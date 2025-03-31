Return-Path: <stable+bounces-127028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A8A75EFD
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C497A25AF
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A670805;
	Mon, 31 Mar 2025 06:47:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177B1876
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403625; cv=fail; b=tyaH2/uf6Pxn+9P41IoP0yF0bScbS6MImt9i/CNQPIeaE7Y2u8wpXClhw5WxpMN9d7R/GTyT5zE10AN77tBgy/IaawHEpVWL98KFeosq9ZZKOYngfiRhEIAB0V7Cn/YnQvtc97WieHywqAAZSHq2XdIR/g9m6VsQD2OarCYPM1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403625; c=relaxed/simple;
	bh=cdpZkWhVM4mThPS1wUoF+NR3YVy+lORoYgvxjzbUaPU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lk4wT3f2G2de2zRAT5y0xNpYmWYd92XwPiuBSTLXLILuKtgjLlUGpLXq3ZyZW3B47FfVJgu8dyVLx2S0hwIeE0Hgo3PGYSj+LNOViv5yybU8GuIabx4htXFSIgpMeGvZmN18bHDlPH//pFqBuT0ESLCpCmVjP1rv9tEf5OiQ770=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V6bU40030939;
	Sun, 30 Mar 2025 23:47:00 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45pnshh8hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Mar 2025 23:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8w7t1A5KBAJB5D8qJvEy5XPlxVVbu4gFoumi+LQY+e3r4/+Tc/PnIMOQV3WcM7INSIkogJ8tD+3ghpB8F8Jl0yD1zVt2NtITGihFVMqidFJ9zGiP93Y/pOfowBGRU2qohluwVuXioTokDwozHPWH5pb/9t0gRR2y7Vai/BakWdvj2G+Cgdz+PeaZVf3HpwunQKSJ+3wXeohkV/yoKXk1GgYIS9fdPPg4GqOuhY212LCb9/hD0ymmNmqlN8SH+nbJpU7BNWoFIHwoNOREoyvG2uVrcyGkEgao5E4idROMIBj6zMoelUGHiPvw+kHSVBj+6sJXKasvnIpKvAVLirB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N5QuMQ8ZvPHzxU6OEMEP/v26LEOrh9U+a5ng56E7yg=;
 b=t95dy8iunx7Bn43ClbQbURz9JUiw6K0aIreGnx4R1MBA/c8ZRJWrbPaoWb0oxpwIF5P2OmS966rwpDcdXCxhWiwphJpT5WI1Uq3pnqOOJbOT6JPNV4eyesLSlKiAbs4pA8m2IEQ07QekhtHl2z7lud7JlkvPbKQrEIu0E31GI5ikh+Kow0qtp0lNKwMYj80SK74jALFT1hOM9wzaa32xNA2/hjr2prrT+R0HsXhSaNuWhxgnb/Bz68OPcUnNxeJsv6ONBhAqVwW4L6VJwGK9AWwJX/dSVHJyGJLEoU0qz/yblE5zIyyBXGN6Spxkt5ZHHuDLftzIhZdYIsERsLutsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 06:46:57 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 06:46:57 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, bin.lan.cn@windriver.com
