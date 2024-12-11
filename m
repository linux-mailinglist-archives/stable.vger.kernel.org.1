Return-Path: <stable+bounces-100574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49579EC77B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61271188B812
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB71D4610;
	Wed, 11 Dec 2024 08:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6421C5CD7
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906424; cv=fail; b=iISC1yMK6xRgKH6EwdAJfPBKNjYfKl5BJqa8PhcG2uYYEDZmWKPMWo1+x9Zfz+7tgcvjZn+QpPxep5ts5ub1oaxovAAGau08JemDcFQZi5x6h4dgy7o5MgyA3dGT/C9kSQvCxuVBYc5jsbbownl7TAtuHdGoDkfwguQ8RTxboFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906424; c=relaxed/simple;
	bh=+ZT/Lt9uV/Klte7KoFQRwdrvi7QScE00RpvA5PlZjPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t52AlHbILXdCW9w74rkMyfuj38UqTVQW7D2DFhL46ZOiNoIv3zpaWMoHfc7T5YG2lTCGzL5Hrox9qMbBXP0Yf0x4z0WBn+Mg2UEfhpxDLggV0n3ZcZ7FHKP+tmwEP4QFk/hIoTWbwvbXeCgc88CckEisOmCzJEFrzgQG/3AgK/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB6LYwT017285;
	Wed, 11 Dec 2024 08:40:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3kxwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:40:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfAiN8QsBTuaDLhfIeuCD8h+sKXiWPYSqZNK+QvVY75g4HNe0fVkLAFnnvpslUx9Qrkst+le45TOsh5KqRCQiZfu13OF0DNlJF2d+pCkqSUrcYPtbN5dvizO7EX+KR6SlPvygBO5W/iAEhZgQYesgTmk7SNFQNHVGpNUA4d4DBd8S6cLhMx1z2d8GqHHPi3Kgfc/gdr78WBVW+2j9bW3clItUibgf3pRg3mZOUahxqJQo/wgzczdO/NVoQcSfC3jmjtijjbU8btrXM+JN5De77aURhGuygxSt4u37Sq5X97uBCaVObLD9dJb0kG+T2OTTmMlLX0jHhZFD0AoiTguUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VSml0vamU1omDFVajXyvhW+umLoJks69nSGreLhIVs=;
 b=fybhbrkWI6fsNQYvbi6gTwSil/8XRTkGLNE0koIWl458rJwIzuOCxm0Gm6ngSOScjcMm3RrheVx5aCU8N+yFfW1R5VOUfgEmvszxy0rUv9aaSLcc0c9zCZyECuvcWEj9+BjUkIuHnUHa81kuV24cn6Ny2Vr2GRCTpwAWRyvCweFKy3QVu4ImSFx9qBfR0XwUDWXYea0p5Qe8uaqIHrqc1qHQhrS9kOQTBgOM4ofIZ5ziPvdd4/KUr/XbXpeB+R26Nhm0Za6cR2OxWPgA0Ae849yASO1qpgn0y37COhLSJpuNz3pwrEwmYWKuOJZU0bEnLif/sZPWOIs5qLc+5k+ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:40:12 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 08:40:12 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, juntong.deng@outlook.com
Cc: agruenba@redhat.com, majortomtosourcecontrol@gmail.com,
        stable@vger.kernel.org
