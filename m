Return-Path: <stable+bounces-163272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C3B09074
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C323B9F0A
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E61EA7C9;
	Thu, 17 Jul 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPZULboe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXa+6xRy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6B15A85A
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765745; cv=fail; b=ZOciP6tpn0Ak4eyyD/Xog/FI52En+4ScNsy02CZQhP/fheUs2Qt8wks8XEmnqIOl50k+NNojDyEQGvHJ00S8f1GsNX4f7tPIngkiEIAvWxep8nHhx6zAGfrBdLlqlhN2J1RoZ/rWBPUZtdUxUr9zh1Jdtnj7nIargiCxTF0m1Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765745; c=relaxed/simple;
	bh=+bWey7+YDKOXlJ8ZjO9lf+NiX2RmXrlIv3B4SBcERcU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oV2S8XUZLIQePTVJJnrU9uethQ5Vuvg6DnJBG8xc0hI/RA1j2O1RqBs1jdNAvQsTIEM71yw9LL+cntc1ROtatUjliXv/AVgHyXoj01uEtkgtUjHFQ//te1hkUwA23vUP2tKlyip6YW7iUriSRiQwcigiUMqethbUUY1pB8tPlNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPZULboe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXa+6xRy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7g6Fk022908;
	Thu, 17 Jul 2025 15:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2025-04-25; bh=+bWey
	7+YDKOXlJ8ZjO9lf+NiX2RmXrlIv3B4SBcERcU=; b=XPZULboeQYBUSDwReunux
	k6JsMvizQo5NfOkT1WhM041kpk4dyhkxY5qORrzw2ojdMPkEv+mF0JSrZCWHKX0x
	BAdazFjj9dzYye2X6LZHG7nlkLkUAfMEUpv/xH4rr/E215TTL5ikDqf7nblJtcls
	9hb5+vzjWOBj/ctIWZ/hSscIdaFtMQgnXX3yF4k6mQDdPmppezUXdgVv1UbA1i4I
	TwSDITEzO+TZwtHW/QL4eNNANgl7iikc3xNo5xszA4fPmEj5xb0KymE/9sXRuUth
	FnmtKTyXA9taFvrsUTo29ENiyCg9Ima0sw9EJFCOQB0HsTWsWyAxD55qwZqdVHAv
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3eev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:22:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HF2ZKe023936;
	Thu, 17 Jul 2025 15:22:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cu9js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8pZHDZicovzZ/+NhccT1Nk3Pf3DBNsuOpFRQ2v2u5qI5ah02fm56q9Ho/UnAiZZ2TVRWCPjCvYla9Hr3Mev4DIdd4UPEceGsR6UWSQJAdniZQTm+gmmP9X0X0rhsDf6fmf5Wcj5IQK4ljZsN2fKxgJYP18+PAmnTC1bodTyd7Ki8B4HOc8BIHLNgiAU+DwdHK/66t4fwERywG2LYDSEvEUzz5ItYKhW99sdXK/yDe216ExD9yZHhS9zCOLtpeNmQKI3ZnV4z4jHCRjz5nNZ/JSG0WYMB0JrGLB4NMyXklx5R9wU8VZKoSjZwghuKrFV3PUUWN4qsGeo8UptygoRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bWey7+YDKOXlJ8ZjO9lf+NiX2RmXrlIv3B4SBcERcU=;
 b=ZLg8CdZaRcztxp1RuC9EJ7K/pLAgw5DMVzfzthd9lDXmuZsYANhspKdiVmNOyfHgpLGzYpYDNBMPdum1D7u/SW12EPB4wykCpwKZc17IxReWaN1GUDDcKpj3ObqasmSW1e+IafP8jkJylv5ndklVUvdAiQQRb7S8LWpypwl9cqoZD49LhFKYffHm205e2IBix8Q2qtH1Q4NtdyyDObwR6JskO/sRdOWd9aKwgQBAkqhh77aleEgjSh1sNnefbuBRnE2CLnZjwZRqY4FbxzAHbu9b2QYj0nvRe8rZG7878uOh8HD/HMLXYxMoUE5MfrRjoRaWw/Ty00uvQm9xOFfkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bWey7+YDKOXlJ8ZjO9lf+NiX2RmXrlIv3B4SBcERcU=;
 b=DXa+6xRyoN0i+rbuWke5fx1ASiKn4wx0Btp7w94Cik1Bf6gs3py2siiaXN+m4Mq/ZnzdfkNXT2lX/6MVxHCI77/DAS88u9qHzRFY+YqW6gQ+hbmJFLs8AR6Osu5ceA+JxxcRwGIekEwThdfQierf8Qy3yWxQMuODO3NUZrSSnv0=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Thu, 17 Jul
 2025 15:22:06 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%4]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 15:22:06 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>,
        Aruna Ramakrishna
	<aruna.ramakrishna@oracle.com>
