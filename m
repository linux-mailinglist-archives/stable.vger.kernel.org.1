Return-Path: <stable+bounces-86832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B669A4087
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F11F25A2A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782B1DF26C;
	Fri, 18 Oct 2024 13:55:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293141A84
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259702; cv=fail; b=Mg8dEpRoeE45dWfQbTop9dBV0C+1dai2DWCDi/BnlZymmMelfwFlOzSL5rRepi9Xu/nOlTVzNsMl62b7u+xNJahxS3Utfv3/Iz7VBVaLgUtzeFgMGOcPAqJHQhHZcBIUmvjE9nx0xZ9eJBmhsU1iQV2yZHEuin4xfrBG31/FKrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259702; c=relaxed/simple;
	bh=1WFncbjEuQ+wpZ2wv08bVTCvhDAZjcaO1CbpMJLTvUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8F5E8Ye0TLURnva7bTlHsqW3gSHiJgdXzENmg9NastiRYo0r8DPWaoA/tvuy0YCrRlYFqHIXw2fGk/QYiHUkAkn+W2HnT+Mm0xA+Lz0hl8gk/udcYQBSTLBxp1NUt6rGcRaJAMznb3a3GmMs5qoM4KcyAmxYUo2LXQ5mKRF9Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8Cnoe027945;
	Fri, 18 Oct 2024 06:54:53 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42a397k9hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 06:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCu7ZxsfwOdj+VwoXgMlAUJVHfj/AqF0/0YwHYt3BiK46mCQojWOeXFLtV3Chy/BoBwN7uHWglVQgpD2VkQD+uY2SKTFSNOHkZv8XybkCa0cw46tZSpn4FzUhfUrCc43hgJVekFF2sfMX4gGcIrBEkTuFw+zZZDRsRebbpV2IMV44lah2GwoBjmKp258Fa9t+9HLBS+DrnbkukuvATI1ucrAwU0dor3EziNx9pnfjZq5AceFZlgTMhwklLQwewuSh/mHOnnRcjtr1Ts1q2sf1bezAqoy2eoziDAR0iCn9PrULmovhDEpWvpvWbB0WjgslNAHBT4UJDhGM7DuzSB7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aJ59XKk7pLlfAhPHfTrZm25GtmmcXU1BlbZnK0ix7E=;
 b=GBSzCQWeyrzz+g01oo6CBejHIbH95yudpeX/mujO9Vqy1q1+4ocySjFKDHo2xNtgGOTTubpN9O2A2kpqRiI7CA3gEO8JWF2vQjl5TMKeJHkBX80AmdUXdluxXfc1OWUNkY8td5LdDbsoPQu53muW2IfQtFaEwS9w0wT3Vp00YhZAHag0jUBUOUYUWptbFXzQUKh5Mm3+WleUd/iVSTWwYwGenu1TYAJNTEuVTE4SuVWabW9Tb50qeMWSMlOK/xM/BTkDge8IKfoI37vhQDwHISWgi9Q8pXaFpKXVJa9tzufw517uC4E1zdRJRgO4OKf9uXgN9rlApp6EpaLeyNDAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:54:51 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:54:51 +0000
