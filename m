Return-Path: <stable+bounces-211288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFC3NCdjcmnfjQAAu9opvQ
	(envelope-from <stable+bounces-211288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:49:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC76BA95
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 817F13003EFD
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C426E6E4;
	Thu, 22 Jan 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZZgzra2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9582E764C
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104160; cv=none; b=qkAbcV7mlt+QZ1mIKWd5Qyt5tPsFBXo7wXla0Yz5EUnUw0mcROuHhIOmuNTcmyTtzSV4AkHZCLtQw5yGCwGrex3pTsxQXj7XHK3sqC3Z29+0z19wg8EiSa854zksUXWu1MHqEhsUnqqAuW3DDL2Bnt4Bsax/4GFnz2/74Jsn2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104160; c=relaxed/simple;
	bh=wTsjPAguFxK44aeHyC0et/kZNTjTEFQuWhSCYOzsKNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjlawSoYUdI0W4RkZdkrjjdkIROKDqJIhgYAsHMLkKPM+IRl+qBTTNMj8XK4fUEPRnrBM5aEaOYVWHAFT4MZKo2QmIdv1ZH3l3H/LoAoJ99kMCdxtul82r+KmP7sDnMYFroOlkUIW2IbX0iLkeVQmjjew9GqtqoyMeJyLTEVv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZZgzra2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a35ae38bdfso655ad.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769104139; x=1769708939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/5lkZw7jlqAQByX7Ibn/d2+GVrr92pIkdaecAXndWg=;
        b=2ZZgzra2DdXiiVr72UuJBgrdtlFVCAhEOBizFW6oFzs8tqx1g4N0KsrxpksTLsTIAR
         5M18yLnu4VW1iQ7DIfdg0nVapbXP3cakiUkozS0r9/heDDaPWjgCk3XbJ6/p6xmkErik
         F0pcgSFNcI/dJhqZMGeepZ0Uo5+GcGGTALyQ1vtsC/adCPKYpF3Q3H6+AAXBDKtADNMa
         nAVpBqqyr56sRgnZgawsDfzgaZyF7fW4Uubh+LcY1+2sT5+fBNDVkQxJrCy7jvh/D9Wt
         igwosxG49bKHcQpQCik+0t+DIu0Z5IboOfIxmAUx+053YiFruymOvJt7DGSe7MMmoUUe
         ycQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104139; x=1769708939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/5lkZw7jlqAQByX7Ibn/d2+GVrr92pIkdaecAXndWg=;
        b=YhBbAUC9K51DfHVJfQZnF7VynUkvBB2iQQCueVVtfgDCPK1F0+En2CISomiTQMagJZ
         liqXxxO8Z2pElsDpZWpeNBWHrPCX+ja/oh/uzFxfvMjl+AovuAU9sLPFWmqNteGqnu9h
         EiCWONIQ5q1PKp5wPoPPs3Kvm8qVIztcQOAgxGE2SjDVk0fErLVjnNWG6GA06W08OjDL
         +aOs1V05HHeOEitlcSkQ2SBr/zUzl3QB3bAI98clta8pLLaBB8PT0HxfAYXhpCXWfG3i
         oH6HnLbjiwXGlh/aNrAQ27UQRJJbs7JdUaRbxJZrZGlf5pJp2uHSqPiLDYRDfKFOKIZU
         6FJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1DG/GA1naT7+Fi427cFUt3CbKg60HbnO6L0AdgRe1hT8mT70MQV09earkNo1NcSHywsYj53A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwj78LYKkL1UOGyKnwa1O9QAEfqxkf6iOMXvrRrbiC0QVS7Gm
	30AcVSpQW0KQEstpuJwzJXqDUc7+vWyHXu6Z2KPtFPSZr6/9tcf8JPZ+z7Dj5FYBnQ==
X-Gm-Gg: AZuq6aJ93o39XSu2hBVu+UUJShpbadI8CImM5nOxMa07/vOWnAT9S7oIMCeGEoQJCwA
	YGK7yIuOaSH+VOjvs7/htHh/OYQxNVvv5tPmOBX+tO8dkB/Bm6EMbOuSLi7rqQdauN1xWIuedxE
	oP0IApILHsgOAUYS0oiBC6fi3ba4YFMfyDCnzuHqWimkCccAgTJ8bxmtoe4FcrS6gmrHWwRDIde
	rmaao95tjeNKotwC9IzsQtvBhWRiR4Cl5TRNtssvlo5oxT0/Mjoow4vJmH2/kmD4E6RzGJIdonh
	6IVoD5k+E8TUZVZx+R2RLhSdUC8cEKo5W5k66gXhJ2ZDIXXU7r5XRXdjzJyRWiEyHXAwUm5j6xy
	fmOTzw+rU3G9ClybF8is1qhSVzXmHAqpwYNNilOxEOUrCCdQoqyAKq+A6JMOsuUYyeDmnp80OJ0
	bw/2mVc2qD/o8VKBrFlAlFfrw8F+j1mGuymXv9vcc/holEk2K4ew==
X-Received: by 2002:a17:903:32d1:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2a7d4178102mr3380815ad.6.1769104139026;
        Thu, 22 Jan 2026 09:48:59 -0800 (PST)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbb7fsm190952515ad.64.2026.01.22.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:48:58 -0800 (PST)
Date: Thu, 22 Jan 2026 17:48:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, Li Li <dualli@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF in binder_netlink_report()
Message-ID: <aXJjBRbZw3xkIvhz@google.com>
References: <20260121145005.120507-1-cmllamas@google.com>
 <aXDvlhDvCpzf62KH@google.com>
 <aXEFObeAwlzXprDC@google.com>
 <aXHfYfNZ20-3J8qR@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXHfYfNZ20-3J8qR@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211288-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CDC76BA95
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 08:27:13AM +0000, Alice Ryhl wrote:
> On Wed, Jan 21, 2026 at 04:56:25PM +0000, Carlos Llamas wrote:
> > On Wed, Jan 21, 2026 at 03:24:06PM +0000, Alice Ryhl wrote:
> > > 
> > > Erm, this solution seems dangerous to me. You access t->to_proc and
> > > t->to_thread inside binder_netlink_report(), and if t has been freed,
> > > could the same apply to t->to_proc or t->to_thread?
> > > 
> > > After looking a bit more: I can see now that you do call
> > > 
> > > 	if (target_thread)
> > > 		binder_thread_dec_tmpref(target_thread);
> > > 	binder_proc_dec_tmpref(target_proc);
> > > 	if (target_node)
> > > 		binder_dec_node_tmpref(target_node);
> > > 
> > > after this ... so I guess it can't go wrong in this particular way.
> > 
> > Right, the access to the target is safe because of the tmprefs just like
> > the rest of the transaction().
> > 
> > > But I'm concerned that we will add fields in the future where this is
> > > not the case. For example, let's say that tomorrow I want to include
> > > t->buffer->clear_on_free in the printed data. If the transaction is
> > > freed, then t->buffer might also be freed.
> > 
> > You actually can't access t->buffer already, there are scenarios where
> > the t->buffer is released before calling binder_netlink_report().
> 
> Hmm, I suppose you are right. It may be worth mentioning that you can't
> access t->buffer in a comment inside netlink_report?

ok, that is a good idea. I'll send a v2.

