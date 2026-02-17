Return-Path: <stable+bounces-216893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEPpICDBlGkwHgIAu9opvQ
	(envelope-from <stable+bounces-216893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:27:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5E14FA2B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBEEC30460AE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4B37474B;
	Tue, 17 Feb 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZWOGmP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EE28C006
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356441; cv=pass; b=BI8Id00JTVyZ8fGjyQ6SodmTo+PwJcpNt4yCWUFFTxFba70xgeX3kaRHK0F6EZGjmZMoszs2mTX1J9ZILTcZWr4JLO66bj4q3uaPlUE3PQZ9E+/GbzL7nIEScMw4wVh/Tx4KXvCdB5rebtPVdPhgljv2oPAy5wgBm1POQyFfF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356441; c=relaxed/simple;
	bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIQtiLJGgbb43u+W/TAluR041J4kKrKwue1C8Iej+IqbHGKRj0xArakxUhLUWo/6uasl18cIyedtUCZ56kbXq5pTBuWdtDPBWFyhuQjs4fSAmIhc2TfHRyJRWhR18XzVktaMtEY3Q2Wkvzz82rCpB+pkiKshV5Orjqk2D7obyp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZWOGmP3; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so10305e9.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356439; cv=none;
        d=google.com; s=arc-20240605;
        b=DQvg4nEa4HOG35uhIKZAKGm77r2+cFmjSnjr6XXhB9YnXuj9TQaIZozq0+KgGTi9A0
         qz300w4+B/WAB/bhvcrMAadI4t04YoXoG46iqMfPQKn2fT4cwXNcfPHbsyOfV1p+PWLI
         AoxsHwFtYqN71waHG48p6oIa1bzs1PXwVcUdLqjKbyYY3pgDSOGbuQ5M9YL3/ggv19kV
         eukVwp6sW+G0JKXAYwUSZ0mRWAtOAB7qGpZuO9yAGU1esXg9ZLCdMJ0CnT0Fwbn+V1qT
         fvow1AIIb2LH0QVC20mjHNt7ifJbpz3CrEUXZsn1TxgRKmRLAx3WXY4A7zWjRXXnC+jn
         ofbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        fh=SYk8R/c+m2tg7jgBbWEZB2TShTmVfm1Iz8VQgZtdw6o=;
        b=SYstIeFt8KDttKLaCDoWjJ/Z3y2u1KQXazILUTFq+j4VzsOokBjlRrJQgQXa7KJhPr
         koR7I9T7UqK+sAQLk9PEQEN/Sfd0HaeHxToyVQf6kk94aBIiHEddowARHqSBUlh+++Yl
         KfbisMTTg4EiibofRp4BPgfAU+jMpfXHUbU1PFhQnzuPfCATBPkSpJvlBp5PC6tBROe/
         DZE8gsq/a9owykpT2n4H1J9ERaZLGhcJT8BzdDlUFues8I3KswodefQ4J/Q3L1Wguk2d
         KmSRfpqUU3hwbX6e+mym70GO+efmUD9qNDLnLehXfhCCx+Z1MZff+2T8QdbTro2KDjVH
         NGdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356439; x=1771961239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        b=2ZWOGmP3Lks6UZsCdh+O+V8lVRxDhQpbLt6FhmKX4Vox7lhbzmE/f0e5knQY11MGnr
         McXwwPJf0Bz8n+ocHbfniiksJHF5I0MYkpQu5Tq0YXLdlE41Bn7/NabFQrucua+ua5SD
         nfn37jYWvS7reusTwJMEWRIMFrprr8GP9voIyHJimwmPHT5JUNfViIj+xLV8Er+2M50/
         qWF64ZJR7/VHbzCaK9JruS4li3JI1NFvoADt9viV/z0xCkpUkjbQWYC9chnttXLp/on0
         +I3j0hNqasfMDo2Icmauz1pHc0eDRHLAMgn3GKXurk9CVmnTpqmq+xXkSfP5SuzRGlo2
         KmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356439; x=1771961239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        b=ieXV8xlNjusfFD0DzG111p0D2X48caf/ezBKF/3+i1m6uzK2tpR5hyRee895LkdAv8
         nn99ew3xJblAjDOJzpK4OJ/8JNJIoWJv6FsgCaOVwfuMbaoen+epfOHX5T0RFw9YskLk
         Wy9qIYYG4QLdmuGIHxaTiB0QF1MNXfWIiJk1t6PJSzoxxBgVkumj+ZB9gwwVA1lXReoV
         b57AR//fql8OQOm05t34ESLUuEL/kVVDytRcqfPSpG+DUiibR/jptlywVKZ8ashjcvgD
         UTisb4qSLqeQx0hpckAnDXDF4I7kaF+xllvwsx/EgYRz2gy3/DDqTtMz/fqIRcKXqOfG
         IGnA==
X-Gm-Message-State: AOJu0YyZpavbjnWdLp+1imHJ3uBP+Ktxf31PPWF0rbLnagLI6WZNv7lD
	iYQskjFIGHLeAIFN6oPW5Qw4PO32EQeXWU8Gh/N1SkTw5wUuYMMTQUkIwswQp91BO+gcwWcGpwf
	FjyfTla8/Zfvk+yFuk2ZKMh1JC+qYtYXoCd/rBR8J
X-Gm-Gg: AZuq6aKhEZPBpVK2ezKIYVX3O49zd1iDQ6w6mQ65LcvtfTUMtHb48axd+0OXJUtMUgr
	LdWN7m1u0VSQxmtRx14ZFPvytodgnUepb+vmn6bDpuMcKyzwB0f612lskk668FdTcktsIuAh34/
	TQQrkJC1ZQ/u4yTxL3fh35w3R8zsgDVP7ISySVm87/oJ2VrBiFdsDUvgNwcbYHYALv0qmslk+zo
	/IXk3A7BGYGZJ8824QRzhPWsAgUODzOlPCHi36/QBWCkt1o5G8RTwzHxi+Vg8pi0uxeleQxJQ3i
	Ybhr6TEfxqrQuuqkC/0mwd6RA5XExpiXNWs3+0EhQu8APsPhJ6y21Y+UtwD5Kk4gdPyL7w==
X-Received: by 2002:a05:600c:4796:b0:477:95a8:3803 with SMTP id
 5b1f17b1804b1-483888567damr911935e9.13.1771356438652; Tue, 17 Feb 2026
 11:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129191034.3181412-1-tjmercier@google.com>
 <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com> <xlebwk6u4a2uwxzexxwnhwldjtgcd5gl3srtciujayegoucweq@gx5ny36x3pu4>
In-Reply-To: <xlebwk6u4a2uwxzexxwnhwldjtgcd5gl3srtciujayegoucweq@gx5ny36x3pu4>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:27:06 -0800
X-Gm-Features: AaiRm53kYc0yFXkgJH_rl_IPVquZJsQt9DvtiwyTxn5fYzJdJ-aJEIuW6kYWF8g
Message-ID: <CABdmKX0zB=AnGBpGZGnHWGr2qHK=JpYoMVVVO2VexDXiBLWoTg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216893-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 44F5E14FA2B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:14=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jan 29, 2026 at 11:11:48AM -0800, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > On Thu, Jan 29, 2026 at 11:10=E2=80=AFAM T.J. Mercier <tjmercier@google=
.com> wrote:
> > >
> > > This fix patch is not upstream, and is applicable only to kernels 6.1=
0
> > > (where the cgroup_rstat_lock tracepoint was added) through 6.15 after
> > > which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> > > subsystem") reordered cgroup_rstat_flush as part of a new feature
> > > addition and inadvertently fixed this UAF.
> >
> > I am proposing we apply this one-off patch to stable rather than
> > backporting 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> > subsystem") and its fixes to 6.12.y.
>
> That's a performance optimization rework, IMO too big for stable.
>
> For the conservative stable-specific fixup:
>
> Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
>
> Thanks!

I forgot to thank you for your ack. So thanks Michal. :)

-T.J.

