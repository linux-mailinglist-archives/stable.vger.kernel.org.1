Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7B6FDE26
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjEJM5b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEJM5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 08:57:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350E49E9
        for <stable@vger.kernel.org>; Wed, 10 May 2023 05:57:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac733b813fso77917611fa.1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683723444; x=1686315444;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM19wuNlad7MiDQI/HfTVrsziUE7xLYgxN3zttAxQhk=;
        b=pns66P5+dppyqpyH7pdDWEO97IcoqO2RRaB2ftcFBXWB1qQUdfjequgDHg6WFoce+2
         Cs0np8i/7XXj6+Eti0mXXOvzlxKIlevH32nR2CZzAQIb09TtwVLpJ/vW1zRDR+dPZAuC
         l6MNPnhivuOAwp8yIUXH2VhZweSBlAba96kTgjE0cczdnPfI1n5VcBu+d7cRZkY8Vpx4
         9AFS0aXVB+13Kxhqwi1KhTRIWKcY/aGEpcTxLFo17I4GpH5lhyQVcopyRK9wLQ6dH6Cs
         MZbruZdba75q7wvQITvJyjD0cRbfHfrtJ2dAuyUAx84YTi2LZACoBJNTqcgLAGlW1k7f
         Y4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683723444; x=1686315444;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hM19wuNlad7MiDQI/HfTVrsziUE7xLYgxN3zttAxQhk=;
        b=Xa9E4OJM5cGhqJr5z4O2PBsoTbtIT31nAOlq5XCS1q7VFTBy1v/C9kaKQ+5qkgJ9SH
         0yOfUSelx4RC7/tPeol5QwRjx9JQAFzHmzr9MJOIzc7Pstel2ovX7by1Ug+ZY8hIoB1R
         SNfYgzDJVpXUoPO8IihgLwWl3zVEhUFf2uzfNAGrhTHhgZdeHmxyEzB6pxm3AldeTnHH
         uqrifEJ3aPVFOrEWAkE6MKfBYJuJjMG8JfOz/mNhxu6X9AOSm+y7RDSSX3Ru7zBoYAeN
         f2bDmhNKwbhIjVoo9pA/l9ORqdDcjxe0q1GiNCFBh6U7LgUXMcNoPrgQcb8ncKN1dAka
         Eemg==
X-Gm-Message-State: AC+VfDwVHxeiXZqJ+rEJeKHmMO+r77E1cq0bd10Mg0dFmLtgzjVxmIAp
        glEaauIDCeHFGU2cjmhsPumruo2FHv+Exg==
X-Google-Smtp-Source: ACHHUZ6n2CmlgtrSz6MFhtxPos+XRCPisuE4NWFgqSvgkkfkGOjFUWrp2yFU9R3YS09iNo5ZMNWmrA==
X-Received: by 2002:a2e:9110:0:b0:2a8:ad36:f8ca with SMTP id m16-20020a2e9110000000b002a8ad36f8camr2213166ljg.14.1683723443816;
        Wed, 10 May 2023 05:57:23 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e94d7000000b002adadd0c8c8sm458968ljh.33.2023.05.10.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:57:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 10 May 2023 14:57:22 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jared Epp <jaredepp@pm.me>
