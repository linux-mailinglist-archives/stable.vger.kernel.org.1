Return-Path: <stable+bounces-244431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPlALkdu+2miawMAu9opvQ
	(envelope-from <stable+bounces-244431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:37:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C394DE2FC
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5E4300A129
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D544D039;
	Wed,  6 May 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="g9VdTCfm"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF3F0754
	for <stable@vger.kernel.org>; Wed,  6 May 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085422; cv=fail; b=a5AGlc1z8JU0q52hsdTpDdTsYepKAbUlo8MOV0g2VHyiggCpS66aEudkwD9lbnJph6vy3efwp6y2heuQ9WpoM+RQ1Ix1pCnrDjWkr7h8whKeKZ9J4vaHIzq/ZtXUoTObNTi+lpR0IWqv4mmeNYqX1x+mLhgr4nXaHWGjdZiQjaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085422; c=relaxed/simple;
	bh=4GV+iTcdt7mCTNNcHiSqQVBEVWtpJg30kmEsn1+Vhxw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=We4GS62IqqnjeHSXHGnFVg56S09Ga5qIbOikv4kxBqEfbOP5H+sMDX7Gi1kLzHncPdZplBCtAA42l/6jRMQwTx6AxWSQ1SjpweBxadoM2nmscgwnOAtqIVT61LxSBI0rLwc2+kdnQE2vgPpRGYKMLGYGA4otvVXbeF4JGSMYqW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=g9VdTCfm; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeelLJqUsWnXHDnNmEtG56WzSmKGpzQSFBGwbDfr+RCO/1kikDSYt4TWx2YtWyxYSyAVieIwCEB+q16Cxr/IsYY+4NHwOfQNMHhVrXaeC+lQjpa9JbAasJzqD7qL7Taiy4VbRvb8xEbVTWNxBDBhn8JWbY1AmDc2jGPyD+NZHAzt7QnhqQMoOQp1fkEDzw72Uteu9uQdM1+Vf/XAMMZGdNk4qTlWtUrPW/A3E2S7MVka0FC6sxXCwDIwC+wYAhH1OHR2XSHbW4zzmpbJUS4a/rDI2dtff/h0o7ffevHIIXIeRFW4wuMqREMn8DEbV+9ZnmaIMYiJGe/YAFm7oQDWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxUCTaQbLjDLglF9YbfLZ2h2jqSoSuaBRC9oZXdVjvg=;
 b=Kez4rw+AlZ4FR7ep2b2CFJ/GWQ2WApZfZFoQ44CEgPTi4klijaFlvFaeV7+HH11tS0QjKx2z9kNxKrZ6ZblSF5fS+oYsGo+OhB2xYI8o4n0OYK8nbzTfDuexcqjI6jjo6udvv+A4w8HJPOWv0l7QrS1v0uqzcOHqrjnhhQ6hr0C2P4KVj1S7rrmBDcBMZJ8deUxH9lUb1qqt9vm/lHoWL8cSK09ugwIRLbPdsRwrUQEtuXIMhVwI5ZpO3gukEaNVHpRLwlloYoq+N0+lTc6Ahk1JO29qujN6oNB3pZ1hqhpIouW4QNq0s5rV7Fp2XnX5C9jjd7UhBF/yi1Sjwd6e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxUCTaQbLjDLglF9YbfLZ2h2jqSoSuaBRC9oZXdVjvg=;
 b=g9VdTCfmHIO2toie3PVGq8IEQoMfCCKhtdQI0BVwyhNouTLAHBGK7zNVzaZJ60SrOIzysl/eHCK+KAOQyR9N95ZghM1qQ8pngZEY7URxW6N+8d2sKHT4VtxkX4pxCEo1NdvciUv8aygJ7OOX7M6/wj0gBFVkBi/qFx/dZTsRwJNE3lRbw8wZYOvvEdCl0Gt8ggI3ePC5fLTM7yTBh/HJy7P/Y7MfJihTmJDm5pI5Pbi0972uLTXbCraTmJraoYDjExyLrz3XfF1Gqce8fDchi0vjLaPt6znQEYVuvMURYJwfzHgGv5OoHwGwYDt0oo9FozQlgDjTSEfSC9NSpD+zLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by PAVP189MB2483.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:2f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:36:56 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:36:56 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>,
	Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	=?UTF-8?q?David=20Nystr=C3=B6m?= <david.nystrom@est.tech>,
	=?UTF-8?q?Roland=20Kov=C3=A1cs?= <roland.kovacs@est.tech>,
	ysk@kzalloc.com,
	42.4.sejin@gmail.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 6.12.y v2] bonding: fix use-after-free due to enslave fail after slave array update
