Return-Path: <stable+bounces-241332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NSrKVVn72kIBAEAu9opvQ
	(envelope-from <stable+bounces-241332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:40:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD054739B2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D98C30379A4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CE3BD657;
	Mon, 27 Apr 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="teG8ybI5"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F839B949;
	Mon, 27 Apr 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296963; cv=fail; b=DN2YCIuXU9wuh/6OBu1mmQy5v3kI5KIdDg2k8LYMEqaAzs4dP/hQsCnWsYbbiFWZP/4zEb+V1Hs9J7JX+BNF4/ZL6SlSXyoUBvYz2vRERcCza11NlcIpsC1DR09syMJGzBo7wWczTF29HOwAPYB338mnz43pOHtTZD944aVp7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296963; c=relaxed/simple;
	bh=1r3K4B5WbPaMcpqo3lvERM3ugPC+deqDM9R2RfmXREc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yic9XszvHj/q1STOhP29lQZAHC9LRNj2KNoa342w1E30cHztbwrz610c1OHoZqFXSU+oY/18zSTX3i70OX5uRLxZssHn5SqrNflI0BjOTdeTo6x8V4VmXvxpJOzc1m4aZ8+k86hLf8PT03IOdU0x+XjNxAjQVQYISnb/8Kle9AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=teG8ybI5; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9wq6VtjM/2Abb4U4v9X+Anm9jlu+3IRr2mg2QorFZJSIumo8ccBBvXTfFkRzD68+lIa0+poLTOeXc5qQIn/o5KtwvGtTfF7JNTMj5g8T0rFwdB3zWzXS73HJQJvaGRJWM12hdOmIRWqDT3r7mLYVtPsfMw1yi2HMAvO42ImBGBq68w+eSwLfr+aY27BH3B8OZ3knjgZSTwztQLgExgtQhwt44nIrq7AUCTXErTmtMbKN3gGUbBhXwG7GU9lohxXocmlXqLP7bAUITqyxJ7Q3UyOYLJkMZE5M7Xl2I1qN0IJAJO5kqwa5Ij4jHEckN0xH0vIR5gnI5udXvxyseOWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXpC+4ufzGRKTGv6W1zHaN9YFCsAj7nS05oG/Ezpmvc=;
 b=NW6KMD2Sw34WXnfr7KmIBvKzFYv7B2NEL5O0A36beIJVZNpODGlf+qB31KVFUNHDSjymv0KKNz/s/G1/A8DCChdhdsQN6YrQLmS7ThpzJVd2gHxUZvUr4w0hDsvsJIUgWZXevUKMhpKex5xo9q+ZFKHqhoUZta5ZULo4tX7Eg9i7YOoLNRXbBS2M/Rdagw+Qj0ZVma9DzVHOAfl2TojtbJVXmHsGrdyO2I/wnkGhsnUU83DzEXix4YfAT5WoCRiiP3o/45V8tyHboc3bZZ6vAQmfo1FVHtAYTj9DaWJ2IRZB5DQ+3LorA14nGjes8FknN/0paJcgi7Z8mLBGYS2nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXpC+4ufzGRKTGv6W1zHaN9YFCsAj7nS05oG/Ezpmvc=;
 b=teG8ybI56r3vbR+mcOk77NToP4JvISEthHtE3N3J/2FGFnrY4CZ9QRxj8dyWjzXo34RxAI2J77V9RuWQpzfF24CBE3kkM4plaRQyJgTmgSh2zN6cvakW21ihMQ2XEdWBs2OB2ch8Jx16vPN4JxvwqQsa5MhZEdr/FbCCUJif8cTEm2AFMhmYva8sqocOO/dRtzcwQlJdnlWR6p50faDIntlvi3I1uvksXKxY1vp1e5Dct590my0wbCJBQZO9AZF4I382oZ3NvlIpATOmTouoU3SM+1CxrEWGP37rOSCJ+E0pKIiDbxiebmzi+u4qu+8sfIhFa2yHqxpotl2tfeLqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GVXP189MB2053.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:6c::22)
 by AM7P189MB0929.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:35:56 +0000
