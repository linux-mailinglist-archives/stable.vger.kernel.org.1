Return-Path: <stable+bounces-214636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MQTJ0bEhWnAGAQAu9opvQ
	(envelope-from <stable+bounces-214636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:36:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B1FCB44
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B381430131F6
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE7377551;
	Fri,  6 Feb 2026 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IoGE6Iz3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39C376BF6
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374209; cv=pass; b=LAbRptwrOUo8rWXdih0okDvdlQRBO26avb2ZN259h+rLh1stpc0J6CO+9w54nR0VPYEN+qAMcfVEXwD45DO2bIEl/31GBshHujkHJuw1tOO2mNYyCPih6QQ82f7Ym1ceR3lig16WpIG+wGW4vitydJBu1KycBBFj4DmCUPC02dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374209; c=relaxed/simple;
	bh=GwsZMQ3i1go4w0scHZ+m1mBsqJNxv0WunqabD0BSZyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tttDI5UGH2CWIkuQ9+1SZvUwc8LM2sg3kuKMG1ILoO9EmSXMdCN31AFq4DSGXRS3qdHWaanLrzqVltIoT0981ItMOKebKpNSgJKzH+OJx87tSkLKnHIY8sBwt14T+3i0+xaMEUulE97zQxAJ1SXctY2N6N4DqQReqfNh1awHKxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IoGE6Iz3; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649bb5a0ba1so511525d50.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770374208; cv=none;
        d=google.com; s=arc-20240605;
        b=dJy3Aqn35CMrOUThBpu418L59DKim+7hzH1RryXn9Edtfzi3uG+d7zl3obIzt4+5eS
         GKTustFgzhi7+a3NcTOQ8RRoewK+Hb4kGnS6KxtDzesdGPurSoap6Ju9nmf/4HojNF/6
         ahqe5HGCPHwrF73ME8wThujVAvAJoNhV7GAHkCSRKZe7UaH3ZMelsGqGrsM1jjhfRIEP
         G/MK4JOkDwOat78e87W/omHbBJW4XLyFk1V4GDVtsFdXnf0jTl5jMPeZ76milYxjv06I
         0CDOdI2KAIvhdPo45Lz4oQ1N0TAqTGqMbR8bfyI9YRPFwUvFMUTdnhfh0aRILs80M+fE
         3AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PzGmXVQk3J2sigNGOODPHGi+on8K6hw6Su0XUOZ0YCk=;
        fh=XyAwryX2NkEZGUgw4IY3D56YhU5lPh9m6MNoNbFA6Ps=;
        b=aIy/cKwaKxMhV15+SOedGGDweSoXANKbsOL4p3LKHqqBqX4tYwa88WjdYbFIE3E9Nq
         Cl3d2DYkgzRH165LsKYCq8znaLiPThmJOBskig0Tpbjr9F3mL3olNLHxxgWBv+0o58oF
         Wf2RMZbv1xpIb9SOwsW7lb+1+z6LV94CZ95MlqUTEM728uRHMnq7orumY+sPpMoo7MVl
         Dj58WSsLe+a2ONrtKBj8sqUemiZE1gwUGJl7LD2o9xKTj++vI0tjCwoLc5Rh/pyTykyT
         mdK8kgOP5h3BwkLyhafo7JgMto6xyrueShsg1YrsapgeARmZKeJ7JhiDLWxm6SXGpKRQ
         i7yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770374208; x=1770979008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzGmXVQk3J2sigNGOODPHGi+on8K6hw6Su0XUOZ0YCk=;
        b=IoGE6Iz39HIcqxPJkxs72Xo6G1dxaxsbmYq+DxPMgNjCUzVO6S9uarwHMTVx05NqZ8
         e5H/oWiVwQk1mc3+h2pLIJI4O0jXcAL5BaXphVHTIFMwckagUfR2zeY1or8jOed7Drgf
         qzAqkByF2Io20Xy6MOvU91q7VZBOkn/2Xuo4G74UCArPXWhfYITGBOxa5RlD5VE1YY7l
         40Y23CwkglFURxOh9XOqdTd9oMIbcvSVd15l+P0byOpKYEycQztBSUM/BQW1Cl1w2QKE
         9BVFECa+ZlGa9mGqAN2Mp4JmK+ieUt7+tfgReOrUKuZ95RJqN36zLuveX2h/UYfdjpD1
         +r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770374208; x=1770979008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzGmXVQk3J2sigNGOODPHGi+on8K6hw6Su0XUOZ0YCk=;
        b=HjjuACqaeApB0szmgnVWDyiYf3Vxc7jlQpUOe/gQ5CtlTDzdspWz2yyHXA2+R+9EpF
         smqK5r6Iyv3E0KDqFvekHa/KrF8fR539p34jpgSzzDdSjl98oINELCRmDuNE/qfeZpDD
         3uf2oZw5LGi4zvan6wASUdtHZCoO6RDJ1xmwVwqCxde/lh3frwf05ZBNiyDqKBGYX/1j
         QydwRHLU78j5Cc+X7OGM/sQHj1oHwMKHKrj+9RuowrRtrgzqPdaIYInbb82N1JZ/dr87
         UyLqVECnuic59Kom+pz4jP9zn2QrrbSvRmUcVOs2QpwtGKWn4uNrYWflGiYKgRFtYGJW
         XQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGT0CvqeFSeZWD1kTK5f6IrUeBsj4yCN4tEm/F5mV7oCGw3+09nOgQo8lO5dvDd7ops1kFznY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bbdJYgX2e1pTJrAQcQ0UxAJvAQxabmIQvPNSejCEB+OTMRru
	D5ZkwV+fiaNjFtQntk+QT3b2OG10mSzGHn5KMmm0zHs/cBpmJKK59p3CRX8Q7nkEx9pjSr/X6cV
	rdE933lwsDji7oQoSZ62DK/fSqYFxhfWXGp+EYMpk
X-Gm-Gg: AZuq6aKZTymVz08K6V+2NC5fRq77Gy1cBPOAVKjJeRj6hS1iMsPIuWwt9NVZaIRhnuE
	qo/IKvERPZWoesiPNBJPlJ8iicCHPGL7OAPPJFDcTVU6+kmm+HChbsL4l6Qa/s8HxXQTwbueZn2
	v1WltDaO1uYQvdd7kw6RQOSmplGmCT8/mQ6M84hUVu02UmXwopLXt5tXMcP3G0e4e55QpD+Tfgi
	49Gy47cl4aFqL4wa9azMYO6pES8U8gRrMM4ZAQqohzXlA3yrHCMsifnhZlHDgnJDDzSCmnf73ly
	wABz2Pavig==
X-Received: by 2002:a05:690e:1659:b0:649:3bd8:22b0 with SMTP id
 956f58d0204a3-649f217bb98mr1518481d50.83.1770374208195; Fri, 06 Feb 2026
 02:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205150958.412278-1-p@1g4.org> <20260205150958.412278-2-p@1g4.org>
In-Reply-To: <20260205150958.412278-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 6 Feb 2026 07:36:37 -0300
X-Gm-Features: AZwV_QiYtWaWMP5EdtymmE2V4jK-w8k2i3KrgkWKLrY_WU-3x2CuPcl5QVsU4yI
Message-ID: <CA+NMeC_v8bQo2tFUYiD1faMJ0Gd9FFbqmPHCvBUD7HW_yoCx0A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-214636-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C8B1FCB44
X-Rspamd-Action: no action

> The gate action can be replaced while the hrtimer callback or dump path is
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates under
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..4a1a10bfe3e62 100644
> [...]
> -static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
> -                            enum tk_offsets tko, s32 clockid,
> -                            bool do_init)
> [...]
> +static void gate_timer_setup(struct tcf_gate *gact, s32 clockid,
> +                            enum tk_offsets tko)
> [...]

