Return-Path: <stable+bounces-119549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE417A449B0
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE08424600
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A31194A59;
	Tue, 25 Feb 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="GFPx8GUp";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SafQg5th"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28A19E7E2;
	Tue, 25 Feb 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506856; cv=fail; b=ekBN5MZ9M935PZES+e0lA8mkrabFP6L8Pmrvs7cKQCRBzJxf0RDw4H0MGUdxGI47+8sKssHL3ZwhnUH9XOr6i45769cPZNvDJHSXu6lnClOug+rw7cj0bH/cbUeh/X+js4CO/hWzSOmdbPM6O8Z61VzuHA8KLewbszFhOLCiw3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506856; c=relaxed/simple;
	bh=inDKl5I7rmGDWXemtW11cQ0S+5iURsUBzXjcBTTrhfk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p7k3bxOjQuWYApRzfrnhLx8mW6tuqkfe71hgxJYWrnqMPBeF3HrpRMhog0Q0ZxhRJ0vwdNNr2r5qaONsZNYuvm920ORu20pB89AMOacZTqnHxxdB2iq4XVm1M+nmDzyUKvR6FgjK/DH8ch/bQtxAXu/lzHegXtc0AcuZ2h/XgL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=GFPx8GUp; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SafQg5th; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9qHTo027208;
	Tue, 25 Feb 2025 10:07:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=OYxum45ABYGDG
	Jyc5fHAIczfSag75Xa4VyDB5dz4gUk=; b=GFPx8GUpKfeQ8A26tlEytBwBUD/8b
	AXDKtB0H4eBnOXlTFggLtKWEXc3rp1aYL272cm+dASHdBczYPZEc1cgRqAQBZZL7
	8jQ0sPsenaagBdowZj318U/az8FmKYRCO70XU4/z3cLO5AoabwWSVYtE9KD92BOO
	Cm7ilUtrNUVXpTw3Rja7i/jHA+IQtpWI3k6KnZ+XTYzGkjxvwXTAnOArCBAqa+cx
	uu+H7A5EbAOvu5XMDs1F7aGc6q7Ptlhy4Jqa7gPVL2bZJAd99jIBV8Liu8lc6395
	0+bmCvsmvDSyi6QdD58BW8z5AjY3CGnb9q3BqLqSPJjmE1mVgPJY+vkRw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44yd0d7rej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKtCuwlktmfS9pqdv8bFkxkPdnj0iQjTvj1pvAXJnP7S14QLUT3UiemJ43mdRfD2/13sRKNrRwGCuFbNw6Ws+M4vC0OLq4w3uSm1RDdCzsVtgLzwxsICVljPuQk1+B1oLsuoiqXWLd2XzqqAr/iUAJrebhaaNI7yvuFmxTbjVZ3wiZmZOn3yoF3cOPsPRoHvyJm3/okrFQF9UVOXNmmu+FSdBLe3DR7x94LBQamEcxwuExgwJFoDqeIhPvSjQAj14Z5/vxyZoutEJ/OdDM+2Reu1qKeAxK0ZZoWgnfB42sXOZSOfy9MPr93NVBgLOz6IvLnPtO6leia82YOBhIWR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYxum45ABYGDGJyc5fHAIczfSag75Xa4VyDB5dz4gUk=;
 b=VVmSGPgdprAB99RF8/uEoa9qxzDf7AicUX+5DMafKB8mnkh2k4FvoMNGt15Vy/Kcckn4lcF7eU4YFDBTBAvPCCHb34z8OCr2NILSkvmR6rCiAykf6WIpkkLkrratccPwE59FgvMsRjlQg7VguJSwvNQ+pmtGq1JfUF20TQxlKGHMozSyBgi2NbefMQUGdI3G9OP2rubKpjPrcJgQQW/fYUE5zyMjBMZa9myCASxGB+03RBjjvOPGQEs4irqLOE36/uvL22AH9PIxTa7d7UwTWcdtB90su0yOf8h69lLLYcRgHSC06Amq8aQbYEvZqtCOFDNI2VkgFeZaKjQmxPDkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYxum45ABYGDGJyc5fHAIczfSag75Xa4VyDB5dz4gUk=;
 b=SafQg5thot3iVWIgUyn4giX2H/Z3paB9/neRno4LHzAoT4Nni253nqBthNzpRtxwIRBsiV7Di5PI6MYHUM+vo+QyxSHDML9crLiqz88xrpBrt7rHGBZoddqmRWayqUBVTh7H1YP4t6VFYHA+/I/VHvW1ipoVOOivwucxqRSjOMkZkdw8HiF6q45qMxYrptkL24wk4Q2y252vh//lhi9bC7hjrtKV/q//4jCNHUUIdJRw8fuPzEJ5QoUu5NL67tVuyu2Ko/x0bh0YvF4I6JyfqdaykNvbgprmJ41Hoe7/Orb+sKfq9ZWn2/2Ls2ymsF8BQQGE2qbOaeyf+3fEHlKeUg==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by BY5PR02MB6867.namprd02.prod.outlook.com (2603:10b6:a03:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:07:04 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 18:07:04 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, Jon Kohler <jon@nutanix.com>,
        Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru <rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH v3] sched/rt: Fix race in push_rt_task
