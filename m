Return-Path: <stable+bounces-86800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4769A3A12
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE81C21342
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740AD1E1C2C;
	Fri, 18 Oct 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGX+oOQe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MYSIH47z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0595187858
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244057; cv=fail; b=flOkJu6MUmYnMeDnAo3CmamC4KZNiAJUZyKC3+ne0ZilzXX+/fvFpHUOB8B2E7BPaUPjHA8ytpglMAfk3jLr65pI8Mma4dscEiSrxx2svwYU/m/idcKN7/S6PE0xpL9GUbq5l6OITR2aqMIacb02Qi/N0RLh8K3vMcpJxT3FXlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244057; c=relaxed/simple;
	bh=z1U9qPZ+VtNyd5ercHkQuoJ4EZwO8bxKXOgm6Bqzn6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwjW7QjAB7lXgcsC2dm4bWiVR2eXPMkpT+GliHhVoSXn2Fb4TzaRNtpHHUnutrDIhkY2u2YjFovDI1G+5flU4Dq+P0naS37/FlHZ52ZF0c+WJxhVx8VHh5ZNbX0D2unCZWZeTl2ZXLBiJTFYcIHRX53xmb1vQXECLvanONEnZAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGX+oOQe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MYSIH47z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8fgKT007389;
	Fri, 18 Oct 2024 09:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rUnu5Mnyl5wfzfiEjoMkNF0NIFQ3xc48hZ/ZJbzG+MA=; b=
	hGX+oOQeWoLcf1qMVkimi+jc36oIqDcIVChhrnreJXItEACYqtyOdHe7AbPbpvTu
	RtnpHAQrImcQhQabARbcpUOlM/PcdIj3bEp9pJnAPTC7zaFqN5a8+s2LNuPHo8eB
	+qKz18MDD7de7Bb3VcF0Y4GSBb1Snb85faR47alM7PSAiDd0WDV/6BdgaQfdLNDm
	uNWPtiYwQqvQ9k+PTfMWRsLXg14aYA+yIh5nByfst6p4RiWWhCmwyLVWtuVZu4NE
	CeHTjiED9/hWAe6GAWt8WhfuSmWMQ8i4NvOTAIa/RVqg5vYbZssB6UKA7nZ/Mgzq
	h18czri54jpgY/qD0IUd0Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ar3y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:33:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I91aRF026429;
	Fri, 18 Oct 2024 09:33:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbcs0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFrsr2FcEjzyIALJWU0uc3NX1lKmOBEWI9mmnygBQ4U9mEYHeAEbhXywQpnZyCgzJDe/NzyCm5HwjyZ6RVwZWCQY4galfGlumJu/8mNqrF/77Na097c1F7JgMZf+N2zfXwugvx78ge4LcYcVQ1BqF8uVcI5E7IfgiKCTQwcX9RORvlsfg5hL2oM1WmR058jPxYcCOhIwvXVpOOkKGUFQayZyiXlpBE1B6g39IhFy7MDdmrNJbRm05BK7nyebLC2eQ2/S6kK0Ip1tYw/QaF63vtO84mercmAyi/GEXNhGcYRiE6dRsyDFInueWK8G0EACAZLo85xWQsAg8WeERf1zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUnu5Mnyl5wfzfiEjoMkNF0NIFQ3xc48hZ/ZJbzG+MA=;
 b=tIL6ubUJluKotUagVz1z4XCuydx9LIhK0TFV8wz0YELk5Vlwkqe6MaJFYdOTGb+FxCNHdt4eURxRwqquYin6MXMAeUn1vTaaV60LY656dfs1gIroGoqUFsgcVqEmqdiHJygbRISa5rV/b92cejTLzUr3KUEUhFJLUez/20ELb+PEDSSBC2f6xHE9Umg4S4it+2JPB8y5uM8WOCT8VLlqhLz6LHZwh5YwkFfx9PoI+GMCIAtjEkjSv8WlPSk13DtzDxHnJw+sWOXzU6C2JAoqhDjU6BwVfku78MAUYzs8eZ+J9A5PirT2UvKD1tLZnrXJvS9H2VE43pRD1+fU24aMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUnu5Mnyl5wfzfiEjoMkNF0NIFQ3xc48hZ/ZJbzG+MA=;
 b=MYSIH47zYuz5cpYy+rgaMY0/tChQDlVlxllirqPLymMzudtGqSUP6cRzAAbaFhrzTF0jgNOfMeCCZDAMEYj9r0IegEjhmSiE9TW90+vNx6zvPFfi3pWX8+3KmCcusiFfP+fA62YAOrL3ZDNd196eeBDiKBQMSeP5Rdw8Zuq8q/E=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 09:33:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:33:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mikhail V . Gavrilov" <mikhail.v.gavrilov@gmail.com>,
        Richard Weiyang <richard.weiyang@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6.1.y] maple_tree: correct tree corruption on spanning store
