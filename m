Return-Path: <stable+bounces-91786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380889C03DB
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2282831F5
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A341F4FA8;
	Thu,  7 Nov 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2I8RgXCr"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA71DE8BF;
	Thu,  7 Nov 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978760; cv=fail; b=r29mmcbas7Q6CIIteYEvJHyIjIyULAFDNFXw1pBVOiCFuBZxjTcba5fSQX10CLPcYsNVz6QXboseuh84OYrRGSquVG+7LEZOV8yyeqVxIwGJDfE1paOlizCUOXfBAgBDnVjhuk9QBzrBMiwQzYHZtHCeSzz4/q5SDl9yaojEZeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978760; c=relaxed/simple;
	bh=3lpOchSGvoCQAdaopCT67+BqI6X0W+t7X1J3TzBKfD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQ/8KTUfRM0XR4Pv1BAKq0DwI6c5Ds3PZNX49n7SnyZj8M2DH+Dmku39QlygkXd8szWNlWDQWsV90amNGqJO6WtpZaG9u3q/KjQo9LPdn6ZvlYHetWIHMkXvDXHyLeB2yCGUY3C87r/q4PKoEIHdYq5ZtZvK+koKkysKM4flAUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2I8RgXCr; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2o2ppy/D5yZuG7P7OSGPcdGEuHdjUdPBJO5wrx3eupGfNpp5h1H271/ZtAdf/TizjG5XxImY5CwVr4VHQoGeJ8X1gb+AUpAVMo9fjrQrVFWyLueRb01KzUAZ2khmb3bgNbh7dY2Mq3wXB6J3GTloA8sDdy2AUU31LwivbM7wBCL515U3BFveprUMUOLLozJrSeYyHLgKCiCUttol2pt+iLcBmd5c61BelckuQJkVUrGAUHlJU2ElxhCzXz7xtmkTChI6U3CV4ysTN3oN0wQ6kei2ltzCfCl430Pc0PDnXn9j1k0e54mSvpNoKbiaw7gp0gjRUkoVbx8sOEUZjHwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpMT8G4C3wy49dsuzEvSp7i94pAq/A5Y5M5gOgfcpK8=;
 b=VaZW428YLTz/n0Jj0azXTHpgQRpXLRGe69bKcjBY9XA/cs6fVJNLvibastbSI4VKOvVTA3gqLlrn2cUvBPTUUFi7gqVopIBZDI/2HcJHaWVeusYTmXYHK1uRj26K5Amj7en7PyQlo6xoka+YLXeCf1ikzB+KdvxnzwwHB23VIWpLunSRJat9mYbkeMiej7lJmbipxbS359be+1edDRy0IqcX8lqlMMnsN058G1BnP/XEPIPD7vVfP9xbwGlDC9uMHWAzU08nhRueRSUvUHd2olPYa6auhwVAlGcgtLBqu0zeleY9iMVfSHFFDqH+gvr+zrmrTrZpRDeFK7s01UHdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpMT8G4C3wy49dsuzEvSp7i94pAq/A5Y5M5gOgfcpK8=;
 b=2I8RgXCr13PchH/6ZcJgf/TO4QPpG7iScvrvONnss9lXi6XK3ut76nmEzSKrpUx1xxi3FVaBN/OSI5TH2xg0yFJ0aVcR5RnfsQu6owIVJfGgRDc7DMjQV3tnq3A1zcbEbvLij+KtVJxTIYXhphDipkbI2uh/GKxx+spodTqkctA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 11:25:56 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 11:25:56 +0000
