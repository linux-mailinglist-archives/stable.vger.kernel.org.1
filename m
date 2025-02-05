Return-Path: <stable+bounces-113972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70737A29BF9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EDE3A79CE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19A215062;
	Wed,  5 Feb 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdVZIJ1F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZihfvIAm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780E215061;
	Wed,  5 Feb 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791648; cv=fail; b=Keu85SOLmaSOax2SD1YWTH0ba2XW/clhw/CaqUQeuM96IvwntU1a/P5RGcXLF4mAhncUJ8ss9MAE7x1UvbTKHqT6NP4hXJtbAa0TmCh+mBtJy4+1pEKOzvO5z5Of2XIcqWhvDcjVpkIBeAMc/NgQku0lPbJ2dvfAGo/HnAFqsAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791648; c=relaxed/simple;
	bh=vpTcJQgw+pAdfQYFWfT6pP6Y7pozjxh02ztbpHFw1lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dusMHMUhEJHjwzUivBn/wL8+Lm0CV44V3J+jdhYk+69vYhb3usYzzbPXyuoDO/7FoOmRgOyJ1uoJwn4Dd1qiSwd5FmHAgXtZxa1YQkIs7QYQEhibSNZYlnZ6Vxaf27m2PxigH/Qho9T2DSgnJb2SREpm1wteaJHragVfTV+kjo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RdVZIJ1F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZihfvIAm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfpqN015234;
	Wed, 5 Feb 2025 21:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P78CBG7r5pP8KQMa0tAdoxP68g1sOQsrCBqWM0z1hTQ=; b=
	RdVZIJ1FD3LLAT2E0OGvEHm7kqr8Rk9mi9acMbOrjp39UD6qr08T8Yk4ll8txu83
	DXWDV+cD/L7Q2eIA3DSG2TPghjHwjProIgw3M6UIO1JcaXl/MmK8u2cokFg7oKam
	NqBTVBgwrjAazoT1oamXN/G8E3UUjWn4DbK+VqtWyEXltJwIBAldvPRirLjD5/+d
	Xc4uCryq+SjgH5AhW0QyAdaYak/fmqJ/ldW6ejvof+71tJ36Cz6Aaew5BJpkq92B
	LxVmKnQ0eA79G/6bpRT7qAK1Zd/7xsv9k+iYCaQD57+aBGrXRzu3/08wAGi40sM1
	1gVf2T+q6tYwwSi1xLAVvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u9eyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jtrs6026923;
	Wed, 5 Feb 2025 21:40:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5a6v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHc3wMVOkDv4EwJeLrNe0cx06HL0RM2hwct0oZXtAZ5utPmRL9vdhSpehDT21NAx88xhGLdY6w8haZM20f9eGN9nab6BGvpoJ4Bm0EUh85AoQsBkQ5p7WmAfh+HIfgrXUCVGrKg8fFD6ajx4kD5/1hUeyWIbaCiWYRxngBr9g0WXhz2qyUZyxa6nuNXrEpu3qULxTR+fOeEENgfuoAgsZKoQwgLSUEjBmSMp6H2m5TdZBy216mTMSH4V0XKfj6an7ppheG0unhiN1nsjEZ0zb1uUwa1FdX+zH3XgqM04cWjPwzMsQlXPatYztfoqN5b/d1xDznJry73JBThrxR0Pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P78CBG7r5pP8KQMa0tAdoxP68g1sOQsrCBqWM0z1hTQ=;
 b=fepnxWOYPKxuSIOgcaHGlrfNbRiHFeKvbdPRnx//jBKfrL2exgpiOVeng+oih4I2jWJn9bAM76V/tQtaX/OOuZs4rHjwVMlJxQTWirIUfusOP7cHk8C17eOjwnXxXIyllX4j5Bzw9Kf87YhUCEfAQE7I67pFUg8hovj/acgQTASKN0vmypgbkmq9lgp6qjuwCX4Mz2aWJo7Vo5NN1tNsXSSlWXFOjYdhgH7n1FJELU7IsebWa0eFOnEbtHP+2BHYPXCltra4A4FHDmQ4k3IQ1hwJ5Ajr4B6q04dp01smFouoYvfaRO+oWwtIDGp+HxM+iey1PEGy6OHT8IDdxpNXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P78CBG7r5pP8KQMa0tAdoxP68g1sOQsrCBqWM0z1hTQ=;
 b=ZihfvIAm0FuxdPlnFH+YyDnRLGk4bs4NXd1uWzXKwaWceEEMAowLN+IHGT4/unRmbtQgk6dtrJqzFfCWEZHFCTTOnCWzsRDkB4obxT5gdqmWmZ5gg/xfQYY2huE9h247andO+Ls22HibqKwTftxbaLAREJUEpuBgZVjWx4dsqjM=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:41 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:41 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 06/24] xfs: don't free cowblocks from under dirty pagecache on unshare
