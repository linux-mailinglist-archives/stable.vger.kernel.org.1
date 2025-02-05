Return-Path: <stable+bounces-113977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD6A29BFE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046973A7963
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83752215063;
	Wed,  5 Feb 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iTRpva09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vwsgPIVR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7621505D;
	Wed,  5 Feb 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791658; cv=fail; b=YrpQv/uTrzXFUtvM00o0e6q7GkWZDSdgljyvZ7Z0GObO9Uar6q08Q0sGEJFbSCcCJ0c1H4EzbM0t1eUJ18Bz0OSrkbWtA/hltHDTBDlWPUWS0zCaNw0HTKHw/ENHVl2nSk+eVTeeS/POKIGlRIyzkBJJeV/VzTg4xzOVvTKYR8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791658; c=relaxed/simple;
	bh=RVuB6l84D4agjhYFkE0OK25jf2HvfAKcA4Yc0QujAuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRiWAHS/FlT2jF6/1rg39wCwIXBDdg1sxMpO2hzB3pAirtG2Z2Hm7CGXiw5nFNoTgzwOLiYTb35bEe6MoixDUzpNt0o5AoFMmdQSrZa5dEKA9Ltld9GbnH+YYFaoLWtHzrcf6UfzcNQGjih1HVQIyowK+aEXQ6L+FFfe4BnKQNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iTRpva09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vwsgPIVR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiF5016851;
	Wed, 5 Feb 2025 21:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vtYd09zxzo5C8pp+b/H6BHKKdS2zH1kSxA21cydjeM4=; b=
	iTRpva09fH8fiIMMROpyt9HrKZ5zJHg2Aait6Ik6lGMF7acmtuwAfDZX1A7rQqVM
	zREYb7bFW386UpdrFBVgPnm5Xfvf2q9dbUUNgncczCDIr4i5Xyls6vestC8dV01/
	0qQKZ18yrKQCXGvXp1J9VbZm9/0ln+XAGMO4DFaTKYVhvk92pi+gfoZcKBNV8JZ7
	gKhM1JbNkLGgADzYZeZW9wvarfnjuitbBO1bPiTBETVt0hbMV2glqh4GfNnCwWq8
	K0wbq3BTyXSLm5Gt+POVv2FbVCnhXGfcJBjf3eaC/RnjdBPTqm3R06OeHS2qhWTj
	SW5MFxxVlsd0TsRPwP3hWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxm21r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JoVU6020619;
	Wed, 5 Feb 2025 21:40:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr07r7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS9mJOLzKA4HwtFxrLfc+anCQJSuFvAyqVMunwW5+CrbOKauPGOt+LUDNZlo0f44EgP7Vi61/2goXqbOtOzbarj4ctWpGM1HzdArbM2P7Nz7ZyNJv5fGsi0jBPxhqfXoZhY66A9Yn2IW8P/qkU2chIqqm3SGkTX5GkfvxlJT2uMVkVDpv/y2Cqud9beo8xY3HZfbF5B/VnHQYts7broPcVd/3WOh2hyvScMZ/02/vWiuDqwNesNlj+D0XMFfiHMRKtZjrevV0NYinCydt80UXjcgemgsbwfcXbgkWngXXRMn3IPVkHWXD9AoM9qP0tqKiDcJOJ6juIwBmUh3DL2u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtYd09zxzo5C8pp+b/H6BHKKdS2zH1kSxA21cydjeM4=;
 b=X5M5F+WzWNgeGzsJRrn8Ydp3CP9VmqQMoxEn/mIukVpiY3z0P38eure6feZsc1Mv47RPPeBgyf58lXY7poTLuQLVs6uMB//f1doWIFWtZUb8Vr9fLJ5H3vMA03xUzIiu1FfgxSPkGbL8ha/6o0naeRXm5wJMBokJ6Oj4rUSGpZ15WSWQV63UpnRaWloi+EIbH/CYn9of9J4RR4OqqGGD9bcwkNizViiWMxqEc1P9fGVEHUPGFd37wCngF/Nl8upXvsxrJfw865RNCVgyQf2zFjp7x9EwbVJVf8uqqESDPk1Bvqi9TlaExhzNmm+3XxdCfRtLqlZSmWacMOGaO6NGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtYd09zxzo5C8pp+b/H6BHKKdS2zH1kSxA21cydjeM4=;
 b=vwsgPIVRd39UUO5yuoNvi0Mh812/+pqmNprYMTEbZ3lpQ3k1KGgCIqwXsdj3iHO/UBU+qLrq/SspK5NUwyBJajcaC4nc3PdrKra2g5lfFp+lZexaHv9X9dtsOe5gbpT85Yu2g5M+Lpj4p0R2C3fqzczOWeMnxR7uD2itFl2FyXY=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:52 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:52 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 11/24] xfs: fold xfs_bmap_alloc_userdata into xfs_bmapi_allocate
