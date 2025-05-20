Return-Path: <stable+bounces-145016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DBABD073
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3953A4156
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1178F4E;
	Tue, 20 May 2025 07:31:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D34B1E7B
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726297; cv=fail; b=svOPRwkPHN5Mu480fvWXi0x44vTo6Md9N3Jon4gmfJIDnYhD+maBr83yKSez2fIRRF3d4hMgTxWkpDyZJxbbfJC8R2rSS1oAcMHZGp8xLLHbjJ4wkuFG+roIf96x46+j+5l1ey1BX8SfuAaGUYBNdIJ2TUN0UHHzESlQoG7noBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726297; c=relaxed/simple;
	bh=A3yRrG7CdZMU9E0zeJEz24Xp7ZobXhrgZkTqfAIao+U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pRgxrFiaAkzGvdqDKmtdHpgYfAJSYPL+Jqw56GrryBf2Ob/QHgn4V+0uJ1sS+Kl1AMBhkM0Fr4KOY1NZutVn4vJt1HoTBiVfQ0k1oTsNcsUr+MpYEnJkkQEJ1byPf6dR5XycXL3HIy++ATMzxqHBjzQsiyzMfFbsupG46Qg8mbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K4xqHv024001;
	Tue, 20 May 2025 07:31:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46pfp0tya3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 07:31:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7KFIerhWEWGSnRyo9tDriDW5hwBNiEOIsF6C6Odtkl9mKATsPmYido7xeAti3QxSr7yOzsKCnh5VUQeRBZHBZ4xvYPVVb29t9EosIyuNNVBy4PbMpgB/ES8F0LsowmmOefE1Y2iXXB1puCSH0R1xXmTlfMY/tIWEYOBNGX9HkmV4PE/mqEW0mApsq5DystaM+aDUzZ4XaBg0B/nnYO2JlfhxItuw54RHEwtLUuuF5RDq3bY4Ip9AE0RK2U0x3+2BJzZniKTvr5xBW7KThc7U0YN8yrYUyJ82M/EvZRXp72zxhBDYw/mCnGadORmzpCyHr32j89xTShILxmAhwqmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kZqjV0dab97KIhHS98q96hY/7brAfvx2bjuKHerxs8=;
 b=YUw7t3dsIG4rBFm62NMcEvk3/9H+62OZqeeTKSIzWHgEbvw9etQSLSgV/xnsgF5KPfK3Nc7yWiYz+tXlEGQM+Q7fLMdRhh0LQQU6b/XQ1MkCh5GDLEN23DmLfN6a1ztWbVpTkFp9+oOFiJvLyQM1X5moMndHiuSZMvgdYOpC+EvsLYI/LZWuIH2LHy7DB1x7JgGotVnXAtLfGIfdmt2QywLm0W2RUaQLTO7G9RXd9lqR5GxCsirYES5bqsVTyNXXq6AC+CDHalynI8pGUEwtSo4kUlfOaRbepyu+uKNyI5JM9Uo3WaOSLjT6xc5PvdoYWDY+VEyW5W77N9b9I4FUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:31:25 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:31:25 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: neeraj.sanjaykale@nxp.com, luiz.von.dentz@intel.com,
        bin.lan.cn@windriver.com
