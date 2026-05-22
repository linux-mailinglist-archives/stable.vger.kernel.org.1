Return-Path: <stable+bounces-253717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAAlHIkcEGrqTgYAu9opvQ
	(envelope-from <stable+bounces-253717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:06:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D46075B0D91
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D531A30207CF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4633B7759;
	Fri, 22 May 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWl/Ja9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5803B3BF2
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440617; cv=none; b=C93x9MaDr3SJric3boeU9kC5jgY5SplaQkjK0aO3qS++e70xfe/rTF6MYN1fQHHxu40m3XfCbugz0JJDTqX50T0CObfLkkgHg6gyTrW9nQJu+dPmSJKknOZsKLwTuz3/y4nfbJ6fhptNFlZvtPM8Cjo2hu4+t5dWAK3tIV4kX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440617; c=relaxed/simple;
	bh=cP8Wy30SjzkGdpt59Lod6Ulao6cPITYTAJj19/9raXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbIMWoCks9uef2Hg3ZkoApmXYz6X/aj3rep7cdJhBcPuesU6iOHcpw5aOkcaym88pXLyyukFwc2Crx9uIma7/093XPA8G2i5TnInm9MNwrg+kEeCJ7b0FDsgza4nOtDh0MSSVbv5lxme7/P6MiIupQ86NPjqVhclJgzDCMPZZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWl/Ja9h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso74170125e9.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440614; x=1780045414; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg49TtTvO2RO/6WZj2jf7npNdtKp+STjgUNA71M7QmY=;
        b=rWl/Ja9hxd+mbzBgNzir/MKF1CIjbwCVX9xJyuWntdNF809NPjIMGjgL38qpUOoY9c
         uec4Oe6M1eEVymfO401oa1Es0/C4NOH71APO+yQMtDXZ/cwDf7wv5GeMmTWPBqdoSkMv
         czP7L700AVVXVTEx650WGtOrI/icwsORG/tuVAhJ8RoAbln/zZRba36jr5Wu6S9nJK3j
         6ZcTuxYOKZdVXPpfie/49noEVhOUW8q74Zjj0uhWutTptuz1n/DzJcJzCtbxZTe3RtEx
         KjiMLE0/Xr1zFGeoq6aafM7x7mCs/m4mMKqDLvrlF/047bwJ+kQIboiwsTnPpdhUU53d
         oCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440614; x=1780045414;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rg49TtTvO2RO/6WZj2jf7npNdtKp+STjgUNA71M7QmY=;
        b=sQzGt/SIBAYDH7t4AD8lY8aJfX0rdHa15eIgCOUDnrhn2rJN4rRfXH7HT7AD0h+zwX
         XxOLavYr2nln25IbInF20+m8YGZ+FckNIOjKYbn4e41RgCVZkXmeLuyHfaGmZsjqEZ6/
         d3/oOEq07X8iv1LokTFiVeDVBL137Dj5qP8XdONmslvg9+W7ZHaGNArQhTiXjN/M5l6H
         DGYyRi6bW26prtOUnlyIV2LZVMDqbcyWOCzo4pRZ6+wY8TyAKfVSYZ0o9kZ1jl6dOhNV
         gVi0FkKtRDJl4OkcqYkjSxLfW0SeLdS6FMm3kyf6ncQjwkHJIHzJjWoFNKydBrHPLfA2
         VN4A==
X-Forwarded-Encrypted: i=1; AFNElJ9nXU/p7RDLC9xSszp1TES8eXDLJrMOJK1pSJNen59JeReQ5IX0QUAw1S00TniL0JZIzkG4wSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUaXJ1jBkYP9QNibtkcw0s7g8SezkjVdDQn/wYM+jJ/xSQx5L
	caK9uGtNJiDHeQws6eM7ZNOcObf2WvRx/v0yOHHwgjWHhGUVdqCsoMaN
X-Gm-Gg: Acq92OGA04G6DyEKer8YdsHsZqczBgt7OUA9y6rCIqPcxU5f0dcLW7/kJTeVs/TP3i6
	1/1AG0OVdv0JCE3jLP2K/7XP2TPRdU5KnQUW4QQ9/dVGMUtGRfzTLWcMTzq0sKLEzbeboMoixSH
	6ppkgohCjX9l6+bU04GXFc6+kTV1nKNlZ0+shVZpP/WA5b+PmnygsqliXW3E1ng4W1bin0DvJBI
	3JFkyyEGnA3u1FHdkNht0ljKu9pHaYH4/Jdaf1Rvi461bRYp/5VaRUKE7dnNQ8gV8KUNu7uzdRQ
	TT8xt5+6kRmAe/Wsicl8UDfP03jeHxI5ve9RWQECi6Dr6sJNyfHnGHncwKAdvon7bhIezn3RKwj
	EfUb7C+S9+j+H0JjVu3J8NSnXha+7HOBkEjKTwd3dD3suRqFZ/wz/QKSr1WYDvyRzxKGZ8NkB76
	z4qC7W/1A+uIJEwGO5mMCOxVud7tR4AsdNr4MJDZALh6w=
X-Received: by 2002:a05:600c:a402:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-490426d1a91mr24483905e9.19.1779440613700;
        Fri, 22 May 2026 02:03:33 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm49820785e9.7.2026.05.22.02.03.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 May 2026 02:03:33 -0700 (PDT)
Date: Fri, 22 May 2026 11:03:28 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260522110328.0d3eecd8.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
	<20260502114644.76e6b5a3.michal.pecio@gmail.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
	<20260518083339.507e24bd.michal.pecio@gmail.com>
	<CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tdf+lakP77TA_BBXkiiy=wC"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253717-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D46075B0D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--MP_/tdf+lakP77TA_BBXkiiy=wC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 20 May 2026 01:59:41 -0300, Desnes Nunes wrote:
> On Mon, May 18, 2026 at 3:33=E2=80=AFAM Michal Pecio <michal.pecio@gmail.=
com> wrote:
> > > The chip IOMMU faults shortly after setting USBCMD.RUN =3D 1.
> > > Such fault is expected to cause HSE assertion and usually it does.
> > > You will probably find that HSE is already set while Enable Slot
> > > is being queued, even if it was clear in xhci_gen_setup(). =20
>=20
> I've just read HSE at these places and confirmed that HSE was already
> set even before queuing the enable slot trb, even though it was
> previously clear in xhci_gen_setup().

Makes sense, thanks for checking.

> The fault addresses do not appear in the main log, nor anywhere other
> than the DMAR fault addr messages in the crashkernel's log.
>=20
> However, by comparing the previous log messages from the past kernel,
> to the ones I saw with the new kernel I built today, I noticed the
> same 8K displacement from the fault addr. Maybe an iommu driver bug
> clue?

If the bug is deterministic it should be fairly easy to nail it down.
Attached xhci debugfs patch adds a list of almost all memory the xHC
is allowed to access, including (if I havevn't missed something) all
mappings it is allowed to access before any slots are enabled.

Please apply, reboot and then:

zip -r before.zip /sys/kernel/debug/usb/xhci/0000:80:14.0
# trigger crash kexec and the bug
zip -r after.zip /sys/kernel/debug/usb/xhci/0000:80:14.0

Note: if you need to use tar instead, copy the directory and then
archive the copy, because tar doesn't work on debugfs directly.

And since the bug may be an out of bounds access by the HW, if you
don't mind running slightly experimental patch to a critical subsystem,
please also apply the DMA guard pages patch. I've been using it for a
few months without issues, but YMMV. It helps determine which mapping
is accessed OOB.

Note: DMA guard pages may casue USB to stop working before kexec if
it's a HW bug masked by memory layout, or begin to work after kexec in
case of some IOMMU subsystem issues.

> PS: there was a big iommu PR a few days ago - all the results from on
> this email were performed with a recent 7.1.0-rc3 kernel checked out
> at 30e0ff6d6a83.

Well, so those IOMMU changes neither broke it nor fixed it.
Knowing xHCI I frankly suspect that the problem is here.

Regards,
Michal



--MP_/tdf+lakP77TA_BBXkiiy=wC
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xhci-debugfs-memory.patch

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index da528d07b815..b4f12013d487 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -779,6 +779,78 @@ static void xhci_debugfs_create_bandwidth(struct xhci_hcd *xhci,
 			  parent, &bw_fops);
 }
 
+static void list_ring_segments(struct seq_file *s, struct xhci_ring *ring)
+{
+	struct xhci_segment *seg;
+
+	xhci_for_each_ring_seg(ring->first_seg, seg)
+		seq_printf(s, "%.3x: %pad\n", seg->num, &seg->dma);
+}
+
+static void list_event_ring_segments(struct seq_file *s, struct xhci_interrupter *ir)
+{
+	struct xhci_segment *seg;
+
+	seq_printf(s, "IR%d ERST: %pad\n", ir->intr_num, &ir->erst.erst_dma_addr);
+	xhci_for_each_ring_seg(ir->event_ring->first_seg, seg)
+		seq_printf(s, "%.3x: %pad %c= %.16llx %.8x\n", seg->num, &seg->dma,
+				ir->erst.entries[seg->num].seg_addr == seg->dma ? '=' : '!',
+				ir->erst.entries[seg->num].seg_addr,
+				ir->erst.entries[seg->num].seg_size);
+	seq_putc(s, '\n');
+}
+
+static int xhci_memory_show(struct seq_file *s, void *unused)
+{
+	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
+	int			num_sp = HCS_MAX_SCRATCHPAD(xhci->hcs_params2);
+
+	if (!xhci)
+		return -EFAULT;
+
+	seq_puts(s, "CR:\n");
+	list_ring_segments(s, xhci->cmd_ring);
+	seq_putc(s, '\n');
+
+	for (int i = 0; i < 1; i++)
+		if (xhci->interrupters[i])
+			list_event_ring_segments(s, xhci->interrupters[i]);
+
+	seq_printf(s, "DCBAA: %pad\n", &xhci->dcbaa->dma);
+	for (int i = 0; i < MAX_HC_SLOTS; i++)
+		seq_printf(s, "%.3x: %pad\n", i, xhci->dcbaa->dev_context_ptrs + i);
+	seq_putc(s, '\n');
+
+	if (xhci->scratchpad) {
+		seq_printf(s, "SBA: %pad\n", &xhci->scratchpad->sp_dma);
+		for (int i = 0; i < num_sp; i++)
+			seq_printf(s, "%.3x: %pad\n", i, xhci->scratchpad->sp_array + i);
+		seq_putc(s, '\n');
+	}
+
+	for (int d = 1; d < MAX_HC_SLOTS; d++)
+		for (int e = 0; e < EP_CTX_PER_DEV; e++)
+			if (xhci->devs[d] && xhci->devs[d]->eps[e].ring) {
+				seq_printf(s, "DEV %d EP %d:\n", d, e);
+				list_ring_segments(s, xhci->devs[d]->eps[e].ring);
+				seq_putc(s, '\n');
+			}
+
+	return 0;
+}
+
+static int memory_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, xhci_memory_show, inode->i_private);
+}
+
+static const struct file_operations memory_fops = {
+	.open			= memory_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
 void xhci_debugfs_init(struct xhci_hcd *xhci)
 {
 	struct device		*dev = xhci_to_hcd(xhci)->self.controller;
@@ -831,6 +903,8 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
 	xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
 
 	xhci_debugfs_create_bandwidth(xhci, xhci->debugfs_root);
+
+	debugfs_create_file("memory", 0444, xhci->debugfs_root, xhci, &memory_fops);
 }
 
 void xhci_debugfs_exit(struct xhci_hcd *xhci)

--MP_/tdf+lakP77TA_BBXkiiy=wC
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dma-guard-pages.patch

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e847f16..41ff22748276 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -757,6 +757,17 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+static unsigned long size_to_iova_len(struct iova_domain *iovad, size_t size)
+{
+	size_t guard_size = 0;
+
+	/* allocate optional guard pages after the requested mapping */
+	if (1)
+		guard_size = iova_align(iovad, 1024 << 10);
+
+	return (size + guard_size) >> iova_shift(iovad);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
@@ -770,7 +781,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	}
 
 	shift = iova_shift(iovad);
-	iova_len = size >> shift;
+	iova_len = size_to_iova_len(iovad, size);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
@@ -807,17 +818,21 @@ static void iommu_dma_free_iova(struct iommu_domain *domain, dma_addr_t iova,
 				size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &domain->iova_cookie->iovad;
+	unsigned long iova_len;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI)
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI) {
 		domain->msi_cookie->msi_iova -= size;
-	else if (gather && gather->queued)
+		return;
+	}
+
+	iova_len = size_to_iova_len(iovad, size);
+
+	if (gather && gather->queued)
 		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad),
-				&gather->freelist);
+				iova_len, &gather->freelist);
 	else
-		free_iova_fast(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad));
+		free_iova_fast(iovad, iova_pfn(iovad, iova), iova_len);
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,

--MP_/tdf+lakP77TA_BBXkiiy=wC--