Date: Wed,  5 Feb 2025 13:40:12 -0800
Message-Id: <20250205214025.72516-12-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b2798d-315b-45da-0eca-08dd462dc399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ilb1FeDcjbeQjtHH350xTC/LY2cs/CEe1QHEG3m+EybA6r1nfothcN06f2Lz?=
 =?us-ascii?Q?Z10BY9/8LDQStfJpNT485ibNYryb1TJJQWsww/M2og5swV7uzHZErMVzTP4W?=
 =?us-ascii?Q?dyvixehb46SMFaLVyMT/eyoTgvZJD+G7CP9MV8lLuIWt+kYNR4bMTTsqAbWB?=
 =?us-ascii?Q?9u4KNQt+B2JYkCnrhPecS5WtqR6hQi5VxHH96BeE2s6WIQg7WQZ8S4j2x3ZG?=
 =?us-ascii?Q?sLYGJAavA8ACwT2f287MOcP2QrMe8Kp3XSR5kMkctsbcESFfjHwpMT+KhSxy?=
 =?us-ascii?Q?JP0cNhu2buxfMcodaEbL+i+Vc1y6eLMYm+tNuZikB7i05Zo2o/wxBgEN8hz2?=
 =?us-ascii?Q?sjujufaD0Xgotq3ZvZasLt9pyE1KNX81gOMXXZ+S7+kLwFZbcKeE0sThqqk8?=
 =?us-ascii?Q?9UB1F8PWoE80pPnBuAOtY6ytH3bIwP2N4OT84VQwzQYyb6lj4f8siidqMIWU?=
 =?us-ascii?Q?uiE4FjWEbyTfBb07eeGP/aFnHUFXQGVtrB04pQbUJcBEl8gKakyOr7VQHPnK?=
 =?us-ascii?Q?+Z3SE+9jgfuDwV4EKsRzBztvO+aO8SMFIq+X8n2ebDZY/ortKVgyRWBvJFpC?=
 =?us-ascii?Q?FGItQ5hVtzr6cPF0F5EHki7YiHTJD2/qfJe+XPo6l/jBjm97vLZEc64g8l2k?=
 =?us-ascii?Q?MxkBAdD13coUo/r51xghR5FOkkrr/rLjM8FtH6+ycxdFiiaM0K3nQM4oVB4h?=
 =?us-ascii?Q?qM4jWLpHhK/ZHJjTRVM6O6iEgK04zMYSzxDGxPbL/bEzI6wOvz+DtFNl1nTI?=
 =?us-ascii?Q?mjf2yfGzoBBLgfNU7U0MiIyyuIPqqigNoJOXPV6Na/stbzPk3i3Rv+E+ekP8?=
 =?us-ascii?Q?Ez/bKbCvtEoeqHOik84WYCCC3axSc8ugEbcUMAI5FkdCsttlnBMWOWt88smZ?=
 =?us-ascii?Q?OVPHdu9NR9rj0/uA6EsG1i0Ltj9RZewAv9uqBnLvzvKyN88oUwCICoOLthT3?=
 =?us-ascii?Q?ihsG6wx61p+TXKQfkaHsbHMbPWwrJDI+4AGmMuAQev5vRvHIKUPSyf3H78iM?=
 =?us-ascii?Q?xPihOtesTLj1pHOemehEguxvWrC70UpL/wyDGpgrBtJqXo2qfDetIWtbUT0x?=
 =?us-ascii?Q?6fjPs0CFVLexonYj/cLHXTcf6t0CL0ZzQV7JTbpJqEZNtcg36+e2KUvD/J2k?=
 =?us-ascii?Q?Vr9ZRwDyIqzvh+/4h48u6rPdbYXFf/PBlrODHh563HKbdraBSFZgVH6pH4sL?=
 =?us-ascii?Q?tXqTwESQ6pmlalRN7bJ+deDbtWOUZ/BXPoOO+giZDz+JL/+oXI2wlMtm8zgu?=
 =?us-ascii?Q?QLujuxKPozmay6XzwkX7cIy5FzZNbBQ+30PLqN9h+jZTEQQhzgPUJgDKQa1X?=
 =?us-ascii?Q?QLM4OcAyRepGZ8ZHSoJPWPtIieTdQLv0b+j6R+rOCcTHE7vbjOK5guwv0YNV?=
 =?us-ascii?Q?DJsiYpw53G5T819Xm/QbLG9bkylO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhgMwWXCs4NR7v+HxAykKrzPbOzBkDDnW3g4AqeeW3fycG77VNFrHAmfTx01?=
 =?us-ascii?Q?ZHp8QnXJEX0P8Hq/cEtGQqEGeP+3VAfkWncM1s7yYRjr5Lv4ZYNYA8WzO6Fq?=
 =?us-ascii?Q?CKuCDw1j9ZCEaIZ0l67g5Ukegurm6w1yUWMq+METeXoj7Ur9paLLy/Suh7Q4?=
 =?us-ascii?Q?LvTxzXoFaPoWpZUFnkLaB2TaXzSQMo+YpZyq+mWlvXitR5MUDJFLjooQbqXG?=
 =?us-ascii?Q?0V+B3qoCP2KinR3vAWsQg2Tfo1321KpIRgRucJzxCw/FmwTBDabr3LxqORbr?=
 =?us-ascii?Q?v/2CmaUuamsb5o3qnw1wwKg/qHAml8zdQ2leL1twdvKzEtcW1ZRHRYJu57iV?=
 =?us-ascii?Q?0HlTE2k/vUsOTY8CESoRpAG1kbk+xsrF07K9/MZaFJl5E5SCiWZHFs8ChNun?=
 =?us-ascii?Q?48+ZLFs8E8XIp+k6tynnQyuAP163892YceIXm50B4IdozExfL0uYxM65O8vk?=
 =?us-ascii?Q?L8lIqhHmE43V44cfFrCSUgs+u72yQqeHCmf3v2PsOTXmjEDedFRI8GPU1h9m?=
 =?us-ascii?Q?58bGsXd8OiMPn3FBcP4TMMz5pujNkLcg87Xun/UMxJtfaGjrbADzuLg6JwUC?=
 =?us-ascii?Q?skIUbtadoDAwEmgKE/t+O676OCbnMa1fCQOwyw60f8BJI/G3h9/CtLenKWVi?=
 =?us-ascii?Q?Uc67w1VlzLU4mZS0cC0ArtSc1dU6zqvI+I+ue1E1oxB0QYhs9njS4Q5shfmo?=
 =?us-ascii?Q?X/imIOlb0eHK/JCVAwXWzqjPp+6bzdZZYM0zsTYbCBJz42p9hVgliVw7KlM/?=
 =?us-ascii?Q?eq6+poYwJrWSWw4NHhb9TEWX+P7BAW0t/BB/veFCSKxt1t5YZCmfpeqWu64f?=
 =?us-ascii?Q?lQbJiBVfXaiwxwh+VdV9Nzp58PwmPb6OrmVDNZOBsdkYvViDS6AY0avkeZ/O?=
 =?us-ascii?Q?XhzDshu1rJTHSzE70hygclzcO9yhK5ohIDkZHHIvbdp9raqAHWWQ2TbTZeUq?=
 =?us-ascii?Q?DihPpmgLjXwJKqODL8M0ZQqYKKJXkOZhS2NWm4/VigUZkHUfBYtxwRaLt3O6?=
 =?us-ascii?Q?o4ZxLiIzCSBOt0qYl0NnVz4PglLZ53eS6E/Od52D9nRjzCWOY4ih34noIyNw?=
 =?us-ascii?Q?LQ6f8xbMinLmnlvcBeQp2BhID5lTRuWAuGZI0fCruE9Q52tRl/0EXBD44cjW?=
 =?us-ascii?Q?79Z0LZ/nOP8Q6zkRJvoODod8MXP8Qi12U/AyCqHbpO2/A8RZMFcyD8Zjxzhp?=
 =?us-ascii?Q?wo8TK7XNGOg5Owh/NAYnT9Lz7FQpJxP+kc4gpSrsz5Cfe0xUrAcRt4MV1/2p?=
 =?us-ascii?Q?QukHukQYdoWNpv+PANYQheZMFhpYQdeRe956/Qg43ScMDyAW12nZ4AucE5f0?=
 =?us-ascii?Q?EjbAut6jfkHavoZd5SXtuQZlcIXdF6cfTxLplOz5k8uJ3kfMyePLqHK5PuXo?=
 =?us-ascii?Q?FEB2EA20P9nxjVYl96sXBd5axsMBporNKNK/CFT7wU/WLOokUfALHyOA6mpB?=
 =?us-ascii?Q?2bCBIP8REgdFh8Lp2ylGP1CtfCk5RzPGi7itrGKDgZZaTeKY/oO7DP5mLRFc?=
 =?us-ascii?Q?X5XA2a04WMlzGJjJdc9Qzi+qS/DgDqWlt8MY1sYKyOfbB7KdupyBooYL9H+C?=
 =?us-ascii?Q?vtyl8e2agSrdgIpR1oEkcftXzmJgBiQzfgtRWRuPj8hxkK/dBva0IEZLbpS7?=
 =?us-ascii?Q?QRPcY79IQmyezNezNiVqnqVVYJflkSV+/1/7RFXO9E8cdSmBvJHHZ76Bvo7I?=
 =?us-ascii?Q?AjKFOw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tIIACHmlhWBNsa0akSzidF/2NBr+RocnDFe3p3zNpyjmiYZpThjvyWtTnzJX5RTt6NO4mY6cV1zMB5V4Ugn1njx1Qctl6X8RiIJdaCOotxnY7miFEtfMdQukuQGR3dwKN52dOkjosX43jXPZYvBTqpdgQ/g1/lf88OC/Hf/YX6m5H+mfTOAEY9qwfYILI+xMzuRTVRwM4v4otuydd6MidzNBsiUtnKWVexYuOyg5HjfqxyX6wHkL6ArvoxB2zvQBukjVpwysKJwFkvpQGNMPlz82JUrdROAhe7v95AlBri/1TWBb69SpcvBy63sGMqOFNhvZOQ5qKHw8GIHj88I2ze98Cq75bi0UdRTOlNeWm1DMoB6d/MIT81IKr6byIu85CkmQSgjLRe3HHRmcTR50BXYRPX3aHSzwfqvZCdILTJ0/VBIwNZqlZwXIG0wdjEpBienvmWcGmjisYJH2IWfn7fgIQcUPxcOtf38uO4nJxXihHw/M3S333P7IlUVqFPjlNFLb9o90TmRDcLnP7QaSLgrc7EhT9rq9hUMerwRYEDvgeUYbRefBU7Nfxx5MtxrthPmaNmcJU0QrvtX84bpv/FDVJiA2vUitateZk1mKJVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b2798d-315b-45da-0eca-08dd462dc399
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:52.7534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJFKMpFqoXUd3SAt0SgKnaTkYvZ1sBc0hJZTFXnqP8xm/13DEE1VTtL7WbXKE1UhiEd7NVxeRmViDmWxQV1PqEUTxaIXtlUQpiRUwJwBIns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: z14SpQUlG2ovco_5ryO1euif4f2goqWv
X-Proofpoint-ORIG-GUID: z14SpQUlG2ovco_5ryO1euif4f2goqWv

