Return-Path: <stable+bounces-216254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME6kBYlJj2moPQEAu9opvQ
	(envelope-from <stable+bounces-216254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:55:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D89137BB8
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00AF4302BE10
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A23312808;
	Fri, 13 Feb 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMe/JcgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701A25A2A4;
	Fri, 13 Feb 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998148; cv=none; b=drpdyx5LrgU6yhG72PTxRdQL75sDM+vLwQ9XIm90lY6tHZZQZi5fMkqAisEgossCFHkO6ZTxTDbhjFnIDRM1hnqDRf/EHM8V55Pq9Pd/W90UhUTv3A41UcuvhzLSuQw/KKmnhVF7ErJhal35NyvXlHdOOQoDa566W7lBlhPIxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998148; c=relaxed/simple;
	bh=QvYIB5WqqOrUK4YAhDT9S7D+68jRo1GDzrIhWFZzer4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiAT1IikbGWa1muozSKp/MmerH2bqaq+odJ+wjkNgAeSb6BeTg5lHueWbf0FQaf5sug6ToSES5Ou4QQ4tljog6YWRKEMcifoYVhspeG1v6wSRq623cFf243cfjDlq7ZhzZHlOFQBgn666zblbVEOTfyAOusnqC0w12RUCr9GfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMe/JcgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F4C116C6;
	Fri, 13 Feb 2026 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998148;
	bh=QvYIB5WqqOrUK4YAhDT9S7D+68jRo1GDzrIhWFZzer4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMe/JcgXuZuHIji3Px1biG7atMFTV3yf59CW9HXGIkOIGolK/Y6X7IeU6iinIzsI9
	 WdHbTixYLzbHyZxTou6x3sBi93qu7fW3nYOQ1B2ulc8P+uD7c9BkrPJOqJi5j9kQew
	 XkEs+wsZZDqA7wngHrW+VYYx3jweoQDuALoxTFqi0L7u8Rv/EyvtjY1XS78vTSdVs6
	 aA2gn9qeieOEwOzbcHGCduzsTtEJyyB2EBOS1GUc7CuMWPWzfVP+NfbqMZ0eXvZ1GP
	 x/vkgmSl5AC0lUxXlO0Ko31YjGanAlvCH6M4kXBXa8ENb+V9kvEK/2aspY81nWP+7i
	 xQq1TuoWVzqjA==
From: Simon Horman <horms@kernel.org>
To: p@1g4.org
Cc: Simon Horman <horms@kernel.org>,
	jiri@resnulli.us,
	pabeni@redhat.com,
	victor@mojatatu.com,
	jhs@mojatatu.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com
Subject: Re: [net,v6,1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Date: Fri, 13 Feb 2026 15:55:28 +0000
Message-ID: <20260213155528.2515066-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213113849.136695-2-p@1g4.org>
References: <20260213113849.136695-2-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216254-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,resnulli.us,redhat.com,mojatatu.com,davemloft.net,vger.kernel.org,google.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: A9D89137BB8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/sched: act_gate: snapshot parameters with RCU on replace

The gate action can be replaced while the hrtimer callback or dump path is
walking the schedule list.

Convert the parameters to an RCU-protected snapshot and swap updates under
tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
the entry list, preserve the existing schedule so the effective state is
unchanged.

> diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
> index c1a67149c6b6..5223c00279d5 100644
> --- a/include/net/tc_act/tc_gate.h
> +++ b/include/net/tc_act/tc_gate.h
> @@ -32,6 +32,7 @@ struct tcf_gate_params {
>  	s32			tcfg_clockid;
>  	size_t			num_entries;
>  	struct list_head	entries;
> +	struct rcu_head		rcu;
>  };
>
>  #define GATE_ACT_GATE_OPEN	BIT(0)
> @@ -39,7 +40,7 @@ struct tcf_gate_params {
>
>  struct tcf_gate {
>  	struct tc_action	common;
> -	struct tcf_gate_params	param;
> +	struct tcf_gate_params __rcu *param;
>  	u8			current_gate_status;
>  	ktime_t			current_close_time;
>  	u32			current_entry_octets;
> @@ -51,47 +52,65 @@ struct tcf_gate {
>
>  #define to_gate(a) ((struct tcf_gate *)a)
>
> +static inline struct tcf_gate_params *tcf_gate_params_locked(const struct tc_action *a)
> +{
> +	struct tcf_gate *gact = to_gate(a);
> +
> +	return rcu_dereference_protected(gact->param,
> +					 lockdep_is_held(&gact->tcf_lock));
> +}
> +
>  static inline s32 tcf_gate_prio(const struct tc_action *a)
>  {
> +	struct tcf_gate_params *p;
>  	s32 tcfg_prio;
>
> -	tcfg_prio = to_gate(a)->param.tcfg_priority;
> +	p = tcf_gate_params_locked(a);
> +	tcfg_prio = p->tcfg_priority;
>
>  	return tcfg_prio;
>  }

[ ... ]

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f272757..60c80e609ec3 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c

[ ... ]

> @@ -509,10 +621,9 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
>  	struct nlattr *entry_list;
>  	struct tcf_t t;
>
> -	spin_lock_bh(&gact->tcf_lock);
> -	opt.action = gact->tcf_action;
> -
> -	p = &gact->param;
> +	rcu_read_lock();
> +	opt.action = READ_ONCE(gact->tcf_action);
> +	p = rcu_dereference(gact->param);
>
>  	if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
>  		goto nla_put_failure;
>
> @@ -552,12 +663,12 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
>  	tcf_tm_dump(&t, &gact->tcf_tm);
>  	if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
>  		goto nla_put_failure;
> -	spin_unlock_bh(&gact->tcf_lock);
> +	rcu_read_unlock();
>
>  	return skb->len;
>
>  nla_put_failure:
> -	spin_unlock_bh(&gact->tcf_lock);
> +	rcu_read_unlock();
>  	nlmsg_trim(skb, b);
>  	return -1;
>  }

Can tcf_gate_dump be called before gact->param is initialized?

After the conversion to RCU pointers, if tcf_gate_dump is called during
action initialization (between tcf_idr_create_from_flags and
rcu_replace_pointer in tcf_gate_init), p will be NULL:

net/sched/act_gate.c:tcf_gate_init() {
    tcf_idr_create_from_flags(...);
    ...
    // gact->param still NULL here
    ...
    rcu_replace_pointer(gact->param, p, ...);  // line 517
}

net/sched/act_gate.c:tcf_gate_dump() {
    rcu_read_lock();
    p = rcu_dereference(gact->param);  // can be NULL

    if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
                          p->tcfg_basetime, TCA_GATE_PAD))  // NULL deref
}

Before the patch, param was an embedded struct that was zero-initialized,
so dump would return valid (if meaningless) data. After the patch, this
becomes a NULL pointer dereference.

While the tc action framework may prevent dumping partially initialized
actions through external synchronization, should this code include a NULL
check to make the initialization window safer?

The second issue is in the hardware offload path. Looking at
net/sched/act_gate.c:tcf_gate_offload_act_setup(), the function calls the
accessor helpers without holding tcf_lock:

net/sched/act_gate.c:tcf_gate_offload_act_setup() {
    // no lock held here
    entry->gate.prio = tcf_gate_prio(act);           // line 723
    entry->gate.basetime = tcf_gate_basetime(act);
    entry->gate.cycletime = tcf_gate_cycletime(act);
    ...
}

include/net/tc_act/tc_gate.h:tcf_gate_prio() {
    p = tcf_gate_params_locked(a);  // uses rcu_dereference_protected
    ...
}

include/net/tc_act/tc_gate.h:tcf_gate_params_locked() {
    return rcu_dereference_protected(gact->param,
                                     lockdep_is_held(&gact->tcf_lock));
}

Does tcf_gate_offload_act_setup violate the locking requirements?

The accessor functions all use tcf_gate_params_locked(), which requires
tcf_lock to be held (verified via lockdep_is_held). The offload setup
function doesn't acquire this lock before calling the accessors.

With lockdep enabled, this will trigger warnings. Without lockdep, there's
a race where param can be replaced via rcu_replace_pointer while the
offload function is reading it, potentially causing reads of inconsistent
state.

The dump path uses the correct pattern with rcu_read_lock() and
rcu_dereference(). Should the offload path either acquire tcf_lock or use
a similar RCU-only approach?

