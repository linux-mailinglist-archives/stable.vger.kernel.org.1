Return-Path: <stable+bounces-73866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260539706E4
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455081C20B84
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6A1531ED;
	Sun,  8 Sep 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKOaRXDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4D14C5AE
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794951; cv=none; b=YGQsomxT88LsQEWxrEPOsyXkZSDuK4auvW8nX3ETXBTCuFsP6r6Nl6eGnU6GsCtZ0ldfpOTxXY3Pzcov/DJMzXCfLkQ0PSrXgN4X3fUCJVmVM2wLF7qOit2sKGfUNuGLWX/GYIxP+nowQ7VmTvNmOAJ/eQStqqSEUPFd0tTmvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794951; c=relaxed/simple;
	bh=OXXbx5aKaQpg+1vreFr7ubge5em13PdBntkG9iCXvcs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kVIWrb3zpnMPzhavumOwZEw6eh2WWZxITSoW/SA1nI//MY9Q3IPeYRSiuSSUqcqM5iUztY8SnUdY/V76E5oyyix1YjSPNfv073jiY1csvK9u78fdUslVnHodzq/qfFEOs8Yg8gVlswdovkYSoWD7dZs19ffAnATdPDPgThDP30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKOaRXDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EB0C4CEC3;
	Sun,  8 Sep 2024 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794951;
	bh=OXXbx5aKaQpg+1vreFr7ubge5em13PdBntkG9iCXvcs=;
	h=Subject:To:Cc:From:Date:From;
	b=VKOaRXDTqExzLJWjuGUSUYAUP3WopGWp8cPmpLWcXXeRQTAOOUarDz0g7At6VDTem
	 sNEkdAq/5AnEIcOdBN3jHSKoqgF73bBgEaB7/JPMBnnuwPvIIvHsqkhQwRrVhrpg68
	 tsgt4D4AE+GPsjttWqAJEWjvGcSl1cyAvddcF+fE=
Subject: FAILED: patch "[PATCH] OPP: Fix support for required OPPs for multiple PM domains" failed to apply to 6.10-stable tree
To: ulf.hansson@linaro.org,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:29:09 +0200
Message-ID: <2024090809-portion-riptide-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9ec87c5957ea9bf68d36f5e098605b585b2571e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090809-portion-riptide-f7d9@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

9ec87c5957ea ("OPP: Fix support for required OPPs for multiple PM domains")
0d865221c8b1 ("OPP: Drop a redundant in-parameter to _set_opp_level()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ec87c5957ea9bf68d36f5e098605b585b2571e4 Mon Sep 17 00:00:00 2001
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Aug 2024 00:45:38 +0200
Subject: [PATCH] OPP: Fix support for required OPPs for multiple PM domains

It has turned out that having _set_required_opps() to recursively call
dev_pm_opp_set_opp() to set the required OPPs, doesn't really work as well
as we expected.

More precisely, at each recursive call to dev_pm_opp_set_opp() we are
changing an OPP for a required_dev that belongs to a required-OPP table.
The problem with this, is that we may have several devices sharing the same
required-OPP table, which leads to an incorrect behaviour in regards to
aggregating the per device votes.

To fix the problem for a required-OPP table belonging to a PM domain, which
is the only existing usecase for now, let's simply replace the call to
dev_pm_opp_set_opp() in _set_required_opps() by a call to _set_opp_level().

Moving forward we may potentially need to add support for other types of
required-OPP tables. In this case, the aggregation needs to be thought of.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20240822224547.385095-2-ulf.hansson@linaro.org

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f4598246a87..494f8860220d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,27 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
+{
+	unsigned int level = 0;
+	int ret = 0;
+
+	if (opp) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			return 0;
+
+		level = opp->level;
+	}
+
+	/* Request a new performance state through the device's PM domain. */
+	ret = dev_pm_domain_set_performance_state(dev, level);
+	if (ret)
+		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+			ret);
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
@@ -1091,7 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,27 +1123,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
-{
-	unsigned int level = 0;
-	int ret = 0;
-
-	if (opp) {
-		if (opp->level == OPP_LEVEL_UNSET)
-			return 0;
-
-		level = opp->level;
-	}
-
-	/* Request a new performance state through the device's PM domain. */
-	ret = dev_pm_domain_set_performance_state(dev, level);
-	if (ret)
-		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
-			ret);
-
-	return ret;
-}
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
@@ -2457,18 +2457,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			}
 		}
 
-		/*
-		 * Add the virtual genpd device as a user of the OPP table, so
-		 * we can call dev_pm_opp_set_opp() on it directly.
-		 *
-		 * This will be automatically removed when the OPP table is
-		 * removed, don't need to handle that here.
-		 */
-		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
 		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;


