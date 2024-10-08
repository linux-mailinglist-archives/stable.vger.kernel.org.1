Return-Path: <stable+bounces-83080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5E99555F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D838E286D77
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1B1E1300;
	Tue,  8 Oct 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emUKcEtd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AaqmYiLR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F1224CC;
	Tue,  8 Oct 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407515; cv=fail; b=e+MbczriBx0qMLuF+h+Qz9kFNj3XYmkEsnD0PqlkuAvBi3Gu2pNMM8PvkiY70RlvDtkLlPOCB8yBnFMF/TloGZ5vyH4p39DQMb4kJpCP9/6SmR/LKwoeGxtbaJoVP2ozUzM3N6iiJwELcmhxXbYeUSCyMD+tbM1eS/BGQCRroJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407515; c=relaxed/simple;
	bh=kwERdzMxENkUrsvGzXwuHiZtlvSMhCe38HOHaj2xd2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDLuziBt+vm3nqlY5ODIAdBg4NyXIMtT7g6weYlatNjjso4qXVnlxjvu98tV5M66C+LyCkkQ0W7nEoL1OQ/+AQiuYWardNWPIlSi2eSboOpgZ3wXaYoYfKrNAc6riTqDN53QA0mEYdRAJ33mQiCOBX8QcAL5fDEDc9ON0uMGN0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emUKcEtd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AaqmYiLR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498HBg91031034;
	Tue, 8 Oct 2024 17:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kwERdzMxENkUrsvGzXwuHiZtlvSMhCe38HOHaj2xd2I=; b=
	emUKcEtddX9andrWtF7La4Na4KL8h0ehaGFdd2Up0DxTtREmvOdf9OYByyhD4CeL
	ybMe0HO3senVvLebiseemhEn4tRGR50dQ4CmgaUxH29/BvDG1G2N5+vv7Qb1GAqw
	+vFHdIK+rS4lzXGkCN6a9EgBDWKB/sUUREvrRjN8gZ9aIEQk2DEcKDkQd1wGLih9
	G60mp0xXOh2sLSwfJgOKA+BlnEvOb2IRFaBj8675/J9xQSpeFXqglH61wjT3f7xe
	sYSZbehY40+oaT3uH/MKoqIHo2lVyT1P3tXg2vPKlw3GpKOcUQFmaFgKlUnYTQez
	FjxEEX/FNROTCiudoexbVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063pb96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 17:11:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498HB6jL019062;
	Tue, 8 Oct 2024 17:11:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwdrv1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 17:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw3JXaR5Hfy+uuWXQvnGS1/BwsYTjzg4LY6f3tCfZ6eB5ivyx9bKGGMo+bgaMnnxxDfeSnsU917bVlK2i2LFY2RdFiC/rW/UP6s2FNAA4Hn55HQA3+Akv8hdArkr5A7Gv1mIxOY2uRfOUBfeDOHNNjxi66oX8rcF3kanU0MOKbCn4Rlij6CH7bSv/v56iScAeWD8fLfjLM9nKIQVNJnLv2PUQlS+lrJlM+ffh8q4NFX1f+WPDf6kUXeaVW0yK/wnUvnEfpuyddeCs51hoOfu2KmKnFAJul65nmxEy3WyDm0Qyu8Z/qS+S6ek4SVW0C2slfNEqO53rBiMpnj7x5U8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwERdzMxENkUrsvGzXwuHiZtlvSMhCe38HOHaj2xd2I=;
 b=vF1RGtYRyCIIfzBeB7/BLoBizmeqmioDzUpX3ZDvnczD3qwaYs1RPkLHKZSqzacA+bzgvnCkBHsOl8V9FwiDyrrTMg8mu3j5x04PAPYjtrjoGp1jzlTmo6Wrf0s7ZgpY6+lvCxiIORxZUYqF7R0X5J3kr6STxQRp6dJjgjWlLXqxvLhFB0OOhaK4dOroYV5y/XxhOjblhsDkujmgIj3ae/8Or5ViKczeZ5IbEyNE/XsvlTeYJA2gfMjS1CEsTO91j/82VD5reBLJszBzH/BcU8X0ynd5tNzM/sRpkWqxfnOkl3w30gZdibGLCLNEhUIawdHtsdmO5UmhMrXJ16yHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwERdzMxENkUrsvGzXwuHiZtlvSMhCe38HOHaj2xd2I=;
 b=AaqmYiLRgfC2r3TpyT0C21OjclHhRDzBUsCm4EL13w+CC71kFHnF1LNmrh0UtvJVlM+9BDmPLVTnAHsJFaZbJLxzai5mQk+fZjXDakpoMkB2Te4zJMZbU6fb0lsFaJa9NILj+usJai+CLTPm0olOFjnAt8FdHXPO2EqYumkKVkA=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by BN0PR10MB5208.namprd10.prod.outlook.com (2603:10b6:408:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 17:11:35 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 17:11:35 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-stable <stable@vger.kernel.org>,
        "sashal@kernel.org"
	<sashal@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "roopa@nvidia.com"
	<roopa@nvidia.com>,
        "nikolay@nvidia.com" <nikolay@nvidia.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] net: add pskb_may_pull_reason() helper
