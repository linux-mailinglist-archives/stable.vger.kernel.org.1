Return-Path: <stable+bounces-135094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F49A9679E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43313189E68D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79027CB0B;
	Tue, 22 Apr 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgvfdOKn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mVPCXofC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD227CB07
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321560; cv=fail; b=gnJ6cN6iU2HjwsVHrnk1TtcTj1SGB9Yv6q/5PnDDUl88rUg5CcANHZwloGXiNMJ32mlZiLXEvoZztwTrCpgFuhBvJMK2tuugBKIC5TeMwWpFkQoMX1BabwwkE7WbvL8gHPA5g036cPawTQR+9aTn1m2m0TX/zHcnw5UjM5M1Ppw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321560; c=relaxed/simple;
	bh=kj3G7Y5NrDWtFpOUjuElZACLMe0T61sN62tZf65Sj+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhUOhc8dPGEFr1yHE8lv0O2wa3JCF3D5urLG9DTB2BPNN0UCfArzpQGU7Nc5XLtq2oYXsr8S8KbHsS0i/Ux3Be5Xp2o7syGOIeIr5CW275Rp5zOi6kZr91eGxZra6medYZ8dIVe56yOa7XhKVi1T9+Uuln+mTpIOoal81mF4ABM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NgvfdOKn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mVPCXofC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3SaF028138;
	Tue, 22 Apr 2025 11:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Akkwo3P483Mkz2w3k+8eRorOxAk/I4CyZ3jENSBqng4=; b=
	NgvfdOKn1nxJSp8gAomqaq/XlACMFsyL5flgDAp9Gz2vJUKkO82hyyppPLC/ECcR
	So+QWshzHv+9PFfJP8SMLlMk3T+nyHXrO0OTEvwFHjynFAq3V91mcqvlFiMLoM77
	klIdYFjKHVFGaR93STHFQ0d3R62DwnhN/IteBRqM5rAfivycPwPXSFnjspiiA4q2
	hwp8s0SOR8gJaigyWYMDiLKG2jNt7iSjhTOu9y5KLdXg3ZxDGabcXEgsHiVdR1v2
	lOLboc7rssX94rLweqQk9AsxaSJqmtfrmvJJ0gFGYodc76rv6a1ZwzaAxG/5Hwfj
	4wrTfy4OZrLpL/GnFsrh5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643vc4cd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:32:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB2B7M005783;
	Tue, 22 Apr 2025 11:32:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 464299fht9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxkHfVufaffCFu+SNhrSATfS3mZ7IoWdwlDKHXiLLHccUdewem1rRkIripp4OmazYgfKl1olkKvU6iftwJX/wltDyyjwOTzIFGSyq+9EFG1RmbsdSwC5glEAkYURAYBOslcPpJ+YloPPxKO2Pt/UbF9Ds+XYKe2KMf9E4+9cDFOZAaSs+a16R7H5W8HR/CFPZ2qYNKlBuPwMJkewbkYy1+nd/L8q/8ho4Gyjs2DoyXHTIC4+ozkt7eJSSK/hyBgS+mER0Rowb4D+u057FYVegtpkOms49d/fHpm2wic1gjDsPt9aKikLVzTLiKi295kdY0pKs3hZSZ/T6K3iq8VesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akkwo3P483Mkz2w3k+8eRorOxAk/I4CyZ3jENSBqng4=;
 b=vYlVkAx9HFhJ0InSse4dxgg0pB0SN6tExy/02n7P2UDLWQi040DiEbLX+6ml5820h1bwQvHc5BgxcVKlp7QroiRMWvjFgfRVgl05NhGwVEXqQ9Tah4SPF/E5n10orwsoa6E41YVRk9UTfADWGq8SlhyHLLauZFiBZbCgd4leCbj3RXmOSeFmm68BcOAu0fbItoOTsN4Q+M3j94ws4tmt4x9JO6Y7hvHKHsO/rFFJO0D97J5GjtXJ8vQRaMUzYqUbHb3E9a1zo4nRiI+lpZnL6qfPHh2Mc2Dz1+RiIzZSsTsdoyV1W5Q89p1L7GN5qy/+k4dOcSDXgSR/uZxpnB6E7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akkwo3P483Mkz2w3k+8eRorOxAk/I4CyZ3jENSBqng4=;
 b=mVPCXofCDVmiMU7EGsCp5TpWhgKtP/3z7Fer9w1nfE2PBv4phJhncRahc5WouG2Zwc3ZhWbEU2999Jnvrz/iZBijlgXltkFI4mw899J8s0NkwAcz0LsOXPFGD3yfS2U8uSgQpyW2DgY+PiPMME9zsjxh+7DnPSeJ7BztrhZ1INc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 11:32:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 11:32:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 6.12.y] mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
