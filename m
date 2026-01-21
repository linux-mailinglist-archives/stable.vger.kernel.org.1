Return-Path: <stable+bounces-211155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG4KEFY2cWnffQAAu9opvQ
	(envelope-from <stable+bounces-211155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:25:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A42195D2A3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69BCA89EC3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2123BBA14;
	Wed, 21 Jan 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m/gLvpKm"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7F346AC1
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024701; cv=none; b=NwG2uhQWu+SEy2IOqtGd4uugHoYbKYw9K6ui9PkOQ5oD7i3UYzMKNQIyV7IweuOv5ASOTKybqRz8fuhVGILM5xSWiQmem8tjslMTcX0ecVAgVxFwYoL3GuC6Y16vbb3gOIJw2TZE/dpVpo1L16+rDGRapDUcmki6WsDGhpVnsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024701; c=relaxed/simple;
	bh=ykOJXdnRPdORkrcuM4LDP6Fwb8+CG51exR/43qlXuAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rll7AJ4TjIv5Xbr9z9m6gCRuh122jf8lJ6dKyR2mHAWHYmKDRNxZRdFHkKng/AgTE0e7hspUGCMEwtsd5qC6RpCZYULIR53OCapSXHESBUg+6cTIXrlFydWDrIRIfEhVGH1SfObKzeAZo1UKRWXee0OD145JLR3UpolN2mWtH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m/gLvpKm; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1233b953bebso533303c88.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024698; x=1769629498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecdrB4zSMEy5aBv8OAslEgazFoiJdmaPpZodoGqi+h0=;
        b=m/gLvpKmxspQ32YdnwcEX3KVnmdoNdVcKjtGLCVlDThBtYQeXf2g2V8FCjkPFrDEEO
         b198E8/2c/OLB9rKKApQoKfzavgUvp34diP7qKde56/X6wYr4KtE52H3SIZr3HE/1Vc/
         3J4+qe2OMoEx7W4IHxqyKcGspaRMItEoD3WEbaXDG8711dmKPILy8S50XcTfhkJpXkyE
         3yXlrxQXIF3KvYap/jbNy1EYv1y7Ev52fK+5mGiQX1SylTaGJmQOCSP4fymRafPiUjkx
         loR88taQbXx9jq2jX0mbJWW1Gw0ByfMgYzPsgfKLIsLPQjxaBGTokOx60uvX0lzAaeYz
         VGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024698; x=1769629498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecdrB4zSMEy5aBv8OAslEgazFoiJdmaPpZodoGqi+h0=;
        b=XBKcPitmAvinNH96BS4LrgEB20bx/RpFkuXLAzrOqwT3v0ADlgGVbEI/AeksVwTdYN
         MTiznv6S+SnU+N2lFcReERh3/mucURwibwQOkkleOqEu8qj9nMZD/wO2xIs6wWhWKaP0
         ae0n8pW7Ria/UzrvbZ3njhJPf+1I5gge97eVEmUJwRYu4nlR8sUqAIEvNTdfMEThDwjr
         R9fF5TmvwlGquXI1zzNI03gQouhPjhhU2MeydxJ8osXX0NLQK6iv3pSN7n//WvXa3LdS
         va/AvdnfDLx2rqJgV4bsPFhulQ9Fc06O34X7Z6r09T8Jf6PoBr4xj14Kct+RFaIJ6VWx
         vYyg==
X-Forwarded-Encrypted: i=1; AJvYcCXIJtdXx0e99TMMuN6GAy1Y9Nmo7LY9NTI6eEjhvwp63IdM9dvDn5RVIOUtobVl+Ahme9sl/H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2POnFGBH+gWXd5/wAvgzvN4jjGvhdF7EmgeFLuYfW8JGCSCK6
	TFJHR/0V9zBNJffhxFZKR+mlF9bD23LMHU77BWEBuOCL/ZpSOIF0BYJUXgP0bTtoqQ==
X-Gm-Gg: AZuq6aIzOj0RPsm9VbozQUk5K5WRTDYEvX0M4z2ziMfTqF38U5ZlSWtXVfU3Dj3gjpq
	lOPMmmRpyMR4nnzQ1mr9GWaFVhS5Hk4PVqVEnwbYg/xCLaRtsRPLd1WzlZPj3NEIkAV7isu+pCD
	Qy1kq9WIxCpMUnN86xrkVAt/Nceh8YDebTN+OPGJu8mRHCQbQxeCfsLiELL/ydDR1IuHctAzrZX
	IMOxhlx9ol9+zddXQriyEcNkjQxzp5VI4joaVGO9xADM1fnocjHmrfieJrbitDGoU99Mw1fbXIF
	/C9sfVaQTkDkVyDPTAOnei4OL3b34dqhxM9XUq0PLT2JPsR8hBFSBZKHnIR61hiQzDpUdoRBm9W
	qgUncRvG1mS7KrbaphTqCHzEtHegLGCugJvbxSRrWMwLwN9LO5l2IBVR9qjIEvn6KUD8zowoV4x
	3/3abjVf8gnaPBm+v8+W3YDg==
X-Received: by 2002:a05:7022:914:b0:119:e56b:c75a with SMTP id a92af1059eb24-1246aad1e60mr4237514c88.31.1769024697979;
        Wed, 21 Jan 2026 11:44:57 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefac48sm23814082c88.11.2026.01.21.11.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:44:57 -0800 (PST)
Message-ID: <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
Date: Wed, 21 Jan 2026 16:44:51 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule
 list
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-7-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-7-p@1g4.org>
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
	TAGGED_FROM(0.00)[bounces-211155-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A42195D2A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Reject empty schedules (num_entries == 0) so next_entry is always valid and
> RCU readers/timer logic never walk an empty list. taprio enforces the same
> constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).
> 
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Signed-off-by: Paul Moses <p@1g4.org>
> Cc: stable@vger.kernel.org
> ---
>   net/sched/act_gate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 48ff378bb051a..e4134b9a4a314 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   		cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
>   	p->tcfg_cycletime_ext = cycletime_ext;
>   
> +	if (p->num_entries == 0) {
> +		NL_SET_ERR_MSG(extack, "The entry list is empty");
> +		err = -EINVAL;
> +		goto release_mem;
> +	}

It would be simpler to check this in parse_gate_list.
That way you could return -EINVAL there directly
in case 0 entries were passed.

cheers,
Victor

