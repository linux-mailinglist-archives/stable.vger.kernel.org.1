Return-Path: <stable+bounces-144137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464DAB4E7A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDABD19E2254
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4E1F5435;
	Tue, 13 May 2025 08:48:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF11E9B12
	for <stable@vger.kernel.org>; Tue, 13 May 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126106; cv=fail; b=BWSjBcuy3YKF2bkOc1OPfrKkBOH4lsjvodws5to+R0LXoeaprcQjijptpxYTgo1QDSTqvscphlCUdRvdS9exHF0psR7S3Ca//YHEVlZte7qWDuNEIpE2hMrwHrvJNzffXcffEYB53LkbycuoM4zn5Bxbdd2s5pspKdRhnokSLKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126106; c=relaxed/simple;
	bh=TiTSQdC40gN8zEtOedfVhRUQAnByEzL4ECz32wQCyxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hkyXC71ZzblSdcFXEBi056IHcy6i3Gyw2uawN3A4FPwSH33BR13XUvYXkqjvNx/D3wpNLnlYk3Zb03Pk5MuA04KwdYAdTDCMc/PTyJ7ZID9/Hwsd7tUCAyeyVIOpBFYs2tBtoSstKn4uth4yCsh1xfmI3q/qpqmrstyZ4LWotvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4fq7Q020492;
	Tue, 13 May 2025 01:48:17 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j233jn0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 01:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFuX4t9Ma6znpTQA35Gxpj/wcy51TVV60rB+BK9Uhh4NYoZpmpZaJi/ITK4cbErBahNt8TZz1f7Kclpz3l/zWVsxaIXW9TROpTgwfbx0XyOYf1ikq5/SxdduqRR5zwpYL359d3YCFnqQDukWASB2YdHWpOI9MhUo2wCpWfHeRo/LlTSkvaCznQxqh9geRVlfrYYwlJ6O3kQ7RcRCmnG0jBOi+cLsR3E/PSlFOt2u+mXlxUNW4cpASggMcw07SqVNRofWEjZ9RZkkOWqpXwGnPcRmG5Rj+SB8HOnN94pirwVTp3oVt5vgTgJPAq2qzWQGvYX8WI+mTFDjUahVTn8oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaNwFntQM9lzTRXNUkEwZif8gsUj3spycfQk1cU+1mQ=;
 b=ScJ7xoA8l1hmyrBzM0Es+8P7GFKMtfGKvvpQgAzdN001Oz6yd1PGnbbJFW2G5FJavQF3FkuhPGZeIhXAbn7BBPfZ3UQzKGTH8oIV/Kb2xzs3irM99NmqVx6Mr0aexPVjNqoa/mEBRsMyPYItT8lmbZxhd9hfPmqFEJlJtCoy7B8cOUimrkL7i3QZcpjwmW/kIOpDJi73HdCNMqR8vmJmSVw3Sa9R9kiJIEfX3oF42qPddevFXRsuPdEsrlYkmp8bmqDClnhtpb6nA80geSGrlD1SfG8caRdfa0//yrNB7h4DVKHu59b0gae1n5FrhcAW/4f5FKYMKW1NOcQW29kO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by CH3PR11MB8209.namprd11.prod.outlook.com (2603:10b6:610:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 08:48:13 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:48:13 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: wei.fang@nxp.com, kuba@kernel.org, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 13 May 2025 16:48:01 +0800
