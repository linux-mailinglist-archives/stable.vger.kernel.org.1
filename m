Return-Path: <stable+bounces-121724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D0A59AAF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A86518905F9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844D22F166;
	Mon, 10 Mar 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OyU9UOyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1622A7FA
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623110; cv=none; b=Q7l8JjocVKUygBsNNUfz7oAboiXcRLlNTPp28kt5qzC1PaahNfUTd1oo9l8h4QTpEekoyYBxi5xrmrFvDtSlBvhiDAaWKKcPxukvtiSgsRRVbIrRJTZRpo/3rlgaoZXlqq6sOlj/96/RFdHQIuIDWs0RYADzp+7U8hQIZal1pJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623110; c=relaxed/simple;
	bh=1tXG62XAKm4s8GxA5ZztdG/ijquR1O70iFsEOXy70Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWX+JAZG4AdptbkhwN+IYWJBLEb7Bfgb1fGMYm5zrqWsdNryPZ1bTUy8TC9OZ3kl03GTMbzc0ztcl9OOA+1VTNfSrGlsm6nmAoJyXwy3vYbLwoXxbV/t9n3Tt13gaSRb3bOro1jvTvmocnGUbDPsEKSy7K/EHSTaOSBDVjVDxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OyU9UOyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840F1C4CEEB;
	Mon, 10 Mar 2025 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741623109;
	bh=1tXG62XAKm4s8GxA5ZztdG/ijquR1O70iFsEOXy70Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyU9UOyUnK1NXsEF7HGNPfp2xueUg+UCf8c+laAxvPMmdlnHPOiB73xL+MmjI/NSe
	 qblEUyhVI2hoKufLdxYI8hhhOQ7LwiekRtL9cVrz/BsnMvv8QePuPpSwHNVot7K04Y
	 /Tiss4O91cAUIaIt/r6HOTwgyRh2p+ZlfL9B9tKg=
Date: Mon, 10 Mar 2025 17:11:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH for-stable-6.x 0/2] Stable backport of c00b413a96261fae
Message-ID: <2025031038-confusion-parlor-05df@gregkh>
References: <20250309220320.1876084-1-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309220320.1876084-1-ardb+git@google.com>

On Sun, Mar 09, 2025 at 11:03:18PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This is the stable backport of commit
> 
>   c00b413a96261fae ("x86/boot: Sanitize boot params before parsing command line")
> 
> to the v6.6 and v6.1 trees.
> 
> Patch #2 can be applied to both v6.1 and v6.6. Patch #1 is a
> prerequisite that is already present in v6.1 but was not backported to
> v6.6 yet for reasons that are unclear to me, and so it needs to be
> applied to v6.6 first.

Now queued up,t hanks.

greg k-h