Thread-Topic: [PATCH 5.15.y 1/2] net: add pskb_may_pull_reason() helper
Thread-Index: AQHbFn9akz+jHlgFt0KtVylmTtACbLJ8rt4AgABuVoA=
Date: Tue, 8 Oct 2024 17:11:34 +0000
Message-ID: <1E956CBE-882F-4316-B6F2-FF2B357DDC8E@oracle.com>
References: <20241004170328.10819-1-sherry.yang@oracle.com>
 <20241004170328.10819-2-sherry.yang@oracle.com>
 <2024100856-skittle-hazy-9569@gregkh>
In-Reply-To: <2024100856-skittle-hazy-9569@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|BN0PR10MB5208:EE_
x-ms-office365-filtering-correlation-id: 5b4f2890-e8d3-40af-f704-08dce7bc4357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUdTUEVMd0l1c1FuNUY0bEdlaW9SbElscTl0WTdScC9zZTE5YXJ2ZzZGTXZ6?=
 =?utf-8?B?TDVPM2pMaEpzUUhycmJxT2N2T3dqK29YZ1FwajU5SUZZNzVIdSs0cW83dnJG?=
 =?utf-8?B?OGFIejZhUzExaXhWckovYVFaQlNJdG0vbXZ2VGFmbXRwZWorcHdsb3c3bEpZ?=
 =?utf-8?B?SGlDNVBsSmZYQnlpZiszZGREb2E1WkZtamlMOGFHZmh1dk5lVzI3VW9JSXZs?=
 =?utf-8?B?Q08ySjI0c2RGUC9tcTVoSkY4SnMrLy91eTNzNHN5aFlXb091bmtiZjY0eVNa?=
 =?utf-8?B?RVBCcFpCZ0dxWDNDR29mampiNzA2Q0hyS1BpSEdZOEk5SFByanc0blovYUlM?=
 =?utf-8?B?ZUkyUWIxRFd4aGZPcUtSSzJ0Y3NZazMxN2VFcWdoZVVMWG5nTkswenJOK3VE?=
 =?utf-8?B?b0J2UlY0YnYzMHZ0b1dXK0FUb0lHWURoWTk3L3E4cGVSQmFPKzZBL1h6clFT?=
 =?utf-8?B?MmhqaGQxV0d3aDl6TUhRNHZ2WGVsaFZ2YmZvYzNQTkNwbVYwL2pQZ3NLMml4?=
 =?utf-8?B?cXhDN1VKRFFKdHh4OUtFWnFzbnhtM0RnNkEzajFsSnFZWUE1MnhSY1BabHZ5?=
 =?utf-8?B?M2liQ1hPNVBXd0NKRFE0T1FBQXkyNTR6cXR4cjdYV2pMNnpqUGtZdHVQdHFu?=
 =?utf-8?B?ZzFITkxEL295YVpzcWZOVlBNekwrcHIybWFhMm5TUWZqZk9XZFBhN3dMRHNw?=
 =?utf-8?B?V2YxaVdIMW9rWGpqbVFRemcyWkp0MGhCbFZ3cFg5bmJJRzBZcG5JQktERXgz?=
 =?utf-8?B?Yy9PdHliK0tFZ1BNeVc3ZHVSUURUa1ptaGxZUTlZSXdpMVl6SGFqSnFpcDRx?=
 =?utf-8?B?MHNHNnBzUi9MZFRSUFNhMXdxczV2eDhIb2dUYmc4Ly9SeS9MTTVQd05WYjIw?=
 =?utf-8?B?UHVFNGRtR0pFd1RRK1RxeWpKNC9BamNrR24wWlJlT2NqaWhGSkhDRTYzR1li?=
 =?utf-8?B?aHVwSEp2bkhYYURRaUx2VTVRWitXc1BsOHBadzRZb3RoUCtVeDVJOGpybUVR?=
 =?utf-8?B?b204ZUF4MFVYdzhGQTY2NEp4MEJVU21iL3gyaDBTc2VSRDJLK2R0WjhYRlYw?=
 =?utf-8?B?UVRyczhzb2JpQ09lWEVYbnZyaFRHcHdXSHRFYkxWWjZhd1hsc3NmMlpWTjBM?=
 =?utf-8?B?WnJ3aVFqazlmTUdWazU5WVRpa2tWbnBYU2JEZktCbEVJL0NYdE41VHhnM0tW?=
 =?utf-8?B?SDYvQzNpZzN2SjhhZTF1WkRqNVhjN0FSYkI1dzNleERoUVB1TW9iajBNc0hM?=
 =?utf-8?B?VzNHbzU5NGRmOUNDS3ZLU1psUDZKNnpGRGNCWjlNVGRhbW9qVE8xSXd1VnBv?=
 =?utf-8?B?UGVDWDZYb3VpZXUvWmhzU1lia25wdVQwWlpaS1lINTh3d3dGQkptWmpVZTVB?=
 =?utf-8?B?Q08yOXVpdnJhM1lwZnFFNVRkRE9rWEdNWGNORW9ubEs1OE0wcW9sZlpWVVpQ?=
 =?utf-8?B?cHYrZUlDMjVCYVlubFVTL2dWRW9vZ3FXS2twTUljc3lPWEtwQi9MSStUYS85?=
 =?utf-8?B?eUtaZjZYRUtXQ1ZWVnhGZWhSUjNYS3hYR2h5TUc4eXlLaXJqTXlnLzcyUDhz?=
 =?utf-8?B?SlV4WElRZWlLVUlUM1JoQnhRR2VZajZITVQxVG91RTV3ZG9pbVEvbEJ1VHIx?=
 =?utf-8?B?VVlNNEdjcVFiTGppbXhCenpkc3BhZEMxVy8yNFRXMmRiTFI4ajZkbXdCRkMz?=
 =?utf-8?B?cFZXVVRqUXpMOW1KTnp6aFZoQ0o1cHVLQndlTitNYThqMEttcG1OZlEwLytG?=
 =?utf-8?B?ZjhuK2g5NW1TMTdMVEFRa2tQOHlkZTRZWTZsMFZ0bGYxVnRTeDAzcWFFa1kv?=
 =?utf-8?B?azZGcFRiWmZxRzg2S2kvQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2pGMWhrUDY5bkcyYldQTkVxamR0TW0wWWZ5eDlzOVdBTFAwR29aSEtrRStP?=
 =?utf-8?B?dE54U3ZZV2JPcWhDV2crY1VpMzZiR015K0I4dmtIMWE2OGNJL2ZHSkJPMG96?=
 =?utf-8?B?b3FxUUhnNnNKYXdCSFdLWjVDVFhxb21KV1A2N21KUzd6aFRqWFpmS2xWejdp?=
 =?utf-8?B?cThodzBxbTVjRUoxVjJ4UERZZ2piUk92RksvRXFnUTUyNDVtazRvVTB0NjAv?=
 =?utf-8?B?V2R4emJEdU8rVzBTc1BpRzF5N0dmbGNmRDBBN25PaFhlb3lxQmgwNG9Dc1FZ?=
 =?utf-8?B?T0ZJK3RIcEluOW1CczVhWUNiRzZHWklyK01wWmF1NFplQk4xYkp3QkF1SS9M?=
 =?utf-8?B?R2xFVC91TkUvYnpQM1lvUHVQUy9wWVQ1NjBIa2dxemdGbGdydndWOHpTWHNE?=
 =?utf-8?B?VFZ2K3UrNmtUKzF6OTJQVEVvYVN1T2VTVmhPRnM5UXduSDg5ZjhjUmhkR2tM?=
 =?utf-8?B?RXVKM0t1c3N4cVFwbmpFTmk2eHVmeTBkRTluNldLNnYwTG5IemlOcVdxZ0dr?=
 =?utf-8?B?alNCMEdTQ3k0MWorSllFTDBxTWloYTcxck1TSmVzUWZkQ2tZMW42dDRkV1c5?=
 =?utf-8?B?MXFRTjRqa2tVUUpRYmJ5aWk0ckJzNE5JY0pXcmdMYXVqRXhhODRaVFFCVFkv?=
 =?utf-8?B?eHp6NWIyV1FnT1ZpRTJYcnJhOStKa0lVam9UaGNYcGRYR3p6NnNhRnlkdUNx?=
 =?utf-8?B?KzN4LytGVW9pb2pBRGdLVHRzYlIyelNSVXB1VUcrbWkzdEZpQlJEVFZ6ZWJr?=
 =?utf-8?B?R291QXlFNStOcTNJS3MrTm8zMDBRbndvMTN4eVU4bEphKzAwS3NEdUtaZlB2?=
 =?utf-8?B?SmdpZXNtU3hCTnRzV1NsS0FwUW5kYlFEd2x0OUMwTFhNRTB1NHpxUVE2bk9n?=
 =?utf-8?B?cHNNN2hUcFRuTVVmS1NkMEVsZnBVcWFMdDhXc2gwMW1YeU55am4zSnpTREZm?=
 =?utf-8?B?Wlg2UEw4Z2JMNU5VWFdkbGR0YU90SzE3N1RyYUVIWm5pajF6RmwrWUIzV0Rv?=
 =?utf-8?B?WE5pbWNrdk0rSWFQZW5kd2oyMFBwNms5NEtUazBxdUZkTzF3SnEwVStkRWgy?=
 =?utf-8?B?NGlWb1R6SzFkT3ZzbUJ0cEM3RzNUNTRHZ2tkUnJxTWhzckVZQVk5eVIyV1RL?=
 =?utf-8?B?K1llN2RKQVMvd1JVYlEzY29hNjZ6TFpYMHl3VG8xWFN5M3VoT0VLUnQ4UzFX?=
 =?utf-8?B?UmxiS1RBVno4blVLaHVjV1FHV09nTTJBc0UwU3dGOTd5WTdWWUNTZk9xMHE0?=
 =?utf-8?B?Tk9FYWd6dXJaeEhMenhMc1ZLQW9DZ09jTjlhSXUxVG9jaUN4cUVJZUxrVkYr?=
 =?utf-8?B?bXpnck93NldUMFQrN3lwN2s4VllKeW0vaVdWWlFZMGlJZWVoeVE1MVNwcU1n?=
 =?utf-8?B?dTd6YlhGVGNYUzE2Tks0Ris5NTM2Y3g0MWdWS0FaeGhudFRKNWM5cTZrak1S?=
 =?utf-8?B?MmNSYzVsRXkvVVhzbFh0cHdxejZGWTZYU0FWZEtGNXM0NUJ4czMxUkxhNWFP?=
 =?utf-8?B?amdNZ1FRa2VuUlY3d1gwRVVocmVGam54M1lzY3JIdldhZjRGb0pkWjE1VmIx?=
 =?utf-8?B?SWlQdmRLdTczZ2JJTHpackczU1pKWWU5UzlLVE5MN2hIOEM3MlgxU2ZpS0Jr?=
 =?utf-8?B?akJFUTFMMVFZMVltenRoU21zbkhOVzNMQzVKTVFpU2pCYTlka21GR2RnSVZX?=
 =?utf-8?B?WEttZHdUV3I0MDJNdkp1cVlSNzRsV3M3d2tsZ2w2azFDcDRoek5XdFB3SGZn?=
 =?utf-8?B?dFZWRGtjUWpjY09ZSE8xWmlRb2c2NmdZVDQ1dkU0TGZSc1RNdEtTdXpFcmlo?=
 =?utf-8?B?Z3l1QzJnaHBXQ2NucVl2ZTYzZ1lkblhTTEthSzlRQ3J2U2dqckltSzRrRm93?=
 =?utf-8?B?TEllVjNVTlBFZGNUeTdpYTZGZktxNWpncTBZejR4OTVrQzIrNE1sVGhia3pY?=
 =?utf-8?B?S2REZmRramNVMkg0NXFRYWMrZWtDUElxSWpMbDh0L3B3cHk3VjdHc2ZlNm42?=
 =?utf-8?B?eW8vd2xEbDc2cXN0ZVA1UTdMUzNTZWN4Znk3bmEwNVJHQ3lLME0vTFpVYVc5?=
 =?utf-8?B?M1RXd0ZXRHhwQU01VzhPZnFyeUdPVGloUmFuYnpzZXZ0L1NqOWQ1VFhMMVRT?=
 =?utf-8?B?RFJwbzYzWGV1eDliZVdGNkU2MEFVZS9DM0UyT3k3bFhEZTJvNFNEd1dmL0lk?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D20FD453CA943E4CBA5766400F83DDDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WXdx7Ejz+gSB52NG2qAwjKb5frweFuApODLWCv9LxIJOsG2X7pfboaVLWAyrlSk1lax90lbPp7O/wrOJXT7vvnA+IN2vMbeTbH3zRB26154IqvRgWoD/rxN8IVugViyuCGs2cXELwuhWQNc7kCjcGKPQIgVCBpMCTklC/+bU+pF6zPbKNHhstDPUzwp2o6tslkddFig1e8CTpoJ9HrGosz0vl4PjuEhQK1Lfm+7d7tVFbXdWtlzDl7pE4Ji6vwo3ILVjenbWiXf7ClyeKG0Qjy/uURiJ57FrDejd3I4F5bmGScr5bQkKzBpRCj2D3lHARAStCKXp2drthnSFgZAZUay5gnM5/aLmHHvl+ZeX6f/2qR3aYRIQl5eDdkd7/oEi9IqZxeHuv7belEjKb8DyPXkUzoDwpCmYYr8ZZfoghaN91yTYbbpValBRe3Oxs4gtvy48pXQQs0YwoeyKNHJwJs+MiUlR2lbA5gZ3uIDzuUV79RKrRMOniO7EGaW4dWPMGWslDAGoHY4chSjw+pn23k4fs31w5KCdQfjD52lEes1NmubAcQvZdiTD3Y8tekG2tz3abCVbkQut+YyEVGnwxNNRHeJY7b9eVGsNi7B2Y84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f2890-e8d3-40af-f704-08dce7bc4357
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 17:11:34.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ST1KmOLa3HB8YD8dxpmm52zhXVWdlF/a6Of+P2vD9RrpaDhv5gqvLARaO2MemNQaxDriLe5AvK9jT26skg9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_15,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080109
X-Proofpoint-ORIG-GUID: JCYZuEBgDgApSrzfuAnt21uGvjQ_Ut5I
X-Proofpoint-GUID: JCYZuEBgDgApSrzfuAnt21uGvjQ_Ut5I

