Return-Path: <stable+bounces-233220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFb6BIfvz2mt1wYAu9opvQ
	(envelope-from <stable+bounces-233220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E3A396978
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F811300B520
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C63CAE7A;
	Fri,  3 Apr 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky0li6vr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0193267714
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234209; cv=pass; b=ODNP900xhD/LQ+BJ1amyJyk47z06hZ/ZOTEjzHfCq9kc7coTRe0v0FAOWpbCohMu+FqvvVebBA/ylUmAMoSAV95vrppKJ5jqYnt2/o0WyiiKfBBv/AkibCuz9oTk79CwElNrQODYYG5Y/pxsWxclUFzIIC/ohZ41vM000L4ifzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234209; c=relaxed/simple;
	bh=mhIYPi+ZTj650hQKyeIbVrsNYbY3op5BHueN/8Cl9Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIEbs1NDyW46ZhknENQ2rPQjUnoC3qF0FTgSw2iYiXSRCnwNguUGJ2TtmdWb4r6SbkdVh80ldtjMr8bW3R+sP9m8pwoBM0OFcibUAN3yqyk+cRBLCzRqgMSVLy6b2pFALL0gb7vSH72v0wsU48rzVAcBfE0oBX28q2SwYb7/MIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky0li6vr; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbb89ab229so876939a34.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 09:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775234207; cv=none;
        d=google.com; s=arc-20240605;
        b=eI0uZKeFNaTQWJCWqguXjmP8oKMMIa4qobWo3xqdrjK4tNFzDg8oAopUImHMKbYDSR
         cTRbD4a6m0C7j+FjbXLOWEINO28qrjmQZ9sWf01z48vG4gD7ngXrjt7NcWrPLMFTKxNR
         I9/Brk+xlViz3+ZwpeETrP2ULKzRwppWDRUK3TdNa7F8N04xal1x2OvgwQEXRd2wKQWg
         B6gTEHjfRZUntZzTcCftNqK1mXjkIjsg+jYXNz0DmrwC0BTFUWw0zwSKmXSAWq6kvAJD
         eECMJfY299Ro1bhYHE70ryHTNCo950YHeCnT5CZRUj01rYbkmQYKByRYxqeLD3+Hh/jE
         4ljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhIYPi+ZTj650hQKyeIbVrsNYbY3op5BHueN/8Cl9Xs=;
        fh=nzN85aAd2huLJktdxH0kVYjSdP12Mu7gghk7PtBO/JQ=;
        b=Hph8Ys6IhpxM3IFS4ZoT408Tyd3pZTOLScji87XuYJFbWyUYef9+E+YtmzkZBvaZTu
         UKrnG6mDNMt0Nq8KVpBjTMcEDrYyAV2nKtNw4SJyJk5RMhThlLs+F73iSnwftfTX9NAx
         VcMl7Ik4g5Yrlg+YgCtWMoPwrm7hkXZWh9dm+gfhP+cEwyb2pR6lcXHe5b12WD4wtEHI
         Jh+f3Sc2hUqk41ILiKcj48xEhw3iR0UwZnwH98VntDGN8V9EogdslCE6Ze9EUsntcBYH
         /6d6HrYN8oTZLjrDRVNf6BL0osBQKUf+cEauFAHzgJcMRk37wg7fuqcfM7NfywqDeQMw
         Kb+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775234207; x=1775839007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhIYPi+ZTj650hQKyeIbVrsNYbY3op5BHueN/8Cl9Xs=;
        b=ky0li6vrd2pYiGVkSaMFBf7mfkcpE93MZ/J0rRq50oOw38Aux76GJbxTk+hczSxbKg
         2sBqh05nGYid0jRDIQJTjihDRetjxLLJvX8pAvKcw2KHH3nn3yFZlt4jyS5nNKgeqJdx
         jgnbxig6Do3Cy8Ff/ZWjK4y1edRtu72jfGNoRim2+2q6i08CJfeZXEh2fyOxdEO+WdY3
         v7gRP2aK9fOyhGH0Tv+Slg1No9RwJlDv8YAjajPLLD0GbvN1JLWknp6lKSJtbxOE4ijF
         buR9YWKhCKtVKAnWtmDQylLjGkf8dNo6wDZ9RJyxSTraJsJ4EQAfqqdB6KCqYtDIHSoK
         Nh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234207; x=1775839007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhIYPi+ZTj650hQKyeIbVrsNYbY3op5BHueN/8Cl9Xs=;
        b=ZpHBzvoAP1lqI00ewgDNZz5z3eoDFeX8Iv8UXAGakW3pjB4XN4D0m69lkaJs+2WM7S
         WXb8n9R5np8/pAenjPLL4m65DfQ3+FZABJwKIJMq6nydnvo3tJ3jmRrSfJVfhn8VtmZH
         /XvXUFzoWryYo5SWbFhqyJmfA/f5rSP8d7F3ZBKckmzESI16CpFaMT8cQPAhN8J+Kyih
         wDD+RnzvWecY4ab95slD7jCCQ9FQKlYqRBfkHVABgdRlbxAgsca9uhIWpAbXd2H0E8nz
         7d2hxLhFxLgTnX/GL2/wW3n7ZaWeVkmbYurPbegJTIPPctShTQ7XeBJEL+/rVgFdIQ31
         wKxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZOCiPQsF39BjBXCrpc/hS9J8U9V7KFeXZKfaeCu37w0Xh+59LfpcpwnxFfIHF1HEL0Tp7Hvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0D7CUM+Ba8CMZQf5ieK4i4SNn53qGo/5zWcMmbN4tk/WQt+v
	TY/6MtRC7qsR4UgzSMKb1nyjF0VxekoOc9HXN/41X22cFoBRTQA1jicTPTtmMCy1QI1QwF0vipS
	NVExrWYMPHM+6DYfw1qCxKJEaREZIdyI=
X-Gm-Gg: ATEYQzzuocJ4ppkY4aYtEVszTTQSPlsPCw4EALJ9FDFBHmIiYzAIGYxxXxgtMbTzOtd
	8HqGMRG9kgNUtPHWWZ7dA0LLUQUhpVzIsFXsgiqoMtMj8UDyE7h35CKLOsyPupwtpSgIV7KC8H6
	xcVnpsh1GgtFOkr4rDZzFY5j4T0jXXsavmV9nwY6qAekux2XTwn+Uv8gFnU7do4CU/Xdy6//ues
	ABzg0kEjXfPO24CZcs4I08GT5MHk44NkrImZrN3izNjClYGGEABp8W0BOYJ3r/qiZqVzB1tmOSm
	uqKfl+mp
X-Received: by 2002:a05:6820:f023:b0:67e:1259:aac4 with SMTP id
 006d021491bc7-6821d747f8bmr1924347eaf.26.1775234206887; Fri, 03 Apr 2026
 09:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABb+yY3hYcJ82QGor3w5KKHUGz9Pc1k64Jdf-94E4Yvv0DTeyQ@mail.gmail.com>
 <20260403151950.2592581-1-joonwonkang@google.com>
In-Reply-To: <20260403151950.2592581-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 3 Apr 2026 11:36:34 -0500
X-Gm-Features: AQROBzCNnfUiQJss0MRPovDqMc4MnIhdZ3NJ2hHQRVK29Ar7Ti2BAIx3xKRl0IM
Message-ID: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: angelogioacchino.delregno@collabora.com, jonathanh@nvidia.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org, thierry.reding@gmail.com, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233220-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,lists.infradead.org,vger.kernel.org,gmail.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09E3A396978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 10:19=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@googl=
e.com> wrote:
> > >
> > > When the mailbox controller failed transmitting message, the error co=
de
> > > was only passed to the client's tx done handler and not to
> > > mbox_send_message(). For this reason, the function could return a fal=
se
> > > success. This commit resolves the issue by introducing the tx status =
and
> > > checking it before mbox_send_message() returns.
> > >
> > Can you please share the scenario when this becomes necessary? This
> > can potentially change the ground underneath some clients, so we have
> > to be sure this is really useful.
>
> I would say the problem here is generic enough to apply to all the cases =
where
> the send result needs to be checked. Since the return value of the send A=
PI is
> not the real send result, any users who believe that this blocking send A=
PI
> will return the real send result could fall for that. For example, users =
may
> think the send was successful even though it was not actually. I believe =
it is
> uncommon that users have to register a callback solely to get the send re=
sult
> even though they are using the blocking send API already. Also, I guess t=
here
> is no special reason why only the mailbox send API should work this way a=
mong
> other typical blocking send APIs. For these reasons, this patch makes the=
 send
> API return the real send result. This way, users will not need to registe=
r the
> redundant callback and I think the return value will align with their com=
mon
> expectation.
>
Clients submit a message into the Mailbox subsystem to be sent out to
the remote side which can happen immediately or later.
If submission fails, clients get immediately notified. If transmission
fails (which is now internal to the subsystem) it is reported to the
client by a callback.
If the API was called mbox_submit_message (which it actually is)
instead of mbox_send_message, there would be no confusion.
We can argue how good/bad the current implementation is, but the fact
is that it is here. And I am reluctant to cause churn without good
reason.
Again, as I said, any, _legal_, setup scenario will help me come over
my reluctance.

Thanks
Jassi

