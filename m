Return-Path: <stable+bounces-232827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGeVGvJSzWmnbwYAu9opvQ
	(envelope-from <stable+bounces-232827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC137E816
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E437C3053B24
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2447B437;
	Wed,  1 Apr 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="loC/fEPO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259B47CC61;
	Wed,  1 Apr 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062916; cv=fail; b=MIgsnR/aWVe6pZRVK3NVGtAYhQZyKdAkv/BFbq4zxSMieJFkZTHKE28fTkvbHO94Un6RojMbVKzZnwGZ8fYvcQOK5+FU4GPMiU8yGeJzgO7T46D1ysgR7ESp6CUtxeStBJDxBTFtR5AwVyw7pHkJOl1oYFvu7wBfWVZKwAOBLbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062916; c=relaxed/simple;
	bh=gwKOu7rMkEK48lamRUdygXBgMj1hd+J6wMFYF5exTBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMmdNYwuGq6/LYuTVKnldwghloSV7sJt5ecltQdDJH1LQNryeP4QDnvT+zDLXrHEn5AXox2Mo2rtSuRmS/DhJhrnIaa/FQOyvq8fR1kBelQCGdlJ7AUHh0Mn0Iz9181w+HRa2ns93Ct9dv4mYmh1IMXAcjUWTVVoa+AI4kmGNKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=loC/fEPO; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318ij40724059;
	Wed, 1 Apr 2026 17:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=taaImu0Y/8psSDq6psmOd9GSowb02TbQURdYV/ds2G4=; b=
	loC/fEPO3ahfYeKpOK06BLoTqHXnYw0/VMFDI3kZZnNf00YPbKWOlfPXi2yaaqw9
	GA8DCz73C8cMxojwgDsn2S4uIvFGD4eSdQWm+uGRDDK0w6nOrCYI5tAXsJ2bC1gF
	juEcssiRaMUIZRKGN15QQTtZSpJBjG0bieuEvqPe9LD2AH2b1+NYLVnGbkCyBOZn
	exAEovN9cGxY97Km7NIAU+7YzE5lHPC5Wj8IT6RVXfH+s/lgk8ugok5IZCuKR+Ef
	0GKSa7gY86CbcuIrO7zYBIM/tIC1cWaNDZlwDL8VDevHcm3ZQ/cfCyZDrk3aDxxS
	dWaOVCelw1jsbhuyGbpmmw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vx4kj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:01:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STPVZpzr9FLcEyRfVMJ/imBXb8BxlyY6NXqn/2WSSUuRB6vaykIirgJmGBRa9wHox/xaEbbJkU/LhIWsAT0qMsyyLQOKDFufZ2s4VQWZzstYEHaGsdhzKhfYw0OqFpWEsr2HMaStv1R8dGlRX7oKVWf+PDglr3A7Q8wjCPNcD3YHpo+T85KhqGnPEdppgu+1OrmRKmfTIy8WCq3MzznlsM1xclWslUhU+Pq2dF4RSIX2LyQfAYleb6TNYHtZxg90MDAw0kA2WlLACdlMceGnzlyXwrYyPpIJ+aSKUILabM7SzZGJ3LnxnE56ZJi7dCKnvD6+gCM2bLL289asUAuBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taaImu0Y/8psSDq6psmOd9GSowb02TbQURdYV/ds2G4=;
 b=SfGw60wslXVnf7VjVyygFlGxdX+jVIWAVGkiaW6XddfJNG0B9q0iiver1rlH29Vs0RTde0tDO7mZ8l2O+MO3LKGZgCv+2JGYsn7/PBIbFDUpQueHSwt5mQUEbg1Bbmjar94MRM5MtGsqD/YkfVe2UU7Tnw2a5nctS6rfQhWRulqeW5hTSawQq0XmNR+f481qAmFT06NckeOAlCZp17feRG0sbyS87X3+H3v9wRdBouifkmNxo2Fn4SJ/bfJJLLJ/5pEMugSsHXiO4NkSruu4Mb16QAOl2K43kxn8N9VO08XqJzQzhc8JNxRZAwQwlCugkFUSNRdVBzh7SCAS/mWJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:01:14 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:01:13 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: jan.kiszka@siemens.com
Cc: crwood@redhat.com, florian.bezdeka@siemens.com,
        ionut.nechita@windriver.com, namcao@linutronix.de, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com,
        gregkh@linuxfoundation.org, chris.friesen@windriver.com,
        viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock" causes ~50us noise spikes on isolated PREEMPT_RT cores
Date: Wed,  1 Apr 2026 19:58:40 +0300
Message-ID: <20260401165841.532687-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com>
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0038.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::27) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BL1PR11MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4818bf52-a454-445b-fe29-08de901047bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	q8k6A/Zo57hhbk6oaxoAoCcey/EiTdjYFFx5ovUhDS3hvS6/WcPQuKt6VXtKisBOiEsGTaGXNl3hVCpYxJm1hYSB3lMSIRAq4EOBAXzfjs7MSXsuof/3b8lqbYqOANQbZchQH+PCUZ8FFa1CszyBXAlisikddltayDozhpgG1LnMfLlfyYqdgXZnGZAVc3vQAWoTw+jREa2N4gWLGQgrHo6CaAmM98njauA9FUQcAcPNzZPab94WgHhfIUgBD/Frx886200znUO3SFHBr3yqpCP1eyiAtqjMOVKlVJqv9T60tV9BCP06zas/OKGAseSaAUuAmRzf5BbHEbPCljoHfcqGqq0nwSRrcL+nCDbLg9DzCTIYaiNsalpqL+wUSZYJW/6iHKMOp9DKMC/mguAR0/iTSsL2QQnUX8vbas6ilyW7OnsJ57noPnpo7lEKltk3zvtC7s0o51qDUcm+ZtD0HDxmcJ1nSa+q66Ljiwu5Q1GcMAq71fXEq8CQA0ZPFqChdIE/HE8EMy80S6MgII//V+0xK3CkcOz07tga+rCZ8+6/IEKNO5Y77ZidUv15AiejmeH1llIdkPR6QgCbeY7XDd0E7oFJ1eAaKrmEsxisDIuS088r/qIQlSzdGAlN57smD1iaGqo2zGTejeMbzuG1RRYWY0p2kNpJJYA8R51bbZk6qiX1LZRgU3ODMoN4BSbO4TvjUyEv4MwqAVzkbkW5waJbC+s5a+y16rbbH5zp6nTfPMUVWd0vvAZFBT6dadu5QFxh8FpJUceyPz/uD/6SQUGQsVsHt/sUZoQYLwJvCL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1Y3emdmV01uNTE5a0pGR1g1WGVnNE1KdEFUc2paV1N6SXVZZDh0SFgxMzlE?=
 =?utf-8?B?TFdUTFhnRzBrK3dZcW9FZXA0Z1hqcCt4Q2RKSXY0T1FlamoyMHlocUF5Rkdt?=
 =?utf-8?B?ZHRjNS9PUFhCdW85VHAzZ1RKNDBMbVFqcW9UeTZVeDdXZjZrcUVML2pWRUhR?=
 =?utf-8?B?Y1RhVFlzdUFFVE9wV1RNaStEL3plY2R1TStMbHFDNWdwaEVicG1GSHZUdXE3?=
 =?utf-8?B?ckdpQ1RIK09KaFVwZUcyK3VlV045NzFPYWlwVVZ3NXZjYllUMGViUnMyWVFt?=
 =?utf-8?B?ekljbGY3NWhDbTZ2dFVTcDJFRmFjRzRva0JxNVQ1QjJoYW5RV2ROV0JIeEc0?=
 =?utf-8?B?VEorUDBFQ2p4UVhvbGMxbU1zVVNlQmhwQktqU09tYUsxYk5rZzUyWGUxWkdq?=
 =?utf-8?B?U1pKTmN5M1JBOGpVMEdDZHUwdDNtYjdjalZZR1pobVlxYnExck5HbGJCVFU2?=
 =?utf-8?B?Zlg4ODlldVEzUUttTVNJaDgwMGdWWUkwWHhIeHRhTFJlVVlmN3BoejAwL0Rl?=
 =?utf-8?B?dk5jQ0NKcGVsa2pIbThZb0V3UGl3dU5LSy9pN09LWlA0MFF0MGVIZUc2cVFD?=
 =?utf-8?B?UTRrWkZZRWJJMDJzQnZQbFV2Q2s1M0JsQVcrbFZOcVRDUU5zNENvV1dteXM5?=
 =?utf-8?B?VW9zTXlCRFQ3bjg5dWlnQ01TYVdCRHFhSE0wWHE0MG53UjlXQ3UwZSttUXlx?=
 =?utf-8?B?ZHh1THNMUzhmZVpGNzlTbU5pSzVJR2dVQWtvZGd0Sk94REU0RllwSFVrQkkz?=
 =?utf-8?B?TnV6RU5EWHlxb1pDT0tHd3RKVEZWc3F1SEt6TGM4K1ZWK3h2RDVCYnEwdFZ2?=
 =?utf-8?B?MHlKR1A5Z3d2VE5LNk9mMmtDUE9PUkhIRXY4MHp6QThxdGY3VFdNSUErakQw?=
 =?utf-8?B?Q2VWeityQk1JTFRJc3lvZklTVHdZV25KRzdGVkZ5bUs4clJvY1NQdjJ0Q3V5?=
 =?utf-8?B?SHhwUXRzQU9Gc0p3V3BtRVd2dmxyRFlzbDJnRUo5RFVqaXRuQnkxeXQ0a2gy?=
 =?utf-8?B?cG9LaTBBL1RzTThMZXVGdVJVQTI5UWJMNTg2SVpzWFFzOEQ0WHhuUmEvbVd5?=
 =?utf-8?B?ZXZUa1RyZnBxTk1ORFh0VS9veEJ3L2Fvc0RYQVF3d3cxQjVmVjFLL3VoM08y?=
 =?utf-8?B?bEMyN2RCeHIwRTlPQ0JaR25ndTBobVNlSVZyNHhHT1pkYy9yQlQ1QXM3a0xZ?=
 =?utf-8?B?bUpjUlV0TEI5UTBrbVh3WThkSGRnbDRFOXM1Y3p4Q3F4NzB4MVJoNmZWRXYw?=
 =?utf-8?B?MVR3NGtDUzA0bEJqMnByTy85cUkvZDVBRW1ZMm5qS2dQaGdJZEpJSnhSVE9N?=
 =?utf-8?B?Y0ZTb0o1R2tXdzVoTzA1aDVsaUx2WmNRYVk1NC9NTjhPczVXRE5NZG9lbVpB?=
 =?utf-8?B?VGMzdTdua2x6eDBlOUV1SlJvb2Ewamt0MHk2alcyMElyWUdqZENFcVg0Snh0?=
 =?utf-8?B?WDFtcldzR1NOcVFZanFCV0hpcERGeXhwdHFndkpPc1gwUTd5amNRSGNhdUZS?=
 =?utf-8?B?UzFlOWVFNGIxTzVvd3d6U2VzSXRzS29NWFE5R2pPV201Y1lLSHVsN2NKOTlK?=
 =?utf-8?B?MlNIR200NGplTEVYbTBjMHg4Mkg4c2twMTRNUE1QR0pPaUtEV0FBVWJPcVcz?=
 =?utf-8?B?anM0MFo1NkNEemI3Q0RsMytFR3BraHd4UmphK1ZxSE1LWDlMY0czczd0NVBk?=
 =?utf-8?B?d0lvNFhqWWhSNDlLRGJ2V0JxR2dUZUI2UGxxd0pQYnY0L05UUmlXNldFbGow?=
 =?utf-8?B?Tlg3UjZnYkhwcStQS1JiZTRUYXoyZ1NvM1ltQWFLWUZiaHVtODFVS1cxdzFF?=
 =?utf-8?B?WVQ1V0JXcjFoVzZoZDUvZTNNSDc0ZW1NZy94dGlicnRYNWRpZS83V2lPaEVF?=
 =?utf-8?B?cFg0NEx3NDlPbWhJSlR4UzVpR0dmYkUvWE4ySWYrblAvZk9jMXFKN3NTdFZq?=
 =?utf-8?B?dVg0ckdURzFCb0Q5dHM0d2gvK2Vka2N5R1IwdlgxczAxOURVMVJsOEdiemsv?=
 =?utf-8?B?bkNtcXYwaUNyT1BaTkVmc1g0REJ2cU5lVzFZNWZrRkFJd2lIOHN3ZE5rV2RL?=
 =?utf-8?B?T3IrQWEzRGRXMGFrNW9wRFFxKzZJcnlUNy9PV053RGdXVXQ0TVdzQ09VVlRX?=
 =?utf-8?B?WUcrODZJbHVTM0pBc2U5TjI1SGFnd1M3QkZQNVlPUmhjbUt6d0M4a09odFVB?=
 =?utf-8?B?THdxeWF3ckZKWXEvRitPZ3FRSXc5ZWJ1enRNUTJjZExLRkxWZ1E4N3dkQjFL?=
 =?utf-8?B?b0VuZnh4Z1pKaTN4Vi80d09HeFNuQ1VUSUdaSTgwa1k4UUdMU09RMHNLVXlp?=
 =?utf-8?B?WldaOHV0dWl1ZHhTZ0JzREtZeFloWkg5SG03Ty93Zy83WTVCL3NRRXVQVk1v?=
 =?utf-8?Q?mPX1shftJnfPvYAM=3D?=
