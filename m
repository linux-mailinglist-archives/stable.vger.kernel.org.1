Return-Path: <stable+bounces-114162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94BA2B144
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF601889E29
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB54199254;
	Thu,  6 Feb 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NtC1dqpI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jC6oiT8a"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBD19ADB0;
	Thu,  6 Feb 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866716; cv=fail; b=pUdpSt16nBecTfSpY60nddQFdzqCF1i1SZPgROF9Q4eGQjef+0uJwIJKZ1czsOET9QlYj6geAMbQ7ucfhP6LAjQhJbL/s0mWyzqHssIEJYiJjk1WFxgsj2ksMyFkGVq8M7W3GbaWchNkVughZIJuNFjWeXMJfvEzj5oBkYCOKZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866716; c=relaxed/simple;
	bh=+c0eH1IHhaSyig2Usw9yVSDeJ2r/XAjryaTFPB2/xvk=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=mHaVB1Q5cOSCk7KqlgMxr/FVxtMQ54TVZAaL7/vdZpqOZMFMebs960UVYc16KLhbpN6BoheVR2lgMzYyTtWDAEHNaRQEmAY1nxMWnbHwedEsBHbtBxCLVfTQGGo9hm0sEcVHVtx2HBstfSWi65ElShh8HrjOYfswrSoy4B+jvt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NtC1dqpI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jC6oiT8a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516GTg4D027973;
	Thu, 6 Feb 2025 18:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=tOvHE/1dnJ5ype/+
	ySs+saYWOecew+DelRgE0DhOpZg=; b=NtC1dqpIVB/kRcSXtLN50wBcfGZFO/yP
	k1W6ojiQwpxBwNoHqeEyAFYj0SugJlPaUNSEGkG7x0HM2VxVUQy8JFz4ALubkLtr
	dg1hcz5yt7pGnnm6gEjYpgyCZBBi6HITTfNtROWE7wbKlob3Rw3xubsZ5t+kV77d
	/0/qbbGiKnezNYvziaj/2AnUc2LUl5s4RWW5zB/7C/4N4pjqxix7NKPKUQ4xD12c
	0craUWhYX9BZZ55FwsQ23MRVXWk8NBTUSy75Vwtiil9FFPMvUhutDULGLEArRnMd
	UEwumQZUzQWCmNyD3bEDeylCsn+4PjYGKJ6iIWMxYX2kZq/+I02K8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44n0nb08hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516HKoDK026975;
	Thu, 6 Feb 2025 18:31:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fqchxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:31:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd6APCvrUct264JQlUg3QwyXRvk7DInzLiQj7yBPtTLrH1p5xdRcFizjnWCAQEeEXyNRdeqCxaUn6RPCTkeNmpLfLd9DvjJDlwWvh50rEqlZTuQ3E/eN30AXfGVbWIpSKd//iSpctv0wIwgAJF2x6RB+ZR7HnCPhHwhSzVvmtZc5JGYjRa0dSfQp+T2RC03uTuhhRY7lVRHb4+YF5GDOUwfvXsOSyLR0iU4C+BDTEeAD7QcwkSSta/k7Yco/8O7RT983X9gx2Trd/VKM/4k4urgULsVp9r8yibCn2YYrq4DrGgiQIbI1nF3fiJTE2ikUIhXzEFQGIsvJZlolk2CFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOvHE/1dnJ5ype/+ySs+saYWOecew+DelRgE0DhOpZg=;
 b=RXm3iDdOhmNv3SSPWhuawIMNTsZo05CYbv2UpA1hBAIpBgEIgOZD3U1waJk4h1Z1AZobvGUYxU7UHAh2iPyWAKAACaKHuhqpcsmP2taAHDj+vxh46WBZil7stVdarg85LoBo9ilpcTQALkiPk7yRU78c3kXT/DzZWUZxqm2uGP6c2Mw+Ff//r7BYC+WtluDA3Yhpg7pg5U6hsnJzsTtWly30TEfME7pBmSPovUHYViWwmVjoidyok9AgsGLoCnyJMLtkm/VhadCk+I9uT89KyOpEk4SHipFDsUttYKnxsftASHW2wocjXieB5+S2Bzf8lL9s6oT9nMxVU49Tx8vu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOvHE/1dnJ5ype/+ySs+saYWOecew+DelRgE0DhOpZg=;
 b=jC6oiT8aIEmjKK/gQyIa8rPEKj37YkJVDekKuvIcPqOZYB38R/T61605eSbIFZqm8ll1s5nuPqrOVQQzScOJa40+ZkFUfRbXqgptVd84t0Ebw1t4yF8zRQiB5HNMesMCr486DaB6YkU/w4plykIAayIF7hk3p3qJbCbhHZjMkLU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 18:31:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 18:31:44 +0000
