Return-Path: <stable+bounces-33796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3738929DC
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C40A1C20F69
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64165BA30;
	Sat, 30 Mar 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oqte1Kqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B61C0DC9
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789384; cv=none; b=NS8vXnFYJ1Y6uiAlEET/i1QzButdstB+PybKA5izDj4pkOEUTq3ULvfnhgl4bKV2nHRrr76fKFGGvRj+9bjhnmPHeJmSLBw2OoPjq8II9Zv/piAXbI9yAJXLiXg9YBcZ3Q+noUpaNC99S8ixD/49U9hTh0h3aO5gP6U5pTtZzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789384; c=relaxed/simple;
	bh=BZolKp8iHhFthQxQduZu58W+FB+ZkT1PxRXM0ojha0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwavWRuTzYiW90Cbdvqgh3QGlafgHYl3E952C9u8W/vWXLmq8UpjZF+czlUJvCEZczCQBZudGeA8nDSqPxCrQHB59SbmGjmi28CykM5FdHKSLZUoRAY0u1FwiDhYJ8FjWA7sxJ+CubNYNYjeY7dfhDworBRlYn3aEdbutLJ3wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oqte1Kqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0484DC433C7;
	Sat, 30 Mar 2024 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711789383;
	bh=BZolKp8iHhFthQxQduZu58W+FB+ZkT1PxRXM0ojha0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oqte1KqciUswQ84LFF5QJO5RfLHPVny7VCTYP3d3MYaAHkcDpwn0NCdZY4+hom/W4
	 tDNfCf8L6xVzIYtfAR/AlgwuDqyFwUtWAlIi+IhGY7p//wTUKZC2IRTGzIfqwNxUB8
	 JXY1jmSo+s993R87v7svs3FG4+WXMn5JgSDvSGwM=
Date: Sat, 30 Mar 2024 10:03:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Borislav Petkov <bp@alien8.de>, stable@kernel.org
Subject: Re: [PATCH -stable-6.1 resend 4/4] x86/sev: Fix position dependent
 variable references in startup code
Message-ID: <2024033004-mutilator-alumni-358b@gregkh>
References: <20240329181800.619169-5-ardb+git@google.com>
 <20240329181800.619169-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329181800.619169-8-ardb+git@google.com>

On Fri, Mar 29, 2024 at 07:18:04PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> [ Commit efec46b78cf062b7eab009c624cf32dfdab99aa7 upstream ]

That's not the id in Linus's tree, or anywhere else, let me dig...

It's really 1c811d403afd73f04bde82b83b24c754011bd0e8.  I'll use that
here, thanks.

greg k-h

