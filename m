Return-Path: <stable+bounces-127481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B687A79C48
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B2B16D352
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E119F471;
	Thu,  3 Apr 2025 06:48:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478818D65F
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662888; cv=fail; b=uJWhr6wMD8RHD+KetgbMEPYMdhLNMnwsoFxwh/Bnd1pPoWiNkk3ej6DSC6lNooP8GXfn2VLZjwhDB7OhcWmZX8wq1mfF5i4bKtaZHGiU8dOfmCbtY6Jcnupzv9mGgaFv5qUJe4jBKTu8P2yL4JExad+Ge+/xLLW6hbAJDcb8GaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662888; c=relaxed/simple;
	bh=xfR3gYfh6tXG4TZMj0GW2l8/beAQHnckSo6oxyKeyeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHZFHli19vNHyPajrG9d+LKzxEigiZDVu5JdIoyisEtH6Eluwou/kv/9EfqPZx9zGQFj/aif37fy7Q2ov1gagdvhcIqEzFoJTMxEgl6CPxsghPYiWF0PH4MGZXzYsMVXtmUwCtJkpn2X0HsJ4lhYvFx7sTJvksHo74R7Hs79L3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5335UIrc026443;
	Thu, 3 Apr 2025 06:47:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg2dgayx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 06:47:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Smvk8sP/MwckxMjp2Cd9AGQKZOrTCTnxR48nUJmeSbvo20IvBsgnLyCfQTrpjf7VvM2hJnPL7KodYAaqHH2XcdZZxxVi8Xj2pWPJOk9D4FIGFRPrPHfBuyox5E/taeJDbSWfgx5Oj5nNLmXvh+XzkMNWzWM0iJ+Nron2ljWtzQ++YDoWRMsNmLefAnT+k16riZgQkqrjQYVTnMbuups6qzLpNwYms9gTrP5VzfbzaKwds219ZTHQJ1ieJ6Smicg9emrSu8EkWvxE13eTmVlFVd43tj19CjvUqm3t/Nz5ABVfZ24jta9TYa1e3+/4pjU6FFLp6aV2P2tA4U/ADLQsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgNKkAnoXtb7QK52HIm7btk7ZrQ9QmWlwD6z6dK8lOQ=;
 b=HoowEF7l0+kmwSL3N/eCUD86nWtmIxYuiXSBY90bSRr0sF8/AzK6UL35hZmrMOnFLlGpden51kjsWf9Mm06vtRInsrUPC+yj9kZNucxPU/pqzanlwbUUW6tlDuZpxFpxuDT1+TRVaobGmQt7o1HUVo50/muah82xxHF5LtD5mpNde/0NFuSy8BEg1QAtW5B3SBCAEL46hZDqPVG2FQ9MqOx2/mErna69sAATZV3XxHE8eHG3pgdYzozyKmP/6+Gf/GOZUTi6Yx1dx3MR535JLVYLmI4XJNsMVZ2gWDO2iq04V4JuvXR3LnMFw20wXcvGbKuQmm+ICgoBbrAbUaQ7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Thu, 3 Apr
 2025 06:47:55 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 06:47:55 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com,
        tom@talpey.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/2] smb: client: Fix use-after-free of network namespace.
