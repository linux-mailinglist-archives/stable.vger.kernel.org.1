Return-Path: <stable+bounces-203405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7BCDDE18
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBBA3019893
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E032B998;
	Thu, 25 Dec 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgCAOeS8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D11329C67
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675899; cv=none; b=njnNR3fvS/VxB+mzVqrZ2o6+rk9PfO7NCVlw7Oob3iwvzIb7ezpshH2NeOGrVFzs+U7VdjgnMq/+DSYuRy2o2Piv4Q7q9FhIn1ayr0tCZ26mfbCft9lt4dySWWKfVSRfrmDN9DazILWLvyMxaY+mJnUC+iixXuXjuMXQ2EslRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675899; c=relaxed/simple;
	bh=MbMBUpR7B2x4JyBu84ec/Nl4m/QIwV9QVVSShfb9dMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5N7RuAwlI+EcolK6rYDXAr0akPXI8zjy1PMHnkjbdDgBSp5wqreAIay1YAXh9xsvpuuV3BGx6P8rZuZMsU2/9haO+SQqe87kRBUECM4Eg5P5mei7wVBszeIE57JoLJdM4bP5muoVBL/m8eNC1o+iRjAX95HNAk+g77lSh7XaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgCAOeS8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so4904100a91.2
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766675897; x=1767280697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs6BJX7+RWUbYyZjj+cOPleo4iCRlFe1YsbACYZyhFI=;
        b=cgCAOeS8Yvk+9LCKE/fHmRulgnlQzJIUyW0juEgc3OseKtBjGdBOSNyCXbkOC7COCt
         Is33sTVt5+DDeP3u4VMRsm2qWaBgQAjIIusab5yL91HohBt4r9wTkAw4XJMQwRktM9jw
         ukEeNSY/DqEsP50+iVRoWfWSb+1WfqlM+ogrLAar6LTqMICAjYXqsVxnNpN6EL/ljSTE
         F0pm3q7kY6+xDulaoaeEx3rrJRtFh18F3eJfqTsLGVfmhfRRep8gp5ueYU5XUHCIpvp3
         JIRn0z5/dCf3wMGoUaQlFbFsROQJNlhPpK6uILb+9ZWyevuqJSEpDVk8JU1wKmXhi06l
         xO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766675897; x=1767280697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs6BJX7+RWUbYyZjj+cOPleo4iCRlFe1YsbACYZyhFI=;
        b=N7FuOyd+VwQm3faWfH4rvEshIFFtq7QLxS1or2e5HRwrAhooxu1/mM9VFlVQXvh6Bs
         WPQRZPv8LBAIVEHduKawGYPGOo02yiadnaT5YnjHIDf4H8JAQWoLpHcseXkW4XH/2NOx
         FiMXkhzSeuhKKc1KbTeBUibt2kxrWKZylWDx3fJQI/yEi2vdOrjLd985qKT0t8zg9D7L
         Tvn+unC8NBQL8isSgnOfZtv44TtzPMn0t2BDyDwyaFshmbnjSfUyqldPIUfsldTAzwNR
         FDrEkuH2LhuaxNUYbW+Uo4VSsQc+wvzUcPCuwD9cfQNK5a5X+MZOfihK0HminnJXn/CQ
         nw2A==
X-Forwarded-Encrypted: i=1; AJvYcCUvxCoknNby1wfG3nPYj2unXExPVPzz+fOY6Og9K8wNaERMSMzqNfFnuj1t+E3abDO3/IynRCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEiTUe5wYqL7/QhXOvkKKZzexxn3rKYG6WgU47RaL6pqyfrED
	BrvlSCEOS5V6PXZTlWEw8UGFi/IUOq0mFuwZ8Ra+fGyXH6/r7R3ESSkM
X-Gm-Gg: AY/fxX4OSWRUeY7KyPQcKsgOF48oFftxiLDKaMgnhnv94lC+Rut/ywAdV43sahz544o
	puWwDomDTTFDw9IJy/4BTxRa3++rypNptv+E3VgU/Q/xigh7HFtAsOp++vhwxZ2cFrPdxiHViuL
	cuGU7DonPEgXX1IXp8gZqLrGsXP4Z2+DG3bx0wJc16yBLM7JZMG7m45JEcifLQpP+Y+KRi6STnZ
	rFb2aXYi3FeqlPd5fVDe2X7RRnEfAiMWZWh1KihjMmTECnyL+xiI4BX7O0PW6SqP/bUyGpoUhda
	CrSmtlzobqAoQ9yhZRZdI1bCK/Hl7QcK/fcD981yWy3poObcB0sDczjt9Ji6lVrEW0co01FsWX4
	ki8gIKWkLMZKlCramRQ3qprQjBsxAzcNNv6iDbrbXIvGOMI7SNoQmURkQdm+QK4Puwqsg1pXdsH
	gGQt/Az85iLI4=
X-Google-Smtp-Source: AGHT+IFyYhem34TIt5JkWzwnSB53xq94ui6A4MQrPDy5SuIyfwhYp7CBOvr+9/vlj+sQXcZsrKKlUw==
X-Received: by 2002:a17:90a:c888:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-34e921f582amr15972331a91.34.1766675896814;
        Thu, 25 Dec 2025 07:18:16 -0800 (PST)
Received: from inspiron ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm9337558a91.11.2025.12.25.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 07:18:16 -0800 (PST)
Date: Thu, 25 Dec 2025 20:48:08 +0530
From: Prithvi <activprithvi@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Message-ID: <20251225151808.lvpfdwqvcej4vxgm@inspiron>
References: <20251225072829.44646-1-activprithvi@gmail.com>
 <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>

On Thu, Dec 25, 2025 at 08:08:50AM -0700, Jens Axboe wrote:
> 
> On Thu, 25 Dec 2025 12:58:29 +0530, Prithvi Tambewagh wrote:
> >  __io_openat_prep() allocates a struct filename using getname(). However,
> > for the condition of the file being installed in the fixed file table as
> > well as having O_CLOEXEC flag set, the function returns early. At that
> > point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> > the memory for the newly allocated struct filename is not cleaned up,
> > causing a memory leak.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] io_uring: fix filename leak in __io_openat_prep()
>       commit: b14fad555302a2104948feaff70503b64c80ac01
> 
> Best regards,
> -- 
> Jens Axboe
> 
> 
> 

Thank you!

Best Regards,
Prithvi

