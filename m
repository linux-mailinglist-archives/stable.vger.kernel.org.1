Return-Path: <stable+bounces-135099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69441A96835
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A2917BE93
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EA21481B;
	Tue, 22 Apr 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MoW7v6To";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SICWnQQv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E113151985
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322771; cv=fail; b=V/NdaFk/31YkyFo/fA9qlFlG1yiGIGk0k5eGDaHtj5fCgNHEvAl9vqxTQZHSD+nyk+K0iqzA7Y/oWl0IQvV1J3wKbotkG2gzor4Hlo9ZfetcdC0ieGHPEh/NYGI5r+LdcUKK0lIwPqRS0wSd8OzINFXtq4fI8/RFqA6ujsL5nas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322771; c=relaxed/simple;
	bh=sHelH64vvOu8x7kydGTL1LFVqkNnT4BLUtdop353e1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AsyA1wXIzrpBO7sVZ4lR/DxuPLNfn87ZkdYnKUxATDqSi/0nVt2D6UNj+aHX2vfU+BicQthaigcFZADBZPfIwMfmNtLecxJjQt0KyfVLM1HY8izjmnty2OB5ty+D2CTN63WHzTPIE2801jCoReIgJQSaNzkSYUXLvlfQyCzUlu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MoW7v6To; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SICWnQQv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3DBi025764;
	Tue, 22 Apr 2025 11:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mB2QGMtI/jMN5nY/lit6mCoBdOpQzhucJBOxMLbOUa8=; b=
	MoW7v6To014iPFqW/nHLOKSKfhIymjt4ZypRg5iJ4gpmoyqEmkTmGtdSctIPl8X3
	a3NOtDD4lNYFVH71Tx4T2kxdl4ih8ZaAviNmApZ6tQ2fLc8G2WzfFB4UpKuqylNe
	LwTxr9gjnE957jrFs0ncmQ+uhlEyTbBfKFTkss+zySyLmjoNqWK2J8hZcupT+Lfd
	RVgWINvEN28J1NWPI2uQ+z4p54JY8rvbHkD3lE08JRPeywI2F7YyPPt3CLwg6Uu6
	rlAO7JSV7KC8VWS6UxDR7mfRcnjDW03mY/Gjp7s6KUJKUdCt+UYmGXwOuAPPl+0g
	A0LpA7U+vRW6ZwowTIsy2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csv9yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBZ0Jv005771;
	Tue, 22 Apr 2025 11:52:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dejeyhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBsbKR6LYnUmNcEgEL4EiyLAdO752LksWL74RbR4x4/BuqBOyCLRIQiA4gfGIbNpmKrJQ+lIljVFBh2Q1RZRJ0EuPgdtXAiSX4qiheVWGrNLPCEi69wzaWgZJ8BxDyI4zRMuYuzC+5HtPNKR8uQFwQ5oBDQ6/PfmWmf4Ze98fZJe1JKJrayzCfz12Dhh4aB8IFjOb3sG6Tw9KxeXs8ISEAF1SwFuvglTcRHf6MNE+ksSC465gYb7MEWXSxrTFBboD/cwgyjGQvSXhFsjYQf7imiiRqIJBJIiNnkk9JUWbK9wE/zfD27+mpsIcOpCXjSL9ZCUas1KLygKDBf3m0NQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB2QGMtI/jMN5nY/lit6mCoBdOpQzhucJBOxMLbOUa8=;
 b=bBUTLous9moYNFK0kowWZuqwS1JFEID1zb0IN0IddXrjZ+TjbiCP5o4oyVGqeKw45BuReCbQ1fmuF1yKOB2f7crIiWbiBt8/6hsKAqWr7gjFn5US/32qiFmvlCetiUDRKE6Brd+7Fiq4HMVy3x0lY7NMtUQamvyv+U+Iyl8zmLo0uEH5pHZW+IRJiUq2mxTq8IJDkkVLAmzTy5706CcrOtQcIm6eVIZvSp+pl7ugsKKgX7CKqo//bgixdEHXXMS5eL5igfpt+NoD0dMRzJDr+NkSf558zxFgqwzg7XDx7P6FQk4g2sAU05V5OGyALH/ITdYfrNExtBDzY4H1cQa5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB2QGMtI/jMN5nY/lit6mCoBdOpQzhucJBOxMLbOUa8=;
 b=SICWnQQv+QwB49CBea8aFodWaQ+eJ9MYcDXRMjmzu72/4kvu2b+P+1hguxp3MLHGLcvHPZXxifRiZCy6YC6gqjmVcVXaQbCENh1BA3/o7c3XVATTUItamOg60Dv7xkBJcoGrawOKZycuwrrJxkUuzOygFzbMTiYQ+3PQJMwEI04=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 11:52:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 11:52:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 6.14.y] mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
