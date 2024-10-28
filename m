Return-Path: <stable+bounces-88277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5ED9B2515
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4019B21445
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626418DF7D;
	Mon, 28 Oct 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nySnYZhy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="imgSjz0K"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E718A924
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095709; cv=fail; b=tv6Ovhe44ZftrpRGH7XJ10klLh1W5HmsYD7y3fXimJfJdjzK8poZZfthJqcFQcRbN5GjHSHzKbeoyHWNflWQ5aA+zHRk2W4GyvK6bnHJ/wzvdOspqCzvmBzSv38CfHpjyXh2s4U9rulj/SSm9UdBEJDFwkfcKQZqEQo2saL+0SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095709; c=relaxed/simple;
	bh=qGTSk2Q4ffHxfR5FZUVW1Kfb/E/JMgO2YXQWIHjlGh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hj+qy3gHnZXvvCQohPZLIBvJp+ymmVu6WhK/8jOZLaj0WoN88uqpkzX4fLsV/61KOLT8l5fVGBd6w9JnVK7eIWo19ps8eFGIIqB6cQXSrysiuHi21ny+RDaPITU1ODHbbLVWx7gz8j7W1lYs9pHul3JL8hl2YrnBK0I+vNFcOo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nySnYZhy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=imgSjz0K; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0871d74494f311efb88477ffae1fc7a5-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qGTSk2Q4ffHxfR5FZUVW1Kfb/E/JMgO2YXQWIHjlGh0=;
	b=nySnYZhydVo+s4CBfuckplNuu3iktLMOwZQ8snHaUbnFFjcAEWY3Mi0LNas3NuYbsenuZY9KTFSZDc71SEoQaup9Bzd/OhV+NGBQfFA2oTvysANT9N8uBFOxQ77fs2nrAEkoXKykG/P7yPpMexVZbZ3MsQtNywYAqrj487ZV1RQ=;
