Return-Path: <stable+bounces-148953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0CACAF0B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B8D3A328D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0C1F461D;
	Mon,  2 Jun 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bd2T3VZl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BFPBLnGD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADB35968;
	Mon,  2 Jun 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871097; cv=fail; b=W9shE5Ch8Qdf2gQXR5F12cqLTgeWc9l1rZHMWnnW5FO4nb26+N9styVkHyR0JNz0Lx9rYv6Tbg9W33yJIckhE9hAGCui7kq77Wd1U7JZIpWI1skVEUbk6IRZ248+hIt5oxTT4Qz0oOD4hIrA2RbDS4vio1r3Dvu2VrEw4QQ/Nj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871097; c=relaxed/simple;
	bh=7KXm/z7CT7zrRh/Buax0JKlWRQsq00jPl7oUF6pDLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZsR6a++3wsalfalXtuvRQqUyGXFAX5NcAG3rLr3ntOEYyWhoAUvc4wN+QeADCzYHtPNelOhkqf5FcBSQbS0LbG+jVFQXCjOzHHGZ9XUDMcovJ802gcHoDGH6ng15tjoelE46ae0MTkytXnqGe371sHlFti4zD/jXUpNvhK46LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bd2T3VZl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BFPBLnGD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4UnH026037;
	Mon, 2 Jun 2025 13:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OvXTJ4BjFAUHqRr0zZ
	/lHGFfl1BqcS+rRDFjsqzR3jA=; b=Bd2T3VZllHX0risJwY7OLgVy5T4PRagaow
	fUX9Bxkt7HWhItsfvkSeoLzNzDlgmRolqk8OXovUJMA6LUPxoBFyAL199dbs1Sw4
	mPOkVL5YaroLK6Atc38agBMH6pz06SfmFJ2HF0YthQJwW5ztRgudNKVvYkC31wHd
	O5kWxRaSYqVKbz6gpj6gKaUnsU7ZPSKEhP3B6IY++BNnz4/ohSgNUyY26fiZg8VM
	GkpfVBi7knAwyNGyKW1l99jFXiYbj+PAxeoZE2kX4MPTUzRc6Ajuw4vopFjt3Bmx
	FlCxauLdru/GA/TxK+wl9TMAzbFJRKSwEOwYGPmEVJHv2prCNsfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yscwakxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:26:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552CYwIR034871;
	Mon, 2 Jun 2025 13:26:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr787dch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx8EQ4fE1KCbobD9ptzS53oCMaUUQHl1IFAVXffKOxh8DCaqFqByPhcLKYRqPXZDcsHrFv94SiJ0+nwLt9RDz6T66siyin/WRiSUQWyEK6k5YXSynbXoXy3t9FHJVXH6hO/YSX3qhTY6e6Ips+VFNdjg+pjIZLvnBgejiNrBX+jVmARwKODgibUEvHJDL6JQoY3+IcW9aoGILRC4Vqmd2sfiEXHjyVb79fJ5tYObB2MZDW17M+Yi0zeUP/VHK5b46gEfh21IfcbniDhWL0FYJzfp8VFYu8iFzGEz5J4v+96LsRFw0a73rMtbanJOgIK8yEd/SYdZ6Tg/cQftNU72eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvXTJ4BjFAUHqRr0zZ/lHGFfl1BqcS+rRDFjsqzR3jA=;
 b=AEXPbq46dAtnTUevCu5EuSBtVzPbzOMDX9KbBOo45+YgrBiW9aJbfSV9MZ6M+AapTVRS5TEHSe+d5q+fJ3Wv7PDYQVCjzHG08wdsNJ5lt6b0OnmPhlC7R+48c2iuCNLLDpz+PfLED4D/xzAAZjjyVb3gTqJpBRfKAiuQix4v/Dm33VwgGxbdO4NkZ2Jdof+ZlOxiqo+cD4kQgzA3ZTvCkMKc2zj6z0HkQ37Jq/1qKUU7BP0BACI3W3PEGBp0aRc7xNStfIDecFqLu85RBsWzRw04S9LiC/tsSWQJwCuVt0mNdjPDrDgZVpYumZFgjHGLlUEoeFP5BLhkHzGkry9wXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvXTJ4BjFAUHqRr0zZ/lHGFfl1BqcS+rRDFjsqzR3jA=;
 b=BFPBLnGDEItIwQyGisQKIrB+31oI5PJDm2bTb+l0MjP9QG2442AHlzCqpdduSvfxmwkHUXKJ2YhShU9SPPan48kkA6TyRYBL4BE3+dcq/xre8I99+Vp5NBvAKmrvxRGs6VEjh7FO2Zgmg4pr86IC780DkeoWnfQibaRElTCVmQY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8054.namprd10.prod.outlook.com (2603:10b6:8:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 13:26:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 13:26:03 +0000
Date: Mon, 2 Jun 2025 14:26:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
Message-ID: <117e92c1-d514-4661-a04b-abe663a72995@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
 <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
 <009fe1d5-9d98-45f1-89f0-04e2ee8f0ade@lucifer.local>
 <6dd3af08-b3be-4a68-af3d-1fc1b79f4279@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd3af08-b3be-4a68-af3d-1fc1b79f4279@redhat.com>
X-ClientProxiedBy: DU2PR04CA0182.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: d53b7981-ca2d-4fec-d2fd-08dda1d905df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sn61NRKayGJnUSgzx5Fg67f3CvNx1OkbMTBFKj7hJ9k4Krc7bWSG99cl0bkq?=
 =?us-ascii?Q?qXG22fJHPKaKY6NYJXOQEgZHoJBPzAD7vSg/1TbB0PMmobufZCM5bn7QUal4?=
 =?us-ascii?Q?SBCtYutibHOXrHMRV/8wrcmZ0neGTMpjoI8f138swgAgPCokiqFUrX+w3V9j?=
 =?us-ascii?Q?N5ThaSRGrgtxlAeal4D9S1Y1rsWonelQv/5Y6gAd0jbKVQjMzas9LlkIv9Ay?=
 =?us-ascii?Q?kvErjf5UucR+Lqn4BbHBKtiUDSkGzJxT/In4slQZf2k9jKJthYBAdANon1sb?=
 =?us-ascii?Q?1D+cuQmHhOfyPC06E0CEnSdA/bBfbvPn/N4fvSm4SbERe9IXb9rMHE5mHP+B?=
 =?us-ascii?Q?rgYq8RfbcisPNAPCiPB6nr9FW7+NaivRar3OS1bNKIWvZ7OJPR9s34/QZcN8?=
 =?us-ascii?Q?AV+GV8zG4WNWeeecMGtNG1uyf6an+VUYqcmO0uMoTyMNnJCayaAUIZB/5FP/?=
 =?us-ascii?Q?CF3BZRUnA1lYxyWr2/7zkm5cbp49YbXScg3Z1RpOZ7+2vZx6QCdwSBFZqWol?=
 =?us-ascii?Q?LIXa3HJvv8gdqKIQU/3fvkPmlhn9NpnTIrIJIste/+1bOWvlJf0MF1grUsyT?=
 =?us-ascii?Q?Jggcps0f+B1O1RD4f4OXpdZVH7K19URhqmzn6iCsgiFa9+KQ/XOs0oBIyJ4N?=
 =?us-ascii?Q?+sW/+9dhbu1/YJNqCUFhPn4x/Oj2aiLj7Xws736QpvQy96nlPZBrsAvBQKpX?=
 =?us-ascii?Q?QslVi6+iaDydtiCGL61bxgoyR79p6YmJPbNOg7qqMYOsl7nNS5k6IoYsME4g?=
 =?us-ascii?Q?54zmflQV3iSi473wY3aH5meKfAPnDy+dgEgti2umxJKDxoIj0d5lQS2qHsXE?=
 =?us-ascii?Q?fHjVop5Y9AdTObXj02mD5IdAz4NUEHZW3mTB0fMoAZXOQkLk6nF6zMyIkC1b?=
 =?us-ascii?Q?9bUAQdyVCjApG6BBHhuYac8Q6VQEqv4GTppG/2kEXzmKBX+wCVLWONRSZD6n?=
 =?us-ascii?Q?QO2UQ3aH0gjtWG6KfLO1cc9HsSrdLAjOb0epBTWSGEWLgzhIXkOZ9om8r6TW?=
 =?us-ascii?Q?rTIDjWu9K7D1qYUdovrxO3uW4f+LgJ8yFjqfbEYwV9tZO4shsSJyiMjC6gp+?=
 =?us-ascii?Q?9fkCNXEEMePbLhjdJrF40z3nxovd2H17rFTMMDVm3qEzqaK33pMp+76K6L+f?=
 =?us-ascii?Q?ZWCZLJhgZVa/CnDHW3pzGc2YhBU6X38ull3mdGj+ppgFd4yDaB/62XtyQWDq?=
 =?us-ascii?Q?VFIR4UVLBzpupyJ4OqgoLKLBKoCf5n/2jU0UUgzzRYDH5nrJmR9MyjwH1yx6?=
 =?us-ascii?Q?dkQFLPq5OYMX51c/rtSWx204kbVaCQrkmbcdtAcvKWrdUPgtUVJB3recO1sa?=
 =?us-ascii?Q?T6l2Oowm9AWqYQAJLwHDJ5UKamCTyJsHuAHOwQwFrf5DMTqvwmTEmuTIGkMp?=
 =?us-ascii?Q?VqIU7WtiJ+frEBTpgUeCDuhTAffJevLOe3cq8C+pDzmnaJfX+uMpD7ZLhsj0?=
 =?us-ascii?Q?edB4Ut+9ayQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nVPS1JCTnGTLqm/f6R9hjekMRLw6qTGwZgxefjKM+wt1ivBul7sicUdf2EF?=
 =?us-ascii?Q?3wwNoyaja6pdlGE4U/zrjMG6RAkiHGVDMowK5ByE7Q1l/ORmr6YoQeSakxvY?=
 =?us-ascii?Q?gwEOn24NEe7tCGT6+BXPKNqbitNKAd6fD7FJidvPfJ9U0YiilS5cuUhYyM5+?=
 =?us-ascii?Q?TaSIBtD0TVqZdTdadhIhK/+ezYORrba+wHyUI0afooSgYyGefreryZQvp46Q?=
 =?us-ascii?Q?vjj/3BOh40CG1uGm0gOdB37jHItE0J3V/PfZvPZgrngvznMbqLEqFfO09b6M?=
 =?us-ascii?Q?F70eLzECjdlBzxdt8mb1uX1eS6oE7sT+L9wkCowkavIs34em4UmhK3kSoCtH?=
 =?us-ascii?Q?1SkUqwbxzUbsyL3lt/5p2DmfsoC1B524DwWBxzHKOoonpNtF92oelfSe+HZh?=
 =?us-ascii?Q?iBKQhvjGRvBGexf3RH7Y1AWkw3tuB0oaIYqEKH7OtD3h7bAAQe4qx9XktueZ?=
 =?us-ascii?Q?eG1m2U72sOllZpjuxedicumiBLi/nL+lqclPMX34esfoQ9V/yXbGrSpbFT1Z?=
 =?us-ascii?Q?CSzWrjNdeRmR5js33FfPd/L+GWVnjCGlEa9E57q0CFbw4q1TxWwLN3va0fY5?=
 =?us-ascii?Q?H5W5SN4OjlJiYhVmXqbaSfW9B9TeKQ3OR/XG8cnafLloOurNa8pWOj86MwM1?=
 =?us-ascii?Q?tTwvYQUS/BU65it082PvjNP/SPncKPWuwWmqTXRRQ3w2ArRqUFUtBGUV18A4?=
 =?us-ascii?Q?sgMgMg/cJhOyb8tf0l6w79kKwf7/F3IGP5ZckJUIycdulpZlnXmgHXFwUEcu?=
 =?us-ascii?Q?hnA+/02L/HH62z3rLjI0JYDmLPvAmFXFghoPe5/drKYFZVkEMetCpO9OMx+g?=
 =?us-ascii?Q?tkHc0l+gYvUhVX5TQRcQqc17/rf2q2ITxvaM/mHH74WBugYKS9yC2PqiUzRT?=
 =?us-ascii?Q?cf6GxnjXDbUMZ/W8gD0s/5YZWYtXs944Sa5sn5d1aVAY01LTEICFDZ4NOXWN?=
 =?us-ascii?Q?ZmBgVzWoTOp9mq/N46kJ5OSOSUyZ0ATWHeWD2z2lx0VirRdGK3UaGjjTOnAe?=
 =?us-ascii?Q?pbcuYHKBmUvGFP8+63s7AU9bJzT4VDzWpDRb18BLyBPZSnzvQdgclPG/abqR?=
 =?us-ascii?Q?Wf8zwY8ovVC8p2ea1svR+nYWW45PyUWmQZUivv5/ELQAq17Bx6ajAtMTmwXd?=
 =?us-ascii?Q?M7B+9FuXNDcWDPRciFwjLLf1iXuoY80ROXf1311w7TvTsFEO6e86TO/22Ayi?=
 =?us-ascii?Q?3p0XN+4iktKLGyZ+JA7cWZ1Za7pAzOZhwXwOA5DzVB6Zt2eVA4v1ZLrbxii5?=
 =?us-ascii?Q?57MuBfWTdlTIoN5N9y0yiVPrbmMqUfeuZQLsKaqpI43IkCBbeB6EVAS6Vml+?=
 =?us-ascii?Q?j9hb+vH+yTXL0XbPmEpbvgqpxZcNoAwgCUHYPnx45lYuTbYVZq58gk3HRRjr?=
 =?us-ascii?Q?MO+KznhCKNIcpIh6BIxBkLXNJsPtWrXcce39N5ZhDHlqtaBWE6mtsrLPf3qS?=
 =?us-ascii?Q?JYWNNXap1c/R44mtfPeRgE6H0WtJuJzxbDR4kU8R8U8+pdLf4Tz7nL62LMAY?=
 =?us-ascii?Q?xVlg4t7o5jmoZo3WMf/x+fnY9U4tdmxlc/EtaBS1AURMojmf/Jq5A7xfOW7X?=
 =?us-ascii?Q?N0CuRZxdqVfwaAkzX1tmHM8jSbLpMHxX/NNIQ73w1af/vR9DREztyCOEVA/0?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eOLY9f6fgDFelHC0wGI6xoimACa5SwlsdCUxRvEQZ2MyOgz0Bng44g81oYQw2dYhht0TA7ILeNLvcWb3Uaf9GL+6rkQx22HdFnRcIMCPrMceo3ep1iNYNXdzrXWKoK0V96RpdyTzNcy2gkIprnWlxUAtJT3ODiJYh+nAN2xZzWBs1TL8UIPtLzLNMpbxkCBpcIe8jf7Z3HhCmwsAs9yTcepSZ+4ryrWZCg4iNHmbvliJPvNuqwm2NxVyVSHxLeI5qhRTp5fW66LYHZ+gRbxa+SCFhrkOZva4YC9gvpRgLUJYjnGXXKt2qouh4eSkUiDE0AG7P1QjcJ7sWL9RWTnU5XzoPRncEy76wCFMIk1gYJb/ieamjkT80KcaCM/e4thRov4B8fwdGSunpFLladtFfGcPVgM7aKT5K4SWv60NBo7ya6NTG5rRtlh8xAz6n2IPfrtDD52VFJaitJgbv0fnHp1M2QRU9bznNsUaG1ngDayx6Hr5H3Hx3VS7GQ24yi2/qRwfoN7gy6tuRp3PS8WFRUBlzeUgMBVl8fTLa5Co2X7jySxmDKAvucWzHnXVi9lDz2zdeCkq7PM4NxbEN6EjcAyhmnT1QIrn7rcDxKUoOJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53b7981-ca2d-4fec-d2fd-08dda1d905df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:26:03.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvVzFxgOiYO6jS5ygvcyb5BI7vfKK7rIRzS5Q1bt7SWqw7+CntvEVAPZfoE0nch9e6fBimsgucIG88/49YHSD03KyBfVKgtRW4Z1BPBrnBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020110
X-Proofpoint-GUID: mN2pKe19DJUzyTQtFKZTaxnq8MNx7siN
X-Proofpoint-ORIG-GUID: mN2pKe19DJUzyTQtFKZTaxnq8MNx7siN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMCBTYWx0ZWRfX3csy6csyH/Th IViRW1gNTKbB5vW3a8yqb25QsDcV5tg1d23JugEJDNfsw0+phR+mH1pkz1HLwwNze84xBToF1Eh 2Q10HFM1uvtC3uQgCckyOfnFUXbKUiSDFuo2/5Zuupfhnv4wf1cu/+Uf0E+58VbABKu8K7W0vxO
 tk7sHWCSSw7WqesNK21daau1J+IPW4GpnmPdlUWUFdmM+uJ0F3MuQ08xJfV2NZbTmNuEP3i6LCC jLQxpxMDQmpvNiEWLxsKBBfoGCY7rNuULBtND0JBWewmOv75MmZYeLRmSdr8GdfBDZ9kJsA1Kwn cEbhOP6Op5pN1omVDyXa2JlcGw9Z+upb8pV3yXqOWynuZ+7aG5irM/fKJmY+xbD3xNw4VP1MmKW
 Au+FXRs7xkOqqBD0l7S15Q74wP6FD4ISP2hYaiHBYPyoxEJlD6tzrht/Hu0IX/ab06qPrCmY
X-Authority-Analysis: v=2.4 cv=N+QpF39B c=1 sm=1 tr=0 ts=683da66f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Zz_v1E7BrEJzXcIT5VsA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 02, 2025 at 02:26:21PM +0200, David Hildenbrand wrote:
> On 02.06.25 13:55, Lorenzo Stoakes wrote:
> > On Fri, May 30, 2025 at 08:51:14PM +0200, David Hildenbrand wrote:
> > > >    	if (vp->remove) {
> > > > @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> > > >    		faulted_in_anon_vma = false;
> > > >    	}
> > > > +	/*
> > > > +	 * If the VMA we are copying might contain a uprobe PTE, ensure
> > > > +	 * that we do not establish one upon merge. Otherwise, when mremap()
> > > > +	 * moves page tables, it will orphan the newly created PTE.
> > > > +	 */
> > > > +	if (vma->vm_file)
> > > > +		vmg.skip_vma_uprobe = true;
> > > > +
> > >
> > > Assuming we extend the VMA on the way (not merge), would we handle that
> > > properly?
> > >
> > > Or is that not possible on this code path or already broken either way?
> >
> > I'm not sure in what context you mean expand, vma_merge_new_range() calls
> > vma_expand() so we call an expand a merge here, and this flag will be
> > obeyed.
>
> Essentially, an mremap() that grows an existing mapping while moving it.
>
> Assume we have
>
> [ VMA 0 ] [ VMA X]
>
> And want to grow VMA 0 by 1 page.
>
> We cannot grow in-place, so we'll have to copy VMA 0 to another VMA, and
> while at it, expand it by 1 page.
>
> expand_vma()->move_vma()->copy_vma_and_data()->copy_vma()

OK so in that case you'd not have a merge at all, you'd have a new VMA and all
would be well and beautiful :) or I mean hopefully. Maybe?

>
>
> But maybe I'm getting lost in the code. (e.g., expand_vma() vs. vma_expand()
> ... confusing :) )

Yeah I think Liam or somebody else called me out for this :P I mean it's
accurate naming in mremap.c but that's kinda in the context of the mremap.

For VMA merging vma_expand() is used generally for a new VMA, since you're
always expanding into the gap, but because we all did terrible things in past
lives also called by relocate_vma_down() which is a kinda-hack for initial stack
relocation on initial process setup.

It maybe needs renaming... But expand kinda accurately describes what's going on
just semi-overloaded vs. mremap() now :>)

VMA merge code now at least readable enough that you can pick up on the various
oddnesses clearly :P

>
> --
> Cheers,
>
> David / dhildenb
>

