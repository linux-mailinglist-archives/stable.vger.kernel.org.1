Return-Path: <stable+bounces-227580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJUQBZyAvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:15:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F12DE664
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66C4E3041251
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE13CFF43;
	Fri, 20 Mar 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qVCadJlH"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011038.outbound.protection.outlook.com [52.103.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B63CFF7B
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026577; cv=fail; b=EF0fgatz5HWcUbhQbZ+3epXaBxgdv9nCVgDe3NVAduxCDPbrsyeWtGqUESVACjgrWRil1lzOrMf8mpfJYFDgsWc6nUALcvGY/JtQjp0YSTntbS7enVIzpHNBdBTmsI9g/1C6fUwCDSF01zNK5CELSxNWmjG6nDiljtDOclDpHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026577; c=relaxed/simple;
	bh=ZRFmxXYBSmiCEEAEqFtu9UNl3enXSfw/ftMAd6U5tDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NURc2XAEC8dA9kwxWd0p7/1y/6c9kToSMSZ551OpoL/+fato5y2BFuxNLX9Muzp3AbGjsVyI/8dvUH1bh3t/V0YtTX6yJ5g2PobwlTZDYhXSQDPPyY8o7HiDcUfwLSztjb95uHbqZ8PHLJuAb6YMp3zE1k5p/SkMHf+Y1eUz/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qVCadJlH; arc=fail smtp.client-ip=52.103.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPO0H3VS97oRsUhEY+lzjbLagf8gvpZoNgcLtubDdg9TsYuU/3O5/VbXwbaV5+uDKaSBL/XJCmtGoEW5olAB1d5vw+PitxxEnluv8kUjbu4Akd2CWUT4qoFWiSKl0Mv206z102mGeWsLdHmdn1j/Poc7RbG61wczr9AH5PlKwbZ+gihTs6gqraYG6RHVLMxFSLBFzxHOl7oBl3eyJrqXtLvxd8+s5fA/ImSc2fE+5dsHYBFRSh5+WgvYITZfHvAiW3JorazQyW58bK+kExNhsktiwSMouDRZPIpCCxCGjLIHNJmVULglcK5LurarI4Rz6c72J3arb15RwFBZqV/aPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRFmxXYBSmiCEEAEqFtu9UNl3enXSfw/ftMAd6U5tDI=;
 b=IZk01wSK6I4u1lZoKhR6/D+Gjsq30JpwLt883wozvfjpSWgFpSU80KXrXyMQRMFD//aykD8HBJibBvEHat+OmhCdIsoW3TRmtVVcRzIzswgASuT49XC2BtrgOSa6vq7NF4g0xPnBZYUC1sNVwNgZkg0HfKpAtqXXIR+ut/hNRAvUie+ivQla9kHuAvzX6kEvVYVSAx/3d8rweGjLGbP0z3bsHFCm35R2tmV7tGpdzDs+zR1KwU6DfD3D4kwLxhxQQIQY1mfrv8qNGVEfV/PGhm3XS5RMDCGpAYzqtHGs2QFxYsFYt31k5WrxWY8dqoMe0fzM86bDc4828mLPj+qvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRFmxXYBSmiCEEAEqFtu9UNl3enXSfw/ftMAd6U5tDI=;
 b=qVCadJlHjis4PI/UiAP9MnggfT9Q5mGuRsMuXDXwOo4IVl8qI/aBAySESGurO/dW5s4ZdpXeLB1H88tbvsJKL0QncCBjse+wOceCviTKGCRaJcRu9QyaaerwwqelHFkcaYp4ae3TYMy4ztyOZjhEChEfwoeVeJxNKiljUGMjWz0rFRNr1to4eEwIy6X/eUM/bQsvqXy7egOJIY77dl0iQLv3BYK1y0cTZUUe9mbWxqMTgzohfS135fveDsDRUnh0Kp+rhwV3/WdBaIcfsMaJ2Lzq1ngyGGwgOC8cYdvJAtycoJ0u33Q9e4MujwmPLyns7DYMG8dkSLyUpFEwMcnJWg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB7707.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Fri, 20 Mar
 2026 17:09:31 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 17:09:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Greg KH <greg@kroah.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcuEd0/wOFsdNRC0GHsf42bL/1ILW3pb4AgAACVEk=
