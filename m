Return-Path: <stable+bounces-139270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC704AA59C8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 04:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F24C985613
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212E53365;
	Thu,  1 May 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DM0LqW5a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XkdsRXRc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FE2F37;
	Thu,  1 May 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746067622; cv=fail; b=TVKod10T0L5X+fx2HOVj5nFkfENg/xsSTm3kobzshL5HKCJissz7oBst3qmdn94U+FvcENd1t985s8KHbHW0jwOJc08r93psm3hYw65CbZX6kY5nrKMXbbEd5GZ/fNQYMEfSBVw77L0yipwMYPFORBcj+Hz2gS0k9vlgBOksgxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746067622; c=relaxed/simple;
	bh=8doBho5fVtg8OEZ4audnURkuH3qSbHkkeF+gky9i92A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dD/7J25iuU0xvdwNT4TftgEUOTGTSoHZxb29jGFfVXJezeiFX5uWmcGJoqJPR9NbWnSB1Qp6XsCp68R0OLRT8fSafxMzrmSBIT/Ve6CDGJM9Ql3UgPwsTzQOBeN5xD9Wju86eW+17dvvrWOCrcUmRTYbMwtsIPFa/YnHuUdqhpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DM0LqW5a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XkdsRXRc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKwYBM028097;
	Thu, 1 May 2025 02:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AGM6Cr0yUo204jBkIO4WRfFP938Ryi1shxiMny8Pyew=; b=
	DM0LqW5aSLInYB825V8GiqWLrQE4TepHeeKO0ETJTivsiTwH0YDSwNnuMuda65Mn
	lur8ygJA0IuHDAvwFu3jX4ChNWrgmhLgCfcQMr4zN3dc+SVydzbkUTd+rlpJ9eT+
	ymTm2CQ4gXF331wO9Jsv/3ohyg01+TPY0lbPeBUsDx7DExGRnv+he6yM86621O9b
	/nsdb2/puOKl1SC5XplW/m1ZDRpcatx1RmOmXR3vbcehinxTRYw6d9Y5StE97/UQ
	gkgjtYggC7J1f4lz2Tdv6Xc5kOx+fNkhhmHLjTK8eEksPVFNwETO6H86JXgUU3UT
	GsQc4eUAC5bpfPTUeNoLuw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uktf1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 02:46:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54110GJl011417;
	Thu, 1 May 2025 02:46:13 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcmtdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 02:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCA2Slcxis6K2TOmjrziCB0qipq1fIVrISO3JtYsnCj7Tm5bTr520pEbm9A0NpezI8ux5Ybt/GgP60gEdGq6ypI5QE1N/V+HjeZG+Gm61YYSmM+2XTcKwrBIse5yvQsmg0iXEGQ52l7Aiu3H/BUFWbRs9zhr4CqY8OdQwfaUU+5wVK24M8+jrbVpLNff85coP9RbKuF+6kCxd5vXr8v054HXeqcJHtGkWGSRpKPVwV5R6HSpVrFh63VgJ7NoXUHlI+ViyrrarQdO2cqbWAdm+sSHi2N1OqdQIBweyLZin0galGovf1LqDIN7vytoaHGCZ2I8Wk8xEF4tPyTLc33NLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGM6Cr0yUo204jBkIO4WRfFP938Ryi1shxiMny8Pyew=;
 b=f2UdkUDEcikSuzOnDGhX3Y0Ig8CBFQQ5Ihg8KwC8RlhKCQpza2h8ccUrQFjIlsM5o87qlfyxDlSWRHwspw4V/bV+42hSsLMUb3VpQEqpFP0ygX5LJeqgY1yu0btaJ5ff463LrcWAnDEVehegQEQw6kUBtO2NHxrr5FhvDNI9HLWAqRNAT78vJnFpyomRsJS60aHqdzPgN7WJgzGVIi5KjuDiDaWGDhgM7GfHUDC4PKu5+oiNO75C5D+kOY0FTbce1z9EqtBHdEeTubndxODn6CEI6ovpgXlI1HCJXur0XLrN7Ub5B2EH1gLXR+QY0WHrnRU93loGOKnfTX6Rn4YAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGM6Cr0yUo204jBkIO4WRfFP938Ryi1shxiMny8Pyew=;
 b=XkdsRXRcS79ytc5JkVl333aSQB0pk2N1r8Gnhm/qyhMyysx5zvhUn9kbmkM5257LerEN0QtI4F/TQPZQmRL8JPuY2LBJEW7mT8YT98S6P8W7LIGGr8EFtddKy4Csb8j9TWUkbj/IacfaZcXfl8L2svZYQEO6/cP71iIsMnqo8aw=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by DM3PR10MB7972.namprd10.prod.outlook.com
 (2603:10b6:0:43::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 02:46:09 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%3]) with mapi id 15.20.8678.033; Thu, 1 May 2025
 02:46:09 +0000
