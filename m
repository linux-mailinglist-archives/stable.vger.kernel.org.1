Return-Path: <stable+bounces-127450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACEA79826
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04831890028
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95B1F4CBC;
	Wed,  2 Apr 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RH95yE/C";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DeCSalKP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tg+0JhU5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B75126F0A;
	Wed,  2 Apr 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743632579; cv=fail; b=rCI+yX4MXYpBW5+49oNymVjEMhf09YZXgowyMqmfw4YwQipiizSUp0eoGH1h6S6GUx9pf5UZL18jy4Yi9MG528Dg6Z0NOALRveuxib/4JSry5CbQ6rT6lgV7WDinhLHxnqSqqFEisbm2Q9E740jmBjv6cX2mIFlOcyy+nZl6hbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743632579; c=relaxed/simple;
	bh=vbvICP6lM05C1XO0a+LbEWCvxCQNpv3BR3vttHa4USU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bOydYB+EbJruoJb4qA5bhrAxThJ4p4xdRFH9PVK0CruuB9eA9Mpl2+AUmi7M9Bf1Tu0V4qOXMmGUQNkx7HAfwi1UfzdHQaXwpErdBGLZti+tXw4L70GTspuTvyM0tVtYb+evyPFiReS0JNjqRk/vrGlSEEFUehNQhTbRxxd4Dy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RH95yE/C; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DeCSalKP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Tg+0JhU5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532GpthK013664;
	Wed, 2 Apr 2025 15:22:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vbvICP6lM05C1XO0a+LbEWCvxCQNpv3BR3vttHa4USU=; b=
	RH95yE/CyewwZxAXD/j8dLNRqUKvVZQquvD7ozbiYS87Nc9qL8qABTtlIYeateG/
	2LMWmzSghhFzgovqBkPAADnjFRbyLoYEgJb8EjOskY8k46gZZgZ/Lo5mEWkWv/Ra
	ql94cBb8KzMH/OlUoYwS6qAHRGJRvw/qg/nxDLYkklmD5+7JU7akOf3qUS/nweIT
	Q/l0WCv2wwHZVXSs7WkV+HDxU6Yo4UBLe26jaUOd6DHglZ6FKRpnEi2Bxaft3c0r
	y5X03lK8FXdhcyh4HxAbxXuyp7BayKs0zY6EYU6SIAel9BCAZhPlF4780CsZNvTL
	QKeSc2EKBWxwQ+OpN85PRA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 45pfgfwu9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743632565; bh=vbvICP6lM05C1XO0a+LbEWCvxCQNpv3BR3vttHa4USU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DeCSalKPZdEWyVfwMzOpfmaXHVEUV21pRR9aq5pUi0Vb/pY/y0jTaYRb95ov5jh9y
	 sT5hAE9sSkKc4OkV++A8XTCmroaeauzge2pQ9Q+UzUsPcBAHa2leqJ4bMo+QpDDnqT
	 taaiMKyeCZbb9ghcIztcxQM5nLEOrHtSfsYr65R7IeLVBc0+o2sVfp0In+xmplZENY
	 5k2i/rv7V3Yh4fsB1FGHr0Qs/0D9GIF2FrzsXWZQESVUgmyyl3WMDdqOEk7QbDZf44
	 RGm9TTU+gSRpu7t2RFVpVpewIKMLo1XlQEkkItTD15ddYKhxFTHxX4iR9dn9JkUOON
	 I/aALndEzYAng==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D23A340235;
	Wed,  2 Apr 2025 22:22:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 69000A0070;
	Wed,  2 Apr 2025 22:22:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Tg+0JhU5;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0D54940566;
	Wed,  2 Apr 2025 22:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARQ76VZrZabUeKA5n/vu2RKX03hsi2nQfYGa06ZEwYCJrp1cxzDYRJMm/Ld/3pC/fyUBM3YkUU6j6A4wXGKW0H93y2SWbLNrBRsi5q7dywUG5n3EQAY/6tWISZLBeRQbTs8+HE7zcHUdFRplCNttjF1zIuzEPBmhjQn2gTSSUDAlXjbbPttEC805sPXkkgcFdb0x5GCNHPMLAvcM6dXbJzZBBD8+3ZDk0sP40xxcYEb8im42ctPrNG5mCuS2tndRV57qzc3+5SANfP3XU+jG0ALmjZExicRR15w3j77RYffpgybMsiub7bnPlGpHC0tMuYB2jrzmhcvJGP5uH3jsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbvICP6lM05C1XO0a+LbEWCvxCQNpv3BR3vttHa4USU=;
 b=fDriXCnb/Bx3/Fmwh6EwiP3vLAY/i5nexqCRBVOBAiofS9ovW+dB0QbWUm5V0qycvjp1dBuyK0Cyo61VxxAAp/VjM+agjN7MxIGozr9u68JWNXv7Emqn5im8Hm9J5GVhU+8BAoN6OOvI28uWKPGzkSFhU/xy/ThvZXLqgCi7BoRkDnOu22PWhBvL/egsiSPZEwi6bvp+PWfMCNhJsEtUwfjvGm+wFjhFf/ss2qOVog57VEOk4P9/eeFp3OzjJmRwSfFoq6c/129HfZ55NftrupWKPMXdQ34In56RgDQ3lpPGymuUIAVmIbrxwoqrwX6HuArnkxNQJf5B8mktb6H0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbvICP6lM05C1XO0a+LbEWCvxCQNpv3BR3vttHa4USU=;
 b=Tg+0JhU5R/VDH7Z6Tx79gEFzwU0uZHrnqJ1j7xAaBjqxDco2l1PcRIMskBiKFit21iQtiaG4+mqp7/vYU9ZjQh+KmKC9O+FIj0huku0RYYm4ha17iY0PdaYi+Mehp6Nt0idDSxeB7EXEkWIGZWSIpl6yUfedHPPVQABIEMHmN6A=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 22:22:42 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%7]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 22:22:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frode Isaksen <fisaksen@baylibre.com>
