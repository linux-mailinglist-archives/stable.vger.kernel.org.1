Return-Path: <stable+bounces-227231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF+fJ7e1u2k8mgIAu9opvQ
	(envelope-from <stable+bounces-227231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:37:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B382C7F60
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AADDF3010738
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525433A9616;
	Thu, 19 Mar 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="MdtPObBO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395E21CC5A;
	Thu, 19 Mar 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909426; cv=fail; b=VayvNbxmQWKhwYA4GxxwNdB7LTXLqViNzd8vdGnK5ctMT1vBszVDcOHoIl+X4nlWOhyZwEwW9P7Yp72aeTl37VprNcX0wbAnZlx6gHZHN/Eek16B6aVLVp68CLsx+kopSzJMhDddnICi0F/qQM+Ro77ll86GpXFOhDgbm3P0ijo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909426; c=relaxed/simple;
	bh=02u3wEnOZ10A/WwloLF26QWLE0B673ionYnMVlHl8sM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oiHZG50jk+RQiyIAigogXcBY/GTc+yfV8X7+H38UTjHA1mRaw25gkNIhIzQO3wC98jr9TzUCBFqLU+pd+JPYJVcJeZsTgJkYCsCGoXUkPK73JTt02T0YM+mPItsVX0uyofigAVkIBfZRiFo/IOpyGZ+qkaXZ+2MfOvpbMSx1XB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=MdtPObBO; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62J5O5dt2996764;
	Thu, 19 Mar 2026 08:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=oR1geZP2V0QPyKYfUkkJ+W
	88B+FgI3+ooTOdvppwmOw=; b=MdtPObBOGzxlK7qHjQpqAkdhh45SQrSjX/Ehni
	wiCiSGw3q5H1cWaGrqk2o2WPv7224SIlUJCkh7XkPxASKyxCPez1x2VwkeJa+68z
	8YUGsjbpYYbXMZ9UeygugRBounTJNe2TPFUIBA+xk9RFoSUaRHSusi+9Cao0L3Qk
	EmqU6oSPbEwHsFyrAnu7cBQ+nNe7/41bqw+Uw3d9lVc4bDjFUj9nW+0ukgP9VFG6
	g56yjnasmnJ6YJW3BxC9q/XBO03dEqIaQ539hnFc50VJuwd4/pZqmM2E3sDyAR3U
	fffikB6C4rdSQZLOaExy+F78MUf6Ffm6QqM2UdIhaBnwcAVg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4cw03swnh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:36:57 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62J8YCwI005884;
	Thu, 19 Mar 2026 04:36:56 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4cw30xbngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 04:36:56 -0400 (EDT)
Received: from usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Mar 2026 04:36:56 -0400
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Mar 2026 01:36:55 -0700
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Mar 2026 04:36:55 -0400
Received: from MN2PR17MB3807.namprd17.prod.outlook.com (2603:10b6:208:20a::10)
 by LV0PR17MB7655.namprd17.prod.outlook.com (2603:10b6:408:332::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:36:54 +0000
Received: from MN2PR17MB3807.namprd17.prod.outlook.com
 ([fe80::888e:8ab1:c6c2:374b]) by MN2PR17MB3807.namprd17.prod.outlook.com
 ([fe80::888e:8ab1:c6c2:374b%7]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:36:54 +0000
From: "Boone, Max" <mboone@akamai.com>
To: Alex Williamson <alex@shazbot.org>, David Hildenbrand <david@kernel.org>
CC: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
Thread-Topic: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
Thread-Index: AQHcth/WF/LOdYvhgUWcXzpRmVvqP7W0zn6AgAC8SYA=
Date: Thu, 19 Mar 2026 08:36:54 +0000
Message-ID: <3C8F924E-CA2D-4368-83DF-3CCCD4BA49FF@akamai.com>
References: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
 <20260318152249.43eb81f6@shazbot.org>
In-Reply-To: <20260318152249.43eb81f6@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR17MB3807:EE_|LV0PR17MB7655:EE_
x-ms-office365-filtering-correlation-id: 5e35f8dd-66ce-4b72-ecf3-08de8592ac9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|6049299003|1800799024|38070700021|4053099003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 2R1W8GTGPyVXt1WbTXKXCnTkdt3Js/LH5MdQAO3ASgg9gZKVfMjcxqhlt9Yy+rOXfGj0qaNQIpSwO4+rN+3yy68KsbHPxEWRx9U8wTAi6VofQYd/j3aaOI2EQCoUd80U8uJFtM3LCmfjHQX9RYo5Tl2Noo6+9bmevCXhcsUOHK7M2pHpT1569IqHLLpMMBtUTAtkdADipYSWWGlavU563SoZQYT6HdL+Hm4505vjlr0zINXobD8ySj/knbTSqRNwNIfWTjlMYKDya9NrtpY7jCIQK2u5DXYOQmifC3BsBOBLxXm/d5tK41M9Z8oT+qvcQVUqHuO6jVpVIk09Grqg676oIS/znv8EqSnLxqCPdWFIcFHpI6wdz6JmyQ7Eq2/bil9Y9Wkgppag11EXlvhnQf38oGC2m8P95XKexN7aTalfe6zdSpESNmE7Zg0bBzNmk6uGb3KoqhACKF3KUed+miJwdgsiqaXZfU9OCimHOKlRVVzK2PFAjgV6mLDUgRQmPI4UNvTpxo1VTeTOGUkhYms4Z0b2N34+tZ9HaQANnftGxita0oJd60pIfecuVN8Ihw/Hv+peUDFm4/5D33Or8CsLEUKpPf6nIrJz/0DtRRA2p2UDhsUZENGw8nxmMfNOGMsjJA5R6j54hNLGmcpK0lAHVuNc72Mk9r6ihtX3MuOEJ+zSHf4bxJJbhZiiewrz7OrC70qLCXXytjZb3s6MDK/9Do4a6oX8yGdb0gkJqEuj1Nc9A2rNz4mLcPvmhOWVay04q81esp2z3lcnEF1QMzjaGIf7SOi/36TGt4eoS5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB3807.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(6049299003)(1800799024)(38070700021)(4053099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUJtWmVkUE9Rcm9qNXkzcXd2UUZyS1JzWDBIaERhcjdRWVdDSDJlbjMvTjY4?=
 =?utf-8?B?dDd4RTgyNFRVb3JaTHh6Y3M0ZEQrY211cUJUcmZWWFVkUDZtSnJYd2Q1M2xy?=
 =?utf-8?B?bG9mTFNKaDdpN3EveVlJai94empRNlBLSHlzZHNnbGlMcWVNUTdXNTYvcXA2?=
 =?utf-8?B?SzdBWXJXYjQ1NGhFYk1OdTcxdmhhcjlqOW5FbVAwS1M1MkprVWhUeStaOU5n?=
 =?utf-8?B?amswZ1ZiYjYvWjd3WDZjRHByUGJGVk5KdlZWZTFUbnhIOTRscGJiNjh0UjlZ?=
 =?utf-8?B?MVdWYVdtdFIybHpRSEI5TzRlMXkvL2kyTVU5R3JGV2JObHQwUS9NVmdXWGQ1?=
 =?utf-8?B?NWZqM2c3RERpcTNQNHhZdW83YWxIdFBqTHF5b0lvT3B6cSsyN0p6YVhFVUFV?=
 =?utf-8?B?bzNnTDBrSzdEOWdjZS92cEgvY3pjWHlVZ2NPc2QwbmtjL3d4V05uc2xJSDNv?=
 =?utf-8?B?WlJWNTl6VEdQNVZ6NC9aWEk0bTQ1MVhnQnZMR1BscGcwUUlkVXE5V0ZTYkVL?=
 =?utf-8?B?SWdGM0RwM3Vtd0E3RVRqbVpMRlVOOWQ4T3FtSStxTVdHbG5qTkxBcXVTV2NV?=
 =?utf-8?B?QUt1U1B6RkZNbGh2SmdCZWJqZEJpa3M5WmtjaHdiaUFNTytTRGdFWGRYOEwv?=
 =?utf-8?B?WkgzbXlaRDZteGt5UUNNcmVMNjN1a21rM3M2KzV6VEJuckhnaFlURFNocTlp?=
 =?utf-8?B?eXFhODRmOHllWWY1Q2tWeGJrak9jSVVsRmNNTGdBVTh2clZKUGo1NFVRUEV4?=
 =?utf-8?B?WWNWM2ROSC9jclh4ZEEyaGFlV0FQZys3Zi9seEpLRXIyWUo2ajFNRnNBUGI3?=
 =?utf-8?B?MDNZZjA3M0dJQmhSdzVuK3JmRm4xYk9sYll3cDlhU0NqeFF5c0srekdiUlYv?=
 =?utf-8?B?dVpKa0s0T2dob1JCRS9mU2xVdmZPZ3dublVWMXlqS1loS2c5bDFERVpTQjhI?=
 =?utf-8?B?Ujg1eHB3cWZ5cU0vSHNFWXpuS0JQN0sycFFNYU1TYkFKME1mdlNyZ1JxYXAv?=
 =?utf-8?B?b2YzRXVMQS9sVVdFcFpqOGtpQ1M0VWNRaW4rSmZqMUFjLzkyWngvemhlT3Jy?=
 =?utf-8?B?K3JrbytERGJzYU5zMzE5bTlQMmk4NHk1WVYvYkxRc2p3aE92L0JHa0hmVy9S?=
 =?utf-8?B?UGJiMk0vc045UFpneU43RzMzMWZjaEZGZUdlZkRnbXg2VmtyTmtmcWdUQ09D?=
 =?utf-8?B?N2Jyb01jbFFyQVJ1SXVlY3IrdDl5UVFDSVdpTGR0SmhsQy9QMllIODJtNXBN?=
 =?utf-8?B?bC84L3pNTjRPcFFoUmpyVWJXb2ZFaERDcnU5cFdjYWRBQnQvRXJhN29ZRkZ2?=
 =?utf-8?B?cnlGZHlIajFvS3FJb1dJV1h5Yy9HYSt1YTl1V05EY2xPdjV6a2NVb3YxYW1x?=
 =?utf-8?B?dkY2aTNKdXhBL09JM0VUNkJHcUxOQ0tBMCtNbEVLcjdqNFI1Zm5QUEprdnVu?=
 =?utf-8?B?NDg1bmYzSzJpUDlYaGtMY05Ia1VXcHRhWVZUOFBlRVdSajlwNEZBam5xWk1P?=
 =?utf-8?B?QW9xUHVnOXRHbTFhM1VMS3ZaSi82RU1ucmw3ekdGMVNoeXNtNkQvSWdqWld6?=
 =?utf-8?B?N3V1dmJzRFJNT3cvL3I2VUMwcTU4dytWTTJnQkJDTkhUYkJOQzE2dzUyZHAr?=
 =?utf-8?B?WTJCdVlsNnV3cGpnMDdsRmdoenB1SXg3TGM4alM1UXBTbW54K0c1YUxFdllm?=
 =?utf-8?B?Ujd4ekVneUhUa2NEaGFIUUdZSU4vRTV6VzBnZlYwcWRDMUIyM2F4MUVkckQ3?=
 =?utf-8?B?QSs2U0Uvc1NvMlpvemFpUm5ncExEaVpkd0JyRE5MaElCNzBHdjJzVXFyejcw?=
 =?utf-8?B?VnFVTU5URm5DQWEwbVQvTG10QjgyaGxnalVGV0ZlaE9HaTNPWXVFTWI4Nitj?=
 =?utf-8?B?TDF5b1Y3RnBrajJTV3Q5NTR3MlBuTE5ySkZlM0hWLzlaMzZibmFLSURsOU9y?=
 =?utf-8?B?Y1ZqUGh3RzlYMTAzTU5ZMmtnTjFiaGVldDRyNzR6QnFNcU5veUxqYnN2N1dP?=
 =?utf-8?B?dUZseTlHdFVaUjBXREFwVEpCMFhaQVZlNGw5OGM2VmxnZi9Rb2w0d0JqT0NS?=
 =?utf-8?B?VkNpV2ltYTlkUGY2Y0tGcktsZFhSMUFlazJwWjQzQnZvei9hK3VsT2s5N1pI?=
 =?utf-8?B?R0ltSFBxNkVmdFlpZjRNVjBYSmtPMlU1SHJKTDU0c0pWYTRJZloxZUhaQkp6?=
 =?utf-8?B?R3dOQnVOanorSjFnZGVHR0toRlM2c3htSUY5ZUx2U2FOZU9MRHR1dUg3eldy?=
 =?utf-8?B?cHh6K3VmVFFSQWVCL2ZJaXhlZ1pRZ3VwTUsyam1JZVJGUERWVy9kbXVzUDdO?=
 =?utf-8?B?dTJDSjUrQmtoTzB6dTB6NjltK280WEtpMHp4dlpxMzJFd1BkUkpqZz09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1jfhL6D6DaCoyHba7/F5G8WNSiG51TalKd8laF3kvCecOcD/rAsZ/BmWexdiPTRbmOyLs/atOB4K1rNX3iyLLJKYRW6tbWo9HuWCwRuVFl/AqrkVTi/k31p+swRovJX3MmCLuyfwcfPqGnVr206fXIlUY6ESHfLKULyJINYLv/943bAJEI7G7CEeUaW+wUQeQTMxTsWeaFJdEYujXqeK1km5uDoqB9117i6nEfKfd7Sm7gOMYK0fGaZrHNORukowM9r5P68xyF1nD2F90r7hU1y+9wkdfHO56oadqJL8El5L9Dn5uk2BxcEk5eVH51UIxG3IHBPt+4yI4QIit4TyQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKGZcHUcoQYAXtgwYdAy0CJ7tEp36uY6JXLIwJXOheY=;
 b=w7SSYGBtx11QejAfF1SAIqFfMvtVDMNbp/B9n/FWRbAx3vzQDZzLs/ltlY2VMEwwTd9NpPKZz1n+W3DgCy51YmlS5oluC0Y+URSYW1q27V6DAFZVXvTDQfi8RU2ERDMwANrz9qo6ifYyMzflZl5ldN9JOrDMPsHYwzCyofSXxAgXFUzJEBAOZEqUWarJit92gT3kRTRYW5HQsIiSERmUcEaE5E0AZtkDzTINa5e0jDxAfl62YlhpDnBpufOF6M1C5mjM2ndRNSEP0w+h6QYZZzn0hdq2w+MrGd9RnkLfCHOY96/fppFnhloA8XDnOtm0cEeWS3WkFPBYtoMgLhy3Qw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: nX2sQiyZAKe0NoKU0eslWNLzhyDXrJsZeW04d2hRezcGejuEiAgg+DaiGwNyBzPSbSgoEfl+lF807IWAIsRg2BRnogrnKNeMiAB8i9bkxehb5NH7PdXMonBa8RRiiokOMUMvF5zvEZFO720q/aMRaICLd+ndwL9LDxDACE7XWeeBrGL45D679eYsSM45+Y8B6bfKxtux0fXW43aZsOJjBe0SKbnlNOjKouGWTemFePOtkB4GZQS6CetLjs7QvS4sQA+8WJ4mYeKOtPnTkahNvNN2wzWCw945lIU5dl1UWCa9mpkawMuoVVzXIAKD+ymErBuFDih2k3LHE1xj8YlZ5g==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MN2PR17MB3807.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5e35f8dd-66ce-4b72-ecf3-08de8592ac9a
x-ms-exchange-crosstenant-originalarrivaltime: 19 Mar 2026 08:36:54.0510 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: V8LtcREY9Xcl52FTN5760Sc4fHUiwevbreoKUDr8FcfDRqMyGOcU3F8752X+DnN0DCQaURWK1EZewK3Pfd1Dkw==
x-ms-exchange-transport-crosstenantheadersstamped: LV0PR17MB7655
Content-Type: multipart/signed;
	boundary="Apple-Mail=_2835EB76-12D0-4946-979A-7D70876143CA";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603190067
X-Authority-Analysis: v=2.4 cv=Q+LiJY2a c=1 sm=1 tr=0 ts=69bbb5aa cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=r1p2_3pzAAAA:8 a=Tf3fbeekh0F0YBeSp_AA:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: Z2kp2isFyYPxrle51zwN_HmiHN7XDDi7
X-Proofpoint-ORIG-GUID: Z2kp2isFyYPxrle51zwN_HmiHN7XDDi7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2NyBTYWx0ZWRfX1/sBO1K4o1K+
 jv/pRxw/6uKFSsOzEO/IoMWknxXYYzPqcXvOtbB+lR4U6iGuzltQvX+TzUYzkiLHXX/Ycgb2dbI
 uNOyfJu9nR3gP2frHk5Jsvv1AMYl3gEFfNrOjl3dBFYG67GlT2cT8b3BDetcE5PhSZbZRXkjMgs
 +vA9tzPbAISW1rRopeC5LH5FKxliqbhR7TXpPaYWmFfkK2/Pqp1aWHzmtEhaSuOyp8jltqKdNfW
 h2eLANuZPN3/AMytvWAkdoOogf/hOXbP8XVhsKLE4O+aDeO+cR7WAiQQz0fbAZM+g1EADQ5De8G
 TPe0H+KabmeEWxNEzzMAK+gzCUG7mY9xQVHdLhpScuCkFoTF/tu3G1ZKCB2Noy0CI0YkFM6k4HV
 PVonogRpywD3szyLsGs6NDQYByUJnNPDnof3vFwzO14ZmgT4avHNtkNXSXDEjoXZC1uoqTh/+44
 ScJGDMVpyZQABWo1FVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603190067
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227231-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[akamai.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mboone@akamai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,mboone.akamai.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:mid]
X-Rspamd-Queue-Id: A0B382C7F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_2835EB76-12D0-4946-979A-7D70876143CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 18, 2026, at 10:22=E2=80=AFPM, Alex Williamson =
<alex@shazbot.org> wrote:
>=20
> [=E2=80=A6]
>=20
>> + /*
>> + * follow_pfnmap_start() returns -EINVAL for
>> + * invalid parameters and non-present entries.
>> + * If that happens here after a successful
>> + * fixup_user_fault(), it is likely that the
>> + * pfnmap has been zapped. Retry instead of
>> + * failing.
>> + */
>=20
> It's a little stronger than that, right?  We're betting that the only
> remaining non-zero return is due to a race and we can introduce what
> appears to be potential for an infinite loop here because -EAGAIN will
> get kicked out to redo the vma_lookup() and fixup_user_fault() should
> return a genuine error if we're completely in the weeds.  Should we
> make this a little stronger and more specific?  Thanks,

I=E2=80=99d say that the best case would be to have =
follow_pfnmap_start() return
-EINVAL or -ENOENT w.r.t. which of the two return values it is. But then
again, we could theoretically run into an infinite loop I guess - as the =
zap
and faulting could run in lockstep (the race window is extremely small
though).

We could make the retry above bounded, and bubble up a -EBUSY such
that users of the ioctl can decide to retry instead of fail?

David, you mentioned that gup already has retry logic that we don=E2=80=99=
t have
with follow_fault_pfn() -> follow_pfnmap_start(). Would we potentially =
run
into an infinite loop with this change?

I see that the same pattern also appears in:
- virt/kvm/kvm_main.c:hva_to_pfn_remapped()
- s390/pci/pci_mmio.c:s390_pci_mmio_write()

And other users of the function are:
- drivers/virt/acrn/mm.c:acrn_vm_ram_map()
- mm/memory.c:generic_access_phys()

Maybe I can better draft in this patch with adding an -ENOENT return to
follow_pfnmap_start() and in the same patchset add retrying logic where
necessary (on first sight, kvm and vfio)?

>=20
> Alex
>=20
>> ret =3D follow_pfnmap_start(&args);
>> if (ret)
>> - return ret;
>> + return -EAGAIN;
>> }
>>=20
>> if (write_fault && !args.writable) {
>>=20
>> ---
>> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
>> change-id: 20260317-retry-pin-on-reclaimed-pud-dfb9e26eb8cf
>>=20
>> Best regards,
>=20


--Apple-Mail=_2835EB76-12D0-4946-979A-7D70876143CA
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzE5MDgzNjQzWjAvBgkq
hkiG9w0BCQQxIgQg153+TEhSFoUOY20eBL8XK7EwXCt9eQ1+tr8fIeiirxkwDQYJKoZIhvcNAQEL
BQAEggEAk0KNebpdLWuiO/xvkdVry4yRd3zmJDsj2tiIra4JXI9nmh/hUBb8ftt6WnWT6KsxqqkN
wSUn9ud/7H9w7qUvsuDNUXGX2vumjzp4OY8YjCU5Rb43NvXu6I1MbKLlGr7TxRVZkCWyEQp7u7+L
Inhjkc6zILx/FnG2CpsKNZIm4vBWayoz2AiJfQFYtoraYfPcMoTTTN1N6kwToef6iPCUn+j5S2hx
7jx9qUvBY6o3Ik1vR7yjs+rGcOxtlvz1Jj0GrLe/7Fqxyc3PG4iDDceuMRJk5kr3hPtXwusFz4pw
783R2AqTTjKJzKEmoQ6JcLKpB+27jYdBjwn1b65K5OqzTQAAAAAAAA==

--Apple-Mail=_2835EB76-12D0-4946-979A-7D70876143CA--

