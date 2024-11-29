Return-Path: <stable+bounces-95788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B799DC188
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A43628185C
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A517277F;
	Fri, 29 Nov 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBYaK8A0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291D15747D;
	Fri, 29 Nov 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872624; cv=none; b=e+9TZaAvNdEuu5VJ+0dHlClSFGzXpSUNJIowjDPWTiaNr1psKVSinQfBOQ+qDcagm+ux7tG4txTM1CsClYXwRn7LFHR60257N93ioaGHSxUXZa5VD55FDbXvfH5reEy/mualj1wFQ6WhsHmQ4h7DKzsmQ/UHT8mc4lUU8bgthXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872624; c=relaxed/simple;
	bh=5qFwAQVJ5aEaLqUQNcNBF2r8DvEp0/gr+E1dttl+VC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIwJTzBageInefpZbKYjMJl2Q4PiWeyEo8Dg2/4mrIsUX7+tTL/ULf0f9b8pE9DmuTu64o3eeIQL9StT2ox3+QYBBFKeiJDeiWMQwSnroBWUTgsKFd3FkslpyRfZeYLKKul+2SXfkdbttjsoioR7WcEk0JZi8bMA4TxkQkZk0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBYaK8A0; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4af1ace57c7so1270954137.0;
        Fri, 29 Nov 2024 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732872622; x=1733477422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qFwAQVJ5aEaLqUQNcNBF2r8DvEp0/gr+E1dttl+VC0=;
        b=iBYaK8A0HTTnofWK8ngscWW+a+qKpIR0NZyTMbRedKEhZ8uYXTEqk8C/o88hbbDEFm
         AFmHXgf9GV16rVWubi+5gw07dWD1L50spSe7W62DrOIRv4I3d/UEsIvYlMm96qE2WPUB
         jE9WKJw0AdqT9gWB7F+EFsOczmp1exi5PDGQqUMpYMyluUcTS//MYwfRdBKk+yVGzGlV
         n70oeYEZOcQEGMbJE+WMppNdWQlZwhaxfAb6pEerLpjeBBlZWFN/Wr6UAybI27jdBF4J
         9XNpepQ4tKee3OE6a778SjjdEKbs+j7jpXyJDMtAAsf0NN4FVg2FDHtlLLkDa2yssYWY
         qP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872622; x=1733477422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qFwAQVJ5aEaLqUQNcNBF2r8DvEp0/gr+E1dttl+VC0=;
        b=R6d++dJ3HOJHycjbgCsKRinvEo+8sRRGYugger3MSgprNt9mHX3mUjWF+VKFBhVJdj
         vcYRMXMvJHeCT1VFQafJNXr7srP3dhfrMB0sgmcNlLgqpWtN8Mg34pILDvNvyfQ5ypbp
         xNY8UJ0XURbZsACKks3kySoVb1yVa9FTHKaVEnck4+mtzpHvGLQHRZkH9/JAAcrS747h
         1VMsQopXRIrEql7rxrvkJArsz0wSed/ACjSArRSQ+UwXELYde8iCTIcyQCms9IS3mlnX
         a+ysrRRTb9HVEjL+835o1jKVFUvlERzDHdM3ra8QuwUyKwCNjkTvnYkub+IutbFgZwes
         VUUw==
X-Forwarded-Encrypted: i=1; AJvYcCU8GNwui+maIGAFvwLBv6IfaGrDW1bCBPHah1jtW+nfTz7bwFqf2yrk+L7ojJIZzWfP3MW25fhAe24RJv0=@vger.kernel.org, AJvYcCUI9DdAh065RU/zTF23B1jFbK8Xhylc6XUyPPuL8dSg72hPnBBPbP0uuy/2BtG7u3Gh83m1rFCR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CvUMIfBEovub4jN9v1CFMReWHhxUN6O2PO5KtMI9LKLDxGg3
	Sytq3/lmKOraPxRIZLTd7WDJsOYaz2zeFOOJ7jSOBR/n1VKULR6Vh8lPYYWlqafZxhZ/Jb8s6J1
	FnPaOlS6Uni2o2Df5jxxGZpEHBYs=
X-Gm-Gg: ASbGnctQkrProJmEhmB/PqjmR/YRqGkzD1kP71qODFV3CWp8HXzxKABqMbYeBXtyxjR
	/kKFRxn2r8k+qQDR4W5N/qAIpiHMnrgJjUdFQbzPIObh20NJ/nb01oBN2TcpqrA8=
X-Google-Smtp-Source: AGHT+IFNfC7VTio97TeVkgyTvSTy+BO+RcT6EqwQ0DcsNR1C1LLW+kLKwGdg1NPQRWOzlRAEhjZPV7ex60OGekXEGLk=
X-Received: by 2002:a67:fdc3:0:b0:4ad:5940:36ae with SMTP id
 ada2fe7eead31-4af556c3a1bmr5751093137.8.1732872622267; Fri, 29 Nov 2024
 01:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115232718.209642-1-sashal@kernel.org> <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local> <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local> <Z0kJHvesUl6xJkS7@sashalap>
In-Reply-To: <Z0kJHvesUl6xJkS7@sashalap>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Fri, 29 Nov 2024 10:30:11 +0100
Message-ID: <CAL2Jzuxygf+kp0b9y5c+SY7xQEp7j24zNuKqaTAOUGHZrmWROw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
To: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com, kim.phillips@amd.com, 
	jmattson@google.com, babu.moger@amd.com, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com, 
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com, aik@amd.com, 
	vegard.nossum@oracle.com, daniel.sneddon@linux.intel.com, acdunlap@google.com, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"

[...]
> The stable kernel rules allow for "notable" performance fixes, and we
> already added it to 6.6. No objection to adding it to older kernels...
> Happy to do it after the current round of releases goes out.
Sacha,
Thanks for considering the backport of this patch, much appreciated.
This patch greatly impacts servers on production with AMD systems that
have lasted since 5.11, having it backported really improves systems
performance.
Since this patch, I can share that our database team is no longer
paged during the night, that's a real noticeable impact.

We all know how difficult it is to maintain kernels and support the
hard work you do on this.
It's also up to us, the users & industry, to give feedback and testing
around this type of story.
It could probably be interesting to have a presentation around this at
KernelRecipes ;)
Erwan,

