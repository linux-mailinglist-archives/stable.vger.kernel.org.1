Return-Path: <stable+bounces-86831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E35D9A4086
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F15F288D89
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C181DB360;
	Fri, 18 Oct 2024 13:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C11487AE
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259701; cv=fail; b=qj5+vtitlmgwu/EaOLtQEDSn7DmePsh5myjv5TLtVn//pocNwQhl4dl0dPFfW4PDlHAaAzdE3kk7aCV6F1RXqkXcPX2Fy6niRs4ERn0f1ib86mUhaoHTMxItrV1Y2s2aqjkNnZEFlewtuSuF2lKkqJ4wUQsGSlK9jSntVz8iHc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259701; c=relaxed/simple;
	bh=BU6vsk4MO+Ol9FvzPtlobRCaAHpuzgl5dA6PqioEdOw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RQVZ4JVu7Q0VC9qRF+O+U50bSBVAZ1EwKfb9njaukpHwKxqGUlCgvzoBkeCHIUcROYquBkKw5FXSeU8Q0k7BugV58qXd7/uU7BeXBMaZ8vPAPGjbN/mFwRHgJCpvXTx1n34aPGmwhlIpePfxwPzYjmz2occXLtChdamDRRBBLTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I6bOuf015585;
	Fri, 18 Oct 2024 13:54:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42a3eska7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 13:54:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWuEGxQ2NP5DOPa/SzNfBiX/KcVjfQa4IeL8Qn6hnA2YDrBfciPwRYn1nPeKtacG8c+VJbwrFQ8I41y2RYg1kUKGR45Uz1ch1fEqsRBvUZC6Zc3g2iA5rnDlwz65cBTt2qTF+RMjOUOSwTSvsMwzPQKB/iCBqDLzctjxBS6/9iK4xJ9nIcd2jtvn6g3K4G6wTKoKfuBos7E+lMyiSnrMZvIjpxhAu49XZ6HTmrm636o/rrufNOqcfPL7auv+6WmrrDBPFNXE/CvfLzvUSJB7TDOHtM3k9lPzjvRHxzrE/TJs6rOtt5XUT0CzB4ULr47OjoXCfGpA7Dw8sm/ews2AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2JKcd68INpoRO8Cqz3gniDiZvg/mE3/izaLZGF9sSA=;
 b=UQNj3QnbHIaZjVVeTKGGaWZRAlYomiva+b52bnrRaOsZ7MAxJNivv+O4TMBnk5JCN4KzSYvUj5mxmTnioamtnX/RJKYCqniuIfCIE15XkY2U8Gza60Au+tgqRWPKcqb86Vxbfb/A2Q+aaIjXe/jdVWmXiLZUe0z6m0J59bEjKHpsZppsK6eIZtQy4u+WnslaxC0fOi1/H0W71xOoXu7Qz/Zitb1B+CAHws6GMmDbIKleJkM2JRgzFlvrebffVofZrF24FI8RbvMWIyt0iZIVbFPsl4Id5mtXSmZSVa0ovbW9clqB0C6N7Y9iwcQec9EnLPz4JSI+0iI1f0CTfkIAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:54:46 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:54:46 +0000
