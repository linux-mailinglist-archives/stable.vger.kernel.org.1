Return-Path: <stable+bounces-120190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E6BA4CF35
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 00:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8047B7A558B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 23:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EBF23BFA6;
	Mon,  3 Mar 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Nwq5KU2x";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ALBG9MwS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WIGb35YS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C523AE93;
	Mon,  3 Mar 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044389; cv=fail; b=lMF7ItqrUcuBkCbEmTxFoCw6OP0NHnVKPHRwZYUv29XaegpU/23MEvCD/oLoD/vckecj1tOFKat9kNStPR/asXBcg0qNoZB6mYu2sDpXBilESFbkR1x7ykGVQ/Xg+EQgzwns22nSFGHjO756Fc1JjPTGx4tn2BbEz81DhC6aEVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044389; c=relaxed/simple;
	bh=xEm6IY+FvA1BvV9bKvKp4OPFJIEuMMG5m8OyVRkCXz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUjQsLn3INxlSnCpL3v2b/sZB6b5srx2VYRoeleZcKr70FoNIESWMlygElJHEOsGNFbPRw5+jPP5RFRGsbBuZUElcnPKBQuVL9Re6Yg9zE2QLociRiASo+k/WyOCRl5oTrDnYdQVzP/MNRben3PGs0uhr5KU+nLo/Ufi3sh39DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Nwq5KU2x; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ALBG9MwS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WIGb35YS reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523KAGD1011337;
	Mon, 3 Mar 2025 14:47:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xEm6IY+FvA1BvV9bKvKp4OPFJIEuMMG5m8OyVRkCXz8=; b=
	Nwq5KU2xQ9mUYWGhmsCdPXxEW1rx3Mf+3WNvfEExrFTrkh4Tmr3JfwBwWSEo9e01
	/gVMByhofAFO7esfBRvTROh3fyeKmDa9JoZrTYwNWCfeDX6LYPMJNCAOBT3iFNTZ
	AcMH1EVPrxbqft1N1DjLL8qmEWvhA9FCg8S2NyGEbz+KOCxRivf+/ZREfdqRYtZC
	QRynQ9ze5YLgdMnmz4EN7k9QE53f713bHHYgPi8BsMryG2EjMRn0W0er3yqddXQs
	V5GZ5XU0gsBP0jcLko5emXr/lF/n4h8A1VU7en2tUR3OHwQ8aItUBdqFrCnToW4M
	MYI8P8YOhljd1TZd/z0mcQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4541rk37xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741042043; bh=xEm6IY+FvA1BvV9bKvKp4OPFJIEuMMG5m8OyVRkCXz8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ALBG9MwSqcKqeeCsYKMAtjsnudRmYHkus7Urzo2Dbxt2WSCKo5Wu9mMZ8Rdw+JCgw
	 Cu6CFfzgwP5jGmouubvTe+ettrlZ8wXoVvm/mrdsA/mwlm5y6U8Ebiwd/3EY7sxmw5
	 M8k+ZyXfmQKDmif/g0H+U+3khnhvM8PP39kuu1EtHPn6J8Wz1dQYG1VK6XF9EAQGsg
	 foBxltNuD3OLGrfL7rU3qldpvvrxTtqfLGDnjMbuw2lPQKwy/+JjTz22tKzQ9AZBEo
	 zXOgqutpCjb4oSx00vqbwDb+UN66o4KaODlXIehuEKW3bit23WkJRQ+BP8/MXf0u8G
	 OC24VQuuP6BoA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5D4E4401CA;
	Mon,  3 Mar 2025 22:47:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CB667A00E8;
	Mon,  3 Mar 2025 22:47:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WIGb35YS;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 50F684035E;
	Mon,  3 Mar 2025 22:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNwBKUv9dVoV1XnmQ7nm3mOstMqFmikyYtOTffzIoqvOpT3wN+8n25GjnTXMD53+IYS1/eMqJ2emrDcrI4y9z2Zep0JG8TTosoOM/Xflm/beNB098gvvQZ9KQRJNBZo3HsnEL/O7Xq6tXN8MrcE85sPTNC1XcUwiLv6cfe2B4wACl+9YUQioNmusiK8HL7VtKcAlJlHAF+AqFQeKR2C+mJoxTvs98CXeChhL3sePUnTCgDhWEdHozSgZ29eQM675/xcB11hMTpbdR7Z5jA+6n8uU01afSUhRJTojf0BRMD26s4vbcI+UW+l0snvlWeYxSZXFKdLiD0SEeaDUTaIGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEm6IY+FvA1BvV9bKvKp4OPFJIEuMMG5m8OyVRkCXz8=;
 b=DH3GqVQcFaQZkgixXiTM9SL9cnxbtl4wHgizQ2R70HizvWgQ8boCqup86hYA9qYBIUaKXC+7qZJhhDeOhrwNUz8s20cBN2JWdIk9rtTzkWFsAI6bo2CLAfSU2njYN/03+77aVJRsXigM2XMZ2l0KHjWMlVZDz+4sRiZmp4561pLI6YLHWqwJGPvK9+hvcHNaVNkttpqV1gYIR7Tcn5Ghq2AwiclCW/Fx91MPqga9zdw/Y4vSfGHlY8dBZeHW0yJGX9qzbVTFo7xAyhOFGNAXm0JA2ux/obMloGrU3WeqIR0o/sQttjyn/bfKuGjBQthqHWilEpUDKpcO5u3l6yGJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEm6IY+FvA1BvV9bKvKp4OPFJIEuMMG5m8OyVRkCXz8=;
 b=WIGb35YS+6f1jNjdPM1ZVwDkbtFMsL8kQDlAEQ9nQWEtG/WhxwuxG4PCsi0xQD1PxsdDoK52eIJHGQSWiZJKLQ6uW54Qnj/uRMVj2aXbv8u9LlaE1sVwjEYTwcJAbQ6CVLnxH3IjctKw3Qopy+C7ajnx6zwM3SSwV8AEcAPOxkw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 22:47:19 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 22:47:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Set SUSPENDENABLE soon after phy init
