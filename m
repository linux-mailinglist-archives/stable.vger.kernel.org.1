Return-Path: <stable+bounces-237702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EVlF6uj3Wl8hAkAu9opvQ
	(envelope-from <stable+bounces-237702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:17:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26C3F4F39
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D02430342B9
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAE3043DB;
	Tue, 14 Apr 2026 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="VhzIJ7rC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4032773CA;
	Tue, 14 Apr 2026 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133023; cv=fail; b=Dy6e5+oEzhieH6Wu0HK7aIHoQIUe4qvYylyJnihGWrd/TpvZb7RzXu5Gpj6ZO7gIncWUJl1lDHZaRVRGoLW6lhxtjFe2Nz7cNdf/qW5s8rGVA+4+5md2RFpzaVQsJE5TVtuUJMbo2SE+RVl59pDT+yviTlfE9/3iAjbOEgpisrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133023; c=relaxed/simple;
	bh=jXvHvf43mmGvUVu+Mj+x+NGdLn+SXDOHvN7sdXP+wLI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RB9qnLDvQtYho0xvzZ6UIR8cRQZjkduolsZBYTSH1iQb0xh2vQdJwEzF4tcjHdYe47L7Xwr7MH/wDr5uAgBE5vd2v77GU1J+KpMShjv+h3oNK1WKvYv7gvfQtFH/7DRQ6ZtUQkEk7QRfxOm051XsZ0HPIs8WQT4FvFsmKsPd0B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=VhzIJ7rC; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E1UEGx1450648;
	Tue, 14 Apr 2026 02:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=XS66cJ5pW
	8Q20UlpxXIaDGf1KIZo6JLzX4ajRf5PhfM=; b=VhzIJ7rCgVPnu8NA3gUT6g0uo
	SnuudsNsZ0qDU4NGmcMFmkGwOmUmOMXm5Hx6y1MUSt1J4IJ146xI36BC0oxjeMCv
	QvxQTthaOPXr5qntiwW4vXrIwKMrf+cbN7qyeiHu9qlAwO/A7cc5+Z/nKbDQMxnh
	0AOIWFxoacUDA9k9A42+DpAw0vDjJ9hlWd5oAeBW5VuLb++UOJLxckLJV17fMm2G
	bTkW0onAosKQo1b6NAXhJLWeQAw1qPrT0ItRLldJCuJkrsxrRB00K27evRJHXVYT
	HizKZ88Zj3nhz4mK4p6mQQCaDG6+fcbhfXau5hz1wT712IV/fgbSM2pPqVrqA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877g6yx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 02:16:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3LaPFPg3SOfI5p8bS/UA1VmEJyqux3NbQirwLgIB9E/O1wtPdtrLew/C+fRAsEgKOrwxJzwPMYJ3dbjvF5t+/5T1uOpFaBQD6pRHv88FxRSa+v3C7DeET22cERoppGDqvic868K4c4lfU5TpNTm+Q3b9P1MWvPONBpHf28/sIXcoeQmWkpE1M4yRLvUs++4dOEh6X6bSkouMbHtlVv2dzeJOwway7Ic70XnHSIMoFGYAuwlhAnUA5W7zIVhidoCGSBgk1+aiLpsDP0odkMmbjaMDuErsD49mWCo12+TET+cyc+5SoLu4acrIpuVQwO7uuWR+BMwaG1Qt86UUNZ+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS66cJ5pW8Q20UlpxXIaDGf1KIZo6JLzX4ajRf5PhfM=;
 b=ZrYnezufu6kqSQq0c1mEGM6OPNSnDhcMXeD+vbrbgKwjIZhUXNpggCHr/qSVuVJlB8MBN67F+QBtTd4i+Uvuv9LPLc236wwQJGY+XE54wQNr3oMvYa3Gfj3OVcfqsGoca33hHrf5h8KvxXD7qAtYTHJe2VlmvvNFUmVqyWglvkzdtgilOLIobsBkMgTmaQFuq0M3vSR6g/hp7Q2JuCeSnj2LCvpv6YT0gNl5m3QLlnXfBFLSud3jWuMW2lkBRSEwX9B9Z2ciJARjJ//4xVSgwF0/mE7pmUykn9+3fK5Et4cMWjNQznzYiQuCP6DZshYCZ0UEahozzJU9hcNuXjzsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 02:16:54 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 02:16:54 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, johannes.berg@intel.com,
        netdev@vger.kernel.org, regressions@lists.linux.dev,
        miriam.rachel.korenblit@intel.com
Subject: [PATCH 6.1.y] Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"
Date: Tue, 14 Apr 2026 10:16:33 +0800
Message-Id: <20260414021633.2765982-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0117.KORP216.PROD.OUTLOOK.COM (2603:1096:101::14)
 To PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5586:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f7cc87-1ebd-4fa9-c605-08de99cbe4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mQRzCe5VNBdB738JUxX6kewgIDQFhxwdqufOZ65JNoI6NBMxM9D/lMkbuW0xhK1yeR4nsmfug6MTnOiYt40HOD9khklaS0Xh1RHGY142lilzlfr37tq1nS2OhHOAM+jwSxpvIx6/RWgAAF5WCpp/T9a5cjL8kxglt/dgpI1W2YinMx9u5696IfPyDdZw3ZhFwVyNpnkxfFmIHRun1ZIJWGYCCzBe05DD9ZJAgNgCFi+yU+vCsXE0pqV2X9lMQdgH2fnwYVF2sWCEFRFoADbctkdROxEfcwjW4yV6hQHTJARajTKzGK6fJ0nkaQBbXcHVTjZ8yIVVB16Y47k/dK7KmOvj49491vXX29u3PVg8ZpikRc59LTZluBSYmMdu1T668l1P5qY94OUdg8/tTLymM+fuGi0XD9ObJq39bl1vRV0cvUrb/udTX1T5JbNvKO2R+GxZei7YoyzXTXUborg0Wx3EqYumQ+OnYaEocMCdf+Nt+wGd/8glleFxY2ifFwUDLP4zyfdmZSt+zabZwEI0ORhvZ6+iGB7a7cE96L/tyQ6kEb4c2xhOKxBXPSBgOvctx795BJbmgcPqtN+oJQfsbD0qa9OCEiFY/wgltdv3nRMPy2zjTOBwOZo9bXZ4XCw7wTmrReb3eI8ZNp4hh3c0tKiTDE3PnuQzy0lttzz4uhzW3xj4Ug6ysgQputov5JQ2HbHmR0a7EgoLrb04r0VxB2y343Wpy+cTFpXqqCGQdUvLmZ82kDMLWtwIhvZNeJa66kMVIQPEq8hpMbrDyqzOg9p0q3Fm40Xe2Wj1s+qrewE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bzGTBA59DfxScTMSsdqXwsovSxepAvqIx/0wNjEsdAx64XOzTJMf+2y8KOlT?=
 =?us-ascii?Q?lLeo1MyWWkRcZwHRLSLQmKALoHEvCC+7XV2I4NnJ7ZygfOT8tzIQFilYaE2a?=
 =?us-ascii?Q?dWkvA/5rMznrChmAWvqg3D6MR/CH8N1N+KvkxfworTGosXoKWi7gq86lpkD1?=
 =?us-ascii?Q?hUyWKwmVIXdE8JOYZToh96qDqIYaBoegpDjQDIfmfHs+mR+83ERrnAGrc4nQ?=
 =?us-ascii?Q?dSTp/duJGQO8Fmj+NOcw//vM6v3xntWC7OTUs5V0i9Y34BIdI8Slihpb/uv/?=
 =?us-ascii?Q?uHcafZjqF78vilDyHM0oSoEpWZmizIBxTbuMIwAGm4JW4Tki64u92NiAFwlS?=
 =?us-ascii?Q?7HMr6HdxMj1Cx1mHkJheonmuSFv3kPBFv0QoGUPhC90J9vc8mAwp3xhr0buB?=
 =?us-ascii?Q?l/VdG6zBxfo6NiVTLrrytHoiU8VinZlPINpGpyEdL/6Xt/6OpPFR5MOTIgsM?=
 =?us-ascii?Q?ICR3cXfRXx9kN5mfKGIfI8+FE+cG/NnSQ/AcT5dp2y4NpWQzY8dMA8v0Faj2?=
 =?us-ascii?Q?CjdA/7Q05ehfO1WFgUcxGZnYXPYXLHluN0Xo3G71i7Rnm9j+uBZ0cmaMAzog?=
 =?us-ascii?Q?l7TUbeDXPldDkNVzuNNPaPm6grYxJjK5p2f7zDa5ZMkw0QV6iVxXmVACBlAo?=
 =?us-ascii?Q?s/BpUl+b2aRzB4GXnny3VglQUhlbbsPSvc6OTWOkb2sarqcuSF9eedTdWrTH?=
 =?us-ascii?Q?4htiHNIbG8KAXVQjUCqXPzXD0PKExopmRlLftpMpvU0wSywPduMyhaxzUaia?=
 =?us-ascii?Q?xMoorHD0e5Bzd55keaVRJfCCPtPzT1XifYYlub45kxyFopmJsIlLo2JerCwD?=
 =?us-ascii?Q?+B82fMDqCQWVm1hxTXGiLZMtSC4ubzLmxbXA8abxCkWSAJ5JP91+AUiw2fQU?=
 =?us-ascii?Q?DS8Q2QeYMuXV3XHTnYfO9RUJUAHISuYRpU/nW3q9IgQux7yCQbG0bWCyE8hw?=
 =?us-ascii?Q?7cW3XHQxi1Nn8KBQwdnWTdvy3XcM8ope2CfoQ3zreYBzAG1YeTb/F3ImNMiP?=
 =?us-ascii?Q?60Mr4uMi9oNY4iy8glv9+X+rAJsyA1j8e4va1zV/uY2QDQ1hhO8gqtq+ioW4?=
 =?us-ascii?Q?o8PsYYjaJuyCsL79czdbSGqm9/PzyBj+GJvGu/H7Q/6P0/la8J9aSwQrSd9Y?=
 =?us-ascii?Q?v8l4swiFlJhJejxtzoSKa9ptPdY5uveX3jnn6qSdl/Kj0ciC2l9ffwOX0yER?=
 =?us-ascii?Q?k4ck6unMmUn8qjACqL6XOFGUxJf95D2t4pt1DU23lPhu8LJDdzqnQOIYKYiq?=
 =?us-ascii?Q?lDINqOrDsoLlOlnyYbhGz/Fn6/w6KpHuA+AeVHjYpyjhDso1jLVv6J1RmylJ?=
 =?us-ascii?Q?YQDQ2Ct9fQ006EikmvddYz7gugkmpuNv1PzVFRL9I3N0rkdNxF5ZasYY4bTi?=
 =?us-ascii?Q?8fIP24wUaAYW+NlKwdsGdoA9Uiwkbmg/3cKUz1Y2wEm/nNB8nkSJi4cHZjD8?=
 =?us-ascii?Q?sS4pe+f+N5o7Dq49gD+LERsRoSUP/ZFyfCu07Byh0VkzkDCWlilhVYFIIWc/?=
 =?us-ascii?Q?VCIIha6LMn/gokYRJtT0q3l38kDGCK7zm5Dv+NRvmv2bkejp1IsvGVGdVfq0?=
 =?us-ascii?Q?Mmds7nNTv6GHeBKFLCioR5WiSL7hvV0KDuUdxm49E6Fjo1ypxVcSwF28j4rT?=
 =?us-ascii?Q?YrfIGzRTycNCoBp2LiG2gPYb+vnbCKAk+BiC/2d0V6hAZXYmHSx4DG7v5Bhc?=
 =?us-ascii?Q?xaeYTcqbcwaLhN/ZNfewf+czOmmJQvkRdc7vl1yIJ/ugIhkiYX31nieArLAs?=
 =?us-ascii?Q?jZ5LhSqzu2iNoWexR/Lk2C44Obp41BY=3D?=
X-Exchange-RoutingPolicyChecked:
	P/O8yhNAlSVBLCLTaso0OZ0AYKFFJ2lLlnuZvqtGubMjl+nZ9ifVPHVgIz9AYDShhKJ/RfqeN8Qe0nrMxx6+/yexF8SRq/B8lE/Emiv6cdQeCmqf5Knw0KmotmPn2Ng3UKX2IJoRR65WIvAE10UVE4wPQ7WVjwIrRGwvBFclbTP+d86Sa0cnJI8b6gx0XFa8WOLtidn7BObviVxSbn1ji+BgMJBNOvoqfXLucJ2lUwN6+Tc75eGqh3+pugmtFJPnZoZgwgy5DpG9CzXop0w3nvZCcKaBc+E9QUSloEQZtS0T0CY8DCKCkmXS+E7zW8KZCkDMZE74pThnbK5Zxwenhw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f7cc87-1ebd-4fa9-c605-08de99cbe4fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 02:16:54.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxDU/CBIAMlFNFNCL601QsssCB3ME1DgunBaC5SHZwdC78tGvieNkovn+Nfu1U/qxerdPl2sM+WgUH7iJHpW90aaOoi9pfq8sbc5hMuCows=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-Proofpoint-ORIG-GUID: t5cGY6wbmGmv6UVMuOqUBQzmvoIVPGfX
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69dda39a cx=c_pps
 a=Zi+2/POLpdgQ9anv5Nu4tw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=y-J10uEhvVOKljhdnB8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: t5cGY6wbmGmv6UVMuOqUBQzmvoIVPGfX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAxOCBTYWx0ZWRfX7E/NBb7ZKp5d
 q9UYbnCoO4O2PgDwfcZkCDs3T6OsTSykhjIHW6CghSFE1jV4BCSoqCoj3KfbiSi9mU4GsTILSFM
 XCzfxYG1cmVrPt9rwZ5ZUIgJvbFottWekDfWhMzzI0BPGG6/545eIUg76fyR9K0JZFl/pT46XJn
 q7Va1zm2CFP3ByuU3gixb1XsfebBqMmsqaVCV61sSAums2bNnRT0Gq0jCGnqHMyltvH6ARrGylH
 mATfC5tL2PoMpNSgvdzqDWCQdF/lkwT4/S6iPiOMMJjeb9ogv2vdVb7l6U/EaffEyTR2jO3aYtp
 9CUm3tlLe3ZCECG1ed4VQMGwKHyc9eSYEls1w4555lgcTQ8CaHM9Aqg/lmGuChtYBJX7dLTG3Fy
 QRWtqyEJmD9xXgBCw6dOYa3eeXuREQ8SNHZgeb1ydJdhJhxnebNm5mddS37dF6P+ByIhH/liMh1
 pPs+wa+Y/xu/7HLSh4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140018
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237702-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guocai.he.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE26C3F4F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guocai He <guocai.he.cn@windriver.com>

This reverts commit 0c4f1c02d27a880b10b58c63f574f13bed4f711d which is commit 
e1696c8bd0056bc1a5f7766f58ac333adc203e8a upstream.

The reverted patch introduced a deadlock. The locking situation in mainline is 
totally different, so it is incorrect to directly backport the commit from mainline.

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 net/wireless/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index e75326932c32..2a6a8bdfa724 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1328,10 +1328,8 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		__cfg80211_leave_ocb(rdev, dev);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		cfg80211_stop_p2p_device(rdev, wdev);
-		break;
 	case NL80211_IFTYPE_NAN:
-		cfg80211_stop_nan(rdev, wdev);
+		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-- 
2.34.1


