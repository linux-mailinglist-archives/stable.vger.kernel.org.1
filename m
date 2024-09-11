Return-Path: <stable+bounces-75841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4721975366
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C959F1C21FA8
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C41865EB;
	Wed, 11 Sep 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ymy3JUKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d55ipkpZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E8184537;
	Wed, 11 Sep 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060646; cv=fail; b=hi15yxrCnKZN24MnJmjX/24jpYC+ALiPgmLmDkqWsQOa323WC2rzy+NDS4r7GX78DzWoPRqCNxFP+8YzI2AUWULvImTY/F84hi/6dY6bmtDJ+PlLIIHdDAtfjY7sIMA08m615ScR9kyFV3klDwSJW5KHYZ9eJrQRk+oN7aTfg6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060646; c=relaxed/simple;
	bh=8gmCQeU+QRBLZVFVojC6TQoJ4csZ/2wM5RTD3YL/Jjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjS7fUUVe4WVOMTJQ7nPR1akNxu9hIlz3VZSHTCXqDzLD8voWpTUclvlpeLzoCnGF64B42AXH/hDn3DxjWig0sU96QJ0lxk4ohgGhJnmMquIGTwxpGwSMpAThBehidwijGxelw7TeU1Jkbwio/kUP9+2Sqdmf5eymiXs4tsADBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ymy3JUKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d55ipkpZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgIfZ032256;
	Wed, 11 Sep 2024 13:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8gmCQeU+QRBLZVF
	VojC6TQoJ4csZ/2wM5RTD3YL/Jjo=; b=Ymy3JUKPRLXUAwdOB3dWauEWKW+rO3C
	LIm4foePTUmt8qabXX7vcvlEBRkb/cMNg87u2rXYALb2E4ramZ1YjXsNOjpnNXK1
	BAvzNdA4fh+sk8iGCHBocB8Z99aLVb0tFYOssNI/bwT1Gg8ax2NSLLJ7qExYlELX
	eIM7Aibaet232RqIEssnBcoCIX+dP50i0heIPVXW+SJqCfAhpA/zCqtLEwdpzXQ0
	2vxN9cnegFtrxG9AbCGqs4mhJyPFOroVoEuyGPcPY6Y4k8QSIrSCc2gpxl1hSNyi
	OstP+eUwKGWoFQgQIe88xtFis4XYIG9jo9bXFJGbckt6g5TE1SIX6lQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9r3tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 13:17:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BBcavX019845;
	Wed, 11 Sep 2024 13:17:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9gem2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 13:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opFqA2y1pMG1/9thk3Y/NyHK8zvzaEVciJ52KjoGBqz248Z+6tvmAMftz9ZcwE+q67V1fqzlyChjZ/yHcQPiaMrMJwHvxwtfN0pHzSIkN96Xs5nYqcjdxSBto26qeoEmdWV42eKJajyPpBc37bc7Hx/d1cFeKnMBRGYOJajI6EM/MMTh+XgtcYQsiyloTaRXAfuE1F+dHa/aCeFHVu5JbzknAX6PUVNsDe+CRQzOO68S3cZ/CdPEk6peYMbfWjb6kU76cMxCxD43ZEpYKPDJ/yaJG30vs4TZmPif+M7Q7Sjc7ocnDe7x8nK7D+MP2Eox2xYX1rs9TsId9r71rZ24Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gmCQeU+QRBLZVFVojC6TQoJ4csZ/2wM5RTD3YL/Jjo=;
 b=F357oU2ysmTQXkWZss2EXtRIgxn8PovOUPdkxVJYkxrjrsBD/xPD23FbG96FS0Y6x7cY2YQDzzsHdPVLcfGd9/O86M/GH5x5cD7JP1xpLUhACZB8xS6OC3f5eE3e6c9fnL9iDB3es+1AWZ9bpQhfJI+KUcuHpz7urn0ONa6WyzND0UkMoKTXcD3iGzkND/s2gKhtDUDMESuuTru5IPaKJknnLLLv+UQOB8dq22/8sGl43P++MKKviITsdYZpioSqZY7YJMDjeDDic/F45dBg+ZGK4m7C4KlnvU10CiPeOWro2+A9kwNMi8UgXPy5s+rsJ5ar5ycOKS5V0f3WAWwM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gmCQeU+QRBLZVFVojC6TQoJ4csZ/2wM5RTD3YL/Jjo=;
 b=d55ipkpZJsiWfkB4aa/qGJjn19yhr7oISkotm4pVoYjPNVrWtfn+FqXc6V6Y3Phi99kXX5nsxvX6ubkk4uRLHslaH9U1MHCzkMTqYGEHcPThHxCT3+vZ+peSRc1Cqrny3DgMVIDGnj/EyRbeR1XL5ylSkOzX6zhv+9grQg1Moe4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 11 Sep
 2024 13:17:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 13:17:11 +0000
