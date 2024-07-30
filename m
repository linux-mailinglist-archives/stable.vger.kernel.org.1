Return-Path: <stable+bounces-62752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C3940F4C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B87B26ADF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD13198852;
	Tue, 30 Jul 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVx2ZYI4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC5197A89
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335203; cv=none; b=lli+ersltwbXHMkfP6teLSwDzrpyXB141JJlJ0SZbCtjQyT0BBiaOwebuj3ER8pe00tUjl2euF3MgdZPpb6twNB78obn2yYaVHevVyupA5xIWJ9++sEyZDPY88QhYnprkjkzkb6d3yQ5y3GpRTuPy0YJyJYjJh5wNqydcSd94Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335203; c=relaxed/simple;
	bh=HctCwVf/uYnCmlND87/z/JNhExYyoaPmTWKXRNLZv4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mJOVDxNo+4dZZtUybItL2q2ne8BhBiVPoJ1dwNGBJXuNn6hda4SVlob4AFc9TuY3MDJXZ6yghmUNIRIeH9EocChU+B5I0yDU7eoeHbLuKB1FW8v5o/Lnbk2CQmajjBw0b8jn6ZPL2W2zOx1pFk1TR73fX+JfegIuGIuIDjkUw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVx2ZYI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B85C32782;
	Tue, 30 Jul 2024 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335202;
	bh=HctCwVf/uYnCmlND87/z/JNhExYyoaPmTWKXRNLZv4g=;
	h=Subject:To:Cc:From:Date:From;
	b=hVx2ZYI4XKrOVCQNAO8m5NuAViqtDdekOLAHWQr7PY8Nx2yeWHaO3dQs8UFgdo/dC
	 uB/MF18p/mzJ7DYuQtZHKea6lTyKXl+PpgqfWknJctfGbayomN7be2okRLJ9VN7lrv
	 MjiamGs8quUdI/+mbEH9KT94S3J1Sk8ixEQz4jiU=
Subject: FAILED: patch "[PATCH] remoteproc: imx_rproc: Skip over memory region when node" failed to apply to 4.19-stable tree
To: amishin@t-argos.ru,mathieu.poirier@linaro.org,peng.fan@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:26:36 +0200
Message-ID: <2024073036-capable-slander-fe44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2fa26ca8b786888673689ccc9da6094150939982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073036-capable-slander-fe44@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2fa26ca8b786 ("remoteproc: imx_rproc: Skip over memory region when node value is NULL")
afe670e23af9 ("remoteproc: imx_rproc: Fix ignoring mapping vdev regions")
8f2d8961640f ("remoteproc: imx_rproc: ignore mapping vdev regions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fa26ca8b786888673689ccc9da6094150939982 Mon Sep 17 00:00:00 2001
From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Thu, 6 Jun 2024 10:52:04 +0300
Subject: [PATCH] remoteproc: imx_rproc: Skip over memory region when node
 value is NULL

In imx_rproc_addr_init() "nph = of_count_phandle_with_args()" just counts
number of phandles. But phandles may be empty. So of_parse_phandle() in
the parsing loop (0 < a < nph) may return NULL which is later dereferenced.
Adjust this issue by adding NULL-return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240606075204.12354-1-amishin@t-argos.ru
[Fixed title to fit within the prescribed 70-75 charcters]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 5a3fb902acc9..39eacd90af14 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -726,6 +726,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		struct resource res;
 
 		node = of_parse_phandle(np, "memory-region", a);
+		if (!node)
+			continue;
 		/* Not map vdevbuffer, vdevring region */
 		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
 			of_node_put(node);


