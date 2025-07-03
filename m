Return-Path: <stable+bounces-159688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7B5AF79E2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451FF48451A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA722E7BBF;
	Thu,  3 Jul 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PVqzVYF2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1394414;
	Thu,  3 Jul 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555024; cv=none; b=ZcnqKnoaTRXlsN2b1Nwk8RTdpKuI2CZxkdcg934hZYKv+V4uvbnw6k1kvP+G2NOaOCGmBEec3ctelFo37dMdCcs2jL7ALwbOWNEU3a0ll5zGDGTqgzD8E+B5Zeq1zwKuQHch3QmMiqIigky7im8vZB8/ZuYIXVlcW34DOS2yttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555024; c=relaxed/simple;
	bh=4uxrc+POXLDZv6te9l0xL4gXwcAiTugPfOdRU+wBm2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akHlrCn0HNMs4jDTAtLH8BfhX/yfO09ZqsieeQw3VhO9MabEw81PZCIG9O7oWEyA20y9KwHk/hUGmMVRPfMvi4VU7JCdclI3eiOdvm6cxjMPdv1jev4A2nemtgabQF1HIPhf5NVZilhO3qsu//HdcusVJWeY5LSwb7kYpKe4t9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PVqzVYF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B7C4CEEE;
	Thu,  3 Jul 2025 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555024;
	bh=4uxrc+POXLDZv6te9l0xL4gXwcAiTugPfOdRU+wBm2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVqzVYF2f7rCx/xWGRVA7G7sV4wid9c71OgU+MuZ7ni6dGZvfNgx8evs+FO3X6XXp
	 xzJ+/nyMQJZE/zidTK4kl5AlPUZY6hABCTuxN4f2q9Nr+uCHO2IGMi+4yEJTwRUS4z
	 83DqJ2smwtsHZrDOQ/m8GaKOMFKdSQdeK/+kUH0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 152/263] um: ubd: Add missing error check in start_io_thread()
Date: Thu,  3 Jul 2025 16:41:12 +0200
Message-ID: <20250703144010.450337947@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit c55c7a85e02a7bfee20a3ffebdff7cbeb41613ef ]

The subsequent call to os_set_fd_block() overwrites the previous
return value. OR the two return values together to fix it.

Fixes: f88f0bdfc32f ("um: UBD Improvements")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250606124428.148164-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/ubd_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index c5e6545f6fcf6..8e8a8bf518b63 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -41,7 +41,7 @@ int start_io_thread(struct os_helper_thread **td_out, int *fd_out)
 	*fd_out = fds[1];
 
 	err = os_set_fd_block(*fd_out, 0);
-	err = os_set_fd_block(kernel_fd, 0);
+	err |= os_set_fd_block(kernel_fd, 0);
 	if (err) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
-- 
2.39.5




