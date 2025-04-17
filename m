Return-Path: <stable+bounces-132915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF6A91557
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591C016BE67
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65EC2192FA;
	Thu, 17 Apr 2025 07:33:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF8183CCA
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875215; cv=fail; b=MIsUE/4MbJJHtHVy3GY/875r6WGPTv7TTz/FsBguq4k6h8XSocxTToQYysJwaGfqnsvNoDaewherkx6JgFAaHnh8Shy9pMLvvxvve3sbbiYxgXT2m2MXz1W586nIPMQ/w/MrvmkgurUSVt7ZMHrRhpOCeWxWj3Q9fOHgWriFVpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875215; c=relaxed/simple;
	bh=LoAnB+XKlffguIF/NTuwQ8eu6TahmFV+iq0joIbTXlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJXDepEK1GCGd9L3p4d1nPxtQqNCbCoaK90yB4Yt9zkGwIVyTiULj6BtLSzfo+WRKQXjW+HHDz+pMp4Abss3NaejnLd82Vh0XTWCtOqf95hFkTNavSIBsYPsQhkSik1f4/S2QqkBJYPhaODYX41EP+e4PK+iMNzLpChwfRZAJpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H4wt62028471;
	Thu, 17 Apr 2025 00:32:19 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ykf3ntrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 00:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIbKs92bA/jJ57Gbi5e4dfbZ3D1DMPksgj5a7g8QXhMB/oN3BoJWJnNXRSFHBw9OptdKEIG3rVxfn6g1a4TMEQVvNTrFDCqCL6HKcJ5KpI5JRqGthCkXP+WaJbIDAu/yziSr5lh+OZuuUrQIsa4sqinzKJEwpUgm7V0Lm7xNzqU2p3SbVmNsnQWTNQIs7yg1IWijSUP/SFkxeUqBhvNyqrq/Kvs+8jUV+3+1+Wr+mxcmF2ER0/KEMLyY7WixiXTX7E2GfOGI819yjyDU0X1/mSl7Q6HO9KdQXiwhQLV5VhPayjZsXApSH5SV+AVDdBbn80XRER/5ck/lcrPDmBwzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM3xLuKCcZfmngKnbStJkJEB815kH6qBvlFVm4fU+eU=;
 b=A6NaVy8yCZuSy8JfqXL7vqRLK/RF7CkjyvsgHp9NuNYB2mFo4mk4kBuV0/74gBGQkHqEuauroIsA519XTejpsYIT4PValuzq21cn0eU20ydyNPiSkDwqi/hN4y5+Oo0gjqkSZixjk05hH97mdpJHeuQyp8iJx1Jx27ebsSGH78hkpJslFESMx7hqxxmabnECEYl1p64uOyb0TVKelp/TKVrS9A/mdeA+9T0uq80flJOm0DV5si2w5+EKWK2Hb63AI6KbSUMw436VsYamVYWvtX37+TSq+I/sIx8KMHoaBsciY1WRKrWw3PhH/kLt8mLMsClWlmfbyZe7wDiXE9PvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 07:32:15 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 07:32:14 +0000
Message-ID: <205d560b-be0e-4ee4-8293-e66023e481c0@windriver.com>
Date: Thu, 17 Apr 2025 15:32:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
To: Greg KH <gregkh@linuxfoundation.org>
Cc: huangchenghai2@huawei.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, stable@vger.kernel.org,
        "He, Zhe" <Zhe.He@eng.windriver.com>,
        "Bi, Peng (CN)" <peng.bi.cn@windriver.com>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
 <2025041727-crushable-unbend-6e6c@gregkh>
