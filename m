Return-Path: <stable+bounces-62751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A328F940F49
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF521F24170
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43686198822;
	Tue, 30 Jul 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6csbCav"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F9196DA1
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335200; cv=none; b=GLMrX3l5LoZ8KtXaAWGPCsYbIY79QDNK3sDSN5SoPq8TN+pZGRNpRIvuZRPGcFB0U3TkQP7bs65t7tlTfxbuxUhPDgig6b5whqGkm1tfWYRhS5gObDyUZ3POBQDy0FW2dYAxdCyRjqMA+k9Zaq3Vp4Fi2xnKMYN2uKiPQBbPP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335200; c=relaxed/simple;
	bh=bi9pRXdEc1+pG+5uSDCffrKdGkHEDfkOinKoGCtrAZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P117YvTe5MyJN2X1l559ho65bTKoOpOiojyFZuKerDPVrDdcCmxqRQmtuDH7M1+s2yS7ZRmd2F8UR21lUa1/SrNjAGc2ChCgVPHfe8cQMSEzJtywjUzFD81j2MWrcLUtC0vLioNOSXORgIkMZncP9L66gB+o0hUeRWVQlz8ZYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O6csbCav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5C4C32782;
	Tue, 30 Jul 2024 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335199;
	bh=bi9pRXdEc1+pG+5uSDCffrKdGkHEDfkOinKoGCtrAZg=;
	h=Subject:To:Cc:From:Date:From;
	b=O6csbCavQlGCwjAht5Au+AQI4C7zGQn2Qm6K0KJ5VApTJaHaRgQvJAFmptDGza9xq
	 7WvobTajIQicVjhnAGbIx3+cG0zWrYYAWotXFUutqA4YW0BIMA669IEP9rAnEqNfMf
	 wY9dOpweUdN6OOkhypIYPeF6QrJcQRfcuWAfDBF4=
Subject: FAILED: patch "[PATCH] remoteproc: imx_rproc: Skip over memory region when node" failed to apply to 5.4-stable tree
To: amishin@t-argos.ru,mathieu.poirier@linaro.org,peng.fan@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:26:33 +0200
Message-ID: <2024073033-santa-unscrew-ac70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2fa26ca8b786888673689ccc9da6094150939982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073033-santa-unscrew-ac70@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


