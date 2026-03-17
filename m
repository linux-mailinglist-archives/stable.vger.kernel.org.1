Return-Path: <stable+bounces-225903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL4yGYlHuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:22:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7512A9C2A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B3EF3031392
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C43C141F;
	Tue, 17 Mar 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bc/y0/Qr"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB83BFE59;
	Tue, 17 Mar 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750135; cv=none; b=nTDHhk6LpFF9SSfUOg/+EMA+mFSMC37tJd8tEeqVjOl/xkvjryedph9mLwO/1stDHpdHWV14cjFovOm6QZSRbUw6aaozrAX6VMedvuKD4OQdU7qX76yXFH4m/w+1IpRE4HuzKKZ+atlyq41wRacSmehibh+a87jtbkIJw+mG/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750135; c=relaxed/simple;
	bh=CwqmOtDedE3vPSKwcIgRZGYpswGb8oUFdLF3Cn/PjsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMWNHumWKt8P6qoSpR9IdQBm+W162iz+fSv6ZLCR82XGVLn83tth58HeJtO8BYal/woeHOovG9cWAddzCNPLWj/K31HkurLubJIDvlQcIc2KWh9XFAOCEWNRgGSbPjFZrkOx59CAbZslvkwtN1Yj7pjZE+hC0O+qJAgLtXlMx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bc/y0/Qr; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773750130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IcBDrMF6egPDeR1Nx999ZhF+DZ+aH1WWZBUJtvevnHg=;
	b=Bc/y0/QrM3BZwBjdBwmz6brc+pNeL8M0v+SKD9O/std5F6ED5McpM9iGPlKSHKaxah0f/43tBOSvenGD0DWvgDdK4Zxd5IzN66qq6xj4AQBlIfO2yZJCNGTxexYHeozRbsmMWwdj7UrH3c2lzelhJlkg4LWu1TkmEbzILvPWrQM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X.B.vPK_1773750128;
Received: from 30.221.129.140(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X.B.vPK_1773750128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 20:22:09 +0800
Message-ID: <a7f7510b-652c-414b-a530-3aeda945c74a@linux.alibaba.com>
Date: Tue, 17 Mar 2026 20:22:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2/dlm: validate message payload length in query
 handlers
To: Junrui Luo <moonafterrain@outlook.com>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Sunil Mushran <sunil.mushran@oracle.com>
References: <SYBPR01MB7881890B57945C79BC03F31EAF44A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <SYBPR01MB7881890B57945C79BC03F31EAF44A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,fasheh.com,evilplan.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joseph.qi@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 0D7512A9C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/12/26 6:03 PM, Junrui Luo wrote:
> dlm_query_region_handler() and dlm_query_nodeinfo_handler() cast
> msg->buf to their respective structure pointers without validating
> that the received message length is sufficient. The o2net transport
> layer only enforces a maximum payload length, not a minimum, so a
> truncated message passes the network check and reaches the handler.
> 
> This causes out-of-bounds reads from the receive page buffer when
> accessing structure fields beyond the actual payload, leading to
> operations on stale or uninitialized data.
> 

OCFS2 is always deployed in trusted network.
So if not considering defensive programming, how does it happen in real
environment?

Thanks,
Joseph

> Fix by validating that len covers the full expected structure size
> before accessing any payload fields.
> 
> Cc: stable@vger.kernel.org
> Fixes: ea2034416b54 ("ocfs2/dlm: Add message DLM_QUERY_REGION")
> Fixes: 18cfdf1b1a8e ("ocfs2/dlm: Add message DLM_QUERY_NODEINFO")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  fs/ocfs2/dlm/dlmdomain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
> index 70ca79e4bdc3..07aef9ae8cbe 100644
> --- a/fs/ocfs2/dlm/dlmdomain.c
> +++ b/fs/ocfs2/dlm/dlmdomain.c
> @@ -1100,6 +1100,9 @@ static int dlm_query_region_handler(struct o2net_msg *msg, u32 len,
>  	char *local = NULL;
>  	int status = 0;
>  
> +	if (len < sizeof(struct o2net_msg) + sizeof(struct dlm_query_region))
> +		return -EINVAL;
> +
>  	qr = (struct dlm_query_region *) msg->buf;
>  
>  	mlog(0, "Node %u queries hb regions on domain %s\n", qr->qr_node,
> @@ -1276,6 +1279,9 @@ static int dlm_query_nodeinfo_handler(struct o2net_msg *msg, u32 len,
>  	struct dlm_ctxt *dlm = NULL;
>  	int status = -EINVAL;
>  
> +	if (len < sizeof(struct o2net_msg) + sizeof(struct dlm_query_nodeinfo))
> +		return -EINVAL;
> +
>  	qn = (struct dlm_query_nodeinfo *) msg->buf;
>  
>  	mlog(0, "Node %u queries nodes on domain %s\n", qn->qn_nodenum,
> 
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260312-fixes-c80f56fb6069
> 
> Best regards,


