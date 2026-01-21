Return-Path: <stable+bounces-211178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOh1CJVLcWn2fgAAu9opvQ
	(envelope-from <stable+bounces-211178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:56:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705F5E5EF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E229448AAA7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466F3A4ACD;
	Wed, 21 Jan 2026 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ecYTw7xK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88050358D27
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032150; cv=none; b=RbCPxGkwZkBvBlWbHAF5CD45opBHvZsuxf0OOECEMFJ9mWFfpNj0xa5QBFoYkUaSsPXCsm6RTRUP7Jo+fPof21/G3yF5iuiO1JK48vlnFbd7krSegWIn428o//ZXXgFE7yE35t7pSmyPOUGvSD9Wd26fOadSjJ2IBYCZMZTjHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032150; c=relaxed/simple;
	bh=2SFqDiH83MW4ugjSYoc3/nCATH+R8FXbL80fYxa71co=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L2AFc/7upAubLRjTtEtXrBdHHSypzw5ns6oXM6G0dNFckvQX9ROsUmCU59m9lth7jQpLsYMCNpHykj3mE7iopYZKROcDhFTXyNhBiHwrqknR55kYWHPKYE1urv71GkP+H5qYRmAbruKMhCszRLBDk6a+uUIrjD2iKEK4Z9T2IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ecYTw7xK; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b704f08e73so172817eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769032147; x=1769636947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5o26zUnay0o8KGgb7cyYz/y8MIhvkmFsB5HLG6SVuQ=;
        b=ecYTw7xKvpsrSRzuYUK7y1MEjBcnZ8BbiQFS4jivnso1LJ6+BokxipVxRuxpr1CD0K
         aa6NAIiJVOL3LQXhVzMqm34zGDGiLOppFRWg9zuhjDHrxN30rA3WePntt6H6vy891GDy
         R7c7NfTsz6MqR1rIYiFB7QaUPu1ysAyuY+03FPf3SRBA/YFqXyCRU2apTmtBRPWQ5G4/
         jiLXLOpxBdMrE56p/8AuS4UsQuIandbhOIg5Z/4KXVa5KlIeDQy7qy7KIPDYUGlhNlw8
         9A+U3dZe4vKSadHsWiH088upHRIXus/Qab0w87Zjx03xp3V81Mhs7NM6FTlK49Fhjf4r
         vylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032147; x=1769636947;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5o26zUnay0o8KGgb7cyYz/y8MIhvkmFsB5HLG6SVuQ=;
        b=wKJOJwdL4V3U8U4QuMD6buhpflweBrefITF0xUjyjZuR/4Y9I5dBgjTHEpjwhIJfp2
         svOo2sJ8OxvjT0z5kdHLYxQyHZ4xOw2MsY5qFW2ohYYOc5iMnVsdXiWp7pZv8mn/ba/E
         73jL9QEM9qcA/ekb3PRcmQg0TWdJPkwH+7BuwNHk38Q9d+2MeivhlxfLtmM07eNuaZEm
         +dgwl/CQYuzhxxXeox5YRg4ld87oY6IVQNVAD/ujqvtOXJ8fxhGRljV0IUMui6cCi3eE
         QTxSJzBKK66OM9KjAVkk/ppGQEPOAjVK3rnkS5s5FXKv4/pcm+tS/ZMmnIK0TRv7gPi4
         YC9A==
X-Forwarded-Encrypted: i=1; AJvYcCXKuj3GhLfMur0WfF5PYt/yNLKzkbzUXU4nL4b9BppPlWl8IdsexqiN1+ATo0s0HNfrXkbigWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFtCj2A0BljlT3CPkwT64NFsVaEUOqKISQeR7EvUOWeEGqjR8
	znzDdtnkH2iVNVFjHHkjKDKD4ut+tS/eUyVruIfFZjlcgZsp7N8PMyu/E/wdz3drBQ==
X-Gm-Gg: AZuq6aIs2nm5ywQRRoPvYgaQNkTuAc0k9V7k1E+KksBXC3v4NaZbA1WstOadEuQPLMh
	W+fZ+2wvoXEonsouEJvPQO65AWdym2XXWNaJUCge5kpblXBDQeWsE3J51YbkHf1PB7pgdURD7NW
	i8XFRneXV3Pv+fGGwFGsnKV/r5vjb5GEcgjb/7LOImexNeqa35TDrfNDyxSgezlt3exKz4PhXNs
	o87vgaDtkRr17V8hKAaSRq2AnR0J0dhgN0G/x84Jyb0dSSjRZKS3M8yn6XoNvV+n1jnvW8ItKH0
	8oCy6bGzXgLbZSJ2sNbZgaZ7477zbKLssTBniuqcj7uc7fFRPEH8cvPECtQG4pdS54h+M9rpjH8
	WU5DhVMhPEKm2KJ6dLi3OK1vv6szKtqW3GnuwJTNB+iBe4jbkp99076T7rRl3IlDbhREdF1YDFI
	Z5T23PxKoB4JE5Fpy2nZmtMA==
X-Received: by 2002:a05:7300:ad2d:b0:2b6:b246:dee0 with SMTP id 5a478bee46e88-2b7247158f4mr526028eec.4.1769032147014;
        Wed, 21 Jan 2026 13:49:07 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm6550761eec.16.2026.01.21.13.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 13:49:06 -0800 (PST)
Message-ID: <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
Date: Wed, 21 Jan 2026 18:48:59 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule
 list
From: Victor Nogueira <victor@mojatatu.com>
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-7-p@1g4.org>
 <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
Content-Language: en-US
In-Reply-To: <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
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
	TAGGED_FROM(0.00)[bounces-211178-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 9705F5E5EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 16:44, Victor Nogueira wrote:
> On 21/01/2026 10:20, Paul Moses wrote:
>> Reject empty schedules (num_entries == 0) so next_entry is always 
>> valid and
>> RCU readers/timer logic never walk an empty list. taprio enforces the 
>> same
>> constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).
>>
>> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
>> Signed-off-by: Paul Moses <p@1g4.org>
>> Cc: stable@vger.kernel.org
>> ---
>>   net/sched/act_gate.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
>> index 48ff378bb051a..e4134b9a4a314 100644
>> --- a/net/sched/act_gate.c
>> +++ b/net/sched/act_gate.c
>> @@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct 
>> nlattr *nla,
>>           cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
>>       p->tcfg_cycletime_ext = cycletime_ext;
>> +    if (p->num_entries == 0) {
>> +        NL_SET_ERR_MSG(extack, "The entry list is empty");
>> +        err = -EINVAL;
>> +        goto release_mem;
>> +    }
> 
> It would be simpler to check this in parse_gate_list.
> That way you could return -EINVAL there directly
> in case 0 entries were passed.

On second thought, I believe it would be better
to check whether parse_gate_list's return is 0
and the op is a create. Something like:

err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
...
if (!err && ret == ACT_P_CREATED) {
     NL_SET_ERR_MSG(extack, "The entry list is empty");
     err = -EINVAL;
     goto release_mem;
}

so that you don't need to add new arguments to
parse_gate_list.

cheers,
Victor

