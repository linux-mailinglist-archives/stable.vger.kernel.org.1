Return-Path: <stable+bounces-247387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIyUFrO0BmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:52:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16103549C41
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89B453030D0C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67A349AEC;
	Fri, 15 May 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0F6kMaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D772FDC30
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824368; cv=none; b=dy9u5G0As2G4p4v7Iv7kJMIkA3WRh1yxrsB8hR3PONMMirxljInjS9MYOs8YXX8upOqI3JZQmCsZx3pnoUIUJjFupzEbZYAqVYCEH5DVoCSi7+pLTnz1uWey9jV1MsWJZ/8UIWcI2+qElH+CDFmHA7OrPhfFwF2I/v+1gzmX7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824368; c=relaxed/simple;
	bh=7xN9toEelBOOry+zmlOv5ue+mDLGjG52OVWGwM2TCyc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GiNQAKF9FHEYURC+A1BRmbXkdYY8ItYIcsdtcrRudQkqkv1t4vRuCtNjDVoaSv1gINLc0VQHSfbnLyKXypqsX7PswMsvHKXmw9X3Q3UqvrA76ML62+mfFeazM0aJP9+m1eLiwneQ06kv2u9xTj/yRXWY17z1sFoeIblo+ACxDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0F6kMaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA51C2BCB0;
	Fri, 15 May 2026 05:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778824367;
	bh=7xN9toEelBOOry+zmlOv5ue+mDLGjG52OVWGwM2TCyc=;
	h=Subject:To:Cc:From:Date:From;
	b=j0F6kMafufsMYehtSFkACQyQKkJNb9WwJOnHkCoaZDx6Lolt6fu5dlhZGhW6sahCf
	 qW8GElehCaxLzVmdWpCr68XaQ5Su4s4xmiBV61ex33ar61Ev4OUTphe5VEKm9umo7I
	 4M7qQV8mvOOZxUW5Io1Kh3PdVfq+H69rO3sAx9W8=
Subject: FAILED: patch "[PATCH] media: videobuf2: Set vma_flags in vb2_dma_sg_mmap" failed to apply to 6.1-stable tree
To: j@jannau.net,hverkuil+cisco@kernel.org,m.szyprowski@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:52:52 +0200
Message-ID: <2026051552-hence-yoga-0f39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16103549C41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247387-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,jannau.net:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7254b31a13aaa0c2c0f9ffbc335b718656117ff4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051552-hence-yoga-0f39@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7254b31a13aaa0c2c0f9ffbc335b718656117ff4 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Sun, 15 Feb 2026 18:42:59 +0100
Subject: [PATCH] media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

vb2_dma_contig sets VMA flags VM_DONTEXPAND and VM_DONTDUMP and I do not
see a reason why vb2_dma_sg should behave differently. This avoids
hitting `WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));` in
drm_gem_mmap_obj() during mmap() of an imported dma-buf from the out of
tree Apple ISP camera capture driver which uses vb2_dma_sg_memops.

gst-launch-1.0 v4l2src ! gtk4paintablesink

