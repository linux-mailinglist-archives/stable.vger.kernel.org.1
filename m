Return-Path: <stable+bounces-256538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPUfLJtGGWrHuAgAu9opvQ
	(envelope-from <stable+bounces-256538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:56:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7A5FEDFC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 461683034334
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0619CCF7;
	Fri, 29 May 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ2xNQjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBD1C860A;
	Fri, 29 May 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040862; cv=none; b=Wal5w2uN7Zf+k1mWxe7KLvsaCH/7lgKDSbLWhk2wVhw/5NlLaX5i5zeDysOrjKVH4Q5BGGXy4/GYb/ddmRFSyq7wDzrGG1GSNPn9I8orunjJsy6NNMVn7nftUP46vvuhE69qowW8Bbe9T2s1EqyIbnN2lZFJDge5vnhBmEXC2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040862; c=relaxed/simple;
	bh=bT80htsJM5fMPojIJl9otZSe7IXP6SzmCHZSrqVUfx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvTF08PkzwR4SIVW7AhjeJQOCiYYAHQrlzyc26zjr/Q3wxQSCOcSLLeL0rTHF1LXmsYyHBuz2/q9t+jDCC/vfsA4dYuVH+hZU4EpF136QMDET/K2xblElreuV1IQ5fSrbDX0SOPlDmzcUEbum3fR/oXQw4ys85RchsITINQ6dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ2xNQjF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7763B1F00893;
	Fri, 29 May 2026 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040861;
	bh=iomTY4Ad9VMho5vTBG2rGPVpkuu5FijZvMIWhno+SFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BQ2xNQjFvx798LQaafRp0qHl4e/SQjVrVHNZPyfzx/PuBbDNICyKY0w5mzA//yE8+
	 bnaL6668ZqrU3Y+QDFDECJba7z6HMVy6WccEJCjRy3m7EVNMDER3pydwX72seN44K+
	 WHdMtkhF7Z5LTT6t/hWwhgDZJxnSigaA4ua3ohZ5qd6A8XgJKBjU4GXSkXkPNTkJ1x
	 JpUiJw0ZmEMWoZnYfw5YIrPUpqSk5qxJH0NlyrLo04QtI/xJELrSJg8VEaIZOi7wZC
	 KroKImR6OBgZwj1H4MuUQGIul1DnXn9/Gz0mITY9LfQL1jAhnpkbrIYkCh7AVeWMjZ
	 1HOhvGCpE/X2w==
Message-ID: <ad30ca8b-01ba-40b9-a631-503ff463bc50@kernel.org>
Date: Fri, 29 May 2026 09:47:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] firmware: samsung: acpm: Add memory barrier before
 advancing RX pointer
To: Arnd Bergmann <arnd@arndb.de>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-4-43b5ee7f1674@linaro.org>
 <a1629d9d-0357-42a3-aef8-c8d1cfa5ad39@app.fastmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <a1629d9d-0357-42a3-aef8-c8d1cfa5ad39@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256538-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 28A7A5FEDFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/05/2026 19:44, Arnd Bergmann wrote:
> On Tue, May 5, 2026, at 15:13, Tudor Ambarus wrote:
>> Sashiko identified a silent data corruption in [1].
>>
>> In acpm_get_rx(), the driver reads the response payload from SRAM using
>> __ioread32_copy() and subsequently updates the hardware RX rear pointer
>> via writel().
>>
>> On weakly ordered architectures like ARM64, writel() provides a write
>> memory barrier (wmb()), which strictly orders prior writes against
>> subsequent writes. However, it does not order prior reads against
>> subsequent writes. Consequently, the CPU is permitted to reorder the
>> writel() store to become globally visible before the payload reads
>> have completed.
> 
> I am very confused by this after seeing it in the Exynos fixes pull
> request. How would anything get reordered here? What I see is that
> 
> - The SRAM is device memory, so any access to it is architecturally
>   ordered against other accesses to the same device. Even on
>   architectures that don't guarantee this, Linux I/O accessors
>   do.

Well, __ioread32_copy does not guarantee that, I think. That's the
relaxed version.

However everything is guarded with mutex, so we do not consider here
other threads and within single thread it indeed does not look like
misordered.

> 
> - The __ioread32_copy() writes data from MMIO into main memory,
>   and the store into main memory is guaranteed to be both before
>   the final writel() (because of the implied __iowmb()) and

Yes

>   after the read (because of the data dependency).

I don't see the data dependency regarding the write. We read 'rx_front'
and 'i' in the loop. The 'i' is used for subsequent read (addr = base +
mlen*i) and that's dependency, but that 'addr' is not used in any
further writes.

> 
> - The smp_store_release() in addition orders the write into
>   rx_data->completed after the previous memory asccesses and
>   before the writel().

smp_store_release() wasn't there before the next commit, so maybe that
was missing when interpreting Sashiko suggestions.

There is no code flow where smp_store_release() does not appear, except
when RX queue is empty from the start, but that case would exit early or
would not matter.

Tudor, please validate this more. I postpone for now pull with firmware
driver changes which were put on top of these fixes.


> 
>> If this reordering occurs, the firmware may observe the updated rear
>> pointer, assume the queue slot is available, and overwrite the SRAM
>> payload while the kernel is still actively reading from it, leading
>> to silent data corruption.
> 
> It is possible that I'm still missing the point here, but it
> very much sounds like you trusted a chatbot over trying to
> understand what is actually going on. Can you explain a
> sceneario where the barrier actually makes a difference,
> and what the corresponding barrier operation on the other
> side is?
> 
>      Arnd


Best regards,
Krzysztof

