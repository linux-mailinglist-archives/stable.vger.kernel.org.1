Return-Path: <stable+bounces-5635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C184C80D5BE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D83A2823A0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBA5102B;
	Mon, 11 Dec 2023 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHXQT6cQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08335101A;
	Mon, 11 Dec 2023 18:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4458EC433C8;
	Mon, 11 Dec 2023 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319254;
	bh=e9CVArW8oRLdkhCqpbxClyVN8QO4ie5LUD2PfcfiFUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHXQT6cQk4ZrcUdFJLBQAu3EsPn4lXBrkVC48R68s8eiDhZVXaTnMuRvWl2UGQXGR
	 GB4VoWyjAUNirnMN3Wu69ciDDp+eDgLYIGVz2mov49tUN1+G9WhbEj3jKVD1iPvOoi
	 kIgLBxppE7SgG2WbHm4wQ+l/K95vPeDguuwmUEh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Pakhunov <alexey.pakhunov@spacex.com>,
	Vincent Wong <vincent.wong2@spacex.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/244] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Mon, 11 Dec 2023 19:18:23 +0100
Message-ID: <20231211182046.245888619@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 17dd5efe5f36a96bd78012594fabe21efb01186b ]

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-2-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5c18ad10efc3e..b7acd994a393b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7874,8 +7874,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.42.0