Date: Wed,  6 May 2026 18:34:31 +0200
Message-ID: <20260506163430.552483-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|PAVP189MB2483:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbc8a45-7c27-44e7-7ebd-08deab8daf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	um0frTLx4Fhe12lF/ZDgc0d4un0J0pZ3pdUODY29qvxSw9XqBewRzpHo0xlqfEt8J6ruO6lq0Pa5lxJU+raX2u50RNskahMXrmycTB4oXAUFMjIjPbIzdw6gPTzwzp8RDmNobFBZmmeyXuT1ptM2gHxmDJ+tBxEftvL7aPoy/+WKrC0E3T6OY9QbRb3zORJ0K0clunAj45OUIr7rK9FPrUSfBEikl4oNJAoc73wK8rY7c5kQVM7lWnB10aZSM2Bdh0MX9t9sWd/1VdemuUw5BvOsGsgh5alVhcRzX9zfZLeI1DqJLLzvJ03cRH1YjUKpIfaE+7IMWcb/AfkHrMDYixMyZhp+eGOD9UUMtyTbUI0atlukj9VDghV4KjjohGDpT5K36AdnJCYFzA3zODX6lmICTazeeryRJTOaW1VyJo+/idqrNakDkBBY3of1Oc9rN/epGYxXtoc0FSejBCxLBVQ+58AJdbpAXzopKCtx+MuLVkp3XKdmm3AHjVlC8QPAdCjAcn/lWFpgJArPOmc1jwTpvs474GKZy77arynThXYtP0L9ICUIttojRsaiwK8MSbkTNS+uGrOCeYh0SK5WNaihDeg7uuUtbLQYzBWnzijFt6IqetG8sBBz//v3xV3nu9DWoynOcqZ7trpBiXU81A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?empLTXdxR0treU9NaFJ5NzRITmJuYnppQTR4YUNsYjZsTXdVNW5GTEFEZ2tY?=
 =?utf-8?B?WkZ3aGpXelk2MVlIZVpoT2JRUnpwVFlkZ3d0MzVHc01YQ0VCVjQ2NW5ra3Uw?=
 =?utf-8?B?S20xbThnQ2RwRnBxNnFjZXRhM0hWd1NVU0ZyeFR4NzJLSWxiKzhqM2F5V1M5?=
 =?utf-8?B?eVRhNno4ZFlWbHFRRENYK05EUlBQSFBoVkpNYjNuelQzUWl6NndValQ5ODh6?=
 =?utf-8?B?Skhhck80R0hadVB3d2V5SUlKdzc5dUdGK2F6dy9pMGFtaFkzVi9kZ0U0aFNs?=
 =?utf-8?B?QmpJUFRrekF5WXZlVXJpb2ljRUV3dzg0SWxZU3V3blF5bkxWeTR5MXBDNXV2?=
 =?utf-8?B?VnVkS2ZGMHpTTGxRV0EzYmpjMURYaVFpZ1N1ZW9vNVdFdVlRRldjblFPUDdQ?=
 =?utf-8?B?MUNqdzBzQWRydUVMdVY5cGFQSFYzVVB0Wks5dHZDN0REU29GcUhYUDlBNmIr?=
 =?utf-8?B?bHEzclNNMlUxK1BaMHdRbkE3WmFCUmNuWVR3cGFDRDR3OERIUUNLZFdTcHly?=
 =?utf-8?B?Yk1OTW9wRFB2MEg2YThRZnd2RXpJUnE5Q3c2bENBOTlSMmdsWWw2ZUpHU3Nr?=
 =?utf-8?B?bmsxVXBuTm5BeDR0MldGQmRNTGMxcTdFZHFpNUVyZkwyOHdGbVcyK05SbWty?=
 =?utf-8?B?bmk0bEN1UllFNmgwbkhPWG4vOFR5Yjl0SlVIVFZyTThDdVlLZ0VaV0dkOGdX?=
 =?utf-8?B?empuZStoZnBGZFI5Y3Fwb0FLNzRsMnBKbnVTc2FwTjBUNHA5TTZheHV0VmZN?=
 =?utf-8?B?OC9uK3VydXhZSGhMU2dsK2ZiNlE5enU0WDF3N1BHWFBOdk5SeFRvVXRXa2Zo?=
 =?utf-8?B?ZkFEUmxiVk5xRXd1aXhRRmVlYnFta25MREVqN3QvdVRWU2RkcEFtaFh1VDFn?=
 =?utf-8?B?QUZSWFRPM1pRRENFc25NaEJWeERoTy8yVmxpVTNiNjFhUkZ0eFI4amM1THo4?=
 =?utf-8?B?TDRFbFZQbHhLZFo1ZDFod1dWSnJob3BoOCtrelpqK0R4Wnc0NUthVW1vc2Jk?=
 =?utf-8?B?dHM5ZGVwRnZVTmJZUzhsYnVKWTRkUTUwSUcyNkU4K0Q5LzY4S0RRN2tUZ3U1?=
 =?utf-8?B?M3htcUNSZlJVNjNuU1VibFMwZU5HeEgrUG14NUVmeENoZDZSWkp6aS9icE9F?=
 =?utf-8?B?dnFkenhuUDVNWG1JSTFhbnI3Qy9ZNDA2aWJONWMraUw2R0ltTXVHb2k4NCs2?=
 =?utf-8?B?VmtnVEZWcXdGMUV3Rnc4UjVpOEw5NnAyMDQvbGZKblZzTUU5ejNwV0orWHov?=
 =?utf-8?B?NUxYWFFwR3d3V3dPdlV3UWlEc3ZVdzFQRnVxUGQ2S2RLdXZDNUpqanFoeG15?=
 =?utf-8?B?M0hscGMybngvUFI3L1JORk42SFdJd3pjS09ua093NWNRbG13TjNnYmdocUVC?=
 =?utf-8?B?cGVUamxTVkxYUE8zaWJNK05URE0yeHZ2VGZHbWI0N2xRb1h4WnZVUlBqMWMz?=
 =?utf-8?B?WXE1d1R2ZSttSzBjbytSNlhkSzQ0RmVqdTYxWGFSWUVweTlJWUdUU0lTUm9n?=
 =?utf-8?B?ZDdaTEZqTjdCYmVDaGRybGovbzVpZ3pvZ1VHQXRuTk04UmFFeDlQQWk4U0ZV?=
 =?utf-8?B?ZVh1Mzl0UUhVdUN6MlAva01OeWRMZ1hiMXFWT1BrazFlbmN0WDY1aTJ6Q1k0?=
 =?utf-8?B?MVMzVTdLazBEWWVMQk1JT3dWSCtkVzhFbzZWZFo0TUhkeTU5QUF4d2RRT2Yz?=
 =?utf-8?B?eHdNZzZEMllLaUlQUkRod2RXeWdxVU5YVDg4WEw0Wlk5ZFlBS1N1RDVxWmRC?=
 =?utf-8?B?RExXZUQ3Z29oOUNNU1J6YU41dHBISXhiTVlxRGM2S0NtZEgzRHgraXhFREZo?=
 =?utf-8?B?b2w4RGtCTy9zV1k5cXFncUdVRmNkQTVkU3A5MEVLSDVubnByZytPMlo4cXl4?=
 =?utf-8?B?VTNwb01tcWg2cnNKYU9NVm5pblVWdFVkT3d2ampnTGIrVlA2YjJPRkQxWitr?=
 =?utf-8?B?eHdaZjlaYUpPWFU1eEpQVlVMYUtpaTZ5TVJ1elVMYkk0cEFXcStyb1hIMkpw?=
 =?utf-8?B?OE9wcjd6YUNsOHZlVTdaVTd2S1UzaTdCbHNLcEl5OHB0QmlxTGxMcHFqV3dq?=
 =?utf-8?B?MTVrMkNvQWt1Zmppbk43NExQZ05IRnNYZFZ1QnY5eHRlQTdhdW0vVlVXNGNW?=
 =?utf-8?B?WnZUNXNNMEkvbCtlVkthU3hRRXBWR2l1RXpUSVlRRm9md3ZyRk1CZlVYUVB1?=
 =?utf-8?B?enh4N1ZGWDl0ZEI1MkZhM2N2a1hMc0ZLVTN3clptRGZjVElwa1NTOW11MTZB?=
 =?utf-8?B?S0ZSSXNnbDRDdXZyejhHUmlhQzlmK0thWjNTciswdndVcngvKzJFQ1NHSEZU?=
 =?utf-8?B?cjZoVG9ITkV0dWQxNHZ6aVRPd2VoVktIVzhpcEN1UWpTSHk3cFR2UT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbc8a45-7c27-44e7-7ebd-08deab8daf8e
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:36:55.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc4Cay8HUiKfGAos+rkpyU3kAReua703uMKaJihWls+nqvRWKAVZv2gxuqQhE3BjUowHmi8PQ7Kigw4mfo07jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2483
X-Rspamd-Queue-Id: 35C394DE2FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244431-lists,stable=lfdr.de];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email,huawei.com:email,est.tech:email,est.tech:dkim,est.tech:mid,msgid.link:url]

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit e9acda52fd2ee0cdca332f996da7a95c5fd25294 ]

