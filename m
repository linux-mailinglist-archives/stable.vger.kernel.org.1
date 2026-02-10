Return-Path: <stable+bounces-215617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHEONSTqimk8OwAAu9opvQ
	(envelope-from <stable+bounces-215617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:19:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC71182A2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6025C30143D1
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEB33710C;
	Tue, 10 Feb 2026 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZmpBe9m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7bZO4nz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C45336ECA
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711584; cv=fail; b=hnuxMocfiKnjyTAJDyY/TzIW5zK4MYJN1V+wHYaMd8WTt+W9bu158BqAMBcfjgLhOEWFmmDM36z9cuiPx4Yx+ZDRPCVNHZtt0PQzT7iQueetSyzTSohj0X0zVxg2KZu2oBqeGpbSFZbOG3xwB9WIQLTKWKRF+gwpDmxalGJUmmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711584; c=relaxed/simple;
	bh=c9BZ1wDe5ANvCtEE6Eoxk6GmrPX8JtqwB76Goacheoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYLwgnSBo1WP7+9gIayFFylSSlvsdL2KnKDhfWeTuvAtBWlnpMlxQg1hXs0rBqfaxy16EuYfett0yD8jFHdTmtB5imSrZMf2KopAeSob7u9hYN5UFG8j7nEpra7L1Hm2ZY0PA8NRl4gBs8fH8fHMRJOEmaVEV+ZoFih5HwW9+sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZmpBe9m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7bZO4nz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619LmTSX1628310;
	Tue, 10 Feb 2026 08:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M0noEGrgDeX1XuGB62XSq2oH5Xqfv5a8GR9UoGEvkKs=; b=
	FZmpBe9mRJuTCAQZyyMC1ogXevOemekTrKUghoWWo4WR247+mE3u77+ryXopUUfu
	FGO8u9Jcgmqfk7Rb3E297fPE5lKmKUFgsz2E8nuWVinNOyVmUzYtDnElMOGT7sm2
	Ho42sfLHATREuQ4UXrvBpCbj7evvSM3qp8yuAj8F1V43/1jrVv6GHMy3G4Q3IIY8
	rw/qArQTgCjT4iiKzvY3sFBAD6ThvmH9eFftUov1q3QhILC1CsGLHfx4Ix708vre
	e3xJYHe5Mmu1l13VrcJ3Z4iG0njXsSMhanemmR5Ff+1vIZNpJX52qjbvh5DAJuBb
	IHyacZRGPluJCW+vp4O70w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8uhcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 08:19:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61A6UCuv040629;
	Tue, 10 Feb 2026 08:19:22 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uum95eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 08:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH4hqEQGM3vWUt4/0befksIZsViQBcBdBF66dE+cs8+hKwv0aQaOZ3YdaCzWsQCle8W+ZYXJtfOA14Tiu0CxQwQ19ZiX1PNevGp/w/0lSeo4ot+HObLFco/YMEEocZm77SH9fD+8K/9Lg5q4aZvsE+V4i6/l8lnMChDI6XnMABQ+m3W8U0rZeVdS8zoocFDtdXvH0EGSpa32pA/0LhK71Xkf9uOCd6ESKr58UORNa525xZVIps5xGzi0yyHiNeyg/Nl3SPHaMKO+pm6l67UkpDyGYZDIC2diDbWCeXJ/PCSrZP5vXancxYJgBGRBEf9fxnEOt8s1Feq69yw7dzbxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0noEGrgDeX1XuGB62XSq2oH5Xqfv5a8GR9UoGEvkKs=;
 b=t7HgIts2y1Uc22HEcDmwiISuFvs+u3G8mvAUss5NRRhHQAEHADF7hqgjrTfqHnS2gmFAUxIIkSFTnXKZFicE0ZTF8FJRG6hyEe7P64yrRFcL0fART7lFcJomoVOkDTcO5ybRcxTFpW+Sbbqy3pQDUyUtcGPvhkV9PAbKCN00Si2HLGk5kkv2jgfKz+ENsOSmwo5LAWRUauM84VfZBe7+y3SdyAZgiTn72MT7w2BZYI7j7JWY7wYLjLYJ06pAjCF/yffxhr0SoAt3c/5nI7KxME5x7l9VzADiGcU5Yn5tCgt4dIRlKXlNB9CE8T+Y3ra1aTyzSCDZaHf0HDwzyXF0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0noEGrgDeX1XuGB62XSq2oH5Xqfv5a8GR9UoGEvkKs=;
 b=J7bZO4nz9vcPaaDX5g3cPXFmEavLm/lT1D3bSwEeH33wZkL2K/gykFLEleIdsCzs1VLcKCmVCtDwOQlbiahGPKJIKVRhJg141JOEyeCqpoqQRDdhiEUqzga2vfM4IhX2ZleVge5BX232ELUCxhaOkRN5rqwvjx9q4YZJt0LOm44=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 08:19:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 08:19:19 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>,
        Hao Li <hao.li@linux.dev>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH V2 2/2] mm/slab: use prandom if !allow_spin
