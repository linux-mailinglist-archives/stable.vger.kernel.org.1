Return-Path: <stable+bounces-252177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG1cMUj4DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710959553D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 447BE3120D44
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831733F1AD9;
	Wed, 20 May 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYmeyzQl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284494F5E0;
	Wed, 20 May 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299993; cv=none; b=ShhX+jEnHSVjI2emx5i6E0oBbXUHs5wYeG6tGkNCLGLzLSBQ2irrp4Fjx1Um3hpDtCiz4WJ1ajmy4qdLPu5JTKP84Y7nG/mqKkrOr0vXeDv7WS8VJ7Jx1dSyPWBzdlpMp1CXmU5MOngYMhUG/mKDLkU39fKfB2s8MEM6/wc0V20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299993; c=relaxed/simple;
	bh=39iA4Cx/6UzsSSKiLgur6AgH/3hpHfljb4ldfLlRJdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrSONmQRg4/lky+R57vL3jQs0jtdxHrv9RNY611q3ZdDo1JG57BArujwq2aPP/T2RiWPGou3IKnrT0+I0yga+1Ufk168GcV5W+2IuGhMxsTT6CVH5NW0upRwTI+ookkCdBj3h/QEkkVRUVFBsPiaD2LyMQ99nEUIL0WkFAswczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYmeyzQl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4B1F000E9;
	Wed, 20 May 2026 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299992;
	bh=Mi9a/8wwx9a3t2iCVxjQnWXcg1IptZPb8EZORVZdGUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYmeyzQlBNsXpjF3cJXo9xHBzBhWwuxfaceJ8MxmjVeML5ni/mSXKd0mhtnVl4rJo
	 Gpmrr5Aknb0wdPnfH0/Tf0VJ0DzMo/4+zrnI7v5yeJIIYsswjYUdZiEMunT9dj2q4B
	 9yQ8ORS6QTe0VVV1JN8pPinWUcd3PZK6zNKPrwr4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18 937/957] iommu/vt-d: Disable DMAR for Intel Q35 IGFX
Date: Wed, 20 May 2026 18:23:40 +0200
Message-ID: <20260520162154.917894442@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252177-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,naval.cat:email]
X-Rspamd-Queue-Id: 3710959553D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4517,6 +4517,9 @@ static void quirk_iommu_igfx(struct pci_
 	disable_igfx_iommu = 1;
 }
 
+/* Q35 integrated gfx dmar support is totally busted. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x29b2, quirk_iommu_igfx);
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);



