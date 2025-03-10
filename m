Return-Path: <stable+bounces-121640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BAA58A1C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781493A9390
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82BD14AD29;
	Mon, 10 Mar 2025 01:41:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DB433C0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570913; cv=fail; b=YYe2KZJ0CcUOKprLmJuZauAAFxR9r7d5Kce31qJHoehHb36wtGdJ+7YrO8IT8/PzmaBy80voe3Hoz3J6UEJWzRyo+hhLRN6/OePayf9nlXFMNE6UO4geayrKA99G17c8h5b30VXEg2/fqn56bLUH5u1+g9/Yjh1x8cs+ufGx6lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570913; c=relaxed/simple;
	bh=vBjIJD2YjdL8EHRbab80FUF5heReEhV8OTDKod2lrZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hyH4pXopWcKPADttIvXDk5zUWGrQGA/TeqzgGnjV0SmOBdKfcmXTCbM6pLwnlsLq3hX26GgjSixFkbS9VyfbhbqU79dn8Go9+c3C+jUK0RNFuFYShWe5CgLwfUCb41fP9zvxI3aosehZz2DJkelNqJo85CkttHBR4ENWzdy8CoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A193Vb002737;
	Mon, 10 Mar 2025 01:41:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458cv8sh1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:41:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wimKgbcFs/fIFhKgfmCuABPJdby6yWPJWrhJLghtSrq8QCMPyJ1WBixyNrGmqQ0P/ij8KwQw50mWMZG5qrZsTznbbUq1EVV4mGoQAT63Cd90gUWpRqOZQWleO/jUW+YBr0bpndIiJMwon14LNiCCt6iQjpj6ZD3Lovsx7EfJa6W8676YAxpaRzNAq7QYyH333A4nBETg7cklxSTWpxrqU9IyoRwl8j/7lcZz8NqciDD65+26q80DpnurpDFSxWYQAskzWLSvTjtBdH5CLdyIhflcIZow0WF8nivkKyAhbDAKywps3k5oSq9t0OGcyK6vXszGWwZwJzbmuwnZ2eVnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTzmZB2B1slTt+tmqMpBvoQTZCk4DjKlE3LkxwA4Tms=;
 b=ie5DN9nkOCTWNve6sgngPZXi8+E7ek3RZEcQruF7WbSEO19t749evvimfawOvhMx3aEVh4a9JQbCGe73FruvXVgS83y8ZEY6BUvee1FXUNS5ydkmMOrsEeRhG2tbYwMrhBrdlN/QR+bcNWKYHHlIbph8Tn27OAVtF6iDh95wz0OHQLqZ9w3q0VjPYT72Hb6T8yRzUY/+ZKz9gEP9F8TdsXo79L7tXwHCI0kzRscqSllbB7Vkq2fAZejB96A7X97CCEc1a9NMfzCFaU6i6TpE6ny1/vV9fwQ2DqybXsdy8+xAeJE3AQzPNOJL0GhUGpaYk8I+TBG0zECwEyEYlDAUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:41:33 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 01:41:32 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: pc@manguebit.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH RFC 5.15] smb: client: fix potential UAF in cifs_stats_proc_write()