Date: Tue, 25 Feb 2025 18:05:53 +0000
Message-Id: <20250225180553.167995-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|BY5PR02MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9a4bce-6165-4742-59b7-08dd55c7354a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWhEcDA5Vm9PNXNrOEkzTVJhdVVKYm94ZmNpQ01DREoxdUprYkRhV0Y0Y29o?=
 =?utf-8?B?RE9jbWZPMjJ6MzZtK2Ywdm5ob2IwWGZXaVhmZ1YxNGg2aUJ3djJ3N1JYTUph?=
 =?utf-8?B?VEx0TGFCZHlaMGlDUVhGY3NaejErVlYya2JRWS9kUExNS0pEaFkvVExzT25H?=
 =?utf-8?B?RXQxUTVuYjhiREptSVZManVBNmRXd2hIOWVmckFUOE9OeVY0RVhBTG5jWUw1?=
 =?utf-8?B?N292VW5UaHJhZTM1VUkzMHdaTjkrb0RGYzBTbnRXZnJaZzVjSDRoZ1lkeitp?=
 =?utf-8?B?bXJRMXZxbGM4eUpEMGk2TW5VWFNCMUZqcDRLRUpOMEE1ZXFHZThndzlOcVJ3?=
 =?utf-8?B?S3hZRHdPNklYYmNuak15NjFIem5RU0VVQlJ3Umk4R3lDVWN5Z3NSQjhvaDl1?=
 =?utf-8?B?M1dRVGZSNUEwa2VKQnRRWENVWnArRWZUYlRxRUp0WUFHdzByeklEK05TaUpO?=
 =?utf-8?B?ajdHWmZzK3VFbVVDQk9PSjlBS2hjM3YxeXNSMk9KOHhEYXNUa3VXN3h2V1RH?=
 =?utf-8?B?S20xUjdwU2JFVUtTRjdwRHpXVC9HcW50b1dpdjh5L1V1blNGQ2lUYncvaFRF?=
 =?utf-8?B?Vk94QzVZbUVlWkdpaDdDR0ZUVCsrWkZqWjBBeTYyd3pRbUwycGxZNlVpMEZC?=
 =?utf-8?B?c05OWjdybzBuSERxRG9pUVNVakRuQzRVRCtUTXlLS0lCTVBSWTBaV29wbE9E?=
 =?utf-8?B?V1BDMXVVUWFpMXI0VGpyWUZ5WG9yTU1pbmZUNkViK2VXRW1lTlRkeTQ3ZFph?=
 =?utf-8?B?VjVhMXVUQzEvcTBxUFViMklkRm9rSzh2eE4zWHRFcEN6NHc5YW83UE9wWVBI?=
 =?utf-8?B?dWNnRjg3QWJRRUh0SDArSEhuRU9kQWlWR0pNcDVDQUFQdy84VCtYS3pLd2pZ?=
 =?utf-8?B?bityVlpjdVA3cmVKaGFGWk5sZi95U2pDV0Y1RUNzQmpINExCZzRGOUJHeWJl?=
 =?utf-8?B?UnJoQUlueUp1VThwSkM5Um00MWJCSzA1dDQrYjFYTk9QblA3dktvclJocmZB?=
 =?utf-8?B?SlFKbDlYODYxUmxYblNUUC9LZHp4eGdxREg0bHBDZ0xJLzlRbU14Lzdvb0Z1?=
 =?utf-8?B?MXRZZzZNTEdHWFRFNzR2aTdDZDFGOHY1ei9OSGtnU2Vkc0hCTjF1V251cVd3?=
 =?utf-8?B?UDh2dmR6VGo1NDZtdzhmSjlMeDAxd2FYWnhiTktFa1VoOVRaejBOSGx4UGl2?=
 =?utf-8?B?Q1lwQkIxODVSNTZJN2RwS1A2NzFRRStnYXVQWTArNStOZG5VbjI3MW9QLzZ1?=
 =?utf-8?B?SUxIMzdGMjI3YUdqRHByZEhBZkt4Z1RMTU5SY0xrRHkvcEx1VTE3REJ3T1hZ?=
 =?utf-8?B?STdsNklRUmgxT0MyNmM5Q3dHbWpLT1c0UzR2bEJZeUxUWVNDOUM2YXRoeGt5?=
 =?utf-8?B?bzRlNFl1R1JpNjFIYndQNk9QYVpBaG5pK3dvaGVUd0p0UVFYK2dKbWJpZk14?=
 =?utf-8?B?SlQwdVN2YUNLTmRCUVozMkQ4U2tTQkp3YmgybDQyMUt6NEErUWVyZGxBWExQ?=
 =?utf-8?B?TGZVWXV5YWRuTjBuU09rZUhSTWpZWGFIOFlPWnBxSm9hN3E4RGxPeTNvekVT?=
 =?utf-8?B?WU80bVlMYkIvMjFBRVdJUEJUVkJZN29WQXJhRG9pQTgwL21pTC9ZVGFNT3Zq?=
 =?utf-8?B?WEdodFdLRWROL0FvL1k4cy93a3Y5YUhWSE9aOTdMSjFNNUJ1OVhPcUJjZFpW?=
 =?utf-8?B?NnhTN2ZTSmxJVUx5SGdDOHRWTzZtYi8yYmhjazBJamQyS3c0SFUyVjV4N2pV?=
 =?utf-8?B?V1ZxcmFkcmVjdVlMSGMvS3BaK2lxWlZuRFBkSjQ4bnFiazF5eTNycGplR2ZU?=
 =?utf-8?B?V1V5NzVEV0JwSXFOVHlEaTZabXNkMWM5UGxZallhRVlhMURGL3l1N3FpRFdi?=
 =?utf-8?B?UTkydTlaUlJSWkowbk9iaTZmZE9XV1orY1A4WFhHNkdRRUFRb0pmZE9lQlM4?=
 =?utf-8?B?VVdHR2ZtbWZYSTU4RzV4WS9FVXc1MFNZNGVMaG1hbEtTSnhOL0d4VlJzZTFH?=
 =?utf-8?B?ZXVLSW9LSEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDZVSmJTUDVrTWpHMlRFRWlqcGlsclNtcGZKUHhEdlJtTUIwRUNBU0Z2NjZJ?=
 =?utf-8?B?d1FyVENKemJURUlZOGlUWkxOL2RscmU0TVBWSE0rYjNCbEFOM2Y4Y29qSUdm?=
 =?utf-8?B?MmF4RVlxcGV4clFGKzNmaXdlNVdNcklscHJteEdQTTlxUVJKOFNITGd6SGJv?=
 =?utf-8?B?NkZDTkFOZHdPUGQzWHlIRDZYN1Fqc3F1MFFOVHpJVkZXTnlnVklOY216TVIy?=
 =?utf-8?B?TkVtQy82NUZhZGRPMGFYaGxvOE5JbW5kcTZpcjRBbWxMUFFLS2VjeTY1djZx?=
 =?utf-8?B?bGlvbDZ5Q3BkY0Vkb045YjhZMHQyMFFUZDNEcG44NHJ5UFJ4NkNOZVBmMmtT?=
 =?utf-8?B?RGFuZlJlR2pUMGcrMmtKU1gvY1E1cjloTStzYUhjcURGMlJXTk9kYU40NGZn?=
 =?utf-8?B?WUFManlqS3pCRXR0RDBucElTQXpEZi9qdG5SYTBOcEhvZVFUakNQSWNYK1hp?=
 =?utf-8?B?dWxBUG8rd0pZMDdReFlMeHIzdGoySWM4VWQxUG5CQXQ2bDV1eWpzcExMbGcv?=
 =?utf-8?B?Y1h5VzhGOGw0eHBXYWg4NW5iMzJ3SVFxZHNLb0FzNGJOSHNVc3IveUQwZjBw?=
 =?utf-8?B?Vm84NEtNZXY2MWEvOFZMd1FzU1R2Y3hZWFo3aUVRNlRaR3BWTS82RUt2Y1c2?=
 =?utf-8?B?bldTQzFnZ2ZCNG9rczJvZXVPUnZZaW1zUURudWhKaXZzc2JxMXZlVUVUWFVP?=
 =?utf-8?B?bS9EeDl1cVFqNWkrTlNqN05oQnVWeFQzeGN0dFF4MldJVVkvZGEyR1ZZNS9o?=
 =?utf-8?B?b0VuUjNMam93bXZtbENvcTd3ZUF2WncydTV2ZG9od2ZQMWdOLzdBbU5NNlFL?=
 =?utf-8?B?R0l2S2NQNDFobDJFMzl4TVV6OHJsN0szYS8yMmhnalo1N2VMQW1LZ1pYMXpK?=
 =?utf-8?B?NllRbEZiak81SE93SWNoRnNPa1NJNFN3ZmcwOC83TDBhUEc3WHJQcG9vQUxJ?=
 =?utf-8?B?R0szV3ltRTBSMmZyZ0VSanJVbGp2ck5tN0RDMFFzM1FZWmZFbUY5RXJTLzFV?=
 =?utf-8?B?TmZnbU9leTR2cytYUGxWVXBrNFlHOFAwdy9YbUVHeFFzdCt6RFpWSFRGQ3A3?=
 =?utf-8?B?NVFIdUF3a1Z2eG1UMVJ6bjBCNjhFWmNDd0V4NmxicUJDbEdrMlNSMEdKK1o3?=
 =?utf-8?B?MlVPN3FLOGxXb21yQ1dwVmc3UUdUSDFod0YyakFjaXJGblJVVzRLN2k2dEVO?=
 =?utf-8?B?bFFoYUplWEZQVkY4NE1lU1o1WU9WK1lQYmFzbHVDWHpXS2kzc3RMeXZxK043?=
 =?utf-8?B?d1g5VG9qNWRDem9wTnRKOGZ0VVhTcWtKTWxBZ3p3bzkrY2syblhmQ215UlA4?=
 =?utf-8?B?QlZrampIYi9RV3dPL2JMVjZkVzBQMGRKYzdKbFl5eFd6MktGNndLSHVhUVRa?=
 =?utf-8?B?ZkUyRnFqTTJhNUVmL3o0azJrS2FtVXNjbjVOY2Q1UDlxTzhtY3RqTXMzWTVO?=
 =?utf-8?B?eEQ4VWNIUENZQ3lpZVp5czdobVdGUEkrZHRQUHI5YnNodWw2K3hNSXdlWUpr?=
 =?utf-8?B?cEZmUWhiNGJXeW9jOFJDd05LVGFIK21OdkRhSlBOMVBDdm16N0cxVCtwWjZw?=
 =?utf-8?B?UzVIWGRKYjNyZ0QxUERWTUUrU0lGNkg3N2luQzVGNmpEcXlOZEpWbG9TQmZQ?=
 =?utf-8?B?N0pwaU16M3BEaTF5VXh4RW93TCtqWHUzTDRTQ3NNWEVySHg2U1VJZGtjRmVY?=
 =?utf-8?B?RVdSa2wyb0p5aVlhMm9hYkFZWnNyb1JaNm5kekFCenRmS29LUCtWRGIwL0Zu?=
 =?utf-8?B?RTVNdCtwWGVNVWp6SG5xRmRlbmNxT2dvVEZqYWE4c3lXWmpBQk15TjZuV2Jy?=
 =?utf-8?B?Z1JkZE40bjdHeTV2Y2RNWEFRWENYMDF6MVhTbDNQRi9RQWNKY2g1WG5xNVFO?=
 =?utf-8?B?bk1MT2J5d3owUmV1aGpaaHh2SkJUb2ZHV05GN1ZWMGdUbUVmU0U3elBxbUhL?=
 =?utf-8?B?cFFJY3NVeHdKQk1BZU8xcXRjcTF5cjBYV2VoZWlkNEZFK0gxNE5SVi8xbEl5?=
 =?utf-8?B?ZHFzdTVHOHNhWkJteDhObnBNeFhFUzY2Zkt1dEc1Y050c0tQT0lpOHpvWnV3?=
 =?utf-8?B?Y2pjWW5MbWFIYUpWcWlDb0h5NFBPNXZBVUZMLzhqNEJTNWk2Y2lFc1Exb1hn?=
 =?utf-8?B?ajlFV3h1WjNkdE1ZS2JIMGlKYmJDTmdrUCs2NXloRC9jeVI2b3hnakFON3hT?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9a4bce-6165-4742-59b7-08dd55c7354a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:07:03.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTQyOHJt3IMVZznMrF1Qj5Urt0ENGD83A8DbqZN7JUbMWtEhW/KKsLajAdnv+B872Flsa5wTsa5UoGXnbZn1iH9KUYkZuBzedR1D7niOoDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6867
