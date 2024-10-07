Return-Path: <stable+bounces-81310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87847992E47
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E9E1C23174
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B11D3560;
	Mon,  7 Oct 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fINlrJMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N3U4LorG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A81D279B
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309981; cv=fail; b=AER6w4ADFCWlPgUA85Db9jpRflJDzr57MINNLqC0k2k8q+ukcwBC64uEshXblHMw7sSda26+DRV8oIvWrUoTT+oVscFoLwUHojvrUVS6fLzxZFDoMdo9AD01jhAUxYxCTPKIjFU7OZLre/kRtKs3Y18nYv4EMxpZz77nPhBueRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309981; c=relaxed/simple;
	bh=bDrEjx7b2TuworSlHAN3r3uwVyOZc3BZyXCVHBS04vo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MdD+mdMT7K0IV6jW5fdxYXwj6ij8KbEmXRfGMmgoO0na/3LfjqFlewgH3c3VDFSYnHDUu3oz/qnBobN5GaNnEPPDBHoLg9sg0TlEkZ5mBygTdMQhHDLdeSxCp6/1nSnsFykg5n25SdxRdv2mumfP9kZDvYpL9703hohHJEOQlb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fINlrJMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N3U4LorG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497BxYKP023705
	for <stable@vger.kernel.org>; Mon, 7 Oct 2024 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=KvtEX
	LwGjhc/KOrqpuVIxJ9UfiJL7h07rnlkXpbBUCI=; b=fINlrJMX8Ad0spuMcBWGK
	Pu68lihxQKrHuBSROYb5BiyGDM9sFRGyztkvCCky5SmFB8syM8gxcp7xehRVHLvx
	XgU8jtVOHACDYSh+kA1uoPU4Pzrcqypvnl/cpHP+YPh7bjC85yIOxIyoLIcYUj/U
	OlQI9iFVgii0KkcR8542Kd2uWkO0PpW++ybX2fEFrP7583g+BaVke9bqqPwp6eA6
	x+4FBhXLtzcPOOCAOrE69BgPVkjFikPmQ6bT+Zy8QtrM76qSYtQkwinmSbAYYsoO
	n6gqPtC11OgbiY6zRPx0pUGQnHFH5XNWC8/D4YfqFwA+ibyu6bxiUNEyWwGy7w5w
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv3g5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 07 Oct 2024 14:06:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497E5Ib4024191
	for <stable@vger.kernel.org>; Mon, 7 Oct 2024 14:06:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwc3ebr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 07 Oct 2024 14:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGb633IeRDe/fyRPcxCawhjCZJGczqCJXCOfS0fMsH4VO6cR68Fsey64OZS0yLj7xcgMdMksvZk2WmuA6Yx2MNLR4IotbBvXrWEjZ2+W0LuD981IbUnSlkYgjMDZKKoRqTmwTeR3rTsoTF3+XCQF1QW8e98/WdmUNC06ViBkQAlkMumawVciM5wK1YLCwacPMaca9kuzq9nWJ4H5vyRhKKnfXJnmLJWDhYd8LYa070fqrETmkDHEmKv8BwsVUlCZO/EOQotVakwx2DEbAB+h1toxM1oAHh616w6VemdQ6FnHzXzcczcyBIpUpklnm9AFzYlKbsAYUiO0I+RNbeNeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvtEXLwGjhc/KOrqpuVIxJ9UfiJL7h07rnlkXpbBUCI=;
 b=G09FpGIK4/2AL8k3b68DYl5xFevDy2EGGhOpUZwdDFbkVkEMo52uj32oRx5svNBxNNw9oN2xcYZG0SyRpFt0cE0o/jkGiPJMnqPyI1/5BpjggZ290LdgeUpCXcg/mHKfbGrNr973XD5828pNE1SoU6wcR9qk6hvBcnc2BsgQ5iCXilooBX/YtkGSJOrTeAq1NHC9YdfUeuPG8HY0Djlw5dEB2x3u4yoEXPO2oc3Ww9A+CfB/p+jwOFyjlbTAQ9p9yzv2ZuONttMb+zqCJ38mvzReTxOV2f/f4qg0VYCbtnXoRu+Gwvi0UukI0HGc+xh5M2bJYe4ZBC2fB0lMZWSclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvtEXLwGjhc/KOrqpuVIxJ9UfiJL7h07rnlkXpbBUCI=;
 b=N3U4LorGDhMuT6O/z9SlfiL3DFGSTDBLu1gmzu3F+8FYtfyrQ0dNHhnONcbHOXkMmfJK7BFDhcIs1vgvbMCHNQVXjPhXJKIJDWRC2Twd1qa1zNuX0XNszkE7EU4ZN6ealhxceJGFoQGScf7xd5Wxd7KsX5EHlpscO11R09HQGG8=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 14:06:15 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:06:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: linux-stable <stable@vger.kernel.org>
