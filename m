Return-Path: <stable+bounces-86833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CA9A4088
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF01D288E48
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BFC41A84;
	Fri, 18 Oct 2024 13:55:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94561D9686
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259703; cv=fail; b=gfjSf1S85HGTXN0lStmSdXZyl3bggJBMlCC/1+/whxIIxnqnCJl2/aW0r4rS8xQLkBJWFIRiTaJBYAVGJ3O1pEYrj1DnEUs55kwNwpvfoMWSIGYNsdwAr3QtbTyo7rXH7Llab9geKNZsFDCUFh9RK3u8OLScNLa8JoCPf3NV76o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259703; c=relaxed/simple;
	bh=vnKsHCIg+9qRfYGZjBjMilJxj/xF5eqi9KEt5DcfnU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjCa8+wG0RvvWZ3mcYi3LU/HxNG8wh8pTq+8E9oKTVSOB7tEfDK1qnRwUXJLhPWLDsZ6rbtIStKWUPGPxBfZ+N4Bmg37K3c8ynZ8jvyodsaq8xal0IH+mtORMuwL4D/5NmCF8bYD6sG8JjmbX7yQ4Lo8GE+eq1fvjEMGA4T1u5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I4uTA4028388;
	Fri, 18 Oct 2024 13:54:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42a3ddbata-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 13:54:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6leetzhxE9VN+CthUFLHv6XLqvZOehI5/WV0hE8sARZqSsLBM/IIW2o8GMfrEeJzpgH3f1PQ8kVpNeA9K0RJKuUBcUtG5FkYqdyr/yPo9t+EmqeOg35+57zuqUQlmp0tuaaG8EpdHjB8OQIb5dXYOhfSJKupD3AWfcd/7cpz97hHVadS/9edrsqiluqYcVIVHte6+j5gbM+RpyHiP51t7gsE2zO6Smtmi7ZohmipF38OgOTFuKhqPJJIMjyEN6BpQDc/VpUHaEzu7TzHEqyY6RrEFdFlt7KnjnZKWwMpnPe0M7QozpvAS0yWIAh+ZKlYyMcR7Y2FrMG95HhhHG27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfSTasEFilRv2r8HYHrzqlWX0OkQ2B6eu/A2CfroLEs=;
 b=HyU9fEfkxSyU0GSKUFV94C83FAfjiJczKtrEYg98EPVtO7cS9SfDp+DU6z4JuTG8mbHNrHqWNVO7RY9eRt8yomdyGCLp2NeyuD0wUg2gHzJw42faPriipJVZmlG4cHqkLrLI9GsNZp1ljF6zxZCo54Jbxa8p/CrybrgiEuslqWWV5Nb3XQpDxEf4qwp+NmcwQU/eZ5dMAhhW8kBvGy9kbtpuNiyzofZ2+ryjctjKF/NK5pVb1dYe6vp0ufF++DfOFtBmMZQB39CCbLz5y+T7M+cHtCQcWFnJKaP8onmvCZuld4m/h/EDKr2b7TBF4hFXtMOBUFAotUDrfw8q2KR01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:54:52 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:54:52 +0000
