Return-Path: <stable+bounces-172284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6AB30DD7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C564D5E7EFF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E828AAEE;
	Fri, 22 Aug 2025 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8R4dvhu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93763F9EC
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839448; cv=fail; b=Nc2Nw0VC386rJSun0F7zo2059eLX6s1ZqzQ/inRCPI4iobg82RPx2t8DH130q20C8EsrlyKLzWJmafK9AgK3jkcww2Z9JemFwKlD/K+Q7Zkc0XzgW60P3LHDGEWfy17n3tVMHc+mbb4lXtVdph2KdAx3BYibibiZVRf3kByVSog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839448; c=relaxed/simple;
	bh=hPe5hw1hUGjShBaUXLYVxifAEOMT/o8laQiupJsEJuM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXmQ8Je7FlEndmthFhKcMjfJO4o3crQdWFE5r3jAntyr4NcbCnorJLujdeATaqNw4T3n0KhGBwx5mstde8sCVAPKWF6ZeaVgNr662cHiQWSwutqjUUV0OtLd1ahdL3byLRjQ8FhKiL7v1WwBInQNuF2XxoeCb35ziN5xGROg6ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8R4dvhu; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755839446; x=1787375446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPe5hw1hUGjShBaUXLYVxifAEOMT/o8laQiupJsEJuM=;
  b=U8R4dvhuLcnQZ05c5F0lHQO++98fGh3PvXEv9UPtOoooUEPLxGfvzg9H
   822qUJZ3+d65L64/XLwDlnKr+pJzdloq49+vcGye4LiGJ69NW+EQy/EX+
   ucOX7RoegsbhydMJVGVqbLTjt+FJUcvkGirUggwsLO9F3AJ5bj2kGizR2
   NW0LmN8qjt5TeY/wE0i5Z8TomppYWWq9Oh35h+y8QOHXjuUQH+42IycHZ
   ChWb5EgikjFW3GvmvxXXYhTpwmMVjP23jgHC+qsY1OcamF+3zNo/nK0oz
   Kbn+hFzZlrNBDB64H3FNo7a9EYnv16j18tSO/6DyxV6JdlNwwoJDBgP6V
   Q==;
X-CSE-ConnectionGUID: NQHVmbeuTi+iKhzsSNekpg==
X-CSE-MsgGUID: umxEyNRbSryVHF9GsjVDeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68845824"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68845824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:10:45 -0700
X-CSE-ConnectionGUID: DAegz9KSR2KYnBASi+s73w==
X-CSE-MsgGUID: OUaGIcwtQXmxZP8WyFHClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="167841795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:10:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 22:10:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 22:10:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 22:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPCe5RzJ4pC6Du0/JKXRDU2TZ4bgQSByWtJQ5HJwjhJ7wyEfbYlBVuQqyOscbrbfyGI7nMkMfGeNzZo0kOMZK+COjdCIs10wkKDG4hqiCcuv7gypoV4Af7wHtnwxFnOBYnUVwSD4Ej3Dl0Xb/thI6Alt+hVwekqPkdIAjFfRPR5HVYHoU5LKuBSsItDSGYEkTSKqcAspSIenc9KItaO4ViMfiDdLPOO2I/pgvXPSqyTJSkLssJS8OcV716FrCZBDGBkTPgaxEMin7JaMZPDUrJKf2L0tM7tpJuVJc/VlVGTq2xXzMYelSfl3VOj40f+Y6hojrle3OdLl5FMIJulI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH8uGnUhK++3DBVFXlg30ufUQbkqP7XGqL1fk9nxSu4=;
 b=Y0hunqHJdbccNaZs8w4WYz/ZG9WNGK96CCXt7hzGS78AKL3o+PGcTRsJSOmrknnnJUd5inkiffZyWAE9XRZoPR9eCcfjbZ6F5uQfYV9pWcZkdh74NfTTgv9BykY1Ukiuzy1tqk/DHwpj/0Limnd3YIhzswJtQAOkFnVKP1kt1pfr0QZKd/Um1g2UPOxomili6rdsWlkP+uE4vOC7Nu4ViSyBlW0txOiVlTP+9DNDZDuvyqlKyi+CAIzXnFFrsl3sKG3j96zrAHS3WvP1qx8/sogX7RSvaKigN6RVzzHzv9C4tvJnSQ9jAnHN6/GB5nmKGJMQ2fNpwEb/v7XdyqMu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 05:10:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 05:10:42 +0000
Message-ID: <0bff6489-402b-4c4f-bd7f-fe8ff526f91b@intel.com>
Date: Fri, 22 Aug 2025 08:10:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] scsi: ufs: ufs-pci: Fix default runtime
 and system PM levels" failed to apply to 5.15-stable tree
