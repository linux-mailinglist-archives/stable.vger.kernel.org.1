Return-Path: <stable+bounces-211297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePo+A+RvcmnZkwAAu9opvQ
	(envelope-from <stable+bounces-211297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:43:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD46C9DF
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 290303015480
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EB38550A;
	Thu, 22 Jan 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhRSBOeN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y3vT1y+u"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7E37757A
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107412; cv=fail; b=QA8tMe1J17WSy8PQ+OtHh5lYGNsBL8yUueBgSCTpxJMwAQuYZui+TOP1314VV4vIsEsbEY50orKxpEzxrdPqM7UrRSV1PwdImfpO9qB1VzU4pKUmDkjGhKRcdL/g4L/nghAFj7rD6ZoAFOT8exKv+h4zUdhtj5gv7s8BEAfz5oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107412; c=relaxed/simple;
	bh=cq6L3xWwsFJL3yqgpl6mwWuDJXrkd5Qn3Y3+ORxQJAw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ofELi/dAEyQUg1p8OWHH94NCUcISPNp/7dqCi2cf/nwPg/x/lbwY1azhUgFWzZaAyfpEey0pZRhDq4eHStGbxAqMvpz5MQGNOEdFfhYg60fEoDwToZb0LNZkCgPjP4Z/laRcelwsnp6EZes8OSEsCqtEhcTDY3OM1fTy66D4LEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LhRSBOeN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y3vT1y+u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgjRp404439
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cq6L3xWwsFJL3yqgpl
	6mwWuDJXrkd5Qn3Y3+ORxQJAw=; b=LhRSBOeNjfDVCEDsuB87wFX+Gkx62NE/WW
	Tcje1mhA6WTiIPV1QC0Lm2fMaCstBmwaiJbZ96fN3N5IZU1FvsK1WDCcdPjFGgk8
	U/H0SPDA1t3nVtSBjjZ3IAyL/cK8OwtOR7Jxm8RVeyxRVxt7FesjZPb106xvOuWq
	7QF/R7v41/ekfYXT2AU8rMiPLytWwyhHgZZQHgi2hBK7a3KkJpsWrTpiN1p+Iz6W
	PgtVerbed/WbP7BOgv0eVhFSDfX/9FtgeInLpw+HswNziSIhktVp5tqZQ1oOg7o7
	UNYuhJCUHhADY2z/mhd63GA1241YM6vl+TpV2ndSBlkRc8UL3TMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9rdqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:43:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MHDlgZ038749
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:43:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd8pjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm5K0UrV8YT2DqQOe4qcf5eAWyUgblwag5Cmu7q+A6ECkB1AZB36JxjYi6OzaFDi0d1n6c+euYfPO9o0E5rGkPUE0XLGVKYOfJC5AOt+Jt0ON4PisZ8IRvchvaFeE6PKTRPTKKEQMGj2Z9KqHOcnd4vp11yqwZWt14w5iMYZOQftU9s0WTF5sIFA/f1FCeNcDEjbJ6aumz6ev1iVIumNn7pVNm0s1g5E4IGkINziGFs1URoLlOhODnWfB1wo7ee2K12wiLKzTUmx9QdfYZlarCA7Vns2lPEaFTZgY87fWeZPffg/OND7VtuckOpiW8JzzBG/djwDBqMUXh9YzgnSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq6L3xWwsFJL3yqgpl6mwWuDJXrkd5Qn3Y3+ORxQJAw=;
 b=hzGzXVbTvC2t4iDZJJ3oJ3Dckd2a8f3dAdGmxzxR6dzx9KLeHMKHU1nQO1cOIfS2ADt8fwY7yeKl9yjpR5ZKf4yqSosDYqHW6tomcARp/HZIX+MuvLGrkKLibZVSqitJm14Y6Lw0lZM+0VLewZ+PwdrmsMWygLcCrNiBAF/tnzSjirXBwyz+bkLyNjy/I5kMqkYhbmd0nC6rtDLPh+rR8QBL0az2vxLDdMCNwmMuzNzthYd8cyAtg7UjPJv/nnTsNSznO/WO3QCmRTwqfP0FBTxmFkPePUANDePZ6KCp3u/VIXetM/fEttX4OjilELsT/vrBtemVRDMHGRCmPw/OFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq6L3xWwsFJL3yqgpl6mwWuDJXrkd5Qn3Y3+ORxQJAw=;
 b=y3vT1y+uBU6w3ypTLA6NQZLuJmWxESlphABVCMRkYkZhlnmMJ9Z49OHVou0SeFKlU9qtPprgwP35U0oi0e8WE6EdXyP+pBQYRjLxwlo+4MXSzVKU4A+BZ52Iy8epnVcyAuQN/FwKq7DZTqBJsl+Uhhq7nrua4FhdMcTL6giTHTQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CO1PR10MB4626.namprd10.prod.outlook.com (2603:10b6:303:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Thu, 22 Jan
 2026 18:43:12 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 18:43:12 +0000
Date: Thu, 22 Jan 2026 18:43:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] mm/vma: fix anon_vma UAF on mremap() faulted,
 unfaulted merge
Message-ID: <38c66ff7-d8ca-4690-8927-4f2182ef20a4@lucifer.local>
References: <2026012009-headroom-imitate-c895@gregkh>
 <20260122182744.2301298-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122182744.2301298-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P123CA0046.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::34)
 To BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CO1PR10MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4fb06c-9601-4aa2-4c70-08de59e61877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbjdijKzC1GJJG2Q+KE0Bs/LyPy3PPtPOuyAG0PxfWNbroHBOvZxC/D0z51V?=
 =?us-ascii?Q?3Q4tN3vHB+rtfTQ6btTl67E8adT2PuUOe9VFdQhFa+YMfhSji/jFDsLrXxCF?=
 =?us-ascii?Q?l3D68SnQ91O47GCpAG/bgdmOUo5KhTp47GXPUi3XCMCe4PVmvH5OBA0YEKWT?=
 =?us-ascii?Q?H+IVk7pww7cpHYxSvkugvsH1v11/xO6eKOb9OixFFca6Sl1Jdm/IpuOFQ/kv?=
 =?us-ascii?Q?0YumLAJEAMUVua63JuMkrmFJI+v2phld1D5GS3Tx7ig7NUkQx+sKhM6WKXVb?=
 =?us-ascii?Q?OqT3l+zdpJ/11aBJx5/PkBfds2nf5kd0vk4+81zYyXzeD3xsmiJFXBqIYp0N?=
 =?us-ascii?Q?SUbaPM3jzsLo6rBwXbWhwuydtZcAK8aV69uCZRc4k9eSUdu/ioRybePHOug0?=
 =?us-ascii?Q?vDx0kUyMMSb+uTjyijKYB7Wnj2CkZIfR7tztvcmVaD4xfDup7zOY1L+aoi/F?=
 =?us-ascii?Q?bNTEVsnMjgxdWlXDhOH7MpROVxMIsRw27OeTkGJFqSAtM54drkXVIOe8iIWh?=
 =?us-ascii?Q?6O6QIcdVU1r3GNXWo0nbgzeu6zl6auCR6BiEhl4x/MahKIw22PGEhXqXMPaT?=
 =?us-ascii?Q?z5MadTCdMR2Wy4dSFbdKTRPDmJa7uODha8m/J54Wi2TeHmOwXFPJpUwWmEFG?=
 =?us-ascii?Q?kjcwr6vLFPrVc4r1SP+6XrWzbpfO63rvIvcZwUKndL5wAEDhFDnZ0CZtyd76?=
 =?us-ascii?Q?tsqY1UhsnCElUuEYOXPYiR1Snrf073IbO+hOHMNe/YdWkCeCk9PpSj5oMoUf?=
 =?us-ascii?Q?x+ZhN2GsKQWwJERvlaXkJzUVTF0dks7VeiKW0FLFYGyUKQFIT0MvirTsMkSv?=
 =?us-ascii?Q?6A/tZcVl3Zmi3IS9PXG3ki4I9xF7YupO5kzLpEPlQiKwd8kwtlmpfL5B87jP?=
 =?us-ascii?Q?/ptS/gtvFEs8UlV25SBQUDdrhoPsBQjxZR/ghtx9RuL/lSLMDq4tQwF6Rh+T?=
 =?us-ascii?Q?zMrYUi5Qf5odYBVr2dd/yHfmaK3MyHaVJkNLfX8OxQWq9JfWHD5yQ1rRYMfq?=
 =?us-ascii?Q?A6EaFqCCQo0aLy4xb0d3Cknh0wMnso+e5s4mLN3ihZL0sUL1JQrn8GW03mHi?=
 =?us-ascii?Q?3qximSlrQAi9grl55GdbRphIrnFrR9wXQ8QK51+06s0HpM9ld0AjjnQ2Q/CC?=
 =?us-ascii?Q?KUfIud4MYT5qc6YVmM9bImmJTCwmorZC9XVEuu1140c5aEjLrcwOLDdnYPji?=
 =?us-ascii?Q?z2avCl+1LI6SjVmbVBosmtCWzyyMXxkCuqYevnI3fEQFG54BzvAR5qFg0LdX?=
 =?us-ascii?Q?ZhqmYUIuFfQ1fXrXytuAwU1MqUh3O+B9o23BLBuA6ekjXpuFQbYAHM0jx+K4?=
 =?us-ascii?Q?PqJu+/S8PVGo8BxXukRSRrkO+eGUXaxhg2kl+PdCAEppbo13gy2pZa4LmHIj?=
 =?us-ascii?Q?vnZKgsce02ASR0agfsiBE/NTDUTi6EeofIflFDAhDppuc8I2hb2/8d5mbZKP?=
 =?us-ascii?Q?a0hZndPJSLP7X7pTK3WkOPVYOWRANYB+zobnSPDEsrqdx1F4wAD6Bte81Haf?=
 =?us-ascii?Q?DxkHPRIU9+1xv/Q5tmvGUmQKk0RQbn/3c+HMrTELD/PVMVJD4L0JvN7oIGIL?=
 =?us-ascii?Q?lYWNjk9raN8Vb8cMI04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?itMaFo10kSJHHh3frHxlWNzAG5YOpI4Vpf3+B7j2oB8E1W6UPnHGzSkwfc0r?=
 =?us-ascii?Q?tICiig9vfpAV/PCHO3z/29lLKRiXyv5FTUoBaTChml/c0kJ0YDX411V4Bu/p?=
 =?us-ascii?Q?QC0XQxm45v5l5zW5NqDQEgG9ih6CFfuH2eZVmWM+lGdcoFUXxHTzO2G40DXU?=
 =?us-ascii?Q?vWEDpCEjRiOwt018IW5HLrFGgDIwEz9wp0rhaV7fM8VnluuG1T3n+GQWRdCv?=
 =?us-ascii?Q?vW6RA89JIaBpPuk0g1xsdp2AKgnPRHKZa9tZIxfkPl59gmk6ZYTMFK2z4uKr?=
 =?us-ascii?Q?q086ydtX9JZfx8THi6XqvANQo/5cw3THl7wlEmFS1qfbs0UolUZgS0CdbwC+?=
 =?us-ascii?Q?1LtTkvhVlLQNtLTOON4FUIGZfhmv3sK3MPan+bdGhO/wv/n3Be2LXFLzO8SR?=
 =?us-ascii?Q?bZvBTcvBaimgBWtkddsPseVGyYr+8qgqL22c+aaJMaSw89Kbm5bk6/7HhjeO?=
 =?us-ascii?Q?9kpPJkeej4sXb5tCFmLS6sJiosYM5mZ10YZzzD8gf+H857LFZlzWCfLC7Xmh?=
 =?us-ascii?Q?FowyygGiZl1uTu/xn/qq9kHWJz+zSJ/4PCM/lDuIE7mSk0H4qJQ1bviVMDR9?=
 =?us-ascii?Q?j4XSuPpnXAIf3ADTDGjFNQ3YhGUebkIyOKR+Pkki+tS4gRc5500palUHpwez?=
 =?us-ascii?Q?Es4kb8Piv6Nk6/e84JhZ5e4XxXOROPnqGp5BJxenWEY0pRJscEh3jCyOnqWv?=
 =?us-ascii?Q?AumGUoN12jGHUzN8DIYWAux5sYp0w+wABI3Bwm3cqOJRRJg4orunlofo3miX?=
 =?us-ascii?Q?LW0gyEPor9oTFYYXQ1c9DUhpR8Zq/NFrGtuLj9V0MhR8u/mWiRHB5T1v8OX1?=
 =?us-ascii?Q?9QJXx3A43BAzI7GYEpXfJvUBqrGo37X5xO9cS8KHi8vGb73Z0hkEozRmgJfH?=
 =?us-ascii?Q?mI/AfiJqe8HSj5liErxAleE1cepbWI0xCpMfJ9/EyVqTUjY9o4ew5fZ5UU5T?=
 =?us-ascii?Q?bRy6GQKrJnBluKtAJKygMxOi77Dr7cEJgjn5GNSGkKtA2mjDp6BR0RYORrnE?=
 =?us-ascii?Q?qwrBJ5crvg08fZlBTP13OcQ3aoe5OsZHoAhIe4JHW94/DsEdJKyyfDtdA+Qf?=
 =?us-ascii?Q?Q2RJ+4IysboN+BT9+nsutBk6Gq4rp7b6/VI5ImB8a7E3C106Ahe87foTAAoC?=
 =?us-ascii?Q?HNbkOOglzOGqoNNNTnB7J7Gx1jUzAwZmlGooY2q3IM3Wkn0RSPA/HrU7O61O?=
 =?us-ascii?Q?YR4hNpJZyvgyvv5MSa7fvFNbmyz5k3/A2tN51BNYJqlkCoRGYLGNENr4n5cO?=
 =?us-ascii?Q?oBoK49dm5Oem65rO1x34VVHCpbHGjhBBbNL4PnVwGVIcXJEwAVZIlPkhHBuH?=
 =?us-ascii?Q?CpduI2rgr1inP/ucxrIPpDD1vpdcC0T+1y7IyWJRuMVK4UUtLHNSdpu7OCgI?=
 =?us-ascii?Q?1eeom3kjXpOrSKyYhOpQ5l3e13QnFM4coHx6PKJDz3YgYMbZDvOPTJgMpMgO?=
 =?us-ascii?Q?hit/LkVudhhcdofQ7dqHopfgWCXGtAWJaO3zF0RmY/02G5WChErSZXIWDIHh?=
 =?us-ascii?Q?o6IEyHS9WTgq8pNMjA5XTFyI9ZkHVa8eCs1Sd2xZGZLFBnqkNsIZ83oKMcZ2?=
 =?us-ascii?Q?5GaG2zExsuSJJUT3wicattzlNrrkPOPZ5SSWuNQvKw93oeLoXUcAlKlgqVQy?=
 =?us-ascii?Q?WFt4fhZxjHcpxKy7zsoHuDAzLa9hPNbT35K/JadBZWtxES1zwxAAah283O93?=
 =?us-ascii?Q?MA4Qis+a/XG/1fibx6LSMp2+SMlxgVM/AzrIzl52J/Gu2DLmoITIefCZS/sp?=
 =?us-ascii?Q?pfUnV6Mij9kf5MxYG/BhKekk8aK/uUs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	myn2zQ6ZfaQuWhBXx3NKZu+E3qWSYb6lZzwDpsfJt9kf2xyEv7xIu3jT2XjQrkGNjsKpSwEDWOO5njNm/T1Y99XW5et5RCAFuUPL7xkUnYnNMKAcydFq3nSBqYG2W4YA1nqF0fL1lkzqSCZOBLIqoNKTcp+mGg9/VgvcMI855hRETswb/01H8M86Ja2rMOwC6DN1+QeD6/RR9BwZDO4vLgafJ0HPhBMOSXFR440CotGTJN/p18yOtuBE1/T09TR9TLY0kjMNv/DwBFwWOyL/4cu09qyT5y/p7Xa13TpkZorIe+1uG6vieXytykXhPeyYUoh/PfwdjqHWmzr05TkpSDERAfgwTG6tJvJrLc8m3hrTOuPHzvKUaYywB9ufFjimX812Bltqi3E8VkOXUnBj1Sh6jHXTrAMz5vkvqoZJU3JhbkYMu9E3s+swpCtksR+TAwLwUP2/xm1y7NgUo6+/L2n11u8vbzysCpr1Dmd8Cg75wx6FAi2Fxj9RWfmSizpGZIRSRuC21vl/W3lIytJaDBXKpfnGsU5ApFK9Y6R16EEvqwFIIgTK7uEHfucXxf8RnaRHd6F5BIr2x3c3DlrZUasB1dZvXWfkP2P7xXFIKeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4fb06c-9601-4aa2-4c70-08de59e61877
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 18:43:12.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrUX/iKXGtvaHd0W/NcGPvkxzrZntTUv/wJdIEFw6uqA5xrS/N6WBA4P16Li07uH0m6pC0CZK0nEsZKg+czNovvIegeZLrLw2XhGvs95gb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=322 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220143
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69726fce b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_wHMalicw5_DR0-4DQ4A:9 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10
X-Proofpoint-GUID: RSLFee4jlRQxOFM0PsneHcDVwAZX7VCx
X-Proofpoint-ORIG-GUID: RSLFee4jlRQxOFM0PsneHcDVwAZX7VCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0MyBTYWx0ZWRfX8fyXx7m5k/na
 17J2o2GT/RJe7p5ru1W+grfEM/vbLoJZlYKQIRZ0pLUNPzZcE6I5DyH3zXGKKxXlsA8jLRRWPW3
 VPtw9W6Eo7kURkGBYHh1Xtk1oXgoahnptj4d5jH4VIoeSoC6V6LxvPqErRIFyol8K3CTS/BvR3a
 uhdrD2aDYZKvlhzVKDTCg4SiRV9o1lr7jXro+Qr0gQZtBfmPKUAjPLBnx4jnGL5t+JnZLDb0bCF
 ujF2P0C6SNdHkWWU5hILk+29S2C+64zVrQ2A0wwLNealAVvpN5OkZeOr0XVsR6+xyqGm2NZsTIL
 DHxHucCfolKn3MDtRESLMA3FQg7MbgFVfbPBpEXwH4oxhFyIl51iVTabRXVgt5K7BiBQdT7d171
 JHmWEb6CjPHJsRoVjlvZc9geteCtgrDAKgDCax71rHxMQwhUuaMO9EgoDshxndtBVEn+ti2xkL5
 pOGj42GINX++AVHkUKQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211297-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lucifer.local:mid,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 85CD46C9DF
X-Rspamd-Action: no action

Sorry, screwed this up, please ignore.

Have another that is a dependency on this one + I failed to do the S-o-b
correctly :))

Thanks, Lorenzo

