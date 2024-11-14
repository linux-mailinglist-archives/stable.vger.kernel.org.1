Return-Path: <stable+bounces-92966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D409C7FA4
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 02:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A592228227F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43C1C3314;
	Thu, 14 Nov 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lddyi49Y";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FeIdQMBv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dsKJPNl4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C01C303E;
	Thu, 14 Nov 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546136; cv=fail; b=hm6GKmX/TfqHivfjjSoANUp1NOZLrtRvpos+IxpcjNiPQDMtGXaAZmov/PUEPChah2gRPggvJwUTzHLSG2iXJxXARP4E5ljmdYfGvn1NwTwXFo8v2GJbqymGPt36/e3MtWxIn5PnEKFNpGvJ1OAa0fxuXqZ5lyJw/qv/z+ZBTQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546136; c=relaxed/simple;
	bh=vF8xAE3kbhMFywODSXu4N3bIjEgko0JKNHmr1dGRHSk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=itWwp6uoT6ZGyaxJVp3ZZ0cj5Eo0ivk2lRWp/PvAPBUWwZUqoz3mKLIWvvA6XCC6c+6NFbK/o6eBCc1CbAcyv96sootzGICdH+e6wqxL4PDMr7W04pOsQgkGuaL5Md+avwhVesP5K+my5XnJuuqVwJiNJFRZhnrk3rackBskGis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lddyi49Y; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FeIdQMBv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dsKJPNl4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADI9GpL013141;
	Wed, 13 Nov 2024 17:02:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=Oso1e2Y1i2GQqMJ6z5R
	ERt2gbzC1De/7UJCGXxsbMis=; b=lddyi49YIM6+m90CYHrtzQ5g1T9YnRddTK8
	rgAe55t3cK+WvEhsWoGRgcNlY98rWIX6JDRftTMuoWMZ0tWgWBSk0kX8F0lRfPZg
	qS/aUL2+UZHszieGbI4o6jJBv19newfd21XBc7mL2lZFQKH7fBJjDcn0/0YKdNHt
	lIQj35EJkq4p9tkNycdowSFS7lnc/DjXDm+bpQgsKYUlvZkDbyy8ZZp/EDh2QaAO
	WPI4ZgB0SuFF/E/KJWwRs8m9YTBkQnDY6aARvm1EwKUXqxTuPFGVNYaFToRxU9m7
	jBwDrvG1WkVTNKBRCgFT46iNzospLW1zlBxEBaLtO3dSmnqxvxQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42t7mu9yt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 17:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731546125; bh=vF8xAE3kbhMFywODSXu4N3bIjEgko0JKNHmr1dGRHSk=;
	h=From:To:CC:Subject:Date:From;
	b=FeIdQMBvmraQ08A3jX8AVfplnIzdIEc4B3W+pPBGaG5xfU1vM5HwrqtnH7z2rhK3Q
	 T96ABvZFPG//AwQi5YG8ZWMzy0LJKgnHwfrr5iyBcBx72y7SY9nE9sKMlEgL0A+9Ph
	 DwPlSCfSFnvql/UuMxT9+sopPMNpS5JRVz/msz6tYKdi7+ulo5C3C30XAKxuOAS8YY
	 f2baXwKlhtwvi5Oh2TE7j/xAsmtsVzgliD8srzdwmYjcaiWxJgP4R3r7IEl23QUiFh
	 xrzhOS+Irc2b+6VnGyXRmEEHeFQCc1oXfgcaFoQIp1iiwgPyv+VAykANmJR+I4jFlq
	 VgZQO5wxeHx4Q==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A03940147;
	Thu, 14 Nov 2024 01:02:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id F3D39A0082;
	Thu, 14 Nov 2024 01:02:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dsKJPNl4;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4B93640114;
	Thu, 14 Nov 2024 01:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgbViz/F6Rw15wuytutZDEmUgG99RhlqO0KsdNl33wn4+WheQeFIi4q8x7Ovonp9y9IEli88fnyEZk2q/8aiKvflcmjC9e0biAsvzk98p5y5vGCmXLT2bUbwZLQKmO1T00zX5790O9lK4qJpMbk427qDjatDjWwt2WTOZ9y6ZALlSHqXFTBKsrZtQruDZorBaZC6NNMbJYzHJx8byBJTtna5+rkEL9mhJH1E2dfb3W7H3WzxOHLwsfAUofPOJTBz3NCrlNrItXsbuq2Cr1N5mOElYHLfucz6vqMKuIal6XWJYPcC3l2Qp813oZSCl3uEnmWKgTSymqUYFU5mG+4Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oso1e2Y1i2GQqMJ6z5RERt2gbzC1De/7UJCGXxsbMis=;
 b=QVdAvQqvyP4lXWM5gL63ZEqIWkHkO8fGqRjItq3RS+VMXXJnNCTyEyLKcChxRjNjND52acOSOXkRSvqoLeVD4YV2zvgKUs5ROf5B1OSVCsxo9431sk2NuslN/HDgwP3MMYdF7IC+X8wQf8DjPwoc2TFAgqf/HtGfRVokauKgnrKbGWAYxPFOAYh4+8nrqo8O/wU9C3pxmJv2B9Kvrti4UgeQzfjjQ3FaG3447QDPRw1X3NLp0Ahw/4caoY5YamC0oT2JKI+q7vpEn9t71+Fz83N+vowcb/cFfRn5HAeNJeuqyPpto/OOyJZDhTZRgusHOpkF5/CCtaWX4hqkQLIBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oso1e2Y1i2GQqMJ6z5RERt2gbzC1De/7UJCGXxsbMis=;
 b=dsKJPNl4DEBUGC0fCCtrYhQnqhLYq6uMLzMpW8pV2i9Vmo30MCTZ3LND7nKHvOVm5hsX0H5vxMbnc322/ifKIxMR2TJPWZYcgRN7O1593YWpUhCFbNdJ9dNu8BiJGaOevlP/ZJT4mg4qmN4nbxFM1HjRHRGxEA+IPMtaS58fX1o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 01:02:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:02:00 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 0/5] usb: dwc3: gadget: Misc fixes and cleanup