From: He Zhe <zhe.he@windriver.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] gfs2: Fix potential glock use-after-free on unmount
Date: Fri, 18 Oct 2024 21:54:24 +0800
Message-Id: <20241018135428.1422904-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 405c7d2f-b832-4608-5c37-08dcef7c6cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaqPRnE6C3wT4/rQKjMUzA+6MBlkKZn/zTYYSSIK4W8Q6q2dZxFoYyK2p8wD?=
 =?us-ascii?Q?FqKg+bRSwme4SGRqSNsea19LEr0AR38lI7Pjnc4Kckt/FIKJbKydmyW4oQ63?=
 =?us-ascii?Q?ZBWkl04+TYE7a7DHlsm7a9QL1n3TYns27c2X+qQOLxItRAQ3gsVZuW5jH8p+?=
 =?us-ascii?Q?Fp8oN9amBEhOEUfZWEoT9lS9XV4rv03DQydNvplhzOhXJH7GpJEii5kaZf1z?=
 =?us-ascii?Q?oNXttFaztuExh8SakpcANNFzqrF8uxW39/wCxUgI2sH+BwcpfqPtgSJ3j77N?=
 =?us-ascii?Q?7s/YGdKYRY75Xy11tL9l1gMwn4eiE9E03l5fP+i5DNT0k5+x+T1nlJ4fU8pM?=
 =?us-ascii?Q?fMKuIrTcI2xtPuaE35ZgTefZsUnK/ZJ814JX2guJvqMrCNuWBAiBFWNgklKB?=
 =?us-ascii?Q?keNIJRXibO86K7wXCVHYojtJ4Jm4SW6Mni3P8VUQvM7jCycYYhtYf/JJ9DrO?=
 =?us-ascii?Q?M17FWZV3pSEKmMIQjWmVtX1yMqU56Ojl/hNK8QdFaok2uEptRunrC/mitW6o?=
 =?us-ascii?Q?biKi6u+Ffgs01CY9phvbu2SqpAeHLscvHxiY3CFyzwkt7vMeBeuiMMtG56Kp?=
 =?us-ascii?Q?dLTZYaG7/Tv1rAOdyDloeYgNLwq97/x0ITIRbSxbjTyXnHkKjyJP936/t0vu?=
 =?us-ascii?Q?8iCFxu4b4wt9JIaUOEgdsdFBKT9E/M9q3OyNJ93AepqaGnOyCmVbC1/XyNTk?=
 =?us-ascii?Q?sxa2XYlYT2jtXu+Ww2DWrjhI3kM4RN8MUKPSZH6GtCMyzNlKGzIo5m9Y/uS0?=
 =?us-ascii?Q?8UMuEOTPOGWgsieQ3roiYtM7lHE7+O0tjNWyS4ji6i62M+oqyyRSE6ufPoX8?=
 =?us-ascii?Q?6uGDexdG/vkkpdlrqq90+ipjdpLSHaK3y9mW/DAdJ6qIvfxQhEM9yI13lYg7?=
 =?us-ascii?Q?UxL7pfIPzpA4s/mnTHWj5CiUMPK6I4jhkJckTNy+kuit49EqXVKcnCcWi8aQ?=
 =?us-ascii?Q?3oOrY2jJuSqWW6JNTohU+O8MnlF5MXGO7JiaBhrBMsLshKUeGEt7RL4rqG/y?=
 =?us-ascii?Q?f9+SZ3/p3MwnNGVCiQE7/W6fb2qOZMEhLIzje9/tTbMbKRy318JBnaJV0JhP?=
 =?us-ascii?Q?FB1jHSh3m2y0dFuXxG4HvjfWUxk6WrU7K2FjJem9Wup83XXeQaV7nCUTsNHs?=
 =?us-ascii?Q?aJvTeSy70RWwJezWE9wzuZFrR5PVF5R2H5yKDLbEAV9wso9lzP+FNnsbAC6/?=
 =?us-ascii?Q?ZElhO3A+h32LwADMKXrkKfqKcF//IzWrGwJCqWyWgp8KHDZTOvBhgyf5TaVJ?=
 =?us-ascii?Q?e5vXJvnHc/fiMnD9X7siWUDFT2h4PVyD8+norbeIOR2p/MPpX5KDVHkZd/DO?=
 =?us-ascii?Q?7oR9IJ5DanUa9SLtykRfffHMo+ian1Mp+SXQDx+7qSE3K48ydQ/KvuWNwBBk?=
 =?us-ascii?Q?33cRd/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpz7/GDwp/vD4BG6DxBymkLyinzIGgs3oKTylsegZY+dmw31+QlPc0+L4tuJ?=
 =?us-ascii?Q?AEQeoBIJulaNBq6S3Qqh9/W812ykrXUzOr/avDQ4kYaKiZW59gWAOIM06CCX?=
 =?us-ascii?Q?D8rNEMbkeheGvegRK7uDWCUBJGf0oZcG/UUDloLuIGSyp2/ntivwlLqpEIDs?=
 =?us-ascii?Q?4fueoEcck8U3J4obZkPCBUJ7CCSBnCk3d8rUKAH/+PepsmLW9LzA07UMVuZL?=
 =?us-ascii?Q?RrXsOVVqVVCOtdAS1Bki8goZnzeDoB2sA3AGXVFa04LNA9enbgOx61BN4hBp?=
 =?us-ascii?Q?MVKUaO1a1JPp92etEg5W0gM2VL1kWM3Lfenr8lU1JyysOg919+e051AaFKQg?=
 =?us-ascii?Q?SVc0WFSZGDu0/KREGc68E1r//+SWJqQzgJi+Dwtule8201hvYVXhhMPrlJ/q?=
 =?us-ascii?Q?p5XbQZ6ei8chCLmoPjAPLu4mx3alzwk+/b8qTSG4NXgo61XXD3cLaPgtZ3aj?=
 =?us-ascii?Q?Ln4hHFa/JWFN6I6E64VMpqSDXUC9nu31RwSNtcz/47bPoCVVEfrgyYywXLAP?=
 =?us-ascii?Q?Ao6cClj78F+VmNaX6UyzYgrmxu6CAkRDaA2xvNmzLnFqFojb4luL0clKe/lp?=
 =?us-ascii?Q?iLqHcKgUceHLpARRMSvk9SW5pgE8bp0mhASKj2+TrWP1+sgwZqhkTFW4yMqa?=
 =?us-ascii?Q?5TRrqtI3QWh2d3L70Q3ic00xrBjmm4IQYdzzW4JWrP6fq3ZdEjFgTyIpnP84?=
 =?us-ascii?Q?7BVaZ0c8yMYKd/EwduwsT7Pv6kAZyruUoMI3xaITYczIYjPVkRjVqMWkZQsZ?=
 =?us-ascii?Q?Tp9EHOn/mIDpVwV9HTkVeMPVRvUC2SgcZAyV6Fz4T9LGuXYEEnQ2YleVhRt9?=
 =?us-ascii?Q?gijbB6YZNPcrd1jDz7m7iBIGkXa59tH7NZMFy8ZdQYgqyx3L/hEi8I7XMPes?=
 =?us-ascii?Q?r0w9OhAi4gaaxjhaSVw+HLkJMVSaQtRYmxTbLFVc4jY0kwSZKBA6MywSn2AW?=
 =?us-ascii?Q?LpTAPYPtXijElozsoaL66Ud6KpnO50xzIvlz11lnUbqnTqXbW7XNMj6zeWFi?=
 =?us-ascii?Q?KxtG9/BW7KwyxXiD3rXxNOLtH3/0O2RFrurH4anIG6GvymL0+lYl9ziIRPYg?=
 =?us-ascii?Q?uaBmdw4iw74PAu3RGj1yX4PCDmb259BdXT/vzJGxs0/aUrzD9PDCtVUmbYxZ?=
 =?us-ascii?Q?K7BwqquT+Wje4OB/EV/qUWow8P64OFcUL0xOkth6LPGw0+hbzaiHv+fcJgg1?=
 =?us-ascii?Q?AW60N88vwvQOCOcl8Dc5D3OwYkNcMN8R577Bqo3eJAfwOn57721CPsOb0WmZ?=
 =?us-ascii?Q?EJSIHBiv7/CLuhj2Ewmk+H2579hj3hWz+tKwSlwB+Qg3ox9Y0LibH58NKR5q?=
 =?us-ascii?Q?EHAG2DzdpRdiA0JjR/QyNir8Ve77JUTHXmnFVdanLwO4SA5FBtfrBtKbRFbY?=
 =?us-ascii?Q?8LnyAe64AJy2/MLznVAFxqDhTeIJ3NlaO8Ca2H+uN9xnfOavFB/4WkG1YBsO?=
 =?us-ascii?Q?mxh/T7rMoUT4OHUy+sbCposaUrwZZ6fA6KFgf0zpeX9/ibrx/SNgDhC5GpFT?=
 =?us-ascii?Q?R7Xkqvj2kgKt25HjW6b3Pg8Y9ycQd2EstjoGCs1fnzwGsOmSyaZRHa4Bncov?=
 =?us-ascii?Q?8wYqO8KlgwFD20ohxFb0V0FOpATVsizMPUM0upZc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405c7d2f-b832-4608-5c37-08dcef7c6cd2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:54:46.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH949oQ3XhTqoFCEUpWwgXwJoCOPC+d0rRBZpuYxW95Kwcjc54n2V59X/wfri4Gj6CNm0jb95GjVAgvMIAQGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-Proofpoint-GUID: ic-zuxvpXXXYcsZdFtaf5gWKH9-sMQaV
