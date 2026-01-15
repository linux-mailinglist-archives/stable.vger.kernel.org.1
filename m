Return-Path: <stable+bounces-208436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23AD24300
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8FF309F8EE
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648B37A4BD;
	Thu, 15 Jan 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTbWMzsX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSI+99es"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDA37A49F
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476327; cv=none; b=YgUAJIwHgz2kjNc32uxJz93HQ/eDXhH9tH63BgV1XTpDsyLyf5CeadwrSOB5ehTzda1CWz0/IX9CHE+jWLaFEW/RP4oaz2wZitGrpsCSXiOYL3CNIdVwpDl+wVvorZC3TyXv+1nDZpkofh/vxnyZ6c6JebJ6Xw8BqY0Hj1QVDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476327; c=relaxed/simple;
	bh=H2Rd0lLdKRFcnzUCm2F7g+aZlfEhedtUjCpakzmz5Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmXGLSz9NCuTiueKtFJeo0QB4cZGRGa0FWIcJuvA4vsJUUWGAyPTnfqPQ4HLHHC/BbrtEADoPrE3cXc/VSKxuCFL7W7jtVmik0OoEpZi+3gc84XaT8btc2L4EpML2/6IWr43UCdfNP8TmuPUhvRqTGZzX54JxLoDer303YUQ1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTbWMzsX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSI+99es; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768476324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Daj4mBvKz/orNgYkU+OBGpVjcjRCjHiW0Hdgz6VukRA=;
	b=TTbWMzsXytWPRYa1XY/VYJr/DrvAPz+DOq3oqVhksCVjkeoRn9m4/B2GI5EPqvht32WU7p
	yZeCUtdWQSVUXTG95zA9ZS+9sZiQnF/ABT0CuI1TzXlYZ7zyqGCrgB2EQBNJu9WyfdcjR9
	Ez232tejwWga/S5iQz/Ey7oQHFDidVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-oNjkqfreNbuew1q2_8rvqA-1; Thu, 15 Jan 2026 06:25:23 -0500
X-MC-Unique: oNjkqfreNbuew1q2_8rvqA-1
X-Mimecast-MFC-AGG-ID: oNjkqfreNbuew1q2_8rvqA_1768476322
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-434302283dcso654899f8f.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768476322; x=1769081122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Daj4mBvKz/orNgYkU+OBGpVjcjRCjHiW0Hdgz6VukRA=;
        b=HSI+99esRvWQ644N5Z8DtGiWLt3PvNMqDMstxdZsXbXCxpLIwMG9wB1BRORbKPhzDK
         FFfezjf/PsXLurzv5XwDAukgxyO8CmNSY5E3guVg7i7RPYMTZ70Hakh8dcsNEd5WiNmR
         ZT6xFQ0nBP6y5TLqGtwWHrwVbhxiJ/etTkdGt6d1N3t8lbtiZl+KQptcEurXP8GMNsjW
         0RjLCEw0vZ/tkCIJi76Ki7Fbu3pnFVleTBBchzAZ25qVn4M4Jsym9/SYE+fBqsR9VSic
         ZEU3IUj1FfPRzmPkPSwmBdmLivSR93ETklyuCFa1r2Daoqg5Xpug5SlMQQssmUCMhCBX
         os5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476322; x=1769081122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Daj4mBvKz/orNgYkU+OBGpVjcjRCjHiW0Hdgz6VukRA=;
        b=K2vVuHBD/hNknDzZpdslSI+/vOCKr9xfH/llUe96DqzwF5OjtiGQ40KQXvrlYaz7/6
         r2+P1frIvtYYk6UvqKOCYNcTXLFfvgUU+Hag//jfJytRUs0EI9YeWe+gvl3o1JWi8Sa8
         okJayH+6K76otEIEQW92epksDEo2QoycF1ry2mKaLvQAuEPAErZK79T+4pRQJyznq1qX
         LwYtOky5ul+vyzwjewMDk42bmpk00GaofNfW5zgv8quR7eaTCUbc2UzY/FHSNzQAfulm
         pPGpP1LzlJMfvA/28/rzu4p+n7RXavRmdrTQ+PcgNvM2zJzPFBCxJxP174C0eLYCbkF/
         GoUA==
X-Forwarded-Encrypted: i=1; AJvYcCXTD22PYjjYkuWMwPser8fmRjXyZvmXIFe8vfrCp3DY7Dq8Cv2oVHUwMkMMt1ihcf9D5ME8L+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOwNYo7+zSYmcXH64QoQ1lZLglsKkpMKPO0kjMmUocbPJMP6f
	Mcn2fs4oSw35Tm0J9L54TUggT//CLXiv8oIQoW9nJgw2cEbsld5UOWDO0HYDEnR4THY0r1cMozd
	D4ptlPqUNywKNTveZjw4qH7bz1TN7nIObZCqEvngeCR3KVyioKHFY2C/sqQ==
X-Gm-Gg: AY/fxX7G28lEVlGgHaWVB+NKQ89hTueQ08gLCGDbQckkpEIg//4CIZe2w5yuoYzYvGx
	WM9N5VHpWgu/wSuDyVtYnNDMPT9dx0Rc4ZCDQKiZh0ByJgHp28azy2WH8V6u1eoPRGDSVszPn0S
	4MMnZrEJjXZ2FoEtSRGHDPG4wGTt6Q9+gFxhNZK/bY4XsA9emaznXYGPRWaOgYUVJtlAeYXXZDR
	UTHmqjdaqXRG3MzipUxkYc2AU7e0QQ4XqJKDFPPRDg60UspzgjspFMnpw4zBZbmXv2e92/tFz+W
	UQlZRJCXoWJHk5DhPpK+yID7UtqN6dqb0ItexbUCMXFJFaJzRZyOiq2uuKb4FRgAqXCD+g+nuJr
	3O+aENg8KqYQRbw==
