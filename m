Return-Path: <stable+bounces-133053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA446A91B07
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6934C7ACD2F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42C23F405;
	Thu, 17 Apr 2025 11:38:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63668460
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889886; cv=fail; b=VBq390yB5Pc7QcUD5isz3SmZ8kamVRxF3qAZbQvOXOL48wG7lXfyu1aQzjmBT5CFpg/MlvosdVTCgkhPJ4mUmamnvZrgC5RtnKMkBbTHKW6oDq2BWk3/okavHcmMHaaSTUaOa6WEuxMoIl4ZRCX53cxOlB8x23m1DhVODQOR62k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889886; c=relaxed/simple;
	bh=ohSvVBASpqFXXfbx5hhFyRjwG7EnlBlqsoWbNzEzqx0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EjxS7MHcllnkBfs8iS57OMJD4wZT8jPc5u8vH4zoa+1wMJHSgPTWov1QEhnhs3/M7dfTLgacLGMN387x3GWf/GNPe8/vN2+a9BmI3AC+5IRbyZPkdLxbih/Dvo4MSxN8riaFlFbx4BuJqVAmWSUw04ygUruVj4h8pk6xSujDKJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6023S019651;
	Thu, 17 Apr 2025 04:38:01 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpknxbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPJNIf1xjVOa2TUEZDMGTnSvbESkWWp/fGD0VKw8PE3+tdp4baNpVq4JlkZNH2i8yh89s8/OMe+UtVqF3G3OynkJiFSXCfxU0XANGZWIErjC0Cwux105xQ1WjrNzl/JbEHTh/CGLIe1jJAAGxpJY+8TT9npqVi4tSHguT/qwItFK0Qte04p0C5rZVDVWk3zSXA8v8jpNXXlbLjWcAyOYpCF0g06ekPzxijFZAU1ymZadqaSG8n/g4CVF4xkiUzzV6qEvy5YcYVPcRHqoDX9Njsk/tJAcKuJqVVsy2f/3w8APK5+vU8okuc1HBn3aCBpKNYWV7fcvp952YQeTczkXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeRxGHnjd160/cjTlObHj700Ve7x4t+ah/QoFHNmi3E=;
 b=ci/Ju1YAzkwPYt1PFmbFlkEAjXMGcHRUrnfSijXXKCa94bZTIcOSmyn/dW1WmkmO6CB1jYtZPScRVLWJ5vdHjjioN8lryyCve4v8cphRAaIV2L9E8Dhoa4qrZaLGXEo+odL4b/WEuUBdKv1gOd0ea3qmxgHd6gNVCXknNATcc44ePaXnF9wJ2F+asNZ76j5Pm7vsH0fEM4GCT0O0EHFg2jv1YP5IyQCFoe4BUw5tqXRXx7d8W4O167kpJ2nL/B51BEJZTdUYFGITU2JvccpGu397Z5EbwufAdyfI1S6IEbMalAKtcvaHo0W1Ml7aDvZ0j4e+e/bMEuuKjmI0WZqFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:37:55 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:37:54 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns 1/2] CVE-2024-36912: Fix affected versions
