Return-Path: <stable+bounces-254074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD0iDr7eE2p7GwcAu9opvQ
	(envelope-from <stable+bounces-254074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AF5C5E81
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 115B9300D14E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C83344DBE;
	Mon, 25 May 2026 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mrnidYhy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q35npw43"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391033F383
	for <stable@vger.kernel.org>; Mon, 25 May 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687090; cv=none; b=hw0UUPtG3DmAUUwanKUrx7I2ymoC9XMP0RIkRAcYm8bS0NKrqxglEwGhBoBIKPAnornSwbvMbYedtK7ZaZDD2FffNP2n/YYGg71aKlQ08lOv4bMaEeZl1v62D0KXrwImKrOStRJ6etGaGVOqq+6D4CH3UzOxaBFloUDi6SWeXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687090; c=relaxed/simple;
	bh=ng0GzwL+SXuNmFa5pHkWjm1uNpGAuR1QWsTTWpgOp4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrrzyvVSpo6/kL1WRGgDvkIZsk41w6h7PsVReK8ErZag6IT3ehNNVjXnnNGYlSct7SiwGGYyumpv4fZgZ27IUpRFXNgLlIVXaxS5uKRXOes1sMRev+pQvu9BeV6kikHPltIYQVCOGFbHwrchmJ2V+gn9hJEIYBIopp1wNTARKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mrnidYhy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q35npw43; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3RRP93890153
	for <stable@vger.kernel.org>; Mon, 25 May 2026 05:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=; b=mrnidYhyVHk/r4CW
	uWJV4XEZohM6XYWyYSPlnNKiztNL3kEpw8M26kONxWLi6sqLTzOyhCgre35GYzI3
	bpDu0cx8o+X6AMzvnkHjcvFOgF60zzUBk2uIs/ox/IBZH4pAZ07+ntm/vOLhIC2A
	nZ2eUc++wk7BwUynwix/TfV4iEywx8tc4zTdAK6UlmromSUjKDDEGJZJIJb3w8cs
	LokZZhp94443QaZcSsBPmFhTOg9Sm7o7NL2IMLMfnO5T5L1JzDFVclIhs1g0ZaET
	WVB3jdCPhnJya6s4DIq8JHGjN70+aQ5zMRJfbOU1V9WIjx2bf3BkGC9jvFHJBtXE
	irIm1w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asw2re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 May 2026 05:31:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so2281152a12.2
        for <stable@vger.kernel.org>; Sun, 24 May 2026 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779687087; x=1780291887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=;
        b=Q35npw43viprb4c1GQmELuB7UDQygQShyC0QgTGlVknDk2Xdtz4hjp4NiJvBTtoqeC
         YdoVVoGt2YGzEW0KMsSV1tOtecs+AhaOdDjJPr+Xj9BL/rKsLlCyOSuzYJYjOzgD/Q6K
         XRDvvyvORJyK9qMK/8Fl6lhr2ftEVNGlZoPFxmeE2JgVZgUpMkScYi2wKCIlvtQrk+kx
         /AB/OrbUjDXfcMrXuZpC7AvNG0xPZR+H3RnVHU8dHuzQT6YQxKrn825mXcw0XK0UMzhV
         A5r9GaeOHHLzkE9wSheHLdogYr9aF/5okcUUejKwYyS2yaCnykwo/VcHlmLO5m0rhS5u
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779687087; x=1780291887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=;
        b=Dw42jNteOAP8wm/7yvin1+XUrt2iEmR5UpjINpesoF8lOK0ckrPgjXd3Py1yj6nIP1
         eiwLwR3yDoFaSuCxU+93MgkS21S0DlOBlI63nhpqqw5gDPuAOkckp8VJCuW8JjGm3dMf
         CMr9LeRM/dKjyIIaxJD15meyj9KgZ6YvOTqj6nEzHDVm3c0ABFUKjkydWU5TB6rhj3im
         D+YZwQv+8jdpiS9yVCRvK3u0mkL/ZEwwvpgbLrN2lrfWVj4ZIVs1F4qMYRwj99Qd+TUm
         5t0MqREy7iYrqOza14o0T/V8n0PfThAPQLU4k7wjEW9QJ4uA7Ry+Os93py82G0QZoigq
         VtsA==
X-Forwarded-Encrypted: i=1; AFNElJ9U+9WmrN9gpUKwpzF1nw06XnViD/IDv90IswElpRlgvg0T/V+R+V75ofSUJhApAXMEyPG2t7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YySS4KZJhBwEIw+JwW8l9A2bA80BUhpmSwH5OjMH7oxixkcDbrl
	3jkn3ez9EJDrYQIHyQIFfNjDZzzhoUEAD3CmcHUkKVOjvzSqT4n37SQdZcKCq7L8TNBCES/RWol
	n0Nfuemy+FpzHir9lXNSny8x648bN9NJ9EZ6KdfImBEHE2CddY7mab5IPjHw1zlcjqrI=
X-Gm-Gg: Acq92OFwTTxj6LXd8cYIDRw+FfZ3uorIriaok07QkhxVfYdL/YcUXyeEyOXCbysYTlW
	TOQO5fgBtrdDHINx7LUsXXZa8GvJcHPFOQhQT3t3GIasylZPXWN9q92q7vvra/yRqPaMhkvw08C
	UONoQ4oeA4rOieYmpGXKG8sjtC73V3iZyV2QZ8Ht44YljI7kgzcZmUzgE470ZfeCfSzfcLeZq+4
	OimZt67OanP2QLoSME3m9yVJlxQNK7Qbif1mO7EP1Umkdoi0YaeQyRKEL9Z4CCZulVJh7iS2u/q
	jOn1QY9bEijZ5PAeA+nzjmLUBlnknz+wwTjSbhZQsGWFQYoTh16ra5Gm5tUwUaTOpCK+KU4dI8o
	X3sN707u1rfBY9UsWPqBEOo773r4CIbZhQGSn1j2sauspK1/Hx0ZMVw==
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id d2e1a72fcca58-8415f17bdefmr12189656b3a.17.1779687087032;
        Sun, 24 May 2026 22:31:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id d2e1a72fcca58-8415f17bdefmr12189626b3a.17.1779687086548;
        Sun, 24 May 2026 22:31:26 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ad2ca6sm8175618b3a.5.2026.05.24.22.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 22:31:26 -0700 (PDT)
Message-ID: <16ae5bf1-6124-4644-9e54-4fe45aa1041c@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:01:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx-lpi2c: mark I2C adapter when hardware is
 powered down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>, aisheng.dong@nxp.com,
        andi.shyti@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1MiBTYWx0ZWRfX4wfVUaTDJNfy
 Ev88mRvKOuK1YqjU1tcaOthue9S/+pGAjCy0HFk2RG+i3B54egcebcqQf6XqWmGowehYDPMQapc
 2erzQ8Lvp0xVsvRv42JxR/itcuDVqzgkb5GI7/Oe2yUc87Uwwr+I0d2brLu5eMnP1Q9fvDbqNcd
 gbZusRVDEJRE9T3spzhjM222qts9YPOe660VtQ7NsgJL0j6o/gmVouh6DrE42jC76/LyaRlKC/H
 Px+rQrcdBFsUwD6cMQriznyz9oRqc0Iphj0rCi/ICuoGfw9QR4p2ph+RKj+HVi6QzFsQeB8uv7Q
 9nFwpW5gFid/fsMS3a+vehjlS9UQ7obDLIFNJBfl419Pte1zkdto1NrJFezre3drTsBgebdrEDM
 9b+eOhU1A2Jn0QezARRdyAk9s3WCfymovq2TNB/3UpZA47WDpDu6JzJAulvfVKKf/rLt+8r5FT6
 8kzgyTCr8grXtPfbpEg==
X-Proofpoint-ORIG-GUID: XEB5-lhiLNeFWC4SVhNRalREgVcxLaVv
X-Proofpoint-GUID: XEB5-lhiLNeFWC4SVhNRalREgVcxLaVv
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a13deaf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=elOLNqXY3ezWbv45m3UA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250052
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254074-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,nxp.com,kernel.org,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,i.mx:url,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A68AF5C5E81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 8:44 AM, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>    - suspend_noirq and the system entering suspend
>    - the system starting to resume and resume_noirq
> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

