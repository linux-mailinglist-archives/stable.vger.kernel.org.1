Return-Path: <stable+bounces-89056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4369B2E8A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDE5281D7B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8ED1DB52A;
	Mon, 28 Oct 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="e4JJv4ih"
X-Original-To: stable@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF851DB520
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113718; cv=none; b=QC6uq//jxTqKRWJ+8XTcEOzoRw6PK9orlTwR7WouzazhWV7HpqhHERO1c2cRKY/8krV7438dOnsK0fPcDerdc9LKGUmlLUI7SuzZeSCGMIilo/BdZLbMgKW2i1U+9PLAFrGHMzT3+iUIBeFZYGVYqbai8q44xiAXpDGctvQDd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113718; c=relaxed/simple;
	bh=VTwTyhTyWMzt5lJAgMkPHrW1D1b1Q6BEBA7wLZtsgiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4XZFFvQiTjlpbZO6IECwzxGBTr601Q0cypWpdohsv60Uv6EOBQFXrjyEQQYyehxZF6mJsKPQQ+kTUTu/yoQ3nr42NWjshX1Cd6mPlfHkD1c9VSE5+IPedyX4tpQVDPs8VeQjMnAn6WEyujFFVgcTOHvSa4JDHg6Z7M0dd6CdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=e4JJv4ih; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C048D20758;
	Mon, 28 Oct 2024 12:08:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OlZ9Kt7b5G19; Mon, 28 Oct 2024 12:08:31 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A457F20508;
	Mon, 28 Oct 2024 12:08:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A457F20508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1730113711;
	bh=lrjWMqo/Cp30yEr3PVAbl559CFc2LaEdv9IbyyrWZ2g=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=e4JJv4ihM3rg4tawYaeOjCcHhROimpumlTSf1808spjIrlVzmaGLyKgCzUOa/8DE8
	 +jm/OIcRQmbOSNnnMLQH0vmMhW3sqgDP+/nC0ygjtq0Zq4GFQSIqgJ+RN1bpNpamY5
	 f+XTZJdPos9iKSIgmEHyQs+K4/IwokthHEN0p9bKioe1EhdBoKC2Pa3LgAbIyPuRq5
	 AmOvInZnm6cZwR2YujhMmSs166e/VWoCrgX9C7Q/PEqKqKOvFgEjE/IOw7mmqR6JH9
	 /009MzNqA103pseR8aukVH7dF4kroz7tJ6ODnGKUzLRMAJZRMZK16buYCJumdAYfLO
	 a00Deglpi0c7g==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 12:08:31 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 12:08:30 +0100
Date: Mon, 28 Oct 2024 12:08:23 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>, Antony Antony
	<antony.antony@secunet.com>, Sabrina Dubroca <sd@queasysnail.net>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 133/208] xfrm: Add Direction to the SA in or out
Message-ID: <Zx9wp6atLMR1UcCL@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20241028062306.649733554@linuxfoundation.org>
 <20241028062309.914261564@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028062309.914261564@linuxfoundation.org>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 28, 2024 at 07:25:13 +0100, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.

Hi Greg,

This patch is a part of a new feature SA direction and it appears the auto
patch selector picked one patch out of patch set?
I think this patch alone should not be applied to older stable kernel.

-antony


