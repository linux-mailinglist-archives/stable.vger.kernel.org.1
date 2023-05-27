Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC5713735
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 01:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjE0XyW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 19:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjE0XyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 19:54:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC3D8;
        Sat, 27 May 2023 16:54:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-528cdc9576cso1296415a12.0;
        Sat, 27 May 2023 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685231659; x=1687823659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bcoTDy4yp9J7+AxB8A50sccmom8TCJEyod+GtDcYqI=;
        b=OfiPKkzyMcY29P4qeg3SZd88YXMKJcCeH+Onv4iHR9U9ugMWpMKQHKQ8Ltt4rpkecv
         MIU73ttV4zrYCH61vKkfkP0+xTNceeTwfYyKo8RVS/nN55YNAuONSk2DNGSGhM0IClxI
         cRDKZpm9lD+3JTqEMjKJkitVzcUGZABlCxyQf+keHPva67Lj35IEOS+qvnyzl135FC3y
         vzM9Sxk8dGDu/Rk88wgMo8Guv7Msfh1lCvBcap2RcXP/k6MdOyFnCSCzxERNB6/kZIuI
         CSaZFw9y8/xQmeDIBb7WjgjeZg8h/OQIZAi+6fXfNuaKUxZc39yMKS4YWeGK6KMsk/qY
         11Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685231659; x=1687823659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bcoTDy4yp9J7+AxB8A50sccmom8TCJEyod+GtDcYqI=;
        b=eP+ht/942Hxbkoglfm2AmwXaqTyacVxqRSZR+cLo/VrKneHCoL8l4AA3GJGvqaICzC
         jv2C8EdOPUEo8LtsqDOh50yhyvAOKKOnUyZlyyFkHSjrTUjrdwAgAIKLeuvm9EGl1h5k
         12R91BjHLvBi0oFcWUqtfhhZHobtz7ltaOG2dLxAHDhVpmJwMyNlB2so5QF4ZvZPIayR
         5CDkeSV2JHOmOEzJFStKsyQcPL7tqPhgx/tzc66yDDkChxdYFmpb9AR4fBG6C/i9Cgg1
         RQm/EzKNFx0SPbTdtg89pp+mgDnTejtqWatZDFc2klTfzeH7gKrizvDoIVJ0GLzQ1rQE
         W2yQ==
X-Gm-Message-State: AC+VfDwRJZRUCOcZ97vi855IMq3JYJ+8/BdeizyCLW27Rz/oqElsdBtJ
        7rZfx7UqfVDfDYuddlVIzFY=
X-Google-Smtp-Source: ACHHUZ7IxhnopHgeNlh4fZrlR+Nd1iv+ktb5MvtYRsG69i0oIwc612HFssIw6Za9EN1OwXqyfINeKg==
X-Received: by 2002:a17:902:7b83:b0:1ae:50cc:455 with SMTP id w3-20020a1709027b8300b001ae50cc0455mr6214132pll.39.1685231659208;
        Sat, 27 May 2023 16:54:19 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902b58400b001ac7ab3e97csm5388556pls.260.2023.05.27.16.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 16:54:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9FCDB106990; Sun, 28 May 2023 06:48:52 +0700 (WIB)
Date:   Sun, 28 May 2023 06:48:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org
Cc:     Linux USB <linux-usb@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Message-ID: <ZHKW5NeabmfhgLbY@debian.me>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZlxuf7mDuFb9O/k"
Content-Disposition: inline
In-Reply-To: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--yZlxuf7mDuFb9O/k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
> Upgrade to 6.1.30, got crash message after resume, but looks still
> running normally
>=20
> After revert
>     e16629c639d429e48c849808e59f1efcce886849
>     thunderbolt: Clear registers properly when auto clear isn't in use
> This error was gone.

Can you check latest mainline to see if this regression still happens?