Message-ID: <f94a10cb-e65d-4697-875e-43f624f79099@oracle.com>
Date: Wed, 30 Apr 2025 19:46:06 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: IPC drop down on AMD epyc 7702P
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Jean-Baptiste Roquefere <jb.roquefere@ateme.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@kernel.org"
 <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Konrad Wilk <konrad.wilk@oracle.com>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <bc016aaa-fed0-4974-8f9d-5bf671920dc7@oracle.com>
 <020e7310-397c-4967-9635-8e197078f333@amd.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <020e7310-397c-4967-9635-8e197078f333@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::17) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|DM3PR10MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdbdccc-dd1c-444c-4ff4-08dd885a53de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlRSRldteUI5VFBoUWYyR0EwRHJhRTZZTU9ybndQb0xrdkxRV3JpTy83YVZj?=
 =?utf-8?B?MWptT09oQThDTzA5TFRNY0k5TUxrWFhwVklsRThoMXlxNndET1h4clpFbUo2?=
 =?utf-8?B?YnJCTTFSb2t2MzB6UE1ZbVJIb1FIWDJtdmJBRDNQblc2VXlsNVN0dWd0a3NF?=
 =?utf-8?B?Sk9FVElFSEM5cTY0ak50b2ZBeEFoS3loeFFadGR5cXZQMm41b0I0dlcyOFRu?=
 =?utf-8?B?T2FucVUvYXRWSXhRQnZONjlhaE90bkZIUUdkUzhKV2t2YVNURnpNZmd6b1h4?=
 =?utf-8?B?MXBOa3kyOWRxaU9WcVFQN0J4YVdIYTVSaWJWbmZFVUg3KzV6VWJ0MGxnMGlC?=
 =?utf-8?B?OTlQVUpLWStLY0JmV012cjBLTTJUY2NWS2ZuaVZxWW8zUlBMTXNhL1hyS21q?=
 =?utf-8?B?aE5CeE8zYUovMEMvSGdadUZyaFlrZ2xVanBMWm5QUTI0aldVKzNTc08reWlW?=
 =?utf-8?B?cGhJQXd6Uk5qajFEQ1pSYXloMDcrcm9aYWpnOHU4bUZ0WGVIMmhQR1dZemda?=
 =?utf-8?B?Z1FldWdWVk8zNm56VWRwTFo4d0pJUDkzUmN0UUk3RisxMmdWUEFFMWo1VVY5?=
 =?utf-8?B?anJYNEpaMWFBL3dJc1orWDNyOFpSTllGYmtLMldveDA2TFNKcmVkKzlqZ2JL?=
 =?utf-8?B?aFBLTWdsVTR2ZEtWVS9FR3pzZS9EQVl1RlozRXVWenRjL3RMZGdCU2JLejhv?=
 =?utf-8?B?VjZ5QkRUMDNPcjh5eVBGbWlXTDR5UGFYNVBIaUtKNzU4OUNCQUpkOUJlK0JF?=
 =?utf-8?B?OXZVbDNKV3RlMElWS0xiL0xFUWY1bzRmU2dkZUZYTnFsU0E4UnZTWHVUdnhF?=
 =?utf-8?B?clVWdHpQZWNkYkZ2bU81bEVGZ2hQd292SXEvNVczRGsrdnNxcm9od3N0Q2lk?=
 =?utf-8?B?VE1SenVTbUMxaW1pdTNueXN1VnVtdDhlMW9HMC9XRmRtZ1FuSW96bU9ZcVZI?=
 =?utf-8?B?QXgxR01qTWM5MXNraHVwSVdrZVZwMGoxVklVcjY2eFFpNzJMdTh1bzdkb3Rw?=
 =?utf-8?B?VC8zWjZwVkRJalFEQkxNVE1NQS8vdC9uWThLUHRWNjVCRDFrS1lVS3k0UUs4?=
 =?utf-8?B?ZGdLODFZLzNCZlpmc2RKVGJWRWFXNGF3Q3pzWXAxVGJTb1ByRzJzYjdaeUhD?=
 =?utf-8?B?ZFZ6cWVRdmVZbkpTU2phSjJYYWp3cUwyYzdJMlZRREdnOW53eTdnelM3WkIw?=
 =?utf-8?B?ai8vTTZUWGlmQlJSeWJ1MDl6VHZ0Y05CMGVtcUlpbGdPZTdHWjlsSkE4MVlp?=
 =?utf-8?B?QXJJejV1SmgweTd3V1ZBMXdhV0h5WXRsaENEdHAwRFk0UDF6ZjhOV01WUTNT?=
 =?utf-8?B?ZzN5SjUranMra0QvS2FpREtqWHVUYllOZXJjNDNOTlg1ODBOd3BIdjIySGNj?=
 =?utf-8?B?NjIxeERZWTJheit2VFVta20xMy9RK1U5bXlObWlibWZ2RWJQd0hnUnJmQ1py?=
 =?utf-8?B?dnVxK3hZRmdXeXFBY29Ca3RZeXNJWHhRcXFCTkpyY3VHWEF2MzFaNDUwNW9z?=
 =?utf-8?B?UkpzRmdVTS9QdzhmbTlXTHVoSmRLZjVIZFhpcXFreWhpRXpHZjRkd1h4dDh2?=
 =?utf-8?B?dGFvTnZyY1FIUDdhOTRZRHIwOGowV2tDRnN3VFNEZGduNFFDVUR1K3FBUHRJ?=
 =?utf-8?B?Z0NMUXZQWldUZ3lmNE5zT0pza2FMUmE1Q0NDYkhKTHVXOXFZQm1RNFBaYllB?=
 =?utf-8?B?KzB2NkxCM2llQSs5cXk0TEZUV1kzUVpOOHIxdUtCNjBjWTNhUkRzekJqaXR1?=
 =?utf-8?B?Z0JWN2cvVnR0am91SDdmazcrYjNlai9KR2J4aWdIbWJJQmRVNXVwR2YzNXY3?=
 =?utf-8?B?aGVpcjBHRE8yaExqa2FROWFRbThiWXYvVUJScENTbk4wWmNmWU1vMmhKZHJN?=
 =?utf-8?B?dVRXZDM3d01XMndOd2Z4MlZ0THVLVGduV3JwQ1Nka042eEhBRktVNGFZRjZU?=
 =?utf-8?Q?giL4dURXPLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1J5NkJuSGpiZi96TnJhUEQ3dFZIRWI4aWxNaGRROWNTYkJ5aGZ3bTFnaE8z?=
 =?utf-8?B?dEp1SE9RYzZncFlUZXo3MTBleGpjMzZKVzlUK2I3TDNnRmY2S3NJQ2lYcWVk?=
 =?utf-8?B?TE1GMldvVmdVVDFFNTBoT2hsSkF2dWJDRjY0UEIwTjFGaWk5RzdQMko4d0tP?=
 =?utf-8?B?VjNsckloZE4reTJkVnEvS1J3RnlraXFadS94dlVsYWQ1YTg0Yy9pUTV5VDcx?=
 =?utf-8?B?cEFHODloVnVDSm5vSHRoUTJPbjhTa0tVRUlpYlpqU1BKbFNiek1jYnRkNnd6?=
 =?utf-8?B?TG1PTjlaVHNLc3NoeCtRMkRhOFAxT2pNTGdJblBVVm1zVEREWVAwTFF3ZFV3?=
 =?utf-8?B?eGVEVXFXQmRSTkVxakJmL2FGaFh0Vk4vWXJQaUVZNkNXSU9KL0JWVmdjTFRQ?=
 =?utf-8?B?T2tlVkhIaEdGWndnWm9OSnhHNmVHTWJBcnlIblNUZUJhcUYxV2plYUo1K1JU?=
 =?utf-8?B?anJ5U2hpbk0zT3hoRU1BZm5mQllQRng5WEtsMjN6TitFM21tN3RSWnM1RGlm?=
 =?utf-8?B?eG9aNGxHNzFYdmNMQWY2aGZzZFhsQmIzYTZTVVgzV045NGE4Vk9NdU1XR0Z3?=
 =?utf-8?B?dFdZVjVWTnZraUtTeDB2UmNhWVZ3Y29UV3FmOXZ6YmdnRTJtTHBDOXQvMG9t?=
 =?utf-8?B?TWIvQm5TMjRYc2hsR3pKYUtLbUtuRzYzWWtjNWN6ZnFJeEYrd3U1ZWtWS3J0?=
 =?utf-8?B?S0dXRUJ1cHJKbWRpYmlpcDdsVVExc2JwbWQwdGFWV2FkaE00UG1VendTVlp4?=
 =?utf-8?B?R1drU3UrSGhCbUFtM2ZrMzduMUcrTFZWZ2I4Qml0Y2t4eEJIZE5wdW0xOUti?=
 =?utf-8?B?SzVBUHBxcjlBL1gwcHdRL3JQTW5NZmxQUlQ1dzNZYzBQV0RoY1VWK2poYnlv?=
 =?utf-8?B?TG1tOC9GRi9KOUI0NVpFMi96Mk9pZVAxMzVmL05NMU1zNVowUWNmbE5tcWRh?=
 =?utf-8?B?NW5VSis2VG9WWlUwSTR5UUNCTk53Mm5uSlMzb3B4ZTRwN0dncGlKajNvdDF0?=
 =?utf-8?B?aTIyV0hodVNobThsUGI2NWhSZVdERzFwWjBwT050MmUwVDRBQVdTYVVhWWUw?=
 =?utf-8?B?czFJZEV0a3o3b3g5cUVGdGNJVkFvSXdsamIxRlYxSGF1cktXMDdxK0VtUlRY?=
 =?utf-8?B?bmF4NXFyQVhQcUZhMmJRRXVhVnU1ZTFuUDhkOHRZT2MxdWo2US8weHBpdkNY?=
 =?utf-8?B?cXVSdGIrRnVZTkp0bjd5OE5zT2pyRUdueExmbkdKV045QnpnbXM1UWZia1hx?=
 =?utf-8?B?ZzhKMWpIeExUdUxiQ1pkZXVYTWlHRnEveEhEdWNBTVFXUGI2UHZ1cHhpeVNw?=
 =?utf-8?B?ajVXa0JydE1qUG9JOXQ1ZFZNMDhTbitkWXVnaHdOU2Jja21aeUF4VDhxa3dv?=
 =?utf-8?B?QTFFRW83YzQxbFo0VEhycUtHWitKai9YZTlNc0NneHY5a3Z3TDJrKzNJSGNi?=
 =?utf-8?B?TlA2KzRNdUFURTc1MUxYYWNxZ2xTd1E2L3VOVXZxRFB2Q0JUVWcrY3FEUjIx?=
 =?utf-8?B?OEZ1WUt4MExSMHhDMlMzR3QrK1l5dXBJZmdMZ3JmejI1SEkrZjNXeUtqR0NY?=
 =?utf-8?B?d3NDSXpQbHlqci83elJzUnIraHAzU3ovYjE1OExXdC8vMVNYOEYyOWhCblNC?=
 =?utf-8?B?bW45VURmWXJ6UlN0S2o5dFhFSEtpWTg4a0dhODUrdjU1K2d2eWRKZ0hQTjRC?=
 =?utf-8?B?V3JBSm1YY05yWjV6OXJ6czBGSGI3NVFLaUF6RXNSQksrdStydlUwUGtEeG84?=
 =?utf-8?B?a2JRakRwWHRma0plbExVT3pKUzdsL3JqcGpZQVVOMXl5SElaK0NodmphRmx4?=
 =?utf-8?B?RHRUWFptRW8vTkdZT3lkOHMyalBtTStqeXdtVEpFZ3Q1eGNpOElzOEtDRUtN?=
 =?utf-8?B?Smh3ZTIwZnlvTVI1VjFRRDJQUGVzVXpFa25iRDloKzhtZHdoV3p1VWhEWS9D?=
 =?utf-8?B?VlY3cWZHM1pNYXFldXJacGF4U1hiUUJGdmh1Zm5BS25rVFNZY0EwNUdXZysw?=
 =?utf-8?B?NHhqR0NZTElEVHJmdjh0T0xKQWhPd3FvYTlZMjJ2Z1FEekhJOUdHUHI4SHNq?=
 =?utf-8?B?OVNuRENWbHhLOTcwdHRNV0l6Zmc2M0hNRjRQUEtya2pzSU5SODdwRGRNeWRL?=
 =?utf-8?Q?0PJCwTzLPDNHTtIBtVy3MUzMJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p0sLtt5Ut3fbNQIRZ+VhPU8FIyElO68oCT2nPOjFDc0tB9uABJti5ZfvVMHlXDWsAOjQogfq2UwE5MqB1B+xpSjIKVIkd146fl5Zp5afsesNq5qY7MtvUfC1KsxrTA2vA7FFOJZjmcn5vkwl4chU3gIYtfYKarGGiW3UoPgfvDFn4OXeJ7z1QxzVQb+/KWkVsmg5FcQm6fX0h83LYR92ULxbMsAvo5vvdQBUqCCHpRwg6rhwcNxhmzrInbyX+PUzabGyMNHNood2+s6YVH27zHiKRH/d4YpDqpBAcxqjgly+onNc+wmSgWI9YYw+QLC+XhkFVLzchhZ0cOeGmOwcLVSEY0im15B5BTxC0jCiskvvcGiqYRx6b+H9Sej6gOuseGI6dd0akAIK2eKNpYvlXxVKgQpHyComX+vYOMvgzdaeJu8uUhPwqVmu5SQsojgeG6Vv6gBbkhngCHK5dxy8Vt1mLfLM9eXNq/JRc3NnxAwlgscFmcFiBePa3Q7zr0M7oeLgGtIRlB3cLzbOrNvKdSan35iS7RMFHl2c1T8y7Pk7enU+zucyLng2oAQc4geIzoR3iaushgtM2GJhDxyMuOGS0rOLKj7mVF7Qh28uyqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdbdccc-dd1c-444c-4ff4-08dd885a53de
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 02:46:09.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqFIoFQeiFh0QTuZORgfZYtVjt2y3m9Dsfg47fr3qivQBfhm3iX5cuDt8VXnzouJpuKd1NqvEWLwRtyfWPYM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAyMSBTYWx0ZWRfXyTWyddRdWHKl QzYXHLR7HWKfn78YOQ6d3mL2Ogb320HvzQecPUvsGFNyVRYAeZ81kIeoA4WIxEbvkSZfatk8CbJ k5RL1QtzJqfC6f4fi+XJ7E/hh6PVzEZVC8/RlUnz2GqH64Db1YgjMWdhXmE9ymsD91QxhGH9BgV
 ON+LvoEJ3VRjrMKFqRqEw+2RUGbdAK25/wcinr7w03zqg/Kl+elFvwllDjvge7H2H0po2epA001 zdCU41iNabin6NXLFPF122YvCxQ5rWZdhMWvbKgimInuThk5DTvkYicYuE6zxrnAdMYpPPpRfvm nChVJ8Sdc0MQjGvSOCtSsLFRP66cZ8AH/goY3U1ovH+dLaBlcZaZUD3iTb0LMJ/YqlwA8ZcZqRg
 2+/43NhCQWlgKEvA9g7zmD6zBX7z2mV0nzzWPiSVe7P58AanE28u1WoqNAJt8GJ+W9TWhzKP