Received: from GVXP189MB2053.EURP189.PROD.OUTLOOK.COM
 ([fe80::9996:4371:88cd:bc04]) by GVXP189MB2053.EURP189.PROD.OUTLOOK.COM
 ([fe80::9996:4371:88cd:bc04%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:35:56 +0000
From: Ravineet Singh <ravineet.a.singh@est.tech>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	stable <stable@kernel.org>,
	=?UTF-8?q?David=20Nystr=C3=B6m?= <david.nystrom@est.tech>
Subject: [PATCH] kernfs: protect of->kn access in fop_read_iter/fop_mmap
Date: Mon, 27 Apr 2026 15:35:21 +0200
Message-ID: <20260427133521.62793-1-ravineet.a.singh@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0340.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::21) To GVXP189MB2053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:6c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP189MB2053:EE_|AM7P189MB0929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc519bc-d405-4bd8-a540-08dea461e8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4oxTEkdYyP5NySXz2ES1pysZiRg6vDRx4NsO6YmKcNjngIzm7WlZRm2fcAvGABqt2D1+oEpP3Tv16wUWzJG8TETOSnco73UCRNwbzS3QwGYAPya1RRW+ekXQKQ7S4BDO+d2RgkctHK8AyrrT1unhBt750n7cESRKdSCTQ7j+tckM7beOhjsUTJkvOLJXhGp+rmqnd8iwsVoLL2giK+e0qeQXrWnu95YVD+2FHMd2flf0GQXi/1AoapCmDpaoLaoazYGX0lVBTUrvWjEeUHXgQ62gk5RT0tMZWh8YW1E1UHlPfrGxRDuSokXMH8UxR/vXcpZFdXcx/vxu8X1Y9gJfXUwfXClphSZ7o9q8qKxFcWtkHjhwSihO2wT9GiUDvHdecNF5OXvreDwp3VrPcFNsd36+nQO+IftpUePZjU7Blc+ej0DKWG+zuKsVCsknScOSR5MBLtBpeHjreKflW7CXsN7z0XZluKAhEPL2M3mx0op2kO6BGf3Vtpbo1ezc9Z0du/8Tw9LR5Ot+G51DwmIi/RNqKoFngOZ+O9Ry3Zfsd3eDehKjnZZH6iOF73NMsb+GPTeSJump34A4bmsWQ0vXqV4af5Q5cj5oF1RrdmHl/c2kAYnOWam9470epV17Ai0xj7zA1QfcOdyaMSMbsjbV+MxtJCdo471mtKOqqXUGJYOYgHGweaz8TassmIJgwUcd8V1HPMGPfdy7UhEvXjtWeVZvTdNrjKZKPlPqQQ9eGgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP189MB2053.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFBMXlJcWg0K0o1aWU2Q2tIbXo1elRMb0VHR3ZEdVFNT1VCbU9pVGI0MTIv?=
 =?utf-8?B?dWs2bmw3a2dOSlVja3Z1V1ZZYlZJWko5eExVQ1JDc3lEN3FncXB6SURuWjIz?=
 =?utf-8?B?czFmZDVpVHBRZWRiMWhBZS8zU0pqMitaOGRJS0p0bUwvTXc4UXo2T0xvVVhw?=
 =?utf-8?B?cEpCTkFxTHJxK2hybmV1dUpHZ1ZFMmVyMXV5UnRMK2NYZzRpYXlvektPbjVL?=
 =?utf-8?B?TjJ3SjNyTVFtN1N3cngwajFReEZQTWNITmFmSVpyclYrQ1BFcjVoaGwwZGFF?=
 =?utf-8?B?bzNRRW1XenlmVDhUOEgxOHpaWTA1SHI3cGlpdVoreERMTHF3MzQvTzc5SHNu?=
 =?utf-8?B?dkpSOEZNVlQ0VVNOamZqQ1ByaTV2QWRIcjEvVEJMdXozMnhGWElHdituaHA4?=
 =?utf-8?B?SlZjMFhIdXhhWFg3eXVKTVdGbThTQTlJbmlucFNNcG9MQlhZTzVQaFJDUHFD?=
 =?utf-8?B?VmUrWkVvc0FqdFBybmpidDUrOVI0STE3T0Z6bUpIckRvcmVnc29tUVFCeCtl?=
 =?utf-8?B?ek04MkdJRnJnUTdYZnQ1ZUZTMGxYRjMyWFZqYVV2MHZGditGNjIzcnFwa1BD?=
 =?utf-8?B?dDJXcWJNM0JTYTJ3MGU4YlJicmZUSkpyUjZ3eThXTzdIZlNna0pEbE0vNTZy?=
 =?utf-8?B?cmFjaWRaRGRpVUhydTYwbEM0bS9acVZOam0wc0habUtPemU2cmp4RHF5UHJ4?=
 =?utf-8?B?eFBuMXBnaE5FZWtLK1NzS0hmTnJDM3lyUnVRb2xsdlpsZzJBOXBuUGw3bFBQ?=
 =?utf-8?B?NjQ0b1NTWS8vYTVPZTFwa3dqWHAyM2xWeVBDa2VjaEgweklWKzFCS2VwTHFF?=
 =?utf-8?B?RkxJV2hES2VCWm8yR3QreTBsTHo5MU5NMWt6LzBWZ0xMdXlnam9ZZjZ3NjJ4?=
 =?utf-8?B?USt1eFdHdUJ6V01VSzdhWTVyaFNxcTNseXpqRVJwckx2Yzh4eFd1Ky81TzdN?=
 =?utf-8?B?WlM1NTAyWUZkQ29FQXpWRjRWdHhaTHF4OW90ckt0T21vTE9sNmxRSGxSaTg2?=
 =?utf-8?B?U2EzWmVMVy85aytxTTIrcDJ6M2xMTXQ5dDZoOWYyUGlYaXNXSVVQNFBqdUdq?=
 =?utf-8?B?cmI5ZHlTbUhFakpsMzRkaFZiWWJsVmkwVUlKVDJNd01pTVNZT0k0Y0w4Qm5i?=
 =?utf-8?B?QVpyMnJ6eGI5Q1NHOWRJOW1pdG5tcDVxUW5EZExTUnVJNmNlWmNCQmpqR2sw?=
 =?utf-8?B?bDUvZTJMZ0JXN3lVY01yaXZNcTB0amVpUzlMSjBYbXgxRi9uWVlUZWdYak9h?=
 =?utf-8?B?Mmw1QjIvOU5zcmpRZGVDUW5EOUgrSHQyWkFJUGtjcFlZMnRoOW9FcWh0OXNn?=
 =?utf-8?B?U3R5RWdiNVFZWnFIN09Ya0FWWWNLYUM3MU5NeEJoMGd3Q1VUdWlEcjlqV1FS?=
 =?utf-8?B?TTNDb3VPMFpURkVzT0NkU2N2dWF5RTdmaHBDQnBvZnkvbk9ZS0FWVHBBZUo5?=
 =?utf-8?B?SWJkWWY4K3BOYllaQ2x5aHFkY2hGWmZva2tYSmpGcjZJNktiaklKUW82Rk9l?=
 =?utf-8?B?eEFmdktSbDZjei94OWpjVnI1ZHRWYkpHc0ExVE5WUEx2YzRQUkdjTEdzd2gr?=
 =?utf-8?B?UHEzTGFYc0tmSVFna1h4WURuNnZhc0VLbHF5cXQzd0dlYk8xZmpBZ1RkZnY4?=
 =?utf-8?B?VW5OL0JmUU1SM2hsNitGUERKTXhZODRLZ2Q4Z3V5c3JOZzluMTdLZDBIZE9V?=
 =?utf-8?B?NWQyalhWNmR4RkNNS0JKSkEyK3R1Wk1Oa1dBVDcyenlWTGtSSjUxTnM3TzBZ?=
 =?utf-8?B?R2l4M1p6VGxyeWpzOUFCS1dVbHBNNkZSTlpocG1iZEtjbU5pRlFoRW80Nk5O?=
 =?utf-8?B?L0hqOWFYUmowV1Y4ME4yLy9QWDg2YWdWSElEcjAvMDRleEtQcFpPUVZDTmd4?=
 =?utf-8?B?c1BhV2N3SzRmSkFZSTdqWXp3TjNFZG0xZE1BaUVsQSt4bjlZaWZ0cTJMSWE3?=
 =?utf-8?B?VmRJQ2FvN1NCajBCa0QyV09jQUNPWDlMck53RkdxM2Mrc2pOQzRRaHlSYWpl?=
 =?utf-8?B?Wmk3eVRySDJhMllNZ3FIdkVhbUI1Q2hoQkgvTDJBcDRKeHhrTU9uNzh3VWRX?=
 =?utf-8?B?NEZiNFZ1NkZXcXpMZE5YK2VJWXVhRmFXSStaY2x5eWdRWGp2OVV0ZmRRemhY?=
 =?utf-8?B?aFFpOUhpb3RsYW9CQmFFOUhqUGdoQ3BpN0hGeXN0ZkpML01Ha0xlVitRNktD?=
 =?utf-8?B?SHE3R1ZZeHVkQTVrelZyZGlVejJrV0tBcXdNd0ErMjBzSDJJMkxBb1NtM3Yy?=
 =?utf-8?B?d1FacFQ0bm5UTWZqRHMvdWdVcEN6ZVVsdDVZZWV3MzhzMzJ6dzdzV2RYVlNq?=
 =?utf-8?B?SjRkRmpKS1owYWtwWkRVWmtoQnVQcUpZV2p2SVFYdWtwaUZueUtOY3JwbUZV?=
 =?utf-8?Q?1qVzQaxrNwnOCEd1Ff5Y+TFs+3yHyXtZdudLMZewku9el?=
X-MS-Exchange-AntiSpam-MessageData-1: FHbZxZB1Y57qZLnpxP6EkTXmIh/6kNMcI6E=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc519bc-d405-4bd8-a540-08dea461e8c8
X-MS-Exchange-CrossTenant-AuthSource: GVXP189MB2053.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:35:55.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1Whgho0/j8wd7jxhTn9wyzt1iLzLj+ixC6gxn2yakfm4kfpkuSZnzg67YZkmylbzgiRxVEgbpOWzqd6DJ07EgH54hH8M7UgAJN/aLmdn1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0929
X-Rspamd-Queue-Id: 0BD054739B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ravineet.a.singh@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:email,est.tech:dkim,est.tech:mid]

