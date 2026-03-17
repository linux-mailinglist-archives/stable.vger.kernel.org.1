Return-Path: <stable+bounces-226911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMjiHuTHuWl/NgIAu9opvQ
	(envelope-from <stable+bounces-226911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:30:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07AA2B2B44
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42E530B7717
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C08392822;
	Tue, 17 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlswbjuq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484A392818
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782836; cv=pass; b=JkHpBvEolcP9UdpF7zG45rFckCG9LVpljO4rnVv/meMHU8k9IuZPIXuHCwKMVVne5LRzcwHSdvvUpGcor2ifTwFy8Crz12hZglWZJfCuI7eLflrjH42V60ZwoZQiif8bEjaK9L2VOoVkCpPMNoOth9BFSy0Gt2LK352hBmmvT/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782836; c=relaxed/simple;
	bh=wGd+thudyV9Nv0l5oAVAN331H+viWPRkQfv3V3ltlVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USuactAnyHg9KQy8i1OXrDhnfkdzpla/uEab+F5l7AZzG5DRnYQWhajin3bP/q3/jXIZGgQvZwfsxywiajRKuzxqOrXHZhk/KBwQ3QtE+kSGDUTWPYZ3MtrXn2RCaadYid9BKyEk4v5fu2eTdBolO+/M152mkr5B8fgAIeusiMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlswbjuq; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6f21c2d81so621196785a.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773782832; cv=none;
        d=google.com; s=arc-20240605;
        b=ZE0PM5Fjot8dZNfMzrW2VUZNNI15G+/I2jwq72uz2I4bDiu/NfVF1JPuZmpAsMAmY4
         4aq6Pi0sFRPr5VZGmAwNEBBF/PitafYLmWvzPFO+fDimRrkmA/RSTxKAMLr5e8g0HV33
         ggQON5AYGrPahwfs49mmR/lMVeu3C2OkL4iYjnPwv5kfrjLDqj7pYA6mFPOnmi/kETnE
         JqIoCuV7v4wyuiebhjLmb+LQ00AUBN3oO5O7nIyNIiU1h1Jv8Rg3cdShHYETdOxfxHyO
         FX2+AJ1zBvy9bcq5+Wmx8RgBv6iQAs8hTLGT6Cx7hqFCFX4/smrtUqNCsNjEyVi3pfld
         OTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJn2bqD1oL1nPEOJJHpHZSbhMDi7B8umwU+fF6DGIU4=;
        fh=MHHqimSqCTzr/wBO5QzghpQkj1HRHdaZkEF5fbBQ40Q=;
        b=Pp5WwSLXz+iRNEBYrlFV6XV2qLPosoEOZzHa+3uMebr8R1LXIcCw2T0SzcJpq3deHY
         8HMRmZRQJSqEWN9hksXatgO7wUX/Ig+ZqooflwC+WPbJznMgn3AcFqLBcmN9B/cwz+jA
         pvXTX3lf21hWQSuskQ1FlWebODHFsKmMF4mm3VNw8ALrMnIQtArDh5oz4Ozn9xxFc3CH
         tUad2xRC5jsKbEHUw7J3WTPXoRIbSTZ0rKEj3C1k1eglO/EZktjMer3elw6ebdJkl1FQ
         8M6PN+N3Dknm879LMr2sKbxPsvesyK0fvMVGfCRI6f8kTXiVbdYeQkfRAethkkNtq814
         Udzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773782832; x=1774387632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJn2bqD1oL1nPEOJJHpHZSbhMDi7B8umwU+fF6DGIU4=;
        b=TlswbjuqlWcgMinNXf6X34agjZPdaPTsvDlhYTuE57y7F6BhRxhOdipFC09j9JfOQ7
         eLCvVFNSP27/g8QYHDKu14HCOk5B6KzeVrfJ+00hpTIJAZGK0nQzUbQaZxt0eoYDa8vM
         7inJMSvB1xWOh1jCeHCcwO/1qg2mXEJonUnX+TvLE8HjccgHLuazsH/GeCAUVzK15aYO
         km+jGZolDoe9t3uUKirvMuCHXjBrNM7rogBy1kka6xdKbCzgVnSKnnAxgEKh049rS7Qq
         lYExJUYaWy1D22wo/FD0+YuxY6B+4889qhXTLkw3cGKqJ+nqguOQwdQVmx+KUuaF8QXu
         s64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782832; x=1774387632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJn2bqD1oL1nPEOJJHpHZSbhMDi7B8umwU+fF6DGIU4=;
        b=CBbUUXo0PigTabWbGFh0XwFDM4vseYlSwTawYR7ljt64yTm2+VIyen7GxK0YY26kDW
         XDSdcXrbWIVajvj3kY7UOYOiQ6EOcM5jKOQusupBzPcAGFtWSB82l92qNLItt9uji2Hv
         OvIZxwBTWfuXnzKOgNG14r4kXH85KaQcUOBeoUIy5HFbwBsZwXu1ddTS54osAE8S9PBe
         QCU7rRo3gFB1xxk6dbyvM9GUbiBOeqVKs9kfJ5CkqCTNINo5KCXtgGcdV1YfO996clpv
         oleNjtEUsgK/l0AfhC+Jer3QhDwAuZmZUupIMO3cPbytjL+167OSskBY6vGaK5DirBu8
         kY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIxZC9hcWp7wtWMhl24QumtagwSdNtv+TZGN4oZToyepcgnWlZnuK/0pMO2mE44/HtpPrtors=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCZbX804uGhjXJ/ClVcKCzDBzAg3jrDABWtKPBqI7GC6jgl4L
	E7Y6geNt4045f8UKdCH1QTEjzykH04/Hh6cHgjXAvbqUsg3Yn6UK4qeJUB/hlbKofCnS9wsGhKh
	3wcYT+rxCZHaz1xFgdxGups+pDtPmKaLmDF/3
X-Gm-Gg: ATEYQzwLuNaHUAH71V8318vkXUWLmyapWDNbV3x/+UU9O4EtIsTRIcLsk99zXdQsvuN
	/6V4qzdMdz34W6KxTBqsp6SFYA2NyC5vmGRKjjKwqyfIoxusrZP5TfxqSL5nZNfrgtmMWyOngkb
	zZff5G0Qf6zs27+avu8TlvPSVMba+uq2+9N81HqtavEvabGj/VhUW/qe9knoOE7+kEKacpQZrkq
	EmXJ8E+27yskCUu2tg5+UouM1IupEfUz+tLsZaMwMt4EpH8KIkDdG7bUXeGyhnR+sVoJQRRz2sQ
	IqYf/Pb3IXZMjGtUHKm88pTExyyWNRx1F62aZ4J+rjOUBlF/LkPq9Nad+dwgncXWh9jdNgONH2d
	UIhsaKHsjOpgq5YxtggR7fHHGxerqnxDeb/7OmyCBAG+uSL9BvQvdAGU/dver4A==
X-Received: by 2002:a05:6214:590e:b0:899:f9f5:97a9 with SMTP id
 6a1803df08f44-89c6b58deb7mr18079006d6.37.1773782832437; Tue, 17 Mar 2026
 14:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317065253.1743552-1-werner@verivus.com> <435dda9f-93f5-41db-9d21-70371d31857b@chenxiaosong.com>
In-Reply-To: <435dda9f-93f5-41db-9d21-70371d31857b@chenxiaosong.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Mar 2026 16:27:00 -0500
X-Gm-Features: AaiRm505a8UyoMHPlnBXec4AZ4qil-1PSoZze-n4iJ1WCJq2H-I9vKg9CjSnNpE
Message-ID: <CAH2r5mvRpUJpXSgeQdQ_ssjz=skeFAFPKQ3u1YZ9Z1jtsjf87A@mail.gmail.com>
Subject: Re: [PATCH v3] ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: Werner Kasselman <werner@verivus.ai>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, 
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226911-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chenxiaosong.com:email,kylinos.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: E07AA2B2B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I see some AI review comments from Sashiko:
https://sashiko.dev/#/patchset/20260317065253.1743552-1-werner%40verivus.co=
m

On Tue, Mar 17, 2026 at 3:17=E2=80=AFAM ChenXiaoSong
<chenxiaosong@chenxiaosong.com> wrote:
>
> Looks good to me so far. Others can continue the review.
>
> Thanks,
> ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> On 3/17/26 14:52, Werner Kasselman wrote:
> > smb_grant_oplock() has two issues in the oplock publication sequence:
> >
> > 1) opinfo is linked into ci->m_op_list (via opinfo_add) before
> >     add_lease_global_list() is called.  If add_lease_global_list()
> >     fails (kmalloc returns NULL), the error path frees the opinfo
> >     via __free_opinfo() while it is still linked in ci->m_op_list.
> >     Concurrent m_op_list readers (opinfo_get_list, or direct iteration
> >     in smb_break_all_levII_oplock) dereference the freed node.
> >
> > 2) opinfo->o_fp is assigned after add_lease_global_list() publishes
> >     the opinfo on the global lease list.  A concurrent
> >     find_same_lease_key() can walk the lease list and dereference
> >     opinfo->o_fp->f_ci while o_fp is still NULL.
> >
> > Fix by restructuring the publication sequence to eliminate post-publish
> > failure:
> >
> > - Set opinfo->o_fp before any list publication (fixes NULL deref).
> > - Preallocate lease_table via alloc_lease_table() before opinfo_add()
> >    so add_lease_global_list() becomes infallible after publication.
> > - Keep the original m_op_list publication order (opinfo_add before
> >    lease list) so concurrent opens via same_client_has_lease() and
> >    opinfo_get_list() still see the in-flight grant.
> > - Use opinfo_put() instead of __free_opinfo() on err_out so that
> >    the RCU-deferred free path is used.
> >
> > This also requires splitting add_lease_global_list() to take a
> > preallocated lease_table and changing its return type from int to void,
> > since it can no longer fail.
> >
> > Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> > Fixes: 1dfd062caa16 ("ksmbd: fix use-after-free by using call_rcu() for=
 oplock_info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Werner Kasselman <werner@verivus.com>



--=20
Thanks,

Steve

