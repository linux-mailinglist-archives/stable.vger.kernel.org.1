Return-Path: <stable+bounces-235976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHYjLte33Gn2VgkAu9opvQ
	(envelope-from <stable+bounces-235976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:31:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AFB3E9DCC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20CCD30157FD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71D347500;
	Mon, 13 Apr 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf4epigA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnANikbc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260037F8B0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072660; cv=none; b=LbhyZePPuIVM4ef1X/oppxuwgM18ixMI0IwAdU44tmMJr3JMsh2bU/RZWkbqDGeD2WYdwYcorg0dCni9lknwlkkDG2/1Xe6fprjJohDxzw0908ZrNfuFtl1Wip82QMc1TRXzGc0n2Z4pSPg2Yn3e+vAmxDEr66nLE64g7h8PRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072660; c=relaxed/simple;
	bh=ktqp7Hnd3tVxz0U7RE+2KrU8E8SGNSwevfeqTyUIzy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkqQgZ/GmBh9+twTZERLljFlu3PHmgFDkPNQpZFa1oK7vAU3JmVeIzF8UFqLQf3T2XoauIRr16RokDdgqta3l7gZKRN/mYPf5uRfdZynwivCnbyGLytuFfG1DqPm7KKBfeKkuvNq2UWWB2aMg30MT55gZ0Ed2z5bhkRSQ1/4fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf4epigA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnANikbc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776072658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
	b=Jf4epigAaaozNkEKBbYSeeKHk8ICwoB8Cib5BBTm/KvLSR1s0/+DdWeHTvY20h5G+S8RsP
	KAmSMjwxMAOxtEbVT2rGP/vav2aWkN1KOoQI7g8TY6rolHZRc4xe6pNArWo5BRczn6oDgm
	WggyDWSvn9Fm5MIQTvZHhC1RfkSvFpM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-eLIicSOeMc-X8F7Xg66Zqg-1; Mon, 13 Apr 2026 05:30:56 -0400
X-MC-Unique: eLIicSOeMc-X8F7Xg66Zqg-1
X-Mimecast-MFC-AGG-ID: eLIicSOeMc-X8F7Xg66Zqg_1776072656
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso20454075e9.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776072656; x=1776677456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
        b=MnANikbc3nLNkRhpX+TBOhFuvUeP84gkF8Bhdpcpp1x9EUJra83RSlZZixf1RYoQAW
         wzQIyKYXBmPJM1Ufs4gq7eibe2nN683sJp/OOE6Y+jElvXjHJ3m8NgTOR3+UBcvtjLPT
         3sAm/xJp9+kJh/3KTpCMyaz+VF5lnYK7xmOeCN6QZ/SZYBFmanGHUYulvsRlwy2i63SH
         FpzEpTd1DgiVr8rid5G7enMiGgZLN+oX41XuJrVoOFE22A6fnDR5zp6dSTPMq0SPQk6U
         zFHHhLLvb4lc2jvdCjtYOBErSOUxz8bRCMcJzgISJ4ma3abXFdbULSUxhP6ssCmZgo1+
         ovxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072656; x=1776677456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
        b=L8cZMSV96uJ0nVrU/n/ovLYwqqNgHeVxM2Vx5U43mDFdlW+7iIZfRgjyDjXwBcLsDT
         KsQkr6Kz3QcrOSVnJBTAt6SAf7R3LEMRCBdJoMDcTe4yGFk8FFj9S2rA5VN4FCXO6O5W
         T3D4SgS6RPjsefAsgirSpTWGh02s7LHTBx41pv39E46Wk2YWygLoAmmAlDrHd3EgAAIZ
         +GMWj70UUnWcTo5/T+IdQFT7htsWSSxf2Ygna9tnLpZhZyW7y33f0xvYoDv+LcZmd9u1
         Kkst8Yu0D+zQty2Hqr0M90Dx/V/Dq9vXw2HuV8theM8VqnEUsinOgwWJMudehfnpaX0D
         iHpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oSHyhN8E6VAfQK3XrayhrL0651uDtwMzVtZUV0mUiTKXEwgQiJ335Qh1QDkkCdtiIGONCQrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vtzAGqEt07jzFCK12P6sNA3VQUqnVdWux9BaVfD/QsHYDxJl
	XwVOrYh5NY0fXICm/xrGKkFBDRrEI8RhDGGhpQdj9OeFu4iIeu45nQeecO5W9T3/ITOoqZi/l+S
	N/GWiCIM5qOv3bVOe0alQglsjhaFmaLFJzvVw0AVBveJi+2djv5e73PSWuA==
X-Gm-Gg: AeBDietVrpq+bNf+UkerHNaoaS+tVIyfcubbYoXNsFTz7vKTvGyPtrPcr4Ef8qrRH3e
	r+HwC2LSrMek9yvsEnPDANgXgkKOt25MZCK1FCV96Q3N7ZitGkhAyTxZOHzFLdzcAEXfndvf+0T
	m22q6ucFDfuEVvtCfL+WzTR8afB11OGrJofgDaAfh8GWDATf73fq64+hGUxoo6bSUBxmKUCo3WT
	R3Fwg7jl3fkrO70jWDWYFI1BtBSatIHpXzD0rjzPbTWkLERsNOBk9bULylvQtZbe6iW/ztc7Nnb
	ev2MpQbLgrBsPGN+uqybp6sjGDnWj7ZVzGJNMf/r8eEw19RfveosZQ5KwR+0SnAi/Q6qDRylmip
	rwcvYunzIAhItAT6M1UipAUZCgehIXwrTB7TM9K81tj5P58JSBbb0JH8e
X-Received: by 2002:a05:600c:c173:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488d684b024mr165236565e9.10.1776072655682;
        Mon, 13 Apr 2026 02:30:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c173:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488d684b024mr165236145e9.10.1776072655200;
        Mon, 13 Apr 2026 02:30:55 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a8438sm312055965e9.5.2026.04.13.02.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 02:30:54 -0700 (PDT)
Message-ID: <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
Date: Mon, 13 Apr 2026 11:30:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
To: Simon Horman <horms@kernel.org>, Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kees@kernel.org, thorsten.blum@linux.dev, arnd@arndb.de,
 sjur.brandeland@stericsson.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
 <20260412135743.GK469338@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260412135743.GK469338@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[utility.name:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32AFB3E9DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 3:57 PM, Simon Horman wrote:
> I am wondering if it would be best to follow the pattern for
> writing linkparam.u.utility.name elsewhere in this function.
> That:
> 1. Uses a somewhat more succinct loop control structure
> 2. Silently truncates input without updating cmdrsp if overrun would occur
> 
> Something like this (compile tested only!):
> 
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index c6cc2bfed65d..ba184c11386e 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -15,6 +15,7 @@
>  #include <net/caif/cfctrl.h>
>  
>  #define container_obj(layr) container_of(layr, struct cfctrl, serv.layer)
> +#define RFM_VOLUME_LEN 20
>  #define UTILITY_NAME_LENGTH 16
>  #define CFPKT_CTRL_PKT_LEN 20
>  
> @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
>  		 */
>  		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
>  		cp = (u8 *) linkparam.u.rfm.volume;
> -		for (tmp = cfpkt_extr_head_u8(pkt);
> -		     cfpkt_more(pkt) && tmp != '\0';
> -		     tmp = cfpkt_extr_head_u8(pkt))
> +		caif_assert(sizeof(linkparam.u.rfm.volume) >= RFM_VOLUME_LEN);
> +		for(i = 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i++) {
> +			tmp = cfpkt_extr_head_u8(pkt);
>  			*cp++ = tmp;
> +		}
>  		*cp = '\0';
>  
>  		if (CFCTRL_ERR_BIT & cmdrsp)

I agree that the code suggested by Simon is clearer. Note that AFAICS it
lacks an additional `tmp!= '\0'` check to break the loop, but even with
that added it should be preferable.

Thanks,

Paolo


