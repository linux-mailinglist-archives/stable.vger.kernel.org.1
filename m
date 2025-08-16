Return-Path: <stable+bounces-169857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D8B28D02
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E9F1CC5A58
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C885270540;
	Sat, 16 Aug 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4WYQM/+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmOR6bIi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60E221283;
	Sat, 16 Aug 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341269; cv=fail; b=tGIlVdYdWNm2FqwBSdrclvV7cEVS/d8NrRY9HxbAJZ1jNdosuneuDpNI57GpCPTrZMmKj2iMPM25ZIWfZvAnsFphA3RxrZZOl10Ij7D1v5ZykoZwXiYzsC64pVz8lZvgZCiKyNWa4xijvtAlUMatX+8R24fuIERKvDg7bECpuDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341269; c=relaxed/simple;
	bh=T6cMGb95XiFS4gn0R2i2BK6+4i/I4dy0s6jgazAqL38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lbu4F3P5jI+VXr1TtVBlQoT75PbIcM7lzy/haTnNM/2iy1ywSe0HdTzkmva95KhmgVGhBLzounD+f08uiXBxWFLjWGViMYUysQqwQ7PC6n/7CqQsaNcwtCvE6/OcUmg6CO+fMmusHQH4zMwbyiqzFOcnaQ6lBOtahZxYSKhKqZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4WYQM/+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmOR6bIi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G6fCiP000565;
	Sat, 16 Aug 2025 10:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BBLSnYLHdQHIajg68L
	ryZNQ7Psmy33r3wjTO7b88+jI=; b=E4WYQM/+lKsxkb3AgxXYshspXoVztCnA++
	77n5b6sdbJrx6xs8v6NoRJgTQICXP2P7ZLeWrKzDMZY5y4DG2gip1yd1JqCR1UTV
	IutXAYn7pzQIvR/5MpaN38gxQdVL7Zs5fQd6T3fF/85ldKot4YIOIi2ju2EuwiN8
	j4dWfzHKq5vwXR3buAM42VgbskWsxb/+hrNJk/LxkGSP+cOSTgPqrRkZiOlGwyVY
	mf7AbjybrvQglIYknEThnhFBqkAgk6x9Ob8XT/bBvJEmSKwpRf5EH3olAWEQVyBB
	4dcyap164GyTCpfVzUeViesKQ3SgJt8Dy20eCdeWNZX4Whjc9sSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgk4gcrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 10:46:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57G964nh040803;
	Sat, 16 Aug 2025 10:46:24 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge7jbn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 10:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1z5AddVIpldozZTsGdzV9zKjhvHFankhe/wrGYhE6rFNHKErzthWEpQ8HGGrcUtrQV1sHohh6NVnHJk7Gztf5fbbgvWHE2r5yDpaZZEBzxSd1H567VtwopxLCp1amqkzhNOU0xhneyiRWAIy1/wQMfEFO16sINZeWnveFl5ZkYpfoSqZE+V0ztTHlzIm97WJfdXkSCvNAX/Qud131Px/Vi7/oz7JB8uCgM8hgLIFX9gHUNVCYjpnX+PP+LwiMyFG1bfALv2UOe1YdW2+4MXBujwW8Ol3lzsRn+0zZ+c60dOnR3oHOFVqUDkff8AjLerSvBqO5yA5xomba5IpZ9TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBLSnYLHdQHIajg68LryZNQ7Psmy33r3wjTO7b88+jI=;
 b=I/dc0+bBTsNGoT4/xIrDGJdo+N90h+INQ23I9b8YzadFWDtoaMH07XE58ofnKKHZ5iIsVAsUxZEdTb/uQfx6B3/6e7x5beNphm43jHLrs3iTd0QNEZooA/Coshv1FK1DLx0lF+W9WN+pV4SoLy2mLD0IBSGmbJlL4+CS8Q6zcPYA1mNUoTPuL5wLcNCZr1ch0nWVRBA83/wgQMF+EZOmkAjQLdRpyYUWP/HjhrqoLPDRb9zcJyK/2LPHJNvxLdVnv/wBTtqX569wYiJWRSd/04/+k48/wFesHkVDbCAoG/ueQxOXWisgsKPRyDpBBltNytW4ILyp+gc0hJqFm1A5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBLSnYLHdQHIajg68LryZNQ7Psmy33r3wjTO7b88+jI=;
 b=kmOR6bIiISkIrd5JSdeRoCPRvM8PxCzhhnpGE5PFGKlIT9dOuZaEzPmNmch3vlotko4LCwcb6M8TWukmF0LkYbWZoybupVp5YM+I4wuSUb2e1r6ciXJS3u7Laroc2xBxIb5e/V5mU7cnYQWMCdjC2DawTqQ8ofnTwq3w+Nvkzv0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 10:46:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 10:46:21 +0000
