Return-Path: <stable+bounces-60693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD561938F57
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EB1C20E4C
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E016D30E;
	Mon, 22 Jul 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHsmywl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7C16A399;
	Mon, 22 Jul 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652575; cv=none; b=bYE2u9cHAR1FXxK8+4gv+YyOmegAMgBNgXu9k3d806HAsNLc60l55oyvbI5i4MXCwCzrpyItJ2LKAWbIVrn2Budn6kxys9EW5N6h8c+AXZ8b54A60YaH7Gu9FlKYILAGTeG7MOnJhEu9eDmok7CF07grHHth2H9gTvPLZFYmSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652575; c=relaxed/simple;
	bh=PjR5duhkjr8DNHVqLUTYNN7l737LnHJ9IB8dtErhseA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmj2tbSRaOKWsx20kzDce/gLaxT67DtkTymgO3QR9k05/CH92E5MJbAmGTd2gPRMK8KK4QpIifGKvKkNSdkTWBMT3kiFgrdtjw2N5CXd5ztgYp+i0ulCCtotusrqr+PnYGAHfOMhxqtbeO/Vh7YwyFceiVPqalSZubgZsMYMJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHsmywl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CEAC116B1;
	Mon, 22 Jul 2024 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652575;
	bh=PjR5duhkjr8DNHVqLUTYNN7l737LnHJ9IB8dtErhseA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHsmywl4/kHG4FfswELuiK/WjJ9b3REnDi82AulwR2LAuZkPEzNy8ny9CZcHppc8I
	 GQjm8iWxCGEggAnGzjBGw33CFffLkHwUQWZK/LRXaht3FYEjMYGoZqkXy68bIt9TuK
	 s1kkRa8waLMxjgL4mK8EybwegSoHNeD8CPsDPt5K9bTMoVwOsINy+IJnz3XdQH8nTb
	 CENG3KZfhQZe7v4LQrKJNAkDfWoKZfnPNgqXzjWM/vHQBU7fKwWZdZAdvNsF9iOmy2
	 USRMJyuCVJHCeKTiXI2mQz/pUmJGtvIWCCBe2oOzwRjH3FRs89hevDdyOwTSRgdYBy
	 5Uv0f9V+JEwhA==
Date: Mon, 22 Jul 2024 08:49:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 10/40] ASoC: topology: Clean up route loading
Message-ID: <Zp5VXeNkZPrcwwfw@sashalap>
References: <20240709162007.30160-1-sashal@kernel.org>
 <20240709162007.30160-10-sashal@kernel.org>
 <844e0213-33ea-48b6-ad55-145c9dab584a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <844e0213-33ea-48b6-ad55-145c9dab584a@sirena.org.uk>

On Tue, Jul 09, 2024 at 05:34:51PM +0100, Mark Brown wrote:
>On Tue, Jul 09, 2024 at 12:18:50PM -0400, Sasha Levin wrote:
>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>
>> [ Upstream commit e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7 ]
>>
>> Instead of using very long macro name, assign it to shorter variable
>> and use it instead. While doing that, we can reduce multiple if checks
>> using this define to one.
>>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinski@linux.intel.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>This is clearly a code cleanup, there is nothing here that looks in the
>slightest bit like stable material.

Dropped, thanks!

-- 
Thanks,
Sasha

