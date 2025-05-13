Return-Path: <stable+bounces-144110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE5AB4C3C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0314E465DFF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60611EC018;
	Tue, 13 May 2025 06:45:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3981EB5FF
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118748; cv=fail; b=GFFFYqL7023NSp6QcSr2LZ+dY0vhVP/JIWR+OTsyuMRPbusDNS3IJqKdpkbmFlRcnn55qO0hS7ghKXOtRCnjooGiyFuz19oVBpNYK38JiLTR4NnAfVOh//BX0cwP4rN0ByRmuo9aOqqtUZK48v78cgbmDcc0XUwC8PS3+sW4CPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118748; c=relaxed/simple;
	bh=g80zzHW6esM967AZjzstuzLie3rwwPmxdISQH5mTpJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jTvxJYobnCaMTHZWL+pQtPFu9opFuRm8iDHik0TZ3uvdbvV6t3oiyphYflQqSMp19kYVVNLmRZFLIcdoTKTT0HV63a+xocbmmYE07WgGSHsPI+WY7lT07M6g2P7iqaWj/6pmPnalZhV3HikhCWshcdSf6pYSaH8IaRWOuWBKlT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4fq2T020492;
	Mon, 12 May 2025 23:45:31 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j233jhpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtAUG/AMXRx1BfrWLp0FcxlEaff13mFzkaR1gXYt53kVpf8MTLtqJWZT44E/Sg0IEZ3nj+cypleGQXhuoZas6g/SUIKI7k7oUasfdnhE8rnVoRtx7XcOkz8uZaRS8MXF8CTsfVnPHduHsWYl/twrcIAtwMWYE3M6cUNhros23kPP+tPSyHaPznrbgiEdJQRd3LPGjlx1k0GN3T/RfhUO3wRYcfK++vkzeVJPme55lw4kXW6zafQNHRzgwMLKA/xL2weKH/XQF9LKjnMGJOhoCSgf9ftwfXMtUDq3AgPIVofc5gA9qq+APVsRalv3XoGsvrDvJol9hi/ApeOJCcb1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3UBVtNJl9OxPaQ/TbxVMnzwzbEzpfBRG7bw/ikMOzM=;
 b=EKSr8R512MmfwHnJbhsyZE+eGYHAEdSzKi0cXiYR/woc/uOUTmHBAiM9oNUT/bjdU0PU1EQliNHWyDoEuL0AEAkQIzzJIYCHigOvDPGue7zV0lNxHuEMJ5VCj7iUTc0luC2PbmB54uVQABD4BnRjLBuvAN2sCjr9a+63EGL+nfAHA+xsf+idN0LB/CvlN4hNweYVmNbPxX8XypBvpMQJk4U6KPUMnkFmL0hV1RccAGOqam90yyuQAkaATSfdRQY+aVdK20aDxdybJPuICpK3ztuhHkY5vaYyBmcjYnjlnwm8EaZNp0FhKz9IKdiMssjxpd/1kpvzYo6TvSL6L1256Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 06:45:27 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:45:26 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: puranjay@kernel.org, bin.lan.cn@windriver.com,
        SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com,
        daniel@iogearbox.net
