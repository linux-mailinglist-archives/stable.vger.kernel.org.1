Return-Path: <stable+bounces-180480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4100B82F34
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 07:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1158365A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA002727EB;
	Thu, 18 Sep 2025 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ifzc/1uz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCrikhnb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113AB21B9DA;
	Thu, 18 Sep 2025 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172165; cv=fail; b=rn+JPXox14/74jlMOAOFOfbv0OSsq6cD4bwUgx1TIEn/hsgf1N+Cn7Cxn3oNDUMIndRgbBFm/0KKO9lknVZoZkdO3T/sL6Ei8fvo3thzjbtWLAhcLoMV3/41L2cGa/1LtotcbHd4H6UfVQNQ86JJjquMWAC9IMLVSqn5w5kwd9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172165; c=relaxed/simple;
	bh=CXt+kpC2LlzWpZhU+gd1Q6PRAj6cEYN0EPdzVlC6M9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1nGN06URtxoiTtadjUWNArRyakSeIgjF6/A/VvKr3pdIJb1rJHq1X5p8PaX2EFRJNXSCbpqlZ5cBOK/OqUGbrIZFfrHvi9uvcbcZTl51EmAOBxBHogI122zsWB2cL6GNU8Wz2u/rcN024XxMDQhSPcTcNmxKe+ktSzuH5KHbrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ifzc/1uz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCrikhnb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HNPvXi007349;
	Thu, 18 Sep 2025 05:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3PSZ1FUiTh41XwHygI4jjdCYHcqTammm1OUNB2ne95U=; b=
	Ifzc/1uzP8DV6rrhv/IdeNaJ0sJ9eqV4zd4HTrIYU7HQBRvGoIWqOMHbv/cmNuLY
	u/QLWQS0zKyGT41dgITLRYE+HB5ShnBkP6UTkpY0D9LA7FzEUWE4ve2M2s+DUIKm
	phgZqtUd62H3ceKPb3yq1HC6oVBCFeFG8IZsv17PP75sgYRgMvD8CbXmz4gbv9TS
	KpYDDzejHURyeAlxIPkz4sdmYPcGvauDH2q6pdlV8MXZnZgcziMgys6ItkWXyJwy
	4MA4rjR304mAzBZGZYCjBTbkERV9i5+R5pqEANYt/EJUI0HuSHCxRxLL8EAu+tr5
	KkV1p18XbG7cjn8lQaKdNg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx92mvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 05:09:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I56kqp028762;
	Thu, 18 Sep 2025 05:09:17 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ekp26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 05:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHM9wa2ZYHAGz92UEEkQi7DzlZoJY2fSCYs1ME9Xto2N+W1SVsPY2kOqhXY5v/U8zJQ61vVEAg98V9chmn/XucO92XKSlbzhI/dsIFyuqBQ4GfTFuLxY8tPBwxNJCAzFY0AXnxLOi6feer9LfwRfwraLTvqAJZL0+QEGWgQZzBHZKE7XohjZgd5jz0VrpVrjccxPvs8OfA/yGM82xRPvNVJEu4N7dItb93uxuRhld1Kap3cacZ2ObDSfq15nqTStAaLXJLyKO4ahD29NjQMMOoAlgGjoJlriZQytX3JHYQ91iGuJxY+y8eLzp7WpDGBG9DaHgZ57a/vd2//dZIsxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PSZ1FUiTh41XwHygI4jjdCYHcqTammm1OUNB2ne95U=;
 b=cqOWMRJtysFNsMr38yfdpM3e3s34gsxnTMBjwdDB16D3cB/qzsVLJO1A2KG0/lepBmYcBnYNfzM6EFmM1Yt0EpJFwEZsmxMk/TydED3Ma8g9rIeefhi9HmbHAIbv8wNMpEhvZXuwW00P2tvG8QkNjfvCOqD7a41/N9OvIilrWHni+RrYoByG5Ygz4qrESmMr7itlRJZkWj6XG1WPS0Fkh4ZbHU1hTisbgUobiUwrbzXlGpbFmuGZmmQ09VTjbI4jZ+CuP5Ice3oEn23kDbc99984/eO654yqnqLmqzwDtDmvISGG7HCuhC7HmlbKWFH9luI65YS6UZuUKcm1amMLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PSZ1FUiTh41XwHygI4jjdCYHcqTammm1OUNB2ne95U=;
 b=cCrikhnb+T41WP63wd+DYFdH4dsmCHKRYPV2zJtvaxtk5+OTcI255pRf5dM8+pYKNUckprWTBShSOOv2XRzSwHcSlOzSq5uBH0ZnSg9FsdH9fJ0CW3TJmFNQY1MkLZUzyCcJoytxeoVN0Ls31EPLIUpWqb4++NaPVVeUIw49/9Y=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 05:09:14 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9094.021; Thu, 18 Sep 2025
 05:09:14 +0000
