Return-Path: <stable+bounces-227619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMBOBAiyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:46:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B57A2E0FA5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E103070B2A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14418364927;
	Fri, 20 Mar 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Cbo3Fq63"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519E35E95E;
	Fri, 20 Mar 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039550; cv=fail; b=sNIqBirJNElwr4sQ/KB/YWmecR1bhVYXt46Gf/g+/lvXkmM9PwCR9MN8OKkIaMjCxK2Cr5ZsKqDYEr7eKJ1aACPPsbpCZ+bypAOBz7bpQe12sxu2FsxkbL3L3oQzZkNvI9hFs0phOORid7eyP951EuZbQFHORunXDIhsLwmDfOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039550; c=relaxed/simple;
	bh=bomf4Tn5t4fXBnPtAhVrkZaBQwMrwu8kP4RBiJYnyXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxEVcVNbl9ke/W5hhYjlXafRxTQ3EVgnwcZNd0nY04YGz9k5iVd1oqiNWeGv9qreogMgiVNmygPKNBKzliImD3vvF+gjbmsXz8TyY20tmmwY1q1hdhiEjkLQWOUytL4yOiEjTlrM3r3JFF0lHp4CbMzIywNnFAZBF6uR97OEvE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Cbo3Fq63; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K7o5mn866812;
	Fri, 20 Mar 2026 13:44:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=M7ufVu9GXPrexYPW7e3H5cMGDNUC8ezbBQQCxaeqOSg=; b=
	Cbo3Fq63DNX9umV2FHlaaHJuHkelpnj5bpbhhI5wN8uraSu5XL0CDpofsbuJL01P
	S+4+CWPZA6wFpADdEtbrkoznF2PyEcXoS/mDhzzClVIEYkmlqi1a63M+8HeBNcXA
	Z89/nobJIQOAwfFQkuG9B3PrUyjRZJ26aWXaMfnHX2bA/MS3+/CPlujQ3PePK+bV
	1AqYkH1x0ozqpE5Ge9PGv/AK2BBswBiWN0WGzCzpI1eid8EcUP0yrgCgrpyZWaWt
	rrP62wA5Zzn4pi+DePuGBN7JYbBM7u1quo0u0pDJtW5Vs3/6qugrGRq7KbjguVVS
	zFyJ+cB6Ag8YTRkPjXYgaA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y18k1r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm2NCxsF2aMKCxIQtM7QB1Dts72zTioUuxsC/CuBtk/UODL1bqReSXxQ5UT7pMFAypSryklXhkoMLR8+sEk8Et0T+Xbe9+adRGKUpEdxkC0XTHvFerqlHb7XvehEpEDlD8x3Bbonf6tKH0dF2qz/VHX9iUzw/E6j5nBlQH95w3HIAj8SI2WFyKOCxqkOI5zUU0DL1ABubR6n7nZs37o//e2y2/JVVvnWFKxoWY8praXJI+SyHCOSc82LqhQVpTY//sDbGsjBC5uRWithUc1kUwBOrsURZmyUHjknNgRoTpr3wtSPkH1XWSuW2rVTI+AlTX2GyY3uB6io+YHBrpWZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7ufVu9GXPrexYPW7e3H5cMGDNUC8ezbBQQCxaeqOSg=;
 b=LdXTH9N3n9OnqL3ic290S+hh0OX1rHoCuU2GVQJPA25QB0jWpLN5zCeEndSC/yB/ou7M/+CaMdumkRxYP/62m4/0yUOLwqBwEnCt0dDVg3YUQ3Fu7GysJDe21O2vifwaSu1QjOSmTdf5jczQhK82Fz30KlbHJAccKxEDPiMDBWzOW265ibhpXoE327xDlXC+AztY1rpeu460KzuBmQAqtEop8XH/CWKTLYBo20RSoSSOMu3IuNgtGx53b3+1DPwm9iNmo5W4fGZHmjrpEgl4JLEGQhrsFSQNPrGWjkkiGjDLDw08D8PYHpD1jTC/ZANfgJnR9CK/lOatBNzBV1hDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:44:58 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:44:58 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 6.12.y 2/7] timers/migration: Annotate accesses to ignore flag