Subject: [PATCH 5.15.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 14:46:40 +0800
Message-Id: <20250331064640.3180481-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0350.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::16) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d26d83c-a269-4a0b-e17d-08dd701fd4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTNaQXNhaUJ6MDJIMksxR1F0RFZIODRwellNNWZhT0tlYkg4K0lFS1U5Ym1U?=
 =?utf-8?B?U2ZiVVRXcklkb0E0RVN5QU9xTFl6K1FYTjBIZVR2d2JGWXB5L1VuUlQ3VXZG?=
 =?utf-8?B?RjljMjB4K3BKMGVWZzU5ejg1aWRHajJPUUpiZkhRV0NXNktpVkpvWTZxL0pY?=
 =?utf-8?B?RE5ZdjhPVUFyUGprSTBDdU1NWmpXeDlGZGZzR3hJQU1wdjVOV0FiVmZVSkdQ?=
 =?utf-8?B?L1RKVnEzeTBpNERmQnZsazhPY3dranIrN2IwOUorczJiU2w3ZUlmRHJEWnN2?=
 =?utf-8?B?SDFpVHRaY0tEZ3IvWlAzRklkZ1N2c1RSOUtLbFMzUkp3NWhFQUR1dGdiQjdU?=
 =?utf-8?B?SmRrZGpsRFVWYm84MVN4U3V3UDdJNERxY010enVJZHlkQW9IeWtkSnN4Wkgr?=
 =?utf-8?B?cW1yZ2FQRHdyY253THNKUVdsTGt5L0loTnNTQ3pXaUZUelFYRElIekY2d1E0?=
 =?utf-8?B?YlQ3cGJFZWx1V2EyZVU0ZG95a0ZUMGIxWW8wZ1Z1VW9xVjdoby94NjVkaVNO?=
 =?utf-8?B?S25kYWhYSlFxZVRMNCtKVWZxZnJDMVhiTS90VG9yV1EzWGx0dE1JZ2NZZ0xs?=
 =?utf-8?B?MDI2bHhEL0JFU1FqZW5hUit5VzQyYU45MEZzd0Q2blBVVVpIQU1MWTFiTDRH?=
 =?utf-8?B?NlU4ZjhZaTNtUGdWRjd3ampVQmRQbVZGcWdZZnBDWm8zK0d3WWgyZDEyQ3FJ?=
 =?utf-8?B?dTRLb2lzcitPcjF0VnpvMnl4a2NJSmFBZ2J2UFgzYkdRbEZaNW5YTWN0aFNu?=
 =?utf-8?B?UFdmUzBGLytXZjZsOHFyZEorUmVmcG82NDFwa091TFF0TVV5dzNYQVdzdTdZ?=
 =?utf-8?B?ZmRHbXJRb0VDQXJtbkZydFhZS2RhTHVPdEhtNVQ5MHEvcG1HY1B1SlRsbWZk?=
 =?utf-8?B?REtNeUdIY3RuYUdNUmNlckVHNUxNZmZBZVU2OXFXbGZQUlBsQkdsVkRKbWdn?=
 =?utf-8?B?NlFIMDdPUHVtQW00SW5WRXNudCtDMEJsd0dqMTk2OTYrV1YwcWVKdEhSQi9G?=
 =?utf-8?B?K00vRUpULzI1ajZDWTRyMXNySzBNUXNJTjd0VFA1dFoyeldtMGxoK0d1YjRI?=
 =?utf-8?B?WTg4T1h4a0JoMExpMUhaWXRqWmV6NVFJdTV4bmozQk9tdWFXUW1jRGM5djZV?=
 =?utf-8?B?NkJBQU82N0ZUM242V1I5MkZrNXNVVGk3cHF0UVNlTE5FbStqQnlyZktDa2I0?=
 =?utf-8?B?NitDSUNEOTZsZEVpZEFrcUZhd2NJMmRySUFoOVBralJDMDZHcTB0MHFGSEgv?=
 =?utf-8?B?WUtSMjJqbWZJVGFQR2hlRk4za0F3Z3lMY1Qva01IL1V2Z1lrVEhzWWJQL3F3?=
 =?utf-8?B?MkYvSVlWYXR2SGVUK0ZTQUdWbU5VWGlMYnIzcm8rZi9FcWl5VEhlSW1KemhI?=
 =?utf-8?B?OUVuRWVLQitpa2p5b0hvYkpmN2R2Z1JqaWFLM29DZmJmdVBvTzU5WlZ1Qncy?=
 =?utf-8?B?R0U3NElLYzdhOHNZdk92clVTT055T29FRmh5dkhjSHlXeHNEck9iNmR4SUV2?=
 =?utf-8?B?V3RBMnBXNnp2V2tSaEdGOWFTVThvbmdQVENMWENqMmNCL2Evb2hMdUlhNDl3?=
 =?utf-8?B?dXlqbUoxeTVRWHJBWi92ZFV0NVFSVVdHUFV6YnpkZEZtcGZCUE9TcWt2YUgx?=
 =?utf-8?B?R3IzblRXKzBKdjJWZWxnT3hxN09JSFRaRVhkTUg0cUc2cUJqUFArVFIvbkVC?=
 =?utf-8?B?azBZZWFYNS9RZ3B5SUN5N1FMNHlHSExZSzRJeVJES20wUUhjZ3RKQlFJNHhw?=
 =?utf-8?B?amQzTXVFaUpjYXJjd0hOVVVjRmgyMWtDdEdYaHZMYldldzlnRHlqSzFDaGEr?=
 =?utf-8?B?QkVDejBvbFJabUJER0hOOXlyM2F6dFFsMzB0UG83T29hMVVJSHo0d1BOSVUw?=
 =?utf-8?B?OFBxQ1BwSGhacmwyQnBvUUUyajByNXRhc0JvWG0rL0k4UXlyR2hNT28xemRN?=
 =?utf-8?Q?J2qMj00N4N3rT6LnrwMCLQ6kjNdFOebw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDJ1QlZxYkpvdUk4Y2pGaDFaYTY4MnlKSVVpZHRYRGI2NjlUZ2FrR2xYZjly?=
 =?utf-8?B?SHc0YmtNRy9TMVVaWlVvdFh5TmtGQWptVnFqRDBrMlZDWUtwMWZ1NHUvQnMx?=
 =?utf-8?B?a2dsUHowUjJHL3Urd3FUYUVReWlQNFhqQXJVREZwbUhlejZYVU9Kb1FMZUtv?=
 =?utf-8?B?SkUwdG9jcDJUM011N2R5VXFrNmJ5VXlkZE96SVM5L1plN0tJRlRURjhHcjFE?=
 =?utf-8?B?WDlXaERXMUthbk45TzltZWJyenltemJjSDBhZHBQazJHQ2NmWE5raWE3UUJw?=
 =?utf-8?B?VFBxMTZxWXZJTXpKR0F5VUdTOTlnemltY3ZJc3dKZ1o2c2xBUGxuVG5vSzZi?=
 =?utf-8?B?UDVONGtabncrcWZvNEVxSXc3VGcrUW4wK081aE1MM1JJWkpoMENQbTVJTnU1?=
 =?utf-8?B?ZUtBUFV0cFVCREFrWENBNFh1TUxMVUs3VjI5RmRrQTQwTmRDbEs0TFlBOGVq?=
 =?utf-8?B?OXd6MGltYlMxTW9EbGVmSEc4Yld1WVVMWitnWnpyb1NTSFNEcTdLc016QjN0?=
 =?utf-8?B?dW9qMkhWdTlXTk4xMXg5Y3lLNEgyM3lSbHhzbUJyN2k0V29VRlNmMmRPcHdN?=
 =?utf-8?B?RXdsWnpQUHowV09vWkFJZzBLY2dlUUpvZ2VxWEZqcVBJR3F0ZWxmTWdZSnZS?=
 =?utf-8?B?YWYxNEJQQVhqcklGbkZYdGdwa2swSzBtV09KVDEvN3l3UlJUTWRDMWhkcGdu?=
 =?utf-8?B?cnEvK2pYakFHTk03NnkvNWk3T01QcTFwbERrYlQ3eEdnYVN0SDhzemhRK0VZ?=
 =?utf-8?B?S05XYndmRVhQTjFVSDJ5L2hpeHBFZXJweEhiQ1dWTi9QdzVnOVEyeVEvOWhF?=
 =?utf-8?B?ZUQrcE9QZHVxekVibXZRaXc0RkJCeEM3RElhMGE5STBIWGg4ellwZVRsenhN?=
 =?utf-8?B?eFhSbEs4ekxzdTFRd3dUL1ZMZDQwanRkS2U3TVQxUDJtTm5JVHNRd1ZGb1l4?=
 =?utf-8?B?MXpwSzlzOWFSNVo5RTlaVEJPUE9BZVR2aHZSZ2ttalArVWZWNk1RMjJpY1Bp?=
 =?utf-8?B?SS9zNXdOQmJwYi93WEwzOXBjZHRsOWNYVXUwbWtCd0JKcTJPMlY2R0crYk5M?=
 =?utf-8?B?NXB4S1ZVYngxU0F4R1Q2UVpoa3Q5L1J1aEgycWx0NWJyLzJqcndpaytwamRq?=
 =?utf-8?B?d2JacjJnNGJwalN2T3pGTm1vUDd5ZUhZSzF3dVA5VmVxa0FVMHkrV2NZd2tP?=
 =?utf-8?B?UEFNNVBMYWpnSm5nalAzWS9YYVhzeFJvV0w3S1lnclZzbDlucndXclZ0V3N2?=
 =?utf-8?B?Q3kyYXBUem84cE5JWTg4MHRVWjNOZnRQQm92U2F2Z0I1VTdlWDEwbkVvcUJV?=
 =?utf-8?B?K3pQUFBiemhqZ05UaVF3OGlUbWo2V2pTYmFvZ2tuT2d1cE1STWZ4Q2ZjWEhh?=
 =?utf-8?B?R2Y0UXAwVlBsUzd0dTJ5TGpiZk4rUXNQcm5WalNVZEV3RHg4L0ZWYnlsSWQv?=
 =?utf-8?B?Sk1yT0VjVG8zc2M5cGtCNkJrSyt2cFpFOEl6K044bFVtQ1VGYWRVejBmRjlw?=
 =?utf-8?B?MzUvaiswK3A4VE1SRGtqcEFJbkVSdjFmOFVKM0lQWXRzNFNIYk95Y0xKaTVo?=
 =?utf-8?B?N3QvRFYxWXRrUGR2ZzFBS0Jvb2srakJ4WnFYMXlyOHkyL05VWHNwOUE1S0hh?=
 =?utf-8?B?QVkwUzFqcmlSaHZHdFd6QktXWHJCaGxKZVBJUVBibTkwSTMwMDllVSs1aFV0?=
 =?utf-8?B?UFFCSHJYeVpDT1hrT1RsNE1WRTdybjhzZG1GalR0RC9nTVBWbTBGVmdCdmdI?=
 =?utf-8?B?eE43TUt6N2JacG5NblhMR3AwMWJTWmNNRkozMG5OTHkxRmlKYi92NTREVVRx?=
 =?utf-8?B?ZDdqY2tVL0VCMk1qREVLRXNHSTg2b01xK01ZU2VhYWJIYzg3TDRidmtuYW1J?=
 =?utf-8?B?OEt3TndmQXJvUExwRDJ4VFlvRklLNEEwTzFoRW1aTUtiZjdKZ2IyUTByWkFv?=
 =?utf-8?B?NTN0WVdNRURSZWFxekNMQVVBbXA4MFMyQlJhdHZ2S2liVGQ2NUp5TlJEdXJJ?=
 =?utf-8?B?NndiRVNFVVFQVitoV2dPaTMyMitqcit2V0VSbzJ1aW50RE93MXorVGNtL2Vi?=
 =?utf-8?B?enVsdGpmenZiZnpkdDdDUkFoZVFMMWJ3Z0puZkJ2TjZKS3lhQVQ4QWhqUUQ1?=
 =?utf-8?B?ZHhlQklIMjE3YVZPVjN0T2hCSnVjaGlzaUtYTG1acUl1VWNKM3dWQ1c0ZFdS?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d26d83c-a269-4a0b-e17d-08dd701fd4ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 06:46:57.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThRl0sgl+x6Yakyxwkm0nW5g+gjBRW65SNuq0JdX9dZ4zkVeIozfl05UPjw2hqw9SPlmMJtNQZr18DVvwje3557s7ss6lMg/lg4MzOWLpAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-Proofpoint-ORIG-GUID: GKcc_X9LV32he1-4gZX38YSvSxJNPrll
