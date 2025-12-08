Return-Path: <stable+bounces-200331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977EECACBE3
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41EBF31248B0
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F6326934;
	Mon,  8 Dec 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hqcMzYUi";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ppCWnECj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4D325726;
	Mon,  8 Dec 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186304; cv=fail; b=R8FVv2rXhXBKXlvrMrYizPRfXiPvBQWYCRDfZQmzpZTT2T0BtIfMZe57/5a1BMYJoazGuQcx0StVwEE/iPvhagsezbNRc8c88c4uJt8PTqwi0ThEZh5pqMEOgdidWLfBRNBvUOAc7b8j1pmPrBclfCOEIjZwwVcSW9VmV6rCV2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186304; c=relaxed/simple;
	bh=AxICOJnYe72xQqh0sJhyD4E7DLD9mvT7uc7UuNxABTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbVixoDcllNx+h6d0nO/6EXEhK67lOuB3StuGatod0/mVpd9GQ2qeJ7UjcC45zJw6tF+HZTmL3xaBgWQbb1ShAct/brH1J7EH5yZWR+XEEr/WuJycHzQvqba/qHODdYkHMxkGpwyr+KqmoEQaHAQcfjZqhQ7XUGzUETCEsPUY+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hqcMzYUi; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ppCWnECj; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B80T5bP091931;
	Mon, 8 Dec 2025 03:31:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=4Wv8QGsVd83OQLmWHMH34efVpdYz0I1Z/SWzzqeTyDs=; b=
	hqcMzYUiD0ogDSzn+cM0jthg1C6FbDf+vpjBpaIRp15X1txa2TMP+dGKcA0rf3KQ
	cib+pk7vWz12LHIBRLJ4imP0m4zpgLbLO72uI7rtO7C2ufw4DXjCpnJYdUJxDbqz
	jHvtw6mYTk6Cd/Bll7yf/ZCzZuPlfzzcvD79TPkYzfWva8RzdNmag82bjnxW6Ida
	s5kc0q0jOOkHx99w4reMpPEuwONRDvs9ILsXuwMynPLN4fIW2h4xv8MR69lixZPl
	tv/SWa2SATVaPMaaE4/TIcVWF7mDpPQqgDzul7Gew48ssQtSkU0oofwLPDRI6tTj
	SPh8A6GtDdSBPAziorgYqQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021100.outbound.protection.outlook.com [40.93.194.100])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4avjs29qan-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 03:31:08 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDX7Y1txJO7C4gmZVGCfkcE2QHGItfp1OXD4FMdvAkOtKE0ih7MLdUoB/3aquLV6gmXPr2waX1ABlCTDI7zaVqPytbUCABbUEoAvRzxRMDNnrDsD5NM0Q+dd9Fz+wPolaEtWdrFZ0uUZug2juvroju6EfkowjKzZg9yVdgcvb6/eaBBo94/Stam52a7mpja+8LQcbSsPpvxwsUqCSAA8cHeiOxar3NnsKDi9evkmh5G2T1fUky6mnVQPKyHWSXA7NgWr1axyeq9tXWCL+zNzuZGZu08Iva/UyyQseUl8VD51fZtYXVDfOJkWaH8gHyio6+5x6grMCTM1Y2MYHIjxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Wv8QGsVd83OQLmWHMH34efVpdYz0I1Z/SWzzqeTyDs=;
 b=gJBw/smJaitsVFBYzNsYCnePeUSyguV9NKZx0VbsiafqZxaAmPybDbeRNN8KpgwJtki9F8A4DK65w0O90iNPiHzOUMbV/i6Yxue5CZ03rrn6Qn9mtaJAs/dVVNihXDV8RPZovrYmLt2dD7CbQwfV84gPGnGnoVizi7Gf4fNqpkWM/u/P9JXj53XZuClxEYsNrDSiK4Hzd4WsI16+R/ViC0lUbilzfZ9Q704NsoPuPelicTzlkSfB/cpdQkiwoDORRhEjx6ytEUcA/LchLWHWKs6WcTIPRVHvzotWrF+xXoj42xM1hhg4JDSDYHnFyuTSJ+4Tub79OWhTOcML2eXq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cachyos.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wv8QGsVd83OQLmWHMH34efVpdYz0I1Z/SWzzqeTyDs=;
 b=ppCWnECj62UxuijvJZHR7QWaN/lCXM0rbjwSWUKtgbD35j6aED+5PNDw+Ilh7+juECz47iJ0FkDrBckxOqNL3vlujhmTOanesRiRwyf8jY/3JwSWdSR4C7KKJYzmR0CRDag7vdalcXGhiQrw8ZQ2n1FR+gwiCCkx7NTyvgLFL7U=
