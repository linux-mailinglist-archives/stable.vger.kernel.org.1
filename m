Return-Path: <stable+bounces-6189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D680D94B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E82816E7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78851C46;
	Mon, 11 Dec 2023 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zEkW0Pgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139C51C2D;
	Mon, 11 Dec 2023 18:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18187C433CA;
	Mon, 11 Dec 2023 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320752;
	bh=zpnrVrjIlNaV92mnEmkjPzUAjYJ1DXTqpGfB1H2Q1U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zEkW0PggL6OgfLg25Y1r/1CcBQZPizvZTvgb7y9C9J38avG/rvGE5JKnuLH2STRmn
	 XD8Eey8LbeK7ctpFGHUYcseHYqKO7jSrVWipGqaqQfCNIYteceySVY+4RFV/a9NwZB
	 JWXhWCetTCgdJnzIiyCcdLbJIpoxI5xMI3p2Hi6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/194] misc: mei: client.c: return negative error code in mei_cl_write
Date: Mon, 11 Dec 2023 19:22:09 +0100
Message-ID: <20231211182042.811714449@linuxfoundation.org>
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

[ Upstream commit 8f06aee8089cf42fd99a20184501bd1347ce61b9 ]

mei_msg_hdr_init() return negative error code, rets should be
'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.

Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20231120095523.178385-1-suhui@nfschina.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 0b2fbe1335a77..77501e392cdeb 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1978,7 +1978,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	mei_hdr = mei_msg_hdr_init(cb);
 	if (IS_ERR(mei_hdr)) {
-		rets = -PTR_ERR(mei_hdr);
+		rets = PTR_ERR(mei_hdr);
 		mei_hdr = NULL;
 		goto err;
 	}
-- 
2.42.0




