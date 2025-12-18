Return-Path: <stable+bounces-203002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F4CCC882
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2899B3057CA2
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EE34CFD6;
	Thu, 18 Dec 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOItW/G7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kZopEdPm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D334D397
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072186; cv=none; b=YsXljkcaaqzcPKYin24Uri/OQarpHec0cB+miLHgCEPvZQTVsI+++XsbMWuCjbzV9ChpOAev9tpkOtOZvE5nwPxnAFlTjwrPpvie2MnQLqgeu5ZliyMO7B2icHYdjFRnCuiAetLV6PZ/bkNxdwNminL5k+nArsrNZHmGaYwnNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072186; c=relaxed/simple;
	bh=HcQ1T2QJAcsrKq4bBhpA/oJASDi8MBf1Z81/YkVUoCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxPKKQn2Mr6oEJ2qwuIfUwU18Dgs5J8B8AESziYxAvF4IbScXYNxfPjg/FgUSfTMsjAVOLhacPUKR0DYhMO2wlnRr7OGBnxOLcjafGZDLpdo3VZCJSAn8CMnbrJqb41gmke/X+xffsgEHE48yF01xyto3uK+qYSBLpd86x+vJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOItW/G7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kZopEdPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766072181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
	b=eOItW/G7yvw5E7RfUjxf9gI/NR2rlX1vw4ssvMBSJpacxEAZVFyl/LKqx/egLL+rO8bXon
	W+q5Iky+GWKxtiZlYPtlgdTb8Yt+Bmm/1CdF2NqWzJT9wYgyu9w9qY+YCj1OR3QxzX67EF
	NKdLAP04WGs4w3O3QIyy8Usi7CLjMC4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-F5t7-WRANPGXhkUu23XQvw-1; Thu, 18 Dec 2025 10:36:20 -0500
X-MC-Unique: F5t7-WRANPGXhkUu23XQvw-1
X-Mimecast-MFC-AGG-ID: F5t7-WRANPGXhkUu23XQvw_1766072179
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47910af0c8bso7478365e9.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766072179; x=1766676979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
        b=kZopEdPmCyHl9AV1+J8QP/KusGO6TszEXNqSO10GnqThS6iXgIO4YeRJR2H5O6P1Vo
         3nNjQ9rnplabaSVmJwLSrBxvKFN9W0HaUyhMC1ihFR6c96PSooogUTtssPy+hkmGenwk
         DwWJmZR/G3KR9mMKbzYDHMtEw2YEIjVYMSzkdSjk9HmDpR6TsoNedjMqatrfSF4YhAPE
         2MdGU8+BxylToOYZDU8uh1byqwhP3K++exnisT0mIrnzVT85N4gOAG58tdJyHPoG8iys
         mpS/P1ZxGGwYBxHMcIpqwP8TOxawBwXtyinOsvdEbP+8J77wxtq7dpJEPmGSDi8TDbPm
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072179; x=1766676979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
        b=XpgBDL8w6yE1gDwpk2zhtzehIvCekMQOviJ7PwKRotGv1A7EfsBgtLCglQah8vNZj+
         Nj2ZciBK2/P9KxErrppxH1Esd9Am4JtX5FNdeaQ/qt5RA5e7zQBGPnRkCCgW27vxVL4r
         1fh5LWg0emRCulES4YRUemtL8yeAvYV77sSYosx8wak0BqPsVJZQdchOxzXDpNiNrDQW
         kB8lIHVywY4vjFnC/mdqwa+07LS2ZdwXJcKVib2v1AVoplBf9DFluRkw7oMOIZQidaXT
         ED/FW2bhMrzBiP8KlxkrFguA7iEH8cShirLLnim0D6qIxAt/o2CY6wv151zqJiHrqK0w
         VV4A==
X-Forwarded-Encrypted: i=1; AJvYcCVs8/uIN3Gn6ygQxInR0lE4gkYFpAJY85lmq2gRjzsGrlcu6qHYeRQSHIQ6ll0Fnr1U4MMj7ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9qSKczKj+HtB6MQ5Q4an1wTy31jaEhQnk+C/q8tW2wDmLrKr
	2RHjsi9JMKMRimDwgFNWV+vJ6WgB0yTdhcKsQkL4Ekg8GWGeL6Z8EI0bfkCQVnxIWurIAZ/Q/U9
	sYOrko1HZlNK1ogPl9VCbdWL70GXp/QVsPOqJeO08OqUptujQgAfoAdnxkw==
