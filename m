Return-Path: <stable+bounces-214660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKl1BBTuhWlvIQQAu9opvQ
	(envelope-from <stable+bounces-214660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:35:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711AFE32A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75368305614A
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BA30FC3C;
	Fri,  6 Feb 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hOlhUdAE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FB376465
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384838; cv=pass; b=E09zykBOt5bA9qWABIJ+oencdC/ol/u/rPymaXNx/LxPpZBnRVfO2lc3bJCmZfvA8nz3NKVPCza/B7OTfpD9EG0yiFKcUJSBAWcW0q+dpXCDqY4Z5LRfWTQtUDfriU0uEirF0JdRfwg2D63y7tECXfBqRLR8Pow9gKFnSvq0kqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384838; c=relaxed/simple;
	bh=36cAPXabIy/gLJhlRddUDA/lfFlJQdABCEPa/lxdOmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrlGjUh7WAM04cKuJF31ZXSvuqolR5e+lHD6GHRtUGjXGiWq7qePJWLID61i/K998BWmflU7mH1oChoOIvOn8iJVRW0maTZcICVukPblQlekJdfE2osN0KbYhIxwLQhe6UUXP2HeuCgdOoKtHiB+Cu7PCUF5lz4EbroCDQpAako=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hOlhUdAE; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso481336b3a.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 05:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770384838; cv=none;
        d=google.com; s=arc-20240605;
        b=WZ6foc/25AfH73m7sn+gwpsbWiBugPr/eb17iPjJbXztryMX5sOzWyo8AAIPWBSxXB
         MY45+6brDG3Fgm+UNx70fyTJycNXw3l5vuqUJhbZh4WZPfDIkTjh79zeeBhr5Gzrq3ct
         y6UuaiGgAryQNdUeT4qF0x02prjS9zIfWGedr9ej0EgC4WowTU/ig8JtEDFA68+6JdA7
         Cd8AG81SPL4chXpV4uEIkul3VcfTAJqm3b/AYEoHEPyim5KHcaxWvLzZnMr2Xly8U5Wa
         5uHqFDSLMhQfTTq687hSe/lxb4rQby4pBh5Ke/F+dXbmb4ZRHzoFHJ2b5HuYiYWIltN0
         pSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fBe47Hk5EXbn4cDbFpXmEVaFo4OhNBIsCpV63PIxSw8=;
        fh=bnOOCHMj/ooJTByL+SV+fw5cbKrbZLjwRmOjsuRIziE=;
        b=iNxQzJluPGKZ++9scmUnM+581JfUwotMl3uXtP9TwasDJY3u7ub1frfw5uBOjjRbEf
         W6rnu56wdd3SUU1+6t7o3RfpvUWr1CUBcIo/F39ujMq7iXbKv6k1/suN3gyYkkyMVQQo
         9/h67yYZKJLNBFoe9gonss0ooqLH6fqY/+hjIW+9t6VAEtanYuKCl08B2E9L4bxzOEaO
         hQT5D3vLBrjH8M5X/fhE+MiZVHNUZLxTpiWu76dPyasEAN4q5BlkMbqxN3GG7l9V/op0
         Gja4q6J5rGnj13mRnpp1Orvm6+JufpDP2A/32E6KNvdfBrA52r/SbB6g1xNCAOFcmuGC
         0rHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770384838; x=1770989638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBe47Hk5EXbn4cDbFpXmEVaFo4OhNBIsCpV63PIxSw8=;
        b=hOlhUdAEnDFFZCxjAoGXt5tJCNhjypcmFRNb4hmCdxsrIpVK9C+s1+T9AKcaAbJThw
         aliejpOrvsZkFMI8/0xuzsDbYDbSX3Vtmkag/FRzw3HDtTm/3pQJNh63hztBlw/+mN9J
         +Wnmx0pHc8IrujrFaPyGx2fv7NeoWcUMt7rVR6YA7hOrol6FMt7Ewt7yqUED+MR0ZvP4
         Bg5PdsIawgR/1AFkVgHcYr5fWq8jDItM8nd1b4Kt1rJez6k5V96tpyNr5ui6zh+9+zAm
         29nL0svFbUhDRfvm7xO7WU1CMXOL3PKtbYQu56OCTAuq0B0KqX7IJGIN/ijneVT/UtuT
         HQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384838; x=1770989638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBe47Hk5EXbn4cDbFpXmEVaFo4OhNBIsCpV63PIxSw8=;
        b=a5fYbFcJYdZ1p09Tz7xQSdc9yoyDa7tgLz6WZjOrMEfCHkAa8KDg42LT2Irizm+Txg
         IrJhmAiL9XbA6qlGvNEej/dS+Jj4xRA3N77TGtFnuPKg7pFg7+VaQ298jr3Gw+jcqLlc
         zRMDacljGBzOdN8F9xiVoRr7il/NAk3zU5XiqWE1ADBzTQkb3rVvQFYWWorekmqUXMmd
         c2iFKFQmyui9EU1qbZS2OGXBww1ioKGgxVbjpCqgym2Nkrf2ezUM5533SzsI4mhSjckw
         Jpj36ifQDjLgKIdnY5zIJDI6nNwyt/cj8fgkJRbOAZAxyY5eieOa8Ly4qFyby1Uik2K2
         8F3w==
X-Forwarded-Encrypted: i=1; AJvYcCVpBbimICIDfa/ZAud08LGqhLlz0SL/aF9jm68X85NIMRsWWg+lhDovJMUX11r/1lKdWmvEP68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAC/p+y4QNHT427ObMPe5rnCuE7qiK/1ChBQ5AU2c3oCwqmYu
	mKAT6D9jQIkLd3u+ft1vJCDZx3Hxu4/Uyp1ttytII7rau9vQHZUVswxNFtnfUyYGVEOQ6SSM3Vc
	QDbi0VddPoQGr1UPd4t/4h3Q6NdSRt+Aatxi1T2ho
X-Gm-Gg: AZuq6aL17WO2AOKONEmAKuqjbOt2k1f4talprJzJwZMz9Hb8UC1vy25fsq53LxyNlv4
	PWTx4rAGvMtoSa3HQVVUIKGTLhNDoNBwmPjrQ8K3lO5dHgZ1/qtN3OP3mf8uN++O1B6s0uaALyN
	aLsoBxBlnogpVsnLgVcFHSFcYGYstBPF6bSKnEtIlOXvuc5EXJHW95j488spQLKmeEcbfnnTdXG
	26X4CEvDaiRy44NJeDik94ExxsLb8D+3ITBI6r+E/WkGhKyOb02bnDAFnijUEeUaNQcm0acdz6p
	jXg=
X-Received: by 2002:a05:6a20:734f:b0:352:220d:e5fe with SMTP id
 adf61e73a8af0-393ad33a9f2mr2780918637.50.1770384838036; Fri, 06 Feb 2026
 05:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
 <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
 <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
 <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
 <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
 <20260205203615.t3n3bbqmjscp2cnz@skbuf> <CAM0EoMnUm497YUZYbrYeqecF6JYzFbjauV8ACf-h8pjgOd2jdg@mail.gmail.com>
 <20260205221155.na4qrsuuuzpqo4hg@skbuf>
In-Reply-To: <20260205221155.na4qrsuuuzpqo4hg@skbuf>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Feb 2026 08:33:46 -0500
X-Gm-Features: AZwV_Qj4ABtjS1zJ68_MjgmGn89Qhf8UaoYA4aONrd9mGUf4Vx6K6XiiqIvJQBs
Message-ID: <CAM0EoMk8nd2XVCvKmakqN0fPsz3rYWfUwL7cJVW8rhntP5turQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Paul Moses <p@1g4.org>, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214660-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[1g4.org,vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,intel.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9711AFE32A
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 5:12=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Thu, Feb 05, 2026 at 04:30:06PM -0500, Jamal Hadi Salim wrote:
> > Yes, this kinda answers the question: we are looking for something
> > that serves as an upper bound for the control list.
> > Does the standard explicitly specify that it is arbitrary - or is that
> > deduced by lack of mention of an upper bound.
> > Either way imo  we need to have a "reasonable" upper bound in the code.
> >
> > cheers,
> > jamal
>
> It doesn't specifically use the word "arbitrary" but it describes a
> mechanism to indicate what the arbitrarily chosen upper bound is, if
> there is one.
>
> Specifically, clause 12.31.1.4 talks of a managed object for PSFP called
> SupportedListMax. This is supposed to report the maximum values that the
> AdminControlListLength and OperControlListLength parameters can hold in
> this particular implementation.
>

Very helpful details - Thanks Vladmir.
Paul, maybe a nice number like 512 for something analogous to
AdminControlListLength?
The analogous OperControlListLength can be derived from counting the
list elements.

cheers,
jamal

> There is no intrinsic or universally reasonable limit on their count.
> It depends on the required schedule complexity.

