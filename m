Return-Path: <stable+bounces-200443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B352CAF581
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E93AE3019192
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF922D7802;
	Tue,  9 Dec 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZDBrpcoz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D224272E72;
	Tue,  9 Dec 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270419; cv=fail; b=KNOva9VOmuVOYmTPxyex6tan8ANEHMONdChNzczwRXbs0u2ZUglRz9XS/ll3vmOb90bHRhr4mY3aUzRZch7XPWqerAARpxMHYfraVBgwYAlcwRPo0MkCuIY6wT5BYifT1SEzDXYffIo9TyDfjYhUEozfCwiMWnCjVsDHcn08zdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270419; c=relaxed/simple;
	bh=1Ug/z80x6+R3zTd2rK8P0YvEUyWMISooq0JYy0oAD5k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lXWSOtRqCv8Hdf3EA0MwJF/Gzsj12dmVMo37qga2CDSsUX52SYnNO0BbKsyWyyEyajX9gdfCClVK2dRrWcyx5HMNPud2ORURdMBS97IzqcFYMfPyEQSG5lc2SgjhH7EW4cJHbU5TNoxUTDX99OWPSZgUhzqOlH4/GuTnemxA6uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZDBrpcoz; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B93povc2987874;
	Tue, 9 Dec 2025 00:53:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=OOEQTiyc3
	GYdlLtqsrvnsbPeXhQkXjoWLojflka1Ek8=; b=ZDBrpcozq/anIL55U9orFXMhl
	rEPv+RPkq9XEAbQZIn49/OPseccXnVoEel2mzFDE2F4jkdgK+pEn9A5YH5YCQpSb
	qwSwpNmT7PpDZcmN88yd4tC5pC3jkANubuT9cPzzM0wKd4dQNN8NuVSmV8M8esC3
	omQWf6JkbQJFmnY86Wln1RPL/VfbKWbgL3+H8QJwt7YKURFAbIp7QtEI4o9888ez
	uPwYqFFzF3zjxYXYuPRlD6wTRyZOlEEwW9Uz23gOhYD3gl1auUuoBRBvojETQWp2
	NCELY9jEElF9XzrHbGbg3t8fAEWlL2+Bnr30gtb7mnWix7Vh7NBlrCyY0cn/g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4avmvhag57-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 00:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqEBb2XlXWbnGquX/uqMrmcSfTalNlrr65DKtiu0EzEaBlDWBtK/2jKkXDnG8mGr76q1rAKQ8fkTMMwkaXaqiiCf9oDleFAhF9/qFaZH8p/D6Gu/l85ZRKZWAqTfbZGucL224T3HF0x0sn2CYjqChXQmw6ocCu0ML7eeXzaZd2WqWmUbCkQ50rXnKGtL4Nvd7CNhqC/0W9SpM3/MxA0t4swhhu4kR++6ptUb1ocWo4a0ciJDVhQj3Bw2BJAkNjsD8FJ5QkV8EmpiGVuibFRXiHd8lVWWI/AloeODWiy0C+uBbbwwTAbxFfKL0ImcRgDG2qitFOYMvcQ6kYzLzL6gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOEQTiyc3GYdlLtqsrvnsbPeXhQkXjoWLojflka1Ek8=;
 b=OR2Eqh2rjzw5a4lUGvq4bruHaAnYlx7uyYZg+1szCDx65sun3xmh+qpucpThz5faLsLVGAAo3j81jAGkoqwOg+wiWjkJF7U7ObAFQmHhlDfUtIfrWsVReaWG8KI+9YEeByUHV+v28vvCpkgE5X6jWNQA6q8RTESCdoZlZ9hC2Of6U3VmgOnjkK9H7RmIDdQd0zBUwFnmFOnwFnEJlXe1gEBSMOewVo5XupwrEB9ZHw0antAq3JWEl04nAqMsMt5X7DneXAjRwlsra7VCoS6/7zFgggHxYxlmK1cof7oDnKX60oHdHMo23rHceNdAJ4ZYUMO5NYxwLkyVYmerBEbOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by DM4PR11MB7374.namprd11.prod.outlook.com
 (2603:10b6:8:102::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:53:01 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 08:53:01 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: pabeni@redhat.com, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, rmk+kernel@armlinux.org.uk, Kexin.Hao@windriver.com,
        xiaolei.wang@windriver.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()
Date: Tue,  9 Dec 2025 16:52:37 +0800
Message-ID: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::13) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc39127-a62b-4fa4-44d9-08de37005bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnwJ5B4rKri5FGRnKnvvg0pOJhn1D3lb66qrApc8tmN7GvS8e4kZGUkQwFjE?=
 =?us-ascii?Q?/F4h9slngc2qHSjmByIuD84ojNSlorFYXN7YYHUo4qfMpuS43un7xw5x53s0?=
 =?us-ascii?Q?rS3W3odFB/wkUnJeK9Omf2rAYffPnXLk7O1b8W9VmDTtmQmQI2thUwaoEhmV?=
 =?us-ascii?Q?X1+OQGxB3Fij7x5ek+75rntQRFoBpFeP33Kkb2MMhpGEZhjO/QcZ3Lv08H8T?=
 =?us-ascii?Q?ovaouv41kf8iZ2P3B8HqJrOzZ6AD3IB8QY5neuqd5SrsDzOd7m+W3OEuCHsQ?=
 =?us-ascii?Q?e23NDrtzTH4KKO6edm7RL+uw0Jw6Aeux1gM+0WisWXKiXcvZWiZ9+QcjqK1T?=
 =?us-ascii?Q?P5SpCsV/T2n3fa2EdRXycOSlbPKp7G1S4Dy4PyFq/NtKFjuAOCT3qPBcOLKA?=
 =?us-ascii?Q?anPOvCe93iSWJJqs17QI5LHlVkrR61nsZWwbHDjXUuwDvBhrinzpbH+dyaY/?=
 =?us-ascii?Q?0bWFQ6+AWQq68zCGsNniG4wvAnqYEz+qUSFfKMHAoCr7SaP/AxJ8ULOlw5up?=
 =?us-ascii?Q?ABMQv4H+deiemmtYRqKQyIzHgKQqkBopyVBSDiyRyrnOaWo04d7nlJHXhhEt?=
 =?us-ascii?Q?1NGamIKONcBNJy6cI8ntaGvoa6lsUl9o8z/sStLzp4AER1o6BT+S/DjnrbqR?=
 =?us-ascii?Q?sa+IQjwG8E8OQ4Elk6abBkKEcv5JuGeosBrZ00cwPnGzMmZNw6IDZRmEoE2q?=
 =?us-ascii?Q?EithccU+xiNAZKvIGrpjXr3VHJ4y9GQmZiFM1L1rojv79qovhDwLuFSzsEyK?=
 =?us-ascii?Q?RyHjwHfeZC4nk9wCwKqbNf6WEy74kvvvVjR5JdEp3JrLobQ1zoJMRb9XdjFc?=
 =?us-ascii?Q?1bZK1GQ0A1iXZ/BbOV4WtIfIjPW6xXJonKV9TJUitpadYYv5O/E5iKKzu9ZV?=
 =?us-ascii?Q?7Dww14W1KsusWa1rPMm+Z053rZLFhMBFPsi35mtZJWAQe+Qhx5YpQah0fGhR?=
 =?us-ascii?Q?OdBhUJuQPFdx3pYiTR8tZ2yOrVRcpq19sgT/yScdojFgRYcPquC2wd1ETJ5v?=
 =?us-ascii?Q?lPJgYuTOmneTdVav6MKA8wsLjmSFpVvRQ/PONkBK0V1ANU9JLsGe3olG1KRn?=
 =?us-ascii?Q?stKxkkDzc5lluIIaaBWeKcb42viLxC2QHW1M0GM9soew0i00CNkSFqEFLgow?=
 =?us-ascii?Q?1DKX6pSbHMqjd+1xktfdGSorykTwTHmKRfmzkhas8fLTy4VjDMT2walzDVpX?=
 =?us-ascii?Q?QJ+sNpKQQxqjnV33sNCTRr/hYuD03EuXussERXWqj7eq8/D6h+xq2cNBbg+o?=
 =?us-ascii?Q?TITHeKLSxZ1FjCO/x+mOiEIjUq3oYjH4NDGtEkMHHxmv5MJcTzzlOJoQznh5?=
 =?us-ascii?Q?MmkHndk7y/svWWSgu7gWsGTHnAOHrG1nLj2ti6wuQIy0+pqrnCYs4fFCpWuw?=
 =?us-ascii?Q?tILVrVkcQM9HFeh7u+fSPxW/+oTIy0a7ctQ/aYo6umNgfGNayGuTifWP44BT?=
 =?us-ascii?Q?xecjZtjw6TgExjb6VHfVx465YzCrvzxjFYluikyJnQXc1xXI4Sz1+x2Nhqi3?=
 =?us-ascii?Q?KJazKjYiHrVIzDfOCYp86eq/BfY4NFP9Rfhxdz647jD/8KMsqtAKxKMG6A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gf4mvJyZk56ycH7AubTDsf7LjWO9lMmMj9dMevayPqRIbqe90I6C3p3RW7mf?=
 =?us-ascii?Q?j9NRi9ySkpqDdKMOagnA82e2Lb/Jn2zVOzzdEEnNDTkvs080lM5wzQ3GLtK3?=
 =?us-ascii?Q?wiFjoV8M8GfaVc2DR8iEExQogkDZeOCXswC98/ievcViYJWqTyTBYDgmQ/SO?=
 =?us-ascii?Q?P7mEL+L6X2wg9yzA3n2FFnEX2wgZF8EKJjFWaPwdZm+CwrVcdkC9Vg2SAnLf?=
 =?us-ascii?Q?oxcP2Q9ibjRVl1ri198RnwrwUObDsIdnIzOD+o6egQOloq25jaFkkRez2D7Z?=
 =?us-ascii?Q?JW1EXElhPlD6MNncWPCAPZVs28mX3689LC0wNbPfL0dxyQHk1T9Vk5ubIWUd?=
 =?us-ascii?Q?EWoLM/jfZycMHwn+PZ6EojcU+tFG/vRsupmrGdTt4D4R5jpO7LXwxMyTu9c6?=
 =?us-ascii?Q?zqE8FS5GRPeRz6dtZXqLLwIr66CrW6ZH3fa08xBsjnLtLGxFP5PpoT7hJUl7?=
 =?us-ascii?Q?IpXpV/lYwr2sfcCtKio0EkPmPURy96yJOQYzTo/BAFglnTx6itiXJrHPt49J?=
 =?us-ascii?Q?RMHeEAgrvw+2R5xFBTZHabISCrx7aUEMpcWTrgVZoXBeV9a8VecI+zj7wrEH?=
 =?us-ascii?Q?8/6P+F1o/9e9oTO03XAKJ+Vk+O6xmhdyzsyjfDZ3WP7hpWmNJw3fu2IbfGO0?=
 =?us-ascii?Q?ZB0a+maArhPXZBVbHzAdDDteMZo29uNuiLeeRlKabz3YVzTzsuO7mgN/Nc5R?=
 =?us-ascii?Q?+70fybBnDxcXjy59mltdLOVoUpYbXHaGBi+dX4k6rU3OLNBUe77jc0hlM20N?=
 =?us-ascii?Q?2rwejrtR4PPw/IOqjvrbzuTKaRpT6MpfZks5kz56ONcEy2B4XT47cQU6FApK?=
 =?us-ascii?Q?M/h1v0xMjWSzem3bflVYERFpmrA/f0OkGP3F2LUs4EazqNDG02cVilo9n3zn?=
 =?us-ascii?Q?bI4QSDv9HjTbux2knWC7RCo/x1k9uqnIqCYMYByJ5CSYRr8PeFcqV+2G000z?=
 =?us-ascii?Q?smKFTzZE0CdX6LHBZFEV1WSl8Np275Hn+w5WvhVNounLnCSgyzA9alG4pIcy?=
 =?us-ascii?Q?7dzSu3i17MOsULT/p/OpZ6NtjPH9l18A7+yeGIfEPS7jj/kusLcnzlYxIDbl?=
 =?us-ascii?Q?aVnteJf26Mv9/z1mnM9xiDQLgWq6tHvdWPHYzXmV7h/I1gb89OLMXh6OiONu?=
 =?us-ascii?Q?voZBHp8TA4c5GBe3nkhWOMx56W7IURell9GTcsEUO2YeTdc8Zc++euaPjAhJ?=
 =?us-ascii?Q?pgYgBPi9hFqujl1cpoadSViwUkn5EMXGoy7EYdlyHfFNrTia7T82KYDWW2eK?=
 =?us-ascii?Q?GLSeWcDi8XTOKaa8tbQPySdUWOvNXM/4Di7sLJxI0s5xCstIV2N55/DyZH2l?=
 =?us-ascii?Q?OlewWwXEdNLJkDq4QhTPkUR1HTHLhOn76pyugwE+iwE4WgLWIFE+2jYX6ihq?=
 =?us-ascii?Q?Eh+km4Li0ANbCya4zn3snkUYmqisS8HVaLJHm9YaYNWeD+n99ki0qVCDoCDs?=
 =?us-ascii?Q?NZF7w3jmIg/Te7sxct3drmOWINqrQfBETZUHuoB6RoQQ7/nOzzl/0zgjV3lB?=
 =?us-ascii?Q?TcDGK/6sn807QX4jQL6ndlm9M4YztXV9h6uyfrUxFOBteFt47VW8gDmWEdI/?=
 =?us-ascii?Q?SeTiiOF3fHu6d/Sx7i8BxrfEwgBzfvvazdyoVL9TOXZD1JpmTJL9jzPRmMeY?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc39127-a62b-4fa4-44d9-08de37005bd4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:53:01.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdI3IQWiUVMTwCsTLDiRdaCrI9GrEWSR6VGEBJKB6BTIdLC1KjXSXQIBGg3G84GgdZIAwuXup3vXmrUwKKku5uIxA5TV5YIM4n3CZSxtVh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-Proofpoint-ORIG-GUID: ptPJFYNIGRQy70aLNwXQtUcoFWZuze0d
