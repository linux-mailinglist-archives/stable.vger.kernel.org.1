Return-Path: <stable+bounces-127399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64EA789D3
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EB81893E44
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41016BE17;
	Wed,  2 Apr 2025 08:28:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D7234973
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582526; cv=fail; b=lfSGzprDgTnH0DdUxj5LrmLH5DuRqBAi1do3JZZ7S++0xwobDOsVm/DFJpRTojs54OeEhYzt6iNk8HjRiaTdb7gOWlTo/8qdeguZ2rgaSAvtfKg0ioauJRLSOZLIu06whD4Jk/39t+n4oai9vvA7qN7gw5FySo98rz1DyVk8BYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582526; c=relaxed/simple;
	bh=pcVlKc6nx3JEkkw/XOx5Se12heHcYdbyduv4trtGcnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9wcS5865wDcLcPdqmhqPzmTi+6x8PlWfqdc7bNHn+FSOw9anUUYeAcdm5bdgOlhrTokIMc6+kSaBzqhoon7vhlshclGAxz7A1Bc64LjMVd753w8+DG6C7JxOjga/mlSSR0U+cugjbV0++ZPAYLlDbijyuawfgyAgvBeJaUViyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53268T8g022315;
	Wed, 2 Apr 2025 01:28:38 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtf2ggqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXHbhjNUh/XS4MSyqxu2zg117C2Ff2Qzb6GBSKIdeEsQNLD+Rwcj3CVbrwJMlQ/RblZ2f+eeIezQxemx6jkSxHcdPJJgDi/HgoJ6kbKpFB4ZxnIYodSqr1keOjgeiwxtCxF4Xhbk/xk9DKWvuWTovxmzXlqhK2oFqq41Edzu13WgXo0VBQjY4Mkt7N0qNQyyw1snaSHkuRiDJ/j8Kcjyf45fzgO8VvoAahAgC0Zq0WVMy8g5qv5NjOUXiIkNGFk4hbUFK4GHnUHoQlI87V1AVZ+Zv3m1ZpGoSbYUJgYaPIHimga/e+57yQnvWVxdJsTDIRhrbJ8piR41jIInnJFe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW5zPnv71tQobpUlNtdKt4mtW3p9d6YiF0oug+UGHPQ=;
 b=cNjgOOyqp1hxBwxVMbR+U5sGsTBIoovwrD9vPx5LiFZe4UY4WXXCgHtTWymgPCFsSRNP710yI8KDpfpfOmhMzmwt7wGxchD07OyW2+cenr0L+rV3yHr8K/wLOMB9dH4EEV7VqsBI6iJz16uzsNhZuBmmcbJb/uaUMKpcS9BlRKFpQX2rBvHX8FEBPaVqGh9/j9AtnUXpbrROZ/AXvu94XcISharoj30c8fKh/vPffpSYsE2BxEn5fKNaPwRfbp5NayropzD83pLYgXpwGnJAygjz5vZYODU/P/g7pO4M/p+c0IwMVUp+2NCsVpUu4SOn0ZgX01V7ftHveKbPzGgiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:36 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:36 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 6/6] mm: Remove unused vm_brk()
