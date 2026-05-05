Return-Path: <stable+bounces-244005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGTdLnei+WnR+QIAu9opvQ
	(envelope-from <stable+bounces-244005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:55:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119D4C8577
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF80302AD1C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1E3DD51A;
	Tue,  5 May 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kI4zKppA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYlTyktg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3313C1969
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967683; cv=none; b=PCNcNM1Q6ZaGuYFV8NalA9WoJDRiZiGP0rUIT5EKfYF+1/ZS2wGppJXqTjjBwa2rOWei4UT3Pwg9tq3osqEwPdDN4tqNVUsBFQ+2sOFHEhTCrPM26m2HVWc6TwJmt8h/35FXA4I6YHGcqWmyefpmmP/uiKnkTqfCqFKfFI6PmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967683; c=relaxed/simple;
	bh=maTmERrmr4R6czOYH0VPfmBrwakiLoJPBPiqZv8tXOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVhBsfKMHlD+Jw27bGZ27PvUjVSxBAgDuR+5pOAtzsSuHFPOEyc2B7Hy9EyBMzK8pLAqyrS4b1SvD7VCe8o6xvHlENU4HDAWX2oYoAFYQfeCQZc/kusD/Tn4NKUuO3EpFUgfE4Y0IzZ0XK+GcnASh9wHszY1JYSAY3Wb9+OJ4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kI4zKppA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYlTyktg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456m2273187946
	for <stable@vger.kernel.org>; Tue, 5 May 2026 07:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=; b=kI4zKppAKshgUTaE
	nHuuAYG+Wn4r8g/dWP1MGuuuOIt50LGit1mGonmoCF3/zXDyQYQgcvWqTf9MrKBN
	/GTQiLmPj+4enFp3CVxBpgllBIomuzdkvL1pgTkZtpf14kh19QDZW6/bU0lpsSwM
	IMASotFVncnNiUSF90EQHadf1ThForjHA47yZc6+yaMaiwg7lY/m/Eu7mG9b4l6X
	XDBJNSYO4+07vX97LQstreWOC5TQSwFyn3AYW9rMApL+63mzRhaFzO47qH1fYhcG
	tVWtyYGamh8RouuXPNkZD9XTEMzJN0+RtOayvsdFiTVeGm5UPORHIa/9ROBfoPNs
	AdxHEQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk86tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 05 May 2026 07:54:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da31af14cso126953701cf.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777967681; x=1778572481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=;
        b=PYlTyktg0unOcnBBjnj1zv1PPbdZWINccUEflf8JnSxMYTxXO7erAJDArRvYtK47w8
         OulnhTByFUjTT+39WiVcolosrCqTIXp8HeUZkA7cIdt8HnJttnc2QAlk0gcRU7+QTBJu
         ZXTb9A6Pi85k0EYer2Hu5u1ooeFY2gYL5hR6xEiAyh7T8hqlu9vPUmFLcarfC6HoqQtE
         3OO88gHeFTIVnmluYTKYk9G3gKNBsCyPDtDG81FO+Ly6uyLE4cQl4M/uSXatnzj/s04f
         4oUFxyJtmiqAH1mDicyOpqSrmOr4icgv3H0KuVh7qRGDEtQSB7yeZYgZ+J8IAQKM05EE
         jE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967681; x=1778572481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=;
        b=RGtQeRHFvSrIaNY0FSkp/deT2YpXvl/nhwR8WJaNhgKqywdIYYg44/fTdRWGLrreWm
         YH+shHSId5b7DIOKCjahm7IVLyWnv6oUhMpDi95Jcp9QIdISdpA5KqKOviJiaOs91rdj
         jr99OfgxGA7O3D0NoDYT5IiF0TrZfw9FyrpOELNhOTKNcs2cYY0KHY0ZzRqXrpZcTSjv
         5W7NvT4MncDHAfg3CAXIO9NMIoF/fKSR+pwM58RrdOqGs1Cypf9435D7DMzTa/5C548f
         zwyMzR8nvT7Bip8f5t4IuN3KwRTpAu6aKLgnDMc+MD04+IAq/yFZCfBPp1e8PCI3w9Qf
         3/qQ==
X-Gm-Message-State: AOJu0YzqpIfZqqvfoKdeboWI+DwRR5lnqIMumL1CDFsMqEDM8VWJVgdk
	rDFX9/+jy00vQO/W9RjxxcgNZG4qp8Pn4c8t6xJpSmWLFINppRgO76CqddLysP9P8ygsFNBvmEE
	qx2aH7Del4ypOkj3Dlnby58Nu3V3p7llx166rJTZSIer4WlgMtaEvTTPFAgA=
X-Gm-Gg: AeBDieuV2e/p9H3084tpbayb81tpgcmU2bQfbIr5cw9cYUr4e4StujmYyeDwjaSxNvb
	B5n+F2oajXFAsIPbVYKnD3MVB0ThefB9eJd/EO8bimDWGspDhwJsxnpzJInq8qNsdGKzK5ugfrR
	qHBGNDDH/jb/7Im3H6zTOIpo07JHdo3iFqY26JSD8T+CnUjrVr1gNcUxrBWE2k7ehCZraEe80xf
	fRfm9slditTZwPM8CbDd1J4sTAuHAk6r5Xa5NJRfcg7qbWLIVm/zn1j8W3FH87TC45cfxFiVGA8
	ZEk5ANLR3cgZsiLOxGFjsOGX5tcKLtEGuObdUecOKfIX06XXlFzCatbI2oB8XtA8KLPdTdRhhc3
	guRkX54Pit8msyokCdfL1z7r1CqBzVs40U430sRW1Dc1pRKwVTA76EG6i84RQrQYDzqy23YWvdA
	W1ZVpOF/DbBtXHIVxh
X-Received: by 2002:a05:622a:295:b0:50e:feee:76c3 with SMTP id d75a77b69052e-5104be22870mr189158351cf.18.1777967680805;
        Tue, 05 May 2026 00:54:40 -0700 (PDT)
X-Received: by 2002:a05:622a:295:b0:50e:feee:76c3 with SMTP id d75a77b69052e-5104be22870mr189158181cf.18.1777967680329;
        Tue, 05 May 2026 00:54:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm2733025f8f.31.2026.05.05.00.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:54:39 -0700 (PDT)
Message-ID: <c22b2fc2-c10e-4afd-ad9c-bc43df820655@oss.qualcomm.com>
Date: Tue, 5 May 2026 09:54:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: s32g_wdt: remove incorrect options in
 watchdog_info struct
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc: stable@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20260505024409.60301-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260505024409.60301-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3MiBTYWx0ZWRfX4g8DcAPvmUzn
 7r6cM1m3JYabsZY9sCXEMlCMamF+bLN7vVS6fa7cVnQRX8r6RVaR4ZQH4qgRL12vkfgmsaEO4Ux
 pXtuCnMhjPuYkgtOQqUm5dHXyRFcPw2FEMCu08lHIxvrFLCG4JVekW2ImvuQWJrGbiQc+wQ1wPT
 TZs/9bHuD2tcFx6gibiwImH7b5O3SPhZ1ueMmeUxlYqNXJUrPYgBEohTKDT8KQueRnBVgHwKDhj
 EeK5ujHLYwJtKckEa19tBf+ksD/9VQwnjIMTxENL9fTD9KM9oQ4ZKi15TtQzLhCRRaw8I1+P0VQ
 d/irRasqB7vneaEpgYIZwlSkHUKAW7yhcDJTGzz7091twpJv4IXuMktUlFVK8eVZI7gDGbbXUd7
 RQmo4FCd5sM5HqvJxiXgarYqDzsG653+dBsuluCHzdn4KpgkpMHxMwrI84HaBBNPzaGDq2LTKp/
 w9DSnVphlGYQJAdtWiA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9a241 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sjASDcFfOvue4x0fWBMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Hovj1VTWpd1hTOfo1GgFmM1XZMOBndgW
X-Proofpoint-ORIG-GUID: Hovj1VTWpd1hTOfo1GgFmM1XZMOBndgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050072
X-Rspamd-Queue-Id: 5119D4C8577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/26 04:44, Ethan Nelson-Moore wrote:
> The s32g_wdt driver uses two incorrect constants in the options field
> of its watchdog_info struct. This bit mask should contain WDIOF_*
> constants, but the driver uses two WDIOC_* ioctl constants (in addition
> to correct WDIOF_* constants). This causes many incorrect bits to be
> set in the bit mask. The functionality indicated by these ioctl
> constants is supported by all drivers using the watchdog framework, so
> this patch simply removes them.
> 
> Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---


Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>


