Return-Path: <stable+bounces-126655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20491A70E74
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4452189EAA9
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966642A8B;
	Wed, 26 Mar 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iggGQHUz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IOehNyt8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B117583
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952783; cv=fail; b=lU3dRNyVBHoTTmvudUe03FfnYH0knjWhZDtt3XzDzAbzzZrUTy+XN1mXwU/KkQvX9EMYokLOn1rwAbtDsrz4vQfERB14QR/qZX3iCkuL3zilfCmoizQ+7zoJEOd83wfSbY1V1//6I9jYgXcz/houCl7Ek4WK7oW0HQ2yLvmQfVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952783; c=relaxed/simple;
	bh=zd+eQXxjuM7Exzqs19EuaxSejM/pTDGZM6ZhWEBN6Ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J24tSOoOAqmMqPsTHOUb3YyDxjH/6xR/zDhycjxOVZEI0B50FF4gJYhiUGQtFNytmtGQEQEmy4BcZ29bA9jr6eaITCdajska9OuB0aAZ712gNFJdFe98slMgeSLxIbtc2i1SlzeHHBugnP/tKaKrc4Ne6OzjDfFtnoDHkWt9c+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iggGQHUz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IOehNyt8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtvLD025366;
	Wed, 26 Mar 2025 01:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eYbY3iou+8wdkWIvGdtWXipmvfecZFP2NRRYJCqeku0=; b=
	iggGQHUzov+8nkQTexCKNVImwUvi5IWbAV4Bf8cn4VRPjVmuUVcxqICwGrkeSstA
	PM36ZncDdhl6hnE22TQkOj5w6+3b0YFSTj8duyO730IgAVc5MhUTCLU1Bxc/EvAw
	dKPej8De4c85CLTdUhT31vppb+SXVAvSd4V0fUcFVdwksm+XCcojFESQffrtneL6
	ZwiS9D7HL4GhBQKXEkfLreplzmHXOUo1/ogs490w994toS1SxkPSScGbkANqs8Dq
	QkJ6HS7JbZ7XOy0NImYrE+Fowd2p6+072lUUXjVbQpK9zGh763TUWXUdTeG3rKPW
	eUAEjppSogjwl06yeb3soQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn870bkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q16oD8008457;
	Wed, 26 Mar 2025 01:32:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6ux0kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx8mGWZxsNNgDLDE5xNiG51RJ0lDM1SHM5eyhJ9YhTnnPocEHQYQVsrecbjsYDE8hBBmIA2E5+XF/Pqn+XxbdOv20bkVHcCNDKec7e29CVJw7/nXi9kZ/yu4z2D+FFUYgaanXEUJh4Gv5daKmNsRmGI9zNoFlYOQXS7FYILVTWptmYJPkEOfWSENnIZ+QHV+q5KgDnN8+SqmyH0SoFnSBX1syTSJjIPmM398/LV4UJAx5IisE6ayIY4+smYhg5t3wRZaKR5OxJLEnxo7EXOvwmE2/rF6kFkC8sUw8yAbsy5+xkxxYbkB8AfEtlcwfKByTSru8JYIwnAlRBK5TvLhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYbY3iou+8wdkWIvGdtWXipmvfecZFP2NRRYJCqeku0=;
 b=qoFLGxTP7ARHkRZEkr2LzSLj8fnjw/rx4aWMyHpFHapyudv2+e4gpj0w3O+u3DxwoVI4yzMeT/Dze/nqC7ceXYxfYCszbwIncnmDysdvCa4RoVMaxTktRtJQN0Ua6HMqFWhgz2yZhfWCzppA8Vx4tnksBR+acF5UBNajusrn+an5ThhPJ659mFnsQnan2KfbE2Ztsfp1HvI0bepYen2foC0ebdoldAbWRbzRq+pb41FEi6ly5OgrVLaJS6+6pWcA92aJRT2SZbaud/AkdUbH7yh2xsbMYXDbPgkZuJtU6hH1h6KP5amSMYYtLUA66bYXgZHqq4clfUD2PrQjMwQITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYbY3iou+8wdkWIvGdtWXipmvfecZFP2NRRYJCqeku0=;
 b=IOehNyt8TJtTd146cQfoeAJI6BZ68mwulfpDnnYo2joyrf1q34f1aj8qsuZEeFo5z5ZXbKb7YjLL6GWkmDEkdJ+OQmSZHnUo88zkmBFz/k/Fcq1/QfdViIc+iR82CQgRKsmATlP5/bomyh3UQUV+gvrnNwMzp5+PncLUrjUS9DM=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Wed, 26 Mar
 2025 01:32:44 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%7]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:32:44 +0000
