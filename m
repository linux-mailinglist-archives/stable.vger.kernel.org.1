Return-Path: <stable+bounces-217825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKgHIcOynGmxJwQAu9opvQ
	(envelope-from <stable+bounces-217825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 21:04:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC517CB01
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 21:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26ED3011A5E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1814361641;
	Mon, 23 Feb 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tDgltaO/"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1925FA10
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877054; cv=fail; b=iW9f2tStdTqJCq+HHC7KGi09G1Aax3EOc6B9sNwmgmAxTc8vIpI8FMHNlBh60Xn+Nck9dij0lM6QPJyNwomVvyLm+YAbFijfv4UnKExwnLkjj/RXeSSwaFe24LADUDC08t94/AmJY6Kxo6R6L++1vNYTSTi4YOVRyn2L7x6UnnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877054; c=relaxed/simple;
	bh=BnpTYrn1a7g0QQJnaLIQDAn96MP3j+Pp56k6AumRb8k=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Z4trjkZtrhtHVH1zwyF23wPyHppK4NP7OJDa8hkNoiONUZLY7r4huBckdNLk1a71mqB3COV1juQ0kOJQ/SFBdIaSyiz+lo9zivyFU/pElC1+V4VYUE3kQiyNgC3QQd78Xu6fEG8kI16jycYPdQXagyWhorDeEqw74SJO7PX+5q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tDgltaO/; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODmAOA9svSJ4LhSRJizZHmeh3SHO5keoWS0bmNYgcX8IY56zCuGL6HNFwPUkB3J0fd/4fqWWzEMdd10b/ddCjejU9uGw3f8H6I8yLUkINQTprxHGckCyGFfTlxyHKZ72R2TQGB34DZmwkk967dkoTeB03Z5dsFz8AmlTPp+l/vrRxb7MMXK9uePc1xSJw3NxuOZlTPeiwmkRzzpKw7Uysrjzdu+RI5CbJr24OhHHn7YNA1TF/SrYHrziS4ag0Io4dphOss1+qpw+sfnSUsevT2Wx/zuOrMu9fuVKXz+GYN521S0cwQtMTdY7o0TEKr30N1mznXq76g9AiKIGzmXViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxtZoFH+NQB9nTcNFwSx1yWEjPxDx1g7aAwoxNuBZVs=;
 b=u/D/Gq0xHWXUKnfB7JIVXg24qreKGjtziJLMHxB5mgbJidYQrdY0QVHRwBJNp15wsohN8VJZ8HJjvztgTXkJCJjQHp4VXvVWw/Li6eM83BpJGhLkLkOvnThY7GSocxKg4QNlCESwuOTuwFKW+ncn81r17f6F8jIYW/61gn8blft2hKA/DmqwkEj0FFtHFXxfaZIVdaqgESb2i1wpvaD+qYmmSJfAwXYH2W70EhDXAKMiNLo0anld29wXFrylF/T75XjBHPfUzOE9ONAK3Ew1jcTg6yIj43TgknxJF069SLt8LlV8eoXkGE8GgwetFyTkV8jzaX5dmKu2ho0UggJJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxtZoFH+NQB9nTcNFwSx1yWEjPxDx1g7aAwoxNuBZVs=;
 b=tDgltaO//MCdQqzuLfw7h25Oo+f1LIVQhMkZNZdY9FZtEdjEvDtD1As8jyYeHlaHdXNZDH+mmkkkO6hLkPRdzoxpnv9IsXY3Mr+Hk2hxoFyrijoMwBqJA7oBC/Fx1OjlpR7FA4KmAPnLOSq3d7QB6ObWLDgxRd7Hg/jrsBPIIE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:04:10 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 20:04:10 +0000
Message-ID: <2525eb93-1515-4213-ba81-6d654c5db2ee@amd.com>
Date: Mon, 23 Feb 2026 14:04:05 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: A few HDMI fixes for 6.18.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bbfc40-f3b2-4b0d-3f43-08de7316b559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHZUTEtLM1hVdnBrOUZtbWd4bXVqSnNocm92SzVWZ1VyMGZCWGc0djltTTBl?=
 =?utf-8?B?d2xVSStQSHdEYmZjUERIcVdLM0tHTVNRN0hvL2xhWHZ6ZGZaY1gzd1BodVRy?=
 =?utf-8?B?ZmlaM1o3SEJ6UGNmaWd2MHl4U2NBc0lJTi9taEZFUzU4UkY3TnZSbjhVQ0x1?=
 =?utf-8?B?c01TZEFKTDdyQzYxNVZ0STRZczJxZXVvYnpsL0xwMVRza2R2NkN0dS9jQi85?=
 =?utf-8?B?cVNHTWRUb1VobjhieEZVOUZEUXRuY3RxTkhoRHFGalZnZjByT2hiOHFUaGtU?=
 =?utf-8?B?ZlZvakFTeHZrMWJIQ1E4U0FKRGtINTZLUnFvWFBPVSs3TTVRaGEzajFYODM0?=
 =?utf-8?B?UFRJbXV2RUJZMEVZQ3ZJdDZ1K3lKU2JJOEcwdWxSUld5LzJJSHcxYzJNQjlw?=
 =?utf-8?B?UWZWMFJGQkJTTFZWYXRzbDNwK3VUR1c1QTBXV3dpSTBBcVJ6VkZIemNmSEZZ?=
 =?utf-8?B?UnQ4YVpLbnp2akdvM1BTVURmR1pLa3FaQnlsVWFPUmg4K3BiMWNJUzZPa0Rn?=
 =?utf-8?B?UlBVOTRyLzJNY2ErWCtaZFNiZE1kckJUTWhxemxTc1pEMmc3dFZnNGM3VUlL?=
 =?utf-8?B?RUoybUNlUlhlbVVLVnJQOCtvS1BQa0Q1UCs1TkJnUjlQVVg3eGF0WVVXMndu?=
 =?utf-8?B?RklPK3F1N3B2eFBHWkY1NFhRN0tJL3hsdC9OTEc2ZjNsYjRjQjJwNkxyMHpD?=
 =?utf-8?B?ekIrbWVWa0N3REpwTHhtbXp0TVVQODYvekJoTGdheHpBZ21wM2VhWVYvRG1C?=
 =?utf-8?B?Y3d5bUpaeTNveW5Fci9CQVVHR3dkM05janJ6Y1VzNjFWUSs0UWJIS2U3YTJo?=
 =?utf-8?B?dFRnSHc0ckFCT3A2SFdTZW9lQSs4TUJuSFFpNHh2T0JBQy93M2RXc2g1RjBK?=
 =?utf-8?B?ek9ydWYzQk1STklTTmhocnZEZFJTMWJKdDVCT3ZQQmN2dDhFYUdDeDBkby9y?=
 =?utf-8?B?alpTbkxJbEd0VlVBQVI4TWs5c2dDKzRwSzBYTlVRTS81NSt3OVdYN1J1ODNR?=
 =?utf-8?B?YTM3ckI1VHNtaXRoSHJobkhzZHB2akJJME5PNDdPRUt6VUdLVnFNNjB4dlp1?=
 =?utf-8?B?a3FrOVJsekVOQXRXQXBGTXFrdEdxSzZoVytwYWM2SVhUUXYvNDhOZHdDYXNq?=
 =?utf-8?B?QXRmKzJ1bnd6Z3BUdmkreXRIR1k5bU5hcFVBaFhKVTY0aDhabVlCaXB4SHBh?=
 =?utf-8?B?Rnd3bmFZRHh4L0hEL3R5Z2RPMXBEUnZnV3MyRmltVkpNdjVWTGRkZm5jUEEw?=
 =?utf-8?B?b2pjRGMvSzRxSGIxMWpWVlNjL2xDQXJNK3BhZmptUlVIR3g0VTZzbDgzOVQ2?=
 =?utf-8?B?WFo3ZVVFbFBYdTkzWVpHelZhWGtZemxpTjBvdklxdlVDMXZYQTE4REJnb2hQ?=
 =?utf-8?B?VEVKL01BZDNBM00vSVdKbWdHZTk4ZzRoRGtRdDVTWU9xRkZkVm5ndFpkQlV5?=
 =?utf-8?B?Mk1GY3FKdi9Fdk8xcXF4cFFpSWtvcTRDM3BDbEEvY1FJR1pvMmdsUVdMSTBw?=
 =?utf-8?B?T3RvVVhpcW1GU3d4Yit2bDUybE96anFKWE9qZGF2aGhuVmxIaWRsM2w3NjVX?=
 =?utf-8?B?Zi9sd3NCb2E1TnhsZ1JXZXV2ci9CTnFWMzdvZGpQZENrcXNLbkpBSS9VYS8z?=
 =?utf-8?B?UjBGSXNSZ1RvWUc0SVFsbzVIOFM0TU1JMmVnYXhHbXhmNzZwemppQTI3Szdu?=
 =?utf-8?B?ck1lQ0xQQ0trSWQ4QXdxQlp4MmMvajBXYnhvZHhjNVF4bkhQMWFkeE11S0Rj?=
 =?utf-8?B?M1htNjQ1bGpZS3Vka1FjUThXYVNXRUZ3V1NFUHZvUS9XSlkvUXlTTDVCYjRn?=
 =?utf-8?B?WGxINlBhM1MyTVh3SGlFd2ZCZ3MrSXJpaEpaMi91MnkyZy9ocXFQcHdVbDlM?=
 =?utf-8?B?WGh3dHcyTkhtY3pxWGxCZHZrOUtIUzY4dGl1Z0lGSkpxQTMrZHBwTldKOFhw?=
 =?utf-8?B?WE5DQzFiVUszak9CSjVUWXhGKytsQTB5MlBCWS9uOEJwUzJTUWxXYkNBcWhP?=
 =?utf-8?B?Rmd2d1paN3JtekgxV3paTm1Zc3F6ZUJwTnY1blpPNFNsZFh1QmxuNjZOak9x?=
 =?utf-8?B?bXoxTTNWVWo3M01DdkUrM2twUER0cmFPaGMvejV2aEhpT0xVd3FUUWVIbjlZ?=
 =?utf-8?Q?G224=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU1oU3ZCSUwvYTYyYXhCK0ZGZ3dVdW5IWWhwbFJCcUVKQzZqclEzc0phSnk0?=
 =?utf-8?B?N2xSVjRKMnRXRFpRU0IwQjdKQ0h2NFVHMmg2MXdOdW1vL2RPZVZlMGdJZ1la?=
 =?utf-8?B?RzJNUmwzZXc1YXNSYzV2eDBEbitXVHpDSFZaMzNFbmFjeExCQmJOTU5iLzhn?=
 =?utf-8?B?QlR5Z21FVEFrZzhjcmFaMVBCeDRSRkJMVVphYWRvM28yWk94YVZwaFdFdG9Z?=
 =?utf-8?B?dkM5WktlekFaRFp5T3ZVREpKcFF5cHArU3gxa0FybjF6MHZXQUdibTQzM3F2?=
 =?utf-8?B?SkZnTVBiR3JtcDFsQllPUHRUa0ZDeFdjNXJlYkNIOTY2YVRybkd5MDNTVkE3?=
 =?utf-8?B?NUVBZUwzSzVtVVV6L3NyeWVvdjh4VXdLNTA0bkdRRXRFK3FENDNmRDl6enNB?=
 =?utf-8?B?NUVtR1NiTmpkMlJHQUpTblZoaHdKY29CN0xua3BpNHM4NFdFNTRxellaUTg5?=
 =?utf-8?B?K0ZZWmJCT0F5YzI3azZaYXBLOE1zUUNmem9DZHJ5ZTQ2MnBRdFMvQ2hkNnpk?=
 =?utf-8?B?ZHlvb0JzVWFQdFJHcWtvZzRxUEtNQ3Rna2NzVUxZZGx2Sk13eXJVOHhhYlhN?=
 =?utf-8?B?S3ArOU5uTEF2WU0xS3o0UEZrc09QZy9sb1l1OVRYL2JBQ1hWMXZsaVFBMWkv?=
 =?utf-8?B?SHB2TUltMW50VnI1RGRHLzBScjM2UFdsVU9QTmVyREFKZHhleEFvNTJ6S2Zy?=
 =?utf-8?B?cGp4V1lLNE12TVE1dzR2R3BCZmZOUmp0dE9Fa0F2YVZvZlFRQkNneWxYbitX?=
 =?utf-8?B?VHg0SWVSMWVkRWdXVVNPVDZCL1Y3a0ZVdXJ1eTFHRjlRY2NXeGVjand2a1I1?=
 =?utf-8?B?eFF2Q09iSkZCVkwxWVoyc1hjRjB1aWdKdjBmN0NuOXM1L25LY3IwcysrU3pa?=
 =?utf-8?B?bVFqYWNOVDR5b09oLy9teE00cXVBMGxOVVBHb0d5T09naHZqNGp2YUVrY3pX?=
 =?utf-8?B?VWdQbGIyajRxNnNlbjhycVNZYVcyMFlZbFVNcDd5ZkxJSjBBUURPZWtYVnF0?=
 =?utf-8?B?NEFjVUJVQjZ3UjU0OCtWT1RlaXd0MnRCYTVuQ3ZWNjRSWndFeVV4N0VzQ1hB?=
 =?utf-8?B?ZFU0THNDeW1iNDJoNFlseFkvbnV2NkE5TUFjamhmclo5TU1IeEtpWHFmVm5u?=
 =?utf-8?B?OU0yQVhDWDZCYzBPcTRiZXEyNExiVzZ2WktaSTE3cURlcmhFWHA5MVVIUDBx?=
 =?utf-8?B?NU5rM05ZRk0zdlhBUDY2VC8wckhqYnA5QzA2UXpZMTEvd1VnaGFXK3R6MFJG?=
 =?utf-8?B?TTY4ZEFwV0w0R21sSUFCTkp5WTZvbWpiOC9mMnZCYitDbjQ3OVkyV2hLTWNl?=
 =?utf-8?B?YnJBMm03N1V1QVBSRk1ubXNGWTFUWEtudUVhR3pkZTVPblB1WkR4NVNEcXVI?=
 =?utf-8?B?cm9LYWVTTzJyaFg4YjZsaDFCUUpjOFpTUzNuU2Q1MmkyZGg0SzRDb3VkSlNu?=
 =?utf-8?B?MmNEcDlQVThZTHJ1bHJEK3F1VThENVp3Nk9rcFhrdVcwN3JsK1RQVzhaeitn?=
 =?utf-8?B?QlRUQ3RZOHpXOHNSQkMvSVFJOFBHaWpwYVU1a1REaUFjOTllcTdOSGJHVTlX?=
 =?utf-8?B?c2VwZ2QyTnF3M3JNUlNtUEpBOEg1MmtDZUk5bXFDcW13c2d5NDl1dVl2Yi9p?=
 =?utf-8?B?QU5XejNDTGJKOXNOMmVkeHRzT1NqMWtKSzFncXBGazhFZlFQWklyZm14Z2k1?=
 =?utf-8?B?MXJYanNYUDNqd1lUUkZaY0J0azBJZTF3RDhFdEFITjRwUjdXL3RLRHFDdnBw?=
 =?utf-8?B?VExVOXpkTTE2U0hXNHl5aUxUT2V4OGxxVFA1K2NOa28wNHMyTFl3N0FLV1VK?=
 =?utf-8?B?ZEQrU1pBZTJ4SEFrMmdYM1lrekhlY3h6dFJyZ2hOb0FLNlZEanAyV1lFSTQ2?=
 =?utf-8?B?TVVKaW5wNExkYmRVN3pVU1ZtVVErV3dzNHV1UnVjMDlSSGF3SXJ3VUVKdTEr?=
 =?utf-8?B?VHhid2hRcjEzTGFBYVA4ZVRXekpKWnpvN1BEWmhNQW4rSXUyUHVZUm5Bc2Ez?=
 =?utf-8?B?c0JWWmcyRHp6RVRwa3B5c0tDZVhLWmF0aGlvdDhkTzJieEl3Q1BWL241QWxj?=
 =?utf-8?B?M2o4NXdrdVp4SUpkeTZabEpLZkozSVo2Y0YxVUMxTmNRWUJtNUZJZEFKRnl5?=
 =?utf-8?B?WnBoNWNwVWJ2c01uOXhHV3U1QjBWV2hmVEkzWGd3WTgvbmU1ZzEwcHgzclZh?=
 =?utf-8?B?MlhWWURMQkFHd0w3bnJrbC84K2p0TWU4K202QUU1aHk2Nk1qYnF0NVJIalBU?=
 =?utf-8?B?eXdCWTRIRWxQSWNFMXZ5Ykd2ZDBYQ3VvNVppdVdIOUdxbjFvZTFrdFhPaXg5?=
 =?utf-8?B?dm4yQ0ZFRkNtaWV5Yy9ZNEU5NHZsVjRIWWJORkhoYitLVXhmWHFQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bbfc40-f3b2-4b0d-3f43-08de7316b559
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:04:10.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx28M/1jfkzgxyBrlHWLO8CCOP+TKfm4yYKeqJ5UL6pRiSVmn7aAlBMdHkV8Dt/Nmk4LTmomtsP6NO8EWE039g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217825-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3DC517CB01
X-Rspamd-Action: no action

Hi,

There was a commit in 6.18 that caused a problem:
c918e75e1ed9 ("drm/amd/display: Add an HPD filter for HDMI")

This has been fixed by these commits:
commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms 
module")
commit 17b2c526fd80 ("drm/amd/display: Clear HDMI HPD pending work only 
if it is enabled")

Can we please bring to 6.18.y and 6.19.y?

Thanks,