Subject: Please apply commit 6470accc7ba9 ("KVM: x86: hyper-v: Avoid calling
 kvm_make_vcpus_request_mask() with vcpu_mask==NULL") to v5.10.y
Message-ID: <ZFuUstsT9plyGcTp@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi

After we updated the kernel in Debian bullseye from 5.10.162 to
5.10.178, we got a report from Jared Epp in
https://bugs.debian.org/1035779 that a Windows Guest VM no longer
booted, and Kernel reporting:

[   51.576266] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[   51.576269] #PF: supervisor read access in kernel mode
[   51.576270] #PF: error_code(0x0000) - not-present page
[   51.576271] PGD 0 P4D 0=20
[   51.576273] Oops: 0000 [#1] SMP NOPTI
[   51.576275] CPU: 6 PID: 2209 Comm: CPU 0/KVM Not tainted 5.10.0-22-amd64=
 #1 Debian 5.10.178-3
[   51.576276] Hardware name: ASUS System Product Name/CROSSHAIR VI HERO, B=
IOS 8701 02/08/2023
[   51.576280] RIP: 0010:find_first_bit+0x19/0x40
[   51.576281] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc cc cc cc 49 =
89 f0 48 85 f6 74 28 31 c0 eb 0d 48 83 c0 40 48 83 c7 08 4c 39 c0 73 17 <48=
> 8b 17 48 85 d2 74 eb f3 48 0f bc d2 48 01 d0 49 39 c0 4c 0f 47
[   51.576282] RSP: 0018:ffffa99ac3a23a30 EFLAGS: 00010246
[   51.576283] RAX: 0000000000000000 RBX: ffffa99ac38a5000 RCX: 00000000000=
00000
[   51.576283] RDX: 0000000000000000 RSI: 0000000000000120 RDI: 00000000000=
00000
[   51.576284] RBP: 0000000000000000 R08: 0000000000000120 R09: ffff94e2c1a=
e72a8
[   51.576284] R10: 000000000000000f R11: 0000000000000000 R12: ffff94e2c1a=
e72a8
[   51.576285] R13: 0000000000000323 R14: 0000000000000003 R15: 00000000000=
00006
[   51.576286] FS:  0000000000000000(0053) GS:ffff94e89e980000(002b) knlGS:=
fffff8033f006000
[   51.576286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.576287] CR2: 0000000000000000 CR3: 000000018e4ee000 CR4: 00000000007=
50ee0
[   51.576287] PKRU: 55555554
[   51.576288] Call Trace:
[   51.576307]  kvm_make_vcpus_request_mask+0x38/0xf0 [kvm]
[   51.576319]  kvm_hv_flush_tlb+0x147/0x370 [kvm]
[   51.576328]  ? kvm_page_track_is_active+0x12/0x50 [kvm]
[   51.576336]  ? make_spte+0x146/0x260 [kvm]
[   51.576344]  ? mmu_spte_update+0x11/0x1c0 [kvm]
[   51.576351]  ? set_spte+0xee/0x140 [kvm]
[   51.576358]  ? mmu_set_spte+0x327/0x4a0 [kvm]
[   51.576365]  ? kvm_release_pfn_clean+0x22/0x40 [kvm]
[   51.576372]  ? direct_page_fault+0x223/0xa20 [kvm]
[   51.576374]  ? svm_get_segment+0x18/0x100 [kvm_amd]
[   51.576382]  ? kvm_get_cs_db_l_bits+0x35/0x70 [kvm]
[   51.576383]  ? svm_get_segment+0x18/0x100 [kvm_amd]
[   51.576390]  ? kvm_get_cs_db_l_bits+0x35/0x70 [kvm]
[   51.576398]  kvm_hv_hypercall+0x176/0x580 [kvm]
[   51.576401]  ? get_cpu_vendor+0x40/0xa0
[   51.576403]  ? native_load_tr_desc+0x67/0x70
[   51.576411]  kvm_arch_vcpu_ioctl_run+0xbe8/0x1740 [kvm]
[   51.576419]  kvm_vcpu_ioctl+0x21e/0x5b0 [kvm]
[   51.576422]  __x64_sys_ioctl+0x8b/0xc0
[   51.576424]  do_syscall_64+0x33/0x80
[   51.576426]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[   51.576428] RIP: 0033:0x7fad816f2237
[   51.576429] Code: 00 00 00 48 8b 05 59 cc 0d 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 cc 0d 00 f7 d8 64 89 01 48
[   51.576429] RSP: 002b:00007fad7ce65508 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   51.576430] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fad816=
f2237
[   51.576431] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00000000000=
0001c
[   51.576431] RBP: 000055a3e17511c0 R08: 000055a3df109848 R09: 000055a3df5=
335c0
[   51.576432] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[   51.576432] R13: 000055a3df54fbc0 R14: 00007fad7ce657c0 R15: 00000000008=
02000
[   51.576434] Modules linked in: xt_nat veth nft_chain_nat xt_MASQUERADE n=
f_nat nf_conntrack_netlink xfrm_user xfrm_algo br_netfilter vhost_net vhost=
 vhost_iotlb tap tun bridge stp llc overlay ip6t_REJECT nf_reject_ipv6 xt_h=
l ip6_tables ip6t_rt ipt_REJECT nf_reject_ipv4 xt_multiport nft_limit snd_h=
da_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd=
_hda_intel nls_ascii snd_intel_dspcfg nls_cp437 soundwire_intel vfat soundw=
ire_generic_allocation fat snd_soc_core snd_compress soundwire_cadence snd_=
hda_codec edac_mce_amd xt_limit xt_addrtype kvm_amd snd_hda_core xt_tcpudp =
snd_hwdep eeepc_wmi kvm soundwire_bus xpad xt_conntrack cdc_acm joydev asus=
_wmi ff_memless snd_pcm nf_conntrack battery sparse_keymap snd_timer nf_def=
rag_ipv6 rfkill nf_defrag_ipv4 irqbypass nft_compat snd video rapl efi_psto=
re wmi_bmof pcspkr ccp soundcore k10temp sp5100_tco nft_counter watchdog sg=
 tpm_crb tpm_tis tpm_tis_core tpm rng_core acpi_cpufreq evdev nf_tables lib=
crc32c nfnetlink msr fuse
[   51.576464]  configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbc=
ache jbd2 crc32c_generic dm_crypt dm_mod hid_logitech_hidpp hid_logitech_dj=
 amdgpu sr_mod cdrom gpu_sched sd_mod hid_generic ttm crc32_pclmul crc32c_i=
ntel usbhid hid drm_kms_helper ahci cec libahci ghash_clmulni_intel xhci_pc=
i libata xhci_hcd drm nvme aesni_intel mxm_wmi igb libaes usbcore crypto_si=
md nvme_core cryptd scsi_mod glue_helper i2c_piix4 dca ptp pps_core t10_pi =
i2c_algo_bit crc_t10dif crct10dif_generic usb_common crct10dif_pclmul crct1=
0dif_common wmi gpio_amdpt gpio_generic button
[   51.576484] CR2: 0000000000000000
[   51.576485] ---[ end trace acfac62cc884c67c ]---

In fact this was similar to
https://forum.proxmox.com/threads/with-latest-5-15-104-1-pve-windows-server=
-vm-freeze-stuck.125294/
and could be workarounded by dropping the '+hv-tlbflush' flag.

Jared confirmed that applying 6470accc7ba9 ("KVM: x86: hyper-v: Avoid
calling kvm_make_vcpus_request_mask() with vcpu_mask=3D=3DNULL") did solve
the issue.

(Same commit was applied in 5.15.105).

Can you pick it for 5.10.y?

Regards,
Salvatore
