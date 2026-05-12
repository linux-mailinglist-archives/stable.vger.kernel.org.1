Return-Path: <stable+bounces-245990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHn/L41pA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:55:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D8526495
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443F130CEA0D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC73955D4;
	Tue, 12 May 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlGbYfNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAA3955D3;
	Tue, 12 May 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608074; cv=none; b=UPAln7ogPIxv3OI8WhUrsvnzF/62VUiAosRbNofAEUnKoEoS73SyTLk4PaXjFg8CBd5Qejt2r1WrN2lTlSoTTg3y67M3Rkv+Wazep2K5dEWb56Kkj+9kKs8cUSe6WutdZU2oZcPM34i9wSWkcTcrZquPiq3/E+Mm3bULKtqUnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608074; c=relaxed/simple;
	bh=HBQjzgKheesxOpD6+l9zebO1Aw07mqI+Pvca2+Yu0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkrOeB6zTXOlEcLjqIsjXiqtKLD5wvcI/y00Qe3djeWa23taDFGDm06f16kDlizu0dvgWncDVTMLxUx6k5Z7YE3DxWJbecJ8OYw84KFVghKguDfQlm2nJrEnycpAOPKdr8NWfohyITlM9/Mc74yE2pOgL5Rq1/msdH8kVDwHyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlGbYfNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E573C2BCB0;
	Tue, 12 May 2026 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608074;
	bh=HBQjzgKheesxOpD6+l9zebO1Aw07mqI+Pvca2+Yu0qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlGbYfNoM34qUED3NZPhb5c42zL+7GSY43ULon0cZ2xFdALVdTrSFKd4lMGwfoEMM
	 f/9OeYVLddw9aekllBqKpmNIGBV27Kbw4jg8DfSYUXmhZM9qi6iErypm5mj+TnncQn
	 kY/NltzGflpxpgKTWtIH9nRkJrEN3vVZiybwpYHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernd Schumacher <bernd@bschu.de>,
	"Alexandre N." <an.tech@mailo.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.12 143/206] PCI: Update saved_config_space upon resource assignment
Date: Tue, 12 May 2026 19:39:55 +0200
Message-ID: <20260512173935.890728481@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 308D8526495
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245990-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailo.com:email,wunner.de:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 909f7bf9b080c10df3c3b38533906dbf09ff1d8b upstream.

Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
adapter plugged into an ASRock X570S PG Riptide board with BIOS version
P5.41 (09/07/2023):

  ddbridge 0000:05:00.0: detected Digital Devices Cine S2 V6 DVB adapter
  ddbridge 0000:05:00.0: cannot read registers
  ddbridge 0000:05:00.0: fail

BIOS assigns an incorrect BAR to the DVB adapter which doesn't fit into the
upstream bridge window.  The kernel corrects the BAR assignment:

  pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
  pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned

Correction of the BAR assignment happens in an x86-specific fs_initcall,
pcibios_assign_resources(), after device enumeration in a subsys_initcall.
This order was introduced at the behest of Linus in 2004:

  https://git.kernel.org/tglx/history/c/a06a30144bbc

No other architecture performs such a late BAR correction.

Bernd bisected the issue to commit a2f1e22390ac ("PCI/ERR: Ensure error
recoverability at all times"), but it only occurs in the absence of commit
4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").
This combination exists in stable kernel v6.12.70, but not in mainline,
hence Bernd cannot reproduce the issue with mainline.

Since a2f1e22390ac, config space is saved on enumeration, prior to BAR
correction.  Upon passthrough, the corrected BAR is overwritten with the
incorrect saved value by:

  vfio_pci_core_register_device()
    vfio_pci_set_power_state()
      pci_restore_state()

But only if the device's current_state is PCI_UNKNOWN, as it was prior to
commit 4d4c10f763d7.  Since the commit, it is PCI_D0, which changes the
behavior of vfio_pci_set_power_state() to no longer restore the state
without saving it first.

Alexandre is reporting the same issue as Bernd, but in his case, mainline
is affected as well.  The difference is that on Alexandre's system, the
host kernel binds a driver to the device which is unbound prior to
passthrough, whereas on Bernd's system no driver gets bound by the host
kernel.

Unbinding sets current_state to PCI_UNKNOWN in pci_device_remove(), so when
vfio-pci is subsequently bound to the device, pci_restore_state() is once
again called without invoking pci_save_state() first.

To robustly fix the issue, always update saved_config_space upon resource
assignment.

Reported-by: Bernd Schumacher <bernd@bschu.de>
Closes: https://lore.kernel.org/r/acfZrlP0Ua_5D3U4@eldamar.lan/
Reported-by: Alexandre N. <an.tech@mailo.com>
Closes: https://lore.kernel.org/r/dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com/
Fixes: a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Bernd Schumacher <bernd@bschu.de>
Tested-by: Alexandre N. <an.tech@mailo.com>
Cc: stable@vger.kernel.org # v6.12+
Link: https://patch.msgid.link/febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/setup-res.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -102,6 +102,7 @@ static void pci_std_update_resource(stru
 	}
 
 	pci_write_config_dword(dev, reg, new);
+	dev->saved_config_space[reg / 4] = new;
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
@@ -112,6 +113,7 @@ static void pci_std_update_resource(stru
 	if (res->flags & IORESOURCE_MEM_64) {
 		new = region.start >> 16 >> 16;
 		pci_write_config_dword(dev, reg + 4, new);
+		dev->saved_config_space[(reg + 4) / 4] = new;
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
 			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",



