Return-Path: <stable+bounces-253701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aODZD8IDEGqLSQYAu9opvQ
	(envelope-from <stable+bounces-253701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:20:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3971B5AFECB
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0F113004DA8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B538886D;
	Fri, 22 May 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fj1Gj80Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8fWyW/S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35175349B15
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434423; cv=none; b=LjPyHOsigsZ+V9/UGFswW3IT+5esCHsuEem0fvkYffFGXCDOtduEGWrj3xebzzJqwGwRtk1G5kW1Y7Re278/xO5toJ2BcYtqsoKOqYAA7ckratcwnnrqYJr8nTSyxM5fM27uYS9XmAhTDG2OFntqU0WUmKbI6X3MJfnwXy5Pyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434423; c=relaxed/simple;
	bh=/tvkinZc6kam6AsYNY4KzQ46LaHAeu6Sx70rjikUnw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksD+7kODiW3VRZJK3R3eidXjocX04Z8RdtthUeM211Gk9tHDd5+ZkA3LGVfV37K0yKxuk5KxK5FMKA8oOBD05TeXL4yEY3MzKlSn2tzK87gdlLlMazMhf7c5kecN0IGlMEPm5wJlyOCrVcwgvj1YRdnDj/gOVLYxBFxHUaNG8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fj1Gj80Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8fWyW/S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M2VOfI1657930
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=; b=fj1Gj80Zd3Xzg5Hy
	6VXT9nMwdgI19YGqTzLas9P9tZk1JGBbxWrNJ/3HIfD/2girwPx9+K9lQAT3ZxAT
	+1TELcUT7UuI1pxxwiut3okMvTCTN+Vtcgk1g8iokVtcEw02lB6ETE1Y9SUr6y6K
	Bc8FrTeczZQdIv1duxQO+W4+m/hKVlEbIHJnn6jHzP5BiOo6rIzbCwFW7CQi81P6
	+UP08ZawsbgiOPTQJF2EbBzkUeGQkwvOsyyQ5wrExDDiYcNguf4vpLFacCN7hqxl
	TcNz+vpsqDAPR8CJlLmQdUqChISoXFKKJM9EHViTgQfYSdInlh7pF1LvmNUxaOJJ
	ytDjdw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkmdd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:20:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so4001267a12.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779434421; x=1780039221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=;
        b=i8fWyW/SVg8zM0H1egM7Dk19N6/g6s7FmWY/Z9IAoY7J1r26MLVd+GitDrcgvXZj3d
         07pmeK+fuQ7DsPys5e43a01VTeCZZQy4Jw/Mi+sgJHZc6FzPUXAb1m8bcwl9E9CYzgSM
         jIRf99nQGyDwB2QEt8ezZ1ieR5adEXdr0j+zfkIuhUO8o9KaSqqGrMaEvD4cl7/HHUhi
         eF/SNRF0gTyMXBVDj8+DKjfhsqCp/bMcskDEbtqwUkmvSGFutetGu2vojvreCoMaIVwm
         GL6h1gd7Bsl4Yp+lhneh/Gv2jn3vfIxtTwy7Iqr6KOUxfs77+tuddydY0ntHCh5YxFIz
         Xa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779434421; x=1780039221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=;
        b=n5q+DgbLeXPvm6qX9SzORTz/p5/1xxIrf45tL6SuShyt5U/ftkAkU1zvtr0ihBsQtM
         hCw0st2grKnR29TfEdp3XrKyNcuN7ETVLHV1xjs0LkVIZT1gGztGDna+oa2aCyViEanS
         836Zl6ggr++tpREWI4yQmgcEsWZ3T6Kvs8YWCXFSSWNpV9VquUVZdzU73EJ46Pp/qUAI
         iu368VyMQ7kawNLLKopqNcxZxdUNy9oszMG1JoYMopATTX4klUCWlHcXxMEhuQCLFZqY
         vwO2z5RDXTs3tK0bh98jl4KcXcZPZyg5uScrby30W9gltYcMoSRzZB5b07kiWbMWNI4j
         85XA==
X-Forwarded-Encrypted: i=1; AFNElJ9FNSXpc2oZXWA5GwvObcdsLXxTiIxQUwkde5pqr4bRgFvNo+FOOJI0rDN8EtZ0cAYjO8WdL4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApn3Eh3++DJnSDkQTxnGEMvs4WhhcWnut1YpZWlZjult4L/3Z
	ePYjKZysrDStPTQn/uATmmllyJd3Hjj9xFrJ8WMc1YfEZ2S7t/lRcAz4OrL6zNLnq8TmatAXlFd
	g5LlBBnBXuHr3ktB0Qfd5wrGcaMXB6aFfOAFA6PmqmSD7BzjPApB7JT2mH3E=
X-Gm-Gg: Acq92OF1Y7cVze/THU+P1Yy8bBVTccQF+9/V683bduFw1cmq+I+pQ6/kiNjBbouvFAT
	OZy4uunbrTJ35zAqeL7pNXrXY/prFT79o5cIjzUi3j8Cs/nxOORhGWwEXgPoZhhmfS1Fxa3kBtp
	cxm+iIwukduZoV5k65zGo3h1c9M2D1IUclCQCv5XY5ifn31Up4Xwvfcoyi1FwXsYiDlQaWkyKpw
	aXh3W9HT+cWwPc5NShM4sAt9pwHYBreUgauzAf99lXRPeQ8fvZPYTSvQP+ACCWSZSD6S8OvG3b8
	Q8MG8nCn6zFaBNiNu2TK1q76dcgJr3SkaVKU5VAeivTQ+LXaexmxKQKJliZin88NwgbLLxClVH+
	V4cbWb4UXrFfUkuT/8qhMymbrgN/eKTI2QKnxZkE3g9AXWey4173ig2W1
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d68d:9e83 with SMTP id adf61e73a8af0-3b328c0f502mr2643995637.5.1779434420641;
        Fri, 22 May 2026 00:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d68d:9e83 with SMTP id adf61e73a8af0-3b328c0f502mr2643961637.5.1779434420115;
        Fri, 22 May 2026 00:20:20 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205616bdsm707529a12.23.2026.05.22.00.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 00:20:19 -0700 (PDT)
Message-ID: <a0941899-bf27-4551-b23d-37d7f99a3519@oss.qualcomm.com>
Date: Fri, 22 May 2026 12:50:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
        Frank Li
 <frank.li@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Carlos Song
 <carlos.song@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
 <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
 <AM0PR04MB68026A6412B8F844D1324B92E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68026A6412B8F844D1324B92E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3MSBTYWx0ZWRfX6/gjEeXvIhx1
 Hw2HBu7PNGuYom0UiajWQfeHrSMHeYCjuAg+NhkWFkVpT0zMjsNzDT3Lclc7EpfKHRERmHLVxuk
 LzG+5FPI3dKQW0sfSBkVClgNXnjNDFKydrArKnsl15zpBxx/tSOPLKhMdEDHa/UoXmANhLiC4o5
 2mHL19w3KMTy/5s99ipu27hhxsa85GW0m4f+aKplPm92PU0avQsGsScgWlurLeNuV6U6UcQoSwt
 J59HPV5LOPgm9FWCvVPFcRyR4HVdL6R23xe8sKN4SCOdZm5qjdegP2gAbXtsaSbBQbllMGS7v5S
 ew2WLm2IbRHZOKhycmSkVwI2TpU+Ftjsld8qkVrHKfKDorsgzvMGClJXbHd+YLxLApmCL9MOySK
 PsTLqhY6krB6GRRJzOUSxKIqyNnhd69DTi3bffhlsZ1xX1/LqDRwxlRH5OMnsCdr1bafoLEDup9
 u02c8wB19cFyXL6TxUA==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a1003b5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=2UpP72-WgONIwjLJxC0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: npwsf9U2DHdC4o6oz-vw4f0x9ONoYIZG
X-Proofpoint-ORIG-GUID: npwsf9U2DHdC4o6oz-vw4f0x9ONoYIZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220071
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-253701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3971B5AFECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Carlos !

On 5/21/2026 8:19 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 8:40 PM
>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; Mukesh Savaliya
>> <mukesh.savaliya@oss.qualcomm.com>; o.rempel@pengutronix.de;
>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
>> down
>>
>>
>>
>> On 5/21/2026 5:32 PM, Carlos Song (OSS) wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>> Sent: Thursday, May 21, 2026 7:14 PM
>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; Mukesh Savaliya
>>>> <mukesh.savaliya@oss.qualcomm.com>; o.rempel@pengutronix.de;
>>>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li
>>>> <frank.li@nxp.com>; s.hauer@pengutronix.de; festevam@gmail.com;
>>>> Carlos Song <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>> stable@vger.kernel.org
>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is
>>>> powered down
>>>>
>>>>
>>>> On 5/21/2026 4:21 PM, Carlos Song (OSS) wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>>>>>> Sent: Thursday, May 21, 2026 3:40 PM
>>>>>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>;
>>>>>>>> o.rempel@pengutronix.de; kernel@pengutronix.de;
>>>>>>>> andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>>>>>>>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>>>>>>>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>>>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>>>>>> linux-arm-kernel@lists.infradead.org;
>>>>>>>> linux-kernel@vger.kernel.org; stable@vger.kernel.org
>>>>>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware
>>>>>>>> is powered down
>>>>>>>>
>>>>>>>> Hi Carlos,
>>>>>>>>
>>>>>>>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>>>>>>>> From: Carlos Song <carlos.song@nxp.com>
>>>>>>>>>
>>>>>>>>> Mark the I2C adapter as suspended during system suspend to block
>>>>>>>>> further transfers, and resume it on system resume. This prevents
>>>>>>>>> potential hangs when the hardware is powered down but clients
>>>>>>>>> still attempt
>>>>>>>> I2C transfers.
>>>>>>>>>
>>>>>> what was the reason of this hang ? I was thinking you don't have
>>>>>> interrupts working when client requested transfer but adapter was
>>>>>> suspended. Please correct me if wrong.
>>>>>>
>>>>>> And it would be good to mention the actual problem and why/how it
>>>> occurred.
>>>>>>>> Code changes looks fine to me but have comment on commit log.
>>>>>>>>
>>>>>>>> It seems, you are adding support of _noirq() callbacks to allow
>>>>>>>> transfers during suspend/resume noirq phase of PM.
>>>>>>>>
>>>>>>>> Would it make sense if you can write "Replace system PM callbacks
>>>>>>>> with noirq PM callbacks" OR "Allow transfers during _noirq phase
>>>>>>>> of the PM ops" instead of "mark I2C adapter when hardware is
>>>>>>>> powered
>>>>>> down" ?
>>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thank you for your comments!
>>>>>>>
>>>>>>> But this patch is added is not for support noirq PM callback or
>>>>>>> transfer in noirq
>>>>>> phase.
>>>>>>>
>>>>>> Okay, may be actual problem description can help me.
>>>>>>> In fact, this fix is to mark the I2C adapter as suspended during
>>>>>>> system noirq suspend to block further transfers, and resume it on
>>>>>>> system noirq resume. This is to prohibit I2C device calling the
>>>>>>> I2C controller after the system noirq suspend and before noirq
>>>>>>> resume, because at
>>>>>> this time the I2C instance is powered off or the clock is disabled
>>>>>> ... So I want to keep current commit. How do you think?
>>>>>> completely Makes sense. Please help add how this problem occurred
>>>>>> and
>>>> why ?
>>>>>> So the change/fix will be good to understand against it.
>>>>>
>>>>> Hi,
>>>>>
>>>>> In some I.MX platform, some I2C devices will keep a work queue all
>>>>> time, the work queue will trigger I2C xfer every once in a while,
>>>>> but the work
>>>> queue shouldn't be free in system suspend.
>>>>>
>>>>
>>>> work queue has transfers queued even if system is suspended ? IMO,
>>>> the client i2c devices should not let system go to suspend.
>>>>
>>>
>>> Hi Mukesh,
>>>
>>> Thank you for the detailed discussion.
>>>
>>> Yes, I totally agree that I2C client drivers should ideally stop
>>> issuing transfers when the system is suspending.
>>>
>>> However, in practice there are many different I2C clients, and not all
>>> of them strictly adhere to this requirement. Some clients may still
>>> trigger transfers through workqueues or deferred contexts during the
>>> suspend/resume window.
>>>
>>> Therefore, adding this protection at the I2C controller side helps to
>>> avoid unexpected accesses when the hardware resources are unavailable,
>>> making the system more robust.
>>>
>>
>> Agreed !
>>
>>>>> Within a very short time window, possibly from noirq_suspend to the
>>>>> system actually being suspended, or possibly from the system
>>>>> starting to resume to before noirq_resume, this work queue will
>>>>> trigger an I2C transfer, and at this time the I2C controller's clk
>>>>> and pinctrl have not yet been restored, reading and
>>>>
>>>> Right, this kind of explains the problem to me. I think you are
>>>> trying to serve i2c transfers when your resources(clk, pinctrl) are
>>>> not turned ON and also interrupt remains disabled. And that's why you
>>>> need to add
>>>> _noir() PM callbacks supports along with IRQF_NO_SUSPEND |
>>>> IRQF_EARLY_RESUME flags.
>>>>
>>>>> writing I2C registers causes the system to hang. This patch make all
>>>>> I2C operations are performed in a safe hardware state.
>>>>>
>>>>> Is it better if I add these comment to patch commit log?
>>>>>>>
>>>> if my latest comments makes sense against the issue, you may write
>>>> accordingly. if i am wrong, then your explanation makes sense. Cause
>>>> of the hang needs to be clearly mention int the commit log in your next
>> patch.
>>>>
>>>
>>> Based on our discussion, I have updated the commit log as below:
>>>
>>> On some i.MX platforms, certain I2C client drivers keep a periodic
>>> workqueue which continues to trigger I2C transfers.
>>>
>>> During system suspend/resume, there exists a time window between:
>>>     - noirq_suspend and full suspend
>>>     - resume start and noirq_resume
>>
>> - noirq_resume and resume start [Just opposite ?]
>>
> 
> Sorry, the expression is ambiguous.
> 
> I will update the commit log to:
> 
> During system suspend/resume, there exists a time window between:
>    - suspend_noirq and the system entering suspend
>    - the system starting to resume and resume_noirq
> 
> Does this look good to you?
Yes, looks good.
> 
>>>
>>> In this window, the I2C controller resources such as clock and pinctrl
>>> may already be disabled or not yet restored.
>>>
>>> If a workqueue triggers an I2C transfer in this period, the driver
>>> attempts to access I2C registers while the hardware resources are
>>> unavailable, which may lead to system hang.
>>>
>>> Mark the I2C adapter as suspended during noirq suspend and block new
>>> transfers until resume, ensuring that I2C transfers are only issued
>>> when hardware resources are available.
>>>
>>> Does this look good to you?
>>>
>> Looks good, Thanks !
>>
>>>>>>
>>>>>
>>>
> 


