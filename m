Return-Path: <stable+bounces-253420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHYiHt1aDmo4+AUAu9opvQ
	(envelope-from <stable+bounces-253420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:07:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631F59D853
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E00F301FA9A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354E2C11D6;
	Thu, 21 May 2026 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avOEfJQk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D02C21DF
	for <stable@vger.kernel.org>; Thu, 21 May 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325657; cv=pass; b=nhaXGmaPsrCpQLSRAG9YunuNxaDXjWNl80HmgWIIcT8PRnRK6Wap1pJm/V6oQcLUNdoTsoXWQb1ZVzN9A6EGWKzFk+cxGOrCQMSOGZcdA8M7YmbKE2yTCv+AE9yH8XGH7L9LOWrbWLFEZ1QGcDryiA2a/0c8uJGw1ZtoxYz3Vi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325657; c=relaxed/simple;
	bh=6o6OhfFgqhvs6+Xg2vngq/GiNQmqcRy4IaSDQZXFPoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmmabtTW3o2H8C1HZEaCIM4Uy+1RAhXIjUD5kawxs/4O8b9BzoDCA5HopQBC3d9MKFNpYc0IE4U5HnofBw0IYB4vOcKkJUO/rV/CWvfzXTLgEXQtYesrEyfG5y237GnEiYLdlcyItkednrCTkb1G7ajHLKGbz9na61z6JHP23s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avOEfJQk; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bf0b47d2f1so48769217b3.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 18:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325655; cv=none;
        d=google.com; s=arc-20240605;
        b=aODv4YUKLrn6ZVGDqotBToL1QN1xc1Y8m8jzNTrk/LmJ5ReQ9tXFeNvoWyAgZvo+i9
         8+qiFr84pOQW1tM45tRF6ZgY5tF+AhOUFLIP3B2zOdKD5ufxaEZwAcV0/uL9fKSJaevD
         S27bA3HCbPQZRLEYLJ5smUnFDah1VFTwUydTo7w9uvgCwO+0UPHelW/fmEPk6f6hvRk6
         5WqpcpfOcKVXL7TeOC7QHjJyiID4Ks1wWXpkZMyHBWR3WToPmZ64XfoxsF5+snTweMc3
         2dvBB9fpC7UiwPJKx+DabTXPN76rraL9Pp+CF4nEOa3Oqf8O3nHARMeKDzzW73GHZLgG
         7sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        fh=ImFMhtfOJmtAdNm7I0qqwCqxHGjPOTFhdLAmMj0J4Lw=;
        b=Lqoo6+OkyboPzX6J1VW0AbBMvZ67yywzD0cCT/OE0IW7d8pTF+OMdq6jg7fQS6yZHD
         8bGpAEWNXmpcYvKSqOofTB23V8Z69XNfbT5BLryNt3U3FAbQgv/bys0MI5HWLAqaCvsN
         Y7UFETgEjb46e4ikLpKirpR8aonAtv7k2WK1rMw5JR+pS9DZJgzoKEGA723TtOSo1N1G
         EKMH4tnrtkV3Ha1yEkF2T66rs3CwcInS3O5YmTWZDIMm3HOAtFSU7eZV6xEXsz8wQnHm
         h11Llnv7f7Lhml+GnViUsuctqhYCa8I8ZIDSFcII2Lt5w5IZK0L2R06rQZYy/kzXwPyZ
         2aqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325655; x=1779930455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        b=avOEfJQk9XPK2nssdDJ5nZCRUosqu0jqYFCpAwPRnWl0C12aO1jsWg708ei2jymQB/
         +pKxukhxaH+rBE5ZT8hiVaah38/9ReQPspWVqX1BgUoJOsQbpehJOQbQRFOM3BqwLpgw
         sbYtFGcsVg7tXjTSwukM4dIYa6c2QJnGx8wezwh+LLrnlGZgY2IhdyMKIkmbztm6J6bh
         i2nXsAIbVOSsFrqvPAf4cc4uCmsCeM8FWFO9sKdam9G3pRFOy94brZx6DL9nt/M/0Wcs
         Oio1Ln7nnYK4RRT6rUv4yk2kNBO/hsi40w33xg2PCtwd0N5Mn9WANJBGe1HtFpAla8Eg
         NtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325655; x=1779930455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        b=Br9jObg/6srum7R/bb4o0eFeyOkfeu2EgL3e40Q0rQQbNdOPhUPCgdl9UhKKV4M1rm
         MEy3mWv3aX4eIjoH6iy7EY9a0KE5dzjwHqjst7mviHZtIONek6G8J4/kkLYAYZOu54hA
         PRloOwaMCpW3YyV0AA8xx3G7sXVnl0jqzo10SXvfBs7ZeTJA0ywuPmlRclCtU/bOrT6i
         NpyEY1Ri2Ty0paPSteR0e/4XTgAzGNUVvzVA94DfE/Ubq+obFQC5DffbKOChQNj3qM+2
         cRA7dABSngJ5aWO/587oRaMnwJi0nUmALZPflG1IqiGx1zzNKS/hWuZcsB1dzp+N0RoX
         BP4g==
X-Forwarded-Encrypted: i=1; AFNElJ/KQxSAlv41u7p87p3sUdHgYWXa11hI9SjjF9it79vQdsA/txzajlmUpsvJWvLqBAys73N83BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTU4UQ1grK1FQXmnozLrO7bm3TkDvu/sdhtVkiNAVBOt9W/ri
	P7OtBT03TcmE4g/5UBKvp6H6vgKwy+o4b96NrCTKnkoUvlnoQ7Rafbk9PxVKMvblWt5SFXUwdil
	duwq3wmS02i6oY9l4v/fbmJCKOQMu93o=
X-Gm-Gg: Acq92OG/EiruuHzEHfDiZlhtrZcrIYzKE5JnYNqQESIQg8GvWgmBJQvbTsbFWtsLBcG
	OaiQXZc/qO0CK2j4d2f7U7p+HQYaecxpM2kQ10ahi+kvem+BLISqVM/pM/SkDVSolkNk593rFf5
	Y57/TtHsRjGZIXFn9K5BtAYY1FNcxZS9CdmTYxBF1Ub4M4ACdaNbQmRTF4VgkNfdX33JneNAxMu
	hT6/gLuJ4OE/xci4l96mVy1bZQuX00UNA3oXZmZQ6vaqyMiV2tXl127yJIkWMb9sfrJbETmstkH
	7L+T/Y6ql3N0MwaDgZ5InF7Ra3+Xs6HL9ZVmcb6EFYiWuaePhyz66v61Zg==
X-Received: by 2002:a05:690c:23c3:b0:7b7:1753:1bd5 with SMTP id
 00721157ae682-7d20a2bd737mr9515747b3.7.1779325655215; Wed, 20 May 2026
 18:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519113017.1851462-1-michael.bommarito@gmail.com> <6176a49943969a3948b21bfa98c98aa69c0b6c16.camel@ibm.com>
In-Reply-To: <6176a49943969a3948b21bfa98c98aa69c0b6c16.camel@ibm.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 21:07:24 -0400
X-Gm-Features: AVHnY4JjLe5tM-z0l0ct9MDwLv5s0xybADAO1684DUHRrmgfjftmm_3pCPqfb04
Message-ID: <CAJJ9bXzUcYt5hT8ejxbFW0QwwHdQS=N_RmG8ZnU07=E2_L_P1g@mail.gmail.com>
Subject: Re: [PATCH] ceph: bound num_split_inos and num_split_realms in ceph_handle_snap()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1631F59D853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 3:47=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> I am not completely sure that it's good to mention it. Do we have final p=
olicy
> accepted?

Yup, it's now required to disclose:
https://docs.kernel.org/process/coding-assistants.html

> We introduced the self-tests recently. And you are welcomed to add KUnit =
based
> unit-tests.

My bad.  I can add one with a patch set in v2.

> I don't where patch uses i variable. What is the point of this change?
> ...
> I am not sure that we really need Claude AI generated comment here. Maybe=
, some
> short comment is written by human being makes sense. But, currently, I pr=
efer
> completely remove this comment.

Sure, agree.

> > +     split_inos_bytes   =3D array_size(num_split_inos,   sizeof(u64));
>
> What is the point of this alignment? Claude AI like this? Please, double =
check
> the generated code and follow to Linux kernel style. Have you run the
> checkpatch.pl script for the patch?
>

That's all my whitespace, not Claude :)

And checkpatch.pl does ret 0 with no warnings/errors.  But you're
right that it's not house style, I'll fix it.

>
> Could it be possible that split_inos_bytes or split_realms_bytes are less=
er than
> SIZE_MAX but we still could have overflow?
>
> > +         check_add_overflow(split_inos_bytes, split_realms_bytes,
> > +                            &split_bytes) ||
>
> All this check looks like a good candidate for static inline function.
>
> > +         (size_t)(e - p) < split_bytes)
>
> The whole check looks complicated and confusing. It's really easy to miss
> something in the logic. I believe that this code requires some refactorin=
g. I am
> not very like the pattern of calculating the split_bytes in the previous
> condition check.
>
> What about this?
>
>   split_bytes =3D size_add(split_inos_bytes, split_realms_bytes);
>   if (split_bytes =3D=3D SIZE_MAX || (size_t)(e - p) < split_bytes)
>       goto bad;

Yours does looks more intuitive.  I'll refactor those and inline the
check in v2 tomorrow morning.

Thanks,
Mike

