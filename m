Return-Path: <stable+bounces-223722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNTIGaUkr2mzOgIAu9opvQ
	(envelope-from <stable+bounces-223722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:51:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F2240591
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E90AA3028533
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA0410D26;
	Mon,  9 Mar 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rCTLKR20"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD943491F4;
	Mon,  9 Mar 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085817; cv=fail; b=Rt7agvicWtPwjPVTvHCv/LQvRhadUA4uER0kl7s++FwuE49mEXyRpHBnEzfUTQXtFV/qDJTlVnkzZuvWdVgujgdMzQWoeqw3St9m3DH+n2PsjE53Q/Elh8uWxxN7qpVGKmHk6ZX4VgyH0z4jXwJ5/7Zw2d8j58sdKKYfD8D3aHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085817; c=relaxed/simple;
	bh=nDLLjwDfxbyaAFCFkkSX7MLGTSf9IZU8+RSHm+pllOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQGufX1ItT8mFpDmG040r31tYyBW0qvnTWOu2MOl48CGYHTao6VMEnSBprPG24Ux6NblPwy9nHkVxXlPjX3A7PV9gj0bgnjFDqTwN+zc0Y33gXf3gASc6LkyA2Tr5a+OkwM7DLHFhCXiKw+oaBDZukbpTvt8EWfOmH3m9aMrIJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rCTLKR20; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6295JF1l4055645;
	Mon, 9 Mar 2026 19:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=s0gvwq8UwL+8qQnRN0yTJP4UZNKlMzcBSFF3Iz3qz2w=; b=
	rCTLKR20ETk/quOm0+pEyGT12BY5IIrp+RAZtj14mYPjot3w5ZFhVT0qGXr5fjb/
	m31U3zOs4n3uzukDO3zPmet1lGrBFdcZGs2XzlnulUE4ycGJkJB+o547GoRx+Rox
	FhjEiz0TTqvIrrWIRXRfBpIUD5JPuA4gGAgZAXcm4IZtMDVMvoECRfOwMZwAQdVj
	Avf4+XGih5OrkgB7NYGPcCygZMLRonBzazKMSnxGc+vEKVKGSsit5/LFkoLtS26Z
	IsvychFzeTqWmhg/VdsZe+r/y+v/hS5vcXlQetV30mkUoyiqh6oM97MFBWWChFZc
	l9OxrC48be/EQoN9vkWWig==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb082bna-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:49:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4XWpEgmM9TwRG8PkUnvWJXYFBT8uoDik/azpb+//PfpF2exP6o8Ty9N1cHHLcgah0T2Yv2+0JazQNkNWscKfnrdWBw6nAsLO08M/wqcl4UznDmCFuqz7h7+uVgZ56/i8GG8ZuGiuLRfomPrgDuipg/cZMx++uquKTIKGHtAQWblNBLz0/cVplbSLpw3ZF4a2vxGH7mrODNZjVLGuKZH+nGKiT+zIVXRbRm2/s5YGeSnWrGvvNwlgUPw8PwNRqwxXjxfqZigiDhOJRHMWFd3k/LlZXJQgzF1/uCLlRAtZ30MuVKqctwX7MlYMHB6WvxR0tP+1H7EBCbQb/gJetE+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0gvwq8UwL+8qQnRN0yTJP4UZNKlMzcBSFF3Iz3qz2w=;
 b=yJkZpBoQwFf8Mz82S3e8jWOBQhAIEzckD6Nb6K2Z6AjFRVrCQWlojxYRggqA0ZdmzUoIPt+7O+3I5YfH3FEFsEQUI+ttIzKLyQWihD9Hxu0Tc6wY3/j89jkht2rMixqITVVOYZ/kdP+sUIYpa7EqHM4hZ9kTn5Nder7rlTp8BNzbfDrrVlCnZtvK2NDncAZ02XrlrpPw6Bg70hUk39d3stRrQHrJ84DClZt8D5DpaS5DtjpO+qFW/CEO9y4Bw+rSOhRe0joirRSMx4vFurDRNUzX8aFnVx+D/ddFg3u4VkhGOvt9VvWxJ2q0AuZsgWL71L+itjduvxQFiE7hjD4ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:49:45 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:49:45 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v8 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Mon,  9 Mar 2026 21:49:19 +0200
Message-ID: <20260309194920.16459-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309194920.16459-1-ionut.nechita@windriver.com>
References: <20260309194920.16459-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 93429555-fb6a-4ecb-ee12-08de7e1503b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	jkE+C5iNmOUuuiIKqwpTMKh/scPuJz0qFIzfJHqr8UWZe/8l3OUMw9YIvzCRmJvL5m1WDeJhMkpmOfnbh396+pNYjsfo7xOKXMsFmnM/nehbjPiXJxtnyqvF++y7gM+y1kgdffBDF76QNowXGRbVrCvZbYSrDZdzbprYKs3TIe97izwrdq/tWJbDnnVQxEQ7MWfec+Q0+Zb2/djc+xNkHFmdQ3a2bofMZFMGe8Cs67GBO7rueTh0MVjVtAwiUdqrmHNZfazN5hKpLdFVtEXXuexfaUvaEWpS0nIqLz1rmZER5nvKYeX0SmKf6mhZDBEjchGwM6GdFe0CvWo9AM5bgkocV0jJz2CRwz9PtPuPXA5/wpxjnHc9Lh4698CVVSe5oQdU1sob2QuJgJ7Yhyv3fx+JeYdRw7bZbcrMeHrSCPgr/nXM0pvu/cLMtu/2I6jnKUhTKxSDEh74yReddStLpcGT1Ueynzt9ZXHeLioiBBp+C8MepmmDxR7xr0RhxnwT1T9jC8++VW4ev7/sPOz56oxtkD9BuiW90xuvxcHKlfoVna1+9Pf6l/9OTg2sQHv6FwUnkHSJDY/Z2xxNqYIZLslsIibV6JsZXKsRyXo42FqjK0UHX6o9qNnCIcizDdp3P7WAwBPjWLumHN+QCI16TxLw+hi1MpcJXirAyYY9Pw+nmy8aU24dutyJBX3o+Bi/vPDF6ol3LcZqMrAzmjBchKmE/CDjwtM2yBS6wurplWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZ3tVK/vg0zc8eb/qN18RujHwo0bRANnyuITAN0ISBt5rkf4C1OeJAIwXcgh?=
 =?us-ascii?Q?tHYkDBK6BTJ//GqlMQMzT3ltu/bLIX775s2Qqa39uqjTU43FXRD14fpSQ06U?=
 =?us-ascii?Q?sGQP0dx56IZT1ODDOulrB8jDuHhp1qx2DqW9VpVDmsfhuyz0yYY6jg9Pzvo8?=
 =?us-ascii?Q?eg4G0tzV/YMGDBKbxqrxNvfpgBwxpq3CFfdZ4nTgEQx7n/8lZLfkTaYn4uQ6?=
 =?us-ascii?Q?751AFRLYCJOuqdBnrv3806H86FBnjovIPMA4hzAEWxfC4e/hD62C6yY0Lwsb?=
 =?us-ascii?Q?Zpi8rkQ4QvTXUqGaFhxuB/vdtdBwlcoBoqsQAaVIAKm4w/6hTno2u4Cwgmp2?=
 =?us-ascii?Q?maneEcuTkYtTFovagp+YY/UebVX2pR9gyHPfU5kjXNYA/Mm3in/OQtPfn2xQ?=
 =?us-ascii?Q?xZavXyi/bk/bzM0UQA6eMUCCqe5ZkX+mGxcsXaSseK4pMxumt6NFYCuSqf68?=
 =?us-ascii?Q?3UhvO+pk3XU9SLQBaRV32hRGYacbX25Kp59kk30G7EoviMpu0TyWxLyUBadA?=
 =?us-ascii?Q?M8tIg0OzEqXRqnXIlhnrhkhQu1eRWURiFRlR+Xca8H0vfEgqBpv3yvi1UFju?=
 =?us-ascii?Q?hZGKa4AQDPAPFkJDucfMEFAkN0y6oooOHnRnr28LINadUUs5Vo+ZoVLKf+nJ?=
 =?us-ascii?Q?0syXRDj5QYe5Rj3fmW/6MjP97PJy+iASjo0vQShErLZN/T8mURczuD7RS5qR?=
 =?us-ascii?Q?L5ca+49JIAef7zAWtGc4avNAfWWpq0MTZh6jgy9RUkiKsVynDxp3pgoSjkwb?=
 =?us-ascii?Q?3BJ2YBvr42esvrWAJmbMwaBvF/912XO/5B6C07lFYGid51C6ycH3PobscUKW?=
 =?us-ascii?Q?H1RPGlNZHMe1QwAaJ+bduHEFlIwExQOH5akxuF49zrCRQkfbwM5tdJURpo60?=
 =?us-ascii?Q?vTg4Qb94cGBqHB5r/uq1ufmLuSRUmnO4Se5ziB9TAmNUaTqMIpfOrXIAf33W?=
 =?us-ascii?Q?eG2FnBCddXwUhUORJHd0Y2HRA8U8BEGQgVmJp9MNy/fQTlsmMRc2BPLKuAFf?=
 =?us-ascii?Q?oUmF/BdEyyR07Tf7GWlPBq+psJRhodMdhf46p/f5GKLHrMx8AC+Fxv7z7ZmU?=
 =?us-ascii?Q?N1J+yC8FHQBrl+XbeRojAfdM5sQGtj02Yj8w3g8aaEaMtmvluZdtwbNIYLRp?=
 =?us-ascii?Q?8ElHhbex42rOwmJYYMU3Ps+Zzp60ShreqYPD8raTOprrl/nit4GJNPNbQFnG?=
 =?us-ascii?Q?VsmTZYfTyh1cJpT/LEAe7tG3bL1ejSpynDspfPV48Xpy6XXwIG27C6L2/w2P?=
 =?us-ascii?Q?FWH8qebrVdPhH62VB1YWEALZnDNjyuUPxSn7okJqrWHwMLltjpkMD2Yn+JFr?=
 =?us-ascii?Q?6owJI7L8bFczq/0YJP9owtshrpcZOVATNc3QnUdVjAnld3EI9aYrmaFyVqgx?=
 =?us-ascii?Q?TJ2e+VnjwcqwPH6F1DRmo7VQCbCgafhSlnIYaygtazLO5rL/qVS1kKS6WGqK?=
 =?us-ascii?Q?90b8nG435vZC4BjDATmL6QFD9EsNOZ6SclwIPxWGqlh+JNVMCwW+sCJFAr0g?=
 =?us-ascii?Q?39oNSKOmKneKyfeWc9nagtJIHTm8tNKnEegz91sTff2ZxBjbFzlKjBFW21tl?=
 =?us-ascii?Q?auB21io4JogIS+IPwx2jFSIPitaJnNMdKVZYCCe+T5ctZCB65KB2uVVD1Knf?=
 =?us-ascii?Q?IVXL1uCZ6zfWGCcYcmruXNQUBvtYsWuKOAX1a9vTLLO8bsL42hTHLyCr+jhI?=
 =?us-ascii?Q?wLgzvDyjG5D1j2qCmZkKfk9BWTm8LcZw5KpbueNG66Ib5pkE/+CsPXPuk01U?=
 =?us-ascii?Q?xEu1rlj1heauT2fSWTReQT3ejXkc2MqM24BtRTKEamYoY2c7Dn/AisH9E1oK?=
X-MS-Exchange-AntiSpam-MessageData-1: FO13azVNHOlf6+dudkkz+0sFcj9ZuDVjYQ0=
X-Exchange-RoutingPolicyChecked:
	I0yPcEFOt6MSkWOrtK5oDIk0twXIzjMf0NB6rFteiQwZ8eEBQTlz2rrivVUj0NrN9lnBBb2ILQ/qD2V2yjzPaY2WrOpUGhOsZNZZDtyMxqJGGrSToBa8LOYWL9PkpQZwIz8GzvP8SKQzvUok7qCeHrCNizFOdO62ywbLu0Hbj5uPUdx/U4TCfMeQMsC5Wstbw5xznhVmAXMerE0jdkn+tcvWkIEw8yo42DsgQXH2rKldYkU5sutsTLt1DSyYsbW2HmsVzp6vbtdzYDtybGPFXT/Ugr58s5sHOZnEATqmXmFiPny+Xze9vQvHbM1w+cpLgyz6ZrRG+5Jic12Xaw8VqQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93429555-fb6a-4ecb-ee12-08de7e1503b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:49:45.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV8kwJN7S7Uk4RyJBYmvIEk3WFUi4icfSUh+DC1wy1zNmRN8H09OMs7JrupD/11cT4reH7KZhT1iCKVvA1l9eBD+9l4rn3V4tU+zLtm/fSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-Proofpoint-GUID: FLRY_YrqS5NzRBPNotJPqNiVuAB9MYsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NiBTYWx0ZWRfX13r7VCEWY4bW
 YS+Lc4yAdyrDNLOlK8yFabS2HaeJrUPc69WMqH/H7tPkcC0duSkl0aBDDPqQhzx9GrxUt2Dvn3B
 G38vA9EXfUwoG+fHMM5LZkGyqlhO8bPdh1RPsS1ijsstHl2CHCVoqlhT4lW8nZ3DWd7U2+HUwK1
 IwiGPyUWTgu899JKqn4UHhQpBwqQKBlCPYII+eTLRXwBsauQ0C2KDRXc6mDsBga67/ieKqa43MV
 ONDao/vUjHoXomdiCfVljnmRsIeZLsTLo6E0MbQp8PSSNyJv43h2u9ZRhRIU+uxgPHDML39zz1D
 ivbS67OdfnkKKZ1888ejbA+9EHh9Mfagx8rTQi04oN5SilRTyycYp6agX8Oa2s/0rnWd06dvRH2
 dkFnQc+2cIiFw1PQSXYggQNrJIr1kHG3wRgBbKYufzc8Pwl7lqS+4maRVqzQvzjwkfpd/GIAsOV
 pYQrcQxzxPot0FuDPGw==
X-Proofpoint-ORIG-GUID: FLRY_YrqS5NzRBPNotJPqNiVuAB9MYsK
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69af245b cx=c_pps
 a=25df8hqnvvr9QcO7WBwFwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8 a=6S3VQf3ZLieD-afqmuUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090176
X-Rspamd-Queue-Id: 114F2240591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223722-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
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