X-Proofpoint-GUID: q5Ml9isTA1XfHaAWGr6B0IvNX7qkMzG1
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6812e082 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=XXPTK-dxorRYMydK5xEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q5Ml9isTA1XfHaAWGr6B0IvNX7qkMzG1

Hi Prateek,

On 4/30/25 04:29, K Prateek Nayak wrote:
> Hello Libo,
> 
> On 4/30/2025 4:11 PM, Libo Chen wrote:
>>
>>
>> On 4/30/25 02:13, K Prateek Nayak wrote:
>>> (+ more scheduler folks)
>>>
>>> tl;dr
>>>
>>> JB has a workload that hates aggressive migration on the 2nd Generation
>>> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
>>> C2C latency.
>>>
>>> Based on JB's observation so far, reverting commit 16b0a7a1a0af
>>> ("sched/fair: Ensure tasks spreading in LLC during LB") and commit
>>> c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
>>> condition") helps the workload. Both those commits allow aggressive
>>> migrations for work conservation except it also increased cache
>>> misses which slows the workload quite a bit.
>>>
>>> "relax_domain_level" helps but cannot be set at runtime and I couldn't
>>> think of any stable / debug interfaces that JB hasn't tried out
>>> already that can help this workload.
>>>
>>> There is a patch towards the end to set "relax_domain_level" at
>>> runtime but given cpusets got away with this when transitioning to
>>> cgroup-v2, I don't know what the sentiments are around its usage.
>>> Any input / feedback is greatly appreciated.
>>>
>>
>>
>> Hi Prateek,
>>
>> Oh no, not "relax_domain_level" again, this can lead to load imbalance
>> in variety of ways. We were so glad this one went away with cgroupv2,
> 
> I agree it is not pretty. JB also tried strategic pinning and they
> did report that things are better overall but unfortunately, it is
> very hard to deploy across multiple architectures and would also
> require some redesign + testing from their application side.
> 

