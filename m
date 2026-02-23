Return-Path: <stable+bounces-217780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGfHKtsnGmcGAQAu9opvQ
	(envelope-from <stable+bounces-217780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A11786FD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B0D30DB6F2
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB434D392;
	Mon, 23 Feb 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PfnHG04+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0C276038
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858782; cv=pass; b=B9XHfHASXwlxrK1iiKI+Cjjntg91zjM3j5A/wbepcqIcFIiHUQ1lPWXOYl9HZRm3wr0iOtv+vHqrbzRi1Gklm6JiIux6QPASFjN7Db9KxlKICzEQicTwM3wovqebO7G/jGf8qoVKO32hmVYjC9GmCWNSP9My1rt3/TksU2XDZRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858782; c=relaxed/simple;
	bh=Ua5ebazVPkVAaROdqBahoTBmr7z+xfRmyIun4rznWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2Mur/mB6JKlaWAN/m7aOhCoWK+PbEzXo/9J79U1hygHHY8hqjdFoVe9p5eehiY575UzBpBu5cBVrpJHMYE7tnCz4j8h/3MF2Dz5lFSK6BJlAsNVR1iA1kv84v9yCM+rsRTXexdcqbLPBNO8BcoaJ/KfIgkDn8E+x7EDKtuBtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PfnHG04+; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad617d5b80so26810155ad.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 06:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858780; cv=none;
        d=google.com; s=arc-20240605;
        b=NbB8QtMBHo0yqWGjhyhJ2K1PmUX8U3+DTZU+7bk8Qennula6mpDUFWUXdR1+K02XCn
         JdiVcT1XS/ANq0TdDS6e7m90jtTPJ53fWn9+CGhpvBHXu3uVr2z+GYcATOzutZb4yZLZ
         6ID8p3asVFuGmARa+C6IaDIWAF7wqCNbCuCDL1fDp8zkUp4ZDzBaQBQHlgvI242yvZnB
         KgEoEh1w4zacx/dFW/0QgB76oa9ZMou2weSTdBubmcwYAqALGy5ZwKq4RiyC+z9/ISwm
         S0gQ+wJKMny2JZQMGDhnT37tTXE0CelOCQsGBKZ4KN2lzDOsLYVLURoGSIO0eOmeJNir
         /2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        fh=rT2ycWvXrpzzbjCJpnZAaBPAo9V+BqGs9fOCzAZNMJQ=;
        b=I9l9AdgMiiYV9KgLy3HCJu65R9TnJaWpgbtG9nlG273eNO7atmEmpwiV0Pw53lGne3
         Dgzpzf1hWjDPuz45Q+7RTZ5E+DU4kuMntNOeiF4T2Ft1kxepGzCrHn/cMdxyJlHcYHWX
         HRmcGrvHsOdinhag4Fow0Smc3nKcTvN4QkXzchidNmlQezB3OnlM5xXo24PohFh+qFfq
         owWzbdXwRnYxSkoL4hPI+NiYpa6Be6LJvqfG8r9simh+TBaSU7QPNSlRWZ4WUVGRyYTc
         nfzrO4ke7peDozJ73pGTIl2L1OGAociXAOXacBH/o1c5sZKz41bh1Cj/a3aSQPn95KEa
         f5dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1771858780; x=1772463580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=PfnHG04+XUnWCp92qHHPIornNbkLV8rre0fZd5MujhQEJl2ndftjWe0RUiLXXNBZz7
         9zI55kcPuY/gnrNSm+aHDJsRy3nua32X01EgZJXd24oY+wYhOanPizHIQCR5R5GVJorn
         wrZ3Z3UX9F34LGKkHKGBAtZHdTOFuIQUkDqDjoHCqf5jJnrR9qo2gjW+A5xIGeLfxQhP
         bndT7JOOmrNad4HrmPyCEuniA/M93g6LtxNDP88uZ3RKqdi+ATI5ayzoX5djeawA4tv2
         xTG9lYg3Rdk7hmGUyvT0ZEZnJbHFBMtVDRxVyUejDH4smQCR+/0bv9BEYs73pnJsbjZO
         UXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858780; x=1772463580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=LGUtFVWEhfHI0P3K6lRPe9sP839hhli6lPbWTp+KOyujYX2Rb/I+kJ4JI7NwljNjZs
         wgMe6cWdAH0sOwXl4PgD6lrbsrKBzcUSJIRJmJJYbY0eie9U/NzwnROdS8UMX0p5kN4K
         9ZFaqG9gguTKLaKSjEH2Tk17loH9nDdhmrAJPVvyBrrQuXQhmgIuy9Nkm+/8SftA7USm
         mgOJ3qpkpBZAfGrwLmUSCNHrqsGyhfPXgH/0kfY+5pUFYTZTAGhzOn5LA7CsS+Ll7wm3
         A5/4qIO06S5eAX16wDv89ymWV7Dq/HxtKA/GqS3VlfXri0w07HRg/Vm2/+XSm/h/l86P
         Uw3g==
X-Forwarded-Encrypted: i=1; AJvYcCXd4+m5UwxZ1LsxZKj/XZmE2bVsCROgq84SrQukx6qok4nyDZ6fRHfZLUHrgBxXx0ManWxqhmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeV9c0/aSBIaw7Ltyhbtu7MjwtCKmIfQOCZOK+aP5vb3joIXe
	7DhvyZ+TU9PTPf8E8dp+5PHi9t/UtMzmMUD3d4tzcdA+Wdnp09vXcZg0PK36nh/ri1iWj+T7Mde
	N1GkXxzwe4vc1+wbbKjtS+aJzgvFvw6NCSsXfGMOE
X-Gm-Gg: ATEYQzxrkcF38U0tdVNSKTd3WrgX21JgEl0SsKzTTD0PFpS0HdalHYKqG7eDZ3BCleV
	/EYIR4YQP3KRsvki1OlpQqvRmpBnrYH/gJ5v5GTVN7F7CrOBmcXkftWI03aregAtUsUdZdwMDDe
	BizLlYI093wIulESABi94J89+Ap6/wX7itkHSNbYUrmHKvSFwvpaHdsZNQVlsZjNaMQVbHKMaxR
	dcR/vcm41DGJfagLUASALduDNoUBcQFxWe6Kdxn0WnzgkTzYgktg09xcGjSxyewMNTw1c4k+mNR
	e6Ae8ppLAKZs+y3u2NXHFiRronEbP4Ol+HeNP7vTlw+CqwKuvk258tsI7P/qtfabqkPRAjdgTLk
	hdI8X4hD2SS0wIrZkBNuLqpfFPMDFz/U=
X-Received: by 2002:a17:903:1210:b0:2aa:e6fa:2f67 with SMTP id
 d9443c01a7336-2ad74511a69mr96850605ad.29.1771858779863; Mon, 23 Feb 2026
 06:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com>
 <701de3f87f0f6bde97872dd0c5bf150bfc1f2713.camel@huaweicloud.com> <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
In-Reply-To: <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 23 Feb 2026 14:59:28 +0000
X-Gm-Features: AaiRm51Ex5szTVumxkie8rxUGv5c2Mexa2CnyFm86CE9yaxb63DUCIaTBGDvtsE
Message-ID: <CAGrbwDQgySNjK8K68PpWmKdhe0h7AuMeX78joqsC3bjiY=gyNA@mail.gmail.com>
Subject: Re: [PATCH v4] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217780-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arista.com:email,arista.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: 0A6A11786FD
X-Rspamd-Action: no action

Hi Roberto,

On Thu, Feb 19, 2026 at 8:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 16:20 +0100, Roberto Sassu wrote:
> > On Tue, 2026-01-27 at 15:03 +0000, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <dima@arista.com>
> > >
> > > ima_init_crypto() skips initializing ima_algo_array[i] if the algorit=
hm
> > > from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> > > It seems avoid adding the unsupported algorithm to ima_algo_array wil=
l
> > > break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip)=
.
> >
> > The patch looks good, although I didn't try yet myself.
> >
> > I would make the commit message slightly better, with a more fluid
> > explanation.
> >
> > ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> > HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> > are places relying on the algorithm to be valid because it is accessed
> > by hash_algo_name[].
> >
> > Thus solve the problem by creating a file name that does not depend on
> > the crypto algorithm to be initialized, ...
> >
> > Also print the template entry digest as populated by IMA.
> >
> > Something along these lines.
> >
> > Also, I have a preference for lower case instead of capital case for
> > the file name, given the other names.
>
> Hi Dmitry
>
> do you have time to make these small changes, so that we queue the
> patch for the next kernel?

I've just sent v5. Sorry for the delay =E2=80=94 I got busy with the local =
release bugs.

Thanks,
           Dmitry

