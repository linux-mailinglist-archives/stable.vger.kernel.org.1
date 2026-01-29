Return-Path: <stable+bounces-212720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG/OM4C5emkr9gEAu9opvQ
	(envelope-from <stable+bounces-212720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:36:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE8AAD1D
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2C3305C4A1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A3318EF2;
	Thu, 29 Jan 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnDSMtP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC802FE566
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650401; cv=pass; b=BoM8Ax4ZtkES9p4VMS/rXFGK3NF3F9nphDy+Mr6r9h8ZX5yelgx1Sm6Wmpp0p9A62zZJyzcBs71AbudSi+sjT+Rxz4BE2tMiVSxxGUU/gke2lpjtumjZjZBaxnN6FkDLP8bbmpj3lbzLE1NSK4gPrPCgqfScE1RfoDBig7LcVow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650401; c=relaxed/simple;
	bh=KPxkUftLifgbex2Sk5+vVvXj4pg8pH+i1zJNrKTkaXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N82TKHtyyAFJqJmy8Fx1mKUieJMxgLpU0L1zRIlpBDSl1eCaPLvS3HP5qUEvAZ9TLbLrFRT8eqv2xgZkhuKHz/RuvKeVbIz1PJw8m207xjWQXc2VtPdDF/mbjSB/o/+79Q1SWdE6OFcj7UcY4no52QDqqwX0bf89Dj3W3wrQwIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnDSMtP3; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124a95e592fso290856c88.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 17:33:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769650398; cv=none;
        d=google.com; s=arc-20240605;
        b=d0A/nE0+KeN1CIVNfXVt07Niar0zyPmY2gtL6PWNcYZUGdtGB6YKEACUVqDOv3yPst
         pYDjXshtSjKkR38ZLktKPtQz8OrhCr0u7vg0P49qSFNTja+OXyjmAREcwsizovhYPsTq
         OfAW7XMaPJcHSbf8eSxdKaq9u6HtjFUKJ6XqfTjMYP4iZ/2/eCM/9E7SGZ8Hy+CjO0cG
         DZ/NvKk8+7FMLA3rPPvoF7AMu6fuygvls/u/d2KNAbby4u5JacybRc+xfNTrmXw9T4HS
         zRClpoaG4PDiAsJf1UFawzXN4YoM1PkV2pmUSR2uxYXrTbJ2FDQCBTw8kKJermZ46XSE
         PmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KPxkUftLifgbex2Sk5+vVvXj4pg8pH+i1zJNrKTkaXI=;
        fh=QkFHyyMGvPsdmH3uKFw7f9PLlrP1v1brfOCW3GqWKJU=;
        b=XgkIwRY3bFyx2zIQ4mAGPHC/3rlpFSOiPChgN52ELn/0ojs7nf2+xPAraeUO3Upbhi
         O/j84ZoKQOIZDsIvOlBnOrNSgN7I28PWbIWO1WMAtV1w+3Os5U3aODGcvWx/ZOdVLDJL
         Zg0WGbMdeWhU+cl7w/ssmEaDLCIAK8tYdKA2+uOQSDF0cb8Ow2vv8ybMszHJARcYN2j8
         ORtPvP6rkq7b0Nc90Rz0ksTbjfoAFLf9ntSgx/sop7Vey82YSgXXE0jmPh/9gcb5M8i3
         vI2VfUe9L4CKAbqf+NOwjJD7l97B+MlIfPbb8NFuDjGWYNN+hdFKUnTscqVMptFVapZ/
         d7bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769650398; x=1770255198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPxkUftLifgbex2Sk5+vVvXj4pg8pH+i1zJNrKTkaXI=;
        b=OnDSMtP3W0RLKw9N2d1/evtnaZyYzojwTLtCsomJw9IKq9lHXmVa5n2W2ARAdmNgRx
         AFnGKtRUbEUvsxGkPJNWhi7mc4Ax7t3nMPkUFOivgx6xIB9qJi+YNveUbm2mo6iabizZ
         eiqMEChCoGqR02UP87BhPwurlpxHuhjhuyj9b84ACG9aHsk4AouPGgioHc2RxkTtCOIH
         Ukw796lf42fWg8HT7u18c0FJGOeywsVO9H0WTbywrDJFm2PRjXYppaBClNWOGy1HkGhX
         1h6PDiihhHnfEsorThk/0GbAqrZgzr3S06vPHTWTpqEECrESpW1v6W5zHuIdXEFZ8wV8
         seKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769650398; x=1770255198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPxkUftLifgbex2Sk5+vVvXj4pg8pH+i1zJNrKTkaXI=;
        b=OjLzXjiYzMQx/rxSMoyCjxqhHIK8MzLYWsHHkLXtX/Dh63bLaeFCGq0MSetBSf973Q
         2OLSbuCA3Nukl1OImYIEJXz7W9IpBd9U1X7j1V2ugVKsNS5DXrvX36lINWNAkf3NeD3K
         8c7tFsk5EAtPgeaw3D8KxUjpv3zQEv+QI00najFFgxUObdaHcmKMM43OdURyA9lXbhSj
         bacjAW5DQDyX9k+FCIjkEx3TnosMsYM3ICR2yiVt1Tv47DZMquIqNyOQa2cWBr1l2lwg
         q7DmNBjmxUMIVBDBt4O0oGKBH+3fWiHyZVTwNzav/W1/gT8OmW+hQhIqnGx74Nggj8Hp
         ysPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6OWU9Sx3JbKJ+tQSh1j7PdDK3lyyMCJkOo7Q7hpA796eSwhSpwCDQFTdOsHAShygW6AYtG1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDc8HSVIzS1Q+N88JS+gN57lRCwGfCOave5ytI3LNZdgNkHmx
	l+jWxciLT9YygOag+wbvC+KcR04tkGpiy1h9EX1JZwNFoVO9tBf4SC7RI94KMY/XQwWq2KVu2/N
	kO7kz2CTfGkjprNsudIuv9GZ16k+IqUhHRPKfpUZo
X-Gm-Gg: AZuq6aLNIcOZVFULHcmhVfrD9D5230Lla9zuuDwdPpTTAHXPBWPvs/tyjESPEGTd2OI
	Fj30zhFHRpI4j9q1wFhpKqyavZnRcMYMROogn/53I3phzL5XTIp6SQoGVoywtMmkpvRt446aKMr
	RHxdWQ4hlAschMDLXnDsEBb5XTgJ1eHrmxj7njEG4rUf239qiqMXn9Nj2NJm56yFrTkZbliAop/
	v8iAg4bWE13yAHZLp+UDjv4NYu9zHthJDZ+xTrctmNqMJQSYCKrC8+yZi5dd96HmM2F1ZVXSYPo
	bjXUcpRzhstrqQp6Db0zP8n5cRQ=
X-Received: by 2002:a05:7022:fa2:b0:119:e569:fbb2 with SMTP id
 a92af1059eb24-124a00ce3damr4826575c88.33.1769650397896; Wed, 28 Jan 2026
 17:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129005645.747680-1-elver@google.com> <20260129005645.747680-2-elver@google.com>
 <aXq2FOa1va0P_zu8@tardis.local>
In-Reply-To: <aXq2FOa1va0P_zu8@tardis.local>
From: Marco Elver <elver@google.com>
Date: Thu, 29 Jan 2026 02:32:41 +0100
X-Gm-Features: AZwV_QgWRiXog_Bj0YjuS6XVuAh9IM2upzY_YIdNl-vROYedm134WVZPU-1IYFc
Message-ID: <CANpmjNOBD5EX2vkVQoGq2v3xoTd+edcoz2g6n6u4fvahA3AXdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Bart Van Assche <bvanassche@acm.org>, llvm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212720-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,linutronix.de,gmail.com,redhat.com,acm.org,lists.linux.dev,arm.com,arndb.de,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 67DE8AAD1D
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 02:21, Boqun Feng <boqun@kernel.org> wrote:
>
> On Thu, Jan 29, 2026 at 01:52:32AM +0100, Marco Elver wrote:
> > The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
> > qualified the fallback "once" access for types larger than 8 bytes,
> > which are not atomic but should still happen "once" and suppress common
> > compiler optimizations.
> >
> > The cast `volatile typeof(__x)` applied the volatile qualifier to the
> > pointer type itself rather than the pointee. This created a volatile
> > pointer to a non-volatile type, which violated __READ_ONCE() semantics.
> >
> > Fix this by casting to `volatile typeof(*__x) *`.
>
> I guess a `volatile typeof(x) *` also works. Either way, good catch!

x might expand to some big expression, so better to refer to it only
once, and then use the same-typed *__x as a proxy. Semantically the
same, but compile-times ought to be better this way.

> Reviewed-by: Boqun Feng <boqun@kernel.org>

Thanks!