Date: Sat, 16 Aug 2025 19:46:12 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: yangshiguang <yangshiguang1011@163.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re: Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
Message-ID: <aKBhdAsHypo1Q3pC@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
 <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
X-ClientProxiedBy: OS7PR01CA0272.jpnprd01.prod.outlook.com
 (2603:1096:604:259::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: a127fc79-3f65-4f00-efab-08dddcb2232e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ux+bxEgK6K2YxeQajWlN4DmysVY+DKs15lLgGzjrzPZtDor0H5dAUnguX7tu?=
 =?us-ascii?Q?qUlHLYH3Cy38Y6fR7vmFYEZreCj5hmBdtNVCk9kQX+xPyF6E0q9OI/LPsi45?=
 =?us-ascii?Q?9ppq4W8l62Bfhu50bHEVR+FSfqaL0GFPjCF3kv1vrdek0a3wy2asE6pke39h?=
 =?us-ascii?Q?+TaL08YxdfoJRJxiB2Nx0Dyeou5cEW+nppaxnk47jj7zJuoccx5nin7pnb+u?=
 =?us-ascii?Q?nV1chNe6lNK3TbhoblTX5kAQ/PB92RGZFeoa1z6b2/IVLtvvaSHWIzOcYuhO?=
 =?us-ascii?Q?PW+X6ivxF6rqYv+KrPzecgrhXay5VGdkqcgkVeCx3jm2Kj7Law37Srz7ypuj?=
 =?us-ascii?Q?DOJetDxlc9BdZO3LBPSQd/F11/Wb6E5wVWxVT1YvT0JaN55P6F0R4ETfCYzT?=
 =?us-ascii?Q?lThnejVY5Koe/OKq6RZuxPiNfmVcEpFIHLaTUmvPKQNOrH29nDQYD+VCwOQS?=
 =?us-ascii?Q?ZCZmYYWaORKR/PZiXvDmSpJnBbYLBJKu04zxBRpRTdV44iAteDxBAFPttedg?=
 =?us-ascii?Q?lS8YicYzFLr/yK8gc8zm8luN3W3HI2f6XFwT21tb8b5IFCF3ES8LSfrBoXB2?=
 =?us-ascii?Q?93Q7L2U+YcPvbwTDdrk2A1ohGMpu/79VI0Ei9KuDXehU/+7J9auUkctX8Nga?=
 =?us-ascii?Q?DT7oYF7u09rDDXl/XFC8g70T/ShpquUEQu8nV7eNjN/n0rtKteiFaSUalap7?=
 =?us-ascii?Q?zxrHxjqZ/et//R6G7egU9MiNM9crwhpQ4hAPC3I4kA9f6rNFPDItRrimFYIY?=
 =?us-ascii?Q?8iaz+dwS/jw1ZnSI8f3IHvbwPGh3XzHT2XVbmFfXVcqdzwOjTzFcVQn6VgDG?=
 =?us-ascii?Q?gYo8rcrfpAFSpveO7AWzm/CauWBe5Uk5PZ3NVWnT/DRMElU5SW7E0tanbYXQ?=
 =?us-ascii?Q?aMMOBwcfZNX9LizNk6a6Tu86KKLQ9mp3vzc7Dd69yLDTQK++VoDAMNFtiEpC?=
 =?us-ascii?Q?Pfrkx+L4JWaI2QDvAi+zk+qkbwR2CTNBbDd0Jp+p9Uy5mJvV9ESuX1cwHAXq?=
 =?us-ascii?Q?jmHe4f7B+ha2rMc8mioaJL8FN0BH/XHkRAFAL8jPwf2RCJV8Xr8B97FrH8C/?=
 =?us-ascii?Q?OatrjrhOB6dD1nKDIECuW9zPQRAxbYM5UwfhJxL/xOdDhZw31jBAOENm2QUg?=
 =?us-ascii?Q?u0cyOTLQJM6vH9I2cgNlL3oj7o9LmMHXlCp/Wq7olb/VCnWO52l3dyeUkwZN?=
 =?us-ascii?Q?44viqTjuMiXM0DqhNDy0hQNKhB5V+B6flp+GjuuGAViOo7RbhVhjcr1jT5dh?=
 =?us-ascii?Q?0bcGMEw4tKIWF557U2UOyQHJnCyH4izBX/yk6eVTg2PNMgeiuUGhBTXwk2Tj?=
 =?us-ascii?Q?qxff2QbGOtiE6wG89itohxJIbftLs+yrcn32vmO7qSB8BPYjnRXTjZ64i+YZ?=
 =?us-ascii?Q?kG1UdYL72lsQxbjut8PuYCEWU4dv5z4XL2IwUl6b9jp15OF/8Wn5FsYHq+By?=
 =?us-ascii?Q?0Ubd6nQuRBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTW/0aW/j4zAnybU6v5IchCziMCsP7mVUwW3ERnSPOmalyldzibhcuAFM6aT?=
 =?us-ascii?Q?dl9omMVwZe7zIIL1Gf36V3iE7GxKhwr3YRcNebSVyEzNysYD6i0/fpINK3Co?=
 =?us-ascii?Q?wfJTsuXxfijNf/rNRm5EdI22sEkOG93w2IFVQFNySz5HKh+nUKrikGU3VgaX?=
 =?us-ascii?Q?GeaQAgVZf/pHk8u8NSUwcxJyHfVbmq31Qww4emLe62ic3jyAHdi98CU8cXG6?=
 =?us-ascii?Q?FMTGxjchHwe/zgz2tsk37wv8JN4aOCb8Ayp2TJw8+8DqRGXxktu2TaWChc+T?=
 =?us-ascii?Q?NoLm2bo5MWemrmUVCk+sTJ01fD2920GwJVv1BWUxnGSyQyTkFnL06rN/guLy?=
 =?us-ascii?Q?+ndWOoJq/iDkiIApjNWry+eYeJqrufM6w69DzTd1iE0ClPFZTdHL7KYz3xvS?=
 =?us-ascii?Q?CTd9MKoiL16cLWoxKUCsYURg3ivW/59s10w1C6uXgbFMUIelzZYNbhQ77ReR?=
 =?us-ascii?Q?A0Rg7RI0Zvdsg65RJT2YNcjR8J+KoiZUblhAEuPBAYhk1fd3J5LH5kkLf9td?=
 =?us-ascii?Q?pL5uWZz3vXrfZS5ePf38cw7yd4gudJLzHmG+Q40OEQrLyy4hyzlEE3KP4UBf?=
 =?us-ascii?Q?SbxAD95rD3gHXfL/2QCthG+bRVsUvTuz8RcE1DflWTwDLZ4+QfbGKKGIEynr?=
 =?us-ascii?Q?JH36xClnhJ0fdWCRW1YOHSEt050HBkJhbtG7NwRHnX4PBC9rTptGhiGvfyws?=
 =?us-ascii?Q?cISz1LwZcxl8Ljz4bRiYpcbRAHkyPFdh7HtiP/YGW22hYZh/pWbqQKcphqjq?=
 =?us-ascii?Q?k7wlS9up3n8vSrX2j/S99qmm0YSCzY8FAVPFAWY7JVpmsK0CcbShHH0JCr6O?=
 =?us-ascii?Q?3jMbAzvezNvvMziwEqpsa4UVBCyjMR9M+pbgze7JkNQpAsyrxlSLNnqRKv+N?=
 =?us-ascii?Q?ZgbIBDsSB5GQjpKodI74CIr8wEyG/E8AFzdGUfwTouMM61wub5zHX3zN9224?=
 =?us-ascii?Q?f1a8JZkJK1Y8uowz7u7e1MHqTxEuSL6liPt9RpLlNp1Jc7q/ODDq2C5K3oDi?=
 =?us-ascii?Q?+yhmslStAL+wHbs1faMrYTqWAz6M6fNcGEQL5zycHDjWmUzgQVTZhsecOKI7?=
 =?us-ascii?Q?17r6r9zM7/qbHl2rI30lUbB4bJk7HKq+Wg2ncfgDFEEweX9rtZE21xZG0QpM?=
 =?us-ascii?Q?heT3UyL8YhbAt4R5j9N1hvPEtw+fw76OwuPPMkZNi2oLww6fS3pjgjfWQ5Vd?=
 =?us-ascii?Q?eZTbzXjBQnWMc363ptxOPbsMjzOWx411GzuPRKc+dHcIiQVQqF+OLwdVIds5?=
 =?us-ascii?Q?rX7PMr3+MYkVklOxJCFj4hQ9X8YyW//jzx9P59AHxojG1DNtwBHaESyULc2f?=
 =?us-ascii?Q?VLaJQAQsUDJEjv0kBShfadQ+uis2rFL9dAlPJFwtS2AKz1838KyrdXjtfKRD?=
 =?us-ascii?Q?SdoWfDQNpp6AuY5CFj2jw0BEMWHCQ+MV8xLZwSIDqJKkbQDmFXhyVwazoKc7?=
 =?us-ascii?Q?Fh5pYfmyxu/urXUi974YsHBl5gqr0YVnjFI+TRPFd4oUA113BOMFqtFFo5XL?=
 =?us-ascii?Q?UcFeKFQxp/G+gLTtEFodK1fxiQIwLt9UEvWcr3xdP8Rdn2K61CZ3EQEN2EZk?=
 =?us-ascii?Q?MLXcvR7nZMtVB588lN/4htbvoOHOj498dJVstavl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fyK46mNC/vQmfTwgmcWxNx5lb/J0/8dNcFY7fX+FTs8OZ4x4eGNsbH9rpkkqfN2xdSXmYMXl3YMpSxUSBua40q55bRmWsI7mC35EiE1MwDDmVJ5ocmXZIuFC2IknJXoV0PMQ0rgDxLrFdtBQFAypqm+KLGRJgf5Jz+QUjTBqjPZGHmnBpzZBLx95vDl4I7U6t/EJw7tJCkonB9sqPPrLZaskdegFVUKWaI0IsADDpJr3sg0cTDSOpgtP0yFMZvHHcdqCLqafgocKM2RJMG9thOJ/fqyLgVkYRpFV0+iE39zUJ8sgZz/3HavMdeRC35eqrsx9cI/5xfxUm9qO/PPV+EZexf3RgYXcFo6dHV0pzUrSn+1BVtf2GPk8AqLbb13/yVfAlR67oSLO2ITor6f7FeHOjEA75ctMUbj1qX+oBbKMxm+oeuzbtQCft+iDXwiQI2tsWUMnE0+5lgb8r+9R0Qx5nemnxNBHDsnEjXT06xRZZUnimqmcF++Bh3WWCvvQWiSny+DVq28Bgdlw2h+VuyZVV08BKPGFhUFaR1ioqGf1Pa38Cc00q5gVIh0pkA5HLWWde1CvtwQOs+AdSe+JZhw+Sz0w98L+Tuy3op5r/kk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a127fc79-3f65-4f00-efab-08dddcb2232e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 10:46:21.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmv/KWPDdXtTBlW8kVbdIZj1z+rCSGxA7mBC9IesV0b8buoJXMBAcihJkRjl1tVb3Tf73wJFIVjQdo+iYAKnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508160109
X-Authority-Analysis: v=2.4 cv=FdI3xI+6 c=1 sm=1 tr=0 ts=68a06181 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=yPCof4ZbAAAA:8 a=IeNN-m2dAAAA:8 a=ezb5Z2J7aYlrO0PX9G4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nz6rwijb92QKCW9bQYgRd29ff633zzQm
X-Proofpoint-ORIG-GUID: nz6rwijb92QKCW9bQYgRd29ff633zzQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDEwOSBTYWx0ZWRfX6GEirPSvojZc
 X6h1lmK0kpghrwimXAOfWrD9kaCGTJG7J2V+xmuEs2rVvSTgZYfLcKMJdVwZKW4iNmU3oD9xJDu
 5hUcPI2TbjTnqcFYW0MzvTKCqfBKD5GEKS0rmCHEIK/062Gyd+KgGGngNH/gAaXOIclkHudTJaJ
 lsAskikkvxENg6cYdKpoCDRZCcYG7rveMqR+oGk/whltT5fM9E4x+sKDQTv1trPEQiTwxBVQXWv
 sDlOfDRrJtgdUD/EOgQbol8flerIzyWSuoSELIw5f46bSKvdNv8Lm3Yib7S8LbFtpA/MnENIGBD
 umGL3wHDym9H4SJTDqQXnq4a/uc+kRSigK97Q8Fov0aXOB4i7vDyTLkkD2FGR33EuhYYyi+VWVY
 UPMdro57aLfYMw0UnXrTgOInm/9tQ7BjqOtgWaBOMwY5gDsOXuH8bHlsVRiIt0vt8bcyJjk4

On Sat, Aug 16, 2025 at 06:05:15PM +0800, yangshiguang wrote:
> 
> 
> At 2025-08-16 16:25:25, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Thu, Aug 14, 2025 at 07:16:42PM +0800, yangshiguang1011@163.com wrote:
> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> 
> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> 
> >> set_track_prepare() can incur lock recursion.
> >> The issue is that it is called from hrtimer_start_range_ns
> >> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> >> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> >> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> >> 
> >> So avoid waking up kswapd.The oops looks something like:
> >
> >Hi yangshiguang, 
> >
> >In the next revision, could you please elaborate the commit message
> >to reflect how this change avoids waking up kswapd?
> >
> 
> of course. Thanks for the reminder.
> 
> >> BUG: spinlock recursion on CPU#3, swapper/3/0
> >>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> >> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> >> Call trace:
> >> spin_bug+0x0
> >> _raw_spin_lock_irqsave+0x80
> >> hrtimer_try_to_cancel+0x94
> >> task_contending+0x10c
> >> enqueue_dl_entity+0x2a4
> >> dl_server_start+0x74
> >> enqueue_task_fair+0x568
> >> enqueue_task+0xac
> >> do_activate_task+0x14c
> >> ttwu_do_activate+0xcc
> >> try_to_wake_up+0x6c8
> >> default_wake_function+0x20
> >> autoremove_wake_function+0x1c
> >> __wake_up+0xac
> >> wakeup_kswapd+0x19c
> >> wake_all_kswapds+0x78
> >> __alloc_pages_slowpath+0x1ac
> >> __alloc_pages_noprof+0x298
> >> stack_depot_save_flags+0x6b0
> >> stack_depot_save+0x14
> >> set_track_prepare+0x5c
> >> ___slab_alloc+0xccc
> >> __kmalloc_cache_noprof+0x470
> >> __set_page_owner+0x2bc
> >> post_alloc_hook[jt]+0x1b8
> >> prep_new_page+0x28
> >> get_page_from_freelist+0x1edc
> >> __alloc_pages_noprof+0x13c
> >> alloc_slab_page+0x244
> >> allocate_slab+0x7c
> >> ___slab_alloc+0x8e8
> >> kmem_cache_alloc_noprof+0x450
> >> debug_objects_fill_pool+0x22c
> >> debug_object_activate+0x40
> >> enqueue_hrtimer[jt]+0xdc
> >> hrtimer_start_range_ns+0x5f8
> >> ...
> >> 
> >> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> >> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
> >> ---
> >> v1 -> v2:
> >>     propagate gfp flags to set_track_prepare()
> >> 
> >> [1] https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com 
> >> ---
> >>  mm/slub.c | 21 +++++++++++----------
> >>  1 file changed, 11 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 30003763d224..dba905bf1e03 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
> >>  }
> >>  
> >>  #ifdef CONFIG_STACKDEPOT
> >> -static noinline depot_stack_handle_t set_track_prepare(void)
> >> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
> >>  {
> >>  	depot_stack_handle_t handle;
> >>  	unsigned long entries[TRACK_ADDRS_COUNT];
> >>  	unsigned int nr_entries;
> >> +	gfp_flags &= GFP_NOWAIT;
> >
> >Is there any reason to downgrade it to GFP_NOWAIT when the gfp flag allows
> >direct reclamation?
> >
> 
> Hi Harry,
> 
> The original allocation is GFP_NOWAIT.
> So I think it's better not to increase the allocation cost here.

I don't think the allocation cost is important here, because collecting
a stack trace for each alloc/free is quite slow anyway. And we don't really
care about performance in debug caches (it isn't designed to be
performant).

I think it was GFP_NOWAIT because it was considered safe without
regard to the GFP flags passed, rather than due to performance
considerations.

-- 
Cheers,
Harry / Hyeonggon