From: He Zhe <zhe.he@windriver.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
Date: Fri, 18 Oct 2024 21:54:27 +0800
Message-Id: <20241018135428.1422904-4-zhe.he@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10731236-7888-4320-881c-08dcef7c6fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8csVx1FsgdwLOzvNQHozi45AVhUjKKqV7BWZy12wcwHM1Pb0fn0l+WBAn2wW?=
 =?us-ascii?Q?8U+iLZAzX3HiGrSTtq2BcPlNJMcUATCu6gEQJFfw5i1DpbCN0v06ceums2MR?=
 =?us-ascii?Q?9xZ2wBYdOjb9+58YZRSUJo30k//cjYoO56id86Re09fEztReJqEeufIA5VUS?=
 =?us-ascii?Q?nFipixnmt+axlOsJ3bT5JhKD04IKkHyYxG+j+sV+zO4+7Wle6RAVR8Sb9QWy?=
 =?us-ascii?Q?Vfuud1HGaiEF8lcYacaZ5jD+sqd0VL5kn1gCrehPZmWs46MrXf7N5vKx/ALb?=
 =?us-ascii?Q?5koUmDWuIYL0pHLA5if3CXXzNK6ISWHVRb7zLRjtgI8y9WLMqo5rfUYxnKfZ?=
 =?us-ascii?Q?V9Tux1cMQ1aAFdRj5fhtPcNOsqIrVOgbsakSo42WH6cjQJeDVjvJuLNePhFH?=
 =?us-ascii?Q?rD+BcxyOHrC7KciR/gM/Bic1xQL9HiJDF/15agnuFVzCraJXVXUy5KonopG6?=
 =?us-ascii?Q?rCNTTmqN/KKHd5IdeCSe59GIULas4s/5FA5VzL33u2vQWZl5NU5V59+hBkUE?=
 =?us-ascii?Q?3cQ9OgWO+pHQ7OTLIcyjiEygaJLeUal4xokLTLM43OA5737buU6Xs3tUuUIB?=
 =?us-ascii?Q?NKDd149EvogV8+XSpSEdzwy0h1/mE6BLMlaFBEOIA0/vEK+NuMd0sCbSlxYX?=
 =?us-ascii?Q?PlNCqP7v38jRRhaCwEwPWGUbhcm69DVMCGwGDyr6UhF/EmIFUFBuBLFKij6b?=
 =?us-ascii?Q?mg4Y04gNYLT8OJUFn/WltaJSs7XwBzckzjpUm9bB5CwqJvVsql59Z8Uz8poI?=
 =?us-ascii?Q?1tlU4t/Cza+RAOkKrcZy4rzl7ZYF8RBww41l0TTy7xJ22VFlOmg99KDIjkwh?=
 =?us-ascii?Q?I4Dn9UfWNtrrcYes9Ie3ghjiSNZCxEwiRiG1OeK+Hk+1FQR76WT2Xij+INSz?=
 =?us-ascii?Q?kvrHhdlreks5q8tv7VAxKetq8wOpAjhhz3SGOHFQD+vE/WmuMNNlX7dVB8iO?=
 =?us-ascii?Q?r3JoD6EGo8CC77DYVJbhvIWuRs/mK7PT7YHXukq3WnwoVebusZH//H/vRQxE?=
 =?us-ascii?Q?63ZrQg3yXk8A5yhVmXJhCCyGF5+2wa2PomcigItwLc+hVBwfqKnS2kAlwdxC?=
 =?us-ascii?Q?Nez7SdOIu+sEX7mDgsQPYs+v+a3mAMqguK4Nrv+/ehFcyIZNoYErKW+chJkw?=
 =?us-ascii?Q?UqtiVR1KbczGEkFlRSaJGeSoaSOaAialK5Ky/1o+5bK0cqbJm7TjZdHJZQhx?=
 =?us-ascii?Q?3c6sNm7oTOkjM5puoLK20CXXkmf6aHpF0b0VgVGakSFi47+ECc/jTQ9RK3DS?=
 =?us-ascii?Q?KrkHjm9+8fsEXj+wOeNL4ZXxPT7L2oF7MAI0QHm0vJeEPXlS+Bw5ndXUGsbO?=
 =?us-ascii?Q?wQRDqyOhsQgnH5KUhWyGSp4FcO6afsQnVVh+sKp8Y0IR4/xYt1r4ojaY8x7O?=
 =?us-ascii?Q?gCzTKaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/E00kzNw/7W71ZMR2QiVl+8ZPOezePMKoF8pYRVtK2HqV5ubxJHCnwa63hsy?=
 =?us-ascii?Q?hTbx3I2i4yf91mIK6wT+E4vGg098jkO0wkmRLflScP310g3ZWJQYxWxXElvC?=
 =?us-ascii?Q?oupSy0YAPz0KPEqvlgFqcoZMBr7xIIcebLWne7r/xTKUHmS3TR+FrINa91jm?=
 =?us-ascii?Q?hC1bKAtfBgpOMlKGNiKnwJadMXDfMauVszrTn1sdC6j2uyMCBwKLPnr2K6TV?=
 =?us-ascii?Q?wfcRWE6ht0oVPHgE2OD908j1ywB9SgGh3h34j9kIz6kftFI9Wzt5dSLCU8I3?=
 =?us-ascii?Q?frfTOX9vBGmN5bmHfNGHEkf2ii65kfUMju6adHUnlQ2CQIYJCR/XIETHKo4E?=
 =?us-ascii?Q?S+JhTfpZyR2NA9+ohIomAL+1zrKFvx2GykTqQQpuQSIbTtrSb0oewWZHfVhK?=
 =?us-ascii?Q?ckctD952BmJAnuqud/NZHGOjwWrf0yRY7ajs57KiLMy1BcZwz/xmJRDUIZkG?=
 =?us-ascii?Q?PFwAWTcSPxSjGLDGLH7YZP/iNlXAZO+BKItPCIZ9ipeq39+cblJ1miczMi+u?=
 =?us-ascii?Q?WqY05CJV43TPLR3hvieCb/4RjRwoMsEIMU9vhMcATUZKNDzmPqXgW3pzfdUL?=
 =?us-ascii?Q?lsKI3T39ACQaCrF4Vj5l3AELOeIHBpq8YX2OCtYq/g/qWYqB0ixWi7NdWuoW?=
 =?us-ascii?Q?/cwd+GwtIsxo7gJKNwbSe9T5PAg6LvqMjiLraCP1MeycvFgreYks/WhQMIHp?=
 =?us-ascii?Q?1H0S0lsddgISLHkK7/ssAQGlFAch/ryaVUICZV+43YaWQt7TqkV9lpbWY1Lf?=
 =?us-ascii?Q?oQQen4TrowDPII8XaMh7Unu/fLA10InBlEdz86VGAEWA6meGHln6mfkRYhpA?=
 =?us-ascii?Q?Pf9Z9X8yBotrGSgxHW+xmtT1dPMiCyFqomyS8u7HQFN92qNcrn37xwCK2R0L?=
 =?us-ascii?Q?LlJpxehdqzE5WDKekbVSH46X2PIqOBpMCuHBjxIeeSGkcZ5f5uYGsWft/pnZ?=
 =?us-ascii?Q?Mb+7qgNjr4pq5FBkAlT0Pnl2OwiwgCtcMZUVASLXcuhJkUi3E3O37/Y/t0od?=
 =?us-ascii?Q?8Dc4iGPB/R+q01fgP97I+h5jBeaSwbBoIhqJed5IPPSc45N1ABowuJm1Tri9?=
 =?us-ascii?Q?6EY8zi1fcB42jo+VHx5yeXoThEeHH9/sO05iS2bXnHgx4/13oXEvUk1qFHA0?=
 =?us-ascii?Q?VF8jzXZiuy9CPloiJzSD+1r29EvuMFf/z+eYgM9SixbjzOX4unEUs2Tz4L8l?=
 =?us-ascii?Q?uZFQxsA+JqJ9Bh8GKsSuG7bg7PFiUT6252AvCczQBPV+XIC4ucv9xnqK+Pvz?=
 =?us-ascii?Q?au7LJKPtVj9jmXnT4u5Ru1W3wyfJFEYBLGj+99KaPxNY7tlpZ3aDiG59e/n+?=
 =?us-ascii?Q?tOpiOkeCpfcCwqAJRTI0bnhvNBcSEztr8aLcPUwH2vJOPPAP9RhlNu82JHsM?=
 =?us-ascii?Q?mNcUESJK3sxHqQn+DkUNaHXR9KpCnz10uY/w2dlIBc7OJ/rB25VjB55LE7oW?=
 =?us-ascii?Q?BYGTknzrmyYHHjS5O23A27HHkC1Aw5CLwibjYTohLdiYqqAEHMI/UGhhii9g?=
 =?us-ascii?Q?drhS4myAtmCQDkIQ4GKLH9OCYGF/9Ht/dnKhPvJlTL/2Je75RYvBAQpMynBw?=
 =?us-ascii?Q?kgUqJsHlGiJCAgIRs8Qq5NCftXAKBE/lsY3UdTHO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10731236-7888-4320-881c-08dcef7c6fbe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:54:51.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej6soajaTM44qviehpeBaPCZ9066GBZ+dxH45uCVvBPFxO6mYSUg7qNtjAWooQrImqAdnbufq7DO8rNpD2URig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-Proofpoint-ORIG-GUID: _yhRTBwS-Tyx0LkQI_ofFq9nRDmsIwUe
X-Authority-Analysis: v=2.4 cv=Fc1lx4+6 c=1 sm=1 tr=0 ts=671268ad cx=c_pps a=0XndbtkAAnsFgPxdSZG6GA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=qk35L8eiK-LMfPonh_wA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: _yhRTBwS-Tyx0LkQI_ofFq9nRDmsIwUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=944 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410180088

From: Alex Deucher <alexander.deucher@amd.com>

commit be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7 upstream.

We don't get the right offset in that case.  The GPU has
an unused 4K area of the register BAR space into which you can
remap registers.  We remap the HDP flush registers into this
space to allow userspace (CPU or GPU) to flush the HDP when it
updates VRAM.  However, on systems with >4K pages, we end up
exposing PAGE_SIZE of MMIO space.

Fixes: d8e408a82704 ("drm/amdkfd: Expose HDP registers to user space")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

CVE: CVE-2024-41011

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 799a91a064a1..9a444b17530a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1311,7 +1311,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -1969,6 +1969,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-- 
2.25.1


