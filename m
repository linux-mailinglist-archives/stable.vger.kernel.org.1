Return-Path: <stable+bounces-216901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5JkPHTDKlGmEHwIAu9opvQ
	(envelope-from <stable+bounces-216901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFC14FCF2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B58303A6DF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505D377577;
	Tue, 17 Feb 2026 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JueFnRDL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40202C3255
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358763; cv=pass; b=QXUqA59Q1L+mB2qkPYG3xEQSiCXkfB3vqCLjXNBUa5rcmTiDbXlwOpUQ5Dlj4w29uuFAKmTZZMbtYTkWDJlgKZAm4CKAV2XhAr4LABn+zKFl8B0Shl/PMeaoEhpOyLchJEati+WDE6HMRtwmGMG0gnGh1H/ukiNHoAG5aVzS1UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358763; c=relaxed/simple;
	bh=QvmFEfilerm7lO2XoIh8wNsVoLikRWpQlWvEe4HXSfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suPcUba6xJ3BXytOse+dFYJcuTEOJ5cPtFDHvnCaC5t46LdIqrqDGUh0OehWkw4dB3F3kmhxUJekMRtIGsSiVtVelWMXa8fLkrTEWSLPEnN4TPkDyRw4E1QM0DuVXX3yT8lGIjiyAvv2mMESfvsWckbO14cyTiAWZGiCX1vykzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JueFnRDL; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so43154015e9.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771358761; cv=none;
        d=google.com; s=arc-20240605;
        b=RBeWnzN6wF1qjShy7cjabxo8UGxAjEbXaa36JjemCKoBjxiPS8A3BWtO97bYRjGcMY
         XHWnUjtkXeLa6X9Y2UQaeXEc6KboSQ/bIaTvl3Xn3S1Dy9zgEkk0NNcAthAaeQ0Zbeo5
         uHyB8kzNwFU9Gj5jWRsNuBN265NLD6zZYhNn87tDCr8wGWbHB0ls3pZ0I1SMKzneEz75
         JyiqxQshf0KdJN56RB9Dgh4DkVumBhsZTXIzuB7b/XkbgNt7dSwT5WJ942Dgo/jMeosz
         kEf3dHoL+sBAh5mu2auvBqK73OZEzpZSc2uPRZ+Ajj8lcDMGcWECpmM+5zEHLjxUVv/N
         p+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+fSQAiWwoKsBkf2pV1VjK0/Igt7D1QD3gcI6T4bBSA=;
        fh=veFpcfGrmtwvV4SsUyW5Wz4vDtHsiJPlmINo3/9JCc4=;
        b=GkrnyovTvk54DybUXLvan+Jzrm0hYZ15rK029dl6Fv6gEv+JsxNCtNfeMqooHAAhSe
         NPgE6v0WVHWRyMVu5k7kXmbkP2W8D8VdvxclpUp+nkNgF1O9fCMj9Ln/df3+6v/m28Ak
         JivWb5ialVC4u4fkRNkP3sH9AZTeE2V8SvyYWYcoVChOOqsyoW+q+DmyIHOpKTDQkxXw
         /pstSULvZ7tp20o78AWSamFZioaHNxMLh2kWLX8LV9GHZbJ63gQ2UJ2HeMnrIBZS/ubY
         Hi/fgxAxnyvKqVMmZYbCnk/f9F248gA40lqJqfwIKdP8iRae5JaqMPf4PQv9tMBm+Dhd
         LS5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771358761; x=1771963561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+fSQAiWwoKsBkf2pV1VjK0/Igt7D1QD3gcI6T4bBSA=;
        b=JueFnRDLCq3eOIvExg+Sd0+l5j0h5p0HgBEXJuFR0nj2XacvqP1Cjtn4tFDgjd6BMp
         OVxY9PTJaqEOI6sVRs9zYPSw7eJh0rASgRfBFgs8/0bCPrPdOWzsA5ie66ojNRzSyytu
         0GmUVO8SuZaB/6sMQpHBNlqIQn9MxrfP8hUUqE9pc4xZurW2xAUf5JvDbRlcXtj8ATYf
         hksq4G8PeJY9fH/vQC+62ZoIiBKf/LI0JSnhz89ZRVm+lc9DX3j6QNlGmKkwnyH2amS8
         HdTk/ByQQKgHTHdHDnQyH61vlnX6RksviYr8yyD/FNPOO5/Jio5k2hKNnsvLf4ZAlEq1
         aRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771358761; x=1771963561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+fSQAiWwoKsBkf2pV1VjK0/Igt7D1QD3gcI6T4bBSA=;
        b=C1MD+52/aFelbuPV7TKJWXE6N9PFJAGEXhj/TNI/Sqp21w68vAoi9X2MYFAjuAlRpv
         /rruzEKbRKABR67maa3j3rFUD4eQFuzpuSAK0bQudmT5Cz0/V7MIJ0SneloMUJ3vjMuj
         wIw0qCf2B6UBiKId+2vCU02A/wcsO7TSdV67bs+cOF44McrDuEdpyQNl1sG0uy5XeMzd
         BzRsv5YRj4pO1q0/a4P/JBFnIGEURN6OFD5iSlYeMsO8eud78URdHHKItwSy57cp1o5E
         ulgST0EnJk/0CIU/Srub037qFtQweTPtoB/Epxzf4z4woSkEKu0BCWnEVaStkhCbFlzO
         YuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD6oDcRjtAk/LHWeuXF5T8BBMM14gaAX22Wii+3kcpqEiZxGQ7gxFcAHh56n/pSx4wbdUmG/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWa2V+LdGbW0xGnjmfkAka6Sbz1dKQOkb1AOn7V9u5R2qs+rS8
	Z++xupRYzFQvIy7m/9w58qRwBAt7VtaO4asxMpnW4v7VxpaEdHzM/Y3wk/j5PHB+we2XGDZ5ihz
	BouIK2hEkLT4O3wONVFy6YOaxQFI9jk1kOh1KQEXa
X-Gm-Gg: AZuq6aIvxws7C+XLbFMawDtd5Pkg8fgvO/p6Btwc1MjYzhl8/3PBK0M58lEl2c4ayuC
	o6hAm5jBkXQaMCw3gQxifLPhm8S2i9YoXs6lP1/47Ujon5dZZLQ0Va34v3oIl9UK3mm0LqY7YEe
	TnbzQz2PhAfspljucbxuiD1zkFng0JV3rX8tK21PDMRCiebrlMvg/JbFjkgw8GrebT9Ik9a7Fe5
	ei7zrfRp5eaeZNluue0asnkX4TTGTS0PdBWjIXvUgH5+BoXLGqv9EvvMRP2XZG9NUpJwYqJZISZ
	DoLG8XUjzKcIsnRARk5MPVHtUet7/QdMAXhfkw==
X-Received: by 2002:a05:600c:1d0a:b0:483:3380:ca12 with SMTP id
 5b1f17b1804b1-48373a74357mr227106915e9.29.1771358760418; Tue, 17 Feb 2026
 12:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-binder-alignment-more-checks-v1-1-7e1cea77411d@google.com>
 <CAG48ez2j5xA-+XwVejp-8gUv2uPEJNOO5t3MoYBgbigE2oV66A@mail.gmail.com>
In-Reply-To: <CAG48ez2j5xA-+XwVejp-8gUv2uPEJNOO5t3MoYBgbigE2oV66A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 17 Feb 2026 21:05:48 +0100
X-Gm-Features: AaiRm51LnptDI8uYMgxt3iMO_zRosmyLsJWFHS1h5b3iwf0sDDYLYCM6k7AIJcQ
Message-ID: <CAH5fLghO5pAmOitPXFA+udWZYTNk2n9zn4RjX5SyydvjzsFEWg@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: add additional alignment checks
To: Jann Horn <jannh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216901-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: BBBFC14FCF2
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 6:48=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jan 23, 2026 at 5:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > This adds some alignment checks to match C Binder more closely. This
> > causes the driver to reject more transactions. I don't think any of the
> > transactions in question are harmful, but it's still a bug because it's
> > the wrong uapi to accept them.
>
> FYI, this actually fixed something somewhat harmful: Before this
> patch, `unused_buffer_space` was sized such that BINDER_TYPE_PTR
> objects could grow into the area reserved for the secctx; so you
> could, for example, clobber the secctx string with a BINDER_TYPE_FDA
> file descriptor fixup, resulting in an incoming transaction where a
> file descriptor number appears in the middle of the secctx string:
>
> 00000060  75 6e 63 6f 6e 66 69 6e 65 64 5f 75 3a 75 6e 63  |unconfined_u:=
unc|
> 00000070  05 00 00 00 6e 65 64 5f 72 3a 75 6e 63 6f 6e 66  |....ned_r:unc=
onf|
> 00000080  69 6e 65 64 5f 74 3a 73 30 2d 73 30 3a 63 30 2e  |ined_t:s0-s0:=
c0.|
> 00000090  63 31 30 32 33 00 00 00 00 00 00 00 00 00 00 00  |c1023........=
...|

Ah yeah. I suppose it's good that BINDER_TYPE_FDA isn't used on modern Andr=
oid.

Alice

