Return-Path: <stable+bounces-93594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B295F9CF4D2
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342EE1F23CC3
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95461D9339;
	Fri, 15 Nov 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jDwd/FrU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pDKvxbzA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4161D6DC5;
	Fri, 15 Nov 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698950; cv=fail; b=NT+ScwZOcbb5DxDtV1N52Txdy+4Li+8Y963utzlCvd55YwkMPW5xozBppxbk2TvSsBkZ81jRgMVMXHP153ZwXso+blxerLOZbfI2fgZPGQ1+aaBgGtSabDmzaaR0Gh3BSxxGg3A9OE6s3aivexJGNrn8xPf7cnS2ZfdYNxH2pfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698950; c=relaxed/simple;
	bh=NuZHHb+Frb7muNHY6YS2HWSxLvYkAVsc4IqZ2azu/3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbO9r7HAlq/2hggIFkLjnOgVsdnw9vN47hO0mbZv52grqZjNZH4uzQyN1710+7GKmDbaKC6+8hUtzsDh5Zt++uw4cINVw5Ar/UNUW+J5s3EIC0X6CKFEbGG/VUMZkG5/2RK3OvoNYyp77/oUTu8tIB6bsvHSV6QnKGtW/7FK2cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jDwd/FrU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pDKvxbzA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMw3s006324;
	Fri, 15 Nov 2024 19:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/f5+GW67rvfeQe9OqT
	G3j7ALt9ypTj8GUu4AsTfCfRc=; b=jDwd/FrUHCJaZWN5W3jKQK9ldS2vru0zWZ
	YuPazV1cg8wgFXFxk8TCv9BM38qore5lLQTJIGW+m6DIr7JT2tNWVz1jEMqLPOev
	S4o2G3f4xQ01XSzQuftk8A7UCS8vNnnxh8I2RXvtq+x5oL/2Gt+AvpU1m9NoarN3
	dFOUAf2DHGP1iWyR3D9XGCsMU7HKv5Ay1oeAPxxp2pBvjhsE9r03jbzOiywfFn6c
	OgJDzvvm4W9HXNemf2V99sv+dDyfUIA85Cg07sYoFx6e5/jLi1bTIU0gWAeQIY9P
	nqOOdmSlhc2OtkMvfA8HUAVjGooqj+Y1+FwAIstmJqggnRsl28/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heuxw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 19:28:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFI05hB025867;
	Fri, 15 Nov 2024 19:28:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cm68s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 19:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbPtSRTRLESD9m6xuYzgmA2obT6hKBQffynn1FWPEAuR2PMDNEQAeuywuwG2lQ4694+ITj/oxAVrtJyaP95bWWRAw7prNTFVzFrCiSnZxCAhFw1xU0Jpt9t1mJf05DJbIZOcKOk1qapqJGfpfn5Kd5Q1EqQqbmcJh8a7Qit1fJBRDAbyMB1EC90GBmsiMKxDZIpIIeqy7OhYn5MEgszfZV9cGS2Wv4gdgag3mXZc87kTnYUNlpc7KBx/ZbkehBx2X5nevJMDfGhODbzi1h6SA+4K2bPzMqk8pCMXmnK6K7riWGkawRC6Evi4njrDC+A9qyR9lEI3+DySetDvblsYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f5+GW67rvfeQe9OqTG3j7ALt9ypTj8GUu4AsTfCfRc=;
 b=McTZo4UYUaMYFxZ9yOE1X177t97aiQ2rMOjpl8zpYMuGwoZ8mqkBVYIMPG3PTsbx2bZBEkmsbWtUyMjV+7q3rTCrCEen6kRdo/c7e1oGjAegtVx/9HX8DIoWMeYvKNIFzrjBjihYXDRc/feNy70vekGcorYr85BwpJLCefx4jX61faJK8FkTAlNiD5VbUEiVEodGCXFf4DAx9CI4du+2PzVU+4t4JD8HjNmlXdRNDEnsEypbxaiwjh+ACgShkluQVO+lsr2F83YCFUZirJu3mNcX6amGTtVOhbCiwWd4cMLNpRAIRNRc08/trMaxtcZSR24Z0Mk/PLxNv2ThvGdNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f5+GW67rvfeQe9OqTG3j7ALt9ypTj8GUu4AsTfCfRc=;
 b=pDKvxbzAfN/Cin93Z18FOfX/QcLBpbNc4xSI7uMy/fjmBydMO+x6VoBAqz/ZCglbl/JlIv9JbqTt1sMRaDit5UCDTTic4gGj98ftLb8NpdXLaNuv5YXD8ROSzxqgSTIcnX5AUw21v9Jw8G2e4qFh48HtfeboGAw1tTIEVaEJ9pg=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Fri, 15 Nov 2024 19:28:36 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:28:36 +0000
