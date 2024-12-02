Return-Path: <stable+bounces-95989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E79DFFD3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF5A1625BD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16E1FDE36;
	Mon,  2 Dec 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gGlM1jNB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QqE5IB6E"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DE1FDE21;
	Mon,  2 Dec 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137859; cv=fail; b=hxcNQfl/IWaY+X0Ff2A7Z2hWqezqmEYoht+1eNiX7fzT5aoazUgGyckyK0Gp5HQifKyQANvWz3w0oEosUn5rfingGlYDgE3ysveoJhsY/oiDBftE/SmdFQZNjMV0RALP8BrdsIgAhYp8UPky7s3lH7/eiuAlyjhkcSZnIKBUJSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137859; c=relaxed/simple;
	bh=uwPLuOU4ILWYTOCPCY1cX9toyYDvZYy+qhBncDKYvXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEYf/CVfYCrmxuhTURs5tlVwI0kYotIEs/0wsGf1GN4kTCarIolxo3IbnVYKdPVK6LAqrc5o8FfG63emmTF2sYmqmKpBrVh0aQFnXS1AXC93Z8H1JoGll3DzEleI8Pgu5XLbd6hARehKVrekghw3yYIXNWs82HYn87Fibehi1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gGlM1jNB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QqE5IB6E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WvIg024799;
	Mon, 2 Dec 2024 11:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=; b=
	gGlM1jNBaGPHQwmtuq2p5vOqSerwApTCWYPiYYeTOxc2quzeIs6RHhk0U6eFmHvS
	xkWWF+YNNBrIoB4YS0Li+En9HU0daYF82WQom32AkoO5AxlapxnQxs4obBGq4xvk
	kCEgWS98/ZAAu9TXELqbDD50rXzXs/MJOuz7IbIzPQr34J7yvwnIicIlhPVXW6Fp
	a+3xZ31inLrOFZKXUh1rGJQMIKIsvGA6Rxrsswo27NyzKxlTO4uEk3q89N9rGIDu
	0uNk+SATes2lFG1KRswOy5JFsvZA9qI12MUlSHUnb2ppe/s8kD47YiM/KWSkPon+
	cT3KrrLsihxaNgwmuV2siQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg22ppm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2AcXDZ000871;
	Mon, 2 Dec 2024 11:10:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56e081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLqRYDNofTmHoOJK6ttvrynxx2K5dzK94Y63yuqUB6JAzT/deJ2XCyQ5NPpQ5iYQAV34ryrBMi/GTVtMGh0AkpM4Di5qbyH0bB/hABBS7nwwQG/hpoN72d0Af4e+pcmM0J0lkrO1esopen5FCbSkdVQKjvFDy7VhdnnniaBL0Cy/6KFQDnn/Jlh8fNKYWWdXlqNAeS5x8F3fL5C1/tOTqpMNG5stlXUvPl28vNQoZ1bLn8PiEKLpnvgwr6gxr9D73L0dswKfrWSmak99em9rQ3jFTugLpO+EiYKt8riEQICyUVkeFEafbNKga+g9v4eLVBpzuaOWCgJp2Cn2wZfqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=;
 b=ExIKF5p86fpHzXub4Xn5wvxFrOXGwu+UQsquSeVfeiIoE2U4ihjsCYXvnMN5D64YqYkjF5gAXwL5oUQqIAZiHUuqWzz2TlPTZIyaINx+/XbAJwkUEW4RrcZ5z3RpLcaNrvhKiFNOr1tiWGzw6Z10gi77CG2yQ0Oiuuwemq+GziD+A4tNZUfuMq7H7eZ9H/EUXh4hr21iiTCxUyEeQ1tkfOUXpKdiJAYozmjwp7ydo6M5LbD9ElRWRo7BeT54KDEhfGv+KDV55AqrpNtJldqwQiaWPRpUfdIQ9M18gPLp2ag20bUqRLDLvWzELv1iO3CwuN56IVWTWv4vgfkbx5dJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=;
 b=QqE5IB6Ek0frJaPr5kzx50FKrbAlVAGYxtzdgUhx51o3LyKuOEV1CO46qS0zBfq6B1Zh6l1JJ/9WX04totAneaeejertk8tceEwO/IdLOQROuMxe/v2TeqAMHe9xzPEKbw4KzO+hmtzi4jXsfZ2qak2jGFkpnKxWN35l0c742J8=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 11:10:51 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 11:10:51 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.4.y 2/2] cgroup: Move rcu_head up near the top of cgroup_root
