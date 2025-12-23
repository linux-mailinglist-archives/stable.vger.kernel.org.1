Return-Path: <stable+bounces-203314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93867CD9B96
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FACC3002506
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22496283FDD;
	Tue, 23 Dec 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SteLA8kJ"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8227280CE5
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501939; cv=none; b=WXFZlnFql76t/7wya3tsATFPiSgdcKVAyvwDvyvOH4IVrqO8XLAmYutwzdqognnVnhU8dpiyzoQpsKZS492DSsY5WeYZERrp+ENyo8Ikah4mlqkmh/ARaprof34q81UiJc0jRr1934NZuTBZXG1p1jUSfpCj1ot8rtCSETojiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501939; c=relaxed/simple;
	bh=Zac3x4zScRUewYiacrN2sa7Cxn/nvL6JcXLym5Un8sE=;
	h=To:From:Mime-Version:References:Subject:In-Reply-To:Content-Type:
	 Date:Cc:Message-Id; b=ktm6Y5CKVj37i3MXbwz3kl9r6UvpZGsexm9jLSRo/VuGbdoo8JjtnQ5zN2ourd7wV5hSht3gLbF5h0Pvy+n8RApbYIJh4KYmV6tRm0v0VDOvpWgPQ9wKtKQwdOyQylpcjOBljDY8yjyxpfMaa8L5G9fah25V+ae1AoLKUv1xedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SteLA8kJ; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1766501925; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=C3IadwNijnYTZBNHU2+TLQDdoJ16wgHLMRHBgOVXA0Q=;
 b=SteLA8kJ1v6GPzgjcUseuUaY6dZA2Y8XELXGp1Xl/m6njoiIF4hSJQNNY9I3ZzhWA7VpYx
 WZ9KGZ6667acOByz+W8DPA5+Pl1EKQha6ZfGyESMyPdk56oIDSTs/J4OY48LrQ+RFzm0KC
 vt0Ph/kXWYCLP3Ss418DlcWXmDM2Iib0LqAWaqqFLHQJCahAKYSNOKtYCPk7XWkYH48bjk
 6mmACKHwV25uCxNmMp/sl+OtVeoOes0Wc+P2VvWy2/8QPQcc8B09RTTPavz4VyPs9wJblx
 D3m2qHZwgNBRsY8zBMrw5gQ+eZG9K85iBJkUcP5L9QP+2dw5kpQlgoGE9VWLuQ==
To: <baolu.lu@linux.intel.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
References: <aa1eda8a-4463-467a-b157-c6155882f293@linux.intel.com>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
X-Lms-Return-Path: <lba+2694aae23+127c85+vger.kernel.org+guojinhui.liam@bytedance.com>
In-Reply-To: <aa1eda8a-4463-467a-b157-c6155882f293@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Dec 2025 22:58:30 +0800
Content-Transfer-Encoding: quoted-printable
Cc: <bhelgaas@google.com>, <dwmw2@infradead.org>, 
	<guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <kevin.tian@intel.com>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	<will@kernel.org>
Message-Id: <20251223145830.644-1-guojinhui.liam@bytedance.com>

On Tue, Dec 23, 2025 12:06:24 +0800, Baolu Lu wrote:
> > On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
> >>> From: Jinhui Guo<guojinhui.liam@bytedance.com>
> >>> Sent: Thursday, December 11, 2025 12:00 PM
> >>>
> >>> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
> >>> request when device is disconnected") relies on
> >>> pci_dev_is_disconnected() to skip ATS invalidation for
> >>> safely-removed devices, but it does not cover link-down caused
> >>> by faults, which can still hard-lock the system.
> >> According to the commit msg it actually tries to fix the hard lockup
> >> with surprise removal. For safe removal the device is not removed
> >> before invalidation is done:
> >>
> >> "
> >>      For safe removal, device wouldn't be removed until the whole soft=
ware
> >>      handling process is done, it wouldn't trigger the hard lock up is=
sue
> >>      caused by too long ATS Invalidation timeout wait.
> >> "
> >>
> >> Can you help articulate the problem especially about the part
> >> 'link-down caused by faults"? What are those faults? How are
> >> they different from the said surprise removal in the commit
> >> msg to not set pci_dev_is_disconnected()?
> >>
> > Hi, kevin, sorry for the delayed reply.
> >=20
> > A normal or surprise removal of a PCIe device on a hot-plug port normal=
ly
> > triggers an interrupt from the PCIe switch.
> >=20
> > We have, however, observed cases where no interrupt is generated when t=
he
> > device suddenly loses its link; the behaviour is identical to setting t=
he
> > Link Disable bit in the switch=E2=80=99s Link Control register (offset =
10h). Exactly
> > what goes wrong in the LTSSM between the PCIe switch and the endpoint r=
emains
> > unknown.
>=20
> In this scenario, the hardware has effectively vanished, yet the device
> driver remains bound and the IOMMU resources haven't been released. I=E2=
=80=99m
> just curious if this stale state could trigger issues in other places
> before the kernel fully realizes the device is gone? I=E2=80=99m not obje=
cting
> to the fix. I'm just interested in whether this 'zombie' state creates
> risks elsewhere.

