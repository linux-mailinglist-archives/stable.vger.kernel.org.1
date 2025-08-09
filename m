Return-Path: <stable+bounces-166919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF8B1F5A3
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346E218C2D96
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382B27780D;
	Sat,  9 Aug 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o62sAaE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xw0AmsLF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0825743D;
	Sat,  9 Aug 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760303; cv=fail; b=KOhb/g2nU4xfm1faGUiLSJlprb1dWKB51IL63gfSitSl5ZaFq8H5bJLTT0gbQ5C2eNVHOwoYcMO1e9pygLltlVWZxnFODJmqCBgQykJDptnw5YEkjSeahlnzTLECSKxLb8lMedpwD4Bqj9LlNTV+MMHkaEzO8eMmiMC7OXWOAfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760303; c=relaxed/simple;
	bh=TlqzT2OeCyAJC2qSEl4JqOvLtVsonK/IQA2nn5AJKWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=a2G9085DV6xjseBykhyAdBgUwkDqIWSmIs/AVbYgVgRAc+lhK4OOnWvcNzdUO4XC+Q6NQARvWqjy2DbtAK5pbSJb7AKAZex0mVtBAxps0vp781ODK6MqBBOJ8V6vehUE9NXJvyvL0vJO1hQtv2zl+6XzNDqNUUHbwwpHLRhHbmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o62sAaE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xw0AmsLF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 579Ebr9J013461;
	Sat, 9 Aug 2025 17:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TlqzT2OeCyAJC2qSEl4JqOvLtVson
	K/IQA2nn5AJKWs=; b=o62sAaE+0THkXsJrBUGALbK9B9mBYbPkv11vIQSI5MVAn
	Ev/hJQgG1gMVSH2x93MUP0rc8Yu7QHh6VKoqoh6l5wOSNc+AXe7RIjH1FX1lxT96
	urZK8j8H13oJTG+YojeSYycv88lqEq4hhnCymEc9k/PnxnxdFoAIreJXDOMspZfT
	R0jKtrGy8OX+R4BEh+BTccLpcq1AanPd+1k8EfN/8qlM9HFgRn6QDVKk92TKM/Up
	4L9VsNb5ifU3vcpzXsn0xCow9I6L4owivs1INGCfvokHPag35l4FI3C7adjVu1OZ
	YMd3/T0jUXC11igrcSadls7odxD7Yqfpwn98Mpxrg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfrg3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Aug 2025 17:24:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 579GqrMU006369;
	Sat, 9 Aug 2025 17:24:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs6xvew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Aug 2025 17:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuVjpgrOEf8tV1CjVcMR6kquhIniSAsojlQbh4CSmsrKqdt5TZFtsKnyIlooEY+W162mtacCRQyER+ELkB84Wxz6hlOhgs3rMAwHxypZFPIj+yilQBfxTVpNAuhBpGIxr23CQJVPVo/cQ2p7/wsM+ZMLsUVtCNtX/GfP+1DbzWtvEQdnNAFLzK4mm8ad26cMxV/aeX2BETlm/dEpit/QPvG9o9AZ4RItqMzR8PcVG2WgttHikBi/otVcnMH13j7HM9MwJlLX3OSmxnLCIJtZqIKtymzeMyWlcs3xC8Jk8Co2z6TcW5+SfN0romGtU9rmuqRMMmtwEMgt2A7G5wDI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlqzT2OeCyAJC2qSEl4JqOvLtVsonK/IQA2nn5AJKWs=;
 b=i0McIP0w0R1S/yFn2C/7yM3yzAOLFLApMwSh4H2jG9m+U++a9rqd96Qnxrj+F5BLnYQLEkVq3/o5TqQYkbFNcuhQuD25SP0WBhXoIr8hDiN2UT/ubqPzIUUG5GqQLJuezl4FznzSO+DWJFBOg+qUc9COBZSIWEA4hfogKmhb1ik6qpP9j/EFNumH5Ll6uJxG/td6EIHk3WHEUlPB2aUi6uOaqzBz+NBqWspB9a6NDQP6g6buWW6ayjsTTftVS1NpjJlM1PxkXF1DxUxVsbhVY7ZuMkDL4T2WB7HC/371AXbJzG1SomwRmLzD9beWKO/kqey+1CRFNt93pwllKgARPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlqzT2OeCyAJC2qSEl4JqOvLtVsonK/IQA2nn5AJKWs=;
 b=xw0AmsLFyOsn3u6vC+i4LU7bFnO9FQnvFS/qoBtZQkYLVfY71mpIeArqblpluxHXlUv6uJSGBqu83GTQqJIQ7SU7at8IPAaB659k8r72oJdHlO5zWcVyvGgLfP3xxqXaJ/Kgy1/cDhwDS/yjoqVsH5tEB3TF7PdG8eaexgCcczk=
