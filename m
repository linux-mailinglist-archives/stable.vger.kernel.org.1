Return-Path: <stable+bounces-108075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD5A07279
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6708C1885C27
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D17215773;
	Thu,  9 Jan 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="dx8Q/Bwq"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197A1FCFF4;
	Thu,  9 Jan 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417544; cv=fail; b=cII+YcRKQb7/yTQ77nBO2iX1cfP615jFvOv8txjpzyNmb8UhcG6MIyP+4ghh1jKiyLPr+SXE8CuDDBYkWGiP97a61wCFco5c97K2GDMZbe0RROsS1XTv0risaibqmr/Wc94k8f8rpzexCtZa3BNxD2AhcUDEabPpFYqEReVu+0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417544; c=relaxed/simple;
	bh=FwrO9u5CmY67lkJoBubEXOWheM9IESpxyOUo+eL53os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ojZ6rqNeW5UDVpTojKeXptq++zHLTdp9eagS7mAp1KEOe+k3+ukw7IynmRokmyy+Grq4lB7DMolbLmyJDRs/k5TrY5Rpz3v+fnSexYQIGyWB9a8gICuklNdlO3srAr65adeutwe7Srtc4JOrNpQNd0dqRPoD7khKtDUpCCBBq2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=dx8Q/Bwq; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn8w3wCv9EhVZnHU66jc4G5ucn4qJKjF04bB1TrPgmWxZal1fWey7VR5eZTqnD/bJ5vvyHYkFon1Z5SsE35LinJ22LnE27PmXhh4fA77S2HC4VD8kaG885m2ZiUNEshesP2LjAkIMFMKtBDWeLg2nWYhp+9dljeEuCFtiG0wV+gsyDmlsI7EnMNZqWiFEpSwSoC/9a2FhCdWq2OXmZBE7+5FCa9PvX3u2pRoGIfCjSV6gBsmnVLFGoWdruurwUKDereo6eq8W3147QuCbBV3aZdPPWzECIJkZVPewW6ohGiwT2+ClQDs9Zvf99rMeT0TLMdS6TnMSFXXUi79Wl3ZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwrO9u5CmY67lkJoBubEXOWheM9IESpxyOUo+eL53os=;
 b=CvzdqN/TepqH8qPKr3caqk9oRx2GILnDtlTq+R0rttHLTeHsILHtCQlAmBmftN4nXbo80kR/FZULhR+ELxAcPhpIqEsyTo9nadlpmJwLgAShdXaaLynMseUMMxyyoDWV7IKUkVOvb/EeEnCld0/v0y/aowPCUSVSXqGhztWtzPZ/ehlWvlAs4evtQe2sK/S6PV7MbTUcdt4fDSmr4u/xoj4ls4g02+SNbFiJWQkUVNKz4Jte4yoes6J5PewFM6/APCEIntY3jXv/mi3rR5y6oZcZYAh11uBS46zJVqlBpJxEwyMbE7wf3P8q2qcVGA+NjAsHKXndVrLe8UAP4ULKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwrO9u5CmY67lkJoBubEXOWheM9IESpxyOUo+eL53os=;
 b=dx8Q/Bwqe+9t1oluolaLKyOcljIwP3o8ubK0qZclFown2YpmvJMSOMAcaIC7W2NV26ZWPRl9O43SSgPo5KhXhW/RRkXx0jLQitOp8GzQBPLFamCMBSmX3wfX4Rl0oTFHveFktNevVkIV7Rb4396SjobLXywQ4fjmh2CNP9JUJJ3g7rpA5rVrEFAixlfGL05gxh1yWyozAjhIGNJeJJJzKsxsXvtpT+hR9s40SlyHHfoPIQs4cdBidaEufFrcGK3TzZIhgAg53saGGr4aEQ0+aOkdImR7WjoYh0rq1fv4dO4BadFVa5H/uDm4oO7X2TqcvxqREpQXBuOCRtrea+rS3g==