[   38.201528] ------------[ cut here ]------------
[   38.202135] WARNING: CPU: 7 PID: 2362 at drivers/gpu/drm/drm_gem.c:1144 drm_gem_mmap_obj+0x1f8/0x210
[   38.203278] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer
snd_seq snd_seq_device uinput nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr bnep
nls_ascii i2c_dev loop fuse dm_multipath nfnetlink brcmfmac_wcc
hid_magicmouse hci_bcm4377 brcmfmac brcmutil bluetooth ecdh_generic
cfg80211 ecc btrfs xor xor_neon rfkill hid_apple raid6_pq joydev
aop_als apple_nvmem_spmi industrialio snd_soc_aop apple_z2
snd_soc_cs42l84 tps6598x snd_soc_tas2764 macsmc_reboot spi_nor
macsmc_hwmon rtc_macsmc gpio_macsmc macsmc_power regmap_spmi
macsmc_input dockchannel_hid panel_summit appledrm nvme_apple dwc3
snd_soc_macaudio drm_client_lib nvme_core phy_apple_atc hwmon
apple_sart apple_dockchannel macsmc apple_rtkit_helper
spmi_apple_controller aop apple_wdt mfd_core nvmem_apple_efuses
pinctrl_apple_gpio apple_isp apple_dcp videobuf2_dma_sg mux_core
spi_apple
[   38.203300]  videobuf2_memops i2c_pasemi_platform snd_soc_apple_mca videobuf2_v4l2 videodev clk_apple_nco videobuf2_common snd_pcm_dmaengine adpdrm asahi apple_admac adpdrm_mipi drm_dma_helper pwm_apple i2c_pasemi_core drm_display_helper mc cec apple_dart ofpart apple_soc_cpufreq leds_pwm phram
[   38.217677] CPU: 7 UID: 1000 PID: 2362 Comm: gst-launch-1.0 Tainted: G        W           6.17.6+ #asahi-dev PREEMPT(full)
[   38.219040] Tainted: [W]=WARN
[   38.219398] Hardware name: Apple MacBook Pro (13-inch, M2, 2022) (DT)
[   38.220213] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   38.221088] pc : drm_gem_mmap_obj+0x1f8/0x210
[   38.221643] lr : drm_gem_mmap_obj+0x78/0x210
[   38.222178] sp : ffffc0008dc678e0
[   38.222579] x29: ffffc0008dc678e0 x28: 0000000000042a97 x27: ffff8000b701b480
[   38.223465] x26: 00000000000000fb x25: ffffc0008dc67d20 x24: ffffc0008dc67968
[   38.224402] x23: ffff8000e3ca5600 x22: ffff8000265b7800 x21: ffff80003000c0c0
[   38.225279] x20: 0000000000000000 x19: ffff8000b68c5200 x18: ffffc0008dc67968
[   38.226151] x17: 0000000000000000 x16: 0000000000000000 x15: ffffc000810a30a8
[   38.227042] x14: 00007fff637effff x13: 00005555de91ffff x12: 00007fff63293fff
[   38.227942] x11: 0000000000000000 x10: ffff8000184ecf08 x9 : ffffc0007a1900c8
[   38.228824] x8 : ffffc0008dc67968 x7 : 0000000000000012 x6 : ffffc0015cf1c000
[   38.229703] x5 : ffffc0008dc676a0 x4 : ffffc00081a27dc0 x3 : 0000000000000038
[   38.230607] x2 : 0000000000000003 x1 : 0000000000000003 x0 : 00000000100000fb
[   38.231488] Call trace:
[   38.231806]  drm_gem_mmap_obj+0x1f8/0x210 (P)
[   38.232342]  drm_gem_mmap+0x140/0x260
[   38.232813]  __mmap_region+0x488/0x9a0
[   38.233277]  mmap_region+0xd0/0x148
[   38.233703]  do_mmap+0x350/0x5c0
[   38.234148]  vm_mmap_pgoff+0x14c/0x200
[   38.234612]  ksys_mmap_pgoff+0x150/0x208
[   38.235107]  __arm64_sys_mmap+0x34/0x50
[   38.235611]  invoke_syscall+0x50/0x120
[   38.236075]  el0_svc_common.constprop.0+0x48/0xf0
[   38.236680]  do_el0_svc+0x24/0x38
[   38.237113]  el0_svc+0x38/0x168
[   38.237507]  el0t_64_sync_handler+0xa0/0xe8
[   38.238034]  el0t_64_sync+0x198/0x1a0
[   38.238491] ---[ end trace 0000000000000000 ]---

There were discussions in [1] at the end of 2023 that mmap() on imported
dma-bufs should not be supported but as of v6.17 drm_gem_shmem_mmap() in
drm_gem_shmem_helper.c still supports it.
This might affect all gpu or accel drivers using drm_gem_shmem_mmap() or
the wrapper drm_gem_shmem_object_mmap().

[1] https://lore.kernel.org/dri-devel/bc7f7844-0aa3-4802-b203-69d58e8be2fa@linux.intel.com/

Cc: stable@vger.kernel.org
Fixes: 5ba3f757f059 ("[media] v4l: videobuf2: add DMA scatter/gather allocator")
Signed-off-by: Janne Grunau <j@jannau.net>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 982021d547e5..b1d0695cda26 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -345,6 +345,7 @@ static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
 		return err;
 	}
 
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	/*
 	 * Use common vm_area operations to track buffer refcount.
 	 */


