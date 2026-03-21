Return-Path: <stable+bounces-227754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EuCEv50vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94B2E4C63
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08CF03013DED
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AE318EC5;
	Sat, 21 Mar 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sZd+f984"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74C2749D5;
	Sat, 21 Mar 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089466; cv=fail; b=j4rztk3Jf/XL5SJkh+3DxTi+B2H3/Pl8EFCVNqnE7lhfObT45tqfvrOMP3uulqIiUjCXT33IDIwdQ3dOsiAVpYpBcjU4WdjkIQakvoOQA8fG+5dnPLOv0s6svP1PFIYIgmi4IE5nqeLik5MiF68mORvx7cDcBHuBWuenziT+rto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089466; c=relaxed/simple;
	bh=/AQ03K1VfPaCF6r/SkXkLo2gOB2ssoYD3NIQ8bTULTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iirhj6wDLv5mY2VFXy9Z1oczP8DBzQI2iUnjptDexA3rnIuEDfPib8yJ0MY2MFwZ4rOy/wxr+YzkhhGIEycccyxQ3fMSr4Evw0ZIclETzgVAWE9d7WpJKqCgwHcFcqu78POX2vqcXXyHXJP20BTbxOmdnPlscjunyUei47mDeGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sZd+f984; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LADHGi3553376;
	Sat, 21 Mar 2026 03:37:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=5N/bOsrUC
	6owa5RdeiiCgoWsV/Y5rRyUw7BvRPzC2b0=; b=sZd+f984qsKsCAeffMj1Oy+oF
	qWKBY81IYxvvBEeAn/WNHiXl3wTTqrAYTdNTCF1KYNoiFcDEgiNCS+JSwyDUy1cJ
	/Raw2R5v1+hlXSUZDAPqAYqpKmb53VMGbn9m03KkdlRGJsZT//ns2cyuYAXidZms
	H/7GFiEH7MWA3TlBL/orn5yrJo30X86+jvjIhITlrXX+rzGPvr1XAPPaBNmzAQku
	6LC0PyADUXGBeY/A5jR9YdDcpIoo9+/J4QHwM89jl09mYJ3Pzqr3JYldZoEA0432
	6h9BCMpGudd4CWJN3dCXyd59HGT+PsrtjaiYf0XICN8eGYsAAtD293tQ9XH4w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky83bm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQJRlaAsHZILpqUpk8K6C9mFPs5RsrZ4I0vSdKNx89VzReq8Ujl9tWkaQSMRPjEiO+ThzHd0+njXtnj8/sbGJqJghhExVA6Kr7GRAsc7VT4CLMWTwXf4v2xfen86FzCkM1FslM79972t11zZNnTjU8QHg1kWT4LIx7KRLdJ1gVOEdTPT5w6K/3U7z0eZjYqHJtp8LkxU62nqJki2oa6Is3awt1fKRUcSBiFNqiILznzLxR7nWf+qBNLd4QeXkpHmfpCXncCdNYRmfXQ+LX9p5K18M+OvrfeA7NZ/J7S1vBA68ivCeEXr/oiPpyvGYjULx76mQizV2IeMDeBpcLBlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N/bOsrUC6owa5RdeiiCgoWsV/Y5rRyUw7BvRPzC2b0=;
 b=hTDDSnYgiBJeVSNOh1HCsXkFffk0TiC1+wMUnBfUJsiLjGIgsK48y4M3ee4Bw6WBtV5PdRdTvQKbzUMqJPWdQHOKfbGwRKjK8BkVgakTLvlzUeuDWNPS2MEOFBzu2ql1HeyRHlkP95brdH4onDbJb0p2KwGqFA12cBbbYnqXdFdzyW0QUiwhrbxOTb3PhUf0vU7B/o+YYq2GlqcHorIKdhfnIuGDGjgh3j9jIxkD5cmtW0revGoPRYGvKdJD8Di3CYR+Y8h8ciM6SlM/neZyUVqB50l30Glp4VylRW2MHbERaPFdLmOq/RcpHwvPS1u+jtcz4bYR0rkYycjcYfePjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:34 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:34 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        "Ionut Nechita" <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 0/6] cpuidle: menu: Backport get_typical_interval() improvements
