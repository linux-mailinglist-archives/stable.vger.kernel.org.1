Return-Path: <stable+bounces-219680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHO0IGs5n2m5ZQQAu9opvQ
	(envelope-from <stable+bounces-219680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:03:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D976119BF6D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 168F6312C0B6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D182C15BA;
	Wed, 25 Feb 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NFDbDlxS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3912DF717
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042447; cv=pass; b=eNnKBJergjbKhST8Sna1aF4OVNOISrGLPXhUvjrmAYesHnYGqErke9PAhmU6Wwb9bOM6D3eqAXfnV9cFNc5G3RAZfUVgYUE9ltfE7NQbhFfnvjEL8chPAuB9HhKYmQk+ggkpTnW7szbLwbZWd2uv2KqnIfcDygfUAuoLhH/7h1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042447; c=relaxed/simple;
	bh=ezrs28hh800Wrad6rqosq13WMeXBTafZNVMfGZxxrPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKb23MSD+Gbx0Lwv4MlF56yBrYj4nfvoboxIZ6P/TfGrzUbXe5EhOOf/rFAkHOotsh+zKkC2+NJbTSMP0WhWUN0e8DwDeh1A7dB9upuILJSNACajgHhAGJG9tsYF5ssx+dtAh1yuD2slDCtwcKpH9kTH/FVbzaSVEnj8WWnjcnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NFDbDlxS; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad617d5b80so44459705ad.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042445; cv=none;
        d=google.com; s=arc-20240605;
        b=B2nYlOJ9u2nHUyQEw7sb0zdPYhIJBkFyIORZBGr7alcs1cNxWQm0n5FGatxY/z4QbR
         Ia77IS0kIdOwGBqc1KZpTHTtqD7nhxbXrpzhta/00Z3Gqs4KKiSd0A6SH75d7HRJntRN
         F62gc7TdLC5vD+wnLoBhpHRGD1PJtJqdgJDjD3BdD0X7qkwfSXS51QKv0tBeOTd5oKkx
         1BLaBpTnS61kLUQNtsGxgqMWKGPxEwRT3ouP2NOhsitzo/v9DNvDC6BW074RHZUd0H3e
         +XwBX+Dkuy3/qgouSzKu8dkLlXxOwX9g0bsJ02mJB+VXENojI6gqmKY43nXWEuiynrvT
         gVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        fh=WEEA8VVBfjg1Tn0RDNw89uK3zvYd/Cj0iBeZkZXy0tI=;
        b=QWuTpoC+YtTRGy8OrwU7/Hqfm1Gw02XQ4e8Bc08sDpCrePIKtonz4VYRJKvtGduOt0
         /1o3WcJcXa/rAoNkHSBnBEj5XI8PIxon3nSG16u+7iFiFIs0jVqJhgOaxB3pwvIRJ7rk
         wsulf80AZgZJxHaMbYAUfOvE/zUTLPQhXHlvhCCQot9TzB8d2mJdHhnb9Ne/wyKOstCK
         dDCQoZ9ZBKxP0IoOKodUjN2deiz8skHpzCp2tSjXQowk8ftydNQ3LX+trESglpeOepob
         jVj5k9r0hk6dbX1WVY6MvsIl3//Srtr7N59Ife3JFbrRNmvKPN5AQ/mxscIzfeVOBXmk
         V3hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1772042445; x=1772647245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=NFDbDlxSchreCFA4REu5sfMZ42uB0CaSJZwym2B2f50pfwhGNXTkGUb4PqUXjK23km
         55rxRAMwMD/NQ9xEmOADEXNr+1otfMj353teENNrKaC9NxPJuJbh9mGCZRRJX7tx/uYU
         IcfrP4gI+j10pyNC2u6KuhjzLjXpU8jtcZofjpsemTJkJF45bwWyHeIq+rX4HJp/VgMJ
         Khnzz2oDTHvYevWSNGZh5krarObAwnMIp5FhNBlnAe+D5WuFU4J2j+btYH76tvy/RNtm
         KqEhrCM63QjjRt+guPxF3m4fSWvlCat1gG/AjDmspcNfBuR5m8u+krLmPvVbeGn1WpET
         ZC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042445; x=1772647245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=RTSHD5nVKqODmbJl7mmtR1UnZ1eWfVgA0VB20W6NNknJ+d3B3RnNotLOM31XTYuOiV
         rbZFpzbs3C9bCDUbpqO8Bvm9kEZA37iSzRbRtFvoNvU0zO5qp0zYoTAFj3mf83LU+Grg
         3rQOBWY1LHBLIDoZX2JksHGhrAeOgtv9ZOnfody9J+vA933HpexAn8s1qp+tvebfLBfl
         x7NLZwJM61yzuY7TfbpTWrmCQUmYQ8Jz1DzxHmhzD//1HX1mpdK6DbEv7UXoC1Wd5BHy
         PFL65K8KnHlj8jvTDLEhKrG2yO9zVgDNxyBfguuD+ApzlvDIo8VbIPpZhEB9NN+Vai9M
         lFXg==
X-Forwarded-Encrypted: i=1; AJvYcCX1PR8QTG52pigiQqOBCKY/W0lVIVoX0IPTz8Ilb0XlKLiuc6/SA2teggO6U4+PBvx0uBnZvRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0XwSEp6ZRAwxo2G5tHMuROkIFGRNHKC9o6cf4K9F1Sn9JHod
	TGREaApjGHeC5JyeSusZPWSH2MH5Ww251p4M+hr2uKaQVGCDmlaSOnMVTmEW+Eye4erXvaNBWI3
	mIW+6jxDBCqquh+gEcKauRgKMY1qbgf0X2EykhEwi
X-Gm-Gg: ATEYQzwglAtwsprSP3n8EF3BEFgStGxCYwPijukO8m5shOB/hsIo86hEjD1dtKZjhwv
	MkaYHbwbKkrffsMS9MrwedmaesyffwEKBgU/2gbLjoyQ9EWIYAs9jMMDSmsQrf9vwM19HeSoc73
	mbc8H089aVkDqWui9dyYNtKQQ9OAQVtXdfMoZ5CtScZm+XXWbBjIoSsCY1Dj3+Ig5W8j+A+vhFg
	yzUr8GUQPQbsZTPUEn7eKtpNLKSfmVedtlrC3O2HXLjiVXbJzH9nZ2ceqAtmqHUNABG0LgkCISP
	oiGxIzbp8MGaIUM0rW5LfMVwEB8G5XAE9d/kVRr5sHcOtaI5Fd2G4RRkJxTfHp+9mrmlZMLguz7
	Iqr46pSovs9DqtTAJSWiUi+o7kQm2GRea
X-Received: by 2002:a17:903:1b6e:b0:2a9:6165:6e88 with SMTP id
 d9443c01a7336-2ad742b4ddemr145518575ad.0.1772042444923; Wed, 25 Feb 2026
 10:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com> <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
In-Reply-To: <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 25 Feb 2026 18:00:33 +0000
X-Gm-Features: AaiRm50Ofcel8xIk3XALa1jfjwmSOSuMPTyZWqkq20mhBhxlK5tUNoc9kdl48mw
Message-ID: <CAGrbwDQC_jp0iYtpW5JUMqEkJPZ01O4iL6zhyMgWQxXcfrc-nA@mail.gmail.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, Jonathan McDowell <noodles@earth.li>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219680-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,earth.li,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marc.info:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D976119BF6D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:20=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> > @@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_f=
ile *m, void *v)
> >       seq_printf(m, "%2d ", e->pcr);
> >
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     ima_print_digest(m, e->digests[algo_idx].digest,
> > +                      ima_tpm_chip->allocated_banks[algo_idx].digest_s=
ize);
>
> Sorry, I realized that this does not work if SHA1 or the default hash
> algorithm are not among allocated PCR banks.
>
> I just sent a patch to correctly determine the digest size:
>
> https://marc.info/?l=3Dlinux-integrity&m=3D177202677128752&w=3D2
>
> and applied yours on top of that (if it is fine for you):
>
> https://github.com/linux-integrity/linux/commit/6efbd2b38b102ecbadc350228=
cc30fd67666a089
>

Thanks!
            Dmitry

