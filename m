Return-Path: <stable+bounces-104518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3409F4F82
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF011882841
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B71F4705;
	Tue, 17 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="SPzsqT0i"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5091F4E23
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449580; cv=fail; b=YzjNYoJ01BJWBc1S/jQSk7Bgj/yP5E4oWIVyhcS4zh/rP4Dc4XiJOJcncyq++tFJUgDJskQy1M1Cozy3TTpOhtCMgWJ+LnQqO5VqkwFtbM59RHPSM8Ud43AkLVH5kwHbcFfM/LE1VdYCofRNXIBe3t8u1XIHRwFcTqZJAH+dgEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449580; c=relaxed/simple;
	bh=Zyajzmh7jaHcxfea+DL00811t7Dvk0Jm/0xD29Zy7Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eF1mk0yxuQ3vAI67cKJTAXqHPa8XpXPbsrcrnFNtRkTTl2y7zBOJ0Ibef7EK/9+OiPSrGZGf5fWmHKktoq+jOXxOYjwusrHi8wGfVc7atVVpaZJiYHEQ6B6mJtu26/wBMhoCn48gEah15ysIS3nrmh1RfIQxlY+fV/We4+30rRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=SPzsqT0i; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQi6HoETYnGhNrhnnLkThvpw86ESDeQ0E5xwX7XgBfitD8HXL8fi2t2MaQMGEcmhD/IHCDI8E31sjfPLSL6N6uIoVb70fcRQEmQo5/gMmCZAtxZxqDKtxbmYOUfexoORhozVndTXra82T6Ry8LQ4zsZ5xRjUyFeu4W8zsmGPReAd9xMHECysVA8sHbm2rV0gKeJCqGplUugDnaBJhR1tKbrIikNQXRp6OJjw3eimmlNXt9AXfURX+z5dczv/ORrQEj4/pRiMSnRjZTtzJ1RZXVkaU+X4Hltzx/FV8RyVt7ywLF6mWc9yHptmZlNpPapOuJvoZliRN5/8B0TqQ/8sBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8feYMDKGH19CcdjtRNFGyUWkKINuOESik3HrNHQt2w=;
 b=aRXqfXC1P8D59T8aavuJIbzawIONVEDQDz2jVFld+zBNwSANShl/Lne+envYGVe6pV1U1eKKuYwX9S4hNxdRwW0IXjFRI6wbPzO+t/x5AjXl7pV4wTjTss1Rd5fLzqOebKFxyFNy8S9Z9tO073vEaiyMmZUo/wgVKHhK0bbnb/i57aRUKwE6WA/FlWksE4Pkir9X5QcJ6rhHDnkM4eHPcJiurhe7uTshTju9dGJLMcIMzIaV7eGZrQa8J2XtaCh2F2Ojk52HoWhcYn0O7YyGkDbKhu8sLe08RVcXKzEICJgA8zKw1C/yCBlK9g3sMO8/NtT17iRb6aymI2VRSpD6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8feYMDKGH19CcdjtRNFGyUWkKINuOESik3HrNHQt2w=;
 b=SPzsqT0ikpLVvNynVrLWgX8Z/k7C1Qfk9RBOMi0zUuY6E3G1ZT2IXM/Nz38KWJ96eEYXKARTB7TI62oEjR7sjNniFTDIPN9yGDk0yxVKOZrWdd23uoSZcN+eFA+IlutHOnorfKVvqtiAvHlJRxT+T7hYgnFua4FEtaIYcFva55nilW4km5GfniIt4pHwNWIpJMPJ9zk1fmAU/rNoik07NGBTyc0K3kMYrkZN62/Htc6HnXNcJLjhXb28pvKS6jsmoWMXIfzThi9BzVeIYSRnuSMvL77Pex0MfcPqZk1XmHGSjTGPJUisIq4/Niw/FLvGLrOeR0i5zPUxu1IuNJeRtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by DB9PR07MB7850.eurprd07.prod.outlook.com (2603:10a6:10:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 15:32:55 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:32:55 +0000
Date: Tue, 17 Dec 2024 16:32:55 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD: Flush
 patch buffer mapping after application")
Message-ID: <Z2GZp14ZFOadAskq@antipodes>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: PR1PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::15) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|DB9PR07MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd9a05c-13e3-4f3c-5c32-08dd1eb013c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVta2QvTEJ4S3VLazlPNnprZXZFODMxbGlXNU9RbjR1bHg2b2xyMWlPRmh6?=
 =?utf-8?B?S2hveEtMS1JpSjBXTWxsQy8wbDZnZkVFUXlsOTU4NHo2OEptTzVaL01PbTZF?=
 =?utf-8?B?YUdtWWZQVis4NmN6RUY1MGlWM2RwZ2xNRWo0MkxUa1ZyZEFmSFljOWc2UHA4?=
 =?utf-8?B?NnA2NGtpdXZoV1k5V2VITit5OXdNN2kxeG8zZ0lrL0lxbW90SVlmZjNmUUho?=
 =?utf-8?B?UmswalFDZDJJQ0gxS25kaFdBWUd0dStDd1F5THROVlNyU0lIMjRCUnRsQkRX?=
 =?utf-8?B?bzlWNCs5VEo5a2JFMm5YTXZ3cjFWVy9vQkhNUmQ2TG5pa3c2dDB1R0VnVFNG?=
 =?utf-8?B?K2h4MkhzKy9CVUJqa2VXdEwwRlJ0TGtMQS9YNWUxalR6NHJwc3M0R09iSnNo?=
 =?utf-8?B?ZmY2QkFudjdnM1F2R2VuTExsdDdvblcxYm1MelhybkFxR051RkxNSzNYREJE?=
 =?utf-8?B?NEVNMDFOUm1vVllmOFBNN29takdCNWF1blZGMjBoN0tOMlZzQWRoSUVVc3pQ?=
 =?utf-8?B?d0RyaFVPaURaUmVvRGpDZTBObzJTekluWlU4bENQaC9XVmd3cEVKNFk1VDhW?=
 =?utf-8?B?Y0IybndaM2hJcUxBQWdWaTVGVnc5YW1oQ1QrL0N2aHJNTm55R1lRLzNzeVhN?=
 =?utf-8?B?Tk5yZjFqY2oyRmhldE9HRVpET0pqNzF5Z1IxZE1LeUZzRXBnUC84Y0tGQVAx?=
 =?utf-8?B?WG03QmpKUXZMWm0rMHRQNko1RlRId2hSQ0R3MU9NdTNZWEhPd2VPUm5hZjJ5?=
 =?utf-8?B?dER6UGtJWm9uanhOeHgxaFhOcDh0L2I3MmdGUllVKzZrNjZ5QkRFUkVGMDJ6?=
 =?utf-8?B?Ly9wdS82bCtyL0NreHlQZTBrV0x4Q0FhQlRKLzQ5L2Vyam9yRjFRQ3RnNGtm?=
 =?utf-8?B?RUpTS29FeUN5TUNldFg3ZGhnWEJJVm90Um12ZTJnc1NNNVdnUERsTWR2RkZB?=
 =?utf-8?B?bXNMc3g2NmdhM3BDZ2o1ZCtGOE5qNzUwR2NMSHI0bHVtYmVHMzgrc01PbU55?=
 =?utf-8?B?SnVnRTI2VEdKcllvYTE0QXYwR3VXZkxVMytKTURRWnVPS0lIMkRaanJ5U2ti?=
 =?utf-8?B?MWxTd0tJVDQ4dTM5c2FrNVFkZWw4b0tCOXVrRkhFSTliZitjRlZ6V283WHZs?=
 =?utf-8?B?Q3kyRmpHUERMd1JKTEVIaTd6dFkyc1Fhd2orYXJqcEZyQUI1RGFFb0tZd2pu?=
 =?utf-8?B?OUgwcFpzSnpTYURUdVZzaXQ3ZXJ5M3dFNXVaeTZMTXNoWmdmc3NaNUJPZ2pP?=
 =?utf-8?B?Y2p6eE9JdlFpbkg3ZHBaL1l6dDhIV0wrZzZObUpMaFZucFI5SDFWZmVhQTh5?=
 =?utf-8?B?ejEyby9yZlowc0F0anlVNVNCRlZxVDJjZTQ5a054YnEzc21UelFZbXB2UnI5?=
 =?utf-8?B?NlBBUWZYOHpsQUt1TE5hSmROSHI3UGZzb3hjL2lwaWlQTThkcHpnMjVIcDAr?=
 =?utf-8?B?SW5TcDRSWFdyejQwYmpkVEZEaVNXa1liQU00OHBUTG1mM1IyQ1NVc2FiS2ti?=
 =?utf-8?B?cUdkb0Q3aU9GNzRyTml0U0t2TDIrdjQzNmFYTHVocndtU0I3K2VQalkrQ3BE?=
 =?utf-8?B?M0ZqQ1JKV1kySnpzbWVwYldJcjNiVVVDS3hkRzFOYjlramMvWHFXM0taT0FU?=
 =?utf-8?B?R1E2cXVWWGV1ZmFVb3FOa0NGNGVxQWx6TkFSSVdlZDByb3ZtTWJVZVkzR05N?=
 =?utf-8?B?NFNhVzZCUG56aHJiME1nSHd5Z29DbkJ3RXlzeThORGVlMTRCZTN3MU5BR0ZV?=
 =?utf-8?B?djdteVBKUXFrajhXMnRhOFA0UWZtYUFSUVlMRDNFL0o3OEZabzZUNGZNWWVC?=
 =?utf-8?B?dDhicUJKQ1BvZ2RDdmZUdFp3WW5QWXBySCtJN0N6OEVkc2ZJS2FLMHRiTXBM?=
 =?utf-8?Q?Ncs7hKxR6c1dy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OURXRVFlbWZsQUhicERia2l6VHJhUGFOR0xoSWp3QTJGT0lZSGxydmJPcEZH?=
 =?utf-8?B?dlo1L3dnNU9JTUpKUXBKTEVZNHh3MTNsMitrK1hzS2lkbVg0T1BVZDg2dWdU?=
 =?utf-8?B?T0dQd25adzBrSW5lT1I0RUw5TUZadmFZbXdjMW80U3V6Y0QrNHJGaUFoNWdG?=
 =?utf-8?B?ZW4vRVRXcU9BNkExMzQ5dnRXMDFYNklqYnNUcmN3V2R2eEV5WkthRytjNnRQ?=
 =?utf-8?B?bmp2RkFHeFFad0xqdVpJTXVsQ210Ujd3NTl0UXB1YjZvRUpuMFBCU1hJVGZR?=
 =?utf-8?B?M1JIdVJ3VWlIM0VHNjI5cWlRNkdQVVVYYllJZGtmQjNFdTZORml2ZzU0QmJ4?=
 =?utf-8?B?eWhKOUp4a3RhRmJqR2ltRFhyMDI2Tzc0emp2c0ZLRHdYM2VsVnBDUlRMbDBu?=
 =?utf-8?B?WmYzV25RTGtGaFo0YmxXczRPdGRVbUM2eW5OQUNjL1hYVmVyUmFjMVFnMjBk?=
 =?utf-8?B?ZWt1MzFJSjQrS2xPYnNXTjFCSmU2NnZPSFQ0b0twTWZRQW9PcDF0OFdRTWVE?=
 =?utf-8?B?TURzQWJvMVE3VC9pYk5KMVNVdjltQlFYTzlZNWoyckRKR2Vpa0lkV256OFhv?=
 =?utf-8?B?ZWJmMVZ1SlB5cnFrUWE4MERvUzBhbzQ2cXZVMVJuL2d6cHNKRDVONE02UVpC?=
 =?utf-8?B?TWlnVHUwTzlqZWVCS3hPRnJEVDhGUUJ6ZTRUa2Yya3haL2czMU5HZWRSOGcx?=
 =?utf-8?B?UWE0aTcwa2ZybU5MQ3YrMk55UmtXTno2K214dFJ2ZzViRTZJb0Z5cHlTZ1Iw?=
 =?utf-8?B?enFlYTBoTE5hMkdPS3MxWUU3eTBCU2t6blNTUml2aXQ0WUdnZzd6NTV4OS92?=
 =?utf-8?B?Mld2T0tqL3dGNkVzQnUyTXpEK0pRL0NVR2hUQ3dhaUhzYVl4QUFJVVpiVHhQ?=
 =?utf-8?B?UjBxTHl1blJ4a0dnQmZhVm15eWhLRmZWUU02YVc5bDJlLytRUmZCaEprSEkv?=
 =?utf-8?B?RGpxeEw1Rlc0TGxpNnhFU1pHT0hnZmlKZGRnQlhzRmM5eDFtWFdselRwUm53?=
 =?utf-8?B?M3hHZnA4NTVFQXhRdjlOaDBKWEw3Q1ozUzRvV0UwTm5LdlNxd3dlcEYyWmhS?=
 =?utf-8?B?cjRsRGhhR000Q2dydmZ1NHRNY2NMdkRMbEhlamtiN05DUHVhdEx2c05Db2d4?=
 =?utf-8?B?QkdROEFldWVWaDlvM3k1UzJJc2FEWkgyWkZQQ002cVg2U1FKY294OTFpWERB?=
 =?utf-8?B?aWRwYVVCRDlnOG5SdHdJQXRncndYQ0lSSGhNUlZsSUJjKzAvZzRUNlVvTE41?=
 =?utf-8?B?NXI4dUxaZGlZUitQeEVEVi9nemJ1Z2xDT0dqRmM1bHFYN3VEb29oQmgrYnRa?=
 =?utf-8?B?dzlFYjVQRHpRT1pRQ3VQSGx5dGJxMzBwckFZVjR2SU9oS1RlcDhPVC91ZlE3?=
 =?utf-8?B?YjloVy95L095MFMwVEFkVjArR1h2UkVOdzd2aW1UQkI0Q2l3STF2ZW5STjd3?=
 =?utf-8?B?SGMvenNPRGMrcmUyTGxGU0R3WE9DKzhZYUR6ZHBBQks5TWpUekdCelBJYmsz?=
 =?utf-8?B?S2ZhSWRFNE44Sy9MV25tdUhJQkRKMTJ3QzBGRStHWVE4VWtmNTlnbGMwMlZK?=
 =?utf-8?B?TEM1NTJSZytEUXJMRkpySWFXeWF2T3JOOS85V3M5Y2c1YnRKRFAxSGpWM0JL?=
 =?utf-8?B?YUQ0K2RERFErbm14UG5lVjl5RzhWMWZMRXQ2Unc4M2hZRU9EYi9sWm1hQzM3?=
 =?utf-8?B?azM5bVFrTFRYekVWS2xpWmZKekhSdytBRUVEZm4ybE8xMmUxLzBubWJnVDVM?=
 =?utf-8?B?ZEFxbXJUQWU4SElaOXNlaXkwTmI2YllVTFh2T216YUsxS3gxZEE4bkFaTkJJ?=
 =?utf-8?B?NDRRSzk4NklLdkFvZ2tVTzl4VkQzN21KVTZyMmJnUXFONnFxLy84SnhtOHJl?=
 =?utf-8?B?UUlmMG1JcU56VWs3RDBFTGZwKzdxNURYMnIremJlLzhIb3BYMnhoeHRieHNs?=
 =?utf-8?B?Sml0cFFEMGNpa2ZCWW92RGtpUi9FOVYwb21ibE1IUHZtOXlOUzB4d0tQREd6?=
 =?utf-8?B?NkVGMWZZU29rdlZnNzR4UExpdW1udHF1eEpFZlNQaldYUjl6ZGNJZ2w3b3RR?=
 =?utf-8?B?ZEJGVm1XTXU4NnBhbXVOekI4RmhzQS9WcWxwbEhRck8xdTNOMnh6ZS9iTFg3?=
 =?utf-8?B?QXU1TUY4RWdHMDMzVStRTFBKQWVmYVZNTE90Sk1UdUtKd1FiQnRhR0M2T1Fi?=
 =?utf-8?Q?mc0GOTZ4wLvbiTilp4G8K5A=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd9a05c-13e3-4f3c-5c32-08dd1eb013c9
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:32:55.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZbUPAYZ5RwSpymUeoZZUq8dYdUrnc/4z7mR7oog02DgQzW2ONr3PqWavBvN0S6m+VHaPoeEeJqEqDBZVh+mlW4i02FZwwdB5iDji93/RTEWfdx+ZYbhe237INFw7paE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7850

