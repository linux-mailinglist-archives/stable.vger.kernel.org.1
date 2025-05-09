Return-Path: <stable+bounces-142977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A1AB0AAA
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF699E7461
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E96269832;
	Fri,  9 May 2025 06:35:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F2238D3A
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772538; cv=fail; b=PCCMXi8+40Yjlz9EN/fh2x0lNqjNAFGrUItHTGYGUgV7KDmm/NAusMh2Mo8od4z8+2d5XJfPtUJuHFtXEgaS0hoG4SaYGe36v90SX3K4UrmgOFvSMGIB/kgHzK0ggAlUsX6Sij72M9YvqCH1TorBXXYf34T/JAAkJpkmOqbnmKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772538; c=relaxed/simple;
	bh=2JdRYc3GWAGjpLO/nIlc9d1YD0CfQF8hsUavPwP3RmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8hMfgGWH0W3+I2YMeM/aVqmMfCWaXfu4CPVEJ5xJqhKDM87cFQHiiupNCZYYOQ/2mlXxeqNmxp1LHAsSE1e9IVm9K39ZeV94pZhK/N0A+tRF5t6Wryx2ZRpls5w50fxG/VUnKgRJ62J8ghXj2BRfjC0NisahSLW/SKIbzO1Bu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494bbX8013638;
	Fri, 9 May 2025 06:35:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430p7ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:35:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1mMDTWhS4eQvOleJZ7nMCIvfThVxYXP/8MQgnSSXggYIURdVgHis+r9W1piq+DFz/Zc4p9PltCuzLVVgXXrABDAo3BqZE/aW6y2RtzGRpE4x0nZGl/a4J+Zp1UuuuSf9bcqMPAumdL9W+L55JrtYmTMZOZ4g1vfRV2Q/dXns45FfwACOkwfK4hEy/XJ3dRXvQkPh6zxlFNz8peI/Vk7e3ynxyb7C73jzMZGpwAEILPqQMnzdNCxFf+GeqEExVomXSIzylwQhK7YyTnd67p4FrwILK9tUjhZgYu1rzS9vGHqOYrOqWFe0pS8po+wBl690rQLYf5FjgK+zNx4KjnyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqn+CENtXzldQ91ZOCTEmvM/SjcbRs/SA0rl0xxqWJE=;
 b=lEe13LxzuVAHkTIWCGrgCrUpUAmP8DNXgTTukEtsI6utgTXWvSR3aD0wd5Cuam3K1ntehZp0xmfhPXoXXEF+f7bIkWfEaZaPRAEolwucWwcD81T5prORGs2JG12DjXpyCYHDXhiJICNRBp3HnkJSZUpQX+42uCugXFL4FV3+7cWhwdYTymO82GCdNL/l5yo6Z6nH4FWmLaHb6pEAHv/DmPzFjUxhSyxJSQ3q+dChEXvGr9U7C0baep+j8sPcGllKB3UvqxDexbqb8RD/0ZaEhS/Fk5g3aOKWo/6paMSctqtpRorduKLLw6l2VNHgNyY7pIlnFi6pXWzr0rIOzHP8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 06:35:30 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:35:30 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, bin.lan.cn@windriver.com,
        dan.carpenter@linaro.org