SGkgR3JlZywNCg0KPiBPbiBPY3QgOCwgMjAyNCwgYXQgMzozNuKAr0FNLCBHcmVnIEtIIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE9jdCAwNCwgMjAy
NCBhdCAxMDowMzoyN0FNIC0wNzAwLCBTaGVycnkgWWFuZyB3cm90ZToNCj4+IEZyb206IEVyaWMg
RHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4+IA0KPj4gWyBVcHN0cmVhbSBjb21taXQg
MWZiMmQ0MTUwMWYzODE5MmQ4YTE5ZGE1ODVjZDQ0MWNmODg0NTY5NyBdDQo+PiANCj4+IHBza2Jf
bWF5X3B1bGwoKSBjYW4gZmFpbCBmb3IgdHdvIGRpZmZlcmVudCByZWFzb25zLg0KPj4gDQo+PiBQ
cm92aWRlIHBza2JfbWF5X3B1bGxfcmVhc29uKCkgaGVscGVyIHRvIGRpc3Rpbmd1aXNoDQo+PiBi
ZXR3ZWVuIHRoZXNlIHJlYXNvbnMuDQo+PiANCj4+IEl0IHJldHVybnM6DQo+PiANCj4+IFNLQl9O
T1RfRFJPUFBFRF9ZRVQgICAgICAgICAgIDogU3VjY2Vzcw0KPj4gU0tCX0RST1BfUkVBU09OX1BL
VF9UT09fU01BTEwgOiBwYWNrZXQgdG9vIHNtYWxsDQo+PiBTS0JfRFJPUF9SRUFTT05fTk9NRU0g
ICAgICAgICA6IHNrYi0+aGVhZCBjb3VsZCBub3QgYmUgcmVzaXplZA0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+PiBSZXZpZXdlZC1i
eTogRGF2aWQgQWhlcm4gPGRzYWhlcm5Aa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+PiBTdGFibGUtZGVwLW9mOiA4YmQ2N2Vi
YjUwYzAgKCJuZXQ6IGJyaWRnZTogeG1pdDogbWFrZSBzdXJlIHdlIGhhdmUgYXQgbGVhc3QgZXRo
IGhlYWRlciBsZW4gYnl0ZXMiKQ0KPj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hh
bEBrZXJuZWwub3JnPg0KPj4gW1NoZXJyeTogYnAgdG8gNS4xNS55LiBNaW5vciBjb25mbGljdHMg
ZHVlIHRvIG1pc3NpbmcgY29tbWl0DQo+PiBkNDI3Yzg5OTliMDcgKCJuZXQtbmV4dDogc2tidWZm
OiByZWZhY3RvciBwc2tiX3B1bGwiKSB3aGljaCBpcyBub3QNCj4+IG5lY2Vzc2FyeSBpbiA1LjE1
LnkuIElnbm9yZSBjb250ZXh0IGNoYW5nZS4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBZYW5n
IDxzaGVycnkueWFuZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBpbmNsdWRlL2xpbnV4L3NrYnVm
Zi5oIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPj4gaW5kZXggYjIzMGM0MjJk
YzNiLi5mOTJlOGZlNGY1ZWIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5o
DQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+PiBAQCAtMjQ2NSwxMyArMjQ2NSwy
NCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKnBza2JfcHVsbChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1
bnNpZ25lZCBpbnQgbGVuKQ0KPj4gcmV0dXJuIHVubGlrZWx5KGxlbiA+IHNrYi0+bGVuKSA/IE5V
TEwgOiBfX3Bza2JfcHVsbChza2IsIGxlbik7DQo+PiB9DQo+PiANCj4+IC1zdGF0aWMgaW5saW5l
IGJvb2wgcHNrYl9tYXlfcHVsbChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1bnNpZ25lZCBpbnQgbGVu
KQ0KPj4gK3N0YXRpYyBpbmxpbmUgZW51bSBza2JfZHJvcF9yZWFzb24NCj4+ICtwc2tiX21heV9w
dWxsX3JlYXNvbihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1bnNpZ25lZCBpbnQgbGVuKQ0KPj4gew0K
Pj4gaWYgKGxpa2VseShsZW4gPD0gc2tiX2hlYWRsZW4oc2tiKSkpDQo+PiAtIHJldHVybiB0cnVl
Ow0KPj4gKyByZXR1cm4gU0tCX05PVF9EUk9QUEVEX1lFVDsNCj4+ICsNCj4+IGlmICh1bmxpa2Vs
eShsZW4gPiBza2ItPmxlbikpDQo+PiAtIHJldHVybiBmYWxzZTsNCj4+IC0gcmV0dXJuIF9fcHNr
Yl9wdWxsX3RhaWwoc2tiLCBsZW4gLSBza2JfaGVhZGxlbihza2IpKSAhPSBOVUxMOw0KPj4gKyBy
ZXR1cm4gU0tCX0RST1BfUkVBU09OX1BLVF9UT09fU01BTEw7DQo+PiArDQo+PiArIGlmICh1bmxp
a2VseSghX19wc2tiX3B1bGxfdGFpbChza2IsIGxlbiAtIHNrYl9oZWFkbGVuKHNrYikpKSkNCj4+
ICsgcmV0dXJuIFNLQl9EUk9QX1JFQVNPTl9OT01FTTsNCj4+ICsNCj4+ICsgcmV0dXJuIFNLQl9O
T1RfRFJPUFBFRF9ZRVQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBwc2ti
X21heV9wdWxsKHN0cnVjdCBza19idWZmICpza2IsIHVuc2lnbmVkIGludCBsZW4pDQo+PiArew0K
Pj4gKyByZXR1cm4gcHNrYl9tYXlfcHVsbF9yZWFzb24oc2tiLCBsZW4pID09IFNLQl9OT1RfRFJP
UFBFRF9ZRVQ7DQo+PiB9DQo+PiANCj4+IHZvaWQgc2tiX2NvbmRlbnNlKHN0cnVjdCBza19idWZm
ICpza2IpOw0KPj4gLS0gDQo+PiAyLjQ2LjANCj4+IA0KPj4gDQo+IA0KPiBBbnkgc3BlY2lmaWMg
cmVhc29uIHdoeSB5b3UgZGlkbid0IHRlc3QgYnVpbGQgdGhpcyBwYXRjaD8NCj4gDQo+IEl0IGJy
ZWFrcyB0aGUgYnVpbGQgaW50byB0aG91c2FuZHMgb2YgdGlueSBwaWVjZXMuDQoNClNvcnJ5IGFi
b3V0IHRoZSBidWlsZCBmYWlsdXJlLiBXZSBoYXZlIGEgYnJhbmNoIHdoaWNoIHdhcyBmb3JrZWQg
ZnJvbSA1LjE1LnksIGFuZCBJIGRpZCBidWlsZCBhbmQgc29tZSBzbW9rZSB0ZXN0cyB0aGVyZS4g
VGhlIGJ1aWxkIGFuZCBzbW9rZSB0ZXN0cyBwYXNzZWQgb24gb3VyIGJyYW5jaC4gSG93ZXZlciwg
SSBkaWRu4oCZdCBub3RpY2Ugb3VyIGJyYW5jaCBiYWNrcG9ydGVkIHByZXJlcXVpc2l0ZSBjb21t
aXRzIHdoaWNoIG1hZGUgaXQgZGl2ZXJnZSBmcm9tIGxpbnV4LXN0YWJsZSA1LjE1LnkuIEkgd2ls
bCBhcHBseSB0aGUgcGF0Y2ggdG8gdXBzdHJlYW0vbGludXgtc3RhYmxlIGFuZCBidWlsZCB0aGVy
ZSBiZWZvcmUgSSBzZW5kIHBhdGNoIHRvIHVwc3RyZWFtL2xpbnV4LXN0YWJsZSBuZXh0IHRpbWUu
DQoNClNvcnJ5IGFib3V0IHRoZSBpbmNvbnZlbmllbmNlLg0KDQpTaGVycnkNCj4gDQo+IGdyZWcg
ay1oDQoNCg==

