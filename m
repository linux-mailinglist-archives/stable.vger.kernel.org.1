Return-Path: <stable+bounces-4793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3F806475
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1869F2821E1
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F123D1;
	Wed,  6 Dec 2023 01:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAn3xdl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08B4429
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 01:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB1AC433C8;
	Wed,  6 Dec 2023 01:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701827863;
	bh=S6FcSqXiPkB7bwWbEbflS16ZC3a2KNbRC5F2L4gR/4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAn3xdl21XANaUmOmjCJr+DdXxkpTwUv26qVzaT5ZSHJpMY8b73R3wUqaEgSCUG+3
	 TtExK7/OMeBj3TfRSSzJJYdQezB0cd3i9UAHoqkndX74Krj+WyUU9Sk1ra13GaLhhZ
	 f05xuh3fI6CtRJjSZkS+/r17EytANbKv/fy+ZPqFwdnfk6BeTKY83xAAPuiN0nHpgh
	 vOkwdTS9cQIP91Y3QIdZXJMNjY4d2HOF/GFLWw3bCpoQyNOpjhSR7UCFwFe2yrE3jr
	 KNoTYudbDfwoX/KHqXikBr4fO/PDzDplOWwgtR8NH4hHuzNm2vLp8TaCZDilX3hLPz
	 TbSiqpaAQawqg==
Date: Tue, 5 Dec 2023 20:57:35 -0500
From: Sasha Levin <sashal@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, deller@gmx.de,
	ndesaulniers@google.com
Subject: Re: [PATCH AUTOSEL 6.6 12/17] linux/export: clean up the IA-64
 KSYM_FUNC macro
Message-ID: <ZW_VD-H7ota8GZwE@sashalap>
References: <20231122153212.852040-1-sashal@kernel.org>
 <20231122153212.852040-12-sashal@kernel.org>
 <CAKXUXMxiRL-ay9eMz4AZNORbO-mhyZECGE2SDg0rTB7wZdHSRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMxiRL-ay9eMz4AZNORbO-mhyZECGE2SDg0rTB7wZdHSRA@mail.gmail.com>

On Wed, Nov 22, 2023 at 09:06:54PM +0100, Lukas Bulwahn wrote:
>On Wed, Nov 22, 2023 at 4:32 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>
>> [ Upstream commit 9e0be3f50c0e8517d0238b62409c20bcb8cd8785 ]
>>
>> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
>> there is no need to keep the IA-64 definition of the KSYM_FUNC macro.
>>
>> Clean up the IA-64 definition of the KSYM_FUNC macro.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>I am a bit surprised that this is picked up for v6.6. This commit only
>makes sense after IA-64 architecture is removed and I do not think we
>want to backport that change to v6.6. So, this change here should not
>be backported as well.

I'll drop it, thanks!

-- 
Thanks,
Sasha

