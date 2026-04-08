Return-Path: <stable+bounces-233747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DGBKrm/1Wmi9QcAu9opvQ
	(envelope-from <stable+bounces-233747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 04:38:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 059843B6431
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 04:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371AC3014669
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800B367F5F;
	Wed,  8 Apr 2026 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jrmgdk2F"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44819F40B;
	Wed,  8 Apr 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615921; cv=fail; b=l1WPusdi6mVU30VfAK7fq0SuDNe8zxiw71SmmTPUPxpU6dbnp+1IWt/PUgRpZfDZYjOjky6CD/M7YcVGAM5fGP7ephatRgQ45CH0LIH2NDJoa3dmNYiQoVooaJsFEPZhE2Ya5OM4slvZ0Lbycee8d980KQkq0/CbjjxMX9RXB8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615921; c=relaxed/simple;
	bh=25iinbd9tTH2uiQNIdiAm/aKsrunAtjQDZMkfmsk0eQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pl+ZvwBCGpQ1mwZjFdg2ulvcJi/1sjhOPizwe4vpDPMhyMGYZuH7VAM8O414vJMyS/GcvfFNoNMB6AC9jFdtYeNUn1QCfho+/kJfKh3wvo63qra24CYMehq16ckypl5nvfj+50Cy4pk9xiax56odsiMYA+/RSKPTAa8zGVqubT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jrmgdk2F; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adaOoIP6jvxeISdCW3t68M9UL5GMmXGa90WQomhFFb6aXlxkUCbH9lu57nAb0R7t+AEB1wvDILq8pig0PfMk479vE+QyP/8BqeTetoTBY/QDKImMfi2VpKiw0857ZOuL0F6xTT4I047W3i/bs55Q4hFEcoje+3XOT+9VcnlpVAB+DKHKbN2Gt+LqpYh0YeWprdCEKd+KIIGvxS0JlM+TEgfrUifX+SeyoSXiMLbgHU2qMTlkewjVLEIiwpTt8PYExR6OVO3Haqme5ll/AZ8Ksp3l31DCWZ0rtj5bo21/9JebRx81gFa5hP0iisXN/8tapckrMz3+nNcPJJpwkV9eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25iinbd9tTH2uiQNIdiAm/aKsrunAtjQDZMkfmsk0eQ=;
 b=u2dKKoTRydX9YQs7NiKHzSJNXUp5VCT98i7IB6QG6iqwG83SNxMRig4H0ITYg7FQSoAvtNttGz9EhMD9Mth8g3TMHbDz63Mrc7ZFRfEul0UZxQhEG4rcBpUNmuGtfo1937vsVwj99bEcHdTL/UmNjoVrpmo9mm2x5F/vcnp4tcr4Qsxv0m6N2qYG7DvOXciskHnFjeXdQxF0tl+Tb2RKM+7HZUfu18oHJx+vc7SY8C8wYqTTUgMdEj3gfzhtTVI9StcceMB9UXDjNiMe+8mVcbo1buMzmx5nnIZ1qkbbypKhXTiH0/HFo/RX5pSK5HSGRIKfAS8iaflfljkEERwPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25iinbd9tTH2uiQNIdiAm/aKsrunAtjQDZMkfmsk0eQ=;
 b=Jrmgdk2FiCVjLL/LUWlkTPnGjH1KDjuVaSqakEzSvUUjyI/aPePNHpoM7aEg1KUCv/LfsvNhyf+VfbeO7aIsr21RGvNVRiu5vbzJGb2NRx/g6hBc+7a4JBGI3ZaU4ceM+zpZn9vIozPWoUUy5VmBUDyQ5rb21sMOsYN0lv3935G/boYCX18eTH4JnelmRDIhoGRiav+K4e6Ua6pnCVD+TwSQWdAL5rHlX+1UYtAzxhdqF7XEZJmovEwxauTu0auFSwoWu3jXGzdiBnYfCfaSNH8UDyXlFggbBUEbpONbqHsjPJ2tQXvodysX4JnfNC4nhWjyqvc0gRNrh8bwufSRXQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS1PR04MB9681.eurprd04.prod.outlook.com (2603:10a6:20b:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 02:38:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 02:38:36 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "mani@kernel.org" <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Topic: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Index:
 AQHctdXR4rMaQwHMbk+Nxv/9or4V47Wy+e2AgACXyCCACSXqAIAAPoUAgBC1qACABVGiIIAAVfmAgAExgtA=
Date: Wed, 8 Apr 2026 02:38:35 +0000
Message-ID:
 <AS8PR04MB883374CBFD3C97CE54DFB4C48C5BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260323220858.GA1084506@bhelgaas>
 <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <y76fzvju42srykr3khio2bx5lmzusy6iasodvs45imis7fw3b5@wjv3gsocj534>
 <AS8PR04MB8833C20B6FF92F96EE7641E38C5AA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <ihoprlijtwgihkbmszm53iftvpyg7ljvubs3bv2lt22uma74ul@zqgulwmj4jpb>
In-Reply-To: <ihoprlijtwgihkbmszm53iftvpyg7ljvubs3bv2lt22uma74ul@zqgulwmj4jpb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS1PR04MB9681:EE_
x-ms-office365-filtering-correlation-id: 9cbc5681-16ca-429b-b48d-08de9517ef13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ioPbp/oDdgtJlnlhz+rF9a+DuTFkuRWkc/VEN1WFBuoETvrfKqyFhkbUZFZApk/D0AdEwfTeCGWIkeYovI+q+9U7P9WyCLjrdP589i47qxWh0ps4nOgtxNUDHfn85sPkBF/4GuBZVSBbjLsBEyMFaFqvhw6595E7606bJwEklD//D4mnD3MNSE0wqwCLtR91g1Tb0S8QkKFHUO+ieYAN+rtTyRcwxEnD0NOTU47hThD6bLU/vTUoD7hqIrxJb3ZC2DK9Bsb6faUbOHk/64OK6cOPcfFJXRq/qmoiiEj/NJ+vO83UyjR1tPUmFg/aPLRXgC5TDrmxggRl7iNTsrbZSnJ/LfnKOVrOs2/xe1GKwUAKuQZwiich/DqNccsmvCyCOSDEFD17FYe0nKy2+o+iV6K3MXo/26Igv+Ch4vJHfwO0icWr7h1jY5vUJNjUJmBAT8wJb2Hx+SZ5XXWGss9b+lTRgPi1aF9/vpI4SqWyZiUiwm2gsEbf+QKUAYw5gi5mWlt1dyH2yCx2OhkQPOC76YB6sbpL3GVUF2avYZOeuqw+hMkw7eZ2KD69g/CzKNj+pKtj8qspF55ej+RVG9JO0VNG4lgb5qltmFRcjOLYn29rD0yxeyPSFzCQmZzs0MbZOV4qfVT96LXq8YPdmjoT9STBxEtxWiYvRPEyQiTPZRcU8ZWsjEDv96ORkGrV4r/SXASoO86HY9Sd2cwHz+40g2rrbZRcVxU6N9o/guRYLuE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmNJRnpOd3AwbjBkSFcxaUpJUWJHWUs0R24zNE45TWRHWlpXcmZmUTBYL1Nh?=
 =?utf-8?B?OEJkVjQ0MUV2Z3VEbXRUYVYra2dJcDljTnJlUkxFUXdHaGlYUG5aUU1NTUsx?=
 =?utf-8?B?K1VUUlVDVU5KWDFQdlJZYjk2SzBjdnkycEFic2ZwU0FEQmR1YmxJMWpud2FG?=
 =?utf-8?B?MEZCZFcrNU5lNGJwUVlIQ2dLNTRGcWIySmlpWFppTm9IT01vVGV6dVdTSGp6?=
 =?utf-8?B?TWVQdGZucW9RRERKc1p0OERaNXZ2WEQ5cmxEL0g0OXVoOGFsbHRuMUlzSWVa?=
 =?utf-8?B?MFV4VUtwUm95cFVpeUNsZnMwaDRaSUtreXN0RG8xOTFvMDhWbWlRZFA5NFVT?=
 =?utf-8?B?QnBnWng4ekFNV1JxYlpEMVZmQTlPNGxWb1Rmdi84c0FBazJBOUdiamF6REhQ?=
 =?utf-8?B?SmlPT3hSWEJLVGxnbTdIcWxjZkNLSEpIaGVsY1lhZkI2QU1QNXczdk5GblJt?=
 =?utf-8?B?Qmx3Y2Zpd3VrczdRdml2ZlVJQnIyWW9LcHVUZllrbGZkUVBUVDFSellmajNv?=
 =?utf-8?B?Ly9MZkJROEZSN0lnNEh6QlV0U0hubVpzNi9VOVBRMnV6cGFOajFtSEh2U3FE?=
 =?utf-8?B?ZzhWR3RDQW1vSkRsa010NW5Dek14bkwwNVVZdU9BdTZXeHNJM3VHS0szdng5?=
 =?utf-8?B?TXluK1BSK205Ymc1UHZITDlYS1BLTTVLZmdMMzAyZzFpV3BMZEZ2QU5HeTFl?=
 =?utf-8?B?ZzcxakVBWXdLMHFKUVdxY2o0YW1rQ29wWXNjV214L3JlbXpRYTYrN0ZBVnZk?=
 =?utf-8?B?cVFWMmx2Ly9WcUJhWnlKZS96ZVBCSUZYNTgxZzZwSWNqTTBuZEpIMlNZaEZN?=
 =?utf-8?B?SmpBNVBBS1FzUC9zWlBHeld5cjBXVDRnaFg2Q0M2VjBiZG1rbldpcHNhaXFH?=
 =?utf-8?B?ODlOYmE1cEJEdWJPSkxiWkE2Qm92eFJSZGxTL2p4bHUzYnNFalFNaTRuVFJ2?=
 =?utf-8?B?RlBNRWhORis4OS9rcnh2V2pjUGpTQnV3dFRTQzN4ZmZ4ZUd5Zk4rTVNTOUI1?=
 =?utf-8?B?NWd5VnI3eVozZDMraGpYTmdkZ2JMSGpvR0w5dmN3dWFYU2F0Q3NTaFNmRmJ6?=
 =?utf-8?B?dlBqOXl0WjZIdHI2b3FjbTdvZ3BreGtLeVhDNzlmUWRSZ3o1Q3lCVFNuOHFT?=
 =?utf-8?B?cEtFNXVTdlVyVEltZXJsQXE5bG03aFVTa2Y4bG9WUEpPY1VUZk5WcWZxQzdI?=
 =?utf-8?B?c2JiLzJOTUNGbTJHN2VXZzZuOUR1YlI4OFRXb2lwVVFNUzlsUjlWS3FXNTVv?=
 =?utf-8?B?dEdNUmpLVndJeGVzUHFCdDhwejNDckZlajFoQ3NFeFBpTFY3NlZNQkJJeDVP?=
 =?utf-8?B?VHo3bGR0V0N1dVVkNXFhWHl5V1VKUk9jSUFRMXJYVGIrSTQyaEZ2VDQ2b3Zp?=
 =?utf-8?B?dHJlMFU3cEcwUXhtLzN5UjlZdkhSZmhmbnlmdHNmR1Y2RW0rVjBwbTcwVGlm?=
 =?utf-8?B?N1A3amZ3Wkg5VlRLVXA5RVFvUUo4clA2bU41OGxTV1ArcXd3dmg3TmdlZ1Ix?=
 =?utf-8?B?QkJ6WGpURW01SWFoSTIvbnhCRllOYUdOT2VJdmd1NEM3TFNxS0tJbnBmTksr?=
 =?utf-8?B?enlZZEtTQzFWUEl4TkhqMVdjMFN5K1NoUjhLWHd6eHQrb2NDdEZMc3dUQm9i?=
 =?utf-8?B?eEZnL0M3VUpDeUZuMVVUazBDZU90NVpnd2VRMk9RNG1zdFgybVFSY01UZXRJ?=
 =?utf-8?B?SmhQZTc0U2h4V0lraHdEeVhBRWJhOEdZaEJGTlZQM3dzY0hQcSsyR1poa2Ex?=
 =?utf-8?B?bGRWMXMvTDcvS2xSVHZqWVd6bVhRR1JFMk9lMmNCeGU3VWZWcUlhaUxNcmNE?=
 =?utf-8?B?dUdYNnkzZmNMdStCTTg0Tmt3NStBRVN2Y3VmbHZIdmxodjh5T3FKaUNETVlz?=
 =?utf-8?B?V1JEYnZxQlAvWnZCL3NFMTBZOGhybGRVTlNaa3YwMHNoNCthQU9EYU4rWkRI?=
 =?utf-8?B?Ylp2SzVMOUVJUDl5ekRoZ1VMWkJDbjRwQWYrVFg1UnNxMytTSWI3QzA4akpU?=
 =?utf-8?B?amlXTW1OQWxDRjRFbmt0OWpsMkV6SWp6NCs1RGNQSmZ0NDlsbVlLKzA4QW82?=
 =?utf-8?B?cW1XN09CVnkzb3ZQNEZDaTN5ZXFIR2ZtM1hCK2J2Q3lNUnI5c2pDL0t1dmgy?=
 =?utf-8?B?d3MrNXdrWm4vMko5SXRMNkFUbUE5ZnV5clFwRFVoYTVFQ0RBcUJOcWtvcHhs?=
 =?utf-8?B?WU9rdHUwQ2puUXJCT2J4RGdzQW1UY2kzbE9tMkNjNjlaRUpRSFVuK3FDVUpy?=
 =?utf-8?B?RmRyd2svZ1g5RTlWcStUUkFyeWJNbUFwU2xESzdTWTRKUUpLWkpCaWNnSG9N?=
 =?utf-8?Q?j8ey793QsQBtUuKqc3?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbc5681-16ca-429b-b48d-08de9517ef13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 02:38:36.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iMGP4LANaC7/F6iueB4GPQmTSoPSUDFeX/TLl3KEquZdaqHxITUgSZOzv6tZEsWb1VOjhB9XbGvoTfijj+Bcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9681
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233747-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,pengutronix.de,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 059843B6431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBtYW5pQGtlcm5lbC5vcmcgPG1h
bmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDTmnIg35pelIDE1OjI0DQo+IFRvOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVs
Z2Fhc0BrZXJuZWwub3JnPjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBqaW5nb29o
YW4xQGdtYWlsLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwu
b3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFz
QGdvb2dsZS5jb207DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5k
ZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBpbXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBm
bGFnIHRvIG92ZXJyaWRlIEwxU1MNCj4gc3VzcGVuZCBza2lwDQo+DQo+IE9uIFR1ZSwgQXByIDA3
LCAyMDI2IGF0IDAzOjMxOjU3QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBtYW5pQGtlcm5lbC5vcmcgPG1h
bmlAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjblubQ05pyINOaXpSAxOjAzDQo+ID4gPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENjOiBCam9ybiBI
ZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+ID4gPiBqaW5nb29oYW4xQGdtYWlsLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOw0KPiA+ID4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgcm9iaEBr
ZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiA+ID4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MV0gUENJOiBpbXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBmbGFnIHRvDQo+ID4gPiBv
dmVycmlkZSBMMVNTIHN1c3BlbmQgc2tpcA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgTWFyIDI0LCAy
MDI2IGF0IDAyOjAxOjU4QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IEJqb3JuIEhlbGdhYXMg
PGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiBTZW50OiAyMDI25bm0M+aciDI05pelIDY6
MDkNCj4gPiA+ID4gPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4g
PiA+ID4gPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWls
LmNvbTsNCj4gPiA+ID4gPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5l
bC5vcmc7DQo+ID4gPiA+ID4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3Jn
OyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsNCj4gPiA+ID4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3Rl
dmFtQGdtYWlsLmNvbTsNCj4gPiA+ID4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiA+ID4gaW14QGxpc3RzLmxp
bnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBp
bXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBmbGFnIHRvDQo+ID4gPiA+ID4gb3ZlcnJpZGUgTDFTUyBz
dXNwZW5kIHNraXANCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFdlZCwgTWFyIDE4LCAyMDI2IGF0
IDAyOjU1OjQ1QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2Fh
cyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+ID4gPiA+ID4gLi4uIFttZXNzZWQgdXAgcXVvdGlu
Z10NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAwMjox
Mjo1NlBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBBZGQgYSBm
b3JjZV9zdXNwZW5kIGZsYWcgdG8gYWxsb3cgcGxhdGZvcm0gZHJpdmVycyB0bw0KPiA+ID4gPiA+
ID4gPiA+IGZvcmNlIHRoZSBQQ0llIGxpbmsgaW50byBMMiBzdGF0ZSBkdXJpbmcgc3VzcGVuZCwg
ZXZlbg0KPiA+ID4gPiA+ID4gPiA+IHdoZW4gTDFTUyAoQVNQTSBMMQ0KPiA+ID4gPiA+ID4gPiA+
IFN1Yi1TdGF0ZXMpIGlzIGVuYWJsZWQuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiBCeSBkZWZhdWx0LCB0aGUgRGVzaWduV2FyZSBQQ0llIGhvc3QgY29udHJvbGxlciBza2lwcyBM
Mg0KPiA+ID4gPiA+ID4gPiA+IHN1c3BlbmQgd2hlbiBMMVNTIGlzIHN1cHBvcnRlZCB0byBtZWV0
IGxvdyByZXN1bWUgbGF0ZW5jeQ0KPiA+ID4gPiA+ID4gPiA+IHJlcXVpcmVtZW50cyBmb3IgZGV2
aWNlcyBsaWtlIE5WTWUuIEhvd2V2ZXIsIHNvbWUNCj4gPiA+ID4gPiA+ID4gPiBwbGF0Zm9ybXMg
bGlrZSBpLk1YIFBDSWUgbmVlZCB0byBlbnRlciBMMiBzdGF0ZSBmb3IgcHJvcGVyDQo+ID4gPiA+
ID4gPiA+ID4gcG93ZXIgbWFuYWdlbWVudCByZWdhcmRsZXNzIG9mIEwxU1MNCj4gPiA+ID4gPiBz
dXBwb3J0Lg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRW5hYmxlIGZvcmNlX3N1
c3BlbmQgZm9yIGkuTVggUENJZSB0byBlbnN1cmUgdGhlIGxpbmsNCj4gPiA+ID4gPiA+ID4gPiBl
bnRlcnMNCj4gPiA+ID4gPiA+ID4gPiBMMiBkdXJpbmcgc3lzdGVtIHN1c3BlbmQuDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEknbSBhIGxpdHRsZSBiaXQgc2tlcHRpY2FsIGFib3V0IHRo
aXMuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFdoYXQgZXhhY3RseSBkb2VzIGEgImxv
dyByZXN1bWUgbGF0ZW5jeSByZXF1aXJlbWVudCIgbWVhbj8NCj4gPiA+ID4gPiA+ID4gSXMgdGhp
cyBhbiBhY3R1YWwgZnVuY3Rpb25hbCByZXF1aXJlbWVudCB0aGF0J3Mgc3BlY2lhbCB0bw0KPiA+
ID4gPiA+ID4gPiBOVk1lLCBvciBpcyBpdCBqdXN0IHRoZSBkZXNpcmUgZm9yIGxvdyByZXN1bWUg
bGF0ZW5jeSB0aGF0DQo+ID4gPiA+ID4gPiA+IGV2ZXJ5Ym9keSBoYXMgZm9yIGFsbCBkZXZpY2Vz
Pw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZyb20gbXkgdW5kZXJzdGFuZGluZywgTDFTUyBt
b2RlIGlzIGNoYXJhY3Rlcml6ZWQgYnkgbG93ZXINCj4gPiA+ID4gPiA+IGxhdGVuY3kgd2hlbiBj
b21wYXJlZCB0byBMMiBvciBMMyBtb2Rlcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJdCBj
YW4gYmUgdXNlZCBvbiBhbGwgZGV2aWNlcywgYXZvaWRpbmcgZnJlcXVlbnQgcG93ZXIgb24vb2Zm
IGN5Y2xlcy4NCj4gPiA+ID4gPiA+IE5WTWUgY2FuIGFsc28gZXh0ZW5kIHRoZSBzZXJ2aWNlIGxp
ZmUgb2YgdGhlIGVxdWlwbWVudC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsbCB0aGUgYWJvdmUg
YXBwbGllcyB0byBhbGwgcGxhdGZvcm1zLCBzbyBpdCdzIG5vdCBhbiBhcmd1bWVudA0KPiA+ID4g
PiA+IGZvciBpLk1YLXNwZWNpZmljIGNvZGUgaGVyZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiBIaSBC
am9ybjoNCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIGtpbmRseSByZXZpZXcuDQo+ID4gPiA+IFll
cywgaXQgaXMuDQo+ID4gPiA+ID4gPiA+IElzIHRoZXJlIHNvbWV0aGluZyBzcGVjaWFsIGFib3V0
IGkuTVggaGVyZT8gIFdoeSBkbyB3ZSB3YW50DQo+ID4gPiA+ID4gPiA+IGkuTVggdG8gYmUgZGlm
ZmVyZW50IGZyb20gb3RoZXIgaG9zdCBjb250cm9sbGVycz8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBpLk1YIFBDSWUgbG9zZXMgcG93ZXIgc3VwcGx5IGR1cmluZyBEZWVwIFNsZWVwIE1vZGUg
KERTTSksDQo+ID4gPiA+ID4gPiByZXF1aXJpbmcgZnVsbCByZWluaXRpYWxpemF0aW9uIGFmdGVy
IHN5c3RlbSB3YWtlLXVwLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBkb24ndCBrbm93IHdoYXQg
RFNNIG1lYW5zIGluIFBDSWUgb3IgaG93IGl0IHdvdWxkIGhlbHAganVzdGlmeQ0KPiA+ID4gPiA+
IHRoaXMgY2hhbmdlLg0KPiA+ID4gPiA+DQo+ID4gPiA+IGkuTVggUENJZSBwb3dlciBpcyBnYXRl
ZCBvZmYgZHVyaW5nIHN1c3BlbmQsIHJlcXVpcmluZyBmdWxsDQo+ID4gPiA+IHJlaW5pdGlhbGl6
YXRpb24gb24gcmVzdW1lDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSXMgdGhpcyBhbiB1bmNvbmRp
dGlvbmFsIGJlaGF2aW9yPyBXaGF0IGlmIHRoZSBQQ0llIGRldmljZSBpcw0KPiA+ID4gY29uZmln
dXJlZCBhcyBhIHdha2V1cCBzb3VyY2UgbGlrZSBXT0wsIFdPVz8gQW5kIGlmIHlvdSBjb25uZWN0
DQo+ID4gPiBOVk1lLCB0aGlzIGJlaGF2aW9yIHdpbGwgcmVzdWx0IGluIHJlc3VtZSBmYWlsdXJl
IGFzIE5WTWUgZHJpdmVyDQo+ID4gPiBleHBlY3RzIHRoZSBwb3dlciB0byBiZSByZXRhaW5lZCBp
ZiBBU1BNIGlzIHN1cHBvcnRlZC4NCj4gPg0KPiA+IFllcywgdGhpcyBpcyB1bmNvbmRpdGlvbmFs
IGJlaGF2aW9yLiBUaGUgaS5NWCBQQ0llIGNvbnRyb2xsZXINCj4gPiBleGNsdXNpdmVseSBzdXBw
b3J0cyBzaWRlYmFuZCB3YWtldXAgbWVjaGFuaXNtcywgd2hpY2ggb3BlcmF0ZQ0KPiA+IGluZGVw
ZW5kZW50bHkgb2YgdGhlIFBDSWUgbGluayBzdGF0ZSBhbmQgZGV2aWNlIHBvd2VyIGNvbmZpZ3Vy
YXRpb24uDQo+ID4NCj4NCj4gSSBiZWxpZXZlIHlvdSBhcmUgcmVmZXJyaW5nIHRvIFdBS0UjIGFz
IHRoZSBzaWRlYmFuZCB3YWtldXAgbWVjaGFuaXNtLiBJZiBzbywNCj4gYm90aCBob3N0IGFuZCBk
ZXZpY2UgaGFzIHRvIHN1cHBvcnQgV0FLRSMuDQo+DQpFeGFjdGx5Lg0KDQo+ID4gRm9yIGRldmlj
ZXMgY29uZmlndXJlZCBhcyB3YWtldXAgc291cmNlcyAoV09MLCBXT1csIGV0Yy4pOiBUaGUNCj4g
PiBzaWRlYmFuZCB3YWtldXAgcGF0aCBieXBhc3NlcyB0aGUgc3RhbmRhcmQgUENJZSBwb3dlciBt
YW5hZ2VtZW50LCBzbw0KPiA+IHRoZXNlIGNvbmZpZ3VyYXRpb25zIGRvIG5vdCBpbXBhY3QgdGhl
IGkuTVggUENJZSBSQyBjb250cm9sbGVyJ3MNCj4gPiBzdXNwZW5kL3Jlc3VtZSBiZWhhdmlvci4N
Cj4gPg0KPg0KPiBPbmNlIHVzZXIgZW5hYmxlcyB3YWtldXAgZm9yIGEgZGV2aWNlLCBQQ0kgY29y
ZSB3aWxsIGNvbmZpZ3VyZSBQTUVfRU4gb25seSBpZg0KPiB0aGUgZGV2aWNlIHN1cHBvcnRzIHRv
Z2dsaW5nIFdBS0UjIGZyb20gRDNDb2xkLiBTbyB0aGUgd2FrZXVwIGZ1bmN0aW9uYWxpdHkNCj4g
ZGVwZW5kcyBvbiBkZXZpY2UgdG9vLCBub3QganVzdCB0aGUgUkMuDQo+DQpZZXMsIHlvdSdyZSBy
aWdodC4NCg0KPiA+IEZvciBOVk1lIGRldmljZXMgd2l0aCBBU1BNOiBXaGlsZSBOVk1lIGRyaXZl
cnMgdHlwaWNhbGx5IGV4cGVjdCBwb3dlcg0KPiA+IHJldGVudGlvbiB3aGVuIEFTUE0gaXMgZW5h
YmxlZCwgdGhlIGkuTVggaW1wbGVtZW50YXRpb24ncyBzaWRlYmFuZA0KPiA+IHdha2V1cCBtZWNo
YW5pc20gb3BlcmF0ZXMgdGhyb3VnaCBhIHNlcGFyYXRlIHNpZ25hbGluZyBwYXRoLiBUaGUNCj4g
PiB3YWtldXAgZnVuY3Rpb25hbGl0eSBkb2VzIG5vdCBkZXBlbmQgb24gbWFpbnRhaW5pbmcgUENJ
ZSBsaW5rIHBvd2VyLA0KPiA+IHRodXMgYXZvaWRpbmcgY29uZmxpY3RzIHdpdGggTlZNZSBwb3dl
ciBzdGF0ZSBleHBlY3RhdGlvbnMuDQo+ID4NCj4NCj4gVGhlcmUgaXMgbm8gcmVsYXRpb24gYmV0
d2VlbiBXQUtFIyBhbmQgTlZNZS4gTlZNZSBpcyBhIHBhc3NpdmUgZGV2aWNlLCBzbw0KPiBpdCBk
b2Vzbid0IHN1cHBvcnQgV0FLRSMuIFdpdGggdGhpcyBwYXRjaCBhbG9uZSwgdGhlIE5WTWUgZHJp
dmVyIHdvbid0DQo+IHJlc3VtZSAoaXMgQVNQTSBpcyBlbmFibGVkKS4gWW91IG5lZWQgdG8gdGVs
bCB0aGUgTlZNZSBkcml2ZXIgdG8gcGVycGFyZSBmb3INCj4gcG93ZXIgbG9zcyB0b28uIE1heWJl
IHRoaXMgcGF0Y2ggY2FuIGhlbHAgeW91Og0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3Jn
JTJGYWxsJTJGMjAyNTEyMzExNjIxMjYuNzcyOC0xLW1hbml2YW5uYW4uc2FkaGFzaXZhbSU0MG9z
cy5xdWFsDQo+IGNvbW0uY29tJTJGJmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5j
b20lN0MwNzc5ZjIwZDAyDQo+IDM3NDQwZTdhY2MwOGRlOTQ3NmIzNjglN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlNw0KPiBDMCU3QzYzOTExMTQzNDcxMTg0MDk2NCU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjDQo+IEdraU9uUnlkV1VzSWxZaU9pSXdM
akF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJag0KPiBveWZR
JTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1SNmZEZU1qUCUyQlgzbjVMQ1lGZkhJJTJGZjgwTXM4
DQo+IDY0Z2VNUUgyREdnZzA1ZkElM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBCdXQgdGhhdCBwYXRjaCB3
aWxsIG9ubHkgaGVscCBpZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIFMyUkFNIHRocm91Z2ggUFND
SS4NClRoYW5rcyBhIGxvdCwgdGhpcyBwYXRjaCBpcyBoZWxwZnVsLg0KU2luY2UsIGkuTVggcGxh
dGZvcm1zIHN1cHBvcnQgdGhlIFMyUkFNIHRocm91Z2ggUFNDSS4NCg0KT25lIGFkZGl0aW9uYWwg
bm90ZSByZWdhcmRpbmcgTlZNZTogQVNQTSAoQWN0aXZlIFN0YXRlIFBvd2VyIE1hbmFnZW1lbnQp
IGlzDQpkaXNhYmxlZCBsb2NhbGx5IG9uIGkuTVggcGxhdGZvcm1zIGZvciBOVk1lIGRldmljZXMu
IFRoaXMgZGVjaXNpb24gd2FzIG1hZGUNCmFmdGVyIGVuY291bnRlcmluZyBhIHN5c3RlbSBoYW5n
IGlzc3VlIHNpbWlsYXIgdG8gdGhlIG9uZSByZXBvcnRlZCBieSBIYW5zIGENCmZldyBtb250aHMg
YWdvIGluIGhpcyBwYXRjaCBsaXN0ZWQgYmVsb3cuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1udm1lLzIwMjUwNTAyMDMyMDUxLjkyMDk5MC0xLWhhbnMuemhhbmdAY2l4dGVjaC5jb20v
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4NCj4gLSBNYW5pDQo+DQo+IC0tDQo+IOCu
ruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