Subject: [PATCH 6.6.y] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Tue, 20 May 2025 15:31:06 +0800
Message-Id: <20250520073106.2054836-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f36c28c-f340-4e59-243f-08dd977053b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T64QCIwxAnTcf6U5AXfGikqrmPy8TBKrygjR8O0f6cFrWnx+AVe8ZoT2ye8Z?=
 =?us-ascii?Q?RtxSnFLq4Fxe/bk0xqzDAigVI31C8WNXSiLrNqGDH9jgMAJ2sMXEvmQtVV9b?=
 =?us-ascii?Q?OO38mIjInKAxFYyT1bAz6uHBQZDBggRZVKzESmXa/GIIhGl8PCKV9qk46FTJ?=
 =?us-ascii?Q?jY1b0lxaBco6nomv8Lj2q+2yIG6WiAJ9adTaS4X9zhFy1j406Uyw/2FM1r+I?=
 =?us-ascii?Q?opfDTN9xSvejYfICxZnKbunQc4waEqpvcC17anEoWYdXPvQ91BHacXHVYYCd?=
 =?us-ascii?Q?4tZcDRwT9+6WFuPXpv64zHrqFkJcSP2+++RpztxoYAraA2SK1D81L8096/84?=
 =?us-ascii?Q?JNXdH5P0QJXdy6YRDOmLwRcy+MLQsLUM53Vwo5Kc6zAHZQeG3hdLbYqXz2la?=
 =?us-ascii?Q?C9TpsLAJTemH3wVHOg3VBJ7DvOlltwCkfcWFHEnrNCAMuLhB1+fLmG9A5/dV?=
 =?us-ascii?Q?zqUPAft301M7pR1m7L74vMmNar7GZ5TWhpGpHHCQmk5a4uu27Bbl2ks1hi5g?=
 =?us-ascii?Q?kvmK+Hc7iPGVlbng+xh9iNVecthEMH12LurUAh0DyNWrOQ6ddSwTQqwnA9fg?=
 =?us-ascii?Q?NJueaTQK7FMA95FvHi7ElzqXsmk195LKLZp9Aprt+KrsKx9iPHWgGVQsSqxF?=
 =?us-ascii?Q?oHH7J8jbKBVmPCKz+g6DmSVxTg/A7tCNbMvQoAB+FsN/f85F/zEszztqiGpV?=
 =?us-ascii?Q?aRmT+o4PH3coHo+zO2njq99s4CL8lRTI8pNKA6fNBuRZJq3yzENHm4iOM6/N?=
 =?us-ascii?Q?yCQfKBXsLesUu0fJ0FOlS0k/b0az0SETPfABd6ypPZCiEHHVbyAZkpuFFHcD?=
 =?us-ascii?Q?pXceMY4vvq1bmVHYoCmEHjOU7khV62vJYErlu25IWrRO3GT1nmuyQB78/1wB?=
 =?us-ascii?Q?ZOplJnBc29YxUri6qRAMQ/Lac+vFsXsfSvjaaB6V1EbddR8cifUA5vHyA+xl?=
 =?us-ascii?Q?kwAprIwaNAmrsubN81UttSfm3omArfsxyTXd1YCrCJBR38TVpL3FTifNZr2S?=
 =?us-ascii?Q?heV3JGIU73Z7+HAfB2Kac92NA0L7aJvIiRJKYCG2Xq0/BdK10Adx19ox3nW8?=
 =?us-ascii?Q?47ylwo5tlUIExqljPWA+BDP1by9dZhEaWemQb+Pzj7YsH+ZQSi6U5zTObGIk?=
 =?us-ascii?Q?8/myq5tiI937r01xU+wUpQoJ0u9PG+HvZqnTuhj25eE3x6hxMCQj9a/91K+/?=
 =?us-ascii?Q?VsFgMbYwbmiCa5fHV0oMsXr5xbLfyECY6pmSJnAUrDxNG35RHrLa151hdqV6?=
 =?us-ascii?Q?omqZOp6ASNRs7yVWViDZCcXl3d9iXbjAX14oiSX2Ut2TdtqY0jvE3G+B+rbo?=
 =?us-ascii?Q?whcDnIi1D3mdAMT+QyInmNkgiYfXHHbOxJiHq4/Py3Wd3Lto6wJRdTWw3n8a?=
 =?us-ascii?Q?uB26H3LYetiED2r2188n7brqBQVx+mmxNXU8mNW5cV6Ogiv9g2IHmqSqTStd?=
 =?us-ascii?Q?LA+1zgkRLAACHF21+UvgFrM0WowCGukQIFJXa2dAccugEzaktsdqEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sP1J//Tm8SM9IHX0uQd0zErMPPV1aZD6iPOY4U9WjNCSX2W+DXlxwOVhI6M?=
 =?us-ascii?Q?gRjJLs++au05302X5LqRfvYZ7ym2CUbQ7/+ScBsaH1PqLN6Gibx76MPPmG/d?=
 =?us-ascii?Q?PTENAtYl0Nk5sm3SD70FfhQLdEdK9V9BTyqzQeAHlIeJ2mcOEu2Uln3UtxZ4?=
 =?us-ascii?Q?MR1Aw9yk5tSgzjt3RcKV9pgfOyChNJeZLHRzxM+3UFb45l4BnLKC6mehov6d?=
 =?us-ascii?Q?FPfB+UAp1rIRWcM38iclKAkM3Xb2Lebs0soGVTda8iycjX3azv9jfmHw7fE0?=
 =?us-ascii?Q?NVdJa8vliQFxZ2YdFc+5OZSpHn3dmYhEPpNoJv0/eUYZZc2OSkvr0ieOD75u?=
 =?us-ascii?Q?6yd6cM3lMF8YECJ1+5pIb10obJZZahVJBlAl9L9blRSeYYWnWQQX2IRTABx9?=
 =?us-ascii?Q?1c2hHavL3t9hPinu9rEMBNMUDGnXOErsXqM82fwPXeCGm24oCAaUeq1UtHRZ?=
 =?us-ascii?Q?YYlE1LHRVJsQNsSQzw5JqUnIV6Gj9a1GLZTQN/AjGj+XvFRfPxtGbQn1XJqs?=
 =?us-ascii?Q?5+kPyqkdrsfETyLbjyghEjQlHhEHUm29S5OKRZGvgGjdwFiqj/bt17VOOjDX?=
 =?us-ascii?Q?AZ6rgre6qlwDfLcAlp7rM/LTUCvNMUtUXwfYHmb+/y3d9Z4yDZqOWr/RO0z5?=
 =?us-ascii?Q?uzF/GoRt7IuBcwwDf8EEMqpcAYobmxUyEi/3ZvU24P+ebeGWzVSdG39yRQBY?=
 =?us-ascii?Q?bH3e0IXeqLMNdi66VwPTLnFaMXuIDScZgdhZil7Wp8/KO/X3l78kb61OF7WY?=
 =?us-ascii?Q?65AEjzTw74ahdDCeZAw3zFmBYmENoklh6kZgqJ4Hu0IU+8G2P/asyF18bpw+?=
 =?us-ascii?Q?m24vvqrfNtFlny16TVqnmj2TUB5V8dGIeuggJ6zAbAMRVn5FK8w7cXEPLRfF?=
 =?us-ascii?Q?6c1HWihSKKlgWK8LBstdpI8ODbkx47BvJoAzN92bv7FeoFBKPu54nM2LlUq7?=
 =?us-ascii?Q?xUnq0CHMVDgC2ptPcZvQJCpmFDZSSJXs2mTeo4rdAtmdPT+TLbFa/MkwS93O?=
 =?us-ascii?Q?l41qosP6MDDvA7wHXFwQg77ZAJ8Jz1gV9/xmazAGGA3aDfqlNRR2i0l1GXUU?=
 =?us-ascii?Q?X+vWiQDX0hDL7ZrQ0fu/jMe+na5PsPCjyMFHWa4sYJvfXDsBcwDdijQHIL/l?=
 =?us-ascii?Q?2tBflDv7YQ2lLm9UnGH96JlDGuajWCTIdw/hkDInD5O0Q4K3JU56O1Hq532S?=
 =?us-ascii?Q?oqlzC8fhQjZuto3kgdc/wyIGe0A6CrR5FYqx6qSmsIbZu5s6EBU7wLfujQmP?=
 =?us-ascii?Q?CdMp9ZQ6M0DXFlt1RaAmYqAngIneXyHIXrex9FKOkaei0uoz+HjW8XYSKMf4?=
 =?us-ascii?Q?XA+cGI3xdMTaELyYx5T1xcX7vLOeEwoUMIjgGTykw/6clV7bQiSiDXs9UbZO?=
 =?us-ascii?Q?xGdac61KfpjfE1ScmWs0jb2IdJ+hkKiUqGRk8O/0Y6jdQTvcC+Ii5AdsSfF0?=
 =?us-ascii?Q?lbjmXI40Mo75GkHeogRdGdynzoF4y+zGy72Xq2iwi/JjGsnpe/vZWAkEAHB4?=
 =?us-ascii?Q?JndgQNuSv1Ez/QrQDWULHhawE/l8R5Wvx76dl8LvK39TXmqwP33czvbk5td4?=
 =?us-ascii?Q?LfKx66s7voOaWMNMj/oCzGqQ/rMRbjD0WXJRkwLhTfjDQocPwPVeUjCGbWOM?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f36c28c-f340-4e59-243f-08dd977053b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:31:25.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrUzRGNr9O0pE+vzNWqR+uFs0bNdF+fRsAEt4++7LrBMhI3qdGEJ/lmItJP4uJr7nPTUiR+PeuyYRWnGpsluZyj//10K6ewGc0IM7FZF1LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-Authority-Analysis: v=2.4 cv=F8pXdrhN c=1 sm=1 tr=0 ts=682c2fd0 cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=ejepizUdJjaCFj8ohFIA:9 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gnyeCyeuAyXbnF-1At-jwapCXEPJWf6Q
