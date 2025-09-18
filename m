Return-Path: <stable+bounces-180567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3519B8637F
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D71F463912
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80591263F4E;
	Thu, 18 Sep 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="r4Fx31Il"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021095.outbound.protection.outlook.com [40.93.194.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCD258EE9;
	Thu, 18 Sep 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216816; cv=fail; b=tGmO58s3YEOwUbzNGq2J9X5gykR2hz8btIVAR/h1stVGTWpdoPSa3SsJ7PiRI77CG0tiVa868r3Ef7spN+NKe6SmyeN/GJgpWSMRGb2E49XDfsXmh9jIqQ0LpEReErXhsjijqINAylVjoU7PKf0NKSE+5aAq3oIjFU2D6fFnrWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216816; c=relaxed/simple;
	bh=BfqpxPHhmOINNr/2aGD/VmyfLphJOeE6ZKe9KYfYkhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QtvhNSHv4FysjFWFfXkvhbEYezJ6IAI2RR9Ndd3rKWSpDs0ReqCh8iD2D0nVq17P+9agQEarUlA50g7Q0fGdIoCxNClMCB203RLl9c3aWj3ml/eeRhzBpnSG0jjlH5sYcCA4XUHFSPzjlXA7Yd4pb6sNPB4DmRhWt1+AWexWhsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=r4Fx31Il; arc=fail smtp.client-ip=40.93.194.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtRwEOqYQ9bcalJDCDDNYYTjfLojgC15gSTjkyi/wnJRULeNj0zFxKLKfGxgtP0ochOBmlZr0R+xi7iKpVns/G/CDt7x5NwTiz/+iqTlX1Eip6pjNYkdyCnMaPpZ7LPHPRbX0kDUIHNaDaAU+mVCP0s4Se8MxzOX5JtLNITg0A/+eOCroHpzuYAGHYOV93iBjaOqZuo67obgi/dG7f9+7yTgnxn50Q85S7RNcTUiancs4FvKImZJnG/IIeRb4r/QNG+erkUhoow5ZpWZhS5b+/IjfulgFmkLImuLou74tq1frmPnaV/XSqApHnx6LfKnWv4JOYA9+S9aEtlKENlLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx1Mp+6BOSUYCtqcJt7sT/7hDIoy6DERxy8+Fe3AdQE=;
 b=D9h05Bp0j05qB/K1lMU5s1zzHI76gZEefCfgnZV6vCVdYViTM+eUoJQlZXQJ5VJIKYQ0Pks1vsThqnYoPujxM0QibV6LaaY/7SuGaL5fMBefeOsdfrsRfDp59QGEucf/hiD4d6J9GBvS0ucOlO1tNCqmX5KbePAPnTZyAlaHwYfTrhDVaciaqK4q2GLkyYjmIegfQ4qDj+sSnVIMdyfSlZL531qR9Q8u0es1pstgVQNN+ucZriXibhP3Te2utN/DzltuPaGKSQpu1VZ7+fvE8TYFQSwudwhfuaJmWLKlmAdV59fRyRZ9xJj1pgJC2El+zyf3pBt3pr4+27Xpty/u2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx1Mp+6BOSUYCtqcJt7sT/7hDIoy6DERxy8+Fe3AdQE=;
 b=r4Fx31Il+3msD0yz3kSHMbIag7uwicemX5N51NJU+Q6+ukuVrujCSsLUZlpGZLC0ZCtWt1z24PzVXYuzxX6UO3KbM/+2gnvjmSSnMXw6gRG66XHZ2rj1z47evUO2rcmu8Elz/1SGF13zqQhfm2gpYZOGr89Kzl/xs2Dul9RatEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 17:33:30 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:33:30 +0000
Message-ID: <8df9d007-f363-4488-96e9-fbf017d9c8e2@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 10:33:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: kprobes: call set_memory_rox() for kprobe page
To: Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250918162349.4031286-1-yang@os.amperecomputing.com>
 <aMxAwDr11M2VG5XV@willie-the-truck>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aMxAwDr11M2VG5XV@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:930:1a::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ0PR01MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa6b52d-c3be-488b-be5f-08ddf6d97c05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJBcEZ6elRDdWg3WVd6cFdWOHk4WkhBR1pxcHZseW15UUttVytIaERmZm9F?=
 =?utf-8?B?aEk0NmhEekZrNDZGVUZoMG10eWNhOFZpVCtLbmQxR2ZZQmxnL0g2OVFoOVZl?=
 =?utf-8?B?bmszOWNUZ3NtMjd1dFQ5ZFpvankzRmQ5ckVyUk1Qcm9BeVU4WFRZQmx4ZkN4?=
 =?utf-8?B?ZlV1UlB4NVNzQlRoaDIwQ1VYOFlCVlNPbG9KSzhpMEdORHVDWm1GNStjTFdy?=
 =?utf-8?B?R1BraER0L1FYSzNvTGZneSszdXNLM01ENk03dFVocEEzSW55M2tsRUpuOGRn?=
 =?utf-8?B?akNIOTRYUEpjRnVHSWZSSXIvNmE4UGNHMW9oNG1BbXNlNnVMNVhBOTlSaUFy?=
 =?utf-8?B?MjdIRlk1VFVKVUhGVWIyY2t2dFVsUlpVNC84Tno5cTdhQjRpRC9KUWZLYzgz?=
 =?utf-8?B?UkkrUFhrRDloYUdzZE9rSGtDQzRyeXBZRW91OS8xMEM4UXVmN1EzMnVyOVd2?=
 =?utf-8?B?c3lqbVJpU2k3eUlud3N6dkdEWFJyT0dBaTlHZmlVajFJazhzbUtteGdyelFW?=
 =?utf-8?B?SFJXb3RDZlpIKzM0MUJxNHlWbW5FUUswTUc4N0hXNFVMRzZ3OEMyZlNPVjVD?=
 =?utf-8?B?cE5CY2tSSi9aODN5T2N4em5DbDQ0SnNCOTFBYWNuQjQrRVZkODRIVzA5SW54?=
 =?utf-8?B?VTJFL0VRRnJhUVpqRFdRRUdFem9nejl0NE5aMmpqQzcrZS84WVVXcUUyclVZ?=
 =?utf-8?B?cXhJYzdDMVc2b1JPU2NjeVJsU1pmUkxBdmtNK2NsWXJJWWdEaVdpbXhtejdy?=
 =?utf-8?B?OTFkUGU4cDdBR2lSUCtiNjBaZXVOMWYxaXNTRXgza09ZMHBGVVlESS9NU1Nl?=
 =?utf-8?B?NFEvQTlMS2JSUG5zKzJQVyt5MGZvT3RoWnFWNVJBMnVKNUl1TDNReGVJbFJ2?=
 =?utf-8?B?b1g2dWQ0ZGZ2SjJWNURMYjkxbjdFQzF1V0gzNFlWdXBvSXpyb05CSzZVZExw?=
 =?utf-8?B?eS9vZ3FVNmtDVnlpM00xVkhkMmRNRUVnd1pvdDZkcjB3UkY4ZWcvYWh4bjN6?=
 =?utf-8?B?Z2YrWjNnUTFXczZqNTNxNTFueVpDazRtbVJYcG5GQUZ6TXlOVGVhWFVENFg3?=
 =?utf-8?B?MXRmWXZEb0tEb1RidnF6bmY5bUJ0Wk5FTUltcTAyTnlWN2NYeHFzckFtWTh3?=
 =?utf-8?B?Y3hlRXUyeGxoaVlXTjZnSnJOTyt1d2luZGtsVk8rQ21kcWdvOFZSUk53U05F?=
 =?utf-8?B?R0pQaFBjMWJJZ0phTmExQmt5RHhRSWZPajlLQ2NpbWR4Z2M2aFZOU1FuTzJn?=
 =?utf-8?B?NTlOczZZK2tTdU4rMXU3U1hwRGFPUCtGcGdQU3hycUc0ajZ6QUZqWFNIN3c5?=
 =?utf-8?B?QXM2L3FzSWdEZ3kzN1pTT29QeEtxWWMrZFAwTTd0anhWQ0xqaWVqclhkMFU3?=
 =?utf-8?B?c1dwakREdytyZ2sxU3ptaS85ZW15NFBxaWZHd0FsRk5jNWdVY08vMzdxVURh?=
 =?utf-8?B?YjdJazFFQ1BySEhOZWlibVJqTWFQRjFqL3QwTlRpb0lDUTBsbGJBSEEycG5a?=
 =?utf-8?B?STNmWVdPeG13dEg0a1hJVjM1bjk2RHAyN1FNckJnY1BpNC9JZXd3bTRtMGJh?=
 =?utf-8?B?YzN1bmUwK0g0d2F5L3Z0dUVKRmZlMWZnVU93UnAxWDJZUEp5TXBvcDNENE1F?=
 =?utf-8?B?S0VLeCtPaUR4a3k2WFFLazFSN2ZkalJleHl1d1RiMmJFdzNCdlAwdkIvR2V6?=
 =?utf-8?B?THJhQXUyMEkvZGhCc09KamNESjVDWlA2OVA0ODNzcEVyUmRrWUdZalZhVkNx?=
 =?utf-8?B?U1JHVnRiMmlSS2RVOGNvT2FMb1NEeWQ4aW1NVThpSHRsTTk0WVVDT3Z0STFY?=
 =?utf-8?B?c2E3dXA4MUtWTFhsRCs3UUw5TnloZmdLd01DU1NQZlN0Q1Z5K2hHb3NDMXUr?=
 =?utf-8?B?M25tOTJUSm5tdmJOU2VmV3VsSTRHeXZyY0NtVW84UGZhOWQ0QmVaSWF6SEZu?=
 =?utf-8?Q?NS3ZbH9HuL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdrR1cvdzhwOTFkR0p1TGQ3YTh3T1EzTjV4Wjdta2FlV3E0ellwNGFueW1U?=
 =?utf-8?B?UUx0WE9QSHRIbnNpWG9UK3lmV0hnZmNhS0ZETjNsdlRsaFowaWZIMmdMNGdT?=
 =?utf-8?B?cGtJTVNOeG5qajdRN0xmdi94cDRtMFRSdDdJQkpsaDdkT3NCT1FZL3lJckpM?=
 =?utf-8?B?VjJpMDVnK1YxRlpCK2hsdnFtQVlzRzM1akJnRld6aVZtS2xaUTBRZXpNVnpZ?=
 =?utf-8?B?Skl3T1RiYURnQzBQQUp3VDJyd0dvMDB4NEs3TE1Fd20yWUpNOFlKMU9EWjJz?=
 =?utf-8?B?b3Vlay9iRlhKSllVTFRvY2VaZTRxMDI3VWxQaG5jNng2dWNqSVVuQ0dmOGQ3?=
 =?utf-8?B?QWo2c0ZYMHQxMFAwdVFmdVRhWmlqbzFJQXE1MmkzMk8yMGd5Q05kdlYxSWdC?=
 =?utf-8?B?dlFZUTR6Q0Q2ZjBvT0gzVEJCaVl0RmxkTVM4KysxOEZNU0tCM0FUQ2xIeHRK?=
 =?utf-8?B?NDVrb2lWTE1WbysvVFgxd1FNTzNvN0taSWp4QzVYaFdJWkI2akNNMExiTERu?=
 =?utf-8?B?UWxCdTgxbWJ5TTYwVWJjQk9aV2l6aTlXVTc0WnpGTGhjbTVJK0M3ZGJBMm9k?=
 =?utf-8?B?cUwxWUkxdDdMeGVOYVJGaGgwSHdjV1dpNVZqZGp1emdlT2M2VTd5WW82ODMy?=
 =?utf-8?B?TG1Ib29jOEtJbEkvM29qc1EwZUpzdGYrOVBWSTVCaGJWdy9TSGZTZW9najFF?=
 =?utf-8?B?UDNHUjdxclo4THN4WjhjdXZ1dm16ckplTklrMTRObTFuUVhOdHo0eWJhRkxT?=
 =?utf-8?B?RnprM0FwaThDN2Z5ZEt1RXdCVW80ZFd6YUhQcHhNTHNZOE1GMUxhUE5iRUl4?=
 =?utf-8?B?S3FaYWVVL1VDaE9Laytjd2ZpQ3ZRUTd2cXhzbEY1ZkhiNGIwNDkxQ0ZhQ1Q0?=
 =?utf-8?B?Z1VxSUh5bk8vOUpJQ0VwV1BFTkRyZll0Ui9OZ2NJekNwY1B6b0NETzFEOG5C?=
 =?utf-8?B?VXdLeXBDTEtRVjBROElzMEdodjl0eGJKTkE2MExLYS95bUNaZWhDZWhMcFIr?=
 =?utf-8?B?TU1VTGlhdGYzVUZLTndybzl5cWZ0T0ZzeVY1QVN6ZTVWYmNZUUJ3SGRHOEJC?=
 =?utf-8?B?WGdQSVVyUDRoM2NUSHF1QXdNS0plWE0zeHFkTE9HdFlvNVh0U29HbDcwZUdn?=
 =?utf-8?B?SXltaDdMYkRMcW0zeFZzR214cWlCSEE5Wk01QmNOMmF3NEQwWGVxM2JFNTZR?=
 =?utf-8?B?REpyUGI5aEJvY3MvNit0V0NWM3FWYzdrQXhpRGZrdStrVWg1RlFtRWpGVXN6?=
 =?utf-8?B?dHNKK01PbXFuOVlEK1FSQWpHRW1QZlFzYkJwZVIwNnlRakRWOTRjaEdhTGJy?=
 =?utf-8?B?TFM0VDkyTVBHc1BoYkJ1RFk1c3RaWFBCWmg1SUIzVHNNZzkzcERvY055bTVj?=
 =?utf-8?B?NFUvWEZXUFJmZ2cvbzBXTlQ0N09aWjBwbVdVQmhJbUlCelk2QVVQWDR1ZEZS?=
 =?utf-8?B?KzNoYTFMSDVRVTNuUDlSQitJYlg0WUo5R2hiWVN2ZFhlRlF1NUNNU1IxZERs?=
 =?utf-8?B?K2dWWmVIaW0vengwQ0g5WFRKVjFMcmtqcGFDWDZkTmExRkI2UWUzdWtYZkNO?=
 =?utf-8?B?cUJKb3lrR3pJdURrM0tUdEJEakZlL0hwMElqVkU3b3ducEhFbUZwTWlaOE5X?=
 =?utf-8?B?SlJuR1pHNnFlMWJqZUl4UmFLekJZWHJUeXhYMnZ0SUdkMGhkcyt5WmxFU2JR?=
 =?utf-8?B?Q3lyZVNwbHpGU3RncDRhcU1tQ3VHaTl3K2laclBHQUI0M3JXR1FSOFJWckVN?=
 =?utf-8?B?K0M4ZTFRTlV5Q3FmbkVndVFEZGZzbndneDJoQ2w5aFpycy95VkhuZFZhMk9p?=
 =?utf-8?B?elo5SjA3ZHpVQTI0QnBXSERsVEFmWWU1Tk1pbXRDalpsYlV1dHUwWXI2M2M1?=
 =?utf-8?B?S2tVWVpDTEFaZnpYTmh0QnNCa0RVT2JQMEVZWkpSQUpqZ2VrclJpZjgwc0I5?=
 =?utf-8?B?WmZlRFhISjZpc3hMY3lPSWpRd01yczF2QW4rbTg4a1AyZDk4NXZyemRMTXls?=
 =?utf-8?B?WXVyNFZ2dDFvdndwOXFXaDlKUVFYTCt4Y0RTbDRBZlZZN3B1M3A0elFsZDN0?=
 =?utf-8?B?WnUzV2RFM1BUUVlZTVhlVFExLzh4N0hCRWZTeW5vQUtIVmttSG9FY00vRFVG?=
 =?utf-8?B?L1dzUURkTytNcmlQajd0elNCRE5OS1hndUhWM0V5d2VzdWdsS3RkaDBidCtn?=
 =?utf-8?Q?aOv1jD0S+OstRbaGvKHMK6g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa6b52d-c3be-488b-be5f-08ddf6d97c05
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:33:30.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzMH+8VfzhglnlbZ/l74fd92wFOWCZqrNbAiwzB1TcUU43krqFKYjpGhJwzzCoggPJNoQqqSN988wWeXQB6SQT5BJdRQHBIa1Uuu+TfEGI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6509



On 9/18/25 10:26 AM, Will Deacon wrote:
> On Thu, Sep 18, 2025 at 09:23:49AM -0700, Yang Shi wrote:
>> The kprobe page is allocated by execmem allocator with ROX permission.
>> It needs to call set_memory_rox() to set proper permission for the
>> direct map too. It was missed.
>>
>> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>> v2: Separated the patch from BBML2 series since it is an orthogonal bug
>>      fix per Ryan.
>>      Fixed the variable name nit per Catalin.
>>      Collected R-bs from Catalin.
>>
>>   arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 0c5d408afd95..8ab6104a4883 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -10,6 +10,7 @@
>>   
>>   #define pr_fmt(fmt) "kprobes: " fmt
>>   
>> +#include <linux/execmem.h>
>>   #include <linux/extable.h>
>>   #include <linux/kasan.h>
>>   #include <linux/kernel.h>
>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>   static void __kprobes
>>   post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>   
>> +void *alloc_insn_page(void)
>> +{
>> +	void *addr;
>> +
>> +	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>> +	if (!addr)
>> +		return NULL;
>> +	set_memory_rox((unsigned long)addr, 1);
>> +	return addr;
>> +}
> Why isn't execmem taking care of this? It looks to me like the
> execmem_cache_alloc() path calls set_memory_rox() but the
> execmem_vmalloc() path doesn't?

execmem_cache_alloc() is just called if execmem ROX cache is enabled, 
but it currently just supported by x86. Included Mike to this thread who 
is the author of execmem ROX cache.

>
> It feels a bit bizarre to me that we have to provide our own wrapper
> (which is identical to what s390 does). Also, how does alloc_insn_page()
> handle the direct map alias on x86?

x86 handles it via execmem ROX cache.

Thanks,
Yang

>
> Will


