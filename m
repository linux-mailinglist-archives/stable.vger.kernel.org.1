Return-Path: <stable+bounces-216870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB+hGgCqlGl7GQIAu9opvQ
	(envelope-from <stable+bounces-216870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:48:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6114EBB8
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 440B13012E46
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0236F43F;
	Tue, 17 Feb 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Plf3wlvT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3536D4FD
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350523; cv=pass; b=GqJAzqQxog5UnSLIHWy0nMUYvSQL20gM1LiH1CpVzowcoN5Q1n3XCLeTtT4DWjkb3MDZrhq22zEqvp06xTh8K4OpshFE3bzLJITVuxZ/8wKkkrm2pfXwii++l4JAGDI6WLadBC86jzY8UqTv5sBOu5YTHtZN3UYVdMsqk249xjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350523; c=relaxed/simple;
	bh=GgpJ9yEcRczGDFchqBwS4N3ZDlFOzwb0ws/VEtH6HCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pkb7kz3RqHyVib7TvuyDoS+Hp6CgTh3L5DjbrEs9kA5Te//px/ZuGAQfuqxjYkQGFejvRki8X2HhOvNG6fHuwsXo8y0WpUgMv3euaGhqSmQtTUPvugfRKJXXfN+KPTUAtDXC8wT+N8CbUcW8zl7+xJ91F8wO0zK/4AaIgP3PJQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Plf3wlvT; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a3a1740e7so330a12.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 09:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771350521; cv=none;
        d=google.com; s=arc-20240605;
        b=LhC+1+UZQl5czuRo8FVpNwX0wxsObw42IWa3cUfBmukDXyHimCyYz6SNNlbvzKEXrg
         yFuLXGH0xz5pvb0lwurQuoLxJBlLx9LeQPMbS6J6a/+gYkDc/ePqsgqsQK+pdW0dpe03
         FnbAmjQq4aT3ujkB+0gyCh7mMukRioU23CRDlEnigis4enfE84TsK3Z6ArVeNkelYF9t
         5lPPzoVNePvybJafjVs/exTzsLzjzLEn28JtXsxVuQGPjsxlL9wF3wf5+o/f9myWjLKW
         moVyRIVpjT84om7ZkXfj63sDVVNtmiPkg3r1e/Ql7wJnSyHfnIQz9EBmjkKe4AbBJPfS
         XXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfLQXgkBk9jXdjY5cMxmWAy50vt0W+v4RbNQzonshso=;
        fh=fxhnWfBzJvLdsNNZHWQ13rHmKI1uanw9G5V9kJEWquU=;
        b=FlVaks/aYQED2FqJojaVMGCkT01xXCllPedPg14MWX4TqkwVcRO10tsNP0ukvMXYcr
         4HVzmgXUtyrlm+0T8bBeU+wHjXRyVIToG7tZNCJt1ZPdocwDpeabjlDEdbKr/46K4BU5
         rfQmwNTtm2jBkufMoRygiTVPJjeJufsPQFTWg/+7EzZwpaIErDRr45IPI6bGKfmGmv12
         T+cXfX+30DhC6KB+kB+DnFVM4OBCtgEa2Bn4YaYlGjKu7X3GSJRf+NsFN+pbrVFczAWu
         4iV5SJSexI1kTTCjHYNNTDh44VyATe5VrS1nIJLHN8hQ565ssO0X/Qe8S7uwoYmnhNhN
         HoMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771350521; x=1771955321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfLQXgkBk9jXdjY5cMxmWAy50vt0W+v4RbNQzonshso=;
        b=Plf3wlvTPrIJ6Q0HhdjgrbVCLGfuH4UjZKUjOusIbz1cDbI9pv8TR/nNrKlcS8y+KR
         DsbLE9gENuZiJBaqqp9MUQa3BqTK6w18hUKXxLt87+1z2dCYAda+0agCAR19JvkGZiYg
         tpYBU28VdOfWPlrMYqdgGuY2+9yin/vQELmZut9rNLGf2Lrj9PMo45Gr4ol4pWKSkwD0
         tMeiYg9z6XxSMPhyN+JPRU2apJuzcIS7DsX19ke8UEnqbytLjXWgVD6JtsktpgVxw9iU
         sY7cuVynQyA7NpmAcejJWEgHNWfwOIQdbjLVDB0IB1Zxsx93uPDmAVSe4aVLXCkgxBnD
         0bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771350521; x=1771955321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfLQXgkBk9jXdjY5cMxmWAy50vt0W+v4RbNQzonshso=;
        b=vjBxtWKzgPSxbf1wJuo76myxIe3wQc0f/FtoaG3uEMwRWfNhdsHbKsb9Sa+52KN3/B
         uysedfhNUOlC5ejyehtDea2cYkDztElmnRGQp8J+x1bmQ3EtO02es5fM1QaVoWj1ngre
         KdG9zz6ubuv/jcJILgJx0eHSs1VTjh5jwdimfrWxPTfXqK6iEjh6BYowAbP6lnMQ6v4x
         rP/Lc/R2vwF7j4jReiDrgBX6QfnVr+iGQTgEKAbYsOAYpGFq0lwdmrogzP6u7e5b8Dt9
         NiPSB0yxJ6rQD3ZQ5XMytBvMAakZdQxgFTVl6ie5lDJvHZZNhizsv8dk+nyMobNWIONx
         se+w==
X-Forwarded-Encrypted: i=1; AJvYcCXzL30vA89B88/jk5GFG9FAt/BtAuFM5vIzRjzGLVs4wp4oVAX+hklfRGehZ4Wly0SFaLopGsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeW0MOl451Gqp+XlH0uJYGDzyktXBZLm7Wjne5E+2l2c1jGQEi
	BDKkHBxhoYPe6BnDo2jfDDy+YVXKXUKdnI3Uf8LLD68Sw4Q2EBa/ebmjQOP1BCp+pGzPi+aLvW7
	HQvdNEPILVVhWnTYMKWW3oq9calLI68V/mnI6wBdm
X-Gm-Gg: AZuq6aK7bnmbqSSxVgsc7FrYBRiCuNWfKKLX5HvfR992cVpC+eS345XCz1O+YakgRLR
	W5MfAc/fHqQU+W81BIZdP5LLfbZSwqfS04l4MluASQJGraUMO3OqvqNImyFeEwEce0Ee1TOfzDY
	q0ZDC2zPOdmaxaxpIW9nc+Y2jFYj56GL5IfqSU6W0cHjT699bqdeER+Hu5PxjiA4qwdL2MHtomQ
	qUW0gTm0TG3/B2aAzQvaTchAVHDOMk651EnU9Boq5VxqwuDF969/a35CIyEQMAUo9yQ/6vZYim4
	Ynhp6yN9YhVoh5LZsYGkB5mxCxLfuZDakKkB7g==
X-Received: by 2002:a05:6402:110e:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-65c1784a989mr60515a12.3.1771350520127; Tue, 17 Feb 2026
 09:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-binder-alignment-more-checks-v1-1-7e1cea77411d@google.com>
In-Reply-To: <20260123-binder-alignment-more-checks-v1-1-7e1cea77411d@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 17 Feb 2026 18:48:03 +0100
X-Gm-Features: AaiRm50Q6ssb6ZW8F6siVy7jzQQOTtBvYsjEBCebZyc4a5zul4m8Fw0gjdRMHs4
Message-ID: <CAG48ez2j5xA-+XwVejp-8gUv2uPEJNOO5t3MoYBgbigE2oV66A@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: add additional alignment checks
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216870-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 0FE6114EBB8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 5:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> This adds some alignment checks to match C Binder more closely. This
> causes the driver to reject more transactions. I don't think any of the
> transactions in question are harmful, but it's still a bug because it's
> the wrong uapi to accept them.

FYI, this actually fixed something somewhat harmful: Before this
patch, `unused_buffer_space` was sized such that BINDER_TYPE_PTR
objects could grow into the area reserved for the secctx; so you
could, for example, clobber the secctx string with a BINDER_TYPE_FDA
file descriptor fixup, resulting in an incoming transaction where a
file descriptor number appears in the middle of the secctx string:

00000060  75 6e 63 6f 6e 66 69 6e 65 64 5f 75 3a 75 6e 63  |unconfined_u:un=
c|
00000070  05 00 00 00 6e 65 64 5f 72 3a 75 6e 63 6f 6e 66  |....ned_r:uncon=
f|
00000080  69 6e 65 64 5f 74 3a 73 30 2d 73 30 3a 63 30 2e  |ined_t:s0-s0:c0=
.|
00000090  63 31 30 32 33 00 00 00 00 00 00 00 00 00 00 00  |c1023..........=
.|

