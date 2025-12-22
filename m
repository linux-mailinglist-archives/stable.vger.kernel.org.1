Return-Path: <stable+bounces-203210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788ACD5CB3
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 12:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B7D301670E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C1313555;
	Mon, 22 Dec 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ANCqLoFS"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195711D432D
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402426; cv=none; b=H9qHUh0qkWQVVXFMm5sofr/9Ywp/Q05X4hsEWqb3mdO1++HF6uTjtzFSV5dtiQxEXYK9wLrrj1NYJm337b9tvHtag/FH/Itmbtuat586+stWB12iLRYUiHYw4czoQklz+0hLWm/CcGHyY+sUYW/AzQH/ZTfjA27559PoY2OJszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402426; c=relaxed/simple;
	bh=mHQthMzxJu3E+atsEgJQh4T/uxmRDuUn+84ljSm4FT0=;
	h=Subject:Mime-Version:To:References:Date:Message-Id:In-Reply-To:
	 From:Content-Type:Cc; b=mJ/NB8kMVaOztMLY0lfPKLov1RfZVxIHsFQpVZ9vxhzz6/eUCb9hH710I+ea0uaGrCQJY1eXvkW8tV3M+Il3QTdyXs2M78Tsof5SA4+WOYIx7Si+9H1Hu1A4bP/YCFlwjxukm4JPPetFLJMkZ9gu9+MNAB58P+03AC8zSsYEEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ANCqLoFS; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1766402410; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gzAcAzeaZxzdmZKFrZ4lKUOQGmGL9jeDaLQFRn4XriE=;
 b=ANCqLoFSx2z4KuqQ0/r6FGum5/NGTaxaoFMdo/ohNdBNb0pqvAZIYf2+OYGpLv3NXfg1Gj
 CfuWa6fs5Il5jL78qWiV+//tYZczkngnWNiT1PtVeVrMLFBR5A8SbLLf/u4wfUXpRbAfJC
 h6+rZ5ttoi9rpYhkENMpgDtS0HL6gRUeu0k6bxDHcMzsN7MxOE0FUYB3Bcmw0XrECwJZ4F
 eNb4jo95Qcnq4ynQRvD2RH4pQrnKvSN0T6852wYKJyfdAjAVgwmJPO6uf99CRV47jQbHL8
 y8Vf8/kxO2wQacYFNMkm7MJyIp+qe2vFIsXoFsBPm+/9re1n8yga934C+jnNdg==
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <kevin.tian@intel.com>
References: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Mon, 22 Dec 2025 19:19:35 +0800
Message-Id: <20251222111935.489-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+269492968+f90f92+vger.kernel.org+guojinhui.liam@bytedance.com>
In-Reply-To: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>, 
	<guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <will@kernel.org>

On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
> > From: Jinhui Guo <guojinhui.liam@bytedance.com>
> > Sent: Thursday, December 11, 2025 12:00 PM
> >=20
> > Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
> > request when device is disconnected") relies on
> > pci_dev_is_disconnected() to skip ATS invalidation for
> > safely-removed devices, but it does not cover link-down caused
> > by faults, which can still hard-lock the system.
>=20
> According to the commit msg it actually tries to fix the hard lockup
> with surprise removal. For safe removal the device is not removed
> before invalidation is done:
>=20
> "
>     For safe removal, device wouldn't be removed until the whole software
>     handling process is done, it wouldn't trigger the hard lock up issue
>     caused by too long ATS Invalidation timeout wait.
> "
>=20
> Can you help articulate the problem especially about the part
> 'link-down caused by faults"? What are those faults? How are
> they different from the said surprise removal in the commit
> msg to not set pci_dev_is_disconnected()?
>=20

Hi, kevin, sorry for the delayed reply.

A normal or surprise removal of a PCIe device on a hot-plug port normally
triggers an interrupt from the PCIe switch.

We have, however, observed cases where no interrupt is generated when the
device suddenly loses its link; the behaviour is identical to setting the
Link Disable bit in the switch=E2=80=99s Link Control register (offset 10h)=
. Exactly
what goes wrong in the LTSSM between the PCIe switch and the endpoint remai=
ns
unknown.