X-Received: by 2002:a05:6000:420a:b0:430:fd0f:28fe with SMTP id ffacd0b85a97d-4342c54ace1mr7936679f8f.31.1768476322533;
        Thu, 15 Jan 2026 03:25:22 -0800 (PST)
X-Received: by 2002:a05:6000:420a:b0:430:fd0f:28fe with SMTP id ffacd0b85a97d-4342c54ace1mr7936636f8f.31.1768476322080;
        Thu, 15 Jan 2026 03:25:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b2988sm5137976f8f.28.2026.01.15.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 03:25:21 -0800 (PST)
Message-ID: <21e77ec4-fa57-4a9f-8d9b-c417fd908ac6@redhat.com>
Date: Thu, 15 Jan 2026 12:25:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: nfc: nci: Fix parameter validation for packet
 data
To: Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20260112124819.171028-1-michael.thalmeier@hale.at>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112124819.171028-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 1:48 PM, Michael Thalmeier wrote:
> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.
> 
> The mentioned commit tries to fix access of uninitialized data, but
> failed to understand that in some cases the data packet is of variable
> length and can therefore not be compared to the maximum packet length
> given by the sizeof(struct).
> 
> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>

AFAICS this patch is doing at least 2 separate things:

- what described above,
- adding the missing checkes in
nci_extract_rf_params_nfcf_passive_listen and nci_rf_discover_ntf_packet

the latter is completely not described above and should land in separate
patch; note that whatever follows the '---' separator will not enter the
changelog.

> @@ -138,23 +142,49 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
>  static const __u8 *
>  nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
>  					struct rf_tech_specific_params_nfca_poll *nfca_poll,
> -					const __u8 *data)
> +					const __u8 *data, size_t data_len)
>  {
> +	/* Check if we have enough data for sens_res (2 bytes) */
> +	if (data_len < 2)
> +		return ERR_PTR(-EINVAL);
> +
>  	nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
>  	data += 2;
> +	data_len -= 2;
> +
> +	/* Check if we have enough data for nfcid1_len (1 byte) */
> +	if (data_len < 1)
> +		return ERR_PTR(-EINVAL);
>  
>  	nfca_poll->nfcid1_len = min_t(__u8, *data++, NFC_NFCID1_MAXSIZE);
> +	data_len--;
>  
>  	pr_debug("sens_res 0x%x, nfcid1_len %d\n",
>  		 nfca_poll->sens_res, nfca_poll->nfcid1_len);
>  
> +	/* Check if we have enough data for nfcid1 */
> +	if (data_len < nfca_poll->nfcid1_len)
> +		return ERR_PTR(-EINVAL);
> +
>  	memcpy(nfca_poll->nfcid1, data, nfca_poll->nfcid1_len);
>  	data += nfca_poll->nfcid1_len;
> +	data_len -= nfca_poll->nfcid1_len;
> +
> +	/* Check if we have enough data for sel_res_len (1 byte) */
> +	if (data_len < 1)
> +		return ERR_PTR(-EINVAL);
>  
>  	nfca_poll->sel_res_len = *data++;
> +	data_len--;
> +
> +	if (nfca_poll->sel_res_len != 0) {
> +		/* Check if we have enough data for sel_res (1 byte) */
> +		if (data_len < 1)
> +			return ERR_PTR(-EINVAL);
>  
> -	if (nfca_poll->sel_res_len != 0)
>  		nfca_poll->sel_res = *data++;
> +		data_len--;

Last decrement not needed as data_len is never used afterwards.

> @@ -181,16 +221,32 @@ nci_extract_rf_params_nfcb_passive_poll(struct nci_dev *ndev,
>  static const __u8 *
>  nci_extract_rf_params_nfcf_passive_poll(struct nci_dev *ndev,
>  					struct rf_tech_specific_params_nfcf_poll *nfcf_poll,
> -					const __u8 *data)
> +					const __u8 *data, size_t data_len)
>  {
> +	/* Check if we have enough data for bit_rate (1 byte) */
> +	if (data_len < 1)
> +		return ERR_PTR(-EINVAL);
> +
>  	nfcf_poll->bit_rate = *data++;
> +	data_len--;
> +
> +	/* Check if we have enough data for sensf_res_len (1 byte) */
> +	if (data_len < 1)
> +		return ERR_PTR(-EINVAL);
> +
>  	nfcf_poll->sensf_res_len = min_t(__u8, *data++, NFC_SENSF_RES_MAXSIZE);
> +	data_len--;
>  
>  	pr_debug("bit_rate %d, sensf_res_len %d\n",
>  		 nfcf_poll->bit_rate, nfcf_poll->sensf_res_len);
>  
> +	/* Check if we have enough data for sensf_res */
> +	if (data_len < nfcf_poll->sensf_res_len)
> +		return ERR_PTR(-EINVAL);
> +
>  	memcpy(nfcf_poll->sensf_res, data, nfcf_poll->sensf_res_len);
>  	data += nfcf_poll->sensf_res_len;
> +	data_len -= nfcf_poll->sensf_res_len;

Same here.

/P


