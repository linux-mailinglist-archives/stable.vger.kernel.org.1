Return-Path: <stable+bounces-180958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601EAB916E6
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451D618957DF
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53D2D9EED;
	Mon, 22 Sep 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ml0sE6zx"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244D30DD37
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548280; cv=fail; b=rR6aF+HB0C1leCP3YTGzmwuAgMxbwg5Nh4om0UGbNbB5FIePN0/pNcLdNANJ5SOmYjgx5fnGRgq6xEEuFd5pVIq+l1M2Ud0CA5qr0clDkVa2ceJdyihqd+bT2cSt1+6qFq3PmvV0mHOeF5StNqWkzKxmrEaoh4BGiyCEPHNg8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548280; c=relaxed/simple;
	bh=Fq05uUyUMdCzzTp3fjv9h3pxAM2DCY7D2fN31LxiSP0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OS9YQy0awq9hbR4AAjJfgQOV4eDuPesJri4Dl3bb/usmWMW/D62lCPoiiLb71xTDuNBqW+tLz3IVJdd1cx/nlqLgdzvDGdHO1DoOAjUuZF9ZbWixD3RlIw/US399ig1YCDjPd3T0S5coBPVYnvbgLFzxOvJdBFwFiPLnS8WwtKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ml0sE6zx; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J86L+Gpej36G8SRqWrZg8gRy7ho0AhgQfbO19DrI+Z0aRjPbxnoW3yU9DGvNNtTGTAyuSwRqD9j/dL6UjVp/R1Cs5ylnmpR8r9/AY6ENsel+ELAW2Z/LB+mqHfL51fHqqkg/HBQjbXfrS0erpPm1Cpe8JBxvjVp+Hz0anwzvjlAp1h95sVVkh0UOCYMhvsw9FN+pbflIPmqd4G8S8MKU4S2f/mCe3VrNTJY2hwZK1UdweD9tBuQ96MTc1LCbXpf+TSdJomPuPNJ7Jc2XGegAqfs9+6/60uUUlCJ1K8wd8YAwUAcQ5lY5XH72ywQpKbFYFwLIci9vtr1YWGo/NnaqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g93iLRLXVKbyXX3SDneRjBsjglJkIGxKeYGMX2A/fw4=;
 b=pXwR67KDq0eEs9RYIv1bo4+NdNMWqPOHuXdRKWO0GOlSZLaK1WlxsoSjMFa/8E5AVdHKWPjdVEZ56zsAsYXo7Uoe+67rmmH0yPL4gywg7mWwVhR53csxsdxTWFODlyDrgS7sjDLYeioEsEly/e9ZhRY6pQH+TcF+RHll9JE71cpYo6PR2/OEK/7hgjkiHbC0MKlhS4Xwmv8FEFn7Z3BuA8HZAhuFdnCDDMv8aSyLXbF3HMlDYe8/UQ/zP6e3J5ssUNSy3gdHglEWNOlinvphPZaQwObMj+DITW8HwxfLZ2sKEmkB6qWYprc2x5p4kHeOUzZhU/jwHhejcna+TMTDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g93iLRLXVKbyXX3SDneRjBsjglJkIGxKeYGMX2A/fw4=;
 b=Ml0sE6zxGx3k8zqwX0WcS9SE7rfTRrZXt9fVNcFIYMBh+zj9evMQmv9RmTZOQ3uvbg/z4+KYdm23tfckfdj+I3uGzMPhplPqhQ5Ud9RThIqb9rgEY/8mDp6W0ps7/kAfX7QRDDylckFbePR7nlAeEoS+6MFOQ2K2CIYShDpbXko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:37:55 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:37:55 +0000
Message-ID: <371ed3b2-8c7c-40bb-4e23-6a246a715168@amd.com>
Date: Mon, 22 Sep 2025 08:37:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Patch "x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org, bp@alien8.de, sashal@kernel.org,
 stable@kernel.org, stable@vger.kernel.org