Fix a use-after-free which happens due to enslave failure after the new
slave has been added to the array. Since the new slave can be used for Tx
immediately, we can use it after it has been freed by the enslave error
cleanup path which frees the allocated slave memory. Slave update array is
supposed to be called last when further enslave failures are not expected.
Move it after xdp setup to avoid any problems.

It is very easy to reproduce the problem with a simple xdp_pass prog:
 ip l add bond1 type bond mode balance-xor
 ip l set bond1 up
 ip l set dev bond1 xdp object xdp_pass.o sec xdp_pass
 ip l add dumdum type dummy

Then run in parallel:
 while :; do ip l set dumdum master bond1 1>/dev/null 2>&1; done;
 mausezahn bond1 -a own -b rand -A rand -B 1.1.1.1 -c 0 -t tcp "dp=1-1023, flags=syn"

The crash happens almost immediately:
 [  605.602850] Oops: general protection fault, probably for non-canonical address 0xe0e6fc2460000137: 0000 [#1] SMP KASAN NOPTI
 [  605.602916] KASAN: maybe wild-memory-access in range [0x07380123000009b8-0x07380123000009bf]
 [  605.602946] CPU: 0 UID: 0 PID: 2445 Comm: mausezahn Kdump: loaded Tainted: G    B               6.19.0-rc6+ #21 PREEMPT(voluntary)
 [  605.602979] Tainted: [B]=BAD_PAGE
 [  605.602998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 [  605.603032] RIP: 0010:netdev_core_pick_tx+0xcd/0x210
 [  605.603063] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3e 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 49 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 25 01 00 00 49 8b 45 30 4c 89 e2 48 89 ee 48 89
 [  605.603111] RSP: 0018:ffff88817b9af348 EFLAGS: 00010213
 [  605.603145] RAX: dffffc0000000000 RBX: ffff88817d28b420 RCX: 0000000000000000
 [  605.603172] RDX: 00e7002460000137 RSI: 0000000000000008 RDI: 07380123000009be
 [  605.603199] RBP: ffff88817b541a00 R08: 0000000000000001 R09: fffffbfff3ed8c0c
 [  605.603226] R10: ffffffff9f6c6067 R11: 0000000000000001 R12: 0000000000000000
 [  605.603253] R13: 073801230000098e R14: ffff88817d28b448 R15: ffff88817b541a84
 [  605.603286] FS:  00007f6570ef67c0(0000) GS:ffff888221dfa000(0000) knlGS:0000000000000000
 [  605.603319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  605.603343] CR2: 00007f65712fae40 CR3: 000000011371b000 CR4: 0000000000350ef0
 [  605.603373] Call Trace:
 [  605.603392]  <TASK>
 [  605.603410]  __dev_queue_xmit+0x448/0x32a0
 [  605.603434]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603461]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603484]  ? __pfx___dev_queue_xmit+0x10/0x10
 [  605.603507]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603546]  ? _printk+0xcb/0x100
 [  605.603566]  ? __pfx__printk+0x10/0x10
 [  605.603589]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603627]  ? add_taint+0x5e/0x70
 [  605.603648]  ? add_taint+0x2a/0x70
 [  605.603670]  ? end_report.cold+0x51/0x75
 [  605.603693]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603731]  bond_start_xmit+0x623/0xc20 [bonding]