X-Proofpoint-GUID: 5yELP8gG4CTMm9M8kiLpaI-Wa-jK52oR
X-Authority-Analysis: v=2.4 cv=X/6oKHTe c=1 sm=1 tr=0 ts=67be06cb cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=meVymXHHAAAA:8 a=tRswbNlCWb7GgJ6GzHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 5yELP8gG4CTMm9M8kiLpaI-Wa-jK52oR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

Overview
========
When a CPU chooses to call push_rt_task and picks a task to push to
another CPU's runqueue then it will call find_lock_lowest_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.

Crashes
=======
This bug resulted in quite a few flavors of crashes triggering kernel
panics with various crash signatures such as assert failures, page
faults, null pointer dereferences, and queue corruption errors all
coming from scheduler itself.

Some of the crashes:
-> kernel BUG at kernel/sched/rt.c:1616! BUG_ON(idx >= MAX_RT_PRIO)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? pick_next_task_rt+0x6e/0x1d0
   ? do_error_trap+0x64/0xa0
   ? pick_next_task_rt+0x6e/0x1d0
   ? exc_invalid_op+0x4c/0x60
   ? pick_next_task_rt+0x6e/0x1d0
   ? asm_exc_invalid_op+0x12/0x20
   ? pick_next_task_rt+0x6e/0x1d0
   __schedule+0x5cb/0x790
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: kernel NULL pointer dereference, address: 00000000000000c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? __warn+0x8a/0xe0
   ? exc_page_fault+0x3d6/0x520
   ? asm_exc_page_fault+0x1e/0x30
   ? pick_next_task_rt+0xb5/0x1d0
   ? pick_next_task_rt+0x8c/0x1d0
   __schedule+0x583/0x7e0
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: unable to handle page fault for address: ffff9464daea5900
   kernel BUG at kernel/sched/rt.c:1861! BUG_ON(rq->cpu != task_cpu(p))

