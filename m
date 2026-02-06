Return-Path: <stable+bounces-214690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJO7LgMghmm/JwQAu9opvQ
	(envelope-from <stable+bounces-214690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFF100BD1
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A796B3007F7D
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6A367F56;
	Fri,  6 Feb 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ng5Ic7+q"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E083644DE
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397695; cv=fail; b=iKLrmvr4rZaA/lj+CMff7qUvvi8+RWcuf8nU2j34PaMeWfT4Y2nb+rC9L8GbwD1481nljahqiN7SIQLqCIog+1/+675OLrAKAi5roITgGyBLdsgqJKCZxabVZ46JSxNhoFM8S+D3VsqcX1rgpq3zNeH0NJfLs65EqpRJ01ApJxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397695; c=relaxed/simple;
	bh=Eb4rRJ8fwVuVxi75Z2D5YNpqzDDL7mrRX9kUvH2MUvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG0EahDTMyEKhoWZ4ODxGZsufFdEd8G2Vl1KRoP+bK/+sXENxZx8e/qJWCWUOnbLflRLkgsv5zMhNnjRCWKC73ihmyeLUu6wn9MX5lGpfW3zIYUuopytZxoML8ITojp0g3Mo/s1Z+FtgGJSImSSINZL3yS+nhhSozIsLooa/MCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ng5Ic7+q; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFdOhE8KIphEwT72MEiHHVZ91vUHdIO9wEH9aS87BS41nKjhjtnX0VADG+u5w0oSCfH/qWbJXxb/jG76BesBjSi5Si7NybpPwcGrYaCkjnqOVVn4DF1Z8EdqwSzBKuYj+6Do7O6TfO/1FCkGYbz7L+qeDhhW568QsV0a2qk0Vw05YbR3RKUTlMZ/+7AYaA1sHH/v8gOEj+FsbjvvKFNuKZUFAyMA7zqRTmp52P7IbBkrmmo7HoHb0Pg/I2ll3pxdyrzcEvIFxZhR+PAITLs70h/0iJ0GXU1c9+wh/JmtPKzQYSd5ccHX1oEWQA0IJKhgkRaDpvLH49iXMXTbb6tSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A26YsBAUd3K8VDlGdgc3/ihn88u4I7EKvsWmYMwQxq0=;
 b=EzDf646cGK9Tn76joIc7lyHeh52af7r6VrW9PNQw40UPaBGIScKu9AKesp55/bN3nR6h1Sirryz0pRzArMC/+6Tyiyul1e9JHL5mXpEky48Woahjxie3fnduLvh7v6bj6avsJXiltfUkxafr0JneME+TIFj907Z3ctSPRpGVxXnnlugv/rdB4woKusogzKru0DORQiKjCwGcp0qgo38hU5HBFOQRUXmWiJ1h+CnbSiDb9qfVt406fhPXNui84pOefOdpSrBEriFzxUqZWW7OmFh0hEihHakooutxpjJ+uGMVpsmv99UpOUakmcMfUIhUiqDGAOnAHhT71ofUDXtoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A26YsBAUd3K8VDlGdgc3/ihn88u4I7EKvsWmYMwQxq0=;
 b=ng5Ic7+qKu2AHmgVsKyY/voy+EO3Qnihqvoe++o2v7PzWBXlyaSSSSYdq5LQbYr2MFkzRBZWbVwmIm2fZStt5MmEuyFAM9wMMvL2oE+Yv4wB+jCOUR7UD1/rcIwoTZTQrqknBK9fFdCG1g7O3R+apWUhIHx6dFaWQJ3SKk6U+M/QgHu/1u1gxg4n6NQAfbj62fHhgwOa2ecUtmyQiOXpyWp3ogc1jSLJmHZl80K/eragunia7E6q+OIyXQKmWkg76cQMnFS2tQaWwdix+rT6oKDBr+L3yiqtOt8ltWiIYFtzvB2jvUSAx9WtN6UVu6ZUGZxksRmCXD+ffJN8N7pODw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 17:08:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 17:08:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: skip debug_check_no_{obj,locks}_freed with
 FPI_TRYLOCK
Date: Fri, 06 Feb 2026 12:08:04 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <7B9B9CF3-29A6-4271-8C3C-87FF3EB9FA4D@nvidia.com>
In-Reply-To: <20260206165802.17280-1-harry.yoo@oracle.com>
References: <20260206165802.17280-1-harry.yoo@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f16f91e-5958-45ea-ea4b-08de65a24dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCBR3jZilVlNge3Kusq3yA5c02a76ZSMt/GLiYc3f/S/klIOhnfKMy3YDQH3?=
 =?us-ascii?Q?N125u7WzZYZW6pSk7OUE4cDchYvZ716SHoOQNRL1F3QdO7ANt2CywcAfO+L+?=
 =?us-ascii?Q?7W3mUhcC/oRmFzh5oyilSuSsfb2wer/DAxPyFG8S152z8KIJFdIbjh8wH5gZ?=
 =?us-ascii?Q?4LHoy77zKXtO73qPpIySxxNwbuGfmYoXAhOx3s0TxuscZkGXuzfeax0PtN+v?=
 =?us-ascii?Q?LqYba2G/1qq2eFu2KIIgxMFtZCHnw2e7LFBqaSa+pf/CH0ttv+ISdYlOTm0g?=
 =?us-ascii?Q?dcUS/sg1ILPx/+9UaGaVmIauF4CTgDc7y/0eI+F0UA/2qpMtG8dPffXCHjbD?=
 =?us-ascii?Q?nyfWn69J8ggAXTGiiRPfFL5ILBKxcV1L1/YYSjK2SA8Go9+pai2bBx8Vpab4?=
 =?us-ascii?Q?RktY9uCWLwdjXd4QmUdcLrgienMPYSKtQVxp9Vf9+oIm6pHiYYgnTIwsSgGh?=
 =?us-ascii?Q?kTmM1kpScGcaEq+Vc6C0MdY65XGP3JhBqbp9Yez5DDzepD7a6OXMMEBx1CVV?=
 =?us-ascii?Q?TalUlzhEHHhNH8crBr44wx0XdlAQBrN4k0NeDM/XHx21p0tDYc9NF001bKE3?=
 =?us-ascii?Q?GuQktQrmBaIzvqtP9I1R4X+F2l3FZRE09VThPXCGsGrChHosDGmelLL2A5+X?=
 =?us-ascii?Q?+hLpedaawiQjmD6HJS95quX2h/SkloGAkdyNLdF+dNd2C1Z7/se0V1OFgfYQ?=
 =?us-ascii?Q?L8crUXTImaBI4cImrnotplG+43qc9jhHvKRszls9m/srwzaknirh5d4Ic4pd?=
 =?us-ascii?Q?XKIcIcKRsOJDZrfKVxX/fNwqeuj3hlrHnNuaA4q7Fnkhe7eMKYtZw1K00oLe?=
 =?us-ascii?Q?araGtSKWxY/hdmVHKbDVWdORHwTLquFfugLzhj8KHKIEYd2AojJM5GO75sLo?=
 =?us-ascii?Q?QoO5jYlhXdF1CdlRFhFIoxyHn8RRqEDutJytiLYl3JD+iDSg0kZYeigIvx6q?=
 =?us-ascii?Q?dhzuYnOTg1QP5V0C/XuunqrKvRn92q9IuAVpuepayt0x+dM6wY3QUOXCYCI2?=
 =?us-ascii?Q?e6XGhqpjr8XX4NRZXYxmMZd2GTGiUpDZu7zJjMOAoour2lZxMl8KqWWNAIpB?=
 =?us-ascii?Q?lDXfiSbnimos01N93lqRlgzTys9L/3WTuWPKj6JagZ1EjjtXF8izyKvX2mKR?=
 =?us-ascii?Q?aRBQbh9Ya0jaq3khyTg0QF/0zUUmytFCp6w4EkysRHmezGpZlDkq0bnyrl+2?=
 =?us-ascii?Q?mPQ89CvJfnYic77v0bQgQ3l53UfDKZyGjk7tI6Az6b2FwfgYiHkZHnkD3xaO?=
 =?us-ascii?Q?8BzNKG8HqTLoH4CQ052Xx73AaowilgGyDLidQvBriFGjmvhwvrCZAtOnozwA?=
 =?us-ascii?Q?jpfxgfXjqKjKZVI5K2WMKeA1vCEb3Rcbfd4YGT0hITSrU1UR26t07tPk5K6q?=
 =?us-ascii?Q?VT3yxxndwx+/LfmhHshbuk3uxo7JTY0PW6UaYQc0yxlHXffdGwTfye0D9lP5?=
 =?us-ascii?Q?WwAlrIAQQaymKY5497yh4QJnibZQ1TKQgAdlpSjfwkcz3YwaUqxYQchVDGUd?=
 =?us-ascii?Q?XfZGIkWI65D7oe19kprqQLy9zbAO/Hj3VzqfFOC4CLI3cSev+9gDfqfsQELT?=
 =?us-ascii?Q?sfJXTdGrMLT0ILZrtmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSJaIHy6HEtQ5hm0DDfmVtmk6XOWSJIucfzks0vuusr3p8+lB/NrX4/S65MI?=
 =?us-ascii?Q?hotfBWrSU7+r8wr87yEOh26Pi/Y2UmEuyWhCNXejgghNmpoUuPIMRQbMZ3t0?=
 =?us-ascii?Q?yhIs44XPrZa0d81I8s4Cie0IYmzZrlXYXanVaRAKF5ilRhxv9lYvuchQS5PO?=
 =?us-ascii?Q?iNrQRRzfnZ4o0Q6pTuQMspu492xmOH9vd19afRdxegh9H3N6yEYgrI/HbQ42?=
 =?us-ascii?Q?KeqKUcYn5hJfToo2PTqPjYRu+tdD9CJoRxiqDt4E6YTMBoelbmg/6zvjvazU?=
 =?us-ascii?Q?b89VCJa2t9AGdTyhVi1KenkRBD31MfK9j8Ac02bml1uBdiIbO04It9wiDcZe?=
 =?us-ascii?Q?iHQFq4fLBTocBswMlJ16ZQnO1ry5z2Iulh7XauPaLsIY7GrQ1fDBktY+aZMe?=
 =?us-ascii?Q?XN6Spt2cuhzzwS77DOb209W8dJdURKFPfb44RVttW8mjL4k9JwVtooGv2sCJ?=
 =?us-ascii?Q?k95xLKfPCpa7f4Y6HzJ1eedy/NduqQDDtPi0quZneabnsTzOVOA123piOIqw?=
 =?us-ascii?Q?5eRvCz3m6iDibdNCH+IaH05/lXx8Ef8Y4dyDDfU9jBtPUlmphIv4zTGV1CFO?=
 =?us-ascii?Q?TRugOotrZUnTVpcGvhkqrP8+m8DnkjM7fZ1siE/L/ivG44SKo0OG9M4e4tlc?=
 =?us-ascii?Q?85QyLMzz4vuMVKuejVy6UhNrsP1Wn0oQSiGD5dGGrrxlTSNuQmeF2wx1N6XT?=
 =?us-ascii?Q?Sqi9znRML+gmYhtcQL9wmymWGGsuWAKqOLaPWx8CMGwfVeciLpHS7NQf/nZT?=
 =?us-ascii?Q?YS1QDNUK3L5DV6IoKG6/qEXVUP4Usy3PeBGFWMWL/rLlZ5AjqvkBZc9EzST/?=
 =?us-ascii?Q?sKoiUdnnjHLBPcwKcqjV1CwOAGCRHrGUvf+xEdfFpTYrepZc1SeOe7HKIhrG?=
 =?us-ascii?Q?44O3yzAuCKLanopKPOrqyRViodVf8dq5h3rKaWgtFNnBPIKlonCBbB4+hW/u?=
 =?us-ascii?Q?u7qPRvkNcHyaxoH9A4/bnBGkqdXRbAFBDC+iU7jcmEU2/OzgO2jiX1d6Sl77?=
 =?us-ascii?Q?DBe29ubX1WkokZQbM4MUNsEoBe4f1RuUTHS125LEpaqX64mWuT9rEEa/VpBR?=
 =?us-ascii?Q?Gt8w3ZxQOBb8GvBxYKc5Sp6dskZjS3Eg7fORR1ZqoJp77v+kEirOi83AloAx?=
 =?us-ascii?Q?D2KQchpw4yw1zZBUJTMSoBj7JHN/7MX52zs2+JEnx3yecMZAzatn3o7Gq6RE?=
 =?us-ascii?Q?10YQR4deq2bD6urGhQDHosTR3QPpEddgwZ+2SbttzfbLAMX4khXURl3kvxyb?=
 =?us-ascii?Q?lfxmmdZ+DhfE5vronsctsvcWtXZbAmRQDPsn4I7U7HCk8CCn1T0UeyZkT9bo?=
 =?us-ascii?Q?ou40y3uXxmOIGj47j8RTtfgOejDtMg89cZfMYatiSXvJ7OJsK1C1DA9dCyLF?=
 =?us-ascii?Q?xhcvqFKQVhPOVXM1zxMMy5t/Vh8G0G63A0A8U1fOCYNsMFb2fimRIq94kcSF?=
 =?us-ascii?Q?BURT4zmbw99V3lDxI3g9TY1TvWXNACORBT2stYdkaO6pi6MbLs1DVo6gsHqr?=
 =?us-ascii?Q?dV65p5uefPsUnhhvlDHMacfzVRzfE1+sQoKqRgFqWgL5+kE9cCVYKvSC1/DG?=
 =?us-ascii?Q?wxIb+LVB1UhSgJ9SH4WvGSnAl1pRLz8XGkDWYDDbzR6yPSyDR+OyYKuBQE5p?=
 =?us-ascii?Q?KEkSgIFj3q3/9mbMA+HD5P3iR7NwoFDHwdd8gi8HcOf8oNVdU9mht/Am48/C?=
 =?us-ascii?Q?KnC1uIQyxz7vk1vGKxmyU9uRmSz10Boq4aH2aaW249VrAR9P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f16f91e-5958-45ea-ea4b-08de65a24dbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:08:09.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGjswUows/Tho/f5PWE12pKixvU0sG2ZIRQQULZ9Y59m8Lv2GLVMKA0fA0iAzh7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214690-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,oracle.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EEFF100BD1
X-Rspamd-Action: no action

On 6 Feb 2026, at 11:58, Harry Yoo wrote:

> When CONFIG_DEBUG_OBJECTS_FREE is enabled,
> debug_check_no_{obj,locks}_freed() functions are called.
>
> Since both of them spin on a lock, they are not safe to be called
> if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   WARNING: inconsistent lock state
>   6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
>   --------------------------------
>   inconsistent {INITIAL USE} -> {IN-NMI} usage.
>   kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
>   ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_n=
o_obj_freed+0xe0/0x300
>   {INITIAL USE} state was registered at:
>     lock_acquire+0xd9/0x2f0
>     _raw_spin_lock_irqsave+0x4c/0x80
>     __debug_object_init+0x9d/0x1f0
>     debug_object_init+0x34/0x50
>     __init_work+0x28/0x40
>     init_cgroup_housekeeping+0x151/0x210
>     init_cgroup_root+0x3d/0x140
>     cgroup_init_early+0x30/0x240
>     start_kernel+0x3e/0xcd0
>     x86_64_start_reservations+0x18/0x30
>     x86_64_start_kernel+0xf3/0x140
>     common_startup_64+0x13e/0x148
>   irq event stamp: 2998
>   hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/=
0x240
>   hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_wor=
k+0x11/0x110
>   softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu=
+0x132/0x1c0
>   softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu=
+0x132/0x1c0
>
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
>
>          CPU0
>          ----
>     lock(&obj_hash[i].lock);
>     <Interrupt>
>       lock(&obj_hash[i].lock);
>
>    *** DEADLOCK ***
>
> Fix this by adding an fpi_t parameter to free_pages_prepare() and
> skipping those checks if FPI_TRYLOCK is set. Since mm/compaction.c
> calls free_pages_prepare(), move the fpi_t definition to mm/internal.h.=

>
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/compaction.c |  2 +-
>  mm/internal.h   | 35 ++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c | 42 ++++++------------------------------------
>  3 files changed, 41 insertions(+), 38 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 1e8f8eca318c..9ffeb7c6d2b0 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1859,7 +1859,7 @@ static void compaction_free(struct folio *dst, un=
signed long data)
>  	struct page *page =3D &dst->page;
>
>  	if (folio_put_testzero(dst)) {
> -		free_pages_prepare(page, order);
> +		free_pages_prepare(page, order, FPI_NONE);

Is it OK to add something like free_pages_prepare_fpi_none() for this one=

to avoid the FPI flag move?



Best Regards,
Yan, Zi