Date: Thu,  3 Apr 2025 14:47:36 +0800
Message-ID: <20250403064736.3716535-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403064736.3716535-1-xiangyu.chen@eng.windriver.com>
References: <20250403064736.3716535-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ccd1f8-5cb2-4585-bde6-08dd727b7683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JF75tpDAu1uDVS4bVnpC7G9enVbIvJGQEb1zEzTCPsLCw/o8NGtSA9reASrA?=
 =?us-ascii?Q?niK/5Cau1D5xLvzCITtRhkfOqO5RWIctTP03YyjvynFPCWnwsGz1cQ/FWstp?=
 =?us-ascii?Q?fnWwwte+A7Yo/kqn0Rs2F/qQKnWZt21ipPeP2lbtq2sO0cnCSw+srU3K1TmL?=
 =?us-ascii?Q?U/lTcnib9oIyhS6eS53ngOYAsqcIl19ZGsBORUORTUS0GrPQtztrTyVuXZor?=
 =?us-ascii?Q?ebx4ryEDjv6ElBMpZh6NrE79kdpAYEMe+vd+eIcNZwnRFq7NLQHdpb8+v+sD?=
 =?us-ascii?Q?19ilOS4F7HRees+G4MXQCtzWTcpq+wza+gQElWQSnGp64hZcKK8s3u83tkJW?=
 =?us-ascii?Q?N38yRVKFyzFrgkS+Ogx1TAw6fFe/GNXZNTWw7PWyWZPOc/ULPWCrgdqNXCDl?=
 =?us-ascii?Q?HKZlAGzunZJ8VEOJNTM2NU1EYn2SqxZWO+MMTkSV0aMwPTkuWlf570sjELy1?=
 =?us-ascii?Q?3r04SuvuzAhxnrzkWXb0k6FHLOtQqzz1u6uiAtxcztFb210WCCwK2F5/VOtl?=
 =?us-ascii?Q?8VHsGaExyAeEwuQDqwGY0+BQIJ2fJJ5fUh242rRM8+n2EfCjQty2s0zSnn/4?=
 =?us-ascii?Q?L+h/Z8Ep+3y4/l0HZ/bU5vZqjlTWxR/YAqsuW15B/+xImxoMTBh+BH6kBs0u?=
 =?us-ascii?Q?s2Vff4LlMwO51a+cwz3C0oiMVtAfdEHooob5PM60M8RFLEaHODQF7bXQHf3I?=
 =?us-ascii?Q?b7eNTlZIbufoBj4Bd4/azwgvZksnj3OEPD+eJjeO4cNDZMvSkaXQpqb5HV4X?=
 =?us-ascii?Q?66XzyfmxlgPONaeT4b6/4u8nWJJH9g1nMomvwZYr1gQ9J0FHMyi55/HpL3aY?=
 =?us-ascii?Q?EfYVjEFAheVlde962LznXJQLKhkncAR6FZT4IJB/bpBn41a57Y88J7OIvsh7?=
 =?us-ascii?Q?DK7mo/9vf1+AjS1PacY0jmcTMz1mzsm9+GMcNxJNS/75mdsIWRZOEbuB9aTi?=
 =?us-ascii?Q?IqJUpf0RaHLfwhB5unT5Rbj1wzPb+nnWrn2vjUbUJnhlj7/R/QSdmhYQTmiW?=
 =?us-ascii?Q?w3VaqhDUtmFZo05wdjgcma0pua+xV/Nkfjyw4ITW1vSTfPhSo1z0gOuRKfIa?=
 =?us-ascii?Q?D1e+dV/vK0bvfSEE3DTKuCM4CPKAssaNrMvtrZbc9XNCxyiEL2yYHsEKKtLO?=
 =?us-ascii?Q?gxFxqRvLJX3CP1a/7j2c/X89PZc5b9+c8YYW7Rd/8ZSo9DSB3qz9H3lRrOCw?=
 =?us-ascii?Q?F8WKjvZNEFUBkxjevG67/RZLxaX1RiwDCunoUnZOSzan5CUP/EBU0FVcU6P6?=
 =?us-ascii?Q?ntVEvAU42GhoUnX8MvOgTCYy4YZ7XKz8C1qLmTLE1PzLnJWUMGIK2biIPsgl?=
 =?us-ascii?Q?EHWC/hs3dlBynyCp1KJOejnimtwC+LgoH2TS8fvZKFHlyFOoNXjqxaJQAShm?=
 =?us-ascii?Q?DdPeHtMIlGrfZkeALw+aw43KGutIJvIfqHVc2msWHtuGm+e1aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZLU14Wt36H3luIKDXZMtsw8LpEE5z1JcNOIiGVVVcfOkTN8xcrcQYzBdcdV?=
 =?us-ascii?Q?2w6Y9rv9GJxm6VQ46gZQUXeSpsKg9PG5PmXWft+yc4OccsuTzsKcYdIPoETV?=
 =?us-ascii?Q?tHRunBCdbZSON5JZbMXtyCBecrO7zoxcEuPzB5OlLNum6Cq9WHElQAINIZpK?=
 =?us-ascii?Q?HTGY0eT7Vbd7uXBQoTss9sGtxa2EGUxWnTSnaJeZNDXYnhmIO/Fathe7MJEl?=
 =?us-ascii?Q?bun7QWmnAaHTG2OrjFUDaVNRzb8kdh7OtuXCM9z1/D52MJCrwxFbDyFyLbfe?=
 =?us-ascii?Q?JQ3gOsE+CMVda12HcD/B5gzbk5wsFCTZMvS02z9+c0YYRqzDIu3sFNYX3k3/?=
 =?us-ascii?Q?8BipJb5MEXr1z43IKHDtFf4MCelKxBNr1JfYkXvVy9CQLE/qbBXR5T9AzV4u?=
 =?us-ascii?Q?5m553+E2EJlC8beaFKPlFDD/ZXNTXIKPdpYU7G2n/5R2krlYhslE3ZVzwmrd?=
 =?us-ascii?Q?zgg0Dusm8FusORQ+MrF1phc23a23MP63H4qIdEf8Xey+j/EeWBytl1IWmA/3?=
 =?us-ascii?Q?Kyi3nvfEvOKSwKwgot74E3Ly7HogcTphPi/+kg9QAevMnDSJ1H7xK11/uuKF?=
 =?us-ascii?Q?hQGmpGD+I/c0j53v8vCBBqB5Nof73aYpt14k8Cr632cUQsFMJgYjxZgHPlD8?=
 =?us-ascii?Q?JD6YMpgchkaGmQjyS1o+uQDCZX68k2GWocF3B8rzpckRV4IPu9/gFW/nr7vt?=
 =?us-ascii?Q?MswsDLF8JevQXjSTMI4416GW5WNEreBRTC2upPDLMG5swzq4GJWm2YQ5IjKp?=
 =?us-ascii?Q?lfjPOkw5v6lZmBH0lxFc8m3YxtqlpJIYvOD2v4iawB6suPscL6/wOHf1SHEy?=
 =?us-ascii?Q?YvHHB1TKM8xGM0QAr4riU87CSDtkF4u50lkhJIyTKIwCTYny48ABLn1twzc5?=
 =?us-ascii?Q?gn97Iw4kKrZsO8X8DxKqAIn0V4EcR5BAG2vav0qu1Fu4ehvNvX34sxakNwUf?=
 =?us-ascii?Q?P+ikZ878gMKBey9l7imNfEUDAky7WJuyMlaU32k5GGJkdLxss/PPfIrkkpeD?=
 =?us-ascii?Q?II5HSv1iEcMWdPQa7jLfS3Tso0YJDhZt7LyMJpIRhSw9UOYo/urp+ZBnUGF/?=
 =?us-ascii?Q?zZg4srJJQJmNKoJ6odOPQdBRZnDNlSZCmrBtOGziKiKvBhkLtcPvsBpDt0sL?=
 =?us-ascii?Q?7xHsO8St3j7K30ww+pdy1DMFivEd6wMcd2QlpQ8d2fEpe8VG6Ese9cVLvLGK?=
 =?us-ascii?Q?bn/UJPYkzUypseYzeaar2RMH5bv9sZM5B7RShihZAAD/JgWHX6gxzvWrC3PJ?=
 =?us-ascii?Q?tWc7ZHfTVOKeVyF2/Vl3ikmSG+8Q+RysjopjCaewUNnxRNZGyvZv5mjBDHLw?=
 =?us-ascii?Q?Jj1OfqerOsEYnDcAF7cZ23obtFPBCtpjUMhWYOH0dIJjD9X4x0iATRTI7dw3?=
 =?us-ascii?Q?7eeHakTZdqflh0/n03v6Kti87uuY6r0tRzUAM3W+0JHb5O31iWSObyR34e3U?=
 =?us-ascii?Q?NTMNbT9f+pbH57lOAlpVMCIzV3vRymd0NpMNYju68oDXy785/+ftH/IvOqNJ?=
 =?us-ascii?Q?s0YABmT142g94yWluBzUmjYwPHL4iNXh2cUcoVc7r0/FI6WQclSf+e6jfqVd?=
 =?us-ascii?Q?l+aNqtgtK7eDQeS/tCYeMh8G/RMtfCrk2Xu7KGS1r6OpguubfRpeXMET//cC?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ccd1f8-5cb2-4585-bde6-08dd727b7683
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 06:47:55.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeWxDDujrjkMogkd7tT4y1EdkMYrvl9c1KvfTZYp1oboT7VQWu2NrGbLzUG5shuy3QoTB9nwUVttCLWGpyCfO36BLinK2ZN3XmOjCoiPAdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-Proofpoint-ORIG-GUID: y6_sYm28W53ksZiSwi4zJE1fanP96U8K
X-Proofpoint-GUID: y6_sYm28W53ksZiSwi4zJE1fanP96U8K
X-Authority-Analysis: v=2.4 cv=LPFmQIW9 c=1 sm=1 tr=0 ts=67ee2f1d cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=NEAV23lmAAAA:8 a=vggBfdFIAAAA:8 a=A1X0JdhQAAAA:8 a=SEc3moZ4AAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=6s1ZfWTU7Ws2phOeXU0A:9 a=5oRCH6oROnRZc2VpWJZ3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030033

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit ef7134c7fc48e1441b398e55a862232868a6f0a7 upstream.

