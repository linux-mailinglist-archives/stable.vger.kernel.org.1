Return-Path: <stable+bounces-121562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16753A582EF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E140B3AC49B
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845681A4F22;
	Sun,  9 Mar 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="YM6DHCOx"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECF1A8418
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515306; cv=none; b=JmFPL+yC9Knt4+TJK8XQnKB7RiwX/4wzYsYJYHgxuxB88H44onkW3Y00EFxG5beCN3QVKJXw+vXBTrqbsQ84Qi6ba9zTLSvrWBzHc7eebETbwCOIdXmyuEKxdUWSK/0WWadyZPteq3MvZ1Q00gYy65HmfVSi02oOVCzjqknmAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515306; c=relaxed/simple;
	bh=6+sx/uKbcT/XifleL+nJx9XxBtH/gNc4zUHID3ZvHVg=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=dW5cZQ5YC/Xo3CgnXV654FKg0H4HCFH/9lOf1PAGEQxWpY28I85q4cG8E+UWcs63dQn4pc8PzjMRw6ODl5lCCWli5TT4YeLf50NYr/VaHxuEB5jIoaBGFAxjI2FE6i/8Bow+G4ikPqlShLGMZjRE7s3kGdYGqoFg4dkr++sZf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=YM6DHCOx; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 3B5211C16F1
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 13:14:58 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:to:in-reply-to:content-language:user-agent
	:mime-version:date:date:message-id; s=dkim; t=1741515297; x=
	1742379298; bh=6+sx/uKbcT/XifleL+nJx9XxBtH/gNc4zUHID3ZvHVg=; b=Y
	M6DHCOxoSiR9EYSXxKZvJ6dVgq9PFXg+Am+Cp+KsDtExmmR9S+tUvprejlmz4ODF
	TgZd7KAv34ild76Sd1aJIb/S4CyieVDxCAdphIcm2f1649fVP/HpeJQhMXW9m8Jv
	Pbq4f5fHk1arETL5z77hY866YnRXZrUJyYMA/vcAdw=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dDMRgxBwuXjf for <stable@vger.kernel.org>;
	Sun,  9 Mar 2025 13:14:57 +0300 (MSK)
Received: from [192.168.1.67] (unknown [46.72.98.152])
	by mail.nppct.ru (Postfix) with ESMTPSA id DCEC91C0B18;
	Sun,  9 Mar 2025 13:14:52 +0300 (MSK)
Message-ID: <c315940b-dbdb-4acb-b319-d3b0fd53eb0d@nppct.ru>
Date: Sun, 9 Mar 2025 13:14:51 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
In-Reply-To: <Y8bTM3cbL3x9nhKa@google.com>
To: lee@kernel.org
Cc: ardb@kernel.org, greg@kroah.com, keescook@chromium.org,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 samitolvanen@google.com, stable@vger.kernel.org, will@kernel.org,
 lvc-project@linuxtesting.org
From: SDL <sdl@nppct.ru>
Subject: Re: [PATCH 1/2] arm64: efi: Execute runtime services from a dedicated
 stack
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux Kernel Developers,
I have reason to believe that the commit 
4012603cbd469223f225637d265a233f034c567a, which was backported to the 
linux-5.10 branch, is introducing a bug that leads to a kernel crash.

Environment Details:

Kernel Version: linux-5.10.234
Architecture: aarch64
Kernel Configuration: Available at
https://syzkaller.appspot.com/bug?extid=75dc11b3aa0369757b7c
QEMU Version: 8.2.2

QEMU Launch Command:

qemu-system-aarch64 \
     -m 4G \
     -smp 4,sockets=1,cores=4,threads=1 \
     -cpu cortex-a57 \
     -machine virt,accel=tcg \
     -kernel /home/user/lvc/linux-stable/arch/arm64/boot/Image \
     -append "console=ttyS0 root=/dev/vda2 earlyprintk=serial 
net.ifnames=0 rw debug loglevel=8" \
     -drive 
file=/home/user/lvc/image/disk.raw,format=raw,if=virtio,index=1 \
     -bios /usr/share/AAVMF/AAVMF_CODE.fd \
     -netdev user,id=net0,hostfwd=tcp::10022-:22 \
     -device virtio-net-device,netdev=net0 \
     -nographic

