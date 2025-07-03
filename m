Return-Path: <stable+bounces-160025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81277AF7C17
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D403F1CA3EB6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995F219E8C;
	Thu,  3 Jul 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBhiFw+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505122259F;
	Thu,  3 Jul 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556129; cv=none; b=WjIHhi4y5URsXBuTJh0My4e91gAtWupLH57EDo53BabZ+NqZk6RXC4Bsi69Xxw8SYLKsbud72RlUZ/NvwlXGMm2vZxluWk5zCUzl6y8648iOCwblIXq2kiPHDSvwWbbDmg0tDmu8mJLSJzxVRU8DF7HKDjvwXfJxc4+6Ktc8gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556129; c=relaxed/simple;
	bh=p+MHD1K46OhK/VNfyZr1oZlYRrkkUZHTlyZ8IkqxUgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNC+wlGlQOqfx5syEBGA3cB79DPSPpgIrT5yNLwmdBPVovOBfolhKfYjb5Z4eB1YknIwuYZ+3mAura1YqWRgNYaXlqZi5FTUu9bGUqGsrzhfL5vAqkJsvcaOp2iHctldLKBrqP+RWXMJ0Zanv4VIfRG1vUAOSEwrFQuwCT83Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBhiFw+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B830DC4CEED;
	Thu,  3 Jul 2025 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556129;
	bh=p+MHD1K46OhK/VNfyZr1oZlYRrkkUZHTlyZ8IkqxUgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBhiFw+q0KbElNxVeQzcaZjVXnLE/CmKn5rsFQeqx4Fos00L0O8/fUsX4vG+joBt7
	 aYDCX+soL7ITQtXTSqoHE3d+jLzlDRYwd1bUdNhM3mQ9AcsQjODfPj4QkahZZmmtrt
	 dgvDaCpVSzC1CoL+pu73YG6xf1oIrZnY4mdu1hP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/132] um: ubd: Add missing error check in start_io_thread()
Date: Thu,  3 Jul 2025 16:42:52 +0200
Message-ID: <20250703143942.662480648@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index a1afe414ce481..fb5b1e7c133d8 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -41,7 +41,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 	*fd_out = fds[1];
 
 	err = os_set_fd_block(*fd_out, 0);
-	err = os_set_fd_block(kernel_fd, 0);
+	err |= os_set_fd_block(kernel_fd, 0);
 	if (err) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
-- 
2.39.5