I don't believe you need to change the function name here.

> [...]
> @@ -323,20 +370,11 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>
>         if (tb[TCA_GATE_CLOCKID]) {
>                 clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
> -               switch (clockid) {
> -               case CLOCK_REALTIME:
> -                       tk_offset = TK_OFFS_REAL;
> -                       break;
> -               case CLOCK_MONOTONIC:
> -                       tk_offset = TK_OFFS_MAX;
> -                       break;
> -               case CLOCK_BOOTTIME:
> -                       tk_offset = TK_OFFS_BOOT;
> -                       break;
> -               case CLOCK_TAI:
> -                       tk_offset = TK_OFFS_TAI;
> -                       break;
> -               default:
> +               clockid_provided = true;
> +               if (clockid != CLOCK_REALTIME &&
> +                   clockid != CLOCK_MONOTONIC &&
> +                   clockid != CLOCK_BOOTTIME &&
> +                   clockid != CLOCK_TAI) {
>                         NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
>                         return -EINVAL;
>                 }

This is better than what you had before, however it still
is redundant given that you do the switch statement later
and perform the same validation again. If there's no reason to
keep this code, you probably can also get rid of "clockid_provided".

> @@ -366,6 +404,37 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> +
> +       if (ret != ACT_P_CREATED) {
> +               rcu_read_lock();
> +               old_p = rcu_dereference(gact->param);
> +               if (old_p) {

When do you believe old_p might be NULL here?
From what I understand, you can't arrive here while
a delete for the same action instance is happening in parallel.
Were you able to create such scenario when testing gate?

> [...]
> +       if (use_old_entries) {
> +               err = tcf_gate_copy_entries(p, old_p, extack);
> +               if (err)
> +                       goto unlock;
> +
> +               if (!tb[TCA_GATE_CYCLE_TIME])
> +                       cycletime = old_p->tcfg_cycletime;

Why did you keep this one as in v4?
You don't want to reuse the old "cycletime" if the user
specified new entries?
Not saying you are necessarily wrong.
Just trying to understand your logic.

> [...]
> -chain_put:
> +unlock:
>         spin_unlock_bh(&gact->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> +       release_entry_list(&p->entries);
> +       kfree(p);

The 4 lines above look exactly like what you
do in err_free. Can't you label them as err_free
and remove the lines below?

> [...]
> +err_free:
> +       if (goto_ch)
> +               tcf_chain_put_by_act(goto_ch);
> +       release_entry_list(&p->entries);
> +       kfree(p);
> +       goto release_idr;
> +}
> [...]
>  static void tcf_gate_cleanup(struct tc_action *a)
> @@ -458,9 +594,10 @@ static void tcf_gate_cleanup(struct tc_action *a)
>         struct tcf_gate *gact = to_gate(a);
>         struct tcf_gate_params *p;
>
> -       p = &gact->param;
>         hrtimer_cancel(&gact->hitimer);
> -       release_entry_list(&p->entries);
> +       p = rcu_replace_pointer(gact->param, NULL, 1);
> +       if (p)
> +               call_rcu(&p->rcu, tcf_gate_params_free_rcu);
>  }

Sorry, I think I lacked precision in my last comment.
I meant that you should've removed the rtnl requirement
(which you did), but also use rcu_dereference_protected as
act_vlan does. This relates to my previous comment on "old_p"
being NULL. I don't believe you need to set this to NULL
unless you were able to reproduce the scenario I described
earlier.

>  static int dumping_entry(struct sk_buff *skb,
> @@ -512,7 +649,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
>         spin_lock_bh(&gact->tcf_lock);
>         opt.action = gact->tcf_action;
>
> -       p = &gact->param;
> +       p = rcu_dereference_protected(gact->param,
> +                                     lockdep_is_held(&gact->tcf_lock));

You could've kept the rcu_read_lock approach here.
One of the main advantages of making the params rcu
is being able to dump without the tcf_lock.

cheers,
Victor