Subject: [PATCH 6.1.y 1/2] bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
Date: Tue, 13 May 2025 14:45:10 +0800
Message-Id: <20250513064511.1282935-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9709929b-957a-4cbf-7402-08dd91e9be80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vaKMv3SM+ti5TaK4MVUoxqdO3Bjk84kpytU0AgVohNaTGvU+ogKOhmdnmDBo?=
 =?us-ascii?Q?b7R3VuQAzG8ijLbom86OHOtGPdRMbrQrBw0029loASq0IE4FMZWXWQyZoah3?=
 =?us-ascii?Q?nGi1j4vdpzAhCHZvh621c8sA2TkHzK6etDWGXu/XeCLavBxE3UMOycxb35kq?=
 =?us-ascii?Q?TY60WpS/JsWCKNY2sQ08jj/7ogDqiNSqHznhjI8XhDTnQgmxbmGvLIZRxW9l?=
 =?us-ascii?Q?ofbL6KWnqMW+VAZS8qyWvQnnObtKqtk6C5Bod9pf5tjq7r/O4ddZvgrNM7aV?=
 =?us-ascii?Q?JK+uuCK3aQp0m9EYcCAYWOEOGNwkVzFo5nJkAVi13g5kX7zh9d1DNajTtqNF?=
 =?us-ascii?Q?N9/J/p7ocW4M1gR/M2U+/8qnTkq30acZ6SM6Lpdrze/mbAAkdoRqw8+Dl7eu?=
 =?us-ascii?Q?BOR4Lz+ylKtxN91rncgFa86ewRvbIeP7YmuGn/UCJUDPP0E17jZiBjzt/t2C?=
 =?us-ascii?Q?1RdMIOIBBBjvtCI/qAmrjPyNAyWrOcdVQVedptaXvwJ+abtlOhH5LxBHpvMh?=
 =?us-ascii?Q?iKv/1SDFeA2T27aJTEnDPASw1FwRpfaxA3TF4WUiBHl+DZ0AKrLhvG030FHt?=
 =?us-ascii?Q?352O2H/DdjYCa6EOM5pVsvSdtGiVoXy6V0beyYi4VlHCc0zj6PfTtFElvZgb?=
 =?us-ascii?Q?gfE2/yCbdKeXbrsNmwxUvFFeeHLhMp33DFEGgrXPL2delv2DNbPG4mfN3b2d?=
 =?us-ascii?Q?461Qj3QaHSg193MsbXARM74DShKA8+OWDhKE+IH5+++vXW+cR3INuwSL5RXq?=
 =?us-ascii?Q?qznTfoJL4+XE2Skn2cjcyIFOhewxPt+MyfH9HHfvlyu+Y3h0JuXt5d37WyuK?=
 =?us-ascii?Q?7epifPpA+JjWCCwNX79jHX/afjWNNJih4RwTNRQczzLkhwiL+cqHzs9cQRRE?=
 =?us-ascii?Q?uansKEX5cVZDBwSnqJQKfKv1irqAipcyfw/Dx3Ls0uBEt8nHV/grV72f24Fp?=
 =?us-ascii?Q?aWJMgNa8e706/zbIxRA4d6rOYIbbUXdCRJjbth2dTcLTfMR/YoukLAkddv6V?=
 =?us-ascii?Q?xV2OwUEyQQzilTrIY0MiCcKB62H6gXpOuBH1FWhUCG5waaeoeYm866XuBYj6?=
 =?us-ascii?Q?ITvmxPSI/H6qBlEPUEaW1xFn3QlSo9sfbjLcuXKLGY5tOODQAvvdBkDn7cwI?=
 =?us-ascii?Q?rsrKVecg1UWMIm2dYX1D+C18gnSzXY88JDpOMKyuEH2M7R2bp5/llAmsr0zZ?=
 =?us-ascii?Q?pTXM3zT2X2hFOlcf2Vz8TfvVUUCxB54xOe6rw1rwSfzQ6DkUGUIZMj5MXZrc?=
 =?us-ascii?Q?d38qIpnBdm66kXwQQTdB/4DldlSSyAG46CQKpBRuYJvBDGAlMWBTR9Odiu7p?=
 =?us-ascii?Q?8CTVYunE/430UmWXllE3g7fnE0iwbGXTilHEER2229r4sjHLKw0R8NnKk9Rb?=
 =?us-ascii?Q?UMG8WtROxwTJlYpbV1Gc+y7+qKPLZs9rqps01WhxwLLq7mHOBTPBGbl2XLMy?=
 =?us-ascii?Q?Zk7X5OD8I0Hy9YUZX8zhmb2GQQZpT/8Q5AllxbTF2okW42cYspmqsmhb5npO?=
 =?us-ascii?Q?XA6dcRgN3XaCs28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5TOZAhebLW5xDIThoA41rvnAkntB623YozHHI3ot57eZGPhD74pPryf0288?=
 =?us-ascii?Q?csOpppZnpP1NZbHK0it5qQzD7o4OG3gTGYFVoAQ8FrqL23iDgSC9LnCVgYlz?=
 =?us-ascii?Q?kV1C+fNJD0Ag2KPBA0cp1+RtzWtexMidm+mfcFKvF0x/N/OY5bpNZ8NDo2EI?=
 =?us-ascii?Q?ktPRo6X9WIonYjQioWU72KtiGXCL7U0/1Kd8PIU+pdnXiD5EggAfXV011/03?=
 =?us-ascii?Q?cxKG7rZ9d3YZEs7BNu0QdXuNxnmFf07OqChUSsK/tnE7NEzTaXKYEM+cQzsl?=
 =?us-ascii?Q?33BbqqK7K5YHmUwwoQHlkERfTedp91MqVnrnpqX2xVoYYH873XeXs4r5jfBl?=
 =?us-ascii?Q?M1v5EB0+krmxO8yslqiTJJi6rZF2g2FUwSTKf1UmMeVqNj9Dte2ya6V0IZaE?=
 =?us-ascii?Q?Tp1UsYY+cGMpHLx7ukZ2YxYF6uNxfT5rBQsbA8Llc0J9vzwSqzi0EfRCPz6r?=
 =?us-ascii?Q?rzn/rJL44zmN94SW5GsVipr7dlWiWvAgcTX3nZsQ4UYOoU5MZyECgve9jsSp?=
 =?us-ascii?Q?4HChgE0fWXxEO7jKmsjEv+km1sKj+N2ajdt9rjBRNqHIvoDGBCDa3sNeH5Zw?=
 =?us-ascii?Q?zcaeJy9gQ2ZSxeUdhBMoeVNdvRXOkscyeQ5doE6cAeIRxnHDTy6Gbi/oEG5k?=
 =?us-ascii?Q?7rKEq8taWdfUMB1SS4cisRrwxabtIQax8XudkidSt/lDnh+32gFJjcoqI7nJ?=
 =?us-ascii?Q?AhJfkrSYLjMgOTGVvmI5yDmPv2XyTrY6m90jY2zddb+WyLSfmm3pkwQFpDdr?=
 =?us-ascii?Q?iVPnSZc3v42Z0r1m5fuhYQ5q2RsZEOlpRcAOAz/WQ8dhE7tvEJ7WcOVd7ctF?=
 =?us-ascii?Q?gYCfNRUawUnDOA8E+ERuo51RJbLlaBCXFDZvWAFSJ4TwmE1bL58bMd/eiI7z?=
 =?us-ascii?Q?5sAzrxltBipQpSSOSWsaDaoXGoOloyMLGjvGBLHsmrHTHwz/jmRIEhxkLL25?=
 =?us-ascii?Q?G+RMiTT0q3+Rbdw05GueUXW0Uyg7yYZc1GhUC85PmcvzdVl3bVJ+jpnjHvHz?=
 =?us-ascii?Q?TJJaCbirsNg4e0Y/D/cOkSvBm9isH3VjEr92w+X9Cmbpf3nucMPeXPnVci64?=
 =?us-ascii?Q?ecZ9Gj8RWgK1sYYHwBdkdZNrc7oVbDKQG/wwnlZEQKczkNUeIMWPmOTNr5AU?=
 =?us-ascii?Q?mkQ00yJ7H4G4XboVW1s0NwCdLX7eUxuCtnVpEqTHBF3fO9g8LZ2aAc06Hjzu?=
 =?us-ascii?Q?JHw1uhWWD+aR6CClwELbT498z/4QU/RWbWJDJgkQry18mtCej7MLhbXq1zp1?=
 =?us-ascii?Q?48o3syZNwbyYwap8Ed3X5hWizFMQ+BM0OOLEbJojd9PkFEQRfd+2nhjlfi8q?=
 =?us-ascii?Q?s497/wC6FayDp1q1eGiRlzdw8UhqdVOxUf/pMbbeIngsqOhV8qcA8olU6UnR?=
 =?us-ascii?Q?HUUt9V/EjCCUEJLpx5fbRgrEVd4U/vZ/RkiUjyJId4gNy58PI4wSZyjMAtC5?=
 =?us-ascii?Q?+58FHDAT60X6cV79RZMvKS4ULsZvsdqmsr68g1AU4U1IqaE1LbAmpyJb1yUQ?=
 =?us-ascii?Q?b2snfTSD7wI0zCUovFb7CtNdV+aEFhF9bIyyWI8GTaLgoDRasDmZ9FvJysg2?=
 =?us-ascii?Q?98f/2K3EyoqyMgKrYQYMvWF2r2r/52RTN0vf9ajnK89eLSvcZ0yWFpYj1pS+?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9709929b-957a-4cbf-7402-08dd91e9be80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:45:26.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+VBPOP6FmDTagtNj/+mwjp8lptTkxZReIu+sD81HC+c7qrzcHALpHbYQTvMm+yht9Ocyg6JiDnkgSVaX2oqTB7rqIbLZiEQNjNt/RADDdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-Authority-Analysis: v=2.4 cv=EojSrTcA c=1 sm=1 tr=0 ts=6822ea8b cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=hWMQpYRtAAAA:8 a=t7CeM3EgAAAA:8 a=-PzTzOnoyufgpEh59qkA:9 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MiBTYWx0ZWRfX9IjipH/v7qQz p3SwcKkqrX/eRQuXQCjp5e//PxE3t2abK+E3EKBbmrU9PRhHHPruleUVnfHH91zfVg0ofGvevFO beCFc74nSVcQ51h2sD4pEPJtVt6nD5xh58BGb9W15P/ib3B1IACCdxERRzqZ6XuyUG8ODNc/kng
 iw51xVHEj8BZhzMK3I5kIh5mownMSeqidC3yHTPmaQJm8BXUAt7EoheeoKsuI1C8KMxTKQcLhtb 8QFchcwjQifwfMBhe5DgZ69bUgnpIx9e0QC4LYGyR4LID6sjJhrjjerr6sKUsYQbMgXh642bOd6 zKaHFJRaByyYqP3RQ8te0HKehIPZnqUyDYlDF7UTVRtADYTUOYpXOP/rsOvPZt8/LI4dpyOubBS
 0x12B5/t+9oTSNOqFkwZnVIJvlJl3yxZ4fDcMA0uEjYfrr2/RRTJswg2CO/JXcFfbmU140nG