Date: Wed,  5 Feb 2025 13:40:07 -0800
Message-Id: <20250205214025.72516-7-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bb1097-0db5-4c3c-ed95-08dd462dbcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0u6JcRAqjU+A2GLrY7TEtCs0WDMx1AVYa/R4zebAvS6vPHmy57yEi24NGJn?=
 =?us-ascii?Q?HKBNMoX0vEPE0ow2TTBvixgIby0PHeoUp8Pa74KJA7bqikya361HIztR7s+Z?=
 =?us-ascii?Q?ixLRWQK/DbOZAD7xV+YC0mwZvvbqLolizdNDpDoCmZG8SrokzDINBjh4b43k?=
 =?us-ascii?Q?dQ4wFBIa/nZYbaD2yCSd5UPTLJ/z97ZAxo8ZoI2PvsC1zyrK8EHsZgwkjP3n?=
 =?us-ascii?Q?tOXplDG8SLYYSSTg8Zo51PJiHkXkjz0GxryDYLZJF4iZSKh35sqGoUv+WDzx?=
 =?us-ascii?Q?OPmQWV1n83+GXbGtnOzDuWKDX2vZiDV2EIq0jwyFuir2fXism2ZlREyTtljE?=
 =?us-ascii?Q?kHJbczPlcZ7a4dIircyfoI1E9bFBA3sSvIoVVKZq59l/47GRaiL52bvhhsPO?=
 =?us-ascii?Q?0go/qccFB2jDIqmFlqF4MG2llX3PwBn2epTWeUTw8SsOHFkMiSOV0wevd0dn?=
 =?us-ascii?Q?yz4xd0MdW5lP+ozpXjTZjQzfInzcdxSiQZbB3kT4PyH9iFyhrBcP0Smy3zNE?=
 =?us-ascii?Q?jMLoGlSdINSfMj/KJW2FTWHJibzvd5PBJJfEW/vT2FIZfsOxH7vR8nsEfqJN?=
 =?us-ascii?Q?FnKxngD+NsHx5elHedYwbAS8D8xFMNj8+XRZ7OQMKi69x2cPeVbrFZGn5sEM?=
 =?us-ascii?Q?eedMAk5EDdmwG/asAF2PncotVDCevfeyHsJq1OmrTqufTuKmzK00wCPNYbgg?=
 =?us-ascii?Q?tRJOIqp/viwheyHCIAdlVgZTIeIUIKlpRGj/jhlcC0oVrFkOF8MCIeI491ub?=
 =?us-ascii?Q?OB9e/5Ny1bN1E29EtAwuNLqSRU4n0Em3otzzS318h7KNiHd18zj9jT766A6d?=
 =?us-ascii?Q?lInrmvALmflWrDoPWZX030lQmqPB5jX2rxKw7txi+YTb7UsRi0GKUJb3+KCv?=
 =?us-ascii?Q?iVI/e7KrxK6xlAD+ANRvGm5EtIC1/Swa79IFbGOtfYC/lDN0ojItNp+37QvV?=
 =?us-ascii?Q?W8G2xgAXl8Kc+x/Y3PDRoQYO7+nfCWwAWF7y8uicczb67OJb35Mvq4CfF89L?=
 =?us-ascii?Q?Z2FW6MSCq8jzGxu4oXjh6zVpshjPwl8tFXORcEl6IdGqV37lXV9npSUEhaA9?=
 =?us-ascii?Q?bKMhuANqGICp0Ie/b7zfDhW9iLXyFBmUQmYaxtLMM/eTc3LsPBfQBd3hdCxO?=
 =?us-ascii?Q?DA5R1R+4o91hnpkiv8z70D5fgLyP9DofzPgoTTEa5+x6RmWfME106FEx9Yw8?=
 =?us-ascii?Q?rlYqS0QNuNwPQ5jAq3IVZR9DLnbTgZMjM+FmuuANE4y2AZ4mKFnZO1c6SbLG?=
 =?us-ascii?Q?Q96lyG/tRX1BtamUlojNbVMoIZzbWQzbXvzJyyAcIFkqLFeVeAB1g1aRoWU5?=
 =?us-ascii?Q?nSLWswk/Lsm4ZHJgPlQb1fzXTjfyhzbTqfqPk+79p94C9NrJvNI1NHshhqsU?=
 =?us-ascii?Q?e+KzSC39/tBhfDKBA/xB9/PQ0age?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zbr9OgmPtjyqIQV/t78sbAc9NAON2YRJ3XafGQrhHWXudllKlhXQGnaVRGhI?=
 =?us-ascii?Q?U/oA1swvpvbZuW98LcTSPjjsTUGojvfs7siN+KjdaVxksQORfG2aVl1VDAZ9?=
 =?us-ascii?Q?jxAIGsJscinznbyuJoP9pShfo1D34zkOJP44UlznX+ixYSw8S1zexs5vz7Ee?=
 =?us-ascii?Q?P5XwBn4cfwtUStefsPciL+wg0ZSR+tuDtARQzirbOO+d4ZGc1DGN+Qvtn6tG?=
 =?us-ascii?Q?F+wRGbUoRBtUHoFb8J4p6GgHvpMK9GL0GtiWIOUNQ02AfzEh0HrAEHKTRBaF?=
 =?us-ascii?Q?zryWdiHzQ1Y/Q+QWzqUjYC3G40DpKMWCAvNyIr3hQ67W06ElaRdPvD71EENh?=
 =?us-ascii?Q?OIBwKlHnONhk4a2dqRL7uzzkOV1PISeL107vRCLnL+o2d8vjpPJmKH7C0sw4?=
 =?us-ascii?Q?SyuMBP+JutcNjxMp8tTajBomWTREv18YyRdqVogFKPZt/e9dL1OkvixhLLd8?=
 =?us-ascii?Q?L8bB9OWcvAaobQleSrKpsQ/Htr3mJ1DanKphyTp6iCKZ1Lyxl+dUZLavhUVD?=
 =?us-ascii?Q?77Z/tUB2OPa0yQ/0K7xIKcZV1GtMbjtgDcFz5RSmTHaNlQSK/SSQN2ON5jny?=
 =?us-ascii?Q?6TwxiAZJSpQ2sCLxKdJ6K1Rybaddy6E7OLXkqSuPMlO89yQ/euL5xtn4asc6?=
 =?us-ascii?Q?B4NBiGhR8sd3HdenndQmhsIijf3jWx7ijvtFcUEkDr5fNjlsAlLlHNczYkPs?=
 =?us-ascii?Q?D7GWYwon0LmoBGbufneYAXAzGAkobZ0nQ/WahO20FA5xf+DuCClrewH5FCbn?=
 =?us-ascii?Q?k0Aaq0DHMoF97xkonnQSrD4G9VmeC5x1gI19EoQ7PDfvGPBzVM1b348NZcKG?=
 =?us-ascii?Q?zIl3iXFzjo5x65AvUY2MkOTfOiFVHDA34qoDA7Hr9FC7lu2rpHVjtdd8ILT0?=
 =?us-ascii?Q?t0TrkXCE4LrlHCNwyekH8TyXRZ33P0uX923HQGTz3gNn3FV4QMC7CkNiDVJt?=
 =?us-ascii?Q?MVnONhK4P0Q5w5E2FSD+skKKtLZNDtyIUQD/UyHJxPG5chLfpl4A/0TcrlPE?=
 =?us-ascii?Q?zCSx8R+bgPEMWWBTNPq2cLK80se2d3lU7vGSMu4X8slrxQm9RRstwAydn5OA?=
 =?us-ascii?Q?1AGUOa4aKvZJAdHx83vij9rcj9bSUCaYSGQS3ulu+lxN3n4tkyC250/5O684?=
 =?us-ascii?Q?r7OoY574pkxgXG9XZ40HdvIhDLPK5GOlVBUaEDjfszy2tnJ8cMzOQauHX/NQ?=
 =?us-ascii?Q?EAI9vjRGXcaS3f2bGmbUVaWxghl2bCnWkeEXDMKTmF69gkVMrHyYzzGbr7vZ?=
 =?us-ascii?Q?T9HOvJ8BCQ3JSzWy9Zw+CYmoRHqsHjRrh3VbuYFRd2SPvwPwIEzoZh1aRYID?=
 =?us-ascii?Q?tJth/cd0tND6rCfo17sw9qBfTgGI64G7crVY532XVbCbOMw0T8HkW1e9F8Ut?=
 =?us-ascii?Q?OdeH7eHe3/m9GyPf/26FTHTzY+W4oPjaUGuBFppYcKq6lpVORnDUuVylbTth?=
 =?us-ascii?Q?geqf5SYqbr2qFRi1L9aPZXQ4DYQa+aJqYUrb7Hia5vp8pu97AlvJOz+toUa8?=
 =?us-ascii?Q?sWDUKUvNZejTXBcxs1hiC/DWS7rT8MwdlvAzRazkZ7oxolcBSnhS6Z8VDwQI?=
 =?us-ascii?Q?itMhuz6gLnMmq2NpY6yk2vId+WHY7eLSAZNG+d0tjhI3YeFmow45Dib0cNF9?=
 =?us-ascii?Q?uQvVB8nGjN+ixh7xNxeYQvxb8R9E5l4pIy151lrOKBBWsF3acm6EQI1ypn34?=
 =?us-ascii?Q?AkvV+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bbttEDTG9BPBlyqgXhxthJc/ZbwTqdc9bpChseKqgoNGTzQOBqXf9cT1hxFqxOStdkOcH3J26aK5QTn4779J2PmuZiETU/gj7bGeb1PpchoxPTqlFzMJxTiqW+htX0S6aThKP43RtDxJFVjwHU3vF06zP/xCtJEAInD7ro7p36/hntVywUU3vDjMS11oXYJddassAVvOpH2MPc4DJNuMdGc9US9MIHyXFEG1+etEUXjdxEZWeAgki36rwDSO9v5TvNjMbfTcSkqNBpewc9XK27lo8G+gY7IqpsIrnyQZjV0TwJwa6ivP+oUU/m2YRjiwR9tlMyc/8PqWEc+XYdj53uXOlDy1NuW9RqS8FJGMYwRTGzC4uYKA56vGcp8keH8yCS2hC2PYW7bxHeU+lRUIPyeJncY+or4OJYh0hNh8xt7K15Gt6sHHh9NdVzOCct+jBKrbR2Ao6vwKfMaKMSKyMai2qNTXvQa2pY0LYHXUVkOH5LP6oUNHxn6F6oxORlJrNtBiW9zmVkxJ6zO1sr1KbEvwRg9hCSYdnqfFjkAEG3WHCKKHvk7z0CivYC83Xbvq3uQGbqhKfyJgkA/jsIDaNIWrwPU4fguV9UudUgWwx3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb1097-0db5-4c3c-ed95-08dd462dbcd7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:41.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7Nb7a6W9mM2YTJ7CLgx1rFNaciDGZAu0hLDpJDYAdXelVKzV88ojKS8gjrreqgaZGHHVBsBmHFzrzgzVqopDdHMX7nfrIBKNN1zXaEnixY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: x0fl0ktEY7h-6-utH0TMW1eVILJqxMWX
