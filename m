Return-Path: <stable+bounces-142997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7FAB0D2E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFAB503C92
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E9230BC9;
	Fri,  9 May 2025 08:32:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC1270579
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779574; cv=fail; b=NEajA3F8vhQhg7r7WDM43Q31Fzaoifw8qEhV+Rs1wj00N4MwA1zgWn2wVuuE1bdtDaWhCiEcBaSU5ZTkmzdqPdfQ5/fa1BVd4qcf580kh0ylRsDsWeJ07X7W+43X4kDHtfdLvnRwb43+YF+c8X281RcUC0YHo3H4TUrRGcrAvLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779574; c=relaxed/simple;
	bh=CDmrlGrJG7E6UEMlwaoAtB0I2Q/565RHW+4rGiwmYuo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NDnreBGZf/Xy15YbDpUFVvlv0zLJyT59fEmZEIvqmOw0nTkN49vFwIpkNVIIylvI5se8NpCN6QEdi17OmzQCxEOQRBgswgjzIrf0yUz9DiJUqWklXwJaJJ0BhIhL5+jbJADq/YsH2G3sR4Mlmy9jC04tG8mGl36P15/LTihFkEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5498UaQf012563;
	Fri, 9 May 2025 01:32:38 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3exqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 01:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsSa5SiDqPDiwG6odZ6y+sMbqz7XaPJva9WDpsY3tJtlc5pPFrIHeGAi04Mvm1FYvSNAwabRegKyId6SlkcJctj5lI06CF8lOD6bokCxyN6JzrfZ1qXjAVRx28DASy80II0JgrKZRFQfPixoeL0k046NCPggbTi8ZeZSJ5Hn75ClpmEgTZRMDjFWZf/E1JX8jgYfDAX3kbMW/IEQFegSZ0XUP6VlSlNSlTS19xEJ519rm89uvo9oWMwL3TqumtQeUvPtL1xSGv7Wm6izhvz0xzumvBIyoYoc8Fj4N0WWGgHx1jwOJbDYVrO03eO5tJNqstutSfwxAej+opUeH6MzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFBDjTR/CpPY2ROXjb637UCLa3FyClan12FKihjw1C4=;
 b=twvfwmmurrH6daDfZf3Y9m4fnof6oQFA01GwiruJ2oF3iqZQyr9ZYvy91ZUc8CmUiB6ozvar5Hfr3eBYNUXIeZ7G3QcWjhGOUInBE0iqYPFmieC75MkLih3pm7ApvkZOOR189IXQHhXk/KWsor+r1ACcYRFrCAA+VI1ClO7zVCycdkgts+I4m47gGyjya3LpXF7sOa8Pdj5D4ff4bGpHWe4O0yScWSd7IhrDyXa/bZQSLjUpWOW1llYLiyI91ypxUz6KSewTNpRMuZAEkIj4pV+ZUinaGmTusrV/HxaFoHK/aqGJO5PMi1ZAl0BNmLSSNuKhzzhmwczboNZrpQgBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 08:32:34 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 08:32:33 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, kch@nvidia.com, bin.lan.cn@windriver.com
