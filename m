Return-Path: <stable+bounces-216011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AdoNJOHjmlyCwEAu9opvQ
	(envelope-from <stable+bounces-216011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394081325D0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B2F306FF46
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8D2264A8;
	Fri, 13 Feb 2026 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXgAC8dE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB5EADC;
	Fri, 13 Feb 2026 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770948492; cv=none; b=t+pPqRl7Gc+3L98q+Fy41XlTufk2VGO81sRCXwQ+5dQrWm8D5geIi7oF5oMUwabR6JU4jbRQdvKfI0Y9n5WnjvbYByjB7sqbsT/Jz0j8zV6ebgbDZmjQVfrvaeZJFWQIaiceZ6bHqydFe4677mGg9rjdeaGYojCqURqYEiZcwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770948492; c=relaxed/simple;
	bh=VLCHV8yvlNulRyTa5WcIYDM2c1VCiFEvLavM20R5a8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0tXTUevdn9Jb0y0UeEeP6TQ5I6RLqnylounDUKtNNwQWHxZdaZN0BJPiCmcR5GY83iX2cau4YQpp9+ezhov6Vw5BVxxEr30vQt2ZUeC3Xo+NmoKBjv4bcKn5nKoRdPjjWMGg26INJAIOasmK3hszyXh5wmJmlHfRjQFLuII7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXgAC8dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF830C4CEF7;
	Fri, 13 Feb 2026 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770948492;
	bh=VLCHV8yvlNulRyTa5WcIYDM2c1VCiFEvLavM20R5a8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXgAC8dE6g0VqrNGwNuLTQxGl13xbnaSY/W0bkYXjBvNmpNad+p/5C7ZDSafPDHsJ
	 mb75SMFDmZlZjIxBNv1qmDrnQF5OOtA0XyC7zlLh/hlzdoLlm/so6NTj0nkkl/erPB
	 U/3jqflikpNpujQmqJ2Hokdcs+5C2uSAw1CKRLpjWGmjSdjIKVeQgbBA5WV8gauKgB
	 eT7tW5FqTVYKkanXU3uF40sGeo8RkT0dV0n2cUiKNJNZ9/kaK96sFtGlAC564ekvZ6
	 YNiZgEyI7jyiX/NGAWU0GXC+naf3C9qTphOuqUDyyoXCHrxBvuz6Abv9yS2/T3XXSm
	 Vp5o8VEqycbEw==
Date: Thu, 12 Feb 2026 18:08:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ruitong Liu <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuyuan Liu <L0x1c3r@gmail.com>
Subject: Re: [PATCH v2] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()
Message-ID: <20260212180810.0b06e2b3@kernel.org>
In-Reply-To: <20260211194325.797963-1-cnitlrt@gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
	<20260211194325.797963-1-cnitlrt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216011-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 394081325D0
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 03:43:25 +0800 Ruitong Liu wrote:
> Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
> added SKBEDIT_F_TXQ_SKBHASH support. mapping_mod is computed as:
> 
>   mapping_mod = queue_mapping_max - queue_mapping + 1;
> 
> mapping_mod is stored as u16, so the calculation can overflow when the
> requested range covers 65536 queues (e.g. queue_mapping=0 and
> queue_mapping_max=0xffff). In that case mapping_mod wraps to 0 and
> tcf_skbedit_hash() triggers a divide-by-zero:
> 
>   queue_mapping += skb_get_hash(skb) % params->mapping_mod;
> 
> Reject such invalid configuration to prevent mapping_mod from becoming
> 0 and avoid the crash.

How did you find this bug? Do you have a repro to trigger the issue
you're describing?

> @@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
>  			}
>  
>  			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
> +			if (!mapping_mod) {
> +				NL_SET_ERR_MSG_MOD(extack, "Invalid queue_mapping range: range too large");
> +				return -EINVAL;
> +			}
>  			flags |= SKBEDIT_F_TXQ_SKBHASH;
>  		}
>  		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)


There is this check right above the lines you're touching:

			if (*queue_mapping_max < *queue_mapping) {
				NL_SET_ERR_MSG_MOD(extack, "The range of queue_mapping is invalid, max < min.");
				return -EINVAL;
			}

I don't see how mapping_mod can be 0 here.
-- 
pw-bot: reject

