Return-Path: <stable+bounces-220465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLHPEfM3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D91C63AA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D874332CD868
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC63BED26;
	Sat, 28 Feb 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1IDYMUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BA3BED1C;
	Sat, 28 Feb 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300352; cv=none; b=MI3y5zXTFBsNDUPzoUI9OwNmumsLGfD36rxnA5C9F1TRkM+V6JSjc90ujjK2nwtgzPaYlb6l2f5LSf0D8BUaFALuRf3opJM1QIs/PGGxnffHN1BfIHf6U7BgQN6NiA8Dii1Xey1qv5SUs0Ck3PXskUwiB2B2ou/sFH2xfZ+AjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300352; c=relaxed/simple;
	bh=dB6FPpCoDZ1xiwuejfr7S5mzPXo8oS/VjLqIRF8hHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/sDAr2oajDaMuAfOsVkQpPS0k5T8kbCf4ITahtDzAzw91cYQo8SqqxQr1ztrXIKWeM11nhbIcaaKpAUkGqMbLMFFAK8RDqh2dDhG1dE6L+DknWspC3r5bET9qokVHy/D3O+ocoSuJnVOp6hZKX29y6kn4k0GLBCceNPRgfwKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1IDYMUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21CDC116D0;
	Sat, 28 Feb 2026 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300352;
	bh=dB6FPpCoDZ1xiwuejfr7S5mzPXo8oS/VjLqIRF8hHqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1IDYMUYnUsIRPtUqceY9m6cN5zPmxaAxVtG44SdC9Ix6egeLabM/rSQauPEIl1Ub
	 hrlR5MXYWx5/LDkYYSP01K0Ms1HRo3BI4FoeKnInJVxsF0ePxS7kU5Gru803qHkfQ1
	 yzIeoPKUdH+C0JoE34oUGQZBZvAGpiz31Bu2c3nKQJzA2vRGcWVK/HW3ay4hxFOyDu
	 39DcGV6DHfPRg9iayFby5LoolwufsewOn3KhMJyCWjV80oFkzOh4DtHFATwoinQKyi
	 AzEpE5a+PiI8dLLwIX+LldDz5Hgj8O0wcMIZYDgOByR8DvGQFRjaDZsY2H3s2Kr6m4
	 LAHRfLx0YZ9tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Day <me@samcday.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 386/844] usb: gadget: f_fs: Fix ioctl error handling
Date: Sat, 28 Feb 2026 12:24:59 -0500
Message-ID: <20260228173244.1509663-387-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220465-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D14D91C63AA
X-Rspamd-Action: no action

From: Sam Day <me@samcday.com>

[ Upstream commit 8e4c1d06183c25022f6b0002a5cab84979ca6337 ]

When ffs_epfile_ioctl handles FUNCTIONFS_DMABUF_* ioctls, it's currently
falling through when copy_from_user fails.

However, this fallthrough isn't being checked properly, so the handler
continues executing further than it should. It then tries the secondary
dispatch where it ultimately gives up and returns -ENOTTY.

The end result is invalid ioctl invocations will yield a -ENOTTY rather
than an -EFAULT.

It's a common pattern elsewhere in the kernel code to directly return
-EFAULT when copy_from_user fails. So we update ffs_epfile_ioctl to do
the same and fix this issue.

Signed-off-by: Sam Day <me@samcday.com>
Link: https://patch.msgid.link/20260108-ffs-dmabuf-ioctl-fix-v1-1-e51633891a81@samcday.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 928f51fddc64e..e75d5d8b5ac91 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1744,10 +1744,8 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	{
 		int fd;
 
-		if (copy_from_user(&fd, (void __user *)value, sizeof(fd))) {
-			ret = -EFAULT;
-			break;
-		}
+		if (copy_from_user(&fd, (void __user *)value, sizeof(fd)))
+			return -EFAULT;
 
 		return ffs_dmabuf_attach(file, fd);
 	}
@@ -1755,10 +1753,8 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	{
 		int fd;
 
-		if (copy_from_user(&fd, (void __user *)value, sizeof(fd))) {
-			ret = -EFAULT;
-			break;
-		}
+		if (copy_from_user(&fd, (void __user *)value, sizeof(fd)))
+			return -EFAULT;
 
 		return ffs_dmabuf_detach(file, fd);
 	}
@@ -1766,10 +1762,8 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	{
 		struct usb_ffs_dmabuf_transfer_req req;
 
-		if (copy_from_user(&req, (void __user *)value, sizeof(req))) {
-			ret = -EFAULT;
-			break;
-		}
+		if (copy_from_user(&req, (void __user *)value, sizeof(req)))
+			return -EFAULT;
 
 		return ffs_dmabuf_transfer(file, &req);
 	}
-- 
2.51.0