From: He Zhe <zhe.he@windriver.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
Date: Fri, 18 Oct 2024 21:54:28 +0800
Message-Id: <20241018135428.1422904-5-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018135428.1422904-1-zhe.he@windriver.com>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddeea754-1502-410e-e200-08dcef7c70b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z4WaasEko2hE/PNFt7LCG49V/FmaBKA61tA09PFKVRSw0A1Fqt7Zctwe00Gp?=
 =?us-ascii?Q?pShiH7AXbERr4jc8K1kjj2cBYkhrRi+YulApSo3+8lJvww4uc0rxu22ej3bg?=
 =?us-ascii?Q?A9MEYLbSdN4mLQJHNhQRFID1rwH+ruxKp4f+QmO211z8mlEMX6V3sd0TzPVQ?=
 =?us-ascii?Q?ZZcCABdFrYLvuptF0EKnyUWI4J7QLu94o1DrwLv/oIKQC9lvrcW1BHtQsKQ8?=
 =?us-ascii?Q?QB0gvBIEYwWnWgW2BlsPbbZsFS6nI+1SCSRADAlX87pVa05ObwFS2Bld6g70?=
 =?us-ascii?Q?Tlvm4wQ904xTF2R4A6LgclrtdbS06zhT+u70/7juEXhjaTWDksnFEKQryUZB?=
 =?us-ascii?Q?KpqTXXleGTaenQywmSVuYB8+ZpT0dCssnrn/R0sRDf9euBCy1pvpQ5haG1gu?=
 =?us-ascii?Q?EN99otyzz/kLnl2IwonJf83GSmVJpcYKoMQ6PEuJFZ85hiDjO214TlWaFau1?=
 =?us-ascii?Q?zlP7L72UkY6djXbamZlmjSMlkXl2gZ2RL9r4t2lsv8JHdlTZ4aE6dXwJJnUj?=
 =?us-ascii?Q?+Atov25NzSp5jYWo2LD5ZgTcue6FxeR1EZUqc36VgTm127PMrHxzCpCf4P1h?=
 =?us-ascii?Q?wW7BDdrj6O5xEOsiC7UwxKIann0vFxIrENecACyvuUFWFCh7UUZyKmpn+112?=
 =?us-ascii?Q?Y7qHG2qoCfIPHZmWPxJWgzOl8rYUhw+9iyJgjjfjhp+QmkZNVsDhR2l/ALGw?=
 =?us-ascii?Q?4s9I7L9S4v9xFPv4S0MP+PwkKwUJKy1sytX6309bX+4Qvx86scYg80arofyV?=
 =?us-ascii?Q?j3VHJTwkiOfhv2NN6cgMgdK2oI6OKYyjskuML2RSGyp++LLvcUtPJaLyrhn5?=
 =?us-ascii?Q?wDF4O1sr5PkEBLjEp5Pvb0tqsNUhJ9D9fVURFpiF2LbJnZOZ5dvY680nEzjq?=
 =?us-ascii?Q?FeaNjurWrHS77ByKrQQw4J18ZEf7NyWmp+3Rg5RO+loIlXH44rxlhObuf6it?=
 =?us-ascii?Q?7BWKiKa187HL1LFQVR4njlertBRX812rp9xco0lXxx7R/BlMwGZtuXDMedyp?=
 =?us-ascii?Q?1/3WLthb47pqMaiUK6pBx0U9fev5kdX8BR8J9d1dMJDUmbzxPaCHQn7nW8am?=
 =?us-ascii?Q?TRthAoI7Bn6JmsBfGbT19X4HIBl3ehyagAHG1kBJTyfl6EGzfmyB8tJq/AVV?=
 =?us-ascii?Q?ZuoRCxYldGzH1Z3QFeMpGUTN8OJ73dB2RYQ9RwxCgAYGpBMBaePlmLXl+F9m?=
 =?us-ascii?Q?Lm2RSf4x0Ak6rJA6HKe8WGVJEBQLVcdT7rwgbkyLfq7b3K16105enL1EsPFI?=
 =?us-ascii?Q?UyJizg7oVlFX25f6nF1dGrVSyxfJa6FjX0gZEzgSzFCzsHBtYWyPul/zhPIt?=
 =?us-ascii?Q?8QVfeEljnFYADbprYRBzS1YwrXEJuKk+YLgzWZedYMaRO1+99b4Z/EPMvDX5?=
 =?us-ascii?Q?IWQEa6MRrIfQ/LnTFf/QpSMv76S6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogXfOWdqlqlavpnypBHYPxHz/vvnre4WJbAUuQWa7S2G6QIOK5EEeGrtO0lN?=
 =?us-ascii?Q?KnKAih8grhlEvLdnJTDcQ0GZSNIlP9ngmXvWTacVUaHCvFwNJUhG5ga2eIbO?=
 =?us-ascii?Q?GSlRZ/tTVWdeEGxPRqlTRCQalixkREjnFA+4Jc3deVF9pHhp31hDoRmwZL9m?=
 =?us-ascii?Q?HXc/4oMPyH2EDoWkRMs5RtK1VNSkGCarCTvoBD98Bfh1JskMdc2WMJbO4bCy?=
 =?us-ascii?Q?ZLIT7VMzTuJJo6REW9LzzLM/2/yOl+dVLQkOzpvYaNr2OP768+mfmxXqDDLG?=
 =?us-ascii?Q?0t9CLnCbgHxb05uWgDFcMAh0aySZMs49smiMDp8kLtUoE+TC+TwcKiq0xKJB?=
 =?us-ascii?Q?50FuqTx2Vw81DCbzh4b8fmpcI3Pl4NVVcTetXzjkrk3FZrymGinhvApGwBBp?=
 =?us-ascii?Q?XZ/dKL17Ux3LPZJU8a8ZlYFe4MLWI3pr7HiuDzPqEBY5V6soOyE6No6qA7fl?=
 =?us-ascii?Q?ybqqPzD4xkePJm8CcEGyoLZ0GZn25Esp9jWddiziD0Hp7AIGNyNQzy8+VyR5?=
 =?us-ascii?Q?6RlDK6IwT+YDB17Q9yx4L3aKY/8o4DC8l58hytlPuKJkR8sd325SZtp3U1b9?=
 =?us-ascii?Q?epuGxrvaO2Nf7UFx4yD4LvAu5sFP5sAix9XxWEWHh25w7g7JQuuAJ6IB5QRL?=
 =?us-ascii?Q?aqaCbeh/qnQQpc2qVB/2DOhj61U0R8FVWx9YuZSsVW1AZOb5MhK75f5kc2nX?=
 =?us-ascii?Q?o3u8SU/DDQf8jf5+rBw3+JpjSNjr3qNL4E3RTzoeuZNBaxt8scu/aSXXzTz8?=
 =?us-ascii?Q?pxYwoynIsZH4bSvf77o0rdx88ZPx38WWnOlmuwh4Gkj/gqEj8gg81PKOgnLZ?=
 =?us-ascii?Q?Nq89pg0Qms6YNy2uUdgE8AgirVqChU+5b5chu9XkNEmEueSLq37gn4lMKMca?=
 =?us-ascii?Q?JpMfEDU7ntRmOJkjbJgoFYPXj0RYIqNqE0Qb7jr6xIfGTV20iPicH+RfzRSU?=
 =?us-ascii?Q?80OHOKc8x2L7q1PQa74BBn9aNlhgcfwtwD5FQV+dc1fogYhVPV4jCGPKV0Wx?=
 =?us-ascii?Q?M2baXzqx5AeVYEHprwrfHvQqjbeC3J6xaAUQxsNviysp+vRWNCFx/RRzPIiR?=
 =?us-ascii?Q?JID2BuPzBjmqnedwmDUu+D4qi7Y5FlLQlhRAZZk9rr/MpXXgf311YFPfNcN+?=
 =?us-ascii?Q?9/mISRDohRKk6Na7M1mw/rHW6d3XHi+X6w4Bs/GmHDTKyt+GlOuF0BssoOyY?=
 =?us-ascii?Q?wrA5Bi4A3ImvjMYLLPHE4tlwPLJoWuIZNHSKPPkmat1iOLi/N2M/uKe87KDA?=
 =?us-ascii?Q?FIRPxGECRQLhtALzHXOGJB6ovYuOC62V8BnS1oy5DxymgHn235PDJPQ9qu0k?=
 =?us-ascii?Q?F9ofXAuZ2iU/W+PfvP5JaX0/RqurNHEqUyWK94ecZ071chBRzLnSRhoKIngd?=
 =?us-ascii?Q?NumOmpZZ7giNBNhyBo8Ri5JNZMl13GDfdAW8SwAfZrQht9XDF8lItSLWGj7O?=
 =?us-ascii?Q?aQL0lfmAySV2vMZ93IUmgg/+Y0Igu4XGP8Y6qQS5yozOBnWy2dD4VTK446ui?=
 =?us-ascii?Q?Ud9BcQUMoAQzprbyY1KuMGK2yHQ9FRkrrvsm7yUm02QWINnFo5E4+nfuUAI7?=
 =?us-ascii?Q?iaMfT6xpQQ5sIjCoQTyQnm60cP0VyDbbkTlnTwPO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeea754-1502-410e-e200-08dcef7c70b3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:54:52.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMqfG73kxIE9w8QodDLllwWTw+xZwkdB3aZpbjRcXjdQ3mKZUCJh0kF13i7x1xzoej0B23+I2VcN0dY4altJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-Proofpoint-GUID: CffPRgL6XwXVqpxRJHwVrs5yV53P2jS5