CC: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Index:
 AQHbn88kqDW/B37ovUqwebLGGZUk+LOOUlcAgABri4CAAAT9AIAAu0aAgABVmACAADSRgIAA85KA
Date: Wed, 2 Apr 2025 22:22:42 +0000
Message-ID: <20250402222241.sijy5qzquzdippen@synopsys.com>
References: <20250328104930.2179123-1-fisaksen@baylibre.com>
 <0767d38d-179a-4c5e-9dfe-fef847d1354d@oss.qualcomm.com>
 <d21c87f4-0e26-41e1-a114-7fb982d0fd34@baylibre.com>
 <a1ccb48d-8c32-42bf-885f-22f3b1ca147b@oss.qualcomm.com>
 <20250401233625.6jtsauyqkzqej3uj@synopsys.com>
 <4d9226a9-d89d-4441-9dbf-f76ebce49a9e@oss.qualcomm.com>
 <5c428f8d-8c8e-42a4-9650-f731ff5ea16a@baylibre.com>
In-Reply-To: <5c428f8d-8c8e-42a4-9650-f731ff5ea16a@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|SJ2PR12MB8689:EE_
x-ms-office365-filtering-correlation-id: cb6766f7-d8b5-4eed-39c0-08dd7234e2cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlNNRktKZERQOXMwN2dXbXpXM0RNTGwyajAwc3JibnpRbHFoRFBHbGM5Y0s1?=
 =?utf-8?B?RlZwSUtLQkkrN25TeFYyVW9LRkZqUXNzVlVhOXBxcUFEeVhNN0pKN2t6cDRF?=
 =?utf-8?B?aFl4RkRoTzFGZ0tLTm0xaTdyVGdYVFppZ3E1NnFvYjdNNUVNWUhZMTFjQkh3?=
 =?utf-8?B?VkN4MDRCMC95NE4wY0xsOXpZd2VhSGhBVDh4MnQ5ZEVBMVEyUjFuR3VIL2tk?=
 =?utf-8?B?Y25wakkwcG95eTl1ajJVY3hnbTY5eXl5YTBWTGtQeVpTbGEzaStYZURNVG9a?=
 =?utf-8?B?cyt1aHhKNWZaelJnNGdHM2RCR3lja1Z2WWRhRndEZmNkcVVHR1BGRTU5cGpi?=
 =?utf-8?B?Uk1EQktCSDZoNWoveHRuRUlnWVFwUTV1TVBiWTdQZDBFU3VnNDNlbi85WVZ5?=
 =?utf-8?B?NU9PKzJ5MFQ4ZzRMNDM1OHlEcXh3d1k5M3hQWVhGWk9OZ2poT3pIL21pT0c4?=
 =?utf-8?B?Um96aXYxdWpIbjdldXBGZCtqaWc1SElyOUdOa0xKZHIvMEpYeEU1Z2RINVl4?=
 =?utf-8?B?UmIrcEFCUjJwVHZtNmlFYkhNSFQySUp2aHFKVXA4dWhveFM3aUYybW9SRUgv?=
 =?utf-8?B?eEloZm5JUGJiNjA3YnowcVk3aDhTY295VjBwenY5c0tOK1VKM1NhVmZvdEk2?=
 =?utf-8?B?bVhpYlpCcDIxckpUcnJrMm5IcWxEOU5MV1hOUkl1VHVFSGl1TC9aaE5yanN1?=
 =?utf-8?B?a0xhRmNSVmtuenFETVJKQlltSUpqeGVhdXRYZ2V3RXJTUFlBd1ZMWk1qdml2?=
 =?utf-8?B?Nks2TWVDdElhUUkxa2E2SktWWnl0QmVpa2QzeGlGOElMUUQ4Z0dmTWwvL3o1?=
 =?utf-8?B?a1FZMTBQaWpxSHNScW9ZbU9IRHNKbi9BanpoYTBVcDJDWE9MckRjeDRFbEp0?=
 =?utf-8?B?amx4T0IyMG92WDhTVmxtYStxd2V3UVQ2TWN3cGVIWDlFNHE1QkErMmJYUVYy?=
 =?utf-8?B?RHFJbkZyVThGUmNGdGdaRU5zc3d4RG9HSi9wNVpFMXp2MHVjMVFMUk1tVTQz?=
 =?utf-8?B?NUdRNWtMOWRlRStaZ2hqTXRyKzR3LzJuV0hhZXVnRG1FV3NIdmMzZ09CZEph?=
 =?utf-8?B?R3J2SnM2OCtIcWRPRkVxZlk4R3FsZlVCTUFTV25lS3FWdENHOEt2ZXFHSTZq?=
 =?utf-8?B?ckhNUmc2a1dwL2xuS2gra2lSdUlvQjZuOWJ0TFhZS2lOeUQya2E3Y3BXaGUv?=
 =?utf-8?B?YkdvM2hRTEczd1hHVmRFaFNWeHF5ZHpoeWEzSVgrSW5sRTJsTVVCbnA2U3Bm?=
 =?utf-8?B?aWo3MHFEVUFsY2ZDODlkN3JjdlluWTV6V2I3cXlrWW9LcGgzUDhGTUYzUk51?=
 =?utf-8?B?OVJpWkd4eDVLUmY3R3JKOVp5MXlYL2haVkFUT1F6bm9IaU5KZDJJcHZaZjQ3?=
 =?utf-8?B?T2hFMU1PMVZwSnJHYzA3UndraXRCMEhScG9HL0p6RG85aTFoejZUUk40TlhC?=
 =?utf-8?B?WC80VGtBVG9CR0xOdlNKdjFURzZVb2xJcUY0c2hWbFdJd0Rudyt4WXZvdk9T?=
 =?utf-8?B?TmVQbWFqMnNZZFRjUnovZnZacVVGOWNLSWhaMUpxMFRxeC9oU0tPUG9aMEpw?=
 =?utf-8?B?ZGNteEkyWForMkxmR05ROUZUQUc1YXo0UHVEb0lMa1lONmdZOGZQb0J0V0hY?=
 =?utf-8?B?N0EyR1p3dXM1YS9jcExnU0xkWk1ub3hFMlk2MG5XUkhxb0FLZnU3aERHMkNu?=
 =?utf-8?B?Y254ZWx2Mk5DdTd2VVlwcEthMlVaNHh1eVdOcytwd24xaitlcW45RHVmMysx?=
 =?utf-8?B?V3JXalNZOXhKd2d1eWh5Zi9JTFVjcGl5U3drUkJOdVhVRklrc1dqQjNVcHpm?=
 =?utf-8?B?bW10RUFRakxtUG1TL2doQ1BxZmRUZ1pMajdGTmFaYmcwT0xyN2ZCOHNsZVhY?=
 =?utf-8?B?T0k0SjliL2p1ZGY4ckRiTjBmOHVLOXZTQytLSk8xcTBGRkdzQ1FpNzhiRUp4?=
 =?utf-8?Q?7hM9iBd1dffNG+jEyuwntqhIeu1wYXCe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWNRRFRYZGpJeDRLVXo1UWo4VDNTMXl0UGhCVEVGSExhOFFJczRlY3Q3Wmxs?=
 =?utf-8?B?TzNJOWZkc2QxNWFiYTFFTm9JOER4Um9DMDF4TG9CNkxUQ1c3SFd0NWUzU2xX?=
 =?utf-8?B?OVlKZTczMzF0aHBQSmhZMWpPeE1IWXIrM1poNGFHMGEwb0lRcXdUcTEvbmxN?=
 =?utf-8?B?OGVzVkdXTmg1QjgzU045WUp5NFIrcnlSWnFmb3ZtZ2ZZRUdNeE4zeDZZYjY1?=
 =?utf-8?B?Tzk5dDhtclJNYzN3WE5WYWVtai9xeCsvb3VBRkhTOTNxSVpPMGs4ZjNqcDRX?=
 =?utf-8?B?c08ya1Uydkl2R0MxdFliQTVvT3NQZXBTWXBXOEVTbW1rRkZRSXlGQ3V4cUc0?=
 =?utf-8?B?SWRMTDB0dWExOElVZmlQZnhrLzZmZ3YwdDFSSUg3ZFRHTlZFNDBzUG5JSWh6?=
 =?utf-8?B?cFg1QzVPWVdSMWxnWDYvWVMyTkdtUWlrUk83OGhTemtCc1QwVmZVeUR3Tm0z?=
 =?utf-8?B?Y3FPY211L3JaQTAzM3ozWlRaQjNBdkVXT0czb0VMYWkyM216THVkc0NpNkhv?=
 =?utf-8?B?Wkl4SXplNTFLRHUvZEFxZzlHZWppcVJNd0doamtsc2czc2xNNXN5Q3RGR2Zw?=
 =?utf-8?B?cmp3ano1RXM0WEpJV3lqbXBIUVYwYzVkRHhmZW1FMlVqS3ZEcDNjVjZXK0lO?=
 =?utf-8?B?SHVkbVFGOCt0VFNEMEYvTjJTN3d5VmFLWlpTaDJFWHo3Q2cwTGdycHE4QWsv?=
 =?utf-8?B?R0RPb0EzY3FOUXpxZEZQVmVrNHFFRW4rdEYxbFVJRjFaaEU5dUxyVWJ6U1VI?=
 =?utf-8?B?TW9TQUlxWUIycnJ1M2VMSHFJZ1IrTml4d0hYbUxVZlRwWk0zZTBXNGVMSGxx?=
 =?utf-8?B?dTZXdHFXNldZUEhtdE05aWNiYXBCUld6ODVTRzFOblVjcnJWcVBjRVF6bksw?=
 =?utf-8?B?a1NSU3VMTG9GTVdwaEhpS3ZMcTBRZm53YWcwMVdSd1dTeHNTQ05MVzNXWE5a?=
 =?utf-8?B?UXl6ZzFvYWdDWUt2bUp6MkM4aGpPU0JYRGwrcHVJL1E0Q1YzaHFFUDUwVUo5?=
 =?utf-8?B?Z1QrMDJueXhlRDRTOVBMdVpBaHZvZnowenRPYnowMXRvM1ZmZVlpd1dXWXlD?=
 =?utf-8?B?NXJtOStkMHZScGg4MFFuRnBLUll4Yng5a0g5YldPZ0tSeEtDWUFKL2JGWVBZ?=
 =?utf-8?B?d1pIN08wQXVVa0RWekpydDFaWm1oZm9VQUc1V29oaUN4cW4xN2JaTm9nMWZl?=
 =?utf-8?B?aW9KcVpvU3B3dWhEdTNkUTBNRGcxMWdGZTArVUR3U21hNXBTUG5jbU9ZMFdi?=
 =?utf-8?B?SkhBRWhuMUp2cndXT0F2YUJ4eEJsdFI4MXBFU2VFTnZXRnBWd2JJYUMwbzFD?=
 =?utf-8?B?QkR3Z2R0Qm52MGNidDdqV01JU2RpR3BianhCY2ZndkFPQzdFV21pN3JwcTFm?=
 =?utf-8?B?YWxORE11a2I3QVdoRTZ0MkM5a2pxVGZTaGJ6TU4wUmZieitSK0xrNmFZWDl1?=
 =?utf-8?B?UjJucUlYNURpTjFUR0p4dnNBVU04Qmtvek9ockZ5My8xU2tEdi9JTkVFRmJX?=
 =?utf-8?B?MTJUZkpzMXZKbDBTLzM1L0xtTDI1L0ZodUpmdTFzWjNyeGNjb0JDeFIvYURF?=
 =?utf-8?B?cGw1NVh0QW51eVpXbVRmcFBYMEZ6c3RQTG11eDltem4zTkNIaVdkTU9FK01O?=
 =?utf-8?B?VDA3VEhFeEhXQ04rOEFXeHcrYTlBaS84YnNOaUNvMTVMejgxOUVuYXkrcVAx?=
 =?utf-8?B?ZHJlMFIvM0NnSVV4L0pJb0NibUhSZGtaTS8rMm5mUGxXY3lHMUF2M1U5Q05m?=
 =?utf-8?B?dXFvaDlvY0tkaTR6U1pJRnFjNXNqOHJSVW1VVm5XN1VFU1kxemUrRTREczRw?=
 =?utf-8?B?VWhSelNVSDgrbXB0MGxZNHdkeEJVQmZMTXdHUFU1V3NsN2pMSkVEQWlld0lp?=
 =?utf-8?B?N0hPMytsTm5jQ2U5Y01FOC9uOThib05QVVBBbDZBUmJLUGx5S21rRkJPMHZZ?=
 =?utf-8?B?cFBYaGM0NVZ1SmpqZHlnZ253aHlRYllnTVJiTlJkbnZ4MHBYTDdWNXZoS3Fs?=
 =?utf-8?B?RW16OHgreG5FMmJCOURlQ3Q1U0pxd3ZPaFVYZlE3UUZPWmxDc2JINzQ5Rjdr?=
 =?utf-8?B?dlNobUU2U2xyWkN1MkVTdmhwb3Z2VTBtWUxuYVVJdithcGFDMlcycURycUFl?=
 =?utf-8?Q?xlgd6YJptkj6QLYlXlfkEs6AN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB837C13C0F4A14DB532AB2D8F2D3E71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9BBz1xInGC4GdXEHvTVFZ3h5794sEe8FCRpGZ5rXDeBcWLwMPi+w0jLuod9mEUHl6qAz8Awi2FgYuIS+67jj1e3uzou5A2xgAo8l8Rym5blRmaOU9ZrqXGAo5Obpgsr57lHImjhgoSvTQzwaz/v0w4/O9+fn2H7Zka7TM8RKDGOdyfnM+bFQhir2ZjKxdblV1YNB15jxxslwDI43TnYej7ayWAEitmOWV91OCNxg+28ji3gCtBUIELHgedEj/U91nHoSURFh4TiZ0g9bU6fqJ6zLthadwoLu8eXzOpywuCM1kSq6piGOV2kmrH8w0z3rYIC+3cy2TPiyAqBZ2i2TfmJeCpqf++lo/FilbPYvdHmH6WgUnauzjD5v8MZFXkRbfF89O3mnMCNh3PtcCIHpL7RO1tpbOE8reeeAwLeaIhmPSxPqEqQLpGWZD5gRhCw/mcXypf8cT6w4d9jyfcZS79JZHzuAr+mRuhF9vVfHtbPONzyKQNslLAD8eBzrYMPtBoUqn+KrHXfbfGAo3dUScBhva7U1qaSeWxCSfA0OJ1yVWMbwwWvCCNe8v90Mu57Ioh3+fbNu7Bukqk1h4WZpitOB9MqF2qTO7gf1Voxu/p9dwVd+/VMuTGcyJLIaqSHuMTOE24ltP26EiUG/7RrPpQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6766f7-d8b5-4eed-39c0-08dd7234e2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 22:22:42.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTkzOFIkH7ztcec2jP4xbb2huBto0z81FsiXcqbcnt0hgeuBN+xPACfWpGof+mFE9kEcMDOLWh0CGTEZT/t5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
