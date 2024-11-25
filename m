Return-Path: <stable+bounces-95341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3389D7B46
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07B92815BA
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC81126C1E;
	Mon, 25 Nov 2024 05:38:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D081E517
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513102; cv=fail; b=bujPuE8pKKg6dBCUPNNEGQYsXQQtta2dwT2Y5UhlCK0VOanQXBNauidbw4yNzhUB1KB5C/uB78r1y4oLGLSubTm+CxF87k6qn1IPW3URGYJUhdL1EMvgBaYeaJKXb/CaAp9DxmeMLMoRmTrfZXhhpHHUWMrUamAAzpQhontS2ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513102; c=relaxed/simple;
	bh=lqTBVX+LrLpb9sz75gnz7rzR/KH0fsR6vi4zlhR5FnM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wt/S8FWPuYKKi+5+RWV3XnJY2QONEhnniOik568Mx4QgjzorXPXN/tSC+16G+3NsErRTJkbsspMfZPc1iuBJnayMbwmvjNkhXQvcrfSZYFKh/98+FkALLfVb+93shlSzRGQD6zn7Cm/gFzAFwgFnXRKs9cUANkSMZn4EfB2U/mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP40lrR024079;
	Mon, 25 Nov 2024 05:38:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4336189mgy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:38:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS7OG6TauYLzQpSyORqsW4IOSctaXY8vZypNNujlcjXmEXHOcY70nPns2iGy6pE9oAJn16gr3xUsgWxsh0No9LiFFl0taZbm+Sw18UErd4Gs2PFxDKnrGX+wvO1mhR2rGbnNP4Jk8cW12COKsrOgY1bUo/Tq+Z4jg4GbfMCu/d6VYxD7yK0k9Y0tatrbxaA1zYiI0Sg5ixocZwKT/Rryf2zXSTXhz6wvrHrjMo7O+0u+cOmJv+SCbYFMtG+/2FQJ3kBlfSZ9dlM+W6qJR/r/VzSZmDzRw0kwulyMXz7xZEruagOixORMWkM6PtFe4hcTXsEp/i2dKh/I0HL5/kwCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KflaaGp69pDicwexQV8TrTomAtQb3qLpHv+pmgQgdm0=;
 b=cOyhPOo6OX1a3e87bCJyjRwMrPYak6lMa2GEBoIrPVomZotB82iav7h7CG2nuq/j+lK3DywZcAkCUVarhEE3dBPa1sdC+p4Wjx4xb89JDp/CReryW/txHvi3NU1zy3TXwJ6Ya7iSBM3BurSec8JvQUOxEgbG8auIc0gQZf5OY32V+Aw8nUuPGim49NICbSazdi4t4ZUngq8RPOr021LJC3WxXhZaaERVy1SVBLDH0FhCkCNSj1SfaRwkHF30ecookW2WkZxvJ0PkDFUEJBWQxpT3Za5AWYQx3QlwyapFBnUSrcFFdL//zlgrLMRm54yh8EnyfRrcPxxNygE38DR/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 05:38:09 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.024; Mon, 25 Nov 2024
 05:38:08 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: marpagan@redhat.com, yilun.xu@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1 0/2] Backport to fix CVE-2024-37021 and CVE-2024-36479
