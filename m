Return-Path: <stable+bounces-210606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN9bEzf5b2mUUgAAu9opvQ
	(envelope-from <stable+bounces-210606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD54C941
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F250ABF6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872A3A783A;
	Tue, 20 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QQDzjRg+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCA3A1CEA
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943091; cv=none; b=NujbnZyF3G/YyXNL+Hdj0i7AMHEXNh4Vm85QVQQoxdDct2A0Q/HU2nz4pLkHjpki3B4/8i0DfdF6lHQClN9VMYt11E0F6TgUMI53SaGEeveJCp+k/VwPOH1CLYlDAZErzA2pLIlj1Ug3o+iNPNpSE/jp30mSq7I+PHzpDf7MaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943091; c=relaxed/simple;
	bh=UXP7g/BBPk/YWgk0/upubrDKRWdkIInmrHekkfzLkNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTq7VasjLEWwvWtWcbTa3DIGb/unZwKkO2tW8M6HXMBRNyupPiC9xWtYG6EemLwaoSsxiU2t/FUEXDAO865hHbqKfbfFIBeieYzkPaBMq0D2+rCS9OpB4lx6cWWG980sNpxEug7Rk4if71qS02OzbHBxfgldVxwU5TWrf6aHXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QQDzjRg+; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f36012fb2so8489406c88.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768943088; x=1769547888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ai1otIKDYCwf2Y8TFssFgbpLXbDAkZ98nVLTsrDMfKQ=;
        b=QQDzjRg+EfNb9xU2noNNQVPU9wAh+1jsVztkHkbzYogqHdQeZPHpCd1eH7tBsYLmX/
         9RztlgV8QwqUmcdGJK6wdlxY8qta/xwv/1KdSOyoz0E6yd/YIVcmcVRCIFKKFobyQc2I
         JkwYLN5ugRCTL+uuJmjxjWXr4NA6TjTb32FWf5cy2ZQL0gtRogGZd9oV1ehQUdZLeABK
         k+8Ec8C9pCigtApIEYZHA6iR+Jab4xy98uIjQi6a78WA9mqs7ZmnxWDb4dJkocmw6VhT
         3UggRPWVbidqmqzhqPc1BQ5pli9ZuCFr6kYhkRr2OuarTxyi7Gk1DPXZGeEK466qYlm/
         /HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943088; x=1769547888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai1otIKDYCwf2Y8TFssFgbpLXbDAkZ98nVLTsrDMfKQ=;
        b=OUCjy83tCQ5i/P3ulLs9n2khGsjPdIkKcqWHbI4eN7mpFklonmWm74LH1gGrA4RBLQ
         jKCNv6GKpQSiiNkP867Tg1mSPbgrEerRSbQyUH/dZWzSomEJSOW+PRxAlphAOF7G7YKZ
         1YCX3g/sXQFRwYAfiUoaJ2u/pWDnkhGype8Oe3Pw+0c3yR5L5IcWKCq8Rdkxi5qlMmsg
         Wh0j1oqZXMZx2cFMzZSXOKCsiAy558BcXlT+keQqDCdorQt9ma2V+Ds5edIUOYwyH7GJ
         Ovd/Zp4WN78K9185qy7+0IYixaFWgDDgLI86QrO+L+wQlzQmZD+9P9u9N0epQpqrnJYf
         GEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRUD+MJRnk98+Vme71wqjqptbm6kfpv9OEG84Gkir1ajbLIjl3NK7a9QSfnzv/AjV0dLRFDuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/Qx1MwYSj/I7i+lRqxLUvx867OUKGBl8A/sJvBJWeow1khAq
	90YrwEPm4zWGaWhT+frAd9v6Q0ixA7eZdy7xFfNSTr8yr7grafei0EARljwUJVLQtQ==
X-Gm-Gg: AY/fxX51LCFK6eKJlBpQNWakXjRM180iJD1sdSBHTHfL4CVuW0ZUyNjyOCgAS7pVmyH
	a9Jp0cT5rXFnkVTC5ouN0EgrFEK/fXHFHrGjQ2DBPCS/mquOV3HM9LxeRUV4YGUiF21wA2DkfeU
	ct8+or3Ek3lqHJJMjojTOM3Y3vc0VKYPC0LMNzbrN80HnuzgIg5oN8DkHC9iHpGHoshUnEIH4RF
	SV9bEi8zZCfN1feAFTzPLLCeb8xYjE4hi9q+ELhgjOPJi9OdlBuiBcnpaUGdJdCWuPCQbVv6JH2
	Hn7EXSxviZ/9lQSllYLAn3VHZKubqx8rrDun/JfhjyfvB4GV55bSZis2lPIXLrp35sgjFNj+dqQ
	2D7Qdr1kQJmbJ1jb7X7A7GKGSWlbkqkIbgMDxDvQ9xIrZ+aosGLu/91FaOigbmu5Bmh4Gf1lfgZ
	8DzdBCpgMlhPxEVxqkuAqmTw==
X-Received: by 2002:a05:7022:6183:b0:123:35cb:96e3 with SMTP id a92af1059eb24-1244b37e603mr12727280c88.46.1768943088165;
        Tue, 20 Jan 2026 13:04:48 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm19748304c88.4.2026.01.20.13.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 13:04:47 -0800 (PST)
Message-ID: <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com>
Date: Tue, 20 Jan 2026 18:04:43 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU
 swap
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260120004720.1886632-1-p@1g4.org>
 <20260120004720.1886632-2-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260120004720.1886632-2-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210606-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C2DD54C941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/01/2026 21:48, Paul Moses wrote:
> Switch act_gate parameters to an RCU-protected pointer and update schedule
> changes using a prepare-then-swap pattern. This avoids races between the
> timer/data paths and configuration updates, and cancels the hrtimer
> before swapping schedules.
> 
> A gate action replace could free and swap schedules while the hrtimer
> callback or data path still dereferences the old entries, leaving a
> use-after-free window during updates. The deferred swap and RCU free
> close that window. A reproducer is available on request.
> 
> Also clear params on early error for newly created actions to avoid
> leaving a dangling reference.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..3ee07c3deaf97 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -6,6 +6,7 @@
>   #include <linux/kernel.h>
>   #include <linux/string.h>
>   #include <linux/errno.h>
> +#include <linux/limits.h>

Do you really need to include this?

> [...]
> @@ -69,12 +71,14 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
>   {
>   	struct tcf_gate *gact = container_of(timer, struct tcf_gate,
>   					     hitimer);
> -	struct tcf_gate_params *p = &gact->param;
> +	struct tcf_gate_params *p;

When adding/editing local variables, you should adhere to the
reverse xmas tree style [1].

>   	spin_lock(&gact->tcf_lock);

Shouldn't you call rcu_read_lock before this line now?

> +	p = rcu_dereference_protected(gact->param,
> +				      lockdep_is_held(&gact->tcf_lock));
> [...]
>   static int tcf_gate_init(struct net *net, struct nlattr *nla,
> @@ -296,20 +296,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   			 struct netlink_ext_ack *extack)
>   {
>   	struct tc_action_net *tn = net_generic(net, act_gate_ops.net_id);
> -	enum tk_offsets tk_offset = TK_OFFS_TAI;
> -	bool bind = flags & TCA_ACT_FLAGS_BIND;
>   	struct nlattr *tb[TCA_GATE_MAX + 1];
>   	struct tcf_chain *goto_ch = NULL;
> -	u64 cycletime = 0, basetime = 0;
> -	struct tcf_gate_params *p;
> -	s32 clockid = CLOCK_TAI;
> +	struct tcf_gate_params *p, *oldp;
>   	struct tcf_gate *gact;
>   	struct tc_gate *parm;
> -	int ret = 0, err;
> -	u32 gflags = 0;
> -	s32 prio = -1;
> +	struct tcf_gate_params newp = { };

Abide by reverse xmas tree when adding local variables.

> [...]
> +	bool clockid_set = false;

I could be missing something, but I don't believe you need this
boolean.

> [...]
> @@ -323,6 +329,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   
>   	if (tb[TCA_GATE_CLOCKID]) {
>   		clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
> +		clockid_set = true;
>   		switch (clockid) {

Instead of using clockid_set and repeating the switch statament.
You could put this if-statement after you already have oldp and do the
following:

          if (tb[TCA_GATE_CLOCKID]) {
                  clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
                  switch (clockid) {
                  case CLOCK_REALTIME:
                          tk_offset = TK_OFFS_REAL;
                          break;
                  case CLOCK_MONOTONIC:
                          tk_offset = TK_OFFS_MAX;
                          break;
                  case CLOCK_BOOTTIME:
                          tk_offset = TK_OFFS_BOOT;
                          break;
                  case CLOCK_TAI:
                          tk_offset = TK_OFFS_TAI;
                          break;
                  default:
                          NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
                          return -EINVAL;
                  }
          } else if (ret != ACT_P_CREATED) {
                  clockid = oldp->tcfg_clockid;
                  tk_offset = gact->tk_offset;
          }

> [...]
> -	if (tb[TCA_GATE_CYCLE_TIME])
> +	if (ret == ACT_P_CREATED)
> +		update_timer = true;
> [...]

Here you are assigning update_timer to true when the op is a create...

> [...]
> +	if (update_timer && ret != ACT_P_CREATED)
> +		hrtimer_cancel(&gact->hitimer);

.. however in the if-statement where it is used you are only allowing
updates. This looks weird.

> [...]
> +free_p:
> +	release_entry_list(&p->entries);
> +	kfree(p);

The 2 lines of code above are being repeated below and in
tcf_gate_params_release. You should put them in a common function.

> +release_new_entries:
> +	release_entry_list(&newp.entries);
> +put_chain:
>   	if (goto_ch)
>   		tcf_chain_put_by_act(goto_ch);
>   release_idr:
> -	/* action is not inserted in any list: it's safe to init hitimer
> -	 * without taking tcf_lock.
> -	 */
> -	if (ret == ACT_P_CREATED)
> -		gate_setup_timer(gact, gact->param.tcfg_basetime,
> -				 gact->tk_offset, gact->param.tcfg_clockid,
> -				 true);
> +	if (ret == ACT_P_CREATED) {
> +		p = rcu_dereference_protected(gact->param, 1);
> +		if (p) {
> +			release_entry_list(&p->entries);
> +			kfree(p);
> +			rcu_assign_pointer(gact->param, NULL);
> +		}
> +	}
>   	tcf_idr_release(*a, bind);

Also, the AI review [2] pointed out a real issue.
It's easy to reproduce by running something like:

tc action add action gate base-time 200000000000ns \
      sched-entry close 0ns index 10

I think overall you have the right idea - RCU seems like a good fit here.
The issue is that this patch is confusing because it seems like you are
trying to fix the bug and perform cleanups at the same time.
If that is the case, can you try breaking this patch into two? Do one to
fix the bug (introducing RCU and etc) and another for the cleanups.

[1] 
https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
[2] 
https://netdev-ai.bots.linux.dev/ai-review.html?id=cdc17d0d-fd59-41a8-9c8d-1a42699167fd#patch-0

cheers,
Victor

