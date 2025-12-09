Return-Path: <stable+bounces-200497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65CCB174D
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E7130AEC94
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E926E17F;
	Tue,  9 Dec 2025 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DSM3UkNY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE821E097;
	Tue,  9 Dec 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765324565; cv=fail; b=E/1aleiB4Qdo+PUSgZpwvZkAK8TkLKZxjXsToxLXm8FddzBDwd7ino3SRgXNdb6zazNTLcZtMZq6i2TTwZgcw0U0mFBPhL7I6rirHYH3A4UCyu7Dc4nqOq+YpsszUnKMy+wKiDzT0izk9HFgY7xiDft3kNLNzb53A1/OEEYgUK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765324565; c=relaxed/simple;
	bh=DgsTOpd0anOP9X7i7VLT6+aD2LudswOaW/Xq+4u+5A4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYOTtcbgw68JApNxN8RaT+A/x8pEzSfHM36invpNPNTlosHNDrJZqE4pcg1vFf4ShbNY8JTofAYu7Wi/f5ToxGdcOQNfArj96DNq6tZGW7L74vYocEhxnsSDnhQ2G6hOjRmWQhrw/SaaVG9FuQlscdDrvj9IxXD0gLMbOkkU+vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DSM3UkNY; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9MDsSI2082307;
	Tue, 9 Dec 2025 23:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=54NgUKPSEmkeSW5JFC7Q4/PI1YAOV9Htz4TvNlGFyJ8=; b=
	DSM3UkNYxat9n2euYoYuHAllzmrrnYnQlF7gRDa3AFWzGPjjXMGv7FYFYRQt8Koh
	m22zhInFFgUf0cIU5G9+EpKnjyuy51LRESJHyyaPj56oMtiDCcxw6kiM1SMlyQFX
	v+9MO1iwmoLdQAYSkOzSVqDcMNzyCL7xX1vnogTuQl+zg5WsPsBXPM8xIBKWl+QH
	GHwQ8BM15XK3owogzal/TiW6X89XB58LTK4pN/Jr1o3b0ek0+ChVIczidnoFxPLq
	ZEn0fbNpF0A9NuWaScUQm9/wG5ebPBvxeVbzrNqWnKCFjY2VJLmfeCM7Yq7kxA9C
	b9xqYSjxP9xo3Zml9Y/gCg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4avbf6uv5a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 23:55:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSjaQMKUuX3lZGdNXhXcaGzMcUYt4VBAsWQ32qXnd4rD8fcQqcwVBFoofqHVTI1nJfqStr6AKLulQKzzhNzgED1kUPJGbcco9PSe81YltZUfVGmW9ulz0sQB0B6kpT2LVD3DcGAym5IiA/BZMqmiz/y4b0N4Dj8DlOVCzsBA2f65vfFngj9/qJAe6bX3o4xKm6Og8506R1KejAHwIikrGVc4eZYg6/jlgrc14/x/tDoPzfLVDYAYNhH58HVurD17WCm5oyjyre92Tn5EqQeQbls1ZWMOkGEUozAot5Xpp5hgnH7ae9UieMWs6fb+8j7+0oc01SVCl7QyC9DLmQiDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54NgUKPSEmkeSW5JFC7Q4/PI1YAOV9Htz4TvNlGFyJ8=;
 b=ljR9zrtEvXFAoHTgW0T8bhnEAcZHBXGh0wy40HM0i+6SXbO/NForjcbDmWDVmlUl+ohwyvH5e04B8kRe/s1Iwld96Jd1bHdiAHKpvYhcDgRi8fXbNGDda6n5loJL790CtM8XbpH24oY9pSPCh16D64PnPjuhuELMoELHs5aihfAong8BQ67w8arwKkpxMpMtRtQIc9MBi5qNOenOmVfTxQGY1bRBPPxx86bSFuXlXViQEw3ePbQdFEvtTdvWzLnNgpZXZagu/TKW9DjOmKepXMdpYHsZbidrh/9+8E5klWko501ijKEANNivbiZQc++S/mAbWSyAq/kt6f+IXas+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 23:55:11 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 23:55:11 +0000
From: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To: Ingo Molnar <mingo@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "vigbalas@amd.com" <vigbalas@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/elf: Fix core dump truncation on CPUs with no
 extended xfeatures
Thread-Topic: [PATCH] x86/elf: Fix core dump truncation on CPUs with no
 extended xfeatures
Thread-Index: AQHcaNx8Ag81ULkC+k+4juZLIA+dBLUZA/8AgAD4q/A=
Date: Tue, 9 Dec 2025 23:55:11 +0000
Message-ID:
 <SJ0PR11MB5072F196CE31B9371118153CE5A3A@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251209072124.3119466-1-yongxin.liu@windriver.com>
 <aTfmLKlUjQN4e1Zw@gmail.com>
