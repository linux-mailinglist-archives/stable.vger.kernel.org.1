Return-Path: <stable+bounces-176879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE0B3EA96
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF997B2861
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C61F3B98;
	Mon,  1 Sep 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b="JamioJuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.dnamail.fi (sender001.dnamail.fi [83.102.40.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10020334372;
	Mon,  1 Sep 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.40.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740066; cv=none; b=Q+3Lb/tDuGv/ki1lBx99pzTn8aDbaHdrXDY0Pg96PfAbE3PU6G2xft+AdZQtFVgmC757Z2OUBExXaYU5bdgxW4Y9zDjnvq0vUDId+uUVX4S8xlPCmx6urGEGU5EQX13CA6lhWimjaM6tHIUo+wixsFwA5sle+4fPstQJcWCH69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740066; c=relaxed/simple;
	bh=4MXorRygA3iS+ycoLelxrTTNdpMNmF6JkScxrjohY68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCJSk1LMXRvPnMzwbzy3pHrD0SZx7GflFKhnLt1hFJd/ikKk5nchXK79mG8rO1pqOPE0Goa7aYUXkPAGof6XjnwE9dqPTRnbryGEjHZArhDcagzpctjtR6ilxeQrZ3oewcMwLCW7lwjUquCKaCC0az2yNizyJ2ave+YB3zH/5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b=JamioJuo; arc=none smtp.client-ip=83.102.40.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Received: from localhost (localhost [127.0.0.1])
	by smtp.dnamail.fi (Postfix) with ESMTP id EA3C12113FDE;
	Mon,  1 Sep 2025 18:13:00 +0300 (EEST)
