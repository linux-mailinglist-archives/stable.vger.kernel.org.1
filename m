Return-Path: <stable+bounces-38068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7258A0AAF
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB4828629A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC113E881;
	Thu, 11 Apr 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0Zn2cnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539413E88A;
	Thu, 11 Apr 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822237; cv=none; b=GcSDd2NYOjg7ww/5AgITmF7+S5JXYxuIySxoLrZUjt13JFizzHr4xmQh5uewUHHOgE5z2jWm1Xt20o6BcO2H/Hwk0Wnmj5eDvy2HO8dUmp4+AeYRl24+Ykf2wVfeJH7NHB3R70AL9NgR5RPNJa0xAhiaF/qXit8OyxE44MkUF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822237; c=relaxed/simple;
	bh=iDDAdInN0HQVHxerJ2KA+dAkjEhhn4I1PLatg7xEYIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuOIS867cbz6z5d6LhxNmZwdP8r+J5NyvkooJxGh2gVOjK2xTf7ztaCBXDIG/KZIGnKboGc0yJXilR1T02MQLf4v/1Exi6btPJFdkFEnuI6c5nqYGRoatM9ZWH5WaMsMI+mXIrI1EdxMSmXFxc+gcXo6O7wICLl0wH0+rcaEERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0Zn2cnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B738C433C7;
	Thu, 11 Apr 2024 07:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712822237;
	bh=iDDAdInN0HQVHxerJ2KA+dAkjEhhn4I1PLatg7xEYIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0Zn2cnM0QVW4t7lgG7q80lqz17lYwwRPwS/Fkc5hOIZPDqlhF6GEAOwyZrhJVLOo
	 8OtSHJxHPybV93owtb7r/kqnDJojQ8c4MCVcGRayJEEE6EBKBVJg28YA2aPkEL1Vz5
	 3vOAjzr/vwTrU1sEFbDqSxlK9T8pOoq3ue6DfUkTesrgXzwxLetvLBXSyKmQKFcdVT
	 5k3V3TSMOOP2iW+VpKNNvccaHm2VpmE0OJYhfMJ+2mCHQcyrwBh9ZwTwvIPPDvCCyj
	 99p125/jdYE1RQ5yFyQOluLuF5fZBIFz+LNNil8Vp6ujLtzrql72yDnVq0bwKSI4zT
	 uAoSIw8t+qb9A==
Date: Thu, 11 Apr 2024 03:57:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, buddyjojo06@outlook.com,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
Message-ID: <ZheX3KdUA76wTYMF@sashalap>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
 <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
 <2024041112-shank-winking-0b54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024041112-shank-winking-0b54@gregkh>

On Thu, Apr 11, 2024 at 09:34:39AM +0200, Greg KH wrote:
>On Thu, Apr 11, 2024 at 09:27:28AM +0200, Krzysztof Kozlowski wrote:
>> On 11/04/2024 09:22, Greg KH wrote:
>> > On Wed, Apr 10, 2024 at 08:24:49PM +0200, Krzysztof Kozlowski wrote:
>> >> On 10/04/2024 20:02, Greg KH wrote:
>> >>> On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
>> >>>>
>> >>>>
>> >>>> On 4/10/24 17:57, Sasha Levin wrote:
>> >>>>> This is a note to let you know that I've just added the patch titled
>> >>>>>
>> >>>>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
>> >>>>
>> >>>> autosel has been reeaaaaaly going over the top lately, particularly
>> >>>> with dts patches.. I'm not sure adding support for a device is
>> >>>> something that should go to stable
>> >>>
>> >>> Simple device ids and quirks have always been stable material.
>> >>>
>> >>
>> >> That's true, but maybe DTS should have an exception. I guess you think
>> >> this is trivial device ID, because the patch contents is small. But it
>> >> is or it can be misleading. The patch adds new small DTS file which
>> >> includes another file:
>> >>
>> >> 	#include "sm7125-xiaomi-common.dtsi"
>> >>
>> >> Which includes another 7 files:
>> >>
>> >> 	#include <dt-bindings/arm/qcom,ids.h>
>> >> 	#include <dt-bindings/firmware/qcom,scm.h>
>> >> 	#include <dt-bindings/gpio/gpio.h>
>> >> 	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> >> 	#include "sm7125.dtsi"
>> >> 	#include "pm6150.dtsi"
>> >> 	#include "pm6150l.dtsi"
>> >>
>> >> Out of which last three are likely to be changing as well.
>> >>
>> >> This means that following workflow is reasonable and likely:
>> >> 1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
>> >> 2. Add some sm7125 board (out of scope here).
>> >> 3. Release new kernel, e.g. v6.7.
>> >> 4. Make more changes to sm7125.dtsi
>> >> 5. The patch discussed here, so one adding sm7125-xiaomi-curtana.dts.
>> >>
>> >> Now if you backport only (5) above, without (4), it won't work. Might
>> >> compile, might not. Even if it compiles, might not work.
>> >>
>> >> The step (4) here might be small, but might be big as well.
>> >
>> > Fair enough.  So should we drop this change?
>>
>> I vote for dropping. Also, I think such DTS patches should not be picked
>> automatically via AUTOSEL. Manual backports or targetted Cc-stable,
>> assuming that backporter investigated it, seem ok.
>
>Sasha now dropped this, thanks.
>
>Sasha, want to add dts changes to the AUTOSEL "deny-list"?

Sure, this makes sense.

-- 
Thanks,
Sasha