X-CID-CACHE: Type:Local,Time:202410281402+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:3b0b4279-203d-41b2-bce7-3dde1f8f4c98,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:10ed342e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0871d74494f311efb88477ffae1fc7a5-20241028
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 82583488; Mon, 28 Oct 2024 14:08:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 14:08:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 14:08:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTow4hcmRyKzkTMARlbC9gBI84RFMXsUxiln2SJq2GKCaISudMzt6b6sgK18Qk5/Cfp6ea0B1X4ByOj32SjokJgYmvdRrNRrzJvfZ8ynOVfeldvzcvcKJX71+uepCPy3xnrv7NsautINp8GtqLEQpKwuFAjnx43TRCF7N0Du5C8fGhX6qDCbl4D0LFX4Hfazdm7i3Qdwe9Rm8S8BfQeb61ANuqAzcMF+bv4oOE1XV4un7UV9CXGD+cSZUpHQbRyZefS2TPveIMBCSOSwb2JB25/tq42SP+dUzCj/OkOh/fUwEYKsi/JbjEPH5D8iBSUhh6cPm7xtNtzPnoRZ7AexVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGTSk2Q4ffHxfR5FZUVW1Kfb/E/JMgO2YXQWIHjlGh0=;
 b=kQTYriuu8H8T+NyDkcligZ3XdHotGRt0ZNCCJ23hKtIRZo3yoL5fM2zkdxULDDB2/vxynNHK8oviDCOjDE9NtbEjXG6HTc9k29iM/rypeasUkAZyeprREIkbcf8ZrixgDigrHHS7PzmBzx1NaLfucUNh32zJpvO/26Nd94IjpBjdCXaQPDtplSWyJCdohvi8aHTCQWh/TIpTh8amOrV0zWzDekYGRMoeBtVo605NnNnPYXXUwg8wZjam3h3ZCM3jE4Vc35EmwafRAW9969AFjZtkASn6cDE86vOGu5bbQoYmpIm2k2lJdWzBJcuw3982VMNhBUuXoaIZY7XlabzAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTSk2Q4ffHxfR5FZUVW1Kfb/E/JMgO2YXQWIHjlGh0=;
 b=imgSjz0Kxyen96kcc2AEAiHQrtB5CMv8IAbYcdup7F8W4N+9YNuJsXB/erv5A/drRwAAwNPQsLinzxFulsatr/8ZBogUgnlYDqxvTTVAUcYQ2YkYe+9KXefI8IUkRXk6y6UmJbTcTuroQTxDKptfjz2X1x7Eh9w8Ho6wAh+C04Y=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8636.apcprd03.prod.outlook.com (2603:1096:101:232::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 06:08:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 06:08:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJf/SXPr1B+Q5Zk+EOWAsF0zUX7KbqyAAgAAIbAA=
Date: Mon, 28 Oct 2024 06:08:15 +0000
Message-ID: <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
	 <2024102847-enrage-cavalier-77e2@gregkh>
In-Reply-To: <2024102847-enrage-cavalier-77e2@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8636:EE_
x-ms-office365-filtering-correlation-id: 4d1e7ee4-a832-4d4e-9a3b-08dcf716e93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDF0Zkxyc082VEVKTkg1Q3ZQdUI3TzREaHZua1JweW5MdXhtdkZwbHlNYXNs?=
 =?utf-8?B?YXgrQkt4Mk5OaEM0c3ZJY0ZVeDJvankxZG1aSG4zVU5heUdDTTJIaHpraElq?=
 =?utf-8?B?RTNNTmU1aTl2bGNPNzFEWTlOU1JJQUhnZVEwd2R5Q01hcGlBV0lqZVp1SnEx?=
 =?utf-8?B?QWE0dWNSY1lvZ0toQ2plSGtiRU1JZDN2RFZGcmtZbTlnaE51MGprZ2FkNmps?=
 =?utf-8?B?ajRHb2FQQkh6UHBIVmZtZHZycHZvZzFRM1BqMVBlajUreVFpa3daRWVGaUhR?=
 =?utf-8?B?Tm14YzBFZkxwS0xNL1Z3cFUwTGZVSmxTTVl0RlQ4NE4wemRoNFkzSC8xZTN5?=
 =?utf-8?B?bTgvclllYWtzNGhCUXk0SGdUQm0vL0RHU05tQUduN0FFRTRoMlEyRFhtWDdC?=
 =?utf-8?B?N1ZMTXFieFo4U3prSElwM3ZQOWIzQWNiL3ZHTGZuMXdHMkJpZ0puSmthRlFK?=
 =?utf-8?B?T2tlOEZ1eEhocGxNNnF3R2o2WW9KdUlVbmo3YVVkYXZmKzV0Y1BianRUTDJP?=
 =?utf-8?B?VGsva1h0NU5aUXpHQ216Zk9wcUE5Z2IxcEdkZnBDSmQ5MnRCbXIvRnB2VmVZ?=
 =?utf-8?B?dXVJaHAzOFY2MThNOFJ1ek13UHNIQlhWb0NxRVppRnYxWUYxSitKaHNSZXdw?=
 =?utf-8?B?bXh5RUQybmNlR3BFNXppUnJOUTlpQmd6T3ZvWk93Yy9ydVMyckpBRnRZVGo2?=
 =?utf-8?B?NW1tciswM05OODFpcGE4WWYyNFE5Lzk0VmljR3llcHdSczRXcGl2RzRYclJU?=
 =?utf-8?B?WGhGWmxEbEdXMk0zK2Zjay9UOFBwVkw4VUxUa0d5U05sbk5JWEo1bC95YnFi?=
 =?utf-8?B?S3ozYmdJb1Z3SWpmL3VWS2xwN3FBUm01T3BqUkkwcjcyU3g2TWhlclpScXAy?=
 =?utf-8?B?NHpTU2lRc0RiTG42Nk1obkE2cnI1NnhqQjRzT1JjNUlKejZuaDNWWEJsWFBY?=
 =?utf-8?B?SmJxSWo0YlJGTE90UEM4Y2NJVkhmNU9KNFhTOFNPV1l0ZzlUR3o1VXFEa0V3?=
 =?utf-8?B?TjVZTDR5bVZEZVdMNnR5bkgrRnJ0OURaVi9BTVNSN3BHUmZFYmlsRG9NT09N?=
 =?utf-8?B?YWpUdFR2UEVTdk1UWEhiT1N1ZlVoWU9NbnNtTncvZ0p6ZCtxSWdZZGEyaHli?=
 =?utf-8?B?M1FUT2toa1h6ektPNXBUOHk2VHJXMGFCYmFPTDZCSGxwZ3VlTTJKMVJBa2RL?=
 =?utf-8?B?OUpTanRMSUlmQzJYTUxneitYWXlSZXI4QUltMUNtVFJ4NGZVOW5MLzdnM29J?=
 =?utf-8?B?TmxVa1FXTUFyNXRVSGszSytqaEhyay9JcEkzTG5kUHI2TzJ0dmMrU3RmV2VO?=
 =?utf-8?B?U3BvZXhEVXZsWHF0QStTZ1BpSkZJenBqZVJ3Z1JGRzJXMlBYWmZNcUhvK0Rr?=
 =?utf-8?B?RGwzWVdZNzZqWWc4WFFDa0lUSmFqckM2MFNIN3ltL00rOER1ZjliSFZCR1RT?=
 =?utf-8?B?c0hPR1JEeEtpc0k5ZERiWDFLejlFSTJ2aW9qMW5DUE5FRWVVeTdndVg5TmUw?=
 =?utf-8?B?WW5xT0hWT3FIZU5mbzAzdlRaYzIwelB0ZmI3MzF4b2dReFVGU0pSb09YZ29q?=
 =?utf-8?B?UGgzYXZ4RWhZV3hOSjZYVzE5c2FXVmxmUWk1Q1RUU3FUS2xOeG5qZmFDN3R2?=
 =?utf-8?B?L0dIMnRXZkZpejNxbXdKOXdoM1FpbHdNME1VL1dmaEdLbkViZlAyT1crQXZN?=
 =?utf-8?B?L3ptWTJrNEhCazRrREQ3cS9XK2xvaE1uejRZVHVhZktwaFhNYlI2T0sxUTBU?=
 =?utf-8?B?eVdGU3RoMVcwY1BkdGM1eW45dW9ZZG9RN0RJaU83aDhZMnd6TFpJVTBrazhZ?=
 =?utf-8?B?WDlsU2xHb0Y0WTk4MU80SWhwV3M0VXZxSnpJYjNRdjQ5L3I1SGRXVXhycXBs?=
 =?utf-8?Q?tRtV21exhTRGl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THc0akI1OXBheEpUZ3ROb3BXNVQxNHc2eHI1cjA1MXV2ZXk5dDlrNHVlQ3dI?=
 =?utf-8?B?M0M2Ty9GK09ycHZTa3hkekp6OVBDWENubFljUWdOMnQza2xyZ2xpbVBxeGxM?=
 =?utf-8?B?YjBPMEcrU2VOV1Jaai82cGsvVi9CS0RYZkZIS0wwTUkvMGFZeEY0OUQwNHNP?=
 =?utf-8?B?QmV6S2RiR2tWd05RU3hnNGZuWXZJQWQ3NDNLTm5ITFY3SW9IdGRQd094RERC?=
 =?utf-8?B?SWFvTVFCdDU0dTVtSnphMnpjM0FQRmNTbWNJNFk4djNEa0dNUXorYy9MVjcy?=
 =?utf-8?B?YlByV1p0QlBPSlBYMndsR05qMG5namUzYTdTbWp3YlFkRTlKMTRORnRBOHFv?=
 =?utf-8?B?SU54UmJBM3dZNDJrUlBvcTdiNXZZNWVTWEtCekdvV2VMT25Pb05YUCs2Nmsz?=
 =?utf-8?B?eVlueWswR1FYdktraWFNNWRxOWh2cFhNcFRjaDIwYjhOWTJkaU5xUU10cjBB?=
 =?utf-8?B?S3EzSmJpeHk3aHNGeEVYdWYrcFJDQjRDdllzRWZ5Y25McjNBUzRTbWxtRnBO?=
 =?utf-8?B?R0pML1VOQ1dtNkdPMUZUTGMzYisrdTRjc1B5eXRwQVVVMy9IRmE3djNkS010?=
 =?utf-8?B?OUNnMWhEQ3k5Z3NXellUK3ZpcnRPSHM4NVU5WU5VcG82eXR2U2UwN1J3bUlj?=
 =?utf-8?B?MS9oV3JPVnRMbk9hcXNyY3NFMHhmNXBCOGpxbW4wUzhVMTdDM25iUGxrc0JP?=
 =?utf-8?B?MUhVVDZYdjd6YlFwS0JWV3Mrb0x3NE5SLzhJU2kxbVNHdjdqS2hNdEc4TmZO?=
 =?utf-8?B?elNiM3l3R3FGd1BGVm10SEpDYmJ1Qyt2OGtKKzJkaFU5Y09jUC9YMGZWL1BH?=
 =?utf-8?B?YVlKaE1kYitPT2hNck5jSXBUclRTUVh1ZGFFUUVtSEhCU0gybFF6RnhvRXE2?=
 =?utf-8?B?SlNWOUlYaWRYSHBlSGJETGl6YlpETjBEbEhnMWp3NGhwQzkzT05xU3hyb0xN?=
 =?utf-8?B?enZqSVlhU0JTS0hpTWlqNGdwM25tUm9uem5ubDdsMUxYUFQ4T0theXppREkz?=
 =?utf-8?B?eU1TY0pvNjBSYmJ4TExQV1cwSFNXczNtRWx3SUJkZHhzOTVjTmdDSXdNTGkv?=
 =?utf-8?B?UDJxejlCOVZkbWZvT0ZQdzhIRXV0ODROUmlXL2taN2U3d3RLYno1bzYwNTUw?=
 =?utf-8?B?U3pkTmp2ZmJUczVlZjRVVW5pU1EvL3lOOEZBSHVNYjBSOGdGUkVCT29kdGFt?=
 =?utf-8?B?WGRidzRTUGQwUm1tbFoxbk9FdGhJb25HRkQxL25MRDVEM2ZpQnI5Q3pXb0Mx?=
 =?utf-8?B?cUtsZEJQYUV4VUlYT25QRmx3VGk4WnpDOWxBcHhlaDh4dXZLNDgwOXJFKzlj?=
 =?utf-8?B?NVZYTjFRcHBUODR0OXJhWXd1SnA1NDBkRjEyOHlFbUVWYVVNNjNKdW9RWlkw?=
 =?utf-8?B?b0VES3NNVmdtYWlsZy8wcW9OcnVhZzVZSHRKd1QrK3ZiTFU0TFhjVEdmREZR?=
 =?utf-8?B?ajhrTU0wb2dibTI3dEt0dnZQdGNpYTVsb3dlRXBhdjFySm5kbzAxUTJrbUdv?=
 =?utf-8?B?N080bjdma2U0aExUUitVT3lCT2F2TmpVOFVSU2NkSmhxY1g5V2N4VDRXTzFB?=
 =?utf-8?B?R3lKRGU1MTB4UUpKUk82ZFpzd05mQUptOEhwRzgvL3NlMy83QUV0SHJvTnV0?=
 =?utf-8?B?R2J6RWtOYXRBMkRjbzVJV0NrSzhxSTN0ZXJ1cks1a05QY0tVMitjSzI4MkIx?=
 =?utf-8?B?NVZldTF4dWhSYWJXQjVNRkM3TTlDdHhPdHlRU0lTMms1c2xna0J3N3IraWtY?=
 =?utf-8?B?RGF0am5ZZnJ6VGVldGJuL3Q2Ryt4eHVDZGI4a0puUzhaeEVwd09UZHprNnhP?=
 =?utf-8?B?VmVKTFR6dUlVQ2RINEttNERUTGs5eU1sSUpLeDhRbUtMRmhyeEw2RFV0dVEw?=
 =?utf-8?B?T2hucmRIYlg4dkRMZ0JMSysyUU54Z2RJMi9pbkNwcHZJU0VuRVRWNDltQThN?=
 =?utf-8?B?RC9ra2dYRytXMy9TN2pZT0svWUlkUTFEeWNBUWFONXQyOG04WHpvWk50QkhJ?=
 =?utf-8?B?Q0ZmalhOSVVWZVR0Mk10NFRtM3YrRnh5TlIwUTcxT3l0MHlUcGN2WUNDOHFN?=
 =?utf-8?B?L3RmSnRIdFMrTTB3bS9HbFY0L0s4VVMyTUEzVzM0OUtDU3dtcERNVlU1NHVo?=
 =?utf-8?B?L21yQjhrM1lxeUw1amRhNjR2a3U3QTlDdjloUUJMOUVZTU5MdnkyMzQ5Ky9X?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF671375B846C749A8B4924B7446356F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1e7ee4-a832-4d4e-9a3b-08dcf716e93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:08:15.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FiLIzwFJTNHapE+az1D76496ZwK6ZUPvLI1x1ULoxY9ELUdnBt5EfCk+uK9HxmcHObShjt6GSsVQiK3VnwAa48TVQ8eQjIjyeSXNyqWVg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8636

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDA2OjM4ICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDA2OjMwOjAxUE0gKzA4MDAsIEphc29u
LUpILkxpbiB2aWEgQjQgUmVsYXkNCj4gd3JvdGU6DQo+ID4gRnJvbTogIkphc29uLUpILkxpbiIg
PGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVGhpcyByZXZlcnRzIGNvbW1p
dCBhYzg4YTFmNDFmOTM0OTlkZjZmNTBmZDE4ZWE4MzVlNmZmNGYzMjAwLg0KPiA+IA0KPiA+IFJl
YXNvbiBmb3IgcmV2ZXJ0Og0KPiA+IDEuIFRoZSBjb21taXQgWzFdIGRvZXMgbm90IGxhbmQgb24g
bGludXgtNS4xNSwgc28gdGhpcyBwYXRjaCBkb2VzDQo+ID4gbm90DQo+ID4gZml4IGFueXRoaW5n
Lg0KPiA+IA0KPiA+IDIuIFNpbmNlIHRoZSBmd19kZXZpY2UgaW1wcm92ZW1lbnRzIHNlcmllcyBb
Ml0gZG9lcyBub3QgbGFuZCBvbg0KPiA+IGxpbnV4LTUuMTUsIHVzaW5nIGRldmljZV9zZXRfZndu
b2RlKCkgY2F1c2VzIHRoZSBwYW5lbCB0byBmbGFzaA0KPiA+IGR1cmluZw0KPiA+IGJvb3R1cC4N
Cj4gPiANCj4gPiBJbmNvcnJlY3QgbGluayBtYW5hZ2VtZW50IG1heSBsZWFkIHRvIGluY29ycmVj
dCBkZXZpY2UNCj4gPiBpbml0aWFsaXphdGlvbiwNCj4gPiBhZmZlY3RpbmcgZmlybXdhcmUgbm9k
ZSBsaW5rcyBhbmQgY29uc3VtZXIgcmVsYXRpb25zaGlwcy4NCj4gPiBUaGUgZndub2RlIHNldHRp
bmcgb2YgcGFuZWwgdG8gdGhlIERTSSBkZXZpY2Ugd291bGQgY2F1c2UgYSBEU0kNCj4gPiBpbml0
aWFsaXphdGlvbiBlcnJvciB3aXRob3V0IHNlcmllc1syXSwgc28gdGhpcyBwYXRjaCB3YXMgcmV2
ZXJ0ZWQNCj4gPiB0bw0KPiA+IGF2b2lkIHVzaW5nIHRoZSBpbmNvbXBsZXRlIGZ3X2Rldmxpbmsg
ZnVuY3Rpb25hbGl0eS4NCj4gPiANCj4gPiBbMV0gY29tbWl0IDNmYjE2ODY2YjUxZCAoImRyaXZl
ciBjb3JlOiBmd19kZXZsaW5rOiBNYWtlIGN5Y2xlDQo+ID4gZGV0ZWN0aW9uIG1vcmUgcm9idXN0
IikNCj4gPiBbMl0gTGluazogDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMw
MjA3MDE0MjA3LjE2Nzg3MTUtMS1zYXJhdmFuYWtAZ29vZ2xlLmNvbQ0KPiA+IA0KPiA+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xNS4xNjkNCj4gDQo+IFdoYXQgYWJvdXQgNS4xMC55
IGFuZCA1LjQueSBhcyB3ZWxsPyAgQXJlbid0IHRob3NlIGFsc28gYWZmZWN0ZWQ/DQoNCk9oLCBZ
ZXMuDQoNCkknbGwgc2VuZCB2MyBmb3IgdGhlc2UgdmVyc2lvbnMgYXMgd2VsbC4NCg0KQlRXLCBo
b3cgY2FuIEkga25vdyB3aGF0IG90aGVyIGJyYW5jaGVzIHNob3VsZCBJIHJldmVydCB0aGUgcGF0
Y2ggYXMNCndlbGw/IEp1c3QgaW4gY2FzZSBJIG1pc3NlZCBpdCBpbiBhbm90aGVyIGJyYW5jaC4N
Cg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGst
aA0K