X-Proofpoint-ORIG-GUID: x0fl0ktEY7h-6-utH0TMW1eVILJqxMWX

From: Brian Foster <bfoster@redhat.com>

commit 4390f019ad7866c3791c3d768d2ff185d89e8ebe upstream.

fallocate unshare mode explicitly breaks extent sharing. When a
command completes, it checks the data fork for any remaining shared
extents to determine whether the reflink inode flag and COW fork
preallocation can be removed. This logic doesn't consider in-core
pagecache and I/O state, however, which means we can unsafely remove
COW fork blocks that are still needed under certain conditions.

For example, consider the following command sequence:

xfs_io -fc "pwrite 0 1k" -c "reflink <file> 0 256k 1k" \
	-c "pwrite 0 32k" -c "funshare 0 1k" <file>

This allocates a data block at offset 0, shares it, and then
overwrites it with a larger buffered write. The overwrite triggers
COW fork preallocation, 32 blocks by default, which maps the entire
32k write to delalloc in the COW fork. All but the shared block at
offset 0 remains hole mapped in the data fork. The unshare command
redirties and flushes the folio at offset 0, removing the only
shared extent from the inode. Since the inode no longer maps shared
extents, unshare purges the COW fork before the remaining 28k may
have written back.

This leaves dirty pagecache backed by holes, which writeback quietly
skips, thus leaving clean, non-zeroed pagecache over holes in the
file. To verify, fiemap shows holes in the first 32k of the file and
reads return different data across a remount:

