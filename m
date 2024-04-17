Return-Path: <stable+bounces-40061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA98A7C55
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6E71F237DA
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF15F861;
	Wed, 17 Apr 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fuRTxGPN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VclcGd3i"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47815A115
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335412; cv=fail; b=kvmvlkrN3VAoF4WII8vqlyq/ZI7LPDNiDk68J7cIybRCSS9nGIKbDdoWbDYoWF2pYoZFMq5NAMNOZKspzBee8tiQDCHO3+UHJQLFlJWtuAcZwtgLCfHsaj9V9WoLjjvV4MyMYU/ecTxoc+RJKQuAWDewGd7AbZEtPlMOL1UfD+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335412; c=relaxed/simple;
	bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hxn/9GzviXQxVLdIpFMLevceu+XZxbFIf6luMR/lvRH3WOTQQ7luOtZVxFElT5YnExXObx0Ok9wE+G5fMWE4Meckdcw9sDwfVzlndk1RjTebCaoygCfAgHYcAULfUK0XcPyG7nsdiH+89hkWXHK5cRjMkcCXh7QD6Z7j+MFeqRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fuRTxGPN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VclcGd3i; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ee404e76fc8311ee935d6952f98a51a9-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	b=fuRTxGPN5TeCfwwaqN3YrHN0sJBZTySI59HmE0Rcs4cjrp8BuFPpfsR392RgZRLaM8wrfmRCyJTbB+lMDSapoUOMS5R4n9Ec4TSalVMxmRgbyzERTy51yhgCHvgsjsxYlqZUF4/qX/8D9S2YiYFyL7XZIy9XOq8XOT9TlV0Vaec=;
X-CID-CACHE: Type:Local,Time:202404171426+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a4d0b6e2-fe51-4c8c-916a-cbc52aadd3e4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:6c8f4686-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ee404e76fc8311ee935d6952f98a51a9-20240417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 311812730; Wed, 17 Apr 2024 14:30:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 14:30:01 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 14:30:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChjBXulwD0mH2vskhD0EusrmqvJJm8uPIpcHTbP9GV7UmD5PuZ1IgkH1xJyr4R9rqwcSb4kDWZp+43lKP7rnBE58Chk7KDQ8U+wDkcHuRNDGWGDJXcZvN+66lGYLXJ/yGTNT6rwfyDkfprSW6Bhj4MMFc6s8lR9F5r3IdDNCGVjcVWajWeh+Icx2l9ZvMKn1mlg6S5s+Sx0SUbtRTAsYA2lGprwZBkR9gQ9czmhUICSZqWpWBW+EXfxziLwJDja36UxAfIX+ou5ZUwVQ+Cxbr6YvgOQegNh6N3dsguPx1ApXVbH6qTllRKLqjqW8xjtn7TEYu30uf9cYRdrqdBrfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=NNpJry3OzjwN2sS9jpDeXsAcNQWCH0MuAxu/p/Tf5L33gd2ohZcAtqAIwLhcl7XavMA7XXGZ1Y7KZcNwRQ/YIHf0mQ2AFZEfLnDoovnLrCWUcJTGEQ1SHFuTM1GIYlwTCyVN2meOzl8Kg6/X+Lu5hl5Kgz7t8fcUz6VnuyqK3RAOciIMxz+HBQG3PrAkMtTNGJ/2CSGqk9RNP495QmBNEzAfWJw53+0+ixjRZCgweojIffGBJcyoNxPaAN7EHsK4YLWUWbOKXpf98Dy/qBKKbal4I4inQWXdco6X+qG6UWkdyuZCfuIggvVgT8EX1hRzo98sqfeUdTzudVPDDQkP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=VclcGd3iIxACM+gGLG8gbCaS2E/L1LkPvOn7O1TvPCNOdhS8u7E1G4BXE1ZHzSfji/1J2do86NOX2DO5mobdqW7NjcBAr/egRkf3mUDnWZJ8quCyhX9vjTsZqXVdZNMta641/K2cwM0rqoZLe7T4QTGA9t3BnyJWew1KbM6cy8o=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by TYSPR03MB8046.apcprd03.prod.outlook.com (2603:1096:400:472::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:29:59 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6%7]) with mapi id 15.20.7452.050; Wed, 17 Apr 2024
 06:29:59 +0000