Thread-Topic: [PATCH] usb: dwc3: Set SUSPENDENABLE soon after phy init
Thread-Index: AQHbc3Gb7tGfYjs2j0yp5RHjp5XhGLNiNX0A
Date: Mon, 3 Mar 2025 22:47:19 +0000
Message-ID: <20250303224706.wzvsf4nw2swzelaw@synopsys.com>
References:
 <633aef0afee7d56d2316f7cc3e1b2a6d518a8cc9.1738280911.git.Thinh.Nguyen@synopsys.com>
In-Reply-To:
 <633aef0afee7d56d2316f7cc3e1b2a6d518a8cc9.1738280911.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB6804:EE_
x-ms-office365-filtering-correlation-id: 79b64887-328c-4097-1ecb-08dd5aa55a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGhIcjRrUHZtaXMyNkFmenV4aERzWUk5WElLSDVxRDk1azJhUmNYdngzZ1Nw?=
 =?utf-8?B?OTY0UUJMcE90aG1abVBVS2JYOXczYW00S25BMjJ0WC8xZDJ6WkJNa2drVE9Q?=
 =?utf-8?B?WCtML0NiWDh6dGY2anhlOC8xaXlTenN0OG44SnhPNXFCcU5wY0FiOHZwOXBw?=
 =?utf-8?B?SDVSQndhMXgwK0pweDZybjl3Zm5kN2JiYk9pTllGOU5nLy9ZSjFDajFEcVRK?=
 =?utf-8?B?UTUyeEthSnRncVlidUROTTlycmRGb1puTlBvYStKTmhodUU4OFp3cVhzQVRw?=
 =?utf-8?B?bjRnSXdrNWR2ZlNxWHVPM3QxNnlPUmU2T2pjWW1JNWJCTTFIMW9oUlNaOXR5?=
 =?utf-8?B?MU9yMTBFUVBDd3d0a0dKTFZqK0I1Q3djand0RHBtWnlOSzNPWTVIdlRtVlVo?=
 =?utf-8?B?UHV4YU5HNTdmU3dRYXFybHZCYjMxK0RpSEFIRVlQK3NUcjNDalNUVzRTLzVI?=
 =?utf-8?B?VzVyeERHeEowSXY4QW1XK21zQlg2bzBkdWpPb3lTVUphWGhVekp5MUhDS0F1?=
 =?utf-8?B?UVYvWVZuUHpEdEdWdkFvcFVROFFvODZzSEtTVzk1Mk9jZXBubVhQTmFDbzBU?=
 =?utf-8?B?UUwvSnRaVDZady9tQ2RlOFVOK0RkeWFwTkJvTzczNTNlM3pITXVSRUkvbHZu?=
 =?utf-8?B?UW5XSlQ4b1l4TW9wdHF2SENWUytDS08rNThFRXNmaENkV0E5ejUxYjBmUlNY?=
 =?utf-8?B?M2pBM09lVlIwODBtZGx3VjVCalR4Q0VZcmx6Z2VYTXgya2pCU0NHRVpHV0ti?=
 =?utf-8?B?VlpYR1ZmMEhwem5peTg2VzdzM3EvR0dHSTVwZ0cxdjhYejNLNVRlZmtUbHBC?=
 =?utf-8?B?ZGpuN1dMQi93RVN4WTRIQkE1eHJwYlZBWXpGZWx1bGtUWWRQNW5VWVJSNGc1?=
 =?utf-8?B?WTFQZzhIUmZaTldaODA1aUtRblZhV2wvZWE1b2M1azRRdThuWm9DbVhIUER3?=
 =?utf-8?B?M0hHdDBwdGx6U2lWQmVFK09QeXEySHNqU0JOUlVndDdOa0M0bUo5TE5DZ21l?=
 =?utf-8?B?d3MyQXlQaWdocUUvRU1HcmI0RVV4eE1sakJadjEwcEhPczR1azZmeElhNmJo?=
 =?utf-8?B?dDVGdGRPR1RoWW84L1JleHdreFpPY3lJSi9lUUsxcG93WXZlMGV6ZXQ5YXlr?=
 =?utf-8?B?S1Jva0RkWUwwYjZ1Q2FnUGRiNjBqNEJHY2xqWUpGYzk0VkVzZjRQY01DMTJT?=
 =?utf-8?B?STZVLzgrelBtTko0bDJqa3lNNkw1S08vaUhPUm1XNVR5YzlQMmpPUHlPQ1V1?=
 =?utf-8?B?NXVlNndrQ0RMeVhBT3ZXWWk0Ungzd0E4ZzdkREUrdWR1M1ZNRHNUbmZXNmtl?=
 =?utf-8?B?MGpoakVBbkwzN29Eb3F2MWtwdGVwbjhSYUtVY2dOVCtvNHZiTC9FSGZPaCtQ?=
 =?utf-8?B?a1ppbHhBRThMZ0syNnFCT2xWQ2NveWxYb0JmaUFOdWNsT0NSNCt5cVZLcXNk?=
 =?utf-8?B?c1VwUlI1ZVF4Q29TbXVTL1d5V2x2T3A1MFRMZ3I4TG5LaWN1Uy9zRStiUkJs?=
 =?utf-8?B?VUhKa1NxNWI3ZmpORjE2WnpSU2ZxQ01DUWRacWt0eEwrT2xPelg1TkNCeG9D?=
 =?utf-8?B?Q01neE5QQ0d1NzVuRnlmZlFrYUFlSXZQUnhZTnJYNUhLYTJEZlBJU1VuNGs5?=
 =?utf-8?B?VW5YcXpjNHhkTkVWTm5DMUt2WFNQVENuS3dhYml4MVpsc3dIUHBKZ0ozZ0c3?=
 =?utf-8?B?Smt1Y3M4N3RtZzgyNEVkdkNsRkJEOGZSempQdllXQkR6LzN6UVV1S0VZdzdQ?=
 =?utf-8?B?ODB6czdJZG9YQTduOGp0cVJkcTlCZ09tM1dNZ1ZFNHV1aHU5bWZnRU8rbW9j?=
 =?utf-8?B?WW1VSlh2V2sxWmxRZTlGOUdKSU9peXFTS0JkRWJlVSttaHVKTW9UOU45eFFr?=
 =?utf-8?B?NnNPRzROb005bmt3VHFWcGJFd0tyKzM2Q083Y21NUXZyeVorTENNb3lrMGhD?=
 =?utf-8?Q?O7EumcJzuJjxmLzNjSuoaLJn+FtnZw1s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlMrQTIzSDB6RDBJOVJkcEd1aXhROUhJbklvZkRGWmxXdjFmV0xvVFdnQm94?=
 =?utf-8?B?aXdYNGFjSzVORG84L1REcVAxeXVNVU1EU1cvMnZleHFTQ3hqeVNvYTRHV0c5?=
 =?utf-8?B?ZHkzZmFKQTlrOG40Z1QwQTZONCtHK3A5MmU0U0FmSTJOV3A2UUhIZWNoTjRP?=
 =?utf-8?B?QWJVMHZxSk1yRTMxRFhhTlhhMzk0K2tMMnU1YW5WOUFvQnFQZDFzYkFRYVBn?=
 =?utf-8?B?cHkralZZVjFKVkI4NXVmYytZMHZ3U1ArTWl6MmsySy9kajdHdUorbmJCU29J?=
 =?utf-8?B?N1NVVjRCYzVWVitvVnJxcjJSbzd0NHNSTzJURG54V3d1cEpjaWdvejhKQWty?=
 =?utf-8?B?RS9kemdLUHdWRHJxQkZadWo2RzM4Q0VMNVlLOUFwU0JsLyt2aFZKTmJ5V1BH?=
 =?utf-8?B?RE9lR2dBRDlnT2RjTEpnN3lmd1FISWJqRWZXTmhyeDVsUXZFSkNzUGx6L1NM?=
 =?utf-8?B?THVjZko2QWNRa2xsTFBHYTFEeWVTdUdoa0FNK3NtLy90VmlHVDgwYms5VVRo?=
 =?utf-8?B?U0JlY3BreFVmcnplZlFqajNMMDlkUytiaERPNkhpdW9yUU5OeStRMUlHQU1I?=
 =?utf-8?B?TXdaTENGdHRyRERFUWRTTmpRb0F5bmd2bFZVOGZYY2ZjR3RUc0EybFh6S2wr?=
 =?utf-8?B?Q3N4VlhpbmxhakozQXdlcWVSYjR5ekRGR3NLU29HUzlhQVRWa09LSG54azk4?=
 =?utf-8?B?YVhJV3hqaGwvYy9VOHEzeXYwYkg3QklqNTEvbFBVSGNuWTIrVjZTRmw2Qkpo?=
 =?utf-8?B?ZzdrUUtlOENLc2FyaTkvY2d0ZjVlWWpLL0d5MytyNG4vOG9ORnF3eXJhZ3Rr?=
 =?utf-8?B?WnhPclRCeTFiSlJqWnJwTGJ1bWZsekx0R3lSbFlmREo1ZGl0MU5RbG9LTVdT?=
 =?utf-8?B?eDV3aSs3MHZvNVB2cVJBRHZJM0d1b3Y3cHNVb0s4d3RMVDZjekNJMTBCcEhv?=
 =?utf-8?B?YVBtUDhvY2c4YVlFZ0xjekFHMGFvNGZjUDEzbU9GeTJ0MzZMN212Y2VMT2pE?=
 =?utf-8?B?eEU0L1N3ekRjTlkzWG5wMmdJQXhqYmNiajF6c3h5Y1VEVFlPTzczbHMxelJy?=
 =?utf-8?B?TTZhR2V2Ykt2ektnUWVxSU4yRVJWK3cyNzQwbUJNUVdmajJWNkRaUVVGbWo5?=
 =?utf-8?B?ajZhOFRIcXp3QUZldTJuOTU2ZG9nbmVON0w1S3dEWWpuTFJvRy9sdXRhSjd3?=
 =?utf-8?B?enVDSmc2U2FjU21obURUZWlydEQ0eVNqaEVIQ2dTNC8zcGlHRytQQlRmMk5T?=
 =?utf-8?B?ZWdIaEZZTFJJSFlHTHlLdkRNSmhrNFpoQWplWk52cmdTdE5zdjEwSFVDQnNp?=
 =?utf-8?B?TkJuM0w3ZlpPUFVkUGxZMXF2T3VyYzJoSDF6aWZwZUY2Zm0rOXZJL1NvRVRq?=
 =?utf-8?B?SFBhZFA2Qld4ZktRUWc0aGxkZXZtdkhrRG8yUU5wV2ovcGdVTHJxU0xjRHdO?=
 =?utf-8?B?VXBEVmF5SU16L2FCcHpBeldGU2RlMUlGUHlBU0JOb3h3dlRDOGlJeVRlSEJC?=
 =?utf-8?B?ZzBUVGZLdGg0MDlubVVvZG81aGZyUVdUQ2NiMDdVNU1hMFVnN1RFdTltYzl1?=
 =?utf-8?B?QWRyOUQ1NnpQa0N0QktpNzZISXB6WEhIK0w4TDBqWEF4SjdlZE8zb2hvWlEy?=
 =?utf-8?B?R1M2UkhTNHE2Zk1uYlR5VG04ZDdFc3VyTjFTVUVyQ1FCbEN4Z01ERjl5bGUr?=
 =?utf-8?B?cmYwcjFWRFp2dkE5cm1mZmVCL292aWRLSS9ITzdzUGVVa1M4Q2thOHUzeU16?=
 =?utf-8?B?VitXajBPR1VCUU1DZWg0MGFTcnF3WUNWV1FvcmJRVzRERkpIYkRKd0FkSlp1?=
 =?utf-8?B?cGxaYm5LQTVnODd6MkxNYnNVQmIwTkRUKzhUbkJHeExRWVlyQVcrckp6dUdn?=
 =?utf-8?B?YzNhbVYrN3hoc1gxL0xDR09Oa3JoeC9OTjV3QWRtUHQ5dFppb0NGRkRoY2hN?=
 =?utf-8?B?d1lMY2hNTnBXSUhHb1QvZWJYQmFiMTU5Mjl3eWpUOFZPSmRteFNrSjdWOVlO?=
 =?utf-8?B?d1FpMUpCV25aWEhFL0RFSEtvc1VjQ3NGV2RQUlBMUVJmQ28zZElMU0pkdGFi?=
 =?utf-8?B?blB2bTRJTnp2Y2ZqUFVFWkVhdG4yNDloeUFVOXpSQmNocHJXc0RaK09mbDB5?=
 =?utf-8?Q?O7Em2ejvqgLs9MrLUgXcyC4I0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A767179EE0ED7419251BA745DC3DE8F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vkv9LXTkmkuiF7bIHdERGo6S1gNa05rHB5WybrCNSYsELGWiIHlp7vY2xYMlmz4j6YeMEFXNwAx3I6rIYKgt5HQXhsCMu/E7GMUx++J4XJCxHZQB3lwcdd+BX5JHNUZoVFvJ0Z9WiZCQaAecl3T25I6lRwWnhJYShf2lpYG7qZZbimt//b3rjbQ2K/yho6rYkmVsmFCafJRjUH1mlf3Rr4Tjx+hsl2xcOXf37SYeYBhcLu+OADmr/kdzyh54fgZD1Qbyp4f1ut1UFJcgwhwBGe40sykBxXiiDCFcPYF+PJjpxi0dx8WeZ82ap8zcm8lSQrKTAvgncdl/DcrRtIWsl4WHuc7IqwRjjpmCPnfeI/yAVWTq1tzgjqd4XmVDfXnc+kZncSOh8h5ZZ8CGj3Ng9BZc1SzWhmVCQJZEdkXHOyFF0dD/zR2im13dCQGioA4GCV32GdcdFvY87IrU0kL4n9WDcirVNAb0JzuQcJCUH7S7BTSOvRUG6ixtomZE/6TnR2lTa4mqb3U8GMpaw/JOzJSrx77t2YpGJ6zyyTBkPdgZHmvMCzht5/yj7kvNsie5fWPRxbX1QT/7JJB9yqQe4AcG/U5IbuPYHMTdz1p9xVtB32nDiVBNDT2KdJyuI3adBPYcw0p6IFSPoHJuU251fA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b64887-328c-4097-1ecb-08dd5aa55a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 22:47:19.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMHXm4z9vYWWhcmNlGM+dxYIERpb/guhKWIqpiV6NZq1R0ks6lylxq5XDz1NPKobKJ4sgGUYRFvNorLRDdRMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