References: <2025092205-quaking-approve-4cd6@gregkh>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <2025092205-quaking-approve-4cd6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:20::11) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f55e2ed-c4eb-4e60-7af6-08ddf9dd3b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFB5ZlZkWUZNNkxFUDk4R0Z3Uk5qSmNQTGVCMXpCQ0ZqNDMwTlBneHp6Qy9x?=
 =?utf-8?B?dGk2OUMzQlVNVG53S0tSMXFGL0k0MkUxWldOQTNWTUxsZlVtUWltRS9yZUxv?=
 =?utf-8?B?c0lKUSs5VkFsR25qZGlOalNJR01neFkrM3FHZkEyeUREVFB3OFU5M0E5Q1pI?=
 =?utf-8?B?NGh4dks2M2hscGRHMGVOdXVOMzFLZzJaTm9JdnFyWWNoMFR2WDNTUHdTQVpw?=
 =?utf-8?B?Lyt6a21MV0hueGl2SExmMGdHc2xNMFJBOStyVjl2ZFpJZ2R1TTJpcU1uMXpI?=
 =?utf-8?B?S1Y4ZFo0QnF6NWhsVU5LYnpNQXlvNVFkQUJtYWpYaEtkYzNwZE5UeXlXQ3VG?=
 =?utf-8?B?RlUxVkVVdmNBK3JqZ2w0NE1zS2xOS1MxeWZxV0hOMHpFQTRIRnJuYlJma1d0?=
 =?utf-8?B?MGJvbDZxSDFmZ1dEeG9GTVRQUVVvZ0VtZzhyY0xFd2FpbHhnd28wblJ5a2V5?=
 =?utf-8?B?SHpjYlphT2FDMmplZFVVeWdyY01mQnByeDljTzRGQ090OVZybldpdGZDNEo4?=
 =?utf-8?B?eUVMY1hNTFlMcUZRazNobEhja2VvSmUrZWFkdXk3TnR4dWZwMEtYMm1sVlJN?=
 =?utf-8?B?TnZndmVjby93VzBJRkZYTlpLSit0NWZ2ZlNadEdBZ0dpTHJTcVB5RG5YT3JX?=
 =?utf-8?B?NUppcklKNU5aY3JGS2NNclNoOEluNTE0SEx0OUJCU2dXMWxyTWdKbTZrRmZY?=
 =?utf-8?B?ajArNGEyQUNmT0hoSU1HUVBFOUlYdU1qeTRzVWs2amthS0d3bEpIYm9qME5V?=
 =?utf-8?B?QTc2NVU5MW4zcFlMd1BZRHdmTCt4VDNnNk5UK2hvZ2g0SjlzOVZxOUI1dENZ?=
 =?utf-8?B?MGh3QTJrRTRXL1hKMk5seW1Bd2w2WEh6V2c5RFpTeXc5R3orTkU5V0I0dUQ3?=
 =?utf-8?B?MHJsU0NybUxKZWcraXdGVzdQd3ZYVkhnNGRuZHlOMHJQYVJWOE5ReDhlTWVn?=
 =?utf-8?B?N3U2WG4zcXFVS3JBWVNaVEtYUDFFbVFjYXk1WVorNm5nV0RlVnVHbGQ4Wi9F?=
 =?utf-8?B?UlZLOVpWaExkNksrd3RsMWszNWg5bGpVT3lQejB0WSt4dTlVYVVWZVNZR3pJ?=
 =?utf-8?B?d2tSWXh5NGhxTldycWdtSlo3VjZ2djFIcEdvZEtRS3UwbFRsTmU0eVZsQ1dN?=
 =?utf-8?B?K3pVWTU4VHIvMEIxUzRTZ1lLT1lxVk5VZ2FHNU5aOHQ5a1NoeHFpSzU5ODgw?=
 =?utf-8?B?eHU3K0wrRkIwNGJoeXdZZ01MOHpGQ0dnTzBmZ2RtcXJ1OWttWklzRU1aazNY?=
 =?utf-8?B?ZG0yYWZlTWxuZzFtQnZnZkY5WVh5YlZPREVtcXNjek5hbVJxZkcrWFd4TGNM?=
 =?utf-8?B?Y1dVbVU5eG14KytiUEp5RHNVcytZZzlLVUJ0Ui9SQVB2eTRYWGRqTW9Fb016?=
 =?utf-8?B?OHJ6T2xtc2VOaTJWM2RtNXVPa0JmdGVPQk1tZjl4cVZRQjJiSjdRUjlCQkZN?=
 =?utf-8?B?Mk0ydnIrR1N1VHRGVkFBS0twUktodFhYQTFTbkxjVVNMd3RmUWdiVXBzQzZH?=
 =?utf-8?B?MThmNXVocStGNjZSamM2MVo0eDZMcmt2a3hMbzRISlhUeFZsYTRYVldjMTE2?=
 =?utf-8?B?Mk52bjRGRUFMU3Z0OTB5MnZqazdTYWpIdDlXdStmb1pQOVB3YmxqbG5hY1dE?=
 =?utf-8?B?MWNTL25oN2l6b1o4Mm5TWUwvR3I5eWdlLzZPQWZrUjd5WFhCeFBkMlBNL3R1?=
 =?utf-8?B?WFhESm1WWTNYWmZ2Y0l4NSs5dlhhb1VEbmRtaUFVMGRlNGJQSDlKa0R1Y1pz?=
 =?utf-8?B?NGhRUmJTWFZRMnpOT0hvVFBvRGZsbGx2cWU3dkUvbFZsV0hvTEFPUWJOaHNv?=
 =?utf-8?B?eDBJNVN2TDZZMFV3bWtMK2RHeHlYRnZ0L2tFUzdTako0MGhsRG5Hcm8venAz?=
 =?utf-8?Q?sRKdrH8a5+Faa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FqVHZrbjhSZWxyWmxwUDBTOEg2ZGlyYnhIaS9iWkRQZmJUdm5sclBpRFdh?=
 =?utf-8?B?akE0WWg0eCt5RTQwMzNaYSt4NmpWYzY2QzB2NDJZQ1FQRkJaOFFIUlBUc0Ju?=
 =?utf-8?B?SDhFV0creWZLNExIdEVBUitJTyszR1k1bTJWdTl1eEVBQTlwUWVPNVFaNi9X?=
 =?utf-8?B?T2lOYk0yS3ErYnBrbXEzOHV2STJSSDVWWW5OL3ovcWpSeVJLZFBuQnJXTVcw?=
 =?utf-8?B?SDcrcm1VdjJYMForQ211K3V6QmtUNjRkTnJRcTVycVBMUUJ0WlFzTCt5bi9v?=
 =?utf-8?B?Nkp1SXpnT0J2dzQzSWc1TjhmNk5EMnRCQWQ4eGx1dXdGc1N0SzYxUURRL0tm?=
 =?utf-8?B?UU5aSXBYQ0pnUWVjRkordnlCVERsWDZSZUdIN0JzYklyVmRXNG5iM2tUNDlo?=
 =?utf-8?B?aC9SSWhrOEpFc29CZUR2bjc2Vnpud0pneFRYOFVwc0ZCRkV1ZVhaNWpnay96?=
 =?utf-8?B?SjY4MkZPcmdtUFpIZWxLQ2tFRXJ6VjMxa2U2NWFpZG02K2xrRG1mV1BOaHJM?=
 =?utf-8?B?azhaZ0UzRDRTZlZad2Q1Z1ZudTRuQVpWLzRqaWNYbjJVd1BXYWtxYkVIZmFG?=
 =?utf-8?B?NnZoQ0lmUUdkdHdYYmVwSU9kVDE2aTFwUy8zYmV3SkluZzhzdkhrUDBMbndP?=
 =?utf-8?B?K0lXbmFQRk8zL1BDOFR3Sy9WT0sraDdJYWMyNU5MWkxpckVRdlRVK0xhMzJL?=
 =?utf-8?B?OFpqWHdRWk5LT2ZiMWNDTE96VFdiNkJuUUplMU5TWFpNdkFWQW9NZmZCWndl?=
 =?utf-8?B?SGNGTUlGUGwwZ1NqQXZCWWRROWN3UW1LUXZsaGFYM053TzhvbThvcnpXR0JX?=
 =?utf-8?B?aFloZmZ3Q0RtTDBsRjNDbVU2TkpPVkxOdFdpN1c0MVFqdHZpYlk4S2FINDBj?=
 =?utf-8?B?NFFRR0duSTNDem5RQ0N4Wm9vdkwrYXBBSkJYamlXM0lOZ2lZZlN5bXcwTThQ?=
 =?utf-8?B?MkNrSjRaeFVDUG9SYVpiSzRsbmlGV1JmNlQ0ZEwxZjBZYUx3TWQ1bTBMQ1li?=
 =?utf-8?B?SzMydTJBVDNNL2c0QnhtdzY4RXlrTzNaUDNVVjVTZXJDR2JDd3JHK3p5SmV2?=
 =?utf-8?B?T0VEMDNMRk1GRXBnbUs1QlhtZE95cElPS0JVVzhQOWlPSVlXV1V3Y0ZEd3ZS?=
 =?utf-8?B?TDJwdEJOSWEzN0p6ZFJjRDNSYVBWWFhsY1N0VUUyWkJsUmkzbEwxZTlMa0dK?=
 =?utf-8?B?VVVRODBTRlFoTkR6V0Y0RllzRWgxRE1OdE9SK3pYbUV6WXFtZXR0VkM4S0RO?=
 =?utf-8?B?MEI5T2tRUFBhN1ZIUjQvWVRYZ3hNZHBSc3IzVGJsVHVHZG41U1hpZGd2SFRx?=
 =?utf-8?B?dzE2SDJOZ1JvOEFiTmM1TS9XbXVaYzlKd2o0czdscEdmZjZZdDB2eGdDaUNL?=
 =?utf-8?B?eU5uWU43bnN1elppSWloTUJlRlFDMldNN2lta1FxTFZIUi9uaUdydFVuWWpX?=
 =?utf-8?B?R2E0NFZadklHekFJejVlUUpxUEppV281cEhKeEhKZ0FUYWVIL1I5U2t0ZVdk?=
 =?utf-8?B?WU5YZy9aVmdWaGpzajBaZFBoNlZxNG45SnVRbkFlcUlucTZHV0U2eFBlWFFl?=
 =?utf-8?B?V0M4dVhBSzI1OFAzeWRtVFN0MWU0ZHRNZGxlanMxQVpOQzR2cTgrWU12eG5G?=
 =?utf-8?B?bHM5RjZpb1JnOWZJODFvMmxpY0pLU0MwSnVGOEdTSW1RSjkxOFBrRVFWc25s?=
 =?utf-8?B?aUE2U1Y2ZVEzOHRiSjBiVkUrd1ZJcG82U2dRRHgvMlVmc2ttdzR6REhrUm1l?=
 =?utf-8?B?ZDRRL3VSQnRPRTUrYnZMZkEzUURTQzdRSWpPZ2Z5cnppamE4QktzaUhwWTNS?=
 =?utf-8?B?MStzSlpzZSsyQThhbHIzZVJNZFZ6c0RkRnNTTXAzeFBHNTdhRW1lNzdEYlJ1?=
 =?utf-8?B?OXJnSXU0UkdxOTVTeTl0YlFvYXB6enZCQThzZ3FoMk1rbndrTk5VeklUbUUx?=
 =?utf-8?B?ZlJ2U3RFTHFzSjd1ZEY3dlpmSFAvcWZLZjVJQVMrRktmY0M5b2pycG9jZE9s?=
 =?utf-8?B?cUJ1d3RvUVcra1lLRDArZm9Kb01POGJya0dTQkpFSEZ5RWJKSmdmeDRNd0dF?=
 =?utf-8?B?K3FEYk4reXo4dVpPS2Y2Z0kzUThzTjVyZ1FoUytUTW1QUzMxalIrUlREbFpZ?=
 =?utf-8?Q?0QgvC7909w7MrUGKXs6v7ww3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55e2ed-c4eb-4e60-7af6-08ddf9dd3b15
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:37:55.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L8erJG3D3oAJ/kV/GmgbjKt+4Yc/kaZZfoxUOwMhvSJJPYSNa/ts4PJhwBXSxzfhhz3pm0QTZdH0zPKTtq5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

