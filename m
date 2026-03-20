Return-Path: <stable+bounces-227620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKTIGgOyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:45:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E342E0F8F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E894B301EF22
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD9364E86;
	Fri, 20 Mar 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Xc3fkkaj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F0364021;
	Fri, 20 Mar 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039551; cv=fail; b=KLYF6czb73yVt9wKrTAyPthOqmSquQ1KQtrrdOJkUezxffD8Yl2Er5v0lx1ZVloEdxyzqKjh+aZr21DGHTuz6Q459aSCYP4q6+/9eBYrd8Y5QPKr7s3beLDyMSDC48ie0mQ1IAZHAqqAMFT5BFA3JJLw+XR3IqsuKjttzh6wxqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039551; c=relaxed/simple;
	bh=x2X5EBrZf2XyKVw0jUbDWMFxdJoBpCAI15ZdcbTBD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GevIctroOjOsnAqPTaROQ4PNtB73+HDFKqnkHplxcqzxg4806MQVorOxYMS2kolKLNZF648tiZiqOUZbnh1UreiiyfwIgXqtmp+n5Nxm/gH/V2yAlG1lW/3Cv/EoOcj2mSEswDLbLQ7CAOm4RtbgRQmOaaVdUl/L8fRWyzvPKpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Xc3fkkaj; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KFNrV61789288;
	Fri, 20 Mar 2026 13:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bXu2CGPO/YCOOGt7fvWnSrJfdPwFBeVBkYcENPHjHlU=; b=
	Xc3fkkajIX9Itzj8YoSYam2Z+j6tzO5OxBIrKyN+wHOCGvkz6TirusINj/xjlUWe
	o73g5gkf8plfx8o8bbiTdX0hfO9BrC4aXGD/1pa+KL8wgWDYxBQBtdt4PJKkN1u4
	vJyVeG8UssktTX6nuTWKJ9e0KUkodcUHV/QeAoY8ssbgnYaVDD9U19k+4btQY41u
	q3PWhOdGHOqCJ0PXdclSMT19pl2DuvHt4DElrlCKMkhoicXh5ejxWx3+iTOb+43F
	4qmK+fe3nas5KvV2X04+uc/SSgf9yR0Tczo3P4r3GN8ZLpoF5DAK7gkAsuVORM6p
	2eKxyGmcAt/5PBwTrWSHPg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggb74-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j29NiHvqg0aZXf5UOJcPD4d/UtBuj//N61BP+be3yGQGJeO3V6f0lPP02CjTJL6+ot7aTPQr4g/eXYAbGL5sYOywud8xkqtokg0MuurM+IDYC2Vjh0VMWc5oSW8iAYfDZpExJbxl0xK8QSigy/5gJG2TyqCrSlDiezYASSOGbJvmFdjuwPuQtHk37Ts28Q5ygi9QB3BbxAKp06yK7LaqFFDwfBmKDSON6xYwB0osLdy4q84EbL4ZrSlyhQI+EMcWKO8im636Dbvie8MCa3KsMd1iiv0Qf64Q0k5W6GSTOUXZIuHNj+XybhURC0qLU0zBHvkizt3MShSFS9Tu7eUOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXu2CGPO/YCOOGt7fvWnSrJfdPwFBeVBkYcENPHjHlU=;
 b=Hfqb1JZlyCzG7kQJechrWh/scAH+kZwmwFuEEk4t3qfcCfQ2umXiF6viYjnha31KueUeHc+T7b6JfWTi9YMHHSNzdOJGqAajVCBFPeK+ZVmJeHyF5C8Jq2rsuwz+vJTxjmv7CKvk57xsamdzD+X+Aamv5w1NVjal5wdNuJamfvWvXX6OF4BNa4GOEegARXVLhJrhudo3T40afHhCX4F85i/ATSnwCVJTjRip3ZbRbk3GRqemBPUYc4bFTIKYnF+jI1vZeyqMv95QBm+f6bc0kj3qI7dJ3jxPs9aQImhaNbyDoOWE8NjDncH6vNuIC/oCDuoYrVgfqpjrmHGgQu6C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:45:00 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:45:00 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com