Message-Id: <20250513084802.1705121-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:404:29::34) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|CH3PR11MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 453ff918-9aa0-4460-2ec1-08dd91fae580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSJFSDqp4OEfzzvoxcU5xhnMdkXuTnOXWwCVIZgTGkEj+Mxarp//tseb3+M6?=
 =?us-ascii?Q?EVr3Ld6I++Optz7r8vbFUXRx6yNV2/uQWvuC3+lVYlQVg6o/CBDXXZTxFaP5?=
 =?us-ascii?Q?L40dFDerMdrXwCG38kQLAn56Tjz1zP6BPJ/BtjQ4jzeCnxhDmb1a2MUjtw/V?=
 =?us-ascii?Q?78U+RNBm9LDolLZXUaPtKECEzAH4TVi2JmZI8rDdtYcKyqCDJd9HhYviYQ6v?=
 =?us-ascii?Q?g0/0PTLbKdu+ZZuvysZUcNRheOcR/YtH9wCQq4rDLItJ7zpZhOw+be3+jcJN?=
 =?us-ascii?Q?xcyOl9dPwwA/grNTbMhfh0nzz7T97MrQJy7kkH/FPblvkAFqbo0qAqL6jRNt?=
 =?us-ascii?Q?f7PJdMD3l+hx5Tzwh3UYoChdhUkTqdoUdzO8Q0fGh7hseybY8bBMgomJ/Ewl?=
 =?us-ascii?Q?aBhbmdN/zsVcJVYXk9XzPKRzKWR1Jc24Fdx6KslIdVe7yF8dZxu8FLOk42S4?=
 =?us-ascii?Q?BwHp5qLp3lXtalSXxOUrzbr3x29mgjRhZgCAc+l3HZpdCojXFDYuCj+qbubK?=
 =?us-ascii?Q?/EzcyC5b8iRT9KqY9vD2XYEVjYxo8nXBOMKiIZeh68SKZw+HmSHBrHTaTZ30?=
 =?us-ascii?Q?4RyI0fEesruaoTYg2Zp/Jet1GgI5xP4t5XUAGfsDmd4TGO8qCX317M52p88j?=
 =?us-ascii?Q?kPsA4SK7FJHOT/jgAIHsi87wJ2hWFWetLQS2I26jL+TiHi6NfbFP/lf3UhyV?=
 =?us-ascii?Q?R/ZDle7vYusAV/Rv/e6hdh5EBYCF2IPdemIUml6gTsyzj8S8KjdfILdMzuAZ?=
 =?us-ascii?Q?dQX9mJZT4mc0LzgzR2Xbm2AKg5v+InVZHvWCmVYYaVfIe6ncuZ9xV1S5j/Dg?=
 =?us-ascii?Q?skRkmghfrkISGxkKNxr4UTl3sQov7+tiH4UK5yBO+s/FaRe3WWUxh5yGigzc?=
 =?us-ascii?Q?JyXhVZOg1ZN6RchhwUBl5i0ZW4U8Apc1GBsG5KieMjeyXRvInx593U31DMT7?=
 =?us-ascii?Q?QxOG/+XE1tVxbhel7TOIYhB85k4ug8QI6tIF3eL+JjJ/ZcZrqmDkjzkKF8Za?=
 =?us-ascii?Q?X3z1x7uLyPk7B2rThKypR1kzVIL4D7qze5zJFLu4Q50HVZh3DXOO43Vj+h+4?=
 =?us-ascii?Q?N1YoLqwztmAbGx3+ezH6RFC55HjbgLDmil3EwwtpvyLKTq5ppwQ2asstTSKj?=
 =?us-ascii?Q?GyNqxwBHt6uL9uDAO5t5X963d2mjg4IOXUEdu0bpJui3wox7Lns5Rj1hEOdY?=
 =?us-ascii?Q?749riA5VPPIybu7m2x4d6qEqK00p8W1de6zT33E27F+heDpiIjdQWvIHKPCj?=
 =?us-ascii?Q?rdscgovt5xjhVUERVe9g1aVV3xQksSMjQKbyDUVWgM8XIB0E8JHJFCUKz2OC?=
 =?us-ascii?Q?1NwdmhcRrHoBR5hDPrPVvCY1//2UjibMFiVtEVCUL08mTInmTt9N3faGvJSs?=
 =?us-ascii?Q?E1KXN0oFMTK1AvpdRkVNQelMyvbTu0fW0u5qgORgL3IPI2OUmRv47N2zXEZw?=
 =?us-ascii?Q?e+WufSRdPKxx2Ht38CfAkfEX8Wm12YObH/U3CIpxhYr6eHRIFspBkQ3STIMJ?=
 =?us-ascii?Q?MXG1WCPUTy24IhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fceEhYV1fadaZZoOCO6S0w9/lKMopDne6dkvyviOr4DBK71pHRDnrROOt03g?=
 =?us-ascii?Q?rIt+7tKK9V5/2hg6W7ErWAWnWfW5LAlKgPYPhtLgZFeW2qJmTeFZoR7mVO5/?=
 =?us-ascii?Q?toeWTAEbrAAfymXMABEgNExWKqSeK6gavuw2YnfI6x4f2RSIA/UvqxoqsqPW?=
 =?us-ascii?Q?zLMBlm9ojeVMEcvcllX4qBy7CKjgvDp2a9er65/dQYXUDGkdREyigBaDwTrQ?=
 =?us-ascii?Q?RTvaN6AG8/SKQzGr/vzobdhOwitexVJeNXv/OBxkBgH0T3pdeWUoyV/kBSKd?=
 =?us-ascii?Q?hPnFobLmJX6n+mpri/lJ3O61CusrQwsDTYOMsVhnO0a/VeF+5aJSeqtRN9Id?=
 =?us-ascii?Q?+K0cRu+nVy3R8x9kcSwy29KjEl6KcSDgPQp75JsrZMr2HQPvaPnBDmsf9CXd?=
 =?us-ascii?Q?UeHCUy+y5G6DdkFCt5na/z3NtnwqZgL+a6S2brG3gV2pbJDUruTZtqdC3KdI?=
 =?us-ascii?Q?Ret3yKqM7JuPOJ8YASWUJAAff0fH+i23PTAovcqMSZPcytXvGhEtrban6djM?=
 =?us-ascii?Q?QpI4DipCQfHn5Ny0mpvDh/C154T8W/VIo0ii+9NKfj6JOPrgn5TXaCCe7ptO?=
 =?us-ascii?Q?v90FP/vWFcfXzHSFaOCzdKbFHYZz9ynit6+274CYGCsnbKGHby/WkCE5gcPx?=
 =?us-ascii?Q?wQNf0vf83lAf/xl65whFeHS5msdh4y5r5b+ltNIMlcxAIXtyoEsySesEpCq+?=
 =?us-ascii?Q?pbl80HiF+r5Poz4rEIUvdWnaG/vWQH5cFFMGgBxxJhcodw4ENcOVAH/O2e79?=
 =?us-ascii?Q?P+wIOyQ6T8QE67wBYBCBOsMRHu1lXLuJkx9mkc3Qc/NGeP+8wbe2nU/K2HCs?=
 =?us-ascii?Q?7za1Z5YU47tQP+eN8wERh3mS1zoDo0RENaiyH9oumfPfFhLQJyrBKLDOIcg9?=
 =?us-ascii?Q?Hykhjrd4i5MsfV6oJUaKp4WHeABhBRFWmF1i1vY29e2QQt5mhYkd0lj7NSUs?=
 =?us-ascii?Q?y6d9B7LZidV8Z3mXL2XwV9A+kNu6CVO/Espwes+JmvFvylyDLmuptyfmf4UR?=
 =?us-ascii?Q?JHeOo8BBSee2Y3jfc48JbaYT+Vyc5V/ngBx+29E1W/+oTtqHpLa9Qwf8oP9b?=
 =?us-ascii?Q?50WTZDSf2gMSMfddH6ISoXFviVv7XUKqxG2N5Br4Qud/IrOvzuSgc6TgLzct?=
 =?us-ascii?Q?ZIBMH4adb5qszLj4JMfq8xbDAaBleIG7nJOT05+jkyEPHoKahf4uKyFsxWqw?=
 =?us-ascii?Q?4xBDOSf9HO5zJCnuksiJl0dHRaVQUNgIO5m0y59UYfOu9bYgypyeaajxBBuN?=
 =?us-ascii?Q?S3B9VoYRIFfNFil2dJo7it/6wNN5lr9kUbB63DmYhIYmGcL6V0V1MmR/mZhK?=
 =?us-ascii?Q?H1gmvfv0tumCgfYjP4/z4kQZxzyLdgzo0s9CSBwZUlbRM0rvpMRqVtThXJ5z?=
 =?us-ascii?Q?AgIEekt1/WH84c0yG+2PvtOuyhH+xCSOpmSYUQ+j2Z+VCARjzhxJyjr1tB9s?=
 =?us-ascii?Q?3iTaWc9WgiaFaEPEMk9OSzpTC3LTvymlzx2YRlSdU70Wn0BzljAqyoX4DD7M?=
 =?us-ascii?Q?SYY94eqcNuyOmOo7R/aJWhQcPXOYqoy6skM5Q+wjjPeoaXEhv4Vfta3GggAQ?=
 =?us-ascii?Q?Iea9WQ6G2Ay7pFPoAblxQTLiA1L/ozPg1vroFA4bWVRU9MOOU3TkIHDSOsgI?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453ff918-9aa0-4460-2ec1-08dd91fae580
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:48:13.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eljF8wpXDucux7XgI9NX1XcC4sROmI2BhloiKS47aYKdeU/XMvB4jq+zIPj5oAPghBl/251BxMkgGYivxWV0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8209
X-Authority-Analysis: v=2.4 cv=EojSrTcA c=1 sm=1 tr=0 ts=68230751 cx=c_pps a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=t7CeM3EgAAAA:8 a=IFCpX8b_31d8Zp-CglUA:9 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4MiBTYWx0ZWRfXxVekMxpJrhmL glYM5dD+r7QYqbUTA1BW2DFcmmS4uwwEwYTqWsHoE2sBKYyHabM6bMpBMNVePimQHmYPyGr07An ngi2TGiTlzlsc0om0bHwphpn35vJfSIyoDvUZ5itxaH/ekyFCEqx0ZQW8r0zx/7C+wtWTwI31dx
 Xm6hn/CCkS2+Omra7T5DZRFleFrEcu9vDoVVV1T+oSiiUJkM+eaF2RhjWCtL0neAgiiNZbR1wyO HCifRU4yWIYDYZq2wntvUBd3n+76WV7ruoaUDeDry8Pkb0nLeEHq1MjtIKRvkJxmlFex1AUz6Aj /JGRAcLy5IiwUaZCtz+wnmnrEDgbW7gpa81D2Kc3c4ydyiwdO1QYMIfU6UNF8E5G/6XQyW1wFQ3
 pq/KZgoZjkr+JYSjE1eIoR89+jojAnp60tT1jGfo/dvTmNet7JpscYeaOQGf2VfAVE9g8b4H
X-Proofpoint-GUID: 9xZC8syuzrXXvpKniOK74o8c1BE8hBaD
X-Proofpoint-ORIG-GUID: 9xZC8syuzrXXvpKniOK74o8c1BE8hBaD
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=982 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130082

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]

There is a deadlock issue found in sungem driver, please refer to the
commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
deadlocks"). The root cause of the issue is that netpoll is in atomic
context and disable_irq() is called by .ndo_poll_controller interface
of sungem driver, however, disable_irq() might sleep. After analyzing
the implementation of fec_poll_controller(), the fec driver should have
the same issue. Due to the fec driver uses NAPI for TX completions, the
.ndo_poll_controller is unnecessary to be implemented in the fec driver,
so fec_poll_controller() can be safely removed.

Fixes: 7f5c6addcdc0 ("net/fec: add poll controller function for fec nic")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8e30e999456d..01579719f4ce 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3255,29 +3255,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -3351,9 +3328,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_do_ioctl		= fec_enet_ioctl,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 };
 
-- 
2.34.1