Backport commit:

 commit e0caeb24f538 ("net: bonding: update the slave array for broadcast mode")

The BOND_MODE_BROADCAST condition was removed. Because introduced by
supporting commit on the v6.17-rc1:

 commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")

Neither of which are present in this kernel version.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: Chen Zhen <chenzhen126@huawei.com>
Closes: https://lore.kernel.org/netdev/fae17c21-4940-5605-85b2-1d5e17342358@huawei.com/
CC: Jussi Maki <joamaki@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/20260123120659.571187-1-razor@blackwall.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Tested-by: Yunseong Kim <yunseong.kim@est.tech>
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
Reviewd-by: David Nyström <david.nystrom@est.tech>
---

Changes since v1 (https://lore.kernel.org/all/20260426201205.465809-1-yunseong.kim@est.tech/)

Changes in v2:
- Fixed wrong upstream sha1 and incorrect author assignment from v1.
  Updated to the correct author and full sha1 for the upstream commit.
- Documented the conflict resolution due to recently developed code
  not present in this kernel version.

 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5035cfa74f1a..0858116687b4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2349,9 +2349,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2385,6 +2382,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	if (bond_mode_can_use_xmit_hash(bond))
+		bond_update_slave_arr(bond, NULL);
+
 	bond_xdp_set_features(bond_dev);
 
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
-- 
2.53.0