X-Proofpoint-ORIG-GUID: gnyeCyeuAyXbnF-1At-jwapCXEPJWf6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2MSBTYWx0ZWRfX7vzo8WsA0uPK KA3l7u6Ess10CRCcRcCSoWC8jTXhiN9rKPMzfguleeX9CbaIYX7RLoYDQmvOBR/hvpkUV7hZzbt 06iJOdJwiozHBtjNdJWUxI5NLcT2EM14//3J96mZkDKOGlXZQh+/0PRJd8UQjgLvdEMemuxjyPA
 G9yH6QQbWL6IU9GfljEju5K7hDL5+Qa4+rX/2XXah9QzU8xUadUaR80F7n4nrBRHODXcS4CykRS RV+3oaAyK8gViHWKOb7R6LOS2OdbhruXG5tskf2Vv+LiOX2HwdaZjEPmgAAqgSUxfKy4gMpRHfW gH22lzLXYCXlzOht8zF6mzQfb63aDkuqffwaCQheKaOnM/kg+hAmEy+cqmQP7COqb39SHDCyVtE
 0W4/8x/zEQtLag/VDOoFNILczQof/BjA3cHs3904p1FI32OMmNO5eGsqJf8Wsu1BRcV0bW0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200061

From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

[ Upstream commit 1f77c05408c96bc0b58ae476a9cadc9e5b9cfd0f ]

