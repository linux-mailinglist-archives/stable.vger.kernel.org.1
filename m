Return-Path: <stable+bounces-237826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNy3OhQp3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:46:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB43F98E5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166573075848
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E683DDDBC;
	Tue, 14 Apr 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Ohkw8N0l"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247863DDDD3;
	Tue, 14 Apr 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166841; cv=fail; b=ZzFyXHCgWxcwXah2Geeh/toROD62bHHx2Tg4w97tJl5jzc6WJ8WGOk+eTBWr0e1yyz+Z2vFAs1+d4YJdDSKICdIXCx7c6eMav+CYt+0Lr2VCwybxH2ShP2Zkt1qzNcuP8b/S9H9zFp7zrdAzAWLHprNvmy3dLW19jSN0MObSn5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166841; c=relaxed/simple;
	bh=Z+/b8QBxV/gqlFap3sEVX+0qRUVhs/KiVUs8UmBxgQo=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=ev+BMx0iJGg3bs9hs3b1uNJAZIt+NdnlFj7J3FNHL9HAmEJYWCffdSYskKkaiqznGiBFWsU2KmIUgPmrPstF+/Y0Wa0RkrXcfj/RFPhyxAn6NpNGgwtM08QF0bdJBcK48SZCdxqVOgOlSj7zd0OYvBfuT8iW/jEf4CisD3/I5+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Ohkw8N0l; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBRsC9Z9nRYbfXNZCBRLcQshjlDBdMW2JMz0rHcX3hM9eybtRblfk89kb6YWCiFvSfWdK9OF3CA3XVfaS48Qs1lBY4pd6+hkRHMnmS9ff1KtzKPQZQq67i2EE7uT5+TjTrvs+13vuv84yJ05QBsAr3ECXjktcaoL6Ue+JL4uUzOsTa/zy/P2wRzIsVP9WWHhJwTXV2nQUC3sk4QiWSiyTjSWn/ggrtpm3mF2j6PKz+4vNhUycUJ5XFgzjHXTVR/12OL/U+NA4UhXwxx4tzcfKHZrTWhGO7qj/idbj52/DCxKNck/9BAKtnDIEOyPn8AzHoYG7t0XSckG6eLtvx6WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQLCmpXvYWJ+jy94ebRnU764cBhbHssKW8paHzKH9SY=;
 b=kNbJ41CPxWAclq80lQhGyiWU5n+M4J4a1UXd7ZIoR8GWNs68oUb1Nl9w2iE3kuCi1CdpKi0dA/6CfqFT6n7Q428/VpS4EM2wywCwvp6jeFsIa2jpXdLuELwwqaTogajrBsT2R62e2by3iaTsr6TSjYzgLhHs9Az3NsDcOwyQZBSl4jVJgrs2d2/TCLHpkTTRhmD5zZu2jJpT8MVHq9NqDLmvJfi54bOFs9IeompuHPj5P95vzOkqwXrnxLBkxfCmH3E/BF4oLkt32CjjLWvEXykxnopYORi7FmFwMzE3P4J181XKfuJUQGGAwrSoNtvkMpFaXOV2gtEvjkJB1cVpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQLCmpXvYWJ+jy94ebRnU764cBhbHssKW8paHzKH9SY=;
 b=Ohkw8N0lZJdWmtYkog/CDeE0/F2LY9GM1HfbjhORRSSQGyxWTNsz24dVsNCbjXQEM0KjGYtMUPLfrrPN/ENBWKJ4xsvJ+0L0YLb6oX/fa+aBYmoVrPY3z7EaQbf+4ezrLSi/nHmGawfFa7fpJe9A8EekSbUwZ0P/slLum0dV4nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:40:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:40:35 +0000
Message-ID: <ca758574-b32f-4614-88c7-266acf9044c3@cherry.de>
Date: Tue, 14 Apr 2026 13:40:33 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: How to backport (with conflict resolution) CVE-fixing commits to
 stable releases?
