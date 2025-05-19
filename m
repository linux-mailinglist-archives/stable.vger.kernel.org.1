Return-Path: <stable+bounces-144726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C362ABB2DF
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 03:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AF47A3A8E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944F19EEC2;
	Mon, 19 May 2025 01:28:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9B19DFA2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747618131; cv=fail; b=XB17MXVzcB5cS1HDCMuF8G+YI3Z1lusBK08JZQEOJ3puZvzpeLuHGHUA2od2qw22nxiUatObRzMOClUDdGU5BIzawCOpRv8Nw4MDZJEfZ2YL4F4jbfwVdzFjSwU3iXeDnjnu1gu/5fgVlf12wrCnOY4WQLDKLeC+U+UZL70lSKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747618131; c=relaxed/simple;
	bh=Bk9Xx+VWbU2c1bgvi0v4FCbW0D2SVeZqJP15pk6wzTY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S9k83n2F77bonU6RS8fdE5YtApmj04ECtvb2OOhhBOM1FRjNbBedIk8NUPIcWckkFhT/eOFQxrHvqKyYWSiCAgnvlPAc5yioE9Xby3P5mVGNihFURjYJTPRAJFuGAbvaOkSruFqpOJPTHWrIORpI3MMWcb+iE8ZmsGQC4Q+BuCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J0VOjX028277;
	Mon, 19 May 2025 01:28:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46pfp0sfr9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 01:28:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmml6ZfdF++CF2FSw0iB5ks0lq1fTm+XqF4VPmW8eRh4c4cFCl74aJQgEQiX2bj+xaTUWc+xm7Vvsv94LymFrm7ildV7vwSLvR95vmKh1RXbGiAFMPrfK46L9RbQpTEI5NKALooKOs5eyEn6wCrkUbur9u1Xhx+42Bzbh2hLmwU449KYA0KbquQe0oXeVe3I9X6mrOoRg+NpttsqneTZxWzwKoYX210vzMRL52PMBawIl2k21eJkzSqigibEeJwvdeBrGZ8gwtvu7RPuoVyW6wLAI5j4YdgMkR6WIziwkPanEt5o+l+efMrF23aBPb6JFSDxCbS50zSgq+jTv7i/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7RkpO0ub5rSqMO32uPC3QlSCuWaWj/+yJwG3s1YRvQ=;
 b=sXbgE/2nayYN8cLu39KbvYjuK/pBgs47z+0a9HgB6vrUUR4pLpeiLFZl4vAPynv4amOT+T1g+/h8jjgGeEvCg+LgVnROsZpQqjHLR2llm3GPbZhvqDZHucy3u7h8kWp1uneqOdTJJjfU0wcwhIWQeZJaBxKLTDl3N1L/Bw3PZ91QEGVYaPjSYt3As14Qxn8JMAEKZELBFiQ5owcYD+1WZ9bH+wytP8vKO/NcXLQpG3WUCPUUeXkF9VIZK2Oc0M0/20TGl9VgLzcdxsJC/dSoXoYCSBzHD4CJSKSkFTrIVyMAjGp84wfUwSBUkcNdBuCAvCUIzBCcTezcupyXzYPL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 01:28:28 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 01:28:28 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] powerpc/pseries: Fix scv instruction crash with kexec
