Return-Path: <stable+bounces-274251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pB86JV09Vmo/2AAAu9opvQ
	(envelope-from <stable+bounces-274251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A47554E9
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:45:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YMVjIDIk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274251-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274251-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84A830FDE16
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520346AEC5;
	Tue, 14 Jul 2026 13:40:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFC34BA24
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036412; cv=none; b=H4f5e2cKfnnUh+iKiod+3p84RSbCKv22J0S751C6a6bb8QXoekxf5gBtRyLJfnXIZ3pdb4uDIXS/iNOea3nVuPfZFSvaiiO4TNUJXqWAVoiRjCZlQ6EzjAgsOA4l3sPEkc35oZl3HgqWjO0UkT9rB5H0e0qHGINA9vvUrjw01+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036412; c=relaxed/simple;
	bh=vCgOEVh5hST7gtTelMlFcFE/LlwhqnYycAAH5qyVeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBJsUx6XvPAzP0eoEQoQdtWBc8HQ3jZDOOyTogkjtXOV7qEvGVFs1ofK/JuXutJBi0phwj+8Cr0+FRVwPp5BlMiyUsQZiU0EG1HJb1QniXCme6pK/p/1uW8g5rzLTs8jyhsWaLwHueYplY87Lo7Rm/Kh9gf8IShpOQGaIShq//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMVjIDIk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99B01F000E9;
	Tue, 14 Jul 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036411;
	bh=F9eGTnnjJ8Mb3giX6ZK38564ssJTcMmLWUJzhQXYqoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMVjIDIkuswCdvVDNiIO7/R2R5NrMyjCPvwnakcpvBMTOmlzuOsqqJ8IWomqLML96
	 4idsOL89NI6yV4lp1Mv6hfkELMCLIgtbwnBCx5k5jJlvR+v8ZiWBPTYuKMbq0ltfrx
	 5nNi8iBj4uFN9XLVLGZgXy6Xl1lBdxmL49rmweSouO5PuHoAGja4NIGpUQGrqb9xTF
	 lBxmijf1fE0CHf4fKBZB/JM+BWtC1GlJ5khLRY6EcPfCZmMnopO9ZsJti812EuhAzJ
	 ixeHJed7KJJPRHu+moZwH3VoeXyA6O+kwI/aDm9thTBHgInIJvfp5gVR8kw47K/Q90
	 wUf4GY8CbQfCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vfio/pci: Release the VGA arbiter client on register_device() failure
Date: Tue, 14 Jul 2026 09:40:09 -0400
Message-ID: <20260714134009.2674596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071329-outbid-dividing-1c8d@gregkh>
References: <2026071329-outbid-dividing-1c8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274251-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:alex.williamson@nvidia.com,m:kevin.tian@intel.com,m:alex@shazbot.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,shazbot.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F4A47554E9

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit daedde7f024ecf88bc8e832ed40cf2c795f0796a ]

The re-order in the Fixes commit below displaced vfio_pci_vga_init() as
the last failure point of what is now vfio_pci_core_register_device()
without introducing an unwind for the VGA arbiter registration.

In current kernels this is mostly benign because vfio_pci_set_decode()
only uses pci_dev state, but the original failure path could leave a
callback with a freed vdev cookie.  The stale registration also becomes
unsafe again once the callback follows drvdata to the vfio device.

Add the required VGA unwind callout.

Fixes: 4aeec3984ddc ("vfio/pci: Re-order vfio_pci_probe()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-3-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7835712f730dab..108af4b0863658 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -2094,6 +2094,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_power:
 	if (!disable_idle_d3)
 		vfio_pci_set_power_state(vdev, PCI_D0);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 out_reflck:
-- 
2.53.0


