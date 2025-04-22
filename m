Return-Path: <stable+bounces-134996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB8A95C79
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55723AF47F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 03:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C276D18DB1A;
	Tue, 22 Apr 2025 03:06:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B12C18A
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291202; cv=none; b=esRwouRRCJvpmywz4uivinZ6eRmYmKIzntzMjHRGbKCM9DHMCpKwMSHFWWVTYszxi66W0edL0QFwGqe7Q0sVuPZjzXKYmKcisSjHWabWJ7rmCVEPCOR6RJCqe3y0PdRR8T8lUCdBqaOWJgQh1WlKct57ld8UUH1XnEXGtKiXlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291202; c=relaxed/simple;
	bh=CyGkjI7pENuCyA0wW6k/D9TFjybQSu+6QY6S3B13vlQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=d6u1esw/L3K5RKKSEFU1RkFIbzf6LWbua5Du7ufqCrt80xhWKZX1hjweqDfYbBmc+We1IeY3BHNEsJkWR68CpEz3n1PInZw6hDH2EL7mMy2fAnFnDXIXpLBzgpzazk0JFK6w83XyEuE8L8+gwLl9/nd1SZQFN3jLiExytOoGM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.3.9] (unknown [113.233.63.114])
	by APP-05 (Coremail) with SMTP id zQCowAAXUwvhBQdofZAiCw--.57342S3;
	Tue, 22 Apr 2025 10:58:42 +0800 (CST)
Message-ID: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
Date: Tue, 22 Apr 2025 10:58:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kai Zhang <zhangkai@iscas.ac.cn>
Subject: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Language: en-US
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXUwvhBQdofZAiCw--.57342S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4rGF4kCF1UAr4xWFW5trb_yoWDKrg_A3
	yUKFZ8ur45CrZ7ua13Kr1rXrWqkwn29Fy8Ww1jkas2qr93t398AanYgr1Iy3WUGrZ3JF98
	J34aqFnaqrya9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOWl9UUUUU=
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/

In most recent linux-6.6.y tree, 
`arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the 
obsolete code:

     u32 insn = __BUG_INSN_32;
     unsigned long offset = GET_INSN_LENGTH(p->opcode);
     p->ainsn.api.restore = (unsigned long)p->addr + offset;
     patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
     patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);

The last two 1s are wrong size of written instructions , which would 
lead to kernel crash, like `insmod kprobe_example.ko` gives:

[  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
[  509.837606][    C5] handler_pre: <kernel_clone> p->addr = 
0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
[  509.839315][    C5] Oops - illegal instruction [#1]


I've tried two patchs from torvalds tree and it didn't crash again:

51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
13134cc94914 riscv: kprobes: Fix incorrect address calculation

Regards,
laokz