Message-ID: <26786cc6-79cf-4f6c-a217-d1358aacfcc0@oracle.com>
Date: Thu, 18 Sep 2025 10:39:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v5.15: UDP packets not fragmented after receiving
 ICMP "Fragmentation Needed" (works in v5.10)
To: CHANDRA SEKHAR REDDY <ccsr007@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "arun85.m@gmail.com" <arun85.m@gmail.com>
References: <CAHD5p1U5vrrcT1QpqPDwEgQJANdX67N-j0Hy4sh2ED+6BPMstQ@mail.gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAHD5p1U5vrrcT1QpqPDwEgQJANdX67N-j0Hy4sh2ED+6BPMstQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a7c30e-f8f6-47cf-0bfd-08ddf67182a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVoUTIydUdZWVpncFVrMDMrM1FONm5KTTJKeHJzeFNrcGV0djQvdTB6WjZt?=
 =?utf-8?B?SDAySjJYWEJmQUlmS1lDdEdrcnpNdUl3ZHpYb2ZzWEoxUXJlUloweFN3ejh4?=
 =?utf-8?B?OHpxM3FyUy9nSThKajVkaWV2SjF0YU9XSGZMZEU2QUJFbDFOcDdTbHkrRTZN?=
 =?utf-8?B?dVpQR2JvRzRISFlrTXBBZks1NUJnbjczc2haT3M1OElxZUdlbGlSOURNbE9H?=
 =?utf-8?B?QXlSRStPeWhJTDhTa0c4Vi9nK0k3ZW9PTm9yeXRZdCt6OS9mZlZnWkpieU8z?=
 =?utf-8?B?WkFIOTFsM2NjazlTYmQ2NjhkNDMwUkwvN016OUIzQW1rNHJnM0Z1QzVaSXhs?=
 =?utf-8?B?NjlCVzg5czNBWnpkRi95S1M1Y2NnRWp0V1laM3JGQVZRcjNlVUN5UlE2NFRN?=
 =?utf-8?B?L1M3QVlyZnNycmY5K3FISnZ3cytZNlAzM3gxeElsZ1lKajRscmU5bis5dDVB?=
 =?utf-8?B?TCsyNW9mbU55ZzdXU0wybUFhSm1qUzR0dVpPRU9qUHdDeUUxYUFjcHFEQW1H?=
 =?utf-8?B?d0pac2thbE8vaHhlUjRiMExlaHRTbDl3SStpTUtaMWpsS2RQeFdMclg5Y3Ri?=
 =?utf-8?B?SzE4R29HdUcyUGtKZXg2TWVTNFdVRkFWdGFXcDRGOXNFYzVGdXptcHp4WG5o?=
 =?utf-8?B?QkZ4eCtOMTdrb1NaMFdOL0RpVGc2WWJlRk4rM1RzcEoxT1pyQnp6S25ERXI0?=
 =?utf-8?B?eVRlTzFxaHhUVlJQcHMxZXRmZEsxYWEvZi95RGZJTjRKVDlYUzV3dW9JYmJ0?=
 =?utf-8?B?d2cyYVpKajZHMlg4SVcxMnNWYWxjSWZ4TlVMZkp3dW45bE5UcXZWRmdKUkMy?=
 =?utf-8?B?cElNcDhjdDllWXpRSGhlZ0ZTaTF4TVVaZVRuNThQZUFlNWZ5aE95cmZRNmRM?=
 =?utf-8?B?NWt1ankyMklhMVNjTThBc1ZmRzNyR3NiUEw3TGEvMGp5V25WUXZnVDU0cERH?=
 =?utf-8?B?VkpvZzNXeHFnSFFWRFFHUzR1QXJJdTJVT3NkNk9QMStiUzJGR1N3NkYzZ0xV?=
 =?utf-8?B?WG1IWURYUEtQWWd2a1pYdVVRd293OExyNTF2ZWt2bnNVVjFFRzdya0p2ZndI?=
 =?utf-8?B?NHlsNk1oZGdCV0tKR3N1Q1BXdUlpZWtwamJOOTdLbWNyZ3ZUV1dqd2FMUUR1?=
 =?utf-8?B?NHAvdytjaFdidXVZOUcxTVllYnRvKzhRZnk5TTVHeXZkd0Y3YnVUVzhDSlFG?=
 =?utf-8?B?VktCKzRCbU5vRk5idy8vdnRRN284T3g5elpQM1RKeHFNaWVVYUlYNVNBY1I5?=
 =?utf-8?B?eTdqSmVDbGl1dS9HS01GWnJ2VGw3OWJYSEh2Ni9JdFFPR25GY1c4ZXJaL1Vz?=
 =?utf-8?B?aFE4c1dabkJuczVSaW9aSnFuNEM2TUs1UURaejZoMzlEaDdVWmd3c21BRE5t?=
 =?utf-8?B?VWJLMjRQWVIvd2o5dTZEQ1BKcTlWS1ZTM0xjSm1PZ0huYnJwZE9zWWpjeUk0?=
 =?utf-8?B?T3VET2phbitFZHVtYkFWK3BwM3J5MWIrUy9uNldCRWhuM1p2SVFaczF6UG5R?=
 =?utf-8?B?b3Q2K2UyOTcyNmVCdEhrdGNucnVZcXU2NzN2WU9rWlVyL3BmSHprejU0T21O?=
 =?utf-8?B?SDJ2cFBwMS9XN1YxS0diOXNCWGdON2tVT1kyL2htMkxMQ1ZKM3lYeFZrcHMv?=
 =?utf-8?B?NWs1djNZNjNhZXl0WFpXSTdnU0lOY05TeEQ4MGhIbEJwYnFQaHA2WGZBalgz?=
 =?utf-8?B?bTJZd0xrcmwrL2NRR25QSDQ0Ui9JamVXT0krRGxwVkF1bTQwSEl3N0lnaUhq?=
 =?utf-8?B?bUtQV3JoQ0dreDRyVmM5aDVOUGN3U0trRjFCcG4zcnpBNGZCbUxDYWVwd2ZQ?=
 =?utf-8?B?OUZUOXZkcG12K2ZUcmtFVHpNc1IvcHJyZWhHSWxESGpFWTBWWTg2MElVOTJE?=
 =?utf-8?B?YXBSanVkVTBwUjVZSVpYUDhKVUxUTnlMTFphT2FpanFSMnVLVVhIbXhDWjNI?=
 =?utf-8?Q?XmJkwVi78IU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1hBK0JOaDZWWitBODE2VThRMDlQdmluUjJrVk9WNnQ4Zm45RFdERjEyWlNO?=
 =?utf-8?B?ZFIvNS9Fc3Ywclh0U3V4eGFEeGRMaFA4Q1pmYnpVbFJKN1RpaXRGRTVKK1Jm?=
 =?utf-8?B?ajhGbUhnL2NqL2p0OGpsNDBBZE5makxSeXhtY3FCU2FFMFpIQktJMDduT010?=
 =?utf-8?B?cUE4QUt6VTBBYUFkeER4T3JjczVUYjh1U1FWbHBVblFVUkZLL0IrV2N4T3hm?=
 =?utf-8?B?aTM3aElhVXBTOEdTNFI3YktQckprRGxqWHlKMS9tQnMrcGVGL2JvS3lxd2dH?=
 =?utf-8?B?UUdrblRYd0Nzb0cxYllJRmIrTmVGVHVUZi84eitqOW1aQm5zSWpqaXhodnd1?=
 =?utf-8?B?Y2cxb05HZTFRcEc0bVpsSHBZY1FMTWcyangwbFFVdEk3Nm5uNTd4akpiblpC?=
 =?utf-8?B?clhtaTMyTjVtcUNDU1pQOFJXWU1LcnoyWWRSUW5aaGl3azRaNjQ1WWxybUky?=
 =?utf-8?B?ZVBNRGt2cFV3ekJRbG9QTTZZSUtOOXQvTUFXSWJBcEdwQUtFZ2IyVlpOTjFU?=
 =?utf-8?B?bjYwNHdJakpiM0lwYm1GMjNSZzVISUZITmJRYlIrRms5Z2NPejlmZjlId3VK?=
 =?utf-8?B?eGpvL083Y2IwaXVSTHZZOCtyS0JHNHpUc21hVmFUdGZmMTA5WFFKeWpKOTJX?=
 =?utf-8?B?ZVVieDZ4U04zSHdHbDVOamg4ckszNVVFOFI0QnUrV3pwNWN4MXl3Z0tzQUhP?=
 =?utf-8?B?NlRpWDR1KzE4Tjkzc3hld2NVZzcyQWcydVYzVjRCUUtVb0NXekl1MFN3SGNS?=
 =?utf-8?B?UzM3NHREK1gvNU14NVVoSUw0d0xXcVBlTU43SjdsdGRPOC83TGpuV1lweHhR?=
 =?utf-8?B?YkpqMGcxWTJ3em5qaFd4MnNKcUgzYjh3VmNoaCtwMzBMdjhLblVYQWdmcnI3?=
 =?utf-8?B?b3ZkZ0NIK1Y0VnRtZDZoWVY4S3ZjZGdueGt0OFJUVEVEZHZ1OEgzS0lmNktZ?=
 =?utf-8?B?cnppenRmOER2R1JycG9SRmN4cVFONXNyLzhjUCtxb2RxNHVlMm1nWjQ0SGhG?=
 =?utf-8?B?eHg5Sk1XTTlpa1FTV2N1NDBZVjhveit0QlJlZDk0cE5nTTJ5TGNqM0ZWYTFh?=
 =?utf-8?B?OUpPVGtURXgvb1FtV0dJM1A3OE1KODZIZXYwSm9QOVBxUmREQ3dnczlGa0Uz?=
 =?utf-8?B?OFNtVHN2dmRndGQ3VVNFa29sN1BXTEJOMXlNd3VzV2FnQm5yNFc2Ly9QZWlU?=
 =?utf-8?B?RHVWSnhTWndOV1A1STVWMlVrZ1dmM09vbjQyTnl0dCtsaWlBQUNMamswM1Jx?=
 =?utf-8?B?Q2pXdmFIV0phN3NBQWQxajNKM3ZCTW0xWHI3aDduQ0gzSmpqZ1liWHNMMGFK?=
 =?utf-8?B?aTEwZUhXODZYZXdrbWFWM21BYkV5WHNudTVia1YxMlgvdi85NThLWHlWbFRr?=
 =?utf-8?B?M0FBM1N4Y0M2RXFpL1BGTEY3K29BbDAzNGlGUHRxbFNrNlJoMUlyNkhqQTh5?=
 =?utf-8?B?anQrL1UwZ2FQMWlaNzI2VmVlRWw2U3FkK3loUElmN2VoVm9BazZzd0UweHNJ?=
 =?utf-8?B?ZFB1SnNuRElteWdBM3FxeFoyZDg4SHhpM0M2Zk1PSGFkbzdRZ1ZJZm91MStJ?=
 =?utf-8?B?L2JBdXFUZm8zd2JOenlXVG4yZGNCUmNZSDVsbnNwUXpuU2dhczlZeGU1bDJt?=
 =?utf-8?B?aDJEYUNPbXpEKzdEeSt0NjE3eWpVQWpPbG5MMDJ6aFVDa0RXd3JuTlZwYjNI?=
 =?utf-8?B?clVzRFhNaVgvZ1dTNFNFWFlIUDFwVWdqNnFZeGdWNzhGL2VqalkwTS9ldjJx?=
 =?utf-8?B?T3NCSHBROWRtYzV1M1hTVzlhZkQ4aXdKSEc0WGdWdlF1YWdCMWJhSTd2UWMw?=
 =?utf-8?B?TEMycHVqbXcxak9mUFY5eTJ1bjl3T1Fic1M0QjkvV2t2VEtLNTZPcGExRnp5?=
 =?utf-8?B?ckpsdWVLNzh2OXhXRkxaZkZUTzRPZ3UyOE1qM3dvcFJZSlpRaXRzYkEvT2dC?=
 =?utf-8?B?aGFXVm4wL2UzL091NWNjdGRPKzNiMTV1NURNM09yQ3NoRTZVQTRVbGNNaEFI?=
 =?utf-8?B?ZUlIYkRZYWZobzg2UFVaNkhZeWxuTGZVdmpjYlh5Z3ZOVXlLTlFMdXJUMEtI?=
 =?utf-8?B?cVdQYTY1NWVnKzJhNmswcms3RGNKMElKU0ZLcCtPVmVSeWpycFdQdDhId0dX?=
 =?utf-8?B?Z1ArTGtWNjJqT0Q1NmphV1JqQkg2bzR2aTBIZWE2RjBrUURPT0dhRkJUNGhS?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bW6rmTlj/WqzLR+0sdVSLTGfza7MsNPH1mYd9vnfRFVcDzfmrK35SCrE+etEPLxVqOcfICo6gpNC72GdWz9CADz5nb8PThRWbF9+YGcc4oEKr6OqWB85vlyCf4UF9BTDNk5LtqaYQgsWyDGfB5GYIKAAA8PWy1ozdqbWER3a/AZTyTEuclaqi18MKzpXEEAZ69VY41oCsUgebQQmLSmrG/C7Zz5fHxTihH4lq3htXSysQLMgmspxTDZ6sARc+9mn7Mdia2KrNoEmTaJvzzERwu3keqN9wCM4AOfd/nmxroXoEjCjj1BgmRU4vMCThvSzuFgV8LcviDuhHgjppsQCzWlqaBOWbA6a1Ddd4uhP9wAGr1JJYRwpucxzFd12/+PBp6iZjSnnmHvM/7pcd3YtdTDKOffs43o0m4O4OEl/CC9TISq+hgXkl81sUm5CG0OoReyypJJxJ9uvYrdp0xs3oFlxeSXcEBGpHUAKZR/nCvyl0s3KAyfTJRwziGIz7tdjV26zY9CKSBIEy+0smPkKKpl9p7AC30S2iYhKy3LJHyzv+N9DUZKQIjEmcY/dftYIOA1DHSkiRqK2ME/z9E+OLlfVkFETtfA1zr+PxUBRcos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a7c30e-f8f6-47cf-0bfd-08ddf67182a2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:09:14.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAaeTDLbcVquXV/zlHxnD3fXeN1pP0OWaF/DZG5287lVg1dEzqo4qw0rw/noD9PKkCQY2KHAirhTqYrKJp0+JTZLXJlTaNIq+iU0kAvYs4L5/opUspbB3ueURDaBzAp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180044
