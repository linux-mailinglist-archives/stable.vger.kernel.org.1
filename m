Return-Path: <stable+bounces-28291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CDE87D945
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB501C20B8E
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F843F505;
	Sat, 16 Mar 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pDlM4Jd/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jgq8TB/7"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4DED9
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710577004; cv=fail; b=S34IqGJwrrSWsI6YHEAan4SeWlIzOvvQIRpS1Kc8GCkvtRBtg9pLTYXz9Lv7v/ZohpODhHWYIsEQY4k3hfH4MZk5BCkHJ5EuTWma5UaRjnyTUDyXvdLLe2NaUyW8CtBi4a4eBN/tvrf57ILZogYVjyq6S5TnyqHh1zKJdm0F648=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710577004; c=relaxed/simple;
	bh=h8wowBhrww7mNfGrTWLOEs2gU1Lk1bzIGZR/rvDkH28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKqnomWrNMS7vO53AWYQPqnTICX/s3sJ3bsCiS/xjPvAGmaXTareo3KIUgSvXU7u9gVKeAwCzy5eTWVLBWbbIbXYfsS4MZsFYMax8d5ADcozn166hsiRbtR1f/HN1pWIirIhaLI2PSeomQ0MF80Vx6DgbcOnhuKJXd43KhbMidk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pDlM4Jd/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jgq8TB/7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8167a350e36d11eeb8927bc1f75efef4-20240316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=h8wowBhrww7mNfGrTWLOEs2gU1Lk1bzIGZR/rvDkH28=;
	b=pDlM4Jd/4fJs362xHh6FSnT7ZzpcNEoFqn1hC5y+SHNtLBSHiz+enbyqbUmL3xKRFQIoHjKRfYqXXDYFnJQqdRut/jLH0KR2qkhtoJ7+ZxnZo1YGwkYdBzJ27ofFgkfTwg8cBRAtd0+P1rX8oQbAnAxhTRq+Au2yaKuZTYD2osM=;
X-CID-CACHE: Type:Local,Time:202403161609+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:578900b8-1145-4f7f-8581-d17e242fa494,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:c418f6ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:0,Content:0,EDM:-3,IP:nil,URL
	:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8167a350e36d11eeb8927bc1f75efef4-20240316
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <lin.gui@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1961898147; Sat, 16 Mar 2024 16:16:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 16 Mar 2024 16:16:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 16 Mar 2024 16:16:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eck4ZZJ22CnMkPh1nRsOyi7/yqo9z/e0tgatz+0l53g9OI4HACXeUvv2gT/CxoQCiSqs1+3NKWqf8g7zWP5DsLejJyC/06ENUcb1gY9hQ+3Pzih4uAQuDz4RLrkhmJnbQgbuJGeH/ucJxmyzqXo4UoucRj80ohduM3732E8CUpPUSk/lMQ2Dq9pRkFZhBCfRsS1WCrBd7Xm1Znvvo3NvNZp2aq02MB7FwnvkIQc1Ac3NdDIdJDhTQbe+HE5T5gZ6KCLae0v7XpzkM1QvMdAL9xMtp6hZMQlGRglGypFyLFda8/RQ/MeQEKT6ChuEc7yL3zPbL3W3MCgCCgbLrQzXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8wowBhrww7mNfGrTWLOEs2gU1Lk1bzIGZR/rvDkH28=;
 b=Mdx07ofQilVDCQYT4iR9H2PWws5t+eqQVw85Cp0gjPxXSEw3Lhck+6hUYCqpa7rYQ656/KGJVkDiLsLfSQDMZ9+fFBqufPnZTShxdktWILXlZ0FUSc1XaunkDVw7ei+B5JG1V6Kh/69eQfe2rz7wS+B92I+cawlolVWlS+lyaDVApdR6dYV8TklEVwSebliZpcxEvKarsBk1HTiDwCDZiFiNg34j9XFIDXdX/jkhInUdhl+p+ePq2/R7HrrMzpT8iHt7oPAqRuXU8yeePNUsJ583syyBV+Lwj33Z/C00Vx4w3uPl0OoxeOdIWOg3sMLTmnWZIDVCyu84d7kC7KUGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8wowBhrww7mNfGrTWLOEs2gU1Lk1bzIGZR/rvDkH28=;
 b=jgq8TB/7Ha8A039fXSoDcMXROup0RhkjACqW2Wcv9K9ileV2LMrcFyFtFk4SGRI2ize2eIYXcbda6Fk72M7+OsaKCSZ/LLW1S6/nz/pJ5QGrr0m/jVSIUomNLy27QRDHhFXfsRSo95vY5fwUOvCd8p1daM+o8eVs85VzZ4ZEnaQ=
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9)
 by TYZPR03MB7317.apcprd03.prod.outlook.com (2603:1096:400:41c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Sat, 16 Mar
 2024 08:16:30 +0000
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::dc82:7aa5:b2f8:2fea]) by PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::dc82:7aa5:b2f8:2fea%4]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 08:16:30 +0000
From: =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?Qm8gWWUgKOWPtuazoik=?=
	<Bo.Ye@mediatek.com>, =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?=
	<Qilin.Tan@mediatek.com>, =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?=
	<Lin.Gui@mediatek.com>
