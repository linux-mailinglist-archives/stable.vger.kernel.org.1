Return-Path: <stable+bounces-232585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APndMhlDzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:56:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4923723DB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A647A3007CB0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA64657D0;
	Tue, 31 Mar 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI+ZU316"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6733EB7E4
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994024; cv=pass; b=b+M8ZOsKKRTeKq26SlWKwAVMgTiPLrq5lpxpcVxDGqnwFrlbF3pJ+4uRxIkHFRrsvJpxpOz0ZDU6lR3sSpcy1346987jtDUbJC895H1DjTfPYbhtTLLUKa4HZ4DLY/u3VBZnqzVrwV/yCHpxTJX2kFDbFBUBTPEbFvdPP5bP/tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994024; c=relaxed/simple;
	bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1HK1ocw8YprzrAS/YWLtfrbJlyebYSxgAQgM5L0sQ0e8d3+cLlzrzebQColfNrfLH5E/NIoZLjc2KgJ3GY9KPtBg3iIyPGsk7lTJXJeeQquaqBqDkUaBRB6u2dPiNmIfVQxNPwsAo4NoQK/xDNQ/poqjjHF7uSnhV4dTskSg9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI+ZU316; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c16cd8024bso165282eec.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994023; cv=none;
        d=google.com; s=arc-20240605;
        b=FdBeKE2wtemIZhhPddTHUHUuCKjZWlivParcuiGnM3sTdh91n76Kd6hVD8TIFEbZUV
         s3lJJRViMeqJP3zag5rG5V86I9Yf3yjDyMbAALjFITJTceO2T5eqnOB3kh/eepNd4TYJ
         Pj6kSH9m7cGOK0+gsMqXdWlHGb2Po54QqriG2ZBMyxMTRbJjXQPNO+4LKMVuWMdOfwYc
         3aBBzvy39BYdvl6iZIIvLHdboq2OhJl2WDjx8frL8aElKnyF7O/0fLK2AfUve7fNlR1B
         848mcomIXFxhzAUrGIWxE9+Gdy4RMS19wA/kOuGQ2EsZLx70UndjJz1H1qo0tSZRHTxE
         /feA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        fh=1lixDIrkVT6Hn3kISHHmEDs4bbw9k8MM9p7dzawWW3g=;
        b=DmOI14B3Xu/WicXprUg9Mc4LJYmrqzz1c2M1zILWkWMR4MHeFXwOtTKfVz0KSDZBfP
         GzQTENS/ux8GH824+YRRrbClAxYkrxYoDYYXR17RcEUDNcdo38rWCbZk+1qrR3FOoYip
         J6pnIp8ISEzLo+gJgdyrwrVDo04CfLuapZ7aROGOcKvSJ/jF6ri+1WC4z6WieaQGPfEP
         /HBkx5+3nExKkjP9aWw7TQJhwV80N9lvdxMH2wPB+AveGnXIhKEjMY4iaZcYMkXTiGgX
         WrJY7VXiXPPq5w2dKMPrtSk3dVblgI20GV/kP/AeR/YpZqNnbadW6KsbOD6gfKM8B+vs
         LLhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994023; x=1775598823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        b=hI+ZU316rzrg7e7Aifygasa404WPmfjmKJN0XKVyVRATCGwnsGXkM/URl7vqLwObXD
         q2x8nMzVT9xaJYJRr3NucWs0ZjcXhIx3d+UMKamrzxfc990kUClNRKDaObTG3NX0rb6b
         RFfMu9Y21lR9nTm0WZkhAIPY8bGqf9neHxUe+tepxvVzWHhYYz5HBoJmT5VWOzOFB9PU
         1SScrw32lJwxRYfmn+6bvZQ3uTGC37p2tgNQSdyhJ3V6hyT8W5P78mZl3gOFx3S0AxOk
         00dcimD5ozJd2QpbZzCPcW9wWLuaripl+vhtzovrK860zA4z0EIcogXjJRhHuZMlvg/B
         hfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994023; x=1775598823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        b=VQwZ7rroITOJsd9ZUXJMZzu/M1YzLOjgFv0fP1BvVWG7uYQr0W60GPKMb7RAkBlxAc
         vPrQXfN1kjbo8raDnMsW35gehTGwxeQm86SHWQ6wINwMe2Xv/0h7kpNO5VtOSZDRnLrk
         EAnElxx749TBgQIvjodUVBU/Y3xeMULdH/tr7FR08RLcKHm72/vIQCzY5neEkdV+duzt
         nduMDJyKLwIA/8GgDiLT3bSo3+gfM/mr14q41QOA2RknK6gnp7OTpC/CeycdBCor31KU
         hJhfAWEM9im1yyynsJdjPsxJPodRHxMlm7RNuqACfTJoUqyo9xSUgQnVusNAk0Fa319w
         JjKg==