Date: Tue, 22 Apr 2025 12:32:16 +0100
Message-ID: <20250422113216.110404-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042101-tigress-ream-51ab@gregkh>
References: <2025042101-tigress-ream-51ab@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 32928b95-94c0-4d97-4622-08dd81915e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAtr1IPvki5o/BUkBHj9I+/b1kREZY8NgWc6yZE37XHAefsNu9lhL0j8DisH?=
 =?us-ascii?Q?hr8ofq1fdXgfNtrXaYAbO+TXqBylhhfndiUo5RqU4GXmS8akTrarPXlobOcl?=
 =?us-ascii?Q?VT5fCZkhDJkeO2GusXe15bzO2svcFSCrJ241E6xe9d617xE+vSVkEsZv2JiK?=
 =?us-ascii?Q?M0PKfD9WvS0mp9W7+6UnN8jB/eF+u/dMc6VcwHnccYs5Q7llYeWDyQDPBFdD?=
 =?us-ascii?Q?VqoDAlNHU2ZhgpkuhnTolwJksXr4b3DlPjKBspKbOtTN747dIvjdBoqK5Fwi?=
 =?us-ascii?Q?hpyGo7PP+6KKC82cDU0vaMeiMXdAQdhIkD9N0rD9vyovcGGYG/KM2JOs6doQ?=
 =?us-ascii?Q?WgaDyU9CR9xgFIcLp3mIZ/x+1FRM2mkXUwzuUDjGqrlb7gmhE8OWh0JflU+i?=
 =?us-ascii?Q?TD0pF7JFWTIVjMwlM7WFVteg9B7r39/30XRXRB8msn0eLIfmjmUAONAL/HEm?=
 =?us-ascii?Q?jeL1nqNs0HtJkPjzUMBY5sVFeLUH90BdzNgddM/iH2KHO2MUNC7SvwnRfvck?=
 =?us-ascii?Q?2L/g+0IIl/7OlmvqD5PLxZ2YtrDu6+Cvh/WYCd4ztRqwzsm/ZAri8Txo0dJR?=
 =?us-ascii?Q?K40dcyCnMYCBwUCsNhFEdlm16VjRsFkdlTKDkXA5we+VS/n5a0nTxrVz4S7E?=
 =?us-ascii?Q?0DOnGcvUxEBQpPel8hETSSVQB6/FOd23g84bcHVWuBpNqutJjfD9Cm0Bs0H7?=
 =?us-ascii?Q?eKJFM6VOLvZmw0/74btzlFR4RzPHWxWPVhd4ysXm3GA7sjO+eRquOD0PMESm?=
 =?us-ascii?Q?0GrviLcWQrjWFISwbZ0yFu2eJM/rR784JtKlDRIhhLj4tituzxVhsZd8ItLM?=
 =?us-ascii?Q?6F/WcAcwqBbpcF8cD8RyvFvEo8XhWXYTvBCxT+eIAgKGWf0aOzVlmNXRtIQy?=
 =?us-ascii?Q?wJQbgOMnXRCz7+WBUfAWEPQMEy0mU56m1J8s1gReAlJmKsYE0+9AVLKvhcV4?=
 =?us-ascii?Q?4S/Ty9FeQijqXl2GNjyscnJ9Nh6VAvPZXM/P29zX8yYkJEyn25y1rp2cr6cP?=
 =?us-ascii?Q?O8+tRpuFjkQrsBeABrUMMbiUJXqTY++B1CmnhpSjhzk/eP0LIKBASlSM0zoa?=
 =?us-ascii?Q?HIL+6EypXXSkM/HMQK6UunNsoXZpHKCGuXg0mdHFQwvvB+VSbLCxK0/DnavV?=
 =?us-ascii?Q?BoMQgviWakBCcGCkqh0r/xmpjhavPcZyfT1slgtSRskg3Up7gu7a13EOF3Rp?=
 =?us-ascii?Q?fSW+nDlbEDIEpcLSA/4hH73M1zQHxO6C1wOZmrDIRrJQ6cH21C+0AXG7Wo8f?=
 =?us-ascii?Q?mRa2jfphmL7tAmOC5Di2Dwnl1LVxG5ecZ7L7dssRJaPdOv0slnayA59Br46t?=
 =?us-ascii?Q?QoWbqmzBWMy8Fi8hRUE+bg2rXxfwflPQAvaDXqyOq9RgZP+oe6egLV2LTfUj?=
 =?us-ascii?Q?iiKeDeMn6VS9Yv73SDw22oCHV3IhkkiitW4bzY1a+nKkMACU/93+BhTNdTka?=
 =?us-ascii?Q?BW1JV0vB4Ro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fIiza8G5pCwepDI67I4TjHcooQ1oQOTmS+lgYyberdmUKX5/YRwuSxVWS2dA?=
 =?us-ascii?Q?wIgkIxI49mO3fVqm8iXXYISavbKYdnjHQTZS9tSqkhljMiWYKrlaHmxllG6E?=
 =?us-ascii?Q?oeUkR3osanGefFX+r7pSlrL6WKmwGOrrEQwJAHwe/jv7ZtRErjfKHTpLtMCH?=
 =?us-ascii?Q?XFfXJqgPt/7B7jNjqE4jL8JygrnXzB5d46ifaBBcrzW5iDY8+WUPR8smtAmS?=
 =?us-ascii?Q?GRxl/+3DazApUUeMW9tq99uRYPd+jDaOx0rbQ4wSGHI7hVzk8BFrYJw+XcNV?=
 =?us-ascii?Q?+kpMLfDeLeAJVzSwWTh9aSw3xaUFJmPVUeY+Skf96lllqJDbIqXerErqV/+o?=
 =?us-ascii?Q?r9fg2A5BuxtVsfBabsXpEBXmXLJUZBlRFDG3IKexN8uMfaOfpbTMnqLMVIcR?=
 =?us-ascii?Q?aWKPMrDZ3WdZvoynF/KYlMEbQlTXtKwlFv0Bf/GIoj7EhLhkqL2CRtWiPbi1?=
 =?us-ascii?Q?nffUszptPrNhpUDPBnXbDP9bu7sRgzcw1sH7c9Sei5gtmY6pw5uW1679x6/e?=
 =?us-ascii?Q?xADVmzzjDYd95iNF4YN+5hnuo016DFTjcbHS/eDVlQcljjm+rY25XTxGPdtl?=
 =?us-ascii?Q?6pzQzgpMgVsCZahTF8QGdERIhgy0kK1g7+0jnsXHjvj0wNrMlO2jz/H2fQ8c?=
 =?us-ascii?Q?0Yn0jyeWZTFn4C4stbZXJjeCcJecSf36U9yv764Az1yYOPzowYyYejctRNto?=
 =?us-ascii?Q?5JNW/mx9ChdjqqkmhCZUpXw39tg9s6BptnmRaZAILK3eBdNUogloX+/uUA6r?=
 =?us-ascii?Q?3mTmHxt2HcP/74OPdf24bfd3mC8fkG6OkTt45oGvk5b0AC+7VIdtFmvbDaAr?=
 =?us-ascii?Q?dA36xeRsJbwa4tZ6nyGgtski4lN1Pzt2Y5QLo3v2KhVNT8nhRnJeSUbt74sr?=
 =?us-ascii?Q?su8TiT2GayM9uhOoFZNcP+NQJYgmDMhEApR21sIQwnbGQosivGb+f6H/XR4F?=
 =?us-ascii?Q?upFWqmi28YC9SvvBF0X6+eWZNSi4YFxmIvSZqHWgBfqZjHFrxezoQiO0XujT?=
 =?us-ascii?Q?JGMCYzTaV50Drrp7odPW0JMbagLd1Xr6PDNXvBOavbn+WlJarHM7YFywJW/7?=
 =?us-ascii?Q?M3ksa8laknoJRTOVfbvojc0ocvPJaENF60SZcMv7OQ1olcxapSsSITzKGN3h?=
 =?us-ascii?Q?FppSXpjG2Rx29oYvc/gwNlOG390E+L5CWojsRBclDf/LkP77jk3lhYMeVNpm?=
 =?us-ascii?Q?WJn34wYhaQduUbPCMKjJI/H0yQoXaWo27htx4oDIn3f9dHfQ+Z3lQtW4BVgG?=
 =?us-ascii?Q?llDahhjdG+T7mmqoHFwj4918dVpSSOLoApXq5DqsG7lNKas8UDotn7z7J2ap?=
 =?us-ascii?Q?Vewl9oYg4LyzR78IBDlh8Fg12ngeVk39a/RFWxtuFgddFp4DCFd7jzYFER5n?=
 =?us-ascii?Q?MqhXN3/jVNuC+aI4fUBm0iK9aKFKhfzsJBWt6R6IDmEEEmbxIMWqFnsqQ0ab?=
 =?us-ascii?Q?iY80ApI5ZhLMePOW/8yGFDzp1acaJ0hk8WK7s+zfDFuXxLLpFhVfEFn3J/5p?=
 =?us-ascii?Q?OrIZGlFhULKWCIEMZts6PbzyKdEUcGk2MtlvoFI/6ltTLdHgYn1QDtqbIJhy?=
 =?us-ascii?Q?FEllxB6EIJYMyeEd+CSHQv1mGbpeZUnrrxc4bwM3Z2iGGQYt5xxsXcb39tK6?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gIAr1QQ1T1Ts7Tcv+jDQvjzCfFM5H19QbcIjss2VCXAkwi3BkwKcD7jDLzHiAhuNcMXQNUps8UdzP9qo+BlYTFpKlGR2H9Dpr7xQ4SajSgHh1EdzHKleJ4me/74fq0R0RrT6ZVQx5YOv4ZOXQqOZRqfEWZA+PztHzRZVXa08Pe6rmKEzLxzeiWyrgGY4cI4MKPM0cI+M/EPTML8/YVds/QAkQauNMGxkXyVb9L/6A2MYMzr8+tQsW55dIFwQRS9iWlYibz2gO0yjOEY2aDG0MWaKVVIU29t3rz/FKvTaVNjnABsbr7FJPZynVFfl07ZFCbnwkYsq18rgRcqWuSjGPHMHs9FR+QctOLJsxWih4+NwIJfhGtQAQabdtjok7di5EcojY6biFHZITNzQeQ5rV7EpQU3qJzTGbLyuX8hzEvm3BQqsMi3LfQnD1LFPzbs2HxBVMmy86qfhf+XKE9ME23nAPfbg0v99RDiAI3bDzFqBYtH+j+K6Qukt5DP3/t6nRm6qBE7pDW0w+0FhuzZEw8OXSfzEeDCl7ZiFNDLiFIeOkp0bQdS8uvjXmRZMN1+M16GCCgWaEbcG2cZOfvuKpECM6v76DB47jiVru466qZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32928b95-94c0-4d97-4622-08dd81915e6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:32:31.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoMzQWYE1KBfW2dO+LjantznkV8BjLacT+FraNvFhajD45r78qMHVl43pb+TiyQzZ5Vlkdw4Mh97lJrIhv+9OJPATaNcAqSmtUCymvu8PAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220087