I was more of stressing broadly how bad setting "relax_domain_level"
could go wrong if an user doesn't know this essentially disables newidle
balancing at higher levels, so the ability to balance loads across CCXes
or NUMA nodes will be a lot weaker. A subset of CCXes may consistently
get much more loads due to a whole bunch of reasons. Sometimes this is
hard to spot in testing, but does show up in real-world scenarios, esp.
when users have other weird hacks.

>> it tends to be abused by users as an "easy" fix for some urgent perf
>> issues instead of addressing their root causes.
> 
> Was there ever a report of similar issue where migrations for right
> reasons has led to performance degradation as a result of platform
> architecture? I doubt there is a straightforward way to solve this
> using the current interfaces - at least I haven't found one yet.
> 

It wasn't due to platform architecture for us but more of "exotic" NUMA
topology (like a cubic, a node is one hop away from 3 neighbors, two
hops away from other 4) in combination with certain userlevel settings
that cause more wakeups in a subset of domains. If relax_domain_level
is left untouched, then you get no load imbalance but perf is bad. But
once you set relax_domain_level to restrict newidle balancing to lower
domain levels, you actually see better performance numbers in testing
even though CPU loads are not well-balanced. Until one day, you find
out the imbalance is so bad that it slows down everything. Luckily it
wasn't too hard to fix from the application side.

I get it may not be easy to fix from their application side in this
case and but I still think this is too hackery, one may end up
regretting. 

I certainly want to hear what others think about relax_domain_level!
  
> Perhaps cache-aware scheduling is the way forward to solve these
> set of issues as Peter highlighted.
> 

Hope so! We will start test that series and provide feedback


Thanks,
Libo

