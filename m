Return-Path: <stable+bounces-232988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LEDlLQxYzmkxnAYAu9opvQ
	(envelope-from <stable+bounces-232988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA338891C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15C2830A328A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7553C6616;
	Thu,  2 Apr 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPhOcr/Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="enP1a3Or"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD703DEAF0
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130399; cv=none; b=NG4J7lN+qJ/365SooHbDxGDVbVs9xBzkSfO/zNj33x9OAvmA3UryUsm6HxA6V5redY13t2+H+WV3LpXkThZMejS01P4oEQ0W3KtJ4drnbJuZe+gP29zUfAX1207kcpfRF9Y/L14xguMOiRktaEhrJP7kvfA1wLfOoj4G4awuj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130399; c=relaxed/simple;
	bh=96/WVMIDSBKKgJSfQ4EIO42g3fE0wTNJnou+Effn79M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USBicsBVcrMlUcJRfU5mDavmJzULjRpoGAicrEfKrka7XC9Ef6FehjfArcHF6Agcp4BqBvfWZJ1k0e8FIOLva2lEmPXziJBwBBRVISvVaHrfLhT27etQtkJPFyCe3S8m4imAID4yJwulRb5JMntokA4PSI+pnSprmh/Igy2ojFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPhOcr/Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=enP1a3Or; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775130389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
	b=UPhOcr/QGPtWmNzdv/wi2PljI+aNH2/qsv4IVAGrlw7A8fVIXWrOanGr655u5O/kWwm/C8
	3uiUIhSQ331Vw81W0kGa20EAFxrfNdaD8hmvTSo/3Icv1F8zsrEz7pq92g1674EcSr5DBM
	R0l4tQmV5GqcdfPumjrGUGXKeXf49xw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-hzz3cBorPVWOZtx8fLA_0w-1; Thu, 02 Apr 2026 07:46:28 -0400
X-MC-Unique: hzz3cBorPVWOZtx8fLA_0w-1
X-Mimecast-MFC-AGG-ID: hzz3cBorPVWOZtx8fLA_0w_1775130387
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso9450115e9.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775130387; x=1775735187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
        b=enP1a3OrP3GpfEEarv4+JTv3C0WAGcaypormI5DRQkQ5YXwR7ky3e+AFOu1sjrnvzh
         9cPQDCzWeN2b31nlCHoOf7LMNSGO7zMtmHNhZ6CSOWHa3bzZmUx4x2kfs1DlHv/+lH6g
         zgqCE4VCWfAqrFuA+BwVmuZwTEjXd5dijRpvrLtt+bN0KDpJ2cMNImME1kxkwAFVZFhi
         iNL3vRXdE+mTi+vcHzNFfHtRF0IIzuo1JwhOEIekOFDT1JqfiRcGK7CA5fD3+3HlfQ7l
         yKQlr15Qr8m1ygIf+FjX/EBQcgBwL6N04bb1KpzBntxJS0GVg5ha2OU8Rm9YSxpHGYF6
         q1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775130387; x=1775735187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
        b=mCZFuFyoU29qx90yJnmeTdmh7+QwKipJkp94jXj2OSToHB4cEM6xerI7modX/twCt6
         Izsw0tV0eDrejEZtPGS1i7CLhSYj5nakmmF4CLBenusXxRx6cZPB24Ytgddt76zy9BvF
         cyGyompVarmb3miwdMhFNS4cSTtcB6YlXnzhHEYGNlmRmRZzetRPXDIOMsDusC0oO/qm
         6thj988IrCUWGWebSV35Rd76Tz+WkZ4Emt/u1c0mMhlXoSE79/LmB3Rv+xegvOZzsSIR
         zdLoC8pl9SegLQlJkargovnvnebOwGiXFoGTZJTwYSLMm9pSU7R/ycLq6s8/Y5HofpGH
         pC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUTfdNbNlXwN2WJsxJThAB+16tCv2b8LiY02D2kXJvqeYXMmmcj71qr6qOFJFyJ+Jo2GzZ2ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aM9jgS5/kK2QP26Qto9LtwtW5cQgS9jSE/kztst3wuVi/5U1
	aLxQspRlaIFWC5oNelAMbULBbpugFSW6J2tkIr4sL2dJvuHfs7rOYixITNa/jEEfLl/dc4QL9EK
	2Hhh0jzOEdgfh13/rwtHDR98yPxAkUl2YUaUwq3BN9+Uccxrfw6YyqnLeng==
X-Gm-Gg: ATEYQzwOQZVurD1PvyzgegdNrtBfsovkwckt+EpMyAzyZxE41OkRquwNRIsfqLqwoJj
	bar66ZhFu48TfSdo0q1kibr7M9ZLDEy7WcsgkFn/35V/0i6jtAXUVgPugv26OQ8c1FfgjZV6JlP
	btZpsT4j6Q3EwUkbmR0OiySPY+kGLm6lL7CZOxnTfONFY6p6DnwKVc8KquWNkmKbb0bMQnbBfBv
	NHPCT8VOHdwiqBkHKUKp9G+bZo+uNRhf4XvLcn/2e5rikTG1QsjE3V8k4ewTk8ml3ifkC+5ZlZY
	0e0YQ9zF24XGMPyP5005YMdlsfTN6IC0XFoVgM6vP2l2wTuEVqL8MMywsIh2JDwT+/tFGAVzQ+7
	cXOxuvz6J2bohMcS3jPNPwWGP1nz2U+d38sNJ/JjeN3GDGLLxkn1NtOFSfQ==
X-Received: by 2002:a05:600c:a406:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4888b7a0b07mr41585465e9.29.1775130387301;
        Thu, 02 Apr 2026 04:46:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4888b7a0b07mr41585005e9.29.1775130386828;
        Thu, 02 Apr 2026 04:46:26 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm62293295e9.5.2026.04.02.04.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:46:26 -0700 (PDT)
Message-ID: <d088beb8-d957-48a9-85c6-85775fef2ef4@redhat.com>
Date: Thu, 2 Apr 2026 13:46:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: fix out-of-bounds write in
 bnxt_alloc_vf_resources()
To: Junrui Luo <moonafterrain@outlook.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Prashant Sreedharan <prashant@broadcom.com>,
 Jeffrey Huang <huangjw@broadcom.com>, Eddie Wai <eddie.wai@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: DADA338891C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 11:57 AM, Junrui Luo wrote:
> bnxt_alloc_vf_resources() derives the number of DMA pages for VF HWRM
> command buffers from num_vfs and stores them in the fixed-size arrays
> hwrm_cmd_req_addr[4] and hwrm_cmd_req_dma_addr[4]. The vf_event_bmap
> bitmap is similarly fixed at 128 bits.
> 
> If num_vfs exceeds 128, the allocation loop writes past the arrays,
> corrupting adjacent fields in bnxt_pf_info.
> 
> Add BNXT_MAX_VFS to cap num_vfs at 128, matching the existing array and
> bitmap capacity.
> 
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h       | 2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index a97d651130df..cee67ca2955d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1398,6 +1398,8 @@ struct bnxt_vf_info {
>  };
>  #endif
>  
> +#define BNXT_MAX_VFS	128
> +
>  struct bnxt_pf_info {
>  #define BNXT_FIRST_PF_FID	1
>  #define BNXT_FIRST_VF_FID	128
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> index 7f9829287c49..18ac0aaf4166 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> @@ -459,6 +459,12 @@ static int bnxt_alloc_vf_resources(struct bnxt *bp, int num_vfs)
>  	struct pci_dev *pdev = bp->pdev;
>  	u32 nr_pages, size, i, j, k = 0;
>  
> +	if (num_vfs > BNXT_MAX_VFS) {
> +		netdev_warn(bp->dev, "Too many VFs (%d), max is %d\n",
> +			    num_vfs, BNXT_MAX_VFS);
> +		return -EINVAL;
> +	}
> +
>  	bp->pf.vf = kzalloc_objs(struct bnxt_vf_info, num_vfs);
>  	if (!bp->pf.vf)
>  		return -ENOMEM;
> 

Makes sense to me. It would be nice some explicit ack/testing from
someone @broadcom.

Thanks,

Paolo