Subject: [PATCH 6.1.y] nvme: apple: fix device reference counting
Date: Fri,  9 May 2025 16:32:16 +0800
Message-Id: <20250509083216.1281489-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:404:a::34) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CH0PR11MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: eece6dbb-d08f-43d7-59fa-08dd8ed40b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPA5bqXjA1dY1EdGA6Y4B3BYvCKXEZhLhd5C5z2zwpc9QnouUTfNGz+KR3QD?=
 =?us-ascii?Q?Hkt6CeGFb3XL4HEkZ7QdeMFCxtWDV2NIF2Y1deLbJx9ikqmO7NfyLCq2z4nj?=
 =?us-ascii?Q?0alEWh7EYNa24oxKiN0NYBMl5ITK5H+IFlA6EUWBE1+OwxvIP1+yaT47qmNd?=
 =?us-ascii?Q?pwlWKgiRzxY1P/O4mZnjj6exXmrTXK6w7Iq0gSztOS4eOioO1tZGZpEjfdQ3?=
 =?us-ascii?Q?KfOwks2HTEFRt8H8OH8Kx3cGNxfwZSjadtrdNkjRXTG/NROUiQE536kcXBff?=
 =?us-ascii?Q?sRuaimdH7UkvfX8WGNSmxfL30Z3qhprfZJnoyqN6NlaCmkjf0xIqoLrhQTXY?=
 =?us-ascii?Q?HAqWZ8A7dtb736bc4Wc6u0t7grHNnlL+UX8gqqy4wQF9FhWAtIFeempWLDG+?=
 =?us-ascii?Q?oS3cBY5Cg/xJH0WTSvfMlsdPJ09/KoABVErK6dqDj172dHxZkKEHqVs+ksk6?=
 =?us-ascii?Q?RwRBy5Fyn9wnR9RXwSAszZuoeAqypLp1N1zsJm2ob+Dx6WHhX0rS/3JyBzO4?=
 =?us-ascii?Q?WPmuDvV2NUh5+OdlyGpe7G74d9cXUjw2O8/qASOe0Nipyu+Lt64jASmkOQRU?=
 =?us-ascii?Q?7oRikaVULLrvMV5ddRqYhSX06Odu1z1PD39XgfGqqLt5q8L5SGl5ddIhcchT?=
 =?us-ascii?Q?6uzj1wuKJrj2f3QzesEJV8xN2BdTWRdwF91jljBZWYaSscZsdJw6wJtpqZnM?=
 =?us-ascii?Q?Vz1tlLG6BQowv5Ki3fIXGvOa42LFCSqChhnmO37F3tOC+CA+iV/bdP7KIqxH?=
 =?us-ascii?Q?BhxIUr6trPr0uacvVaydSwRUBGlZomOSW0ilKjhDHEwZ+H9hZxWusYUO0htk?=
 =?us-ascii?Q?75gWR6OMq039jNL+tgs+MTbaeVt3YZ6Xy/othXIskpB80vyxyxPNhIYIH+Io?=
 =?us-ascii?Q?f7EOeiQM/G7yzcahfq9jZXE5afnuQ4ecgDD7JLHzmcxBIoHmgnfkR3+L6UoY?=
 =?us-ascii?Q?uou9ULVhks9vtF/u5AAfvIYjw9+DezmHWZ2zWYOT8RGPQui4CI9IjeTlwBNa?=
 =?us-ascii?Q?RNSxQmD3OIdFTFM9hV4vfXl016DMzUioL2h6K6D79Lgj9VRh6Np1wAVRHeZT?=
 =?us-ascii?Q?YFjffp/Tuuxd8waRufgB1pwiqoupVEGtojtyL2Stu02iudSWARrVnE5z3Vsf?=
 =?us-ascii?Q?MA0BZFKH6uA6WtiZkWtmFFnlPCU7T4wdPTwxk2t95aZRRiui7klEiQXxuBFx?=
 =?us-ascii?Q?B/nmeVcaGGp2KpxKBQ1UdKVlVXkCofVrkbfxxT2dEp1khBiqq9fyl0Xfg800?=
 =?us-ascii?Q?4/7iH2caqnUOIA6J+7n1x16nMtexiaiueGVV4brRdSA47VNOLTibVdLYNfS5?=
 =?us-ascii?Q?YGHy30UHtSkQKcgYN079wv6oOLBtTlc2Bvmrpeyux/E/+F9SbarSCUMIwIEz?=
 =?us-ascii?Q?br2ZTPOsT9B5Gi8+m/xT2RXz7uAbz+N32zvJ90+bTPuQKKlGCsn99sehnTBA?=
 =?us-ascii?Q?OjThj32QHmA7PuJu2/iM6XPnL/Ef+5Sq8xBvmnER07uPSdFTCJKbCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUlqCfDdqvy83cgMoqLZtEhE5PdN6+VnxGQtmm0shXdWXix8nBRG46M0GcOv?=
 =?us-ascii?Q?+3KI+4BisnUcFWx8GDD4T9mrRj0Cb0xpdHDrkxLhdkKBKBNpexITeEIs+zng?=
 =?us-ascii?Q?coP7piABiXQLM6aT5YztkxXJz6dplYFt7mcC7cTetglsaotbcpelli03nAUb?=
 =?us-ascii?Q?pkUEemPOywDguHI4mNGCaTJ1d0Vz1raz42cYR9uHeLidO4lmFYAWy/ZcEawu?=
 =?us-ascii?Q?ZWRHoTRYoJoelzh8Fh0/niHBIyZOsuepO88hu4zTtnjofSBulnn//UZM66bX?=
 =?us-ascii?Q?DcGcelBuKlNOfLSf/AhlrdmSHPX0zU/FRGWF6h2z5/QIcC/AInq2VKEIH/qT?=
 =?us-ascii?Q?iIfZYaHk5W+0ozzFZ3G7OlrMgcecBBzCUxyMUv/oEAQ6ZUUOYmdsxTXw6rA/?=
 =?us-ascii?Q?bMEgBW+9pRUKbedGzUBGw4KC0R8uyOIybrd8u6Y5TP5fWnRTdgl3+ZXt8SIy?=
 =?us-ascii?Q?o6O5LijHXn8AaDEscxihmsAyowPQqULtzLO6PqFlIqJgiVFnX8vRJiT37a76?=
 =?us-ascii?Q?xu5nxdEAnTV++bAImTSKIAAGr6pIaBwSb3zNOJiPvt9NEb6rFQZggu+jisK0?=
 =?us-ascii?Q?rnCq8xDeyP0W2KTPmSItbs+2JN1gDr1IvhJ+L9oXEeeCr0xh+u188IiAECnz?=
 =?us-ascii?Q?1Mm5ikulzFb83+CKNIcvXNkxUd4sgqARLJXX8d/vUVCNAFNtf6RPsbW8xDbK?=
 =?us-ascii?Q?AIhN9HfFUJOkyGloW7mgK5WkxjC65R4uTbMRdVmfOec03QVce80nTPs/hpHQ?=
 =?us-ascii?Q?b+UtvsLGGTBtwHzud0CMXUqRxNeXtM5AIJx1/n5nKCQ8HXpfqir0gcjstRLs?=
 =?us-ascii?Q?EnTRh0qGUWVBoiU80c+pbQVXGBHSXdYC3VdYyzMtkKHJXl4I1KUYp8Lvpy1k?=
 =?us-ascii?Q?aKvHQD2XH/mVtMdiR1IuZr7ubd30lCNArDsBzvsz5muFt3BtnlW+5NgtAHqy?=
 =?us-ascii?Q?wsLctXLyjO+dMwFhxjmeliU051DzxNWHDQtMPEGkBTPPC/96TkFI0kqs5EIc?=
 =?us-ascii?Q?obY1oExRBdTTenQyOMsDoOZPCrkDzobe2kA+/IU8Uy4FAa6UxOR4n1ZXo74s?=
 =?us-ascii?Q?oWD20ca1NiHHUCncBKcHpY3XDYOH26dsUDMrG8EHXuIaQ7zzW8otAJSdzxLE?=
 =?us-ascii?Q?nyIuJss9FQQZ/rc/jO4p2k9HWbnfZlgnIwPnmwSKUKeYSc3v8zGZiBmXB9YQ?=
 =?us-ascii?Q?Yl+Yjl2C3OL/ikedyIbJAcDvRU/V5hs4A+ihJNVahgH1jqFGwE35ljV0a1O5?=
 =?us-ascii?Q?zM7EJeNM/0+y8Oe+SJnSf8TZVeFpcfOQOU3T5pugy99gxB8ahaxgkbPz4bDK?=
 =?us-ascii?Q?IPgou5OVSi6tLx0AxkkZPHiETh02kKFFV3GPB4HF/mAlAzz3CEPZT8ewNW/i?=
 =?us-ascii?Q?lnbZ1os3GnFdtb/hFyrlytDZfe2YhsDp9KmI+6jOadv5FV/DtCHM6GO6hNNV?=
 =?us-ascii?Q?bX9XacGGB/0fliCyBu8Dp5QYSWP5B3soSgFReKbJWZeCTTb1ez/2UnWUmzF6?=
 =?us-ascii?Q?3oXbfc5eLqQfTybEgtExWMufnYH8BYm9QXs8cI6XprAORdvJlbrA6ToCfUhS?=
 =?us-ascii?Q?NtrUddaGA7S9Kkus4TdryL2BYaV8bPHcuRIa486S7soo3JfKMl07X8+A8LKJ?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eece6dbb-d08f-43d7-59fa-08dd8ed40b98
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:32:33.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mz8Eqbdd50Dy9Itzf4yAfDCNkmPBS+JNLz7L0ByYGF98Yz5ls9YhO+Gqrr26pNK0AiGT3yZpXjwNwpnBjhe9vFu2gbqHVYZaHWcQk8kVe3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-Proofpoint-ORIG-GUID: _oSjjeCDCj5jVATTDENxTqgcZjbKXWCe
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681dbda6 cx=c_pps a=IYePPuTyj3qIg1BHBNk0GA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=t7CeM3EgAAAA:8 a=hL0XF4ZhNagHdJ7adRwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: _oSjjeCDCj5jVATTDENxTqgcZjbKXWCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA4MiBTYWx0ZWRfXzzQMyWn3Qmaa R/M1oFhVzqY2x+EuCOdfyMBu2tyhA70BD0WmDHbvOA9kxnShGofjAcpl8vYdWtkYJc0LUNRA1IP +GhGlRK9mh6CCg6TAHUx2mmW2naGRtqYYHdCdRQHq79WmzadyC/1aJkpTO23CP2jPYQ/0PUqwl4
 n6hUnSMcpcOW7+oumpc5M+6BsJORZjaF2aVpQ+CEHFCopxCH9w/amv9fz48xUnAu9Gjne04yvOa N1dUWgASlvGr5ezXJjtUBdOYsgYHB27o1KWq8U6QY23bwRd2O2JNqq3WJ0M0y2LJQdOEdpAFbaH tbGnui/L8KMe/nlMBzP3KS5tBbwAT54R8EHb8ILhjbFuwO1Pas9clJozmNrLSgajSbUVj824YhQ
 9GwMdKh3OfyAfxL2cUrT2uBetVQOlvUj37QXWi4aCazu/7djmf4WT4QIVy4L/3jbKNssP4WX
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090082

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b9ecbfa45516182cd062fecd286db7907ba84210 ]

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The apple driver had been doing this wrong, leaking the
controller device memory on a tagset failure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/nvme/host/apple.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 262d2b60ac6d..057917e23b6f 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1373,7 +1373,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
 	mempool_destroy(data);
 }
 
