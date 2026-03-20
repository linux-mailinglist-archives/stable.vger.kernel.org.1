Return-Path: <stable+bounces-227621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCa1JjqyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:46:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542C2E0FF7
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBA430B9F9A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDA366831;
	Fri, 20 Mar 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pQrwvHfV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5B364038;
	Fri, 20 Mar 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039552; cv=fail; b=fVt5gonH0anZ3bBXy0KM8shuCKKC4cHTtCAdltpnMekiikd5DI0jmR+uFoO+5B9R0Y7q0Bnm+Q7vrMLauVpjRLB1GOHq1Bcfjdrr0Q7GIA4um3WjTK2wFcjqGGffZWPyoZcmQ6DBW/uwbDjiCluVeX/zQQkl0J9/5zsAeuTsgmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039552; c=relaxed/simple;
	bh=3IEeiaQQnDgGcY/Um6oE6skMSmYdldUYh5bPLBp/0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snNlYhQyPhmrlt71mijrY4EVubM3KIDpukor5DFm4puia2zpkwJafLFQBhnxlOeXPvRDPwLpS+duo9iTx6x/hQknv/w0X/rO/4+r6AR8ZCdBavOwuWApf41QLWsPt7sFC5U8jmBTfCiyFNvjOudxt7dBOk/HLBvw9kTgyc6pwOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pQrwvHfV; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KFNrV71789288;
	Fri, 20 Mar 2026 13:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=NvgeKf27I+9OsA6o9lSFuMD117exw8zSKxHdYScYsd0=; b=
	pQrwvHfVYcaQ+tGaoLRR00O9m1+k7c88+g2gEdAM/ofBusaJdUZWXaQlOyAeDA6a
	cVGvY4zqnyYwsjwvYYRYCb5ha0RpEnNR3AONxz4qLYnJwYckV0GSAUDW90WxL8Mx
	Brb04Fp3qxJffDgLR64PivBPa1vPCZaWrjb7SV6wFHkyWpoGRxo2LSESBziglRZ2
	EmE+irKnXBo4qoUlAAcx0JSUD2MITiTIPlPCFKjCoRijUdx/k/DnZ5U4jgcKGQhx
	SQ5Og4z/Eku9Ic5dJjQJs4jYKECzTSpkRtn41aNOWNh+avnCpyhzIZKnyOhPeqNK
	UQ5vdiwymURmMaQwzeAoyw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggb7h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJRh43smP59aaKEVcDXjk6hyA/r1iKA/9KPYj3d3gWljlTMZ0H6KBRmwCflDXEadxTOt9x+wPCIGIMRXKGygAd9wScyscqJKSecYJe3g+SNMroBUSA4y8QUIq+gRW/QgohOtmP+dVdO+ZSs61ysnFx82AKakbt1FlPFM98NSy3f3DF16ahmJcFY0dxb4nOR0AKDRITdWXDHFRRc17SnHPFO3Tjs0JdYbk4BZmXTOMXrUyz8dgw2haw2Z9VykHXDHWMukA2OUaECQZIumXFuHuIf2YZoRKHUrWge+xjTdQ1FRwI+ajre7TR/VYepBm91K+dxqJwvWJwn6g4qEjtszTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvgeKf27I+9OsA6o9lSFuMD117exw8zSKxHdYScYsd0=;
 b=mccEQ6GUr8SRrrNTaebXl2NLBC88lffphtD9zmgh300gy9dpz0bPyqHWsROUXOrq1Xkm8ylaragEY8Hklrn2HNNJOJkHZHBuKy9uF7VN+H0piSEexIT0AC8GgCddGI4oMoD5Jltq2d8AoP6X0ZX1T1InGppqCagaGiP1QvtMR8l8n3kQHjBrvvGPWCKp6n1IfVjJUNPCOIFl5lAwTZWw1sS6ZSQAe56nFjeZvWGmJJ5Zdy+sRPqIv5UQXawlKincoq3p+NofFO2ir7kmYCHqArsDOZUUyVxfgkf6k0qgUu6q46eaeZpCRuY9cewSZ7MRu/4Ve4V2rDBvLgAHqU9CWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:45:11 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:45:09 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] timers/migration: Fix imbalanced NUMA trees