Date: Fri, 18 Oct 2024 10:33:47 +0100
Message-ID: <20241018093347.95848-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024101840-army-handstand-92f8@gregkh>
References: <2024101840-army-handstand-92f8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0501.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0d9c9d-cb46-451b-5591-08dcef57fae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IiTYaZmZPr5SIFKc786emBkyXztA44fQa48MkZY7UdWv85io4Tx9gNVV29X?=
 =?us-ascii?Q?47Vl9xNrEPjzaLhBF7TGXSDxZTyzhLp76nIBkyZWqDaxHc8PmADywADe/YUA?=
 =?us-ascii?Q?bq4BksfCJXqfuCRJ4p5V2NxoUhpDUXyKjS9TIC+Cmgk4eirwJAeh/zGOGtld?=
 =?us-ascii?Q?Gxw8ieZVG83EgtLlrdF0GlKyB3EfIrZad0z/uIBjl1zSLHPv7JgsuSX0qjGi?=
 =?us-ascii?Q?3GMnnGOcOcPYO68XHGaQEnOQV1F/0AR3x11hx2nEMK8xxwnMFV9xBwRujx7k?=
 =?us-ascii?Q?sgQCDv/qiHN8yuEaUnSFO7xIrIQhRuvctE3UAh8FhMU7ld0/vekNsY2qWClH?=
 =?us-ascii?Q?rWkU+7YcVAHEyc2HzVa40TU0ZWk/YbDPqnNpblB6Yvb+7In4Dvl4164hiDhX?=
 =?us-ascii?Q?uJXOMxaP8jMwa37LCVIVuYXQSi+VL+zkHbJytls0UaCAuOuUZOXpGQfgIc1g?=
 =?us-ascii?Q?WvwDciZ5EH/j1o9l7eMw+2VHEPd6eho/OhP8GYQKCpIsSi/japkp6ppist15?=
 =?us-ascii?Q?CCYATTeoQ1RAL7NT8426kBmooYkcneIyTBr9sQvzBmOADKcAM436Allyhx0L?=
 =?us-ascii?Q?Y8GNjxNl6b941jycUvuIgf5Z+X2JJEe2s1qHdDX7V8JPbuxTZMgrRU4FdXhx?=
 =?us-ascii?Q?0T22UyY42UnmClbj/IAYu6vSspaX/U6wunbMJLJB1w1iSxI04ZCYpVO3QNlA?=
 =?us-ascii?Q?ZkYFbrzdbv/d1DcXulB9q1MI3s2a7lsBiqipU9D27bUBpmlE/+iBiJCkvmWG?=
 =?us-ascii?Q?hU6lnMTnVvvL653trO56Y/azNLn2eRR7Sei3yrUB1ygogcsYv2TvQj+Cb0/A?=
 =?us-ascii?Q?tfdBHvV6ttaLHp+EvxeaB2ySGNA2aOWOsL59zG+apJgtYfyxKSMYC3DGjtFW?=
 =?us-ascii?Q?yuV2NcWYc7X+mm0uD4q84w3Oll4vN83QA8gN3qS+0xwZGExtJc6luCwjiZSS?=
 =?us-ascii?Q?h8I+6Sb1VWzp2tCUxwROGgyKEdhIoquvMVvUrDYN/BG8A+yuZmpXcH4kKrMW?=
 =?us-ascii?Q?1knCmwol0PsxvNEW22ZSx57bM2fpWHz0j53PgvE8tYU5h+SMruv9yVp31bN1?=
 =?us-ascii?Q?BfpQwiOBCJ/Eu2+v9crnxM//gbKeMH7CjR2uSW/LVCQS3Q0Vl7MIoHj/bOzF?=
 =?us-ascii?Q?CkMwnenZly/aqz7tkX7Y3Glx7RKkdr9U0M/793mY3kuJ5UDc6pBZS3di4NdK?=
 =?us-ascii?Q?H6LN/8aWVk9JCv0wyNT39hGRp+vNDi/E/i5d2XJB/uhX1rg821N1OJ0SYYrd?=
 =?us-ascii?Q?ZmL214H/ESIVsQMfFGYZvPJV9Sie6l2Rw/Jglqoh/cnAzWiRdxK4UBk+cQCT?=
 =?us-ascii?Q?F10icligd8zrjrbBFjNPFr0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnRFnUVhRb7sQtgbzGxx/m5s2b6+hqRFWgPSSfnuHYbyDFW9kCQoGVkAKxMJ?=
 =?us-ascii?Q?QCpG5V2froL5apfl/r8/u9pxrr/XCOsKPOc7HHAZoMWnLF4RHUXVz/9LdjXw?=
 =?us-ascii?Q?Gp7zsmAZEnpAOjpFA/n2Enu6Ia4MsrsU5/FZEBNg2WkEIyjOzUAUi4lhmM5y?=
 =?us-ascii?Q?Pfu5PyM09057njI5SJVgK+tI39vhDh8y+SGI9pSl5g2yJNcfLMq1tVDLtUR+?=
 =?us-ascii?Q?nxPqTdzolJ38tCFiJqY92i69vJklhklzh0gq7LHRfeWyG8F5cxp7BpwmSBOf?=
 =?us-ascii?Q?beweDIOH01Hx1EzZJGAMDuvQqWxpM/h3gTasllGCRuNimq/q1UFV63VCSEy8?=
 =?us-ascii?Q?Mj0Jjf588pVCZwtG0xMMoOy08fQI6SvngBTCFBtrPkLtuNaMBvS+LbFHP7xW?=
 =?us-ascii?Q?6YCfpGiP6Vz/fb/neDQol5w8mkAnbucHaK7cRFsSxKwBJsecJup2C40hNiyS?=
 =?us-ascii?Q?xVzWxxLlP9gIk4whqFuEH3PhTUbQcgZJbDhdddjF3VaeuMLQ/Qnubq491zrK?=
 =?us-ascii?Q?3DedMR60zwovd0vUGB7J1L8IzdbWe/UcOjvKO8IXAPJVl+mDovrOxT+Wylol?=
 =?us-ascii?Q?04QwxGrez+WhPHPZHjoOlyTlSmSic120lBUXYr77tvzeGcsh/+L6nLl3Gnve?=
 =?us-ascii?Q?FrAW3ZgQzKpB2AnTzvbyYD/HxfBXzv4+FnCNCOvHS8FVuJYIHA1sf25zBjKr?=
 =?us-ascii?Q?Sh8bsNuWLpwaYWjkc405vfHpNP7dhNrk7nwzyqcMh86w53JQgW8A6tdYLtVu?=
 =?us-ascii?Q?MD4UVhYE6gFWetSu49xjG/MwCWmhY4kse3Z/RGNCpAV/BFKS7ChA8tSnn9DX?=
 =?us-ascii?Q?QpoEHUVxBdzCNy+2t8Mpekeaj/aRDTvMPzx67/W5Jy/hjVmXyhsjoq9c08cb?=
 =?us-ascii?Q?L9yxhwTA4pv50yIdIE4IG+YRK4w3nET8n2ktkDCJcVwdvqLET0CxyWDFTagJ?=
 =?us-ascii?Q?fFjpYEc9xRO9HUqhOLiI5Jb+BGHh1weiLylImOaKIpTvdV+Fww8MU8eD42qj?=
 =?us-ascii?Q?eO/ZqqVki0q0OXHtdxvIru4yS3qEfxngD4zvT6m5xmJYYEFMcsaP3uvBC+Yt?=
 =?us-ascii?Q?OwKyt7+mUftlvtlATcVbWuCaZMTdH+4DG1QpuEOyOHhaMs63f4LLx0IZptkC?=
 =?us-ascii?Q?fe84kKUajOffQe3rpW2m7Kp61b27o20cxgfZfGLMSv0T/mkSfUZcT2y64QpL?=
 =?us-ascii?Q?xyeUwpitVzUr2qooNnSEjz7ySeGoZYJ7nlxVg/5mX9RbKqOvqGPBE484anF1?=
 =?us-ascii?Q?Y1vU39uSQVmU5t6t62Tv7uMXymLQB3YOY4WW32kYUMi3wDHPoYJ+CoLgYJ7G?=
 =?us-ascii?Q?fm1HmwVPF1LujAoebQfcOfTyDvNTo+PoQcmuaGL/o4+XllnVCkMIfryrhmkl?=
 =?us-ascii?Q?SBLHxYo5thfkj3o94Tr3rYnXm9LA9xdVhIo4Fo8xS76+cpiRKYT8qjIZbyOW?=
 =?us-ascii?Q?XZUTY/t3nCttScY2ZH+wiRp25yHiiHk7Jr51kHdo0FpQ1b464T0Uobig1JY5?=
 =?us-ascii?Q?8LquAnEyA5W9q2236+wQ3OwTANMoKWXXluvYfQjrnUFlt5w1bvBgvxQXzO4d?=
 =?us-ascii?Q?1K3iDwwiA9fX35kH3HXQ3dzcCim4x9Xqc0loarGqCQhkUKLk1X4B5V40XLw2?=
 =?us-ascii?Q?bDAIf01J7Xvg8xF+gt/GUAnQv3lBRvicyFfoqV+BYcVDpX+DOaltX9CiQICO?=
 =?us-ascii?Q?HeMiNQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EicsN7D5kbtUgl0rR2qqiMcRgv8NXpDvtbCu6q6zYV9Z9R8oLTnq5tM7CMmYNc7ZmFp9vfc9sfS8nhhLk86OtQp3fBGphubpeemBWwDRLoXVyqf2oOzWj902ooUCVnGTRoNqlsc4s2e2lOtyJiYfOj4aoTEBCT0pWdGHckl9E6ejtr4f5aywMpUywI0HGAfoQbr2YUY0tN18XHmUXKJCbd57qZ2GUc/z5InNckpsoMin9G6XYrLJjSE8N528emKqXp19qzCRzbwFblt4weBwMo3SriC10qhLRa5iSMxUW3nLgIFjmWONxJPNKT+LYYdxZUn/Skl6RbVavfZCPIIuBTyquWwsJkB/qkJ/67JHDSQfWusQqqkNrynFlzQDIxLFOSqvHRzUKMdOqvJg1zH/TmWuWgZorHTNI1On8vzp6UvFxAVnxaSqQ3PpFgV6cWiqoeNtspVh3y9wGmkWKJ69eGzZu6f8jcNbQu4iGVkQJAqUgQMfx9d+W/k1blZfZqXPYMPT1OLT5TACkqfMQ7A+XmE2pzVrkzp3QUVQI3+jE8EuhaHRlw3/tprmGDwFjHMczTM2JpvXUn5/1JLakGSt6DhjUitLHEKhY8bVGXQSPK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0d9c9d-cb46-451b-5591-08dcef57fae5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:33:53.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuqqSQKwtTk8o6lJQf8Zkg+E7EnJoFw81dEZ+egbo8A0T8i99K1qcNgTSlp2wYS6Ipm9gF96sAFsiyS875lj+IPz7sBz97E8MYnw2ogfgqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_05,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180060
