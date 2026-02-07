Return-Path: <stable+bounces-214757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCQkKzEnh2m5UQQAu9opvQ
	(envelope-from <stable+bounces-214757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 12:51:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF1105C83
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 12:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D3C301BF72
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBCC304BA3;
	Sat,  7 Feb 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvntph6P"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4B30CDA9
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770465065; cv=pass; b=laoAueLF0H9rC7BX6J5MVsMiEfIrE+6Udpi25q61oIRLuiwsSWw7ixN86L6L4e4oML5cwagHdfTBGBF4qcQ71MG//u7W7TzUpPDGfd6GwFiccg0OxKREdnT/eIgsSPHqpMB1ELQp3b/nZdZ2SXJyuYyv/lUh0BGE68QwIEi6mW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770465065; c=relaxed/simple;
	bh=0zHemBC6Bdjzuqlz5xgkTYqv69RbXXUlNK063knTChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQKSWP4os5X8Wm4nNjlJ0/K2WUkgoowZQE3HseKvz0/Z5QkuRg1OrDNQO1l3XnHd0/HUUBhd8+pKaIq43Kn0OM+SFxCRb6Jyg9XN3NGEQjN++9+tcUErJBtb6Rq0VZN2nZH02DWycMXdZ0Lu5flEqZ8nr0l3CzKikTs8nfFmVVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvntph6P; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d195166b2cso2350996a34.3
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 03:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770465064; cv=none;
        d=google.com; s=arc-20240605;
        b=AVNl/MoK+eP0mIa8IAKhJ3CVG1yAwaik3xw8eN7qxRrZHndOXHM5uka5z/jBWUQde9
         n8arGNG8hFN+Kn+sZ5aXOVK26trO13xSodrcmiR8XE1p32JfOYp6aENrt86OMugVSxz2
         ShlyyrntWxsQzyxYtaeMjf5Dtb+SxHZvjdbEUNsTGhqKkn4vEJgse+W9JSKcd7M9s2tk
         J6fKPduPR+u6P8WiuGFfjWBDQTl52eCqxZnJ+u9qPn45M0CVCxd31rJ1R0Dyd1jVyuj8
         gUfgTXGSY/JGVKKusU5yDve+hAC0EJ575J+PJMMRJnbzQSJlio/te8vk2pRW8RZnSgHQ
         JdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFHkmGEuQHGZJWf/M/aLuLTajVSyTFYMnDHLnCKCwgk=;
        fh=W6k3gI+ZDGXF4/S7Tf4m59ytImEG2hMShRa6rRqfldI=;
        b=gZjDxJ7YSLAEzZEOI805jJS7VQuxM/KuvsZgstL7eKouYqU8JE7kl1bMqnubv4CsLi
         2EIIhSz8tpOE1LPaed2KixTGR8lQO/VNmtLMBNn8On5MJvwH6tho0Xon6Ww2H8y3T08/
         KrBgh2X4+i0mxw/dB7quDjSbxT92xZYmp1JsvlW8k+jZapt0pZ9X2uk6/QZoQEJla3TI
         xkC4O9pMhaNdmwiSqXuf40Ug4QR1eUCQk022Q6FigrwsLqnc+rNHHiNYwZqyPysK8OSt
         TFYrwKrrKM4nBerCE4Sqo6q5e+HPgeyuGnpyHIufpbjg3cVx0aKx3LtC+gX80iS130kN
         stnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770465064; x=1771069864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFHkmGEuQHGZJWf/M/aLuLTajVSyTFYMnDHLnCKCwgk=;
        b=Uvntph6P92NV5FF6zLHiLBB0fXBIZ2XDdvtIpUUaiNITmwMGErlnmVar4dO7okr9+H
         OSoYLNJCK6hjK8AfkU0AfbF88XnGriuAbn0rQR+EiQGX55WX3J+h+v90YwoLD2y8yGeC
         EH0lDtD5xUo5wYOXJi+JfUWD8VsI+5vh5TQxxNBlWZIWW19gVQ5TBGpYW0i7eGfMVf32
         g7wMyL4Qca0fmNsNvhbKWeRmukpYGABY/lP3rdbZIk4tRlb1cyitCOW/VtMfItbyNf/q
         NEJNsziZMcGBeYJhgq+LlriAAajTP1HwqOPz+cCVF2RB2V7IJtV9GC17DBfSFq0/NwMR
         T0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770465064; x=1771069864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFHkmGEuQHGZJWf/M/aLuLTajVSyTFYMnDHLnCKCwgk=;
        b=ccFs789AESfE9JIDCmhly+Hu1vU7HG2QQI/jlX6NSASdvfRwarQ3IifaPH3vKHtkl7
         i5/Gq4HQ67YtRUm+dRmEHwlSOmroT1ybNTxbRixDYpFQOB8ZQGwXdA3AHy86RpgGiEXX
         7sfTGTZMas1j6vClNXhw6buTsL4lI/geJCgKEOyXZ8rXEExFkfywxIMMVntPiorgfZO1
         bB5fcQbbEG3ZzLc5SybOVMqrl3UHUqSbSvZAsFYOdkyBTs9Ll5h2JchxKmBfu7kLsPuN
         LOMkyC42TEG+SBCkHXDjm8sbJapVfY5VZ7D9Bj2OYxklbUrlosx8dFm25Of5KJxj3Iri
         uPfg==
X-Forwarded-Encrypted: i=1; AJvYcCXovdmKfIkoaG74ke1a7J/ncbH+znPjNcrNUZaJ89eJGkyCDbGO0mtLXBZbSNERw9v6++hLytw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRneyqipukBjf+Hks632QynlsVU9mF1gBf3u6QZMuOob+fJzm
	4ow2cYZ0Y0/lDQ5JK7vzw8bmSG+rdiy54PCwHdw0EiFlNfm03Y6B0Wg9INQ5Svd7QeMHSENgQDB
	zFDQ/ZEfZf2RncRWD9L+Qk6EqCVwP7Yo=
X-Gm-Gg: AZuq6aK3VllXrcSKX6nw+t89SJ1JlzlSb2whbXhuvlBhlOHsIS5mwqpeYswWgHhrFb7
	6FD+uqbL/Y67m2MmplZmwJOpPh2yEk04TY0cmlwZv+vt4sZFpMz1XaRBqi/HPMwNWcTWmkyMNM5
	k69cdGd+ZDN+WsVDkWAoHFiG7w/z3hZSuZB6ZaV3F4xSlcoomdcSIAv7vBBE+QP9hWgbWjPDzCh
	jmj6/KL+JHMubI5WtMksy8mCXIr4yhBxfHcPKoyBQnQKl5JIvJv/XKQTyq9thHk+e9eBtlVa/OB
	Vo+ZdO2AbTfHHT/d43xdqErQmTioXOjLQSG1mYfOi9Bc9Jn7KaN9hIWq+fkY
X-Received: by 2002:a05:6830:600b:b0:7c6:ca92:3621 with SMTP id
 46e09a7af769-7d464489281mr3417737a34.22.1770465064248; Sat, 07 Feb 2026
 03:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203121443.5482-1-hanguidong02@gmail.com> <20260207104308.1bc31102@pumpkin>
In-Reply-To: <20260207104308.1bc31102@pumpkin>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Sat, 7 Feb 2026 19:50:53 +0800
X-Gm-Features: AZwV_QjmF7D3mncUisHZQfmM35uKMQc-Xzh6Vh9NG3y8UrfrmKdKsLLq4Ty8_ro
Message-ID: <CALbr=LZ3XtE8Fd_qj8f1znZOKSB02gGQYw=fGEAM4BS_wNi76Q@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
To: David Laight <david.laight.linux@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214757-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,vger.kernel.org,gmail.com,decadent.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14CF1105C83
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 6:43=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue,  3 Feb 2026 20:14:43 +0800
> Gui-Dong Han <hanguidong02@gmail.com> wrote:
>
> > Simply copying shared data to a local variable cannot prevent data
> > races. The compiler is allowed to optimize away the local copy and
> > re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> > issue if the data changes between the check and the usage.
>
> While the compiler is allowed to do this, is there any indication
> that either gcc or clang have ever done it?
> ISTR someone saying that they never did - although I thought that
> was the original justification for adding ACCESS_ONCE().

This patch addresses an issue originally reported by Ben Hutchings
during his review of the 5.10 stable queue. Ben explicitly pointed out
the potential race and suggested using READ/WRITE_ONCE to enforce
local variable usage [1]. Many of his recent suggestions on stable
patches have been adopted by maintainers like Greg KH.

>
> READ_ONCE() also includes barriers to guarantee ordering between cpu.
> These are empty on x86 but add code to architectures where the cpu
> can (IIRC) re-order writes.
> This is worst on alpha but affects arm and probably ppc.
>
> For these cases is it enough to add the compile-time barrier() after
> reading the variable to a local.
> That will also generate better code on x86.
>
> The WRITE_ONCE() aren't needed at all, the compilers definitely
> guarantee to do a single memory access for aligned accesses that are
> less than the size of a word.

Following his report, I consulted the LKMM documentation. The access
pattern here fits the definition of a data race, and the documentation
recommends annotating these accesses to eliminate the data race [2].

>
> This all stinks of being an AI generated patch.

I assure you this patch was not generated by AI. It was created based
on feedback from an experienced developer and kernel documentation.

Thanks.

[1] https://lore.kernel.org/all/6fe17868327207e8b850cf9f88b7dc58b2021f73.ca=
mel@decadent.org.uk/
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/tools/memory-model/Do=
cumentation/explanation.txt#L2231

