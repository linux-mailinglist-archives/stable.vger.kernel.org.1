Return-Path: <stable+bounces-3138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0217FD424
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DA41C20F6D
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6CB19BB9;
	Wed, 29 Nov 2023 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFNcX4uG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7BCE
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 02:31:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so1995090a12.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701253859; x=1701858659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lAncjJSOOjZiNADXqbSSNgxD1Kx8XP10IMElfbL+LY=;
        b=ZFNcX4uGTrHkx9lUD6XrMsLxcm8W3z9lB+Ccvn1ltunL5K4ug6/6/+jI5tcGfki0OH
         B3jjFc+UEBLf/ckf/LVhy3aw8v7OmmJb2bx9S6gAktEqnpvv++r+oF1zVN/VpULKrt0+
         NQo5aDqbfaDoREYjzquhSnBCxspOCKUXfzfwxO8UN9lMJAJehDSAWmL00XtJvSK7vTse
         +aRCnCRNqmSpGmXbhh1fwkM9cyeYsBq+mYUpuA6dtbgMvXb9OahOp1vRZ8WDFPP5abG1
         yDAU5DSa/OGJAdKogmBLfMoolLOGDbIdOHLZl4fIU0vMBBkDio3SqtuCHW7Y0Q3uozIE
         00Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701253859; x=1701858659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lAncjJSOOjZiNADXqbSSNgxD1Kx8XP10IMElfbL+LY=;
        b=myxb4Xgytg95rYmd/MoQP+canE7eXJACIWnI1EQlkMPdfdB0+B4NO95qU+HaTv0NYG
         bmj+tq3xPM084oMZAE93e1lHeQbd+SWLuGLRVJx7yXTOvcA+xTcdILisBzAbXnrzohUZ
         tSLAtfq1PFtiICJgMtAAzTHl9R3fvL1uz6edCjmUjtAN0/1kQ64IOVJd80zbBIcTxypb
         VpGAoI1ym/x2/JhrEVkvUuTkU1zQysaOq9nVqMG0OpQ4QRnU1ehGdbAmHqqb9yYEWiuq
         n9JIr5sxBtL/EDwJdwGPLOy7R1HhS96Km3p0V+nBGHoto+DAfuNPNPp81trtuT64m5uJ
         UCKA==
X-Gm-Message-State: AOJu0Yw9h1YQWVLfE0yTr8u0b/eYqOl6kgbeRADa64usuD6HvPuIJaWF
	d7XabhiXNyBst5eAl3ec0UU=
X-Google-Smtp-Source: AGHT+IGptUIWmZYcaDGodMJ/aJUrATc3/axoxHWWr7FC5K0fVtF61tB+rOJdv9N5WVOF8xPpsKYW6A==
X-Received: by 2002:a05:6402:220d:b0:54a:f8d9:8023 with SMTP id cq13-20020a056402220d00b0054af8d98023mr11645670edb.37.1701253859154;
        Wed, 29 Nov 2023 02:30:59 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b00548a57d4f7bsm7241144edt.36.2023.11.29.02.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:30:58 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1BE49BE2DE0; Wed, 29 Nov 2023 11:30:58 +0100 (CET)
Date: Wed, 29 Nov 2023 11:30:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Timothy Pearson <tpearson@raptorengineering.com>,
	regressions <regressions@lists.linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't clobber fr0/vs0 during fp|altivec
 register save
Message-ID: <ZWcS4uBOUefxZAQY@eldamar.lan>
References: <1105090647.48374193.1700351103830.JavaMail.zimbra@raptorengineeringinc.com>
 <42b9fdd7-2939-4ffc-8e18-4996948b19f7@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b9fdd7-2939-4ffc-8e18-4996948b19f7@kernel.dk>

Hi,

On Sun, Nov 19, 2023 at 06:14:50AM -0700, Jens Axboe wrote:
> On 11/18/23 4:45 PM, Timothy Pearson wrote:
> > During floating point and vector save to thread data fr0/vs0 are clobbered
> > by the FPSCR/VSCR store routine.  This leads to userspace register corruption
> > and application data corruption / crash under the following rare condition:
> > 
> >  * A userspace thread is executing with VSX/FP mode enabled
> >  * The userspace thread is making active use of fr0 and/or vs0
> >  * An IPI is taken in kernel mode, forcing the userspace thread to reschedule
> >  * The userspace thread is interrupted by the IPI before accessing data it
> >    previously stored in fr0/vs0
> >  * The thread being switched in by the IPI has a pending signal
> > 
> > If these exact criteria are met, then the following sequence happens:
> > 
> >  * The existing thread FP storage is still valid before the IPI, due to a
> >    prior call to save_fpu() or store_fp_state().  Note that the current
> >    fr0/vs0 registers have been clobbered, so the FP/VSX state in registers
> >    is now invalid pending a call to restore_fp()/restore_altivec().
> >  * IPI -- FP/VSX register state remains invalid
> >  * interrupt_exit_user_prepare_main() calls do_notify_resume(),
> >    due to the pending signal
> >  * do_notify_resume() eventually calls save_fpu() via giveup_fpu(), which
> >    merrily reads and saves the invalid FP/VSX state to thread local storage.
> >  * interrupt_exit_user_prepare_main() calls restore_math(), writing the invalid
> >    FP/VSX state back to registers.
> >  * Execution is released to userspace, and the application crashes or corrupts
> >    data.
> 
> What an epic bug hunt! Hats off to you for seeing it through and getting
> to the bottom of it. Particularly difficult as the commit that made it
> easier to trigger was in no way related to where the actual bug was.
> 
> I ran this on the vm I have access to, and it survived 2x500 iterations.
> Happy to call that good:
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>

Thanks to all involved!

Is this going to land soon in mainline so it can be picked as well for
the affected stable trees?

Regards,
Salvatore

