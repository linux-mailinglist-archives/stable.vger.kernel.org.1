Return-Path: <stable+bounces-240065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LaZGKsp52mo4wEAu9opvQ
	(envelope-from <stable+bounces-240065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225C437B8F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4941E3056163
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8413845AE;
	Tue, 21 Apr 2026 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZxejIFVg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D2382F2A;
	Tue, 21 Apr 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756930; cv=fail; b=Yg7KSWPqM7K2396hElocWOf81eBSOq1n26Ko+2wtsjAZ1nC2poQSDDEv0fzANRffzlnOouwCGddTtbFky6o9WRJjnLDipk0RiK+/Sb1uH/1mzgxNpaEqHHh01h0VB2pB13lMsXt96qJ4TqCqLd4TGssxxQW8wnZUDYnIVXjiHkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756930; c=relaxed/simple;
	bh=ro+NEVngoJwLV3zH9wmio+fSihSxr60pYfH3e0bNFeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rdVVrMD0K0EYRU5LAwrsUr1PaBJxTJ4DLcweB49NxxMjcD8t/v3p/8pEJ3zP0vYhQGGNtTVZn8fYU2Z2eFTYSG+2ksOR/Ii98keqnkinxirNHx+k0Y/6JifrK7NYO8uqT7PSJr+WzS3+7I7pJCuuNL9dCK3Vd1Qd4QgdwCeSAFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZxejIFVg; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L517X8383621;
	Tue, 21 Apr 2026 07:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=xj1MG6PjxfLHcjimUsHntnROzsCNKvwim/LTNuA+FJ4=; b=
	ZxejIFVgQWUm7/MTxMZikk7jfRTm++dYQ1S26e70lGX6NFAlx4WJgRWsFXRnehca
	Xr6ixYIK3XyOunXW2O7RoMVGCEYaBaXoSbAjbdKmpWwK/LzSL7H/rczICgEtT89j
	XJI0dHvpqzVMwn+2iNGkcjlWg2wfnh5hMJ2eJjVvNgvu27zn76sGDUWpWUoq9nC8
	TeBR6EctaGHFc3Erq15OmduUd0WvcuIRuF3Faf9Ur3BrM06uEa263n5L+/7jiCEi
	VClf9IedAFQRhfOT9b1Prns15vdLvebJpUAb4Q1RNH40vLLGctfg1Q+x37OQ2R2R
	0TdI2O39r+JAix5qoOJLqg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dky5yb2vx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 07:34:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0IUNg3gfyO7A4uk9QAEefcuSaQXMMSvebOrbU7wsTB1LMxYhR+37vzYXDiRZsHIE0pdnOeyhBiCkxo2S2cBAixN/tLNLtc4hsRow6Ha2QSN/Q+nyWekvFC4Z7fvwaBHtVEzWsaAC4IDizMPUfPMDFGaRggSb8mj6h85EXQ63Oz1la+3FE+sWe4+3VZgqm97wNVmgL+MaJ1bUtuCnwKxICgUIZUeniHvBg7g8Vhj+hOUwF7COJVQHoRVcEx2H0zxbKIcSbvF58MeVWogCDUILOUQkrg9xpcIa5sVOtnKj8Lu8aXiz9ru4zxLm+RjSGafE9gbX0JEM09RJAn3Cangow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj1MG6PjxfLHcjimUsHntnROzsCNKvwim/LTNuA+FJ4=;
 b=TRUG1xI1fA8uiNgMy4jz6pD5EUL/ib6gZnjPfxlQFM4REdpQs1Fg+WYm216sDUvX1DvCj8RjTs5KnKWPkHRhjbVnx7A/YeLfUbUEI+RkeZ6nbkKHkVRseLrosPAGR0Lw4z6Vue1Hgn6cdyA/vQ6QobBhUIi5vjnt52jfZGpCI1eI8dGAA5un8G/mSYH7DqTAmUphnSK07XK01hzRZ6tzuQc5Rw0/md4f7G8HlqKTmzaJMVFoc5fHOa7vIs7ectGUWRzahT2lm3C7Z1+Cj1OVjrnbx7H0tx1KyYdj+xA3atahRP08CQqaB0L0M4KRhlTF+PqWU+DzX6vtv/JVIRqUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:34:53 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:34:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v13 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Tue, 21 Apr 2026 10:34:20 +0300
Message-ID: <288517e50996200c368cfe172de86ceb02bbd342.1776756380.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776756380.git.ionut.nechita@windriver.com>
References: <cover.1776756380.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dc9201-c35e-4751-9cac-08de9f787a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|52116014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y+D3RxlA5QeSzpBXV+69xjg40RECnmZMUSQSeQ7PzwBYYTTPZHQFQPo8XvWQc70H+uefl5S+kAPMj98kkNQKOuZZtu7OkFNZATy3qUnP5vKCSdjIntIrNIMtWS2ej74PoPDFBXzrOSnSFohIiG5WdCxtNUjHikjNVkPkMvVab9m+LUgXwZannCARAtP/sSktaK46S8rXq3gsb0i3DUTrH7UOcofYaVvafC3APA8+0CbEq2/uP82/z4muPNiyG5o+NI40vGCNPASC9Aj2Y+NAkIHmEcWlSxILInrLECiFzev4UUa8xDhu4InkwLntPLhee8/XwlTguyAZQaHsS71FHGJF0acJsNvaixrZm2KYBdabZBjvHwre3Yb2CzqoxYhNBmtTPwQYL0Fz5qYduLJHFU1iLdVRFuwjeW7KmtZZKwi0OD2xl29HpIFytvw+3XFEUOvZEb/PoUZ8iXAles2RnnatVWk5bqdaw8pM9v9a7C/ilGBvaJ2sWS+N5eOPJEWe0aR4mDUXcENC8cLl8hsr3pAog+AxevtRugdg34VSY1OS+NLOFeolViQkeVJLL9nvJG6vQ8yWsaaVxSaph+BG4jciQ54tXg7wIkurq81M8HgSAFax6+6F0aasDJ6blWbzw0jso5JhwID9osl7/2Nk5QXyd37MEdjMHyU7M/kC4cNE2k2LzIsg7OMEp3MXhQxfQeBYg77uS4igzyKUQd2WYQpWQU72x6JSBzYvVnZPqc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nUE0ofBkvffITZiC2+Zw6qM25JKcX7/rGztEjnmjPJQN0wbEdwOK6eC/dKZ2?=
 =?us-ascii?Q?+6gv5bbIfgLIffxtJisjkA1s+RiO9EdyFsDjtT2xPMpdPeACE4T0MC2CrdVc?=
 =?us-ascii?Q?xI7zKsO6pvWzKCw+44Am2XD/CYHQW5hdYuqQjAIOh707dajuQ+MLLxInVmxk?=
 =?us-ascii?Q?t+YS1XPKSowYj7PChax/DCYCUSDlDYvIJkwHh5X+C50iQm+3o/gR1SR/me8a?=
 =?us-ascii?Q?qZyvGId0agTrxJ15XLOzo7A8zhXH25NO8G8JSO0ZZhuPawgOKOf4XX1O1iqp?=
 =?us-ascii?Q?mAW1ey7DxaPHq/g0fOH2glUOviwef34Ck1f7OUqa0wz8truHHnH0haTWG1Sz?=
 =?us-ascii?Q?1G7eFie0QJRcJrn3Yyez3Gi3fCTJjjNjlq5WJxD5g/itgPqcSYk6zY/ecD/g?=
 =?us-ascii?Q?WqABBp8RnblXzOduiT8JFxua0ohVrCSGl9FI6xABlkOUNosAOqkQ7V2222hI?=
 =?us-ascii?Q?t5+9cVIjv7Rba4AMQmBw2Q/6CCHkQxYy+Lf77aLQe/51kDFOElJPyurBc21P?=
 =?us-ascii?Q?gtNrWFPTuN54F7aN9lolcaOBCTlScF4skMCWtlr0A8xlIiFk1bGZm+8hLtl8?=
 =?us-ascii?Q?HUfzwP4uG3OU6gNCNKqEHeLJOMgsYolMCJTWMOiv2WCFoJwzvZkdtQ1gjCsl?=
 =?us-ascii?Q?4jDBPssnkYqmtMUQG2xryauIvfEEL5JcVZoiPUM9Qt61KoqHh1s72eK5Rpdf?=
 =?us-ascii?Q?RWRloIDMGELWcjEjQGZKbkU34aQSz5dxUT7fpMu+UIdYi4+Lqol+B/5qkTfL?=
 =?us-ascii?Q?P9WqdP8LlghweSUm2tnBT4/db7A2FgJXvbtb8UkUwteHWpm0EspsHJ4of5sy?=
 =?us-ascii?Q?K1oMBiWpcsnZilVkZ56qkHEuWEFifXVTXgKLJf1vJow4ms9VlFevjT9bpNCd?=
 =?us-ascii?Q?3fHJiMfr6aq8n+VlQpT8NodQcSurMYdPll7hqJPN3J5dGYx+juqYzAhK96E+?=
 =?us-ascii?Q?kcvgY/IXzKPru9H9c8KP17uvOdf5sZ5PK4EIgRFY8jB/hlRF0ouUD1u1cova?=
 =?us-ascii?Q?yx8L5QCqohttMmP3Dp+S0JcoA/mm/t99u3vyUmLIhmH4tmvv1b9RWyfXdUf6?=
 =?us-ascii?Q?9zK6YbFlBd2UJctjPlCk3BgBxzApePOo9DIJSIq3klg5vw/YjynHvDanQFVn?=
 =?us-ascii?Q?mhe1v9KdGLEu9s6Ps2lqAc3wbiOjWTnk8QcyUk4y0hkyVg8KgsmhVxVpkoNW?=
 =?us-ascii?Q?VR1qulECTeRwL+khNK6k3YgHThbFdVJq1g3ZuCiAxDjRibax0bktxU6z2bDE?=
 =?us-ascii?Q?lwndGVjUC+n+ny9rBdIITUQG4YcPPdZPo9gxv10VRuk5xKKzd/gZO6RCSYeD?=
 =?us-ascii?Q?3WN18kCX0+OqIsM0vM/cAUZi3Haf1cc6XVGHSDyLmgpfP009PM7KKs+MrA6k?=
 =?us-ascii?Q?0Wbh/mfkxpMYsMre/eNehoKTgTBc6cooRIjKqcSZPOt/mgZAQnBfdyCL5g3w?=
 =?us-ascii?Q?aK2pwTinLS0+IcfRmtzcTBlm2MssJ8VDb5sC4cJ15XX+1U4vgYtpEp29yEDm?=
 =?us-ascii?Q?SgftAZZ3oVCv6721XithNpYAwa6DwBJae/WUhJye9ImN493PtTeQTyHoAgZn?=
 =?us-ascii?Q?moWSpzSspJBvSG8eDJMuOs+gK0T3Ocpm0cG9ZTExvMRQxTA39FOs/ZyaDGTb?=
 =?us-ascii?Q?FmU0CUXhgq8NZ7UB6u8aGvQGSvnet63CfM7PMVOfI3ywYX+xHsfSUSROEpmn?=
 =?us-ascii?Q?77Hhi0yJE7mK0rZY3WgJIDxtFaviedz1g9075zYP0P4VU1G8CGMaFxybu/zm?=
 =?us-ascii?Q?xV2a47q7KAgblbIMLe8YWwdzhiFQdrIoiaO0f/ZYEkHH4a57/Wn48VwgH+GQ?=
X-MS-Exchange-AntiSpam-MessageData-1: FF1S+ND4FyBVA2sj5rhiDetPSRs/QscvMJE=
X-Exchange-RoutingPolicyChecked:
	E5yB0sBBZSajDCJnCdyvPYHHFm2KTRysH5Wxi3x6XbQhqQYetDdaOlWbNVhKl0UPBQCbxzhT4ELQu61wwDs1+1x0iGGB2FQZP43rvLM0+bwsFBW9FbWUHV9etI68cJ8lliDFEYSK+2CmkDoPL7/PIxc5+0VN2hu+owj6Sp2seDD5WvrbpaaUGh2fp4lGxnTBcix4QQ+8IlSviSJwSxeObElx0qRaWtASLZkYXwWjg+2lsU6UkReag6TAE7TfIlLHd0Xyvyoiidr0LyuJvEhgNYyEfhv7rAOVPPCZfcFOkoFgs+dpPRuaHESo3oDdS4doxZIbDe9MfCA66JAa33ocWA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dc9201-c35e-4751-9cac-08de9f787a98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:34:53.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBmi0Scw/USkMypXTEKr7ftfY0Ojvnx7nzY8GbBBqAbbzja3YbKAC8/oeOW9Zws23Yq3+xqPMII8RLmQJ1RfSFVqY6S9I79whQVlhOm1ILw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MiBTYWx0ZWRfX/QNndMXjkHlu
 BVLIxZzbEMhuIkWKw5dMWlkbYabmg6cNgrfNHKowTwACX72a03RPH6A7xU3EX8Osp2sjvOBG4ay
 5LLy9vh8w72QS/3FIj4fV4IHAOAf6f9Hs+LgbMj10fZRyU+JbE1QOvZf7Eh3bENFDxl/QnoYv38
 iFfhGTjjELnokG0i6ecAw/F97404blnyYDZ5ILc1dd96daM2DF3wKwDqngv4On1vNIqAFOsNspP
 W6XpVXE6GImdzQuh7NjWDgNBIM/6Eh4rJZbA5WsDEL0YRmqlRCHJ5p3ogDDo5DMnAYwKVyq+ESz
 k2iCDpFPB44dI159HePeAT8NKhdGbexQDmoMBg8y2oE7BI50ta5o/Ct/oWsCi6ramEN/G7f7DGT
 dBaXzWiq/sH+69hVp5cILzdgDTf8eIEx4iouCBWSyzyDlQCNlnCuDHke8fWcSEvxhOH1lijrUR6
 daaFGj5UVDL1heTrQ5g==
X-Proofpoint-GUID: WQbKc-ePUuOVm0h7K2y5s1Chu5LpS6Jm
X-Proofpoint-ORIG-GUID: WQbKc-ePUuOVm0h7K2y5s1Chu5LpS6Jm
X-Authority-Analysis: v=2.4 cv=Bp+tB4X5 c=1 sm=1 tr=0 ts=69e7289f cx=c_pps
 a=PWz2vMGk566g1z9MD32Dlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210072
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240065-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid,wunner.de:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2225C437B8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

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

Make pci_lock_rescan_remove() itself reentrant by tracking the current
owner task and a recursion depth counter, as suggested by Lukas Wunner
and Benjamin Block, since these recursive locking scenarios exist
elsewhere in the PCI subsystem:
 - If the lock is already held by the current task (owner == current):
   increments the depth counter and returns without re-acquiring,
   avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, then records the owner and sets depth to 1.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the depth counter and releases
the mutex (clearing the owner) only when the depth reaches zero.
A WARN_ON catches mismatched unlock calls from tasks that do not own
the lock.

This avoids relying on mutex_get_owner(), which is not exported to
modules and caused link failures for builds that inline this code
outside of the core kernel image.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..7ed902539051 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
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
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..0e62081bc5e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3513,16 +3513,30 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;
+static unsigned int pci_rescan_remove_depth;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_owner == current) {
+		pci_rescan_remove_depth++;
+	} else {
+		mutex_lock(&pci_rescan_remove_lock);
+		pci_rescan_remove_owner = current;
+		pci_rescan_remove_depth = 1;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (WARN_ON(pci_rescan_remove_owner != current))
+		return;
+
+	if (--pci_rescan_remove_depth == 0) {
+		pci_rescan_remove_owner = NULL;
+		mutex_unlock(&pci_rescan_remove_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