Recently, we got a customer report that CIFS triggers oops while
reconnecting to a server.  [0]

The workload runs on Kubernetes, and some pods mount CIFS servers
in non-root network namespaces.  The problem rarely happened, but
it was always while the pod was dying.

The root cause is wrong reference counting for network namespace.

CIFS uses kernel sockets, which do not hold refcnt of the netns that
the socket belongs to.  That means CIFS must ensure the socket is
always freed before its netns; otherwise, use-after-free happens.

The repro steps are roughly:

  1. mount CIFS in a non-root netns
  2. drop packets from the netns
  3. destroy the netns
  4. unmount CIFS

We can reproduce the issue quickly with the script [1] below and see
the splat [2] if CONFIG_NET_NS_REFCNT_TRACKER is enabled.

When the socket is TCP, it is hard to guarantee the netns lifetime
without holding refcnt due to async timers.

Let's hold netns refcnt for each socket as done for SMC in commit
9744d2bf1976 ("smc: Fix use-after-free in tcp_write_timer_handler().").

Note that we need to move put_net() from cifs_put_tcp_session() to
clean_demultiplex_info(); otherwise, __sock_create() still could touch a
freed netns while cifsd tries to reconnect from cifs_demultiplex_thread().

Also, maybe_get_net() cannot be put just before __sock_create() because
the code is not under RCU and there is a small chance that the same
address happened to be reallocated to another netns.