X-Authority-Analysis: v=2.4 cv=be9mkePB c=1 sm=1 tr=0 ts=6937e370 cx=c_pps
 a=CnS1ju6qDdjTg6bRefQovg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=rMatQu2YQQHvfZU9zi8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ptPJFYNIGRQy70aLNwXQtUcoFWZuze0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA2MiBTYWx0ZWRfXyve18ZQ+ZvVG
 vbOBlitCJ5gr6nex1I9M82zQQU1wnihl9x29IJ+mB9B0BV6Su6HMzC+Wcz+IkQz5BA3pJ9ae1F7
 73VzIoyw039+d+ArDFBl5gvXgJhMKP7sl1Omu6Un3kO2KEVUL2s0VoPT3QRk+wVi38Ien5RKQEB
 iaxvxCjxJLC+4yHcADzQAeGw/+/0nloqkSBP+PvlKnvRk+8LvODZYpsb7IfcbhvMAV/EMJVp2EF
 6/OhOvkviDjnCu3kG75R2yvW71h3a+irGpSLo9HYwZ7adlhjo2rcpZre1inTDGLCepnRg/vIeua
 DZhapyPrP7zWNmPdycrBHDmHMd2Pl9ifGgH6qVesz8ZZprkhqsNiVSWT3Qzhv/korrKzod8/RDB
 39KwKY6PTAGzHHPcsNXBik4VjpDVIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090062

In the non-RT kernel, local_bh_disable() merely disables preemption,
whereas it maps to an actual spin lock in the RT kernel. Consequently,
when attempting to refill RX buffers via netdev_alloc_skb() in
macb_mac_link_up(), a deadlock scenario arises as follows:
  Chain caused by macb_mac_link_up():
   &bp->lock --> (softirq_ctrl.lock)

   Chain caused by macb_start_xmit():
   (softirq_ctrl.lock) --> _xmit_ETHER#2 --> &bp->lock

Notably, invoking the mog_init_rings() callback upon link establishment
is unnecessary. Instead, we can exclusively call mog_init_rings() within
the ndo_open() callback. This adjustment resolves the deadlock issue.
Given that mog_init_rings() is only applicable to
non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.

Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---

V1: https://patchwork.kernel.org/project/netdevbpf/patch/20251128103647.351259-1-xiaolei.wang@windriver.com/
V2: Update the correct lock dependency chain and add the Fix tag.

 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ca2386b83473..064fccdcf699 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -744,7 +744,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
 		 * cleared the pipeline and control registers.
 		 */
-		bp->macbgem_ops.mog_init_rings(bp);
 		macb_init_buffers(bp);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -2991,6 +2990,8 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
-- 
2.43.0


