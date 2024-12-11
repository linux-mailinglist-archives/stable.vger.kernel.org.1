Return-Path: <stable+bounces-100542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6929EC61D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CEF18833BE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19EC1C75F2;
	Wed, 11 Dec 2024 07:55:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C112451E2
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903733; cv=fail; b=incXatqoWisRLICd8jSAl4fw7Z8EzrYm1sdFoPKyTt6zaFKuZ3vLDUE8QTUZwg9rQEW0xMC0K8rXkKgz2ukwmnkfw+3r0V9VhC4CYqAPctgN1Q6/hWKe9Htr0b6z8kdCOwQW1SMiqqnjo6RNOzF/yjMdID9LFiudYQcqjtelPEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903733; c=relaxed/simple;
	bh=+ZT/Lt9uV/Klte7KoFQRwdrvi7QScE00RpvA5PlZjPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KPxfYCgoY+nqTbsVEMTJ1ABmIy8UyHXqtyxknZGyXHAyayzMxtRSFt1pjepdJ+3v4MJ8JKStaPfaTZMRpldbzhWkUysNgNamACXbORb1JonMF9bCZhbQZnOyqJNiNk2EX/7c1rsGdaa1pwK1IrxaGIqc+foI1vJWay9eb4gU8Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5d2uD027034;
	Tue, 10 Dec 2024 23:55:21 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u3wnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 23:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+1VqBR4ZIARh87PDkmkbMW0VVGPXf7GYl2fTt9EOLHrTSx1A1TdsIWxgMKLmCGjYW3H05LgmRHuWFJKx+jmkkvBns0XFcHjvEyrWT2jiNGbX0yoO2Pa84UYQUwnGPxMNsYEOZBENQPxpHwBhJNO2GBoM3Mn4stwwhYfeApW0m7dLiOORqraeUYqvzqJ+d9Bb9pT53KFX+4p98BFF4SPQXC3jaZ8G13qOwgyI8j9W463uMzXx2kzFE+Ag8bdo2we6LuutbNBXaGw9M7V+29loCksKwa6LbQpqI1OS2tyLsV3gvS5FfnBC1/qloDO7LYOKIUFWqZnE4HllE+Wy2WFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VSml0vamU1omDFVajXyvhW+umLoJks69nSGreLhIVs=;
 b=U25QCt4QRJryG0g0mJWkulBtJgjst0M2i8xW63UqiUSZJZPvHGq6w5lBWuzdS+beGsCkLUOslISikZlBluYj8/1alq2n62uDNYyFDOX0PGSpl87y7R7CC6InSZzcZy6FTiagl+qA+XwWcmdkqZIeYNYTUkpxOtd/oOyH9s4ry1uN5Ac/TU5/5faqbHrJ2j0f1kJsP5LE6gj2XMWQIP+ZFF/yXA+iXwXHHKSi9Q7qx9a3Li8HefPBD1fXkofe8pkckLnmmoJFwTXwYFLBzVPQxrKygB7bzzMqHIz2qzSQ12Yz/Qa27Kq+ilki9m4fqkvYQkmbrNhs+jpQQTC0KV1t6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Wed, 11 Dec 2024 07:55:17 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 07:55:17 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, juntong.deng@outlook.com