X-Authority-Analysis: v=2.4 cv=EqyArjcA c=1 sm=1 tr=0 ts=671268ae cx=c_pps a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=e53pv_uEAAAA:8
 a=t7CeM3EgAAAA:8 a=EHIzWE65ROsh4Kq0_3oA:9 a=nlm17XC03S6CtCLSeiRr:22 a=i2WUat-zol0iyFTidwVo:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: CffPRgL6XwXVqpxRJHwVrs5yV53P2jS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410180088

From: Duoming Zhou <duoming@zju.edu.cn>

commit 573601521277119f2e2ba5f28ae6e87fc594f4d4 upstream.

When the cpu5wdt module is removing, the origin code uses del_timer() to
de-activate the timer. If the timer handler is running, del_timer() could
not stop it and will return directly. If the port region is released by
release_region() and then the timer handler cpu5wdt_trigger() calls outb()
to write into the region that is released, the use-after-free bug will
happen.

Change del_timer() to timer_shutdown_sync() in order that the timer handler
could be finished before the port region is released.

Fixes: e09d9c3e9f85 ("watchdog: cpu5wdt.c: add missing del_timer call")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240324140444.119584-1-duoming@zju.edu.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>

CVE: CVE-2024-38630

[Zhe: The function timer_shutdown_sync in the original fix is not
introduced to 5.10 yet. As stated in f571faf6e443b6011ccb585d57866177af1f643c
"timer_shutdown_sync() has the same functionality as timer_delete_sync()
plus the NULL-ification of the timer function." So timer_delete_sync is
enough for this case.]

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/watchdog/cpu5wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 9867a3a936df..91adfb55c972 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -252,7 +252,7 @@ static void cpu5wdt_exit(void)
 	if (cpu5wdt_device.queue) {
 		cpu5wdt_device.queue = 0;
 		wait_for_completion(&cpu5wdt_device.stop);
-		del_timer(&cpu5wdt_device.timer);
+		timer_delete_sync(&cpu5wdt_device.timer);
 	}
 
 	misc_deregister(&cpu5wdt_misc);
-- 
2.25.1


