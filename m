Return-Path: <stable+bounces-144107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6696AB4C31
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3364A19E6289
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28791EB187;
	Tue, 13 May 2025 06:43:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FB183CB0
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118633; cv=fail; b=A8wPxqvLCwkxu1vbUHTnz6P76WLwp/Y5p1R2QvgFkSeVFMgC7k0coL5VYqwKk4vjTtQ+torq4tnPWArjToF4ajS7MFXYHZyMdyHapS9SwNX6AWQgHb9AiuGEQdMFepU/iRIUHkNebWP1KGA+yETMbGCaa3BKRyVSQH1spvTzoh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118633; c=relaxed/simple;
	bh=3/urxzXAzQE5QIEy1hWJrgHpNQd89efoB0szEYSGNAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZYv4UFBn+6OhnVEgxKAufwHWO6EaodSeyd/UxMoCUGlBnUnlkD4kP144VV8Jn4AN0jkSbzN1UfCa3O0Jy1TnEH6aYoho5ypXqslbkab/+Z27DZweQaBrvrahytT0FuLyQQ7SzN9uzI5xc71bOXXWoTBHW5OvP6R48puTqQyht0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D5UidU027150;
	Tue, 13 May 2025 06:43:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46hws8antt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 06:43:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu0lbP2ClQuwFHQwVZ7dHzKesZj9/T8foDxbnH/Z0nYZfMdXI/Sh+5W7BmSU1M8rRIgBmfBgQ+OLU//Brwhq7SWwq5NHgdcmqEJv/yMhl5JowMR8JU3E41Cg+T2WbK6UFVLMa2R1McpVwOJS8u1VjqZc4jnCsdrl9ibiNn1ylyec17ZcesgSMCPg7Y166EWmxNyd0uCY/lSgesVWQQScKBN61DD0O2x02SMRpJyvQhIwnekyxDKfaObmPLF5ZzPKxcgzrjAp9tyzuejB4WMr37DSmUJZPnzMARuWph+lSZ1LVDQ+W3zW8FvSr+ngST3EKTbP8wvCeMxLGj+r7BZJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M5jTBgvOphopm50SmuFcbtvsRy7TZBg47Pr4k2oT/o=;
 b=nA82aqZpM1iGYRpxb9DtL3lgxVfiRp4tAmeVWvidYaTfk9ROaLf3g9wBpYlZ17IM+eIoFqNhCkMGHJJQp544yJxCVbHp6L5yBhzX98MzzIYCt4438g0/udP6oFWXP1JQNsgNkOrw9h8MH9wWcFouGw95Ut7SzBYEF39eWyvkMuWQ6llX7ZQM5GkMrunxI2nuhXphFn7mllF9bFL0q7MQsYQBQuteI46NHSnidzjkl/FqSEoP56EufXdgZ8p19QgPqHhF+KuNdu0t+qpbjRiUcXBhQOPzpoAzHgTNly5g/xkXiQzVXQ2zu5qx4264XhJQ1vqkY4vZIk0k5C85Wtaw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 06:43:26 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:43:26 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, puranjay@kernel.org,
        SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com,
        daniel@iogearbox.net