X-Authority-Analysis: v=2.4 cv=I8FlRMgg c=1 sm=1 tr=0 ts=67ea3a64 cx=c_pps a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=yxFpyxf4MhevmFWHfCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GKcc_X9LV32he1-4gZX38YSvSxJNPrll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=984
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503310046

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 545b215736c5c4b354e182d99c578a472ac9bfce ]

Using __exit for the remove function results in the remove callback
being discarded with CONFIG_VIDEO_ET8EK8=y. When such a device gets
unbound (e.g. using sysfs or hotplug), the driver is just removed
without the cleanup being performed. This results in resource leaks. Fix
it by compiling in the remove callback unconditionally.

This also fixes a W=1 modpost warning:

	WARNING: modpost: drivers/media/i2c/et8ek8/et8ek8: section mismatch in reference: et8ek8_i2c_driver+0x10 (section: .data) -> et8ek8_remove (section: .exit.text)

Fixes: c5254e72b8ed ("[media] media: Driver for Toshiba et8ek8 5MP sensor")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index 873d614339bb..2910842705bc 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1460,7 +1460,7 @@ static int et8ek8_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int __exit et8ek8_remove(struct i2c_client *client)
+static int et8ek8_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
 	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
@@ -1504,7 +1504,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.of_match_table	= et8ek8_of_table,
 	},
 	.probe_new	= et8ek8_probe,
-	.remove		= __exit_p(et8ek8_remove),
+	.remove		= et8ek8_remove,
 	.id_table	= et8ek8_id_table,
 };
 
-- 
2.34.1


