Return-Path: <stable+bounces-148135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD117AC87A5
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 06:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956D97A90C6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 04:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A71C860C;
	Fri, 30 May 2025 04:52:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070183FC2
	for <stable@vger.kernel.org>; Fri, 30 May 2025 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580728; cv=fail; b=fP/Vyb9LpZLfilOozH7ArMsB6K3nSzZ/XafYvwEKtLa6Q36FZ+9g6gbb2G5+PpJLIksa/1KG7waBepUKv56TrMqqMafgpLCHOdd10nARchqwFCt8/To8yH1NqIdaAjp9UPxnU99IOMnVIU3wChr+yBlaw3c9I43LyZcp4wPaRFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580728; c=relaxed/simple;
	bh=HgBytNRgP+FlkEsu/UQDg14dL52ZBgDwgoRz0dHR5SM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S+L+1HJWyHrZZgbqWbehrBDuVTxfUB2P/lh8Of4X2B858ZavGn0lJotdN/fUPoj/OZ+w+K0XKRMsQUw7MkyeyZN2gY8CFFak04/Y/apnG5SKijqb/V6i6ei9xUoX4A27hgmMCkp2v28iqDwIAXVQi59BQiyFoxUH3wgBsQCDhJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U2dr53007100;
	Fri, 30 May 2025 04:51:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u3b1668r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 04:51:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkPhxFsNN+qoyvzX1uiIPwi0lYg44g+0qYN1m8E7m0ILxzgVE++BaKu97TjZwnhtpyVBY/RD427hHF55USrj/+I8WOqQqZvhgaGL29bjRMQM41JDSUxwkeWZZJY4cqKfGqFnt3wi7XMMcuqxP1mj2OZd1hnQcBTXWZCY3HJ3GG8xjij9eoGX0widBJ7PW+4XCUBkMIerGLOH9xctsykRhSyexSIOopm9jWb+vxs/7ygZmhnEw1hdEfgjK5LbyHCgQBhmCu54X3GckTRGJhne026k/3UFYs9bY+eihNOCIoz2nzg384Ehn22XR73IUviF7pQtbQLPm9RmEECgPbWC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhGGWa4AzVU7WROzhPeNw0M5lVfksCV34M62q76QySo=;
 b=dsWR0yxB+5U1lgFxbKa2KSeiX/M8FpNPB11+sih/5/S6svsIKHZjWagxuqnPmWSierc0GowKMe15CWJpmZC8FgcmRTakUPRYrHJxEbAEdXTlZ+UNMxfC49EcRn3wGvbUKeUfRnH5Wq1NgNQYYK1QO4Z2FdCK4MwKDfYywFqI3So4DczA+sk5FvzApLOBrfVzqWyTS/hLuAknY6+OJAIsXnXAUmFk02FHT76OYxo9sg+CeOFRD/D9QHT1/37mBb6T3qyvfLTEpQ8RPBbFM7FQPb86+0fNDJRJfxJNfSN+yKsmAXwk8S+W9eTdd+aJ9FaTK0b00u05uPeT8QLojUpG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 04:51:52 +0000