X-Proofpoint-ORIG-GUID: iFPHhCpRV2ey8mDRnR3Oq7nmLfVKd69P
X-Proofpoint-GUID: iFPHhCpRV2ey8mDRnR3Oq7nmLfVKd69P
X-Authority-Analysis: v=2.4 cv=FIrhx/os c=1 sm=1 tr=0 ts=67c6317c cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=hr2nIaOk1OsHvgVLbkcA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=528 malwarescore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030177

SGkgR3JlZywNCg0KT24gVGh1LCBKYW4gMzAsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
QWZ0ZXIgcGh5IGluaXRpYWxpemF0aW9uLCBzb21lIHBoeSBvcGVyYXRpb25zIGNhbiBvbmx5IGJl
IGV4ZWN1dGVkIHdoaWxlDQo+IGluIGxvd2VyIFAgc3RhdGVzLiBFbnN1cmUgR1VTQjNQSVBFQ1RM
LlNVU1BFTkRFTkFCTEUgYW5kDQo+IEdVU0IyUEhZQ0ZHLlNVU1BIWSBhcmUgc2V0IHNvb24gYWZ0
ZXIgaW5pdGlhbGl6YXRpb24gdG8gYXZvaWQgYmxvY2tpbmcNCj4gcGh5IG9wcy4NCj4gDQo+IFBy
ZXZpb3VzbHkgdGhlIFNVU1BFTkRFTkFCTEUgYml0cyBhcmUgb25seSBzZXQgYWZ0ZXIgdGhlIGNv
bnRyb2xsZXINCj4gaW5pdGlhbGl6YXRpb24sIHdoaWNoIG1heSBub3QgaGFwcGVuIHJpZ2h0IGF3
YXkgaWYgdGhlcmUncyBubyBnYWRnZXQNCj4gZHJpdmVyIG9yIHhoY2kgZHJpdmVyIGJvdW5kLiBS
ZXZpc2UgdGhpcyB0byBjbGVhciBTVVNQRU5ERU5BQkxFIGJpdHMNCj4gb25seSB3aGVuIHRoZXJl
J3MgbW9kZSBzd2l0Y2hpbmcgKGNoYW5nZSBpbiBHQ1RMLlBSVENBUERJUikuDQo+IA0KPiBGaXhl
czogNmQ3MzU3MjIwNjNhICgidXNiOiBkd2MzOiBjb3JlOiBQcmV2ZW50IHBoeSBzdXNwZW5kIGR1
cmluZyBpbml0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDIgKy0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZHJkLmMgIHwgIDQgKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2Vy
dGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCg0KDQpKdXN0IGNoZWNraW5nLCBJIGhvcGUg
dGhpcyBwYXRjaCBpc24ndCBsb3N0IGluIHlvdXIgaW5ib3guIElmIG5vdCwgdGhlbg0KeW91IGNh
biBpZ25vcmUgdGhpcyBtZXNzYWdlLg0KDQpCUiwNClRoaW5o