X-Proofpoint-ORIG-GUID: rJWrJmWvQM7FH-d9PZ_oC2r8kUhCWexf
X-Proofpoint-GUID: rJWrJmWvQM7FH-d9PZ_oC2r8kUhCWexf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9QvKymsD7gyN
 9OfVFfNjtsaWAm4PCYdykR3qgh3Ne0IOKe2VTgsqTgtS0yXceL4BAOp29FrRu8OnXnPb6xIfhlM
 REJgZI831hf0W8IlA5cjgfpLx2XScY1LO73DBfcl3ux+zGHdjFexEOKeCzMwhGd0aMgs//8uUih
 O0fFuL/ajecEkEC8E11Yy6ztWCkwM742Mg8o1JQT8bEOXsGZLaUHK2AKmtBjq6KOtzdtD1zJoP0
 NRHw3lCfZMJMS6MlIzj+VKlrsFVYFzJqAKiG9FlegYl4LxZ/hxh+HCFId5LtHDQLbpyTmsItrqa
 X716dsL/k4SJ9kDPvqEJbFKqwvkDSpS9OCmU34uujxzoKxIakQ7UoVD3IZojnFvYD5kbakCOAFf
 JvFI2Rfb
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cb93ff cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=6EyYywLGfX6WYdpxRyMA:9
 a=QEXdDO2ut3YA:10