Date: Mon, 10 Mar 2025 09:41:14 +0800
Message-Id: <20250310014114.3430531-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To SJ0PR11MB5815.namprd11.prod.outlook.com
 (2603:10b6:a03:426::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|PH0PR11MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b7ec11-2b41-4526-441c-08dd5f74af5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYxWW2Iz8O4BUOZ3Zr3sJjmeA17hjVTk9hPtnRzJI+csDBPZWww9v/qJtmgP?=
 =?us-ascii?Q?HjhCEDWaqTCtdp3JM3FRu5auCkS3xTsibwh0NjmAZM6ih3+XPuWtV/kiSmHg?=
 =?us-ascii?Q?llkD5pvKcFKND/TF99ivy0b/8Sko9T4lbV2HrAUG3baj2Zcmqi+hRt0381xG?=
 =?us-ascii?Q?zBp0sMXMEk1708w8NUoShPryi5bywgMZLYp+qgIrXUKhEz0nB1wkvaAEfuhS?=
 =?us-ascii?Q?hAU2pCoMqiopl4iHCCPsKXd6CvGvgMmJV/9eSFZmrpxwtjswUi9nfK628Ism?=
 =?us-ascii?Q?vDD+EsOQpUUJ0ehPyli2SF1KSiGXhMEyooAX98IB85+9QT2e1tf+pMsTt2vS?=
 =?us-ascii?Q?Y4nlD+K9b2ZOYTVH8WdJFI2DaakxlJv+j/IUrcyo6RnVTs/y7x4EBqEJYfX7?=
 =?us-ascii?Q?v+uioxiBxj3xRfygNqLkexpCkp8Nbu7uHCLW1BCNLpvmxg3O9ipq28a6BT6r?=
 =?us-ascii?Q?OUtIfmQpjENRJjAWGyrmU6bkMHbHv20+bD96cDpTn1zRjmqZtEWlhInnqlSZ?=
 =?us-ascii?Q?7tvoxV1xV5VXMp397giCN6hdIPdfPD/dVFX7x0GhiECQ3ciKfjfB3HajTL1f?=
 =?us-ascii?Q?zopHi5em5ozrgUnGJpyOCG0bwIBKolXJr6jZErX5rV9qNGtaNmOMn1VP54Yk?=
 =?us-ascii?Q?AHZsOcekhqr77IKEsbbVTwpzeuy5lB9NTdzy3ds4FKtzdodqGuBcHBOgfpqy?=
 =?us-ascii?Q?tHdlW27tLcuI1hLOvrLPwhXwIoraIeTsihjqLmtaD9j6+8NNdzW2ewTLy6bp?=
 =?us-ascii?Q?koCKSvjdvGWZYSho1H/7PQCZXiihe8jipS+5EfIDJkwevXSmQlHQoBfYmNYK?=
 =?us-ascii?Q?A8iB2QIsTb2YJVdLnX2Xxp/V8M0cMEG+wACw424OPhNM8Jks/hJ9L/1enJ52?=
 =?us-ascii?Q?Vhqax5pc/rrDq/WFBY5WvIroUvy3dXVVSnidyiECiVXtm98rI3+DVgl2XDDE?=
 =?us-ascii?Q?A0wD42rp4L5K71kQC/gpitM1ctH98q51EGctS/3p0ioI5h0LhQR5JtZtT3bE?=
 =?us-ascii?Q?rhlyo7CyUs/gHCRfo7oOcnQrSKqWgh5GWokdzqrqsepqP3trbLItZ2V6a0eu?=
 =?us-ascii?Q?AcGxubOTeFYU62hb69i7B0UpDjpz3Rj6wK3+uF4J0875XTxUBl95Tn1MJVfm?=
 =?us-ascii?Q?q72eSp0HFVIKApifiWqfM7s/uzE17dHGRCBqTjsyNG/JKF2PUVfiNOiofiUU?=
 =?us-ascii?Q?WoykGQeskhfwftJS6XGJhMDJ3X23NOzyL80l8ZP2mfOIlBy4e1UDi1e+qXhl?=
 =?us-ascii?Q?ggOnVh2rjRN9eAQ5nfX8PU/6h8BW26xJrnX0vAq/3csNuK3Y1Xclg0JWTzlD?=
 =?us-ascii?Q?FmPAk0g0bKvztpE2Y980lPworTKOZdZmgBh/GJhh9zbeuGccqL/gebPc/LUE?=
 =?us-ascii?Q?iWa/0SCBPvG4mUAYiB5nozVgkdlDnrQN1FJAk0wJJMrosFL+dbCEl16Ph7Dl?=
 =?us-ascii?Q?ymbB0MYb1+iOmrVwgMUk91rCejwRQStX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWpiphiEoauhEMgXdXEU4cXvLvWFt6gJTb8DmJW9ok4GfexpO7jB/fkMES78?=
 =?us-ascii?Q?Fg4jDDU6VT1UQALkK7OxrPWONehQD1WzGTLUuafinKinF8Q0prkkCv0mvR2n?=
 =?us-ascii?Q?WsivrQCuF9WMf7rYbswotHUGBevF9qNk1tXQq5gVM8xCwWgxmdi8oc23pv4x?=
 =?us-ascii?Q?iN1YK7F6Bi4L3XlRYOmCA2yml79EdFWeQbmcKf1BrLi4HvZ4OZTK4dJa84mB?=
 =?us-ascii?Q?f8Rj3mvAWln6r+WImGq+VBVpUlLeobfmf1sKnA9T6TPXbETFwbTsxFYO0j3l?=
 =?us-ascii?Q?sawODSAdgb7EsaBwfv764WOUXBsm4SLA5SCL5oK9ORklKOnSgwok6Nkn7mi1?=
 =?us-ascii?Q?mnblktpYoUSqb66vCzyB5W+FV3EggqxQyIuvGOAkRufGxYfEcDInWBuQOIZM?=
 =?us-ascii?Q?xie2exWSQRoa/7k6qLJOZvVR+n2//QoNuezcFfc95TVPWhZmbXOodSqquSdn?=
 =?us-ascii?Q?7WDQlkazZmvP2NQ71CvEC/uenxjHR6q0IkK4Z5uQNKhMq36OXFLWcDveq4kp?=
 =?us-ascii?Q?IIFugc/+V4x7FbP5CdNCoOPpRJy9+KB7N6O72z8uvwwTd5KbBbeIv31Gq7p5?=
 =?us-ascii?Q?PLQmdvpGCPJGeDshlWSvX7VVg6Pm3WSG/Ekc8ihfdVRqtiU3DMV0vCZHEHfM?=
 =?us-ascii?Q?7z+13iBnHKi9DSeI++v1EPR2w38NEQ5l4nEc9z35SyXIsju30B4p1DlmVLYH?=
 =?us-ascii?Q?n+tWbFzXf21dRWZitH6q8KhYanqwlnuWMxRt9NLcfyxk6iY+o1OEIIRLZgXm?=
 =?us-ascii?Q?MItsHrNNxwKFsf5f0a+UYfSvRLULzklktRjFqso6viEB5cEPPh1RKF1m1seu?=
 =?us-ascii?Q?BIjTzcajunDnovY42d5it+HJlRgw5WBF3/aCx9H+WugBENnrHkBvmWcWTB4L?=
 =?us-ascii?Q?gwC56MoGNiF19LhaGFUYbnHvaiPVMNZfUEjz7phBZAGIxvuA8BYogL0CYBlp?=
 =?us-ascii?Q?Oq1Z+o6ngsIXOgqX3h1cGXgyetOE/K4eP1A8BDpoMWu7XOXIlEXxIY7RotRE?=
 =?us-ascii?Q?fwwsz2oNSS2pcMp2JAGp7L2zgKghb0UlPY6iKY1qlHdydTmsZVs9+63qdAqk?=
 =?us-ascii?Q?5YFTELOLOdJ14xFtcY3eeWP6KGajWFI1B53dOnJcsNRu9aZf1INF0427zdT4?=
 =?us-ascii?Q?qqi1eSnRYs2qFi3XX0FMObzzGXRT6a2jqLw6clh1dGCbdbOivkbAcqp5d5cv?=
 =?us-ascii?Q?P+YlawEtwmdft3Vy9HyV5iNCP9Z41aUehKrpQYgOzPmi1fI080Mn1HsEaM5D?=
 =?us-ascii?Q?wvjdPBoHjEKLB4NDeEmynNrJOKimq2wfpNYXd7p93gKsRJav0fAUxOhRJnfY?=
 =?us-ascii?Q?xG0eLQ1aIbRkL0hoRkArkxR0Tj0h3cvVYGnMBo4SguZBwEFpTENYGBc5q3LF?=
 =?us-ascii?Q?W6TZThQgsow+5wOsbYhUWDEy+1mx8pe++oCS04+FA6Tfesplt4A9Qpa23vfj?=
 =?us-ascii?Q?4zKYNpU/DKVW1vdfoPd6dbUARjdqvPQ5wPclOwVlPqw8sr361bMxDEL4z0XZ?=
 =?us-ascii?Q?NpIrS31iCeMXA8l3wSJJVtJ+eaVsnjiJCiKWLhm2M4cIeXenLFaueU97Nw0e?=
 =?us-ascii?Q?THotpQjvgUrV9uJEfInnLYxyQkvE+cHSEsImeMVy+Waa0z0ERb7GNz5J7Yn0?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b7ec11-2b41-4526-441c-08dd5f74af5b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5815.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 01:41:32.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WhYmnQRPw2F2YLzE0+31D7Q5F64NzdjV+HF3co2avjUoRisollWagN2XTpJHw5ylAmqaBdC8KORMMny9PbM8hWKq/z5eWr08Em9NhvicC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-Proofpoint-ORIG-GUID: QmKvRITsuABkCA0mYWceygmmV9EC9Ys5
X-Authority-Analysis: v=2.4 cv=QbKcvtbv c=1 sm=1 tr=0 ts=67ce4350 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=Li1AiuEPAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=i5IeLDUB_GyS7Qvew-AA:9 a=qGKPP_lnpMOaqR3bcYHU:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: QmKvRITsuABkCA0mYWceygmmV9EC9Ys5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=921 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503100011

From: Paulo Alcantara <pc@manguebit.com>

commit d3da25c5ac84430f89875ca7485a3828150a7e0a upstream.

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ cifs_debug.c was moved from fs/cifs to fs/smb/client since
38c8a9a52082 ("smb: move client and server files to common directory fs/smb").
The cifs_ses_exiting() was introduced to cifs_debug.c since
ca545b7f0823 ("smb: client: fix potential UAF in cifs_debug_files_proc_show()").
and the SES_EXITING in cifs_ses_exiting() instead of CifsExiting since
dd3cd8709ed5 ("cifs: use new enum for ses_status").
The ses_lock in cifs_ses_exiting() was introduced in commmit d7d7a66aacd6
("cifs: avoid use of global locks for high contention data"), on 5.15/5.10,
there is a global lock take care of ses->status.
So use "if (ses->status == CifsExiting)" instead of "if (cifs_ses_exiting(ses))" ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Try to merge commit d3da25c5ac84430f89875ca7485a3828150a7e0a to 5.15
Verified the code compile on linux 5.15
---
 fs/cifs/cifs_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index e7501533c2ec..ce02cc71e117 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -528,6 +528,8 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 			list_for_each(tmp2, &server->smb_ses_list) {
 				ses = list_entry(tmp2, struct cifs_ses,
 						 smb_ses_list);
+				if (ses->status == CifsExiting)
+					continue;
 				list_for_each(tmp3, &ses->tcon_list) {
 					tcon = list_entry(tmp3,
 							  struct cifs_tcon,
-- 
2.25.1