-static int apple_nvme_probe(struct platform_device *pdev)
+static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct apple_nvme *anv;
@@ -1381,7 +1381,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	anv = devm_kzalloc(dev, sizeof(*anv), GFP_KERNEL);
 	if (!anv)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	anv->dev = get_device(dev);
 	anv->adminq.is_adminq = true;
@@ -1501,10 +1501,26 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
+	return anv;
+put_dev:
+	put_device(anv->dev);
+	return ERR_PTR(ret);
+}
+
+static int apple_nvme_probe(struct platform_device *pdev)
+{
+	struct apple_nvme *anv;
+	int ret;
+
+	anv = apple_nvme_alloc(pdev);
+	if (IS_ERR(anv))
+		return PTR_ERR(anv);
+
 	anv->ctrl.admin_q = blk_mq_init_queue(&anv->admin_tagset);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
-		goto put_dev;
+		anv->ctrl.admin_q = NULL;
+		goto out_uninit_ctrl;
 	}
 
 	if (!blk_get_queue(anv->ctrl.admin_q)) {
@@ -1512,7 +1528,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		blk_mq_destroy_queue(anv->ctrl.admin_q);
 		anv->ctrl.admin_q = NULL;
 		ret = -ENODEV;
-		goto put_dev;
+		goto out_uninit_ctrl;
 	}
 
 	nvme_reset_ctrl(&anv->ctrl);
@@ -1520,8 +1536,9 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	return 0;
 
-put_dev:
-	put_device(anv->dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&anv->ctrl);
+	nvme_put_ctrl(&anv->ctrl);
 	return ret;
 }
 
-- 
2.34.1


