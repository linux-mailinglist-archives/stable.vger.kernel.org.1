Return-Path: <stable+bounces-92165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF469C4600
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 20:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CB2B21B3C
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33B155A30;
	Mon, 11 Nov 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQsq88Ol";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q2HlgQqT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DB139597
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353974; cv=fail; b=hxZeLiDnoNAxgzzhShwTkF/iojL3ATQjfUEpgvgOxZMtMP238ESGmnEwh6zN75pXxHLsGP9pHVaLRsMeDKgUYyNuXTdfHrys60I6W/iQVtZDs3c8d8ar7A+LL645XVsg6l93HVxauN9I483nKV9/foGic15Km0BmwpBYtt4q6Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353974; c=relaxed/simple;
	bh=NcJt8Wlcme+PWjjRLz4Pzpqrqg/SnvvBM0jnFEXf9Oo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kH1+5vufpgVCZda4Z7WFRHaFQNmwWjUO6J1zNQ6TXckS+CQbDiRSuOiUC+m40gF+g5kM4ZKjXYpfUJkABdRiZaN3vcBjigi91JxMlECzDOD8Twam6KwR35oZlZVscdKygADbXhC0EA/9c1Y1DqYkY/5m/wP6g9C5nxOGiwfbPhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQsq88Ol; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q2HlgQqT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABIBWlR002329;
	Mon, 11 Nov 2024 19:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ro7p2iLt2oXzN2gmjDIn6bfjx0RdWoowm2jkfTGhzHk=; b=
	VQsq88OlcuNiX/dGeRXqTqYfVXX+qOCyM0c2vrJtV9GxfZ1vfgF5dCOgspIY58De
	+sdUKGuRdfN5u0wZMfk+RR+EobnP1GxZ4V+CKY9SSAr8SmeKYmRPJGYcLrZIIvLh
	RGCD9/n8SKbrdAwmtL9jD/lDLiFO+7x5wsqbBFB2NlzbCorDrrm4M/zukf/Sw/XU
	hTWiM89dCRBuKY84V+D6fIwbMZZGA56KPMCkJn/qC3zx/jvHJ7tNGIHQo/ahnGAZ
	/5w5ZKX/7GucPaH5ewcvcw7lakx4cwN4Uj6UVlmK5e16w89c/nI3B/BWtnewTw5i
	w6E7Xs4bvwL9ql8IPFu6fg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hek3gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 19:39:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABHAI8g021488;
	Mon, 11 Nov 2024 19:39:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx674ku8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 19:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA7u3sxqLIenk47jyrU41YRvjKZsYTpL+ZmRaC3HuQd9c0+eH+BF7oTXCGVdB7aGrYwColg0ujRxg1lqxVH/AeXBAM2cYF0BEko98TJHMwZHgljeQv2BKhEuRiOFTBmuieNBWaefIANr5Ftx8IerOl/yUhYCXcVM7VGxx9DDa5fFnsD/4OVIGc9LMMLWM6HMKAB64+1YctmJKDvgw7kmN7wVFsxeuHBkz+xZgWjVNHndxvz40NwWZpik+qUsciIO7nJ5vYyabWjp+dU5hcEuESD4/bjtcPKu8oo2qtAqEy+8Vb9FhaY/M6R54y6xDIuEoakqeL7iUwypLywPFcDKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro7p2iLt2oXzN2gmjDIn6bfjx0RdWoowm2jkfTGhzHk=;
 b=vAhgZ6unvC4CnNQ4Go1unwcesGKasLn9XMXgNyzXHLuH8qwNkZwRRAH7Ym+mCl5TpC9cdj81lvELttPw3xx3xuAhPtCr1JMCPhAc8qKh32yO7+EvCTCbA2DHOBkHSZI6w3+UWvPP5T3x1X56n1g+ut9kidnypj1jOlo+jV+js4R5YgafYdxka/hmL8ithpRhQ0f8Z33mSiHQZyGa0I0L5DBJx998U+YtSQoDh6L42JmetwSrp0jSNnRnS+HozXlrqMgWDJK45mM2R8xGt0UTmzws3hHYOAbT/SefivnogjvWh+hyxn/DCEl+Yv71+eLNOpZw4qk4IKTST2JlJ9xhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro7p2iLt2oXzN2gmjDIn6bfjx0RdWoowm2jkfTGhzHk=;
 b=Q2HlgQqTPAByxydG4kFa10mjFg8VWjqjIdqHcN0AIn51XPWW98SVWR/YHsXhJIm6k0bsBnZGbfTBooKhf72IbAIfBFRj2/M2zywL9EqdaNlXr+qVMa63+3gGkM37acNoSUYFv+x1/ZiefByxOX3JW0a5c3Ij+FmFyrqa//7lLvE=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 19:39:22 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 19:39:22 +0000
