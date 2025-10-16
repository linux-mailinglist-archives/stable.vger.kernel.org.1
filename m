Return-Path: <stable+bounces-185874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF7BE1387
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 04:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B62119C6C7A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A720298D;
	Thu, 16 Oct 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjtwx4VM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85117260F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580519; cv=none; b=rFQ3VCuPg18aSOSXnD0AAp5OAgKlZXtZAtKSk1J5rjNfjDkXu0SiCXZVCG333qcRSRXak+hl0fY4YnMbtC0yWny/XMbrmk2t+qX4YlQdUhXm7rcZbOji0FzrzfJU82HgUhb7AtQDJdgvTMQyljgTeYCBO6x8Ss/M4lbIXrAnAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580519; c=relaxed/simple;
	bh=yLSAW0BvSIprjBOvjLWDFlo3zpGUDliqA93OBfwvqK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiL1rnNx2dYIFDaE2189Xj7uk7mM1YLDzf3RQSnGdlgkUu8LIvDKYBcBj/rvGSYFTE1GHNSQOvZoQsOCxmNJ/DZAF4ln4LYZhHE3TTXsSQOANjMkAkB1hZbgZmy4pu9uHR5Ia3RjCXM5KC9KbsHSGrDVH0qONVkUknAHgFd0NjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjtwx4VM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so168347a91.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760580517; x=1761185317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmQmlMgZWUc3/3kOb22L5i35I5CqDvoiZHY/YAnIw9I=;
        b=Zjtwx4VMaKxljGiqcE52xgOLrxu6wd7eXi0ZY1QgOyaD9C76/InHRAhXrt7A+YNOZE
         kjY5f4gp6oYAfArClr4DpKaeDR6hXq55gedXj4+7LFbb8SMsCH29irtmd+nuuMZgczAo
         3n3qhhBvBWtbaBSBEY/J39IQPM1vqdt4C5hDEcvGZRyrWX/l5vqwNtrNr8oX27Zahs4A
         iBgPUq9Jrmxmvt4oYM7QawkA0IS8wbGt2s62pg+GH4c5rn3NVyAEXlfJUGOrgphOTLDg
         1CbASZq2Bie1K6LU3Fle+PusH+RzVSWCEiKSrvpeBW6ljeKfbz51vExGeH/cgaknyIKg
         fMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760580517; x=1761185317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmQmlMgZWUc3/3kOb22L5i35I5CqDvoiZHY/YAnIw9I=;
        b=Vc85z1iu1O0EqMxA5fys0so0wzsGK/8FhenPwRGqLVZv+3YCarMfW37Oz1eF2O3fz+
         RW0MaSjym3VsFzHEPv0M3DBsuNjIL0SRhciiKunUrsMzR8HRTwovnXhioZhhXy5gnTvH
         eMUb7o8EcTYk2yo8dSfyu6MnsN+TXMMkFzxzEhw7sQnOl2ncZRNxyVqQOBIR/sCC1GF+
         3vt8T1XYzDOxy6k/r1PzoUk9Zx2Rg/xxut0KVP+m4LWCb/1ihzt226glNF6UANBPTFGC
         sIKboY80nt7AU7K5NQEdPxhbBQ0Y/I6ZR2xd4+/c4gz3ySofld1sFe29OCeSe0ix00rN
         Ra1g==
X-Forwarded-Encrypted: i=1; AJvYcCWMG9PZMRPklp1ae+OGsrp3t5ghf7tWhaLXmpAPlidCE5e/CW+13AQ/GaT6YXPdMobT/BsNrZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoarB6HOF0P2jesZF5MZSeJ3MJSsvpY0ESjFn0JW6V2scTACi4
	no6mNH8ciCBh6h30/8BAePGCwfQB7LGy8XcxnNicFvbP1bcyYtdF6GV6
X-Gm-Gg: ASbGnctU1bh+6NxeYCSgWIIhp3VajATFb5WlwFHQ2DM7aD5GMtjdKxVU0muGE76OjyU
	vI5eB9lc1QLK+Hhxdat0ze2QN/3RroXXtUpjb9LB5QCbSVfc/Rpij5qZnIVwhnbmJET92R2hZi0
	MzkcF8jXbOJkJ2cB5DjOZko1xc9Gxyq7k/Bg03vrdeaZRGGx8nTCqqzeRovGXOxKz0JkkE/UCtr
	o347/o4T1yFpna9WmWTQ9DVR7ByXbPVLRgcpY1Bign4qMvnab2b/97ZDELnyAo24LowPy/zGX8l
	m78i3maQ3HTZCK1emrT5laXfv+YTgtP7i5t19+AxKRKSwcz8QNXWs+R+xcB+zgvbmrY/6IUsvdI
	jpg90m0muVedRSBLfwQnNnzMUWPjyOoz2QmSkI+dlcBfVxyiVynJIPFYFLKC64MGi88XtXRTBhh
	c=
X-Google-Smtp-Source: AGHT+IE4kaxo/0J6sXYQafAXDYDfRrB+jJbQaa8rsXequYMNbs/eknPqCiTM1l9jpvXtki2gsxjLdA==
X-Received: by 2002:a17:90b:1a8a:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-33b5139a212mr41848203a91.27.1760580516925;
        Wed, 15 Oct 2025 19:08:36 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba93cbb7asm315334a91.1.2025.10.15.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:08:36 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:07:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>, 
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Sasha Levin <sashal@kernel.org>, 
	Kenneth Crudup <kenny@panix.com>, Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>, 
	Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH 6.17 068/563] PCI/MSI: Add startup/shutdown for per
 device domains
Message-ID: <o7hrpbeszf564cznyns3zorrofz4kkffugbmvwwub5arh34vki@dgrqpuasd7ks>
References: <20251013144413.753811471@linuxfoundation.org>
 <20251013211648.GA864848@bhelgaas>
 <20251016030711.57e92e97@mir>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016030711.57e92e97@mir>

On Thu, Oct 16, 2025 at 03:07:11AM +0200, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2025-10-13, Bjorn Helgaas wrote:
> > [+cc Kenny, Gene, Jens, Todd]
> > 
> > On Mon, Oct 13, 2025 at 04:38:49PM +0200, Greg Kroah-Hartman wrote:
> > > 6.17-stable review patch.  If anyone has any objections, please let me know.
> > 
> > We have open regression reports about this, so I don't think we
> > should backport it yet:
> > 
> >   https://lore.kernel.org/r/af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com
> 
> I've received a similar report for v6.17.3-rc1/ v6.17.3 (v6.17.2 was 
> fine) on a Lenovo 82FG/ Ideapad 5-15ITL05 (i5-1135G7 and Xe graphics), 
> failing to (UEFI-) boot already within the initramfs (Debian/ unstable, 
> initramfs-tools).
> 
> Backing out (only) the changes to drivers/pci/msi/irqdomain.c and 
> include/linux/msi.h from patch-6.17.3 fixes the regression again.
> 
> Regards
> 	Stefan Lippers-Hollmann

This is caused by the vmd driver, as vmd driver rely on the assumption
that pci domain template does not set irq_startup()/irq_shutdown.

I think this may needs the following patch:
https://lore.kernel.org/all/20251014014607.612586-1-inochiama@gmail.com



