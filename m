Return-Path: <stable+bounces-239931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLlbMkhp5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:58:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA943258A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F7731E9ADC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85B344D86;
	Mon, 20 Apr 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JcDn1Wi5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B334107F;
	Mon, 20 Apr 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701580; cv=none; b=mbBmnBTsp+z2PVWQoCmV+KKDvx7Pzp9fRZWYVrNfRGCNPYITH4wr63CUXH02kIP/pK87TviekYuMzppDHG+8tCzI4DfkNjy1mSZNBCMv9dDdlcljwpg78LHBS3cf4wDIFBW8et+ctTowpV3x1CNdKNTZT3BYJkKfdmUy4dccVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701580; c=relaxed/simple;
	bh=3mcL31hM0ovu0jMK91xgTYZrnbs8zsWei5miGYg8Wa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L///R7xObRWdfItFAYspgpvwh7uctYUwOLI7Ctfq+hydnKwRDZFjovcwnm9fYXJlEExcWGIPXbGxBNYaEVAS/99XDEssMT69h2+Fa5yebE1ggsp9jRIorfL+ZsyUJ7zFONFhYnXTE9WY+pOeqMJQk2i9Et8NccjxHpReL7NbFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JcDn1Wi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F62C19425;
	Mon, 20 Apr 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701580;
	bh=3mcL31hM0ovu0jMK91xgTYZrnbs8zsWei5miGYg8Wa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcDn1Wi5aFzuUladPRRMmt57jSInS5WsiydpeJJa0yDlqNSEVRkFRX0e0Yh1bQfGA
	 3JXRhNftPXMZTVuDQ/0UG3CUq0MhA1Ep7h4vcUZB9p9xrCB8PsFZLNFVj9HpePIfU3
	 zULPxTbpXqul2uZzmPaSQpqt9V2AkhD/7/gVgeDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 6.12 160/162] PCI: Fix placement of pci_save_state() in pci_bus_add_device()
Date: Mon, 20 Apr 2026 17:43:12 +0200
Message-ID: <20260420153932.851452840@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239931-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DEA943258A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

Commit 58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all
times") sought to backport upstream commit a2f1e22390ac, but misplaced
the call to pci_save_state() in pci_bus_add_device():

It put the call at the top of the function even though the upstream
commit deliberately put it in the middle to capture config space changes
caused by pci_fixup_final().

Fix the placement.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/bus.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -331,9 +331,6 @@ void pci_bus_add_device(struct pci_dev *
 	struct device_node *dn = dev->dev.of_node;
 	int retval;
 
-	/* Save config space for error recoverability */
-	pci_save_state(dev);
-
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -346,6 +343,9 @@ void pci_bus_add_device(struct pci_dev *
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
+	/* Save config space for error recoverability */
+	pci_save_state(dev);
+
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)



