Return-Path: <stable+bounces-121559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B8A582AB
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C777A4097
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5719D89D;
	Sun,  9 Mar 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UB+Wn7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8A18CBFE;
	Sun,  9 Mar 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512227; cv=none; b=Cnmk+jZMDsW8b/MJgYuNQaWIBrsjeHcQXqSkKv7WwGjMFpSITpT9XnooSyV6r00BS7npdmrdA/UfiVuKEGVXl5LfSginlAP6XYuAVBiVC5jlU5gHX0fnICEHEQXx8rmm4b/aMejrrBS8u0hGSR1KS8UhSYu4zr/sVw9BbUmEdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512227; c=relaxed/simple;
	bh=NGUThif1MWAbt3yYjCQawzz72SNY3fuWhUbs+gZEPUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnG7NPzPc1Tpd9+G2CawHwBgwRGub3kYaFgURfldfpYbUaUb+5fmb4w6L52QsEtYHehSu9RT15enqXkpv/LOnIZ1CtxTB212UzE9Ab00ruvBzKvqGVzkxNpF9m+6mwYvWvzGp8CoNdaZDD3BV8hDpXE/rpy4rOInRw7r+arF41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UB+Wn7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F30C4CEE5;
	Sun,  9 Mar 2025 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741512227;
	bh=NGUThif1MWAbt3yYjCQawzz72SNY3fuWhUbs+gZEPUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1UB+Wn7eTNO9nmCReuyR+Sc17w/eBSy8b0Rpoz7PckNrstPyXF2RqKe5fK71qCcct
	 OYdK5Z5lx9DR1wq9zWqWrWu15wRN1iK1nfMHOkyODbDidhOJhU5sfuemRW6LS/Uiv+
	 5yNzaZBMUVueoeSQvvLADP73aOTIlPZItCgexsgU=
Date: Sun, 9 Mar 2025 10:22:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: =?iso-8859-1?Q?J=F6rg-Volker?= Peetz <jvpeetz@web.de>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org,
	x86@kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: Linux 6.13.6
Message-ID: <2025030925-crazed-swerve-57a3@gregkh>
References: <2025030751-mongrel-unplug-83d8@gregkh>
 <1b3ea3ce-7754-494c-a87b-0b70b2d25f99@web.de>
 <20250308163003.GDZ8xwi0u3rAAX0J23@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308163003.GDZ8xwi0u3rAAX0J23@fat_crate.local>

On Sat, Mar 08, 2025 at 05:30:03PM +0100, Borislav Petkov wrote:
> On Sat, Mar 08, 2025 at 05:03:08PM +0100, Jörg-Volker Peetz wrote:
> > [    0.000000] microcode: You should not be seeing this. Please send the
> > following couple of lines to x86-<at>-kernel.org
> > [    0.000000] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
> 
> This should fix it:
> 
> https://lore.kernel.org/r/20250307220256.11816-1-bp@kernel.org

Now queued up.