Message-ID: <29815488-2ee8-b7a4-8454-45c3b37e5c14@amd.com>
Date: Thu, 7 Nov 2024 16:55:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] usb: xhci: quirk for data loss in ISOC transfers
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241105091850.3094-1-Raju.Rangoju@amd.com>
 <9265b40f-b803-4dd7-b6df-3e8cb510b07b@rowland.harvard.edu>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <9265b40f-b803-4dd7-b6df-3e8cb510b07b@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f72793-cab0-49d2-4992-08dcff1ef292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JWbWN2clZDWmdVRU43YSs4R2NyK21OZkZmRzZobVU3YXVwRTFmMHRwaGk2?=
 =?utf-8?B?RmFPZnhnUzZlbE11SWFwbXhqdm43SzVwZ01VOG00MUVpQ0tJcTE3Ri9ZeHR5?=
 =?utf-8?B?TlhnaWRWcG9MYlUzOXgxZWhHOE5Vd2tZU0JZNEltZUVpNkFON1ZPbXV0MEdD?=
 =?utf-8?B?Y3lJOXNTL21KdXF6TTBYVisvc0lQazZPenpyQlNOZjIyd0pSUDdMdzRGeTNs?=
 =?utf-8?B?NjFkRUF5YVFQTFNUeEZqaS9uK2dQSHJLY2tBTWZIZmtLWCs1cFloSC9tNGhU?=
 =?utf-8?B?STY4ak4xMDk2YXBMaFp0aDZTaURSNnZjcWpMVmI1WE8wSmw1TzBuWmF4Smx2?=
 =?utf-8?B?WTBaMUZBclptbTB1endpY1VHUXo4WmFQNTlZdHRPRTk2M1dGRkNoakVGbEZu?=
 =?utf-8?B?L1BoajNZcUlSRnlYR2c2OEdhZkxFMGlZOUV4eFV4bnRDZThheS9iRnBkOGg5?=
 =?utf-8?B?bmV3QUlkVS9SZGJSSlVHV3dRMHdCM3lyYWFIUUpPekJPNEhsYzRpQ1NiNldW?=
 =?utf-8?B?ZVdKWE1lOHB6cys3YnBCcEV5eVY5U3hpT3NFcTdKQnE2UUtUMkcrYWN4bnRK?=
 =?utf-8?B?QUxVbWtTUC9qS09YZUw4T3M4SERTcW1Sdk1ZMjJPL0lEajZmeUJKQ0ZVdnhs?=
 =?utf-8?B?WXlZbVQ4dUNTdktUOVVMUXJHOXlIRW03cXE4OHoyWW1pMWsrOE96MzdibFdr?=
 =?utf-8?B?dFFpZEcyaVFETkQ0Qys5Tk9PdFZRSzdrbGYwS3g1U1o3cFFuMzlzUjZMMktx?=
 =?utf-8?B?YllxRXBUTXdZNUFxU2JGR1BPdW9IMzQycHFvMDhPdFNLdGhZc2Z0T1huUzkx?=
 =?utf-8?B?d0RXd1VyZkE5VEx6aFlqb0t5TU51NDhkWmlzcEd6cFVROFFwYjNMZGlBTVZr?=
 =?utf-8?B?T0JjYXJ3OUoxUURzZFBLOWg4c0tMVTloRFRrV1FDdWl1Z1BBZnE3b2dRaEQ4?=
 =?utf-8?B?bzVMR1ZsSE1RRDI5VGh6MnBUQUVJbXJyYjVWRXVueUFsakM3WmlXNExHNkNO?=
 =?utf-8?B?RmJzeGZmditjL0gybUhyb0lQelJxOVJjVkRyM3MzT25jYzhJeFFyRStuZGZO?=
 =?utf-8?B?SEwrSEtZdjI5UUhqbzBYZUR4RmlaWFI3UmNRU0pDMUYxUFUwYmNQVytaZE0v?=
 =?utf-8?B?Unl4VUtRc2xhNG5INUp3aGtrb0hCYWFTUE9DOE9XWXVidHBNa2FPQmF2amdJ?=
 =?utf-8?B?YjNUazhpYmJiRTFMODJDalNwOTU1QnByT01iY2EwSlEwN0N6QU9Mc3ZxV29K?=
 =?utf-8?B?RklxSk9FdzFvaVpwNzZKd3h6TzBoSFB6NGlOL1NJNGpXaUNGWnFLTUdYV0tT?=
 =?utf-8?B?TytMcE9XVVExWXNDcDEzN09hdHVyd2R0d2I1OUxXcy9pNHhJc2VSdFFnRlBY?=
 =?utf-8?B?eE10RktUTWlQQXZuaE11cWJxc2pYTXUxcjNSb3lZTWkyTkp3ZlJ5NHkzYlJR?=
 =?utf-8?B?MU1tZDhDY1Z4emR1U1ptZktCRDZJR2I4dVRmT3dlVS83emlkcjJuMzB6cHFC?=
 =?utf-8?B?dm5EbjlyM2F0ZWExZCs3bkp0MGFpUVozaytUUmxGcHgyUVB5YURFOEoxdEdL?=
 =?utf-8?B?TEtqdnEwSUNXbzhyeEpacEx3ZFNUTzhTZlNUdnRtVkY0bHZiMmFsNW9INnhB?=
 =?utf-8?B?aGpWaVFkZWZBRkpTb2R3V1NNWERPcWNsNXdKT2RUMHdqeVIvQ1N5RGhSSnJ6?=
 =?utf-8?B?WHlrdDNJOWhwVHJrMTJYa3hXa3F3R0paUSsrZVlhYUthZ1YrZXpPVjhudW11?=
 =?utf-8?Q?fr7tupAliSitdvfKdMoVPBNE6utXDPFuIGRj+71?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFJkYUw3Y1dOVC9LWlFodkVKMEtjUDBSenowb0Y1bG9naGcwSng5Mzd5VjhM?=
 =?utf-8?B?S25vQmlPaytiditNN0FPbW5QVTZiYlA1WDFJS1UxSmYwQTR6dVFWanBqR2tm?=
 =?utf-8?B?UE5OTWFjSlpKa2poZXkwMHF4NkNzTzdPVHNFdy9paVlpelhnUE5OcnNtMHdY?=
 =?utf-8?B?K2dHV0l2VWQ5dHhxdVNsemg5amtTM25KdG0xRVppYmhSSWZ1c2NPODNCQjkv?=
 =?utf-8?B?b2J1cloyMzVjbjRQUHh5dWp3a1VCYUVIOWJIOFlPbENodHpMVkVsejlGd0ll?=
 =?utf-8?B?ejQ5UkVBNzVZQ1grSjQySUo5MkNsL2hwUWNBY2hRQ2hFSzZaaTMrQXdCN0Iw?=
 =?utf-8?B?U05TMkZJcThCcGoveklYR1dvbmsvbzVWUC9FeTVzM2ZxcVlhR3FFY3JZZUZ4?=
 =?utf-8?B?SlNQVktpRndVQS9jVTlrbFBoa2c3YWo5bDNZNmtGTU5vTEVOVVl6dWRNcDI1?=
 =?utf-8?B?WjNhaXNHbzlQUGRYTTRVck9VMnR0ZTFHV1NBZEx3QnlvbWhGT3Via2JRempJ?=
 =?utf-8?B?OEN1MUV3TDNTMjNpcGJpVFJkdml2ZU5pcFZBRWM3ZFVRRFNhc0JqcG5MRmY1?=
 =?utf-8?B?TENlSXlHNUFBWnJTWEtkTCtKcVp3aXRJa0luRjdmM1drMzlOMzdmSlRvb1o1?=
 =?utf-8?B?b3RwdmkxNGszV1pPU0Z2RlBNVDZiV0IxdjFxZkdieTFmVWRuRDBqZDdaTUEw?=
 =?utf-8?B?M3FjWjZDQnZkWkhRQ0YxVzR5azdtZG0wMElhUnUyeHFvWjZLWDI5eGZlYUQ5?=
 =?utf-8?B?ODJ4dk93QXlwdWNGa2hpWVdlejh5ZE5nRlpjZlN0TTBqUWNBdmxNK2srcG1w?=
 =?utf-8?B?eDhnQkpFbWlWZjIyUmU1cTBpNEh5MHlsbXcvSmxVK29qQkptMG5iTTNBREZx?=
 =?utf-8?B?MWtOd1M2OEJYTndjL014djArMURJajd1dWVSRXFlY0F0Mzl5OWlLeFoydDBn?=
 =?utf-8?B?Q1NJN0czakdaZU1jRFBXTHppem5nVStBMTZJa2JtQ3Y0Y3ZINkhLdEd4NXhz?=
 =?utf-8?B?NktYUUhuRVhPTE9NMmN3L1BNa2JVdXYwM1cwQWpONUNPMkcrVktNTVpCL3lW?=
 =?utf-8?B?bE9LK1dyWDdkOElzMGRIK0pQQUh3Q2RhclpiWm5vYzRtNHRnMEhDSjZFaUpM?=
 =?utf-8?B?TVNwUzVNQmd6ZGNlNk9RekxPZzBSYTZaSktXSkNibmJ3RHlmKzFtdXoyQy9N?=
 =?utf-8?B?M29iZ0Vvd0h0QitMZUxJZnZ5QTFLbEM2Q0RYeWFNRU1xTkVqU2Nac2NMVTRM?=
 =?utf-8?B?MWQzclN6YnBOQ2xqUWFMOEZHRVd4eXN4eE1CVTY2RGVuUlNNWE5YaFMyQ3pk?=
 =?utf-8?B?NjBUdU5mY0tmN08yVnVYWS80a0NpeHNGaGEyZlpHMnFuYms3WDhtWXJaTGFI?=
 =?utf-8?B?bE5lSjFKcTJrajZJR3RSNTkxa2xWYmU2TGovcmxHZ203b3p5Ni9WQm9CY1hq?=
 =?utf-8?B?dzBnV3NIZzVvdHNHVGNnWlliUk00elZBNGxkWGtIVTNCeVZQcmJObURTK3N1?=
 =?utf-8?B?MFRRTFhTa3ZSamNsdnB6RVhHQllSSUsxV0tiS1Jka1RaeWQ3ZzJTQ0JDRXU1?=
 =?utf-8?B?c2JSVk1DMU55a1g2cy9yOWxRMG82Sy9PdE5oT3ZYZE03R2NKZWxjYURuYnJK?=
 =?utf-8?B?WG1vQWxabHZWT1VDc3NiaW9vTElkMnkrS3hyMk0zcFJ6Wmt3ZG0reGcwY0xo?=
 =?utf-8?B?Q3hET0lNRmp2QnVpeGJybHg5cWpaRlVSem9lNHQxMzM1MkwvQVdqMzgyK0NN?=
 =?utf-8?B?L01jZjVWRGNpYkJuN3Jqay9jeUJtUlBRaCtQSExjRXpnQUdtNjhuNTFjMnhK?=
 =?utf-8?B?V1puWjZ1S2pZYzdNQXgzTVV0WE9zTEJNaUdSQTRYejZQQ29RcXR0YjlMbHhw?=
 =?utf-8?B?VWJFYkFidFN1L0JrOFE5NUZRcFZXcllBdnc0aS9nMFVFUmROTkUrbjA0WG5K?=
 =?utf-8?B?OVhWd3hXZkFNcld4b2MxNmx0d1JNeXk5RmlRNVR6dE9LNG9SUERSalh4UmZS?=
 =?utf-8?B?OUtLaGNQZis0TGlEN2t3NDJUN0lrd1IySmZzYW1RcXlqV0lCWDRic0lQNVlw?=
 =?utf-8?B?Q1lQY29qYVVBYW5GY0liL0h5bm1CYVhvenNVbEQ3UnppZXJKUFNVMGx6d1NC?=
 =?utf-8?Q?5yDAIg9hcVZ85LjMYvwVkOYMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f72793-cab0-49d2-4992-08dcff1ef292
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:25:56.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pitOOdj2KIlV3VnxISbnnlfi+kFN+0kDYvZI+JAk5N+OyfKEkf7eGsYIBK4fwDLkCyQqX3Wlm0d6DyjvEZ0fbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070



