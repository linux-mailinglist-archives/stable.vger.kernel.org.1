Return-Path: <stable+bounces-232951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIjiAGA0zmk8mAYAu9opvQ
	(envelope-from <stable+bounces-232951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:18:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E80386B7B
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E53A305DA4A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69795312832;
	Thu,  2 Apr 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHnTTV2p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CARUPya/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020D3033FB
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121326; cv=none; b=uk88p67YRq030t5G/zMNDTK1zrWsIdOhKkgia8ylmZL8IbjKp8dXZb7cKvuYW70duiHk+0/qvJECs2uZYWTiMx6+t2jvQC1RwRcEf3Z0zS8nyLcxqe/D2C3KHYHIE9k7TKXSEzdKUt1A51+5k7p+6288PjEuSK9eZkOyazUhtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121326; c=relaxed/simple;
	bh=jAZxqtMpHzi7Mhaugkk6uTTYMLEDQ9pF1F+mOLCkCXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EElcyNPKJMiuVj8eVALIS0WbSd85j3+5vLz/fTBIjhpz9w0JZ8o+dT36A0H5g3074dP9ykJsIBsYWPlvFOTcUSwvnXcOysANMhPhoOUEpMqBslUbQOX1mfS/k3vV+XZ6B7SlMLh6zo/iEeub/VoAxh00HfTogw5+3VQ5uhqR31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHnTTV2p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CARUPya/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775121324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
	b=dHnTTV2pUW3anjfSdhjxAQWvG5n0+ae2d3qZ1CuF0q1i0H5pzI8zeMmC5tnc2X+cURY2A9
	eRwGQ6dwNwF9VgVvYrIRosC1jFPI7s0JohAPWft/rMSp1luAT3UkSjbXnNQE5ZebcyitI+
	ha8eAzpEe3ADL0IILCp14aP2Nt9AiKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-GOVnAGeHNzKYUqIgxzA1ng-1; Thu, 02 Apr 2026 05:15:22 -0400
X-MC-Unique: GOVnAGeHNzKYUqIgxzA1ng-1
X-Mimecast-MFC-AGG-ID: GOVnAGeHNzKYUqIgxzA1ng_1775121321
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d103e46c3so434792f8f.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775121321; x=1775726121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
        b=CARUPya/P7aHJTrYH44uVwsE7fsNFLZtzTnxPr0NvOM9akTk0o17oJNKSDLmKn/orB
         3t9h+RdRjbBuevc+Jm6NxjsZ4cCCh4FYIquHPvRtnq3ybZD2M66Jefg2REdPrzg8/+R1
         4eBsTp3+uZiAD5Fh2lMRf0JeudFxbWGwKCOdMdj2+HHGVBgc8NwyRTGGDjuyH6Rzi4fJ
         E2US44wUAWwFktpdCtwj7VJsxp6FMvosM40R36eqQ/ENGspsDvSsu5KOyrzCoZvByu3z
         nAyF8qWh2nNYoV7UPKrk/XXbRM4QAa27comjkXOwF8g3ZcapUAxCsdpdKTDt+75bZmmh
         5iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121321; x=1775726121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
        b=LorxtgCsDoTPbDsu3rD66xdaSeG40a+a+m9yobE1DfztLByAo8JnF9V6c3wku0u3/5
         sDoQRZk+pI6uKAdi2VwE0n1/mDX7s/Q9mBsOCh0hCW0/HQJzjCGpyu6mOpqJHSqlmJtc
         QTrAMyl+PSwjV0czc9Lrpvdu1vtq5wv9Lrg3VdcNdAElsa0ME9XVmouTodPrg8uK7bqY
         IrjSgYucqK8kjq/KWC3IT2NsuNjtUo92TGdkl4N1v6p/eHYWofwX8ua+gY3FIBQDLZa6
         469DJwgHlqcmpc/VGozQpsWi5PWHRxN4RCZJ8KGD73Jk/u+cj4/wOAjJNjFV78PSVl85
         lErg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ohStJHlgDU2lyatqdaTdje6YnqNbEJR/240fkMwToEsjCHXjRdqkbTaUgbF/HvOr+MkQHV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMNkF9E6PtqODbxxOPyuA0hAvz6a/bRXwRj0J7xdAARVkvpXO
	YkdQJngkVkMJYhIwOA8d6dmcY5KYEMU4OzZvuhZhJ6h1SGOQNLDw2FXFNmOutjDwCE+yuGz8vVt
	sdUTWSJ3k8z7Ba4Gg1tXt+fy0pyebADH3GInK5G9wgH49Wv2ilbQ6PQVG6NDAdWT2mw==
X-Gm-Gg: AeBDiesG5g2B8iv/cfE5dzeQXQ0kccTPbVjzP365uKNfhGL72QlOZu1/WOMHaMafLgM
	ylKCqU+35TYu/CGW/IdEVreOSXppSfQsEUf7rT39r15+sdiHS18Q4KX9Go51JPHQarHfMjCMEnY
	2aBVIYacRJJPC1vpA/OZVfvSOEniu0yBI0g20X5QVE5p+OsTnX6q1qapD+wxhcF+WY4K6YoAiuB
	Vd/mMpaLtZVLVrF2tBBFanu8KOfQbDB9GimTSR58I3U3mMEeasbAhUhJFviv6w7jyOPdEAWwJ37
	12BaPqBidzCS4rxmV1zghUmAeucD4MjC4tMheLnGEb4bcTWFi8DzbMO/hN7oWDDlOt/uuti70q3
	o23t/b85hIYXcaZukLn1STgi2vK4Ug2si9sX4i5GWsXdf/XhSVJ9ehSkWMg==
X-Received: by 2002:a05:6000:40d9:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d150b770dmr12948348f8f.29.1775121321108;
        Thu, 02 Apr 2026 02:15:21 -0700 (PDT)
X-Received: by 2002:a05:6000:40d9:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d150b770dmr12948278f8f.29.1775121320596;
        Thu, 02 Apr 2026 02:15:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a7223sm5966184f8f.5.2026.04.02.02.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:15:20 -0700 (PDT)
Message-ID: <624d0f8d-9a6b-4dd7-b9b0-950f2aacd251@redhat.com>
Date: Thu, 2 Apr 2026 11:15:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: taprio: fix NULL pointer dereference in
 class dump
To: Weiming Shi <bestswngs@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20260330102904.2677818-5-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330102904.2677818-5-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232951-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 91E80386B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 12:29 PM, Weiming Shi wrote:
> When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
> Subsequent RTM_GETTCLASS dump operations walk all classes via
> taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> returning the NULL pointer, then dereferences it to read child->handle,
> causing a kernel NULL pointer dereference.
> 
> The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> namespaces enabled, an unprivileged local user can trigger a kernel
> panic by creating a taprio qdisc inside a new network namespace,
> grafting an explicit child qdisc, deleting it, and requesting a class
> dump. The RTM_GETTCLASS dump itself requires no capability.
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
>  Call Trace:
>   <TASK>
>   tc_fill_tclass (net/sched/sch_api.c:1966)
>   qdisc_class_dump (net/sched/sch_api.c:2329)
>   taprio_walk (net/sched/sch_taprio.c:2510)
>   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
>   tc_dump_tclass_root (net/sched/sch_api.c:2370)
>   tc_dump_tclass (net/sched/sch_api.c:2431)
>   rtnl_dumpit (net/core/rtnetlink.c:6827)
>   netlink_dump (net/netlink/af_netlink.c:2325)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
> 
> Fix this by substituting &noop_qdisc when new is NULL in
> taprio_graft(), following the same pattern used by multiq_graft() and
> prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> all consumer paths (dump, enqueue, dequeue) safe. The noop_qdisc is a
> kernel-global builtin qdisc that drops all packets, which is
> functionally equivalent to a NULL child for data path purposes. The
> refcount increment and flag modification are guarded with
> != &noop_qdisc to avoid modifying the global singleton.
> 
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sched/sch_taprio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..cecaef16c0dd1 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
>  	if (!dev_queue)
>  		return -EINVAL;
>  
> +	if (!new)
> +		new = &noop_qdisc;

Sashiko says:

---
Does replacing a deleted child with &noop_qdisc instead of NULL leak the
qlen and backlog counters of the root taprio qdisc?
Before this change, taprio_enqueue() checked for a NULL child and dropped
the packet safely without incrementing the root qdisc's stats. With the
child now set to &noop_qdisc, the check passes and execution proceeds to
taprio_enqueue_one().
Inside taprio_enqueue_one(), the root qdisc's qlen and backlog are
incremented before calling the child's enqueue function:
taprio_enqueue_one() {
    ...
    sch->q.qlen++;
    sch->qstats.backlog += qdisc_pkt_len(skb);
    ...
    qdisc_enqueue(skb, child, to_free);
}
When the child is noop_qdisc, its enqueue callback drops the packet and
returns a drop status. However, taprio_enqueue_one() does not appear to
roll back the incremented qlen and backlog counters to account for the
drop.
Can this permanently inflate the root qdisc's queue length and backlog,
breaking statistics and disabling transmission fast-path bypasses?
---

It looks like you additionally need to replace NULL checks for
q->qdiscs[] with check vs '&noop_qdisc' in many places.

/P