Date: Fri, 20 Mar 2026 22:44:42 +0200
Message-ID: <20260320204442.32901-8-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320204442.32901-1-ionut.nechita@windriver.com>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: d76dc035-9a4c-493b-15a0-08de86c19328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|52116014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZhlAqDsQYTcnJAHFhjxP910ngTH8KmaCZw6FPUodvhcU9YZvkxqniUTxfqtnjDJFSJED1zJUkCBW6H5IhWwoLMo+6coDsRDtlxXyyxDu4P6g+HQX8hH6kiTECYF/sonpvoC3TPylfbC0MdGZsv3LX8pMJnMFn6/KPJipqne4AUUwLiF/GnT6iROIqGGJutTU5gPFFouLDIDps4HXD03DZ4gCkomFHuI0Cpge9pKnJgRwxhFwI/L1R4SiEpeRkcZw3TkkpIeAd16dWVtYz2OPLIItUZ3HtE+TWgbx3NdUhmnrni5+IVeKTqPAT0wy2mgPELlu8f/EESFfYlxbiGWyHBlJlJPUzFUJ6dRjDrx9cSli/TJaESVNiBnQE+k1yb9cyfcvPt0+ZSs7q3bAvf870MEG2bxDP/xHzy/do5J0u7NZkBzLnrLsciZD4k+LEdIf/nVg23gxe0G8fYTYpL3gzc3fYyZLLoGCQVMAXqCkyQbIDGeLJB3CDMWWjQtjI9GjQDPMF1xfGhkx8iS1QA1tZLcnMnLD+4+DRCSxCr0uN+8FbONLnBKTFGHX+UrP3YbwqhOEhKdeXbznFJE/BxZl8KmSd1N8nrRvf8QFDMjhS5r7kynec2iXSXaT0jqEFU6C8h+5M92BbjKuziZpk0TYzQ/MPkCYhAd2UnJBl+/bWnI5rlTvZ3g2OCVJz0CFPm5u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(52116014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qft46/Bwn9Fn9JlHoNR2jlQeoHTvLbnvQP1ro/6XkiMCu1QM9lvQpuF0Y4c0?=
 =?us-ascii?Q?pbiH173aR4VgyT3t2IpXdr/Fgn4ElIVISSA29SF3k04ExAyPx8jHLUntFJKz?=
 =?us-ascii?Q?ho/F5SK78kTZf0rTZW52C0dOIgpJcxEjDI0spXUzem84vyTeHSE2oWWY0Upf?=
 =?us-ascii?Q?jb8eWPUOMMKYt01nlw+5DjVFfpFHAtHVH7fm25BNqDOYt1VO+Z5//3peUhy6?=
 =?us-ascii?Q?pdUwSoKbCt59CUOWQE/7MFqdSIFAzLfmbOQZhYkLDxiRGHi6hTtjlooKknnP?=
 =?us-ascii?Q?5rD7AaXcdoJp+vp2ibbOpaqeHxtnBXWBh0wb3nif2h61xQFq2I5TddjZaIiJ?=
 =?us-ascii?Q?thp9j6RIG2ksXbJzykczRU4xIiBhJBk8YMEfsZzpBW7u1+j6MLD6xoEnnZzW?=
 =?us-ascii?Q?LRZAgiZDcPhLSEMY5DJgL9jxodK5Xx0LSzRofw63/n1xOcNTx6K9VbzIyuwT?=
 =?us-ascii?Q?P1Xr6UvPQKcoGehPYhItrfNrHcLtud/poNY6NrRfxYbnV4h8HceYZAdmxiqa?=
 =?us-ascii?Q?SWtgSqPYA/tim3MJ+NIJi05EX6VnNvMFoJh1gLoy5W0KdlFEXEjK0bRQtAay?=
 =?us-ascii?Q?kM2d5WxhUm+URarCF0ymmaFb4sBZGtSVLpajVQDwZzM1aFKvMOaycvqKu+tQ?=
 =?us-ascii?Q?Kr9VbPmDnU7XpudGT35MANwmnGbBckSscSTfAXeLnymObIs//jrfRgvcczwj?=
 =?us-ascii?Q?9phKCGDg+uOjz+1dzSKREnvimrH7vS4FFUyb556aAt3C9EG1PsAJju5aBr1z?=
 =?us-ascii?Q?QNxkSHEoR72xwcL2KuFMPMMp81Iqj2940hi5uTyxndUfDhk7V22aymKzrjNK?=
 =?us-ascii?Q?ZAwCqQE2+muN5y9f6Pm+OpU1PaltPI2NQZ1ZosLWEM7b1DKZJg9N4H7dSDAn?=
 =?us-ascii?Q?P6BrEwaykI/BrjV5q1RUxqje8EGmykvsMKEyXc7KwsVyVDCBgwHgGvxsDG/M?=
 =?us-ascii?Q?1MTNB1eZJ8exrvcdPbp+156jfWloyXsbap0baG87k62wEqBn6JOCP2oy2ViZ?=
 =?us-ascii?Q?X+zTq15gd9GMCn831Pjp98ZFkzzCWjMr9saJH3dIQyPEkBZnmBtM9RR78q2C?=
 =?us-ascii?Q?GstHWLTxT9dXS4hixjQKvaAAfA3ijLJc6HH179/Hl/MA54vNsgD1nFdXmypG?=
 =?us-ascii?Q?6GCLYiU794IUy8gNPce6wwlc+jlbr7qMbWR1nyO5KmlXQIsGqBqNk7ULV5EN?=
 =?us-ascii?Q?4B66KVPN1gZKyna9P4349x0n+BzGhRsNwJZZN+JBhzvZrGVtdW5JJSgBu2ci?=
 =?us-ascii?Q?ABxZ66MkVjDuxt4MuBNbWpD4yCVtEumJD+yLPQO1HLjMA2FVy44wIVyGzvMj?=
 =?us-ascii?Q?uHex6P5eIeHotbicxpR7sJY+jWV2RVyw9gwf6BAh3uZ6BH9ymvXjtfQTn7F5?=
 =?us-ascii?Q?zc6USn+tjCxGRxi6MilAfjoWFNQIv/7CWYK8cxnyv5cUu5T8pBNdUbjUv/0N?=
 =?us-ascii?Q?OcL9HSzjm710xkHhF7MLU8UXsnJQJHesyGjgCAXNYURT+n9XKty5CaUt5T+l?=
 =?us-ascii?Q?ImKAcx9Qh1cjV+rv1g2N8m2YJ/UxdGR72Cv5zqGnWDNBCRsnvYNijEh+cGgn?=
 =?us-ascii?Q?HcyTCSU3guNc7AemRp8kCUb2IWTtnnrH8BOe5MfUqA7yYeF2PzK2X6Mnvv11?=
 =?us-ascii?Q?VsuJe5jJKoOvIHFNoNtbIBe/DQLoBKO7T1fPwEv9Jn6gH6katybT67qjYxkM?=
 =?us-ascii?Q?CRK2urgmysNwjBA6nehGOWQ7TvPuHpAgNrv2KwS0H2Qq/2vbXTMOVQMkX4XB?=
 =?us-ascii?Q?Y4R5QMQw0Wckob+rkfZQv5QxZORm7pF5KwROJwfZ0sBGgQC8bWYPG1OWhu6K?=
X-MS-Exchange-AntiSpam-MessageData-1: VLYVcEPl96nFS3vOV9xX6A0qoMLrnZNFYE8=
X-Exchange-RoutingPolicyChecked:
	gnBOOEk7QbqN2hd2X9mohCPd+xNB/NWazv4eYd24nf1tYD9an35UPDOi+6pEwPr4HtnHVLU6Owkwfze1AlZKOd8edZX9JLiS7pQ+mRTbKvDwuKkPnHGOB4CxtB4RM2R3ZajDEkK0DJHhtloUQ4vP4tFNkGk9a9haPrq/U+QgQHMZbGii3t0opYVu1NJRB4PSy9JELprFbYvMuoBwnhFgDm/gv3IE1UAzgPXO0l4mOb2wf77BVKYvsM3lM7oRU+ogNkS0Uy09LeqvXB6Z01PC0PSYWFnM0fHlpIZcZZKHR3ncVU+grfX6tgUxxcym/4k8+7gDceyMtY8pzOylwQpbUA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76dc035-9a4c-493b-15a0-08de86c19328
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:45:09.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FId9jIO5Uun6vQKvQxYnTkEVE7NNEYVuY/Jg6ZPRZWkA3V0CDM2d1L4OKD3IwZp54upjs+4keb+3gc+q/Q4bR5T/ITnjxjr93rR0XjtHyfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-Proofpoint-ORIG-GUID: A_-psWsjSzoIzbMbyVSnEbmuk6LW7vhl
X-Proofpoint-GUID: A_-psWsjSzoIzbMbyVSnEbmuk6LW7vhl
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69bdb1dc cx=c_pps
 a=MTA8SzjkfSP6DqtUeP+PaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=rPOk8Gav1BpNgUgkAfMA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX6WkVPGKVnUV+
 BYsAY76TVcTrcjpXJ3YLP7U/5f4kVDg+jQgMmS5AN/845GXv9/qR/N/MWGlipYcp82Bt9e2s/t9
 Bh7gMmg7mL1zUuJGydSJN1UkwXLzyVqzTMt2bIzRjzarffp7CFVrivygHhBiDCNYvNjB1Pp7Qfs
 RoJlfnXp7j3PTqw+GuR6NRv7Z6HUvm9uHnVi5Zncr9ttz7Ix7Gw5d8deFvMqP+3agDSuf7k95qn
 hLoUb62glK8WQmvlIC6AErg2zsvy8KWdyHi4uIce6mPeXjFCx+h3tGtl95sY1xFRiOg0Beyfdmf
 zs1KPaMcQq92o0Y1luAWYZvUn6hNglRfpL8s29Keld6IJ3amyXkTCai6JyONLcVUYgDurZQ4ku8
 9HquxbEgK/JhJnwQD4E4UkHbsxM9NPaWplrTtNqPVIc8JNa8pmqlchGvXVcuUquMfuB7JVznU3T
 EROb0D0KNabEaUOTzXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227621-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,windriver.com:dkim,windriver.com:mid,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0542C2E0FF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 5eb579dfd46b4949117ecb0f1ba2f12d3dc9a6f2 ]

