Return-Path: <stable+bounces-125856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA5A6D512
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16509188D496
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD20209F2D;
	Mon, 24 Mar 2025 07:27:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C518FDA5
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801258; cv=fail; b=GXsE86KDCND1mflImiGVS8KkNOOqQzMxf3WVJzSjJmfqJ0lsHf2g6aXbDDix1EUBP04Ku57UOj23guAwH2WVykQrxUyKMgHK46zkGwqKzPUAsn1KEi32GdTZqOTSJMJEx7rkJ5TgNM0mbA6Bi+61As94OBAcxXlODqFHyjMBEtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801258; c=relaxed/simple;
	bh=RBGvRtWJPhMztZ8pIUe4xB0CKx9jtAAL6V2aAl7+xBc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tHBIQ5Jj5ZiCxmVr9mtqq+36IMZFyMgOxaWyF+T6rYZCXjuSjVO4hFUOkb6CnXqg15C17MZO7PxDA7YYVYSArzhygXYkDkKVR/EOvECHQo/SCQXzsrL5cQdceGsXxK0EPOpFDrVzvswBH7V9QLAuIvqmweA6owHuH+VLMC+odoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5NIqK006164;
	Mon, 24 Mar 2025 07:27:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1hubd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:27:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJD1UV9D/sMZacmg46ZwKnItBKSquJGYihwfkZ7DzFt8Fmqu/kyuQP/LILgHnyjHjWt+bJMVinbYAGUW71wiFlChSwLaOZh/qu7YKP6nvOjt+YgUvWBGsGJMuuensUlCFOUGfcjMdveVEODbqPjPz+IUvIwzqQVEUMTrBXeqQ5Q6jzPrpS3N7+TI0XXAxVL3Wk+y6+CBdlu6g57NMaogdf5QXui3aHrbbAeOhxVT2+dqkdcCiZfD8cna8G1rYGoujRg0N7GMbEFBRM5vnGnrCKw9VZBXA0Y4/keBKdgSa+Ab8IgkaAB6g3UJF1iCHjMX7Qzw6+Y9Tszf6p/Fm/YJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzfxSHTSq+s5WNiF9H8aTM609IMMyWYKaRRdVqNInM4=;
 b=g0PA9xCFLw124xJPHoN+l/5byky5B+oRnBHYd35yoYKJTBPOHTVF13b5ZjnMZE2+cSAuIw0sk3tyFb+aNOB3IjDUbUjDiP4GWwp1HXNlg/W99Z/ZevCM9K1siGo7JSWGrqXrO5m3MRWLJYeTR0PhDv7aEMNfjOvgYJALr39fhl+YAVebV9XGG2RV9/gi/b4sQILSJmjy3txfWQ7zVuRlcOW0fuakHgWvIWvcpdqR9D1NSM6jK8bckt55K5sqB1HYo7olF87NUxnupa4cavNQ6jk+IFmxuR4F0DGXjKMgAzHOfOYUJ+4ns6Fy0ZJ/iBRsuGuhXFrahWScKWDV5qT8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:27:29 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:27:29 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: vitaly.prosyak@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, bin.lan.cn@windriver.com
