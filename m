Return-Path: <stable+bounces-223455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN4lD7h/rWlU3gEAu9opvQ
	(envelope-from <stable+bounces-223455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:55:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42F230815
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF50301B70C
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078EE26C3A2;
	Sun,  8 Mar 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="GcwNY9W3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B44257448;
	Sun,  8 Mar 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772978081; cv=fail; b=R8AHc9utkAJI5O/SWI+5IyDnauPZxrOXf/4vT2tAkrY1yWKCsFuO5YQypA1YHO/OPg4emhyx52gkmJmJYj3R/8MPeheSsqRIGbUNIMYmGv1mORA25dy6ODX8SLwRkK8VM3e2FmaLU8xsO+tnrICmJp0vkz2SEdRcf2fQxwI46kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772978081; c=relaxed/simple;
	bh=1Pzd2blqsQR4RhpjKqvZ9B7LOHgy3Fj7A0wQ+lrYA+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEYvug/qhHUqse3VVyNKMDJWsr9y53ZUfv5GsMGI3oOn9JgMnsN+RE61wKeJbRqdbFBkpuioynYk+/DgFYzUYw3aicJpyiu+IA4pwTUpCTYK9xsIVb4B2v/SsAQvgN+4LKXuTxqQoTUolbaIO3nCbwX6vGipdGWaZuAl9xQYeFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=GcwNY9W3; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628Do8XG2500988;
	Sun, 8 Mar 2026 13:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=O7RLAQYbWBUG48Aitf85vEiFVsdW5GRy2p0qy35+Rq4=; b=
	GcwNY9W3N2DWq93gw++6KzdMAFZz67phisSDQj5QJ2Wr75TR81I0bR4LTEkCS4oS
	hi4DCma1Gy6pUPpyWRd0M/eW9MCmWa3BygJGRe8G3TtQVQ3l2DHFo26D0AvX08fy
	oOXZjYal9Cxre4if+Fdg8QaRRBYDAm7IehgDLwpUuIAOyMZ9rA38vOS2gzwiZeIO
	lK7MoSFXGbeNhrioZzY6EJwjFOl9n+vGL9XMcTmgTAMv4SwskVkbU2XlPqPRxkRa
	SDgfhOyVIceAB1tRB0o3pdmBczi42cxTQr4r92euNe6c0Li0Nmx4SvzheJPs5jlq
	QRp9EkecojgZJ9iJf5bKiw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb0810rk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 13:54:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpWn4LX0+lC2JQI7jrotb4v+65i/Zc4LIVtvgWfeGVpf9sckYW+lrkS4k9+HscwlTZF0sT9LlGF/6bncpHufsP0L3zp0iwx1qWuK8KM3q0a3pGW/lDXJ4jQjq7r9JSh7TL1QvJsMsIFUKGmShZU7ut3OyKpiW/FgaonQvSJgSIqDtxcE/tJNUycigL53vZe6CybVINDT5VXOzYsLmQNfMlf9m0hF6KtoAQPWiu89fuF8HJWb+ebGiubNKgsp1905hzoBM/4NVRoRLXlddf3C+s5P7ARIB8oo6oroIzzIjkip8Kb3rWa9Ex2X0UZRFK6VoEuCsfDosnZfZ1Rr8FoIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7RLAQYbWBUG48Aitf85vEiFVsdW5GRy2p0qy35+Rq4=;
 b=a4jag4DVveZJhbcduFdAddvdl1pB5qE6cRePIPVYfhiR5LGR4nawkZny2fFMIatBjXjvR8Od85pxXMkOM/uLWKHClgcpvMm/0y6T95kiS+wLredJPih7cAuIiQdlcCZ/dDTdPUFGeaVSQd4oH1+8po6ywAHfXRu3WMdRetCmuSacHiNoQy9QwgJYjonyEbI/G13PaFKEyVKf+2h390+Qjd+PAchl6PJl5jxIjFUDNXYstlkwwFy2zBM0Tmyfy8l/Bq/UKpMZ4daxWGZKqil1YjRbKlF/LTaJbk4u9fiNq6m8vzMPjpa/b/fS4E0wGXkUHwT4NHIWMkr+ad2tlY8fOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Sun, 8 Mar
 2026 13:54:16 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 13:54:16 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v7 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Sun,  8 Mar 2026 15:53:52 +0200
Message-ID: <20260308135352.80346-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308135352.80346-1-ionut.nechita@windriver.com>
References: <20260308135352.80346-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: e417bbd1-1517-4b60-f8de-08de7d1a2ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	5XJn1wBy0FiedHUC16/8s1C+OuFfsevvyJsVJXlQr0X+QocROT6JgTQ3yUTtt8MJFzFbhNwWFZSPEhmlIrKkPAvd2iLwkvJdw1SBUz/J1qRZYluqVTBiWRNaVwkGnmCJeNDTSl4gC+B7WG1u6Y7zIi/62kzB3JCd7tBPzB3R7yOYm2lffpp2Q6cFKhznPl4ms78VtSHJiCeB/hi3W6NGenUHs8SuG5k+oYFEsCnB/kVidY7Z+pIh992xLzuXHR1JUe5B2CIBOGnTxzgTGRdtzPs1j7E4LET4I1rjd/WViULxUsv/G7Zlk2sIukJuKqRVquxLs4aRnnYNxkzPRAfPzMlT4M4HIZLwxruQX3E8zM7Zoiuc8t8WUKUaodnv4M/L8zncte/YRHsUum94t4338dHzh0uVMpaPJHL8tcHJsXQcuGAGwMWrPDzPum/O5RKKjSCxF/ktRKo0QhgJj3aZGmCCLOy4o2k6P+homiEWmfyJUtO0g3QhfB0ahTVKEISiorjbKAAselqlTDD5lMi9GmSjUCN71BmMyNv3+/ZRJXwRhEQGm7+t1dGloiHc4DZbyj+Y30fmmEfSCfkTmcLVq/dU9/0EVKx7HaXtXl6DuBzH5qHHGm+cyvUOczgXBErTo0y7ZUj1CcNq2qnI8k3RT2phazdpmC4DsZq0XMmtqci+QLHAGraFFnP3mvlbX3bTX5RRhciWwhXaDVEgh5Cob7cLg0UqPrTKVYqd9FcZi7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+LFxwhQqaaz8Eyz5UCGuDw0XUZDEU7suNuwAeFRyaH5m1jlACi2uGIMotn9?=
 =?us-ascii?Q?PWInIqfuuywIW13uZWfdZRHqF4VDNT1BAKfGWhcms/uwYdJ+gxNnDlUk0hWi?=
 =?us-ascii?Q?b8lyCkItdkWCR3KW63jOvfVhZr3QyvoS/X4487q4i7qhFYRpA/wxV8q2Uc15?=
 =?us-ascii?Q?zJ4sIyWzAtpKhZl8kSwusylTbJ6pS5SOOy8BhAS9aE0919OR6XSWXCbCnt72?=
 =?us-ascii?Q?8Vgo9tQ9h6pRboFROg+c9tgcppUmtYQ4B2P3aEO2GpjY4XHWYfJRpY8ADxJl?=
 =?us-ascii?Q?X4RGeksT9akijxovDCRKgAyUGQd6RrKt394ipzzPZ0df9EXD8r81uGssTKvL?=
 =?us-ascii?Q?xVei60/7zKvibHq0sPz++NJj2NhNaQhEfqJMgcrI2U/Upa86JqDmrgKGFPtB?=
 =?us-ascii?Q?JZKx2bsO+UHXjzJt79cQgFnfGA4XnBKtBEwrvux6RY9zpC5nQ2ithjCLzhur?=
 =?us-ascii?Q?mbBALhb57JlQwKpRRQhClvrUiV2iJjN3WuZQW7Ljnxi4wlNsXLx8luckQYGT?=
 =?us-ascii?Q?1CYL2fs+iLKmolXQmGE8mt/0ZQgAvWYTwaalRiytWohfFyiO37inZz0zJBON?=
 =?us-ascii?Q?bB9BU2wDd2IrcvGJdAACjefTCiSRLp2KNkbBtOkEyXHwbtCNLDiFF6/f03Ks?=
 =?us-ascii?Q?iKtlklXMWlm0wy5NbknbnPrJdNPxkxDojDlxUksun8oJY7VRtK1OrPtygeby?=
 =?us-ascii?Q?3KvJLxIysqTqPXF01h8NXamasEZWBqQ8SnVbdG4lRpCVVimiLkxnkBb9ry/I?=
 =?us-ascii?Q?IDaJL6KqphUXKmuDph1eHm7xECKuIR6DdiuCmE0sv/nTmSRs5QvYoBEX6iAw?=
 =?us-ascii?Q?sKIvNpr89YdUx6z6J5xWD4EN8EfXtAxlgcPY+yrxC8jUUdR9GQfKcni59TBQ?=
 =?us-ascii?Q?cHGhM1biBGf1WFjpFVrfxtB24HWEJk01Jzy+LiIqiJsF2zG3HOs4rtmZts5m?=
 =?us-ascii?Q?qyel6vdtJAnx5I7wYr7FM82puUe6VVzg136UK4BY8YPLqsQid/HaA4h/Xrsc?=
 =?us-ascii?Q?4dG+0cKioTwJvjqnKEllOb63dL5Cj8tGuH+kcc3+y0gohksbttvCtOwlbCY5?=
 =?us-ascii?Q?Wx3KcXEd3ULeYoguZQDNNebs1IMygDutQ5L2x/e+AtGzMERrd89jMqwgqBSh?=
 =?us-ascii?Q?9WuTNDhQTu0cE9mpcp8IRbrwz7cDDnM4/aDf3mQoGJk8cwQxUUoFlHE+b4xG?=
 =?us-ascii?Q?rUH2VnkfSSMEJJUY2pNqQB0/jVRqV0X39ehZwl+7jLZhi4NJ9FZkBbzAH97s?=
 =?us-ascii?Q?cSu1D85XB67zI+nSLf6i9LQWkz8AUo9Seobzt+W1axuDjJR8y3io+Qk8LBqo?=
 =?us-ascii?Q?GnUrf35MvcHnAZw3egFv1Sb60qmD12KHB1fpGKIhZAoVESfoZSX/k8Jol8KN?=
 =?us-ascii?Q?ajW8qf1FMrfx/DwGI4wLa/ajuEl2jGLUW33+HlAp8X+FzWSUpL/m0oWOMpsy?=
 =?us-ascii?Q?J6dNgGDzlQO1cSLinef7SRr9aK7O4rTQVlz9w52sZ+lvJUwXuglmK9/MEHaL?=
 =?us-ascii?Q?FFo/LKN2se9H47BemhWIGXxAccd6aFG6OmCNIy+WhZAg11e8oN/Omt0mI+60?=
 =?us-ascii?Q?86qki2s/KX4q4rqjHrYCQxQ4TyAkNgYSjH8oqU0d96Oh4/9rHfJXT6TAcKAH?=
 =?us-ascii?Q?yRcJNmM1t3mCNRn2oT6waQY27PswyYjqt7YVlTQY0rJp2Ee+d7Ta1FnedQch?=
 =?us-ascii?Q?zFuD18zhXCO6uXPPAg1LPVLTaZjUHeR2EkR30tZ116cagjhBEMXgC3xK6ANF?=
 =?us-ascii?Q?cdl3yhi5aIlFa8rygzOs0dhTcxSt6kI0ZFU7k0PaHWCUqcHEZX2RhB8WVkQz?=
X-MS-Exchange-AntiSpam-MessageData-1: qH7RlDGzfDOJx611rrkYePezP/wIsWgYWW8=
X-Exchange-RoutingPolicyChecked:
	QZD/lO1y+NHEcpsf+zpTySjRjrmGiEaiTO1ZclvjkIIGNofz4q87+B+Q7NnQeS8Dv/f7OWmorr9GFpg3sYfEgY0hohGDhnvTdWO5Ol2gcvFT6K5fWALolNK+wmSGmPtqJMOpDj3OA38ri9TX045bvmcKY1ubY1P+pwZ3CWQ5v+tXm+kURimSTims8nqNMa9jvThSyl2n9dYWvyhFQ94b8b21jPfi8z+IHqYOmiOkX0t06i/W9yK7HWTE0ylWSxjknjeIAdlb+azU+aX0qSEY+y7/r2DnxxQraU9kO2SJykE2zk9Vhi8Z1YlcVJP6hPpEDdv7UPUQb9RACGTrrMglVA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e417bbd1-1517-4b60-f8de-08de7d1a2ff2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 13:54:16.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8F/ZzATGXOyfjTy8QdtzLZkZOKmJ17XdhKvfB0CldJUsER6VEP1ShpmNYvzrKteYGJ0Bfr+pWpzo7mMWK9RICDyyzbvNORLEHzDFruHWIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-Proofpoint-GUID: 863tAfhrd0cd-a_UNS9ikcfPzbuv201d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDEyNiBTYWx0ZWRfX/LP9FFiOL1d2
 JVUtPVSIQ2iFyDsTpT4/tq+JWlx4UAEdh6QG7OOAY5bRYU6ScFZXkormkC0BbA+8pxJVK95P1ox
 GeqcuB/boJx7bwg3Z7Tgj02y01G/UHSxVuR/geg2NKfKL/yGW4Aimk/OYydFwdo8UU6Auoonx7D
 e8od852dEK1Oqsml4tiwq75kfhIgDe7Z/dtShPHGlD2iZFvmDVS9OsQS5QmaAClyMP1LcdMyi4F
 e8T4ADDmSz+ioTbvY09s0orENKsNiwB1kHsgdnQLcHvpygf+Ydkaum5uFJTlKrwLokReEfaOkh3
 QlJklVX13l4MJeDPti5H8PxezkAriSqZHBAxy3UbjwR6mKgBkhyW1PCEed4Hcobs86JSgF0ESUv
 EFyycy3aRsdJTibCsQthHGr7CdW5FC0c/4ZApWbt+8OSEkB+KZZeI/BmbAVaWPPZn3oGyo9SX+9
 /adABMCSRI8dyy/OJeQ==
X-Proofpoint-ORIG-GUID: 863tAfhrd0cd-a_UNS9ikcfPzbuv201d
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69ad7f8b cx=c_pps
 a=BcPl/o76WFXIZ3b3OvynCQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8 a=6S3VQf3ZLieD-afqmuUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603080126
X-Rspamd-Queue-Id: AF42F230815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223455-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wunner.de:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant using mutex_get_owner()
and a reentrant depth counter, as suggested by Lukas Wunner and
Benjamin Block, since these recursive locking scenarios exist elsewhere
in the PCI subsystem:
 - If the lock is already held by the current task (checked via
   mutex_get_owner()): increments the reentrant counter and returns
   without re-acquiring, avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, providing complete serialization.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the reentrant counter if it is
non-zero, otherwise releases the mutex.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  5 +++++
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..aba2fb90759cd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -633,15 +633,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +769,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..ce4d351b5aa21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,16 +3509,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static size_t pci_rescan_remove_reentrant_count;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		pci_rescan_remove_reentrant_count++;
+	else
+		mutex_lock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_reentrant_count > 0)
+		pci_rescan_remove_reentrant_count--;
+	else
+		mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


