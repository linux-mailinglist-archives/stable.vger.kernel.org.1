Return-Path: <stable+bounces-154630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79EADE380
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB543A3D77
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC971E3769;
	Wed, 18 Jun 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9TQZHb5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24C45C14
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227345; cv=none; b=F69uQ/9nKoRxB5njGIaknBfUHV2CLMvIiO++uimQnIwOERTk4xIE+MEck2VfQ3x6J3cCfFb3TgKD6VZwQ4W3hrkNhVUgawV9L7fPRAEJeafIlKtCUeMl7pbjkzAm1mbXK1nd4+SZXKRxHypcpfW40NBETrqqdAAp9H6yG+LbjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227345; c=relaxed/simple;
	bh=Fkn5SytAaBa9O89r6Gpzy9dkjndpoma8OAYmtFP08mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcRKvvS5SO0kYifvw0J7nvV1CBuNiUFMmj/63QCD8QSXJXGjBou7jTK8pSHDDF0B8yvVsq3HmZjLIPngO0ZyCWcXuYfctbWncHd9C8alwSHSguAs3o+AuH6bClWc8YoMvKbzqk/+qfRMYzBaNVwXuErCbDETP6QEW5QG7rJxgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9TQZHb5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450dd065828so52694895e9.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750227341; x=1750832141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44LtWgsCEvdwzAmdCUR6hBV4NtMzuG+BweyDdLhiOeA=;
        b=F9TQZHb5ssQCcrMGw+EWfAtwXxS0SvwPDQKusZmZBxx3CrE12sPgiNqA2rwo9iX7VJ
         UQca6N513s6ABX/m6c8Pm65t/FDiafeDAHTZ38Ry4bMzwF4uW3Fpz2syACc7GSgiTSUk
         9g43bIsc1/vn4TBnNL6b8VkL+9eTDb4iQgMW8hGfn1Q22xt0BTe6i1mqMsfYvPmoQ0Av
         o58BjkpBHZ7wz680DrVIszT5OD3Y9tx//by7c6FJNQIe+wjoyq0zBDwVprmEt+8OwFQ0
         sGG6m0puAucqUmyC5hpIKPVSfyOFAvcDe9lbejcYeuaNzXUiWKRk3Df2ltEn6n2YrMQo
         gUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750227341; x=1750832141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44LtWgsCEvdwzAmdCUR6hBV4NtMzuG+BweyDdLhiOeA=;
        b=WBVEN+CzDxIVRUvKVkPUY5qqNVL3EaeW8PvqexbaE6t6I4iVnKnCChugzJWWxn+Lh4
         kdC41NBDnFkf1RgfrlABq06vqqiGwSv2p6+8rGb4d+vGEPqGbtdfn0iABHhqGZbiitNH
         xjfFlINAMn/atYmD6o1Ul1VwQVYZZhkQO4bTsHv4kSd7jA5sF+ihCCFEweQ0WK6J/vQf
         T0K3YHK8UQxPmwLlBoxDcUWxPHgDh3TdeUxEaeP2CV29Vf3b2FZ9MdSko3TUT+gmHF9E
         zWS4zswR+96sPyZd7qBLaW6FuI9YN3CAEDrP+5pn8loBDOv+7Np14isWVJwcz533FzVn
         k9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSCmGD3XGyHXvTt1FlOv5sgtECRPP+GRbqNKpBEMocx0NPDCHKichm5faYjyvfkwvskdiXSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKY0Sv4WrkfG5oZn6l4wL3lepGGwjHCDyL71/z8ByzcJ6tcHHk
	/p12Z//pGj7lolCfW8elDfbrlBi8vLVlaZnUzrSTRN29UMDoM+ap5Yfw
X-Gm-Gg: ASbGncsBu+MLuGcpZsnTsoUkV+7x6eg+kynovL9snY9GdsKa9RoII8qf3TObKMLa9dM
	i8BwcQynRuJpOCwqXlQYFciUtfHWWCoZ3TxAaOwldtD4vm7pz5sSwqsyXDMjAghtGYOwAXr+mMA
	u+pkWv5VcYjL/uS+FXdkBTKHpNym6WAbTXwefO1es5JCZHWoxdZ22IwllJ33IayYH4fhgMYSUVz
	6tHRdvfikIEuOkj7nkgVMrW7xfC43BInl6ofZPaGXUfWah33ZLhe1f2zoUiYbYFP7gDL+AZwpvs
	7mWOAQBsIHr6b1M5W1AoCn6zNZanU/ccAY1VxkL3yHvWbApXcRFrJKOpRYDSZWf2IpqhwhE73t3
	qGLkxsiJyHzZa8u1LH/E=
