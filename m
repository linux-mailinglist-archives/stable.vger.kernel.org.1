Return-Path: <stable+bounces-230436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC4lFLXwxGnv5AQAu9opvQ
	(envelope-from <stable+bounces-230436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5F3317CE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF7A430438BE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6E3B8D58;
	Thu, 26 Mar 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NSeTyGFC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989653B7B84;
	Thu, 26 Mar 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514202; cv=fail; b=HQrySMUqhdYwr5sdE2D0Qt/CDw7QcSkqLkGYcHIrhQyJXbuu7hMauspQUVvYlG5ZRj4TH3r98eUGdxhWBagNzVbWWWEleORfZBNyiRCJHhH9jdn4ZVz/UyFCmu1BwTChkUywqUn1RL0IPICXZTQOuWjvRRdCI3cy/Vu3G0+0Yk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514202; c=relaxed/simple;
	bh=JRvP46L7F2eaASRamyg1n2OBlwShDNWp/UbpXnod+po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTIDvnjpS4kjt+TvksRxzyCXWP44KM28M0uRpR+/46DnDZOE36Q7lR6ZmCQrx5qkkxMFhi2mVaq7tQxS2LkXbfLECaHuHs4LkXru6I6iFF+3thVGU1pOS+S38EfUk9/zmnYQmRojkb4HgezGbgi7vg6+hmu5C3XeAQN5Eif4Slw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NSeTyGFC; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q4C8W7174395;
	Thu, 26 Mar 2026 08:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=GYKfeUJP+8speWTR0SHRvsqPoYjKRtNA6Qqabxat15I=; b=
	NSeTyGFCE+kyjY7hWiJxUK4MDi+RjT2gTatk32Vv0oap/JOLbWgvYJrmSLhZ961Q
	1A3qpHEa3fVR15SLXUm/ZY5Vei246Vh5daglIR1pWPwEWq51ZkNKst7sQyRW2QNz
	8THX7b/QnRjsy5fiRYfYkZ8BgP0nyIikJzpom3/KJLk1B01K94InC7dvytFz2hUd
	WpAmSntLOVyzHMW12hAVlqTFIfeoXWg33Xv2zYYPHlwASXyfJVa1Dtrh+1jdo2OO
	mRSnV/kZjOyPhDke1ddEhfmQQv+C8Y4PT1bOpUAiUk+UnQgVgZx+44LGdDEKl9e0
	6w7g6hLhKkNV4uGJXk53bw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6x7fa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 08:35:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by8978COXeSNeufqBOPi2E5FrRiuz77uACY3buQ5CoudcBANQuQmy8/JIRYZsJo20FR1AD1lnPXO3b69u77rTa8/H51+YxhrUc4fpMY7PMVMme9hfe1Gqcc00Ok4WSKCCvWoZUp5znsK68TGNmtIFLhFcyvG+ySjLlAPdE6gw1ftyO2KbfHA0IG0vwaa6K8sL03dnyc77K5Ssa5XQVZ+M1wEUIN6ZlOl13ngvBy+NyvNk3+cdYQb8TqP8EN9OBp6G7Hshg2XXRzVyKFNuFXag982czTDbCu3Tmfu14CVLkSCTTyekuSE+TB4UQaHfTVvM3AgsGlx8+k3Q7fCz+xQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYKfeUJP+8speWTR0SHRvsqPoYjKRtNA6Qqabxat15I=;
 b=mqC5zH0+UyTmpKf6n4vWwQQS0nFzOZnQdNSAXJ1wqy0ozA6SzFn5L8GJXkESh7CifjJ6vxkdHKOcY6LmI76lQRqF13A7aLV74Yne/AfVGXn9iXvOJ2DT1vJ2JMnVvuDxOmGXmSA8lirEVZkscMLxuGQtAy9e2tAfj0zWw7iL2xELQ8MuLvUM02SVfYqGDPQcGmabYVYtAxuK/3iFeTiqvDXpRs77nYl+oZLBJg71s3+HeZUnq6lqWfkZT9RIQTOQAMX9/rOWnyL+++hx/2EhqYVBRwmAo7i6Ij36yLtAiC1Vs7SvDtBr8JbZyhy30H36jBRVAy2DmY1Su7q1RZpGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 26 Mar
 2026 08:35:57 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 08:35:57 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v11 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Thu, 26 Mar 2026 10:35:33 +0200
Message-ID: <20260326083534.23602-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326083534.23602-1-ionut.nechita@windriver.com>
References: <20260326083534.23602-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2ccd9b-ec09-44c3-ad0d-08de8b12b390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|52116014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QJ2w4ywpno0FXWED9WIassTHc8CzupAQVqunxgZz/wEiy+rBdYGllNkaTI7Ad2v9Ou1jaBOhJdenamqKRxKZqZ38pGXhk/c5tvjb7eN8delyXIdVn8bbquGqtjsUXe+Pw0snK4Ywc5v9tDBVCwz7jT8K/RtQ6TQ7619GGbDlcWiz8+Pv5mnoSmFOiZMaZKyUR8LZL5hDRksg+JHbjvF0k3XHy+d9ZnfeenFuTnu8nnIWECx8loZt8VhAlezQYO3XUKjE9q+NouSlI51g3Tgq3XV+Rag7rF0om7yMO9ijkJDxvyTezeugtAW4Spht5qLkpeIN9/PMGxffaFTHeS42/+14Ce5w8UVtpS7CtIHxTA7BujUIwZkFKCM3/zNhior+TF7nVZiQKjiMBcDLWie89XZ/+eOqednHY/W5VXlDZVRSp0gzVrMj/f6RQcflEQlPL1yVs2yMPb+XK9MW6w/PYMDHyw3I1a9mBVwmwauriCeYip2JJxG5hZXQ42TzGHs61N+3gF2NoN24AyMvYDM2AEMFn+GFHID2FuuGoZgiluWQZkksuLfTjQT4XxsnTUSTI/OmC3Svmvim8Y7vPEONAA4pC/xNPwOj3HMlPSFjI0LGGMegHFVzwLTg0v2xL7Yd5lQvuBC7LvaH7a4FHKAQnHTgXVtX1RvKDOcvam90W0vPObbHicDpnDJhDL2bOTh1gVWgBJO63dzfZaZtdZ2b6jO8UJwMmAffrgQdNB1VbBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(52116014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5ECztLgJbA/29csNYAzMe3EO+PloZVLWJk9sD0jUNw0VK4lk3vtp96v7u1c?=
 =?us-ascii?Q?EhoFbsYV8chG4Tfm0K2hhB/aqUKUcn4vCwx4hmXwuII9P4knHC8E+gOgXHDA?=
 =?us-ascii?Q?2hg+sJRD9ZEVR3JLUiPABik2oMZCe1fb7Mld1UReRIRViKDHGwdhvu3j2tPQ?=
 =?us-ascii?Q?M5e7NBAlCYNpsVGn58npOqOqx0GY3q2NUlEvVcKPMqiFz12he9nyQVfbl/LK?=
 =?us-ascii?Q?rElmspSCZnfysYJFXlv5ZrZOmlrm0Keek77QhiM5GBS/xVU32jhQM0sWeLaI?=
 =?us-ascii?Q?49tZcwOFadJLeHYFSyjco6j2BZ7dn6uhposArZ+el+FpIYZQb7KRZv24rF+S?=
 =?us-ascii?Q?tSAaTrqQasnljAvSkclQ0DeR6OIK8agKOX5oEKr+OR1woMD2QTXBYiuYFyJb?=
 =?us-ascii?Q?JoOhTO2WqGnkSFWQABBEb3uMgF4i2HUZaoYXTddBhbat2YxAeQQMWB7zjusN?=
 =?us-ascii?Q?jMqMXhQv+aOO9M/5KVM88KNmFrDbWdjfv5LXGyK2h7koKlaX1tNOvye5qd5z?=
 =?us-ascii?Q?5USe4ia+L3htOhpuCRf5M69D9VofyME1d1gHKibsnqcznrJtiBFBFjTjF3xi?=
 =?us-ascii?Q?QUVuyUdogG3SjQIWM7PULJzTaoSRCdoa6eewI6mwKkG5TwLCHj5zoEysYoSw?=
 =?us-ascii?Q?bw1IB1zailfZfkskbMjxFA1NLttlAkxFfyZvCPlRpAEeXwFIcUQXQGAsZk9z?=
 =?us-ascii?Q?6MeweQHJeZtV6CJ5GhNkzjCQ+6bzm1HfTwflJnUvLiz+6a7GgmYjbUsuNMj5?=
 =?us-ascii?Q?p5KAMeU0UuDxYhnS3K+jVqzi7vKPIUSjuiMdZ5V7Ey74uRrk+u4l9YX8XsXf?=
 =?us-ascii?Q?bd7Q9yd3lPomvAZCf+mNzwHosNbzL0zCy7KtSabscLJl8tQg9vv6tTaj9w0C?=
 =?us-ascii?Q?qchKw7wxyLqq8bMRYFdQpNHOQqZaVxDwKuH14qcwRTT55BvjCJoL8B7YPE9T?=
 =?us-ascii?Q?IZXnyrOm0SzW7NHnhqW9fiX5LLIVSiMo4ULBuBAMZu3QZgQJZVCY5N9s/sYs?=
 =?us-ascii?Q?ToxZkpmakVooPTP0lO8GbdBlb40KLJLBDIGwPXxmMhEnCnHrTvE0+TVhpMK6?=
 =?us-ascii?Q?kMKdgQKoTBZYqN89zpDUIc4gOq5rcooG04GtJNtkNtFWBRta9kY9SiAabpw4?=
 =?us-ascii?Q?YoNZKWlbM8C+CqBW8dnc33ejq+zVWGjSfA2fkK122ndAGpv/z7I0/MDiv6HA?=
 =?us-ascii?Q?PP1uKSSiYY4nVs2z+x3yybZEfO+OR3U1oYKwvp6vO57qztf6Zqf/mTF6wY1h?=
 =?us-ascii?Q?GwKYig4Xib/1tmxoXKKukZQykDV7B4xuo3FHBaNkN2ftqnVcyasbYBhOXLrz?=
 =?us-ascii?Q?EEBU7JjO98dAv8R0gS04MoxfdmYV6paGFsQN9fY9ATE00WAQ7+QRQX1b5YCp?=
 =?us-ascii?Q?6S1OX/JrwGnpFVeojSdSzMROAKIjCASJdoaW2daWaAiJtGoDaJqz2jEOPwt8?=
 =?us-ascii?Q?0kRZpkylptA9+nkzDXKHfpUWGzHSh9lWSwNyfFZcN6WtVsKyFcpm8o5842RE?=
 =?us-ascii?Q?mDvwlRtM11oq2EJbds/XnqqbKlnI/JCCt1s4gbh22CL5rfxVkfsFILASGprb?=
 =?us-ascii?Q?FHRqGhCuorzivb85niyYDoHqK9yRVa5Ps7fLZSnD/r8SXF44YAvd5nGGJdcS?=
 =?us-ascii?Q?+WwaNqwNcDWRg36hkOE3VxsfKdoIMN+DAOcDsZeNMRc31gOtqLaJ33QV81B5?=
 =?us-ascii?Q?BveGfVjWQCOh+JSMO5951Bc71KNJ8N2zgAFlAO43o5xFyY8N7beXjq4KA7tT?=
 =?us-ascii?Q?f95omo94Ttrzhoq+EJZoEWpI1EuwXneJRfNFPoAAYcZ+Pn0q2rmcGjCwUXvY?=
X-MS-Exchange-AntiSpam-MessageData-1: quzT71cVQJSQ3KCJxdGsc/mugaciyvmTnxI=
X-Exchange-RoutingPolicyChecked:
	i7uJgq3Dn4aHo3J1optZw9kR6Cy+XZaUK2NjAH1hfgkCptLt/Ji3j18nrm2J73AzSDhE6RLLuNUzK0iCh84Hw9XZnSiTOjavBoeHP6v39aZoPyLn/x5PaKwh4lJVxXg5+yEckSbBGlnaZavYvbGBtqgmkdCiPP2On/A4kjhQahQjJTWoEj4t5+dmLLlN1Ll9jZiI2kcNFp5Y73vcG/OWk1IUpEWPT6cX95O/8dtN+k11BT6OlM9Wc3sMWswvFV6bRj7CLSwlkfwE4bu21kFDPN5vWTn+HkuSvoyCKVxNsos8nK6hzIBPU6v53hoqNfIvRKSwgjMBybmPZiqqWfVZ3g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2ccd9b-ec09-44c3-ad0d-08de8b12b390
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:35:57.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/0yu/ZYnipyxRrl4jsfWe7IOQ7ix0OO39kwYns0Kj3YQxZKYshQIEh6dC8LUUJ9VbsFEon3BzQz0iYaaBuAMBgXZSAy+R5DLxOH6A1lplA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2MSBTYWx0ZWRfX62iSbdhEzKB0
 hdyYX2B4jEYnNaB3oPC+5k6I+uT65QWbHdNMWuFBAZg6k/Y6FIOD+L64+P7Mx2aaUa6yZrp70sQ
 QLovWckqc4As5dV1Pa1gtldq3o9K808/TW9xOtokQas+AtAvBZPEvIWLA6f9BucOhQOMlRgPjQq
 Q+8DbEEOVthKOkWymvJqA6vdYB9cE3iZ0JlI30F3nM3fxLBl2e2KHp0Wv0kqXqJaQUhpSUr8e22
 OzgaBqGT5CXICZt12FAqeOL1jpssN2ZEkkT1LrLR23pvlacmWHzPoxLPNqWGCr/xxAJSqFUmy0c
 BLSpgw6WmGVPSuSDRBXsjjhbRgvI9CoQG+7dPDJMPNSdz3UyGOqzrnJYiHDF1LJ8dav9h/9AHrc
 cynZA7+fZTXOo2LS2ABBlBrNxOekqSAbTIMXLHRK5jWP5suI5Is4Yl0u/w/4M0chpyQjNWHPwS6
 JYdPa/n8AzV2onwLnAw==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c4efef cx=c_pps
 a=DyUboiW8/Fjv5kZUpInndg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ThrQ2Dkq5_na5RY6e9lPs643F1_tu1q7
X-Proofpoint-GUID: ThrQ2Dkq5_na5RY6e9lPs643F1_tu1q7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260061
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230436-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wunner.de:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BA5F3317CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant using mutex_get_owner()
and a reentrant depth counter, as suggested by Lukas Wunner and
Benjamin Block, since these recursive locking scenarios exist elsewhere
in the PCI subsystem:
 - If the lock is already held by the current task (checked via
   mutex_get_owner()): increments the reentrant counter and returns
   without re-acquiring, avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, providing complete serialization.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the reentrant counter if it is
non-zero, otherwise releases the mutex.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..7ed902539051e 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..ce4d351b5aa21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,16 +3509,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static size_t pci_rescan_remove_reentrant_count;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		pci_rescan_remove_reentrant_count++;
+	else
+		mutex_lock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_reentrant_count > 0)
+		pci_rescan_remove_reentrant_count--;
+	else
+		mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