X-Proofpoint-ORIG-GUID: ic-zuxvpXXXYcsZdFtaf5gWKH9-sMQaV
X-Authority-Analysis: v=2.4 cv=cPWysUeN c=1 sm=1 tr=0 ts=671268a9 cx=c_pps a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=diuMypkBt17-YGCZ2XQA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410180088

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 0636b34b44589b142700ac137b5f69802cfe2e37 upstream.

When a DLM lockspace is released and there ares still locks in that
lockspace, DLM will unlock those locks automatically.  Commit
fb6791d100d1b started exploiting this behavior to speed up filesystem
unmount: gfs2 would simply free glocks it didn't want to unlock and then
release the lockspace.  This didn't take the bast callbacks for
asynchronous lock contention notifications into account, which remain
active until until a lock is unlocked or its lockspace is released.

To prevent those callbacks from accessing deallocated objects, put the
glocks that should not be unlocked on the sd_dead_glocks list, release
the lockspace, and only then free those glocks.

As an additional measure, ignore unexpected ast and bast callbacks if
the receiving glock is dead.

Fixes: fb6791d100d1b ("GFS2: skip dlm_unlock calls in unmount")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Teigland <teigland@redhat.com>

CVE: CVE-2024-38570

[Zhe: sd_glock_wait in gfs2_glock_free_later is not renamed to
sd_kill_wait yet. So still use sd_glock_wait in gfs2_glock_free_later in
this case.]

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/gfs2/glock.c      | 35 ++++++++++++++++++++++++++++++++---
 fs/gfs2/glock.h      |  1 +
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/lock_dlm.c   | 13 +++++++++++--
 fs/gfs2/ops_fstype.c |  1 +
 fs/gfs2/super.c      |  3 ---
 6 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b0f01a8e3776..11206d810344 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -159,19 +159,46 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 	return true;
 }
 