-> kernel BUG at kernel/sched/rt.c:1055! BUG_ON(!rq->nr_running)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? do_error_trap+0x64/0xa0
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? exc_invalid_op+0x4c/0x60
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? asm_exc_invalid_op+0x12/0x20
   ? dequeue_top_rt_rq+0xa2/0xb0
   dequeue_rt_entity+0x1f/0x70
   dequeue_task_rt+0x2d/0x70
   __schedule+0x1a8/0x7e0
   ? blk_finish_plug+0x25/0x40
   schedule+0x3c/0xb0
   futex_wait_queue_me+0xb6/0x120
   futex_wait+0xd9/0x240
   do_futex+0x344/0xa90
   ? get_mm_exe_file+0x30/0x60
   ? audit_exe_compare+0x58/0x70
   ? audit_filter_rules.constprop.26+0x65e/0x1220
   __x64_sys_futex+0x148/0x1f0
   do_syscall_64+0x30/0x80
   entry_SYSCALL_64_after_hwframe+0x62/0xc7

-> BUG: unable to handle page fault for address: ffff8cf3608bc2c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? spurious_kernel_fault+0x171/0x1c0
   ? exc_page_fault+0x3b6/0x520
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? asm_exc_page_fault+0x1e/0x30
   ? _cond_resched+0x15/0x30
   ? futex_wait_queue_me+0xc8/0x120
   ? futex_wait+0xd9/0x240
   ? try_to_wake_up+0x1b8/0x490
   ? futex_wake+0x78/0x160
   ? do_futex+0xcd/0xa90
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? plist_del+0x6a/0xd0
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? dequeue_pushable_task+0x20/0x70
   ? __schedule+0x382/0x7e0
   ? asm_sysvec_reschedule_ipi+0xa/0x20
   ? schedule+0x3c/0xb0
   ? exit_to_user_mode_prepare+0x9e/0x150
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_sysvec_reschedule_ipi+0x12/0x20

