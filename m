Return-Path: <stable+bounces-230291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKSTKnarw2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:31:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FC322416
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC490314AF1F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BD2E11D2;
	Wed, 25 Mar 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gpQna/3a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C6318EF6
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430623; cv=fail; b=J4Xfmjch9X33779W/9taaS9if+MrEOhqkIOYb+Xeve7nrG1iWjL+GtnibOzlS3EA35eLUxdw7cAf00crofNrgTz6HW75IrXBZkmbJrQPDg8hDhN/LLZzAJunYMev8tVc7/yQy+PN0RBSUWkvfDpEMq1ArFGNNlbDJokmfHLQunQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430623; c=relaxed/simple;
	bh=M2RPuH6oYEwZ5LISiO1kujTIRHyzk3h7CJItQ8Ro3CM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fHKBe/m9qDUBmIjP6czb9jGSEqkehBNkbm5uM4KvWSOfs4h+i6E1swmwU/SqO9Ypj8nRUUd7AKmoPUHjuzMz19mQfTE+TQzaHzIRNTUCd8cJ0FYwh2rB1aLjFBvA0BgAs/F53r8q+gslVbzzElCcWQ1z1LTjnfMgrhhuWw8IpgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gpQna/3a; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P1tOGx064700
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 02:23:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=hNkDA3DbPN0YY7ZcEM5H8Q9PBPx01huh6gMQf6nbKb4=; b=gpQna/3akHGA
	zlPA+4JBOlN3LcRY+bsL4VwsfJW2sWrcr5h016KEORsgFQbs6VwpxEGX9IzLOJHy
	t7XULrMEAAfq/90yLL1A5ArUnuHR7qaBKUm97+/noyY1jvLtfb01qeEbHKW56+pz
	ws5n0nK7EvpO1cQSFUm8m976KYwCsnoyIWTH96lFY+dlO/yo2xSULaZqP96GeO/w
	tQNcXOyHHBIHRgoYjd04hMyaApaDRN3OXdL2TR9zaxRwHwLbMbV2INrr39FOdBep
	VK+/AQrFxMOqfBSnuFgUb5USuQSc8+v0aIldM6xpMFA8PLGjfe6eXWb/yDfG+Xc1
	PQYTyEabcw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1tucvdnt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 02:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wp94psOwQEIt1+yG4MCm507zrvQIFBdXBQx10MzrIuLdFWWz2CamK1wVtdy4/10fhtfZ1Ww0pjE4YGEGiuEWSHJ4F4iF7YhLXVKggn1GAA7CAvhd0FRs59cYDrm7/F21PskSggQO0DINQ3/P8NDPN+xirvAVCNtWSTy4syizScikQVCFHcyPQj+ZwkjM6HOvoAp076HfrxQcmmM75pwdcGm99zpogCzTeOJDqCeh2/3WTNMXdKIj9J60tJdfYx9jR4CHXMrJ9qWHQo6E+BfSf4MXWbt8TlgEfXHeH62EnxvUotfLjGtuWXII1CsdfRbId8a78SQAQkeqGK9l+1FgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNkDA3DbPN0YY7ZcEM5H8Q9PBPx01huh6gMQf6nbKb4=;
 b=i2Z+k/7jIMoiGoIK8BGQqL8yasnwGKA3ox4WbvVKbnbIPSQU6OxaETo/bBIeFlPeuqQUfAfCN+e3Vzl8mpnLiNLjICyZYRDLmDg5pkMR4tyXxJl5HE08EtiSUmQzoCTk37Cyi9pLw3tLwPZssjOYi2xo84R4Jtmvs/BTZoZilpD2fUJ8msAPZZyZuIYsSbl3XOZim/+tuJey4YSzDBzzlB0pRGH/7NInu7rglByRAvJi6AF1T+Bwb79+N65LipdiNUoN8BRhm6GzIfpftPgv3MFbEGUGTIkbEspqAue/5nc/sFqYi6YqeAdh+Bpy9DtMfLN9tkq5MXKRcf7Smq8vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:23:33 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:23:33 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:23:15 +0800