Date: Fri, 15 Nov 2024 19:28:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
 <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
 <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|DS7PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2a08bb-5e14-43b9-7acc-08dd05abb382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tnbmyQmQTOitTXsWsKRnzRtrHu5CVYIhWq90S/YB4liedF2qDvcRGcYmrvJ?=
 =?us-ascii?Q?F2oPA/5CLEsM/S0yLwnkMRITfNld8oc4eR+cWz3zHbTQmJmjHFJO6FSvelOw?=
 =?us-ascii?Q?FVKpDQvbo5UqciINrkQDQMHN4Kk1OAaooh6yOBXZbYk3yUeYc/xfUuWnjMnz?=
 =?us-ascii?Q?ezyTj4ZRGLlmDZWd+2xTsTOEo6CNc3pFoYHvHNxAA5lwPHIE2TUVQu0wa7tZ?=
 =?us-ascii?Q?m+l/H2jn9etp1dDPFGJSWBSmHt0fm29IoPXzl8J9es17Z3pMy8xkkhuKMNtH?=
 =?us-ascii?Q?BBi8BUELTExrAGD1dSfR/Dxcamq9O4vcazYbyrJ4jgo4/q0rbhIvvb7oiKGl?=
 =?us-ascii?Q?so9KUE85b7L+bmm83wf25wa00UBnmf87eYjnptLn5GJggsXUzLW+ZBJMe9wf?=
 =?us-ascii?Q?J73XcJO1SksfqGehJCnppl/e94+bTF74rHJx19DcB40nC5uqdoAgwlkPaUKe?=
 =?us-ascii?Q?nx7/6iwRYBTr8WDsjdtOPxv0Xkkq34UUR3xA8gXKOQntBG4Lms2+zSjUQGQf?=
 =?us-ascii?Q?cnBqbxgO+qpitXUtNZcIUxzZQ2TKoVwQ0ErGaOyIfIZJnZq1Hc9poMnI/cwB?=
 =?us-ascii?Q?hC0emuGONzpJXO9s/qm7JId7f148vWshcu8+2V3UNSj+BLm1VKEEPDdhYdSV?=
 =?us-ascii?Q?uZn8UYBG/4kztXmFn8HyQskKGhKwGp+oRgmFtNR6aGwhP5NuVUjFjCx/b5P5?=
 =?us-ascii?Q?tdnxm7CWd9RZV0lAgxPIoJFhDz7lXORvXccAY2lYm47jhNFgs68gPer2GcWz?=
 =?us-ascii?Q?3JoVPyS0gIYAYaXu2HKuwFh8XZq1QLZhC31jREmgMD2uyCJCqK+wdDM7hRXi?=
 =?us-ascii?Q?onKgNBmt4MEwlfd9Xd0lEB4xqZSVhWCgkrsL3yD0AFEv5KPetJFVmKcYgIy/?=
 =?us-ascii?Q?z9REgsYMn5/K+twCZNA2gn7pC5gaZp2pYEWtJUDM/E71rYNdCFQxdDy+HW6F?=
 =?us-ascii?Q?aNh0QBeFgHcQZ2mlRZ82bKD3eECmo5kNh6wJy7r+arBzp6DgofY4xsgMQthq?=
 =?us-ascii?Q?kJMeM5wuVt0WZ+6HbEQLD1n9A/VbOOtriMBeXP5gfd/oVTWOWk1kCKSWXLYq?=
 =?us-ascii?Q?aze8DO3p63J1T6qGU+WGw/2FCnnIkHCJq5ag1UnxI8CIg48jua3qzgWgiwcy?=
 =?us-ascii?Q?YQMDpYRzwKLFiIqS1DLm/1UwJmPWqaa8JDeciNEbwM/pPtGn+rwtuWCI5ZJn?=
 =?us-ascii?Q?MuUfWT7hfGqNY/fPJ8+PuimlWxZrU0E02D/+WNtWczKLFLZiVNP76qRDLfdw?=
 =?us-ascii?Q?h3AYjmYGs0ieYNYOenZYJE3QFGETP18Nf5f8oPj2HQoBnxQgB7sp+9ZANPyr?=
 =?us-ascii?Q?WefgVCIzGxHaXTVjh0fQgaeI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xiabSQLakz3TA0g5r6ZuXdxMVcnklz+5r7hHJDzH8vOdh82hquKmvTN6bOco?=
 =?us-ascii?Q?ajJ1QRKGv1St80YYNYG0nIBiyQpH9gamKW6ZLlEpZbztI7ftw82RISg3UhLK?=
 =?us-ascii?Q?k8ub7D3Ji5ba4IER7zd9sG+YujFj4XDyon8OcaUmoQyvhrt+42KqLKev71D/?=
 =?us-ascii?Q?bPYlf9SEppAOT/MueL2TL65/q2gFi0E5KZZYWyplIMrfwQREW1bVt+CZkDib?=
 =?us-ascii?Q?ZkUGpm0RdIguQRNCHynkqzVrWC1NDc4A0ks/mCEOLCc2L3twU8gFbM4A0kiM?=
 =?us-ascii?Q?x6Qt6oCLWGsoaCuqbqQNICkTLUsO3kkCCpJAyMuE0KillOe2pRgOT19HoVep?=
 =?us-ascii?Q?xycV3SSEGu/ZDJHc7PHAekrw+qJBhoEqSZe0jZrqmK6pTGIgSMjWN81G8l+l?=
 =?us-ascii?Q?KA96w6wkLK7Rrwk/6X5sIopWFGwd8rkpbnL0Pjvr9Q4OQPQbcc4Ds6KBKLMC?=
 =?us-ascii?Q?fFp5nNzY2CessaBeJSPBS7xU3LX9MAuSAyOaZVsrQ2zq5Kkv0DUWnD7zVCgG?=
 =?us-ascii?Q?x2il74O7mSsvMGFFwCPoAU6q3B1Gp7dFM2uWZXTk6SFjotJUmTLcDL1427pm?=
 =?us-ascii?Q?3wK4d/SlPwgKfbMkEEHVG9G4WeJIsPwNuRch8OUVHUwFRQJi4MQDL7UpSvvM?=
 =?us-ascii?Q?xodksJuldZWBxuWOFZ+/7R/eIQ/bP2SSbfzX1BWhJfkn5uc+MbnaLlZN6Un0?=
 =?us-ascii?Q?YAdgiayrNGFqt/KmLwb2oGlWw3Lv5t9rt9t6gY6pDIhlXNYjjk3PCn1IilEo?=
 =?us-ascii?Q?jR33CHtssVEs/2+nUPOH6fUzCW8pw9gqi1np+PdVlt8LpM8zZccjS8xVS83b?=
 =?us-ascii?Q?JoAzJLiXurcuB/UDz4bST7b0y0Z+ofUdzRWuenwC/X7MPKGpCIgY6L3+sIYb?=
 =?us-ascii?Q?a62xaEi6wL21ZaneLP0oUKeEhMLCDSraww+aIJvaR9EPWM5t7cr5HPqCy+K9?=
 =?us-ascii?Q?ty0seZl3iGYRrGTY42yNHlPJJWu8YtSIVpkw1zAXE051cO/OLORwhvrALe7T?=
 =?us-ascii?Q?SaTiDvC7ZEPjXoMhCOisUtDbVXKh4PnegNLGTUYPeyp6nM89ZEJo1bFe1vHE?=
 =?us-ascii?Q?SfJhpyYxMdiVQvhkCz/kpTHEhPmvDzfSvPtrcgwANNbiqXuWdd9RPEK4Qjoj?=
 =?us-ascii?Q?DkuDdHK2A46XbLCoM5aAGAFBOAB75+OSDd1sxkfjMVnT9Bpl957YOXaL1YmL?=
 =?us-ascii?Q?5OG1u7zwsJK8bpD2UddfZQQ3tj4IWPfsNhMca6Ok8ZCg4nzU61GLjAs59jSl?=
 =?us-ascii?Q?2OLMSQbcXcrRXLtbmZ1IExyZRss/R4nGi4glWc+lOc2xHJAbX7B21AN8rLAX?=
 =?us-ascii?Q?q2/u5amYFzTg3gx3HJnLrsW3QY7tld+rFBPRf6XXCQsv0k250i++IS/UGXep?=
 =?us-ascii?Q?MRDld52eADfiXHHSHSi5k0LMSVMRk0AlZkIIh2PqagjeUGPye6Bj04Ewtxh/?=
 =?us-ascii?Q?PHBYIvzrYjEn6Gu+gO1PzPoEvd4mU+3gF9wUoN7X9bdMB7SzB2rzH5d03L/e?=
 =?us-ascii?Q?b2uQKMXgxQy0Q8ALDwmvk/6gA4IRCDrvfzwG//V6l02D6ljDh0835NyHnT8K?=
 =?us-ascii?Q?zXKnbJLaa8Azdq0xDZhcdJdX7PAfbqUB9Ll/odgdFLzRFPW/2Vwquhq8tQlS?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1DLbX7wR2Rff4uc2kOCylpFc1SvyYMSqGCFvpxE68i5cuoAgPqL4QeLsJlwymx4eH+9tw66YOA3L2tk3BIvt/gs+hAd9vgjeLT0LuBRneFQpDxcnI3QS8bpB1sJzobSyW30zo/eEYZ7uy84+oiIXxyfZJ3/9IUtFHK0Z7fvHNlDEfslnqYn2S3vzIlt9GMzg5ReXp8Aj5pfXW1JEK41iWHHc7TuJ/bPyB7xJdm38YJYf+HjWiTUmO+MnSRyXFnqYYWI6ZX395T9op7/R3vT1rlIpDR08Pwatz7CFUMw+uJE86twv59xB2fNDkJ0j5m/oBkohhplTxmP4V1DnztEYJnKr1Pjl+p46rtOLGataQoUuzIduP1brtRh3md/wSnwDZE8xn9/sXpAppabOz7c30LolOEHRHo/Dd0zhggncYvhPS4gNjTyEZ8A75iRJg1lCFY9Nmj9gw/6ktWgFMWhBTOePWGx2cEFwZroj81HX69jyHIs8BVPGs+tmEU9/7Yo+YY+iwgY56l4uhL5rsw33M8NTWQLNzOzcJDyM5jfGcNuQ7C8o6oSOhsKx8B1fkvstGQUcTuIe4MrTxZ7JfklHDbbUxs3jwcYfjzM6m4mFTDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2a08bb-5e14-43b9-7acc-08dd05abb382
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:28:36.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xZtGqm2FPInGh4Ju50AM29WdpcwdmoCp1uBS1sxvA7ZQMo0Kh/n1Qmvo4D4hDlx7wPLLBs60i3Wx8rhh2vE/NxOHpVB22B21qQ0O0hupDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_06,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150164
X-Proofpoint-ORIG-GUID: P8TkVOMQ4OP7-BCDglUymfVxvhLBF-eN
X-Proofpoint-GUID: P8TkVOMQ4OP7-BCDglUymfVxvhLBF-eN

