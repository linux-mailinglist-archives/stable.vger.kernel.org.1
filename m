Return-Path: <stable+bounces-219626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKJSB3T/nmlAYgQAu9opvQ
	(envelope-from <stable+bounces-219626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:56:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49A1986B4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEAC13055639
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864C3D1CAD;
	Wed, 25 Feb 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bg8T4Y21"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5E392815
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027745; cv=pass; b=DS6eiOzMgr+trffTQ2Cp5OesefFVUPro6/hX9D64DnM6Xpum1zEw1AhW18i5Qo6FmeUOVZCudciMr0+8TYa1NfIw4U6lL5EndbdcodSWvHVyNSRnq9UDKoBQ/wTT2XOHwUeE3Jdruwwx0dDgcfan52rJQVCe5bEXIjWPHDwEBsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027745; c=relaxed/simple;
	bh=6kKAlFgYuTHk2LVbvOmVRV8q0D1KA45DRls8/waiV6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBgsL/6/B7K7AojyKCUWC/gQcvAYAdS944BQ7dFMPyP5pHTMF3HPrejXZL0k6EbtFYpF8GsIrcdGsVWGZ1WX3iHEPcznt7uX1I9o70yb83BFXDp2y7Pa3Sl8PBWWnqeFg7bHZ/SE7CFAhZIaPVdq/Chnj0hZsBfwi+FTc3mGp9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bg8T4Y21; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso820741a91.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:55:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772027741; cv=none;
        d=google.com; s=arc-20240605;
        b=keBb5CqG94urRe9YOqfWW5MzQ9PfuG0FWhhCaLHfBoBM7wSYm2SEFWZbAohcWqppac
         pvYafALSERkk5PVFLcmifkzS11uzrR3jczRvbVRBC4Gm/9E2+Im1fFcHDloXCsMdWvLQ
         f4inF+uYYfmOHCUEIhG0NqSP1yMjw5WGqZDke7db6hezEY6TdsgsEZQuKvX2W/Zz2PPE
         0Zn9OEJDoyxITGmG/TIreADVMcnGxd+rdRE8EYqgHgQaEgE6W1u+9q9KJV3u/44RfOq1
         X1SaiyzSHb7LXknbWSDklr7m0bJP2Q+K8yEnzYU2lq7XQR9cJZO6swgncWytIL3VrbBi
         DLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gwvQxWwqI9n9M/n904tFcAVBAXJSGeydCNZN3rYyCc0=;
        fh=UltBR3Dr1I2bXYRgjL2qC4Za3VxJ1iH9D3Y+g+Iioqk=;
        b=jPlnVqUw8YigxeOzFCIJe3fuNkDTAkLuGwuH1jqElqQqSsv9o5s8rs9gVthTKdSKsQ
         X2v69ZMhinix5u77ej3IXIo3PEXDKzCPXVLPQ0A6oJI17e9JHwl3uyIwE20Rf4jbcxUk
         AplbRLgZOO6ZtFOzuipHPmXt/qxppb+Hq8FzOLGMD2NJ6iuCdlzfVWbWqzDchzA9YWDq
         sdPlDhJl8J/GtNjZEnhoQFaaPFSJwCVzpxXieAs5Ddd0avyvmFT9flza8qIXydsnzdlM
         FkG96qGV76JnM/AHsUHxsda/rJPPPPhjPeUPCCdIXhYipHbN2gwT6FxJj71FfTNXIFrZ
         i/wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027741; x=1772632541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwvQxWwqI9n9M/n904tFcAVBAXJSGeydCNZN3rYyCc0=;
        b=bg8T4Y21YRxgX62ER8gPLWTiASc1NFMKCpJEw4sBjdzG+oj2Vg2g2iZdnW0PzKjnIK
         QdRpHzCAfS6bnoLrTKgWSROjFWpAZfIr1Ck+VHsS6yVJom9cLQiqYmfydmW1Z4Qfy8dv
         uFj6dv7S8JiZmCPr0RXCCgxwJtOdTti+6y/jvwSSMkcWP2YropVS6jDBz0pf6NlFwTET
         HvtzIq0OVN3GzQYNiXNzyVtXDdbno54PzRqrF/GTFR53EbcmNRvUgDFbF4907Ap6RlQp
         BSgHmOZTAiWbPAYpkaqmnmdCdwVwoiRMdjC57puWzJwK3BJTwGxTmGlnuABoNYaQezpS
         x8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027741; x=1772632541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwvQxWwqI9n9M/n904tFcAVBAXJSGeydCNZN3rYyCc0=;
        b=UXu4fvG9zNIfblhIMSQmlVWz/aMhrVMtVVAupQ5kbfQFwsEJGDOtp26gMc04KSOB2N
         48uWucuQhf47I4iOeLYPmfPkgtvQgLOLpYwk47WnGZBrkblZjyImJyXV4Dbxpy0Z4lqA
         o/oOQxE1z+fsH02yMsJfw0n4YTAbXSPcZF4Gx4pgY9mbMcpCu1hKCIkic/l2gJMSLT/f
         2nVhfEcdi5V9a6v2VdXfjs8+D6iPiHcVa3YSTpUReqOoO7nqi/jHVJJIJ6tXXM78PAVe
         wv2il3mFaDEQxzNVCjn+A/iN5J8f3p8uSqEGvj8Bgn/NcUNS2FDVEA27pBgdFNIwr8Tp
         wbnw==
X-Forwarded-Encrypted: i=1; AJvYcCXODs49v5sqceyMOAXsVpVkI0SwTN11J/7KMtW7EnHJyVdfA+/AvviLc+8ycPKftoBp2Je2R+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/vwwAtQWtVqLO2e2RG9usvaLKY5cHXCyDksXZJwcapvRKzBu
	Z7OQSVKEiMw3B4aBfwH6GManh24F8QnQy1PpJcQVzN5eeSOpYPN9+zRiwc/UtmhOedURBe1wZV1
	jFXSwhol3h4urP3RP1yYsxrD1h3HcRJfZkpX7NrtE
X-Gm-Gg: ATEYQzzF0cui+GWJIeUK0+nQu6rrxmyRb4RutYzAwrKl4zRVBTOTFvluAoS2diALIke
	V/3THfMSwcXNQXpXO4VN0U5RFGHheBvdSsl8sgbAAQWC2IW1i3sqcxvMwov8XMdacp0FgiHQNA9
	l0HyKZJWVlbGRs+iqmlDth/lr9Lqt3YRJxi7LOdiAFZTF+dMGBi6MZeNNGEVC1cH1y6TvpibVf5
	dMq07gxf6ZWaBGT3Y3/KTYsyHUiiZieuPIgyKaidcEAPK1MtjfgnEzWkLu2ejzX9Zywqh9NQ7co
	3B4xsb+C5/+eJbSLvQjdey4hcA==
X-Received: by 2002:a17:90b:562d:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-358ae8dc5c2mr13755299a91.33.1772027741510; Wed, 25 Feb 2026
 05:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org>
In-Reply-To: <20260223150512.2251594-2-p@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 08:55:30 -0500
X-Gm-Features: AaiRm51iUzrv7kkgP4Qa_HtuJ02HHLwugXa07cFGEfyrFTjgdqdb15ZTfo4_nsU
Message-ID: <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Vladimir Oltean <olteanv@gmail.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219626-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,nxp.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,act_gate_ops.net_id:url]
X-Rspamd-Queue-Id: AA49A1986B4
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:05=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
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
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Looks good - but can we have Vlad (added to Cc) review this as well in
case it breaks anything in the offload case? More specifically,
regarding an update policy..

