Return-Path: <stable+bounces-108406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A8A0B48E
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786BD163033
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59391FDA65;
	Mon, 13 Jan 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvcF4Kvh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B7235C07
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764081; cv=none; b=n9tNRhOzDQ7B1FjSf8os3QP/F9cokT4u6nHu4cyQcP13Ir6gGBDjDUCBSG+oWa4e81mMt9NBaHUWzJy2dGnZxI2FLpGCLnjl1SLXbIhheb7VOZzYu90v7Kte7IZPWSyisNMc9rK2bUD3VeaNbs0bjbax5bov1hKeGCNNYd/BaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764081; c=relaxed/simple;
	bh=9xTztXUjz5tf20MXeulOaFPe06A3jmt4ef+aKmtdoS0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kQwUmnBn7vj406m/NZTOhNMrlLGev2FU2T9i4XDIKwnYE4oakqgUVH6JYGfh+ihxqoZV7M/BSvNZgzlI74FGM2cpWlNGsxvuAkBMAsXMxBRQc94E7WiP5ZsNWyseafcFeOwOrRTlsr/7ntB557gprhCRqIjT/SjtHzPUK2T48no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvcF4Kvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB2EC4CED6;
	Mon, 13 Jan 2025 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736764081;
	bh=9xTztXUjz5tf20MXeulOaFPe06A3jmt4ef+aKmtdoS0=;
	h=Subject:To:Cc:From:Date:From;
	b=NvcF4Kvhf6onq3BAq9e6MWQHE6oljItPAWOPjIu/mc+oKR0tfOCBR9D7CJKyhDWLY
	 LCyx2c13tKZkgwIiO0ewAVIsYZ8zf9nYo5JB+cGTdOYFduss3v5BcR87VSc6d+nswY
	 GtIxh41vNZ04Hju2qsfSjE3RyfmA6o9haL/LimH0=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Set orientation as none when connector is" failed to apply to 6.12-stable tree
To: abel.vesa@linaro.org,bryan.odonoghue@linaro.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,johan+linaro@kernel.org,neil.armstrong@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:27:57 +0100
Message-ID: <2025011357-emboss-unclaimed-572f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f47eba045e6cb97f9ee154c68dbf7c3c756919aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011357-emboss-unclaimed-572f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f47eba045e6cb97f9ee154c68dbf7c3c756919aa Mon Sep 17 00:00:00 2001
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 12 Dec 2024 19:37:43 +0200
Subject: [PATCH] usb: typec: ucsi: Set orientation as none when connector is
 unplugged

The current implementation of the ucsi glink client connector_status()
callback is only relying on the state of the gpio. This means that even
when the cable is unplugged, the orientation propagated to the switches
along the graph is "orientation normal", instead of "orientation none",
which would be the correct one in this case.

One of the Qualcomm DP-USB PHY combo drivers, which needs to be aware of
the orientation change, is relying on the "orientation none" to skip
the reinitialization of the entire PHY. Since the ucsi glink client
advertises "orientation normal" even when the cable is unplugged, the
mentioned PHY is taken down and reinitialized when in fact it should be
left as-is. This triggers a crash within the displayport controller driver
in turn, which brings the whole system down on some Qualcomm platforms.
Propagating "orientation none" from the ucsi glink client on the
connector_status() callback hides the problem of the mentioned PHY driver
away for now. But the "orientation none" is nonetheless the correct one
to be used in this case.

So propagate the "orientation none" instead when the connector status
flags says cable is disconnected.

Fixes: 76716fd5bf09 ("usb: typec: ucsi: glink: move GPIO reading into connector_status callback")
Cc: stable <stable@kernel.org> # 6.10
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20241212-usb-typec-ucsi-glink-add-orientation-none-v2-1-db5a50498a77@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 90948cd6d297..fed39d458090 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -185,6 +185,11 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
 	int orientation;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
+		return;
+	}
+
 	if (con->num > PMIC_GLINK_MAX_PORTS ||
 	    !ucsi->port_orientation[con->num - 1])
 		return;


