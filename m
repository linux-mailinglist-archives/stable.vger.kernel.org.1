Return-Path: <stable+bounces-40409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A158AD74C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312081F22688
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B011CF9B;
	Mon, 22 Apr 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gzb73olF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nIbQrdEp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A261D545
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825143; cv=fail; b=CIiAloZd0rcUVKPiaq2RmXgIk5AlWFpmPus/fkBQhZECUf3dlKnUXS0UdPVSQLiQYW+z7212NYhfpm5g5jrGYlX+Z811hM7l8zFvhMULwvBbBDZznD+57ZS1LTCwYtlMlmEI4n3XNSM5OfrpF7RRRvKUkDR4juPSVCx2QcyLURc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825143; c=relaxed/simple;
	bh=MRM8xh2JJp7fvPbuARPSG1iro6PvPJ7xeLKPnG1//eM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xoqs6od0x1LsmWnEnfkpe4Ww1hisqHsgKiVkhHx183/XX2JutjBAeXwcbdC+v64W1N9y3zZV/6u25Rq9pil7cEJpiExXF/nUxpfU/7RwdgeMylCYn6xDdL00dYUKKjFrNnngnBMCpuK3zwN0UJuaWN+0dfAg8gcKxm5bjmAWKJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gzb73olF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nIbQrdEp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnYIo014567;
	Mon, 22 Apr 2024 22:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3uJsmYJqvjQC6PNBkNmBWj8wQMiyiB2C55GS+fyab6U=;
 b=Gzb73olFQVIL/EIhm7ywkuLmQTG21pCr712VuQTwrWOOcr+Tf6iJ6YX6kTGst6XTThTR
 yt3IXH0R+ZmIc+AvAMAAeS/MtAkM0burayW6QHjKqiLodG7k+PX3Sp3HBasd5mRL3SRP
 hIMhmK4FMCBp1hV3smCjYUgl2ldn8ulY5RpKVhlvWRYPVMrW1aUyvKusKsAuHX24Dvs7
 eRR6bmZfr62lPBVwQNwVS6EUKkGbZE/70wfxrfq5296XORTR0CN143xk0uaismvIUuOd
 sENhgAhH8Zo9gagpjUyzi8E/bnDEwWiAbk0MgO1B0qAuf+2CJrCnqZDOPXcZPXyyvPbV dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vbskv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 22:32:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MLV9mL010329;
	Mon, 22 Apr 2024 22:32:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456ra8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 22:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLN20Zw6yrThyzfBJ+OGtYb/3+W076VQXE/kkZ+0B1a8m765QL2KDVRpmi9sP0hupmVD1di0imevLG2LlCS4XFtUZxqjPPekGCN4Ula5ngFnma1PtxmLEVEPhAERFCIjz3JR7JOs8CWcNWQ6NL6wv/7sMiDqQ2QbHW6r0BSyiHW+maAhYGGtk+ziQjCc5MIpeUmqIV9v5xuKjFGA189q+mZ1p32iHxB9AiLmrUCgmXYGr7q6TUj7O/eLQ+i9jDyN7jWICqqf29fD1HSQkw35y4Pa3zGAgrxOl9XoiHB0bDgSJIWZ2kYjNi8/gH2WAfe1ubC3DSf/JBS420yHJXhPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uJsmYJqvjQC6PNBkNmBWj8wQMiyiB2C55GS+fyab6U=;
 b=M0dq4YgAKk0Pu48Ax8KXzhHr9TowTBLlOcmCkxp403AlSakDeXEL77vOzX3Haqtq1Xlq5ZVad1E7jTQ35uI0Dbxvzj54P/a6MKXdU6OoIlvafkJeJzi/xOMiOvUirwhYsuOWtWfx46na2p5XUt5U5HfTPhW/sp9pS4YTEurI/uHuocauwpvrtpN8kxPfAy0DitDX8rN/nzrDRGD4JY0KhdC6xe/DmYSuuwYQ9ThWI3TVmmlQdMCftOZqymJeyk9IX4B+kv1KLLcIL7TrVupQvw0A/mZLua+gGro5b1JAn1r+Qwr8nB7W1FY7OinJ16i6GB98uyfA3aBokHEF6gah+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uJsmYJqvjQC6PNBkNmBWj8wQMiyiB2C55GS+fyab6U=;
 b=nIbQrdEp1HdC5pWMscCNq6iNFigIjQucl7dyXgHI5yODPaluglYGFSRMlzNQ58deoiaPCoOSVA2g8JX8MFxtDuDXpD/PlY40O3TsTG44w751fXVv9vbndu1+2tx1IWGyhWs7TJZriE99IdTwIU3MPNIC/fzP0j8LqH1aevSEZQI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 22:32:16 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 22:32:16 +0000
