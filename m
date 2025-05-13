Return-Path: <stable+bounces-144102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9732AB4B01
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F46863401
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9913BC35;
	Tue, 13 May 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MOV+QjOT";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ys2PcNgq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA808828;
	Tue, 13 May 2025 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114236; cv=fail; b=KIUvYVwTgB43noZR4iCKnoDmAiSvm7bL5fzT2n1k6LFppKBsLyokt0KJFV1Nc11DZr9uZ5yTujcpLorR1Bq2Ng1J6mCynX2EiSPldwvOiFpusFYL9RCfJ8/jtoIOOZgmB4N1sVqMx+1J6/5UK07NylGYUNoXhBCAxrWR06K2oZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114236; c=relaxed/simple;
	bh=QOUx2taC1R8eEcpmfeEA/WGIwfK+0qQERQ4+UUgO2Yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AkC5lF4IAI44hi7NxT3lsfS+gNkMKnC/FgDJC1ayFJkWpajtzx2SZSaP1BbDJDnaWNMvNZg2HpEaVym184/KKyeJ8IpdfGR+pgyJuZb2PxhItwrBjObfh2mf+nX5Y679rWWlQRB7v+1DLdSPcNn2zWMOrxTr7mpmpYnJqtLL9Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=MOV+QjOT; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ys2PcNgq; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4Ds5g027548;
	Mon, 12 May 2025 22:30:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=KNASa3XgWURD3LyJQA1zt7S3j/tli54Hu/QMm6jwsmU=; b=MOV+QjOTQaij
	7eN5WxqFr8y3Fj3KiL+GELKlhEp008HaQbURphI2OiuDDjgYgM/v7662jav3fCKf
	pneA65h0GCMHfa4s5P93UyROl8x8k2aKpUqcM4khLPOm297nsT1qvVdm+bMLvPey
	Oodq9PKY9n3smFff8oTm8uxIOftO7woUk3zdkdqmCSYQqctktXHY5f76Zw0Ya1wQ
	5Ii1qMp6mE0LhjTe4htLGAj9rL2gCoND5zV9NMUCObV/5/wKYR6RdH0jZjM/ufuT
	6LyLEMs42RqhQAYSnKO1VvcS3gHJM2E3zZHtyMy4z9uLmEJzmOifWPiDmqUcLGZI
	Hw1zJPE5Lw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46j2cy1uhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEPLuQA7mbrDE8ghQwdAl4tqZH7KNcqn2c8tefQZx3jQaAwnBADulPYZqsVXs6Nr1bcWsl0I8R0Nw9d2dGZwg+5BMwlHrlYlp/yrHtnfWUlsH35iJrNeAn9Q+64IGyI0uXK+ilfvrZoZ1XBYeaYYW4SNKEg7HrPH3LcROQtA9EoMq/3tVcD6nPYEkCYU0Fgr8zyIgCINY68vGFTgU2GMPli8O7YhWP4qoYFVhIrQQ3TsLhlBbwHZ/5Fi0y0VZuVaOz0fxacp6MOVfYarLc5IBgb1K3AJo/AdSX2Gl8yNaG72D/LxoYdUIW2peTc/1Vv6kAlCzexC773nrHv4Vxug5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNASa3XgWURD3LyJQA1zt7S3j/tli54Hu/QMm6jwsmU=;
 b=DuFZ8jsYM2R4EyYqR33qas7Thrt/k6rAo54rby7bcEpzZx+DhSSPeI4wZIUYKXj99BGGE9xSfSHoQhKdWA8S1p66kFEKFNxyDAL4HgxSNJ8+IzKN1AbiF27cqtMK3AREOzYaCjldDsVgq9sH4LUf8nYRoQVDL3Gj0ziTD77jDCFKwUgLYlQWSlLng3iOCgLmxaZv4WWMSqrpiiKJZnt2zLDkzIyP+RZ6YwglA413UAiI+vamPYAnuQQ55F35GexIjxXJc+d+qgqe1lLz6rlhP526ejCETi0PUD0Q9lnaOYzMSks73mAcEkRZYru3e9cclO6yHqERK1UmISJUE6dbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNASa3XgWURD3LyJQA1zt7S3j/tli54Hu/QMm6jwsmU=;
 b=ys2PcNgqxJYg1Y8ExihFKCsR+ah6yNTBy6k8w4OSWxC0HUUe22eu6OO7QjNGKGvD6W/0i7XGZnYi6awbQtoNJ0RmBhmpfvOVBrE2IVzmRT0DlkLfEKCEawKUqJd0Nv82L+KmLNEpIv0Dbi/U6/mI2Gjqf6Q4/nEaDrcoFrEK6Ac=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BN8PR07MB6913.namprd07.prod.outlook.com (2603:10b6:408:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 05:30:14 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 05:30:09 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fix issue with detecting command completion
 event
Thread-Topic: [PATCH v2] usb: cdnsp: Fix issue with detecting command
 completion event
Thread-Index: AQHbw8efzs/izhLR3UWYE/4/Cfc6R7PQCADQ
Date: Tue, 13 May 2025 05:30:09 +0000
Message-ID:
 <PH7PR07MB9538AA45362ACCF1B94EE9B7DD96A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250513052613.447330-1-pawell@cadence.com>
In-Reply-To: <20250513052613.447330-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BN8PR07MB6913:EE_
x-ms-office365-filtering-correlation-id: 36c0c1d0-2ed8-467d-b779-08dd91df39f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ER5doNs8/eZztzO8V/LReIZq0i/ou/Gtl0PfEpG3ol+JvImJZXVCyv0S10ZI?=
 =?us-ascii?Q?yF8b0IWXJGXsWUFRb8vR3mPG7soEN6L6rTGYQfPxn8tIILHMnRDQo/zHQoAq?=
 =?us-ascii?Q?CrY9ybaNB+0illXlJmbdXaTY42umYp7s7ic2/TXlcAWaPcTGSPSxTtq0JBJn?=
 =?us-ascii?Q?U5uOm3Tp55ZtZ/WaR2dx2x/kCFvf6zAsftRecnmwryx9VH7z0uIDlVAgIFO6?=
 =?us-ascii?Q?NlLuh3O2vQvE7qMBjSiJESySKYNbYL8T1RDBIuUrxoF5r9K40+6JdX+F57ia?=
 =?us-ascii?Q?mKGsSP8Dlb6YCPclAqby1FOaEDCq0oqYpu9+Zn3Lxvf0UbgIteLUNxbHkzrR?=
 =?us-ascii?Q?ZALiFAv5AIOKHTWmU6jhfII7TxBQfK4kV0LqcuWji313k7Con8A4eOtQFs9O?=
 =?us-ascii?Q?flHmqkJcCHoFwWloLRPC1XiBbJ9FxxwcyiV8qW9LPdeSlQXtkKeoRxqanqSi?=
 =?us-ascii?Q?Ge7NSovJ7Mav5/7uKJJUEglu8lA/0XvVP8ZOiDP6tzL8AlmXDZY1ERrFwDRw?=
 =?us-ascii?Q?JOXXe39R1JJNABbylKbC9R7kTaXm2nlGhlhvNAMElGWUvXa2h1lVu87u6WFz?=
 =?us-ascii?Q?45J4MPMxpPdkX61L1JuMmQ6yNMLGFaR/aLyqCzZXkyU0TT34gKLytRTeKBfM?=
 =?us-ascii?Q?/cmdS2T8Qofp3Q9OLDeSZYYWVKv2rvGI+vtBbk/phYsqPpmtJr00y6Xbp10W?=
 =?us-ascii?Q?eAvIMRs9BIEMmG7KVJ4safSjVGgl+qQD7BKjmDSoaxIoB/NjF8CarbQbrHs3?=
 =?us-ascii?Q?A2BXH+Elk5Zw5RT773P/tbd7erE14PwoD9jIFspfrigJ8g2VlbQ0g690gRI3?=
 =?us-ascii?Q?LDiy80NPpgD9QZ8VUMLdenyc+jQhQb0yzU7Enygxmxdk4kkEGbL7ufGflI+J?=
 =?us-ascii?Q?w/sysOaGX1uXY+jKPx1Q2mNqAaVVw8kM3fLQ+ORaZ8gxOvuNEQ2i1UDJ9AtM?=
 =?us-ascii?Q?I956Md0DtOaPo2kRpPgmUkzO9GfXIy3kw680MZOywGVPqUA/17/t0cSlYAcC?=
 =?us-ascii?Q?ivPNkri/AbU8nBOrZQ00JcJmBYMjGGlXc8AelU/WTWggoYKVjsen8hMUV0+a?=
 =?us-ascii?Q?E6n84+GzGfNM6duuuJwa7zwZgki+Wnuej9883c05ycqL2THK27P2WrLRuQvA?=
 =?us-ascii?Q?C35rfg5opKCaAhy3+yrSOqINl+KhsmNkx9PlVC6vkvgv12B60EhRTndpIlA5?=
 =?us-ascii?Q?TohspeCAmALW4k3VMws+2UvxQ+9QpH/zzxStNA6oDu9fnea5gDrDj+amr28F?=
 =?us-ascii?Q?F02tH4mKSmurxoKbvLTjWNLcntsWiTWrjk5EokIpfaO5VzZsb86dbxsq6BHx?=
 =?us-ascii?Q?+40xaDE+cawtAq0Wbgi9OoRNjp3lz1002r/sziFv8mITzDHoRUVYc7I9Vsmw?=
 =?us-ascii?Q?gZ6L1Nae8j3iDi1KzZwhCdBanYXAXteGylH4owpJB1FuTLZsMOf6J+F+j7Wv?=
 =?us-ascii?Q?8Io7uPEjBnrutL0HV0s9fOybeqrbXiQYVSLYXNYKTIwYsXvo5msKBHHRIAwF?=
 =?us-ascii?Q?crKte9SL3chtq8g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hjjNVnKQIgizifF8cB9wq1aAB5q79Fnq7jeY/elt+m6PQISwfSARSrn1M/8n?=
 =?us-ascii?Q?e/WiYInsyUAISC6KMRSHsAWmRM8cSXosU8SdZUujBRiujEkl79+uimUEH2F+?=
 =?us-ascii?Q?7AiHk6Vtkk+TANmhuslFGWVSwWITSNyQjV0Ov51WxjCCoLKcM59BwzFbEhBo?=
 =?us-ascii?Q?ZNLAISLTl7SC5ORsnb7DaQ4xBPvUuzrN/qnNcH/0gIM9+VWqbANd6Q4LFfFg?=
 =?us-ascii?Q?4xZKCdKJ7st0F6sIfSapYAA/nkTrqIgYsipIfKlZcdhGV/ka8RuwwzU6Q490?=
 =?us-ascii?Q?vuAkqO2xrwVkHu2ckGfp8JXKJcUMXahZ6/2uwaRWa90US5Mg6jyQql9QmFBr?=
 =?us-ascii?Q?dxxRAtZOc01dGgaiMM/Z9gWHoJHVSivFWUnn7oBzV67ZbeDU1hzM6XjPBW/I?=
 =?us-ascii?Q?qvrLyAjnRYEV7xbFokAyypis3hqUxtNPZY/Hw0w5H5Aq+fF2K50dcaxpGy1Q?=
 =?us-ascii?Q?EZnuHmqBWCnX4v29Vlhbf8L4HUZyMqXzJwETOIl14ueicHTAhPh31aMnY59o?=
 =?us-ascii?Q?IB+njgGrtaUJ4WXDBrWMr/tc2lWXapCLhjnKv3V6OjjzBQ6YWMgDyfYsMiYs?=
 =?us-ascii?Q?lebiuODE0ukS4lLqnKjfGaC7elNWPVUKSBTunJH3HS8FtmOZHajBKUs1hieA?=
 =?us-ascii?Q?H/8Rn/lMaYFcVA1QwJx9rVxTFv+wXDziCYxDl26hY+cmp7LcSxgYx+U6c1UI?=
 =?us-ascii?Q?Z1ha8PwCLXvBChjhgWE8dtD0/lGfb/YZN1+8xR8HqbVfnaMYIK+BlB4Ouofl?=
 =?us-ascii?Q?XRike3Sq4GECOZXzjXRO04hGXxOg8AAl9z8z6hJcFaEBc3p3/FplwqDkfvfO?=
 =?us-ascii?Q?waDmu4ljFzAfeq9SRvc718i6cGd5zNfsVs8isNc1KRnsXRyCesbEs0MPsW6t?=
 =?us-ascii?Q?XhSV+lTaoV8ADIW5uoi7huGCxpU5bcUU1QbT1+BDWVvqiYcL/1xRv0OOX/CL?=
 =?us-ascii?Q?Qwamk6g29aDU+1ub7+RqA4Sb9jrdqx/l6okxDQ2OGIIFxqMYuxTfModtcjjV?=
 =?us-ascii?Q?WIdVAz+Ng9f3QlWTxFTYCSHVRgimSrjWP/zbpe+15xOjhfz0fa2FoXLVwYt7?=
 =?us-ascii?Q?dmcnTVNTMpKvP/kGj0vDbqTh3bhHGab912TY6Gg0x+LGhp/WQS/ISPlpVVnV?=
 =?us-ascii?Q?0KNNXLfMyWialrkJUjKZvmABkBRRldLA4pOOG0G1J0vBXuMuPSAscKZTS7ds?=
 =?us-ascii?Q?qYcIj09MiDjrdNt8L4jr1pGR6yToG5ERrawq2h1EyOAl6zB6QOeVg+ZuE44b?=
 =?us-ascii?Q?hzgs9ln4vvkJouIj21Luzmj9+FTrqa9URkjWw5bm/en88qv40IkIkiTfGJrw?=
 =?us-ascii?Q?+tDlqHIXQb2EsgWOCtXFy8tYD0YyP9gov2Uecoa7Q9Wku+dCH/JvUmbf3fL4?=
 =?us-ascii?Q?GHhC0jwjFR33w6dEK0T41JWaVgFzgeZw4KfbUrbkxwd8sblwZilchkKwETZV?=
 =?us-ascii?Q?csixY9oM4I9IcanzOYHpXJ5nm5CAgXvn4kYQzU/Um5sGL0eyoRr3o8vQ3CZl?=
 =?us-ascii?Q?829BqFZmLQlWlvmk5VydJid00DBlWwlalTt/V/ijdVcwyALg8J8JmJtCfRvy?=
 =?us-ascii?Q?0p5Fbe4x6krBDA3Oz5Qm9v3CyZQgkxhGps9EWHaT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c0c1d0-2ed8-467d-b779-08dd91df39f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 05:30:09.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87e9SmbSPCgtZBSQQqIQ6QVX77CYXAaiYl15pzk21W3x+rjfQeomyHsMfZ80hNDzb39Ig4KmEARFDkFS9mVzG6hMgIpuX0ONsUziSOqKAec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6913
X-Authority-Analysis: v=2.4 cv=fsvcZE4f c=1 sm=1 tr=0 ts=6822d8e9 cx=c_pps a=ruI+LRy+bJmAUyIDade2ZQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=3iKoNwNRq6wiF6nZCI4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: hajmc1A21aaRxZrP4hCmT51KB0AVp_ke
X-Proofpoint-GUID: hajmc1A21aaRxZrP4hCmT51KB0AVp_ke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA0OSBTYWx0ZWRfX+boHXqThtqwN cR8nUaGJ/SANwehDSb8ns3exQsP2upA2SQAj4KWU9WLWEXaa6Fgin7puTJcP9NnCA5EhTgR614k YrLUjwRTm/c8Qtq6sRsEvjZbqxmlSqm9AuG3Qt8p5Cz7atKkzb6At94ArSttM4p4oLRlTaPIqBu
 nwm/QtlyH14f7wqTdqu64cBbogpDx7C9ymeMH/QVtwm8BB3R11Hj6Hx2dv/nAbMvRdXRZscNIid mi5cQGTcxcxJpHCJ/lkLiuVrNY7iurWGDw4Fnkkg8wp0T2BY/xiscft4udIPl1F7zP9opQ7qaIO RUk39L1LirfsItF728Fu/UFKuPlq7y0idLi9kud/6WeA/xMvnDo6o5xEmv2nsv3B/AQJEo35MxI
 CnDR3bruBBabVyfxtsL5wVoPe4G1nnp/SFYtTNmP/UwJS0TUO+gWMzdxA/2ambJP+OF39p/D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130049

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
in the future the patch introduces 10 retries to check with delay
about 20us before returning error code.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2:
- replaced usleep_range with udelay
- increased retry counter and decreased the udelay value

 drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 4824a10df07e..58650b7f4173 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	dma_addr_t cmd_deq_dma;
 	union cdnsp_trb *event;
 	u32 cycle_state;
+	u32 retry =3D 10;
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
+			 * Give some extra time to get chance controller
+			 * to finish command before returning error code.
+			 * Checking CMD_RING_BUSY is not sufficient because
+			 * this bit is cleared to '0' when the Command
+			 * Descriptor has been executed by controller
+			 * and not when command completion event has
+			 * be added to event ring.
+			 */
+			if (retry--) {
+				udelay(20);
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


