Return-Path: <stable+bounces-136617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D508A9B651
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F1F9A62BC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C9291169;
	Thu, 24 Apr 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2GYT18hf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACA29115E;
	Thu, 24 Apr 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518964; cv=fail; b=eNzJdBQfvS1Fi7UYuZR2pNrTTz3SLiAwr97Y9Gf+2M2orVmVdDNUCqGHdAEVo9bYO9pgGZTyaNEsI48DiJ5Ve/joWEqMrLa8xfbjXv48L/Js3HPJWd2pfolg90gEuczdz0INX780E+llUuvhurHL/VZVTW4d7k7GokBnk8W/OfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518964; c=relaxed/simple;
	bh=Jg0V77Up/dKl01P7Z0Scv2Rticq9Pxva5ghjvEvVfcU=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=j7UMoo97kaK79r1DU3WNklVI4G+HRzXUfwxATfPlNsO7J0YbzzLC8NcVSAS4qgu41e4AbiaoCljCjJv6nBkzmMAxanKl7Yvd8yMhFHyQNB7vI4+WXdWhq7iiqt1xKi4RfRuRmy6o3YezNv8XBJwjuofgi+pEACxdBN3KJYjkcqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2GYT18hf; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP+PIjr/3eJA+UHPcR20lLQdYoQV0MSoRmWOqjN/LfpVGbTXI2SsAs9vXfrijVWY6Yj8wkAaic813SikM19RrvlU3j9Du+uuEeluYB9Yw8lyU5TAXX4pcFt02Ow8TEuZf6qaS2cNKP1s58CHKuGzW9xIB13gg+wirFzlYgSgvI0kUpgN7vtKAV3XaJKoasagcgj6QMZL3f+0BV5WQtAAvagCuveKylkLAeeXoz//vy0Yi7mwH9x9oef9jibBxXIVSZ5VAtbI+O/mClRZn1ijtTf70WV0kyQjpwj0ByB1QENJCvT36IWjtFimwPbhnNKdLkLPc/Skhj2gcf4l7ak40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX9WP7klubA2PAvVmN92K7om+kNLzXnrxGVp3jBo07w=;
 b=L8InH5z5hJis6vANUcDmOmvHF7rsyWnJ5gtT4DDIG5O5nf9TwW7hkeEGzSKr7oRY2LdS4NmiytDE/vpzfJW+ZHJoSIMghtHXwy0En1XlkCxUTFc5l88vVx9UrrwuOq/uoc9VsFPJDpMTLwWYLQ+NSm7WRp9RTSh3uDXeYgo+UUr+2cjZRlgE01Cgz3A4gO4IfATVRRr2NblWRtK/3vkv4ZB7aA8463bYND2xQ8tYWa1+yf850rVlEXD3IyV3pIHPnNQHkTb/Td5d/I3IqxFXnpw63pi1yc0U1TJhW4PV+7TMS0n+XnNdyLVi9QZ++1qF4s3D/sPJpZI2qnVckwSd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX9WP7klubA2PAvVmN92K7om+kNLzXnrxGVp3jBo07w=;
 b=2GYT18hfdM8lcQ2XEnhzPPYzHEk01w8bca3axTXti2EfqON5xIVnjuwBFXvGChWDqA671kjbCY5+LlMhPgaEAJ34AYCCYRN+FZSTf9x6kZA7HTA3xpJ01k+nR/woZVNHHGqzboHAqvp3ieZZeSbhqx3FBE5osrGai0khpMrYPHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 18:22:40 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 18:22:40 +0000
Message-ID: <90a031fb-b0dd-b5af-7013-7483ebad49ab@amd.com>
Date: Thu, 24 Apr 2025 13:22:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: kees@kernel.org, michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
 ardb@kernel.org, gustavoars@kernel.org, sgarzare@redhat.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev
References: <20250424141536.673522-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
In-Reply-To: <20250424141536.673522-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:806:6f::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb599b-e6d2-4799-18d6-08dd835cff1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnlHTjBxS09PQXBzSzZZZGJVQWszcUZYM2lwMFNlL0VzSDhLdGpkYVZpQXJj?=
 =?utf-8?B?RE1JZGZsNERrWmZBQ1ZzSjlWSFpZTXFsNktCZFZBcVRTdmQzQklSUVJNa25a?=
 =?utf-8?B?c0VpbFUvcGkxQnduRUtDR3NPcXFOdFA1MXE1b3N2VEFhdGl2YkxGd1hpMEJs?=
 =?utf-8?B?eGJPRlJQNVVIVmZlWVZnS012djZ6dkhxVWxDTnAzUkFKdGpEazJ2NjZYM2V3?=
 =?utf-8?B?NytlVlU4YWFDRHFwKzNRWGIxZ2cwWUpHdUpjMU1NeFFlWE5iaXF4K01UaCs3?=
 =?utf-8?B?Umw3OFdEcmpDSEYxUkMrUHltZWZqMWZDS29PZFZ1a0EzUXU2RW5QY3UxcHBV?=
 =?utf-8?B?Y294bTV0NEs4NXhMRjgxTExQVGFJRXBxT28wM3VDcTZ1ZTgvdjBmbXRrLy9i?=
 =?utf-8?B?YWFJdDdkS0Z0djlDSUdvWmdBbXJmUGpFZUlGMjFJdzlDOWhuL2JmMlNEZmFv?=
 =?utf-8?B?Zmk0UmpZZWFDdlZZZ1VBbm8wMmhHNFg3VnlqT0pxTjlucHU5elpuVkRjNnRZ?=
 =?utf-8?B?RGJlK1NJK292THRXODZ0Tk4wWVF0cGdsUHFoV0JzMUFzWGxMZkZLM3lRT2VQ?=
 =?utf-8?B?VlpSTnhJbkNlOXdhY2FRS1ViN2szM1NFalozWmxtc2JzaS9CZDNQaFN5dmVi?=
 =?utf-8?B?Y0IrWldnblFnYjZRR3VZdU9nWFZaTzRVM2xMZU5pU2V2SUltVlFpcUQxZmxu?=
 =?utf-8?B?RWxBcHJIdEpXSWJKU2FCYyt2Wi9oWHo5cElhTDF3UkI3VEVnVFExSzdqWU5I?=
 =?utf-8?B?d0EzWHRXTHYxT3hvY3F0eVRjRCtkM0dvYmhFclZ0Vy9qTlBMaWtlMUlaelp2?=
 =?utf-8?B?eFBNMlZuWU02ZEg5OCtYUHowbk9WZXg2SWJrL2xYWVNaN3V3NTY3NnNnenlp?=
 =?utf-8?B?SEJnS3lCd0RldUUwU3hZRWVuMnBVM1UvUTczNElyZXFvOFd0VHpmYy9BNkxn?=
 =?utf-8?B?T0xUckJMdjVNMmpKbXpwK21KK1VtMDJjNDRmc09jdzQvei9VS2w5TldUdVRL?=
 =?utf-8?B?SGVBK3ludi9qZzk4ci9BWmF2cTcxczVKRWpPZU9Peml6aStiRWdKb21jUUZr?=
 =?utf-8?B?RzF1WlRjMUlreERVUGk3S3NaZ21CNmppeWg5VXBuYzRVQjBzaUtKQlpBYVJw?=
 =?utf-8?B?a3Nwd2cvdEdSL3NIN3V4b2lLOVVKdWcxbWZYbGM5R05yTjVuZlRqdnZQMGYr?=
 =?utf-8?B?VGJERS90bHZNeWZ3eWdPeCtJbEFGdEZRZDJmS2hqRUp3eW9ycFlsVzNPZ21I?=
 =?utf-8?B?OU9uQWx1clkyWDlsc0dES3pjejFoQ1ZGdVFzejhXSFY3aFRESzZUZWlIdzRk?=
 =?utf-8?B?LzZBVzVhUVNqTUF6Mk5jS3BLbW8wTXJyNzAweW9WbHptN0VnU1loOHZpM0tu?=
 =?utf-8?B?alJPQk93RUVKdUVrNDMxWmR6cTlRdS9YMzZXaU1BK0J5NmNNQ1J2RXBybDdT?=
 =?utf-8?B?MDZFTUZSWllRSUlnWVBMaGt2ajFKZzNWWU1leCs1bU52bkRORGNDQzRmV0kv?=
 =?utf-8?B?V1YwaGViRjRKWnJlbGJyYWRFTFlJak9RcGl3YnlCakJka21JNFBuaUdYUG1F?=
 =?utf-8?B?RVNTZFJ5N3BhbDNTOUo5aWo4RzVFTnp3VGhyZmJFcHRjUGtkTG8rbWZMZ2hH?=
 =?utf-8?B?OVNzYzdaalIzbUFsN254TWVpMFF3ZHlEa3NMRkR6UGNzQmhCRkZXZTBNbXNX?=
 =?utf-8?B?SEpSd1B5ZUhYS3d1SUhiYkFkRWJmQmdOU3h6Zm9lVjhsWnM5eDRNWGhYODh3?=
 =?utf-8?B?bkZVeVFqQ2dQWE5tK2sxenZoekJaUXlEQ2ZUanBSTDByTUZsSnl1anNVYlZ4?=
 =?utf-8?B?R0tibEc5cGZnaUpNR05EdkxpbXVpdkk4aHIxUTBnYlc4WWZFYXR1cHkzTVBC?=
 =?utf-8?B?eU5oT2NsREEyTlJ4T1dVdUtHcVpnUDN2VW5GTytlWWNUVHFrTW5RTlZKUHk5?=
 =?utf-8?Q?D3z3Rnyiy2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckVGMy95bmRTSXdxc1JNUVpJMUNhOUtyV29FZ2JaZGRpWHJ4ejJ0L3pnVkdC?=
 =?utf-8?B?dUoxZWRSUUVKbjVDSHJpNEhLL00wZVRoMmNPcUlQUmxsUzhFQ3hrNE1BRzAw?=
 =?utf-8?B?TndGRXN6U2pRU2p4MHExcVU4M2NHT1RxM21uR1ZzOGh3UjlJd3R5Z0tnOTBy?=
 =?utf-8?B?SyswLzRWeGo5THRuMnZWKzRyelU0QzNlc2szVWd5SnpMT28wa09sUjE2VEJY?=
 =?utf-8?B?QlhsNHEvNEI4dFB2d3ljTTZaQnNEUTlhMlMzVVRVb2VNYmtRemlhUm9EVDA3?=
 =?utf-8?B?NGJibGYwTGkyYXFUekhHbEx2V1BsdGRWbStRbVFDT3pQcUl2c2tNZlRsVnhU?=
 =?utf-8?B?WFI0dTk0eVphbmNpKytqcGVFWENWbCt1cmNHYm9jNmtrNXlCRkV1MFlLbGhE?=
 =?utf-8?B?b1BwZ3ZXdGV4bEloWjlWRS9RaERTWXNPTWFCMjFscXRwakxLY3o2L1FPclc4?=
 =?utf-8?B?VXRpdHo5ZVJlc2xvUlhlUlNjVEhiZXROakNmdlVyREdKb1FOMUd2Wm9QbHRI?=
 =?utf-8?B?RVJXTWRpUUtzR05CK3BrZ0NiTkpXeHVkSkMzc3ZLY3BDWkF2R2VKa0tJNWZx?=
 =?utf-8?B?NzdSYmNtMVRTQkUrRzJuNU9KUnl3c3dVRHV6aEZJZG93NVg5V2krYk9FVGRa?=
 =?utf-8?B?TjNPNysvWFdUWlluWTZ4T0s4Z3IwVjhNc2xVd1NrVWNuamFUaXZ5eWJYNWRs?=
 =?utf-8?B?L0hoL1ZPZWRNZENlbXV1aXB2cUc4UlZadDQ1ZHZVNjJ5QWNINVNHUFd4bS95?=
 =?utf-8?B?S240bjVJTjlYQ0xTOGlERC9rbUxpZW85RXRXZlgwNVlTcDJDbHV2SlNnRlFx?=
 =?utf-8?B?Z2JlQ3RYeWUwSHdEUitUODRVNHU0VExBVURFZTJITTJQYjdqT0FYUWU3WnFX?=
 =?utf-8?B?cm1DMG1ZNDQvaGFLZFp2Z2xmTDBSRGw4cGtqcmh4aXZwdFFUSXJVRFpxbVhm?=
 =?utf-8?B?VTByZXVLOFVVbmU1NGJuOTRvSC82Y3crTzgvUWdBaTBFTys5anJBYXpTWGJk?=
 =?utf-8?B?WkxxUGpkZTFjbEpVUWs2RHo3R3JyM3VKZEtFbDgvUVBWOGdkODEyaGI4MmhZ?=
 =?utf-8?B?VXI3R3ZnZm9laEorQVJucm1lSkd0elZDNlpTSnRFS2VjYnF6N0VqaUc3MURK?=
 =?utf-8?B?di9JOUFKNGFnS0wzcXJsS3YyWTJGbmYrdUtreFJualp3ZEUwcW0rZzdENS9p?=
 =?utf-8?B?OUlCWnBsVkxRMStsSEltcVFEZEIrb3pJMWdVUVgrMXF5R0R4OVZLblF5TVVm?=
 =?utf-8?B?VzA2dDZvaXJkV3RHdFVKV3Y2VUNIS2JUdTZyNmJ0Y1RLSTZ3VnN6WXo1T0h6?=
 =?utf-8?B?NXRCUER0dDRWcmN1SHlkRDRtVXVNbFdkQUVWK0VZKy9pNWZKQmFNZFVodFZB?=
 =?utf-8?B?N3FqZVNaNlliSEFZS3FWRmpRdEU4MHdyMmVEbmNXS0NzWnFZdGVFLzNtTysv?=
 =?utf-8?B?V3RjaSthTUZ5eENPRENLOFdWM3BZQk4xV3RNbUMvd2J6MmNjZ3JKQ1ZaL0sw?=
 =?utf-8?B?Vnp5NEp6azlrc3ZvZVh6TVcrNzVUTjFtaFhaN08yb1V4WXpWd0owTG9lSjZh?=
 =?utf-8?B?akFlY2tibjBRcGZwT1hwOHltdExaWXBkNDh4bTVhemhScms3aTVUYjZTejVK?=
 =?utf-8?B?end4enNHVjRPbnBLM0MyQjJlRnA2aGxuY0V6RUpjM2xJY3pwQnE4aUIzMnJK?=
 =?utf-8?B?L2ZsRkJvbWVYT1VXd0ovYTdybTkwR0FiRXlyRXAzeEtnTVl5VVMvNnc0eW00?=
 =?utf-8?B?dUVQYjdOS251dmZLZEJJdThxeEo5TkdnYjkzeXFWeWlIcTFNMHNmaXo4YVdM?=
 =?utf-8?B?bjhxTnp2N0dnaE5UWUxwcDZyZkZuZTVtZWxlNWo0N0RGKzMxZno2ZmNqb00x?=
 =?utf-8?B?T0ZkaXJWV1RNOS9QSWc4UFp5NDJuM2ZZZHVNaVhSbjJ5cnhmTVhkcDNqamdI?=
 =?utf-8?B?UlBJSWVMS2FjbUp1djNkZnNPVU5pYWYwYThUZXhQUmgwNFg4eUtkU1JQdzIr?=
 =?utf-8?B?c0g5ajVvVWZNelI0eDlJZ0VRTHZ3bXhBMFJtSjRBWHI1NThKV0ROUEVmZmhW?=
 =?utf-8?B?Yjc2Vnh2WHJrR3JLOUJ1RnY0YWI5T2RJaW5kR1ZqL1Zza1VzQ1hKeXhLYWhC?=
 =?utf-8?Q?EDDpLf8IiQebJsyWgc+uNY01C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb599b-e6d2-4799-18d6-08dd835cff1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:22:39.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vUnMyFR9YfRB3Lke6xFuzq3+nlwnZvhndlkwSu9i//B/pONf50IOS8d6ndCX+gsMmHRXAIPW5bmzcZkjqT8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

