Return-Path: <stable+bounces-134663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DFCA940CF
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC234434AD
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB1824A3;
	Sat, 19 Apr 2025 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tWYK5oIZ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V0QSr9BQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="s9VgNHJ9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3029D0B;
	Sat, 19 Apr 2025 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025876; cv=fail; b=ZsDWYrdJewhYtr+pCu/haniSDC1pRkUkxy/Evdvj3v9lsqYeGSeBFqzeiYIvDiLLpurVjUcw7pJh2D/C5lQ0BzapkmWGB7PbEiMkJJGuo58vBnCXuoKybr31l/qo/w5M1aV8PulbNQ+F/a3MqhEpFQxT51NTmA4Wlf79OYXDdzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025876; c=relaxed/simple;
	bh=LSI7Ig8TfdAUUhMugoWHOJn71HwfWyegEMBCKA3QFVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4EWRK90wIhKerGuDiITucJXdNkH5C6rh13l6bQ2h7L62DxbkQYY2TFdiM5TNBr9LNpT+LJkLwXUmhF4CCxjdoxtEk2uaPR9uLBoH5NAWkAA2u2jb6iKHTUfb3Ns0eE2DXaVwgxHsZsr2Dp1HuQuicTY1MslY/PgUrsyA/+ktDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tWYK5oIZ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V0QSr9BQ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=s9VgNHJ9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53INIJka020433;
	Fri, 18 Apr 2025 18:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=LSI7Ig8TfdAUUhMugoWHOJn71HwfWyegEMBCKA3QFVc=; b=
	tWYK5oIZop1wkfnwz6zTeChp9OddqP1AxjHLaZrOtp1ThLDnSiCYh59NHzd3EThI
	vNU+7Ht2K32ZkY94og9gXMrMqOEe/i6kI/FBoUZ1sz0TTUzrpKrZ/ISOzXGAKnu1
	b3qMrQwkA4xfvfzB+bXsAddmFZn3BDuR0bxuzf3JOKg5et8CTEjksnrm5hcEXLW4
	RwPC2J1Z+uM2Bn2rGNAWJga4hLXdmoJd6kiBxYRTnRn4eT7InBvjK5Paiz75fAKg
	bDNTRNbIAIVhIjQw6KeHtdol8ccLxPeuMQeKpgnEVvxSIRynGXVJq3oe+DReTP+n
	LP1IQ125WslDy6bIowwKVw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4602t92amh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1745025869; bh=LSI7Ig8TfdAUUhMugoWHOJn71HwfWyegEMBCKA3QFVc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V0QSr9BQWXU5LFbmbDIg4MN4Kmvp6SxSFDR7LvuQLwO/phH7B2C+jurG8jGtPRkTY
	 JLjQ+uZY+dZkVEbA+EfqGC5u+ctQZ2FNOZ8tldM+95CnxukVqVcLueSAwpX0VFgMuD
	 eSWm+1IqoxYKfHWSdWgPTZwPWDmv+N0lBpw0A5a1TjmdgtqiyOEHVRdodsShpukd6l
	 6lV+ThVb/kPnpmHitmHtJckQZP/lbKCRc3LSrohVK4LOlU9DWKuMIbE8vqaXyo0m7N
	 6Eg64do1XvPuFjJV2zjysHHRgtcee1Go6CAIruPFs+PlE7ItCgLcv+ZqiQqD8Dy1bO
	 syNlhJJ1NLtqg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 766014013B;
	Sat, 19 Apr 2025 01:24:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C5FAFA0096;
	Sat, 19 Apr 2025 01:24:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=s9VgNHJ9;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1979B40355;
	Sat, 19 Apr 2025 01:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1ZOb9xcpO4wBUnzEt+pAC0C8g4nJIxpAWJUeM2YEwN/ztEXdd9q4ptYGMlAxFlfZFuj/4SJkWtaLlNZqfIo3AARVkF5NlPSBEmJM7PmZF9139+8PfRqvt6iMqr/XxK2DK5JgNaSMIbgub+vAKL1ixH94UL/5T0Mm5UuTk2gHPTkhAVDJKbIf+GKR0SShh3plvAouQgIHebcaHg9qlh0kIMKeK8hxkbSiBnfflXF3eII3NR4RgeruqZKUChdCltbqGTAeGX5X+QR2riyBfFswDjcYjIQMjWm89110nG1SO9S7WSPmjPR5vDeEfIOBe0kMsNx4jwUoAlhkA4T7WbH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSI7Ig8TfdAUUhMugoWHOJn71HwfWyegEMBCKA3QFVc=;
 b=giHAIPMzXopPdmuFiCCl5QqneoqE3L9Q/9vFkOSmdMczsHmoT7TaeWemR2bDxVnytKITOhQycTNSz599fH1SRvR7b938mtMqfRlmod1fQ4AGIN+X44eUIBRaO9doIDrmBce8ClBVLVpYeMPJ3prB+XqkpkKIM6dLR17YOGriiYfFhY+flm4wHXrs5D5Hj2olVORHUr+nvrwXwwLKulZXNF8RSbyN82tzd/WgjLwCN2GNJDOZ8bMgLbrHihcN4GfdxTRpZybkugbOZJrgzZehBoMit5U6iaNblL60sYdb9YiBnXRIyj+7RdejkZ1SQUmGOSNWHyE1cTzpEQsmZSjPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSI7Ig8TfdAUUhMugoWHOJn71HwfWyegEMBCKA3QFVc=;
 b=s9VgNHJ9Sq3EI5JzyjJ5KcvZgevwuzmgYlnmA0adW95AFT8aoK/MakTP10f54gWnaM7cfmCmriXeBHV5/ZGLPwihNEHkcFGbVWpoqhszdytGx6sI7bSALZDYGhLFaTY7aheutr+NV6gjFa0Kip5jrVnxmRvOhDDlKsGDhztUePM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Sat, 19 Apr
 2025 01:24:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8655.022; Sat, 19 Apr 2025
 01:24:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbrrcVIJ3v9LAKC0KlURLuwZqSArOqNhAA