Date: Sat, 21 Mar 2026 12:37:15 +0200
Message-ID: <20260321103721.35114-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc2d0fb-461f-4656-f612-08de8735dc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hFA1RVPr6KZkGUq9JzQjeBAhoNGxWA6+VbP92NY0n2BXNuBbwuRskjGBQU0f3+d5XT2ZkRwyEL/UCzJ6NE/TVZknbLCxEga7nLmp6gmI69M5nloqTVAm/iaL1bTLxZFr+7pCvvlCD/JQMdoPAWmxKvNHeyTyTn8L2mWdK84VhseNipfRlO+/a6RXAv4uCYvrtnfGd/rSxxGgY0khMbsuHaOMNNVKPj9dTlczMfq24lYWASSk3kGKCofCpVhGVO6M33Zc8bUsJtLej1Nh19RoyHsc/DKFfUviCpV6HatOPvRFdNgQIRNHKIfSiLtKhXIlYa38sKgxGHhbyi5nLeX9WlnjhSfCnV/u/xsB4nWbg1pV5tD/aUYtC5NNfSbkLqIIC99YJYU29JNCV2WdqCCZRn2b27jBVAhwtQOG+lqD/+rUlwl1aAovhYJTdLGwiFGjI6+M916K6h0VyXRTpQszvs/srofpObT3aGnFHO1+mqhRarMiYPD42r6493Lm3ml1U0+EeU2dFzxBJVZalFwCXGcUpbm5Qc2bf9cwJG5g3mgLx3A431F89meaMQzFbcFS0ijFyQHfZ9VryaFJ+yyEGCFPVEXhb6RbWbbSpdgLkhXO0gG2njlwPlgZewX1z32T/9TQZlaZLKr34DkA5vyF0YLMD/TWxn+yb9JfKWOhjqKuifqrKkvTbPWW1g4kg9JnUdkB/QNtBQiDxDHnh6XoeBL4naMpYa6hXJoK5wtViAdaHwHzKUrhVfRC9mZDZgfKbgW94uvX2vhLlfvgYOhWeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ww7VrsQORRz+1kL+3iOvUxGsbT8djS9AQRxh9VLEucb+2r6ssdvKGJv4kVi?=
 =?us-ascii?Q?i/MbpPF5ivqCd2c2fN9O6ZwS7tl06/9zxfE7OI3ZZ8BzOSEuKO9dv31o0BbB?=
 =?us-ascii?Q?Nhh49MiDtlS2Xhw29jGYNNw8gfNEC2K8+Cu873MMqorSqYnfPm7t4Dhpfe/8?=
 =?us-ascii?Q?XEB95lpIEdyCoFqVUrnnhWMd++09De4oqFdByQAbieL7/BlbsxfWL6U8jacZ?=
 =?us-ascii?Q?hl1aJtNeDWFXMCwHxQW6BAJiGhgntBbrzlUr570hixMm9AsePAYpfiByHqRI?=
 =?us-ascii?Q?UE9RaJySgCW9PW8zFODf97LgIMYe8WmYkkz8P8yn6xnodBUfLlGF0W8zn54t?=
 =?us-ascii?Q?dfoFZuQQOQmIyyRZpM+oybCpzE/FFaqoDjIv5t2+0DX3qa+dWmkFbBevnTCx?=
 =?us-ascii?Q?5d31dDF0yrd7T2iPhr0S+7WiyPzPfG0WI/b72NazO8SrsHwRs3Blz0/pSwMq?=
 =?us-ascii?Q?fDED7xksEriQFp0g8NZuB/sPWDcAyoxaGASE6LFyW3eVfCswYMHUaitGFgsm?=
 =?us-ascii?Q?SauP+lpLvk1aX8vyNbmQIL65QHvxr0Xlyy2V4nii7JrcERwGqXVf5mQLA+GS?=
 =?us-ascii?Q?/r6IDrRfFHk1TsguNyT7kiwMYPGloHGZxE5q2wCliishwEJoZ3DJFDWVQ/Pv?=
 =?us-ascii?Q?tDDi8rBp/yZM8wf+h+adUH4CmkwQDk7W1A/cP4aM0UNIq55jYr9/F9s4fHdH?=
 =?us-ascii?Q?lPjUwO4NhWSLCnoRCahWcBmKrnpQLitPjIlK2klDX5HOO0wjgx/8UIYwQ7ab?=
 =?us-ascii?Q?oR3vuwUDyO+BxU6H6cBciFCMOLp3IXWXQ9h3PLC/D9HEQwxo3iOTYymiCnV4?=
 =?us-ascii?Q?yZBfT+sFvnfllBBZUA3CJQ5qDDxaOUO1q+NPIkc3IEQbjS6UEHDOF91cTgUy?=
 =?us-ascii?Q?YsuTh2hgrVZocb0IdwyfxT+jBw0G00/uczdUQZhiP2rPNrENPMQUIcBqefZN?=
 =?us-ascii?Q?AD2JzqGHSI7XxTWaA5vNU7R2F3+1CKyqM+PbV8d6zrQX4qUFfuhMoxULleFR?=
 =?us-ascii?Q?IA6PFyvgRgoesaTvPRmzHUoZvMWAYL4g/NLkoE16iPvDpe6PkaTh91Cflhv8?=
 =?us-ascii?Q?gFJGwg5lQ4H8Yz1sI+GOiy/r+yHmua92K8z6EMMKpL1Msk5P8cXWtOkQmW8C?=
 =?us-ascii?Q?Qg0NTxMYBr8LdNJZpzwMOwuA5MhIojquM8Ax96CG73nMFuMYPlk0ydCjyVIZ?=
 =?us-ascii?Q?EN9g56kJ6WCEMSIff+mtX7SmyestFP+IrO1R8Tzt5kwVW18VQ9FR2PbJKCDJ?=
 =?us-ascii?Q?l+UtgJ/ufhzMuh976tQUn85p+T/YxIQsvtUMkSFGc8l0ULx5GI2JZCxjB2cX?=
 =?us-ascii?Q?LgN7d8+jP8qf+S6Z0OPTWzup/SqmrWuTA43KhS2l4Yoq8gDB3/2Ng6dJJmDE?=
 =?us-ascii?Q?Yy8HHjEMpH5e61kKa9VayESwtwdWrtUHHYB5MsXylhOPdM8W230hMheXzM3R?=
 =?us-ascii?Q?3RJfddVodrRJS9mY/UrwgkrdFJ/vAyM4DYILm8btaL96qXMCEDYhoOUSGArn?=
 =?us-ascii?Q?SLdoqr8j30yGsKUpQMG/lVBhU44g6k/NNIcXnryPUA2pcWIiNLfl3nz+6tqu?=
 =?us-ascii?Q?JzUekiUp2o2ThZ5gPfJjTFpyCSdXhV06J+ofMTqxcnCEkaroB5abtZ0rnrMW?=
 =?us-ascii?Q?nI7iwOxgIYjdSx9V5+9hfXMPP2KgiVIVDScdBBsMnWlofabcr8AGYuL9tlOm?=
 =?us-ascii?Q?sL54P3NClQQkYkJO+inoOcVK7idRJt8g65Snt4KVwyO8VmY9OTEcOlPqrlBG?=
 =?us-ascii?Q?WhIWxqc5dyrEiQ1cBkw+U6U/wPy4ioA=3D?=