X-Virus-Scanned: X-Virus-Scanned: amavis at smtp.dnamail.fi
Received: from smtp.dnamail.fi ([83.102.40.178])
 by localhost (dmail-psmtp01.s.dnaip.fi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id d7tmIfMIGLGX; Mon,  1 Sep 2025 18:12:59 +0300 (EEST)
Received: from [192.168.101.100] (87-92-61-203.bb.dnainternet.fi [87.92.61.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: oak@dnamail.internal)
	by smtp.dnamail.fi (Postfix) with ESMTPSA id 1426E2113E0B;
	Mon,  1 Sep 2025 18:12:53 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dnamail.fi 1426E2113E0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helsinkinet.fi;
	s=2025-03; t=1756739579;
	bh=pd2r8zAJCyTMArHVQIHS7IIjNpjZF/Rb/ZQJCnx4bzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JamioJuoeiN7QczyB3T5zGC9ajP+/uWKCaeIzE7JtGaHVdOveU6j5nivGA1bW0r9l
	 WsHr9r6qBBRP58NeY2GvU5Hle2aWMiJU48BUkxLAa58nZyX5i1oQvZ0Jd6X0qhJRxo
	 SCUp5f46+KTEuyE8ecbwphl7kob8qqisDgiXQ+7R3wBYDKrXVj1eqYPi2tNOwg/gLz
	 a3GquxmdlACo4ak1bhoqwGqlWOMkksUuV0zqQOSPtUi4H4KG2x7mk6rOz9rqu6+Wa3
	 Los+xKGZb/wy3LItojmYirnerShUvTFtbna0BDyw9UScbHYFL57jQLrkNECZhUe1RF
	 VKEbYv0HKL2bg==
Message-ID: <617b6c79-2d66-467f-89a0-79d2d2efb714@helsinkinet.fi>
Date: Mon, 1 Sep 2025 18:12:53 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
 <CAMuHMdUKgMfL+1EnkZbbqNqTv4aMs_XWocXxq5jVGeOMaQXnDQ@mail.gmail.com>
Content-Language: en-US
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <CAMuHMdUKgMfL+1EnkZbbqNqTv4aMs_XWocXxq5jVGeOMaQXnDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

On 1.9.2025 11.51, Geert Uytterhoeven wrote:
>> On 23.8.2025 10.49, Lance Yang wrote:
>>   > Anyway, I've prepared two patches for discussion, either of which should
>>   > fix the alignment issue :)
>>   >
>>   > Patch A[1] adjusts the runtime checks to handle unaligned pointers.
>>   > Patch B[2] enforces 4-byte alignment on the core lock structures.
>>   >
>>   > Both tested on x86-64.
>>   >
>>   > [1]
>> https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev
>>   > [2] https://lore.kernel.org/lkml/20250823074048.92498-1-
>>   > lance.yang@linux.dev
>>
>> Same goes for both of these, except that removing warnings makes minimal
>> kernel boot 1-2% faster than 4-aligning the whole struct.

Note that above result was from (emulated) 68030 Falcon, i.e. something 
that has really small caches (256-byte i-/d-cache), *and* a kernel 
config using CONFIG_CC_OPTIMIZE_FOR_SIZE=y (with GCC 12.2).


> That is an interesting outcome! So the gain of naturally-aligning the
> lock is more than offset by the increased cache pressure due to wasting
> (a bit?) more memory.

Another reason could be those extra inlined warning checks in:
-----------------------------------------------------
$ git grep -e hung_task_set_blocker -e hung_task_clear_blocker kernel/
kernel/locking/mutex.c: hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
kernel/locking/mutex.c: hung_task_clear_blocker();
kernel/locking/rwsem.c:         hung_task_set_blocker(sem, 
BLOCKER_TYPE_RWSEM_READER);
kernel/locking/rwsem.c:         hung_task_clear_blocker();
kernel/locking/rwsem.c:         hung_task_set_blocker(sem, 
BLOCKER_TYPE_RWSEM_WRITER);
kernel/locking/rwsem.c:         hung_task_clear_blocker();
kernel/locking/semaphore.c:     hung_task_set_blocker(sem, 
BLOCKER_TYPE_SEM);
kernel/locking/semaphore.c:     hung_task_clear_blocker();
-----------------------------------------------------


> Do you know what was the impact on total kernel size?

As expected, kernel code size is smaller with the static inlined warn 
checks removed:
-----------------------------------------------------
$ size vmlinux-m68k-6.16-fix1 vmlinux-m68k-6.16-fix2
    text	   data	    bss	    dec	    hex	filename
3088520	 953532	  84224	4126276	 3ef644	vmlinux-m68k-6.16-fix1  [1]
3088730	 953564	  84192	4126486	 3ef716	vmlinux-m68k-6.16-fix2  [2]
-----------------------------------------------------

But could aligning of structs have caused 32 bytes moving from BSS to 
DATA section?


	- Eero

PS. I profiled these 3 kernels on emulated Falcon. According to (Hatari) 
profiler, main difference in the kernel with the warnings removed, is it 
doing less than half of the calls to  NCR5380_read() / 
atari_scsi_reg_read(), compared to the other 2 versions.

These additional 2x calls in the other two versions, seem to mostly come 
through chain originating from process_scheduled_works(), 
NCR5380_poll_politely*() functions and bus probing.

After quick look at the WARN_ON_ONCE()s and SCSI code, I have no idea 
how having those checks being inlined to locking functions, or not, 
would cause a difference like that.  I've tried patching & building 
kernels again, and repeating profiling, but result is same.

While Hatari call (graph) tracking might have some issue (due to kernel 
stack return address manipulation), I don't see how there could be a 
problem with the profiler instruction counts.  Kernel code at given 
address does not change during boot in monolithic kernel, (emulator) 
profiler tracks _every_ executed instruction/address, and it's clearly 
correct function:
------------------------------------
# disassembly with profile data: <instructions percentage>% (<sum of 
instructions>, <sum of cycles>, <sum of i-cache misses>, <sum of d-cache 
hits>)
...
atari_scsi_falcon_reg_read:
$001dd826  link.w    a6,#$0      0.43% (414942, 1578432, 44701, 0)
$001dd82a  move.w    sr,d1       0.43% (414942, 224, 8, 0)
$001dd82c  ori.w     #$700,sr    0.43% (414942, 414368, 44705, 0)
$001dd830  move.l    $8(a6),d0   0.43% (414942, 357922, 44705, 414911)
$001dd834  addi.l    #$88,d0     0.43% (414942, 1014804, 133917, 0)
$001dd83a  move.w    d0,$8606.w  0.43% (414942, 3618352, 89169, 0)
$001dd83e  move.w    $8604.w,d0  0.43% (414942, 3620646, 89162, 0)
$001dd842  move.w    d1,sr       0.43% (414942, 2148, 142, 0)
$001dd844  unlk      a6          0.43% (414942, 436, 0, 414893)
$001dd846  rts                   0.43% (414942, 1073934, 134123, 414942)
atari_scsi_falcon_reg_write:
$001dd848  link.w    a6,#$0      0.00% (81, 484, 29, 0)
$001dd84c  move.l    $c(a6),d0   0.00% (81, 326, 29, 73)
...
------------------------------------

Maybe those WARN_ON_ONCE() checks just happen to slow down something 
marginally so that things get interrupted & re-started more for the SCSI 
code?

PPS. emulated machine has no SCSI drives, only one IDE drive (with 4MB 
Busybox partition):
----------------------------------------------------
scsi host0: Atari native SCSI, irq 15, io_port 0x0, base 0x0, can_queue 
1, cmd_per_lun 2, sg_tablesize 1, this_id 7, flags { }
atari-falcon-ide atari-falcon-ide: Atari Falcon and Q40/Q60 PATA controller
scsi host1: pata_falcon
ata1: PATA max PIO4 cmd fff00000 ctl fff00038 data fff00000 no IRQ, 
using PIO polling
...
ata1: found unknown device (class 0)
ata1.00: ATA-7: Hatari  IDE disk 4M, 1.0, max UDMA/100
ata1.00: 8192 sectors, multi 16: LBA48
ata1.00: configured for PIO
...
scsi 1:0:0:0: Direct-Access     ATA      Hatari  IDE disk 1.0  PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 8192 512-byte logical blocks: (4.19 MB/4.00 MiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
sd 1:0:0:0: [sda] Attached SCSI disk
VFS: Mounted root (ext2 filesystem) readonly on device 8:0.
---------------------------------------------------