From: Christoph Hellwig <hch@lst.de>

commit 865469cd41bce2b04bef9539cbf70676878bc8df upstream.

[backport: dependency of 6aac770]

Userdata and metadata allocations end up in the same allocation helpers.
Remove the separate xfs_bmap_alloc_userdata function to make this more
clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 73 +++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index e6ea35098e07..e805034bfbb9 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4077,43 +4077,6 @@ xfs_bmapi_reserve_delalloc(
 	return error;
 }
 
-static int
-xfs_bmap_alloc_userdata(
-	struct xfs_bmalloca	*bma)
-{
-	struct xfs_mount	*mp = bma->ip->i_mount;
-	int			whichfork = xfs_bmapi_whichfork(bma->flags);
-	int			error;
-
-	/*
-	 * Set the data type being allocated. For the data fork, the first data
-	 * in the file is treated differently to all other allocations. For the
-	 * attribute fork, we only need to ensure the allocated range is not on
-	 * the busy list.
-	 */
-	bma->datatype = XFS_ALLOC_NOBUSY;
-	if (whichfork == XFS_DATA_FORK || whichfork == XFS_COW_FORK) {
-		bma->datatype |= XFS_ALLOC_USERDATA;
-		if (bma->offset == 0)
-			bma->datatype |= XFS_ALLOC_INITIAL_USER_DATA;
-
-		if (mp->m_dalign && bma->length >= mp->m_dalign) {
-			error = xfs_bmap_isaeof(bma, whichfork);
-			if (error)
-				return error;
-		}
-
-		if (XFS_IS_REALTIME_INODE(bma->ip))
-			return xfs_bmap_rtalloc(bma);
-	}
-
-	if (unlikely(XFS_TEST_ERROR(false, mp,
-			XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT)))
-		return xfs_bmap_exact_minlen_extent_alloc(bma);
-
-	return xfs_bmap_btalloc(bma);
-}
-
 static int
 xfs_bmapi_allocate(
 	struct xfs_bmalloca	*bma)
