Return-Path: <stable+bounces-46034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18A8CE0D5
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 07:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62EC282D12
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE4127B73;
	Fri, 24 May 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IYR/FwPE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LCkV/Gq2"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55B1272D6
	for <stable@vger.kernel.org>; Fri, 24 May 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530324; cv=fail; b=MF5JOBD7DRA4UVocmJZmandhwDBgHtsDfEYzZq//mdq9CG7szGtpdVe6aByt9Ow30ulZ57jdpNtHeRKcPChAGuNdeK8YM8lMNEMbOnpUXIUrXedtSzsSkEDuN/PtbIK/1gyew4p5uaWe5tiRya0KBtGBhGqUdO1usR+xolfoUxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530324; c=relaxed/simple;
	bh=Zg/vxGMaJqPAZ6oW7j11dHMFt1Bg0XHD3VEx8VaO/lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgwwJGdYAdUfOcv75jOfqiFwPk0BmSriVIN7GDZ9zO8VX2Xfi86Oh1/NbRGPN4dRzgilN7wlFketeeEAAq8rjqy11wZB+Hog78Cs6x2brzQd6AoN08ugFpFDJAjXd0WZfdKrDbbyOUCpbcmWpDGAiwJtWWX8Xr9GEx8G+cMnX6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IYR/FwPE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LCkV/Gq2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a941e5f6199211efbfff99f2466cf0b4-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zg/vxGMaJqPAZ6oW7j11dHMFt1Bg0XHD3VEx8VaO/lM=;
	b=IYR/FwPESRi+R1tXXC8rINZAr9ZA83032Y0AuhCjVVzJXwV8MA39Pkijv6O8jZ/SrPsiL3oUFc3Osi7vkLkLGjBxerMHR4YHbTA6IkauT/xLD23Uqh2IRVzILaVBtUni5lkFQUsdjWj4d4LGH1CQkrQVEvQQMKYmZWq0UI8Xsis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:cb319e3d-33a3-4605-acd1-c830da486bce,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:15f12893-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 50,UGT
X-CID-BAS: 50,UGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a941e5f6199211efbfff99f2466cf0b4-20240524
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <lin.gui@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 155900768; Fri, 24 May 2024 13:58:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 13:58:34 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 13:58:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS7YxE4Ehk3PTjj4j7RYt5tXqPGf+d4mpp4w7zd35dljNJDFeW9L0mpW0FudJka7SgZ3GZ67bdzR4OxbFlJX3yz1rAHzKIHjVyxa3GL5skkxVppzYAJY70TT/232nhmj0/RYcx57V8YlHN6Mv4/iDEWSgJfDzoZxBgamNUiqaaoHmWbsD7VAuuQBRwEs8MN3JHg57BF/3T0/2ixCqdQwEB2YpQBeWeNKARiPq7WGOZZu1jK0Qo0S0pcRRum0W/tdDcagsS5C8TdgFvTv4ZFVi5iPWMcxMYtn3QaY6x/msvnLKj8z2uYq6tOp+dTjwr6tv34+W77XjvN2v5hfymwI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg/vxGMaJqPAZ6oW7j11dHMFt1Bg0XHD3VEx8VaO/lM=;
 b=BOZHaaqHMDkH9UaMy4tnnnqi5+WInD91DYGM2o1kgS4d6z4R+c4MASPwAu8ezHoZ82W5T1Uixi9UqVrFo4X9+dVVHcXO3u+E+40eXGvs9T1f02LsiAqMY7gl3DeE0w8yTN4fpWsznWmv8dm4y7zo27EDR9WE1M++/OvuL3GhF8hRgXevrCIs2UmJIq2cTR8x9HjCTf4Nbn2aU9qxOC0UbAXSNQI5uJheqUiYfLNuyUDfATz+2AMeKKigcvHOquUANZ66CLcnUu8ONQncuOoDbpr/fbwbYoxOf/ZQpozur6A8xv/9yYqvW5/Nm1ZV/rJ3/S1OwZdKF5MSGuw1lY08Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg/vxGMaJqPAZ6oW7j11dHMFt1Bg0XHD3VEx8VaO/lM=;
 b=LCkV/Gq2vJ522BDG1Y22XOrHCWyYKfZAyckdgzmIB0+r6Zz6BWkSM/4EUCnlj+KS3r+q11vd50iuqqAxFwp74DNvupas5oR7Xoq56RE94kSfF2a9ekCm+EtMo1SpnaH/CSl5Cr8KB+++yn5nt53tIao3L53uLO4NgPoibb1M8qU=
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9)
 by KL1PR03MB8823.apcprd03.prod.outlook.com (2603:1096:820:142::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 05:58:32 +0000
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2]) by PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 05:58:32 +0000
From: =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?Qm8gWWUgKOWPtuazoik=?=
	<Bo.Ye@mediatek.com>, =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?=
	<Qilin.Tan@mediatek.com>, =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?=
	<Wenbin.Mei@mediatek.com>, =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?=
	<Mengqi.Zhang@mediatek.com>, =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?=
	<Lin.Gui@mediatek.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBiYWNrcG9ydCBhIHBh?=
 =?utf-8?B?dGNoIGZvciBMaW51eCBrZXJuZWwtNS4xNSBrZXJuZWwtNi4xIGtlbnJlbC02?=
 =?utf-8?Q?.6_stable_tree?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogYmFja3BvcnQgYSBwYXRjaCBmb3Ig?=
 =?utf-8?B?TGludXgga2VybmVsLTUuMTUga2VybmVsLTYuMSBrZW5yZWwtNi42IHN0YWJs?=
 =?utf-8?Q?e_tree?=
