Return-Path: <stable+bounces-181681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1ECB9E1AD
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DB914E1935
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512ED2777E1;
	Thu, 25 Sep 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC33709i"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C11277028
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789923; cv=none; b=moapziXioDNKfFhwu6hM/MptHuDrfTPGX+frlQLNXkLIrmvgcbja+f1BPI888KN30nzgIWFVQney3SP80uh6zZUwteQafgUM32Nv1efX+IaxhWF/7yuwI4hBdntWgZAxEXyFmXGSiO0azI//P4BjBFepB80PgkczP3vh1bNh7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789923; c=relaxed/simple;
	bh=qC1aIoK5yYcF83FkI9Dqc3KWerwB3ZBIP/sva6h4a9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYpRQZCZzT8L5R7El5Oc4z5iBhCDgqiArIzKTX4bmqHMlbM0FVT5JLeu7L28nJ7lU9RN8NBshZfaz4Uwdv6zfOUvTlrnmQkkXAi25jVQCxEITDxHn9yn2tUA266bEeK6uPH2ZHL+ksDd06kvjW0YAgZnib7ot0W0rCBg3hcv0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC33709i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758789920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ShWX7vwoNNn+VH+yd+QMji4HEbe496xkh5xSQsMnu0=;
	b=OC33709i+7jes+BNHIYwmWUuhZB5B0QKUBIiVnAHL3sD5hI7uyfsCbs3qWTf1fMmahHwaP
	ucrAMgpbMQgOv3w+UtE1oKHHpj/5fVa1kl+7fAOhJ/4vlP9U/jB3fFefUtUYu0SWpu+KGX
	036BD334KCWcwiWRNnYgCJfetRFOhhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-d1ZShvh0M3uis9uiFZFFYA-1; Thu, 25 Sep 2025 04:45:18 -0400
X-MC-Unique: d1ZShvh0M3uis9uiFZFFYA-1
X-Mimecast-MFC-AGG-ID: d1ZShvh0M3uis9uiFZFFYA_1758789917
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so768053f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789917; x=1759394717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ShWX7vwoNNn+VH+yd+QMji4HEbe496xkh5xSQsMnu0=;
        b=hLqPFfNWN6JolE88V4FOm2mr441WngrOkwt7O6il3ixbV6mGNn/N2NMVVE0JwTOwe0
         tBQixrnempmRU1g+n5zl7BckrKF6qDpN7sYmFbpH3Nngs9dQcHOIhs8Lt+d2D3e7CmR3
         DhWNHceNCOeG2xCT27gEYT9g/U768jhlvlqB3U5L0r1fVjwmb6ycdXO4WJrYYXlEKmHw
         Jc1/kZPep/Z4NvdIZykHzvz5LzKk2rfBPYok8FXEhyh7OI0IAHEe+MTv9RvT0OOD6sSG
         ozCnVsewPG5fy+GOkAqOkC835Y/n47oXaZM4uU7Sz5XEMBNDtctjx3r3Lm8Rk1cr0530
         CoLg==
X-Forwarded-Encrypted: i=1; AJvYcCWOAFzzbooMwCXWWbAxVCoh3vijS1nRdg/GOvv2QE2B3qCU+hIGipmLkao5Fbv8l55rLZHd7Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91kg5A0cSnn1QKaeCFFWs/uGpBMQvoClX7iVBfLB78Hxgw30D
	Z4eRZ8HUrAswS/vXMXJLjKyNTxOazRDminl3KuHYEb1l+icAJU8SW2MYkdcasBWlFxlEL7ErkE3
	+j6NXGUXYMF3/5KY7B8FyM5TWPRcU/FA4mslLZFhYQAybms4BAy27isur+Q==
X-Gm-Gg: ASbGnct/kWL7eWgnLSufGIe/DV53N+j3na7Ru+L+17WKCtqDBH/hAHWQNnzo1uBTA9I
	RbrWGXOE4CJSUIL493WP6e+R3Nifo63IjYuTY9EVfeTPVonoiq4c/tgCI6plk+0LqQdPgMyrsf7
	8snaC8iSKEtaWKTIjZAnsmndpbOYitSXgP6W9ZqIw90VAwinYYtNTBW0xxEEG6k+idrgmX1KWY/
	rAbdO/kCXSJLRse6GFLEGRPASx5iUnT89QWSBdWwYXg23v/4NkS7B1AZb/0GWKrLHcaRnpz0BME
	tQ3/K/RYxylRcmBuuLK0zy5aP8ldeSSZNQnRV6dwTCn4KFkGZt1VRQ6H+g34NPe+rQ2HHV5d9Gv
	g3+k+7zSCuFj5
X-Received: by 2002:a05:6000:2302:b0:3f3:97df:a2b9 with SMTP id ffacd0b85a97d-40f652293d8mr1558661f8f.24.1758789917235;
        Thu, 25 Sep 2025 01:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8MnKrqVU5iaRZyEisFTtWADltgBvMSKns5i2HHc+LVMjxuzcCkWpGyCR51gWllXQXpAW+mg==
X-Received: by 2002:a05:6000:2302:b0:3f3:97df:a2b9 with SMTP id ffacd0b85a97d-40f652293d8mr1558628f8f.24.1758789916763;
        Thu, 25 Sep 2025 01:45:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm1974284f8f.33.2025.09.25.01.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:45:16 -0700 (PDT)
Message-ID: <f95da89a-152d-4899-8068-3b6aab568825@redhat.com>
Date: Thu, 25 Sep 2025 10:45:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net v3] net: nfc: nci: Add parameter validation for
 packet data
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, krzk@kernel.org,
 vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linville@tuxdriver.com,
 kuba@kernel.org, edumazet@google.com, juraj@sarinay.com, horms@kernel.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
References: <20250921182325.12537-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921182325.12537-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 8:23 PM, Deepak Sharma wrote:
>  static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
> @@ -501,7 +536,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
> +					    (ntf->activation_params.poll_nfc_dep.atr_res_len
>  						- NFC_ATR_RES_GT_OFFSET),
>  			NFC_ATR_RES_GB_MAXSIZE);
>  		memcpy(ndev->remote_gb,
> @@ -513,7 +548,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
>  	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.listen_nfc_dep.atr_req_len
> +					    (ntf->activation_params.listen_nfc_dep.atr_req_len
>  						- NFC_ATR_REQ_GT_OFFSET),
>  			NFC_ATR_REQ_GB_MAXSIZE);
>  		memcpy(ndev->remote_gb,

I'm sorry for the late feedback. The above 2 chunks looks unrelated from
the real fix, please drop them: they will make stable teams work more
difficult for no good reason.

Thanks,

Paolo