kernfs_fop_read_iter() and kernfs_fop_mmap() dereference of->kn->flags
without holding an active reference on the kernfs node. If the node is
removed concurrently, this leads to a use-after-free:

[  448.037888] Unable to handle kernel paging request at virtual address ffffff821d8cedf0
[  448.093213] Mem abort info:
[  448.104535]   ESR = 0x0000000096000005
[  448.113391]   EC = 0x25: DABT (current EL), IL = 32 bits
[  448.126411]   SET = 0, FnV = 0
[  448.130758]   EA = 0, S1PTW = 0
[  448.134268]   FSC = 0x05: level 1 translation fault
[  448.140335] Data abort info:
[  448.143275]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  448.150223]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  448.155668]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  448.161233] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000afab8000
[  448.168835] [ffffff821d8cedf0] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[  448.178817] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  448.284717] pc : kernfs_fop_read_iter+0x1c/0x1ac
[  448.289416] lr : vfs_read+0x1c0/0x2a0
[  448.368374] Call trace:
[  448.370855]  kernfs_fop_read_iter+0x1c/0x1ac
[  448.375156]  vfs_read+0x1c0/0x2a0
[  448.378508]  ksys_read+0x6c/0x100
[  448.381901]  __arm64_sys_read+0x18/0x20
[  448.385768]  invoke_syscall.constprop.0+0x4c/0xe0
[  448.390502]  do_el0_svc+0x3c/0xb8
[  448.393898]  el0_svc+0x18/0x4c
[  448.396990]  el0t_64_sync_handler+0x118/0x124
[  448.401377]  el0t_64_sync+0x14c/0x150