Message-ID: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
Date: Thu, 6 Feb 2025 13:31:42 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: queue-5.10: Panic on shutdown at platform_shutdown+0x9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:610:5b::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6421d9-cdd6-4dd1-a1bf-08dd46dc81cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzdKSzdTaU8zWDZQK0VFMmdIem5SNHJGVDIzcU1rc1o4Z0VlTXZobEVxUnRK?=
 =?utf-8?B?cUg2eGc2NVJidkhjL0VDYmNWdmRIdGFGRzdmRm1BNFJjZjlaaUZPcmQvb1Z3?=
 =?utf-8?B?MEtrTzNvUER6MUYwcHhKakQ2Sm85bStNcDcxSWt0UGhsZFJyV3JVM0hmZC94?=
 =?utf-8?B?cUdlRHMyV2Z2bDdZLzNDbkoya2EreEw3MEJuTkI0VHpIUVUyMnRzdmR1em5C?=
 =?utf-8?B?YkdBaFNsV3VaUCtidmd1cE1PeGJnaFJWeXF5ZzkxU0FZbElxN3hZaTFvd1do?=
 =?utf-8?B?YlVkbGZGTHh2ay93K2V1WWU1TXZNQXFnNnU2SFdKQjhaUW1BajFhTmp5M2hT?=
 =?utf-8?B?Vk1VMTlCcjdjU1Z3UDRYY2wvYk1GeFJseDJLUDNIWFViRVdUUENxRXdtMTVr?=
 =?utf-8?B?bE5aelNBM2ZlYTdIQTFiMU1BcG82UWlsRzQ1Z1I5bmpmK0ZhYXNMdGs0Q1pY?=
 =?utf-8?B?S0xmcFdWalFCclV2T2NRMVFYSllNOHl6Z2JTRjU0azhqSCtCV0dNalN2VERL?=
 =?utf-8?B?SUpzdTJITlRHRUhFSGhsT2hrN3NJbzBIWDU0L3AwSExjRFQzSUExeXZqSHBK?=
 =?utf-8?B?bTJ4QmhjZDYrWkkxckt3bklDQVp6MG1laUpjaS82Tk5nbGVERFV0cGlxTTBL?=
 =?utf-8?B?Y0NoMWc3ZzZBS0REYkFhbkRxbTJEeTVCT045dzF4aUprSVllTzk2NUVnMFRq?=
 =?utf-8?B?MzBhajR0TjQvTmJYN1doa0tYZDdIQXZRb2FEYXVCbGFKS3RFN2pRZDV1QXlF?=
 =?utf-8?B?WjEyZkY0RHZJWFl3Z24zQlkxNVo1UEdoVnAxUXpKSXBxdm0rMkFKSHhwdC9a?=
 =?utf-8?B?cHhGOXlXdVhFV2N6eEpDbXNzVVpFU09RTUxtUGc5MDk0VWZUK0FCWDJlYWZY?=
 =?utf-8?B?cTRlMS9xUVBlSXpFZWNvditZYzF3bmlCMmd1QmI3am9MWFBqby8xN1RCOERM?=
 =?utf-8?B?OFB4LzY1Z1RHUHdpZXpiMjdZa2VnMVRGbFNYd1VTYnRUT3oyS3NZUU5uRGJX?=
 =?utf-8?B?N1Z3SHJScWdqclB0L0R0empjUWphano0ZHBIYlVma0Ftd25NbDg5SHJFMENl?=
 =?utf-8?B?V29NQ0RVVjUyVktPM2xWTlB0d0dld096TExPK1NLRUZNSVNKaVVwTkxtOFlR?=
 =?utf-8?B?OVBRTHpTMC9ZbmtJQzBVejJTM2gxenA2RFI5eXpjYlkzM0l5OEFPMDNIQnlX?=
 =?utf-8?B?YWo2cXhGSkpRbHEzZnpOWWlNQXNVQWU5UmVLZlNzdUxHVkJYcVd0MzZpY0Fw?=
 =?utf-8?B?ZnZlLzNxQk1RcFNuNjBDUlpIeHUySGh6dXFtM0kxbzI0TFgwNGFERWJ2NlZv?=
 =?utf-8?B?ekNZYmEycnQ1S0M3R0IxZ1BrTWxSUWZUZCs4M1NzVFFUalY0Nm9VM09pN2hz?=
 =?utf-8?B?U3RMMm5Xc0hBekxBOEY1N2UwSTcyVEg1V1gwQk45cmdyTmZTYVJnbmxES0R6?=
 =?utf-8?B?Y3RYVURRT3cvL3JXYUx0clN3VnRYTnd0TXhWbGVNL2tibDVZU3JxdklscmdU?=
 =?utf-8?B?L2FMam56NkMzd0FLdXJ3K1I5dlJpUzErUkxITnJZbDNFbktrRk5EdXFzNFJm?=
 =?utf-8?B?Wm5xOW9wR0xkWkMvMS9Yd2hnck1GR21vbERieVVqZWVUc1N3Qis2SVEwbUs1?=
 =?utf-8?B?UnF5UWRjOU9VcnBvRlpyejRRUnpyU3o3QnVndDdYanpKbHN1a3htM2dmZEVp?=
 =?utf-8?B?bG16R2Jkd2lpUzU2YWNIUjQwVTdyTm5ybUlLcncrNTl1Tk9FU0lNZkF1K0xq?=
 =?utf-8?B?V1haZUVOQ1FUMXBEelVPTGx4SVQ3eXNhU21QVUdCbUZFWTdXVEhJVitXTjBP?=
 =?utf-8?B?MG1kT1JrOUFUMmZxOFc3NTVhKzFkUnk3ZENZM1djcGxNMTR5bDNROUFBdzFC?=
 =?utf-8?Q?usba2LDv00pZy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHI2UHd1OGh4ajY0MUlVUmsyYmN1dmYzNGVBWS9iVjU1Y0ZhSi9lRFIybWZT?=
 =?utf-8?B?eGl0UnRRMWVacjFybUozdDlvdHdERDMrOHpPUis3Y1k3R2UzekFoaDhuU2V4?=
 =?utf-8?B?UWhaRG1teUlCcDhlS1pkQURhM2JkNUNTSDJ1N1hocDJiZSt0T3UzRGFIMDdD?=
 =?utf-8?B?c1FNOTNFbWtJNU5nVmx1cytkL29pdzBZZEdnNU1jMmxDc0hOcTRVdXJsQlN2?=
 =?utf-8?B?YWRuYTdzWFpiazVVN2VJdjBnZVZKSEFaUEFBMWVxMVVLczZIR2diVXZheWEv?=
 =?utf-8?B?MmIvcVl1NXVKZUY3S0Zaa2JZRm92bnZpWjNRaUY4QWQxb2k2aFNMREhaSlZ2?=
 =?utf-8?B?eHl6ZmpESm5tSE5BU0lBWUpnRHkwaWhqVWVNdmZFYmNWTnRsdXVHKzFTM09i?=
 =?utf-8?B?Tlc2dnVUSEswVmkraDRSaE1ZWlhOTFNNTFp2a2p2bERuOWxQcEgxNnJEM1Az?=
 =?utf-8?B?R0YzRXJ4RjZyZHhHbGNjTnhGanpJRXlpY0ZIODhCVDlrN1VjNjZGb2ppL0U2?=
 =?utf-8?B?ZHc1andLWVNBS2NBWlppTTNzREtOUjlCOGxXOEc0ZE1RVUZrWDFKaDdMQlpW?=
 =?utf-8?B?cDFnNjJ4YkoyZTFOdXNFS1lSMDNnVEtDejlWUCtIazQrRjhKc2svYlAzWEJp?=
 =?utf-8?B?MDltNk1Zc1Y4bjFYem1Nd3BPdUQ4Z2V5L2NhNDM4UVJ0VjhvMG8vQy85N0NI?=
 =?utf-8?B?Y0l0TDJ3ZXFMNnlOZDByQzc4dDlHSGg0UnNKNkZwSlY3UFY1YjkwOWNabnRx?=
 =?utf-8?B?ZHlhTm1VZmFYb1RaOUpJdjB1MUpISGNkSlhDTlQzNi8yYXZvcVVobVhza25P?=
 =?utf-8?B?cXZuVkcxdkVBWWpHMnUvV1pOcXcwT1lrcTJzQXV4RXltT1ZUVWViTWVzSmQy?=
 =?utf-8?B?TVEwalEwRmdRdkFhbi9sMUw3SW5nK0lsWVNBUytnMUJYdC9HVjgyTVp0dmZt?=
 =?utf-8?B?QW5VVmtZbFZveHpKUWQxTXZyK3hYSXdXdmZpencvcUJpTXZTSzYzb3dQUWFE?=
 =?utf-8?B?VmRJckpPdHc5bzhwTDUwU3FwSXFIV3Rub2gvTUgxT1pRMGVXVkZFMGk5emZY?=
 =?utf-8?B?OU5CQTZnQmVQUlpqNlhyb2phN3MzOXB4L1V1K2o4Rmx3Smh6YnQ5QmhVMmFZ?=
 =?utf-8?B?YjhCV2xyZzJxZnI0MVVpcm5VNm1ld3ZhOWU2OFNKbUgxN2lTSUpWVmQ3dkwx?=
 =?utf-8?B?R05PVExQN2MzaUUvNm5la3k1RTd3U3lZMXVTUzFIZzBsOU1KanJTNEJkTDFa?=
 =?utf-8?B?eWtLSnZiemNUVG5JMktLS2dqYlRQMzJianR0ek40U1UxRDFkaDdEQzJRUGdF?=
 =?utf-8?B?amlwQlNvQ1pKYlNQYkRPaHhkMWV0d21ZdWVMYUIxMmhPcnJRbVplUm51K1Vt?=
 =?utf-8?B?bnZvTnhROExJZ0xxbjBRcTRUcGdDdzZmZldrTXppdmlEM2xZSzRreVhxK2xQ?=
 =?utf-8?B?UHo4MndCZC9oc0l0YUlJY0tueGZjTmtJcTMvZHM1UkMvMHZQUUkyakV2UXdJ?=
 =?utf-8?B?L1hTOGpObU51MVdpMzlXVDd2aFRnbERhRVNzRGJKam5SRWRhS2NVSjBqanl6?=
 =?utf-8?B?a0FreEpQcGtacklVaFd4eVNGSE9zMTJZcUdqOTFJY2hNR09SVDdtaTJ4V2hM?=
 =?utf-8?B?SGtqQ0YzMlU2TDY4Q21LT3E4YVVDejd0U3VrTjU4bnZ5QUtGL3FNZFZ1eStr?=
 =?utf-8?B?c1NJTmY4UUVLeUc3U3IyWTVlWWxnMEJCQlZuYjh3Zm42eXZnbWtGbXppZE45?=
 =?utf-8?B?c21nUmltK2sybU8wbTVtYjB6WllRTml1UUoyZkxOVTJUY2FlM0dmcGpORWVx?=
 =?utf-8?B?eTRxQWdJbkhpMjRSekdia2grankwNEhDdDQvOXdvbUtnTm40N1JVQ0tQWU9F?=
 =?utf-8?B?RnJYZlF1YTVUSFlFalV6L1BENnh5cWZKYnZIbkNoUlNYajZhUUZ3ZzdVMzBF?=
 =?utf-8?B?RDlQdmllenlDaVZNUUREWFBWNHBKeit1aW5wUm5UclQwRCtmeXlDT2Evakwx?=
 =?utf-8?B?T294MGVHT2ZEWlFYbzMwZFQ1NHJEcllmR2lTbEVkSU5GekdLS0xaMU1oN1pL?=
 =?utf-8?B?aGtXUWdkRHhSWHFMQVR4NkdQVlBxL0VxSFg1Wis2aVk0cHNtTUxZeEdnZzVR?=
 =?utf-8?B?K3Q3VTk0TXpYTUJpRUt5OGJMSDgxVlZybWUvSDdod00wTmM2TU1zNFlxcmNq?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CkhUcif6QQeSBs80emHdki+VS5eo+5Z3082oZKkEXoUCo9vmU3lj0SOsTKuYOr497BGHSO/zyzlpqvCjX6BhL69sgRDGjjh6vZYd3uccv8qqHe3DeJtrMgpCMB+sbQ4/eVjGY+jpTBWIBg3uHdUge6bPbXlmr7X+iXWfdDsinYiwXb3KlNfKdy8w/So2N5hCGL3AIrRCtqpDCuEq4zUR525NjwVg0yD24bouLDV4JhBSU07WCod1GYMMxm7oBUQpUwcgjKfYle3/ntiMNO1akCgdnLas/A5sJhRC2cB9DwdkKougMU9aLiGthwMpAsxitsCN5p5xVic+XDBRBdZbfe9vGJxr1A8c1qu8mOMInFnUVsUFKbUDbSjyP/wh331hDAHjgF7rJCNBzHd2XgOeHtEi3g+XQweVuYTix7/yLOQSh3EdmpUXCEtAM67t9I62+56eJKNF23mRpXOK3bOL83iJPEjkFSfQ3EpzuLTRqEckkKme8w+EWAvI+d9jsdnhePkOSWUIANHc4BXRS1anfLaX1d97xnBWUCj45ufqZjou7zzbmEE930FFPhjbs3PXAXaB27SU6wX94n4Mmz7zChcJzvJgp5QPo3Vx7llzizI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6421d9-cdd6-4dd1-a1bf-08dd46dc81cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:31:44.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBg95GwCWFZCdPsVDP2aomOQ1p0QD5Cxplxsd9L/EZj4Nk97ZRwQSURTBhYNTp0xI7AdajN7uJzduZUhkzcFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060148