Message-ID: <28752189-6c59-4977-abda-2ea90577573f@oracle.com>
Date: Tue, 23 Apr 2024 08:32:09 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq
 resources in device shutdown path.
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20240312150713.3231723-1-imran.f.khan@oracle.com>
 <2024032918-shortlist-product-cce8@gregkh>
From: imran.f.khan@oracle.com
In-Reply-To: <2024032918-shortlist-product-cce8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cd3535-ccc2-49fe-f2e1-08dc631c102d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFFUZ0hGaFQzZEs5RDVYWXZ3OTBNRGhsaWZ1ckNqVlU5cnVZY0Vqb2FidE5z?=
 =?utf-8?B?TDFwSGpvYnhSTDRnL3gvTHNMbEVGa0lKOUJzS1Z1QVQ3dTl1d0xUUDcrMGpW?=
 =?utf-8?B?blZXYzEvakVrbDBKaEI1cGhEaDNKMy85bzZheU1Vc1dyUmN6ZXBBSXNoMjMv?=
 =?utf-8?B?N0JGUnBZakp1U3VQbW13bE1MQlRKZHBZWTZKZnJaTE82SHUycUNKTTZGV1Fy?=
 =?utf-8?B?WG9iRmJQcVJXRHdWRHA1QWRmS0hMU0VhNmprWUh1OXN6eTR0bmUwbW5teTB6?=
 =?utf-8?B?Mi9lSlp5M2xEaE1peWJUVXFLdmFrMW1ybmZzSWRTVWdVT1RYZVYydVZNVmNP?=
 =?utf-8?B?ODBHeHpEUzJSb25maGNva1FrTGNMQ0lZOVV0anczb3ZGenRLeTcrTE1wUVph?=
 =?utf-8?B?SG0xaEUxN3RLUlAzNmlBenFzMDFUY2E0YUNyams4SkpmZmVTVElpYXhjYWh0?=
 =?utf-8?B?ZXh6MFlBWVNRUEJObFBEWW12Rk9YS2YyYW4vdTcwSEdrMklVUCthYXZzenFL?=
 =?utf-8?B?WGxKaGdZT2UweFJWa29XTHRPQ3RlZUhtYUtpUWdKMjlYMFd0TUFDWkxwT3hm?=
 =?utf-8?B?STBQcjdoMFA5UUFNNHJpZWt4VjVydSs5anlKaEY0OStZWmpxMDdpNktvWXBw?=
 =?utf-8?B?U2JSNW9yNHdid1VCSmRMeEttd3NSN1hvVGhnd08xamRjNE9NU3ZvOXBMQUwx?=
 =?utf-8?B?WTdTbndtQWhtVGZpL3JtTE83RStiVkp2TGt6emdZSmZ4N2MxbGZFeDNtT3Js?=
 =?utf-8?B?S3NZTkhQbUNTWnJSMXMweEZxSVE2Sk0yWDFpdThvZWFtMnQrajVJelk5NDAr?=
 =?utf-8?B?Q3RIZlVKbSsvQSs0QlNXK0ZoUEx3cTJEWFVhdEpVaTNwZGJab21BNEFsUHFm?=
 =?utf-8?B?NU5ZS0ExS05QUy9QM3ZWWm9za1NoeW93TDVrRUw3ckt0ZldSK3p6Q3dkOXc3?=
 =?utf-8?B?MlMxR0dQcnMyS0YvbXF4U2k2UWVIRnZGUkRmZlR5RURvUDZiaGtpRXpnRVEw?=
 =?utf-8?B?MnZxcUNSTjhwRzlRaHhtQW56Tzg1aXNUcXBzVVJkUk9SSlRzdklzOFphVml1?=
 =?utf-8?B?dE12aEhEZHRraVdoNzJsdHFwaGQzNEkxcGNqWjUrV2VZSDlSSW0wZGViekRl?=
 =?utf-8?B?YjRVMFJJeFNZaW5lRXIyM0lNQzc1amJ5am9jSEZGZFNYdUpiNWNaS0E5ZWph?=
 =?utf-8?B?d3ROMWhlYUdNZU5LSkgybklGZzNkakNTck1kNm1zczl0ZERrVUxjZnVacU4z?=
 =?utf-8?B?cVBsTExySUlzcUxzeGtvRGp4b29RMEtrRjhmVFl5ZnZKWlhYS3l6SGFac0tI?=
 =?utf-8?B?UWJIUjQwdE85ZE9yTFRYNVE5djl4Uy91dW1JV2p1UVVrVEZ3NjA4djBQN0lt?=
 =?utf-8?B?bFVENSs0Z011bU9RTjJCVzVqYTd6SGdFaU1saGZXSVJiaVZqaFdBYWlMNlBG?=
 =?utf-8?B?dmtXb0tyYVlzYTVUQ2Jrd1U3NEVPOXRBU3I2RldGdFJ3cWk4YTB2WnNVUDV6?=
 =?utf-8?B?Q3ZyWTJjRzg5TDN1dDhsdDBIcHYxdFRRSm9FTDNnaGlXWWR2WFFDcmduWnV2?=
 =?utf-8?B?YWM2bytxN2p2T21LdkJuRTErVTMvN2FDU2Y3dTlERGViQ3AyOVV5bEFONDlw?=
 =?utf-8?B?SWlGaXVhUy9jWUFTTkwzRUlxeUxVUVZ0RFpNUDNzcitwc3QxaDJDd01GU2pQ?=
 =?utf-8?B?MzJoSCtBcm54emgyNVZoUG90STltczZXSTNVdEV5aFJCQlZjeXBBblpRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU1mZi9DTGNEalRZbTg0cjMvZE1JUEFRanhOOExOREVMcjNyM21ia21zRzJl?=
 =?utf-8?B?VDJIMFZjN0EzbjBOaWNKT3cxREVwb2ZFWEZvTk9tRkRscTVFYmErY1JZZ2ZO?=
 =?utf-8?B?clRmZjFsTkdHN0VScUx5aWowWlZkK05qeStIbDZGTnRidjYzR3pyZ1psVlRY?=
 =?utf-8?B?SFRLVFBDTXdFRlRqdzF2Q0llVUthek13ZnBiR002Z0x5ZDg5Rndpcmh2YW1Y?=
 =?utf-8?B?YWpkZzB4ZEdCZk8wV2lqaUVxamRMTStnTnFXTTd0ODY0VWhhZzdZWVkwL3pE?=
 =?utf-8?B?SG9VTU5VeFo2NFFhZFBQb0oxMVE1VkdZaDNCZlBGcGxKVzZYWFpmTExWTy9t?=
 =?utf-8?B?V0ZZbjQyU0JvbU5lUHFITmtGejVLd1lkV0RGZkZVcHlhejhkNjc0UFdDc281?=
 =?utf-8?B?M09Qekk3bjhVYlNKZzJzNVJYTU01ci9xU1JSZUNnUEhqRXV1c0JzQVJvTUVx?=
 =?utf-8?B?WktVbDZVRzVpZk5GZ1dJNXVVUk94aTZwekNoUVU0Sm5FQ1hVSTZyOE44Lytl?=
 =?utf-8?B?QWxNOVNvVzl1eTlDTFFkRzlBcm5pNlk4V3FzMGVBdzFrbm9KeFNPTlRIYXNH?=
 =?utf-8?B?OThXTFYvMUxXWDVWNnh4NGhxd241Y2Fkbng1YnhjaUFxdll5MFJqQm40SktP?=
 =?utf-8?B?OStEb1hFR09SM1BRblFiQ1d0aU1jVFZrdVVJOXNwYXR2dmY4VnpWZDAvd0g1?=
 =?utf-8?B?UlZIMmpZWHI0eHl1aEJNaWFMMnR3cVVINjN1Y1JOTlN6bWVHaEhTNEF6VGF4?=
 =?utf-8?B?M3BVdHl6ZDVOZzNWSkN5enBZWDFENjRhQVdBbEYrRDF6MjErWFloWUhiVDE1?=
 =?utf-8?B?TTloKytNYkV4SXlpbm0vSXZxeVhYSTFVQm90SDd3bG9QS3p0ZHg3dTNkRFUz?=
 =?utf-8?B?REcxazNWdGMwa0dtYTVaSlJkcjZWWWpabzZ2TVhFWTBrcGQ0eEtEM0tybzV1?=
 =?utf-8?B?OXo5L0xEYU8zS3Y1OEhHYjBuRS9vRWI4MllvRmVTa1NmSno4bWZkVlJOMWdm?=
 =?utf-8?B?b1QzNDg0RStiaGs3QWFkUnppLzh2ZzBZYks0TnpKd09jZ1lZZVlBUVNwbWlm?=
 =?utf-8?B?WlY2SWk1d2tKVzBaTnhWc1BJQlVwbTFYbkoxTHNibjhnWmpxRm0xVmIxUHpm?=
 =?utf-8?B?OW1JdXM3Y2dsMUZPSnBsV1dmc1REeVc2elNYdVppWG9UNjZqUmV5dFdEalRo?=
 =?utf-8?B?TFhhVzBFUE03Wnp3ZnYwTUxnMmhsOFpBU2c1eVUwNlFnbUZjVVdJYUEyK1pW?=
 =?utf-8?B?QXMwNEhFMTEyZWFDQ0hOdEFTTWhpN0NidkVSWVRlRjJYVWNJSHJncnZtYkl2?=
 =?utf-8?B?SWNhQlhCc0NmMU5JY083UjVmRDgxbktHbjJWdEp5b3AxS1crYklJbElyZFJO?=
 =?utf-8?B?eGdWTnJIbjcxTzRMeVRLcFYvbythanQ2TERLNEdIMTdGN3Q5OHBNakRJZzFX?=
 =?utf-8?B?SXQ0b3hPWC9wS2YzNEZTZkZJa2RYVXBGR2lJaWNmOGtPSlNORnZLQk1uUXBY?=
 =?utf-8?B?bmRQL3RaUjZLRGZSTVNHL3plMFY2Z25LVEs4bUJjL0RpVFdIWmpOcU5peXMw?=
 =?utf-8?B?VHNIeXNHUHE0SlBHS1daWm9KbWJKSFF6QW1WWjJlQXBmNGJvWWhWR0d2bEF4?=
 =?utf-8?B?MjFHYmpVUmxrNW1kMmFMNU9DWUw3TzZjL1ZPYk1rT2dTTTR5Y3dUbnpHWStj?=
 =?utf-8?B?R1V0TE9mYWVocTlIdTI2WTZhaGo1ajcwYTlMbHAwRFczRkJLKzFlQkJoTEVo?=
 =?utf-8?B?UkNQREVydFBIZVFSRExFSFdIM3FsZ3JtU3RRaUl5NEpVcTNxdXZvdjhZRFZB?=
 =?utf-8?B?b3ovS3ByOXgzRjVVY1kzNmdlNVVOL3hHeVVKTUlyL2o2aDZETVlhQkRtNHl4?=
 =?utf-8?B?UFpFV1kxbUhlazBXejlrUXUrdnlBK3d3Rko4QnM4d3VKbkJFS1JsOHlXNGt0?=
 =?utf-8?B?VS9aNkMrTGVVQ3V6NWsxTEZvdUwwcVkwNTgrVkFUOHFUL1ZSUS9wamdZYTlY?=
 =?utf-8?B?UDJGUTBYbWJ5bklMTHhRNnJqLzdFTTNNeUdleUxXZFJDWUo5MkdBcmg0VEox?=
 =?utf-8?B?QVNUNHJSbzhWSzQ0V1NsVmt4RjN5TGQwdUdubE1tVGxjbjZMMno3VkpTQ2g0?=
 =?utf-8?Q?VUoBsNOUFMUC84TefPEesAhzK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2ivg2g5UrGwblV7ONlSFNR3aMzO9eyGYFCJlUwa6RKWfn63CJ0U4+gEbQEDXcwgFhJ0IvfSmCRcS04irH/Hvu7BKqu7inCL21pEw2tOPooeeZmO5AsiyXlmEH0aNfbtE2iKHE+Krbu1hMfkv9tZShpbO2f4IVKl8R8494cRQk0VvUseKikUBwwo3BgUPv/siYdl/Ug7QvDI8Dk/fd9vOsLra6DFqDfBpMYROn4FiR1rQF5ySy4gVXATZNc6iYWnpiw6QapLPG0LA9wSIPkd0JRinxt/V9h6bQjnewBBoXQW4vNbbkDd5Wt6vqSdscEU/MiFstXRvWe9xcuQJVquSzwp1E/1vgYkOVfi+iBegJNSfYaY0gJre7Sc+jWKN0c6k2utzsylsss2qtIS+ymjGzkQ5vHYsMUrn1uzk1U32yRf9qL6MO/X+l3NWmN3KHBj7YPvCQM9lgfcofQJjXalpl2UqfZdilQlNAwQ1QM/NjM9zyYVJwxq7kLTepqNX+extuN0i8DD6ARMGwy15+bQDA5ccgQdKQ5egMVgBYK/zL7AoznlFsSx0HSG5NS3Zick+smYeVoDR7XTxxZrJsDeOP2ipmIWON21i/wkBFbee/IE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cd3535-ccc2-49fe-f2e1-08dc631c102d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 22:32:16.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcNVkfdBthkLHS+QGPaqhX2S9CToAeDCDjuouRmZUk1zQZg2I3g7UNbef36PkOPYmTHFNN5Vs4UrTn1pJW/EXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220094