X-Gm-Gg: AY/fxX6M6BOx/e4gvdoW8jv3krCnF65bOUgjyBvGVZJ/PWIrGkRKBJ21biXC1MW0ctb
	cYyG9tktiTPccQWi/O9MpzcYc0eyVaK7eRVfrYt/3h+V+7ioxTKUrnm60f6s1iIUighRq9wYaMp
	fZoWqjbN4L/okAaND7cugiQP2LvZoQHfxJC/3JnchRWH/HGGjxxqmt7Wf57rRRW0bMu3RAE10RB
	xE3EKP6cc//9WsqDEDnFCX//Y9xu8RQeG8TEPICN2HiT9uX+Q+KhaV1EcIM9cdVqLgsWZa+JCSE
	7nXiXwtN4qm48HlQKqCP3rdA0L68rIMjeTxdrceP6TYEDtRxs6wGkJ8rCpO5BXxC0IXs9hlm4/D
	ueGw9jg5VsnBcRQ==
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-47a8f903800mr213401765e9.20.1766072179189;
        Thu, 18 Dec 2025 07:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzPSeaBpb5nGbuAxNoRgvwXIaPYaxEWF8FWstO/zIN8aNHf3vr7XOZckTOB1XmAE6KBJF8VA==
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-47a8f903800mr213401505e9.20.1766072178704;
        Thu, 18 Dec 2025 07:36:18 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be395d9cfsm16877665e9.0.2025.12.18.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 07:36:18 -0800 (PST)
Message-ID: <743244a0-41ea-4e7f-bd81-6814e852971d@redhat.com>
Date: Thu, 18 Dec 2025 16:36:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: nfc: nci: Fix parameter validation for packet
 data
To: Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20251210081605.3855663-1-michael.thalmeier@hale.at>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251210081605.3855663-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/25 9:16 AM, Michael Thalmeier wrote:
> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.
> 
> The mentioned commit tries to fix access of uninitialized data, but
> failed to understand that in some cases the data packet is of variable
> length and can therefore not be compared to the maximum packet length
> given by the sizeof(struct).
> 
> For these cases it is only possible to check for minimum packet length.
> 
> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
> Changes in v2:
> - Reference correct commit hash

Minor nit: you should include the target tree ('net' in this case) in
the subj prefix.

>  net/nfc/nci/ntf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index 418b84e2b260..5161e94f067f 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -58,7 +58,8 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
>  	struct nci_conn_info *conn_info;
>  	int i;
>  
> -	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
> +	/* Minimal packet size for num_entries=1 is 1 x __u8 + 1 x conn_credit_entry */
> +	if (skb->len < (sizeof(__u8) + sizeof(struct conn_credit_entry)))
>  		return -EINVAL;

You can still perform a complete check, splitting such operation in two
steps:

First ensure that input contains enough data to include the length
related field; after reading such field check the the length is valid
and the packet len matches it.

>  
>  	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
> @@ -364,7 +365,8 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>  	const __u8 *data;
>  	bool add_target = true;
>  
> -	if (skb->len < sizeof(struct nci_rf_discover_ntf))
> +	/* Minimal packet size is 5 if rf_tech_specific_params_len=0 */
> +	if (skb->len < (5 * sizeof(__u8)))

Instead of using a magic number, you could/should use:
	 offsetof(struct nci_rf_discover_ntf, rf_tech_specific_params_len)

and will make the comment unneeded. Also the same consideration about
full validation apply here.

>  		return -EINVAL;
>  
>  	data = skb->data;
> @@ -596,7 +598,10 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
>  	const __u8 *data;
>  	int err = NCI_STATUS_OK;
>  
> -	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
> +	/* Minimal packet size is 11 if
> +	 * f_tech_specific_params_len=0 and activation_params_len=0
> +	 */
> +	if (skb->len < (11 * sizeof(__u8)))
>  		return -EINVAL;

Again all the above applies here, too.

/P


