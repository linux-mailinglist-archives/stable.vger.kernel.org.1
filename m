Return-Path: <stable+bounces-61942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035593DD61
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 07:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065F61F23F0D
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF5179A3;
	Sat, 27 Jul 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ra5FhW/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AA14290
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057030; cv=none; b=dhRgAMkgRi9oj5yeaK6NgO1X+8EsFT2LITeXeQveIGNn9FtREVtuRgagMz/4kbr0JnqMyghVxSzckflZnNJ7FndcaeFA0Cee+nTHy6j7WiB+noKM70ndCnmpNBITmwaTN0C+EVbb8+5Lis6oPKMReCXCnrPnaxoeSmI1SP6Mrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057030; c=relaxed/simple;
	bh=auo4fTunZsreZJwnd9jfvqLTZMnaLGCenpW62Cijhgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVYvvhW8847QeiGOFRV6M9LGoPDMs2z7Id8PhRm2lEyVERrD7tJkbUc83EZ8F1ItQJDawlp55CeL86kyMwbZtvFj6KYqxP6DF7kGwat1PAtU3rFCWTOjv4Qsuc+UuTvqzNnuqlDKkIHH7eT+NrBBGMMhJYN6opCyFtSTnkOZgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ra5FhW/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA2C32781;
	Sat, 27 Jul 2024 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722057029;
	bh=auo4fTunZsreZJwnd9jfvqLTZMnaLGCenpW62Cijhgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ra5FhW/1uMPjBaO423dxKs2OMkmDxpQ8qqjQUrd+RLjzFTTl8FstRlIRK0j4NqaJM
	 wRLSO/QKZU9UizjKubT7mk2UMdh2qFYsVv9zipf+5XORVO411C7Lh1aSTLFHX4V5bi
	 Anf6bajVzbLtzcZTOFTepL4+K+B9tE05HnIQXhig=
Date: Sat, 27 Jul 2024 07:10:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tj <tj.iam.tj@proton.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: v6.8: cmdline param >= 146 chars kills kernel
Message-ID: <2024072722-borrowing-arbitrate-256f@gregkh>
References: <JsQ4W_o2R1NfPFTCCJjjksPED-8TuWGr796GMNeUMAdCh-2NSB_16x6TXcEecXwIfgzVxHzeB_-PMQnvQuDo0gmYE_lye0rC5KkbkDgkUqM=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JsQ4W_o2R1NfPFTCCJjjksPED-8TuWGr796GMNeUMAdCh-2NSB_16x6TXcEecXwIfgzVxHzeB_-PMQnvQuDo0gmYE_lye0rC5KkbkDgkUqM=@proton.me>

On Fri, Jul 26, 2024 at 01:48:44PM +0000, Tj wrote:
> This is v6.8 specific; v6.9 is reported as not affected (due to
> extensive code refactoring).

The 6.8.y kernel tree is long end-of-life, there's nothing we can do
about that one anymore, sorry.  Also, you really shouldn't be using that
branch for anything at this point in time either.

Always check the front page of kernel.org if you are wondering about the
status of any stable tree.

thanks,

greg k-h

