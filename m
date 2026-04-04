Return-Path: <stable+bounces-233268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEDIIo3I0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B739A5C8
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B14309DDE6
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB53A4F3F;
	Sat,  4 Apr 2026 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRffffSM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816E3A4F29
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290233; cv=pass; b=SqTI+uSXDejsqatNbgn9ziAvAiZqt2NSzKsFSzpVg8yB5IAfqGUlXEHP0TKa/gdt/6Uk5ZK4oGF6/AnDwfArUBywao5WL4H2lK06xT0qxtIOfpjIgW/RvwMRCUxNJNU3M7DPrtawzmEg3QzoiD9ZSv7LvZJ+tUVNUS9Wgz1uZ6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290233; c=relaxed/simple;
	bh=DGfRE451pnw7NyOGNMyrn4Imx+oD2bBNkpJX4gxeM0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=escxsTgwmZZbAADDhpiuPE9QpiAXqVCb4RHjHJA1l4OyTV1ubt0bGVNQS/r/KtbQAPMPW7PKt0WEokA11ZhUc402F/nTTvB5GuggpQg715CGaaBts3eGLGXdiZbCGR6X6wyxyOA5GvUAwgHUO5QdbY2q2Z8gKVDnKmpY2MrPhdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRffffSM; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b87970468so2131352f8f.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775290230; cv=none;
        d=google.com; s=arc-20240605;
        b=Gn6z/jiKYkK5VpCkRVISD7XLJOuw+KcjyyqCOavvQv2UB3NGCCBZyCGHEVAhc8ZI2I
         5RQrFsAsHYV7SUl/CMXCwIJaCe8CrXa61pfRjvcYBE0yLiqBhcKYnOeWLmfywBy0p0B6
         MxbVsygv39P/WlPQdQ1Gk/2tQgKkP4FQ11Ul9gdgZKkF7j2CDynz2gNBSaG+nhbVd7vU
         Ao1hKNkSTBSdMvv8Zm3RO4Qijy05Lxuu+UXBw94NIE7wT0BAgpQuMVCeJzdca4CdGlW1
         t9b/b7gkaY6sRXJb4zvJfkMP3o8UmLMr2lIuJOvKKk9hoI6ZELppH/Oay5iCwGL3VVov
         YJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGfRE451pnw7NyOGNMyrn4Imx+oD2bBNkpJX4gxeM0w=;
        fh=epPv5XWEKnl18S1hDU5cVhWOzEOlO2o1072drM1PumM=;
        b=Juwl3LhYdnGNT+1/YYk5wqQbf9EsTL8QHwnzmY7vuh3RKJsPfeybgGpDAjU8ItvA/n
         37ao6hkLO52jf77AEAi3XB4RAf31pv4JHBK9iJuD8lVGvUkDf2dc/4BOjiRQ9ArQj5hz
         mN79vzcJrDTwF3hczmlO7ASkcwtMhDQSvwJO8xIxY5ooROr3mkWPs/sFdGsQcXWPo94Q
         2++4KkQjL7PYxf3EaLqf6TqZu2g0ovS8Jx1OPK/PhgF/CVCkUdqsoRi0MHszQr7NL/K9
         sjY9WB1o5a2H1sz9CiGwAooU8UN9D1OEvK8/xWICCYm8iY1+kEwmhFjlA8IHidjVm/2P
         Rryg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775290230; x=1775895030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGfRE451pnw7NyOGNMyrn4Imx+oD2bBNkpJX4gxeM0w=;
        b=GRffffSMuhhl3B/4hgi7A2dPpC+ASB5mbylg+PMOjmqR9eV6Tke/MVML6xYt0PPbrl
         KNXHgeXKeLejB6G2LLXg/toonYFBNh8lg3mcLQbdTNMPY8hrPzOTgQIhYD9kL93twugD
         SHIrmnHuXk12qoz8YyrMN6wCK3JUV87KWUsxwQpep5xuaOI9Lh3QM8eWs7R2svXdr9+S
         P2PwgG+GBGDojw162xKpgdt6n3xSYLXMIUhWVoMgv+IVG7HHX8CosnPPir1swK1qWZHJ
         7DcnSyv4ltO7ukVDQ6aKmbGUeyjyH+ZoCHxYey06JwZOr2p+vG7S0ySaRIRgJhtXhrdy
         /7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290230; x=1775895030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGfRE451pnw7NyOGNMyrn4Imx+oD2bBNkpJX4gxeM0w=;
        b=JU0urXwQSnkOa5x4jFJPZakFHrj+JI8XO7HqXwHVEb0cLdGI2c1K/LTQKND8VaQIen
         TNyDwJNRukC5WtwMOVFAQBIGQd7TMBZeup3dLlDcqFtZE78r0tnc8sYmT2amavrQcEZ2
         Hs+PLgh9vyTM02zBzZRnkFSYGd4PBjwBVRDzdNnxsiPE354ha/mLzWh26qg/cp15VLJD
         7Fe9FNVu+6A2gLguSk7ktTKzHkix/UAbQXnkkWbpnsmQiF+P8OuUT1lWeuh67gLNA/DX
         k8snYkYKN+LvqJuUfhKZjVR1xS4gqTb7VJQqqz4RMehyJjUJILOdiA1FsIDyH/rjyCsK
         xQBw==