Message-Id: <20260325092315.956451-3-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325092315.956451-1-liyin.zhang.cn@windriver.com>
References: <20260325092315.956451-1-liyin.zhang.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 303410a0-d496-4488-d0d7-08de8a502f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NmRDNWIyyTDOTQ9kkJ5gxafxGGd3D8u1h7ga+fcwv69rpGjNt4Q/47OCdjcyCmteTT8SBmlMtMraGkUZrXJLT9/JYbU7xGKZzhfxiRskS6fsHnbN+RqFQojKILl+p6dfw3UY6ONoF4RNyl5uT8pQkQAyY7cYCaa89Hkk4r00c3KL89MF351P6jRuPdF7R8KZbv0FcsXaoD5kZv8mY0+mjgyqRSrJiF9XcG1hcjTwLHF6hnUaqj4hNh+ZsaTQcUTxvQwa7DF8zMCI0Qct1abY7lqRzAKO+I0LCNaIfkkX4nWQh3N992qxzVE1lutA5oHfqlqXIs7ErXKBpIutIssEwjJjhCerGpKEj9Foneu7RLa3tU1tA3V/6fjAXuf22F8Rrx+twex1nfpnx1+0lf/tKgBZpCKRBCYg4ArRIgNcS2dFeVrQ1wFuBUkTur63+YDzGAfKKNff9nwbhyOwfYW8VmNZTQ3BaabfbZQpWN7TZuIl6LAR9NVtNVrEAng7O27StLHpHyIuzwKvUd8A+AwMn6yhp464gA4sGIMT4TSp3ITYlv9HZ3I9C5BDsYBEuPg9uQmsQEtFCXqdVM0bS7OcrTFRFxPle7HtpGL7xMe3mS5+NBxdRoDRbx/Cj7fmnIVx6sDVQ6y6KHK+pjlJkrtr3JKUm9TB7WLTbfRP1YO4m47feWs3bV+q1XReG0sHLMPT/3A4s8gjdnWahlIz1EKfrFwe+ETVbUzo0mLYmWmKuLVDi8kn2ci279DbZdgwQRU1580vnTnYLR33u8Dm9XF9jzlIcbvZw6jgYz0f9d4/tsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1Lq+sC2ZC2HLCDHIlAeW1TcAn2OpRR6L6OpkF/j9AhzdeThrs3m2OHxpsZp?=
 =?us-ascii?Q?kQ5w05bbP0bv4WnuaYfxYiFKCxu4mreZoGaDGNgOXst7T69kQlP6XHV6o5pv?=
 =?us-ascii?Q?4cBB8C/ZDUHMyCbuo2nOVc3pGeXyNxKwxzK5Y7POztzvjz4CbU26kofrTIah?=
 =?us-ascii?Q?EAH9h7LK0LW0GSw933X3Q1q2R6BzRqNMTXOV6XcdFmOQWpR2RBLMLVONdih9?=
 =?us-ascii?Q?aqSHNyvTOEut+P/LuEaOMk9iELu3ASNCs6etHE5AvZ7W9UJB+L+XcjY/QCQN?=
 =?us-ascii?Q?G9KMqrOZXZYDzBTYUWePnmrg49qdYUoMdnZa1RTa4Q65fqZn80HnLMk9YO8W?=
 =?us-ascii?Q?FxCLiFo93JySYUTjqKwVNeV33ctX2+1EbrU5qqpHU0Gst86CMIWH46Bz/XwG?=
 =?us-ascii?Q?9zgqYdJ7HBR3Yfo2rsgYhS03MYAmK69IqNMTXIHlTjosoR/dDq/9s2M8jryH?=
 =?us-ascii?Q?qMpD71UNHhWBfQik20WcnKdcihSFOwkUZPGdGoGK1ExMLvDArgS2/QzDJ81Q?=
 =?us-ascii?Q?vcvpN8Hv2bWYJr8na6Wfbmy4UMw2mTW/IsoLffZzn1OA4vx3Hqhnzj5wyZAO?=
 =?us-ascii?Q?uiFOEX3sqFT3tcUR6sTyiwUVtvWkwFXCdWvElHR4Y/1I9vjpQ4bUfb+Yb0YK?=
 =?us-ascii?Q?yvwF7GTVRAZz2pZLha+crQy8RdcS1ykbzT8/GdV57eG606VjQrFcPCI8jplb?=
 =?us-ascii?Q?J5izALAHMZnQQ2DsIRuKrXRsuR30jBjrr4Ne6B+ho63uhs45G/1uWuitCuVf?=
 =?us-ascii?Q?TcmhIgORYghSvYZJ45ZFH+AP3Sg+GL6P2muWv6ol+MQK6Sa5oLA23043QoN1?=
 =?us-ascii?Q?1sOYONOB3Pwfp2evUjd+Vb7iMoNBEZChqjAaZFWBzDqHj+7PnGs5lNxJXXHK?=
 =?us-ascii?Q?hwt4NbhJY2gWMU8zUWxEQTq30kURY65AaVPsPIRD2OrJNmn8WA3IKh8Wlwq1?=
 =?us-ascii?Q?jD1tsv4UZi1ZigMlfiJ7XtKuJ5bAo58495jCw42ne+s5PPYF3OwUdhkkiWtj?=
 =?us-ascii?Q?3lfYcRcZu6xnP6NGSKBAW9SCxHEXzWRJOSUlB9HKPNS3jcTMrEJw0rSQtEjZ?=
 =?us-ascii?Q?Ke5kjL5B5vPUucXCJB29PuJyUsjcrh5R+0ACQ/aILFRjwpCFU5G5U7+JHmjj?=
 =?us-ascii?Q?j3A14ZjOqtvOZMYOrZwJBvhzY4Umjk/a8MexqX70pQeyxNqbD2+4gkCLJNna?=
 =?us-ascii?Q?ehQGC1PJ7EurEHOH3ZHHjyjmXt29ZreNJ2lI6uzRpnczVJJ78/7fmiReGAeF?=
 =?us-ascii?Q?c2N5WJTPySm7cwKE/XU18Ql3+pNlE3Kp0h2cPnCHoqfoAmeAIwXLl5ttbhIa?=
 =?us-ascii?Q?Yf/MEEgRkJI1rr8Gp3ikhQdMiAnDKRBT4eFogHBsnJVwrmAZmpcyc8ZBpqhw?=
 =?us-ascii?Q?a6+5fT5a1qenhsDcDpflt+iWPtUwZg7xWAYcoz7IHzk5dJrxQpeJpikZFtaw?=
 =?us-ascii?Q?DPJy8MWdSMcDMSEFkNxoyotv721uAcXlBp/pvXoWZAvP7OFuMc5x66ChBKJS?=
 =?us-ascii?Q?iddWphFRysIdfY88gChcDoWaeNmtytR2f76bsAOxw0CZjOkSTknTjx7PsFWK?=
 =?us-ascii?Q?OW3Ef6r6KGB2R9WVKzF7uJ7w9npReIjo0+o+oo2dYDmD5i5WUR82QYAA0Afe?=
 =?us-ascii?Q?fqD0Lh8zcEJMochmZGwc0fsSgQNeHl2+2xZ/l7SrVIYuVG2kksZLmZyQIfkj?=
 =?us-ascii?Q?O/pxISn2NsKiTl8iNOtmJhTPAMFizNQSHoe8BTYcXaEmhwr7CsnKeVwPvux4?=
 =?us-ascii?Q?mayCfiGs0ds6RcTrNiqaA6vuQFHXhAM=3D?=
