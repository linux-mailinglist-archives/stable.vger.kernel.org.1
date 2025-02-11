Return-Path: <stable+bounces-114840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D709FA30326
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AA6166DFD
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812A1E5B66;
	Tue, 11 Feb 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/Or0PwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703C26BD98;
	Tue, 11 Feb 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253630; cv=none; b=BSKrUwhSHXZwnK97HxGkYu/1L6g9fKXbmOlC5jPsGdBSpIqOfwNkwM9S6utba+XCfayEkZZOEjyQ0esDtvcSjEn2J1DLAoaY9HD4zXxeuBkVgPO2a2khieS7gCOtcBaR1IVMM6oMgpx0g7/upqYP8i4Cd2JXxs5cEboE0/Fl+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253630; c=relaxed/simple;
	bh=JdWtLw17C1nfm7u7ea4jJC5huVL703xGqMB9SVBoneg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdwNrVCi4+VMUwAdDXkvYAY4bcXrChZWCEzbwLVvZTezedfEUCqcVtYvY9s9BbDCBj8aQuDV15Dy+oCnLMjHcJu1IaRhCXFXwAzkV0Tnjh2qRdL9rU9Zg6J6lY+fCXvNF+j6xnj0JPCEhAR0bOwlWYSxwXKBJu0PgqPMEBf8snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/Or0PwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF91C4CEDD;
	Tue, 11 Feb 2025 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739253630;
	bh=JdWtLw17C1nfm7u7ea4jJC5huVL703xGqMB9SVBoneg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/Or0PwFSgLjja7MNpaGtl8IpC58RRoEAU+vqeZbQqHflZo7dtiNMpY7nNT3RrmCE
	 66ILcpcQ30QE7KcZB3IH1Beiw40OLVrDJqOi1B+G6XTeE0pVQSfgqjN7SJ2CEtfDqj
	 fxOf0v/HxaL5uYEtZ9O2pEWQJg478BY0JTTRT2ZU=
Date: Tue, 11 Feb 2025 06:59:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
Message-ID: <2025021148-expectant-rendering-1019@gregkh>
References: <20250207203441.945196-1-jilliandonahue58@gmail.com>
 <202502082022.ILQXjseT-lkp@intel.com>
 <CAArt=LhOBqH-qZVkdBsh13Csvv1GrDBqakfPGjpFt0TF8KBYsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAArt=LhOBqH-qZVkdBsh13Csvv1GrDBqakfPGjpFt0TF8KBYsg@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:18:13AM -0700, Jillian Donahue wrote:
> Ah yea, this error happens because in this commit:
> https://github.com/torvalds/linux/commit/8653d71ce3763aedcf3d2331f59beda3fecd79e4
> the tasklets are replaced with works. Should I request the patch to be
> in v5.10 or should I update the fix to use
> queue_work(system_highpri_wq, &midi->work) ?
> 
> > >> drivers/usb/gadget/function/f_midi.c:286:31: error: no member named 'tasklet' in 'struct f_midi'
> >      286 |                         tasklet_hi_schedule(&midi->tasklet);
> >          |                                              ~~~~  ^
> >    1 error generated.

Always submit your changes based on the latest kernel tree (ideally the
latest development tree).  Any older kernel backports can happen after
they end up in a release.

thanks,

greg k-h