When a CPU from a new node boots, the old root may happen to be
connected to the new root even if their node mismatch, as depicted in
the following scenario:

1) CPU 0 boots and creates the first group for node 0.

   [GRP0:0]
    node 0
      |
    CPU 0

2) CPU 1 from node 1 boots and creates a new top that corresponds to
   node 1, but it also connects the old root from node 0 to the new root
   from node 1 by mistake.

             [GRP1:0]
              node 1
            /        \
           /          \
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0                CPU 1

3) This eventually leads to an imbalanced tree where some node 0 CPUs
   migrate node 1 timers (and vice versa) way before reaching the
   crossnode groups, resulting in more frequent remote memory accesses
   than expected.

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 1               node 0
            /        \                |
           /          \             [...]
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0...              CPU 1...

A balanced tree should only contain groups having children that belong
to the same node:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:0]
              node 0               node 1
            /        \             /      \
           /          \           /        \
   [GRP0:0]          [...]      [...]    [GRP0:1]
    node 0                                node 1
      |                                     |
    CPU 0...                              CPU 1...

In order to fix this, the hierarchy must be unfolded up to the crossnode
level as soon as a node mismatch is detected. For example the stage 2
above should lead to this layout:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 0               node 1
              /                         \
             /                           \
        [GRP0:0]                        [GRP0:1]
        node 0                           node 1
          |                                |
       CPU 0                             CPU 1