In-Reply-To: <aTfmLKlUjQN4e1Zw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=aebb0c4b-6049-4a64-82bc-7705c1bc4be0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-12-09T23:54:44Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5072:EE_|SJ2PR11MB7670:EE_
x-ms-office365-filtering-correlation-id: b617e231-4b73-48b9-b594-08de377e640a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?htqESYiCsZh/entebJkDvurNf+gb9DdFU06QFxGg9bU+64bCnQKKWfgLAe7Q?=
 =?us-ascii?Q?jgHAa4kMud4g8/7xPCm1dRzUM+6ObuGfWpHNdrLvjNYoiXDlrqgYj+H3nwcT?=
 =?us-ascii?Q?CZNXIMBqUK6j6VGQemuZ5QJoroM5gOHijp/5v7zor9g8eA4H6kPl00h8COOq?=
 =?us-ascii?Q?XYc9Sp3y93VAdPPgKno5uJRAZFkYOYNBfqbI+2biayJi8QzilZtltI4h2uah?=
 =?us-ascii?Q?6f+Ty3c1RqQfSjyatPtXlpx9MlGysscQ3twoWvHPuycWnM+X99z8rqVPgI7m?=
 =?us-ascii?Q?sFINCMDYlm03drjGzAfxTPyvifmYZRwOh7woz2TB/2bsrHzow8ij+B3d5DE9?=
 =?us-ascii?Q?+AHpnMXeRejDrOYl9vnkLI4lqsHZM/EneL4r6v3b3zlkjKwzlg7qxtE8+IRM?=
 =?us-ascii?Q?3J9Hq6JsfplL27n9ohHyGxqaG+eacD7GtQUwZcTJjAz4eYQrN5X31IE5wI+r?=
 =?us-ascii?Q?wEFJeuyvF61nCbgYn6QPb6SUkKjVE9HKG0+lELX2GGj+NXzq1BnuRKV5Dyz7?=
 =?us-ascii?Q?QJ5AvhFLJew9Be4DRzAypWX5lqlYSOPfcQoLssegW5rbSpy7y+/Sy4UJZnMs?=
 =?us-ascii?Q?VE9j2htHPO0NMyZJ+2fotYUCn1xmMDFD44BFfqQRmZ4MhuJdBsFhl6NCfJTX?=
 =?us-ascii?Q?zHEm0jUboR8ZlT4TJfC0q1uXSkNMjvo58Xd0KFIYYWoAB/lOK+hhq50nQsIM?=
 =?us-ascii?Q?6Dz2liq7Up0grVFngdoCSgKXa7wXqQloUK9cTZvqJA43d/sgLJ0rOeDSwXO8?=
 =?us-ascii?Q?nlWfiliISnwO+nW3vvc+bU11JR9IwhA8wVc916RYDVTZED/Gwgmqw3zgkrmx?=
 =?us-ascii?Q?jx9w2dnguqbBqn3/rwa7eBS1S+m06dXkEvO5HrN10P3+fikcxMaOl4/bwTzj?=
 =?us-ascii?Q?Aq1eoUnUmuGU9FEbQ1GsdP4w6YrOGlRKFxos/MQprA4L8n4ZlvDlFeUfvRg8?=
 =?us-ascii?Q?mhdlvp7aYHn9+Y5VwYutd5EyZeJlvcEZugwYSrpbB55kesEw/Obq+zWrnYJg?=
 =?us-ascii?Q?m0uCOFRgXFrdRbUm+81/9hd2OV/DSdQAwzS/YzCtEewNr7lbPUuzWUu9Bz9H?=
 =?us-ascii?Q?/qvxG/vOEq1rDDWct/fW8w8n1BstfuksGRxOkmr9sB5ZUI7Q5vCGCmxwVsq5?=
 =?us-ascii?Q?APDnpLSedY61ZjFcs43saxO1cIcAmglYyfFVKPDB1J63eBx5i4d60dNB9OuA?=
 =?us-ascii?Q?gRNOmJBTBnJMSJjP5d3A/+J4G1TPu2G3S930dxAMCbRGkfTZtAtDr029/v2j?=
 =?us-ascii?Q?ityvoDUm+B7eHyRPkblPE/CChf5y3UyY1PxQGxTWIvPUHWNaSC3QYnUP97KD?=
 =?us-ascii?Q?SptZXYvFSoMG4QKd4iUdxuKbWvvVy/L8uY/xqGHrPtFFI39LqCuMUV6MccF5?=
 =?us-ascii?Q?R/5R++2lYhjsYAAiFQycg/3oq1urVJeen4e2abgR3O6KMCvmmzkBcdx02+aA?=
 =?us-ascii?Q?ZKs/vEfNHVpPCI7/52/6hyvtkRMmcwZf7H5OPk9LfsmaDpi8GNXJ1qsh/z9s?=
 =?us-ascii?Q?T8r4Db2OnY5X2bMPNgSF25iOHAP64Cm507nt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rO7T66YMg5wjJXs6ArMbqGM4qzwmqWAMNhZ4xRcC3qs/SUQImPIjE3UbbLr+?=
 =?us-ascii?Q?utT8oGnDTMIckMkLtBbhDo4GfGPw7OtO3Px7PCXT9gB9kPmmwHnVycfmCp4f?=
 =?us-ascii?Q?qFv0LkrKQ94mhOJxEfdIquPIrI5lprsdZyyo5kduJ1leEfkDTkjBTzLYi/4v?=
 =?us-ascii?Q?nkCAZadjd1EK9MzSC/5oo9wu3StzLuGSpg/ELMYrIIV1PP0CF3GHnpq2n3e/?=
 =?us-ascii?Q?E2Ki13K67xwI1+yN4VNsStlBSkBEbmW7Ah38T+XWMWenjy1EBDtMtQS8iB9c?=
 =?us-ascii?Q?oyYnzdMQWKkkmhug6TiDzKWO4WKP5Ztzgcw9xebRYJJtvzDz7plLG0xo9CXd?=
 =?us-ascii?Q?UUXHVQ4hsRs0nVE18fzThAvNLxvajyHYk1bNdhjqcsNKG0ITP1+TwgHaxdbL?=
 =?us-ascii?Q?jU2xt6V7EMCxiy13Gzr04K0QQxTz7AIoD2Yqg9x3HVqwUBKOx8F1nEAQcnGf?=
 =?us-ascii?Q?AwJAmqaNMqeE5KDVBHCmRFQqnHCoTM2IWk3oROEM8NIsy8oVPYSpozPl8sb0?=
 =?us-ascii?Q?1PcB2fA9d28MmflLj2/JpntVbXc+zRi1lzlbPaXkl/H93RxvUbwUF2ctZAUq?=
 =?us-ascii?Q?Jha59zhqNIKjM+VHqt0WYdb1JyXcSmsJKHWNZvyQVsq/HiG430e2lbxtdL9Q?=
 =?us-ascii?Q?avLrDJYvyzEmhhdkVFTjfd91/NcOKvofXXLkr17n1lv6JZ8vlP7a/+1aIKMg?=
 =?us-ascii?Q?S3Hees7wZ/ItverVBZ3sA7prdvasJEpQXsSNRRv0PfL8EBYOCbhiEkjhtzFN?=
 =?us-ascii?Q?NozJAs9uK9mIiBbIlMHvWO8dGwcJidf2h1t94iiegE8zUxfESO7aZPNw9ZGj?=
 =?us-ascii?Q?PT03i5P+n0clfxcdZ4YOSuZJmG39iIoSDvrGcAWY94+WFwlNN3pv2oHgwQfX?=
 =?us-ascii?Q?luJU4f7NZPSSsqUDc4YPrKLeI37P5ypDeUr9XH0vQq3QetEawAfQJpEosEwr?=
 =?us-ascii?Q?blBR78AlLGX0M5raFBgduJ46t6cobuPOSGQb97NB+ETbJXLCziGUUnh2jcRU?=
 =?us-ascii?Q?ki7hd85YFLTncaD3L3n9ubtc3xs/lWJg6KSffiXl3vPv6fDhqmm5DYqaro1W?=
 =?us-ascii?Q?08U4D+4L7axniKte7U/cByDvseq9HH35i0uYfrV7qJn5MHlhqx7FT16nz1RU?=
 =?us-ascii?Q?vnUJ4Yv8sRP8/bzb7MCg8o2NOicAMGAA9rKrVBeRoRfXDCpsmrNFW9nZe+zY?=
 =?us-ascii?Q?PrrgS5Us08jE5qCPhxEgHr4ShcYoEF7UdrKWv+vjf6oX7lHfOtWt1hmz1cHK?=
 =?us-ascii?Q?vcS62QAAszHv6OjYnw9mfR2sPlmJC9b+8dkhrhAL35a8HNDN+H7gnvp5O9D9?=
 =?us-ascii?Q?R933CDv2WH60MuY5ebw20P1WOMNwnOZopoZ2C99kRU81NQtvrYzA5v5aXPqy?=
 =?us-ascii?Q?AE3mb5f0TyT0Qi05Vcfodh0WfYNgjbdlQ+G5VlYjDaABi6eONvMrG2sPcaeu?=
 =?us-ascii?Q?lC4XV8I8JCtXr/TIgl6AzgTBUC10KYH/cCmo09MvLVNKvt3sI04Whl6DK03z?=
 =?us-ascii?Q?WERzrPk7Iv4rtYmbwMPdiQ/fMYvYM4h77FuQvIaq5W4IineFzedWLmGuKQu3?=
 =?us-ascii?Q?qfHpbt1uQdsEdlka47ujCq5n5KcjF9Bg1Q6uie1z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b617e231-4b73-48b9-b594-08de377e640a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 23:55:11.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8NQqgh6PEc0Bc+7dwkgQTDQjCrrSFiHZ0gMDo1BbBlWLmciWOie3VLsba/swk14lzztqqPjMYI/yB1sunx2dX3zM3U6+5YlFwOJm6IGwro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