Date: Thu, 17 Apr 2025 19:37:36 +0800
Message-Id: <20250417113737.273764-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: f15e64b1-4232-48e3-3b81-08dd7da44b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16hQysURSfEiJC5fApiv+f4g6a4tX4H1EFhDUFtAJsIQ3dH5lbdzWR46UXCn?=
 =?us-ascii?Q?YJzeLqb139WU6Pea7SPj7fz58I2AltS86WLFX7FtP2e3sOQOhTSTTtQMjY0s?=
 =?us-ascii?Q?5/ASYInAh5HKZxv6FOpccZtPIHo1QDYANCObWf58TC9UanDszkh1gugRopsG?=
 =?us-ascii?Q?1ZYEEZF50VZG85CGkxIAiDRUiQ03i7Doprlu+i8nSbq8sd60h7zQtMkvhGUZ?=
 =?us-ascii?Q?LwF/mR/AeRXJqBtyR1n9XKG87wgQ5rmI14bG84tsen7nbg837PQv1XXRa11R?=
 =?us-ascii?Q?F/uRRPFr7IXQpXT+nM2IDy48PfKdqV/2qoXG8NMO3rET/E9x+G2h1CN96dG0?=
 =?us-ascii?Q?Z4UQ528fobimRFHJQkfqOkpuaSRtJPSALNjXRdck+bbmzkDP7GPaqgd3ClS7?=
 =?us-ascii?Q?A9lnDw/cSRlfcvhhEovFXwU6Jqx96aFYSFCVxLwMimN0Cq0O9/mbj+usu7wT?=
 =?us-ascii?Q?HAQGfjmpLQPi+JOawBuJTNecspXcn6AXWsQ9Ls2gg/OikxlOYFivcivwRHCC?=
 =?us-ascii?Q?gGYbhhrcY+VQBNL4MfNqAuez646FlR4JNJvFjbEJOEpTjr/IQ7PiglX/A7Nt?=
 =?us-ascii?Q?2Xy1Mmk7bb+3RlvAFXAgWhebHTxJ5kyT+HZD1KqV7LZp/2r4vdgmd6zJUEGf?=
 =?us-ascii?Q?kk1ttj1JsLvLdmaZuxuMWkcFktjtgc8iRUCHFiGEWZCGkkHn5rapdLALGnsL?=
 =?us-ascii?Q?w/cALwJel0qa4g8fmsNytk9b4JHRD4KNMrSlmk/WDB8varnh4LpW1EZxbdl1?=
 =?us-ascii?Q?JEeoHOOVmMV1yao+zhV1uH8C3CiyE+Rc4jXmSd0mB75F8JwR4ljKPED7c9jf?=
 =?us-ascii?Q?ojbjJRup/oEo0h8DtUyY5sW/UlqnZZHkDoAZF+cA0s0J8CTR5q/789JWef3E?=
 =?us-ascii?Q?OkyMlbYXMviiSyDZtsVGXqpyvxBKQ2KTH52u2fvWXa4UpG5O7lqddvgdSt/j?=
 =?us-ascii?Q?LPmx7QqUwZsNPp2aDzmXENA5528kmN7QZf6sfB90LkBkiQMe4xa+Ef3Xn1xb?=
 =?us-ascii?Q?t0YMyYZu4AJywCzt9oVLWwhPuZvIwMC/D+wXR+A+OiWIfQXr6FnEzhLCjRga?=
 =?us-ascii?Q?3YOZwwqXI+l3OPbYTyKJc60nAuRKJS2/nZmN0I3Dqey+eZPIUb5NGaUka0aT?=
 =?us-ascii?Q?UzLTQhitsLwWphKPVERCPEhA6EzM3tROtWu3EbTiTBHM7204Qa/0tB1uV5Yl?=
 =?us-ascii?Q?J8n0PnhSuGjMi1fhyR1fuuM4GqwcTviFgy9+icMUSD/wPFP57su1srK5ZPYH?=
 =?us-ascii?Q?AkXhIHN5na79Q6vffptBjDNXfL7tflr1vTuLwSuxaPGHY5Ontj6v+A23lPah?=
 =?us-ascii?Q?YG325vZsZHo4Mzjpg9Oz1ptqT/oob1WbMvvr1gGPEpMRKGBGQvXvALviO6CQ?=
 =?us-ascii?Q?r/Ze/18wwaNXso6obCawWBPlYLZjmIry7F4nDnTbAltVqL4xYaM50nxI3ooE?=
 =?us-ascii?Q?JgdFNquSeev7BPswJZGog6VpbNws/qpYVtWmbpa7e6HkLKbp/DK9SWauN4Oy?=
 =?us-ascii?Q?yGcXffI5ChGd1CU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMslPZlwUmHvKJTn076kJyiWaQIoTADZZ20I2KD+xD/5uWRBh5HSgo0IDvfo?=
 =?us-ascii?Q?YhclxNHOYd2/CuPkdgTPwxy1uJ83pshgTOEz3jA1VgtZNXW02m7OOUkUvk91?=
 =?us-ascii?Q?fS8TLgLKo7takYljJSq/TAu3telhQRlOQUUjQztiCyvveTxHCTd3wCC/sdSe?=
 =?us-ascii?Q?zWOeUIn8OHCdHnaeunozZvAc+5a8CJKq+Omg7lIeMO8d6PnEn5dos/okdmcz?=
 =?us-ascii?Q?b4zTVl7lSMkk/v6YC/gS23l4k6dDGRNKvg8kkRuDJUAUKMY6Vs3PU8l7fgpo?=
 =?us-ascii?Q?0SWeRfwk5viqIfM/t49CDieGK7u61Se0cEbBT5608NCl1wk7V+Qv47JxS/gR?=
 =?us-ascii?Q?L0JggSmZQtPpbE3dv541bBSFjIOWzaVPE1zMXOXW92NXGBHvLGHx2JeqH6ik?=
 =?us-ascii?Q?AGr8RRuyAeWwTkMtjBGgbhG1rUKbUJaA86EQQ2aiQCWKrCam+GyRazKPFQRD?=
 =?us-ascii?Q?ETXjaewxR5pfxzWzygxPJ1bp/LuKHwB5pIeLZr8Mwpi/5g6eH7q9FzyLLzya?=
 =?us-ascii?Q?anH+dyP3r7oQKmc0v1Qcb1D54fv73J3CewbGX9fY+sCZ63/m4L1MkFEMnQZG?=
 =?us-ascii?Q?FUmGG1v+/i59Ys4Fj0hXC60tRg5jPNvvPqwq/S2HKlaPB6sOI8Mw7qP0Y98Y?=
 =?us-ascii?Q?RmmCG9BFn5sprXDu5ZCHv2nJnUpr8nDvpYXQm9P9UAVvS3adrjnakSrTPK7Q?=
 =?us-ascii?Q?GMLQkl4Nto2scXfhHwX2KFzAI6moZIPR+u7tccB/+NiKa3GO4IyjOJz5B58l?=
 =?us-ascii?Q?2ejnVWiLAkJ0m73/h2agTRpPWkif+VMRw/gm2AoncNbbzQvPtHDndikC6j42?=
 =?us-ascii?Q?3cUBfehO/y5ODRUyQM7LiA4cGYTYmn7Fj0y3PK0LQS9x/sLBaDEjyOH4tWFX?=
 =?us-ascii?Q?VDU9wbig5JvloCH6W5A0HOPfyJeCEYX0PEBM4OKhfnlpFBLXe5JoNkAmBpwa?=
 =?us-ascii?Q?m14RrxUa8+DbGXZ117WPdovjpH5QaJdDelG/KUL5403zAcIxPbyWFJTDG9w/?=
 =?us-ascii?Q?waBla0PDyKPvTjmqHlPaDLtfkPaTROWm2Y/+sQ1Ff4gd6Q/8SwQgrsmK5H+h?=
 =?us-ascii?Q?cb2CmXgdBAb+V7+ZIlQs1T0erxgIjRkcvVGAAVnO9iW9f98nrWX9k83zaT4w?=
 =?us-ascii?Q?WOxu6nds6RKpzljHuKKkumzdlcGfVOPgjHshddD4Qu7IL+P4/QeNN0qxtmij?=
 =?us-ascii?Q?nd7rQaE79D/ZFagnepRu8rwDRvKW8qo1jxQRU8iMDrWIDhyfQoIUa9xYTfTh?=
 =?us-ascii?Q?Ldn7QKBw96cAGi/pWbT/GYjoYvREXLX+z7eh7OGmp3UmK3bRP8aEEYkr3WPy?=
 =?us-ascii?Q?4E4lhPIaHELd7AcbINmJzMct621nipZBpknfZbIf8uWFXHZtVR+7jbCE/Ign?=
 =?us-ascii?Q?AUneLcKG7uB50g5P71p8scz3nlDj8POfWbNlzL2zxpX/qOXKCtWN5sOxTHc/?=
 =?us-ascii?Q?DcN9vazCSUvc+/f/zDsJ9NlIgaFNllrN3gTvWiOyFw9N35m+Zo0gT9yeGLjC?=
 =?us-ascii?Q?R6dN3PF4VBaTmSrqanZ036TP1X/8Y2kWT1Fd2fa5UU61kliEedD7f6Cq8mNN?=
 =?us-ascii?Q?G5QSKvvbbJ8butXStFyeCJ1xEhEtNGvno7UxjVjl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15e64b1-4232-48e3-3b81-08dd7da44b0c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:37:54.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9Bmwu1xvHSzp3cS0hZDQ9qVUOajKodte9IaKc9HfV7vMRLwba/98Phlt/hIGkoHHUkU59o8y9/eyZVVgat/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-Proofpoint-ORIG-GUID: eoKfl8G3tcL1hWinYjyxnqrU9ZB-ml3U
X-Proofpoint-GUID: eoKfl8G3tcL1hWinYjyxnqrU9ZB-ml3U
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6800e818 cx=c_pps a=hSS9g3ca6WprpwKybkK64g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=t7CeM3EgAAAA:8 a=JlKoGYRGfjBZGDWtW-YA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=641 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170087

Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 cve/published/2024/CVE-2024-36912.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-36912.vulnerable

diff --git a/cve/published/2024/CVE-2024-36912.vulnerable b/cve/published/2024/CVE-2024-36912.vulnerable
new file mode 100644
index 000000000..ffedf3da8
--- /dev/null
+++ b/cve/published/2024/CVE-2024-36912.vulnerable
@@ -0,0 +1 @@
+d4dccf353db80e209f262e3973c834e6e48ba9a9
-- 
2.34.1


