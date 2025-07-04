Return-Path: <stable+bounces-160210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEEAF966C
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F7A58769B
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E42BEC28;
	Fri,  4 Jul 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUukQ3ng";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zRqKYMhH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5D19C54B
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641843; cv=fail; b=k4Xrp5qRB5zFZAawK0l8mhdZu5zADgfXTDjaOXuYO+IhhJUlRjNMlbbjiOTEoTnKUSCOYxIYPaY+gJTQz9grMz72cPWN1QQEj9kuRt89Q4CzNwNVJ+/F2dAAGAZLz0Zz3OYpwASR32Fm/5xs+bw0XqWnw1ec+AcxliE1MZP5G4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641843; c=relaxed/simple;
	bh=SwQEfusMMOuu3bNm0fqtMuTTSWVZBhtrjEOV6yhd05A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ce3tdXrezmj5mzlgF9ayTmiZLZj7q1Kt84seEDForJqx1WNU+Y7xca8SB9yjQMfuzU45NVnPBXwXAU/YjNFZPtqwLvO38MkneIoBw5Zn5675UBKmfwAGGnMu1Ualpx5r0g2iG1Ck0q9VqXXoO5pqyz0/Sg+4ow5qkUNLemnHuac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUukQ3ng; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zRqKYMhH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YuDh028316;
	Fri, 4 Jul 2025 15:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BOrp8HPOfnEPXduglq66eE2ERpx9yOP7XASec0B7tE0=; b=
	mUukQ3ngHO0tdDPyOQMWuHvNUg9ZK1RxxTmEtyqphcKcabMrcNXhg/6509unyrey
	K3KlTPg45lutkk68xg/XOpLQBe0kftKK8JKb7ppa1bs6cwIC6wqJ/azm+VUgYXQN
	svsOX/NcehbCSlvdkgo3QAVCAYp2SXC3qGlUoyvV3+X1SaEYLq0C8Dcix6XX+nzF
	36q9SH1C3oMjY/v3tC+wXRn5c4dAWVpS9XH6CEmm/BkarSUeOJ4Ftlfy1QCe2vY8
	MTh9Eyaar0vH2OgBu55ej67IFxzVMW73FIp5l/zvMnWXk5eD7Lu2W1XJobcb5E+h
	6bHX2VU9xaqE7tpcsbrV2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum82637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:09:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564F33LA032567;
	Fri, 4 Jul 2025 15:09:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6un6ug6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/zUFl79u3bRrm4W0X1oNkFAbcMztv09lvx3RQLPNWiBMGZ3V66chtvmeq6lB3Lf7UQUCWRfjmGMUCLrXJzyxo0QW/QQ53BuiHjBO0t2xeQ+PLclPEXTgj0OdSm9jEjOzw5f2ZOPDrtHTp9iQ7fQodbMow6nVph5j7GOSfeprE61jlO2a3590vqk/TouXINkNrEljcOYPJ8/5r6KcZf7Qn9J14qRcgVKyVLJZpGCL8FTlUMuVVJ5irVJ0gJKdxPzZ27drGrkl176KGn7UWEEhDdxxQQIBbVjsIUmtko0CfcWERWCT0sl0mhcLLnIIbVpm5K0Hn9zE9kqRzHdrGJMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOrp8HPOfnEPXduglq66eE2ERpx9yOP7XASec0B7tE0=;
 b=gppQVeiHNRlbZd9JQ7niogf+KelqVU99Sgv7RSg9SBvZ8vGd61rkqxNvr2iaVvdtgvOaDX52DrbsSVItZLPLuwSWqqeXJXyVSg74tsW+CWW7p62q0ti2vkk0/5xZskKfZRgx8uyPyceLmOV6eE4YrJkPwypOHPm2uM1j0BGQypYtyjBJ8juJAVC3XBODVpk/QltrZ9VI1+dKCIdr7IO8+j51OXR3LDMcODS5ghmdJqU6upQza5j3rSUDzh+01vFEA6BAL4OQM8FDVLBJkZbhZfhzZMu90AInAEEzrlSMA3IMPGCAbypiGLGEJpLX6TqLBmg/v0wkzwTdMl84286Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOrp8HPOfnEPXduglq66eE2ERpx9yOP7XASec0B7tE0=;
 b=zRqKYMhHxKW2NRo/+6hsGVESjcJ6PQWijSjXjNQpWVpiIKnbq5SLyLp75VNDu9lbj6OuxnGNl33nji7NHjj0FQwnzG5rdiNSuhIAGurKhsp2MrMVsbUFl1pBSScqtm6vTzuZ27mOsiwt3hYKhEcwutLtODJUVQQnViGdjKVzWxI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH3PPF46347F8D1.namprd10.prod.outlook.com (2603:10b6:518:1::79a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 4 Jul
 2025 15:08:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Fri, 4 Jul 2025
 15:08:58 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: stable@vger.kernel.org
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Hailong Liu <hailong.liu@oppo.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        Steve Kang <Steve.Kang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
Date: Fri,  4 Jul 2025 11:08:26 -0400
Message-ID: <20250704150826.140145-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025063032-shed-reseller-6709@gregkh>
References: <2025063032-shed-reseller-6709@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH3PPF46347F8D1:EE_
X-MS-Office365-Filtering-Correlation-Id: b94bf4b2-645a-4585-dd2d-08ddbb0cb390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RGQZcqOMuxLuf5krFKcdXboBSLIXlG0iPJwG9D1LFOKO7S+YdeqrOw5FKApr?=
 =?us-ascii?Q?aGZqHTk5k98YHB/LfGcgh2F78Uq+JzvLx+6BFXHYUY8erdqwFgzSiP/Z6lt2?=
 =?us-ascii?Q?X2hbGFRVfZGiKUOSTjvOcKS9XZJOhQynT6EVoWfCCyAKPmbuFUPnW72CqD6W?=
 =?us-ascii?Q?IOB2lZV6BGIsF8L6sbhhzkn7AxnZaA9eJTCbdUFrKjjr9VuaTyCw5FUpqXjy?=
 =?us-ascii?Q?T1BtjAB6TnnB4qfY9CZjCQYBuoOeKvE5JSW6S/0jOZXMftH54OFaB6p3qyJ8?=
 =?us-ascii?Q?/YQDDIpmNHIuLAlSsvLCnO2ADuApHTQHNREo04E/UgkVqdcyClwkm8hARxK+?=
 =?us-ascii?Q?5OkS5ofXtPkUM2LMpzrZGjc2zMhax4rpOHQdqyDFEqtvsGfy3wj6TQ5qNkAd?=
 =?us-ascii?Q?b7XdOOrsy0Ipz91vv7MZ/ggJGh7YsfD7FS3eRJDYXhoPK4lCpclF6gYn7epQ?=
 =?us-ascii?Q?LBb91kALP+cI9jC5MxLYej2ex5H2oHoUqePczah9NjdbxhfSaPnL0Mgb03UZ?=
 =?us-ascii?Q?Md0c/wsqDT/jyz209CDrCtzXrjh6Gt7Wr9PobwzrZnbD2hqyOvABdx6aYHhd?=
 =?us-ascii?Q?xly/Vco6mYmLuWYjk84mg+GRhBOzSuLkAvtv/OfvRve6NUXwDSjVQrYXliPm?=
 =?us-ascii?Q?5g6+wOJXp1eK7REwbAoE2U96qmiZR6A5epXMGO+UXIk2dkO2G0LWnTnxQ2IP?=
 =?us-ascii?Q?T5/0xX0ahxHXL7zqW4bgh7P4phA2Om23cvtdODI+rOzqD/0wvf4Lp6VLi4IT?=
 =?us-ascii?Q?VUIkjMgi8343Bw4NiX9iYSBGJrRekqE6hgQhcwJRJFik126X+Jx/k5MDudbB?=
 =?us-ascii?Q?yMLRGhWWlRa2gXJ3r8wN1E5SM922YMeLEUQ1BJhgFqR5vWgi/TSUSVCJX+z3?=
 =?us-ascii?Q?QCX9TuX+8Zyl66FU9iBqg2HWZ/jrSHQZ5YnF1lpJrVfzOL6kgGdEmrsYQTCW?=
 =?us-ascii?Q?XCl1ndnvMzbyckzpgTmgLWuUWwwK+MqsmQGmLrTTPA2OXT7ZkgZR1310R+k3?=
 =?us-ascii?Q?J31jsLo6zzo8tDX7rrgJ6UjL7/eBBF1oL5m4YgI6MVARG+/A6tkhVdiYycOV?=
 =?us-ascii?Q?KnvyKxWi9xcULMHS5Jn8kp202o7j6uJJuRhSjSpCCWp5Xj3pLxBZN6dqBfSa?=
 =?us-ascii?Q?LrdWFc4pKQGXnKzn/jW9Ctyfm4QxMPIzybBoPynjxcGcUQwQXdldg3TIdXaV?=
 =?us-ascii?Q?K8LYT/pGeQVKHOpiy5HzJlGTZJICVjPX0OIDDq+hIjXdKoCg3G0+uv8+sntD?=
 =?us-ascii?Q?x1m5OB+5+/Bqgo0l2jgepxu79Sofw/laZbM/znNUxr+rohL9B3+iNf7e2Kub?=
 =?us-ascii?Q?xVncw1nlXe9lE+PD9HbNfbIFeyOnaLj1uXchICPBgZlVHyFUfeYAJuSQL6Yl?=
 =?us-ascii?Q?Rh+ov5LNFGwyqRlHMJUkWMT+TBL18weItzcWXbT04vRNKPuRmGBYSM/pbQ1i?=
 =?us-ascii?Q?1O20qosQvZvDYqapZuUpGkF+QTXskB7B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7M90eQy9vJpGi04xrZ/eDU+rl36vqkQW4oh/quYStuggx/98Utzh0cNcGZ9T?=
 =?us-ascii?Q?rqYd2vdCZU17vNz58x1p8Ig63pTQ0YJGyF1oxZ1BtYrMStEYc5qHf0kTRxqW?=
 =?us-ascii?Q?x5JpLqTsuq65yNf7W7dCee4+kzbD+qZ2fJ1vMnxAH6IfHXci/eanvgp97HKz?=
 =?us-ascii?Q?Q+jKgQADmPHoVUbfDC31uHvAihawx84pTOCz+7/fUSvu4M2pSWdvmgK5qaTn?=
 =?us-ascii?Q?xcWNmHpvV/kvxJ/9NEFg6jX3Gx2VM5x8JejkBEao5i6pHQT9VxSQ+BrKuYYQ?=
 =?us-ascii?Q?07u/KoT2bb31Eqw14y12gqiPQ15jQgESKhBOsMFwNDFeWUXkG9pGINmZ6zpw?=
 =?us-ascii?Q?F3/hb5RC5Acb3i5F8v7ME25Q7b+F6gseBZJZ2gRo4SO+1B1/h0evgH4oy0Ah?=
 =?us-ascii?Q?683VHakzB/P1FOZLkKofV+SqIjfNrdcaPiqN5ai6Gl6zj6yqQMeK2X8S3Gnf?=
 =?us-ascii?Q?AanSVBceYbzlD6jYxdO6E4EnxxQiMM5RqhWSnxLaaxR0UqDOyGanmD9u51zy?=
 =?us-ascii?Q?xNmi+c8UeI44UJ7VPB57CBZcg5r3tjZ6BOQLtho/w/uZwTWc90IogjqrrRS3?=
 =?us-ascii?Q?+xlLYe+ukXRjalhrK8GPyB2xco1uftMEp5LQq2MB+mpzjaizV2kZIizwIGKY?=
 =?us-ascii?Q?SY2IVCncYFq35S8yZGkYLIB3l7hSqESusEEoDTDvtyok3rZ6HR8+bia/qaFo?=
 =?us-ascii?Q?BL81fme8ITGxwtToPRbiueFGJvE2Zaj3zO2AjIxL3RZRtIhrFWDcHx0DIYqY?=
 =?us-ascii?Q?Ti39U1kJXl94B/hqRDtyxezv4k+AI8OdvNIo4dNIywaEXdyoysCQZL0P2NdO?=
 =?us-ascii?Q?Yfg5bF7aCVB3poVq8SgBolUANacg4xFeO5/v6LxGZzgAnBE/4FtsBsDBWRVw?=
 =?us-ascii?Q?8wqSVIH1bGzlmd1caORIuQc6DH6tNBOsl0BkNbGGRLk5edwOhUTjt5f9pyfp?=
 =?us-ascii?Q?Wupmz+onBxUh0A2uhbu9ymvMbcOG0b3S9mwKxWNfs4bedbWRI5F3AB09P3bj?=
 =?us-ascii?Q?+uN094Oiin6tWNoRrLeiqBrvx+8u734GEfxBSw2uNwHdAH3KNn0998ywF0+F?=
 =?us-ascii?Q?uNSb1YdlYGAuqWLvBQI8bO27wT6zd2NJsxJ4J+iRdGO+obXfvyFsh262QlVy?=
 =?us-ascii?Q?UXKDuBw7wb5uTNe5E/j9C24K6BiNaLRD7kEYVH2OGu0/Xb4vDm/Q37qDnwrF?=
 =?us-ascii?Q?CwiBtT/+WwpzI5Xof2VTCjmQe7gLqCPrr6lERGTZAf6iw6GXlEU7HMU/Ev1p?=
 =?us-ascii?Q?WcwJI036vBDoLgWNeDV5lcdU+1XWcutDqCENiJ7BiwDtKwQJVqxxVxg1T/39?=
 =?us-ascii?Q?736tlilDf5OxZcykH2LVXGyDhmb2miqNb6DoHJCAO+vIi7QEEAKcKlTxPB5Y?=
 =?us-ascii?Q?38eselAJnDm8uXSrGbwQx9JhP1LZevYWE8pI5x2zT9kx8Tir/c9r9a7o4oTF?=
 =?us-ascii?Q?p2/sJIMGtu5RgUURearqI3oArHhXk4QcVhfxq5dyKDDrFmn/1jZbjKazmIxn?=
 =?us-ascii?Q?JS+IvZ8c6vTppC8EMYuivIStBT1tW6nHowAQMPmHuMyl6XKHTO/9IotXRqBo?=
 =?us-ascii?Q?DoGpyD+2lP/C6cXQssidvu/lEWxLKRHgVPJyrW3s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WuQXoe8+tCO7SDh19c8bWk4V9ThGcrJjWrcnEWVI51H5mTHOe5t5hqw4G6WKTZljv2vKqhusbSOrFhHxtBYPAceJIZntys3btRGjEj5Kxw7S85P4HwrjUzAi/HBygCKKzSL900XmOqXC+QSXX9A5WWK5+SUTnwxv4K02KN1UL9WnfrwqFtQqXBxj2g2LGYEusLWV/60IJbc9W56Dbly4YDve4lb2wSSEoO++FgJdtjuybveMvGaU0DjSC2KddxFHnTiZMmKXzEgr5U8iANwzbtjrKkKw7JR7zdE52A4sSOsAszLmXntJkCCIrpbNGR3BRHh8pA6NNlY5KJaEL9ew4Jpy8VpIawnrBvHl6sTpKzzqwEuXOz24aus/EqeHJDODDw6lcpQdl1F8iuivJm9Ggmd9fN+qPYLSFWg20yEQQmMyhVU9efTR/XzjQ8dKbzFMmb4uiRU3XghTPjJLwxta9LVzSp/rL2My3zTcgpepn1huWoGAeVp5l4GQQeF82Lv0J9taMNz90t993UAkFnI6cdlBT6FOxP11urCnzA4u6hy7rOZvCdKw+dGeAAMzNYpPbtqDtid6ZUiO7a8tibyLwAtLgAkd/CaWtdKqUqfz4II=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94bf4b2-645a-4585-dd2d-08ddbb0cb390
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:08:58.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdKqoNzEhkmq5hCEpX3Fxk6UJoYRl/B/7Wasx3HXxSt6Bx9D3kXcO9+6QdKR96B/EcybNTLVPq2NT0guXugoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF46347F8D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDExNCBTYWx0ZWRfX/iAwrWy27GWz kyK8CblYaW38wMFQgLN5/O6EJJpxqplqLynSCZ6EVbGmd9XlTKsyVQsB8Jm3TfHT4tkyPZufolk xzhmHO0d7qE6zgYYD0AitGEkten1IQC3de+ll5k/ZR2/u/I63r5Ztl1xjuqmEcpdXy9kJDIEQrW
 JvbGogeKNI0cS9/OMFn0pqrnZg3m+PAYkpzcMFyhoN3PZohZo6BaLuegRis/gbGI1uswcHJ1ZRZ ikIMariwt82cho5ydV+9nvbdKoBr/vu59aIQmBYO1JidDV7jB7s9NTMw4YqmyWurRqUizabU648 pQLdZFai3zfCl8CH9jphbTygIE9eTvIh1898PU8snsENlk98A3vCSzLd81tDio0wM7XEkDjhpYC
 O0MIOogsPzmVCtwuhYFDCJ8hh63Pva2JgzL1DL+KLLrmPQWDLqXeNR3Cky2i5B/2pyOo4kKc
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6867ee90 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=A2pY-5KRAAAA:8 a=icsG72s9AAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=qBVN9rlWmg4_UtZo-wwA:9
 a=T89tl0cgrjxRNoSN2Dv0:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12057
X-Proofpoint-ORIG-GUID: g-iDu6olTNCCu3fFcuT8a1L0iumnlMi5
X-Proofpoint-GUID: g-iDu6olTNCCu3fFcuT8a1L0iumnlMi5

Temporarily clear the preallocation flag when explicitly requesting
allocations.  Pre-existing allocations are already counted against the
request through mas_node_count_gfp(), but the allocations will not happen
if the MA_STATE_PREALLOC flag is set.  This flag is meant to avoid
re-allocating in bulk allocation mode, and to detect issues with
preallocation calculations.

The MA_STATE_PREALLOC flag should also always be set on zero allocations
so that detection of underflow allocations will print a WARN_ON() during
consumption.

User visible effect of this flaw is a WARN_ON() followed by a null pointer
dereference when subsequent requests for larger number of nodes is
ignored, such as the vma merge retry in mmap_region() caused by drivers
altering the vma flags (which happens in v6.6, at least)

Link: https://lkml.kernel.org/r/20250616184521.3382795-3-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reported-by: Hailong Liu <hailong.liu@oppo.com>
Link: https://lore.kernel.org/all/1652f7eb-a51b-4fee-8058-c73af63bacd1@oppo.com/
Link: https://lore.kernel.org/all/20250428184058.1416274-1-Liam.Howlett@oracle.com/
Link: https://lore.kernel.org/all/20250429014754.1479118-1-Liam.Howlett@oracle.com/
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
Cc: zhangpeng.00@bytedance.com <zhangpeng.00@bytedance.com>
Cc: Steve Kang <Steve.Kang@unisoc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fba46a5d83ca8decb338722fb4899026d8d9ead2)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a4a2592413b1b..27f55f61d88ec 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5497,7 +5497,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	/* At this point, we are at the leaf node that needs to be altered. */
 	/* Exact fit, no nodes needed. */
 	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
-		return 0;
+		goto set_flag;
 
 	mas_wr_end_piv(&wr_mas);
 	node_size = mas_wr_new_end(&wr_mas);
@@ -5506,10 +5506,10 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	if (node_size == wr_mas.node_end) {
 		/* reuse node */
 		if (!mt_in_rcu(mas->tree))
-			return 0;
+			goto set_flag;
 		/* shifting boundary */
 		if (wr_mas.offset_end - mas->offset == 1)
-			return 0;
+			goto set_flag;
 	}
 
 	if (node_size >= mt_slots[wr_mas.type]) {
@@ -5528,10 +5528,13 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	/* node store, slot store needs one node */
 ask_now:
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, request, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
+	if (likely(!mas_is_err(mas))) {
+set_flag:
+		mas->mas_flags |= MA_STATE_PREALLOC;
 		return 0;
+	}
 
 	mas_set_alloc_req(mas, 0);
 	ret = xa_err(mas->node);
-- 
2.47.2


