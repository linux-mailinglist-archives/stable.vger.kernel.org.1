Return-Path: <stable+bounces-121701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB76A592FF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C88188F0CE
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CF2206AB;
	Mon, 10 Mar 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wsbzJqz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5119F103
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607209; cv=none; b=nyzENGv1tiTNLPpFdJCYJIUqxD0o4iWpLmNloDjEvxsmxZc942UVJ2nTmuTpa9pJvIQdvdDpSv6qwEOZ7v3Zr+w8/JdL9klf3CO93YbnzGNaYcJBtU3c4Tc+lAIpR1ZqIA0Qq+3uHRsUEHQsm4Cmdfz4Z8xCLLXHuiRMiQ5RDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607209; c=relaxed/simple;
	bh=GwvITYkQr9hQCyBC4OFdJdpWXEia4u6/EagUNuLS/fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nppPZRKm3z+xk6v/d18PZggeujguG6l/tSBdbEzorICNjms2+XNhrrWf1iGPnqPsgY/sIyvJYsPiRgHcMWgmButk8hH+Dm5kw+aFW9Qfnf31jg6lBD6JP5yRvPf1zWoAKM3g9P1f2ORh83ldVf71FzJrK/Hn/0PdHGJ14U4eaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wsbzJqz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BD4C4CEE5;
	Mon, 10 Mar 2025 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741607208;
	bh=GwvITYkQr9hQCyBC4OFdJdpWXEia4u6/EagUNuLS/fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wsbzJqz1nVqQm4UocqgFC3NfwtINZKJMPLUmGpFBQ+/3n2Rsyfy+JX4Px/G+USnYk
	 1qNSfOgULrgb7myLR+hWbdrQJgimn544wwz2p7JoIVVPnJszVAvAj4R5EySUxdZHUi
	 izNeCHTtd7SoC6LkH0Uu6GKiT8fD28psbGV5yhuw=
Date: Mon, 10 Mar 2025 12:46:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: agordeev@linux.ibm.com, alexghiti@rivosinc.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, david@redhat.com, will@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: hugetlb: Add huge page size param to"
 failed to apply to 6.1-stable tree
Message-ID: <2025031031-overfill-woof-ffb7@gregkh>
References: <2025030437-specks-impotency-d026@gregkh>
 <f1cbc610-e78d-44df-aba1-9c8b392670f2@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cbc610-e78d-44df-aba1-9c8b392670f2@arm.com>

On Thu, Mar 06, 2025 at 03:52:09PM +0000, Ryan Roberts wrote:
> On 04/03/2025 16:41, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> >From v6.1 it becomes non-trivial to backport this patch as it depends on a patch
> that is only present from v6.5; Commit 935d4f0c6dc8 ("mm: hugetlb: add huge page
> size param to set_huge_pte_at()").
> 
> Given this is fixing a theoretical bug for which I'm not aware of any actual
> real world triggering, I'm proposing not to backport any further back than v6.6.
> I've already sent the backports for v6.13, v6.12 and v6.6.

That's fine, thanks for the backports, I'll go queue them up.

greg k-h