Subject: [PATCH 6.12.y 3/7] timers/migration: Simplify top level detection on group setup
Date: Fri, 20 Mar 2026 22:44:38 +0200
Message-ID: <20260320204442.32901-4-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb728b5-2dbf-4785-d229-08de86c18dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sCYCAA9IM9Y5dc8qvDsP0Y1LIpVR6AjHKoYx7M4p0YeNhiq4YbEumDy4VijM1ST3ysVB3m1G3bIpvHUgq4Z60FX+bQsik0kb9n1My/57M8OwxjcirPAwH55ZKwEIBDkW64RfxmE8O3U6Vq4HQ1+56pUYCQsVm3IENn7rtOmAQRPh8NiIZaRwYhx8ZCm5EGAUEuzEnlDszlfNoRn61hZuUEb1nsuvRFgi4W5oCSq8BBe6WoAt0VywnbPPTnj+hCQXioeCTRMurSS2E3h8ckX1/2vgg3PLWRQ3GRUAfv3Tw4koi+IftBAssgyXaDtx5Bxqstufsl8AzHthpnE9gHhLLpu2WasQkTpC2x1tBrQS2sIF2D3VKscVggiu0KbsUBTT/epw4whRf6dkwg0EgUtDeAjVmZHd1OWN6Jdi25MOQKAOzYRGAimaPN/bo/6u2O8qY7rh3Po3VAOm00VFyeA4RZWxqor3qeustqwggMVNQpGpqlfgmSvQh1CbQuNLadlaP70IKEPTmATlWvLZyAgmxxcMBeeIp1gPOHlN26ujLzZGiyhUcKbsiPEP5LeD1/fFYn5N43MAy/F8pF0hkxbCiewJooKBgqpam790odIxTYv7cSxcC4CbSiZWqU8jQiV92EYTxliZx831SENtOZc2OL9vii+OCBYY+8f1rcZZ37wMi4UuvSYv2COe9BiCIuMhup6nGnn9h+Hpw6E4kI1LiEqXySbFDbdngY4Fn3PiLw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBmjzm9PrafG0K2CY/8eaXBoci4vFJEfeO/lpadrCJOs+uX72Jz21Hs1HrB2?=
 =?us-ascii?Q?4GDL+2pb0NmRKXVxfzCJUok1vBC6Bmt0y5oV3V0J9F8MDkBn3ytGrINJZRwJ?=
 =?us-ascii?Q?ffHCqTC+XZni1GoG7s5G4T6Z+dcwHvXDrXRWTNn1zDk07ImdJ7RoufzPxfGN?=
 =?us-ascii?Q?MoD99VMmOj4h6DhCFK+g8iEikEoLbRvdO+yyV+0udxe2T7uymkRqexY/B/0N?=
 =?us-ascii?Q?uaLno3bRhoi24Bdb3LAUxR2+ryGhNe6Ga54FQbB098y+1ZFZKc+Ihw3RDr5k?=
 =?us-ascii?Q?XXgPvdu5+GxFyeyW34Jcv730dEy5Rq1Di3DvdbNeVyZJvOu4FfYrtKYs5MFL?=
 =?us-ascii?Q?0s2gbYoQUltCIwUnQMkYF/Tah5739dxJ1yHCt0M42hbs/X11IGvmqFD3ZLAw?=
 =?us-ascii?Q?3HNE9NUTXrq9jIJ8xFCl07MjcFWfZICm7QQDOz+qRPiBkfncW0vlYecpHtDO?=
 =?us-ascii?Q?KsniKkoeCF/nGnWlYw8XpGhyITGkZFvwviO/9zhljIc/xAlD/9cfjRYCG/Bi?=
 =?us-ascii?Q?RnZSpe0VJE67tDZXhzLvmWwEVOAVaGloatWLm6iW++XEdx4Gv/lcLisXgphg?=
 =?us-ascii?Q?Ye+f6ssnu/aEk3CvVjBp4AyUsFnseEz8FTRxDheaDG2EEhkm5hkiXEXofWX+?=
 =?us-ascii?Q?HZauv2tZN4c8pyMmLNK3FxnGghfQwmchoeI7XAwjwP7vT6M3iS6gbI0uc/IX?=
 =?us-ascii?Q?e0r9OPpCkBah+49xxbwE+57fSyRoby8pHub4X6RbCcwo+e/XkoInJ/kRPMl+?=
 =?us-ascii?Q?EKEf7IpbwkFBZH5BMGZJN4gYWAeOQF0CuTiafknB+QMt+urUPozH3q7WnkNU?=
 =?us-ascii?Q?Gwl7lSqN7HScEckdl803QD22byPOYfJ4gJAH8WvauMG6HHj/Vc6LMehNmpUa?=
 =?us-ascii?Q?h78kwgZB6FoVUFk5Eblf2/I+zWOc1pmFRoRj/Z1cJqop1IS1o96DgNCBGxtb?=
 =?us-ascii?Q?RsPuW46arqVcMJ9rKYZfKvQz+APDqu58d5Z8bgum8O0bGRCr/lAt3OZyuQfQ?=
 =?us-ascii?Q?rCIjBD6EoaUz6KyMM8+GfmEshRWdYg1lxkOiVWIInPs4fo7WT5QHU9WjTo1m?=
 =?us-ascii?Q?rmWL+98f697c3tEcclG0JRqAzS+Xv+Oaw5li9R9Vvab1kFCzc3CnFjkLdne+?=
 =?us-ascii?Q?JbKUi4WcPASOdNjiG5WGxXPPrPcHiseYkhqaS8SXgoYBocjQug6KulGmL9vj?=
 =?us-ascii?Q?u11qhB/HkfDjOZCwQzSuSIccJM4NN2OtJBIHwSbRYYD+TXOq/wjc32DE2itf?=
 =?us-ascii?Q?B4vGPpDW1YHw9kbSzsLrs3Cio8DrrOQz9UpEZBv+blHfh7KbPEFXg3ARDGV8?=
 =?us-ascii?Q?l76uO64teAxGWVTsxV64jiXg18ZzK6SxAOHHO7rMdA3XTWTYodkxNbHJojCc?=
 =?us-ascii?Q?trVqcxKIN7R2TYmVddRLfbgxO522gBWOl79fn9fv9hGSAgXLw6dP23HnpdTN?=
 =?us-ascii?Q?79fhPG5IP3790RxwHiKGpra3LyqijaHxUuQ0NTeoMvegmDjXUR4SsTHYDgLQ?=
 =?us-ascii?Q?6BATnzrYGJeSaBCCWJHbp7KSsJjUGOsPwZlNopox5iKpRxp0QSewIuWdzURi?=
 =?us-ascii?Q?WjcyznikUzwJflhuTE0qQUJbQUFeqgusn2mvjdMvsFrB0vhD8lOM6+Q0jjCJ?=
 =?us-ascii?Q?O2/PfTlQs2uhiGCfJKhpo+X8iLwflmqvJ7msIRE76CccUPClczqg8bbczdFb?=
 =?us-ascii?Q?fJc3Xphnukan8JU7ZyBsUwVR8h8DUEtJpBtqNactFBFd6ToNwPbIb1r8G3su?=
 =?us-ascii?Q?ibrwaQkcPjUliJsaJ0doH0kx2vHL/yfjwUxwRTwxCGTqmf8HpLm9GZP8/e2/?=
