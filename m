Return-Path: <stable+bounces-227756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD5DLwJ1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B182E4C72
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB5A8301C13E
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36C31E824;
	Sat, 21 Mar 2026 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nFu05dBa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2582749D5;
	Sat, 21 Mar 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089471; cv=fail; b=r0IXBRK6+lLOcn0elshBC3MRFB9o2Mg4MFFhG2FfynIkWIKhkW7loAoIYWZ18g9RKDG8ro/IMfpRtrXq6j3MlLR1wpViRV6jUhhEtXSTfqQ7C9cj45alFgNnVWtey0f+6rAlH4qrwqpfaibbO2kht0XXNRUUaOMYP9aR9/H/5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089471; c=relaxed/simple;
	bh=8RR6iqmtTDZIkaCdXr/qgraoXLsdXanhC74BB7q2FpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhdfnXEgvflASn/7eC2MdfdclCEXfHCDGnUEB57Gk7hdCUgj7G/txbWLNxw2BpWnIbXMQV/QjlX1OWVkt4O4eSIXoaxub4HGq6zGZy+SQo954epVGD6SvmMZebWJwHZ9QLb8tTPN/VSszBYQPZgwyv/uFhaS9UkNrF/EUzju+JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nFu05dBa; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uEuV3525421;
	Sat, 21 Mar 2026 03:37:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/d+G77HJmExE9vmJxnJGif8BAfujrN7TFtcqVIY/G+M=; b=
	nFu05dBapJS3NI9mcW9AIunLtt5wxWCGG0Xcg6FfwnccNvX41Jwi4EfVMdpmtGLD
	/hLBKDUM8+9CdopShlJ8uNoFFkVHzqDX3iDxQ6ogPN82me8oYOEnS0Wy4cRQyvp7
	QNoyfP7KYa5SbdFUks15ptE0tJLz/etyHpcywbbrHLa6Ldt7dU2BYL9+IFvibV+7
	7OJB6DD9NO7t7M+WUp5cVbQgz4zaSEtSZSmf5ybtsbqqgjAoURxT3HuvWS+KpSto
	PBnLXzVpVKuH6YTY2g3BIdyU8+9dNB0HnO7Sowxl3GeN869PoogJO6cJJfu2GCqE
	xR205MrLI3aoM31YgjddTQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky83bp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeiHjnoEbBigzW2wOfIJECad56+OAY6JgicB5dNDsAOzrA9/U76vSZLgi197Wf85j8XV5FbkJodkG9wS8fi4JfIcDl2qpSz+vorYdCuJKq5ZnFnKIqT1q7k+n89uDlct1+M7MDIqSz6RCg6YG8HWB5WEYEJLDM8fP0kc9fWyJ/z1z8PxA1SQWlPmjKn0y3ayaKIo4S/xYhYNmtlUVIo+BgXQlFj0M4PZMvkW5xi6PLjz+/UMG1DsF1OxBUu4N1keFZw+kYnveT3yZEMbH10YxDf1iOT47Kj39iwZU+7YaQi+nwYzr0EhmI9HyODLAAa8QTdfDWVbsw9q0hoYStuwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d+G77HJmExE9vmJxnJGif8BAfujrN7TFtcqVIY/G+M=;
 b=i9ym4KzzZxkynGKVyzrJKcOKkwqNvwDSh7zQBz/KiD4OGA2Kxu9j5liR0Kdi7CZ1wywHd3aWui5Okq1p3zkY1Wa2q48Z4XXLgxm5NaqvGi+kQuGySzbQ1ieMRdkDwoFTp688Rl+hG08M5KCPivdWNSuqWuw6hs+tDdZO0mje9v5XBi5ZrU9UlzU4RFwns4y0s/stzAWuT/9micIbeiDKvrlxHcKt5h5HzJb1usn4VPWWPCrpR2qPq6TKBgR9zRxA5SRJGAurCN8LkFFctQQQvxn2MyUIDtauKF/EMB0dXcWNnqeWNFUuaRdRJ7xvki06wAD4OGgDfeSC71w4Up5sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:41 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:41 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 2/6] cpuidle: menu: Use one loop for average and variance computations
