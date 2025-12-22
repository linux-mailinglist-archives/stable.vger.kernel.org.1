Return-Path: <stable+bounces-203224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8BCD6846
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39243303C9E5
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352F320CD1;
	Mon, 22 Dec 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KyOpUdt2"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AB2F5328
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416925; cv=none; b=o+GOmaj+mLfVtPDxSL7xHzUYY0x5/FZqd3O/80Tpj4d8jLoiwRxqqKjRFjpxu5sQWAxPA7TCQNwJmwqws+bkrAbVpqU98l/HhVaHg2Mo6/U2OCg5bkWduUxrAZdgVPtpTbVxF0Su/ut6p+c1N5LSTMzGE407ja2KiBQ66fQTsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416925; c=relaxed/simple;
	bh=rsfsZQFUXvUgzB5b7ipEisB489aciHhgsARMx8BUDXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/5tXNIjhyj2sQGyTDrwGBk+3doeOcxS1IiRq8ktqZQcfx02IBwgMOglLMZF0xZXn8s9AWrgFixSzVRtKntLk4cYQyvq7RoKh09mSMgiLMJ5Cmm+OHtFEpHasV/xT6RD/UCmlektzJxCVQsagqXnjjKIbdoaJE+zn9j69bwD5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KyOpUdt2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <059d9fbb-7383-441c-9368-1c96eafae1f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766416921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI5w9UdO/kkIcZxLRIb64c8Q+gNUOfD8NA1o77mtVOo=;
	b=KyOpUdt2qXZAHwApTZEn+TK7+V5b2/mHxe5pCCZ6m7LYrWZtCgUSL+6Boab2kVZIsSbNst
	Av7vrU5ixPqFtXolhl6wKxLrxuHGNJaCo/wkP3TSMrAOH+tU7sXEsotNGn9lYoSROvmkJv
	d8Qm8eR0LuwXI0fMxzPXUFcPGtK1F8k=
Date: Mon, 22 Dec 2025 15:21:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: nfc: nci: Fix parameter validation for packet
 data
To: Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20251222143143.256980-1-michael.thalmeier@hale.at>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251222143143.256980-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/12/2025 14:31, Michael Thalmeier wrote:
> @@ -668,6 +679,11 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
>   		}
>   	}
>   
> +	if (skb->len < (data - skb->data) + sizeof(ntf.data_exch_rf_tech_and_mode) +
> +				sizeof(ntf.data_exch_tx_bit_rate) + sizeof (ntf.data_exch_rx_bit_rate) +

extra space between sizeof and the bracket

> +				sizeof(ntf.activation_params_len))
> +		return -EINVAL;
> +
>   	ntf.data_exch_rf_tech_and_mode = *data++;
>   	ntf.data_exch_tx_bit_rate = *data++;
>   	ntf.data_exch_rx_bit_rate = *data++;

