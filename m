Return-Path: <stable+bounces-139311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DEAA5F35
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6D47AE979
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADC1A314C;
	Thu,  1 May 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ra2twYCW"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BD19C55E;
	Thu,  1 May 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106211; cv=fail; b=MZp91+Z82X0NGe3Bd2sQFbj6SpKp0GKFEoMJXyYWAHC4u7/mkogEZsKrZOIY6UsD9+ydN/5fkI4NKCz18E0ee2lKYMfCgBUzWYECslGXjdycfnYZplQ/jIz072k3QwsXTES8ym6yePZzbi7pViPgyB+8jDx7KbIKUKuZqT4hlCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106211; c=relaxed/simple;
	bh=W+ma64vi0m50kSiJS7RDHWiARiHBaj1AE8lLq+gYXlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m/gbJv8MNzXZGqZoluvaWU+LIuMobx/X9R0UBJ/GeL0axz79uWOhgz8iDL05jhn/T6vfowOG+BVSHSi9nABNgGUw1/TvHuewFs1CYr4O6+C6h/XSkXR4uwg9+MI4UAqYrL7WCx2/+3CLdQxjgyLPdaxk0c8wKM3qlyLccRE8ktM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ra2twYCW; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNFCDoCieCRExs1KY/3B8LAL0TDZL6Zl7ROxe5jPeKNQy/lt9z8sW8ylCfrbiZpua724ZrTzjbyFSVhadnpMR2GGZssEGfQcd3KaUCw2lGzyfqDTCM0BqOF0zIaJ8VyoTwQFGVYOUq/1QJSzoHhsIAEMb9N0MP7CCY/ZAU/ohzcVTqM/7GpAQKtxBkzNInBUdi63Y2vXh1WCIG68HMcSpqmgC+JKK1EBmgzo3VelUxYaUoIiwWliUla9jHxd+HmRnXzghPsE+j96/RGWhP9oKz6sngZdE6ziTK2DhYW9/od115oeaojhvd3S2lxCM6LEAi3y2F9IXOKNinYnoVWjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NseGMW6YHZumRsu/ROE0vbLOHt7tZNwPE0voLa45rY=;
 b=bY9mEK0SpzqiwYrRP1lZwPsMDsrhS86qND1ZYp80THzczF86xKAgwk+gVH9jHNat+rIIAGK8jFVD4OQrnLcSi4TxkHW7kBk2fdVRJnb6Fml1fR6vOd9ZS5tgNtrN5PNI0t0pkh1Ro4hIHGVzs326ciLX0leiX+NDC1jgxYwlte6Igi1YP9YvCzW3C6qPq2hLt2ndl65GEVOzNBJz7tJq1NEGU7yFtbJy+RAymjZWyoTeskaqSPhAMd2FfO4VEPIHIYNgixqaGg76U6BaYe/pHoLamxiwIuof/nEU+jMMuyLeswb8U/YTTqh5MbVrLULSIYrNMC5AiMxsRFNjcSEvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NseGMW6YHZumRsu/ROE0vbLOHt7tZNwPE0voLa45rY=;
 b=ra2twYCWrb6VvbSIkgAboZFd+wvr8o2J8N6HT8SKq3s+5YuyXqa3ML5z3E+ChUiT5wBiGEX1S1K9WQLEDoQDYaui3aLMUZNFFgZpL0bCvNpw8dKUA8aptj4jy6DBlnrUWrJq9SJ8RNKxLca9yiXnHLpvthZMLhVDzkS4uoOiv9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 13:30:06 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 13:30:05 +0000
Message-ID: <e7a0cc72-388a-7fa4-601f-371aea369204@amd.com>
Date: Thu, 1 May 2025 08:29:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] x86/sev: Don't touch VMSA pages during kdump of SNP
 guest memory
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: kees@kernel.org, michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
 ardb@kernel.org, gustavoars@kernel.org, sgarzare@redhat.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev
References: <20250430215730.369777-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250430215730.369777-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: a6600eb7-e72a-4596-716c-08dd88b44868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlRKMy9iNGtncU55U3JpM20wVVBnTmtycm1LZTMwNCtWN3hFUWliWjZNeUxt?=
 =?utf-8?B?QUFnUVUwVy9EcjRXRXA1TjNXNUtPRnpnQ3pQWnpHY1BBUmlvb2IyNVNDVWZT?=
 =?utf-8?B?UjhMQkhLWHlMMGNtYU8ramhjd05zcmF2aWlSeVQzTEQ4cU0wRitPMm9kd0tJ?=
 =?utf-8?B?M3pLVzhlcmlHRmhRSzBPY0NTOU8ydGFHZUdRTC9pTXpiejBKR3JLMG0wSTJo?=
 =?utf-8?B?cmlHZ1VoOEpwUSsxa2UxQVUzYm52WXA1QUhGcmU5ek94RkNyOEVYTGc0YldL?=
 =?utf-8?B?UjNzNWtKTEtwdGtEMVA4WnhJaEVod1hlUVl4TlpCNWd3L0dTRTA3cWFOSm5l?=
 =?utf-8?B?a0haMmVsbmJ1MGVQc3REZUROQkdqT3lBQ0ZmVjZZYlNBMDlLRzVZL3hoRlho?=
 =?utf-8?B?SDhLalFKZzRvVXQ5eGR6V1dCUTgxdEJpS01Tbm5jc1FyU1ZDQzFwb0FVSFhM?=
 =?utf-8?B?dkwxMUIwKzJMV1BEeUZBeWIrNkt0ZUU3OTJTdHdXYTJkUzlZSTk1dWJNVjZ5?=
 =?utf-8?B?Mkl5VU1Vb1ZMRTFBaGVzbStpSkQ1K0ZoMytiYWptYTdUcGRWMEtra214QXNJ?=
 =?utf-8?B?NUFXaVovYkc4UG5kbVVjaG9CbE5SYXBlYUdYTE1vNEVFNzNCQ0ROeTdRMm9W?=
 =?utf-8?B?ZExIN01nbXlmajFQTVo2bE9uUzJHU0xFMkZLZU9nQjVIU2pWSEFjK1Fjck5C?=
 =?utf-8?B?QVFOOThvT29YdGc0VDI5R01TbXpCOExVb09heHhxRFRlUUxEcHpqVk1KaGFk?=
 =?utf-8?B?djRGQUJTZlNIRkppNGN2dnB3emZEVW5FSXVTUk1leU8vWVFGK01qQlRXT0NJ?=
 =?utf-8?B?RXpkOHVZajdRSkxnZUduVlUyUkxlS3E3OGprR3gvTWhWOHczcmd2Vnp2bm5X?=
 =?utf-8?B?bHJxN05lWjRVT0ZSUGQrMVpNUWg3bFFZNFdyZDU5Y1YycXBQRlVIRTlkYzJX?=
 =?utf-8?B?bnZvRUdGQUk1ZXNJbVY4U0FnV2JDNVo1cXRCdUNmN3N0LzViZExHZjR2M2E3?=
 =?utf-8?B?VVdpVE1kSE5wTmpxd0NaY2E3b0JMS2o5MGVhK3o3b1dKMnZmUzhTWGRreTBE?=
 =?utf-8?B?UWEvTnAzbWFkRVRrZ0NhY1lUOXRjRlhDUllSUVFoMU9jbVFmKzVuK21NaGpU?=
 =?utf-8?B?c3YzMitMLzltbE41eGVmQnFoTjRoL2d4VXRFYTltdEV6b0FoWXR0RjVsUFJU?=
 =?utf-8?B?eTRqL1lJZFVQWWI1Vm5Ibm9NRHVlNzlFRVNXa0t5aWxDYTZTS2xvNkF6ckpT?=
 =?utf-8?B?SnVYWnpmNnFyZEF6UUVTeUJnYzIxemRIN0pNd0tGQ0I2RHUzRFp4aGdkaVB2?=
 =?utf-8?B?bmR3TzdRdUlBelhqeDlFUlhNVDFJUjJsUkhqQzIwdWszWnBpOGhxYnVJZVlX?=
 =?utf-8?B?Zzh4NExvTkZQVXpkU1FsMElEazZuK0t5emlZbEt1ekFDRmR1ejFKVjFuK1Bi?=
 =?utf-8?B?SzRKNWRzVm9uQ1BMeCsrSVZ4enNmSXJEMUljbzd2VzB5UExOajZycUFycXZi?=
 =?utf-8?B?OVpMclRkU2NreEkybTdpY1ZFZ0hicUNwZFhjeWhLZld5a2JSUjNTUWthOSs2?=
 =?utf-8?B?UHBCM1llNGgzZjFlazZ5MkE1RG8yZlNwc1FnaWdOMVRTR3FQbFpXRmMwZkZI?=
 =?utf-8?B?TklZSHg0NHNkRmM2ZnpUeTBWMWU5QTJmL1hXcFZsTVN5RVgyUmJHc05pVUNY?=
 =?utf-8?B?TTgzMVA2cmwxdXhVSXEzK3k4bWs2Z284b2N3cytTZkcyRzdxUWx6R3RSV1hL?=
 =?utf-8?B?SnBPZkFFL3ZKUmZhWXN6eUxxcUQ4bHRZaklOZjFkQ0NrNGgzWU1IYWIzcGFO?=
 =?utf-8?B?RXEvRzAzMVpBY1ZEK3c1R3JHVXhZWHFMM29aNXQzL0F0L3NZR2NOTzNzNVFr?=
 =?utf-8?B?bWJVeFFuRVlFRnhyOVRybzhLOHA1QUhhU3BFWmpmZzE0OGJnS0QwbFp1MlNz?=
 =?utf-8?Q?txrJCAp6JZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3BVM2hsV1crczBQY2pIMEh3UFFVdGg1TDF4LzJVbWw5WXBFTm1ncGE1NWxx?=
 =?utf-8?B?K2R3K1dSSFZMZW9GWlR2VVZOT1VIYzl5STJZY2htK1dhaWVTb2Z4Nk1veUJB?=
 =?utf-8?B?WWRTS2NXb3JiVVFFTjFKZHM5aXgxMmY0Y0xrZTVnd3gwQlAxU0t3SnlIWG45?=
 =?utf-8?B?eXRPVklPZGJsWDY3QzJRQk8vU0FKcGgxakpyRUpnWHQzTVJIMVIxU1RPVmR4?=
 =?utf-8?B?TVF5ZkhTRWdzTW8yUmkxV0hpd0RlSWhSK0FRV2Q5amk5MXh5MnZ0L1ZNcks0?=
 =?utf-8?B?OTBCZ3ZIeld5QVg2MXBwNE1mTldJWWg3Z1l0d1h2TWcvVTBIUUttaEVQNjNO?=
 =?utf-8?B?OU5WY1Nxd3BhVVgzRDhjV05kZUxOT3JDWjdCMndoTmhkcjVwTjlnWW55MXNw?=
 =?utf-8?B?UE9yaW04SGRQcHR5RFNlWmI1ekRHMHJjS3FDbXVYZUJCcXJwbmRMUTNKbmRs?=
 =?utf-8?B?dVNtaGYrdGxRY1dMRW8xRjRjejFvN0VvenF1Y0w4RUdCdGd1K3A1eXlwRGkv?=
 =?utf-8?B?WmpVVEpMbldDWjFRVVZnYVVvVnhHYUx6bml5MENUazU3ejhiVW00WE9UUGVR?=
 =?utf-8?B?ZlZMTG5rRWM5Mm93RFVzQ3BwSHdTWGFpZWo0dnpYR0dXanR1WkxvTFpoWm5y?=
 =?utf-8?B?dmpjN0x1czdnNlBPdUNIWVQ3NDYrdWF5TTdlMVF1YkFQLytFdEsrQzRRU2lP?=
 =?utf-8?B?Qk00TDREUllHNW56bFk3SVlWRW8rNVJDeGtHcWJXY2dhck9FdnhGWm5OYk1Q?=
 =?utf-8?B?OFlFZUYyaFlxaTV3MW5TdTlUQVRYSW8yWU4vdHJNZHVMU3Y4Y3d0dlo1QVBF?=
 =?utf-8?B?N2VwYWlGZTdDeXlNMVpsb3BDR3JYWnpqODRMWmZSM1ZuQWRqeFI5QVZqRXpQ?=
 =?utf-8?B?MDFkSG5iR013UVBCYWZva2pHc0dITFdodFhSdlB2eElmT3RBOFZrcTByb2JP?=
 =?utf-8?B?SEV5VExaa0FMQlJoTUxrNm54d1hVNktQWXVFT05KMC91a3NBR3ZUM2MxZWNi?=
 =?utf-8?B?OVU3UXJEY0xXWVQ2MXpXemJGbHBIWCtrbDExd0o1UmxvbTNYOHJoZkJyZlJZ?=
 =?utf-8?B?VFIzY3g3enNEVUZ3WGY1eE8yNWgvTEFreGlzMHh3Qi9Gb1JBd05ZSlVFMnlN?=
 =?utf-8?B?ZXRPWkV4dVYrNzZEMDI5bmhtOXJXOUZtL0ROdmQxRzAyNTNTN2ZVVStGWk5T?=
 =?utf-8?B?V0pCTmVWUlRvK0ozeityUmU5TVlFS0FmWnc2STUvdnhrNkF3QzJYT3VpRVhX?=
 =?utf-8?B?bkZ4S09DdmNlZHdWSU9aS1VQQ3ZhSEpwczZOWUV6ZW5jWWJoZjFpWWhvQ21k?=
 =?utf-8?B?M3VBMU43NkZwUG5SbzNXQXFHdDFaQ3hteFpzelkvUm9wNVJMalJvelRPU1l1?=
 =?utf-8?B?NjVRMWh5OWRueE5VVkM3NG5aYnowTmtSYXJjOHl2azh0eENjSlNNSXVRS2Ft?=
 =?utf-8?B?MnBQd1M4ZWl0b2dZV1ZSOXloU0I2RnJ1MCtXbkZ0NU55M25zeXBkR3lCckxH?=
 =?utf-8?B?eVlOa0NtL0paWTVTTXBBbURhTlplYzJvdHRIdEtET0NETkZINFh4KzBxTVRx?=
 =?utf-8?B?V21jMWJRelRRSnZGQVpyazNmWVVUeitjVEZXeU9hNnM0aGVoZmxJY2tkRVEx?=
 =?utf-8?B?RG8vVGhyVDVDMitNWVpQSkNWYlY5cHFmZmxDZnhvMjF5dkxPMVhUSWUxYjcy?=
 =?utf-8?B?eDVSK09CL3JyUWt6Q2lNUFgreGM4M2Z6ZVp0dENlb29JdGtmZE1KS3pYMkdo?=
 =?utf-8?B?MmVHZWRQSzBSeU5GT3hCRGhXdEZ3d3FnVjdnNzExNWtDWW1QZzhSN1VFTXlF?=
 =?utf-8?B?M1cvUSsrSVR1aTF1L3Foa1hoTFhpUVFBTytySDZnM3hlTm1hVnFySkRzc0RU?=
 =?utf-8?B?bDNtejB5OVYrbVp0bkJMekFzOVJIWUtRZFJIQUZNZmVHRFJLWEVzaGZhSExh?=
 =?utf-8?B?VTRSRnJ0QXdNOFV2Q3NJS213c2VKVlJaSmhLU0oxeXJLL0VrVFV0eUFyci83?=
 =?utf-8?B?UTdxK2Y4UHdaRW5XZW9iK2RWQWZYYVo2aGo2NVJnNUxJbk5OUnBWRFovQnAx?=
 =?utf-8?B?WGlzMktrN2JEV0wranVUV1ptdTZMZ1YxM2E5WmtEWm9BQThzdUhQUTlEeWtW?=
 =?utf-8?Q?laWRf0HLQIXxHwnxxIYNWNZrv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6600eb7-e72a-4596-716c-08dd88b44868
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:30:04.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUVVM3uBq7YsSCWr1wcAVjYoJ8un8ZHzM5uwlHTRqIzeSk2m19qewkBDH5jC6XYCC8pZyUq/+OhjWwy2ZXaruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

On 4/30/25 16:57, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running and subsequently causes
> guest softlockup/hang.
> 
> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 244 +++++++++++++++++++++++++--------------
>  1 file changed, 158 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index dcfaa698d6cf..d35fec7b164a 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -877,6 +877,102 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
> +{
> +	bool create = event == SVM_VMGEXIT_AP_CREATE;

Just occurred to me that, while we don't use it, there is another create
event, SVM_VMGEXIT_AP_CREATE_ON_INIT. So maybe change this to

  bool create = event != SVM_VMGEXIT_AP_DESTROY;

Thanks,
Tom