Subject: [PATCH 6.1.y] drm/amdgpu: fix use-after-free bug
Date: Mon, 24 Mar 2025 15:27:12 +0800
Message-Id: <20250324072712.761233-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5284d479-f6e1-4cbb-ae97-08dd6aa55554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUVVNjc0RmJsMnc1QkRGTERscXByMVY0MFlFeFZTcXdJZW9RcXNDWDl0bGpB?=
 =?utf-8?B?a2dkYUhBYkhBcTEzcG56SHlxQm9MRHMxcEU2UmhtQitRY0xUWHp0Y3A3cUpM?=
 =?utf-8?B?bktJaXc1b0Y4blpCeThXQmYwU3RsMjFGLzJXc3hLWDJablluczY5d0JIcmFM?=
 =?utf-8?B?aEE3aFJMakU4UndIL3ZwWGZTbnRzM1V6eVgxRlBTeU1iVVF1TDRZRzlGMDlI?=
 =?utf-8?B?SkVxRE9vemlib2d3V25wNENrSnlaYVM3L0JTZlRUSytubXl4K1p3WklET1Vt?=
 =?utf-8?B?blVrL2ZqNmtOaWtQck55UmRONWVUbC9IbndYQTlMOERwTm4zdjk0ZTFxWU1t?=
 =?utf-8?B?bDFaMHdHOWhnUVRJZndNSVFhU3lPdG5kSWx5TTFqUCtrM2xtTGlvVXZjdzhj?=
 =?utf-8?B?a1ZpN0pWdDBkUVB4Q2VuOVZEMmp0S290UFJnSzZabWpZclB4b0JJY2ZBbG1p?=
 =?utf-8?B?bFF2SWFia2c1Nm43S1VKOWNBSUJMelQ1N3pEd1dYdDhZVCsxSUQ3R094MDlC?=
 =?utf-8?B?dEhxYkdYOXdUQ3EvY2FVZ2xrMjV5SFMwSU9DbHVTKzZUVzRJRWZkK2dld01K?=
 =?utf-8?B?Sm5wVFhCTXV1N2sxTVdtczQ0cnVaN2gxLzloWlRodGZtbjF1TnJ6OExjWCtx?=
 =?utf-8?B?dnRFNGd6VGtoRFBwN1RraEN2TnFOMHNCVGtIcVBveDJ5MUNRMmFxRUc4ejVv?=
 =?utf-8?B?cnlHSG1DV3VnNFYyRG1FNHY3SGZHc1JuSTI3NjhMUWs5ZVNiQ2JzMzlkNm8x?=
 =?utf-8?B?dHd2SmEyTjIwczVtZ01oSko1OWhiTkdiai9ubTQvM3dldUlVUjFqVmw0WU5v?=
 =?utf-8?B?WEdjdm9kSzBVZHg5empvYU1xT1ZuaHkwWUVKcGMzOHJ3eHliUVR4ZWRGbFhW?=
 =?utf-8?B?cHFZeWo5d29EWGJycUVxeGtSMW9mSVlZbXQ4QlorWVdMbWJ1dkRvTGFzVWpG?=
 =?utf-8?B?SEFGNFh5cG9sTTduZThhWkhxenpmTzlNaUNVZStuOFhvZWszREdHeEhRazFl?=
 =?utf-8?B?YzFjeURkdWhJTkdHajZaR1hHMjFzekFaNDVNdVgzaGV1WkRsdWtEVTJodTJQ?=
 =?utf-8?B?Q3J0eEM3bXBmK3lxSHQ2cjVOamNXM3pyMmZPY0RWR21ZTFdIaWRINWp5bEhh?=
 =?utf-8?B?emhjTGhVMi92aDlGOGNGRGhJT1RwQXgvNDIyY283T2JPQ0Z5NHpSc2xaTk1Q?=
 =?utf-8?B?QWM4ZGVwWWloTUNjSEk2MGlLQ25wMFRuMXhKNlY5Z2gycW96WDRscmlXeHNB?=
 =?utf-8?B?OU05d1ZTa2MyTng2bktzOGpCU2dtU242TnM4NW5IQ1NFMzhtRmJGVzVKbS9M?=
 =?utf-8?B?R1psWTZtekZ4a3dsS21FL2JrbnJaSVhaOWJOb1JQOXlPWWN0U2VqRitmSThW?=
 =?utf-8?B?cDFaMUNDTlhrSFhwUzZDeUMzU2c1QVVjYTNkNy8yU3RHRkFqTnpaWWl0L3BC?=
 =?utf-8?B?YlRLNVFpN2tyb0g3U3UvbVo4WFFMa2JLSjdUSDJhTTRyTTdFWjdVak80aXZJ?=
 =?utf-8?B?MlQ5TS9SU2Yzc0l5VmZ0cEtGS3hlU3Q5LzhtUU5IcVAzOFRRQ0ZWd3ovbVM5?=
 =?utf-8?B?dUJyRTE4bVljZzljWmlWOTdxdkFpV3FoeDNoaWZuTkZJeTFmWXhCTUNzcEo2?=
 =?utf-8?B?YVBsSTZ3Tmc1YUVjcStQZE9hUlg0b2lOcCt1RmZFTjlJYXBqYVE3Q2d0RUdC?=
 =?utf-8?B?bnlmazlUTXBpRlFiQUZwMmpVcUczK2tXbWFiMDIyL0RvQ0ZKL2pkaU5ZQXFJ?=
 =?utf-8?B?K1MxNjFQVm94bjR5SlRFNFQ4N25CcjRWZmdWZ0luRTd5dmxFVG5xOFpHd1ZG?=
 =?utf-8?B?Y3hwdk5OMzRBTHhvRGlZSVRrQ2F0OURXZkp4N1NvTGgvSjFYUWttajV6dENE?=
 =?utf-8?B?Uko0QmpCQmRHM0x3aVcvU28yRlc5TTB6OTFkUDBYZy9WWnVaQkNzVE4zcU9I?=
 =?utf-8?Q?dDtKYyxEcSNiED0iLjQ32ltCn5Rw/kw7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW5kN1RjTzR6SjhhV3UxbFJ4VDZXc3FHMGxCdGswTHd5QzBVUGNudHZtTzYw?=
 =?utf-8?B?YlE3cjZ4VytSKy9ualFsZXB0SkpBWDZxb2l3Z2NicXI0R2VVL1RXaXE3SG1T?=
 =?utf-8?B?a0dzSUF5MmxxRHpsZXE0cGh2M3gxcHJoc05IbjduTnJKSlNybjZwVFR0eTJv?=
 =?utf-8?B?RVoyRklhenhXeEx5aUJLOFVIdGFVQ3l1M0ErTytVVzJUL0pZRDZocEI5VnNj?=
 =?utf-8?B?azlvRjJjVEhVZXovVGJNNDJXakpCSTBTbTFybGlyNGdaYU9sdWJjVUMzazBK?=
 =?utf-8?B?UGV2Mk53c0JwTllmUmltTlBJSk9LSzhnZmhMQlZBRG9TQWx5K3RNQTJzVHJt?=
 =?utf-8?B?WFBDNW5XbUViTnRoSko3Q2NvZzRIWGhOUU85aE12OWcwU0RqbTlITER4Qlpj?=
 =?utf-8?B?NlpjQWM2bjUxajFtYkIwTWxZMjF6MFNScmdGdVc4djliNDR1dE9QeW90RERm?=
 =?utf-8?B?VzhPWnZERUwyVkEwSFBieFNtSjlwWFBwZTZwbjUxNk5RdElnL1ZLVm1qSDM0?=
 =?utf-8?B?QmlhOUgxU3NWQUcrRGtOWWEyUDVvMGgyaGxyM05CN0JUdFdOWFAxTmxORVA3?=
 =?utf-8?B?c0IwdUtkNHlGUzRHbmNzNzVTeVJoekJOck1kc0lzWDlNd2JLczg5OVNoRFln?=
 =?utf-8?B?QVk2dXJLN0dQNXVJNTVNeHpMQjkvb2dRNjMzODFtNDlZeXg5SWRheEVKMmZT?=
 =?utf-8?B?MG9jOFdRNFNlL0RnNWZzU01LRmVYeUdNcE1wbmlINXdvQ3RSVUp2L1lnSmc5?=
 =?utf-8?B?cHRBUXRwMFNGdXJ5NVhGS2pPMi8yK0Q4Zk02ZHQyUFRIMG13QnJHaGl1MGNM?=
 =?utf-8?B?NzJsWnhWbTczRHNmS2FQNDRLVjF2QW9yTWVOK2p6SzNqYTZGZG9SRWlTUUNY?=
 =?utf-8?B?eUkvSzRHMTdhR0pnZWNUTnpGcnVyaDlyTGVSZXVybzJVL04zVzNPV1JqZ2pj?=
 =?utf-8?B?S2pzcGlId2d3cnZzMSt5c0lMdzBZTlVoK3V1a2ticmlzdmVicStOOWxOWllL?=
 =?utf-8?B?aks0Y3NHZ0RMb0VSWXBCclg5bldaSWZrTlN1TmhITHFMWjJtZGpIdmZqdzFa?=
 =?utf-8?B?QmhoUU94elNJaGcvd1hJbnZxVityT0U0THRySFQ0Ry8reG4xcThzVzNMQ3FN?=
 =?utf-8?B?RnFkU24zaEljMHFYV1BzVnZvcGJMbkZrK0x2M0l4MzdrL1YwbytnVXI2RUVE?=
 =?utf-8?B?SDlWbnpRL0Z2VHNRV3lCR3U1bmw0TVd4anFGcFhoTUpYUkYzZEdoRFdaNGtP?=
 =?utf-8?B?R3I5U2tMVTFCSE5hSndJMHlnOEozSFlWTlUvNUUrb3lWZDIwOEZUcDR5bU5h?=
 =?utf-8?B?dGZQbE9HaDJieG9iTExERnc3Nzd1VnNydlJsUXJ6c1B3Y3lKTVlOdG1Sa1Zk?=
 =?utf-8?B?YjR0VS90bEQvZzFSQkNuSGd4RE0xejRYTzl0T0ZFcG9zWGN5Wis4RWdVajl5?=
 =?utf-8?B?NHRtS3p5U0xDUWtMTytoWXhMWXNaMWpId0dvaXJ2V1dCMTZqb3FYbXNEN2s3?=
 =?utf-8?B?eHVIOER6SzB6cXAyZnhGcHBsRHVpdTkzUXFIbVZsendlOHJlZlU2bFBaMlgr?=
 =?utf-8?B?R1B1ZHdjNXZnMEFFVUJVb1U5eFg0WUNDeHh6SXNWdnVqNWRSZU81SFpBY2Vw?=
 =?utf-8?B?cyswYnk1YkRPd0NISzFqMmdQSkJyNGVvWllpUmhGRzd1eDNKY3lEcHczMDV5?=
 =?utf-8?B?bHVocHpvUUhRUnFqU25ZVGExSFlmR0dJdmU4d3JRTE16WHNRaXQ0RHlodDZ5?=
 =?utf-8?B?d0s5dmtDUnpTVU1JckhuSWRhT09rdUJGeERBNFkxSE5XOVllejlBc2RUTDlh?=
 =?utf-8?B?T2tOWjZVVEdyVENaK2s1WXJsS0xjdUxIbk1yQVhXK2dmNnZjc1B3UEowZzlO?=
 =?utf-8?B?K0ZoNWhHUkpwSEFkQTA3ejRKUzVBQXBsdkJnQXVSY3RJMzJZbXpyZHdRUUR6?=
 =?utf-8?B?SVpLd203S1JqK0xSaERvNFJkN25URzhLZjZHYmIvaE9tZ25pd2ZtQ05DWkM4?=
 =?utf-8?B?ZGE4UzVoUGJJNjdIdkdUc2xRVlFoOFJRQ3BuMWgxUzJRZEhDRGhiYmN0T2xF?=
 =?utf-8?B?ekJDbFBMYnlXc3Z0ckExUDFvdnNsVnF0MXBLRDQ0U3BPVktKMkd2bVA4bnBI?=
 =?utf-8?B?REFKSmt5bjAvVU12dkdJRlRRQnZ5U0dqZGtCeXpRUnAwMzZlcGdiMS80T0Mx?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5284d479-f6e1-4cbb-ae97-08dd6aa55554
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:27:29.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUCEYog5kWPbtkqFyFNJVKhHDv4LHyX05Myr+8XmUaPWSn4DhKCxRmZcRKSuYjZvZK3wmS2RpQQJE55PVDGiPhWJDuxdL9O7T44YXUM3jEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e10965 cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=yujlmxJUa9f4s2p8SREA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -6RCOfOYvq2O6apCoIg8wRU7GojqYiyb
X-Proofpoint-ORIG-GUID: -6RCOfOYvq2O6apCoIg8wRU7GojqYiyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

