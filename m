Return-Path: <stable+bounces-62750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E8940F4A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6630EB26A93
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D2197A90;
	Tue, 30 Jul 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfRRAwDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0E196DA1
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335196; cv=none; b=sbETSZsTkgJDpYC7VpeZBTmoBRknYSzAqSmIrRhL7A+s40Ms/5c+kIV80VgHv9novphduTUfbMEjyd76SEi4o9yXXr8VQ0jPwE5TJIkhxrlUIOXCNLLt18MSzaHrvgUcnfRs9ruK7hqlusn//sfb8mfYXFuKDe9vNPFusiaoPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335196; c=relaxed/simple;
	bh=mt9vOe5DMdcCvYteITSIz2wMnVXOxQ1KlHm/jO0Uo3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S5bCk4p5l6BrJzNvfoIAG3ANW3mJHrula08BwyP+jWJEVnjs+zoGt+dO0E7kkrYRZG7yA2rQqAoZMemPGo0aprPU9rGjvq4a0fKKUCP2H35mqBVKL7aei2XXEmW/typo7/DmkMfuL6mqvkpep8ByduIxOEdkuoQPUl0n+ZSVibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfRRAwDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FBBC4AF0B;
	Tue, 30 Jul 2024 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335196;
	bh=mt9vOe5DMdcCvYteITSIz2wMnVXOxQ1KlHm/jO0Uo3o=;
	h=Subject:To:Cc:From:Date:From;
	b=WfRRAwDmpuRyK4r/zp21UrOLONlgwbCrLbuCLBWyH1sp38xAetT+mKV2gcjrWL6iD
	 ej0KulqPM2PH0ys29XCxZ4Mm5gcLZk5ThPWL4LnAwHt9jr6FL6YMmZH+zVBS7YLcbV
	 yk6vD/Rr/pfA11gN9tfBpf9Yca7Mwhs1cNB5mSP4=
Subject: FAILED: patch "[PATCH] remoteproc: imx_rproc: Skip over memory region when node" failed to apply to 5.10-stable tree
To: amishin@t-argos.ru,mathieu.poirier@linaro.org,peng.fan@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:26:33 +0200
Message-ID: <2024073032-attentive-tamale-4489@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2fa26ca8b786888673689ccc9da6094150939982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073032-attentive-tamale-4489@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