Hi Chandra Sekhar,

 From a stable kernels point of view I have some comments.

On 18/09/25 08:54, CHANDRA SEKHAR REDDY wrote:
> Hi Team,
> 
> We are observing an intermittent regression in UDP fragmentation
> handling between Linux kernel versions v5.10.35 and v5.15.71.
> 


These both are like really old stable kernels. Can you try with the 
latest stable kernels ?

5.15.193 and 5.10.244 ?

If you could reproduce the same on 5.15.193, maybe we should try on 
different kernels to understand the cause better (i.e 5.15.0 and then 
narrow it if needed)


> Problem description:
> Our application sends UDP packets that exceed the path MTU. An
> intermediate hop returns an ICMP Type 3, Code 4 (Fragmentation Needed)
> message.
> 
> On v5.10.35, the kernel correctly updates the Path MTU cache, and
> subsequent packets are fragmented as expected.
> 
> On v5.15.71, although the ICMP message is received by the kernel,
> subsequent UDP packets are sometimes not fragmented and continue to be
> dropped.
> 
> System details:
> 
> Egress interface MTU: 9192 bytes
> 
> Path MTU at intermediate hop: 1500 bytes
> 
> Kernel parameter: ip_no_pmtu_disc=0 (default)
> 
> Questions / request for feedback:
> 
> Is this a known regression in the 5.15 kernel series?
> 
> We have verified that the Path MTU cache is usually updated correctly.
> 
> Is there a way to detect or log cases where the cache is not updated?
> 
> If this issue has already been addressed, could you please point us to
> the relevant fix commit so we can backport and test it?
> 
> We have reviewed several patches between v5.10.35 and v5.15.71 related
> to PMTU and ICMP handling and examined the code flow,
>   but have not been able to pinpoint the root cause.
> 
> Any guidance, insights, or pointers would be greatly appreciated.
> 

Thanks,
Harshit

> Best regards,
> Chandrasekharreddy C
> 