Subject: [PATCH 5.10.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:35:12 +0800
Message-Id: <20250509063512.487582-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509063512.487582-1-bin.lan.cn@windriver.com>
References: <20250509063512.487582-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 564c891e-0805-470a-2ac1-08dd8ec3b16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWBeeZol0qDeHDJUyng5tUaRhcNgRuYDEoXnbM/m0XWPXDdHkVE6sX6dLBXt?=
 =?us-ascii?Q?NNQMK9t00SkzPI0KUEQCGpsb4gra4AUyQghSR+RdkkLshuSXjY+KVFSWmukY?=
 =?us-ascii?Q?tedSQQyogCCW2+bMUD2iTHiD46nDeQgpBwDfebi3JLWIOlWidXudRqPyMdJw?=
 =?us-ascii?Q?i9FOcBbOUuVe6K2RjBppO5t7rqy5FejFrBJPD2Zm3Fr+FuGoxuFoxdD8e/Vf?=
 =?us-ascii?Q?tn7ihtxCGkwp8NqAdcWr+SaMGJoAtTDSQH0APcFATzTPwDJCVWVBBWtlkMqx?=
 =?us-ascii?Q?w5OMdd6FkpRdYngGxv9q21faX03b0LU+A1rzdGjuU5UWIwjKynu3BBPfYPkQ?=
 =?us-ascii?Q?3MltcRkPIK4TZoZIaWGayne+N3GrxDr31wcIiJi1YEEcr1+5Rb0YFkQPwjtJ?=
 =?us-ascii?Q?D/LxzsLH5IVTrUCScD344A2nuqz4UR/KvYglun7xxYFl79FsEoYY+S0SQzaR?=
 =?us-ascii?Q?aGLV09Q1SW4C4t4OhCAG06OjbY0rDMpuB/s16J6Bwnh1LMLS28jl6Ezn/Yio?=
 =?us-ascii?Q?xhCE0FxCtv/MT/UirhYhgtipEYwaOHc+S+BUacJ9y5ZqaCfHj5hmZ3ZrW4op?=
 =?us-ascii?Q?mlhUa3dGCREpFMvaBZNcpRdSZo41Ulxkt2VJNAjdNqS86sKed5aFyal0Ij/U?=
 =?us-ascii?Q?vdzZ3+5hyPvm/kbLtqwZarYhWgBGWmN4MgG7ZpwWGGsqljOSg8a5UskK/7J4?=
 =?us-ascii?Q?fW9fAZNaZqvqy9Bo57gFhHx7C7sttVTC7eMI7mvErVv9QmliMmviPAuzRsMR?=
 =?us-ascii?Q?6LgPHh2WC8pesXDgpJBQoZ6Rk5HS9Z8mIR+3lBQ4090JtpcL1vU+jAXZ7ZL6?=
 =?us-ascii?Q?NXkiq3nPnbCy2KqCdtxvrKh6inTlN+hhDRBXgy4xjtb/ojX+j8RoOsi6r63S?=
 =?us-ascii?Q?UIpK+ue4KZOnPA9KRuV5lQnoWqiQGG81BrL2XpXpKwN2GV+Eo6UAPFr1gshY?=
 =?us-ascii?Q?8msbsPeiyQbBxIIAh+KU1+zZMGEyBGbabX1SHfTJ/cLVq7xJ/YS9DIpkMN8J?=
 =?us-ascii?Q?sQDGRLoirCEeQ4vgY+JRmPvlv9c+WhDWdhSXjlqiEZ0TjGFKLerWJgF9JOVI?=
 =?us-ascii?Q?g02DZBsXvyVjI248aD2C7srUC6dYA6RSaLODvv8rWTqg/Vl8nwbqJNt20kVX?=
 =?us-ascii?Q?LIeEl1c+nH6e6U/L2frwHU/0AXXsHnU7rc3W8w2GOzf0pHhvPAygFzdvUUNh?=
 =?us-ascii?Q?Y/UnBhKtnShxWVgXxrsoRfA092AqoQUXc47IDgZPng6efbVowvGx51HctPQf?=
 =?us-ascii?Q?HLlbAhPPu3bev6RMd6kp8QPwh/hG+UpZOtlMN8Fd/n7zDC4iFEq7wrWu18cB?=
 =?us-ascii?Q?E1QBdIHTG5Ev1w99PFIasJtvIL/bWYeLP8FhovKsoPjbPyaDqzZO7aGuZydF?=
 =?us-ascii?Q?VtiuYstYmfq+l57Geote9pYsMY5zqquyECoOgF2iv7keD3rb+8MMq6fR0ogs?=
 =?us-ascii?Q?/cHcC94NA2rbZqIjqMTo5OEtqQa001lBNqQ4vWtWuDfLULGOEDAOgAcZCIv1?=
 =?us-ascii?Q?+TXwBOT7vFTluS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDFipcZ+r1qOp4bbPkFEcXZhxIQFMoxeY9MAQq7cRRxgohlKxKeABAALcY0b?=
 =?us-ascii?Q?60hY5yhBBKGNYG0FYnLXGF1z8xCN3cJ4ETw1pxv0BhtSAnijkCYD87QdtzwC?=
 =?us-ascii?Q?wuJmrwMgLRwilmsQORxj5m3zMZivK7g3gt4PmqcaMbitQvin9dAY/mJeFrgZ?=
 =?us-ascii?Q?MKOsmMDVe4ZUko1YCEVu14XshvhSBr2ZZNnm9T05XvKg+YSPBkbUKZUQBjYG?=
 =?us-ascii?Q?1AFNgBstu8q1uSdGz2ULhlt6rzLg5V+wbS6XOR02CX+wnW2+uZ/ou28ozeto?=
 =?us-ascii?Q?0uuq+okrjo9669hyrQZ/aCxUSo5vWlsm3NDbc5nEAuaHawcHsTOIMj9RQKiK?=
 =?us-ascii?Q?/lfh5RGhAnjTXQjvahYaa7YiG0esvQexrhLtRqvj9lD4Stdr1wRUyABjgmFy?=
 =?us-ascii?Q?tn8PpLiUfi1CyaN97/ix7QdcwZCPCwYcnHWPg+zN1wroWBCaXzol1QQz6zrN?=
 =?us-ascii?Q?37razMoVHF5fsmgDrS+0qT+FeJZHj0EJXLIISF3dc8tqK8FV+s9jW9Yrpa3R?=
 =?us-ascii?Q?Soriu+1OQjpV+7DyE9JNz6Ve+Hur5ZiHDQLww6V0RYnC6YjJhBZogHEjzZvA?=
 =?us-ascii?Q?64Di2I8eABm9hu9JTQg5DQEPI+/BeYbmNlNalze3KK2LI1ZNYdDB1qkxtHWr?=
 =?us-ascii?Q?nUOYCvu0xh3ldaYoLNVrh0VG86kQayAlxn018U2CyrBqeDhzP/pd/jFPIFwm?=
 =?us-ascii?Q?jOwd3D/FEOE2CTNKvzIwyMqB7ZtqcO3uAP2KbzoJfUurnU+XC0Hc94C8Xtc7?=
 =?us-ascii?Q?jGQofwkJDk/PXzRfoULPlcatZqh8zl4hF9pPR828rCtbQ7vQO5eqdfG9caRG?=
 =?us-ascii?Q?ZjKyTq+QoIJpYOQjGW5T1p/7ryDc0PioxlCNa3Bzw4CjpQzOaZ/ohlSmNLnR?=
 =?us-ascii?Q?mqfuq8b3MA1WHqgS+1EpgnyCTsHjtVikbZX+mjUkyyNK/GWvDLK0E20QXiO5?=
 =?us-ascii?Q?XqfOxK+KDu7We8CQlMFLqHvbOKzH0SoCgi5RR77BndmeBRiBOZRmL5bE/2Ia?=
 =?us-ascii?Q?a+hdGNjbYs76zyEqQafLCjwzxAmikoIB+6PLZqc3hXldrqqCYhE6FPw/MSEz?=
 =?us-ascii?Q?PFt4Ep0PlvaeaAV6Uuw48BX87lQsqAtE5+1fKivneDGrYTPuMFi8WB9TFqD/?=
 =?us-ascii?Q?MCd8cnHp4Qx4jtjILQeFnRNVcqMCAKLIVjXx1MCt1T+2SRphDL42Cu66SLk2?=
 =?us-ascii?Q?G2RVWdCqQqtdllR3yAjr0EJDyPHqAolK6yL552AJC0A4wcHlidm9ncUDQ1is?=
 =?us-ascii?Q?d+0joMDLHoHIfDw3BBaqnK5BFLLmulV5E7DLsg/JOX9V1S0IQWvR/33JDM66?=
 =?us-ascii?Q?3EmxBP7TAMO9mww39yYkBnMUSYKgLlIB/+mnS0EEFlVZG5Yg6emW2qdc5u9q?=
 =?us-ascii?Q?GStjBE3nVFByJeLsNqOiAgxVqrS+lMsfdSZNUD4Ck2CDNfiFPNTBx+FbhXsq?=
 =?us-ascii?Q?NWz3UX4U+KrB92m9M1gUjmFOlBH2iCjfDuHsyU6JeIPbENomY5WXclxY3xPo?=
 =?us-ascii?Q?dvdPt6NfOY7mxQLTL2Fxj6eJoUzVKOYQBueemIMqb8yHT308+ksrc9W6UsRZ?=
 =?us-ascii?Q?oYuvPPz7rY18v4jKUlbEAHyDs9JQZJCuqa6hiW13kn+EI1ci6crOxuMQBWA0?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564c891e-0805-470a-2ac1-08dd8ec3b16b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:35:30.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOiCBytU1+kMMYGvZIyDJOd4olnaZfhm6h5QekRNluKutSe15uijDMG+UpXcUfw19m4xJXt4QFlALIALRkzbVWeqOh93IS1XIJWs/Y/SxGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681da234 cx=c_pps a=kSx+wkOqrR7DBdLtetN7AQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=CXR9pdGyltkxUn7QIsEA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vHVTd-i3Fmov7G7gBDCh6CWoD_xhbB2w
X-Proofpoint-ORIG-GUID: vHVTd-i3Fmov7G7gBDCh6CWoD_xhbB2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MSBTYWx0ZWRfX6JXGWYh7yPk+ mto7idV9M9r/+CI3bGePC07xKMVzqElRDTYXXjiL1/DC87MLHawtk3dj68Hu1Zi1Q37bGRvb4MW twICnAAmxj9nMU7FvYlmHD0lSEfEi7Q/sO6veGStZ+iEj+/RBooZKD6q8AaHs9SDCbtfgci/WEG
 G2k0nLT7UlqK1ixv+1Ue8NTS89jyDnRusx2vPwEfEHW5gD3JfKuQyNXuCK40D7fPF+oH6FMtG9P ACMf5u2mAwjDJXRgmv13I2hJ3rGDldYwFoWgzBfsdw+mSRmPportToGDw5benaOdHG65lrnVy6V 2CgglUp1RItQaUKEBPDN6A6cqWiAsYpWTXZDmPP1drejDNJ8bqqqOG2Vk3G+0iFQ7TA46Cyx7Wi
 SvzlsfjeHoBKKs+WhOSq+UE3gVaznkKWdoprm0JMn8xZwwmiYuT+gO0MocsOn1sUACHEfhwx
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090061

From: GONG Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit b0e525d7a22ea350e75e2aec22e47fcfafa4cacd ]

The error handling for the case `con_index == 0` should involve dropping
the pm usage counter, as ucsi_ccg_sync_control() gets it at the
beginning. Fix it.

Cc: stable <stable@kernel.org>
Fixes: e56aac6e5a25 ("usb: typec: fix potential array underflow in ucsi_ccg_sync_control()")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250107015750.2778646-1-gongruiqi1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 3983bf21a580..dffdb5eb506b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -575,7 +575,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 				    UCSI_CMD_CONNECTOR_MASK;
 			if (con_index == 0) {
 				ret = -EINVAL;
-				goto unlock;
+				goto err_put;
 			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
@@ -591,8 +591,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
-unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1


