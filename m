Return-Path: <stable+bounces-188160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80EBF23F6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B88189F0DB
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0219279DB7;
	Mon, 20 Oct 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvRasipR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BC2517B9;
	Mon, 20 Oct 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975898; cv=none; b=YzmnxFDCvyb5yeRdT+jM6DAng7PG8XJx/dTuiE6LqEIntasMU1rxJ0AacvD9susLstKDImBviY04qTuC8hw+FytAQ/qsaEZYjT2XoFT/CzTaHZg7H/DRViUFzisoqaQqkEC8m5vYipyNS1UNxGt3j4eJLT9a5Zp8saIPc6sipF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975898; c=relaxed/simple;
	bh=c1pFx8WKouJ8FJj3ToqXrSrEjMFH54BLR0ELsARARUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK4kyFvlm9kUSIVB4Jg+eFCCIo2fsTSVnJ3LU9DxpVci5hRQy5WHM0TU2Zv9k7Q74Z3+INalhh+phoBsN92UdVyMBjrXpnPkKRw9ES2tb9yzg19uW2F8hDVwX+OsayvqU4q0Z5XAHg7ACF8T/G5lb+oeugFeLs1GOE+Tq+kPqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvRasipR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A484C4CEFE;
	Mon, 20 Oct 2025 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975897;
	bh=c1pFx8WKouJ8FJj3ToqXrSrEjMFH54BLR0ELsARARUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VvRasipRZTsQXIgyYOKhcKTqIYGgRXodZ4d8kfXfct1ws2fA5ltN3WFtMw4RiJuzG
	 77YD/cXjTnqdgq/JezeOxH/HeEM1zD+CeoS+O+KaqnnwOIAvdlW1nj87aPwh6C2x4B
	 0MSyKwSo8+FSJETqUTV3ypgWzF1M8ah5y58979IaDkTkM+n0H/yfeZANNSZo9xX/yG
	 acd5h6/wQCMzExGPopD48E10PfZ29vYCNiP3J+QSI8bnkQFfqglc7ygDP7oZvej7Tw
	 CuNIjW3yNrbJceNpeZrIplXe5pFU3T0LXXlpEkltDu0uBy+htp8izJlP6a4a1/i0qK
	 UtKk1Q8MMGsuA==
Message-ID: <a23607ec-e1a2-45b6-bc80-01deec03d6f0@kernel.org>
Date: Mon, 20 Oct 2025 17:58:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 2/3] arch: back to -std=gnu89 in < v5.18
Content-Language: en-GB, fr-BE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
 <20251017-v5-15-gcc-15-v1-2-da6c065049d7@kernel.org>
 <2025102015-alongside-kiwi-6f75@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025102015-alongside-kiwi-6f75@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 20/10/2025 15:30, Greg Kroah-Hartman wrote:
> On Fri, Oct 17, 2025 at 06:24:01PM +0200, Matthieu Baerts (NGI0) wrote:
>> Recent fixes have been backported to < v5.18 to fix build issues with
>> GCC 5.15. They all force -std=gnu11 in the CFLAGS, "because [the kernel]
>> requests the gnu11 standard via '-std=' in the main Makefile".
>>
>> This is true for >= 5.18 versions, but not before. This switch to
>> -std=gnu11 has been done in commit e8c07082a810 ("Kbuild: move to
>> -std=gnu11").
>>
>> For a question of uniformity, force -std=gnu89, similar to what is done
>> in the main Makefile.
>>
>> Note: the fixes tags below refers to upstream commits, but this fix is
>> only for kernels not having commit e8c07082a810 ("Kbuild: move to
>> -std=gnu11").
>>
>> Fixes: 7cbb015e2d3d ("parisc: fix building with gcc-15")
>> Fixes: 3b8b80e99376 ("s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS")
>> Fixes: b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")
>> Fixes: ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
>> Fixes: 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Note:
>>   An alternative is to backport commit e8c07082a810 ("Kbuild: move to
>>   -std=gnu11"), but I guess we might not want to do that for stable, as
>>   it might introduce new warnings.
> 
> I would rather do that, as that would allow us to make things align up
> and be easier to support over the next two years that this kernel needs
> to be alive for.  How much work would that entail?

Good question. I'm not an expert in this area, but I just did a quick
test: I backported commit e8c07082a810 ("Kbuild: move to -std=gnu11")
and its parent commit 4d94f910e79a ("Kbuild: use
-Wdeclaration-after-statement"). A build with 'make allyesconfig' and
GCC 5.15 looks OK to me, no warnings.

But when looking a bit around, I noticed these patches have already been
suggested to be backported to v5.15 in 2023, but they got removed --
except the doc update, see patch 3/3 -- because they were causing build
issues with GCC 8 and 12, see:

 https://lore.kernel.org/a2fbbaa2-51d2-4a8c-b032-5331e72cd116@linaro.org

I didn't try to reproduce the issues, but maybe we can re-add them to
the v5.15 queue, and ask the CIs to test that?

Note that even if we do that, the first patch will still be needed to
have GCC 15 support in v5.15.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