[0]:
CIFS: VFS: \\XXXXXXXXXXX has not responded in 15 seconds. Reconnecting...
CIFS: Serverclose failed 4 times, giving up
Unable to handle kernel paging request at virtual address 14de99e461f84a07
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[14de99e461f84a07] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: cls_bpf sch_ingress nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver tcp_diag inet_diag veth xt_state xt_connmark nf_conntrack_netlink xt_nat xt_statistic xt_MASQUERADE xt_mark xt_addrtype ipt_REJECT nf_reject_ipv4 nft_chain_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment nft_compat nf_tables nfnetlink overlay nls_ascii nls_cp437 sunrpc vfat fat aes_ce_blk aes_ce_cipher ghash_ce sm4_ce_cipher sm4 sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 sha1_ce ena button sch_fq_codel loop fuse configfs dmi_sysfs sha2_ce sha256_arm64 dm_mirror dm_region_hash dm_log dm_mod dax efivarfs
CPU: 5 PID: 2690970 Comm: cifsd Not tainted 6.1.103-109.184.amzn2023.aarch64 #1
Hardware name: Amazon EC2 r7g.4xlarge/, BIOS 1.0 11/1/2018
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fib_rules_lookup+0x44/0x238
lr : __fib_lookup+0x64/0xbc
sp : ffff8000265db790
x29: ffff8000265db790 x28: 0000000000000000 x27: 000000000000bd01
x26: 0000000000000000 x25: ffff000b4baf8000 x24: ffff00047b5e4580
x23: ffff8000265db7e0 x22: 0000000000000000 x21: ffff00047b5e4500
x20: ffff0010e3f694f8 x19: 14de99e461f849f7 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 3f92800abd010002
x11: 0000000000000001 x10: ffff0010e3f69420 x9 : ffff800008a6f294
x8 : 0000000000000000 x7 : 0000000000000006 x6 : 0000000000000000
x5 : 0000000000000001 x4 : ffff001924354280 x3 : ffff8000265db7e0
x2 : 0000000000000000 x1 : ffff0010e3f694f8 x0 : ffff00047b5e4500
Call trace:
 fib_rules_lookup+0x44/0x238
 __fib_lookup+0x64/0xbc
 ip_route_output_key_hash_rcu+0x2c4/0x398
 ip_route_output_key_hash+0x60/0x8c
 tcp_v4_connect+0x290/0x488
 __inet_stream_connect+0x108/0x3d0
 inet_stream_connect+0x50/0x78
 kernel_connect+0x6c/0xac
 generic_ip_connect+0x10c/0x6c8 [cifs]
 __reconnect_target_unlocked+0xa0/0x214 [cifs]
 reconnect_dfs_server+0x144/0x460 [cifs]
 cifs_reconnect+0x88/0x148 [cifs]
 cifs_readv_from_socket+0x230/0x430 [cifs]
 cifs_read_from_socket+0x74/0xa8 [cifs]
 cifs_demultiplex_thread+0xf8/0x704 [cifs]
 kthread+0xd0/0xd4