Date: Mon,  2 Dec 2024 16:40:24 +0530
Message-ID: <20241202111024.11212-3-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202111024.11212-1-siddh.raman.pant@oracle.com>
References: <20241202111024.11212-1-siddh.raman.pant@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5051935d-1ceb-44ab-ae73-08dd12c1fb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEgwSEo2V2xYejh4dkpvRjRzMFoxVG9ZMlVHcGxmMUFmSWxSeUlSVjR1S040?=
 =?utf-8?B?bXBYUE03WjlSWmRzVGUySlVabHJjajdYSFNYUjh6Q3F1bDcvNmtFRGhNV0xw?=
 =?utf-8?B?UkU0U0xDamFhUm8vYWtncmx3d3hYT0FXRWNBeFg5eXZhRUhrNmpuRnJUK09V?=
 =?utf-8?B?OVplTWJxWHJqWTU2MFdON2p5YXlWczhxb1FhM1VXUlMwZUNzbENuZ3AxeDBV?=
 =?utf-8?B?SjZqUWlrUC9jLzZpQ01kL0NHaWQwRW90Tm05Tzdzc29ucXNMakFlaHJvWDF6?=
 =?utf-8?B?ZzlvUVNrWk9xTkNPZU1JNUxWeUNzUWptZkYwT3VmTklWUitkSlpqMUwydjk2?=
 =?utf-8?B?Qld3cEh5Mm1MTlAwaGQ5UEl1anFQQ3IwbjJlaVk5S1NwbTBNWmxOeEE3L1Fj?=
 =?utf-8?B?Q1RDOHRORFhxaWovbXBaL1B2dFpTOUVsZ1FCRGlnemh4dmxpTU9ycVRHd1lS?=
 =?utf-8?B?d1FqSFFMZGNuL0FWU1pmeWFMVThCQTdHTU5TWm5UZ1NBTWROQUpIaVJQRDFw?=
 =?utf-8?B?NlZGTXBBdzIwcGhzM1pVWU0yeHNXYk1lSFYxNGNoTFdsWm5BeEJ3SnVMbktz?=
 =?utf-8?B?eEZ3RXVpdEZBM3dTK3ZLclh0b1I5TklsV29QVHlvU2hodEZESlI4VVpGck1C?=
 =?utf-8?B?aFhrVTh2UVVVelJJWVV2ZGp1Tld4MmFiOEJFeTU1RFpNbTZMUnJpSmtPT0Q4?=
 =?utf-8?B?Y3Rpdm1COWRvUGRzU2VRZ2hoVHh6M0QzZmVMV0U5OGhIdXA5UFZYb1hPejJk?=
 =?utf-8?B?QVFrYm9CZ3g5c0FIN29PcXpjdHB3eGVBa050RXU3TDBpRWJEdzJKMm5oVGIr?=
 =?utf-8?B?SVBCT1dRLy9ScEN5QUs5OUpVS1JMdUJvRnhOVktGUUJqaUkyaGU5YXZpT2RO?=
 =?utf-8?B?ejMwZzR0NFZ1a3VOU1ZwRnFqMFFKWWxTTGRPaHBNdFA0cXZwTjlCMEZCRE50?=
 =?utf-8?B?Ykg4VVRidmVBcjBlNGhCM1Boa21ZaVNyTUE0Zi9ROWQ1QUxVTDdXVHVxb2sy?=
 =?utf-8?B?Y0dHYW1mdTZiNEFrSVNuT0RkZHliMU1wYjgyM0ErcnJ3QzBYS2g1MTE4aXZt?=
 =?utf-8?B?TFpxQmt6QXNQVjNDQjg3amNzTzV4aFRVai83T0Jwc2xPU0JPU1hqQW1aVlVR?=
 =?utf-8?B?UkUvTVA1Y041aCtOTEtWbjVmZXBKMDR5M29zZVExbHpkQVgrTFdUdDBMZ2h0?=
 =?utf-8?B?b0dnK0wwSFN4cnNEUWJyTmV2WjVNallNYjZqU2pFb05XWk9KQnZza0dObEhv?=
 =?utf-8?B?SytWd05Vb2tsaDBrYnZhNk14Wm9jS0RWNWVoek9KM2h4UU9YeVBhQUhFTTZH?=
 =?utf-8?B?WHFSWmM1NzJOV25uQmU2VUdKWDhZUGkzdlp1bU03Q0w2N3RvSTZGMTIvTEtC?=
 =?utf-8?B?S1IzZFVWd1BET3VLRHdGZ213R0ZOdlI3MFFUeTNzVzR0L3VCYVNNeFRXYnYy?=
 =?utf-8?B?b3R0MnpKU0Mwekpla3daeVNyWUdWUFU5NklDWjBzSjFCOVdMNjBkRlpOYTJY?=
 =?utf-8?B?QUJucXpseWtvb2NLNDFIRjlJQ3FkaGdpTmxQUUJlMWw5clF5bE9aQ2c1TEJa?=
 =?utf-8?B?ZjdRbFUyL0JYdVo1bTR4TEFVUGo5bklJR3JzUTVtZ0R0SEw2TFc3eElhM3k2?=
 =?utf-8?B?R3p4ejZGbGM1a3VKM284RGp3a05NdU1UOXdRNkdLbGNkT2c0ajU3elhyUURi?=
 =?utf-8?B?bWwvYUwzVXA5L2NZRDh0c3p3TVhvdnkwT1d3cms3emhvc3BoYWE2U0pSVGUz?=
 =?utf-8?B?dDB5eXhIUHJLNVVYL24ybVZXQ3ZHeGJSVjB0bUIxY04vTE9Ub0J2ZllQZE5h?=
 =?utf-8?Q?OfKOaDJ5+KexWEWF/BaZodcXQQLJw/B6Y2ltI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlVMNnRKWGJNbDg5MEtZK2F4bzNOZzZCOE8zakNQN3dWd1h0M3pJQkZyWVVC?=
 =?utf-8?B?dDNjckRyR3orbzBxSmNRdUZjMEZIQUxDUGl1THR6WGtwS081Q0JOYmMxazlN?=
 =?utf-8?B?OU9zUTZsV1haaDB4bS9uSzIvelRFMWRSdDEyOStxUk1mQmpUTnpvQzJOanNi?=
 =?utf-8?B?N2pJZU1lUTV0c215Z0pkeFFKM1dhcUNETGlWc0tYejlVcDNyeHNIbFJsaFNO?=
 =?utf-8?B?am9HSlViNFdvTUFMZnJqTEJ5YTZVQ0NENjZTVHJHQWFNc05Nc3c2cDNXZ1Qy?=
 =?utf-8?B?Ym0yMHhMeEI2VERrNUFGZFJpQ3VRTGQxMXdVK2xpbG5UTURJK1J5ZkpEVldS?=
 =?utf-8?B?SUJTTkt6TUZhS0I4TXlKN09xYTg1dkZoalhOZzFrdzBBaGl4SG9RdExta2xw?=
 =?utf-8?B?VW03MWUxcUQ3c2p3YTFQQTM1Wm44TnV6QTd0eHhjUHdUVmJTSTlJUWxzY1Rs?=
 =?utf-8?B?TUp3bFZCWVE2RzVQTW1kUjdiWE4xNUZlNzlJUWZpRk1zT3BNTDdjbzgyL2RM?=
 =?utf-8?B?S1NwTWF6SHhSaDE0bEV6bG94UVlabEJITkF0YkxmVzRqR2x1Q2c4MDN1Zkps?=
 =?utf-8?B?N0xOUUtxaE04UmROWjJMWmNWY2NDaVVwam9tcVo2citRUE4yd09sMWxxcXJB?=
 =?utf-8?B?YTkvNTZ2RkVES01mc2QxNDg3d3U4R3VRYk15dDloK0ZmajRWQUd0TDlyWk85?=
 =?utf-8?B?OWtvbmtTMVBlZEtTWTgxc3p1dVNaNFlJcVBwY0JSb1hjRmtLOXNETGM2TzZM?=
 =?utf-8?B?WVliTmxTaE9JWkV0QUtnZklWdDFYMGFwWHZsMTJVeEdzZnB1WSswZjR6b1E2?=
 =?utf-8?B?OHlKSUlERjNPMEhXck1YQ1JWNmxBV1ExL2tod1RMWUhSY2dKUmdQbFF1c1BR?=
 =?utf-8?B?N1BDck9Fcmo1NE1uRnN0MzZZRXZTRGlNeUdVWmVBd3p4Z1FrNWxuNjNYT2lZ?=
 =?utf-8?B?RkR3WnlYOVFCcDJKcTIzRVIvMUhrZ1Jtd1crUWJ6blppRkFvV0ZGQ0dXVlBp?=
 =?utf-8?B?ektCU2QxalFuTTRsMUNWMEwwbm5JbGVkTTJGeDlrSEZERlFUWDQ3eVJqMkxF?=
 =?utf-8?B?NGZqNmszZWcyb0dYS0dyUTFBWmk4eTcyVHRhbHE3dk5hd3drcHNVdHAvYXdr?=
 =?utf-8?B?MFBna3V2elo1a0tkZGZacVU4VFNDVWE5Nm5jL3U3cWU1aitWSEZjSWJRanM2?=
 =?utf-8?B?bWJNWnhhd1V6QXdLaENDWTlrU2JYajZqZFVERUlTZWRXYUhDSXAzTlpadEIr?=
 =?utf-8?B?NWNobGtOUDRtYllISWpBVE5NOW9VQVVsZm05dEdKcTFodTFlRWVwcGxONVpY?=
 =?utf-8?B?UktrS0E0VnR1T241c1pVRTkwS1FEN0ZEOHlzRGhTQXByOUNpd3QweTlQaWZy?=
 =?utf-8?B?QzhuSjlqSEJiMDRmYm5BZUt1bXdGQjdlQUlRWmhNSXZvejJ3RVVPaGNCbE50?=
 =?utf-8?B?cHc0K3JaWHRhMmdpam9TTkxEOEU4VTdjZ2RZSURMbkxNeFJuRTNqUE9CM0dx?=
 =?utf-8?B?VDBBcy85ZHJvTDhxNGhrdmFpSDg0SjZmbCtZTWZ3cGxldjE5SzBuV3M0Rm5o?=
 =?utf-8?B?NXdZYWd2cmM1a2NpZVBWbmt0THQ4NHdrSDFDVDM0bjNkbWRNQ05sU3hkVDk0?=
 =?utf-8?B?NG5DdDJLdzlSOUVjdnJOSXZ2MHBpN1M1ZDlaR2ZoSytiTGF5SzZsUThyR0xV?=
 =?utf-8?B?QUZLaEtjSHNFTmZvQmpUcnpEaDRrWmFreFJmbDdLeTBaa2V0aWwxZHlnZWhm?=
 =?utf-8?B?ZFlnOWZON0t5WTErR0JYb2ZPMlBEUXBnSGcyTEFkeDN6SkZ2bHgyZ3cxd0ov?=
 =?utf-8?B?Z1l0SnZFc21QaXRVTStFRkhLRFVoY2w2NlhCb3BWYzhsNUVWVUxxMFQ1MTdo?=
 =?utf-8?B?VElzVzdPY1hxMFY0bTN1d1AraVNjemQ0Y3hYdzZjT3d1MlFIT01jcFhRTFRv?=
 =?utf-8?B?ZGVOdEVNc05TM1dSNVY4ZE5QRmJNOXQ3UzRUVGtmaFVsUTQzL1ZVcVI0MHNX?=
 =?utf-8?B?VkxraVl1RzdSNXp1Vm1rSm9adWVXOFgxUXhRZXZUZ21adTY2dFdXQW5jVnZr?=
 =?utf-8?B?Mk4rS1FXUWl1SVdTV1NSOGp0SHhRd3hzeXViVlQxeDVPUTFQemQ1RFYyU0pE?=
 =?utf-8?B?SFdzYjlUdmR1NkNQY3puaHVkWlhSbS8waHZkOUk5d01yQWIvbUdBcFQvRG02?=
 =?utf-8?Q?lGMI+Aut4Qbg5nkgWDQGbaU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oERvmLWbQQy7YiWsLsnyl/6o4TD0QHLr1iFn+yrrfIffe+KYUZYoaNh1MY2e0gKTsajM1QG1xJuZ1Ik9QGXa+7q3Aafxc9L3dALUeLP9WdwOEoVVmUUzy1V4nwIKWAPX5IQvgjwXhCUAeAQo65a5tjo8qo+3wBSzZVdoa+XWgY49/6/eMa70GyjBH//5cBwpoFVQ97vqWmPQRe3DZqlAXPGAwmsMGobMZT9axONZ+q3feiG1AR+0FnCSg0AoVG09C3Xh+/sTbVIWqZAQVpQ9iyaN28C/LY+3pCasp4NYCy9bXe7qUs1+qfD6OsYWRpD/O+4Ck/0OG0/b2tvKRqUkm28gqfyeiPP6KqOmVu+8PVTy96qIZ/x6foLTzlug022MCsGBoAxLzZD1wBwcqHIDNSU5/XpcAq8+IsKinNZGBbJFr0M3pvyVD4NKHHiUFiYljU/MrlzxNl+UEM7KBZ2Wo0wT4dffUAjTqftfpL+2w4X8p6jpe51mSWPFGkBCmQMybJ97TvWakqIgPL305156W0X8ELlPw2jrWKc9JRnJEvTgMr6+pAeKrhEYdiKh9QYxaigtmC3NnNqdEkYuk0tfM7qv22L8P5u2pyg8I84tgj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5051935d-1ceb-44ab-ae73-08dd12c1fb9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:10:51.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3qFx2mffJe2WSrE3GKdI+6L2fUlD3MvTm5xNS5700+QDT86Ic8zBj9MxhYQ62Omx2HShVEibs/nwdSCMEOGrq6zpdstR+Q4sZVvHb0LIuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020098
X-Proofpoint-ORIG-GUID: 9SXhEVAEyMQ9c9f_Rz7cr6_3I7DiDJ8A
X-Proofpoint-GUID: 9SXhEVAEyMQ9c9f_Rz7cr6_3I7DiDJ8A

From: Waiman Long <longman@redhat.com>

commit a7fb0423c201ba12815877a0b5a68a6a1710b23a upstream.

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c64f11674850..f0798d98be8e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -506,6 +506,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
@@ -515,10 +519,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.45.2


