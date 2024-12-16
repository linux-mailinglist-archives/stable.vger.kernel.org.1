Return-Path: <stable+bounces-104333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888239F301C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827257A2266
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6A204578;
	Mon, 16 Dec 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCYzkpQl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3520012C
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350979; cv=none; b=Zj1FzlrOL0fo/YmcKOX10FaCH7XHkjmELblhkPkWkFZQMgNE9xzuFk1HqVtUbtB5kv3DKcHjVDXr4/sLPSRTm8J7bB8BaE+NVKlcNKcGGxNi5uXaPxqKVqMmgMMD8Y+GIiETrPmoQIgCjHESWctlrsx5T4r49Ve0x+UXxonqVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350979; c=relaxed/simple;
	bh=Wk4sRAM0D5c8ISeWzFGoKaFTDgJVmKQ79ETQpL6OEUU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sldUYOfaUyfiT90XOAvJ3NLgAXZToijSEz8hM98hl9nmKdsuWS+Mc7EKtKq065WgLWnAbgxAdsRc6RXYnSTTlr1q8b3zqIIAo8sl003pU+6drIA6+L2DhHzpSBZScm32UMRkdeKbSfNYvx3843XYkaqadhwOidNHb2fDDlOLU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCYzkpQl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436281c8a38so25543435e9.3
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734350976; x=1734955776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nidQfNWWDTNBNgkOIqULFuUrChYN+bSrZ/WxfTlEpw=;
        b=jCYzkpQlq78+V/4vjmpQSwxQWeJjXuOOkU4hP28vopdbVLcLjD/DRDW/hpfc0rmOJE
         Zib4Mt6TNKast3FIcMMsxVAKLbvoje8ZeSboGm0TOhiJhUgLKSTaf+JWyHy4khDeOiJ7
         bFguEtRA2yvmgXwJeTSObDVioIt7WlfJVJgg9wpkNRnpOe6DKT3Y/9AC7O26zII1Dud/
         Itw9RcajUaJYtfXGSijEtXzYXfD/hc+0zk5AvCwvK3Y9wLbJVuyrYaxXsAHJBZEd+qNI
         T4Kjw9cFk2nSvQmLA90brtqMkOZGlEel2jZoSGodaXZQ2ioAuIKx1m9o23aRD/1K4+x1
         Ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734350976; x=1734955776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nidQfNWWDTNBNgkOIqULFuUrChYN+bSrZ/WxfTlEpw=;
        b=JQJoMNHvTXThYoh51A/uWR8ASHJD1jUBnojhGB2vpF44ptLtLsksld+74z0yiJj9g0
         gl6+o+JoB8k/fKW1c6CJAB1H5tcvjQ8RBjTzzGSYzGqHlzMr/nd5qf3GJqmn2cxbgUWI
         aPE8ky0G7QaWbd6JNv+Rh5C3DePxQVsIwx7fGwDFRe43DGgcD7954LkEuaafvwOkaIa0
         mQP8gONOo4n70ha54hiSa8DhKjJv4qmVHIVKj77jbizF5Hw6HGKyhMYnKurWo03/7dFt
         wQ0R63IWbnHwgxWZOgTGgz9qg2jiOZFZuC8WHrhdV3xqldnxvv0dDbAPOiBhsHEkpfTO
         5BKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe/H33N6/O6ykKDN1e9LP+koD2IeBCtlQ+gxzfHNeC4jhl2wFRXYig/Ef4K2ZE5AKUzVzDyCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgK5wKIAQArUIkxXsu5iyF5mU/6xhhiMd+7GXvWxP+xXx9aIYZ
	wm0CNpnNP47mSJVcOsmq5SiKV/Kui/RVQAB2Z3w0yaHLrAVMr7Cm
X-Gm-Gg: ASbGncuIRuJuAcKTN2vWzFBx88PCVBB42LWdRtHAbKKb2gS51ggbI9lXv6LLWY5j441
	4yMb941Gh9LkH5KCUxhcOWj3Za8v018iN5WbNu0yiDbiA6eFZ8aHuIHKUh1qDy2MXKjFXQ+nKJe
	cRA3pghiUi+K/bn0WXlPQTT+WWN4nGVHsVXCtsa79Ab/6R2kxswpvY9Q9KO2U2jsgWGjjSMT8D8
	5zqrktgGy86in8FeKl3g/M5uK0k2oJV3qp32WSlSmXpTskAsQYlERRRMkGRDdNeEwvE1xQ+iSny
	AlUbZMk+0guFo8hfPPNRRAtOlp393g==