Cc: stable@vger.kernel.org
Subject: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 15:54:58 +0800
Message-Id: <20241211075458.3346123-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::21) To DM6PR11MB2665.namprd11.prod.outlook.com
 (2603:10b6:5:c3::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8559ed88-847b-4d1e-93cb-08dd19b9269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eU7BBDVQBqCs0UHPlweVyQNOUey+F4erTV9BeqTgpxu5wVXC1Ew4+HVD/4Q7?=
 =?us-ascii?Q?2b+kw2yJ/63XloYw0Ytv0392kVmOO+0BFVmCRRBWGy3T1/AN0/wY2hfxIlxI?=
 =?us-ascii?Q?Jlrwnr2OAlDLeyP8KiHdmlq11zq8FRT0I0K5c04vADpCIcEazD91P5QOdscc?=
 =?us-ascii?Q?bcwlXbQUc0tIADXPMJ24WzipCQtokp0KPvH5DO5Cn7QH2VOCh0FkRF2QTxgg?=
 =?us-ascii?Q?YgY9ClwCYg30u2nYa2MrvnormP1EybB8iXvngi2+dpW6Q2r0CLNnW3c3PmKZ?=
 =?us-ascii?Q?V/JA9Ri56Th31D7J07A8uO3d048Mj3jJbfVI6Y6He9nMuxwZB7YrsiJt8vIs?=
 =?us-ascii?Q?O44y6oHIKUhzsxue7xZPJaS8Mq9LhT8GHr+8+UXjXPMFA2MzYq3m1i7iNLs1?=
 =?us-ascii?Q?yoXNlplG01RCxv4LWwlYU2IA2wyQvR4aM86xdLaWMFrPk4FJsrlC+i4mggt5?=
 =?us-ascii?Q?oHRPDH+YI/R3hpkI3L9rwezKT6Kpwa9S2aOZtxstuWfWrVQ1wzxlqCrdpWuV?=
 =?us-ascii?Q?rjoH+u4AqDL3qJ+ZuKdM56ZlNxSUGHK4UDbH5M74dws9ZhssfFkK41iPc6CV?=
 =?us-ascii?Q?sAB5RnD72U2amlpQGrbIUJsya+63SGT6tsbguo5R6KqE55w1XlOMeOIQ6g5n?=
 =?us-ascii?Q?33se9wHJlnZ8PNPPk9eqGl5Xj5/IRXB+rSN0cZ/OL+KNuCLAqkyNDtbAx9Y4?=
 =?us-ascii?Q?l7sBpDPBqDYyIOfrrDOMsMnKQhtWfqa9UOvKcpvkgtppWD3oumFl9PyZzohv?=
 =?us-ascii?Q?/xCEXjIPUufgZc1KaJZIqCjvzgTky96lPPQROFm8XeFh/NGlKaPjw2221FIk?=
 =?us-ascii?Q?R43ryZG8f1ZePzy/6xGlsOy8poMrm69P7PFrwKzzFIFqyzcOnSoTP/8HyI89?=
 =?us-ascii?Q?spfzFfwQISY0m0mEvdCumONNxx0one2cOT0sxjWN9CqMsoLTo522JJrIJ9rk?=
 =?us-ascii?Q?5ifvcQDPJgGh40PKT+bosKJuzGFeWBORoG/u5B6qns0+AcJTrKScK35Hcp71?=
 =?us-ascii?Q?oxZgpTvRUMMKOg+AXOhsYYts9w8QSV5CdklgoD9NuAZ6Vai3PzEglqnfZlfa?=
 =?us-ascii?Q?/JG+cVBsRh60j7S2OnyksHLk/IIflr6skjAMEki5o/u96xjJHuTBhQpvBVkI?=
 =?us-ascii?Q?S7lLatRFNrkBjCW8NeFL4ldlS7KSyzQaJ/jre6RG4WwyYcz4lprbCt0mq45s?=
 =?us-ascii?Q?tvbZWNBSjYLq6iaSE/1GtO41rHnGZCIGZAFSQTgZixbUCD5SEba8N8kGYdnO?=
 =?us-ascii?Q?RQI5HazFyc/WYaU1jOTsj9a4Wv1J161xEU1AeoTfPrHLiQSQmU9+0RSCAWB3?=
 =?us-ascii?Q?ewnUWMPj5/XYa0iR4dC87wbdlrzHLswGOda6Xst7Tb18JaOWrRXtZcjgXZ0e?=
 =?us-ascii?Q?fLKkAIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXxMzWqpcDfZKKa/LJClOIVfHYRqI8EHe1ZLTLbQ84GFAUAFJCL2qlNsuwcd?=
 =?us-ascii?Q?KetGHAT9nx19iKHDEYu9QLgB1ZHplrgLgLHm0Uy22FbMUoZRkKKDKIEqNSQP?=
 =?us-ascii?Q?DchcbxgScihpxWQe/ZhlsmfxVJojxlNI1cz1BIpPCol/Y+PxsyV020KEWC8G?=
 =?us-ascii?Q?qoOIcHDZw/f81zLk7ilIYoE0RE/nj4Pmc09xgCx4sw6p32ZTHPdAOMfzhWyw?=
 =?us-ascii?Q?xSew4yrb9Qvw2GAl4ZgE+KJ9t5LbcOvgP3w+SVxBYd31QBOawJ8XnJmHUrxp?=
 =?us-ascii?Q?cy0h8Jf2kjIEB758BKVd0ndFcFB7crl5Ih3JWKsrIALVLIbTxtlmTyTdnhEz?=
 =?us-ascii?Q?aCZ+hPRu3o7OoSAHFvf756HqeKwgu6WHUvd+DRBnM2amwydBPKKsCVRK+7wh?=
 =?us-ascii?Q?g+hj0/H4ZkI1h92tLFSxjArGU8faSrjpaWi0WDGJX3uDCMvTseHjIKiQvSkf?=
 =?us-ascii?Q?oHH6U2txFnf6re5P5I/HXp2joSPxWAj3AXKFBE1YyhJ/prM+LE+sYl/EAFSZ?=
 =?us-ascii?Q?31wQHLEBAwFmObdVz+9VmLGJyQNPcq5CMxZnOmnJYJ5A1q1fhMSm/rzCvYQN?=
 =?us-ascii?Q?VEfB7cnmyjk/CgYLwGqYE+OEtKeJg59hmFyTVo3YPNMtKNKvHnuMTbsg8fjr?=
 =?us-ascii?Q?ioqh4DJCnb1YdJOW+a4hIEcfgmOkiJQESvkdFcj+N6TzWYPF1NBOmp4x7Wed?=
 =?us-ascii?Q?/5yvbfW12E5tv8i5qTiDNhn/duLTBnl98Gt4WudRAI6cQR88C8ZU11S3mm7T?=
 =?us-ascii?Q?7afIL3fycmTTSjzvW1pvHvWGGHni5SilreD0A1EjnNaF1k6G3FO1jsgXRB+g?=
 =?us-ascii?Q?Z0tjZtWdB92AZbz2c1vkYuJ8SxbfZuWI/rgesouUK4NexcaGSul6TOULw137?=
 =?us-ascii?Q?hCOYOQByq/fF7ObF1BgYKcqAGKM4Is8HRINDRlT+HChpCdIEseFyrv9JYG0r?=
 =?us-ascii?Q?DWT47XVhJHC9wcSrbBerOJSEJVLjsDcKVwiMv6UD3349K7ihwGeCNE/5z3Rb?=
 =?us-ascii?Q?b6V7hm9Uof5+SWbvqlM6O7ibvyf4bgCFkJMn6kHzESGLVvya7T/IWkkjoOeu?=
 =?us-ascii?Q?L/4cnnPpes7IweN7UeG0P/5nPA4sx8+HrMdSgZZlitQTkeNegPfLWxppivj+?=
 =?us-ascii?Q?IuxGk4IDrsmgsAE3TWFfaVJUEFmQWkCTX+sPcq7pwIcHIKPwv4/Koyw5d05H?=
 =?us-ascii?Q?92d5GWI84TD7FUz0/YOL71vgcjozHemwOag+OFAHhDp+csGl61OCxReE6wek?=
 =?us-ascii?Q?gv8nOJ7HSY6xIlbfbtbHNACiTWIOdO64qk4u6NLwhW9ovCd36aszJ4o/L/iC?=
 =?us-ascii?Q?dXe4pcsJong+DindEmznZcXR2fTvDyGR7zmF7tanMNebAGo2qA525YDISUXs?=
 =?us-ascii?Q?UD9sBAZJK0tFIPG5c20Uv2UzPKOPJwHpsf4o4Ljppt1nmvJ9ciR61wUxwGRZ?=
 =?us-ascii?Q?oGGvfTAPECxayci+vmeGUSR+TVfK9AnKBKBsovUBHYWCkPVQ9Y9i7ZDhU3Lc?=
 =?us-ascii?Q?fiAO0K2pRdnJfxv7PgCx+0Mo2zLD44v2IgkF9stuj+pZMYQPe/SkkAFjbT7z?=
 =?us-ascii?Q?vCWJ/OntXhYieoeS9EmCpdKfVjzH+j3ZUdI8QEYIlqy4HqWIwmrhvC9a4JnC?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8559ed88-847b-4d1e-93cb-08dd19b9269c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 07:55:17.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GN18We3OGaDyI+3XUYDq6y13FwR165pa6P1VzP7rpUsPaTcvz+isR/QO+Di6vLcPjoD7pRUpYC/xq7I2rcNhUq9uOYlpK4eaj8nXlhBi7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=67594569 cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=UqCG9HQmAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=kJy0AXKTCvhfZgbxjNgA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ASnT6hho-bWL_DjfpxFksTJuMC4bXlk_
X-Proofpoint-GUID: ASnT6hho-bWL_DjfpxFksTJuMC4bXlk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=742 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110058

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


