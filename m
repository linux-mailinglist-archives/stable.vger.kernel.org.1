Return-Path: <stable+bounces-81902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3F994A0A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5793C282FD9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2E1DE3A2;
	Tue,  8 Oct 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUaNgy5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324DEEC8;
	Tue,  8 Oct 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390519; cv=none; b=EDFqHDs6dEIdAdmlobe0CxJ83nRoXL+qvbeNErNQIKewPplSBbvKKgAy3Ecc5FrSntolXsSbSGD9DgLurpDyh4l41ZqHLBxtXmOsvPq3gnvkyM4eCbUsfrqT+raWL4WY7qr3SvqjG18DpczyO/ak6Ld8DtZyj82r1c6y7nGPaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390519; c=relaxed/simple;
	bh=IP8ffe5Dzmmh5NHxdl4RiD92eKoxEaHlv8MBTGRIi7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke8dEcu0J48jyzPJFMiSlJ+k7fJVjQMMQA+Mc4u+T4eHb8u1vPaMbYeGO39gWVsqaeJzDNFC+0xAya5HkxhAKCeDXaY3jtEpcUcBUak1f0ArCl0nI4CoBCYkkT1nJpwimUqB8SfAUTOBYwaizuPbJn+m3AqD4HwNq2y4CBYDWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUaNgy5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC28C4CECD;
	Tue,  8 Oct 2024 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390518;
	bh=IP8ffe5Dzmmh5NHxdl4RiD92eKoxEaHlv8MBTGRIi7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUaNgy5o2y+iqGr73JqwFNvduRxX97hf0JVMebA1eaBxK5JtwJBQLbgh2L3OeyMGK
	 O/9+tdeDMbOapnJT/kxdDhc0UiwA18ILVn/QHFZK1/N4QuNbnS/0ABGwPjHju6hR8x
	 DSPhAbSJi+kumg/vtRdHHzmRelfgpOexIBTQEt+gCouEMLFqPkjeDEOMLQjbohjakT
	 As8Mw/eB4Fat6Va4zRRJycsUt7YZ4jiVAB6KC5qsIqPFbNDKz5ihHyMKuOknSiFx52
	 m9sfUdWMtFBNqlDgTzN6KsNepKZhCMU3nCm7y2MHU6VjLtZk9/yhRlaB5HBm9nhNGl
	 x9usUaBSbZTdQ==
Date: Tue, 8 Oct 2024 14:28:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	airlied@gmail.com, daniel@ffwll.ch, bskeggs@nvidia.com,
	jglisse@redhat.com, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] drm/nouveau/dmem: Fix Vulnerability and Device
 Channels configuration
Message-ID: <ZwUlcWka1_CgXRyG@cassiopeiae>
References: <20241008115943.990286-1-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115943.990286-1-ymaman@nvidia.com>

On Tue, Oct 08, 2024 at 02:59:41PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> This patch series addresses two critical issues in the Nouveau driver
> related to device channels, error handling, and sensitive data leaks.
> 
> - Vulnerability in migrate_to_ram: The migrate_to_ram function might
>   return a dirty HIGH_USER page when a copy push command (FW channel)
>   fails, potentially exposing sensitive data and posing a security
>   risk. To mitigate this, the patch ensures the allocation of a non-dirty
>   (zero) page for the destination, preventing the return of a dirty page
>   and enhancing driver security in case of failure.
> 
> - Privileged Error in Copy Engine Channel: An error was observed when
>   the nouveau_dmem_copy_one function is executed, leading to a Host Copy
>   Engine Privileged error on channel 1. The patch resolves this by
>   adjusting the Copy Engine channel configuration to permit privileged
>   push commands, resolving the error.
> 
> Changes since V3:
> - Fixed version according to Danilo Krummrich's comments.
> 
> Yonatan Maman (2):
>   nouveau/dmem: Fix privileged error in copy engine channel
>   nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Applied to drm-misc-fixes, thanks!

