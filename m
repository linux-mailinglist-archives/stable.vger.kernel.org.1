Return-Path: <stable+bounces-135206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B05A97A4D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010821899B3A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDC29AAEB;
	Tue, 22 Apr 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lMyKKsmT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BogQTmiE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M1oP8l0l"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31625CC4F;
	Tue, 22 Apr 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360357; cv=fail; b=S3tlDKslU42kRDyFeq3o3TPB1xOj+H/fQN3DNNSEsdNVfUwq30+5ucs+98NW9qVeKFbd1ZjqytIpYz1ewOQePE7L1jzRkSqt4sijwa+L77wI6v0ByWmYP/eqHt8GaObf2vy/aPHwNFf+K4kbsJPr5LzCKUOugLXgT3wngZ7qhOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360357; c=relaxed/simple;
	bh=s/JwXJGFgBMu2dPtuJKRjgz4ccWBcsMhhgT+lvlg5uE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6fbluFhRS3fgz2fvVwRqF+e4IrX/GdvhFNYF3gSx1KdutgocaY50kkRA+nTOD3rzz4nPQ5lia4/CXOfpg86VbOHO6LDjt5lKXjsA4bly9SyL+bLeGetzqBdYnsDQAucTSz81NvzR5ty3mmSCOThg83DmZh8VGaml7JyarOXMBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lMyKKsmT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BogQTmiE; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M1oP8l0l reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MKultn021644;
	Tue, 22 Apr 2025 15:19:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=s/JwXJGFgBMu2dPtuJKRjgz4ccWBcsMhhgT+lvlg5uE=; b=
	lMyKKsmTWCnM5mnVgWcbyRLiaAVqSdda5+Yt726zExSgQkl9PHhT2lQf2n8iaOiw
	hEn06k+CA4FAf8CSnEZniw9mZ0e5fRAzFPEpt26qQx9PT0HwECF7K1MQtFXn0QAO
	j029UH5GBWkFwPVXtaw0Hy7QCrnKWMQSyAO/ScGibeA41omIrFVkc3uqhRKD/3JG
	uqcP0hCnQ1qI4SdD4tfTSYN1zzJ+P2nhBMUS6C8x9Q6fW1rsXNRSdMNz27hwzLDU
	F8nv7BDumqHVduosgRGg2LmxeIFmX4BBcZSLDp4qCGuKmi/Hl0Xr0vGsrqSSyK+X
	7azxPLkDF5R4HA5ZP8FxeQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 466jkdr8x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1745360348; bh=s/JwXJGFgBMu2dPtuJKRjgz4ccWBcsMhhgT+lvlg5uE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BogQTmiEInKJrzjMmKbGr7wig00ykJCQMFgcN3bwZRUSB79PMAl4ZKSrlpDTG7Mjc
	 4zTIqU5Cew8MVndZ8j+xeCe1wbJ79Fl9NYDPjeJQiBxTHzqP3AbrIL7l77OK6xkwKE
	 2jkxjO1jG5uTTe9iowpHXuo31C7dCnXCv/2mMQKLofyqOq2RdX+PoJPyGOqi6b8NlR
	 TI/c8GH9EkAG0wZIBZ0yhy3WlrrywFDla6uVZaDKY2jpEuOMALA4a+imCoCT0lOh5Z
	 +LULKJX3PwGaGQiE6tiHscI9wSz6Q7X27CtescE0jOOzAXLhP2ClBgclFjFdiw2zO9
	 NVSRXrOg+XQDg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B20BD40361;
	Tue, 22 Apr 2025 22:19:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0D53AA006F;
	Tue, 22 Apr 2025 22:19:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=M1oP8l0l;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 89BF5405B3;
	Tue, 22 Apr 2025 22:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPDL5xqeD4mJhrKbn55/R4+lIsf9FNBTcJmNN1RUc1Ot/9cqZmM02dusMn0+DzY8ukvyOU2VY8ioNwiVttIAlSlHwQ2Vx5CoVOD5As7Oy5tqgC3IjWJcHWeknVfFhC9HIJkeVt8tpn57pXviSKUWUtfUO0r20TlGwcVVjz1eLJ+xfYY04o6JHuBrWQsqlJt3xog9WZ3HhF9UsiIZJ3WOGdvPK6E7Ep9yXsRSu0OWMVJS0UaHQkvl5xhNWniJkrcohb3bZh2LcbmdQBYUP6+IYHfqBvzckq4pB2/ARl79oZFr79606aSiZDwYmEkdLQaBoPPK2R3p2TfkfrGAnCt2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/JwXJGFgBMu2dPtuJKRjgz4ccWBcsMhhgT+lvlg5uE=;
 b=mmZswjFnxGBphLVuEwmL2RqzW1V2qN9V8dzqcL2v5WoxqsPBjppgXeGDh7+NWvTCwwTfPxPZ/BbulO/f8OMKKQO0JYYMeoEWRg95l/8798Qq5oK9hXcwDuJdkQgDbaht4t9OsJSPr01Rw5srVI0KKWj8wVVv/IKSe+amSPYF0uSoS0EIw3aMmvNCX28rlC/8N/YFuV3cz9xHxDolpxx80ZSkvcGjeYk9hbWm8uihhTX+fIUYPAwMKCni/QMsJWlmLN+h908Wm1NzrVbv1K9VKM//ho8jBPNd/rsZv0G+5ConvwgXmJeDhYeiSdR76yZDt7UL3sM8LMCHBNNk1dgYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/JwXJGFgBMu2dPtuJKRjgz4ccWBcsMhhgT+lvlg5uE=;
 b=M1oP8l0lxb/aIAElyzQo34v0OASHC6Tjd1cu5Qytg8BvEVB1/lHE9XmNuk0VcORs/idLlYNXF8QC7f3+nG57m5FzUzjQltSD98N5h2cwC7ulfFWYHJEzYoz0uFEzBq+lWKWMQmf13OXwSwA7tVXB1g7bkYkZwynMCi6A8hh3JDg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 22 Apr
 2025 22:19:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 22:19:03 +0000
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
Thread-Index: AQHbrrcVIJ3v9LAKC0KlURLuwZqSArOqNhAAgAPMt4CAAMehgIABFLyAgABsfgA=
Date: Tue, 22 Apr 2025 22:19:03 +0000
Message-ID: <20250422221854.yl7ypzc4kkxbxw2a@synopsys.com>
References: <20250416100515.2131853-1-khtsai@google.com>
 <20250419012408.x3zxum5db7iconil@synopsys.com>
 <CAKzKK0qCag3STZUqaX5Povu0Mzh5Ntfew5RW64dTtHVcVPELYQ@mail.gmail.com>
 <20250421232007.u2tmih4djakhttxq@synopsys.com>
 <CAKzKK0pReSZeJ1-iRUbU=w+dK0O1fB7AgecfC7KJap6m5cQWnQ@mail.gmail.com>