Received: from MN0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::22)
 by DS4PPF879E7CA97.namprd19.prod.outlook.com (2603:10b6:f:fc00::a2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:31:05 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::da) by MN0P220CA0005.outlook.office365.com
 (2603:10b6:208:52e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 09:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Mon, 8 Dec 2025 09:31:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 224E5406541;
	Mon,  8 Dec 2025 09:31:03 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 11F72820247;
	Mon,  8 Dec 2025 09:31:03 +0000 (UTC)
Message-ID: <6d10da69-65bb-4dff-97d3-8c4a387a94fe@opensource.cirrus.com>
Date: Mon, 8 Dec 2025 09:31:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l41: Always return 0 when a subsystem ID is
 found
To: Eric Naim <dnaim@cachyos.org>, David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20251206193813.56955-1-dnaim@cachyos.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20251206193813.56955-1-dnaim@cachyos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS4PPF879E7CA97:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fe90b4-dced-4644-a21d-08de363c8219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elF6Q2RIclVldC9OR1VFWHhueUl2citUT0NmMHVmRlhtZFVYZEdWMlRhZjFV?=
 =?utf-8?B?OEpWZEt5enVZZnFPc0w5dDdneEorYWZDbVY4UzgzVXJuR3RaZ0Y0eWV0eGdM?=
 =?utf-8?B?OEVraFMwbWNWNGtJYkJuV1Y0L2RmelQ1NXhVY1BPNVNZdEdzM3NQcW5QMVBC?=
 =?utf-8?B?d21HTlBEa0RLRHlSLzRPcGhlUGVCeXRiUGtsUFZ4VjhYZThCNUJwT2NmRFl5?=
 =?utf-8?B?SGxmUVd1VFlYWEN2bFhuVWp2b25HZm1wOVFIRDg2UWpXckc0eXpkMmJPVGpV?=
 =?utf-8?B?SFQxRlFCWjhGRHFoUlFNVGlmb09EMkovcVo3eHRDZWU3dUdiVUFyZ0NjdjZ1?=
 =?utf-8?B?MHhsSU4zeW9DZ3dYeWZhMkZyQUx5ZkYwZmRRMUFLeTNlNHhGc1VMY0dLbW1P?=
 =?utf-8?B?b1ZDdk5TeDA0TlgwRWwwRWdMZ1FaYmliNFRDb1ZPbTh1bFRqczJhUlVrbW9w?=
 =?utf-8?B?Zjhtc1ZIb1BvYUtNTXJLMmdsZFFaU3d5ZGliSVNTS1pJUTdrTUFOck9sbDNH?=
 =?utf-8?B?THZSMWhBSnhKYnVmejhtbFRjOStYVzNTaDNiUitGeGVCT05Wa0FBNm1BN3Bx?=
 =?utf-8?B?VzU1dk9GS1pjRzBTVXNWQVpvelhTNVB3WWdWWlllU29sSW9wVjRnc2JoMUR6?=
 =?utf-8?B?TDMvd29FdnVwNWM2UUtHMmpKUXFvaWZ3RDhiUEw0QkIwOG1NRXFMM3VuZkVH?=
 =?utf-8?B?VmN4UDQwMXBiazc5TjY5aEY2QlM4cHBKSmVPWXN2M29MZWJTTnlpOWRXcEFm?=
 =?utf-8?B?b0FZSXk2QXdCVU9HYzJ1a3o4bURVRThCaEozTWhpUnlPYTlPLzhodTMrRmY0?=
 =?utf-8?B?ZlZFK1FobktibkNGTmhaRks1WmVMM2ZxNmVlQ08yOUJCbEdMOW5oRmtKaFBh?=
 =?utf-8?B?R0p3VGV6VWRtb05QUVlabGhlZkFLU1FVc2ZiK3RkSU5lT0RveUZOcWJnMUQ0?=
 =?utf-8?B?aHhyYWQ1dEdjNnlWc2ZQMkU4QldFdkJDZWYzcVdkSTZadTZkeVNPam56bGJu?=
 =?utf-8?B?cDM3YjVOamJTdmNGTVljRGR1bjB6Qy9kd29PWWxiMS9CODZobUtGbU1FVnZj?=
 =?utf-8?B?KzU3RE02TFJkV0MyYmVlVFhDaHJScFk2M0pGM1dkUmhId3orVS9JelkvaWdX?=
 =?utf-8?B?S1NuZEM4b3MrVnFaYXBla3JkMlJWa0lVL3pYT0xLS0pYNnFIaEh5Q1lZRmNY?=
 =?utf-8?B?NHZQN1Y0Q3Q2MXZKbitTdkdpalBzTlNnRGxaV0JidWZlcVpVV0p3Zk5NZHRQ?=
 =?utf-8?B?YWs3ZlJZaUE1NUNmZTU3NFcreHp3ZE5wSmRnUC9kc3paYlNjU0hQbUVJQ1JT?=
 =?utf-8?B?djBEY3VJaFI3S3pXdFlLbUtidENZbjZGaVB6OEpMSnA5SVI0MWI1OUV6R3lL?=
 =?utf-8?B?OHJTOXJRME5BNTdzc0E5bEVSU2QxZWNLTHRxYktqTzhqTVoxdkluaWpROGF5?=
 =?utf-8?B?eS9nVjB0K0xmSlBvVGZseWRIZVJaREtpTENvOTRoYzEwQmtzck5sclJ6czFS?=
 =?utf-8?B?eDF1MHljc0VHd3U0ZGNPbWxMWVN1UzhiZmdZZVVPMDNxRGxFWWZKR3Q3cnRX?=
 =?utf-8?B?WE4zU2xsY3dDOUc1YjR6YmxtZ2x2OGZzLzRLTHFXZlVNRTdNWHNObnJPVm1L?=
 =?utf-8?B?TmxtMXJtL3hBWEtUcTlWWXh2em1Rdlh0cFlFSTRWOFB4M0tLa2dQUWlYQUly?=
 =?utf-8?B?N2NpMFJheEFVbnNMSllHdXFNejArRWFkSGFrN1ZaK2JrZ1NCUjkrWGZRd2JR?=
 =?utf-8?B?YnFNTVhKZGtvelBOdWR1ZTBhWE52WWw3anEwZnY0dEtuYnV6TklwL2hBajBW?=
 =?utf-8?B?UVdnUGtyT3pEaC8zc3ljajgrbXBOaitmdDk5bXQwVmpaSG96RXVYTkFXQU00?=
 =?utf-8?B?ek52NW9XM2JwRzJaUXBXa0J4VkdBNzFENFU4Vks0RStab083UktpL2VZemMz?=
 =?utf-8?B?enV1Y3YzZUVEZkNwSngyN3UwYXZRZzJMN2V1ZkJlWXB4enZQYVJwYm91a2Fw?=
 =?utf-8?B?c2dhY2xYdCt2NDVIMVF1NmJCcnEyZmRWcVI2aHp2Ykc2Y2lhSnJPZlRHMmpN?=
 =?utf-8?B?aXM1STg5NDMzRjBQMC9ZUjd0U1g1aUlJdmwrMElYOUdGb2R6SHZqOEJyZ2wr?=
 =?utf-8?Q?GwUI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 09:31:03.9710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fe90b4-dced-4644-a21d-08de363c8219
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF879E7CA97
X-Authority-Analysis: v=2.4 cv=dZONHHXe c=1 sm=1 tr=0 ts=69369adc cx=c_pps
 a=q7lH8giswqu+5i8oUQ1grQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=mehdgkVfAAAA:8
 a=w1d2syhTAAAA:8 a=NRQH7m2onSM1aHJP32UA:9 a=QEXdDO2ut3YA:10
 a=J1pP9gvGZaT0y92QayzM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA3OSBTYWx0ZWRfX/DMdoEW5PCBB
 IbToIm0CT8yO8q0Mhphgh6FcpnMdJ+DYAJFgnN8QNhGBwTBw2pREDKNVH+aJUiWnVAVt6h8UaLb
 TLzJjzPy8e8sQGKVohSxzOusoKBr74Vd5JWuGDI6XYPBvYaGCmOZmT2Y3iKhOQ3sgvDbIvBdPka
 jK2teJi2f/SwwvIVvvBSDF6W+IIQmH0GD38EyezfDy24f+rTXWP+PHMXMHbfMdCRupoKPVpddQv
 Nl/5ZRTvQkH37HRZ/pKZqnh+aFD4y8fmGA6nDXPtaGUpKvp5Pg6WdlDVkqh9+smGR+9NacZgF7d
 8j+0opQcoMButEgyKdGceuEE9/R5YElaBrTEYWHdfWBLvGABpQgn8RDd1bM9DpDuEqxivN1D33D
 /HXbfd9+nQK8f+hCce6fvD+xobdccQ==
X-Proofpoint-GUID: x8rIJG_fCGF35PO4PLdK3wooAXXoKjW3
X-Proofpoint-ORIG-GUID: x8rIJG_fCGF35PO4PLdK3wooAXXoKjW3
X-Proofpoint-Spam-Reason: safe

On 06/12/2025 7:38 pm, Eric Naim wrote:
> When trying to get the system name in the _HID path, after successfully
> retrieving the subsystem ID the return value isn't set to 0 but instead
> still kept at -ENODATA, leading to a false negative:
> 
> [   12.382507] cs35l41 spi-VLV1776:00: Subsystem ID: VLV1776
> [   12.382521] cs35l41 spi-VLV1776:00: probe with driver cs35l41 failed with error -61
> 
> Always return 0 when a subsystem ID is found to mitigate these false
> negatives.
> 
> Link: https://github.com/CachyOS/CachyOS-Handheld/issues/83
> Fixes: 46c8b4d2a693 ("ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI")
> Cc: stable@vger.kernel.org # 6.18
> Signed-off-by: Eric Naim <dnaim@cachyos.org>
> ---
>   sound/soc/codecs/cs35l41.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index 173d7c59b725..5001a546a3e7 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -1188,13 +1188,14 @@ static int cs35l41_get_system_name(struct cs35l41_private *cs35l41)
>   		}
>   	}
>   
> -err:
>   	if (sub) {
>   		cs35l41->dsp.system_name = sub;
>   		dev_info(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
> -	} else
> -		dev_warn(cs35l41->dev, "Subsystem ID not found\n");
> +		return 0;
> +	}
>   
> +err:
> +	dev_warn(cs35l41->dev, "Subsystem ID not found\n");
>   	return ret;
>   }
>   
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