Received: from MN6PR10MB7518.namprd10.prod.outlook.com (2603:10b6:208:47c::14)
 by PH0PR10MB4487.namprd10.prod.outlook.com (2603:10b6:510:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 17:24:40 +0000
Received: from MN6PR10MB7518.namprd10.prod.outlook.com
 ([fe80::c5ee:65c9:c000:803a]) by MN6PR10MB7518.namprd10.prod.outlook.com
 ([fe80::c5ee:65c9:c000:803a%5]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 17:24:40 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "nnamrec@gmail.com"
	<nnamrec@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
Thread-Topic: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
Thread-Index: AQHcCVJ8jSPcLY6s30Ww+eUmhSpM0A==
Date: Sat, 9 Aug 2025 17:24:40 +0000
Message-ID: <eaebbc7e4e87faad586db3b6b119db4f273d1d93.camel@oracle.com>
In-Reply-To: <779ce04d-2053-4196-b989-f801720e65bc@hauke-m.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR10MB7518:EE_|PH0PR10MB4487:EE_
x-ms-office365-filtering-correlation-id: 1cdd4e14-5459-412c-3f25-08ddd7699f50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0FsYXpVYTBEanh4ZWc3cGNHWVQ5UHhSUy9teWlhY2wrRmF2dG8rMkRoYUZm?=
 =?utf-8?B?RTQ4d2lKcEtZbmcxKzcrQ09Ic3Nndzc4YUhGTUswVHVsY0swNGdoaG4xcHdQ?=
 =?utf-8?B?MkdpVm1FOS9WdFVzdXY0WnlXMEtjMzljYit3a0hWZVpYTVlGS3F3RVcwQUlZ?=
 =?utf-8?B?eUdXQVhUaDNlZkc4ZmdQSlRBWVpOaHFURWJTb2hzTTVSWll2QXA4cE9UdkJY?=
 =?utf-8?B?b3A5VVBnN2dqb2Y3TkJ5UUg1MnNrMVh0S3JwVmN5MjdoeWZCSmE1L2xjZmMr?=
 =?utf-8?B?UVZDV3JWbzRzVFAwVFBSLzFRbnlJc3AyNzRoa2Z4cWIwMFQxVnRBTUhMcXBk?=
 =?utf-8?B?WE5mK3RPbXBBai9waU90c2hpa0J6a3hNWE50Ry9UK25kWmlNaE14L3hvTkVL?=
 =?utf-8?B?aTJyNFg4ZzlQZnI0ekI4WWVnZ1BURzFFMjE4Q0VnQml2ejRiUUZaa2VIM1hN?=
 =?utf-8?B?TkpoL3dkK2pZK2Noc252Y2U5elJZcTRvWDZvekJlZzdobXlLMmVYcVpHLzFl?=
 =?utf-8?B?YlU1aVRrL25TbW91RmZWS0Jsdy9jVFdVVGgrRHQvSXg3R0c2MWZxdUtHZWpv?=
 =?utf-8?B?dXRLVzMrbkVwOHZRUkJncEU0VTFZeWhsVTg4TnZXbjYzSXdQVS9vT09Tbkgz?=
 =?utf-8?B?NTh1OVhaTTJqM3Mrb1RFdDlnUmRzU29xejZXUXBtdXk4M1NZaXVXMXRNNXNa?=
 =?utf-8?B?TGlXcUF4M3hRT09zdDQ3bEZWN2RwMTR6eDdranNxd3NWM00wZnZyUXdiaHp0?=
 =?utf-8?B?V2psdTNZWGNRU2E1Y3hDalRwTEdrMXFodnBZcTdsQzdNWmpvOW5xYWhGTmRG?=
 =?utf-8?B?WjM0K2dlN1pxbE1NYXY0WERWcnUwWG16c1c3TXMyNUtjcVhHai8wMWw3UDdW?=
 =?utf-8?B?ZysvYTdZekl3TE9uZ2RLbnM3U3hhUXk1QVZkODJ5RFN2NlRVS21zdU9CdDRS?=
 =?utf-8?B?elJXTVM0c1djWEdFZHhmMTRHZmhSUVJPTXJWTWlkUFFkY0ljSUUxR1lOK2p6?=
 =?utf-8?B?cUJrbnEzd3pRNEtWQ2FXZkVDQXhiZkFvVGp4TW03dGxSeTdidERmZnkyQTh2?=
 =?utf-8?B?OFdHUEIweGtkdmFNTnZhQzdxcTJjUEZQa0cxejJlNk1vbG5VN3NpYW5uaTU2?=
 =?utf-8?B?ZGpSSXZHU1A0dDVZaFZWcm00VXB4Z2RsY1BQTzlZTU4vRHM4WGh6N3VaNVMr?=
 =?utf-8?B?ZVRnTGsydk56TmxpMTdwR2ptMytFV2JlVkwrRi9KV3NBS3BGMkxvM2F3akRn?=
 =?utf-8?B?cldxRVVXbzBIbTlCakdtZjRXcEhPTWlVZlVpUndsK2RsUmd6ek5xT2RlTG4x?=
 =?utf-8?B?T0NLR2V3M2E4eWgvL3k3Z1R6VU45cTc2L0YyaXozY2pjL2J3cnVwb2E0eHo2?=
 =?utf-8?B?RzJGeERJbHA0cTZjMVVkUzRRMS9HYnNGOHM1ZmhxNW1OM1FHdlZWYnZaOGFu?=
 =?utf-8?B?R0RZM1BtbUM4WHFFU3YzRXVTaWtoNWpKSGlKU2gxWGtNWC9tU0tKWkhlSjNH?=
 =?utf-8?B?UFZrYlRyVU14czFqMG5GZi9uZFRuVTExWjQrZmNKMnRHbi90SnhheXAvKytR?=
 =?utf-8?B?MytMK1loQkUxeldmbnNjNEl2OGFyMU9scDNaQU9ySjlDamM0Q2k0WXdSK1BG?=
 =?utf-8?B?SnVpMWhzY0xSL0c5eit2NGc5MGpESUQvOFpDdStmK0lmSzlvZjdZMjdGTEFq?=
 =?utf-8?B?YnNWZEpFdEZhajVTOFhDTXRVNHVNOTJvSlVHY3MyaDczaFkrUGw1WFlhMlE4?=
 =?utf-8?B?YUJ6K3ZJL0ptZWczQjZpakZCQStuUHM1UkZXSDFlU2ZiVkdydUxwcWN5UlJS?=
 =?utf-8?B?UFdSbHJXdXRkNCtUMk5icmh5dzVEZ2Y1cE9iaGlmZ01iQ295d01NYUFvNndw?=
 =?utf-8?B?M25ySEhqWXVHdTdNd1hCcUQwL1RjazZFek1McXN4ZU5JT0FCNGVUWENtR3Mx?=
 =?utf-8?B?VnBOVjFNb0Rua2FucU05VThobE9tZEhJaW14Y2liNnBBQVoyanM4bzNsdVVx?=
 =?utf-8?B?cGNOajRzRGtBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR10MB7518.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTlqUUVpbEdYQnJkZ3F4bGpIZ3RpVnkrT3FoOWNNTy9SSk43VmhFRDY4U1g2?=
 =?utf-8?B?MVJYaDdJQVFDaG1rQVFCM3FOSGtrMCtobC9aUWcvK0VaWWFZR2M5dVprWGgy?=
 =?utf-8?B?YVJYam5yYzdJZ3ZnWEgxVTFYa2Q2RW5sZlhESnNNZW9BQ2lYSys3Z2Z1Z0dx?=
 =?utf-8?B?VmpiaEtMaTk5eFF4QW9NcllSKzkwNjVpU0FBUVVIVldGZEJOMURuZGVyZ0Vw?=
 =?utf-8?B?NDBQZW16YTlLUnQxY1RUWHZQaFJKV0tMakhTc2NYZTdSdW8xQ21UNEQ2akNW?=
 =?utf-8?B?Y1QvR3V6SUpiMEZLSit3aVVLOHk4UDBLb3ZzcjFQc0h1MEpLaUlTWlJ4aDB6?=
 =?utf-8?B?MXUrV1BxWEZrT1hJeHc4Q2tjcVZMTm5VYUM5WExJS09jR2Q2T1B5ZzFnUlEv?=
 =?utf-8?B?d2xGVUtGbW96RGxETG1hY001N0U0WE8zSWdCa3Qxa05iN2Jtc3ZsTzFRWVEw?=
 =?utf-8?B?NCtreEFNL1FndXJnVEIwTCtUU0tCaXFqa3hiVW1zWG9sR21McGVLQTlQM3NT?=
 =?utf-8?B?MmRMTm9qODAycFdHVU1nUUJFdFptSFVxcklSS0xFaEM0ZWZBa1I4U083TGpl?=
 =?utf-8?B?MWtKUnhkN3ZycjlCNzZjeXRPaC8wajNRdS9IdUxaSDVPeVp6S1lTMU0wYWtS?=
 =?utf-8?B?bUUzMjlNVEhLTnU2QWJDalAzZ1kvMEtpMXc2UzFUc2x6OE8vWkltMUhvekRZ?=
 =?utf-8?B?YTQ3NlYxVmN6RHpBTFpnQWRrMDZXSUZTYXJZRURXbVE0WHdHYTNBcGlXaTd4?=
 =?utf-8?B?WFVZMUZZZS83M1JQbnNqT3FobmxoaHJuQ3dJcFc1OXl6TGxwNFFaRUdJVC96?=
 =?utf-8?B?WEY5SnI4aW9HcEJjbVkybEEzNnpCMjNyM1ZLL255ZlJjNHA2VGtMM09QWDU3?=
 =?utf-8?B?WEM3dFVveUtsTlByYkF1UWZVdFNnRkI4RzRqK29lQitSMlZUb2w2d3gxWjBy?=
 =?utf-8?B?TGZuaGRhOE5Zd2xueFBJcklrUjBhQUpYTnR3ZEd0c0d6MWx2cFJQMmNlajJL?=
 =?utf-8?B?cjl1WTRaeXY1am9XMlhLcWMybzBGRzJ1RWRUK3JXdkZKVlMrUWw1V0d2K3NV?=
 =?utf-8?B?R2J1eTJrRjdIbW9VczF3OHo2S3hOcktlU3pOZmZnVnZ5c2lzRW9Dby9WMHkv?=
 =?utf-8?B?R2Fkd290cFpVWGNwVkRTOGVuTktmdi9XKy9qYTJDVk0wOW15bzJhOGF4R3hD?=
 =?utf-8?B?dHVxUmdkUFdLYmFBbm1Uc3VMUEVBL2ovTmdRZzRNSnhMQVp6MmlZK2J0UFJk?=
 =?utf-8?B?VldsYXhLVXNiS1E4NlFYU2NZM3JkWUNzdExBNmhpZE5qQUIwNXcrUGdGK0cy?=
 =?utf-8?B?MkxVUDRncnYzZVFEMWlVdktlMWNFNkJlc0Npc0grdWtOK0JEdTNDckR0QkJQ?=
 =?utf-8?B?allYTGVVRFZxNSt3RGRNWFpXNW4xOHF0dnE0L3JOSVFFcEF4aVV0UnhWN3Ba?=
 =?utf-8?B?RHhNSmU1Y2h4MHduUk5xMlZQTHYyeTltbUpOcHVjMUo5RUtXZHBvUEVNVkdw?=
 =?utf-8?B?UkEvL29GYXVwbzRyMEk0MjNFNmNUekRQbUdzMk9sYldqU2NkNEpEMUNRU09t?=
 =?utf-8?B?U2VzWGVKU08wRVhnNUxEMjBLaW9lREJkbEU5VmRJZXNCS0NZdFdsQStCKzFY?=
 =?utf-8?B?SjlZYnVRR2hKaEthenN4R2s4a0xGRTY2K2R2MzU1NDE2NEcxdlNOcGc4UkJO?=
 =?utf-8?B?d3BqWnd0c0xXMG5ham40K1NCTGRWRVExcTJVa1VpSDFkVWdsbW9rMTNOejZQ?=
 =?utf-8?B?b0V0RktUMjBUOWl2ZFJaWlhYZWZaZGVWYW9NUmE5dzBSU3YxUXl4OE40czgw?=
 =?utf-8?B?VHBpdGZoekVHYUNuL2dsRGl0M3l5YXB4T3Jjdmg1WHNxdGd5c2pqSFlyV2NI?=
 =?utf-8?B?Yzl3VHlHTTIrNmd2TUhDUU9pKzRibVpPcHFNUDRnVzJLa2lmZ1Zjb0dMMEly?=
 =?utf-8?B?cDBiNVIrVzgwZ2RaTE5EV25oZ2VzT2l1NGRac3BqcnBXNm9ab3lOTTlJNjlx?=
 =?utf-8?B?OEJsWVlwbXhNYkIrREwzVXNQbDUwOFp4dEpFdVJiQ2hiMFlwQ0ZkUDdmbGh3?=
 =?utf-8?B?ZVZzT3NZN0l5a0ZsYnE0aGlwRExiVk1GT0wwdFVqQ2ZaUjcyQXIzY1JMMldN?=
 =?utf-8?B?U3Q4bmxDWmFOaVpJRmVJUFVLSzBQYUloVXdTWGphOWZGZmFpVllIcE9acjNB?=
 =?utf-8?B?bFV6QjBEQWNudTVnWWxUdXlEaDhqdXNFVUFCalBUMEJtM01BT3JZNlFXUk1v?=
 =?utf-8?B?VXgxcUc2cGFwc29veVVJZ2FONGJ3PT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-NLG55C4BWepJ5mKW1k5P"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wxRfZklt9n6qtIK3Z7J9QXRKNfcFjjRZDT2rXq42ADhj9wwkXV4n5lEbmVWQDWxeqcPylx3o4yRftsMi+LWPsHGcX0tM2rJMHhciKvyl5p4dmS32OUPrSGU7GFex4WWVkYay5IJsBkcFEtSQ0Iiz6fpbvF7VNI6yEHy9AvpXhsxn3WkIF5NTM6BX5k3TUVQoqFElRuZasYi9okQK6lEijsIr759+nHDBVvOpGg7G6rcr0A7mvLOpgSlX59sWDuvGjAgQhbNz/qr/OmEa9MsKfdEq01sORgjaHPsfQyr+Zf7/uTg/i0MR2QK32U0ynU6kaf9ll5kns54lcZlCnmW45LMfOeo5PK6ylVwMuVBAkb4bKVoqhB9QmLBNftc/1yWEAo5CXrKxT23ZsUN5a9JeYoQngg5jByQXrRub4wGqlzMYKJvSYzrOye/CSadZu3WZVL8K5uwXn+udeLfB5gY1d9xQqcTv5G53vteG7t0lJ4Xpn0zzz4CI/lSsXT7xo9AqyZMx8MqVlugWfQ0oSE6fUrZKFKQOWE8G0cG35d8mzSeeWGj4qK4s58r5lEmhwVvVsn0xXCYGD6Jzs+LYSL+mxM8+HzpNER9mIMWX8yb49tU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR10MB7518.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdd4e14-5459-412c-3f25-08ddd7699f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2025 17:24:40.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZjZdeiXSiANcpPLcfAcFgynRsZgHp0uGn5XMPhDHDxWt59B3/+bRBv8coTYAOk0NSjFxwFzxmcjxwZzdcNUxY06VGqZKKqAM3mqssxwko8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508090139
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6897845c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=mNvHEJ7c0oKyjhUZySUA:9 a=QEXdDO2ut3YA:10 a=3AstpMzsqJ8A:10
 a=Oi99pz0Sxv4XBl5fD0wA:9 a=FfaGCDsud1wA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: GbETDAfqqng2oCeLqvSNwH8l3XfVpMK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDEzOSBTYWx0ZWRfX7e82S5V5jaM5
 irlbT80ZgP2oYfxJDcThWmJ5qgvhyq+mWQG/6ftEoacVhQOms+8QILa2JfI1aKOblIUrejOMSz8
 w7wdoBx9EOOPvf8O74dlUyEX/Im1HixCBnNmZhlCqaiMovXGVXMBwHfpO60zpAyRpQLVbzv/Eb0
 Ku9RLj1gIRkuEd5qTfRp6h0BagvV+N5d10uX7NXQAOtkkaZk+DZyfElzduMYrP70B4ihjvFwqCl
 2tGZcG6Rz5EOxAuv8ndjr429gUym4DmgGxwWQqu3uklH8TfHsH9c5hInSIBOQSP34wyjLxiSvU2
 bEbVAao24j/gfjdAAzCXdfiNMscOnaWyY5lse45C3FlwqAvFNiif6k6fFm92OfLrBT+VZrG11H9
 d+Li4a2hH4J6LwCOMDwpkagYYLKt1vbO21nDu6FvY0ghw8ral737/SbpbbuwUNn4GZ+ewfk8
X-Proofpoint-GUID: GbETDAfqqng2oCeLqvSNwH8l3XfVpMK1

--=-NLG55C4BWepJ5mKW1k5P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Aug 2025 19:34:29 +0200, Hauke Mehrtens wrote:
> I will ask Greg to add them to stable 5.15 too.

Just came across this issue thread.

I posted a series earlier today doing just that:

https://lore.kernel.org/stable/cover.1754751592.git.siddh.raman.pant@oracle=
.com/

Thanks,
Siddh

--=-NLG55C4BWepJ5mKW1k5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmiXhEwACgkQBwq/MEwk
8ipRgg//a0tk3t1LFo0WPxy033gmtkxH8/Gdqh17Nheg016czfRalGTR3rGNADi5
ChEAQ5bdqpEC9pfPKpP8tLP+evAHa8j9kkzfcfTm/5m+KVwHECK6CWpjEq8Cjo6O
LplqOg4e9F0Nw9Z33cIZe7XAibQgevLPhRjOBDeOV2ZX7c9DRl591WqahyUSTpBM
40ikik+6Jk4jD+V2XNLSzKbxDFxGwGrWqZ671NZCVhfUp18gVQ2HniJXYQfvIWV9
tXSGtm66gZzCXHPkBUGRmpIGvT2bBJ0qX5XvvQa85d3XvB+IxHNU97SaYyVmGULC
g4Xx3C7XN4FSZvD9xhV7WDn1qoComhobFoO09B9rwyn/rB75SAXb9NXm8UMXMrWp
tt7HQVH2VmKF0PELwtR80Tva4N4garY+RdldSJr3WNzBp4bcV+fnHAylVcEiLsdt
iV+j/Uguw5h0VlyGQs17yQf8uabt4xdPWkz5OkaDw6DmuwcyRUjUahyPjqYBIWK/
DHf6zgpJMx3J25s0PbLHP0ZL5SbQmD+egh5vzl+KOhErHzBhcM/xdNzc0D+G4Hat
0xMTFuOi2D9rP/MRMxc+9m9J0Oy3XShcpdmSanEmDu92wJg1SrnlYM1F5vVxS+Vt
DY2w/7GZmmQ2Srma9KZixoownrmcBq53cdwTGMNdzXPVw34IpGI=
=oK3z
-----END PGP SIGNATURE-----

--=-NLG55C4BWepJ5mKW1k5P--

