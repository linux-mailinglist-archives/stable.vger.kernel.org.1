Return-Path: <stable+bounces-109609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A9A17CF8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8365A16042E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318741F12E9;
	Tue, 21 Jan 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="FyO+k0nT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4591F0E44
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458559; cv=fail; b=ULEDgkJ1omO2E3Z34joOvYHDlbO07QDIyKA2Ut2c6W9eBFVWlBodIP10BwVytPxPbRl30PDqvPxyE1aVHUfEE5gtCt3q3GOJLYRy0+IQTR4pjo4aWv+MUCa+5eGGVaoB2OegUkscx0eNB2M3SQ5qGLLq9dEyARBN02C2Q25bSLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458559; c=relaxed/simple;
	bh=at2VAlHs13hEe39UdJ0Tr6cKesRZg09GKftP9uM1+6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NWjx0n3H8W7NX5INgybiOeSwJowuYtMa5ogUZuw8H7uoLi+Z7AT0FffKy+0tHRLKOajym96apwzDrg/R42YgT128leygLtO8aVt+9gYVas51ZRaYXGdUPDQbXC16pkuBJkqBMtuxvTDBnh26PW6FL7o0AquExuP9Rt1qiyv9x3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=FyO+k0nT; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L5NxqP031494;
	Tue, 21 Jan 2025 10:56:15 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012051.outbound.protection.outlook.com [40.93.78.51])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 44a5d8raph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 10:56:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie8/U1dIiP+l2xXafRi2MnCUelrC4y4Y1xBnOu1d928G8OjMSYsGyE+bEt2BgJmukxs/ij8iAskJ7otlWPA2i4gBbJk7J1w5LX185zZd1GeHE1P6dlVs6m/EZP4MPx0+hMX80MrWpQyBXiqsuAtF9JCMdCo+qPw+gDeu3eK+ZNdYE2TEk7I566UmUdGp2SvMXWJhBmss9qq56qelsxYy0NTUkQ8w0K0aZOYf7OPnisEUz5o8IxnNCc+gQKOzyvGjLN18CQjlk3ZigSoICGdAYHBbPVemoZxvPX962J8DSDqf6BmproRXSJoanBXhQZ7c0E23LChf6C3hb0nDDV/TwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+D/UGDSv2Hlql5/k5oUa/9loxzSQ1Rx0OZGxAh/lg8=;
 b=SXuOlm8o3EHoBiNd5JPqocOXdpHJtfxBHq9pJq29QIw3VfH0Xq6FcEO/DrsNVcpU2lbA3FX1NgsWeQKSYq3JUbdiAaT+1AnkbD3OY0+BJto/Ca++x4QRHGWAs09Z2Km/lOnBSbMtdKv2EAt+RGvFExkjA+btvnLDx6dgGef984vbo58Ff84XEb3TcvBVENV03c86oTP51TwpzzeyTYZssyTlou657egUFQLzmhCE0VgCPbqQE59f7Ewy1MRxKUk8ek73wawwFxfR3HSNdWBLUURp+KJq7RembB1rZC3sOS7/tPyson/aVsOIDeLcxRnl2HmLH+7SpNVxft2ZWGij5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+D/UGDSv2Hlql5/k5oUa/9loxzSQ1Rx0OZGxAh/lg8=;
 b=FyO+k0nT7P30w+9mxohU/uj7E8TvnDekyx5fFfqE8Bnnn4ut/y8cdp2XYn5e5BNU+WdDTvKdcwFalVbmFOqTVbm55Egx+UFJewt+y7cEBsNn/8DZkwAY6xCH7fEIB48wrfQk1tFNMRu0xaFYqm3KLZ/UxsCbWn2ezIjTcdf+czrHuj0gQbj6gZMoDsv7M2o//LMzYWliHSB4fSPqt1yuBW7Jh7IyEoAP8L9dFNi7NICd+9G2f38WQqP/2W7Byc6XIekrhaIBSTPbLwP6LClf9QRHCJNuetnz600gU/IsysYmHwpVfAGcJDqXmYDK0cROvI1zNyMFhM8uJuy55pNY6Q==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4561.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 10:56:03 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 10:56:02 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Topic: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Index: AQHbZb3K+MnNLBz8SkyyPkNfFKLFBrMf0AOAgAFJ9Jo=