X-Google-Smtp-Source: AGHT+IFaumpm2Yp2dMgJPg2MJwI5txAd67hk6f85NhhZwBtDrRsuK6yELE2L2ll3JJpvS/VruXd8cA==
X-Received: by 2002:a05:600c:511c:b0:431:93dd:8e77 with SMTP id 5b1f17b1804b1-4362aab0deamr122971135e9.31.1734350975740;
        Mon, 16 Dec 2024 04:09:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec87bc3sm127034385e9.1.2024.12.16.04.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:09:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 13:09:34 +0100
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] bpf,perf: Fix invalid prog_array access
 in" failed to apply to 5.15-stable tree
Message-ID: <Z2AYfrXAubWIJm9q@krava>
References: <2024121506-pancreas-mosaic-0ae0@gregkh>
 <Z1_1YKhjE1FSBAlO@krava>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1_1YKhjE1FSBAlO@krava>

On Mon, Dec 16, 2024 at 10:39:46AM +0100, Jiri Olsa wrote:
> On Sun, Dec 15, 2024 at 10:02:07AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> hi,
> there's conflict because 5.15.y is not getting [1] fix (because 5.15.y does not have [2]),
> I'll send new backport

after digging deeper I don't think we need this fix on 5.15, because we don't
have [1] in 5.15, which allows to inherit tracing programs, in this hunk:

	 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
	-               if (overflow_handler == bpf_overflow_handler) {
	+               if (parent_event->prog) {
				struct bpf_prog *prog = parent_event->prog;

				bpf_prog_inc(prog);
				event->prog = prog;

before this fix (5.15) we allow it only for perf_event programs, which is safe,
I'll check and send separate upstream fix to handle attr.inherit for tracing
programs

thanks,
jirka


[1] f11f10bfa1ca perf/bpf: Call BPF handler directly, not through overflow machinery


> 
> jirka
> 
> 
> [1] ef1b808e3b7c bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
> [2] 8c7dcb84e3b7 bpf: implement sleepable uprobes by chaining gps
> 
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121506-pancreas-mosaic-0ae0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd Mon Sep 17 00:00:00 2001
> > From: Jiri Olsa <jolsa@kernel.org>
> > Date: Sun, 8 Dec 2024 15:25:07 +0100
> > Subject: [PATCH] bpf,perf: Fix invalid prog_array access in
> >  perf_event_detach_bpf_prog
> > 
> > Syzbot reported [1] crash that happens for following tracing scenario:
> > 
> >   - create tracepoint perf event with attr.inherit=1, attach it to the
> >     process and set bpf program to it
> >   - attached process forks -> chid creates inherited event
> > 
> >     the new child event shares the parent's bpf program and tp_event
> >     (hence prog_array) which is global for tracepoint
> > 
> >   - exit both process and its child -> release both events
> >   - first perf_event_detach_bpf_prog call will release tp_event->prog_array
> >     and second perf_event_detach_bpf_prog will crash, because
> >     tp_event->prog_array is NULL
> > 
> > The fix makes sure the perf_event_detach_bpf_prog checks prog_array
> > is valid before it tries to remove the bpf program from it.
> > 
> > [1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad
> > 
> > Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")
> > Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Link: https://lore.kernel.org/bpf/20241208142507.1207698-1-jolsa@kernel.org
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a403b05a7091..1b8db5aee9d3 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2250,6 +2250,9 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >  		goto unlock;
> >  
> >  	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> > +	if (!old_array)
> > +		goto put;
> > +
> >  	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> >  	if (ret < 0) {
> >  		bpf_prog_array_delete_safe(old_array, event->prog);
> > @@ -2258,6 +2261,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >  		bpf_prog_array_free_sleepable(old_array);
> >  	}
> >  
> > +put:
> >  	/*
> >  	 * It could be that the bpf_prog is not sleepable (and will be freed
> >  	 * via normal RCU), but is called from a point that supports sleepable
> > 

