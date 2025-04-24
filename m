Return-Path: <stable+bounces-136566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5974A9AC41
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC21D927CB7
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BC22A4D6;
	Thu, 24 Apr 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="o/YEwmOE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1t0Bdli1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B72288CC;
	Thu, 24 Apr 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494592; cv=fail; b=INhl1GiVuRYY70CLhxqK9ZmVpvzTi8+JmbknDg5Susl06ljtvLeEpoDUuCVwqnOE73RcWTmAVXlLtYOJnZvKip02sHNK3fe3+2sx+TrgG3JErCX0xg9DyHRkCIoyPwbYXIjfFXeAR4NxJPMaXbcEylW66i+ooCMaQChvodZOj5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494592; c=relaxed/simple;
	bh=+TrXu6ivVTLyanaeeAQ3xZezsjHaZrKnFWRN2ak+zvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbmcUJupFOUG5z3In3d+Jyn6rkqXwgf8CZWFG6B2Mx24M30E20Guk00L6uFO6vjLrqa69BnZc4haaGxDx5IoHPnqDycvNjCH7RZ7JmbpZFChqesg6+RBgEJf932XExn9kGXtWIhtJUnXF7k4/oDV9bZmjtxnDPdAGHX5l/2IQBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=o/YEwmOE; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=1t0Bdli1; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9TvVs023634;
	Thu, 24 Apr 2025 04:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=loIUfvkF+y/PrznwxjWiiBjOqWWAS6nVATai6z7auUQ=; b=o/YEwmOEwtJR
	EL2ztKHYIVldqpbtkNy1SORncsLpV9MZ5W06msKWcZBzlXyY7VYe0qAjzgGx8f6t
	WP8zYZfsH+frEJBk1VYA/mIc+GGvR2XBjWJTvawnZmmzPk2DGLFDJxkj+IZt8Mof
	v/IBbhmCYO3vyLTYYLQRwYsfD27Cq/wy1D+9JK7zhBQi4dM9IjvleDcRPAACVBqK
	5CHZMNUtqvMhaxvwy3XpCNCgncaNIfEPmMznEApJGcT7e5s3TxnZbE6rCg9CB66c
	YKsRsq1roE+DItXz9Mlczw06+p99r/HlLHNLaG/sKJ1rSgNbcCd2jHqygu7B0vOe
	yYv9woS9Iw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjyqd3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOM1Stpanzpq6dfJCW0inwBIQQTxEQc0EHs/EhMb8B28TZYnvR7VZKcawzd1BLz4u86QH7ZMxrWs8whpSTVBk9ple6YQ7G70x81Ym6nmYEpWFelzRLgbNcWzhnaCLpiN9sIkz7TWzq9Xgil6wA6Uwql4gEhEebZ1Nnvnp3Y40pKgmNviM0v1V/4Yv/ZGWqQkLpaIs2lAvuMzc1kXp7JBhvnQcmVyBqfeCdB6e6nz1M3BQafd64JdGjr/m2++tlm5I1luThiyxqRtIyt7MeMSppGSBzIYMn/CNCTm26Nu9YI0+yapVVr/M7vJKb93hdEayNF2Rya79d6zjJGq+Yk9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loIUfvkF+y/PrznwxjWiiBjOqWWAS6nVATai6z7auUQ=;
 b=LrpL5pPhq95WemnLLH61YzvJ1yw5K2XgR7GFVmME23ZXTXhufl5G0h0caB8WdtnNEmuXaJaSp21lsfxkNlz8RXGxVtw01pA3yc93oipBQRckWD6ImpEegwtwWI74cwXa5oJ/IL+kob9WtONJ9bxbr2BT287vKnCDW1NP1jIvygf3fOqew7hWdiDdwaBO9tfo4QClqd0H2Hga23hAlnSP7Hgh0FTSJYNHw84wavR0cDR0FqoW9UrSyhiwyUcf7iD7GxslneiQXVYny0hN0cAzpU9V65BmHz2/Fn0M2EdqVWFlZfHQL3tFpc0ie1c31RRF72VYc43LrQHXhtNol7TwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loIUfvkF+y/PrznwxjWiiBjOqWWAS6nVATai6z7auUQ=;
 b=1t0Bdli1UPN8Nj/X9DfiNK51RwuamU8OW6VoYYXp0enVIQd0upn0vDd91m2HLzxJaXoSmNu+FhuISj/EEVLWNFWfhjf2RaF1V+ox+IfD0FvBwSRY1ddryCz/a3WUjz/eAvCxKR6mtYgNvD+VcpZdhcw39vNCTzGqOePR5Fljbgc=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by LV8PR07MB10265.namprd07.prod.outlook.com (2603:10b6:408:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:36:22 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 11:36:22 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Topic: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Index: AQHbtEEvQ7zZtKOwf0+ZY/0fGIjH4LOxH2BwgAE2hQCAAC7PMIAAKDZg
Date: Thu, 24 Apr 2025 11:36:22 +0000
Message-ID:
 <PH7PR07MB9538A65E135543B23202757BDD852@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250423111535.3894417-1-pawell@cadence.com>
 <PH7PR07MB9538D15B4511A76BF9EE49DEDDBA2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250424060748.GA3601935@nchen-desktop>
 <PH7PR07MB95384A1319F64B5DA9F04190DD852@PH7PR07MB9538.namprd07.prod.outlook.com>
In-Reply-To:
 <PH7PR07MB95384A1319F64B5DA9F04190DD852@PH7PR07MB9538.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|LV8PR07MB10265:EE_
x-ms-office365-filtering-correlation-id: f3d3d789-a59a-45cd-7989-08dd83243d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vZZgQoTTEZ0/tb3simIUc+hOz6Y21CaF8YwBmNJ9KKwJrFmWWKYqw+KmYYDC?=
 =?us-ascii?Q?oXaNAWZNLsSjGjvvDWz+8HDxov3Uvk5tNXFL+Ysm4J5Vw+pisMa9hwIT+/v5?=
 =?us-ascii?Q?dZxH6UAOvURN8Zo2KcLPAWVomMp0lPt6E8R0Db/abL/FUnZf0DoVQnV9ppXU?=
 =?us-ascii?Q?Iksv781PY52I60Ztp595TgiDWU10O4cJ8T7xNgpEjvEcX2g3jg8taKR0ONgy?=
 =?us-ascii?Q?fJkOhT9xSysmQXUoqdM8f00J33lUO+EtYB0mt78JWPVsRtwV7wPlIT1DmkpA?=
 =?us-ascii?Q?3R06IVrpaY2FY1aeu5xfehY8/nQ7UKhhA17eGk94ngIJ5gH2XR4jKw6qTJxg?=
 =?us-ascii?Q?/gkEOnpTU6wVbRHRMRyPqHMNVS4Sfl4rXESvwTpMJ5ahFZA49geJZRL9vlOs?=
 =?us-ascii?Q?tufIfX2IFEchq1JzYVvw5nEMQ49Jc4nN5oItPc+X1eQPpxAHiWraIxTOR0dD?=
 =?us-ascii?Q?zmePWK49IISq+wxSbXffEEy92R9hhhgOn41uD0VAWhCnbgBSLLMxb46C/dYN?=
 =?us-ascii?Q?kEvl+MtkVy6ZWcEqXXynKit3IEVn0q528RQkezWbLllFw2jHUt2GBSbxdAyO?=
 =?us-ascii?Q?zsCRqtvWvMyNcAskmoB0P9ZwmTMQzfAVnrHjADORQsPNhnMMQ86CfnjkccEF?=
 =?us-ascii?Q?NTDhHYMUlC5miL6Um749M9KsMXmhNAVF4UchzPsJ6IashL8cFtKSKYkToda4?=
 =?us-ascii?Q?TXvm3F/Osg24aQHBcxMMBNXvauWnwcfYNJK7v+FNGSI16rIkA4x1HYyJdDBe?=
 =?us-ascii?Q?lbosbPCJvIPvlDZQmneEkPHAQTV4hFmzO3lXU3az9GS7otaWsOUiJWoEyVTx?=
 =?us-ascii?Q?SmiaICiWd16qkRnBRFUfkjrQYBYsD71AS6O7wab1j6OIreH6M9LRJMdF9oZL?=
 =?us-ascii?Q?KmaHGi6lQ+h1+lO71/re9NY+gAOuVjhG3rnsYTrULcx3DRSNmagxUwhzT4el?=
 =?us-ascii?Q?dt676WWq2tiT5wxRtiHyTG8igngApB+X3DBvM7DkCgCmaaZwwqAnZU8+TKuv?=
 =?us-ascii?Q?S91KM+lMWy8rxLcrGCLXkFqJ3J2geG7Jhjp0QLr4uOGhKYoZC0q5cZicm1/v?=
 =?us-ascii?Q?Pi0zw/oXpI8XFJ9v5CfW5+vz8FKAxWVsbJf1YpjtwwyyznuJ0BxcXDcOdFHY?=
 =?us-ascii?Q?VU8iy3P8eInZMyaUOmW5mcCdExq/55K+x5ujrwRkBAocmyVPu4KVDbm5Mr7W?=
 =?us-ascii?Q?icgg8euhiSklFqKUhnylKiRcssU5EgF3eDMQS4EVhsTFQzUtVGFDVyoGvv9v?=
 =?us-ascii?Q?bn9+2oRXLr73GdMpdMrmyzaVKSyxoZjmuVuiLHZSCgsqlcIh4CFUVrx/fdyz?=
 =?us-ascii?Q?OH3WgIFNbXOQ5Dwe0XRMcvGWjifczy4p5CjVaxF+5tB7MN9vRfApVwrhLMyl?=
 =?us-ascii?Q?0WzgAkzHZVzox3kTtnSuDGQv66KMkcUMGo0drb7i106Mmte2izfxWDk4/su6?=
 =?us-ascii?Q?IL+70KATwwnD094GQ1hmUCD3Y5CZvJJN/kXeTDEA5hCTNfsJPUWAUUkqqu3i?=
 =?us-ascii?Q?IRTr9MjoeCiSGps=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hDGT57Sl3QjuL8GLN4FL5Y/H6SflVwojzv5BTCK3oqXUdv310sv6eGkv22Kv?=
 =?us-ascii?Q?AJWxvvmG3KVDK6nhH/Mrk7nrvMB8Cd1vO2HdzAX12koZkEys6hLpt3wvzbF0?=
 =?us-ascii?Q?+00XebY1VcJXmJu16VaNnmV17pEEe5HQg2q9ax9bx3zZGWk6dOCDNcmud0SK?=
 =?us-ascii?Q?WwvChUgR6xv4az7Bg3F1guHUjvCN3vsdQ2VJr77MDMhOdA8RBMy/HXF7NYhg?=
 =?us-ascii?Q?MLTw47/kH563oIjkSSA+Gpb8VvvcnyLW6R5EPJonb/D+c7695wyoJ8aCeZzC?=
 =?us-ascii?Q?+J37haiGKUtqwbdhzNOyX3T9v8Gofa8b12m/vSgZ7tj+8INTuFUy5wf0icph?=
 =?us-ascii?Q?O0aMkEofatlaRUYPjW0qmq5d+5gY40Htmwf+jrbhEC+7eWn8kEn49edL6lnX?=
 =?us-ascii?Q?kHO4I7XBLKMQ7JqEjXkSVqAtCNoJA7kNSb8x7SmUPGTAAHhgWP18N24wSq6o?=
 =?us-ascii?Q?mA/pUPbf/g+OjC3iZW2rppwX/IixvqOzEcH8wdmRjoNipaEcIc/wTBmnP2fA?=
 =?us-ascii?Q?ocpfcClGpc0cI6p+azY5EYadvBFKwy2LsMrBdhg0xC+68Iq4lwamUUbizOZv?=
 =?us-ascii?Q?Dk7cBFR5EeVi9yjBEJlXJLgzXtqmoBp3SLscv/Xr9WFv21SAVUNKyDYCdxUw?=
 =?us-ascii?Q?mbLousYpvJICfky4hKGqaIXgBgTcLlIwtdSBiOY3oEk9hiOJqMG1AWVfzg/S?=
 =?us-ascii?Q?bSttB5Kvm2T3Bk/yvizQw9k9Nhm1IpEojyzuFLs731CCCZUyjqh0GhHVsXwW?=
 =?us-ascii?Q?37QIKbUccMXG1x0SzrJxtaheEIVeivrBSRSXpqru55TyRc0csNj5pY6Eb3ec?=
 =?us-ascii?Q?SMTebmmVSpevXR0r4EO+T4woVAx1wIFwu1lrpOqizjG2z9NVJgYIdmTEK9ba?=
 =?us-ascii?Q?PVUpoWP2h4NeRXLajKcXNjH2BxUfIUuWyHRpllvlce6ud/2qNLQh8oqYymnD?=
 =?us-ascii?Q?dMIa/2MVAYe7Fdw+V/z7s3kbDS/RIQrZJWVKP7Bg9KieuszD7HZOIzKec8yA?=
 =?us-ascii?Q?hT0GjxbY7WiVrnZJ87xfLYxIolntRJsuxPMgsrewdGyb8l9oGj71TAdYwhhF?=
 =?us-ascii?Q?dL6OQdqZ2gpCYwhx0xis2kR6QKEIzbYkMlCllQdguEqcVHKXVc0Py7hR6cYR?=
 =?us-ascii?Q?BQEF+CxH2/Tze9rR3GXTUcmAOrIJFIEqygq5dcvnmQqJVKqROa/x2GcTUmen?=
 =?us-ascii?Q?rFR65NIobTg86E4WedzegIOPEztcftquj4VstFlOzCOTUaHbNjowPbVKz5bd?=
 =?us-ascii?Q?cTGS8Kb062K3dEx+rupUTqjGD0ARdvoTNlU4iOOGrPKesYUn6/c8logtoYUW?=
 =?us-ascii?Q?HDgCx1AQrAtvF3g/T+4Uuq5Fvf3rqv+i/ueHfjxrp70s4RDy2meHhHyruvUI?=
 =?us-ascii?Q?f254mpTrgw6QjMSkgRChEfecwyftXmqQ4ghT+A4Tz6l5UuCCq9SgiaUt90gC?=
 =?us-ascii?Q?XCDbzRF8SbuUJ6IdRMp4V/lx4QJ1YGLDl3Rp3dhY6DWQ19PGdX79TVviz0VT?=
 =?us-ascii?Q?pik5jZS5jbv/ybDjOQok7oYQypO/03ms/ZCuGlK7hTsRpIsO7X4/q7v5Hkl/?=
 =?us-ascii?Q?POGWwa+pJR9YNoFy5RjY6ZbGqPPuY/kokpsI3usA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d3d789-a59a-45cd-7989-08dd83243d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 11:36:22.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FwzuGey6Q+ibcxRer8TGfVdZSa8YAyQUWf3zwM6X9HfI3YT7ifB00syIhdjUl2Fh7lZuxPzVbryIYFIWX00idPI9nvTW6ATavifnP+noBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR07MB10265
X-Proofpoint-ORIG-GUID: kDfSKdU_vOEHqc1ndGfJTNH2e2b0k2Dy
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=680a2239 cx=c_pps a=Fcp+KkUxEAj3pI5yN7qTmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=1NJvW0vRciHsk7789YoA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NyBTYWx0ZWRfXzXCRXfbP11+2 zdhsg4yyyxDPJfGjzYnG3TQbjYQ1DT0+uXvmjxQ9RFiwPtyzyKA6Rc/fwNgsh7nQOu1t+EAWePS /AV4b7OTvtn7RL6e/o2gsH5imPHKnOArNknWo8HC9ffNKMbErw5NL1mlg7XhVSJm8/3aZKDVixx
 aZPPgEqPjkDgTPJ2L8oC9hyW7XIezbW0DKgMIldI7zYZMqOBX8zW9znAsANMNMffp1Y7GoW6enq riLc0B40AY0QOWE4WGIw1DO72lkEuwT9i5RWsOk/b04hocTWcjXhmXfdk4T+0wKmb0uzgWyS9S+ FrmUNSoO5t+YqROEa+NndY9rCtfHm6dSuXWPFRuCTtC4W2x9Yws9t/6uWr8XrK+XrA46/8hcJet
 0qIFg7I7QvHZ3PB0YxbpqfpqwEk4hGgjKsbOcCcieo1CqeCdtr5Nvf3Rjt4qg+n9sQjUzqlh
X-Proofpoint-GUID: kDfSKdU_vOEHqc1ndGfJTNH2e2b0k2Dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=968 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504240077

>>
>>On 25-04-23 11:43:03, Pawel Laszczak wrote:
>>> The controllers with rtl version greeter than
>>less than?
>>
>>> RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that
>>> controller doesn't resume from L1 state. It happens if after
>>> receiving LPM packet controller starts transitioning to L1 and in
>>> this moment the driver force resuming by write operation to PORTSC.PLS.
>>> It's corner case and happens when write operation to PORTSC occurs
>>> during device delay before transitioning to L1 after transmitting ACK
>>> time (TL1TokenRetry).
>>>
>>> Forcing transition from L1->L0 by driver for revision greeter than
>>
>>%s/greeter/larger
>>
>>> RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this
>>> issue through block call of cdnsp_force_l0_go function.
>>>
>>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>>> USBSSP DRD Driver")
>>> cc: stable@vger.kernel.org
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
>>> drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
>>>  drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>>> b/drivers/usb/cdns3/cdnsp-gadget.c
>>> index 7f5534db2086..4824a10df07e 100644
>>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>>> @@ -1793,6 +1793,8 @@ static void cdnsp_get_rev_cap(struct
>>> cdnsp_device
>>*pdev)
>>>  	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
>>>  	pdev->rev_cap  =3D reg;
>>>
>>> +	pdev->rtl_revision =3D readl(&pdev->rev_cap->rtl_revision);
>>> +
>>>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
>>>  		 readl(&pdev->rev_cap->ctrl_revision),
>>>  		 readl(&pdev->rev_cap->rtl_revision),
>>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>>> b/drivers/usb/cdns3/cdnsp-gadget.h
>>> index 87ac0cd113e7..fa02f861217f 100644
>>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>>> @@ -1360,6 +1360,7 @@ struct cdnsp_port {
>>>   * @rev_cap: Controller Capabilities Registers.
>>>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>>>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
>>> + * @rtl_revision: Cached controller rtl revision.
>>>   * @setup: Temporary buffer for setup packet.
>>>   * @ep0_preq: Internal allocated request used during enumeration.
>>>   * @ep0_stage: ep0 stage during enumeration process.
>>> @@ -1414,6 +1415,8 @@ struct cdnsp_device {
>>>  	__u32 hcs_params1;
>>>  	__u32 hcs_params3;
>>>  	__u32 hcc_params;
>>> +	#define RTL_REVISION_NEW_LPM 0x00002701
>>
>>0x2700?

It does no matter -  0x2700 has not been part of any delivery package.
I will change it to 0x2700.=20
This issue will be fixed in  RTL_REVISION >=3D 0x276E

>>
>>> +	__u32 rtl_revision;
>>>  	/* Lock used in interrupt thread context. */
>>>  	spinlock_t lock;
>>>  	struct usb_ctrlrequest setup;
>>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>>> b/drivers/usb/cdns3/cdnsp-ring.c index 46852529499d..fd06cb85c4ea
>>> 100644
>>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>>> @@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct
>>> cdnsp_device *pdev,
>>>
>>>  	writel(db_value, reg_addr);
>>>
>>> -	cdnsp_force_l0_go(pdev);
>>> +	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
>>> +		cdnsp_force_l0_go(pdev);
>>
>>Pawel, it may not solve all issues for controllers which RTL version is
>>less than 0x2700, do you have any other patches for it?
>
>At this moment, it's the last patch for LPM issues which we was able to de=
bug
>and make fix in driver.
>
>Thanks,
>Pawel
>
>>
>>--
>>
>>Best regards,
>>Peter