On Fri, Nov 15, 2024 at 08:06:05PM +0100, Vlastimil Babka wrote:
> On 11/15/24 13:40, Lorenzo Stoakes wrote:
> > [ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]
> >
> > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > control flow and numerous means by which issues can arise and incomplete
> > state, memory leaks and other unpleasantness can occur.
> >
> > A large amount of the complexity arises from trying to handle errors late
> > in the process of mapping a VMA, which forms the basis of recently
> > observed issues with resource leaks and observable inconsistent state.
> >
> > Taking advantage of previous patches in this series we move a number of
> > checks earlier in the code, simplifying things by moving the core of the
> > logic into a static internal function __mmap_region().
> >
> > Doing this allows us to perform a number of checks up front before we do
> > any real work, and allows us to unwind the writable unmap check
> > unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> > validation unconditionally also.
> >
> > We move a number of things here:
> >
> > 1. We preallocate memory for the iterator before we call the file-backed
> >    memory hook, allowing us to exit early and avoid having to perform
> >    complicated and error-prone close/free logic. We carefully free
> >    iterator state on both success and error paths.
> >
> > 2. The enclosing mmap_region() function handles the mapping_map_writable()
> >    logic early. Previously the logic had the mapping_map_writable() at the
> >    point of mapping a newly allocated file-backed VMA, and a matching
> >    mapping_unmap_writable() on success and error paths.
> >
> >    We now do this unconditionally if this is a file-backed, shared writable
> >    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
> >    doing so does not invalidate the seal check we just performed, and we in
> >    any case always decrement the counter in the wrapper.
> >
> >    We perform a debug assert to ensure a driver does not attempt to do the
> >    opposite.
> >
> > 3. We also move arch_validate_flags() up into the mmap_region()
> >    function. This is only relevant on arm64 and sparc64, and the check is
> >    only meaningful for SPARC with ADI enabled. We explicitly add a warning
> >    for this arch if a driver invalidates this check, though the code ought
> >    eventually to be fixed to eliminate the need for this.
> >
> > With all of these measures in place, we no longer need to explicitly close
> > the VMA on error paths, as we place all checks which might fail prior to a
> > call to any driver mmap hook.
> >
> > This eliminates an entire class of errors, makes the code easier to reason
> > about and more robust.
> >
> > Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Tested-by: Mark Brown <broonie@kernel.org>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 56 insertions(+), 47 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 322677f61d30..e457169c5cce 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> >  	return do_mas_munmap(&mas, mm, start, len, uf, false);
> >  }
> >
> > -unsigned long mmap_region(struct file *file, unsigned long addr,
> > +static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> >  		struct list_head *uf)
> >  {
> > @@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> >  	vma->vm_pgoff = pgoff;
> >
> > -	if (file) {
> > -		if (vm_flags & VM_SHARED) {
> > -			error = mapping_map_writable(file->f_mapping);
> > -			if (error)
> > -				goto free_vma;
> > -		}
> > +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> > +		error = -ENOMEM;
> > +		goto free_vma;
> > +	}
> >
> > +	if (file) {
> >  		vma->vm_file = get_file(file);
> >  		error = mmap_file(file, vma);
> >  		if (error)
> > -			goto unmap_and_free_vma;
> > +			goto unmap_and_free_file_vma;
> > +
> > +		/* Drivers cannot alter the address of the VMA. */
> > +		WARN_ON_ONCE(addr != vma->vm_start);
> >
> >  		/*
> > -		 * Expansion is handled above, merging is handled below.
> > -		 * Drivers should not alter the address of the VMA.
> > +		 * Drivers should not permit writability when previously it was
> > +		 * disallowed.
> >  		 */
> > -		if (WARN_ON((addr != vma->vm_start))) {
> > -			error = -EINVAL;
> > -			goto close_and_free_vma;
> > -		}
> > +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > +				!(vm_flags & VM_MAYWRITE) &&
> > +				(vma->vm_flags & VM_MAYWRITE));
> > +
> >  		mas_reset(&mas);
> >
> >  		/*
> > @@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  				vma = merge;
> >  				/* Update vm_flags to pick up the change. */
> >  				vm_flags = vma->vm_flags;

As far as I can tell we should add:

+				mas_destroy(&mas);

> > -				goto unmap_writable;
> > +				goto file_expanded;
>
> I think we might need a mas_destroy() somewhere around here otherwise we
> leak the prealloc? In later versions the merge operation takes our vma
> iterator so it handles that if merge succeeds, but here we have to cleanup
> our mas ourselves?
>

Sigh, yup. This code path is SO HORRIBLE. I think simply a
mas_destroy(&mas) here would suffice (see above).

I'm not sure how anything works with stable, I mean do we need to respin a
v2 just for one line?


> >  			}
> >  		}
> >
> > @@ -2800,31 +2802,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	} else if (vm_flags & VM_SHARED) {
> >  		error = shmem_zero_setup(vma);
> >  		if (error)
> > -			goto free_vma;
> > +			goto free_iter_vma;
> >  	} else {
> >  		vma_set_anonymous(vma);
> >  	}
> >
> > -	/* Allow architectures to sanity-check the vm_flags */
> > -	if (!arch_validate_flags(vma->vm_flags)) {
> > -		error = -EINVAL;
> > -		if (file)
> > -			goto close_and_free_vma;
> > -		else if (vma->vm_file)
> > -			goto unmap_and_free_vma;
> > -		else
> > -			goto free_vma;
> > -	}
> > -
> > -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> > -		error = -ENOMEM;
> > -		if (file)
> > -			goto close_and_free_vma;
> > -		else if (vma->vm_file)
> > -			goto unmap_and_free_vma;
> > -		else
> > -			goto free_vma;
> > -	}
> > +#ifdef CONFIG_SPARC64
> > +	/* TODO: Fix SPARC ADI! */
> > +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > +#endif
> >
> >  	if (vma->vm_file)
> >  		i_mmap_lock_write(vma->vm_file->f_mapping);
> > @@ -2847,10 +2833,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	khugepaged_enter_vma(vma, vma->vm_flags);
> >
> > -	/* Once vma denies write, undo our temporary denial count */
> > -unmap_writable:
> > -	if (file && vm_flags & VM_SHARED)
> > -		mapping_unmap_writable(file->f_mapping);
> > +file_expanded:
> >  	file = vma->vm_file;
> >  expanded:
> >  	perf_event_mmap(vma);
> > @@ -2879,28 +2862,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	vma_set_page_prot(vma);
> >
> > -	validate_mm(mm);
> >  	return addr;
> >
> > -close_and_free_vma:
> > -	vma_close(vma);
> > -unmap_and_free_vma:
> > +unmap_and_free_file_vma:
> >  	fput(vma->vm_file);
> >  	vma->vm_file = NULL;
> >
> >  	/* Undo any partial mapping done by a device driver. */
> >  	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
> > -	if (file && (vm_flags & VM_SHARED))
> > -		mapping_unmap_writable(file->f_mapping);
> > +free_iter_vma:
> > +	mas_destroy(&mas);
> >  free_vma:
> >  	vm_area_free(vma);
> >  unacct_error:
> >  	if (charged)
> >  		vm_unacct_memory(charged);
> > -	validate_mm(mm);
> >  	return error;
> >  }
> >
> > +unsigned long mmap_region(struct file *file, unsigned long addr,
> > +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > +			  struct list_head *uf)
> > +{
> > +	unsigned long ret;
> > +	bool writable_file_mapping = false;
> > +
> > +	/* Allow architectures to sanity-check the vm_flags. */
> > +	if (!arch_validate_flags(vm_flags))
> > +		return -EINVAL;
> > +
> > +	/* Map writable and ensure this isn't a sealed memfd. */
> > +	if (file && (vm_flags & VM_SHARED)) {
> > +		int error = mapping_map_writable(file->f_mapping);
> > +
> > +		if (error)
> > +			return error;
> > +		writable_file_mapping = true;
> > +	}
> > +
> > +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> > +
> > +	/* Clear our write mapping regardless of error. */
> > +	if (writable_file_mapping)
> > +		mapping_unmap_writable(file->f_mapping);
> > +
> > +	validate_mm(current->mm);
> > +	return ret;
> > +}
> > +
> >  static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
> >  {
> >  	int ret;
>

