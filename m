Return-Path: <stable+bounces-254743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Eh2E770F2rNXQgAu9opvQ
	(envelope-from <stable+bounces-254743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:54:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF945EE0FF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B541D311F469
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD6335BA7;
	Thu, 28 May 2026 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWHc7TyN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20E315D29
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954630; cv=pass; b=HTVKkw75ZPrSMmWjkP75/THXIIqFFjXm0jOyTqV84515LyHusuFJXre03FG17RcRToGJVCJS/o+865gNTEjOSRMbuPgBqyg33au35KIVkgQqI4I/Eor4jIw2LbYBkGTsR4EXCpWkKDYln5JHe4oIJTHcPRroHXG2xOmVP3yAW7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954630; c=relaxed/simple;
	bh=t0V9M6e2VB4qcIJrywyyrYPhcdcYJQBM+oNk8gNRf+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCQB0Dr+xnmDpzxW5k6kQpu9Tg1xkUaBEkQWHXn92miV0KSh4uSmy6Tevl1HLLIHqqDtIsenFA/r/G3MtFjvpcIRFJhHALShDoaDtvIZLYgNxRRYupNkBDJrn1KdgdIE61WxZ2ta+H61KeYDZe4FHCtvp51MtmmdfCurroycm+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWHc7TyN; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304d8e3bb72so688204eec.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 00:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779954628; cv=none;
        d=google.com; s=arc-20240605;
        b=REGGd0rHnrORyIWSlMx+OqYxXac52g+jkPO2Bgikv7bD0oqPjZahRcYxCZ8aSr/0Dz
         g67UH2Oq2nTNf09sQFmhfcvYinuzuuTiAtgDrCo3LYAohWhcOGPenDo0C7wEakEuiNus
         g8hhEcHCyjNbdmbZR6VM0x4D1RKgHEN4KvxsfSN803o7cVPSlk0PNZxNQaIQBkHHO5dC
         ABaNcdJ72B/Wp/FhjsAUxwCSHtGv0WBqB6ZKzx6XlSSxhYQV7EVg/EYjk1AJD+ms3+hD
         4A5t4Ap9hL7ZdE/lPlPPBWYM1I0P9lA50ZtK7PGL5SmAVuekBHOXi1kGiSnkaPT/a+II
         iTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0V9M6e2VB4qcIJrywyyrYPhcdcYJQBM+oNk8gNRf+8=;
        fh=U8UIX2RJCy6YVrfwl+CxOBXvl2NjRjVGIhrn98yaUx8=;
        b=E1ZynYO4ALa0aW5rMb/VBE09ZW0uaMZF0l1CjfbdFw8LRhRbsb6fxOb7VISXBxNWN0
         qKoSgZ7n3/7F2Iy92CZ1b6vWiN8BQ7YODpF0x5eU1BtRmsvZD2YitCHkX7mcnYRjxrb+
         HTDpf/I94UucSZhFwJD4c/0VmCmeLZiRM3xoFsmx+kwSitJvCUnmVgn6r0LV34dRb2Fn
         NQDfBAYV40ZmfPhnWs4E+Qhb4m6wgUo68ReXSQ7v4Rlm/l1kdCWUx3RvD7URWfk15Hbr
         vq7JGkCXOBbehW/ATZMz4C1oOzfOA7WGlIQgZ7LAJ+sgjwdzEyDLomJjHlcWlnRN7Wvy
         goZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779954628; x=1780559428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0V9M6e2VB4qcIJrywyyrYPhcdcYJQBM+oNk8gNRf+8=;
        b=lWHc7TyNWIGIR0dQ+iuW/ZtSC7yNVk8aEnC9RNDr0gE+KlICoU6ZDPh4vVQWkdVhiM
         TFDk9M+58z00ApW50L6cggsHVuJ+SwGjQZAB3K2XokuFzB8KzmZhDjKsukHmdQflSaJI
         Y07mF5WmIlLD8kEANr0llyy5UPBth5QlUOmgWByckq+ZIVAYir1thzsWWt7KbLsENi97
         kwsubOMY2p7txzET+G9qIve2lRnKmM7isi5NExkae9CosftvDr7gqo2b6fQfMmLVAyyy
         8TdxDPgyuoXtIUorYMg3th7wnJtbqsZoKd+mtfp16Tu6V8PxYsBdzZ/oIGRjg+qERbzV
         tVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779954628; x=1780559428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0V9M6e2VB4qcIJrywyyrYPhcdcYJQBM+oNk8gNRf+8=;
        b=Ea0+k2n3eBMqhJeCU9R8R4Q5WrzkBCkSXhbGNRKYCBQRO0i53+cc1SAgiZ5GvOg0u3
         CViZW7mL99l0xXJ59MnOXveuwE/vfl2EXuYAxVhTGGGmGZ42OnFhFWDTZFoufxL6zkIL
         0Ejq7nWXhuQiykzdWPuIUwdlZ0gynpvWfTB6l0AxZ2ps4qysY/XBj96Mw+BEqnV5MwEc
         Lgc/Sn1gyGOusz0+bvGVvJrjluFI5xbecxJpTOq6PrPuZCjDR7GWR4y51jKG8v4zDatx
         +bGelF7MQgm9/mktj2oASNecOUf4Rl8u+D3NNo61gykyVdOD9MkcJfLrj/SSRpoCTB2i
         YtMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Mfbs0TaCarh7+P6hQfUWWtJKqOvmhSVnpvDUfWh/qYqK0m4S5uPDbXtPa6JcK9UZ1L1GvwM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDbNyMfRP6meWgaH75QFs0S9xsGw3btpJYpSxSqhFk2XSgR96
	uPCKn6zlR9USPm4lS56esUbx6TJJCmRYcREVBRrcYwNVFFoGggu7th/J6QXEezrPDcuvJP7PKTf
	2dfhSFY6eBu2eVKbEa0inftAnTUqUfwEvYhB6W/Wv
X-Gm-Gg: Acq92OF2tZn+DRLLYKeyvzH/6lurbscD+l29Xkp/FN1kz0hsgrjWqOB/2MHWkTcSeJ6
	P+ismT+/JZu/q4nYIhyaiLbkj6Aovgap0yTFOOsxTzTrndFOZV1P0kA7dU42i/lS3GdI4CrCvk7
	Gx1LMQo+jnrt6S+okrx4BIww2gBYzP557HY4Q70k3B9JK5/suvzeKNVyKhCqQL+pUgmkmSFYzsV
	iEdtkPILBDoIlrffKopcOY1SgoJlqJrgB2zz86Ta3aqhhCtdjJ3VARrvHF93uQLe5IF71Yroqle
	4xBTwwADTC9G1gKXmHEm9hPYf3bTq+XwRV5INGD/O5cSd2WbBgxkHYIOOPXXUe5oe6tiFtB7Obt
	w5Y0l
X-Received: by 2002:a05:693c:69d3:b0:304:5db8:daaa with SMTP id
 5a478bee46e88-3045db9c438mr6096842eec.12.1779954627675; Thu, 28 May 2026
 00:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-set-extended-error-v1-1-407b4b466035@google.com>
In-Reply-To: <20260527-set-extended-error-v1-1-407b4b466035@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 28 May 2026 09:50:11 +0200
X-Gm-Features: AVHnY4INulTCcRwU6GdvWBSiFwJioZKqN5qt8BQbixvcN9LDNmBIpBZ3C8IQ-yw
Message-ID: <CAH5fLggH-kXntkwF_m6=xv+AzEANKm5eX5rUV4sT3HCasheBuQ@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: fix setting the extended_error
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254743-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BCF945EE0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 3:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This code currently copies the ExtendedError struct to the stack,
> modifies the copy, and then doesn't modify the original. Thus, fix it.
> Clearly nobody actually uses this feature, because nobody noticed that
> this is broken until they tried changing userspace to make some errors
> fatal.
>
> A test in userspace is being added along with this change.
>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Hrm, looks like this patch is insufficient.

Alice