Thread-Topic: [PATCH 0/5] usb: dwc3: gadget: Misc fixes and cleanup
Thread-Index: AQHbNjDPRIE0cRHxyU6aUg0i0NCc2A==
Date: Thu, 14 Nov 2024 01:02:00 +0000
Message-ID: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7950:EE_
x-ms-office365-filtering-correlation-id: baca0994-afce-4ebc-58f0-08dd0447f1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?j8TUZhG/yu6nBJfyRCx/qVwGMz/tZwS61+Tk09jMdUuSOZbDkPKPjGM9QF?=
 =?iso-8859-1?Q?E2zaFi4l3ny4902g11Wr8pFp6jucTPcEzO6KOI4xbucUkR4tR4iYA6tgmf?=
 =?iso-8859-1?Q?PQ0/9LfnMrtOyN+Ub0TTmlz2tDicjDBzMohIkZBktui+/pRxobbLzHsf4O?=
 =?iso-8859-1?Q?Z70wAwoAzsDZms+psTbvawDcknsdR/em6m3muXMZN5rGAOKzrSxJDEV5RZ?=
 =?iso-8859-1?Q?sV7C5JgN5u1c3PCMoJAUv6S/WxC+aPZaQggF6OcDRZEj+NUUU565P2iHfH?=
 =?iso-8859-1?Q?ir4UDp7PTFkOS5wW2yrIkl+H6kJe8ezCZGXKdBaeiQDMxSk2gb5wfXkse/?=
 =?iso-8859-1?Q?+QlyUh/hgQT2UiNRXEZjxeicv+dVlVOJcMu68qvpbBe0i7kkLdzW+eVvVA?=
 =?iso-8859-1?Q?1wPdNyhzDE1CyvscgT2jCAK2D3eQPNlvwtZZ4b/fB0lZrUA6YaiozV1w5H?=
 =?iso-8859-1?Q?Hc/zbFSNo01RfhXMHxAiTFd2ha30xLAkq3eRlYmU0O+NOdJAYy5Kve/HXt?=
 =?iso-8859-1?Q?MRGnJ1Gw3jf7Zw14W9hdeUHnlzVMp9DuXrs4ssrOzHNLsUoOKGfwjzOtXd?=
 =?iso-8859-1?Q?ID2lWIP7h/f6FvyOoo8bmGwt2TJFpjQ1+FNYKD0kjTWfB19dmAsAnosUtN?=
 =?iso-8859-1?Q?c7fftTq3iPeDF5vGO483z2VGFQHiwq09n762bs0Q/zPqN4QBXt3zWqEKbT?=
 =?iso-8859-1?Q?PmydpVdkivFe50grodfPStZq0TVvsODSv4Z9LIkN4/6DM0EczE4jhupqqk?=
 =?iso-8859-1?Q?0InUWUI9+1kK5TmYDJQDvKO1leEa4SBhSyfky4/CwCoikXGBE3fJPiyYaV?=
 =?iso-8859-1?Q?UWHgfJmdt3atXSKP8wcz/CJGVq0nlwevX4uwZeLNMbxcbGVOt08epmLa87?=
 =?iso-8859-1?Q?gXRWZZzzOBIbrOwHdB4HiPZnZtifey/mRwfZbKMuUesB2s1o7UyJVFN+kk?=
 =?iso-8859-1?Q?tbfcYpt/3l/CrhdcLnGMDIV9VtiJKn6BHzMb+H+7NazQhePfVX9n++VTIn?=
 =?iso-8859-1?Q?Q4WzNZiGKtoky6y4IP71bqGyUCf5DUp5L6x2ejmiaucddNQFKoy+Z4cLC8?=
 =?iso-8859-1?Q?TpFKStD+n08hn1uNhZ5MPUEf9gP86fYXHnkktcYmz20o8WGvrpCrmKlxXp?=
 =?iso-8859-1?Q?3B6qV2F/l1MwxW0rjjXTv/AD1jlJiKL7sxPhR1KjcPWgMORMPXm2HIaLgI?=
 =?iso-8859-1?Q?A3l/IFSrbwz7ma+S6/SbdVxY+V8ei+XDpJChRWLvRjEHe/I7eC8f0+mxNV?=
 =?iso-8859-1?Q?JthD3sQpMLrv46z3RsYC0OKDcVbQY2JEOHqRo5oLXmwVXUcx+0ZZK5ukBQ?=
 =?iso-8859-1?Q?ETQdBiVHBPhDAvz7gjsa8IW0Ugb+n3enrzAoAkaEfO/t81klolDMmAMEMg?=
 =?iso-8859-1?Q?7Po0RlRtPG1SNn+IqFCLtzcVLFBPhpMpcYLvzoGLyAeLwprhod4CE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aY0JvQOZ/x+0YSEsPenTvJUxSr6LkH1hjmpacfqG2A4Jq0QgoTAUKCy/oZ?=
 =?iso-8859-1?Q?TRHBp9O8oe8jItr8HpzEyZTLkvb+FiKPv/7selQh7/POzjJ0YsBPX1Pjoz?=
 =?iso-8859-1?Q?sv4OTxyehypI7a8IeOBKhTJxcZYXqfOWWep8JZ2q4IO1HW2KMvCqaeJC8w?=
 =?iso-8859-1?Q?WIKffWHaZ6/QmUHVgj39iEHDpPT7ayRRJliMmogqd9CVOtx10TgoMR3Be+?=
 =?iso-8859-1?Q?yZp84px2ctaQccK72zq0RUZXSJvmi2EZfwroWJQfFsv3HAxCNsAJDR1MJR?=
 =?iso-8859-1?Q?qyQTzQ4925nRDnQ11Yj8Qfci3oB3htzn/zYnQ8t1PsirX2+ieEIYIcLqnc?=
 =?iso-8859-1?Q?RhHTiqLtdzF13KSofZmluihqHtcnHNh+Uq0XgF+in5Je8fT2poQSpZ4Rx+?=
 =?iso-8859-1?Q?M/fROZjuTgcUM4dV+pE1uDZTK9VL4X21bnrow7H+8QThodocjTqIAnP3fd?=
 =?iso-8859-1?Q?sxTxFLq7/tiRpWQNzAP+mJv/YGk7yNVXu6PAenXNfaI64CWa2mm9/mcdMY?=
 =?iso-8859-1?Q?nTN/9xdKSFm7OCZb+sP1HSFzfxQrHE7zyjeGQSBqwenR1VaeA6r/cfdHoD?=
 =?iso-8859-1?Q?1L+Mv1VviFeAztCA5H2wGI4tUCHanBtufym6lQn3VfVh8cvetzih1B8fZy?=
 =?iso-8859-1?Q?igoLUilAz1zAdsqIZIduPMqXocS/cg9YwtgWqPCbaFFvxUPBYmEVbek6mN?=
 =?iso-8859-1?Q?MRDW7VooPTiihpqBkNl2ngm2/XPR+IgXuR4fEyqyTdpPQ3hjAtffg+vJ8y?=
 =?iso-8859-1?Q?AiMElsxebqbPAD7oTpFmKx0ivJhzQxyj5MJ4B655OHw/w7W/J374yV1zx8?=
 =?iso-8859-1?Q?G5bvD/Q6LGKOPs3GJtZCtfPLeEdWNqIESaG/RvQ5I29YgUBBNsCHEFsA/D?=
 =?iso-8859-1?Q?5NR71HSAvLVAcUUBSLN3f5b8DTBGzpiRRuNywwQab6dAQTlDg37WxZr147?=
 =?iso-8859-1?Q?YFIhhgQuBfIJf0air+v3/zfmvVFQoE1zHsKuZuFS2X/mafCjMqqdCqM9dI?=
 =?iso-8859-1?Q?07Ho4haFDXNPeh8dJ7egBkk/i+i/l4QgQhKg1F1bUNloHkwkxt+FFpvetD?=
 =?iso-8859-1?Q?mE/wDkTle65bqi7YybV/X0VsQ7p46XruByYkB7/LCmT1YROsSMbQburk9E?=
 =?iso-8859-1?Q?RgabNPJb5vjAkCg9oH/DFro5JQ4dVib+BYvGPtj8NMkQo1FIf6Lbpur2oL?=
 =?iso-8859-1?Q?xXIQ4fGMRHmfhCuvkJ19/kz2yOMTxT07obSsNm/yiza3tG0Qlqokk+2luJ?=
 =?iso-8859-1?Q?/L4Cq2V5mU/3n1yOeANMxXp34U9mcLvVUKeA++mope0oq4eFdmHbguo0+k?=
 =?iso-8859-1?Q?hLX2YTG42M7q0WbdbvuoYqG5+S9qRfa4WKJlY5ej0HY1CfWDSndN/nlfzp?=
 =?iso-8859-1?Q?6pPjwHtP6JIlxL3BeLDDFXtBRmMJ3nAeOnrf52itRUcK+/pvAHYliQaXYq?=
 =?iso-8859-1?Q?O4YbjhHmdmqpSAN1JHLCJM74/Nr+XTWhDkuxLFbGkgQiHvWBkvQ/wl7Iz4?=
 =?iso-8859-1?Q?VNMmTAkU5PFfRVux0s0RG0TB0tciHXuEme8PFRNU/pVoW/GblBXO+/fV7v?=
 =?iso-8859-1?Q?M7zY9HnhxCwFUsIpbdQPE9WY56p0959KvP81WeL/d/Boe5ihHA7tocMC3o?=
 =?iso-8859-1?Q?1KL8Rulokp65dNXoJLRS60lnfzaQYPPNdI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XTjdHRu5qM3L3tyCizOBP8NNLEMFYgV5aHNUB+hL8SOj1OnhnZbA+hylC97qt7jcgBjRTnJum8qF4QG69VYMk34lYgaitn9MbrYYkzfCkiIwjkMsnaCLJIegZl3Lh5KVmTj8T/PgTiyXeoX1sYF1J+Wfppoi+Mwwu2fiARW4ogDKSj2x6GQeEnbeUqymAge5/0ZqWWs9cbyHDf+2mvMhUUgwnNSWm+FsbkNVL8XU68JO0CSU7oW4+SznmLgGwKQBM0eUGpW+/EfctzdGwqdH72ix229+B4nIfPyDNJ5BLGFLsxf+gtQMUxMzXx5e4ydZZZVpweC0iwYaCnXZGX2S8OBcdKUJmEERnhIKIlI127V4Uzr0sV4KAlU+qIlB1Go3a7jCGr6oJ+EiXxGs01kSOlwkqlZWVCiZ0NJ5vqkUfXr7H9EaovW+udPH7qNDSWXltpI+yxit90J+bPowiWksKKPVpITWUyG0NVLWfT+UFO2FrdwoYGD2BQKzqNZPb0On1p3cePImMrvSwUiDeNrD/z3Xl6CqmACPsDPV4JEulS3Pq6d6oo5AYjuAHY+1rOaBpZ+nX5heJPBsev5POKKN6fY2z6OQnfQ/bYWb0bsYt6ULhNGi9s8AbpJdESnpYG5iMcHTCw04cZdUjj1dPmECSw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baca0994-afce-4ebc-58f0-08dd0447f1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:02:00.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5XFF0Sq11WpUnoTHiyeAvc+9Ml3cijtfi8NV6wUf68WTXhV+6pc+7UVhDwjtiuYk3uc8qvlK27VRYuSe+hPMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
X-Proofpoint-GUID: GmxLgLewMmHpXOyACOfR-Djln2uU3v98
X-Proofpoint-ORIG-GUID: GmxLgLewMmHpXOyACOfR-Djln2uU3v98
X-Authority-Analysis: v=2.4 cv=Y5mqsQeN c=1 sm=1 tr=0 ts=67354c0d cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=G22H_ajZ9zPfgKLza4sA:9 a=wPNLvfGTeEIA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=821 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140005

This series contains miscellaneous fixes and cleanup including the clearing=
 of
the ep0 flags and handling of SG for dwc3.


Thinh Nguyen (5):
  usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
  usb: dwc3: gadget: Fix checking for number of TRBs left
  usb: dwc3: gadget: Fix looping of queued SG entries
  usb: dwc3: gadget: Cleanup SG handling
  usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb

 drivers/usb/dwc3/core.h   |  6 ----
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 65 ++++++++++++---------------------------
 3 files changed, 21 insertions(+), 52 deletions(-)


base-commit: 528ea1aca24fba5616f397d43ccb2de99d2a41d7
--=20
2.28.0

