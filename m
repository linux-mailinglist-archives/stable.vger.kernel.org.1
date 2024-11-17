Return-Path: <stable+bounces-93730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E090F9D060D
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103C9B220C2
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F181DBB31;
	Sun, 17 Nov 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usOH2wn9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706584A3E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877648; cv=none; b=U0Vvtm4ciS8BpuO0YAcZQlEYJu5gECHjecQCkytveZxtz72ygctgqt98T2VlClZoBK0TCxFL+RI9/pTCZ/P+Gzh/3G13rHhXt43+K4emjCRc5NGt+V4Xz9tQkBFnA+1hbk3eVxKFGqwFyKy+d7HEed/eLYpxxwlSAA4W4DnZSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877648; c=relaxed/simple;
	bh=dPE/6UDMMNTud90mRB8SxwxkKNDGqNVlNy5eq4COdCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oJnHuwxLrXzrKOJnMEKkVtnFqnfQkiE/0bSXP4GfuPGsVmWeGT/k52xAcx4wxL13cWrx3o4h5ZjmQkl+A/EEOmnzR96qKyvknkCVkZpvZyZydMwDEx0t/4O5UMGrsHVkFYiXSTdY2nFJtHi8GuWLkTjnDVcRJ20F+z7ouKbTwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usOH2wn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18123C4CECD;
	Sun, 17 Nov 2024 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731877645;
	bh=dPE/6UDMMNTud90mRB8SxwxkKNDGqNVlNy5eq4COdCc=;
	h=Subject:To:Cc:From:Date:From;
	b=usOH2wn9IJGz0m6qGFsFafnUJC2ma/1yn6lY2DN8B8etrPDcUJh1muGUT55zhbPVq
	 hIKNI2neelKzMmXZ7+VShXlPQKRgb8UQ/GFwK7MK5C9qZ4+LXvVP02vW6aqvZtqCdZ
	 DdDqQsdHArG/5wwnMO0mX9ajSEkheff03tVrvP4o=
Subject: FAILED: patch "[PATCH] pmdomain: imx93-blk-ctrl: correct remove path" failed to apply to 6.1-stable tree
To: peng.fan@nxp.com,ulf.hansson@linaro.org,wahrenst@gmx.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 22:07:00 +0100
Message-ID: <2024111700-overhang-copied-323b@gregkh>
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
git cherry-pick -x f7c7c5aa556378a2c8da72c1f7f238b6648f95fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111700-overhang-copied-323b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7c7c5aa556378a2c8da72c1f7f238b6648f95fb Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 1 Nov 2024 18:12:51 +0800
Subject: [PATCH] pmdomain: imx93-blk-ctrl: correct remove path

The check condition should be 'i < bc->onecell_data.num_domains', not
'bc->onecell_data.num_domains' which will make the look never finish
and cause kernel panic.

Also disable runtime to address
"imx93-blk-ctrl 4ac10000.system-controller: Unbalanced pm_runtime_enable!"

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@vger.kernel.org
Message-ID: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 904ffa55b8f4..b10348ac10f0 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -313,7 +313,9 @@ static void imx93_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	pm_runtime_disable(&pdev->dev);
+
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);