Content-Language: en-US
From: Cliff Liu <donghua.liu@windriver.com>
In-Reply-To: <2025041727-crushable-unbend-6e6c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|SA1PR11MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dfc0a8-b40d-4ccd-9ceb-08dd7d81f974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFV3WDlYbStReEJwdWhheUtTOU5pQngyb0JlcUNjQ0ZSKzRGUEFXRjhabita?=
 =?utf-8?B?Q3phQWZoRE5qeG1MaGdMRTVYMjJuUVJEak5DV0ZWQUVHOEJiUk5TeWEwWE9O?=
 =?utf-8?B?bWk3bDdDWGM0YkxNb2FEN0pTa1lKbXhiMzRxNlhZY21jYlNHWEdVbmJJWXBu?=
 =?utf-8?B?TkhqM29IVVZKMVI1Z2NoMHdiaU1KRzdxTFl0S1FQek1PQ1hNMzBNVEdJdGU0?=
 =?utf-8?B?OU9oMGo4M2xiTUxiaytYSkZNVXJ1VW1XOXJsbXJKKzNaZGFmd2NHeXNnU0dQ?=
 =?utf-8?B?U0dtRnFMWVlsVUtsSWYvYlNxaE1XbGlOMmllOER6YkVxTDhScEp6eHREc3VG?=
 =?utf-8?B?TiszRFRRc2tyeVlNMEdSb2pFeVJOOURCSXNobXVkd1pDRTFQOUN2aFdBN2tS?=
 =?utf-8?B?ZnRobVNuV2h5aDJEYncyV3RBU3RqSjlCcStZTFh4K0RwcWwrQ2ZoZnR0TGV5?=
 =?utf-8?B?TDNQa2VTSCtHZmJPaXR0VUpSazdDRklZTDdKNThBbXBhN2p1TThMR1pKQk04?=
 =?utf-8?B?dnFWV0tNeGFEN0VueS9iZkd4NkNyNE5KVHRSd2s3UFRNZE52UXp4L0JwOVBu?=
 =?utf-8?B?VGdWamthK2VIYUo0UFY3T2VIakpydU9GdC9OZUtNa1FwV0JCSEpRVlhDVUZH?=
 =?utf-8?B?RXZJcHNTemRGTVJzQjZqS25DaEdJT1FoTnh3WWNrMmtBVjZnYmdrQWN3b3pt?=
 =?utf-8?B?YTZ5QVRFY1JQNElpU0tFR1hHVUJzNlc4U0crQlFybUpFL2tuZVloVVhjUEF5?=
 =?utf-8?B?TC9yZGo0em9LRThTMDJJeUdWRit3TzBxRlJpa3RJbTNvV3pXSGVKelhsNzNo?=
 =?utf-8?B?b0xKa1lubzQ4WlIyaS80cWwxQWp2VVZCb0NiKzdNWmxmdldnUWtzUFZZd0w4?=
 =?utf-8?B?aEJDbUFiakJXeU4xbkdWWjZOa2Y0R1Z4RTU2SUREcHlpM2VBS3ZPRDJ6YWlH?=
 =?utf-8?B?Y25HTDRncVJhL1RHRFRLMy9JaGFUZlh4SVNUcWExQ3V3TWlNbkcrM1BaQk5S?=
 =?utf-8?B?WSt4Y1F4WHlZTXExcG4wR1F3bzV4MEZsTDBUMUVaamlrSVBHd3JYODR0VVFG?=
 =?utf-8?B?aUVvQjlhaHI0Y3p6VEdtYmhmNHFubzU0c1JKRGdmaW1IVmlINDdIaFIxeXpw?=
 =?utf-8?B?S1ZwRWVnYldpM3hCWWlXeGxmQ3NjUzN3eTZ3UnNtQ3hTczN2S2R5T05xMUxS?=
 =?utf-8?B?dFQ1djZOVkJIRnU3d0hWYTAvMVZyczJGTE5ManhUazBUSUd2MGtTN0JSYWF6?=
 =?utf-8?B?S3h1L1NqaW9SVHh2b1dyR2ExQi83Z1FLdlFKU3BlNEQ0S0hWSDVXa3ZadEZX?=
 =?utf-8?B?Ujc0NWVYN3FtTXdHTzRpakY4eUlhdHcwRllLZElUQm5pclNaT21XZEpmanBO?=
 =?utf-8?B?VnhlblhJVDlGbVdPWWxtUjVzV09QeWYrczNvZ0k2aGlBaURZcUJPZTR5ZGVN?=
 =?utf-8?B?eU9mNlUySXJPdEh0N1pOazdwT1RPMzBZblFvUzBGWldKc1o3d1pCc1JNZDJ0?=
 =?utf-8?B?NjNtbE9GV0pIL090eVZvQlduYjFsS1Y3aXZ6Q3J3R0FsS1Q1WUxXQ1RVUkdO?=
 =?utf-8?B?dUJObE5jaHJPcVJvVTZBS3RpajVzbGtMN1NvZmova3lySVVlTmtiemxhdjFD?=
 =?utf-8?B?aXlkRHoyaExLb0RlZldnYkF2cDVyeWxLQWJQNXVOOFNtYlo1d29MbGZ0S3Bv?=
 =?utf-8?B?RFRNdUdYUUJnNmp4MS9YYmlETDlRS2dZYkl5SmdVelRyQ2RNa2x4QVJFUXVo?=
 =?utf-8?B?MkYyWmk3dE5VWTVZM2hmdTFBUHJ3QmZ1ckpRZ3NRZEd3NVIwREdkMC9ySWMv?=
 =?utf-8?B?TGtLeERSbW8xK3NrVWZQNFV3cUxpK0hFRFArSE5PRGpzdjJRVlJDNDg2SGhp?=
 =?utf-8?B?bDdGT0NGRkNFQWFlRVJnNUlBVkwyZ0oyZjRjWmpHMWZpdlpCaVNjc3BLRnRv?=
 =?utf-8?B?RnF5bVBGcGNtWDJiTXlTSFpMUlpmVFRqYk02eUdMMkVrK2t4bFUzUzJTNmNo?=
 =?utf-8?B?bkxMc1NqWmlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFhQVGNVOEt0dXZBcnRPZlgrS3o1WlBMTU51YzZCd3I0T0xnYWdCU3pvc1lB?=
 =?utf-8?B?cG1wTlRjSVpOVkpGWThVejkydUhjZ3hnMmJCVmh4b2V1YzZBRmV0Ulc2eEpS?=
 =?utf-8?B?MlJWMXZVbGZ2NFFQaEZXQ2NVY2dndFI1NklBUE9yUlZRZUcrdzF6Q25Md0RR?=
 =?utf-8?B?bit3c2UveSs5OTVXb3k5NTZQNEh3cGl1K2NuSXcwd3UwUjJ3NFhUY1NTWDBM?=
 =?utf-8?B?anlhanNHK2J0OXRweC9PaTY3czNsWXliWXhBZzREUXE0L2FRODlsaTUzb201?=
 =?utf-8?B?THZDejNEK1YzdERVckFCUUlVQU0vRDZJT016OEwyRTNDN2ljZEZXSFBYenRI?=
 =?utf-8?B?aUxmM3lTQ2t1d3pHdURlOEc2N1RjRm8ySXpnbzF3WWlvN1B4VjV5NkFqTVdV?=
 =?utf-8?B?NDdEdFR6RHdwTkt0VXRtZVAyNDhTT0RnbDUxa2Vma2JGYlNqa3g4YmMxMmVE?=
 =?utf-8?B?RUxWelREREJudzhoalBLZ0xuN0hCVGJPRk9NM3hIWjVLNUIxN0NHZTZ5S042?=
 =?utf-8?B?SG00aDZOOHE0MDVmQThFSWp5Z0lyS1dpVUlVOFZFcDR1aDF5dG9VSHI1eU1C?=
 =?utf-8?B?aUFvcmtqL1BxRVpRTDlnc3krbTVQOGFLbitIbFZXVU53UjZMUlRYMVVzUGNX?=
 =?utf-8?B?TytNYlQrY2piRkV6b1VWNXhHMXdaTFpRWUVYb0ZTMitKdjVENVE1TkNDUHdm?=
 =?utf-8?B?N3lWNHplYXhsSFhEdnU0U1I4d1g4R280V3ZaRFNWQVdabVRITFNiVitJT3lr?=
 =?utf-8?B?VWNsUVdqMmFYR0RrMTNWamVzK2VHM1MzRkNUN0xOOTlYSEpFK1JmK080cnpX?=
 =?utf-8?B?UU5ENHA1SzZuS3NSVElxakF6N0ZrN09ra0hxdC9JVWNnbDZmYkptb2tFV2Rx?=
 =?utf-8?B?Qmh3L0IyVTdMTmRkRmhBQ0RrZjd0RjBLZkZTVml2akJFM3JqejZsc0lhSTB5?=
 =?utf-8?B?WHVZREx1T3lpMVdEbDd6MEFtOVZvUnNSNnpmSXhZYnNQV1Nya2RuQ2Jpei9H?=
 =?utf-8?B?RlBzd1VyWWs4aFMzQmFyRzNhOVBjU2gyTTgwRFE0b0RZVXBpMG05Q0pvaFNX?=
 =?utf-8?B?QzY0UkxFbTRVenp0UjFYYmVobnU0MmFTRmVlWExHZ1A2blRabjhncWN6cDhO?=
 =?utf-8?B?c2NDa1prWU1qYXBZbGRUM2hwc0Nwc0dwUXJManU1RlpuTEJxTFRCdVdoSWto?=
 =?utf-8?B?MVU3THI2Ris0ZXNjZGdrNDVjenV0VkdMdHdHWHUzUnZMRXFUTUNhS2xad2VZ?=
 =?utf-8?B?Qjh2eW1sZnNpZ0JqNHhqZzVFaVZmVUxLcFNZRUhoYWxGTVRjZUVPL0YvTXMx?=
 =?utf-8?B?TTZKWmdST1pxUUxVUy9xQkNscWZ2NmVuSkpwZEVjTi8ydFpxa3duV3hhNTVY?=
 =?utf-8?B?dCtabndNRnNDSWc1eUpPa3YwSVVXRkZOd1M4YTc4bkRQbEFnSklCSVRaOWJD?=
 =?utf-8?B?Wk1nNlkvOUdtWVFuSHErMENPSnBLa3NSTDBQRndrZjRhTk0rOEFPdjFLTXFZ?=
 =?utf-8?B?V25QZUVFTlhuR0hQUVdpWlcxZHRDaE9UOW5wSWFjb2xqUG5MTWNPRWtCR0FZ?=
 =?utf-8?B?ZjJvbUR1UHAvQVIwTVZSNkJWL3BMdjZSOUlORlFQdXNhVkFjc0JkTHNST0N3?=
 =?utf-8?B?NkU2SWtLQ09yc3ZUOFJ3a01sRFJoalBTMkE5YmI0QTBaYmxKYlVpRGNKeVhQ?=
 =?utf-8?B?U1YrSjRLMmNpVFFrY04zUlZheEl4c3pZNmNXQlQrYmsxK3ZkUUd0YmdMRElM?=
 =?utf-8?B?K3NuKy9LOUtCNTVONEJzWHExbTNDVWdKeFpncCsvN3M2eFVYdzJrV0U4M1U3?=
 =?utf-8?B?TTMwclo1NGc3RGpKYnFndE9wT1hGaytYaENZeGRXZUR4MDFEUm5RNVpFY2N5?=
 =?utf-8?B?dHc1RFE1N0FLTm5CVFdZa1cyVjByc3hpT2k0ck1HMElGVFZkMHEzNGtURUow?=
 =?utf-8?B?aTcxb3pmMEIxQ09HTldiUG1qc0NlclkxZURialhTZnZFOExnOGFhMTdCU3Nk?=
 =?utf-8?B?bEtZZVVkZmFLWlEvRXhWUXBEc3J5bVhldWVaRURCTVAxM2x3dEtIWFl5KzlM?=
 =?utf-8?B?cUlJVGNNbkJWcEZ5MUU0WVl1TGJ4QWFrMkYwYmVmM3lRbUI3TDhmSXpoVy9n?=
 =?utf-8?B?OEtqUEE0Zmcxa2tKRDErWDI5Vko3MjM1OXp3NnNYcFNaUGYrSnl6VkJRRU82?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dfc0a8-b40d-4ccd-9ceb-08dd7d81f974
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:32:14.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjgYBrSRdmDDBnZklRPXWKWBBeHS81wRooVgsDrNs65YnHhAQ5AKJoQ245e1Jup2Rhc0+NKWrlS2BPEbst53Wp6UiS0zu+3bKOwm5d20nNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-Proofpoint-ORIG-GUID: UMZ8HC73DIOQGXhxNlawqWNplkYAXHjT
X-Authority-Analysis: v=2.4 cv=Wd0Ma1hX c=1 sm=1 tr=0 ts=6800ae82 cx=c_pps a=n5+7iF7l5R/EKaY7dbRUPA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=w6hMAXcQu-OzUumtAsgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UMZ8HC73DIOQGXhxNlawqWNplkYAXHjT
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=968 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170057

Hi Greg KH,

On 2025/4/17 15:13, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Apr 17, 2025 at 02:51:05PM +0800, Cliff Liu wrote:
>> Hi,
>>
>> I think this patch is not applicable for 5.15 and 5.10.
> Then why are you trying to apply it there?  Do you have the bug that is
> being reported here on those kernel versions?  If not, why is this an
> issue?  If so, find the files that are affected in those releases and
> apply the change there.

It is reported by NVD that it is CVE-2024-42147 vulnerable and this 
patch fix it in v6.10.

So I want to back-port the patch to 5.15 and 5.10. I didn't make it 
clear. So sorry for that.

I just want to get more help or information to confirm if it is 
applicable to 5.15 and 5.10.

Thanks,

    Cliff

>
>> Could you give me any opinions?
> It is your responsibility, if you want to backport changes to older
> versions, to do the work.  It is NOT the original developer's
> responsibility at all.  The first rule of the stable kernels is "this
> will cause NO extra work for kernel developers" so if they don't want to
> do this, they do not have to at all.
>
>> Any helps from maintainers are very appreciated.
> But not required or even expected.  Please work with your management to
> understand exactly how the community works here.
>
> thanks,
>
> greg k-h