Subject: queue-5.10 panic on shutdown
Thread-Topic: queue-5.10 panic on shutdown
Thread-Index: AQHbGMIS8A3TzuI+pEOVr2IEvH+mEw==
Date: Mon, 7 Oct 2024 14:06:15 +0000
Message-ID: <9D3ADFBD-00AE-479E-8BFD-E9F5E56D6A26@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|BY5PR10MB4164:EE_
x-ms-office365-filtering-correlation-id: 4bd5febc-0ef2-4f59-d46e-08dce6d93500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8rHuwK0dXIlTNxXRATlbe4RGOjxXCF5oKOuKrXLj2N2Xe/e8f9dSr6TlQXMv?=
 =?us-ascii?Q?QmsWqvZoE4gFOUYMKoeEuRjQuFVd/tyq4uFlWquREFHXIJtvfvtaR16x3uTz?=
 =?us-ascii?Q?4ooInQ70AvxbU+9tNfG3LSNPrpdQv/mqNyKoB30PnrkAz9BTKcj3g9IR9jvV?=
 =?us-ascii?Q?oC8n39HwoMv90OI+TfeWF73U6g9aD0NaAyi2C+FmUvJZOR1ABBGsbZl8mD4R?=
 =?us-ascii?Q?abuKVocyvoqd7nq901ZpqTAq0TYNRM0Hns1CP3QUHPYz220fFLEzrW+xKjoT?=
 =?us-ascii?Q?PlfZ1S3F4NXSxHmOsGVD9bhwl3lQFMj4hCqA50JjJSEscsilQIhod4nszVS+?=
 =?us-ascii?Q?XOmGWcEU3T3HVNApkK0s8zo3aETmNvdWyzjnFUQVtD0SAjeHWTaBwBlb6ITD?=
 =?us-ascii?Q?H8vnG3G6eTzkXQebbOjtayreU3JmSXgK6d6rdSDxm/6y6Y8jWKin0hmJcDKJ?=
 =?us-ascii?Q?hc6rHqF7Vj37Fsy4O5cH5X6hHcubIjbD+f+Tiz0Ak4F4VuDO8aKyHHjrLFcQ?=
 =?us-ascii?Q?Bd+guTAJCIMiEo5g2redO+QdKA2qFO/yHeYzROE8CJ8GIeQO7/993Ww/qyAh?=
 =?us-ascii?Q?l91WU/bex1Lf1/XlSkOhLF7kHyebaEcOI2eOHDjbfpCCBsy7XPxngDiiUQyd?=
 =?us-ascii?Q?Bp+tN7fHW9ibf2qfSsNwMTr2/GrkEmOqCQO7JVfiCYCpSDLyNfuBZ6eb6Fwu?=
 =?us-ascii?Q?KP3mmTlzwTQjcXMw+VpBMvHuycf4zGdSOi4yktUZ8kF55CtTYzElMgKtuHe+?=
 =?us-ascii?Q?yO+t2+xw/Jkm/1HIvha984Kda+BKsin/oX/swFL+bU4ka+A5EvkTMllutoZH?=
 =?us-ascii?Q?BmLHi1BRKDOmAJpvYGbJlyp72rvJhVPsMhLmQCmoI0fRrO0gU87NZelig691?=
 =?us-ascii?Q?z+6FuLprBEzeWR3h099sGSq+YR5Y9JFziGoPXYiLJS3UG6JvRJHWZ3DNVBQ9?=
 =?us-ascii?Q?/Wdcfv5fAMj/EwPYU6uuodslHVh2084Ny9PqSsO6a48sczVdrIsoqvnMgPkm?=
 =?us-ascii?Q?sZqu/NCknPGXrf0Gd+MeZ7J+JedzI7lcEfnZCb2sHoHQ6VnmbIdML1P2fig+?=
 =?us-ascii?Q?0r0l+ijP9fVJq3nwO0BIxn/9zJfim/ETxAI006J4CmZx9qBzec0EOeEYYYOO?=
 =?us-ascii?Q?eDGMtpUzuHtKVO8ImH0Q4DKJbjbgUYAgQStBFYdIiwPEiSlyhqVddQgYwqNY?=
 =?us-ascii?Q?WrR0UsFVRMQuM0MTFOZDCACf5lncCugtarqXc81K+nkEJNUL7VQVtNAm2voT?=
 =?us-ascii?Q?cqom93yK2+ZiV+2Wxp94Zyascmb8RNVzfE8DKy8cKzI5d+eTF2lcx1DK+FX9?=
 =?us-ascii?Q?XKungyKaOuNdMeYU7LAUHkeMlvHyjNGSDQoF6MKRCE5Z1w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y05Ae9gqENFJ+EvuYa8sSBlr09UdwrUnMmrCAVRvipMUrqFZtyOxJXtkksUk?=
 =?us-ascii?Q?vHgWnWlHTXwT1CCwCtWuC/8DAQtl+4FdsNW5YpcJkWVYx2ACNUjVkLdLoJyU?=
 =?us-ascii?Q?yF3I23c3hg7h36/N0GFOufHzwEC/09g4HbJosVis896f7gKrDwowJISfOnZH?=
 =?us-ascii?Q?GJMQyJJFEuULmAM525yo6hu55xd8Bafm/8IfmnSaRKoAK6BaGuJ5OiyOny/2?=
 =?us-ascii?Q?7f1RxjwcGOhRKkf+cVs83ge0V+/yn9fR8Zq6hQAVODSs3tf6mDEY+mURqahE?=
 =?us-ascii?Q?Msvr7m+foJ7TUy4Re0iKIXCRKsW+kYDJzAmCLTukHTZJPGQAtA6LcPH0Y7h3?=
 =?us-ascii?Q?LBj4wrQvLMUn08WLFluAQP5juUTk4PjFJD7CEjO1CSjHya3nLp9e0r/kp6Ir?=
 =?us-ascii?Q?t3RF25s3NVnjTB+ZhRJwf2x6NMlWp0fggFmuZ2cSFmbVt4jsyTLSI3/SY3EW?=
 =?us-ascii?Q?YL4VZa7PhGVZrLEHCCpXxwFEX3gTE+3c7GML4gOvCejaAZxeNMnBI2Cu8GDU?=
 =?us-ascii?Q?wqKLQC9+6MgF6QK5mVl3tAykDI22bFruOyaKYTmNaRPpq9KYj6DzXDaw26t3?=
 =?us-ascii?Q?txixkUx1477We4+ALANnSFduSSj3bzlacPKcnBdoYtsuuAGNlv1yk/zoJ2eT?=
 =?us-ascii?Q?Zg6It2f0SPrreKcCBZFb0aZa47GNJppAA3KV7tI7c8L9YSV/vBlQk2HuJvoH?=
 =?us-ascii?Q?trj8fCu9wGkatIlHp20Hn55gfep8ahft6T/pOi7t/OY5eGvcdWYra9JoSA8F?=
 =?us-ascii?Q?oc6AKvR/g0fBHDWExKDtfuFwpQo3kXx4mSULMHq1UMRrhsxt5RYV5eO3+ywq?=
 =?us-ascii?Q?mZtDQufZXM5fOLe5ibEyHll+VYQ/3jm8rIqyVO8RN+LOsMEM8LJzi5rsqyLt?=
 =?us-ascii?Q?z9Nm4rgffKVkahecrbjSGUgFw00ZHTVPy7c60P5s8bqii06YFmssl0m4z+9N?=
 =?us-ascii?Q?ZuixXo53AN0FDRgY0IN/yajYZHJn4wxahVywc4mJLlrHuYgWttAa5h5F2F23?=
 =?us-ascii?Q?q9aDXhI7c2culIfcjjmKdSYTyPAHwdt3kX6WV5i8TQkAM0FDwo3f8gaYIBuD?=
 =?us-ascii?Q?luXxynnn5tJ1AhOEX88ek02d8VunTUAkFW4oQJXh8G6fD69z3kgMdCKfuwyE?=
 =?us-ascii?Q?LYju9SUnUcELvhzZFBlBzwIY/FCgVA4Bd7qZYhYdGxcsZgpxLRp6DtBuqzS8?=
 =?us-ascii?Q?MlLFzEwnOsfMBw2kdEaBGlwcsKOcKiQGcG1VUYJo1VYYvwcftmDn37XhJ2eH?=
 =?us-ascii?Q?wVdzBSsKgQ1aU+wyNUaneElnFfK/NdbMzfA0xd+ei7JDK4j75/D0nAQGCdFQ?=
 =?us-ascii?Q?jgD8WbKeZMIx+4GUzXYVFhw6H9bRshWv0IlyGh5wUsTQ8Tx9znZazLmNxs/N?=
 =?us-ascii?Q?m0UvhQDLX6ogXjNWF1YqQYkhFMHs+cdEDiOf9sHu4ITzx7fQeQJgA9Q8F99k?=
 =?us-ascii?Q?EmTQ/Sl4QM71ONiQxtxLj2kZNwn5W+h6lG7ADXDuHoXd739EMqphePHQa6Oc?=
 =?us-ascii?Q?JWlF3f+xCfmdtzNF/cBC5LXnnV2i+0QHoeEWFl7HeANIdRlf0apouxzQOs7l?=
 =?us-ascii?Q?/TvR0G329ziBo6kjuP2F532KC/AsP2Y5hfbLk+hnfTR/r5fIZPce+OUM3Iaf?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFF8CA0E4F6B7542AE229360D47C0D18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t8G5OOtzISjoj+JdHD3zhE6wpfopJGfyMuagMKaSzkcaZBtSlb7uW+wnkW4zxfirecUUM01zB7y1w8K94wcevEulm3DFBq00uNBRvQsj7POJZ1XIihJ743xruXMoEvbzK8t7+jx4fmkkoIND0FX7aTYYc01Mzjq6WSvidSdpL2P9rD6gpz42kbBJqvzcCbxcY0gINpy0guUhJtzNHoYggpf9MqgL5lRlEyGfoYB/XIo0NsAg0OCLo08EwaAl0HncpZjNQeaTgz49+A8WKdcUXBRgtvUaYYitbO+lPnEzM4xQOKw/GLhDPhWPOfgkTm8dqpjiGkNJZRdGilTUWY0Bz9xp2gdIyv2tsoMLoI7KsFuJzQ1DuAOmpeNtwUJnRqjtMhjSKjaViugaAJqgNjjauA6xcfWusIH1XvDM4/xlkzd4d8CZLCIheT6I7g3jF7401gEJ4jMv9qdKyuMwVXTMv542s/OqP8ua7ZW50fHU1jjMRN67WanRPUn2fHZ2n10wMj86PyvVtNLq8tOnmpuBSxJIzhnyahtZhKDdi9FQ6/FpoQdUi8OxQPkBKmP1kRJgNh8cFUVtpHPFQTYvAVDu29V4p7UBrtoVcJ8tOajOELg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd5febc-0ef2-4f59-d46e-08dce6d93500
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 14:06:15.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTlJnq4dESxxo7Hk6HJMwz0UXwevNRkmsRkNyw2lhhGu7DU0xY62ZUISxak5aY36oWeoU2OPDIb8LYclYCIH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_05,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070099
X-Proofpoint-GUID: 1djVYKwtrsepMYaXlk5lQwAMu-8V8lT9
X-Proofpoint-ORIG-GUID: 1djVYKwtrsepMYaXlk5lQwAMu-8V8lT9

