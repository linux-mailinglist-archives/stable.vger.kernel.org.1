Return-Path: <stable+bounces-217844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OQRBtv4nGmJMQQAu9opvQ
	(envelope-from <stable+bounces-217844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 02:03:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341718067E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 02:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1256D304FA4C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B511DFF0;
	Tue, 24 Feb 2026 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XasyQ/Q3"
X-Original-To: stable@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010021.outbound.protection.outlook.com [52.103.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC601C5D59;
	Tue, 24 Feb 2026 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894996; cv=fail; b=YfIoL+U+Xmg+VlxyhcLMnE8VWuIMxP6FhfNbK22fuKdG/liXpHaTXfWjpVWjjB24EXKsD8QsMh3TsFtFQ4p4MikJtqeRcjUUU3CM4EYXs9K3msqKqBNetgWhNh3bvinvrXQFxkbtesZ/ucUF0aeL1ZBlNiNeezzkelkTRjtz8DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894996; c=relaxed/simple;
	bh=PIKSYEffwn7orCLwQyqJv/cVlTzxSXsTwBQnL2JyT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm1Zjwv0ghquXLp8AZNLyUdnRBmddcOGAOlhlPYfQ5gEyiDDkMGg2TAo1xFGTIro35oy8Ms5JqFVya0UYaRSiSzG6WfJj8j3yTIphYyC4Bc+30FSrEKDkrcn2UbvpdVvNVnGxg4ugGMsDvDlQ1mnwVYvqW/WqQmfIN3yvDY1VvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XasyQ/Q3; arc=fail smtp.client-ip=52.103.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISOG55QDhYgbtQrnFFuGqXZPe3XH3oNKqkDA1ntbFa0EEwQ3he5SkMUc8vZYCbnzuKIuuOJfPutqJshYNKECChBgTp7Y4dW6D5eW0mM2X64CVoIs/ZT5NuGBAEeuw5v7AaUXI4QESgZzi6aSwNlWnwdF5jNJKhlFZbJAJQLMlZzFIMZ9TcSKtG6g6u0mqW1oszc5hez06MqRxAcGALGaobhIZKkVKemjOHTcQDt+47seOBpUUaY4xqog8yQmh9bcKix3U6CzzIWywuEXevdvsqf3Lg228GVOQyPmQApHAlzgBFsH7hnAULUKqOvwtvqDandQ7m/8tHZvLbRoPQXnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIKSYEffwn7orCLwQyqJv/cVlTzxSXsTwBQnL2JyT1w=;
 b=Kda6LGtfZTw8W4WwmSQhLNyACn85ec8RRQ1/Dw73X/mrOj9bjphEKT4ZZbRpyYpkFfXSI1IjGGXPbh6ILZy0tJwKXur+/kT/r8lSwLAIiRZ2NzsMJm36SHVsykalymBtaNFHcZ0dhJXBMeYzLwnwGalYJOhe5hlc0HUeRBMgK1Pp1lmfpXYK1uNLOdXyClSSJtLvMhLoVLPC8S9GU0lPbkhPv2NiD9rMMBruY5kA3srNKdJZSZwkUFNHoP7Y7AI6qG7kv3rB00NrdH0a1BfvJfSJqVU7wMogWRkZOiMdmZD4FROuNzAnU5crD3yK1Azsvb6RutXY7+HA4zt241vWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIKSYEffwn7orCLwQyqJv/cVlTzxSXsTwBQnL2JyT1w=;
 b=XasyQ/Q3RiypsaWRI2Y6wr3j0ajysJ/Ben2cIV6iINcd8IoDVk1YoaoeL0895d6F6TMWwIUlpKzi5vs6KbklAkeYtPP6WXjN1KZBuA5X+9oJVliktGtgmowz/vbASv2YIESrDd5VHXYFWVasyB7SvlH3QDnoajejFpG55C2rVj/qE3dw6CGiumfbIStFZo/d6cmzCfPcwty8tl6xLSEl413s0UM8zQXmAWcRTD/sc/OKU4QM+LsJ5p6pyc3Hj0496swUxXTzPRMLMzrbBTiqWTsbh/RhV5PHxAPO5j5h7vkOv48hxJhZc44+zq8wxFqL/12s84/RgHTZEP5F42D1XA==
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
 by TY4PR01MB15003.jpnprd01.prod.outlook.com (2603:1096:405:25a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 01:03:11 +0000
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50]) by OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 01:03:10 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: andrew@lunn.ch
Cc: ben.whitten@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	jacek.anaszewski@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavel@ucw.cz,
	rmk+kernel@armlinux.org.uk,
	stable@vger.kernel.org
Subject: Re: [patch net] net: phy: register phy led_triggers during probe to avoid AB-BA deadlock
Date: Tue, 24 Feb 2026 09:02:49 +0800
Message-ID:
 <OS7PR01MB1360256D2CDB85F5042A4CBACBC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222152601.1978655-1-andrew@lunn.ch>
References: <20260222152601.1978655-1-andrew@lunn.ch>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To OS7PR01MB13602.jpnprd01.prod.outlook.com
 (2603:1096:604:359::9)
X-Microsoft-Original-Message-ID:
 <20260224010249.1090-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13602:EE_|TY4PR01MB15003:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9eb812-e42b-48b1-0990-08de73407a37
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|8060799015|15080799012|23021999003|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zbnr9rQI0/kt6TpZSdXlDmKGsqSPj7fTmd5+gp1qUjKFTNRI3lZMsbeTa1wl?=
 =?us-ascii?Q?yjyfy4C5k/s1hWvaLLWLk+1AwT0uu8lhsyPaBGzl5TcVhxV2ms/+RmeJmisY?=
 =?us-ascii?Q?A18anB7WsDRuQm2Bxc4s6sQbcY4v6VjTKVLCAj7ND1UBioY3l93DuNzLQTR7?=
 =?us-ascii?Q?Ji29m8F43eu6DJeetb0YGxWwOx1ESipVUIgAAfNSu0a4x5f6NEncAP9g4XLi?=
 =?us-ascii?Q?5fm4tgpEx+u2huQpoivamz4l1/W099vqr4dI0Ja3HVKoobQwNgabC6MCNHJ+?=
 =?us-ascii?Q?w3fYcRKHuEer8XSJ/NObf1iWURtCFKY3PmnbnfQNUrlh69HkxjS3vHnJkg7e?=
 =?us-ascii?Q?Xfacn+30ox2hgMJQGgNzSI6nm4eYfV3JIAtgVCQ+SdCEpdJjkMQryhtpbPzv?=
 =?us-ascii?Q?mb2aJjXnoNsxRTWWqucYcCvEwD96KGHu6sPb75ZMKYHNM41WUc4sDzrO+DH3?=
 =?us-ascii?Q?qrKf+7eN90JuXgKbTioofqWgKBPa57usnX0npt+OJSvM+9ABhGjYej5vIEbI?=
 =?us-ascii?Q?hfc+SYFS4UQfswZowKy+dSSwsJH6ZO7ZXsdlIG9HzAmHJHaFx1q9Hz9VB6kd?=
 =?us-ascii?Q?bjK1ZtsX7luTUfPVlNA7CG8x8VVfR0DoOsfkYWWxCAKkfKmSYrlvkYijCJpD?=
 =?us-ascii?Q?6atq4gSf4iDKR2fGK4/wu4Vq0gDIDLCTXn1m6GImNbSFrddiTJ/cWJ19nQH4?=
 =?us-ascii?Q?DqDRuwO4jOd2AUcUUSO5ETk+TA+af/uGSuiFXSoV/9IU/P9r39/t2d/ol3EF?=
 =?us-ascii?Q?1i18zTFeNjO7sdtfuyaVFhjUFX+8Z8YnM3pkn9w/eQYnJztKEABTqWL0rwUj?=
 =?us-ascii?Q?jU/hIaYQhv7OsIGS0j2oN56TmnV932qXKyZT4TzvEXYDoV8Qm9u88lqE5rqc?=
 =?us-ascii?Q?/KwA4P9Bty84jR+TvqWtLzQhG/JMTDGM7ExKQnJVmJkFi1/A/LG+0wAOGFy7?=
 =?us-ascii?Q?MPF/YRn9h8blbxpo0/zAoqhvtk8mdI5AO5EAt20QGRkKncxGES2r5nwKlrxx?=
 =?us-ascii?Q?hMvlr1CMir/egyKY4pn+cvt8ccHpXW2WbZnHoEnqKfdmA5neYYKeQlq+5Kv2?=
 =?us-ascii?Q?IhJxsG+FXG8CHXvTTNAvHLMwJ1jPoFjBQibPRYjzVcJGM84SOxKSmSP5g7DG?=
 =?us-ascii?Q?XYuSMNiXGfOIgoeISULKgZsVwJpMavp3Xa3zSAe5EN1nCcE/vDKsQAAFqh5O?=
 =?us-ascii?Q?9kNYtCQ5uS7SAEEI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jghrfol8xIlijoY8nA1Tvk0slufjHrpBxFvYhFMLmJt7+Nrlzd4TbMMQCOsi?=
 =?us-ascii?Q?jUMu+Dd9r4WUghbep0jVhm4P6LNVaJDVCfiO6HFFVMXDNMdhPUqHvbRa7U6x?=
 =?us-ascii?Q?fJwU5KIHEh1E/M7EVCZyfu0kLbu0WKFrbW/FnhfFrO8/LXY6zTHpg1IH7B8I?=
 =?us-ascii?Q?5QDtJVx4XVL/mGOgB13AUx9167znYbYXtSCJagfeUg0c9wVch1tbllAvU892?=
 =?us-ascii?Q?kBqvQYMu6wUAK+TyL5vOD4P2sIW5ijHqAk3hwCqi4P16/JcUayfs6SgziQer?=
 =?us-ascii?Q?xb9cIkvrK93g6deEoXoSPeNl3IwAhh5hzlF8u65LVm94zgNnSrRVbG9334yi?=
 =?us-ascii?Q?eBIUdChwcS0aS5cv92bqltSRNynrE8IdZQ8dmS+nOb8d4YX5tf4FVTAIchkS?=
 =?us-ascii?Q?RQSKdsr9XnXLDQvBYxKr6vFK5JfO+3mCn/m6IZ7DRGTfaZ60uHGOAm3ZCyvG?=
 =?us-ascii?Q?emNyjFvVAY0AIdA3c7OkyAIM3BIDvPqcIbPm0vskb5MfbZA+pE89qMBtEok+?=
 =?us-ascii?Q?dxFvN9s8nRMtwE6RN5ZhQnBcSg0OZRl69RMxJ1tcRVGsLrQteH6DGFu5NCUX?=
 =?us-ascii?Q?nqyP+Fi+tiUmyfwR9HHmgw8sz/7IFPldRaZAhkn+34/VgPMtiE0Y7IFs4828?=
 =?us-ascii?Q?l5/PBpaUBJZTddtey71ZhjKcyWlpgKKkcRIheNjib6/Jm+jdBAqJPO+k+t7o?=
 =?us-ascii?Q?xJYm028nbuMo2XCzyDFbc9YSc6gKKOzDo3Lcv6i/JddRR8EWpYW5h9W9yFDR?=
 =?us-ascii?Q?WFZZvTsP5dnEWEzcqI6RiHM9+Yp6c+pmYuUnthyST8wYR0Z62g/DhJKSdBRk?=
 =?us-ascii?Q?3yra/EArzsiJBhBLb+skokLVHl8HLwAAnGHfrfGNgt1mM+5X7E1xzf1Qzgyu?=
 =?us-ascii?Q?hCwX7OiOsJE2BSIrpyeppoVtR2knRxMsJYMKdrXzy+vvdjwyB00cmZEsBDO2?=
 =?us-ascii?Q?qkLF+P9hhocw4ZlZrPVd7sngsqy9S5QrpVdR0pKuH0etjLD8RDxxU4j6qz60?=
 =?us-ascii?Q?mp6fBSWAC383VAqjSG98fjmkNJ4dm/GIeKfKUTlKgt7N1GT97ydMawyggmwg?=
 =?us-ascii?Q?VKgdHTXZQ5sF8HU91f9AeR6mZUDnerCfUPlWzr2SbB4zwHlMJuydV2ZuIQ2U?=
 =?us-ascii?Q?egsWRlL6eo6BAL00XqrKlVp0Kf8u3zDfTnxzj5oHEh3uIGENQrtdbA+FQpRI?=
 =?us-ascii?Q?e/NBzV6zaKkrkQ0ML5Ja5/UhWxKQTrYAZuSa3pdN1YnG6JOcFS6PjR9Pc4si?=
 =?us-ascii?Q?HWh/8sgZSsVMJNgkU1YTZ9wDwIhDeKFHTyJEQALyE2Yw/+40qSt/r3PtZKJ8?=
 =?us-ascii?Q?UwgXcTHD9KuRAAFWORu+/2prgjujOpF6+bGeAzjRncBYJ695rTOGUabTOrVd?=
 =?us-ascii?Q?2mMcFtJl8Kcx6luuqN5RIhDyDvt6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9eb812-e42b-48b1-0990-08de73407a37
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13602.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 01:03:10.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,ucw.cz,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217844-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangshiji66@outlook.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8341718067E
X-Rspamd-Action: no action

This patch fixes the issue for me.

Tested-by: Shiji Yang <yangshiji66@outlook.com>

Regards,
Shiji Yang