This means that not only GRP1:0 must be created but also GRP1:1 and
GRP2:0 in order to prepare a balanced tree for next CPUs to boot.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-4-frederic@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_migration.c | 231 +++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 104 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5f8aef94ca0f7..49635a2b7ee28 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -420,6 +420,8 @@ static struct list_head *tmigr_level_list __read_mostly;
 static unsigned int tmigr_hierarchy_levels __read_mostly;
 static unsigned int tmigr_crossnode_level __read_mostly;
 
+static struct tmigr_group *tmigr_root;
+
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 #define TMIGR_NONE	0xFF
@@ -522,11 +524,9 @@ struct tmigr_walk {
 
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
 
-static void __walk_groups(up_f up, struct tmigr_walk *data,
-			  struct tmigr_cpu *tmc)
+static void __walk_groups_from(up_f up, struct tmigr_walk *data,
+			       struct tmigr_group *child, struct tmigr_group *group)
 {
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
 	do {
 		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
 
@@ -544,6 +544,12 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 	} while (group);
 }
 
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	__walk_groups_from(up, data, NULL, tmc->tmgroup);
+}
+
 static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
 {
 	lockdep_assert_held(&tmc->lock);
@@ -1498,21 +1504,6 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
-	/*
-	 * If this is a new top-level, prepare its groupmask in advance.
-	 * This avoids accidents where yet another new top-level is
-	 * created in the future and made visible before the current groupmask.
-	 */
-	if (list_empty(&tmigr_level_list[lvl])) {
-		group->groupmask = BIT(0);
-		/*
-		 * The previous top level has prepared its groupmask already,
-		 * simply account it as the first child.
-		 */
-		if (lvl > 0)
-			group->num_children = 1;
-	}
-
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1567,22 +1558,51 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 	return group;
 }
 
