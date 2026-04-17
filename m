Return-Path: <stable+bounces-238526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGyiHiDA4mmF9wAAu9opvQ
	(envelope-from <stable+bounces-238526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:20:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC1C41F1FB
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB9E3092928
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5037DEB4;
	Fri, 17 Apr 2026 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uok6B7GK";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DeqzWMYU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="szqIamRl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C9199D8;
	Fri, 17 Apr 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467614; cv=fail; b=OsaoaTWMo1e5LJ4WjsKE3UL834SC4Xw71d7qzvPxmfmKwBdQgdx2MGto53v0UY+6wvCGiV4miH0LQ/fwRTaxYWd7Ud/NrbyeICC+qj8qx2hZTc/Ck4AhrIgPViMwabBcVKKrKbsTd9BOjzc3oTzn13V+tgtQpWFxtUA2NwQ7j3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467614; c=relaxed/simple;
	bh=+QAm57gi0tdvYzUecJeDghLiP8xy0gVSsIIayfHKz+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrFBorqgzneFqaVrrw9a8NqJDEizigcyutvwKmANknurHgP9pql4ANGcq4Z0rJhC2e2REWcA7W18DeH9iiJYEFigY4paf3YPLEAX/yXiN3ZsNkK/uGgYbuXsX4tUkclomJ4z09H8so5oSyhBSDZIm9uGs0A6NuDWqqK5/26kyBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uok6B7GK; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DeqzWMYU; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=szqIamRl reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HLfIEX1585441;
	Fri, 17 Apr 2026 16:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+QAm57gi0tdvYzUecJeDghLiP8xy0gVSsIIayfHKz+4=; b=
	uok6B7GKdgbszmZHjjUiaESQivLydZ3F/tIa6j59Fpk/JMmaWwVZgXzVvNammN87
	JD7akVrUQRfT5FNzOqmw9/RiC3dT7hFX6lWQXMH6miRMhGR/e+HxS+6mlHyOmOpq
	QYmhQEipiIDYMhzIK/wp9kSdsC3XcmjG5eqTACXP1x2i1ocEKXFqWw3wf9i4Y/JU
	AFBsileub7tgs/IMXQ5UAcVGioJDrZnFXthGPWGhJwNDuEdIJbeiNa8gLvScQWCU
	YLBOtEbigsyZnVUKkLlNUIX2BY0MqDIDaUvPgK/yYIOU81k8RdljEvVfTX4mx/HT
	WR/SuU8jB4HIc4a4p4Euww==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4dkrdghrq3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1776467600; bh=+QAm57gi0tdvYzUecJeDghLiP8xy0gVSsIIayfHKz+4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DeqzWMYUvc0JPpB5GhIMCmYZa8UOfHfoqeAPw67hl4U2RcixAKxy6loc/tcfI8y3K
	 XMQYkf4z+SmLKSaQhYKpEpyhFeSpjwsKOMWcB+9EzMyAh5He3glPo8bSTmC5oo72JZ
	 DwCWdLY/n0ewj6zPHCMNP4LEOirWplrMP2hYgVKO6cqgas+5YbI/Xsa3APJLDX6p82
	 Dmu7QO4tcmQU32ya3NttHVledhiHruLRxUpaXWhcS3+OUaLho/97wzBhn/ZwZYroCB
	 HP7AUVujuSj27eyAbY9Rur5pB3LmMkQmQiiKJEHBaK0JjyIh4EUl3PwpCMUAQSqOeu
	 0laEBdGC3LjBA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A94F84041D;
	Fri, 17 Apr 2026 23:13:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 15460A0357;
	Fri, 17 Apr 2026 23:13:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=szqIamRl;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00107.outbound.protection.outlook.com [40.93.14.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 327DB404D6;
	Fri, 17 Apr 2026 23:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkJG2OAFEB55ViNM7R4OzzPTsdTmcodncACrvrKziML1HjexhUKZwzVhAtZTqp7G4MXo7zPhu8f2XKlOqu5klaNo4RL2oSeiE7SP3p8ZCjt20jMKPqdR0TRP8U+j3tAcpfCsKvdi6FAOpCKv7TANI+YcOnCWnJYFFhhDAggpLlKIRjbQ7enhgZ2ngSBh177GnOd8FG/yl65g1uzcqD2vyBVdS8QQLioIHFvNepZsayQZEIFifQXrUuiv+5aY38cmS4UoRGUAdxIKbAQvEMYtA2zCpUJRrogE+iCJa8ReDEJ7Dbtmj8NCOOUHjR+3VCFI9ZTOLrn4FN2CV1/ZZAS16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QAm57gi0tdvYzUecJeDghLiP8xy0gVSsIIayfHKz+4=;
 b=B39WyqJgYIZQHxfed9D5VW1UMJk0p0dQckKBx4Zd0w6CoinR+lgSWz3xEH7WBA3+G3u/SOXGhN8+O4D2Z8ng+OkTmAhNn8HyIDihkQPmQbILSMIRAclFNC19VTFphNCV5Fj0KBSNTlvqsuzikEZMHGA66jObp34wz7k9FCZ41+DGyipn7O2rnt25L5tsWeiLJdJh7zwikuvGIpIQpie1h9FFNIZxU/bkmusGZLXkSJtSuPNbm9M7vidNe8Zw1QxS5iDOr/UcKO6UtP69odDcRpqU43tNaoXZddl2gKFg0VE+uyEKSxu+91GroQ7LPX9PaeUNU/2AQ2exWiGXlDlnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QAm57gi0tdvYzUecJeDghLiP8xy0gVSsIIayfHKz+4=;
 b=szqIamRlytEXoFcoTqm8dIq34U1L5wXed6zf4q3fCnCe/+6a4ROT2ucgDQzDZ1mEUoj+sn9MYmnHUF4g2ggT9C1gt+x7INH4F88D0LRJgs+BNtySh9Rj90F/IaNLvGVc+1dyMvMKvlnRQSkQgVffVu6nnB4ogUWFRIQghJ5kCjc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 23:13:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 23:13:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paulz@synopsys.com" <paulz@synopsys.com>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pritam Manohar Sutar <pritam.sutar@samsung.com>
Subject: Re: [PATCH v2] usb: dwc3: Move GUID programming after PHY
 initialization
Thread-Topic: [PATCH v2] usb: dwc3: Move GUID programming after PHY
 initialization
Thread-Index: AQHczjRZ9qiBmjtESkmzBqlvaJQWl7Xj4xmA
Date: Fri, 17 Apr 2026 23:13:13 +0000
Message-ID: <20260417231309.dnorz2sfdh3j652y@synopsys.com>
References:
 <CGME20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84@epcas5p4.samsung.com>
 <20260417063314.2359-1-selvarasu.g@samsung.com>
In-Reply-To: <20260417063314.2359-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4112:EE_
x-ms-office365-filtering-correlation-id: 87d46070-9bf2-4089-a608-08de9cd6e6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Q8yyuR2OyRU9oSezHUaX18qBYSzCm+jWF2vxk0BMwnKyNpHznorPoKgk8s9gpf0+uKpLyHVn3V7tYlAeqjpj2L/MTswPcZXti5i8uqQB63UxG1tvVUURghDyEmrFMO1exjA9zGPUA9A/lLhKoAt9/Do4J6gepTRFFRERc5LvGFkxzstQ0aJ1PvoUY2kIoDIUYyn87MHS1jrPZdTS5fT9yHM9dnoPLOyFvB7jKooqYpV+hMrfwhgUSI/pJOW2Xufppp8+t4ErsndNG2X8ecz+vhuGrBaN11wYBiM9o8KILNG1u+xckPEHn9dOsz1pRuaFZA9FNeyuJ+w0wdaQkbEsGR22VZoZlpEFdYjPnTKmsJ84WGO5fd3PXpplzqfwTzXRV+7/syumzkK5u0dcaHSasqXkdCdjeLevzbLXRmgKo/qHowf0OJsaiT2fvrIcnh4E1gTbeF/HDrVekTTI5HV9hJCyksz0Z452T7zP/2GUiL7AJKzbLoIPtjxLugpFUYcIB8Mg5kDDyZxS0ASC52Y5YJ+mVn0XScFzOky8cl26S0k9I1Vqd5tXQoBRyDfBg/hxvMtzWlCXI6IUi3OOHAo7epAxcGEM3YPYKeyHe/lph7j+P/IM7fOegaqrQiKdL91VWfPA6Q7Ww0Wp3OTtSnbMcVVaCs5+aPJ4+90Bju+n6wWC8nAxzAeV40OJ0rhrSM0/bxnS20a/LHm8kvYBEADQ2GIizG8HvjCqFriMAsTdYWtICGhXZhZL1UCiTYLJeL65vZFWDGByMTvG8GpEHlnKzgj+gj3hPjAC1n3//vIvrds=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkRPY2FvZWdzQVNSSWRrOGVtbVFOQWdBNVpoZ3NLdEcxY3FQVWg4eFpqUjM1?=
 =?utf-8?B?cjFYTit3YitiYWwycThxNmtRUzRHbENMRXZsZXJkSXhacHlYWTU5a3drT092?=
 =?utf-8?B?QVR2TExSR2RLWFVYQjUvOVZOOTN3QVpTZlIycHVodmJ4SUE3M01aY0hmSkdS?=
 =?utf-8?B?QkFEc3pFaXVVNmVhSlZPUFlFRHZRaGozcGV4UUNKM0RGajVkWENuVUFIc1Rk?=
 =?utf-8?B?OE5yNk5RM2d6Ri94NWlSR3JvRThMOUQ0aG9hajRXczRzemlIVWlFL2dnd1VG?=
 =?utf-8?B?NCtyMmgvNEp4VWI5RkJZSlg2WHk2bTduemJkZVRxd2R2cGREdE1Kd0QzN2p2?=
 =?utf-8?B?SDFhVE9ZMHpocjl3MGtnYmdhOVQxbWRPKzJkTm41WG4wMmpkQUt5WFF5S05i?=
 =?utf-8?B?LzcrbUQwbllOVEc0UmVYclJSRDZyMmlMR0Z2TUNPQVZ0RXRZTWVCRlhLWWJP?=
 =?utf-8?B?ZXhjYUdydVN1NzFwOVhoVzIrYk9yenR1UVczODE3R0R3cjJOYlVRa0x4bVZX?=
 =?utf-8?B?QmMyR3RPQWFxaFlrbkZaOThKSnlVeCttYURvSTNVdU5kK0FkalNVbTI2WEJT?=
 =?utf-8?B?cDFNaXVHdlVUakQxY3ZHVnVWNFVnOFRCUTZWM2J4L3d5NlljZFdnUmRFMTZE?=
 =?utf-8?B?dW9rdWF5b2ZYQlVWQXJFK0lQRkxYQlR4QlJrL0xiMU92MkJ2T3ZuUDZmZ3dX?=
 =?utf-8?B?SERlcFR5MkFINHZjRFpOdGZPdGVCcGpacTN6SGxpNmNTZ3FGTXEzR3Q4WG1S?=
 =?utf-8?B?cXMwaHkvZnBCc3VLeG5SMUtFSWZLRlM1ZWxtZU53VUJGYkZkZFhCTS9GY09r?=
 =?utf-8?B?OE4wb1NkYm5BeVQ1d3ZET2YzT0VsN1ZkZm91dFNvUUhKMUR4Y3VwL29HYXFE?=
 =?utf-8?B?bUxxbk9UVmd2QjB3SHVKcDVlMG5PaXlxSUVPV01VV1NTUjhLemdBZkt3Mm8r?=
 =?utf-8?B?MWFyZ0FhQWxvOHZ3M2d0eG9acHNQL25MSDBPU01MS0U4ZmwrbUxtbEJtN2JB?=
 =?utf-8?B?Mm1PQnpiV1A0bHQ4TlcwcGhmZTVBOVQyakplYUNwTXRSVE9DU3FDMjRTbHRv?=
 =?utf-8?B?WG1mSkVnSGpsYWpDb1lILzJrMU05QjYrV3dzNWw4aGxleG15Ni80QmFoYjZs?=
 =?utf-8?B?ZktSUTNxL1RiKzAyLzNoUTFVTUdTYkFFSG1pNmx3L2pZTmdZeHorTmFna0NC?=
 =?utf-8?B?WTFYZlRCenhCcURWR1o4OERCYUU2a2dCTHBoU0s4SWE5TWtlNU0rYytxUnNV?=
 =?utf-8?B?ZGdyTlJ4NzNaZEk4Yk5TeUV5YW5Jekp0RjFEYlowdm9YdTBHSXVpZXZkR0h2?=
 =?utf-8?B?VkJyVk44N0hhUWtDUTVxck90N0ZUV25Fb3M1SzJNY2luRExhdHJBQmFpUko4?=
 =?utf-8?B?WnJEMmI1c0tOeTBvWFIzOE13YWxZbmVSZXV2MnlsMERid0tuazRyb3d3Mmlz?=
 =?utf-8?B?SmVEdlJsWWNqSEhZT1NJMDJ3aEZ5U1llaUdHU04zSWl6WUprRUVWOGlEZjZ0?=
 =?utf-8?B?ZmpRcGRBVW1PaTJ2WHNLamcrUFRXanlWVDVhcmxRKzZJZGQ1eGJodHN4Mmsx?=
 =?utf-8?B?MHNDdWdGWkkwRFFKNUkzWEJLZ2k3S05DaG01V05BNm5XNkhtU2Q5b2JoRFBu?=
 =?utf-8?B?Z1RNZjBGWm03a1R3QVhrZzh2R3prWUNnYW00U0dhaUZpdS9MZzBVdS9uMktG?=
 =?utf-8?B?cUNyVGtsS2UwNXlnQWtOTXZTNmhUYzhSMjhCSUhnVm9pRjB1b1JJYnJUZVJn?=
 =?utf-8?B?WThGWCsvNVowbWRoZ1ZsczhkcjdZRVNyZnJlRkU2WW1XUlB4RzUzVmljbE5l?=
 =?utf-8?B?QWMxT0lDck9UKzFBZU5weUR2dlRIc0xLWGlnRU9YR3FTRDRDQUFNWnRIVUF3?=
 =?utf-8?B?MTlHdTBrK0ExZ1hLREdLbGNILzc2Q1BTcmxhbEJoeC9acGMwY3BxZnFoTHUy?=
 =?utf-8?B?ekFmdlI1d3l2VE05Mnd0V21vUkxSN0RjS3dZb3U3S2hkeTFTdjRYVEpJZ1pa?=
 =?utf-8?B?Z3R6a0MxUXdwbzAxQ0l3engreFlUY09PcHVWWmRPUVNIRWJwdnpUUS9GR2lP?=
 =?utf-8?B?ZjFqRTdTU3RqbzBQQUZERy9SOTNZekVVOUEvZXA4dThEOHpMam90a0xOblNR?=
 =?utf-8?B?MzRtWElvU2w1dXNqMndpSy91ZUZlSDVoNXNpMmo2ZXh5c3BTM1d0NmdjaXFC?=
 =?utf-8?B?eko5Ti9UeEpGaWJoL2RDc1Y0L0ZXakk3aUIrS2VkdGhRQmVLc1gzSWVYYU1t?=
 =?utf-8?B?THU2cm1jVW0yeS81bGlvS2RXSC9BT3NVZHYvTVpFenZNREhhRE9aYXF1QTVP?=
 =?utf-8?B?aDZtUG9tWHJ1TDlCRCsrRHVVYzBqR1RJRW9XU2d3TFhLR3EyMGw0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D30C212E468A364FB3DDF4403AB886DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eKf05WnLYnk+N3YMrXXRbDM1UF4UKXbWH5Nb/JeYn3hLGSomjtFqNUY0wMB8RhUtSvjzyQszGJ4tIC4fGO/digRLDxHfR3w9cem7J9iMX4G9CufdAwPMF45cT0CAsyi17gAq7wPhYMjvNnVm4+qfAupNosrZYvinq2qW6cN8RlKkPEc064DeB2P5cWXeKKb0gerOCcNvMWZzIk5Of7A1N1ALhMEzJuzuyJKEAVFD5HYXZtfZDg+6C5W6D5qV+t+FuxZ63qTA9V7obrJEFwbe+OoQgGpV28DnAJi/+YzpiyAE4SqsG2HMu8rtFzelVDGOXpJrNE11lny5RvvW6uMB1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ww+I/4nSApIfxxauelO5yCFIQSsOtofIQenm8oQu+tRMU2lzV9L+uNXbs3WbxdqxsYSOW+BB+qpczfsUNc3wH6zGMY1gqjAiquAOjTQQhGHA/1hWgk6beoKlP1mWCMCyq8z+HBnsCclEsqi2dVYJeGPMMYY55zB+6cPgJfOM4lx/6xwsk3EDiz9a21YMEqogIBSWckYDy5HDcuNs4og6LtU96fR35Xm3mrIw+8SjSQ03Jr3BE/gBMTyvyshd/0zY3g6CgclAvEJvN+FiHsMqaDcOrlTjBi5EeQKckx9XWwRtkvkwedn8gltvkDNeE/qbwqRcCOt/ReAFvVfDwWHmTRxMCC6JtCKOHoLpBa8n/0Ev5UEROonPKoQIquVuknoKQVLUSI5HWuAJzHrs3jAqh8NUyDCaBtE2fiLFQKAZi6kxW5mcQ8DPyLlf5ImXlhVltZtap6PGR1Oq5RDEo57KAoEEIxpXTsV/NR3uAhrpKMVKuyKCDpbCq7HNyig6cHnATv1QUyszdNTnjM15hWYEE1BuKOWspEkr5OhacFVqNDfBJ5J8F77dTxz3fiNwGTMZ7QHntu6yQyCEMCyE/yfmsNZYjBS737uC9tY5Ug0Tikvs0LYBVg6rp9bjIB/2vf6L63VmaZ6HKF1dgn34QLld/g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d46070-9bf2-4089-a608-08de9cd6e6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 23:13:14.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqg+0IemjQIegY4bDwp66IFpv0NRqP0oYLy3KM2Jl9yiOtj1pp2ipAsUEEkoYGosgkFpIAW4BNqZdTzwc3tAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
X-Authority-Analysis: v=2.4 cv=GptyPE1C c=1 sm=1 tr=0 ts=69e2be91 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=GLuEah2PNnTpZbAg6XwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 30PAzGsxkY2rfRi8HcfPVy6xbMk6DLD1
X-Proofpoint-GUID: 30PAzGsxkY2rfRi8HcfPVy6xbMk6DLD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX7L8mZhV9fzek
 GkvbghwnrFauyUgRdDol91qLnupdyPLk/FxFYY2ltqQTfECtkAlxQE1iO5OFYfpv9eaIWoF3H0i
 yCLjKMQfqvRj5swCVaPYLAZriQxAX9Ko8/wTu55ALtIpKtj7b3coqYz2gdZVLzZNKLyKbwAuK6x
 Z0pxs6x6NRfjYos3WOrVDlnWJvPpcAk6Tf7IFdLxzIuVbeNUhq5lFxTCknrRDrd/k73YAFPosgL
 NdnZzisXbstc+hj3803A7EXxgZidywmbnTzLZtbAEJPw8mwMukdl/vBLhWlnidPggijQ7LAvdSf
 T+BtD37MkcKenzeAr+/SqoqcXUQwEpqqIU4R5a5/guDcy1guFLKZ8XtKeuAcxc8HU+JA9Bvt+IN
 wLsAif/KZARf4kCLtouE3/pKH21suN3KQ4jlUpiBYhR6ZHzXwPDOdN+oq6aa2Iz8eIQOT7KWcfU
 enk6L8cYEiwbVXkbZpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604170230
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	TAGGED_FROM(0.00)[bounces-238526-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DBC1C41F1FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCBBcHIgMTcsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgTGlu
dXggVmVyc2lvbiBDb2RlIGlzIGN1cnJlbnRseSB3cml0dGVuIHRvIHRoZSBHVUlEIHJlZ2lzdGVy
IGJlZm9yZQ0KPiBQSFkgaW5pdGlhbGl6YXRpb24uIENlcnRhaW4gUEhZIGltcGxlbWVudGF0aW9u
cyAoc3VjaCBhcyBTeW5vcHN5cyBlVVNCDQo+IFBIWSBwZXJmb3JtaW5nIGxpbmtfc3dfcmVzZXQp
IGNsZWFyIHRoZSBHVUlEIHJlZ2lzdGVyIHRvIGl0cyBkZWZhdWx0DQo+IHZhbHVlIGR1cmluZyBp
bml0aWFsaXphdGlvbiwgY2F1c2luZyB0aGUga2VybmVsIHZlcnNpb24gaW5mb3JtYXRpb24gdG8N
Cj4gYmUgbG9zdC4NCj4gDQo+IE1vdmUgdGhlIEdVSUQgcmVnaXN0ZXIgcHJvZ3JhbW1pbmcgdG8g
b2NjdXIgYWZ0ZXIgUEhZIGluaXRpYWxpemF0aW9uDQo+IGNvbXBsZXRlcyB0byBlbnN1cmUgdGhl
IExpbnV4IHZlcnNpb24gaW5mb3JtYXRpb24gcGVyc2lzdHMuDQo+IA0KPiBGaXhlczogZmEwZWEx
M2U5ZjFjICgidXNiOiBkd2MzOiBjb3JlOiB3cml0ZSBMSU5VWF9WRVJTSU9OX0NPREUgdG8gb3Vy
IEdVSUQgcmVnaXN0ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRl
ZC1ieTogUHJpdGFtIE1hbm9oYXIgU3V0YXIgPHByaXRhbS5zdXRhckBzYW1zdW5nLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTIgKysrKysrLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gaW5kZXggMTYxYTRkNThiMmNlYy4uMGQzYzdlN2IyMjYyZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gQEAgLTEzNDEsMTIgKzEzNDEsNiBAQCBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIA0KPiAgCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3
cGFyYW1zLmh3cGFyYW1zMCk7DQo+ICANCj4gLQkvKg0KPiAtCSAqIFdyaXRlIExpbnV4IFZlcnNp
b24gQ29kZSB0byBvdXIgR1VJRCByZWdpc3RlciBzbyBpdCdzIGVhc3kgdG8gZmlndXJlDQo+IC0J
ICogb3V0IHdoaWNoIGtlcm5lbCB2ZXJzaW9uIGEgYnVnIHdhcyBmb3VuZC4NCj4gLQkgKi8NCj4g
LQlkd2MzX3dyaXRlbChkd2MsIERXQzNfR1VJRCwgTElOVVhfVkVSU0lPTl9DT0RFKTsNCj4gLQ0K
PiAgCXJldCA9IGR3YzNfcGh5X3NldHVwKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJu
IHJldDsNCj4gQEAgLTEzNzgsNiArMTM3MiwxMiBAQCBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycl9leGl0X3BoeTsNCj4gIA0K
PiArCS8qDQo+ICsJICogV3JpdGUgTGludXggVmVyc2lvbiBDb2RlIHRvIG91ciBHVUlEIHJlZ2lz
dGVyIHNvIGl0J3MgZWFzeSB0byBmaWd1cmUNCj4gKwkgKiBvdXQgd2hpY2gga2VybmVsIHZlcnNp
b24gYSBidWcgd2FzIGZvdW5kLg0KPiArCSAqLw0KPiArCWR3YzNfd3JpdGVsKGR3YywgRFdDM19H
VUlELCBMSU5VWF9WRVJTSU9OX0NPREUpOw0KPiArDQo+ICAJZHdjM19jb3JlX3NldHVwX2dsb2Jh
bF9jb250cm9sKGR3Yyk7DQo+ICAJZHdjM19jb3JlX251bV9lcHMoZHdjKTsNCj4gIA0KPiAtLSAN
Cj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lu
b3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

