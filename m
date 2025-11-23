Return-Path: <stable+bounces-196618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BBC7DF56
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 11:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DCBC4E2314
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CF2D23A8;
	Sun, 23 Nov 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m5bAjofb"
X-Original-To: stable@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC284315A
	for <stable@vger.kernel.org>; Sun, 23 Nov 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763892522; cv=fail; b=VvhuVsTnLApOewSfW6NzAgOyGSzPvwOBMqbzXVZD4cw5K5eX8KX1wHUcvxDs9BOmjtlHnjWT/S0O3kY43a+9SPOOSGGuwqZPw4szwu3NsQzme+IEOjae3kyKmhyq0xItzcsWP+AKdcCssYz+a2yYS+1MClNA3hes1zSZd2RHPE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763892522; c=relaxed/simple;
	bh=9ZIvmdimYGZjw2kspJ8Oj1SrR2Q7C9Q9W/iEKN6fQ1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFE4RDy6sLEbB9RNO05AxCrDrWa9jjY1GbNituhfmgGFc1fFSL9nME8zpmKjLfIV46ZvPvMpkjHDVwHAsWBryBvC+yfqMl0tS3ahezGHeZbRzcv888f+ZGMBMPE/OdLRAW9xVErA5vpzw751EXLtAZfJeCjf64t/tt3SNz1OZsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m5bAjofb; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AN9u2X5012959;
	Sun, 23 Nov 2025 10:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=9ZIvmdi
	mYGZjw2kspJ8Oj1SrR2Q7C9Q9W/iEKN6fQ1g=; b=m5bAjofb7PR9TZ1xEf8Qn6k
	gXa492FE5i7SZzIpqbPk/ulsun/UhGAUj4uG4bp4I3a2SodFeNsp1Y4rs+alsO9b
	KwjzSgicc/Z6WjqxP9/Ec/ZmJzntfAHFfeacXQq9EYBZu3z/tSbU3uo1v0iM1e/v
	ghD3cWiyhA+tpZEDZnFpRafOtTvnoJqeahG/wR9nFsWoWxRnbeW5bZHDw8L2GVml
	+18yQBPAmRLJFGrSQT8jLoQXWo8nkZ3/1NnGqscLi6uoYJszTy59Mu6DyG62oPa4
	rmn7JHpIV/BsriGJ95s02y489t9FrI7gWdzZ0aNUEy3RKfPL6S55S+t2Sw48CAw=
	=
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazon11010057.outbound.protection.outlook.com [52.101.228.57])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ak41y19hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Nov 2025 10:08:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8JFT+oXuBGA0wZs3rLBTr0SJXpFyK+FyCujEwoO5Hh7lM9fhFWjzfVUI9hvF1kGNu1QNKxXAOhTFeAV+MYqlaqlW/KvUa9jfhS/4R8UBJD96KpXbC2QIceZKW12S5g3JYWAg5Vlw+YHpO1miI/JK1y+ssgJ0tNza8ShDv+4cHXAS/VS56ML7LVBagdlISSl1MrbE8gBvmde1SBdjypWMj68f7cv69w4E40LB9k6TKywrfHcblTsky6iHedMj7LLrop5FzqTCsG3FrmVdL/vmQV6PS6JJUaBjFCT6/qjMIueiRnQSdYKc7mjQ+BnomnVG49oNDeOLeQhzQeMU9WBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZIvmdimYGZjw2kspJ8Oj1SrR2Q7C9Q9W/iEKN6fQ1g=;
 b=quLmimyH1DIMlfJLOFNzDRKDyEKLlPrQe2hByFuqLqt4856IN994DR7Oa9VUKKfP9RWUI+mzOEffM23W1gOs62LKgjIR3zO2xQoegOMdLyv4G/2MGEFmd0YLEK7oEK78Pxfm8ERnclEUe9VKvbBOtlANkAGHxhKIuRSiYcW6XNdyKI/ZhKnOh9UjRaKhfG4sPGH6YE2Al7mPn1h0kFOXmr8MU8okoRI1kd4m5sTl399QLZs+kihu+uE7BAKVCqHsro/1y05cjGuqDxmKy5ySYKmKSaWKdHnzxvDaRCVB6RLwf5wiM9z81w2VAn78+7mCc7OF2YbRJ5eCViz6inxqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY7PR01MB15038.jpnprd01.prod.outlook.com
 (2603:1096:405:244::14) by OSCPR01MB14384.jpnprd01.prod.outlook.com
 (2603:1096:604:39e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.7; Sun, 23 Nov
 2025 10:08:16 +0000
Received: from TY7PR01MB15038.jpnprd01.prod.outlook.com
 ([fe80::5a7d:6901:2c39:b38c]) by TY7PR01MB15038.jpnprd01.prod.outlook.com
 ([fe80::5a7d:6901:2c39:b38c%4]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 10:08:16 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Sean Christopherson <seanjc@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Xiaoyao Li
	<xiaoyao.li@intel.com>
Subject: RE: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT
 violation
Thread-Topic: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT
 violation
Thread-Index: AQHcWqoTJzQq1iv7fE2Sl/xlUXE8ULT9byIAgAKQGpA=
Date: Sun, 23 Nov 2025 10:08:15 +0000
Message-ID:
 <TY7PR01MB1503836F91731DC7C6D4A3E12F6D3A@TY7PR01MB15038.jpnprd01.prod.outlook.com>
References: <20251121055209.66918-1-Sukrit.Bhatnagar@sony.com>
 <aSCrRoe3fcBgLo8W@google.com>
In-Reply-To: <aSCrRoe3fcBgLo8W@google.com>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB15038:EE_|OSCPR01MB14384:EE_
x-ms-office365-filtering-correlation-id: 3a7efd55-c6d5-438b-2d87-08de2a783830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkJHam5ab0V6WGRLVFVzNWxJMU1xZ1JSdENUa3o5dmdWWnBHcldTUHVzbWpS?=
 =?utf-8?B?dWcxcjhWYStIYTNMdXhWV09SMGlmMDNTRW51bzRvNHd5azVHSU9aVFpCN3Ja?=
 =?utf-8?B?SkdYTUNJKy9zVytEQVNvN0pYN0tuc3pOS1M4SEdPYkpPNktkTVZ4amNYMHVG?=
 =?utf-8?B?VllnQnFsa0J4TGlHOUFZSkUyT1F4QlhoeGJackV3ZXRlczR2V3p4Ym1TSWpD?=
 =?utf-8?B?ZTg4Y2llVTdvUUpBVFZBOFZ0akM0djgvRCs0WHhXcy9hc0FwTU9CK3Z5dW1U?=
 =?utf-8?B?UG1Ud01XUndtWTQ2eDJuN3BDSmhQSUxTM0ZITFA3V0NvL1NkOUdMMU9uTGJt?=
 =?utf-8?B?Um9icE53SGFyS2h2ZTJtUklOd0pNQmFtVlRXVDgrc2d2dm1aMUVSOER4QWpK?=
 =?utf-8?B?TWY5enFVRkp6ZW1RdDZvUUF0aXJRSzRHSlphcUlQWU9qdG5LaEVPbUdyRlRG?=
 =?utf-8?B?QzVsTWVVMlVUWlVPdUVTRFY4cjQxZFdUYlRkdkxHSXRia2VTMHdLSzZiUkY4?=
 =?utf-8?B?ckFlNlhOYk9FNUxvdk1VZmkrMllvcHhLZ2pvR2FBRjE5VTIwR20vc0hlcGN1?=
 =?utf-8?B?S1pzRHJuOXYrVjRDOHYwSzVpS2Izd0llT1hZUkNPOXNpRmoxNE1DRGdzd1hi?=
 =?utf-8?B?M1hTTGRQM3JkQ05tVVBhaHkyRnRMOEthNUNZWjIxcHFPQ3hSTkE1TWZUMWFR?=
 =?utf-8?B?dDhwVTMyK29kNFUvL25oRmxZd2JxN2grZGg4ZitPSnNlQ1pmMVdTR21JVS9i?=
 =?utf-8?B?ZXNuQ1pNQXlpRkFZSWtuR0J0LzJMUGM0V25rcUJKdG42cGVMVnVkalAxd2FY?=
 =?utf-8?B?ai9jWVlyb2Y4MUcrNlM1Sk9sazJxRlIzOVN6MjljSkdIK1NoL2xzblNGYk5M?=
 =?utf-8?B?N3ZvN21lNVRsa01rNWJDOWRvWTdhK08rU0RLNGNkenVMNW53ZklqdXBJN3FM?=
 =?utf-8?B?N2Z6YlVtMExsR2xqTGNtMnRBN0NmQWN0Vkt2TG1FaEFNaU5DcFBqWFJ3dWVQ?=
 =?utf-8?B?cWtqdWdmN2FXbU9DNllsalhwdDNwYitIN2kvZklFdGZLWTFJaDlyRWFMQnpt?=
 =?utf-8?B?VThCejFicXlUcllGYnAzdnh6QUhDT1N1ck00RDMzK0IxTEptd2hkb05RY1lR?=
 =?utf-8?B?emR2MmJIWTRiY1ZCdDJiem8xenkrMVozQTFUWm5CbmpuZDFUTUY4RnQwaHA5?=
 =?utf-8?B?RDZiYkd1ZXpJV0krMEI0ZkpaQUpoUnNmRThmZVRTL01zY0kwVkUxdDdtQUNX?=
 =?utf-8?B?SXZFcExUY2EvS05Gck8vTllMZm4ycHIxd0RvdWtXV2xyUEYyUExzcHpHZ2ps?=
 =?utf-8?B?YmRsNitWb2ZVMVE1dER3L1RPUTIrNmg3MWJ5VVlHdFZaSUxTNmoveTh6aXlp?=
 =?utf-8?B?TUpMNzhDVVcxL2FsS2ZYZDZ0dWdmZEdZZkpqdk5SQk40UkhoZVB4eWpROXdh?=
 =?utf-8?B?Rjg5WXVLTnJuWURSVGN5R0NNQ3hoM1pPY1kvU3drbkpNWUlXa3JHMkJjSnBB?=
 =?utf-8?B?aE9rM0k1MjY0MHN1eUNhalNRM0hOSEsvTkRobVRrNC9zT3ZBWWZ6citscDFR?=
 =?utf-8?B?djhqWmE4ZW03QXRsbEZMOWd4b0dYMDJEd1M5RnJpclhVbkxQU2ZzTEQyUTQ0?=
 =?utf-8?B?Ujc1MHgrTEJSNUJqb0VEUGM2S3IrTk5uSHRCcFp6YmhxcytsL0NnNVpvNkVQ?=
 =?utf-8?B?NEFnRElmeUR6V0FXYlhQTEZwc1RGMkhsMlNFL2V0QXR6M3ZzeHgvUTRVRDlN?=
 =?utf-8?B?dThBZitJNTJpdkJIZmFHb3hpME9aaG9Ya3JFeHpyNVp5N1Y3TXVDMEJDS0lG?=
 =?utf-8?B?T0JFaTFYYzkrTnVteGV6SzVJR2xiYW05UVp1WmVGVzZCT0lWN2k1YXpkU0hu?=
 =?utf-8?B?cTNPQmdLSjErU25VS3ZCSEJjZC9mWkFWMC9QWWsyYTc4R3g5N01ZZmNqdXRX?=
 =?utf-8?B?QnJUd3YzYTl0UFYrVWVwWlJOSXN0TFZQOVhWbTRuV0ROa2MrYmdoQXlGeEZu?=
 =?utf-8?B?K0JlSTFkNGxMSHJ0R3VLQTQyNEhFY2JSdHZOWWVMYjFIT25OMU5nbHNISzhy?=
 =?utf-8?Q?Unf6z/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB15038.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGprSzBUakM0WVhmVm1YRy9EK2pPUnNTMzhkaVIyMiswYUdrQk1ydGNSNC9v?=
 =?utf-8?B?dUlzVFVrK2ZBbWZGUTFRZ1A5blQ1VmNwQjlaMTJnZllQMU9vSnd4OUpxYTdV?=
 =?utf-8?B?OS9ocGtkY3l2SkVqSjE1OUswYm5yeEVWbDZ2Tit2VFZWbmo3UU5ZOEtycVBi?=
 =?utf-8?B?NTlNNzNkclVMUE9hQnowam1vZXREUXlaSGN3K1Vvc21ON2ZvTDYxTFJMNVg1?=
 =?utf-8?B?NTVxMTBmVWQrRWw4Ly9DWVNWM2d3T2d0d25iY0R3Z21rVDU4YVlIYmJqZEZ6?=
 =?utf-8?B?eDdPdk9Pb0RHRjNTQzRlaWVzTW01RUlDRnp2ZytwMHVwR2lZWUkvL1JKZFkx?=
 =?utf-8?B?TUNJNmVtb2s3Sys2cVljTXNvcW5KM05hSmJFak9qaUlHWEpTWER6ZDYvc29m?=
 =?utf-8?B?UVdqaENHbEVxTU5xV1lMWE1VVlo0SUxkTkl1ODRtZW1PNi9QUzZTZ0l0UHI2?=
 =?utf-8?B?alBRYjk2Q1ArYzV4QXM3QTNOdHVNaXMyOGQvY215RnB5ZWMyaHI1NmNwUkZL?=
 =?utf-8?B?VGRRQWkwSEg4cHZILzc4dm5GYUpZNU1TdjFSTVg2cTJndXNUOUx5bmxxaHl1?=
 =?utf-8?B?YTJvQThHTUNkMGxmaTdJTDdFRkRGSE5aWEVRaEZzcTVFUVJla0IzV2pLNVFR?=
 =?utf-8?B?VDVsRnNobEluZ001SDc0OVVXSEM1dU9zaDkza29TQ1Q1UmcxSi80R2VSeGlS?=
 =?utf-8?B?Nk9IRDdMd0Q1K3ZHV3dRTTRoSE0za0oxYTJlYkVBcDJtQVBmTTEyeTVyVnd0?=
 =?utf-8?B?bk94SGMvYStXcVNaQjFibHBOQU4zcVZWS2pyTllQSThRN2FTQi9FRmF2cUEy?=
 =?utf-8?B?STNtUFRPRXlBQmNtbytYemdNZGN0Tk5BNndUT1h0SHVMNnUyME1QOUJoT3RX?=
 =?utf-8?B?WTlDbm56SDkyRlZiWUQrTDB3M0t0Zm9rR3FxQTl6NHB5RWJlQmo4STN3cXQ5?=
 =?utf-8?B?Y2xWOXJxbGFjRjkzRjMrWThSSmZPY0tLUndRVmlrMVNjSzhZYyt0UmZuSlhN?=
 =?utf-8?B?bi9obHk2VjBpZWZHb3dkcktwcDAyS1N1aTVMN284ME9sUlpMYmRoM1g3M0Y2?=
 =?utf-8?B?S2ZjL0hpbEtNdzB3QmV5dGF0STdBS1NhQjhLdFVCUnNNaEtEeHkzK0hzNGdM?=
 =?utf-8?B?TFRiaUtLaTc3cGJXbTlFM0N1REVhd0puT2dOWnY4UEF1c1VZK2lOMGRNZlJC?=
 =?utf-8?B?NkVYVWxaaDhnTUM3SlNwcHlvenI3dHpjVTBJNlU5NG52SmJ3cWVlSXRuVGhp?=
 =?utf-8?B?d28rRWdoanFsL0pIYjdNcys2bk1CdndFQ0g4YUNMUXNpYk5wR01KbTFsL3l0?=
 =?utf-8?B?N2E1OEhSdDI1a2NWTUJ2VVAvSFFoTlRtbDNTZ1FFM3JCWTlFWGZWZlJjNWFq?=
 =?utf-8?B?Wk1yakVJTXVuOWlUZkRzQTdnWjR6QnkwY3JnQ3VUMy9zclBrb3hpaTlvblFv?=
 =?utf-8?B?SkRmMzNxelpyR0lSNzZlWWVpMHRjN1JTaVgwUWFINnRFRlQyZk9mMmp4TWRm?=
 =?utf-8?B?YmpNUHp5VkhTenZUUExxZDJkd1pVNGJ3THBvaThBSDFtMGpTZW1PaVN5QkU0?=
 =?utf-8?B?S3VoWitybkRHOGppVFVWQi9zQnhZdThGQjNkSTF4MjJLZTlZR3Q1MlptZEpp?=
 =?utf-8?B?aHBwc3hqM1FUMkdRQzNSb0ducUphZm9JSHFQeEU3cUM1RzRzaDRUQWl3WXFL?=
 =?utf-8?B?clI1KzRHbStuQXcyTi8yYUhjMzc2VG44YW9LR0NwRVpJamJFeDJkU2JFYnBy?=
 =?utf-8?B?WldsRUxJai9wb0J6VklaeVRtRFZOUmtJVXNMRUFzNUN6YjBuNzBINzA0Q3Fo?=
 =?utf-8?B?Zjdod09VaG5ZakNrQXdWdnY0T3RscWxMVUZVaVBFckpkakc0OHlVL293bDlq?=
 =?utf-8?B?UkpRMGprUXJEUEpyN1VNSzdVZFIwL0xtbmk3dStWNU9DSlM1RUZMRUl6dkpS?=
 =?utf-8?B?QzVlUkV2aFczWXpiMm1RL2FhVDFtM1d5MW5mb1NlQmdzMXJ3ZGt5eUxCM040?=
 =?utf-8?B?cktIQWN0UmVNdWFJMndoSXk4M3ZGRDFLMVhERlozU3RSNmxhWHNWTTJZckd3?=
 =?utf-8?B?MkNpRnNJc29EMkNIaDZrRHZxbHJ2a3I0aFl1U3Q3QmdiQkc5K25YanU3czZ1?=
 =?utf-8?Q?TC44YXfxTVczp687iDAPTNEtK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/FLSCBczhBIkeHHqizgVVQIWzHLJrmZgnlg9ussg7UOV37/gxB94ZncIfsZi5DrapPp1W0rZ1zDXtHQ0YAPeqHyIuW4F0ANYsFuHurLgQYljuT0I+JQoe1ZCbHoz1CpNvUsjs8IzXXWe+v9DNKlpfYz9oDiylh1KTNyHNRyf/EJCZZ4L50XGWxUBhTcXXTrfF0MRn9z9eNNAD5C0uaPMBkutMcnxSf3knRAZQPWXOkjlGZpTA4FqXMXr5OnbAAVi5cduVUL2HbvJsZttQTWCtLP+DJOF9GO3wOq0tITUC6sRIfpLnRDqOKAsxxgz+kXs2S/4YJI/3GW3PXLWyOF4GivhPC5AzohWIaX1BSDBsFJljsOFffz7HsxY3fcMqVylZDZdgef55za/d2VVgHnAppH+44tnmmCIIVdgJNickzD2EEitpW23S+//uGsCdVrJzT4r2RTQW4DJXdoStiOpbKCjIQiA5zuRIS800ODyAU3CL5FsTGamawTI1HM/iqCPAqssf6mk/+MJk/rkO3YM8cGEU83xexPEYmhJYzHkz6XX1CY9DEF+pxncvzIYuKIwyZ6K8hFngO8VQZL3YJrRhSsNbUsZL8tMkWWcRp3JfoXMruGwBJT4SGJPmXE4uCuZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB15038.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7efd55-c6d5-438b-2d87-08de2a783830
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 10:08:16.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gD5jjjSi5qI1q7nrr4XsIR2P9PQ2vpqRCu4Rlc24h3Jy9zCg1eoyTVFrvAESF6+FR+apfjk9ORUx2syl/v1x908fUSxh9IC8piLvgsojc9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14384
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNCBTYWx0ZWRfX4CmQi6i7KsRG NJc0q7l+A9YfaMceJ0MQvKnHktdCs3HndkBPwcTGzB70tIkOOvrSq6K7mecFBXCwNPqRK262BE+ xSuvcn/+jiCGR9dEJAU63DEB6UXUKC6zoqmL2Z0WfSFu1GRysIKFks8ZVrhkx2x7NkOnAFDY3bM
 +QrHXWLU9I0H0hSemJNMfa0xXATRygSIYKJWIsARKN8u2Esh9jDRGWPUCYi3WWElyI6dMpOYUHB kZO6HFRMgK8qcK/6G2EhFN8GPJmCfETodZ3xqpuxldmhd47+UZWGT60032ZZx/85Ax231uNYLtk rxk8czceeWXCwDdry+JOid4K90UV2s3EAgLnFvNBBV4HpOq31nDIPTfxjuj0qBenHmjt8UMjsHs
 bBwTudt5MUg8UKlu73E3PxXMwCerNw==
X-Proofpoint-ORIG-GUID: fFPUlgYn78Rkux6CTf15mnsVIqRsJ426
X-Authority-Analysis: v=2.4 cv=dpbWylg4 c=1 sm=1 tr=0 ts=6922dd1a cx=c_pps a=wY02Ji+oW3AsbAv5xnuNcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=eDuFe-1hXp-CTEcXElgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fFPUlgYn78Rkux6CTf15mnsVIqRsJ426
X-Sony-Outbound-GUID: fFPUlgYn78Rkux6CTf15mnsVIqRsJ426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_03,2025-11-21_01,2025-10-01_01

T24gMjAyNS0xMS0yMiAwMzoxMSwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gDQo+IE5v
IG5lZWQgZm9yIHRoZSBtYW51YWwgImJhY2twb3J0IiwgY29tbWl0cyB0aGF0IGFyZSB0YWdnZWQg
Zm9yIHN0YWJsZUAgYXJlDQo+IGF1dG9taWNhbGx5IHB1bGxlZCBpbnRvIExUUyBrZXJuZWxzIHNv
IGxvbmcgYXMgdGhleSBhcHBseSBjbGVhbmx5IChhbmQgb2J2aW91c2x5DQo+IGRvbid0IGNhdXNl
IHByb2JsZW1zKS4NCsKgDQoNClRoaXMgY29tbWl0IGRpZCBub3QgYXBwbHkgY2xlYW5seSB0byB0
aGUgNi4xMi1zdGFibGUgdHJlZSwNCmFzIG5vdGlmaWVkIGVhcmxpZXIgYnkgR3JlZydzIG1haWwu
IDYuMTctc3RhYmxlIHNlZW1lZCB0bw0KaGF2ZSBubyBpc3N1ZXMuDQoNClRoZSBmdW5jdGlvbiBo
YW5kbGVfZXB0X3Zpb2xhdGlvbiBnb3Qgc29tZSBjaGFuZ2VzIGluIHY2LjE2DQogIGM4NTYzZDFi
Njk5OCAoIktWTTogVk1YOiBTcGxpdCBvdXQgZ3V0cyBvZiBFUFQgdmlvbGF0aW9uIHRvIGNvbW1v
bi9leHBvc2VkIGZ1bmN0aW9uIikNCndoaWNoIG1vdmVkIHRoZSBjb2RlIGZyb20gdm14L3ZteC5j
IHRvIHZteC9jb21tb24uaC4NClNvLCB2Ni4xNisgaXMgb2ssIGJ1dCBub3QgdGhlIGVhcmxpZXIg
b25lcy4NCg0KSSB0aGluayB0aGlzIG1hbnVhbCBiYWNrcG9ydCBjb21taXQgaXMgbmVlZGVkLg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgbm90IGNvcnJlY3QuDQoN
Ci0tDQpUaGFua3MNClN1a3JpdA0K