On 11/5/2024 7:43 PM, Alan Stern wrote:
> On Tue, Nov 05, 2024 at 02:48:50PM +0530, Raju Rangoju wrote:
>> During the High-Speed Isochronous Audio transfers, xHCI
>> controller on certain AMD platforms experiences momentary data
>> loss. This results in Missed Service Errors (MSE) being
>> generated by the xHCI.
>>
>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>> being omitted from scheduling. This can happen either when an IN
>> endpoint with a 64ms service interval is pre-scheduled prior to
>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>> endpoint is shorter than that of the IN endpoint. Consequently,
>> the OUT service is neglected when an IN endpoint with a service
>> interval exceeding 32ms is scheduled concurrently (every 64ms in
>> this scenario).
>>
>> This issue is particularly seen on certain older AMD platforms.
>> To mitigate this problem, it is recommended to adjust the service
>> interval of the IN endpoint to exceed 32ms (interval 8). This
> 
> Do you mean "not to exceed 32 ms"?
> 
>> adjustment ensures that the OUT endpoint will not be bypassed,
>> even if a smaller interval value is utilized.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/usb/host/xhci-mem.c |  5 +++++
>>   drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
>>   drivers/usb/host/xhci.h     |  1 +
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index d2900197a49e..4892bb9afa6e 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>>   	/* Periodic endpoint bInterval limit quirk */
>>   	if (usb_endpoint_xfer_int(&ep->desc) ||
>>   	    usb_endpoint_xfer_isoc(&ep->desc)) {
>> +		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
>> +		    usb_endpoint_xfer_int(&ep->desc) &&
>> +		    interval >= 9) {
>> +			interval = 8;
>> +		}
> 
> This change ensures that the interval is <= 32 ms.

That's correct, thanks for pointing it out. I'll take care of this in V2.

> 
> Alan Stern