Subject: [PATCH 6.6.y 2/2] bpf, arm64: Fix address emission with tag-based KASAN enabled
Date: Tue, 13 May 2025 14:43:08 +0800
Message-Id: <20250513064308.1281656-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513064308.1281656-1-bin.lan.cn@windriver.com>
References: <20250513064308.1281656-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:4::27) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a53d56b-7ec4-4fb6-888f-08dd91e976c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DSpsYcK0CS3kIR1FCEnqocG9nreYCJ3uFEiz7fFW7C4OKDYjCyFdD4cRjlxA?=
 =?us-ascii?Q?6E7eJmqfAikRjJT8/xCfETSc61Ykf+pVauXufSCSeuRhVcQHMKKld/MlWudd?=
 =?us-ascii?Q?6e0Jmnlq7iKordaA4LAE5U+3WYN9dTfT2sPKtbG3LxXJ5DMKcCpyGQtdbcIE?=
 =?us-ascii?Q?USHZZL3UwqSNd7gHnGAtuIoMz9Ibrwcgh1/+sVh7qhLxlWiA7JwqKNvb1Epy?=
 =?us-ascii?Q?Y61F87dYaHwoBxzMCRoy0blbhH/dTKoS1v7tosz196xzwzWZQ2+TwAsozlMG?=
 =?us-ascii?Q?+x8o37aBxmB8ZevfRhJWpfgb3MS2+dGBhjibP7arvfc3cH2rNrtiwQ64lsET?=
 =?us-ascii?Q?zShYW4D/P3YjRk4aGcCm6d9ITJ6a9z0jOXIEnuDywv2Nzkqv+6ehQt3gxigl?=
 =?us-ascii?Q?7qo+i4k8sT4JApDoIlzFvvxy+3Ds1Gw7+p6MosWbjBaGYq1IifvDZl9BAyOO?=
 =?us-ascii?Q?Jfgkb/kO0ds9ovS2ooieYhuPgoiy3ZD8Ktl/hMDhsSMja5IAfSAmOw2wjzBo?=
 =?us-ascii?Q?TfGCZzKsPm1ZemZ9bRJKJVwV79aRPSzippIzlnv3wj9jPsQzVUKO0rAXajBa?=
 =?us-ascii?Q?Umntzc1qqUywmLjSUP3sFiVHz8sovXVw5DzgTQhgOncDjP2IWHuGqCF2uOkW?=
 =?us-ascii?Q?7rRcN9ckXAvHLaFfwLKVUyyAlZLaHGNfAiEEy5lTORkL6fHvDx6XqG0XXMBt?=
 =?us-ascii?Q?0WqmtAyPybQnR+5w+5MGEdylGz8Da05a1yd2OSGNLrHvzweRHANIGyrO+Fcy?=
 =?us-ascii?Q?8i/tOUZ6F7/umCmzL9VtOX+aPqt1LrI69LMNu0NLadY0c8w+1AUAIK8i+8WV?=
 =?us-ascii?Q?wQ9BswE+j6txlbWGl+lYjjVUk1UcA7XAYs3VdS6ehPBp4tA9KX1KAB/FeskG?=
 =?us-ascii?Q?4kwKf5GD0/2dFS3CBeXlEBQFP54jIaaxo+E4J4nRggjaxgXvTbl4xSNUPiqG?=
 =?us-ascii?Q?bhjdFoT3LIKWx7o3/1Elkyh2Hy1GhKex8zobGqo509RbnBRC+GNqFe2f5p8u?=
 =?us-ascii?Q?WoeEIbEZIwZkgQYJ/JDmWeiXnITS1LgaMwcJTwEx3EE/Kw1aNLYNk7I7wjQP?=
 =?us-ascii?Q?3jRkFVMmE47U1bvIMAE8zcYfJno87qd5eL7wXSC1/N6bc/GZmAeV4zIBUeov?=
 =?us-ascii?Q?dwYDR8VJg6M44c1d603PxBgZ0vHVT2ktuo+rjPLfwzhXrCojEKjBI5MZ43GQ?=
 =?us-ascii?Q?s6IgALCmaSHalZkmg8OFZJ/NO5GdRekr42+tLN4Z+kZdXvU5qdpX5i7uig99?=
 =?us-ascii?Q?fO1TTMMPKcXR3dvjZAOK6Izvoy0W9tKlgoJRbmoyl3S6Q0HMvXC6wXepuobK?=
 =?us-ascii?Q?UvddRda8aWRe/WXqXz8IfO/XrHxqRuEjD6nST3zeCiYm53ZZUCC9KBszCQPw?=
 =?us-ascii?Q?MytWqCY45uUF3Sr0R1FpCvu55yQXtx0RNI/mHTd1ccukAhGVjJ2gL2dlftb7?=
 =?us-ascii?Q?Y+snViN9m+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oL+iKljHKI5On0BmJXA/lKP/QYbNkmxL+kKQeKIz4GcESQSYp2I48NG8xSf0?=
 =?us-ascii?Q?Yci43zIKYnrZ0WwXefAZbPzpCNvaVNPMwv25rPOrsa8PUWehXgoReglUuE/r?=
 =?us-ascii?Q?6rDcD3FpFrRklhEOv9L/oPKsjCDZSc5KNL58ZhwHA1ptz3AQS0BNNL/oUBB4?=
 =?us-ascii?Q?oqiWm/vshTZLipkU0Sbsa3iWVT20dwHEeUcWpio11Pg37WyemWy9CXGOFDug?=
 =?us-ascii?Q?3AWE02AaUD42btUfdtcAEi2T43f4Kc3ZVzWfZXeiP26iag8KjDeYd0fO5erC?=
 =?us-ascii?Q?1zSmadSdqtMA9kHU9GKimFxkQ50LjyE6I9YP6OphYJ+F9dzu4Kj6VfzsDb27?=
 =?us-ascii?Q?IV74dywwASNhTT8j2dHmD0anvIg+gzLyhUyhMZ/hwlR+3ENEgDllSdGVB3Jo?=
 =?us-ascii?Q?S8fprWlAhdo8Lbrospk4m+TmWuMAOq6XLfZaDilSqK1xA4tGVoIRtMqq5R4p?=
 =?us-ascii?Q?tRFd4J6FF7lA5yhhUe5QW77EWy5ypIr+nhbtWW0UQQHGMjx+xp2o8pLPeJCi?=
 =?us-ascii?Q?uv5C/z9ItQFhgZZ6HxVRHmnl6VJOqoxzsnitXGitNtOL0waLVr6dHDXVCclD?=
 =?us-ascii?Q?t6VhXgkwAKy7nsnvFAjJQ5tOgR6Dg3fstOtbIbsdspC5vTxE2l0+B4z6CXQh?=
 =?us-ascii?Q?SQ3WC0iBJF1c4QR8x6oKn1/9d6cXGpnqEtkTDdetMupcetvR2DudAlNhPHh0?=
 =?us-ascii?Q?+2Oti76KENpWCaHD9qsbdbv03lJNIL6x0MPU1onkY2NUkX0y026+F01xTBVv?=
 =?us-ascii?Q?uvTZwxX9CP+R0uefUz0+kwKDm2Fjpg3CBzKkyZ8EjsbqmoeT4tLDYTS+kOq4?=
 =?us-ascii?Q?3mEPqIeCpE6yDgW0qSVSSuV9x7ne2zmqGWVycIUhNxDGbiWD1/u7QBObebds?=
 =?us-ascii?Q?0b6lvUeygqtDlA+YHyWXs1qEu3aHGwBYHJ00G71P8tGfZORmYJCDc70ZEqX7?=
 =?us-ascii?Q?Iz6VLjaMDT5YcPDbZ37el/OIr660va8U7q1ht14L/Q+M84xmzbKNHyLrwGqr?=
 =?us-ascii?Q?bXtLADRxNDsmw8Oa9HStQSnXu9yrneaJU9S4QNAJ5N8j9HfLfzHDi5ZeZQaB?=
 =?us-ascii?Q?5cRGVnoC+Fh+eARLxejsiRQoSOJyaZ750YVKfHxDoZHdkGqPJR8cZbkzEeRZ?=
 =?us-ascii?Q?zztcvoFXS2Ysdug27Ae8pLvo9qqorvLW2EwYjMMYnxDS2YauZ2ShDCWRo37P?=
 =?us-ascii?Q?42UkcHyVw6+h+5PEqHPuCkyNizpVUVMH87MPp9rOz8v+hvY7WvD005QvTKcz?=
 =?us-ascii?Q?jMxNRCKRPUsbjTXO1bFoCrsYJZ+If2CocvRfrNZcizq9V6HEB/LJJh2OVgKt?=
 =?us-ascii?Q?zT3nkkALIg7blVtxcD/nJOBlU/8V6VJb45Fpha6IsZscgi4xUNNe3bDCUh/A?=
 =?us-ascii?Q?e6GjsYu5j55InaHSMBDLiAMsSsfBJULy4KIzpnUOC8DR2HJex7HVQouZvh/f?=
 =?us-ascii?Q?X4PeA5+W7QJPWK75S2a9sNIfa61RLHXfqr+idizelG/4ICT26oDyci8awcij?=
 =?us-ascii?Q?sgkug+AszRI0C9o5OTJQzLKmj1PI+fsxxnybDMMW3L3UtZH7c2fcg95awYDv?=
 =?us-ascii?Q?+En35ZvD7WoJXUQuJFe9NxAgcNCwh85ailX89ceakvqCl3I6yoR2RiVtMPzg?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a53d56b-7ec4-4fb6-888f-08dd91e976c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:43:26.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkOGE7vZEb/cY0P/sCBMSiwx9A4pOtNcSuarK6cNq9sz6VGx2JOV3rySkmz0SvjcPqlVjODlqz+7Z6v9N/1xvc9ToiD15IfgDwb8b8yodOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-Proofpoint-ORIG-GUID: 5gXR2MPTdXoIPz_UxlYLhrozzfkuTRdo