Date: Sat, 21 Mar 2026 12:37:17 +0200
Message-ID: <20260321103721.35114-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321103721.35114-1-ionut.nechita@windriver.com>
References: <20260321103721.35114-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 465c99a8-fe84-4da7-14ad-08de8735e0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ql4Q9a2oe9DqkrMM1bDLZsecGBAY8e3ATs28ElpyQFGIB6112sdKa6DcdXHcHbbZ9pxPmuIoRmqK0OoYDuwVcE/IRuEZ4B0bQ9TmCImAx82Zx7FS9gxY7+3koJ8FFAbRSyTJwTmUwzxdXOOCDhIe0GOEmQxIrPbhAdN2/cZiSPV5NDcbZsn/oyvUN6UPeEs5MGS+ywazLRzHcJNunMYV4BHKQ/Ykdhhwk+Kp7DxxQayhy3IXEDh+et6LL0CMOKRCnWdeYiTF6TLyGVg4jIHqsXbyGfe9SNRv2oDSKWpuV/L18OuHSMb0jq5f//+tMQ4VcTahjLkV+jqX8ClntU8FbF6pq7zsiK3W5FrvIPMA6H7LKeKaESYSotYQgnalE5Wc3UNx1zdnlXLdoKZfBkOaIMn/unA4pjqaeCTpltlSyAEUdR+SkgCYfXfXQr4HsDhoeFjdMgbx6itxp8ZP/Uqv7s/VQUFBHXBP8jK/p07t5EtUfHFg0paQS+PUsGxryCw2IJI3MUh6/GcsVdB8SQnwWtxuXJnK2WrzrVR1Lx01Lf73Mtf+1SxVTqsRUlEEhmM2lDyKhEUAQc9dGMQLMNHwZGsaUAwV1iUtXqjjR3OTbRY7HkvWYgXaNYJbBKY199XpcuLMtvWLyDMMJK1kE602FNN2MUMeLKLsT6wzfkahbriP8MxGVDS624U0QMlo77Wk9jkjzRbogE7puNtSJrfBExui5EYoksOtUBnceNoXV49cM8pZmq3l5V2UN0demVf5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPYLU0Av4/BIBu3gObZvvHPClStl+O1n5l9fLcyC37wAB/KqhiVMAhaY+jRz?=
 =?us-ascii?Q?D8jmqep27aNgIaFc4Rjx7i2dsdqeuutauVduYRQMUdRfjgsAqOrO/b4S2aWO?=
 =?us-ascii?Q?1lF3fwBOhBrbBX3F+ghVFE7s806FAhT0hEdWIiz0sCGFcxsLDVD/PO13d/Xd?=
 =?us-ascii?Q?Qr7gi2sptjFnBLxOum/zAsl0LxdjMI2blPeQV2F6I6IwyjUxYAg37GuUjxWd?=
 =?us-ascii?Q?K/LWiOmdUalSD/pE+H4qu9DAqmJcHrflRRwT55W8Fa7dmFX21agQujQ6Th5s?=
 =?us-ascii?Q?FYMhbpyIVMAUR295ttuZnKNAFuhBxuypyZqZW2WdRSe51ZnLgiPdokXYvcUk?=
 =?us-ascii?Q?5Z+XLc/BLk0LptPlzKhGstV0yOskNqIDURno84XBfLT0Zyvylp7lzNVUB5wP?=
 =?us-ascii?Q?EXk8YLGpx//o3CfFkwQTz7/iDI9z9QdcqMP/P9HULHvoFkG7fawa3Ds/AnON?=
 =?us-ascii?Q?rtk+u/s8Chc1cjOWv+c7GnD0YTRVH3NPjujisGApAuVRqhUKoVcUwWlXp+BU?=
 =?us-ascii?Q?HvRNfbbJ7RgBamsaCWTThhRWCNAporLvmhjkZuv898dhfpw6G1UzgiLgcsY6?=
 =?us-ascii?Q?5TA3/6i2rbh+j/FBp2pBz0/vZDw7LwirPUAOkEHak9XXQDOP25kSWGSA8oQ/?=
 =?us-ascii?Q?g5ijZ+hFhojiOakh5F1lNZaCv+so+mlLhdO5/Ja/WPlRC3x0lhe2GWwN4t0P?=
 =?us-ascii?Q?7nmBHYSYts+uX0jqDHZL5aLTo7ZyRXIlqPndAcnRAut9x9u+zvogPmwpseWd?=
 =?us-ascii?Q?o1+Vsy1xnLmbaNtSNtpni7KcH0Enov3AyQFyvijEQk1N5zO15kOGp8v/1S7K?=
 =?us-ascii?Q?LgLZtZhRyEZT69Mgch6q51vmD0/cg/oP8jmt3ycfBvFNvdd7NUB6YmxbbhTK?=
 =?us-ascii?Q?INGzmpU5xv3vk9xQj87WbSSGg9MRjQZPsC9k3qTvew8ZuGOTv+0JdaMw6sxv?=
 =?us-ascii?Q?5MknGbMelrPxdTwJ4NxDcvXDXbWqzuK3o3mCoxJde6/QRNv68ohsr+eyaExq?=
 =?us-ascii?Q?SMlGFidDs64VrxjmKLWBjf5y6a1hiNWImMDW7W/96U4momdWwYeeCPE0CYrI?=
 =?us-ascii?Q?wPY74JRfhsfzB3+3orgMt0unEUy4mqGQiOpZst8ZyPNQDELBvYko8gbUz4MB?=
 =?us-ascii?Q?LEUzYL6L87q8cjwJZVXMLKamhtm4H5jcs1BGfcKG00GKAts6qxwBrSrTKP0S?=
 =?us-ascii?Q?+jyTipJlxIOkXfAaDvCsMzZt8wXDf93yPRNIOH/3U0rk9jnAGuK2O1dZ5BFl?=
 =?us-ascii?Q?n9z0W67DyA9DTqSE3OeBiYIMGOYy+oQ/WcwgZlSYXtg6z6z9/kvOBnI//nmN?=
 =?us-ascii?Q?khMDsQzwVirpERIS6qSqR6od9uyjygcMhgW1ZV7ltgqOsa0uFjJ0sCI5Btkv?=
 =?us-ascii?Q?w8q/ug9SR+H4yLEv35W062mKBtKCSzY1I9gsB4Fd2MQrOq1wk5CU0LmYAh4k?=
 =?us-ascii?Q?NPkustG+L2WvpWmFe1Tmsg3I+rk+SAMLm4O2I1yONYxtqFVfbZcJ7l3skoIy?=
 =?us-ascii?Q?1/F8V6xM11gEgK2XViSXTZT7/qp9JOIro0NXURRKCgT/yhoqOCEZFMhL30wc?=
 =?us-ascii?Q?ZZNCfq4/Swir+wWKRqyrOHLpw8KEZ9ZRSKoJdQ8kOFdNvu4ps85fBmTpidtN?=
 =?us-ascii?Q?qcUSewndzTMQA3B+ChqMR5AAcdoyVgtlZq6B3sLwsmDSbJXETNyAsj/87lzV?=
 =?us-ascii?Q?TtIK5eZoILFHOmAHKATwv2Ev8R+bgAcFA8Y8BN1vAvRBHRNAR0v/npx8I5zr?=
 =?us-ascii?Q?QlZHugedFKexHxZgabExO0/4JYnqKZw=3D?=
