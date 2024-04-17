Return-Path: <stable+bounces-40062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B468A7C6E
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA6C1F24DD8
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18405810F;
	Wed, 17 Apr 2024 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JU0AZDSN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="glzgvLCY"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B6535D1
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336125; cv=fail; b=NrdDR3T/M49lfbBPuxHqNb8rl1wnjLX/+NSKRZGzefSlsb8aqFDiRkL/xRGWWkJET4Y/ljeDS6j0fEjVb40XaIQjg+eANMxhTDi+yQJnV6VoL1HQA6x2D30Ezzxt3RNgub7z2n9We7+rrvjxuHZk9R6tleld6pn+cvVIWQX/R5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336125; c=relaxed/simple;
	bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lqkH+w2kv5C6ElM6IFSOIPdemBtEUmRMizj2EGFQtw4W1vpIPVZANRmAc905muyGRTzqwGbjDoLZyjouiyyE4LDYWpYXTvoafUlPg/wGN6qvoaAVsxrJZX6vDl7JPWw1o36mncZDNSDLo9u5wlnfipQBcZfiEU2Ms80imzFTdfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JU0AZDSN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=glzgvLCY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 78e4812efc8311ee935d6952f98a51a9-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	b=JU0AZDSNmlk82h8iAh91TRqXIzLixM3XEYmcjvOBRfCkVzVfgmm1Zaf2Iu9mvMoF2MQV0lwdXsGo03xW7cx94zbzXCJ+Xl7c5ppuxyOlHlBfqQHdfkg+HtqHLdJeSqqJndaMM+zw1Ku9sb2nlw92z6yad7hjneonzFeAShS6ZI8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:df2371d9-d19e-4656-af9c-03bb878c4448,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:6c8f4686-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78e4812efc8311ee935d6952f98a51a9-20240417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 794889699; Wed, 17 Apr 2024 14:26:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 14:26:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 14:26:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN6rWLL7z4XezHY+mxOBXhKbkgo4/9ixb3C1dru5stn+Jf9fR8b4DfvVDkUEPpbJYGCbSJr5xLUB2ppvziSymZyo78U4wDF4yCHPBduKtOwotF+PVzoAWS2xUlV5iNpCUfyNfoMi0qUqPXifxdlaUzAq1kwffUohX0HCtNgAyD4ThY5A1SMCcyvpPl2LcVmU58pswibAzU0qkbpEu6eLMs1mY3B2BvybhY5aFnEqca/Ti9G/MQhah1KIAfMpVUoRu7Q2HAQ1UR+3yyRM41Ca/Jl2G86PwFUQtcefO4yGOfy4rrqePiR1qV7Uwmmzfxj5nNVSGPB6cGtTXTHzyX/ELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=JtoRth05prXAr68SpsqllsgvDXikAumSsCdMUOLZD321QKptmDSBCscDr2SkxIB92iLf8tI5Jiy2SOiRGZ8P/GwYMZMb+0hRZc2NCuYfG21iXczIRAvQvcy6KlF4+Qg5Xsvryxe/3cYz61UhDAABM9Nk3U83swTBOPNeitl8DPx8NDgReoDb+GaQbMlCJaRWBFzf4RMtUSrtFtQWoZ2XJSRtGqxO46f6/UZ8FQF3zDoPKXMTd6F4uvRfybwrMEwDCNK0/MDXgRlnP8SozSodZ14Y3OiYcuYdF/B3sY29hXHQCrgkMvDHadP4tzz8AgHBE4GcRwc2tZyImGUGqFPgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=glzgvLCYsh+ekIaCcFMcJw/UHC44/L4kdq77xnEqPNLQcBXAD0+TLbGRUv6BmoF8QLpxYmx7bexxe0u6MSJXpf3fMchyeyJKRbt+KWYwl+O+1giQwTn3NVq2zWx7zzE0/layhP3SEiZFQ8CclA2XYYsMl73xLuCfPuiWP9vYX7w=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by KL1PR03MB8144.apcprd03.prod.outlook.com (2603:1096:820:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:26:44 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6%7]) with mapi id 15.20.7452.050; Wed, 17 Apr 2024
 06:26:44 +0000
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
Thread-Index: AQHakJA3FCjhpS4uyEmQLjlbedeOvg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 17 Apr 2024 06:26:44 +0000
Message-ID: <SEYPR03MB6531813E3565AC82B1F636B1940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|KL1PR03MB8144:EE_
x-ms-office365-filtering-correlation-id: 43adf366-edc3-4e0f-1b39-08dc5ea75a27
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?gb2312?B?bkVzZnFRM01qcEErOVpFOStmcWh5d1d1bSsyZWhQZTlHRFBZaEZWR3BubW56?=
 =?gb2312?B?RjF0T01iU0M4Ri9TektpK0RtK2tLVmF4MWZySDkrdHBBejNaazJQTmVSbGNv?=
 =?gb2312?B?YXhLUTZMU0tScVNJTGkwWm5aUEIyaTNMdWhBSW5tOVpFOGRpVWlUMUtlQ2kx?=
 =?gb2312?B?MUZweHRPRG9XdVYzQ2I4TmpYQkx6L3VWaitNVVZudnZXV2dzTTRhcnprZUxj?=
 =?gb2312?B?WEhtc0FqRXV2UlFsbGlYWElDRzFXYTdGQVEvZXJ5bnNhZlo2Tk90VFRoOC90?=
 =?gb2312?B?VjBNLzVMSkw1cmw4WEJFbURJMGZRK3o3dDVtQUNSa3Q3ZmJOWFZycmpNRjBS?=
 =?gb2312?B?MS9VSDVKdEcrT2tZRmlrRWFZL21qeHBRUTVwQzVKNUIwS3k5dXFkZnUwclE5?=
 =?gb2312?B?a1F2VW5KdTVGb21HR0xBakhGdXMvSTBtazB5dzlTQkZJQW10cWhnckZWL3Jw?=
 =?gb2312?B?U3kySlFUa1VEMUk3UVUvaUp3dUhNN21ZbHZOUUUvWkxNYUoyZXNWSGh0OTYy?=
 =?gb2312?B?OWlzTEdVY1FYaU54WFY1ZUNOQjZiU3pxSjUzU2xlYjkzcmJrSks2YnhmbU9L?=
 =?gb2312?B?cVBLVWQxbXlSMFVETm5QOGZkd0pIb2Y5MTdaU3lQU0o4dGNxNjFhWXhyKzFa?=
 =?gb2312?B?bDMyQjh1c2I2NEIvRlVTQUF4MXBJZjNjMzBVVHo1K3NsS3RScTlLU2lwbDFv?=
 =?gb2312?B?ZTF2b3c5QlhxSFAweCt0dEpQRVV0VXhyTXBUeTdSSkdKT1VUUXFWc0YxUXNp?=
 =?gb2312?B?eFB4UUFmaXpPTGdoSjJXTW9CcENuaVpteXhqMi9lOVJNYVdwbFFqbmYrRHlF?=
 =?gb2312?B?OVlkaVBIckIvY2htZFp3SXM5QUxMQ2hBVlJKRC92QjFwVkhKdXE4ZGlYWVdm?=
 =?gb2312?B?TldacGNTRzVyME5Eak1USlo0cFVqRGhNekdZVVJrNjIwYnFyQU5RQm42V2Js?=
 =?gb2312?B?Vm53YjlSV0t0cXRtcUg5eFl2UVo2aWozdUFhQnZFOXJma2l4RzgzbXlMM0ty?=
 =?gb2312?B?Y3FJaEtrZGVSNzZtT05lREk1dlZtRnpqOFp6dUhteHdFL2FNSjZoSlFhWE1B?=
 =?gb2312?B?R0dxM2pJM2ppVFhZL0M4Z1c5cTN0YUVMVHNYc2V0eVRZS0NxWkFMcmt6b3ZO?=
 =?gb2312?B?SXpNdG5tQWpmM2JURDVsYktNL29VemxJZlkrVXZvWjZ4ZGttVlV4NEVGTHlp?=
 =?gb2312?B?b1hhZGZDczFmT1hTSHdBdjlJNUxzWlpNam8rRStPdTFzTmNSdGhWWldKaXM2?=
 =?gb2312?B?MzNLWEE1Z05nNjdxbDVOS2pRUEo3ZGxIWFhSTWN4Vm1HMkpTb1JCSzBtcWYr?=
 =?gb2312?B?SFBVS1FIcXJnRjZxaU1QV1BWN0tkdFRBZUQ4cGtYRExXaEFGMnRlK0pNMHVm?=
 =?gb2312?B?VDAzMUZ1dENxNlUwaDJ3NVpIS2pueXk3T0dsdFVKWWd1SzlJZTRld0FDKzZi?=
 =?gb2312?B?blRlMmViU05ha1BtQks1Um15Y1FnSWlPQVhsNjZYRU56SHZIOHJqK040TjlV?=
 =?gb2312?B?aWF3UnRpdW42dmtIcW44ZkRHdmtFZGdKTXBlYldzMjZwUnFDMXdIYWNoNjlv?=
 =?gb2312?B?VzlOTHk2VHovaUlOSi9DbEdmSCtjK1lLZFJXL2R4UDAzSmVpeTU0YzJ1TUpR?=
 =?gb2312?B?R2E1Z2d6WjdITStIa0lpeFBaY1c3N2xuN2VVL2w3QWNWSm8zWi8xVTFzQlNO?=
 =?gb2312?B?aWMzQVJ4Zk8vTDN4K1M0RWJJZjdiZzg0YXVPTmFFelh0bFN3UytBTzZkOU9T?=
 =?gb2312?B?aGdVV2k5Y2l4TDVldTBIOTdHQjViRWhrNU52bnRKcVh3ckZDbjhSZE9pMDNS?=
 =?gb2312?B?WnJMcTJtaVl3M3BCR0hNUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?blFmQVl0NUJsSldtbCtNUGlrN2N0Y1FNc1JZZjdJeFpxc3RYZzExZDE2VEpD?=
 =?gb2312?B?Z1JBYmozR0UwTjgrT0xueTI2ZnlwWkkvT0Q1NEV2UWRDYS9vYnFsbGpPOXpj?=
 =?gb2312?B?aUlIdVNXUStsbU8xd3VQTjd4Y2I4bEhwcXdYMGpFcjY5T05kbkVZYnpYWkxB?=
 =?gb2312?B?b2k1T21PYmZ5R1JpSnZDbTRodUY2MkkwVGRKVEw5b2JDMkxwK2YwdVIzSzZK?=
 =?gb2312?B?TzgycVZ4QnZ1Q1JEM1JCTmpLZDJFRmk0NGh0ZC9MM2FoQU00eU9lNWVRdVVn?=
 =?gb2312?B?M0ZFRC9sbFRlSmtra2FMSloxQk40c1BXZUpOSFo5REhhcWRoUWdxNFBoL1JR?=
 =?gb2312?B?cFdHWHZQNXVpY3BESHdKKzQrVjQ4aldxTGNxVzJSTno0ZnBjbFBBM2d2Q05P?=
 =?gb2312?B?Y0xHWEY2WmdmczBOMFBNYnVPWXc0cytyckRqUFYwaStvSVRsOW1nVit3djYv?=
 =?gb2312?B?WTJSMFVoMDdmUFRPcmw5bFRsOWF3dmVqem1iWkdxdFZpaXRkYkcxekRzQm8w?=
 =?gb2312?B?V1FqUnVIa25la2ZBajhOa25OeHpkN21YWU1uM2FTaW55S1hyTUp3akljZ0c5?=
 =?gb2312?B?R2FhU2x5M0Q3cE5CdDR5c1VodURqK09USVkreVZqTnFiTDk2dWk0SFFsUzlv?=
 =?gb2312?B?S0VDL3BhR0NaaXdlWnJQRFQ2WWRiUFdUUjNaeWNlYXNqajFyUDBEZVlTYmph?=
 =?gb2312?B?cmlNQjFyeCtSOVRiVUZ4YzU0VG9tbTUySTBUZzJHa0hMUVhZa0t2R0pEbUpt?=
 =?gb2312?B?U1NrMGFwWHBGRUdKZlRQVDdTalYraFdXUXpNRlJSd2F6ZHVydUE2Ri9hVmE2?=
 =?gb2312?B?RitGTyt0SittREc2bStEa0JjbFM4NzlLcHFFRnpDcktTc1FmR2tSck9mbko5?=
 =?gb2312?B?S1NndGpOcllCQllzekwyWm9QOE03ako0WFJpYjZQTG9BeHZvYnNDTVRzb2tx?=
 =?gb2312?B?LzlvR3dSOGI4SE5LblRHNUVkT1l0M00vNk9DSG5zTU1LaC9BMTk3VlltSXp3?=
 =?gb2312?B?T3M4emF6K1A3VGdCd0xqRHVMQ3EvMlF3YTBZcFVXblJIR3VwU3dxSjZOUTJr?=
 =?gb2312?B?RnVKSUUzRXNoL0RqdmpWTlYrTExJYUx2ZTlyYlFaVHE2WkN1WHZWTVhmbGE1?=
 =?gb2312?B?ZE9JeHpsMUxPVnhYTStTRVlBUnkyMnh3c0ZweUQveFc1UnhNb0JxVStUOW9B?=
 =?gb2312?B?eUVta20rSEtIcmlwYjU2TGt5UmVmQ2NmOWpRcXNUczJlN1h6S3hXYXBvTUw1?=
 =?gb2312?B?VERQTUcweEhIUmh2RUNCaHBybnVnWmRFa1Z0T2g5QlhRaSszVW9wekJ3cWda?=
 =?gb2312?B?WkRnOTJVdUpjWkRCQkY1UGxEZWI4TEtwbFBOeDJ6MUZPeWsza2NzdEJMR1RE?=
 =?gb2312?B?dmpHalpwT21oRXpHY1JQR2NzRFRoWVFnT2JYZjlPTHdCQnE3WUNvb3NCZGFt?=
 =?gb2312?B?eWErQTlJMDU0WkxGbkxiNFIvQkppMGR0TTVnZURMNi9ZMWZnbjZBM1Zoa2Ro?=
 =?gb2312?B?eGMyemgxQTZuejgwNXFzOXI0QzQ2ZGpld0ZOck15RjNuTjFvWWdDWlovaHB2?=
 =?gb2312?B?MUd2d0hSY203UndIOGhOYkJ0VVRWTjlZVTl4STdtM1ZQK0ZVN0JWZ2gvblBZ?=
 =?gb2312?B?MWN6K3c0a0dsbGN1aHQ4SittWDlzWWhWR0QyMWcwM2VMWGRFYkJSQkxNVWd1?=
 =?gb2312?B?MDFVeTJlR2V0aHplQktyckZjd2pVTWljR051ekNpRVhsMW9JL0oyYUcvZ09k?=
 =?gb2312?B?WUtQMExvRWE4RTZVaFRjQmxCbXdzaFJnUFIzTE1GNTFMellXblEvQVVTTTBj?=
 =?gb2312?B?SVlrT3hPbTVvdFJpN3VJSEYzWGhvbXFUZnB5Q1pYVmYwZ2QwdTIzYnl5Q1ZL?=
 =?gb2312?B?ZHZad2NhV0h0djc2QWVvTVhYMEdYSHU3YTMrSExVVmxBTEllRmxVQXQ5a2Vx?=
 =?gb2312?B?bzdrd3lXTEVnSG5iSTdRTG1kUjZ4NlZnY0lkMzI3Njc0TjBBR1EyV1ViQzhC?=
 =?gb2312?B?c3JqaUFtZERvVGc5YlFaaTQrWm8zY0RLdjdkMHNPU3hYemo0RlVqclVkdVpw?=
 =?gb2312?B?aW81ejBoZldxSVp4MURrankvSVFXenhaRjhSUVh5Ri9va09oYWFFR2ZUL3g2?=
 =?gb2312?Q?a91k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43adf366-edc3-4e0f-1b39-08dc5ea75a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:26:44.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PBhnCFIq9qhx0vWAAHAWdbEL+FJ4n6YSpgnbu4r6SDuzh80erktipWEBC4T/xpAdRaKFdf/3MY5is9NgReNCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8144
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
	9DBE6DCB56974856A65218F8BCA59899D6C68623894C9FBBEE77D47E6E1EEE202000:8

Qm8gWWUgKNK2sqgpIL2rs7e72NPKvP6hsFtSZXF1ZXN0XSBiYWNrcG9ydCBhIG1haW5saW5lIHBh
dGNoIHRvIExpbnV4IGtlcm5lbC01LjEwIHN0YWJsZSB0cmVlobGhow==

