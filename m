Return-Path: <stable+bounces-204634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB5CF308F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D14830F3C24
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E6316918;
	Mon,  5 Jan 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPBahxkD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7253168EB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609605; cv=none; b=QN7L+5fTCCiyMLPgdQNqMIdjZ0dRCBpNS/H4Jq5NbgDA/DBQwJN42bb/K8coyuUQhtDEVOqh0aoP2WC7KjyKtfk//tPHqphBOvcl0mgRRISAM/0RM2SQYY5fxaH+tB/Z99useYgFLOdLBqHck39jxUDiFe3v5vx03NKpsxQUHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609605; c=relaxed/simple;
	bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPOPfccDctvIybNlM1nO0XCQZfcwh1uKBVHn5YIwvTe0OhznYJ7bj9/UHJ9vz2n4qaP6wX/kc6KLAvSYysWuxlLpy48lO3ZwLOEDrcXbYeTqT1s4UzFpNW4kY9/C73ObPTnhXGRJ+l3PgG0zAl5oeC6SXVG8w0J3EsRw3A84ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPBahxkD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a08ced9a36so30573465ad.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767609602; x=1768214402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
        b=TPBahxkDEzxpIldCY4B48Wn0U0NjzwIRbzpxV8VdgtEolAf7SDrhIa1TmNAYW6ytEL
         MdFu0LTgkLyGgbi9UQIBVVUlnV/QfSD3GICWA6Hkpa8AjmWhr71O2TwGAQv2eDhDebYd
         p4iITY36D8esuBSU02dRVLHpvlWikGcDejkfpANOUxejXnfB/V2oDJfYG2gUOP28/0ZU
         9YhmIRHHsi0oW64Q958RraaJxBx8v1ufnPCHwaMWExcDEnZ+6KDCNggCFzma5s4abq5y
         2+mRBT1JLftMEa6C/V1oLDRgIwMOVNlIh+2J7DcMKlW7AdJbnC5KghBWwo6fBJ4a9mkh
         a+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609602; x=1768214402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
        b=jIeUM1o2r7MJzshEm7AI+WSm0Y3CWsRoc859VNX89xk/z07Y+hqVs+8mEMSyuDXG9E
         Eon51zB6b+icuhfp/Qdf1wVB+UtvBXQuUaM2S8snebUPDRsVNphQc+UtmLGzAo+4bL1T
         RLhoIn9EKKbkaGj7Q92I0GjTczkr+mUdxlw1idY+fAWriZsNLzUTceY84clFqPw4Bp+A
         aj4+LNCEFPtk3FnaNJw68bZktsoVaO9+OA4fta8wj+XZmubYJUixaHP/MBKg9C7q+kcq
         ez6yoK1WxLzvX0dKwO++ZpccPiC4NFMj8vDk0tuRAv6V7sSlKM09kf8sYtPK7I3AcQUc
         yG4g==
X-Forwarded-Encrypted: i=1; AJvYcCVby998GITunFQVIMrNCB77eirnlcmc/myidhiwGGpM09oIAGrn/cC9Pp1nzhmfHXJz21UbdnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoysTGsx2h1U9xt2zPtJdVmvQuRgXmYmuy29hNPmvGEh/104o
	ZKcVE8U7+7/pWQqWZe9EHHBZK9SvIZXa7yWEClbJfCAeLl3kAR3steTWXefN3547HeCWyRcunbe
	yJ6x6WclHyMCnfrc2uLMlkcoXt03/4jw=
X-Gm-Gg: AY/fxX5Iw18jDAMCli/z2yEQLieUMc7C/i0PHJVPYz22pX4iy30O7iwUv4HsNqk1E6/
	ojYvrzDondheBAwgGD59wB4h+POd867R46y4OQZFaVkQFuXohLgxUrX1bcIbTo8WdAR5Ob/E2nd
	uaidhizQcUozrLIjDL5kHCfOpDA+Xqr6klcXBkzYayxzB1nhj9dFFDQx9NUQ5kbMsvUwg8Gz5De
	Y9nZyTszIJGtTLhwBHzsfFjV4LJ/aQ4jpvE97dixhE5pTT7EbCwIU8lQG4GWUjPdO4Cyv9ER3nm
	Ub7snzgx0MpGeX0Z/daOmQ3c7mWM3yWjqEhO1rKT4LUa5xIvHlSTkTmSU6wpzivsAB+aapZF7tO
	YKuAerNNe/qrm
X-Google-Smtp-Source: AGHT+IFW2rQaG24jjJapMA2YCS5ndIcCTUrcLoVwM07bEOEYf1H++r47YjXTIrY1jYLwOX3qoKgMykSxPiszDmOKty4=
X-Received: by 2002:a05:7300:80cc:b0:2ae:5dd5:c178 with SMTP id
 5a478bee46e88-2b05eb787b8mr24225253eec.2.1767609602464; Mon, 05 Jan 2026
 02:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103143119.96095-1-mt@markoturk.info> <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org> <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info> <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org> <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
 <2026010520-quickness-humble-70db@gregkh>
In-Reply-To: <2026010520-quickness-humble-70db@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 5 Jan 2026 11:39:50 +0100
X-Gm-Features: AQt7F2oJSnCa_SxWh-jZOT4jqarKH-djdmAAEP18_oI9iQTalSPqljHbD4ecNRg
Message-ID: <CANiq72nrPiTmuFStm5fmOZZM8e_4TGHFyC_77+cSqPp8yC8nUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, sashal@kernel.org, Marko Turk <mt@markoturk.info>, 
	Dirk Behme <dirk.behme@gmail.com>, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:25=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> It all depends, sometimes we can handle file moves easily, sometimes we
> can not.
>
> But really, why is a comment typo being needed in stable kernels?

It isn't (well, it is not just a comment since it does end up in the
rendered docs, so it is a bit more "visible" than in a comment, and I
imagine some projects reasonably treat them as a fix, but still, it is
just a typo).

We discussed this years ago when I noticed a typo being picked up by
stable since I wondered why. On my side, I am happy either way -- what
I currently do is explicitly tag the ones that appear in docs. That
way you can decide on your side.

For the others (the ones in comments), I think it is not really worth
it to even figure out a Fixes: tag etc.

Of course, this is for trivial typos -- for something that e.g.
completely changes the requirements of a `# Safety` precondition the
story is different.

Cheers,
Miguel

