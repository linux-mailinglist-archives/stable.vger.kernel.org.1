Return-Path: <stable+bounces-141936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E7AAD0B3
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A53A2662
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8C021858E;
	Tue,  6 May 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHAezK6v"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB31922D3
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568984; cv=fail; b=T2h4UbWv8RQetJTgrWeSvuwr5nLVAyJNccBwmHDkevoCCYK14nIPff/2BdVCYVWLnaNlAnABxeHig0BPCQX12cvo5bdeuXglis04YcOBowJmkki4lppbEXqNNQUOY6HqFWlwdoCR7EvQ+DIpX/dK2tvYGIZmuKRppaxpJKP3h+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568984; c=relaxed/simple;
	bh=joEdBfxE9w6TZ6FuDl9iKqg1nJQhq2+YQfnM8gav9qg=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Eb/gV2z5eVFPoTkxq4Tm1pmwmsAqIqI3XYvyAYVwRhn4WWmuqmNDQPLkzyqzOpvj5HxeYvyeOWKN1sYyWgSIexCJDjjnmo7wvjCJmHd8fGRebzeM7KvBQnYctqXw0bmftRTFZ8eAq+oDwIN1mwXwR/Y3C4ps0dBVWYva0csfkvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHAezK6v; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDjapS4SBDhG9j8u09vIgQT9BkXkqI1PezHlRSaTtqohM9lE9skyXONQqAtPh3nEuUIxe7mqIf1QPeqwpDYlpFdlETijE83Th7pyWDus6vfMDRgkpUAVrnyP4bNsV9RUaWJB7j97OeYepr+llLJlKEfw6qVgwMo/nzw3ovyCiVBVS3wIHMhPIxzla5TYxk6gB+hRUwvPBhqHITFhsrHAFjcy39TDQ+Z5XVF6rxTdlizALyk4GzmP4yMr7qM/6cMwAKWbM19N5UyfJCWaI2iaBsIb2InR+wSDFdt1JgaP2/ZKUuu4VLFlj2UDj0WnfGAMw7gwEgE5MpvYphXz5q7rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HAE2NLJCQthavwU/BboKbFpp7O+NST7SuHlEdWNMPk=;
 b=k7AmrmB3nPOQtd0LM3LTg3SbnhkHNbLHFF/drMa2Yjx2daiEA2JoWlUk1lj20HRUIF0QTk4edHeMpDDCg3qcHCBMihVZ3IWiRwPzgCGDHjwMMldmgnt9zW73nPfZESu4iBB0sqyJYVjfdGNw1/xSX2clvjyM8UiMuwtzq1pFekqlUGrEC4E2nMzp5fFNhAFszRcWSkWuVI6s4jNqrhnvJEll84XsFcMIq+03ov7eRlXb36cBt/9HSn6/eiaKkQXYwblIWp7Z+jtVELnDtDrr7kAhw3Jy8zK1zOGL7OBYObceAf8k6gVuZh+DT4WGmODf/Gb/8A7Mgf/H1vrdeo2cTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HAE2NLJCQthavwU/BboKbFpp7O+NST7SuHlEdWNMPk=;
 b=HHAezK6v/w3QbsFIHoUwYamYiZUSQKOIXdRN7YVN1RbXGXtfj5z+mMb9H6spylUzYbWSq/ss/MFUZcJaxvZW5Ery602IVt+OLrWBXUGhO4a9gca4zbdjXpjw2JaYfo0hj9hI51JlnsotNXmn9AqAJgvdB21SY37PzGo5eBSKigbnBS4IMYcgZEywoyfvR1xjv9P9G5O1db0oZZqlSYrRbw8ZjMD2R2BbLTWvobaHQwmowrSuKexU0l3RlAbH7EjUaYrnc57/18SdNpOe41gqRmrdTrLcqh0e+pT29Jbj9zscuKxGDa3z/s7FCERa7Tf/CBm0bt5r78zawNKbZG4auA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:03:00 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:03:00 +0000
