Return-Path: <stable+bounces-247171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKA+A/m1BWqeZwIAu9opvQ
	(envelope-from <stable+bounces-247171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:46:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A05412E0
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 497AE302F77F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE33C3C00;
	Thu, 14 May 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVf0JXXn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdTFDFD7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A323C3795
	for <stable@vger.kernel.org>; Thu, 14 May 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759147; cv=none; b=mPucL+jS9pSi2/avimregCYzWPZ7S1NoQ9FB7LIDocEA/8zbSOlwm/hzK2FtL/L33UE4lo1LQiZHTDbGDKwp9kk18ow3s/9+S3nsbpcrXvXHazd+CkEFLb17dS8Wx7F39+PrEPCMlfJUqgYSqkab8KWdAQy75YNd1j7fx1V8MXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759147; c=relaxed/simple;
	bh=HzzKtLdDSOU6qk7De5CYxTiWMfze0a1cgEfK3lOcNlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pP3pXawvb5nmln7kYGOTygjdKkeznNUUBXj1IVXprhyheqBarrQN7Tx/mhcszaroitbPav77O4xopx8wOdQYzjQn4+ONbp/En3rrDSXwFZzQ9cbCiqnssb6bkkuEbGrWNcSmSGlbIrKNeIj6IZ0Z+psbGRI2jzXXvLhfBZP9MeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVf0JXXn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdTFDFD7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778759145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZr60InQnZWO1LkpnVVTcP+GBmOQnYBqSDneZ78egzQ=;
	b=CVf0JXXnXPOrpgBxKEne2lLx2NMVe1EsJM70hF+taXvE8MeJ8s7VWKFOz/8fO07qi1EY2+
	PzKErIJJZtC4kHlV/FvUpLp7rnIrPIX8ZyZhDaxhXnGk+7S9I5iZZlEcynYdMEnx8ETOOS
	WPKeWLn8ymKQJMliuLl72AeY2h+eOHE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-BRGKmu2MMWyivuB-hw-YOw-1; Thu, 14 May 2026 07:45:43 -0400
X-MC-Unique: BRGKmu2MMWyivuB-hw-YOw-1
X-Mimecast-MFC-AGG-ID: BRGKmu2MMWyivuB-hw-YOw_1778759142
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so5159983f8f.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778759142; x=1779363942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZr60InQnZWO1LkpnVVTcP+GBmOQnYBqSDneZ78egzQ=;
        b=OdTFDFD7JaXCOs8XCSf1TIgk75lSZVyA2seKJvO60P8gslr05DHIK4cyHJaeOLoxPy
         ihVHmwVJsqfLAbNQ+PNTNhv8R3omhi4wGm+XQ2ZMhMxkjAcLUbOJ3b6oyn9VqpspOgR3
         VhfhvpfTnAge2iU46B7ReTWlmPLVKkuxtjU9T0IdeSW8kXERma5QRH7RVBUpGbkGdvMy
         BCyMmkfFLAgD3e0sCYjcgPEZWHWq+eiKl9wwPAOflOigUDFBzmT2XPdvyozP5Hgzm5mB
         s8KPrCr66n5JsA+yyeKcfzQG3RkfBhKcFO4GJj4drKEYLdBDwEpfmltBaOG8DTK10qkf
         DZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759142; x=1779363942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZr60InQnZWO1LkpnVVTcP+GBmOQnYBqSDneZ78egzQ=;
        b=KP4FCZJ7eV6hP3IAdb+xL2sKErd0YwvBeTcsST3JdeJxmpxuFbQSZfuA1mvb0OiK+L
         j+BQnF3Y0HxjjArt/YXbZeITapbA2s0yA7DyILM4ILh05M2lIFUfqwUwXcSWByJfRWh3
         igKiC6auWKrOCFe5eohGQV7YBmGl73CUrw548kgOgOXSgLdb6St/F3Ced7uiJ8IezO4P
         S9UFQIQ8BU9yHli67oVGEUg1nLGDCqdS/w7+uKdxrJnyoW3WtTaRJy9mEEy0f0O7tSXA
         MDMDrQA+P67GmHg6VfrUbrVxOKysqYROxA17jFQKsCLADbHXSXJvlMhPcGN7r7+BapZo
         vDaw==
X-Forwarded-Encrypted: i=1; AFNElJ+f0m62ORTnM9/LuJnkvu9XXaIYvreTEgm+e19KhkV0D1cDIBcanIYVln8gAlhgll8prmb0iAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEciPOP4qcHTSKCQfbhUwr3x1FaPkinK7tER+mEqDamS0C0PJ
	AWw9xb/susJQqa5fYmWdzIpDKX0p2K4RFV/9RMkZoci90+5u9DTufUqCSIgvuOymnyew8cbS9+x
	VnNT9ekWga1u9yMnFYFq1Komo3mGYlV4SnVdZH0L15qByJNrT2hF9nSgncA==
X-Gm-Gg: Acq92OEhtQ3ZR+EkjnCMoON3rMGKe+reeXgkm43J54PGzJRiC2lxoy0fFe/I0CYf39f
	q6Valua06ISCKZCl5r7bVh351U1GMhAF2mfzT5jDT9V5vn0wNrYozkvzWDp4+nvehokYRBGvSsK
	/XdqbDHV5KBdCwUzn49EL2WtQMwsQCTBlaqXPMGdX5EjK0GUg/TkgM4o4we4qM4P2pw1rhyxwQ0
	s1xpCWqTHH428VLCKpueViDA3vzxZtGQc7CIZIYnY0sMjb0eOspqiVlquCz+hlQWVH7xEqZ5C8y
	eM2V1OoygKBdJfYf7Gr6HIc/jReYzHsgxKQlwYI7twYyiAlysHU7321FmN/lnMpbDaGFGfm27Nm
	9WT0e1FI/6SVTzfFpiSvPVKJEJa6ff7MsQJR+Yx8RAkgLEoIngqogZcU=
X-Received: by 2002:a05:600c:4ecc:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48fc9a391fbmr124907465e9.21.1778759142428;
        Thu, 14 May 2026 04:45:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48fc9a391fbmr124906965e9.21.1778759141942;
        Thu, 14 May 2026 04:45:41 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2c7f93sm57514445e9.10.2026.05.14.04.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 04:45:41 -0700 (PDT)
Message-ID: <b4ddcc50-ba34-4788-8931-40f31ec43986@redhat.com>
Date: Thu, 14 May 2026 13:45:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: core: dev: add reprocess depth limit for
 another_round in __netif_receive_skb_core
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
References: <20260512022127.7818-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260512022127.7818-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C15A05412E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,mails.tsinghua.edu.cn,126.com,tsinghua.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247171-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tsinghua.edu.cn:email]
X-Rspamd-Action: no action

