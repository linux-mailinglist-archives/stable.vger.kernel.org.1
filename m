Return-Path: <stable+bounces-242498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GH2E3j+9GkiHAIAu9opvQ
	(envelope-from <stable+bounces-242498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:26:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E132A4AF243
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC40301588F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC14218BD;
	Fri,  1 May 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPAaRvsg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28D41C317
	for <stable@vger.kernel.org>; Fri,  1 May 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663599; cv=none; b=bBIWLRHxrun/LvzTq/PH/YWElj+r637heacRX2Hdaerqq0Ad7uwZ/hNjaa5w7aBTWlaTUgKdovOd5WbcN6+IQh5ZaDyZ68TgK92jVLIrE5r1vU1lhfOu4y2YnCn8L7U4c8cxKsfn8IShxvvyVyyqroXdTbf4Rz5WMwvLpBoIvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663599; c=relaxed/simple;
	bh=HVuL/IZWSvdhZZkkQXpKjZZJIBtOavjaVaByvGXjaNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F62F2C9x9FvYtQqWHExYSAbHvhXXsFl8eFm4pvI7iMhAKppR3ABob2Vr+aTd22bmcI0HFTd8vNkYWUAxm3UXJTduDqfnGG4/W3rzJZ3UB1Kq4/tQ9V9g0ad/N/yzhZhSXA0hAWMxBBPgDensYbu9v5II5NrWF9xSERnyQIG1DMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPAaRvsg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso15248405e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777663595; x=1778268395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KV4kSIiY3A3IMB/1Fwk7IrL1FCT6zTF9wEUbB3puRYM=;
        b=JPAaRvsgOtvGbrYyebgx78TvF8ih67ZpLcmLCmJWdopIkeqsKViuOKqY0nbQSks19V
         slY93ogWrYgxQuYMgfAKxbWgC2WtfOfVxxxkQyeqKTqwTF7h9qGXrN8o+y/Q6crpfq7c
         Ubd90S49aCVaDv9OhhMUfMaoypeNSv2KmUAJUfSpK4sj90pR7+vGz6DSzCQd1px9pAdw
         RdNlN1G0M1MUX8UayEslQH7ec6h3A+OgKWV8zuQ+FZWFMuZUnXFl1VnKDmxAMyPp2stf
         1MkVoENA19u54FylkFVTqadnws64kewGdLEcWXFnyU5aeLrAK16zE4CDiEBjaoyETfL4
         WZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777663595; x=1778268395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV4kSIiY3A3IMB/1Fwk7IrL1FCT6zTF9wEUbB3puRYM=;
        b=bAOD76QDnG8maf4T/J88NcyklyRaxwtGGAJre3keiVDBhjq3juRk94QVCEr9R5CqsI
         JCxqDHi2e9n5DxI5w8kIgORYVFURyariTKVilNLa6zSUpeq2iifhGmwH9K8D1uW0IHkT
         RhAgoPqWomV2Vfjnoh45ZTf/ZNuo9ZlEAnnhL2s3XUzOSXFz64qj0o4VNVsWNWcdTTW7
         5SXe/jEpdo/sUj0jgMkdgI9n0oaMFShESfGgze4LeJE+AHZgUkPh+NU/X2dpiAARA2Fs
         wXSAtf1XJd8DCjyD0H1Y3zhc0fcwRGUAqu3oOfI7F3CVAFFIZJeZKa8KXUKn2oaMkBKP
         vHxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/y78l7kxGMNYuCVz/P1cDbbK2Ju3goEfHTftydYdegiUpzBO6BVC9KR5XMDs9SxfwvYpZElwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1Ep/wb+JKfhxgnVxOx4HfYVnBm6EMgn5xHCkZDd5rn6zA0ZQ
	wu+Jo+qGyw2s+O43i29Cu4oy2Zee4OePGWq7dJixfL+pmHmnoN7QqBr9
X-Gm-Gg: AeBDieuIHBC+kIBe6EOqyKGBa0kza70GbiApt9nKkNkIYmBi1z1yJL3z5UwrdDhKR0p
	PlY/u+tWgUfryYmOV5c2fc74QbvDgWQ5Nbf3T+6qdRo07gKlQgKRtrFghmDdi7aXAkKpsSMbF2S
	iwAWWkZV4ZlCcuhmot3Rngpzv923P8+AVMtRlf7m1OGDwxFhJovVuSuquEsOxtHQk6HZAeuDiIm
	NPauRGXj+xegg7D0IHGurjf5Q2iID1HoG+mIM8y6H1xtDVfiK6VYv9FrAzG2QbaWRjOOeDhYN11
	hLM4h+JrOEF2AwmdOGEPmDsc3nIrsXDgTMWpwV9vou9jYfuaoM7bvcO7despH5J+yviXBMpm9ml
	F5sPM3o+tJNlLJhNlHgA0UE2vL7AC9b30lTH0O5GXURBY23cXqCQB1A3ExzlCOAQrbuwyXhcXxY
	grHeIC/Q+oDTjNMv/LLCsb/VFTvW71HfIYmxxcpp35rePNQALKlSE=
X-Received: by 2002:a05:600c:698d:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48a9866e8a5mr6571995e9.24.1777663594868;
        Fri, 01 May 2026 12:26:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm171686915e9.14.2026.05.01.12.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 12:26:34 -0700 (PDT)
Message-ID: <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
Date: Fri, 1 May 2026 22:26:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: increase TX report timeout to fix race
 condition
To: luka.gejak@linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
 Brian Norris <briannorris@chromium.org>,
 Stanislaw Gruszka <sgruszka@redhat.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260501150402.227788-1-luka.gejak@linux.dev>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260501150402.227788-1-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E132A4AF243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-242498-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 01/05/2026 18:04, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> The driver expects the firmware to report TX status within 500ms.
> However, a race condition exists when the hardware is under heavy TX
> load and is simultaneously interrupted by background scans or
> power-saving state transitions. During these events, the firmware may
> go off-channel for longer than 500ms, delaying the TX reports.
> 

But power saving state transitions should not happen during heavy TX load.

> When this happens, the purge timer fires prematurely, dropping the
> tracking skbs from the queue and spamming the kernel log with:
> "failed to get tx report from firmware". Dropping these tracking skbs
> prevents the driver from reporting TX status back to mac80211, which
> breaks rate control accounting and degrades performance.
> 

But mac80211 doesn't handle rate control for these chips. How much does
performance degrade?

> Increase RTW_TX_PROBE_TIMEOUT to 2500ms. This timeout is large enough
> to comfortably accommodate the duration of full WiFi background scans
> and sleep transitions without incorrectly tripping the purge timer,
> while still eventually catching true firmware lockups.
> 

rtw88 supports many chips. Which one are you using?

Perhaps provide a full description of the problem you encountered.

> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  drivers/net/wireless/realtek/rtw88/tx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
> index d34cdeca16f1..95d15e4f5d34 100644
> --- a/drivers/net/wireless/realtek/rtw88/tx.h
> +++ b/drivers/net/wireless/realtek/rtw88/tx.h
> @@ -7,7 +7,7 @@
>  
>  #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
>  
> -#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
> +#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(2500)
>  
>  struct rtw_tx_desc {
>  	__le32 w0;