In-Reply-To:
 <CAKzKK0pReSZeJ1-iRUbU=w+dK0O1fB7AgecfC7KJap6m5cQWnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB7932:EE_
x-ms-office365-filtering-correlation-id: 9b366948-985a-4e8f-67ba-08dd81ebb08d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU94bmxqNUtoL1M3ZHVvSXdPd281MzJJSEttVkxwalFLdVJUQUdQd1E1QXk3?=
 =?utf-8?B?b09rOTBLaFlJQXVHaFhDcnBCWGNxYVpqQXVVb3lTQjM4Q2tQWjFNZW5Kdnd2?=
 =?utf-8?B?VXdJV04wKzBFcm14ZHdVRWFOTTJLUE81TXVWeExIRE14TXR0MHFybGhzQnhF?=
 =?utf-8?B?ZmMxL05QN2h0TnR2dVlkN1o5Z05KYlZZVWl6c2lkaFZCUXBveXJTbWlQL2g5?=
 =?utf-8?B?S2pWdFFpODV0ak1iQU9sb2x3MVJWVkVPcm9iSzZ2ZGFKZzZ6eVJYNWgwc0t1?=
 =?utf-8?B?QUtTVFZxWDZyYnc0dXlLaWhCZTIzSm50ek4yc0hXV3lsaVd2ZC94YmphMWFZ?=
 =?utf-8?B?ZUdQM2FsRlNaWTBRQ0oyVHZwdHNCNXptWjBubmxrTUJOTjBKU1Y1N1hNRXpM?=
 =?utf-8?B?SU4xQzdIVVJZVExXRkNmZVhqYlVCdVJ0eC8xYWI4NWE2L3grWTduOVlFN2Zw?=
 =?utf-8?B?SGkzVE82c3RMWWxvY2pUK3FFbFdqRmxsWnlHK2oweFpPQ1ZrVmVXY1FYNnRq?=
 =?utf-8?B?YWxPWU55bmhTbE1TaHRBOEFNOWZScnNLSHBOT1RBM3NpUzFuWDIrMk90bXVD?=
 =?utf-8?B?OGpoMXpMa3IzY0JORHZZbmlUc0JLQ05FODZVL3Q1K01PK2lJVTJHdUlaczgw?=
 =?utf-8?B?bHg1WnhIMDN0ZWFOUWViWUpKd0hkS0x4NEQ1T2tNYVB1bzUyeGZreWl0OHgx?=
 =?utf-8?B?WXBiREtpZFNLMHpsN3Q4VUdSaXlYMHJ1OFNsUk9URy9oNmFUK0NwdnV5eVNG?=
 =?utf-8?B?d08xK3hOMmo3NFdUMXFJd3ZwOGdEMFZGRlpucW56MVNkNmo1K3hWNHNsZ1Vi?=
 =?utf-8?B?Y0dnNnpXVXQ4OVNlT2VlQkc5bEFUdHZSTTF0c3BYaEM4Q0xqc1FaSXd2ZHFh?=
 =?utf-8?B?Zjl5SU9kRE1LUk1ua3pBN2JOVXJUU0FJSU5JRk4rb0syZFdyRCtxNURaMEJx?=
 =?utf-8?B?YTFQRmp0UjNMV051cm9FODZjK1h5MlRNZE5ScVgzWnE0ejVHU2JWNURZVVcv?=
 =?utf-8?B?UFhMNXdmZXJTTXhDUWthUHBxU2s0S3l1MEpMdkV2VmZqNkJ3RnM0ek9XOXpn?=
 =?utf-8?B?UG9kREQ1RHQxeDVpQXYyUkV0M0dLSGhQd3lPWDBDTGZOR3k4dkNicnZTL3or?=
 =?utf-8?B?WW5jdnh0NXlRZXJqbHpwSkFndGpDUnRqMENraTNrSWNBVUY2RjFSMC83VUd0?=
 =?utf-8?B?TUZmWDZZVzl6U0lJUStXemZVK1dLNk55ZjFxaG44Y0JrL0Z2S0J2MlhBZzdu?=
 =?utf-8?B?SnRYTzByMGJNUjArVnRkaXB3NjR6bGxSWHRIL2ZYVWNsYjMzMXBVdjd5azRp?=
 =?utf-8?B?SHB1YzJXNlBSWTJ1bDJFSHkrT2U0dG1zQnJCNnY2b0REZHVPUUY5cFlsYXFE?=
 =?utf-8?B?NXlDc1VsNEt3TFVzTnNoTk9kQVZTYVVZd1Q5NWN2TGZ2RGVGMllaUU5CdURP?=
 =?utf-8?B?NlR6cnNIZzg1M2w3RDZhdEVaQmRFc2hwaFRJTWdDWWk2N2JvTm1RN0lCNnhZ?=
 =?utf-8?B?YUtEck84S0dlYzFxK0tVL21mVmRkejZRRnpwZUFzVmY2blFsdGl0cUhKVGtQ?=
 =?utf-8?B?eDBBUW1BZGhYalZJUUduVUVmL1NqaitwWWJsdy9Yb1ZDQ3h0T082ck5aYWNh?=
 =?utf-8?B?ZFRFMExqcElrUmZJTGJKTzdGb2JDZmdVUGNPZzdhUFFRaEJOalVrQ3Z2bGYv?=
 =?utf-8?B?ajE5Qm5LcGVpSUs4NWUwZFZSN3N3a1RKdmYyNXBmaGZmaGFuK1E1blg2ZENB?=
 =?utf-8?B?UkhsQTJ2ZjFmKzhLNUZjZisxaWVLdGI3YUtmRVNkcUNrcFdkMXR1TnozeUI4?=
 =?utf-8?B?NktScStUdk5jeUVyNXFpbDdPMndBUks3N0FRR01RTEhPbE5VR2ZpSTlLQ2p3?=
 =?utf-8?B?My8vRklLTjZreG5DbFVvNytwWHZXR2c3Y0U4ZENCREZacG9pTkE2R3RtSndi?=
 =?utf-8?B?QXh5RHlTc25PUy9vM0IzMkhIS1pvSWZlQWlEV1N5TVBCS3ZVbVN1b3FRVU5J?=
 =?utf-8?Q?+1HynBM2cCoeGW9KB2TgFPq8jA0pWI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXVsTHJrNlJ3TmNrMEhKYjlLNmJmQjZZR3h5SUU2aldDcmZRN2J0SmVCSlI1?=
 =?utf-8?B?Y1Y2N3RXMG9OY2d6TW9XZTVlbHQ3SlF4cTJHa05mZmh6L0t3dzI5OW9NbnNF?=
 =?utf-8?B?ZURSRUpzQmkvVjNucGxZN21iS1RtR3F0R1dQT0tMcVRGYjYrcm52b2lJMGo1?=
 =?utf-8?B?aTd3Z053ZUZyZEt6NUFYeC9ySHBMOXdHYldiL0ROTis2S0lpQm9QbmVLZWly?=
 =?utf-8?B?bTJnNDUxMnpiSWpmUVpMdHNQQk1sU2Z1bmIyYVNQQkVRUWtlbGdtZkloSkd2?=
 =?utf-8?B?ME5sWUZrRE9RdEJYWHkxMFpmWXRGZGl2dWE5Rkp5NEhtRDBkL1BDaXp3WG1q?=
 =?utf-8?B?N0hmQzZIekw2Q1N5ak1uTEdkZGFtak53UDRTWWdhejNPS0pIQXRpRzZaZ1F3?=
 =?utf-8?B?a2RXcDlQdmxKcjFreFdINUtFalE3QXhtelVCMU5ueUdCQVVGQkVWVUxIYnQ3?=
 =?utf-8?B?REFCazhjUTliOHVlYlA1bjh3aFp0Y1BFNzluVEVYVmJGWVhNd2ZvSEVSZG5n?=
 =?utf-8?B?VVgzUVhQWmVrbUs4SEVTQlNDd21VQVExWWNXOFdFNllFdmxiV2FHbTZzNHVP?=
 =?utf-8?B?bmVuL05RT0RVSmNKLzd3SUVSTkdacElKTVlRQ01CZ0lyYUZqQ2RNbkRGU1BY?=
 =?utf-8?B?N1BSTnBjeGp1dkkrR25RY05VY0pKbnp3T1M4cUFUYWt1Nk9wWFAwWVZncTNk?=
 =?utf-8?B?c0oyWEZ0VnBQbmhKU0JxSDZJYzQ0eXZwOEVFTmQzRW50a1hkdHdtMEk5Y1Rp?=
 =?utf-8?B?eEY1WHc0WVE5ck9SM2NKQWRleTkzQmovU1V5QzJaVFUyeW5IWTd3RHJyT3Fx?=
 =?utf-8?B?K1V2eDFMVlRnK3ErSkZUanJmRVJuKzJMYkFlUytwT0hkK2dza2ZqTEpJQVBI?=
 =?utf-8?B?OCtobDhMQ1hsYVBHU21kL3VySm9BK0xKS2FxeEtNSlVSOVI2cHNyT0I2VURW?=
 =?utf-8?B?OWJmQ0lJWTVnSzAxSTVFd3JIcVhsQkpuWXhyUk8xWW43aS9zbyt0bTk2dGJI?=
 =?utf-8?B?OU85bThYcmpZaUNSNm1KZlcySW5sNWZIb3VlUG1tK3VJTHhDZ3cvQVVtano1?=
 =?utf-8?B?TFRNL0NUbEc1MFJ6aEN4M0RGRmx5QzVRZ1A4NTQ4L0pKaTVLZXQxU3c2M3NT?=
 =?utf-8?B?d04rcjhWOTJNT3ZJbzlNVTkwSkhuYmR1UWZlK29MbSsrbWdpV0s3azY3ZVQy?=
 =?utf-8?B?eE1Ld01tRSt1Wjh4UkR0Y200cjU5MVo2dHhtUnBBMUtIRDJGUm5jdm9KQXpJ?=
 =?utf-8?B?elRIRUJ0Q0lCNVlnbk9oaFQ2N3J0cXN1SVpoUFFKcTN3ZE04OStxYkFEYi9h?=
 =?utf-8?B?aG4vaFd0RTZEeVo5cTUzeitiVmxmZTV3Q0xrNFM5dEpmMlNxdkRGa0g5eTlz?=
 =?utf-8?B?VnRxRGlnWXdKemtjaWZkUUwzUGc1c0lERnNwWitBNWp6WGVjbXplVmllOEt3?=
 =?utf-8?B?cmZnMVFEamZyakNqWkgyOEo0RTF5bFNmSFBXeDdQbFR4MGYycmRWUXlGZk5I?=
 =?utf-8?B?UkVvTktDL0tHSjYvVWlKbGYrRmZ6QW8xYmdoamR4RHl3TzRCNXVTZ2tuRW84?=
 =?utf-8?B?dENnVHhFNXFDOE1ybE9Na29XQkN1WlZnUnJiMUNoRmVhUGRwcFlpeERRY2VV?=
 =?utf-8?B?eWg5OHRQcFZJNVVNbmR2VitkRzNVMjBRYUYyVGFtc1pkdndDY1BreEYyb1FT?=
 =?utf-8?B?OWxwa3pVNEZrNEgxL0pPcFJJRXZ1MEpBbmROb3YrMlFzbjM5SDlrbThTZllw?=
 =?utf-8?B?VUxuOHpwV2g4RnFvNzM2YTFTclVibloyMUJpZmpMMGRpdURmUXBweGVUV1hI?=
 =?utf-8?B?KzNheFFuRGxkc1dXazZpeDdEbVhua3JySnRkU29icktjYTViWGdDM3VWZ0tw?=
 =?utf-8?B?Ny93R1NqaGlXUTloVUFkdnV3eWl2alRTWEltZngvRDdEMi9lUEMvQ3RlSjlI?=
 =?utf-8?B?MHdpQmNDdFJWcm92RnVxNVp2R01PMEVwNXcvenZ6Z2FEMGpmSzRNeERLcHVF?=
 =?utf-8?B?RVlCVmZLZms5WDZhTkhEUnZweFNNYUp1VUhHOWlodG1oaWpWaEZmTmZWZGov?=
 =?utf-8?B?VTVKdUZWQlJiakpIOXZLRVcyNXBmL2FuR3N4amJUR3doUHRVVXphR0lVMmhD?=
 =?utf-8?Q?J3Y1wjdbhw0lNRaGQXrsxNxXk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <190027010D35E74F9687F02BBC246ECE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IhS0UOVUH6xazSZcnJ5Rk0ZpOBHJcP3pC+6y6t/IK+UVSTLWkWobg0dl6QIgQTgB+xeXrZaUDDo9dqVWbNzjcovOTLpLk+3xmNUhgnGWjrMR8zbhBOY5r4P1RGuTnRolL/dzo8YhH686qY8aeybPuTJLWNPUD9AtfSNODFjdRcRg649Y85V/A3Dttmz5vzSXIr0iX6kFBm9dt8bN07Jd0YtsXlngJCG+sSCKYYKn++e79tdT2hKW5bVNuWhNFrwF/JqLaRoqehGsuYEIYpsMMuS2A/4gfIaC60WcJgl2psvZ/KW3ir3R51Fvh1uPZWzlMwrObrwurhdCDXJALTG/TEXDbFByAavMNzPQ3KctBC+fOfro5vVkwzXe0Axn85fn5Im8ZJtuXyYlpZDatSH1f3KsUc/xjWmu7UTFx/ocVFCvUdDsQ74QO1P8p3qIk7MEyKGYCS0DVnCCMTfZaf1967wdrgFZ/VaUC4lGz/jl6mUKZJ5Gniike6JDDerjJlgu5TuJw39qnnEyeM5FPDQ8e5oVV96+gWe2MwxiGQX7I9NASRe9HvIUCOjcSlHAFuMKR8YtQNaCr7SPTCAvs8aKOqudAuWXA0R+kTZRnoDzoN4bt9ohWzwOqYehzfz2X3qF6JhT1/I0kTwagp5BkfoW9A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b366948-985a-4e8f-67ba-08dd81ebb08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 22:19:03.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMxlrSR7132Kdj1zgkraGEyo4SBFEKCpUMS/TPynZrANX01mlB6u1bzTI206/B9g5PCf6Uu1fLgwgVguKz7nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
