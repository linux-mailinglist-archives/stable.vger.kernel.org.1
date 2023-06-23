Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13AF73B0DF
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFWGre (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 02:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWGrd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 02:47:33 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9CE52
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 23:47:31 -0700 (PDT)
Date:   Fri, 23 Jun 2023 06:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1687502846; x=1687762046;
        bh=NjBF+7pqqYe64aAO0fArWosp/b7tBdc/NMgwZtdnJZ0=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=M7SzMhdGZtS8j0dmc2obDweSL82WG3qi4m7ku7vuMSYxvNLQUnQ68yW01DXtAHP8O
         n8FDjMgOLxwfsr1wRxRHuJmjDfA/CoQuph73bwUa3aPFG+K8I1/Rq7kHY1Lx160dOw
         fjuPl09qpgrSt3hYjVW4zhhuGzE88omAVCZL5Hw8=
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        stable@vger.kernel.org
From:   Thomas Backlund <tmb@tmb.nu>
Subject: Re: [6.3.y 6.1.y 5.15.y] drm/amd/display: fix the system hang while disable PSR
Message-ID: <b7a277fc-a60e-6de4-72c4-59aaeb1600e0@tmb.nu>
Feedback-ID: 19711308:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Den 2023-06-20 kl. 00:16, skrev Limonciello, Mario:
> Hi,
>=20
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")=
=20
> was tagged for stable, but failed to apply to 6.3.y, 6.1.y and 5.15.y.
>=20
> I've looked into the missing dependencies, and here are the dependencies=
=20
> needed for the stable backport:
>=20
> 5.15.y:
> -------
> 97ca308925a5 ("drm/amd/display: Add minimal pipe split transition state")
> f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
> 81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream=20
> update")
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
>=20
> 6.1.y / 6.3.y
> -------------
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
> f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
> 81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream=20
> update")
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
>=20

Is there something missing in that series ?

We get a  report of those patches on top of 6.3.9 failing on AMD STONEY=20
(0x1002:0x98E4 0x1043:0x1FE0 0xEA) with:

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 1248 at=20
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:393=20
dce_aux_transfer_raw+0x731/0x760 [amdgpu]
  Modules linked in: rfcomm ip6t_REJECT nf_reject_ipv6 xt_comment=20
ip6table_mangle ip6table_nat ip6table_raw ip6table_filter ip6_tables=20
xt_recent ipt_IFWLOG ipt_psd xt_set ip_set_hash_ip ip_set ipt_REJECT=20
nf_reject_ipv4 xt_conntrack xt_hashlimit xt_addrtype xt_mark=20
iptable_mangle iptable_nat xt_CT xt_tcpudp iptable_raw xt_NFLOG=20
nfnetlink_log xt_LOG nf_log_syslog nf_nat_tftp nf_nat_snmp_basic=20
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323=20
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat=20
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp=20
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns=20
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323=20
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=20
iptable_filter ccm af_packet qrtr cmac algif_hash algif_skcipher af_alg=20
bnep nls_iso8859_1 nls_cp437 vfat fat dm_mirror dm_region_hash dm_log=20
rtl8723be btcoexist rtl8723_common rtl_pci rtlwifi mac80211 uvcvideo uvc=20
cfg80211 videobuf2_vmalloc videobuf2_memops
   videobuf2_v4l2 kvm_amd btusb btmtk btrtl btbcm btintel ccp kvm=20
videodev bluetooth snd_hda_codec_realtek snd_hda_codec_generic=20
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi=20
videobuf2_common asus_nb_wmi mc ecdh_generic ecc snd_hda_codec asus_wmi=20
ledtrig_audio sparse_keymap platform_profile irqbypass wmi_bmof=20
sha1_generic r8169 rfkill libarc4 realtek i2c_piix4 mdio_devres=20
snd_hda_core tpm_crb snd_hwdep libphy snd_pcm snd_timer snd fam15h_power=20
k10temp soundcore tpm_tis tpm_tis_core tpm asus_wireless acpi_cpufreq=20
input_leds joydev evdev sch_fq_codel fuse dm_mod loop configfs efivarfs=20
dmi_sysfs ip_tables x_tables ipv6 crc_ccitt autofs4 sdhci_pci=20
crc32_pclmul crc32c_intel polyval_clmulni cqhci sdhci polyval_generic=20
gf128mul mmc_core xhci_pci xhci_pci_renesas xhci_hcd atkbd=20
ghash_clmulni_intel vivaldi_fmap sha512_ssse3 aesni_intel crypto_simd=20
cryptd serio_raw ehci_pci ehci_hcd sp5100_tco amdgpu i2c_algo_bit=20
drm_ttm_helper ttm iommu_v2 drm_buddy gpu_sched drm_display_helper=20
drm_kms_helper
   video hid_multitouch drm wmi i2c_hid_acpi i2c_hid 8250_dw cec
  CPU: 1 PID: 1248 Comm: Xorg Not tainted 6.3.9-desktop-1.mga9 #1
  Hardware name: ASUSTeK COMPUTER INC. X441BA/X441BA, BIOS X441BA.310=20
02/25/2020
  RIP: 0010:dce_aux_transfer_raw+0x731/0x760 [amdgpu]
  Code: 4c 10 00 8b 54 24 0c 89 e8 83 c5 01 41 88 14 04 3b 6c 24 04 72=20
c9 e9 3e fd ff ff 3c 01 19 c0 83 e0 c0 83 c0 50 e9 72 f9 ff ff <0f> 0b=20
b8 03 00 00 00 e9 77 ff ff ff b8 03 00 00 00 e9 6d ff ff ff
  RSP: 0018:ffffa52801b8ba48 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff934801cdec80 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 00000000000098e4 RDI: ffff93480c700000
  RBP: ffffa52801b8bac0 R08: 0000000000000000 R09: 000000000000000a
  R10: 0000000000000001 R11: ffff93480c700010 R12: ffffa52801b8babc
  R13: 0000000000000000 R14: 0000000000000000 R15: ffff934803816a30
  FS:  00007f0dd47f82c0(0000) GS:ffff93480dc80000(0000)=20
knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f298f3620d0 CR3: 0000000104d00000 CR4: 00000000001506e0
  Call Trace:
   <TASK>
   ? dce_aux_transfer_raw+0x731/0x760 [amdgpu]
   ? __warn+0x7d/0x130
   ? dce_aux_transfer_raw+0x731/0x760 [amdgpu]
   ? report_bug+0x16d/0x1a0
   ? handle_bug+0x41/0x70
   ? exc_invalid_op+0x13/0x60
   ? asm_exc_invalid_op+0x16/0x20
   ? dce_aux_transfer_raw+0x731/0x760 [amdgpu]
   dm_dp_aux_transfer+0xa1/0x160 [amdgpu]
   drm_dp_dpcd_access+0xad/0x130 [drm_display_helper]
   drm_dp_dpcd_probe+0x3a/0xf0 [drm_display_helper]
   drm_dp_dpcd_read+0xbf/0x100 [drm_display_helper]
   dm_helpers_dp_read_dpcd+0x28/0x50 [amdgpu]
   amdgpu_dm_update_freesync_caps+0x17b/0x360 [amdgpu]
   amdgpu_dm_connector_get_modes+0x242/0x4f0 [amdgpu]
   drm_helper_probe_single_connector_modes+0x18c/0x520 [drm_kms_helper]
   drm_mode_getconnector+0x390/0x4a0 [drm]
   ? ____sys_recvmsg+0xdd/0x1a0
   ? __pfx_drm_mode_getconnector+0x10/0x10 [drm]
   drm_ioctl_kernel+0xc1/0x160 [drm]
   drm_ioctl+0x24c/0x490 [drm]
   ? __pfx_drm_mode_getconnector+0x10/0x10 [drm]
   amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
   __x64_sys_ioctl+0x90/0xd0
   do_syscall_64+0x3a/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc
  RIP: 0033:0x7f0dd3f68e68
  Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24=20
d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2=20
3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 71 ef 0c
  RSP: 002b:00007ffe6fb5b398 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00000000009a5ce0 RCX: 00007f0dd3f68e68
  RDX: 00007ffe6fb5b3e0 RSI: 00000000c05064a7 RDI: 0000000000000010
  RBP: 00007ffe6fb5b3e0 R08: 0000000000000007 R09: 0000000000bea1c0
  R10: 0000000000000003 R11: 0000000000000246 R12: 00000000c05064a7
  R13: 0000000000000010 R14: 00000000c05064a7 R15: 00007ffe6fb5b3e0
   </TASK>
  ---[ end trace 0000000000000000 ]---


reverting them from the 6.3.9 build is confirmed to fix the issue.


here is full boot journals with working 6.3.8 and failing 6.3.9 with=20
those patches applied:
https://bugs.mageia.org/attachment.cgi?id=3D13888

--
Thomas