Date: Wed, 11 Sep 2024 14:17:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Narron <richard@aaazen.com>, Linux stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
Message-ID: <541f2c3a-da71-4cc6-8b5f-7e56ce885382@lucifer.local>
References: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com>
 <2024091103-revivable-dictator-a9da@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091103-revivable-dictator-a9da@gregkh>
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a75b4e6-abea-4ad9-384d-08dcd2640b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DS8oaucrHv/AxIGHlkbmM524alDwT7dcQ+pOt/ya9af0LWEHsy4tdylt5x3E?=
 =?us-ascii?Q?U6MChaxwD+e8gKDV9/Y5pXnVR3xqgSe77p+5mWNbbdybt8i9CotHa8T6o7zv?=
 =?us-ascii?Q?tgDXW6jM4bn+rotDTwS5tzIpnZmQ703b3HdAaxTEJ7/2LOcAjhJ+W7dtpMBF?=
 =?us-ascii?Q?dR1tbKhQ3u7u8TwlB5j41086jeUZULvXaVLQuvx2fNLIGIAAU9ckd+V0fwY3?=
 =?us-ascii?Q?lLEnw5OR7fPfjNr6CUl5mjuQovRcKMYfe2KHvFQj2NMYMxZxES6BFcMxQvIY?=
 =?us-ascii?Q?kboorW9NlBXic91Of8srTcWS0RA6r+Kt4qIOWswn+OKCEzbfioIQ/f4LtftD?=
 =?us-ascii?Q?jQ/EwLcBXfhs4iU90BXn6VuGVqQj6ehi/yv8HVDY2I9TP7UyYkfP1D/dfzJg?=
 =?us-ascii?Q?Kf9vlha8lwgDQStESfVPpphYuqDv44HZvQHw0y11kcTZvmRm5PlYwxXq3tKo?=
 =?us-ascii?Q?strE4eLzPIDK6t5O3b04ST+Rc5+mzSl+Ip7k/rlfmDk0IQctEH3Uq9RHsx6f?=
 =?us-ascii?Q?DHc7fNY5HmQ8qDQ6L8SfTNCdrPEr3WoXwGvZ1okYqrXTfwZLYszDgDLU2wEH?=
 =?us-ascii?Q?DXs7Mf1bAP1Txv9WPZKZeCtOYmSYZtMMHmllX/xGk7rCITPOpZbZzW8zfisi?=
 =?us-ascii?Q?QtOvukRRdcmRsXvtPP1AVuw/uXS4/Ne8j5jfecddoRWY22PkdpZsS0YGZrIr?=
 =?us-ascii?Q?eqKvY3pbNx/ceMNTSVTD4TkBpNr+U8UN8hLdm6XnCx/E0zB11aEhQDytNj+L?=
 =?us-ascii?Q?v4RSzjQFArGouY5UBE5m6n/GI4g/tn6p9ssf5P1+fmZpYAe7jIDokbNNNZz7?=
 =?us-ascii?Q?yE4bayCR1YYcbFCdwPkm+G76kyeb6k3PRO0Sv1BrgQhKacLWEjqU441Fk6BW?=
 =?us-ascii?Q?4RddOPJ+9SHQiu9w4Fv2vTlC0uUIeeFnki6mCU4dpXiJrMypBMpdooj4P9MZ?=
 =?us-ascii?Q?FAPmLHfFq03GSqVbceBa4dpigqUuiqlmBLsatwsSbn89K5jbUr784vmjAOLH?=
 =?us-ascii?Q?4CKP4LBknozrBXl/2lGBnY/lBWk+VLmmgjmw8T2k19+2FIhjTVY/uzBSfT21?=
 =?us-ascii?Q?Axu1vj6nzdQrBrsrL2/DPfFqaqyTYZeInjELLFc2mXk1d7MTl77cbBWbGAhr?=
 =?us-ascii?Q?WQNSNIWZtUbH2FLiGG7VPkxvPR+Y8w413+bHhFk4jvUxNSnHaONMXVSs1cgi?=
 =?us-ascii?Q?YbM71I2FFiwd050259EmZQExRoDi+FQMJSeCSxfEmat44ZlkwtXx4Qu+Dm6s?=
 =?us-ascii?Q?jyw/nsvROvG1lmMMsxUulorSg2ViHb8GHsiD/HaMrRyHt9M8DwUH6BGpPlT6?=
 =?us-ascii?Q?/8Oqx7bFUjDo40jZdwPM4XyyscEuL/UuSjGM+Uw8MLYcN1bxor+jZmvNMPA5?=
 =?us-ascii?Q?wdLKBTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQd3TRUxIfmHIpGt5rkEKuWBXl57it9QKycCLIQ3rTwaA4x+P9YQ6Q79Ujt1?=
 =?us-ascii?Q?0LCZYWltS8sMwYyNgFevenxcaEXFog6ngaNI6ZA/YMYimoJVKrfykH+URori?=
 =?us-ascii?Q?y9DUSEeenLw849/MQmyqj+RxrYZx8M7qeYlkX0zhatDOo8Yx6kbxcepwE26S?=
 =?us-ascii?Q?td5L0dnbqyvKcEIUwiN/Z6zBU/I3ExIVigm7fM/Kt0xUiE0fgSk/izZq9kGa?=
 =?us-ascii?Q?ffvUXB1ly6bR1rmXl67cKqfkRkKNJhLoO+XJBm03evED8yxl0urC5tAlASFA?=
 =?us-ascii?Q?ejI1BI2u3uJM8cgXhgIInACtDHLJKcWzNNl/YxRv8bGOTU535ZfNilx2hFK5?=
 =?us-ascii?Q?4xTHyqKHY3jiZA5EOVh4mSyXAbcXxGtP38yhZEjNR22vbyW3CacnN1aNEef6?=
 =?us-ascii?Q?jOuGuS3q8BOgMHzycicssNey31FYiazZDnqLnS2L8wXAmAdK7N9RJqRVMIvR?=
 =?us-ascii?Q?vq+5u35d+nsvwKKhm6EI0XivwhUjjkllZVHof8qrgvFMsJEXWBwBX9ZZJlgT?=
 =?us-ascii?Q?GprAMW0lnRvNry/KTMe6ANFDgHXBrkNA63XYOpPm14LUntA05iYFLmKWzjUU?=
 =?us-ascii?Q?sSD2RJZW0NP+MQ4jNx08Swu+T1Q67LsUUbt3covN/On1AoDLlJhIM8SbhZ7A?=
 =?us-ascii?Q?Sjp17uIiaa72FIt1wU8yHSWJ5a8mpoz+279Ca3az8EjCoIOWwaNiu4aEE/yY?=
 =?us-ascii?Q?WC0UktlAsg0IvDA2sF27EdL/fUhi59Ur6tGCh9GNBzqXGUMUTJkuhh8BFv1t?=
 =?us-ascii?Q?GqCs77YF8m/9vMvQjdsoUqilkXlOoJHLjhyLobythxiNJwQnlq0kO1cRIAF1?=
 =?us-ascii?Q?nAFv19LaLLqxa21x9jLi03/bIZDmmqkkQ7gtinm+yVloBIiJLB3pvhrjRLF0?=
 =?us-ascii?Q?dowPup/BxyhiRUR3mxWTvv8gUB7arue8QwhnIp0k/kZjW32CKzn9woYa0VqC?=
 =?us-ascii?Q?9jSVOOa7JWN1g5POv1xZk3M1Sv5i12SWe8/eSBhwf8fdcKZREDJDJINZ2pIV?=
 =?us-ascii?Q?Z4Bo7T8rFv9KzpXbAcKn00LXOOGTbQJ/ECxBmqFsuzagV+svS2jxMZ0y9fDO?=
 =?us-ascii?Q?09gO7PMURgHdXNu/rv0IIvg0bVWVXPUOHWRTWmT8m2kfC42+zvuWUsLKxDAw?=
 =?us-ascii?Q?DZJTQf1gi2J2iCFmZBvSbr+xBWKhVNfMNC3bJNgqYzIhuwGSmPeJ5YC5fp2i?=
 =?us-ascii?Q?+n8RQIURADG6kouW0APt3TIyVC0JzS/iZnFSy5iI16vOiVLrKk2NyVJL9Ke+?=
 =?us-ascii?Q?BqGzMZSUXXEao7ir6BGegXJ9Bc8frKQO6b9RaX8O/qOCdXmdZk+2IXWmVtNM?=
 =?us-ascii?Q?PS9TfDe6BSEsdAycXV1iSA7FPQ6I+0HMRDDfTJj7sCl5xtoJpMiwZs+AiV8t?=
 =?us-ascii?Q?qRmiWlDdFSPRmOFxMBEzgOlUkDBNLIBNtIQSScq19QAViRLAkgUuIFPxeP/9?=
 =?us-ascii?Q?Jvgg0+gi2FrY3yaHPwYcyLbo5hCuSleK7po5SzAjX+rUCWayr2xQvOBmjfSy?=
 =?us-ascii?Q?T5iAFvLViTXxPom3kcCTAzOrRPzATjwJy8ApGo/FfiPgjMRI3VwwhV/mXxSa?=
 =?us-ascii?Q?hxpKZWzIzaT9Bnew6M3AZtgb66ZayaZ/lTH4EflsbaXoG275362qfv+AQCdS?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aJrL5od9aJELHX2pR0jU80mOfRV2lFVsyMrwvEBEpnpVdoPi00TvGaqbne1cBqn4J4xjNc7r7FLQCOZN9f+LOe/+VcKLvWB1InkykN+/Bltk0SZlw+yMn9otLZF6NoYD47DiUcdmXfZcHBcazVhh8fJCkB+Qen9PSg5Uz++U4VGsZ09EVs5v81cn3U/N9goDUPFWXyMzXfsvyMUK0O6MrHB5KpW3l5IpjMinwpXYERmp9+pPRyCKY4zYwrOwVbjGXKGxz9ghX1cTJnHqdb2gxdX8yW7gTWfDhzZcB22UNU+oy3DzXCWR3ORvUWJX3R1sJMzkhoTKXd2P+vCSLK8FntN6L7QhC15lcE3wT5MVm/4ARQJTu5x3N9XlwU3QSTeCsJiXcfgO7dRLBg81LFtMVJv71t7OdC4GKyvPttuWBbiejUPU1DFsAMSw7QmoBpBNYAVtlNRxJL8VGM93VkF8u86l2QEqq7+64FtfUJ15/iRGJAekUXWYod1WwTKRH3jq1JBZoUpEOjiooUCy8j6kTSCGp+KsapgUgRSE9kl0lU6Un+PiFcw8TS7SY/Yfj3mPHQUlSH0+sY6iNBH9NSMPO2XATrMoirot4a+hc+Z6gNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75b4e6-abea-4ad9-384d-08dcd2640b67
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:17:11.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsi4kGYvh+mtjwKH36bH20bZB9Z7hbU3muiYNIkSzOpz16tPlkpv+kcrKbIQESU/HnV6tIjSvRMjm7uAQd7e1I1NYMIB5NqrjlgpgPVjvus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=797 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110099
X-Proofpoint-ORIG-GUID: 5jULzcSTNiL1NcJ1fE9CEgoZkw7mf5xQ
X-Proofpoint-GUID: 5jULzcSTNiL1NcJ1fE9CEgoZkw7mf5xQ

On Wed, Sep 11, 2024 at 03:00:20PM GMT, Greg Kroah-Hartman wrote:
> On Tue, Sep 10, 2024 at 03:54:18PM -0700, Richard Narron wrote:
> > Slackware 15.0 64-bit compiles and runs fine.
> > Slackware 15.0 32-bit fails to build and gives the "out of memory" error:
> >
> > cc1: out of memory allocating 180705472 bytes after a total of 284454912
> > bytes
> > ...
> > make[4]: *** [scripts/Makefile.build:289:
> > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.ho
> > st.o] Error 1
> >
> > Patching it with help from Lorenzo Stoakes allows the build to
> > run:
> > https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> >
> > And then 32-bit runs fine too.
>
> Great, please help to get that commit merged into Linus's tree and then
> I can backport it here.
>
> thanks,
>
> greg k-h

Well that's a surprise :) Did we back-port the mitigations for the
MIN()/MAX() combinatorial explosion?

Slightly surprising that those were insufficient if so.

Regardless, will send a patch upstream FWIW and cc stable