Date: Tue, 22 Apr 2025 12:52:26 +0100
Message-ID: <20250422115226.149137-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042100-pasty-liver-e6a7@gregkh>
References: <2025042100-pasty-liver-e6a7@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6a0433-a733-46b3-6724-08dd81942eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzBZD1PGnMwTzBvhxxRSRY6ptT4CZk3U4pyB2NfPlvoyKg+FyHH9+87kgQPt?=
 =?us-ascii?Q?iAugb3YlRE3YYmhJeG3IJXnshWUoAfP2/B68ymVKrcgnW6cImCz0qaQEhkQp?=
 =?us-ascii?Q?oQIIwOe5xNsKSR3pXRc8b1bzHKVp9iqBgMZG+pcqcREsALXqLUgyvVXtKATr?=
 =?us-ascii?Q?aUvJhoUL5+g71QUyIDd79YjBZwjobcabj36dAi9qnj5nfG0ShF8fNk3lrVBK?=
 =?us-ascii?Q?TjB0VP/0JjB8jqIpv+43ym+ZchvkbtdCUfT0p5ZDFaFXy79xY6d4KkN/qZoZ?=
 =?us-ascii?Q?hydW7C8udcVPp2dO31Av/6zjYz4JjUO42wEbu1n23gZs4Ayah6APVAaKlaLE?=
 =?us-ascii?Q?8lRilvrsUX/aRKjWTJ2MSc6EhVGs5TpULJ798HAtJtrE/GDMUdGGRrZ5BHd5?=
 =?us-ascii?Q?uMmj99J2fG0l+JsYExQvzti4rl+F0Xze9ljv9cMN4Nv/WjFAaEj9CB9bAMfX?=
 =?us-ascii?Q?xYGFfHeFCjqJnR9rE0qqp7cBe+Gcq76CWMLERo5PF+DLj/FN/VSuCduLGDtd?=
 =?us-ascii?Q?f636lwRhmV3BWqUIvmHkX74Qzw/EJCNcse6dEaDPFYbTBdOHMpjBUndfXJyD?=
 =?us-ascii?Q?879qVXTQztsNxh1sBzaUFSCDhvqfYxkzKqABMZ0oRJqem/OeE8mOSbfkEMrd?=
 =?us-ascii?Q?1hnl+oxkQ9EP+O5ladyE5HvNpeO2K7Ckh/hAwO/Hd/op5ZwazfDwwlxsEY62?=
 =?us-ascii?Q?aAhth3j35Po7dFZsZtkSWBWJT+wlDKvg7PTFc/U4pxjsfOucymkQOcPD+HsD?=
 =?us-ascii?Q?ZB8k6xLpDrVwvEJjsup5gOZWMzAAwZX6vDfqaIlSWeF1EsPyIumcoUypkyP8?=
 =?us-ascii?Q?81Rw85aFP1IG0ouNTtCmInGy+zVivZie+NfH+Y5XclL5mIYY0GkUJtJhRQq2?=
 =?us-ascii?Q?igVk1NtDMjs4vXJN+Eu0LLXTOBzNVu7OCZTM+72ON9moYLGFEqOvfkM9BW1h?=
 =?us-ascii?Q?sfI7TbHKv8vXiws+JqnoiKULgyyIefA6LNKEDyKP/CxckgejvS67DUBFcoGE?=
 =?us-ascii?Q?rsL9kHxtnWXaKtgVLqmPi721JBxWNAcap5EUN0p5pekpbuUNOAWAUAzE8Bwh?=
 =?us-ascii?Q?kbAwqaBMk6EZXTHPefVGps8SZoP8PrG2MznHyzvPGMD3MhGK0LzCWFgJdmI1?=
 =?us-ascii?Q?FSMuTjFTbSix5oGbehynC+joS27+DH2fzspQU7iigRR+WvKjRHxfhok93LlV?=
 =?us-ascii?Q?jqNjw5dDZfKRP+kkgS/Vusl4Kn7gex8RD/v804OFk4GIkL5OBxlCqpqHcFzB?=
 =?us-ascii?Q?qELqWXDROmRa+wza8yG3tANyR68SSwvOnHlGHpGnEuXHBy2A8G0tbaJqp9KQ?=
 =?us-ascii?Q?jl8OeaMp8uFiBUpI4fi9WRrkUDjGhF+Z8909L/2kvrb2vWIMi/RxZ6/wdhjb?=
 =?us-ascii?Q?JWLm3crtyeC7gjCUgsyTW+wo7PGTNTmyqb1YPsMNdStuKU5RfhR3W+5gSKeQ?=
 =?us-ascii?Q?clyTMugq/KE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trzRicM3tk/czYsvq7W+Mz+OwdqYWwpiPbJQwWXAC3sbdi17y5JDffhwuBTa?=
 =?us-ascii?Q?1SJEsbVm+4G5cv8d/DTYGwv0BGbX9lIpID02B5/NiPZA6XP0tQg0zN/jNMJm?=
 =?us-ascii?Q?1VubzyuxOY5tP0HT7CKl3/LMbkXUnLQb4SbEdK3RUKnWgpN0YQXB5147m70a?=
 =?us-ascii?Q?EJblAHmwRGCyHCe1OJl0+MEY4re3PoIDJrzNFLmBEvtZWDpixuPhIkJPWOn/?=
 =?us-ascii?Q?5w3PlRuBx+OLkKJqg+REHyc8RpeoZ7nBn6RdeUy+rU0ClO00GW/87hKTFe4E?=
 =?us-ascii?Q?kt3nJvOlInc891B3J9OEfkztPYDgX3W3foATAGQof+Pppf3RTLuC+3N/yMbC?=
 =?us-ascii?Q?d+qHawHM6aSDItFeKVGUhRJGZnGPKuGrzOKlxPkb6DD+FL9O5IZGQhZQ7wbO?=
 =?us-ascii?Q?7k4/oG9O6Nktj8UoTimT2YAffbJqU9UIluIke6r5ARgnaNFcYQsXruZf1MC/?=
 =?us-ascii?Q?34YjzT20csD8FkqmUtBCXGFNVM8OS2TYFBp7F3dW5QccCinOKCablt3XucRH?=
 =?us-ascii?Q?atnjVUEpvEFLanwdRbEE7maII1Fbvbi8r0d6wSJpzSfg240nlFzoZ7jPCPyW?=
 =?us-ascii?Q?8FIyEdgn06h4cFkXZbjU2OI87TpiDJpneBsgqf12Ge9Lu7rMDXV3D7Lxg0zI?=
 =?us-ascii?Q?txvhpEtMwTO9HdNIOFdobssDmZYDaIt1aFegqmQG2XJ0amsdUJE6BQSYeqXW?=
 =?us-ascii?Q?HKsubAt0DdgtNd3ponwyBufaiDgIdNxPP9SwGqolBLICLE//50MrHUnsvTQ9?=
 =?us-ascii?Q?2F8a3iA/MGhI1RyS806wE0X2btr7iuEvoWXBl5aQXYtTvW6Sn8shVgIMr+vG?=
 =?us-ascii?Q?O1opI38f7FrgajgFPqSqUyENd/VNJHF0C8waJCJje+IDqtABP0EWjTT9CXPS?=
 =?us-ascii?Q?udjBbkaO+Ky44h0oZcQiCHJOwNL8+Kt9KogyVnidIOZJi4GSEwadeYS/sw53?=
 =?us-ascii?Q?jbI6by/2/mow4yXqDrz0DhA7ARmt//HERbRAs95DIU9Gsom9IT5c+9K28wQJ?=
 =?us-ascii?Q?kSSIZtK4/vslaokkEvii9ULw1ePY8JUmO9jFAEug1r2HWlbL4G4oJjNB7+yl?=
 =?us-ascii?Q?Mb59NeG9hj2EN0DzUuzaKQZRf4oKo13X4pYuUKW3gwRokjKlTfFhkV5U0DAm?=
 =?us-ascii?Q?0d1Lu/XSwiQNg6HOq7vl0jxiM/kAP/JsB7zuUW2pgfCkeoydEdVRsYzJoW7t?=
 =?us-ascii?Q?ELO0e9dJWPx3S5CsXdbRokKYnKQxsbtQ0qN9Yh0tv+o2zX/gzWxhD/eMa5gF?=
 =?us-ascii?Q?bX5LVw9JdwEN5FeqLCbM2IZIF8NnWKdLBltrzbh9JuQw4zmkfRg+IepYJ2rb?=
 =?us-ascii?Q?rDRRLvlxDK2DxyJj3oW94r/vvU1UomKg5ln7OnFrpt4U05c92ZRUfT3Bl53e?=
 =?us-ascii?Q?oT0KTY3/KFVRafGtmWAhIKVJiWSOkx0B/JCoCXPDRhd1tZcEJWgqckrGdhRv?=
 =?us-ascii?Q?sDQmHHaAMITFWeKRZLKkjbaPEe8S+lKV318ZAUkKunmRevf/GUnRCFL/MWcv?=
 =?us-ascii?Q?QwtDdl95FjxyGSxOTrfp98q4WByuAETKlRZE7PvFRv8mdx6CeWCCslg3631O?=
 =?us-ascii?Q?4XvlNbgxLKoFACRmEfdWT7L2rEWIQI1AVkLVRmeIIxtQ8qmhUYE+6lHr5hdC?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OoEhBI9b4sTl8JHmTmPPejBoCLmGqBB1/b0tWmD8GYsinONc+5m6bMa1j+D3mIM8arVTBJ97OdislHdrjt8fhNTOIvwjmgKhw7S+xO85RfTr1ba2rC79PVS/lN4/RJUo8tOB1HoHjVVO34aL4n0tkySUmrTAHiy7KfNV/yUyUEzwtiP0xYgio0Ib643iBQO5EieBuBo+LrtxxxsJvuB2BVbe54owKGQDHTg3HCo9zRzlhmL4H2MhJod2AxvqV8fYCmXa8qxrTexQq+FrWi5TluGvdR95vSn7sP+gO6ZAXHUINQfNJfGok6RVp1sGS/xVxknYsuY+E/c5h8Rams60JEsECyJcAf9g0svH+AVxVaV2UwUHuupbcO1o4ZS7KzYC3pnQknE3QlWw25dbOYEbRYoH9MRMeVaC6MYlo3VZ+sUT7kM+Sig4gr9B3gluD3jGBEI9mq8UymhHOEYbqDgzLtVpprwQ8vh27iW1f2Q3/eknGg3zrbIpFyxFRWq+/fT1dGF3E6tbz7jmgpYnkkRBJMYguYIYSyVBgp7oExddo1aLJRoxK50gP3VZZpUUv0i0n3tbsm+qKiDfwKVR8mG0klSO5lGPY5r0PVEdLp3ZY1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a0433-a733-46b3-6724-08dd81942eca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:52:39.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zEfJLYJSJ5YT/EgUb9/WNMoTTNRyTuyFzG/cJgurG3NGSjwO+BD9g4K865LpUhEWiA0Huxk5dJLvyPD5z+YHiPTvGm6JLH2qnXGgiOVPNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220089