Date: Tue, 21 Jan 2025 10:56:02 +0000
Message-ID:
 <FR3P281MB175752F44CF9936F7642F9DACEE62@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <2025011348-amaretto-wasabi-3e96@gregkh>
 <20250113131918.128606-1-inv.git-commit@tdk.com>
 <2025012012-drearily-bonding-0904@gregkh>
In-Reply-To: <2025012012-drearily-bonding-0904@gregkh>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4561:EE_
x-ms-office365-filtering-correlation-id: b0e2a095-f4f9-4001-d1dc-08dd3a0a3251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iJSJf4O340PhABU9Tc3+YYaNa3y5DmDz2dk/efTNBw6OFBuUhFAHJCyD7M?=
 =?iso-8859-1?Q?X2Asj8yTmPpMdKkwk8TAe4cbwnZvVOZ8T0Rwhq/0jf1PBL+mGcO7931KZT?=
 =?iso-8859-1?Q?JvdlkNc91GCrIft5FshYmXjix9oh0KWEQ8qkCep3uChNYRxzqvoqYrORkF?=
 =?iso-8859-1?Q?o84DwVFmvP5YUnrBjdc4dd9CvA7qwviRWE2qzxN9Vd8423cb4rTuhwN5Uj?=
 =?iso-8859-1?Q?sbnDzTaiq9GPLKuRSUyfNfl/StiP+oMMnNYai5UjuwwhmqxaSFcXN6iT8k?=
 =?iso-8859-1?Q?iqDhoNfOy/niHOp4P4uy4lOq/MghV8hMkl67wrfLNIykkttJuHOq9E48Er?=
 =?iso-8859-1?Q?VWNdQ46yzaWF5x3mZ412bFcqVHTfUx3+D8NnmYx0kxrNIqlQSjXaqQ3bZr?=
 =?iso-8859-1?Q?6jrweGHYNCb6XWzPpdmnQO/J3JbmyPcWBebpdi4OUwdOkxDGRImfQy4q6p?=
 =?iso-8859-1?Q?dMsJaMWIyo2xDdpafmjkl2VuE6JK7M9OU9vTl8alcjIYWBuYiT+d/iEPof?=
 =?iso-8859-1?Q?05TbGDOxNhtzCfRatChV5ukBhsw12TjwModwaQpxkjhpkZ6tje82BXT1nV?=
 =?iso-8859-1?Q?4rhGndOz1KB1eUIjE0627gKD2WkGtGyDH5Kuckaq5v7NZ+g8e/p12GGwdM?=
 =?iso-8859-1?Q?N7kNC4hRuVRraPdvd9h8a1pAZMcHbsaFRDuLkT7whJMW1KXSP7SDl7RvII?=
 =?iso-8859-1?Q?RC3rlAYo2M4QBhMw1RQfs7mo0Mtr3qDvSGfzen00hpsZRQrAHBkC10GTTO?=
 =?iso-8859-1?Q?mgVl3Xepj88INFqIsVDxlrAHA61hLUdJRETnS4CMTnYIvbzfZX6fD+V9pY?=
 =?iso-8859-1?Q?/wIjkC/sCnpr0wlkO3Cp3uoSyz2uAVbDcXW5gbEqPiwb7o5T6dtheXNg7l?=
 =?iso-8859-1?Q?LAHhaZzV9OfLIyiv9bg5GU9TtuXg8GlLKPPuX2rDBvpVx9YbY5dLJEdCsY?=
 =?iso-8859-1?Q?5AX+Mob/lsP5SxCXJp4EYpfLE2Au/6IVr1ZYkIrgSUtnnGwR3QxB+Ar3Eq?=
 =?iso-8859-1?Q?PxcDYuWk8Mqrwp95P+WMjEX68Rx5oAbGUF77ML+dFm5mcm8NhrOJw9hUZr?=
 =?iso-8859-1?Q?b05NR+vl+8Fo5eWp5lswoOpUiWc4oT8NlUCYBo57rdJCpQzOVg/4SmrUPk?=
 =?iso-8859-1?Q?kTs55j5+6XNaFdhAnfBcnX00QI5j2sGyAevhazp0VcDbyPsmSyYhILMxmx?=
 =?iso-8859-1?Q?YUUpuJdao1gBGXjuUu7xMZV/QUEFHLZbmKosU6fDlsMraaNu/NA7ApRL8d?=
 =?iso-8859-1?Q?TELn+eOBNSwzz9p3Pm8pWah+O4mA2QtJBvn59OVnQaCGsE6+wAvUCAQ1zt?=
 =?iso-8859-1?Q?I/5mme2iKY+JOejwbA5M8NcvPmWDKmnFIK9ccG6YMIASJGTWRXY8J6kjPB?=
 =?iso-8859-1?Q?9tX7PdCc2KWZw0dnyYfffXzce2+HlBWbQi6DRPyGpVE18qDaUnlyaa61I+?=
 =?iso-8859-1?Q?MfiPuOPOm72Ftc6sMZ2sTrthov3oPcuydNybB4GRE+uobsHaIglxL/DsdY?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vQSMLngczkWkbKAcLrUeWNivNwu1j2UQ0B9hx4AiwW1LzEeRcqtard5Ka3?=
 =?iso-8859-1?Q?qrHTbLs4lZEbUNhjGnQ6mj4Ie+r3dnK9yjQOxPw6fV5TMawFjSsJjhRZTp?=
 =?iso-8859-1?Q?I7IJAR62a5glHy+4zv1TAvzIEn15zPkS1DwckRhZfRdNwZNLx8H1gIjn/C?=
 =?iso-8859-1?Q?//U1+zlzJHUJjifp3xYQUHDEVxygfxWqswVnA1ivvAVciFN+ZcaILPLrEv?=
 =?iso-8859-1?Q?fDx/otzrwYSh5ep1O8bkdHSyElZuUB2IzRI0ws0m/00o2Dme5V/gX3xTo6?=
 =?iso-8859-1?Q?b2u1zGSVNC01dllCrRkMY0q7Ov8aBhJa5R4NqxL6HKYixM7e67tyJAU+g1?=
 =?iso-8859-1?Q?R7dwKgqmnK1klakncXm/bI9VN3kSLF5S7fIcxi94etm6CHkmjPODgBQ1up?=
 =?iso-8859-1?Q?UlYrlt5W43PapoSFuf5XkA9JTszmhy4ydg/hYjHI+O9YZ4RLNunsCbALhT?=
 =?iso-8859-1?Q?HwtmLyQx6nzBpQOW9l4wLsJj5MebjEA1rWVLohKrx9JB+X6mIFEeYIwqpt?=
 =?iso-8859-1?Q?VrlnG40/DtHjt1on54buCzGAPCW/k3plSLEnQW0grm/H67McvwyOZHzPSw?=
 =?iso-8859-1?Q?IF5dl1KadgH/Hk52AOPbjONtEaL2RGOYacdxEGl1FALXV15L99lTRNcRjw?=
 =?iso-8859-1?Q?hkpfBLKa6uqJ+DSJq+4ikJqlFrZTFMROrqrnhFCpcVaO4aSuUK79lgErob?=
 =?iso-8859-1?Q?w+epIldfRE+uYayRxqZDnJVCEMC2aPtP/0ETGm/FoEahbrM+KHpfgM0Ryn?=
 =?iso-8859-1?Q?RLToelkzczkn+PZVCW4j/RgDOvuDqJghstTdi7647XG0XiDXQnTIXzFp7q?=
 =?iso-8859-1?Q?R1joxt6towT1y/TjPVqlNG2zuNelCu59Upj7v4fi/xXljM4dh7vUWJaKt4?=
 =?iso-8859-1?Q?yJtWUTCbqb4yZnFzHDzJUGoqLZSaSRoKVfxHHkuhgU36+TL+5oVHdq89b/?=
 =?iso-8859-1?Q?W/TvPxJtEvYLgzDYdohKf2ydi2Eni5ClB0l/t3q3B5lHa6rsuDCAL9aoMu?=
 =?iso-8859-1?Q?MqSxIMIUZWE/YBpzqa8Lxg1E6NmnkvWYoEd7snfq+4tr03mniAu9U23Wno?=
 =?iso-8859-1?Q?7LfXXnhS1eC+XYQ6JIsDIN/7D2EKNUfRMUOvmh4qoWHBhYfS3BugMtnLdM?=
 =?iso-8859-1?Q?AoxXGuwgbtP3rTeCLw88v+H2O0ru9MthQHYN+xNSpvN4uhXivI8Za/Kd0a?=
 =?iso-8859-1?Q?Q8yiu5zUMOLpi1xP2WLozK0m7GBO2//jZFW6f4BWUWfO5v5W66sC3Qjz7a?=
 =?iso-8859-1?Q?j36ng3yqfl5VFYPqOTL2/M50Q6/wOjrDH2sHsOpd67860mP7mVtrJk6HfS?=
 =?iso-8859-1?Q?Zaw4fACyaPOTRWSfIl8NAkz7uuxkfQd303OhWQHIPjPUISNwe3cam1lEcj?=
 =?iso-8859-1?Q?tBBo5bLhnXKiUIdldEcpO/XzHiyKGceMacNrs5DK4bzkyWMtLlAeOjnPFd?=
 =?iso-8859-1?Q?qZXayG6rrOoeSF2go5cByjkLQb/Jh6QJbbnZdAiXM8XtD36bTMPct+YiEe?=
 =?iso-8859-1?Q?SYQfVEOFhLM0hTQb/dJJh7UjTjjq2iwt6EahjRsBG3VXgbUeqmcpUX6/a4?=
 =?iso-8859-1?Q?+WGOwz4cAjqmIyncJWeeEM+9qLFYMfekw0hHtF7PMURHUc7QGnIL08ckQx?=
 =?iso-8859-1?Q?qN6Zb3WgRrpeKIexnIelHRSIzqgf/wmTtltRUf4+TMDzfU7w2nmlynEQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e2a095-f4f9-4001-d1dc-08dd3a0a3251
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 10:56:02.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nECO5xzXYgmu9IN3eC/O2v0Anc9gE0lXFp8v0/VHAZsLK20OfBw0EjpukMXv20CzJ3SoL6Zu7MRCSToB2a/yDVNzS6TVCJnF9HFIfFqAcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4561
X-Proofpoint-ORIG-GUID: -sdVLcUzOAwLHhOPattXjMxlt6DlredU
X-Proofpoint-GUID: -sdVLcUzOAwLHhOPattXjMxlt6DlredU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210090

