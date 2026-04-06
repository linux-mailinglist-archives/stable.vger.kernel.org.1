Return-Path: <stable+bounces-233454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AWjIaY21GkNsQcAu9opvQ
	(envelope-from <stable+bounces-233454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:41:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCC3A7E6A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D243046987
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EDA39E6EB;
	Mon,  6 Apr 2026 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P56FrZx/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA17392C5D
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515292; cv=none; b=tvSHVen15Mr6Ah4vMC+DSfesKCDN68kxsaDi/pQq0zAFxGSvRel26Vgb317JhfNjar6EHA24bWdNjL8K+SMnuPU4joNSaGfEvMIWppFbMVBQtc45HRcRMkighhAsSln5jrPU08eBOXQMkQ3T05T4ki9TyTBkhfM0Ks1M98dRhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515292; c=relaxed/simple;
	bh=rq3AU77WzvBFXo+3+0Fp5PwIFd7YUbJZ6A/QINchdfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkqsyF8wJi++kZn+wszB3OIN745cQlZb/u4tDk6PELO4lvBTU6tYnryWYd6U7sG0rgPWYWEykTgDEnB4FYcgD4P7y2IlXvG/YFlqWIMVrxd5z7IQ7jf+SUas11aIWGs+LuPIm/9XaeM+FLcuZAvlTNOHuZBzHZLqz1A1wA3/F+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P56FrZx/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38df0a031daso2567061fa.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775515289; x=1776120089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6xY5R4cNcV4g8oF6JwJO4h1zpXLceVm3FoP5Twk7Qo=;
        b=P56FrZx/GdYgpvN6O+oFAqrAdrJ0BaKrBkV0/ClXdenRzQFp3six4esYcnVEE288pQ
         gCeOpW9QTnwUBS5dVGVRI/KpJac9jn8vwxP0ENVvJnkUv9cGBO3w6DaDLFrkUAYdy/8T
         aw8F/SlAmeGTS5yODIQJcFzsUa6oezk7SGUHC9UkSUZ1gpmh40TTjkVE/Tql00ZcWqj5
         o4Oo3Bjsv8dCIt3/fHnCI1LGpTGLd8EYSD1oJQGA5peDFMRC5H8IreEYHm6Q7k8zlVTm
         yYGp6EcqfoCFnUfN9c3bMPjOT0bZdlo3i+THKRZUepw+PNQ64rx96+FAqkZjlH194KGp
         beyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775515289; x=1776120089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6xY5R4cNcV4g8oF6JwJO4h1zpXLceVm3FoP5Twk7Qo=;
        b=Tg4hriXTtJU2+aXy5EHs8q78QCaa3fjW2+nPJn3OE+xQegc4MYMInWB8Mp2d30HukP
         60TCIATzJQagD9jXJp12L8+CGccTBXf3D9mlN6TAU+Igzdt8/e9ftkr7/fkeInFtS+wa
         Go9uAcPJgv8MAHmjJNUCXESrorH7QB+Q6VawZWQai/5ac5h3yNd63AQjEq65sjIzEKfd
         BVhVtLcgp0EmV5le0SbklhCBVvA6KMs2BwJi73U5KiR8+NhOMKss34Q+1vdYCfBOzDPY
         qXQjsLEtUQdq7Z9MJK6PZz2t9C1l3QeeRN/SVOzkXh1crUONBs0GN/+DkVeOPzzBhAbG
         ZmCw==
X-Forwarded-Encrypted: i=1; AJvYcCW+/Q/BkR/Ub6izjzwLTKcf+dtgYfVqFnnaBe3QXDuyykzThJlx9VwnJlu+06OVIHk0C9khmhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30fBZTgosAE9DpyeNR40hM86DqJT3F7YOBvFV4H/bQUAADXAt
	YxlrmT56sNKAMOHBVWoyUxa0Y4waUuXitL6Rdu+3gdsUV4gkojkJITTeI6E2pedPNxU=
X-Gm-Gg: AeBDievuIZpeuH8YHxVGJOGulUowFiQNZdgm+qlgURkephzsGRSm+Z0Q/FYKOY0upw6
	hM5bA0PlPctFuefMkM20fmLv4uuLmOvNPQDrE2z14nrvOaTspbnWwTtT+/buuTI2TLnx9m5wY0V
	wqTcBq9JBMoKFzfBRbVmec1s2tYZLPXdBC+BeZN2UHau7iAweekinnUYVJsbtBJBxrNyoMqOz3b
	mU1C4XUfBMXXub2SI2UAb6VxUFwAGQX5ZwzyxuOXLDplNbOCtXbTNSHfO7f/uHW897Cb9aHeO+9
	h7Kz3+aj66pA1gXwrvLWHP/yneX7Cqa7vyfaItAjKjg6eYCoWT3vyywQq21tIZu99BJWHyFvVyK
	dSCoVs4/oLvbflHnbrx3SYqWSokroFzgYB6kOOsLwad0ZfwgFunih97BF5XWeWaiFGfeRX2OfIA
	vnUdQyXoDTQ6yiQtpnT6vUpP3yG8xwHzFq9TCug76nLeIb1d3BMtaeq4oqyFhBx8eODm25b/wQ9
	ZbR0w==
X-Received: by 2002:a05:6512:39c7:b0:5a2:bc5c:f421 with SMTP id 2adb3069b0e04-5a337596dddmr2971851e87.8.1775515288463;
        Mon, 06 Apr 2026 15:41:28 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cd3509sm3676707e87.75.2026.04.06.15.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 15:41:28 -0700 (PDT)
Message-ID: <7b349fdc-7a78-4c17-a8ae-2729bc704186@linaro.org>
Date: Tue, 7 Apr 2026 01:41:18 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] media: qcom: camss: Fix RDI streaming for CSID 680
To: bod@kernel.org, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
 Milen Mitkov <quic_mmitkov@quicinc.com>,
 Depeng Shao <quic_depengs@quicinc.com>, Yongsheng Li <quic_yon@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260406-camss-rdi-fix-v1-0-d3f8b12473d0@kernel.org>
 <20260406-camss-rdi-fix-v1-1-d3f8b12473d0@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260406-camss-rdi-fix-v1-1-d3f8b12473d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233454-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.zapolskiy@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24DCC3A7E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 00:55, bod@kernel.org wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Fix streaming to RDI1 and RDI2. csid->phy.en_vc contains a bitmask of
