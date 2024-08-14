Return-Path: <stable+bounces-67725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B72952626
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947261F236E0
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D21514CC;
	Wed, 14 Aug 2024 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KHTbozZv";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N75yLFjV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BKqrd+aO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870011494D9;
	Wed, 14 Aug 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677626; cv=fail; b=rAYkAN3cmeFBsbbiDw0TqOyhhACn2JlbHTINHTHDI14X4UpJAS/7XbTiVENt6YHNR52H4vg0X6gSPiVEvrU5QqkRLbDg+pDrRX38tLRqrzdYR98SL235OZ0WYKe1q+urqjZeC4JK8EqG1huNwinKDY+DVA219gy9/HSQ2S0EveI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677626; c=relaxed/simple;
	bh=0ViZPI/+G+q5EA5LnioMWTxMpgJIDlP/7hkQ5438AHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HugH+wOECryUblfYo4SscqiZdwfkrzu8kEhkU5gYlfGFS7A4zlKbsnB8AQqG9KYPbLOSIKr5KTqGbKXTAeIfXNqGJBHfve4eoLZnw6x2vbfq8e8Zv+c6mm0hJzYJ5ODfseBsHANQpgVw+qoXR0m+DBxoZNIBhZOxj+/R9j9Pm4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KHTbozZv; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N75yLFjV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BKqrd+aO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHxuts015948;
	Wed, 14 Aug 2024 16:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0ViZPI/+G+q5EA5LnioMWTxMpgJIDlP/7hkQ5438AHQ=; b=
	KHTbozZvhJxHVn5MrV6oa1CSfj6E0Gv3pXYVn36fAr42Eju9JGqvlVaNZqUIB2kp
	GMOSwR0II0vita73nkGINNZ85j2QUhGE2QU5sG9Dn+AkSnXUkn03D0cEII5DDJ7J
	LwjtJQUnfFfO91JUzUB23AJiYK9rGI9NVKP6pVBDCwmgWfvA0zocEA8xrwxIBkfy
	DBFmcLfjJ/Yedr2gvvTJDfhc8Gc8rM5FygbAIE7z8DRrYrYFMpYDAC1oQFqRXoyi
	KGCXZ2DvnC9zRcEjR0+GI3Noexr9/JU6DKYBFNAcsAfTgXsJ1rXpQ4jv1mg2ry6n
	W+Aut2SVcFylOFebzmrI+Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111fhh4g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723677603; bh=0ViZPI/+G+q5EA5LnioMWTxMpgJIDlP/7hkQ5438AHQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N75yLFjVQv4R9D3juDsAiMmCl7X6bRzvhez4eameuMPXcd3TuXeSoRBmvENvq1Won
	 Pygsfw3HkghyapK7q7mQZMYnSK1q8r8i/kwMvIBZxeoCrotkoPFFQPgglGM17UZfLP
	 jOy+BaSlWd0broOVwCCLjdeRHYMdnZk+pLGHdfeHDJCiuRvcacFvQALHX+NB42JfE0
	 W92NDCUaB1Lan1Dl4vQ19W9FKHEXaUccWroVLuS0Gei9xzl0F+bM/RDjL6Q7lbKGhD
	 LztKpRMao5KD5Q6drWP7ZHS2IWyxyztYg3E1s2RQjnb7Z7FkjLdNzpgq7IZZdk0CHm
	 O8uY5sB8+kKKw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6021640361;
	Wed, 14 Aug 2024 23:20:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E5AA0A0081;
	Wed, 14 Aug 2024 23:20:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BKqrd+aO;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BF26A4011F;
	Wed, 14 Aug 2024 23:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t49604b+DRL92S87LTYlEboKO/3VzaGmT5T2nQpGZLR2HFL+TcgA/F8Nq5R9AMu6ZlXtVkd/ImnDlhYgv76V8tbiioiD7SfPsV93v385KkkN9GTXVL8R4q3LAoAg6IRmhRO9jwVifJPXkD6vqEiDu0dC+5UsM8i4kLvXlHIyjTc/jPwdoJaBoevATrWtwQIfrsReXlYXrjoMJs1kZ5sofv7igxylYdSkJ6tI7SzFBLTcDQ49CxsBT2bp4ckiOmRCUkIB5CcnxWGP6cZnxnUncvp8Plt6doPXOulEeQdgUs179CawMDerqa71LC7tFFcGIywvWCfsd4E7X4ct2y8qBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ViZPI/+G+q5EA5LnioMWTxMpgJIDlP/7hkQ5438AHQ=;
 b=K3RDUa5X8hllzmVO2vEBobEOP1XkRgORnMiYTqJ/oyKE2wrzTnua/8Z4jc3R1eq1imvQtRXECnRH03NI4NVzXKykdQYq2LcQkLcGa8ZoJ74UM3l4URTGNqpXmzjKBSu1i2MCoZwOYaK7GL8WspCDhMhce7Qk8SFllgwYS1yv9KqpYlJUOuLfDwO6FiDYW7cia6vTy+7PiUWfPkMwFS7Gb1f63dE6J6penjiJJJpOHB4cOOLLIJfSZ8yGZQH0A9IwswRwfrS5nTR3T8Hj3hdjw0kw4qYMlzKD2XksNV8iG5bQRyFZQozFJt0nzrMfdsaWt7+WzrR1fGOz92PafO6GPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ViZPI/+G+q5EA5LnioMWTxMpgJIDlP/7hkQ5438AHQ=;
 b=BKqrd+aOl5fgoq03bAv9Jh5RImBLGPD7wibc7Z2Nrux3/NGObSoY/q839T7yN8JBorJ4mjGBr7o2ZtqgcUl8oJScCQT9tp9GN9si1ORVPm7KYCSsmLvEPaPMRG3ieENLkmIlxdUmeC9QJg9p3h6+xYEWzAPg6q/Y3X0l/TNubtE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 23:19:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 23:19:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Patrice Chotard <patrice.chotard@foss.st.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>, Peter Griffin <peter.griffin@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Lee Jones <lee@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: st: add missing depopulate in probe error
 path