X-Proofpoint-ORIG-GUID: 5Xy4WZJ1NkxxpoUbYuUMKxHbWRzhdKuG
X-Proofpoint-GUID: 5Xy4WZJ1NkxxpoUbYuUMKxHbWRzhdKuG

Currently, if a VMA merge fails due to an OOM condition arising on commit
merge or a failure to duplicate anon_vma's, we report this so the caller
can handle it.

However there are cases where the caller is only ostensibly trying a
merge, and doesn't mind if it fails due to this condition.

Since we do not want to introduce an implicit assumption that we only
actually modify VMAs after OOM conditions might arise, add a 'give up on
oom' option and make an explicit contract that, should this flag be set, we
absolutely will not modify any VMAs should OOM arise and just bail out.

Since it'd be very unusual for a user to try to vma_modify() with this flag
set but be specifying a range within a VMA which ends up being split (which
can fail due to rlimit issues, not only OOM), we add a debug warning for
this condition.

The motivating reason for this is uffd release - syzkaller (and Pedro
Falcato's VERY astute analysis) found a way in which an injected fault on
allocation, triggering an OOM condition on commit merge, would result in
uffd code becoming confused and treating an error value as if it were a VMA
pointer.

To avoid this, we make use of this new VMG flag to ensure that this never
occurs, utilising the fact that, should we be clearing entire VMAs, we do
not wish an OOM event to be reported to us.

Many thanks to Pedro Falcato for his excellent analysis and Jann Horn for
his insightful and intelligent analysis of the situation, both of whom were
instrumental in this fix.

Link: https://lkml.kernel.org/r/20250321100937.46634-1-lorenzo.stoakes@oracle.com
Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001e.GAE@google.com/
Fixes: 47b16d0462a4 ("mm: abort vma_modify() on merge out of memory failure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Suggested-by: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 41e6ddcaa0f18dda4c3fadf22533775a30d6f72f)
---
 mm/userfaultfd.c | 13 +++++++++++--
 mm/vma.c         | 38 ++++++++++++++++++++++++++++++++++----
 mm/vma.h         |  9 ++++++++-
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..4295a599d714 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1898,6 +1898,14 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 					     unsigned long end)
 {
 	struct vm_area_struct *ret;
+	bool give_up_on_oom = false;
+
+	/*
+	 * If we are modifying only and not splitting, just give up on the merge
+	 * if OOM prevents us from merging successfully.
+	 */
+	if (start == vma->vm_start && end == vma->vm_end)
+		give_up_on_oom = true;
 
 	/* Reset ptes for the whole vma range if wr-protected */
 	if (userfaultfd_wp(vma))
@@ -1905,7 +1913,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 
 	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
 				    vma->vm_flags & ~__VM_UFFD_FLAGS,
-				    NULL_VM_UFFD_CTX);
+				    NULL_VM_UFFD_CTX, give_up_on_oom);
 
 	/*
 	 * In the vma_merge() successful mprotect-like case 8:
@@ -1956,7 +1964,8 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
 		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
 					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
+					    (struct vm_userfaultfd_ctx){ctx},
+					    /* give_up_on_oom = */false);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
diff --git a/mm/vma.c b/mm/vma.c
index 71ca012c616c..b29323af68dd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -903,7 +903,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		if (anon_dup)
 			unlink_anon_vmas(anon_dup);
 
