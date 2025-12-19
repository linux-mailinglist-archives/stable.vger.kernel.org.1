Return-Path: <stable+bounces-203069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EDECCF786
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE9F3082FF2
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B230171C;
	Fri, 19 Dec 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sve/ih0V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oPe70/SG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E127FD68
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141259; cv=none; b=ast6Gcul1T4u8aeurV2XHvAS+pIanvOxlSTTuOkUO0L6G/zolsE2ha32M13bWhBcb64q65LeAolpeQeRwM1OtIdBcuPznTxzQqespZqIfc2+C2hkhazXVSpk2zYSkUZHVjVlzNuY9WJAYwHpXQdivld9p8VyqKxQxt8Qq8XB/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141259; c=relaxed/simple;
	bh=jcSLquhQd9vs3yycLTlkV962wYyg0ao0gWX1c4mC+3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5YDWKeBDNHy1XaWau2lE1ZM13YzUUjG7V2PyrAYrcpcM+B6XjPghu5Tf7IpbyIyG/BEkDFMUE72yL1T5fql6P1J3CYudygYPBmXVXTrMy25d5RV/ZjSHhLV1o2bruxwVp6xVpUXKx8GfcM+Llif20Eg80442WO5XqwombSAMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sve/ih0V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oPe70/SG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766141256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohuBcRpV8beJcWGlYizxYN54dm2bkbetXdev9n84fy4=;
	b=Sve/ih0Vw2pVgKU0cGxjC3YsYfV9holvWWuJlg/revcx8CfzIvcMUi/ywNmmlSAuYMq2Pp
	GQRvLKqerzc/NAvbDZTb8LeTAuaN7P97flqqApfMR3xw6WXoPvx8bGF5VnSwow7w46bb+0
	hs3HqLFdX4YTE35qoLDHrmEi6Cjo7gs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-WCfZhgrXNLmzf3OE0YVkbw-1; Fri, 19 Dec 2025 05:47:33 -0500
X-MC-Unique: WCfZhgrXNLmzf3OE0YVkbw-1
X-Mimecast-MFC-AGG-ID: WCfZhgrXNLmzf3OE0YVkbw_1766141252
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso20608875e9.3
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766141252; x=1766746052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohuBcRpV8beJcWGlYizxYN54dm2bkbetXdev9n84fy4=;
        b=oPe70/SGbEnIO1GuIo0AHGvbShooriHLnEi3edlRDk+bhgLoBfBUKQTQAG9LfwZ5yK
         QIc8ZJD+eQOHgpLxYuBqRIbB9Hym14r99iWTpwFuoA+6hxr8bQa4sYG3w3rdpLEdYP9T
         eOfd9bhjP1R2Itslw2R4MJNnvtQDtRNKRfqrzjQLEmWlZXV09sth9LL+zsZe//Pq0QTy
         7tUjavN8S96ZVVz/30WhRP3YJjaKsWe/D/1BD3GvpcngDS/pFtgrk3UEefjRDsoO6vuN
         JW2xnVsFLSPuxsq4GgdvueEpmLlG0eExwfijF80WDZikEKnn31UleMrS6FS2SDRAo2Qn
         4TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766141252; x=1766746052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohuBcRpV8beJcWGlYizxYN54dm2bkbetXdev9n84fy4=;
        b=sG5LFTkH95zBkA5pC2Zabz79V2UEsClUzxAhtOMLOEaKdT3BFBldemq7HmVcsz/PNc
         kPsc35oxWMtJkKIGW5baYK5oFUlD2f8vcD8qGJEFmFtubF2xDYBwgcksJdDg0F6Xuj3y
         Ow6/vwBbjk45LVfS7D7MkU4VgSPdSvYPXMZhik9/zkub538Mo+X1/K/ujq910uJrJoAb
         kwT7SC8e2Lx73vEKU6WedNOo00fKvM/fn5D5+2hHQFWLK1mySF7f9Lnft+BHY3XesKF6
         nh7Ox9hBysVN7b7nEKVxJfXaIzcnxoNiGy8kgXVobkPVkq2w/l+pdwP1d798CdpNmIhk
         n2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUitLcKgQaTjbhXqdSu4WFAt/fA2AHqyjhW21VroIoOpqxhnUKxWIDKWlMSYi8P0+L4WjcEgxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU2aY8NApLRgdNnVxHsjVoKCW/bx+M0j3zFvRp9JJbLMYZ89t
	WxDYRmacRdaDiRwpTrc3ZLbUmC/9lQfQJbTC2DhoYc4QMUrATl429bEyG3900/3JfqhVDxxCnAb
	DU00mfN5ZxpJByYj5FcPQQLNWLhVQOQUg64oTEq0k36Z6zR67F1oQcejf/Q==
X-Gm-Gg: AY/fxX477pQGShviK5yUDXx2NUIieESYhtAmMOtGzlAn6WKEtwqHr+66CygroMAgLxq
	4YZgg/Nn12zmSfEDIfq30wtCGdGMwi1AYkna8fdSVkCbXSA0jrJ9/sGdgXo7+P9zE0cpTSt1gjz
	GinApSwlpYVD5mefidVGPiDCm4qB0G1naet4HLeDfLUYz0UyKp/Xe6sc8BRc2hJk5qskjfHQkGG
	bGDv3XR28vXKCq/PhgDnMYp7FKqMkQmsSkmJ/XLKSsWOKPk5HgpT1v8Znasxs6mHGtzq/wW/qRq
	j14Cq+TIIv2VkwV2elrU3F383eBcO9bjmRVzo5fU1NaiQZfomIBm7Q1z+WfJ5fkjVgb05kd4SkO
	G5WMgg+GcKM/2
X-Received: by 2002:a05:600c:6812:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-47d1955b97cmr21387405e9.6.1766141252216;
        Fri, 19 Dec 2025 02:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0haeKdz6e1wVUfU68PetlUVJ262uD0U3xuzOT7CFHMjUWuxjHWC2bHGvwH3+5rKwg5RCnYg==
X-Received: by 2002:a05:600c:6812:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-47d1955b97cmr21387045e9.6.1766141251798;
        Fri, 19 Dec 2025 02:47:31 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm92155575e9.7.2025.12.19.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:47:31 -0800 (PST)
Message-ID: <b547252f-9893-4c23-8b17-9808c8bdd0c9@redhat.com>
Date: Fri, 19 Dec 2025 11:47:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: qrtr: Drop the MHI auto_queue feature for
 IPCR DL channels
To: manivannan.sadhasivam@oss.qualcomm.com,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan@kernel.org>,
 Chris Lew <quic_clew@quicinc.com>, stable@vger.kernel.org
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 5:51 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
> Cc: stable@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

For net/...

Acked-by: Paolo Abeni <pabeni@redhat.com>

even if I don't see anything network specific there.

/P