On 9/22/25 00:52, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-sev-guard-sev_evict_cache-with-config_amd_mem_encrypt.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Maybe I didn't use the tag correctly, but I put 6.16.x on the stable tag
to indicate that the patch only applied to 6.16 and above. Before 6.16,
there isn't a stub version of the function, so all off those releases
are fine.

So this patch doesn't need to be part of the 6.12 stable tree.

Thanks,
Tom

> 
> 
> From stable+bounces-180849-greg=kroah.com@vger.kernel.org Mon Sep 22 01:18:07 2025
> From: Sasha Levin <sashal@kernel.org>
> Date: Sun, 21 Sep 2025 19:17:59 -0400
> Subject: x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
> To: stable@vger.kernel.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org, Sasha Levin <sashal@kernel.org>
> Message-ID: <20250921231759.3033314-1-sashal@kernel.org>
> 
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> [ Upstream commit 7f830e126dc357fc086905ce9730140fd4528d66 ]
> 
> The sev_evict_cache() is guest-related code and should be guarded by
> CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.
> 
> CONFIG_AMD_MEM_ENCRYPT=y is required for a guest to run properly as an SEV-SNP
> guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=n would get the stub
> function of sev_evict_cache() instead of the version that performs the actual
> eviction. Move the function declarations under the appropriate #ifdef.
> 
> Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@kernel.org # 6.16.x
> Link: https://lore.kernel.org/r/70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com
> [ Move sev_evict_cache() out of shared.c ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/coco/sev/shared.c |   18 ------------------
>  arch/x86/include/asm/sev.h |   19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> --- a/arch/x86/coco/sev/shared.c
> +++ b/arch/x86/coco/sev/shared.c
> @@ -1243,24 +1243,6 @@ static void svsm_pval_terminate(struct s
>  	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
>  }
>  
> -static inline void sev_evict_cache(void *va, int npages)
> -{
> -	volatile u8 val __always_unused;
> -	u8 *bytes = va;
> -	int page_idx;
> -
> -	/*
> -	 * For SEV guests, a read from the first/last cache-lines of a 4K page
> -	 * using the guest key is sufficient to cause a flush of all cache-lines
> -	 * associated with that 4K page without incurring all the overhead of a
> -	 * full CLFLUSH sequence.
> -	 */
> -	for (page_idx = 0; page_idx < npages; page_idx++) {
> -		val = bytes[page_idx * PAGE_SIZE];
> -		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
> -	}
> -}
> -
>  static void svsm_pval_4k_page(unsigned long paddr, bool validate)
>  {
>  	struct svsm_pvalidate_call *pc;
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -400,6 +400,24 @@ u64 sev_get_status(void);
>  void sev_show_status(void);
>  void snp_update_svsm_ca(void);
>  
> +static inline void sev_evict_cache(void *va, int npages)
> +{
> +	volatile u8 val __always_unused;
> +	u8 *bytes = va;
> +	int page_idx;
> +
> +	/*
> +	 * For SEV guests, a read from the first/last cache-lines of a 4K page
> +	 * using the guest key is sufficient to cause a flush of all cache-lines
> +	 * associated with that 4K page without incurring all the overhead of a
> +	 * full CLFLUSH sequence.
> +	 */
> +	for (page_idx = 0; page_idx < npages; page_idx++) {
> +		val = bytes[page_idx * PAGE_SIZE];
> +		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
> +	}
> +}
> +
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
>  #define snp_vmpl 0
> @@ -435,6 +453,7 @@ static inline u64 snp_get_unsupported_fe
>  static inline u64 sev_get_status(void) { return 0; }
>  static inline void sev_show_status(void) { }
>  static inline void snp_update_svsm_ca(void) { }
> +static inline void sev_evict_cache(void *va, int npages) {}
>  
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
> 
> 
> Patches currently in stable-queue which might be from sashal@kernel.org are
> 
> queue-6.12/mptcp-tfo-record-deny-join-id0-info.patch
> queue-6.12/crypto-af_alg-set-merge-to-zero-early-in-af_alg_send.patch
> queue-6.12/asoc-wm8940-correct-pll-rate-rounding.patch
> queue-6.12/um-virtio_uml-fix-use-after-free-after-put_device-in.patch
> queue-6.12/x86-sev-guard-sev_evict_cache-with-config_amd_mem_encrypt.patch
> queue-6.12/mptcp-pm-nl-announce-deny-join-id0-flag.patch
> queue-6.12/drm-bridge-anx7625-fix-null-pointer-dereference-with.patch
> queue-6.12/asoc-sof-intel-hda-stream-fix-incorrect-variable-use.patch
> queue-6.12/qed-don-t-collect-too-many-protection-override-grc-e.patch
> queue-6.12/dpaa2-switch-fix-buffer-pool-seeding-for-control-tra.patch
> queue-6.12/nvme-fix-pi-insert-on-write.patch
> queue-6.12/xhci-dbc-fix-full-dbc-transfer-ring-after-several-reconnects.patch
> queue-6.12/pcmcia-omap_cf-mark-driver-struct-with-__refdata-to-.patch
> queue-6.12/tcp-clear-tcp_sk-sk-fastopen_rsk-in-tcp_disconnect.patch
> queue-6.12/wifi-mac80211-increase-scan_ies_len-for-s1g.patch
> queue-6.12/i40e-remove-redundant-memory-barrier-when-cleaning-t.patch
> queue-6.12/usb-xhci-remove-option-to-change-a-default-ring-s-trb-cycle-bit.patch
> queue-6.12/btrfs-fix-invalid-extref-key-setup-when-replaying-de.patch
> queue-6.12/io_uring-fix-incorrect-io_kiocb-reference-in-io_link.patch
> queue-6.12/ice-fix-rx-page-leak-on-multi-buffer-frames.patch
> queue-6.12/net-natsemi-fix-rx_dropped-double-accounting-on-neti.patch
> queue-6.12/drm-xe-tile-release-kobject-for-the-failure-path.patch
> queue-6.12/wifi-mac80211-fix-incorrect-type-for-ret.patch
> queue-6.12/smb-client-fix-smbdirect_recv_io-leak-in-smbd_negoti.patch
> queue-6.12/net-mlx5e-harden-uplink-netdev-access-against-device.patch
> queue-6.12/usb-xhci-introduce-macro-for-ring-segment-list-iteration.patch
> queue-6.12/revert-net-mlx5e-update-and-set-xon-xoff-upon-port-s.patch
> queue-6.12/net-liquidio-fix-overflow-in-octeon_init_instr_queue.patch
> queue-6.12/net-tcp-fix-a-null-pointer-dereference-when-using-tc.patch
> queue-6.12/drm-bridge-cdns-mhdp8546-fix-missing-mutex-unlock-on.patch
> queue-6.12/ice-store-max_frame-and-rx_buf_len-only-in-ice_rx_ri.patch
> queue-6.12/selftests-mptcp-userspace-pm-validate-deny-join-id0-.patch
> queue-6.12/bonding-set-random-address-only-when-slaves-already-.patch
> queue-6.12/drm-xe-fix-a-null-vs-is_err-in-xe_vm_add_compute_exe.patch
> queue-6.12/cnic-fix-use-after-free-bugs-in-cnic_delete_task.patch
> queue-6.12/mm-gup-check-ref_count-instead-of-lru-before-migration.patch
> queue-6.12/tls-make-sure-to-abort-the-stream-if-headers-are-bog.patch
> queue-6.12/um-fix-fd-copy-size-in-os_rcv_fd_msg.patch
> queue-6.12/smb-client-let-smbd_destroy-call-disable_work_sync-i.patch
> queue-6.12/bonding-don-t-set-oif-to-bond-dev-when-getting-ns-ta.patch
> queue-6.12/xhci-dbc-decouple-endpoint-allocation-from-initialization.patch
> queue-6.12/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
> queue-6.12/octeontx2-pf-fix-use-after-free-bugs-in-otx2_sync_ts.patch
> queue-6.12/smb-client-fix-filename-matching-of-deferred-files.patch
> queue-6.12/igc-don-t-fail-igc_probe-on-led-setup-error.patch
> queue-6.12/octeon_ep-fix-vf-mac-address-lifecycle-handling.patch
> queue-6.12/selftests-mptcp-sockopt-fix-error-messages.patch
> queue-6.12/cgroup-split-cgroup_destroy_wq-into-3-workqueues.patch
> queue-6.12/alsa-firewire-motu-drop-epollout-from-poll-return-va.patch
> queue-6.12/asoc-wm8974-correct-pll-rate-rounding.patch
> queue-6.12/mm-add-folio_expected_ref_count-for-reference-count-calculation.patch
> queue-6.12/wifi-wilc1000-avoid-buffer-overflow-in-wid-string-co.patch
> queue-6.12/asoc-intel-catpt-expose-correct-bit-depth-to-userspa.patch
> queue-6.12/asoc-wm8940-correct-typo-in-control-name.patch
> queue-6.12/perf-x86-intel-fix-crash-in-icl_update_topdown_event.patch