Date: Mon, 25 Nov 2024 13:38:14 +0800
Message-ID: <20241125053816.1914594-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0340.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: cafb0009-87ff-421b-adb4-08dd0d1357c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYtZ/5nm9vFxQTNko2jEKRZuxdal6yoZ7MER+q9P5Rfzqai3v6644KYyBDIQ?=
 =?us-ascii?Q?IhkfLPE2aWKOutdVmJ5aV0thDBRoq1D6kYPAwb4oe9+vshUPUBfAF2/AmZJ9?=
 =?us-ascii?Q?aakeZU7chsr89QtIX9B5DPO4/Mk35WS9WvX4+wbfBzDGs0nhsi4qeQggFMNz?=
 =?us-ascii?Q?a/DQOdKMLMbONH3VKDVL89AoxWGDdzfldxO9hanTs3ebb86mAt/gpJ37fRtC?=
 =?us-ascii?Q?FtY2eoSQkiDu9I8CUOaSjSiEAyncWqvloMUji83jDl9d+/ua7ozYRrWEL894?=
 =?us-ascii?Q?da8pJp212HRwDRDXotvGVq3oM1/Pae9tZhwpymnZdg3iUFzKjG3g2H4LVbCp?=
 =?us-ascii?Q?aGexII0HjKSPoPpUxCFF5aH0U8aTdM1LIJ7nvXlKF/GuThVgQNFc/ihOSe6o?=
 =?us-ascii?Q?sxfX8QreG6H5p393e2AMbtGS7KCXpQQJFUrMALld4O0EorezDy4l++oDycAZ?=
 =?us-ascii?Q?tGoyiOM14xThnnB4ASRv2j71YTE7tuQxMoe/Ho40z+UPZa2QBAwdOhaGziEm?=
 =?us-ascii?Q?eOjOG6AskbRWf9m/lj3qqsDzlxEIr1ErVwLvZeFmJYzMJPLlxgZKKDOmRpX8?=
 =?us-ascii?Q?qNCpWbHvhGVMxgqOuqCmYI9F3Ql2AL8v0vJVIYdDKogmiDY0c55HeDj0xoO1?=
 =?us-ascii?Q?hQS5AeFTZSZJDmmknmJVDFLzG+Xhv+kYbCTQwemsEvQDokdbqkGDYA84JA3Z?=
 =?us-ascii?Q?sn8v4AS58Ip+mfWE/75erzmsECt96apyAT/pj5W+0i5MJzfSjN3CEotIku5i?=
 =?us-ascii?Q?RtkYVQa/wAJbAl/U8cFYZFEpSzk/p2si78YLlFQ8GKOWnA7G+XwTED2uXgm1?=
 =?us-ascii?Q?Ogjswzwp+GkB2EJVYJ7YMLNSTZIpM9UDzjn3e4BgAtw9UJp3IrfswfoTqfZY?=
 =?us-ascii?Q?6ck9AEEJoH1SvNlLeohhrmDS9lmy4Y9ZNbtNFYIUh9VOtPdOy8koDvSGx/i3?=
 =?us-ascii?Q?sbqS8T3PCz3x0OGUouirjwgHovcTZLsmxggx1jQWu8LOc/3xVD9gaQMUZiaH?=
 =?us-ascii?Q?4ey0U4VqHTxXKCGn1+K5Ui7T9Hs8VKuv5j7qV3Z5dMYUBWDji5oRrstDCMOQ?=
 =?us-ascii?Q?0KPfkosCi7cIXu3V3mlZK+LA1XZsshJrVsgf/qdC6py6WO5mGU3VjUJKuG2L?=
 =?us-ascii?Q?ppKymwNqQ9C3RSaq50HGd7GqYMaswFIRQczacp1vmBv9MGyfEvqepVKqc/oR?=
 =?us-ascii?Q?5jKViXYUFFfSJK+f2SFWz4DU2V9CGDJm8bArqNNYSJwylf3rcWBvkBxanGNZ?=
 =?us-ascii?Q?xhAKH5jD99NTHK2E2Zr+pwPIa0bKv+bgj/POW1do1TuhYGDzmMTfiaWTDOcK?=
 =?us-ascii?Q?MRUm10F1KkjF8NXPUMucAZLR08ts84AekjBdbgvwaEMBGhm99q7LSlshdTWO?=
 =?us-ascii?Q?TxQ3X7nPe4kpsXyIrGSH2v5jT3LX+dLVpbmuNc3nGDz6Jz5fpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDtq10HGkqc94+Wtb1E5EXvmOR9dzMPN5/6mopOH2gbQzzedsS0aeAcWYrc8?=
 =?us-ascii?Q?rLqGvNxFMBM2bXp+FjFnDTEO11PQRu0LDAEh1BubdX7OCR/PUKh8lu29dBKG?=
 =?us-ascii?Q?4kvNJ5ZmiPXpiEm3E/vOS7OryIVA+mEPadSK0yxr6T5F5Z6bWSpyYZEVnrEb?=
 =?us-ascii?Q?gj2KOVYg4g2X+EAgFbRfu1wPZFRvAdwJ7I/DXR1ZYFAjQZ8tAngtmeSMb3Ns?=
 =?us-ascii?Q?txfhr4SCTN8kjab2kJRJQqldVCqEedXr7XDSXO7HHF41p57EGeCQFIjadPcP?=
 =?us-ascii?Q?7YbdHfHwmjNXy9KAjbEyHlfkrtcwmD2Xh3DXcRdVF0CD8qFpoESG6Qk7ve6r?=
 =?us-ascii?Q?nOqLssYOGd8i60+TEpMVGuTwW0y+aPdCJbYAOwoAd9SVk21p0uQehOTK1FAl?=
 =?us-ascii?Q?AOWSiN8MjU955B/DolxX0XlS6PaIbK1SNlqfSAPY6DQVcJUPxmuSauJk0ZIg?=
 =?us-ascii?Q?jEINO495ZlLnO646ZCkIehymz/yxGOBaXb46J7gOFtlcxSZKEVAoEPEm4K8f?=
 =?us-ascii?Q?loO0GtwjczNcnqVQ2TAIow5JQ8FNVncTPk9zgtvxOScJu2zNQg9K0i+eO658?=
 =?us-ascii?Q?I3Hsiy1GdrHONWCKq30B3qtyNzcc+QaXD3xt1jXiXov4ifePkQQ14PXgeZD+?=
 =?us-ascii?Q?ou1OXZPtGfXvGDo1y7Kncoum3O3LLLxbMYT+G509FmScXQ+quUhLmXc8ZYOK?=
 =?us-ascii?Q?qZLTFDIA1JgF/bS5ofsmUCGBPpDEY8FGC+yESQYPUyLfd1Hv/FETJu7qZuXJ?=
 =?us-ascii?Q?1xzXP3kglnfNZPBBXkEj4hArzvstj6CbVbkSFE8Qhy2OZWLauOC8LZbjZXwg?=
 =?us-ascii?Q?uy8ZUdUYBHnGzHpNZuZUfMSAbpL/gopWHGkhb1YwfwrAk9jOJrvR6UV8n5uC?=
 =?us-ascii?Q?nlrwDEkmx4rrNsMDENaZQ32gUzPBk5mfr4v90s0N4LZU2Or2hg/LP3wi3Xxk?=
 =?us-ascii?Q?HiYqLHF+ZGAD+0A2KTcrMjyW86TOplDfSw9smya7GKs9KpMS9HuyifySqrFh?=
 =?us-ascii?Q?miutOkW6I2JtmPsQ5+UMDyu/nAkhnn44grOWwahI5FWWXJdWra0ouawqaNhu?=
 =?us-ascii?Q?whRM7jmRI8tbdC+hjS/7Jw0x4AAAjWuq6IwQFr5a9cqzZlkxBDagpdtlVx6o?=
 =?us-ascii?Q?lX0b1ofJjPT3Yes1+5/JSL2HH3G/+DiDTihi/7dvPqOOJcnklv6hiKG09pBv?=
 =?us-ascii?Q?GMQSrOY+85eahmOG1087pMOop3tCb96uOqL0VqQGGfihGv9K4CLqIBsZdF/D?=
 =?us-ascii?Q?OBXfLxEHTwb7S2sOz5xSJzAxdUkbmtOFXbDSgjdsW5ZfR9qXoi+lFETs/sfh?=
 =?us-ascii?Q?0FWsQVLKtwIjfhAhjYMtwXnxYyvKhsj2L0r+HOPBQaXPN5NRZZRvyQcae3vE?=
 =?us-ascii?Q?W1GW2OJ681O4yOarXvTYWr4Dq7EzdDF8vfZvGw+9W15WZGmPaDkZCJEzHHQm?=
 =?us-ascii?Q?wntFRdyv6PLIdfO6Or9wS61T9I5aVKg0Nsq3U32C+dF0PsNq2WFbjGQws4Uz?=
 =?us-ascii?Q?osN2ObuOhiBlJF/QSE4s3tDWeEuK+iUdYMAXTnjW4ADZh08UwrBZzRNpPbXx?=
 =?us-ascii?Q?q2ZRfK+Qx9vDL2FrBErvYUuatpGUJJEZqT6WneUhJk9nXCpeebU+doGlXs0g?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb0009-87ff-421b-adb4-08dd0d1357c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 05:38:08.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYswfQC+smtmZRgRs8PImqVPOBsLf3yNroPRZFqol6fwBibFeJWP2R8BjTY/RAHFe4Iy+lJN5RqGHaM9L1YJziaJbSnPwVdZOfUmxkVv/vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-Proofpoint-ORIG-GUID: sSkJOxPQf-TFi1cTs-s-tHwSpoar141T
X-Proofpoint-GUID: sSkJOxPQf-TFi1cTs-s-tHwSpoar141T
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67440d45 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=ZbELxbT9_Kmj0sIWyMwA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_02,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=631 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411250046

From: Xiangyu Chen <xiangyu.chen@windriver.com>

The fix of CVE-2024-36479:
fpga: bridge: add owner module and take its refcount
master rev 1da11f822042eb6ef4b6064dc048f157a7852529

The fix of CVE-2024-37021:
fpga: manager: add owner module and take its refcount
master rev 4d4d2d4346857bf778fafaa97d6f76bb1663e3c9


Marco Pagani (2):
  fpga: bridge: add owner module and take its refcount
  fpga: manager: add owner module and take its refcount

 Documentation/driver-api/fpga/fpga-bridge.rst |  7 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    | 34 ++++----
 drivers/fpga/fpga-bridge.c                    | 57 +++++++------
 drivers/fpga/fpga-mgr.c                       | 82 +++++++++++--------
 include/linux/fpga/fpga-bridge.h              | 10 ++-
 include/linux/fpga/fpga-mgr.h                 | 26 ++++--
 6 files changed, 132 insertions(+), 84 deletions(-)

-- 
2.43.0


