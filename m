Return-Path: <stable+bounces-273728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SFteNJbnVGqMgwAAu9opvQ
	(envelope-from <stable+bounces-273728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:26:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6574B8E4
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1v1+5jPn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273728-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273728-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E436E3084B07
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FB040BCD2;
	Mon, 13 Jul 2026 13:19:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D5421EED
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948771; cv=none; b=fqv06qerqwH/jzVz9GT7MCXyTBmGAToMtJLadnL3eJeAzKe0qIYmwz6xQvWelf4xrXA+gUpZF/wBAWZN6Juj6O6Wxg34MFO5gXOT+IVORhNcZ0H5/fD1IClzpkXqjWN8RV+BO0GT72M+CZ3mPrFk3UMULfIoGpMzBHGCcGAr570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948771; c=relaxed/simple;
	bh=eJVnFsIPP6blew/D513pDfINr0Sfjy8ufMWViYH6bE8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SenTgL2ysLvwTjcWVg2fOB01UdLVFzJJHE9xc2k1KtPhBPZ2MelBkup7DcTXkbBxe0gz7us3jq0VDgYYNfw5B6yktkHvfhciZO6dqtVmUEcumcLu+qhDmFTPlAFFJ0XkM1EFOF5P04RRuRrAy74CWf2Iu67JONnOxYxqbiParxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1v1+5jPn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5DB1F00A3A;
	Mon, 13 Jul 2026 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948770;
	bh=6duZNTXyp5lYtakL6pB6ojqAqFsj44IgUOM+kfTJrZE=;
	h=Subject:To:Cc:From:Date;
	b=1v1+5jPnfGlwLLJc9838GZj6l43Ba2B9XyrW9RdqUlxIdCpchBKlfQOnQobQfveOt
	 +YFKcxwNVdesLLPllMRMZxyP0uvg04tvbVp7GAmU2THSGz46nfEHOWkcui0RJo7e16
	 V1tj5hA4iHUCQeUy65yqyOuC4bsVvWXDRBi8hy6Y=
Subject: FAILED: patch "[PATCH] vfio/pci: Release the VGA arbiter client on register_device()" failed to apply to 5.10-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:06:29 +0200
Message-ID: <2026071329-outbid-dividing-1c8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273728-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alex.williamson@nvidia.com,m:alex@shazbot.org,m:kevin.tian@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,gregkh:mid,vger.kernel.org:from_smtp,shazbot.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BE6574B8E4


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x daedde7f024ecf88bc8e832ed40cf2c795f0796a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071329-outbid-dividing-1c8d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From daedde7f024ecf88bc8e832ed40cf2c795f0796a Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@nvidia.com>
Date: Mon, 15 Jun 2026 13:12:30 -0600
Subject: [PATCH] vfio/pci: Release the VGA arbiter client on register_device()
 failure

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

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f8d1755de2ce..dab82c078580 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2254,6 +2254,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 	return ret;


