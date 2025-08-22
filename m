Return-Path: <stable+bounces-172310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CBBB30EFE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A71CE5035
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69B2E5409;
	Fri, 22 Aug 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/Z1cNk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD233277031
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844371; cv=none; b=bZvsCDhxZj4H07mx1DdYiCzim2R9D9S3WqN9lomS4lVsvNShjB7A7pns6J97coNoFqgavuw4ckIZeDn7BEW27ZsmcEp50ulJ0F90AWzumxN2SPJX9vVAN2py7LDIe43BO3U6AwNIYHpBfGDKWPfd5NJ4hITh0yn/k41QN08x1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844371; c=relaxed/simple;
	bh=WIm1CFQ4YaVdOy1z3x70efxsPMRnm5cZ2AaEQxpRfoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHeAY+CvuonTzaRhbXIH93PN2k92EFpJtfVG3pWLt4bYmgfFFLPhBo37DwYvDcLWjaTQ4D2VSaEpBEy5MjQxJlyz1+KFg79gX2bR/sD0oYMadYkINm7IX9MQ3IKT/lB324/hRPnoyY2AScAdva2aRl3gu/HuxiGBE/dPMWGwmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/Z1cNk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB3C4CEF1;
	Fri, 22 Aug 2025 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755844371;
	bh=WIm1CFQ4YaVdOy1z3x70efxsPMRnm5cZ2AaEQxpRfoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/Z1cNk1L3VUuaxBcyuFeYBadBtIN26dibLnbwvJEFezltAyjLQLOyt9nyrDiWQij
	 cccVRmj5utvGDoXJYtq69r7qFYkV8uatk6nRhykB7lFNz+4cLiaM1xOjuVpENgID9b
	 5hMdFbHoTxJhoOtIz5wi8cF2dYrn+J8WfEZ2n48c=
Date: Fri, 22 Aug 2025 08:32:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alistair Delva <adelva@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Elie Kheirallah <khei@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Cody Schuffelen <schuffelen@google.com>,
	"Cc: Android Kernel" <kernel-team@android.com>,
	Linux Stable maillist <stable@vger.kernel.org>
Subject: Re: 2a23a4e1159c to 6.12
Message-ID: <2025082206-blubber-ought-421a@gregkh>
References: <CANDihLGGcVHO=8uX6+TWciJyXqy6KtRHGgjbAGq4a1hZ36mU8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDihLGGcVHO=8uX6+TWciJyXqy6KtRHGgjbAGq4a1hZ36mU8A@mail.gmail.com>

On Tue, Aug 19, 2025 at 03:00:25PM -0700, Alistair Delva wrote:
> Dear stable maintainers,
> 
> Please consider cherry-picking 2a23a4e1159c ("kvm:
> retrynx_huge_page_recovery_thread creation") to 6.12. It fixes
> a problem where some VMMs (crosvm, firecracker, others) may
> unnecessarily terminate a VM when -ENOMEM is returned to
> userspace for a non-fatal condition.

That is not a valid commit in Linus's tree, are you sure it is correct?

thanks,

greg k-h

