Return-Path: <stable+bounces-244744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMMFOYLR/Wl2jgAAu9opvQ
	(envelope-from <stable+bounces-244744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:05:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A714F6149
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4F983019D3D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FF3D5240;
	Fri,  8 May 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jqz4R//9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uygtg3KE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2D396579;
	Fri,  8 May 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241916; cv=fail; b=LJ2oKB4cJ0T4j+Wi/tn8RQPSyR0J3BpQOyrrNTRgw+Ugapji/gl5O6h5pHVBbQG3qv77p3iaN+3dlrX6i4j+lpXPCVdAn40yDiv14Q954ASvi3E4tYXMMKa+7+UeT8bSvn3bjAPPnvB8hI2UWa24/vYogFlOBIOnh2SYgHPVrqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241916; c=relaxed/simple;
	bh=1W4IqIeNlSlPa504Onziaaz2vgJNtz9V52UZyMU3Qnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=BaLrX3i+v80yCRyzxWqtlH4M/Wd2D+dSgIQfxDPTW0r2asTnX9ENIg/EZQvXnBSWJW4MooPGxBIsY5DRAQHrMFdhkj9F06CiLOr/FJK4r7Z9NDeR6RBWrwaPFRj4OUOB6FYXpAT7YNUJM8h2CIYdlWldSVVAqnOXxT++DtdblG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jqz4R//9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uygtg3KE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6481kR5D1742875;
	Fri, 8 May 2026 12:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=1W4IqIeNlSlPa504Onziaaz2vgJNtz9V52UZyMU3Qnc=; b=
	Jqz4R//9OywnYCEm4iat1WbIEG93PVGG2BtPSylzKjxxioUEjj+5l2WJ2Rn93Mgm
	3+Vnf4e/8DJBxIREA90dG91L9tCG2q6n0bYvNKPMB9Kb8pBEFYEUcshPxXUIO+a3
	jEJkMQphh9TvKkA7XzFvKpbKLrk/fqAi+jGT/34u4hRFRqllet+dm2EpS7Demrdt
	8wli48PAAjPl5PGAs0DkuGMTHwAkCxjFSe2QztmJT2uAWAqn8DJ3zPiZPGkws6m8
	G40P8e5l167Q46lF3wGfY0CbXzvMSZyxuPrU5fB4U/a5PRHoJnMIpouJSX9eHFVI
	zDOpCY06PZlipSYsT1dPYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9frjsma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 12:05:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 648C1KWA023869;
	Fri, 8 May 2026 12:05:06 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx595q5bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 12:05:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srCuuIMG6oJ6bmxmQprQsnF1jtHw10xXSzbgKd27QfgFgbiK1XPSMBF4kDXoLv3IwNNX0t1lIAgyR44aXDEr3N31ZUW5P6pc5MO2PuOJUgG/Cz/L1guMDWnzb9y5pBRB648Rq0CgkG64BMGRk1aiZNa8gG9H7m6awGceH5HCn8kRvywKtaTQVzvPuGHrpoitNek3wvEmol83GN11rO92lf0xCUrmaxP3eTvszVeALPwqSUuJw+Lkc02YPQbGzrZPegMynqfnDKjEhXiHbSStlgMf2PuENCYQxvkMDvxcr974DWQoHOg8iKrRAYQtKR/llAf8UJux+hfUXjpslcArJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W4IqIeNlSlPa504Onziaaz2vgJNtz9V52UZyMU3Qnc=;
 b=tX5Ws1EeOJsV9rjqN4KY0/55OPc0j44XuATwmw/8rCoInsEZNF4nDvO7HSuI/3v7eYtGfLHJtj3zixDU7Rtz1mmymvc6xgbxHYUsTba+7x5lGvtKcOQAqHbNRAjRGDPZTt96eXGa4BIncLfA4fZAsXRWj8wMZ8HuOpNNU2W0Wd2cyJtt2kRcMQIufn+iXMtIMq+CUKZlfZDOxX+Wf/2Lk53RX5uismj6FkSAC8rruc3uMfGENqKPBelmxUwzxA8Pho+nne5+iqroqjwHoEK2cM0FVjvQKJeBxN27GGfpCrpTi9iT0SQkqo0g+wxUr7UdRlscI0sjfQNFizxxHbXg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W4IqIeNlSlPa504Onziaaz2vgJNtz9V52UZyMU3Qnc=;
 b=uygtg3KELHTFx+Ptyjh7JBcz05utmToj2c3j1CUwx34grKR8CQCzsFOu1RFFmdeKc2oiBDCg1rCRFpCyxI+ueBnB1ifdDLR2lR00VSnPs+nhcupVd0jjcGLua00Qt4VDfp8BzGpk/xYYdVHwHz9zNLA1w0ncAHka7g7qpIqdFxQ=
Received: from IA3PR10MB8322.namprd10.prod.outlook.com (2603:10b6:208:576::14)
 by DS0PR10MB8055.namprd10.prod.outlook.com (2603:10b6:8:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 12:05:02 +0000
Received: from IA3PR10MB8322.namprd10.prod.outlook.com
 ([fe80::cd58:4f7b:d:bdd6]) by IA3PR10MB8322.namprd10.prod.outlook.com
 ([fe80::cd58:4f7b:d:bdd6%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 12:05:02 +0000
From: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "lwn@lwn.net" <lwn@lwn.net>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: Linux 5.15.205
Thread-Topic: Linux 5.15.205
Thread-Index: AQHc3uLm/6xAQ5X3eUKEthsud0QpUA==
Date: Fri, 8 May 2026 12:05:02 +0000
Message-ID: <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
In-Reply-To: <2026050835-appealing-stallion-a207@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR10MB8322:EE_|DS0PR10MB8055:EE_
x-ms-office365-filtering-correlation-id: 33f3d244-dd20-4a3c-8cdb-08deacfa0929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003|3023799003;
x-microsoft-antispam-message-info:
 pgoQlCMJ0TdPuxXwL1qfDas9i+x/r7uarYzYI6rJ1Kl6tZWIfnS8zkdpiGbmqd0z6BZVnVlOQeAxakwVp0wdZ5xi1W3uiSIWWF10L/rSBkuB1yi6gpNLxzckq6dBoiIPuvXgYT8inyTJhk4SorzzQkLmbjl1RDtjCoUfv9wemCFRA+qzbcY/4jOuJWMVHMB+r41cCIDfmpUcc1eGbgeLMZhb3Oe2a9C9lQSge5FrsSmC5/Mvb4pBvb5Y0wZ+7t801Zuq0/DRlN4/NypkEzQjKXE6EZNWjeYLHzc9qo4Xyoe+/0pMwMHfs15X7lV7CY5/5V6YZBuJKnEzFPMI8qCB9Nqm9rubJEAMILtrVijdQfEJio0lwWII1xrHn1nDTLl8geg2ropFjS62is6aLol+iKxH1i9auaohnK1T3d/eVxz5qbJj7ZHxfysLYE2EE0BbSBvsslkMPC+yKhoBF4Ks2G+rC5N9s9y+ODZTHVyG/G6mNA7LQZIp8+mOnEtvSwCn6G1UgtSnu6zKvhw99DSF1csTrxXfJGsl2M3d2KYvBTjYZxeyvBxiimVqwIx7Wa2vLkoLYpUBq+C1BG/5MzvVgKLjqwAn3EB91xGEIyDgGrb+zVx80yxQ7m9wr8MYrqTR+utDMll8ouve1cZg5zA641zMO5DP8ZfAG40b2HLy2ZohfKx8eFXgUXaJG35ZHI/cJxJe+IdQC/Rdnqx0WASCwhWf19AIWxP9kNzRGi63lUUKDJ0N3qqUpBtH/53eJxYr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8322.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmkvU0JnaHZPUGVQQlhHdjVDT2pHUU1HWkNQYmpxSTBaR3V4d3Q1Z3Yzbit3?=
 =?utf-8?B?L2QvanBwTkJpZFJML2ZoVSsyaVVmd2lKTUVETHROSlpyNUo1TDkwbW1mbDNN?=
 =?utf-8?B?SlRVaEh1TVplREJmNDZUNGlzWng0Y0hWR1BBRUdVZEVUZE8vWlVrd0FOYyt6?=
 =?utf-8?B?ZDVhU3cyRmhjVkxYcGJOUElaWERlUGtJTjJtY2dQMmd5TEFNZkFJeXlFenMv?=
 =?utf-8?B?aGFUTW02RnY1Q2lrK2N0L0pGMk1wSmUxNEV0RDI3c1pKQzVjck95NjVqSHp0?=
 =?utf-8?B?aDFpVGY1enR4VHR4MllsSng3b25yU2VXa21uMTgzU2xRa2NtM3Q0ZkxCMlgy?=
 =?utf-8?B?cFVGNjc1MjREVEZoaWhKeE5rZkxhemlaYkJuZ21lc0x2aG1YTzNINnc1czk3?=
 =?utf-8?B?SnUvVlJJWE1EZTlScXpXYTdOUHJVMW15ZDNodzVub0pBVlJOWnN2bzExdGhj?=
 =?utf-8?B?eSswVjdxalVlc20xbVd6alB2TS9NeWo5amhLQWdwQ2F6aUc3VDJ3Q3MwWVlq?=
 =?utf-8?B?bjhtNlk5Y09DbVNXQVZEcjJiejhlVUxNcnNhVklzdnlqdzVhWU1CT3JmU0ZK?=
 =?utf-8?B?VC8wKzIzMUFCdEFwbE1QR016MGlkWFUwUUdGSDg5Y3FuSDQ1cWZOeDFVM2Ez?=
 =?utf-8?B?NXpkRi8rd01VbmJ2WEkrVUt3TnFmODlDZ0YwdkJMSDFHRUFnR1U1WU53OC9Z?=
 =?utf-8?B?enBtVlFUam1Eelc3YWxoWTBpSVpzQjlSUmFIa1V5UEVzOGVOT2cvZEV4MW44?=
 =?utf-8?B?Ty9KZWRxRFhnUFBpOVVpVGI0RjhoTFdBWnhRM0IvalRldW1USHpKVUlJeld5?=
 =?utf-8?B?amxtVkF5ekZlZmtpSjAxQW5ZYUlzbEdkbmpFQ2N1eGlKQU9ZTWVDRzFsOVhU?=
 =?utf-8?B?L3VuOS91SSt6TUp3cTZwN2k0WlNVRnNveSsvdGM5NXpVeVN4Ui9SMVJVMFdE?=
 =?utf-8?B?QzlLN0U1RWRxdk1pdG5PUU5iUnFmeEdLVjZ2Unc0TU90WXBteUh0NVBoT3Y0?=
 =?utf-8?B?NVdkZnV4bTRTK3I1eWQ1M09KT0twQzlsb2d3TVEzd3B0NFBKRndjVklibmhR?=
 =?utf-8?B?L0ljeUJ3empha1BBSm04UlU5YWlIdm5vOXN4dGc1RERIZ0o3NHgxams1enJF?=
 =?utf-8?B?RDJiN3lBdzVoZ2hLdjE4aXB4NFJjNEo4VkVRS0RCV0VkaTNzMk9GZUdBZ2tk?=
 =?utf-8?B?Mk1SVjd2RjdTckxCYTRjME9DKzVGZlZJa0Z3WjdUOHZ4UWVOcGxvSlo0YzYx?=
 =?utf-8?B?bXZodVNKcjZvTDROc0xJQitVUGUwR29RT1duWXYxcTdOOE1UQmJjS2RZOERi?=
 =?utf-8?B?bnpzR1NSbjYzZ25yamUzVWpUNzNFcGJlanZHRHNGT0hkSDdmTWw4NzRRdFJI?=
 =?utf-8?B?dmJNcTloNVRsNnVZaDVZek12UHlySW8rc05NYm1HL2VKc3JpYzhMVGg3bWk3?=
 =?utf-8?B?dGlyYzJDSkVrVjVmRCtDQ1gxQ0dCU252eU54V2pIZnJqSzZIa2diR3BIRUJJ?=
 =?utf-8?B?aStOSURRd052UVdUck5FRVl5ZHlqNlRRWmRGTFlIS0tYOUNlb3ZBMkVuWlRa?=
 =?utf-8?B?WVc2ZkRZWDJQQ0QyNUVEbUM4TW9ycTRyQjEvL3VoUjVDak1UejFGdkJvS05r?=
 =?utf-8?B?Z0xmQ0VaY2VnWWJLWWNVNnJXeXFsRlBjL0RzdFh5WjA0WlI1bHpsNC9WQWdV?=
 =?utf-8?B?aWxmdVM4anl3c0hEb3BpcFVvUkJDdGF3REI2dkVVbjRFa0hZTGZzYTM1RExh?=
 =?utf-8?B?UUFiYzljbm92L0tWZUtmd1REUEFENnhlekoyWVBJbEttOW5EY0RSWGZCN1dr?=
 =?utf-8?B?dGZ0dDZzaDB4cnJaNzJQWVl3a01pQmFISnRFcVJoZ0hIbDJrTVBNRXRzMzdC?=
 =?utf-8?B?OXptdXVrSVpqS2hSdkFDWHp3dU41S2hDWDV3V1RKMmpVaHQwY3RUa3JZckNU?=
 =?utf-8?B?Q1ZycmdsTHZTRWNVYndCMWdZNGZPc05Ma1E0ZDF5dzVITk4yWEtJRXBNcUdq?=
 =?utf-8?B?Zjhnc0tDVkJ1aVBmaEdFK3FvanprTEdiTUp5VlgyUVQvb2lJRHBQSlZ4WVB6?=
 =?utf-8?B?QldFcHRpNlQxNVJRUzVsMDFzTllvYWV3Y1Q3bDRVeTFmemRhRGFtNmtRdk1Q?=
 =?utf-8?B?cnB4OXNseXg1eFRyd2ZIY3hkSXRMV3FQbmVhUFA1NUJEYjI5WU1GQ2pleHJu?=
 =?utf-8?B?YmNQMUNTdVBMalR5NEZXbWR4eVFOY0xmMG1McHBvWUh2ZmRpbDY5aU1mSFhW?=
 =?utf-8?B?MlhqbFhmWTdTQ3MrcFNBWEtwSzNwN0ZxdVdWRGJrQVl2WmNYajl4ZXpmTUNT?=
 =?utf-8?B?NEIrT3NTNzZXVWN3OGJMRW9uekFkSk8wNGptalBqbGhyT3pITXdEc0EvTHMr?=
 =?utf-8?Q?/Wgl4E1ojR0cIczk1iK9XnW3npDZse5Fw812Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B04CCDC71B7394F9B088FD3588C03C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OqS5vsFJEMvoIMfXG+z9dtSiDfm49SLHXgrIM6BH2VNrnallOviI5ga6BM5fD9JS7jaO4gZXWH8hGIs6Hn+6NNiZbLWmSnOdkoJF/MbjdGr059It3xBtDtFeDmhS+HTdIDuO9wJPXL+80htVn36DvCiejAZ5PtXGTRrctINF5VfKzzeVm5GYaVgc7BDXbsY1fDU4pUTC6wUJj87gt62xHmtjRtKEB7KNQCs2E3mIppFbMqNBHYJlXuQOwVLJOKfe5r/DoKVtQLIdOJUAa33+dK15pwByKQBomq/2qWmiU/y/VaXTuevFpEvmXUEc91E2a8ahUPGodyxlOZkBcvj8MQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D0zrj8yyizqSQGz+Wxknc0CXiNekr5LLfC20Z/5y3QGHEYF3Jh6y/HGmeBWmZaCyTzbzTfDKh2/f2kjDsBecd1zbEodsXt3sdrpO7hE/JGaktku2IlDz9nOLefNG2QsPGla0O5f40SjSBfDkTf8iV0+mJYsPBvpC8u0EZM1rLD3ZRmgZFfyF/pKABqZTIVhuOlW6rySIR6RaZUajsIftJagfMdntunpFEq/CSEZfqvx1JNEQXYjRVZvqQ8xJAHc58a8vEYCiZRyAmdPikmOQVj2zYS7TtbMBhUqkyZ2ZV682cQrqmLpx8i80DpvI4D0ctsZPXFRahTpoNTTFeC9BXYZan77o+KcJ1DUBlbu8QvfcIM+OFsCbWcduYwBm8xI6W1hO3g+oAdJWYMTVVQrDcIsJ02EwuPtm4UvvAW6Hy0F2UHMxLt7f8f9fDIPqQxxCCkrRdXnEmFpMEU3VTZN+WoshC0QFUtoYVfMaHOlyy16DqE2Ers+mjnQk1iYAb9o6vOJU2mjgASeANFCZTuzW00kppZOEfZKQRQnpheYFNnk3N4Lp4X3udaQAKdcR/E+5i9YxHRHHywmTCGxXKVJhr0HmYACjRSBnNtV+BwrCv6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8322.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f3d244-dd20-4a3c-8cdb-08deacfa0929
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 12:05:02.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJZua4vMRFQ1VnGk8ytWLtsaGbm57fHph/RajprsjFCepl4Vf4LkcnLJ2XlZE6dOS39/Z8az/T1d/ZrNRym2XYYXfWOfHY5fKaQrVAkWgdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=459 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX2V5cZGBVUipd
 t6Q4/g19ziFYf7WxxMeEYNjKAitVUwvVhOaBLx+G8aHGwHLGqLGzhm5NGfrOxeH2mvpZu9UZVTe
 KROTXb3drd9UTtv8xVqs9R3uy4bHJBL0PL7DBnbVNx9LSpX3OUWPzGNBOjoHNDZIOWVzowdlTic
 cI0M+/+gDQJDcAD2usc7RVnTxEFJ8iSO9weHhPdcGGvbM6WCAuVKzfwvEsYuYMOQcq2nHpOmwGu
 PcQc6l5DxVnJ0avv/xF1kCyjDFb5DWF/Pic4lLIDCCwPtXawmJ0EwOI/Isas4iioDBc1olBSIFq
 r3d4fouL+jdGbHJyo5I0hPq+PL6mmVcpMiGkBkWMAO+22ETq+QlD0GdHSwHkEZFDoM0OWN8A55g
 fWYUKnVI0C9BKHbaautwyHYMC4LGR0jgQEtt2PNytqd28tlgM4aah768azfyx33lzc47PYHualK
 rtpqrOlRPQPYBMsvyZ0H1Z6HHDLdhbzC7iRCVON8=
X-Authority-Analysis: v=2.4 cv=TZ6mcxQh c=1 sm=1 tr=0 ts=69fdd173 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=MUvaavvMVnRRQpdFBiUA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf
 awl=host:12299
X-Proofpoint-ORIG-GUID: 45OVDdA1lpLbbYfFFzQRyyuCvryLxwoe
X-Proofpoint-GUID: 45OVDdA1lpLbbYfFFzQRyyuCvryLxwoe
X-Rspamd-Queue-Id: F1A714F6149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244744-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.grzegorzek@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

SGksDQoNCkkgbWF5IGJlIG1pc3Rha2VuLCBidXQgSSB0aGluayB0aGVyZSBtaWdodCBiZSBhIHNt
YWxsIHR5cG8gaW4gdGhpcyBodW5rIGluIG5ldC9pcHY0L2lwX291dHB1dC5jOg0KDQpza2Jfc2hp
bmZvKHNrYiktPnR4X2ZsYWdzIHw9IFNLQkZMX1NIQVJFRF9GUkFHOw0KDQpXb3VsZCB0aGlzIG5l
ZWQgdG8gYmU6DQoNCnNrYl9zaGluZm8oc2tiKS0+ZmxhZ3MgfD0gU0tCRkxfU0hBUkVEX0ZSQUc7
DQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBTS0JGTF9TSEFSRURfRlJBRyBpcyBhIGJpdCBp
biBza2Jfc2hhcmVkX2luZm8tPmZsYWdzLCBhbmQgc2tiX2hhc19zaGFyZWRfZnJhZygpIGNoZWNr
cyBza2Jfc2hpbmZvKHNrYiktPmZsYWdzLg0KDQpSZWdhcmRzLA0KRG9taW5payBHcnplZ29yemVr
DQo=