Date: Mon, 19 May 2025 09:28:15 +0800
Message-Id: <20250519012816.3659046-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0141.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::33) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: e1659027-60f9-444a-10d3-08dd96747512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhUltDkX1GoFRdPSBpCQeZxj9amgjRjLdhp9z5n6tLuNR8Ol0RNf+c1SfIA3?=
 =?us-ascii?Q?73rnKO7QzK26ytvO4n94niqdn2atOBAlH75IxKO9xixgf2NVwxIcbu0AIiBQ?=
 =?us-ascii?Q?bsoYH9OKgRlHmQ85/7eQtNV5rSTwKNFzl8abDkg5IE6eauMXBR3ubEyCA2VE?=
 =?us-ascii?Q?MlZs7wsij/aRoDKI/LXnL2U2SBReOnLE23/FJT2mvi8Nk7fnmdKmqwBGuRGq?=
 =?us-ascii?Q?2unAh6JbvFscPWSiRbNBPzSddQ+WWhmyKLeRErX7mvvCGuhSV+izERJcZ+27?=
 =?us-ascii?Q?g9Y4gHDzVXgdMFf9EJEfrPjfzzlmsJesqD877FBsgRa5c7LaLKA2QatwWqJx?=
 =?us-ascii?Q?cvFpymac66J/4b0FKGmXql1uNR9Rzqwntz5T4cKOhiFtbOY/P28XRYHrOy6c?=
 =?us-ascii?Q?BrN44nqgMHKBmESDnf+soYHz4pC7woML991zMU+kDFhE56YdVQCZvl1aDWQS?=
 =?us-ascii?Q?MhxbJtABIVuI/SLvR1b1numlPlOMT7ex+DGjBpsqpTvtEoFFzMsmVWW7EWPj?=
 =?us-ascii?Q?xwaQxoMHjoWQaRoQ5VBRlBn44M5y4p88053+L+bSl+ukiH0G7N+ZrHlu7xcF?=
 =?us-ascii?Q?Lkoa6SwOEiMT3bUdO+iAwZyeF9WmGZx8Ef+7wy6I8q5gM4VKrW2apnosdVWi?=
 =?us-ascii?Q?aPlqHmcPMh8cgqIwSaaoGwQePe+vUGcmX7uMMhmLFurmSjEI6HHyiD4U1otn?=
 =?us-ascii?Q?0oiPvQPYciAK/JCl06srPHgfI3odxl1lA+yPCENs5+sotauSIOitiuj8XMMh?=
 =?us-ascii?Q?FT1fXDO4GkCfuYBoHwXHa8KAQF9Od0nulCxQwiZQs1pGF2d9WvhkvJfWgM6b?=
 =?us-ascii?Q?icQoqgk0r5UlAg8YiMS50dQTmXOLamMBEl9YQlcTKO6YpiXG6sCkhZCLhdMR?=
 =?us-ascii?Q?abxvitJIc/Tv9vDZ5vsSnhsTJNlkNY7P218HsbIqUlAT3euYNywXESLFaq32?=
 =?us-ascii?Q?n5cOGrGq5FPxx+11JPPSA/GbkTxAdfn+4pccMI+RTDbGRL5KHtGNMrTi6oVj?=
 =?us-ascii?Q?qVA3rLqqK/9RTLlVM9VQweu8rwJIaHQXMfyEQiDMjxxucwv+tm0oPeSNpvFU?=
 =?us-ascii?Q?8ioGk8neIHbgs1nBElx9idIiAN+WopgwImKlkSncKn0dpo56IMvH32E0EH4k?=
 =?us-ascii?Q?nAt3eWVvNQzqwp5BW4Flx54DPIoTgVialeJABEX8jA+OTRFEtnSrKWgGszS1?=
 =?us-ascii?Q?choOfu8EemSQLAb76ojHj5f24TzfZqLv1PrODv1Zr5qp4AIwys96IyFsaOlA?=
 =?us-ascii?Q?QjoJi5tKZ02hlGEkJemA2nm2qV8f9XDtsRJGqJjuFb2xrz3kJlm85YtCsA7U?=
 =?us-ascii?Q?OnFJ2Q3VynvmcA3nwbCBUcejcy86Swb+TtOzExwqJFwpZRjPnaRFgNwbjv/B?=
 =?us-ascii?Q?OtBE9IGAuGjlfU72Ok4i2Y+nYIKiLPBAJZvrIXXEDTcjGigLs//wemfxFV+t?=
 =?us-ascii?Q?aOhek/EmOIcrq98pJoK9YYp30H2iB7t/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3Et1MNgPDnxIeCBRm74MaolPNJykW6WkZXA7LXZUUK7hAmAH1NvZn0Yc1Zs?=
 =?us-ascii?Q?tu9UtgBoB+e9hp5kmLNV24IFXLetMcnsiPGL8yOESkLzQuVRZ6vLJba6KEBk?=
 =?us-ascii?Q?KhSssyraAHPOgEA5zJiDW2kqdzeK5eeC8y0fZyxSY/5Yd/Zx1j9+36zLOsMw?=
 =?us-ascii?Q?8CewHwa5sPmpmawoRzXvym4rLno0mTbJhWSIv5i1bc4+H4az5sRoQAv621qg?=
 =?us-ascii?Q?5J9REysohm4OZDWdZjZGYln33K5hiL8AbOOWfz9h92DqrDYOZztRYEGrZ+iW?=
 =?us-ascii?Q?pkmXV5oYaCV3bOOnb0cWKLNQlSjdwmAm46JpQWO4bFyeHi6ToB+2TVm8mmhG?=
 =?us-ascii?Q?1vwI/A+/mZh9XPXc3ww6UjJ6WuNin4ZJ1E7ZIjgnwTYSd78vc2FbWdBEbH9C?=
 =?us-ascii?Q?LTjNei5z0VCZa3oeqME/ySY7KrgzA41HCUBluzKPbaIeOgxBoecN1XRgM3j9?=
 =?us-ascii?Q?Ivzg6nfiXVYfoBV8YPGocn2vqKOpdJx1nmGFpWC9uvGx1/OlfGlNDeHMRzss?=
 =?us-ascii?Q?7MJx0FRpkwkNPBmmfxb9zvfjeeQBudwWBFUh5xNhKqm2+nnrIYrZyDggSVxF?=
 =?us-ascii?Q?NQXuW/KCeVPfGzVFOhSd/lGt/8u5utdU+ac4Cu+bqX/Ip6u+Pka3dY3FqPZE?=
 =?us-ascii?Q?/NtF1CvLjBe/JgZTWIU4GaAUl/UH6JQNSLW82CrFFdzMrBsr7WVezbuP69ek?=
 =?us-ascii?Q?J2vqgNow/+/atEhdt1Oscsqx7Tz2nxbse/0mkTqU5opvKO6IogoNfsyzjRvj?=
 =?us-ascii?Q?McPWlZGDXd/g/9RecinkVVpPKob4zX29JAK/7YzcvZfRlPQD4909sFbqARLR?=
 =?us-ascii?Q?9ik6guNT39f4i0R1paJbPZpATnMxke9I7DCc85CNsFFr4eGAvuIkCOSQ0FZq?=
 =?us-ascii?Q?UCDJRyD/R/5etj8EQp6Z6EOqx8YWbYp0EmdP3GJ6Xukbx+X9Xfm5OmIovlTc?=
 =?us-ascii?Q?U26eDctfalBNctaU8n11cCp8Nl826ORJa0olQiE8kNBsPDUczZiLgJzGUWlY?=
 =?us-ascii?Q?3VYRKVlT++ELap1A690zPXlAYfNe7Bh6ejGaznRN5EjlYl7+KYgdT51Q9/uR?=
 =?us-ascii?Q?0CNnFGbSOGAyNX5/WdSAb1PLKd9gdiv0Ue/PWXOt4FAE0Y3R/rl1epSaa7X6?=
 =?us-ascii?Q?rgEDHB03JkrWtNN9vn4QSB/jFr+LkTZwpn7nVd5GyT187q7nv5VJYfgw1uEo?=
 =?us-ascii?Q?EYXG1qxFIZq59yL2E/UAUSOoDiAXw/wDeenv/FQGuklDvF7REzobWp1QKZ9D?=
 =?us-ascii?Q?F5g8aj+RsyzNjDFY4NbvHjI3xcq2viQoMLUxyi/EP4eLgB0bQjpc80DKANRR?=
 =?us-ascii?Q?UsVah0yJqG9GfrjMrlxBzRIeVBaKv+3xNKQcTjCUXxbb6cfPuOLPbwUrm4FL?=
 =?us-ascii?Q?JQ1s0w5qlvUsQS4Nwn0it6gEpoW7NDUNs5OW3uw3gaH1pMk8g52yKFqF1Gxe?=
 =?us-ascii?Q?rB8+ttofqir6LrZ45Wpt2FRv730M0pUFwmlXQTacEUgGHRbIgYU/JvLdKhsM?=
 =?us-ascii?Q?sDMNZBpwyNbO3c4pjkvmQ0oRIq9Mde/e5dkCVogm17uxlS6QzTiwqMAq5Xi4?=
 =?us-ascii?Q?37sTwcjv8cuCpBu1ogea5a3dxnsgqP6mIqzzLOFsH+9WxlLEw1R3B+4h0x85?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1659027-60f9-444a-10d3-08dd96747512
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 01:28:28.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d5vcjLm6fKWl0dFRwEaCYR2x9lAVg6VMEERtS6Z9lkOQdn4ZeUsKts6grGvo+YDwrMpLxkt6D2RwSn1MEOBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-Authority-Analysis: v=2.4 cv=F8pXdrhN c=1 sm=1 tr=0 ts=682a8941 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q_-QqQvvsW3-AdnsPqgA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 1qyMO4L3ixsNM6VHRMpjgWfRaAW-raQ7
X-Proofpoint-ORIG-GUID: 1qyMO4L3ixsNM6VHRMpjgWfRaAW-raQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAxMSBTYWx0ZWRfX4bsxtJjqbqQB AtZnfv4e44bCZ9dEtqpXoPiAuBMNWSzwLQDX6XfhAZUEcbxYkflE3EiTxwGe6iEq8yfqGaag8Tw Kpg7NMHh0QVe0lG1LeikfWIIXuh7tA9942wfepv/jBVU+0NhvJaWfr7UhqWfgMT7yw7HhrO+h+i
 e+PLnh9hrbqe3cKDB+y6UpXf5VN1kuSZl4z2t0tVlBG70WavNmrNaQuVo53pb/uhHcZQZRtu2h6 NmkDWCef161CV5lalxXr1zUAHgkq6DIdw+xyC/tV6BGEuEqBjjHV4VcNcj4ebErt+QszLB2qz/Z oMZRAOZdU7JnlW4f7FMKae2y4aHGOP9YjHsmXPjoJ0TEaAhmQIllnV9xz4xurWngqiMUb3HreqZ
 GTIzmUJhCaLb9FOj/gGsQsiW2SuWGdj04g5XoZNIH8NVA7hYgq8mpsh2GyaHf0QRpG8JnRiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_12,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190011