Above are some of the common examples of the crashes that were observed
due to this issue.

Details
=======
Let's look at the following scenario to understand this race.

1) CPU A enters push_rt_task
  a) CPU A has chosen next_task = task p.
  b) CPU A calls find_lock_lowest_rq(Task p, CPU Z’s rq).
  c) CPU A identifies CPU X as a destination CPU (X < Z).
  d) CPU A enters double_lock_balance(CPU Z’s rq, CPU X’s rq).
  e) Since X is lower than Z, CPU A unlocks CPU Z’s rq. Someone else has
     locked CPU X’s rq, and thus, CPU A must wait.

2) At CPU Z
  a) Previous task has completed execution and thus, CPU Z enters
     schedule, locks its own rq after CPU A releases it.
  b) CPU Z dequeues previous task and begins executing task p.
  c) CPU Z unlocks its rq.
  d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
     lock) which triggers the schedule function on CPU Z.
  e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
  f) As part of dequeue, it sets p.on_rq = 0 and unlocks its rq.

3) At CPU B
  a) CPU B enters try_to_wake_up with input task p.
  b) Since CPU Z dequeued task p, p.on_rq = 0, and CPU B updates
     B.state = WAKING.
  c) CPU B via select_task_rq determines CPU Y as the target CPU.

4) The race
  a) CPU A acquires CPU X’s lock and relocks CPU Z.
  b) CPU A reads task p.cpu = Z and incorrectly concludes task p is
     still on CPU Z.
  c) CPU A failed to notice task p had been dequeued from CPU Z while
     CPU A was waiting for locks in double_lock_balance. If CPU A knew
     that task p had been dequeued, it would return NULL forcing
     push_rt_task to give up the task p's migration.
  d) CPU B updates task p.cpu = Y and calls ttwu_queue.
  e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
     p.on_rq = 1.
  f) CPU B unlocks CPU Y, triggering memory synchronization.
  g) CPU A reads task p.on_rq = 1, cementing its assumption that task p
     has not migrated.
  h) CPU A decides to migrate p to CPU X.

