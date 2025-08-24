Return-Path: <stable+bounces-172720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F0B32FE8
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 14:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43ED7B2245
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06338262FC1;
	Sun, 24 Aug 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdWLxtIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D31F4701
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756037580; cv=none; b=P+MzUDgxrhyxm1PmoFPjmcvyWZ/xjYVyFcz+xPlBEQ7HPQ1/nIvjz3hjN+3IUYQxKWqyAYGRWynMwp8NbKHTEtFOm4x3nKK7Lww/pSqnZ3vWJGzH2P1MvoamWqE/JRCFte/I+zaZJhR2WixqQ8pV6KjJtncHiSXgd122kzLErE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756037580; c=relaxed/simple;
	bh=vysBp8g5TQtWFV/VVinertZmbChV6bk4rL4XJqRHy9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaqBfazSr+QX7JSqGdsH5ITlP4MrVBeyzOugG2uVUUwFq1zXrnS0XVHRh1k4+LFDJZhEmp0mmBq6o0N7m7eo11t8FY6ARkzA/wa5Hj9fCWvKfs+rohlnwfB/WM3f6KYqnwfPERU+oG2NubL0/G1XYyKhX17Ii2hC385K/xOHvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdWLxtIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE5FC4CEEB;
	Sun, 24 Aug 2025 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756037579;
	bh=vysBp8g5TQtWFV/VVinertZmbChV6bk4rL4XJqRHy9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OdWLxtIWKvEuE8omFtekqqceR0xpWPuS4LAXrH2Iu455fRW0GzxA3gOqBxpWs8mHK
	 cyThUU+PGn9Yrl0C7eiaDCwkFHYOMhIPaYrAHVLdaLXof2n71O45O22o+K4N/NqLPz
	 QsDcUrzvF/n/7hFzyfR3Jd/7XW63Qrk5koY5Hq1p/3eNurLGQuLqG+LJ1HJgCEqX3t
	 z65iSkET1Jjk5IN4rTErb77lkSYFfHlGHPkPQLz246XsWHjXybcvoCEd3cIDvG2jQT
	 /lybUnXPGbEVKxC/E2+HOdm8+xsMEiagkPh5GCCC50uwMjWcPx0wiuoE1V/vv/zxvL
	 DyXHMue8ur4vg==
Message-ID: <e898036a-5453-4b3f-97aa-7ab35f7d3adc@kernel.org>
Date: Sun, 24 Aug 2025 07:12:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PPC GPU hangs patch
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <96f62b2d-4d26-42ed-8528-e48b2d385341@kernel.org>
 <2025082435-tuition-suffice-d462@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2025082435-tuition-suffice-d462@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/25 4:10 AM, Greg KH wrote:
> On Mon, Aug 18, 2025 at 10:52:29AM -0500, Mario Limonciello wrote:
>> Hi,
>>
>> Some GPU hangs are reported on PowerPC with some dGPUs.  This patch is
>> reported [1] to improve them:
>>
>> commit 0ef2803173f1 ("drm/amdgpu/vcn1: read back register after written")
>>
>> The other VCN versions are already in 6.15.9, this one didn't come back
>> though AFAICT.
>>
>> Can you take it back to remaining stable trees?
> 
> What specific ones?  5.15.y is end-of-life, and this didn't apply to
> 5.12.y :(
> 
> thanks,
> 
> greg k-h

OK, then let's never mind this change.

