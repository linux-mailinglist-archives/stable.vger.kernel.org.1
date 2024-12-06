Return-Path: <stable+bounces-99149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72F9E706B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D241281A6C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEA149E0E;
	Fri,  6 Dec 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdUw+S1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8F1494D9;
	Fri,  6 Dec 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496168; cv=none; b=B2n0WrH2/nP3D7ClDxyp14gLcrHLUwe/5CVYPmHGGhtj7yqHHaJp4Hb7/FGRybjuO0ialDjeeJybam5L8b7r1z0hZL8xeaCws+bvLTu5FcUMsFgRabMbEI2fm8fvqP3+KpBqthZtDRVhPTyIGEJZruNO37TNeR3DoJkfnlveesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496168; c=relaxed/simple;
	bh=Ay4uIWNQfO2fgim1Pd9/naKjqAx1hYsDLPxYgixskqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+AsOSTMhu3e2Ji5c++iciLcDKw5t3rQTLY07fjNPC2NVJYPFzoQGppnm0LNExHdWPu7Xb7lXbJnBii9s+X0a7fzxHvAXsv7U+/yDrkaZMruBlxAsP0tfH35UFfxh+w2STAyX4wSDF+3FhXrwFTMpFQdEOmD7Qfe6p2kdoATBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdUw+S1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B07C4CED1;
	Fri,  6 Dec 2024 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496167;
	bh=Ay4uIWNQfO2fgim1Pd9/naKjqAx1hYsDLPxYgixskqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdUw+S1jTFcWKzL79DKeamOmgCSJ18uQBm2HBL/Trdb8WWikXqK6VinhqHFdWQW9a
	 wOBlIsZ3ZwaxC9JzaqZT94NgpKB+Bi6UhgrdnGPTo4CCeORoVWkLXmxQ6c4oexU38E
	 RQ/AlRVdrbIvcIavzLUaKpRpqUaiLWlfB3rOVyu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrick Donnelly <pdonnell@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12 071/146] ceph: extract entity name from device id
Date: Fri,  6 Dec 2024 15:36:42 +0100
Message-ID: <20241206143530.399276047@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
References: <20241206143527.654980698@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -285,7 +285,9 @@ static int ceph_parse_new_source(const c
 	size_t len;
 	struct ceph_fsid fsid;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
+	struct ceph_options *opts = pctx->copts;
 	struct ceph_mount_options *fsopt = pctx->opts;
+	const char *name_start = dev_name;
 	char *fsid_start, *fs_name_start;
 
 	if (*dev_name_end != '=') {
@@ -296,8 +298,14 @@ static int ceph_parse_new_source(const c
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



