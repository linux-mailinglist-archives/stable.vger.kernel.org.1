Return-Path: <stable+bounces-165618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A7DB16B46
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4B18C543E
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2323B619;
	Thu, 31 Jul 2025 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U95PeeuP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hTYJqJoC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0B2CA6
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 04:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936844; cv=fail; b=k4rRuuyI5xTOwJlbEw8o0bT3zhvEur3ZCTPNZwweP9zEr287Yh7hI4ylF/A+XR3T28XTU8cESrtata2gUJsSSFguG5ctz9zZumpKyg1Ci9EVy5AXjwIbAxDs5GnfT5ZP24uGukJnyTgwzx1Sc1SpMNoApPOFgq1/qz8xFEiGUSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936844; c=relaxed/simple;
	bh=Qyv/6GMATK1l72Z5GFyA2kWNterfXxt+fLDzOHKXtDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EN5+j/mGOlQrcvTQMiGSFnwAg4r9ioU2oWAFSfnPotHE9NZe9+ZdE9gSDH5Ez2OLIgHAWzstEXgrjKHIjmbFxTo97UYB3XKGKNnbtHd3noxMAx2genWWss4kYA11HOqrMf8JERs72cQhdDFkU8EiI2maTEbgAlB1xKjPOsWYnqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U95PeeuP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hTYJqJoC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2g2Pv026901;
	Thu, 31 Jul 2025 04:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Qyv/6GMATK1l72Z5GF
	yA2kWNterfXxt+fLDzOHKXtDU=; b=U95PeeuPyRJJmKm4N2AxR7GjZHv+2XMugU
	o8rvdmYOIZjPKLHXC60PqHYtLFBbucd67eDDPS8BDDXyTXPZsyOL83KizDK1KFbr
	TRE42ry+X2ORjT75lzrAnt0Z3U/Fg8VK1ZC69n+X85GZ+1fzPLDvCOCW9kpSl8zW
	ywA2J2M/o8KiffJiiQjyVcOJH7Bwt4N1vBxryVxSyrl+seU1vLQvORY3JE6iwbLz
	TJuOPXeZ85pqTAGalQ2N0ly4Lah6Q6fAMUwDz3lwo3jaTfaEvdpn6ZHImbp48ouT
	IjC8SheSdIpoB3hQdshf5lobFxyYIuovufQfk+k81aqo+zM1Uo3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x35as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 04:40:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2G7Tq034529;
	Thu, 31 Jul 2025 04:40:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc82kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 04:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q78yeJYvboEXXUlyvd9q/8KHHfCSstmIhqyDJU8iVBYIKwFhkHdH/+KmiW5bPHSWlgTxEA5kz1mP/8D2X6C5gwjo5VbDgL3Tko4hrZ3k6pGHPA+71S4GBLCgSzwHx5HiR4XtA3WXfSR9qcC+SCHYKMLoLKDU8H2cq5E6p5QRyAzKc9zFm/lZw92iMquaDTgFgahdk5Unu2LdmWMtgq47RYDb2tGCrflJamlZ+Z+Vb2sGMiSjjnAJUy0PyAGJFamzXmG7rTnm64KsCGKQ6BuZZgVL576znoV8aW2xTwnMHMMAtUKN/9b4w6ZfiyvPKntlTujD5EAZqiE2NgCqzuvu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyv/6GMATK1l72Z5GFyA2kWNterfXxt+fLDzOHKXtDU=;
 b=gzGNS3DWk2/0FpfbRMORIzToYHsUdLLFKhcsBelQEqKX5qvo1LLNMKyeplyb7GsZkv6hBakPjMpzJs0i2Q7FfhFkW0l9SLEPUfR2kybrUUvx0X5rKOOERzqYfVLeBn4Au6sFyJ5R08p1X18xU6s4mbH3M4uN1N6IwYXlmmVHqvWgQnbuWBmYbtOSibbZvqlSaWBJBQwtOueQyW0kptG0LFKmWO4GBtu6sdWXWvA2BTSV78hqAKBSi8GCeRKs/MpXQx80LBWrFdCdAGHGL8Au86Vv76ZyQuEUyn3hFRzZ724aFpo78vAdEo8hV29HpTNY+kOwGeeEvmzKCEgkeRD6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyv/6GMATK1l72Z5GFyA2kWNterfXxt+fLDzOHKXtDU=;
 b=hTYJqJoC3vwA29ICiIWXfvZ3FcMa/WYdi9ZvSUfzgkcgYYSGRBailpeh8X81ohL/PF/8pxh+oICUGQv0+AXMt7LHhKm4EZolSorrj/L2SlcyAYbL14CfMIO+5b5vR+IMN6dZkRegpdTwam5KVU5pmUHS4R8OpgPcF8/441WJi+0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PR10MB7972.namprd10.prod.outlook.com (2603:10b6:0:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Thu, 31 Jul 2025 04:40:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 04:40:35 +0000
Date: Thu, 31 Jul 2025 05:40:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: gregkh@linuxfoundation.org, aliceryhl@google.com, surenb@google.com,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <538efa9f-d3e5-41ab-ac82-5b7b799df706@lucifer.local>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
 <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
 <aIqb-bDjsXppmyPN@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIqb-bDjsXppmyPN@google.com>
X-ClientProxiedBy: PR1P264CA0119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PR10MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: d65021c2-24d2-4605-9b9d-08ddcfec63ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ikwx0USCdVyq4MQxnwlMUvCxsDJs/vIjt6bWeeLIvcPh9fzmRwjhbzpM9ybG?=
 =?us-ascii?Q?TkHilBsJtFJiXlxjGpXSkJC5GnKdoaEir3tdS0p8+9jNjbMti8Ii6Fhx9I+Z?=
 =?us-ascii?Q?YdW+9884vTekF/+gZwQqaxbZzDb8cnWJm7fNe3cXvmALmB1XZrmrMr1rn42N?=
 =?us-ascii?Q?V4PmovVrnwftg4qCgKoRdjchjp214XkZBZgXhABqKWHfssxkJK4vFda8LDoH?=
 =?us-ascii?Q?8+MAyZgEcynZOh5Yx+zdn9UVbg5hyJ8VtQhHjwy8jLd3t1gTv7/6OUx3D5PQ?=
 =?us-ascii?Q?qLH3r1YSakkaglcg9vmawir2iGMCv26xvTBbRhqEy6Ezy/SCICSaBCkKbsbO?=
 =?us-ascii?Q?YtN3O3zaH121n+tJAUUSyOxtOoRCE6EDidJomMKJRaHXvdU4keobsDTOx8YE?=
 =?us-ascii?Q?A2yZeYBHd0KBzEkWQnHY+MBxvtLOpE/jmKhIr/6fSOMBNlbeflY+kI7DMex1?=
 =?us-ascii?Q?6yNMzzEGbpv04ntfkPjoWX6zmB8LpSjdASnCL3Tfj8z9Pi2GoFOeI5qOHJH+?=
 =?us-ascii?Q?d+Hv42D0+EsIUqkKmGHFD+y2J391oPsyq/Uulzctfv7j0thsyZCQ/w8ThFiG?=
 =?us-ascii?Q?de0dKenvOlwXLFtod8iyRNvyki1YVL80MJk+UgJKmQ4TYY5kzdEBqICUA58Q?=
 =?us-ascii?Q?pDxrLlXEVgpdJhI7ZOb09f/icJiA7qg2mBJqffzub6QhWvUvOUJYCSl3MnAe?=
 =?us-ascii?Q?5n7SdDkbc/ql5sV5tB3eZh0sZumSL1L2rQ/nIDXU5Py9MDwFC9voBN+UHI53?=
 =?us-ascii?Q?Yrzka0Ixidl5rMTCEoeNxapyYF/AZK3N+t6MzS6HSWKix4/q0v6ak8zvImrD?=
 =?us-ascii?Q?yfvTK6Qn6AjAaD/Q/naMPUBaxVCag+Jd/SPoBzrRmLsHWkNHrChqEANVVjYs?=
 =?us-ascii?Q?G8ICXknC6mIsmQC2bqLPLFSZrR4SN7QCE095B4GPqc9LgRwgxojbkFNuGG3j?=
 =?us-ascii?Q?eryCRYc1U1aFS7a9fHzMAKHB5j2cQiwpjh/mcITebs6mWvtHTYsLDktSnmRt?=
 =?us-ascii?Q?Vfqp6KuP/O+pzppydzG4jZ3Yl1xg77q2ZqtPfHln0gO+diTC3cQg8ST0tuXg?=
 =?us-ascii?Q?CNECAAU4tD3J7io1kegHyq/QbNSaKuorHNB0plpnTMfYuOxkoYSF7jt1YLcM?=
 =?us-ascii?Q?wIA7dQKpss8/kMKCYb7LvZ79PgJqt5+8XeT+aBA/J+04XFA6mL6VOQp1zUP3?=
 =?us-ascii?Q?boHSNXWNHUkxp2tnz1zdVXju7yS6GWdr4+BMpbL4kB8e6E8kVvyHkBhZaWfe?=
 =?us-ascii?Q?3GvL0Szliyh6hFRCx2GxtAttxSLsmdkD753Y345yFNRjox5xZ1vaepOd7kuH?=
 =?us-ascii?Q?yJK57WEeHvWiTUDFdHXtarpiAZKCjLMN1zt4eYtDNKYKmYNvOFRA2QEVdHvC?=
 =?us-ascii?Q?RiDMHc4uFRGbC3qk/gFP86y7VSD3KaPt9aLpIJSD0YRFch8qao0eU9FXWm76?=
 =?us-ascii?Q?qkL79/DHSUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vQ+4G9zqAavqma9ujkaZvYth7k/ULquLQwaVlelGgG75emMoJwVFdANyLbr2?=
 =?us-ascii?Q?uOcL/YZ/8u9UPpZzMvVWwiFkbGH/aYbEvSz3QCT0BQg3cYRsXmC66O1/wprs?=
 =?us-ascii?Q?SUjHgoZl2qTuzsgDCaPDc3uUxQIYME9JKLN9WV5azeK78ZegA8696eNkAVn7?=
 =?us-ascii?Q?RspI8JI6rTvMU8VQdDH7qpkkzOJ79GjZ095Au6BH7gwV0Ek1aalimE5O8iES?=
 =?us-ascii?Q?28xT/ufDxmpSq+Wl1/B/dshkyi1jMqv+Fk9AuK9BBGTg627PAzHMS6ylskQv?=
 =?us-ascii?Q?sohQXctjmjRdZIrqfa8uKesUuWWq1M4zxvRaZAahjRVhJddV67Iz+ppP1ype?=
 =?us-ascii?Q?LcxtFMFcuoljw8npcz+n3IF1wnj2JpFMtqFhK9NujzBViHxM2jkYHkGpSwFt?=
 =?us-ascii?Q?tZP4mAgOcnNuz+RG90VQ+Qyp0Yx3kMRvp66BdK3Q+6hdlZHm1Vuu4j9z5E70?=
 =?us-ascii?Q?7PiHpju3V8BxHK6CEFjK4hfZHGHLcwBSYEGGmditebL/V86uvgf8GomzgcrR?=
 =?us-ascii?Q?lYZVxUaT3xF4Z9CarXC1IP1bXgbAjJ+++mJeyD9GdnMTipnvtCGHghOz6ZlX?=
 =?us-ascii?Q?lb8UL5bUTyvJHbGw6yqBK82LEqiMPoX49MgMF30lvOW0VYsGXLPyByQLMYLj?=
 =?us-ascii?Q?pBOBhh309NiypAma4ud9QEUVYkiVXbA8Fr6w5XzQDFArPDkaEnlN4G0KmhBD?=
 =?us-ascii?Q?NH3tm66WcQ1tmkKFCu6WHNO7zZYDK1+4z2oEalydgkZR6XfMyah+7gGS0xfz?=
 =?us-ascii?Q?PbRywKBco4zU/hwO4GHj9OytrJHbewnM2N73IRyKwdsQj3JjKwjfzcyD7Or5?=
 =?us-ascii?Q?yyzXzyGntWbSowBzAaOlua7h/hfqfyWYaeYk6iQ3Qe8ZW/1sv2T2beoH9T8W?=
 =?us-ascii?Q?Fe2qZPk90mKFZVT8lR4dFmmCqWNCZNAeY4HJd88Kr6Rz1xA4UYVtqrco/sKN?=
 =?us-ascii?Q?VaFah78GTGl2EN3V9xfrP5g+mWzl3RTAyi0iK9BRVmKcF/B0Xt+Fv7y+0bQw?=
 =?us-ascii?Q?ZaJKPHrLYMeVFliJxsvznAs3fmU1RIi1dETu5PtVk3WwWQtzmMfHmZ2egML1?=
 =?us-ascii?Q?9CLe3ZJOdNAm8xd7TtQQbiGDzuEhjbKvpQHIpoxw9YwdH7tumFvfVIwaU/hF?=
 =?us-ascii?Q?M0gduoYk0KGy1Vm0NCQAoCbvoERRGl3VE3qDqXCJAehWRi7VEiBoyDuu1qby?=
 =?us-ascii?Q?sJnUScFjoXSpZbIT5cHbBVY3APZ8SYBDM47CFXLFJi4o+LUVtqOZewfVmN81?=
 =?us-ascii?Q?vkv0ZoZYNhoXXpE1bKUvnU77ENYzKk8irkv5Xg6aKpUEm3JygfQ0qhKPxOYy?=
 =?us-ascii?Q?Vv2PXK2EUb5MOsr80yTkFSZRE5cia4JMfGVHqIZIPcOV+blluYn0BbpHrvfo?=
 =?us-ascii?Q?KTZftpfBR/clB+4LrkJBx3p+oCbYV4eGGkSroLkRQLp0rgCA7/+5XjuDjCM5?=
 =?us-ascii?Q?KGEfkcAZCkSyrDJOX43WqfjHXC/merd1B//JCgWdfnAtac7rksT7wxYo977o?=
 =?us-ascii?Q?IYsJ78XYfEJAHeXBZD2w4+cMW0AVzmb3mBaKsf5ZJYV0XHz10SNeWMtVhO9r?=
 =?us-ascii?Q?YkFFYgPWWvdvzgVyCUo2XOMREIR4PitYnNy1cIvochO18114MSkKQf4ZP1XX?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xcyXApHwqokNnjwcoS17Mp/B5lyLY2tvTr20EBmialMU/oft/yJSkf3B3p9T0rDJXn/jLjG8IUzg2WL6nBQ0g5Q0Nf6bg/fdvjF0n9Ik0LZpmENn5G0h3j3Ckk4hAkDFY90qo0O/BjEIOSps5i+gp4/GlvvNltw7KdImJhSrs+FmT7H1laMyvCa9M9DUXzLPbamZzRqylgZJ4+vIOjInC7/fCaP/F1FL7VNOYuF9RCTHC9gcVx0KSvL0I3pZZlUWNMOKezpRbvDz6C9RBUa6JT6h+ZZAb9XDwbwjPjdjdP5yDDvXwV8RYym+FjyjCc/CamT83WBYmgAlukIA7leZ7+cmpTC33TuwECXNgh2z2B/QCnLMadyWyoAm2EbzJn59+WTeXrDbr1nUtxOZnd9LuLgzXjclzHu8aofNYUbkuFJA8yJRzynVknNA36SRPmeAHJCbnNB6BUFyB0oW2YA5vX8CUHfwWq+JdR2VtAC4Yey1jIW3xCC4E2P+R1+yYreVyFT+ytpaicmwYW6i/vKLFo2hsDynPZWXBaQC5J3bNbOEUBNX3ifrl48qk6QV93zkA+HpKTGye5404JvG0aQYIynHa7JLFmzKMncdqh7X7eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65021c2-24d2-4605-9b9d-08ddcfec63ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 04:40:35.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+IuMn9u8wOMAXDsSB8BIKSGapaGbofvuf7Wwqf62FRwCNmcItkIYz5sH6+ipAUUr4GvmDJbHblGlraxyj8B5c2o9d9MrFKgRSf2o5x3Vic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310029
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688af3c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=obW5qwOZwnzDyMXWYBAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DHEA6rmZNN4zn3kb99bEvg74dLCCBzTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAyOSBTYWx0ZWRfX46Jidd0PQspQ
 CYl+VhHzJ6c7fYNK8LT2Ijc09CFkKZ9I1NI4DxtprVquLly/ThcI8qFKJFt9FZ+vJbr283kQeSK
 AkqKzYOFBzusljaLvfVTt8Z56ZDrDw393GhP/chnlhd71metypKcEjiVI6FqBLd3as6j5bu2dPo
 GnahtBA1gErwC5xrNaRUMWiehkOcKJHb3Uu/8Ri1WTAdEK48KjZgh7hShduJeirBHwyAjhCT0ry
 EWpGnuwBVY9KfjdoNJuJcE7xSWJIPidktIXtUJc5nAgXMF8sPHfSkr2BsyRmfHrM9c6qgeojF5b
 t+wRp2cJ0wYvjzdC4EnuwfTRNz5Ko10cxwbCFzjVMGXyZxFla0OfJk9M+tBtnjl1qv3jkijnefa
 U3AAOnb2Lyf+V6+ql1XSUUqKuOxITo+7pIcmkOQKOp9+jl6dnomxRY1emeXoB4GnTxH1LpKt
X-Proofpoint-ORIG-GUID: DHEA6rmZNN4zn3kb99bEvg74dLCCBzTF

On Wed, Jul 30, 2025 at 03:26:01PM -0700, Isaac Manjarres wrote:
> On Wed, Jul 30, 2025 at 08:34:02PM +0100, Lorenzo Stoakes wrote:
> > > >
> > > > Having said that, I'm not against you doing this, just wondering about
> > > > that.
> > > >
> > > > Also - what kind of testing have you do on these series?
> > > I did the following tests:
> > >
> > > 1. I have a unit test that tries to map write-sealed memfds as
> > > read-only and shared. I verified that this works for each kernel version
> > > that this series is being applied to.
> > >
> > > 2. Android devices do use memfds as well, so I did try these patches out
> > > on a device running each kernel version, and tried boot testing, using
> > > several apps/games. I was looking for functional failures in these
> > > scenarios but didn't encounter any.
> > >
> > > Do you have any other recommendations of what I should test?
> >
> > No, that sounds good to me! Thank you for taking the time to implement and
> > carefully check this :)
> >
> > In this case I have no objections to these backports!
> >
> > Cheers, Lorenzo
>
> Thanks Lorenzo! Just to confirm, is there anything required from my
> end for these patches or they'll get reviewed and merged over time?

No, these should all be good to go, Greg + Sasha handle the stable kernels
and should percolate through their process (I see Sasha's scripts have been
firing off already :)

Cheers, Lorenzo

