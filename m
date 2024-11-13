Return-Path: <stable+bounces-92890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF19C6962
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953FE1F21A6A
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D8176AAE;
	Wed, 13 Nov 2024 06:38:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278D2594
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479901; cv=fail; b=opysLm41QpRTH+TwldRxT6c5pBPAMb81Pqu7ZWqaUxu/FnOqMI0Oq5rx4RvXG+hTOxajDv+eRe8jfM9CR1X9SwND4ftIFv5dUprEwAxl9r1zTOFBe8iRDqtEyBAxmkcM3zBPhcoOdKrAC6WHgXde+n0Ebihsqj1HdZkPzItAwY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479901; c=relaxed/simple;
	bh=7k+KYRIVEbQLoOGSnkVWdcroJjL1/10bE2yTPYyt2hQ=;
	h=Message-ID:Date:Subject:From:To:References:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=OJhf9YiO0Cq9sKNxjWDqMUSruco+cFGk5/R1nrnASWKVVKlzeb4QmDxP11g3O35yV95QJL9tY2b8/oEeGMGq5627V/qg2pfm9c/5nHuLamuyRuy97POs2Hh4/cSa6xTvqXihMitkol8W6PmE1/8o6losadMddzELx3lJc/De6Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6K2sx030342;
	Tue, 12 Nov 2024 22:38:03 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpmhmre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 22:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToDQgRuMEOdL7V/uEbLUD0dTLRzjxV3oSEZeOKl4TBBIXR7qOd0IObIG8rKhW/HA7da/+IvmryJ47aq7dDcOmmC1dzVeO4gib4vdlz/bBCpxVq3WupOlWTzFjMBwMCJ6DCya8HFuESw0Hn1P8qmpna8sm/xAlO1zgi8Vd+R8g9TzgGHY1gxfXMXSTKYcm4PKosRdiE08Ip67gnqJVZrulhg36W6N4UEQ3EjUWrZqRX0HG+dODsz9T6EKeeF6ACzjt+zXTjHuSWshhIu9COseW4BpCKzYPIuFGnC/eymoKfY9kglo6WM0Xbt45pLHDHRU9JUkhplSZQU9AC9750W4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw+rr/t6Xjo//VkET+IsX3j1wWH29VFojdGS6GkxGw4=;
 b=u/4uMXgdByQsiMQadznRcRmd8oo/s5hU8srehpcEuFvcU/UlF2F+I0FwCkXSBzjWGFYY1NYCtgMNy1leiX1VBYJ594d9xJgeoNeclSLiKhbc8e0e4lmiIU+5tSP61lCubXnei3uM7Vy3W79HwegKqlgfDr0F/PUmeYs1ctMZ/oGn496LERGLlpScHJN9t4Oi4PzTKUFGbn1lGZLXPIMPy3kNDppwVvzdrq34fiAg7pNH3DFM6B0w8088iu4/aQ0i/G0oBSsSAs9plIKoCDMMwIYTVAx5nt6oSRGQz2SRY/wqu+IqMcERUkW7cbXO6NnzSf2C34nT/d2YzLkk2Zejmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 06:38:00 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 06:38:00 +0000
Message-ID: <8444629b-34c1-41e0-8edc-404264d46b11@eng.windriver.com>
Date: Wed, 13 Nov 2024 14:38:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] blk-iocost: do not WARN if iocg was already offlined
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: linan122@huawei.com, yukuai3@huawei.com, tj@kernel.org,
        stable@vger.kernel.org
