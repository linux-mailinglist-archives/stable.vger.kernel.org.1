Return-Path: <stable+bounces-99869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8890C9E73DE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABB416FC9A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2BD152160;
	Fri,  6 Dec 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ao4m3P6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED21465AB;
	Fri,  6 Dec 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498626; cv=none; b=btWT5b15qYTSE5MHPdXmvRHNke1BmqrFLVS2WSmGhFdUyeAmOiRJEW/TDz3yQYFCcxRhee6f5VbMEfpVxcs8eKasdAc3fCIkj3YUjpXVcoR4uLas+wep6F44bAc5teirMHDfIbOkt/Xs0J5pQtfrXWbFPnpGA7NWILCnuWxEXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498626; c=relaxed/simple;
	bh=lr3yI/mnoki3m2FPWb8glZkKW/KdJnSrR6PXyXcURSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTQjABcKLHY/6q1xO/Ukc7VOS5HqoJE4fr6Iv77iXkt9s1XoHac0uG7vOgx6cuLzppoFcsVaZO+ZEzst94rpEC7yvsgS8OuCrQzDCqH2lw+yW8CQdtVCwDCbkoAa11VQnXBl1XI/AQsem2YA9AMfVGbwau/gbKZNtgytZTp6M18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ao4m3P6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BB7C4CED1;
	Fri,  6 Dec 2024 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498626;
	bh=lr3yI/mnoki3m2FPWb8glZkKW/KdJnSrR6PXyXcURSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ao4m3P6pHGIWaodfC2h0vshpnZfQbjKvECzKIfjsWgu0ZT7/filE9OYknBcDCgb9l
	 Nnb58FugyJ3xWkKWU/l2gpp/cZ7Uxy+Ri9jv51h20cEfdp4pUd1SKHoJNdZkHLzvRE
	 kc/PwxzsaqgnF8oXj6zFoQECymYxTITZV1gyHrH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrick Donnelly <pdonnell@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.6 640/676] ceph: extract entity name from device id
Date: Fri,  6 Dec 2024 15:37:39 +0100
Message-ID: <20241206143718.370261170@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Patrick Donnelly <pdonnell@redhat.com>

commit 955710afcb3bb63e21e186451ed5eba85fa14d0b upstream.

Previously, the "name" in the new device syntax "<name>@<fsid>.<fsname>"
was ignored because (presumably) tests were done using mount.ceph which
also passed the entity name using "-o name=foo". If mounting is done
without the mount.ceph helper, the new device id syntax fails to set
the name properly.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/68516
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -281,7 +281,9 @@ static int ceph_parse_new_source(const c
 	size_t len;
 	struct ceph_fsid fsid;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
+	struct ceph_options *opts = pctx->copts;
 	struct ceph_mount_options *fsopt = pctx->opts;
+	const char *name_start = dev_name;
 	char *fsid_start, *fs_name_start;
 
 	if (*dev_name_end != '=') {
@@ -292,8 +294,14 @@ static int ceph_parse_new_source(const c
 	fsid_start = strchr(dev_name, '@');
 	if (!fsid_start)
 		return invalfc(fc, "missing cluster fsid");
-	++fsid_start; /* start of cluster fsid */
+	len = fsid_start - name_start;
+	kfree(opts->name);
+	opts->name = kstrndup(name_start, len, GFP_KERNEL);
+	if (!opts->name)
+		return -ENOMEM;
+	dout("using %s entity name", opts->name);
 
+	++fsid_start; /* start of cluster fsid */
 	fs_name_start = strchr(fsid_start, '.');
 	if (!fs_name_start)
 		return invalfc(fc, "missing file system name");