X-Exchange-RoutingPolicyChecked:
	CjtKoDNRh7l81TcDfzxorYUprZSfHCOkqq8qLBs6Sv744yFqfb+nSTS/N6IffKQgTzDQxl99ZACj7+8KsdeXv3gWVE+dlXgHUe4h2kIW3pUykXT+OFQu4o50sYPASy5MxOlRw5NqjVWPSewQMHqT3uKf0aIGTQrsOgQxTIuGJyAeXGhr0TcO4hUo1gSRHxKMjvnt81YG+xNKj8vNham9DQk5PzEdld2q5yZzPMHlJ/GH2kgTSWgghee7D3QbJPZfT6bTjF0evyqbmcjt39HTIXfAyKkyGiRJFJXHBVWGck/YZTy0ea+9svddCm4erI/thNnmDRj93AU3tcLJrdCDNA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4818bf52-a454-445b-fe29-08de901047bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:01:13.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sJzEUquTdG6WyuhsHwKC+ZdDBVlFVT0ujotVgeM2JCHZB+JfxDnrxT98kV9UFuA35heDzScFJOTsa+UOPGTvfXqfk0lEI+GBTDTy0UJHQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cd4f5c cx=c_pps
 a=beY4+7vfl+OHeoikwBMclQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=v9AJ2DROe8wa0_ane2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: hyFiuYSnJtcNOvUTT0ATNolPB51Vhb0K