Date: Sat, 19 Apr 2025 01:24:16 +0000
Message-ID: <20250419012408.x3zxum5db7iconil@synopsys.com>
References: <20250416100515.2131853-1-khtsai@google.com>
In-Reply-To: <20250416100515.2131853-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: 533b7973-52bb-4b2b-acf2-08dd7ee0e6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVRDVDlsdHB2Q3Z1d0M2WllMbHpWYnNQUitMKzFoZ2VlQVFkSEhqaEovSEN5?=
 =?utf-8?B?VGdDVWdBKzhXZnBWZTJVM2FMdmdCdVZZdVhISkRJcVoyM3B1a2o1MEhhd3Zs?=
 =?utf-8?B?bjNTVjBNZ3czL1RRMkprOXptYXRSVEJHS3IrdGIzaTZxeWRCWE52YnNjbk52?=
 =?utf-8?B?WGpDTnhPMEl1REhFUUNtNEFhbWJ5alhwajFRY2VPNGtXT1pqWmZUUW9NbEZw?=
 =?utf-8?B?dVoyZWZmbjdjTVc3blg3WkVjQjJvRTNuYkZPR3dBaXJMMEhidVVVWHpZVzIv?=
 =?utf-8?B?ODJEUUxKVmhlNWJpUERBRGEwWGlhWm5jRnpUZEdiWXkwUnoyWDZVSno5S0Jm?=
 =?utf-8?B?bE5VUm5TRnpwNDB6N21GbWZSUWxxOVpja1RhK2xTUkdQL3RrWXo2SDJ0WkVN?=
 =?utf-8?B?UDZxZCtqVkFWN2hIcmJmMFU1b2ZWWFdJTEdmK2tjcWt0RWdtYVFBZWlnemZy?=
 =?utf-8?B?L0hiaFdhTjBQRitLNzA2UmhKNnhGNjZFQ3VubGdWNGtuNHpGUGY4TDV2OWRu?=
 =?utf-8?B?YStza3RNQkorcEZDbVRldkhSaklOVmxGQXhEQmhBZkRiMWlwdkxtNCtURUpj?=
 =?utf-8?B?QkNqNkZINWdqdWMrUWNnNzZWS005aUhrY203NmpoRUhDK1dnNUE0RFkzd3hL?=
 =?utf-8?B?ZldyUUlybS9Hb3ptTUJTNnJyRGtsZW40V2ZTUDU5VUI4a0lBVkdXU0ltZEkv?=
 =?utf-8?B?NkF2OWxJcFFzWjNYWmZmaFM3RVZGRzUxVElOUGIzNG1xaTBRbUVTVk5xWm5x?=
 =?utf-8?B?dDk0SGw2anExVU4yQ1pab01Bcm9qYnJwVVloKzhac2Nacit3T3ZpZ2hvWmpj?=
 =?utf-8?B?cnI0a1ZCRjVjdGI0WDZLb1VHV0JsVlJ0YjRPeHNxK1JjVkR6NDZNMGlPWTdl?=
 =?utf-8?B?a1FwM2NhNW02T2lQZlJTVm0yUXhIVVhxRzJxVUdUUVliVDc2N2lQRzhWY2Q1?=
 =?utf-8?B?RTFMTVUvdkhQZHQvbDZDWllzeGhUS1V6T0R6bjRpQWpVRWdab0xLanVNQlhF?=
 =?utf-8?B?dVFzZUhaOUNTUEVYaWRKak9vZXpCQ3ZHWCtEM08yUUhGWUwxK3gvYmRudStZ?=
 =?utf-8?B?NnVXQVBRempERnRGOTJIVTIwU3BVM1ZMck1uQnZlbi9BV3dnRTVieG02L1lW?=
 =?utf-8?B?VXFycTMrS3JBWmhYSFpuTEtaK3o2Q1dYczhOeXFMSkpycjJReVpXcFkxOEJT?=
 =?utf-8?B?L3BiRG9qUnE0cHhXZ3JKQURKZUxIeENqRXBPNWdId0dPbCttM2N2UU1DUzhp?=
 =?utf-8?B?T2d6em1hVmZ4NkwydytJcWdlQ2VJVUxtcUQ1ZE9zdFcya0s1VEpERXh6K2VU?=
 =?utf-8?B?bERnV3h6eTJocjQ2WkhMSWkzREVkSkE0UlF2UzZ2LzdRR0NjOU5yY21oWVV2?=
 =?utf-8?B?NFh3NWFQcEROLzVvRGgwNzZBaGtYOU9BeVA0TkV5WDhlT2ZOSXRFZjBBazhV?=
 =?utf-8?B?cHRwbGw5K2NxZU9iR1cyMnUyUnZ6Z1dGWWcwMDloM1RseFl1eWUrVnBTTjFW?=
 =?utf-8?B?TlI1bUpvZGpaYzVNTFhYaGsyUXZjTUhRdVdmY2RLVzViRWFXMGxrSEl1MmtU?=
 =?utf-8?B?bWwzclZYNzNCbnE5anNmcnh5Mmo0ZmtsV1ZiRitQSEplTlpIVFVyZTFVYngx?=
 =?utf-8?B?NmlpTzUycWlzRy80S1pwSzBYa0dZQnBXUVQzL3NTbEsrb3dmcktqRytJajR3?=
 =?utf-8?B?QXYrVnN1WGF2VVI0WnFWOXNwd2cyek1tc0tOZHhiR0F4M3BqTXZRVW5LYzZt?=
 =?utf-8?B?aWR2NG15WlN5S0I3NmFRRi9ZRFlYdkRaQ0VnQStmck5CTmttdGV5alVNamJr?=
 =?utf-8?B?S0lSeVRiWmluenZGdHZsNU5WRE9uckJrYk1ERDVxNlhGaFh3VWxwQlhVTWMz?=
 =?utf-8?B?SE8xVXc3ejU3dlpTeFZCcXJHRDhqWFJQZ3lySmo1bWNVREdOZFJFREVxNzcv?=
 =?utf-8?B?R2ZWYW8vTzkvZjJFcnd3enFHWVB5SlRycWRmenNHWFZTMzFjemhkM2JYVmsx?=
 =?utf-8?Q?JA5FYV/Dm4V3gDzZgvU/AIOEQ4gTb0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFdPUFFQUVJHcGczSTNyM2lNNmFaTm5OZzJoMkFKOTR4dU1TS1dpc3RReFVD?=
 =?utf-8?B?MktHM2dNTnNJU3d2VHR6RnNvMUsweVZHenQ1VGtnZXV3L1Q3b0JEZ1RPaHl0?=
 =?utf-8?B?clJoQVlTZXF3aE9kZFdZQ3hMcXZJZVZ2N3MxKzgzd3FYQmZTTWxsWStZQlEv?=
 =?utf-8?B?Z3lvZlRYcDJqSHlQbkZIVUpoSk9hdGNoQzRiZjAwWGU3dEdaODdUQXpETE9K?=
 =?utf-8?B?TUxabVdNUW4rTFQyZGFQUXM1U1Z5R2N0bzdNcFhVY1hsbkp3Z2lrQXAybnFo?=
 =?utf-8?B?MDlKVGxUZUowOUtZeE5SSTU0L2FyS1owSHJVZ1l6RnVGYzB4NGZnelRHYkZ6?=
 =?utf-8?B?dW1hL1dMUVl6KytJb3hjZHFQOTV3UG5xV05QY1d4OTdtenI5VGxMaXZKR01a?=
 =?utf-8?B?V3NLRjBXSHFuN2pYVGQwQlcyTlAvWlNjZ2dJeUtIUDVtOXZNd1JIK0Nhd3hp?=
 =?utf-8?B?OUZrOU5aTGl3SktScEpsTk9hSVlqUVRUZUxJd3RJbktoR0EvMnVyOXFmdTUy?=
 =?utf-8?B?Ri8rSFRESEQzYVFDRGxRajRJSVFvcDc1anRtNmc3cE9BZk0zeGtMSjFvTjFE?=
 =?utf-8?B?UEliYm90TVhkcFRZMG5IMGZuRHpMZmhBYmdSS21IRFNnejcyTzJGeFgyYVJp?=
 =?utf-8?B?ZmhHSzJvNm0wbEpTT1dtVEZ2dklYSXF4K0FsZEduOFhuL1pibjRYZ3JiUzNC?=
 =?utf-8?B?cTdPNkt6WFlrZ1FDVWJTaUtmbHE1SytqclJjOU9wK3ZTem13d2pJeVVjcStT?=
 =?utf-8?B?TzZleno5S3V0SDhXMVBqa1RTcXRWd3BrSmJZQ0IyTzBmV3ZPNUJSVmZxbERw?=
 =?utf-8?B?YkVzT3JGNE1odjFBKzdWS1ZaVWlCb0ZURmZQUFkrcllVT2VZRjhzWHY3cTU4?=
 =?utf-8?B?akZURitaS0FDcElDVk1mTkUwVzJsdDE1cVdSZGVyNVJJdkUyZng3QWoxVngx?=
 =?utf-8?B?Q0VXbzBaci9qUldPTjNxczkxOGJ3WUlRK1Z2dkJ3VlgvbEFsTmtuZlJYQ1F0?=
 =?utf-8?B?Y2x3R0RYSXg3L3NhZXgzbFBWS3dXc0ZQeVNDN3F2ck5aL0RjOFpOenRTS0x2?=
 =?utf-8?B?RTg2Z2I5S2J4Wnlzd3FnKzRMU05iQThGNDZLS0pqTVRadyszUWp6ZGgrUnpU?=
 =?utf-8?B?Yk0rTDc5UGtubm5lSStPYUpFZjJRcXBwUmRDckhTVG5tMnAwTDVTdUd5WjFH?=
 =?utf-8?B?NWQyUllpaVRzdUo2dXZLVUJMNkV0aUh4N0R1bjkwQktqNFp0K2ZieUU4cE0r?=
 =?utf-8?B?U3JzMDRxQ0dZNXhEQUt5eEF1dDVwZlAwbjN0TjAvMUo0NkJpdTNVK3cxdzlR?=
 =?utf-8?B?S3hIWGNJYlVOZXRFd05CNCtQdjBNZzdIeG90OHRYbW1FV1ZlTGVLd0dZYmZW?=
 =?utf-8?B?eGZVY3NoSkltZ2I2TC81Q3RtKzk2cEx4dDlxSHg1RVpGU2IzTmhuMGZ5Z3lD?=
 =?utf-8?B?OTlwWTlaeDFRK2ZoZTBxZFN1TDBBSmdKWWk0SjJHdkZMVjhzZEJyV1dxNnRr?=
 =?utf-8?B?a3NjQnArR0tqKzZ4emJnanhuc3gvUndqQWRiY2ZVVTFlRDlUN3VmK3NYUXpj?=
 =?utf-8?B?c0ptU0ZxZ28xUXJMR2szbmFjcVJLSkdzUUFjUkRwV3RuOHZqTFdOdGpsV0pG?=
 =?utf-8?B?YTkzenF2a0MwcHo2K2JxYVF3dTZYWGg4djJwK2NkRHlleGg2d1ZQeUFLSG9j?=
 =?utf-8?B?UlcyTjhiNmluZG5iNEtnTENNaXNTZ3NHZk9hYmJ2Y1NrdVRpLzllNlZVSVgx?=
 =?utf-8?B?VHlOVWViSC9La2h0dCt2aTNCaUNpOEoyemdLbnJ0c0NWQzJJQS9qM3FCSUNI?=
 =?utf-8?B?YVJaYjZJT2g1VVp6a0h3dHBtSmdzTFRhbisrdk1ndUhnZUE1cHVwQzR4bGNq?=
 =?utf-8?B?VHdtRDNDVHFIT3EyYUt1NFlJZXp5bjZGUnF1aVBNeitXRXk0WmlnM2gyTGsw?=
 =?utf-8?B?Vm1SdkVIWk0zNmhCRkUzWXhHcXhYTUNTRkJYRXNxSUFpVmxSL3ZmcDR4amI2?=
 =?utf-8?B?NTJLTHI4dWw2QXBMRVBUS3IzTjVwRS9WN3ZaSDhkdndYMkZ1Ky95V1F1bjdT?=
 =?utf-8?B?MXFxWmtWWFdSL2pmaFlFVnR6dS9mWDNlYnBXeG5UWWljK1V5VGNSUFB1aVBW?=
 =?utf-8?Q?V86XXZxJ9AntNoq3OU1y91XNT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <707A3AF380CA9346808C6C4ED54B8554@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0iPBN5jdPqujPrsFHFu8AEh+ehHdXhW0msncRe7MeVSzodP9AQolyA3KJvQVdCzpHqSIs0DfxRkAjms3hQLzJ+8hh41Uq/bthQjk+6Jazz1wU/aHB4LYdiyGVDOLX9nLhja09vow/HmR/V+RRxiyWC00ebpJsELL9N04oanPr4MQkRSU0fqBs/g3inhXC6HMxcoFlTdIcc8ZVzSvgdhKa8D4DZm+8mKsLzeCgA01bRy+fCurrpcUkopEiGaDjslOMheiLinrRibWWnrkaNZQo5aNiAuepYp+Rxjw7a+tx1CPuJU46DBZNscZMp3NkYzpKSEn+fvaILiVrEU1MkSoWe5Eb3h3DhSb7zlp/3q/2xv/iv19WELRdVGDNSOyGqJJ2tmVumXxqo2m8/BJYTHK0B77fbkGBigJLddOdAzc60D2s6kWmSKRk45NmkBVO1dzAq0+lN0RkLGFk9L+d8iH24qShf6f7OdtsY6b/hpsPbsnSv1GPrBddmS8Hyznm4GHz9PjT/wChCeQSM8VUDi1KAbQ/f+zFFeNbCCshySkmQ4C13sdS4I5HCKcmZnasxupCD+wG9qME0jx0NZ+6XhPhjKqIqB5Ih43MzLJmllx9Rjx2pPjWNc8Z8Bxd1Q8XmEy+oFWnVbmJGHWdopJTQMgrg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533b7973-52bb-4b2b-acf2-08dd7ee0e6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2025 01:24:16.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mstxA0zn/dEPqW4r4xUyZvFlB0l9zkLVe3SclKW1SR1l++8uuuCa4xXHlV3CdSMdImtaJ8aguneT0hy6PsXn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
