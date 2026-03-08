Return-Path: <stable+bounces-223454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANDWHKd/rWlU3gEAu9opvQ
	(envelope-from <stable+bounces-223454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:54:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9CE2307FF
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185483011F1C
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FD261B8D;
	Sun,  8 Mar 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SVgq6qTj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD02571C7;
	Sun,  8 Mar 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772978080; cv=fail; b=a32/DyzD7VdquAlHkVG4PtO7i3vnA5NXz9r0zPBphysrHyFNe1SIzz/mFaqCa47O5HwrNB/TeFdU/8la+w9SdF7zQRtPf3QixklIDMwXNiJu/I31MdQZb8Wazl+go2LcQwe357M6HgpgCgEhz/8LPFA/Mf72XXMIUgve5TQ2BUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772978080; c=relaxed/simple;
	bh=L4h9ZF3uU4jRDoQsg+EpzFZh1NoMP9bw00D++qgAi9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=it8vsEPmZo4LbVWAynmZCiIC9iJCCV7K2MdhjC0uo6f/k1wYjMWvpHOt7yonOkGQG/c2JX/rRulsyzDNfTWhN5F3nhgdm9mRTuip73/gGks0lI9W4mxkNmr2c3OTOEH8w1pHbLQk+eQkbPHmT2CdzyKxfm9aZXNTAfdLs4DuQw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SVgq6qTj; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628DiO0F2490193;
	Sun, 8 Mar 2026 13:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=w4R66t1Ds
	rQ8HJ+MNdqyKEJcVQI1bVQcghf1pcjQg+8=; b=SVgq6qTjDK8hq1+Vxpx/b1vvz
	7bML6ruKKR06q7BEaLuc8CGNxkw0xNBysmABkaUDtIIlwyHIhsjFCloHBYwUysHs
	zmFOG4yWOXGiUkTg2tRi068DrReqkq7XijGbQvfOSsC+MHvA9IlCYJdpQyk9sbRf
	gUE9L589Pjfr1qzX3mB/XSbPuPcmBaecLcQPBFRXMQoMnvXmnKHzxVZIWa82wAyT
	2Dzn1yBqlNOcVegEy0AvpEq0S3btV7nrA00SeIiuXm4n0qiRUAnO3zAXotGGxnXu
	Db70WtvXdFkCFrFA4Tx1gNf601xLf0Y54JkxwK7+EfqTooydkVnr0vYzl9gUw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb0810rh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 13:54:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfYIVOp8eN0zwKa9UZONuC65DrPyxfQbwFMaxjMstHNumNn87mvrTy+1dPC9z5R0NCcNsjCepiXol/tHT3AuUVQtcx2xeSflE8gCPYrz5HcS4k1AsS5cJ7n86nsQfTszkSLgksMAjIMMmIzxIFv39iyaJ77GSMmseejzCAyCEGxlV3O44P+19+T97w22Pem2veeDRDc7rPx8YfLxnqqibrxZXSJgKXx2Dfnzm9ilRqe3ZJ+QkC/9tED0+V1I4Z8yfHjtV9CMxCjew6oGpMMFze53V6hnKG+SuleUgaEUWxlTrYxJpNbeX334tSEVs8A+ZXz0MVhcRAlOBNlUx5lG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4R66t1DsrQ8HJ+MNdqyKEJcVQI1bVQcghf1pcjQg+8=;
 b=amjHo4LWT629oX8I4hxNCu1oXN9sNqYXjGGHptqyhRMOCe1lUW9VJSriqD1yNSMOyss1WF3iXsNXOUIjay0jVZ9cWm2In0zobnQaGDEdvFkqfe+59mhIkJC7jX4yyCeXWObzPKERuI4HCfy6fi4a5G9iXSIBCCLAU8HxOkQOt7039Zhhd5vi3Dp81K0dh5nPkv6xP+iQ+qr70tFEn0Ioc56P7Gy/WQNISQRHzUiP6MVdCM5WiWIVbElipU9ORJw5IRpLvcr6xNrIjHO4v0we53yOgODDoHZRKUbc4AjIezzuF6YPJSVDSMniOI7riFMWK8TUwXeAvMMfwQySbxCuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Sun, 8 Mar
 2026 13:54:11 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 13:54:11 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v7 0/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Sun,  8 Mar 2026 15:53:51 +0200
Message-ID: <20260308135352.80346-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: fca321e9-7aad-4f4b-7ac3-08de7d1a2c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	wbG5v/ZiStmxmjny5rkhEIUldGPkImETo5tQyqhR5Qxsp1TJPl/5aG4Ibsh7HE/PWPDhPd3AB2ofMoeos1cgGnJosqyujO03F/WZIZYe7OmFupDckVBEUE5kwZ0AG4zH5ck8i+ccQHpyb144cYzZj8A72bHD2LGWdmWxP8YdsAZXh2vvkozGQny1p4ZEcmJFxSE9DOz+4Lm1C6XwKB6LUa0L6jQ4MpRxH1Py31UAOizSX08eGOf15CwqeZM4bS4uCL8y6tbwgQttucTr9F9+MDFdhXF8TyTMd8RrE9M5ieb9VeRQVqpgJCYQ57KqrcTEDbvMvlAh1OBgP0hNBDmlRFUE4N2ojTGVXoSwi8KyPRWCYmO+3TCie5mcQAOIIr5VRGJ3K+cDWQIyVvA5BAtRWZOMXAHjCV4Y+/DPWbOt3Qkl3QJn6J5WB8fcoJm+DwziSXvI5rEUzpGI1CHFYVs76zhnOw/UeogqX3eBEBDEzNxi4mpqxkivK85AGvIDZRXPvDedw9f+3Ytp1dyLwOwIXW0Qh6zgJfHsVkop2/x5AMVtlIYi7JK5jmKhPihkwA4hk0g5tihjZI4ShWsdGWIaTCZSchoS9JVZcLrEPCWDIeJnFjK4REBrF2kiCFlTlg4JtNA6Dbw1NIWvD7QXNgAfPCprRArlwZDevhlZqO9gb8ROVkBg2i4DfDHIZ++Yw2dELS6YI/J41V+sYdBAsMRjUWnJypP+V4bZSwaz0ADGEGw+ReuFYzjknXthIPXzweHj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TviBMdh3iPeIG1GSrAtcdlYG5A58+NHjwNLGG0MvYCw2Hnj4T0bxIt4ozxej?=
 =?us-ascii?Q?UfDDHv31B7TIugySbn5Q+L8HvynwC4PREQMF7ncWqR3UDpXI009qQObrYGgD?=
 =?us-ascii?Q?uvKg+jXPkOwMNG+jAUSdY3mYufEIy9fIwBtiwIqjmR+l4b6rUX1bUgS4xX4x?=
 =?us-ascii?Q?ZOmROJk/bXsgwkwmHGdi8X/cov0S/jnPTgVeeZBTeTlyCyQSbfvlFJSzmw/A?=
 =?us-ascii?Q?BYLgKAma/qf3uIzYn68cgug0CYprXyaBsgmRwD8pv9jV7J0nNxXJSV9d0TaS?=
 =?us-ascii?Q?1iTK2+Iw1BgsLygaB8WTk45dMxCR2OLr1gsrUC3uW+QwKZWIfKaw0jViLwLv?=
 =?us-ascii?Q?f7gxGfaBW0kQA0wWKKmm1ggZh5YqVRPIsZBPvnni0iL8d5X+JBTU3k5LOVQO?=
 =?us-ascii?Q?YX90OdNplqLJg7yF3LvuTxR1RosZqrrT0xdqBILJ5U+/SpNnPbslse4BIExA?=
 =?us-ascii?Q?DX5fi8oLUr+/mrsbhBcHDh7HWBqp4i/ZpAsVYpfbRuD+WtNItHWGmgXOJT/F?=
 =?us-ascii?Q?ddlQzXLfDh0hXoquFP+rwVzpTleyRA23BNl2Pr/OlIMBL/v99qbhVWnJUFv9?=
 =?us-ascii?Q?wYjJExTGTi17DnSnjdJ1eaqvJZSfHMBd0pvzB8N1VHbmJRUxDv+1UkYis4Cy?=
 =?us-ascii?Q?kysMSaxnaSoQdgasIZHTrE0zd9WbovYpFSvsksnlNuJZNBJk2SK5hZRHt6rr?=
 =?us-ascii?Q?gPOe66og90hB/1oiYIB8meGEnOewce8Mr0QvYSWs87S3gXxMii4Ykoq7CpUG?=
 =?us-ascii?Q?lnpxZWBTvtW6x+YlA+ePeVrfi7Nre06aJPVDa4EF4R72ilI+AKTPF7HvayNR?=
 =?us-ascii?Q?BUFdxZWSYAt9Dz6vgORq0PRdBmhhQcMdJwrvqATdSBrHDeDhsvKW4CzvugRf?=
 =?us-ascii?Q?ipd5KS9IyvuQGHaXudyb6/C9CNXpxwfU9kBX/kmdIWmeY2HLeEWUT3AhYZ/t?=
 =?us-ascii?Q?FYPb0LIGIop7gIjsUAVJsIdxhwizwSg0E0j5ZCaZIkgRrNzrKlZ0LtI+fEWM?=
 =?us-ascii?Q?CkgTYX+gqP1j364hPFWzdWmtjs8O6OP/F/eWwJxl8jz5b3tlpJP5d0JWbJ9y?=
 =?us-ascii?Q?PYMO2bDRo4RdYTcLCPfnu1IZiIoDNid1Dj5+s6zBZezAdX1nFl0p+Cy8LSjb?=
 =?us-ascii?Q?O+p9w4T4FUJt+xSe3aCe4mQiQGbrQeYxHwgBRn/6r+ea7/Evwcc+q04RPaJW?=
 =?us-ascii?Q?NQ6WusQZDN72tF+hUC0EJ8+WRdj6rKI50p9JGisWuISQeA8gkdy3a16XbP91?=
 =?us-ascii?Q?O6Z+c+AGpLEcQ7yroZeP7rmwCaZDj2qB9uvNxLQc1gLPnsq8mHVus1PInhKR?=
 =?us-ascii?Q?pWRScqe3IJkULP1P4yKfdRz8EGv2i11FbOZu0QiQyAzTcnPmqVO3VdIY9bFE?=
 =?us-ascii?Q?cFFlNmbSa4FJjIhdefUH5fqMWDPEIxs9KbtXT579gpj8dDAtqkEqV6EkvYtw?=
 =?us-ascii?Q?3dXB5EY/YtKH7RKnVcf/ZAhI7qqnsAarQ6OJua4A1xiRQ/HGSwCkWz96i4D+?=
 =?us-ascii?Q?l/SerOkKtOWhsf51+mJhXjhWPqncXA+uvsnvdkhEjGNLrJTOVgBoqNSd/J8P?=
 =?us-ascii?Q?nTtVUGMR3CmVy/ddpXaKUTpzU82TxU5SBmFQC4sKfSqdcIaRAjBfRZIPS+Uj?=
 =?us-ascii?Q?e6/0wIFhxQRv3o231xza/CAGlyveWpMLGoMG8H3OJ3q9XtZxuUYOcNYIc15k?=
 =?us-ascii?Q?SO+CzNVoef2vdbJsJYG3kzShxeAQ0tMaWK5UyBlTgc35wq+aq6cAknNzvsSc?=
 =?us-ascii?Q?3bhS6Auz4AOc44H1QHetStz5/T28fwIZdPM4P6zS/5nex9Ie/n4WmnnETSX+?=
X-MS-Exchange-AntiSpam-MessageData-1: kVT68bp4YZnC78Qao1u/YDTGTp7EjdIXDxI=
X-Exchange-RoutingPolicyChecked:
	pT1D0KWb9N5DJvYcXi/eMB/rufs617W0MusrlDlJB4qkDX0T0P3l9kty24oNHjTpvP8Oi78hHzBZaCm8cD+TEhbDARU/71YBO08GkbLJzCL2jwaKNQPbL91Ef0uKA26ds87s3DtPyfY+/O6bojlYdhioOIoqSXbCmAVA/tn6+abzHgm+VsT3C6u5X+KuN0rfBiTn7cio+yfKbHm+C/I26g9puP8ZHeXuuOQLnJK3b7gutm/z6euTLEEWmtlIM6bsLH1Od6QoeZhos3gXsjoC6fy/P1gkrZQgdLdyYqWkQwse9Oh4Rywn9xS/Bm73B57T7Xzk1or+iU9PhXmejCpMfA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca321e9-7aad-4f4b-7ac3-08de7d1a2c9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 13:54:11.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbH5eK2jdNO7y07RUmjpwK4yBNpm0f8we0HeyIUDvAVQ1qYWV0uOXkDjvMbedHf6yxriXyYnLHvVu2BfasypvlKC26gOqbeVsObbCWpyFtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-Proofpoint-GUID: 6NyRH4Y-DgRZHV0yLUQZL9WnnoFqbeVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDEyNiBTYWx0ZWRfX7oXeLMOcwyCv
 X4utU3TMAUaOkmsux9WKYcK0+JQqTxGMc11xBry/q35SAkl2GqLvsXf3ABpnzVy4wpJsO6ynSX7
 wODWPPcG5DbspQ5imIdKPpCWILP4p3K5xm0ihxpDCPUraNMJ+LR+gk0c1a8PhdyAM1rxj9SQTon
 UguRhXlFLpM9JUMRqF6oz+skSmyd21gzixNEgyIfSz90+qAsUK+hOnPKmnRjx49UhSkzZ8o9C2k
 nq4E8BgP88eesWX6mXAccuGPMzj7Glh0v6K5vXJxGeDOV3XWpAu6iGQPvRznhIkbpSIKC5isw3e
 Fjll+4in2MRHDobh2I/7/4rdLZ8LmqGGixQtVdSoTKzaKcpqLkhQKXFZNfJix6I1EQAc3KeMkUg
 cikXt+vA2B9cHCXh7234Vu1t1ELZHGjboAELppjaBu3tUWvq+ig8CM57CcMX2ReFXQtUH6X55eg
 Siv5YCbfZp8cg+FBPNA==
X-Proofpoint-ORIG-GUID: 6NyRH4Y-DgRZHV0yLUQZL9WnnoFqbeVB
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69ad7f86 cx=c_pps
 a=DTw/Ji8TAQQrvHP5vDPzUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=kQKg9xZ15-e5xf3JWGcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603080126
X-Rspamd-Queue-Id: BC9CE2307FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223454-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Bjorn,

This is v7 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events (particularly on s390).

Changes since v6 (Mar 6):
- Replaced local pci_rescan_remove_owner / pci_rescan_remove_count
  variables with mutex_get_owner() for owner checking and a single
  pci_rescan_remove_reentrant_count depth counter, as tested and
  suggested by Benjamin Block
- Dropped Reviewed-by and Tested-by tags per Benjamin Block's
  feedback, since the implementation changed substantially between
  the reviewed version and the current one
- Added Suggested-by for Benjamin Block
- Rebased on linux-next (20260306)

Changes since v5 (Mar 3):
- Reworked based on Lukas Wunner's suggestion: instead of introducing
  separate pci_lock_rescan_remove_reentrant() /
  pci_unlock_rescan_remove_reentrant() helpers, make the existing
  pci_lock_rescan_remove() / pci_unlock_rescan_remove() themselves
  reentrant using owner tracking and a depth counter
- No new API: callers simply use pci_lock/unlock_rescan_remove()
  without needing to track any return value
- No changes to include/linux/pci.h
- Rebased on linux-next (20260306)

Changes since v4 (Feb 28):
- Replaced local pci_rescan_remove_owner variable with
  mutex_get_owner() to check lock ownership, as suggested by
  Manivannan Sadhasivam and agreed by Benjamin Block
- Removed owner tracking from pci_lock_rescan_remove() and
  pci_unlock_rescan_remove() - they are now unchanged from upstream
- Rebased on linux-next (20260302)

Changes since v3 (Feb 25):
- Rebased on linux-next (next-20260227)
- Declared pci_rescan_remove_owner as const pointer
  (const struct task_struct *) to make clear it is not meant to
  modify the task (Benjamin Block)
- Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes since v2 (Feb 19):
- Rebased on linux-next (next-20260225)
- Added Tested-by from Dragos Tatulea (NVIDIA)
- No code changes from v2

Changes since v1 (Feb 14):
- Renamed from pci_lock_rescan_remove_nested() to
  pci_lock_rescan_remove_reentrant() to avoid confusion with
  mutex_lock_nested() lockdep annotations (Benjamin Block)
- Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
  to avoid open-coding conditional unlock at each call site
  (Benjamin Block)
- Moved declarations from drivers/pci/pci.h to include/linux/pci.h
  alongside existing lock/unlock declarations (Benjamin Block)
- Simplified callers: removed negation of return value and manual
  conditional unlock in favor of the paired lock/unlock helpers

The problem: on s390, platform-generated hot-unplug events for VFs
can race with sriov_del_vfs() when a PF driver is being unloaded.
The platform event handler takes pci_rescan_remove_lock, but
sriov_del_vfs() does not, leading to double removal and list
corruption. We cannot use a plain mutex_lock() because
sriov_del_vfs() may be called from paths that already hold the
lock (deadlock), and mutex_trylock() cannot distinguish self from
other holders.

The fix makes pci_lock_rescan_remove() reentrant using owner tracking
and a depth counter: if the current task already holds the lock, the
counter is incremented; pci_unlock_rescan_remove() decrements the
counter and only releases the mutex when it reaches zero. This keeps
the existing API unchanged while providing correct serialization.

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]

Ionut Nechita (Wind River) (1):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs

 drivers/pci/iov.c   |  5 +++++
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)


base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
-- 
2.53.0