X-Proofpoint-GUID: hyFiuYSnJtcNOvUTT0ATNolPB51Vhb0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MCBTYWx0ZWRfX/CORSIYtR0eU
 COPcEZ/U49zDqNW7K++aJ8KImMpravVyJrOfB7bLCWJp2wYmGcXdUFDXWcT+qo4BVH6rxi2hTd6
 cFCvAkI6ZoCDafLmbpykTGaMf4cDILAEjwlC3SuQ7FGf0qfaDNE/g/0OyLkVfOR7othumyj8nbo
 /k+cFGhLhAJ9smjHxLZ3+n0lrM4btiSJIU7/JaxZrybuMUx+iKXrf++vy99optFg+Qa/mxnuDwr
 1q8dIQ3aSyz3etjj98W5rj4aAdfBG1jUJFJpY5mAIG4L9CmJ3Z0f2cK0HUGxXkSjd+NSxCEH5lN
 DrXC3GYvV0hGYr8vh4OI+azAEW7y8kfOkUrYC2OHMksgmJtLhF1xpaJO5CuM1v0nFfw96YOHAzm
 FBC0bg7H/gey32U9VSQl4I0byK7zd5/QkFSnpN6wg6Un0LTuku/LbLHphPQ0ZB1lDhelQLeO2Kf
 BGCZKaDhHN5gDf68lcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010160
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232827-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9BC137E816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