Hi, Baolu

In our scenario we see no other issues; a hard-LOCKUP panic is triggered th=
e
moment the Mellanox Ethernet device vanishes. But we can analyze what happe=
ns
when we access the Mellanox Ethernet device whose link is disabled.
(If we check whether the PCIe endpoint device (Mellanox Ethernet) is presen=
t
before issuing device-IOTLB invalidation to the Intel IOMMU, no other issue=
s
appear.)

According to the PCIe spec, Rev. 5.0 v1.0, Sec. 2.4.1, there are two kinds =
of
TLPs: posted and non-posted. Non-posted TLPs require a completion TLP; post=
ed
TLPs do not.

- A Posted Request is a Memory Write Request or a Message Request.
- A Read Request is a Configuration Read Request, an I/O Read Request, or a
  Memory Read Request.
- An NPR (Non-Posted Request) with Data is a Configuration Write Request, a=
n
  I/O Write Request, or an AtomicOp Request.
- A Non-Posted Request is a Read Request or an NPR with Data.

When the CPU issues a PCIe memory-write TLP (posted) via a MOV instruction,
the instruction retires immediately after the packet reaches the Root Compl=
ex;
no Data-Link ACK/NAK is required. A memory-read TLP (non-posted), however, =
stalls
the core until the corresponding Completion TLP is received - if that Compl=
etion
never arrives, the CPU hangs. (The CPU hangs if the LTSSM does not enter th=
e
Disabled state.)

However, if the LTSSM enters the Disabled state, the Root Port returns
Completer-Abort (CA) for any non-posted TLP, so the request completes with =
status
0xFFFFFFFF without stalling.

I ran some tests on the machine after setting the Link Disable bit in the s=
witch=E2=80=99s
Link Control register (offset 10h).
- setpci -s 0000:3c:08.0 CAP_EXP+10.w=3D0x0010

 +-[0000:3a]-+-00.0-[3b-3f]----00.0-[3c-3f]--+-00.0-[3d]----
 |           |                               +-04.0-[3e]----
 |           |                               \-08.0-[3f]----00.0  Mellanox =
Technologies MT27800 Family [ConnectX-5]

 # lspci -vvv -s 0000:3f:00.0
 3f:00.0 Ethernet controller: Mellanox Technologies MT27800 Family [Connect=
X-5]
 ...
         Region 0: Memory at 3af804000000 (64-bit, prefetchable) [size=3D32=
M]
 ...

1) Issue a PCI config-space read request and it returns 0xFFFFFFFF.
 # lspci -vvv -s 0000:3f:00.0
 3f:00.0 Ethernet controller: Mellanox Technologies MT27800 Family [Connect=
X-5] (rev ff) (prog-if ff)
         !!! Unknown header type 7f
         Kernel driver in use: mlx5_core
         Kernel modules: mlx5_core

2) Issuing a PCI memory read request through /dev/mem also returns 0xFFFFFF=
FF.
 # ./devmem
 Usage: ./devmem <phys_addr> <size> <offset> [value]
   phys_addr : physical base address of the BAR (hex or decimal)
   size      : mapping length in bytes (hex or decimal)
   offset    : register offset from BAR base (hex or decimal)
   value     : optional 32-bit value to write (hex or decimal)
 Example: ./devmem 0x600000000 0x1000 0x0 0xDEADBEEF
 # ./devmem 0x3af804000000 0x2000000 0x0
 0x3af804000000 =3D 0xffffffff

 Before the link was disabled, we could read 0x3af804000000 with devmem and
 obtain a valid result.
 # ./devmem 0x3af804000000 0x2000000 0x0
 0x3af804000000 =3D 0x10002300

Besides, after searching the kernel code, I found many EP drivers already c=
heck
whether their endpoint is still present. There may be exception cases in so=
me
PCIe endpoint drivers, such as commit 43bb40c5b926 ("virtio_pci: Support su=
rprise
removal of virtio pci device").

Best Regards,
Jinhui