Code: aa0003f8 f8480f13 eb18027f 540006c0 (b9401264)

[1]:
CIFS_CRED="/root/cred.cifs"
CIFS_USER="Administrator"
CIFS_PASS="Password"
CIFS_IP="X.X.X.X"
CIFS_PATH="//${CIFS_IP}/Users/Administrator/Desktop/CIFS_TEST"
CIFS_MNT="/mnt/smb"
DEV="enp0s3"

cat <<EOF > ${CIFS_CRED}
username=${CIFS_USER}
password=${CIFS_PASS}
domain=EXAMPLE.COM
EOF

unshare -n bash -c "
mkdir -p ${CIFS_MNT}
ip netns attach root 1
ip link add eth0 type veth peer veth0 netns root
ip link set eth0 up
ip -n root link set veth0 up
ip addr add 192.168.0.2/24 dev eth0
ip -n root addr add 192.168.0.1/24 dev veth0
ip route add default via 192.168.0.1 dev eth0
ip netns exec root sysctl net.ipv4.ip_forward=1
ip netns exec root iptables -t nat -A POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
mount -t cifs ${CIFS_PATH} ${CIFS_MNT} -o vers=3.0,sec=ntlmssp,credentials=${CIFS_CRED},rsize=65536,wsize=65536,cache=none,echo_interval=1
touch ${CIFS_MNT}/a.txt
ip netns exec root iptables -t nat -D POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
"

umount ${CIFS_MNT}

[2]:
ref_tracker: net notrefcnt@000000004bbc008d has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:339 net/core/sock.c:2227)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1576)
     generic_ip_connect (fs/smb/client/connect.c:3075)
     cifs_get_tcp_session.part.0 (fs/smb/client/connect.c:3160 fs/smb/client/connect.c:1798)
     cifs_mount_get_session (fs/smb/client/trace.h:959 fs/smb/client/connect.c:3366)
     dfs_mount_share (fs/smb/client/dfs.c:63 fs/smb/client/dfs.c:285)
     cifs_mount (fs/smb/client/connect.c:3622)
     cifs_smb3_do_mount (fs/smb/client/cifsfs.c:949)
     smb3_get_tree (fs/smb/client/fs_context.c:784 fs/smb/client/fs_context.c:802 fs/smb/client/fs_context.c:794)
     vfs_get_tree (fs/super.c:1800)
     path_mount (fs/namespace.c:3508 fs/namespace.c:3834)
     __x64_sys_mount (fs/namespace.c:3848 fs/namespace.c:4057 fs/namespace.c:4034 fs/namespace.c:4034)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ cherry-pick from amazon-linux amazon-5.15.y/mainline ]
Link: https://github.com/amazonlinux/linux/commit/ee70e0a05686
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 fs/cifs/connect.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1cbfb74c5380..07731f95d211 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -839,6 +839,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
+	put_net(cifs_net_ns(server));
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	kfree(server->origin_fullpath);
 	kfree(server->leaf_fullpath);
@@ -1373,8 +1374,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	/* srv_count can never go negative */
 	WARN_ON(server->srv_count < 0);
 
-	put_net(cifs_net_ns(server));
-
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -2694,7 +2693,10 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	}
 
 	if (socket == NULL) {
-		rc = __sock_create(cifs_net_ns(server), sfamily, SOCK_STREAM,
+		struct net *net = cifs_net_ns(server);
+		struct sock *sk;
+
+		rc = __sock_create(net, sfamily, SOCK_STREAM,
 				   IPPROTO_TCP, &socket, 1);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
@@ -2702,6 +2704,11 @@ generic_ip_connect(struct TCP_Server_Info *server)
 			return rc;
 		}
 
+		sk = socket->sk;
+		sk->sk_net_refcnt = 1;
+		get_net(net);
+		sock_inuse_add(net, 1);
+
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		server->ssocket = socket;
-- 
2.43.0


