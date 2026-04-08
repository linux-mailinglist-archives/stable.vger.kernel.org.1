Return-Path: <stable+bounces-233934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHgFAmF31mlQFggAu9opvQ
	(envelope-from <stable+bounces-233934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:42:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745F3BE605
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCA1A300B53B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAEA3D6CA7;
	Wed,  8 Apr 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="MnUy7ktk"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8143AE185;
	Wed,  8 Apr 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662932; cv=none; b=PcunxTdYyk21qeBWonjPicSmJaXosJrem4TavLvVklgCujkG8m5KjSj5m3/uMNOJNNRq2SdiO8btVWRrugWjKST8i3QIwwu0APAT+4j6nO0BERoUGy46WK/pe90qRPTqjEQWrUrvyAWNxPF9fC13cU+9cn5CFjwZRtJba/BYvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662932; c=relaxed/simple;
	bh=W3QxEp8Ylxf5MMGPhDx0Ol703Avt7WU74+M8FdwX34o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaUTxRzdQ3TtatCOPGM+ES6+bRxwlFx4R3b8PMsxSHXR/1WQmXU8lP12kNe+Xe0qBPke+X1C3VX+zXTl6xVaHCL8qVtnO6I3FAn402w3PYbI1O4VTRmX4MlC9/7ZtWobROokUplrFbxu++cmXDiicxFmAJS1I0ugUDXdU8Z3Z7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=MnUy7ktk; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DD1D1120B4;
	Wed,  8 Apr 2026 17:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775662921;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IdmmjbfVYEjHv+tYxYslz652pMJ8SFMHqeMgby0OirM=;
	b=MnUy7ktk7JYp0ro72qS5AZDBKy6qvuyYt7KB6BSXLZLVXEMU0DPH2vvsVrmPbfGM56ygfL
	WWvlaARSPX/3s5cb6m2pTtrJf/hllsqz0x5TxYjZOJQAGxC//cj5D3gzX/7f3OA0bP4yw3
	QQyN8r2GPw6SNy4H9f0ZtKNK1xBRx5kbyBvviRb67BB48obPcpxaQ2BcS9PbSlHif8pywk
	46mbQsxTB0fYA5obF5n3qqVrD5BH9wR8oX/SYPFI0GKDOf2N3C+FQdxk2+UbK+R48ThZjv
	ZM+J4qCel0ffSkz/9QKFqOj6zSlZpteLqdd5ASY0K02dDpyIWeRmFcJFh/7K7Q==
Message-ID: <a9845b8e-5d3f-472b-8f03-bba699ba3882@nabladev.com>
Date: Wed, 8 Apr 2026 17:41:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260407212344.80265-1-marex@nabladev.com>
 <f4010cedaa49afc1648a73775a987ee5@tipi-net.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <f4010cedaa49afc1648a73775a987ee5@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233934-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2745F3BE605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:54 PM, Nicolai Buchwitz wrote:

Hello Nicolai,

thank you for testing on the SPI variant, that helped a lot.

> In order to make this work I would propose something like this (which 
> works in my SPI setup):
> 
> --- a/drivers/net/ethernet/micrel/ks8851_par.c
> +++ b/drivers/net/ethernet/micrel/ks8851_par.c
> @@ -60,12 +60,14 @@ static void ks8851_lock_par(struct ks8851_net *ks, 
> unsigned long *flags)
>   {
>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
> 
> +    local_bh_disable();
>       spin_lock_irqsave(&ksp->lock, *flags);
>   }
> 
>   static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long 
> *flags)
>   {
>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
> 
>       spin_unlock_irqrestore(&ksp->lock, *flags);
> +    local_bh_enable();
>   }
> 
> Tested-by: Nicolai Buchwitz <nb@tipi-net.de>  # KS8851 SPI, non-RT 
> (regression + proposed fix)

Are you also able to test the KS8851 driver with PREEMPT_RT enabled and 
heavy iperf3 traffic on the SPI variant ? Does that trigger any issues ? 
I ran 'iperf3 -s' on the KS8851 end and 'iperf3 -c 192.168.1.300 -t 0 
--bidir' on the host PC side.

Let me prepare a slightly updated fix and send a V2.

