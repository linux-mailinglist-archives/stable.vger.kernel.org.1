Return-Path: <stable+bounces-273438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RzqMDSGjUmo4RwMAu9opvQ
	(envelope-from <stable+bounces-273438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 22:10:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF2742C8B
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 22:10:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hfFHLuXu;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273438-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273438-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235B430128FB
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE33002CF;
	Sat, 11 Jul 2026 20:10:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D62F99B8
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 20:10:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800605; cv=pass; b=MBQ7xig695qyvYT1dO1yaHe+E403336E2jm1eo+lKb08QAZ+BYjLrFYtuMAq4gi0dIKI5saBRlHk8WZvSpWfqj5sQ+4S3E4t9ZqZfH8ujMKDZ3kd48G9K2tThKfZRRHiSk0ay/3/51IPUbJ6vS03DRtDlg9LsEF1JNmVn9GPjW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800605; c=relaxed/simple;
	bh=LSX0EQVM7DWr8F8pNcgugxSXwHXI/IUJle8xMwl+QgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbR5xAM/HKklKHkQDByaCXcrC7iJXIZMRtYRNhKB6qP45Dv5D0g6OTwOhFigGf7HCSkOc/nDOASiNUs5aAAimToMOc3Dz5mRfAX7lrKhiibbu9ZvZMgFWgvsXKIaFPdygwcy4Qpds6+ipzheehON1bWf68xi42seFHqSD6iHmYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfFHLuXu; arc=pass smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80814edb536so28698247b3.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 13:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783800603; cv=none;
        d=google.com; s=arc-20260327;
        b=Js4xvqFO4O/FwexosH4CjsTQkBP23Sx3zw44G2ykC1inJT1m00JFTD/itBI37hJJ47
         QHbr5ro6V6U0epeRGINRLmeuVr5xC85KWPzAFchSOA5zTYCqC2+Shs5533okvnt1F7J7
         QdyxJ+i6FiHjVIbyfbrzq7NbU3PVTecw5liw+Vzr6t7M1hgeAOrgS6f3wVp4WxuUcmSx
         wA2dS2pymqEf4/CxscsZ7quieVR6S9s9CZ26L79LLFwYG45zlFGAl6u1R5qiQpt0IRSH
         1TSkAvvtY2ibCE7lxbfTwOME+sHG2DQCMAwliYDJKSXCe/EkYbriAQUSw3D52fyThKVN
         bzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z2uP4vcgqtoDKuySsmaaAAQwDgg0HuQELevsl/jkD/k=;
        fh=aFNJjw4eNz+/5DMLnmjHH+Zd7M4fBxy6JriSIwILZJE=;
        b=Bd9jh1xujpTvcqAPBQz1i++XLxViqaoEYhrZRHTuC/EfZdF6RIbn6zAwh0cNlWGQgk
         CxgoC0BzMCtHWtTcBUFSBafzbTwiO/PGu7B5PSUIN9wrQh877Uk4dGcOOtC+MxPI5c6v
         zUljIcqzg4BeByeXhXQTfyFos0ND6MzYDgMIfUnGgTVHPk0QWFP9FzaU5aD1X2pl0FjA
         WuCfJLWiEGOrVbpZwWyJsBbv2sqne0ygLjhXp9r1Vz2ryrh6oeb3fa7t0AN78zgCmoS2
         9SxrmVAg/0GE1jUVyL8VvYcQwG5lc2tCshG1YCvUbLNqWteAuTHpze1ufIV1QthXkubC
         hcfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783800603; x=1784405403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z2uP4vcgqtoDKuySsmaaAAQwDgg0HuQELevsl/jkD/k=;
        b=hfFHLuXu8Tbwjz7rks+20FRfyYdd1YKuHZzl+CrnG6KDRnhJXcntoU/B3CI3qwpotr
         CmhkllMDCuUS0XgAtnVWzVdfa/05QxjuTT/lMPjZrUNWY+nJocmFPFpi+TZgUKrkKqNE
         c2VivMxxuWtV+/X8MfZtXpjadSADGqDrYxBvb0pR8H9ekgvzwbSSzhYucOmzu8mo6ByT
         TGCB5z+/+rTBAEEqFqIB4S8gj9kLFge3KkUbZTZ0mDXrhMZlklSFLhcBePDmIhljNmKH
         I+zkYS4czuoamt0Q3BeObYrlwmQbwJfQ7hGGz/7v5wtZv2XEDVz9sD+aHQlSEv44x9DJ
         gWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783800603; x=1784405403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2uP4vcgqtoDKuySsmaaAAQwDgg0HuQELevsl/jkD/k=;
        b=KRnGS3AVBS9831oNMo9DVCAK0k7HWGcbCKjf+WxvZtddiRML7fiGI+VR748dnLGorf
         h0xHO+7MBVAA2744gxPkOSGd3TK1Du33K5o5Y9myL45UfwFetW7Z0Vlcx6m3WLIH7tlD
         5BmS/w3HBAAiaV+uaqwq7tovZSjKZ56dbZmvrc5FkYy/cYtREscm4HjV55wvXsOmi82b
         u7LuGULZ6t7yty8h8SDfGMVYYxbQKK4vuecoLWVE4YwRb6WArLJOjZDf2odqpPwllQxE
         0Vpxb1fhCn87iyQqPyr/9kIzmjI9ckuRUyzt+9ZQWPyMEHmXmeLW9rHMn8wuc51aYIBc
         /n3Q==
X-Gm-Message-State: AOJu0YzYHzknHqX8WZAbtC7BplIMukjiMn/8rZPJZB8vnsrPYxxBrlgD
	jANMplUl2UHb4KG6MME5kIHMA6hxYOcLQrhcjEPXyNzCAPy4nvfNSDBHFIetlmM8TrmMWTKukKD
	yFABfyvdRi6jGQtFMq3+AMdBpcmJof9k=
X-Gm-Gg: AfdE7ck+wN0WOBZqX5594ZUWgar+9/SScWPTeNyFUlsR7cwGBBhPYJShS0a3Y/8y2SG
	JQHtNYlb1GS3KparRBKeQpWwIbqi6XQih8HeMswammzOwfVwPHarlDvlnSneTZjG3AeCH/0J9m+
	6QHSraa0lCS1Zhj6H0/RdN6IsoTd7yFo3iHO3l70fyTh6BjolrpxPDeqiAZ6yyWWi7BTyA4jv6g
	dqdeYOlFBJPhB3sNTjM3ToEhE7teJ07hZgYVPr6wPqS0GTxuj04Mo9JdLUqvTDWFhqAiwS5wsEk
	XWlqGW2iK69uF4AlPrFYWUWN4nsFMGNc+4qv
X-Received: by 2002:a05:690c:6901:b0:80c:85c6:897a with SMTP id
 00721157ae682-81e9016acf7mr26630617b3.57.1783800603397; Sat, 11 Jul 2026
 13:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710023142.3748810-1-michael.bommarito@gmail.com> <alDWUmORy7fTnorX@mit.edu>
In-Reply-To: <alDWUmORy7fTnorX@mit.edu>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 16:09:51 -0400
X-Gm-Features: AVVi8Cfy5oAizepBmVd2eee5DuIa6zdF4xgDku5kOy5Jz70xwawi0RaemcoCo8E
Message-ID: <CAJJ9bXzXfQuJ0+LrHbEjBvMR9X+WSYBzeZJFKBt+0HitNE6=CA@mail.gmail.com>
Subject: Re: Please consider 83f99de1b7c0 ("ext2: fix race between setxattr
 and write back") for 5.10.y, 5.15.y, and 6.1.y
To: Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273438-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78BF2742C8B

On Fri, Jul 10, 2026 at 7:28=E2=80=AFAM Theodore Tso <tytso@mit.edu> wrote:
> I invite you to figure out a way to figure out an AI mediated tool
> that can attempt the backport, and then run the moral equivalent of
> "gce-xfstests -c ext4.all -g auto" to verify that the backport doesn't
> result in any regressions.  (Some previous attempts to backport to
> older LTS kernels have resulted in the kernels crashing as a result.)

OK, done.  The whole set of scripts and results are in a GH gist at
[1] but the most important part is the subset of relevant fstests (see
ext2-testset.txt in [1]).  Everything was green against the targets I
listed.

branch   variant   pass  fail  notrun  timeout  dmesg   failures
5.10.y   stock       40     0      27        0  clean   -
5.10.y   patched     39     0      27        1  clean   -
5.15.y   stock       39     1      26        1  clean   generic/607
5.15.y   patched     39     1      26        1  clean   generic/607
6.1.y    stock       27     1      38        1  clean   generic/607
6.1.y    patched     27     1      38        1  clean   generic/607

Regression =3D a test that passes on stock but fails on patched.
  5.10.y: NO NEW FAILURES
  5.15.y: NO NEW FAILURES
  6.1.y : NO NEW FAILURES
OVERALL: PASS. The backport introduces no regressions in the ext2 surface.

If you think I missed any tests or you want to add a fuzzer/syzkaller,
lemme know.

[1] https://gist.github.com/mjbommar/c8ec6b6025d054e453625a06806459fc

Thanks,
Mike