X-Forwarded-Encrypted: i=1; AJvYcCXxZcr6hxYwkblZXiK7l0jHj7OnDwLdRyPXSlx/Sa9j2dG34ixqNjCMswFTAPsgMc07Hx08hWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO58oKqeMZytKA8jf+5fdJqc0X7Y6WOHP9s434FQHzQ7NQmhod
	jPgJAdWvWr6YFSO7q/GM7Iw4aXBblx+ruFtIZC3GMwkgdq8Ju0QXN6LfE0WrfABwqexx92dZ5ZE
	o/LBqxsnh2Zh4bd58TrRpVcbYRHuKOs8=
X-Gm-Gg: ATEYQzwcsivoYeTm8UdpG4gIYfH2JJC+t1temIEiiBRCnI30+wAckVLdvNwrkMjWKg6
	0+/AjNK+gbw/A82uRlX48Iod/Wh3tM9cITSnXCBvPH4P+GNvYvFSUwI2Hc5ufGl3ArS4AH1/bLj
	aaNw028AvcqYVBn/2mGl9jIxIi2xSIliXme3kFFnQVc4xeR2lgNsmluqVUpEf0aJiwYwBBvSHx+
	8Rszw0I/1hgQRZCszqAZfqOHtnZBi3JH+fob9GDXeqddCJZpcT6fBNJ53JISwiPUtdh3svWsk8L
	v7k5lgns9yEd0odPgm0fGs5ICxC4aF8Lhqmu52mNab7FOFfZxVW6r2gwu/eHymZRgbfAGcYhU82
	x4ateVDvZX8305FKpolZKLex8Q71UGLNmIQ==
X-Received: by 2002:a05:7300:1491:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2c932cbf06emr281953eec.5.1774994022517; Tue, 31 Mar 2026
 14:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
 <CANiq72=wsdJf1_qwAADhmKA2i7y9U+3WOm+9utE2rv52_eqnpQ@mail.gmail.com> <DHHANEJI7LQ0.3PGBQH34QK0DJ@garyguo.net>
In-Reply-To: <DHHANEJI7LQ0.3PGBQH34QK0DJ@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 23:53:28 +0200
X-Gm-Features: AQROBzC47UfLtt9SgfAHiHNm4GsMBgtssH0puTNrVE3JRvF8RcuXvNsGPOJ1MSY
Message-ID: <CANiq72=8d03wo3_28Q91DpHs=LF8D5N3pmuZtAsr8gLuco5hKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232585-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,google.com,protonmail.com,umich.edu,vger.kernel.org,atomlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4923723DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:43=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I mean the lint is kinda useful, and I don't want to disable it just beca=
use
> it doesn't exist in older versions of rustc.

Yeah, personally I like the inlined way, i.e. I use it myself, so I
don't mind enabling it everywhere if people is happy that it only
applies to some cases.

Another consideration is that the issue linked mentions that they
don't want to mix inline and not (for field access cases), so that
could be annoying for some, which is why they moved it back.

Either way sounds fine for me.

Anyway, if we enable it, I should apply the other suggestion too, put
the Cc: stable@ on them, and switch to `-W` here and remove the Cc:
stable@.

Thanks for taking a look!

Cheers,
Miguel