Message-ID: <e0eaf734-dcca-45f8-ab55-7ecc70147ccf@oracle.com>
Date: Tue, 12 Nov 2024 01:09:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 1/1] net: sched: use RCU read-side critical section
 in taprio_dump()
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20241111161701.284694-1-lee@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241111161701.284694-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 577084eb-4672-4ed1-7889-08dd02888a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEo4czFJTHMxMk5YVjg0U0ZRNUlYLzNkV0VBRjJ6YnR5YkMwNytxS3lIVjcy?=
 =?utf-8?B?ZXAzK0tHVXpwMjIybGhCWlhGT05uVXNuWDBlR1JyQk9UVVFFR3F2YnhTTnJG?=
 =?utf-8?B?UkVwNi9sNmhqRXVHMlZNZlNYd3dzTSswNnRLSEl4d3dpcUxXcG1wc05pRGJm?=
 =?utf-8?B?eFpVM1VlekJDb1ZtNEJyMDRHWkxDbE40VEJoY1BNZkZDTVZMZFR4VUJEeWpm?=
 =?utf-8?B?NmliYkt5eE9TT2VuMHlMalFaejNjTG9TSGZiVTRaQUt3VGJ4NlBDd3RsaXdT?=
 =?utf-8?B?L1VDTGFFbEVJVDY1YkRKWlFNWkxMU0Z0emZxN0NOM05wWkJMVEFpZittOUc5?=
 =?utf-8?B?ZlpxdGZ2b2JvZ1o5VFA4R1lURlFPZExiL2dPUURnUWJDaUIxTk02aG9yNlVp?=
 =?utf-8?B?NkdZL3kzZ0ljQnhxTFdJV2txbC9yaWV4RHZEa2NMZXFpUVFwdlJuT21uQUJB?=
 =?utf-8?B?QWJqYlpwSWhzNkgzeUpsMlFlcm00Ny8zWlljYU9OR0xuU05BNkorQkNUK2JK?=
 =?utf-8?B?akNoY1hqVWQwVDAwakQ2OTFSMUZvWkJ1SWdaZ1dyVmNFZndGL1VyT1Q4Nmx3?=
 =?utf-8?B?bHNETm1TNWJxRGh0Ukl4ZHNHdzIwN3FtMUZIVUZYZ0YrRnZIR2tRcDd3MWYv?=
 =?utf-8?B?andMTDhKbHJGUEQ5c2xORnE4YUtPYitzV0Y0RWN1eEdwczVwNjRjdlE5VXZu?=
 =?utf-8?B?UXBTK2Rudkhzd3RpTUd2a1J3cmpINWxHY0psblB5MlJiQnNGekFSUE53SVJ1?=
 =?utf-8?B?WUJKUDMxWkIxcyt3eS80YWNSZU93UVdhMVdTRHZaUDRQV0lHQkppdzRoTk9y?=
 =?utf-8?B?TGpjTE9xbjRKb1JtOVNGNnB3YnRueXh0amxYK1JDa1hzdEcyd2JTRGwvcWRE?=
 =?utf-8?B?aFhHZ1JBcW1IakJkRXBRcXgveXUxY3dSMDVRMStoZFdrMmFDWFpkQ25ZejhC?=
 =?utf-8?B?ajFrbDZTZldGZHNDUDBTcTU5QTB0T3pwQ2pZOWs3YnQxWmhXYjlhbE5TVkhS?=
 =?utf-8?B?UmczaWQ3OEtnUkpSM3BsOTVNNTBRT3hFNHFyRkNmVEQrVm4rR2djZ0VMUith?=
 =?utf-8?B?NjJENnIxdWF1RXdKTmIzYTh3aWdiL2duS3doTFhYTDBIeDBsVGUyUlFiSHpT?=
 =?utf-8?B?dzFjYUNXRXNvd0FjcnBUdC9SdktzNitBTFIxOTlzUUlVMG5lZk9xTUozYW52?=
 =?utf-8?B?S2I3Zk1YVlJxY0xmMk5kb25nRVg3d2Y3UkRuU2lhZjlFTzcwREJyZ3ozbVUw?=
 =?utf-8?B?Z1dKT3Zpak0wZGd3cXBxRnFyOUFrZ2JPaE1DeTdBTUtuS3llaHVxUGs0OUdB?=
 =?utf-8?B?dGlkZTF1Y2x0US9telB0WUdlQjI0SzNkVjNZOGJkZEkwRllxQmVvMFFsU3Nj?=
 =?utf-8?B?ZzNQSndRQzBNeFNGaEpCV2RDR0lsbEZKTU1KR0ZnckVWTTZMaHBYdXEzZUND?=
 =?utf-8?B?N0wyM082U3hQaU55TnhjWW05ZUFsSlJNWkVzVkh0ZTg2VjllYi9MSVQwR1hB?=
 =?utf-8?B?MjU5N1VxR29RZkNrQ0NHRmF0TXkzcFAvMG5lRVBuTW1jVkZIRmpwcXpWb3d5?=
 =?utf-8?B?VWZsd0F2VWtUKzNLWE9EYmlqMSthOXVxYmxsOGg3bFlKcTZOMFNXQW1PaWN5?=
 =?utf-8?B?UlpvTDB1bGEvek1PdzhuaW1mV1ZHR0lWNXUyK0JuaW9CMnBHdWx3MmgvZU9p?=
 =?utf-8?B?dGVNbDlTL2pOMW5jc1pGdkcrN0VWWHRsQjRWYnhXYUE5WEpBU0hxNE1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25uZytqWjlPMGtJUzdzZHB1ckRqUjVXWGtkSUliWXBtT2JUT25kcTExZVhT?=
 =?utf-8?B?QUNOOU1ISGtKbzFEOVd6SDhFTlV0ZFVrbzlMYmNUcElnWm9KRFE2KzZGMm1O?=
 =?utf-8?B?VEhZYm1NT3U5U295WUZSZ3plYVZtL2VxRFJ5WFZsc1dpVFRNU2F1MnpDQzV4?=
 =?utf-8?B?MFdTQVhtamJOaVEvV3NUWTdKSFdNbW5ubWRDOXNMVjEraWtQaHdkaUhHaFlo?=
 =?utf-8?B?M1ZNbm9xN201OFNlMEoxdHBMcVkwQTY5ZVYza3oxTXEzMGVRU00zdmh4TTNR?=
 =?utf-8?B?N0o5L2V6RkJ3NkphSlNCcVlzTEp4UEJEa2VBUW5hcVo3eUF2aHRIZzJHdU1z?=
 =?utf-8?B?bGZoRzA2U2IvNzhSdzdlMWZZbDk3aXVGclN3S2k0ZEpTQWVvc1kxdFkxbS9D?=
 =?utf-8?B?QVRiQmkvNFVOQjZORGl0Qk43ejhjcjBlMjNCN09SRUR6VXdPQUg1UWwzVURn?=
 =?utf-8?B?bXVnNWNjZElpdEgwaHV1YlVydjBacDgrUnloT1lJa3dUakFsN2dLSWFVaEEz?=
 =?utf-8?B?d2hkTEkyMzd3bXhmYmtJZkg0UmNZM3FHNWc1aUF3VHdDM1AwMzVTYUdUSVZt?=
 =?utf-8?B?a1JFMkZmMDdnZyt5SVNxSHZJMVI2ZmtlTStjVWYwM2NUdUVEM2JUSmVUYmc5?=
 =?utf-8?B?Mm5Ib2o2aGhmWGJWWFllejZjazBHY29Nb0NtZ0RrODNZci9WaGsvSmovb091?=
 =?utf-8?B?dGdVWkU1UG0wazFxYmJDMWNGRjliNm9RUGErdE5OYzA3ZGpnS1ZiSHhJdVBt?=
 =?utf-8?B?ZkR6am5CQXZJT2FSeWhUTHplSW9HSG01K2tPYnppcDg5bEZJZlo1VE1UeHZK?=
 =?utf-8?B?djJucStlemlXM01BRlV1TTAzZlc2a3hvbjExM2pxeVkwOFVWU0pISHpra0xv?=
 =?utf-8?B?KzJLZ0dadWhKay9uS3RZU2xOcUFJc04rb3d4Unk5b2N3cTRkOWgyNEZsY09C?=
 =?utf-8?B?VHFDMDBPekliM2dIUFpGV1Rlbm1jK3ZtNC83azBlUmVwT2liU3NUSS9SSlVK?=
 =?utf-8?B?SHN4L2pwUkN1SWhKZ0dvQVUvMmh0dFBBeHhGQ20rQzFEc3hiT1ZRVkNPU0Vo?=
 =?utf-8?B?SUxNNm04Z3RGdHBkYUNkOWJlK2diY2FyR04rajNXNUtiVCtsdVN6UXo2amZX?=
 =?utf-8?B?Q0I2cGxNWitTNHp1TGtrenJMdzZlUENvOTdsZldQbnRRMmFIai9wWTJzQ1ho?=
 =?utf-8?B?VUxaWWNRNkhxQS9VSTVDOUpMdzI5S0ZOS1FSQXlkbndEM3dTdTNhWnRNczdB?=
 =?utf-8?B?aFdVTEFJeks4N1F4Y0FSaUx1RFpBWG1lNmdRZXU5M2NuanN0UitldExwVlJs?=
 =?utf-8?B?SU9VZkZWK2dXeXkvQitIbzJsdXBmamZ5WjhWNUVhNDZFTzNsTmFud25jMnpw?=
 =?utf-8?B?cHo3bzRtalVaZFZHODJUMEhWVHR2dUhkTUN6eHhLVStzbVNERzRVVEJpdFFQ?=
 =?utf-8?B?U2FZalF6TGhvWk5ZZCtVdDdWT2lQVnFUM01QQnc2V0JDVm1jODRvRXJYdFo3?=
 =?utf-8?B?UE1MZk9pcFRtcDNxdEtSV0UvM0JXWHNYclBtbnlXZ2ZyQXFGWFpxdmdVYkFq?=
 =?utf-8?B?N0hNZkRKMGpOZmx6VlNoQ1pZcmszL3hId3hZKzBCa1VEZlR1R0h2bTFreWEv?=
 =?utf-8?B?eGpaMTdMMUtPVnlZcHgwTzRrRkYrSDU0R1Qwc2VpTjRlN1kzdTZONFkzcjhv?=
 =?utf-8?B?ZGFHUyt2VXIwMEJuMGV0a0N5S1lUZHR2OEY1VWpqMmR0UTZCRnd2Z1Y1dysw?=
 =?utf-8?B?RzhFWFN6U1VIVGkwY3VJSkw2dmxXT2t6NDI0Zi8yT1owZFYzaklGM0JuajZq?=
 =?utf-8?B?ZFRMUmI3SG1sbm9KVEd1emZ5cEUwUTlJb2hDRmliZDczM3FCbGpwOGZqMDVP?=
 =?utf-8?B?ZWJoSlBzQzAzR2drY0xoT012aDRwYUl3OVlXSlBRMUl0YmJ0RXd4Qms0M0hu?=
 =?utf-8?B?RENST01UUU9jYmsybmhuSkxhbHpxZ0VJazRkYUZ4dlo3MndZWVU4TUpTTUpV?=
 =?utf-8?B?MzRHdFZUTFFmS0lqSkgxOHJ5L3EwaXl4OFRaWUFkMTYvSTR1RDB3QTFpOW5p?=
 =?utf-8?B?eHRBYTlnZ3lkcWNqMklpRnN3QkkvR1hhakwzZ3kxMW1qQmhhb29reU43bEpl?=
 =?utf-8?B?eFZNYjRVS2R4SHhvQisyU3A5UG9ybmlFdDFKdzR0Yzh5VStlYTB4SDBpYi9J?=
 =?utf-8?Q?o4tMvgttw4QtHalFKysTYKI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cZQtnFXDPUzqBguzVynGx26vMoTHyvijHOMdmK4gfNibo5PiKD/UVQZMKX/wl4AVF4IVSdfSJPnocK7QCuX2MvA+mt6/MBE3UsNYPsuwBv9UXDkCCUYmylyzR+USat6p1OgAjbym4p95j3ePB4SALBxA6PLNjhOUukmQt+16yhgzi9EQOP9tc7/UR9pE+PrKK//MrDjEsqxlD8PJ3Bo/oQyOl6pTYjJlEmWpsfv7JSU9V88eczG9BlzZUGqRVRPlsMzzIaKbrun07Jpz3gLgGao9L8N/r5KOTZKM900jKz1F1924+wZdYs8+9BeYrKYLNPkUxKzqVSAqgfp4HhEIndE+7ykBF6J1iRBdwmNg3yWzxSFnioUbj5W3Zc+mPDYLbWPZYAwj7ShX95JFR5VvM8YoWtnKAzIZzr3/2cpC3DcUmkUeDFzlpJodvrO4kcSU5EF1akbr1n56fCbrvN5DKxBOyhUXq/EWuGoLoT1/Kcksjm4Azb/BIBhqC+gSH9P3ummBJ51UR3OtW1sFJ/ZRqoeMcSXdSX0HnQrd1V95ZDppK6AdNqFKlzSvEMD3Mm4AYlmoJOoTXU1QX9u+yA/ljKG//nSNVoanDhGKFq3W9Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577084eb-4672-4ed1-7889-08dd02888a9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 19:39:22.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlsB+iUmiBuC+urwHg1hVih+uJn4ufZlwmzloQzggHa5hlAI9RZZpEra0K2GyZXyLuW1q03Nvpi4QqKv6DLsVM+OtcGneLiLLq/ki9ra+HjPYkB2hqYSqnJhMgxN09v+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110157
X-Proofpoint-ORIG-GUID: ehvXBpjmgfrYEOaTEQMVhZbnPYeTtxQR
X-Proofpoint-GUID: ehvXBpjmgfrYEOaTEQMVhZbnPYeTtxQR

Hi Lee,

On 11/11/24 21:47, Lee Jones wrote:
> From: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [ Upstream commit b22db8b8befe90b61c98626ca1a2fbb0505e9fe3 ]
> 
> Fix possible use-after-free in 'taprio_dump()' by adding RCU
> read-side critical section there. Never seen on x86 but
> found on a KASAN-enabled arm64 system when investigating
> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa:

<snip>
> 
> Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change are protected by rtnl_mutex")
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Link: https://patch.msgid.link/20241018051339.418890-2-dmantipov@yandex.ru
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit 5d282467245f267c0b9ada3f7f309ff838521536)
> [Lee: Backported from linux-6.6.y to linux-6.1.y and fixed conflicts]

Conflict resolution for the backport to 6.1.y looks good to me.

[ I am not a net/ developer, but reviewed it from a backporting point of 
view]


Thanks,
Harshit

