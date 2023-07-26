Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2707635AB
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjGZLyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjGZLyk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 07:54:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106161988
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 04:54:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-563643b2b4cso3415334a12.1
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690372476; x=1690977276;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3sJ40vm4HVuBOgvDIQqcETVwurPntBCvBEW/UzOG68=;
        b=fVVXMVVr2mosVrZK/ef/2LBwtvU4Z2mN3Pj0I+ErlQcbQ94cvjcbxCtEK7OXFKmwnz
         YpGqD+nBQUvDpCMAYhI61X4iGIZwmTGqr8Q+TYS9weaGgv6L2MIMZxmhf0VCGFUt70Xd
         6r1NqQL57+lWcoX2jiZNnaxGefdwBBJ7TDBWCdaDie49DpnXaZ5J3w7qLBz+0oLyrkhU
         NNY9MeBA4JXQ+7oGzAYJgIElpibjflVY4bw04y+any7Tvy4hkjEONdnJPuSSG8b6iG+Y
         2GsLzxkMRmGVhtz82z7iTuhuqgSZDaFUi2i/EdkmEYI2gggl8Jc05kLJh9oeU7ig0fR4
         M8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690372476; x=1690977276;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m3sJ40vm4HVuBOgvDIQqcETVwurPntBCvBEW/UzOG68=;
        b=ieBVwBweiSVXVu5nV39y8Enw2gzXj6SWZv5VB1ho9diwcYTSKfBPN7RqKWpxGIflqW
         nAng5MmRixjmA9kle38nD4OZOivsjgBu393RKvzgoKIfdFB1QAHqSbnZgBjqWsDqJCx3
         i/x+2Bm0OO1QZ6tQcLXaU9lJ4P93sqKIkjf/tlOmFXjrIk55hfWOkkX7NJCrGEbhVPKE
         9XTQx+ggJAOdCSmVeLct47LyKxe9bxDUvLxArKinZ4UnZjet27M7Pc5fk71hiE4NpecK
         YIBD9ScmHB5IdomaJHh2wkEj8QRZ4CjqJGk0HFlVVUh+sSjV/t+Y6LExU3vy5MX6PAtO
         otnw==
X-Gm-Message-State: ABy/qLbhi68dlHGqtzOlfYxrVDtS3zxGB2R1LFCXDdWueCR/Wi/VDgHy
        VaGnSZqnOM56kxIjbPvWaDyOf0UiTYdMNQ==
X-Google-Smtp-Source: APBJJlEfKeTbrN5xCinj7hKGyEStwDBvPTNHNw1SAr8Dh6GIJ0TYjHnJ7SoRt625abJ7D1UH1mfD8g==
X-Received: by 2002:a17:90a:ba82:b0:268:1def:221c with SMTP id t2-20020a17090aba8200b002681def221cmr1344342pjr.45.1690372476032;
        Wed, 26 Jul 2023 04:54:36 -0700 (PDT)
Received: from [192.168.1.121] ([65.129.150.161])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090a290e00b002680f0f2886sm1211956pjd.12.2023.07.26.04.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:54:35 -0700 (PDT)
Message-ID: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
Date:   Wed, 26 Jul 2023 05:54:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev
From:   TW <dalzot@gmail.com>
Subject: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I have been having issues with the 6.x series of kernels resuming from 
suspend with one of my drives. Far as I can tell it has trouble with the 
cache on the drive when coming out of s3 sleep. Tried a few different 
distros (Manjaro, OpenMandriva Rome, EndeavourOS) all that give the same 
error message. It appears to work fine on the 5.15 kernel just fine however.


This is the error or errors that I have been getting and assume has been 
holding up the system from resuming from suspend.
Jul 20 04:13:41 rageworks kernel: ata10.00: device reported invalid CHS 
sector 0
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Start/Stop Unit 
failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Sense Key : Illegal 
Request [current]
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Add. Sense: 
Unaligned write command
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: dpm_run_callback(): 
scsi_bus_resume+0x0/0x90 returns -5
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: failed to resume 
async: error -5

