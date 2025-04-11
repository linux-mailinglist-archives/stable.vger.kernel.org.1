Return-Path: <stable+bounces-132193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55504A85134
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608D7188605B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A41270ED8;
	Fri, 11 Apr 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga7qcpZz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88B1E5B94;
	Fri, 11 Apr 2025 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334575; cv=fail; b=chCxEss6+s3wm74h/1QY81LV/r9VoaiteDOhefXFUIFPzWf6fcPjueEE+KQtNLmH3DbBUJquy8ywnooPAD4pOelWgC2/StzOXFHTZ+A5BRiDDUNzIDdKd37ZdSp6+Okx2P6GvCKgorbqCpV24738oTOnRtCuqibH0eNbOaizSE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334575; c=relaxed/simple;
	bh=Kw4Qv+/GNKOg5IoscHIxsCfeS37EtCKc3kvUQm4+9xc=;
	h=Subject:From:To:CC:Date:Message-ID:Content-Type:MIME-Version; b=CD/09jd2QOZ2y4PR7yKedoZIli4rDB6dbeCKJg9M3LcDKGLY4ZP/sdU9rVKDd7emXU369BM9SQq7/6IWJWswo61FaVDmRwwSP/nWh20LUk5r3NoMMZAhTTGzlTRvinHr8pXwNufN4QadMImvk/IA4DbdoFG5d+jeYrc57eyErjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga7qcpZz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744334574; x=1775870574;
  h=subject:from:to:cc:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Kw4Qv+/GNKOg5IoscHIxsCfeS37EtCKc3kvUQm4+9xc=;
  b=Ga7qcpZzgzDS5tzAYDiCmivQaiGT9m4MIeI0n4EZua3UbwEPhbymgkBa
   PFJIxEpdjkf2m0snhTDz+k4y3qveIbS2oSIbWAFg3xVIZAj36k7LoSBFc
   ko7mXh/TOjQnCiHiA2lQJZ4z715NvGrRF3Vqena/30XYqY4RTjOcm9Tba
   I+h92FlxfO0T4FX/0+6L9bWAv0K02EYg5U1MjKoqPE7S0AE49PNH0gjab
   c2RdrlsvuzCJKKpTNmHf62VT83nf3P9qnXz59ng4HoiAbkxR9pMiqrJiS
   c7ub4LjkT13Bnec08pig9hNccxpaE54jGEq0kxwFiARLinfSqi1M8GzNb
   Q==;
X-CSE-ConnectionGUID: A48EveikR9CrGIqGKEsRlw==
X-CSE-MsgGUID: 8nGF9aj8SwiUHuDVpcxmcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63276803"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63276803"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:22:51 -0700
X-CSE-ConnectionGUID: /HGF5HOBQ32JMIuZcg0IzQ==
X-CSE-MsgGUID: MSMNWi9HRh+S8qc0sLs+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="160031732"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:22:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 18:22:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 18:22:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 18:22:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMrPjZQxxnys7vhe1aPbz/gUTg2OdEG1Z37HgxlWLvHkL9ulj4dj5lyD2OUqIHMCkTOwESojTVRBs/ogMFshRwoC515zkjhSIsjivUYPnTx6cBMv/0m4J+2sWWzC0GQZv0jbk5ZiWxnEHxIEAabWV3IWGtVV8zYjXkLrA6Aqj3EgCLX4zv/ImTs86qwb9QP+mKBC0p9/qlOTcYBa3g64KduxrsuarrFsXai/b0xCKU6/2ecnmJqWH+vjR27sREGSSUTk4lPI7iIXC4JvpIBBq3S2JulqToY7ylhDZfSEEDVNia3ya5YnaacvsJjKSBm3l+hLxeRxqGnozzRJ/nvjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVOQjH71yzi4/ilwZeXmvuQ96vaousMfc1gqgluF9Tc=;
 b=SmHqzVzER4ZATqbi7CK2F6TpmlbD1jERERoY3/dWtuUrN38W43bKj8BJ1LbDD93ZNQEPyxD7c5Qd9l1f6kYG9SL+3I+oVYkj13mm+8abY5TyX4+k3naGI0YXNA5hWnUbXiHQ49A+3J0oBKHQqK6L7KGlF4OJiI+QldBXhZsbdO8GaDXiQ0/TOT6hprFeieXJjKgAt3qzJ7waCPY7LC2IcoDm1w0uuTdrXS1bgD6ZNOtlSG/DYl3AGlVmaHucGoOkkOnhErdwYPPVLyWGlPeBSXqBV7I5MO6YzwBcwD50TTWKOVwFk2GzkCs1EcfGNvFKs0mvZUliZ2kxSCouc6v8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 01:22:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:22:18 +0000
