Return-Path: <stable+bounces-272318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BD4oNFkXTGrngAEAu9opvQ
	(envelope-from <stable+bounces-272318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:00:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC19715932
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:00:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=anZpke75;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272318-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272318-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C74303004631
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0E421A17;
	Mon,  6 Jul 2026 21:00:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF241F7C4
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:00:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371606; cv=pass; b=XQReUlcVjkOFgMJ9XTn8c/u2npOIp1IMPazsDRHk6Yipf6xZ/kEqnwV8rtV5piwaqGL14/ZpZtSivLsDjmu1VRETwZwpjOZZCgHRPmWXoLmGg8tMvsoE0YMuheUNHc0I6s3JedMsEKP6B4ISw41Gv/+Q0LYGxYD/saGaR1i+st4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371606; c=relaxed/simple;
	bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCEvxSJ6+s0Dsbf1FNOAPc+xeHYxwJ+R9OIVoVS5MqfxJoFwjI556rvHdxDEUHweliHsN7Z/RqPrmr43DnMVy/Jrc1tHifIVXP3PLz4BaThnVE09vthakB9e6w0/TsPKvUOaD1gK1EHqe7cK+7UUWPHkhwbk7AHSBLjoqMC2a5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anZpke75; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so289a12.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783371602; cv=none;
        d=google.com; s=arc-20260327;
        b=C0/3m4TCZXM3AIK/W34zKszC5YbPx7apVNM6o+9qHBVAinp4scWcnmXzhmnqFB7hjw
         K+xTm2yhcTNUMQ3nNCZwN2HpQzjefUSMfnE4u8aJK4+CbzXmi543RCjHpmLc5lCrGwlS
         /X3PYhlH1GUHbJr/hMMzgyn0utjfCUG5NupY38FWqbs5NOtuFXAo7FfQG4AbBa1gZNgZ
         SHW3Lh23zxXk7MS6y8WKahqZosyFE2NZbQvzVCIvd3cI9jfGyAzrcaFaSkWKTTlcHVPY
         eT23cYH1YNExP3iT0VWqlNd7au8ggQ0zpBROT4HQhULwMQuve4ZwbtL5INcK/Voa2/2f
         l88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        fh=Zihasp7YU1NV27TirspgSju3G/a0GxNQVlrKSKdy4V8=;
        b=J8Fe34o/nEZIhsJYqbRYXaRIIndiHTFi0zjEayPJf7ptb8QgQ8PCgT0QP9asg413su
         xfZ4MPE7uCfAeXk4MZGM+p/zXrzYakewUOFIYWn3fN63Eay6lj17/0pUhYIet2ZAWxzU
         NwoJOtty3b/88DgIaZmjOMuQhVXL6ToiBFxgTuAUlQw7aRxm2jmJHq4LDQcNeH49phHT
         0jp0US9sJPu9bN/dkUNhPrB0Y+OWTyzSA5ih5H7aByCIH+uJkTRo4PNzEUdV6nrmbr79
         b7rcUCGzoXQQHO0Lkp+zeN3gDa020VeTIy1053duEXlYZLWRz3bPO3aG0R9/Gnismb1H
         UdmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371602; x=1783976402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        b=anZpke75kv9BWt1YU8O7S8ovnSnXmBjclhVmAcLDn3pkRVT67BpK8azd+F7i9+Zde1
         4fcW7U1/+veKA2j14mfugmmU9V7KKYHsWZc2BqDhgeggNTyWN+N+/ITzaZ8o85LmkwOR
         F6piN7L3XWuJBgt0NCwEx9xi7jr88Q8w5vwJR/LGd66RAXCZnXH5Z9rqTJWbcEK01lti
         b0RuOdAWRDgqxmLN+7jPsGBpwdapG59FavlDTNJjUsT65UfOpxPVYlh6qZxnoDC4QF+n
         iC8EgWfNo/zw7QWRaNQ92W2t9X2W6M4nqY9SZf/xVekqDSyAR5EyRiFR0cm1dPcNGa8u
         xIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371602; x=1783976402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        b=CHaIBHlo5HbDn+2UmdfzdGpPTLUW6pkBZMVCVjaaknG5sL8rYQMExv2Zq4hbjXOOdE
         4kjHl/cl+0qEJA95I5pFJ0nx2G+RAgxuCE/V2pXLKYVd0CPuIzW12XLpIB4pBu5Cl8B8
         +bBCiPkkGIah4xWJcHiapBSYUm3U2MH0F+yVzBEQJ/7Q8oBtpy3lqziMdT5JSYE9pGUK
         kBynpIr1vdAK30UUO9Z4QLTYWxT91mZYUQWz+8L88htMzbRvC+C3MFv6gBetpv7RsrFC
         PcscJAbEml0dcjGB6HP4JsUb8edPPplSg6D97MboAIWqQBmozKThZAQqOmuYiKhdiqCS
         +nWA==
X-Forwarded-Encrypted: i=1; AHgh+RrRhAxQXnFPCS/bxAHlylXbLC+PBljVIryi9ihojeb04WKkJaGsZnuK+JQk+HDkfw9oeW7Rffc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKFuokuGbIRTZxSjwFLs0kTGbcREwIFbmhxPFsLwSjIE6NmOu
	Z1j6HxMkwN4EAR0ij1crCWTkJxVA13TY+zn6VtPQ94Oy4pUpCf4vpo1Yy0lK7TLiK6nF64/ss4l
	7dDDhGSD5OmVU6Hyp/VcwxKMXeWozz4PxPmFQjsej
X-Gm-Gg: AfdE7cm2NSGZpqOZxGCaPjm25RPCZuwfX9dxjjBDaDg/AYlpgHXDratwpbKOPEq9noM
	J62vtL9WbfKqB7lQU9ia0myfB5u+0OZH3aShMxW7k9FD8wOmJW8hQJGSQTnQUy0qOYRoWou2w9b
	A8oBp7+9ZGu+VlYtpe4WpWfNNJLJxDtLzmYgtu4ftHjJIT+48EUaseqHQwpOU5OqPOxV0XveyVp
	O3X51x8O/qd6vLN42cF4p7eYfLFMMNBqi9FyYiySfa+mdpJoVxOrVRfw5GrI2VKp3JSMmCofq1c
	AwX6aWBqLqmKvjKGc/4zdadGFD1y/3HUB39Bt57PCf0EC3uT40nWo6GVTQ==
X-Received: by 2002:a05:6402:a581:10b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-69a90c6186cmr3802a12.8.1783371601820; Mon, 06 Jul 2026 14:00:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com> <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
In-Reply-To: <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 22:59:24 +0200
X-Gm-Features: AVVi8Ce7wKbDwrqIn-Ojy2Nx2LKJoP2IqoCHaxHLVTCiHU_aETZ8yxpu-NaWsuI
Message-ID: <CAG48ez1+unKRQQB1r_xwDpq6V62+0V+GZqbUTAUhcY0Nw+06Xw@mail.gmail.com>
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272318-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mjguzik@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:linmag7@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BC19715932

On Mon, Jul 6, 2026 at 10:56=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On Mon, Jul 06, 2026 at 08:22:42PM +0200, Jann Horn wrote:
> > Don't return the return value of down_read_killable() (0) when a ptrace
> > access check fails, return -EACCES as intended.
> >
>
> This is the kind of a bug LLMs can find very reliably.
>
> In fact Sashiko did report it, along with something extra to take a look
> at:
>
> https://sashiko.dev/#/patchset/20260518-procfs-lockfix-part1-v1-0-5c3d20e=
0ac33%40google.com

(that is an older version of the series, there was already a fixup
https://lore.kernel.org/all/20260604155806.1402880-1-jannh@google.com/)

