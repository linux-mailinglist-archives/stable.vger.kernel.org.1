Return-Path: <stable+bounces-268255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +64AJrmjPGoJqAgAu9opvQ
	(envelope-from <stable+bounces-268255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 05:42:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39096C29B3
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 05:42:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ON4r6+gW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268255-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268255-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA22D3020D6F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27F235C01;
	Thu, 25 Jun 2026 03:42:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC29176238
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:42:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358967; cv=pass; b=BvHNjG60Cva4Q3Txtaci9gZho5fXZPlmIrxTSaKygoQksA/8QAPEDTg1dLlmoIFrsiAO27PBE6ptwBJ7jBBwAqvA+1yviP5tbRy02YjHxYek38/xJBj+UFpkXCVzqpTviFXkIALTLDefch4vz0SrImRRxU/Fw5wovZqBvTKVpts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358967; c=relaxed/simple;
	bh=kHDiEmKDetNI8Z32pwvyr1SW6dqtsj2Q0/SP3U1mtYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXspQSYgL3rRJYhkZ8kXUF6ylMjlsa6729uz+kod7fB53GvjIi7tO34V9CMxKpn8PtrHAwq9XwwUgM5wQiGE+0ucF4FHYnsetN56Is50bPRokb4p7GUbOloQNCwNgzAjcA/iyPmQ0WYEeUoxucvoSpEk/s+JRR7YuDNyvT4JmnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON4r6+gW; arc=pass smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec450b950dso336615366b.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 20:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782358964; cv=none;
        d=google.com; s=arc-20260327;
        b=KTX6sdirblOCIpHbFcW6B5PMWzr0GpHD+oXdgCcnH7WXlYewksmkllTQP5nvkYKEyu
         9HmGILMsV1CTqWzVugRz5pmmKwIxVWG7kgSzto9X6PdYO91VvrowuVY6x2WTjq5zpDVJ
         asCSb/2634cfVcuR+jnFtA/eb1Sa1sqDz5Sq0WrOZAQ1RtKJLZcrsaLi/tbQ/tDL0rYK
         /D6AxY8OXQnk0sJXMK5uVU9kpeWtBMgLFZV59mz1RTE7qtYvdJ1foIpVTrhj56xWgs/K
         Xebu74HYgXSJ0KjG+1Y4IwmFJqKY/BMpFD9w3YU7naiPIijy4XBE3Vm+MhpXIusQZyhX
         lDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kHDiEmKDetNI8Z32pwvyr1SW6dqtsj2Q0/SP3U1mtYk=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=QrmypbQdcEar24g60o1DHclFaP10kKZPb6eC98N1wB64G/I4KJoBjPqPJk1Yvb4gG2
         g6+4pdKR2HJvWfjfYyWrGLlSl9pgK6UbQubWlp09dp5xhZQaa2G65ogX72nQoN1VWFU4
         kwsTQpVYejSV+kkJOQtsBouW3NWNzYw0olbz0cVnZTffnGPWVCXwcnkv7dmyiw6k5kO2
         Ph3pYTpnqZ+hcBDqdEB7Et97mZKCIv3Wpt6B8LXFFBeYH0E/8HxsmXomX9GzWFYVQkPE
         YRG4lbYN/oA+S7IJmd+ziVDecS0BVCuTQd+VWGkiMAfVJrvioG6ah2uTMR6YvUHadH/t
         sRZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782358964; x=1782963764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHDiEmKDetNI8Z32pwvyr1SW6dqtsj2Q0/SP3U1mtYk=;
        b=ON4r6+gWOvB5NvBBU+kXr/hUA7sLXBCThwp+zsW2dArf3Ty33JtVgz3ZKXbrnJjTJ8
         xfFOsCkOG7yxW6MiVHFeFZFhNeoTk3+ePwwhQxf8HSgKxtVQVVzBVI+7jt7Lxeydp4Z9
         uyszKwxFsKor1LqO2QIB+MIPxYxhYgWyLG+vfmiwwt8uyLOimaJvvt0LpUPoUX6TxAqP
         aPwFzmgE9c4Zm7TWE7cxFX6IuDeqFpoGJEpW+/Y7YXYagYcywy3UBQmXN5DLb0DIcBO2
         aQZw5BszYkeuN8yUA47uLZfGV/3lHYQgz3F+6ena+4/AiXFRudzcD7kJZauc/kkjsCqh
         KubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782358964; x=1782963764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHDiEmKDetNI8Z32pwvyr1SW6dqtsj2Q0/SP3U1mtYk=;
        b=rBOaUZcIndK3Jzcba3f+0bsUUuqQZBPl79XK7AqmWiUctBN7cQ+LdOmZvKMJlqVLY8
         hd2CxE26ShhrnAUhESJ+WfnrRYhE0DKvLackOSJzNmQn69Lc74ui2uWG5r0G4o5rPbYW
         kdG8nu2SHJRsFn/X7D/P0IUZGAlRcxmnO9sZBtbmvPdVWNi2WArYG/5drNK2805L/wS4
         P33iWzXZtTj4i1bZhY2HkYuzB6k4luYuFL16g0ehf19R/gxoF5TgFukkPQdy38fnG0jE
         +sAjL6+jquh8BNKscPHI6qnABG/WlmP/6ar9vQmYKZzcNGSqHQk5Nd2LKgo93aqMxzX6
         +IAQ==
X-Gm-Message-State: AOJu0Yz2D/yClz3N2QWIr+n5Kd7bx+gX/we8dDqj+cBKELNK2KskjVcu
	pEIJ9xO8A2tWaDTvDAOGc0znrg9ZvA4RD5ydOCCchOkvgGJNqh8ncb/VTtKjMuxp9IUBaNlgHZK
	54Wez8AwZT3VIAlwZgdYd9yQkPNgQ8gI=
X-Gm-Gg: AfdE7cm4Hthh//acRVoKfuRnzLEnib6Wmq0ia/fQM5lLs19VaUZx4uoTTRGZzLGKDSo
	b+Zt34v0D3CKtJ5l+ZCI+gQPXoFTwyc/A7j4eWEkAbhTpAkbVdUgSDNVldUV2PfUQVezZFw+9FR
	/O+uDbjnj2oF5aKmWba696EklIqNE2pj80wHkOSvNWwkKZE/pX3gk+KRBIXMT+1uczldqCMv7iY
	+XPBV4I1IyDuNNbRUMYDjuVj85K/4WVGFeqHErdbF6Fzojo14fLuF/rRcH5NXIXRanwV4k=
X-Received: by 2002:a17:907:3e82:b0:bf0:550:d9f with SMTP id
 a640c23a62f3a-c1205ef2848mr25751966b.31.1782358963784; Wed, 24 Jun 2026
 20:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh> <2026062320-backtrack-unusable-96e1@gregkh>
In-Reply-To: <2026062320-backtrack-unusable-96e1@gregkh>
From: Faicker Mo <faicker.mo@gmail.com>
Date: Thu, 25 Jun 2026 11:42:31 +0800
X-Gm-Features: AVVi8CeLhIYSLwobZAWdl2H4EJBbxqq50KWHcfbh5mAJOsgmHfU0apDfYGJE_xM
Message-ID: <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
Subject: Re: need the upstream commit to be merged to stable kernel
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[faickermo@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268255-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E39096C29B3

On Tue, Jun 23, 2026 at 3:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > Subject: net: net_failover: Fix the deadlock in slave register
> > > Commit: b84c563
> > > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > > 26.04 (LTS) uses this kernel. Thanks.
> > >
> >
> > Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> >
> > Also applied to 6.18.y which will not go end-of-life.
>
> Nope, breaks the build :(
Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=3Dy), make
vmlinux, no errors.
Both 7.0.y and 6.18.y branches were tested.

>
> Please provide a working backport if you need/want a commit backported.
>
> thanks,
>
> greg k-h