X-Proofpoint-GUID: yegEFay7pW5GzWEms9tZLTTGftzLzwyH
X-Authority-Analysis: v=2.4 cv=Q7/S452a c=1 sm=1 tr=0 ts=67edb8b7 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=O2uXmj3L9g1dXuc6Wq0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yegEFay7pW5GzWEms9tZLTTGftzLzwyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_10,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=790 clxscore=1015
 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020143

T24gV2VkLCBBcHIgMDIsIDIwMjUsIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+IE9uIDQvMi8yNSA2
OjQyIEFNLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gSSBzdGlsbCB3b25kZXIgd2hh
dCdzIGN1cnJlbnQgYmVoYXZpb3Igb2YgdGhlIEhXIHRvIHByb3Blcmx5IHJlc3BvbmQNCj4gPiA+
IGhlcmUuIElmIHRoZSBkZXZpY2UgaXMgZGVhZCwgcmVnaXN0ZXIgcmVhZCBvZnRlbiByZXR1cm5z
IGFsbCBGcywgd2hpY2gNCj4gPiA+IG1heSBiZSB0aGUgY2FzZSB5b3UncmUgc2VlaW5nIGhlcmUu
IElmIHNvLCB3ZSBzaG91bGQgcHJvcGVybHkgcHJldmVudA0KPiA+ID4gdGhlIGRyaXZlciBmcm9t
IGFjY2Vzc2luZyB0aGUgZGV2aWNlIGFuZCBwcm9wZXJseSB0ZWFyZG93biB0aGUgZHJpdmVyLg0K
PiA+ID4gDQo+ID4gPiBJZiB0aGlzIGlzIGEgbW9tZW50YXJ5IGJsZWVwL2xvc3Qgb2YgcG93ZXIg
aW4gdGhlIGRldmljZSwgcGVyaGFwcyB5b3VyDQo+ID4gPiBjaGFuZ2UgaGVyZSBpcyBzdWZmaWNp
ZW50IGFuZCB0aGUgZHJpdmVyIGNhbiBjb250aW51ZSB0byBhY2Nlc3MgdGhlDQo+ID4gPiBkZXZp
Y2UuDQo+ID4gPiANCj4gPiA+IFdpdGggdGhlIGRpZmZpY3VsdHkgb2YgcmVwcm9kdWNpbmcgdGhp
cyBpc3N1ZSwgY2FuIHlvdSBjb25maXJtIHRoYXQgdGhlDQo+ID4gPiBkZXZpY2Ugc3RpbGwgb3Bl
cmF0ZXMgcHJvcGVybHkgYWZ0ZXIgdGhpcyBjaGFuZ2U/DQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVs
eSwgSSBkaWQgbm90IHRlc3QgdGhpcyBwYXJ0aWN1bGFyIGNoYW5nZSBvZiByZXR1cm5pbmcgd2hl
bg0KPiA+IGV2IGNvdW50IGlzIGludmFsaWQuIEkgc3RyZXNzIHRlc3RlZCB0aGUgY2hhbmdlIG9m
IGNvcHlpbmcgb25seSA0SyBbMV0sDQo+ID4gYnV0IGRpZG4ndCBzZWUgYW55IGlzc3VlLiBJIHN1
c3BlY3Qgd2UgZGlkbid0IGhpdCB0aGUgaXNzdWUgbGF0ZXIgYWdhaW4NCj4gPiBpbiB0aGUgY291
cnNlIG9mIDE0IGRheSB0ZXN0aW5nLg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDUyMTEwMDMzMC4yMjQ3
OC0xLXF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20vX187ISFBNEYyUjlHX3BnIWFsc1R5bjRqZEFu
VENINHM0aDQxaFFKQ25jUWpGdWtnR2Vsd3JMQnhPdDFja2VOOEdSUWswRFBNS1NwalgxaFN6MjI2
MFA5Vk9mcXBxSHJOVV90d0N3U1gkDQo+ID4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBLcmlz
aG5hLA0KPiA+IA0KPiBJIGhhdmUgYmVlbiBydW5uaW5nIG15IGZpeCBmb3Igb3ZlciBhIHllYXIg
d2l0aCBtaWxsaW9ucyBvZiBRdWVzdCAzIGRldmljZXMsDQo+IGFuZCBubyBzdHJhbmdlIGJ1Z3Mg
Y2F1c2VkIGJ5IHRoaXMgaGFzIGJlZW4gc2Vlbi4gV2l0aG91dCB0aGUgZml4LCB0aGVyZQ0KPiB3
ZXJlIDEgdG8gMiBjcmFzaGVzIHBlciB3ZWVrLg0KPiANCj4gU28gSSB0aGluayBpdCdzIHNhZmUg
dG8ganVzdCByZXR1cm4gd2l0aCBJUlFfTk9ORSB3aGVuIHRoZSBjb3VudCBleGNlZWRzIHRoZQ0K
PiBldmVudCBsZW5ndGguDQo+IA0KDQpUaGFua3MgZm9yIGNvbmZpcm1pbmcuDQoNClRoaW5o