Subject: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 16:39:54 +0800
Message-Id: <20241211083954.3406361-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|CYYPR11MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e6da6d-8b49-44f6-abef-08dd19bf6d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsuLOUg5x9heicOUieVF04QwENrv4atgpLr+jKvxqlNsf7yvZyqRd4W4IWEe?=
 =?us-ascii?Q?W0plG7gitD8juh6skxOcOFEEIG78tQr9cDjL11DqIZJ4qNPgtOUL5oAcfq4c?=
 =?us-ascii?Q?LhXIM5l3LiTLev0SE+gMU9VBd8RFLc2Dxz8E9yp4qf9BvGx7DF8lezlsT3d2?=
 =?us-ascii?Q?78DFRqI2s859WkneNhcBba9Zh4hPr2hLcvD7oDcKAOVQN3iQiNl/PwyreTdu?=
 =?us-ascii?Q?KyS+P+q1o83kInxeJ03OfPd4chxyPJ/niOUqweb9BnKM0VaWzT0H5OXtCunS?=
 =?us-ascii?Q?v3Zjo4rDQDd67X+tQPUHO67m0AibYGnYxlVJYPf1exz7Rk1blw3qqD1z3lOc?=
 =?us-ascii?Q?zXZyPcjNamPGSvHiXm1r3MZjl5HUOm5ekK7H6kJ99oK5cIOr7eUod+50NFZF?=
 =?us-ascii?Q?XcckcvPPWRKXFhxkDeLpwcnC3CjrUbqGjlgo42fzNCK1og9YeZUFlHHeBW4i?=
 =?us-ascii?Q?qbGdRgVwzSaCv3DjcGgHT/x0vdLx+mSznaUzShgPps2BK7hG/Rd0UyAHn3ON?=
 =?us-ascii?Q?75FbwoFIZN49epVGBOTqVOl2fhPj9HSwz8K+7q4PrwmvBOQuN5wWa5d5lO0A?=
 =?us-ascii?Q?3YR+PrsaLAli9GaujiQvaUXPwt8ilbH1Hx9dxqkEhtB1bEkJsynURDjqiENQ?=
 =?us-ascii?Q?T10lgoWeVAFCUeo0I7R45D9yDL9K7tHggeIEFPpO+T5tJUU9X3YFvwjl81va?=
 =?us-ascii?Q?q56wz95sogZDRaCbA4UyKu8Bl1qHJJja9fJf1PLusG9JpbQi2taDDGbUkD2f?=
 =?us-ascii?Q?W2P9GL7AODCtp4dSmjSOkzBhDHfHyDGX5DtxdEAMYQFBqfsxiKuXiVOBjGWV?=
 =?us-ascii?Q?F1IAngUdBlfur4yXD5Hn8ZccFxI7SfY4kU8Yc1/bLR9zygH0RZPeYfKfJbrr?=
 =?us-ascii?Q?R/LtcgX8gYW+Cn6EbrgwSMWqBfsbBNGWk5uyMdDEiAT2GaOvlNNAHjF+65ck?=
 =?us-ascii?Q?1ugqdNreW/+tKTN1nwOSdmS3JiwAKf66WkFAxgNtzOy4PkWRocJWX3Xc/qZh?=
 =?us-ascii?Q?2LAgD1eUxrB/UhzM3tXlp/Z+4mwUmw0nlMaiWW+w4M26GMweTqw0aPXczBi2?=
 =?us-ascii?Q?huqhR3waXp9nQfUpvKFWk5w4+ES69Q1veMg/FOZ8ADDnGwq02NYC9OEQYys0?=
 =?us-ascii?Q?WOhK1dL2L45xUVgnBzLZRxYYxGdHU74Ee4x6f/z3RDlMTyaxrWIR6DTMvIqH?=
 =?us-ascii?Q?tZuuXppx0Lq3JTY8WNnZgTjS89RBw3YLCw38WhG95iNCgRxCYTR1Jn4jaAyC?=
 =?us-ascii?Q?BCYmSoy1FlMeXdz62Ijmrz45pcLw3DGbBUW+bmr/nPXau4QyHQZPXMbgSkD0?=
 =?us-ascii?Q?QjhsVFOX5lXM0y+ztSmO5lI89YhfmLyjR31E+Wp5m1RevtpXzYZPebTRE7p+?=
 =?us-ascii?Q?XnpI7nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h46ITr0P8wGB+8dYXi3c2EecOicr9Z3lPwbNi53RqYJRBvofYVa39M1l1wQz?=
 =?us-ascii?Q?L+1zPkvHbBRSS0m6kytkh58Dy7oWl9arViBKKJdHbNSWg8YDcUtbzCM/IFEU?=
 =?us-ascii?Q?I2poronQFrOdpAhRY6gzhYGMokUZRk+OCJM5Hg6e3Y6Ego618BFT3Sb8xTKd?=
 =?us-ascii?Q?riVnkhTBjZd91TGZ0lXJjvEb5+ABaXPiapGlxvzSnrQwL/+u3xEJSrKvnsoo?=
 =?us-ascii?Q?9kjMrxDXmLbyoWjFV1chHTZlqzTOhPerGd/PVeD2mSlvf7h+DPgQBtQjEJxv?=
 =?us-ascii?Q?8LoBHnWz/CvRHHSvhsdEo3kkUbTfe5rsmuGlXPSpCt0bA39G0B6GDPp1qkVx?=
 =?us-ascii?Q?MJFus1gky9AgI68eAWNRE4MVPkWQCkz0CZsB+tp7bB8dXhKkGUU3NFxUoq0A?=
 =?us-ascii?Q?WngxJEtJOtXF7y+7rN6HAbLckoUBxifC2vmKFGT3pXM1SDZOEQY74wFOnloV?=
 =?us-ascii?Q?XXErushg48+jn5+wQAnK9kSL7+c5VAkdHaAXzNieDSlPvUBWK+3HUJkLbHTL?=
 =?us-ascii?Q?NCs/sWonFZ7p/scroBL3tXkEoByRk3INOBpB7QFHLrshioyG+X/CMNupT5Jk?=
 =?us-ascii?Q?721rm9z0XggYkP4myrWPQ5RB+lhkmLL190nui1z2k6703GruFC0SZ0W0ZUIC?=
 =?us-ascii?Q?wqFpiy+1Cy34h+j0sSRYkPzS3HFqXdUhstlgxg1yLlKXl0X9659vdUP1BUNO?=
 =?us-ascii?Q?mipK7CuWk+2SpQFNBPwcJz9WC23D4fzHftM+JmaeliVMW/XBunN52BNNbe0Y?=
 =?us-ascii?Q?qhE6qDoS8WbFqi7gdpW9cwcVnc3tM8fBkkvg4MH4oJ9kacpCmTorwLwoahyV?=
 =?us-ascii?Q?5yPgdXbnRcE90JBUhIr+gHhIbl1nZhoHGdoXqobzzoYPxUnwLbGf35xsXcD7?=
 =?us-ascii?Q?pqk+HP5bX5PEi3d2RV8CFKRkw/+59yFzQ3LGMZgDFD/MmSXUKlb5qypXsaIv?=
 =?us-ascii?Q?ri0GLai/LeaAJMHQun90VjG++HUugtqt07H/ttgVGbyyYyyPe05E2R8lD3E5?=
 =?us-ascii?Q?wJFFWLnqOk1s/DnofZEt+1dQtMfCxAwdxeX0MoeJeEdIwfLW/RD79ShRn+kW?=
 =?us-ascii?Q?+LmQtYTH6noyBDX2jXwbCNvpR2hhbkmKDSgSuZnEb0SKlWvmw8ceMgM0SYC+?=
 =?us-ascii?Q?ggNbRpeiPDSbTOWndNzHeyJeXL9Ck4hFhllJAeEDcDTzatK4ZJaqqj9Yk/YF?=
 =?us-ascii?Q?ovWbtl6RlnTCpQlyite/KePi3fPfGg01w0gbPXWYTIuyD75pQKdnjV3icECE?=
 =?us-ascii?Q?yAbmDwQBzDJEPO7IND2P3ruioi3/tWeI9So7C4h/1cheT5tEiajaWFgnEDMo?=
 =?us-ascii?Q?KU2h9QO9MvkxXg3Sl5jh3d729nvnDvfoSP3fOtVgzoskf5MeG5uCtklc0haE?=
 =?us-ascii?Q?LB9iCdfz1EmgScBs8udaNZ809ks6kMaFXHShCzLv7RBuTd08MXwCrSJk6lOl?=
 =?us-ascii?Q?VDj4earHLEpuy9tRnaIiO9qtXw2Bt6T5T3zWswuXhkpBGUeToBI6JyQOfh8Q?=
 =?us-ascii?Q?ghCX6kH9N6YuVFi9tBDoCvT+DvtuVgOxmJzkJoR9y7vfeT5IfwsrYE6uhsQK?=
 =?us-ascii?Q?CFB80ikhkIKTltLcPL6ltOjS6qqkGoo4PRBrKvJys/GREYTRbEluZXPKRkIf?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e6da6d-8b49-44f6-abef-08dd19bf6d2b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:40:11.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAbJ5rJfH1pLGnjkSMy1R3ztQQRgXDQVodQGPFB4WQu6d504a7ki/Av2lgxXp0x7mptoPcR77ZORrKqBP4zer4nkqdwObzOTzpvzrQXxwUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-Proofpoint-GUID: AmlWdsQXsXNLFgpAMAn9lc3NyOrLoFgT
X-Proofpoint-ORIG-GUID: AmlWdsQXsXNLFgpAMAn9lc3NyOrLoFgT
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=67594fee cx=c_pps a=oQ/SuO94mqEoePT5f2hFBg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=UqCG9HQmAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=kJy0AXKTCvhfZgbxjNgA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=744 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110064

From: Juntong Deng <juntong.deng@outlook.com>

commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting 7ad4e0a4f61c7ad4e0a4f61c57c3ca291ee010a9d677d0199fba to the branch linux-5.15.y to
solve the CVE-2024-52760. Please merge this commit to linux-5.15.y.

 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc8..98158559893f 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -590,6 +590,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.34.1


