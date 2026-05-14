Return-Path: <stable+bounces-247196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPNaLPLFBWrDbAIAu9opvQ
	(envelope-from <stable+bounces-247196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:54:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E599541F5B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92098303CD1D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DA399895;
	Thu, 14 May 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RfWEDwpS"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907813DD52E;
	Thu, 14 May 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763154; cv=fail; b=Rg9PRTxASr9IisKFozJED8SVF8FN+dCLMp1oH0SfnMUItlNEy7EbfOumFhXO/FQgAZXkpeeU9YEh2qgzjT1uxDkr1qmL6d1qvI7voBeXy/4/O12+5s/iHhbUxUhmFPUYUXXXklwltL/FgptycmV23BA2yOXEgJ5LqwXiaatuGk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763154; c=relaxed/simple;
	bh=ndmqUoTe3uyq+pxBortl5qmipuXUjEyUogNcE4VPnmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsjVUwnmaND4WhIv7cgUyC4nOzQD6LkQWb7v3Wr7vGYbxmnlT4n/HdRTTIEcw7gn+5zGhZ9eIelb7aYau/zuPpdbUUt1YYbtnJHiJ50UMkdBdnzTNxLa1F3A6V8PENQ+U6d025EkbzCMa7JR1ghcblz7i5DGg+kTNEO9hRQrUGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RfWEDwpS; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvikDp6fn53rx8x66QrPrymtlizBuQ0yfwRPNwgmNTwjCP43wzI2bqRrbiPjQw7nTAdZDUn0/uBxDKtNU5OQDL4kpIY9nIZVpd1Zr2ggZhk+0rug6r4o0t/sn1kkZwUY+L0S0NhVXNgJUMj9AXWAJsUDIns3fzJUZ3NPCIjKZy//+gC3cnK6+8XvcODurg4RSWuEQ2A5bvTEAy1/Nd4CaEuxeWaSytzVdPuX3BtSGBQNKDe4qqFLcIFZ/vZXAQC/3sCDB+2H0R+XBQtH2TyrQ3ehIor8gv7M91zSMcMMz7thXv6/oTiAjrda3ZrkhoXSG4TS1bbEqWC5Tr2X//2IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc8V6/bs+HTXOBlN7h+U1C4FS7zyRn51Jy32DFGr7aU=;
 b=Mtk8pgOY8vN9IVWT3A5EH0ZCMK8wMbbfIukXwjxYI+6ijfbS/sq1DCWVHOOmnRuMV+/cx9/vNfb0ZJVqixg+i4WCs/3vO69Vyoh9Rb7HpwQp08q2jXpArIdiEkIGQYiw02ZHQ3AoWJgYpbp6tDpeS03E/Q0C5yjwzTQZfTsRuQBOwlpfdlKJjFFDBydoOe7QtPjrcATDv/jozn54ukw6ONtn7eWVzl2t03IXhPMnmkzGn4roN95msclVAHBf0EHSUu2bfE+HP4StGxeVAMf9EutEEyuvNaLZKTCDarlE7EtqGIjVke3S8t/OMZSQPuSU37utDnj9Z2pUeOhBTA8XeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc8V6/bs+HTXOBlN7h+U1C4FS7zyRn51Jy32DFGr7aU=;
 b=RfWEDwpSU9R9glSyWfB6kxcAWS0DL6EdjGF+Te8jJQrCaMeYcwrONqpVv+pjlBZNbVaKLBzG9Bujt7LUa+Zj5iCYfwW/5yy61a8ls/mht5/KSDuEStXhUXiWAg/HMVxKeBGIsF1IUNfQGX/xRNhbJrgjSO5fFHdFHd+nlctPd90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 12:52:26 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 12:52:26 +0000
Message-ID: <7eca29f8-9847-4ee1-ae3c-8c507bc295c7@amd.com>
Date: Thu, 14 May 2026 18:22:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init
 error paths
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git@amd.com" <git@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
References: <20260511160814.2904882-1-radhey.shyam.pandey@amd.com>
 <20260511160814.2904882-4-radhey.shyam.pandey@amd.com>
 <agUnwgXyyrGQ2t2y@vbox>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <agUnwgXyyrGQ2t2y@vbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0059.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d9fd36-cd9b-4ff6-3ed7-08deb1b7a655
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	4jb32SzUNworv0c1kvjsp3aLH+y1A4aWuIfCUvxMNQHKvgo+a+km8w8qAqQrutaIQAR2QCc1ObVnfPzRWtMrXSDU7Z5DSoLBgJS8GE4JA4SRtINgfocPxedRDBs7FTfl+7knwKwQHnsJnPA3ui4C2jLfT9KNzxeBLXtyI4+t5LUjmkAthUnnKtAWwOtAo0Mh8Bhk4wi17mj0BdUXxwkaMv/pjmYTEWk1sZozlP6F4WptRJdmdlkaYMhzW3ThJYVqddrie1AMKW6FsizVRp8AO9DoDoy6RN/t5y/KKGzb1ywTdtk+DAnXCeBlqP2uzbm2JuXHq2bZ037a0ngEGQ1fsbaLOvy8ZmgjPfwAcX+RFUT2PeoKjIIWcwQL0/rxjcqNIy+ceOesMC/y//RCeSh1lJY67IAIW4h5Ok/2nk1/52XYy6oSbn8sEZb07CXLONLY6LVsh7Ddgr4HtXE1OK32Ltkk+FgxN0v4QjjdZwrQSEN5q8nheaoT3ttfgVQn6DabrCTG+KoFuApaWbPWLqOE9iX+lljXEnm/CcnFHsR8cuoDNlKBls0ZbKKKmqylD5InL4tFhLEkmu+Ki1VTYeFzZ+0E/DGhW7nAuPJOSMpI10og1YLtRRt/GOCW3uCBdDHVfsw66lJqmi3dAZnQDlkJJI2WS8ktTBwIhSF+hrJAv4LKb00c120f1ur16tP2HIRu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGE2VjdjRUo5TFoyVmM5cFc1WFIyVDh4azMvN0JvSUtIK09SRFBHSVlnZlY2?=
 =?utf-8?B?N1ZSWEQ5dmdHUC9Pd0hyOWFXanZ1eG9TQmFBazJldkU1WXkwcTJjcG82cWtx?=
 =?utf-8?B?U3JhNGNoME40UzdpQmxMcDZBNWpSQ1U0YnMrU0QyRTJPWjZ4RkJrZFJWMCtO?=
 =?utf-8?B?OFFtK1o2ZkU0aHNzdGFFTGtGMzNRYXZHV1JVT293VlJuY3dwdkJHczZCcHMr?=
 =?utf-8?B?ME54bFF5QXRrMHhlVS9sUTM4U055UVpkM1o0bWM0TVg0QTRLQ1hqSXU4clBE?=
 =?utf-8?B?TUZ0ZlBTL1pUbjFUV0QxQlFKODl4c1YzbGVUYWZVdSt1MUlLTlFreW5uQWxy?=
 =?utf-8?B?T0xyMEpyU1hOc0FqcFNva05nQVZoaVhBM3RTUUszaTN0S3VDSVpOY0pTSjdW?=
 =?utf-8?B?dFM4SG9hSHd5dzNCVlh5NHZwcWFuWkdDbjhJazBMY2lFR1J2ZEgwN2d4L3ZV?=
 =?utf-8?B?K21HZWlTWENYRkJnQlZKdXFWQmwyQTBUazUrckNJNDNWTEpHWVV0cGRjcXd6?=
 =?utf-8?B?MCtnWDdlaTRIK3JXMlF4cVpSK3dDUUN2ZFJsUDdXVGRHVVM4UEU1NVhMTzBq?=
 =?utf-8?B?TERyUGp1bTFFdnByS3JsUWNzOWRFMzVNcmcrUUJja0c4M00vS041ZzhRbVc1?=
 =?utf-8?B?ZFFEWC82VWhIbzlnNkJjUkoxcjJpVmI2QXdReWloeGlDcS9Cb0FSbW9yL2lV?=
 =?utf-8?B?SkNMRXlIVWpXZVNrSUFmQjB5elZaUGtKMVdKdVp3V3V5eUpKUks2S1JydlE0?=
 =?utf-8?B?TDMvWWZTMWdhTFl5QkZVTEhoN256aW84cWN4b201eGdsQkdvQ1JTRW5TZk5L?=
 =?utf-8?B?V3dIbzRWbi9LVVVMMEs1cXlyeVdPZW8yTTJNMWFlV3E5bGdZQWpESVpqVUxn?=
 =?utf-8?B?aGRjVmFTZXdIdGtrWWgyWjJvbk1ZZlFPbjFqZ2JPZDZhTDIzbFJpNjAxQ0pM?=
 =?utf-8?B?ZU5zZ1NQL0ZiUGI1SjA5MWxwZ1l2TVVCQ3VXMFExaG0xa3BRbTlJclJndEph?=
 =?utf-8?B?OHlNQVBHRSs1V0ozTW8wRi8zLzhUVlJTRkpHbkU2b0ZkSmRadTQ0aXVtVDAv?=
 =?utf-8?B?eDF3QVJZMlBjci9uNGpLWER1ZEtPWW9mcmsxZmdUdTdwUFkvdVUyUnA2TXNO?=
 =?utf-8?B?MlY1NXBsR045SHgrbUVaZG5rMUgvMmxqQ29FVmVhQjFxaUtEUEw2a2Z2UDhI?=
 =?utf-8?B?ckJPNWRSOEg2d3NiOEtyTkpFVWRUQm9xQ0k0MHA2KzFycnBEaVdqb2dIVkpG?=
 =?utf-8?B?c2JVUEQvVHpOb3Qxd0VOWGVlUGpzWDZnK0VUbnBkMHAwS0dkNmRvN09CbHVr?=
 =?utf-8?B?Ly95Ni8yZDdLZ28vKzVqQzdHbmIrdGE4YnZCZ1BtVk55c0ZEWTFjaTBtZmtO?=
 =?utf-8?B?OXRrWGtyWHkyUUdaQ3BReUR2amhJRjlSNDVpQ2lmY2J3T3lmZzdNU2JWZmp3?=
 =?utf-8?B?cFRDNGgrUE1TVDNodSs2QkloRmxjNytFR01nSWVCUXRxN0w4bnlVM0NPOVln?=
 =?utf-8?B?S084TSthUDZDRlZJUjJ0U1N5SDRqbUdJVktJbUp6SC9GTUhlaVh5K0xrRUdG?=
 =?utf-8?B?V0pJTnRRd3FJWGZlcVVHbUVTdm10a1ZOQ1o3eE91MmlVNWkwTWF5WXArWnVI?=
 =?utf-8?B?bC9GbFJBOU85V3FVaWdWL2tuVzFISWxlemFlU2xhVURZUmZ3eEpWek5FMmlQ?=
 =?utf-8?B?VlFHMEo4VHBvdXlwZFRsdHJyajV5ZGcxMWxEVVMrOFpZV1EvbkhzUy83bDFq?=
 =?utf-8?B?akpvUjRaM09zU3VXcWhMV3dXRTZVckdoYXBsMktSbm1qVi9FMGN3WjBncW9U?=
 =?utf-8?B?MFplNDM2dCtpYzYzUVBUV3M0OWlTSittSG14VW1ZQmQ5RjZkc3BiTnBRZWN4?=
 =?utf-8?B?ZWwxZDBVNE5QY1JadjJlcUllQUxuNlV1UzFEZXJyaStrNEp2QjVycVdOWCt0?=
 =?utf-8?B?RjI2VkpEZG9ITHFQdXhjSGNTMlJNWmxDZjU0WXVERkYyWUE3UWlmS1RUMjUx?=
 =?utf-8?B?azBncUJlSGphMXFpSXZKVEVDNnJBZDcyalFxUWpXS09JWnV3dmZ0SzJ5OGdX?=
 =?utf-8?B?VExWT01YQ1Z0MkJXYjNvbVRxQnJXUnpoT3JJa0c1U0JrUHAxUFdicUhFblpp?=
 =?utf-8?B?b1BnMjZKRHdBdVQwdVVRN0tBTit3NnZVL1hBdGZUSlJqYTJaUm1JK1lKUmJ4?=
 =?utf-8?B?S0RqWVdFSURDbm9CaDBYYVc1Smtha0lPTlY0blhvSXgyaEEzQ2xudzBYaXBu?=
 =?utf-8?B?eUFYQUxKb1JPVE1vbmdyOG55a0tnTDZRS056TldIaDczbUdoSUJwT0VuN3U0?=
 =?utf-8?B?TktTc1R0dUFPVVJwREtaLzVwOUpJSFJBUXBlSTQ4bVpxNndNWURjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d9fd36-cd9b-4ff6-3ed7-08deb1b7a655
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:52:26.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpDOEav3jtCb/r3okzvXPHHAoDR8afHq8W3JxH6evlSj3MQsgLZ7aHIG1675eO7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Rspamd-Queue-Id: 1E599541F5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Action: no action

On 5/14/2026 7:13 AM, Thinh Nguyen wrote:
> On Mon, May 11, 2026, Radhey Shyam Pandey wrote:
>> Fix error handling and resource cleanup i.e remove invalid
>> phy_exit() after failed phy_init(), route failures through
>> proper cleanup paths and return 0 explicitly on success.
>>
>> Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> ---
>>   drivers/usb/dwc3/dwc3-xilinx.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
>> index 94458b3da1a0..b832505e1b04 100644
>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>> @@ -176,15 +176,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   	}
>>   
>>   	ret = phy_init(priv_data->usb3_phy);
>> -	if (ret < 0) {
>> -		phy_exit(priv_data->usb3_phy);
>> +	if (ret < 0)
>>   		goto err;
>> -	}
>>   
>>   	ret = reset_control_deassert(apbrst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release APB reset\n");
>> -		goto err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	if (priv_data->usb3_phy) {
>> @@ -200,26 +198,24 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   	ret = reset_control_deassert(crst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release core reset\n");
>> -		goto err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	ret = reset_control_deassert(hibrst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release hibernation reset\n");
>> -		goto err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	ret = phy_power_on(priv_data->usb3_phy);
>> -	if (ret < 0) {
>> -		phy_exit(priv_data->usb3_phy);
>> -		goto err;
>> -	}
>> +	if (ret < 0)
>> +		goto err_phy_exit;
>>   
>>   	/* ulpi reset via gpio-modepin or gpio-framework driver */
>>   	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(reset_gpio)) {
>> -		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>> -				     "Failed to request reset GPIO\n");
>> +		ret = PTR_ERR(reset_gpio);
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	if (reset_gpio) {
>> @@ -229,6 +225,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   	}
>>   
>>   	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
>> +
>> +	return 0;
>> +
>> +err_phy_power_off:
>> +	phy_power_off(priv_data->usb3_phy);
>> +err_phy_exit:
>> +	phy_exit(priv_data->usb3_phy);
>>   err:
>>   	return ret;
>>   }
>> -- 
>> 2.44.4
>>
> 
> This fix should be a separate patch from this cleanup series.
> 

Sure, will split it into a separate patch. Does this patch look fine?
If so i can add the Reviewed-by tag in v2 or address any further
comments if needed.

Thanks,
Radhey