This fixes a kernel panic seen during release FW in a stress test
scenario where WLAN and BT FW download occurs simultaneously, and due to
a HW bug, chip sends out only 1 bootloader signatures.

When driver receives the bootloader signature, it enters FW download
mode, but since no consequtive bootloader signatures seen, FW file is
not requested.

After 60 seconds, when FW download times out, release_firmware causes a
kernel panic.

[ 2601.949184] Unable to handle kernel paging request at virtual address 0000312e6f006573
[ 2601.992076] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000111802000
[ 2601.992080] [0000312e6f006573] pgd=0000000000000000, p4d=0000000000000000
[ 2601.992087] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
[ 2601.992091] Modules linked in: algif_hash algif_skcipher af_alg btnxpuart(O) pciexxx(O) mlan(O) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce snd_soc_fsl_easrc snd_soc_fsl_asoc_card imx8_media_dev(C) snd_soc_fsl_micfil polyval_generic snd_soc_fsl_xcvr snd_soc_fsl_sai snd_soc_imx_audmux snd_soc_fsl_asrc snd_soc_imx_card snd_soc_imx_hdmi snd_soc_fsl_aud2htx snd_soc_fsl_utils imx_pcm_dma dw_hdmi_cec flexcan can_dev
[ 2602.001825] CPU: 2 PID: 20060 Comm: hciconfig Tainted: G         C O       6.6.23-lts-next-06236-gb586a521770e #1
[ 2602.010182] Hardware name: NXP i.MX8MPlus EVK board (DT)
[ 2602.010185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2602.010191] pc : _raw_spin_lock+0x34/0x68
[ 2602.010201] lr : free_fw_priv+0x20/0xfc
[ 2602.020561] sp : ffff800089363b30
[ 2602.020563] x29: ffff800089363b30 x28: ffff0000d0eb5880 x27: 0000000000000000
[ 2602.020570] x26: 0000000000000000 x25: ffff0000d728b330 x24: 0000000000000000
[ 2602.020577] x23: ffff0000dc856f38
[ 2602.033797] x22: ffff800089363b70 x21: ffff0000dc856000
[ 2602.033802] x20: ff00312e6f006573 x19: ffff0000d0d9ea80 x18: 0000000000000000
[ 2602.033809] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaad80dd480
[ 2602.083320] x14: 0000000000000000 x13: 00000000000001b9 x12: 0000000000000002
[ 2602.083326] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff800089363a30
[ 2602.083333] x8 : ffff0001793d75c0 x7 : ffff0000d6dbc400 x6 : 0000000000000000
[ 2602.083339] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : 0000000000000001
[ 2602.083346] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ff00312e6f006573
[ 2602.083354] Call trace:
[ 2602.083356]  _raw_spin_lock+0x34/0x68
[ 2602.083364]  release_firmware+0x48/0x6c
[ 2602.083370]  nxp_setup+0x3c4/0x540 [btnxpuart]
[ 2602.083383]  hci_dev_open_sync+0xf0/0xa34
[ 2602.083391]  hci_dev_open+0xd8/0x178
[ 2602.083399]  hci_sock_ioctl+0x3b0/0x590
[ 2602.083405]  sock_do_ioctl+0x60/0x118
[ 2602.083413]  sock_ioctl+0x2f4/0x374
[ 2602.091430]  __arm64_sys_ioctl+0xac/0xf0
[ 2602.091437]  invoke_syscall+0x48/0x110
[ 2602.091445]  el0_svc_common.constprop.0+0xc0/0xe0
[ 2602.091452]  do_el0_svc+0x1c/0x28
[ 2602.091457]  el0_svc+0x40/0xe4
[ 2602.091465]  el0t_64_sync_handler+0x120/0x12c
[ 2602.091470]  el0t_64_sync+0x190/0x194

Fixes: e3c4891098c8 ("Bluetooth: btnxpuart: Handle FW Download Abort scenario")
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/bluetooth/btnxpuart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index a4274d8c7faa..f0d0c5a6d512 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -601,8 +601,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
 
-	release_firmware(nxpdev->fw);
-	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	if (nxpdev->fw && strlen(nxpdev->fw_name)) {
+		release_firmware(nxpdev->fw);
+		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	}
 
 	if (err == 0) {
 		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
-- 
2.34.1


