Return-Path: <stable+bounces-59285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949993108B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BCC282724
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04213C827;
	Mon, 15 Jul 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RcF7yDKe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA21836D6
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033113; cv=none; b=PUjHftU374FR5LNtAPnC4XZzbVOD+p5qNYpIOR50Mvks/dwUvDGt1MyUisWNU+4YI6NBaBYLwd8KQrCn07Vm6yHzvvEJSZtCVuVvYPLUbyGOECF97nuhwbMN78Hfk9dtQiHd3EB5tjFCpFH79UPWWmeBKZwA0ckRLvp6Q1IjH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033113; c=relaxed/simple;
	bh=KbdlWQKJn0hza2m6K2BTUfffnTnvoHZmFO0gSi7vJwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiX+4z0/5i0bY46wOP/WbwKDzLES1dzoyCTKI4TGsIKIy1WN3NJY1mx/dY47rOp3atRvmS4+U239t1TthlSZ8WNP54iH0lSFnTNiUgXDAHmZB5QKbiPI/iIVo2NJeNMAuXRFGMsANLEzd4dBvUNmUe9p4uDk7Uf3kdF72rgXLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RcF7yDKe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266eae16b0so3194185e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721033110; x=1721637910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPt43vWv7W7uWoCMBzaMsxBX+ZmRLoqnMa3kAMiQQGg=;
        b=RcF7yDKer3QecybgNFRAoXitisxR93dnEqr03XAm9ERhXF+nkF+Dehg4hTmVXPqwLc
         ZhLMjFyWfSlG1r+CSIhM+gZO6gcoyU31fsAg9lBWCUObW/E6IRxV7+JiMZjK7WGurxUg
         xVeT5JMD6d/bylHVnPeS1X/jcHkVlgk0f1HU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033110; x=1721637910;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPt43vWv7W7uWoCMBzaMsxBX+ZmRLoqnMa3kAMiQQGg=;
        b=mEM+NTeUPE8YIRSntpy9xBLpntOXLLtuIJ2janKpIhU0GPVj91PGHkX9UQt6436cjB
         E4nxw7D/l3bO1cVqZlEl/ZVKjn7mCLNXdZxzANoARhQal0tMQ8U0CIyKjNNBuL0VJpZG
         24VJBQ1ifXKhZZSHig7mC4HdFWYu0AkIMBKXkp61QprIb5aBeHgcfN5PbzwXYyjejayS
         A+e09KOFp+iw7sgPWHAcAyLfg+5ASuY8evQYoPLIKFe+1kFVG7zpe1ijjWDUJUmQIQ/u
         wSVxh+inAcAPGH7S8sBQllpRQnzP/u4ENshBfoHKuLFDzhwZqRoT4fkfLNIS8sNMg0K8
         DVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDlKlrDsbPq6zq/focNIRrI63JOhrqOBg1lIN45z0AsJ12NUzL1SGbvHl/xDBKwgjaTT9oDp8zVLegsYjoSc62gkNQ0Ac3
X-Gm-Message-State: AOJu0YygepQywrvgKSnj3ot4kAY0ehXhx4HZ2HUIrH2bUL/+JOvh2n8w
	Ey9bp8Rx0OP9PCCOkQU6DC30U8HFR8oUk+VBUI+TOB9tMh4RuiM1o5RB9z/uUcw=
X-Google-Smtp-Source: AGHT+IHkDheiQWPRAvAOHQTkNQHOAUKicTVB0J2JBhxVC1tcwLKXg6dTru289RnVzPDELy4A5wdRbw==
X-Received: by 2002:a05:6000:2a4:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-367f05439c1mr7021710f8f.0.1721033110619;
        Mon, 15 Jul 2024 01:45:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbd2sm5664721f8f.49.2024.07.15.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:45:10 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:45:08 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>, stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] bcachefs: no console_lock in bch2_print_string_as_lines
Message-ID: <ZpThlAGUsPXZArvk@phenom.ffwll.local>
Mail-Followup-To: John Ogness <john.ogness@linutronix.de>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>, stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240710093120.732208-2-daniel.vetter@ffwll.ch>
 <20240710130335.765885-1-daniel.vetter@ffwll.ch>
 <87jzhtcp26.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzhtcp26.fsf@jogness.linutronix.de>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 10, 2024 at 04:19:53PM +0206, John Ogness wrote:
> On 2024-07-10, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > console_lock is the outermost subsystem lock for a lot of subsystems,
> > which means get/put_user must nest within. Which means it cannot be
> > acquired somewhere deeply nested in other locks, and most definitely
> > not while holding fs locks potentially needed to resolve faults.
> >
> > console_trylock is the best we can do here. But John pointed out on a
> > previous version that this is futile:
> >
> > "Using the console lock here at all is wrong. The console lock does not
> > prevent other CPUs from calling printk() and inserting lines in between.
> >
> > "There is no way to guarantee a contiguous ringbuffer block using
> > multiple printk() calls.
> >
> > "The console_lock usage should be removed."
> >
> > https://lore.kernel.org/lkml/87frsh33xp.fsf@jogness.linutronix.de/
> >
> > Do that.
> 
> Note that there is more of this incorrect usage of console lock in:
> 
> fs/bcachefs/debug.c:bch2_btree_verify_replica()
> 
> fs/bcachefs/bset.c:bch2_dump_btree_node()
> 
> from commit 1c6fdbd8f246("bcachefs: Initial commit")
> 
> ... and its parent bcache:
> 
> drivers/md/bcache/debug.c:bch_btree_verify()
> 
> drivers/md/bcache/bset.c:bch_dump_bucket()
> 
> from commit cafe56359144("bcache: A block layer cache")
> 
> These should also be removed. Although Kent should verify that the
> console lock is not providing some sort of necessary side-effect
> synchronization.

I'll take a look, at least some of them seem doable to audit without deep
bcachefs understanding. Thanks for pointing them out, I should have looked
a bit more at git grep ...
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

