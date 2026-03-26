Return-Path: <stable+bounces-230470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCM+LQM+xWn/8AQAu9opvQ
	(envelope-from <stable+bounces-230470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:09:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D258336906
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1490430781A0
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B793246F8;
	Thu, 26 Mar 2026 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JoM6oOYt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948731D75E;
	Thu, 26 Mar 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533730; cv=fail; b=dh21BO8ErDT8Dh00j3s9Gxih9wYOcHLXzb5KnQw3cfqCK6Kssonv9TA2ByFKBV7Jh+8msrJ7aCF6jWFPR2+hM5yeGPj2ThYOSDUlGdcYVIl2tjDb3qDJTjXbuq18rNXEoueJ7pb3M4ovPHrCCFeXyft4LUWGk06raILcjjqjQtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533730; c=relaxed/simple;
	bh=pKiFLWjDeVkA1NA64LPm641PSQ7w8rAlPQH2P1IDiuI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nuhn8sMsDao4blvUpgWMr/YTK2KsLyqlGxEzV4Y4eozPg19GUJd5On6FARQo2LwsPWGlHKAP+NW5MtLEceQw4gpdlJPFGDSSWjga16DiLooaYs/nofKbFNxtrjIwLCTHu/nfKVh8TqcFO3Nuo4/X9kzHUwseMpwCcI7s+3s7SOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JoM6oOYt; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q5fXgK3033013;
	Thu, 26 Mar 2026 07:01:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=UCB/3x5Qv
	6cVfV22oNuALPxIPvCgkhYushj9uJVmXIU=; b=JoM6oOYtb2G5FdjHmrSENpAbE
	+FL78PFinUBN4mA3NzA7xJieLs0il1eqRKe1lREqrjkeZy4kFDqhO+xF07p8TIPA
	DNi1wGvNj3jk/dgRSNQ/B2NKbLYLAFM0f3+cX/b/UFyNFTGjwj1LKoKbuhd7XAy1
	QuNvbe5+fK/iH61R0n8V3TP6EakgorCSn8HfgIa7WZrb0j7bMVs7IdjdXSw5UJPP
	Qc0zPwxWUUxduAWIngSKeoOZxuU4l/r2AbJGVa9RzcZYqjPuamU8n44nCCDvLB2X
	/rG1O588wDJMHUsJGrkmZSKb1COvPn1KZPSP1+U73n2OWnA/4FVUEGlT3AHTg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pkyefvd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 07:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceh65IGuBQjvFyto+KYMF/bFsL04F6nYQelGmePbMnTineY3wyVB1NEKP1LOA67CTmbwaFk3r+2Qhl/zDZ8n/rRLlxKU+0HTmyVBpywFopm7lJdrxRBZY5jz3LDB1FcwzltXQ7GMbjMjnXIESQgE+gPV33F3ZaOOChKoV6f0ocIgeXzKTe9DmyupXXve3sMeE8Ll0JVYrxaNEgVQizQkWYX3sQpUpp20AE7r73faUb+9IgtlsDKPSsBHJO2LL9SFY8ULRPQQlvrCkczjfv7B0zj6DGPZ68jgtj/Qbl51Uq2bDFsbmqe7hbqTYC5eGEOBHm+CVbzKHWDSvXBEO7FNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCB/3x5Qv6cVfV22oNuALPxIPvCgkhYushj9uJVmXIU=;
 b=ICg+2O/fFZERpjG3BlahnKhjMUZFqXmDLnG+g1MXfsZ5LrF8nLRB3QZ+RrBAE98A6SJXo+ANYAqAQXDNS58jnXKDVzrcpyxMoYpDRIEcGn3+XYsVO+qe6/xmH1DHTpBqo0CT0/c2DPK7cWCxX3Qk4DoKeOyYWwE/TS3z/uVoOFFfu/lgGaWRYtB6atMJ0XcN5UQRd+fK4bu0ZsIpJOw+rMuqU22idhzQ7/J63+E5OAFccX3KJrPBeLTi2G7o93u/lsOV1CKD7Q0yj3v8KzHQ/vdl9Bi19lqeelkJJxvp/Yq813paWgoklbEqN1D2rr1/KgvWCAIBiSa9MSzWPWL0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SAWPR11MB9548.namprd11.prod.outlook.com (2603:10b6:806:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 14:01:20 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 14:01:20 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: namcao@linutronix.de, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org, vschneid@redhat.com, gregkh@linuxfoundation.org,
        chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
        iulian.mocanu@windriver.com
Subject: =?UTF-8?q?=5BREGRESSION=5D=20osnoise=3A=20=22eventpoll=3A=20Replace=20rwlock=20with=20spinlock=22=20causes=20=7E50=C2=B5s=20noise=20spikes=20on=20isolated=20PREEMPT=5FRT=20cores?=
Date: Thu, 26 Mar 2026 16:00:57 +0200
Message-ID: <20260326140058.272854-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::28) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SAWPR11MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: e250a097-a5d2-46fb-7cea-08de8b402865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CCBeVv9LZBn30NDixLAkkqzKia3DYmFikxjqE9815FtiJNBvRvtzJyyhcU0u7WalDCv1LCEce/l/u24DvRA4C9w3gK1/KgqNXSLgaXBigoXLIqyxjsK1d0PknU2uuYx+17bDpf5jb6VV8O7JwFZvTQGSMsj5F8Yo76JPux3uPqbQPmeby6qQs304uO0kYtW8sGk2gXWYwOngqghplATnsnLPyvLSKdAfJTFMlUz3KX6h3fUjExJLAnij4SvqnAalZTwTklgd6GQx+CWzzO4c7hYXrCrnQqPGCFtBxKYUzaUD/ufDtRi/MXICwy4KEiFZTMBqDaFCaCRhgzmrrGLKk4tI4wkYP0MuMhMk4xwsLrdaHUeAsnvPNeM/3dQv4yM+v/RPjGLWtda1Iqk48zyjYFwW630YmepoNgfyU6KRktM39W+7EPZlbLuFpQTV39+mLgngVAGfbD1GaYLbpPqkgmw3YLCJxvt9klvTPo71sTZ9j38zzeEZZPLmclKImBTGsnsOjBP6O3pD0v5b9kdJQZ4+US7QJESnVzlpeFPJcUG0X4tg4hZ1CAFYDBQS2acVxld6C5Ffdqw738rHe7avpHRLC2Q10FZv4boT7gR3VW9QThGx36VrBymFII8gKc8L0wYv2bv1IWjoNk2MFhUr7saY5RMrJSVmuMYVwlzbabbv9yN0m53omsXw8iMwTvvwKQr7QCVZ3W0LfhENVodxsByDpGHN4CL1koieSrkwmtL+w0I/nWWQcT5a10bu7Hvv04k1kNXrxOXDw/hYkftfE6Oz5BX8E6RGjbF7v0m1od0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a29EUmR5MU80bDl1UnVoSDErWEUrM0RUOXNZMkd0bUloUTFFU2ZkVmpIb2VU?=
 =?utf-8?B?OXo3Z1RqblhETER4Z0EyWTlhVklMR0duQWlOd28ydFFsdUVtYm5GM09TZWlh?=
 =?utf-8?B?bzNvTkwxUjQ2dGFscGlzTDdRYnE5Q0RyK0FoYkZiRytFb096MllHcEdyN0lU?=
 =?utf-8?B?OS9UVUFZVE5tZDRnbzE2a2ZpK1RKWEZ3d2lTcHZtSWtjRVVIODBZV05EWEpH?=
 =?utf-8?B?am8wL1RLRFBlQ1RjMWlSYzVzQWZOYS9iQnZaU3ZrejV2OXY3NnZGV2I2bmo1?=
 =?utf-8?B?M29zMC9rY1RjMk5qOVViMDZnRVJzand4S2pRNUdNLzU2TEVQbURLSjg4SHVT?=
 =?utf-8?B?Y1lkWHREeWt0NjRzeC9TdjVJT3RTMWcxcm1RWGdPZmJOUTlGSXlCazFraVhM?=
 =?utf-8?B?bUpTM3hZekI4VzNxWVUrNnZPME1RSGtvVk5QREJlUWxudnVPQjRYRW13SEVS?=
 =?utf-8?B?MDBZeURMa1BOdURNR3lHMTVWWVBLRWxFb1FjZ2gxbFgreng5bWdwYnFtblJS?=
 =?utf-8?B?WU1qV1dwU2Y4TTU1dFdjY29PZUkzbDhhbDVCZnNMMUo0dWdiRWM0Q0pRTmlN?=
 =?utf-8?B?TnF0djZKamJOR083Z3pVZVJoVDdlMGV5M1B3Rmw0bm5BQ0k5WVFkYXdoTmk1?=
 =?utf-8?B?WlgvcG5FODJxQy8wNndwdFMzTEN3WW84bnl5RXhvQWxEYXVkR0pFWkduQWc4?=
 =?utf-8?B?UzIyc2JIRmQzSm96c1R2UmlNYmpTN2xJeEliaUVMcmJUTytMMkd0U0FIRXZa?=
 =?utf-8?B?TUh1bGRRRGlIY05vaC9jVHc5WWxhN3BXWEExbWhBbTRhT09Wa3UvMXZCS1hv?=
 =?utf-8?B?VUpUbFRiOVFpc2NETzF4SWxCck5DcTdJMVpTZUIvb2tiWmM1Qis5S1JoTThp?=
 =?utf-8?B?Z3pRODFwN25BQzZXK3p6L3pseFBycnJJUFpXQ3VjWkcvNGVTN0dJTFArTUNm?=
 =?utf-8?B?NUhGYWtqMCs3ejNOaW54cHpJQ0xjZ1NPSmhnMkhJV2tIclBnWCtSeUdkMW5L?=
 =?utf-8?B?emFPSms0TlRnejZkR2IrNkNuZkQ5OHMwTnQvVXhYUFJadjZVMFBDRUI0dUFj?=
 =?utf-8?B?Zzc1OUJDa0FINzhVVmlNSDlBUkJOQjJQM2lHM29IMGphWkJzOTFzV1NpbHNw?=
 =?utf-8?B?YTdCMDhicVNJdTBTSXpKclZPQktBMXVXckZNYzFVTXlGdjZYQlo1cTJPbDd2?=
 =?utf-8?B?aWIvK0xXNmNSdTVyTGpYSnk3Tm1RVFR6b3k3aE1POWVvWjNxRWczcG1SSXUr?=
 =?utf-8?B?bjZvWm5HMUlicHJUS1Z1NFZLS1E5Q01Iczh6LzRIL1J1OTllMmRKVlUxL05w?=
 =?utf-8?B?b1VqTlpCZFFoVnNpUWd3bElaQWw0NUtIMVFaTTZVTEM1QWx1V1NWbUVybGhK?=
 =?utf-8?B?NGd2ajBaY3huYUsvbmRJRG5aci92SkxKbXZKZGVERjgyOE5vM3JvckFMQkF5?=
 =?utf-8?B?cjZkZVI2OUt5VitvOFVXYjJqVmJocjc0Um5iTTFrYVhaV1R5UVVjbjRwc1lI?=
 =?utf-8?B?ejRUcUxEOENZdGhmaGxsYVdHSFFOdVFDTTFPK3E5Nmp3Z2VMZ1hzSUNIYk5U?=
 =?utf-8?B?SXVlcGViWEFPUTRMcmJQRmo0VTN2bEV4UDlXY0pIMzNVWU5jN291UXVQSlkv?=
 =?utf-8?B?bExpdmpHNWJXU3dyTlQ2dVVlRDdFa29lanQ1aWVSbWZPZnV4YWZmUlZYRVJW?=
 =?utf-8?B?QVFoZlk2aGV0SWxGK3Bxai9ZTlB2eXgxdEZDUkd5K3pCRy9xVDdXZHpIU3Rl?=
 =?utf-8?B?NzBqZWhvQU5ZbzJjMHV3Zk55OFVvR3c5eXBPQ0RxNjZ3VE1MNjJLV1hmMUJq?=
 =?utf-8?B?dVYrSlFxOEszdzQvMWF4OVZLNGxCeGZoS1ZFMitrTndnZzE3NmxYTWdLdGpx?=
 =?utf-8?B?bE9nU2NVN3gxQWlkY2tqNTRZK1JOVWlMK242QnhRSGV2UnhwSnFJYU1TblFt?=
 =?utf-8?B?MitncnRUV2lUMStLaHh5TFIrRkNkeVAwbXhJYkt2UlNyTWVRN2llVFhSdEtm?=
 =?utf-8?B?YkdSMDFXRGppY0krS1BRVnJyREo3VFAzMlpBT2FMdGpSV1drMUNLZGRLcHU4?=
 =?utf-8?B?V1NmemhqUVlGWnY5M1ZFWkdZZEF0cnd1TUszNTk3WVJMM3M0Z0x6MTZRWmFl?=
 =?utf-8?B?WWl0bHlsQWxIV2VuTDFpZW9zREhpWkxxMHVidnBNNUNaU1A2ODZJKy8vODZB?=
 =?utf-8?B?MlpDb1F3RkxDZkViRm4rMHk5cDdLK08zejFMMlQzRFh6THA5a3lFODViUXkr?=
 =?utf-8?B?WUZOMHNVOVFTR0pObFlWSTVBQnJiOTQwM2lkRldYYzQ3c0FUdXBlVFZEMXF6?=
 =?utf-8?B?MTBGWkVQSzhRTHh1S3ArbWlYMlA1SzFNbGlMdlRMV295ZFdqUGxycy9MTHA1?=
 =?utf-8?Q?4k/dmx401Itqvxyg=3D?=
X-Exchange-RoutingPolicyChecked:
	vYdQikNP1YPDg5q+RWySEnYTN2FajC07unU/tOTnPpYCN2PkrpJQDSVX4WXkWFJ5cff1tTv6M/5Ze/HJ5rhqZEnyVqex8bdTK5CIJcG7GtE2tkElDNPw0cBPT47Z0JEP4UO3NFkumcuBSSNXREPXNKp6A9ZbjgLTfnma13Bjn0vftJD1ifLFI0I+i8pbJNId5Lf+6y7L23tHXRT9ZjW67/E2OMymBdaBpizstDif6b5YZ51KHQ/lrl4xnc05cbiqKIdqEq6a6PP/MtW/UG4T/0tFp0VcVHqhBAzFpxjgnclbUvQFXAESbmNWlwgCDd3coLkMrqeM0b1Zwz9lscPdAA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e250a097-a5d2-46fb-7cea-08de8b402865
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:01:20.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNPAzkU9hJTIeDNo+FFH+cQCfH4z99oD3ZUZYG1cjqCfKxiYaUqGk0IHBnfmlg/8KugVBhGxLs3Ip4IHReL/w7th34dZxme3xJKbUufU1cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9548
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5OSBTYWx0ZWRfX/Bs8GMv0nLqu
 2mZK6HDfmx4TIruwDxUXUs20lenSs8NiKniZpPQDamlYG1EgT06l+hcAEUOIWEnue8sm81wJ2ri
 vNz2F2DEP1pLFvRBBFDkHbvbyjRwcVbN8Fh55lEAg2MlaZggcflMpu1NC5pi99f0NNzahyrja41
 Dfd3ggGoxL6ReZqTS1SDm3FmGmIK4qtV9gS34XPwrcfONgKOeB/m2ghiV7SDf21VtfQRSRYJnuD
 bm+aWY25Qg99/LKbTHpyxLKfZX3Ta+hI+DbnKg+DdYNzQUYQnb5zo3W9faFeusELVAzvCF+KcHy
 +8vlxn1+O/byBxODX3ryBIdtsco1PvkUKl6gscKIttAmzSIL1EnJw6Fb6VmvsdUntzeiDwnYs9G
 Bds3+pXJdZuCOLr2YvNYaDjEsSHJIe7d2BZ4ao2tZUs2O+12ZRIWHtsLKoEpYW29ulLLPtqR5vI
 8pwzdxdTuWvp3laadeQ==
X-Proofpoint-ORIG-GUID: BpFHIJo4X1RKYwnh5Z6WsgAMJ0D8LehO
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69c53c34 cx=c_pps
 a=PWz2vMGk566g1z9MD32Dlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=Cd9e4CpS2Di8jUyXZQoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BpFHIJo4X1RKYwnh5Z6WsgAMJ0D8LehO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260099
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230470-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D258336906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm reporting a regression introduced by commit 0c43094f8cc9
("eventpoll: Replace rwlock with spinlock"), backported to stable 6.12.y.

On a PREEMPT_RT system with nohz_full isolated cores, this commit causes
significant osnoise degradation on the isolated CPUs.

Setup:
  - Kernel: 6.12.78 with PREEMPT_RT
  - Hardware: x86_64, dual-socket (CPUs 0-63)
  - Boot params: nohz_full=1-16,33-48 isolcpus=nohz,domain,managed_irq,1-16,33-48
    rcu_nocbs=1-31,33-63 kthread_cpus=0,32 irqaffinity=17-31,49-63
  - Tool: osnoise tracer (./osnoise -c 1-16,33-48)

With commit applied (spinlock, kernel 6.12.78-vanilla-0):

  CPU    RUNTIME   MAX_NOISE   AVAIL%      NOISE  NMI   IRQ   SIRQ  Thread
  [001]   950000       50163   94.719%        14    0   6864     0    5922
  [004]   950000       50294   94.705%        14    0   6864     0    5920
  [007]   950000       49782   94.759%        14    0   6864     1    5921
  [033]   950000       49528   94.786%        15    0   6864     2    5922
  [016]   950000       48551   94.889%        20    0   6863    19    5942
  [008]   950000       44343   95.332%        14    0   6864     0    5925

With commit reverted (rwlock restored, kernel 6.12.78-vanilla-1):

  CPU    RUNTIME   MAX_NOISE   AVAIL%      NOISE  NMI   IRQ   SIRQ  Thread
  [001]   950000           0   100.000%       0    0      6     0       0
  [004]   950000           0   100.000%       0    0      4     0       0
  [007]   950000           0   100.000%       0    0      4     0       0
  [033]   950000           0   100.000%       0    0      4     0       0
  [016]   950000           0   100.000%       0    0      5     0       0
  [008]   950000           7    99.999%       7    0      5     0       0

Summary across all isolated cores (32 CPUs):

                          With spinlock       With rwlock (reverted)
  MAX noise (ns):         44,343 - 51,869     0 - 10
  IRQ count/sample:       ~6,650 - 6,870      3 - 7
  Thread noise/sample:    ~5,700 - 5,940      0 - 1
  CPU availability:       94.5% - 95.3%       ~100%

The regression is roughly 3 orders of magnitude in noise on isolated
cores. The test was run over many consecutive samples and the pattern
is consistent: with the spinlock, every isolated core sees thousands
of IRQs and ~50µs of noise per 950ms sample window. With the rwlock,
the cores are essentially silent.

Note that CPU 016 occasionally shows SIRQ noise (softirq) with both
kernels, which is a separate known issue with the tick on the first
nohz_full CPU. The eventpoll regression is the dominant noise source.

My understanding of the root cause: the original rwlock allowed
ep_poll_callback() (producer side, running from IRQ context on any CPU)
to use read_lock, which does not cause cross-CPU contention on isolated
cores when no local epoll activity exists. With the spinlock conversion,
on PREEMPT_RT spinlock_t becomes an rt_mutex. This means that even if
the isolated core is not involved in any epoll activity, the lock's
cacheline bouncing and potential PI-boosted wakeups from housekeeping
CPUs can inject noise into the isolated cores via IPI or cache
invalidation traffic.

The commit message acknowledges the throughput regression but argues
real workloads won't notice. However, for RT/latency-sensitive
deployments with CPU isolation, the impact is severe and measurable
even with zero local epoll usage.

I believe this needs either:
  a) A revert of the backport for stable RT trees, or
  b) A fix that avoids the spinlock contention path for isolated CPUs

I can provide the full osnoise trace data if needed.

Tested on:
  Linux system-0 6.12.78-vanilla-{0,1} SMP PREEMPT_RT x86_64
  Linux system-0 6.12.57-vanilla-{0,1} SMP PREEMPT_RT x86_64

Thanks,
Ionut.