X-Forwarded-Encrypted: i=1; AJvYcCV5cexP9goW3EnnAYKQRwVFl+/rKUQpci9aSC7u44tTLmhVxDd0H3Py8FHEqvH/fYKsQo8y9yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxsc6tM9gcIkUR/efjwbSekaT/BpvS7p2YQSm87Rwra9V7pFdo
	TEQhwEVC85Jet8eGqB9N0PqHDkBhk4CYi1X0rrySyUHCLU0z1czKHcIv6Aeio2xHIemBNe5A3Yb
	MGBaMDW/DviKZIIOIf+uowWKl/oB+3fLKkkk2/D7Z
X-Gm-Gg: AeBDiesyFldzLd7C3i9AGed6JVmC6VKT9gawzffaaq4WA2a/7BIPFYgNYAt8Xu2O20w
	NBdu4SwBFK8r3i+c98NGx9K55Ut3X2lPk0poOpYI5x/Y3Rkp9W0GVarhCROUyBqr50GQM8BZvXH
	7rmq+CiO9UhpimwwFMsT2bBIdX/wdppbHHF+gHELhMoAPisMPV6Saa0GLsVFmHS+hkW0pIJ0IsD
	UjH9Lx4MMDqr5oj3waiieMDjUb/LyqWtFa3LZt0eSG3zoBW98el76R9JvduhBB/JyV0iTtR96dA
	71lWbDccLv2ig5C+8dqVAOTYnsig8EUS+R3M3g==
X-Received: by 2002:a05:6000:25c8:b0:43c:f257:c6fc with SMTP id
 ffacd0b85a97d-43d2926adc0mr8915415f8f.10.1775290229411; Sat, 04 Apr 2026
 01:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
In-Reply-To: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 4 Apr 2026 10:10:15 +0200
X-Gm-Features: AQROBzBU2r2t9knrpqR3DtB1YzIUeNgZ2Vu30xRIPe5hGHIT8gC7oGew3aOQIVc
Message-ID: <CAH5fLgg0F_ijK8i8XYwN4odFAQJshkFJgaw_-eEMRboS=oy+RQ@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: Avoid holding lock when dropping delivered_death
To: Matthew Maurer <mmaurer@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Matt Gilbride <mattgilbride@google.com>, 
	Paul Moore <paul@paul-moore.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233268-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,garyguo.net,protonmail.com,umich.edu,gmail.com,paul-moore.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2B739A5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 8:19=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
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

Thanks
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

