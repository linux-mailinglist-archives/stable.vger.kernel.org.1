Return-Path: <stable+bounces-241384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNukIP+R72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:42:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D3476954
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24ECA3015801
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336283D34B7;
	Mon, 27 Apr 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTpk0FJ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F03C65E0
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308003; cv=none; b=Y6Edyoi8VNNwt/bNq9ClTBgIyKurSPNn5jkQ8gZKDiei3jZ+ffg9R3byvp93KvOQ3uorBnC9vPDw2wBI+f8UtLgGJyIssTz8BATb7gFRN20PXR5bjH2ZWA6T6plPtD2s26WJ7J1SueC9Hw+DTfGmX+ldPKYe0ejL+uBYV/H0774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308003; c=relaxed/simple;
	bh=ELm9WL56BWn8XsVieKjsOyOl1nxE9yjcplz5KpQGR+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSG/4x8EsvHhRazOZPCEftptKnMDhWQdtFXHRw+z+GZrwZfgVgEbflCz+qp30hdbuqkRBwKQNHI52sBfwSG7QkE/V91jjelDIcLpgpS1F+esuwsXFthacg5oI5sjm8lfd6ygPxyiKAKtiCxnmETVibA2Z8wPqz9D7bdOIsjiGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTpk0FJ9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso2355ad.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777308001; x=1777912801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1r6n/7OP5VXencUpZp7irvZXo3Q7ZpTXl+NYS+r5PI=;
        b=hTpk0FJ9t2VFhHQo9poiVlDfvB/MP0HWGzTReU/fkQch7YMciUlebXw+yxT2yA71Sc
         EPVDGe47ILw5+nLeJQGh6egPq2+Q/TCWfOmAUf1e7buUreTX1F05KhiSklsVEGyA6y2t
         oOjxM+JjNZG+3Uy63obuiFksdLGoozNcHocqEKz/lg3Zt2mTSi1KGGiS0m4jPkLwGewv
         nSuzFNQp8ZFD7XN7FHIrAG8fsxNxKv/j6gLUD1SQfvUf3+nZwmC+zZaNEaFVUMXAlC/Q
         0POe3MtdGr6Mb1/jHn7a8E+Y/wRLsIBKRrCne1yte9ENGdik+o/AQc2EQYySbfDJIBN6
         zWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308001; x=1777912801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1r6n/7OP5VXencUpZp7irvZXo3Q7ZpTXl+NYS+r5PI=;
        b=bu3eJxZCNffpxGvJnkYvWf3obCqcIFDKaTF+5hiD7hA9DkBqZhA9wuiZGpnrLOGW3d
         DuIMbDH8vspX7Po00AzGQGHks0940hyGXqJEd3pPrM6cf8IFl6fusZV8CPa7HI8MFQjQ
         bAwx2MRkeiAv7CcyHVDPjbrhLUp8DzMWQLdrmPE7rI4yChmIjjFdkmwa/mfsKTXe4WzN
         RrxAtYe3R2z7ZfmYTewtNzRRT+ivbJR+jmHF5CgRfSxVFkgmXudV5m4Yb4sEgjA7q3Mg
         4IIiH+yUqTgkMh+eKUyjVmhFuyUvDOufPa+d+qAWyaQdfTCgCzG+Gv+89iBR8Q7mQOSg
         kDeg==
X-Forwarded-Encrypted: i=1; AFNElJ/F1CvJrtLKnMajN3XKHhdch41HGJX84FzLWzuGGG+DjULUOnHiJTzSHRUw663N14j7wIH1mUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMNrhMJgp7fZtnW1zz9abvXguKbwlKQm51cCF/wEvq9IMtKP8
	2sl2eH5arQVfHpYy9A11CNHeeFCPpowCcQFGD4Bg89lAiRPuAMYrOgt3Y4qkvD0ogA==
X-Gm-Gg: AeBDietXimm3JDxHhzQ5k5vDa9BimvLnHxhAZKqX8dXWIAcKrLsBQRN9pM3sT5bhG8f
	MfGSTs5J9gCDJaAGXvCFwPOz9qwuYVLIDuXnknXQKNyICwXo/1rCr6paTxSutVLOFep0EknnomW
	1Fo8AvViXfNfggGnIJMSjHttGU/nDSj7+tdjhsGiOl2kQV3OShXbMuzR4/+XcOmN1aFdzBFXrZ0
	kivnMAWPHgevbhAUEbdHOkVXsh91IP3WliVjVnvccna6ldCCjHWYloJbLNDsb9rn9EApai2vKwQ
	t42BNjRw6bdh/kTSFoZxU0XVtnuulWhR2Wg24rJ8qeF36K4bxVn1FDWbjGGjcuo3X+fGrrtjQ7I
	SI5LYXO3DAQ2bJQ78ODI3rH0gdM+hQRX5Vge1RiVFw1/+S03c1+beDsVm8E0qKh63BK/AXKaOWJ
	djF2J8RVt5m/EXCcKHTHSJnkOZgZ/Ae1AW4u2q4CyS6qgbnckFpsug8aH+TwvXrpC4YtLxJ0/DX
	39XS7/ceGiGDoP7WRNt1S6qFH3coQmPGAEL0JaqoBzI3XIo9t7EhcgzoKuja4y4Bfw=
X-Received: by 2002:a17:902:cec2:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2b97a407e44mr259295ad.5.1777308000438;
        Mon, 27 Apr 2026 09:40:00 -0700 (PDT)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa40b2sm23658373a12.13.2026.04.27.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:39:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:39:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Matthew Maurer <mmaurer@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>,
	Paul Moore <paul@paul-moore.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	David Stevens <stevensd@google.com>
Subject: Re: [PATCH] rust_binder: Avoid holding lock when dropping
 delivered_death
Message-ID: <ae-RW3Pdw7-sN-Dt@google.com>
References: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
X-Rspamd-Queue-Id: 8A3D3476954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,garyguo.net,protonmail.com,umich.edu,gmail.com,paul-moore.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241384-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 03, 2026 at 06:18:58PM +0000, Matthew Maurer wrote:
> In 6c37bebd8c926, we switched to looping over the list and dropping each
> individual node, ostensibly without the lock held in the loop body.
> 
> If the kernel were using Rust Edition 2024, the comment would be
> accurate, and the lock would not be held across the drop. However, the
> kernel is currently using 2021, so tail expression lifetime extension
> results in the lock being held across the drop. Explicitly binding the
> expression result to a variable makes the lockguard no longer part of a
> tail expression, causing the lock to be dropped before entering the loop
> body.
> 
> This was detected via `CONFIG_PROVE_LOCKING` identifying an invalid wait
> context at the drop site.
> 
> Reported-by: David Stevens <stevensd@google.com>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