$ xfs_io -c "fiemap -v" <file>
<file>:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   ...
   1: [8..511]:        hole               504
   ...
$ xfs_io -c "pread -v 4k 8" <file>
00001000:  cd cd cd cd cd cd cd cd  ........
$ umount <mnt>; mount <dev> <mnt>
$ xfs_io -c "pread -v 4k 8" <file>
00001000:  00 00 00 00 00 00 00 00  ........

To avoid this problem, make unshare follow the same rules used for
background cowblock scanning and never purge the COW fork for inodes
with dirty pagecache or in-flight I/O.

Fixes: 46afb0628b86347 ("xfs: only flush the unshared range in xfs_reflink_unshare")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c  |  8 +-------
 fs/xfs/xfs_reflink.c |  3 +++
 fs/xfs/xfs_reflink.h | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 63304154006d..c54a7c60e063 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1271,13 +1271,7 @@ xfs_prep_free_cowblocks(
 	 */
 	if (!sync && inode_is_open_for_write(VFS_I(ip)))
 		return false;
-	if ((VFS_I(ip)->i_state & I_DIRTY_PAGES) ||
-	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_DIRTY) ||
-	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
-	    atomic_read(&VFS_I(ip)->i_dio_count))
-		return false;
-
-	return true;
+	return xfs_can_free_cowblocks(ip);
 }
 
 /*
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 3431d0d8b6f3..4058cf361d21 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1600,6 +1600,9 @@ xfs_reflink_clear_inode_flag(
 
 	ASSERT(xfs_is_reflink_inode(ip));
 
+	if (!xfs_can_free_cowblocks(ip))
+		return 0;
+
 	error = xfs_reflink_inode_has_shared_extents(*tpp, ip, &needs_flag);
 	if (error || needs_flag)
 		return error;
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 65c5dfe17ecf..67a335b247b1 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -16,6 +16,25 @@ static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
 	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
 }
 
+/*
+ * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
+ * to do so when an inode has dirty cache or I/O in-flight, even if no shared
+ * extents exist in the data fork, because outstanding I/O may target blocks
+ * that were speculatively allocated to the COW fork.
+ */
+static inline bool
+xfs_can_free_cowblocks(struct xfs_inode *ip)
+{
+	struct inode *inode = VFS_I(ip);
+
+	if ((inode->i_state & I_DIRTY_PAGES) ||
+	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
+	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
+	    atomic_read(&inode->i_dio_count))
+		return false;
+	return true;
+}
+
 extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 		struct xfs_bmbt_irec *irec, bool *shared);
 int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
-- 
2.39.3


