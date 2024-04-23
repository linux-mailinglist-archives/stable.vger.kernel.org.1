Return-Path: <stable+bounces-40731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E68AF422
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B169928EDDE
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9F11C2A1;
	Tue, 23 Apr 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LVEXiij8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JGSgZo85"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DB13BACF
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889849; cv=fail; b=phYhRHBAkrq/o3qKs5tdyOZtZ0c9hI9xRw3uL5449DFWT2xOUmX2M2ykK8B4wrbQrgQ1MtCq0mRFbobwUPXm9v61utXdVDL3bi/qHfCjZotzq0FNTS6sRBv4tcNBpAC/3pMjp4kCYtwUrDdZDhgJwcAtg0er2OC/XB3IqY3s5LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889849; c=relaxed/simple;
	bh=UwBYk3ddfOD2G3NV6JAJ3+FAcXAJiWwEv2of9JMZLHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLqu6Wxf1On8HW88tzcNpVlDjWx0bZBm0xMS0mvxdCKdYTk4JMT7BFCsAj68SBhabubgI6A6xnu4ERcQ96omWgkF+baj2F+ay6SXZ7evhGJkzuTQqniXBDAv8mXJS1ue3KsOKNd0KLSVqoQ8gNTlL61qY17hxqbJmB3OPJWnWQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LVEXiij8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JGSgZo85; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUboQ008142;
	Tue, 23 Apr 2024 16:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UwBYk3ddfOD2G3NV6JAJ3+FAcXAJiWwEv2of9JMZLHY=;
 b=LVEXiij8e1/nURRK3LgaD5hDo+G4l+fWcHq6pBG1eSxJV9qzOW5AwysN2b3KSrN1R5br
 Z0onHiVPIF2wJRw4QnHoXh0aSXre8aI1+qlMWBgMMOMXWTQ7fRvFQfSYPkkLktVp0urS
 ZwBwcuhiiiDIle7uJJJCe6ORJ/lBst/GgOE3/eEcCDAhqfmRCTHVIPvdQPrNwBp+E/bN
 jrfV30/G4Q+Ye9BLs7J7faXo0aPXUWcxSdHMW54DOw6/283B1aRE6C7jUV6oC+o/TCMx
 cAIrEc3xzuO50JvseTIkWVBjoSUjfEOSzo/x9Say+OFj2vRSSb8svB4PHg3yHCKq2qKs eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbpdku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:30:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NGQWc7030800;
	Tue, 23 Apr 2024 16:30:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457gsgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrGhnMH9fVuzSvK3zj+BXts1OJNuzEss8opI5csBWGv/W/uRboea+mX7jRxqRQ1BTefj2kbtjejpmYoRPMnabqawSwucYrRMIWkPPWXCDf627C4k3/u3I62hV/6rkAIqXOt446gSKAoFUQiwsLXZZQ6wukPw8DaW3KXTqQjmg+gbu5LQN7Oj5ly8D1nuHap+bVAfRl+sK6pVvyyYEZ0dW/zLd5BE9Ji8JVTecfetZSmPOaICxY/a3UOQ68czHV5AqC7Q0dqJsR6+0sLx+swxhXZWUZ/oik0SXBkbA3wXA3Zadm0wwZ47WhHNQYffXYs3vvyoL5eo8/Cd7PVDmfU+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwBYk3ddfOD2G3NV6JAJ3+FAcXAJiWwEv2of9JMZLHY=;
 b=TXwa2A2H0iPD6WSGE7l0cDi/NzN82/p5yfy8LiIOBDq2HG2ppyruxcLBvcedhRK34je48jF9chPmW3hp8fQKz1pNch6R9KYLhSpNoAUQEiHaB0KccqA/E7BLy9XXImX3ONvKCygQW8V5Ck/8niYEanGa2/yVzu/I9N2zVvHVTzaykB1NHbcLPF65KgXrpuH3KEgbZGIhqVv2kxYEr8NE5E6BrUElSqd8DIUhzvZPvpOmiYhI3pW+mVnsp5HHmMFr6urT/GoPH+QJvFjaFcPJzmD5Zm8poZYhx6N82FuaPSc63gzWlhI8G4NDIbzh4T4PR3eVpeeMQr816LTTSNbvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwBYk3ddfOD2G3NV6JAJ3+FAcXAJiWwEv2of9JMZLHY=;
 b=JGSgZo85g8hJpW2Cvx0iyAEdLi30Z3ERZZxB6XkaVlC0YMGKXzv0Er3psiW6bm8xfNbVdHfuXKERBEU9UP1xPFlp0CByKWnwTc3iPjX0nDcUVxRagTfhrMhXX49cjpvuIaIsctmH5t7tPxwmw3s1dgYch4t0lqABklo+iWhQAZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6693.namprd10.prod.outlook.com (2603:10b6:8:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:30:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:30:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Chuck Lever <cel@kernel.org>, "stable@kernel.org" <stable@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-stable <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Thread-Topic: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Thread-Index: AQHalZsOM2+NT8MRnUqaf37jL9dls7F2C+QA
Date: Tue, 23 Apr 2024 16:30:38 +0000
Message-ID: <70538016-22BC-4D71-8DBC-4832AB60E6BB@oracle.com>
References: <2024041908-sandblast-sullen-2eed@gregkh>
 <20240419160315.1835-1-cel@kernel.org>
 <2024042351-unfocused-respect-2dd2@gregkh>
In-Reply-To: <2024042351-unfocused-respect-2dd2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6693:EE_
x-ms-office365-filtering-correlation-id: e363c2ec-1e61-4bfa-ee7c-08dc63b2b5ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dmEvYzV6cVZCQWM0R0ljVXRnYlZLVTZZTURINWtHSDhsN0x0UE1aZUFsQjN4?=
 =?utf-8?B?clp3SzUvL25RcytiSWRNa3dpSnlOcWVudGJxT1N3RzgyMjk5LzI0RDJiSlM5?=
 =?utf-8?B?WkQrZE9pUzJ3dEZ1VUJrL2Z3U1pQWVluczd0NlI5bFZVb202V0VlT1VESStL?=
 =?utf-8?B?alhodk5mbXovNURNYm0vazgxUWhhUTZ5clc3UXF4ajJFMUpMSzhkL05pTnBS?=
 =?utf-8?B?RkQzQmRySGk0cGhpRnRPQU5weUhZdk5tNjhGNlk0THJVd3pVR0Z5bTBmdjcv?=
 =?utf-8?B?UnhFQk9xazlNZExlY0FsaWFXZ1I5d1dYMWhMY0FFVGVVb2NJN3F5VkQvMnNl?=
 =?utf-8?B?THVsRFNZTXIwNHlaTUVGeS8xWnR4SjZtSUlsZ0dsMzdrWjRBWU5TZjRzNTcz?=
 =?utf-8?B?NUxFNDhYVDJOT3NwTnR6TUMzZXd1aVJEWjNFUFd4MldjdmVHaTJ0aCtzSVhx?=
 =?utf-8?B?Wjl6eTNaaStaL0o4VGozNzdnY2lMMTNZYkVSaE9rOFVJLzJtd0lEYi9jZDkw?=
 =?utf-8?B?aVk2RnpvSm5maElOcTNWVEx6bzJjQ2d4L0pMUm0xQkQrdzM3d29rbFRiaVJx?=
 =?utf-8?B?MUxEeEpYRGI2MGRvQnB2bjBJdWpoNVhKSFpaQ2l3cS9TVHRSUFFqc0MvUGxS?=
 =?utf-8?B?VmM3NkgwbS9XeXFZc2ozRFdOWXVZN09rNkdZb1lrVkV1Y0VrbFJZL3BueTd3?=
 =?utf-8?B?S3Zrb2VxbU5teUh0MUlHbThTNE9BT2hYMTJEc2IyeER0Um4rVXNnR1NkRmFX?=
 =?utf-8?B?cjhrbXIvN0FTVVVBVzRmb0JBNTBMbVhUT3hKUnRoRmdkSENwR3I3cmZJZHJR?=
 =?utf-8?B?RTFNZEROVkJLNnN1YVZEcHU0Wlk4ajlQMUtJWFAyc0tsQ0hKd2k0UHpvdGFv?=
 =?utf-8?B?cEU2VlpSK21WaE9FbVF0bGFEUTNhSHJHS3UrT0NhZjJOV293bXdUMWlEcXFM?=
 =?utf-8?B?bkYwZzlMWjVIL0NRbUQ2ZzVqVy9qMjFkdGgxT2RvcE9nNGtTSldzd3BHc3Rq?=
 =?utf-8?B?dk9tMnVRK2E1TnJGNDR0VmdwZjNSNVFCcFJSQytHVC82WTJXWkFZdENmdFJi?=
 =?utf-8?B?a3I5ajJFcUlUZGljd1VGaWdIK1VqaEhRRThxL2pWc1hCbEF0bEg2aFJUbHlp?=
 =?utf-8?B?aGJiRDRicUdJd2k2UDV4OXJ0WXpKMXVTai82RlRFQUpvN1JjRmw1UHN0Qyta?=
 =?utf-8?B?amF0dHMxMU0zc1NrNEFqa2pESnNETFRDOW5qL0VhZFVoajJCUmZZNGlPa2dn?=
 =?utf-8?B?N01qM2N4bXRUWXZ4RkwxZVhWbDRqeXBXZy9NNnFUOTVDeTJVUnl5aEZ2OTV1?=
 =?utf-8?B?NlYwaWJ0RmdOL0V3MXJRcUxyQnVOWWhLSndkNVdQWU5keExaNmNkNUVUREJi?=
 =?utf-8?B?TEtzUDBKdG9FdTBpeWsvRVVNRXpKdjVtTFgrOVQzM0c2dUFiWVpNM3g0eUlT?=
 =?utf-8?B?MkIzem41SmJMY2ZqbWJXTHpyYkxYQTBzdDBZV05CSmtCdDJrYWNDQ3g4WTRG?=
 =?utf-8?B?NFhnZFFqaFpOTWI0SytRWFk0MkVkaE1nTW0vOU5XcFRkcXpDVmxDZ1FNLyt4?=
 =?utf-8?B?R1NWdFpoUWtyTmdyVnZZQjlYMmlTNzJ6cjRnTVUrV0UvNmhvYUgyYy9NcjFC?=
 =?utf-8?B?a2REOUxpemF3OUMyd2gybmZoL1BPZm9MUWNiUHVzWjROMitDQ1h1R01LU2hE?=
 =?utf-8?B?TFZPeFlnTHFwTkN5Zk03N2k5dmF1L2JjZnVVV1ZLVzFFTWtSaUdzYm1WSE81?=
 =?utf-8?B?SUtBOW9lZ1o4SVh0QzBrZllzaEVsM3hwRnhWQ09ia0hYVXFHMmltT3Q5STUx?=
 =?utf-8?B?V0xDaGlOT0ZkbEZDOTRTUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2t6dDFkckJWb0tkNmJ3NFhHY0gvcG9hNU1WYnMvSkN6QU1sMDJJTU4yWUNq?=
 =?utf-8?B?OFZMU3k0N2dUTG4vblBINUZVNVY1NmljRkM0VU9WOVJzZllEQkZjMWI3bkZX?=
 =?utf-8?B?VnlURFJXb3hna3FpR1cxWHoyNDZXUDM3QkVqeWJoSUpoa1ZpQ2pOZEUzamZ4?=
 =?utf-8?B?bzhmSnBudkxZVjNOKzVpcllzQmJyNWNxeGF6eld5Ym5JVXBvdW1pWDN6S0No?=
 =?utf-8?B?cDlQSlhrTFI1VGZVK09ERkJZT25yOHRrUXJKUmh0RmZuN3A4ckorUTNON2ZW?=
 =?utf-8?B?bmlOMW5sZ0tkNi9nYTN0WGtnRlZZQnRWREFZN2MrSzJqNFRNNEtyaXNpQ0pM?=
 =?utf-8?B?ZUozVUo3c2ZuNEVhdDZHSHRjcVVicHRUQ21ieThicURSTUNLcnhJT2lLV2ZS?=
 =?utf-8?B?UzEzVGE2cGQ5aE9WNlhpN1dhYmowN0w5MERpOW0zNUlNRkdYSysxdzhSUEJt?=
 =?utf-8?B?VDllRjAyQ1hZMG8wSGRqNVVUanNKS0VNVVBjZ2ljWjQwV1RYWkFzWDFXenpY?=
 =?utf-8?B?K0xTS0Y4N3E1V3hEdC9VckdQVTN3cnVCN05GZ2hpbE1lYUl2ZSsvQTZBenFX?=
 =?utf-8?B?bElVOWJPMGJiMFBkZUFBV1JXYWY5STcwQkp5bHpCQTc0eVdldXUyaWNBVEti?=
 =?utf-8?B?NTBpZG5PM0I2bTJiWlhXbWdNTlJNcmEvV04rbmhlOS9rRGRVb21EcGlyWEpK?=
 =?utf-8?B?d1hyTE4wUmJoL0JsQVNoRTV4MmJyUjlyNVFId0hCNVFPQ1JaSVIvRnVVSUZo?=
 =?utf-8?B?VWIzY2tzZXk4TTFtNlBCTjJxenNNQTlIMXBsRWNTY0pMR0ZBQjUwbk5sWi9V?=
 =?utf-8?B?ajVYd0w4c05vZGxqeE1BZHFwU2JiQkk0UnA1ckk4cHJHZzRKbCtGOVFEQzZL?=
 =?utf-8?B?ckhCREtDOHA2MmR0UmNtNnBnRnRvRlltYzF6cHJyd29mSmhOaWlDKzNXaFh1?=
 =?utf-8?B?dEtaUU5YSjFVWEtCazF5MTMxbTMwTDlKbHJFamN1eHRIcWV4UUJkUy9rcGFH?=
 =?utf-8?B?aEJYLzJNYVhLb09nV0s5Rlh1Qyt6ZW91MStaNi9xcjlyUExaRDZaSTdHc3I2?=
 =?utf-8?B?OTR5NjRJdC9HelJSeGlua3Z0d2hwUWtWQXNJM25BN2tsdVVIN3lwenBOZ0xP?=
 =?utf-8?B?ZWNBYnhyaUdrRm9wSGhmdVJ0dDJ4WE5BWnNvMGY2VTVMQ3BseWtXZCtvZ1Nv?=
 =?utf-8?B?a0ZMM2VYTnlCYll2cGVvdUpuUTZ6TDM4dUcvb0psVVdoY09SWTcyQWNodmdR?=
 =?utf-8?B?SGc4N2o4M0dWZnZHOHhnSkZuV2ttM0hVWFhJdFFZVlN0aUNWK3ZGMk8rVGxs?=
 =?utf-8?B?YzE3NGlXSXNnbHc3TzNGNythRk1xZTF0eFRHWkZ2WFd2bzZSMVRUV1pnS1ll?=
 =?utf-8?B?Tkdma2kvVVBmVmJTN1BGTmU5WVA5QUY3U2lBQW4rMGdJcFdpNWhWREdkTGU2?=
 =?utf-8?B?N3NGM3dFcWlZb1lWTGtEYTh3R0IyRTU0cWpsUWxSR2dnMHRORm9oT3M4bHB2?=
 =?utf-8?B?THVEcGhIWWJFL0xnOXN6a3d1cFN3VlRUYUt5RVJ4eFFHY1NkMXdrMW1hZ3FM?=
 =?utf-8?B?cndxQnN0cEFrTXI4Uks3YXdsczVjN2c4T2Fjd1kxMW0wcWRoT1lBOTh3SlpG?=
 =?utf-8?B?Y205eXlVN2hEMXREN1VMOFJHVUt2UEpHR1hncG03bldtZE1qM1pqTVBqZ3lY?=
 =?utf-8?B?ZG92WkxDOHdKakxsTjJ3VVVOZGJtclN2dUVCK3FCMEI2aGxmQWViNk1PREhp?=
 =?utf-8?B?OFZaeFVmSXhuZzBlbEVkcXdpRk0wM0I0OWJKamd4Y1BNZDM4aWIvSURCZXFW?=
 =?utf-8?B?b1pIaGY0YVp6bk15V0p2TXdFd1lnblo3d3dzYlJGMVdpY0JJOHZNdmxzRHZm?=
 =?utf-8?B?SExjcGM3VUR4a1M4S01lamczQTlUcVhoM1VnNExVbzQva0lVMEgxZFc0VEtZ?=
 =?utf-8?B?dms5MkgwZUM3bFZ3b3BFQS9YL1cyY1lDTkxDNDVMNFJTaFoyaG1MVnlHS1k2?=
 =?utf-8?B?bm56NGhNcEtZVEkxWFFPWnVEWXVQdi8xdWJ2K0JTUTMvaTBCeHUweTdDU2tK?=
 =?utf-8?B?TXJYU0pMNmlSZnBHQVFNWHBYNzdvTThCQjlWM1ZLRlBVb0hNZzRsZzFRTHMy?=
 =?utf-8?B?dkg0NzhtaFFqSXZNQ3JER3V5aTV5WlpnV3kwRDdjZWg1U0NLbkUwMWRjOE8r?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <468828FDDE360A40AFF8052E18330D2E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fSaYiv40jDgkztOwvC6FXuFsPmoaC5V1cjWWYLWyBDiOhyJTKvJ+F5VUOj7sp9Z/AH/qls2O/Fu59sYIQKa/z2GLCKU3v9P3e1uDGmKxXUrSeGSvVGDpNdx8h3jot1AOqZrSxoY6CgQYC4D9A3Y2NWzk6fA+5yshuVkfPU0FZnNekfSpaiRCiDlfcWt3RK/Mmq4toHISW6NDKI4KVLp4FwS5Ez8Oz39gTOP/P0I7exu4KWiKefaLebESvPSF6Jo1HrXVrZhN6iBG4YcjQKUug4Uf5qmhdRkSVGawHsy8ZiEsq6zMq6ufbp294An9q+4C3kbbQEEUpunuKmF5TY8us+5a6dhBr9R8UMOQHOFPY5X2yGShuuwRR3op2QeDLoA/Q4npsqM3NeEUDeboa0YZQT+GS064G99jVQG9TbdnuZ/D7rD9pFVDimSBwKRJk5iUZzvMPEaN2GVJYQgo7ooXAuXvx9sXfIOYVEvUodnGlzG8KE0keDZuHcOdp32L0DlbSbz0l1WoSPFVALtO3aPgH8WXHQlPK9oPnEO8jSmwwFhsojjIm7va/A88ILQOm80F5bSoH/hyRJnVGHwVZlIfT9mNGec2ZNQ2eIxWiIqFzkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e363c2ec-1e61-4bfa-ee7c-08dc63b2b5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 16:30:38.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkuCCGFZq5W2BXUR+qazv+YcIeXwOJgiXL7FUn2+GMyMaKGgbQYkwTRpjjXtLsOnuhGlcJbBhhPrnn5dfgOeEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=900 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230038
X-Proofpoint-GUID: 9suGjPH6PhxAJMUgbvxvad1omUXfv7-s
X-Proofpoint-ORIG-GUID: 9suGjPH6PhxAJMUgbvxvad1omUXfv7-s

DQoNCj4gT24gQXByIDIzLCAyMDI0LCBhdCAxMjoyNuKAr1BNLCBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEFwciAxOSwgMjAyNCBhdCAx
MjowMzoxNVBNIC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToNCj4+IEZyb206IFZhc2lseSBH
b3JiaWsgPGdvckBsaW51eC5pYm0uY29tPg0KPj4gDQo+PiBbIFVwc3RyZWFtIGNvbW1pdCA4NjJi
ZWU4NGQ3N2ZhMDFjYzg5Mjk2NTZhZTc3NzgxYWJmOTE3ODYzIF0NCj4gDQo+IHRoYXQgY29tbWl0
IGlzIGluIDYuNywgc28gd2h5IHdvdWxkIHdlIG5lZWQgdG8gYWRkIGl0IHRvIDYuOD8NCg0KQ29w
eS1wYXN0ZSBlcnJvci4gVHJ5IGY0ODgxMzhiNTI2NzE1YzZkMjU2OGQ3MzI5YzQ0Nzc5MTFiZTQy
MTANCmluc3RlYWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

