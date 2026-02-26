Return-Path: <stable+bounces-219860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F9OA+e4oGnClwQAu9opvQ
	(envelope-from <stable+bounces-219860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:19:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DF1AF9FB
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D29053090E9E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074D478865;
	Thu, 26 Feb 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="kvTIhvS2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="dfmLAoCY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778D478845;
	Thu, 26 Feb 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140537; cv=fail; b=plW/x4AZI3Be6eRx0dD0M+A23EElifM91JZSCJV/OTqepP2XhggQ1WdjcIFlvkueZtUO0O1hOvkjBMzT8efO+mfb8P+g/xON9xRYF3WtVTORPLhXXyaml8iXj7BFKoKyD8qtQ7wLxW9XhfIQvrF1b+Z4NBjE9n6RLifLvLm2iJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140537; c=relaxed/simple;
	bh=gjsQb8QnKKUQJMIu9Ok609mugcbbzeSK7FpVDjtk4ZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGCWUqSGOahTsoyQsIVbpJPk/78m1fkqedxVhIMe9Vl39d4RabhPski1hgXfPu8SkvqyDz180+ImnM2BEyukr3zDqxKljoeG/mWON4IRyYe/2UnCCJB86bfQJf/OYYu9hHWe84RclRkoP+LFayPHaeKfyomjWNRbhaQItGJEw6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=kvTIhvS2; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=dfmLAoCY reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QKN7Wa723203;
	Thu, 26 Feb 2026 12:36:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=OUMRj3Yl6MLBFuG72dOi9Z2/GBHBn9v3ngMdaib3WfM=; b=kvTI
	hvS2lwF5JmZuFtfWxICEQm0EuigcW9HYBGyyeIoFUyu3yGZnqRabOifm463p0Cy+
	YaZ+R8Px4OXX9uorEwatbp259xprjFajUb+Ey2IwiBZ3TML9P6jhBcmt4LhrxqzH
	qEEBsXJdVyc5bqBLh9DCoSKFPpe/bRPxJWuQfwFIGajQcfTq9YnpHwMBrLse4e0U
	cbZdpxLJXoP4zy5p48vJc9PGslLTTF1IEGgjjLGRwE0Pr4+0JwPkJBjlOjPI1SGf
	1dFqZtqwn0Nc7cay86vwaGNGNTB/d0GBh4KR9rGrhbHevhM+MxUvcCI9+0fwzDlX
	tegzyE37tiyF9KOW7g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4cjnuka74p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 12:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZk1BhJ5476X4SWCM2uOLQBrOioGKo9bD8toR8i7QI+ivSMlN3VvXHTyOoFmMUqeRt2kcDtwxJtFm9SyVPfE0C5sQ4u70XIw0CQ9PLcl7+q4f7ZIwjHB8scliT+Jro8WrLOYt+tsskWtdVQ5XMI9oNuRoVlpKLEMojoa100zKNCv+t0SinsjxT0Wh09u9+9v+riF0PFKNlFnD6mnMfFZRNLxszjRN/guOpESkH7nXMYdNrhnzuajI4+LMQiv68xNalwSK7Gi09u2L54UmMgYAuQw7YkMFMbnMZvm3B9HNSlFln40r/1kEFg1mi1E77eEr00+88fYkieXTUjREbJ7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUMRj3Yl6MLBFuG72dOi9Z2/GBHBn9v3ngMdaib3WfM=;
 b=rR81KcJHQISO29Utad+zjQdQP5SIaqylvmr+bfXYP+s+VQa8gt304aG/L8iOJJc+AjNJqtt5NZzlnBJC0s8mzjpsLi9ZqJHZ+ZMcjUUjlEmFpPgL+EvS2O0LjaU+au6sG1bT25mEa5SZ85ZevO/2qK9N2gHnkzlnaj3v8Znqr4YZ/HJICc6PLfXFsG+WvdkK/pKoPU70fta4yKMBOJZXSv88eWnBRHD6L62T7MCsvPHDyrSjyovMCTHvGF4G4+YB+sLsRoET4z/qwOzgsGdGRwn6g/4/+6xkkXptsgQSbd/1aXrzwpahwNHSFvmsXEIeLlDkiSZ0bXN1iaatGcUZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUMRj3Yl6MLBFuG72dOi9Z2/GBHBn9v3ngMdaib3WfM=;
 b=dfmLAoCYXbvD4ZZvnfAerfsv4E18870ta/9rQj87lq7NTBIO2IP7U9wlhYLYmHF/lEcBL7gAGWCPDqlnSS4nadQqwUC32AejWxBEwrrlymsGgefLhv9AQCMaNxhh0E3Rj2Iy5tfp3q8UZgcngIn/PdomPV/7/+TRlFCO3K5zKOo=
Received: from SN7PR05MB9749.namprd05.prod.outlook.com (2603:10b6:806:346::14)
 by SA3PR05MB11099.namprd05.prod.outlook.com (2603:10b6:806:464::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 20:36:12 +0000
Received: from SN7PR05MB9749.namprd05.prod.outlook.com
 ([fe80::a972:b867:f007:4344]) by SN7PR05MB9749.namprd05.prod.outlook.com
 ([fe80::a972:b867:f007:4344%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 20:36:12 +0000
From: Brian Mak <makb@juniper.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Thread-Topic: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Thread-Index: AQHcpq1xqdkfgwy+1US+LCdpxjnE1LWUlXMAgAADPQCAAMlvgIAAC92AgAADtAA=
Date: Thu, 26 Feb 2026 20:36:12 +0000
Message-ID: <8C05C22A-D7F7-423D-B680-1A274ABDB81D@juniper.net>
References: <20260225232105.454931-1-makb@juniper.net>
 <aZ_18m0gYBDEpSlt@smile.fi.intel.com> <aZ_4qqZCnpMKD_5q@smile.fi.intel.com>
 <E3EAF942-9F00-4214-9411-1B3612C8C3BF@juniper.net>
 <aaCrlxEW16n5iPa4@smile.fi.intel.com>
In-Reply-To: <aaCrlxEW16n5iPa4@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR05MB9749:EE_|SA3PR05MB11099:EE_
x-ms-office365-filtering-correlation-id: 3e04aa19-2b6d-4a22-99b9-08de7576ae7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 wFdH39eekQ/6Ldn9QFaaToTbephTbrLn3LBC0YAwY2FUl2ATByA1kzwAutO5aEad3DEoe04xyt8bjk/i/HGRDI/U0L5YmmVq0LkzVWx8Uc3AsJKSPGWO2NNuoBC8EDdsw05Av/PhfCGJangyEyFjwnV0wFmVoq2F0hBVzdjn5iXHYLt0bUiVTjykVNP6mXCrcFcxzCPmQ5IZpDh58DPalLtoy38UzEdfMvCyY9/fFpEQ2cOXHZIbzVllJ3BSbfepzGWuIjRh2EgL8BD/S/H+b1+LzSLtIFpGU4KUKcS95Tm9qt4VaX+5eUgJ/a0OY7MVOgF8lhafq9NwQ3TIsUgV1ss4Ldz0Ga8KTsg5XGlofRY616ZXstSia8ewxD0nXjwRdHwdtNfj5Y6YR1Y+jWj1y9AMvwR0dT4RQ0OZ7taeeotnhIdMbHlrk6paxAm9PLIz6S+eMKCRoKsgnIZvegGS87ZSQG+RLzQc3g0Y1xvKuZMdoaI2SWBXYqcuRw4dVPJ1zfScwzLMrSNYQ30itOwuEdOvvk2mLo/grichinlAE+XVjs1931f1gfoVJA6x8Qf/8EltEHCov7YnQpbEPHfe/i9kEl9/eaJ3nAGU8zgHgKqCMiJY1SNVRLyEdujCZYDThT4aORl5mjY4EDpxmIVirVE7kmlLl7HTF0blCWLQNjQakMOnw4o7SwyNgI+AT2D+wj8aGVoT+VJjc9/tmfLkI8wmlD23Cg1B94Tl3JDF6Azx/bCTaMR4MyOcviUIzgjSjbfWv0YOqE6TKIdvFTPQvverEfyrvbdFVb4FqcJYmmA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR05MB9749.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4LRcf037Bgs9z/Ppsq8EBB6Ioz6J7tznyK8tHpe0yuq+4WlPExeU8vX3jT0O?=
 =?us-ascii?Q?UpA85/l6CSdpHev1S14MP9FUSqEgvcdmistpnFThUNs7O3fwmnaPpK1Pn+Ys?=
 =?us-ascii?Q?DdI0Lghzos8qm0Y4yEhjJz3AYfiHAAH49qcTrvTw85TahNQgQaltTMGNQmCV?=
 =?us-ascii?Q?9/HrvQegjYOswWYILa5mas+co2kTbdZQO7Af/dwWroJCP0U7P+eybI4U1+TZ?=
 =?us-ascii?Q?TlU8aYGayBgBKCBx/NAidGnsbadyiveW9KrPMqnXZEEDGDjJUVt73FbVHdQi?=
 =?us-ascii?Q?t9kAMZLiTJEsZA22XGexzVN8McPFXLxTNga3lIvqEBSZZnGeifrTAhRplKH/?=
 =?us-ascii?Q?qSwZP1fJKVP9l5q/rzwHE43N8lEHe+mOLB0z+cXReHcGMaDFDqdoDKdKpLQK?=
 =?us-ascii?Q?jb7md8zbgLG9lnApfrGklzfRlxKTSGCPgkU8eEorK1W+7Tz4gCOqj8R9Edbk?=
 =?us-ascii?Q?jvcucjjbmHM2YotuDSbcYIvqhwa+6qhs9+QrfXhJkxKJmE3d5ICDEQO+Ciu9?=
 =?us-ascii?Q?Pyv3pu99+PxPxXAZrxs3+js+9MmjzPO+88JNytwc71FMJSVz2L77vWUMfx22?=
 =?us-ascii?Q?Ez3jCnnc/6tNiInS3k9xx1p8vssNFs1Yl1zXfmoXMowdCsHjarlAUldCooSN?=
 =?us-ascii?Q?Q23FqJJEhjXv3WS6t6iudkBf0PW6g6gZaflzlH0NKxeaNvcICqSJRgSpomx6?=
 =?us-ascii?Q?j6zhEGtbxR2u9acPn+NEKoD8uJzhe/Eqi6gAIGnd8jaMZStDKZ89MohBea1F?=
 =?us-ascii?Q?reqB9u9eilCqJ6XZxkimogQzSww9UnfZc9aP7O0VQ4SmelWam4zwlhvSi8XF?=
 =?us-ascii?Q?w+ohpuQca6t+gpz2EGiY0kv+snLweeVt50ECmxfY6+G8EzmNvQW5s6hdjs8i?=
 =?us-ascii?Q?HGR2tqyLvpCDDXqwGKL8gq+uSQXUozRjC728U+r2xv3GJra9KdAOnVfD8u1n?=
 =?us-ascii?Q?dD9fg2D8TIbhc9C74ofFcjeBIzB6IVHIXpQYuzBMiqr6AUr3+MWlVYUOUIDs?=
 =?us-ascii?Q?kf7YnLLGDSvQHpS34dVn5MLB52+6q7vYdfoe/ZH/ooA6iCOGb36Gh1TI3/Z+?=
 =?us-ascii?Q?ZRczLxgVPcr587WveiodwgnIaMkLB/OkadBvdrMsEtOduBi+ewyVYf9l3B0g?=
 =?us-ascii?Q?JjqQUwvhlnu0oiZgNlz35iJC8wiVlDz1h3HWZn+kxb0aQA3RitWWFLrmQIoM?=
 =?us-ascii?Q?TrP4bw6fs679copJNkk7lEMsOjSPqnPTEvWEB8n++BlYHnOYfzSI18leV5Rt?=
 =?us-ascii?Q?TvzvVg8IzPAiEhUBHmFdO647GWJ2p6RcjzQwklfVKxGmj9DIhhIQGZ3jvARO?=
 =?us-ascii?Q?57goWQCIsONitJdwSx0nB0shOI0veGPtj0vDlQdMMYAJGQ5qXntZNwwyk8GE?=
 =?us-ascii?Q?eq6+wjUNYQq9uWVaxt75hF+UzVQImaP75C4LwUJUq9ZjW+ggMaxIqtxgMHzf?=
 =?us-ascii?Q?tvndmPNUlpD/Jvt5GlPnpNxcf62IoMp/W+HWp+2bcQITXlFSK4SCgeCJu8G+?=
 =?us-ascii?Q?vApmek3a6tPyXbc9GDScJve36BCEA49xjdVfilUvgVYkwpyybQ1cJfvXZsuc?=
 =?us-ascii?Q?j9JdUoKJLxk376JNd3sxhYHsC8mkbwY0CdQ29UiT3k8tCqFQpK5MN+Vdfwyc?=
 =?us-ascii?Q?EdJGBr5LohkmmbaqZJ5hSV4xkdmGF+neeqnKabprlP7ks/to/SfrspiKf0D+?=
 =?us-ascii?Q?pJwaWdLQTAA4eTcw7OgdygsS3Pm3oPTzg2g8BGuxilJI7e+kVLa+aoo0kwIi?=
 =?us-ascii?Q?RK7mVr7ZMg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A71938470606944EAE064A54A53E4304@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NUJfCbmPLh8nHoqeZCNAogJCGNcZrHyDf8btopDbUhyYixfVdPulAFfLnBMErepqC446krrFyyxg/WK7ElDfRvLXggyRgrnQyi1lzhI+N83RfKhRl2E90ZeTyNc/8alVGsFS4hBqjesrJyPvIHNN5NEpoV2r6L/K0kLpgWQuvmvANUho1ND69GbLZ2MKcgmsa6P7XbquKrIURtZ8muaBXn7PMOD8VoPNycZVlCPvWOYp+ziZA63AZQT/IBixKyOKt6NQry0RretfvN5VbJ0t9uYDyzFTHMVOhwhrOpYnMgB+jhXOonOmdSvpgOoVs4sm/5RZecyfJP+6UZ3xeq+43w==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR05MB9749.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e04aa19-2b6d-4a22-99b9-08de7576ae7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:36:12.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Po7lZ/vOxwo/iEnu254PKGUVeIaT1Dh9BfA3/i8soMOncfyPvjm8HhvdQ8kotWrBtk5o/G2zSHRlJnMI3E3PQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB11099
X-Authority-Analysis: v=2.4 cv=cLrtc1eN c=1 sm=1 tr=0 ts=69a0aebe cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7vL3O5uBSuztJ3xaqtyr:22 a=iQHEN9yVhjWw7-rk4WGD:22 a=QyXUC8HyAAAA:8
 a=1M6ubzLRFaeA2MpaWk0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: A0dv4Gv4gPrS0Q9aG5FCYWx_ax2l9-p7
X-Proofpoint-GUID: A0dv4Gv4gPrS0Q9aG5FCYWx_ax2l9-p7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4OCBTYWx0ZWRfXxjyx3IqQwDWL
 AlA2zmj5PNJoebGh+3Cc0Cv+dXd053aIJNg4Dr4AxtSlC1P5mYpdbUaohTG+W/EcyCOs5s2S9sT
 2OiTa3Unm50x/RpQmwY/Usa4uLhrmmTbNm0UQjHCO5gOthV0vcbXQgByM9QkvIk1C9aI/hiKn4K
 HWfwFA08+XPqWWggznQ3ojUk/1m0pEGfYLsIROaiGXpvM/DY6JebTvNj/g2od8P/JbvjB67D4CE
 7EHmElg/ZBnmW58jyDOCa4K3bhoJxvxhf6w5BxOhzOzkBO/0lmxA4VIV0QsYPG3D0KxgtHV8WcK
 4JqQMKaEWP12MRcC80cK8vKSWS5+lnVyU/Tfnspht+cwdoQNiiN1Ki3lyWMYSDbUr3szz02u91Y
 lW2c+jzwCWsq9okZZXVxWTP+0LjIJCV1KfiC37JqaIp1K5TNN8AEyRcXGIkcz9L97PIz71VGUHz
 JAXd7oFNa9ypgBaXHHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219860-lists,stable=lfdr.de];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,juniper.net:mid,juniper.net:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 773DF1AF9FB
X-Rspamd-Action: no action

On Feb 26, 2026, at 12:22 PM, Andy Shevchenko <andriy.shevchenko@linux.inte=
l.com> wrote:

>>> Even more thinking on this it looks like a violation of the levels of
>>> the fwnodes. The current design was not expecting the ACPI *and* OF nod=
e
>>> to appear in the list. They both are considered "primary" from the desi=
gn
>>> point of view.
>>=20
>> For my reference, is there anything documented/implied that indicates
>> that fwnodes were not designed to be used in such a way. To me, it seems
>> that secondary fwnodes are designed to allow drivers to pull properties
>> when the primary fwnode does not have the property, which is exactly how
>> we're using it.
>=20
> OF by definition is _firmware_ node. Secondary (when it was introduced) w=
as
> only about device properties (today is _software_ node). The concept of
> using DT overlays on ACPI platforms not new, but was implemented much lat=
er
> after the initial fwnode / unified device property approach. Basically
> you are (mis)using it due to the design limitations / flaws and historica=
l
> evolution of the concept of device properties.
>=20
>>>>> -   device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>>>>> +   ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
>>>>=20
>>>> As a quick fix this may be fine, but it needs a big FIXME explaining t=
hat this
>>>> is actually a design limitation of fwnode that doesn't allow proper sh=
aring
>>>> and stacking.
>>>>=20
>>>> Bouncing back to ACPI_COMPANION_SET() also doesn't feel right as it hi=
des
>>>> the real thing here, and real thing is the primary/secondary fwnode ty=
pes
>>>> that we need to care of. Just call set_primary_fwnode() directly. It h=
elps
>>>> also to get rid of ACPI_COMPANION_SET() calls where it may be replaced=
 with
>>>> simple device_set_node().
>>=20
>> Sure, I can call set_primary_fwnode directly in v2. My only concern here
>> is with the FIXME comment. To me, it seems like the fwnode API has
>> already allowed for such a case, simply by allowing there to be a
>> secondary fwnode. We have no need for more than a primary and secondary
>> here.
>=20
> Again, it's allowed technically, but not by design or definition.
> primary =3D=3D real firmware node (OF/ACPI)
> secondary =3D=3D (kernel built-in) device properties (software node)
>=20
> Your case is primary + primary.
> Or let's say not-so-primary, but definitely not built-in (a.k.a. secondar=
y).
>=20
>> Before I add the FIXME, can you elaborate on why you believe we
>> need more than that?
>=20
> Because tomorrow it might be an ACPI device that uses driver that already=
 has
> a software node for something and you will want to add DT overlay to it.
>=20
> Or even more realistic case is the complex device where we have one firmw=
are
> node and several children which want to share same firmware node with dif=
ferent
> software nodes (this is the case that may not be realised with the curren=
t
> design).
>=20
> It's just matter of time when we face the issue in full and some poor guy=
 will
> have to address that somehow.
>=20
> What I think of is having a reference to parent and child without limitat=
ions
> of the length of the lists and keeping secondary as a sibling pointer.
>=20
> This hierarchy will allow to have a tree of fwnodes where one may be pres=
ent
> in different lists as a parent and/or sibling. With that we probably may =
have
> a tree-like structure with many possible combinations and relationships.
>=20
> TL;DR: It is not a problem in MFD, it's problem in fwnode current design.
> FIXME is just to make sure we won't forget this.

Your explanation makes sense. Thanks for clarifying! I was missing the
historical context and software node implications. I will raise a v2
with your requested changes.

Best,
Brian



