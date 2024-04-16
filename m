Return-Path: <stable+bounces-39982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D28A61CD
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E21C20BD0
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2318E02;
	Tue, 16 Apr 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="d7ycdu+x"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC017999
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239225; cv=fail; b=NAddDc7/Q9yaL8Yav5Bx90If5Z3OEuIqp8PIXK3s2XR+Nj3+s8wuiyYeh33GKBwrhnwbbkil17aJmfGI0yKaS3AjRatFonj8mQGhzHw0JdKcudgQW5mfpHylq/2V7HrPM0WzIBWul+E6ctLP5lCTS72UpN5sbqEQl017RbWi+r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239225; c=relaxed/simple;
	bh=p6e/XOn//Pe8Ch/jXEUt/E9wdC6KYoqX4/C/cZg9Z3Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aS4kDvfnLrzHXR+u21La2OTV7sx4KrKwQkGFARJTPoHbxyD3U7SDeCXBao75dBz9hUbMchOLQUnCKLY4A8R9cQ7wabdIQFWtJFou33rZED3SE/AahB5nh+pNthJIoHYne3G8D7Sd/bl1Ex1kfGmLGFqCJmfkJLwkaknEpfNIPi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=d7ycdu+x; arc=fail smtp.client-ip=40.107.92.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja6aJ8q1VyJvmwpvP8I8JXUeZTsLR6eTmbkdJ/VeGF4GAEYrpIPtBt2t1eM4GiVpdk8/RMuERuU3RSxyygjW4MFuzk1tN/gpuqMtEzQsZ7k0j9Q1YjvP5RuNG6HIh+yERjoZeb97s47fa7QspBetPLVeTpckbB0K0H4rPrET/HRUqQYIaWBvc7IDLpvnK0VP155Z3luWaIQH9RgTv7eHuOd05oA9Bn6QYeCgY9V6VoXWWIKZqowE3KAXx8ORllzHdvWWj8xODh6gvwmeXpIYgE+NMvU1KSuG0wL3OzfPIpT767nHUdZ9BNi/+9lIsMtjrE+Q4DJSoNwLEm/0Fs869g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6e/XOn//Pe8Ch/jXEUt/E9wdC6KYoqX4/C/cZg9Z3Q=;
 b=LazJkWlByHGwU7AMpPQiRoYdbi8qal35neXnAuuMWZnxh580Sf9//cyL0Kl5ugkv1bhlZdmCjucYf4DJlj0Zofs43FMfvk7mn1/pBPoCBNknEw5jajfUlNBdDH7PmhM6kMUnnU9/BCDiu5nf6FiWuOULdw4GIE72I6hqo7gVKElyqvVHs+Dcq5sYukBsOKWpe5JgQsALHlgBK+D+g4w8wWM9FctGevc5f8fz75c9VTj5Mxw0qxDKwQhmvVS+8fs1+wPrlDKbx1ebPI9y7F2mGgMoilgbWnnEoUI2nVGk8B9rVCom/TlXPXn2/0fc7/D5bDUGUZNFjNkrjGi9YD38TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6e/XOn//Pe8Ch/jXEUt/E9wdC6KYoqX4/C/cZg9Z3Q=;
 b=d7ycdu+x9wbtoLzJ0MTAqpeHuTNfAcSkJEOVNuAB3TEruF+jzsCslRTwB+Y/hSAOZu2FQj8ZsAox9YwKzTxlzPsjJDzEo2oK6slXchq89icXe4Cl67JYgs6UYJm4G27FnxU4YyRW17ZA9G2gLbpt5zBkkpcBHTUYtl0EqoZ4x2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8581.prod.exchangelabs.com (2603:10b6:a03:53b::10) by
 SA1PR01MB8394.prod.exchangelabs.com (2603:10b6:806:388::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 03:46:58 +0000
Received: from SJ2PR01MB8581.prod.exchangelabs.com
 ([fe80::7fb:cd5a:61bc:9922]) by SJ2PR01MB8581.prod.exchangelabs.com
 ([fe80::7fb:cd5a:61bc:9922%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:46:58 +0000
From: dcrady@os.amperecomputing.com
To: stable@vger.kernel.org
Subject: v5.15+ backport request
Date: Mon, 15 Apr 2024 20:46:26 -0700
Message-ID: <20240416034626.163580-1-dcrady@os.amperecomputing.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:20::20) To SJ2PR01MB8581.prod.exchangelabs.com
 (2603:10b6:a03:53b::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8581:EE_|SA1PR01MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be7511e-b480-4c4e-4613-08dc5dc7ddef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kZMvlRYIgtuu5MHGwDFcsy+FFaq09jw3bPIoHPwwS1t437+3CV01xUaBY8K/cOTpmARxDYievOctAQ5kErTfCDBTOU04Q3MCZ8qHEiSDhhB5lTqbK5DJMckNle9+1f51n0SDO7XLacPdawT/U0Ut+luB85JJy5ET8IE57meBB3J0KtGjxwzkL1fyEPD3wz+dzQD0l0aVuGktxQwNuNe24y90cxXNDGemh6wpuN8272MjOczw+eajkMxTMN9+ArfZt2utOmy1dcD85+lQO4R04iYjVxayDiXtfmCe4mu/oE9PCGQqYfO2rsRcEsTjPePM4uaNaRzpoZ+A50uIDBBqUT21J9yq80/mVxF2UU99LJ1EFK3CsPQiISwbJSlAnkPCsmt8lECEXRggKa12aXY0UVIllkN9fIQfVZAMlKF8Ca8eRTfYQeqsx+oB5SQLojjhc72oGKitX5KTyqxSUBe5UbFjkFPL38cW+o5DqmY/O4qphk6qbunpLpdBKP0HRf/C2wEtdtyEBKVMgwxwjubQ3Pa2/c9iRYcyyHq0NF1S9WJJdxGdt3V3X183JXVReCdac3Xtd5wke8X4HVY25j7+MxoQ1OrtT1QbquPWL5MeKAGd5qJZ9gJtYSpBaWvCC7V3nlJN1uJSbsB1SOBH1wxGBuuKg2zdPw6sLMfEgEmsY1jITR2qFkWZ2A4Xqg2WQrinurR+HREMTMbSHLPlmfXi2EbG2caL5fT3M+8ZTnYfW4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8581.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFRna3BQSzhla3Y4UkJyK3N1MG1lc2Nmdjh4ZWdhWEY3eHptaG9WNW5zTlc4?=
 =?utf-8?B?SXRXT1VKdkd1QzF3ZWRHVXJGK08wSDdZaXNnZnVuTWt6TWg5NThsZEpRQUk4?=
 =?utf-8?B?OXZVWXM5eEd2TDdOZktNcU9CZXI1N050SEFRVHJFTGxzL09STSs1QVJGcUVE?=
 =?utf-8?B?S1R6VG1JeWgzNXBKb3BKeE1OMmppWHN0Y3hWTkxXaU9pdU9zTEdDcWx0WVhW?=
 =?utf-8?B?V2N3ZG5NZEpTSlhXWldQZ3MwdXU3K2RKck02eWRBY0ltSnloR283SWxoWTVP?=
 =?utf-8?B?OHU1ZVlHK3B3LzZhUVN3eFR0YlcwMFJ0UnJINUFLMStvMFRVNnZLQy9JQTZw?=
 =?utf-8?B?akk3S1N5aXNPRHZlL01hQnpERDVqWDhFTkFaclA1SDdPYkFUTWZ2ZVJLeUdK?=
 =?utf-8?B?Y2ZZeFhSK0tENWZXcnJubitIT3hIeUNZbUxxM1VWb2wwUTlBRStlNC8xeDhr?=
 =?utf-8?B?TTR6cGh0WGpWdWNONjIxTUIvdXNEWDFxNDJnRlBMVXQxUnUrQkM4OE5XSlJz?=
 =?utf-8?B?NTVXeFdmaTJJZEdBanRycnQzTkdwd3ZGMlpZT2hhY3FXdWhYNmd4ZEpCQS8r?=
 =?utf-8?B?TW1Qb3NUb28rZDFQaTZJRTZuQjM2dkNnTi9CT3cvRkx4bnlsVktPTWszczhJ?=
 =?utf-8?B?aDY2RUkxbCszaWt2bHNSMEUyYUxsSHBFbWUzellLTVdldjFYQkMzVUxlbG9M?=
 =?utf-8?B?bVJhbHAwaHR4NXZkMkJMMzliTWZYNUdFTHlMeDJ4SWlFZlBsenppMndWSjBX?=
 =?utf-8?B?WTlVbGp3ZGErLzFOczN1SEZncXFlOUhZNmlIZTc5VmNNV2tQdW5Hb0t3c0RE?=
 =?utf-8?B?dkl1dmtzblNBZHJDQ2dsQ3hQNEFpUGJJU2RXNm9vNkVSOWNZeDZ1L0QxTjdN?=
 =?utf-8?B?Rm1qNGsxSUhXSVBQZGlhdXVjalpUZGRhSjBybSt2MWpCL1BLZ1FpUWwrbjRP?=
 =?utf-8?B?QWVjbGl4RTg2Q2pnNFJqTSs5OHJPNEFSN3hXVEdtWXRZcWZhcUp4dWMzYnJJ?=
 =?utf-8?B?NFN0VXo0L1duSXV6Ynl5M2lSWHI3OW0ySElVSW1XZlJZS1hNZk5MSXNSMFFj?=
 =?utf-8?B?YkFwMGgwM2xEYUdJVXlOMitqSkxxNTIzT0hNWkNxRkp5QjNycjJENWVGS1dx?=
 =?utf-8?B?K0pQb2hzZUxLYXFGRUw1ekhrTmRFa0dXbURNN3hXd3lIRnlXdGpUTlEvMHZn?=
 =?utf-8?B?WStDd2NsbHliT3c0NWdEd2x3MVZwOHhSVGZUQ1ZKalkvSER1aHE0UE9YWjZk?=
 =?utf-8?B?YjA3ZjQ1bmNBTlhCajZlaWxweGN3Y2tzOCtBS3hUUkVwbk1RdXA3SkpJS3JP?=
 =?utf-8?B?SHZ4dkVJZjZMS2xxMFFBdDE5RzZwZHRaSGZtQlY0NnhoOU4zVXkrVEd1RnBq?=
 =?utf-8?B?QUFrMk1wZzB6Rm94Y1NLUytUV0wxdUZWOU5oeFZFSmI2QWhEV1dPM3JjZlBB?=
 =?utf-8?B?OGxTT3NlMmRKNVFsRy92U2ZJZVhPTEZ0akNKa2VSb3FjeTN0MjRqbzlMRWg2?=
 =?utf-8?B?WlBqbWIxSzFpZVZ3SXdwWE9seVJsUHBRb2pRWVVYMTBXNnhGZ1Nmc0VaaE5w?=
 =?utf-8?B?M3pIeWFocGtaaDRlNE1TZTlnYnorTlByeFZkdWhpRVJVMkFpS05RKzdBRHBp?=
 =?utf-8?B?NUx3TzEyQUpHODNJaU1BU1JSUXJaZHF6eWdnZkhLNUlFdlp6b25KY1pyNVRV?=
 =?utf-8?B?eXVpREVZUHdrSi9ubVZBVUVZU1R1Q1hHNXlEU3hwcCtsbU1Pc1d2VGRKQW1r?=
 =?utf-8?B?eUxNK0NWdjBFTFpkSW5mcVJOQm9mNklibk5QTkNzS3NrSEpQRnEwTU5qaGla?=
 =?utf-8?B?eDRmdnh4VmlZZTdpWHFnY05jV3hVVG9KWWUvQjdaaTVPUmxhMy9hR3preExM?=
 =?utf-8?B?MzBJSi9WeHNGYUc4cm5aUW5kVVpLNWMvNXUyQTlrQTJjaDlKendUTzhyK1JO?=
 =?utf-8?B?akM1V2NWejZybU13ZXhEUjlaaXdzYUZIVUZXTW5VRExRZDlodkg1amRiZlRB?=
 =?utf-8?B?SXRJU04vdUtHY3lKOFVCRWxaaTZGbis1WEtQajlNa0svRGxsM3piQjlHS3Nm?=
 =?utf-8?B?dVVadklzR0UyRkV2b2pUVDNLcW5DNWtFWGRoUWthTEUwY1VlSlBDVG40bWFI?=
 =?utf-8?B?aVBCOXlJMUtaZzBMeXNqVW9BMzlYWStBSFk1Yys3MElLa1gzd0RGMDFJdWdJ?=
 =?utf-8?Q?N/WgZLQNtA83qKryBHpgsWM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be7511e-b480-4c4e-4613-08dc5dc7ddef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8581.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 03:46:58.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEEjW0pdAcjMcSpPFtqLPmkPt9iwX8R/yQvn+aWsdxoVToRHtq1l9RWV7kh6rlpMzJ2sXLwIb8E3cre5ncwvC/sflsbJQxI3v9s6VqJL0m37V5W7R1gip+0/K1GIFCpz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8394

Please backport the following v6.7 commit:

commit be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")

to stable kernels v5.15 and newer to fix:

It is possible for multiple vCPUs to fault on the same IPA and attempt
to resolve the fault. One of the page table walks will actually update
the PTE and the rest will return -EAGAIN per our race detection scheme.
KVM elides the TLB invalidation on the racing threads as the return
value is nonzero.

Before commit a12ab1378a88 ("KVM: arm64: Use local TLBI on permission
relaxation") KVM always used broadcast TLB invalidations when handling
permission faults, which had the convenient property of making the
stage-2 updates visible to all CPUs in the system. However now we do a
local invalidation, and TLBI elision leads to the vCPU thread faulting
again on the stale entry. Remember that the architecture permits the TLB
to cache translations that precipitate a permission fault.

Invalidate the TLB entry responsible for the permission fault if the
stage-2 descriptor has been relaxed, regardless of which thread actually
did the job.

Thank you!
doug rady


