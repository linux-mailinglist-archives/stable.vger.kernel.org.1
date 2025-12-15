Return-Path: <stable+bounces-200991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E5CBC304
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06FC300889B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72AC1F1518;
	Mon, 15 Dec 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm6qAvVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB018C2C;
	Mon, 15 Dec 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762680; cv=none; b=hDxhc9fJB2cttphyFvZ3lG72tbU1VDNXYEH8toY/V7kvPt7RuNvPn1GVVqs0eT2/Wei2AddSKTprlEdCtA+I5S+DKrOADSMh6aM7xMwDSAUu9axyMNafXNmYeXfSkFHXpnOQQDIuhI2aobvaWqFS+QPIPnEIEXh4kakwSFTHvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762680; c=relaxed/simple;
	bh=ktoC2F+cqjQpF7Xk4h8T7/cY2+CJYjsIeRNi1E10N2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGJU8cE141BbkYzvici0EPq+4n8pRFKvyXKWqL0rZ+rBsm3eZ3qENA/tEKBF4r38O0oFv8yo9TxHEY+/STWi4dvGfjWlx92tc+n9YusPAhufeV401vjnr2jzKU7MhivITf5wWIaDvIa85/YmqZwrTRdlanrBJdM2rw3K1r11NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm6qAvVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7628C4CEF1;
	Mon, 15 Dec 2025 01:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765762680;
	bh=ktoC2F+cqjQpF7Xk4h8T7/cY2+CJYjsIeRNi1E10N2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pm6qAvVPzEtBhNiEnrj2dDQo5enTK7azS63Xv+N00DQPyfsIvwZ8NVeqvbTmjdnwR
	 N4et/2ca47CEiNlrCl2XpeRXbGfMUe8MRuEC0rQWLW3+4n5z9rVX/5b8lX4ci8DTei
	 hjzdLnTxVJuMtmT6F4Ab/Zq8t8v9peDandiLFzDUMVbi14SiSZmLt3Ob8nQbuiO4W2
	 bkhJA39AghEdrczGOz2oMXxNBuYYK7in2u6xpT+eoBYKoA+MuxeB8uq6Es8JXOjveV
	 K0rjCS/IKGPVFjqY4cj80uS9bYqo2PEkI6TBfF+9PlpEn1O12CojXYZmsqBCfV+kFF
	 9YJIr97htCSwg==
Date: Sun, 14 Dec 2025 20:37:57 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	jason@os.amperecomputing.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>
Subject: Re: Patch "RAS: Report all ARM processor CPER information to
 userspace" has been added to the 6.18-stable tree
Message-ID: <aT9mdXWspIz0KXQL@laps>
References: <20251213094943.4133950-1-sashal@kernel.org>
 <20251213111405.65980c34@foz.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251213111405.65980c34@foz.lan>

On Sat, Dec 13, 2025 at 11:14:05AM +0100, Mauro Carvalho Chehab wrote:
>Hi Sacha,
>
>Em Sat, 13 Dec 2025 04:49:42 -0500
>Sasha Levin <sashal@kernel.org> escreveu:
>
>> This is a note to let you know that I've just added the patch titled
>>
>>     RAS: Report all ARM processor CPER information to userspace
>>
>> to the 6.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      ras-report-all-arm-processor-cper-information-to-use.patch
>> and it can be found in the queue-6.18 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>You should also backport this patch(*):
>
>	96b010536ee0 efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
>
>It fixes a bug at the UEFI parser for the ARM Processor Error record:
>basically, the specs were not clear about how the error type should be
>reported. The Kernel implementation were assuming that this was an
>enum, but UEFI errata 2.9A make it clear that the value is a bitmap.
>
>So, basically, all kernels up to 6.18 are not parsing the field the
>expected way: only "Cache error" was properly reported. The other
>3 types were wrong.
>
>(*) You could need to backport those patches as well:
>
>	a976d790f494 efi/cper: Add a new helper function to print bitmasks
>	8ad2c72e21ef efi/cper: Adjust infopfx size to accept an extra space

Sure, I'll grab those too. Thanks!

-- 
Thanks,
Sasha