-		vmg->state = VMA_MERGE_ERROR_NOMEM;
+		/*
+		 * We've cleaned up any cloned anon_vma's, no VMAs have been
+		 * modified, no harm no foul if the user requests that we not
+		 * report this and just give up, leaving the VMAs unmerged.
+		 */
+		if (!vmg->give_up_on_oom)
+			vmg->state = VMA_MERGE_ERROR_NOMEM;
 		return NULL;
 	}
 
@@ -916,7 +922,15 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 abort:
 	vma_iter_set(vmg->vmi, start);
 	vma_iter_load(vmg->vmi);
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
+
+	/*
+	 * This means we have failed to clone anon_vma's correctly, but no
+	 * actual changes to VMAs have occurred, so no harm no foul - if the
+	 * user doesn't want this reported and instead just wants to give up on
+	 * the merge, allow it.
+	 */
+	if (!vmg->give_up_on_oom)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
 	return NULL;
 }
 
@@ -1076,9 +1090,15 @@ int vma_expand(struct vma_merge_struct *vmg)
 	return 0;
 
 nomem:
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
+	/*
+	 * If the user requests that we just give upon OOM, we are safe to do so
+	 * here, as commit merge provides this contract to us. Nothing has been
+	 * changed - no harm no foul, just don't report it.
+	 */
+	if (!vmg->give_up_on_oom)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
 	return -ENOMEM;
 }
 