X-Proofpoint-GUID: eBfxXfxZrF4bH-niygA1a2FL7qPFGKQ7
X-Proofpoint-ORIG-GUID: eBfxXfxZrF4bH-niygA1a2FL7qPFGKQ7
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=986 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130062

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 19d3c179a37730caf600a97fed3794feac2b197b ]

When BPF_TRAMP_F_CALL_ORIG is set, the trampoline calls
__bpf_tramp_enter() and __bpf_tramp_exit() functions, passing them
the struct bpf_tramp_image *im pointer as an argument in R0.

The trampoline generation code uses emit_addr_mov_i64() to emit
instructions for moving the bpf_tramp_image address into R0, but
emit_addr_mov_i64() assumes the address to be in the vmalloc() space
and uses only 48 bits. Because bpf_tramp_image is allocated using
kzalloc(), its address can use more than 48-bits, in this case the
trampoline will pass an invalid address to __bpf_tramp_enter/exit()
causing a kernel crash.

Fix this by using emit_a64_mov_i64() in place of emit_addr_mov_i64()
as it can work with addresses that are greater than 48-bits.

Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/all/SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com/
Link: https://lore.kernel.org/bpf/20240711151838.43469-1-puranjay@kernel.org
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c04ace8f4843..3168343815b3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1893,7 +1893,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -1937,7 +1937,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->image + ctx->idx;
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.34.1