References: <20241113011237.488632-1-xiangyu.chen@windriver.com>
Content-Language: en-US
Cc: xiangyu.chen@aol.com
In-Reply-To: <20241113011237.488632-1-xiangyu.chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fccd12-b697-4d48-1dd7-08dd03adb7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUpBSndIVWdtUG1qVzhEVEVKNDZLYm9YZTZDWnFtSXJGY08vcmhwdzlaaGxR?=
 =?utf-8?B?b1NUUHdvT2Yvd2xwVTVtd1Frc2lOZWJIeFpOampaMUdXaWZoM3hCcXUwbnRy?=
 =?utf-8?B?aVJCVHlmeVdrUGNVTEQ2aVZHTzQ5MnNnekVITmhRaStmSkhyN2UxYWJSZG9Y?=
 =?utf-8?B?ZDZzR09OaXJ3VUhrY2d4Rk1KemlaOWhaMFU1clovSkRRZFh0TlNYQjQ5Nmwx?=
 =?utf-8?B?cmg5blF3b3RTbnNWZVZaWFBMSkkvRlYyWG4vNzJQQWZGeVZ3aU9jYlBKc0RG?=
 =?utf-8?B?bzhvL0Vydk1CZXFBbmp0RDFrSXJuMXk2anlQaUo0MFk4N0JVZzl0c1pEbHdJ?=
 =?utf-8?B?VG1kMUw3OTNJNytydWxZdTNIb210dnNDR1JDREEydzhaQ0NZRHY5Tmg0NEdx?=
 =?utf-8?B?bHR5SVBRRHlRWFFCZ3E3Z2NRMU1XM3I5THYrTGpNYUNMTEZsQkU0eUVRajBI?=
 =?utf-8?B?K0FUUTZBQnlYL2ZybmdlUkxFRUlNdXpyUVJ6TS84WVlGU0phQTBQdG5lL29w?=
 =?utf-8?B?VXhTZmRiNEl5WEgwNGNoOWFDcCtsOGlQKytrSXp3Ynhoa2NiVFFWeDlFUTIx?=
 =?utf-8?B?MC9CcXdTcFRmeVdsTVBGS3pGaXRaMkxUbisvVytPUEExVDNJalBiVS9TeFdR?=
 =?utf-8?B?U2dXZUpobDluZUF0SkFPZmxXY3liYkZKa0llS281Zkd0WUNZWTdQSlNCZllt?=
 =?utf-8?B?NnJvaHoybkNpMTFsaUVpN1Q5ZnlNUU1FTmxJNEhnZDRrcEJLNEhMZHNkYzAv?=
 =?utf-8?B?SjRjR3dSRkRDSER5RlBmd1Qwc0JOL2Nrb3V4dUZmV093MGtqWEdZcU1lQ3NM?=
 =?utf-8?B?Mmd6bU0rUHVpc2NXRFMvcUllaEJLMXQvOVJ6Nko4UUxzY3Mxemx6b295VGIy?=
 =?utf-8?B?TXN5VUFDQXdaN0Rma1RaVXRsbENack12ZXlocjhkcG1NdWQzYnRVTzJ6WUFY?=
 =?utf-8?B?ckQxY2hYY2pwZXZ5TEVRU1NTdlV6SHVXN0JTa0ZpdG5ITFdLSmxIYWlpRURt?=
 =?utf-8?B?SE1rWjhFVUI1NFI2N0dxdG9xdlNkeDBoQ2RmN2lhRHZiNzRKZGtwRkhmWDFl?=
 =?utf-8?B?dVRsbFRsR0J6eEp1MG1HVG01bjJtbTdWVGx6U1FWaXVpZ1hobTluL0M2RTlz?=
 =?utf-8?B?UjJuWUFrVVduOHFnWkVYbVl1OWFtUFdWd1ZzK2xiSDJYSFNtblhIektraW9a?=
 =?utf-8?B?eDA4aytidFFtYXBNRWp0ZzNSOWd3YVJBbzZJRlM1Y2J3WWpaOEwzM0t5dEFN?=
 =?utf-8?B?K0twVnR6OUgwa294ZXlIeTJvdGc2MU00RDIwN3EweGo4Yk00OElqSWtNUEsz?=
 =?utf-8?B?RTNmLytjdUJWeWZUeVlwanJEYkZCa3BnOWlIVkEyY2phVFV3N1Z5SnpHRC9B?=
 =?utf-8?B?OVFJZ0VCVU5WOC9PQStrMGVJcVNubU5NUVRncmJyTVlVMm5VbE44aUp3OVUv?=
 =?utf-8?B?NVlFNlArYmZYNG9wdFpENmdteExlMUtrd2JKaW5sL0ttc3c1YmpkTGRjazFq?=
 =?utf-8?B?ODk2NS9lOCtvZ0JqWEtYQVZ6dTNnK2tsQ1RFem00RUxMQzFQd29PMXJoQk5v?=
 =?utf-8?B?ZkVZaXAyTU9MWnFQT1JlR1g4NVFmQkdRb1NFeDB5L2U5ZGxhSmZic0tTK0VE?=
 =?utf-8?B?dTB5WWVjUUV6WW1BbU5VRVMxd0ZhQ2xUZk44RHp6Umg1L2tLcE96Sm5TUVBR?=
 =?utf-8?B?SHZLWlVwc1R5UFV3WGlNWmxVWHJhNmNCblNZVFJhYjQ4VHFmTzI2SFFnYlVs?=
 =?utf-8?Q?JylRzFuQae4tIQkf+JXnA9yI+UWvytI+mjsqq0K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akZ6T3UxZXFpdmlVMVVFNnI2TVNtRmFTa2ZhcE11RHNOTzNrMEhSSHlDNE5h?=
 =?utf-8?B?V2dma3ovNm4xc0trS01kY2s3MVlwVVpJREdpa1FuUVhZSUpkQ1VLVVU5MlB4?=
 =?utf-8?B?clY4bGdyYTlNSTczMnRQd2NPM0Zhc25LMXdMNXpHY3A3MkhVeGczRnVLdEJC?=
 =?utf-8?B?ZUJNWWFDNE5iWnVTc0krNFNGSG5DeEVEMFI5NElueklwR0t0bEloWGE3NHB0?=
 =?utf-8?B?ZDNPMTZuS0dmc1ZPSHhZaFFYc2xWczA1Y3d3K2E3dDE3TzJLZjd5N3dTVzJF?=
 =?utf-8?B?eFMva25sNlZFQ3p4TEMrdCtRQkFTU3VBS0tzRXZuSWd3TzZQOTRTdjdETm0z?=
 =?utf-8?B?NU5LNEZtVm0wcytEcy9ndFpMc1BDSmNqWTBjNldEQVJIMTd2Y3YvckYvL2Zo?=
 =?utf-8?B?SDhZak5odm41ellWZjdOWm1EY2RRdWFtRVZhMm9XTWxOOVhuT1hXekE5SFhh?=
 =?utf-8?B?bENoMlAvMnBBUVVzdS85UUMrUUVpUmhDQjFEbWxBS1NFV3kwSkVPRWJEaGFP?=
 =?utf-8?B?bnRyRVlkaWQzYjFEbTltNlNxQUcwaHBGZ3JMOHpDSHBaRUdmK2JzRFJ3VC9h?=
 =?utf-8?B?OU0xUGNDSnU3YVVFaTZIWWNpd1d3MkhqVEZYTlVZQWd3UnJkSzIvcG9QeEV6?=
 =?utf-8?B?RnhGL0FvTytCQWVBSGM5Q0d2Ri94Mnc2QS8vc2hON0RwbHRtOXN0eWRUQXBx?=
 =?utf-8?B?SWtONDZsZ1JMdWFjZ3VzdlllYUdSaGV3dVo0SGxOQnBJUWYzRkp5T29SaHUw?=
 =?utf-8?B?VjYzWkR4Y28veW9CQVVDRFo4QTg0a09HRUdJYnZEc1BVSGZFaUp0a09QWmZk?=
 =?utf-8?B?ZjVaY0VWdXhKdS9BcEtzcVgzTG9sQ3l4ZGFiTC83anZLQWR3dzU2WkROTHFG?=
 =?utf-8?B?Tk5xSnUzSnhiZlJCa3RsR2ZzNmI3b014M3lsUDFFdDRrSHR3cXoydFRyQUNk?=
 =?utf-8?B?bC9hWDRXQW80MlJ0YXRsTkl3bXNna1N0QlkrV052dkRzcTZpa2haSWpYNFc5?=
 =?utf-8?B?R3F1M1VMT21DbHVFeUhEQUlQZzNNb3dBVGVLRllRYWpWV25GYmNlMGJOTklW?=
 =?utf-8?B?bGI4eG1uelh1SjBwMUFGL3E2anhXNmJhZmQ3ZjRhTmc1dVJqdEhJRUlkQ1pK?=
 =?utf-8?B?N1g1aTVJU1JpbE9EeGpCclhBVTgrSnVVamFUV2kvb0Y1b3hONzA3WW5BWGs0?=
 =?utf-8?B?dkdrNHF6czM3SFlLQjVzeGdVV2tiU1g1SktyVVE4VmVoWFZhMGp1VmtLZWtx?=
 =?utf-8?B?QnhFZDc5WFB4MU01RWtYWVgzNGg3Sk9sNWpZZlNsVFhpcWh5dGY2VUJ0TFl3?=
 =?utf-8?B?N0tORDhHbjAxV1N5aTFHQzQ0b3o2NmRNM1FTNUFEbjBCUmw4dE5iVXcwcENC?=
 =?utf-8?B?dmVJRzRBZ3E4bnJ2akcvY0FlNEZrSTRXajV3RlJ6d2UyblViaHR5NjFuOTFT?=
 =?utf-8?B?ODhnb0tyL0pSaHZXQTlzdkxSWXFvbSsvWitWbGVhd2c5Qk1JTkcyV0trVmxa?=
 =?utf-8?B?MHJaenRkMVdUN04wb0xOM0VaTi9UMnZ5Z2tRVGpPQjZGSnNJSUEyZDZYUVAx?=
 =?utf-8?B?QklObTQ5cjdGTzE3Y2ZtRzJ1a1lzOGhtblVYZTBxbTJVeVQvNi9lUElvcVhP?=
 =?utf-8?B?eEtzbzJudmxsREI3MDNOVkpmb21mQy9pSmROWHZlM2RVNjRpUXFZWjhFQ05z?=
 =?utf-8?B?SS9mQkhUR0Y3ZElabng4dXZqeUxUbHRzNDlPSlhEakQ4aE4zVVBYWGZOdENW?=
 =?utf-8?B?M0dTUDFBYUo2ZDY3WE1QK000SFZxVVZKaG5OK09UaVJjbWRDam1NRlRhR1BH?=
 =?utf-8?B?LzlhVXI4dERCVVBZSzk2cnVnQWhTeWlEYmFVTDZBb1NOYVVoMHdLWE1ucE5W?=
 =?utf-8?B?YlBtS21FaFBqcFN2ZnFHdWFLUzhCWmgvSG4vVHcra0VaR1Z6SENEVHBSSm1I?=
 =?utf-8?B?UkU2QnVlR3ZBSjNFVnNudjVzaDZ5NmFEZlFtd0NzYTQwckt6Y3BEK2U4Qytq?=
 =?utf-8?B?M1FMc2NVZTBseTIyWnN5RWk4aFR6KzR0TklPTVl1OENYcGVicm1VNDdRTWEy?=
 =?utf-8?B?QXRxWUFUNXNrbHc0QnBDeitzQWx2amp0UWZUMkJORFFSbTlieGEvZXU0cWZ1?=
 =?utf-8?B?YlZYR1E5NFVpQnpIVkJQUW51aUszZkdBSGUzbkZ3Y2RiWHdwL2gwL2FWQ012?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fccd12-b697-4d48-1dd7-08dd03adb7b7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:38:00.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnRoeRTYnyJpabcOgQjOCzK1JX0DhQtzynryfR9HBjNMvSDMj7Y8WTGfd3TXSotJsJbdJcH63CQT/fIMsTJ6vm+rAvxwmFriDoqJaAiHcTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-Proofpoint-GUID: 7uW5NiSb0Ey43Tj-6lekW-xDKw27FV1s
