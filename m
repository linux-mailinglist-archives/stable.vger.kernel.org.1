Return-Path: <stable+bounces-6159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5546E80D91C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D7D1F21AB0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19A51C2D;
	Mon, 11 Dec 2023 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GkpUxU1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9E5102A;
	Mon, 11 Dec 2023 18:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C00C433C8;
	Mon, 11 Dec 2023 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320670;
	bh=ZuHIe+Y9nKGikK4NklBgJYjjXzx5Eg+cu5TBIBDCM04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkpUxU1KKwwvgBzebyRiQC02P3gFGgLe3EEizFlGyq6arP4fn06pSU3r9Jh1gDv4N
	 okMEDI+CH1n7ZPlQvlDqyF5OMMLzsCh8h+pbAEJq1jCU/TMFY4BU4br+GuFfx7gDj+
	 MWsqpeo9VEPBMfeVze0S4aFNclPZSeNt1T2BFQFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/194] misc: mei: client.c: fix problem of return -EOVERFLOW in mei_cl_write
Date: Mon, 11 Dec 2023 19:22:10 +0100
Message-ID: <20231211182042.851781704@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit ee6236027218f8531916f1c5caa5dc330379f287 ]

Clang static analyzer complains that value stored to 'rets' is never
read.Let 'buf_len = -EOVERFLOW' to make sure we can return '-EOVERFLOW'.

Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw modules")
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20231120095523.178385-2-suhui@nfschina.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 77501e392cdeb..c70c89209fe55 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -2002,7 +2002,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
-		rets = -EOVERFLOW;
+		buf_len = -EOVERFLOW;
 		goto out;
 	}
 
-- 
2.42.0




