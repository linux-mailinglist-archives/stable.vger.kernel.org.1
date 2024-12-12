Return-Path: <stable+bounces-100838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D3D9EE006
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890BE160F71
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F920ADD2;
	Thu, 12 Dec 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZytnGVRX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P1cdSb/G"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC55207A23
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987444; cv=fail; b=bvmnNXp/KSnc1KR3564BA6vSLJ/awlZcRiUVp0ag0pmxD/me5N/u/aR9PLb2OcnJfB6Zh7uBTuKWn3boT4jf2YNBuMmOrIgBmTF92UqrhefIYToJTlGONwrSeOt4vxmhZ7t5KimYZYTESHTV6c0nkWxWsTgjXup7GYf9VU+b5DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987444; c=relaxed/simple;
	bh=plIdxSFJJcbjgy/YozWj5sWgK73HDU61uvH0ApX3R3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DdjBAHLTSEuzs3JLKg2+qhkPrTF+YyKgxep/s2o3IvPWotlA/SZzLzSTbZc7JUm8iXV4U6ZPoIqCe6gktDQ4hb+DiT6/NToZxwrvUaeJUZx79GfR5TuKxE8L/uKI+iNKNAwpNS0xdDOuUVTeBhK3m9QKAZB1CCJ/1yQFkOEXZZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZytnGVRX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P1cdSb/G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1uVN1014256;
	Thu, 12 Dec 2024 07:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=I199H35s3TwIMQNUoxTLjjDnBmdiE82u70Rr4ESZZ6o=; b=
	ZytnGVRXWuLk15V4msWWwRV8/Kozi8n3R+5ubAprjfLRHEsay4O3nw24d64tP57X
	1rlJECbBeptBZErBYUSA6M4PPYyP1h2UHSXnfO3p3gbnosySNnF0aks9obKKVVh3
	DDYAw8QHDZ02HylfP2BrmzCAyrp+wYLNvgTcchYAUvRkcqDaZGYoFnrqYSHJF6Up
	ABXqI+6FSzs+L2IhtRTAcCPyhOK6eEynv9P0jQ2PL67D9Tp3YWmRxYUqIVJcP57r
	7jkfMKQGIjk7v6NmWPOaVt/BFrhpF9PdM63+HECBms0HcjQ4eXjRnmYXSYnyNGCh
	RajQ+z26TM12uQJpFI2BhA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt2cf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 07:10:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5YPxj009482;
	Thu, 12 Dec 2024 07:10:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctas35s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 07:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss9ogHedvfMLeQNuQJxLj37pnHW1+vbwsifEWsbfYfi4CDhBSowcL8JeSzfD5AYXP96vywdWtBhUjgUTCRJtwiKzYG0yErUhFNXhvcpD7EXpbF7BMrBAylaqG9lWt0oYGqEiGr+2TerUzCiAnnbbcFcpoZ6WcGdsui0idV8uxoSK8FhTeodXFwrm7GWHY9XSK6Vmc1MWknYG0w1RF0xbj/pgkjYf0zxzvZpGy74DYhgLlnQtSYOCtlwFn7+K841z16LhslI3v0lQgKvt3HnTAiNUXMAycg0y61lb4L0HxQ6rWRypW68TrPXAtOSnP2qCnjSXttdqs9o1C8/AXUKsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I199H35s3TwIMQNUoxTLjjDnBmdiE82u70Rr4ESZZ6o=;
 b=JNrkYp9Ocgch0O+RL6rIp+MmW7QMO8OBBLj40nkGIDX7EQcYcnZKR5o7NNpihce2yeiioGhHnbDG07m/sMHvxnZ75wvXDE2w+4IO83cD/zP0X5gOWTC761EVxoNejkd32Rka+j3GR84nGBrWRfnm0/uRxY7OAcqsGyGvpzA/y4mDTO8NtBEcXYLMwl3p6xcBmgOJnsSYnAuA50tDspvGyAsjbIM4LExP38Qj6kn8+XTRH4otDjFwqNOSmjcudcwx7iGxRm8bz/je5EDiXSe1Ke8c/PhWi7ScmxjA8ChuLKtKJB7U51hu6CafsCewxvt9maX44oMYVhU4cuDVomHXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I199H35s3TwIMQNUoxTLjjDnBmdiE82u70Rr4ESZZ6o=;
 b=P1cdSb/GfLwFFAOqFdecPM00pCnl+7qlp+yuWwaIfgibSkv1GaphPMrOMY10G9y9gINltJSBd/IpUp5ioPsNza6DeBRTqYKalq4fbjgQ6/KUV2Vr84d6CZxttrunxTQR4zzFcfGNCls/T+tm2omioAG5XWDN3kTEozClbol/TME=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 07:10:26 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 07:10:26 +0000