Received: from MN6PR11MB8170.namprd11.prod.outlook.com
 ([fe80::a943:8506:56e1:43ce]) by MN6PR11MB8170.namprd11.prod.outlook.com
 ([fe80::a943:8506:56e1:43ce%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 04:51:52 +0000
From: Guangming Wang <guangming.wang@windriver.com>
To: guangming.wang@windriver.com
Cc: stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y v2] selftests/vm: fix split huge page tests
Date: Fri, 30 May 2025 12:51:40 +0800
Message-Id: <20250530045140.3838342-1-guangming.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0107.jpnprd01.prod.outlook.com
 (2603:1096:405:4::23) To MN6PR11MB8170.namprd11.prod.outlook.com
 (2603:10b6:208:47c::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8170:EE_|SA1PR11MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: d4825522-e062-4c92-419c-08dd9f35b1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EgXqdPCohjGsgCQxKvImS8jh+VrIvCcKUbwownYMEms/jrQ7TZDeqeV7Y0t9?=
 =?us-ascii?Q?eKUwm53z/ikQHS7lKlpEWVmndqDmA5CV/pzJ3UQS1fAAtJPrNKh+BMWE4HOw?=
 =?us-ascii?Q?RKYQT/P0sbvEHN0wmMJtPhJ1BFYpG7PGk7Sb1JfdU72u+2x8XgfLlRSu1xyY?=
 =?us-ascii?Q?NVAg2lpkJqnk0y6qADE+/O5MVai8YgResU0u7mxYm06Oaw1g5sLC2EQml8hz?=
 =?us-ascii?Q?PDRprzozH/EhjysmJKSNgxyf9VFgj/DAOIN/E5FJWqZ2RjBhsgYA3DuBEw6m?=
 =?us-ascii?Q?JEotgW0HGaLaE56yrf5/JSgkK8RUZpZl4cWbBPfphZAy62pYS8NwotZJgzK5?=
 =?us-ascii?Q?H+qwzfga/amJeGM0oUUmmiY/iZqOJZdYBykGZLDEjQBDll8EYvLhXP3qpFUI?=
 =?us-ascii?Q?tU03/pi7HGVY+OiymuJ/xXTbXzWQN+ORx81NK48yy6yAeHFFkSwFHQs3nHr8?=
 =?us-ascii?Q?qofrjuQYYEmWWDeeALrJ7Q5kl7bN0FY8+84MwGuWkllKdwuTJvG2LpmsZulx?=
 =?us-ascii?Q?RYHROgL6VLO2z0x2pi7Pf5tscSQfREcleSA7s8f3y82M2TxvrboIi/ETPUHI?=
 =?us-ascii?Q?QVLZGVs01Zbjxrou4uMHjIiDvmMYUlV+/2V+eax2fVmx1LNBUpFC0V5pFTnU?=
 =?us-ascii?Q?sqwdsSrjoYGHQ8FNFpELjr3RNVNjpDWu8MAkjXchceaYz27+m7swfviUhRgO?=
 =?us-ascii?Q?6AdsLKK4DUFi3/R+nKv39OoI1PSx0uqhM8Tkjtkd3+PRGV2WaTlKlvOvqTY6?=
 =?us-ascii?Q?ukHaefVCt3Qkjkb3v5gwgvaxq9QmnfjPzdh+1Rd6M7fMt7AYMVEo6CCArty4?=
 =?us-ascii?Q?ryKmyjPdhNkd274nrVdrCo85sn7HIjK7c37Kn8kCNteS4g6thf43meqidXGR?=
 =?us-ascii?Q?v2wInw95VIEas4oaRp3le3Pjh2KzQb5+Qrn/SWF/hNKEq+/xt8sTD+v6lovi?=
 =?us-ascii?Q?3WqMwLDuFzTx6R+HTlwDStGXyi9J2sF97Ek09LSNbUvO5TRqHk+lv16hh4wd?=
 =?us-ascii?Q?AdGY+4LjP8cQaiE/+GKvSI1PIJcKkjBIoqQW+yRNSyWPleU7KKP2gmkH5rau?=
 =?us-ascii?Q?KQNOnHarLsx0swTLiRB+o2uqjGAVnUm0AbWN3NTP23cLnFT85cIjBLbGONeh?=
 =?us-ascii?Q?3yvfi1qprsPIDIOMrR0OJF1ovZ9tX6CrygNhvsOfw0SM7Cxi24fJdnp6UyUJ?=
 =?us-ascii?Q?cpShNAN/VotJch4dIyDLwnR7xeCtZTtuPb14lRG+Gv2/h8kUcVq7aq0lq9hy?=
 =?us-ascii?Q?ZkV+hErjt+lO3vWfdWzZKFyaOnGNIP/KGvd9FXRhO7TZLJsnjmYf6FQJSo+/?=
 =?us-ascii?Q?dUKamsqxuGguAZPICm6JQ3o3mj+5suf+9PHStreOzBTa/RxNM3jfM/QfUYHF?=
 =?us-ascii?Q?ie/8caxFZvtRyHdbEnlMZElMXJzRhqeHsytBD8N74AzQfuMEqQAdP6mqDSrl?=
 =?us-ascii?Q?kDTnYIoI9B4NppbQcYx0IgMD3JdPIT1nM2HoX87pZxX7mnEPrrvq+YDXndDG?=
 =?us-ascii?Q?Mguo7yQK6sT7BRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8170.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1rKhZESkeFsWNq21GgP19qINFeu/oAfQR4O6hYSpsfUhGvrTHWVh8dps4GVq?=
 =?us-ascii?Q?4EOVZUVdyZvuXsf6UCckE7P2f7OIfTL9nrDRnhUY/c1eqhcWX2raevo6nDXV?=
 =?us-ascii?Q?u5L9uCwYA+EseGjzugGQzy+jxOzDsLZPPkMUCmtUYU481T7jNx4OgwXOxReE?=
 =?us-ascii?Q?nUGk92CaUsmmTp/yy86zbYQNGcw5mkoVErMMDDohUBIsnIstHT9hyRTpFQ5K?=
 =?us-ascii?Q?XJSqXWGzyknyiPGewIPSMQtBiAOS3IsVjQ45APLrFOQgZN73BEP6lqqSqU2S?=
 =?us-ascii?Q?daxUm8d23cqKyNlPaPeXOTcrh9uikktULt3ROaMo7rZyu1Yu8P0/DxHYRw9O?=
 =?us-ascii?Q?sibl1pEtwzdSEQ62eql+bH+2LRQN1dkJLiZBpBzn1PfVN+7TN9OSgCRKj/R/?=
 =?us-ascii?Q?kt1dTb7XgISPobiPkl0ttI9FxW0kqRoDfybmVByg45uSJjjg20kkGkVr0njR?=
 =?us-ascii?Q?bpTJAp5GldGSjdu3U6hs23VAjeA+f7/pVV7r6rRMHo2Au89EbDomzQtRwLtY?=
 =?us-ascii?Q?zW6pquSdQzgGmmcfbb58jDE0PcG8UKLQff+kzatpwiAnpXz7JV1gRA+9F9aV?=
 =?us-ascii?Q?xFuOQGN0SkCz1kIve5z6VbEVzjCHzIANUjwp7dbvh4OF/WRO26tjE38Fr6DE?=
 =?us-ascii?Q?ay0xr016NfJiVSsbQbFXDQfyb+0n8+5A3r/oMQmSQJuKYHxcd4Dlj8u9r9Dx?=
 =?us-ascii?Q?tJUPvLF61vkUjSaLxzLE73JgwqrGI8ompdv9x59cN4rT9akZkGCntW4s19k7?=
 =?us-ascii?Q?Oy94Hkqr+OUifkaXs0v4mnXabFzYpn0EedoD5r7FK6bWTyIc/XgT3FGxb7YI?=
 =?us-ascii?Q?wjDm3ft45RAc0ps5vQe6K7zqe7xBvhfpx8/wgIGIVEFzTMdq6zoOlP1BQ9Tz?=
 =?us-ascii?Q?XudftreBrFJp9RvW5x5VWE+Q01OqU/E1lVmyts9h1mwVvspqpptVJvNgwKsx?=
 =?us-ascii?Q?om9u/b1flW7xVkXdrhhMDkVrsyegmqEKp2UvueiklTDISe97YPrUcECArERN?=
 =?us-ascii?Q?DhKveD2RGMhgkoEi3gBoafAb9/6G1sjeS+xGJN2hU7x7OpJY6XJeilmK2WVx?=
 =?us-ascii?Q?pUVsF7HfRWfwmkqfiTqMU8TYOhoLepKBiUeNtx1zcCwqEmpuZpzUoparqn2e?=
 =?us-ascii?Q?6APWvLLHr2yzcSfj7bs4ry4bwprneyXEUx9mxmIahybt3AoFxGeXPFCfirCf?=
 =?us-ascii?Q?kLd/FywjgQ3Sa0ZnEmMXKdUv7usTkzMgA3kuiv7pgLkW6hv3QFIpdeNdN2+Y?=
 =?us-ascii?Q?KQTx/R8v9DiNjY1JnQG8CGsvUiVEVABoqyMKqbQWVNKDefFsiNQDsWIYIHxl?=
 =?us-ascii?Q?hsQTfTEZjqY+rKrMvY3RxVS15ZCI2vDcClQ/MkQ+S9FN6KPgDacQ3XWcmh0S?=
 =?us-ascii?Q?ZZw0LlYc2BUtbHPyrJlvyTi+hOWH979iPTLvzr649iwvIJePry/QiuI9S+o9?=
 =?us-ascii?Q?v0ddXu3yf0T4WmX6TP+ThfNTNMdKIQ/fLBGfgD8of+Tvm3kK4WzDB9b8b0T+?=
 =?us-ascii?Q?yvkhpxbaP0dM9o+sdsae42qbS0fO2MOSaaT9IYtCk6tQMFW2l1MNXYSNhKA6?=
 =?us-ascii?Q?CuYaGenI5Wkt/pE+ZsjznaHLb5cEPOs+wBeLyet9HdxceRq0sDnxDu3ftihM?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4825522-e062-4c92-419c-08dd9f35b1b7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 04:51:52.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESzskmNjTZ2AVjGFPjl5xklrKcNGz00p7OrGm9isqo/9rXjE2baeSCGKF5jHC4dDqRCeLiv7lzqRZG6acNx6ZGCMqIfYHM69E6hqQGrE74A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-Proofpoint-ORIG-GUID: LcvkXBBAO2veT0xgvXUN9HGQfe-Hmp2q
X-Authority-Analysis: v=2.4 cv=VpYjA/2n c=1 sm=1 tr=0 ts=6839396c cx=c_pps a=/jMH4tigRTm8KUq8TyAgLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=UD7uQ7OiAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=VVKcLzq8wE9gult8eqUA:9 a=Zkq0o-JBKtHmMz2AGXNj:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: LcvkXBBAO2veT0xgvXUN9HGQfe-Hmp2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAzOSBTYWx0ZWRfX6ihRrp+ti9e8 BNZvXcwaXCas+ovfXLrU59KPo0kD8GijOTjRAB2x78lBdLdX9tfx4O/U23aEWMhJzmcrppcrL0M ku8ru8MdQnLuh3hFqK7gZKjdXpwQvlgy7MYWjPw5FZCv9AA0Dv/YxBJGVhXiUCG7xjOzX1Itt6t
 C9fEMcq2sgCnGjbfvaMnq2LbZJDVwygfySm1hj2Sav/j5XxHi/Np45V3xbSwkupqPJ+adBGvrHX iFhCO/UhWZfioodBUZrIbKQ46gU4pDQFZ306W9yJqCF/K5sezsG5rukO+j/dj3HgM+lR/sWNBu8 CmavvS00GqfPhmLIC4m03HTmmMn0IyKK6wjbbi/UFAuHKNVzlMQRPM++M5gID8NndEG0luB/rwL
 +CV44YHaF27S4FSZIqAe+ruYyNQFGKhPWdunSpwItXzMtwRXX4QQkqnp0NxAPZhQfi+6hE77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505300039

From: Zi Yan <ziy@nvidia.com>

[ upstream commit dd63bd7df41a8f9393a2e3ff9157a441c08eb996  ]

Fix two inputs to check_anon_huge() and one if condition, so the tests
work as expected.

Steps to reproduce the issue.
make headers
make -C tools/testing/selftests/vm

Before patching:test fails with a non-zero exit code

~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
> /dev/null 2>&1;echo $?
1

~/linux$ ./split_huge_page_test
No THP is allocated

After patching:

~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
> /dev/null 2>&1;echo $?
0

~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
Split huge pages successful
...

Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Tested-by: Zach O'Keefe <zokeefe@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Guangming Wang <guangming.wang@windriver.com>
---
 tools/testing/selftests/vm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 76e1c36dd..b8558c7f1 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -106,7 +106,7 @@ void split_pmd_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
@@ -122,7 +122,7 @@ void split_pmd_thp(void)
 		}
 
 
-	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
 		printf("Still AnonHugePages not split\n");
 		exit(EXIT_FAILURE);
 	}
@@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1