-void gfs2_glock_free(struct gfs2_glock *gl)
+static void __gfs2_glock_free(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
 	gfs2_glock_assert_withdraw(gl, atomic_read(&gl->gl_revokes) == 0);
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
 	smp_mb();
 	wake_up_glock(gl);
 	call_rcu(&gl->gl_rcu, gfs2_glock_dealloc);
+}
+
+void gfs2_glock_free(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	__gfs2_glock_free(gl);
 	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
 		wake_up(&sdp->sd_glock_wait);
 }
 
+void gfs2_glock_free_later(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	spin_lock(&lru_lock);
+	list_add(&gl->gl_lru, &sdp->sd_dead_glocks);
+	spin_unlock(&lru_lock);
+	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
+		wake_up(&sdp->sd_glock_wait);
+}
+
+static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
+{
+	struct list_head *list = &sdp->sd_dead_glocks;
+
+	while(!list_empty(list)) {
+		struct gfs2_glock *gl;
+
+		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
+		list_del_init(&gl->gl_lru);
+		__gfs2_glock_free(gl);
+	}
+}
+
 /**
  * gfs2_glock_hold() - increment reference count on glock
  * @gl: The glock to hold
@@ -2016,6 +2043,8 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	wait_event_timeout(sdp->sd_glock_wait,
 			   atomic_read(&sdp->sd_glock_disposal) == 0,
 			   HZ * 600);
+	gfs2_lm_unmount(sdp);
+	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 53813364517b..b81b369e7485 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -253,6 +253,7 @@ extern void gfs2_glock_finish_truncate(struct gfs2_inode *ip);
 extern void gfs2_glock_thaw(struct gfs2_sbd *sdp);
 extern void gfs2_glock_add_to_lru(struct gfs2_glock *gl);
 extern void gfs2_glock_free(struct gfs2_glock *gl);
+extern void gfs2_glock_free_later(struct gfs2_glock *gl);
 
 extern int __init gfs2_glock_init(void);
 extern void gfs2_glock_exit(void);
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index f8858d995b24..44cee9a4eef6 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -863,6 +863,7 @@ struct gfs2_sbd {
 	struct gfs2_holder sd_freeze_gh;
 	atomic_t sd_freeze_state;
 	struct mutex sd_freeze_mutex;
+	struct list_head sd_dead_glocks;
 
 	char sd_fsname[GFS2_FSNAME_LEN + 3 * sizeof(int) + 2];
 	char sd_table_name[GFS2_FSNAME_LEN];
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 5564aa8b4592..9aad03f0dcdf 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -118,6 +118,11 @@ static void gdlm_ast(void *arg)
 	struct gfs2_glock *gl = arg;
 	unsigned ret = gl->gl_state;
 
+	/* If the glock is dead, we only react to a dlm_unlock() reply. */
+	if (__lockref_is_dead(&gl->gl_lockref) &&
+	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
+		return;
+
 	gfs2_update_reply_times(gl);
 	BUG_ON(gl->gl_lksb.sb_flags & DLM_SBF_DEMOTED);
 
@@ -168,6 +173,9 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
+	if (__lockref_is_dead(&gl->gl_lockref))
+		return;
+
 	switch (mode) {
 	case DLM_LOCK_EX:
 		gfs2_glock_cb(gl, LM_ST_UNLOCKED);
@@ -286,6 +294,8 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int error;
 
+	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
+
 	if (gl->gl_lksb.sb_lkid == 0) {
 		gfs2_glock_free(gl);
 		return;
@@ -305,7 +315,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
 	    !gl->gl_lksb.sb_lvbptr) {
-		gfs2_glock_free(gl);
+		gfs2_glock_free_later(gl);
 		return;
 	}
 
@@ -315,7 +325,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
 		       gl->gl_name.ln_type,
 		       (unsigned long long)gl->gl_name.ln_number, error);
-		return;
 	}
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 648f7336043f..4a8c070d14cf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -141,6 +141,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	init_waitqueue_head(&sdp->sd_log_flush_wait);
 	atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
 	mutex_init(&sdp->sd_freeze_mutex);
+	INIT_LIST_HEAD(&sdp->sd_dead_glocks);
 
 	return sdp;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 8cf4ef61cdc4..039d678b1689 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -662,10 +662,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_gl_hash_clear(sdp);
 	truncate_inode_pages_final(&sdp->sd_aspace);
 	gfs2_delete_debugfs_file(sdp);
-	/*  Unmount the locking protocol  */
-	gfs2_lm_unmount(sdp);
 
-	/*  At this point, we're through participating in the lockspace  */
 	gfs2_sys_fs_del(sdp);
 	free_sbd(sdp);
 }
-- 
2.25.1


