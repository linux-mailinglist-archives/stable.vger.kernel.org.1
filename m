Return-Path: <stable+bounces-213252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKKqHb8Ggmn2OAMAu9opvQ
	(envelope-from <stable+bounces-213252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:31:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DDDA9E2
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1FBC3135BEB
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B163A9604;
	Tue,  3 Feb 2026 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGt+rAYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722A3A63E9
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128725; cv=none; b=io67l9LsrYPL2lFxyfKfOjFh4TQvgVnCelTLAw2+/F+acXL2mndicFDSXcoACqG/YLa3mX4rV9xPGyWMo1Y1lmx5IYMgLhel8GVhV0QEkn+coetkDCQbrjj4PQnxV4obrOegfJHUpv6+MZCSjqSBcgJnplRpeNzbteyId72MA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128725; c=relaxed/simple;
	bh=ij4SDGp1opbzrJe20PqBIWZNPjtknyyUZJmweMwsolg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AgfLh1XdgoFmW0BLi+gd1XPMePNTHp48dK2lkbPBOQ5QeBm78Y9cblFoy9FjmYKd+q8t6pInzkWz0hDT55iz3ECilNAIK1LnU+UqEMyl1mjhT54p7EW6GEpxfu9IQjgqA8AXYipRDxbDIOxXGeUd4VoW6mDEGEm1sqR8QGxqzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGt+rAYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C9C116D0;
	Tue,  3 Feb 2026 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770128725;
	bh=ij4SDGp1opbzrJe20PqBIWZNPjtknyyUZJmweMwsolg=;
	h=Subject:To:Cc:From:Date:From;
	b=RGt+rAYOQIQ2dvUXQlk3kqUv3d0BGFVkiraGD1SJDt0GDIQdy6RDK8iTOVj0LSqXa
	 HUg0eM/pwxapxqbSxMP3T9SYv7JoGDAAA/AyRgtsq3QRpTr3IUQjKLcy8uI+vGdUgg
	 XckFfFd9ESZ1r/ekl8UJkD53EeObMUmmKCRgX9F4=
Subject: FAILED: patch "[PATCH] drm/imx/tve: fix probe device leak" failed to apply to 6.1-stable tree
To: johan@kernel.org,Frank.Li@nxp.com,mripard@kernel.org,p.zabel@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 15:25:22 +0100
Message-ID: <2026020322-mascot-usage-c825@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213252-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nxp.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,pengutronix.de:email]
X-Rspamd-Queue-Id: C27DDDA9E2
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e535c23513c63f02f67e3e09e0787907029efeaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020322-mascot-usage-c825@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e535c23513c63f02f67e3e09e0787907029efeaf Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 30 Oct 2025 17:34:56 +0100
Subject: [PATCH] drm/imx/tve: fix probe device leak

Make sure to drop the reference taken to the DDC device during probe on
probe failure (e.g. probe deferral) and on driver unbind.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251030163456.15807-1-johan@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index c5c6e070cc06..e861b8b9d8fa 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -528,6 +528,13 @@ static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
 };
 
+static void imx_tve_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int imx_tve_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -549,6 +556,12 @@ static int imx_tve_probe(struct platform_device *pdev)
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
+		if (tve->ddc) {
+			ret = devm_add_action_or_reset(dev, imx_tve_put_device,
+						       &tve->ddc->dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	tve->mode = of_get_tve_mode(np);


