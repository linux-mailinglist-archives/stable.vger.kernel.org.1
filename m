Return-Path: <stable+bounces-239270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJtLLn9d5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:08:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1624309A9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB8935EE235
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6273368AF;
	Mon, 20 Apr 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQn3YwFW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0832ED54;
	Mon, 20 Apr 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699819; cv=none; b=TxMF0hBmt357Lr4FsineQU5UZwOl0jXDPRicqR7y5wBArFOWEbGhS0+fNb3/6KdKFVn2wGfRL0ssnbe7+Iyot4HxjI9754G5SXvAR8vFsEhOaJBgZZ9LOm/EbjgQDkB323OdT4SHBIrg1FQi4Aj90rwZjHWmWNsGgW+5eBusi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699819; c=relaxed/simple;
	bh=Eeq4Oa6e/ysivuJJmvmW4mxYB6xlGXs2SWNQ/g9f76s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTZWllfaGjxv3vfq6r6b8BskJLhgc+4Dfgm9skjBUsvwWOK3Qfiiq2DACXLTJGX5PpbSfGTkynR9y5mDKJyzJFJSdm9X6tli/cdG0ixYjIjd43QIfdv/Z2g/zuQInsrRSrCw/ClAv/mxxrqlxZoQeF5ZEJ0SZfn2RXIrwMtkCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQn3YwFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A53C19425;
	Mon, 20 Apr 2026 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699819;
	bh=Eeq4Oa6e/ysivuJJmvmW4mxYB6xlGXs2SWNQ/g9f76s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQn3YwFWUTD/CoKC8vnKdBNcCxM150VvR0W2DoOy1+i3RCGysyKuyc13vZdBIJlov
	 H8ks4WIidXYrkmuzhTsgjrLEAM2laNnbTnsVdk3WMbbdc9TyZr9EJJ9XU5173vmrTR
	 86WbNnypM0pVg9WRyrbl6xrYZcdY54xmDzR45j28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable <stable@kernel.org>
Subject: [PATCH 7.0 10/76] drm/vc4: platform_get_irq_byname() returns an int
Date: Mon, 20 Apr 2026 17:41:21 +0200
Message-ID: <20260420153911.194114055@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239270-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,raspberrypi.com,igalia.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ffwll.ch:email,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,raspberrypi.com:email,suse.de:email]
X-Rspamd-Queue-Id: 3C1624309A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit e597a809a2b97e927060ba182f58eb3e6101bc70 upstream.

platform_get_irq_byname() will return a negative value if an error
happens, so it should be checked and not just passed directly into
devm_request_threaded_irq() hoping all will be ok.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022339-cornflake-t-shirt-2471@gregkh
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2449,17 +2449,23 @@ static int vc4_hdmi_hotplug_init(struct
 	int ret;
 
 	if (vc4_hdmi->variant->external_irq_controller) {
-		unsigned int hpd_con = platform_get_irq_byname(pdev, "hpd-connected");
-		unsigned int hpd_rm = platform_get_irq_byname(pdev, "hpd-removed");
+		int hpd = platform_get_irq_byname(pdev, "hpd-connected");
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_con,
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd connected", vc4_hdmi);
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_rm,
+		hpd = platform_get_irq_byname(pdev, "hpd-removed");
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd disconnected", vc4_hdmi);



