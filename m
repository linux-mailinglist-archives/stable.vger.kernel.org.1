Return-Path: <stable+bounces-19433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED6850A13
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2632281DEA
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EEA5B685;
	Sun, 11 Feb 2024 15:42:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9D5B673;
	Sun, 11 Feb 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666139; cv=none; b=j4N0H4NxENXGPDHuPBLtVF9LWtw1efmn7CjR26ilauuJ+kX11OXV0v8I8WtOm2Q5x3Ha+A688B9sCaU4oxZTQFMynCxHSBWgrPW/qK6xft324kfJJdW7Dege2t3k4vpYh2byWl7Ub0mh7BCfKgTagYIaTPphrvcApIQ6QKQ28R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666139; c=relaxed/simple;
	bh=rgaMA3FkZSxtEScGCwmEjxUH8bFBiNFv/875fNpb65E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P0VdKpR5ptFvmBw/UDuchKFAUmNx2we50zhiSycFspYKsnAaYhyeTGCCMLIr/kEbHu/2EU8tQWFrOD2HobOId2XTd00le15VuM2wkrmsJLY43PGtPDVGE4bRv0vLYBpUE34yRmb2FIEhlms64ezLVILAuUFAh6LBgvqTfZ8mlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 7C51E8963D6;
	Sun, 11 Feb 2024 16:42:14 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-usb@vger.kernel.org
Subject: I/O errors while writing to external Transcend XS-2000 4TB SSD
Date: Sun, 11 Feb 2024 16:42:14 +0100
Message-ID: <1854085.atdPhlSkOF@lichtvoll.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

This is not exactly a regression, as I am not aware of a prior working
state, but kernel documentation advises me to CC regressions list anyway=C2=
=B9.

I am trying to put data on an external Kingston XS-2000 4 TB SSD using
self-compiled Linux 6.7.4 kernel and encrypted BCacheFS. I do not think
BCacheFS has any part in the errors I see, but if you disagree feel free
to CC the BCacheFS mailing list as you reply.

I am using a ThinkPad T14 AMD Gen 1 with AMD Ryzen 7 PRO 4750U and 32
GiB of RAM.

I connected the SSD onto USB-C port directly with the ThinkPad. lsusb
lists it as:

Bus 007 Device 004: ID 0951:176b Kingston Technology XS2000

The SSD is detected as follows:

[20303.913644] usb 7-1: new SuperSpeed Plus Gen 2x1 USB device number 9 usi=
ng xhci_hcd
[20303.926616] usb 7-1: New USB device found, idVendor=3D0951, idProduct=3D=
176b, bcdDevice=3D 1.00
[20303.926633] usb 7-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[20303.926641] usb 7-1: Product: XS2000
[20303.926647] usb 7-1: Manufacturer: Kingston
[20303.926652] usb 7-1: SerialNumber: [=E2=80=A6]
[20303.929078] scsi host0: uas
[20303.983859] scsi 0:0:0:0: Direct-Access     Kingston XS2000           10=
00 PQ: 0 ANSI: 6
[20303.984426] sd 0:0:0:0: Attached scsi generic sg0 type 0
[20303.985197] sd 0:0:0:0: [sda] 8001573552 512-byte logical blocks: (4.10 =
TB/3.73 TiB)
[20303.985331] sd 0:0:0:0: [sda] Write Protect is off
[20303.985341] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
[20303.985579] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[20303.989516]  sda: sda1
[20303.989611] sd 0:0:0:0: [sda] Attached SCSI disk

BCacheFS is mounted as follows =E2=80=93 but I suspect BCacheFS is not invo=
lved in
those errors anyway:

[20310.437864] bcachefs (sda1): mounting version 1.3: rebalance_work opts=
=3Dmetadata_checksum=3Dxxhash,data_checksum=3Dxxhash,compression=3Dlz4
[20310.437895] bcachefs (sda1): recovering from clean shutdown, journal seq=
 5094
[20310.450813] bcachefs (sda1): alloc_read... done
[20310.450851] bcachefs (sda1): stripes_read... done
[20310.450855] bcachefs (sda1): snapshots_read... done
[20310.470815] bcachefs (sda1): journal_replay... done
[20310.470824] bcachefs (sda1): resume_logged_ops... done
[20310.470835] bcachefs (sda1): going read-write


During rsync'ing about 1,4 TB of data after eventually a hour I got
things like this:

[33963.462694] sd 0:0:0:0: [sda] tag#10 uas_zap_pending 0 uas-tag 1 infligh=
t: CMD=20
[33963.462708] sd 0:0:0:0: [sda] tag#10 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 bc 00 00 00 04 00 00 00
[33963.462718] sd 0:0:0:0: [sda] tag#11 uas_zap_pending 0 uas-tag 2 infligh=
t: CMD=20
[33963.462725] sd 0:0:0:0: [sda] tag#11 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 c8 00 00 00 04 00 00 00
[33963.462733] sd 0:0:0:0: [sda] tag#15 uas_zap_pending 0 uas-tag 3 infligh=
t: CMD=20
[33963.462740] sd 0:0:0:0: [sda] tag#15 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 d2 4c 00 00 01 2f 00 00
[33963.462748] sd 0:0:0:0: [sda] tag#12 uas_zap_pending 0 uas-tag 4 infligh=
t: CMD=20
[33963.462754] sd 0:0:0:0: [sda] tag#12 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 d0 00 00 00 02 4c 00 00
[33963.462762] sd 0:0:0:0: [sda] tag#13 uas_zap_pending 0 uas-tag 5 infligh=
t: CMD=20
[33963.462769] sd 0:0:0:0: [sda] tag#13 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 d4 00 00 00 00 ff 00 00
[33963.462777] sd 0:0:0:0: [sda] tag#14 uas_zap_pending 0 uas-tag 6 infligh=
t: CMD=20
[33963.462783] sd 0:0:0:0: [sda] tag#14 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 ce 00 00 00 00 cc 00 00
[33963.576991] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 9 u=
sing xhci_hcd
[33963.590793] scsi host0: uas_eh_device_reset_handler success
[33963.592857] sd 0:0:0:0: [sda] tag#10 timing out command, waited 180s
[33963.592872] sd 0:0:0:0: [sda] tag#10 FAILED Result: hostbyte=3DDID_RESET=
 driverbyte=3DDRIVER_OK cmd_age=3D182s