Message-ID: <f879b0c5-7b17-4259-9b63-5e6def883dce@nvidia.com>
Date: Wed, 7 May 2025 01:02:54 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 3/7] ublk: move device reset into ublk_ch_release()
References: <20250506215511.4126251-4-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-4-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b65ebbf-f7d1-4979-aa75-08dd8ce9c3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmZxRzByMnArTFhPdFdiSjRnNnVBbWFPRkZlYmpDZEFSOGFDdVVvSGJydUx5?=
 =?utf-8?B?a21DeWtzNFhaRnlCYXdxbEZVcFpNeGF5T2lYQml4MjF1bXVOd043d3M2NnJC?=
 =?utf-8?B?b3JFMDJxOC9CVlBpKzVzSUZoeWFJYVhVWi8zakJKTXR2c3RFbDNVWU11WDZC?=
 =?utf-8?B?eEZSdFBDRlUwUWZZb1R6MkswcXFkUVVLdWpjRXJxYk5GSjY5OGRvNEp3VzBX?=
 =?utf-8?B?dlhDdUFjMmdaZzB0SkRocmorME1seGVMK3g1NVRJUUJRR0ZmL1kwcE5YdjBm?=
 =?utf-8?B?T0hWTmJuTWxsTVRNZmtjSGJMcDhQRFBIaENNU1FJTlowVFdvdGhtRTBIN0pC?=
 =?utf-8?B?ODFZT1FkZ1JSWDhwd0FZVi8raWIyajJsK0RldzlEM3Exam1sSkxrVDkzOFBh?=
 =?utf-8?B?alVKcXZxSEpuY0VRRDRQQkthalN3dU1ad1hZRXZUSGxuaUR6UnZTM1NJb3lJ?=
 =?utf-8?B?QUNWd1Y4SDZWbWJVRnlaL0gyMFNPaEc3UStrMTZ3WXkrdkswajBFQzRmN0hi?=
 =?utf-8?B?M3RXdWJtN3kyZzJjVXkwOUY1bkZwTk5TY3lhdGlNeU9RaTVidy9hTlJINUtC?=
 =?utf-8?B?RldwMGcydUM1NmZBK2psZTljVDZreXRuZ251eGpCVVR3Q05PN3IwNGxqYXJq?=
 =?utf-8?B?UGNvQmtaYnc5S2pEMzhOYTZmTkNKb0laTGZyejJ1WGg5K2VCMEU1WTAxVDlo?=
 =?utf-8?B?b0QyMlFyUXFJRjBEeWVLNVBUbVRDa3BRRWhqOWJJTDVRakVMT1ZTMXduc0ln?=
 =?utf-8?B?cERnd2cvYXZnblBKTzJYZDhuV2Y5ZURINW85Uk81bmIyaStQaG1hR2N6SmVt?=
 =?utf-8?B?WFBkT1FRSGEzSkNRemYrZFRBZGVwZG9iSFJYRkR5dmplTTVlWkRzL1dTMjJO?=
 =?utf-8?B?QUpZZjJ3NXhRRU9qcGFVNmVMLzNsOGk0THdSNWtoaHp3eVZ4WDBmVmNsUCtN?=
 =?utf-8?B?Z0haUWZjRUxhT1luT2NkYTh5cUNYNVlRNC9mM2gyT1lXV1RSUG40SDN6UnU1?=
 =?utf-8?B?MWk1NExCMjN0cmdTQjkzL3RTRGdzS0cxNXpaWVZjbENHRThud2ROZmN2aElq?=
 =?utf-8?B?dHFBUk5adnNUZkdhekltbE83RE94MkY5S1Q0UlV1M0lNaWpoS3lITU1OMGt0?=
 =?utf-8?B?dEhreHJTVkMrdjUzelY3cHNiOFpaSTZSeUNmZFhwR2g5RnRxdm13UUowL0Vy?=
 =?utf-8?B?UHlWbUF0Rlltek9oem1LTlE5VWc3YmRJVDJkZk5zdUhTTkJiTkI1dTZqY0RD?=
 =?utf-8?B?TG9HRmVGc2hRQlhGKzE5VGN0RmZkczI1N29kWnMvOGV5USt2SDZKY05sY1dM?=
 =?utf-8?B?eWl0SzRTeFo3NUl3YUdkenpRTE1tL0dNRzdoNEYrbDJ1ZWg5TjdaRk5meXdX?=
 =?utf-8?B?WHZpQllUWjI2cUlpME5Sa2NLKzByc21OQ3NJdDg3d3BWc2hUMXI3Qm1aLzlH?=
 =?utf-8?B?SUxsUU42YlUycnVSVU5EZklYR2I5WnRUTTNmLzVBVHJ6REZGaWZNUlFQUUpY?=
 =?utf-8?B?Yk0rc2RvaUJreExXQXhDeUNPV2s0NnF5MjRJTVU1TlZob051c0lRVDV2UHFC?=
 =?utf-8?B?bEt5REZJVk5rbE15VXdPV0tERU1XYVFYbEdUbDR0OUZ2VVFXQy9OQ0owQ2Vz?=
 =?utf-8?B?TnVnTUR0M1ZvMW4rUGxDUGE2WFA2Vlh3N2xhdzBwT0dCVkF3b0VMTGJhbGJx?=
 =?utf-8?B?byt5Mm4xK1hBbWdZdkJGNmIzMStWR05NUzNvK0labStTTnFkMXFOSjRBdmxM?=
 =?utf-8?B?NzFqZ1creFMvWTFXcTZwSllIK0FCbmt2ODFRcUowV2lYMnpid05UTG53Uktp?=
 =?utf-8?B?N2I0azQvZlY2YlIzREtpRXRLSVVGazMzalBCYUg3SGFYYUdvN2FZNy9Iektx?=
 =?utf-8?B?Skxvd3crT1VvdncwV0lDVE0yUEF6a2twSjVXUGlhRDhJNS9XTUZNSEdnbXM2?=
 =?utf-8?Q?oQfdmbBeRmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW9DWnNLdnNyOEF1VHcxK0ZaejdUYS82aUZtYW5BR1VtOEpmS1I5WUFwTHNB?=
 =?utf-8?B?eS9NclluYk9kaUcwd3Z4MFBpWGE5djJoVC9zbGV3NnR6cUJkamNXdCtHRlBh?=
 =?utf-8?B?cU1NYjJwZVpnRno5YzhsejlnYlM4TEhBSHhXb1ROdFczQ1p3L3VPcitUc2gy?=
 =?utf-8?B?WnAyVWZSN0lUVWFVSDk5MjhVY1RXYTFQYVNzbHBPeFJXbXRCVmlxWUVEaGpB?=
 =?utf-8?B?L2JQb2k4dUU0cFZwdDZlRThFMXRBWjN3U21RaVExMHJ4eE9BdXBUc0ROYzhE?=
 =?utf-8?B?WUhaWVVQdGlVTnpqWGd2MlV6dTRYWHJvbjFxWmZWc0ljUXBoeis5UlZvc3NF?=
 =?utf-8?B?Z0tUWWJIbFR3cEd0U01weEdmOHN2ZnBiYW5VWXo5V3BDU1NXVktuWk9UbEhi?=
 =?utf-8?B?cThzdFlrRU9BSnoxR2Q0QkVpNnRLcG4xOVFzYm9LeXE4aVFCUG5PMUVXSFUy?=
 =?utf-8?B?TzhBRkplcXVVbEpmZkdTNmpvNW10Mnh5SWxKSDFZVVRpcGlMdk1QdVhwckVa?=
 =?utf-8?B?akZjWTdtdnF1VXV0T1BTcFRLeCtPVkNWTktaQ2J1SWlGemU3YkNBaDJZdlR4?=
 =?utf-8?B?TG9FcDkvV1ZiZE9iL2k3QUVzOWlOOWpGWGswUXFqOVN0YUpIVVJIN3hHYy9R?=
 =?utf-8?B?SmlxUlZOYkcrMFlXNHF2K0MwSXlQUFpxTWlTbTBvOXBjWEcrZ3htZ3pldXY1?=
 =?utf-8?B?WHI4eWgrVWhzbU1QT0c1OVZjUnBkd0oxdDZZU3E5NFVadXFHMlY2TlFqOUsy?=
 =?utf-8?B?TlBqWGNaRXlWeTZoVXV2SU9rVnErT3l5UzY0ekkvemVkTmp1VUVwcUcwSFJl?=
 =?utf-8?B?dlhvam1vRmNEQnlTRFpqbFFSYTI0SndaTldKSFV2N2k0RHpMclJna1RDWlRN?=
 =?utf-8?B?LzdRU295dktGd1M3WGtlbWtsN0poV0t2OXVTMFgxbVBvempuakZ4cUs2MHlO?=
 =?utf-8?B?NmUwdGZieXkrdkVuVGpMZjJSclF5d2ExMmdtOXdONjl2L3RPV1BQL1BkSXgy?=
 =?utf-8?B?NmJiOGtnL1pVQlIzTjY3MGxhNldVL1NPaWxQTytlWjRkSmJtMmFhbEQ4eUlL?=
 =?utf-8?B?azZ6T2p4ZC9LVTVpYXFDd0lwSHNOQWFKa25HcjJIWVhDZUJDZE1POHVqVytG?=
 =?utf-8?B?SzhZaXFqL09VdlBuWlRzTFFvTnFrcDIrZ24yUkZ1Rk1zYjkwZ1Q2dnN3RVdu?=
 =?utf-8?B?aFlUZ2dZY0pteWdvR0dNNnJlY09OaGV0Nko3VmVWOW9kU3JsYm5rSTNvUVNu?=
 =?utf-8?B?SVB3TzF5VnBuSVNlN3NsZEpIbXBYWmlYWjhDQmJjdm0rcU9VOXdUM3piOFdo?=
 =?utf-8?B?NFVSK3FZM0NHS1ZEN3hZTS8yTWxxTHZpOW8xSm54MmEvK3ljTjNIM1RGT3VY?=
 =?utf-8?B?aUVUcXBVVjVXeHJlUVNheDUrOHpUYmkwS3Y1dXRKcjRqV3BFdWVORmVqQWhS?=
 =?utf-8?B?N2N4cURtRTNWYlo1SUw4eS8yM1FpcktOWVdhVFJzd05FUCtzVTIyQXBubXFP?=
 =?utf-8?B?b0d1THdOc0ttNlA5VGxSL1d4cGpYcjBuY0tCUU5yOXhjOW9PUURvWjgzUnhO?=
 =?utf-8?B?M0V1ZDNyQjZ5dmlhODI1VzkwTmdRQWtxRG1Kb25HODkzRXpscnlqUXQ4VjJ0?=
 =?utf-8?B?SVhwZWpobVJDL09uLzl3Si9ldjNzc0d2Y2QxQi9NbWgrZHVLYzAzN2x2QS9Y?=
 =?utf-8?B?R3FVM2JjUE9leXFnYTRDTnAzd0xrYWR5ME9QWkpqeDA3MlVqNHpDbE9VS3A0?=
 =?utf-8?B?Z0g3YllaeUhzTitRMUhBMklKRDR5dkhVRk5oV2J1MEpHQytXb1RTdEVtallT?=
 =?utf-8?B?VWQxYlkva2diR2NEcURQUDVhL09zMW5raXJzMHgzZkVZVWhlNkcxVm5sbVph?=
 =?utf-8?B?OFN5VTVUMmdsd0lvMlNFU2tzM3diV2hjMmZBcG05dUdwb1dCUUNxa0JMSGIv?=
 =?utf-8?B?eXo3SmcvOUpCTDlhZk10VHFmTTA5ajBMaFltWktMSGJGT1BYVkhQdFZqY3lQ?=
 =?utf-8?B?VzNjd2N5cloxWW4zVXp6NWNESFpJdFhKQ0ZlUkh1QnVXUFZBcENYSm9jeHYw?=
 =?utf-8?B?cE9hU250bzFQNnM1ZSsvamNESE12S0RKem1XUU1BRDlOWFJsL1pZeksweFd5?=
 =?utf-8?B?NTZ6SHdRSTlYZDYwb3k5SlQ0dXZJSzFRVllRZ2JWY1YxejFxV3kzZkV6RlN6?=
 =?utf-8?Q?kikPP9+YZnv8R299yAgwew5Div2Tj+2monXi1uxRHDT1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b65ebbf-f7d1-4979-aa75-08dd8ce9c3ea
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:03:00.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ6rqUAL/lp31X5Aw2TwTULWjuEBSmsCc1tv6pwtNSCoEbA4STNyRT8//CTreWmuDni4Fg5BJBoDpmkh+VHE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Ming Lei <ming.lei@redhat.com>