X-Exchange-RoutingPolicyChecked:
	ajckI6Riqym+3RCbCeW2vAICCo0SD1FO0fs9uR9jAHd3JqOBVFH6TQPpehUVNiGdIeg+9JpTvtjnFJWJzvF13J5T6GndXTyTrfw8gmP8ZUTBCJC68HS/1p/BMPu25AsDCpMaKeJUracBjYXMLKRSV/H+jTtair5ZTlbGaBycri6feWIRNMO3qWzdLNRKzwjGjPL0j1Wz5X1bAT4sPHN/HPQnfuCBBbX+FhQdmZUkhjRpN+d41H6QnTX4cqQxzFVbackICzrxU34DQLxPeg/AmBDnkzdu7ydkV9WW1JcszGU7GkUkSQV+XoNrvzoiqzmGUZ6auZ9SHWFpU4uNvaH3Vg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465c99a8-fe84-4da7-14ad-08de8735e0bf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:41.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0kijP0CUMCWLpleO56cNmjuBtsNsiH0RLkP7aU2AgOhD/BW9lHg+DPwbb3sT9mOQoavDOehgpI+FV2uBuJr2Iucn3MLFW22e6SWLT6mMtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX829gbwmd+/jF
 LNzQHvmP4SS6HAgfSWsgMOeh6WzTAfTlC5c6u9ThnLGE+X3GVZCxv+rh3XWzfTPRunvtXZ4KBL+
 zU3p6/PshWLYR0/tdNxxKm00VvSv3oIighxiSDq1ru0D++ACZl0b0iRC9rPd2t+tYoqpRsR8CPZ
 sbtLlLuDZqaBNHPLbSp8ubkyjYRZpDsjxWNSV1NNnnNgnrIaLk5spg2jW9YwfOQ4VjrLKGJyie5
 zs2BihyfH3wU0bYfBbVv2ljUitCCfKzMJ55t3hu+JBOdjqu2qEGr7/nALJofKawnUvjxl8yLxYy
 ih4HDNMWfrEB4n1WhqTIkBfG8VNzp1/+CPVgnGyotYZNWxKiS8QtFuoOZcBo86UVGgM7ldc/iYh
 SuQfm4NZOQH+3UvgaS+zZXn5BL8Csm8RX98Fdct+2y/9pakPWwaHMdZ0EwEuYTiYQtMbafchrf7
 0eYl/ckgwRB2uQTMotA==
