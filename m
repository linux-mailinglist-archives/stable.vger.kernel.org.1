Return-Path: <stable+bounces-252134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDzJKTv/DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F596C31
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D302137DED15
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1F3F39F5;
	Wed, 20 May 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFcUck6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8F17A309;
	Wed, 20 May 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299880; cv=none; b=KKIceEvBS0PKa2Ll+67BnGUTDwsf2W82CChiYNytyjdiSf5f7ILfiv57LD0DJp5EK0xV8iuXv92I+e9k43UUNz6z1fNW9kQXuidGkogOeXTVK974ndIvzFS9nSAJWLX57+HA3orNUaIOyal8ZDyLeQ3XxQ00Nqg20L+h68ea8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299880; c=relaxed/simple;
	bh=PaKDC++oHdt1PU01NiQmJpDAaDgli2u7/xl9WYOnBN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEiQOx12N5mmKiGkbvY8rvTfXfpFlbkCCmD9SVUAxy3oH/0f2gbiDR8CcN6P2uYqaKTSMS/674kc5WlWn+mhNL5VcwbwvX6S2JPstuzJdTqJlVj73aWn/wy+dO//ZGBJ/0WMb0tWGBkGKLCkT6E6yq0v6iYefsxOolnHdgEeeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFcUck6X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEAF1F000E9;
	Wed, 20 May 2026 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299878;
	bh=Ry7TbipqJoqXQoOFesCwcgkpksPRleuYpaLXqjEASpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFcUck6XFyJJmi9gh2IVkmFx9heoTV9KbpGfvJ7w0Yah7Z407IBRSj/hK/PFc1aii
	 jIYsesNQJUNtOC9xChq5tOl8cRKzyIQRBwXw7l3gGRxRV4pMfbfhdSJAGjkzEYFZhc
	 TUlF99RbcXkRPR1XcNakZ6ja0Dd8BKnMDOaGSYoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyuan Chen <zc@anthropic.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18 920/957] iommu/amd: Bounds-check devid in __rlookup_amd_iommu()
Date: Wed, 20 May 2026 18:23:23 +0200
Message-ID: <20260520162154.531980449@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252134-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,anthropic.com:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toxicpanda.com:email]
X-Rspamd-Queue-Id: 1FD9F596C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

commit 07d0f496fe7ec5abe3bee7e38be709521567bb33 upstream.

iommu_device_register() walks every device on the PCI bus via
bus_for_each_dev() and calls amd_iommu_probe_device() for each. The
inlined check_device() path computes the device's sbdf, calls
rlookup_amd_iommu() to find the owning IOMMU, and only afterwards
verifies devid <= pci_seg->last_bdf. __rlookup_amd_iommu() indexes
rlookup_table[devid] with no bounds check of its own, so for a PCI
device whose BDF is not described by the IVRS, the lookup reads past
the end of the allocation before the caller's bounds check can run.

This was harmless before commit e874c666b15b ("iommu/amd: Change
rlookup, irq_lookup, and alias to use kvalloc()"): the table was a
zeroed page-order allocation, so the over-read returned NULL and the
caller's NULL check skipped the device. After that commit the table is
a tight kvcalloc() and the over-read returns adjacent slab contents,
which check_device() then dereferences as a struct amd_iommu *,
causing a boot-time GPF.

Seen on Google Compute Engine ct6e VMs, where the virtualized IVRS
describes only the four TPU endpoints 00:04.0-07.0; the gVNIC at
00:08.0 (devid 0x40) indexes 56 bytes past the 456-byte allocation,
into the adjacent kmalloc-512 slab object:

  pci 0000:00:04.0: Adding to iommu group 0
  pci 0000:00:05.0: Adding to iommu group 1
  pci 0000:00:06.0: Adding to iommu group 2
  pci 0000:00:07.0: Adding to iommu group 3
  Oops: general protection fault, probably for non-canonical address 0x3a64695f78746382: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.22 #1
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/06/2025
  RIP: 0010:amd_iommu_probe_device+0x54/0x3a0
  Call Trace:
   __iommu_probe_device+0x107/0x520
   probe_iommu_group+0x29/0x50
   bus_for_each_dev+0x7e/0xe0
   iommu_device_register+0xc9/0x240
   iommu_go_to_state+0x9c0/0x1c60
   amd_iommu_init+0x14/0x40
   pci_iommu_init+0x16/0x60
   do_one_initcall+0x47/0x2f0

Guard the array access in __rlookup_amd_iommu(). With the fix applied
on 6.18.22, the gVNIC at 00:08.0 is skipped cleanly and the VM boots.

Fixes: e874c666b15b ("iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()")
Cc: stable@vger.kernel.org
Reported-by: Ziyuan Chen <zc@anthropic.com>
Tested-by: Ziyuan Chen <zc@anthropic.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd/iommu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -329,8 +329,12 @@ static struct amd_iommu *__rlookup_amd_i
 	struct amd_iommu_pci_seg *pci_seg;
 
 	for_each_pci_segment(pci_seg) {
-		if (pci_seg->id == seg)
-			return pci_seg->rlookup_table[devid];
+		if (pci_seg->id != seg)
+			continue;
+		/* IVRS may not describe every device on the bus */
+		if (devid > pci_seg->last_bdf)
+			return NULL;
+		return pci_seg->rlookup_table[devid];
 	}
 	return NULL;
 }



