Return-Path: <stable+bounces-146040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A2AC0588
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F907AFF03
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941F22257E;
	Thu, 22 May 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wikimedia.org header.i=@wikimedia.org header.b="O26dM2xw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E12222CE
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898497; cv=none; b=lswIgY0xvLtBweiuBDrFhbSYzsfYL1drW8KVdCvTX4enFWj1Ts+oceSXD7jrcx01D8HAS6+wg0acXnCUuIvx1ibrUY4bWIn+2JwdCR1vHo5plLOOfdRwvtB53ryyOxR3lbdo9Dzfmg9gMGVD0l59p1iPFAJ1CMrLvwCOQJv3kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898497; c=relaxed/simple;
	bh=dP7GL+thuENnOa6QljHoFx/ji9d+kmAW2+rgC7oF2fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEpEK01putmKeG47Hcw+VqT2kmB6S12t75QrBKhVIxrQ8njefh5pCiRKzYm4er7JroTRZM9zHyzxsOq3A50o41huMc/koQMAxUaUWj9M7sxQv00IsaEW4QQk5w/0Hp+LK7DFGP36EY+2psj3GtswxkTf1YII970SvY8808I+D5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wikimedia.org; spf=pass smtp.mailfrom=wikimedia.org; dkim=pass (1024-bit key) header.d=wikimedia.org header.i=@wikimedia.org header.b=O26dM2xw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wikimedia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wikimedia.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a37d24e607so1943592f8f.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wikimedia.org; s=google; t=1747898493; x=1748503293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfxvhkcdHh5OvwBCnveBRjxTNcmjBDdwmwzm2nmg9UQ=;
        b=O26dM2xwk0799n7Rxczhlj5wSxeKcsN+h2MmvG9BfcpfNh87Qw00j9eEPdTPxnYE1w
         Bp3hDeXpfPpKrxXmYfXcliSWoIKrnSJQy1dTGeJpi44leOCRuY2W+Xf+gaov74PY30Ds
         Olm8zbtOhH135ny4my+MOX8fR5aqrSOC1eFJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747898493; x=1748503293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfxvhkcdHh5OvwBCnveBRjxTNcmjBDdwmwzm2nmg9UQ=;
        b=h+FX1tXWDgQRFBPEUvdNF8bPCCbYQhngXKPLG/WnS3AowHBV81n29ia65wrQuJao3I
         N/TI6sUt6pu1RXVHBeLSkk7MQPm15EUEbkNo4dJnygvINveeB5S5PN2E4dzQEUua0LoP
         6jneny5yJK+8g7FQx14VpCMStHfWg7XVsCBjlmJ5jzPadabi/1/g+eKhuWJjx9m7Rnnd
         HTFlqEwPGjbdbFRQngr0VRVGXGPQnUwRou0fRb4upSem6g88GrVpVo3VcGHwl+CtHEhn
         jA5O4kNbbtrU3YR9WhEtPqygfdzX6fsFnTu5uDhKlVd2bRnvfkmEdQYTd0Z4PqG42Vhz
         brOA==
X-Forwarded-Encrypted: i=1; AJvYcCW3veQO8LSTmdD8od+LjxRE4qwUjgHZWAqerPtylAmXm43sJPW99ob+RFzxFrlEzvv6Ca9npLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsgm+0MTh/YgXgqz6BO1N7MA/WcjpafM5FbkFJvuswVyLVon/
	j57qsD4ToasM0DPI6n8aIcwmM2DgowyzTgwAiW7CcVhm3C1zGv6jL6qzwd418yP2FfI=