X-Proofpoint-ORIG-GUID: 5SLL0T1ELLinBcM_xK5iPu3xUcqFmGDf
X-Proofpoint-GUID: 5SLL0T1ELLinBcM_xK5iPu3xUcqFmGDf
X-Authority-Analysis: v=2.4 cv=QfBmvtbv c=1 sm=1 tr=0 ts=680815dc cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=_TYyJNdKyKnjzSxaRwUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE2NyBTYWx0ZWRfX/Zo72Qqmnsts wQzuwN3XGibVaAz/tdJiNc/YKboYTyaLA/3NBZLZ8v7IIP4TbwXveu7aug2fM/vYkSIEyhXLHmM Y31TBiJXCNevbp28ISPNXjgol1ywthFJO2Lu+Oki3+JZzjtshqvMY1AIeyikpubrHBhwJkCX8cm
 s/CabKbQn+TkgVLoLGslRcRV8SPPGR93HJi6yAVEinPW5idnEyBQ+UybjWlHYBDE779DplpNINF nojZU5HH8IkswDQHwi5d/E7y3XjyH/ZaxHp4G9jazEkW+EEiG1skWafNAq1riEc61CcKS/eyIkL lpRJqh0e0Tu+gUM4LuA0ML3LlUJB6i3bBrfEaBCvU6bzM0xWiuBorX7/m/Da/We1oFNifmog/Rv
 Lo2Lzcm+Ckbq7X3qcQ8rKJycbET8SDN8lNeX3S32g8YrHJhO+uXAPPoaWA9aGqz7WEJoa6kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504220167

T24gVHVlLCBBcHIgMjIsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDIyLCAyMDI1IGF0IDc6MjDigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBBcHIgMjEsIDIwMjUsIEt1ZW4tSGFuIFRz
YWkgd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEFwciAxOSwgMjAyNSBhdCA5OjI04oCvQU0gVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gT24gV2VkLCBBcHIgMTYsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+ID4NCj4gPiA8
c25pcD4NCj4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiA+IGluZGV4IDg5YTRkYzhl
YmY5NC4uNjMwZmQ1ZjBjZTk3IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
ID4gPiA+ID4gQEAgLTQ3NzYsMjYgKzQ3NzYsMjIgQEAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQo
c3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4gPiAgICAgICBpbnQgcmV0Ow0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gICAgICAgcmV0ID0gZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+
ID4gPiA+ID4gLSAgICAgaWYgKHJldCkNCj4gPiA+ID4gPiAtICAgICAgICAgICAgIGdvdG8gZXJy
Ow0KPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiAtICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+ID4gPiA+ID4gLSAgICAgaWYgKGR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4g
PiA+ID4gPiAtICAgICAgICAgICAgIGR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4gPiA+
ID4gPiAtICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
PiA+ID4gPiAtDQo+ID4gPiA+ID4gLSAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4gLQ0KPiA+ID4g
PiA+IC1lcnI6DQo+ID4gPiA+ID4gICAgICAgLyoNCj4gPiA+ID4gPiAgICAgICAgKiBBdHRlbXB0
IHRvIHJlc2V0IHRoZSBjb250cm9sbGVyJ3Mgc3RhdGUuIExpa2VseSBubw0KPiA+ID4gPiA+ICAg
ICAgICAqIGNvbW11bmljYXRpb24gY2FuIGJlIGVzdGFibGlzaGVkIHVudGlsIHRoZSBob3N0DQo+
ID4gPiA+ID4gICAgICAgICogcGVyZm9ybXMgYSBwb3J0IHJlc2V0Lg0KPiA+ID4gPiA+ICAgICAg
ICAqLw0KPiA+ID4gPiA+IC0gICAgIGlmIChkd2MtPnNvZnRjb25uZWN0KQ0KPiA+ID4gPiA+ICsg
ICAgIGlmIChyZXQgJiYgZHdjLT5zb2Z0Y29ubmVjdCkgew0KPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICByZXR1cm4gLUVBR0FJTjsNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBtYXkgbWFrZSBzZW5zZSB0
byBoYXZlIC1FQUdBSU4gZm9yIHJ1bnRpbWUgc3VzcGVuZC4gSSBzdXBwb3NlZCB0aGlzDQo+ID4g
PiA+IHNob3VsZCBiZSBmaW5lIGZvciBzeXN0ZW0gc3VzcGVuZCBzaW5jZSBpdCBkb2Vzbid0IGRv
IGFueXRoaW5nIHNwZWNpYWwNCj4gPiA+ID4gZm9yIHRoaXMgZXJyb3IgY29kZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gV2hlbiB5b3UgdGVzdGVkIHJ1bnRpbWUgc3VzcGVuZCwgZGlkIHlvdSBvYnNlcnZl
IHRoYXQgdGhlIGRldmljZQ0KPiA+ID4gPiBzdWNjZXNzZnVsbHkgZ29pbmcgaW50byBzdXNwZW5k
IG9uIHJldHJ5Pw0KPiA+ID4NCj4gPiA+IEhpIFRoaW5oLA0KPiA+ID4NCj4gPiA+IFllcywgdGhl
IGR3YzMgZGV2aWNlIGNhbiBiZSBzdXNwZW5kZWQgdXNpbmcgZWl0aGVyDQo+ID4gPiBwbV9ydW50
aW1lX3N1c3BlbmQoKSBvciBkd2MzX2dhZGdldF9wdWxsdXAoKSwgdGhlIGxhdHRlciBvZiB3aGlj
aA0KPiA+ID4gdWx0aW1hdGVseSBpbnZva2VzIHBtX3J1bnRpbWVfcHV0KCkuDQo+ID4gPg0KPiA+
ID4gT25lIHF1ZXN0aW9uOiBEbyB5b3Uga25vdyBob3cgdG8gbmF0dXJhbGx5IGNhdXNlIGEgcnVu
IHN0b3AgZmFpbHVyZT8NCj4gPiA+IEJhc2VkIG9uIHRoZSBzcGVjLCB0aGUgY29udHJvbGxlciBj
YW5ub3QgaGFsdCB1bnRpbCB0aGUgZXZlbnQgYnVmZmVyDQo+ID4gPiBiZWNvbWVzIGVtcHR5LiBJ
ZiB0aGUgZHJpdmVyIGRvZXNuJ3QgYWNrbm93bGVkZ2UgdGhlIGV2ZW50cywgdGhpcw0KPiA+ID4g
c2hvdWxkIGxlYWQgdG8gdGhlIHJ1biBzdG9wIGZhaWx1cmUuIEhvd2V2ZXIsIHNpbmNlIEkgY2Fu
bm90IG5hdHVyYWxseQ0KPiA+ID4gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbSwgSSBhbSBzaW11bGF0
aW5nIHRoaXMgc2NlbmFyaW8gYnkgbW9kaWZ5aW5nDQo+ID4gPiBkd2MzX2dhZGdldF9ydW5fc3Rv
cCgpIHRvIHJldHVybiBhIHRpbWVvdXQgZXJyb3IgZGlyZWN0bHkuDQo+ID4gPg0KPiA+DQo+ID4g
SSdtIG5vdCBjbGVhciB3aGF0IHlvdSBtZWFudCBieSAibmF0dXJhbGx5IiBoZXJlLiBUaGUgZHJp
dmVyIGlzDQo+ID4gaW1wbGVtZW50ZWQgaW4gc3VjaCBhIHdheSB0aGF0IHRoaXMgc2hvdWxkIG5v
dCBoYXBwZW4uIElmIGl0IGRvZXMsIHdlDQo+ID4gbmVlZCB0byB0YWtlIGxvb2sgdG8gc2VlIHdo
YXQgd2UgbWlzc2VkLg0KPiA+DQo+ID4gSG93ZXZlciwgdG8gZm9yY2UgdGhlIGRyaXZlciB0byBo
aXQgdGhlIGNvbnRyb2xsZXIgaGFsdCB0aW1lb3V0LCBqdXN0DQo+ID4gd2FpdC9nZW5lcmF0ZSBz
b21lIGV2ZW50cyBhbmQgZG9uJ3QgY2xlYXIgdGhlIEdFVk5UQ09VTlQgb2YgZXZlbnQgYnl0ZXMN
Cj4gPiBiZWZvcmUgY2xlYXJpbmcgdGhlIHJ1bl9zdG9wIGJpdC4NCj4gPg0KPiA+IEJSLA0KPiA+
IFRoaW5oDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgZ2V0dGluZyBiYWNr
IHRvIG1lIGFuZCB0aGUgbWV0aG9kIHRvIGZvcmNlIHRoZSB0aW1lb3V0IQ0KPiANCj4gQnkgIm5h
dHVyYWxseSwiIEkgbWVhbnQgcmVwcm9kdWNpbmcgdGhlIGlzc3VlIHdpdGhvdXQgYXJ0aWZpY2lh
bCBzdGVwcw0KDQpPay4NCg0KPiBkZXNpZ25lZCBzb2xlbHkgdG8gdHJpZ2dlciBpdC4gWW91J3Jl
IHJpZ2h0OyBzaW5jZSB0aGUgZHJpdmVyIGlzDQo+IGRlc2lnbmVkIHRvIHByZXZlbnQgdGhpcyBz
dGF0ZSwgcmVwcm9kdWNpbmcgaXQgIm5hdHVyYWxseSIgaXMNCj4gZGlmZmljdWx0Lg0KPiANCj4g
SSByZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIHBhdGllbmNlLCBhbmQgdGhhbmsgeW91IG9uY2UgbW9y
ZSBmb3IgdGhlDQo+IGhlbHBmdWwgY2xhcmlmaWNhdGlvbi4NCj4gDQoNCllvdSdyZSB3ZWxjb21l
Lg0KDQpCUiwNClRoaW5o