Subject: Backport 36569780b0d6 ("sched: Change nr_uninterruptible type to
 unsigned long") to linux-stable
Thread-Topic: Backport 36569780b0d6 ("sched: Change nr_uninterruptible type to
 unsigned long") to linux-stable
Thread-Index: AQHb9y6OvrL1ynWwPE+e85CbQcnX7Q==
Date: Thu, 17 Jul 2025 15:22:06 +0000
Message-ID: <CDE87A64-9E28-4313-A1F6-79F829E9B118@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|MW4PR10MB6487:EE_
x-ms-office365-filtering-correlation-id: f7aba0e4-59c1-4bd8-3cbf-08ddc545b0ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0R0WUtNSUhwcHl0S0pqUHlQd09YbWZWb0pvMzVNQUh3cFQ1bVMrTHFaZSts?=
 =?utf-8?B?V1hzdW41UXUzNVNGaVRkbldYeDFjSHp6a0R3eUhJVGhhd1o0VXZtekJZTU1j?=
 =?utf-8?B?dHJZMSsrbzJ5OWk1Y1RNaExLdHJYdmhMZXZ4OGJFbkNvS05FdmRJRkYxY2RG?=
 =?utf-8?B?bjdES1lJdnNNZFpsUGFIUWZzd1U0QzZpL2VKbWZ1ajF0RUkzZCtBQ1MyUFVt?=
 =?utf-8?B?SVhpbzBwMXRSWDVXNVJvTXNGcnNUY3JtWUh1Z3U5dWlFWGluODJBRnhZZUVM?=
 =?utf-8?B?MGE4Zm1PYVZnUDRRZ0RLRzJYZ1FhdzZ2bTRCdVdKeWNjN2Uyd2FGS0xST0hu?=
 =?utf-8?B?RFU3UWRsdkFFbEZQVGdpSWlDa2JHUnNFUFdCVktoUGg0UlFKZmUydnkyYkZ1?=
 =?utf-8?B?TmVtaUdGYll4R2tBTGx1d0h1V1c0NlVKeDNiNjVPS2xKQm5LL0tQcldjaUY5?=
 =?utf-8?B?NHk1d01nQkM3aW5yUEk0OXl4RjZHSFJoLy9CMHNBcGJsL0RiNWJuRzRzSGwv?=
 =?utf-8?B?U1l0NHZnclBmTnQ1dk1FTStKWmR6dnVNdmxmZ0xDSXA3NzJNTG8yQjlXcmxk?=
 =?utf-8?B?YVZJRk05TXBXSDhyL0wrNWhXWHcvL3g0VXZldGNNVW8rQ3A5dDFUNDJIdDVz?=
 =?utf-8?B?UVNtamNSREcvcU5nc3V6UmNaeHJrZTRZUEIzUjlabmNGdVc3RDU5RG5VSzRR?=
 =?utf-8?B?ZkZVYVdGOU12SGozM0M3Z1RCcFppT3UyNkk2MTErYnlqQlMyMzJsWlFxOVR0?=
 =?utf-8?B?V05PSGljMHBMM0NuTUw4c0hiS2Nuc21rVGd0b0lSQnRWNFY2MkJpc0JKL3Jq?=
 =?utf-8?B?WkgzQVAxNDlCd294RmlDamJKZnZDMjVhWHlud0I4cmlsSUlwWWJSRG5vVGxa?=
 =?utf-8?B?QzJXdkJOTUVFWlR1TnNoTFZmbmFLc1FidHdUYUYrTDhDcldZV0cvVzRUZ2gz?=
 =?utf-8?B?c0ZNQ2JIMm54dFAxK0dFYkpiT0QreWt0Q01YV0lTMktXUzBSYmh5RlN2WWdR?=
 =?utf-8?B?d3c0S1QwRjhtU2llcWpYQjNTVlNYK0t6WDkzMCttekxhRy9kbUhnL20vVkxF?=
 =?utf-8?B?bXQ2anFGeHFSY2kvQzJsbU1keHhYL1FzVkdaaEhTNkxlaG1zRDh6THd6RUlh?=
 =?utf-8?B?d3c1dCs4dkdWRTlxakNJcWdWZzVrS3loTkRVTk1IMEx2NE9ySFlmRENCR28y?=
 =?utf-8?B?RTdnN3A5eG1CZHpMdVhJWUF3bGpxMkprS3ZNK203ZktCSHM3TlJVdTJ6eTJi?=
 =?utf-8?B?NHZxdWRXRXZ6ZVFRdzhrVzlvQWY2T2dXTjRzZFJkdHVtVmQzN1Y0MCttYlFm?=
 =?utf-8?B?aGV3S1IwcTdycUdQTFJFbUxCcGQvaFU1MFljTGZ6eDZiZ2o1cFFZZUtHcjRX?=
 =?utf-8?B?d2c4OUx6NC83VEEyRiszM0Nva0NTL3hlWldYQm8wTS9jMnAwdjZLTnMrOFNL?=
 =?utf-8?B?TVJodzBNTnJiZCtXNlR2QU42aTJvR004Kzk4SWZaa2NiSEltMU9tMW1VdGVE?=
 =?utf-8?B?TWU0bVdmQWxTZ3pEbDBYaFVwZDFBQlJIbzBaWXBWRlBLS2VZeStQaTBhZlFE?=
 =?utf-8?B?N2dCMWhtQXdUbXRkd2p0Njh0cmtOSGlpSVhtV3FTRXFvY1FkRVRNRDRCbzVr?=
 =?utf-8?B?eDVUOUc5c0prQU9pYkIwUmZ0dEhXajlhVWIyZjNpcGwvZzArYmlQMEwzZWl4?=
 =?utf-8?B?OFlBVUVwZ21BbUJ2MFpQeUY3aW92WkUwMDlpbEc4KzhXT09KK0tORk04UHFS?=
 =?utf-8?B?ZWNOREljY05ETjAvSWdkMHQ3UlZEck5PQ25XVTVFYXY2Zi9OWk9aZ1JHWkR5?=
 =?utf-8?B?eTlqTTZoTzRLYUpSQUJFSGl1Rmx2QTBxSDA4UjJOcWFWUE9wTCszYnlmb3Bi?=
 =?utf-8?B?RXFnMDlVc0k3Z3pEMktLUlhGbFhseGQ1ZHV0dWFPNUkvaWh4K3NNZlhROHUw?=
 =?utf-8?B?NU9HbnNMZzVwL0hYNDBGcUJkb0NUR21WUy9Ra0paREhSbW81dkZxNEtYcWR1?=
 =?utf-8?B?U2ZrTTZRVk5nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDJoVDFvcTRxVkJDSXoyZXIrRUpZblhvdE5XZEZwRFRzTlJmd3o1Z3lFbDZu?=
 =?utf-8?B?L1o5aVhnZkJBcEc4QjBNWXc3UHhudklRcmdmZ21TUi9DcWdPaVNNZmxvSVJ3?=
 =?utf-8?B?aEw5dXhJeXBRR1BTRURSYUx2aG8vNk41a1VWZDJJRUtrdzNHc1lnendXbHFy?=
 =?utf-8?B?Q25PczcyV011MWZZYTJBRnJrOUNqbDBDWVF5RkJuVnBUQ1NaWko2YVNNYVFa?=
 =?utf-8?B?YWgwU0pvMzlPTnhRc0pTTjJmQ1B0YzFXY3hNOTRzMFpkcUxUOUpJOUpVcDRq?=
 =?utf-8?B?N3BxTDlaYmdyOUh0UkJ1Lys1WEpIeEZ2SXVRYTdjMU5wNVhkMllHYVV0RXUz?=
 =?utf-8?B?OUkzWWZMcnM1UFlNdnZsTVAvNXUwT2U1TjNubGNoK2UwYVRqdFRSbFIvb2ls?=
 =?utf-8?B?M2kzTWtiVFNUT01Kem0za1kyTnluQmNjZ2xsajlYaVhSS21VQVE1Wk1sNzdS?=
 =?utf-8?B?UU54MGVYRDZUUUx5eHRwcUl6cUZpdlFQWmIrRzRUZVAxcEhNRXVvcjNkcWlB?=
 =?utf-8?B?U2FtZmE3Z1JSODRuSERTVGtvT0pLQ3VGWmJ5emE2eFhPOU1GVERPaGNudmZG?=
 =?utf-8?B?YnNoeUE5QzNDZFlRYVdBV2UvRDNkVlkycXo3S0JNZ05ZNnhaN3YyeGlnOERM?=
 =?utf-8?B?czF2TjMzWE5mcDhqS2g3RXhIZ1lCOEp6WjFVVHlmOVdnbm5FK1VleDJzLzQv?=
 =?utf-8?B?eGpQdWtzTC9RVnRWSUFWUlI0cUNuY1dTZVE1VE16RlN2VUVnRy9Ud3RIbnRr?=
 =?utf-8?B?R2FVUU15Q2tkU2hiaHlvTjFHNElodWlFN3Jickl6R0JvSVZEbFlGa1RGWUpt?=
 =?utf-8?B?d3pRNjR4TmlQWWZoU2Flbzl2dzVhK1d1REVSSlRvZXk1SEp3OXRaZ0hjWGdY?=
 =?utf-8?B?V2tCckpMc055ZnFtOXVmVEZLY1ZEcDU3NGVVeHI5MWJaY1NOZnQ2bEZLZi9R?=
 =?utf-8?B?RVpaTmpyWVBNVVhHdzQ5bDlnWml1MkRPclZ4OG9GUThmQ3gzeU9XSjNyRXR1?=
 =?utf-8?B?M2ZBOU9ycmFDNUpMbkJpdjR3azgxT0lPT1R6TFgxam1HQ0FKcTBlVjJaZlBx?=
 =?utf-8?B?WEZHTlp5YTdBeE5ET0FaaVZnejhWK2N6SVVxejZrbUFCcUxuZHJMbEpYRzd5?=
 =?utf-8?B?c0JFOXU4cXVrdXdndHpsZ0NuYmhEc25nVVFmYmozeTRyeWhtcVBtZExUdjUv?=
 =?utf-8?B?TmhoRWtFMm9CQ3dIQTZLSlpXYkFMTU5GTW5ER3BkQ0RpcllOOUpoQ3VzMzBk?=
 =?utf-8?B?OUpUaUQ1b0MyMGl6WmZRRDJOZkk0eDBQdE5iMWQrOERMeW03QlFQM1I0cStL?=
 =?utf-8?B?ZHkyRVErVGl6bkt4UEdsN0VSdlFFbW1EcWpQd0gxemFsSVlRenZHS1lPQjU3?=
 =?utf-8?B?dzgybUR0YkVjakgyZ2ZPZ0ZwbFdBTzdXZkhyNG9qY0thVGNUdUNDb2hlRkky?=
 =?utf-8?B?YUNGS1pjcnFFaEZJdG5LakxVek9Ld002bGpzVndtSEFUM0g0amhzNlB5dVVn?=
 =?utf-8?B?VjQzN3BFYVpGQWRvSEROVDNCYXkydFRIR3hrZDRQSmVrS1Vva2F2N1ZHNEVW?=
 =?utf-8?B?ZHJxKzRQcG9qNGhZUEhic2l1eW9KTHhHMWdLRTgrS2RxNVBWNFI4WWVmN2Er?=
 =?utf-8?B?enBWQ3h3M3hxeFBBWDRMc28vdzl0UHNidnRDWFVDa0xwMVVENm1yNE03NjV4?=
 =?utf-8?B?NFdDM2RnRkQ5UkVXNHBSNzRRQUNuWjQ0L095ckJHK1o0ZEozVEN3RUFiRXBS?=
 =?utf-8?B?eUF5Y2svM2dMY2V4VE9DM2t3TVF4elVjNDl2OWpUdVM3UjR4b000Q3N6TTJ0?=
 =?utf-8?B?MklNYVFjeTlucDFZSzB5aUkrVEJKOXc3MVpQU3NtS255UkxSVEd2OUJMWDZ4?=
 =?utf-8?B?ZElVMGJSYURPQ0QzNy9WMEpTZUFGK0c4QSt6MHNsYTZMRlJrK1owdkYwZ3R2?=
 =?utf-8?B?amROWWYvT0xjZEJYMkt2UUYvSE8xVmg5aGpTdXh5R2w2Y2Z4KzNDY042amxR?=
 =?utf-8?B?WUpkd2Z0UmRIQVB5dXpXRVh3d0VnbkNraFVKMWEzZVNWb0RuQjRpS3R5R3FV?=
 =?utf-8?B?Wk9rYTJvOTBTMDNwUTk0Z1c1RXdjemllK3REWWswYWZScWlHVUlrN2ZiYzVp?=
 =?utf-8?B?YTdkZi84MnE1bEhKWXU3N3BNL0R2TVZva2pEbjFIVldPWWp4MTlCWEhScE9C?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F2E74D0BFBB1F4D8E3C4B28399A7809@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SSP5fKFqtHfO+A8fOnEa0FechYnHTvrwC7N2cJj6MqVLmo384Wlz9TIOX2jOliL4BaX4MrLcRXGnQIZu1Zy16NE5qmQmlNcbYR44q/w1xHHhSc1SB/OcHjVvcFHqgjbHIFrQG9Cstd5vDJs/3/god5kq+eLi1bzJSDSWa3W+XoiHVqP2QdjGTpK9YD6VnM1LQK4bTRxEEEmQ4hFT2U8G3UOQOILLvVy8jQ8rHmKXkUsqyjxcdRNMySUCmdxZ+YDwQyvXc4NKUdUKLOt3rmwtUZDxEYZkKC0c5/kK3Oi5u5KL/BVQOXTqI+PhDAPJbVXXZPB4Em9rowTmRTXeUW/IkZFDfTcHGZGgtoyFmddR0GlO/0EH+P9svtP41iVxa2YM4jVML+V5j/+lF7JBTwD4K7hQaR6z8kqy/RtajfeUV70GM2vFs7LZXP0HWENSd5RNcgzX7tY50DNuSteAUcJKYxFfYCcTNwOyiI26i9opMe7obZ1I+S/p9d2I3naJ5nrHcJidzX6yPW9kxwGA8kKn35zS28S98aPFF2S3FVCftqB5D7vaMgYRFQVpDFmy8TyjJyrIqyFoAuvB8z9l5TA/EnxpSbVO/ai/D7IGSu+v7tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aba0e4-59c1-4bd8-3cbf-08ddc545b0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 15:22:06.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWhbrAq9mFFzN1UHh9wZ6EELevZwze7y21V8MCPuqWsjdHzdtQsQttmmSd4DBL37EOfyeqlg7Bp8EIhdW5xt5yZe8KEYFwo+LS9zi57zvPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170134
X-Proofpoint-ORIG-GUID: rFaEyKdjckDAcv0mVzDYQy21x33foa5R
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68791524 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ofGaa-E3UUjty_L3GYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rFaEyKdjckDAcv0mVzDYQy21x33foa5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzNSBTYWx0ZWRfX6qRvbmJD8XGN iEuXnVYtQdD1vwUr0VrFEYva7z+kCu6aG86TuHE881cs9dHdMqAWcf2GD239StCyk9VfG9jVsW6 venLKpmUtvjLR7VhZDt3UyAm7FEuwGlOkc8yjOg1BM4ACl6O7ZNhPPBVtzbSU/Recm69nT2fUQ1
 cKQWU5uROMXfB8WAMBb/hGmiz25CWl4UEFME8cFIuNAff4DK0wIbOFlXNgfWaMm8+mwP20sA4Fd JLm7oL+yaH5Hkl92MOjBo7mzxuWqyxL8Y1mmEiuDqX5IaueGBBKejtIYs07Eif0wA2823iSBglW PHQyKlTdJXziboT5ibZzhFHw+eYV+Os2hGFc3HqE0ohC/Feo7rdqOGVXsr2ZaLyjQWstdbisp+u
 oRziUoW/RtqhnX0NIDwD38X2YIeBplJezd+iGiRzIMn8MvsSpiGdY/dTL6qDlRJt0uNZtN+S

SGkgbWFpbnRhaW5lcnMsDQoNClBsZWFzZSBjb25zaWRlciBiYWNrcG9ydGluZyB0aGlzIHVwc3Ry
ZWFtIGNvbW1pdDoNCg0KICAgIDM2NTY5NzgwYjBkNiAoInNjaGVkOiBDaGFuZ2UgbnJfdW5pbnRl
cnJ1cHRpYmxlIHR5cGUgdG8gdW5zaWduZWQgbG9uZ+KAnSkNCg0KaW50byBhbGwgc3RhYmxlIGJy
YW5jaGVzIG5ld2VyIHRoYW4gKGFuZCBpbmNsdWRpbmcpIGxpbnV4LTUuMTQueS4NCg0KVGhpcyBm
aXhlcyBhbiBvdmVyZmxvdyBidWcgaW50cm9kdWNlZCBpbiBjb21taXQ6DQoNCiAgICBlNmZlM2Y0
MjJiZTEgKCJzY2hlZDogTWFrZSBtdWx0aXBsZSBydW5xdWV1ZSB0YXNrIGNvdW50ZXJzIDMyLWJp
dOKAnSkNCg0Kd2hpY2ggd2FzIG1lcmdlZCBpbnRvIDUuMTQuDQoNCkkgZm9yZ290IHRvIHRhZyB0
aGUgb3JpZ2luYWwgcGF0Y2ggZm9yIGluY2x1c2lvbiBpbnRvIHN0YWJsZSAtIEkgYXBvbG9naXpl
IGZvciB0aGUNCm92ZXJzaWdodC4NCg0KVGhlIHBhdGNoIHNob3VsZCBhcHBseSBjbGVhbmx5IHRv
IGFsbCB2ZXJzaW9ucyAtIGxldCBtZSBrbm93IGlmIHlvdeKAmWQgbGlrZSBtZSB0bw0Kc2VuZCBh
IHNlcGFyYXRlIHBhdGNoIGZvciBzdGFibGUuDQoNClRoYW5rcyB2ZXJ5IG11Y2gsDQpBcnVuYQ==