Thread-Topic: [PATCH 2/2] usb: dwc3: st: add missing depopulate in probe error
 path
Thread-Index: AQHa7i30KD16qyRUJkO8S5L+enOCL7InZJCA
Date: Wed, 14 Aug 2024 23:19:56 +0000
Message-ID: <20240814231951.k3ejoyno2ogcvsee@synopsys.com>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
 <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: ae938cd6-447d-4079-3ed7-08dcbcb79c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUk1MWxkTU5GVHJnQmk5TVhyeFdneXVlL3ZCUWxBZkZCclNBM00yNWNZdlAv?=
 =?utf-8?B?dHpxRVhSV29vQUhESXY3TTNUNWVjSUV1NGt6SkFmUG9JNElxR0ExUDVhZTgy?=
 =?utf-8?B?WXVmM05zOVVURU0xY0p4Tlk2cWtkMWh4bGZaVXo0ZDV0R0F6a2N1dE9jTVZJ?=
 =?utf-8?B?V3UyRlFtbDg2bU95Q2Vzdkx0M1dUZjA1anYvU1daMEgrUUk4RjdlSVpuSEtL?=
 =?utf-8?B?dGxjUCtWRzNRNlBGRmVKQk1jUTdhZ3M4Tllsc1JFc3JBNHR6R0JYUUVRTzBO?=
 =?utf-8?B?UlBhNnNPbWFqR25LSTM5ZDh0RmcxVVROSkJUUlpzd3N1Y3c5ZlZLY3hoajBT?=
 =?utf-8?B?cm1RVTE2UG1OVTAva1JBUmVua21Pd2xHM0NBL3NhNndoQVNYUnA5Q2ZUVTVX?=
 =?utf-8?B?dWh6QnVjRm9WeG9CcFhmYVBGMHRzMHBKSFR6czBuelJsOHFDajRJbTZXRkFz?=
 =?utf-8?B?eXZoQ1o4TFJ1K3pvVy9kT2gveUJxVXdsUHdiNEw1VUtUcTd2djhuVUJkdGhk?=
 =?utf-8?B?VmllSHN2elVhZEFSTTF5ZVRZc2hTaThoaEFyWHhyN25rMEhHU0xkZ2pxMEg5?=
 =?utf-8?B?aHh1aTVIdFYvcUFXL2x2LzA4WkhjVHFXR05xWXdROTFJSGxnR1VmMFp4Uncv?=
 =?utf-8?B?akdsUVlRWDk3TFlhd3IveDJWbVZyUnNGZ2lYTXQ3UDVOQnJPaHFtdjdvQm9x?=
 =?utf-8?B?WHY0MXdoQkFMVkJLbk1LL0xEZC9iTU8zbDJVd3M2M1psRWV0RkZONkU5TWNR?=
 =?utf-8?B?Z0JKL3BuQ2dISDh3bTRTbmZkRmlzMU4wei9MS25hTXpRQnpQRGJlN2N6SVN3?=
 =?utf-8?B?NGJQQ2hPRkU4TkVEMW9mZlJ3NUtyeWhJS2FhNTh0LzgxNXAvMWJ1VXN2L0Rj?=
 =?utf-8?B?WU5Pc2N5azNrU0p2WWNDVE51bEJvVC9kelhhZWh0N0RydVVwWHFvTHIzUGY3?=
 =?utf-8?B?Zno0T3RPNTV5LzBPM3B6ZUluZlUvdGtlMG13RHRINmErN2JNMU0xQmg4RXha?=
 =?utf-8?B?bFcrWXZ5dDR1V1FXMlFFY1FKYnNLWmhwL0VIS1o1S3grN0tzOCt5QVJ4ZmNI?=
 =?utf-8?B?U0NnNXR3bFdOeFR0b2p6VDI3TEkzVkkrejMvRGtGekwyNUJlRXhpc1lXSlRT?=
 =?utf-8?B?NHRSMWQxRWZXcUg1SXRZeDJpWnI3K3NyK1N1R2kyMkhrU3NkRk1RK2ZWZklF?=
 =?utf-8?B?SXhKcWluaFRkMTNsTzM1aDR1aGNDM1FMM1FyNkdnMW9GQ0MxeEhqekpqR2U3?=
 =?utf-8?B?OTYvcUJmY05XNVg1WkZLQzdrckxJZ2dXNWlkdGVOOEt4clU0clBPSk5kY3I3?=
 =?utf-8?B?NFlxK0xCY0x5blM3bjU5MnNnWk5xY2J1MHRjNkR5cWpOeVBtVkZqTms3SFFp?=
 =?utf-8?B?bFRZVmNpc2tNcSt3Qk5pNnhkWDhOZzBZQmZqdWZ5b3hjVnJjNkZFd0RqaG5p?=
 =?utf-8?B?UjZtTnZZaVBoZFQ4ZzRSRGp2c25kdi81T1FMd2lFWGJoRldlSHpkK3pNMU5T?=
 =?utf-8?B?NzA4Lytlb21nWURWTWRCOGNRR205c09vNzNTNTFpb3NzaFFMZ0ZQTy9EUTBs?=
 =?utf-8?B?NVd5UitrNnVIczNJcm13TFFSRkI5UWUzNW1wZ3luTXh2Rkc0MVBBTDZMTm94?=
 =?utf-8?B?bWZCSkNnUHNLZWMybXBDZG9TTW9MOU1sdVF6MFc1QURjSkJlcnBCSGlGOG0v?=
 =?utf-8?B?NURETnNkK2F5QWJ3OGd6Y2R5aWdkR2pOZHgrODZ2dGYybGNZdDNHdzR0MHds?=
 =?utf-8?B?VllPL1ZPa0lxQm1nYThsVUZxbVNBaklRS1RhdEhxT2trUmdLVC85ZTMxdjNp?=
 =?utf-8?B?TnZDUFRKMTRrYi9JMjBpWjVUWFNqSEtLYTlhSnBIMXArVjI3NnF1VXo3bXFX?=
 =?utf-8?B?ZG5rQ2VDR1pCdUJBSEEwbFpsa1pPZjJRU1llUmNpQnQ2MWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1RJREVBdlhTWnUyMUxHR1dBeUxoS3dFSFlEY3NoS2pYNUJUYm01MDdTSTBq?=
 =?utf-8?B?SlA5NVZIeWFheHg1RnlaYWxNZVl6MUw1R2RsRzY4anBQR0M0WHNGRVdHL05C?=
 =?utf-8?B?VEszNUxVMFh3cXhnckQyY0wzNFRPSUt0RUVoYmFCQTE1UkM1NkpVakF6UGlI?=
 =?utf-8?B?VzZLeU1mdnU3SzA4by91SlRnV1d1dlAwK3NMbHdmUS9IVWFTU1N6YlVQdlli?=
 =?utf-8?B?WGROMkpaK2drS1ozOHF0ZkRrRksxOTBtSGZZdVcxek5LN0RWSGpSa0dpdkp5?=
 =?utf-8?B?Sk0zMHQwK0Yyay8xUEhYclpwOWV4WUVub1ZDeTM4c1BkME0xTUFCTTNzVGYx?=
 =?utf-8?B?aVlhTXJ1YjRPYmdKbVFoVGlqU2JSUkg0MWRvL2ZLUVE5Rm1uQXZCbVlWUzFo?=
 =?utf-8?B?dk8waW9HVitYMG5kbEg1UGNLamVMakZLdGRvZkNBaG5CQ1B3R1ZoaTN6SHIx?=
 =?utf-8?B?VU9FVEFIc255b0tHQkc4ZTF5UlVPTGl2NmJETUlLL3FCL2tvaWJneW01QjBS?=
 =?utf-8?B?MkdJVkZKdTdEVDR0YnVHWXU0UWJNdVJvL1J3ZEhuUDB3NzlEVGZBQ0dPSzBi?=
 =?utf-8?B?TFhHQ0FoVnNiMHlWcVNlSXZqdlN6Vmp3K3JZN25pTlEwQWRoTWVkYVZrc0Vk?=
 =?utf-8?B?d21Sbm9IU1JuVVhtazAzcHBFejVSK1lhZUFEaHFjOUxXQmsrbEpzMFdXRDQ3?=
 =?utf-8?B?eUhrZG9ORXZSeWo3cjlaV1hoL01ZdmtwakplTXB0ejVPVmNyYkFtdjhyTzFU?=
 =?utf-8?B?M2dUMUR5dDZLdGFOTzlYS0VGZDVubHAwR09KKzRXeUVnb0VXTVdIUkhHM1Ru?=
 =?utf-8?B?WkJ4VjlxQVFHZ2R3clFZZnpzY09tcEEyOW0vaGh5Z3hHa3czSUVncE5DTDZS?=
 =?utf-8?B?YzZmVlpVKzdjWXJWM0dtODVoUU5EcU9qK0kxTHpuRzE0Q0VBZ2RZNS9ZejJt?=
 =?utf-8?B?cVlmWmlheTZXOERDQTc1OGQyaVdQbHYxek1vSG1ER2tjTmJRaUZjMmdiNStR?=
 =?utf-8?B?OXh1S2JScG9MaWNoNTVGdVJrdGpZOERyMk1MRjJkTkxGSGM5WDJOZytPaVUr?=
 =?utf-8?B?WXQwNHg4dlgyblR3NjRQQ1FCQWhIMkZvSnBlaWJVV3RwZ3NVSUxvNVdmVVgx?=
 =?utf-8?B?ZlI3OGdSdER6ZndvcVdBUkFEY2tOdU93Vzd4TWhROHRFeWFhN2VOWnRtc0Ni?=
 =?utf-8?B?QkdyVXJRWE1QUkdLTEU5UjArSmlHb0hQSVZsT3I4Z0prUVJPYVFjdjRLSHo2?=
 =?utf-8?B?ZW5wUlc3WmRuRFd5bUp3bmdoODY4TlZJRkMwTklIWGJ1Tm9lZSsvc1A1aXFj?=
 =?utf-8?B?YzVZVjB2alZTV0l4V0J6SzhhdkRjK1JIYkJsd0dmejFQeVk3UGVsNVFmUWU3?=
 =?utf-8?B?c3NRdm9lWk9mZzMrV04xUW9UaXpydFM1NUhUM1hhbkw0cnZpV2tlQ2ZmWE90?=
 =?utf-8?B?aW1SUk84SExYLys2a2xxd1AzTmd0OWhTMExPd01KNEZTQ3g0c1d6eUxNVzRC?=
 =?utf-8?B?dVFSWnU3ZEZBdWc4dHNEN3NSejlDdkF5SW1FUmVtWllHZmltM3dJNEFza2lX?=
 =?utf-8?B?OHRiNDFEbzhvS1hPaWt1U3I0QnNBOVQrakorUkx6ODBkVlk2aFBaQUFhbVFn?=
 =?utf-8?B?YU95NUh6YjhBcW5HNmxMRC9TRmdUS1B6SkQzMkVBbmRYZDRLYXEyb0UybWY4?=
 =?utf-8?B?RndKRlo1L0lTL2thZmZhcDgxd2NyZzJUWjhuZEUvNXdxNTE4eU1rOUNOMmZy?=
 =?utf-8?B?VEJKREg2VW05Q2JVdDZwaGtQNWZWSHVXTU9QRjJ3ZGZMWjA0UkdrbGVUSE1p?=
 =?utf-8?B?ak84dmtMOGUzVVFYVlBaT0h3MXcyWGtRZjJYY2pkR2R6RVVFRXhKaVdNK0hZ?=
 =?utf-8?B?aXBOMXhvYkNDcGlHUGQrdlBTb2t4Wk5pU0V5MVJOT2ZHUWZKaHhVY3E3UGUr?=
 =?utf-8?B?N2pGM2VGajlmNW9DRTRLMGxkelJWUVlNVkdMY1F1blVJeS9RNzBObWg3eDBM?=
 =?utf-8?B?Y2hXdTQvbThWWW9nTkJDUnpJdlRiaVI3ZDZ3SnMzMHBYOEpnTzFyTVU0TmR0?=
 =?utf-8?B?VWs1N0Z1ZFN6d2lXelNYTWtCa3Q5a3FCa0I4NnY2Mlpwdy93R0YycWJQekY1?=
 =?utf-8?B?dVFVUGFNdXF0UXNOSFFDTnFXWnBMenRseDhoOS85eHBTaUc4Z1Z4S2NHUVVK?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63FAD37F6D96674BB4974C73B59E34B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WF7ufJE7p6Rhla7zvGwV+rwU+Bqnae2H+830It04RCSLCFzIa2FlHB0GDivs13oP8G5o4fyiWe6ZBBx2BGGj3USkNFjyWeS1w+kl+InJhviEoPdl4KB68mnXjODpVGYc/gNb3vSvkOLqzUo2wpS1P4Z/SbvdvqKo+1pdrpJ7lRg9uhcwuaYTc663rgiPduuaJBcrhHRH3lLg1lP1npGba9DTIT/gO8QQ4SXMyLubB3nJYrdm2NdsXNaKda9h4kyb+UD50Ht6YL09nZTDP9SdRxfMFXQKHtSpkSdVW4HyzvpmV1QrA+rqpRL0JRmFxQb8IgofboZqUfNb28j3AyvpiqXMY8PyTEhlnaGGEzOrGnfMo0CM2I/Jrsn9g5exLcnxyM8Dsc1TRgzYfJGfnA+QhsKs7v5ZByzYqXgUqVki2PEJHUmYQi8fV6g4remolbTUnfxXjr4hebcd3AUecboi08F26zv3w2uMo2TtmgEPSwCwrgQE62cK1yyKD9symXcgX6cZqsVfbMHKKqsdahq1ZcCuJh0g7T/w1w441HT0d/g4bBi/WXngzv/SXceC7Op8hur5n8QrTaIdC1uvKUy2+Ue0Wa8Lb99ZOrXoOgTdOs/MaZgVBtk5crARKBCs9f5yXYAtwsYM/ILwHqy2jRjN1w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae938cd6-447d-4079-3ed7-08dcbcb79c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 23:19:56.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hL72KG4q9A4tKqjrKzhzvxaiJq1eNvZhnEgcepXabGOd91KWn61rndH5KIpt/Qw93g8qXG7ze42Hh9qkZ8Ftjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Proofpoint-GUID: ri3ba5HgTVSMBVwL3rgVst9W3AU2A9zF