X-Proofpoint-ORIG-GUID: SF3GlyVyQmYu-YRvs80GPO7awYGVIi4C
X-Authority-Analysis: v=2.4 cv=Nt3Rc9dJ c=1 sm=1 tr=0 ts=6802fb4e cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=JHzk6tn9kbUIW2eQ6dAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SF3GlyVyQmYu-YRvs80GPO7awYGVIi4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_10,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190009

T24gV2VkLCBBcHIgMTYsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IFdoZW4gZHdjM19n
YWRnZXRfc29mdF9kaXNjb25uZWN0KCkgZmFpbHMsIGR3YzNfc3VzcGVuZF9jb21tb24oKSBrZWVw
cw0KPiBnb2luZyB3aXRoIHRoZSBzdXNwZW5kLCByZXN1bHRpbmcgaW4gYSBwZXJpb2Qgd2hlcmUg
dGhlIHBvd2VyIGRvbWFpbiBpcw0KPiBvZmYsIGJ1dCB0aGUgZ2FkZ2V0IGRyaXZlciByZW1haW5z
IGNvbm5lY3RlZC4gIFdpdGhpbiB0aGlzIHRpbWUgZnJhbWUsDQo+IGludm9raW5nIHZidXNfZXZl
bnRfd29yaygpIHdpbGwgY2F1c2UgYW4gZXJyb3IgYXMgaXQgYXR0ZW1wdHMgdG8gYWNjZXNzDQo+
IERXQzMgcmVnaXN0ZXJzIGZvciBlbmRwb2ludCBkaXNhYmxpbmcgYWZ0ZXIgdGhlIHBvd2VyIGRv
bWFpbiBoYXMgYmVlbg0KPiBjb21wbGV0ZWx5IHNodXQgZG93bi4NCj4gDQo+IEFib3J0IHRoZSBz
dXNwZW5kIHNlcXVlbmNlIHdoZW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpIGNhbm5vdCBoYWx0IHRo
ZQ0KPiBjb250cm9sbGVyIGFuZCBwcm9jZWVkcyB3aXRoIGEgc29mdCBjb25uZWN0Lg0KPiANCj4g
Rml4ZXM6IDlmOGE2N2I2NWE0OSAoInVzYjogZHdjMzogZ2FkZ2V0OiBmaXggZ2FkZ2V0IHN1c3Bl
bmQvcmVzdW1lIikNCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiANCj4gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3IgSW50ZXJydXB0DQo+IFdv
cmtxdWV1ZTogZXZlbnRzIHZidXNfZXZlbnRfd29yaw0KPiBDYWxsIHRyYWNlOg0KPiAgZHVtcF9i
YWNrdHJhY2UrMHhmNC8weDExOA0KPiAgc2hvd19zdGFjaysweDE4LzB4MjQNCj4gIGR1bXBfc3Rh
Y2tfbHZsKzB4NjAvMHg3Yw0KPiAgZHVtcF9zdGFjaysweDE4LzB4M2MNCj4gIHBhbmljKzB4MTZj
LzB4MzkwDQo+ICBubWlfcGFuaWMrMHhhNC8weGE4DQo+ICBhcm02NF9zZXJyb3JfcGFuaWMrMHg2
Yy8weDk0DQo+ICBkb19zZXJyb3IrMHhjNC8weGQwDQo+ICBlbDFoXzY0X2Vycm9yX2hhbmRsZXIr
MHgzNC8weDQ4DQo+ICBlbDFoXzY0X2Vycm9yKzB4NjgvMHg2Yw0KPiAgcmVhZGwrMHg0Yy8weDhj
DQo+ICBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUrMHg0OC8weDIzMA0KPiAgZHdjM19nYWRnZXRf
ZXBfZGlzYWJsZSsweDUwLzB4YzANCj4gIHVzYl9lcF9kaXNhYmxlKzB4NDQvMHhlNA0KPiAgZmZz
X2Z1bmNfZXBzX2Rpc2FibGUrMHg2NC8weGM4DQo+ICBmZnNfZnVuY19zZXRfYWx0KzB4NzQvMHgz
NjgNCj4gIGZmc19mdW5jX2Rpc2FibGUrMHgxOC8weDI4DQo+ICBjb21wb3NpdGVfZGlzY29ubmVj
dCsweDkwLzB4ZWMNCj4gIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9kaXNjb25uZWN0KzB4NjQvMHg4OA0K
PiAgdXNiX2dhZGdldF9kaXNjb25uZWN0X2xvY2tlZCsweGMwLzB4MTY4DQo+ICB2YnVzX2V2ZW50
X3dvcmsrMHgzYy8weDU4DQo+ICBwcm9jZXNzX29uZV93b3JrKzB4MWU0LzB4NDNjDQo+ICB3b3Jr
ZXJfdGhyZWFkKzB4MjVjLzB4NDMwDQo+ICBrdGhyZWFkKzB4MTA0LzB4MWQ0DQo+ICByZXRfZnJv
bV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gLS0tDQo+IENoYW5nZWxvZzoNCj4gDQo+IHY0Og0KPiAt
IGNvcnJlY3QgdGhlIG1pc3Rha2Ugd2hlcmUgc2VtaWNvbG9uIHdhcyBmb3Jnb3R0ZW4NCj4gLSBy
ZXR1cm4gLUVBR0FJTiB1cG9uIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoKSBmYWlsdXJlDQo+IA0KPiB2
MzoNCj4gLSBjaGFuZ2UgdGhlIEZpeGVzIHRhZw0KPiANCj4gdjI6DQo+IC0gbW92ZSBkZWNsYXJh
dGlvbnMgaW4gc2VwYXJhdGUgbGluZXMNCj4gLSBhZGQgdGhlIEZpeGVzIHRhZw0KPiANCj4gLS0t
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAgIHwgIDkgKysrKysrKy0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIHwgMjIgKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IGluZGV4IDY2YTA4YjUyNzE2NS4uZjM2YmM5MzNjNTViIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBA
QCAtMjM4OCw2ICsyMzg4LDcgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVj
dCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICB7DQo+ICAJdTMyIHJlZzsNCj4gIAlp
bnQgaTsNCj4gKwlpbnQgcmV0Ow0KPiANCj4gIAlpZiAoIXBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3
Yy0+ZGV2KSAmJiAhUE1TR19JU19BVVRPKG1zZykpIHsNCj4gIAkJZHdjLT5zdXNwaHlfc3RhdGUg
PSAoZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpICYNCj4gQEAgLTI0
MDYsNyArMjQwNyw5IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdj
MyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJ
Q0U6DQo+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICAJCQlicmVh
azsNCj4gLQkJZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiArCQlyZXQgPSBkd2MzX2dhZGdl
dF9zdXNwZW5kKGR3Yyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiAgCQlz
eW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIAkJZHdjM19jb3JlX2V4aXQoZHdj
KTsNCj4gIAkJYnJlYWs7DQo+IEBAIC0yNDQxLDcgKzI0NDQsOSBAQCBzdGF0aWMgaW50IGR3YzNf
c3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIAkJ
CWJyZWFrOw0KPiANCj4gIAkJaWYgKGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19S
T0xFX0RFVklDRSkgew0KPiAtCQkJZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiArCQkJcmV0
ID0gZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiArCQkJaWYgKHJldCkNCj4gKwkJCQlyZXR1
cm4gcmV0Ow0KPiAgCQkJc3luY2hyb25pemVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ICAJCX0N
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA4OWE0ZGM4ZWJmOTQuLjYzMGZkNWYwY2U5NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IEBAIC00Nzc2LDI2ICs0Nzc2LDIyIEBAIGludCBkd2MzX2dhZGdl
dF9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaW50IHJldDsNCj4gDQo+ICAJcmV0ID0g
ZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+IC0JaWYgKHJldCkNCj4gLQkJZ290
byBlcnI7DQo+IC0NCj4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+
IC0JaWYgKGR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4gLQkJZHdjM19kaXNjb25uZWN0X2dhZGdldChk
d2MpOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAt
DQo+IC0JcmV0dXJuIDA7DQo+IC0NCj4gLWVycjoNCj4gIAkvKg0KPiAgCSAqIEF0dGVtcHQgdG8g
cmVzZXQgdGhlIGNvbnRyb2xsZXIncyBzdGF0ZS4gTGlrZWx5IG5vDQo+ICAJICogY29tbXVuaWNh
dGlvbiBjYW4gYmUgZXN0YWJsaXNoZWQgdW50aWwgdGhlIGhvc3QNCj4gIAkgKiBwZXJmb3JtcyBh
IHBvcnQgcmVzZXQuDQo+ICAJICovDQo+IC0JaWYgKGR3Yy0+c29mdGNvbm5lY3QpDQo+ICsJaWYg
KHJldCAmJiBkd2MtPnNvZnRjb25uZWN0KSB7DQo+ICAJCWR3YzNfZ2FkZ2V0X3NvZnRfY29ubmVj
dChkd2MpOw0KPiArCQlyZXR1cm4gLUVBR0FJTjsNCg0KVGhpcyBtYXkgbWFrZSBzZW5zZSB0byBo
YXZlIC1FQUdBSU4gZm9yIHJ1bnRpbWUgc3VzcGVuZC4gSSBzdXBwb3NlZCB0aGlzDQpzaG91bGQg
YmUgZmluZSBmb3Igc3lzdGVtIHN1c3BlbmQgc2luY2UgaXQgZG9lc24ndCBkbyBhbnl0aGluZyBz
cGVjaWFsDQpmb3IgdGhpcyBlcnJvciBjb2RlLg0KDQpXaGVuIHlvdSB0ZXN0ZWQgcnVudGltZSBz
dXNwZW5kLCBkaWQgeW91IG9ic2VydmUgdGhhdCB0aGUgZGV2aWNlDQpzdWNjZXNzZnVsbHkgZ29p
bmcgaW50byBzdXNwZW5kIG9uIHJldHJ5Pw0KDQpJbiBhbnkgY2FzZSwgSSB0aGluayB0aGlzIHNo
b3VsZCBiZSBnb29kLiBUaGFua3MgZm9yIHRoZSBmaXg6DQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5
ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5oDQoNCj4gKwl9
DQo+IA0KPiAtCXJldHVybiByZXQ7DQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywg
ZmxhZ3MpOw0KPiArCWlmIChkd2MtPmdhZGdldF9kcml2ZXIpDQo+ICsJCWR3YzNfZGlzY29ubmVj
dF9nYWRnZXQoZHdjKTsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZs
YWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIGludCBkd2MzX2dhZGdldF9y
ZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gLS0NCj4gMi40OS4wLjYwNC5nZmYxZjljYTk0Mi1n
b29nDQo+IA==

