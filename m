Return-Path: <stable+bounces-67732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D8952780
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7C284D10
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6333D9E;
	Thu, 15 Aug 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="thbFrPtE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F18Mw5JR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MTrPct+a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8364A;
	Thu, 15 Aug 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685229; cv=fail; b=HQ2mMQm4+IE9kJV2CdKA7oaAlZvdckwKG6LyYTWNy1ppBnA9b64PJlX8OzM5BaKyz0Q+QFd4i0qaP1TVzb0fAypCRhBqM/XQDac/JzT8gKztg1tpH9fCB13CtcwiodquOOomisZ8cj8ja/+DZxgD04pySG186HJwAIRqC0wHcy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685229; c=relaxed/simple;
	bh=qeJQRUK6BgKdHUXgWL0yP8tPiaia4cYUKKrbySzFX30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dXLjY3NA6iegG80rf8LgNThToakFR3JpUAQ14uqcQc2b04+ChymhFy8CdkN4J3o1sfh/Lo8gM1OdsMUvMH1LfYbyqtNZ5WdHuu3XiYEqGjXlqyuVnMpzv6tMmvZvPnOUt73/pjqwxgAwUvDlUhlQJWApWQRk6wGYFIs0MwdHerg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=thbFrPtE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F18Mw5JR; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MTrPct+a reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHxu7Q015948;
	Wed, 14 Aug 2024 18:26:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qeJQRUK6BgKdHUXgWL0yP8tPiaia4cYUKKrbySzFX30=; b=
	thbFrPtEUeE6nzehN8AbJJFY867Izff47ogu1EHwN0yPaY5L0+Zd7zcr6R0f4EQQ
	kFo45ppC9K9MwHSp9OvdtLFZK10KFnatk3Zzn2TN7LA7LvuHyW/J6n4yMIU+Sj06
	tXB/V4dCHw+ER1WKZyuPVJ0Hxytv3/dhO/ZyhyAzIfHvl8fYqZcxc7IGTrSWis00
	uahAbWBcKieoTaKjRUe19Yo0Dz3SmwwOQU1FsurkiV7sqAdhIlpYmYMocRTFVj0m
	Xeup1kV6VU/F5AAIXe+eSCaJ8Ljb+ffNKGIlgFWA2pNbPd57ifvK6RG3dVbvWP+q
	iFKITg8xa4ZKrOix2+yzeQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111fhheq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723685209; bh=qeJQRUK6BgKdHUXgWL0yP8tPiaia4cYUKKrbySzFX30=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=F18Mw5JR5rlA1f0CYVfhAepvoRi7WVszxg7TOhvOEs9jachycAlYq7a8hHCSWLtQ8
	 cbUeCWD3sMR5lk+l/pIy6pfGr8wDxc9uIzZKJjntb89OFjB14Pp+Zi8VQq3NqUJlJH
	 m6vrIGoE03F07lCZ8hjl41TgZQ4m5BxEOx+Cetj5xDlnx6mv6aZbx6B38ITHO1IZYz
	 UTgm4YHPXm14e/nhGyg7Z0MqrmYF5uyQfFSuP2eLY59GyRv/DO/tPUseKhwN5ezEkm
	 +oD80NxiDgIm3Ul0l16qTgREoKEQzntjU8/HlARYPhphbYM2nNLEPTlLBnCIhqx7sI
	 ezQTEAa4dnF9A==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8DCA540147;
	Thu, 15 Aug 2024 01:26:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5975CA0079;
	Thu, 15 Aug 2024 01:26:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MTrPct+a;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A68E840149;
	Thu, 15 Aug 2024 01:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVxor5i2lVyIeTtapWV2d+PLYOdOszAS8+qyGKulxevJWoCckXX6nMiEoUaTLOc6mWWcw5AWO+vnAeefoicm8KKZ/MSelEhx1pVxifEMa3b7GsW+pFZjXAghTbZilBaIA4/Qwcal85hDRia08zcMAZQcli4xmLLwMmLLd7nFflESLdaY4IUzz+/9L3g5d9JyoMk4WIkKmwQ2A8qhEjIwMUMp9cy8vANGGkJ84kw30FVbYdYnw8FC/EmhBB6IkYH/fpFdREKCTE6eJLmTI4STqwtIBGuo54LAxdntwn7gKAvhtGxmoalNvT4N7x3oh/woBuDydfTLSAA1Ki4GhKMQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeJQRUK6BgKdHUXgWL0yP8tPiaia4cYUKKrbySzFX30=;
 b=R6cN+ykzySgdJVCdLEglcmvpptPLr5+33EV/jx3rZ4HuwgRxWyC6aloVCrMGZK8BGt4Qd4CsV6ld0FIJ/6MVG218inIcyw1YHXND+whs7az0Tu2GY0J4RDY/M92OYExbd041So3GAPLAENfXwA2GKpP/d7XO9YLIPVo/qVL2Hro0vvzw0SoUjjBONtbFgKtZWvyIcsRVJad3ByVTbGP35fRZRjyOI137QIvdFmDMbIPB12dhzcvAWDqp+23SdF+vz46ZlFXfaqtJOfPt/UMVqFEOGIhmq4+u4gztYDS2I5K0y+RKtXZtZGk/TZgWNvTAd/J7PgC0QRPvBIPo1sbvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeJQRUK6BgKdHUXgWL0yP8tPiaia4cYUKKrbySzFX30=;
 b=MTrPct+auCBbqEpqRgosbSx4iXvPgI28LlkAcFbNEYt4091NUaNYp1w9jR+aZ0ZUn6AlOtKUZ3obCz4qTlOCLHJsz4uwgO78KsiZboP2O4ltsMbotNsvYUlLnmMmBhoNbTveHoe0ILIbDONwTjm+VGKUENqSJM2jYaQyZVkVnA0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 01:26:39 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 01:26:39 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Sergey Shtylyov
	<s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Topic: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Index: AQHa7nDk1dgqkywC+0uFNhKLhSI/DrInN/GAgAAAeoCAACDLgIAAK+MAgAACWQA=