From: =?gb2312?B?Qm8gWWUgKNK2sqgp?= <Bo.Ye@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?gb2312?B?Q2h1YW4gQ2hlbiAos8K0qCk=?= <chuan.chen@mediatek.com>,
	=?gb2312?B?WXVnYW5nIFdhbmcgKM310/G41Sk=?= <Yugang.Wang@mediatek.com>,
	=?gb2312?B?WW9uZ2RvbmcgWmhhbmcgKNXF08C2qyk=?= <Yongdong.Zhang@mediatek.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: =?gb2312?B?s7e72DogW1JlcXVlc3RdIGJhY2twb3J0IGEgbWFpbmxpbmUgcGF0Y2ggdG8g?=
 =?gb2312?Q?Linux_kernel-5.10_stable_tree?=
Thread-Topic: [Request] backport a mainline patch to Linux kernel-5.10 stable
 tree
Thread-Index: AQHakJCsbdC6C1tUxUCLeICEF1bIew==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 17 Apr 2024 06:29:59 +0000
Message-ID: <SEYPR03MB6531DF0562A355EF4AAEE7AF940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|TYSPR03MB8046:EE_
x-ms-office365-filtering-correlation-id: 901b4f9e-1610-4fa6-07be-08dc5ea7ce81
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?gb2312?B?THVIK1I0VGxtbUJVUmxsV2EyTlh4bWhVOFRNdzUzNXNBMitNNGI2TGlDSUZK?=
 =?gb2312?B?QkQ2dkR4UVR1T002NjJzanZycGRZZy8xYzErZmdaclNTL25WOFZCc1IzQklV?=
 =?gb2312?B?aWwyNlFLdTNmTlJvOTFmS3JpMExpNE5oYmJYendGTW5DMExsYlNtUGRkWXk2?=
 =?gb2312?B?UUJadU42UG5TQmtaeWpZYVdZOUl4VTJsZHh0TndrTEoycVdqUndPTnp2bkxP?=
 =?gb2312?B?UVRvLytFVnA0cVdVTnlEUVJOT3FvY1FpaVZNaXMzYXBuaTBJSWxOR0RCS1RF?=
 =?gb2312?B?aVdLQVJRNzdLSUV6K2ZsMEgxRE5ncXExQUV2ckdKMU1FaGs1TS9jRFFycEg0?=
 =?gb2312?B?MkJGOGh6L0hGV3Rlbk9UY01BMCtDalhTYXhNbUZ2RHd6b3RtYzMzUURVMFNt?=
 =?gb2312?B?ckJYRmdmN3hpZTcyWE10UjYyYnVMdGo0QmxkY3VWZUp3ejFGUmFHd2k5YWN5?=
 =?gb2312?B?MkR4Q0wxRG45b2wySUFOQXZWUjNrVUU4NEdCZmRLYUc0czRQNEJKdG9lMWtQ?=
 =?gb2312?B?b1RKUDVLRklRSXdUeTNVRDVnQmVZNmh6WTg1ay9SQjNVdGNkNld6aEpwRjVZ?=
 =?gb2312?B?SmRjN01KN21FOVJhQXBSbTFtMHlFZVhVRGRZV0dXWWI2OUxWM2p2RTJHRlVN?=
 =?gb2312?B?TDBZRXlIYlhleFI3UGVlMEV4MWd4YWlTNVRvMW9UMmx6K2pkRnlNNWZYb3VU?=
 =?gb2312?B?aE5ORDN6TmJhUUVFdnpsZURiY0hMSmRsemJ2V200QnBUcGRaejlad0dzZzYy?=
 =?gb2312?B?U2wxZ3VWY0twSFZrVy9ZRUdQT1RLZGtlWFBuUTN1L09HbVd1SUQ4N0E5eGE0?=
 =?gb2312?B?Yit2NG1KZHM2SThTcURDNXFqTFN1NEF0QXBTTHJ3L1JmN1pYTW4zQnp3eTVG?=
 =?gb2312?B?MWVOdGVUbEYvZHB6ZkRkN28rUjJTZVo0Lyt1MU5BOU0wZHNEeWY1SmRDR2hQ?=
 =?gb2312?B?QkpyK3hmZHZ2QkRISW41bXBjRE1EN1dqZWwvRFR1ZEEzKzgrMGtpMzd6c3VV?=
 =?gb2312?B?aU95cmV3dkxzazJVWDVNMHdrSDlzejdwWm45UGxBbm5wMU53K2RMV1lROVZM?=
 =?gb2312?B?NWR0cUl0MnlTTExUN3NDWC9TWVVSR243aFl5c1ZiQ2thTU9PSndzcWhLVXM5?=
 =?gb2312?B?VVMvYXljbDVIT3I5VjhUdDBaYnArNFRpNjdrUEFKSHVrYXNEZUxZWlI5SExa?=
 =?gb2312?B?cVpSd1ZCV1hoS0ROSWhVRndVRExsUHJVQUp3ekpicFFoNllWUVN6ZGxXUkFh?=
 =?gb2312?B?UkxtYzhDOXFxY2w3VnlRQlVRU3VvTVdlaTkrVTJKYVMzZEV0SlRZOXVQc1cw?=
 =?gb2312?B?SDFEVWdGQXUwYytyRkV1R2huckVPUmkxMjgzc3lBSVNSNmZPcW9sUVdSSGV5?=
 =?gb2312?B?d1RxZFRWUW9YWXo0QlZyeGZ4blRyaHRLT3B3S0o1ZWJiemtxK1kyNng1d2FG?=
 =?gb2312?B?aitYK2tmQjdNcCs5YndOSnNoS3pSRmNUbXc5b1hGZFJncDY3Tk9iODBBVVJY?=
 =?gb2312?B?a2tvWnJOZFNaQURqcWc4aGp0KzJBQzVoamZ2UXZXditMWUtuODhjcmVvUFZo?=
 =?gb2312?B?V1hPSW9oOWlEb0hEV2lxN01WbEw0YW1mQmNDaEpRQnM4Wm1qUkpUNE5yTXhZ?=
 =?gb2312?B?N2xPVE1mSVg1YnpNRy9iZVdDQkR4L0Q1Sk4yakVHWDZUZXBaZ0RXdVg4ZTN1?=
 =?gb2312?B?MkphaDJYL1BDZjViUkpCdWhlT1ZOcHpYS3lPVUh1OENhS3ZQZ0N4Sy8zSmVn?=
 =?gb2312?B?b3owTGJIc09xU2tBZWVQTW9hWmhyYzB4RUxRbkk5T0YrcWlDdE9wRE5VS243?=
 =?gb2312?B?TnEvaGpXS1ZmRmt2VHJUZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MXJFUUlQdW5IWGppQkNMWS9rRlFpSFNXbmtMQkl0ZmFYekJrdXQrcE1UZzF2?=
 =?gb2312?B?WEdlZ1VoTXlwU2ZFVVN0bi94emtXb2RKbFZsS2N6RUk4RTI1NjhXaEZldHM4?=
 =?gb2312?B?M0x6cHc5cjBZL0xOR1ZzMnFiYkVrdlNYY21HdlFjYnZPY2dPYnlVY3lrVU55?=
 =?gb2312?B?djFITlF4aHJIR2Z2QXBqL0Q2clZxZ05yblY3QUZZR1h3T3B3RUdDVCtMbkln?=
 =?gb2312?B?U3Joa3l1aVNBS1VxTHJSU05CR2NoSk0rYXZuYVNQTkhkeS8wa0FRWi9JVmFN?=
 =?gb2312?B?YXVieUNuZGdNbGxNakk2VEdWaVRkYzhvNkJzZTFuN3FEVm81WWFWWnpkUS94?=
 =?gb2312?B?VXMxRHlwNnU2NS8xWitjOERLdDlxVkIyTXJEY3ZWT1RZeUNmanVadHdFWkN1?=
 =?gb2312?B?SERWYmpWdkZmcVNGdVp0bWJHaTFzdkFISk0zeWJWQWZPaEdocThsaUZFLyt5?=
 =?gb2312?B?anJIMzZpa2tnd2RZSFRSMks2TURSQkVLd3d1L2lWd0F0TmxGdnV0NEN2OXRo?=
 =?gb2312?B?Vm8wWmcvT0VkN1NqREdtMzdMY0hxYmVKaGs3VHRYUVJKaXJtc0NIQ29YSEZY?=
 =?gb2312?B?dDNJbFZoSWpsRWJKMlNyTmI5RzRMc0xvSml2Y3JxMUY2QlkvaHovSm9Tb0VF?=
 =?gb2312?B?WFEzdnp2VUg1L0RXcThmenRNYjM1YVA4WTB1aFNRQnBLeEphdGpHMEtXZFg0?=
 =?gb2312?B?a0FmV3MxaGxxN0w3dkM1eXQzMXFXbXV6VkcwWEJQTUhzeWN4Q2pSVFNZaUlr?=
 =?gb2312?B?T2ZZenBWRThRNHp0WlRIM3BlNVJEY2E3L2xlbXovdVpTaFFTU0tSUVFEUVFR?=
 =?gb2312?B?d2xTRlh3U1V6ZDgzYU5xY09XT0dnM25wSVYzU1VFSy9TaVVRYjVLOFFsR0RW?=
 =?gb2312?B?YXZ2cnZEZWcrWFg1K2FOYjBYTHFiQUJRSlNtK3VSMFdmcXBqTVRhUHFjQ2FR?=
 =?gb2312?B?elJaSjNMU3ZxWkIxc3Jpa3BIZmVSOXlXUlYwdXdWTDR5bDBDc2FrNkRIRmRR?=
 =?gb2312?B?eTBLMnBuaGpIZVdqVjdjQlBrSThqeWZ5aER6UHoxMFMxM0dKNk5jL0FVME91?=
 =?gb2312?B?dk1aL1lQQ3ZMaTg0NDFJazBKZ25OQmdscDhuQnR3ZmlSZmxJVTVSQlh5UHow?=
 =?gb2312?B?VnZPVHVYL3QzZ0tZVS9vcklVSE1vUG5qUE1ZUURsQTlLVTNwL0xRUGNLRFJH?=
 =?gb2312?B?Y0VlWkxmYVY4MjVlclJwcXVnaFFKemkwS2oraVRIMTVwODVac3grSW4yclo3?=
 =?gb2312?B?WXhkc0hjWE5ybjYvY2lTY08xSmZjanF6WlVENklvU1lOblFxeGpBNEFUUnB3?=
 =?gb2312?B?OTREYzZNSWRaalZSTkhWcnNES2NKUjBqdU9EdlRGaGlMTUw5QTh4ZDl6cFNz?=
 =?gb2312?B?Y2hWc01INWhaU25lNnd5Y3BKSGN6bkY4M3VKTzNZK2dvdnJKeUx3VGJ4NnhG?=
 =?gb2312?B?dDAxM0ZJbjhkN1VSalRiNHUrdzVQZTRwb1REVXk3aGRqNUpZUmxMVkpneHZm?=
 =?gb2312?B?UnM3MElIWStPNmZmSGMrek1icDMyMkcrV3ZVQ1RDUC9yUjlvZytFbmF6cUdL?=
 =?gb2312?B?WExSSDJJcEdRcWx0cktaNnBocEQyL3hWZmo0Z24vNUt2YzRBc1M3OU9Qc0NF?=
 =?gb2312?B?SGtienZ5MW5hU3hCakFMMWNxYitrVEJ2TGxqR0dXNXZhUW5CaWRWK3hKKzRk?=
 =?gb2312?B?emxyNFVRc0NMN2FSeEhuM0VPck1IT2NOTHNSMGtzMXFLTW1XM1kyMXNHNkkr?=
 =?gb2312?B?RUdOMFJuUk1FdnVNRXB2dDRWYUdDQmhqbVAyU3RUcHlSbVJuWVA0TE9COVFy?=
 =?gb2312?B?eWNwMXJyZ0loTzcrQmN4cmpFaXpzbzczSm8vZUZwSjY4SVpVUkw3aWo5RTB0?=
 =?gb2312?B?REFRTlhLckkwMXRKYnM2aUk1eFNGZytJdjVlZ1dkcnJDdkdUV1BQVEtiaDRC?=
 =?gb2312?B?dXk1bVlNZ3BqZjB2ajRhV1hLK2JxVmNWeG1UaEFNOWQwUjR4RTE5ZmcyUWVm?=
 =?gb2312?B?dDNXZCtIYmJGL0h0SFlBeng0MjIvZkdlVTBTajR6N1ZJWXRXamlZOXZHWmdB?=
 =?gb2312?B?OG5HdjVISDAxdnlHL2xUU1YxdkxLMzJFMEZMVVFxNVFMMEdSNlNiSUdWWG1w?=
 =?gb2312?Q?JnJk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6531.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b4f9e-1610-4fa6-07be-08dc5ea7ce81
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:29:59.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDFB1CRTK81+DvhYtGzY4wvz6uhWlygDTygkAc1Y0VU4cCVbi2MwdKag02hwP2tPb0uf6dQ3gpTlUZvIa94HQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8046
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.140700-8.000000
X-TMASE-MatchedRID: Pcf9tAO75fA5n7de8a8qbsqXjImgj58bsuIso71Vk6KwzmZL6lfcdaPF
	jJEFr+olkZ3jZ7ODxXyIoJQ67PqSrsVFjkZTkchyNtDyE2Cl4w1uCpSBdG4ThsK21zBg2KlfuVf
	c976pNyqJJPff8/hMR6wwiqhirI4lmhHQww/DmPVFWEETbq5NSvwNgAzF8116xNxlEFDc5GXHtM
	BP/jXy2fh0UMxNN2q2VGMhh6J/ibp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.140700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CA38A3CDEB0EED058EB35198E82F8D90B174032A7DCA9726C0A938C03112C4D42000:8

Qm8gWWUgKNK2sqgpIL2rs7e72NPKvP6hsFtSZXF1ZXN0XSBiYWNrcG9ydCBhIG1haW5saW5lIHBh
dGNoIHRvIExpbnV4IGtlcm5lbC01LjEwIHN0YWJsZSB0cmVlobGhow==

