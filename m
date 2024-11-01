Return-Path: <stable+bounces-89515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621409B97EF
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215DA2821F7
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5ED1A2658;
	Fri,  1 Nov 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vw0VM5Ul"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1F1AB523
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487109; cv=fail; b=B8EGq1dtBVbYmHQlcQVeorx41pryGR/PeDQEa7Fh8lXFOhgKHp6FuMtLDw167qGV3zMgDZy1A6BhSSIRCaZAstSvz4AdUgntf47wzpHyRi0jxvDFkl5BvHNOiDX2rWfk+LDmjv/5/n+BghSp8q5HcoI/IB/kTlb7MSff9m5I5dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487109; c=relaxed/simple;
	bh=yJXI/68+Lp3tQoJpCmTMAUg/BL4tF9dZ7xdwCbH68CA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbkLhxPAVgUeZeIuscNKTxEASjNYk72KWEPS4DDaAaiH6MFgHtxzea0Skt5plXBWsvIP9tLV4EjFNK64qbUN23F4FJNzXmZnDH0PSVmAlM/gj+l0EoVUwnRRQbTUff/Fs1N9sZ8RarUflT0Hy9GCs0BnTDxJcPsvsskGHgFKIQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vw0VM5Ul; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730487108; x=1762023108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJXI/68+Lp3tQoJpCmTMAUg/BL4tF9dZ7xdwCbH68CA=;
  b=Vw0VM5UlLZGuw85Smz5RaKxzzAyd+MWiR/6H+k1AE/nRH6IgcFOg4rfP
   t4FsErB286ZyhvS/aMNLQe7hjg+vSdsWs6FI81L19803+5PB4vdi3K7ei
   nZ1w5BSZqTQLQN2HFah+JQzIZBtmoYOA402P4mNGA2TzLTZTrkAFnP5Gt
   y6lFq7rK8knk2RqsicI41YXojoTlon6jOxzEJ6sSxLgfqsUY148ROeho5
   yY6BcWTE3N1lB63FYP9dQTsolbCruDQWB6iEhRCW5Kctolko1ZUfEv8On
   6lXD21XkyccuQLXNvo5Smu86JVa23o/vyxzUePWQsUTCkGpRfpN+NlSh4
   Q==;
X-CSE-ConnectionGUID: +3LCCATbQbSf+8jo3qAjyw==
X-CSE-MsgGUID: hhshbIleQeSOjyHDq9kGbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="41623321"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="41623321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:51:48 -0700
X-CSE-ConnectionGUID: 6jx7GO2jTgeftI/aAGaJpA==
X-CSE-MsgGUID: T4m6SsT/QEG3HvmE49oGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83165673"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 11:51:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 11:51:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 11:51:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 11:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYtCAbuHvp7KYxRK5nAwl30Wkz1163nt/FHZbOQbbdrN8clkiS/LilFmXZhbT7smKXQdHJ5jSwmZ/y6SR5nrwoXpx9dzUfrsb3mxe7Uh9DGDUiBf8sP121TcofEnOOOUvxs/1FEMQfiOE7c+7rwo4vCNQw0kPi8cS8M9iwsQIV63jbYZgues9ra9sVc87A4uTThUpLsTTD/bbBxCz0wqm9J3lpWREQoaRoRI8ni51muu+XGc8e8tZe6JbMjNdKUyoABOKLcMixZp8Uol7U/EsFS2A4SLLR7X4FMucTgv/f7tlkQpFjeK3O8yesL0wiZI0ABsV3rIhy81OycD7idKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVGP0sk0gtBXB69uZdbrQyu5pwW4vDnwhHvIwPm2T6Q=;
 b=ZMNsN8hI7Awq2oAIf9f8uCz83xyB0rvsRp9KNLLGPv+x0/+i22WziXrtF7LuLkiKLBgMn4SGOHEJXwclq9Y2FlbMpL9uS2BYeZaRBAGzTO0m+3+9X5p5wg+7F8URbgalVkkJcxoxp68KxDPuNjI+xPCbLWdhOB5nrvjzmlOnovSkMe88st/MYhuAMzucNfcKMTfJkAhOCHSMbrZwOvDY4VXKkzSbKFNd0p74pDs8HlGkU9iTGAA3Zc+yT5Rdmbs4LRlbndKGGQ9Fbz1ZJ42rLIUuYao+uCHx4meyYowkiRIyalxhR0BCfpJ8GXx6k6hYuMCpD5gwRECVwiyCDYIi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 18:51:05 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 18:51:05 +0000