> >=20
> > For example, if a VM fails to connect to the PCIe device,
>=20
> 'failed' for what reason?
>=20
> > "virsh destroy" is executed to release resources and isolate
> > the fault, but a hard-lockup occurs while releasing the group fd.
> >=20
> > Call Trace:
> >  qi_submit_sync
> >  qi_flush_dev_iotlb
> >  intel_pasid_tear_down_entry
> >  device_block_translation
> >  blocking_domain_attach_dev
> >  __iommu_attach_device
> >  __iommu_device_set_domain
> >  __iommu_group_set_domain_internal
> >  iommu_detach_group
> >  vfio_iommu_type1_detach_group
> >  vfio_group_detach_container
> >  vfio_group_fops_release
> >  __fput
> >=20
> > Although pci_device_is_present() is slower than
> > pci_dev_is_disconnected(), it still takes only ~70 =C2=B5s on a
> > ConnectX-5 (8 GT/s, x2) and becomes even faster as PCIe speed
> > and width increase.
> >=20
> > Besides, devtlb_invalidation_with_pasid() is called only in the
> > paths below, which are far less frequent than memory map/unmap.
> >=20
> > 1. mm-struct release
> > 2. {attach,release}_dev
> > 3. set/remove PASID
> > 4. dirty-tracking setup
> >=20
>=20
> surprise removal can happen at any time, e.g. after the check of
> pci_device_is_present(). In the end we need the logic in
> qi_check_fault() to check the presence upon ITE timeout error
> received to break the infinite loop. So in your case even with
> that logici in place you still observe lockup (probably due to
> hardware ITE timeout is longer than the lockup detection on=20
> the CPU?

Are you referring to the timeout added in patch
https://lore.kernel.org/all/20240222090251.2849702-4-haifeng.zhao@linux.int=
el.com/ ?

Our lockup-detection timeout is the default 10 s.

We see ITE-timeout messages in the kernel log. Yet the system still
hard-locks=E2=80=94probably because, as you mentioned, the hardware ITE tim=
eout
is longer than the CPU=E2=80=99s lockup-detection window. I=E2=80=99ll repr=
oduce the
case and follow up with a deeper analysis.

kernel: [ 2402.642685][  T607] vfio-pci 0000:3f:00.0: Unable to change powe=
r state from D0 to D3hot, device inaccessible
kernel: [ 2403.441828][T49880] DMAR: VT-d detected Invalidation Time-out Er=
ror: SID 0
kernel: [ 2403.441830][    C0] DMAR: DRHD: handling fault status reg 40
kernel: [ 2403.441831][T49880] DMAR: QI HEAD: Invalidation Wait qw0 =3D 0x2=
00000025, qw1 =3D 0x1003a07fc
kernel: [ 2403.441833][T49880] DMAR: QI PRIOR: Invalidation Wait qw0 =3D 0x=
200000025, qw1 =3D 0x1003a07f8
kernel: [ 2403.441879][T49880] DMAR: Invalidation Time-out Error (ITE) clea=
red
kernel: [ 2423.643527][    C7] rcu: INFO: rcu_preempt detected stalls on CP=
Us/tasks:
kernel: [ 2423.643551][    C7] rcu:        8-...0: (0 ticks this GP) idle=
=3D198c/1/0x4000000000000000 softirq=3D19450/19450 fqs=3D4403
kernel: [ 2423.643567][    C7] rcu:        (detected by 7, t=3D21002 jiffie=
s, g=3D238909, q=3D4932 ncpus=3D96)
kernel: [ 2423.643578][    C7] Sending NMI from CPU 7 to CPUs 8:
kernel: [ 2423.643581][    C8] NMI backtrace for cpu 8
kernel: [ 2423.643585][    C8] CPU: 8 UID: 0 PID: 49880 Comm: vfio_test Kdu=
mp: loaded Tainted: G S          E       6.18.0 #5 PREEMPT(voluntary)
kernel: [ 2423.643588][    C8] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGN=
ED_MODULE
kernel: [ 2423.643589][    C8] Hardware name: Inspur NF5468M5/YZMB-01130-10=
5, BIOS 4.2.0 04/28/2021
kernel: [ 2423.643590][    C8] RIP: 0010:qi_submit_sync+0x6cf/0x8d0
kernel: [ 2423.643597][    C8] Code: 89 4c 24 50 89 70 34 48 c7 c7 f0 f5 4a=
 a5 e8 48 15 89 ff 48 8b 4c 24 50 8b 54 24 58 49 8b 76 10 49 63 c7 48 8d 04=
 86 83 38 01 <75> 06 c7 00 03 00 00 00 41 81 c7 fe 00 00 00 44 89 f8 c1 f8 =
1f c1
kernel: [ 2423.643598][    C8] RSP: 0018:ffffb5a3bd0a7a30 EFLAGS: 00000097
kernel: [ 2423.643600][    C8] RAX: ffff9dac803a06bc RBX: 0000000000000000 =
RCX: 0000000000000000
kernel: [ 2423.643601][    C8] RDX: 00000000000000fe RSI: ffff9dac803a0400 =
RDI: ffff9ddb0081d480
kernel: [ 2423.643602][    C8] RBP: ffff9dac8037fe00 R08: 0000000000000000 =
R09: 0000000000000003
kernel: [ 2423.643603][    C8] R10: ffffb5a3bd0a78e0 R11: ffff9e0bbff3c068 =
R12: 0000000000000040
kernel: [ 2423.643605][    C8] R13: ffff9dac80314600 R14: ffff9dac8037fe00 =
R15: 00000000000000af
kernel: [ 2423.643606][    C8] FS:  0000000000000000(0000) GS:ffff9ddb5a262=
000(0000) knlGS:0000000000000000
kernel: [ 2423.643607][    C8] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
kernel: [ 2423.643608][    C8] CR2: 000000002aee3000 CR3: 000000024a27b002 =
CR4: 00000000007726f0
kernel: [ 2423.643610][    C8] PKRU: 55555554
kernel: [ 2423.643611][    C8] Call Trace:
kernel: [ 2423.643613][    C8]  <TASK>
kernel: [ 2423.643616][    C8]  ? __pfx_domain_context_clear_one_cb+0x10/0x=
10
kernel: [ 2423.643620][    C8]  qi_flush_dev_iotlb+0xd5/0xe0
kernel: [ 2423.643622][    C8]  __context_flush_dev_iotlb.part.0+0x3c/0x80
kernel: [ 2423.643625][    C8]  domain_context_clear_one_cb+0x16/0x20
kernel: [ 2423.643626][    C8]  pci_for_each_dma_alias+0x3b/0x140
kernel: [ 2423.643631][    C8]  device_block_translation+0x122/0x180
kernel: [ 2423.643634][    C8]  blocking_domain_attach_dev+0x39/0x50
kernel: [ 2423.643636][    C8]  __iommu_attach_device+0x1b/0x90
kernel: [ 2423.643639][    C8]  __iommu_device_set_domain+0x5d/0xb0
kernel: [ 2423.643642][    C8]  __iommu_group_set_domain_internal+0x60/0x11=
0
kernel: [ 2423.643644][    C8]  iommu_detach_group+0x3a/0x60
kernel: [ 2423.643650][    C8]  vfio_iommu_type1_detach_group+0x106/0x610 [=
vfio_iommu_type1]
kernel: [ 2423.643654][    C8]  ? __dentry_kill+0x12a/0x180
kernel: [ 2423.643660][    C8]  ? __pm_runtime_idle+0x44/0xe0
kernel: [ 2423.643666][    C8]  vfio_group_detach_container+0x4f/0x160 [vfi=
o]
kernel: [ 2423.643672][    C8]  vfio_group_fops_release+0x3e/0x80 [vfio]
kernel: [ 2423.643677][    C8]  __fput+0xe6/0x2b0
kernel: [ 2423.643682][    C8]  task_work_run+0x58/0x90
kernel: [ 2423.643688][    C8]  do_exit+0x29b/0xa80
kernel: [ 2423.643694][    C8]  do_group_exit+0x2c/0x80
kernel: [ 2423.643696][    C8]  get_signal+0x8f9/0x900
kernel: [ 2423.643700][    C8]  arch_do_signal_or_restart+0x29/0x210
kernel: [ 2423.643704][    C8]  ? __schedule+0x582/0xe80
kernel: [ 2423.643708][    C8]  exit_to_user_mode_loop+0x8e/0x4f0
kernel: [ 2423.643712][    C8]  do_syscall_64+0x262/0x630
kernel: [ 2423.643717][    C8]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: [ 2423.643720][    C8] RIP: 0033:0x7fde19078514
kernel: [ 2423.643722][    C8] Code: Unable to access opcode bytes at 0x7fd=
e190784ea.
kernel: [ 2423.643723][    C8] RSP: 002b:00007ffd0e1dc7e8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000022
kernel: [ 2423.643724][    C8] RAX: fffffffffffffdfe RBX: 0000000000000000 =
RCX: 00007fde19078514
kernel: [ 2423.643726][    C8] RDX: 00007fde1916e8c0 RSI: 000055b217303260 =
RDI: 0000000000000000
kernel: [ 2423.643727][    C8] RBP: 00007ffd0e1dc8a0 R08: 00007fde19173500 =
R09: 0000000000000000
kernel: [ 2423.643728][    C8] R10: fffffffffffffbea R11: 0000000000000246 =
R12: 000055b1f8d8d0b0
kernel: [ 2423.643729][    C8] R13: 00007ffd0e1dc980 R14: 0000000000000000 =
R15: 0000000000000000
kernel: [ 2423.643731][    C8]  </TASK>
kernel: [ 2424.375254][T81463] vfio-pci 0000:3f:00.0: Unable to change powe=
r state from D3cold to D0, device inaccessible
...
kernel: [ 2448.327929][    C8] watchdog: CPU8: Watchdog detected hard LOCKU=
P on cpu 8
kernel: [ 2448.327932][    C8] Modules linked in: vfio_pci(E) vfio_pci_core=
(E) vfio_iommu_type1(E) vfio(E) udp_diag(E) tcp_diag(E) inet_diag(E) binfmt=
_misc(E) ip_set_hash_net(E) nft_compat(E) x_tables(E) ip_set(E) msr(E) nf_t=
ables(E) ...
kernel: [ 2448.327963][    C8]  ib_core(E) hid_generic(E) usbhid(E) hid(E) =
ahci(E) libahci(E) xhci_pci(E) libata(E) nvme(E) xhci_hcd(E) i2c_i801(E) nv=
me_core(E) usbcore(E) scsi_mod(E) mlx5_core(E) i2c_smbus(E) lpc_ich(E) usb_=
common(E) scsi_common(E) wmi(E)
kernel: [ 2448.327972][    C8] CPU: 8 UID: 0 PID: 49880 Comm: vfio_test Kdu=
mp: loaded Tainted: G S          EL      6.18.0 #5 PREEMPT(voluntary)
kernel: [ 2448.327975][    C8] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGN=
ED_MODULE, [L]=3DSOFTLOCKUP
kernel: [ 2448.327976][    C8] Hardware name: Inspur NF5468M5/YZMB-01130-10=
5, BIOS 4.2.0 04/28/2021
kernel: [ 2448.327977][    C8] RIP: 0010:qi_submit_sync+0x6e7/0x8d0
kernel: [ 2448.327981][    C8] Code: 8b 54 24 58 49 8b 76 10 49 63 c7 48 8d=
 04 86 83 38 01 75 06 c7 00 03 00 00 00 41 81 c7 fe 00 00 00 44 89 f8 c1 f8=
 1f c1 e8 18 <41> 01 c7 45 0f b6 ff 41 29 c7 44 39 fa 75 cb 48 85 c9 0f 85 =
05 01
kernel: [ 2448.327983][    C8] RSP: 0018:ffffb5a3bd0a7a30 EFLAGS: 00000046
kernel: [ 2448.327984][    C8] RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
kernel: [ 2448.327985][    C8] RDX: 00000000000000fe RSI: ffff9dac803a0400 =
RDI: ffff9ddb0081d480
kernel: [ 2448.327986][    C8] RBP: ffff9dac8037fe00 R08: 0000000000000000 =
R09: 0000000000000003
kernel: [ 2448.327987][    C8] R10: ffffb5a3bd0a78e0 R11: ffff9e0bbff3c068 =
R12: 0000000000000040
kernel: [ 2448.327988][    C8] R13: ffff9dac80314600 R14: ffff9dac8037fe00 =
R15: 00000000000001b3
kernel: [ 2448.327989][    C8] FS:  0000000000000000(0000) GS:ffff9ddb5a262=
000(0000) knlGS:0000000000000000
kernel: [ 2448.327990][    C8] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
kernel: [ 2448.327991][    C8] CR2: 000000002aee3000 CR3: 000000024a27b002 =
CR4: 00000000007726f0
kernel: [ 2448.327992][    C8] PKRU: 55555554
kernel: [ 2448.327993][    C8] Call Trace:
kernel: [ 2448.327995][    C8]  <TASK>
kernel: [ 2448.327997][    C8]  ? __pfx_domain_context_clear_one_cb+0x10/0x=
10
kernel: [ 2448.328000][    C8]  qi_flush_dev_iotlb+0xd5/0xe0
kernel: [ 2448.328002][    C8]  __context_flush_dev_iotlb.part.0+0x3c/0x80
kernel: [ 2448.328004][    C8]  domain_context_clear_one_cb+0x16/0x20
kernel: [ 2448.328006][    C8]  pci_for_each_dma_alias+0x3b/0x140
kernel: [ 2448.328010][    C8]  device_block_translation+0x122/0x180
kernel: [ 2448.328012][    C8]  blocking_domain_attach_dev+0x39/0x50
kernel: [ 2448.328014][    C8]  __iommu_attach_device+0x1b/0x90
kernel: [ 2448.328017][    C8]  __iommu_device_set_domain+0x5d/0xb0
kernel: [ 2448.328019][    C8]  __iommu_group_set_domain_internal+0x60/0x11=
0
kernel: [ 2448.328021][    C8]  iommu_detach_group+0x3a/0x60
kernel: [ 2448.328023][    C8]  vfio_iommu_type1_detach_group+0x106/0x610 [=
vfio_iommu_type1]
kernel: [ 2448.328026][    C8]  ? __dentry_kill+0x12a/0x180
kernel: [ 2448.328030][    C8]  ? __pm_runtime_idle+0x44/0xe0
kernel: [ 2448.328035][    C8]  vfio_group_detach_container+0x4f/0x160 [vfi=
o]
kernel: [ 2448.328041][    C8]  vfio_group_fops_release+0x3e/0x80 [vfio]
kernel: [ 2448.328046][    C8]  __fput+0xe6/0x2b0
kernel: [ 2448.328049][    C8]  task_work_run+0x58/0x90
kernel: [ 2448.328053][    C8]  do_exit+0x29b/0xa80
kernel: [ 2448.328057][    C8]  do_group_exit+0x2c/0x80
kernel: [ 2448.328060][    C8]  get_signal+0x8f9/0x900
kernel: [ 2448.328064][    C8]  arch_do_signal_or_restart+0x29/0x210
kernel: [ 2448.328068][    C8]  ? __schedule+0x582/0xe80
kernel: [ 2448.328070][    C8]  exit_to_user_mode_loop+0x8e/0x4f0
kernel: [ 2448.328074][    C8]  do_syscall_64+0x262/0x630
kernel: [ 2448.328076][    C8]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: [ 2448.328078][    C8] RIP: 0033:0x7fde19078514
kernel: [ 2448.328080][    C8] Code: Unable to access opcode bytes at 0x7fd=
e190784ea.
kernel: [ 2448.328081][    C8] RSP: 002b:00007ffd0e1dc7e8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000022
kernel: [ 2448.328082][    C8] RAX: fffffffffffffdfe RBX: 0000000000000000 =
RCX: 00007fde19078514
kernel: [ 2448.328083][    C8] RDX: 00007fde1916e8c0 RSI: 000055b217303260 =
RDI: 0000000000000000
kernel: [ 2448.328085][    C8] RBP: 00007ffd0e1dc8a0 R08: 00007fde19173500 =
R09: 0000000000000000
kernel: [ 2448.328085][    C8] R10: fffffffffffffbea R11: 0000000000000246 =
R12: 000055b1f8d8d0b0
kernel: [ 2448.328086][    C8] R13: 00007ffd0e1dc980 R14: 0000000000000000 =
R15: 0000000000000000
kernel: [ 2448.328088][    C8]  </TASK>
kernel: [ 2450.245901][    C7] watchdog: BUG: soft lockup - CPU#7 stuck for=
 41s! [mongoosev3-agen:4727]

>=20
> In any case this change cannot 100% fix the lockup. It just
> reduces the possibility which should be made clear.

I agree with the above, but it's better to cover more corner cases.

Best Regards,
Jinhui

