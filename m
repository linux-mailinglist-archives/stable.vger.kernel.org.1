Return-Path: <stable+bounces-217546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHLaEpIcmGnp/wIAu9opvQ
	(envelope-from <stable+bounces-217546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:34:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966F165B29
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512A9300DDCC
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D330E824;
	Fri, 20 Feb 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbRXnIlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C624169D
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576231; cv=none; b=AJ5daUIjjLqFpmm+S9g+p/Twz3PhWSPY9UFfflEeAYHfAQQ0GYvZ3fqRpIm4KV4YQmNgZ1os0TEOBJYzk09cmcBTVucgm/I9u2MLeZ/H7IJBme8Q4EMf7oGzb62+MoIv0CtUQOsVOFr4Qdw0DFXqUqHjvV3OqBLmrL3tqCEkcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576231; c=relaxed/simple;
	bh=+24v2V0R66T0uswD2ccmoBV/vUFaQyxXjZ7Xh38CFXg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q7yoo1Yc+DEro16JQcaNqBGdlWI0XdzTYKKDlqKeBAP0akeqXU4a6l1o/EhrjSxfKmlX7uyTZ96+kFcG2MK/3bAJ59wHGT/ih6U4YXRh2vwZNqcPQbQWX13cvClmRTeOp+isXza1kdG6MLyLBNyF7t8m2dhIkt5ZcfMjbwfYd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZbRXnIlf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43638a3330dso1499002f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 00:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771576228; x=1772181028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Qq3S+r4Rhk85CvydKyOggoRE+fgwt5wCw5yPrVvJwA=;
        b=ZbRXnIlfQAHsA/P6Yy78tDAWv68BIu3YetmJ3mkhAO0zrYmBZK0sNg+DWipQVqsNOH
         HisOm6zYIcS35V03fzzB6XRq957pPWkKp3KJ5isbRIoz4l2qWB+O9yQsfvGInsjNtQJI
         l/W/N4Fu0MulvtNf6Fc7f+2JSPvCTpVYDovH/y5phqS3Vkk/Wa7EKYB+ZmXzJT+cLTJT
         fzJRZ7UY6zS2iRWNiL8ieid31XiuHIppcMn+M5S+RW6PGAfrLgNQw8vNiipgjscuSEYQ
         sNV2WTScCfOrqM44Er3Emuo9SSnoxqu6AqZYsRG028RjQi1mzD8NOhlxfkaHmzsgWEo9
         YidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576228; x=1772181028;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Qq3S+r4Rhk85CvydKyOggoRE+fgwt5wCw5yPrVvJwA=;
        b=qauBC/n46rwOTt4bc7QchUVWDr37T/SN7av4zjK+IWklTiNKR3CfDhvd3+CqGDIViX
         SQGli8knscJ+SRo6jP6hSdWgH8UXt+0JOxfwXcBM5DuB/GwWdGHWfNgz5GHnW0Qi+0k9
         F+6JneO1b+RaLbVv26NY+BJFpA0FtURd7lOk1hdPF/r48gSa1jgxlH1C6kbgMizxWfB+
         KsOZt79eZlOKva8iF6JPZTxgpvPkEEN6lHZEpJiKjU9ZRhiIcyezKu5QfjoWS3HAPsya
         4Yrp8sf62jzrY59igDWnAoJ34W04BWlO1LxUregTiWstf2kYGx9oxh1nKaeIKq9mLY+q
         2xyg==
X-Forwarded-Encrypted: i=1; AJvYcCV4OaRySxVFm5+FB5XnSvZPhM37cCxlVDtOWamznhjcD5fZZVeW/PL2RvNy7iwskWFyQp8tWOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxb/KdJeo5ujRTNbxYFDJaIw/Wbo97XgS4EyBJwW/Kmy7oKrvO
	j7Y79sB/QAbJgHF3UihGFean+U+aqWmtm/ZVYxKgbnmZ0DlgMkOVcqepjaR1oTWWFMs=
X-Gm-Gg: AZuq6aKE2UwcV0bRKfpn2Uj5lNbLGlVg/Fh9TDBN9zaRDdJ+p8rd6SVuGxV2U+HxxdO
	fEGC8K56iL8SG/o8dvBLNlcF8xcVOZ1mKE5GFalR8yYVQkAwOeEvOwn/x7350HMpLvUTITlPC6U
	bKo9ZSppX/xJZLWW2MFXbwT6LeW3TDsFsCcpaRXTz21MQwYUKMC325E5bKpA+FzF/TSr3iNVB7U
	5JBhsuDX3h72jEUyb7/Xjw5oamlfoUBmBoag0m6gb295BqaUtOm+TWtlt6CyfBxwV2CIc9uo1DL
	JQdhM3ksIEdpvgqceJCyDS2rAVXHK1klqO9uRxkZei67/rMJMo783fnu0VVBIG6wKHiQedQKnjb
	lcuQRHCyGteYTEyhxSK58zv6QiMuOwD2XMWwUnRZHVwmyAknUwYrtfCnlMIYTqcwz0WxviOrJHk
	eAqiblctY7NCMx6e5diY5DlvAFH0WT1N4Vvz0qNOBqiJ4lZ6AWNrvozv7C8rQ4z0QUVVgrFISyQ
	kWQ7q/yJiGgRsqB
X-Received: by 2002:a05:6000:22c9:b0:436:1989:a1ba with SMTP id ffacd0b85a97d-4379db31007mr40196308f8f.10.1771576227964;
        Fri, 20 Feb 2026 00:30:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:5499:ba16:213c:9028? ([2a01:e0a:106d:1080:5499:ba16:213c:9028])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm53586490f8f.22.2026.02.20.00.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 00:30:27 -0800 (PST)
Message-ID: <c19858cb-9cbe-4ece-b8e5-93453a3ba932@linaro.org>
Date: Fri, 20 Feb 2026 09:30:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Nitin Rawat <nitin.rawat@oss.qualcomm.com>
References: <20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-v1-1-f136505b57f6@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-v1-1-f136505b57f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217546-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:replyto,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9966F165B29
X-Rspamd-Action: no action

On 2/19/26 12:11, Abel Vesa wrote:
> According to internal documentation, on SM8650, when the PHY is configured
> in Gear 4, the QPHY_V6_PCS_UFS_PLL_CNTL register needs to have the same
> value as for Gear 5.
> 
> At the moment, there is no board that comes with a UFS 3.x device, so
> this issue doesn't show up, but with the new Eliza SoC, which uses the
> same init sequence as SM8650, on the MTP board, the link startup fails
> with the current Gear 4 PCS table.
> 
> So fix that by moving the entry into the PCS generic table instead,
> while keeping the value from Gear 5 configuration.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: b9251e64a96f ("phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5")
> Suggested-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index df138a5442eb..771bc7c2ab50 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -990,6 +990,7 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_pcs[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PCS_CTRL1, 0xc1),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4, 0x0e),
> @@ -999,13 +1000,11 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_pcs[] = {
>   };
>   
>   static const struct qmp_phy_init_tbl sm8650_ufsphy_g4_pcs[] = {
> -	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x13),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>   };
>   
>   static const struct qmp_phy_init_tbl sm8650_ufsphy_g5_pcs[] = {
> -	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x05),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x05),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4d),
> 
> ---
> base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
> change-id: 20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-9d1adf1508fb
> 
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks,
Neil