X-Exchange-RoutingPolicyChecked:
	R8PGX3KrcNuN6AqpHa0sY/qPlGwip6HJvX/I0qulm+KCLWyiAsKEb9V/IqzS/2ifOBTj9Vj/Xn1RdeUhEaHLipagT4d4BlFkNtiVCl/mICogqTka9AJ/xdC2Utr4hDMc1CB2j1eXMD2IRc9GOiBmgUaxtKjuDAZV5x8UnYXyU/SdiKYUXjIqdUjU/OAOiy1MjIcUvMOtT13gaelc1cFUmQT4cVLux+HvEaUILtde0+paOPSXOUH5T9kVX94P119Lxxngn3hB+KnJwq50JAEPDCilJHq6DQEiuXnFX06Ty3/KvlLppN9hU/ZBGiNMuCiOIOslqBFrGFY3z5y+c5MWVg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303410a0-d496-4488-d0d7-08de8a502f9f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:23:33.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3feVlEhYxXauTLYiIsq/arPq9yDbbMMwKTZMaJil5lDkwQvchRkaJaR2l8f8NpICqTKW6cYJQubnvcK/iPIHhj3VwYd3//wo67tFi30H9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-GUID: E05EPiw9G4-upAF5dpVIjhB4rzGe-P-Q