Hello,

Below commit was ported to 6.12, but I would like to request porting to the 6.6
longterm branch we are currently using:

    commit c809b0d0e52d01c30066367b2952c4c4186b1047
    Author: Borislav Petkov (AMD) <bp@alien8.de>
    Date:   2024-11-19 12:21:33 +0100

        x86/microcode/AMD: Flush patch buffer mapping after application
        [...]


The patch itself is small, but the consequence of not patching is large on
affected systems (tens of seconds to minutes, of boot delay). See original
discussion [1] for details.

The patch in master relies on a variable 'bsp_cpuid_1_eax' introduced in commit
94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the
patch ID"), but porting that entire commit seems excessive, especially because
there are several 'Fixes' commits for that one (e.g. 5343558a868e, d1744a4c975b,
1d81d85d1a19).

I think the simplest prerequisite change is (for Borislav Petkov to confirm):

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index bbd1dc38ea03..555fa76bd1f3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -96,6 +97,8 @@ struct cont_desc {
 
 static u32 ucode_new_rev;
 
+static u32 bsp_cpuid_1_eax __ro_after_init;
+
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -551,6 +566,7 @@ static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
 
 void load_ucode_amd_early(unsigned int cpuid_1_eax)
 {
+	bsp_cpuid_1_eax = cpuid_1_eax;
 	return apply_ucode_from_containers(cpuid_1_eax);
 }
 


Thanks,
Thomas

[1] https://lore.kernel.org/lkml/ZyulbYuvrkshfsd2@antipodes/T/