On 5/12/26 4:21 AM, Yizhou Zhao wrote:
> In __netif_receive_skb_core(), the another_round label can be reached 
> via a TC ingress redirect (bpf_redirect_peer returning -EAGAIN).
> 
> Across network namespaces, two BPF programs on peer devices can redirect
> packets back and forth indefinitely, creating an unbounded loop that 
> monopolizes a CPU core in softirq context. This leads to RCU stalls, 
> soft lockups, and system-wide denial of service.
> 
> We reproduced it by creating a pair of TC BPF programs across two 
> network namespaces that redirect packets to each other, and the RCU 
> subsystem detects a stall:
> 
> ```
> [   24.835219] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   24.835837] rcu: 	(detected by 0, t=21002 jiffies, g=-627, q=2 ncpus=1)
> [   24.835959] rcu: All QSes seen, last rcu_preempt kthread activity 21002 (4294691810-4294670808), jiffies_till_next_fqs=3, root ->qsmask 0x0
> [   24.836239] rcu: rcu_preempt kthread starved for 21002 jiffies! g-627 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [   24.836362] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [   24.836460] rcu: RCU grace-period kthread stack dump:
> [   24.836601] task:rcu_preempt     state:R  running task     stack:15448 pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00080000
> [   24.837139] Call Trace:
> [   24.837568]  <TASK>
> [   24.838008]  __schedule+0x4ed/0xea0
> [   24.838934]  schedule+0x22/0xd0
> [   24.839023]  schedule_timeout+0x81/0x100
> [   24.839095]  ? __pfx_process_timeout+0x10/0x10
> [   24.839165]  rcu_gp_fqs_loop+0x11b/0x650
> [   24.839226]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   24.839282]  rcu_gp_kthread+0x17e/0x210
> [   24.839333]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   24.839383]  kthread+0xdd/0x110
> [   24.839433]  ? __pfx_kthread+0x10/0x10
> [   24.839481]  ret_from_fork+0x1aa/0x260
> [   24.839538]  ? __pfx_kthread+0x10/0x10
> [   24.839585]  ret_from_fork_asm+0x1a/0x30
> [   24.839686]  </TASK>
> ......
> ```
> 
> Fix this by adding a depth counter when it is about to go to another_round
> label. When the counter exceeds XMIT_RECURSION_LIMIT (8), the packet is 
> dropped. This follows the same pattern as dev_xmit_recursion() which 
> protects the TX redirect path with the same limit.
> 
> Reuse SKB_DROP_REASON_TC_RECLASSIFY_LOOP for observability.
> 
> Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> Changes in v2:
> - Move the check just after `another` is set to true to avoid affecting the fast path
> - Reuse SKB_DROP_REASON_TC_RECLASSIFY_LOOP to avoid adding new drop reason
> - Link to v1: https://lore.kernel.org/netdev/20260511063005.38134-1-zhaoyz24@mails.tsinghua.edu.cn/
> ---
>  net/core/dev.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 831129f2a..bb9ae92f0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5958,6 +5958,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  	struct net_device *orig_dev;
>  	bool deliver_exact = false;
>  	int ret = NET_RX_DROP;
> +	int redirect_depth = 0;

As reported by sashiko, the above will cause an unused variable warning,
should be protected by #ifdef CONFIG_NET_INGRESS compiler guard.

Also please respect the reverse christmas tree order above.

/P