X-Proofpoint-ORIG-GUID: E05EPiw9G4-upAF5dpVIjhB4rzGe-P-Q
X-Authority-Analysis: v=2.4 cv=deCNHHXe c=1 sm=1 tr=0 ts=69c3a998 cx=c_pps
 a=Q+OuU4uwq9JOSoz6MpkFfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8 a=t7CeM3EgAAAA:8 a=JIpqKkT3xelr4lRRA5MA:9
 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NiBTYWx0ZWRfX6n3pO/uUsH5i
 pu/8YrlWOp56P3Zv4lnLu7JDYA71wdMZidojd+XXN6+fxji7NaGx4Lxz0EGFIpsahS3ZRVuirIQ
 mjZ8QVnXrTtVbOHUocJPv4z5b27WaKq1dkkfFbXyG49jTWyEYOOytSZPibw/F/gq+L++No07Tfd
 EEp8lO+pka84Q43LPTp457q/cqROfv2ZQoFjpUyWQlJU4C+3ENRnxp9IXvsBqijqZ+jnbOgFSS2
 n1TNrJgq+Nmh73gS4cGROTWR5+mRM9aYBeSEwlwoM+9ASZKoX4cLNW5vWR5Xm0u9PMsnZoSjRBs
 AZZ+iLEFPwduZLM84j/CxYbnxwBl/byGj5nUdP0unmsypWvQH6HSPW1OPA4RWAx+V7BQ1qyg9Ki
 sAk0XJKiu0Dm7jYDLtCzrDrCLmD4EVOQ8x2phi+/3T8imauFxUrFAJt0fkwffQgqm8Ldna0x8/n
 wuCKgPd7RoWTHscV2Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250066
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
	TAGGED_FROM(0.00)[bounces-230291-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid,ti.com:email,nxp.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B9FC322416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pratyush Yadav <p.yadav@ti.com>

[ Upstream commit 17926cd770ec837ed27d9856cf07f2da8dda4131 ]

On Octal DTR capable flashes like Micron Xcella the writes cannot start
or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
appended or prepended to make sure the start address and end address are
even. 0xff is used because on NOR flashes a program operation can only
flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
happen via erases.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250708091646.292-2-ziniu.wang_1@nxp.com
[ Resolve conflict in drivers/mtd/spi-nor/core.c.
  In spi_nor_write(), the spi_nor_lock_device() and
  spi_nor_unlock_device() mechanism was not yet introduced in 6.1.y.
  Drop the spi_nor_unlock_device() call from the patch. ]
Signed-off-by: Liyin Zhang <liyin.zhang.cn@windriver.com>
---
 drivers/mtd/spi-nor/core.c | 69 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2939ffbaad2b..91622d9c9b03 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1790,6 +1790,68 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return ret;
 }
 
+/*
+ * On Octal DTR capable flashes, writes cannot start or end at an odd address
+ * in Octal DTR mode. Extra 0xff bytes need to be appended or prepended to
+ * make sure the start address and end address are even. 0xff is used because
+ * on NOR flashes a program operation can only flip bits from 1 to 0, not the
+ * other way round. 0 to 1 flip needs to happen via erases.
+ */
+static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
+				   const u8 *buf)
+{
+	u8 *tmp_buf;
+	size_t bytes_written;
+	loff_t start, end;
+	int ret;
+
+	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_write_data(nor, to, len, buf);
+
+	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	memset(tmp_buf, 0xff, nor->params->page_size);
+
+	start = round_down(to, 2);
+	end = round_up(to + len, 2);
+
+	memcpy(tmp_buf + (to - start), buf, len);
+
+	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are written than actually requested, but that number can't
+	 * be reported to the calling function or it will confuse its
+	 * calculations. Calculate how many of the _requested_ bytes were
+	 * written.
+	 */
+	bytes_written = ret;
+
+	if (to != start)
+		ret -= to - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually
+	 * written. For example, if for some reason the controller could only
+	 * complete a partial write then the adjustment for the extra bytes at
+	 * the end is not needed.
+	 */
+	if (start + bytes_written == end)
+		ret -= end - (to + len);
+
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -1834,7 +1896,12 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto write_err;
 
-		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
+		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
+						      buf + i);
+		else
+			ret = spi_nor_write_data(nor, addr, page_remain,
+						 buf + i);
 		if (ret < 0)
 			goto write_err;
 		written = ret;
-- 
2.34.1


