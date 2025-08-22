Return-Path: <stable+bounces-172324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE49B310C8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5717CE4B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FA2E9EA2;
	Fri, 22 Aug 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fp2rwnMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4E2E8B76
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848939; cv=none; b=YI+BG5hfVd13jMOywiYiiNBMiRH7y8irnrfEqcqAidk79B1F/TXH/UP8f0A5nznTqUiWQQrN4fVC0lt0TpIdC5tdRC9hpW9oCUVP9sC62PzZiae0iMCBzg32csSb/Z24OGRVK4+elygFEQVNotHDuTJQ34vNJSFn0VNb3k9DtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848939; c=relaxed/simple;
	bh=DKaEMpPuKCdXj1YABKlsM+e9rwjQYLBCTfcoKZ1CBJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbodVIMfHIrd5BVHLArqWk2i3b98LejvkNylO1O5DFIhV45RMtEajmAr36uS4cITE46sPD5ViHHm9AYE43SyB1+ZRgSPyT1glDXog/ngmAe3Q9H8rG2sWlFrO6tJe6UNVjog6Mqos3TcsE9JpjGCAHLnxy1+VNYPpu8EtkpDY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fp2rwnMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C402C113D0;
	Fri, 22 Aug 2025 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755848939;
	bh=DKaEMpPuKCdXj1YABKlsM+e9rwjQYLBCTfcoKZ1CBJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fp2rwnMfgYm3Mwc9vNBEaDhcqV9U92FWeYt2cDhRA1baZAoOE1Ev7FD71v3nwXnJk
	 OjfUY4zHRe0bwRSBxikudVXXxz6bi8ufsH0oG6jzSLP2brGkxRGrW+J3tNbntpc0te
	 V+SNXg2kteePexWsJXeFJq2Gw+MGQsOOQrugZGPo=
Date: Fri, 22 Aug 2025 09:48:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <2025082243-stooge-spendable-53c1@gregkh>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <55735a20-1048-4c04-bcd4-45eff0079f61@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55735a20-1048-4c04-bcd4-45eff0079f61@arm.com>

On Fri, Aug 22, 2025 at 01:08:57PM +0530, Dev Jain wrote:
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Now deleted.