X-Proofpoint-GUID: 5gXR2MPTdXoIPz_UxlYLhrozzfkuTRdo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MiBTYWx0ZWRfX7xAqizUfXP3d fOQP+ex/ywTlaReljeT3rTeD8i1YksCFpazY0fnY10zBPMxL7rr5Huzg8UkvKlel+mYXWOUQ0jW iRoXD4GJzpyrxMiEgrw491H4DkULcmMuj+NMSl98OuYMBrCCFerGplYKc+DzhQz5VWIBd1GfqKm
 ncFzdtAhvG4GG6exC1vYkgsv1O5Mm/yPZL1dh1VqrFSLRFJQ7xe3Ytg5FR2OxsWPJ8frU/Rj0Lz u0Pln0uTjhSiCAFylOMeMG1ToMnAr/KQfNRdFflHtkYxtNfvRfTxyziZ23igpsbj26+T7NK6lt4 ppjf0ulOTtw6/oICjPIvQcdpF0Tljj10GvmhJaSrBnRyVsbc84JprQUP4gzlQ5Uq9U1mdRwVa1d
 QaON/NHZqkeqOiyJFdKXkOs13yW4uYDiRjaomwGohTJAtxSMd+Ywca0kcSSLIulFsl6PdApv
X-Authority-Analysis: v=2.4 cv=Q+HS452a c=1 sm=1 tr=0 ts=6822ea10 cx=c_pps a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hWMQpYRtAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=Y_K549ye1V91rRi3LcIA:9 a=7KeoIwV6GZqOttXkcoxL:22 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130062

From: Peter Collingbourne <pcc@google.com>

[ Upstream commit a552e2ef5fd1a6c78267cd4ec5a9b49aa11bbb1c ]

When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
struct on the stack is passed during the size calculation pass and
an address on the heap is passed during code generation. This may
cause a heap buffer overflow if the heap address is tagged because
emit_a64_mov_i64() will emit longer code than it did during the size
calculation pass. The same problem could occur without tag-based
KASAN if one of the 16-bit words of the stack address happened to
be all-ones during the size calculation pass. Fix the problem by
assuming the worst case (4 instructions) when calculating the size
of the bpf_tramp_image address emission.

Fixes: 19d3c179a377 ("bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
Link: https://linux-review.googlesource.com/id/I1496f2bc24fba7a1d492e16e2b94cf43714f2d3c
Link: https://lore.kernel.org/bpf/20241018221644.3240898-1-pcc@google.com
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7c5156e7d31e..95724f58399b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1952,7 +1952,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -1996,7 +2000,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->image + ctx->idx;
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.34.1