@@ -4147,15 +4110,35 @@ xfs_bmapi_allocate(
 	else
 		bma->minlen = 1;
 
-	if (bma->flags & XFS_BMAPI_METADATA) {
-		if (unlikely(XFS_TEST_ERROR(false, mp,
-				XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT)))
-			error = xfs_bmap_exact_minlen_extent_alloc(bma);
-		else
-			error = xfs_bmap_btalloc(bma);
-	} else {
-		error = xfs_bmap_alloc_userdata(bma);
+	if (!(bma->flags & XFS_BMAPI_METADATA)) {
+		/*
+		 * For the data and COW fork, the first data in the file is
+		 * treated differently to all other allocations. For the
+		 * attribute fork, we only need to ensure the allocated range
+		 * is not on the busy list.
+		 */
+		bma->datatype = XFS_ALLOC_NOBUSY;
+		if (whichfork == XFS_DATA_FORK || whichfork == XFS_COW_FORK) {
+			bma->datatype |= XFS_ALLOC_USERDATA;
+			if (bma->offset == 0)
+				bma->datatype |= XFS_ALLOC_INITIAL_USER_DATA;
+
+			if (mp->m_dalign && bma->length >= mp->m_dalign) {
+				error = xfs_bmap_isaeof(bma, whichfork);
+				if (error)
+					return error;
+			}
+		}
 	}
+
+	if ((bma->datatype & XFS_ALLOC_USERDATA) &&
+	    XFS_IS_REALTIME_INODE(bma->ip))
+		error = xfs_bmap_rtalloc(bma);
+	else if (unlikely(XFS_TEST_ERROR(false, mp,
+			XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT)))
+		error = xfs_bmap_exact_minlen_extent_alloc(bma);
+	else
+		error = xfs_bmap_btalloc(bma);
 	if (error)
 		return error;
 	if (bma->blkno == NULLFSBLOCK)
-- 
2.39.3


