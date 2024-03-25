Return-Path: <stable+bounces-32182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A588A6B7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B211BC41BB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448591C5AB9;
	Mon, 25 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M46Y3cLU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CC4CE09;
	Mon, 25 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366490; cv=none; b=iiIqzBVlRf+ayc14PD6JnD7iOLQ5RvufPA5MpAMdIkBOEWK9+h5RSJqFe/rpVLY/95pdXoEygpCq+Ggzfzf8nCpk0ElgrhPrAzW4jTIZDTEmzed6cMwkL10T5McZA9eBIVBpcnpErkY55y7nvgzga8Y8heyxi1MNyUvP0YcawSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366490; c=relaxed/simple;
	bh=u4R1p+rS+1S1wwSKjEvVMR8WPglN/O5MSJm1Qqv7w94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtW5S5IRgNOpyahYkVWHUl9mhymsuv5qGpKQEImADRbzQ5HqO8g1RgI+xb2wrTifSQO9JuKoZ2OHUFTQD6jKtzLS/WzPpQX958Z+mYduw1S0erpyutdwYwVtUZcqir8YHVmx6/r1mEez2EuZqqoetKOFNVKdz1pgjERwAdubpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M46Y3cLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E562C433F1;
	Mon, 25 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711366489;
	bh=u4R1p+rS+1S1wwSKjEvVMR8WPglN/O5MSJm1Qqv7w94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M46Y3cLUhPb0+7faDczUcfGtsze+3D5Rxy2OzF2nkFhQNvVN0d1pUi/wDwlExd5EC
	 v4CazADNswPqsHuVKJ+meFfp37anWmPGs3Gqw0hgZ5b4mTDp/54tKjw/WHVK3asY3p
	 8NyYW17JlGHkF+v2meQyqnbDZye7SKbly/2puJ8pJbOVQ9Fwyth4JkEkxHp4eLvom0
	 k5drqZfb7xPVYSEbM99QHvauaGDuda+jZqe+zCdqgU9d8ipCYGG3AM7njenoAyZHp+
	 rjblSDYC+6KMDd6lsD82MCavGU4pGtrfIpjF43DTg83u6H4zZrJdt3FMnp5B+ritMr
	 Qz3OfiGWJHJNg==
Date: Mon, 25 Mar 2024 07:34:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 6.6 000/638] 6.6.23-rc1 review
Message-ID: <ZgFhWEyQZpdCaITV@sashalap>
References: <20240324230116.1348576-1-sashal@kernel.org>
 <CA+G9fYueiBdV-uRVbX+JB2_nt831_+8fnyoQ6v62rAsyLQne6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYueiBdV-uRVbX+JB2_nt831_+8fnyoQ6v62rAsyLQne6g@mail.gmail.com>

On Mon, Mar 25, 2024 at 03:28:01PM +0530, Naresh Kamboju wrote:
>On Mon, 25 Mar 2024 at 04:31, Sasha Levin <sashal@kernel.org> wrote:
>>
>>
>> This is the start of the stable review cycle for the 6.6.23 release.
>> There are 638 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue Mar 26 11:01:10 PM UTC 2024.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>> and the diffstat can be found below.
>>
>> Thanks,
>> Sasha
>
>
>The regression detected while building allmodconfig builds with clang-17
>failed on all the architectures.
>
>> Andrii Nakryiko (3):
>>   libbpf: Fix faccessat() usage on Android
>>   libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
>>     API
>>   bpf: don't infer PTR_TO_CTX for programs with unnamed context type
>
>arm64 gcc-13 - FAILED (other architectures passed)
>arm64 clang-17 - FAILED (All other architectures failed))
>
>The 2 errors are only noticed on arm64.
>
>> Jason Gunthorpe (1):
>>   iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
>
>Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>Build error:
>------------
>kernel/bpf/btf.c:5660:10: error: expression which evaluates to zero
>treated as a null pointer constant of type 'const struct btf_member *'
>[-Werror,-Wnon-literal-null-conversion]
> 5660 |                 return false;
>      |                        ^~~~~
>1 error generated.
>
><trim>
>
>drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:358:10: error:
>incompatible integer to pointer conversion returning 'int' from a
>function with result type 'struct iommu_sva *' [-Wint-conversion]
>  358 |                 return -ENODEV;
>      |                        ^~~~~~~
>drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:361:10: error:
>incompatible integer to pointer conversion returning 'int' from a
>function with result type 'struct iommu_sva *' [-Wint-conversion]
>  361 |                 return -ENODEV;
>      |                        ^~~~~~~
>2 errors generated.

Thanks for the report! I've dropped the two offending commits.

-- 
Thanks,
Sasha