Date: Tue, 10 Feb 2026 17:19:00 +0900
Message-ID: <20260210081900.329447-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210081900.329447-1-harry.yoo@oracle.com>
References: <20260210081900.329447-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0162.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc19c5e-eecb-42ba-a2ec-08de687d16a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXmukgqDOjRK6Krxu0gk26vBbQj+TPtMt+OZM+iP4+4IsMVTfnh69cpWvTHx?=
 =?us-ascii?Q?EDBT5Rds5BAQuaattrG4xEIxUaKvHiG/k0xv8bCs3/nyuYExjapJzx4DAZG8?=
 =?us-ascii?Q?D0LE62nKUmnkROPOV49CtdY0G+sRFNcPipekChFlAq2CuP52AciYeVmHeBp0?=
 =?us-ascii?Q?CDrM1TFtPwLiJAO9+cBzr13DDoUS3i6bzpFAY1Mkq9qwBlH9xVGFcOWizAnv?=
 =?us-ascii?Q?+55eNh8KkpRbIvhKI6HIqHZb0B78SaofqLty2DEQ5txxIFeDplZhOOOZTBM2?=
 =?us-ascii?Q?OBL3B70Cp5eNFRowVtAEiDoToPfVIFJfmMUk4TqGUTphF/5pSelwmWNE1fK7?=
 =?us-ascii?Q?5I/JjEP39HUWe9gxhcf3Fsufi/kIwujrBidJp5NgX86g/eezgFiRvNuvBsQF?=
 =?us-ascii?Q?uQXoZcTmeUxdb7hivg9SDsXwizodk5T6qvGyMXBI+9xxgZKksWBXUKyk6CXE?=
 =?us-ascii?Q?gvi5x/fO2gVl8qRlwLxnR3UU921du568tCuy/gudH2PD2J7+YkLUWlO+R70v?=
 =?us-ascii?Q?jucDHH4808KmE926qCe4f8VLDLzQObCzvhm1GdCmxJ9GEI2o/qQJiK2bi+Na?=
 =?us-ascii?Q?FcW1SjzopSZfr1qhFTj+wNU7TzYya5C946QMuZF3829canN85oP94gD0eLQb?=
 =?us-ascii?Q?5x/LVkasMCMHbzoRODi21OLk9qcQkUYJcfVvi4TYgX0k4cy/D/whQ4CN+H+q?=
 =?us-ascii?Q?e9+kacfWBv5absxTzJ1glmMq5s5tceNosg+WtykfmOCU6TRgsEp3XUCPZTNI?=
 =?us-ascii?Q?3w0TF4WbJpSnGK1I6AdU6PSzyezT6kxRn/65DaOSwh2lNviPFJmPNOVmG+I3?=
 =?us-ascii?Q?prHnNw+vR9y7MoVU/U7/7KQhRXJtRRext7ecg1CRErykAkRhuv7otk5SOS6W?=
 =?us-ascii?Q?jZxI8ShiXI2eBCrO/9thDJInQ2SaEZk+Ldt3graQ9EftonE95uhJgpxjlG2Z?=
 =?us-ascii?Q?EQupqVlOfzoCqMVgpNatY85PiRqQF1FoRWSgoDmAnFOY0mK9tOs/VBTup3wj?=
 =?us-ascii?Q?IObZWptokyxJ6mxAsg+rJNTw13eDtarxARwhDHmyOXNMcuZx++Tq8/u0H6IF?=
 =?us-ascii?Q?P0SISa7eD4F8TbRPDL7FjGThdHYRLmj+vNZ2/V7KaxnLcXchFZiAFLxDc287?=
 =?us-ascii?Q?sFN6Ob1oBE8Et+tsMyisoxZldiHydfGGpRDP20nmbsPL5sks84BoVdElmTfD?=
 =?us-ascii?Q?ENvud/3Xvvll4hTjYqmKe7Pf5dzTxW+P8PTXCGNtdXWAp/Zs5tj0fNhRzs8Y?=
 =?us-ascii?Q?5JovQX/m/tTa4U5OefQcOLTDJHxBJKoiuOIw/aJQ7Cexy/voIpuWHTOVJ8gB?=
 =?us-ascii?Q?MwsVFy3X1kuXqk8CmNc7WJjZkmrAVghsDPQ+agxZWjQb8Zax+VfwmVcWGBGm?=
 =?us-ascii?Q?/vpwONV5bWH8/y74/xYqdYulS0kztvwOt6AMVwptnl2SC6qsnaRSQ68NS9Lo?=
 =?us-ascii?Q?SJ6u0UFf2VsnrbkCr8ILs5HNAdO7k7ZuNA2LIYAxpKAqkqZUs9I8qlhPLWo+?=
 =?us-ascii?Q?qfi4T6AfwSKZzSNgvn6L78BSrwVPP7DagMCuOKrXUC3qQBJjzqvNuDt8E9rh?=
 =?us-ascii?Q?tuAuTF8fAThJet8u4ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8WX2b56Ub4MOvPgx9sn6WfSl+LuOm2p9f+uMr+g8P+rx5GTKbS42bCGX6s1W?=
 =?us-ascii?Q?PK18a9BDTPjZpxVcNcooZlnbUEjVs4VgMy4rWsSec0xY9ywlsC8LQSUSt53v?=
 =?us-ascii?Q?0377Izu2hYXQLMn5PWKaz8hngziH28UsaXACkX/y3elZOonW6DHTvpuQxEqH?=
 =?us-ascii?Q?6uSNYrdPciaqu3Ss4ZfajlIHvOduOjiKGGc1bzHsrip4e2CWrqNkBd+rvCgL?=
 =?us-ascii?Q?VbXmcy62Lj4dWAazDNIun2eL6tH26YycVP2zJ9eiR1GF+Lgaog3GQiudvaMJ?=
 =?us-ascii?Q?0aCC9xCLXxwHuhySYdJ5pNje4lOBQZXBZpgWv6/YY+Y2S0FwEVBy7TISte9L?=
 =?us-ascii?Q?DtiyLTq8ZzRo1QQZb3OCxzXyrc04/5f/J4FJOa5/glvq8+cmSQiUMibebF8M?=
 =?us-ascii?Q?pSjuvPoVorI8SPm/i778W4/Gt/hN4NUPlgLDBXDCLA3UGxKmA4f1GFGebdSv?=
 =?us-ascii?Q?gje4i66OhhiVOFfuXR4jT1P+TTTZRpbnXS2/rcAhl1MqOZ+TaA9BLdBdHlCg?=
 =?us-ascii?Q?zAiBkLlCeWnfsxrNBox0wyP2mnC9xGZz2nB+DTLaoovTrSyE3qCWMRTP7HVW?=
 =?us-ascii?Q?jhkG1eagM2DEe3tUp/f/a2TqXbpRPNPG/E34EZwmca9wN1FKDMkWPU7vuCUA?=
 =?us-ascii?Q?ZWE8EatGxwGWA8PNnWpQqNatXh/3gXky6ecohCsdaernZVoI7ITxRamQuf1h?=
 =?us-ascii?Q?yckYYt+ZeqdjZQ+yb/2CUi3B6El9Tj634LqV80JDla/kWzQOYSqYYSBTahPH?=
 =?us-ascii?Q?Ra8XJwPar1ZJ5Ev/gBWiYw7lD72miMdpObyYzTQKPuSoAqEQ6wbbM8NJLmmm?=
 =?us-ascii?Q?eWVznE411DGclrGUAEClEA/ITBNk7pvYAqDIZvfSq0JRqERZy19twXag3ojx?=
 =?us-ascii?Q?5sA6225t2Nzi7KjvgaWKCcTWsbdT0TGlh7b2xVPUCQVF1eruGU5QZouWn4W2?=
 =?us-ascii?Q?pL0beKy6FhiA98qGWVP38h93Cp7kcUT5KC2N0qrLqkD3oHxOvvFc12t6Z0jT?=
 =?us-ascii?Q?M88mRMt0JVgwdoIS5SbgBMmLsOT6l52rG1E5PvRiFMNIKZ/pcLB1c/vdZLPp?=
 =?us-ascii?Q?Noek3M0KYSToSuDY5aeAil0rP9fWyGOglsFX6KnsedjW2vCLbgXvtxjpLhb0?=
 =?us-ascii?Q?WzlJmnGV8cxC0VdLxpU/gZ+EhiAjWiwM/1vy6Ghxm3AVpbsVEOoOOkZwWF6E?=
 =?us-ascii?Q?uFlet3uXaTVaekHFqWLxf0nw1zU3H7HnhFq4jXc6IY3ze14ro2EpayrUspfe?=
 =?us-ascii?Q?hsA6emRFCKKp4/V8jn7y6cCUBj6j2jssIPI0EhnLYBCwPHMz2aUW5v+Ydmmx?=
 =?us-ascii?Q?/z/VLfshe32GPEeNCXUU8tXKCNdzi+oV+XE2ay5w6WnG5DSZk19aqYOZf/rx?=
 =?us-ascii?Q?5xAHwvsHXA4JJTnUPg8weHkS4wQLA4CrcApRNg+VZXOS5Cg7Zu68L9UrOR4v?=
 =?us-ascii?Q?Z2CsSsDecipqkkAEo1QbWKKGCqLL0zfJ3ctyKfOcovN1qCex+/k+feBf1Rj1?=
 =?us-ascii?Q?ej/UsZT8e3zdfHSRkS8/A2sgkazDMUFtOE8QftAKbJDVt6s5cRnVTHMX5fnC?=
 =?us-ascii?Q?PjORPNxkFPXbUGeUCoy6hKh9fKQbRwyjq+VazQCVy0MpJqDeKl3oUWOuMuPT?=
 =?us-ascii?Q?h1YSZ7uHt3yhYZC2nOwo1/z04kf/G6QLZlkuaoo5Er1QNQ6mxYW9HWN0L9p2?=
 =?us-ascii?Q?fTCcdNKj2kOPuaT/KoDp0RS1V4FEpCp2QNEJEiwL3K3jCZSrCq4fWjADeIAU?=
 =?us-ascii?Q?lNobs9JA/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FdBNxezt7E2ngC+A6sBDQT4ARPr5mvOoL4O1EoSWw57xM/w8yzAAP1eEpDo4IhxxpW6N/5yLRKGNUkvWPC5aQUt0a6hNj4KephnLCt1es8Q0MUcHaHKC2DY1fBXhK8BoFvcP+54/4paDTY/QAEsl0csk5TFv59QgbF4+OHoIS65N5X6Wpwj8JRI6wOn0rst4GfUKcAo+mIoTe4JqLnI8G908Jy5lHoEFrpC/xGjqu7DQnB7hOx2h5RVUyZhXa3iqRIkiVqrYzAUkYV0DbWQwg6YfZZa6POx/GaMVcbBjxBrqOSBlppFNtSaZOnlZDFS837Z9FKKak8Pj4xF1UOatQJm4o0Y2EFVqE3AfSxtRpng2hfFWKuMLgWtLxFeNH1jOB7Ya79en5iPvv0EkMqcZG3fpaSU7p5yRVUysZ702H8PSmSKt3o1kv6+tmBC2MVXADC+izp2W+saYBgjahIf4cgjXNJykPP2y5Tc3vh3WCmWAh/Zw5m7LdxCQimy3mRdSDgvV/NUcZghiRrKg8Gq3Mx7SaoYcQIEd+wHNY4oPHGhI3mXo7Nn4TeWUlp0bAlsrT8eqK/KFczmgmxHd0HACCSoIU2xHm+ZGyJZoWF2RyE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc19c5e-eecb-42ba-a2ec-08de687d16a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:19:19.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkW3w3SPrWxTnKXzQcoL+sbCaQkYssJF3GI5EhzV4TEJ6PNNub2eWC2CmXEyC8S+h8E9LsVq8EJX9vQZHIfo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602100069
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698aea0c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=fFAbNiGV370v5-WorDQA:9 cc=ntf awl=host:12149
X-Proofpoint-ORIG-GUID: 71rR-8d1uO3EkZx3rVtoK3hY7rLvIIlV
X-Proofpoint-GUID: 71rR-8d1uO3EkZx3rVtoK3hY7rLvIIlV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2OSBTYWx0ZWRfX2fJrU57QCBle
 Qx/3S/RyiYD7fP+Ubj1qfWdoyUINQyFBKBXGKpgt3h+bYftZBzCNGOcdsNs2avq20VfJ6H7+/PC
 y6bEWVyEyfjol/pFE9ht09AVmIsevewOyhaKqT3HxfBG6IJ/194+HIPdlta4fhDbTS2w5MssNtO
 jadRFwvLAYOcdXgLTRPg09ciUL/mEm4Ky0oela0iGwi6j1BTUM7O/jEJS4hegVu3VjMRAIaS32R
 lPZWl0SaFozyb/eTECzvdGP7Bl5L6ZwH4Wn/cEN53YqEDu+nUq4qMUOLrV3Dwqor2FEpR/qOgFk
 GfjRKgKj42lUCnxRfH09ZN2P9LZBViKglduA0rO4Ssq8Ori78eg+JBoRotH8g9XdrjRnYmc0J8l
 AMhctvZYkfFxqLzVCM7zHJg9nTBFuyy1Ihlk8NkNR4z1ofJ+EUd2uBgRn1dyubAQmStXnM7cXT/
 znkK/B3E+8NQMwyqQyf32VCAqI64m9n/ugtseeVs=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TAGGED_FROM(0.00)[bounces-215617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4EFC71182A2
X-Rspamd-Action: no action

When CONFIG_SLAB_FREELIST_RANDOM is enabled and get_random_u32()
is called in an NMI context, lockdep complains because it acquires
a local_lock:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-slab-for-next+ #325 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/8312 [HC2[2]:SC0[0]:HE0:SE1] takes:
  ffff88a02ec49cc0 (batched_entropy_u32.lock){-.-.}-{3:3}, at: get_random_u32+0x7f/0x2e0
  {INITIAL USE} state was registered at:
    lock_acquire+0xd9/0x2f0
    get_random_u32+0x93/0x2e0
    __get_random_u32_below+0x17/0x70
    cache_random_seq_create+0x121/0x1c0
    init_cache_random_seq+0x5d/0x110
    do_kmem_cache_create+0x1e0/0xa30
    __kmem_cache_create_args+0x4ec/0x830
    create_kmalloc_caches+0xe6/0x130
    kmem_cache_init+0x1b1/0x660
    mm_core_init+0x1d8/0x4b0
    start_kernel+0x620/0xcd0
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xf3/0x140
    common_startup_64+0x13e/0x148
  irq event stamp: 76
  hardirqs last  enabled at (75): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
  hardirqs last disabled at (76): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
  softirqs last  enabled at (0): [<ffffffff813b2dda>] copy_process+0xc7a/0x2350
  softirqs last disabled at (0): [<0000000000000000>] 0x0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(batched_entropy_u32.lock);
    <Interrupt>
      lock(batched_entropy_u32.lock);

   *** DEADLOCK ***

Fix this by using pseudo-random number generator if !allow_spin.
This means kmalloc_nolock() users won't get truly random numbers,
but there is not much we can do about it.

Note that an NMI handler might interrupt prandom_u32_state() and
change the random state, but that's safe.

Link: https://lore.kernel.org/all/0c33bdee-6de8-4d9f-92ca-4f72c1b6fb9f@suse.cz
Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 90f0e6667130..591e41e5acc4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -43,6 +43,7 @@
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
+#include <linux/prandom.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
@@ -3311,8 +3312,11 @@ static void *next_freelist_entry(struct kmem_cache *s,
 	return (char *)start + idx;
 }
 
+static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
+
 /* Shuffle the single linked freelist based on a random pre-computed sequence */
-static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
+			     bool allow_spin)
 {
 	void *start;
 	void *cur;
@@ -3323,7 +3327,19 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 		return false;
 
 	freelist_count = oo_objects(s->oo);
-	pos = get_random_u32_below(freelist_count);
+	if (allow_spin) {
+		pos = get_random_u32_below(freelist_count);
+	} else {
+		struct rnd_state *state;
+
+		/*
+		 * An interrupt or NMI handler might interrupt and change
+		 * the state in the middle, but that's safe.
+		 */
+		state = &get_cpu_var(slab_rnd_state);
+		pos = prandom_u32_state(state) % freelist_count;
+		put_cpu_var(slab_rnd_state);
+	}
 
 	page_limit = slab->objects * s->size;
 	start = fixup_red_left(s, slab_address(slab));
@@ -3350,7 +3366,8 @@ static inline int init_cache_random_seq(struct kmem_cache *s)
 	return 0;
 }
 static inline void init_freelist_randomization(void) { }
-static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
+				    bool allow_spin)
 {
 	return false;
 }
@@ -3441,7 +3458,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	alloc_slab_obj_exts_early(s, slab);
 	account_slab(slab, oo_order(oo), s, flags);
 
-	shuffle = shuffle_freelist(s, slab);
+	shuffle = shuffle_freelist(s, slab, allow_spin);
 
 	if (!shuffle) {
 		start = fixup_red_left(s, start);
@@ -8341,6 +8358,9 @@ void __init kmem_cache_init_late(void)
 {
 	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!flushwq);
+#ifdef CONFIG_SLAB_FREELIST_RANDOM
+	prandom_init_once(&slab_rnd_state);
+#endif
 }
 
 int do_kmem_cache_create(struct kmem_cache *s, const char *name,
-- 
2.43.0


