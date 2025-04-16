Return-Path: <stable+bounces-132871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436EA90787
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425697AD89A
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C1C5486;
	Wed, 16 Apr 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp96fN9L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF794206F19;
	Wed, 16 Apr 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816745; cv=none; b=Fr2SxdgkXeAvuCyekdOVyycYyeekMu7Yk2//gk+AWGT25s3oFgo0iEgtlZDEeMzdHSTJRd2k30Wu8/oJ1M3KG/Aw/BI+8gJXCcWAM5pMMgbMSpqlBIHrvYjEAIqG1Tnz1i+pobfbViluvuWsPsbbpTuSw3hQw0SJ3ezdZhTPrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816745; c=relaxed/simple;
	bh=0xz72GOuhv74Fz+Y9TuJZyZTjocKL5pl8dXfgongog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj9Y2p6v8GID9puiNcTf8XDOfme4ndiLHOv5j9xwtxApcaeMgfTWyqeb7WYrvl7BEYU/iWpNsJxyPlBolznLd573dQ9upby6snP/9aLjt9qz0nJoS5G4sh5eb9tl5INKHNp4Yt+jRI5vXD+WonLS8cVBGxLpH8t1nTZkvXokNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp96fN9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171B0C4CEE2;
	Wed, 16 Apr 2025 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744816745;
	bh=0xz72GOuhv74Fz+Y9TuJZyZTjocKL5pl8dXfgongog0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bp96fN9LPTr5uPQBv4AExaLM88xROTnKOB/IH7vMKnqOhpfzHOOg0+PQHjSQacvkm
	 fdY2nJX5yLKdaODMkcX/rMVIk62lkM8GLD+Yyrk3VQpq/mD9Lo9qSaglPhFXifoQKK
	 4jThaZf2NwgoXiuLwRrkPFsNoL1ta4Ci9+zchxhW8iynXg72DO+Ur4C/aqJqmtmsve
	 7EhIeO2MY6DClA+VQEmFMmYbUr8Uht9QDZyrXL2iK9RJgfR+AsXyO2qXhZ+LzKR9gA
	 mJYN3mVCd7Uxy1+3myJ2m67fqAbHB1p74l5k0I4IlMEDRk8FdmSbSkJ10lHX5GUXYi
	 LwHzGPW5Hm0lw==
Date: Wed, 16 Apr 2025 11:19:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Patch "s390/pci: Support mmap() of PCI resources except for ISM
 devices" has been added to the 6.14-stable tree
Message-ID: <Z__KZ_nI6KrsDhSL@lappy>
References: <20250414104324.587191-1-sashal@kernel.org>
 <690378151fed631c9ac75e09e595a4430d384679.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <690378151fed631c9ac75e09e595a4430d384679.camel@linux.ibm.com>

On Wed, Apr 16, 2025 at 01:59:53PM +0200, Niklas Schnelle wrote:
>On Mon, 2025-04-14 at 06:43 -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     s390/pci: Support mmap() of PCI resources except for ISM devices
>>
>> to the 6.14-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      s390-pci-support-mmap-of-pci-resources-except-for-is.patch
>> and it can be found in the queue-6.14 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>
>Hi Sasha,
>
>Including this in stable is fine but if you do please also pick up
>commit 41a0926e82f4 ("s390/pci: Fix s390_mmio_read/write syscall page
>fault handling") otherwise the mmap() with vfio-pci won't work on
>systems that rely on the MMIO syscalls but would already work on those
>that have the newer memory I/O feature. Meaning once you have the
>mmap() PCI resource suppot the cited commit becomes a relevant fix.

Will do, thanks!

-- 
Thanks,
Sasha

