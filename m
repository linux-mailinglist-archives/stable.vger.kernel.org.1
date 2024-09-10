Return-Path: <stable+bounces-74138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2CA972BFC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCDA1F25A61
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998517E010;
	Tue, 10 Sep 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qhPe3KE5"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011071.outbound.protection.outlook.com [52.101.129.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE933985;
	Tue, 10 Sep 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956311; cv=fail; b=UOU81x77OX9kubJObzzA03EAPa41ujQrE39jOw+el/oGuupmTs8o9ur+N5e6X5ftqOFbl0I0vu5qtwrlYXssHcKMwINGXwyeWqQPT4c3vElnRFUbRkq75tNVb6pi4MjEdgVpZxQT0xMPm0M7TcOvdfG7h7oUJGSpAhvlUehRoao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956311; c=relaxed/simple;
	bh=x+AyL1mVMB1uSuhCI6IOjvjt20yhBSTausRVPEVnAuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2UHxuTVbHTGwwY6Ujj+ZJjTBBP6CQ/rR1kGRWjIRtKHsBTOoo3ask0w2JypAv8fTwZpeR1uVXYd3Soj9IWmnGpkX5IWA83X0nsybOoGEJM5tflc35QEBYgwK99XFBZp1G7CPMFudnGbvnAt2QkFuMEIbyUieO19b5JTC4E2TeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qhPe3KE5; arc=fail smtp.client-ip=52.101.129.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICdzEXtrRzEerAkJtVi6hGySsNMgzKiJUYIUCt1pb0EgWGpr2mnLd2caGX3cHm5SgvrB7TrSGblFruwDsoiuCL3aV+x71iwIzH5S3D171mgrypNnaSget+i3o2Fyqn/WXQWOwoNTIexfS0vOOBSrPuh2ZSWcYjdO5WrnfpGdFx8f/z0CqWPtLlNuSsq2Hw8i4g8rou3ySUNtOt2PXVSjxy62rkwL/SmAMIuasRQ0Z1imWZxd5SoWgf6OOj2GNNZGjvLSRxjM5BvDn/Mel02DCiJpBGWkQJwmF7qa4t9D6tBVENQLcOTdygawMibDNaRfdY2uxBtwd/T6jz1GzrMHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUf+/LBrCKwU0sLEt49VnT6td5dlbwiYdKc+bcrekzc=;
 b=pDu66GoeYoOJgPL54nKOczbVdvn+cXS8lLPsBiH/C0KOQ2knN84wDgHXz1QhF4hupEUi3xkg3otrBSOWoueB6FU2etUlBN6Gsjln+63SoT4IS9a1hBngzbnIwmMqi2Sv6cJiTeJf+fxaxTkVcD6y82VBOrKKf+c2gFVxTU6qccoozI5i87Sy3na8S9T53AaM2hqvhB73ipIvx8uB4tBML4IEXl4DQx7Ztk0GHIeKFA0bLdKUStWVLfi/bJdRztCnhoGPYyzFxqNNCmJOi7fZotn78t5NunD+KEDnWo6NOI1I+UMT/22df7gjshq+8I+7O3o1X5h50r4eWjBabcRQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUf+/LBrCKwU0sLEt49VnT6td5dlbwiYdKc+bcrekzc=;
 b=qhPe3KE5r2FPs4ak03ZKDqTe3INHdyJgcJv1xUbkPAXEYbq61HiAFJH8nRkTp9tcqNKBtUsGSVOo+bwOrwq+YURfeR7Z85cWvHPolLh0AaT6co2DiT6bvTfQFtlwDB7H0bakjVX61ayrb3HeyRSaKwCXRdJ9aaJpoGLiBBW35xBse6eXeVuELAGNC8yJyNjm0sYSEIR2S0A1uO0vbxLWCXXY3UdSUHWvb/rRk+thFbPN7jo7Z7lyNgB/feSRf3dxrcYwBH0w3why9As5CgxsR0pPDczRCZZ4jU9InsDDwgZXBlnQvL/4tHEbAqUYN02EMFL87o+rDo7VsCynspbqig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB6813.apcprd06.prod.outlook.com (2603:1096:101:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 08:18:23 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 08:18:22 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wu Bo <bo.wu@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Wu Bo <wubo.oduw@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN happens"
Date: Tue, 10 Sep 2024 02:33:41 -0600
Message-Id: <20240910083341.283324-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZtuHv9ZbCxLmzuZp@google.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: bce3c6cb-a22b-4d99-a5fb-08dcd1712275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWRhM3dyT29Pc2gwcE90clAyb2swUDNTenIyWm0zSnhQc0l5dWxMY2k4alEv?=
 =?utf-8?B?OW1JOGc5Sll4K2hxWU5WUVJ5QjlYOUpVbmwxMlQ4UWdReUExNHlGNWFpTW1Z?=
 =?utf-8?B?em1ZaFN2MGhNZml1MjBQN0JwcEJkdDIyMllROGM3bHpGU1FWMjZ0dmJYM3p4?=
 =?utf-8?B?T3NycXdkTDg3TFdTNUNYTFRoNTc2bnJwWkg3dkpPb0phWUt1dkhRWWhmZExU?=
 =?utf-8?B?WnVLVEsvV1gySHdkeE1ZallHWThrekZackNlNjU5YkFJWXhHZytXa1p0VEtU?=
 =?utf-8?B?UDhabEFyR1pKTmVJNFlTcHVVSTBiak9Fb0VoNkk4UGJROE52V2xhQVlzWS9n?=
 =?utf-8?B?bkYzc0kzdzN4Z2RZUFpHTnV0c2RRcm51aGNmTXo3eUh0bEd3ZzRvT0d6YjY2?=
 =?utf-8?B?UnNnSnNTWnRFN1FZVzlZWTdOaHJnWUJLUWIzR1h6d0lDRXBsc2xvQldFWUZF?=
 =?utf-8?B?bE1pWDZrZXViQk1od09iUXg3TWJ5RmtmMStHWWdIU2ozdjZ0MG01NjdXTXNP?=
 =?utf-8?B?cFlLUUN4ZVlIYk1mYXk0T000cDQ5cFZSRDU1V3I3emdzOVlUR29jQXVNYkor?=
 =?utf-8?B?bW5LaS84V0JiQ1BmNHVEZFpEZFdBUHFsS3hUODdoSWYrU0VTV1RFcngzZ1A3?=
 =?utf-8?B?dlNiekJmWXppL2F5a2hPRC9PMm1jcGhzMm0zUmFwWnRHKzl2ckU2RU1GeWpm?=
 =?utf-8?B?bytBb3Q5dWkzUUNTT0RVcnFSRVc5UnVxSGpGTi9sOFAvQnQ2VXlVQldQc09X?=
 =?utf-8?B?VnBrUU9mamZOd0djRkhzZDdYNW9GTXlVRHoxVEV5VWRjQ1ozMFB2OVZyV05o?=
 =?utf-8?B?RnpOVm5wRDFjZGdWM2VqdWVRUHVwQm9IZVpZdzIrcVNDWlJzVGZwTVdmWTBi?=
 =?utf-8?B?Skhqd1NtSnF0QmUzTW1CM05iN0V0SXJhVDhzeU5QaGNQUy8wMFRxeHZQOG5L?=
 =?utf-8?B?ekV2YVM0WXZYVzlqbDZMTzJ5R3RBbWlEQlJxYzl1aUpYVmE2T1BPZmZ0dGVM?=
 =?utf-8?B?cU43YWVneGJad0tVbjJLSUN1ZDlUbmx3MXZKME9uc3I3Nmc4U1NoRWlqODNC?=
 =?utf-8?B?Nzl1YWYvWk1CK0ZpTW5jT0owODV3ZUV5QlM4R3c5L3hmd3dQdkpzRDZuUGpW?=
 =?utf-8?B?SXV4RnhJYnQzOXpXcEVJTlZ3QW92M2t3ZjUrUHhvdEc3SnVXVzlydmpVR3ZF?=
 =?utf-8?B?b1RFL0F6QnNzNnJlS1pDZzE3V3hSTFVIYWVlUG9uaGQ0UjA1OE1pdVVOTGlp?=
 =?utf-8?B?cll2U1VuQ3RwNkljNHl5ZzF1cFNFVG5sSTh6ZjMwMmMxWlZOcU5rK3NFU2tL?=
 =?utf-8?B?L0RQZExsUjFQU0h5RWVQZHkwVWYyMHZrTzJEUkRWUEJYeTRPQWljenN3ZWNk?=
 =?utf-8?B?RzRPZnh4YUQxRldTSkVCS0tmRkZQR1ZYMnRCWW1yMHg0bEpNUFhPMXJwUytl?=
 =?utf-8?B?NUFMaG03ZDFtMS9TcmhXVVZtUEdJSHZNNDRzS2E2Z3BBcmR0cVhLdE1RMDNH?=
 =?utf-8?B?bHU5QTJQbmVYQmZsbWpwSUUyQW8wZWlPNWFRUWNNMFZaUnMvdzk1NDR6dHRi?=
 =?utf-8?B?NERxZjhOcHR4czFUQThhVENITG5HRWZaQ0pxSDlyODNXVi94bU9sS2k4RTNm?=
 =?utf-8?B?RWZvdnQ4d2loMHc4SHhiZExINkNhN3ZCRE0wMXF1Y1RBSE5lTm01N1lzcTND?=
 =?utf-8?B?WjNGMTUyTDRUdjZ6a1FPU2gxY1NHVkdwb0k0TFZvenRONUVlUjA0OElqR29a?=
 =?utf-8?B?dXY4Wi8vUmZSaFBDeFc2eDkyeVdya1gwK0ExR2krRmNoZFdITlI5YnNJTlNQ?=
 =?utf-8?B?cE1pR0NJL0JEZmNqY2pFdnFGNW90QVFBVUV6a0pLVWUrQmh6ME1pckhMSG5u?=
 =?utf-8?B?VlBPMVQvRWJ3aXVHVENZRUo4eWpxR3htNUxnY2dlYTlTYkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5URkZqMDlKbEQvTGU5Q2tXR1BvV3h3cVdTbmg5VTgwK3VSaHNUZG9tNWR1?=
 =?utf-8?B?Y3ExdXV1R0xLbEQrS2d1Z01XMG1ld1JTSE9WODVjS21RL2M2bFJ5Z0I0NkVI?=
 =?utf-8?B?ZFZxNmF0eDczZ1hiMTI5QjVJcTFaVDlzZTJwLzFwUm1XQUxPaWtpcmNaa0Rw?=
 =?utf-8?B?UDlKLzE2am5EYkszTUlyUm1adGQ5NSs1TmVqdmxkN1pZWnQrTDhhRlYyTU82?=
 =?utf-8?B?UHFPbFAya283T0RwUWVRdUxlVGFiV2pUdVRWNTJ3WlZJODdPY3FIRk9WTjlG?=
 =?utf-8?B?YkdvUFovNE1PbFFNQklIT0FGcUVFSnFTWTdpU3BoNUlDdDFXNFhXU1FreE43?=
 =?utf-8?B?WG1RTy9DU1JITmhZYkFObnNzSUZSSDBWTFV2TWF4bmpwb3BHcGJ6MWh4ajgz?=
 =?utf-8?B?NjI0YjV5eDg4QVhKUytDa2NRVXJ0ZC9XbmhHNCtTT211N01XMjdENVVLdlhG?=
 =?utf-8?B?VWk4ZSt5ejJmY1pKUkZDZzRJaGk2eDBiWTlUZjRsU0U5WUhwcDNvUWFqQmlK?=
 =?utf-8?B?M2F2TG5PT2lKUXJJdHo0RFN2cDNhSXdkY2g2aWZNZjIyWkJXOXBBbjRjQjky?=
 =?utf-8?B?Smp2T3Evcm5nZzZqRW4wa1l2ZDFsK3lkaWFhdW1HMmwxZDNTMmdyWXBQa0Zy?=
 =?utf-8?B?ejB6R1JSYk5PYWNhVkFnMlhneHhiVE05YUtQMTRMaUFsbG9jVHJtOHpFbDFG?=
 =?utf-8?B?TUpOWERaVVJ2NHJTOWNGUjVCbnk5T3ExSk5hNjRkYXZnTGgySkZTQXFETFFZ?=
 =?utf-8?B?azJkMFJQTm1BclRuVU1BbHdabzNzbkl5UHRXM0lxYVFDc1lSdVg4bzMxd20y?=
 =?utf-8?B?TnFrSWtWTThHbmVzN0p0b0V2N09BajUyRGJlU2xHL3JMK0RLblRReC9sQkJV?=
 =?utf-8?B?MXRqVDBWNnI4YVRRTVVweGdseGk5alVBdjFWaFJmQzlrSW5ybUp6Q3FTNlI1?=
 =?utf-8?B?azhJdklaZ2pGVEpiV0crTTlOenMrTjE0S0Zka0hFdkV3Wm1jd2I2bjNEWE1L?=
 =?utf-8?B?UUpTUjhkK2VKcEYvQm9heHRlZUlwNXpHQmU1ancyTU9hNDZHMWRrM1FReTV0?=
 =?utf-8?B?VHBkRDI3citCMk0yT0wxbXp4d291S3VJRiswSEp0b1J6QXd6NzhjZFErZ1lT?=
 =?utf-8?B?RndOcGtlTVU1blJFVmV3Rmg2RjNxVW0ySFVKeDlpQ2YySDBNN1djeU5YZ0dS?=
 =?utf-8?B?U0pmcEh5MU96b01NMmFkVG1pdGcvb09EOEhnSVNmVVVnMVZiMFJGamtQN3pJ?=
 =?utf-8?B?dTdTWi9aakdwTHJIOHpGdlJpb01SS3pEUDA3Rk9MbWFpbVR1b002YnhENGtK?=
 =?utf-8?B?YURmVGIzNE9aNGhNTXFBS2U0NTdlNEFpa0d6Qzd1aFZ4dWhxZEErVFZ1VmlF?=
 =?utf-8?B?Umh3WWVmNmw1cEZ4NHBzcExXdXEvTEc0U2tGSEluNmpyQzJzT3lwMDUxcFdN?=
 =?utf-8?B?ZVRZSm5ES2pTaFBIMFc0WGdjQUo1MnBSUnNaOUE4aXMrbmlDb3ZoT1dHaTFj?=
 =?utf-8?B?b1B1TFV1SDJjMi9ZMS9Sci9DMUNoZStCZWpXOVpqZTZvV2VEc3lORTlDVEFT?=
 =?utf-8?B?aWRDdWwweW44NWVaR3F3eVVKeGJFdzZLVllLcUNGODMvRitDUXM0amRReVlk?=
 =?utf-8?B?UksyUjIxaHF6ZXRXemk5SnR5dFBYNWgzK3htN0UxVmxaZEZSbTJKRkRtVXd5?=
 =?utf-8?B?Wm1pZjdkRHlINm9tbUdEZVVNZ1dtRmhjV2d1SzZtVzhBYUZKVmsvcThvaWo3?=
 =?utf-8?B?ajFYZHRKdVUxNTlzcDB0UlkwWGNCUU9ZbnptUFd2eC9mcWlQM3lrRE5vS1d6?=
 =?utf-8?B?c01tUVk2cVA2UDZhY1VkWlp3cmRhdU5yaW5PWnhMVDZCWHFacUVTRGx0bHBi?=
 =?utf-8?B?YnpnT2YwalcvdTAzQ2szcCthYW0wVlpsUUJSRHhQaEhjN2lEWTlXM0FEVjQw?=
 =?utf-8?B?ME9BMHU3amlqVEsvNHZGdGU3VktRaDREQTJLK0labWNVZ0ZON0d1cFR6eXNz?=
 =?utf-8?B?RXMyeUhCalZkOTVLVHBOSlZHYnR5SnZFZW1SdnNVbDVkSDVjelZISTE5YVNu?=
 =?utf-8?B?SlVaSXV3ZUJpRGdPSjlCRmxibDljVTlOV3VJVFREZ0tXemwvTEJHWGorTzJ5?=
 =?utf-8?Q?FgJmowMBZTHLZ2oK8e8PYhtGY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce3c6cb-a22b-4d99-a5fb-08dcd1712275
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:18:22.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AucazNOmZTxXOBgC08W94TcwwrzeqlTufU4J1oqf6xqU/EeBgwiNMyEZpmsW7Y+eVQ8o8gaI5JkjW9Vt59NkZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6813

On Fri, Sep 06, 2024 at 10:52:47PM +0000, Jaegeuk Kim via Linux-f2fs-devel wrote:
> On 09/06, Chao Yu wrote:
> > On 2024/9/6 16:31, Wu Bo wrote:
> > > On Tue, Feb 20, 2024 at 02:50:11PM +0800, Chao Yu wrote:
> > > > On 2024/2/8 16:11, Wu Bo wrote:
> > > > > On 2024/2/5 11:54, Chao Yu wrote:
> > > > > > How about calling f2fs_balance_fs() to double check and make sure there is
> > > > > > enough free space for following allocation.
> > > > > > 
> > > > > >          if (has_not_enough_free_secs(sbi, 0,
> > > > > >              GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
> > > > > >              f2fs_down_write(&sbi->gc_lock);
> > > > > >              stat_inc_gc_call_count(sbi, FOREGROUND);
> > > > > >              err = f2fs_gc(sbi, &gc_control);
> > > > > >              if (err == -EAGAIN)
> > > > > >                  f2fs_balance_fs(sbi, true);
> > > > > >              if (err && err != -ENODATA)
> > > > > >                  goto out_err;
> > > > > >          }
> > > > > > 
> > > > > > Thanks,
> > > > > 
> > > > > f2fs_balance_fs() here will not change procedure branch and may just trigger another GC.
> > > > > 
> > > > > I'm afraid this is a bit redundant.
> > > > 
> > > > Okay.
> > > > 
> > > > I guess maybe Jaegeuk has concern which is the reason to commit
> > > > 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN happens").
> > > 
> > > Hi Jaegeuk,
> > > 
> > > We occasionally receive user complaints about OTA failures caused by this issue.
> > > Please consider merging this patch.
> 
> What about adding a retry logic here, as it's literally EAGAIN?

In this scenario, the remaining reclaimable sections has a block been pinned. As
a result, the user sees that there is enough free space, but fallocate still
fails. This happens because the GC triggered by fallocate cannot recycle the
section that has been pinned. No matter how many times it’s attempted, it will
continue to fail. I included steps to reproduce this scenario in my previous
proposal patch:
https://lore.kernel.org/linux-f2fs-devel/20231030094024.263707-1-bo.wu@vivo.com/t/#u

However, this issue can't be reproduced on latest kernel.
Seems this commit prevents the creation of non-segment size pinned files and
also avoids this scenario.
3fdd89b452c2 (f2fs: prevent writing without fallocate() for pinned files)

> 
> > 
> > I'm fine w/ this patch, but one another quick fix will be triggering
> > background GC via f2fs ioctl after fallocate() failure, once
> > has_not_enough_free_secs(, ovp_segs) returns false, fallocate() will
> > succeed.
> 
> > 
> > Reviewed-by: Chao Yu <chao@kernel.org>
> > 
> > Thanks,
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > > 
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

