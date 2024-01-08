Return-Path: <stable+bounces-10024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8082711B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6541C229F1
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EA46BBD;
	Mon,  8 Jan 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hee8Q+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA024C629;
	Mon,  8 Jan 2024 14:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05EBC433C7;
	Mon,  8 Jan 2024 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704723734;
	bh=kQ+LhR7iZZAnXsQPFnXuHuZbf/2NiSo9eD/UrzJsCmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0hee8Q+9O/mK+WZdjhluVyaeIhi8BBgEtkqbV0gkl9+dhhmkPyUq92ddKgtZfmbR+
	 spogLttCVJAmWlzl4BL23R0Y1H8klA47nfZh52R/4q12JlyapoWEd1EBVeRBf9v91M
	 0u2+pvJoHgm+MDzVzWUwzGhQZTtWkKYIpqbUbGkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Hangyu Hua <hbh25y@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 2/7] net: sched: em_text: fix possible memory leak in em_text_destroy()
Date: Mon,  8 Jan 2024 15:21:56 +0100
Message-ID: <20240108141854.235650139@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108141854.158274814@linuxfoundation.org>
References: <20240108141854.158274814@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit 8fcb0382af6f1ef50936f1be05b8149eb2f88496 ]

m->data needs to be freed when em_text_destroy is called.

Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/em_text.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 73e2ed576ceb3..cbf44783024f3 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -101,8 +101,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
 static void em_text_destroy(struct tcf_ematch *m)
 {
-	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
+	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
 		textsearch_destroy(EM_TEXT_PRIV(m)->config);
+		kfree(EM_TEXT_PRIV(m));
+	}
 }
 
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
-- 
2.43.0




