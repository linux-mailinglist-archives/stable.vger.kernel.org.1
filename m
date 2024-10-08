Return-Path: <stable+bounces-83098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1E9958DF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DE71C21745
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AF215F41;
	Tue,  8 Oct 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DQgF6usg";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DGhZN6v3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ScXv/CuG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345F215038;
	Tue,  8 Oct 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421150; cv=fail; b=h2KbCW1/4oi0q+7HPbWlVIznVya3U26d/U0oKXrL2hCNBTiVc5dfH4HxGOQYMGC3tXbUnXt8Tf+1Q5dad6UBQRfV4JnhMza+REzYQebZUfiKhGruvC73YhhAH2vaPfLnWeBrUQ7SwedV2Rd22x/9hRylawjAjC64vO+2wut+xNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421150; c=relaxed/simple;
	bh=T7SkGvVfTdYFDJ1khyIHXYEC6Qf5X0Loq+as2Ts6G78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ft2idAf6ENfFm5cMYND9xORAtaYRcaZXS8M/53+oyOtZpKgH/99xr7+SEf2w6mQk/ZSaMk08l40LBDQZyTH1RFuVlUCCBgq4G6XMy6ZTBsqOsuXl9R0rPg1tCTWN9Bl+qXuthhBxRD+QVNwwRzMKIslJTsRIyi9GXavzA5FtaPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DQgF6usg; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DGhZN6v3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ScXv/CuG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498G2O0l021875;
	Tue, 8 Oct 2024 13:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=T7SkGvVfTdYFDJ1khyIHXYEC6Qf5X0Loq+as2Ts6G78=; b=
	DQgF6usgYPQX0ED8G/JxuvE4hHo6scc38bo+G20Xjf0VgaseQlm0lEe8bUYs03KG
	XWCa/BfGp+mQsnFMNsM4/UseWsjskTl6uydVNdinb6A/O3JEuLJz1R8HeSR7HF/5
	EyT41CQT3dDOTsaxkpuksICX7fpMMtdIiCxuWG/2LXZJoExLc0DAJxvAqRWWx8F6
	VJT0byUF5QbXlZUN2rA7yUh4mKhB5ttQlRHxUvstoTNEo7Yk36gHE11n7qzp2BJj
	F7pwnW4YN3YIU99AL7rHyRPAMM93pgil/6UDxRpDJW0IPlDh1tkMZ0TwWoGoWfI2
	DSQ9ZHZdWkJx79oJ37xhkQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4257w89eq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728421143; bh=T7SkGvVfTdYFDJ1khyIHXYEC6Qf5X0Loq+as2Ts6G78=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DGhZN6v30LHbeGJTW2+/qqJoFM/zkgTg5dg9BzvQovMaOnki59z0AwKr8x0wqJ7Z5
	 Wlmhr/wF00+OnOJLQQUTwQvxI9F2Y3M6/3x6NLIpLv+ZzhHKdgvJ1ZmyfWsjwiOZyQ
	 vFmXTj+u/2yw2on/djTXhNZyGpIad7zOsnmgKYWCuZbx6jIJ1tQ9Ew9wB6uQzXHogb
	 uzx7fJmuXt0qj6dgOqwAPlnb3qfZN4P4RWntDsvyxEn+5Pujild2UE84/EIPnxDKJ1
	 ggDOUivaULehAIJXpILpQkOtg1gp3ZkCkshkodpUcikmFIfD2kkRm7ehlLPHuJhcPQ
	 Gu+D/L/WCDh/A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3919A40346;
	Tue,  8 Oct 2024 20:59:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 851E8A0073;
	Tue,  8 Oct 2024 20:59:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ScXv/CuG;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 572244035B;
	Tue,  8 Oct 2024 20:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCukiAEv9VZQZ9nLEde/rkP2ULqll1fkOnz5ARUZ4OMtd8wkafCUjD6KgWxZH6K4gVRiycLnWf2GNkg4XXjBJ6spA966qAQGeunYR8t74AAqYK/WLuQc0qI47sybzF7G0cpb8jTB7+aWYkR3YCOOCzf1nepRwKwXAvUM2Jw5yJk1M9ASv37oSELWweAhE2qNoZXwjJwL2rf7JXozR6WMvuNXa1CDWxFgXJKH9Z0yFIQUnEBWx+DEbcElaLJTTtbyaz9lnbgN9AkfPeK/9eheb04+qg08pKBWsQQ/WYJByZ47iZkTjWdd6vQ04IMs1F+mwDWkujd6UrP/DS/TuoGg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7SkGvVfTdYFDJ1khyIHXYEC6Qf5X0Loq+as2Ts6G78=;
 b=HnuRM+hlY37myz/SLlQbxyxwl4+TGYuWFiUvTsJ9mKl3ramzWAQL/iQ2MbLJlo/q+rhMz9pSOlOOOesPOGL0mX2RiD+lBXHxcEOOsgRkMeXwo02/X4HF8VvuK2OqjkYucnSmUebO0qCcwXjFAjUNZPVnRVnHPVrkPHXYQ3jufzcBvKCIDRL8AbLJAOpO5YYiDaSOe302N2WL94TkuVTRj8S1+OFf43S+si/Z3iu374cTlYqxxUBEi53A/5jSz+O7AqB0ZRywTmqMMJIAwK6L+PrTpyJ5WYMehIF3jmcb2CZ5aVBTEwi2K9MUlCbtzsfLO6+1AnoH5m0P2Jf+R4kcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7SkGvVfTdYFDJ1khyIHXYEC6Qf5X0Loq+as2Ts6G78=;
 b=ScXv/CuGmAj3NGDzZfwnCdWUGmN/RWtxgGgtR/58n9LKm4nHv9Qa308jOeggISgJZBhXPLPkGtswNShJY+nc5DRMF6RsSkdvTKPO5hJ8VwqrU32opUo/7pOUBlOKwfITOJRfrZjsA2oknEHvCUvC2t0Brgnx5XLIpuoequ7SaRo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Tue, 8 Oct
 2024 20:58:57 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 20:58:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring
 GUSB2PHYCFG