[ Upstream commit 22207fd5c80177b860279653d017474b2812af5e ]

The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl
to the AMDGPU DRM driver on any ASICs with an invalid address and size.
The bug was reported by Joonkyo Jung <joonkyoj@yonsei.ac.kr>.
For example the following code:

static void Syzkaller1(int fd)
{
	struct drm_amdgpu_gem_userptr arg;
	int ret;

	arg.addr = 0xffffffffffff0000;
	arg.size = 0x80000000; /*2 Gb*/
	arg.flags = 0x7;
	ret = drmIoctl(fd, 0xc1186451/*amdgpu_gem_userptr_ioctl*/, &arg);
}

Due to the address and size are not valid there is a failure in
amdgpu_hmm_register->mmu_interval_notifier_insert->__mmu_interval_notifier_insert->
check_shl_overflow, but we even the amdgpu_hmm_register failure we still call
amdgpu_hmm_unregister into  amdgpu_gem_object_free which causes access to a bad address.
The following stack is below when the issue is reproduced when Kazan is enabled:

[  +0.000014] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000009] RIP: 0010:mmu_interval_notifier_remove+0x327/0x340
[  +0.000017] Code: ff ff 49 89 44 24 08 48 b8 00 01 00 00 00 00 ad de 4c 89 f7 49 89 47 40 48 83 c0 22 49 89 47 48 e8 ce d1 2d 01 e9 32 ff ff ff <0f> 0b e9 16 ff ff ff 4c 89 ef e8 fa 14 b3 ff e9 36 ff ff ff e8 80
[  +0.000014] RSP: 0018:ffffc90002657988 EFLAGS: 00010246
[  +0.000013] RAX: 0000000000000000 RBX: 1ffff920004caf35 RCX: ffffffff8160565b
[  +0.000011] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8881a9f78260
[  +0.000010] RBP: ffffc90002657a70 R08: 0000000000000001 R09: fffff520004caf25
[  +0.000010] R10: 0000000000000003 R11: ffffffff8161d1d6 R12: ffff88810e988c00
[  +0.000010] R13: ffff888126fb5a00 R14: ffff88810e988c0c R15: ffff8881a9f78260
[  +0.000011] FS:  00007ff9ec848540(0000) GS:ffff8883cc880000(0000) knlGS:0000000000000000
[  +0.000012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000010] CR2: 000055b3f7e14328 CR3: 00000001b5770000 CR4: 0000000000350ef0
[  +0.000010] Call Trace:
[  +0.000006]  <TASK>
[  +0.000007]  ? show_regs+0x6a/0x80
[  +0.000018]  ? __warn+0xa5/0x1b0
[  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
[  +0.000018]  ? report_bug+0x24a/0x290
[  +0.000022]  ? handle_bug+0x46/0x90
[  +0.000015]  ? exc_invalid_op+0x19/0x50
[  +0.000016]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000017]  ? kasan_save_stack+0x26/0x50
[  +0.000017]  ? mmu_interval_notifier_remove+0x23b/0x340
[  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
[  +0.000019]  ? mmu_interval_notifier_remove+0x23b/0x340
[  +0.000020]  ? __pfx_mmu_interval_notifier_remove+0x10/0x10
[  +0.000017]  ? kasan_save_alloc_info+0x1e/0x30
[  +0.000018]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __kasan_kmalloc+0xb1/0xc0
[  +0.000018]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_read+0x11/0x20
[  +0.000020]  amdgpu_hmm_unregister+0x34/0x50 [amdgpu]
[  +0.004695]  amdgpu_gem_object_free+0x66/0xa0 [amdgpu]
[  +0.004534]  ? __pfx_amdgpu_gem_object_free+0x10/0x10 [amdgpu]
[  +0.004291]  ? do_syscall_64+0x5f/0xe0
[  +0.000023]  ? srso_return_thunk+0x5/0x5f
[  +0.000017]  drm_gem_object_free+0x3b/0x50 [drm]
[  +0.000489]  amdgpu_gem_userptr_ioctl+0x306/0x500 [amdgpu]
[  +0.004295]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004270]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __this_cpu_preempt_check+0x13/0x20
[  +0.000015]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000022]  ? drm_ioctl_kernel+0x17b/0x1f0 [drm]
[  +0.000496]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004272]  ? drm_ioctl_kernel+0x190/0x1f0 [drm]
[  +0.000492]  drm_ioctl_kernel+0x140/0x1f0 [drm]
[  +0.000497]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004297]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000489]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? __kasan_check_write+0x14/0x20
[  +0.000016]  drm_ioctl+0x3da/0x730 [drm]
[  +0.000475]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004293]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000506]  ? __pfx_rpm_resume+0x10/0x10
[  +0.000016]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? __kasan_check_write+0x14/0x20
[  +0.000010]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? _raw_spin_lock_irqsave+0x99/0x100
[  +0.000015]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000014]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? preempt_count_sub+0x18/0xc0
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000010]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000019]  amdgpu_drm_ioctl+0x7e/0xe0 [amdgpu]
[  +0.004272]  __x64_sys_ioctl+0xcd/0x110
[  +0.000020]  do_syscall_64+0x5f/0xe0
[  +0.000021]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  +0.000015] RIP: 0033:0x7ff9ed31a94f
[  +0.000012] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  +0.000013] RSP: 002b:00007fff25f66790 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000016] RAX: ffffffffffffffda RBX: 000055b3f7e133e0 RCX: 00007ff9ed31a94f
[  +0.000012] RDX: 000055b3f7e133e0 RSI: 00000000c1186451 RDI: 0000000000000003
[  +0.000010] RBP: 00000000c1186451 R08: 0000000000000000 R09: 0000000000000000
[  +0.000009] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fff25f66ca8
[  +0.000009] R13: 0000000000000003 R14: 000055b3f7021ba8 R15: 00007ff9ed7af040
[  +0.000024]  </TASK>
[  +0.000007] ---[ end trace 0000000000000000 ]---

v2: Consolidate any error handling into amdgpu_hmm_register
    which applied to kfd_bo also. (Christian)
v3: Improve syntax and comment (Christian)

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>
Cc: <jisoo.jang@yonsei.ac.kr>
Cc: <yw9865@yonsei.ac.kr>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c is renamed from
  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c since
  d9483ecd327b ("drm/amdgpu: rename the files for HMM handling").
  The path is changed accordingly to apply the patch on 6.1.y. ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index b86c0b8252a5..031b6d974f26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -132,13 +132,25 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
+	int r;
+
 	if (bo->kfd_bo)
-		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm,
 						    addr, amdgpu_bo_size(bo),
 						    &amdgpu_mn_hsa_ops);
-	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
-					    amdgpu_bo_size(bo),
-					    &amdgpu_mn_gfx_ops);
+	else
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
+							amdgpu_bo_size(bo),
+							&amdgpu_mn_gfx_ops);
+	if (r)
+		/*
+		 * Make sure amdgpu_hmm_unregister() doesn't call
+		 * mmu_interval_notifier_remove() when the notifier isn't properly
+		 * initialized.
+		 */
+		bo->notifier.mm = NULL;
+
+	return r;
 }
 
 /**
-- 
2.34.1