On 4/24/25 09:15, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running.
> 
> This leads to guest softlockup/hang:
> 
> [  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
> [  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
> [  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
> [  117.111200] Call Trace:
> [  117.111204]  <TASK>
> [  117.111206]  ? _copy_to_iter+0xc1/0x720
> [  117.111216]  ? srso_return_thunk+0x5/0x5f
> [  117.111220]  ? _raw_spin_unlock+0x27/0x40
> [  117.111234]  ? srso_return_thunk+0x5/0x5f
> [  117.111236]  ? find_vmap_area+0xd6/0xf0
> [  117.111251]  ? srso_return_thunk+0x5/0x5f
> [  117.111253]  ? __check_object_size+0x18d/0x2e0
> [  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
> [  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
> [  117.111285]  read_from_oldmem.part.0+0xf4/0x200
> [  117.111306]  read_vmcore+0x206/0x3c0
> [  117.111309]  ? srso_return_thunk+0x5/0x5f
> [  117.111325]  proc_reg_read_iter+0x59/0x90
> [  117.111334]  vfs_read+0x26e/0x350
> 
> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 129 ++++++++++++++++++++++++++++++---------
>  1 file changed, 101 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index dcfaa698d6cf..870f4994a13d 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -113,6 +113,8 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>  DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DEFINE_PER_CPU(u64, svsm_caa_pa);
>  
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);
> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>  	unsigned long sp = regs->sp;
> @@ -877,6 +879,42 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static int issue_vmgexit_ap_create_destroy(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int ret = 0;
> +
> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +
> +	vc_ghcb_invalidate(ghcb);
> +	ghcb_set_rax(ghcb, vmsa->sev_features);

RAX should only be set on a SVM_VMGEXIT_AP_CREATE event.

> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> +	ghcb_set_sw_exit_info_1(ghcb,
> +				((u64)apic_id << 32)	|
> +				((u64)snp_vmpl << 16)	|
> +				event);
> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +	VMGEXIT();
> +
> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> +		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
> +		ret = -EINVAL;
> +	}
> +
> +	__sev_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
>  static void set_pte_enc(pte_t *kpte, int level, void *va)
>  {
>  	struct pte_enc_desc d = {
> @@ -973,6 +1011,66 @@ void snp_kexec_begin(void)
>  		pr_warn("Failed to stop shared<->private conversions\n");
>  }
>  
> +/*
> + * Shutdown all APs except the one handling kexec/kdump and clearing
> + * the VMSA tag on AP's VMSA pages as they are not being used as
> + * VMSA page anymore.
> + */
> +static void snp_shutdown_all_aps(void)
> +{
> +	struct sev_es_save_area *vmsa;
> +	int apic_id, cpu;
> +
> +	/*
> +	 * APs are already in HLT loop when kexec_finish() is invoked.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		vmsa = per_cpu(sev_vmsa, cpu);
> +
> +		/*
> +		 * BSP does not have guest allocated VMSA, so it's in-use/busy
> +		 * VMSA cannot touch a guest page and there is no need to clear
> +		 * the VMSA tag for this page.
> +		 */
> +		if (!vmsa)
> +			continue;
> +
> +		/*
> +		 * Cannot clear the VMSA tag for the currently running vCPU.
> +		 */
> +		if (get_cpu() == cpu) {
> +			unsigned long pa;
> +			struct page *p;
> +
> +			pa = __pa(vmsa);
> +			p = pfn_to_online_page(pa >> PAGE_SHIFT);
> +			/*
> +			 * Mark the VMSA page of the running vCPU as Offline
> +			 * so that is excluded and not touched by makedumpfile
> +			 * while generating vmcore during kdump boot.
> +			 */
> +			if (p)
> +				__SetPageOffline(p);
> +			put_cpu();
> +			continue;
> +		}
> +		put_cpu();
> +
> +		apic_id = cpuid_to_apicid[cpu];
> +
> +		/*
> +		 * Issue AP destroy on all APs (to ensure they are kicked out
> +		 * of guest mode) to allow using RMPADJUST to remove the VMSA
> +		 * tag on VMSA pages especially for guests that allow HLT to
> +		 * not be intercepted.
> +		 */
> +

Remove this blank line.

> +		issue_vmgexit_ap_create_destroy(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
> +

And this one.

> +		snp_cleanup_vmsa(vmsa, apic_id);
> +	}
> +}
> +
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> @@ -987,6 +1085,8 @@ void snp_kexec_finish(void)
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> +	snp_shutdown_all_aps();
> +
>  	unshare_all_memory();
>  
>  	/*
> @@ -1098,10 +1198,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>  static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
> -	struct ghcb_state state;
>  	struct svsm_ca *caa;
> -	unsigned long flags;
> -	struct ghcb *ghcb;
>  	u8 sipi_vector;
>  	int cpu, ret;
>  	u64 cr4;
> @@ -1215,31 +1312,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	}
>  
>  	/* Issue VMGEXIT AP Creation NAE event */
> -	local_irq_save(flags);
> -
> -	ghcb = __sev_get_ghcb(&state);
> -
> -	vc_ghcb_invalidate(ghcb);
> -	ghcb_set_rax(ghcb, vmsa->sev_features);
> -	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> -	ghcb_set_sw_exit_info_1(ghcb,
> -				((u64)apic_id << 32)	|
> -				((u64)snp_vmpl << 16)	|
> -				SVM_VMGEXIT_AP_CREATE);
> -	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> -
> -	sev_es_wr_ghcb_msr(__pa(ghcb));
> -	VMGEXIT();
> -
> -	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> -	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> -		pr_err("SNP AP Creation error\n");
> -		ret = -EINVAL;
> -	}
> -
> -	__sev_put_ghcb(&state);
> -
> -	local_irq_restore(flags);
> +	ret = issue_vmgexit_ap_create_destroy(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
>  
>  	/* Perform cleanup if there was an error */

You can remove the two lines above (the blank line and the comment) now
that the setting of ret is not a few lines before. That way you have

	/* Issue VMGEXIT AP Creation NAE event */
	ret = issue_vmgexit_ap_create_destroy(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
	if (ret) {

and it's nicely grouped.

Thanks,
Tom

>  	if (ret) {