X-Gm-Gg: ASbGnctHlxCQYTCPvOZ0TChzIbZ6kDC2/lC9L6YH6lE3OQhW+Wq2A3E1B1oj6TFl+De
	DYVUyOQHIObFVbooB53qsr2VHgF1RwFYw3pp3Ri7QxfHqhmnzKje5hcaG3NYiX4puxUDXbwr8ik
	G8YEiueT8FAfFI0OZpU7gf4oC5xZNbCYDHKBe4UICbhrid0VCKaARn8Y5WfpepRQwin46/OUlAM
	MBbXoc2/PjR0SIIMx6c3SgbHc3PXP6WYwb2UuAgP/67CUH3umS6Ccl1RN4JKKlqyUpn17yQ9EA5
	L9M27MzOfoYkr28XLT51PMn9ytX+wW51+b0Ou0dstcl3qMOyHUuCM3aOsq2nbGW3VHKIh+7KJyW
	MQ/wIi4LprZhiMb0Cu3tWZZXtLi18Wje5UL6yw3ljIFyc5N8PGptJNyx2p/o=
X-Google-Smtp-Source: AGHT+IFJ+Cy/G9oDt5tGwRat5x4LMKsb47Oeo6C29nhqA419f+nEUolSDMFo2oB4LIUOz9WtzgKh5Q==
X-Received: by 2002:a5d:5f4e:0:b0:3a3:2aa4:6f6b with SMTP id ffacd0b85a97d-3a35fe5c59amr20067082f8f.1.1747898493480;
        Thu, 22 May 2025 00:21:33 -0700 (PDT)
Received: from pastis.westfalen.local (p200300f5ff135a000b0fb2ee3a2e2937.dip0.t-ipconnect.de. [2003:f5:ff13:5a00:b0f:b2ee:3a2e:2937])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0aadsm93187195e9.12.2025.05.22.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 00:21:32 -0700 (PDT)
Date: Thu, 22 May 2025 09:21:29 +0200
From: Moritz =?iso-8859-1?Q?M=FChlenhoff?= <mmuhlenhoff@wikimedia.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: Regression between 6.1.135 and 6.1.139, possibly related to ITS
 mitigations
Message-ID: <aC7QeZiJVuURxptu@pastis.westfalen.local>
References: <aC3R_CCacqN9XmiL@pastis.westfalen.local>
 <aC43zcG1v0A0J9Hp@eldamar.lan>
 <5d97e611-919e-45fa-87e5-00a489870f8c@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d97e611-919e-45fa-87e5-00a489870f8c@oracle.com>

Am Wed, May 21, 2025 at 11:24:52PM +0200 schrieb Alexandre Chartre:
> 
> > > On Linux 6.1.135 every works fine with both the 20250211 and
> > > 20250512 microcode releases (kern.log is attached as
> > > 6.1.135-feb-microcode.log and 6.1.135-may-microcode.log)
> > > 
> > > With 6.1.139 and the February microcode, oopses appear related
> > > to clear_bhb_loop() (which may be related to "x86/its: Align
> > > RETs in BHB clear sequence to avoid thunking"?). This is
> > > captured in 6.1.139-feb-microcode.log.
> > > 
> > > With 6.1.139 and the May microcode, the system mostly
> > > crashes on bootup (in my tests it crashed in three out of
> > > four attempts). I've captured both the crash
> > > (6.1.139-may-microcode-crash.log) and a working boot
> > > (6.1.139-may-microcode-noncrash.log).
> > > 
> > > If you need any additional information, please let me know!
> > 
> > After looking at your crash logs in more detail, I suspect that your
> > issue is the same root cause as spotted as well for the 5.15 series in
> > https://lore.kernel.org/all/81cd1d38-8856-4b27-921d-839d9e385942@oracle.com/
> > 
> > I assume you can confirm as well that disabling the ITS mitigation
> > with indirect_target_selection=off makes the system boot?
> > 
> > Regards,
> > Salvatore
> 
> And this should be fixed by this patch:
> 
> x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

Confirmed: Running 6.1.139 plus "x86/modules: Set VM_FLUSH_RESET_PERMS
in module_alloc()" resolves the issue: I've rebooted the affected server
four times with a custom build and the oopses are gone and it reboots
reliably.

Cheers,
        Moritz