X-Exchange-RoutingPolicyChecked:
	mMjqyxRuSQYdzLZ5UB4csfVNh9XFZZbacabyqLJd6x+HIblKrUWLxybJY6cSv3m9KpzGw5xgUMjBxBKmwt2N6/xWiph2/GwtBkVzyPG2WqkfBDbBxIjdaTOl7wjAdCm+j4o0C6aTQleX9NnDL4vHSOIe9Czk2bSlygp0IG3xcFdu0hKoECks1XoM6BAXM56Ma8n1532L9lI1VCWd9+FN2txk7BZ8SyJuGe+NQ8lnvUA4N4rDkjbgfMK/mgIAhQy6aE5GvyMbL8YtfJW7VSnruyWXw4bCxeAix0DI+AMCsjM2SheXpuHk05zYq6gmCZN4W0B/pJsU29UDIvvT8H8SZA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc2d0fb-461f-4656-f612-08de8735dc60
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:34.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yxccWw2XlyOnS2gSQeaA+cHfAtb5sx+IDAF8qmLaESXGUjgM1seAS63MnTRlxEk+dYHjhJI7bjGMpsmPBoZIESfVUdIOwb+N1puEvYqjUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfXx5VPuDJEbgMt
 SQSgqxzwti8CLqESEkpjH+E7g/ntWP/f84kV5uYYNvbp5CNls6fyBMI4lOT3+d43P4kEuOCez1w
 R2syTj2Annm4GlzcvdfVDw27WAj6jMGXbhM4SNN/Sl4kTCGHpP2SNPOCWvvXpUgjSE+lzfB4n1V
 fw41+ouwwXj9fBOxmcZSQRGan4kNZfX5uVub5SZM/zzZmiHVcI9JcWxvQba6UIiuqKnCoTcTrVh
 rZCR0AUtxx6yOCHoUPfaEWwT2ccD5G/TQak1rBqKbphp+dlLMQfcV6QD9+1f/zwXMRarFPHbPMA
 ekMfTIYSQ9qOZjGS4AKwsL5sFpfkECfSkv1gdFHYv54ufyK6UeL45dUojXlysG77rt3UJ8Gn8Or
 Q9A4KnUc2sFzyZonJVLO7NPuo6+XCjepK0tqZr3oFIWSDK1eX/HBLcE6N6FCgB8FH8qQuLQrShJ
 h0Ct34StJKLccPgnoMQ==