X-MS-Exchange-AntiSpam-MessageData-1: aebYMJFgSi0QkBAf/qJDvzzWd/mZuAyR+VY=
X-Exchange-RoutingPolicyChecked:
	Eh3qPg1rXPUBUL7Jf8lg1CnGqnbVbrMSKMdS0knsA7CgYJ+Ctk4Omv7zbMMSTyA4RDq2kfSAyYERGm1SeNucCGJQKRzuntudy3LimlgCy0IIeOsM2oa7yugQSpP3KAOj6PZvR1NlxUFhlka95yTfbJXsOFZtOtpZYPLNCdbaqcbIwTBGThAhqqiBVOP1sF+PHBGnHPO5cknoDKB1Hh+csyKw0bJZfjzcSs9+SwO69jnEm9zesNQK34CADZcT40qvYckIrAkDNgHnkE1/8AMyavMg89+Mz+qyy5A5S7pr37FvHkhq1HjtAMOeJQieIiXfD8M3fjD3ENbq/D1ek+dp/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb728b5-2dbf-4785-d229-08de86c18dcd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:45:00.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G7Q36dwg9WGDlonth3DN9ewILYtmL6u3c/mqUlXTRjZjzq4AYMSefi4U3JxsQmnm8m3Tc+NEEwLJZ4k3Or4oTFb3RxDIfb1sauvaNl20N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Proofpoint-ORIG-GUID: OAg3yEK8DX77MRSHRba-s-gJWYAYCrvm
X-Proofpoint-GUID: OAg3yEK8DX77MRSHRba-s-gJWYAYCrvm
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69bdb1cd cx=c_pps
 a=wv7XMN/IKY0/lkzoMchZCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=rEUqSOOw8WWV4gaEgngA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX1WDSknC496kj
 wEuO0MMa2nPnSFdy+Jvwufq8PFjsY8GtNS5OtBCLTS8eIl4SyKiogw5Ote03m54EZkaJL6LvCnb
 Rs9I8A0k3lqljOfRkv3yYN/m/HG/jx2aVf47y65TgvrUu7JxWv+eqQf9AptXkysi/X2hLOdTC+k
 3Fz1gBX//BNpDDFMsXzzOktX9Of5XL0ZMf3N+KBYM4xg0DYQlAbVeoUv6hijJgd+I78ecTNZYr+
 WXj+edXlyXSQUU1Tn7g4jLC6s4Tjh5gwPMNdoHI0Xl5+M9K9Gxl5hBWWhQBhMUTsHxmnZOfEdQK
 +aqep6l38rDnd3rCcgtsVyeZmcQBpwaUeST8BflVLOABDNIksQhJ/tl5DgEhuo78ZtpjvIXkOVr
 r2B7kFTFSG2W3bPGR9RzTrO/GuAkI8K8zTfJlUhyVN1bPB8ED8IvH92FLNxMVH86nONR0asNCuf
 PvA4QyswtZv0rE9+usw==
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
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227620-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7E342E0F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frederic Weisbecker <frederic@kernel.org>

Having a single group on a given level is enough to know this is the
top level, because a root has to have at least two children, unless that
root is the only group and the children are actual CPUs.

Simplify the test in tmigr_setup_groups() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-5-frederic@kernel.org
---
 kernel/time/timer_migration.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 0707f1ef05f7e..2f6330831f084 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1670,9 +1670,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || i == tmigr_hierarchy_levels ||
-		    (list_empty(&tmigr_level_list[i]) &&
-		     list_is_singular(&tmigr_level_list[i - 1])))
+		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
 			break;
 
 	} while (i < tmigr_hierarchy_levels);
-- 
2.53.0