Thread-Topic: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring
 GUSB2PHYCFG
Thread-Index: AQHbDmS7XuIxqPDVR0yP6DvWA5JKD7J8VxoAgAEV4oA=
Date: Tue, 8 Oct 2024 20:58:57 +0000
Message-ID: <20241008205855.zpjwopkzladspdq3@synopsys.com>
References: <20240924093208.2524531-1-quic_prashk@quicinc.com>
 <8fb5bfd8-966e-4f55-9563-b580ad3bb892@quicinc.com>
In-Reply-To: <8fb5bfd8-966e-4f55-9563-b580ad3bb892@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB5855:EE_
x-ms-office365-filtering-correlation-id: 2437d12b-a9de-45f6-c6bc-08dce7dc0707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTlzS3V2NkM1cHpreWlwTDlKbWZjY2lzY205OWdrVzh0ZEpKdzZ4OEZZckZ2?=
 =?utf-8?B?UTFjMTZWRU9NeWZYcU1wNS9VTW9Xd2dWbHViQTlUM1hKditRZHZMUUdoc2dy?=
 =?utf-8?B?TXpvdlBDM0c3Z0FkeFgzYWJjS0VVNXh1dFJIZi9BQXQ3aktEUTdoSlgwZ0t5?=
 =?utf-8?B?eVNkSXR3L1BpZTVpc0hWRTQxY1ArRmRBMlM5NlQrU204V1VZRWZxUElIZU8v?=
 =?utf-8?B?eGFZWDVZcitwYkxMUnlucWpCb1lVS3hpYWsrb0lsbndiZGVXYjlESEROWGFM?=
 =?utf-8?B?Ty8rdkk3Z2pwWW1ROWFxdmtmMG90YjBNQU9iNkp6WGd3Q0FFTHlNSmhHYlEr?=
 =?utf-8?B?R2tLT3h4U3FtQkFBTTBJK3Z5S0l3T3FRdHU3SnpiRElpekRROGVhWUI5OElS?=
 =?utf-8?B?RmVDRVk2TFVLMUFMVVo4MmtZTFdFOXRNckUzVlVBQUtlVGlzMjFPbGo4Q3lo?=
 =?utf-8?B?RkhuOUJHVVNha251ZnRhQ09NenZPTUZZODR5VjhzTE1OaWl6L0VFTTV4SDdH?=
 =?utf-8?B?bzRsVVJGYmd1RkpMTzA0UzdNakFueEZWK1ZyUDlCcS9RTkhFSWN6RzBaQ244?=
 =?utf-8?B?dWpVYzIvZ3RiYkQ3OG1VVW1QUUExNUIrQnlNMFRCbFZaVUtjd3luL0Q4VjJC?=
 =?utf-8?B?OGU5dlo3SFJNaWltblljbWlobG9WOGNFQWJDYkpMdWZBc0owMVFaZmZ3WDJj?=
 =?utf-8?B?Q09TaDZtS2RhMmI0eEY4YUV0clk5TWIyTzJPYmpNZFBzWGM3WndRU1VDTVov?=
 =?utf-8?B?Q1BJUWdic3piYUJiOXFHR2ppMHpKVzJhN0NvVlNKQkZwZGpaWmV5VHlMeUhn?=
 =?utf-8?B?bmdZc0NLNmZIVnJueXh3bHFvY1U2VTd0NHBES0JXYUwzWnNZUVdjL0ZGdDBX?=
 =?utf-8?B?TDRIZjUrUEtiQ3VRRDRkM2l6Q0ZQSHkyM1NtVFRpZFBFaFJVUkQzczVucDdC?=
 =?utf-8?B?UTh0enlwZzB0ZzBNQVBBclhCYmk2aWI4NTI5anU0OXpxVVAyekJ2YTY4Z2xJ?=
 =?utf-8?B?K29VYk0ycEM0djdLQmRUSnIrVVRNUFg2UG8veldwbFVUNU1LY2wzNGZKaEJ1?=
 =?utf-8?B?ekFGKyswak9oaEt4dnAwUm5CRUxKZStWa1REbTBmRTlOVVpOdjF3RHlCUTQv?=
 =?utf-8?B?ZTRSWTlMVVFRazB2TEhBQXVqei84N096SVRlQUNBTVJqV013U05TbDN4ZWRV?=
 =?utf-8?B?MkFaNXdsZzlDUTdiWVFnbUFFa3hsZkNjOEQzd1VLRVM4YmpKK1VFZkcyR0lX?=
 =?utf-8?B?Q01nK0NPdHJGT3RRODZhdXFIb1dVYmdQaUNzeHJJR2RYejc1UmgzQ0w2MWJX?=
 =?utf-8?B?NG81bUlXc3IvODJZWTVMQ1VmQzNpeWFMeDJ2dDRydUR2YUIyNlNWRkhyTEZi?=
 =?utf-8?B?YnJ0RzQ1RWM2MUsxNlF6d0h2UUNIQjE4RFNiV2kyeGJnOGdMU0liMFVVbXVt?=
 =?utf-8?B?SFZaK3J3ZjlOMzNOMEh5Slo5RXREZUd3SHZCRUljdE9FZ3hTdnJvYnZzTWxE?=
 =?utf-8?B?eDF5SXBCQThEclF0UWNFVkRzVnJCdGpRbWtJYmdaQis3ZWdycDVvL1FoSk9X?=
 =?utf-8?B?UUI3dE1YTWl2SlJGSWMvVXVudnd0bi9tU3NUMGJUTUJiTnBodXhCZ09QaTkr?=
 =?utf-8?B?YUFxSmROdGpNODVsOWRsYkwyM09OV1gwRUdRMU5YQVdmRFF1NXNScW5taVFq?=
 =?utf-8?B?ZlN5b3VGajEwRW5Qek0vU0dtcnU3R2ZneXdXWm43VGppYngyUlBCcDJCUVhG?=
 =?utf-8?B?RkY1OU8yVU9HMHhiaHVqU21SR291STN5NFhNa2dRN1RJQVNEQ2h0ZVJLc21D?=
 =?utf-8?B?b1UwelpzZnFqRHVSMGxFZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUVYdFBZcUNVTUJLQWVKM1JCQ2Z2aVB0YWhmdDcyZlJEdTdqQ1pVSjdvU1BN?=
 =?utf-8?B?UWJDRTIwOGRWbWQxaXdRTWtRdEhnVW9hSkZvNXlYUkpGempCQlBRTHRnTyth?=
 =?utf-8?B?TDFYL3AxMGN3Y0U3WG1Ob01yTklhaGJKYW1TQUVJMzFHUE5mdmRZQi9oUmMx?=
 =?utf-8?B?T1E5bkg2djZFSThuNzFHUVBiUThwTHdJVTh3eUgxbGx0UTBRVHgzcFlYdk9M?=
 =?utf-8?B?dUpqMklhZFRTc21pR0R2WUthdE1hTFhwWU42QUsrWldZdVUramZvNExvdkln?=
 =?utf-8?B?b1R1V3F4LzNDZUcvdUozUWpQRFV4NldCcDNJcXhWNU41Q1dsbUFkWUJjRHhZ?=
 =?utf-8?B?bkhWMGtqR3MwQmtrbzJXV0s3QTZ3Zk5wcCtIRGJJdGE4Y25IN29mdFNES1JJ?=
 =?utf-8?B?WkVkbVZQam9xbTRWaUlKQ3p0WXlKVkpKc0ZVbXdJendTYU8zcHcvZlNtV21J?=
 =?utf-8?B?ZlBoS1FLRS83dnFISXE2SVlrb05KUTV0ZGtFem1jREdUWU1zemN3R01kQW1j?=
 =?utf-8?B?SldNMFhDenQ2c2RJaENhTnh5Y3RVT3pyVnREVzZqSXZwcHd5VlY0bWdnSDQ2?=
 =?utf-8?B?Y2cybDBYS2MyczZYV1QvQVlwRkZTOXBaRlNSM3gvUlgvZ0l4UHBaUlFOcjBy?=
 =?utf-8?B?UmMyYXJmWEc4eVlGcUFnNmxPdXl1SFZRczh2QndpQzZjaEphNVJuZm5wTzJQ?=
 =?utf-8?B?NTRHSmZyb05qQkFtQVNPYlhwQzU4TVU4VnhEZGxtNXVUMjZPdnRDdFJFOXFR?=
 =?utf-8?B?VmQ1MU9vSWV1SlcvcWNsQkhHU3crdjMzRjgvRElwL1hpc242Mm5FSld2cHlj?=
 =?utf-8?B?c1Q2eTBLdUpnMnN2UjhlY01nZmNlRTF4RXc1S2NzR1R4cUYyM0JpSVQvZ0lk?=
 =?utf-8?B?REJUS0hjbXpDdjRUeGVVb210bTJzbmsvbnVyS3FqR29qa1pOeG5MM2Zsb3Ju?=
 =?utf-8?B?YzBlcTBUMEUyVmdBclVSTjliN2lLUlNhcTlEdTc5b0dEdFloU0twbUg1blJM?=
 =?utf-8?B?TFRyT3c5UHN3VWpUMzF0TXBPUTRFWDlxWHBFMnQ0TDRnNjduMW53bnZTOVpG?=
 =?utf-8?B?WXl0YnM5N1FsMjh5UUdRWmlsRWpjcXozU3U1R2p3QlBUa3lHZit4Y1dYalhB?=
 =?utf-8?B?a3hUTmovUDA1WjdiOUFTVjcwQStVbmxnZzdjZEc3QVo0Wk9UTzhGMFpsMzZJ?=
 =?utf-8?B?MXdKWmZTLytjWkJnNFM5N2FCZXhNdkYxU0Y5VVlRamhZS1k4UnRpTkJpbldX?=
 =?utf-8?B?OFhacW9OWnpZNTA3ODEzZ3FoRVU3bVJvSVVSWXVNUy9DWTB0WkdUS0d4Ri9t?=
 =?utf-8?B?M3VRSk5lMk8veGhMSmlVVFRnbEY0bGFwMTFwSmFGYXNhWXlhdVJZUTZLMkcr?=
 =?utf-8?B?ZVBvSm1iSUMycnFiM1l3UU1NanBPaEhIQ0Yzd2x0V1d4U3VUQmV5dU0yWjU1?=
 =?utf-8?B?OXlRVng4UHFDb0NwUWxiQVlyNWxseE1Ga3pQamxWM25uaW44Ujc3TDFxWWto?=
 =?utf-8?B?UXJUMXVlQy9odzl1ZEZxbHNldVJIODBDRHpVUjRqMjFjSGQxZG9YVVU4czYw?=
 =?utf-8?B?Y2RjcnE4Mm9jd2xsOVJOYko4MkFwcEhwbUhoTjQ0Tm95SFhLYkkwNGlqZHBr?=
 =?utf-8?B?TS9Jc0p3R3NlRHI2bkE1WDJLeGdSK2ZXQ1N5cWJDSlVyNERTQWUzNUFvaVFv?=
 =?utf-8?B?QkxLMXU0QnZEWkI4aThuRGJYZjhiRTYxWEFqeHJ2ZzhENWgydlUwOU1uRlQv?=
 =?utf-8?B?QURwZjhjblRRajBVMkxXTUdhNnQrdGYrT20wM1hyWGtSUC9LS2RCYVo5Q1pR?=
 =?utf-8?B?U2NsZElNWTVkQTQrZzYrOUhWMWxkSGNsK0FneU5xN0lQcFJDeUkzaFlmaU5Y?=
 =?utf-8?B?YkQrQ2dOM2lPMkFqSmNab1Z3VkpPTmc0MHJ1MkJ6S282R25OQVhHTFhtNERE?=
 =?utf-8?B?OEdVV1hNeTl5Snc3dWE3WURDamRNSjM5bVM5SERYTzRjaGtLTUlKTUZDYWg0?=
 =?utf-8?B?cDJIZUpPcGM5KzJNNis0dTJBZGFmTlh6dTdRWW1pV0NPZkN2MUhCdVhMbjlX?=
 =?utf-8?B?VW5EWEpzaEozZURLem9tb1BYZUw4KzYxQ3ZCdlcxQzJPZ0Vna05IL1Y3WndI?=
 =?utf-8?Q?T0ranxbzK+Gh+iQhlbXGScR2d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43EDE08A90C2141A8608FF9AE3EFF1F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZAGmJJaIVM5Sw8WClwhG57ZOLrcl1scdPA9sVGgDZT4DcScV8Z8B8heJca7kExrlYfbd+qIWJ2HsyJHNzhwCxGzGUb+qlShebhmknoqUkWn8wPsaPxtv9v1MFBfBUs1ChDyPZkh2lSrnkcFcm4b2T8O8yMq2VawD4qKW6SnryorTGmlMpIR6BY5zOIDQqx4fiYu4eaGT+VMo58xzgDWzkVPRBtLEhGksjkr5MC90XJiuXkev0U74HrwCEMsY4NpqdaXpfnbb9MbhFqYzD2XjWwT6Tixa7AxFnSZVJKDU+UYWdkRKsjwKlcms2yATnfCNDA4KzUL/4dog8wyws2/EA7WeeavzJn96uid9S1geuiorEQga2dxZWatTJ8jcxhPqTeWTEAJ8LKzO12vrZHw2CBtnkoDaJAEpJ0csVZZ0dNw8fcfdQiwQGLsNsNS7yMjkBO2KlfluRZr58yv5fpn037LYnwh3pev7eq0+oxm0c4OG6ChoE+h5RFdd157j3sPI6Ub3jXZ9obgVbAYs3WCl62oPfmc1SfMMnkJi5sXGL0CcRmTniZEGyIfHrMBAPxLlrVZkhZgc6pg/0Dl4CUdgxMpXRMmIWZVOn2A0MeVso9p6DtGZIoU5J9yGJQfwp6u4t1AqoxSSfWkhGJO7t9AqHA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2437d12b-a9de-45f6-c6bc-08dce7dc0707
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 20:58:57.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8AW6ARC6RhpYvBVCtZ/kNZQQGavxCKB6uoSt0B6Q5jEYLHS047/zw7JIL6p/Fqu/CVsfCk9JJSv5JOKlPSYQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Proofpoint-ORIG-GUID: FXnjIy6aJDh60Sx7OD_YMd-aSVI7uY3i
X-Authority-Analysis: v=2.4 cv=IOpQCRvG c=1 sm=1 tr=0 ts=67059d18 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=C4BuzJeHv7ygLYlxHjwA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-GUID: FXnjIy6aJDh60Sx7OD_YMd-aSVI7uY3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=538 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080136

T24gVHVlLCBPY3QgMDgsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gSGkgVGhpbmgs
DQo+IA0KPiBJbiBjYXNlIHlvdSBoYXZlIG1pc3NlZCwgY2FuIHlvdSBwbGVhc2UgcmV2aWV3IHRo
aXM/DQo+IA0KPiBUaGFua3MgaW4gYWR2YW5jZSwNCj4gUHJhc2hhbnRoIEsNCg0KDQpTb3JyeSBJ
IG1pc3NlZCB0aGlzLiBJJ2xsIHRha2UgYSBsb29rIG5vdy4NCg0KVGhhbmtzIGZvciB0aGUgcmVt
aW5kZXIsDQpUaGluaA==