X-Proofpoint-ORIG-GUID: aNVMDwsXA-xt710QiBTgnyiIaTDucjJB
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be74f1 cx=c_pps
 a=4QxnTjFVIeqV5CvpKlqXuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=doN5y8Ov4thJEN2E-usA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: aNVMDwsXA-xt710QiBTgnyiIaTDucjJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227754-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC94B2E4C63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Ionut Nechita" <ionut.nechita@windriver.com>

This series backports 6 upstream commits that improve the menu
governor's get_typical_interval() function to linux-6.12.y stable.

These patches are already present in linux-6.18.y but were not picked
up for 6.12.y because they lack Cc: stable tags.

The key improvement is in patch 2/6 which merges the two separate loops
for average and variance computation into a single pass, reducing the
latency of menu_select() on isolated (nohz_full) cores. The remaining
patches refactor outlier detection to cover both ends of the sample set,
update documentation to match the new code, and add a minor bucket
assignment optimization.

After applying this series, drivers/cpuidle/governors/menu.c matches
linux-6.18.y exactly.

All patches are clean cherry-picks from mainline with one trivial
conflict resolution in Documentation/admin-guide/pm/cpuidle.rst
(patch 5/6).

Changes since v1:
  - Added upstream commit IDs to each patch (Greg KH)

Upstream commits:
  d2cd195b57cf ("cpuidle: menu: Drop a redundant local variable")
  13982929fb08 ("cpuidle: menu: Use one loop for average and variance computations")
  60256e458e1c ("cpuidle: menu: Tweak threshold use in get_typical_interval()")
  8de7606f0fe2 ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  5c3504109996 ("cpuidle: menu: Update documentation after get_typical_interval() changes")
  d4a7882f93bf ("cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX")

Rafael J. Wysocki (5):
  cpuidle: menu: Drop a redundant local variable
  cpuidle: menu: Use one loop for average and variance computations
  cpuidle: menu: Tweak threshold use in get_typical_interval()
  cpuidle: menu: Eliminate outliers on both ends of the sample set
  cpuidle: menu: Update documentation after get_typical_interval()
    changes

Zhongqiu Han (1):
  cpuidle: menu: Optimize bucket assignment when next_timer_ns equals
    KTIME_MAX

 Documentation/admin-guide/pm/cpuidle.rst |  56 +++++++----
 drivers/cpuidle/governors/menu.c         | 118 +++++++++++------------
 2 files changed, 91 insertions(+), 83 deletions(-)

-- 
2.53.0