+static bool tmigr_init_root(struct tmigr_group *group, bool activate)
+{
+	if (!group->parent && group != tmigr_root) {
+		/*
+		 * This is the new top-level, prepare its groupmask in advance
+		 * to avoid accidents where yet another new top-level is
+		 * created in the future and made visible before this groupmask.
+		 */
+		group->groupmask = BIT(0);
+		WARN_ON_ONCE(activate);
+
+		return true;
+	}
+
+	return false;
+
+}
+
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent,
 				       bool activate)
 {
-	struct tmigr_walk data;
+	if (tmigr_init_root(parent, activate)) {
+		/*
+		 * The previous top level had prepared its groupmask already,
+		 * simply account it in advance as the first child. If some groups
+		 * have been created between the old and new root due to node
+		 * mismatch, the new root's child will be intialized accordingly.
+		 */
+		parent->num_children = 1;
+	}
 
-	if (activate) {
+	/* Connecting old root to new root ? */
+	if (!parent->parent && activate) {
 		/*
-		 * @child is the old top and @parent the new one. In this
-		 * case groupmask is pre-initialized and @child already
-		 * accounted, along with its new sibling corresponding to the
-		 * CPU going up.
+		 * @child is the old top, or in case of node mismatch, some
+		 * intermediate group between the old top and the new one in
+		 * @parent. In this case the @child must be pre-accounted above
+		 * as the first child. Its new inactive sibling corresponding
+		 * to the CPU going up has been accounted as the second child.
 		 */
-		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+		WARN_ON_ONCE(parent->num_children != 2);
+		child->groupmask = BIT(0);
 	} else {
-		/* Adding @child for the CPU going up to @parent. */
+		/* Common case adding @child for the CPU going up to @parent. */
 		child->groupmask = BIT(parent->num_children++);
 	}
 
@@ -1594,56 +1614,28 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	smp_store_release(&child->parent, parent);
 
 	trace_tmigr_connect_child_parent(child);
-
-	if (!activate)
-		return;
-
-	/*
-	 * To prevent inconsistent states, active children need to be active in
-	 * the new parent as well. Inactive children are already marked inactive
-	 * in the parent group:
-	 *
-	 * * When new groups were created by tmigr_setup_groups() starting from
-	 *   the lowest level (and not higher then one level below the current
-	 *   top level), then they are not active. They will be set active when
-	 *   the new online CPU comes active.
-	 *
-	 * * But if a new group above the current top level is required, it is
-	 *   mandatory to propagate the active state of the already existing
-	 *   child to the new parent. So tmigr_connect_child_parent() is
-	 *   executed with the formerly top level group (child) and the newly
-	 *   created group (parent).
-	 *
-	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
-	 *   already connected and !idle CPU. Even if all other CPUs go idle,
-	 *   the CPU executing the setup will be responsible up to current top
-	 *   level group. And the next time it goes inactive, it will release
-	 *   the new childmask and parent to subsequent walkers through this
-	 *   @child. Therefore propagate active state unconditionally.
-	 */
-	data.childmask = child->groupmask;
-
-	/*
-	 * There is only one new level per time (which is protected by
-	 * tmigr_mutex). When connecting the child and the parent and set the
-	 * child active when the parent is inactive, the parent needs to be the
-	 * uppermost level. Otherwise there went something wrong!
-	 */
-	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
 
-static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
+			      struct tmigr_group *start, bool activate)
 {
 	struct tmigr_group *group, *child, **stack;
-	int i, top = 0, err = 0;
-	struct list_head *lvllist;
+	int i, top = 0, err = 0, start_lvl = 0;
+	bool root_mismatch = false;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	for (i = 0; i < tmigr_hierarchy_levels; i++) {
+	if (start) {
+		stack[start->level] = start;
+		start_lvl = start->level + 1;
+	}
+
+	if (tmigr_root)
+		root_mismatch = tmigr_root->numa_node != node;
+
+	for (i = start_lvl; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
@@ -1656,23 +1648,25 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
-		 * available, not all calculated hierarchy levels are required.
+		 * available, not all calculated hierarchy levels are required,
+		 * unless a node mismatch is detected.
 		 *
 		 * The loop is aborted as soon as the highest level, which might
 		 * be different from tmigr_hierarchy_levels, contains only a
-		 * single group.
+		 * single group, unless the nodes mismatch below tmigr_crossnode_level
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i]))
+		if (group->parent)
+			break;
+		if ((!root_mismatch || i >= tmigr_crossnode_level) &&
+		    list_is_singular(&tmigr_level_list[i]))
 			break;
 	}
 
 	/* Assert single root without parent */
 	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
 		return -EINVAL;
