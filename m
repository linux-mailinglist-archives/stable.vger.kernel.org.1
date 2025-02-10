Return-Path: <stable+bounces-114739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80328A2FE1A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 00:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C81B3A4B89
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55425A35A;
	Mon, 10 Feb 2025 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/MiSNjM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A11B85FD
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228545; cv=none; b=cefpV0z2ricS7QMVcoUOa3epy9AZoJitMN7F6lH+lcWJGN1Gndb4V3mzMyKuwGG7elhIuJ3p+Z/cVVqm/knV0lPZdLKJAml5cP9TZsJidoc0zjUSjDqsMAIcTjzdZu9Sq9Oid1j1Ckl5KN3rt5c1vjg293gK+QJLwStOI1l9iXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228545; c=relaxed/simple;
	bh=ny+ATBmbR1SyGAk+gxoXGyW0CLZLmrmFUn/0KjsvVzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBfcP7lFvjp/Wzcn8VaYoPIyFmVYnNI2olP8mk0fVbhMK43dzJ/e0f7crnnv4LvA0XNpVLEBTT5l95UT3/TQomDsBzbNoVaVaXCru2yHEe4ke+LVh44hGc4zME8KKr7zbqNTTlfbVITKyiOfEzg7+x8dnibvT0U52HwX8548Q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/MiSNjM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f50895565so52687285ad.2
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739228543; x=1739833343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/f3RPwfSA1e5eBKwDy2dScoEFSvk94d+X9rymYjEPPw=;
        b=t/MiSNjM08ZmLCMFqJwogu3mRQMZHdqrDziLqK/Jvh4aNuys5beN/P0DxgPTYriHAp
         1D9Uuwf9zZZkGdQxly8uQ+zJeRdxxKHqT0dBwKdzIEeCVALChcqv6Erc3U+KHry4a4L5
         GDEEpbpnJ7lD2blq13lcjBWRwix0QI6jJcmX66rl27Np5ZHtfAMzqq1i0ZPkZD8GvQRC
         eoWg/5pEMtGf4tNfbPK4Lhl5mfhoz6SlUU4vqYrMkF3oG2UHWR28PZ4odWiES/QGBuMb
         LloW2LdjRBVDzdTF4sBlzWng7IUx6IXOUgFSjvStS7sAUdxiramP31ZVuLAOKTsMyjrt
         fscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739228543; x=1739833343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f3RPwfSA1e5eBKwDy2dScoEFSvk94d+X9rymYjEPPw=;
        b=Mk6wFqLxhNJShKnqyfOFIBhwGZVT5wm+lL2S8FXs5vfh0xl+Re64gpMs51FJrHybsn
         qR7M+EXKb8EQTGUVb5uxN5A4IKGRwoXHAsckGA6zrOUbW5B3ZsdUnp1bM2owdAm36jn/
         mXmwNFjksUTQs/HJjr7KhhP18HsrdpHVsqb+PDYTE3zEBsYdUcFh5fRWcJ4ErBXvK+nH
         Hb4mcrWIqujA45bprYN6cvLSO3OG5I+7NKx4xSMOcHFuCEkUpUcclj+AKFZbCl9MABnU
         igvrEhBkwLJJd7DRCi0BcXaUdBoShC7CGaNFLWq3Fxnd+NMhwh+2c/063cscYTfyiTLH
         hzIw==
X-Forwarded-Encrypted: i=1; AJvYcCVXa97TOYXxsmaKeg8fNg10+tIBPI3oY16yMLCjA6hQd76wOIxATnCwDBLxR9YMiabE3BSEprA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxAn/T2m8rlR6Fda8OY1kjM/I+aSpmSAoUs/4odB/Mt2gI4lh
	aDyIt0V2e9AEWOobktr4JLyeyCJDexernm1JbhIV30FXeIl/G9mTQFCjnfiQyg==
X-Gm-Gg: ASbGncs8WuNJTfatQjIvmRFRMtqdRU3AuO7nCgUTLVUeJLoDVNgXwfwP5SGDBgDTYm/
	n8XhkIG+TKiMZbRSOxES6mHPE3jL94vhMM1NEv7/lxVPRa6IKQicb3EL3ONVseEkTH2UOvEP1Qg
	6NoEfArOuOM4eJMwVe8taCMHA8oZHvZDCLpqlGo4XEy4663S+T7OY4lzigR9FDOyr292jTV9uQd
	Tqjjad6O7SMAaWTJawRKc/zpLqRsOQk8PkhORx0QyXrPPmbcke+HmFlpXTNdGZmEyjf+1s0HbyX
	3StxLK3P9HFHGNkpFRDCXeH1rdtHe6dKGdJgcCVdtsuWQE6gudv4czeW+yxObm1RDhdl37sbqWf
	UswjOJk/NXH8=
X-Google-Smtp-Source: AGHT+IEzON8gBhYVw1w+QU6wxSLAM5KlmTQpmu2/n9ZYhrWUoHxKyS3zCZeDf3jaJy/UIfaYUlpNyA==
X-Received: by 2002:a17:903:41d2:b0:215:a028:4ed with SMTP id d9443c01a7336-21fb641d210mr17516885ad.20.1739228542783;
        Mon, 10 Feb 2025 15:02:22 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e14:7:85e1:17d8:711:faf4? ([2a00:79e0:2e14:7:85e1:17d8:711:faf4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa4d1220f2sm5260861a91.40.2025.02.10.15.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 15:02:22 -0800 (PST)
Message-ID: <5d504702-270f-4227-afd6-a41814c905e3@google.com>
Date: Mon, 10 Feb 2025 15:02:20 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap
 enters ERROR_RECOVERY
To: joswang <joswang1221@gmail.com>, heikki.krogerus@linux.intel.com,
 badhri@google.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>,
 stable@vger.kernel.org
References: <20250209071752.69530-1-joswang1221@gmail.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250209071752.69530-1-joswang1221@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/8/25 11:17 PM, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
>
> As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")，the PSSourceOffTimer is
> used by the Policy Engine in Dual-Role Power device that is currently
> acting as a Sink to timeout on a PS_RDY Message during a Power Role
> Swap sequence. This condition leads to a Hard Reset for USB Type-A and
> Type-B Plugs and Error Recovery for Type-C plugs and return to USB
> Default Operation.
>
> Therefore, after PSSourceOffTimer timeout, the tcpm state machine should
> switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also solve
> the test items in the USB power delivery compliance test:
> TEST.PD.PROT.SNK.12 PR_Swap – PSSourceOffTimer Timeout
>
> [1] https://usb.org/document-library/usb-power-delivery-compliance-test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip
>
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Jos Wang <joswang@lenovo.com>

Tested-by: Amit Sunil Dhamne <amitsd@google.com>


Regards,

Amit

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 47be450d2be3..6bf1a22c785a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
>   						       port->pps_data.active, 0);
>   		tcpm_set_charge(port, false);
> -		tcpm_set_state(port, hard_reset_state(port),
> -			       port->timings.ps_src_off_time);
> +		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
>   		break;
>   	case PR_SWAP_SNK_SRC_SOURCE_ON:
>   		tcpm_enable_auto_vbus_discharge(port, true);