Date: Fri, 20 Mar 2026 22:44:37 +0200
Message-ID: <20260320204442.32901-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320204442.32901-1-ionut.nechita@windriver.com>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b04b361-f118-445a-e482-08de86c18c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZERxzb9m3mx0Ozt4fm3e0q/hfc5o2zEjwVFrl2K7QVAjXsfnYk/moooA1WW1JwA5CQGa5I9YAOVfpv1syozud0um2z8062Fa6B7asW2nf/+XyP2E4AGNpwfTEra8lJQHRVjTpnXrBa9AvWig5R3jQd0H8wQ5IKhEfmzPZWlcS6fygGkgRIbPxMIhVwC3F7301rRLy9KKMAjvzK9Bpi0U/g/3WehAAMzq/g5duGmFZ4rvRqBtk+FOKy1I+Cl6mZ9obnE+rpYOJngWl9FQX0KIH5yFGUtMkY2E0g6bCzg5bemiqZ4TmBBzBq1KUYUoHeJ43mPVycDau4LGPhwtSasHGnUqUCioPFqAHCkvcr6Sp1ThyzDsD+Ezu3GbQ27gNSQWBAkKezDFU/AeEf1WBhHbvR74atmoZDxgi3ewzzLZpfTh0bwbz2+va47VqyBletuPGbvm1w+pcJLom541CE93gvrLik69b/nEJRyzOMoJny2X6eXkab3n7Zw3aTHkWcOHSccJuJCiTxI/Oq4WuBNQ93hODbbpwRoYfdcVMjZHYjznJbiHbAbSFz6kbpZzfAGNE+8Trgg0590HPdImw2aQtDdkg0QRZZEDeqrHYDC/MdtC+QhBE8s3JE8gRYtGeeDbQa5ZAkM2AqqG2QjZrKmovIpOLvSJp+dHAR/vgdm9gkSn3WsEUReymtHnaJGpzoChqDkshxvdF6IgVkMZVMUnAtN/zTyvXmtoN0/nmjc64FpR1edTFf1hz6jckEFvWCrK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+S9xUXsZVb13zP7/6VeiI7IUmHHhWFRq7N5GMIM5yKcOaMzg4aOy1IO5X5W?=
 =?us-ascii?Q?3tlN3A8bbGlScrKB6/F4c9B6BLkbLoZcFJM0d1xvDHN8fWjjamyO8KPmO7aS?=
 =?us-ascii?Q?H0YLYjooFxH9iKGGKXckBYbz7bmgcjUnDL0gRxLGCX60nJqQH+gmNag9u3ti?=
 =?us-ascii?Q?xO3GbB9FX0Kcr0Q86PJH1deCsMUz1/PnWrUQ45IDRJPhhVm2SwQ4oajY6Vhv?=
 =?us-ascii?Q?Bc882CrR3w6AIFDPaAVGOfS3AYWWHFpzErK0g8XZZ890hbJhAlS/5pze8Uam?=
 =?us-ascii?Q?iMR4xj7feB77FATJkedUWJrDzvw+o/vnM9QLNm/VU98NSefgd7eebE6S4mlY?=
 =?us-ascii?Q?EuzfaFfW2AS6mLncg7rWpukHltjXuEwQzs13srApeEnMAuPs6c4uWERv3d+5?=
 =?us-ascii?Q?Ln3lovLnu/kp4dYSakLtlUD/Z3JpmA57bvnl5eNEcpYg+rjlHsMCW7AtqSMK?=
 =?us-ascii?Q?/pXvxZTJtPrhdZ4hCspYwBxjnq9SqGgbP5liCvIb4y5h91IAQVxSaAYe11+2?=
 =?us-ascii?Q?J464aZYaPuqzd6BMCRXQKHsI33r9vHvIMpFHMhPIkR3JJqP2N7J4YwDN+2nx?=
 =?us-ascii?Q?PqoJFG437BSmau/mZSKs32vGoI0WqgZLeP5MM6NwC+gsPJS2vcLljxnYE/ru?=
 =?us-ascii?Q?rkyaVh8sGR2XnQSUmH0wyVV29eDYjPv/FOlXFbrq1P0VCs8+nwOLehuOeB9G?=
 =?us-ascii?Q?GUHLsLIa2YsdcUMETHkUWYdt/trvkXY7uGZgq7+1fZq/vBi47+kY5Ps2MSOa?=
 =?us-ascii?Q?3iW79JrnxflI05zt+8a1UbbVZpfYQrp50/Lce2epbbQyU5++aaHSOxJWhpPj?=
 =?us-ascii?Q?MoTe1RPiUPUeDQ1P07mj46T2PfYRuwYLBniN4sXbQlmsNGWPLKsJ4KfJsVzO?=
 =?us-ascii?Q?Vh4jgEo3au/qPgezcc8Pp1gv2QZGJbw1Xngi28ai2QsTGH0umpalQfgU3xct?=
 =?us-ascii?Q?r6l/EwPrN2eiuBCYAk3nAonlAH+K3cYl6dAOyXj6EU+f3vYrhQhOTeQ920Fg?=
 =?us-ascii?Q?JbOieITjwdh9MiT6+eNFVEbbQrVbVL09ZElgkOldlwprOdHywUmTBj4QJysd?=
 =?us-ascii?Q?5j8AyRCL5EcPrJk6sRP1SDttbgfyxh81TF4kn/DBFaquo4dEuqFzb0TO8wSa?=
 =?us-ascii?Q?8mxepAENuLUiRCPM8a0622wtM/TTXrPAsMAega1EuXQJWPY7moN9wEITDpBz?=
 =?us-ascii?Q?9aYbDLNb06dN0JKy5hhlwu9IE6Q3zQwn4fst5bpSO3z6epb2DLprvE/HtTLg?=
 =?us-ascii?Q?6uvuwgxV1EHbKNlWJc4/NCEsWwrzT4TbvxhlIfJFOv3yf+5Eus1b+j4Rp/z3?=
 =?us-ascii?Q?oEWccxN8vz8RjYj2+GaZKdblx9RHW3WmZT+wNLgKQTSiV9BGPVkCtPoB0bLa?=
 =?us-ascii?Q?PluDsx54MdDSYTX4ca3sjQnYKxo0+raG+ZyELwhEJv3In2iWGX4poxzOfJVM?=
 =?us-ascii?Q?kDk3IkgfQywGd3YgxbF6lpYYP+YZXca2C68DI40iZda2QzDReEmvZq0YBNDX?=
 =?us-ascii?Q?t3BjdboVAHFrD34rY4hHuVr+ShtcZVV9jdMbSkBZvSSQ2l8lkseJjdaZl/sa?=
 =?us-ascii?Q?KKZQk/ouDqeq5QwhxeVsVBFCDK2Iq8ahuNewqn3XzBKF8rHKYfbuZIOxbC1x?=
 =?us-ascii?Q?0SwVBu0FX5HSwkShnlXH2aHPuSlWCxakdxFBo3WqXPQ/CYDvgifufcIKlq5F?=
 =?us-ascii?Q?VDuTuYwsmxfTZlLnCfVOFH1xBJt8tT5oc26+oS0SL0C5yD6uuNGEjFEU7iH0?=
 =?us-ascii?Q?HONFtmL3MNysn2lnhPa/Z4qL3CpW2HgS9mU9H7JBrwuMw40WpGDBVsfZAe+i?=
