Return-Path: <stable+bounces-210795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBlCJpcjcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 406345BCE7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CD499ED370
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023F33EAF8;
	Wed, 21 Jan 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPXCABDa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B30ACF1
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014593; cv=none; b=jgmiB5gbBQRR5KeD41nr2PCaCPRiTfGWLU5rJZbEy1IMpfB1WDidS8h7sXU9KOn9gwP2gtG+Nr84LYeLvkMaGhtSUXur8uIKxVYuefFpuevsTvE5AvZfQZRhc+S2I7Ykiw2by0TwaVmVdKSu308FIGUtraxudXd3NlL+3AAZVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014593; c=relaxed/simple;
	bh=XnVzcCbVwpPIAXV3Db+FdhqwiVK0gozlpBoxcNHrWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+0iEtZuYxA+bnHGDv28Typ3Sf4o93PCzUmIq99Mb//VxQsh2Jbo4/xUPHLWc61YZ8SknoS+8mhp6mrSTdZ0NKYCH8x9/YTHlPyTH0Bp2ahLr3LqZ6hKRVTzQ4nkHMeDJhY3hJ956Ig2HjbvMp/MMgdXbamYdOMfaOfGHKs0M+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPXCABDa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1462573caso104695ad.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769014591; x=1769619391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiol+dqLjaDH26Yz1t3oEyuKo1Y9NL/hf5slckp3aSc=;
        b=fPXCABDaVusuyRZNpS0HM1eliDXcBCYEmlXWIGF+Xj06fFOCcKYnjuQO0+BJCF1pGU
         uLScFc/SgJfALWOp5kKZHo/DkEHpsLxcHOypk8gJw2h8rJccAP6JthFd5Z0Y6y3DIpVD
         W2n4ho+xHupTajg/7H+8iMOcbHclpUQYkUl9SqRRrvcIzIvjn7QwDB3WT5SHwMb06EBw
         kZzOk7wFB9igWpMhoPrDVSMSPwS91Xcz0S43t5uzJlU4mGQZniF22bexy4WzLuhV3P9K
         cG/DEZ5Cpd8vE1nJlPRb8kvQaioo/B5gzZjutVDbcHvRAWXFNJuujfRlvm6z+jiVsbnf
         GHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014591; x=1769619391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiol+dqLjaDH26Yz1t3oEyuKo1Y9NL/hf5slckp3aSc=;
        b=PtGMaOPjSDbC/Tc/e2SVW0d/h6QH5jQU7z9Au+BHuHXTXbLx0AqLC9mOMNnxt4l7mZ
         FSBiO848pa7TMKnxUlc+2qYCpqTIC44njU7H6lRxnA+nu9STLajvM0Loxw9u2/K6lErD
         GVzNlpUfeLRsfvFpDJDzopt+ZYWnb5iYcfWwELkdtyvpC6N/YZ519/dIilHS6OcnVRPJ
         M6nJthJhxutThbXE0qrpKcHiXAPpwIljpnZOXrDy2Y4YNS5s3XXUMS1h3TvAOcoofJMY
         FuLkyOP2cA6UHyS1qZvEZ68/8TCKr/1pvWX3xMEyTZ8jROxR6+8UznIFKlupOyoqPSp2
         5kZw==
X-Forwarded-Encrypted: i=1; AJvYcCUzyDRh4EfRNcNpm8YTnHKeUIZHK2T3RVN7tGXnrkrxtzabghMwgPWBPNaR4pHCRa4exUJuNNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPal//VMBqW+ACGJff9B3671bPM86C7uphV/2rOJXZ+b4CsrT
	j1rLX6L9Ax5qMwFVheEV9ub5A/nxiwlt31LCyiRBB/qqEN1lZcadt+Hpn3Spx85zkw==
X-Gm-Gg: AZuq6aIORprkdu62Xka6o0K8ViN0WcGm6dtHIvxsRtrSguZ53hRMOQq19q53BetzIK3
	fkBgedYM05zhkenJyCjjH0yCyrlhKfp6Yh92TVFsdVuxHsbCAaIVTYJkbEtnU2u02ZJMKfupIdg
	1Nv7BUTLEpLHe6FvKkCOQ0pmCf1u0Iw2yjQRy1tGsrDyoKUc5FSHgYl/fISEQ3IOXDvlP/EWqFF
	Q7FkNKYHfrtmuq0NcQ/aUIHRy+yCjPoxsIkpUacGtmCwd9nrEDR/vtHNvfuqTG0kg5yPymtKDFW
	2IzRjFOTYyOagvGIqQu6b1FdCheb690MNFDF825TuylYuUx1Y3IbmUjeccERAIc64Ed9ihVqNTV
	JZt2O8gT9FsuvN/T2X6S4kamSItOdKgYj52XnfdlY5eWfhePRLbmCMUlWacwqgSUhajgG79GciO
	ZfFJ2VfLc9xQ+7sF1Jj9zUCc1pcike2C+DGIsZ8Lx1nqLxb5c22hIRUkLZlmus
X-Received: by 2002:a17:902:f550:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2a7a23cd406mr2729355ad.3.1769014591091;
        Wed, 21 Jan 2026 08:56:31 -0800 (PST)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a718f79f40sm159182825ad.0.2026.01.21.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:56:30 -0800 (PST)
Date: Wed, 21 Jan 2026 16:56:25 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, Li Li <dualli@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF in binder_netlink_report()
Message-ID: <aXEFObeAwlzXprDC@google.com>
References: <20260121145005.120507-1-cmllamas@google.com>
 <aXDvlhDvCpzf62KH@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDvlhDvCpzf62KH@google.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210795-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 406345BCE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:24:06PM +0000, Alice Ryhl wrote:
> 
> Erm, this solution seems dangerous to me. You access t->to_proc and
> t->to_thread inside binder_netlink_report(), and if t has been freed,
> could the same apply to t->to_proc or t->to_thread?
> 
> After looking a bit more: I can see now that you do call
> 
> 	if (target_thread)
> 		binder_thread_dec_tmpref(target_thread);
> 	binder_proc_dec_tmpref(target_proc);
> 	if (target_node)
> 		binder_dec_node_tmpref(target_node);
> 
> after this ... so I guess it can't go wrong in this particular way.

Right, the access to the target is safe because of the tmprefs just like
the rest of the transaction().

> But I'm concerned that we will add fields in the future where this is
> not the case. For example, let's say that tomorrow I want to include
> t->buffer->clear_on_free in the printed data. If the transaction is
> freed, then t->buffer might also be freed.

You actually can't access t->buffer already, there are scenarios where
the t->buffer is released before calling binder_netlink_report().

...

There is really nothing dangeours added by this solution. The fragile
part you mention comes from passing 't' to binder_netlink_report() in
the first place. As opposed to some static struct that contains all the
necessary info without potential issues. This is already present.

The ideal solution would be to refactor binder_transaction() to have a
central place where everything gets populated instead of having separate
objects for 'binder_transaction', 'binder_transaction_log_entry' and
'binder_extended_error'. All of them keep duplicated info and we don't
need more of them.

However, this is a larger effort that would require extensive testing as
we might introduce new issues, etc. I'm not sure that we even want to go
there. This solves the problem at hand so let's just fix it and move on.

--
Carlos Llamas