Subject: backport a patch for Linux kernel-5.10 and 6.6 stable tree
Thread-Topic: backport a patch for Linux kernel-5.10 and 6.6 stable tree
Thread-Index: Adp3eTWrkYSO8E82RRe9kg2KOgLeiwAAECPQ
Date: Sat, 16 Mar 2024 08:16:30 +0000
Message-ID: <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
In-Reply-To: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrNTQyMzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03YmZlZGMwNy1lMzZkLTExZWUtYjczMy1hNGY5MzMyZDU2ZjhcYW1lLXRlc3RcN2JmZWRjMDgtZTM2ZC0xMWVlLWI3MzMtYTRmOTMzMmQ1NmY4Ym9keS50eHQiIHN6PSIzNjYyIiB0PSIxMzM1NTA1MDU4Nzc0NTc0MTgiIGg9IkpkZ2YyWWxWRllLb0piNXhrWm56WmtCc0xMcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5653:EE_|TYZPR03MB7317:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvHlibb9ay2/OItlwCipen24W+6bU/f/qPqrMIPTMVVmRv1avH5vaCNvfdJDkv7u8jzKX1efRokF3Stln5LsZUHAL6DoWaBQa+TtV+bvnmB1ShFpr6N1YtewFkYX58l7u/vWose+vjFNut2HxGKeK7d9wKORh/UDDnx6SZVZQER1AwFe2zY2qbPnqq6VdcnYdkKJgoGCICFEVm9s+EwWa2Mq1Vq00c2uTke1WogTkX/UuLkqsw6RadX9zi1D8iPe5sJvmI4dhT4fZE8YMP8sM1xXV2WBPKK0rl/M1BKb1QkXRfQZLLlOtPfOsKWEwc4kxbxzckP2phKKTa07Xkhl8oUQXMmUnDSWADiBA+WVGVDrgzETwBEKNUeLP5ARe8FQRPdIgmoTpNx7zRW3e5wLKTRGnTDaucLQtbwmI1L/wFb70ix3wZPMA8HA53meD5vcIgmlXHSn1JZmj8VJV/PTgeisMHSjxZXxhdypyMm6EZjUGCy54mwSnfz/+vfGFw5Ktuyub1trKRC+a0RSYTy1J6/kjXJ9elqezIfSERbBjEPB0UNQRPMeXgkjMafl1onLgBDyyWSB5eIXN82sx+tQFE36wYmQmezIU9bgeQ4p7tRe7065JY93xU3A8aMSlFh2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5653.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUxaOEJleThLRDNWNk9pMGdQcWlZRmRDUGdJQ0hNUGpBRmsvdStnWVdFeWQ0?=
 =?utf-8?B?aUx5RkxtMTRzY1FsRTNHUk5NUGorUXY5ZGtGSUE3dFg1UHVTdnVjc2Zidmly?=
 =?utf-8?B?bGR6TmN4aitsQ1hwZGpXWVIzQm0rbkpieUcyUWV4em1yWVZqeEtmV1p1WE1o?=
 =?utf-8?B?NTVINTFFR3A1S1RaUk1TbjlIeExocktpMm5xOFp2ZVg2cVMxRHhlT3EzT0o5?=
 =?utf-8?B?SUNEUkJ6NHlBRjJzblBIZ1RidmFQNzRQUlczU0N0alNWQ2ZqWGJ3YjYzcnhw?=
 =?utf-8?B?ZUpuRVRUUnJrWWlUSWw2MzJIQ2pQWEN6UWZDVTlkaGZzcnBiallIOW1sT3Qv?=
 =?utf-8?B?dCsyempjWXp2YUhOc1B3S0loTEd2L1pTTTExRmhsbHJLR21xanlHcnFyQ1B4?=
 =?utf-8?B?U1NTYk1BQUIveGpoMFh0dGlBNllkcW5iM1o4MGs1VXRHcHFYN09HaVdsY0lv?=
 =?utf-8?B?VG5OYmhaRFIvQitHV0JBVGV0L2lSSTlwSnJDUG9vei9JYzJ2L1VJcFhWRjB6?=
 =?utf-8?B?OFpkRFVtcTQyUG1iampMbGs1bWszdExFZzA2MlprMWhCQ0o5cWtXY1BXa3Jw?=
 =?utf-8?B?L3o0ZDk0ME9PTTA5aU5uUTU3Ky9aOWx1Yy8yaDQ0Wjh6V3lVODYyRGZneXJG?=
 =?utf-8?B?aDQyaVJLYVpLSEdBNFp4T2pEdFlqdU1PVitMaSs3TjF4cjZrVW1Wa05wWTlB?=
 =?utf-8?B?V3BhQStERVFiaXhsT3hhWVVibzBudU1qYndUOXhncDloRy9XWE1JRnFNdzc1?=
 =?utf-8?B?R3JjQit3QU5PQVp4UXBHczdncFNIdnowRzJWNG0xaDJuMVRPZXJ1WVAwVTB5?=
 =?utf-8?B?WkVRdFI3TWVZMXhXK0kyWXluNUV4U09TWHVad2dKK2VSTERJc09hSVh5UTUv?=
 =?utf-8?B?VDJqdHordWZnNHF1L0g2dHE3MCtsZmlnUjlPMFYvZ2JhYXM3T0g0M0J4OWZO?=
 =?utf-8?B?RE5Zd3BDelVXUEpOV1VaZ0ZQZ1I0OVRQZ1lBbk40NUV2QmgzaSs1aER5Z05q?=
 =?utf-8?B?S0Z4WUZNRXJOcjRNYisyRStuTzdSTG5PSnVMSVpzLys1R09TRUVTa3JHK1RO?=
 =?utf-8?B?UDRZVTBUd2VxVmJtQmVPSjJML1N1ZEdhVDF3UEZydkwwY2k1czl5QUNXU3Zi?=
 =?utf-8?B?UUxRa0hDbG83WE9CZVVXOGZoWVdLU2FSVWl5VnRCTjVYd1JqM1N5UTByVEFk?=
 =?utf-8?B?Ym5kOHdIQndmTWV6M2tTZHZOalRKNVRMRHEvQWlsYlVWRW93eCtGQ1dobzEy?=
 =?utf-8?B?OHluWWJ6U2lBWE1MRzZGeUdtM2lKTFlsMUU1dldMSHlWQlI1d3dtbmNPeGtM?=
 =?utf-8?B?eEJmeDY3UWR4cStUSDVVVjVQN0kxRFBpV0Zob2VydGNlTmdBRWNTMHYrSGgr?=
 =?utf-8?B?UVBaWnIxRnFKK3lKc0NsNWU0dW4zL0hUenN6YjBHMDFwalplV3IwQUcxdDUw?=
 =?utf-8?B?M1NwYkV6TmFBYndndFFHcmRFR1FkbnBiblNrMy9WT21lRVFuRnl5NVZ6Wlg3?=
 =?utf-8?B?TjVSU3FCK2hSeVZKQW1OQkNJL0xsMGVDUm9YRnYvVUtncTEvaXE4SHhiZ1px?=
 =?utf-8?B?d3VNOG9FSHppaDRFUDgrZGNSTFRMMk9RTWhFL3hJZExNblk5blcvTG5IaVAr?=
 =?utf-8?B?OE9wTkpGZUMrbk14d0xWOHIxbkNyczh5UHIxU0VKckVvN0pkR0dNQzdHRjRU?=
 =?utf-8?B?b290UGNSQVIzNTZ2YW5LWDZKNTBIeVhqM0d0Q2ZlMlJYZ0ZBY1Vmdy9ucXdw?=
 =?utf-8?B?Mmp1dVpCZXZSUXo4UEd4SGtCUkJ4d3U4U1RZRTFaK3QxYUhaQzNlQzR2WHZZ?=
 =?utf-8?B?eG9hOHBIeUtFSzRwOTRSM2RKZlNvUDA3ZnNlSXRPTTlyUStJTndwUmFzR2dq?=
 =?utf-8?B?OTgrYzdqQUhzeVY5QWx3a0dzYWtiMjJpN0prVTY2UURGaHIyL3E1aVh2UVJ0?=
 =?utf-8?B?QnJBQ2ptdnhWQmNQNWZSNTVFUjVweUJiM2hQeGdvQ2lXMC9Wak5zMUNVRVd4?=
 =?utf-8?B?TEdsQlNzZUNKeHBYUWFtZnI4K2kzTnByQkpkRk1xMVU4ekdQdHVVdzMzcmp1?=
 =?utf-8?B?bmloRHEvOGdQZDBZb2xWZGxJK3JyNHpoSVdNcHErN0xCUTduMSszeW1QSVZW?=
 =?utf-8?Q?06ubVhZQbuPGUYYCf1+ohhfPc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5653.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9fc079-627d-44ee-716d-08dc459162af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2024 08:16:30.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKwuIDt5Mz8wb5wxTJqMgR+TjJHjvR5lXp5uAi0YZ2pRvuuTpfQruo7HDhOg0YzZNSPswGo4Af0eYw+8nXmY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7317
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.341100-8.000000
X-TMASE-MatchedRID: 0aps3uOmWi5wwyMFFFhiHBlckvO1m+Jc+KgiyLtJrSC+M8XmebIk+wcs
	lYpo5iST32QTkj7KSP67bO995ZiXZY9+HWzUuQkw7spMO3HwKCAOPDBPSvoRdEX5hc8ioB2+Jgz
	u+XqIjVVb1dFcLvKsB82cSlJJpVq0RcriDaoCTGJWdBPqAOaXVV7OZ6hrwwnz8Ule2AXgYUvS4n
	ZpaTqEVi2HsYyPxdrOrMXfMomaOcH6sM12uHcbjLBZAi3nrnzbfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDUal568aygjl+8UOW09DXz+z0BsihE7eedaq0BHTGdqSGJHCDcrDNv9T+xX
	mXXHzID8aUW4ZX1gMI1k1lvGr8s071m+/uI3hJlI/rS0oaYfPblnKKaUMzHIDnrGG5trZa5nzop
	jeg1PfMg7RKLZO56eftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.341100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	70C30C89851FD88B79ECE4DDA5B904C683CAFCD83CA29E2DBA81893C904D6CC92000:8