From: Nicholas Piggin <npiggin@gmail.com>

[ commit 21a741eb75f80397e5f7d3739e24d7d75e619011 upstream ]

kexec on pseries disables AIL (reloc_on_exc), required for scv
instruction support, before other CPUs have been shut down. This means
they can execute scv instructions after AIL is disabled, which causes an
interrupt at an unexpected entry location that crashes the kernel.

Change the kexec sequence to disable AIL after other CPUs have been
brought down.

As a refresher, the real-mode scv interrupt vector is 0x17000, and the
fixed-location head code probably couldn't easily deal with implementing
such high addresses so it was just decided not to support that interrupt
at all.

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Cc: stable@vger.kernel.org # v5.9+
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/3b4b2943-49ad-4619-b195-bc416f1d1409@linux.ibm.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://msgid.link/20240625134047.298759-1-npiggin@gmail.com
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[pSeries_machine_kexec hadn't been moved to kexec.c in v5.10, fix context accordingly]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 arch/powerpc/kexec/core_64.c           | 11 +++++++++++
 arch/powerpc/platforms/pseries/setup.c | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 8a449b2d8715..ffc57d5a39a6 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -26,6 +26,7 @@
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
@@ -313,6 +314,16 @@ void default_machine_kexec(struct kimage *image)
 	if (!kdump_in_progress())
 		kexec_prepare_cpus();
 
+#ifdef CONFIG_PPC_PSERIES
+	/*
+	 * This must be done after other CPUs have shut down, otherwise they
+	 * could execute the 'scv' instruction, which is not supported with
+	 * reloc disabled (see configure_exceptions()).
+	 */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE))
+		pseries_disable_reloc_on_exc();
+#endif
+
 	printk("kexec: Starting switchover sequence.\n");
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 8e4a2e8aee11..be4d35354daf 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -409,16 +409,6 @@ void pseries_disable_reloc_on_exc(void)
 }
 EXPORT_SYMBOL(pseries_disable_reloc_on_exc);
 
-#ifdef CONFIG_KEXEC_CORE
-static void pSeries_machine_kexec(struct kimage *image)
-{
-	if (firmware_has_feature(FW_FEATURE_SET_MODE))
-		pseries_disable_reloc_on_exc();
-
-	default_machine_kexec(image);
-}
-#endif
-
 #ifdef __LITTLE_ENDIAN__
 void pseries_big_endian_exceptions(void)
 {
@@ -1071,7 +1061,6 @@ define_machine(pseries) {
 	.machine_check_early	= pseries_machine_check_realmode,
 	.machine_check_exception = pSeries_machine_check_exception,
 #ifdef CONFIG_KEXEC_CORE
-	.machine_kexec          = pSeries_machine_kexec,
 	.kexec_cpu_down         = pseries_kexec_cpu_down,
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-- 
2.34.1


