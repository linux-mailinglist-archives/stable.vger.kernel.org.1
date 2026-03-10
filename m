Return-Path: <stable+bounces-224421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHcVJgMEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF224B709
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C1E23257EC5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC552387590;
	Tue, 10 Mar 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C28wl0uG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1612FFDF7;
	Tue, 10 Mar 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142154; cv=none; b=Th3IK4yXhXqxFkVdJJ0IreYSL9DxselNtguuZBVu7PuVrS7JnlrsCz3muRwgqhjQVe5VhAopEvfJsqeYxcReq5d+d/kat4vZqFuXwjPDCl1YWlNIHEazdl8fQr2+dHI3LeY3bfBWUxpyXW4yKe5P7kXHcwKHbvBiqwmOFbOAPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142154; c=relaxed/simple;
	bh=zOgiKWF+4/k5ddCa77UtIEthe9Cn46C6XEXxI5Zvqgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R00BX7iZ+PQTT63DX6i8Nf8qhcsDeDwHStfq7DWyGcIh1MJbIVTgpg0YtWpjZXVH0KQM3GoIBJYvbLOHmAcFD5eOZcfefVRDfIflAw7RmDzBMEA3cYHYqx5VqNpkS0uVbAFJikDALucbhMtHpErOHxd4XLHgO0uDSvzqdZW5La0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C28wl0uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F5C2BC86;
	Tue, 10 Mar 2026 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142154;
	bh=zOgiKWF+4/k5ddCa77UtIEthe9Cn46C6XEXxI5Zvqgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C28wl0uGuJMbLc7woqdqzJDzu6bOahlP7wjxN6unziX+BCzNG3VnLRuVkSpWKEmnW
	 ElOJ/YbJDYT+wNx6CVgZAl+rIStuHb4YUD8AQs9bOchY4nNCOkhOwhi8vGcYaifq99
	 AAGivfcpAPW7fxAUbDZVFTJPzLk+y5RMRGc1uddgQJSG2A8FWrPo3L3S/5uNvlpt55
	 nwo4kZwEMiwYvQq95190xLE7TkVUHCX0PvJ6+I4OzN1h7NwgCc3UH5bwhvDm5XU16Q
	 dArGM+rOxw1y2d+SWtlCZoxkMHuW8fWtm5pjy5hs7dCw//GjyqISe2/hECOD0oDWwj
	 d4Ih7WlVVy1oQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Julian Orth <ju.orth@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 242/314] drm/syncobj: Fix handle <-> fd ioctls with dirty stack
Date: Tue, 10 Mar 2026 07:18:21 -0400
Message-ID: <23368b61ee32d89e5166c48db47ac7f11d650e31.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10CF224B709
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224421-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,amd.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Julian Orth <ju.orth@gmail.com>

[ Upstream commit 2e3649e237237258a08d75afef96648dd2b379f7 ]

Consider the following application:

    #include <fcntl.h>
    #include <string.h>
    #include <drm/drm.h>
    #include <sys/ioctl.h>

    int main(void) {
        int fd = open("/dev/dri/renderD128", O_RDWR);
        struct drm_syncobj_create arg1;
        ioctl(fd, DRM_IOCTL_SYNCOBJ_CREATE, &arg1);
        struct drm_syncobj_handle arg2;
        memset(&arg2, 1, sizeof(arg2)); // simulate dirty stack
        arg2.handle = arg1.handle;
        arg2.flags = 0;
        arg2.fd = 0;
        arg2.pad = 0;
        // arg2.point = 0; // userspace is required to set point to 0
        ioctl(fd, DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD, &arg2);
    }

The last ioctl returns EINVAL because args->point is not 0. However,
userspace developed against older kernel versions is not aware of the
new point field and might therefore not initialize it.

The correct check would be

    if (args->flags & DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE)
        return -EINVAL;

However, there might already be userspace that relies on this not
returning an error as long as point == 0. Therefore use the more lenient
check.

Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Signed-off-by: Julian Orth <ju.orth@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260301-point-v1-1-21fc5fd98614@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_syncobj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index e1b0fa4000cdd..7eb2cdbc574a0 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -900,7 +900,7 @@ drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
 		return drm_syncobj_export_sync_file(file_private, args->handle,
 						    point, &args->fd);
 
-	if (args->point)
+	if (point)
 		return -EINVAL;
 
 	return drm_syncobj_handle_to_fd(file_private, args->handle,
@@ -934,7 +934,7 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
 							  args->handle,
 							  point);
 
-	if (args->point)
+	if (point)
 		return -EINVAL;
 
 	return drm_syncobj_fd_to_handle(file_private, args->fd,
-- 
2.51.0