X-Proofpoint-ORIG-GUID: 3oFiduLpC4VwIfNpm0GAGGOMyzySakuc
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be74f7 cx=c_pps
 a=TQumU+mCWarTt0EIZfG+ng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=MB4APrNTnA-WWpN6w3oA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=XN2wCei03jY4uMu7D0Wg:22 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 3oFiduLpC4VwIfNpm0GAGGOMyzySakuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227756-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,intel.com:email,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44B182E4C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 13982929fb08ed4691256072856f50bf7b206b9b upstream.

Use the observation that one loop is sufficient to compute the average
of an array of values and their variance to eliminate one of the loops
from get_typical_interval().

While at it, make get_typical_interval() consistently use u64 as the
64-bit unsigned integer data type and rearrange some white space and the
declarations of local variables in it (to make them follow the reverse
X-mas tree pattern).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/3339073.aeNJFYEL58@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 61 +++++++++++++++-----------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index dd7e2a965878e..8943bb8f19190 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,49 +124,45 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	int i, divisor;
-	unsigned int max, thresh, avg;
-	uint64_t sum, variance;
-
-	thresh = INT_MAX; /* Discard outliers above this value */
+	unsigned int max, divisor, thresh = INT_MAX;
+	u64 avg, variance, avg_sq;
+	int i;
 
 again:
-
-	/* First calculate the average of past intervals */
+	/* Compute the average and variance of past intervals. */
 	max = 0;
-	sum = 0;
+	avg = 0;
+	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			sum += value;
-			divisor++;
-			if (value > max)
-				max = value;
-		}
+
+		/* Discard data points above the threshold. */
+		if (value > thresh)
+			continue;
+
+		divisor++;
+
+		avg += value;
+		variance += (u64)value * value;
+
+		if (value > max)
+			max = value;
 	}
 
 	if (!max)
 		return UINT_MAX;
 
-	if (divisor == INTERVALS)
-		avg = sum >> INTERVAL_SHIFT;
-	else
-		avg = div_u64(sum, divisor);
-
-	/* Then try to determine variance */
-	variance = 0;
-	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			int64_t diff = (int64_t)value - avg;
-			variance += diff * diff;
-		}
-	}
-	if (divisor == INTERVALS)
+	if (divisor == INTERVALS) {
+		avg >>= INTERVAL_SHIFT;
 		variance >>= INTERVAL_SHIFT;
-	else
+	} else {
+		do_div(avg, divisor);
 		do_div(variance, divisor);
+	}
+
+	avg_sq = avg * avg;
+	variance -= avg_sq;
 
 	/*
 	 * The typical interval is obtained when standard deviation is
@@ -181,10 +177,9 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 * Use this result only if there is no timer to wake us up sooner.
 	 */
 	if (likely(variance <= U64_MAX/36)) {
-		if ((((u64)avg*avg > variance*36) && (divisor * 4 >= INTERVALS * 3))
-							|| variance <= 400) {
+		if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
+		    variance <= 400)
 			return avg;
-		}
 	}
 
 	/*
-- 
2.53.0