Date: Wed,  2 Apr 2025 16:26:56 +0800
Message-Id: <20250402082656.4177277-7-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d6e517-ec2f-48b8-3214-08dd71c05ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMZKumtYS2j4jRY7rdcrjvFPaGoxTCWgatR+KneQ0R1rPEKZ86n2ucNNGsgc?=
 =?us-ascii?Q?B7oN2VcjxWC8Jv/Ptqivfv0sNmzzFaCS/RIHBfbB8tjgqiUCIqpGKPd4qLwt?=
 =?us-ascii?Q?RtlksxGHrEeDfa0OFDS0MI1EyMsmDnnA/8iF0+L5EHdF8B0gjAJAecab2jKr?=
 =?us-ascii?Q?+RuFEvxX68F74Rk/X2EbEVINpSS7Xl4NivLH4sz2pOVBkm4/Wq8GCJ4ZkbPi?=
 =?us-ascii?Q?jWm92t3EEHGQJGqT08MNjQOSZzZDAHmTBfmPO+Gn7yckJeAfpIrSblMCCbwT?=
 =?us-ascii?Q?S9bOs5XUoH0x2yz8dsrldP/E1J3bQl3lFBb8gyWqOlFITPPoP9uWD8QzUnK5?=
 =?us-ascii?Q?cE4ndj6QzfsbUhtlv7v9LEcySdvR53pX1VI28bYGdmAvOK3osDl4YFx2cjKI?=
 =?us-ascii?Q?BXme3SYhsQ3S7rzCujiBAdNDgwPpP42AMz2x08ym0BJGpiECY4W1ID9J60iB?=
 =?us-ascii?Q?aOa//8ZFRRc6wrR9k/jx7+S8BrMjUg1ItuhG55TLu9X/MgW95yw+N2VvjUug?=
 =?us-ascii?Q?KRCOamEXz5D2yOCMaG4up/SomKrV1uiPAFzcVWemjVyVtqNwkRvIFm/i2RTF?=
 =?us-ascii?Q?USrz6R2EieszRBx86O8wcnw39BPtHcL+WgYMB+nc7G0oA2FbBMAhfSMRQYNz?=
 =?us-ascii?Q?ML38Rr0aK7hDUoDI9v42+eqgyf20cG0emXzRUp6+bm/rVLtzumTG9MNI/Rob?=
 =?us-ascii?Q?ScWbiUwef6pCpqzCTTQGrXQ9RNy7OIEBZ6lawF3abpWKd5R2soyUw/LtZ+Iv?=
 =?us-ascii?Q?XzPgWGf1cn0ISjJFSa9c0zaRmwNl2D0GJ7nrsHbEJSY4SnIcPcobc4k1LNl2?=
 =?us-ascii?Q?LnQn/VMRjdG/vlWivbFjBeR6W7nFP2G3EwVN5UJ6CQEc8d80LLItKt6KnOyZ?=
 =?us-ascii?Q?eO9XX9wdpdQAWa5BbQr20pAndHt3Dt62sBF5ei4VokquaR/obKxNL5Zt9uvz?=
 =?us-ascii?Q?1I2G8ukb0Ajjd7xendZV2xKcClrpDeJuNTQ31plXHAz/29tezSrx9dJ+3mm5?=
 =?us-ascii?Q?TLQxBlfh28t8Uge1sZgvkLeaRPlRcEp3vZgLaJFLP62GNjqQUKozFAI20BKZ?=
 =?us-ascii?Q?q/ynjZzgq8xQdjhgfu6pYjTSc8jnvacT0l711g2RjsoaEVICJWuTkIo7BH8C?=
 =?us-ascii?Q?Ep9AkJtRi8i0KzWsxilAZ9QktoXHRTLFbSRq4vmUBXm6bnWyTGtBdGUapGMh?=
 =?us-ascii?Q?UOzkQKWZ4Crlyy7k4MOzwyjWWc9j1Y6vSXja6Fb3qIi9MXYixtgmZN9IW2fZ?=
 =?us-ascii?Q?WxjIxrjXdr8N4KpWs/iWOcVokPQ2Jdts08xut68TBxmXW2Kk2As2KlSLmkK0?=
 =?us-ascii?Q?NisWB2bV+Sz8cH3i5jnHmTD8R2+UQEro4GPKwMtDVol2d+majfT6uAeUgj5w?=
 =?us-ascii?Q?9RyrY7oKKy/4K0FmgA98eqLq5p1jz41EbT32d6rN9CrqQuJ8neQ3RmXgKbil?=
 =?us-ascii?Q?Sb/4bc1IUIbWzK6OfzG+txgIw0QlGPb57GC1ueTZo5ZMXWQYOyjUruyvk6Tu?=
 =?us-ascii?Q?lQ8TNfI9LGEeWk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZyES57jXNxo9Hz9Om1Rdr7r4Cbszq7nZW3zlZxjTnA6lcYGrKDsesoTETXO?=
 =?us-ascii?Q?vo2zhO0IOcRN1tjgW92HMmciPI4L8YoxdRPHtEwc08eVNJNFNBN9NASFgr9m?=
 =?us-ascii?Q?SYqbNLytzncDKL2xnURnUYIxTCAnYjCnMYiHDH6rtM45ioTb9IQRNoD6oTsM?=
 =?us-ascii?Q?S25RuesHfNQVyuCxV8SFWpvyVelrTITZJ0VmACkVKhsNYU5yWxSzNNqM/3TG?=
 =?us-ascii?Q?axN93EzEjCQtc7RdUK5dWKRnD+410STiP2YZKrq+Jp+I2JVUiXa/n6igXGRm?=
 =?us-ascii?Q?jcy+I+XmDylIG+T4+uWi+MU3UNIJq/t79HhX5CqICTpeWS5Is+tujVu2FNNn?=
 =?us-ascii?Q?p2/8102clF2zJdFnqlCvQ38dcRm81WG6EbjsOy+nHI9inSAw4V2n1bUJfgCw?=
 =?us-ascii?Q?UGcCuELEYvf7SbLVJMqvHpx0DM/nNr+jZfXIQ4VhEDig6Nz8ZFBZHcA3Vr7S?=
 =?us-ascii?Q?AGULn4oVZZ3e1Mpr5cAo/32185ifrHNjtsXxQiK6fgwBLGjZNDStPcGEuR7D?=
 =?us-ascii?Q?6SuJlREXmJrWGnj7HchLmS62qskJJ3PYZdyGtAE85dTLHKO0j5FqL1Y0GsGL?=
 =?us-ascii?Q?0i8i/sbGkbgEoIvaYUx0irzR2YC5mDfVkSRn4JhTkAkcRFlUwsVdOh62gUKx?=
 =?us-ascii?Q?YVyGzAlk1iO7TUwq7ipm2NFUXHhlxWmXz2qBxObq5vkjwXRNdD8rh4iYQqlH?=
 =?us-ascii?Q?FxoIBl69GCjStyG/cgUqpeYe8iHKZxJ1jz7KN8gIb2AOuPcljzkBho6xbXXa?=
 =?us-ascii?Q?T1HV3Kz68PIIa9FOiDV07qCzzjVHHgLZwuaAGGFD+lBqbvF5QMn3qQqqMCYi?=
 =?us-ascii?Q?r2BM+c/1Dxd3RMRn9DzBSsiuJ22y2zkKrHSEKocFD945iLMAYDdx72XYAmff?=
 =?us-ascii?Q?lfX9O6LdmEREAa5OYlZrTtIEXJhLJmUWiXc+9iyAXGREuVFFBV13hBB0XFef?=
 =?us-ascii?Q?4tJAWwa/qrqoQQxK0ztiLE9Nj+nh3JRV/2F21F+2h6xVD+Nd5bQsBJ1JPpgo?=
 =?us-ascii?Q?Dmf1tMuuOtYlkvyHAYqveD2FvE1QBnCWhho5aY7NCIzl4BbdCdXGXLPmB26R?=
 =?us-ascii?Q?1bVg/ytMQGL/lyS99mQWr2ZcWNnvHmWq9lTsNVgppHkBYCR2GdJ6C8M7K8tC?=
 =?us-ascii?Q?04WwN4Iz+39DV5sAZuoTqOiXkpFZJizyrTf+xzyj3Q755bo2brWEIC6BOrsK?=
 =?us-ascii?Q?0/KI8Z9Y8qpcBkcSHjXeTUjkwV4e2lUZs8hI7ExxQJrNOtvSWng4M6N9KbEo?=
 =?us-ascii?Q?hx/IgujCdbJWt3kfPL2XlZOMl+D2/ccE/efUVEvSnDKcpoa9BccI67Ou1zET?=
 =?us-ascii?Q?Ibpj+tpKUHRNm8a6viM2KGf9Fa6aWWAZmGeh59JBlXm53HC5NfuAHMXXQgJS?=
 =?us-ascii?Q?7L1x+oYrlgRbY7uz+mar3IknnRnQ1cTpH7G3GCLgy05aEat3pBEsyPpYSmwe?=
 =?us-ascii?Q?qpueoFXVq2drEFmdubaQks4mGFG5n72FidMzpmU+71x9sjKtOlioqsl/ERXD?=
 =?us-ascii?Q?koKaRZNNE99N9vvzT6bijVTEu8np2gTGOsHuAO/bKQWE7E4LeDVTaN/ZbN8+?=
 =?us-ascii?Q?kjpJiMRMXpCH5o4EkAE+uj4x05jj6JAIDnuq4auuftP1hmLUbXram6rufvJe?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d6e517-ec2f-48b8-3214-08dd71c05ca2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:36.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31mgj5ri9P4TTosHmnDvqBEHmj6svhZr0PtdLSxzAyGgaxl21yES1KbrLDhG1ViX6tzvrMrxiuKi8avOWJX5VZUijuilKEs2DXrJU903fiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: pLkq71Ld8sp9xTc4LqZOLF0iNfS93R8y