>=20
> kernel config attached, system is Slackware 15.0 on XPS 9700
>=20
> May 27 13:55:39 devel kernel: ------------[ cut here ]------------
> May 27 13:55:39 devel kernel: thunderbolt 0000:07:00.0: interrupt for
> TX ring 0 is already enabled
> May 27 13:55:39 devel kernel: WARNING: CPU: 15 PID: 21394 at
> drivers/thunderbolt/nhi.c:137 ring_interrupt_active+0x1ff/0x250
> [thunderbolt]
> May 27 13:55:39 devel kernel: Modules linked in: squashfs
> nls_iso8859_1 nls_cp437 tun fuse 8021q garp mrp iptable_nat
> xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv4 ip_tables x_tables
> efivarfs binfmt_misc snd_ctl_led snd_soc_sof_sdw
> snd_soc_intel_hda_dsp_common snd_soc_intel_sof_maxim_common
> snd_sof_probes snd_soc_rt715 snd_soc_rt711 snd_soc_rt1308_sdw
> regmap_sdw snd_soc_dmic snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> snd_sof_pci soundwire_intel soundwire_generic_allocation
> soundwire_cadence snd_sof_intel_hda snd_sof snd_sof_utils
> snd_sof_xtensa_dsp snd_soc_acpi_intel_match snd_soc_acpi
> snd_soc_hdac_hda soundwire_bus snd_hda_ext_core snd_hda_codec_hdmi
> snd_soc_core coretemp snd_compress ac97_bus nouveau intel_tcc_cooling
> snd_hda_intel x86_pkg_temp_thermal dell_smm_hwmon hid_multitouch
> iwlmvm hwmon intel_powerclamp snd_intel_dspcfg mxm_wmi i915
> i2c_designware_platform snd_intel_sdw_acpi rtsx_pci_sdmmc
> drm_ttm_helper i2c_designware_core mac80211 drm_buddy i2c_algo_bit
> dell_laptop snd_hda_codec
> May 27 13:55:39 devel kernel:  ucsi_ccg dell_wmi mmc_core hid_generic
> drm_display_helper ledtrig_audio sparse_keymap libarc4 snd_hwdep
> intel_rapl_msr dell_smbios uvcvideo ttm snd_hda_core dell_wmi_sysman
> kvm_intel videobuf2_vmalloc firmware_attributes_class
> dell_wmi_descriptor wmi_bmof intel_wmi_thunderbolt dcdbas
> processor_thermal_device_pci_legacy drm_kms_helper videobuf2_memops
> iwlwifi intel_soc_dts_iosf kvm btusb r8153_ecm btrtl videobuf2_v4l2
> snd_pcm syscopyarea processor_thermal_device irqbypass cdc_ether btbcm
> evdev usbnet psmouse intel_lpss_pci btintel processor_thermal_rfim
> snd_timer videobuf2_common crc32c_intel ucsi_acpi sysfillrect
> ghash_clmulni_intel serio_raw cfg80211 efi_pstore r8152 typec_ucsi
> bluetooth sysimgblt videodev processor_thermal_mbox intel_gtt
> intel_lpss fb_sys_fops processor_thermal_rapl i2c_i801 roles snd
> i2c_nvidia_gpu drm i2c_smbus ecdh_generic idma64 i2c_hid_acpi mii
> usbhid thunderbolt mc soundcore rtsx_pci ecc agpgart i2c_ccgx_ucsi
> rfkill intel_rapl_common mfd_core
> May 27 13:55:39 devel kernel:  intel_pch_thermal i2c_hid typec video
> button battery hid int3403_thermal int340x_thermal_zone
> pinctrl_cannonlake pinctrl_intel wmi int3400_thermal intel_pmc_core
> acpi_pad acpi_thermal_rel acpi_tad ac usb_storage
> May 27 13:55:39 devel kernel: CPU: 15 PID: 21394 Comm: kworker/u32:15
> Tainted: G        W          6.1.30-dell-2 #1
> May 27 13:55:39 devel kernel: Hardware name: Dell Inc. XPS 17
> 9700/0P1CHN, BIOS 1.11.1 11/18/2021
> May 27 13:55:39 devel kernel: Workqueue: events_unbound async_run_entry_fn
> May 27 13:55:39 devel kernel: RIP:
> 0010:ring_interrupt_active+0x1ff/0x250 [thunderbolt]
> May 27 13:55:39 devel kernel: Code: 24 04 e8 24 2b 3c e1 4c 8b 4c 24
> 08 44 8b 44 24 04 48 c7 c7 50 c7 29 a0 48 8b 4c 24 10 48 8b 54 24 18
> 48 89 c6 e8 71 34 e4 e0 <0f> 0b 45 84 ed 0f 85 09 ff ff ff 48 8b 43 08
> f6 40 70 01 0f 85 38
> May 27 13:55:39 devel kernel: RSP: 0018:ffffc90000517c48 EFLAGS: 00010082
> May 27 13:55:39 devel kernel: RAX: 0000000000000000 RBX:
> ffff888101dab800 RCX: 0000000000000000
> May 27 13:55:39 devel kernel: RDX: 0000000000000004 RSI:
> 0000000000000086 RDI: 00000000ffffffff
> May 27 13:55:39 devel kernel: RBP: 0000000000000000 R08:
> 80000000ffffe7b4 R09: 0000000082999bac
> May 27 13:55:39 devel kernel: R10: ffffffffffffffff R11:
> ffffffff82999ba1 R12: 0000000000001001
> May 27 13:55:39 devel kernel: R13: 0000000000000001 R14:
> 0000000000038200 R15: 0000000000000001
> May 27 13:55:39 devel kernel: FS:  0000000000000000(0000)
> GS:ffff88887d7c0000(0000) knlGS:0000000000000000
> May 27 13:55:39 devel kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> May 27 13:55:39 devel kernel: CR2: 00007f745c010b00 CR3:
> 000000000220a005 CR4: 00000000007706e0
> May 27 13:55:39 devel kernel: PKRU: 55555554
> May 27 13:55:39 devel kernel: Call Trace:
> May 27 13:55:39 devel kernel:  <TASK>
> May 27 13:55:39 devel kernel:  tb_ring_start+0x141/0x230 [thunderbolt]
> May 27 13:55:39 devel kernel:  tb_ctl_start+0x1f/0x70 [thunderbolt]
> May 27 13:55:39 devel kernel:  ? pci_pm_restore_noirq+0xc0/0xc0
> May 27 13:55:39 devel kernel:  tb_domain_runtime_resume+0x15/0x30 [thunde=
rbolt]
> May 27 13:55:39 devel kernel:  __rpm_callback+0x41/0x110
> May 27 13:55:39 devel kernel:  ? pci_pm_restore_noirq+0xc0/0xc0
> May 27 13:55:39 devel kernel:  rpm_callback+0x59/0x70
> May 27 13:55:39 devel kernel:  rpm_resume+0x4b3/0x7f0
> May 27 13:55:39 devel kernel:  ? _raw_spin_unlock_irq+0x13/0x30
> May 27 13:55:39 devel kernel:  ? __wait_for_common+0x171/0x1a0
> May 27 13:55:39 devel kernel:  ? usleep_range_state+0x90/0x90
> May 27 13:55:39 devel kernel:  ? preempt_count_add+0x68/0xa0
> May 27 13:55:39 devel kernel:  __pm_runtime_resume+0x4a/0x80
> May 27 13:55:39 devel kernel:  pci_pm_suspend+0x60/0x170
> May 27 13:55:39 devel kernel:  ? pci_pm_freeze+0xb0/0xb0
> May 27 13:55:39 devel kernel:  dpm_run_callback+0x3f/0x150
> May 27 13:55:39 devel kernel:  ? _raw_spin_lock_irqsave+0x19/0x40
> May 27 13:55:39 devel kernel:  __device_suspend+0x130/0x4d0
> May 27 13:55:39 devel kernel:  async_suspend+0x1b/0x90
> May 27 13:55:39 devel kernel:  async_run_entry_fn+0x1a/0xa0
> May 27 13:55:39 devel kernel:  process_one_work+0x1bd/0x3c0
> May 27 13:55:39 devel kernel:  worker_thread+0x4d/0x3c0
> May 27 13:55:39 devel kernel:  ? process_one_work+0x3c0/0x3c0
> May 27 13:55:39 devel kernel:  kthread+0xe5/0x110
> May 27 13:55:39 devel kernel:  ? kthread_complete_and_exit+0x20/0x20
> May 27 13:55:39 devel kernel:  ret_from_fork+0x1f/0x30
> May 27 13:55:39 devel kernel:  </TASK>
> May 27 13:55:39 devel kernel: ---[ end trace 0000000000000000 ]---

Anyway, I'm adding it to regzbot (as stable-specific regression for now):

#regzbot ^introduced: e16629c639d429
#regzbot title: Properly clearing Thunderbolt registers when not autocleari=
ng triggers ring_interrupt_active crash on resume

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yZlxuf7mDuFb9O/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHKW3gAKCRD2uYlJVVFO
oxDwAQDQkyT+xtG9aUf8afzUgGTBm1z5UwdfsQyqWGaHJcRBSgEAyKreP2Z5SsOE
2r7eroagLyoRxdm0reLA9MeBPKKPOQ8=
=0zXc
-----END PGP SIGNATURE-----

--yZlxuf7mDuFb9O/k--