Message-ID: <2d9b921b-c7fa-4bb1-ad51-16c176888618@oracle.com>
Date: Thu, 12 Dec 2024 12:40:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
To: Greg KH <gregkh@linuxfoundation.org>, guocai.he.cn@windriver.com,
        Sasha Levin <sashal@kernel.org>
Cc: mschmidt@redhat.com, selvin.xavier@broadcom.com, leon@kernel.org,
        xiangyu.chen@windriver.com, Vegard Nossum <vegard.nossum@oracle.com>,
        stable@vger.kernel.org
References: <20241212064846.1079097-1-guocai.he.cn@windriver.com>
 <2024121257-enticing-uncolored-fe71@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2024121257-enticing-uncolored-fe71@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|SJ0PR10MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c5a5af-6980-470c-fbf9-08dd1a7c0d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L243QUlaK1hZbWptN2lYTGJBa3F5T2JvNm5nNlFxY04ydmp6emw5VWJ2d0pk?=
 =?utf-8?B?QXA5eTlLMDlXeTFPUVJMQk8xUTFRQVV6MXVyTjFMaE9TT3JyMituYm44YTVx?=
 =?utf-8?B?VmZsNWtHWTRlS2ZrditnbVpDRExGS1pJejFDanUwRzJWYVkzaUZCZ0xFQ0JN?=
 =?utf-8?B?OGxORTQyaWx6RmN0djhSVUtjT2wvQ0h6WlFJUGdRanhjaktnMEtId2w0TzQv?=
 =?utf-8?B?YWNUcHNTeFE1dFI2QmZ0UzRMa0ZIUlVZQ0YxRnJRRHowU3N4ejBDaWI3VUNM?=
 =?utf-8?B?UDlBN01SbEhqdmY2RERYUzY3K2tQMlErdW5UcUd4cTNUQk90R1ZZbVZYQmJH?=
 =?utf-8?B?Tlo3OWJvaThkZGovbXBBdUFsRUNMeWdOMzB3Z2RFYlRuOUdEZllUNHQzbEt1?=
 =?utf-8?B?SkNrQXJYN3FXdU5VbUhyczZVWU12SnB2T3JpdWFpc3ZqMGNzcWppT3h1NmRt?=
 =?utf-8?B?bjBPUWRKTklFRDE2bnVvc2RXdWpzNWJpTzY5dDlRc3lNTlFJbDlxaWJ6UEhR?=
 =?utf-8?B?aDFUMjNya05ycUdFajNNR2g5VzR3aFVmUGNuVEIza2tiRHRCQ1hJbS92Mnkx?=
 =?utf-8?B?ZGg4Nk5jZkd6MExvSERaT082eERRNzR2M1U4eG53Z1B0RTBWcjFTZW51WkRK?=
 =?utf-8?B?YnNKd05RNVowMEo2ajVEdVNjVDVsV3BCYThLOCtiRU54V09uNUlRcmN0UG93?=
 =?utf-8?B?cTlMQmxFVysyVlEvMkQ1bTI1b0VxTHU1eS91UVZiQWtKdXQyelBrbUp6TkNK?=
 =?utf-8?B?QXVxS21vR1NyYlZXNzl5L3VSZGN2YS94OHA3eHFIMFdta01nUHE1d1pFc2lk?=
 =?utf-8?B?ckZEbEI0OU41eUNtdVBVdXpBYk51KzNqUXVYU2gyaFZ1Y1VKZWpsQVFva21x?=
 =?utf-8?B?MElpZzRLOExHeTVGemF3N2ZQK1ArTEh6L2FaQ2VJQzliVFlMVTJOVEZPY0pR?=
 =?utf-8?B?K0xxVzBTbWNNUU9yMm94QnN0Q3BmWHRHUGhnOU9qWlZoY1ZPWEhVL1BkNGVp?=
 =?utf-8?B?c3ZldXE3N09KZ0JxL0FmWmJrSUVJMG1lSHhHMjZhVzlxeEp6RXlKU0F2R3lo?=
 =?utf-8?B?VVlJYzFmY01ITFdkWGFaWStFR0dOdjRHWkhoQ1BNN28rUW5vV0NzK0hGNmVj?=
 =?utf-8?B?aUU4VklLOWlqNFk0MS9FbzYyaHhTajVZdUY1STNTaWdLb1oxUEpIZG1mMERT?=
 =?utf-8?B?eGwzRG42dHhTa1h5MTJwbFlaSlNWKzZRZFh0UkVjS25tbnlkU1VzVnFNM0ZS?=
 =?utf-8?B?bEtoczVCWTZVNWM2YTRWWGxFUlZtbnU3Q3VwUDhQeFREd056aWtyQUREdjk3?=
 =?utf-8?B?bk8xS1hCWUV2Tk8zelpHRXpYSlovRldjNk5lemU1b1llVjdJa29XWi8veEdL?=
 =?utf-8?B?bk9YMkllU2VqVGFYdUU3cjhXU0dzMUVCZE1oSHN6Y0F2c0wrL3NUT3VEMmdX?=
 =?utf-8?B?RDdscTk2Wlc4Z1pQTlFjeHUvZ2xLUW01elQvQ3lYQnROMktiOVhIc0RaT3FK?=
 =?utf-8?B?NWlzWGxMa3c4YmtmbWYyZ2pkRDJwYUY5ZmJmd1p3V09CVDJlUGZ5YUtUWm16?=
 =?utf-8?B?cVdqTThMOE9JNDZRR2d0UkpkTVZ5M1Jyb28rMlNmVjJXM0lVWmo1TUZSZk1w?=
 =?utf-8?B?L2NSVXAvZEJoZ2pCL0dHNHlLOWx4YmJkV01FUlBtNjhWOGpxYzlxaDdETHMz?=
 =?utf-8?B?TFNOclowM20yd1FPcCtsN05qMDRqbUZGOXQ2OExoVWdxZ2xTYWlhU3VzQ01h?=
 =?utf-8?B?K2JuVHgxRXU0c25xdks1MTA3K1F6akJlWCsySzZZTURjL29ubGZiazYrR2VE?=
 =?utf-8?Q?/JXnnwmZvxk8xm8FYE005LSPpAgFFJkqovOxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkxRV290M1IyK09DTUJFUGxiTXRnQTQ0Q0djcnFlRFBIV0wrWUQwTFp6S3Fi?=
 =?utf-8?B?R2FhRmpCTERwRFhISmdHRzRUTDZNQ2NacUZEQkYxS0lXa3puTjVRRWx2UXFp?=
 =?utf-8?B?R29jdUlUS0liL0d3OFNFOUlHYTlLSTFZN0d0Y01UNmdXM0E0aDNiSnJ4cFpw?=
 =?utf-8?B?bGZ0MEFGWmFueXVKTVYzaWR1enppMXlHYmR5QnIvNWg3eDVIMTJTbk1vb3Jw?=
 =?utf-8?B?Z24xOTJNZ3cwL1dPZ0p4TDZNbUIrNTZVV0l6Q2FSNmJ5dWNWQUZsV3hxNkx0?=
 =?utf-8?B?VlFCMXlCaVpjTTRCdkdieUhCeHVXZ0RqRHZsa1FiZkVTNGVoOW4rb1VwanNM?=
 =?utf-8?B?bkQwMElYNlhndzV1Ymt4TWxteGFwYjl4YjFuMURzOEIxL2tXcXRzV1RLbDJD?=
 =?utf-8?B?MkVkK25KcGd4dHJQci8zNTJYSE9XWlhyd3pUOFRrWDkvV1hVSXZsSlZMbkVH?=
 =?utf-8?B?RlNYT1hBb2NGQjl4Tmgzd0ZTY0JkdGpFRXYvTC93Vkt3MWZLcUlMbmV0UE9B?=
 =?utf-8?B?K1pxc2locnJmLzRMKzliUHl4R1kxajFyUmtJZFhBSGtoRUxwdjZSVmhGekFx?=
 =?utf-8?B?STlrelJXcEUzNjF5TFFlRGgrdkM0eUg3NE5GR0JERmtKK3cvWURmOUlZL0N3?=
 =?utf-8?B?VkdQNWI5WUw3RUJXTXJuUjYwSlJUUDhLYjJ0emNNRWh3cUhUUEluSkNwOFVH?=
 =?utf-8?B?WHd3Wm9jS1FZaGpYMnJzWUsyWGZhVDhqK1d5a010VXM3TXRaL0tQR01yRGUv?=
 =?utf-8?B?bEZ1Ynh3cXI2R0FaSVR5NFhwVFFqRGYzcTk2WjB2aUYzODBnL2FISWN6WjZr?=
 =?utf-8?B?Q21UalRKSVp0V0Y2MXdpeTd0dzZFRHIvaURQakdHMDVYcjgrRVlrTmc5MExC?=
 =?utf-8?B?cFg3L0lYQ1BNb3UrMjk5ZnQzdGhHRy83cTVzVjNtbTVDZTlMSDFSdkhiVFhK?=
 =?utf-8?B?L3V0WXI4aXV4Y2lRN1RCKytUSG9SamphWFJVT3RaWEx2Wk53c1kxRXA1ZnRw?=
 =?utf-8?B?QXlZWHhPNms5ZTJKV3ptMytLaWNvUHRBbEEwMWVTWEw3TlpQT0d3TTExeXEz?=
 =?utf-8?B?WUpPZ21tNGFyRjJ3OGcvd2s1eHZKeHdobjJ6WGppUkFrT29SbjJGV0tBQ01x?=
 =?utf-8?B?Um5pWCswVmNEWUZYZEZMVUZKb3J4THNTUlpSN1NCNWhZRStQVVpldHp6Zjcw?=
 =?utf-8?B?N0tzNEFKOWtqbzlIKzBxaHJSS2NrdlZ0N0tRV1hJbXc2QmhiSmJUbjBlZ1Zp?=
 =?utf-8?B?NmdreVE1VklyV3I1eVI5RWNqNGdEY1BJaCtUMy9MYWswblV1NzNxY1JhL1Vi?=
 =?utf-8?B?SzNZRVlxVEI0b0VPQlM3YktmRlhHd0NpVkE0aW5SbG1TMWVzYzdnN09LeStO?=
 =?utf-8?B?NDlkay9SbEV1YnM4NDVrbWlCWStJYUVwRjVKdWx1RzhEUk53OUwzcGtLWDFn?=
 =?utf-8?B?eERmTFhFNStBU2poZW9RZmRHY2RHajFvV2NtK3k3K29pN1RtMW5aV0FKTCtj?=
 =?utf-8?B?UUdUcDRIdXc3YW8rUGdQR2RaTm92SUV6SVIwK0tyaHJsanAyWFBoUFBpNUwy?=
 =?utf-8?B?NWNkdTRQdlovOTQzaU90QlEreklBUFlBQXFNWUxMeVM2a3hHdTdmVktNY2hq?=
 =?utf-8?B?eVVaOTZHOGFRZk1wVHRvcXA3R1o5Um51aWdHeDFFOXYvRmN5dVROd20rVC9F?=
 =?utf-8?B?ZEJXdk1hMWl4YmdTYWhMTDZqT21PamQ3MDdoZXFRay9PVGxzYXFQVHpaMU43?=
 =?utf-8?B?TUl2dnBvSkNDQzZxbGlWakhNcXVPdXZRU3FQajhIelZuVmY3dVNHVUZuMjQy?=
 =?utf-8?B?UG1Idk5GblRKRmNnM1hNYjZET0prOVNjVDIwNk1YQ0FkNXBBcE5XdHkwVnEx?=
 =?utf-8?B?SzF1eVJtMTRwNEg4TjAzTXQvMFVaQ0FJUy9qU0dJZlVDUlBSaDhxSEdSMmUy?=
 =?utf-8?B?b2QrelEzbVVTTHVGWGJCanhlZkpDUFRja1pYRTE4ZUFjT0hQMnI4VDA4bWhE?=
 =?utf-8?B?ZzVPTVFCL2FyTHBacnpTbUhZY05PbGY2QnlsVlF6eTl2UGp2TGM1VFZHNU1E?=
 =?utf-8?B?aDFmZWZ5a2cyMlJFZ2xub0p5Q0EzZUdzVlpqZERiRnl6eVA4Z1FiTlBpMWc3?=
 =?utf-8?B?R2dwNFdoZW9pemlUZVk4SGM2QStqMW5yd01XbGJad0ZrUEEybEZ4bGpOZktY?=
 =?utf-8?Q?0FDKfd4e06Z9JqoCbAd8fow=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GcxQJOSD2NMxbr7Pfn++b2rcqNVM0sMqC5cA6KvE18VDtxUFxs274KfiyRZxFCsKOAm9jTE5yfalmlc+lk3WM9x9/xsXWxGGPA8HwYwqV3Ybf2JALJNGQVw9Ht6dtSqGidFELke5NuQaMxUPLxGTf8FRKEtJp94SBgkUzIpsFqE4lURJsQHCPjyjF65QjQEMfWlmS6durm2ifZoWjYjtuVaJorxy2ar2x2Q1IBOSKHCyLfkmEXp4qoZJCM+1VHfoLuOpQzxbthO5GRxKRxH6U6XukmUjxySXZMTK49+CXhcRVfk1+V8sEuR2/8MR3SKFdz+LuWbz8yvkn/iFYZwaKmt2jRXtJ3tzXJY0XoH27whFcrfKXLUr6s2eLuK7aQbkYlPv2p8EHh7eN4po9Pnyu2aFjyBuRSJp8yPJ7dSNHrJ/m/43FJo3DduE+193bGV0mkL+n/Av9YEyQuGIYQOeZl1/Q/6TllOpEf4pN4vm2ENwE+5CRTXiQbQKeoZPAbh+nV9nUENPnq9D4rXbFooN+AYN1bHnA3tNmVpJv8rq6n5Mqe9IIs8sgWQ0n13mlYDFvDC+ZK+p6/xwhe14QVAwIMc8QrjX3hpKhCsw2tgZ6og=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c5a5af-6980-470c-fbf9-08dd1a7c0d8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 07:10:26.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM6QxLN9B8RzNWNpSHn9R9iqBUl6o8ahsLYbhBR2eeG5yq4V6vrgP8hR9E8RRV4vA6pSlT38jcqLc3m/wJwofEHQu8Bxxf9ZSZJftgyNrVZ5gm/mAJcsBm+uu9n/hN4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120047
