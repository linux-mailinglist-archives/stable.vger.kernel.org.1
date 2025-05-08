Return-Path: <stable+bounces-142913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFCDAB012A
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A43500F54
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E5207A27;
	Thu,  8 May 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbFLpwoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146D35966
	for <stable@vger.kernel.org>; Thu,  8 May 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724558; cv=none; b=P3CgLNbd15APrSr3Ltr8kWK/DolYeF9eZo7y2Z1yY60Se/THvmEIKwdrDOwWwMnghleNspQdHEN0zKsdupIdg44Pjjw7qvqutx3MFIIhl7rz5wWKrl4HB+8ZPfV46JvXznG9o2h9jVClQ0WTA8ldJmw9t2zLT8ALUkkAL2XfV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724558; c=relaxed/simple;
	bh=XWu6LX43Cp0NCWogYtwXBvOfylB44uxzYbl9HAAX4gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyOEK+h/EQfMjeToItAts7O0QKT63y/g3EEtdF6AYrG2JwLHQJIKq+1rGVILDykVplGBSuld4sVHb9tom7BxFG2kAkQWQyDKGj6Ffu9F4D44YBu9k0M64ZZ3W1AMMsV5cFm2m/UGno/lV55Q5slzmvNi8PErDnwslYbH9wa6k0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbFLpwoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3AC4CEE7;
	Thu,  8 May 2025 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746724557;
	bh=XWu6LX43Cp0NCWogYtwXBvOfylB44uxzYbl9HAAX4gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbFLpwoCmTqJP0cIfDuGSsotynssOhLny/g49iOmvseVfwAtTFtw3n99g+Ntvm1Ue
	 pGUMKnlxhFF6rDxydNorqXTfY47J98EfJQwDTEsupwKlkctoUf6LwSwFR2hcE8rhbD
	 3AvJDWzu+kempuy/1lutERIdG+JeAvsH8wqB2s0bYPn61U2IOIEqkHKEANsBK3ZRGq
	 Q0k5qy3nkRZDX5w/zZwSDQiMmGvFzLDo9D4JUKmQDci2NtfLWRhnQLqQH2Vfz9Otd4
	 4cPsUHPxLZnJ6+Eg2Jqu9XKOdLCGoIzZUEC2aJk2tk4Utdg+tyzPhHytByqUX2bK9e
	 8u6y2d5Y/w6Bw==
Date: Thu, 8 May 2025 13:15:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
Message-ID: <aBzmyRU6EXuuYCJu@lappy>
References: <20250505232601.3160940-1-surenb@google.com>
 <20250507082538-05e988860e87f40a@stable.kernel.org>
 <CAJuCfpEdkkZd8RSZUPsXkq3BXzDvebfSHuF4T=AoRHDv8hgJzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEdkkZd8RSZUPsXkq3BXzDvebfSHuF4T=AoRHDv8hgJzg@mail.gmail.com>

On Thu, May 08, 2025 at 05:04:45PM +0000, Suren Baghdasaryan wrote:
>On Thu, May 8, 2025 at 4:18 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ⚠️ Found matching upstream commit but patch is missing proper reference to it
>
>Not sure why "patch is missing proper reference to it". I see (cherry
>picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef) in place.
>Did I miss something?

It tries to find one of the references described in the docs for
submitting stuff to stable@:

	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

-- 
Thanks,
Sasha

