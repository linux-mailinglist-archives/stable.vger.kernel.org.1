Return-Path: <stable+bounces-53701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7B90E3EB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6182D282881
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874D6F307;
	Wed, 19 Jun 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsFrfNly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3017583
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780466; cv=none; b=MjU0xBneIGvGLFKcWjtetK4YnqvUKRzqCBiK2VdRZFMv1DlweiAFPGcT7+WL5ybu8C/jd53LPyVZAH6923VSA9imu9nUupyKGb28ZlyVZFmDQjdEBBIa7HGYdzidqJj49RK9/nWkWiPF0viFmoCrl2QXp6y72z3G2f1cRSqp+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780466; c=relaxed/simple;
	bh=hdr8ctJwSjga77tLOd2vsGCcdV/FhkFkApqmqqZU+ro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=juC2FJ3z9r/ea8eOBT6Rj9QyfPcjJ6djke1EeItPmSOsxUKRA2+C/nPkynFAuBLXOCzGGU2lL+oitdopWy8VShpI64Ulo2oy5HNXzsJpkS2Q0HNqnS8eHR0INfzOL7FXKAXwt6yrF5zHhAbQURJR0AXq1DQPPw4tLKS79sVd67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsFrfNly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D9C2BBFC;
	Wed, 19 Jun 2024 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780466;
	bh=hdr8ctJwSjga77tLOd2vsGCcdV/FhkFkApqmqqZU+ro=;
	h=Subject:To:Cc:From:Date:From;
	b=QsFrfNlyXnHJslTRwPdq1BkpqzIPIumml4thv9RUMMN0SilRUEfd1mE2fqPvu2Fxk
	 KmJPVhEsbYLpVTZep/C69SxfVVtkO3LkU9fO9qTx/7fkHTpQe3rn7KsoUGqOmWZnPx
	 Q4lUrwgu++XMWcLwcmdFOAfCgkOfmMAVM1RcgUDk=
Subject: FAILED: patch "[PATCH] pmdomain: ti-sci: Fix duplicate PD referrals" failed to apply to 6.1-stable tree
To: tomi.valkeinen@ideasonboard.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 09:01:03 +0200
Message-ID: <2024061902-roving-delirious-57b3@gregkh>
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
git cherry-pick -x 670c900f69645db394efb38934b3344d8804171a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061902-roving-delirious-57b3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

670c900f6964 ("pmdomain: ti-sci: Fix duplicate PD referrals")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 670c900f69645db394efb38934b3344d8804171a Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 15 Apr 2024 19:00:23 +0300
Subject: [PATCH] pmdomain: ti-sci: Fix duplicate PD referrals

When the dts file has multiple referrers to a single PD (e.g.
simple-framebuffer and dss nodes both point to the DSS power-domain) the
ti-sci driver will create two power domains, both with the same ID, and
that will cause problems as one of the power domains will hide the other
one.

Fix this checking if a PD with the ID has already been created, and only
create a PD for new IDs.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240415-ti-sci-pd-v1-1-a0e56b8ad897@ideasonboard.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 9dddf227a3a6..1510d5ddae3d 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -114,6 +114,18 @@ static const struct of_device_id ti_sci_pm_domain_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
 
+static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32 idx)
+{
+	struct ti_sci_pm_domain *pd;
+
+	list_for_each_entry(pd, &pd_provider->pd_list, node) {
+		if (pd->idx == idx)
+			return true;
+	}
+
+	return false;
+}
+
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -149,8 +161,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
-				if (args.args[0] > max_id)
+				if (args.args[0] > max_id) {
 					max_id = args.args[0];
+				} else {
+					if (ti_sci_pm_idx_exists(pd_provider, args.args[0])) {
+						index++;
+						continue;
+					}
+				}
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 				if (!pd) {


