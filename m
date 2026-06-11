Return-Path: <stable+bounces-262784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cHFXJETpKmoQzQMAu9opvQ
	(envelope-from <stable+bounces-262784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:58:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37712673C96
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:58:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=hxVxaaVz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262784-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262784-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7A730394E3
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301C426D09;
	Thu, 11 Jun 2026 16:58:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE18328611
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197121; cv=none; b=VWhZTUW2VVY84zvb+HwtMB0dqv3uG9V1QxHFSwuyvCqOZeP+pk3R1GHPASc8fjH5/qzB1k2XPHEjHMgc4kIbl5lF0mtOz+J4JwG6GxK11vQHPC6SXEUGNo+FCX6VoDx7y5QOhfjBGbrCVpQhNFrzTCX5RmSxTH50cv4495p0aAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197121; c=relaxed/simple;
	bh=MtH5MrqfJ0innke6B507gEspNv/Po+C6OSD5D0FLWHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRztd1vh+W5M0ybDFOvwrb0OuYp2NwSpkn8AOW9IazdUtjwqzBDqPvCol8a2QzubR483KayzOebGtsQ5NPa3ZlFOR3WNoPO04+/6i05ggh1YPIgAUQsqIY/vKGrV+nauVt55G9X8wnxkD4RqL0CIladYPSVJTvB98WBKHw1Ppac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hxVxaaVz; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c0c3315c5dso715695ad.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197119; x=1781801919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9ksOv65wdintddQvv5k0AzyLLccSaifyeuockXa2a8=;
        b=DbBdpX/jcfrDMuSrJnMoOM9YXW7VgURVn0fMF2tCEBcCXVULwkYqlnIcHjdQyZGcgZ
         OLAfr173BcBuwvKnlslv5DpMCUPahYQSH/3JRqCq9VnWKYBUVsMJAu6L2rTU8aBpujn1
         d82IjZx28PhhEH3Ac+qVLi9ld1kAA+VVdnfDgSaIsnyLkNEQYqlesdXxHRvQxsHfQZ4W
         roDiKyla/L5M8AqOKOkSCGN5Ps+5imz1ddkTdGeSoHcOWvZZPmWsdIqMwS8ecyWwWqWD
         kCfSFAxf3ClsCEiCCpzE9aBiebQS+UrUueeEcutYnf8w68tR3nr4d4hwIYO+4wf+Pk7Z
         o5MA==
X-Forwarded-Encrypted: i=1; AFNElJ/6wrhgHiMfPGX5zmbfj7qPID9UdO7ZIM35qa9VvmC9ZEvTIYmHe5IqZuXvHSeH58l1Ts0+S0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxxcX+NTJJmXw/V52kTtr58q05eNe149yWSoYkIPtK44pwmry
	4ZYeXVhIhIEhLE+fydkLeJl0EhRKNsRewbv+aomLQA3pBOB99nrhKeEpzBQ9bhaosNV/faaQs+A
	XzRL6KBm2myB7pdfOFf29b2abxnPOtBfyFq5uRZm6AY7TSkgRXpGWZVeXnripW6rucwR96/T2ak
	c4kLsC7BknKZ8LbKLqSs3Ccce8q71inoz53mB1MMa7NbAJUeX8ple6sFQrXcdjwIxu7Usj7hBaf
	siLve3+ng==
X-Gm-Gg: Acq92OFuzybP4W+wnKrBV1oMAq0NAE3Jv2HAKCPNHhRYNtnTdRGfpBlDvT62XX8jO4C
	6TD/Ccs6hdVL/mQZbHncTqTXCvQdvEqXE+GyKJg7sVH+pU48GCAoAxD8sPX9acdowrLbhJNIug6
	tAAjek3I8Mtid7eNQzlye1S8gqttAtk85zBt6HG5ezOlId2mMyUMIiyGTYIyiPfr/4VtyHeVIku
	bziHUkdf7SL3X7Fwem83VCu6ycJ1zIb6y7xYdPeMu7/aqrxLNtOZDh8I4vnjvdJe7XUKncKE0sa
	RnL8r5MN7RnGz4dBVrekBxnXhoTgpmPBqx8r1uVZxd3gfHFksu8j+11Z0GMh9XfW0VCc4UtqftW
	+iS5dAncsV94yz+34HKBC/cFRZ93vNVjm448DJMVsPdrW6oE9j6yHHHYPjnC5lASxqEGCd69ppF
	67gRsuRkUoa91ds1pEVBqAhiAbdTv4M5AYzS/eOQ53vE7sfbpcM96tB9s=
X-Received: by 2002:a17:903:3b83:b0:2c0:ab82:6ba7 with SMTP id d9443c01a7336-2c2f3055e26mr41861275ad.33.1781197119202;
        Thu, 11 Jun 2026 09:58:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c165f9fde9sm25675545ad.30.2026.06.11.09.58.38
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:58:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cebec24b12so1995306d6.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781197118; x=1781801918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9ksOv65wdintddQvv5k0AzyLLccSaifyeuockXa2a8=;
        b=hxVxaaVzM/qeI2pr+Jz1g0nnEz1Ta2Db/tkBXQG4vscYSwaVWRj1bfN454HPtHsY1N
         S/3yj7VIwamXTGrQcLCqofD/hHbF9MR1sFy1h6V0DvYa7Q13qLaRt1uQGqw1mZfz5ZlM
         08xBZxWNuWxyWEBINEs1PkKA7TkT5fns+vUT0=
X-Forwarded-Encrypted: i=1; AFNElJ/XEbkpFWOct/u1p2XJ7e+8tdxOg3hhRE1PRgQSfpDCHLliMCzCz83aSTub2OhSUOVTkFWfZ7M=@vger.kernel.org
X-Received: by 2002:a05:6214:5708:b0:8cc:d765:4fb7 with SMTP id 6a1803df08f44-8d1dc1a5579mr63985816d6.35.1781197117730;
        Thu, 11 Jun 2026 09:58:37 -0700 (PDT)
X-Received: by 2002:a05:6214:5708:b0:8cc:d765:4fb7 with SMTP id 6a1803df08f44-8d1dc1a5579mr63985216d6.35.1781197117239;
        Thu, 11 Jun 2026 09:58:37 -0700 (PDT)
Received: from [10.14.7.225] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f3a5sm23064766d6.18.2026.06.11.09.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:58:36 -0700 (PDT)
Message-ID: <d8def490-4740-4ad6-ba9e-c2f6206453c4@broadcom.com>
Date: Thu, 11 Jun 2026 09:58:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bcmgenet: convert RX path to page_pool
To: Nicolai Buchwitz <nb@tipi-net.de>, opendmb@gmail.com,
 florian.fainelli@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260610114835.2225423-1-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260610114835.2225423-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phil@raspberrypi.com,m:bcm-kernel-feedback-list@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37712673C96



On 6/10/26 4:48 AM, Nicolai Buchwitz wrote:
> Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
> RX path with page_pool. SKBs are built from pool pages via
> napi_build_skb() with skb_mark_for_recycle() so the network stack
> returns pages to the pool, and DMA mapping happens once per page
> instead of once per packet.
> 
> Reject HW-reported lengths smaller than the RSB so a runt cannot
> underflow the SKB build path.
> 
> Drop the now-unused priv->rx_buf_len field and the rx_dma_failed soft
> MIB counter (nothing increments it after the conversion). This
> removes the "rx_dma_failed" entry from ethtool -S, which is a
> user-visible change for monitoring tools that key on stat names.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Tested-by: Justin Chen <justin.chen@broadcom.com>