X-Proofpoint-ORIG-GUID: j_z6aVRgnCqUZNDufL7DUiabAd_-c-FY
X-Proofpoint-GUID: j_z6aVRgnCqUZNDufL7DUiabAd_-c-FY

Hi -

For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
looked into it today, and the test guest fails to reboot because it
panics during a reboot shutdown:

[  146.793087] BUG: unable to handle page fault for address:
ffffffffffffffe8
[  146.793918] #PF: supervisor read access in kernel mode
[  146.794544] #PF: error_code(0x0000) - not-present page
[  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
[  146.795865] Oops: 0000 [#1] SMP NOPTI
[  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
5.10.234-g99349f441fe1 #1
[  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-2.fc40 04/01/2014
[  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
[  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
[  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
[  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
0000000000000000
[  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
ff4f0637469df410
[  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
ffffffffb2c5c698
[  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
ff4f0637469df410
[  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
0000000000000000
[  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
knlGS:0000000000000000
[  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
0000000000771ee0
[  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  146.810109] PKRU: 55555554
[  146.810460] Call Trace:
[  146.810791]  ? __die_body.cold+0x1a/0x1f
[  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
[  146.811854]  ? exc_page_fault+0xc5/0x150
[  146.812342]  ? asm_exc_page_fault+0x1e/0x30
[  146.812862]  ? platform_shutdown+0x9/0x20
[  146.813362]  device_shutdown+0x158/0x1c0
[  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
[  146.814370]  ? vfs_writev+0x9b/0x110
[  146.814824]  ? do_writev+0x57/0xf0
[  146.815254]  do_syscall_64+0x30/0x40
[  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1

Let me know how to further assist.


-- 
Chuck Lever