X-Proofpoint-GUID: txiLNjb9FcAm4zBhjw6RVFFyf0UyeZXv
X-Proofpoint-ORIG-GUID: txiLNjb9FcAm4zBhjw6RVFFyf0UyeZXv

Patch series "maple_tree: correct tree corruption on spanning store", v3.

There has been a nasty yet subtle maple tree corruption bug that appears
to have been in existence since the inception of the algorithm.

This bug seems far more likely to happen since commit f8d112a4e657
("mm/mmap: avoid zeroing vma tree in mmap_region()"), which is the point
at which reports started to be submitted concerning this bug.

We were made definitely aware of the bug thanks to the kind efforts of
Bert Karwatzki who helped enormously in my being able to track this down
and identify the cause of it.

The bug arises when an attempt is made to perform a spanning store across
two leaf nodes, where the right leaf node is the rightmost child of the
shared parent, AND the store completely consumes the right-mode node.

This results in mas_wr_spanning_store() mitakenly duplicating the new and
existing entries at the maximum pivot within the range, and thus maple
tree corruption.

The fix patch corrects this by detecting this scenario and disallowing the
mistaken duplicate copy.

The fix patch commit message goes into great detail as to how this occurs.

This series also includes a test which reliably reproduces the issue, and
asserts that the fix works correctly.

