Return-Path: <stable+bounces-211153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FamJFk3cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:30:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4735D3F9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9FAC914C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185336B05B;
	Wed, 21 Jan 2026 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wyIfniBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C130387371
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024607; cv=none; b=DL3+tF9dxoHWZCEExivFlHsEYO6T1LY85wjPO4dWdnshI/Bdh0Z+3Wl+FK0rhTn5L5wJ/sw+Z7SiDTr6nrB40EjkPD0Q/kNHlRM+NeBlq/S30wke9xlh+kPqD5u85VI8m64kJFoe/whENjfMW2L6quw/nR2q6DifzZwRAf9Gav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024607; c=relaxed/simple;
	bh=w1kKinpt/YcI0gMNgEnS5zXjFDhZKigaZ8h7epYIB8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kET8Eq+HV8y9HeztrV9uzofKJ4E958iGxut3JQGInVN0FdZ1Ca8rIQMqdcm0Yj7H7s9gf/ZrS4tx12a+rYoud3wDvsYUk/e0YEIPjVjV2MIcGX6IHbx0OPVPrId/PrcsGBd2yHeMuJo0KeU98wshcbPtRatu2uuZ/LMuhMlBrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wyIfniBd; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6f85470b6so351815eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024604; x=1769629404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry8GpQeL1FNrHjzLhRKtbLVCrSqvGfns+hF1JkeMT8c=;
        b=wyIfniBdxot3ksMrjE0n0bzpL7YvWgg2VvtucR3ENGEYrsK8NAn9JpDTpsNe9pi2i8
         fPJVrUisnvQ1702sS/QjiEUJI7iSOQpyyczAv+YYd74yB1GLixqHOqIrS2bQR/osdAOq
         QDAkBlu5Mu+lAQ8XDbMW58+mUvGm8Ln3lNILTykxaXfEJz1s9zbMDc4EfJw+xyfHjE3M
         Q2DIQzNs3pPN0j5R3XlsHrOzY7A7lpPA0NkhIWY+nGjru1Nn8iGuYDCgU/mnSM9UaLhq
         FUMeq969NlO2nDG1evZsAu1oef+bBWgFvft1VpPmeohRRKp1PsjAXALcIX/XPNFqznZO
         +RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024604; x=1769629404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry8GpQeL1FNrHjzLhRKtbLVCrSqvGfns+hF1JkeMT8c=;
        b=qFrHQ6IpLirwhYwmWjwpEtCniRYzJtJeoWao1wi8OTdtDeGUYVNrnpzgHNwhEtZI1N
         tJ77pyH7ycCZtPUBOG4Wk4MvWng9Ns7NOqWJkbR4/aniCRcp0LP6wBlmtE2EklTpHq6p
         JmjPCWd6Y+jTDZ0oj4Ox/WBNhQPdhJGVjA6NJzCZQXYW++ZWPHgAokY5WHvAo3XKbmOE
         L4UQw3cIKKH6BXJJhu9B+kJFWovS/4zs/og9c/dr8dp2bunQTwIOZNauONULRQjeAxju
         oiJO4UMHbLbqxbBCv3GParYp7c6ighE3l/DxBty8btKL6oNokSVFCCOaKas5BUx2wo6/
         wAvw==
X-Forwarded-Encrypted: i=1; AJvYcCXa2h/3y6EwNBj88/1cV/7olDdEchLICe5fyUesKAFE94/XI+2aQ1h98AHQY8jhupgazaOwXSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8DEmrjFjxvnlLK1T/sxMWkBVgAGTDNxj5bpZBQ7CbdKSkpim
	wRLHMnjRqpjYjIW1sex5x/B6c4N9bciEYS8NQiJCDTRZJKEqSBw+QCWywfsnBYcZaw==
X-Gm-Gg: AZuq6aJHz+yUfo2G78N1rHKXx/izzH6xkikQ4fbz2O+gJf6u0SmDctjWOT3TB03SBBz
	TpgFQm3vfXn5j7vAjClYOeAUg1HsTI4ySfm+p7OBGIP7ArWo/yI7ddynC9rYOrk4DS8iVSU+g/Z
	Seh0tfHORI2RcQ2anxfSv0Ebz6JnRdhp1E+3njgZNc7zZKpvLoG4/KYnZq1GMBBTiPJQoaqbyqW
	O0zPZTNkrULtEWmzPDEAbB4o6ZNgVG3Qcxa/3W2ayk25xEuFoo8aJuv+6gerYZgUve01e/7Vsab
	xqgHOrBMZcIV5bU4oEwd7/m18rZ2JYHus4zjBTfVsKFaKsHfm91g5Hal7242+milAqGNBtt10b9
	dxn5iG/eR04FAx56+FTk3H9AvX6iycn11YoDYxV9z5AJpGRMJtlc1aUAXbpz6UUdaF23YSq0hVz
	z5xHkLX+OUVNg9N6q+I+CGmkZbvIwyJdjE
X-Received: by 2002:a05:7300:6da6:b0:2b4:5a2d:80c with SMTP id 5a478bee46e88-2b6fd8fd5a8mr3538584eec.11.1769024602139;
        Wed, 21 Jan 2026 11:43:22 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm25089488eec.32.2026.01.21.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:43:21 -0800 (PST)
Message-ID: <cab42321-cc54-4599-aaee-c631082f936c@mojatatu.com>
Date: Wed, 21 Jan 2026 16:43:16 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/7] net/sched: act_gate: build schedule and
 RCU-swap
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-4-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-4-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211153-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: 0A4735D3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Build a fresh params snapshot and swap it in with rcu_replace_pointer(),
> then free the old snapshot via call_rcu(). This is the same publish+defer
> pattern used in taprio sched swapping (sch_taprio.c, commit d5c4546062fd6f)
> and in act_pedit param updates (act_pedit.c, commit 52cf89f78c01bf).
> 
> When REPLACE omits TCA_GATE_ENTRY_LIST, carry forward the old snapshot fields
> (basetime/clockid/flags/cycletime/priority) and only override provided attrs,
> so partial updates don’t reset unrelated state.
> 
> Parse entry lists with GFP_KERNEL and explicit error handling, matching taprio’s
> schedule parsing (sch_taprio.c, commit 5a781ccbd19e46).
> [...]
> @@ -388,32 +416,92 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   
>   	gact = to_gate(*a);
>   
> -	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
> -	if (err < 0)
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		err = -ENOMEM;
>   		goto release_idr;
> +	}
> +	INIT_LIST_HEAD(&p->entries);
> [...]  
>   	if (!cycletime) {
> @@ -425,20 +513,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   		cycletime = cycle;
>   		if (!cycletime) {
>   			err = -EINVAL;
> -			goto chain_put;
> +			goto release_mem;
>   		}
>   	}
>   	p->tcfg_cycletime = cycletime;

You are always using the just allocated params pointer (p) when iterating
through the entries [1]. So cycletime will always be 0 when the user
doesn't specify it. This is breaking tdc:

not ok 1119 3719 - Replace gate base-time action
# Command exited with 255, expected 0
# RTNETLINK answers: Invalid argument
# We have an error talking to the kernel

[1] 
https://elixir.bootlin.com/linux/v6.18.6/source/net/sched/act_gate.c#L402

