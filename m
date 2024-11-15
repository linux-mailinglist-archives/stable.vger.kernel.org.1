Return-Path: <stable+bounces-93534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998439CDE79
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204401F21034
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179811B6D0B;
	Fri, 15 Nov 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JawKf0cB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KCU8NR5f"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E91B2195;
	Fri, 15 Nov 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674547; cv=fail; b=UXU08BYVR3Y9itZjKGdXUMwdzHdJQVnLodHhfIRTWfh+7saWq1972qO7NWleGFBd5Ku3qXAbcQMeGFMSp9RKnw9S2E8Q/JwUJLX57XI4ti7mvyEGWhTYSIGYW3anQjcD5nUU/6lodulyYRcBuA/cHnnDtVRs7og4HDtbvv9NHoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674547; c=relaxed/simple;
	bh=h+aid8F+kGUEMyCddsVWslgZNyvho6Y3JlhDbRrJ4ug=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F+iSqgmRenGDqzsiWtY0EstEyEeGIG9bgNO2ZVFfSQJ5pxXAzrI8DfH7fpBGG8g33UO9a0RhSUerM0Y+9PVKoPAyKKMJE+i2Efgocaa27leQKZDoJXcW4N3eWigwROlCWHu8WDupJnB90BNABcG8CmEbxAt/k6dKar/Koev8qpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JawKf0cB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KCU8NR5f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHEqc014465;
	Fri, 15 Nov 2024 12:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=92XquejaAm2pZJ6l
	kHW5ys1jp9Gmm3eN/sKWT19t2m8=; b=JawKf0cBUAwLTEqZzDbFfLkoLXgoyfW8
	2wA4G2ScVFZUPb+6ENzv7UA3sLKXVuBzx93VduMexq5rIJXpBIg7uTSB1k3FXANG
	BAY75rAQBqA/wzR5qLCj4xeW6PSMfKgkegP7yDhTfYaW7j3anw/Lm0LnUrmOysnN
	FJiUgAUc44ucnGUN3bLVh1MxJZb1ohLr3auhcl0vm3XFOXVHRej+zAHjYdH4aih6
	CFN936Eb1ND9Ny1T+KOmLznjSeJb7hfY2ECB29FZgxg+3P6WIH88ROikX9k3TvJy
	FhC/2lIFxpWZhCXG65DuzcICDG119tgdLKxT4RYiezWLJSlgks/uUA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2b9kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCQj9P022726;
	Fri, 15 Nov 2024 12:42:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mtdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTKVDmANw8ZAILpgo9mu7YSrtfXgIkgWlXbUV+C30Y3HLs5ZBV4oCk2UtkUNJ+KoXeFIkA2Vhif4mWAnhBT/c9qZYHpe1FGbHmgjZSVh0XXYICHbv5MVHUfn1FkHUAwkxPNX0TKBqLr/p0DSatsjL7S/uOTHCQzb3XpU7Rdoceak13ZQxpZC+V3A5GaN70c29KMNjiXzWoi7NrSeBo5USX5H0Olv/qFpOoQkeTZoDh+lnzzXaNxMLQtcNwcyeVzlXhZ3LdoFXvG5ZsZmCCtYZgz3JVMJaCFp7RxWUmqxOSLNaN7xzzy7nwHbJ70X1WtqlAsK40JCDRnZnBXKshkjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92XquejaAm2pZJ6lkHW5ys1jp9Gmm3eN/sKWT19t2m8=;
 b=d0nkCX+SyGNyi66L4dxejBzKxrX8LtDmUK1IZ/acnt5llxzZQkI/b3SddwRuk7YgAXJXk3WYT48HgwYcujlvDgTkPEPZ9BJEXHOtSJJD8h63ltc1CjwbRwPQSb+oYR/UoIb6nOYfllF6N/qEICJTvlgI4IbwYY91LXszfQJ8uWwrP4nGN5nvXj2elbFdC9wtOVnHs4fL66RVh+yfpyIQdqs1yQcC9P0WvMVvgsz/R49KaY21SQVpMGMykzBBEreaqm15sSeULUHEUdRiNo4IiLOzBkQSWBgWHcjoQOy7wvZa2i8Ev7fBYuTR/v7Jp37SOOr6Lj8OlPXx6vW/ORwAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92XquejaAm2pZJ6lkHW5ys1jp9Gmm3eN/sKWT19t2m8=;
 b=KCU8NR5fNdrGnXUYmHNN0ALgyXZb/xW/kfpZZMYEwok7ElxWKYiVnrqpuC0nqiYkqYoo9fljnVCRBFQPrMuFRzHlwWijyUXx2lQXA7m1xGInYOSmFNi9DiV4s+fXUFqvRcrsI3KuJIdDKvNchDgynt/L8wK8W8udE+1pALLTuO4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6.y 0/5] fix error handling in mmap_region() and refactor (hotfixes)
