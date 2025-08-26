Return-Path: <stable+bounces-172920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A3B35622
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629613BFDF3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F627E7EC;
	Tue, 26 Aug 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="moKn3jDa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vcCQpRON"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF67223335;
	Tue, 26 Aug 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194847; cv=fail; b=Uf2CwZt/AJ+4pu6H0jlsqfu3MKub0MbM66NutowHbMUEf2kn/WS+i4qlaYjan105bpOlWkDHVFAHhw3iL4z7ux37hD1lTkr0b/INx/cHXAFNCGXFOGyY3/1VtyFHIAKnBoNQdxHhmS0OkyjRoEcOIBKftzb+ni5NqVzXT9CssHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194847; c=relaxed/simple;
	bh=p4jIhcmpjQuNvM+xQ8ypRBZON4QI3OO9QDyIaq/5tJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5zcfZZNI01nlVm133AqguX/VxNwqIW85NbB2h0yiL0G3YOxl/ZZAqdtIvDPTWoAUyL/Lh4Hadkd1FAWYkQzA2F1EHqpCr5ibQdOHprEVStnbfShynQRvIhE/pMpMGxi7nYSTqhexU9TQjiuF2P0cntAYF/eE/QH0lL6Vkf6wCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=moKn3jDa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vcCQpRON; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6BjJj002476;
	Tue, 26 Aug 2025 07:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tfrzAqwI1UPnb+maVO
	hT0UFA8iDruC5L7yzcBmya1iU=; b=moKn3jDa3Pnn/hXIslri3soqfCcCHG90Ah
	BEoGhy0p0DUPcjnX4dmg1aM/yxP9MiW9z5fqSEMtPh0erIzJ/yD/0ofj8Lq+8C9M
	+sz7mWQK3EbH5jWpZ0Ul1jYUPIMwm4SfgCC71WiCwzGuY+hVE3/aAWdQhLdjB09a
	lrobvAWnPTsm6uKhABvv2X/QCvSBfCLPoilOwjI8uqhfK2jy9/4IzbA6xGeWryHl
	LxRZwEtcQ0U5lfmuD4mkwtztQeeulISXc8jTxBJyqGJa7t8QtIYZfpQt9OMnRDMu
	ttDRvDuYEezy2yjKMGT0FGPOy8wWJaDBdl6slk56MiCtK4Q4gl/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e23xc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 07:53:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q68Lu3018996;
	Tue, 26 Aug 2025 07:53:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q4399feq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 07:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGJMszCJqDUjHFYCuOZPwljC+uMnwz42bRd9HYM/BeLPtfoP95y42+6GHBHbCaiOUAKDbH9yVMTCB+JmW6wzgh6m8JNKyHgId9QmuiYvLLJ4XqI5/3LzywMQB9lNkvn1okPCMoTFaY7KTZHHz2JNPqxc0s2qTvTkAisbU0zgikc9UIHAUXJvWGSLMFsRfFpiDeDI+GwKk/Mv0U9SWDAp2BGoaAq7gDHW1XUuZJ7+KvdeDysf1l2k2mJJs1V/unfRr8V8h0pY7AoUwW43ginxIP6d0Y/tyOBTKE9nDiWZY89y5jY81mOvhcz0265km+oc+gfiM7ygDH7miGvHxPjHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfrzAqwI1UPnb+maVOhT0UFA8iDruC5L7yzcBmya1iU=;
 b=sTzmMSnUPPqQQc3gN55v1Ce+C+qtNesd+GhrXY/N072mq0JgpoFx6nhyVD6CorzsDvEryUN33v95G3tvYkJlp/IlxWW+VV5oY3frlQP0Hsf++wJBnNJ9sQCdbc/f1/gqLtNiG1nZKqZMJxzUnbia2dz6r+ni9fUKK3SP39u7rG4wT4pXkSwcZW33KWKPjVgLj3HaHg4WghrQR3ouGv0n0M7qAYCGxKdPPEM3Ctu5MrJ+8fTRWVcuMdLLZO4U5c+dXTPW3QB8n4jro33ZUM/PPlJ/eRFtFQq/Tu6gPR5jtJccRtEq4x9MxJdgyi4iwIDk3SWQOArco5H4P98CaiMlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfrzAqwI1UPnb+maVOhT0UFA8iDruC5L7yzcBmya1iU=;
 b=vcCQpRON1jRk1jAcPOMdvJcWjDlr8D0wk51Ad3sHxunDZseyYs0NrH7IezeyoWUS4QSr/vFVC5wSpl8CstkVPhORTUrds+QWeIWbKzNgTPu3ueEZ9eooLDho7/12avfxp0s3cTxQG3qeYNtCGm/utZXkvmYdvjvDQbSiSvrZ0Us=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8711.namprd10.prod.outlook.com (2603:10b6:208:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 07:53:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:53:44 +0000
Date: Tue, 26 Aug 2025 16:53:34 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        jserv@ccns.ncku.edu.tw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when
 counts are equal
Message-ID: <aK1n_t-V1AlN86JR@hyeyoo>
References: <20250825013419.240278-1-visitorckw@gmail.com>
 <20250825013419.240278-2-visitorckw@gmail.com>
 <eb2fa38c-d963-4466-8702-e7017557e718@suse.cz>
 <aKyjaTUneWQgwsV5@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKyjaTUneWQgwsV5@visitorckw-System-Product-Name>
X-ClientProxiedBy: SE2P216CA0174.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 53abed84-1d6c-4854-cf62-08dde475ade9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agD9cQOO+Vu+4YjPKFS0mnE1epVRx3iHacy6EqTuw1W3s1AdwDFVfHkv5XaC?=
 =?us-ascii?Q?n1UmvStlREIajYrMlXzEh9LOQJKKAYo8jv3TIMD02eldroTeuc3xVcN/L0hZ?=
 =?us-ascii?Q?TqGwgN/drVMHuSpmymwrhk331FVX2anobhUYBYuxr371pTq1husOJvRsm9dQ?=
 =?us-ascii?Q?Gy2Hf6Zv4nELfoKZHGYRCM0OxPeZABg5wf4KxPiPWiyJXsRSRsZlcRnodm4S?=
 =?us-ascii?Q?uUyL8uEeBjOMemT7rHoKDrA7ifwzDgrbu0B8HJWGxjtNR1L0McueTfitdsZR?=
 =?us-ascii?Q?CigQzZzRYo1/zJ95XA9pWunrmS8sJTTLlfbmJopWnflAHaB+y/aIstikcP96?=
 =?us-ascii?Q?/xjc9kNl8vNQG1EOxczWpYb6qyku5g+EZCN4pEetPkv3jk1aEkYouehE53FP?=
 =?us-ascii?Q?Iyt2x0J2eWqaBSlAhyAHPrdG8COr6+1hKmfpeaaCBbDvzgHRj0804Xr7Zvvb?=
 =?us-ascii?Q?xDG/q8m8iXzTQ70wT/YkqSWBrEZYQLOG4NfGDJ5UPNZlFBHNM8DdysG2LwPx?=
 =?us-ascii?Q?5UsAqOEdHweUu87t65x17rTd1LxtHqkoTZW7GfNZ90uLWzIx4T552KAk5cOX?=
 =?us-ascii?Q?QINgPJA1uNprCNBZiqaYhP5I95NwzICUKZQfkiVKKYTyyDTC9dwd1JUT+s0U?=
 =?us-ascii?Q?WxMCXxUtk6Tg3pA2+aLmpOByCG++XWvHlH2CwDLNU4hFJnsgs/Q2noffq0q0?=
 =?us-ascii?Q?gn5EvWQXqvdCFk4jlvr87MwnDCeUWNHoLGmFRYG5u26e4w55Mm4lH0BMPTWO?=
 =?us-ascii?Q?P71WqOIkjtBKCe0sft/92IIWIqiVhu48plt403rbq3JdK2+CrMMDdpl6stsX?=
 =?us-ascii?Q?AwRSDILy2OQ/W1Wma30zjynSOr8rmWrjvmCNrc5wFENanCVcX51/GQbAfIua?=
 =?us-ascii?Q?yjA6xShD3XyVIo+B69BEL4L8m94E/J5THoToviTbFgD13KeiKqWFGfmghBXo?=
 =?us-ascii?Q?BwBTBdWNJ91Ia2FTnbENznNzBF+R/7qqdInMtiSHzw0xuiwKMcKOaPbcng0J?=
 =?us-ascii?Q?SyZmk8vcoJRQbHd4Lp7dst07DFHhxeo1JQp3eEpVDn9lH9fXfG6BYiQgNbQW?=
 =?us-ascii?Q?Y2ZwhwttyVTeJMp3TI6pXFNyxhOtBvswojD4O7L1IuE7q57HyqKnXy9RShcN?=
 =?us-ascii?Q?IlDFK7HcXvOjz7v2D33f5wdx42BbQyZ14pibmdeVQqlY0Mzmrr40C5cXYQ1O?=
 =?us-ascii?Q?5jO06THkpTRforuG5m4ZoIRM4o1gJhGaZKK77q1sbeHvXWcTmKEJjeK6zWrY?=
 =?us-ascii?Q?waIi66hK1OkWvmw4nYQiIyMVRMdgc3BTZ+XcxcdTYauaiYqbXrno/ltMhK7r?=
 =?us-ascii?Q?fidtlpyUY2UD36I1X9UMqs7rO+P5h4IAUXjPU/wZ8sTZZ7HL7W2jFeXi31Gw?=
 =?us-ascii?Q?v+s+lB7ALoKa6OLZ+D2FZmjSh9VhEajeGRzXiVNm/qD1+Suy3OirAfpv7P7b?=
 =?us-ascii?Q?rsDlnZfkOEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WcOeSapoI/hTphG2YcQdevIsfX0lK35U+26DJYIHpRr59+Jx/vRrkjBTdwKJ?=
 =?us-ascii?Q?sYgjin/qy18qZw21xWAyM1wBxIaCJdgdn+/SJU9DiyBzk7kjPiNiaug/Mkv/?=
 =?us-ascii?Q?yZ3zfolx3Ytu3PGFcjEUAqPOjWp17dQZ8n5ay9aI8MQJrLhswZr9DBbmfHIB?=
 =?us-ascii?Q?Y+JCjkt58zHpr09x12ukL9QGxIlrhf/BEsHRFhtpShgkuqOvTMp4akyRexmq?=
 =?us-ascii?Q?XVPh3Jaft9J9j0XLzulRT3U2uwjNRRM2huUttnXHX+PPNivz2tEoj+nXBDpM?=
 =?us-ascii?Q?XxUaPjgnSrVq1uyRNlEME73Xz0mvy9sOy+iBwrO0K4+4BPfPkVj0UUxsvPNX?=
 =?us-ascii?Q?2HVlC6XssqUCFbBRm6rwulbK1W4uJlxJBnsl8kUJfN5nek7jNmrzW5SG0bD3?=
 =?us-ascii?Q?qARu4QcNborpQKbDzegXH1EjYSPQvqD3XT/45ZUvAJz6xCukzOiiFJvIHsdw?=
 =?us-ascii?Q?+hrniRJyJvdK/J/QQ4VzlW1htM/9Q/Pe0deg0oWtIJdHJ4PVkmarJCOJPCHt?=
 =?us-ascii?Q?PN3v2nnt6ThXroZIzH/EB3NUayzmrlCzQHx2c+eNpYSwBUajcGWESrJeFV3/?=
 =?us-ascii?Q?NY0zT3DjCJtH2a2HQfJpIUkzIMu4zhENjeFaEhQLVnEvn1HUFaooqxlF5x7G?=
 =?us-ascii?Q?n7FqhSwdozYng7QernQ70Y8E5vJhfnt4xY0a15dRZ79ahzdv9lIQxWWpa17b?=
 =?us-ascii?Q?fFvmdf+vSIg65wM3S7/JdvSOhClXhruyfoJYrFQ91HZynFZlHfl6JTmxYLcp?=
 =?us-ascii?Q?jJXustxNgUPLiOOMwE4x06RI9Hs+OYe4IpWO0d2EkhVCE+rtDJyvwimioowO?=
 =?us-ascii?Q?bc6bAT7cehiOjR6kSlbbYdlU3gwyVG2bmiAtcaDHiYBlo2euAR1HYAHfQa6K?=
 =?us-ascii?Q?W2bcaKFYSu7m1NQ0FiaAeezUPy5qFTOPXfLNzn3Fmoh13A3FV4pncIz1eQY6?=
 =?us-ascii?Q?xORFVztUgDvnSnnFJTrvUNHjL6FhCwuCcpaKoEtVFVvd7fCSiLVrjQoTGH5o?=
 =?us-ascii?Q?7TByF92HJGdHpSEGOlLOOeH+YulIhHK/e8JGqqDIy8+N5DXtRn5322pOy1z6?=
 =?us-ascii?Q?BM0GGyXc2+U4APscSNPd8dy7WHO6127sYEVNArVafow2bZnfgw27kq1Lk9IK?=
 =?us-ascii?Q?iyOMkS3qtm7uh2Plds9QvO2FZb2aeWEUw6KCTeZjAhcF+cSUA0ryY9GQdTCG?=
 =?us-ascii?Q?glwTniwI+N/3UD71g10uee3uhJPZbv+j3DMRvlTPFLfc+mKmMB7pG7bwOH8I?=
 =?us-ascii?Q?hQe1voC43g83o9mfZJOziorhhD5HfBOEM+tEIMJc6bUyW6yfVU5+98SQ4XjO?=
 =?us-ascii?Q?yjMfHdS55ya2ZhXx2K7F909y7G/CGb/qR3LgTqBAj1oJfxpWmbCO9Ofz6M5R?=
 =?us-ascii?Q?h6FeLIO+U2NQ5gVKyzPUUF33prUI4b94ZgF5aNtkUsGNJu6U+O5EECFroEcn?=
 =?us-ascii?Q?IhmyF4nxxcE9TY4vCpoS6CaBDEqy7UWVyULGvzFM10YUvvR2X2gdJrlTGVfq?=
 =?us-ascii?Q?xK51x1FRJ5cG3MHzr5BnHxK5vlewwiv0Xh2FGRS+7HzkMR5lh0lLTR9FLa8/?=
 =?us-ascii?Q?ZnKbN9aD70Fe+pZ7Quj32EAnw7SVG5F27+Uw2Wei?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a3WkXqbSARg8LIjsys4tXKTNdlaxHceznJMgOoxpb0a7W3ZRtGiLU8vTd8gsluWaQZmyn3RFGiipGmWN4/Ldo9+BjXJMevJVgGEiNQY94WmEOdMSdO9rqY5BVcVjQuiEjVlOJwYgYMrOie/5yJRoucrWspZx+v55f2N9ECLMsmere3EcpY6mYTGCCNXBPgXB/3mln1dUjnnAjU0pC71eJIMzUj3SE6FKc56yeJec6jNTLUUO6Q7nCbg4sT2iuZAH9ahF6OmoGPwtZtkhvaWm2mN1OLAgKCyuld9hN5uyIQtsAfXw8n1AAkGwIWSXKuRNbmIgh+AOpNQ6+36ittZp6QqoTgD+1oikiICruUESPw9c1p5dS9u9vWBflvvHvXHC+9msdUqwDOXXaLUGQWE7Xoc6KMPdF2Z/yN8E19YublUv6zmNljHI4gpE10sP1pHAYg7kDM8/Yhw/7lAyg2AsluOZ6Q+euaqUtAQgaxqo6a2YoYyjOcPW9YoPnHoJ9ENN5XsFCkvkw79fTDzuIJr73DI3/1WGpxfSrvnTVQqesE4FGyXWc4RHyykapITuSmSoKgIe9FLxG8D/e4ZPDL9b/elZWLWnYqaJ1S4ywDTFFyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53abed84-1d6c-4854-cf62-08dde475ade9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:53:43.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWe/azTlYVMkv8b1ivwgDuhuIbJan0YcCtK/ODLleybX50b1JOhJMWGlB5ooZY87kpjf9PgwRClMTo/uo7tHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX/R0jJez71Osg
 zSedQVM/ukAFdceByB410UpikSb2sUbPvqrY7tAu59ymtw40GGLOS6AKMw1doM4wQ+PW1ayuS42
 NRrtRwgQ5GIcJOyCLKuuh7lBpbRyQ/69ED2LAw8STG5vN37UE+rrxH9Fd1AEcJHfJRAJYes5HCK
 8vnfAs4TwhrqpVNMvqopmaW0nE+2TN5nsVQkGOqgEIsFXRNLrmnCAuSZdqWIZrPCrWvMpjSZdea
 r323U/KLOK5t7aJ198u1rlqQCugYp9eLT/AZmeYUlRUqu1vKiVG7BqsySrXYmmcxbITxqvCpluJ
 NeaYxyBeYrsFL7cUxo8FBz8jXEXd9DYRw4fp/GbkqANQYe30LJ1P+Sr9wa2Exa6BxqPWUGLl9aG
 kSgC5ibJ
X-Proofpoint-ORIG-GUID: uxNQTFlA3-8x-PIRPfK0cAjgRmmr4qPw
X-Proofpoint-GUID: uxNQTFlA3-8x-PIRPfK0cAjgRmmr4qPw
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ad680b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ooBoh6QJU2_191gsWxEA:9 a=CjuIK1q_8ugA:10

On Tue, Aug 26, 2025 at 01:54:49AM +0800, Kuan-Wei Chiu wrote:
> Hi Vlastimil,
> 
> On Mon, Aug 25, 2025 at 07:28:17PM +0200, Vlastimil Babka wrote:
> > On 8/25/25 03:34, Kuan-Wei Chiu wrote:
> > > The comparison function cmp_loc_by_count() used for sorting stack trace
> > > locations in debugfs currently returns -1 if a->count > b->count and 1
> > > otherwise. This breaks the antisymmetry property required by sort(),
> > > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > > 1.
> > 
> > Good catch.
> > 
> > > This can lead to undefined or incorrect ordering results. Fix it by
> > 
> > Wonder if it can really affect anything in practice other than swapping
> > needlessly some records with an equal count?
> > 
> It could result in some elements being incorrectly ordered, similar to
> what happened before in ACPI causing issues with s2idle [1][2]. But in
> this case, the worst impact is just the display order not matching the
> count, so it's not too critical.

Could you give an example where the previous cmp_loc_by_count() code
produces an incorrectly sorted array?

> [1]: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
> [2]: https://lore.kernel.org/lkml/20240701205639.117194-1-visitorckw@gmail.com
> 
> > > explicitly returning 0 when the counts are equal, ensuring that the
> > > comparison function follows the expected mathematical properties.
> > 
> > Agreed with the cmp_int() suggestion for a v2.
> > 
> I'll make that change in v2.

-- 
Cheers,
Harry / Hyeonggon