Received: from BN7PR10MB2610.namprd10.prod.outlook.com (2603:10b6:406:c0::30)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 10:12:16 +0000
Received: from BN7PR10MB2610.namprd10.prod.outlook.com
 ([fe80::c5b0:801a:5214:f38b]) by BN7PR10MB2610.namprd10.prod.outlook.com
 ([fe80::c5b0:801a:5214:f38b%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 10:12:16 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "pchelkin@ispras.ru"
	<pchelkin@ispras.ru>, "richard@nod.at" <richard@nod.at>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "yang.tao172@zte.com.cn"
	<yang.tao172@zte.com.cn>, "lu.zhongjun@zte.com.cn" <lu.zhongjun@zte.com.cn>,
	"wang.yong12@zte.com.cn" <wang.yong12@zte.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] jffs2: initialize filesystem-private inode info in
 ->alloc_inode callback
Thread-Topic: [PATCH 1/2] jffs2: initialize filesystem-private inode info in
 ->alloc_inode callback
Thread-Index: AQHbOSDW2WKmxrrjS0S2QDHBQjrZnLMOi6YA
Date: Thu, 9 Jan 2025 10:12:16 +0000
Message-ID: <77684009a0a2c527168df4c40077e51a69773ee4.camel@infinera.com>
References: <20241117184412.366672-1-pchelkin@ispras.ru>
	 <20241117184412.366672-2-pchelkin@ispras.ru>
In-Reply-To: <20241117184412.366672-2-pchelkin@ispras.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR10MB2610:EE_|CH0PR10MB4890:EE_
x-ms-office365-filtering-correlation-id: abe9d2cb-f7dc-4437-2c8b-08dd309617fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGlpL2g2WHJVb2ZoQ1phNncrQnFHWUdnaUtwd212ZWVhdUZPWGZRMkp0OTN1?=
 =?utf-8?B?ME1LWWtpNnJjclUvWTc5TTZTY2hxWDRXbXdsUlRTaFE3TVdlVjNZcUJRdDRP?=
 =?utf-8?B?cDBXbXdkVHNKL3RtL3YwMkN1Vi9VZDlxNG9lNXRaRm9HTWJkNmtmQ0pYeUZ0?=
 =?utf-8?B?eVV4bDdTczFnTWZjWTdrVjZjNFgzWUxqVnBHc2tqcU5aT2VoeVJkUXY1cHUz?=
 =?utf-8?B?QlZpV3RIZFBxUitCOGxmRE5kTGFuano2ZW0waWtpS25ucnFXc21uM1lsME5l?=
 =?utf-8?B?TWVFMXI3OFRDRXh5UFVIM2ZkY3hFTURkRkpBdDA0Q09mV3hPUzY5RXRtMlcx?=
 =?utf-8?B?TFlmRW9jRXNLelFrYVlKWlpSOUFibjdvb1NoNWVTbFpzTnY5azV6T3JoR0Rs?=
 =?utf-8?B?T05iZjN0elUyS0FXN0FaUURuR2RsV1p2OE5NdjQ3K3pUeWYwcjZSakxlUmhT?=
 =?utf-8?B?S3gxYnEvK2NBcGY3b2JXQ1o2cGxCWUZ3Y1lkSnVqVGNtaTcwWS8wSmNFcWJy?=
 =?utf-8?B?Y2pZeXIyQW5mN0NUNmlNYmJEcG5VNllTVU5oeHZ1WS9vZW5pNDFsL2pHdnFU?=
 =?utf-8?B?UWtIYVo2K0JJa1c0bER5a2Q5R01sQ3pXdjQ2NGh5N0FKL2ZLZ21RUjFZd1BH?=
 =?utf-8?B?SzhHRUZyc2xjK2pmeEtDeGk4b0R3Nk51RkRHSktIYkZpQ3FiY3FINVJmQ1Rl?=
 =?utf-8?B?bVJsMUZjQkdrQ3gyaGZieEpScEpsVktsaGVWNm80Uk8wWjAxRUsxeitNNjRw?=
 =?utf-8?B?TmgvenFGaXlkb1FPSjhSVFpMT282aEpmWG9xeFpyRTJONWFyZE52N2k3SkNG?=
 =?utf-8?B?ek5qc1JQTjZWVUE0WENkUlB1V1MzUlRnTFBCcXh2M1UrcFJybjdkOUR2bzlh?=
 =?utf-8?B?OU9Odlk0aDdpc0ZhUU5MNnhCKzM0Z0JvSEZFcFFNZXhhOThUVGRPaEFWMXJB?=
 =?utf-8?B?TXNUenY1ZzkzVUdTZ1BzaDBkLytHN3g4SXpiU0NLbnp0ajlHNnlVaC9DOFg2?=
 =?utf-8?B?aVV3MFhxL09idkRwMnhoN0JaM0hUWlkxUkVEWlludWxRZ2NNM3RKMjh0Uk0r?=
 =?utf-8?B?alloWHc2dWhlbStiTUhWUEFSVnM1Qlc5TDMvVGk1RGZaK09CRk5JUTB5MENO?=
 =?utf-8?B?bEZLV2lZQUkxWnZGQzdZWEh2WjVUVmpZeGllbmM3aWJMMHl0cFh2Wk9tNmVX?=
 =?utf-8?B?MXl0dnMxcXM1d1hsVlR6ZkpRakt2TG9lOFg5UUdHRWpMQ081N2lMR2JCR3M2?=
 =?utf-8?B?eFJLRGQxbzg3WTgycENFVWRBaXdGMmYvWWtQQzBPeHpPRFd6Mm1MK3FNTlQz?=
 =?utf-8?B?c291MkRsRjN4anE4S2dyZk9zUTY0UzRHVzVVQ2FlRk02clMrMUU0cnFLVHNT?=
 =?utf-8?B?TWd4aXhYaEZ2QTZReU1mZGVLMi82aFJkYTZ4S2ZwVXZ3Rkx1c0VMSksvYnJS?=
 =?utf-8?B?NGxLbW4zZkNuTGliR0dBWEdFektWZjM0SzRxdnFMQ2VwU0VVZENCK2J2UXhp?=
 =?utf-8?B?b3VkTEZvWXpSSTZ0QzVFZEY3allyVXlaRS8rM3BRenhSeEtjVEhCb0VLSktU?=
 =?utf-8?B?eGExTFZEcXA2Y285ZXZBbUFmWlRvTThxSzB2RENGMEd6NnVldnd2Qnd4azF4?=
 =?utf-8?B?MUNWd2NVWXpLa3NuUXZ3U3BSdG5GSjlrL3pCMjU5czdRUkNWUjIzeDIrNUlP?=
 =?utf-8?B?WlRuWlNMRUFCVXFrcEFKUXVUdzcwbU1mMlJlNmpPRmp6Z2xMSW5qL3MvNmpr?=
 =?utf-8?B?czZtWW91Z1V6ejIvODVVQk90cEhQUExIVWIxTUZXWG9abEhvbkVNSDZCclFo?=
 =?utf-8?B?eGt5eit0SkRMSUVVWU84VGI5SUppU0ZxK1Jaem9HUEFvbUtDQmVFV2RmV1FD?=
 =?utf-8?B?Ym1NNXVuaTFhc0xET3pKVDd5TDZqR0N0RUdIOVcyRWlwTVltYWFTb1d1bHRK?=
 =?utf-8?Q?ntujn3sQi5cyb8o28uDdL+VRUXJkZARY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2610.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VittK1RycmFoNTVMaHJiUmg1M2Z1Ny9QdVd4TkNQVTBKVW1LMWpYUUdmTk5I?=
 =?utf-8?B?UGlRQlFZMnh6N2ZhcXFaeWIvRUNDaDFPdU5ZeVZqK25Nb0g3TzZpTU1WVldz?=
 =?utf-8?B?OFlQSlNMWTFpcUk2N3RqUFFMZ0NqajZJaXJyN2tjSm9pTzJ2ZXpyZGFOYzJ0?=
 =?utf-8?B?eWRrVEhPL2dSSUY4bFNDQUM2NFdCOHM4dnZoRzRtei9JTHI5OGFtNUJRTDlv?=
 =?utf-8?B?dmRtN0RLeWNBVUZ0Z3BwRzJWTllBcTExV2tzNllEUTNsb1ZSODY0WmdiWldR?=
 =?utf-8?B?VWJqczZHeVZmc0tEaWdmL2Y5VDZnRUpUWUU2clFuRzFMNWc1ajJnL3NEYWlw?=
 =?utf-8?B?TlhhbVRSRmVFZzFmc3JHZXJNOG5RRHFKRHEwekJWYjhTbHFhRWNXcWFxa2c5?=
 =?utf-8?B?OE1PUWx6NGU5MWx0MHRzUFo1WS84RXNqaytjOFkrQ0dHc2lvOU12Q3ZQbUkr?=
 =?utf-8?B?RktHYUJzajRudnliSmVqVGpxdFJPTlM2RHVkLzhmNEJaakRReFdWRDZGbGZH?=
 =?utf-8?B?d1JsM2pKYzUzTTcyWUVBREMrTkJybnJPelArcFd4SEJYek1URERXaGI4T3ow?=
 =?utf-8?B?R3IrZmhxbzV4cllGV0R2cDNMNTFyTGRGbmptZVVsQUdkeTlGcTZJbTlWcm5t?=
 =?utf-8?B?ZU00TmcxeW4wRHljZWhkL2d1ZjNMeVFUQTZhUlRPYjJGTkhhZ29MamJVZnEz?=
 =?utf-8?B?VXpDdHFBem1IZk1HaEY3WldCT3A2Um4rWU8vdmYvMVJYT1laVG9EcVk4YVJ1?=
 =?utf-8?B?akp5VFJ3alAxaE5PcW9DU2dLUXVZT2xQdWtZSWdPd2dWbkloR0dQWEJ0djEy?=
 =?utf-8?B?cHBndEhMenM5NFR1S3hJMEorVVhBUmxiSXVZNXZVclZyYVlnTVVxTzFQSlBw?=
 =?utf-8?B?ZjdQeWsvYnJyb0VQT1V1VXhRZjdEem5Nc3d5cjhXYTNyMkNkTmtSOXNiUXZK?=
 =?utf-8?B?UCtRbXBuT3I4UkZCeFp6QjNKZUlEeDdIeTB3clFBc3NJNW9EOCtDbDJOVG4y?=
 =?utf-8?B?QmlscGlVTU1qZHMyZnFPalZFeE04RGtTWUFnUGhrSkR4c21KY2M2Q3phUjdB?=
 =?utf-8?B?MTJQeGx0YVIrdEJsdDh3OEF6SWh5Tk1Nbkh2RzJRZ3dDSCthYmhaaGhLVy9j?=
 =?utf-8?B?ZHlyU1J2cG5jWHZXbDh2WEVFazJHTkorb0E5UUE0ckdDVUNVQStqY3lHRERi?=
 =?utf-8?B?NzVXNGVVWWJGNHZ4T1J3ZlpCdVlpVVFUV2VkdzNQdlZTdFl1K0NBYkU2MmFY?=
 =?utf-8?B?S3puUG1xQzkvak1CaFJCWHo3SVREZEViQVRiaGg4TTl2ZUZnT0Q4VjF6U2dS?=
 =?utf-8?B?ZllXQWlUdmJycHM1OE44engvNkdXb0dsc1F3bmR6ZmdiY2p4RjlOSk1HVTZn?=
 =?utf-8?B?bXp6akM0UittMTBobzVqTlhFWjV5NUdJWWJHRUZLU2cwOUZlaDRvSFBYVDJz?=
 =?utf-8?B?ZVFUakZML2FmYlJCbERiM1NVOFhWY3FmcVovbndNK1JoOGNqSXZXbHJjRGR1?=
 =?utf-8?B?YmhGbDJESXdBc2QxRkU1TlMzenFHL3NLc2JyM0R4a09LcGpCZkl1cnJLcCs5?=
 =?utf-8?B?ZDd0RnNCVWhIWEQwVlAxV2MwV3R2ZHRFckY0Zzk4SzVoY1FMQzF2b2Q3ZU5h?=
 =?utf-8?B?d1g0WTM1WDFFS09VYzBXbjVySHlzYTNraXV0WWtoejF2cHlKMzAwT0c3SzJi?=
 =?utf-8?B?emFoWlpTNnZOQmdNK1Y0azR2cFJhc21NbnFRUEJVM1BNaFk0ZFNFeUxJNENU?=
 =?utf-8?B?Q3VzL3B4OURCb0hXeDlNVXNuVmlIZlNLUmVJMnQvaTVGUFErbmxOM0VoR2Rt?=
 =?utf-8?B?QjVaN0FwSlZKV0pld3c0QWNTeGJPVDYzTUNxWDBMY2hpdjViRnZxRi9HeS9i?=
 =?utf-8?B?WmRzSXNVdEhaMEJKYmtOZkFYN0tSYWdxN2wwdSt6TTJSditUa0NhYUthVWg4?=
 =?utf-8?B?SytISmpQUE9lbEgvR3NXQ0QwYlhzUWwyQ0tpOGtFQUZvdENyWEFFZEtzS0Vh?=
 =?utf-8?B?RGFjT3VPbnZNdlVFQW40ckZ5RjR3d0hBOWcyV0RhbGNFb1FGbTFSUlpyRDNv?=
 =?utf-8?B?cXR0RDFmSnBXM0dwNlFmRUw2Y04rVXZBVGlUbEpSZDJVd2VVT3pWc0xoOTM3?=
 =?utf-8?Q?2jAifVpFeHb1u9ELuS4csI5aO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E1D2BADCFC4ED489E7E944AB93090AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2610.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe9d2cb-f7dc-4437-2c8b-08dd309617fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 10:12:16.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxTGCxYmvbo5VB4QPHLSfkvkVjOEJ0exnDE8Hue31IdbGsq7+vDsyrGXCbYKXAh+9rG8KPzYmfJSL5ODudN5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890

T24gU3VuLCAyMDI0LTExLTE3IGF0IDIxOjQ0ICswMzAwLCBGZWRvciBQY2hlbGtpbiB3cm90ZToN
Cj4gVGhlIHN5bWxpbmsgYm9keSAoLT50YXJnZXQpIHNob3VsZCBiZSBmcmVlZCBhdCB0aGUgc2Ft
ZSB0aW1lIGFzIHRoZSBpbm9kZQ0KPiBpdHNlbGYgcGVyIGNvbW1pdCA0ZmRjZmFiNWI1NTMgKCJq
ZmZzMjogZml4IHVzZS1hZnRlci1mcmVlIG9uIHN5bWxpbmsNCj4gdHJhdmVyc2FsIikuIEl0IGlz
IGEgZmlsZXN5c3RlbS1zcGVjaWZpYyBmaWVsZCBidXQgdGhlcmUgZXhpc3Qgc2V2ZXJhbA0KPiBl
cnJvciBwYXRocyBkdXJpbmcgZ2VuZXJpYyBpbm9kZSBhbGxvY2F0aW9uIHdoZW4gLT5mcmVlX2lu
b2RlKCksIG5hbWVseQ0KPiBqZmZzMl9mcmVlX2lub2RlKCksIGlzIGNhbGxlZCB3aXRoIHN0aWxs
IHVuaW5pdGlhbGl6ZWQgcHJpdmF0ZSBpbmZvLg0KPiANCj4gVGhlIGNhbGx0cmFjZSBsb29rcyBs
aWtlOg0KPiAgYWxsb2NfaW5vZGUNCj4gICBpbm9kZV9pbml0X2Fsd2F5cyAvLyBmYWlscw0KPiAg
ICBpX2NhbGxiYWNrDQo+ICAgICBmcmVlX2lub2RlDQo+ICAgICBqZmZzMl9mcmVlX2lub2RlIC8v
IHRvdWNoZXMgdW5pbml0IC0+dGFyZ2V0IGZpZWxkDQo+IA0KPiBDb21taXQgYWY5YTg3MzBkZGI2
ICgiamZmczI6IEZpeCBwb3RlbnRpYWwgaWxsZWdhbCBhZGRyZXNzIGFjY2VzcyBpbg0KPiBqZmZz
Ml9mcmVlX2lub2RlIikgYXBwcm9hY2hlZCB0aGUgb2JzZXJ2ZWQgcHJvYmxlbSBidXQgZml4ZWQg
aXQgb25seQ0KPiBwYXJ0aWFsbHkuIE91ciBsb2NhbCBTeXprYWxsZXIgaW5zdGFuY2UgaXMgc3Rp
bGwgaGl0dGluZyB0aGVzZSBraW5kcyBvZg0KPiBmYWlsdXJlcy4NCj4gDQo+IFRoZSB0aGluZyBp
cyB0aGF0IGpmZnMyX2lfaW5pdF9vbmNlKCksIHdoZXJlIHRoZSBpbml0aWFsaXphdGlvbiBvZg0K
PiBmLT50YXJnZXQgaGFzIGJlZW4gbW92ZWQsIGlzIGNhbGxlZCBvbmNlIHBlciBzbGFiIGFsbG9j
YXRpb24gc28gaXQgd29uJ3QNCj4gYmUgY2FsbGVkIGZvciB0aGUgb2JqZWN0IHN0cnVjdHVyZSBw
b3NzaWJseSByZXRyaWV2ZWQgbGF0ZXIgZnJvbSB0aGUgc2xhYg0KPiBjYWNoZSBmb3IgcmV1c2Uu
DQo+IA0KPiBUaGUgcHJhY3RpY2UgZm9sbG93ZWQgYnkgbWFueSBvdGhlciBmaWxlc3lzdGVtcyBp
cyB0byBpbml0aWFsaXplDQo+IGZpbGVzeXN0ZW0tcHJpdmF0ZSBpbm9kZSBjb250ZW50cyBpbiB0
aGUgY29ycmVzcG9uZGluZyAtPmFsbG9jX2lub2RlKCkNCj4gY2FsbGJhY2tzLiBUaGlzIGFsc28g
YWxsb3dzIHRvIGRyb3AgaW5pdGlhbGl6YXRpb24gZnJvbSBqZmZzMl9pZ2V0KCkgYW5kDQo+IGpm
ZnMyX25ld19pbm9kZSgpIGFzIC0+YWxsb2NfaW5vZGUoKSBpcyBjYWxsZWQgaW4gdGhvc2UgcGxh
Y2VzLg0KPiANCj4gRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0
aW5nLm9yZykgd2l0aCBTeXprYWxsZXIuDQo+IA0KPiBGaXhlczogNGZkY2ZhYjViNTUzICgiamZm
czI6IGZpeCB1c2UtYWZ0ZXItZnJlZSBvbiBzeW1saW5rIHRyYXZlcnNhbCIpDQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEZlZG9yIFBjaGVsa2luIDxwY2hl
bGtpbkBpc3ByYXMucnU+DQo+IC0tLQ0KPiAgZnMvamZmczIvZnMuYyAgICB8IDIgLS0NCj4gIGZz
L2pmZnMyL3N1cGVyLmMgfCAzICsrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvamZmczIvZnMuYyBiL2Zz
L2pmZnMyL2ZzLmMNCj4gaW5kZXggZDE3NWNjY2I3YzU1Li44NWM0YjI3MzkxOGYgMTAwNjQ0DQo+
IC0tLSBhL2ZzL2pmZnMyL2ZzLmMNCj4gKysrIGIvZnMvamZmczIvZnMuYw0KPiBAQCAtMjcxLDcg
KzI3MSw2IEBAIHN0cnVjdCBpbm9kZSAqamZmczJfaWdldChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCB1bnNpZ25lZCBsb25nIGlubykNCj4gIAlmID0gSkZGUzJfSU5PREVfSU5GTyhpbm9kZSk7DQo+
ICAJYyA9IEpGRlMyX1NCX0lORk8oaW5vZGUtPmlfc2IpOw0KPiAgDQo+IC0JamZmczJfaW5pdF9p
bm9kZV9pbmZvKGYpOw0KPiAgCW11dGV4X2xvY2soJmYtPnNlbSk7DQo+ICANCj4gIAlyZXQgPSBq
ZmZzMl9kb19yZWFkX2lub2RlKGMsIGYsIGlub2RlLT5pX2lubywgJmxhdGVzdF9ub2RlKTsNCj4g
QEAgLTQzOSw3ICs0MzgsNiBAQCBzdHJ1Y3QgaW5vZGUgKmpmZnMyX25ld19pbm9kZSAoc3RydWN0
IGlub2RlICpkaXJfaSwgdW1vZGVfdCBtb2RlLCBzdHJ1Y3QgamZmczJfcg0KPiAgCQlyZXR1cm4g
RVJSX1BUUigtRU5PTUVNKTsNCj4gIA0KPiAgCWYgPSBKRkZTMl9JTk9ERV9JTkZPKGlub2RlKTsN
Cj4gLQlqZmZzMl9pbml0X2lub2RlX2luZm8oZik7DQo+ICAJbXV0ZXhfbG9jaygmZi0+c2VtKTsN
Cj4gIA0KPiAgCW1lbXNldChyaSwgMCwgc2l6ZW9mKCpyaSkpOw0KPiBkaWZmIC0tZ2l0IGEvZnMv
amZmczIvc3VwZXIuYyBiL2ZzL2pmZnMyL3N1cGVyLmMNCj4gaW5kZXggNDU0NWY4ODVjNDFlLi5i
NTZmZjYzMzU3ZjMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2pmZnMyL3N1cGVyLmMNCj4gKysrIGIvZnMv
amZmczIvc3VwZXIuYw0KPiBAQCAtNDIsNiArNDIsOCBAQCBzdGF0aWMgc3RydWN0IGlub2RlICpq
ZmZzMl9hbGxvY19pbm9kZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPiAgCWYgPSBhbGxvY19p
bm9kZV9zYihzYiwgamZmczJfaW5vZGVfY2FjaGVwLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIWYp
DQo+ICAJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJamZmczJfaW5pdF9pbm9kZV9pbmZvKGYpOw0K
PiAgCXJldHVybiAmZi0+dmZzX2lub2RlOw0KPiAgfQ0KPiAgDQo+IEBAIC01OCw3ICs2MCw2IEBA
IHN0YXRpYyB2b2lkIGpmZnMyX2lfaW5pdF9vbmNlKHZvaWQgKmZvbykNCj4gIAlzdHJ1Y3QgamZm
czJfaW5vZGVfaW5mbyAqZiA9IGZvbzsNCj4gIA0KPiAgCW11dGV4X2luaXQoJmYtPnNlbSk7DQo+
IC0JZi0+dGFyZ2V0ID0gTlVMTDsNCj4gIAlpbm9kZV9pbml0X29uY2UoJmYtPnZmc19pbm9kZSk7
DQo+ICB9DQo+ICANCg0KSGFzIHRoaXMgb25lIGJlZW4gbG9zdD8NCg0K