X-Authority-Analysis: v=2.4 cv=ZdlPNdVA c=1 sm=1 tr=0 ts=6734494b cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=t7CeM3EgAAAA:8 a=AcudRgbqw6sV2eNOjtEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: 7uW5NiSb0Ey43Tj-6lekW-xDKw27FV1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411130057

Hi folks,

Sorry, please ignore this patch due to this not fit for kernel v6.1, thanks.

Br,
Xiangyu

On 11/13/24 09:12, Xiangyu Chen wrote:
> From: Li Nan <linan122@huawei.com>
>
> [ Upstream commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6 ]
>
> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
> is intended to confirm iocg is active when it has debt. However, warn
> can be triggered during a blkcg or disk removal, if iocg_waitq_timer_fn()
> is run at that time:
>
>    WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
>    Call trace:
>    iocg_pay_debt+0x14c/0x190
>    iocg_kick_waitq+0x438/0x4c0
>    iocg_waitq_timer_fn+0xd8/0x130
>    __run_hrtimer+0x144/0x45c
>    __hrtimer_run_queues+0x16c/0x244
>    hrtimer_interrupt+0x2cc/0x7b0
>
> The warn in this situation is meaningless. Since this iocg is being
> removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
> is canceled after removing 'active_list' in ioc_pd_free(), which ensures
> iocg is freed after iocg_waitq_timer_fn() returns.
>
> Therefore, add the check if iocg was already offlined to avoid warn
> when removing a blkcg or disk.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/r/20240419093257.3004211-1-linan666@huaweicloud.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>   block/blk-iocost.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 772e909e9fbf..12affc18d030 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1423,8 +1423,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
>   	lockdep_assert_held(&iocg->ioc->lock);
>   	lockdep_assert_held(&iocg->waitq.lock);
>   
> -	/* make sure that nobody messed with @iocg */
> -	WARN_ON_ONCE(list_empty(&iocg->active_list));
> +	/*
> +	 * make sure that nobody messed with @iocg. Check iocg->pd.online
> +	 * to avoid warn when removing blkcg or disk.
> +	 */
> +	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
>   	WARN_ON_ONCE(iocg->inuse > 1);
>   
>   	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);