Bert has kindly tested the fix and confirmed it resolved his issues.  Also
Mikhail Gavrilov kindly reported what appears to be precisely the same
bug, which this fix should also resolve.

This patch (of 2):

There has been a subtle bug present in the maple tree implementation from
its inception.

This arises from how stores are performed - when a store occurs, it will
overwrite overlapping ranges and adjust the tree as necessary to
accommodate this.

A range may always ultimately span two leaf nodes.  In this instance we
walk the two leaf nodes, determine which elements are not overwritten to
the left and to the right of the start and end of the ranges respectively
and then rebalance the tree to contain these entries and the newly
inserted one.

This kind of store is dubbed a 'spanning store' and is implemented by
mas_wr_spanning_store().

In order to reach this stage, mas_store_gfp() invokes
mas_wr_preallocate(), mas_wr_store_type() and mas_wr_walk() in turn to
walk the tree and update the object (mas) to traverse to the location
where the write should be performed, determining its store type.

When a spanning store is required, this function returns false stopping at
the parent node which contains the target range, and mas_wr_store_type()
marks the mas->store_type as wr_spanning_store to denote this fact.

When we go to perform the store in mas_wr_spanning_store(), we first
determine the elements AFTER the END of the range we wish to store (that
is, to the right of the entry to be inserted) - we do this by walking to
the NEXT pivot in the tree (i.e.  r_mas.last + 1), starting at the node we
have just determined contains the range over which we intend to write.