Message-ID: <32481d09-617b-4396-9577-010ddb657654@intel.com>
Date: Fri, 1 Nov 2024 11:51:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb
 timeout
To: Nirmoy Das <nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Brost
	<matthew.brost@intel.com>, Matthew Auld <matthew.auld@intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <20241029120117.449694-3-nirmoy.das@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20241029120117.449694-3-nirmoy.das@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:303:b8::21) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 791c76fb-0ca7-4199-cc6f-08dcfaa623b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFZlaU1Zd1o1YWIwbzBFczJmaEROMnJOK3VyekpESUQybnBUYjlXME04T1J0?=
 =?utf-8?B?SmNkSTVXbXJwVFl5aVpteUE3OWJ6ajZtdXBCaEVBazQ5YVBoMnQ3ZWtFTWdH?=
 =?utf-8?B?VDh6c2NWTTZjNW1TVTdDc2NZNFZSaGNLWjgra2M4NDYwS3d0aFRpajU0OFI4?=
 =?utf-8?B?OUsvUGNaSnhBaFpvcEhwM3ovTkxEdjdlbmV4dno2SzdGS3BiOE9QKzZWRUtQ?=
 =?utf-8?B?cEM5ei9SbVZCc3FqaVh1NUNtMkx6clkxa1RCaEo2U3FpRFZSTk1rdFBaVTdS?=
 =?utf-8?B?NWRkazRiTUlEam5IL3M5SElGRGwrcHdSVVNETnBtZVhtRW44ZjY0Ykt5WmVE?=
 =?utf-8?B?U295Qm0xZXlZNXN6VlVwZVorU3RySnNVRnpKSDJBbHZ3MWhUYmMwbmtrc3R0?=
 =?utf-8?B?OGVqSUZENFJTVjhlV3o2Sk9URnBmbm9KaHlheCsyYmhiUHlaOHZ1RlVId2NH?=
 =?utf-8?B?OExiV3FLOVVaSEpkdm5xc29HV0NmeVhHVzVzeTZabnpqdXhVbUpHYzFKeGdU?=
 =?utf-8?B?N2JTV01HK1AweU5JOGRQNWpTWnJ3aWU1bjJ2RjVENGhFazZDa0ZyVVlUS3Z4?=
 =?utf-8?B?YWpxNGRTbU5BM3IveVJ4akJQR3dpMVdkTUFycDBBSjlKaTlvK3FDVTVHZ0dW?=
 =?utf-8?B?bmFLZndvRlRINGZpaVNWKytVa0h4NXFQM09DSCtpSGhQOFMvb2poQVQ3UzRJ?=
 =?utf-8?B?NThMQjdIZ2F1NWpuSnJNZmRXcnZmR3FFVExhcXBlZjhwTjZFajg5SHU0Smlw?=
 =?utf-8?B?UHRCdVduSXNzTzBpczJFdDIzWm14ZC84cmY3TGdHcUVZYm5BS0t6b05JVUVD?=
 =?utf-8?B?c3RMQUhzdHM3OWQyN0xYTVpEbFZLNUkzbHV6aWN0M3VRK0t3UzBxdTdneG5h?=
 =?utf-8?B?Q3VPN0dhOFZ3RWh0Z2d3Rlo2ZGU3RndKMk9aOWxnbVFtVVFvZzF5Uit4UzE3?=
 =?utf-8?B?TmhQWUQ1TzRicmZnRkdWSWsyblRRYSsyZy9UdXYyRi9jZUd0UmIwYnpQdmxv?=
 =?utf-8?B?U1lZVW5Ja1U0c0xTRXBJa1N3ZDhSN2FmSFV1amozNjljK0s3ZmpiU3ZLNWND?=
 =?utf-8?B?S04wUDV6ZHAzaXhCRUlQVWZFOURwOVVYOU9UUDlndEtKUlpZanJFM3hXbVN3?=
 =?utf-8?B?SExHd1JNWlBnSDB2OE5leDNHK2k3UGkvR3Q3Rm1aaytQa2hvbFoxNkpJYmxN?=
 =?utf-8?B?SThhSlBIa2ZPaHVJTGJteUZzOElzME01elNESEpsOWdnT2k4TURKZ2FUYkpy?=
 =?utf-8?B?YlhSNitOOUhIVVVxUmRHVUxVVG90QzMyRWJVeFRuK0tzNlZkMTNyZmo1c2Vs?=
 =?utf-8?B?U3Y4OXdqYVl6NFllUXIwN0E3WjNiMU9tUkFPTEhrUWpmdWlON2dMOUVDcFhU?=
 =?utf-8?B?WjF6YVFxR3VoQVJFRTJoczVBWDdHNUN6MGY0RjN5Q0l6Q000YXNTVzVqbHAw?=
 =?utf-8?B?Y3MwVi9FRklYVHhNWWo4MGZXTk9LTkx6MEY5QXJWWExNZFc2Q0RWZ2g3Yyt4?=
 =?utf-8?B?bk5MUUNpM2tKRHlvYW9oNmxuVmNUQzJ2UlhGVGdrRkpDd2N5NUcxN1hTRXZM?=
 =?utf-8?B?R1g5djFxeEpMeU1vcUFSVTVqSU1aMWQ0TG1DOU9paU51YlRtbVE5QkQwWFRi?=
 =?utf-8?B?WG0yU3VzWThwOHlNSkFJdzZpZ29ieEw5MXRDU2tYcXdnY2dZSjVFRDcyWHUw?=
 =?utf-8?Q?GMoVrtcqRQgqliz9R2ry?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENjclRDeVdGVG5QNEg5ZUhEb1JwVC9EWVc2VkZKODdiL1lQbFJLamZjNXRx?=
 =?utf-8?B?WlQ3bW4rK1FROTYxZElUQTB5T2F5ZW8xQWRlYVdmYmpaZTAxMEpreitPWE9G?=
 =?utf-8?B?anhUTFd4Mzg5MmtYdmdqdHNyQms2cnVMWW5HNW5wUkJrUkFCc3p2TmdSTkJR?=
 =?utf-8?B?a1ptcjdKSkc0RUQ5NzM3UXJsdklicHUyVUlKMU5iQXlvM2M5a0RPakloWk81?=
 =?utf-8?B?amhjbE5IVVoxK0owSHIzcXhQVjNITlVoQXdJRWJsRmtBbTh2VnBzUXlYZDBi?=
 =?utf-8?B?NENOek5ESzlxeE80emJBRTBRN21nL1l5ZzZYOWNhK0tMajdVYUg4VHJEaFVK?=
 =?utf-8?B?b3N5WkhqR3Mxa2t5MEV3L2dVVE1QVEIzSTNpSTNYWlNlRWRpYmVyckplY3dl?=
 =?utf-8?B?bUNQMzJoWU9UblBXYjNRUjlqWGQ3enBFd1VHQlVpSWZxS1MxaEFEa2pHdzgv?=
 =?utf-8?B?a3dtRHVaR0lVU3ptQ2YzNVR3T2VueXVXUkxvSXJyTmJhekZ3RStIZmhXTHVS?=
 =?utf-8?B?eFMvTmdvdGlzZUlFRjNneHNLSEo4NWxHanVqTEtZNU1ydTY2d29nYlhPQk9Y?=
 =?utf-8?B?MjRKZXZ3YjEzL25EUHRZd0hsRStCVHlqR08xbXp5d082eksrODZONmt6ekZU?=
 =?utf-8?B?SzNNd2Y3dThDQklweW1IclMvb3RtV2NnNlFhNnY2bTlKbGMrV0RYcnVJWElI?=
 =?utf-8?B?ZnR1c3BQNVRlL2xEUzhqQllzY085UHV5Y1MxSThjYnlqYSs1OXd6RHcvRXNk?=
 =?utf-8?B?UGJiRks4OU9XV3dmdmdpcjVwRHJTOWJpTCt0YVgrOEdCQ0FoSk9HcmJ3Uy9W?=
 =?utf-8?B?M3BhL3ZWb0dST1Q2NC9sV0x4cXFVdTczajJ4eGpsaVRISHJFOWdhYkxXcTd0?=
 =?utf-8?B?bHY2ZzBVTlZyN3FsNW0yYkZLRUMxZTJzY0xPVFE5bEg4SGpUMDhHQ2kwT3Jv?=
 =?utf-8?B?U1lEemxBb2RJTG5jbUZRWHNPZUp0cXZLZGtIQkFCRG5XZUxza29IdW9ESnpG?=
 =?utf-8?B?bi9mb2gyTmp3aXJ5L3BuWGRnaEN1V2tpTll2c0l3V0VUNWEyLzVKSFh6RG9o?=
 =?utf-8?B?QWozZGZxMUxoNUtrSzllcWhyL2FqWThhNVFlWGNISXE0OGhpZlJPMHJQbkg2?=
 =?utf-8?B?UlozczJYdWU5Z2w0dUdwSFVtRHRzeTBUT1VPcnN2VC91TytFbkREZElScDZV?=
 =?utf-8?B?YWxZZyszSEh3MGJBQWpHYmMza2o3S1NKK0o1STRwbDFvcTh2R0U3U0RaYm1l?=
 =?utf-8?B?U3d6WlpRbkR4MUw0R0tSZytPT3owRmVsSXU5Y2Z4bUVhSGxaODZqNlAwcVll?=
 =?utf-8?B?OEwrNVUvOHhjK3REN1V2eTZUM0FTRDRVb1ZXWWdpWHFTN0xqdEZ1TmRJTDVL?=
 =?utf-8?B?aDB1Z1Z3QVp3Y2VJZm5adlNkQklWNDVQN3BsRy9iR2lQT2tLV0pTalY1UmMw?=
 =?utf-8?B?eEZPTzRSejFXZkNXWE5SRXI4YXZmMGRKNUlvOWZwL2xMcDVNczBZNXhNWjFB?=
 =?utf-8?B?VWZaT3lQdEZnWHM5S0N2Mk4wcTdHYmsxRHZkVW9qS1RZalE1bC9jaHVzYVVx?=
 =?utf-8?B?Z3drSGh5R01CbTZYWWtiK21kK2tkeEEvamVTQ29YaitjMVBCbnpXalRNR3dh?=
 =?utf-8?B?NmdDTkNSZDFvNmp3VFFQb05MZVl6QU4xZDg4bzFYWkFhMTBtM2N5NmRKVkxL?=
 =?utf-8?B?YjJ3M3JOem11c0hOeWFHM0hNQXpDZkJDcDhwNXBEcnRITkNZWlFUUzdNcTkx?=
 =?utf-8?B?THFack0rTC9aNGxJRC9tSFQ0ZW0xcS93QzZ2VGJJK3pMRXFoeVRDNVZSdHNY?=
 =?utf-8?B?V3VvZjBVVU5zSCtMYk4zNHNvak5IZm8rU0JraW10bFlvbFhaVkt5UEZWYVRx?=
 =?utf-8?B?bWw4Mkh6TUtRVk5RakF0TlFpZVZ5bUtKR1hGR3NtR1ppd1dCZk5xWDFHNlF1?=
 =?utf-8?B?MVVrOUdCeStSZzVFUGFQUC9lbTUrbkp5YzlRd0N0a2lTZWpRVllIK3pGNzN5?=
 =?utf-8?B?L2o4dzAzeXhLbE9VbzU1ZWdaNGh1UndLcGlyWXV0VDNBeDhLUG9QQ0F1NUxu?=
 =?utf-8?B?L1Z1Y1JRMk1yOCtLcnR5VTc1Z2Z0MngyT09URTNRcnovbUVmYS9TYkNiaTh6?=
 =?utf-8?B?NnY2MURRdmxPM1N0VDJXdmJSS25POHg5cFIyZy9NRXEza29sdDhYaE5Ha0pE?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 791c76fb-0ca7-4199-cc6f-08dcfaa623b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:51:05.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lM+xQ1sL4ctgIRkAMPGbGhbS7xmKifNl4KRgsy/4zCx4R5JclgRDAHiQ90Ke7qxKJQe+qoefuqbSXGprHVHpvUN80paNWaiHIyX8AeFyICc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

On 10/29/2024 05:01, Nirmoy Das wrote:
> Flush the g2h worker explicitly if TLB timeout happens which is
> observed on LNL and that points to the recent scheduling issue with
> E-cores on LNL.
>
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
>
> v2: Add platform check(Himal)
> v3: Remove gfx platform check as the issue related to cpu
>      platform(John)
>      Use the common WA macro(John) and print when the flush
>      resolves timeout(Matt B)
> v4: Remove the resolves log and do the flush before taking
>      pending_lock(Matt A)
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> index 773de1f08db9..3cb228c773cd 100644
> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> @@ -72,6 +72,8 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
>   	struct xe_device *xe = gt_to_xe(gt);
>   	struct xe_gt_tlb_invalidation_fence *fence, *next;
>   
> +	LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
> +
Do we not want some kind of 'success required flush' message here as per 
the other instances?

John.

>   	spin_lock_irq(&gt->tlb_invalidation.pending_lock);
>   	list_for_each_entry_safe(fence, next,
>   				 &gt->tlb_invalidation.pending_fences, link) {