X-Proofpoint-GUID: OAZyCMdhaA5HgstcFtR8zMkR6BdZCena
X-Proofpoint-ORIG-GUID: OAZyCMdhaA5HgstcFtR8zMkR6BdZCena

Hello Greg,


On 30/3/2024 12:11 am, Greg KH wrote:

> On Wed, Mar 13, 2024 at 02:07:13AM +1100, Imran Khan wrote:
>> [ Upstream commit 9fb9eb4b59acc607e978288c96ac7efa917153d4 ]
> No it is not.
>
>> systems, using igb driver, crash while executing poweroff command
>> as per following call stack:
>>
>> crash> bt -a
>> PID: 62583    TASK: ffff97ebbf28dc40  CPU: 0    COMMAND: "poweroff"
>>   #0 [ffffa7adcd64f8a0] machine_kexec at ffffffffa606c7c1
>>   #1 [ffffa7adcd64f900] __crash_kexec at ffffffffa613bb52
>>   #2 [ffffa7adcd64f9d0] panic at ffffffffa6099c45
>>   #3 [ffffa7adcd64fa50] oops_end at ffffffffa603359a
>>   #4 [ffffa7adcd64fa78] die at ffffffffa6033c32
>>   #5 [ffffa7adcd64faa8] do_trap at ffffffffa60309a0
>>   #6 [ffffa7adcd64faf8] do_error_trap at ffffffffa60311e7
>>   #7 [ffffa7adcd64fbc0] do_invalid_op at ffffffffa6031320
>>   #8 [ffffa7adcd64fbd0] invalid_op at ffffffffa6a01f2a
>>      [exception RIP: free_msi_irqs+408]
>>      RIP: ffffffffa645d248  RSP: ffffa7adcd64fc88  RFLAGS: 00010286
>>      RAX: ffff97eb1396fe00  RBX: 0000000000000000  RCX: ffff97eb1396fe00
>>      RDX: ffff97eb1396fe00  RSI: 0000000000000000  RDI: 0000000000000000
>>      RBP: ffffa7adcd64fcb0   R8: 0000000000000002   R9: 000000000000fbff
>>      R10: 0000000000000000  R11: 0000000000000000  R12: ffff98c047af4720
>>      R13: ffff97eb87cd32a0  R14: ffff97eb87cd3000  R15: ffffa7adcd64fd57
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>   #9 [ffffa7adcd64fc80] free_msi_irqs at ffffffffa645d0fc
>>   #10 [ffffa7adcd64fcb8] pci_disable_msix at ffffffffa645d896
>>   #11 [ffffa7adcd64fce0] igb_reset_interrupt_capability at ffffffffc024f335 [igb]
>>   #12 [ffffa7adcd64fd08] __igb_shutdown at ffffffffc0258ed7 [igb]
>>   #13 [ffffa7adcd64fd48] igb_shutdown at ffffffffc025908b [igb]
>>   #14 [ffffa7adcd64fd70] pci_device_shutdown at ffffffffa6441e3a
>>   #15 [ffffa7adcd64fd98] device_shutdown at ffffffffa6570260
>>   #16 [ffffa7adcd64fdc8] kernel_power_off at ffffffffa60c0725
>>   #17 [ffffa7adcd64fdd8] SYSC_reboot at ffffffffa60c08f1
>>   #18 [ffffa7adcd64ff18] sys_reboot at ffffffffa60c09ee
>>   #19 [ffffa7adcd64ff28] do_syscall_64 at ffffffffa6003ca9
>>   #20 [ffffa7adcd64ff50] entry_SYSCALL_64_after_hwframe at ffffffffa6a001b1
>>
>> This happens because igb_shutdown has not yet freed up allocated irqs and
>> free_msi_irqs finds irq_has_action true for involved msi irqs here and this
>> condition triggers BUG_ON.
>>
>> Freeing irqs before proceeding further in igb_clear_interrupt_scheme,
>> fixes this problem.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>>
>> This issue does not happen in v5.17 or later kernel versions because
>> 'commit 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")',
>> explicitly frees up MSI based irqs and hence indirectly fixes this issue
>> as well. Also this is why I have mentioned this commit as equivalent
>> upstream commit. But this upstream change itself is dependent on a bunch
>> of changes starting from 'commit 288c81ce4be7 ("PCI/MSI: Move code into a
>> separate directory")', which refactored msi driver into multiple parts.
>> So another way of fixing this issue would be to backport these patches and
>> get this issue implictly fixed.
>> Kindly let me know if my current patch is not acceptable and in that case
>> will it be fine if I backport the above mentioned msi driver refactoring
>> patches to LST.
> What would the real patch series look like?  How bad is the backports?
> Try that out first please.

Sorry for replying late on this.
I gave backport a try to get a clearer idea of all dependencies.

Some changes like'commit 288c81ce4be7 ("PCI/MSI: Move code into a
separate directory")' are refactoring the code into multiple files and
needed fix is based on this new code structure. This can be got around
without having to refactor the code in stable tree.
But so far the main problem that I see is that fix is utilizing the framework
for runtime extension of MSI-X irqs and some of the needed commits (like
'commit 654eb939a0dd ("PCI/MSI: Move msi_lock to struct pci_dev") are changing
struct device and struct pci_device and this will break kABI.

Could you kindly confirm if a backport that fixes an issue but breaks kernel ABI
is allowed in stable tree ?

thanks,
imran

>
> thanks,
>
> greg k-h

