Return-Path: <stable+bounces-230720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKOsLrLsxmkIQQUAu9opvQ
	(envelope-from <stable+bounces-230720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:46:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF934B40A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6B333031EFC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67135AC01;
	Fri, 27 Mar 2026 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S5P74dEP"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022126.outbound.protection.outlook.com [52.101.48.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8B31ED80;
	Fri, 27 Mar 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644399; cv=fail; b=f6+LA/JVgrAwYEabDMc4+qFtD21hyJoj8MpX+OCa2evPD3r40hO3BdDsAYDD0fH6vHkKrhQeN4TBjluXte7Mt8VYDx3glZN3sNG9g1Z/BudVcDf4A40WUZRJJIN9tHy187HIdw8/DDH7uiabbw1yTVWCwillwCAgyPfD+JXSnwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644399; c=relaxed/simple;
	bh=vgFUZXllLq8ijSSV0kEHD6g1UgTTolNReyt47GeOFXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Df/PrG9iErjMVuC9aDBYdVEesRxv2N5Z8yUrGpCWvBhb3sDB2onCsUR0/YQ5PXAGDxgkkdilkz/scUzllSUezrAdwzjzWqRUlAf/OcZtbCXbCG42jafp+GanuKyys19iXYGj67ZqmuD42oZ2nuPGLaKSWUFyAKiHbIyqRhD4LIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=S5P74dEP; arc=fail smtp.client-ip=52.101.48.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymrUqI+Q5cBmwQwmkISka5fbzJeV61Qj7wMe3jPXHzHi2hevkFG5gkILEKEDV1NaPyn/HgrOrnJl0n5pKYKk/rY1aVzoiaHMXe+DTvMZbbTWFloX8BTKkXcJWcZzpP2zk2jg2XH2Z8nBlPOSDPB6caaAnQ5+smt1wdK+pO5vGWbakmIZ+W/F9koKP3AlWXfbyIIPKj0X5jgzTcGvVDMtg76MX5oE/gyh9x2lBovDli9HFIAXLGHodL+2i/qkk/uTsLsQ3pJFbuWLd2I+vPPV4OnSrJ/EOKy+fvZ4ah+UdyfhLrd+nFhKuQyMdZ6toyGbx4FlR43dd709pOOPd2qL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZXA5nKQZjjLyQUhbqaKZZgj/O1+MbCopO5qp0AzwUo=;
 b=Y0slsjoONdYViz4xoktJmmEgYrUwPNIBvWxqYIOi2SdD7z97tiQv5r60MD1rhQr49GQk6YnlsvsNE6GKmcRgVD4udMXfrmdIt7jxL9yMz8oBRqdlzyVl+Mn8CdR8v9RnAT/6iX1THVKige9BbmAz7AQIYkcVDMD/v58ttnM+pUi1Up5mcw5d8X3L5WPiBZNOYO3V2NCzG8cK6pwzZ24dlBIswi32Q74i/8YjNRM7AJQlQ/6w+8JDfDO7KnXfXXjrZ3D7ZCafTUAAQkB3qPoXWFqaJJcWk1zLWQxvnpoKTy43sDFcS5GTH3f91oNz1PDOmUHE0RD+iv+5oc1JB49KGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZXA5nKQZjjLyQUhbqaKZZgj/O1+MbCopO5qp0AzwUo=;
 b=S5P74dEP75G0aUczl7kKP6zEAl1spsAUobH3k+uBBvXYvZ2VIJvbu3YBYFnEjexov9NWqSP7mBrQ9a2tmVAi54aGGyMLQ87XC7chnW2BWn7zEphc0DCRYIxq7ZEAfu2BnaB6L5SCh1oz6imsUhf4a5/wr9eOYy/78hdWgHaLMn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.23; Fri, 27 Mar 2026 20:46:33 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 20:46:33 +0000
Message-ID: <78f21f72-d847-4ae7-8b69-ccf9976cd490@os.amperecomputing.com>
Date: Fri, 27 Mar 2026 13:46:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
 <401073fd-3438-419d-8287-35eea61919b0@os.amperecomputing.com>
 <eea4f7f1-c929-453b-adca-606ba6e4ec69@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <eea4f7f1-c929-453b-adca-606ba6e4ec69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:930:a3::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b383a2-d36f-4636-a89e-08de8c41ee5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Dc5z2Rt3hVSO/gl+yXeOXu80GtShf7Rc5SKkuhzVPgx3JBe5Q8u32Dhu5t7E3rpm6bbA6FhGOo0lGVUjOyqABCmqLjnKPhO+eD8cofWgJw4DDAd8J91Ro4AWhqsXaZZHTkweHiD1Ss3O7JCNCnYTbPS+cqUjqOZn1PFsY7o48jX6jCxYV5k+esOMr9OeyZDIjhr8ZyKLUbUd68NqQ8k+RYEV5tVMbAEzlwIouZQ3RWv5HEs7oa2a09pGotbizOKOgerTgmyRlCiwEl1J3rirYY+jUY/EPs7E9zuyypSBZS9ZrDzmboiorlnLcFqBCyGCYmc3v0E6tFS64rsGtd/xsARR6i1mS/FwUXvQkV59lMbO2R7l7Wo1tmrPAwdEnzMqy/1YG1dlSwGATIPx+XTsUazL3+/vIc9J+Nwd50NHNGq1IBV4srMijZT5deyweNXQei7V9wAS8eQbGwKY4JcjZPo3fC4IB600ig+3kD9LBEPoDH5u67S1NWXjn3WuV/R1IbqV/xiXA8cu7hvL1QjFwgDIsAF9QxmdHXh0CB+68qmIFuINcPdSbdw3k0YFy/oMrR7r2YPMy/vtmqKPNezu3O3DDZp9+//cASNxq3bc/0EonxfI83NBLRszvWpJGPSDe+/xFUMG1vNJ9+5F2X/+Bb0zlruQXkyDj7rRsOFfEUnIgDDVjvEvXncASl1Mq+xSMKy6d869YSbYwjVPrZb73zWVAkXOLHA2+nKU0BBZGWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGt1djJHU1I4cnQwUVZKRVo1c25GTWJjdWMxUVdndzhiT0RpV3hNWmJvUSts?=
 =?utf-8?B?TE0wcjhmc0U5Z2l4TERVS2NSWEpURzNmbFE4dzdrdFgrR2FYUE4vWjZ3NDRJ?=
 =?utf-8?B?d1IwaXJrdGpiaXZkQlVJUlBPdXUzTytQaWQ1S1NPa29QdG9LUUUyOElTWTdP?=
 =?utf-8?B?QlU0Zmw2RWhUWjFrZXNkdUV4dmtHeWlrWTBucDdQV1RMenptMXQ5SEpMNXJ5?=
 =?utf-8?B?RE55V29hRGplOHlUdXBpVG1ySUZ3WUJZSVFJZ3JZUzFBZUREZVhrNmR0V0hW?=
 =?utf-8?B?ckRTbjFqSFBtbkNENXVKTjdkUURreUE2azVpQlNOaWpIeTlUemhDYWc1cW9j?=
 =?utf-8?B?K0JZMVR4RmRjbTRaZ1pUYWZINURQbTBYZCtZZlg3MStqMHdyZVBlOGtnQWpT?=
 =?utf-8?B?NHdUM1h2VE40YUt3ZmZMaHJUVkZ4VTRNaUswWHQ4czVFNFBzNDducHFxaFJ1?=
 =?utf-8?B?YUN2VXNCallSVW9tOHFmNXpMMnNMT0p6Q1lWSXBSSTAwZ2dhK3pac251cmEw?=
 =?utf-8?B?SlNmV2dmMkY3eis5SHc4Njc3Z2tYYXRFSFh1QlB5cGV1VGFKNDZpZWRSVnhF?=
 =?utf-8?B?dzlSZUNKRStBb1c2bTlzNUpkbXJtQmxhT2FiRHJVS1hPRjlndHYyNm1oeERa?=
 =?utf-8?B?VVRDZ01hK1FLbTIySHpEMytYVU93bTZXcGxTbUJRU3J3WXRwRmFSSHhEV09i?=
 =?utf-8?B?dHVLZGFuKzRRVHpNUFZ2RHk4MnFGYWdJOGJrN0Q1KzB2dHoza1RjeVhLUk9q?=
 =?utf-8?B?MEVnS0JFZ2VWU3YxeC80VHRxdHVlWE5OeTJGanVlRFVXNDJRVmtoaWpNZkdr?=
 =?utf-8?B?SnhTbitvSDBNRUsvVFU1M1dTQUpaL0djeTRsWTlLZ3NaWEg0UWlKei9Da3NT?=
 =?utf-8?B?OUt5NVBlWDIrcDAxVnF0L2ZEVlJrVVpRRVh0Um9LM0V1ZEFXVmVNUUJ1dlB6?=
 =?utf-8?B?UWd2aExPY2srNFo2RVJZUHRSUVIybDkzTU5LN1VwMEhabXdSNGFpQ040SmFO?=
 =?utf-8?B?SnlqYnlsbFpxbnhMNUhVU0pKOVBwc1Y5WGJ0VktSYlYzd2ZtSnZOWTFPMXo2?=
 =?utf-8?B?UjZQWHFuN1pxcitEVnZYcFVTc1lsNzF0dUgrY0s0NHhGd2U3OTZzaWdGS2dP?=
 =?utf-8?B?S0RIZzBEY2VSM29sZ1VuMHpOR2VaK3dQQm1BWEZZa0V4V25Hek5hUGFvVUJE?=
 =?utf-8?B?TzVQRStEVGJMdWtrcDBoU2N1S0JNTVl4cjNDNjlvb2VnUm5uSElOWnRONzIx?=
 =?utf-8?B?QzJsUTBmTnUxTkdvd21MS0E1aFphVzdkM0dlZExLR2l3RXRmOWo4dFl6WVdu?=
 =?utf-8?B?VytSdWZmdzRKSkt3UmQyQll6cmlMQVlIaFB4N3BKamNlN2dEdlBvWmlETzBW?=
 =?utf-8?B?bS83SUpuLzF0V29LOTdOV0U1Q2lUbXhCdkhIODV5VjBtcldoekxLL2F6SWow?=
 =?utf-8?B?MjFnWjg5ZlJFMDBSeUQyWWFCSmREdVpFZFBOTndvenYvTlZia0VIRjh4ajhT?=
 =?utf-8?B?NlhnQVVPTFRjRURmdTM1UmVvVTlGa29MeUhNNU9HZnd2TUowYnhXMm5wMGc5?=
 =?utf-8?B?THIxZERJcWZYcGJWMi9JTytnS3dSN0JvOERmYWt1QmdxRHhyZGd6MkxsdWZI?=
 =?utf-8?B?WFltMlNxVkhMeGdUbzNBN05wbmZ2dUs2c2w0cFFxbTd2M2VPNzd2OFJlRStm?=
 =?utf-8?B?bnE5T0ZHM3l1Q0w4eGFMWHVJeWFBNCtFYTRDWVp2VWcrUndXS21CUFpIa1Z4?=
 =?utf-8?B?TVJMS3lRbTdrRVdSY1EwSjVjaVpoeFRxVW9neUFIWlRYcUIrTU56b3ZseUhS?=
 =?utf-8?B?UzI5SnYxcGlBeVJkUDJldU5DQTF3RUN4cWJ0c1IzNjBaZGU3cUlPeUpHVmlN?=
 =?utf-8?B?OUtadjNidWRCbmw3cnFkUTJTem5FTVFRZ3Q1bjJGb0FwbUFLaDJPbnJ3Skhi?=
 =?utf-8?B?ZHB6SDF5VmFQVS9jb1YrajN6b245NDRxRGlQendKWGtVNmtUZURnK3N0TUV0?=
 =?utf-8?B?UWxpemtMSHVDbXFDek9RYWp3MkYzbUNJNFNiSGdDYW1xUVloUFVIa0RqakJK?=
 =?utf-8?B?bElOb0drMitFeFRFY2FOZjFMWkI3ZlpFaDF6SjkwL1lnQlBZQkFTZW1UOTJ4?=
 =?utf-8?B?T3U0M3RFQ2R6M0pLZjRDOGRRQ2ZXZTZqM09FVVp2azg0cHA4SnNkSkpwL3U3?=
 =?utf-8?B?MWJsU05QTUV5K1RKSGlYa2RZc1JqL0ovdElTWjZVbGZjeGsvcS9MZ1VKNFBW?=
 =?utf-8?B?d3FKT2hqd0FwZnVzbGRWZ01qZFN6TzJXYVFvVFFQTndwL09Jdkk4NzZCdFZy?=
 =?utf-8?B?UG5adk5KL0lCNVVzLzE5Y3EyWDU1c3JFTmRIUDZ2ZVhWZSswUGJ6T2NXakRt?=
 =?utf-8?Q?OLp2ZBDW+q3tpcYQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b383a2-d36f-4636-a89e-08de8c41ee5c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:46:33.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL0X81yOb3LZWbARtrvk5sE5FgL5D064dUdHXf28tWv4qk0nOOdLuALsH1wRE2OhbVPydr+JlvE0twMGVMpaiaD/cy7CK0JTlJgQf5RwXSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230720-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45FF934B40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 10:37 AM, Ryan Roberts wrote:
> On 24/03/2026 18:20, Yang Shi wrote:
>>
>> On 3/23/26 6:03 AM, Ryan Roberts wrote:
>>> It has been possible for a long time to mark ptes in the linear map as
>>> invalid. This is done for secretmem, kfence, realm dma memory un/share,
>>> and others, by simply clearing the PTE_VALID bit. But until commit
>>> a166563e7ec37 ("arm64: mm: support large block mapping when
>>> rodata=full") large leaf mappings were never made invalid in this way.
>>>
>>> It turns out various parts of the code base are not equipped to handle
>>> invalid large leaf mappings (in the way they are currently encoded) and
>>> I've observed a kernel panic while booting a realm guest on a
>>> BBML2_NOABORT system as a result:
>>>
>>> [   15.432706] software IO TLB: Memory encryption is active and system is
>>> using DMA bounce buffers
>>> [   15.476896] Unable to handle kernel paging request at virtual address
>>> ffff000019600000
>>> [   15.513762] Mem abort info:
>>> [   15.527245]   ESR = 0x0000000096000046
>>> [   15.548553]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   15.572146]   SET = 0, FnV = 0
>>> [   15.592141]   EA = 0, S1PTW = 0
>>> [   15.612694]   FSC = 0x06: level 2 translation fault
>>> [   15.640644] Data abort info:
>>> [   15.661983]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
>>> [   15.694875]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>>> [   15.723740]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   15.755776] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081f3f000
>>> [   15.800410] [ffff000019600000] pgd=0000000000000000, p4d=180000009ffff403,
>>> pud=180000009fffe403, pmd=00e8000199600704
>>> [   15.855046] Internal error: Oops: 0000000096000046 [#1]  SMP
>>> [   15.886394] Modules linked in:
>>> [   15.900029] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc4-
>>> dirty #4 PREEMPT
>>> [   15.935258] Hardware name: linux,dummy-virt (DT)
>>> [   15.955612] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>> [   15.986009] pc : __pi_memcpy_generic+0x128/0x22c
>>> [   16.006163] lr : swiotlb_bounce+0xf4/0x158
>>> [   16.024145] sp : ffff80008000b8f0
>>> [   16.038896] x29: ffff80008000b8f0 x28: 0000000000000000 x27: 0000000000000000
>>> [   16.069953] x26: ffffb3976d261ba8 x25: 0000000000000000 x24: ffff000019600000
>>> [   16.100876] x23: 0000000000000001 x22: ffff0000043430d0 x21: 0000000000007ff0
>>> [   16.131946] x20: 0000000084570010 x19: 0000000000000000 x18: ffff00001ffe3fcc
>>> [   16.163073] x17: 0000000000000000 x16: 00000000003fffff x15: 646e612065766974
>>> [   16.194131] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>> [   16.225059] x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000018
>>> [   16.256113] x8 : 0000000000000018 x7 : 0000000000000000 x6 : 0000000000000000
>>> [   16.287203] x5 : ffff000019607ff0 x4 : ffff000004578000 x3 : ffff000019600000
>>> [   16.318145] x2 : 0000000000007ff0 x1 : ffff000004570010 x0 : ffff000019600000
>>> [   16.349071] Call trace:
>>> [   16.360143]  __pi_memcpy_generic+0x128/0x22c (P)
>>> [   16.380310]  swiotlb_tbl_map_single+0x154/0x2b4
>>> [   16.400282]  swiotlb_map+0x5c/0x228
>>> [   16.415984]  dma_map_phys+0x244/0x2b8
>>> [   16.432199]  dma_map_page_attrs+0x44/0x58
>>> [   16.449782]  virtqueue_map_page_attrs+0x38/0x44
>>> [   16.469596]  virtqueue_map_single_attrs+0xc0/0x130
>>> [   16.490509]  virtnet_rq_alloc.isra.0+0xa4/0x1fc
>>> [   16.510355]  try_fill_recv+0x2a4/0x584
>>> [   16.526989]  virtnet_open+0xd4/0x238
>>> [   16.542775]  __dev_open+0x110/0x24c
>>> [   16.558280]  __dev_change_flags+0x194/0x20c
>>> [   16.576879]  netif_change_flags+0x24/0x6c
>>> [   16.594489]  dev_change_flags+0x48/0x7c
>>> [   16.611462]  ip_auto_config+0x258/0x1114
>>> [   16.628727]  do_one_initcall+0x80/0x1c8
>>> [   16.645590]  kernel_init_freeable+0x208/0x2f0
>>> [   16.664917]  kernel_init+0x24/0x1e0
>>> [   16.680295]  ret_from_fork+0x10/0x20
>>> [   16.696369] Code: 927cec03 cb0e0021 8b0e0042 a9411c26 (a900340c)
>>> [   16.723106] ---[ end trace 0000000000000000 ]---
>>> [   16.752866] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> [   16.792556] Kernel Offset: 0x3396ea200000 from 0xffff800080000000
>>> [   16.818966] PHYS_OFFSET: 0xfff1000080000000
>>> [   16.837237] CPU features: 0x0000000,00060005,13e38581,957e772f
>>> [   16.862904] Memory Limit: none
>>> [   16.876526] ---[ end Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b ]---
>>>
>>> This panic occurs because the swiotlb memory was previously shared to
>>> the host (__set_memory_enc_dec()), which involves transitioning the
>>> (large) leaf mappings to invalid, sharing to the host, then marking the
>>> mappings valid again. But pageattr_p[mu]d_entry() would only update the
>>> entry if it is a section mapping, since otherwise it concluded it must
>>> be a table entry so shouldn't be modified. But p[mu]d_sect() only
>>> returns true if the entry is valid. So the result was that the large
>>> leaf entry was made invalid in the first pass then ignored in the second
>>> pass. It remains invalid until the above code tries to access it and
>>> blows up.
>> Good catch. I recall I met this problem when I worked on a very early PoC of
>> large block mapping patch. It took a total different approach than
>> BBML2_NOABORT. I didn't run into that problem when I implemented BBML2_NOABORT
>> because nobody actually changed valid/invalid attribute on large block mapping
>> granule so I forgot it. But I definitely missed realm usecase.
>>
>>> The simple fix would be to update pageattr_pmd_entry() to use
>>> !pmd_table() instead of pmd_sect(). That would solve this problem.
>> Yes, I agree.
>>
>>> But the ptdump code also suffers from a similar issue. It checks
>>> pmd_leaf() and doesn't call into the arch-specific note_page() machinery
>>> if it returns false. As a result of this, ptdump wasn't even able to
>>> show the invalid large leaf mappings; it looked like they were valid
>>> which made this super fun to debug. the ptdump code is core-mm and
>>> pmd_table() is arm64-specific so we can't use the same trick to solve
>>> that.
>> I don't quite get why we need to show invalid mappings in ptdump? IIUC ptdump is
>> not supposed to show invalid mappings even though they are transient.
> Let's say we have 8M of PMD mappings, then we want to mark 2M in the middle of
> that as invalid. Prior to my fix, ptdump would show the full 8M as still being
> valid after making the middle 2M invalid. This happened because the note_page()
> call for the 2M invalid part was suppressed, but there was also no ptdump_hole()
> call since the PMD entry is not none. After my fix, we call note_page() for the
> non-none but invalid pmd and now the "F" is correctly displayed for that portion.

I see your point now. Yes, pmd_entry() will return 0 because pmd_leaf() 
returns false in this case. But the page table walk still continues 
since the later "pmd_leaf(*pmd) || !pmd_present(*pmd)" returns true 
because it is not present either. So the invalid entry will be 
mistakenly covered in a valid range.

It may be better to show the user visible ptdump change in the commit log.

Thanks,
Yang
>
> Thanks,
> Ryan
>
>
>
>> Thanks,
>> Yang
>>
>>
>>> But we already support the concept of "present-invalid" for user space
>>> entries. And even better, pmd_leaf() will return true for a leaf mapping
>>> that is marked present-invalid. So let's just use that encoding for
>>> present-invalid kernel mappings too. Then we can use pmd_leaf() where we
>>> previously used pmd_sect() and everything is magically fixed.
>>>
>>> Additionally, from inspection kernel_page_present() was broken in a
>>> similar way, so I'm also updating that to use pmd_leaf().
>>>
>>> I haven't spotted any other issues of this shape but plan to do a follow
>>> up patch to remove pmd_sect() and pud_sect() in favour of the more
>>> sophisticated pmd_leaf()/pud_leaf() which are core-mm APIs and will
>>> simplify arm64 code a bit.
>>>
>>> Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    arch/arm64/mm/pageattr.c | 50 ++++++++++++++++++++++------------------
>>>    1 file changed, 28 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 358d1dc9a576f..87dfe4c82fa92 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct
>>> mm_walk *walk)
>>>    {
>>>        struct page_change_data *masks = walk->private;
>>>    +    /*
>>> +     * Some users clear and set bits which alias eachother (e.g. PTE_NG and
>>> +     * PTE_PRESENT_INVALID). It is therefore important that we always clear
>>> +     * first then set.
>>> +     */
>>>        val &= ~(pgprot_val(masks->clear_mask));
>>>        val |= (pgprot_val(masks->set_mask));
>>>    @@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>>>    {
>>>        pud_t val = pudp_get(pud);
>>>    -    if (pud_sect(val)) {
>>> +    if (pud_leaf(val)) {
>>>            if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
>>>                return -EINVAL;
>>>            val = __pud(set_pageattr_masks(pud_val(val), walk));
>>> @@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>    {
>>>        pmd_t val = pmdp_get(pmd);
>>>    -    if (pmd_sect(val)) {
>>> +    if (pmd_leaf(val)) {
>>>            if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
>>>                return -EINVAL;
>>>            val = __pmd(set_pageattr_masks(pmd_val(val), walk));
>>> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start,
>>> unsigned long size,
>>>        ret = update_range_prot(start, size, set_mask, clear_mask);
>>>          /*
>>> -     * If the memory is being made valid without changing any other bits
>>> -     * then a TLBI isn't required as a non-valid entry cannot be cached in
>>> -     * the TLB.
>>> +     * If the memory is being switched from present-invalid to valid without
>>> +     * changing any other bits then a TLBI isn't required as a non-valid
>>> +     * entry cannot be cached in the TLB.
>>>         */
>>> -    if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
>>> +    if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
>>> +        pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
>>>            flush_tlb_kernel_range(start, start + size);
>>>        return ret;
>>>    }
>>> @@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages,
>>> int enable)
>>>    {
>>>        if (enable)
>>>            return __change_memory_common(addr, PAGE_SIZE * numpages,
>>> -                    __pgprot(PTE_VALID),
>>> -                    __pgprot(0));
>>> +                    __pgprot(PTE_MAYBE_NG | PTE_VALID),
>>> +                    __pgprot(PTE_PRESENT_INVALID));
>>>        else
>>>            return __change_memory_common(addr, PAGE_SIZE * numpages,
>>> -                    __pgprot(0),
>>> -                    __pgprot(PTE_VALID));
>>> +                    __pgprot(PTE_PRESENT_INVALID),
>>> +                    __pgprot(PTE_MAYBE_NG | PTE_VALID));
>>>    }
>>>      int set_direct_map_invalid_noflush(struct page *page)
>>>    {
>>> -    pgprot_t clear_mask = __pgprot(PTE_VALID);
>>> -    pgprot_t set_mask = __pgprot(0);
>>> +    pgprot_t clear_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID);
>>> +    pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
>>>          if (!can_set_direct_map())
>>>            return 0;
>>> @@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
>>>      int set_direct_map_default_noflush(struct page *page)
>>>    {
>>> -    pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
>>> -    pgprot_t clear_mask = __pgprot(PTE_RDONLY);
>>> +    pgprot_t set_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID | PTE_WRITE);
>>> +    pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
>>>          if (!can_set_direct_map())
>>>            return 0;
>>> @@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>>>         * entries or Synchronous External Aborts caused by RIPAS_EMPTY
>>>         */
>>>        ret = __change_memory_common(addr, PAGE_SIZE * numpages,
>>> -                     __pgprot(set_prot),
>>> -                     __pgprot(clear_prot | PTE_VALID));
>>> +                     __pgprot(set_prot | PTE_PRESENT_INVALID),
>>> +                     __pgprot(clear_prot | PTE_MAYBE_NG | PTE_VALID));
>>>          if (ret)
>>>            return ret;
>>> @@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>>>            return ret;
>>>          return __change_memory_common(addr, PAGE_SIZE * numpages,
>>> -                      __pgprot(PTE_VALID),
>>> -                      __pgprot(0));
>>> +                      __pgprot(PTE_MAYBE_NG | PTE_VALID),
>>> +                      __pgprot(PTE_PRESENT_INVALID));
>>>    }
>>>      static int realm_set_memory_encrypted(unsigned long addr, int numpages)
>>> @@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
>>>        pud = READ_ONCE(*pudp);
>>>        if (pud_none(pud))
>>>            return false;
>>> -    if (pud_sect(pud))
>>> -        return true;
>>> +    if (pud_leaf(pud))
>>> +        return pud_valid(pud);
>>>          pmdp = pmd_offset(pudp, addr);
>>>        pmd = READ_ONCE(*pmdp);
>>>        if (pmd_none(pmd))
>>>            return false;
>>> -    if (pmd_sect(pmd))
>>> -        return true;
>>> +    if (pmd_leaf(pmd))
>>> +        return pmd_valid(pmd);
>>>          ptep = pte_offset_kernel(pmdp, addr);
>>>        return pte_valid(__ptep_get(ptep));