X-Proofpoint-GUID: UdWmv6PmoCkxEjAtEgc-_w5rgiL2KavH
X-Proofpoint-ORIG-GUID: UdWmv6PmoCkxEjAtEgc-_w5rgiL2KavH

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
index 080a00d916f6..748b52ce8567 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1873,6 +1873,14 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
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
@@ -1880,7 +1888,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 
 	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
 				    vma->vm_flags & ~__VM_UFFD_FLAGS,
-				    NULL_VM_UFFD_CTX);
+				    NULL_VM_UFFD_CTX, give_up_on_oom);
 
 	/*
 	 * In the vma_merge() successful mprotect-like case 8:
@@ -1931,7 +1939,8 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
 		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
 					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
+					    (struct vm_userfaultfd_ctx){ctx},
+					    /* give_up_on_oom = */false);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
diff --git a/mm/vma.c b/mm/vma.c
index c9ddc06b672a..9b4517944901 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -846,7 +846,13 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
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
 
@@ -859,7 +865,15 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
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
 
@@ -1033,9 +1047,15 @@ int vma_expand(struct vma_merge_struct *vmg)
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
 
@@ -1428,6 +1448,13 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
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
@@ -1496,12 +1523,15 @@ struct vm_area_struct
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
index d58068c0ff2e..729fe3741e89 100644
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
@@ -303,7 +309,8 @@ struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx);
+		       struct vm_userfaultfd_ctx new_ctx,
+		       bool give_up_on_oom);
 
 struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
 
-- 
2.49.0


