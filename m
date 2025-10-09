Return-Path: <stable+bounces-183661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5AFBC7792
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 07:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A53E66E6
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB425CC5E;
	Thu,  9 Oct 2025 05:57:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61831DF75D;
	Thu,  9 Oct 2025 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989457; cv=none; b=jEcDX0kpmNI/y3EIb9LXyREt95X6y2N9wUkbhr/lx0gun3p+HmUSBn/zZXzCCEamSy8uFFhyrtipYjrGXAckWjefPCBR7d6Xv/kU+aSLu6eOiEoR0l6egwKswGqTVPH3ThHQm4blFXMlxgMhH2pa948P7XaV7N7A3hsEFpxV6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989457; c=relaxed/simple;
	bh=pZQaNYzeBHaJH4Vz/t2FVsiKHeWBwnG/yHlpr0D1EB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOevdCLNT/lVJcXKzyYA56X0jdPmlO/U25BcOsu9pjsZkpEYs92orkeiz9Jb5eXJLDREOEdpmHXZzWHxXuwPeD3gK255rIpCoXeswzTTI5Ec5I6donykoPInsLRVlHFHfS68H1vAs8dCNp3qE+/kOfHvRnod7uuEyGaIvALTVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.108] (unknown [114.241.81.247])
	by APP-03 (Coremail) with SMTP id rQCowACn73kTTedoBU42DQ--.27093S2;
	Thu, 09 Oct 2025 13:50:11 +0800 (CST)
Message-ID: <87d603ce-578d-46a7-87b1-54befccc6fad@iscas.ac.cn>
Date: Thu, 9 Oct 2025 13:50:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@gmail.com>,
 Han Gao <rabenda.cn@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Meng Zhuo <mengzhuo@iscas.ac.cn>, Yangyu Chen <cyy@cyyself.name>,
 Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 Yao Zi <ziyao@disroot.org>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
 <2025100812-raven-goes-4fd8@gregkh>
 <187fe5a3-99b9-49b6-be49-3d4f6f1fb16b@iscas.ac.cn>
 <2025100920-riverbank-congress-c7ee@gregkh>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <2025100920-riverbank-congress-c7ee@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowACn73kTTedoBU42DQ--.27093S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kXw45GFW8tF1fCF1kAFb_yoW8CFy7pF
	W2qr1jyw42yryIyw1q9rsYgFZ5Ww4ktay5JFZ5CFWvvrn8Zr92grn2gFWq9Fyjvr1kW34Y
	qay5WryrZaykZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/9/25 13:00, Greg KH wrote:
> On Thu, Oct 09, 2025 at 12:19:46PM +0800, Vivian Wang wrote:
>> [...]
> Ok, that makes a bit more sense, but again, why is this just showing up
> now?  What changed to cause this to be noticed at and needed to be fixed
> at this moment in time and not before?

As of why this came quite late in the lifetime of the 6.6.y branch, I
believe it's a combination of two factors.

Firstly, actual Sv48-capable RISC-V hardware came fairly late. Milk-V
Megrez (with Eswin EIC7700X), on which the Go TSAN thing ran, was
shipped only early this year. The DC ROMA II laptop (EIC7702X) and
Framework mainboard with the same SoC has not even shipped yet, or maybe
only shipped to developers - I'm not so certain. Most other RISC-V
machines only have Sv39.

Secondly, there is interest among some Chinese software vendors to ship
Linux distros based on a 6.6.y LTS kernel. The "RISC-V Common Kernel"
(RVCK) project [1], with support from openEuler and various HW vendors,
maintains backports on top of a 6.6.y kernel. "RockOS" [2] is a distro
maintained by PLCT Lab, ISCAS, for EIC770{0,2}X-based boards, and it has
a 6.6.y kernel branch. Both have cherry-picked the mmap patches for now.

We operate with the understanding that the official stable kernel will
not be accepting new major features and drivers, but fixes do belong in
stable, and at least from the perspective of PLCT Lab we generally try
to send patches instead of hoarding them. Hence, the earlier backport
request and this backport series.

I hope this explanation is acceptable.

Thanks,
Vivian "dramforever" Wang

PS: This 6.6 kernel thing isn't just a RISC-V thing, by the way. KylinOS
V11 has shipped in August with a 6.6 kernel. Deepin and UOS will be
shipping with 6.6, with UOS "25" shipping maybe late this year or early
2026.

[1]: https://github.com/RVCK-Project/rvck
[2]: https://docs.rockos.dev/


