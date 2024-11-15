Return-Path: <stable+bounces-93532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C579CDE75
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8631F22E7C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AD1BBBDD;
	Fri, 15 Nov 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kv0GjneI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sl8v01gy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCA1BDAAA;
	Fri, 15 Nov 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674451; cv=fail; b=H5wwrlWWAUy2xg/3DoM0ftJnspy1TaU9Yy8Y32eDjqgBgOTFPSmLtwJTsuRKm3nWaVGtxkxaRxlBeiESY136DotTBXPpZNIdP3nODjtra4R4pjjIIaUm/XJsXPbQZl9OUGAn4jWNawyU0pCz8cbANRDNfgfjviRIyZxbBp/6Rks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674451; c=relaxed/simple;
	bh=2lXFp7X7efz5VlJzZgYh66YC+AJnGOEBopeSl9HS9JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSldn08Eh0PGeFTnc0mgi8tczwIdn0i10xIg/iMrRkahJbOCh749PahDCBqkRvSuJHv51Fa/J+Dx5rKdlKrKPuoajhe6rD+dlI7Q7Q+2g/v6mXr3D/Ie+CeKFfaJyCTPsb79HfAd+pTBWg0CcQZmzn4L1JM9H6Xux+9El7C/qeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kv0GjneI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sl8v01gy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHPHt000682;
	Fri, 15 Nov 2024 12:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=; b=
	kv0GjneIVniGUQxoDC6ZxAVbg9r5Q2LkjmV3bbQ875L2bIu1W7gm8524LKSrsaOk
	SIILfdjKHR6Nwi4A17lNUvcXOhNuLwj58lzwb8B2eRIK4UOC63l0gVk5id0v+Cu3
	mZ9S0n7xqmRys6X2wMiyY5JBYK4MTENe1MjPV/5lwCpecsN8m/iV3pJKNEUXFdkx
	vG1b9QY3zhKeoeC9qOjGshbLJE52pW9Bv9pUZ6XUtqxR/jW497g5MCvdKQvPDDFh
	HwrKaMZJwU8yQ6MPHFkuCmzEqteGVo0E1JkH4bjrJsqeUwitl5M7ieuVKeaFkLUB
	ciknRq/gKZPddIU1tdUisQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkdav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCSSLu000441;
	Fri, 15 Nov 2024 12:40:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbjfu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6ZimODuSfEe800K/OYBkUsQPylo7EwIGnT5MF6bNfUyzDT676f2MECVFmJoLOslk91TxwPMOtO/Qu6xKzeWZ6QKD04s7HU+9/QQdo/iqMck+gq0AZZY2t6MMfMenHYPUe3a0w7m7a5Jx1yXm1K8oCdjrSPk+VNvQvfB1H3OBumBQmUGBG0w2egiYIKD6sVhoTkTeYYm0Ewwr6U5qnHT9WzaL43YT/umD2u+jHuyMpx631Zgav7o41y5kQnMiQKtHQbAkqAAGpjj2k4Kloom7BO5drF4gxkJ42XsIfWYfcLvqt/2ccX8K/E4efA7apZcSDXP//zasNP9vSc8bPmzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=;
 b=Bncjhu2ni+qrqE295agC5l03uepeapfcv1HbzeSJsIB9ljg6lYeL74sxb2b57FHIBD6xFCaNLSgfMJY1/SAGafqXk4BRWF342dmMBKUAkN+yPD0qpUz0b8RJhhQKhuJQAvICmu3I/REdB6WlyB/tMEeoiB3RpwHTL+CR+dW8r0e0txX1yiAdnbPUclTiBHsXaUptsqLkQ1CIR1II+758uNnOeHJV/PN2GwUoBo9nrn/0ozbKjcBFwbADtWmoj1xd85eLESWJFcjUUfZS9+Rj2Y6ftNvEje26OMnAlxHXqA6du+1eAV8ilsCGp46Q7GEPr83LH5Ko8HInELdQb8MqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=;
 b=sl8v01gyXZWmbES55tHOE00Pm2QV5iQ4sOeSeoISltTlGbvFRir3+kGRTUvqS4zDpEaGJ6TfVkvzHgVidduzAs7Hz7ANuZWSXhs1v66clwFBN0glBaGAE3RbhNoo1+PjbqE9zCOqeOoT5aHZAGHkpNpli64YjsCQqk6zqWe2i7U=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:40:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:40:24 +0000
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
Subject: [PATCH 6.1.y 3/4] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Fri, 15 Nov 2024 12:40:09 +0000
Message-ID: <9d337250e80eda47ffc386482d4b5d9296a21507.1731671441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 874cb8f2-26e8-42a7-6db9-08dd0572acc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PcKDAO4NtPehkQmox6JUwypRsRSGHRHHYNC/3Ig9skKt6DdIl8gXf8c9W2l?=
 =?us-ascii?Q?QE31dZnC1vyvoa0+XF+EKM2Mw/ZQX5LQ0HPoz8k8dnmjXNa3c/SL35vs63+/?=
 =?us-ascii?Q?x9NOlXHB348IoODNAkedNFhXTEpR4fSjF421QACLNJydHnvZgxiI8ykRZ1cX?=
 =?us-ascii?Q?JUM0bdN1Or47NlZbIelqyDMu+yAHq7tieVIEphax3UBPm+QREQzKvZBZEi21?=
 =?us-ascii?Q?eBYknkTVOSzWb8p6vjiVd3o6W5L+zDh91vE5P1XBWDcYGCNZgD9XQjMtq882?=
 =?us-ascii?Q?KQ0SDGr3c5V0S8H/nSuV8r3BfiwxRpDe676ZqN68T0hJ/fmNEtEb4AlV8yjj?=
 =?us-ascii?Q?zWM7nYQaIXZ5OpqMB/HMlovId+yYpG29Ba1db9Jf+P4qAyIxMKBkn+NWoLgu?=
 =?us-ascii?Q?14Y+oVxKKChIqSfqch19y3bUt7W0EKXEGPE/Pi9YoSkEJvbS+FXRpvvnByCB?=
 =?us-ascii?Q?E3zlNhSX523JMgI9ybawLrkJ48TFkI2Gbg7aKKbQ5YRjimo4r1kERoWlxX+3?=
 =?us-ascii?Q?puJQWUIyIS2dgeTqHgTT0+4hYguim79iNqkqgSYpLOQAsL5uT+za6S9oTu1I?=
 =?us-ascii?Q?bcfuIgdobMpAFkKhsTv635A4rIDVIobejhRa67H1XuPvy+eipJDkOcG8IaUC?=
 =?us-ascii?Q?ocmg1yYpHnaWov8GMFMQcI65OnNMZKSwGRg/Id/zpQ9MAT6/9OTU4FHfEuWL?=
 =?us-ascii?Q?mZUuwduraddf+yKaY7jgBJgjRrYUnn9ifqdt+nEdk4hVOVqRvH73EN/KVrUp?=
 =?us-ascii?Q?CUAovRsbu8zouhp9MMjX/tNRM+joOT8OcSkKS1FmbhHGDWLf500xygZNfgJb?=
 =?us-ascii?Q?/uenynNspns85bjiPLy8SqeSOIyM/d2HmUpSaGzD+dra41L+blwIPZwgg6KE?=
 =?us-ascii?Q?GxL+p6MrOD7ojtwNLjRvumw+G6URq0dk/1Wem2Id6wBegnv1Dz5Q4sBdpUKW?=
 =?us-ascii?Q?23PJVKdB69japdTSRGlquLZqdkHvbt6jnuLAmOupEuSRVQYSpiOkx0WRvdOt?=
 =?us-ascii?Q?B+nT2DD0tc8Wv5PMtJ/b+p6SmpnptkwBW0WO6S1kCrtXXPERu3Zdd+sT9csm?=
 =?us-ascii?Q?b6cR/fCmZSMeG2WeVifSNsY3fm+g8gsrAFDqK07XLw5UUfi2dWjXYXlSxSPz?=
 =?us-ascii?Q?RbcHRda3yPDsCocncK06gjBLmsy6cyKt42/5DG3JkGbh0/sSA0TNLoJpu2Y2?=
 =?us-ascii?Q?2uXGZn5pAqX4QFddOUDin0KqlWjCT+qxAztdumEGr6OLi3+FZeDdmGEKGWQS?=
 =?us-ascii?Q?AoNfKt4rZBclhOiWhFXwqLLBpIcQyT3auQs2Ii0+K1CiEJe7MQ6RcNyTedTT?=
 =?us-ascii?Q?7evNVQAlnoi43irAkAacWd8+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8zLWFr3fzw5AYsgc80AjoW4oaP6AVTzE40FtxRHzAnaVsjtskQw2/VXSw6c?=
 =?us-ascii?Q?506kXhylPHTkOEgU5iu39m0iVrrWVQ0E1QBFFGcP0L+0ovOFiSHyyjRGXmGI?=
 =?us-ascii?Q?7BNOtDMull+gLbz7/1Gma5JylV3py4kwX+LhixJLdgtWaIwqD68idKteZKLG?=
 =?us-ascii?Q?bADCUVlOJ6UbzPCdqEvZTg57/cffCOXB3XphQfi44bfRkEkm5RPhqZ6lLh3n?=
 =?us-ascii?Q?PyB68y4Payoi6IqaNX1u8hpGt4ITIlQTCeL8xOlE4jTOn1AB9iUIGyn86n2r?=
 =?us-ascii?Q?Pyv/+6ytTSsjGPubJhTnigAaW707mP52ZHrGsOqa/3nvGNbBaqAvAn5ze3Sa?=
 =?us-ascii?Q?kCx1RqQpqlr02FCrLk6kHr67sEslJ+Nx3LhbrKcHojIZgiEkEw6jaxvKWHfK?=
 =?us-ascii?Q?AcPWAesRQQ7FSVFwf3wh1EseQP2mV1YfDCBSxLFP+RleYdE0GNwpxjgLxZ0X?=
 =?us-ascii?Q?OZEWM40iaYKh61kfm1GYhiO+jZeyRUW0Oy54s4hBE1D/J/C0s12yeM1Es9KL?=
 =?us-ascii?Q?+wyY65L4915Tw0PqlwdVSRXeevZ1u7P+6NdvhR5BjE7C05VIVcy1+TRrAxJZ?=
 =?us-ascii?Q?dIE0fc+MGdj4dtJZGAnRvvczQyk79eJ8zIU834/Y+Qbm0pSSp3UFL7EASogH?=
 =?us-ascii?Q?pI+JME1RJk04iJnYxyaeFXHguwrznWIpOeMngXzPcEPCCj1D16AO4P9nMxft?=
 =?us-ascii?Q?JNcIK3rqRhXdixY51EW6hZBg0+oWGsWxq1tF4XyLEnVtyL8C0N9T/ghfUA47?=
 =?us-ascii?Q?5ap7rFo9T1vRjN9I+8SWe+JZYzoQ50SkMUVEQhGy3MlolkFTy8MHOrD6rwJW?=
 =?us-ascii?Q?AHafhmneqgGWQvwcqkhy8uXFOPrQ3omLV5Zh6M0Tt2P2ksmgpXSwl9G/DuEH?=
 =?us-ascii?Q?GEp4C/DkYiqVtIW5rdRpNyXz28qdA6Uz95/cXEKYbWJJ8p8bvy8/tOzQXl7G?=
 =?us-ascii?Q?WzSGn8zMPpNsbpYq1P0QDL3757ecgR8CqjVbdP0C0DWGWLZQom7UF2tfHf+L?=
 =?us-ascii?Q?qeT6fATrzbjCSGih3VRJMBlnPfu3enETgByQgaotYb+iG5gkAdWDK6SA3q/6?=
 =?us-ascii?Q?+TcBqLIXA9oHHjZcTf0tCD/I0Us7lzt3DMOLL/jDFKLfpbWWEwX+6ynYnZkB?=
 =?us-ascii?Q?O/zbuyYxBfw+4AJVVepd5Ivnt+Tb7wsZ99ZkAESTBT+BbXpzVXYjhdXBRUzr?=
 =?us-ascii?Q?ofcEvy+2WiDE8se4UTnt9l18RdF2JPaCBpK4GHSaxWd5vX01HwlPVKKFHQtv?=
 =?us-ascii?Q?n6paagZQzx09BaVOWT2QIiwNnols9dfTzIDfiH7qJvla9zHRnsxWjmEPXDSw?=
 =?us-ascii?Q?ifd+ANHqjkV95B8IHu8IqVUeTz0vBbqGy1YTtaR/9ble9Qbx1iAdZkoxko68?=
 =?us-ascii?Q?+ij7tusge9rfZCIQctmXAblyBzRx/2FN9j4UWS7nULhyP/T+/JEWYfgu9M2W?=
 =?us-ascii?Q?yNAwsn/wcjY8572diwWbvr1goASIxRxETiHp0hg1sijT1rgCfP3RAJKcPxxR?=
 =?us-ascii?Q?gNen2uID/7Pm8if1vLXA3AtoqOBLsqHgwF3UcVSD3sBlvcyHMTg7VwH+RbSj?=
 =?us-ascii?Q?YLHmJobjl+ID+dvgGNm2s4uaobUN1CSP4McGAjC/THc3RiQyinmyelpdGOUf?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o5E0LURTrohqLPIOiX4I2xFZy65dDzAV8gHrs3F9TLDa/HzTV83DwlGG0mdKNRokuS/Hu5TX9GkQUpws2KHex6THBWqTo3ywv8BtxLe/ip0D4agw53MKxzQJoZv1d9teeuK3no+opgzbKjBqMS/d8Vf75rdeOAe+jZoepSxJ+5HojlXyX/ycQSAT8Y/fg0uAQfGJL8qTpmZAZcTzCLYnDlMSRf6FaJlgoHKBewSLrQTL/yhdLJxHdTekFYdJSdJSZmr17Fq5d6rNxGuIJUM4w4lgqN8/hMCsme43FI+E3qHHUscclctiT9oCVXlQmFCX8oij/kBHjfPJflk3cUsR0rJWAgiYssINqA1uNxlokWEDH1k5njxn+AmxUPVMRj7CHkQkGeyvP0HlqGyjiEE5PEt/hKomjqP7+6i8Vc/+YNteqwoFonh4fo8D4iOPGkgtvCTfXGRLi1rxfK6dRXZzNVPGbmPTaNP+hc+QxfnHXg1ahQUi5utAM2qMWcGxqWlGBuXmnmsFJZgQOVlnXtx/ar0aJSe1H159bG1HI/dndlkypXCPLD/Zu2rYxdr+pa6B33MYofA6mS6qLsmX0WUonlC3jSKCnkSHq8mHsGG8snQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874cb8f2-26e8-42a7-6db9-08dd0572acc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:40:24.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieE/iCV3FW9t2//jOM0rLxnR+5JJO386IG7qBstXfSpPOJPd5/6s3fiIoJdBPH7TrP4mNMElNQEJPMwZoxKpMc55Spx/DMOZIk1wVr6e94Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-GUID: E5v2IPbVKiW5Rzrr45TcG1A-SeMkYXOl
X-Proofpoint-ORIG-GUID: E5v2IPbVKiW5Rzrr45TcG1A-SeMkYXOl

[ Upstream commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81 ]

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ef35c52aabd6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..21ea08b919d9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_validate_prot
@@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bfec4df51c2..322677f61d30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index e0428fa57526..859ba6bdeb9c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0e1fbc53717d..d1a33f66cc7f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
-- 
2.47.0


