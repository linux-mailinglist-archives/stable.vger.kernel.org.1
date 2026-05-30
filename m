Return-Path: <stable+bounces-258572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAHHHAspG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E55611506
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E26A1300E146
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE03B7B72;
	Sat, 30 May 2026 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+eUiv5+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254C223DC6;
	Sat, 30 May 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164798; cv=none; b=I2OrV8c/Ckr0kMSqyG+N7QgRLnXQT97s5Qez+lOjzzA6TGiUa6K6wRl2e4m6xx23luN2Fzd5GJ0kUYtgdVwLPDVsZd5MJDaQOUuxXXqTYlaTCzG6unCvrYeR1rsUGMVHUyMhVexexMh42z6q6UZf9KKSzwotC5iEtSAVWxeOj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164798; c=relaxed/simple;
	bh=mTxM1pSBtlhEk5TKeik3O2e5rVnI5holvkpPPXo0o7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsTalfMNGnxFiH4FmM0RC3lBF6vVqiFBTCH1IKP0OQP52D/HE14B7LxlVWlWMnjkhsNAkP49kP6TGsqjkFoTpyh6ilma1ERQRf6TgoFbXuHApS+auvDuFxaAt84ToVyaNZIr/29U1Pn5gNQr12vZzEVHMimV9Mm2VcGgcBMdKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+eUiv5+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C4D1F00893;
	Sat, 30 May 2026 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164797;
	bh=ER0MZJro7tmZxHffNnyNEuuRCnmwMSSX6ZSLC3eFWSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+eUiv5+/p/5CsxSX8au2a6w4Yr3aC9eIV2K2IGg7jlnI7q06m7KlTDS0fnwGsOfn
	 CB72b3xLQbu80AapUSOWCNx6D9+DuzGig2lZ86bI3X9XW45r9pEvs4G1teaajBk+rc
	 57SAWYt2om5HEl0OOvvsL4UREs5YC+EgMpp/qL9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 5.15 663/776] iommu/vt-d: Disable DMAR for Intel Q35 IGFX
Date: Sat, 30 May 2026 18:06:17 +0200
Message-ID: <20260530160257.028093070@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258572-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,naval.cat:email]
X-Rspamd-Queue-Id: 75E55611506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naval Alcalá <ari@naval.cat>

commit 2cda2e10dc8343ae01eae9e999a876b7e7d37861 upstream.

Intel Q35 integrated graphics (8086:29b2) exhibits broken DMAR
behaviour similar to other G4x/GM45 devices for which DMAR is
already disabled via quirks.

When DMAR is enabled, the system may hard lock up during boot or
early device initialization, requiring a reset.

Add the missing PCI ID to the existing quirk list to disable
DMAR for this device.

Fixes: 1f76249cc3be ("iommu/vt-d: Declare Broadwell igfx dmar support snafu")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=201185
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216064
Signed-off-by: Naval Alcalá <ari@naval.cat>
Link: https://lore.kernel.org/r/20260410161622.13549-1-ari@naval.cat
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5651,6 +5651,9 @@ static void quirk_iommu_igfx(struct pci_
 	dmar_map_gfx = 0;
 }
 
+/* Q35 integrated gfx dmar support is totally busted. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x29b2, quirk_iommu_igfx);
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);