Date: Thu, 15 Aug 2024 01:26:38 +0000
Message-ID: <20240815012634.c5dw7neyfyly2nuo@synopsys.com>
References: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
 <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
 <e26d660b-ce53-6208-d56b-b33a1d1b22be@omp.ru>
 <20240814224105.3bfxvq63zpa3gjzv@synopsys.com>
 <20240815011810.3bwdhmckcuhtimbu@synopsys.com>
In-Reply-To: <20240815011810.3bwdhmckcuhtimbu@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7162:EE_
x-ms-office365-filtering-correlation-id: c831398e-8442-4fa3-9eda-08dcbcc94fa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmtnUTAvb3JUejFXM0lCVklic2xGek43QktoTEl1Z1VhRWsxb2FiYStiS0FZ?=
 =?utf-8?B?NGNoUmdidlVWMEJzMG4ydHMraDRyVlhNOW1zWUZiclVQVVllOERUSXIwRGFn?=
 =?utf-8?B?WXBac0JpTlhaR3ZMQkZoUlNxMnFyWTB0WThJOFNma0RENlRLR2VpOFczNkhX?=
 =?utf-8?B?Nkc5dGFNNWtvaHNFdk15SDZvTGhlQzI5TlI4dGdmZHlzQThIRXBnT2dIN0JW?=
 =?utf-8?B?bmJwQ3FMY0wvUWMvK0p5ejBadzVsZzZ3d1BDTnp3M3c5QWJtSWZKYlUvWkdH?=
 =?utf-8?B?aU4xM0N3aVowM0xZaVFheXBpVnJ1TlJzcmFyb3I5YnliRDRXWkhKOHRmVmxP?=
 =?utf-8?B?WTM3UTBUQ1VlM2hIU2loS1R4R2IzMFZXaDE5NTRUaDN6WGlpYWxJL3RFMG84?=
 =?utf-8?B?R2N2NWhKbXFSeHlKMzc4WngwcjNJQjB2R1dhZ3RnejFveVQzdUd0QVpHMmxC?=
 =?utf-8?B?RE44QmRNM2pzVlFNNGhQbU5manVBNG42UkFDd0Z1aE53NzJkR1lwR1NDWEJu?=
 =?utf-8?B?aWpGVXA0OTVRSXFqTEhXWVlzdEllTy9nT0EvdTBFU09WbC9RUFZ1MlJsT3Rn?=
 =?utf-8?B?UURTYjVRakxSanN6VEM0ejg2MGRhaFFlMCt4Mk5sYlJiZElUQTEzQjZ5TWo5?=
 =?utf-8?B?czBGVS9BMy90RG1yandtWXAyQXRtNEVBSlJxY2NFT21aaUMvU2Q5L2FrYTJz?=
 =?utf-8?B?R3BEYTBQRklCYkJBditCOVRScjdQeTFVZjl3bmlKNHZkQmxPWTdnZnZXWUVO?=
 =?utf-8?B?Ym9hTDhhT0pWZFJxdHZmcFZSNDE3MmhMenp1ZC9wQStNVys4MElDQ0ZJcXEw?=
 =?utf-8?B?aitoTkxiT1gxRmdFVDh6dUJHT3dqWWNZYmEyYThxTU02aGdwSEtrQ0pDQ3ky?=
 =?utf-8?B?U1NYcm1TWU55dXI1b2g4cS91Qlo4c0k1YXZ1N0dqc08yZjBMOU1CeE44V2o2?=
 =?utf-8?B?QkFhSjdjYm1oclo2VCtQeU1EaWNsSjBQVHVJTnhGM084VHFlSnp6bSsrTTN3?=
 =?utf-8?B?eXdycTd2ZTBmOW5ubk9zbVlaaDBjaVZoOXNzSFNlUFJCczJMUkNOeTI1Q3NQ?=
 =?utf-8?B?azByOWt6cXZZZnVMZ0ovWGdPY01LMUsyVmMvU3AzRm43S0xSYWVjTGdjNGR4?=
 =?utf-8?B?eUF1Y0RPWjBWZDZCTmRvRUgwamRtZnFMSHJKSU5IcGlQaUc5SzhOb1plaFhU?=
 =?utf-8?B?UVFSQTlMS3VNWEorVXp4Y3daVFZ5UXduRVlSb1V5cFk4ZGhwdUt5eXlvR3ZP?=
 =?utf-8?B?TzU3VXdOeEJoVDJYQTZrSHgwblp6aUpkVngybnJDRExFUVE2Y2dJVjV0U291?=
 =?utf-8?B?UHU5bVpSU2dHSENQc1NscVFDRUozak1CakFSYzJVMmRjbzI3VDBXVTdNbDNy?=
 =?utf-8?B?cno2TjFvK09vdUxnTzZ6MkloUFFiTStvTG93eUFpTzNMY3Noc3pGTDA0K3Mw?=
 =?utf-8?B?SlFVc0JVR0FJY1YrdkkxdEMxUG1rN1JaUnorQ2RnRG9VOFFseWs3NUlTbVgy?=
 =?utf-8?B?Z3hEL1RJTGhUNDlkWVp4RzRiVnFlUk9WajFIaVI4ejk2akVPV0I1ZUtKY3pi?=
 =?utf-8?B?MHhhK2tpMHl3bktKbDZQQlp1ZStJWlR6OVZSOHdRRUlXYkk3dHhvb0Q3RVFG?=
 =?utf-8?B?QlFOMU4vTTA4K1VZY2M5SGljUmhaQjN1NzNtRHRMU1pQc3lyK0RvbUg1amVT?=
 =?utf-8?B?UVBlUG1yY1I5Q3M5L0dPaEVnV1JqSmN3cDRQNzZ2eFh5OUo2bzBHc2hYQWdl?=
 =?utf-8?B?NllDQTFydFdmMHdVY2Ryam1vUm9KRUdRSXkvcmxWMXFaenZjRmJkQVVsK0xv?=
 =?utf-8?B?ejZIL1Fodjg1bjIzSmxyMGNWY0dhMVRRRlVsT25VUWY3blZRajVvaGF3UWFy?=
 =?utf-8?B?T01yVzAwaUExY21PbVJ6dWtPSmN2YjduRVJxT3g0b0tFbHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnBGeDVnOXdWMEJ2dXZuemlWWUEvQ2hUR0MzbnFrT2VZQ1BBQWE3eHYvbDJO?=
 =?utf-8?B?eVI5U2dKeTlWWEZ2cUZNU21XUkZrM3BTQVZEdG9jNnNjSlpwU0trRm42dGl0?=
 =?utf-8?B?YW54MzdPWGRxUzdnbGV3RG5aM0lPTnRlNmZpVGFOTDhPQ2J2ZVlnUkgxSEw1?=
 =?utf-8?B?emNud0lGaXJRNWFzSFdhR1FGODNBZFFTTTFmcjhvSzZPUWJ5MDhuaDhHZEIz?=
 =?utf-8?B?UlVodmZRVFovbWJaSDZYWUxtbjNLQVdXbG1RVUwwYU5GZnpXQkxuSjVrSEFY?=
 =?utf-8?B?R2cvbFd0VkoydnJFNHlnejltcllIMDU1MGJ4Y0M1V0F1V1hPVzYxM1VSMzNE?=
 =?utf-8?B?eVduNWpqY0puWjlEeXRNTlJsSUlTallNSktaeHE0aXlWazV4OXIwL1Q0NWI5?=
 =?utf-8?B?ZnFqSUQ3eno5UGhtQmJYQStiTDNONGVkeGhreG0xRERtOVA5ckc1bFpPdmJS?=
 =?utf-8?B?MHpKSHA5Q2pxTVg3bWdaWWhwVW52SmNkQ0gyRDQzZjdlMXdibWtmK2VFZERT?=
 =?utf-8?B?bWFYa0Jqc0pOQzljZFlHRDJFcGNqYXp6NWphSW5pUHRoZFR0KzdjR2p3L2Na?=
 =?utf-8?B?OGdWUERxVWZWeWhyQXFGNXdmNHk4Vmd0TWdaOGNYaGpTR3dlOHR5dk1rOEFZ?=
 =?utf-8?B?VnZ0bmlDYlBDNW43ZGcvbS9Rd0Z2YktDMW4rMVUvU2x6VERzNzJ2STh0NVhk?=
 =?utf-8?B?c25IV2FlNjV1QmhTYVM3cFBCY2Vob0VNL0pwU1Rxd2hSR280ZWtTcm1udEhm?=
 =?utf-8?B?bERCa2JHYXpXTEp6USs0ZGJ0ZE9LZ3hHcUdoaEtremRZaWJCV0kzbmdEajhO?=
 =?utf-8?B?VVAxT0x2L0VUcFlQODBPa0N4dm5iN3ZuWUVaZ1ZrVndEWEJuWnlWNmhOUmNt?=
 =?utf-8?B?Z1JnRTZnNDZXLzI2c1dWWW5vMUtwWmtoRWFPNGh4eGFQa0FyaWhDVnZvQVg5?=
 =?utf-8?B?bXQwR2c3WW1GSGs4TmkyMkFabzB2ckFTRmVIN1lOTE96SUg3RGhMQzlKQUJy?=
 =?utf-8?B?dWVtczJrNitWcXZkUzNTTWJ5V08zRmdoSXRnN0ZjdG1Wc2xkS1RxeDRNTkJz?=
 =?utf-8?B?aitqMi9jMTlmWC9vZm9wSUFYYm8zUUdsQ2RtY25weW1mNVdmUzgzdzljMG1X?=
 =?utf-8?B?RmxOSFVqMzFHL1lpaFB6UFhaTFc3ZGpQR29XWlM1c3YvT3VmekE1bVRzejZ3?=
 =?utf-8?B?U0l0Y2ZQMEtTL3JrMmt0VTdoWFZYMEhVL0NmdWVxYmxsL01UZU5NdUx6U282?=
 =?utf-8?B?NGlNQ0s5dnJBODJFdUduSHhiaWk0emhta25ibWpCNDQxZHBQUTNJaWIvZWxu?=
 =?utf-8?B?TXhNeDNTRk9xY01jb1U5eXZJQmNYTnNJd1o2N2dLVXdYRmNFVTg1RVBjRXRY?=
 =?utf-8?B?WmcvVFNoRVFSeEE1QU00Z05JK0JubGxZc1ZqbFNJQU5CU0NnTjlYdVhEVFg4?=
 =?utf-8?B?Qkg3TUYyYlQzd08wZXlENXBlMUN0RHFtQWxwV1NkT3BsdlJROGlJZmFYQm5C?=
 =?utf-8?B?azMwNDFQVFlLMWFGUU9tdUpyN2FMV1BaV1U5R1ZVOGEzUkRwV21JVHA4UnJy?=
 =?utf-8?B?ZUVYM05kdzkzSHN3RHBFVmNEMkd3dnY2Rkk5NE1NZytEM3pKNmE4dUlKOXdP?=
 =?utf-8?B?Z2JSVjY5WXpxM08xWXI5VGR4YmovNHB5b3doejNOZTFnSURTQU5SSVRuWFVC?=
 =?utf-8?B?ZFAxTVRuT0htaWdEcEhGaFJzRk03bk9FbkJuY2N3c3BqTkc4QTdhOE14WTJG?=
 =?utf-8?B?ZWV0LzBwRjZsTGU5VlFFSVRLMk1oTmt2cEo4R2RQdWtJaExWbW93d0FTNzdL?=
 =?utf-8?B?TG1ycnBxY3pRa2NYRG5PNzFDenBpTWY5ZXhtcFNoRjkzenhUTUlxcEo3blMz?=
 =?utf-8?B?SDhSZ3kyeUczMnlaMytnSVlpN2FZM1lmLzVqOTVSUXRXOGJRYTZRU3dpbkNX?=
 =?utf-8?B?NlpIL3o5ZXpWa0FuSVowZkExZXE4VFhob2kxSTJUQTFNWng2MUNkMzc3QVZq?=
 =?utf-8?B?bVYxWXdwTXU0L2F2eS9CZzZTL3hZSE8wTStDbjFzeFdjTm4yTUkvY3M3OGtJ?=
 =?utf-8?B?SmhFd2liYkFkeXgrTXdqUmFGanlFbm96YjVUYi9UOE41NnJrWlNNOWUxNWhI?=
 =?utf-8?B?STlrc3dmaDZjUGNLR2NFWklsNDlZZDJmVEZvU3Q4WmpXaFUyMG9EenpTeGM3?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C60294A1D3CD46A49E277AA36DC400@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SAFKjuNxwj8NG9eNK0ONXVIPaM/b8ccFqw4fXftE64i6W11Jtcvs/NVWwV4vXsvUDpbgUNZzi60o4/JlJhHRLQqnGueb6DNzg51XMk8MA9askJLdBq9D36/ElvYUASbTxDfkCTCGQdvaC0cMABRJLpGQn3lKxSFg+DY3/aY5qeVW+0EWmgq3fXKvV98Ll8aymJJXxaXgIWo9IouXdSWwXduUgzfcLf+3tX+wPwkcOw6b6+yrQnmTKunYyIXvO76Cq1nWCnVe/ClkXV621YAwrpuKJl4LLMZFOjG2YRWjr0odMPRPdf7gmXi0E+i2z1CynRzj/jT8KmxhMyPGrhrwtFHM0vXkHI/LQth9jd66RGVQviu+GgrZHmnZ0SgSMJzSrOYnVMhvOX0i9aSEgyLt19L/2jnUB/cF7YNPNgNIPYjbDPAz5/ck1bIIQMq7D2KR6iJApiYJ2HR7qtQ/q+7BOgnFOKqLDMFjdqIaag1UTqCr5020Pd39KWyhDAoUv13pHPcKvChFDfmaVurEFSlQDrorzhxxv7QNlbNgj8tK6JwrayaSY3VWEL1/FDZPUC5D4Mt8leKgp2wz0vBCZmoKPLmJFQTMmEHBwy3hMVBEI8WwFKSaTZGjhZLKcQReicjcQlk1vJKRsUi3PAK5NWmpBg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c831398e-8442-4fa3-9eda-08dcbcc94fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:26:38.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUdVEYc9twdbETYXYUKmxjH+XzcXiAPyaI9HYcNP0evJ2aEfc5sfsWNFMHkUpNuOmXYaNYpnziLbpF8pmRH4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