X-MS-Exchange-AntiSpam-MessageData-1: /V/Xm1AzgRj55Lb23YDGNd5Qcj0rXWbsGTs=
X-Exchange-RoutingPolicyChecked:
	UO4NYpapfzX1mqDTB8Yl0SU8ZpuUr6GYr05yeRzu+uHeGUSHlXa7k7aCKnVkZk1Qx2ibyYsbNHeWwmw6q7N6BzQBBTNlP5Sc3FcwZbgPiEkJq4ZkvDPxum1/Q7QQ1aSs/2PWuVgAtPVaCOz8Ukv77Fu+1hR+2yH7Pg+gZwVIfaCRU4PysYAi1THG/kO9U+oo/8K6hj+2AmFgzoq8k0JnokluHzEvXUz7q4LQ4eBUBatp30pYXCVzxBNGhqL3cawJnzKhdH3rZ3AmzdPcP3bUiiQ57tLjlb0EBfGP89n6LnuKma0caL+H/6U/ur/g75GutDDodrITGpYQ3iTNzpW0WQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b04b361-f118-445a-e482-08de86c18c96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:44:58.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cujCmCTOl5yw5y0Jz4T3UQRQAmDOr/hWUu5eAH+ILsfgI3lrE+CWbQS+iEkHDQDTd8S3ZXweQCZZO0s9+WKrZTs0Dt7X51iMB5OyoGeJO4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69bdb1cb cx=c_pps
 a=xkZeeFpQnwfNeFRS3gkPQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=cDCvB4DnJeAfrRTg3j8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX4rooyvIMk5+7
 vEwpY/xg+y9hIsT9+HPRAAFoUOJhSeUswcZ8h/rYWfB+qK1WT00gVdM9twF3Doq28yuflrBHsmT
 7LR6bltnNEP8cGZrRs6uYFlj2T3R4WBKVo9NSN2nk8fBJY52hyJZVXQKWETHhYxXT4YvW7pae3G
 zcm7NYHyxTyJykZNKubaZBiAArqtrx1krUVmbp8SoGV3woR4SNnU90QxwTDrA+Gz+mVab5R7igb
 8C2deLlsns5l+jWUAkNkcp2Iupol/Wlq8Rw1lWrSGrm7Enror5kpavk8045N7Z80mSI+5572uE5
 L2+1kTBNFd1uiYSo4D+Bxzntz2i/fghR9EwgOife80cv/ne6vA9Ds5QdWsofuVZ0WurYcchszM1
 u2VmgOOqIqtXPVov9I8YePH2Vs59YmtT0KHRWyDsCZKFAzKDtvXSE3rUkl6hmb/kft1RQ3ZX+0S
 sLUv2W+IERBBvgiq8rw==