Thread-Index: AQHarLpm4Pel55rT8EmHOVSPAeydx7GkXJ4AgAABPICAAANHgIAAFiUAgAAweoCAAOtIEIAAM6mAgAAd3ZA=
Date: Fri, 24 May 2024 05:58:32 +0000
Message-ID: <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052426-recognize-luxurious-bda8@gregkh>
In-Reply-To: <2024052426-recognize-luxurious-bda8@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-Mentions: gregkh@linuxfoundation.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrNTQyMzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hNGRkN2FhMy0xOTkyLTExZWYtYjczNi1hNGY5MzMyZDU2ZjhcYW1lLXRlc3RcYTRkZDdhYTUtMTk5Mi0xMWVmLWI3MzYtYTRmOTMzMmQ1NmY4Ym9keS50eHQiIHN6PSI1NTUyIiB0PSIxMzM2MTAwMzkxMDQ0MDkwMTAiIGg9Ikg5TWFOblE3L3ZxS3dkd0JPUDNXcWlNNUk0bz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5653:EE_|KL1PR03MB8823:EE_
x-ms-office365-filtering-correlation-id: 980ea550-5236-4b46-808c-08dc7bb68afd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UDF0Vi9kUXRMcjAxUjVNUWhRUDBhZndEWHBvNlRDdWpwTWNiaFBHcHEwV3BE?=
 =?utf-8?B?YTJFRlRTKzQybWtuOXFJZmE1TVpCMW9KcFVzdmZROVcyeVdFU0wxZ2RDMkRZ?=
 =?utf-8?B?dUxZQndpNFlJL014UnVTdlJRSUh4VkQweFJmVjJHeFZVUDdXc3lnL1prZjY0?=
 =?utf-8?B?Uk9MeGZibTJHaStvaGV1bEZobTdXUnV1VFpET2I5MGhUK3VVdCswb2ErK2ZM?=
 =?utf-8?B?NGdZUnlXQW5pTjIyWVNWd2Nsa0VRbTkrYzJwM2RXeHZVK2hWZzVXeDkxNWpF?=
 =?utf-8?B?enNmQjFRSi9kQlRlb3MzVDFDZTNWR29xRm1lRU5kK0RNQ0lna3EySUlTeis3?=
 =?utf-8?B?aE9UK0J3MnpEVDhJU2hpdEYrTG1pVnBES0l5dVp0bnYwSVZ6NXBDYlMzVGJC?=
 =?utf-8?B?dzdtZkJJZVlZbkVGM3g0MEpXUFdwWk1rY0pJR2lLNllqQlZlUDdkbk1QOVpl?=
 =?utf-8?B?T1Y1MGwyZEtZNk54TmxBcEZqZFNtUTQ5U1ZkWU1yWWMzYTlMYWRMT2pqV2h5?=
 =?utf-8?B?N3pwSkkyL0RzbENFbnBQbE95UzNYekVWM1JRcVhsa2wrUU9ZMFhQY1laWFlG?=
 =?utf-8?B?ZGlsZkd2OHpkUmYrdlhlWVNlVlc3clYrL25jMk5hMWM4eVlZTFIvOEZZZlpL?=
 =?utf-8?B?T0VBUGdRVmk0dCs4b1F1a29GeHZMN0pwUW1CaFdEZHVCekRNNlJIL21wRVRM?=
 =?utf-8?B?aDljQS9xYXNETnk4dU12eXB0dnlVL05BbU9rR0VoaS9tZmhHL2FUSGRSN1hm?=
 =?utf-8?B?VXV0dGQ3Z25tMDM0a2tCU3pkeHY1M2dkMDB4M3cyNVNXZDNXQTBvMjg2eHBq?=
 =?utf-8?B?STZVSER2Qlh1NjVGRk15QmkrcHZVYkx2ZGVjR3BrWnhrV0xWRnNlT2lqQWMr?=
 =?utf-8?B?Rm9rdVpMR2loMWR1ZkxhRHlIVEhQVnVlWjVhTjFVbVBIa1VZVnpDMXRaeEsz?=
 =?utf-8?B?Tlc4K2VvZk5aYXBpYWxBY2haZi9VdTM1UU92bXVqSGQ1ZklSYkFOQTRKVXhZ?=
 =?utf-8?B?K2swVkh6clVpSHlPK3N1U1RHVmt3V1p6eUJxcjlseDk4aURIZ0FET01oOUZx?=
 =?utf-8?B?RFNGVDZJSjhNZ1pRT2EwUU90Mlp5UTZtanVncmpZQlc4U1BtUjJOSGJFaTVK?=
 =?utf-8?B?ZVhtcWZycWtNSnBwRUF1amRmdGZDZ25uZHdRcEhFQVFMR3RTR29MSXVlYXVh?=
 =?utf-8?B?MFYvQ3MxVGlKNEczYmoyc2lna3NxT1c0ODVxeFNlVSs5Q3VzaWtham5DYWdO?=
 =?utf-8?B?N21vUTRpTnJtYmNlWG9samlDK05rOUlIS0VycG9oQ25ZRm5kVVVHWTZBSEl6?=
 =?utf-8?B?YSt3bmptUE9PaUkzS1J1ejBsaGhEeCtJZ0VhN0xPSWJDTEtzRjlWV05Va3pN?=
 =?utf-8?B?Z1RIQkpSMUdOT0tIZlNCTEg1b3hvT2VSb2ZrMnVrVVBLZXdSVnhwZWpjdVBU?=
 =?utf-8?B?N3dleE1QRDB6ZWw5NlJQYjN2OCtka1dGRTQyWEtaUEpOTWJEM3E2UDZFdXJX?=
 =?utf-8?B?MnhKYXpDZWZEVFFZb0ZnT0ZldjA5emdRT0Fpc2RIaXEwZXlCV2FNRm5GTlZB?=
 =?utf-8?B?eFRqQUYwTUZQdk9RMU1hMVhQT2NkYWlDdVNZOUd1T1dHOVpYUUcvblJabFV3?=
 =?utf-8?B?MlBMWWpTV24wVDVMNzdnOHU3eHlMaGVFTDBqbWhFRzJnWVM4WTRCcWVhOHFr?=
 =?utf-8?B?N3VMbEVKMlFTMUpINElPbC9xQ3BRSUJ1a25QKzArdWZJbDd4RitxN1hBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5653.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5KcmVOdGxTRlNVYkV4VFJGQWJvNU1sbDZlcmQzSFRDbUsvWE9aMk9CeWYv?=
 =?utf-8?B?SUxsb29oNW1MakJRdnFvRG5ldHQyTzBPVWVnOXNuWWV0QjZlUWJzc21sL21F?=
 =?utf-8?B?NDdzMkFJQkFUemdhMytiZVRXRngrTGxaNFQrd0xQSTFIdVludU9CRmljL0Ev?=
 =?utf-8?B?ZXlGMGhrWk9BeHFQSHBVWWdoVy9kQkg5Q1pYd0NMQmdaNS9TbmwybXVCU050?=
 =?utf-8?B?VzhMd2F5WXFlWEFmYVl1Smw4UVJNeEtudThJbDNHU1o0a0w5Nm1Bc3JWdXRG?=
 =?utf-8?B?Y1M3VGd0WlBJRXlFdnZqdWpSVm96UHN3bHJhdWc0REFDbnNpcFZ2OXR4YmZO?=
 =?utf-8?B?Qk9xTHlLQ3ovbEF1cXpSVTA0SzF2VXpXMmtFcnlrRjc1TG01L245SnlQVGJG?=
 =?utf-8?B?L2hwbGprT3F6eUkyMWxrRlJWc0s3d3N5YVk5RHd3dzA1eVJGOVlyeGdnalVk?=
 =?utf-8?B?b1pFdHlwRklvSk5OYzd4RXdTWVVsWFVkN3dFY0tRNGs1Ykp4cXVZalpuMmdZ?=
 =?utf-8?B?UEJiUkJYd1dHU3ZhWTBhejd0SVlCeEh1Yk8xc0E0Ykl6SVJwcXhXWWppYmE2?=
 =?utf-8?B?aHdxdXRVMTh4MFU2OVFleE04M2lGV3NCUDQxRFY4b2k3V2FBTytwaEhIbE5y?=
 =?utf-8?B?c3lmVklPRzhrTHliKzhWL1l5QW5FcU5xcVFBQkc2NVV0cFF4MXBTL3orRE1y?=
 =?utf-8?B?bi9VZG1XRTRKY1FNWW1rTHY5MnI2a1lDdUpRYURjTDhTV1FaL1V3V25pTU5E?=
 =?utf-8?B?ZVYxQklueklPbTIrZTVLQVFHcjM5cGp6VWNtVlkxOE1ZVEtxSFhGQml1RTMz?=
 =?utf-8?B?TFp3MWZRTE1xRnp6NGszUXZpMDFSeTg5c1Z6YzJHSlQrVk41dkV6UlRTRHcx?=
 =?utf-8?B?SWdzYmxucWExc3prckRsRElORmdLUmI5OGludUpucW8rV3phVDVjSWlrWHZL?=
 =?utf-8?B?Ly82dk0vZ2RhQlU3d2xFSUFjMTZTR1ZHOG51Rm1mY3hndEhCVitlQnpKRzNt?=
 =?utf-8?B?bzhEcDFEUzkrZkVoMGJmeW5WZDNUMmNuMnQ0YVMrdmUxeTNnQXE4Q2xaT0lm?=
 =?utf-8?B?Vmp0M0dWWVVBOFk1eUV2Qy9oZGdwZWZyMVNSYWYzbVNWbE9lWnJGcmVaODdE?=
 =?utf-8?B?KzVaMFk2ODVVeTIvWjdIT3lXQUYzWDg1aFBNUXRDVWUxTHl1VXBuYmZVUkJM?=
 =?utf-8?B?OGxjeWttRS9wZVFwdi81eUExa05iRTBPVEx5bDFoQzlsa0lmSTV6VVp0OE5K?=
 =?utf-8?B?d0dPaWVleitFYy90N2M2MGRqQlNISGdGVjZXbVM4bGpsVDN1RnhJT1VqS3BK?=
 =?utf-8?B?c0VoeDZpUHZMZUhTZGNKZnRhbUV1dnZXbHRBWC9RVnYyYU1uVFVLSmxuL2FJ?=
 =?utf-8?B?NVplanVGOHN4aGFMNVovZGZRRlZ6aFk1bXJZazljaXNZOFhXdTNYMjVocnNk?=
 =?utf-8?B?cEtqUXBvYzdZL2cxM0xNZVdiQU0waVAvbFU2NzBTM1Fkb0tVZEoxVEJVVTF2?=
 =?utf-8?B?MFRTUFZ5bTlMR0JpeEMzaTNpMk54WGNMZnVyVkdPWGZyUHZZOTJ0QlplQ3Jy?=
 =?utf-8?B?UlYvTVVHRFE5c0xLbGx6eDlJc09GNUM1YjRBV0tKL3Bkc0FsNEFhcXltWTIr?=
 =?utf-8?B?dUQ4VGFvSDBMbm0rSmFMblcyaG8vdmJWVUpYc09JSG12dFMvVTFacGlRZ0hM?=
 =?utf-8?B?bEZFTGlGbnBlbWwvUXk2bDVMZ0dNMjljdlFySUh1ZU9LcDNxbzRzbUoyNjcw?=
 =?utf-8?B?dUVCdmxuZFZFTUhFM2lTTm5hTFMxVEo1dE5hK0ZkTFQzendrUnMvaDl3M0R2?=
 =?utf-8?B?cjJhTjN3dE5SaFdITXJOWFI5TmNobWVET3FlcEVlUlRITi9JempDMDJvNWNV?=
 =?utf-8?B?eUJBOU5tVkg5SWcvSmRGZmIzUFdQM1F0elQ0YnVWZzZkU1BkcmlIcWJsSGRv?=
 =?utf-8?B?TGJiV3FXQ25tRWZyZktONjEvWm9CRjIxWitoOG1YaTZQT1dtcW9zV2hKMkli?=
 =?utf-8?B?QUdqc3VzR040VnF0Y1VHaWV0cndrWFVYZlRFYWlpUWo4bUs1MlRUeFl5MFlN?=
 =?utf-8?B?T0NDd1dlQ1BxYUpVZUp1TjZnUk5Zd045NmdRYUtpR3FXa3NtY3VIZXBEWFRk?=
 =?utf-8?Q?OlyvxEWg5UhEvjcuRBR5BIF1u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 980ea550-5236-4b46-808c-08dc7bb68afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 05:58:32.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3TX+tLonUH78t+35rnbXnXrS0e3TDZLpkT5o5ONJP3e0IT8kOvXLMB48C/B3Qe85/CmImDMC1OfGYOeExPV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8823
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.932700-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0MlAE3bRY0vZ1t3XMydUaMXYQXxsZnRwoLjud2x7TPVtwOH
	les/nBwnVKFPdwZMpX1KhBUJyxjhBpCoy9iDotiwzfqlpbtmcWjb4SkGdkTN9dXPU594iqU3Q12
	OR9jMV+BnU1t8LQ9ljxNDJOaBVlnyN0y7mRIiBXcZXJLztZviXDFGoZFuXY9+3GeBkguwpxNSZL
	EBWfbrB/Gtgcj+b/9KMiIZaEzjeLZ48YB5KfXbgkLcvIIgiVuNq93da5kXQoClyfbzMrA/wskUh
	KWc+gwPVw5KjThpZQ48MXho6UtjB0kjllSXrjtQ0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDU980qe9xzB3A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.932700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F60854AA282944B01158A2D274790F0C9ADC0847F0B5DB97CE979D0D4C7F6F262000:8

RGVhciAgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcsDQoNClNvcnJ5LCB1cGRhdGUgdGhlIGZv
cm1hdDoNClRoaXMgcGF0Y2ggaGFzIGJlZW4gdGVzdGVkIG9uIE1lZGlhdGVrIFBob25lLCB0aGUg
dGVzdCBwYXNzZWQsDQpUaGFuayB5b3UNCg0KDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9j
b3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KaW5kZXggYTU2OTA2Ni4uZDY1Njk2
NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCisrKyBiL2RyaXZlcnMvbW1j
L2NvcmUvbW1jLmMNCkBAIC0xODAwLDcgKzE4MDAsMTMgQEAgc3RhdGljIGludCBtbWNfaW5pdF9j
YXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9jciwNCiAJCWlmIChlcnIpDQogCQkJZ290
byBmcmVlX2NhcmQ7DQogDQotCX0gZWxzZSBpZiAoIW1tY19jYXJkX2hzNDAwZXMoY2FyZCkpIHsN
CisJfSBlbHNlIGlmIChtbWNfY2FyZF9oczQwMGVzKGNhcmQpKXsNCisJCWlmIChob3N0LT5vcHMt
PmV4ZWN1dGVfaHM0MDBfdHVuaW5nKSB7DQorCQkJZXJyID0gaG9zdC0+b3BzLT5leGVjdXRlX2hz
NDAwX3R1bmluZyhob3N0LCBjYXJkKTsNCisJCQlpZiAoZXJyKQ0KKwkJCWdvdG8gZnJlZV9jYXJk
Ow0KKwkJfQ0KKwl9IGVsc2Ugew0KIAkJLyogU2VsZWN0IHRoZSBkZXNpcmVkIGJ1cyB3aWR0aCBv
cHRpb25hbGx5ICovDQogCQllcnIgPSBtbWNfc2VsZWN0X2J1c193aWR0aChjYXJkKTsNCiAJCWlm
IChlcnIgPiAwICYmIG1tY19jYXJkX2hzKGNhcmQpKSB7DQoNCg0KDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQmVzdCBSZWdhcmRzIO+8gQ0KR3VpbGluIOahguaelw0K
DQrlj5Hku7bkuro6IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiANCuWPkemA
geaXtumXtDogMjAyNOW5tDXmnIgyNOaXpSAxMjowOQ0K5pS25Lu25Lq6OiBMaW4gR3VpICjmoYLm
npcpIDxMaW4uR3VpQG1lZGlhdGVrLmNvbT4NCuaKhOmAgTogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZzsgWW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCkgPFlvbmdkb25nLlpoYW5nQG1lZGlhdGVrLmNv
bT47IEJvIFllICjlj7bms6IpIDxCby5ZZUBtZWRpYXRlay5jb20+OyBRaWxpbiBUYW4gKOiwrem6
kum6nykgPFFpbGluLlRhbkBtZWRpYXRlay5jb20+OyBXZW5iaW4gTWVpICjmooXmloflvawpIDxX
ZW5iaW4uTWVpQG1lZGlhdGVrLmNvbT47IE1lbmdxaSBaaGFuZyAo5byg5qKm55CmKSA8TWVuZ3Fp
LlpoYW5nQG1lZGlhdGVrLmNvbT4NCuS4u+mimDogUmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06
IGJhY2twb3J0IGEgcGF0Y2ggZm9yIExpbnV4IGtlcm5lbC01LjE1IGtlcm5lbC02LjEga2VucmVs
LTYuNiBzdGFibGUgdHJlZQ0KDQoNCkV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQoNCk9uIEZyaSwgTWF5IDI0LCAyMDI0IGF0IDAxOjA3OjE4
QU0gKzAwMDAsIExpbiBHdWkgKOahguaelykgd3JvdGU6DQo+IERlYXIgQEdyZWcgS0g8bWFpbHRv
OmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiwNCj4gDQo+IEJhc2UgOiBrZXJuZWwtNS4xNS4x
NTkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9t
bWMvY29yZS9tbWMuYw0KPiBpbmRleCBhNTY5MDY2Li5kNjU2OTY0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL21tYy9jb3JlL21tYy5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4g
QEAgLTE4MDAsNyArMTgwMCwxMyBAQCBzdGF0aWMgaW50IG1tY19pbml0X2NhcmQoc3RydWN0IG1t
Y19ob3N0ICpob3N0LCB1MzIgb2NyLA0KPiAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9jYXJkOw0KPiANCj4gLSAgICAgIH0gZWxzZSBpZiAo
IW1tY19jYXJkX2hzNDAwZXMoY2FyZCkpIHsNCj4gKyAgICAgfSBlbHNlIGlmIChtbWNfY2FyZF9o
czQwMGVzKGNhcmQpKXsNCj4gKyAgICAgICAgICAgIGlmIChob3N0LT5vcHMtPmV4ZWN1dGVfaHM0
MDBfdHVuaW5nKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgZXJyID0gaG9zdC0+b3BzLT5leGVj
dXRlX2hzNDAwX3R1bmluZyhob3N0LCBjYXJkKTsNCj4gKyAgICAgICAgICAgICAgICAgICBpZiAo
ZXJyKQ0KPiArICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9jYXJkOw0KPiArICAgICAgICAg
ICAgfQ0KPiArICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgIC8qIFNlbGVjdCB0aGUgZGVz
aXJlZCBidXMgd2lkdGggb3B0aW9uYWxseSAqLw0KPiAgICAgICAgICAgICAgIGVyciA9IG1tY19z
ZWxlY3RfYnVzX3dpZHRoKGNhcmQpOw0KPiAgICAgICAgICAgICAgIGlmIChlcnIgPiAwICYmIG1t
Y19jYXJkX2hzKGNhcmQpKSB7DQo+IA0KDQpBbHNvLCBwbGVhc2UgcmVhZDoNCiAgICBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWxfXzshIUNUUk5LQTl3TWcwQVJidyFo
amZ1NXZnNTVXS2huQ3B4UWJHbk0zRDdORldtc3JhZHRaZFpqdEN4ODBxaTZfSTdoMFh6QjRfLVNf
SlNmcW9PRXlIemFtMm9uSTJtZ2dCb1J2SlUzMVkkDQpmb3IgaG93IHRvIGRvIHRoaXMgcHJvcGVy
bHkuDQoNCg==