ublk_ch_release() is called after ublk char device is closed, when all
uring_cmd are done, so it is perfect fine to move ublk device reset to
ublk_ch_release() from ublk_ctrl_start_recovery().

This way can avoid to grab the exiting daemon task_struct too long.

However, reset of the following ublk IO flags has to be moved until ublk
io_uring queues are ready:

- ubq->canceling

For requeuing IO in case of ublk_nosrv_dev_should_queue_io() before device
is recovered

- ubq->fail_io

For failing IO in case of UBLK_F_USER_RECOVERY_FAIL_IO before device is
recovered

- ublk_io->flags

For preventing using io->cmd

With this way, recovery is simplified a lot.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-5-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 121 +++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9345a6d8dbd8..c619df880c72 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1043,7 +1043,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
-	return ubq->ubq_daemon->flags & PF_EXITING;
+	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
 }
 
 /* todo: handle partial completion */
@@ -1440,6 +1440,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* All old ioucmds have to be completed */
+	ubq->nr_io_ready = 0;
+
+	/*
+	 * old daemon is PF_EXITING, put it now
+	 *
+	 * It could be NULL in case of closing one quisced device.
+	 */
+	if (ubq->ubq_daemon)
+		put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/*
+		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
+		 * io->cmd
+		 */
+		io->flags &= UBLK_IO_FLAG_CANCELED;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = container_of(inode->i_cdev,
@@ -1451,10 +1482,26 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_reset_ch_dev(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	ub->nr_privileged_daemon = 0;
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
+	/* all uring_cmd has been done now, reset device & ubq */
+	ublk_reset_ch_dev(ub);
+
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1801,6 +1848,24 @@ static void ublk_nosrv_work(struct work_struct *work)
 	ublk_cancel_dev(ub);
 }
 
+/* reset ublk io_uring queue & io flags */
+static void ublk_reset_io_flags(struct ublk_device *ub)
+{
+	int i, j;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		/* UBLK_IO_FLAG_CANCELED can be cleared now */
+		spin_lock(&ubq->cancel_lock);
+		for (j = 0; j < ubq->q_depth; j++)
+			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+		spin_unlock(&ubq->cancel_lock);
+		ubq->canceling = false;
+		ubq->fail_io = false;
+	}
+}
+
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	__must_hold(&ub->mutex)
@@ -1814,8 +1879,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (capable(CAP_SYS_ADMIN))
 			ub->nr_privileged_daemon++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		/* now we are ready for handling ublk io request */
+		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
+	}
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -2866,42 +2935,15 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
-{
-	int i;
-
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
-
-	/* All old ioucmds have to be completed */
-	ubq->nr_io_ready = 0;
-	/* old daemon is PF_EXITING, put it now */
-	put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		/* forget everything now and be ready for new FETCH_REQ */
-		io->flags = 0;
-		io->cmd = NULL;
-		io->addr = 0;
-	}
-}
-
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ret = -EINVAL;
-	int i;
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
-	if (!ub->nr_queues_ready)
-		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
@@ -2925,12 +2967,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
-	ub->mm = NULL;
-	ub->nr_queues_ready = 0;
-	ub->nr_privileged_daemon = 0;
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
@@ -2944,7 +2980,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
-	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -2964,22 +2999,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = false;
-		ubq->fail_io = false;
-	}
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
-
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-- 
2.43.0