To: Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, CVE Assignment Team <cve@kernel.org>
Cc: workflows@vger.kernel.org, stable@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b26b4c-98d2-44d5-3113-08de9a1aa483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|13003099007|18002099003|56012099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	Ys+4TdGHl/nQDYTqBcv4Y4dzefATyGrVOcjlQrsz5bR/AvyI7DvT6ByzfxTKYEUEMMxxQ0m8RGAUaVlSZiTBgvYRNWNR2yKe4bzButMGn84IaYBRdox/3FiwOt3M6W4hI37C2my4ovHP2oemjPupalvyaYRsZfGMTHcDEJWCHhh8+dUAZT2bYmtlF90mKQ6VKE8vIlHyksWNtKhsMvFYQ3uRddMChVWY4LPl2dfNKWhrmGBiPyeQ6TBQaMudkYS00/J1F5Qjuiee87Hg42SPKfbgEOGiLMxKwgZRBXfgDOViFCcG7OFpSjbuwPOjAUq7IABWnGu1QW/jpS6jhmNVZneAAumjfUmj4aiknRpogtKwfGx0+6dWklp+guWyKvxgtHoJfBB848u5NBzocX2hs+cGjSzROMt6ZY6yLBCGTrgdV1Nk8H9V3gkKp9Lr5xK+bp2Do8FWFy9u7O51UgnfkoMAVHtGkyvs6sdyXVRO6Lgh7Q9hlQQDHNKXb5aqo3ZQf+8TqOsUlZ32/ephhhsWuUvFl0CeW7+7M9S0rV84EeqWNjfwjtDyOvgxijiPisIBNSPnpLxANYqt1ff4zG4eE8TVvNOSH3KF0mVg87rlmp/hN9043BcWoPxf9rd2ir4FoVY5PzDrmLQ1QH+JVGtjVvdnLRoOqo5pXIksNYtYte2BZCkeCaYdWJCR16XOjgNs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(13003099007)(18002099003)(56012099003)(11006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBvY0w5OHBhVTRzVHZXV3JiVjlxR3RsZXJ5Zk85SlduSzI5SkNJS1M5K28y?=
 =?utf-8?B?TEtqcDVYVVhyVklxM3h2dFJWQjZESzNPMWltVzlxeEp6N1F5NTIvMVhSZlJ2?=
 =?utf-8?B?ZFZhYUw5TEw3Y05DdDlhdlBWWVc4Y1FiYUkxdlN3aWlnb2IzQWxYTTlnL1ZQ?=
 =?utf-8?B?eDNUaVdpUnpBMVVHNDhkcS9iUncwb3oxNllrOFF1SnNjRGtPcnpRTFg4S1Ax?=
 =?utf-8?B?TSt0WHNQNzhiUGdMbkIyM3dBRGpoOGNYMmMwVWFJVllDbnVLdFVhTHExRUtr?=
 =?utf-8?B?WnBJbVhXeDR1QjI2RzZBOWNEeFMwQWlPUE5mZ3dyNlE4bkgvY3c3V2lRc2Qy?=
 =?utf-8?B?MWI4dGJHTFB4YnZUTGR2MldWSTNnZmlmVXhKazBaUzdxZkVhQ1d0WTFUczlV?=
 =?utf-8?B?dXZDT1pRNGlEQ1czUGIxdDhnV1lSeVRoUEw2TGlDeWJ5L2JSMjJTTTZFc29P?=
 =?utf-8?B?K3FkbXF5ZVArOWtaQ0d0MFNpSGM4Qk01Yys0M056TEZXdVJNb1lTZjlKSk9s?=
 =?utf-8?B?bmswMU85a3hTc3c4N1ZZMHRKUkVjRlNBRC9Qa1I1RVFQZi95Q0IyeEdnL1Nn?=
 =?utf-8?B?R1VkZWdwMEFzejRvQnoza05jbFEzZkIvLytGR0dEWjZFVHM5WTNKSWRUTGFk?=
 =?utf-8?B?d2xhNlBPM2x3Q2NobmQ0Nk4ra3hRaXVIblJvL1hoNnhCMmdNQ250Y09EQTQ5?=
 =?utf-8?B?cng1cWFZVjBjU3RjZlhPMDNnL3dscmF4MzJvTUU2anVOVG90alNtSW8xczZ4?=
 =?utf-8?B?WUJwTEtPN1M1b2FZK3ltZ1lITXJXZko4NkxtSEVPR1pSREhYWXhTWDczVHAv?=
 =?utf-8?B?SWdibnhvN3BiR1pMbGZzVk52L3RDaFhtTVhHNXNlK1RQZlF6bXMvaW1GNkFr?=
 =?utf-8?B?VTFFVEJyMGtUVTBCOVhoTS9sQTc0T2JtS3BYejRDVFZSY1I0ckZzM2JRSGhS?=
 =?utf-8?B?c2ZiSExoZm5zYmM4eEtXbWF2dnRwclI3V0VTMzM1YVEwUG1wR3NCNUEvVXBy?=
 =?utf-8?B?c3pUUHNqWUhUWHdzb3dEUlBzMEl6YjRlVTRKdlFETmJ0dHJvc1RjZzc2T0dq?=
 =?utf-8?B?by9GRXJVMjRhcEhnUWdTZ0dabUQ2NzY5d01FTktzQzdjTUZFM1VLOVJEbm5u?=
 =?utf-8?B?aURUTmNGWUxaRlRPS1VBRDUwMzZrQS9Vb0t0cTh3ZXd2YUVKaC9tbmFoRjE3?=
 =?utf-8?B?aGhQcXdHai8rbFp1bjArL0owbXhEdGVYZlBmV0JLeVpZc2xqSVE0UDROY1dX?=
 =?utf-8?B?S0NLTHMzRG5PZ056M0tvaHNRZGpUdVlLWFprcHNBVHJFRDFVUm5qeHlXSnJM?=
 =?utf-8?B?UmFvM1B5UnZCUThLMzhGNWV2ZmNMelRGdU5KeFJ2aHhRbkY5LytYalhjR3oy?=
 =?utf-8?B?TTBkTC9adzl4TUk2L202VVFET1M0dnFiUC8yalpvd28vS044MXVDWG5PUHho?=
 =?utf-8?B?WVE0dldJVUNsZHZsbGRDczZyOVZKMzhsNk43eXhLUklqaEorVjY1bHpYbTgx?=
 =?utf-8?B?bUZXa01ydUtnMCtnVTh0VzFZRFNTRWRTYWtPK0ducFJCN096eUFJMlltOC93?=
 =?utf-8?B?OXJCSXZpVm9qTXhEdEpSbTEwVlg4ZVlKdGVOUkE3N0EwRVRQOThBNVRtNC9E?=
 =?utf-8?B?VVJYQm1Ia2xrdUVmVUdQY2M5U0g2V0tmWGFvdFlqelVMNmFiNTMraFpuSnpr?=
 =?utf-8?B?ZW5MWE94L2xnandhbEVtNGJxSmFVRVp0bldUTVoxaCtIN3V3VGxGcUs0aWla?=
 =?utf-8?B?M0VEL1d2ZlFrK1drUCtwM21Odk4zcWtNM3dVZUJZZmtsVGozR0hqUW1td041?=
 =?utf-8?B?SFNDTTlsdEZKYmRKWnE2K1dDdWs2b2RWUHNSeHJrSlduYVZZWEdUeHVGK09o?=
 =?utf-8?B?TTV1QnJJZ0d2ZzhXLzNhVVlmVFNoR0hUb2J0NkV3SEdqYzdWc0JEODczZHdm?=
 =?utf-8?B?WW42WWcxc2pWUEJNeEhUd3pWNUJFb0dZdHRPYlIyYmtaNHVhZHl4QWo5QWZj?=
 =?utf-8?B?SmFjUU9lcGE2V01PQ204NCtadzhLSk9TUVlRYlVsY1VTaUwwYlpCdjhhcnlY?=
 =?utf-8?B?R2k0NzhYaW51S0tUS2M3dVh0K0lJdHJuV2x6VW94YSs0Mis1MzBhVy9Pa1Ja?=
 =?utf-8?B?Z080RkZZTWtRMXRJK0NYRGcxMUc4L2ZjaWRYbUtUV2dRcHgvamlhRjJvU0lS?=
 =?utf-8?B?UTJkSlNIQXNRNW1CNzBHMlllaWtsb1JmeHRFMU5PUlg5SmtYRjhWQXU5REow?=
 =?utf-8?B?UzY4S0c1aE9GdFlualliWm4yekozQmJ2REFITVlKV3VFcTNzQmxaZG1oVUR1?=
 =?utf-8?B?NXpRRXdzNEtFamFuWEdSN1pMQmtEeXhXK2RiTmNua1lsR1NacXZ0QjV4S3Fj?=
 =?utf-8?Q?1dTo7u0gBITNS01ZFeJVttcSBbjxiEDSQyYNU?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b26b4c-98d2-44d5-3113-08de9a1aa483
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:40:35.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEpkhhaeLjlv7wVlWHqL6UKjOr1l8Mozyc2ZWvY116Bqu1y2aHCDiOKu18myNTzuUseCMy6i0BgSVvBLLjOG95MjZQj3ok+mooaumeX4cyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cherry.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237826-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kroah.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cherry.de:dkim,cherry.de:mid]
X-Rspamd-Queue-Id: 85FB43F98E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I would like to backport 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a7ac22d53d0990152b108c3f4fe30df45fcb0181 
to linux-6.12.y. It is not a conflict-less cherry-pick as many commits 
have been made to that file between 6.12 and 6.19 when it was fixed, 
which makes git-cherry-pick conflict. I believe I have a patch that 
implements the same logic (moving code around, just that that code is 
different since it was modified after 6.12) in linux-6.12.y that does 
the original commit in 6.19.