Steps to Reproduce:

mount -t sysfs sysfs /sys
mount -t proc proc /proc
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
tools/testing/selftests/efivarfs/efivarfs.sh

Crash log:

[  101.403235][   T38] Unable to handle kernel paging request at virtual 
address ffffa00023b20000
[  101.403905][   T38] Mem abort info:
[  101.404159][   T38]   ESR = 0x96000047
[  101.404448][   T38]   EC = 0x25: DABT (current EL), IL = 32 bits
[  101.404748][   T38]   SET = 0, FnV = 0
[  101.404988][   T38]   EA = 0, S1PTW = 0
[  101.405233][   T38] Data abort info:
[  101.405469][   T38]   ISV = 0, ISS = 0x00000047
[  101.405721][   T38]   CM = 0, WnR = 1
[  101.406070][   T38] swapper pgtable: 4k pages, 48-bit VAs, 
pgdp=0000000103336000
[  101.406415][   T38] [ffffa00023b20000] pgd=000000013ffff003, 
p4d=000000013ffff003, pud=000000013fffe003, pmd=000000013fff9003, 
pte=0000000000000000
[  101.407997][   T38] Internal error: Oops: 0000000096000047 [#1] 
PREEMPT SMP
[  101.408446][   T38] Modules linked in:
[  101.409010][   T38] CPU: 1 PID: 38 Comm: kworker/u8:2 Not tainted 
5.10.234 #61
[  101.409376][   T38] Hardware name: QEMU QEMU Virtual Machine, BIOS 
2024.02-2ubuntu0.1 10/25/2024
[  101.410689][   T38] Workqueue: efi_rts_wq efi_call_rts
[  101.411219][   T38] pstate: 000003c5 (nzcv DAIF -PAN -UAO -TCO BTYPE=--)
[  101.411574][   T38] pc : el1_sync+0xc/0x140
[  101.411930][   T38] lr : 0x0
[  101.412132][   T38] sp : ffffa00023b1ffd0
[  101.412363][   T38] x29: 0000000000000000 x28: ffff0000cc741a80
[  101.412761][   T38] x27: 0000000000000001 x26: 0000000000e800e8
[  101.413117][   T38] x25: 0000000000800080 x24: ffff940004765298
[  101.413465][   T38] x23: 00000000100003c5 x22: ffffa00018c95600
[  101.413809][   T38] x21: ffffa0001923a980 x20: ffffa00018d30380
[  101.414170][   T38] x19: ffffa0001bab8008 x18: 1fffe000198e8491
[  101.414515][   T38] x17: 0000000000000000 x16: ffffa000102a26c0
[  101.414882][   T38] x15: 0000000000000001 x14: ffff0000ccf34400
[  101.415277][   T38] x13: 000000000000003c x12: ffff0000ccf34000
[  101.415656][   T38] x11: 0000000000000018 x10: 0000000000000054
[  101.416072][   T38] x9 : 4fc79849210be57c x8 : 11d293ca8be4df61
[  101.416446][   T38] x7 : 0000000041b58ab3 x6 : ffff94000476522a
[  101.416820][   T38] x5 : 0000002200000000 x4 : 0000000200000000
[  101.417190][   T38] x3 : 1fffe000198e8352 x2 : ffffa0001923a820
[  101.417560][   T38] x1 : ffff0000cc741a80 x0 : 0000000000000000
[  101.418109][   T38] Call trace:
[  101.418601][   T38] Code: d503201f a90007e0 a9010fe2 a90217e4 (a9031fe6)
[  101.419579][   T38] ---[ end trace 61316cddfdbbcb95 ]---
[  103.623221][   T38] Kernel panic - not syncing: Oops: Fatal exception
[  103.623723][   T38] SMP: stopping secondary CPUs
[  105.221708][   T38] SMP: failed to stop secondary CPUs 0-3
[  105.222306][   T38] Kernel Offset: disabled
[  105.222711][   T38] CPU features: 0x28240022,61002082
[  105.222969][   T38] Memory Limit: none

I identified this commit as the potential cause of the crash using git 
bisect. The issue is reproducible with the above setup and 
configuration. If you need more details or logs, I am more than willing 
to provide them. Thank you for your attention to this matter.

Best regards,

Alexey Nepomnyashih

