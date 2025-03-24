Return-Path: <stable+bounces-125850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F2A6D4F1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25F116A897
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E02512C4;
	Mon, 24 Mar 2025 07:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F1250C16
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800883; cv=fail; b=pJo05ChBzL/is06NBC32n8tOQZlpt1LcrCIi65jomFIQioIbjk2SgISeWRtctx3Q6JB5ILtTsTEuqc6nOTs+qD79Uc8mVCQ5QeePwqS5jkoU+cX82/jq5q9D1G87nKUO5rc9aVECbMOxDSKMcgbqtHoLDT8N3O6kImrcuAIIANo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800883; c=relaxed/simple;
	bh=pl4FlPW6WhJDyNtKnN50mx52nE8ihBGp0CjuYcB2CYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYEKcaoYOQmoUf3UxzNh5aPW6AX5dooR4KpAx1kb418S7eOINp7sxH6PwyDw/ZduqQ6qH+7HHnemeRk/Pt29ozfVduQhiexgqHu8tULRPzFHT+vv7Ir9IF8yPLq3wcl9k79r4jtlp7Zs33lcldVVcOO0R+4EBluFOSP32MRuR34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O48iD3028828;
	Mon, 24 Mar 2025 07:21:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1hu6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:21:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxo81PqtWcT+/Sp6SkwIUbsqRJdBa7x+FyEGKMRrQr6AjzNZNoJlG5jQCt2WHu7XcW8SLLt1MR8hyp+XexIMaJ2DPlz5yCKAQOolJvG0MZdwNIq3eYz9x3LQGaAkDXmf1FxrSJPLrzHiwt3vSUyYqv0CPiT7CE0W2YpgfPkc1ZN020ju2ZUwT834zRzFW62lXCsuTWQe0vDRzRt9zdA+lpyhOiZ9HMRElD9QClkB+OUyD0PA/to9xsHD49f2whvoiypnbILiTxx3DvNTgUIMLcTGuRL4iVomFMnM8hCbGmafSpt29AOQnIo2BHG7MgJqotpLVni6stXiwoxpCRIOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j//GvhyGN001ogpMWypes3NHZRS6gsL4Hl33wkpTQAo=;
 b=jHi0GMmjY11Cvugii866PWQq639H5qn8F21HXEN+jZSpNKPhsgzWXEK7KQdzu37IY7arpl0hAcowwTQLTv1dl1yYSE3626YLW0UIex8LWXwc/EGdQh8lUp6AesOBSHgNwFwacWhjs7Bt0KF/3YKgjAXulHTIikQWBuoW+nysyl76WqW6oADaoZsRo6iSRIZAEveQVx487MmhZGPQiAx3r35z3t4aLTq+pHstzTNT1UEfU/KCJy/WmARE8YDRJDaL3u+1loIOqx4ORphz35qLAt1ugVXK8OZNMuTkRKjLUhXaWJqpYl0asXH3OEM7YZtFOxWyD1h/GVZBBtS+jGASnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:17 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:17 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 4/7] binfmt_elf: Use elf_load() for interpreter
