Return-Path: <stable+bounces-161754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62FBB02FDB
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F86C3B2178
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67F1E5714;
	Sun, 13 Jul 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qqgDbz5Q";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qqgDbz5Q"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022090.outbound.protection.outlook.com [52.101.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2A158520;
	Sun, 13 Jul 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.90
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752395112; cv=fail; b=Ke1X/JgPEUD/NQ1rgQOTt+lCLJrOhTHsWjVnhx0gnxpgiXppybtyZ/sykDKcYcXc5rlFwpULl/rItgmaVQabJg+AwreSYqPF7Kl0V4Wonvr72AD7mOR/VdSk27Y4hT9mqkmfJVEQO5djM65p99fwfCymL1niw8dLwuOqIp2amKM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752395112; c=relaxed/simple;
	bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jUKlA/u2r6fRQ4Dxg/eF07CohexjjynC/WZATELPtTN5VKFnEs7kCQbN17laOlkgVteVgrAMB5qtretCjSMtZXC3QJwRIPaABI+mOOkXVqWnqGW//voyHM+HZ1tQ5tjq3thXA/YmQy30RXh/Od7cb41q8lSrK0lJh24OSY97tC8=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qqgDbz5Q; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qqgDbz5Q; arc=fail smtp.client-ip=52.101.66.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ea2kj2nuSJQkNE08FEvWVdt5RONfzh7+xtlF6q1g6BzYb8EnrwCEXqqsZ3ZwQonlr62586D/midhZyLix9Qf7/Te1tthJlWCydcYNywgpu2PtdWMnnqPenCXIq4M6N5d/BPqXskPZOU5+WSpc61UYNRPqRE0Uvr7A0rPkaBTmOrKa06NMWMq7EyXJbqAKZhwTsSqz1/ZU/VNOCEmSy7MNX41EhrjP/BFSxXk8YSBkwAr6t5siir3jeeGWhuQxKpT2E20hrxq6Gbc9NwGy7xfqJNf1W9yeFsbR0/0vJTuVp9Acf0uqQxk67oTNGzgnvpq1zeC5q/8iV72mJvf2381NA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
 b=oAKYylvsjQkxkaPdZ4PQ7CW70WIUksg/Nl13Vl18QKhb7SU3uiJnJ84oFvHvpeVY2KhzxlecFGnySbc3YmJUSHBRer0UO1bthJiQd/4bZfItVE0ovd4FgWJH7tEW17YrtzvcIpBODN0d5WKByQapgauiSlWHN6eGe6+v+U2o9q8FvQb5cI10Pgz3w9RQHrs4DU18937RuqFwZwhkemzkpkmzIbsi3sjOEvh3w0JCeQpGt3/vXZke9K27PH8B1cyAn28krSxtijE5jxJWrNDkv3pK6/Gih9FhRteNkzyD9JL3JJkNWhEttisEhf+59jpRyDvYJMbYlmVuCgVKNbTy6g==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
 b=qqgDbz5QxwezU/u2TaJjLyaEo7DD3WiWSaKDV+NLazhTOJiYW6fVTmXeKt9U7oSKpfEVcU+v8GU/DhtUshpOCt/KSRzyaD9rrAOFeHSf2lII50bnDajJKc8uv/HY7YNpy3oH2Et7b4uS3xi5esqh+x+63ny77wVCgystqWBY8ic=
Received: from AM9P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::30)
 by VI2PR04MB10548.eurprd04.prod.outlook.com (2603:10a6:800:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Sun, 13 Jul
 2025 08:25:04 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::67) by AM9P192CA0025.outlook.office365.com
 (2603:10a6:20b:21d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Sun,
 13 Jul 2025 08:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 08:25:02 +0000
Received: from emails-3110235-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-133.eu-west-1.compute.internal [10.20.5.133])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 85DAC7FFCC;
	Sun, 13 Jul 2025 08:25:02 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1752395102; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
 b=fGJtxQlACabc7oXnis13kpoZ9Un3zZUI2csdvkQ1Jwl0k1nSV5Oa3xMZoMQNwfoTYiuiW
 HLFSpYUS8wkNOsIk8ZSpnX5ANuxv73ZZdAU8ArZGBPORiDJ/Ve+XsBC1By/DoEpmwMwKrLM
 Ii1tb6U9xkmRwuKMpvVWdRipkgP856U=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1752395102;
 b=ZuFedkA0yGiwaWn+OlDrxF1ihdA+tTCZIv+s9Tt+Q7Vs1wiF2KpjlF/jYKU/NpX8KHTkF
 YrEOu6YQDRn7o4KrQLIvfGjFEmW0ZrC/kwSmyflK1gLooh3TvCVkGtPoNnqNx9W4era3qEM
 ofXJdIXlryEVMWzVpak3Cpaj1xxhjIk=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIqLVu6zWZGv3ryDptEoU5DvrPlXZdX9bOu2QTJfIw2QNE6+Byw1MQC7KJR348nK8M8JePPOMaTzpCCteC6K7kmhCRTEVLunS2E+jgDvBmsjV3+jbDfXsdbCfWk3mk8UWMNjO0cleM3lvI/mRDEWyg7gKJUHwDqmG0eVl8aDr7u/tnAvLA4RzShvXfhJONveEy8YpkM5SFM+0WvOHYAAwqcAWelnXF1j4h2cm7k7X9K2YHqf92LT6VPdX/xdbtO5N+Zt2TqQwi9aSOyE77N4FBAI4DK+qAsMhUtWqIg/oLhtsJJ7fWHGXr+fDINs4aWXssD35jUVk8wRJSmIMnyTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
 b=QQx+XRKLmyOvsIQeplwc2eoMMiBvz8TR4VYDwAfGMC3+VMoHy2pljBtIdGM7tLqPAhTF4e5V0VoUGtZl0y7g99/5sRVDu97VEUHbAdswLdCde+93BWDYlwEBDwxl+C0e53+UQOQYvE7n8DUaSUVAmfd0btg63K0li4mt4qsXbXZi8CmcD8pV1NphMoFDW8XNejwW7edcdnzxL7XEFk8CYIMdSsVFiG+63EmMnVkMsowAEUxSYJEYqTiSLLkXNZ4e171szPz+Pzn0h7wdGhfO0TqbzJq10KxdnhRU8CNT4FyxWOeYF6iRHxdgDwHfEVKlhn+4WC8tJPMUtjs3SVtXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG2XQ80OW8d+O2lZg7IY/wtoWihdYs1nzjKy68rX9jM=;
 b=qqgDbz5QxwezU/u2TaJjLyaEo7DD3WiWSaKDV+NLazhTOJiYW6fVTmXeKt9U7oSKpfEVcU+v8GU/DhtUshpOCt/KSRzyaD9rrAOFeHSf2lII50bnDajJKc8uv/HY7YNpy3oH2Et7b4uS3xi5esqh+x+63ny77wVCgystqWBY8ic=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA4PR04MB9663.eurprd04.prod.outlook.com (2603:10a6:102:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sun, 13 Jul
 2025 08:24:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 08:24:48 +0000
From: Josua Mayer <josua@solid-run.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, Carlos Song <carlos.song@nxp.com>
CC: Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: fsl-lx2160a: define pinctrl for iic2
 sd-cd/-wp functions
Thread-Topic: [PATCH] arm64: dts: fsl-lx2160a: define pinctrl for iic2
 sd-cd/-wp functions
Thread-Index: AQHb8ayouUAYANNsmkqlf+6+IYF9xLQvu9cA
Date: Sun, 13 Jul 2025 08:24:48 +0000
Message-ID: <524f940e-9e31-411c-a419-cfb5a48d55ea@solid-run.com>
References: <f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com>
In-Reply-To: <f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PA4PR04MB9663:EE_|AM2PEPF0001C717:EE_|VI2PR04MB10548:EE_
X-MS-Office365-Filtering-Correlation-Id: affb9d2c-be91-4e91-ab0e-08ddc1e6c3d2
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RkRQV256c201NnpSUXZLZ0lXcGh1RlY0dzNZbHh1dEtFakFFODhFRkk4NXNY?=
 =?utf-8?B?Tk5tN2p5MjBpMi96UDZwZjRaWUNQVE5VN0xNTHhBQWlEY2g1VWVmb09SUHNN?=
 =?utf-8?B?SmZLWlFQWFRtb211cHIyTXptbEliK0l3dzk3OXZrbVZnM2lOVUlSdHZsblNO?=
 =?utf-8?B?cFBpdkNJMjRTUnlqTW5HNkxRZ0IzaHk3T2FPQlFKODQ1OTl5UEhoQlNWMGhP?=
 =?utf-8?B?MUxwZlZpT3lRUkx6Wllka2lSSGlRNkU4Wk53cWJyWXlZY0NwZzhmL2Z5T0V4?=
 =?utf-8?B?dGhJNEpzL1kxMFNwUjVkb2tRVUlOWDRoWG42K2tJT2h5K05vbVVXR09nS0Vi?=
 =?utf-8?B?bVRacmhvb3FndndqNHNTQW5PSzBDc2hlcnV3NVJnOUp2VU0rMVJETmIyNk9p?=
 =?utf-8?B?MFlnZmhqVzFPb0NIZExPc2RiRWwvRldpNStkR2wwbjVBUVp0R3RuOVRhUGtL?=
 =?utf-8?B?ZGtMdlR4UjBvVENMSFpvYi9pWnFqYUd1WWRhTkJuRTN4dlRERjhZbGJ1S1JN?=
 =?utf-8?B?bzlnQURxRE9kZm1zQmUyTHdycEVRU1QzTEMxT1ozZGJETVdSdThLRjh1eE1D?=
 =?utf-8?B?VVgzTWwrN0VEaGhSN1hrcjlQMUpTVERxenZaY29XOHFuZFdHUms3VjJrVG41?=
 =?utf-8?B?K0gvYk5rdTh4dzl5dmVrbUZmcEZmUWdobEYyQ3djMVM3TmxiZHFNNjJKSVlS?=
 =?utf-8?B?N0QxZDhVM0JFRzdmZUUrb2xtWk95UG4vdTVFQm1NYncyWTR5all3RnRDWXdj?=
 =?utf-8?B?c2N0Z3FyWThLN3hGMFI0ZEFWSHNkQ1VYNm9HVkpuWWFBdmQ2aWc5M1NNOWJW?=
 =?utf-8?B?SHdMeFNaMU00QzdjMGRFUFEydXVzNlcxWW9HL1ZoWWR1ZTAwb2puUjBHZ3l1?=
 =?utf-8?B?QzJ2WCs0U3FZMU5VSVZTNER6WEw0anQwR0JFWHVpSE5EeHUxdnhlTWJOZWN3?=
 =?utf-8?B?bWxseUJHS2VLTkszNDhzaTYzZDIrOHpiRzJrTDNFdWhKUzJXWDJ5WXJCay84?=
 =?utf-8?B?VFdqQkUyVEw4NysxRlQweEdsWFFkNlJKdDFRY1JMOHFBM0JjUzI1TGlHWTcw?=
 =?utf-8?B?UWEzTTlrOVhCRlEreE9YSnNyTmpGbjdzQjlkalIyUWFZWmF5cm1hcDBJS2lm?=
 =?utf-8?B?WGp1SFRFRXp2UnpBNi9CMXhKR2F2UDROT1dkNGI3Zm5UbVBReVdpbENGeXNB?=
 =?utf-8?B?VFZRUnptbEs4Sm14R00rWFJjTkl1b3VlZ1FUVk9Rd0puelFoaytraGt3WUM0?=
 =?utf-8?B?RW8yUmQrdThsTHlVWGlrdGUvOEJza2VkWFdEVE5CK3ZKSHdyY0gxYjYvbE5Z?=
 =?utf-8?B?Y0k3eXNmRDJoWUVsUDk5WDk3YXE3elJoRGNDMklvbmpXTzJWTno2NFFBRTEy?=
 =?utf-8?B?MGE2aE5mUk9oblB2aE5OelBLSnE1R1lmTFhIZmZxWE8zck4xWUF4WWZHRmFF?=
 =?utf-8?B?cG1rcUZ5NTVGaDhWaUhQYzYzWW9NU3JwTFU4VnNySzhhcDJTMzN1U3ZPQjVM?=
 =?utf-8?B?azhUWlBEc3AxUytWbUlNZHNqNmFOeTJwYjFjbUxoaXBLcmNoTzlxK3pNMHNz?=
 =?utf-8?B?UklGQk9UZ3dXNUszMGhqY1ZvaWg3cDNHZGlYVnM5RGtTbjVXUHZpRGNoekxB?=
 =?utf-8?B?WU1ZU21ibkR4dEdlUUdBZytHQVdEcDFaNmxWbXVxbHBoWCt5bkFNRVA0UjNP?=
 =?utf-8?B?ek9zQXphb05WTzJ3RFQwT0RQSC93cFEybi9LZ0Ivc2x0enpJeDNyMWdEYlFL?=
 =?utf-8?B?Rk40TFhHYmk1bGJZbDRFb1BGTDA3cWwxTEFRZWQyTUNjTG9BS1BYQ3pwVkxy?=
 =?utf-8?B?NUtWMGJLVWlyV2pYT2tqeWlOK20xSXRQM2ZqS2o0RVk3NGRISUpmbU1HQzhx?=
 =?utf-8?B?dWlOUDVzYWRIREtaUkpWWDl4b0N0Y3VLcU1MYS85aXFRRmZXaC83cEFCMEta?=
 =?utf-8?B?M2NCN3BDTVlDRHRIVTRKTTF0cW9tMFFkelUvUWVZNWlHeGc0TnR1TmVNTnE3?=
 =?utf-8?B?elNrdlczbldnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D13C7DD6805D644AC8111DA9325397B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8d8581446e9346698edba663f78da076:solidrun,office365_emails,sent,inline:d6c33a5310794ba3b3665c4f73f75572
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2074c428-f567-400c-283e-08ddc1e6bb42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|376014|1800799024|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTl1YkQyclpSWFZpZzQyNFJZaEJFaEV4V3FXaDdDQUp4cGJhYVNpVVVZMzZB?=
 =?utf-8?B?ZEVob1IweVgyZnBKaDBndzNtTDlGNTl4cm5oWGU4MmE1SStKdkc3VGE4WnV4?=
 =?utf-8?B?MzBJTmErazNIY2hQL0VBNFdHWXJVR1J6aFROR0lQNGpSL0dDNDI0RG9TZno2?=
 =?utf-8?B?VVFoazE4UnBESW9PWXNlOE1CMktOYUNuQmt2R2xkanhPT040KzNHQy9qMm92?=
 =?utf-8?B?dDZISXQwMThkZmdUQkF4NHFvT0I5RThvbEcrZHlIcEVlMkh2RUNtSEtCWnMx?=
 =?utf-8?B?S1MwbVBONDhOUWJWa0Y0YzFYZ0JyM2VxTjdQd2dJM1JtaGRjaW9iZzNPbFdQ?=
 =?utf-8?B?RERJZWZtaFdkbVNNVWJMUGhQSjhhZGkrNjd4S0xySjBkOGhGVlVkd3VkQ09i?=
 =?utf-8?B?M05SQ1N3RFl4ZHpSMXA4bWh5NDd4Y01PSzlXWFFTUi9BQ3N3WGduUi9EVjhO?=
 =?utf-8?B?aXRldWovMThpdXVRR3VIcENMUVJzc2E3bUhQMkdjZnpSZ1pZNHM0eGlOR1lN?=
 =?utf-8?B?WjlMK1JaNlF1UUVoTkN1cG5iZzhST1BqWWJaRlJhbzlqZ0ljdFg3OGxQQ0hi?=
 =?utf-8?B?Q3EyUFpiVytxTGdGU0UxZEVEekRnL0pFSzVvSEJtSFFZNGh5Ykdxa2pjQ2xo?=
 =?utf-8?B?U2k0d0VoNTMveXFDV0psYW9QNXpRS3pQd25RSzJjeUNhMktzaDJ5QXcrSE1m?=
 =?utf-8?B?SnA0VG1uL0pXeWRDMVkyVytKc0gwcGF0VzBPZzN5WFdYaHYzUzJOeEEyYUFj?=
 =?utf-8?B?VTBHaFJLVmJJeWg3K3hLenN6cndsSm5yOGRudWRZK3B0YVVidjArWVlGSm8x?=
 =?utf-8?B?dlB0UU5GRCttSlhjcCtSZGt0elpnb1M0anpQRFFBbzg2eXdrS3oreC9adFZt?=
 =?utf-8?B?Z3NVdHVJL2I4RnBvUkRrVHJ6UUNiUFF3cldiaGZWT1RCV0NhNytjN3JPQ0NQ?=
 =?utf-8?B?UmR4V1VjakU1elR5T2tucUw2Rm9xcXVrQlJSWkN6czBDaXVVUTRsTmh5ZHgw?=
 =?utf-8?B?Z0JmK3p4Ums1Zmo4Q251ZjMxbXZQd3doR2M3RnRUTWsxU2RpRTRYbGFEWEU4?=
 =?utf-8?B?ZXpCMk5GNVlYS1JPamZVdHBXTHpzZ2F2eDl5WHg1WVhEdXlKem9VK1p3N0RF?=
 =?utf-8?B?NU9uWkNrVzNvbE5malFMbUc0a3k3TUNReU1oY04rOFYydzIzNjVOOGI4Sk80?=
 =?utf-8?B?TTFvQWJSNTAwZ1ZGcVk3Sjg3UEx5SDVFcHlxc245Y0tYaDNWbGJRYS9jbEhq?=
 =?utf-8?B?MVIzWFhYekJZOG9EK2RwODJuZ29STXcrd0QvWG51SlVjV0ptSHp4a3RJb2Zo?=
 =?utf-8?B?WlFXWUFLZC9nbkdFbHU0TGl1VEt3c3h2cFBnclVSRGsrMzV5VFllc1AzcVdM?=
 =?utf-8?B?dmt3VzBFVjRxeU9YcEVQK3NVaitLQ2xNd3Nub0dSaU1UMDFIbUpRSEdCem9P?=
 =?utf-8?B?d0JRMjNZMFhoSUpwRjBTK3BQQVRuU090SG5YblEyMzZuT1ZUL0xWS3lSVzVx?=
 =?utf-8?B?b2dzVXdrSEJLVitlYWp1cWNzVkpSUWJxWjJXeGNEc1JQRnhhcyswendaaWkz?=
 =?utf-8?B?UlhCRUF1SkJJczVtTTBNM0RvakhqdnhpMmhVYVBsejQ5Q3p6eklsQTJHVVBx?=
 =?utf-8?B?VloxeVdlTFdiVm9zUDhMaVVUUnhxRGlSZGxWTU1xTFdHMWpLOGRwVnlMUWVk?=
 =?utf-8?B?WXlmR2trQjR0c3M4aysxa29DL0Z5THI2S1JTbHVNdTcxNFBVb0RWWlgwQVpE?=
 =?utf-8?B?RjMvK0E5bk5uNHN6cXJuWCtKRmp2djdQdWprWHNXYzkzbHk3cEtoY1c1VDVK?=
 =?utf-8?B?T0hodUptUTFSYk1vbEFHTWlTNUFoZHVxNS9qanU5RlZ0QlZOMDBDbnN4VHhp?=
 =?utf-8?B?K3ZyVmNGWDB1TlpyV0RQSGZUTFplQUtxQ1J3RUQ4TGVRT0I5OW0yV1R6SHlV?=
 =?utf-8?B?SzN4c3QvYWF5SVJCalllYVNvZ053N2FqckZmZmh6NzVhODJKRFh1TWgySHR3?=
 =?utf-8?B?NGQ3QTJ3NStSUnY1SERNSVhqR01ydUttRFROZHN4MU82Y0JUVnoveHBGdk5F?=
 =?utf-8?Q?Dl5FtI?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(376014)(1800799024)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 08:25:02.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: affb9d2c-be91-4e91-ab0e-08ddc1e6c3d2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10548

T24gMTAvMDcvMjAyNSAxODowOSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+IExYMjE2MCBTb0MgdXNl
cyBhIGRlbnNlbHkgcGFja2VkIGNvbmZpZ3VyYXRpb24gYXJlYSBpbiBtZW1vcnkgZm9yIHBpbg0K
PiBtdXhpbmcgLSBjb25maWd1cmluZyBhIHZhcmlhYmxlIG51bWJlciBvZiBJT3MgYXQgYSB0aW1l
Lg0KPg0KPiBTaW5jZSBwaW5jdHJsIG5vZGVzIHdlcmUgYWRkZWQgZm9yIHRoZSBpMmMgc2lnbmFs
cyBvZiBMWDIxNjAgU29DLCBib290DQo+IGVycm9ycyBoYXZlIGJlZW4gb2JzZXJ2ZWQgb24gU29s
aWRSdW4gTFgyMTYyQSBDbGVhcmZvZyBib2FyZCB3aGVuIHJvb3Rmcw0KPiBpcyBsb2NhdGVkIG9u
IFNELUNhcmQgKGVzZGhjMCk6DQo+DQo+IFsgICAgMS45NjEwMzVdIG1tYzA6IG5ldyB1bHRyYSBo
aWdoIHNwZWVkIFNEUjEwNCBTREhDIGNhcmQgYXQgYWRkcmVzcyBhYWFhDQo+IC4uLg0KPiBbICAg
IDUuMjIwNjU1XSBpMmMgaTJjLTE6IHVzaW5nIHBpbmN0cmwgc3RhdGVzIGZvciBHUElPIHJlY292
ZXJ5DQo+IFsgICAgNS4yMjY0MjVdIGkyYyBpMmMtMTogdXNpbmcgZ2VuZXJpYyBHUElPcyBmb3Ig
cmVjb3ZlcnkNCj4gLi4uDQo+IFsgICAgNS40NDA0NzFdIG1tYzA6IGNhcmQgYWFhYSByZW1vdmVk
DQo+DQo+IFRoZSBjYXJkLWRldGVjdCBhbmQgd3JpdGUtcHJvdGVjdCBzaWduYWxzIG9mIGVzZGhj
MCBhcmUgYW4gYWx0ZXJuYXRlDQo+IGZ1bmN0aW9uIG9mIElJQzIgKGluIGR0cyBpMmMxIC0gb24g
bHgyMTYyIGNsZWFyZm9nIHN0YXR1cyBkaXNhYmxlZCkuDQo+DQo+IEJ5IHVzZSBvZiB1LWJvb3Qg
Im1kIiwgYW5kIGxpbnV4ICJkZXZtZW0iIGNvbW1hbmQgaXQgd2FzIGNvbmZpcm1lZCB0aGF0DQo+
IFJDV1NSMTIgKGF0IDB4MDFlMDAxMmMpIHdpdGggSUlDMl9QTVVYIChhdCBiaXRzIDAtMikgY2hh
bmdlcyBmcm9tDQo+IDB4MDgwMDAwMDYgdG8gMHgwMDAwMDAwIGFmdGVyIHN0YXJ0aW5nIExpbnV4
Lg0KDQpjb21wYXJlZCB2YWx1ZXMgYXQgMHgwMWUwMDEyYyAocmVhZC1vbmx5KSBhbmQgMHg3MDAx
MDAxMmMgKGRjZmcpLg0KDQo+IFRoaXMgbWVhbnMgdGhhdCB0aGUgY2FyZC1kZXRlY3QgcGluIGZ1
bmN0aW9uIGhhcyBjaGFuZ2VkIHRvIGkyYyBmdW5jdGlvbg0KPiAtIHdoaWNoIHdpbGwgY2F1c2Ug
dGhlIGNvbnRyb2xsZXIgdG8gZGV0ZWN0IGNhcmQgcmVtb3ZhbC4NCj4NCj4gVGhlIHJlc3BlY3Rp
dmUgaTJjMS1zY2wtcGlucyBub2RlIGlzIG9ubHkgbGlua2VkIHRvIGkyYzEgbm9kZSB0aGF0IGhh
cw0KPiBzdGF0dXMgZGlzYWJsZWQgaW4gZGV2aWNlLXRyZWUgZm9yIHRoZSBzb2xpZHJ1biBib2Fy
ZHMuDQo+IEhvdyB0aGUgbWVtb3J5IGlzIGNoYW5nZWQgaGFzIG5vdCBiZWVuIGludmVzdGlnYXRl
ZC4NCg0KUkNXU1IxMiBhdCAweDAxZTAwMTJjIGlzIHJlYWQtb25seSBhbmQgcmVmbGVjdHMgdGhl
IGluaXRpYWwgYm9vdC10aW1lDQpzZXR0aW5nIGZyb20gUkNXIHN0YWdlLiBUaGUgcGluY3RybC1z
aW5nbGUgZHJpdmVyIHVzZXMgZHluYW1pYw0KY29uZmlndXJhdGlvbiBhcmVhIGF0IDB4NzAwMTAw
MTJjIHRvIG92ZXJpZGUgYm9vdC10aW1lIHZhbHVlcy4NCg0KV2UgZm91bmQgdGhhdCB0aGUgZHlu
YW1pYyBjb25maWd1cmF0aW9uIGFkZHJlc3MgcmVhZHMgMCBiZWZvcmUgZmlyc3QNCndyaXRlLCBo
ZW5jZSB3aGVuIGFwcGx5aW5nIHRoZSBmaXJzdCBjb25maWd1cmF0aW9uIHRoZSBvcmlnaW5hbCBu
b24temVybw0KdmFsdWUgaXMgbG9zdC4NCg0KSXQgbWlnaHQgYmUgd29ydGggcmV2aWV3aW5nIGFu
ZCBkZWZpbmluZyBwaW5jdHJsIGZvciBhbGwgYWx0ZXJuYXRlIGZ1bmN0aW9ucw0Kb2YgZWFjaCBp
MmMgY29udHJvbGxlci4NCg0KPiBBcyBhIHdvcmthcm91bmQgYWRkIGEgbmV3IHBpbmN0cmwgZGVm
aW5pdGlvbiBmb3IgdGhlDQo+IGNhcmQtZGV0ZWN0L3dyaXRlLXByb3RlY3QgZnVuY3Rpb24gb2Yg
SUlDMiBwaW5zLg0KPiBJdCBzZWVtcyB1bndpc2UgdG8gbGluayB0aGlzIGRpcmVjdGx5IGZyb20g
dGhlIFNvQyBkdHNpIGFzIGJvYXJkcyBtYXkNCj4gcmVseSBvbiBvdGhlciBmdW5jdGlvbnMgc3Vj
aCBhcyBmbGV4dGltZXIuDQo+DQo+IEluc3RlYWQgYWRkIHRoZSBwaW5jdHJsIHRvIGVhY2ggYm9h
cmQncyBlc2RoYzAgbm9kZSBpZiBpdCBpcyBrbm93biB0bw0KPiByZWx5IG9uIG5hdGl2ZSBjYXJk
LWRldGVjdCBmdW5jdGlvbi4gVGhlc2UgYm9hcmRzIGhhdmUgZXNkaGMwIG5vZGUNCj4gZW5hYmxl
ZCBhbmQgZG8gbm90IGRlZmluZSBicm9rZW4tY2QgcHJvcGVydHk6DQo+DQo+IC0gZnNsLWx4MjE2
MGEtYmx1ZWJveDMuZHRzDQo+IC0gZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kNCj4gLSBm
c2wtbHgyMTYwYS1xZHMuZHRzDQo+IC0gZnNsLWx4MjE2MGEtcmRiLmR0cw0KPiAtIGZzbC1seDIx
NjBhLXRxbWx4MjE2MGEtbWJseDIxNjBhLmR0cw0KPiAtIGZzbC1seDIxNjJhLWNsZWFyZm9nLmR0
cw0KPiAtIGZzbC1seDIxNjJhLXFkcy5kdHMNCj4NCj4gVGhpcyB3YXMgdGVzdGVkIG9uIHRoZSBT
b2xpZFJ1biBMWDIxNjIgQ2xlYXJmb2cgd2l0aCBMaW51eCB2Ni4xMi4zMy4NCj4NCj4gRml4ZXM6
IDhhMTM2NWM3YmJjMSAoImFybTY0OiBkdHM6IGx4MjE2MGE6IGFkZCBwaW5tdXggYW5kIGkyYyBn
cGlvIHRvDQo+IHN1cHBvcnQgYnVzIHJlY292ZXJ5IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+
DQo+IC0tLQ0KPiAgICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1i
bHVlYm94My5kdHMgICAgICAgICAgICAgfCAyICsrDQo+ICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLWNsZWFyZm9nLWl0eC5kdHNpICAgICAgICB8IDIgKysNCj4g
ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cyAgICAg
ICAgICAgICAgICAgIHwgMiArKw0KPiAgICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHgyMTYwYS1yZGIuZHRzICAgICAgICAgICAgICAgICAgfCAyICsrDQo+ICAgIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXRxbWx4MjE2MGEtbWJseDIxNjBhLmR0
cyB8IDIgKysNCj4gICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEu
ZHRzaSAgICAgICAgICAgICAgICAgICAgIHwgNA0KPiArKysrDQo+ICAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cyAgICAgICAgICAgICB8IDIg
KysNCj4gICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtcWRzLmR0
cyAgICAgICAgICAgICAgICAgIHwgMiArKw0KPiAgICA4IGZpbGVzIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLWJsdWVib3gzLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLWJsdWVib3gzLmR0cw0KPiBpbmRleCAwNDJjNDg2YmRkYTIuLjI5OGZj
ZGNlNmM2YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWx4MjE2MGEtYmx1ZWJveDMuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLWJsdWVib3gzLmR0cw0KPiBAQCAtMTUyLDYgKzE1Miw4IEBAICZlc2Ro
YzAgew0KPiAgICAJc2QtdWhzLXNkcjUwOw0KPiAgICAJc2QtdWhzLXNkcjI1Ow0KPiAgICAJc2Qt
dWhzLXNkcjEyOw0KPiArCXBpbmN0cmwtMCA9IDwmaTJjMV9zZGhjX2Nkd3A+Ow0KPiArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgIAlzdGF0dXMgPSAib2theSI7DQo+ICAgIH07DQo+
ICAgIGRpZmYgLS1naXQNCj4gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLWNsZWFyZm9nLWl0eC5kdHNpDQo+IGluZGV4IGE3ZGNiZWNjMWY0MS4uNjdm
ZmUyZTFiMGJjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHgyMTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPiBAQCAtOTMsNiArOTMs
OCBAQCAmZXNkaGMwIHsNCj4gICAgCXNkLXVocy1zZHI1MDsNCj4gICAgCXNkLXVocy1zZHIyNTsN
Cj4gICAgCXNkLXVocy1zZHIxMjsNCj4gKwlwaW5jdHJsLTAgPSA8JmkyYzFfc2RoY19jZHdwPjsN
Cj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgICAJc3RhdHVzID0gIm9rYXkiOw0K
PiAgICB9Ow0KPiAgICBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWx4MjE2MGEtcWRzLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1seDIxNjBhLXFkcy5kdHMNCj4gaW5kZXggNGQ3MjExOTdkODM3Li4xN2ZlNGE4ZmQzNWUgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFk
cy5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEt
cWRzLmR0cw0KPiBAQCAtMjE0LDYgKzIxNCw4IEBAICZlbWRpbzIgew0KPiAgICB9Ow0KPiAgICAg
JmVzZGhjMCB7DQo+ICsJcGluY3RybC0wID0gPCZpMmMxX3NkaGNfY2R3cD47DQo+ICsJcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAgCXN0YXR1cyA9ICJva2F5IjsNCj4gICAgfTsNCj4g
ICAgZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBh
LXJkYi5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1y
ZGIuZHRzDQo+IGluZGV4IDBjNDRiM2NiZWY3Ny4uZmFhNDg2ZDZhNWIxIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4g
QEAgLTEzMSw2ICsxMzEsOCBAQCAmZXNkaGMwIHsNCj4gICAgCXNkLXVocy1zZHI1MDsNCj4gICAg
CXNkLXVocy1zZHIyNTsNCj4gICAgCXNkLXVocy1zZHIxMjsNCj4gKwlwaW5jdHJsLTAgPSA8Jmky
YzFfc2RoY19jZHdwPjsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgICAJc3Rh
dHVzID0gIm9rYXkiOw0KPiAgICB9Ow0KPiAgICBkaWZmIC0tZ2l0DQo+IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtdHFtbHgyMTYwYS1tYmx4MjE2MGEuZHRzDQo+
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtdHFtbHgyMTYwYS1t
Ymx4MjE2MGEuZHRzDQo+IGluZGV4IGY2YTRmOGQ1NDMwMS4uNGJhNTVmZWIxOGIyIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS10cW1seDIx
NjBhLW1ibHgyMTYwYS5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWx4MjE2MGEtdHFtbHgyMTYwYS1tYmx4MjE2MGEuZHRzDQo+IEBAIC0xNzcsNiArMTc3LDgg
QEAgJmVzZGhjMCB7DQo+ICAgIAluby1zZGlvOw0KPiAgICAJd3AtZ3Bpb3MgPSA8JmdwaW8wIDMw
IEdQSU9fQUNUSVZFX0xPVz47DQo+ICAgIAljZC1ncGlvcyA9IDwmZ3BpbzAgMzEgR1BJT19BQ1RJ
VkVfTE9XPjsNCj4gKwlwaW5jdHJsLTAgPSA8JmkyYzFfc2NsX2dwaW8+Ow0KPiArCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgIAlzdGF0dXMgPSAib2theSI7DQo+ICAgIH07DQo+ICAg
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5k
dHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0K
PiBpbmRleCBjOTU0MTQwM2JjZDguLjU1NWExOTFiMGJiNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+IEBAIC0xNzE3LDYgKzE3
MTcsMTAgQEAgaTJjMV9zY2xfZ3BpbzogaTJjMS1zY2wtZ3Bpby1waW5zIHsNCj4gICAgCQkJCXBp
bmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDB4MSAweDc+Ow0KPiAgICAJCQl9Ow0KPiAgICArCQkJ
aTJjMV9zZGhjX2Nkd3A6IGkyYzEtZXNkaGMwLWNkLXdwLXBpbnMgew0KPiArCQkJCXBpbmN0cmwt
c2luZ2xlLGJpdHMgPSA8MHgwIDB4NiAweDc+Ow0KPiArCQkJfTsNCj4gKw0KPiAgICAJCQlpMmMy
X3NjbDogaTJjMi1zY2wtcGlucyB7DQo+ICAgIAkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4
MCAwICgweDcgPDwgMyk+Ow0KPiAgICAJCQl9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cuZHRzDQo+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cuZHRzDQo+IGluZGV4IGVh
ZmVmODcxOGEwZi4uNGI1ODEwNWMzZmZhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1jbGVhcmZvZy5kdHMNCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cuZHRzDQo+IEBAIC0yMjcs
NiArMjI3LDggQEAgJmVzZGhjMCB7DQo+ICAgIAlzZC11aHMtc2RyNTA7DQo+ICAgIAlzZC11aHMt
c2RyMjU7DQo+ICAgIAlzZC11aHMtc2RyMTI7DQo+ICsJcGluY3RybC0wID0gPCZpMmMxX3NkaGNf
Y2R3cD47DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAgCXN0YXR1cyA9ICJv
a2F5IjsNCj4gICAgfTsNCj4gICAgZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjJhLXFkcy5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYyYS1xZHMuZHRzDQo+IGluZGV4IDlmNWZmMWZmZTdkNS4uY2FhMDc5ZGYz
NWY2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYyYS1xZHMuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
eDIxNjJhLXFkcy5kdHMNCj4gQEAgLTIzOCw2ICsyMzgsOCBAQCAmZXNkaGMwIHsNCj4gICAgCXNk
LXVocy1zZHI1MDsNCj4gICAgCXNkLXVocy1zZHIyNTsNCj4gICAgCXNkLXVocy1zZHIxMjsNCj4g
KwlwaW5jdHJsLTAgPSA8JmkyYzFfc2RoY19jZHdwPjsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiAgICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgICB9Ow0KPg0KPiAtLS0NCj4gYmFz
ZS1jb21taXQ6IDE5MjcyYjM3YWE0ZjgzY2E1MmJkZjljMTZkNWQ4MWJkZDEzNTQ0OTQNCj4gY2hh
bmdlLWlkOiAyMDI1MDcxMC1seDIxNjAtc2QtY2QtMDBiZjM4YWUxNjllDQo+DQo+IEJlc3QgcmVn
YXJkcywNCg0KDQo=

