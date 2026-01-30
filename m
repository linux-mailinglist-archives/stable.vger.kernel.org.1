Return-Path: <stable+bounces-212891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBXKOTnXfGlbOwIAu9opvQ
	(envelope-from <stable+bounces-212891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:07:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6FBC624
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5613305289B
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245B339861;
	Fri, 30 Jan 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="g7xVbLZU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484C2F4A05
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789157; cv=pass; b=TXplPu7XlkiuSVWITWkvqR7N5vYGbx6WHi9ywpehFV23IGBz+ekv+O+IS20eQr5GlVst5Ry3DuCFqxiwRTpznu0ALNOkwppcxKsD5Ebq2qbJgeLXrc2QJzmHcXle0N9UhBCE7dNapIiWRWfwpbYGqg0QY1oOUn8T7u3WviDdJnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789157; c=relaxed/simple;
	bh=4fZnjyFgpIMGJkogD0zANpcfWLMkds61W8vMRGryR5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbl9NdU9JWAzsW6lMhTSMNnZ2qwnRUjeZpkhrarN+rhz9HdB/DAtrT0M8VVunFPsO3q4/8Rc4yWlvWgCpoBkVTMaic841V05jS8g8G+71kI/ROvcoXy9AJ/4sF1EmqzOzgVSZN0g9s4WAk4qc9/Y8heOql0FznG6ytFjand+FtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=g7xVbLZU; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so1059780a91.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 08:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769789154; cv=none;
        d=google.com; s=arc-20240605;
        b=T3h57w7p3yGFqxarhfxGJaPBWMcX5nSXzHkOc7rSKlK1ZEUiMOdwcx17bYbDNMTlF+
         y8RaH6q0qE2CSq012vtOrp27l7zHup3w+5B//QZkbNwllwXEW2AE8Y904LSb3haLTByA
         3Hw59FqkJYB1NAjy/xiJUhTfEMQhgzkHWxUi6NdMDQV6DyKZS9LmlSinVhmGJ4IVLor0
         66cJ5RWbYSxZAG2J2sPrwZ1U1r22g4ywBLboGNxfUsInIKD1hr5yoRiCntHp1C29dlvP
         1Go2pJFA+/HbWuZmmQ+dgORQDdKio6IF8ZfEbtn0dP9wfAkJo8iZ22v3ewwC9Iq5pPaI
         bUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        fh=DPKOOJYuylj9zu8RvOBSgRa8ZNAa9no6zbdIFv9+5K0=;
        b=Cz0T9OKIuep5q4kmc7x0FNvZ8ooRuHb1at/2p+q6vGIJV30Xtuw9Kf91v0l6+k972b
         hwyw16jMe26xcIvq1rZwrV8vBwN0nUjy9tXGZXP9p3mbfe2BG63zFWEOHTOJx1TCFvrk
         MNRxgDa1C5W7zByWaTHARgCSolCSXLlGTzSIMOPR4RsCf4TFYgT2bp1UraE0qm1iTk8z
         ceE/4JbVYnDLctwbVsKTlx9bJ3ZboUEpFDcrCDjQGCdCcUfJDSbniSXK9ioZs7kIfYDF
         tI2Xc/FxyIr1qI62gHNXd3AhQZ7sjitJAiJ0PA/yuoaoG6dggEdw4pKFUsRDRm8Jwg8E
         1yfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769789154; x=1770393954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        b=g7xVbLZUMoMrhOceMCNCgSIv7TMA36rASU+rz5mipEyuiOpZHQyiBakLY4zV3XCwXB
         SnhA3v9/kG0YKbYuZ1si08BSTmq3f4i9prrSTL8ImtQkYqxMyos8vjKXXA93HvgTKJIu
         LlVAJK5WjJgOfeTocAVbLXXvxGdwYWb+H/mr+LVznJ+AJkc7ZkzZbF82cTXXer1gR8aw
         90Ome3al+H9nkJY7Uc2YLygV+jEjabPG97Vots0O5x8hlDfJOTawnwm/z1NhJUq49wiS
         uRRrlehs9/2yvFiHeRmVdRoLG/qoCzR5K31cqCievyPyNWxCC0x6Ur6NmDJB0S/y1wbO
         S/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789154; x=1770393954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        b=B8CkVjuusidtEyVKtBGhh2g8mBREIAnm7beyFMZehIt4Y6BNZCUXlNcfpk/ovnGq+Y
         cF9b4bSamNLDMlWpc5vZXPKlpNpNxHBvMqrFprNparAZP2quG5b1S/E1mhdwrwOAynGE
         Q8G4LH6i+ZtMKXVxwf4sHnzqGKv3YdaJxDPkJdwsS6Tih55LPU6iqzQ8qD23xDfBNMO6
         L+MpyYrYxL0nBbMrjmzaPvVqi5U1rJytPVrpPiS2m91saquct1Nu9twahOtazgRzEOP3
         Eqfvu87vjGOJUiIM/+oHpLvs098gxf47QlxMIbR18y2blnBsVkVWSGbUQtgoNdcIKcUT
         VyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyfMFeYCNNpB+wcfCfjAN3VGSk+u5R+pHYbtKhCafxHKmZueWnuiIhXqG2PhwnDUxjCUcgAPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYMGofnImYVPvRGA/D7BewlcfpmduO8Fe4I+fY1PcgQtQlxAo
	70RRPRe8BXvaSLiLTMB81eSH5vPb8S5K74zByFvRXMVnjEla+oSbTepe3Tl61bMk/ow/yXQhnMT
	9CHvvktSCWABeFdCig8T/pxlmG0pc3In2huOSQSd4
X-Gm-Gg: AZuq6aKDFvFZBw9lVvSCYGx/Auev/WXYrbAd8vWaNzminO+yhcHoiNd34XURlz7vQSc
	ClL0WA12bV+FQF48lwBhwvKnwB0ES+sAwVt+V5lH2iEB+8JwpoGHioVY9wyh5+s14w7jEHIMs4G
	e+Yq5D3NEOD8O9XK6u4uPincmwyzlb6f5cj9IotE/sbRDGAVoWoPGrAtsT6r39kVK+JBFMZClAz
	hC6gJ0o2uu1chnk0zD9hm4h8M79lzbqxjhBf8vCuQEN3WsglvnjC7zbrhAE+slqBL7JWLfyvh5Z
	PRE=
X-Received: by 2002:a17:90b:3b8a:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-3543b2fbda0mr3441568a91.9.1769789154162; Fri, 30 Jan 2026
 08:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org>
In-Reply-To: <20260130134220.305757-1-p@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 Jan 2026 11:05:43 -0500
X-Gm-Features: AZwV_QjDngoIYar1a9pR5LAAkzFxuVZSfOhxk3xHVuv5DzUlcanElVS2Kqsrro8
Message-ID: <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212891-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 54C6FBC624
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:43=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> tcf_action_fill_size() already computes the required dump size, but
> RTM_GETACTION replies always allocate NLMSG_GOODSIZE. Large action
> state can overrun that skb and make dumps fail.
>
> Use the computed reply size for RTM_GETACTION replies so large actions
> can be dumped, while still keeping NLMSG_GOODSIZE as a floor.
>
> Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event messa=
ge size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
>  net/sched/act_api.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e1ab0faeb8113..8ab016d352850 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1685,12 +1685,12 @@ static int tca_get_fill(struct sk_buff *skb, stru=
ct tc_action *actions[],
>
>  static int
>  tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
> -              struct tc_action *actions[], int event,
> +              struct tc_action *actions[], int event, size_t attr_size,
>                struct netlink_ext_ack *extack)
>  {
>         struct sk_buff *skb;
>
> -       skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> +       skb =3D alloc_skb(max_t(size_t, attr_size, NLMSG_GOODSIZE), GFP_K=
ERNEL);
>         if (!skb)
>                 return -ENOBUFS;
>         if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
> @@ -2041,7 +2041,8 @@ tca_action_gd(struct net *net, struct nlattr *nla, =
struct nlmsghdr *n,
>         attr_size =3D tcf_action_full_attrs_size(attr_size);
>
>         if (event =3D=3D RTM_GETACTION)
> -               ret =3D tcf_get_notify(net, portid, n, actions, event, ex=
tack);
> +               ret =3D tcf_get_notify(net, portid, n, actions, event,
> +                                    attr_size, extack);
>         else { /* delete */
>                 ret =3D tcf_del_notify(net, n, actions, portid, attr_size=
, extack);
>                 if (ret)

dunno. Is this based on some issue you found? This is a common pattern
in a lot of places in the stack and has not caused any issues (afaik).

cheers,
jamal