X-Proofpoint-ORIG-GUID: nTmaYDT3wK9zDej_0NlxuEBbZw4oV7XJ
X-Proofpoint-GUID: nTmaYDT3wK9zDej_0NlxuEBbZw4oV7XJ

Hi Greg,

On 12/12/24 12:24, Greg KH wrote:
...
>>
>> Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
>> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>> Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
>> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
>> Signed-off-by: Leon Romanovsky <leon@kernel.org>
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I have not signed off on this backport, why did you add this here?  You
> do know what this is saying right?
> 

Note: I think Guocai cherry-picked 6.1.y commit: (probable reason for 
your SOB and Xiangyu Chen's SOB there)

stable-6.1      : v6.1.117  - 84d2f2915218 bnxt_re: avoid shift 
undefined behavior in bnxt_qplib_alloc_init_hwq

This clean cherry-picks to 5.15.y

Question: In cases like this where we benefit from cherry-picking a 
commit from another stable branch as opposed to upstream commit(if we 
used original upstream for cherry-picking, we would get conflicts and 
probably have to resolve in the same way as we did for 6.1.y], how do we 
differentiate that in commit message ? May be with a comment before SOB 
[ Harshit: Cherry-picked it from 6.1.y branch, it is a clean 
cherry-pick], as per Option 3 documented in [1], the first line (commit 
78cfd17142ef70599d6409cbd709d94b3da58659 upstream) should still point to 
upstream commit right ?

[1] https://www.kernel.org/doc/html/v6.12/process/stable-kernel-rules.html

Thanks,
Harshit
> Please work with your other kernel developers at your company for you
> all to come up with a better workflow for doing all of these backports.
> What you are doing here now just isn't working for us at all, sorry.
> 
> greg k-h
> 


