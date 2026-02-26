Return-Path: <stable+bounces-219851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI53OzajoGkvlQQAu9opvQ
	(envelope-from <stable+bounces-219851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:47:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DB1AEA0D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7E63017002
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEBE4534B9;
	Thu, 26 Feb 2026 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="nDLxxU00";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="GMic9J0/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC2355F58;
	Thu, 26 Feb 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134842; cv=fail; b=aj6QLzfe1D7KKuRto+OS2BgIwfKAWEe7/SNjUiMsjxpgBGeaXEh9bGfRg+WurwHkFA8m7384i8N3eUkt/yyRQvdRr/3SH5/G8HB4Vqyf8XZx9dRmmG+tzgywMMb4N1x0fxX0RBwApD0UG1EueF2K2V/GUnIQAxF6gNSgwWe9h8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134842; c=relaxed/simple;
	bh=dTKZVj57yixkE0jP7fh98PsP/weB6Fh8c4hTw1Hxv5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lV6pQPU2p4kvksOrck36BFpoYcR3gi29pfm+j05T0qudbWNHTAK2yVqdUQJ2fvinOAiyvevplQXTKBRaFyumSoORwOzlN77t6jibE9LRUUqSHo76q1eeuglyTR8qzSnCK9SQ75uRG5YNVhAy/ZV8YUeU8mF9Fdixs0gVMb7+wr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=nDLxxU00; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=GMic9J0/ reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108157.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIY1cu1962258;
	Thu, 26 Feb 2026 11:40:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=GieWXKrVfAqtmouIyUNTG3PfIA48zKgUDIrTzDmr4Nk=; b=nDLx
	xU009GilvFxVmbgIEqNc4LrbXFNHXYGDrB/zyqnXVPFc9RjvYkZNqcs90yCtqMvB
	uC9WwuNmxjkeEt8BWR9IGvAIhxG96cYWT47W9/8yDfThYekPxOUX+FY3SITX+OnY
	UGoLLi4o8/WGeciawfqpf7rwQ8vuCXZzv4yuXhWilJGZWtvCovYPvJ7E/CN7KCRZ
	jDAg0QtkM7+3YtHtHM0IGrdCTJUO02mdNAiU/oTvz8CyQpwOpA/h4dOqsOCrzKG+
	Bg5FDsy+3Jfkn+IrMljVRSmdBqNQk5kQ/jGd/7JUVqNmlvjWHidRx1mNsEIFBc/D
	SY7LXaEjNLAu7une/Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 4cjgnnk9s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 11:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKJg1tZnnMeJzjxa6e/jOzk8Z+tSD1n4yb8vHkMKfYDnRwLeI4JBK5q/WESjXKxHVDVjKcqsjW/MrgPPe7RJaZhDICS1rnk6jV0TL9cp5cs6X8uHT7Y6IVX5fm0sF6N0BwLMs6snCs+HV1HKjiIxiqJrXYpqafIYZDJo0MSS9V/yFrBIVtg6oMFaDB7H7/implY7qSDPctZRaji7rSLeoVFnWCSWgrOcv+q3IS0Ky+QkSfLGAcl26/9u2kRP8U85HMyk6AOaKnMFsnbCo8B1SgQyWMGpoIgLtRh6KhN37YAt8/C5OpSCrvOLiLgof3IsSV3aL1tLka4hvPk99OPe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GieWXKrVfAqtmouIyUNTG3PfIA48zKgUDIrTzDmr4Nk=;
 b=j7TUtBEDmNNqUGVKFK6K9bELL4XiOI7dmMQ6NzC/kFnIMmX1FZ/RCWOI2ykXTIdo5+BgSDGn5fBlMuTDuwU7dR9kp7DUEUAm7uaT24LCFobzak4BaWVp1fIVkGwy6E30F1yRmKG9y4CD61HSw/Zv2D+f7lQs/g3gC4eGa/pzlRVhrDvDspNV45i2JDE08ZLcOtJcmh1H0Bu+f7GfgYlR5e5z0aePqozodE+TwQzDoZDHR88I1HCFoxRkRFt//YJ4/L3lX20rLqGJsVYNCfeNn3pVdexLsW1xD1dvk0AlttfBJG9ocC8NRq+XgyDMVWiMOA+0ZXdraiGKjxO8MaYwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GieWXKrVfAqtmouIyUNTG3PfIA48zKgUDIrTzDmr4Nk=;
 b=GMic9J0/RAzcgj7YgI47jpLLS4wjgOmSze/9dby77OTf4hsVnPzqLa2kTn2nm0LnScoJ6HUPfC2y8+CXe96SSNbTQK5q16R6sg5p1C67973IuN+y71rA1+I/Jm1Ss0sInhbtAoP4w4JdezUQkVMsfFUJ0+JWFxO3qsINQXVxy6c=
Received: from SN7PR05MB9749.namprd05.prod.outlook.com (2603:10b6:806:346::14)
 by PH0PR05MB7831.namprd05.prod.outlook.com (2603:10b6:510:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 19:40:30 +0000
Received: from SN7PR05MB9749.namprd05.prod.outlook.com
 ([fe80::a972:b867:f007:4344]) by SN7PR05MB9749.namprd05.prod.outlook.com
 ([fe80::a972:b867:f007:4344%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:40:30 +0000
From: Brian Mak <makb@juniper.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Thread-Topic: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Thread-Index: AQHcpq1xqdkfgwy+1US+LCdpxjnE1LWUlXMAgAADPQCAAMlvgA==
Date: Thu, 26 Feb 2026 19:40:30 +0000
Message-ID: <E3EAF942-9F00-4214-9411-1B3612C8C3BF@juniper.net>
References: <20260225232105.454931-1-makb@juniper.net>
 <aZ_18m0gYBDEpSlt@smile.fi.intel.com> <aZ_4qqZCnpMKD_5q@smile.fi.intel.com>
In-Reply-To: <aZ_4qqZCnpMKD_5q@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR05MB9749:EE_|PH0PR05MB7831:EE_
x-ms-office365-filtering-correlation-id: c81a9bbc-b7bb-42a3-413d-08de756ee638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 xhG0n9BY8ytT6iIvIA7Byaif7Z5IDf6VLtnUHQPce8/Ls4vxtAG0fmpHExbbfohVUlXdZHxmhvfgsrnLnCBreyBiT/Y5ZQ/bYUwurLyvDSAWmtB6VAU5Gy96a3Dyy5MGoOtleLNJ+mm6GZnvBtnkhk0EPLac4THmdXAb+9rv1y8QdkbjvY4czCbBsUdL+ljcOEk1pJBoStJ/QmSrFypsEMvDLCcSAlU5qMZlwm97uvYDiaLo+sGdSbXMOPPO7hqP0wH6FGPZz4be/JoiaZxGYUya7BIfce2cUWKJdcOO7Sy2SyAC4AooWRZ9tptP8ELsXZ0fNzsmOgrz+u+y2v2T7clqYaIlwgzKx9VYH15/IbxacKurWLQ3gw/JN1sTJEEyEEC8w9RVoGnNXZNoin0/Gc8JT1QHRxRPQ2q+7pBvzmZ+iLYWVJWXTUCyJE7cj1lqSA0HoXN1d8PfADcBbxKmB9iLLpBEfSD73zLJ+VzxgZQCktkgmrzIl/36+uq99iZtOowhGqQ+VIOsL5T6wsmUXmya5vA4DVKsFj4V5yR2yFswIaeY7d3tsh/8uPEzViRUvNOQ4/DUNB73dhqgJV1ZOtK9/JJkOVPLWj6dPTUfrfprpAPzrlcu/a8lz4g6S49ikUWdUv3vdMLWjWnKonwme3NFzpM6Y7ca+pIijb3SYM++EtTo71gNxOsaaaUOClgz4h+/otqq1rI45XLIMELg+jEMLcFBLCTJBJO938EbDRr2omKNBF1wxCXNTP5zgRPAwHib/YgMNj6nxDKRB2J5ID5AAGzJuC9UfALA/rR6gtg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR05MB9749.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W+db2KrmTvf7kqnOk28wx602/YGY7qy42oF9u8K2J+s+AGhny4y3YbLspn8P?=
 =?us-ascii?Q?Qc6LpcpxXtJMngNW/8LAcxhoCNmfJnUIiJHUriVcMM32IX156dxAf3hfAtEZ?=
 =?us-ascii?Q?v6EsxnFk/cXHgsqkVaGYbxK6NakxzFFC5NLUSzsO0EXy6DLammAMlWbdosvh?=
 =?us-ascii?Q?ykS5TacB2jG0b8YU8FQrTYrAGOHmeBVeW1fad31uL63/sp4YpCMxRKY+rSwt?=
 =?us-ascii?Q?jhiVdY7N0ZehHmdCOaGikWbfhxI6flu0avG6VzNd6iTZSlYJtt75fM4XY4RY?=
 =?us-ascii?Q?F2CjuFk8nM6qXLewOIikQr3NDt/GrHTzLB/me4xF2xbCg00lVzS50ZVWfxCe?=
 =?us-ascii?Q?72LKW16KRNyC/QonenpTes6zvTnD5ky1CCmYrc5jDJ+GplOPP0FNZqO4Lbc7?=
 =?us-ascii?Q?+IJawKVVkPV/ASiB6fZud4LMNKTuZXLHX/3kPEPIQkjoGfggE13cRhUfcOxd?=
 =?us-ascii?Q?jkBduJ4fA2I0Y4zl3t3+sDJt8IwTY9jaNb0ReuFe6shzv5hOYpytD0Kqz+Pd?=
 =?us-ascii?Q?EmA3nUYy8S/hZXQ9RvLrfIRTGd3AjYXdkXzuk60KsGc09SiaLlQpFbwsHYW+?=
 =?us-ascii?Q?uO/niZx6Zc0xzzCOaZzEnBsZCEwKScCqO+sQCCwQhJ84jFUkznYZ7ubyQqan?=
 =?us-ascii?Q?ocOuldDgq/4NGJRAPSDNBNlxk1/OO5EMTEzeso/RoAmz0U2uS4rFlnXZ++ts?=
 =?us-ascii?Q?VJy6CrylwR1OzFWLV99RvepiKSZCaQYZUn/iD9wN/HlIq++zEeZFWgVUEeFd?=
 =?us-ascii?Q?ACUrtAITQWRvC56qoz9MSZel/0RdHI+SxZgiLsATPQDIxuE91J+t8qm/Gw9e?=
 =?us-ascii?Q?/oCq8Zd1N3LPXqr/4fLOGNSiaswBWZXZeug1PMPJyL/5MpD7Xa25vHdorGOo?=
 =?us-ascii?Q?oHLNyfli2O3SaW+ix6g4o5QKFxRh6jnO/0QgAMkrLBDow+C+ZihqAapeEGfI?=
 =?us-ascii?Q?iSsBs7025JuARR79ukpf2kLXDyC67dukc/7vcyq+SnjNicDG/IJGuQ8sQ4sj?=
 =?us-ascii?Q?HX66HHqaGrYOGInT+6dvwrFl0GMpYrqOd3sImQs7WiS4/CGauuwCKBUFmvcn?=
 =?us-ascii?Q?gMqF8DPNIXB1mquNKRHWc5/p1itJXmnc3Jj5SAP8Rj4m2SnPdfXhuRZD6dMk?=
 =?us-ascii?Q?QDNxNVG8PXaTViKkrJeG720wJgBTHXwE0+D/nkPpujbFH7M4JQdhY815RqTm?=
 =?us-ascii?Q?X2xDLqSE+ZL+uwaGE6l9+iN693CvMjT3tkwZPffUIqwHhExykJgBWJn/DzAu?=
 =?us-ascii?Q?QoXOP0pE9DceY4+1LYNGe92+SIoZ0IxrOqsTorrM1j+fk96Uccg2Rb5YjyOh?=
 =?us-ascii?Q?cPcJlsviiJT7+xWwVCOtdFNgOj+yOn2mhtMR4WJ2AZ02CSOtyem8LqNc3lIc?=
 =?us-ascii?Q?B2pVyIuuGqOVg88pAifBCj/WI88AcJjK3wEkUQ1Bi8+IKBvIqGkKREQo+I1g?=
 =?us-ascii?Q?w7H7kMAML6VObmJv8WavPy1xNjaf8UIp3OvPrvxp3v0oQVl49MbkyG/bdiRQ?=
 =?us-ascii?Q?kKTkqeOAEZdypTmeTo2GjmYhvkRqeHkHlDt9yZWjgvH4Gh05mdPO6uPEqSAx?=
 =?us-ascii?Q?NSVTsiEuVj1EjhoP1VYC1hpzi2/A4DI6GGTiMXn4F6ypVJC3i7+QQdqiAn2/?=
 =?us-ascii?Q?8IcmN5jfcwJmsvqUtNm+x6En/DEp9sjCTl0pWfkNnaCJYYC/AGsQvTU8SqZB?=
 =?us-ascii?Q?IvS7JDSqjbI6QdhZxJ9gKEbFE89BdfcAFhDfB31llxUn86pxFb2lEN2ocYk0?=
 =?us-ascii?Q?+R+xVfR9jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <026AE23439E9B444BCC7D7595E3788AC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tLx+ZqcmMwwIFzDucoEjrvcji5CAdBAe6zVKkcn/oX3wvwZ9zQfFv3v056Qc1o4QQ7AO5y94k3jSzuLseIekPkRvGgn7nMG967/f5MOaCqUtG5sLp/0oMDTuzNFI8BTbqh6FH0hW6p8SVupjID/gzz1gdudEYsSVrC0BRqN25zfrAUclAMe10HhwN3T+C1aB/geh/en0p18/s86l+0NckjgR+YS/M1Ofog7xD2RBiiJ91crehnO24zpzt12u+zewQDdhh0V7Vb0Zo90acO4dhHa+BERsono3Z0u+/q5m9tQRvJsi1+OVCfRDbKFHBADVJFOSqrPP6hZ+ij1UyaB3hw==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR05MB9749.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81a9bbc-b7bb-42a3-413d-08de756ee638
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:40:30.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIg/gHZUENS62ZyirBzEWeUbQo8Y65RNETIZB6AiMuQAlPrH9myXQiRfr4LKXex0Y6vfn0IN83UdjkRUP62YOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7831
X-Authority-Analysis: v=2.4 cv=XP09iAhE c=1 sm=1 tr=0 ts=69a0a1b1 cx=c_pps
 a=BRu7lVsKyHj15bVqb/Fc8Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7vL3O5uBSuztJ3xaqtyr:22 a=O1S9G-DnkxobS-ZkPuRe:22 a=QyXUC8HyAAAA:8
 a=hKIG7p8Cbz7iKJ4K3bgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: -DxD2Zvzl4CnNLi9TQxeUDAKyYWjahuQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4MCBTYWx0ZWRfX28ajQ6E6HJZT
 AtxUM2v+wH/j+uZimhWIrgi1nN2mxt+piXlxhdM2wCYU6YrSekgWhksu2024T1xPVo4skKo9lw+
 5d+7oGfjQGuiedJR8ECByB9DJ5tdhGu2O9v+2mM6A7HydjPZa+BAqgqV+COLPCv9jyVg4o3ejyo
 kItWNVt+J1RXJNvhHPQmfK0CATUw7UFZcepLG+9qrOnYKmSaTBdy3MRlAWEBV6IxotgWJZHwRWP
 vB10uQFgeEkbP8dawo/pVk9uDL/b7OSZ/Cx61tY9fCHmwul5nc+vWza1teA2dJ5tC85Xh/z+HsV
 LwspWgQE6Vc0J/741bZ21xv7P3zgXWPWWgiKtnhX9+MN8gmBBScOSu0TW/vHIY46c0GjE2orAxW
 WrMuZMMb8IShHahdXgZN1hSK2UU3trMiTO1QB/FjT4I07nDJ7xRZ1O+WpT8vBxEHPJoJ5tBzUCX
 HniYFyCsQjF+Z6M2M7w==
X-Proofpoint-GUID: -DxD2Zvzl4CnNLi9TQxeUDAKyYWjahuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219851-lists,stable=lfdr.de];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:mid,juniper.net:dkim,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 244DB1AEA0D
X-Rspamd-Action: no action

On Feb 25, 2026, at 11:39 PM, Andy Shevchenko <andriy.shevchenko@linux.inte=
l.com> wrote:

> On Thu, Feb 26, 2026 at 09:27:50AM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 25, 2026 at 03:21:05PM -0800, Brian Mak wrote:
>>> Switch device_set_node back to ACPI_COMPANION_SET, so that the ACPI
>>=20
>> device_set_node()
>> ACPI_COMPANION_SET() // but see below.
>>=20
>>> fwnode does not overwrite the of_node with NULL.
>>=20
>>> This allows MFD children with both OF nodes and ACPI handles to have OF
>>> nodes again.
>>=20
>> Do you have a real use case? Can you elaborate more (platform, drivers
>> being involved, et cetera)?

Yes, at HPE Juniper, we have some MFD drivers for some PCIe devices on
our x86 platforms that need to read properties from a device tree. These
also have ACPI nodes attached to them, which do not have adequate
descriptions for the HW.

> Even more thinking on this it looks like a violation of the levels of
> the fwnodes. The current design was not expecting the ACPI *and* OF node
> to appear in the list. They both are considered "primary" from the design
> point of view.

For my reference, is there anything documented/implied that indicates
that fwnodes were not designed to be used in such a way. To me, it seems
that secondary fwnodes are designed to allow drivers to pull properties
when the primary fwnode does not have the property, which is exactly how
we're using it.

>>> -   device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>>> +   ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
>>=20
>> As a quick fix this may be fine, but it needs a big FIXME explaining tha=
t this
>> is actually a design limitation of fwnode that doesn't allow proper shar=
ing
>> and stacking.
>>=20
>> Bouncing back to ACPI_COMPANION_SET() also doesn't feel right as it hide=
s
>> the real thing here, and real thing is the primary/secondary fwnode type=
s
>> that we need to care of. Just call set_primary_fwnode() directly. It hel=
ps
>> also to get rid of ACPI_COMPANION_SET() calls where it may be replaced w=
ith
>> simple device_set_node().

Sure, I can call set_primary_fwnode directly in v2. My only concern here
is with the FIXME comment. To me, it seems like the fwnode API has
already allowed for such a case, simply by allowing there to be a
secondary fwnode. We have no need for more than a primary and secondary
here. Before I add the FIXME, can you elaborate on why you believe we
need more than that?

Thanks,
Brian



