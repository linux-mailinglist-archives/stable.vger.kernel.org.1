Return-Path: <stable+bounces-166656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73664B1BCB6
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 00:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A07B182CEF
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083E239086;
	Tue,  5 Aug 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbxpi3Hz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BC21D5BF
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433429; cv=none; b=IRrEErQwfjHRGH5XJslraxQChA3il5/bbx7aieS9V3CVBXe+Fy8Nsoo9X8ktk96x+RreznI/VAk9LVsLs17DgVRSky/5R8pjhuXbUCofzlGS1fOkQgPfu6203fiwnCDi6FMMy6VEpiuuJ8ycnfV2hLumvu0Y0QB2p0kB9u6Ty3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433429; c=relaxed/simple;
	bh=HA1c0NCotH2ussu5tik/WdpHFFnoLoh3XZP1ddKq8C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nANf1M5O2miOBIt4jqF+G2vcj7MoiG8YsbQclDb55VFErPGBTJYUrR4Ka7muC/0G1sIGqPLknbev8mO6UGvwXHg2q+v2CKwK7fqY2fB/HLnjOYWSWpaSb9PV065qIBdFiDiUeNriuWf9CCZj55FB2v1n23RqPWzeByOyC+yHYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbxpi3Hz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32128c1bf32so3689696a91.2
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754433427; x=1755038227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HA1c0NCotH2ussu5tik/WdpHFFnoLoh3XZP1ddKq8C8=;
        b=Bbxpi3Hz3VFGYz9UNu8WKsqrLVbx4dZSkpyW23qZwXQvOBvQVEoYRc+yhnT25zUkJv
         gyafGev814+8B0jiomgRh1HG0lST7de7YyQ87Wwiow9rbpEKi2EefO12Rz0y1Gbt6SUu
         PLxeKASlbD8cXBtuogYdqEhodJdd1SRxayvINWjR+P4Cg8Wf4DsQ0IwWHSqC4EbXucZ2
         jb4V27PluGDN23ioeqQlIQwwy2ClXGU26Cy+c+COV5m0zTlP50sivP4c3m5IJpfkaae9
         ABSfuxPv1zCCW0KxBCJgeIIQZ6o/hNeCgM1BhwmnJFh6/cTKuFqV1ATLRZH8MEvbglxu
         0PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754433427; x=1755038227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HA1c0NCotH2ussu5tik/WdpHFFnoLoh3XZP1ddKq8C8=;
        b=FbLaBnz9M7SCfx8jxFkmZvky5+rULHDn9fwRchGSMkMpte+thZKpx9zWBOWIcveF6p
         mhyFBWGXOOCpCc2//SiT8Gjmd6EFdvWcZdH1QmfBKzyUUuyIJZOAMVzkg7XVFop0fUq/
         6Ml1XCg1Ost6+aLSLzV5kZTqARX6rv+/5JT6MJCEtbEHmI+7cz8plyEEb6N8OreiJOlA
         WV/wAa+roZPVOEqSgs4uNVxiE1RcCEUd+DbJQsttnnKYtTVejHY1VIGLQMihB6SAA1uL
         0t2TCKin7HLLFZoLqHX5FvlxQTELnBNdBcm6P9sIHEtt5PQZs8kLaF7fyWBfki7GZavi
         lAjQ==
X-Gm-Message-State: AOJu0Yw1J2h4VNCPokL5Lr9QMr39YLGdlhq4UqN8q2G4QTjnxCrKJLWA
	WLDthPzRYPK0gziiKoz0DkZF0ofMYy9s/Fim/3NfwF5asNFUV/8Ve27bbJmJB6B55LkHW8abMbQ
	6iHRQNLL14chyd3v5s29+LMr8rAy2gFM=
X-Gm-Gg: ASbGncsjaXscx8jxBQH/4OdHsSDkgkTVK87vRB8W/LyJ9VfggkJ/CVKeGTfs2Y1paeB
	kkbF7INXFf0kusnBaE1veUzacc7TyP+h1lp48qoOnJ2LLb8alr2SvYTdtt8xzcN4oBP9J2SYB0J
	/7WSK/tWTXri7vFTH3o69RNuXUuxhpyTXpI5tK4i7MHykUkp895rPBJY8DB87fr0VcV5r5N3LoW
	P8RxkY6e3e429Tjjk0=
X-Google-Smtp-Source: AGHT+IF1jrK7B/qscErx984eEy2NbRNJWjYbCU3XJzHRuSxC91Donl/sMtPj9vBuwWvzasUwCXNwtfX8KmLSSZs5ylc=
X-Received: by 2002:a17:90b:53c3:b0:312:e279:9ccf with SMTP id
 98e67ed59e1d1-32166c1034emr562956a91.5.1754433426914; Tue, 05 Aug 2025
 15:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 5 Aug 2025 15:36:55 -0700
X-Gm-Features: Ac12FXz7CmTqZlXS_q9Cm5z0Er6tXIvgLL0TcilmWmlYBOYFBu_AIwSYPhJMJYY
Message-ID: <CANaxB-y14k7xnzzMSCTejn57FZi2-qNeteGVBt=9Sxe7x9dc4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] x86: fix user address masking non-canonical
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jimmy,

You sent this v2 series in reply to the original version. Usually, a new
version of patches is sent in a new thread. I think it would be better
to resend this series. Also, you could add the kernel version to the
subject line:
[PATCH 6.6 v2 0/7] x86: fix user address masking non-canonical

Thanks,
Andrei

