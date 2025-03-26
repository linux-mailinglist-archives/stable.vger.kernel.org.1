Return-Path: <stable+bounces-126668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BACA70F25
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F101761EA
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B186344;
	Wed, 26 Mar 2025 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRr2V6c1"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B853D6F;
	Wed, 26 Mar 2025 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956937; cv=fail; b=N2HkzHFkiniTpQxwE21Eu4qto34RFOd3c8QHQ/ZEw37Pdys9R7JyxBH0Q+gvZ4sODENi1nR+Ql6ljtwSajTM9DKEo2aoSCpV9eY0Ys4QBW+X0fKQmKlAJ+aMijF5kJItGkLSxM37l9+Z+aVDRlobFNPmBkJHCq5JWlizNdRfYRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956937; c=relaxed/simple;
	bh=pem+AYfYXi1lH2LURvcYq2fhwZoN9SDT9Mxz0PC7xys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cweG6XsU0n5mz8zp3badme0T5pPJE4pHHMmp94vuxlWq4ivksqEo1T+JvXyH2OENXklB5KPyEPm6Lc+chT+8A/4paa9JrRZ5SM7wUVe09j7cKpSqQSPkNk6UnSLg8MrdB+10eytiZbxD3r3NhFMXb4ZjvvdBoKnAo8Sbpn4LQb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DRr2V6c1; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXY78RyZRPNlAipXxBKJOu6L++FEt8Tk9DnrL0XRfLmQhYR+8abioDUXn+U1/9m9tiJgNXL/y/ub9xNIY92JEQqwF2uOXjbsuAkxvMbgTfLutOUzf6HUNAOPT7pub/EE7JZIH+SO/+eXJ6bsAWeVmhS93lOks9H6Wcvo4d6O/Soc8SNZ4nCjD5ru4Nt1x9Bie+VHLOH6M2aszePrTXsZ77or2DZhZn56BgIjHkeQPCXn312p2FwmL2CxsXhuF9Y9Ty5nf9zlssZzEQduu0cLyzmTiQmurtOmjGWmgtAYKQP1HvAsuBB7BbKyVewnREgfj/41RrZmUGxpQ3eoORJKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pem+AYfYXi1lH2LURvcYq2fhwZoN9SDT9Mxz0PC7xys=;
 b=fW1+GF4awxRt8/WLDw9HQtOUHCZJw5JUvvJIpTCxPSnhnE8WR/z+J/d9N++WEDrY39lwoda/gcrHoY5x5Duzsi/V/0Xq2CMk2S5CIk1TSJ2b9AgI1p7C6MA14wYUCPGQ3tMWkQ8E9I3HHTZhNENPVBtVIN13FhHrK/aubLBm+kd9JiVS5rzMfQgF736jFxonn0fF2TWFA9FlaLDM4jF++9WDPBTtUeAjHv7hh5sP4WeafhO1WsEcsucAWrEeYC2mxeCmwFlYhJg8ZWJ4cYNbblhfZsU84sV8Or3fKKsQ9A9riD85djo+s8OZpWxLMDlrTLPZEBRxpz6MLtptoJoa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pem+AYfYXi1lH2LURvcYq2fhwZoN9SDT9Mxz0PC7xys=;
 b=DRr2V6c1r2UMNWIXpOMeomoUaXmjqd2hjQcWsDfQNCPl0kqjiVxhgMCcaytxa6TPbw4I7od+46U9UJOApW91jUTMJeBM7NpX7BOc2jVYc/nq1G8+78nhHd82EOhqYFAVSMtui9WuUSuFL5D3aURt84HiRF/DU+RJOmOgqnP4xdnmVh5EmLjcBxjp2HF4ZngHff5Y/AAXNRqFN6+tQlbxyikfDYlqOMZv8iEfe763rlK00cOyxX1m1ME9DyKClW0aOGeqKldPwNmhJUR0TkzGcWzXKnmXuTbzGCOOqI91nh5s6Oh96EgXXH1OsAkoNZOOoaA1iJAAykaRSI2ViHjWwg==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by PAWPR04MB9813.eurprd04.prod.outlook.com
 (2603:10a6:102:391::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:42:12 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 02:42:12 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "bbrezillon@kernel.org"
	<bbrezillon@kernel.org>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rvmanjumce@gmail.com"
	<rvmanjumce@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
Thread-Topic: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
Thread-Index: AQHbnW/7PXTpawcfAEm3Y/HvAU7//7OD7ZIAgADIFJA=
Date: Wed, 26 Mar 2025 02:42:11 +0000
Message-ID:
 <VI1PR04MB10049D3A51688C4C7F42EAD798FA62@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
 <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
In-Reply-To: <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|PAWPR04MB9813:EE_
x-ms-office365-filtering-correlation-id: 3379d48f-49d2-4c2d-d86d-08dd6c0fcf94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnJNM3VRSmxoTnQ4ajR6UldST0hlall5RFpDcitMaGJ0alk2TXpCOFJ4UmRp?=
 =?utf-8?B?RDhQUWV5S2VTa0RhZ05tWFc0Q0xjaDZIdVEzQkNURjNDTUlZVDVBVGhiU1pM?=
 =?utf-8?B?NDlVN0tRTjBTR1NrS1R3cE10cDFnbldPSUZ3UzVZUUFVNmtoRDBLOGtFVVl3?=
 =?utf-8?B?MUJJbWNuMTl0Vm0rRDFKZzJ5KytEaVRXWmN0b2RMczV2RjlNTzNTOEgrKzNT?=
 =?utf-8?B?dC9KV3JBellpWFdobjR0REU1d3BEUy8xUTZOcDQrblJxeU5FRVV3SzZiRE4y?=
 =?utf-8?B?UnFkT1BZWkZuZVB3MFU3VGJTSkRpMVM0NEs4TnhDTVBXNnB0YkRuMkFwSjUr?=
 =?utf-8?B?YVhTZWk3cjYyQXlmOE4rYUhsZm9iSDlmQkY1UjVuaCtGdHdVdnlraGR4a0dt?=
 =?utf-8?B?aWdhVllzaGRJT3hMTW0rTCt2WG9kY3JNeEl0MklBekUyV3pzV3U4b1orQWRF?=
 =?utf-8?B?ZldnZldxTVdGRlo0akp1UHlHMlpQU0o5VGFuQ3IwMkdIZkE0VU9Za3hNY3NC?=
 =?utf-8?B?dXhNeG5pUEREdjNGdXRFanIxaXg0UDNpZlVYRW1NUTJlVjM4ZWVqRkVSQ2JH?=
 =?utf-8?B?cm0zVWxvSHAvUmNyY3ZjWm9LUTljd3pVR1lmT3VoRk9kOFdRNUliakxaWEx6?=
 =?utf-8?B?bjdNRXQzYzdkTllLM0IrT096bTNSSzVRendKMGpsd3daVll0T0JoemVHNGxB?=
 =?utf-8?B?SkordE85QmVkK3NMV0hUM0MwOXpINmJscXRXZkJQeVhlR3R5VE1PSmsrck9v?=
 =?utf-8?B?U0Q5Nk14RnZnbzFvQUNrRjl6Zm1vR0tyYUt2SzRrSjJ1YTczL1ZnSGU2MEZn?=
 =?utf-8?B?SUtEYXBzaWgxblFOVmdOaHhKcjZZaW9CMnVDYTJnN1REMUtwUy9ETkY0cDNj?=
 =?utf-8?B?cGJaa20wTVltQ1YxME9rbk1VTDhxSVh1NjVSQ2liSm9ENVpnQ3I3a3JBSFgr?=
 =?utf-8?B?NWJoeXU4NVg4UjN1OTd5bzdkTlZUWHgzbEFNWkQvemp4Uzl6T0MwVzUxbzl6?=
 =?utf-8?B?NXdaaktiMnZ4QWpxY2h5aGlEMHVCajFOSXV0Q1ZJeW1vTm1VYS9kYUVGZkpa?=
 =?utf-8?B?N2hFZkdNVm5PTzdLS1FzU2UyNERnSGNVU0dRZ2NHOU4waXJQSmtPNzdua3dj?=
 =?utf-8?B?VlJRZWNicThoR2xrd2wwa29UaDlQZVJFQ016SjliSFVMUnVENUtnTnc1bDZj?=
 =?utf-8?B?WVJuNXNYdjQ5UmVmZlB6RWpLTTlnQTBpU2ZpbjRFU1NTODlaUzRIWkZmeisz?=
 =?utf-8?B?b1BHZnBnd0pFNVZpdjgxUmQrbWNDUEhWdUdrZHc2MDlHeFJ0ejhNbzBaWCtF?=
 =?utf-8?B?Z3k3bFZQeFRIQXl4Nit0bVZoV0ZBUzVkdWpTekpSaDg5VWJRY2grZmVTOTJX?=
 =?utf-8?B?VWR5RlVDM3ZEM2kreXBUa1p0eGlxM0RGdHc4aVBBSnp5M0FRZ2w4T09XaXRM?=
 =?utf-8?B?Y0tHQ0VhaHB0OHR3YzYrWHNKakV4elFDdmtJMnRKVTR4cHFDNFlXZWg2Mlhz?=
 =?utf-8?B?aitQVkt2NFVsVnBBUkFRb2hiZnZQRWFlZTRaQVhrTk1oN0pSbDNqb1BZZlhJ?=
 =?utf-8?B?c3hkQ0R1eWJLZVFGZVZjYnBpaTE1YUZ1OFg0bDBkdjdoTlBKNzZXNGwwQmFN?=
 =?utf-8?B?VWJybXFnMmFIcnhuTnR4eEJBNFU3dHpLalZMT3JObG1WT3kxWlJFRkFzQ3NE?=
 =?utf-8?B?ZE1BSW9RNmoySFBvTDkydmQ3dXhVVW9IdkU1TFFKNjlWOUVTN1pUaDRpTmVx?=
 =?utf-8?B?aHVqeEFkeXQwYWxGT21hSEtTaDAvamprbDhqeWJCci9tQ0JaNVVSakp4NGtL?=
 =?utf-8?B?dGsvQzV0dDgrTzZpU2JuTk1JbEhFcDYybUVHOWJ4bEI2Wk1KUEdvamREbnlM?=
 =?utf-8?B?QkNFam00VTBlM0RkazNvK3hJbURrZGhHR0pSVm1uWXBmeGljVGdjczJKRTN1?=
 =?utf-8?Q?/5IfkmTPLnh2MLyvBWDmVy4GclbVXQfv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmhTbkdPcnJXbzdualNOa0I1djd0dDd3cHp4YmdBTEtKUGZZR25ERS9GMGJa?=
 =?utf-8?B?R3dnVVRocWYzNmRzN1dGdFlMamtONDZDclU1Zk9iTEdWUjdibWRmU2M5MUV1?=
 =?utf-8?B?a0RDY2dxbnBwb05OWFR6ei83bFB2WFVKeUVuYzR6VjRPSEwxQWhPNzduYkpD?=
 =?utf-8?B?Nys2bVczZjNjTXdCcHVoR3JzOGxGUTZUY1FQdXVrTzRsbUVGUG0ycmJZQ2lC?=
 =?utf-8?B?djR6Nk1EakRkWXg0d0tQT2xsWnR6VUtYVkx2SVJPbTNrQ0NlYUlkdlhkbDI0?=
 =?utf-8?B?bldSZ3RQTktWSnhHVXA1a0FJVkVxRTRPZ3RFS1BtSU8wMlJJNFV5QTJnTDEz?=
 =?utf-8?B?UVRYTDhPQzNzV2pXVFV1ZFJ3emd5WnYwWXcrQ01MMUR1MnZzNm02a3RKZHds?=
 =?utf-8?B?UnFXak02eFFPMm96Ymc1ck96WndPWUtzdVpVTndmRU5lN05UTURYVWkxQkJE?=
 =?utf-8?B?S0JKK2FXZU9IamFoRUhDSVZ4VXhYcEhwUi9SZ21JSHRNckFrbFozaVJGLzcw?=
 =?utf-8?B?SElXbkFYbkZsaWVJK0RPUXplckpQaVkycldSQVd1SXFpcitoV2FqdTlLZ0Z0?=
 =?utf-8?B?Q2JNMjBxTkFmTG5rbFk3UURteDBuUDJrMGlhcHhvRG5mcmpuVElRdy9OMkVM?=
 =?utf-8?B?dEE5b01OYzNpUXFraXpXV0lsN1JhSStBUGtCeVkrWG9FampyVnJxWWZvczN4?=
 =?utf-8?B?dWEzMkM4MFk2YTlGMXQ3c1NCNjIxZW5YL1ZrRTVJNHc5OXYwSWRTNjZoNkpR?=
 =?utf-8?B?eE1FWVdiUTgyZnQ3bGJDY21PeitsZzFUazBHUnd3WmZlYzhHajVyZGdkWWJl?=
 =?utf-8?B?QWplMlRkb3FYQ0IwUWxHNDIxRzF5Nm9HNXA3c2t2TEpoK1Jsa1dOQTJHS2xE?=
 =?utf-8?B?Qldlc21jcEFUNENJRFZFeVlva1BVSjFIOStqWXFnYVAzT2N4VHVyNXBxaFZr?=
 =?utf-8?B?ZHZmT1c0aWhlSDN0RmZhbEdjSmMwQzFmS3FuSDdOTGN2OHZKVW94bXg4SlZ3?=
 =?utf-8?B?UC9UK1pYNERFa0ZJZ09RRXhHb2ovbG5GcUM2M3ArNkhETG40T3lyVS9kZGU5?=
 =?utf-8?B?NjViUWhTVmc3ZDNoK0FBRVZvbklnaFRkNU1tZUM3alBSbnIxVXFQTmZZc0hx?=
 =?utf-8?B?akFPOE1NWmRUSTlWV3lUYXZHajYwdFdSY1hrZlMzU3VtcmVJcG5EWmUrQXlM?=
 =?utf-8?B?WS9yVHRxQlhUWVVkUk04Tm4rSEpYVkZPeTF3aFlJS2tzZXY3VitpWktmQm1i?=
 =?utf-8?B?VW5tR1ZtbXJFYjZTZGdSZVpTam9kaThxVlZ0NGVJRVYwSmVQNGxBVGpMdXgv?=
 =?utf-8?B?ZkFjS1pXN2hkcmw4UXNjMXpUSWJqcnpLVTZlYzNWZDBhMDFHWDIzUFAwNmdG?=
 =?utf-8?B?NHV2eWkvUjdrVFE0QklBQlJQVHpMYWZ1cGNDK2d4ZDFtbFptTlF3MlNhdEd3?=
 =?utf-8?B?dFNjVmRjUEtMYXYrdXVkdDJHSHozUnBSR1J6aFF0Zm12Mk9EampCK2pZamE0?=
 =?utf-8?B?QkFzUlR5LzhhTUxmc0ptNDhOei9kR1d3bE56S1EwQXlDKzdUNVNRYnpnb3F1?=
 =?utf-8?B?blRpeHVJZWxpRXhQS05QTFdRQVVndkN3VEVMbCtWV0FFVXJIdXhkOUF1K2dp?=
 =?utf-8?B?YlNmNFM3UFJobkRoWGc5VTBJVENBalR4ckl4eGFQa1o1NUNIcEo2RnJZNlZF?=
 =?utf-8?B?R0dxSmdVSXd5TndKS21RMllsazdpLzJ3T0hGWklhbUpEWUtUVWMxUWlqZStk?=
 =?utf-8?B?d3U5eUErd3RzWTlER3JmcVBlM3NWbnZGYmlTZ3hYS2tETUxjK1YzbkhXVzFR?=
 =?utf-8?B?OE9jL29hVk9Ic2FKSDd3MUJHOWs4S1Vhb2xES0xwTnV5ZGMyZWRZamtJUzNr?=
 =?utf-8?B?c1FUMXhxU0xIOXBLTkR2WlJMTmtBRDlmZm9rcmszZ3gzdVRPNjdZbzU3eVFE?=
 =?utf-8?B?bEhlR3BqcS9ESC8xQ2NtU25idlhvT0xKS1FYdDI4MFNhLytyZ1hNT1UxSnZF?=
 =?utf-8?B?SG12MEQ3a1p6THBBUTFleThPUEMva2VpdEdJMWVjZFh6Q29UOWpsdXpIdExl?=
 =?utf-8?B?QzdQRjQ1MmFDSzlFUEd1eFZRN09Kb3hwWVVDQlNHTlF3ZUlqZWtLdU9PV1dM?=
 =?utf-8?B?YnZvYitwUGk0TEx2Z1BGaVdpdTZqM1VFdHYvMTE0VFRUNWk5NzVxQm80Q3NH?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3379d48f-49d2-4c2d-d86d-08dd6c0fcf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 02:42:11.9139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2j17dsWd3k+1tiIxGeDbNACwzeQ3HAdYP/rZPalkxhdsHJlYF8hRs7nGN1mRBdKX4+jRHdmDuEti/691uyPt6BogvQJFKz/8SWjoht9TSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI1LCAyMDI1IDg6MTMgUE0NCj4g
VG86IE1hbmp1bmF0aGEgVmVua2F0ZXNoIDxtYW5qdW5hdGhhLnZlbmthdGVzaEBueHAuY29tPg0K
PiBDYzogYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IGFybmRAYXJuZGIuZGU7DQo+IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBiYnJlemlsbG9uQGtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBpM2NAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gcnZtYW5qdW1jZUBnbWFpbC5jb207IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NV0gaTNjOiBGaXggcmVhZCBmcm9tIHVucmVhZGFibGUgbWVtb3J5IGF0
DQo+IGkzY19tYXN0ZXJfcXVldWVfaWJpKCkNCj4gDQo+IFN1YmplY3Qgc2hvdWxkIGJlDQo+IA0K
PiBpM2M6IEFkZCBOVUxMIHBvaW50ZXIgY2hlY2sgaW4gaTNjX21hc3Rlcl9xdWV1ZV9pYmkoKQ0K
PiANCltNYW5qdW5hdGhhIFZlbmthdGVzaF0gOiBJIHdpbGwgdXBkYXRlIHRoZSBzdWJqZWN0IGxp
bmUgaW4gdGhlIG5leHQgY29tbWl0Lg0KDQo+IE9uIFR1ZSwgTWFyIDI1LCAyMDI1IGF0IDAzOjUz
OjMyUE0gKzA1MzAsIE1hbmp1bmF0aGEgVmVua2F0ZXNoIHdyb3RlOg0KPiA+IEFzIHBhcnQgb2Yg
STNDIGRyaXZlciBwcm9iaW5nIHNlcXVlbmNlIGZvciBwYXJ0aWN1bGFyIGRldmljZSBpbnN0YW5j
ZSwNCj4gPiBXaGlsZSBhZGRpbmcgdG8gcXVldWUgaXQgaXMgdHJ5aW5nIHRvIGFjY2VzcyBpYmkg
dmFyaWFibGUgb2YgZGV2IHdoaWNoDQo+ID4gaXMgbm90IHlldCBpbml0aWFsaXplZCBjYXVzaW5n
ICJVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCByZWFkIGZyb20NCj4gPiB1bnJlYWRhYmxlIG1lbW9y
eSIgcmVzdWx0aW5nIGluIGtlcm5lbCBwYW5pYy4NCj4gPg0KPiA+IEJlbG93IGlzIHRoZSBzZXF1
ZW5jZSB3aGVyZSB0aGlzIGlzc3VlIGhhcHBlbmVkLg0KPiA+IDEuIER1cmluZyBib290IHVwIHNl
cXVlbmNlIElCSSBpcyByZWNlaXZlZCBhdCBob3N0ICBmcm9tIHRoZSBzbGF2ZSBkZXZpY2UNCj4g
PiAgICBiZWZvcmUgcmVxdWVzdGluZyBmb3IgSUJJLCBVc3VhbGx5IHdpbGwgcmVxdWVzdCBJQkkg
YnkgY2FsbGluZw0KPiA+ICAgIGkzY19kZXZpY2VfcmVxdWVzdF9pYmkoKSBkdXJpbmcgcHJvYmUg
b2Ygc2xhdmUgZHJpdmVyLg0KPiA+IDIuIFNpbmNlIG1hc3RlciBjb2RlIHRyeWluZyB0byBhY2Nl
c3MgSUJJIFZhcmlhYmxlIGZvciB0aGUgcGFydGljdWxhcg0KPiA+ICAgIGRldmljZSBpbnN0YW5j
ZSBiZWZvcmUgYWN0dWFsbHkgaXQgaW5pdGlhbGl6ZWQgYnkgc2xhdmUgZHJpdmVyLA0KPiA+ICAg
IGR1ZSB0byB0aGlzIHJhbmRvbWx5IGFjY2Vzc2luZyB0aGUgYWRkcmVzcyBhbmQgY2F1c2luZyBr
ZXJuZWwgcGFuaWMuDQo+ID4gMy4gaTNjX2RldmljZV9yZXF1ZXN0X2liaSgpIGZ1bmN0aW9uIGlu
dm9rZWQgYnkgdGhlIHNsYXZlIGRyaXZlciB3aGVyZQ0KPiA+ICAgIGRldi0+aWJpID0gaWJpOyBh
c3NpZ25lZCBhcyBwYXJ0IG9mIGZ1bmN0aW9uIGNhbGwNCj4gPiAgICBpM2NfZGV2X3JlcXVlc3Rf
aWJpX2xvY2tlZCgpLg0KPiA+IDQuIEJ1dCB3aGVuIElCSSByZXF1ZXN0IHNlbnQgYnkgc2xhdmUg
ZGV2aWNlLCBtYXN0ZXIgY29kZSAgdHJ5aW5nIHRvIGFjY2Vzcw0KPiA+ICAgIHRoaXMgdmFyaWFi
bGUgYmVmb3JlIGl0cyBpbml0aWFsaXplZCBkdWUgdG8gdGhpcyByYWNlIGNvbmRpdGlvbg0KPiA+
ICAgIHNpdHVhdGlvbiBrZXJuZWwgcGFuaWMgaGFwcGVuZWQuDQo+IA0KPiBIb3cgYWJvdXQgY29t
bWl0IG1lc3NhZ2UgYXM6DQo+IA0KPiBUaGUgSTNDIG1hc3RlciBkcml2ZXIgbWF5IHJlY2VpdmUg
YW4gSUJJIGZyb20gYSB0YXJnZXQgZGV2aWNlIHRoYXQgaGFzIG5vdA0KPiBiZWVuIHByb2JlZCB5
ZXQuIEluIHN1Y2ggY2FzZXMsIHRoZSBtYXN0ZXIgY2FsbHMgYGkzY19tYXN0ZXJfcXVldWVfaWJp
KClgIHRvDQo+IHF1ZXVlIGFuIElCSSB3b3JrIHRhc2ssIGxlYWRpbmcgdG8gIlVuYWJsZSB0byBo
YW5kbGUga2VybmVsIHJlYWQgZnJvbQ0KPiB1bnJlYWRhYmxlIG1lbW9yeSIgYW5kIHJlc3VsdGlu
ZyBpbiBhIGtlcm5lbCBwYW5pYy4NCj4gDQo+IFR5cGljYWwgSUJJIGhhbmRsaW5nIGZsb3c6DQo+
IDEuIFRoZSBJM0MgbWFzdGVyIHNjYW5zIHRhcmdldCBkZXZpY2VzIGFuZCBwcm9iZXMgdGhlaXIg
cmVzcGVjdGl2ZSBkcml2ZXJzLg0KPiAyLiBUaGUgdGFyZ2V0IGRldmljZSBkcml2ZXIgY2FsbHMg
YGkzY19kZXZpY2VfcmVxdWVzdF9pYmkoKWAgdG8gZW5hYmxlIElCSQ0KPiAgICBhbmQgYXNzaWdu
cyBgZGV2LT5pYmkgPSBpYmlgLg0KPiAzLiBUaGUgSTNDIG1hc3RlciByZWNlaXZlcyBhbiBJQkkg
ZnJvbSB0aGUgdGFyZ2V0IGRldmljZSBhbmQgY2FsbHMNCj4gICAgYGkzY19tYXN0ZXJfcXVldWVf
aWJpKClgIHRvIHF1ZXVlIHRoZSB0YXJnZXQgZGV2aWNlIGRyaXZlcuKAmXMgSUJJIGhhbmRsZXIN
Cj4gICAgdGFzay4NCj4gDQo+IEhvd2V2ZXIsIHNpbmNlIHRhcmdldCBkZXZpY2UgZXZlbnRzIGFy
ZSBhc3luY2hyb25vdXMgdG8gdGhlIEkzQyBwcm9iZQ0KPiBzZXF1ZW5jZSwgc3RlcCAzIG1heSBv
Y2N1ciBiZWZvcmUgc3RlcCAyLCBjYXVzaW5nIGBkZXYtPmliaWAgdG8gYmUgYE5VTExgLA0KPiBs
ZWFkaW5nIHRvIGEga2VybmVsIHBhbmljLg0KPiANCj4gQWRkIGEgTlVMTCBwb2ludGVyIGNoZWNr
IGluIGBpM2NfbWFzdGVyX3F1ZXVlX2liaSgpYCB0byBwcmV2ZW50IGFjY2Vzc2luZyBhbg0KPiB1
bmluaXRpYWxpemVkIGBkZXYtPmliaWAsIGVuc3VyaW5nIHN0YWJpbGl0eS4NCj4NCltNYW5qdW5h
dGhhIFZlbmthdGVzaF0gOiBUaGlzIGNvbW1pdCBtZXNzYWdlIGxvb2tzIGJldHRlciwgd2lsbCB1
c2UgdGhlIHNhbWUgaW4gdGhlIG5leHQgY29tbWl0LiANCiANCj4gPg0KPiA+IEZpeGVzOiAzYTM3
OWJiY2VhMGFmICgiaTNjOiBBZGQgY29yZSBJM0MgaW5mcmFzdHJ1Y3R1cmUiKQ0KPiA+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sL1o5Z2pHWXVkaVl5bDNiU2VAbGl6aGktUHJlY2lzaW9uLVRvd2VyLTU4DQo+ID4g
MTAvDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuanVuYXRoYSBWZW5rYXRlc2ggPG1hbmp1bmF0aGEu
dmVua2F0ZXNoQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gPiAg
IC0gRml4IGFkZGVkIGF0IGdlbmVyaWMgcGxhY2VzIG1hc3Rlci5jIHdoaWNoIGlzIGFwcGxpY2Fi
bGUgZm9yIGFsbA0KPiA+IHBsYXRmb3Jtcw0KPiA+DQo+ID4gIGRyaXZlcnMvaTNjL21hc3Rlci5j
IHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTNjL21hc3Rlci5jIGIvZHJpdmVycy9pM2MvbWFzdGVyLmMg
aW5kZXgNCj4gPiBkNWRjNDE4MGFmYmMuLmM2NTAwNmFhMDY4NCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2kzYy9tYXN0ZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaTNjL21hc3Rlci5jDQo+ID4g
QEAgLTI1NjEsNiArMjU2MSw5IEBAIHN0YXRpYyB2b2lkIGkzY19tYXN0ZXJfdW5yZWdpc3Rlcl9p
M2NfZGV2cyhzdHJ1Y3QNCj4gaTNjX21hc3Rlcl9jb250cm9sbGVyICptYXN0ZXIpDQo+ID4gICAq
Lw0KPiA+ICB2b2lkIGkzY19tYXN0ZXJfcXVldWVfaWJpKHN0cnVjdCBpM2NfZGV2X2Rlc2MgKmRl
diwgc3RydWN0DQo+ID4gaTNjX2liaV9zbG90ICpzbG90KSAgew0KPiA+ICsJaWYgKCFkZXYtPmli
aSB8fCAhc2xvdCkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICAJYXRvbWljX2luYygmZGV2
LT5pYmktPnBlbmRpbmdfaWJpcyk7DQo+ID4gIAlxdWV1ZV93b3JrKGRldi0+aWJpLT53cSwgJnNs
b3QtPndvcmspOyAgfQ0KPiA+IC0tDQo+ID4gMi40Ni4xDQo+ID4NCg==