SGkgcmV2aWV3ZXJzLA0KDQpJIHN1Z2dlc3QgdG8gYmFja3BvcnQgYSBjb21taXQgdG8gTGludXgg
a2VybmVsLTUuMTAgYW5kIDYuNiBzdGFibGUgdHJlZS4NCg0K44CA44CAaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC9kcml2ZXJzL21tYy9jb3JlL21tYy5jP2g9djYuOCZpZD1lNGRmNTZhZDBiZjM1MDZjNTE4OWFi
YjliZTgzZjNiZWEwNWE0YzRmDQoNCmF1dGhvcglMaW4gR3VpIGxpbi5ndWlAbWVkaWF0ZWsuY29t
IDIwMjMtMTItMTkgMDc6MDU6MzIgKzA4MDANCmNvbW1pdHRlcglVbGYgSGFuc3NvbiB1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnIDIwMjQtMDEtMDIgMTc6NTQ6MDUgKzAxMDANCmNvbW1pdAllNGRmNTZh
ZDBiZjM1MDZjNTE4OWFiYjliZTgzZjNiZWEwNWE0YzRmIChwYXRjaCkNCnRyZWUJYTVkYjNhODVm
NDRiMjlkZDc3M2M1YzY1YzMzNDBkNTBiNzRiNjY4NyAvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0K
cGFyZW50CWIwNjIxMzZkMGQ2ZjQ2ZDdhZDVjODgyMTljYmQ3NWY5MGNiMThlODEgKGRpZmYpDQpk
b3dubG9hZAlsaW51eC1lNGRmNTZhZDBiZjM1MDZjNTE4OWFiYjliZTgzZjNiZWEwNWE0YzRmLnRh
ci5neg0KDQptbWM6IGNvcmU6IEFkZCB3cF9ncnBfc2l6ZSBzeXNmcyBub2RlDQpUaGUgZU1NQyBj
YXJkIGNhbiBiZSBzZXQgaW50byB3cml0ZS1wcm90ZWN0ZWQgbW9kZSB0byBwcmV2ZW50IGRhdGEg
ZnJvbQ0KYmVpbmcgYWNjaWRlbnRhbGx5IG1vZGlmaWVkIG9yIGRlbGV0ZWQuIFdwX2dycF9zaXpl
IChXcml0ZSBQcm90ZWN0IEdyb3VwDQpTaXplKSByZWZlcnMgdG8gYW4gYXR0cmlidXRlIG9mIHRo
ZSBlTU1DIGNhcmQsIHVzZWQgdG8gbWFuYWdlIHdyaXRlDQpwcm90ZWN0aW9uIGFuZCBpcyB0aGUg
Q1NEIHJlZ2lzdGVyIFszNjozMl0gb2YgdGhlIGVNTUMgZGV2aWNlLiBXcF9ncnBfc2l6ZQ0KKFdy
aXRlIFByb3RlY3QgR3JvdXAgU2l6ZSkgaW5kaWNhdGVzIGhvdyBtYW55IGVNTUMgYmxvY2tzIGFy
ZSBjb250YWluZWQgaW4NCmVhY2ggd3JpdGUgcHJvdGVjdGlvbiBncm91cCBvbiB0aGUgZU1NQyBj
YXJkLg0KDQpUbyBhbGxvdyB1c2Vyc3BhY2UgZWFzeSBhY2Nlc3Mgb2YgdGhlIENTRCByZWdpc3Rl
ciBiaXRzLCBsZXQncyBhZGQgc3lzZnMNCm5vZGUgIndwX2dycF9zaXplIi4NCg0KU2lnbmVkLW9m
Zi1ieTogTGluIEd1aSBsaW4uZ3VpQG1lZGlhdGVrLmNvbQ0KU2lnbmVkLW9mZi1ieTogQm8gWWUg
Ym8ueWVAbWVkaWF0ZWsuY29tDQpSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tDQpMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjMxMjE4MjMwNTMyLjgyNDI3LTEtYm8ueWVAbWVkaWF0ZWsu
Y29tDQpTaWduZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQoN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpCZXN0IFJlZ2FyZHMg77yB
DQpHdWlsaW4gDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpNZWRpYVRl
ayhDaGVuZ0R1KUluYy4NCkVtYWlsOiBtYWlsdG86bGluLmd1aUBtZWRpYXRlay5jb20NCnRlbDor
ODYtMjgtODU5MzkwMDAtNjcwMDkNCkZheDorODYtMjgtODU5Mjk4NzUNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0K

