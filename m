Return-Path: <stable+bounces-132220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14200A858B1
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868743BA274
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F97298CC8;
	Fri, 11 Apr 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="q1PpULbM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="N936L6sR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5882989B3;
	Fri, 11 Apr 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365631; cv=fail; b=ONxu24q19lV3dIPgup6Og7dfJFSukZGitkctDEHXuKTr+VWe39TMAUvaWFr8WqdMi0XSzVLq0aDcJotHm8RUQRUkUPEgXF2hhTVymgySm/AbLSrpyVjJpY7gAA9zcJ4ROXG2VvFeHKJVNtcadG8aoAMd+daVUH9YlT0YJHFsiTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365631; c=relaxed/simple;
	bh=HzjZ5zXKH2IUL/nGcYXc2fcfl+7Pp6EfUS38/lw60W8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPCkpMaEd75BKX5olMy94+r5mVtp4xZgmqa0AhbpKXpjVRHjZb16peIZ9FRLkHPG83tJ8ZV2FRd7LlJFm01EKSGyr5NINOv4I/xMp4NUnzMcXZJ7AiGK/ab2chZYh9OMXj8ZUYyLKE3dGfMd9PTf+Pd/g9pOsyd5bGUu/Ty7HC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=q1PpULbM; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=N936L6sR; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8Dlv0003097;
	Fri, 11 Apr 2025 03:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=HcL0FoX/kV9z3J/9s1Yhgx8+4Zxr4kpXshQJ7z6OVDQ=; b=q1PpULbM8xmq
	KfA1DfxdAPdqI9rPHP9baRyPhEKfkDW7OrdepGhAE7xr5pKClwEq9wbZzZq3SBOp
	zg9eQ9no/sLTY0WPEh49o4bFeEOeI6IH/yRWvX3P8ctBhuXW12RYNlZG/UcN1jf5
	K0X9Xw/yRWNRvcz/UREzkNgViFdmVn3ZVWNjPwaEQaeTUP2pYf9jK8X1g6yAuEXH
	p/2Kv2ARVePvuuzhmm7D3rimn3oe75E+Kk2HFfRC+ByrhLt6tJ1I3QJIB7Y9mfzT
	WliHS4MsYJi4rwt2b1ao2YDJafe9CQyJF5/3lHMRMdwqmfgAktv2xpcLKyAowMsN
	33o+W4F+SQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2y8r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 03:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjrmv61VlK2eb180nnT+agMvAuHBLurYO5ka+8LHHrlHWCfIkxZz08wcMOdCpPYBUIUimtgYye/gasXy+znaTeHUqRALU+uc+dGlKlWKa6TythelGIsIunSH4zAYwy5ZJpZrAlswJAPvmyTZVF3oBTu5iu35SLHAPT0OQp7fL7dF33L6GVa7ysh3kB+BljhI8wOAiVujk2x8+GgVGcwAatkOT3VJ4euZEb8AsEdlV7amCJ7jeFK/w4t7ZxNYdLIqIwA+0fz0PjSS88g0IcbRCQgvRN/eviDxlaGsoxSwqANmjr8cKVqJ64/RIZP9XHIuJiICWQxG5xceA7ZTYUmKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcL0FoX/kV9z3J/9s1Yhgx8+4Zxr4kpXshQJ7z6OVDQ=;
 b=Hfn2fkJG6YkH4eiIZQ0LEWRpFCa8ZwWENCd47zovU5WVspDKvq/kCiYFkxGezth/Kje+Qmq87OCpHJLWinKVzezeF+IX7hX63Xp5fjY1jFI5G4+J9czWQJUDO0lUksW3BDox1udXWrtVVKKYxUufyXXC688bUxAqpGR83TDRCDRrwXGgFUhILE/D1M0yolzNtsMUsGoLrM68ZnApcF201gq4yoxXmqsnvjDt/MaIwYfKDbXcnQdwP6BU86VxUnPGCSE51ENamOyBwrnXO/kHGx2BnxD9/eRtGzJTfF5y+hJqqXSX4Vd23Cq235CpKkSNUrxJysTtkG3Pn1AuQQ4j1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcL0FoX/kV9z3J/9s1Yhgx8+4Zxr4kpXshQJ7z6OVDQ=;
 b=N936L6sRZRaDP+2rTO+TnbwQkA2IuQhIg8hd0+xr8TONr0TAj8PiBO0pRDdQ59sx5v/o3UggbnhhW164u4osyLqYkvh5loYxn3zRtI8WEhEnJTfhlXOvT/EGnupCeIulCBt2qCIHuu/W/0t56O8wpnf65Ow+Ip35qfBGUlZmNIA=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB8565.namprd07.prod.outlook.com (2603:10b6:a03:35a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 10:00:20 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 10:00:20 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Index: AQHbqemXS6B5IuQjiUyJckm8ZGIk1bOcgYzQgAEwX4CAAIWWMA==
Date: Fri, 11 Apr 2025 10:00:20 +0000
Message-ID:
 <PH7PR07MB95385403AAF11E030B1719B8DDB62@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250410072333.2100511-1-pawell@cadence.com>
 <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250411014141.GA2640668@nchen-desktop>
In-Reply-To: <20250411014141.GA2640668@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB8565:EE_
x-ms-office365-filtering-correlation-id: 14bdeae3-780c-4ede-a7c8-08dd78dfab76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HmD+dAtsE8SeD0GB7WAtMr6EsyjE+oD7K2Xk1iwENuYtw5YEeZRcXuGRhPzI?=
 =?us-ascii?Q?Hr7Cm1J1umTz7iqgIyhw83MUdpv0g66asbEscM1/OgD6u1F1OpajqDbSGjf4?=
 =?us-ascii?Q?gHDzmUkCUe1Rw3/A/RBxjfeSQ/iZmYEHTJBvwGMP27qWzgwDLWv//0kO/IbH?=
 =?us-ascii?Q?hdmUmc1xnknU/7Rkfarwdl7jFApFwHyll2U/XhcgQkiMxp/9BN59Be3Wwiu1?=
 =?us-ascii?Q?Hm3qMWL1BU93Y2jkKhjIk+lvrSC7mkDSyD/DRhL5bb1l0zvnPNcbu4vJ+CvA?=
 =?us-ascii?Q?vSOO3J3/4Mje4qT0FA5iDDNtbJKXbhC60JjX7oaqMvxz0u8ynCilC9660rS2?=
 =?us-ascii?Q?X2/XxPyD6Pvlod1FQjsGlBt58jC6VekM+MXAhP5thhuos1d2dzdWC3F6RThf?=
 =?us-ascii?Q?CjGfTSrN/ZIXyaU34cSx+OtMauhq/qkTLSZufyF/vSg0U7H+pbJpbdKwyk1C?=
 =?us-ascii?Q?x8+NKw8JHiuOmDAGfLdONeEZJP+o9bYsmZlYWmctFgubbaVrhpu8mIUav5p2?=
 =?us-ascii?Q?R4kujkBwl1xMU/ea8P2L86zx8hAAcOy9m18WHY8QpzzOgmpY/T/PsvLJrcXn?=
 =?us-ascii?Q?SvS5O46L7t/HRrIidQOX/K4B70jH9yIA+dYXz3Ego4h3X3mnZrQTnHr74k92?=
 =?us-ascii?Q?xkEZr3eyVLIGledPQ+Pc12vs4eiz12gGgF9CxuddQx/CjnbVw+yxomAMTWDa?=
 =?us-ascii?Q?hYb9JF182caBjBieGfS2dKK8YHSRhvE5QUChFD3xHizjRVRqaBhQAEaC86/8?=
 =?us-ascii?Q?ijrSnHGDIKQkMjd1L0WfeVuPu6GvQqfW3IoHi2mopHjQLQc82us2Hjz60x5j?=
 =?us-ascii?Q?8MLylXqviJahb0yyZ9HxapmI6rTLHPvtmRTv39otV4Bd+wnv/jyVf+a8x8Cf?=
 =?us-ascii?Q?pnGvUyfuaTArPbX75rwhaEetUVTsUTk8DgUHq2MCr+kv1NP66k4A4TV7iLaI?=
 =?us-ascii?Q?EkxE8QSNPXARL1ah/zgbAlaVvLPbLtcV4jI/82WJMvg2q6w/4IRLPYt1bKom?=
 =?us-ascii?Q?2S1aYL7s9bJvL1V6Nsii4/ubxpg2AqSgeQPgbfUka06wksvrhzIN0bnkT9uE?=
 =?us-ascii?Q?52VJ6sjYoc6NDTdy2vPU45fzpl4E4RqY0qfbymzyA0f6hBDj2Li46wM/sTud?=
 =?us-ascii?Q?xtwRLVKfVcNW/w6WJbK123/XQ4TjEGlU/OTcNbAatNiHeqWlBdkSX9vLimVZ?=
 =?us-ascii?Q?Tk38RADxixKzBpodY5wnwZtmjOL0wyK6i3LIQ3fQMtcRF72gkgskHcK0k6WO?=
 =?us-ascii?Q?eb/S/iE/5wdvTcBzXV2jF57zIR+nD2pCBMyzPEvmYnTDGNLDHWB/CsouCbF+?=
 =?us-ascii?Q?5oQm/SGXaG6RYfOY4L/W6pLqi3OGG9brYQU/mJNc7nO7ukO+d8CZTrTX/TH3?=
 =?us-ascii?Q?13vusdG6aXXj2XQWlpmdmAkzBQxluksUtnqe3HrsXnEWT2oyns9zfQjep7BC?=
 =?us-ascii?Q?8aVPV8EGrsf6Vmd6jE7GGxxC9W2xRouH9LT/TP/qtdiuQaFnCrCVQt1seHxs?=
 =?us-ascii?Q?t6idW8mCU4d0rC8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q7TdqZr2sAgbl9rwq1YKjY0fSa5MkJnG/+7istOzDv571OB5EJEdmQOQMReK?=
 =?us-ascii?Q?kIzjaEEegaHJVavQ7g8/TQ2e6zo0B9238Nq/XcIeGmCIIb62ldLYntYq4CPe?=
 =?us-ascii?Q?tpE5ZTmrxLllQBnfcexOeWtHdY0tQUAiW5XIAYxcHryzYLNbXMY1M+ofJ97T?=
 =?us-ascii?Q?mXaVtv+2oie4PnY5cJnODfGcNtMdmVo+OQbSnfzGy3mMDfwwZ6eCid1hgYxl?=
 =?us-ascii?Q?OHniQ33aa3cbiPLdElqBbi1a/BR/7QKX3Zqwpq+paATjjb/gPlB7A8l4EY0Z?=
 =?us-ascii?Q?yckUDb5Y26NWyf/HLEm6JcGIzYV7jMbrlL9UxZTy3Ejh5kABHKwe2l3hgM+L?=
 =?us-ascii?Q?GeNNP5gEDlYvHwYmsnb72aVCpG0PWKEW2/FhMQ8O5Gn4E6ZWqHEaXXuCccgO?=
 =?us-ascii?Q?PPYMWZRMus939H15cAzV6etVyCrFOx31KFnkobklNH5yrXu8PgIvbb15CaFk?=
 =?us-ascii?Q?Va8bza3NBx64Iq8PZ62yFAaO0l2Zt84biXzW1LFjTSDaKlu76L1oPUDfpB3P?=
 =?us-ascii?Q?qYH/dHVmbx3Xg0SitvBdIKVK7bqamXFKNft53QKNYx601syUwoaGrhl8HM2Y?=
 =?us-ascii?Q?BmuYiOpnL5XCba7UnB2S6L9dXK+mDmTrvWx3Vl4qJCUNX6Qh48ymMlqGhPkV?=
 =?us-ascii?Q?+SkXoPmbGJNPvhWSAasW68Y6r7S6CZpbT0lcccfAl9xHKYVvUxQVjxf6jIqk?=
 =?us-ascii?Q?6GKJ5TDoaHubxz8nMbhFgo8IbGjhmv4ueL7PKhurFdY8fnsju26h/mAj3XtR?=
 =?us-ascii?Q?l/8SJ1tM5eybfwanHkyPOo2trDb/kqfjjpiFePGl6Nn0vDgHfgEzg2ndt4qL?=
 =?us-ascii?Q?PMBmPjhwkC1lknoHBPRDU/A/vRjC4OzmIVqHWCcmiLzi8qUkWc5SSXvjWPPf?=
 =?us-ascii?Q?5cI4zlp9Wnipgky73R5WnsxlQXUsKxH4PgJ0+vyjtFIDezjRNhh37JjhA3F7?=
 =?us-ascii?Q?uRHtPZVKBhR4Xcmr7CxVQIMUJqhkveV+J1L515SBIdqwfm2lRaNUnGTsbtQ9?=
 =?us-ascii?Q?IG02QaePXeoggqrrkpk5guSdQ9IiCEICosR74uYaNcB1ypDJv/ufYD6Gsvno?=
 =?us-ascii?Q?MAHm6ELOIyXGJAQwe+UPS3GhKF6BqLObmO7UWLcrh+hQSpJxi8FxRFIPPbP1?=
 =?us-ascii?Q?txPU0VmDhZVa1mbihTZAEbjMKRHpHAzJP8dj7pUP4i4uVZIFPiiy82hDlReL?=
 =?us-ascii?Q?dkbBI3TxMmdojg0rHanKz2UFdgu7zZBSNtgMYPYFGNjEsIaNYVaSfN9wQ+Vo?=
 =?us-ascii?Q?fMDRFJLKuwDtnmst6P2UU5oQQjIgeqv9BTX3USqtek87rP5fEPXnhmbQvrJo?=
 =?us-ascii?Q?3ygyBjnoTnX4Z12ZBW+5RHzkzPSFOEH+G5f+gc5EGsrf/bp03Wxz6lj+S7pc?=
 =?us-ascii?Q?DNtTTdGlKEk+lNDwa3ci8fsUDh5XGQy8AINpHXDYIwOJsT9WkFATZwADTQ1E?=
 =?us-ascii?Q?6z11M7YtNc3w2hSjuGd/gBGqvjFqJHBi/iOPp2u6aLN5lbFQq7IOY/IsDOvo?=
 =?us-ascii?Q?nruMHAnp2CTCt2l3xcGZYaXqpbaTtdfsUleQH8WcKYmf15Jnvj0yuwijvaIw?=
 =?us-ascii?Q?XXny83eW8SCguHR5jXPe4gH5n7Zk1609Mm4y17Tx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bdeae3-780c-4ede-a7c8-08dd78dfab76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 10:00:20.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkHBtI/YyFQc8aDJOBidAesI2kWmyHzBsepXSz5dW/SrC5oTq5aPdZW8u1hRSZbcZ8W5ynjUJRgi1s56uJx7J3PrmjC0RLfnoX//Xs/H3Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8565
X-Proofpoint-ORIG-GUID: eyLwPgk7H0DuXR_cct2DPg9PY-bz8D2I
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f8e838 cx=c_pps a=iiQOqwU6IAtWz55ZD8rkjg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=pS4D0YpswNWtceYn3skA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: eyLwPgk7H0DuXR_cct2DPg9PY-bz8D2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110062

>
>
>On 25-04-10 07:34:16, Pawel Laszczak wrote:
>> Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1
>>
>> In very rare cases after resuming controller from L1 to L0 it reads
>> registers before the clock has been enabled and as the result driver
>> reads incorrect value.
>> To fix this issue driver increases APB timeout value.
>
>L1 is the link state during the runtime, usually, we do not disable APB cl=
ock at
>runtime since SW may access registers. Would you please explain more about
>this scenario?

Sorry, I'm not a hardware guy and I misunderstood the root cause of the
problem. Description of patch is incorrect.=20

System uses several clock domains. When controller  goes to L1 the
UTMI clock can be disabled. Most registers are in APB domain,
but some are on UTMI domain (e.g PORTSC).=20
During transition L1 -> L0 driver try to read PORTSC in interrupt runtime
and read 0xFFFFFF because it receives timeout on APB (APB clock is enabled)=
.
When controller try to read PORTSC controller synchronize two clock domains=
,
but UTMI has still disabled clock. It's the reason why APB gets timeout err=
or
and read 0xFFFFFF.
Increasing APB timeout value gives controller more time to enable UTMI cloc=
k
and synchronize domain.

This issue occurs one per 30 - 500 minutes in case in which I added some
Extra delay between some requests to force the massive LPM transaction.

Time is hardware/platform specific and should be parameterized
for the platform. Patch will be improved.

Thanks,
Pawel

>
>Besides, why only device mode needs it?

We haven't observed this issue on host side.=20

>
>Peter
>>
>> Probably this issue occurs only on Cadence platform but fix should
>> have no impact for other existing platforms.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 22 ++++++++++++++++++++++
>> drivers/usb/cdns3/cdnsp-gadget.h |  4 ++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index 87f310841735..b12581b94567 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -139,6 +139,21 @@ static void cdnsp_clear_port_change_bit(struct
>cdnsp_device *pdev,
>>  	       (portsc & PORT_CHANGE_BITS), port_regs);  }
>>
>> +static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev) {
>> +	__le32 __iomem *reg;
>> +	void __iomem *base;
>> +	u32 offset =3D 0;
>> +	u32 val;
>> +
>> +	base =3D &pdev->cap_regs->hc_capbase;
>> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
>> +	reg =3D base + offset + REG_CHICKEN_BITS_3_OFFSET;
>> +
>> +	val  =3D le32_to_cpu(readl(reg));
>> +	writel(cpu_to_le32(CHICKEN_APB_TIMEOUT_SET(val)), reg); }
>> +
>>  static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32
>> bit)  {
>>  	__le32 __iomem *reg;
>> @@ -1798,6 +1813,13 @@ static int cdnsp_gen_setup(struct cdnsp_device
>*pdev)
>>  	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
>>  	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
>>
>> +	/* In very rare cases after resuming controller from L1 to L0 it reads
>> +	 * registers before the clock has been enabled and as the result drive=
r
>> +	 * reads incorrect value.
>> +	 * To fix this issue driver increases APB timeout value.
>> +	 */
>> +	cdnsp_set_apb_timeout_value(pdev);
>> +
>>  	cdnsp_get_rev_cap(pdev);
>>
>>  	/* Make sure the Device Controller is halted. */ diff --git
>> a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
>> index 84887dfea763..a4d678fba005 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -520,6 +520,10 @@ struct cdnsp_rev_cap {
>>  #define REG_CHICKEN_BITS_2_OFFSET	0x48
>>  #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
>>
>> +#define REG_CHICKEN_BITS_3_OFFSET	0x4C
>> +#define CHICKEN_APB_TIMEOUT_VALUE	0x1C20
>> +#define CHICKEN_APB_TIMEOUT_SET(p) (((p) & ~GENMASK(21, 0)) |
>> +CHICKEN_APB_TIMEOUT_VALUE)
>> +
>>  /* XBUF Extended Capability ID. */
>>  #define XBUF_CAP_ID			0xCB
>>  #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
>> --
>> 2.43.0
>>
>
>--
>
>Best regards,
>Peter