Message-ID: <ca78826b-bff7-43e2-8ab7-f4679e13726a@oracle.com>
Date: Wed, 26 Mar 2025 07:02:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Larry Bassel <larry.bassel@oracle.com>, stable@vger.kernel.org,
        xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org
References: <20250325234402.2735260-1-larry.bassel@oracle.com>
 <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>
 <2025032503-payback-shortly-3d1c@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025032503-payback-shortly-3d1c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|PH0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: a742c267-0b58-4f7b-6ab2-08dd6c061b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDkraEJGb0c5VFhFd1FvcFZSbnJzWWdvN21rcFNEWm1VNU9pd0swcGdaTGxS?=
 =?utf-8?B?NXdjMXNNVXJKV1YvVkZtMHpoM1ZhcE01MXFuL29HRGo5akRaMW8vQXVKb3Bu?=
 =?utf-8?B?S0pZWTFSRzYvekRmT2wzb1NsY1JGQTUydGVrNit5VGpiMHZJV25sUmZlZXBo?=
 =?utf-8?B?VnZBYkg4VHNXRnAwZnRxWTl3N0YzVWlqa2RzVW0xaUZQQ1B6V1dvTVh2eEVE?=
 =?utf-8?B?L2VUdUEyVEdYaitMVzVQcjZUOUxzTWhGS0V6T01LcUVsMGwvQjJJZ0VBNlEv?=
 =?utf-8?B?anY0MkdSdTI4QTNkNWZ5ZklHNWZRWXJMaE1iMkdlWTFGWHZnUmxxTGE5c29G?=
 =?utf-8?B?QnN0Njduc3J0RmpXeGgxaEhwTFQra3VDanYrMGdjU0RSY3FZM1g0bFRYdzQ0?=
 =?utf-8?B?djJzMFBpN0FpNUlZYWd1OHloenF0cDFUYnZoWW9kdWo0L3FEYVFIVE5UUGZV?=
 =?utf-8?B?SWhVUmhOYXE4VFNzMmpnNC94WnNuQzNpS1dzNG9sVW9ZaFloYmZqNWliNXc3?=
 =?utf-8?B?cVVjNEVFWDhyWmFDV2c1c0s5TG01ZGVhSGs3NHR4UTlzL1VURk1pNUJlM2NV?=
 =?utf-8?B?TGt1bXAzS2lpQ285a0tLWUZrSXFVOUM1S090TVY3bVFMWlpnRCs1ZER3ZnZB?=
 =?utf-8?B?amhvUHU3MVkyM1Mvb3dHMDdFVytCVmFpRytodVlaK3ErVUlqSW5iZEVxZFFv?=
 =?utf-8?B?cnhGOS9qYm4yQVZ1NVZ1SGQzSTlnUldWUm1IR28zeGhaUytzeG1sTWNCVzNq?=
 =?utf-8?B?VitwNnoxTGQ2TXgvWTk3OTdLb0ZJY3FoK2dyU0RPd1JvS0llK28venJQRFIy?=
 =?utf-8?B?SVZjaU5qcEZtZTZjL1QvMG9CV2g2bW5hUTB2Z0ZwSWlCclNxRFhZbzAzOXh0?=
 =?utf-8?B?ZTN4aU5YN3dMK2x2WEJaN0lTRnNqc0VFM2EzcmYyWnFDTmVTVmFDMTM1OUpy?=
 =?utf-8?B?bitET1lBOHBjSUtpaWUxa0Z1MUFoQXZZNlA4UGZLZ2R1U1U3cnpOWG5XbmR6?=
 =?utf-8?B?Mit5YkJmeGxINGc0MVdCS2tMeFZ6Zi9pWXhOUENSZ2s2S1A4RFJFeTNQYXZH?=
 =?utf-8?B?SFlEeXRxSXBJUG9mLzhvbTJVVTZYMk9LWXZNdjExOEp4WjBkeDRYN2J1akFF?=
 =?utf-8?B?SmRsZ0xiS2NBY2xCbWZGMDRYTzFmejYvM3JQK1FVcmRtb1dJbDhPZE5hTjJZ?=
 =?utf-8?B?WVFNTndaZll2ekdrMnRHeWFkNFkyWENhaDRGSmRWRCs3a0s4QXRiRStQWCtB?=
 =?utf-8?B?L3I0RksxTy9jakdGUVVQZmMvMmJPVmZjOWx3TkNUY0VuR0g0NW5qbGZLaDBJ?=
 =?utf-8?B?VG5qeFR0N3g1SGpXUGJ2SzJsMS9JV2NYRi9VUHhBalphYVdrN1JKME9hWDdF?=
 =?utf-8?B?T3padnlxdG5iakVxTW9jSUxvVFJqYms3bjQxQVBJbnJXdEZsdTlVZnhSN21k?=
 =?utf-8?B?dDFxMllkcTBZeUs4ajM3eUlBbXYxQm9nUEkvMHVPVHhmekdsOStWQ3dKNytG?=
 =?utf-8?B?TzlkaTdxVVJFK2pFajY0OFMrdWI2WkszMXhJdlFxZ3V5YXN2WkRaK2MzUG9o?=
 =?utf-8?B?Qm5iMDVCN3hYalRMd3AzRndHVEhEWnpFSWg5RXI3aXFvR1VQdUwvSTQrdnIr?=
 =?utf-8?B?NDlQbTMxcTg4Ui8vRC90Wjd6ZmRNTlRJZllHVlRzQTIzM3E3dktLVlpPa09V?=
 =?utf-8?B?c1p5LzJubExOT1JtZHFiVmxvZSsvT2p2TG5vb0RiS09hUGZ0MjRrTG9XZUho?=
 =?utf-8?B?dm9BVTNaTHRmcW9SaEFDVlpzTFdJaGc3eEhPTkFtcm9hd0N0ZTdwd0pzMjhj?=
 =?utf-8?B?NXg0SHpWZjBuSTJJMDA1eUV5S1JGRHFwcGdwMC84SE9EdHdQaXgrSnIwUzZW?=
 =?utf-8?Q?/KPuS9/OW+CHe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VBTmhqTEdoeFZjRzBMYzA0RXFCYjJtMnZ4OTlvK3EvcjMxODBuZGkyVXFz?=
 =?utf-8?B?aTdBLzc2aHg3ZHNQRXJJUkRRR2JZaTFlbmRsU1NQdFJTVEdTUGRFL3NPRFp5?=
 =?utf-8?B?TzA1eSt4WFdRTFJQdkZtY3hjZXJzSzNMSGU5QUhmdWJMdlFybHU4SThwTVVR?=
 =?utf-8?B?dDhIZ3cwU3FEUkZyejV1R2FjampxZTFiWlpSUXFzdGlNMmpqcFhQNUlMWEpC?=
 =?utf-8?B?OTBVSldvRzBvZDdWbG54Ti9UNW1wMUJySnY0OWd0Y3U0TkVOUkdRejZCTXAv?=
 =?utf-8?B?TGtLMzMyWWJ1NXZiaEJZVnVnLzBIVVp4bk84VjE5UGxrVWNuaWF1V1k4WTN5?=
 =?utf-8?B?Rkl3ZnpabCtwVHpzZy93eGdjbWZTcWpRYTdzOXE0dGFoYjY2T09HeCtsTXpG?=
 =?utf-8?B?eTQ2dnBlR1J3d3RLSERkYzY5RWh2dUQrMHFMakJhVFByemtEVWlVOHMxdVlM?=
 =?utf-8?B?Z1ByQXFBaGVEY3A4ZEh3eVNBZlRRNW9oNW9qVkY4MXBmcDJ2WHdwYWJRTFlO?=
 =?utf-8?B?MnF1dmdmMXhDNzF5K1E2S01JZ09vMEQ1eXlxTzhvMm93ZG1RdWxENnZEVXEv?=
 =?utf-8?B?ME80N1NNSFlFMDVMdkhOb3g5ODkycC9NanlxcUhUdm1HcHZ5ei9XQzcyaEN5?=
 =?utf-8?B?eXU4V241eHRieloybDhqNDlVeHkrUVQwMEVBQzFmcE5vRFRzKzRlVVpQWjdU?=
 =?utf-8?B?TlB1bHlBZUZyeCtONExoNDgxalVjRDlqaGhIWXllNmxTYWNuMExlVllhVDV6?=
 =?utf-8?B?VnZwSDRvMUZPUWxvVnJIWmhpbWRSenE5clNJOVViRXRmWHNkcHhicGU0T1dn?=
 =?utf-8?B?N29Sc1VwaUlmamxXbnhWZnNuUzl5aGxNR09EdXFTTDZVT216R3laWFBaRm1Y?=
 =?utf-8?B?cWViMnZvdVJJV1lpMTJSNnBFeW9MeHlkcWt3dWk5RWpyQlNmbkxVQkRTbkdw?=
 =?utf-8?B?bGo3R3pPS1g2cHRocjJNK3BlRjRNYU96L3FWNGQ2Y0xleEJZQnE2bVplLy9C?=
 =?utf-8?B?NlZXeUROMWJWWFBYN3d0eVRRYTMybjBCQ2tPd1FBZUhXc04rQmNBWkEwMUoy?=
 =?utf-8?B?ZjdjQWRzUy8wZWttdUJvdmZEOWlFLzJZeUNqa3pTVjR2c2tBcEI2Tzd6b1pj?=
 =?utf-8?B?K2o4MFJQMGlsZ015SVVvRjNYcDFSRkxBcEI3aGNFdVA4bFlZMVI5c0VyYUpM?=
 =?utf-8?B?c01qSFJiZjd2eUpjaXhKNjNIa1NSMGhndTJza1kvWlB1clR5emc3a2JzVWlP?=
 =?utf-8?B?UXh2QjE5eExhZ3JQbUNNWktXaEZUaEhGaFY4SFQvbk13a2FMV2xWSFQ3azcr?=
 =?utf-8?B?azZJbkhHZkgrK0JvYUNDZzdSUlQ2WHY4UkhqU0Z5b2V0MU1XZG5zQklFTWRn?=
 =?utf-8?B?Q0YxSGttNkhDMzc1SEFXVElIaG1XWCswL2hKdXRNd1ozNVJMNnk2MHgxUjV0?=
 =?utf-8?B?Z2x5UCsrTjZiNi9XYXl6eEhZUzN2YWxqbC9KM003K0dibXpaVmsxSTBMSE1E?=
 =?utf-8?B?M1VrTlBJcEt3UjgwakdEMXl4Wk43Um5kb28yai9aVWZXbEg3WlBnaFp2MTBQ?=
 =?utf-8?B?T1NFODdMTXFJYXBzR2ZYSFhZTjg2MmplS2dsd2Z5dWV4QnVLYmxvd1A4bDVN?=
 =?utf-8?B?T2FFRjFXWW4zVHA5OTk4V0h5SWhTcjJuVGR0Y0U3Q29rVkt4UHkwVmFQb280?=
 =?utf-8?B?eEoySHpNT0ZOSi95aFY3U2ttYlBxVk9UcFoyaS8zc25hd0oxWFFKL1lrTHlN?=
 =?utf-8?B?SjFyVGZ1bTU5ZzlZbWZTQXZMK3cyY0FDUjNrNlFGUXp0MmJaMlMwQ3htNFdE?=
 =?utf-8?B?Q3h1Y1JjdS90K3RTam1LU2g3RnZsTzFqMXVPVFF0RGFKRi94R1c3ckVaU0M5?=
 =?utf-8?B?VkZjTVd2SFJGZWRRM2hpREpoUnp2SW01RGlpT2JLdlRCYXhsTFhXb1ZweFJ6?=
 =?utf-8?B?YjdNWUtFc2lvcWdKeUIvWElLSXg1NytiSnNwbGxmakJvNXdYbTF3NFNidEtt?=
 =?utf-8?B?U0F0Mmo4S0pvaGJsQTBNSlVCT3VUY2Z2MGxBMHk5cFQ5RlZiRWhOYk8yZmo1?=
 =?utf-8?B?ZXlLcURaRlRRVFF5NVAzUnd3Mk84TFJtQi9EVFkwcGhSNnRyVk51ZGpEUmor?=
 =?utf-8?B?bW9nOXVSd0ZWcFppQzB1TlRSdHZNNWhud1F6cFJDSVVJUHhtT05OR3ZldTZn?=
 =?utf-8?Q?X8YO7QS4z4kyhmUFjfdx/F4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qA0aPGxBWkzrPq4T4MiYJltDCa8sh2saEGC6/9xCiobikSU62SCfVjBjV5EqMV5w9r660SkUKSG/p6lIWs383SjVHoKqzemm3D7RoqdeT+w7NzG+y3BhGMhkPRPpwqdwylghSr1mkQPFUywOG/V7OnZnIX7M3P3xY+9f1K3Dvsl8QCxoPNc3IK/W/zAQKfq3wui9aUYpI+FKs0whHbCUH2IzKE4VR1jT2mjGpsJ3E6Al4+ORnDfM5APjNtFypEhMYBkaeOizV5gQM0YtW2MkpNCQVvla4D99/WWPNLNXp0NhBvymiTnHzShmRM/Tp9qitJaePC+IE5xh+6+X/lRXKgKPx/BSKXXjOSBFisBZ6xxSXcc/GU/Uo/tSbmwJk27CVqfEy7iCD5saITEh+tpVAZzyO7NOInWY/hGEcdUzalFctkXq9zfkFyAn+i04/pkMgdUl9lMHuU7ffPcW4p53ovKIg1qyQGlWdIBc2RzYT0Pz7is61XkfMUUvy/71n0Eddl5eUG8oXKmvfjRc42Z5Ps5E1L0ErfUGbpK2Pr/7CoyQn9CXBVPivxpPeFOe+YGwjxxDRCpyMkyi5Z3RqxNu9lt0/l/Pn6eD9btD+jNCcCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a742c267-0b58-4f7b-6ab2-08dd6c061b49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:32:44.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHqDjt6X2YGMqiterH5x6WUgj65P7C4t8gp390FOBZbeFUQ6FiFY63bUeh3LTZ9EYLcivKD4eZZ73oDMVIRZVDMpXtCIERm8RNskG7VVnuLvdI5/gX3kt1Or0wS+cF2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260007
