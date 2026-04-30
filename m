Return-Path: <stable+bounces-242026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB2PG4n68mnxwAEAu9opvQ
	(envelope-from <stable+bounces-242026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:45:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366649E337
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95FF8300D351
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9623783C4;
	Thu, 30 Apr 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ab9JEHLX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnofuSq2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668435B136
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531522; cv=none; b=saPRGbnYWxiNYmEBSQgAuzjKJAr1lJ3h9U+CZDNbNGg+/1IehgA3s+TyMrDbyIUvFP1EgKrQguDgvKquHJJqNIuq9J/W5Qh36Eg1LH5Hldbkou7zGT2jHBV1Jg47aAE79ivg/3XFD8Hl6tpMVJyRHgQYrpP4Ns9e9MrWZgSUZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531522; c=relaxed/simple;
	bh=9SCXbzviY6OXspooHF0q4LaAr+4xBTp28S9n+XC3BU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdFxk50rreyLVQ8aMrIjynrXZUetcS/B7QHsbWIRJymffcC45i/LaBck8XnbUrC4B+csHcFGUVNmE8Br+V+wjyVzGzM3XBwQVj5jVxieD69wAdTc+ijIIBXaSiU6WzcyIGUCKurGejyBZa3ZvXNsov+QjLEzhVUIn6wht8/X+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ab9JEHLX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnofuSq2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U6Ahfn2533827
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9GCqJLduvd/1QTWe87UsZI1ikcjTcDiUgafH+NTT2m8=; b=Ab9JEHLXMRjzdwXp
	XxifaZW3IFGwZ4aIZxhPwzwIbH//rxzJmRE2kiVG9HstjIdOzkP20RV796HraJOH
	u0DwMR1T53DIi/b2WMWMNCvYlCnYiq/ORzqxj5fpj3IdFizPpvNX3gw//wNA9pXa
	1Gt+TxV5KqdVAGgJFrif9qfItQR/U332H0UeYoZNoFT3avPWpNFf7Jj6znV7bSrA
	xPRVmZqUb1asTzfLCxcQIC9tkWHAgGhdS1ZdCxAZe5Bom8jboc81K6MI0eSohTGd
	vG1e7TZBJ2zX/eqYsAfgQ4HHk0ao6hLUQ7BP3moKCmNLY//as7l2ojeK3BRa4Wo6
	anwp1Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe92bw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:45:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso282749a12.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777531519; x=1778136319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GCqJLduvd/1QTWe87UsZI1ikcjTcDiUgafH+NTT2m8=;
        b=VnofuSq2gP6FYWQSzbLiCWBK6wlGDrThOeS9CkI6WTgdLSS98f50PE8FrICtQ9U6CB
         Kb7I8LEWKXXRMDKPFudHHIi1wYlpPlDE5CjMS82/ZZqpFYrKHGJ6BxgwXciJ/XnSQFWN
         pU8rYt+cus6fQJF3wKaPZ46GMw0rM3m80/0cl04V5sktKUV1200v6FWltvXQTm18kwAw
         +SF1xGolJGrWxeIqMHOlatqZgze+lEYqlkCDW4FRWzdwqtMxtOlmK7bnEiOeQJer7XTH
         gg+a2V+LnzCNqqMjt6u+oU3nRkkzBK1akQ5r87/h0qFLHqa9mDh359AnyVZY6D8YYlSu
         JG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777531519; x=1778136319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GCqJLduvd/1QTWe87UsZI1ikcjTcDiUgafH+NTT2m8=;
        b=b9bNGgqiy28ImvxSXBDBWbHdIBhuwCba3F0yFQ4T5ourYjtZfSxnUrzzTQlYAQah79
         GuinL2W93FiaJV+l+1AEim0+n58NX4CgzMUpIB9+bocmx2YnQfpw7zcD1lFlSlu2bXnw
         IXkLAObl+jpmWX8kUTInBzilNsP87bDHXg3yiGBTSVmilnT4G/8hmhmnTTU0iTScemI/
         pOjxCSpKZndkeVuUtPmI5G/h/DcP1BbkLu7QC0FQfDVgDqNWNSNXAFe/pntnWrM6kEh9
         S8NXt70zN7PuhQbFRi5aNlObxEcN68U8BWnn0UECWjlZ4YRxArEPvwcZZjceOrI2YI3G
         /7NQ==
X-Forwarded-Encrypted: i=1; AFNElJ81qwV6xppdh9IkxnWqJGI1N3qH56AmSswHg9SJNAhr5n9jr1yPQAi/oCan5j5UqV8BTq3Ipjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj3ktM3pH37+koqx3Cd564TIRLFG23epbyKafX7WcDPczoXqQ
	QE6MXZbfhtG+/gXsd5MFYUQ7Hzo7TlDvkMzNU4RcIZigNPO5xtdrQAKqgqM3TRIA/gZbdVHohDF
	TkBYs0ujBh14OjySzLhhL8mwi3MteUSYrOWU1u2JF5jycj8DihC+1/Vf+mDc=
X-Gm-Gg: AeBDieuOjZ6wVickGJN28K6AOUsrivrfWM9V/tl4ruHs4agogq+OvRKW0vlmNxH0P+E
	uDB1sDtODX4x3ggFgderR8SJEtGtGA0+KGdjbXnpEQxUWKz/Lxc9ZRyp9sa1A+/IIe0m5vnhwch
	31u5OqljkFcW2lAj+5uSvPbbTF7l8ya3cu8OyHBMPHfEsGFApdLuUzeHfc9TM55dbDisGUAicUQ
	/WdHaWQfQ79LeJ+kNTVJ+pg69d/5fsRNsY2SQF4WiP/UK7X7JFGHCOdwfUetUzSuhB/EP/8cBjw
	EOKMzmTvpPg6miuY8RRVqZ71ilX4A/484kdIVrU1FSAddysErROYmTc+C5NRZy/8iE6jXEG4Z7u
	9rKnTPy7pEC0c3cmjhTr0QN7IHGCbGdei3buRj7LgZAh9o74iH+6nC9LbmKbN5A==
X-Received: by 2002:a05:6a20:a120:b0:3a2:d79c:4161 with SMTP id adf61e73a8af0-3a3cf86fe19mr1867956637.47.1777531517759;
        Wed, 29 Apr 2026 23:45:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:a120:b0:3a2:d79c:4161 with SMTP id adf61e73a8af0-3a3cf86fe19mr1867919637.47.1777531517182;
        Wed, 29 Apr 2026 23:45:17 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5ccb1fsm4173594b3a.17.2026.04.29.23.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 23:45:16 -0700 (PDT)
Message-ID: <e8c670d6-97f2-40a4-8e7e-9b7857b60ad7@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 12:15:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TkLFbKPNtNUdlqAX6wLtigLxbPVDyYiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA2NCBTYWx0ZWRfX4AhYsbSFWRni
 Rvc5aWnSg/chqhaWbUSIGR6YrHQ6ZHW9iia8R47u1WFdrRJGDO2+WlLm0B4kICSo7m5yzaLVeys
 y7gHjT/qPCqxa1Upl8pk0BRQ7d6az6T+0834npHCn+2Zqzoe8gp1XjYluW7jQcyBgQrW470JWoi
 2ai6Fd0WbqlOQ6+hK6QW6QG4GOuLpMCT4/jFnmn5k5unlApp2+5OpaNGsVKmyT4E1ALB0jiU1r8
 eIgdBpVy0bIEDDs4kcBCIE/rrrYvEUW/0KjBFXisHU9uhBu2Zn9JngxZxz96ejSUu1HqhtiMY5W
 WbpMabtByzq9szeimWTCEClsc2p747B+jH1EyAxWHvqD8LoKptl+eaEnPXZFeuYpEYr2lGNXWpx
 2SNBRRxgz8R+jSaBh6DpKIulK18fPGVFkIcycU4TeVATrTeioA9Cg69gzn0FHyfZQRaQVNg6JPQ
 0sFay/FEHRhy5z0HfqQ==
X-Proofpoint-ORIG-GUID: TkLFbKPNtNUdlqAX6wLtigLxbPVDyYiV
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f2fa7f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gK-aurLV-Wj7dvaEeU8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300064
X-Rspamd-Queue-Id: 1366649E337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242026-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[maulik.shah@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/30/2026 11:24 AM, Sneh Mankad wrote:
> The wakeup enable bit needs to be set irrespective of the SoC using PDC or
> MPM as wakeup capable irqchip to allow the GPIO interrupts to be forwarded
> to parent irqchip.
> 
> This is set only for PDC irqchip using additional check skip_wake_irqs
> making it impossible for MPM irqchip to detect the GPIO interrupt during
> SoC low power mode since for MPM irqchip the skip_wake_irqs is always
> false.
> 
> Remove skip_wake_irqs condition when setting wakeup enable bit to allow
> forwarding GPIO interrupts for SoCs using MPM irqchip too.
> 
> Fixes: 76b446f5b86e ("pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits")
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 45b3a2763eb85405fecdd4770ba3d4ab684563f0..96df8eb8f5d3f3bcfe165ac02a07414e491f1178 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1247,7 +1247,7 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>  	 * While the name implies only the wakeup event, it's also required for
>  	 * the interrupt event.
>  	 */


Pasting full comment from driver, since this is not visible in the diff.

       /*
         * If the wakeup_enable bit is present and marked as available for the
         * requested GPIO, it should be enabled when the GPIO is marked as
         * wake irq in order to allow the interrupt event to be transfered to
         * the PDC HW.
         * While the name implies only the wakeup event, it's also required for
         * the interrupt event.
         */

Can you update in the above comment also to mention both PDC and MPM HW.
While touching this comment, please also correct spelling typo for transfered.

"transferred to the PDC/MPM HW."

Post this update,

Reviewed-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Thanks,
Maulik

> -	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
> +	if (g->intr_wakeup_present_bit) {
>  		u32 intr_cfg;
>  
>  		raw_spin_lock_irqsave(&pctrl->lock, flags);
> @@ -1275,7 +1275,7 @@ static void msm_gpio_irq_relres(struct irq_data *d)
>  	unsigned long flags;
>  
>  	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
> -	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
> +	if (g->intr_wakeup_present_bit) {
>  		u32 intr_cfg;
>  
>  		raw_spin_lock_irqsave(&pctrl->lock, flags);
> 
> ---
> base-commit: b4e07588e743c989499ca24d49e752c074924a9a
> change-id: 20260430-enable_wakeup_capable_gpios-cb9439ae8772
> 
> Best regards,


