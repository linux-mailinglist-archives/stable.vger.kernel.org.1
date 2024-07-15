Return-Path: <stable+bounces-59328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80C931311
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA021F23C9E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE4188CD4;
	Mon, 15 Jul 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUsARzA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B31850B3
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042884; cv=none; b=GAPWafuRf4Q/zgeQdlAvxhD5WhSmlruY2EFZcpyRquEksw8p3HpZjnXcsCxR9WzMWUKcI/tdf1t1pZYut8PC/0Wf5yS610fkW+xdxPGNySOMNETcq/lYNdtwX5Rl8Pezg6HboGt+jOfDqw7eVH8l0/++j6jbTqxX8VtxyEPKOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042884; c=relaxed/simple;
	bh=yonukFrKB+VdVyrdY5zn6mf6Myp7WqqeKMHuFOa78E0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s605AvX0jJQwhHjKt+awxhbx6yHdU2mTxazXoaRRcmvifuqsbubdlbXy+PMXvcsLu/KfU3Rr3QeoeSsRlJ3A1WEDbQQAqXRWsDxWzvfKuX0V3hhHksH1spD4Bl3kZ1PUkv3Wa7oZqVNyG7T6+yEznJ9b+8kMaa7aiLvkXfUmrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUsARzA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9819C4AF0A;
	Mon, 15 Jul 2024 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721042884;
	bh=yonukFrKB+VdVyrdY5zn6mf6Myp7WqqeKMHuFOa78E0=;
	h=Subject:To:Cc:From:Date:From;
	b=eUsARzA7YiddfOdFDJVKxAROHDhPnnkc8MTuF2hWVSho1IIP3BpQa7d4wbNOVRcxC
	 +hRoa8t1ChFiuidjvNnINj5UB2NWp4DVxL+0lzSYk1tFCqiEKqlyjhEXvMfWLRwa1t
	 +ba3/ZHCIDkf6EQaNMFeRQn8i2m8fnnb35c/wZQA=
Subject: FAILED: patch "[PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power" failed to apply to 6.1-stable tree
To: quic_tdas@quicinc.com,andersson@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:28:01 +0200
Message-ID: <2024071501-tasty-grandpa-318b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ddab91f4b2de5c5b46e312a90107d9353087d8ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071501-tasty-grandpa-318b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ddab91f4b2de ("pmdomain: qcom: rpmhpd: Skip retention level for Power Domains")
e2ad626f8f40 ("pmdomain: Rename the genpd subsystem to pmdomain")
b683a3620748 ("genpd: imx: relocate scu-pd under genpd")
fe38a2d570df ("MAINTAINERS: adjust file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER")
7ed363cd8d0a ("genpd: move owl-sps-helper.c from drivers/soc")
b43f11e5b453 ("ARM: ux500: Move power-domain driver to the genpd dir")
444ffc820d90 ("soc: xilinx: Move power-domain driver to the genpd dir")
2449efaaf913 ("soc: ti: Mover power-domain drivers to the genpd dir")
27e0fef61ffd ("soc: tegra: Move powergate-bpmp driver to the genpd dir")
fd697e216040 ("soc: sunxi: Move power-domain driver to the genpd dir")
f3fb16291f48 ("soc: starfive: Move the power-domain driver to the genpd dir")
4419644bfc7f ("soc: samsung: Move power-domain driver to the genpd dir")
a8fcd3da73de ("soc: rockchip: Mover power-domain driver to the genpd dir")
86341a84495c ("soc: renesas: Move power-domain drivers to the genpd dir")
84e9c58c2166 ("soc: qcom: Move power-domain drivers to the genpd dir")
fcd9632122d7 ("soc: mediatek: Move power-domain drivers to the genpd dir")
e5300b2c3fe0 ("soc: imx: Move power-domain drivers to the genpd dir")
aded002384c1 ("soc: bcm: Move power-domain drivers to the genpd dir")
869b9dd3339a ("soc: apple: Move power-domain driver to the genpd dir")
22f86fab644b ("soc: amlogic: Move power-domain drivers to the genpd dir")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddab91f4b2de5c5b46e312a90107d9353087d8ea Mon Sep 17 00:00:00 2001
From: Taniya Das <quic_tdas@quicinc.com>
Date: Tue, 25 Jun 2024 10:03:11 +0530
Subject: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains

In the cases where the power domain connected to logics is allowed to
transition from a level(L)-->power collapse(0)-->retention(1) or
vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
logic to lose the configurations. The ARC does not support retention
to collapse transition on MxC rails.

The targets from SM8450 onwards the PLL logics of clock controllers are
connected to MxC rails and the recommended configurations are carried
out during the clock controller probes. The MxC transition as mentioned
above should be skipped to ensure the PLL settings are intact across
clock controller power on & off.

On older targets that do not split MX into MxA and MxC does not collapse
the logic and it is parked always at RETENTION, thus this issue is never
observed on those targets.

Cc: stable@vger.kernel.org # v5.17
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Link: https://lore.kernel.org/r/20240625-avoid_mxc_retention-v2-1-af9c2f549a5f@quicinc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index de9121ef4216..d2cb4271a1ca 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -40,6 +40,7 @@
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
  * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -56,6 +57,7 @@ struct rpmhpd {
 	const char	*res_name;
 	u32		addr;
 	bool		state_synced;
+	bool            skip_retention_level;
 };
 
 struct rpmhpd_desc {
@@ -173,6 +175,7 @@ static struct rpmhpd mxc = {
 	.pd = { .name = "mxc", },
 	.peer = &mxc_ao,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd mxc_ao = {
@@ -180,6 +183,7 @@ static struct rpmhpd mxc_ao = {
 	.active_only = true,
 	.peer = &mxc,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd nsp = {
@@ -819,6 +823,9 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 		return -EINVAL;
 
 	for (i = 0; i < rpmhpd->level_count; i++) {
+		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+			continue;
+
 		rpmhpd->level[i] = buf[i];
 
 		/* Remember the first corner with non-zero level */