X-Proofpoint-GUID: 3WKcZcPENUywTxO80HtTyTnax8OjnJPT
X-Proofpoint-ORIG-GUID: 3WKcZcPENUywTxO80HtTyTnax8OjnJPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227619-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,windriver.com:dkim,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B57A2E0FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frederic Weisbecker <frederic@kernel.org>

The group's ignore flag is:

_ read under the group's lock (idle entry, remote expiry)
_ turned on/off under the group's lock (idle entry, remote expiry)
_ turned on locklessly on idle exit

When idle entry or remote expiry clear the "ignore" flag of a group, the
operation must be synchronized against other concurrent idle entry or
remote expiry to make sure the related group timer is never missed. To
enforce this synchronization, both "ignore" clear and read are
performed under the group lock.

On the contrary, whether idle entry or remote expiry manage to observe
the "ignore" flag turned on by a CPU exiting idle is a matter of
optimization. If that flag set is missed or cleared concurrently, the
worst outcome is a migrator wasting time remotely handling a "ghost"
timer. This is why the ignore flag can be set locklessly.

Unfortunately, the related lockless accesses are bare and miss
appropriate annotations. KCSAN rightfully complains:

		 BUG: KCSAN: data-race in __tmigr_cpu_activate / print_report

		 write to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 0:
		 __tmigr_cpu_activate
		 tmigr_cpu_activate
		 timer_clear_idle
		 tick_nohz_restart_sched_tick
		 tick_nohz_idle_exit
		 do_idle
		 cpu_startup_entry
		 kernel_init
		 do_initcalls
		 clear_bss
		 reserve_bios_regions
		 common_startup_64

		 read to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 1:
		 print_report
		 kcsan_report_known_origin
		 kcsan_setup_watchpoint
		 tmigr_next_groupevt
		 tmigr_update_events
		 tmigr_inactive_up
		 __walk_groups+0x50/0x77
		 walk_groups
		 __tmigr_cpu_deactivate
		 tmigr_cpu_deactivate
		 __get_next_timer_interrupt
		 timer_base_try_to_set_idle
		 tick_nohz_stop_tick
		 tick_nohz_idle_stop_tick
		 cpuidle_idle_call
		 do_idle

Although the relevant accesses could be marked as data_race(), the
"ignore" flag being read several times within the same
tmigr_update_events() function is confusing and error prone. Prefer
reading it once in that function and make use of similar/paired accesses
elsewhere with appropriate comments when necessary.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-4-frederic@kernel.org
Closes: https://lore.kernel.org/oe-lkp/202501031612.62e0c498-lkp@intel.com
---
 kernel/time/timer_migration.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 72538baa7a1fb..0707f1ef05f7e 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -569,7 +569,7 @@ static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
 	while ((node = timerqueue_getnext(&group->events))) {
 		evt = container_of(node, struct tmigr_event, nextevt);
 
-		if (!evt->ignore) {
+		if (!READ_ONCE(evt->ignore)) {
 			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
 			return evt;
 		}
@@ -665,7 +665,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 * lock is held while updating the ignore flag in idle path. So this
 	 * state change will not be lost.
 	 */
-	group->groupevt.ignore = true;
+	WRITE_ONCE(group->groupevt.ignore, true);
 
 	return walk_done;
 }
@@ -726,6 +726,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	union tmigr_state childstate, groupstate;
 	bool remote = data->remote;
 	bool walk_done = false;
+	bool ignore;
 	u64 nextexp;
 
 	if (child) {
@@ -744,11 +745,19 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		nextexp = child->next_expiry;
 		evt = &child->groupevt;
 
-		evt->ignore = (nextexp == KTIME_MAX) ? true : false;
+		/*
+		 * This can race with concurrent idle exit (activate).
+		 * If the current writer wins, a useless remote expiration may
+		 * be scheduled. If the activate wins, the event is properly
+		 * ignored.
+		 */
+		ignore = (nextexp == KTIME_MAX) ? true : false;
+		WRITE_ONCE(evt->ignore, ignore);
 	} else {
 		nextexp = data->nextexp;
 
 		first_childevt = evt = data->evt;
+		ignore = evt->ignore;
 
 		/*
 		 * Walking the hierarchy is required in any case when a
@@ -774,7 +783,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		 * first event information of the group is updated properly and
 		 * also handled properly, so skip this fast return path.
 		 */
-		if (evt->ignore && !remote && group->parent)
+		if (ignore && !remote && group->parent)
 			return true;
 
 		raw_spin_lock(&group->lock);
@@ -788,7 +797,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+		if ((evt->nextevt.expires == nextexp) && !ignore) {
 			/* Make sure not to miss a new CPU event with the same expiry */
 			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
@@ -798,7 +807,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);
 	}
 
-	if (evt->ignore) {
+	if (ignore) {
 		/*
 		 * When the next child event could be ignored (nextexp is
 		 * KTIME_MAX) and there was no remote timer handling before or
-- 
2.53.0