@@ -1520,6 +1540,13 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	if (vmg_nomem(vmg))
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Split can fail for reasons other than OOM, so if the user requests
+	 * this it's probably a mistake.
+	 */
+	VM_WARN_ON(vmg->give_up_on_oom &&
+		   (vma->vm_start != start || vma->vm_end != end));
+
 	/* Split any preceding portion of the VMA. */
 	if (vma->vm_start < start) {
 		int err = split_vma(vmg->vmi, vma, start, 1);
@@ -1588,12 +1615,15 @@ struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
+		       struct vm_userfaultfd_ctx new_ctx,
+		       bool give_up_on_oom)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
 	vmg.flags = new_flags;
 	vmg.uffd_ctx = new_ctx;
+	if (give_up_on_oom)
+		vmg.give_up_on_oom = true;
 
 	return vma_modify(&vmg);
 }
diff --git a/mm/vma.h b/mm/vma.h
index a2e8710b8c47..df4793dac1b1 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -87,6 +87,12 @@ struct vma_merge_struct {
 	struct anon_vma_name *anon_name;
 	enum vma_merge_flags merge_flags;
 	enum vma_merge_state state;
+
+	/*
+	 * If a merge is possible, but an OOM error occurs, give up and don't
+	 * execute the merge, returning NULL.
+	 */
+	bool give_up_on_oom :1;
 };
 
 static inline bool vmg_nomem(struct vma_merge_struct *vmg)
@@ -206,7 +212,8 @@ __must_check struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx);
+		       struct vm_userfaultfd_ctx new_ctx,
+		       bool give_up_on_oom);
 
 __must_check struct vm_area_struct
 *vma_merge_new_range(struct vma_merge_struct *vmg);
-- 
2.49.0