Crystal, Jan, Florian, thanks for the detailed feedback. I've redone
all testing addressing each point raised. All tests below use HT
disabled (sibling cores offlined), as Jan requested.

Setup:
  - Hardware: Intel Xeon Gold 6338N (Ice Lake, single socket,
    32 cores, HT disabled via sibling cores offlined)
  - Boot: nohz_full=1-16 isolcpus=nohz,domain,managed_irq,1-16
    rcu_nocbs=1-31 kthread_cpus=0 irqaffinity=17-31
    iommu=pt nmi_watchdog=0 intel_pstate=none skew_tick=1
  - eosnoise run with: ./osnoise -c 1-15
  - Duration: 120s per test

Tested kernels (all vanilla, built from upstream sources):
  - 6.18.20-vanilla      (non-RT, PREEMPT_DYNAMIC)
  - 6.18.20-vanilla      (PREEMPT_RT, with and without rwlock revert)
  - 7.0.0-rc6-next-20260331 (PREEMPT_RT, with and without rwlock revert)

I tested 6 configurations to isolate the exact failure mode:

  #  Kernel          Config   Tool            Revert  Result
  -- --------------- -------- --------------- ------- ----------------
  1  6.18.20         non-RT   eosnoise        no      clean (100%)
  2  6.18.20         RT       eosnoise        no      D state (hung)
  3  6.18.20         RT       eosnoise        yes     clean (100%)
  4  6.18.20         RT       kernel osnoise  no      clean (99.999%)
  5  7.0-rc6-next    RT       eosnoise        no      93% avail, 57us
  6  7.0-rc6-next    RT       eosnoise        yes     clean (99.99%)