-	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
-		return -EINVAL;
 
-	for (; i >= 0; i--) {
+	for (; i >= start_lvl; i--) {
 		group = stack[i];
 
 		if (err < 0) {
@@ -1692,48 +1686,63 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
+			tmigr_init_root(group, activate);
+
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
 			continue;
 		} else {
 			child = stack[i - 1];
-			/* Will be activated at online time */
-			tmigr_connect_child_parent(child, group, false);
+			tmigr_connect_child_parent(child, group, activate);
 		}
+	}
 
-		/* check if uppermost level was newly created */
-		if (top != i)
-			continue;
-
-		WARN_ON_ONCE(top == 0);
+	if (err < 0)
+		goto out;
 
-		lvllist = &tmigr_level_list[top];
+	if (activate) {
+		struct tmigr_walk data;
 
 		/*
-		 * Newly created root level should have accounted the upcoming
-		 * CPU's child group and pre-accounted the old root.
+		 * To prevent inconsistent states, active children need to be active in
+		 * the new parent as well. Inactive children are already marked inactive
+		 * in the parent group:
+		 *
+		 * * When new groups were created by tmigr_setup_groups() starting from
+		 *   the lowest level, then they are not active. They will be set active
+		 *   when the new online CPU comes active.
+		 *
+		 * * But if new groups above the current top level are required, it is
+		 *   mandatory to propagate the active state of the already existing
+		 *   child to the new parents. So tmigr_active_up() activates the
+		 *   new parents while walking up from the old root to the new.
+		 *
+		 * * It is ensured that @start is active, as this setup path is
+		 *   executed in hotplug prepare callback. This is executed by an
+		 *   already connected and !idle CPU. Even if all other CPUs go idle,
+		 *   the CPU executing the setup will be responsible up to current top
+		 *   level group. And the next time it goes inactive, it will release
+		 *   the new childmask and parent to subsequent walkers through this
+		 *   @child. Therefore propagate active state unconditionally.
 		 */
-		if (group->num_children == 2 && list_is_singular(lvllist)) {
-			/*
-			 * The target CPU must never do the prepare work, except
-			 * on early boot when the boot CPU is the target. Otherwise
-			 * it may spuriously activate the old top level group inside
-			 * the new one (nevertheless whether old top level group is
-			 * active or not) and/or release an uninitialized childmask.
-			 */
-			WARN_ON_ONCE(cpu == raw_smp_processor_id());
-
-			lvllist = &tmigr_level_list[top - 1];
-			list_for_each_entry(child, lvllist, list) {
-				if (child->parent)
-					continue;
+		WARN_ON_ONCE(!start->parent);
+		data.childmask = start->groupmask;
+		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
+	}
 
-				tmigr_connect_child_parent(child, group, true);
-			}
+	/* Root update */
+	if (list_is_singular(&tmigr_level_list[top])) {
+		group = list_first_entry(&tmigr_level_list[top],
+					 typeof(*group), list);
+		WARN_ON_ONCE(group->parent);
+		if (tmigr_root) {
+			/* Old root should be the same or below */
+			WARN_ON_ONCE(tmigr_root->level > top);
 		}
+		tmigr_root = group;
 	}
-
+out:
 	kfree(stack);
 
 	return err;
@@ -1741,12 +1750,26 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 static int tmigr_add_cpu(unsigned int cpu)
 {
+	struct tmigr_group *old_root = tmigr_root;
 	int node = cpu_to_node(cpu);
 	int ret;
 
-	mutex_lock(&tmigr_mutex);
-	ret = tmigr_setup_groups(cpu, node);
-	mutex_unlock(&tmigr_mutex);
+	guard(mutex)(&tmigr_mutex);
+
+	ret = tmigr_setup_groups(cpu, node, NULL, false);
+
+	/* Root has changed? Connect the old one to the new */
+	if (ret >= 0 && old_root && old_root != tmigr_root) {
+		/*
+		 * The target CPU must never do the prepare work, except
+		 * on early boot when the boot CPU is the target. Otherwise
+		 * it may spuriously activate the old top level group inside
+		 * the new one (nevertheless whether old top level group is
+		 * active or not) and/or release an uninitialized childmask.
+		 */
+		WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
+	}
 
 	return ret;
 }
-- 
2.53.0