Use kernfs_get_active_of() to obtain an active reference that also
checks the released flag, consistent with other of->kn accesses in
fs/kernfs/file.c. These paths were not covered when
kernfs_get_active_of() was introduced in commit 3c9ba2777d6c8
("kernfs: Fix UAF in polling when open file is released").

Fixes: 4eaad21a6ac9 ("kernfs: implement ->read_iter")
Cc: stable <stable@kernel.org>
Signed-off-by: Ravineet Singh <ravineet.a.singh@est.tech>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/kernfs/file.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1163aa7697384..6a52d24a63156 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -293,7 +293,16 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	if (kernfs_of(iocb->ki_filp)->kn->flags & KERNFS_HAS_SEQ_SHOW)
+	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
+	bool has_seq;
+
+	if (!kernfs_get_active_of(of))
+		return -ENODEV;
+
+	has_seq = of->kn->flags & KERNFS_HAS_SEQ_SHOW;
+	kernfs_put_active_of(of);
+
+	if (has_seq)
 		return seq_read_iter(iocb, iter);
 	return kernfs_file_read_iter(iocb, iter);
 }
@@ -458,6 +467,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
+	bool has_mmap;
 	int rc;
 
 	/*
@@ -467,7 +477,13 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	 * without grabbing @of->mutex by testing HAS_MMAP flag.  See the
 	 * comment in kernfs_fop_open() for more details.
 	 */
-	if (!(of->kn->flags & KERNFS_HAS_MMAP))
+	if (!kernfs_get_active_of(of))
+		return -ENODEV;
+
+	has_mmap = of->kn->flags & KERNFS_HAS_MMAP;
+	kernfs_put_active_of(of);
+
+	if (!has_mmap)
 		return -ENODEV;
 
 	mutex_lock(&of->mutex);
-- 
2.43.0