> 
> ------------------
> 
> From: Antony Antony <antony.antony@secunet.com>
> 
> [ Upstream commit a4a87fa4e96c7746e009de06a567688fd9af6013 ]
> 
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will restrict values pertinent to input,
> effectively segregating them from output-related values.
> And an output SA will restrict attributes for output. This change aims
> to streamline the configuration process and improve the overall
> consistency of SA attributes during configuration.
> 
> This feature sets the groundwork for future patches, including
> the upcoming IP-TFS patch.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Stable-dep-of: 3f0ab59e6537 ("xfrm: validate new SA's prefixlen using SA family when sel.family is unset")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/net/xfrm.h        |   1 +
>  include/uapi/linux/xfrm.h |   6 ++
>  net/xfrm/xfrm_compat.c    |   7 +-
>  net/xfrm/xfrm_device.c    |   6 ++
>  net/xfrm/xfrm_replay.c    |   3 +-
>  net/xfrm/xfrm_state.c     |   8 +++
>  net/xfrm/xfrm_user.c      | 138 ++++++++++++++++++++++++++++++++++++--
>  7 files changed, 160 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 93a9866ee481f..c5cf062afd4a2 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -292,6 +292,7 @@ struct xfrm_state {
>  	/* Private data of this transformer, format is opaque,
>  	 * interpreted by xfrm_type methods. */
>  	void			*data;
> +	u8			dir;
>  };
>  
>  static inline struct net *xs_net(struct xfrm_state *x)
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 23543c33fee82..7cd491caef354 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -140,6 +140,11 @@ enum {
>  	XFRM_POLICY_MAX	= 3
>  };
>  
> +enum xfrm_sa_dir {
> +	XFRM_SA_DIR_IN	= 1,
> +	XFRM_SA_DIR_OUT = 2
> +};
> +
>  enum {
>  	XFRM_SHARE_ANY,		/* No limitations */
>  	XFRM_SHARE_SESSION,	/* For this session only */
> @@ -314,6 +319,7 @@ enum xfrm_attr_type_t {
>  	XFRMA_SET_MARK_MASK,	/* __u32 */
>  	XFRMA_IF_ID,		/* __u32 */
>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
> +	XFRMA_SA_DIR,		/* __u8 */
>  	__XFRMA_MAX
>  
>  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 655fe4ff86212..703d4172c7d73 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
>  };
>  
>  static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> +	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
>  	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
>  	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
>  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> @@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
>  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
> +	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
>  };
>  
>  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> @@ -277,9 +279,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
>  	case XFRMA_SET_MARK_MASK:
>  	case XFRMA_IF_ID:
>  	case XFRMA_MTIMER_THRESH:
> +	case XFRMA_SA_DIR:
>  		return xfrm_nla_cpy(dst, src, nla_len(src));
>  	default:
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
>  		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
>  		return -EOPNOTSUPP;
>  	}
> @@ -434,7 +437,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
>  	int err;
>  
>  	if (type > XFRMA_MAX) {
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
>  		NL_SET_ERR_MSG(extack, "Bad attribute");
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 04dc0c8a83707..fc18b9b4f22f3 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		return -EINVAL;
>  	}
>  
> +	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> +	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
> +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> +		return -EINVAL;
> +	}
> +
>  	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
>  
>  	/* We don't yet support UDP encapsulation and TFC padding. */
> diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> index ce56d659c55a6..bc56c63057252 100644
> --- a/net/xfrm/xfrm_replay.c
> +++ b/net/xfrm/xfrm_replay.c
> @@ -778,7 +778,8 @@ int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack)
>  		}
>  
>  		if (x->props.flags & XFRM_STATE_ESN) {
> -			if (replay_esn->replay_window == 0) {
> +			if (replay_esn->replay_window == 0 &&
> +			    (!x->dir || x->dir == XFRM_SA_DIR_IN)) {
>  				NL_SET_ERR_MSG(extack, "ESN replay window must be > 0");
>  				return -EINVAL;
>  			}
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 8a6e8656d014f..93c19f64746fa 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1349,6 +1349,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  		if (km_query(x, tmpl, pol) == 0) {
>  			spin_lock_bh(&net->xfrm.xfrm_state_lock);
>  			x->km.state = XFRM_STATE_ACQ;
> +			x->dir = XFRM_SA_DIR_OUT;
>  			list_add(&x->km.all, &net->xfrm.state_all);
>  			XFRM_STATE_INSERT(bydst, &x->bydst,
>  					  net->xfrm.state_bydst + h,
> @@ -1801,6 +1802,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
>  	x->lastused = orig->lastused;
>  	x->new_mapping = 0;
>  	x->new_mapping_sport = 0;
> +	x->dir = orig->dir;
>  
>  	return x;
>  
> @@ -1921,8 +1923,14 @@ int xfrm_state_update(struct xfrm_state *x)
>  	}
>  
>  	if (x1->km.state == XFRM_STATE_ACQ) {
> +		if (x->dir && x1->dir != x->dir)
> +			goto out;
> +
>  		__xfrm_state_insert(x);
>  		x = NULL;
> +	} else {
> +		if (x1->dir != x->dir)
> +			goto out;
>  	}
>  	err = 0;
>  
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 979f23cded401..4328e81ea6a31 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -130,7 +130,7 @@ static inline int verify_sec_ctx_len(struct nlattr **attrs, struct netlink_ext_a
>  }
>  
>  static inline int verify_replay(struct xfrm_usersa_info *p,
> -				struct nlattr **attrs,
> +				struct nlattr **attrs, u8 sa_dir,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct nlattr *rt = attrs[XFRMA_REPLAY_ESN_VAL];
> @@ -168,6 +168,30 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
>  		return -EINVAL;
>  	}
>  
> +	if (sa_dir == XFRM_SA_DIR_OUT)  {
> +		if (rs->replay_window) {
> +			NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA");
> +			return -EINVAL;
> +		}
> +		if (rs->seq || rs->seq_hi) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Replay seq and seq_hi should be 0 for output SA");
> +			return -EINVAL;
> +		}
> +		if (rs->bmp_len) {
> +			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (sa_dir == XFRM_SA_DIR_IN)  {
> +		if (rs->oseq || rs->oseq_hi) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Replay oseq and oseq_hi should be 0 for input SA");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -176,6 +200,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  			     struct netlink_ext_ack *extack)
>  {
>  	int err;
> +	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
>  
>  	err = -EINVAL;
>  	switch (p->family) {
> @@ -334,7 +359,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  		goto out;
>  	if ((err = verify_sec_ctx_len(attrs, extack)))
>  		goto out;
> -	if ((err = verify_replay(p, attrs, extack)))
> +	if ((err = verify_replay(p, attrs, sa_dir, extack)))
>  		goto out;
>  
>  	err = -EINVAL;
> @@ -358,6 +383,77 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  			err = -EINVAL;
>  			goto out;
>  		}
> +
> +		if (sa_dir == XFRM_SA_DIR_OUT) {
> +			NL_SET_ERR_MSG(extack,
> +				       "MTIMER_THRESH attribute should not be set on output SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	if (sa_dir == XFRM_SA_DIR_OUT) {
> +		if (p->flags & XFRM_STATE_DECAP_DSCP) {
> +			NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should not be set for output SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (p->flags & XFRM_STATE_ICMP) {
> +			NL_SET_ERR_MSG(extack, "Flag ICMP should not be set for output SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (p->flags & XFRM_STATE_WILDRECV) {
> +			NL_SET_ERR_MSG(extack, "Flag WILDRECV should not be set for output SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (p->replay_window) {
> +			NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (attrs[XFRMA_REPLAY_VAL]) {
> +			struct xfrm_replay_state *replay;
> +
> +			replay = nla_data(attrs[XFRMA_REPLAY_VAL]);
> +
> +			if (replay->seq || replay->bitmap) {
> +				NL_SET_ERR_MSG(extack,
> +					       "Replay seq and bitmap should be 0 for output SA");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	if (sa_dir == XFRM_SA_DIR_IN) {
> +		if (p->flags & XFRM_STATE_NOPMTUDISC) {
> +			NL_SET_ERR_MSG(extack, "Flag NOPMTUDISC should not be set for input SA");
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
> +			u32 xflags = nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
> +
> +			if (xflags & XFRM_SA_XFLAG_DONT_ENCAP_DSCP) {
> +				NL_SET_ERR_MSG(extack, "Flag DONT_ENCAP_DSCP should not be set for input SA");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +
> +			if (xflags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP) {
> +				NL_SET_ERR_MSG(extack, "Flag OSEQ_MAY_WRAP should not be set for input SA");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +
> +		}
>  	}
>  
>  out:
> @@ -734,6 +830,9 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  	if (attrs[XFRMA_IF_ID])
>  		x->if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
>  
> +	if (attrs[XFRMA_SA_DIR])
> +		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> +
>  	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
>  	if (err)
>  		goto error;
> @@ -1182,8 +1281,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
>  		if (ret)
>  			goto out;
>  	}
> -	if (x->mapping_maxage)
> +	if (x->mapping_maxage) {
>  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
> +		if (ret)
> +			goto out;
> +	}
> +	if (x->dir)
> +		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
>  out:
>  	return ret;
>  }
> @@ -1618,6 +1722,9 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (err)
>  		goto out;
>  
> +	if (attrs[XFRMA_SA_DIR])
> +		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> +
>  	resp_skb = xfrm_state_netlink(skb, x, nlh->nlmsg_seq);
>  	if (IS_ERR(resp_skb)) {
>  		err = PTR_ERR(resp_skb);
> @@ -2401,7 +2508,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
>  	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
>  	       + nla_total_size(sizeof(struct xfrm_mark))
>  	       + nla_total_size(4) /* XFRM_AE_RTHR */
> -	       + nla_total_size(4); /* XFRM_AE_ETHR */
> +	       + nla_total_size(4) /* XFRM_AE_ETHR */
> +	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
>  }
>  
>  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> @@ -2458,6 +2566,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
>  	if (err)
>  		goto out_cancel;
>  
> +	if (x->dir) {
> +		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> +		if (err)
> +			goto out_cancel;
> +	}
> +
>  	nlmsg_end(skb, nlh);
>  	return 0;
>  
> @@ -3017,6 +3131,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
>  #undef XMSGSIZE
>  
>  const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> +	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
>  	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
>  	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
>  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> @@ -3048,6 +3163,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> +	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
>  };
>  EXPORT_SYMBOL_GPL(xfrma_policy);
>  
> @@ -3188,8 +3304,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
>  
>  static inline unsigned int xfrm_expire_msgsize(void)
>  {
> -	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
> -	       + nla_total_size(sizeof(struct xfrm_mark));
> +	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
> +	       nla_total_size(sizeof(struct xfrm_mark)) +
> +	       nla_total_size(sizeof_field(struct xfrm_state, dir));
>  }
>  
>  static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> @@ -3216,6 +3333,12 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
>  	if (err)
>  		return err;
>  
> +	if (x->dir) {
> +		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> +		if (err)
> +			return err;
> +	}
> +
>  	nlmsg_end(skb, nlh);
>  	return 0;
>  }
> @@ -3323,6 +3446,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
>  	if (x->mapping_maxage)
>  		l += nla_total_size(sizeof(x->mapping_maxage));
>  
> +	if (x->dir)
> +		l += nla_total_size(sizeof(x->dir));
> +
>  	return l;
>  }
>  
> -- 
> 2.43.0
> 
> 
> 

