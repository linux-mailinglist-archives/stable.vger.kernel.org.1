Return-Path: <stable+bounces-81516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C48993E98
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9E2282B44
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB6143895;
	Tue,  8 Oct 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyBBAr93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2313B2B8
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367508; cv=none; b=I2+GzA2QXXijYeE7G/7b19wA1kyYHngy7nz7nxHrNSk/pSqYqsq2IbM6XhIYZ4IFxrG7pxWXsOitncolkK6TkilA0fKkUkBlcAe4rM7poy5RlikqVPcHj0kfKFSSC49tAKI8AvNVuJBl9tAqNNioPk9aWd+QcFTlqjHjHTFxI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367508; c=relaxed/simple;
	bh=nwjM+YjgwqTLp27s+Cb1YgKyJE/Nkp1VylukaY2Jep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzN2QQSHIs8QSmA+wuHcNrkbBlioJVfapANmlHMnc24v9Z/L3K6XWweTP+RAyft4qoOT3vRAQXcoMb56a/iSi+bU2PVI3aH3KN3jwwPwtEmRALtCm2k0OfzqSGNz10kvhToor6mTsFnvPMO8HYVExKisICwrt+BPn4JpXWLK4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyBBAr93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51038C4CEC7;
	Tue,  8 Oct 2024 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728367508;
	bh=nwjM+YjgwqTLp27s+Cb1YgKyJE/Nkp1VylukaY2Jep0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyBBAr93YvDO3oAEvFV+vpGaVhWxauCQkjVZcItbWbwmyaeHvZot17vmDGj48+o5/
	 VjxwH9u0qAqLuZCG8Y96elJb9VfvZkTrRDF7VqtqerJjwzfUzbqeCuKrgK97sjID3t
	 qD0ogo2LJ9tj4n5JmnZoiL5b51ZchM2AWfgnrfsKu2nA0+dS6VbsANOThkFKYeWr0n
	 iwbN1seBq3JDx5eoVF3Z2GggiH8PRypOU27LeHA3KxiVjHkZSMjzDV+i0YmwWgtapF
	 V6Sm/fR8IPy1O4HkgLX5fI1o9e8mS7ecX4NzDTwzOMJOerVvQkOjhTGFOvAjoclm21
	 vaQtYVi1AhbbA==
Date: Tue, 8 Oct 2024 02:05:07 -0400
From: Sasha Levin <sashal@kernel.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	'Roman Gilg' <romangg@manjaro.org>
Subject: Re: Regression in 6.11.2
Message-ID: <ZwTLkxPmK5wL4YIt@sashalap>
References: <d75e0922-ec80-4ef1-880a-fba98a67ffe5@amd.com>
 <602fc890-8924-4ff4-904c-8bc561745b46@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <602fc890-8924-4ff4-904c-8bc561745b46@manjaro.org>

On Tue, Oct 08, 2024 at 08:35:33AM +0700, Philip Müller wrote:
>On 8/10/24 03:33, Mario Limonciello wrote:
>>Hi,
>>
>>commit 872b8f14d772 ("drm/amd/display: Validate backlight caps are 
>>sane") was added to stable trees to fix a brightness problem on one 
>>laptop on a buggy firmware but with how aggressive it was it caused 
>>a problem on another.
>>
>>Fortunately the problem on the other was already fixed in 6.12 though!
>>
>>commit 87d749a6aab7 ("drm/amd/display: Allow backlight to go below 
>>`AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`")
>>
>>Can that commit please be brought everywhere that 872b8f14d772 went?
>>
>>Thanks!
>
>So far commit 872b8f14d772 got added to 6.11.2, 6.10.13 and 6.6.54.
>It is also queued up for upcoming 6.1.113 and 5.15.168.

I've queued up the fix too, thanks!

-- 
Thanks,
Sasha

