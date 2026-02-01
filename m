Return-Path: <stable+bounces-212988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME8EMWkhf2nukQIAu9opvQ
	(envelope-from <stable+bounces-212988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 10:48:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755DC55B9
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D7C23012252
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2931A7ED;
	Sun,  1 Feb 2026 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1w5+llC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09D2D0C66
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769939298; cv=pass; b=tlQqf5pXoHc0idoTNNFl+AIr78N1flVTMuUaCvHw88yKWloOW45u6wUnRNuTLWNEsX2jWkcO1/QCzOvRJsu6dFwNqO6YU0ytuLOxOEuAArnCJyM72d4DwLbbGTJ+irUuAsz7rHZPI5895hAvNPqk+bG02g1WUSpN0i57M9j0e2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769939298; c=relaxed/simple;
	bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJ9QQ8zwsA66J9zJZAw3MV+wnoBsAJDAARGxtdg/sW8gPI9D8JF2WkbU9KzV5eR4iaMTpL9inikxtKDoF4qMf2UqnnK9E9AxWk610GFMlFjb+6cFlVyjV+oI6qw5NjDRO4QxcP/Ojl3JHu/1GLODNB3VapJ4XFofGWPhc5SzFVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1w5+llC; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c713a6a6f8so382435885a.0
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 01:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769939296; cv=none;
        d=google.com; s=arc-20240605;
        b=NXYjpaIdANBUTmyWWyXdWqPP+FrMXbbd95IR1EBINdGncozFQRT6vgmL9ty9OXvHEM
         rrzhCbLoWWNhLx/HsZDAWpZbuX6r4kFwCOBxzPe/4ckaAlVAIOvhMY7sVcpZyQJYxywT
         qDgelKyYwaLnguyMraJOL91/e0HWQlKdDZ+MpylhQrnrtVVovM7OhPRkb38ogmC107fw
         WNkH7kUXxsiQQOB5i73k3WM3q/Z16pVFKureGUDLEgmFlJ9v5EC4bZMveZhvjnM36Z4J
         tt8hICyHOoE4XVh7fSfYxhQTKJeJEuT2P5y3CUk3ckEsNbgZ5+q/NHncS0NqOrPC5zgS
         xiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        fh=kZGKlcmvIMbu5LwuuQvrFOXvLtiKyfpZraVkHHq7+8I=;
        b=TqSPVwwI/KC8ZVmKapvRWceSqQq/UhL7W/jzEUHzcR0ycV0C/QI0iyrPOE7bzbRG8b
         WqRYYA4qTrqFtZ+eKCJepd94Vcdk3lnMucIyhN20Pijji0xWkeGKXz08KAlBES7nnwYw
         +e61P53cuIlr+v0plG7uBzbxcJsOFjPecISeyHdTjvGJAe9NEbvxJU+fYmWrSousWGrc
         kGsHw6tBwfut9DGWnK1r/VjfD4oTt+6pZKHG9dTZpSZCRwtwSi9YK23Zx9o6fChPLkAG
         yQIVF2EtpsfdGOwUgUMVrBeJqpJHbAvJtsc0tfPs93zL7ml/LVJaZbJJzlmT73p8dBrj
         i76g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769939296; x=1770544096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        b=h1w5+llCCiuIxjPNhVXpGF+Ct8UzHQQec6wl3+wukIQQL2Kl+mahgVwyhwW54DVti2
         Jz8/uTckRoLMMGQcPRTjeJF26KYNEaaq35LN7LA7CqnQsXzTdDTJKCb84xvpXqwrv24I
         D56rHSNkA3y9y/yt0PEHwieO074xLIZYoLMkdwSAbtoeTfRG4q6Q0CYxJGgRkT0rZd8I
         W+XNkKMZ0CwDFH0mPE4+zjHZq165ZTsUsNFj2pyoJ98vhBRsJUi9deCVOv8eaV6e3atQ
         QDSB5YzqOE3b/ozGkEux88pHIsyGVER7drdnktrPQv4Do6lhmTCU5V5fFKPlLx6g0Kf3
         cO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769939296; x=1770544096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        b=E1h++20JWarN0PAnjEbvLu2So/HkF4XbjOnf4yu16hgfRjbKAN8mtIx1dWwQnB+TmH
         S6qK9VQI9PNK6NqMeIJA1PvfBDKkaJZ/VjhfFwpKbrPR8J9++Tb9RaVbiW9bMg8qGgQV
         HQGb5AY40iMyUi29VOVaUotpfMC3ISTki8gKNaxjfgf9ubbPzNOAVv2GNkbiOxCxnsLD
         WEeHmfPK4mPim/JhA3AHsTPaX/OszQX33c9cPLAIWF54VrywYWq6W/Kneqln4Vs5NF3C
         udsVPzkS5hvWUUvKcAARjO3bCZOc7o/JXtq29aEVjQ57wW6HbPW8XBseU/4C0OtXMX3L
         wkUg==
X-Forwarded-Encrypted: i=1; AJvYcCWq4S4Kc9GnYIZWcdnlR75GxnmyeLO66yMsztbR9MZVfh1xYAeDY3zLDoD0gGr1Mbr5o0C07D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEH8bGmjWzL+ATvurxi5wNTaFCQNitNKJ1EagyqN92Cp493Cg
	44WWanENXq+tD70OkStddutbAMH8UOYJgvDwlw0tU3PNbqcfRzQhlgb0j2JaBsS/JHDBG+CNZbd
	9sXIPcNljcbrkkEd7rCPRyR+Kmld1bQr6EAy8+tgq
X-Gm-Gg: AZuq6aLAnldjP+/GB29AODlQGC759387sJKy/5W2MpgSyXPrfE6ZoOHwc3sYl0XKy/3
	niiF+XfPjV/CcQfSL5Yf9hU2H7t/0hNvRxqYqd5DrFflpJUrhn6a0xe7TSe+2sEt5DoQorfmMS/
	42yI0oO6KPw3lBmv2k+zw0sPjQHtgZj6EutPDZ52sIK09yMKYF6W0CPygoGhrpPuDh0j3NNkJs5
	QdWRt9K1OgBrWVHBzmkku5Y5bRE85S5ZkZcxta6FqM6Vx+waKpHkA3PPS9v0iUTkf9UPb4=
X-Received: by 2002:a05:620a:710a:b0:8b2:eefb:c8ab with SMTP id
 af79cd13be357-8c728ad7591mr1412506185a.19.1769939296149; Sun, 01 Feb 2026
 01:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201022128.2658251-1-hodgesd@meta.com>
In-Reply-To: <20260201022128.2658251-1-hodgesd@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 10:48:05 +0100
X-Gm-Features: AZwV_Qgr21uZb6Gw6qcoEI0Og8GwGJ1uywAoPTfLxzPls-8511ycqj1xtKmr1ek
Message-ID: <CANn89iKZaoJV-zRLzB7jrrkvrun-AqrN+TjxTkNgrKeB3uML8A@mail.gmail.com>
Subject: Re: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()
To: Daniel Hodges <hodgesd@meta.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Xue <ying.xue@windreiver.com>, Tuong Lien <tuong.t.lien@dektech.com.au>, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212988-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 1755DC55B9
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 3:31=E2=80=AFAM Daniel Hodges <hodgesd@meta.com> wro=
te:
>
> tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
> in 'tmp' for the NULL check, and again inside the atomic_add_unless()
> call.
>
> Use the already-dereferenced 'tmp' pointer consistently, matching the
> correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().
>
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