X-Proofpoint-GUID: ww7c5iUeceeTrw9UBe7_ovqCp9d2C2hH
X-Proofpoint-ORIG-GUID: ww7c5iUeceeTrw9UBe7_ovqCp9d2C2hH

Hi Greg,

On 26/03/25 06:47, Greg KH wrote:
> On Wed, Mar 26, 2025 at 06:32:19AM +0530, Harshit Mogalapalli wrote:
>> Hi Larry,
>>
>>
>> On 26/03/25 05:14, Larry Bassel wrote:
>>> From: Xie Yongji <xieyongji@bytedance.com>
>>>
>>> commit ad993a95c508 ("virtio-net: Add validation for used length")
>>>
>>
>> I understand checkpatch.pl warned you, but for stable patches this should
>> still be [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]
>>
>> Stable maintainers, do you think it is good idea to tweak checkpatch.pl to
>> detect these are backports(with help of Upstream commit, commit .. upstream,
>> or cherrypicked from lines ?) and it shouldn't warn about long SHA ?
> 
> Nope!  Why would you ever run checkpatch on a patch that is already
> upstream?
> 

Ah right, not in this case but it might help when the backport is a bit 
different from the upstream patch(i.e after conflict resolution if the 
line in code exceeds 80 chars) -- checkpatch.pl might help us do it in 
the right way ? (only in a case where there are changes between current 
upstream code and the stable branch where we are backporting to)

Thanks,
Harshit

> confused,
> 
> greg k-h