The full suspend log.
Jul 20 04:12:50 rageworks systemd-logind[869]: The system will suspend now!
Jul 20 04:12:50 rageworks ModemManager[902]: <info> 
[sleep-monitor-systemd] system is about to suspend
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.4923] 
manager: sleep: sleep requested (sleeping: no enabled: yes)
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.4924] 
manager: NetworkManager state is now ASLEEP
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.4926] 
device (enp9s0): state change: activated -> deactivating (reason 
'sleeping', sys-iface-state: 'managed')
Jul 20 04:12:50 rageworks dbus-daemon[866]: [system] Activating via 
systemd: service name='org.freedesktop.nm_dispatcher' 
unit='dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.6' 
(uid=0 pid=894 comm="/usr/bin/NetworkManager --no-daemon")
Jul 20 04:12:50 rageworks systemd[1]: Starting Network Manager Script 
Dispatcher Service...
Jul 20 04:12:50 rageworks dbus-daemon[866]: [system] Successfully 
activated service 'org.freedesktop.nm_dispatcher'
Jul 20 04:12:50 rageworks systemd[1]: Started Network Manager Script 
Dispatcher Service.
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.6544] 
device (enp9s0): state change: deactivating -> disconnected (reason 
'sleeping', sys-iface-state: 'managed')
Jul 20 04:12:50 rageworks avahi-daemon[864]: Withdrawing address record 
for fe80::881:c55d:1583:20f5 on enp9s0.
Jul 20 04:12:50 rageworks avahi-daemon[864]: Leaving mDNS multicast 
group on interface enp9s0.IPv6 with address fe80::881:c55d:1583:20f5.
Jul 20 04:12:50 rageworks avahi-daemon[864]: Interface enp9s0.IPv6 no 
longer relevant for mDNS.
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.6726] 
dhcp4 (enp9s0): canceled DHCP transaction
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.6726] 
dhcp4 (enp9s0): activation: beginning transaction (timeout in 45 seconds)
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.6727] 
dhcp4 (enp9s0): state changed no lease
Jul 20 04:12:50 rageworks avahi-daemon[864]: Withdrawing address record 
for 192.168.1.3 on enp9s0.
Jul 20 04:12:50 rageworks avahi-daemon[864]: Leaving mDNS multicast 
group on interface enp9s0.IPv4 with address 192.168.1.3.
Jul 20 04:12:50 rageworks avahi-daemon[864]: Interface enp9s0.IPv4 no 
longer relevant for mDNS.
Jul 20 04:12:50 rageworks NetworkManager[894]: <info> [1689847970.7576] 
device (enp9s0): state change: disconnected -> unmanaged (reason 
'sleeping', sys-iface-state: 'managed')
Jul 20 04:12:50 rageworks kernel: r8169 0000:09:00.0 enp9s0: Link is Down
Jul 20 04:12:50 rageworks systemd[1]: Reached target Sleep.
Jul 20 04:12:50 rageworks systemd[1]: Starting NVIDIA system suspend 
actions...
Jul 20 04:12:50 rageworks suspend[2051]: nvidia-suspend.service
Jul 20 04:12:50 rageworks logger[2051]: <13>Jul 20 04:12:50 suspend: 
nvidia-suspend.service
Jul 20 04:12:51 rageworks systemd[1]: nvidia-suspend.service: 
Deactivated successfully.
Jul 20 04:12:51 rageworks systemd[1]: Finished NVIDIA system suspend 
actions.
Jul 20 04:12:51 rageworks systemd[1]: Starting System Suspend...
Jul 20 04:12:51 rageworks systemd-sleep[2059]: Entering sleep state 
'suspend'...
Jul 20 04:12:51 rageworks kernel: PM: suspend entry (deep)
Jul 20 04:13:41 rageworks kernel: Filesystems sync: 0.284 seconds
Jul 20 04:13:41 rageworks kernel: Freezing user space processes
Jul 20 04:13:41 rageworks kernel: Freezing user space processes 
completed (elapsed 0.001 seconds)
Jul 20 04:13:41 rageworks kernel: OOM killer disabled.
Jul 20 04:13:41 rageworks kernel: Freezing remaining freezable tasks
Jul 20 04:13:41 rageworks kernel: Freezing remaining freezable tasks 
completed (elapsed 0.001 seconds)
Jul 20 04:13:41 rageworks kernel: printk: Suspending console(s) (use 
no_console_suspend to debug)
Jul 20 04:13:41 rageworks kernel: serial 00:05: disabled
Jul 20 04:13:41 rageworks kernel: sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 20 04:13:41 rageworks kernel: sd 1:0:0:0: [sdb] Synchronizing SCSI cache
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Synchronizing SCSI cache
Jul 20 04:13:41 rageworks kernel: sd 1:0:0:0: [sdb] Stopping disk
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Stopping disk
Jul 20 04:13:41 rageworks kernel: sd 0:0:0:0: [sda] Stopping disk
Jul 20 04:13:41 rageworks kernel: ACPI: PM: Preparing to enter system 
sleep state S3
Jul 20 04:13:41 rageworks kernel: ACPI: PM: Saving platform NVS memory
Jul 20 04:13:41 rageworks kernel: Disabling non-boot CPUs ...
Jul 20 04:13:41 rageworks kernel: smpboot: CPU 1 is now offline
Jul 20 04:13:41 rageworks kernel: smpboot: CPU 2 is now offline
Jul 20 04:13:41 rageworks kernel: smpboot: CPU 3 is now offline
Jul 20 04:13:41 rageworks kernel: ACPI: PM: Low-level resume complete
Jul 20 04:13:41 rageworks kernel: ACPI: PM: Restoring platform NVS memory
Jul 20 04:13:41 rageworks kernel: Enabling non-boot CPUs ...
Jul 20 04:13:41 rageworks kernel: x86: Booting SMP configuration:
Jul 20 04:13:41 rageworks kernel: smpboot: Booting Node 0 Processor 1 
APIC 0x1
Jul 20 04:13:41 rageworks kernel: microcode: CPU1: patch_level=0x08101016
Jul 20 04:13:41 rageworks kernel: CPU1 is up
Jul 20 04:13:41 rageworks kernel: smpboot: Booting Node 0 Processor 2 
APIC 0x2
Jul 20 04:13:41 rageworks kernel: microcode: CPU2: patch_level=0x08101016
Jul 20 04:13:41 rageworks kernel: CPU2 is up
Jul 20 04:13:41 rageworks kernel: smpboot: Booting Node 0 Processor 3 
APIC 0x3
Jul 20 04:13:41 rageworks kernel: microcode: CPU3: patch_level=0x08101016
Jul 20 04:13:41 rageworks kernel: CPU3 is up
Jul 20 04:13:41 rageworks kernel: ACPI: PM: Waking up from system sleep 
state S3
Jul 20 04:13:41 rageworks kernel: xhci_hcd 0000:02:00.0: xHC error in 
resume, USBSTS 0x401, Reinit
Jul 20 04:13:41 rageworks kernel: usb usb1: root hub lost power or was reset
Jul 20 04:13:41 rageworks kernel: usb usb2: root hub lost power or was reset
Jul 20 04:13:41 rageworks kernel: serial 00:05: activated
Jul 20 04:13:41 rageworks kernel: sd 0:0:0:0: [sda] Starting disk
Jul 20 04:13:41 rageworks kernel: sd 1:0:0:0: [sdb] Starting disk
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Starting disk
Jul 20 04:13:41 rageworks kernel: ata5: SATA link down (SStatus 0 
SControl 330)
Jul 20 04:13:41 rageworks kernel: ata9: SATA link down (SStatus 0 
SControl 300)
Jul 20 04:13:41 rageworks kernel: ata6: SATA link down (SStatus 0 
SControl 330)
Jul 20 04:13:41 rageworks kernel: usb 1-7: reset full-speed USB device 
number 2 using xhci_hcd
Jul 20 04:13:41 rageworks kernel: usb 1-10: reset full-speed USB device 
number 4 using xhci_hcd
Jul 20 04:13:41 rageworks kernel: usb 1-8: reset full-speed USB device 
number 3 using xhci_hcd
Jul 20 04:13:41 rageworks kernel: ata2: found unknown device (class 0)
Jul 20 04:13:41 rageworks kernel: ata1: found unknown device (class 0)
Jul 20 04:13:41 rageworks kernel: ata10: found unknown device (class 0)
Jul 20 04:13:41 rageworks kernel: ata2: SATA link up 6.0 Gbps (SStatus 
133 SControl 300)
Jul 20 04:13:41 rageworks kernel: ata2.00: configured for UDMA/133
Jul 20 04:13:41 rageworks kernel: ata1: SATA link up 6.0 Gbps (SStatus 
133 SControl 300)
Jul 20 04:13:41 rageworks kernel: ata1.00: configured for UDMA/133
Jul 20 04:13:41 rageworks kernel: ata10: SATA link up 6.0 Gbps (SStatus 
133 SControl 300)
Jul 20 04:13:41 rageworks kernel: ata10.00: configured for UDMA/133
Jul 20 04:13:41 rageworks kernel: ata10: SATA link up 6.0 Gbps (SStatus 
133 SControl 300)
Jul 20 04:13:41 rageworks kernel: ata10.00: configured for UDMA/133
Jul 20 04:13:41 rageworks kernel: ata10.00: device reported invalid CHS 
sector 0
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Start/Stop Unit 
failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Sense Key : Illegal 
Request [current]
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Add. Sense: 
Unaligned write command
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: dpm_run_callback(): 
scsi_bus_resume+0x0/0x90 returns -5
Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: failed to resume 
async: error -5
Jul 20 04:13:41 rageworks kernel: OOM killer enabled.
Jul 20 04:13:41 rageworks kernel: Restarting tasks ... done.
Jul 20 04:13:41 rageworks kernel: random: crng reseeded on system resumption
Jul 20 04:13:41 rageworks kernel: PM: suspend exit
Jul 20 04:13:41 rageworks rtkit-daemon[1349]: The canary thread is 
apparently starving. Taking action.
Jul 20 04:13:41 rageworks systemd-sleep[2059]: System returned from 
sleep state.
Jul 20 04:13:41 rageworks rtkit-daemon[1349]: Demoting known real-time 
threads.
Jul 20 04:13:41 rageworks systemd[1]: NetworkManager-dispatcher.service: 
Deactivated successfully.
Jul 20 04:13:41 rageworks rtkit-daemon[1349]: Successfully demoted 
thread 1597 of process 1342.
Jul 20 04:13:41 rageworks rtkit-daemon[1349]: Successfully demoted 
thread 1342 of process 1342.
Jul 20 04:13:41 rageworks rtkit-daemon[1349]: Demoted 2 threads.
Jul 20 04:13:42 rageworks systemd[1]: systemd-suspend.service: 
Deactivated successfully.
Jul 20 04:13:42 rageworks systemd[1]: Finished System Suspend.
Jul 20 04:13:42 rageworks systemd[1]: Stopped target Sleep.
Jul 20 04:13:42 rageworks systemd[1]: Reached target Suspend.
Jul 20 04:13:42 rageworks systemd[1]: Stopped target Suspend.
Jul 20 04:13:42 rageworks systemd-logind[869]: Operation 'sleep' finished.


Thanks