Date: Fri, 20 Mar 2026 17:09:31 +0000
Message-ID:
 <MAUPR01MB11546945D1BE4D9739BC3211DB84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <2026032048-canal-smell-2ad1@gregkh>
 <20260320085628.1274-1-gargaditya08@live.com>
 <2026032002-steadying-phoney-bc43@gregkh>
In-Reply-To: <2026032002-steadying-phoney-bc43@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MA0PR01MB7707:EE_
x-ms-office365-filtering-correlation-id: a5aaee1b-a2f3-432e-30f6-08de86a373d9
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|19110799012|8062599012|8060799015|51005399006|14091999006|41001999006|31061999003|15080799012|461199028|25031999004|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkVmdzNhT2lTbmQ2eVZXWGJOMlZUQ2huU2hWTEpEQVM4U3MvT215N1laUUhz?=
 =?utf-8?B?VGFHTTkvTzlmeVVaaGovN01EWHpZWXowTXFoYXoyT0NURVlOeGx3ekVrV2Fk?=
 =?utf-8?B?RFJ2bHp6TkhJUDV5RHdxdEphcEhhelhyMk44VjNPOWZPcTZZK1VwVzhoVFAz?=
 =?utf-8?B?MjU1d2NReVVWZkdNdjF6ZysydEJMWjVDcW1JTTErY3JNd0dRdzZrUlNqYml3?=
 =?utf-8?B?eWdGQTYzMVFEVHpFVTM0aG5DTTVtcUNIRG9ETVVPdmtlZTErWmVBTG9qTVRS?=
 =?utf-8?B?anIyVHpueHV6STRSMUdSMjFLMEtFemd5cC9zQ1B4M2lBU1JlbCs2eUZwWEdQ?=
 =?utf-8?B?UmlXSm1OWVFaUnNIVjVqYTJnOUNmSlA5cGdmM0hIdjgyeWQ3ZGFmbXVEeGpj?=
 =?utf-8?B?aWJ3K3BQbEl3dVJRdVhES3pVRW8yQ3ZkTWt2K0xIb2dPZUY4c29wU1RIQXRJ?=
 =?utf-8?B?Z2pLNjlOa2M0THlyWVJmM1FrZ1BTL3REK2x1MlM0WnplN1YxRG9LY0FkeHRm?=
 =?utf-8?B?dlNmRmMvVjJqU1NYYjFRT2wybzFHNGlhTUwxcEdIRm9hdWtnc2MyTnE3SlJu?=
 =?utf-8?B?TENNSHUzYVFvUGIwMFRja1A0ekRjV04xZGx6SUUwZVVMQjFHeElIRWI1aFcy?=
 =?utf-8?B?U3JrWS9zTmRBN2VWWE5FRU5hRUhneWZKSVcxcVRXdnVZSHRHMUREa2hyUU43?=
 =?utf-8?B?L2d4S2hyZ1ZiUjBTN1hKZnkxRnBQTkZDSjNXa1ArSEFVc0lyMjYzK2E5ZFdS?=
 =?utf-8?B?cVRkVStlTEJPWFRYTmM2eUdIWG8zTVA5Z1VlMHdUd3JWQ0hQUVR3ZDBkOEJP?=
 =?utf-8?B?WkJTVmVXYzI5UlJjOVBvanl0TFpHOUh1Q041MHRNVHhEMm5PN2tJbFE3Yk5t?=
 =?utf-8?B?emFXMjM2ZXI2YzAxeDA3ZUFUekY4WHIwZ20vZ1htZHI5UndXaGhxTEtTS1Rt?=
 =?utf-8?B?Mk52bkc5b3M4NTVoNmFsQWNzK0w3cEZlSVJXeVoyVzc2RnYxT1F6NGQxRlk3?=
 =?utf-8?B?NFJhbzg3Wk9TOGxRMURVbU40bVlGQXJXWllmMElUUmNuam9XTXBxeFVUK21v?=
 =?utf-8?B?c01ZNFBnenBLS1JDSDhyaGtpdzZua3ZrSUVuZkY1SUhiOTRPNENVditvYzU4?=
 =?utf-8?B?Y2dqVXdkY1hIcW5TcDNBT0RDeHF2ZDc0MHRXd1NwWlhZT1NmYUVWZVg1L05t?=
 =?utf-8?B?RXBaWTN4Snk4WDR1ODZKdmw2a280UFpDU01tR1gwSTJVc3NGcFgyWFRUZkpr?=
 =?utf-8?B?QUNjdUM4VDlwOUJzNFJ2Yk9kSFlFVE51dW5NNU0yTUdwQSthRmxMcnBWejJ2?=
 =?utf-8?B?dnF4Qnh3a3Z6WmJiV2JCbTJOa3RJdjBGQ01PRG8vS0NiVUkwQWJhcDJ5ampM?=
 =?utf-8?Q?HGKHbAL087Dn1Vm2hfUkQ8U3cy1QrhFc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnZ0L2E1dW1pa2s2NkFWNnNoWWZQa0VKcEkxaC94T1I3UUVrNUtTZE1hQ1I5?=
 =?utf-8?B?RWttRFZwNjJhVXJlRkFUeGNNT1o2SzlTN0VpaHBlMjgvdHRwTnFZR0dsZW8w?=
 =?utf-8?B?STJDdkhnT2tJRFF6b3JwZDZra0tXR1hNVjhwQUpUc0V2ZmVRbmpBb0x5eW93?=
 =?utf-8?B?dTZaeEFDZllKSVVUZkRxRThiVDNjRDlYQVIzY0NxTzdPTFNuNStmc2tVWXlv?=
 =?utf-8?B?amp6NGZRQUxDSGNBOVp1NEt4dEh6MlF0UnI3WlhManVaakZPMHMxeWhDd0Za?=
 =?utf-8?B?RE9kN1NjQ0dqUUVXaUNFUDlrUnVKL0dLVDVJQkYySkFlbi8zRVR4emlxN1hu?=
 =?utf-8?B?elhHN24yRGIrU21LV0ZUd0dSQ3dNQXc1VVEvc2ZQVHFZYUtVUmcvWFdCQVR6?=
 =?utf-8?B?MzVScDd2aGlUUDAvVXlxbzYvOW1HMnlZYi9CYnR5TzNtMGtNOEgxV2dZTi9a?=
 =?utf-8?B?OHBmekVFTFNLcVZlcnZaNlJMVlJCVmY2MFVadFhYUCtTckpvdXZuUWd0bTBD?=
 =?utf-8?B?cUsxdCtwS1Azc2dVcnhRaUlVL1N5NCtFWGNiUFpKeHhKY1BNTkhlR1VwaTBn?=
 =?utf-8?B?SnhQaWFBVzBtako2VXg2UHRzTi8vU294OUEwemxEcmxWdFlUdmZoM3FwcEov?=
 =?utf-8?B?U2J5VkczTlMyNzNrWjErdHZ0c3ZBWENRQXFTK3FmUTFvMEphdmNSSEU3YWxx?=
 =?utf-8?B?ZkJMWnowdjhuRzRXSmNSVFVHd0tKTGkyZ2MvODltMGhPSTlEK1RNcEdFRmJt?=
 =?utf-8?B?RHhkRERqV3owckEvR1FrR3Nlb1M5UEtvVTQzOS9rZmEvakpoRlZwWjd3WG1Q?=
 =?utf-8?B?ekRJUlk0RnFRYnhGc3NnVmo0bElSWXZ5VW1WRFBJbE93MW9iREF6dkN4VnVW?=
 =?utf-8?B?bzAvTjF0TE5aUklDK3p4T0drUG0xdktwRzFjQUpiSFlYQWl0NU9Rd1RhMHg2?=
 =?utf-8?B?TkNMaWF6VnA2ekpVQUtlTytEakxIRUNTOEVFZHZKUzcvTzVWeHNYSmRiRytk?=
 =?utf-8?B?UmcwVDFveTBLYllTb2loOWsrblRscWJBNTdvQlpOOTgwVFVIanhLYXNkdnNG?=
 =?utf-8?B?c3BOejB0T0xJRzFDSDJEUlM3NDloVzNFZkVRS3BEQ1lReXVBNUpXNmpKTTRm?=
 =?utf-8?B?a3NSRmNHU0FKeXlVWEpaREk2T1F4V0hYWXFMdmN5YTVkbXZpSnJRMWR5dzV2?=
 =?utf-8?B?YUxxL3NaMUJNK3QxTHh2VkduSmhFejRIdTcxbm5qTG1SZnI0TVUvNFFzVm9G?=
 =?utf-8?B?anBjMUJZM2d1Ky9LdTlvSXo2eTd6SkJaTFBQaTJtbjhLZE5UbmJ4Uzc3SFBl?=
 =?utf-8?B?dmx0VHBjclpBZVJyZGF0NkY3TDByVnhFYzlXTVV3YVVUWkhtSC9BM2s5akhh?=
 =?utf-8?B?bzBYeVJvYVdpcWZoRnlqOXNWaDRjbTNwWlBtNmsvejZLbnkrM1kxL3NQMVoy?=
 =?utf-8?B?cHV6OGl2NFZJbVpMR0pzL21nRFZkUG1OUFJtcHNjbVo1dDl4cW05NUh2RFRl?=
 =?utf-8?B?aW9wbG9GUndDRVJEWTN0NEtaNkV1amNsQTVqRTQ1WkFKWCtIWU9oL2ZieUN5?=
 =?utf-8?B?bXRYOTJuSnZXbTBSbmtJY0plYkE1NXpBSFB5UHI5ZlVXRlVZaENrU29sY2I3?=
 =?utf-8?B?dkhiZzlkMm9kTndPMkh1d2FXeW5Xem10S1g5SUw2SnNudUpsbEQ2ZDRVQm94?=
 =?utf-8?B?bi9ibUYxb0p6STljUkpzV3ZtRWY1ZXpNMWZjeVRROHhRZjd2eGtDbHVVcVBv?=
 =?utf-8?B?SnFTOGJhZThLUFVmekgvMGQ5d1VDWFN6ZkhTbHRIU0VYcjJtZ2p2L2V2Tlhi?=
 =?utf-8?B?U2ZPTGNLMm8wbEllQUpuTFhybTRDSmxiVEdrd3ZLMmZmdERVcWNFRHNGemQ0?=
 =?utf-8?B?Q1hwKzlUaVdDVy9CbzU0amZHdUFLUVRpTGczc3FiVEFwUXY3V0pycDFINXdQ?=
 =?utf-8?Q?jKElq4AdDsuwZE8QOc8JivyO04dR7qDo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aaee1b-a2f3-432e-30f6-08de86a373d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:09:31.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7707
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227580-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kroah.com:email,live.com:dkim,live.com:email,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: B67F12DE664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMjAgTWFyIDIwMjYsIGF0IDEwOjMy4oCvUE0sIEdyZWcgS0ggPGdyZWdAa3JvYWgu
Y29tPiB3cm90ZToNCj4gDQo+IO+7v09uIEZyaSwgTWFyIDIwLCAyMDI2IGF0IDA4OjU2OjM0QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gVXBvbiByZXN1bWluZyBmcm9tIHN1c3BlbmQs
IHRoZSBUb3VjaCBCYXIgZHJpdmVyIHdhcyBtaXNzaW5nIGEgcmVzdW1lDQo+PiBtZXRob2QgaW4g
b3JkZXIgdG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgbW9kZSB0aGUgVG91Y2ggQmFyIHdhcyBvbiBi
ZWZvcmUNCj4+IHN1c3BlbmRpbmcuIEl0IGlzIHRoZSBzYW1lIGFzIHRoZSByZXNldF9yZXN1bWUg
bWV0aG9kLg0KPj4gDQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9m
Zi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4+IC0tLQ0KPj4gZHJp
dmVycy9oaWQvaGlkLWFwcGxldGIta2JkLmMgfCA1ICsrKy0tDQo+PiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9oaWQvaGlkLWFwcGxldGIta2JkLmMgYi9kcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQu
Yw0KPj4gaW5kZXggYjAwNjg3ZTY3Li4wYjEwY2ZmNDYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2hpZC9oaWQtYXBwbGV0Yi1rYmQuYw0KPj4gKysrIGIvZHJpdmVycy9oaWQvaGlkLWFwcGxldGIt
a2JkLmMNCj4+IEBAIC00NzcsNyArNDc3LDcgQEAgc3RhdGljIGludCBhcHBsZXRiX2tiZF9zdXNw
ZW5kKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCBwbV9tZXNzYWdlX3QgbXNnKQ0KPj4gICAgcmV0
dXJuIDA7DQo+PiB9DQo+PiANCj4+IC1zdGF0aWMgaW50IGFwcGxldGJfa2JkX3Jlc2V0X3Jlc3Vt
ZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+ICtzdGF0aWMgaW50IGFwcGxldGJfa2JkX3Jl
c3VtZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+IHsNCj4+ICAgIHN0cnVjdCBhcHBsZXRi
X2tiZCAqa2JkID0gaGlkX2dldF9kcnZkYXRhKGhkZXYpOw0KPj4gDQo+PiBAQCAtNTAzLDcgKzUw
Myw4IEBAIHN0YXRpYyBzdHJ1Y3QgaGlkX2RyaXZlciBhcHBsZXRiX2tiZF9oaWRfZHJpdmVyID0g
ew0KPj4gICAgLmlucHV0X2NvbmZpZ3VyZWQgPSBhcHBsZXRiX2tiZF9pbnB1dF9jb25maWd1cmVk
LA0KPj4gI2lmZGVmIENPTkZJR19QTQ0KPj4gICAgLnN1c3BlbmQgPSBhcHBsZXRiX2tiZF9zdXNw
ZW5kLA0KPj4gLSAgICAucmVzZXRfcmVzdW1lID0gYXBwbGV0Yl9rYmRfcmVzZXRfcmVzdW1lLA0K
Pj4gKyAgICAucmVzdW1lID0gYXBwbGV0Yl9rYmRfcmVzdW1lLA0KPj4gKyAgICAucmVzZXRfcmVz
dW1lID0gYXBwbGV0Yl9rYmRfcmVzdW1lLA0KPj4gI2VuZGlmDQo+PiAgICAuZHJpdmVyLmRldl9n
cm91cHMgPSBhcHBsZXRiX2tiZF9ncm91cHMsDQo+PiB9Ow0KPj4gLS0NCj4+IDIuNTIuMA0KPj4g
DQo+PiANCj4gDQo+IFdoYXQgaXMgdGhlIGdpdCBpZCBvZiB0aGlzIGNoYW5nZT8NCg0KVXBzdHJl
YW0gY29tbWl0IDE5NjU0NDVlMTNjMDliNzk5MzJjYTgxNTQ5NzdiNDQwOGNiOTYxMGMgaWYgdGhh
dCdzIHdoYXQgeW91IG1lYW50Lg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==