My understanding is that this means this patch fits Option 3: 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3.

1) It is not specified there what to do with git trailer tags, e.g. 
Reviewed-by, Acked-by, Tested-by. I'm assuming 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

"""
However if the patch has changed substantially in following version, 
these tags might not be applicable anymore and thus should be removed. 
Usually removal of someone’s Acked-by, Tested-by or Reviewed-by tags 
should be mentioned in the patch changelog with an explanation (after 
the ‘---’ separator).
"""

applies here but I think it should be made explicit in 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3. 
Did I understand this correctly? Could we specify in 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3 
what to do with those tags? Also should the people whose tags are 
removed be added in Cc of the backport patch (they won't be 
automatically with git-send-email anymore since their tags are removed)?

2) I'm also wondering if we should strip the Signed-off-by tags used in 
the original patch's delivery path to Linus. After all, it'll go through 
a different path: to stable "directly". For this specific commit, it 
doesn't matter as the Signed-off-by are for all authors including the 
maintainer as last, but the question remains, I don't believe it's 
always the case the last author Signed-off-by is the same as the 
maintainers' first and last Signed-off-by in the delivery path. What 
should we do?

3) Finally, the last question I have is whether it's 
required/recommended, and if so, how, to tell maintainers of 
https://git.kernel.org/pub/scm/linux/security/vulns.git that this patch 
is for CVE X, in my case 
https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/published/2026/CVE-2026-22986.dyad. 
Maybe their tooling will automatically pick it up once merged, but I 
couldn't find documentation either in 
https://www.kernel.org/doc/html/latest/process or  nor in the vulns git 
repo what to do. Did I miss or misread something? Is there anything we 
could add to 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html, 
https://www.kernel.org/doc/html/latest/process/cve.html and/or 
https://git.kernel.org/pub/scm/linux/security/vulns.git to make this 
clearer? Greg seems to be saying "patches to vulns.git welcome" in 
http://www.kroah.com/log/blog/2026/02/16/linux-cve-assignment-process/ 
(Chapter "Changing a CVE"). But also "this is automated" in 
http://www.kroah.com/log/blog/2025/12/15/tracking-kernel-commits-across-branches/. 
However, those aren't on kernel.org :)

I hope I got all the right mailing lists and maintainers in the mail 
recipients, feel free to add more appropriate ones.

Cheers,
Quentin

