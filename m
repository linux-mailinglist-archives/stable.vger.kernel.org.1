Return-Path: <stable+bounces-249555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jHRiMa1JDGrjdQUAu9opvQ
	(envelope-from <stable+bounces-249555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:29:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF257D9D5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF1523272858
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC33F4DC3;
	Tue, 19 May 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7HnchGq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D83F1AC7
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188141; cv=none; b=LabpVWCNGl48diCP/vmUqs/3Ec6rbrMcq2WkJMLxr42R4LLH587rkB3MeVwdKTZfyp0q2SOscZTS+b8IBNC0ZJZUa1G0oiztKS02MgQa5bAc4SmElgSDoKNTjDwQRQBQCmBzTAEc5JO3LofLsCsGJuxq+b+jM1wu1UcReRpyHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188141; c=relaxed/simple;
	bh=qTIuYtfZpfc/KhP0my2UUsb0x1PEx+M0VM5oHniYnnU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4XMGhLn78zllKKZj+49G2eYEYhOxRY8zgcDcDqmONV+4na2Kj2kNwzPIvdC9iiNzvMhrhXfJWZEFjibouD7HDDc002SVuwLsJyv1H+PHnqgKxECj8gOfv0NWjGxhk5OwTxPNQCBRFjNCg0wv+Zy6UZ0OF9VUI9e1XycOdaSN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7HnchGq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so16166165e9.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188136; x=1779792936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXidpbPy4AblXKAWP+/SRSo2g1EEOiSrktNFCukfheQ=;
        b=C7HnchGqUGLnN3GkhnLYI4kCRbXWdcCq5etW6iz1rzND8DMyKX70wTHMEPVAm0mwH7
         MW/S/BL6VWGbD8E/+BDmjkt1cGXEVJE6HPTw5XDRKzwH36P6omnMgCFTh9T5cOoNgZmo
         HSPxlIKOWf0C4swGpYyjCld0zyMH/2Eiz8lyZf4buB96c5sq2fU0RNKE8Z29n/iX9po1
         j2Fe904BYKakl8IsoE/x0rlOotUX7CJbs1OU2+NaS2bQLEfCqy1NlOM82BYk7I9gaDNw
         EBXdXR9m6mldBVWjqm+yfAE6ac/GrUbf8gqrehAUlCmn7628WdIWnd9Xhr7W5QvwJvMJ
         1qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188136; x=1779792936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXidpbPy4AblXKAWP+/SRSo2g1EEOiSrktNFCukfheQ=;
        b=c3DqukzD7scyypz9rCyNiK1W0gZouY9NLr0lM+4DkbW9MXVeuWowcXMDmy5VM6wJWY
         9j6exZQReDPEA861Vhrgh83S3qJE8O6Wzp9lJhFlV3gX4h3ZZYqVe3K7VUvj2nA+rSPu
         Y4l8znx8I0HVMt4XA0aBK1O9Qtbh8OmGULBxGkItj/mPX1FIRQX5IGFAVapJKNA2tOvn
         bi89A5R0H2hL9HZJlufCAgl+pszpSuHb4G7AnXhIJB40XsYjg16WMokeUVBdxVohxW8t
         jy32fywMxg9BVzs1R+Y+erh35BT7KZSXIMjOooxKY9M529gIWsMXZdT+Uca7voXANF7c
         /BMg==
X-Forwarded-Encrypted: i=1; AFNElJ+3WaqHwkHhIpcFHIS18bY60TDSo3vQgMvB2irzHSZzIWn7YUGUWeRTKhKKpYpSC4LcLar/e8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbwh3PHIFHEt4+RpJHisTPVzR8+btstR+uTj0sQ0O/fHuOcDW+
	lh9GiG6vprb4WHTsuYjh4xYWvCWVDH3+REa7hY/YuODRKRNMcYSdTAE2
X-Gm-Gg: Acq92OHBzFLgYMiHa27VGFXXuD6IhnrSbznisice4mBZ1b+P82VVIkInh3k/GVHVuTI
	4OMPf07O44kHkGYegb8Qriv8HGATYOJYQREEbHykxSN2YI+VpYgnHbPD+EQ0dakIWFYopD40tdP
	aTOmC4feOolvy7DqWajr/LjmoqlWqrIVqT/7wzshXqb6JmZKA6jav57BJll3D0XfraUU7rI3H4e
	XJS6u9nY0kVXlXfT0sZIqF52eou0L2wTs1BNl9CfLqXTXwAsdygfXIG7hw4HEIh2VN+uOZ6vkjZ
	AxgnnvMQF1xrwsBIDLZPE3DuX+EuVxmc2bmoMH2VaHrX0uQpbEREtDihUI6QlKnoaG7BL1Xjc1f
	5wxRWL9hRzv3Pp6hfxVyCzP2hvBMIs3K9nHMsT1wVyD44/4INsOCF+/jyPuhTNUuFZ+CRRVIkfM
	7zdpqXsvkRkT4+s3u1
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-48fe6de1dd2mr182584715e9.19.1779188136017;
        Tue, 19 May 2026 03:55:36 -0700 (PDT)
Received: from krava ([2a00:102a:500e:4bd5:e407:4c9c:ff70:3933])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm303057615e9.12.2026.05.19.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:55:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 May 2026 12:55:33 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Kuchmenko <capyenglishlite@gmail.com>,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix race in __modify_ftrace_direct() between
 tmp_ops registration and direct_functions update
Message-ID: <agxBpRc9YIyPVwCO@krava>
References: <20260517110155.21706-1-capyenglishlite@gmail.com>
 <20260518121906.4eebad77@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518121906.4eebad77@gandalf.local.home>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249555-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Queue-Id: 4ABF257D9D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 12:19:06PM -0400, Steven Rostedt wrote:
> On Sun, 17 May 2026 14:01:53 +0300
> Andrii Kuchmenko <capyenglishlite@gmail.com> wrote:
> 
> > In __modify_ftrace_direct(), register_ftrace_function_nolock() makes
> > tmp_ops visible in ftrace_ops_list before entry->direct is updated
> > under ftrace_lock. During this window any CPU entering the traced
> > function calls call_direct_funcs(), reads the old address from
> > direct_functions via RCU, and jumps to it via
> > arch_ftrace_set_direct_caller(). If the caller freed or invalidated
> > the old trampoline before calling modify_ftrace_direct(), this is a
> > use-after-free in executable code context.
> > 
> > The race window:
> > 
> >   CPU 0 (__modify_ftrace_direct)       CPU 1 (executing traced func)
> >   ──────────────────────────────       ──────────────────────────────
> >   register_ftrace_function_nolock()
> >     -> tmp_ops visible in ops_list  
> >                                         call_direct_funcs()
> >                                           ftrace_find_rec_direct() -> old_addr
> >                                           arch_ftrace_set_direct_caller(old_addr)
> >                                           jump to old_addr  <- UAF if freed
> 
> You do not state where old_addr is freed.
> 
> >   mutex_lock(&ftrace_lock)
> >   entry->direct = addr   <- too late
> >   mutex_unlock(&ftrace_lock)
> > 
> > Fix: update entry->direct under ftrace_lock BEFORE registering tmp_ops.
> > Any CPU that observes tmp_ops in ftrace_ops_list after this point will
> > already see the new address when it calls ftrace_find_rec_direct().
> > Add smp_wmb() between the store and the registration to ensure the
> > write is visible on weakly-ordered architectures before tmp_ops
> > becomes observable via ftrace_ops_list.
> > 
> > On error from register_ftrace_function_nolock(), restore entry->direct
> > to old_addr since tmp_ops never became visible to other CPUs.
> 
> The above statement is incorrect. The tmp_ops hash entries are also
> *shared* with the ops that is being updated. That is, by changing the entry->direct, you 
> 
> > 
> > This affects all callers of __modify_ftrace_direct(), including:
> >   - modify_ftrace_direct() used by kernel modules and live patching
> >   - modify_ftrace_direct_nolock() used by BPF trampolines
> >     (kernel/bpf/trampoline.c) reachable with CAP_BPF + CAP_PERFMON
> > 
> > Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 35 +++++++++++++++++++++++++----------
> >  1 file changed, 25 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5950,6 +5950,7 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	struct ftrace_func_entry *entry;
> >  	struct ftrace_ops tmp_ops;
> > +	unsigned long old_addr;
> >  	int err;
> >  
> >  	lockdep_assert_held(&direct_mutex);
> > @@ -5960,22 +5961,36 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	if (!entry)
> >  		return -ENODEV;
> >  
> > -	/*
> > -	 * tmp_ops is registered into ftrace_ops_list here, making it
> > -	 * visible to all CPUs executing the traced function. However,
> > -	 * entry->direct is not updated until after this call returns,
> > -	 * leaving a window where CPUs read the stale (possibly freed)
> > -	 * direct call address via ftrace_find_rec_direct().
> > -	 */
> 
> Are you posting patches on top of your own patches that are not public?

hi,

right, the original email states 5.15 is affected, but I dont see
__modify_ftrace_direct in stable version v5.15.207 .. what kernel
version is the patch for?

> 
> > -	err = register_ftrace_function_nolock(&tmp_ops);
> > -	if (err)
> > -		return err;
> > -
> > +	/* Save old address in case we need to roll back on error. */
> > +	old_addr = entry->direct;
> > +
> > +	/*
> > +	 * Update entry->direct BEFORE registering tmp_ops into
> > +	 * ftrace_ops_list. This closes the race window where a CPU
> > +	 * executing the traced function could read the old (potentially
> > +	 * freed) direct call address between tmp_ops becoming visible
> > +	 * and entry->direct being updated.
> > +	 *
> > +	 * Any CPU that observes tmp_ops in ftrace_ops_list after the
> > +	 * smp_wmb() below is guaranteed to see the new address when
> > +	 * it calls ftrace_find_rec_direct().
> > +	 */
> >  	mutex_lock(&ftrace_lock);
> >  	entry->direct = addr;
> >  	mutex_unlock(&ftrace_lock);
> >  
> > +	/*
> > +	 * Ensure entry->direct store is ordered before tmp_ops
> > +	 * becomes visible via ftrace_ops_list on weakly-ordered archs.
> > +	 */
> > +	smp_wmb();
> 
> You do realize that register_ftrace_function_nolock() is itself a full
> memory barrier? It's doing code modification which requires lots of
> barriers to work.
> 
> Still, the only bug I see that is possible is that the caller may need to
> do some synchronize RCU calls before freeing an old trampoline.
> 
> Can you show a path that doesn't do that?

+1 

jirka