To: <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, "Patni, Archana" <archana.patni@intel.com>,
	<bvanassche@acm.org>, <martin.petersen@oracle.com>
References: <2025082102-levitate-simple-9760@gregkh>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <2025082102-levitate-simple-9760@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0e673e-22f6-4f5e-97b8-08dde13a3e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDBJUldBdTlSZzc3b1YrWFdhc1dCK3l4SnpMblpEOE5JbEJkaWs5TFFaL0pE?=
 =?utf-8?B?MkwyVVlZMGRGZjcvKzJzUGlwc1lESmNOWUxRZitUZEVrUzcwS2k5Kzg5QTl4?=
 =?utf-8?B?Nys5QWs5NWlRRXlyeS91TnN3RkJxc2NSWExTZ1lBcWhlRVNuU2s1TDNVQXc5?=
 =?utf-8?B?WW9VS1RaZ3pIWk9ZL1psVENMenZEWEg5UHZ1dlBxRzV4SnV4TGJMN3ErcG1J?=
 =?utf-8?B?VDk5VXMvL29hMHNhYkF6TnZCUE9YQzRuRHBGc2JoVFhVTCs1bmZQczJxTTUv?=
 =?utf-8?B?TFNFWjZmYlFnOHRDa0E4L1FsdnZCZkl4U3FlZkFTRjVSNEVESjNrT2x3U1RL?=
 =?utf-8?B?UEYwYlYxekE2eEdJRUVGZjNVMXFsVEFwS1J2eEVGQVFFa0ZzQmkwbEdmUkNI?=
 =?utf-8?B?cGhwRFA5OFVhM1JrelBWdGRNandqaVJDZFZHbDBTQU5NdTdoQzdxVFpuUjI3?=
 =?utf-8?B?aGNObjQxYjc1UTF4eUpWeXo3T0I3bWloeWs5UTNiVVdRMXVoeDZLdEx6SWpD?=
 =?utf-8?B?dzRicjN3WXQ3NE10eEVySWhpWTBZZUkybitqUlFlUzdFZ0VLdE1MMTRrUkpY?=
 =?utf-8?B?ejhlNDZlc0FaVmZqUHN3WkxlV2tuWTVqU2ZZZm9ZdHdQWlovc0F5d1U3NTYw?=
 =?utf-8?B?ak96R1VtVHJFS3k0dXVOb3ZNL0JGRU1NYy95eGh2T2hFdnlEd2JPZVdtSk1n?=
 =?utf-8?B?bFFtWFkycy9KVDhMZXlIblgxZzNKUm9oZ0VvYlVlc3BoamoraVRyL1duN3Bq?=
 =?utf-8?B?NjlRejFycEFEWnk1Q1dJSG1NcUFxMkRGSjc1d0pZK1N4OGUrS0pIbzFIcW9z?=
 =?utf-8?B?YmxkcTRqbVJoNFRIcE9aeDhickY5M0MzeTlMK2RXbE1aRkpwVnVVQkJXdGFK?=
 =?utf-8?B?UktKejJZYzdNdGdraWJjUmdrOEZ3YTVJdmpqaENUdEEzZzZsSEtGcEpHOXNP?=
 =?utf-8?B?MVZVbHI4NTh1NnpkZEgrUm1KSGdZaWI2dkM2NXIvZnZHSExYOUd3eVZxQmJY?=
 =?utf-8?B?RkxrcWJHeHhtRDJ2eVBXVTNVdkxrSWo5RHo4czEyaHZTbStSdnlYZW52QkR2?=
 =?utf-8?B?ejhFd2ZiWGNIa2pBSWNMN0MrV0JvZEVTQ01RNE5UcEJtYjQ3eXdpNW1oNEZJ?=
 =?utf-8?B?ZXlzMlhpQkhybUYvYVdFRlFmTWVkK09WM1I2ZzRPYlY5YmtlNmhlWGZDM0lH?=
 =?utf-8?B?ZE15dUFzWDB3Z1M1YS82VFh4VC9kSFlzYWpqV1FjT090L05SNVRvSHI1M09E?=
 =?utf-8?B?SHArNHgxVWJET1JTSW1tY1JuYVRVMFdzQkRPRjlXNFkwY3BnV3JHUmxWWTQz?=
 =?utf-8?B?ZURlUk5FWGpvMm1rUXRYY0FDbm44b2s1ZHlhT1lNeCtNVzhRcW5kVGhpR3J4?=
 =?utf-8?B?a3ZBT1lSZitYdHp4eWhDMHdZL1VhNDhTcXM3TytTSkd1UHp5OE9BbkwrWDdk?=
 =?utf-8?B?QUV4dXVLaXQvdVJlbUJqQkNiaFdsUnNabXFKaVd0Z0UrNnpVUWc3aGlrVEZw?=
 =?utf-8?B?cVR3WjBqSnRZZm5qZjVqU3ZaeEVVM0RYVm9RV2NNWEdIQ2JVRmYvdmJnMzVp?=
 =?utf-8?B?d3E5VDlhcWlsaDNmZXRqRmpqSjkyUVgwbzNYc1pPalViMUt4ZzUwNUJvVkh0?=
 =?utf-8?B?QlVjcFVxdzlZNldIc0R2MWtaZzZMN3poY0V0dWRaRk5Ocm5jb29rRm12WHJr?=
 =?utf-8?B?dFBWK21rWUlZcXVPcWVJSjYxNlFLUnFicE4yanBKZ2VNOVorV0k3emV1V3g0?=
 =?utf-8?B?OWsxRmdobno3a2x1TVFMOWFZYVRvOGFNdCtTbmFWVVpWVVlhdEMyM3JIUUlS?=
 =?utf-8?B?N0ZoN05KMHN5Zi9CVW5WUVVuc2k3YTZ4U0RlWXJoeDdMbnNxV2lZY3FkMVZG?=
 =?utf-8?B?NENWcTUzVlJ3RS9UZ09iUFlBdjNrcEsxMFpKczE5bEFTZHRoQUVVTUtRbG51?=
 =?utf-8?Q?zaesYDczwIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TngvNGszd2x5d0VtWmJtYTRYTlFNRWlteU9kM1VWbDFFME9KVGUxTno5SXhN?=
 =?utf-8?B?WXVKU3Z3VFd4WFhHdkFvbHNYdERrRlVCNytJYWs2dm5BNzdxdzlESHA0OEU3?=
 =?utf-8?B?UkxPWHVBcjQyMEZTdnlKTXZ4dkphSWtuWEg1cGwyOXlPblFySjFmNjZ5NzlJ?=
 =?utf-8?B?UGs3NVRPRzhGUTBMSDNxZHo3eXI2K3VWU3RYZUcvSW15NERBY3RUOWx1RU9w?=
 =?utf-8?B?enQ5blMwSExMWWhZM05HRUdTOGFrbVIzeERzOEpYUlhZTDhaZmQzN1NaYUFR?=
 =?utf-8?B?M3FhUGZ0ODRCZWI2d1FSaWVBTjdJTFZQMUlaUzJscTQrTmxFQ2pMOFJtZm8x?=
 =?utf-8?B?ekZ3WjVBMUFTaXVZNWxqaVlCeE9sWEpWSzk1N3hRQ29lYnpab21SQVlTWHdR?=
 =?utf-8?B?U3MzcTB1UlRUcFMwc0xETVRLMFcySlZvVVdPMUlwNitINGp1dlRHc2FFNmVj?=
 =?utf-8?B?Q25abG5aVEhzaUFraHUzMjRUQTJkaGZxaXF6SFMzUURMekwzWWI5ZDhHYWdD?=
 =?utf-8?B?d0pvb3paT1B6TEFSU3kvZ1lEOTUxS2VvMHg0WExlamlEajRoOGdZWWhGQlhL?=
 =?utf-8?B?cWs4c2ZOOXh5VUxsZFhFMUdBZUFKVVQ4aGE4MURSdGVFbTVsWS83QjV3NG5z?=
 =?utf-8?B?bGZJbmlOUHhTOGJQQ2JtcVAvelBqczRLdFdBZ3F6YjRXK3oxT3Z5VWs0V1hX?=
 =?utf-8?B?cjJEc1VTQ2NkVEczeEplVnNoSko2THZ0MDNJemlYSzJqYzExUHR4OC9LZmQy?=
 =?utf-8?B?ZVVTQms0OUFEZ1JscDA1RkwxYjZkYXI2N0lTNU1XVkZycWNzUkNjVStzRk8z?=
 =?utf-8?B?eG1BWDZCQVdKUExZakNQaThBelVIR2prZzZqeTcxOGx6ZUxVdEdqYytlazZG?=
 =?utf-8?B?U2Jkb2srV2ZrVVlpSmNjdXZNdUFiTVgwbFlCRnhneGpveHpOQ1RHNlJsNzN1?=
 =?utf-8?B?WExUZXlWZ3lmUEd6WjZqeHBXSVZWeHk3U3Z2eC9sWTlQSkJJK3NzTEhZUFI3?=
 =?utf-8?B?dnpDbXVRQTQ2bFhuM09aTGJIc1hNS0hBNHBCdC92bnV1dmtXVkYrb1hKVVI1?=
 =?utf-8?B?VTBJbUZsQXNpTXNJNThReUFmRWZBU0gwbWZiVjlSSHhrMEpMS05QTUlkOEsr?=
 =?utf-8?B?RnJlSmovYjlVNEpSWVo0YmR2ZlJrYlpXdEZ0UTBmUStuWWFMNUVZbDNhTFFU?=
 =?utf-8?B?OHJYTktuTStYTVJNa08vcWh2MHk5cGkyWEYyZGRhQi9VWlJ5MERqSStjcVlT?=
 =?utf-8?B?K2hSd0JnMW5sRnNCQTdYVGF4ZkxDSXBKeDZVNTZuOHdscDB1MlNtRytJSmJY?=
 =?utf-8?B?WTF0WnF0QmllRlZoQW02TkJvSU9sRVFKRjZOZDNrYktBbGg2MFFmWjkrZU1C?=
 =?utf-8?B?Y3RBMm5oZURONG5adFlTSm54K3NkSGFSKzRtRlhrbFlaQjhaSzQybXVQb3BD?=
 =?utf-8?B?VVlKOWlDNW5ucndNL3pJVXlxM0c1Z0llb3hTMnRPekkrendMMUt2cnZHQmRD?=
 =?utf-8?B?a3EvTk1oeHhWQTRzSDVPalc0dWFDcURPUDR2b2tiUGZhQVFEVmc0TmVtRnhh?=
 =?utf-8?B?ZHVoNnMwWUtJNTN5RzFUOVd4N21wNmxwU0RHNEhmenR4RXdZMHZDS1ZBRjRs?=
 =?utf-8?B?ZVpxSkFDOUQzQ0FlcE9CSWpYZVFMYTYrb2NFeVhJd3dscjJaY01SMVlGOXdX?=
 =?utf-8?B?bm03YUNMcms3N2QvN3lCUEhNWEZOQSt3QXh3ZVBkTmN4dWJ3bzdkd1lmL081?=
 =?utf-8?B?elZidXB2MndVdElGQStHN0lNcXhSM3JsSml2cUVLbVBMQXpuNnR2YUV6bFpy?=
 =?utf-8?B?M3ZJUGVkaTlVcGFSN3dhQUtFZkoraXNrWEZLR0prZ211dmY4K2hEc1ZFYVpH?=
 =?utf-8?B?YngzeTA2RGxmTkJvY1o4aXI1WDhwdmovdHNaWjBWT3haRTMxRm5lWUU2QUNX?=
 =?utf-8?B?SkdHSVc2YlJVNG5QYVN4SkFNY3pKUTBsNXBMU0w5RmpZaFVxMU1IcDZmcTNM?=
 =?utf-8?B?c2RZUlFEbkNUbFRMQzRKYmRwWXBFOU4wMmVsT0IxR1BRVFFTcnRmVjIwRFlx?=
 =?utf-8?B?TU0zM3NpNnVnN3VqWENucVh4bTJPNFFBeER0TUNQbUhpTHBDRkN0MXhQbktx?=
 =?utf-8?B?L2xpTlZ2NDIrTEs0THA5TlVrZ2VaSXBzQWV4NVNyeG1tMGxXTEhqdzlLTUtW?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0e673e-22f6-4f5e-97b8-08dde13a3e39
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 05:10:42.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPQJRI2mJ7qETlCyfZJB/oa3l26+XqXNQbEez/WESpVcadmFPXiBVwyyLjOS/vaKbm2W7aacgbopOSh4oxdkWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