Date: Fri, 15 Nov 2024 12:41:53 +0000
Message-ID: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c3a66b-ec42-4022-aac1-08dd0572e70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czEm87QZtkwu5o02w3g4n5cF5n86vXHPPuNUZOdPYdFY7cLaSLShYHLprqP0?=
 =?us-ascii?Q?zvj+2tbsi2COPqGF2FWZAYSuhyMd47Hd6M3rU8d5H5Iu2CBcTCKfXNTJV5FW?=
 =?us-ascii?Q?izpm8AyubfpnTI9adVH1dKQY2n/sFgwDoWR8WKGy4gYsi2FGfJUzK03AGJcq?=
 =?us-ascii?Q?al7t9AEgyAOt6WwtMZ2MKvOPrhFTP1BjLrW9Ool15lwaWpZN57dufAEawY5a?=
 =?us-ascii?Q?Fn+Q4UlgMjxG8BPXo+aL+lrZmfzNdm4nIcgu7+lBEko0TjeZcxA/rya5N+6Z?=
 =?us-ascii?Q?sAvY0eXaYPYa+c5WlFFsbJU7yXDW3UZhWbULCmkKyEZp9PUCXcfRLm/OeD8g?=
 =?us-ascii?Q?I1JQden7uvCYKSMMYMAbkWmnUsSrzZtMOoAaUf+k39AyATEbvqAvJwNFHx89?=
 =?us-ascii?Q?OaPx8ibZ8EsbPBOamnxAF7sjyJre1W69QEEihdE9zSD5cz4rMRaRUU0r6wrZ?=
 =?us-ascii?Q?xncsN6ICJmRpKiqVPLZDrVIw9n/X+NJcwBNEBKtiyr4G3kgI7vWE0LliHxh3?=
 =?us-ascii?Q?g4QAHvQgkpbShTqM/3NA+gAIQhYY+bX5oTuw5ogWFg01XVwtS6fPe5uZj9FM?=
 =?us-ascii?Q?sMYekbsurXm10w2ReAOjG+Idnx0nURRd0UU06A21BjbAbSYVjrfRifTJEEXW?=
 =?us-ascii?Q?hgs0qwx5n9R9BapdWKuoEXsN2c3/AkdjXj9ggcC5ekKA4edBbbS/DfcGr5Gs?=
 =?us-ascii?Q?nhlJ47Mfc/qC9/+f2dWV2++FZAQYVl+b5zLbIJpEGiDBIE2Kaj6brwNKUs7P?=
 =?us-ascii?Q?sohRRN05zkN/U0i5RyDNEZVgCZRC2D3zhX0nYuGf7KPMSe23lN7tBmMkptw7?=
 =?us-ascii?Q?b7+AOM36IaK9La30zVIP1GxakuDEh9iiyru3Pzg9SN1ZeJ4mnQuI9tvHl+6e?=
 =?us-ascii?Q?1nWceRtiy0rX7ImPFXDKkfKk2O3tMmQLRR1opQxfDC4cXyPiPv9mX9r+f0M7?=
 =?us-ascii?Q?MeXJIPfjzDKpL3+CCe61U1Gpc2Rfi8K8gtuUIEOAupT1VWRis14GMCswU2Vq?=
 =?us-ascii?Q?O6M+Qw4xviSL7bJtM2LwlufE/U/XzOaoyX9LxG0wdpPTxfcGThvrO1ce6+H2?=
 =?us-ascii?Q?XbTpWhXnKS9yDKiAizOVkLEuh3BKenaWxDSxLc3hNSEYz5qFtNt8Ue6xuJI4?=
 =?us-ascii?Q?cVj3dxUSyi3KdMML4Z8atWM8y+ihBD2qY5CoaWewMWNATlrARCkp7tTpQot4?=
 =?us-ascii?Q?dg3nqEJcRIvQQROkIjaOgiVQqWLlPjKoAegkajGH/4769OflNk+601S9rjd/?=
 =?us-ascii?Q?sZWji+fF4Ed+Q1JRboKe2I4VY7iETpU0sQVAg4Caoi4NFln8sZYqCM3CyyNn?=
 =?us-ascii?Q?aSwl9yV98h3TbkDIGh9dCEsu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LtZ37tRb6odZDuEPLnr88gjp5s+vQdsViUpgBbYKbVV++aoAx0RNZBUB9EDX?=
 =?us-ascii?Q?987DKmlnDi6nXu8br6NQ5g59IEjYfnLMIKSX1X5rksTgVbtsF/HtyyB1akJ+?=
 =?us-ascii?Q?4WWz3WMGTPCyknYn9Llj/13do+kvSvZ/SomqUsuGr5ZlsgcDxJnUHBlRy1or?=
 =?us-ascii?Q?KWcc1tgpLy90Yyb7B24bdQdvyE7ZQl2maQpX2V5MabBPBJYGwkPDgUswyOlZ?=
 =?us-ascii?Q?Ahb4hQGTW/T7kaWHQ347Rivg5ZHcVwT7ifCU/qHGfuste5uynd1oT83bD0Ah?=
 =?us-ascii?Q?IkPH6+0kV2h6wCG5HtT6d72xxsK897RDfSXwGVQVllnW+kBEy+Wl0byTbkzf?=
 =?us-ascii?Q?WMVfubf2GlS9PtewWLyaS5X/9RZ7lMvt4GhfY4KqucHM0v8lHK6bK7d2PIs6?=
 =?us-ascii?Q?KvbZkucyNahG1f65YCvtwmqN1jmhvK92Ej949bms+7i2bfHxQ4AykiBAI+sL?=
 =?us-ascii?Q?yfpJXNBfISLglrk9T3qG0KBMayU6CCD1h+MDFV8lAMIfOakPdiOKt2JlOpuM?=
 =?us-ascii?Q?8bph6fNKNkdv+HHZC7xHgDkQ+Ra5aTpA4evQKN7KDksyTAS3HcULC/STsTD2?=
 =?us-ascii?Q?TzUMyqzzGUJzvC/z1+8a7wYh/7t5y0pvBKcIUAN3CUQZedddInev1BpqZCUB?=
 =?us-ascii?Q?0Ot1KOeYYG0VuWHqn8rIOChHSeHOygPrQs6kilNsev83LTIYOJUZwvmsk2gr?=
 =?us-ascii?Q?8t4qQRctQ0lUUAyh0ot4YoR9BIFCe+UQi44alE040G4ko21YR3CZMFJoEdve?=
 =?us-ascii?Q?ZioMIAtDQE8TjSR/nlB7Pyie9k62eSsQ4yXlwp7/bp/eRJNuKP7dBXHDaKO5?=
 =?us-ascii?Q?qkaFBRoaVAL+Kq+Qwjvh7CrOeJnCH/ykVq7OrrBd1TxopianK1ggQZyJDl4o?=
 =?us-ascii?Q?ZiO9T9C6SqpPSkFBrsducTeMzoi/V2+B4Vcitas+0h4UB8xo+MEqZaSXlBUI?=
 =?us-ascii?Q?ntdnfmN+O48q15ISfDa86wUduA5dQ1LXd9i02fzCXyU4EJRDVmf+DDPLEpHE?=
 =?us-ascii?Q?zJmaAFhjTpPzbKARg733zauYRLuBdyNlZjBCcD8fLAljQi0pD85n+47UAy1U?=
 =?us-ascii?Q?/X+PxXDn1FAf8ZA6KSIVc4zrOstCV7Q2GK0fvFs5v3QqWBTJnM6G/XhESSFg?=
 =?us-ascii?Q?KwgDS4x9miG3u1tV8rl7w6z+ncO+wQVktLQtKW1U5tN161DfwOCmSl1pOnIL?=
 =?us-ascii?Q?vAhhKcLg4nPYTwc/IdjvT3Z4VRpG/vXVp9UbiA3uRY/6nB7YG44BkS8ZSYpD?=
 =?us-ascii?Q?ry4Dp/x41PJpOqo3rIuO/JGVCWH5O1OBWOIDjy6kzeXqXST9mfMMCH33mAGj?=
 =?us-ascii?Q?+WDK7y9LrFevN853au4/Hr2EBY4q8Zr6XTVuYGt8Wq2WT5y2jSNXnq8VvOcX?=
 =?us-ascii?Q?xHKTlKRBaAvWWqqHfOVsyvG6abekkSCfjIxE25sz21XgICXPTOwlwmGaYJNV?=
 =?us-ascii?Q?vLBpDV6ZeGbYEP+GkQ7J06Tbi0jQmj5uk9qHoshmx9dfPFH9VLpE1jHIicz1?=
 =?us-ascii?Q?ep49WGyuLb/zLCPMC4ZgflRNEw2FJsiIP1upuARnxJHBUvE0UHNyeu8ooc+8?=
 =?us-ascii?Q?Ax/RHnub8AnhRMvL1JW98tx6ZJX7r91tJX8c8jRwrbyGLvIxV4njNwdTreTD?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mdO891Wlqi50avwy/lziVlyT8pCF54xfBEtpmAZirxheCaYAbU9f2K0iWbSqnsmWSCF6LQ5SU2LE+qrBIfYLVd1AuNNtIu9VNBvTXGa6VVHB118f+GYVZynXMmOWjcsnJe9QORfTCTxUBP6/c1P+4Y7x8j9RcJARWjNcjGxI+4CxLt0qKBnih9lt26tivXRxYsg7LfZnV89je7mZwYtp14gHniJII8xGEou+fhT1Ha1Ec352dyvLciAbo780VlVJUoE/VWQLajrrOu63tu7hrxdif8aHW4vGupEFHm6KE1XhQClVOabNtak6rRKHMU2Ucchti6LG/j6qjWeqejNLg4GDpWVFFJJyGoFNssT6+koNSm8mR1Xq9IDNQ82ClzmuOhvTpKaL8k15okN3u3yq/pR9bspdQ25+SsN0mLGFE9oVqUeGvUdVn/MwqemBxnO4WQpRxnwqUrYCeTAurHzlkmousHpW1ejzmNCnUqOxuYqstJjx6KbSn4NIMGN1OX7VTQLOhEF52MTlKMGN2V/0xlCUgHeqB1VHLU/hPIDO1BHw8TSiZzjYDe5RPDcPn42nHhaiGEGecvALeUFm9Zvx9H6jsHugfy6N6rwU1BUYp+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c3a66b-ec42-4022-aac1-08dd0572e70f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:01.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QvdMIRwf2KnbOHA/hzsak6GdxTsbhMW/9c1OCCq5fwvnlMqlfsNC3Tb0/06Sr1jhgSwQc3Hk0lEXWwQ6QY8e5aWHWhEvKmAyOVKMnVSj6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=565 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: 8AurQLQQIhc6LIuDbWAd6hto8vdhI_zY
X-Proofpoint-GUID: 8AurQLQQIhc6LIuDbWAd6hto8vdhI_zY

Critical fixes for mmap_region(), backported to 6.6.y.

Some notes on differences from upstream:

* In this kernel is_shared_maywrite() does not exist and the code uses
  VM_SHARED to determine whether mapping_map_writable() /
  mapping_unmap_writable() should be invoked. This backport therefore
  follows suit.

* Each version of these series is confronted by a slightly different
  mmap_region(), so we must adapt the change for each stable version. The
  approach remains the same throughout, however, and we correctly avoid
  closing the VMA part way through any __mmap_region() operation.

Lorenzo Stoakes (5):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor map_deny_write_exec()
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h  |  10 ++-
 arch/parisc/include/asm/mman.h |   5 +-
 include/linux/mman.h           |  28 ++++++--
 mm/internal.h                  |  45 ++++++++++++
 mm/mmap.c                      | 128 ++++++++++++++++++---------------
 mm/mprotect.c                  |   2 +-
 mm/nommu.c                     |   9 ++-
 mm/shmem.c                     |   3 -
 8 files changed, 153 insertions(+), 77 deletions(-)

--
2.47.0