Hello Greg,=0A=
=0A=
this is an error of course, thanks a lot for having fixed it.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Monday, January 20, 2025 16:12=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0stable@vger.kernel.org <stable@vger.kernel.org>; Jean-Baptiste Maneyr=
ol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cameron <Jonathan.Cameron@hua=
wei.com>=0A=
Subject:=A0Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write n=
ot supported=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Mon, Jan 13, 2025 at 01:19:18PM +0000, inv.git-commit@tdk.com wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Burst write with SPI is not working for all icm42600 chips. It was=0A=
> only used for setting user offsets with regmap_bulk_write.=0A=
> =0A=
> Add specific SPI regmap config for using only single write with SPI.=0A=
> =0A=
> Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm4=
2600 driver")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> Link: https://urldefense.com/v3/__https://patch.msgid.link/20241112-inv-i=
cm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com__;!!Ftr=
htPsWDhZ6tw!EaI5egbCz3SoE8NajVgwSO-Z_j3I5coqQ8HT8LjoBpJ2S6DhseAvoLjEq6sxy4F=
ZuqblNw4YjzadiJ2llxZ8rhToxM_A08K9$[patch[.]msgid[.]link]=0A=
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
> (cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 12 ++++++++++++=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-=0A=
>  3 files changed, 15 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
> index 995a9dc06521..f5df2e13b063 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> @@ -360,6 +360,7 @@ struct inv_icm42600_state {=0A=
>  typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);=0A=
>  =0A=
>  extern const struct regmap_config inv_icm42600_regmap_config;=0A=
> +extern const struct regmap_config inv_icm42600_spi_regmap_config;=0A=
>  extern const struct dev_pm_ops inv_icm42600_pm_ops;=0A=
>  =0A=
>  const struct iio_mount_matrix *=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index ca85fccc9839..a562d7476955 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -43,6 +43,18 @@ const struct regmap_config inv_icm42600_regmap_config =
=3D {=0A=
>  };=0A=
>  EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);=0A=
>  =0A=
> +/* define specific regmap for SPI not supporting burst write */=0A=
> +const struct regmap_config inv_icm42600_spi_regmap_config =3D {=0A=
> +	.name =3D "inv_icm42600",=0A=
=0A=
Why does just this one have the .name field set?=0A=
=0A=
I've taken the backports you did for the other branches here, if you=0A=
really need .name set please let me know.=0A=
=0A=
thanks,=0A=
=0A=
greg k-h=0A=

