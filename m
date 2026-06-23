Return-Path: <stable+bounces-267929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NkKjBnpyOmrp9AcAu9opvQ
	(envelope-from <stable+bounces-267929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:48:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B967E6B6DB1
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:48:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=stu.xidian.edu.cn header.s=dkim header.b=fvodauGg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267929-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=xidian.edu.cn (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E231304DEA6
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A253D47CF;
	Tue, 23 Jun 2026 11:48:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8C2D63E5;
	Tue, 23 Jun 2026 11:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215282; cv=none; b=gOPO9JakYw1YN6KAhS/ZxubEJw08XpG69B3ijTgR0+bgaqmny3m9tlw6G0uXHie9JNfSD7N3Z4WeR5lwFjbfK4nokEFdLLqbDRUstdmUt7bFVd1H0vBJvOmU7Kts28czU7EXuAMEsGkT0M5XwHfw5zsD4hcfmBQnG6MQjKMlIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215282; c=relaxed/simple;
	bh=oaYsPIiRr7O+D3CaQD7H9ELKJrE/yqkcdbXvz2dNA2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnQIjaTachobW4GCBrJMm4EPAKsqKeRMVSVXHR+LtgC1t5Jw+Rg5Lvx9bXboQdbC1IqSxnjThm5IbSt4GzwY+MHDBel7XMJsk159tp3oVAuU1RGv7wYwohIWQi6gDW0hyd6mOEst70q2zo0kjbBifv4Z7WO1SetyUd58fihHiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=fvodauGg reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=riT3aCfBg
	TqpJw4wns4sVNKZ8p18asVLyO8oYAD4aAE=; b=fvodauGg7nCWuaCTVO3YLh04Z
	bHSz12BJFERC8lfPrpQ1f1Vs4KaAmFvO03QRTpQqfi8j1oF8c5OqWcQD6iBMjuIO
	fXplDULp9/J6UIQglT8Z3Tgo1F1jHHOQHJGE6MYk+uvuK1kUa/7VY4NO9F3ttQNW
	1XeNs3fRUUbFYAGmnU=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkD2GzZfcjpq3ZsQAw--.28590S3;
	Tue, 23 Jun 2026 19:47:44 +0800 (CST)
Message-ID: <62e6c81c-a904-450b-8e32-7861e41412bb@stu.xidian.edu.cn>
Date: Tue, 23 Jun 2026 19:47:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: ibmasm: Fix out-of-bounds MMIO access during module
 load
To: Greg KH <gregkh@linuxfoundation.org>, w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
 stable@vger.kernel.org
References: <20260623070909.362260-1-w15303746062@163.com>
 <2026062354-crawfish-t-shirt-d45d@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026062354-crawfish-t-shirt-d45d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkD2GzZfcjpq3ZsQAw--.28590S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw43Gr4Dury3Cw4kXFy5urg_yoWkCFbEk3
	sYv3srGr4ayrZIv3Wag3ZxZFn2k3929r93X3y0qr17X34rXrW7uF4DXr1Svryft34ktrs3
	Ww15Zrn5Aw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07jFpB-UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUNEWo5UXK2FwABsL
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,163.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:w15303746062@163.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267929-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stu.xidian.edu.cn:mid,stu.xidian.edu.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B967E6B6DB1

Hi Greg,

> The kernel trusts the hardware to not do foolish things like this 🙂
>> When evaluating the driver against emulated hardware or during virtual
>> device fuzzing, a malformed device may expose a significantly undersized
>> BAR 0 (e.g., 4KB). In this scenario, the readl() in enable_sp_interrupts()
>> crosses the mapped page boundary into unmapped memory, causing a page fault
>> during probe.
> Are you sure this is the only code path for this type of issue for this
> device/driver?  Why just worry about this one?

You were absolutely right to ask. Prompted by your question, I did a full
audit of the MMIO access paths in this driver.

I found that the dynamic MFA (Message Frame Address) reads from the 
hardware
queues, which are used directly as offsets in `get_i2o_message()`, are also
highly vulnerable to OOB accesses if the fuzzed hardware returns malicious
offsets during runtime.

I have just submitted a v2 patch in this thread that comprehensively fixes
both the static OOB during probe and the dynamic OOB during runtime.

Thank you very much for catching this and pointing me in the right 
direction!

Best regards,
Mingyu Wang


