Return-Path: <stable+bounces-216641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K1yC9Uwkmk8rwEAu9opvQ
	(envelope-from <stable+bounces-216641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:47:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067913FB34
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4D4303744E
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AD3081D6;
	Sun, 15 Feb 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ibfGqydY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D2306487
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188355; cv=pass; b=LuU7EOuQBj1UlIscicFuWFwsYu1SY5Px70jNumcVxfg0bJlc9p/6U8OLhLiZKfl7xTraF1JBEqQf46fUaWy0LozsQKtowFFqkML33mS3cB7PF9ZoO2AxFj13Ib7PCwEsn9dZ5IwJLvvBzrc84AhUAyxdfI95b8Gg+SAA8DQgPlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188355; c=relaxed/simple;
	bh=Ds1v+eswAQASNf0hpI4AxWNGtflZxsZg+jHzXoyFoeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+6UEwdCesgWpqDKGK2Fl4yr4I0ISkKFAS00KXbBGweYxxjC1oXiXFry+WDwIhKW5hG+qUP/XI8vCKhqEc1nbPg6cxauYwVT63CxvRVVIhXinRRVrLwHkWwRX2eq128TmIhh+ym5KYUIdQK2+O/o6hojhszh94fmsAED69S9mgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ibfGqydY; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ae5f0777dso2390360d50.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 12:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771188353; cv=none;
        d=google.com; s=arc-20240605;
        b=IDEsnR3XDQqaL3ilt6TjX8eKCD6btIt1kI0+5HaSQXL1xkokNEMYwHIM/C9jdgOhM7
         QHU+iGYVwiBENTOJjvCnoP0AWhq0Thpt4e6/FeH6OKjEXdMzfYx1ot8v61TogFbQaXKF
         5isOefR0uOXz6jTxqgGhPccv0CBMAMfkOEAcrTb9qdXBVoZrwF9nFgnRMSgJSlO+eS37
         AA1dIbsX/K00iT15E6NW/Q9+4PL4Hbf+HJQdnLwar3BFLZ7ojhfNRR28i4o95zv/31Le
         e/T6VIgVCKD3SL/VCUqsYq5TA9hVTTdixfhw2jWeaxT1RBCzk6mo2spKBsE17MrV9WFg
         X7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        fh=I7Xo11hVuQhAg/heIUZiP9fkCgAHSXjN541v8bfuFFc=;
        b=O9Sz8vyUxru99sErpJ4BPe/zikgDBnGzYThXllH3iS0yHtuDtBTWuXFqx1bMQQoqRR
         eQpFEbPwmf8Yt0vUuMmO0FckdCju+FdD3RtX65aBUDaqj4nDaOo/t5vAhEZIbp9OeMqP
         SkO78bxFVJ882zvow5XAtdPklBIJund3pzy0w90WBD9fP2w6ziNcnoTPKbdrt/NJ6oTP
         ebGSEKIqphKEdny1crbpJ4SaNwF++HN6Ne2jHiDJ8ZK1wuzU8XTNZLR2p2E6oFMCea8l
         Gpb3L1QLgSKIMOk3tgHWZhz1YjxuN/EztFJcLJm+VztIOMzA677cB9LC+QxaHYEefct6
         cIyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771188353; x=1771793153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        b=ibfGqydYU4sLq7R4H3NPDplUcl77UxdcOQQYg4doFoKMXtetTwP5xOev4u9a5YT3z7
         iqXrziQEmYbs3fd/wunDwAyDLmW0TLD/47pnOkMArti683CM4T4A7efDkOH/b/eLSSFF
         ScLVN4tTFjE8AGU6DyVZcaA0hFREKZ+kjhDh0Deex5fyOtAr6pAvPlIDTy+zrXabgGrB
         sR6By92k0lxLbk6CeeuAeiH5UpYglY++sk2H12OHgJlqjxFdQhJV5QQTHgJoIyMi5ZrW
         iUwRnlJoMl/oKPOtcOTMLhv24/rohtj1D3PKdn/scvhSb+erqls7ql3tS6mSrLLqGK0j
         njkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188353; x=1771793153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        b=ncyWuaag5YmH8UyNL4+7HULXbK2JVh4wb2QH0dZQzCFJo9JkkGUYlaYlBAudsFyRju
         dY1nX8bWoxz/1IYwKIUVyMTEqbMSdhOFqRj5n9fuTL0/m5QQF53an+z4ORWS40tCEfqW
         dlz++WedudQRvMO2W++6h3paNDSws4gxJZ47rH0QPAWLvH8eJWNRBpiciDLa4+kN6dtd
         ZqYZ1BnJZMYauJT8ZWmQ6giJyqcYH7ysvlJVgq4tFNQfTs/PEzxgPRrFxcCWg7fyZ3qm
         REY3jwa0GZ4uuvUDHtGBacVKEQJ5bQ+de+pFKj80nXngRirOT/xRCZAMwjJDHzzIzJVC
         +OSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9+U6SiUlWmU/CVTmm9jUQo+DJ/pKPUcJdSOIjHW6im7t0XxAyfMs9dvemK5SaXdaf8HHRS40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUclxzpTuB8qSdgwt2+fa1gsdjck+Hjvf/RtzsWAWhI8tpRkc
	4ysF22XBOnv9ANQb6R4mvRtVaCNcxn1Fd+/ZDlTogNLHn1ct9HXUlfKUYrr+egoDn2h04JwQNNM
	0pRH3PIFjJp0vnLWQMxyDkFVSovDap+ZgLPv2YjEW
X-Gm-Gg: AZuq6aKxmMjaWdfC4apgEyIFaNBlEw22rHowzXzcb3vmG12I1Mf0kK0Uvokvaw38JML
	eHmg6m0b5GIUk6Z4XH64fABONpbkh37AJw5LZBw4vLosZHNRfMWNWoWfUKZqVXzKHJaW60cAPE/
	ijB1r7VBexpu02kJF2culb6eNjjep1oEyyoBBqv2IeZLc5rhSVTMTOXWeNsnJbbGBRpuiTjuYEy
	tY30HIGlYQd564KTXbXswf/grmxumoF3EC9LFfoE9nxYWzGzQJNDOIXSaMZ2Dlm2HlvqsUfKKrj
	FT9zgRQ9R2UOumpqWs+8NA==
X-Received: by 2002:a05:690c:e3e6:b0:794:ecaf:c501 with SMTP id
 00721157ae682-797a0cc95d1mr132565667b3.46.1771188353173; Sun, 15 Feb 2026
 12:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-1-p@1g4.org> <20260213113849.136695-2-p@1g4.org>
In-Reply-To: <20260213113849.136695-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sun, 15 Feb 2026 17:45:42 -0300
X-Gm-Features: AaiRm50bUFQOD3H73oRgDuJ6_T-ZnN2l_KlSeCgNXBjOKlK31-17mnd8s7B7Xek
Message-ID: <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-216641-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8067913FB34
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:39=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> The gate action can be replaced while the hrtimer callback or dump path i=
s
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates unde=
r
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omit=
s
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..60c80e609ec3d 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> [...]
> @@ -56,11 +59,10 @@ static void gate_start_timer(struct tcf_gate *gact, k=
time_t start)
>  {
>         ktime_t expires;
>
> -       expires =3D hrtimer_get_expires(&gact->hitimer);
> -       if (expires =3D=3D 0)
> -               expires =3D KTIME_MAX;
> -
> -       start =3D min_t(ktime_t, start, expires);
> +       if (hrtimer_active(&gact->hitimer)) {
> +               expires =3D hrtimer_get_expires(&gact->hitimer);
> +               start =3D min_t(ktime_t, start, expires);
> +       }

Is this change really necessary?

> [...]
>  static int parse_gate_list(struct nlattr *list_attr,
>                            struct tcf_gate_params *sched,
>                            struct netlink_ext_ack *extack)
> @@ -261,7 +294,6 @@ static int parse_gate_list(struct nlattr *list_attr,
>         }
>
>         sched->num_entries =3D i;
> -
>         return i;

Removing this line also seems unnecessary.

> [...]
> +static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
> +                            enum tk_offsets tko)
> +{
> +       WRITE_ONCE(gact->tk_offset, tko);

Why do you need this WRITE_ONCE?

>  static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> @@ -366,6 +407,60 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
> [...]
> +       if (ret !=3D ACT_P_CREATED) {
> [...]
> +               if (use_old_entries) {
> +                       err =3D tcf_gate_copy_entries(p, cur_p, extack);
> +                       if (!err && !tb[TCA_GATE_CYCLE_TIME])

This check for TCA_GATE_CYCLE_TIME seems unnecessary.
If I understand your code correctly, cycletime will be overwritten
further down if TCA_GATE_CYCLE_TIME was specified.

> +                               cycletime =3D cur_p->tcfg_cycletime;
> [...]
> @@ -434,33 +532,47 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
> [...]
> -chain_put:
> +unlock:
>         spin_unlock_bh(&gact->tcf_lock);
>
> +err_free:
> +       release_entry_list(&p->entries);
> +       kfree(p);
> +release_idr:
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> -release_idr:
> [...]

This looks weird.
You will go to the release_idr label when tcf_action_check_ctrlact fails,
so the "if (goto_ch)" part of the code will be reached in that code path.
I believe it would be better to keep the "chain_put" label and keep
"release_idr" below it (as it was before your change).
Something like:

chain_put:
        if (goto_ch)
                tcf_chain_put_by_act(goto_ch);
release_idr:
        ...

cheers,
Victor