X-Proofpoint-GUID: OZoLFOwgF8HBFyfMkNJmlTUWHN-aD0g3
X-Proofpoint-ORIG-GUID: OZoLFOwgF8HBFyfMkNJmlTUWHN-aD0g3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_21,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150009

T24gVGh1LCBBdWcgMTUsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gV2VkLCBBdWcg
MTQsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSBNaWNoYWVsLA0KPiA+IA0KPiA+
IE9uIFdlZCwgQXVnIDE0LCAyMDI0LCBTZXJnZXkgU2h0eWx5b3Ygd3JvdGU6DQo+ID4gPiBPbiA4
LzE0LzI0IDExOjQyIFBNLCBTZXJnZXkgU2h0eWx5b3Ygd3JvdGU6DQo+ID4gPiBbLi4uXQ0KPiA+
ID4gDQo+ID4gPiA+PiBUaGUgRFdDM19FUF9SRVNPVVJDRV9BTExPQ0FURUQgZmxhZyBlbnN1cmVz
IHRoYXQgdGhlIHJlc291cmNlIG9mIGFuDQo+ID4gPiA+PiBlbmRwb2ludCBpcyBvbmx5IGFzc2ln
bmVkIG9uY2UuIFVubGVzcyB0aGUgZW5kcG9pbnQgaXMgcmVzZXQsIGRvbid0DQo+ID4gPiA+PiBj
bGVhciB0aGlzIGZsYWcuIE90aGVyd2lzZSB3ZSBtYXkgc2V0IGVuZHBvaW50IHJlc291cmNlIGFn
YWluLCB3aGljaA0KPiA+ID4gPj4gcHJldmVudHMgdGhlIGRyaXZlciBmcm9tIGluaXRpYXRlIHRy
YW5zZmVyIGFmdGVyIGhhbmRsaW5nIGEgU1RBTEwgb3INCj4gPiA+ID4+IGVuZHBvaW50IGhhbHQg
dG8gdGhlIGNvbnRyb2wgZW5kcG9pbnQuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gQ29tbWl0IGYyZTBl
ZWU0NzAzOCAodXNiOiBkd2MzOiBlcDA6IERvbid0IHJlc2V0IHJlc291cmNlIGFsbG9jIGZsYWcp
DQo+ID4gPiA+IA0KPiA+ID4gPiAgICBZb3UgZm9yZ290IHRoZSBkb3VibGUgcXVvdGVzIGFyb3Vu
ZCB0aGUgc3VtbWFyeSwgdGhlIHNhbWUgYXMgeW91DQo+ID4gPiA+IGRvIGluIHRoZSBGaXhlcyB0
YWcuDQo+ID4gPiA+IA0KPiA+ID4gPj4gd2FzIGZpeGluZyB0aGUgaW5pdGlhbCBpc3N1ZSwgYnV0
IGRpZCB0aGlzIG9ubHkgZm9yIHBoeXNpY2FsIGVwMS4gU2luY2UNCj4gPiA+ID4+IHRoZSBmdW5j
dGlvbiBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydCBpcyByZXNldHRpbmcgdGhlIGZsYWdzIGZv
ciBib3RoDQo+ID4gPiA+PiBwaHlzaWNhbCBlbmRwb2ludHMsIHRoaXMgYWxzbyBoYXMgdG8gYmUg
ZG9uZSBmb3IgZXAwLg0KPiA+ID4gPj4NCj4gPiA+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPiA+PiBGaXhlczogYjMxMTA0OGMxNzRkICgidXNiOiBkd2MzOiBnYWRnZXQ6IFJl
d3JpdGUgZW5kcG9pbnQgYWxsb2NhdGlvbiBmbG93IikNCj4gPiA+ID4+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgR3J6ZXNjaGlrIDxtLmdyemVzY2hpa0BwZW5ndXRyb25peC5kZT4NCj4gPiANCj4g
PiBUaGFua3MgZm9yIHRoZSBjYXRjaCENCj4gPiANCj4gPiBJZiB5b3Ugc2VuZCB2MiBmb3IgdGhl
IGRvdWJsZSBxdW90ZSBmaXggaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB5b3UgY2FuDQo+ID4gaW5j
bHVkZSB0aGlzOg0KPiA+IA0KPiA+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQo+ID4gDQo+IA0KPiBBY3R1YWxseSwgcGxlYXNlIGlnbm9yZSB0aGUg
QWNrLiBQbGVhc2UgZG8gdGhpcyBpbnN0ZWFkOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IGQ5NmZmYmU1
MjAzOS4uOWIwNjljNDY2M2ExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTIzMiw3ICsyMzIsNyBAQCB2
b2lkIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAgICAg
ICAgLyogc3RhbGwgaXMgYWx3YXlzIGlzc3VlZCBvbiBFUDAgKi8NCj4gICAgICAgICBkZXAgPSBk
d2MtPmVwc1swXTsNCj4gICAgICAgICBfX2R3YzNfZ2FkZ2V0X2VwX3NldF9oYWx0KGRlcCwgMSwg
ZmFsc2UpOw0KPiAtICAgICAgIGRlcC0+ZmxhZ3MgPSBEV0MzX0VQX0VOQUJMRUQ7DQo+ICsgICAg
ICAgZGVwLT5mbGFncyAmPSB+RFdDM19FUF9TVEFMTDsNCj4gICAgICAgICBkd2MtPmRlbGF5ZWRf
c3RhdHVzID0gZmFsc2U7DQo+IA0KPiAgICAgICAgIGlmICghbGlzdF9lbXB0eSgmZGVwLT5wZW5k
aW5nX2xpc3QpKSB7DQo+IA0KPiANCj4gV2UgZG9uJ3Qgd2FudCB0byBjbGVhciBvdGhlciBmbGFn
cyBzdWNoIGFzIHdlZGdlIGZsYWcuDQo+IA0KDQpVZ2guLi4gc29ycnkgZm9yIHRoZSBzcGFtLi4u
IGlnbm9yZSB0aGUgYWJvdmUuIEkgZm9yZ290IHRoYXQgd2UgY2FuJ3QNCndlZGdlIGNvbnRyb2wg
ZXAuIFdoYXQgeW91IGhhdmUgaXMgZmluZS4NCg0KVGhhbmtzLA0KVGhpbmg=