X-Proofpoint-GUID: A-6s8uGLyn9OmuresXrXt--_ZwV95M23
X-Proofpoint-ORIG-GUID: A-6s8uGLyn9OmuresXrXt--_ZwV95M23
X-Authority-Analysis: v=2.4 cv=Io4Tsb/g c=1 sm=1 tr=0 ts=6938b6e2 cx=c_pps
 a=+6ZDvk2G9QUnVG1E9ywKdQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=8PbNx4cplFqxVkNrBEIA:9
 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDE4OCBTYWx0ZWRfX4hcLKg42E/Bn
 XnDauDNM5meFrChWeXF43aGRE0oOYF4wIfbtGBQNNk+zbPTma8uCxKQioGaXSDfvMiIdMOtjf52
 KoTxBRlkXrHrUjY4gNqS42UAFxwv8n5815EFtLBwdD3GTM0qYqG3/hzRXMtCdI6iX0i9a1xBP3t
 ZdKUdZlqqMi2x4i96/8qUuYq6lOO82P/vqn3fYLkkGGoQ2ZNssL8dRfRsYDr6q6hXcMOKEOLis3
 UvUJfZgouzBE/s/7HLy53IY1AH+IAwSVX3RUtN49e7LQf4A02vxeSJiqsmLVx0qUAw0VqLJRSYk
 APjJqpOimpb7BeaVY4VQuEFX/DnfkY8NUWL2p12sDvmIjGAB/ZEkQag4VeVNYelOUq3d73vJ2Dk
 oYOnRgIPxbBO8WMPCZ7xVtGzpew59w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090188