cheers,
jamal

> ---
>  include/net/tc_act/tc_gate.h |  33 ++++-
>  net/sched/act_gate.c         | 265 ++++++++++++++++++++++++-----------
>  2 files changed, 212 insertions(+), 86 deletions(-)
>
> diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
> index c1a67149c6b62..5223c00279d5a 100644
> --- a/include/net/tc_act/tc_gate.h
> +++ b/include/net/tc_act/tc_gate.h
> @@ -32,6 +32,7 @@ struct tcf_gate_params {
>         s32                     tcfg_clockid;
>         size_t                  num_entries;
>         struct list_head        entries;
> +       struct rcu_head         rcu;
>  };
>
>  #define GATE_ACT_GATE_OPEN     BIT(0)
> @@ -39,7 +40,7 @@ struct tcf_gate_params {
>
>  struct tcf_gate {
>         struct tc_action        common;
> -       struct tcf_gate_params  param;
> +       struct tcf_gate_params __rcu *param;
>         u8                      current_gate_status;
>         ktime_t                 current_close_time;
>         u32                     current_entry_octets;
> @@ -51,47 +52,65 @@ struct tcf_gate {
>
>  #define to_gate(a) ((struct tcf_gate *)a)
>
> +static inline struct tcf_gate_params *tcf_gate_params_locked(const struc=
t tc_action *a)
> +{
> +       struct tcf_gate *gact =3D to_gate(a);
> +
> +       return rcu_dereference_protected(gact->param,
> +                                        lockdep_is_held(&gact->tcf_lock)=
);
> +}
> +
>  static inline s32 tcf_gate_prio(const struct tc_action *a)
>  {
> +       struct tcf_gate_params *p;
>         s32 tcfg_prio;
>
> -       tcfg_prio =3D to_gate(a)->param.tcfg_priority;
> +       p =3D tcf_gate_params_locked(a);
> +       tcfg_prio =3D p->tcfg_priority;
>
>         return tcfg_prio;
>  }
>
>  static inline u64 tcf_gate_basetime(const struct tc_action *a)
>  {
> +       struct tcf_gate_params *p;
>         u64 tcfg_basetime;
>
> -       tcfg_basetime =3D to_gate(a)->param.tcfg_basetime;
> +       p =3D tcf_gate_params_locked(a);
> +       tcfg_basetime =3D p->tcfg_basetime;
>
>         return tcfg_basetime;
>  }
>
>  static inline u64 tcf_gate_cycletime(const struct tc_action *a)
>  {
> +       struct tcf_gate_params *p;
>         u64 tcfg_cycletime;
>
> -       tcfg_cycletime =3D to_gate(a)->param.tcfg_cycletime;
> +       p =3D tcf_gate_params_locked(a);
> +       tcfg_cycletime =3D p->tcfg_cycletime;
>
>         return tcfg_cycletime;
>  }
>
>  static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
>  {
> +       struct tcf_gate_params *p;
>         u64 tcfg_cycletimeext;
>
> -       tcfg_cycletimeext =3D to_gate(a)->param.tcfg_cycletime_ext;
> +       p =3D tcf_gate_params_locked(a);
> +       tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
>
>         return tcfg_cycletimeext;
>  }
>
>  static inline u32 tcf_gate_num_entries(const struct tc_action *a)
>  {
> +       struct tcf_gate_params *p;
>         u32 num_entries;
>
> -       num_entries =3D to_gate(a)->param.num_entries;
> +       p =3D tcf_gate_params_locked(a);
> +       num_entries =3D p->num_entries;
>
>         return num_entries;
>  }
> @@ -105,7 +124,7 @@ static inline struct action_gate_entry
>         u32 num_entries;
>         int i =3D 0;
>
> -       p =3D &to_gate(a)->param;
> +       p =3D tcf_gate_params_locked(a);
>         num_entries =3D p->num_entries;
>
>         list_for_each_entry(entry, &p->entries, list)
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..d09013ae1892a 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -32,9 +32,12 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
>         return KTIME_MAX;
>  }
>
> -static void gate_get_start_time(struct tcf_gate *gact, ktime_t *start)
> +static void tcf_gate_params_free_rcu(struct rcu_head *head);
> +
> +static void gate_get_start_time(struct tcf_gate *gact,
> +                               const struct tcf_gate_params *param,
> +                               ktime_t *start)
>  {
> -       struct tcf_gate_params *param =3D &gact->param;
>         ktime_t now, base, cycle;
>         u64 n;
>
> @@ -69,12 +72,14 @@ static enum hrtimer_restart gate_timer_func(struct hr=
timer *timer)
>  {
>         struct tcf_gate *gact =3D container_of(timer, struct tcf_gate,
>                                              hitimer);
> -       struct tcf_gate_params *p =3D &gact->param;
>         struct tcfg_gate_entry *next;
> +       struct tcf_gate_params *p;
>         ktime_t close_time, now;
>
>         spin_lock(&gact->tcf_lock);
>
> +       p =3D rcu_dereference_protected(gact->param,
> +                                     lockdep_is_held(&gact->tcf_lock));
>         next =3D gact->next_entry;
>
>         /* cycle start, clear pending bit, clear total octets */
> @@ -225,6 +230,35 @@ static void release_entry_list(struct list_head *ent=
ries)
>         }
>  }
>
> +static int tcf_gate_copy_entries(struct tcf_gate_params *dst,
> +                                const struct tcf_gate_params *src,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct tcfg_gate_entry *entry;
> +       int i =3D 0;
> +
> +       list_for_each_entry(entry, &src->entries, list) {
> +               struct tcfg_gate_entry *new;
> +
> +               new =3D kzalloc(sizeof(*new), GFP_ATOMIC);
> +               if (!new) {
> +                       NL_SET_ERR_MSG(extack, "Not enough memory for ent=
ry");
> +                       return -ENOMEM;
> +               }
> +
> +               new->index      =3D entry->index;
> +               new->gate_state =3D entry->gate_state;
> +               new->interval   =3D entry->interval;
> +               new->ipv        =3D entry->ipv;
> +               new->maxoctets  =3D entry->maxoctets;
> +               list_add_tail(&new->list, &dst->entries);
> +               i++;
> +       }
> +
> +       dst->num_entries =3D i;
> +       return 0;
> +}
> +
>  static int parse_gate_list(struct nlattr *list_attr,
>                            struct tcf_gate_params *sched,
>                            struct netlink_ext_ack *extack)
> @@ -270,24 +304,44 @@ static int parse_gate_list(struct nlattr *list_attr=
,
>         return err;
>  }
>
> -static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
> -                            enum tk_offsets tko, s32 clockid,
> -                            bool do_init)
> +static bool gate_timer_needs_cancel(u64 basetime, u64 old_basetime,
> +                                   enum tk_offsets tko,
> +                                   enum tk_offsets old_tko,
> +                                   s32 clockid, s32 old_clockid)
>  {
> -       if (!do_init) {
> -               if (basetime =3D=3D gact->param.tcfg_basetime &&
> -                   tko =3D=3D gact->tk_offset &&
> -                   clockid =3D=3D gact->param.tcfg_clockid)
> -                       return;
> +       return basetime !=3D old_basetime ||
> +              clockid !=3D old_clockid ||
> +              tko !=3D old_tko;
> +}
>
> -               spin_unlock_bh(&gact->tcf_lock);
> -               hrtimer_cancel(&gact->hitimer);
> -               spin_lock_bh(&gact->tcf_lock);
> +static int gate_clock_resolve(s32 clockid, enum tk_offsets *tko,
> +                             struct netlink_ext_ack *extack)
> +{
> +       switch (clockid) {
> +       case CLOCK_REALTIME:
> +               *tko =3D TK_OFFS_REAL;
> +               return 0;
> +       case CLOCK_MONOTONIC:
> +               *tko =3D TK_OFFS_MAX;
> +               return 0;
> +       case CLOCK_BOOTTIME:
> +               *tko =3D TK_OFFS_BOOT;
> +               return 0;
> +       case CLOCK_TAI:
> +               *tko =3D TK_OFFS_TAI;
> +               return 0;
> +       default:
> +               NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
> +               return -EINVAL;
>         }
> -       gact->param.tcfg_basetime =3D basetime;
> -       gact->param.tcfg_clockid =3D clockid;
> -       gact->tk_offset =3D tko;
> -       hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_M=
ODE_ABS_SOFT);
> +}
> +
> +static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
> +                            enum tk_offsets tko)
> +{
> +       WRITE_ONCE(gact->tk_offset, tko);
> +       hrtimer_setup(&gact->hitimer, gate_timer_func, clockid,
> +                     HRTIMER_MODE_ABS_SOFT);
>  }
>
>  static int tcf_gate_init(struct net *net, struct nlattr *nla,
> @@ -296,15 +350,22 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>                          struct netlink_ext_ack *extack)
>  {
>         struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id=
);
> -       enum tk_offsets tk_offset =3D TK_OFFS_TAI;
> +       u64 cycletime =3D 0, basetime =3D 0, cycletime_ext =3D 0;
> +       struct tcf_gate_params *p =3D NULL, *old_p =3D NULL;
> +       enum tk_offsets old_tk_offset =3D TK_OFFS_TAI;
> +       const struct tcf_gate_params *cur_p =3D NULL;
>         bool bind =3D flags & TCA_ACT_FLAGS_BIND;
>         struct nlattr *tb[TCA_GATE_MAX + 1];
> +       enum tk_offsets tko =3D TK_OFFS_TAI;
>         struct tcf_chain *goto_ch =3D NULL;
> -       u64 cycletime =3D 0, basetime =3D 0;
> -       struct tcf_gate_params *p;
> +       s32 timer_clockid =3D CLOCK_TAI;
> +       bool use_old_entries =3D false;
> +       s32 old_clockid =3D CLOCK_TAI;
> +       bool need_cancel =3D false;
>         s32 clockid =3D CLOCK_TAI;
>         struct tcf_gate *gact;
>         struct tc_gate *parm;
> +       u64 old_basetime =3D 0;
>         int ret =3D 0, err;
>         u32 gflags =3D 0;
>         s32 prio =3D -1;
> @@ -321,26 +382,8 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
>         if (!tb[TCA_GATE_PARMS])
>                 return -EINVAL;
>
> -       if (tb[TCA_GATE_CLOCKID]) {
> +       if (tb[TCA_GATE_CLOCKID])
>                 clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
> -               switch (clockid) {
> -               case CLOCK_REALTIME:
> -                       tk_offset =3D TK_OFFS_REAL;
> -                       break;
> -               case CLOCK_MONOTONIC:
> -                       tk_offset =3D TK_OFFS_MAX;
> -                       break;
> -               case CLOCK_BOOTTIME:
> -                       tk_offset =3D TK_OFFS_BOOT;
> -                       break;
> -               case CLOCK_TAI:
> -                       tk_offset =3D TK_OFFS_TAI;
> -                       break;
> -               default:
> -                       NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
> -                       return -EINVAL;
> -               }
> -       }
>
>         parm =3D nla_data(tb[TCA_GATE_PARMS]);
>         index =3D parm->index;
> @@ -366,6 +409,60 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
>                 return -EEXIST;
>         }
>
> +       gact =3D to_gate(*a);
> +
> +       err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, exta=
ck);
> +       if (err < 0)
> +               goto release_idr;
> +
> +       p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +       if (!p) {
> +               err =3D -ENOMEM;
> +               goto chain_put;
> +       }
> +       INIT_LIST_HEAD(&p->entries);
> +
> +       use_old_entries =3D !tb[TCA_GATE_ENTRY_LIST];
> +       if (!use_old_entries) {
> +               err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extac=
k);
> +               if (err < 0)
> +                       goto err_free;
> +               use_old_entries =3D !err;
> +       }
> +
> +       if (ret =3D=3D ACT_P_CREATED && use_old_entries) {
> +               NL_SET_ERR_MSG(extack, "The entry list is empty");
> +               err =3D -EINVAL;
> +               goto err_free;
> +       }
> +
> +       if (ret !=3D ACT_P_CREATED) {
> +               rcu_read_lock();
> +               cur_p =3D rcu_dereference(gact->param);
> +
> +               old_basetime  =3D cur_p->tcfg_basetime;
> +               old_clockid   =3D cur_p->tcfg_clockid;
> +               old_tk_offset =3D READ_ONCE(gact->tk_offset);
> +
> +               basetime      =3D old_basetime;
> +               cycletime_ext =3D cur_p->tcfg_cycletime_ext;
> +               prio          =3D cur_p->tcfg_priority;
> +               gflags        =3D cur_p->tcfg_flags;
> +
> +               if (!tb[TCA_GATE_CLOCKID])
> +                       clockid =3D old_clockid;
> +
> +               err =3D 0;
> +               if (use_old_entries) {
> +                       err =3D tcf_gate_copy_entries(p, cur_p, extack);
> +                       if (!err && !tb[TCA_GATE_CYCLE_TIME])
> +                               cycletime =3D cur_p->tcfg_cycletime;
> +               }
> +               rcu_read_unlock();
> +               if (err)
> +                       goto err_free;
> +       }
> +
>         if (tb[TCA_GATE_PRIORITY])
>                 prio =3D nla_get_s32(tb[TCA_GATE_PRIORITY]);
>
> @@ -375,25 +472,26 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>         if (tb[TCA_GATE_FLAGS])
>                 gflags =3D nla_get_u32(tb[TCA_GATE_FLAGS]);
>
> -       gact =3D to_gate(*a);
> -       if (ret =3D=3D ACT_P_CREATED)
> -               INIT_LIST_HEAD(&gact->param.entries);
> +       if (tb[TCA_GATE_CYCLE_TIME])
> +               cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
>
> -       err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, exta=
ck);
> -       if (err < 0)
> -               goto release_idr;
> +       if (tb[TCA_GATE_CYCLE_TIME_EXT])
> +               cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]=
);
>
> -       spin_lock_bh(&gact->tcf_lock);
> -       p =3D &gact->param;
> +       err =3D gate_clock_resolve(clockid, &tko, extack);
> +       if (err)
> +               goto err_free;
> +       timer_clockid =3D clockid;
>
> -       if (tb[TCA_GATE_CYCLE_TIME])
> -               cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
> +       need_cancel =3D ret !=3D ACT_P_CREATED &&
> +                     gate_timer_needs_cancel(basetime, old_basetime,
> +                                             tko, old_tk_offset,
> +                                             timer_clockid, old_clockid)=
;
>
> -       if (tb[TCA_GATE_ENTRY_LIST]) {
> -               err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extac=
k);
> -               if (err < 0)
> -                       goto chain_put;
> -       }
> +       if (need_cancel)
> +               hrtimer_cancel(&gact->hitimer);
> +
> +       spin_lock_bh(&gact->tcf_lock);
>
>         if (!cycletime) {
>                 struct tcfg_gate_entry *entry;
> @@ -402,22 +500,20 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>                 list_for_each_entry(entry, &p->entries, list)
>                         cycle =3D ktime_add_ns(cycle, entry->interval);
>                 cycletime =3D cycle;
> -               if (!cycletime) {
> -                       err =3D -EINVAL;
> -                       goto chain_put;
> -               }
>         }
>         p->tcfg_cycletime =3D cycletime;
> +       p->tcfg_cycletime_ext =3D cycletime_ext;
>
> -       if (tb[TCA_GATE_CYCLE_TIME_EXT])
> -               p->tcfg_cycletime_ext =3D
> -                       nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
> -
> -       gate_setup_timer(gact, basetime, tk_offset, clockid,
> -                        ret =3D=3D ACT_P_CREATED);
> +       if (need_cancel || ret =3D=3D ACT_P_CREATED)
> +               gate_setup_timer(gact, timer_clockid, tko);
>         p->tcfg_priority =3D prio;
>         p->tcfg_flags =3D gflags;
> -       gate_get_start_time(gact, &start);
> +       p->tcfg_basetime =3D basetime;
> +       p->tcfg_clockid =3D timer_clockid;
> +       gate_get_start_time(gact, p, &start);
> +
> +       old_p =3D rcu_replace_pointer(gact->param, p,
> +                                   lockdep_is_held(&gact->tcf_lock));
>
>         gact->current_close_time =3D start;
>         gact->current_gate_status =3D GATE_ACT_GATE_OPEN | GATE_ACT_PENDI=
NG;
> @@ -434,11 +530,15 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
>
> +       if (old_p)
> +               call_rcu(&old_p->rcu, tcf_gate_params_free_rcu);
> +
>         return ret;
>
> +err_free:
> +       release_entry_list(&p->entries);
> +       kfree(p);
>  chain_put:
> -       spin_unlock_bh(&gact->tcf_lock);
> -
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
>  release_idr:
> @@ -446,21 +546,29 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>          * without taking tcf_lock.
>          */
>         if (ret =3D=3D ACT_P_CREATED)
> -               gate_setup_timer(gact, gact->param.tcfg_basetime,
> -                                gact->tk_offset, gact->param.tcfg_clocki=
d,
> -                                true);
> +               gate_setup_timer(gact, timer_clockid, tko);
> +
>         tcf_idr_release(*a, bind);
>         return err;
>  }
>
> +static void tcf_gate_params_free_rcu(struct rcu_head *head)
> +{
> +       struct tcf_gate_params *p =3D container_of(head, struct tcf_gate_=
params, rcu);
> +
> +       release_entry_list(&p->entries);
> +       kfree(p);
> +}
> +
>  static void tcf_gate_cleanup(struct tc_action *a)
>  {
>         struct tcf_gate *gact =3D to_gate(a);
>         struct tcf_gate_params *p;
>
> -       p =3D &gact->param;
>         hrtimer_cancel(&gact->hitimer);
> -       release_entry_list(&p->entries);
> +       p =3D rcu_dereference_protected(gact->param, 1);
> +       if (p)
> +               call_rcu(&p->rcu, tcf_gate_params_free_rcu);
>  }
>
>  static int dumping_entry(struct sk_buff *skb,
> @@ -509,10 +617,9 @@ static int tcf_gate_dump(struct sk_buff *skb, struct=
 tc_action *a,
>         struct nlattr *entry_list;
>         struct tcf_t t;
>
> -       spin_lock_bh(&gact->tcf_lock);
> -       opt.action =3D gact->tcf_action;
> -
> -       p =3D &gact->param;
> +       rcu_read_lock();
> +       opt.action =3D READ_ONCE(gact->tcf_action);
> +       p =3D rcu_dereference(gact->param);
>
>         if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
>                 goto nla_put_failure;
> @@ -552,12 +659,12 @@ static int tcf_gate_dump(struct sk_buff *skb, struc=
t tc_action *a,
>         tcf_tm_dump(&t, &gact->tcf_tm);
>         if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
>                 goto nla_put_failure;
> -       spin_unlock_bh(&gact->tcf_lock);
> +       rcu_read_unlock();
>
>         return skb->len;
>
>  nla_put_failure:
> -       spin_unlock_bh(&gact->tcf_lock);
> +       rcu_read_unlock();
>         nlmsg_trim(skb, b);
>         return -1;
>  }
> --
> 2.53.GIT
>
>