Key findings:

1. On 6.18.20-rt with spinlock, eosnoise hangs permanently in D state.

   The process blocks in do_epoll_ctl() during perf_buffer__new() setup
   (libbpf's perf_event_open + epoll_ctl loop). strace shows progressive
   degradation as fds are added to the epoll instance:

     CPU  0-13:  epoll_ctl  ~8 us     (normal)
     CPU 14:     epoll_ctl  16 ms     (2000x slower)
     CPU 15:     epoll_ctl  80 ms     (10000x slower)
     CPU 16:     epoll_ctl  80 ms
     CPU 17:     epoll_ctl  20 ms
     CPU 18:     epoll_ctl  -- hung, never returns --

   Kernel stack of the hung process (3+ minutes in D state):

     [<0>] do_epoll_ctl+0xa57/0xf20
     [<0>] __x64_sys_epoll_ctl+0x5d/0xa0
     [<0>] do_syscall_64+0x7c/0xe30
     [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

2. On 7.0-rc6-next-rt with spinlock, eosnoise runs but with severe
   noise. The difference from 6.18 is likely additional fixes in
   linux-next that prevent the complete deadlock but not the contention.

3. Kernel osnoise tracer (test #4) shows zero noise on the same
   6.18.20-rt+spinlock kernel where eosnoise hangs. This confirms the
   issue is specifically in the epoll rt_mutex path, not in osnoise
   measurement methodology.

   Kernel osnoise output (6.18.20-rt, spinlock, no revert):
     99.999% availability, 1-4 ns max noise, RES=6 total in 120s

4. Non-RT kernel (test #1) with the same spinlock change shows zero
   noise. This confirms the issue is the spinlock-to-rt_mutex conversion
   on PREEMPT_RT, not the spinlock change itself.

IRQ deltas on isolated CPU1 (120s):

                    6.18.20-rt   6.18.20-rt   6.18.20      6.18.20-rt
                    spinlock     rwlock(rev)  non-RT       kernel osnoise
  RES (IPI):        (D state)    3            1            6
  LOC (timer):      (D state)    3,325        1,185        245
  IWI (irq work):   (D state)    565,988      1,433        121

                    7.0-rc6-rt   7.0-rc6-rt
                    spinlock     rwlock(rev)
  RES (IPI):        330,000+     2
  LOC (timer):      120,585      120,585
  IWI (irq work):   585,785      585,785

The mechanism, refined:

Crystal was right that this is specific to the BPF perf_event_output +
epoll pattern, not any arbitrary epoll user. I verified this: a plain
perf_event_open + epoll_ctl program without BPF does not trigger the
issue.

What triggers it is libbpf's perf_buffer__new(), which creates one
PERF_COUNT_SW_BPF_OUTPUT perf_event per CPU, mmaps the ring buffer,
and adds all fds to a single epoll instance. When BPF programs are
attached to high-frequency tracepoints (irq_handler_entry/exit,
softirq_entry/exit, sched_switch), every interrupt on every CPU calls
bpf_perf_event_output() which invokes ep_poll_callback() under
ep->lock.

On PREEMPT_RT, ep->lock is an rt_mutex. With 15+ CPUs generating
callbacks simultaneously into the same epoll instance, the rt_mutex
PI mechanism creates unbounded contention. On 6.18 this results in
a permanent D state hang. On 7.0 it results in ~330,000 reschedule
IPIs hitting isolated cores over 120 seconds (~2,750/s per core).

With rwlock, ep_poll_callback() uses read_lock which allows concurrent
readers without cross-CPU contention — the callbacks execute in
parallel without generating IPIs.

This pattern (BPF tracepoint programs + perf ring buffer + epoll) is
the standard architecture used by BCC tools (opensnoop, execsnoop,
biolatency, tcpconnect, etc.), bpftrace, and any libbpf-based
observability tool. A permanent D state hang when running such tools
on PREEMPT_RT is a significant regression.

I'm not proposing a specific fix -- the previous suggestions
(raw_spinlock trylock, lockless path) were rightly rejected. But the
regression exists and needs to be addressed. The ep->lock contention
under high-frequency BPF callbacks on PREEMPT_RT is a new problem
that the rwlock->spinlock conversion introduced.

Separate question: could eosnoise itself be improved to avoid this
contention? For example, using one epoll instance per CPU instead of
a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
instead of the per-cpu perf buffer which requires epoll. If the
consensus is that the kernel side is working as intended and the tool
should adapt, I'd like to understand what the recommended pattern is
for BPF observability tools on PREEMPT_RT.

Ionut