> -----Original Message-----
> From: Ingo Molnar <mingo@kernel.org>
> Sent: Tuesday, December 9, 2025 17:05
> To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de;
> tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com;
> vigbalas@amd.com; stable@vger.kernel.org
> Subject: Re: [PATCH] x86/elf: Fix core dump truncation on CPUs with no
> extended xfeatures
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> * yongxin.liu@windriver.com <yongxin.liu@windriver.com> wrote:
>=20
> > From: Yongxin Liu <yongxin.liu@windriver.com>
> >
> > Zero can be a valid value of num_records. For example, on Intel Atom
> > x6425RE, only x87 and SSE are supported (features 0, 1), and
> > fpu_user_cfg.max_features is 3. The for_each_extended_xfeature() loop
> > only iterates feature 2, which is not enabled, so num_records =3D 0.
> > This is valid and should not cause core dump failure.
> >
> > The size check already validates consistency: if num_records =3D 0, the=
n
> > en.n_descsz =3D 0, so the check passes.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86
> > core files")
> > Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> > ---
> >  arch/x86/kernel/fpu/xstate.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/fpu/xstate.c
> > b/arch/x86/kernel/fpu/xstate.c index 48113c5193aa..b1dd30eb21a8 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -1984,8 +1984,6 @@ int elf_coredump_extra_notes_write(struct
> coredump_params *cprm)
> >               return 1;
> >
> >       num_records =3D dump_xsave_layout_desc(cprm);
> > -     if (!num_records)
> > -             return 1;
>=20
> The problem with your patch is that '0' is also used for other errors,
> it's the all-around error flag for core dump helper functions such as
> dump_emit():
>=20
>                 if (!dump_emit(cprm, &xc, sizeof(xc)))
>                         return 0;
>=20
> So please change dump_xsave_layout_desc() to use negatives as genuine
> errors and otherwise returns num_records, and change
> elf_coredump_extra_notes_write() to only abort on genuine errors.

Thank you for the review. I'll send a v2 patch addressing your feedback.

Thanks,
Yongxin

>=20
> Thanks,
>=20
>         Ingo