X-Proofpoint-GUID: pLkq71Ld8sp9xTc4LqZOLF0iNfS93R8y
X-Authority-Analysis: v=2.4 cv=fM453Yae c=1 sm=1 tr=0 ts=67ecf536 cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=Z4Rwk6OoAAAA:8 a=37rDS-QxAAAA:8 a=PtDNVHqPAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=JvzyLxfkzvKq0Z_-GKIA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22
 a=BpimnaHY1jUKGyF_4-AF:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: Kees Cook <keescook@chromium.org>

commit 2632bb84d1d53cfd6cf65261064273ded4f759d5 upstream

With fs/binfmt_elf.c fully refactored to use the new elf_load() helper,
there are no more users of vm_brk(), so remove it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-6-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 include/linux/mm.h | 3 +--
 mm/mmap.c          | 6 ------
 mm/nommu.c         | 5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 209370f64436..586e8d216be8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3315,8 +3315,7 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
-/* These take the mm semaphore themselves */
-extern int __must_check vm_brk(unsigned long, unsigned long);
+/* This takes the mm semaphore itself */
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
 extern int vm_munmap(unsigned long, size_t);
 extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
diff --git a/mm/mmap.c b/mm/mmap.c
index 03a24cb3951d..c43048fc493e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3256,12 +3256,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return vm_brk_flags(addr, len, 0);
-}
-EXPORT_SYMBOL(vm_brk);
-
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
diff --git a/mm/nommu.c b/mm/nommu.c
index 3228b2d3e4ab..346b26b2660c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1537,11 +1537,6 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_unlock(mm);
 }
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return -ENOMEM;
-}
-
 /*
  * expand (or shrink) an existing mapping, potentially moving it at the same
  * time (controlled by the MREMAP_MAYMOVE flag and available VM space)
-- 
2.43.0


