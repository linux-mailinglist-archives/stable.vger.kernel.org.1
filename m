Return-Path: <stable+bounces-227902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H6YDpvxwGkUOwQAu9opvQ
	(envelope-from <stable+bounces-227902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:54:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5022EDE2E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25EC93002937
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B0A363C49;
	Mon, 23 Mar 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IBc4zH28"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A011362133
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252410; cv=fail; b=E1hiAOlFm6wQM84HWapwdHprbedpxliQadu8ckJkyqbKd9751XujpBc/m/wG6byLebvIKt9Z4wPkEkf1NNj7L/TstnQnQMzeJS3IILyivRAhzhVkK4cLee5O8MTVovyva3Vxh4id2BKVRWnezvpx54GIDA0FqTUD3vqeQT3qfJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252410; c=relaxed/simple;
	bh=VksH8m/V9nvSEwTOflJKjwaO4A5CwtTFJfXOkJTJqxY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=MGpzB5qsgcZbdo51NTcr3uee1dQgN4bf2lmeXEvyQ6+oL1nqtfTL6NBApaI5I1O+oHYX8uC3MGP6OYgYRGY2jL9ZXPs69vTAH2ay2vE7EnItPbqxjPVcsSlgB4WJwFb87iGVr0QUx7ozknEqcgmxnKu1qaoRSFCBRPrsajNiJZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IBc4zH28; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N5oJL03736130
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=3NteSprLoJGq4C4DYJ+i
	grxhzxpVLLGHuCxm1q6A9FA=; b=IBc4zH28IIndl/ZtnMJeOGFdCS6gomtcNUOH
	Y1wnWIoHvUHJBquXCjjGpua7tPUx0ZmT0h4hrfeve+C2bsPuxO0AyOF4jbRox7Xd
	AyfN2kyxqIOaAyJn10H0GkFSLk19QFlEbpEqMTb2oOKBB1PDM381L2VM8k85pb3i
	8L2+35FS0FykAAQT212sAjBEomYyQHSkHceeYvGcTHSAVJTbO2x27d+p2Wm8XhYu
	DNHZl399O6ET81ROLUiwd1fwUulqnydf5Jfg7lUtRNSxbDYo6jVIga9KcgyLWhTV
	Fd/NFwlv/vZfVrKIhZXau79q7LALkbeeGxOtaCa0bHzDW529Xg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky9cud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsgTNK04dwG1eBXP6+3AXYA2F1+YJP3+D04FdHFJWqj6fCKjeE2fZ/je8CGWYjfTk/WmemZx/ofgcErOJ9C4Rb4Tj7B+7qz92fp5BNQctb7SqNXqEVYXWhioQDzCgqVBCWNbjx7QAmOrbrHFSqLwNYf7TP2JB5zzr8cXq3RrIjBt/LX17qlHyrYZaDRuI0310BPN6n3j+7dlrWw0HiHgIwztxVXXW30usNJUr3lnuhy24EqJHS9U0WDJaopNFNJbbBrI21NVBh3VaQZtxOpNyW22KXZY0TMYZE/9qE3ynODh9b90aTjani5CzXqC60LXCcYV32uJFGnBan7OwS8hHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NteSprLoJGq4C4DYJ+igrxhzxpVLLGHuCxm1q6A9FA=;
 b=FpsuSo2SoQh6wE7Co+YpsUvk5N/xVSkX092q1Z1FVMZqIFztdZgTdJGzyv9zCF0b3QbbkolEIlfzvuRn1Zk3Z1ybIMfcMi/EBFTdyDx7yERDUc0rels0yUzviLB4BSTKnps2pd+eOPaBTpF1J7UpKzXmgUpSycZbyISnFScp2LAOBsKdN43Nn9imOcoijCrDpuGDVKmSwjbqai05drPS3fMYNRVE8gt5TwQUCsTelbbRtjygF8IvZbqzCmRn/KX4wIt8ZBBHuQv3qLaIAUW+B+nuhj7H8DSrlitihaF+b0h9oJ68ENVepp4FxwjJp67HLD2uCiEuhiHJSWlxXqCzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SJ5PPFEF62BB3A3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 07:53:16 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 07:53:16 +0000
Message-ID: <55ce141a-09fa-404a-9932-1e1d4b0ad034@windriver.com>
Date: Mon, 23 Mar 2026 15:53:09 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Zhang, Liyin (CN)" <liyin.zhang.cn@windriver.com>
Subject: Backport request for two spi-nor otcal dtr odd length/address reads
 and writes patches to 6.12.y.
To: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SJ5PPFEF62BB3A3:EE_
X-MS-Office365-Filtering-Correlation-Id: 9966eda8-9050-439f-5c2a-08de88b13ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PGjHIOcVJdsAcmeq+jV6EszdgIAgMChQgNkruYsseC+jKgNPU03EhUXqYb73cQqPxyuvRM65vHkDu5snFEq+QFnUm0y76z94EvtjFhhXWGVKYqVPRMbt+g71kCWa+0zyxCedmV3tedp/uejjG0tZORI11LB7V4Ry0EozHLa8n9xuacksMDGOgFPoWfknXGt7Orvp25oOTkV+vTSANQAvEGkgUzR+K0se08vNl0c3bftIdy625IFUZx69w4ZqmRnG8AxwczXQLrQbPDaVltUt3wGnrDCG7UeRP6vk7L4SwvQI6d+xU3l2HhnLDZMf7/fC/hIUIOVIPfmao8Mh218WgXkaQPzLM+hGsY6FYIlLUcwgzi7XySUGdaAuC3hzzRJMibAnCmeJyisg3soOQ2L6xInz85SkR2DlPF4kXTtCFCNAKtiEodfy9adiHUCgYmI/rMs3rH1N2DEdT4mpUI45OdNA9MG0yD/n/o/z4ZUlpddl7PswxLitooGvUFK7osrNqlo374nmSqk+TUOfh4IxwXw4nEz3aFVF1gHbrO2pldP3wWAoPBAYIgVNwzYbJiB+1mbsgu2IKEHmg3iAoviBCq55BwA4wLjiY1vqvt6swdjCc3msV6TofZ/SA30ExTB6ygcYYeTjFWvT8fVpqKJzOpdsbsGRm76w1d+810tf4TStCnj8ej9MVHR0714Ih7U/eO/RZ9EUGFlP+GRwq2rxTI+AvDN7X739ZHTmy+EAsnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdqSHQraWpRRCtrWnYwSUowRHRtYnNCYXVMMXN3RHdBS0pBb2ZPczhVeGNx?=
 =?utf-8?B?dnFSaG85K2hJNFp6d0ZadlRDc0JXTVhtR0Z6NS81MExYWkZObjZ1R09xN1l5?=
 =?utf-8?B?ZzZDY3pROE5od1RINnRub0tZK0JWZ3lGdDcwVUIyMVVrdXlSbUhHZFhROEoy?=
 =?utf-8?B?RTlXS0g4c0JLSUhQc1hiQUNsWUIzaXRqcFY2b2pOcXJyalhmUVM2UGxZS0ta?=
 =?utf-8?B?U296VHE4MWVQZjVyRnR1R0JJb28vU0lTUDlhR0RNR2YrSCtuVU1mN3JDemlr?=
 =?utf-8?B?QnJhVS9mQ1dlNDdOSEdqRWdrR2lLY1UwWEZuQzc1dFEvOWJnQVp5cDJ5ZnB4?=
 =?utf-8?B?ZTVyR3JOREo2REFzd0JWcFdVYm9GMWVOTXBEZ0x2VE5wWFc4MDFub0hPWmMr?=
 =?utf-8?B?ejVvbU54Mmg3TjUzRGRoam85RzZ1aC9wQTNxdXZEN1l2Q1BuMElZTEwwMU1T?=
 =?utf-8?B?TTAyeEZiV0VFaHZpS1FkM01SUng1RHBvYVc2NWhZMjNvN2lZVXl2ay84VmZH?=
 =?utf-8?B?RFd1bnE0U2JiWGRoSHFMajRDMTNLUDVlUDJhSDV6RUxxdUZTbUtLbDMxRm1K?=
 =?utf-8?B?Ni9HOWlVMzZONnBGUEhKTjVkQlRPQWJpcWdWekcra0laUFdwb05FMDdSWkNv?=
 =?utf-8?B?LzdXUHBkOTFpNy9aeTVZVnhKRzVjTVJLaXVGSzFQSC9kRXVNc0JQamNUbHk0?=
 =?utf-8?B?TVdOUE1mVWlaamp6b2VPWGZEYzNGODkybk5XWlpSTGJ3VXBrSHNoVGRBZml4?=
 =?utf-8?B?cGcwTGIreHRjQnhFYWxoVXBmcDBubTZQaitUQ2RML3BIOUJFVnlPUkh4VStZ?=
 =?utf-8?B?RjNtclJvQzV1cmFqUU1RZlhpQ0tEOVNvaVFsZ0VXMkFRRU5kd0RuRDNRc2ZV?=
 =?utf-8?B?RzFHRERldHNudjZkZThwRk1Od2VJOEZVMjJ2SVRodi9NQXloMmdYcHhlWW4y?=
 =?utf-8?B?TmJDN1lKMHdScEIxS1VYSUU1MTdESUVCMnlzOGx2d1NQaGlnRGJQa1lvYU1u?=
 =?utf-8?B?NFBIa2tOK3FtUmJqM0gzTXJ0RHpQbGRBS2prMDBqTEVMSFE5S283VmdjWHRL?=
 =?utf-8?B?UFBORE9xWWF2QjF5TGMxNkczM1BwcGhkN0Z0VHlZbE5OemkrM2IySXBhdXZF?=
 =?utf-8?B?Q3hreWxGZW9KUldSaGpnSHZDVDdJMHk1T0RoNXpRLzlmY0gxcUhOQUtBcFRu?=
 =?utf-8?B?WGJNeC9zTEVJRXZONVFGbDFjNnZJUU5LNUFlN0gzN3h6VnN0TU5IYTJPZVRM?=
 =?utf-8?B?bVA5Y21GN0xWMllrTERtNTRvUVJqTUtNamt3MFUrM3F2V1BWSm5SUm5vbzh5?=
 =?utf-8?B?R0VFdnluejZjQ0FscGZ5ZHpZVXJuS3N4K1N1K3ZTVURWNGhPUlM0aUZpU0NU?=
 =?utf-8?B?d2l1bytRZnhaZTVadFk0RXBwT1lxZnUxSTZYcXZ0L0ZGWGM1NWxhMHZsVU1I?=
 =?utf-8?B?eVFGbitPcmowQVV5b0pLQ01SU3VrcjNScXpqMjQ5VloxQTVWQTM2eUgvK3Fp?=
 =?utf-8?B?dkQ2L0YzeGh2NnNBdFNDSDlUakhHbGxlK01NVHZYcWFGTWhGK0d4aTJud3Zw?=
 =?utf-8?B?OVZLQm1nSGVGMGFQc3NkT05HdU5DcUF1MTBTcjIwekFDSk5RUmpCRlo3Nm80?=
 =?utf-8?B?TFN6b2RXYnpJMFB0SU9KTE9mQUs1OThzSUxpczZYanoxekFLbzArNit1bzFY?=
 =?utf-8?B?c1FOeFNac0E1bmRVZ3J4K09TK0pzR3R1Zmx5dDBWNmNQU0FnZml6amloWmlV?=
 =?utf-8?B?THZSY2p5Vkt5ZWRUUlR4MG14bUdBS1R3MjU3YTMxaHQvNUM2SzdwejdlUnI1?=
 =?utf-8?B?YmhyaXRKWTFkandTcjVMT3lEVTB6WXpFNkRjT0poTjEwVFFaZUxEWXFFcC9M?=
 =?utf-8?B?bVRzT04yNnl5bTVsT2duYWphR0NPZGtjTzZIQTFlM3JiL1FRa05tSVdXQjc2?=
 =?utf-8?B?RklkdzU2dTZtVzYwNkVxR3dCMXV3eDdKZzJhQTN2STg0UkFldWtNSTVhWkFB?=
 =?utf-8?B?WmN3SU1jY3pkOWs4eXFjUUZWSDZrVVJ0ZkEya211c210MzdxM3lCQ0t1SDBm?=
 =?utf-8?B?eWp3U1BYYjFZM0FYeWkzbjU0bThieVlXektUYU44WFUwU2VaL1ZnRWc2aGJQ?=
 =?utf-8?B?Q3ltcGx6WnplK2V6d2RMTHJlaHVVaXAranl3UGpkSHhaeGQ1QkFrWWEwanhO?=
 =?utf-8?B?RERaN1hDYjVVZEt5ZnFLWjFQcGpCSjFERXlvU1VBSUx1WEJqRmU4SlBzUFNn?=
 =?utf-8?B?V1VGOGhzVW9nRzlKR0p4VWNETDEwRVNOVUJCUUs3VzRqVkpZanRnMDdOMGV4?=
 =?utf-8?B?WDIyUkNYVzY0SWtNZ2VZb1RUV3U1aFEvVFZzZlhjdURxcHNFSFVsVlVSSm5R?=
 =?utf-8?Q?Ad6XVa76JLct+NZI=3D?=
X-Exchange-RoutingPolicyChecked:
	LfUoHdYYEJ3iF5UbRx+c8a+U9qTXlkUqeUUT8FI7HyPn5pM8sOsScgyEOo2Gcs/038Q2WAq69IbuQGDON2gGXSnMZ/tNaC/x5FxrSNdsMwnIpp/TeUQ55njzgLZf0lFTFn/xGWlWXg2ESYlIVKMURtzBkVkjZVVkGiAyY6hBTWL4bhNfH9fmaqNaYRnRmhebjOXiW/zFm4gYQfLzpZmrFR21+0jGFHIQqThDdkytqt15CZ8nmT5XvimaGQCHvnV+fGinsaFYkm/ImpxAD40fdTJm9bh7bdRx7xenpi0eEpYk2GfF3/+dOq7ljvu/WiyoObucuvfZs6DNboxqLadWNA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9966eda8-9050-439f-5c2a-08de88b13ddc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:53:16.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jzt420VG32zov7tTBwPWkXdPl5AsQL24aaS2vS8kNWJHNp/+IG6/AdNsSsqzIyYkMAjhSZ0/F3wqe/rnpNDgAv6B9Vl/cMkFpu3p8Zhsi60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEF62BB3A3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA1OSBTYWx0ZWRfX6aIVbvu1OYRM
 zCBIMDu5ZYovhCVBVK71ODiEVzSCteztEWmEcsl15cTjAEBoFhcHh4ONrbrHwyNP8lOf9iEBJBx
 YdnQXYSGeIcI24hXINq9dVIRGD75/OIoXo2v2d8JIHwdLbV4VVJqT30dlB3uCApgSJYzJq30vB7
 I3h5P93uYKWAWxrJRrNLWYuVPs1jQ1Kn/OqWxG7mRMqUUYc+JdPhuhEnfUemuS6Vf3YfDB3yKVt
 Rb3ofomokYz73BmSulUfk+kaNDZ8Kt7hNiIDWCRoFI5OySlkKGTAH5HFH1fP5gMRuzbUK6RRKLr
 7naV/ZxmF2cYQsBmWQjH2AFVIHxgFVl5Bzp9SWeHAMc6ms+m3RuSanODqmYFnkoqsXaGAQqDu0L
 /LCuN51n22W7rE3lzdGvwB4gsmm+aayj4HKXUCNIMt0kEmXKUd/GoCVs+ndSAq6jOxcp1UnxXUA
 SlYS7W/bbfBoXu3TLww==
X-Proofpoint-ORIG-GUID: zgtAyPI7bsjGneriAbeXS7win9B_HwHo
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69c0f16f cx=c_pps
 a=cmOV2DJVr4PNgr62m/JMKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=-3IGNhC0d6E5WCn6ql8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: zgtAyPI7bsjGneriAbeXS7win9B_HwHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230059
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227902-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE5022EDE2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi stable team,

Please consider applying the following mainlined patches to the 6.12.y 
stable tree:

   commit f156b23df6a84efb2f6686156be94d4988568954
   "mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode"

   commit 17926cd770ec837ed27d9856cf07f2da8dda4131
   "mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode"

Both patches are already present in mainline, 6.19, and 6.18.

Both patches fix the same class of bug: Octal DTR (8D-8D-8D) mode 
requires both the start address and transfer length to be even.
And we actually encounter the same issues on different hardwares which 
supporting octal dtr in multiple earlier releases.

Now these two patches can be cleanly applied to 6.12 branch.
Would you please help backport them to 6.12 first?

And for 6.6 and 6.1, there are small conflicts. I'd like to submit 
patches later.

Thanks for your time.

Regards,

Liyin Zhang