Date: Mon, 24 Mar 2025 15:19:39 +0800
Message-Id: <20250324071942.2553928-5-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d22513-73c5-4eb5-3f32-08dd6aa47782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z6cxbXI7VDmFJ1+ZXLNYkWqCPSO5S8p47Wj0perSbqivm9VkikIFxvjiXYOm?=
 =?us-ascii?Q?4MlqWRcU/dwUh8YUwQFNtiLVB8CLJMSMJJVTa2nzJ4ONi9UUA/LLOooJPeKS?=
 =?us-ascii?Q?OrSwkLEtZDV+tqwrS5XhsubWCWNClB4FFv9OCXSTk37eGwjO3dNnvy1hjJ5B?=
 =?us-ascii?Q?iDlnf/xPyX6DBKN3pdz1qAD4hUEyVj7SnYT2BqaMGryR9zNPNOW9bsg3Lvn4?=
 =?us-ascii?Q?7MocbD/bKAFYB7wicZsT0yFh9ThiUCMFNQ6gLhja5PaWNX+WZKzYmqmSHa3R?=
 =?us-ascii?Q?1Mzb9751WYc8IVK0S8QpIKH5skVn0onKIjRoHc/KvatK73PK7o1Ng8xrQFqJ?=
 =?us-ascii?Q?dnTTRL+DCY9gBnWdCs76a3OJFK/3EGdnlA3xMruNA+AbtC8bGmhIRbjCp8Mc?=
 =?us-ascii?Q?JsKYQSnn2+Kw7U9ksUjcPqca4vKZXd78eN1bgnjA1Xq4XoZyO1Jx37p7n+Ys?=
 =?us-ascii?Q?sSaFx1Fk4ZekRuAINyJGkd9UKR6Lc2k8kqzrXOifNDcFp2utDA6mU0zCZgig?=
 =?us-ascii?Q?Q7w1BoSPRATYg92pAwCiVrGQuUeBDJnu4nn1AHkJLAStk/nINdoaCMiaUD0V?=
 =?us-ascii?Q?S6FrOKDN3SzGJM833K/yN3OHWPm1eDzplj8ljaNEC6lgCrExBBFb03RYj5jG?=
 =?us-ascii?Q?BPf5X/v/xoaf+I+p/9NVJ+gq5VgYcBCUwWXDzBX/2pflQC1FJVjNuk0XenYN?=
 =?us-ascii?Q?pZVHRgFIZ6z630OuuPp3EGckF+OUjfpa8oGtcqR8b6FKEAeYgnZCrxuKwt8/?=
 =?us-ascii?Q?hHi6NKr+uI5WRh1NNbdfAjUhbzEJzcMA0oFKigLlApCfOqSkxkDcmwoeWFMI?=
 =?us-ascii?Q?7zVoQzeyS3kKS1m+bpzImDbwuU4+WlJJhwC3Ra4rs0xmYMjQQcKYaxgNpC85?=
 =?us-ascii?Q?wAJyP3yFlYMQoe5USLrINf8fjKZY89pYlzWG/o8xFYKicI09sHiFsO5q+sfe?=
 =?us-ascii?Q?s9IGZPoCsHyuoAduQ0xPlpNYPBRQ3HR7WygGW4kzaPnVKaXG+kR71XgPcyxD?=
 =?us-ascii?Q?VQDr7da0o3+ORp+ZuOooyA/9wv38s5jaunf+bKdGdGMuZk8lqVEtYyaYKwSt?=
 =?us-ascii?Q?KYqrV8m/BaW/p5bPGPKRY4NYQMF7y6HQaLETQU0apbqCofBhVe1ETFZD7GD8?=
 =?us-ascii?Q?66fy4jtfGEnGMLYB9PjGcEnX/jn2DcLTDeHQjzx7nmgh7CbpVws7MWMF72ox?=
 =?us-ascii?Q?mmw+4bHJcyE2KcRoGL4D1DT1x+vWBKGorwSlUsBvPDVitoDJZz9warMPEyxH?=
 =?us-ascii?Q?4ZwIpupvtIHZ4Lc2pH2ZQA37HDS6QXUguDd/PPmzfitUlJWEA2BTYznIHd3K?=
 =?us-ascii?Q?silv1PuEIPsARe1aQxUvukDvzBPtpsEKi9WMlu6Hdpa4lNrg7Q9eRYaettKL?=
 =?us-ascii?Q?7Ha5avU+H2L+epXV+A6CfVjDzyy6ZtDe0ncMbJetvwBXmVy9Rg7a1scmsTDO?=
 =?us-ascii?Q?iXz+v8v/kaxJ8GqqIHG1OHil12TTQlHAa/fKvV5l2/r6BOnXmuX5Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgkXXXjPdxVAn9K5ELvKIoZK2r7y4ucjL3CiKuVuQxxwfl0yrqVMAXWYALD+?=
 =?us-ascii?Q?10bEQJaECZGCR+Ft6FTgUIwTuUjwfkecyCYTbssRB6pW/6NMLqabyVcNdCrW?=
 =?us-ascii?Q?gjC8PuJIluCYXFK9XF8OYn5crW/siIhBabcUksfYkLbUmsM8vyc6YxJHoX0T?=
 =?us-ascii?Q?06hghHUwO22pgqR+lzI2M/FNMomyFJm0x0WMf4EHfnD7c6TRo1Ql0tsFfx7+?=
 =?us-ascii?Q?eMfr1c4bL4OtTayq75xTvpOS3k6CkOsuiskrjOnYk1REo1TeSx6QOoXfkqYA?=
 =?us-ascii?Q?QCjKcohV4n9ytyh7GtF+6jD4j/8/OWBZhV9CDXGE3O4LIEkawDQdpH6Udfic?=
 =?us-ascii?Q?ezYlWL95UU0VyKZEDCI8lUoOCDc7zFVZxbxMUv0iUeqOP9mNdQtMguPnvi9Z?=
 =?us-ascii?Q?36PhqPjA5TtfkU1nqCF+3iE1GmHq8AZhM0OBBDJ5syz8Mb1+NESjDB9gE7dX?=
 =?us-ascii?Q?PjEnI6doLVdTi3zqWO2suvmNkQ2/1aWhbH7anOhLS6Cv0/J+uoQoz6ZQ/KSE?=
 =?us-ascii?Q?ixQGNeeFHiFmia/c6Jqmkmbf9A9oaGczwY7l9dZBWnibssUcC2k7MuD20l50?=
 =?us-ascii?Q?kGUir+kmoTECiEuoDBa+qtHIHZpNl4DqAw1XJjzSCdC8rk/X5EcDHNgx56ZY?=
 =?us-ascii?Q?tR1pgxA5VMShK6PSFYuHe8v+Plz6pOIbzyjscYrEHZmVHM/P/haN7yp36OZ6?=
 =?us-ascii?Q?n7v6BBIVdxgRXUVHi9r6Hbwn2C6UaVNlY8G9C9PSYGKnvev0KZFABXBKFrNT?=
 =?us-ascii?Q?S/B2oo9WRx05bBapj1WarIYaDoRCgT89u13n+hAE6mGBQREdm/+PYEOBeu7I?=
 =?us-ascii?Q?GVA+LRmx7ihoeDfq4ntvvdbJIDmQgmQMGiXGQ7PdhItcgxntb6eAcgOnK91R?=
 =?us-ascii?Q?u0cOgsOCqwxNJlM5ELobdMXx1of7XIwb/ay8K42VOJohNlG2ryDqgFMCcGU5?=
 =?us-ascii?Q?i64GCkq0SyYGGekRlL+w9ogaLREg2osYkPvJoDBw2rAXuMmL6phzFEG5/Q7N?=
 =?us-ascii?Q?dBCEQ2ztIz2lr+R4CYsMQogUdD/tgBW7+mJ2e6En0J89VjweuR8RZ371rrKU?=
 =?us-ascii?Q?EOGYiFOgnyVIldMEQBo10gwgkWIeUEdnbZN6b3JWB7ejXrm+/VtrYHiaLqUi?=
 =?us-ascii?Q?K0cmB+ERy9xrfuPUoQTDOzL0V0S3x/vndqFQmgdD759k8UyAJvmPb0DDMKys?=
 =?us-ascii?Q?/4S9lZmAwFSsdzuVwDQF3CUDg1ADcLNqYi/ENN02cEcsJ5ScI1RTBmwH64jf?=
 =?us-ascii?Q?nNlEGiMWtaRAxyTwXuywOgvi4z07C49I2PIci6yP5FKRiKWaCrTGfAzE473Q?=
 =?us-ascii?Q?fPjW0LZpJ7J58PbbCMGted+6DzV4sN0yNfgRpa2FYEhIw71CLqIVkMsv1wLt?=
 =?us-ascii?Q?8WVPyoUBr2F0S+6F2WJ5etFxGaN8zeCqpmo9tuo6hjTFo4d9HDzYOKklSk5h?=
 =?us-ascii?Q?PTiCpVMCkJBf5EQMFU/XXZyYVGZCQui+j9iZvQTo1p8MrRH9gFfeI/ykQfX8?=
 =?us-ascii?Q?gMlAfV+E/sKojM/mGRjKAP4jO0nJdimlaC05ecHiZphzeRWaKsznhdj1gTlx?=
 =?us-ascii?Q?3blrTh2zeXqjT+8qrOW37V9Z5/mk82N7eFrPZBQ3plMKopU/6U6jGJkjgJd1?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d22513-73c5-4eb5-3f32-08dd6aa47782
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:17.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k32IS5LQ+sdWnqE4MYmLtyD3yszZGTyB8wyUWNw0MMR6kJfdvT7RNh2VDDWXq2HtqyhWpg/3aZVLNwLnLvPuVry7JjYCNRMHLsClepUfHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e107ee cx=c_pps a=vIBLTX18KUGM0ea88UIWow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=pfM7RCkbe295brOvbPYA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Xaih8k8x7bherXwC4jWM2IcLXouy9Ewz
X-Proofpoint-ORIG-GUID: Xaih8k8x7bherXwC4jWM2IcLXouy9Ewz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Kees Cook <keescook@chromium.org>

commit 8b04d32678e3c46b8a738178e0e55918eaa3be17 upstream

Handle arbitrary memsz>filesz in interpreter ELF segments, instead of
only supporting it in the last segment (which is expected to be the
BSS).

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Closes: https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-3-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 631219c3ace9..64c5e5cd0cd8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -623,8 +623,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -661,7 +659,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			else if (no_base && interp_elf_ex->e_type == ET_DYN)
 				load_addr = -vaddr;
 
-			map_addr = elf_map(interpreter, load_addr + vaddr,
+			map_addr = elf_load(interpreter, load_addr + vaddr,
 					eppnt, elf_prot, elf_type, total_size);
 			total_size = 0;
 			error = map_addr;
@@ -687,51 +685,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
-
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
-
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
-			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
-		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
-
 	error = load_addr;
 out:
 	return error;
-- 
2.39.2