X-Proofpoint-ORIG-GUID: ri3ba5HgTVSMBVwL3rgVst9W3AU2A9zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_19,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 mlxlogscore=882 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140162

T24gV2VkLCBBdWcgMTQsIDIwMjQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IERlcG9w
dWxhdGUgZGV2aWNlIGluIHByb2JlIGVycm9yIHBhdGhzIHRvIGZpeCBsZWFrIG9mIGNoaWxkcmVu
DQo+IHJlc291cmNlcy4NCj4gDQo+IEZpeGVzOiBmODNmY2EwNzA3YzYgKCJ1c2I6IGR3YzM6IGFk
ZCBTVCBkd2MzIGdsdWUgbGF5ZXIgdG8gbWFuYWdlIGR3YzMgSEMiKQ0KPiBDYzogPHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gDQo+IC0tLQ0KPiANCj4gQ29udGV4dCBv
ZiBteSBvdGhlciBjbGVhbnVwIHBhdGNoZXMgKHNlcGFyYXRlIHNlcmllcyB0byBiZSBzZW50IHNv
b24pDQo+IHdpbGwgZGVwZW5kIG9uIHRoaXMuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9k
d2MzLXN0LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtc3QuYw0KPiBpbmRleCBhOWNiMDQwNDNmMDguLmM4
YzdjZDBjMTc5NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMNCj4gQEAgLTI2Niw3ICsyNjYsNyBAQCBz
dGF0aWMgaW50IHN0X2R3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IAlpZiAoIWNoaWxkX3BkZXYpIHsNCj4gIAkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZmluZCBk
d2MzIGNvcmUgZGV2aWNlXG4iKTsNCj4gIAkJcmV0ID0gLUVOT0RFVjsNCj4gLQkJZ290byBlcnJf
bm9kZV9wdXQ7DQo+ICsJCWdvdG8gZGVwb3B1bGF0ZTsNCj4gIAl9DQo+ICANCj4gIAlkd2MzX2Rh
dGEtPmRyX21vZGUgPSB1c2JfZ2V0X2RyX21vZGUoJmNoaWxkX3BkZXYtPmRldik7DQo+IEBAIC0y
ODIsNiArMjgyLDcgQEAgc3RhdGljIGludCBzdF9kd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJcmV0ID0gc3RfZHdjM19kcmRfaW5pdChkd2MzX2RhdGEpOw0KPiAg
CWlmIChyZXQpIHsNCj4gIAkJZGV2X2VycihkZXYsICJkcmQgaW5pdGlhbGlzYXRpb24gZmFpbGVk
XG4iKTsNCj4gKwkJb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZShkZXYpOw0KPiAgCQlnb3RvIHVuZG9f
c29mdHJlc2V0Ow0KPiAgCX0NCj4gIA0KPiBAQCAtMjkxLDYgKzI5Miw4IEBAIHN0YXRpYyBpbnQg
c3RfZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXBsYXRmb3Jt
X3NldF9kcnZkYXRhKHBkZXYsIGR3YzNfZGF0YSk7DQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gK2Rl
cG9wdWxhdGU6DQo+ICsJb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZShkZXYpOw0KPiAgZXJyX25vZGVf
cHV0Og0KPiAgCW9mX25vZGVfcHV0KGNoaWxkKTsNCj4gIHVuZG9fc29mdHJlc2V0Og0KPiAtLSAN
Cj4gMi40My4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lu
b3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

