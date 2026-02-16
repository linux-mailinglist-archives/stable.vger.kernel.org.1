Return-Path: <stable+bounces-216693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMSGDXUDk2nF0wEAu9opvQ
	(envelope-from <stable+bounces-216693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:45:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAC14318C
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE96301111E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F027FD76;
	Mon, 16 Feb 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="f7+v8udj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E124A076
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242351; cv=pass; b=bfNNiHMYIYZXdhlu25MaXqFl3+C2jiVkyul5F7c3WF+hyNAQy8bz2zjT9aKWPMo8E/JK/qWxUyMpkcWWivNQ973AvFWLwhIrC//+Pq4dn1t24FO5BCGGl01j5T09bbMMB9zORq8JW0BLa7V/8pcLsmCLldp1YSSBD6BZj4+JOKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242351; c=relaxed/simple;
	bh=L1i0pqAOTmK84ICQU4tMLp9dmOgIYZyfXd9LDT4RKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgT35uBlg7HC0/RI/JNh9WgZ5OpmJgsKfUj9T5lUJIPEPlLZYejN6dkVfIRFFpzByNIOz71B9MFcMY9qcwbwwyl/JsucnWgPvlGwAuZuRMDgzy7r9Ho+dBcbY/mYwlvQlnz4h45EMXKa6mE2IkvBu/z9ZqYiXW+I0TqF2It9I5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=f7+v8udj; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad019bbd4so2963600d50.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 03:45:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242349; cv=none;
        d=google.com; s=arc-20240605;
        b=gSZegyW4waWaMU1fGnv1ATURaVvylOPA2K0DcDNNU9FKEZ6Wb1balQKoUoxJKFNOAh
         sA+sct/EJB8rYWT7co6TzZ+dOWZyti36a4doYWwdYUkf9yIN99nqweV4xRWRpCMYGGL5
         FGB75c/FtKsyoyPF8YTDbVKNjli0UOOXltNRc0XrDakb7xN+QQ3Jv0i51GhNGh5i5vMi
         MeRgOwX1n8PznJvaIKiHdWelS2h0WH/ISF/SMPRISFaAC2KGiTibP5xUAsIsq50Ixt8i
         i8kSkiuSaHxwvtEgVIMQA1Uu5Qb5tGV4REbkZeYO+/pMZOn28/izpW6+4W89ah8hh5rH
         1eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        fh=VPOQUVbS2aS0pLyWBc6aNBHr97CEapEOQmr6JNeSfs0=;
        b=aUGPoGApyt9WXMHxLjJ7pBuqoaEFePJLSGIoY9nZwkzrxzAP3ukedCfAeA+F4rElZL
         3OmCCM2Jz31ChYPjZGsYksnnvBe5+Gy6G6/VndE2Q83meQZyeO+0S6/Bl+5jIYrnjP3P
         kIgNb0r8FOaMk0LR3JZDaRqZIfIrT9xsEoxkepZJVgslsrUv+C3E0nwMGkpmNB1tawUS
         kEDz6pY1/OMGwHrDiJMukb3KOir+ti43ZYe+eum7pZ9lCk29MXvlIEgV1g4k5XV/MKsA
         oS9gP8xKU4nYvumvh79DyVjZGdJlwBO/nkYSB9I2AJZYZdYkWz2ZXbQvqyYtN8wTnoaI
         7ahw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771242349; x=1771847149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        b=f7+v8udjfTWXt+JQZZvQvwRbcMDQwvWfwHr3zyq5LkNYmx7JQzk634Mtx7XJRxmjPn
         Qp2WpC70K75PQL3XaMbXBuU3kbLD6sgJN6pYhrmATovdnfAxZ9He1gwfSrDvfz1y52oJ
         CfE4/x5UEbT0KlNxh09rDowKejiSRzFzLTVbJkLaNfkgvdZbkMlN1WhHlki1Mdpenn99
         FliUyJnpsXIhmcH7XyO916GG9FwzWRrwKoq4HDmvvev/94IYpDe8M2HUZDp1T9A37kvX
         un4i5mY8HXOqhNx9LG71aITJfFGcn81cCpHjANqBukvEcT3JrMP8iigzZFNjdf47c8rg
         5KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771242349; x=1771847149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        b=odXcH7c458dIhRQwMQ2dp13MjD8EGM3Z3U3r2DnonYGqISv4uh40EM/SkR5Z7E6r9q
         3EK2n6BW86No0p3ssQ2iNdP+kGZ4YrEbV865x3L0RhR54/ZDggFZvqlvxY0xroVwcykC
         tqn1uKUb9XwnEdCHYkXJHxuwZulmMOLuQ/xYSz00cScQBJHhb9oFOPTxgBTHNLmD9W2n
         psLQ3Qsx1UyERTP+o3kPQBZ4CD2WdDn3O4TTkKPiuPeitNWP9ObbhCwnB+mpRS44Se/n
         93XdB91isFxvPT9HfXU+KpazBJAGFhS8mHt90K/ucmHSZfkrFbLD8EsRhX/abaOXAExW
         1FGg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDktHc1oZ2XCpjeBW0WFkGi2vIqNSbJNLueQjyGM71Z93R72o9mh9mv4ODSUPpE1paVFTxfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwkuyiNOYh+s3NXvHJaOUO1bz/MqEYTJD2qoA5kOV9veQNqgM
	pStWk1n+GlvrYbGCoNfnCN9RDQoCkiWCb0EdRb2Gdk/6yMhId/8ddYZKWu6Q/Q0/a88CLIAAnwx
	Nr+gj6Np3dU445JJMLvIsje0IdUK1ehMasIRZUd6g
X-Gm-Gg: AZuq6aLJ1psgT9UhnB0rZXBTl4/+WfQtJega3msAvDSZnhGGyITAWLd33eAKkwIHhEM
	swxHXh73iu4KaOiqpUvl47uitPVWQXADZVpvcvf4rZ8I55ScFktvMDSg/Wyg9ww7m0BqGkY4ZNL
	fggxx81PggGguwbd8iGgsQ32i5BgzeDv+8H6kMAgx3fnGe5zvRnCo22hG3pVTuPjF2Kh1pe1z5f
	ObkaeI1tAcjrwNO6G9livmu7A/kNFb7T1Hb02u3t+/KVo4Rvja1/rPYZzfnYWf/n7JhKVjBDVUP
	VRZ4N64kad3Zx9URNR981g==
X-Received: by 2002:a05:690e:1346:b0:64a:da7b:9f65 with SMTP id
 956f58d0204a3-64c21a9909cmr5013464d50.26.1771242349416; Mon, 16 Feb 2026
 03:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-1-p@1g4.org> <20260213113849.136695-2-p@1g4.org>
 <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com> <6KeZDQIaJkCfZ-04S-pj5o5agVs4F_vy9xt4MfPb_6XS7MKcW-iX-9Av0O0bcURgoTn3T5bcHqRdM4FfSt8BWfjgHmbuHIUG80UYa7Ag-s4=@1g4.org>
In-Reply-To: <6KeZDQIaJkCfZ-04S-pj5o5agVs4F_vy9xt4MfPb_6XS7MKcW-iX-9Av0O0bcURgoTn3T5bcHqRdM4FfSt8BWfjgHmbuHIUG80UYa7Ag-s4=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 16 Feb 2026 08:45:38 -0300
X-Gm-Features: AZwV_QgG3XlpzFmRNpEA0I9A9uLW7JIeF5RBvvVjOd_VFMhWbXpYJyHZTtpVv88
Message-ID: <CA+NMeC_0by0k+b0wMN39m1uMGt6FbJyn89ocKRnnr51tg3sOqA@mail.gmail.com>
Subject: Re: [PATCH net v6 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
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
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-216693-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 8FFAC14318C
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 8:59=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> 1. hrtimer_get_expires() just returns the stored node.expires and
>    hrtimer_cancel() doesn=E2=80=99t clear it, so expires=3D=3D0 is not a =
reliable
>    inactivity test. Logic was that although I detected no observable
>    behavior difference, relying on stale expires could theoretically
>    cause infrequent subtle intermittent misses of intended behavior.
>    It's maybe more appropriate to leave it alone for stable or at
>    least not in this patch/series?

Yes, even if it is an issue, we should leave it for another patchset.

> [...]
> 3. It's the same pattern used in sch_taprio and it's documented in
>    Documentation/memory-barriers.txt: the compiler may merge/discard/
>    invent/reorder plain accesses and READ_ONCE()/WRITE_ONCE() exist to
>    make intentional lockless shared variable accesses well defined.
>    Since tk_offset is read with READ_ONCE() outside tcf_lock, the writer
>    uses WRITE_ONCE() to pair with that lockless read.

Ok.

cheers,
Victor

