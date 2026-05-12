Return-Path: <stable+bounces-245704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDe5Lf4+A2qr2AEAu9opvQ
	(envelope-from <stable+bounces-245704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:53:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7752523032
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E1AF306E2CB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C53AEB43;
	Tue, 12 May 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZdHFXKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5F39AD34
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595492; cv=none; b=LLNqvTb9fW3u/oyj1K5FVrkJ/66kqEt33wNS11h4icggGoVupuRh8kxMOhSEtN7pJ/RaB5soG8g4JNj8ohhHn/MMZqzhHEhe3fXp5/mrp+S0pRxxQlAvfd4G8IAaoPFq9t+O9vvSUEn1FZ28xeeqSSQn7+9kCs99+4K2PiNew5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595492; c=relaxed/simple;
	bh=YjAcAdM5L7526JkmMOJEMUHc5Wrh0Zfbfj9c+0cnPdo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U3Ha6dU49kA/Nv7euCPJVl1+KT9Pju+CS+LhmuXyD1BZyK1ztgFx+ULOb6O92Af1RJBuqY46BJm6kA58q862ehELw3CkVcMJyOGByFHyECAgUzu/wh96AThalyrprxWDa1kKs9AHB9SqiCIeY2sbMNwaTRm9zFbTkaNlFbQ45eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZdHFXKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E327C2BCF5;
	Tue, 12 May 2026 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595492;
	bh=YjAcAdM5L7526JkmMOJEMUHc5Wrh0Zfbfj9c+0cnPdo=;
	h=Subject:To:Cc:From:Date:From;
	b=MZdHFXKLs2gtyexwOCjNOz7kQVbLFvyhSr57uVBnsLzZilRpAIP1ds4+mlnMbUCOU
	 0SBgbpfhtOPGGhh6+TSy8wq27giBDu5FvuUXNDnuoEKYGx6zphq9VSU36UEk6uFQlH
	 ErQXP2cE7qoZyLNLukgVY0KM/OpGBFVFeJXjzYTI=
Subject: FAILED: patch "[PATCH] PCI/ASPM: Fix pci_clear_and_set_config_dword() usage" failed to apply to 5.15-stable tree
To: lukas@wunner.de,bhelgaas@google.com,me@avm99963.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:14:11 +0200
Message-ID: <2026051211-lifting-happiness-08a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7752523032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245704-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm99963.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wunner.de:email,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cc33985d26c92a5c908c0185239c59ec35b8637c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051211-lifting-happiness-08a3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc33985d26c92a5c908c0185239c59ec35b8637c Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 16 Feb 2026 08:46:13 +0100
Subject: [PATCH] PCI/ASPM: Fix pci_clear_and_set_config_dword() usage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When aspm_calc_l12_info() programs the L1 PM Substates Control 1 register
fields Common_Mode_Restore_Time, LTR_L1.2_THRESHOLD_Value and _Scale, it
invokes pci_clear_and_set_config_dword() in an incorrect way:

For the bits to clear it selects those corresponding to the field.  So far
so good.  But for the bits to set it passes a full register value.
pci_clear_and_set_config_dword() performs a boolean OR operation which
sets all bits of that value, not just the ones that were just cleared.

Thus, when setting the LTR_L1.2_THRESHOLD_Value and _Scale on the child of
an ASPM link, aspm_calc_l12_info() also sets the Common_Mode_Restore_Time.
That's a spec violation:  PCIe r7.0 sec 7.8.3.3 says this field is RsvdP
for Upstream Ports.  On Adrià's Pixelbook Eve, Common_Mode_Restore_Time
of the Intel 7265 "Stone Peak" wifi card is zero, yet aspm_calc_l12_info()
does not preserve the zero bits but instead programs the value calculated
for the Root Port into the wifi card.

Likewise, when setting the Common_Mode_Restore_Time on the Root Port,
aspm_calc_l12_info() also changes the LTR_L1.2_THRESHOLD_Value and _Scale
from the initial 163840 nsec to 237568 nsec (due to ORing those fields),
only to reduce it afterwards to 106496 nsec.

Amend all invocations of pci_clear_and_set_config_dword() to only set bits
which are cleared.

Finally, when setting the T_POWER_ON_Value and _Scale on the Root Port and
the wifi card, aspm_calc_l12_info() fails to preserve bits declared RsvdP
and instead overwrites them with zeroes.  Replace pci_write_config_dword()
with pci_clear_and_set_config_dword() to avoid this.

Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220705#c22
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Adrià Vilanova Martínez <me@avm99963.com>
Cc: stable@vger.kernel.org # v4.11+
Link: https://patch.msgid.link/5c1752d7512eed0f4ea57b84b12d7ee08ca61fc5.1771226659.git.lukas@wunner.de

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 21f5d23e0b61..925373b98dff 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -706,22 +706,29 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	}
 
 	/* Program T_POWER_ON times in both ports */
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
-	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
 
 	/* Program Common_Mode_Restore_Time in upstream device */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+				       PCI_L1SS_CTL1_CM_RESTORE_TIME,
+				       ctl1 & PCI_L1SS_CTL1_CM_RESTORE_TIME);
 
 	/* Program LTR_L1.2_THRESHOLD time in both ports */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 
 	if (pl1_2_enables || cl1_2_enables) {
 		pci_clear_and_set_config_dword(parent,