> enabled CSID ports not virtual channels.
> 
> We cycle through the number of available CSID ports and test this value
> against the vc_en bitmask.
> 
> We then use the passed value both as an index to the port configuration
> macros and as a virtual channel index.
> 
> This is a very broken pattern. Reviewing the initial introduction of VC
> support it states that you can only map one CSID to one VFE. This is true
> however each CSID has multiple sources which can sink inside of the VFE -
> for example there is a "pixel" path for bayer stats which sources @
> CSID(x):3 and sinks on VFE(x):pix.
> 
> That is CSID port # 3 should drive VFE port #3. With our current setup only
> a sensor which drives virtual channel number #3 could possibly enable that
> setup.
> 
> This is deeply wrong the virtual channel has no relevance to hooking CSID
> to VFE, a fact that is proven after this patch is applied allowing
> RDI0,RDI1 and RDI2 to function with VC0 whereas before only RDI1 worked.
> 
> Default the VC back to zero. A follow on series will implement subdev
> streams to actually enable VCs without breaking CSID source to VFE sink.
> 
> Fixes: 253314b20408 ("media: qcom: camss: Add CSID 680 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/media/platform/qcom/camss/camss-csid-680.c | 26 +++++++++++-----------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-680.c b/drivers/media/platform/qcom/camss/camss-csid-680.c
> index 3ad3a174bcfb8..35a6bb209f97c 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-680.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-680.c
> @@ -219,9 +219,9 @@ static void __csid_configure_top(struct csid_device *csid)
>   	    CSID_TOP_IO_PATH_CFG0(csid->id));
>   }
>   
> -static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
> +static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 port, u8 vc)
>   {
> -	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
> +	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + port];
>   	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
>   								   csid->res->formats->nformats,
>   								   input_format->code);
> @@ -240,21 +240,21 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
>   	 * the four least significant bits of the five bit VC
>   	 * bitfield to generate an internal CID value.
>   	 *
> -	 * CSID_RDI_CFG0(vc)
> +	 * CSID_RDI_CFG0(port)
>   	 * DT_ID : 28:27
>   	 * VC    : 26:22
>   	 * DT    : 21:16
>   	 *
>   	 * CID   : VC 3:0 << 2 | DT_ID 1:0
>   	 */
> -	dt_id = vc & 0x03;
> +	dt_id = port & 0x03;
>   
>   	/* note: for non-RDI path, this should be format->decode_format */
>   	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
>   	val |= format->data_type << RDI_CFG0_DATA_TYPE;
>   	val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
>   	val |= dt_id << RDI_CFG0_DT_ID;
> -	writel(val, csid->base + CSID_RDI_CFG0(vc));
> +	writel(val, csid->base + CSID_RDI_CFG0(port));
>   
>   	val = RDI_CFG1_TIMESTAMP_STB_FRAME;
>   	val |= RDI_CFG1_BYTE_CNTR_EN;
> @@ -265,23 +265,23 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
>   	val |= RDI_CFG1_CROP_V_EN;
>   	val |= RDI_CFG1_PACKING_MIPI;
>   
> -	writel(val, csid->base + CSID_RDI_CFG1(vc));
> +	writel(val, csid->base + CSID_RDI_CFG1(port));
>   
>   	val = 0;
> -	writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
> +	writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(port));
>   
>   	val = 1;
> -	writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
> +	writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(port));
>   
>   	val = 0;
> -	writel(val, csid->base + CSID_RDI_CTRL(vc));
> +	writel(val, csid->base + CSID_RDI_CTRL(port));
>   
> -	val = readl(csid->base + CSID_RDI_CFG0(vc));
> +	val = readl(csid->base + CSID_RDI_CFG0(port));
>   	if (enable)
>   		val |= RDI_CFG0_ENABLE;
>   	else
>   		val &= ~RDI_CFG0_ENABLE;
> -	writel(val, csid->base + CSID_RDI_CFG0(vc));
> +	writel(val, csid->base + CSID_RDI_CFG0(port));
>   }
>   
>   static void csid_configure_stream(struct csid_device *csid, u8 enable)
> @@ -293,8 +293,8 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
>          /* Loop through all enabled VCs and configure stream for each */

The comment should get an update as well, this is applicable and should be done
for the changes in camss-csid-680.c, camss-csid-gen2.c and camss-csid-gen3.c.

>   	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++) {
>   		if (csid->phy.en_vc & BIT(i)) {
> -			__csid_configure_rdi_stream(csid, enable, i);
> -			__csid_configure_rx(csid, &csid->phy, i);
> +			__csid_configure_rdi_stream(csid, enable, i, 0);
> +			__csid_configure_rx(csid, &csid->phy, 0);
>   			__csid_ctrl_rdi(csid, enable, i);
>   		}
>   	}
> 

-- 
Best wishes,
Vladimir