This leads to A dequeuing p from Y's queue and various crashes down the
line.

Solution
========
The solution here is fairly simple. After obtaining the lock (at 4a),
the check is enhanced to make sure that the task is still at the head of
the pushable tasks list. If not, then it is anyway not suitable for
being pushed out.

Testing
=======
The fix is tested on a cluster of 3 nodes, where the panics due to this
are hit every couple of days. A fix similar to this was deployed on such
cluster and was stable for more than 30 days.

Co-developed-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Tested-by: Will Ton <william.ton@nutanix.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
---
Changes in v2:
- As per Steve's suggestion, removed some checks that are done after
  obtaining the lock that are no longer needed with the addition of new
  check.
- Moved up is_migration_disabled check.
- Link to v1:
  https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/

Changes in v3:
- Updated commit message to add stable maintainers and reviewed-by tag.
- Link to v2:
  https://lore.kernel.org/lkml/20250214170844.201692-1-harshit@nutanix.com/
---
 kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..4762dd3f50c5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1915,18 +1936,16 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
-			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
+			 * migrated already or had its affinity changed,
+			 * therefore check if the task is still at the
+			 * head of the pushable tasks list.
 			 * It is possible the task was scheduled, set
 			 * "migrate_disabled" and then got preempted, so we must
 			 * check the task migration disable flag here too.
 			 */
-			if (unlikely(task_rq(task) != rq ||
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     task != pick_next_pushable_task(rq))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1946,27 +1965,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(task_current_donor(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
-- 
2.22.3