On 21/08/2025 16:09, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1

This works for me even though ufshcd-pci.c has moved since then
from drivers/scsi/ufs/ to drivers/ufs/host/

  $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
  From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   * branch                      linux-5.15.y -> FETCH_HEAD
  $ git checkout FETCH_HEAD
  HEAD is now at c79648372d02 Linux 5.15.189
  $ git show --stat 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1 | grep ufshcd-pci.c
   drivers/ufs/host/ufshcd-pci.c | 15 ++++++++++++++-
  $ git cherry-pick -x 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1
  Auto-merging drivers/scsi/ufs/ufshcd-pci.c
  [detached HEAD 15aa885c945e] scsi: ufs: ufs-pci: Fix default runtime and system PM levels
   Date: Wed Jul 23 19:58:50 2025 +0300
   1 file changed, 14 insertions(+), 1 deletion(-)
  $ git show --stat HEAD | grep ufshcd-pci.c
   drivers/scsi/ufs/ufshcd-pci.c | 15 ++++++++++++++-

Please note 4428ddea832cfdb63e476eb2e5c8feb5d36057fe works too:

  $ git cherry-pick -x 4428ddea832cfdb63e476eb2e5c8feb5d36057fe
  Auto-merging drivers/scsi/ufs/ufshcd-pci.c
  [detached HEAD 9b324ade6f64] scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers
   Author: Archana Patni <archana.patni@intel.com>
   Date: Wed Jul 23 19:58:49 2025 +0300
   1 file changed, 27 insertions(+)