[33963.592881] sd 0:0:0:0: [sda] tag#10 CDB: Write(16) 8a 00 00 00 00 00 82=
 c1 bc 00 00 00 04 00 00 00
[33963.592886] I/O error, dev sda, sector 2193734656 op 0x1:(WRITE) flags 0=
x104000 phys_seg 773 prio class 2
[33963.592898] bcachefs (sda1 inum 1073761281 offset 265216): data write er=
ror: I/O
[33963.592925] bcachefs (sda1 inum 1073761281 offset 467456): data write er=
ror: I/O
[33963.592933] bcachefs (sda1 inum 1073761281 offset 470016): data write er=
ror: I/O
[33963.592939] bcachefs (sda1 inum 1073761281 offset 471552): data write er=
ror: I/O
[33963.592949] bcachefs (sda1 inum 1073761281 offset 514560): data write er=
ror: I/O
[33963.592956] bcachefs (sda1 inum 1073761281 offset 517120): data write er=
ror: I/O
[33963.592963] bcachefs (sda1 inum 1073761281 offset 519168): data write er=
ror: I/O
[33963.592969] bcachefs (sda1 inum 1073761281 offset 521728): data write er=
ror: I/O
[33963.592976] bcachefs (sda1 inum 1073761281 offset 523776): data write er=
ror: I/O
[33963.592983] bcachefs (sda1 inum 1073761281 offset 526336): data write er=
ror: I/O

The rsync completed but I did not trust the result, even tough
"bcachefs fsck" told me the filesystem structure is okay.

Thus I reran rsync with option "-c" for checksumming. After a long time
with data that did match, it started to transfer a file again which should
not happen if data would have been identical. As it ran into I/O errors
again, I stopped the rsync process.

I looked for that UAS error message and according to the article=C2=B2 I
found I disabled UAS as follows:

% cat /etc/modprobe.d/disable-uas.conf
# Does not work with external SSD Transcend XS2000 4TB
options usb-storage quirks=3D0951:176b:u

The quirk was applied as I reconnected the devices after unloading
both usb-storage and uas modules:

[   55.871301] usb 7-1: UAS is ignored for this device, using usb-storage i=
nstead
[   55.871310] usb-storage 7-1:1.0: USB Mass Storage device detected
[   55.871559] usb-storage 7-1:1.0: Quirks match for vid 0951 pid 176b: 800=
000

I recreated the BCacheFS filesystem and tried again. This time it did
not take more than 10 minutes for the first I/O error to appear. Unless
with UAS it made rsync stop with an I/O error immediately. Before that
there were several USB resets. Here is the excerpt from dmesg:

[  795.768306] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[  932.976677] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[  963.189438] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[ 1000.057333] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[ 1036.917137] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[ 1073.782876] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[ 1110.647786] usb 7-1: reset SuperSpeed Plus Gen 2x1 USB device number 4 u=
sing xhci_hcd
[ 1117.163693] sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_ABORT =
driverbyte=3DDRIVER_OK cmd_age=3D214s
[ 1117.163718] sd 0:0:0:0: [sda] tag#0 CDB: Write(16) 8a 00 00 00 00 00 02 =
72 20 00 00 00 08 00 00 00
[ 1117.163725] I/O error, dev sda, sector 41033728 op 0x1:(WRITE) flags 0x1=
04000 phys_seg 1551 prio class 2
[ 1117.163739] bcachefs (sda1 inum 1879048481 offset 2572800): data write e=
rror: I/O
[ 1117.163763] bcachefs (sda1 inum 1879048481 offset 2576384): data write e=
rror: I/O
[ 1117.163771] bcachefs (sda1 inum 1879048481 offset 2578432): data write e=
rror: I/O
[ 1117.163779] bcachefs (sda1 inum 1879048481 offset 2580480): data write e=
rror: I/O
[ 1117.163786] bcachefs (sda1 inum 1879048481 offset 2582528): data write e=
rror: I/O
[ 1117.163794] bcachefs (sda1 inum 1879048481 offset 2584576): data write e=
rror: I/O
[ 1117.163803] bcachefs (sda1 inum 1879048481 offset 2586624): data write e=
rror: I/O
[ 1117.163811] bcachefs (sda1 inum 1879048481 offset 2588672): data write e=
rror: I/O
[ 1117.163818] bcachefs (sda1 inum 1879048481 offset 2590720): data write e=
rror: I/O
[ 1117.163824] bcachefs (sda1 inum 1879048481 offset 2592768): data write e=
rror: I/O

So even without UAS the device does not seem to like to write data on
Linux.

Next steps may involve looking for a firmware update for the external SSD
as well as trying to obtain its SMART status. So far I did not succeed in
finding the right options for smartctl. In case there is enough evidence
that the device is defective I'd try to RMA it.

I will keep a copy of kernel log and I could do some further tests as time
permits. So let me know whether you need anything else, but for now
the mail is long enough as it is.


[1] https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

[2] How to disable USB Attached Storage (UAS)
Last edited on 4 December 2022, at 14:00

https://leo.leung.xyz/wiki/How_to_disable_USB_Attached_Storage_(UAS)

Ciao,
=2D-=20
Martin



