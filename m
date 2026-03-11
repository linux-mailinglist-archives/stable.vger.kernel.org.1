Return-Path: <stable+bounces-224679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJF6AphasWmGtwIAu9opvQ
	(envelope-from <stable+bounces-224679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:05:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE326367D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 903E6300C984
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046F3DE45D;
	Wed, 11 Mar 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="sPreDZVQ";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="bK+JySr/"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1E3DE449;
	Wed, 11 Mar 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230637; cv=fail; b=Xed5UqQPWBeXKTirofvDXal+crDSe0xJO+iRmRQm21iZvZ9+c8pubkav0yfKNbgDNNdpPNCk64Dd7kEAIXrocwc/zk/NNU9bGrkz/odeBMrDfrfTIanbIn5EpAyyrS3zTrhjtbFOizFG5/y+wierW0zdg4U7MZeDP288zfG8PRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230637; c=relaxed/simple;
	bh=bY317GJuQQ8lxriQjDhsGp1trK6dn0CoScsu0wrdjyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zcodhq+0+DMefpxVCzHhoCUpXrDwxP4zDfyrOeDVNzz1Qw+VW+iK3rHwLpRortqvHhK6eOmsy3MibKGagrqAT5jo2iWZYddKLn5Sk8jZtJEaQJ6w+Et8ov+aHFXo9Ubj0iuu5JACvLEIkrnqGmg+RE4llTWbGCrOgJBSty0MzEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=sPreDZVQ; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=bK+JySr/; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5tPpR1393193;
	Wed, 11 Mar 2026 12:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dk201812; bh=n9QBhr5Ub8D3kXYgKjp9Pna3j
	1yCkxtOwwW/CD7DW/w=; b=sPreDZVQvdEekwcFyBwlYsMQykc2OomZ9EtVYuFWV
	NIsF+aVtT9YgYikeXEiMQO+DmAHjQGS4PcBmKooxuB88XOa/GlNg0ptFDXgIrunT
	CRzqXk5QY57+ME56QzybqeuJH2ZtTl0HTkzyWUA/0E5lVaQZlDi8wEZyMS3AIqQd
	EfWwY5l1pK/gnl9wywiNTyAkw3vFbneNswVM+YmTKF+cl8rszf1XrtwYsJuPe41G
	w60G7bO+gKObwJs4IESS7Vmirp4GTFwZmT7PQ0Zq+hxe+88K4WNi0IJ8WTV+jsgH
	7YQcCIaUSDG0dr02A4xKa9ee22X8L4sxBkUom9ewX8ktw==
Received: from cwxp265cu010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxyggfq5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:03:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAVHMnf/f9ZBYoCJc6uQDUol/AtzgjTx6126O9B/7Rj6BaFiQ4w2ykT+QckuIPOMukMlsRSAWn5OoV5UxX6ZXG9nROrJMwWzoW9QahjWsBZIZkWGGkAmfYAlijN2UC5sa9EZrMF/7OKR8o+s3zwMtKLJtm/tkvhd9OETNeST7NTUSM3KZ8JblPflQE3VDEdqrCSELQtC5DXDYk1au+KkOao4nuAB+SgZGPkzBPbfVk7NJJWKlHdP0l+6jG3Cd64glL1cz9+QBdEbIu1WV+CizVKJjHGBz/gH6q5y8xqykIV7yHydXy8jjzy2USLw04gFbNQA9FtySruVjkkLqv+9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9QBhr5Ub8D3kXYgKjp9Pna3j1yCkxtOwwW/CD7DW/w=;
 b=DIGmImCD2r/LmMnei37AlPdhT4OdARX0r0f6o0/3Rh1FzwKwy6OEeN9nCfr4BWMVAF/ujQpePjGsik6aDbufoLFGt3VJL3XawoiZ2fsPlmHMW5HKZ4Zn1VRVY3gBY4nfiOlDXps9jWS6gZySIGYK6rskq0fD5GQMdqczqZiEsPHZcvHPGpKgFCU1xIsrWwVcGblnQa6ZygdTUNgUiEfHG8Jp3Cz1CBy8F0+X81980XiJYKtInKC6J1Qnts4LovBjl8bJjndAZ/v7NraAdalMj98ijXEtTg5H9MMD4MsfDYwQecSwIQr940Iu5Ruo29RSIlM7PkxMTeZ8Lo5Ub1gpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9QBhr5Ub8D3kXYgKjp9Pna3j1yCkxtOwwW/CD7DW/w=;
 b=bK+JySr/+FCC1KC0C0DNQrSlCHqWiyyzP3xws8ds1oYhP+RQRj8tPzQAAPSIU+EIXc3PdTn0OexiiNdeOClzNX4nCoLavV0tNnxRaVV8ij55h6gsg/KxLbg7PtIRZ5P2SbMKZB5aYjjfIPWhveOC3sCldSSjbaWRsPQeCmosIng=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LOAP265MB9175.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:498::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:03:10 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:03:09 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Alessio Belle <Alessio.Belle@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        Alexandru
 Dadu <Alexandru.Dadu@imgtec.com>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
Thread-Topic: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
Thread-Index: AQHcr9jJ8dpOllmLFEqa2MDrK+RldLWpPleA
Date: Wed, 11 Mar 2026 12:03:09 +0000
Message-ID: <e6e362c5-c923-494a-9744-509bbbb3f814@imgtec.com>
References: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
In-Reply-To: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LOAP265MB9175:EE_
x-ms-office365-filtering-correlation-id: 0fedae24-fbe3-4a20-b404-08de7f662966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|376014|366016|18002099003|22082099003|56012099003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 i0DG//hYwNug2ujzODNqFU0EC7RC1oJTwr++xzXW8MAMcIzTAeNaUz6ptg60ALLFhnSO0ol3E7A3r5Sr2OtEQgvv6rY5l6ItJrGF6M4TA2cFz+h6iPpCEUJpMg3DuLTHBzm+DQ+SDXyq+fO71xBlSHpFS0I/qBmLXrW8hK9frCW6QKXNy6YfN3gxNpXoqfj6+xHrO6JmatMvfcvydy0zsA/GlAuLi/XHZ6cLjPQHiS59KndLp84pG8cM50DWS5D9Hn8sVmxfnG5zUNNkUwE9+KgKajNPe/fejnT6O7/IisjZLO4XMezzXi15FmETHCJ9G0e0/6lWUIygGwTRpDFzpJTjkqtP/AFJhtrMbY5KbotNvfvgIafiBmbCNDefqzCkzKi3BawKQ2p41qb0pehJt/ehOcZnfRijgd19++6IZCOHmCksvyhzVGIPdWEa5nW3y8i4AYnGYxtbXHboXzGA4Ng5GF8veXMfp9+5i9JNDCKG0+a1TI8houheQMPDrIU8F7qa4vg39QRh209hudbhA5/kTbHEDfm3Fp5gQOMqafM/1Oejzb8OT0gaCAg+PixKCC4vnE9gnQBwd3inaSoj3l/nkFess5Ig0EruVh7trAIBWoFZj5oVOVobvEQdfEha7zoAgx5vt/HSMbwDvxhOLy7osT+HchigTCAqsaXLGa2i5vTs8MGsErRxE3D+dW46BzTbUzgRqyP/HyTBXsiVJH7q9M0r/StOnvWg5Km2/U/wEZQajIUdjbSOE0m+pojllH8XqOrdWlE6f798YwS3g8j4gQNK+Q/SKU1xW3aIeE8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUowZkVMdXluY3FMM0xqOTlvVkJJT1kyV05ZaExoUFpqSzN0ZFl6dzlPSWxU?=
 =?utf-8?B?bGpTVk1KODB6QUNINHU4dGtWd1BybS9EZDZEY09ZZUNFQTl1dTJISnFnclBj?=
 =?utf-8?B?elRtR1JtdWVFZ0Z2NjZOTStkV3kzZEIvVTFTQmFGMnVVNWFlbGpOT21SYnQ3?=
 =?utf-8?B?S1B6WDhrbFVDUEZjYlJKSmpDbXFseXRDazZ4V0s2NUdlWnY4Z3NvRkJOZHFN?=
 =?utf-8?B?QlJiRGRjK1F0cExJNXJDZi9UYnY0T3llbWJoNWJHZTkrUFZSYm1NRHEzYk5P?=
 =?utf-8?B?NUJ4ZDNOSEY2bFVjNXFDUFF5UzJ1aHVRRkk4RHdQQmUyMGp2YjkzNmZ1b2ZB?=
 =?utf-8?B?UTREc1o2OFR4RVZ2T3ZWc1JEQjNJWGUxaXlwQllVOHYyeG9keU1PZE95Qzdx?=
 =?utf-8?B?SzlBRWF6WmhobytpK0FISFNWQ2hxQUlDQ0VSOGJ2T1N0VXZVUGhObmp4V1dS?=
 =?utf-8?B?TW1VYXU5MDlvSk45Z0RNQ0dkYTVCQ2tsQlVpVU1HSlV2K0h5VVpYbkV5Unho?=
 =?utf-8?B?enRvcGQvL096Vklwc25MOE00bHZhRkpaQjFSdC9jMXgvc0FTSDNHdENOdkp5?=
 =?utf-8?B?aEhnbllUcjFsVGhlcEUvS1lsNXRoOXJLMk05d0h1dHk4Q3IrdHI0U29lMHdz?=
 =?utf-8?B?SHU4dG11NWdobDZONGIwU2dFaDlmR0FLWm90dWdEQzdrU2N1TEd4OHdXOW40?=
 =?utf-8?B?NXR3dkxOakRIaVNPcUhBNy90OGRQK2pReW41S0UrZmZGdk04S0M2S2JMTzJu?=
 =?utf-8?B?WlMvOWtHRk5XWmhkencrQXd1enJEZ25zaWNWMU9MbG94S2xMa0lyazhTdWE4?=
 =?utf-8?B?a01GQ1Vra1FYVzJOVWpVTzZMZmZLcXYraURkYktQUkFHNG01eGxadHRKcmlq?=
 =?utf-8?B?Mno5MDJhd0RoeXRkK1Y3dCt3V01qeWJtOGFMU3NUbTdMN1FFSExkOCtjL2Mr?=
 =?utf-8?B?bFdnWnJ0ajRpbW44dERRd3k4eGJ0cG9zTzZidUducjlmNVhROGlVeFp5NHhC?=
 =?utf-8?B?SDhFeG5ZUHFSdE90Qkt3SVdWK0VxTUNIWEt5T1dxeDRuajlVQWZzZzkrMGZN?=
 =?utf-8?B?SVBhTW50OG1JSVppOURaWkpXdnZ6Y29YWVFvZ1VDYmRiaXMyZDB2dkhtN2lX?=
 =?utf-8?B?ODIyT3E1RGNvUjFFSHF1eDdjYkgyZnBJM1pOS1doR1hjN25iZjFvVVNCOGh1?=
 =?utf-8?B?RUY5OU1yZkkxOS91cU9KSHJhKzBBWUx6T2tlNC83Qlp3ZDdGVG1lbUd5dGZp?=
 =?utf-8?B?RDdnNFF2VWZtMmZlWnBpdVJvQUJsaTN2SVV6eEpJTGJIU05waGVWMGNjRUV3?=
 =?utf-8?B?OHllWXBKVWx5UGJMRmhQK1c3WndISXBiVFQzN0tLUmhod2FXeEhueGFUeVhR?=
 =?utf-8?B?R2ExQ2lXSjlvTDN1S1VsVjFkaHBnTXU0QTQ4a051dzlWKzV1eC9UMG92SWdF?=
 =?utf-8?B?L3NzTWVDQ3hodzc5RjVyZStEVHlINUIwNHhET0h6Ym85NFd6Sml0bmJsdS93?=
 =?utf-8?B?OVNaaTI5U2RROUoyZXA0MkpIMEErc2FGTTQ0YWhwajR3dEJITHpOSFJick1k?=
 =?utf-8?B?dGRqVHhsbkppRFBNVlI3UFV4ZktuRVJxenFlK2JuRmZpSi9ZdXRoZjAyVFJq?=
 =?utf-8?B?NktCeC9jb1BQUHBKNDdMSWhrdTBuTXpHbHFjdjdqVTBRUEZwL1dqMlBFc3Jo?=
 =?utf-8?B?RTF0aElBZEJpWXZaR3krZFlsdkRsbWdVNVJ0V2hPcHgrSUdZWWZwQnRQWmRH?=
 =?utf-8?B?emxBSVNQWmJWdDBhNEdVeXZjMkM3RGdmaTFaUk9NemorZHVSYVh4VUlBL2pI?=
 =?utf-8?B?VitqMG80c3pVWjB4ZXg4N2tUb1hyRUppV2d2NTRjRDVSRHAxNHVYbFlSbXFo?=
 =?utf-8?B?eEZWdk8wdStOOXBiYWNvRlBEK2F3dGJwL045VGNBakMwNGxkNktjSjd3bFZ1?=
 =?utf-8?B?ZE9pS29xK1cvM01kQ1B4OWVNbGRiNGRNZmlCMU41dGpIZXFDemd3KzhieE92?=
 =?utf-8?B?UWRBYmp2M3h4OWpPT1lPZ053SDlBZERHajJTaXA0ZDkyREpDb2tRSlgzeEc2?=
 =?utf-8?B?R2tEVDFjbHp4elA3djFDeGREYTUxSEtmRXp0UnZFdGpsekUwSVVxR29jV3VQ?=
 =?utf-8?B?SzBTVHNwMnVKU2EyeFZET1JBT3ZXRExGb1UycldOdFFkcU4zWk56OS9qUWpU?=
 =?utf-8?B?QmxwOE4xcEQyb2ZIZmY0RCtHTGgwa3hzWGd1QzJWYzhpTTdpbjV3cVBWbGFH?=
 =?utf-8?B?UUdFc0dEc3JSUzE4MnZmQjdPbjN2SGFabDVaTHZtWFpxSmpFY2txVENCTDU3?=
 =?utf-8?B?YnJqRHFFSUlVamRuNGt3Qm90NnNwVzJmVWIwVXI1RzBVbzhqMzFpT1lxTGdQ?=
 =?utf-8?Q?yue+DPNmyv7D0/mk=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------KgO6EPnnVc4ruYVmBbud1Zo7"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RZ38kFk7q4Ymfszp90XhCq+3OOrCy/8yFGq0RGsv+CERKpmBdTSe3LYs3+3NUAuDDI838en9E1KwpnWVKe3zCZBAsGs7nDYr2UwHfBtS75QiH5XrgCCMdSjejWFNc7Ir6PL4XxgwCS3FRV3L8UuBe4ajIHfMFYCGb4Qa5TczLJBhm9oHHnD3wICJhOKWftBzzlN7WzSN+CRwQnIuanF1hPTX/d6gouIPy3PVu+RVexK04RTp4QEf8kzQYezPP1DQ2JS39cP3jDUVePFv1X7Fiy7JoSvP25y3CrAXG4ZhoWWN5Q4g9SZka5pSYsb6WeKdeVUI5eJqBq4Vd2hncFeSaw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fedae24-fbe3-4a20-b404-08de7f662966
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:03:09.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8J3yu7RHTwvXa2mpwNSuPARpBwANiBNkQ6ajiCjCInxeeQpRGKQCEKkWjCi3RC3uMyskTDfea63TnIfQUB4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9175
X-Proofpoint-ORIG-GUID: UZ4JWH9ooEMx7F0P-ARVxpycfJMY6Q6O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwMiBTYWx0ZWRfX++pVKrGv6jgp
 swuP9iMouD9THO2AEKyrtHJR9omsNAn5DkuDbU2TgLODGHTcV0Zuo8Njg57Y7QwEDM98HN48WyA
 rbIBElgPzW+Z2urcx870suzNjYl4DkqC6chMdW2G+nlVqZw782opKvRpT1SR7drN+4gu6WmmwWN
 Xq497+lIXDtGZi5HdBGMavcNoNkQ6ooUTfQJdK9CFwmDDCLcSMuoVz+0S29d4zGGdYEKFYE1UGt
 DVdhdYEU41M5kdfvBu6Ns1MIirgQiPQ5ILAPey2+G6waCLiDcqkeX9m+/SRiaP8hIbYitjnUVRJ
 GoblWDqPXbM7GL0Xm3v9+b6uC4iGnFU1aM+YbZ/J6WlCZc6py2LEuL7oXIK++VY+chj+cjjd771
 YSguBuU+wr1hBOdAwRexso2y9Psuu0KGIcAqYRhf3v0Q3b9xuZcjtcqkoDE75E10V32uUfo7Bwi
 VybCb+22BMBlNuOZHng==
X-Proofpoint-GUID: UZ4JWH9ooEMx7F0P-ARVxpycfJMY6Q6O
X-Authority-Analysis: v=2.4 cv=NevrFmD4 c=1 sm=1 tr=0 ts=69b15a01 cx=c_pps
 a=6dENGP3aoEgAbR6MFKanVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=3oOJLAxtiLN628aBsBcA:9 a=QEXdDO2ut3YA:10 a=ehzd4H1DWepmrYmHKasA:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Rspamd-Queue-Id: 7BEE326367D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812,IMGTecCRM.onmicrosoft.com:s=selector2-IMGTecCRM-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,imgtec.com,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-224679-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IMGTecCRM.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,imgtec.com:dkim,imgtec.com:email,imgtec.com:mid];
	DKIM_TRACE(0.00)[imgtec.com:+,IMGTecCRM.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Matt.Coster@imgtec.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

--------------KgO6EPnnVc4ruYVmBbud1Zo7
Content-Type: multipart/mixed; boundary="------------9OhGmhTBfWoJTFuIiIDgSK6a";
 protected-headers="v1"
Message-ID: <e6e362c5-c923-494a-9744-509bbbb3f814@imgtec.com>
Date: Wed, 11 Mar 2026 12:03:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
To: Alessio Belle <alessio.belle@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>

--------------9OhGmhTBfWoJTFuIiIDgSK6a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2026 15:23, Alessio Belle wrote:
> The soft reset sequence is currently executed from the threaded IRQ
> handler, hence it cannot call disable_irq() which internally waits
> for IRQ handlers, i.e. itself, to complete.
>=20
> Use disable_irq_nosync() during a soft reset instead.
>=20
> Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructur=
e and META FW support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

I'll apply to drm-misc-fixes tomorrow.

> ---
>  drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/=
imagination/pvr_power.c
> index 7a8765c0c1ed..046cce76498a 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -510,7 +510,16 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool h=
ard_reset)
>         }
>=20
>         /* Disable IRQs for the duration of the reset. */
> -       disable_irq(pvr_dev->irq);
> +       if (hard_reset) {
> +               disable_irq(pvr_dev->irq);
> +       } else {
> +               /*
> +                * Soft reset is triggered as a response to a FW comman=
d to the Host and is
> +                * processed from the threaded IRQ handler. This code c=
annot (nor needs to)
> +                * wait for any IRQ processing to complete.
> +                */
> +               disable_irq_nosync(pvr_dev->irq);
> +       }
>=20
>         do {
>                 if (hard_reset) {
>=20
> ---
> base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
> change-id: 20260309-fix-soft-reset-8f32c3783d3d
>=20
> Best regards,
> --
> Alessio Belle <alessio.belle@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------9OhGmhTBfWoJTFuIiIDgSK6a--

--------------KgO6EPnnVc4ruYVmBbud1Zo7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCabFZ+QUDAAAAAAAKCRB5vBnz2d5qsLu7
APsHk49YrtLF9zQVDnOh36rdn3NGY/yfm/7p7OkIP+didwD/Q/tgn4GMk31Yk/QC7u8qd8yutAK7
elIA2j18yOGCyw4=
=Jfve
-----END PGP SIGNATURE-----

--------------KgO6EPnnVc4ruYVmBbud1Zo7--

