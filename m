Return-Path: <stable+bounces-204652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C4CF31FE
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFC9306DC0A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA932D452;
	Mon,  5 Jan 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZvRzlYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FB2D7DCE
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610699; cv=none; b=BZ7XWUNHWcJES3E6k7p4XCVNKQTH11J02yxHLG0qFkadd+lrYzHdnu667Q/COuxD9UKFVQ6zaAgf82PjIZ4dOozwGjKTAjgaNACH32RSupnMkcV5n1ebAvYeCSGlEJUXo2QneNWaCPYvB1PNGIjn5lH5TF+3i3mTeP313PEa3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610699; c=relaxed/simple;
	bh=w/d0Sinw5mZo8kDod0SI7Sm1aLnXfIiQQW47Sut4mOo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tR3WQSF8lpPrJdOwfOF8drEUE4nYeEgi74zAha/wZudndivD0AKptEZQF1YGYEDjy+fDvYrmJzKFzbqMqIYUBQDKpsVXTJpN3Bp2a+T2JSe8sumXzgr6C948M2OZQoB15B45yo7Mtj6Tbc02g1UTieXyDMz6DTs4AHJr00VKWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZvRzlYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59E9C116D0;
	Mon,  5 Jan 2026 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610699;
	bh=w/d0Sinw5mZo8kDod0SI7Sm1aLnXfIiQQW47Sut4mOo=;
	h=Subject:To:Cc:From:Date:From;
	b=IZvRzlYJFFCdJ44T8hVRjXn+t9e6tvSQPrl9NMu/sxhB8m5gBCTmyRdVwmTkfBLb0
	 1yCpqifKeXVNZt5X0j6l7WcUuCaH5k26nOAKR8KO1mo7jAbn/UuSjHwqAIe2eIuW1G
	 az2BzuZVopBcv8apxT50Ey0Zqu1DFbueyB745Cus=
Subject: FAILED: patch "[PATCH] media: platform: mtk-mdp3: fix device leaks at probe" failed to apply to 6.1-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,hverkuil+cisco@kernel.org,moudy.ho@mediatek.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:58:08 +0100
Message-ID: <2026010508-peddling-tank-6077@gregkh>
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
git cherry-pick -x 8f6f3aa21517ef34d50808af0c572e69580dca20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010508-peddling-tank-6077@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f6f3aa21517ef34d50808af0c572e69580dca20 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 24 Sep 2025 16:39:19 +0200
Subject: [PATCH] media: platform: mtk-mdp3: fix device leaks at probe

Make sure to drop the references taken when looking up the subsys
devices during probe on probe failure (e.g. probe deferral) and on
driver unbind.

Similarly, drop the SCP device reference after retrieving its platform
data during probe to avoid leaking it.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Cc: stable@vger.kernel.org	# 6.1
Cc: Moudy Ho <moudy.ho@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 6559d72d5d42..6d26d4aa1eef 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -157,10 +157,18 @@ void mdp_video_device_release(struct video_device *vdev)
 	kfree(mdp);
 }
 
+static void mdp_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int mdp_mm_subsys_deploy(struct mdp_dev *mdp, enum mdp_infra_id id)
 {
 	struct platform_device *mm_pdev = NULL;
 	struct device **dev;
+	int ret;
 	int i;
 
 	if (!mdp)
@@ -194,6 +202,11 @@ static int mdp_mm_subsys_deploy(struct mdp_dev *mdp, enum mdp_infra_id id)
 		if (WARN_ON(!mm_pdev))
 			return -ENODEV;
 
+		ret = devm_add_action_or_reset(&mdp->pdev->dev, mdp_put_device,
+					       &mm_pdev->dev);
+		if (ret)
+			return ret;
+
 		*dev = &mm_pdev->dev;
 	}
 
@@ -279,6 +292,7 @@ static int mdp_probe(struct platform_device *pdev)
 			goto err_destroy_clock_wq;
 		}
 		mdp->scp = platform_get_drvdata(mm_pdev);
+		put_device(&mm_pdev->dev);
 	}
 
 	mdp->rproc_handle = scp_get_rproc(mdp->scp);