Subject: [PATCH v2 0/3] Restrict devmem for confidential VMs
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Vishal Annapurve
	<vannapurve@google.com>, Kees Cook <keescook@chromium.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>, Nikolay Borisov
	<nik.borisov@suse.com>, Ingo Molnar <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Thu, 10 Apr 2025 18:22:15 -0700
Message-ID: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: ee33d9d2-e114-4c65-634a-08dd78974cc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDF0Z0VjME1SWmNqVVpzVXcvcFhhMEJRTG9vVjI3ZisxWmFRRkgwWTgwYWg1?=
 =?utf-8?B?eVBVWklzak05NFAwWk5kQmZRMmljZ0pvTzlYTHczVng2cS8zdVljQlZ3SlZo?=
 =?utf-8?B?RFhWMGsyOGtoK1AzTnlMaDlGb0RCTXliY0Q0VjczRWwzWmU3RWs1MmpwRy90?=
 =?utf-8?B?dUkrZk04SCt2UzlOT0ZoS3A3eUliNDc0bkVDVllwZDdTOTlJemJZelZ2clVw?=
 =?utf-8?B?R3BnWFNQYjFDVjR2VjRVb0xHdW5wY0czL3FJSVVjN3p4RTYyOWJGT1c5Nnla?=
 =?utf-8?B?TFRONEZlaEtFaW5ZVXNrMlFlUXgwWVJ5ME11MHhkMy81VE9ZMWI2aE9SNjhs?=
 =?utf-8?B?YmFwNEY3OXpVV2hHK0x4Ym5hMzRZaGZsZ2ppY1RUY3hNSDNZYXU3bkhKYjVm?=
 =?utf-8?B?VUtjRFZTWDlWUjVsOS9rTXdtRjkrS2NkYUUyK1NFVnB6cTNCTGcxNkFLeVdm?=
 =?utf-8?B?elpuTEJyMzlCcDVDSXV1eGFSMzJXWTUxZVpnOTZPeDhLd0JJZVFHUWxGNG5M?=
 =?utf-8?B?RVlJY3hPZnR4ZHJrYTcyUTVPVThMcVdlQzRJNGFybmlRczMwbnA1a1JpTEJv?=
 =?utf-8?B?ZTJLeWdTSCt6azhTMUFtVS9QT29rOWZ1RjJVcEo5bVV2T3FMZHY5V00vNzU0?=
 =?utf-8?B?UGdDNytWN3JJUUI4S2pSRkZZQytTMVZIRlBBTVZEUGtyZEk1ZG9JZDFIWUpY?=
 =?utf-8?B?NWxCOU1UbjRjekNWUU9maGZlM0w1WjY1d3d2OGpPaDRkbFVjVmdvZ2Ntdytt?=
 =?utf-8?B?d2F6RXpSc2JFZVlWM2htV0lETkVGT29ZN0tOWVU5ZG5ibEc5MHB0OHhncW5x?=
 =?utf-8?B?Zm1XMXhSOWd5d0hmNnRsSDllS3ppTnJmZ2Z5VzZOYmFFQzR5c3JwOFBFeFdL?=
 =?utf-8?B?THlCRTNkTjVjaGtuNytZQytjZ05tbUMxSXlRN0FwTExMejZ5R0FaMHlHV2Ur?=
 =?utf-8?B?QlNNK0ZPcndYUmJFalNFNjhJU0dqcEpxTmVXS2JUTHBOTmRic2YwRVhWNkYx?=
 =?utf-8?B?RitERVJycFl1endKdXZXNHNRM1AyZ0wvby9DQlIwYnlCWnFsNXVsdUJnR1gw?=
 =?utf-8?B?MHQ5OE1jK21yQVFZbHBkVmF5RXhiMnFkdVltSXA2UEsvMUFGZGZPWHF6cXBR?=
 =?utf-8?B?dzlIK0V6dWhLZ0NjY3RXVkNGU3RNTzJBWnR5am1kMkZSaGMxbVRiWlVPdUdv?=
 =?utf-8?B?YXJUWWtZRGxDMldodERGL0UvMUpRTFI4TXJtZ1FlUTZKTm50RG9oOXNiWTdv?=
 =?utf-8?B?b1JMb0YvODB6cm1kSzdVbWhHa2RIOWlINUozN3QzaWFxcHlVZmxDcFQ3YUZM?=
 =?utf-8?B?cHZpQno3aUpDaXFiTllSdUNJSUhpcXkvWkJqTm9ZK1I5V05tVEM0YXNFMVRJ?=
 =?utf-8?B?VkhZWWphdUxLcXVjT2pNQTVLVGE1dHJzUlpMSmFxaXJwaXpOSXpBSDdzRk1t?=
 =?utf-8?B?NmFYc3l6Tk9DQVZibzNDYW1LaTlUU0YyNkdISkNRQ3gzVjVPbGF5c1R1U3Zz?=
 =?utf-8?B?K3F0RlVibklhSzR2UUdsczZTTDN2M2x5eVRHRGliUUIxbDZsNlJqWXJxRU5G?=
 =?utf-8?B?VHBQeHo1cHh0ek83MFJNMWtzZzRwWUVOY2k2Mmx1R3V1TzRwN3VIR0ovWll2?=
 =?utf-8?B?L1dGU0NxU1U2MC9lTUNrQ2dDd2kwZHM2K29Nd0pQUzhEcjhBcmxzcFhLZXFL?=
 =?utf-8?B?eUF1NUJOOENxUFhiWnhqTFlYZHo5akZ1cWxLb3QzWitCQjBEck1pMmtvTU5k?=
 =?utf-8?B?MkRabDE3UzhuMFNWWFV5bHh3cnBiRmt3QlU1NS9UaVU5Z3picmFzZ1RxVlB3?=
 =?utf-8?B?L3FtRk9XK25wYlJGL0dZYkRPMWJOSnRpTU50RTZmR3JXODhCdDduWElZaThW?=
 =?utf-8?B?RTBuekdsVEU5TDZPTXQwUC83QjU2UUIrVzlnTEZoeHBSdHFVUDU4aUdhaURZ?=
 =?utf-8?Q?eR/11ndE84nsxnw8VYvnyVAqS0YZJ7fW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUwxZzVMN2RiSFdwSlk1c1o3Q3FrZzR1cDA0S2NnajZPeWFkME9saWx1YmpB?=
 =?utf-8?B?TEhwdXNWaytzaVVTdysxSTZwL2x1bGtTVUhMd0xNK3h6ZkVRcWxOOHNmaXdu?=
 =?utf-8?B?Z1ZVMGU2dWhpNUlXdVlQMzdpeGNML2Y0cmZzTzcrdTBPYWc1Y0hRK2dYV0t5?=
 =?utf-8?B?RlRwelQveHZYaFRrREw5UDVrWFlDMnF2eVgwc3lMN0ZobnBqOWVSWndiNE10?=
 =?utf-8?B?a3ZyVEZvOStEZjUwT1dROXdsYmE0ZEdnU2lvbUlmeVNUM1BDLzlwMTJlWExH?=
 =?utf-8?B?OGJ2UC8yQVhlcENFUzdtbjMxWFNBWEc3MTNzMlFNam9wcnN2TEFuWmROUlNl?=
 =?utf-8?B?SExXb2Y4Zkw3bURBZDNiNkJmQjVUeStBNXJtVXdSR2RDMzFEMHBKUkVkZFFF?=
 =?utf-8?B?NjVEb01WU2Y4N0pWRlhQR2ROUmY0U3NmQ2tXU2d6bitqQUdQTXBGbi9oVzE5?=
 =?utf-8?B?dE96eCtuZTcxb3BnNHh6RnNyYTJqVlNjaUhuU2dwNGpuWUdKZGgvTGdZbVJa?=
 =?utf-8?B?MmdpcUJKUTRadmdsaEZ1ZHhYVEUzWHZuUzVJc05Fb0hiRUVOcUpwcWdlRDFM?=
 =?utf-8?B?OGw0dENlYjl5Z1pPdWNBZWExL3pQRG00ZkVLMXpVQXB6cExJY3hLVEptOUhE?=
 =?utf-8?B?WDUrYWhwTVBOSTNDc2xCdzJKTlRaTURURnFzMTZSSjdRR0JXOS9PTHkwQmtl?=
 =?utf-8?B?YUlpd0FROVpHV04yd3hnWjZvWWpFUkMvWjBhYTd0clBiTE5xTndkeFRBeFYy?=
 =?utf-8?B?QzFjTG5sMi9veDdraXlwdEkxR1dseUlCWHV6dVg3eHFvMDMrRFVqYng3Ukx0?=
 =?utf-8?B?S2xIOEdpSEZrMEVLUjlmLzhrWHNvalY4OGtnck0vbEVTUmQyQkJwK1JOd3lp?=
 =?utf-8?B?WUhncjRtQ3ZYZS9iVDNFODJqWXNlV1B1U3JrbTFMdWFMQUNEcVJGNHVYSDVN?=
 =?utf-8?B?NlpsajNFZVJxalJnVmNRQitEbFBSZUthc05YQktDK2FsTlM4WnNVejBVOXJN?=
 =?utf-8?B?b2RrK1ZEdGZZVnlUZ2ZJbkx1SHZlMzVrOG9pWnBWWG5pSkVFVG9Xd202NThk?=
 =?utf-8?B?QlRnU1pHOHFPeXpWb0VQUEd2QktoZndKN1o1MFdmTndiQThBUDRidnI3R1ZB?=
 =?utf-8?B?UU1sZjRhdWcvdm12TWVBM0IvMFhnbDc1RnFrYURSbElXZC84Zk9nNnZhZW1z?=
 =?utf-8?B?MHlDNDd3UXIrbEZSeENNeC9aWmFSOHphTm1xMExOdEtXOU8rVmZCTmNCYjU3?=
 =?utf-8?B?T3ptaVNya1Zhd3h0N08vc29oa2FPdkwyb1EzMW5qUlhkYi9WNmZGVGxtZHFn?=
 =?utf-8?B?U3pxaUxtTEVzd2FaRk1IR1VvNmV2MUZsQjNiVUc2bWQrT05MQlBVYzYrSjVr?=
 =?utf-8?B?cTBiS0J5TWNzb0VLYXovL1g3WjVIN000d2h1SEgrS1BXZ1ZhNm1kMU5BQWNB?=
 =?utf-8?B?QVhKbnNXMUlkR0JmQ0ZHSnpqN3lDaHpvWk91UDdKSUs0aTV3eUIybzdsQmlX?=
 =?utf-8?B?VEVIQVRYZ2xUNnc0clEzSjdIaE5nbjBYcjNpUnBiZFlHd2dIT25Sd0hyS0ty?=
 =?utf-8?B?OGVoQlJLd2hFRGJjTHBGcDRTL0oxUCt0S0xHeDBqZGhXWXg3TzJCczN2RnBo?=
 =?utf-8?B?VWdpbENCRC8yZ3c3UWRTTS9LWkRiUW03RHNTT216U2hJZzdkOHRZdUhOL29Z?=
 =?utf-8?B?NXhualVGS201OWE5ZXd6U01pS3pFYkdPZ01FaGwyaWFENkpyWVBkN3pMS1ll?=
 =?utf-8?B?cEVZSUFSbXhHZStiM2FnRHcvODRiY1ZnR0J6S0hkS3Z4Rks3bTNSYUtDYndQ?=
 =?utf-8?B?UFFrQTFxT3ZsQkx5MlJNZW1meGUvZE1sWXR4WkRXY0k4YTNFaE5MeFZMTnVv?=
 =?utf-8?B?UEY0STZaSDhrYkdrdkQzckpRWFJVSDU5RjBKVVB6VGFFdjJVeURDY0NyRWVY?=
 =?utf-8?B?U1kzaDhaZVRvRU1PWlUwenJISmVGQ3VSUU84N3V6VHdLY1NOQ2cvUUFQSXFG?=
 =?utf-8?B?ajBsUXJqckM3NGlBU1M1dXRLM0ZYSnhtRUszVENXRWl0NW5hdlpFNldibHdu?=
 =?utf-8?B?bytaL0pDbEZUcHNiUzlaZTZ0eTRlVjhIb043R2hOMUFWUDl2U25IK01GSVp4?=
 =?utf-8?B?SmNZeWlxWU5DSkdnMkE5aG5IcjdOQnFTUVYwK2IyOUp4dm1JaXA0MGgvZVAy?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee33d9d2-e114-4c65-634a-08dd78974cc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:22:18.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB6k7jKTDrP9jWLiHmde+SGzmV9joM0PofVQso/+hFTPol8y4t2lMwkeSoI3WjBOyDrqXiDRAcKrDgoyFVfX7qLue5jlJHJnHXfR2QguuPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

