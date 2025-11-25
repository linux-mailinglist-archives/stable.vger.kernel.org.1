Return-Path: <stable+bounces-196838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A56C831D6
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D65C34A15C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0391DF246;
	Tue, 25 Nov 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NvNbaTSr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084E1D7995;
	Tue, 25 Nov 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038235; cv=fail; b=e1PSyIhDcf7iaPPcqDVKLHarKq8Ffn5+NKOwL9DptWR7WfyijoDvs9k9cIY3pC8VBN+KJMq7ZgiKdR4sSif14atAYB0BqTgXuzoxy3A8XLrKayMylXtiZWuuLZQVNcrFZ52Bv0cQN4BYLqqFC1OWsUG8H+nqVhmsy3g+qQgeyaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038235; c=relaxed/simple;
	bh=zCwcurHs+b/swRkA8gGwBNYjNarevu7trsLT/Cb9Js0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U4ANNj9TMSkHxSNUWfFMAbDYCkwPGa6Kk/iO47kG2JqmGWaXiMTDICHSOHWWkCASfIMmlEffDn9BqMos3zKLqzFIxMsM56YSQ4RPodfCHTkgu26nPR5bCsSuBWKZU2uAn8AhjxsBm1CReMHIuFICfBWkWbtI6jRYVqnwJ1ayIV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NvNbaTSr; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1ooD33152590;
	Mon, 24 Nov 2025 18:37:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=UoV9Mav8Y
	jqhVZNRb9Q1D2bcIREewitT4nrv/4TlEl0=; b=NvNbaTSr0pB9APSB6kqgvUb3M
	pfRV6NneG8/kPVHp2q7ndezCC15pRlEakdFSVWcj/Pk5fCOGtjnPnptRqTKrdFsK
	i/KW/JOzoc0yZJJ8aoIMp7CioDjHkV2JSOlL7kd3KXy/liXdmY3am74sDOge8wck
	BTHKKXPrLMXdcXep5aOiE9Lr2I/P1GxL83eed6TIsTXobiYIDtVW1v3oUd+5+pZV
	lJkl1JoNY54N1usmEHH1/3gk1lhJi7hdSk7HMYTjtkCwvt+X+juUOxjXvgaAgqpe
	LTJv9yMmeQ71iPpDOH9AEkkZqjao/0ckRl/Wf9g0uCCObpk8bh3mUdY5AWZ4g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5aecq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 18:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAYlsBQbfcU+bXm1KPapK7IFy5jdUjtiuyaE+xG6kj7H7PIPIQomSitH00Mst6Uo8YUQpiEgGQT/rQ8SzENb+avuKw4nzqd8b9PjRNIBFfCG+mWllJYX+e0E68GW8Y0kvpapSOPHY3KNBq2aazut7/Q7SDnnmajTBWnNEnkD5tz6tWjCvXJtpqOOZreZPSlTtFzOi0YU24wvMK/JzkaTPnQSMfubm0/15gHj7WTSMYmURFi0Q0hQbc8G9yZ0yP9Ycd+kia8w+TdFC3aaFTJo7GYBoFxKIehf0SukBQOoSy4b/MFBaer/1X1nALF1QK0wyJIU/eJpbEDcw/+I2l+orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoV9Mav8YjqhVZNRb9Q1D2bcIREewitT4nrv/4TlEl0=;
 b=Ux5uDpLhEHcCxWxEzIw3v7cUcq17GUrl3ipklbSMWQ7IAIV+VG/kRtRSeLi3vbuuW2WBgZFbRNSc/yG7ZJoFvikQ61Cs4EdgF5pX7KoQqntZtBbOack01IdpebkYifMIjVvvb76uzLUVy6GLYype80OZ7u0bliM67H/SkjrHWuf3i1sPy+LewPT18hX9k4/kNdWZ9wh6vAiHrrxK7uAqUCB6dumPkaFnDkXpRY4EEu6++yoOmqyC1q/PXFt7U3REcw/R5pqQPfM1jb5kZ4yEG6TwIVmrdR/8D8G6pUwqWsvcPV+PpkvTf7iMJHVMy/aH54vUUcJMRGuarpoCVjPZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by IA3PR11MB9037.namprd11.prod.outlook.com (2603:10b6:208:580::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:36:58 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:36:58 +0000
From: yongxin.liu@windriver.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        david.e.box@linux.intel.com
Cc: ilpo.jarvinen@linux.intel.com, andrew@lunn.ch, kuba@kernel.org,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
Date: Tue, 25 Nov 2025 10:29:53 +0800
Message-ID: <20251125022952.1748173-2-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5072:EE_|IA3PR11MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d140023-5a79-420a-cf7f-08de2bcad661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x25nT4SufMsKKWqE9c+HSg8MncRHWtgnA85k0xTT+13VXDJLZPc2+yJA0npH?=
 =?us-ascii?Q?rB7aZG4Qj7jn+lI5cYWy3izYZKJwpNTNa5SVkIKsFtVdXpXK5L5XB6ZaETxj?=
 =?us-ascii?Q?JH3l/oNBjFtJTJTX37iAquh6eduuer+3KnscHI9GNAyOJUmIyVQojzw0/s5p?=
 =?us-ascii?Q?O8WEArYx3Q7y1yHe6rSLKra1Mymjqg2/7YuwYmQer6XkUyPXCSBanfGVFBo2?=
 =?us-ascii?Q?OHNXnscL0IR1q1YA1e4HBb0N0/nwz/kkkOpKI9eV6Bc3zA7OrrivlMRsHhRj?=
 =?us-ascii?Q?HliK+CYSOWjdXPwzjaR4eDc1QIkFsFQ2TwtLPMscoUDPRPMcJBCyqMJhCAAs?=
 =?us-ascii?Q?0bw2AI8pctAn7IugKJBc8FA3/cYHUTlJA9Kt6AZIDDa9runI59w12hmpiNWf?=
 =?us-ascii?Q?uVVtu1qpHdMSCFaZNlObI7jNv05Q0gwFDokGgMQvIRmPoLJTxQ77CKCGAM3N?=
 =?us-ascii?Q?suVFSzv33b24QwslxXbPWxIhV9fNq30bgkRttbUfvgfi1NVQhxFURXHo0R/J?=
 =?us-ascii?Q?5uHJM4Hs/cyZAQQPdIC09R2jG7HUBpOK1Q2RP78hICeEPNQswGIp54y32tza?=
 =?us-ascii?Q?dXQUfV1NQjuhX95SrRvvOUO1pIAp6t+2xuADZAd8QXtTnl4KBiZgRMTOxEZm?=
 =?us-ascii?Q?HkepoKLVrBIJrjXU9pGJDNtwUBXL/X19FEbHMLdqJLpY6wWJUgRZd9zj4KF7?=
 =?us-ascii?Q?KWfwUrAzH+e6XWRkj5qO/b7NmJxEJSNau5XLMf8DGqVH2SIhnMzIYtcuJKK5?=
 =?us-ascii?Q?eWYEQb0kKAqPXNK38Gcr9UXxNNWB/DjHGbUn/rvJkbcMRWh7luECxTNhFA9C?=
 =?us-ascii?Q?l6rNhV9q3qG0x1cOMOEZJtd7zFOVD44ZK7k8yhdlxw3j27D0kZ4MKypDomxp?=
 =?us-ascii?Q?lnxelWniOa/NTWq1/2wA7LHGHUsVdJrAUnyB4Y2dRanmvJXbEhpm4ClnqCfx?=
 =?us-ascii?Q?XEc1qbapuvNQCJf4aribcjLyfkIeIOtGMe4H9IggNOmVMDcA/As8mf4qGZ4N?=
 =?us-ascii?Q?4aSkvIBf6FluaQ+MISsvHa7Xizg/BDbOhNcHfDkhOY/sc01aXI/Qh875LneO?=
 =?us-ascii?Q?zkhgnAWd/I3kwQgmY9xAF0X9ifN4Fgc20Wi9QawGNGWEMzVvLGYLCD3rk9Ri?=
 =?us-ascii?Q?/vMMJ7KNH9R/NI2VJG8B35uBdZg9w9N5YcVFYJeZAgYZaSLPfnD3M/75zjTE?=
 =?us-ascii?Q?QoECuRd9JTwVWVvpTRrwgBbCUqKaX3S3v05Mn4fRHF/E35DaWeGrqTKoWqnu?=
 =?us-ascii?Q?rCwPMHDbPXsvOWo40KZ9uKGTWHFYIRhr4k9nr0BPoPl2legDtK3Y9fqU2Vxf?=
 =?us-ascii?Q?OQjG3VjgG4AYEE1ixAocgglAue8BwOrxNCFLGPZG2wTMAg5K2Jh6FP2dtc74?=
 =?us-ascii?Q?CJEj9dVzDljDtf8hVHrx6oSfpJUJ3xo91Eb9/ug5j27e/JlYVlYwRmGZfbgP?=
 =?us-ascii?Q?UIw1DIgL81p7E6+BriJyMhzsKheaK099N3ZGM+fn13OFoYc0ZRdCplBMQl9n?=
 =?us-ascii?Q?mBfM4fh9kA3u2zOy1LjM54SdXoFeaYu7CUl4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1ogLQvQ2zbPPGdEJFkYdliWT7IsLeojfVc1M2+EfgF2ctHsSAwLPe4WdeNe?=
 =?us-ascii?Q?3NyK/exMvZ0ds2t+MA3ylqDomYIxYGcga0hD07KAzJde6qU1ddRykvuubLIe?=
 =?us-ascii?Q?PNUnqp2CKx80FNs7UDOJFGKe/rjJmcHZq2uFcegpPX5ezjIzEA/gHJmMos0r?=
 =?us-ascii?Q?D/+HKcWtBSPglf5UgoU838S81wi5gFI6wIPbD90mUMufirMq7eYGVJkCOAXx?=
 =?us-ascii?Q?m049aUwbOLKNvTcAc2A0zhlX7fNn9JqpgYNMuNBdr9LtbHPpcewyqnCw7FYs?=
 =?us-ascii?Q?VCBJXBA453D7Aff7Etr9Qb7FlP+6bOxjY2PsHC3KS+VEFjz2Fmiafe9gR1Gc?=
 =?us-ascii?Q?xaMNZt4tV2bgTwY767NdDIwvIfqTXcJZAt/VS44bsg4tYFKc5Nm9FI3Fnsdw?=
 =?us-ascii?Q?VXbKrErLoNr+E+DP3oL8JIRO50hlV1IRye/vR1rGfAbd5/RM+Se9T8eGCsv+?=
 =?us-ascii?Q?dZ2wM+Ia0zwxf8tJ4OxExgb25y0R0LLdCSEqfCm10qLI8amIkNibJo7CYtp6?=
 =?us-ascii?Q?IE4HNl6zZP+tD39g9jaxlpcBJr2EvgI2rGbABPIjI3Rvd0u8HznbdzmAuYnV?=
 =?us-ascii?Q?XrM7pMo8IiB7odgMkYe1IsfoTXKZaWUet31qPeExhpMxxqwSohOG4OnovwKC?=
 =?us-ascii?Q?BpF8XgZvY/oUVNaOurBKQyYNfrW2EjOt6I8FTFsApT+LOgZZXTbSfFIw8dcG?=
 =?us-ascii?Q?E0qhg3Ds//apShv9VWxHH0JY5qU+1wkTB346gOyDtcyC8UPKCsSzoU0tDf2C?=
 =?us-ascii?Q?ZFiKB2Pp37YBGb6aFSf+nB95jRv2AloQOP3Wr5AYizRKurJsS9XPW+tnMiBz?=
 =?us-ascii?Q?Ob9xXCOU9YEWhwVS2HZxTvM/Gs0xFuwOIu1f3fGxmCbxbniFr6xlWLrihexZ?=
 =?us-ascii?Q?Vdl7Ccac1w/3U+zZFB3rAnaUD8UY3OyRRDTt1yiEe+INqCuRj23QQoEy8i9P?=
 =?us-ascii?Q?MwP7s0Pud6TjeUCFfQ9VMUEhvaq4NFgikDqhyWSraar+wx/jxHrRgyQXsQVR?=
 =?us-ascii?Q?cfzJO61eR7wpYXlNR0JPtQwI5Qyget4qcFT4AZYgjlkeLNQruT1Q8WB71OV6?=
 =?us-ascii?Q?uVodUVVxZuOLH1TDWzn8cXmlGHRMq3WyvCdkbMvWaNP+UaRKY8h5XxYczPwj?=
 =?us-ascii?Q?R9UEecIjVYD3h3X0AHG40sfyEfGcpa9QYYzI+mDex8PDr7xpWL9bE66DJlSL?=
 =?us-ascii?Q?4N+cHEBDY4BmfpTvEiREn+c/Mk1cvGAt+lM+MG4He/klOZIPTQ5EZtrgvWzy?=
 =?us-ascii?Q?cRIQx7Dh578SzukosvB1lCTTQfAkEJbIW7Z7VuZKpSoGBTDNbawCAr/Q0BKL?=
 =?us-ascii?Q?Nk+aQihSxx26qzDzp3ZjdhsD0lnB9ahoXhvISti0EDDA7N5y45UpdwuzVQV9?=
 =?us-ascii?Q?SXBjPqiwqMuQQC6m+ftsPoalrGYJgxcbvv3f32xwwR6E7f6/QMhYlNsHP28P?=
 =?us-ascii?Q?y7vHBJHbHxDQIJ7Te9kbQvG5VyOId7BcDhkRkE8Ro4J5SZEBmByvpELn4h5x?=
 =?us-ascii?Q?VhdeOysEOLat0Fs6cE7BTGWtSzWJ/htAkhHeK32zEZEgmhiEiFDNSN9Tjlyr?=
 =?us-ascii?Q?boJkbGabbuwrONECLexOHvivQKIGJxJM96HH+nb9QJIH+Y9Utk/CUG0/IYEv?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d140023-5a79-420a-cf7f-08de2bcad661
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:36:58.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnwJqwfxoS9uQj82pTGxN3BO4fsTO59bYm3PvARvK9sY4vrRxIkPVJKFfL2zj4jMx7rftxddJxSqbci1eQBAMBOTp/JKcgi84IJPIUUN7vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9037
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=6925164d cx=c_pps
 a=UA+Ybm6NSixuq697YtHT5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=GLtnJ_i9NkFmi9gY_58A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAyMCBTYWx0ZWRfX12IGUHHRWXlA
 uW/3TSEMHyP2WfzqoantqlvI6QJYveuo3kh9yclK94szg76jHkSx5cd8yZnBDd7bUKHVuf5YDEq
 1Q/VT+DtbOTLBcrF4EfE9O5SVSAPIyiPc+FXcB068hlN+WmtnKa7U0OLDnjvOwVbZaOIAZpaLad
 pKzoJryuFA4iUN/+nzWH9g9cM6AFhfqvHzhAq2ma786vqtrbuGdlD4x/JM87srJbAlndaP+OXzL
 mCdfDFbOaQjrt4Z3wv3KJ3bwN4eeNKkW7VCJ2RGrOwMV5aolp1c3Cgw3FkoXGU8hMHAFmf0B5vl
 J4Y+5rVFIrtnuCJez5vqNxtg8KIr8H5ZIrFk7JTminQKDYzpdU2EWB5FnDHzK3dCamBYAO/cIX4
 oK7ktKgiHxyaUojGRFlCtSKCZk6kyw==
X-Proofpoint-GUID: LbXaXo6yNPPmfuQQn9vY6u_mHoxJw8Uf
X-Proofpoint-ORIG-GUID: LbXaXo6yNPPmfuQQn9vY6u_mHoxJw8Uf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250020

From: Yongxin Liu <yongxin.liu@windriver.com>

The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
for the ACPI evaluation result but never frees it, causing a 192-byte
memory leak on each call.

This leak is triggered during network interface initialization when the
stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().

  unreferenced object 0xffff96a848d6ea80 (size 192):
    comm "dhcpcd", pid 541, jiffies 4294684345
    hex dump (first 32 bytes):
      04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
      00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    backtrace (crc b1564374):
      kmemleak_alloc+0x2d/0x40
      __kmalloc_noprof+0x2fa/0x730
      acpi_ut_initialize_buffer+0x83/0xc0
      acpi_evaluate_object+0x29a/0x2f0
      intel_pmc_ipc+0xfd/0x170
      intel_mac_finish+0x168/0x230
      stmmac_mac_finish+0x3d/0x50
      phylink_major_config+0x22b/0x5b0
      phylink_mac_initial_config.constprop.0+0xf1/0x1b0
      phylink_start+0x8e/0x210
      __stmmac_open+0x12c/0x2b0
      stmmac_open+0x23c/0x380
      __dev_open+0x11d/0x2c0
      __dev_change_flags+0x1d2/0x250
      netif_change_flags+0x2b/0x70
      dev_change_flags+0x40/0xb0

Add kfree() to properly release the allocated buffer.

Cc: stable@vger.kernel.org
Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
V1->V2:

Cover all potential paths for kfree();

---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 1d34435b7001..b65193b1e043 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -49,7 +49,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 	};
 	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
 	union acpi_object *obj;
-	int status;
+	int status, ret = 0;
 
 	if (!ipc_cmd || !rbuf)
 		return -EINVAL;
@@ -78,18 +78,22 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 	    obj->package.count == VALID_IPC_RESPONSE) {
 		const union acpi_object *objs = obj->package.elements;
 
-		if ((u8)objs[0].integer.value != 0)
-			return -EINVAL;
+		if ((u8)objs[0].integer.value != 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		rbuf->buf[0] = objs[1].integer.value;
 		rbuf->buf[1] = objs[2].integer.value;
 		rbuf->buf[2] = objs[3].integer.value;
 		rbuf->buf[3] = objs[4].integer.value;
 	} else {
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+out:
+	kfree(buffer.pointer);
+	return ret;
 #else
 	return -ENODEV;
 #endif /* CONFIG_ACPI */
-- 
2.46.2


