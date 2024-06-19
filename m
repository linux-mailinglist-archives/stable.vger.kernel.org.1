Return-Path: <stable+bounces-54061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFB90EC7A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FB7B215F3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16324143C4A;
	Wed, 19 Jun 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8Ru4Heb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE712FB31;
	Wed, 19 Jun 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802476; cv=none; b=BHq/alTId1DMj+cSshvTNMlps8Utq6zgou7222nwWCIi43/y70g3TWzLk5ZJo03dqAHuZvde9JdSHg/G5FvE7FDNc/qGgm/SKyaki5awEvOtrZQUTERocmHs8Buzd3HuGIei9+QZZQOaVl+wlLbo9EqqC//qOJlqzMbvpT4dDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802476; c=relaxed/simple;
	bh=pw5KmInRrC3H7NR5PW3SASx50yl8Wsto54GkO2zxUn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyl9M+R02355fSv0cgEC6Ar1V7urKtiFLc4AquvUoaUAt+Za8j/Iq8u3k19a8miIz2ddNBwLsssR4A61S1GUlIaPJsIkQOVjAC5aIAs8Q0grhCiWurG5ClNJHyKGSifLSKFJQt0Tnsqwqk8+9sDwuURKxhTpgdOf3wCPvBR5lBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8Ru4Heb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E4C2BBFC;
	Wed, 19 Jun 2024 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802476;
	bh=pw5KmInRrC3H7NR5PW3SASx50yl8Wsto54GkO2zxUn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8Ru4HebM5tJh4q7KS7Ut8OvGNHaBLnWJr0AYJbfCq1l1aN6nHsc023Xd1tfJOHrR
	 o9864AjdCivipVAw0jNE1Bp2bG2wY7abEYGer1Pg1rSxcz+fgmDDmGFuthesrATmLK
	 pg9fYUS1bnn5Oc/a0nTdQzb4nup/uUvAZyZrVZhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Beleswar Padhi <b-padhi@ti.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.6 209/267] remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs
Date: Wed, 19 Jun 2024 14:56:00 +0200
Message-ID: <20240619125614.349966315@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
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

From: Beleswar Padhi <b-padhi@ti.com>

commit 3c8a9066d584f5010b6f4ba03bf6b19d28973d52 upstream.

PSC controller has a limitation that it can only power-up the second
core when the first core is in ON state. Power-state for core0 should be
equal to or higher than core1.

Therefore, prevent core1 from powering up before core0 during the start
process from sysfs. Similarly, prevent core0 from shutting down before
core1 has been shut down from sysfs.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240430105307.1190615-3-b-padhi@ti.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -548,7 +548,7 @@ static int k3_r5_rproc_start(struct rpro
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct device *dev = kproc->dev;
-	struct k3_r5_core *core;
+	struct k3_r5_core *core0, *core;
 	u32 boot_addr;
 	int ret;
 
@@ -574,6 +574,15 @@ static int k3_r5_rproc_start(struct rpro
 				goto unroll_core_run;
 		}
 	} else {
+		/* do not allow core 1 to start before core 0 */
+		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
+					 elem);
+		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not start core 1 before core 0\n",
+				__func__);
+			return -EPERM;
+		}
+
 		ret = k3_r5_core_run(core);
 		if (ret)
 			goto put_mbox;
@@ -619,7 +628,8 @@ static int k3_r5_rproc_stop(struct rproc
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct device *dev = kproc->dev;
+	struct k3_r5_core *core1, *core = kproc->core;
 	int ret;
 
 	/* halt all applicable cores */
@@ -632,6 +642,15 @@ static int k3_r5_rproc_stop(struct rproc
 			}
 		}
 	} else {
+		/* do not allow core 0 to stop before core 1 */
+		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
+					elem);
+		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not stop core 0 before core 1\n",
+				__func__);
+			return -EPERM;
+		}
+
 		ret = k3_r5_core_halt(core);
 		if (ret)
 			goto out;