We then turn our attention to the entries to the left of the entry we are
inserting, whose state is represented by l_mas, and copy these into a 'big
node', which is a special node which contains enough slots to contain two
leaf node's worth of data.

We then copy the entry we wish to store immediately after this - the copy
and the insertion of the new entry is performed by mas_store_b_node().

After this we copy the elements to the right of the end of the range which
we are inserting, if we have not exceeded the length of the node (i.e.
r_mas.offset <= r_mas.end).

Herein lies the bug - under very specific circumstances, this logic can
break and corrupt the maple tree.

Consider the following tree:

Height
  0                             Root Node
                                 /      \
                 pivot = 0xffff /        \ pivot = ULONG_MAX
                               /          \
  1                       A [-----]       ...
                             /   \
             pivot = 0x4fff /     \ pivot = 0xffff
                           /       \
  2 (LEAVES)          B [-----]  [-----] C
                                      ^--- Last pivot 0xffff.

Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
that all ranges expressed in maple tree code are inclusive):

1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
   determines that this is a spanning store across nodes B and C. The mas
   state is set such that the current node from which we traverse further
   is node A.

2. In mas_wr_spanning_store() we try to find elements to the right of pivot
   0xffff by searching for an index of 0x10000:

    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
      mas_wr_node_walk() in turn.

        - mas_wr_node_walk() loops over entries in node A until EITHER it
          finds an entry whose pivot equals or exceeds 0x10000 OR it
          reaches the final entry.

        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
          0xffff is selected, leading to node C.

    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
      in turn once again.

         - Again, we reach the last entry in node C, which has a pivot of
           0xffff.

3. We then copy the elements to the left of 0x4000 in node B to the big
   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
   too.

4. We determine whether we have any entries to copy from the right of the
   end of the range via - and with r_mas set up at the entry at pivot
   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
   pivot 0xffff.

5. BUG! The maple tree is corrupted with a duplicate entry.

This requires a very specific set of circumstances - we must be spanning
the last element in a leaf node, which is the last element in the parent
node.

spanning store across two leaf nodes with a range that ends at that shared
pivot.

A potential solution to this problem would simply be to reset the walk
each time we traverse r_mas, however given the rarity of this situation it
seems that would be rather inefficient.

Instead, this patch detects if the right hand node is populated, i.e.  has
anything we need to copy.

We do so by only copying elements from the right of the entry being
inserted when the maximum value present exceeds the last, rather than
basing this on offset position.

The patch also updates some comments and eliminates the unused bool return
value in mas_wr_walk_index().

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma
tree in mmap_region()") seems to have made the probability of this event
much more likely, which is the point at which reports started to be
submitted concerning this bug.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue
discussed in this commit message was occurring for him.

Link: https://lkml.kernel.org/r/cover.1728314402.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Tested-by: Bert Karwatzki <spasswolf@web.de>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit bea07fd63192b61209d48cbb81ef474cc3ee4c62)
---
 lib/maple_tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9a5bdf1e8e92..ae8ae9470066 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2298,6 +2298,8 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
 
 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3831,7 +3833,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
+static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
@@ -3840,11 +3842,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return true;
+			return;
 		mas_wr_walk_traverse(wr_mas);
-
 	}
-	return true;
 }
 /*
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
@@ -4081,8 +4081,8 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
-	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_wr_mas.node_end)
+	/* Copy r_mas into b_node if there is anything to copy. */
+	if (r_mas.max > r_mas.last)
 		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
 			   &b_node, b_node.b_end + 1);
 	else
-- 
2.46.2


