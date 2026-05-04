Return-Path: <stable+bounces-242962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNsOJ+Zj+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:16:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB424BAD05
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 500DE3006831
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C4375ACF;
	Mon,  4 May 2026 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iUl7x7An";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Mjem5HtN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903B37649E;
	Mon,  4 May 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886178; cv=fail; b=T43LqdHWEu9cy7dzcHrkr3B+7XzxtJcNhwAfBN/umP7Me77jnsOZAQiixoLPy1Y5vxgU/428LCDP0IAOC5SRw+RJuSwjSKqCCMzWdnQiKyG4gQei7oIX2D/d1kPUwUUHO+XJrsbHLw2EfniX7g8iOTvUTorANX8nMyhzbeR0F1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886178; c=relaxed/simple;
	bh=KoNoHN9LY86tOrMHg77CgkzkhFxqoYgOSuTP4cSqPc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFWAZI+iYFwoMNaAIDXZ/GTTPvr9ivSAZ8NlITHhqT/vC3HIdK8umgki9UlcRAs8sq3bE1F96qFRKAhiiJqoEFmCZvBARncwnMY8jLXm3QDmlizBkB/I+0K+uHjMhRv759rP7yXFZWd+8h/ORlHD0eDBmBbWVmUmXYEeVN6VEUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=iUl7x7An; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Mjem5HtN; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6449EJsF3579825;
	Mon, 4 May 2026 02:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=KoNoHN9LY86tOrMHg77CgkzkhFxqoYgOSuTP4cSqPc0=; b=iUl7x7AnxLOV
	7o9WA/18IDdDfww3iYx8TURd94278rWwMf8uVPnSS2OKF7XxLGI/mKtotM1LoEEX
	+5H0AiHkjMr1Q/OiW+e+skktR3OGD1tL+osaCLxNV5jMH2oJ4+yJZjCrpA7zhmMM
	QLtb1HFtXGTnnBXWjdBFuHyq6qVDDIUBtVrBw6Gv5V637GmnRGR6TP0qigtWu/oj
	dYEqliE9HDowwPInCwdO38bluXFOamZEvbasSeiJN52ZqVC0XGvH4bXsU/BvZEO4
	9+ZEvGyswtXql7XQjBT2IU7xFA6mSSX/RhubM9F1LLu2aUu5YP5wLuRNt7C8bmGh
	+DaeXcTJ0w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4dwdtux36f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 02:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ4m2+jY9pgk29vcWd7QRHKEc3b+PUyxq89ILUGdky6VSKnE4WI7ECvyMjCFKEhSwretdy3g/BKLfjFqJFjDWbngPQHxzz79eeOGwKZZVT+7uIqDTdMRng6wnRHKgqMI1xfhi29MkjWtyzyMoPQJ4SIfoIze1TpzLdCE0TlaO9THzVjY7124knc9NfPk/hHJRwgkpT8htFj//ZxMMdii2l24A29stIklZiap3fTgxmgO85cOE+HRlMgFJhUZYd6OA3xq6HKJCwxlBFtYa8YScXNa+DHZaBEfdrko7DvKRGJlkpvPgJcnkMcXUt2M1osuoRR+xnHO6FxPlFMGk5DW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoNoHN9LY86tOrMHg77CgkzkhFxqoYgOSuTP4cSqPc0=;
 b=dbM4iaxIx3npYCmFzwPZzIE5ql/p0vUvuyVcKY0RhupjCRNFcmvUQPfRkP8FhNa7V4d6npBh8HDyOPssIIEAp+pYL6oQ18QzKyG/AASkpqeU5uageIMEqgH8crJHgcLjjz3tjcGi/ZX6VZ2dNITv9xZHiNcGBSV4oJ3nBeh3c3km7QM2CftWndkVs23jvro9gH0J4kFP+oD26O2IZ1z5+PfwAPbcZOzsJ70lbNAmSoaUqRIL9lAp5QdPejKGgGaTant+nQOb2WvqO09rNj68oMRNEO8lnrj/641I8Yo0vsTr2uXRASZLUd+sJTpd349InOyYqpmy/wQo2An+9m6KwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoNoHN9LY86tOrMHg77CgkzkhFxqoYgOSuTP4cSqPc0=;
 b=Mjem5HtNf1a8MxwpmEoJfbHFQOtvmAcFdRr5N7Y8VoKjPn8RZBOKZl1qdA1IMutTXsNv5abhFHdHfRXlLMOffzIMeqOAxEJ369J3lrxEh/dHTWS2UFO6kAU7NMKIKQ1ZEwjjkpo+RKpHvH3K02ANWuD2c6lWCNjfSY5RnMixf5t5V/btQYYCjuxWxhyM1zK5pR73zvZsHHy4pNJghVieScszvpWzQLnqINSEd9h0a4ypPtQbLuCReSh7Bv5b79SYwTi0sGTZlRgUVfid8xPLrmzEfEeBenjQKkE7vbHDt5Z9hzXhKLki9LpOjYDcfUJ/6baPkwdMgHOyBFyF9FQfBw==
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DM6PR07MB8158.namprd07.prod.outlook.com (2603:10b6:5:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:15:44 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:15:44 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Yongchao Wu <yongchao.wu@autochips.com>,
        "Peter Chen (CIX)"
	<peter.chen@kernel.org>
CC: "rogerq@kernel.org" <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE:
Thread-Index: AQHc26aV23m7vX/A30Sk3sCOrmYlQg==
Date: Mon, 4 May 2026 09:15:43 +0000
Message-ID:
 <PH7PR07MB95384829A877906E69145C76DD312@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
 <ae66WphA+lO6t3rE@nchen-desktop>
 <PH7PR07MB9538E83DB108635EAE7B21E3DD362@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ae/qXIT19Z2zWsDs@nchen-desktop>
 <e963d293-63cd-4124-9a53-8fc16e44ec72@autochips.com>
 <PH7PR07MB95388984DB7A5265770CEE58DD372@PH7PR07MB9538.namprd07.prod.outlook.com>
 <49e3cff9-9ace-4eed-aa2c-7f83825c44ee@autochips.com>
In-Reply-To: <49e3cff9-9ace-4eed-aa2c-7f83825c44ee@autochips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DM6PR07MB8158:EE_
x-ms-office365-filtering-correlation-id: ee7c9f3e-7e6c-40ac-3a14-08dea9bdb86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 HhHBXv+Inu2FBCKOV4RVePn4Lniz3s1MNZXD0SHEiDZi8HaBvzjMBKSa1Dz2QTAJ45ZQV7sRDJNz7R9qjRfAd6y1IvqIU0ysVgR25/riF2qYAN+KMH9mtUF866ZGqcXzpkDE8rA6OMtp7h4lNZ5KQXrZ84V0K3uJDyPbWI6c2KxEuvAyaDq4rGh/7x+BqjCtJ5n4dbcth12LUHRaMHRMcDOdKXzZoMk1/z+WGSBmVNVtNe7QztKzmSV/mRHlUPr9azT68pFgTiccz1ottYgzrcgl3WUlNyI3jqo/EeOaR0exknlDcwCS5FdMc9BPeT65JGP7SQf9rzDZva/fQLMrIfrU3BNLvt7Wt2HiFm407/YIdxjuEl6k3o05VKO5Imx/fwVCWBRpc78BhR0iSvwJMTyJVY/kqmwXwiWW0o5MqPLvKUMoZtavKwjAQ2+LMVvghKVzgjEwPru7NPrSewVGaijBrKFfexX3fFSW63GnoIUmhR8mYLOUGG46J9NmbGkTZ/8oXHZjbETtIzIs42Zt1zZu7OTSNIK+mn2bNi5YJIkmJfQvburVpGhwB2FviPKzH52ba3+TGSZcpj4Hf/KurjLC7W5dobX0FdESZgTUnps95W7tc06GP8uLUpeCHxAiR0Lmn1mdLHbK5j8JCzTweWtkENsGmiYiHOf5RsiE/iJzGOEhl2TrRzgqkKaxrFudlqQo1a1rFWbe00eLJge/llJGFLRoOotQrgoirs7/7FUAd2llwELRZJcoH1iE8XaY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk91cmNQVmhGK3FzNUhjeDdtMFp6OWlqdWw5NmQvWjh0MGNuMXVYUGVNa2Fn?=
 =?utf-8?B?NkQyUHhWUmQrelFiWmZSWWl5Q3B5bEZ1QUJPS2s3c09UbDRVbUlDQWRKNUhv?=
 =?utf-8?B?RmF1WFpmRGVKckZjbVg4aXBhNUdHaGcrUjZ1UHY1dTJ0NnE1UW1QU1Q3MWpw?=
 =?utf-8?B?cmpmT0RtTTB4ZW9rZHVBajRkdzFKWUVpM0ZybHA0alluVTNwK2krcGNncjVL?=
 =?utf-8?B?dnRUVFloL0s1ZWtZcFRydWRVczgwREtYMkY2dWJjNjkxNjhUMHFFSGJXai9x?=
 =?utf-8?B?NW1UYlJQOENZK21ubUY0STAvcTVZSFpaNjI2d2JYbWpiT3N1Wnc4RE5kYTNQ?=
 =?utf-8?B?QTF5WTl0Ymk4cjJDMkxpNi8rUkVpVjJQNWQ1MVR0Q3ptNDU1MEVKNGFaVU5O?=
 =?utf-8?B?dFRTR2YvMGZMMFBVbDhwWW1DamZQaTRZOUlxazd3SVFNNkY1SmJxaTVuU2V6?=
 =?utf-8?B?dndwWllvMjEzRW8zc1JXenUySVVFVi9lZjJONGlMaFprT2hZQWpSTHhpM3VV?=
 =?utf-8?B?TldWVTVHeU9YRktYQVAxQVBpNHZZK0RMVDFrMTlLbXQwclRsV1duQnMveFl4?=
 =?utf-8?B?YzluSjJ5OU9aU0VQcW04WmlITE5ub0pRQnI2VmtVSGZUYWswY1VZZkxOVE10?=
 =?utf-8?B?TitrdnlqTy9mUXFEZDNaTmNoaDRZT0wydm04OEYrZGhhLzNOYVFUa0ZONGQy?=
 =?utf-8?B?TDYxWjBTemJOcHBsZjZlcnRiUTArWU5DY1hTbE41MTVQWGdRaWlwRUdFVWFW?=
 =?utf-8?B?STNLazZQcVpXYm9iZE9FN0ZJYUplS09namluN0JxLy9HTlNGbEVsZXg0Z3pk?=
 =?utf-8?B?OWZOQ3p5Q2QyUlZKNVRnSG9oaEl1andiTkxTZUJkaytSbjVLMmkxSWdyL0dB?=
 =?utf-8?B?SFFldXNXTVZCT3o1WGZNSVhLeGVpcDllajJyalZWanV5Q0VweW5OWVI1NDJU?=
 =?utf-8?B?c3ovZm8rZHVIOHB5KzZoYVo2Y3Nwb3Y3YTlleEx2L2JaZ2V4NGo4RllBTzZW?=
 =?utf-8?B?d0VSRWxMeGpOelAwSkVYNUwyc01UTUtBYVR5VlFEczhxZnlKaFFxR0xYcFFL?=
 =?utf-8?B?R2R3TnFoVmxHVzl4bHNucnZ1cWNMZjdFV2hIdmtiQ1V5NmRVeFcwYkhmeHZS?=
 =?utf-8?B?YzNkSjBiWlhjK2sxU0JrSjlxQUYvM1lGWWN1WU04QnhFYTZsWWdHTmt2YXZv?=
 =?utf-8?B?SEE5QVFqdEhiOFNrbzZNa1pMZzlyUE9pQ09xMnYrWFNGRW1SZFJXeDl1b0Jm?=
 =?utf-8?B?Q05XUlFON0prSEVmVG1NT01nZnV0WDZpRnJXSDFPSXVPUEE1UEhUQTM4OHM1?=
 =?utf-8?B?UUZJT2Q3S0xZNzJHMGxucW1BTlQ0Vit1dlp5MjF3WTRmQXQzZ1VUSnYvVWNa?=
 =?utf-8?B?RnFWSGhNUjRVamUwWVFaVys4d1N3dE5HRVFnb2txc2tRUUlDVVQ5U0JmZWxn?=
 =?utf-8?B?cTF5L05zZ25HQ2xZaThhM1pXSG1EOFBUTWF4MlJUMHl1THdCK0JyK2k1dWVH?=
 =?utf-8?B?WllvSUhpeHZYaFl5cmpCekFEYW9KNDc4VWF1V0ZISldrdEtHOEhPOUxySVB6?=
 =?utf-8?B?eS9ibUZkZFRVRXJoTVd0SFlyTi9Ob2VSY1Q0ZG02MTJGNHg0ekxNYmpSSGRn?=
 =?utf-8?B?VjRoUDlLR09zS21naDNuVTFFalQzUGJINHpCNzhxUjZ2czJNSkVqVlBBUW9D?=
 =?utf-8?B?c0lZVzlUWUo3TmxyUHNtQnViMUk4bjEvdUl6bytGSzVrYml5Q25rcWZXNWJu?=
 =?utf-8?B?MWNzelJpbVh5a2ZzUDFPeUoxaXJyZmFPSmFWNlNwM0NYd2V2bVlTWEkvU2hm?=
 =?utf-8?B?eXZHRG9zTmU5aDZiL0RKNlc5MDRpNEdXcEhRWno1Z0hrVmtEUkJQYWlsMGk1?=
 =?utf-8?B?dFlkMjFsVStKMnFFZXh4VFZvVGIrRjVPaXZqZHlxWFZOQ0VNRE1ZM0gvTXZ5?=
 =?utf-8?B?WmtacGFhbGoxUS9oT0RvVFppWGFmNDgwTHM2MU0rY0lDQlJwMXZzTGdIeEZU?=
 =?utf-8?B?YzgzNjlvdmV6OW9NdGJJT1A1eHppL0lmV1NOS3lzSk9lWUlTOTZkdWVvM011?=
 =?utf-8?B?VXN0bWl4TVhJVC9rTXBIQ2FGb3oxbVlJeWhnNUJrMlUvbzBVZlZ0bjNQdGFM?=
 =?utf-8?B?UEJwSUNuc2VUMkVzUUwrR1BZNkhrcG1tQWdBbmx2MVZJUHJIMlJOWDY5Q2ZX?=
 =?utf-8?B?VG92QXRHQTFVWXN1WEtLbHNMTXlhSFZJOG91VTN3YjJvNVRGN2pvdWcyYVdy?=
 =?utf-8?B?YVdKMXhEMndkS0RNM2tHU1U2MmlxclZUeXdIOXFQeWZxTE43NGlqejBQdGtI?=
 =?utf-8?B?OUUzN3Bvd05uMm5QTitqRHZnbks1UmNYZityeVhWbDVZbGJqa1kvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	c8QsYAKWFrte69RIFOhXOWmI0jMGGyzEp7SKPpe6FfwBUVIn5SkwdbPPc5fRvWESfs0FY32070ny9Oweesvv65a4sLmoKH6ky6u5ukcGLNFFVS42CExUeQvNcgJBLBWUBERVx7PSDp1zaZVoKeIvrM+HIZQd2DySh0RlpsMK0e7j9eOUmyp4A4d1vLhERqQ+xkPtYs6tQCk7dEOS4U0js6KEhm3Il2whfdGHae0LrUXELlg256LPzNwSiWYctV5+T9y/jGnLxOG9MXfQL7BEhN841RKuNPVagoNfq1zq0Yhcgd+k4KG59PVPChzGvPW0TaBtmyLvZxLLDg8CU/d7pg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c9f3e-7e6c-40ac-3a14-08dea9bdb86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 09:15:44.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFGCAECiWqKtoR5Rws0bHbZJZ+r/lHOJqd6tUuk7a6RIvpmxqnk5CBkJd6IfvHnRs7gYHacCDiBwlIH70XxxZhL5AYOcMnCcyfFG+hAhPuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OCBTYWx0ZWRfX0jiDz20ndBSA
 PSi9NTo9xtuDTTudo48v33Qgj6cMFzKsaQoxsC0afaEtqAWOH73nGFZjpvd7Gursb7Y1PJgWJum
 KG3QarEiFo9CpZSBr49SXeMrMIt27cR7B0yw3bkAyOn8wdMwAc1Hd+cp/UM3hQ1UXuyjK+R55Nu
 1BrxGDlXZoZ0JObeB16rOxgO0s7vUaprBtwWTipyvppdn6jgYipbiIE0dG+L9d49U9TwnLKWF+/
 4t1n191d42ieuRBUANamY7EQwIbfhF1APc4tYrQ5baykqZAeP3I2/7jS176BsRlmWYFr56KX4p+
 kdOqTIgG/U4BIOa9xrN3dtbwhJQb/bCkn8CBNugc7/KohMPDStfuOu/3wsJ+V3NaWBb3xX6ZPyy
 0+sYBbnndqcCGepJNpWxQhstYQtNIXTfV/vmcsRwk2I7+nTAjlJL6Ga7dfP5U51vq3FiJqVXrtE
 l859o2yi8IQLpXRvTrQ==
X-Proofpoint-GUID: orTZoG9VJs5i25nyMZO3rifvbVrLE3MX
X-Authority-Analysis: v=2.4 cv=Ean4hvmC c=1 sm=1 tr=0 ts=69f863c4 cx=c_pps
 a=ImwGUT2bfrWU7DBu6bNfJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=vNqGFx5P-HxrNC8AP1QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: orTZoG9VJs5i25nyMZO3rifvbVrLE3MX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040098
X-Rspamd-Queue-Id: DBB424BAD05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cadence.com,reject];
	SUBJ_ALL_CAPS(0.23)[3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cadence.com:s=proofpoint,cadence.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242962-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH7PR07MB9538.namprd07.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[cadence.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawell@cadence.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Pj4NCj4+Pg0KPj4+IE9uIDI2LTA0LTI3IDA5OjAxOjQ3LCBQYXdlbCBMYXN6Y3phayB3cm90ZToN
Cj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24gMjYtMDQtMjQgMDA6MDY6MDEsIFlvbmdjaGFvIFd1IHdy
b3RlOg0KPj4+Pj4+IEFjY29yZGluZyB0byB0aGUgY2RuczMgZGF0YXNoZWV0LCB0aGUgRVBSU1Qg
KEVuZHBvaW50IFJlc2V0KQ0KPj4+Pj4+IGNvbW1hbmQgY2F1c2VzIHRoZSBETUEgZW5naW5lIHRv
IHJlcG9zaXRpb24gaXRzIGludGVybmFsIHBvaW50ZXINCj4+Pj4+PiB0byB0aGUgbmV4dCBUcmFu
c2ZlciBEZXNjcmlwdG9yIChURCkgaWYgaXQgd2FzIGFscmVhZHkgcHJvY2Vzc2luZyBvbmUuDQo+
Pj4+Pj4NCj4+Pj4+PiBUaGlzIGlzc3VlIGlzIGNvbnNpc3RlbnRseSBvYnNlcnZlZCBkdXJpbmcg
dGhlIEFEQiBpZGVudGlmaWNhdGlvbg0KPj4+Pj4+IHByb2Nlc3Mgb24gbWFjT1MgaG9zdHMsIHdo
ZXJlIHRoZSBob3N0IGlzc3VlcyBhIENsZWFyX0hhbHQuIEFsdGhvdWdoDQo+Pj4+Pj4gY29tbWl0
IDRiZjJkZDY1MTM1YSAoInVzYjogY2RuczM6IGdhZGdldDogdG9nZ2xlIGN5Y2xlIGJpdCBiZWZv
cmUNCj5yZXNldA0KPj4+Pj4+IHJlc2V0IGVuZHBvaW50IikgYXR0ZW1wdGVkIHRvIGF2b2lkIERN
QSBhZHZhbmNlIGJ5IHRvZ2dsaW5nIHRoZQ0KPj4+Pj4+IGN5Y2xlIGJpdCwgdHJhY2UgbG9ncyBz
aG93IHRoYXQgb24gY2VydGFpbiBob3N0cyBsaWtlIG1hY09TLCB0aGUNCj4+Pj4+PiBETUEgcG9p
bnRlcg0KPj4+Pj4+IChFUF9UUkFERFIpIHN0aWxsIHNoaWZ0cyBhZnRlciBFUFJTVDoNCj4+Pj4+
Pg0KPj4+Pj4+ICAgIGNkbnMzX2N0cmxfcmVxOiBDbGVhciBFbmRwb2ludCBGZWF0dXJlKEhhbHQg
ZXAxb3V0KQ0KPj4+Pj4+ICAgIGNkbnMzX2Rvb3JiZWxsX2VweDogZXAxb3V0LCBlcF90cmJhZGRy
IGY5YzA0MDMwICA8LSBTaG91bGQgYmUNCj5mOWMwNDAwMA0KPj4+Pj4+ICAgIGNkbnMzX2dhZGdl
dF9naXZlYmFjazogZXAxb3V0OiByZXE6IC4uLiBsZW5ndGg6IDE2Mzg0LzE2Mzg0DQo+Pj4+Pj4N
Cj4+Pj4+PiBBcyBzaG93biBhYm92ZSwgdGhlIERNQSBwb2ludGVyIGp1bXBlZCB0byBpbmRleCAz
IChvZmZzZXQgMHgzMCksDQo+Pj4+Pj4gY2F1c2luZyB0aGUgY29udHJvbGxlciB0byBza2lwIHRo
ZSBpbml0aWFsIFRSQnMgb2YgdGhlIHJlcXVlc3QuDQo+Pj4+Pj4gVGhpcyBsZWFkcyB0byBkYXRh
IG1pc2FsaWdubWVudCBhbmQgQURCIHByb3RvY29sIGhhbmdzIG9uIG1hY09TLg0KPj4+Pj4NCj4+
Pj4+IFBhd2VsLCBJcyBpdCBhIGhhcmR3YXJlIGlzc3VlPyBUaGUgY3ljbGUgYml0IGhhcyBhbHJl
YWR5IGJlZW4NCj4+Pj4+IHRvZ2dsZWQgYmVmb3JlIHRoZSBlbmRwb2ludCBoYXMgYmVlbiByZXNl
dCwgd2h5IHRoZSBETUEgcG9pbnRlciBzdGlsbA0KPmFkdmFuY2VzPw0KPj4+Pg0KPj4+PiBZb25n
Y2hhbywgY291bGQgeW91IGNvbmZpcm0gaWYgdGhlIFREIGNvbnNpc3RzIG9mIHRocmVlIFRSQnM/
DQo+Pj4gSW4gb3VyIGNhc2UsIGVhY2ggVEQgY29uc2lzdHMgb2YgNCBUUkJzLg0KPj4+IFRoZSBE
TUEgcG9pbnRlciBhcHBlYXJzIHRvIGFkdmFuY2Ugd2l0aGluIHRoZSBzYW1lIFREIGFmdGVyIEVQ
UlNULg0KPj4+DQo+Pj4gRWFjaCAxNktCIHJlcXVlc3QgaXMgc3BsaXQgaW50byA0IFRSQnMgKDRL
QiBlYWNoKToNCj4+PiAtIFRSQjAgLSBUUkIyOiBDSEFJTg0KPj4+IC0gVFJCMzogSU9DIChsYXN0
IFRSQiBvZiB0aGUgVEQpDQo+Pj4NCj4+PiBBZnRlciBlbnF1ZXVlLCB0aGUgaW5pdGlhbCBFUF9U
UkFERFIgcG9pbnRzIHRvIHRoZSBmaXJzdCBUUkI6DQo+Pj4gICAgRVBfVFJBRERSID0gMHhmOWMw
NDAwMCAoVFJCMCkNCj4+Pg0KPj4+IEFmdGVyIENsZWFyX0hhbHQgKEVQUlNUKSwgaXQgYmVjb21l
czoNCj4+PiAgICBFUF9UUkFERFIgPSAweGY5YzA0MDMwIChUUkIzKQ0KPj4+DQo+Pj4gU2luY2Ug
ZWFjaCBUUkIgaXMgMTIgYnl0ZXMsIHRoZSBvZmZzZXQgMHgzMCBjb3JyZXNwb25kcyB0byA0IFRS
QnMuDQo+Pj4gVGhpcyBpbmRpY2F0ZXMgdGhhdCBhZnRlciBFUFJTVCwgdGhlIERNQSBwb2ludGVy
IHNraXBwZWQgdGhlIGVudGlyZQ0KPj4+IGN1cnJlbnQgUmVxdWVzdCBhbmQganVtcGVkIGRpcmVj
dGx5IHRvIHRoZSBzdGFydCBvZiB0aGUgbmV4dCBSZXF1ZXN0DQo+Pj4gYXQgMHhmOWMwNDAzMA0K
Pj4+DQo+Pj4gQmVsb3cgaXMgdGhlIHJlbGV2YW50IHRyYWNlICh0cmltbWVkKToNCj4+Pg0KPj4+
IC8vIGVucXVldWUgcmVxdWVzdCAoMTZLQiAtPiA0IFRSQnMpDQo+Pj4gY2RuczNfcHJlcGFyZV90
cmI6IGRtYSBidWY6IDB4ZjdhYmMwMDAsIHNpemU6IDQwOTYsIGN0cmw6IDB4MDAyMDA0MTUNCj4+
PiBjZG5zM19wcmVwYXJlX3RyYjogZG1hIGJ1ZjogMHhmN2FiZDAwMCwgc2l6ZTogNDA5NiwgY3Ry
bDogMHgwMDAwMDQxNQ0KPj4+IGNkbnMzX3ByZXBhcmVfdHJiOiBkbWEgYnVmOiAweGY3YWJlMDAw
LCBzaXplOiA0MDk2LCBjdHJsOiAweDAwMDAwNDE1DQo+Pj4gY2RuczNfcHJlcGFyZV90cmI6IGRt
YSBidWY6IDB4ZjdhYmYwMDAsIHNpemU6IDQwOTYsIGN0cmw6IDB4MDAwMDA0MjUNCj4+Pg0KPj4+
IGNkbnMzX2Rvb3JiZWxsX2VweDogZXAxb3V0LCBlcF90cmJhZGRyIGY5YzA0MDAwDQo+Pj4NCj4+
PiAvLyBDbGVhcl9IYWx0DQo+Pj4gY2RuczNfY3RybF9yZXE6IENsZWFyIEVuZHBvaW50IEZlYXR1
cmUoSGFsdCBlcDFvdXQpDQo+Pj4gY2RuczNfZG9vcmJlbGxfZXB4OiBlcDFvdXQsIGVwX3RyYmFk
ZHIgZjljMDQwMzANCj4+Pg0KPj4NCj4+IENhbiB5b3UgY29uZmlybSB3aGV0aGVyIHRoZSBob3N0
IGhhZCBhbHJlYWR5IHNlbnQgc29tZSBkYXRhIGZvciB0aGlzDQo+PiBURCBwcmlvciB0byB0aGUg
ZW5kcG9pbnQgcmVzZXQgb3BlcmF0aW9uPw0KPj4NCj4NCj5JIGNvbmZpcm0gdGhhdCB0aGUgaG9z
dCBzZW50IG5vIGRhdGEgcHJpb3IgdG8gb3IgZHVyaW5nIHRoZSBFUFJTVCBvcGVyYXRpb24uDQoN
CkFjY29yZGluZyB0byB0aGUgc3BlY2lmaWNhdGlvbiwgdGhlIGNvbnRyb2xsZXIgbWF5IGZldGNo
IFRSQiBkZXNjcmlwdG9ycyBhZnRlcg0KdGhlIGVuZHBvaW50IGhhcyBiZWVuIGluaXRpYWxpemVk
Lg0KSW4gY29tcGxleCBUcmFuc2ZlciBEZXNjcmlwdG9ycyAoVERzKSBjb25zaXN0aW5nIG9mIHNl
dmVyYWwgVFJCcyB3aXRoIHRoZSBDSD0xDQpiaXQgc2V0LCB0aGUgY29udHJvbGxlciBtYXkgZmV0
Y2ggYWRkaXRpb25hbCBUUkJzIGJlY2F1c2UgaXQgdHJlYXRzIHRoZW0gYXMgYQ0Kc2luZ2xlIGxv
Z2ljYWwgZW50aXR5Lg0KDQpJIGhhdmUgbm90IGJlZW4gYWJsZSB0byBkZXRlcm1pbmUgZXhhY3Rs
eSBob3cgbWFueSBUUkJzIGNhbiBiZSBwcmVmZXRjaGVkDQppbiBzdWNoIGEgc2l0dWF0aW9uLiAN
Cg0KQWNjb3JkaW5nIHRvIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgRVBSU1QgYml0Og0KQWZ0ZXIg
ZW5kcG9pbnQgcmVzZXQgdGhlIHNvZnR3YXJlIGlzIHJlc3BvbnNpYmxlIGZvciBpdCB0byByZS1z
ZXQgdGhlIEVuZHBvaW50DQpUUkFERFIuDQoNClRoaXMgZml4IGxvb2tzIGNvcnJlY3QgdG8gbWUs
IA0KDQpDYW4geW91IGNvbmZpcm0gd2hpY2ggdmVyc2lvbiBvZiBjb250cm9sbGVyIGRvIHlvdSBo
YXZlIGluIHVzYl9jYXA2IHJlZ2lzdGVyPw0KDQpQYXdlbA0KDQo+DQo+VG90YWxQaGFzZSBUcmFj
ZToNCj4wLEhTLDI3MDAsMDowNi4wNzguNjcxLDIuMDU3LjY2NiBtcywwIEIsLDEzLDAwLFNldA0K
PkNvbmZpZ3VyYXRpb24sQ29uZmlndXJhdGlvbj0xDQo+MCxIUywyNzEwLDA6MDYuMDgwLjgxMSwx
LjEyNS4yNjYgbXMsLCwsLFsxMCBTT0ZdLFtGcmFtZXM6IDEyNDMuNyAtIDEyNDUuMF0NCj4wLEhT
LDI3MTEsMDowNi4wODAuOTU1LDk5Mi41NTAgdXMsMiBCLCwxMywwMCxHZXQgU3RyaW5nIERlc2Ny
aXB0b3IsSW5kZXg9NQ0KPkxlbmd0aD0yDQo+MCxIUywyNzMzLDA6MDYuMDgyLjA2MSwxMjUuMDgz
IHVzLCwsLCxbMiBTT0ZdLFtGcmFtZXM6IDEyNDUuMSAtIDEyNDUuMl0NCj4wLEhTLDI3MzQsMDow
Ni4wODIuMTE5LDEwNC41NjYgdXMsMjggQiwsMTMsMDAsR2V0IFN0cmluZyBEZXNjcmlwdG9yLElu
ZGV4PTUNCj5MZW5ndGg9MjgNCj4wLEhTLDI3NTYsMDowNi4wODIuMzExLDM1NS45MzUuMjgzIG1z
LCwsLCxbMjg0OCBTT0ZdLFtGcmFtZXM6IDEyNDUuMyAtDQo+MTYwMS4yXQ0KPjAsSFMsMjc1Nyww
OjA2LjQzOC4xOTYsMTA1LjAzMyB1cyw0IEIsLDEzLDAwLEdldCBTdHJpbmcgRGVzY3JpcHRvcixJ
bmRleD0wDQo+TGVuZ3RoPTI1Ng0KPjAsSFMsMjc3OCwwOjA2LjQzOC4zNzEsODc1LjIzMyB1cyws
LCwsWzggU09GXSxbRnJhbWVzOiAxNjAxLjMgLSAxNjAyLjJdIC8vMS4NCj5Ib3N0IGlzc3VlcyBD
bGVhcl9IYWx0DQo+MCxIUywyNzc5LDA6MDYuNDM5LjI3OCw1MS40MzMgdXMsMCBCLCwxMywwMCxD
bGVhciBFbmRwb2ludCBGZWF0dXJlLEhhbHQNCj5FbmRwb2ludCAwMSBPVVQNCj4wLEhTLDI3ODks
MDowNi40MzkuMzcxLDUwMC4xNTAgdXMsLCwsLFs1IFNPRl0sW0ZyYW1lczogMTYwMi4zIC0gMTYw
Mi43XQ0KPjAsSFMsMjc5MCwwOjA2LjQzOS44NzQsNTEuNDE2IHVzLDAgQiwsMTMsMDAsQ2xlYXIg
RW5kcG9pbnQgRmVhdHVyZSxIYWx0DQo+RW5kcG9pbnQgMDEgSU4NCj4wLEhTLDI4MDAsMDowNi40
MzkuOTk2LDI1MC4xMTYgdXMsLCwsLFszIFNPRl0sW0ZyYW1lczogMTYwMy4wIC0gMTYwMy4yXSAv
LzIuDQo+Rmlyc3QgT1VUIHRyYW5zYWN0aW9uIGhhcHBlbnMNCj4wLEhTLDI4MDEsMDowNi40NDAu
MzUwLDEuMDY2IHVzLDI0IEIsLDEzLDAxLE9VVCB0eG4sNDMgNEUgNTggNEUgMDEgMDAgMDAgMDEN
Cj4wMCAwMCAxMCAwMC4uDQo+MCxIUywyODA1LDA6MDYuNDQwLjM3MSw2NiBucywsLCwsWzEgU09G
XSxbRnJhbWU6IDE2MDMuM10NCj4wLEhTLDI4MDYsMDowNi40NDAuNDUzLDQuMjgzIHVzLDIxOCBC
LCwxMywwMSxPVVQgdHhuLDY4IDZGIDczIDc0IDNBIDNBIDY2IDY1DQo+NjEgNzQgNzUgNzIuLg0K
Pg0KPj4gUGF3ZWwNCj4+DQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IFlvbmdjaGFvDQo+Pj4gQmVz
dCByZWdhcmRzLA0KPj4+IFlvbmdjaGFvDQoNCg==

