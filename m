Return-Path: <stable+bounces-141999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A43AADA2A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 10:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0EA3B4559
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C56221FB7;
	Wed,  7 May 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ccegcwd3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="IxuPpUww"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AB221708;
	Wed,  7 May 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606519; cv=fail; b=TaOKbRvRUmWzDcfRdxBSqv+wrHuFAeadtNwHMQL01cLdAtpWtC/Zs1kmMd0FjuUVIBVzYlg1lIT8ODZPQb5PyRkYxs4k1q7MCqXERRv/+8qe8EnWNhWEhJLS/nZ528dA6q8yrwKn8QiOVmXqLy2eDVOJ43yo06D3XqRZ6Yx5yc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606519; c=relaxed/simple;
	bh=3OBb/0yuztHvey6lDCdTCAsGaxZ3f4c4n+sIPde2OvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbCUzPUP2ILFOsm+Es98aoFVdta9F39IUbmDwQwi3R92c3W6iWnhb3b27J0c2Tz0XAcWdXwUfdqWklYKnIeWkUfXi7vbrwFENm4fOetE8hGpApNz7Fc8lBTfaArreyNA6dxeQSqNVt/kC7ALepqU16LfN8oe6JcaPYzCz9TnXnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ccegcwd3; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=IxuPpUww; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5472ka3l001830;
	Wed, 7 May 2025 00:22:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=62HivsSsJomxxowndPLPYKRyDSaYjNf1Hgt6LkGpbOg=; b=ccegcwd3NfDf
	E+hNgyzKUXp9YjKSjoZ5Yc9q60uz9NaWAyDhd2VzrUa4nAVpSKdMTaInDoslWhhp
	CS9crTitAlHRMy29JZJU5p8u+TUxSDsBvtA8xET7DrvZ1ysCfDKUlOj4hcwcfPdt
	AnzA+y5sL6honm7QCTOKAmMF7lmhq2NzYikeEGAJ3WKuFD9H44kRhU/t2cctr4WM
	yn4xdS9Ol4ST0hAWa+wjssg9TZdv6JKwsstA+NZzHq+H571YU7u4ZQHxJRzjgocS
	bM8LJTgqO6WuDn3lI7i9yQGxvJiS/045KL/iOayZtEEIlPh6fgrDoZT58g43XoH2
	BU+JXF2y/A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46deqwrfdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 00:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKmELxRabmbl4Hipprd6yfo4V3RDPC8gY08A4o3JhzQ6ylPKb9dOhE5hEko3flatCLuFb76q4GpIFc7SJJ7vAdQ2LdlcQmHzS+2B9YJgwkCL2mAIYLfhx7Z7PFmRTFVPbkwXTVFsK1OoqnYK2YZ4r4OncvExv45uSuhuPsvCiwCrl8f5AFjdOXJKjpoghgBHR84uK2HN5ts91em7hKx0P+5ToVO8G5WoDJw/EPNNwFw3Q4vGb/IXzmEwefvaTxhH4A7q5pcoRe10idumfeg+bTmnE+mxSTGjJE8IsPfNxVv3HaMjRms9uS7huXrzhR2oUYeo4qwm3SvavlZxdejz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62HivsSsJomxxowndPLPYKRyDSaYjNf1Hgt6LkGpbOg=;
 b=vUz5QfQMJ8D5dKa3XdKQXo9a3B9gQT3rCi3Iwg1mEbBxX8Hd5KQMKHgjvamjXv0s1zTYW3N7nbxiZzNJ6VYCsd9TCWHTF+VAP1N0C/6LQ6GX+2UolrZI0Xc7MLYz8uJwEcROiHhqR7sFEhb0jEQ+dAvqh0KWFXDVwqTJGj74H9IGClZOpStCAs1bzpyp1r3hav17Q43koKKDXkKg1tr2MdTQwgHnt+jIZc57d7dgLBfmyI/mMdIh1faoh3tVnSHtAcEaiPYfIgpFmh50sBzKhD55cCMahrLp5o3/Y6NbFbTztC4AH3caxNT3Kd1xBbZyly/4Fs9n3431bowNNOIQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62HivsSsJomxxowndPLPYKRyDSaYjNf1Hgt6LkGpbOg=;
 b=IxuPpUwwJM/q5S8h9Xds5BmaPAg0lXtHyLWRAAQs7hNBFcrZrt3y54CsSPXN39rVuQquQj6T0LcqtgVvt9GZJbVHxo+hej3FRqFx1pkZ1HtxZhxrhZzwRGhd7fqtm270b+Y/37bIr9bzQletjAbHthswi3Uo+6FfWry2Bhub35s=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by MN6PR07MB9849.namprd07.prod.outlook.com (2603:10b6:208:46e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 07:22:41 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:22:41 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fix issue with detecting command completion event
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with detecting command completion
 event
Thread-Index: AQHbvxnya97aAZjaiECX74c59YsKxbPGwtgA
Date: Wed, 7 May 2025 07:22:40 +0000
Message-ID:
 <PH7PR07MB953855E1D951721A143A83ADDD88A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250507063119.1914946-1-pawell@cadence.com>
In-Reply-To: <20250507063119.1914946-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|MN6PR07MB9849:EE_
x-ms-office365-filtering-correlation-id: 67994820-c113-4d6d-4874-08dd8d37f3d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sxa1+wE0oFV/uKFbtNLtvk0E5UA+msQm01f7upxbmL9NFQGa/t4jxM75huqu?=
 =?us-ascii?Q?TIfmGNp45FTxJUe4lT90G4T27OgUtzmkXXpcM+1psFQIuHAREDkAMkY3+8As?=
 =?us-ascii?Q?P5ddtNkf2qBSEbxO/9FqgTrIOXdejuv0hZcHwDpMROCg1r/g1b1NsHlY4/lK?=
 =?us-ascii?Q?3R4z8B3d7NkUuDV0FsWMJCbKxzTYguPpBOvCuOW4uPj3N52cMus8KBixY4z5?=
 =?us-ascii?Q?HcOzjf8Jlw0P6rh98sGoGg6mF+B4SVmrOPNRzzul9Lcp15i0N9D1dFFenJlS?=
 =?us-ascii?Q?UfloCci0NDTSRsRXkgTpeUbHsn5yqmH4yjsLnhI0bff8xIr/rsU4Fiyn1YrJ?=
 =?us-ascii?Q?Nmt09tmYPPh8xjIQzqrnkIh+tF12JI5Ny5qNdDowj9PgcRDpMakCWBegAoJb?=
 =?us-ascii?Q?VvWw0WlMQY+PtZ00FqtBuPF3BVerCA4lN2NZATCzw4QdQvmeHBD7DTBovMBs?=
 =?us-ascii?Q?q6rTe9nG0pgaGl9FxyBd3LkWRxn8bqjt8fZCQF4Sx0G4wptNOSZT7ECTjfKK?=
 =?us-ascii?Q?nFriJQHIaTPjtkonuVs563rxR08hG81dFYlEb1vIEcSvmMd2bi7V6wg93zQd?=
 =?us-ascii?Q?leKGcx3NSTILyrJcOQbCplllWqvxyeqpMN37VYhFIUG4BCWNG8fZePzCWoa2?=
 =?us-ascii?Q?ID29c1rayqr0Vy+iVKADxdT0K6cUgST+l9zUfbWeM+rkiBzf2BJg0AA+C57H?=
 =?us-ascii?Q?0jf3JUYgcMS4l+Ae2o888lgoz1/ukJ3ttHIXAUh2Qe1ausu+sWyNsnLsgsM4?=
 =?us-ascii?Q?vD2AFm/EzMmm7SkSlAOKG2Bv2E3dpLwePrlkBYLkVqQIujzUm8yWm1lVWYVA?=
 =?us-ascii?Q?2YzVd0Gwc/4waT97NOPiXrjEPWGcQdCp42qIzaIMfAdO97Sc7MVGEeQ1XYfE?=
 =?us-ascii?Q?dyjzqpLsTqnwwUmrUVA8wvTf0eVxUGnwr8plcEdvMgleMmn0LtkaVtjsZCkr?=
 =?us-ascii?Q?gCUNP2cdqpSv7iyckRLatv6lvfEEea38gD7qxx8v6cyIg18cKJayCnRIKxnS?=
 =?us-ascii?Q?XzS3KmkQj9tJTIsrqHjQzYYhFCLkZWB94JqoJw4UeMNyHK3CQ5K+nlVGebLs?=
 =?us-ascii?Q?jc/FNLIKaMkwtGPYm0ZZE4OgT/S2iyvE+rE0+WgSc0Yyr0qKxWZsuhUbckFN?=
 =?us-ascii?Q?86t1IUpWyhglsANHGfHA0cad/IX/s893a26HQpgqFPcUYKkhf4YnHyvgsp7M?=
 =?us-ascii?Q?fgVUhw8hR4zrg2OcBU27L5jlnnwIDOcj0roBw9OBYQIIQ3CdNl7QDoaUOiXS?=
 =?us-ascii?Q?hj0g9KzLlRj9CjmZ8eo7BfTuaJEymVJV9Hevj0N3INlDqSCJzsjCFeEzIMT/?=
 =?us-ascii?Q?F9aU8JNb+7oHo9mHzQehMOrxSv/02eMLFDiYYsFwkPly02inHYSbiOjmLRuj?=
 =?us-ascii?Q?EZvkY5QEnSnoSo2PtOHI9kC4DXOUSy1Tmr0FxrSv7rDKcIaMCioOq/7lFTlz?=
 =?us-ascii?Q?TacseJzP6nMEPqTozm/95lKjf4p1bnnMzyplkzjxB/G0lLjdaKTK91zr7Lja?=
 =?us-ascii?Q?Til2nZInkuAJ/e0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oMiFeaXhAI7WCngVSBEIo1VFgZEM0mPA7vTNkYc2AvmMMCV/RpRmTU+0Q0DG?=
 =?us-ascii?Q?V5b8lSf8okqmu5EzqHF9gryv0J/mTulzV531m0G6yII9kaTq0kbTgZ8OMvpf?=
 =?us-ascii?Q?3l7s6gFDEmbBNGOd3dQzR4hTAC4SueyxyRbvvZv6V9v95B2rwswOsFuy3zez?=
 =?us-ascii?Q?aSN1KDsOlraz0/f+efiqmZ5pX2gSqET93i4n1W4kkdwsaQ5iaj74FheSVUCf?=
 =?us-ascii?Q?q19gT7eFiNO9lDzGEy1LE5uFtwl9ibiw5Vid6nzMkgtgIR3gB60kqEzEbL3S?=
 =?us-ascii?Q?uiHrCieEmssCnHKZdDdJR4TN7zZ95fRs6LodRFroCGzuI1qJXlfEpowMsApP?=
 =?us-ascii?Q?k/QLYniYJ05FbxYGMZTFMJsfPl4v0a/CVuuN9UwQcjZ273OnLFt0JQE8QBoX?=
 =?us-ascii?Q?KgO1C0vmErHX6r4YMZmQqPeZIDwydUg9pvfV/wWrPBqY0rd624xPHy5+welJ?=
 =?us-ascii?Q?zM0I8PXv97Qqk/rn6lRZxxhosd1NtoCnoEYy9e1yVTzvSDFQZyEM2+CRYWFn?=
 =?us-ascii?Q?iZLeQGknxigWsd3YUf2LdXUGczuvv1ESkmPzEhAXS8orZb3FZdH/embi9miM?=
 =?us-ascii?Q?CvCmfPbYOP8OqAwt75CsjPtcJtadbWq0pQSCYVsdNRzo1D1tZKk6BS2uxC0/?=
 =?us-ascii?Q?gR065lU0eGmkbI9ZD1hsQ0SBGrqchckJ4W5VSZIHEtKR0ppuuUXhW332twot?=
 =?us-ascii?Q?8FsNv9zIiEH69/xqoWzOSy0R4nJ38Mrp1uRkOhiSYLAyPgYozploTtj352FB?=
 =?us-ascii?Q?Y3HRJFZ6otO7+EKV5cKXUN98/nLm7skOOmuv59e95sSmpKP9nd6ofKuZUJYu?=
 =?us-ascii?Q?cq6R5IAkD6pZU2VDhO1ZVt1OTiN4cMs9NZvixTfAnAawvpwv4OC1WLBDjMe1?=
 =?us-ascii?Q?+u8LmVC6FnGA7e6DIXenhQPTaSrkL1KLtjVe82V1XkAwzI9Iu6kt1B3k3UbF?=
 =?us-ascii?Q?043GvE5bMSRXi7eP5gqDdMaa7mxf/1QfZHgiQBSzMy5FhSLlls0v7jTA5PiX?=
 =?us-ascii?Q?3dvG0abx00QL8pq7MyIuip7a0bufLz92XfiSiFQcPHmPuym/Ctj3bWwCcq83?=
 =?us-ascii?Q?JqntxoMcuPbgORQ4ex0DGeeSO3dUQ7QfPuHEJXk3LNbp6JVdqFe/3uMxTQQ3?=
 =?us-ascii?Q?EUy2wK0qLBjgTsGm6h/kVvXBKGjzEqc8uA4mV9wJllgZG5klCkYd27hBwExM?=
 =?us-ascii?Q?syox/+xyQxGuFxKrGc0nAzR1U/wyoqy9rk8GnS0QexbbAA0FVT55MEsM1Wty?=
 =?us-ascii?Q?nmQ16jJm0Cs/vSDzs7z1tCcszO3+F2rlwGhNtOMMKJmHdpJ/4hYMtAslvujH?=
 =?us-ascii?Q?NHONO26lgwsX6VLc0C3qSFAhTIaePczsIw0jgIq9IRkrStcTy4fnSaDjXMeX?=
 =?us-ascii?Q?kKisLvlQkC/ce5f1Sa2Dgm6XpYYhjDvM3GTUX/N9lFRTVpbLJ5wNoOm2wV8/?=
 =?us-ascii?Q?DFKiVhH+VG5J22USQmOKb8YHytNdntokoIQeP3yz3cxBpujbq8ZYGYMzhCk4?=
 =?us-ascii?Q?OGUuOYI5w9Jq//yf+jUnhuEuUK0N0Yrky8mkc7mCXKPeFrUc2u2NEl2lEHlW?=
 =?us-ascii?Q?UIUu+cAnvzWZO1xZZL8Dk++ckM0OXZmRb2Cg5FY5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67994820-c113-4d6d-4874-08dd8d37f3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:22:40.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmzyaoiDkadRphFIif17aCyRyFI+pXPDgU4BRQNb63l/xK+0smN3vgF6jWULy4BhDvZyyLGxQN5JC+jsemKyYHY/izLyunEuENLgf7Uf1Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR07MB9849
X-Authority-Analysis: v=2.4 cv=NL7V+16g c=1 sm=1 tr=0 ts=681b0a49 cx=c_pps a=BALyy5icRfvvzfOMzojctg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=3iKoNwNRq6wiF6nZCI4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: 01bPt51fFSpl9ogOumA0M_oZsJXzuzJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NyBTYWx0ZWRfX5P/2GA4xmD3A aldjP5aQdGQmP09l6x4Kr+XV0GBW7EPW9YgItwPi4jjRR0QX2D8DoKyoOf0hO58KrZniu30Na1e FcD+hrX0qSYe3sp1+SmXfWkGeLWU1l7yV1bjV/8EVLBOJh57+oZKw8sh4u9i6KEGFWl0OaarUCN
 IfpASPjAthU7ELwHurS4Fsfhq+NNQWT7BKrZO8sXgaQ2+94etP90dx8Qdw0UeKUMlorSsoOgOnV Z0ChFZwhN+gTU8/Y6d40aA6WgznnqAjWhe6dhgcAOd0GOT0TIOuVyXkRKsLBsXE0ReOwYlRWHPM It8zb5i9DXs8BxI/DERKSI3wR6Rc8aV1A0t5+Gmvtv0JgsOqnAhkkhThk0b6v3EAhS3tD4XwvLA
 m/wMcJvDaUGqIvk7HtrmQWP1bdNAxQzHGeycK8Ddx1UVmfrVB1QPnupgauVwjBX5DMoAtQP9
X-Proofpoint-GUID: 01bPt51fFSpl9ogOumA0M_oZsJXzuzJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070067

In some cases, there is a small-time gap in which CMD_RING_BUSY
can be cleared by controller but adding command completion event
to event ring will be delayed. As the result driver will return
error code.
This behavior has been detected on usbtest driver (test 9) with
configuration including ep1in/ep1out bulk and ep2in/ep2out isoc
endpoint.
Probably this gap occurred because controller was busy with adding
some other events to event ring.
The CMD_RING_BUSY is cleared to '0' when the Command Descriptor
has been executed and not when command completion event has been
added to event ring.

To fix this issue for this test the small delay is sufficient
less than 10us) but to make sure the problem doesn't happen again
in the future the patch introduce 3 retries to check with delay
about 100us before returning error code

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index f773518185c9..0eb11b5dd9d3 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	dma_addr_t cmd_deq_dma;
 	union cdnsp_trb *event;
 	u32 cycle_state;
+	u32 retry =3D 3;
 	int ret, val;
 	u64 cmd_dma;
 	u32  flags;
@@ -578,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev=
)
 		flags =3D le32_to_cpu(event->event_cmd.flags);
=20
 		/* Check the owner of the TRB. */
-		if ((flags & TRB_CYCLE) !=3D cycle_state)
+		if ((flags & TRB_CYCLE) !=3D cycle_state) {
+			/*
+			 *Give some extra time to get chance controller
+			 * to finish command before returning error code.
+			 * Checking CMD_RING_BUSY is not sufficient because
+			 * this bit is cleared to '0' when the Command
+			 * Descriptor has been executed by controller
+			 * and not when command completion event has
+			 * be added to event ring.
+			 */
+			if (retry--) {
+				usleep_range(90, 100);
+				continue;
+			}
+
 			return -EINVAL;
+		}
=20
 		cmd_dma =3D le64_to_cpu(event->event_cmd.cmd_trb);
=20
--=20
2.43.0