Changes since v1 [1]:
* Fix the fact that devmem_is_allowed() == 2 does not prevent
  mmap access (Kees)
* Rather than teach devmem_is_allowed() == 2 to map zero pages in the
  mmap case, just fail (Nikolay)

[1]: http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.com.notmuch

---
The story starts with Nikolay reporting an SEPT violation due to
mismatched encrypted/non-encrypted mappings of the BIOS data space [2].

An initial suggestion to just make sure that the BIOS data space is
mapped consistently [3] ran into another issue that TDX and SEV-SNP
disagree about when that space can be mapped as encrypted.

Then, in response to a partial patch to allow SEV-SNP to block BIOS data
space for other reasons [4], Dave asked why not just give up on /dev/mem
access entirely in the confidential VM case [5].

Enter this series to:

1/ Close a subtle hole whereby /dev/mem that is supposed return zeros in
   lieu of access only enforces that for read()/write()

2/ Use that new closed hole to reliably disable all /dev/mem access for
   confidential x86 VMs

[2]: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com
[3]: http://lore.kernel.org/174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com
[4]: http://lore.kernel.org/20250403120228.2344377-1-naveen@kernel.org
[5]: http://lore.kernel.org/fd683daa-d953-48ca-8c5d-6f4688ad442c@intel.com
---

Dan Williams (3):
      x86/devmem: Remove duplicate range_is_allowed() definition
      devmem: Block mmap access when read/write access is restricted
      x86/devmem: Restrict /dev/mem access for potentially unaccepted memory by default


 arch/x86/Kconfig                |    2 ++
 arch/x86/include/asm/x86_init.h |    2 ++
 arch/x86/kernel/x86_init.c      |    6 ++++++
 arch/x86/mm/init.c              |   23 +++++++++++++++++------
 arch/x86/mm/pat/memtype.c       |   31 ++++---------------------------
 drivers/char/mem.c              |   18 ------------------
 include/linux/io.h              |   26 ++++++++++++++++++++++++++
 7 files changed, 57 insertions(+), 51 deletions(-)

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8