X-Google-Smtp-Source: AGHT+IETeO3GP5PhH8TS51TNiHmwO1qHAhS7dOH6TFNWOsIo/orXR/ywZa5L6vx510mDEDxkawkEMA==
X-Received: by 2002:a05:600c:3ba2:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4533ca79d19mr162483775e9.3.1750227341402;
        Tue, 17 Jun 2025 23:15:41 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25f207sm195176415e9.35.2025.06.17.23.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 23:15:40 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 905ABBE2DE0; Wed, 18 Jun 2025 08:15:39 +0200 (CEST)
Date: Wed, 18 Jun 2025 08:15:39 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	holger@applied-asynchrony.com, Ben Hutchings <benh@debian.org>
Subject: Re: [RFC PATCH 5.10 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <aFJZixX_Y097I1H8@eldamar.lan>
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
 <20250610-its-5-10-v1-16-64f0ae98c98d@linux.intel.com>
 <2025061751-wrongdoer-rebuttal-b789@gregkh>
 <jadhobrooc3h7vb5lwi635jf6r4lb6o44sudv5k65eqngwa2qj@lo2w276w2lcz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jadhobrooc3h7vb5lwi635jf6r4lb6o44sudv5k65eqngwa2qj@lo2w276w2lcz>

Hi Pawan,

On Tue, Jun 17, 2025 at 12:11:54PM -0700, Pawan Gupta wrote:
> On Tue, Jun 17, 2025 at 03:44:26PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 10, 2025 at 12:46:10PM -0700, Pawan Gupta wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.
> > > 
> > > FineIBT-paranoid was using the retpoline bytes for the paranoid check,
> > > disabling retpolines, because all parts that have IBT also have eIBRS
> > > and thus don't need no stinking retpolines.
> > > 
> > > Except... ITS needs the retpolines for indirect calls must not be in
> > > the first half of a cacheline :-/
> > > 
> > > So what was the paranoid call sequence:
> > > 
> > >   <fineibt_paranoid_start>:
> > >    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> > >    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> > >    a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
> > >    e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
> > >   10:   41 ff d3                call   *%r11
> > >   13:   90                      nop
> > > 
> > > Now becomes:
> > > 
> > >   <fineibt_paranoid_start>:
> > >    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> > >    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> > >    a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
> > >    e:   2e e8 XX XX XX XX	cs call __x86_indirect_paranoid_thunk_r11
> > > 
> > >   Where the paranoid_thunk looks like:
> > > 
> > >    1d:  <ea>                    (bad)
> > >    __x86_indirect_paranoid_thunk_r11:
> > >    1e:  75 fd                   jne 1d
> > >    __x86_indirect_its_thunk_r11:
> > >    20:  41 ff eb                jmp *%r11
> > >    23:  cc                      int3
> > > 
> > > [ dhansen: remove initialization to false ]
> > > 
> > > [ pawan: move the its_static_thunk() definition to alternative.c. This is
> > > 	 done to avoid a build failure due to circular dependency between
> > > 	 kernel.h(asm-generic/bug.h) and asm/alternative.h which is neeed
> > > 	 for WARN_ONCE(). ]
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > > [ Just a portion of the original commit, in order to fix a build issue
> > >   in stable kernels due to backports ]
> > > Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> > > Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > 
> > Note, I did not sign off on the backports here, are you sure you want to
> > do it this way?  :)
> 
> Sorry, your sign-off got added because I cherry-picked the commits from
> 5.15. Sending v2 with the sign-off removed.
> 
> > Also, I need someone to actually test this series before we can take
> > them...
> 
> I have tested that ITS thunks are aligned properly.
> 
> Salvatore, since Debian is the main target for this backport, it will be
> great if you could give this backport a try.

Yes we need to do that since some requests came from Debian users in
fact, I'm looping in Ben Hutchings to see if he has capacity to test
the backports.

Regards,
Salvatore