Hi-

I've seen the following panic on shutdown for about
a week. I've been fighting a stomach bug, so I
haven't been able to drill into it until now. I'm
bisecting, but thought I should report the issue
now.


[52704.952919] BUG: unable to handle page fault for address: ffffffffffffff=
e8
[52704.954545] #PF: supervisor read access in kernel mode
[52704.955755] #PF: error_code(0x0000) - not-present page
[52704.956952] PGD 1c4415067 P4D 1c4415067 PUD 1c4417067 PMD 0  [52704.9582=
91] Oops: 0000 [#1] SMP PTI
[52704.959136] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 5.10.226-g9e=
e79287d0d8 #1
[52704.960950] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-2.fc40 04/01/2014
[52704.962902] RIP: 0010:platform_shutdown+0x9/0x50
[52704.964010] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 =
cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48=
> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
[52704.968215] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
[52704.969426] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 00000000000=
00000
[52704.971095] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478=
b6010
[52704.972758] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 00000000000=
00000
[52704.974433] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6b=
a0440
[52704.976083] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 00000000000=
00000
[52704.977765] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:=
0000000000000000
[52704.979653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52704.981008] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 00000000001=
70ee0
[52704.982697] Call Trace:
[52704.983309]  ? show_regs.cold+0x22/0x2f
[52704.984223]  ? __die_body+0x28/0xb0
[52704.985076]  ? __die+0x39/0x4c
[52704.985827]  ? no_context.constprop.0+0x190/0x480
[52704.986940]  ? __bad_area_nosemaphore+0x51/0x290
[52704.988050]  ? bad_area_nosemaphore+0x1e/0x30
[52704.989082]  ? do_kern_addr_fault+0x9a/0xf0
[52704.990098]  ? exc_page_fault+0x1d3/0x350
[52704.991047]  ? asm_exc_page_fault+0x1e/0x30
[52704.992041]  ? platform_shutdown+0x9/0x50
[52704.992997]  ? platform_dev_attrs_visible+0x50/0x50
[52704.994152]  ? device_shutdown+0x260/0x3d0
[52704.995132]  kernel_restart_prepare+0x4e/0x60
[52704.996180]  kernel_restart+0x1b/0x50
[52704.997070]  __do_sys_reboot+0x24d/0x330
[52704.998026]  ? finish_task_switch+0xf6/0x620
[52704.999049]  ? __schedule+0x486/0xf50
[52704.999926]  ? exit_to_user_mode_prepare+0xc3/0x390
[52705.000840]  __x64_sys_reboot+0x26/0x40
[52705.001542]  do_syscall_64+0x50/0x90
[52705.002218]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[52705.003356] RIP: 0033:0x7f0f1369def7
[52705.004216] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 af 0c 00 f7 d8 64 89 02 b8
[52705.008496] RSP: 002b:00007fffcbc9eb48 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a9
[52705.010235] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f136=
9def7
[52705.011915] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[52705.013593] RBP: 00007fffcbc9eda0 R08: 0000000000000000 R09: 00007fffcbc=
9df40
[52705.015272] R10: 00007fffcbc9e100 R11: 0000000000000206 R12: 00007fffcbc=
9ebd8
[52705.016928] R13: 0000000000000000 R14: 0000000000000000 R15: 000055a7848=
b1968
[52705.018585] Modules linked in: sunrpc nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 rfkill nf_tables nfnetlink iTCO_wdt intel_rapl_msr intel=
_rapl_common intel_pmc_bxt kvm_intel iTCO_vendor_support kvm virtio_net irq=
bypass rapl joydev net_failover i2c_i801 lpc_ich failover i2c_smbus virtio_=
balloon fuse zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw =
ghash_clmulni_intel virtio_blk virtio_console qemu_fw_cfg [last unloaded: n=
ft_fib]
[52705.029015] CR2: ffffffffffffffe8
[52705.029832] ---[ end trace 40dfe466fd371faa ]---
[52705.030908] RIP: 0010:platform_shutdown+0x9/0x50
[52705.031972] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 =
cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48=
> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
[52705.036245] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
[52705.037474] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 00000000000=
00000
[52705.039143] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478=
b6010
[52705.040827] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 00000000000=
00000
[52705.042463] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6b=
a0440
[52705.044135] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 00000000000=
00000
[52705.045784] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:=
0000000000000000
[52705.047637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52705.048992] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 00000000001=
70ee0
[52705.050655] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[52705.053432] Kernel Offset: 0x23000000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[52705.055871] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

--
Chuck Lever



