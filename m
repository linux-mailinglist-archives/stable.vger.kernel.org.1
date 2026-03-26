Return-Path: <stable+bounces-230435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM1vG6XwxGnv5AQAu9opvQ
	(envelope-from <stable+bounces-230435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:39:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED73317BF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EFE5303F080
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D063B8BB9;
	Thu, 26 Mar 2026 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="MpCqQKKm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D13B7779;
	Thu, 26 Mar 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514199; cv=fail; b=HtxxEJwtrObYqGXW7JQTia1A6gYLkjZ8unmQEYlLw/f4c7+fUqMSS02++Jgcy6HAYuK/WYqnCq3ksy6qWuRTNmG5U+wahiijEOehyCisWREShQ8U6O1AjIDOoaJFS7jV2FH7ca5xEee3tfagSSNlAWxsCTKFIAHoL6UwjK0qULc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514199; c=relaxed/simple;
	bh=Fi+eX1MtL88V8Z3JP0wYp70ZH2iLBCftVV3bMvouAZI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JDjyD/nOp7YPRn0V51yvKmzMUl/y21HkPhB6HqRFjtM5hcI69jsZN5TP9BKPeix/wTu2SQZ18yi0TM7yjABZ0tO/dpNx4BX62xHqIPIGqGv3qcn6dEMeB/jQk56IgF2SIF6mnEGG1O6n1APzqwxQd7Hvc4aP5MNgA1y5ytkjFW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=MpCqQKKm; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q78KW22227557;
	Thu, 26 Mar 2026 08:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Dnf/TLYWH
	mDJKp+MZOzQ411AFdnxBxNccl7xm+1Eh1Q=; b=MpCqQKKmGcLCB49/F7kxWM+to
	MzpqdXa4gLiQsHZagGE2/WTINyVnJr6bv2tsADLzaxxp7miRm/bahnEVjLyYWE0/
	6JXAbtBvBmFg73u3QSDtLtqMcIdrhigp3UUyq3+dOqI6UsTuGe1nCJmomPESOHA6
	MWn+IdgF9D9SWM7qJU5CwGggEIxaYSKsCLNBrv/V5HJROAy8fFgwlj14QtdQ6IxD
	64SLSWrNWOQmJF53jaZibaCYLFPz1StsOcFMeJlqHV6zAy0uSflRRC4DQyzEjiqF
	oKOOzkjQ51GmTcISaZ5gPFvUFKcoWBalt1eRZAZCUVMfUrsgMa/Azeh4dVEYQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj868js-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 08:35:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg+X8NtpNLJ2YuL9GlpiBUgfX5DXS6OkrcjzTc67IXxolRO9ZJMBazUCjLnAFF2DcSC4RmxVwljTqIG4rTGOLKwFBfP9X5swUmu7a8Yhn1Uv4VK/IKsNhkTEA6+BFI1v4+WmBlzsnmYfvi07QHxAUX2i8cpx2hwSVP3ekpxzQvzqYQ0JN+d+VTMYgvenVSMwG+97G6r1fdyXYOoo3sb7/r5aUn7qEkPHSUFzqhiEFE3q674qrxX3PTpgK1ZX8LR9VKVcGz+ll+ixk6wC/WY7WoFR1Ex1tLDc8kld8+9g3q/kDZMEVSa9duBkAAJ+l1wbUAjpEwm60Ezf36i4IJ8hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnf/TLYWHmDJKp+MZOzQ411AFdnxBxNccl7xm+1Eh1Q=;
 b=ZBNnhDsot9xdmP4Q3tBCr7pwkEjgJTsQRXx6wpRwAI6Ya31RR112cW5LUX/Cyp/xYc9ga8QmVxzUbVw8+u5klHacwqpm8nUW201AhY35f1LUwX1WXlGTzthybO+8Sm8W7Wf6C80ikZol4pFbqp+TQ95YRRKgIl5WrbmOs14YLPOjti03co5RrP/o+pN4IUiVFlegejkuuAp5XFwY2YEQhnY5CIu7DK9AViGqetQwgSnLEkOFn+lxv+f7bnHMniKK04eZ9C2l68gBPjnIC8W41IrTWwvXnxIkTYMcujJa0HVU08thfw4T+EVcMqdIYCVZnHBItRrU1JNGN7fi6V5cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 26 Mar
 2026 08:35:52 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 08:35:51 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v11 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Thu, 26 Mar 2026 10:35:32 +0200
Message-ID: <20260326083534.23602-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f59919-be30-47b6-5bb1-08de8b12affd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|52116014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ClNjloegLaOJ0zTQKzuUsR69Ue2sf7DCYGzZVF/c7LGjbV+NGhfcWORTiFedOrG0LywznnLg6oKrpdwaeNNo4fBRCllKPrWNQCyL2kgRQYVkcHFbUpVBYqegq3tAd9QrAmPUjJxxost4Q75GsMOUKci/3/2p+hNhMl0r9A2LHjbKv4MPKtS5G2FFKSVINcFTrmQXtsdT0f2nkTna4LhuyYEmzfxEyxcQC78Nsbt1Du0QUJlU+Jkuaxo4yS68nitNY63WuSsblIvbn5I0J0JaNk26Ru9KvwOh3Jtd21wRdYz+gbPfYDutAk7cBjMCgwu389yYFFRcJuJ40zPYXsavHh+wZFJoh8KJbiHsBBt/0ZvueyAw0eVPfCyGKZ/92dIbFPhOHDvAgTuOYQ83jNqHbBV08OnFZUc0GqpeSJW60gu0JhNZ6SV4r9xAY/PcIF9V9au8DtOBVYQTZgOHLXppsg2cylY0/nQ0M+vx/eDAod5vT+RE5Is4+7+88Y+3rZbo7xw32a26VRH7WRQendZ2WfX5tsLK64rzSqWic3lB50aSQeE4kyvyLFhioPBQw93RdzotAyRLDXs//KSYGjpR1afBUIjDuUk625CsASWrghM5jzr8vV8LNTHfmAjpV0yelPsbyecRE76gCXP7bNbAKGtj3HAfWpEzE2NMOviyzZXwJznbx4iY+/qKuCLumsjWfJ9jR+ny0ugo+jAC5b07zIrz3AEq6a6WT9u7yEMRYms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(52116014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQiXOfeTL3I/LwVmiPLWdbs3qllGWoE4bg5sAkQE3XdWxRewbSDsXC/PUzOL?=
 =?us-ascii?Q?skTcehy+T15LDZgay/4g3GxJZ13H+469d5YKADx8anEsrT3dap2B3PNES3TW?=
 =?us-ascii?Q?v90gBurT4S1Smtx4xJE/RPr/k121YwBMfjBvzkP6NMAhoZzrijoq8v1xfRUT?=
 =?us-ascii?Q?ZEAc6FLL16iw8IgDDpv8gvwGxLarEXnSG0aZi7TPFToUgIO+5ILm1EGBZpLH?=
 =?us-ascii?Q?L6daZKsKkQY7tYVqgODPXQzXCwVq/59HXA3aRxAEaf1DqHsqTq8QX70TOrqX?=
 =?us-ascii?Q?wUGqK8tv4L/SwG1/QkWtOrfHQGcIGW4QXs1BJwmuzy956TUPGLrcBR/Fe2O/?=
 =?us-ascii?Q?yAUOK8KnMFG9g2HWoaTsLpd3c7XSg9m8IhFO8YcRKQl/iTq2+daVHlQRgreC?=
 =?us-ascii?Q?EhB4UPW8IYUP5WQU5Cu54c/hVPsctb8yMxWdErCvm3SVLq2LQXbaF2Ub6A3V?=
 =?us-ascii?Q?14iQWHvAfROyo/iNwDNSkPaqrc+eklE02/c9rIaOJDhk4xAYdQK7VjVrtFT8?=
 =?us-ascii?Q?P40csFrIwh782Wdm/khFd6o7HG5JCGvLfNoZftWLYjO85nb363/Fg110UppT?=
 =?us-ascii?Q?MTek0iUYY3jUl4SmrDgF4vnLvb+HIiUydEIwD187cNir/90lT1B46gG6Q1FC?=
 =?us-ascii?Q?fN1stfP+XKNcF4t1/L4dxmwB8hjK3DRB1CNNXPVEuNvVlbT58P7dNAtgWQJ4?=
 =?us-ascii?Q?PLp3mIYl5kJkAXYBBw17gWFGKiavTRL6/0F+v2v/dVWrKoaj29sidvKFG9fJ?=
 =?us-ascii?Q?PJJSzYL3rLNcY/U2ItkMzNMJFTrA/FKZ2J80KZoOxga6erkpQQ3lbkDxtcTi?=
 =?us-ascii?Q?XtrRD4Sl+z7+MgmWQdjsdPowqy8KsW6VnkEkRgi3IZQa+sr5jVGkVaPAs54y?=
 =?us-ascii?Q?rOlJEm8CqVxizJmKOgLKT0Uy2PNlTvzE3wNdWtrGJ5G/1czxsrVHcOLQ3h0s?=
 =?us-ascii?Q?lRwDA/s0i8moo6jlZgbI7tnwlLUURcW/rBwUhfK0Vyvk9P6CJQbvejN7TlrT?=
 =?us-ascii?Q?pG44p15MXhXXWDXao59YUL+FibyUMnO/gJuEyGSyb1fpie2BCOR7ZTPtrPKR?=
 =?us-ascii?Q?tF3RpJ9kNZVOfeorZY6Ex3Qm0EXeGbLkXMOTbBYr8j6H1mlmmRsdpMxdfuIw?=
 =?us-ascii?Q?J7c2QuD8/OvJZ7Hg9J5XMdrXgy+Nhg2ndtWY0PkalNv1TssVHu0P4s2hW15d?=
 =?us-ascii?Q?Tpiml10T9f9KcxW4TFqOfRgx9L57c2qLHM9m7unN/C0fAwsxF6v6ixNGYqcw?=
 =?us-ascii?Q?yr/YVekMrrd1AKAT725ZMMfDgseFkwLaE9aBu8o53S2E8/1AvgROeCQeppJb?=
 =?us-ascii?Q?53SK+NwnR0GzDtOko4SepUQ4BByCNS2srxjrN7Q5UV62E1RKQlymbvl/6FgU?=
 =?us-ascii?Q?Hzof4B5IqlZZodueQS57JRkPjQbrjZ/UMihbHC/8By7Yoo/YNe6Pq370Mj2H?=
 =?us-ascii?Q?SapyrDeUdH7jQt1fdLxnUxYi1e/FWVPZdB8XE+hEGyI+DqrUFju3lh/BEkkm?=
 =?us-ascii?Q?rFLluSge6BLKHM4Mp02SI+LEkodvS8o8y/4HW6kBFSeYeVlaEeEzFw6F7ON4?=
 =?us-ascii?Q?zYAh9lgjob250n49dDcGtqwZPOWt53DeDJ2NK6L9cwymxHjQ538phDMDLq9m?=
 =?us-ascii?Q?cKdQ7jdDfJgaU0PcTx+4+33NpIiO7vU+WL/joNL1FNJsrBFjkAZ5+KehYC/c?=
 =?us-ascii?Q?kfi7idXESveMcbCFZqNVPUd97qHnL7OaiyH19ps9SyuyM/6IYLNQr0uZoOaU?=
 =?us-ascii?Q?dgbMtn2lp1rT5fKh65oZHOElioUxy8/T9CIgA9t9PrlHcmIeIuF5B43sarWd?=
X-MS-Exchange-AntiSpam-MessageData-1: wL+c2uxKrSa8gIGL/YxfyMs7fBhA1B+wSoQ=
X-Exchange-RoutingPolicyChecked:
	PphQp5pyxxcsXuvzRPx0T8xrRZFCOhXrQw8kv90e/GKhl6UDmiG27Grq6TPydU6D2XO7t9tR43MyhX+uggIpBYEH/0Le6Lo22uopazO8ZIwopdokY70pXtfOoYYEusv9g/MsKBP+j8SgHI+8Horco/CLmvMiEP4A1TJ/beKNtn5JTnuPUXDmxd0UyFf1lnfqatXshFuI2HUXItuiyxDiQBRDVvW6oWLBtnPSjWyNyPp60cAK8b1gQsutI/i+QKfPKq2w229sV7g1K7Sv+gcXY97v52BLzWnABM57FTwdDlN/Da96wTW/D/Y8C80RluHLpXzJsDUCWGliyCD/AOYYfA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f59919-be30-47b6-5bb1-08de8b12affd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:35:51.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBUD98UnoIkFA1ZwbmGxGWaDRc1I7AG6BLJh8W2VbNleUQoEQ8eMoHf7enYbdTNECKm2p5gPEucouaIM93dSkJzmcV6Vn+O6cWAcXiW663c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-Proofpoint-ORIG-GUID: nXNUIq25lVruRPJll1-Yx0OTs6_fQN_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2MSBTYWx0ZWRfXwhGF/+gY4B3P
 IsANd2EloWozoWko3wH/Rdt+QOGwZP70d/zb0J8V1fLuOIPBA5Hndg8xsIJQVTU1/51a6SjzavE
 VV9LNaBVK0xrmbpG1G3xbIO8tIdDKqDSczvC0NDtwRiwxWKjU+3UzDQwXVVZsxofcbcO4v6vYf1
 pvyxvbqBPxza/dWNc4QBBftif4n+i2Q/PI6x3Vxt1KUtC0om9/hEvd0y3m5xCqDPGl0i3s14ess
 5Kxqiic0RG3uPvu9GrR7gax7uIhseYd1ipqyjbZUAdeLvUEZkHRaH1eWE5CdkpCyjH1PEbvY3zF
 v1mE6HSOsx0GVGsKSPA6hTvy3tDe8g7Hx+UAkXl0ls3q2ZajGCU6Ozi8qXduoB/2IN9Kq028vyE
 DTLBf5G+gigaIzbcnQOal5jcqiINCvbhOVUBvyU4Dm2f5q/YHrEz36m2dIq/Ka1kXy9ujiyHlnD
 YDBxSQL248gF2bR96VA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c4efeb cx=c_pps
 a=Szpykk5hBk3mC7HHiWFpbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=0kW7uK-nrfiYIzTTHL0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nXNUIq25lVruRPJll1-Yx0OTs6_fQN_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260061
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230435-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 70ED73317BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn,

This is v11 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events.

Changes since v10 (Mar 18):
  - Patch 2/2: added kill_device() before device_release_driver() to
    prevent a new driver from binding between unbind and removal,
    closing the TOCTOU race window identified by Benjamin Block
  - Patch 1/2 unchanged from v10

Changes since v9 (Mar 10):
  - NEW patch 2/2: fix AB-BA deadlock in remove_store() by calling
    device_release_driver() before pci_stop_and_remove_bus_device_locked(),
    as suggested by Benjamin Block (addresses Guenter Roeck's report)
  - Patch 1/2 unchanged from v9

Changes since v8 (Mar 9):
  - Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
  - Added Fixes tags for the three related commits
  - Removed rescan/remove locking from sriov_numvfs_store() since
    locking is now handled in sriov_add_vfs() and sriov_del_vfs()
  - Rebased on linux-next (20260309)

The AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Patch 2/2 fixes this by:
  1. Marking the device as dead via kill_device() so no new driver
     can bind (prevents TOCTOU race between unbind and removal)
  2. Calling device_release_driver() before
     pci_stop_and_remove_bus_device_locked(), so both paths take
     locks in the same order: device_lock first, then
     pci_rescan_remove_lock

Note: the concurrent unbind_store + hotplug-event case (where the
hotplug handler takes pci_rescan_remove_lock before device_lock)
remains a known limitation.  This is a pre-existing issue that
Benjamin Block is addressing separately in:
  https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

This race has been independently observed by multiple organizations:
  - IBM (s390 platform-generated hot-unplug events racing with
    sriov_del_vfs during PF driver unload)
  - NVIDIA (tested by Dragos Tatulea in earlier versions)
  - Intel (xe driver hitting lockdep warnings and deadlocks when
    calling pci_disable_sriov from .remove)
  - Wind River (original reporter and patch author)

Test environment:
  - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
  - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
    versions)

Based on linux-next (next-20260325).

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]
Link: https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/ [v10]

Ionut Nechita (Wind River) (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
    in remove_store

 drivers/pci/iov.c       |  9 +++++----
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 drivers/pci/probe.c     | 11 +++++++++--
 3 files changed, 43 insertions(+), 7 deletions(-)

--
2.53.0


