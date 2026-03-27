Return-Path: <stable+bounces-230710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBaVAjXQxmkCPAUAu9opvQ
	(envelope-from <stable+bounces-230710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:45:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D53491C4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C505C3037449
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8E411626;
	Fri, 27 Mar 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HazL2fOR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03294407119;
	Fri, 27 Mar 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637100; cv=fail; b=uRzeE1z8UPBPs5hUbtIiUD8anJUt7de8U7vJ99h18fp3e2eIMvBCt8i3WGQlpc96WpL3pqJVEZYgcmRKjYr0+67w/UoBUz7TD1jbyTggMeFuxK2rfy8cntGRlV7X3Q9zkyk3mcUHHM4GtXGAL5r3PeeWWNuKBTqCiPex1QeJI5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637100; c=relaxed/simple;
	bh=xj6hsTtv7qlD4oXXCfJW3lDLX6p4zERVZDNtt+OnSYU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cpszM9ZvL7ur+pzM7euTsKD4h/kYP7bQBcNWVVSGFbVG2e7RJkIjhPOfwfZCt1C93zNTHsg/5Ix3OhAPjn59tarova+gZm+FsBGS59KXZ5oTxQJ/bAj8YXj94bfEvk3YZb+66cXsLMG1b+ade512Ov4pSpi4XFwSs8a+DK4vA+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HazL2fOR; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RCUAa43255707;
	Fri, 27 Mar 2026 18:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xj6hsTtv7qlD4oXXCfJW3lDLX6p4zERVZDNtt+OnSYU=; b=HazL2fOR
	MQwAoHIWrW6wLAl/qsp25CBzyZqMmKIMXR23o776ALp4R31/CLBuM63FYZk14upG
	HTJA93iRAzBNo6aBtLC+TdONYKSZE1+504Hkqfe3UBs+V2TDHWMo42wkT6/6XbPU
	3U8f0S0LTHAoaQYYm5BUqDjJRFFNgQYGdS6siK8ATFvkYnHpy/2/BgueU0kmI0dz
	4JLAFPX+Kw7SLKCVssxPQ+cQWgDw7klXxrFfQU+4IgIaNaFZhi5dunr/9SoPQR1p
	IEl/3e8L0pAWpA4wnaB+AIbwQDv7WHbUyeqaOhEnkdhsCPCSgUGazGNdK1U9cmrm
	VG+Kxuaf9Ka1sw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kun2het-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 18:44:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6ZXc+E72if2Qnrv5crJf/HJITL7ZdxuwnWgAFtxNxkucxYlIJqTbSIbf+EKR+ND2Sm1CPJ0MnPsSL4fK2LBWjkeN7MpelE8Cotif43UuUP3t1u3EMBrA6qAuzZfDZsy208LZ1XriJrbnFzyKHbxE5Zja6exDklqmN0p7i7z6c1SGpUtbyuyrU+K5/ryGBLSh7YbaAJ8zIo+nm/2e28vJxtsR4xhKB510M0NiVFaTRGV7PXHXcEfp5e4xCTkx0LBIIwOlnZxyipV7Rq84JwUQOV4rf5BNVDh3qDsoHFSGe0wMMnRXVEC9SzB6P598SdpcFRQNBgTX6i4Mjfl2pm9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj6hsTtv7qlD4oXXCfJW3lDLX6p4zERVZDNtt+OnSYU=;
 b=b05WIDShpGai3vjkuAMuTmiYCBQDbAsOpG6pAjvM68uF159hv53U24/hcmhVf+jooX4lvH8dqJmeObw2cSmY4Ol+ayLOGT2nh8BdzTe66uRgag65CH+UZQKOqCGttmst31TA5vrCw1iSAOvtTKG8eipJIKIn0BExyF7AhkZBBctFcE2hhnxXmt91uJCQbkxk2rMyuVAo1i8sIHZHX/bXOUAUcAGHNkgw55OD/8cALpe6wpJ5RK83TOEinrMOa2/4GDvt9SJRIyZkxe00RdYg+bwiWjefbgiZ0pR2RMqS6vd0gUc7YF1jof3Iy5103pe8YheYWeQTviVB2f6wp3hNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF95F6B1BE4.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 18:44:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 18:44:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: only d_add() negative dentries when
 they are unhashed
Thread-Index: AQHcvgqmxLumFOqqCk261e1zVk8aNbXCt4GA
Date: Fri, 27 Mar 2026 18:44:51 +0000
Message-ID: <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
References: <20260327162308.1118621-1-max.kellermann@ionos.com>
In-Reply-To: <20260327162308.1118621-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF95F6B1BE4:EE_
x-ms-office365-filtering-correlation-id: dff5484f-9b0e-47d0-3490-08de8c30ee6c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 e1k6eBDATVJ+AdZxy+OtvboQYszdJM8Jtpo0L+mVKRx9g30dDlp0X3ysluFXmT7ynxgvUit2VbxfqGZtb+97B2gxZzIGvEK2hi9qDWHDg3/5k65AePnkHcO2S/3GGS6GBJF6M4vkJFqu4YEj84gYr2HkW7xa7DNK6uq1PESxvgsNgpFGdJ8BrTVzdh9nw6KamgLHoJhy2ethb0JKdPZZ3q6oly5q0S7CE6pPD3QScZm1E6a9ZXVqMT4wrkz69NPzutDztJVg+w8T6UgCmGKe6O1uD6tgiG42pBfl0tylKqnupGW1W9rOTUVbBhQ1R63QKwBw8i6pzEVj5ywn+oVcw/w/iiswc5F0drJEFFh1qOe7xnij9+RDUgLHqZ1NAxgVJUrjRc00EUcz6N+bIKe1wLpMCVht7u7OQFuacGMbbA6HZel860sOZyMH3Demk+Nfnv+m1J/A+2cSW0aig7Gpyp+az+igTUdOWICXbBrE7aI1gcXRyN1fRw78fAhaIQU1KcKcIIlxw5Ci98cqPGS9UYNb9leqnWLM/Hn6OYuK34LuXw4SEHNZkc2exCL7kARgq7w4TnQziDRg+ejvaduSxl+hsftTJ7Z6D5txxA6NBh1SKBM0xDtC2MsRRgKvnC5FC5k83jl2ZmK1svhc/SpP2pn/D1/JcZA9T8x9nz8427m/9dPpN+EdJjqhvdU4HHCweP9DyqBgv5LBE6EgdhJbqBefTWeQV4paNiSrDGqUNxXjxWsn8AjauDxVWYUDZFqoJSbiPEth1oSm3GV4mumwtmycHsSeI6RVJTVf0rNDCnc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG55Um04dUgyWk9HdFFFcU04aFVWWm52TmYvN1cxWjJ4dXB2SlRxeDlaU0Uy?=
 =?utf-8?B?YlBsR3RVc21ockgwak1Ka2loc0RDYUl1N1hPUHRjQXh1ZmkvZUVIU2dxYzhh?=
 =?utf-8?B?RWs4bjJyVmpKRFVTMkJNRHZrbzFuZ2w0ZW1CRlAyM0xKc2JENlY5VlpkN29G?=
 =?utf-8?B?cnljMG1PTmhacmk0a3FtTm9zNVVTNVBDM2laQytWcldqcDhCbHFSL3R2WlpZ?=
 =?utf-8?B?bWNOaS9lNm9lU2FOQU4wZ25tMzdUL1k2VzJKYlZXZUtialZURXlhaFRNdmQ5?=
 =?utf-8?B?TWxpYTZJZUNHbnQydVMxWDIrQm5FUkF5STlqZTYzTXFwWGZQMGI0ZXBWUC9X?=
 =?utf-8?B?K2V1ek5Lb0NtUnZOQkpkOTdLTjdjcWZhMitNU1ZMWGxQd29DNExyYy9XSkNl?=
 =?utf-8?B?MUYrL1ZGV3ZIUXR3NHFPM3JLWVFDOGkyT09sR1JMWFFhdzVuQStRWWMzUVFF?=
 =?utf-8?B?bjNLcmtsZEk3V1ZieGl6RzFmZU5GSTQyeWo4UDhhcGd6THBuTlZrQ2FPQlBK?=
 =?utf-8?B?UmY2UjJJbm9sSEFoVHRUNysxaG55cDc3OUVYdUd0YW1jV1E2RkZjQ0xzM2xo?=
 =?utf-8?B?eVJ0UmpmUTZhcjRURmdXTmRNak1BUW9tOWtTSW42TWx4Mm5uUWI2aE04N1J2?=
 =?utf-8?B?WUxwelZMazBpZ1NQSDd1WVh2MWMrQTFRbkx2eVg3a1ZHbFkzQ3FNR3ZHQ2h1?=
 =?utf-8?B?dERHelRzYzdmMnBFK1hNVmFFWVVEREJXeG9CRG1DYitnb0ttRUpOeGxIemJ4?=
 =?utf-8?B?RW93aURIajBTY05YREFDcS9FOTNoUzU0NDl6UDVKQTJHN3p4emlKTlBSN0py?=
 =?utf-8?B?M2hJVUNRVE4rdWx6UEQ0Z01pMGEvWHNVWVlZR25kdFE0SEUrN2tyN2ZvTUR3?=
 =?utf-8?B?TFZ1dnZjVk5ZV0dKNU9OWUhncjBHOExDUWhzNTRLV2V6Sk1QOHA1STNWUk5O?=
 =?utf-8?B?em1jYUFacFpyTk9EckxpeThDTXpiaEdsQUpvcVR0NFBXMzd3MEd3bldQL0dB?=
 =?utf-8?B?aDNSUHdEczhheXgyMjA0TVJLWWhROThtcW4weGVkNlhUeUxFNnJ2c0JiN2VQ?=
 =?utf-8?B?VDlkbnd6bXdHNldLbzR5alBVbFl6cURJSG5Ud1o2eUhIbmFLcEhZUTZHRWkw?=
 =?utf-8?B?Zm9kMGx1K1k1QUgxRE5uWTYrd25rekEvTnc1OVVXVUtrZmdnL0pWMURHUkd3?=
 =?utf-8?B?U0J5NU4rOU1mSnhCUGc5SlRKd1VvRmV0ODk4cEY0cUpLT0JlR0NjVmNlWHI0?=
 =?utf-8?B?Y0hlK1IvODNUMEtFTktxejNYeHYyVEtiUmRWSUpzUFRiQWZER3lNYnBvdVlo?=
 =?utf-8?B?Q3JmbUhzOVdJUWw2bHlvUVNJeE5YUisvQ0huT3U1MnlVN3JnbFJlNG82OGFM?=
 =?utf-8?B?YTZwS2s2T2hhWjZkQzZtcDBYY1BQRG9OczdBWHlJQnFUclZiWjRCQUVUd3M3?=
 =?utf-8?B?ZlpDeTEzUTJnRS9lcTNxanRoclNMV3lhYVV6MnVYaHZUNWVnU1JVMGRVR2xX?=
 =?utf-8?B?M3ZuVlF4bTRGK01TaVd6UDFpQWl5SFA3N3NveXBlY21pc2YwVnNGUTNTbDRt?=
 =?utf-8?B?Ti9XSWxUaGdrVW1ubDBrQVQxbjFEajkrV2tpL1dQZVIvZzRkajFrem4wSXl5?=
 =?utf-8?B?UEllVk1qeStBN3dESnY2RDIvd3hUaElFelYxMUh5MUdNVkF4c28ybGFDVHQr?=
 =?utf-8?B?NEl4S1hiNzFjWkZlbnpPVEptZisxSWsxc0N5SW5JY2dqR25UN0RjQmR5dHBP?=
 =?utf-8?B?eG8wR0FPK01kV2Z3d0NJSktITzZ1dG9BTE9sOXlESlpPVHhVQngrYlRoUFBj?=
 =?utf-8?B?d0NVaDdlcTZnQmR6TEpMTERsd0xSWG9xMFJuTlF1WnEyM3JLSFpRVGExdmEr?=
 =?utf-8?B?THVZVUdRTXQrTlVhQWFrak5nNTBEK1NvNWM2a0JpdU5JMVI1WWtsQ1MrY3Ez?=
 =?utf-8?B?K2k3ZklpaExTRlJRb3JXbnJ3ek1jdXkrWXMyd1ZxRWpuR3NVL3RJanVCYVJX?=
 =?utf-8?B?TjJ0SVRycVdZbzR6bjJLSkQ2bkI2WW91dDBkdU1LOVZKMjk1QlZ4Yk81MHo4?=
 =?utf-8?B?OCtuM3lzVUhNYklsTm9iYXZQTm83MVV1clpYekZLRUdONUJ3bDFrV1E1bk0y?=
 =?utf-8?B?cmZoNDhKcnFycDBad3FpOXo2Zzl0TndKbGxscnZQTU9EZGFpbFoxNmlnekN6?=
 =?utf-8?B?NDhHWnZPS3VjdjlIYjcxRTlBdGZQei9nMnVIUGhoNjBhT2RWckc2K1BRM3VV?=
 =?utf-8?B?RkdieFIzd1ZWN1RlbHRqSm9SbExPc0ErUVloOEVMV25xSHE0SmJLdDBGeUpJ?=
 =?utf-8?B?Q2kxR2kyZ24vc0ZnbGJxRXIyNngzRFNYMG41dlE0dkFMbGk4OVlDa1RVMEx4?=
 =?utf-8?Q?9Tc0A+6sothEpyaqKbxEYagCESdFc6wM2e8MD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76E209A36021514D889F366FD580174C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Z9CL33AZYaHPbHuG+jVRI+7mIqfck1t2I9JTx9UCruWoE22yZwf/iqksg4THUYxUJRRVQgCYGRJIPCu+Ua08c6d1L5twUWALZnvRCMp0foVyId6CpJoxTBeuXfdCXlrDpnyQeTVJAbs/wcrhC2qhkOaKAZIdjuRmUB92BbtwBh7ABJ3S8j3CuZaJwy45ORfQxN4sXYvgKdTWmw6ZUy7QcVcQq8X5WOT4JRHmv58eyxQHMoXRQKWKRtgMFujQfAONiEqCAN511ZWPTkyOE//fSe6O/rjuXpvtsh/UeKTXCgUpUlDOKHxzia5dB43PIMBWM0UAhx6mFD30tBAzgdHsng==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff5484f-9b0e-47d0-3490-08de8c30ee6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 18:44:51.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNQ2OAO29nzG2w0vE3M/+gOu/E97Gb1Mi4+sk/apPjMmeRf9NF30wwXD+3g4yEk5SI4JaRedBEqxuIAmMaLjlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF95F6B1BE4
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9VioRvYUcMTOhIz5pu1O65lWIKYGrJND
X-Proofpoint-ORIG-GUID: wbKSq9887aUXRJJ_t9ZpgkZnkNM4Y7rP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyNyBTYWx0ZWRfXzz4i5dzHeESf
 F8ml5eKtMwMLmj8upSmUe6QA+hRZwW53lNLiRbEELFq+khbDJu1VO4WaL8wLe9NrGFr7/sS1yMt
 s9ZvSY5Mju+LepHQJt9YAdDr16a1QuHaKZBVD1tk8l1jk3hcWf4cUAQ1wVIadZ7KlqZW3p+k+8A
 j/472qvTPAVhwAi5/hGVcLnQf09qizp/qRyVlwQllaKIPk/mN0eYD3kX08x9ass6MpSItL4CVPW
 ofqzy7hlqRK5UJ4o/QZINbfT+wGwVnjqqqPjgTHZHtNtj5dgwjthcBjIqwZju06dCKEJm2Hsp32
 aiICuMejQfamy7pNYKaQbscFdZ5+f4CG5pUQ7kTOGbY4eHNbwkOJuMSIokVi+YNJSQJWiVgxLv3
 w8d63ARMJR7g0e5y3ZMV0txYnKnrlVspjLdlyOg2cR4w4/gp7lbN2wIHAKTySjCo0NPULBK47Rl
 hL0ArpKwJMlAmD7OLFA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c6d026 cx=c_pps
 a=AdSExLHk7727Th38kKp3hg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=0IhSICJnwgiYTbdNJ0gA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
Subject: Re:  [PATCH] ceph: only d_add() negative dentries when they are
 unhashed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270127
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230710-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A66D53491C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE3OjIzICswMTAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gQ2VwaCBjYW4gY2FsbCBkX2FkZChkZW50cnksIE5VTEwpIG9uIGEgbmVnYXRpdmUgZGVudHJ5
IHRoYXQgaXMgYWxyZWFkeQ0KPiBwcmVzZW50IGluIHRoZSBwcmltYXJ5IGRjYWNoZSBoYXNoLg0K
PiANCj4gSW4gdGhlIGN1cnJlbnQgVkZTIHRoYXQgaXMgbm90IHNhZmUuICBkX2FkZCgpIGdvZXMg
dGhyb3VnaCBfX2RfYWRkKCkNCj4gdG8gX19kX3JlaGFzaCgpLCB3aGljaCB1bmNvbmRpdGlvbmFs
bHkgcmVpbnNlcnRzIGRlbnRyeS0+ZF9oYXNoIGludG8NCj4gdGhlIGhsaXN0X2JsIGJ1Y2tldC4g
IElmIHRoZSBkZW50cnkgaXMgYWxyZWFkeSBoYXNoZWQsIHJlaW5zZXJ0aW5nIHRoZQ0KPiBzYW1l
IG5vZGUgY2FuIGNvcnJ1cHQgdGhlIGJ1Y2tldCwgaW5jbHVkaW5nIGNyZWF0aW5nIGEgc2VsZi1s
b29wLg0KPiBPbmNlIHRoYXQgaGFwcGVucywgX19kX2xvb2t1cCgpIGNhbiBzcGluIGZvcmV2ZXIg
aW4gdGhlIGhsaXN0X2JsIHdhbGssDQo+IHR5cGljYWxseSBsb29waW5nIG9ubHkgb24gdGhlIGRf
bmFtZS5oYXNoIG1pc21hdGNoIGNoZWNrIGFuZA0KPiBldmVudHVhbGx5IHRyaWdnZXJpbmcgUkNV
IHN0YWxsIHJlcG9ydHMgbGlrZSB0aGlzIG9uZToNCj4gDQo+ICByY3U6IElORk86IHJjdV9zY2hl
ZCBzZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVQ0KPiAgcmN1OiAgICAgICAgIDg3LS4uLi46ICgy
MTAwIHRpY2tzIHRoaXMgR1ApIGlkbGU9M2E0Yy8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJx
PTI1MDAzMzE5LzI1MDAzMzE5IGZxcz04MjkNCj4gIHJjdTogICAgICAgICAodD0yMTAxIGppZmZp
ZXMgZz03OTA1ODQ0NSBxPTY5ODk4OCBuY3B1cz0xOTIpDQo+ICBDUFU6IDg3IFVJRDogMjk1Mjg2
ODkxNiBQSUQ6IDM5MzMzMDMgQ29tbTogcGhwLWNnaTguMyBOb3QgdGFpbnRlZCA2LjE4LjE3LWkx
LWFtZCAjOTUwIE5PTkUNCj4gIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjc2
MTUvMEc5REhWLCBCSU9TIDEuNi42IDA5LzIyLzIwMjMNCj4gIFJJUDogMDAxMDpfX2RfbG9va3Vw
KzB4NDYvMHhiMA0KPiAgQ29kZTogYzEgZTggMDcgNDggOGQgMDQgYzIgNDggOGIgMDAgNDkgODkg
ZmMgNDkgODkgZjUgNDggODkgYzMgNDggODMgZTMgZmUgNDggODMgZjggMDEgNzcgMGYgZWIgMmQg
MGYgMWYgNDQgMDAgMDAgNDggOGIgMWIgNDggODUgZGIgPDc0PiAyMCAzOSA2YiAxOCA3NSBmMyA0
OCA4ZCA3YiA3OCBlOCBiYSA4NSBkMCAwMCA0YyAzOSA2MyAxMCA3NCAxZg0KPiAgUlNQOiAwMDE4
OmZmNzQ1YTcwYzgyNTM4OTggRUZMQUdTOiAwMDAwMDI4Mg0KPiAgUkFYOiBmZjI2ZTQ3MDA1NGNi
MjA4IFJCWDogZmYyNmU0NzAwNTRjYjIwOCBSQ1g6IDAwMDAwMDAwNmU5NTg5NjYNCj4gIFJEWDog
ZmYyNmU0ODI2NzM0MDAwMCBSU0k6IGZmNzQ1YTcwYzgyNTM5YjAgUkRJOiBmZjI2ZTQ1OGY3NDY1
NWMwDQo+ICBSQlA6IDAwMDAwMDAwNmU5NTg5NjYgUjA4OiAwMDAwMDAwMDAwMDAwMTgwIFIwOTog
OWNkMDhkOTA5YjkxOWE4OQ0KPiAgUjEwOiBmZjI2ZTQ1OGY3NDY1NWMwIFIxMTogMDAwMDAwMDAw
MDAwMDAwMCBSMTI6IGZmMjZlNDU4Zjc0NjU1YzANCj4gIFIxMzogZmY3NDVhNzBjODI1MzliMCBS
MTQ6IGQwZDBkMGQwZDBkMGQwZDAgUjE1OiAyZjJmMmYyZjJmMmYyZjJmDQo+ICBGUzogIDAwMDA3
ZjU3NzA4OTY5ODAoMDAwMCkgR1M6ZmYyNmU0ODJjNWQ4ODAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwDQo+ICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgw
MDUwMDMzDQo+ICBDUjI6IDAwMDA3ZjU3NjRkZTUwYzAgQ1IzOiAwMDAwMDBhNzJhYmI1MDAxIENS
NDogMDAwMDAwMDAwMDc3MWVmMA0KPiAgUEtSVTogNTU1NTU1NTQNCj4gIENhbGwgVHJhY2U6DQo+
ICAgPFRBU0s+DQo+ICAgbG9va3VwX2Zhc3QrMHg5Zi8weDEwMA0KPiAgIHdhbGtfY29tcG9uZW50
KzB4MWYvMHgxNTANCj4gICBsaW5rX3BhdGhfd2FsaysweDIwZS8weDNkMA0KPiAgIHBhdGhfbG9v
a3VwYXQrMHg2OC8weDE4MA0KPiAgIGZpbGVuYW1lX2xvb2t1cCsweGRjLzB4MWUwDQo+ICAgdmZz
X3N0YXR4KzB4NmMvMHgxNDANCj4gICB2ZnNfZnN0YXRhdCsweDY3LzB4YTANCj4gICBfX2RvX3N5
c19uZXdmc3RhdGF0KzB4MjQvMHg2MA0KPiAgIGRvX3N5c2NhbGxfNjQrMHg2YS8weDIzMA0KPiAg
IGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gDQo+IFRoaXMgaXMg
cmVhY2hhYmxlIHdpdGggcmV1c2VkIGNhY2hlZCBuZWdhdGl2ZSBkZW50cmllcy4gIEEgQ2VwaCBs
b29rdXANCj4gb3IgYXRvbWljX29wZW4gY2FuIGJlIGhhbmRlZCBhIG5lZ2F0aXZlIGRlbnRyeSB0
aGF0IGlzIGFscmVhZHkgaGFzaGVkLA0KPiBhbmQgZnMvY2VwaC9kaXIuYyB0aGVuIGhpdHMgb25l
IG9mIHR3byBwYXRocyB0aGF0IGluY29ycmVjdGx5IGFzc3VtZQ0KPiAibmVnYXRpdmUiIGFsc28g
bWVhbnMgInVuaGFzaGVkIjoNCj4gDQo+ICAgLSBjZXBoX2ZpbmlzaF9sb29rdXAoKToNCj4gICAg
ICAgTURTIHJlcGx5IGlzIC1FTk9FTlQgd2l0aCBubyB0cmFjZQ0KPiAgICAgICAtPiBkX2FkZChk
ZW50cnksIE5VTEwpDQo+IA0KPiAgIC0gY2VwaF9sb29rdXAoKToNCj4gICAgICAgbG9jYWwgRU5P
RU5UIGZhc3QgcGF0aCBmb3IgYSBjb21wbGV0ZSBkaXJlY3Rvcnkgd2l0aCBzaGFyZWQgY2Fwcw0K
PiAgICAgICAtPiBkX2FkZChkZW50cnksIE5VTEwpDQo+IA0KPiBCb3RoIHBhdGhzIGNhbiB0aGVy
ZWZvcmUgcmUtYWRkIGFuIGFscmVhZHktaGFzaGVkIG5lZ2F0aXZlIGRlbnRyeS4NCj4gDQo+IENl
cGggYWxyZWFkeSB1c2VzIHRoZSBjb3JyZWN0IHBhdHRlcm4gZWxzZXdoZXJlOiBjZXBoX2ZpbGxf
dHJhY2UoKSBvbmx5DQo+IGNhbGxzIGRfYWRkKGRuLCBOVUxMKSBmb3IgYSBuZWdhdGl2ZSBudWxs
LWRlbnRyeSByZXBseSB3aGVuIGRfdW5oYXNoZWQoZG4pDQo+IGlzIHRydWUuDQo+IA0KPiBGaXgg
Ym90aCBmcy9jZXBoL2Rpci5jIHNpdGVzIHRoZSBzYW1lIHdheTogb25seSBjYWxsIGRfYWRkKCkg
Zm9yIGENCj4gbmVnYXRpdmUgZGVudHJ5IHdoZW4gaXQgaXMgYWN0dWFsbHkgdW5oYXNoZWQuICBJ
ZiB0aGUgbmVnYXRpdmUgZGVudHJ5DQo+IGlzIGFscmVhZHkgaGFzaGVkLCBsZWF2ZSBpdCBpbiBw
bGFjZSBhbmQgcmV1c2UgaXQgYXMtaXMuDQo+IA0KPiBUaGlzIHByZXNlcnZlcyB0aGUgZXhpc3Rp
bmcgYmVoYXZpb3IgZm9yIHVuaGFzaGVkIGRlbnRyaWVzIHdoaWxlDQo+IGF2b2lkaW5nIGRfaGFz
aCBsaXN0IGNvcnJ1cHRpb24gZm9yIHJldXNlZCBoYXNoZWQgbmVnYXRpdmVzLg0KPiANCj4gRml4
ZXM6IDI4MTdiMDAwYjAyYyAoImNlcGg6IGRpcmVjdG9yeSBvcGVyYXRpb25zIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1h
eC5rZWxsZXJtYW5uQGlvbm9zLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL2Rpci5jIHwgNiArKysr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMNCj4gaW5kZXgg
YmFjOWNmYjZiOTgyLi4yN2NlOWU1NWU5NDcgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMN
Cj4gKysrIGIvZnMvY2VwaC9kaXIuYw0KPiBAQCAtNzY5LDcgKzc2OSw4IEBAIHN0cnVjdCBkZW50
cnkgKmNlcGhfZmluaXNoX2xvb2t1cChzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVxLA0KPiAg
CQkJCWRfZHJvcChkZW50cnkpOw0KPiAgCQkJCWVyciA9IC1FTk9FTlQ7DQo+ICAJCQl9IGVsc2Ug
ew0KPiAtCQkJCWRfYWRkKGRlbnRyeSwgTlVMTCk7DQo+ICsJCQkJaWYgKGRfdW5oYXNoZWQoZGVu
dHJ5KSkNCj4gKwkJCQkJZF9hZGQoZGVudHJ5LCBOVUxMKTsNCj4gIAkJCX0NCj4gIAkJfQ0KPiAg
CX0NCj4gQEAgLTg0MCw3ICs4NDEsOCBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqY2VwaF9sb29r
dXAoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gIAkJCXNwaW5f
dW5sb2NrKCZjaS0+aV9jZXBoX2xvY2spOw0KPiAgCQkJZG91dGMoY2wsICIgZGlyICVsbHguJWxs
eCBjb21wbGV0ZSwgLUVOT0VOVFxuIiwNCj4gIAkJCSAgICAgIGNlcGhfdmlub3AoZGlyKSk7DQo+
IC0JCQlkX2FkZChkZW50cnksIE5VTEwpOw0KPiArCQkJaWYgKGRfdW5oYXNoZWQoZGVudHJ5KSkN
Cj4gKwkJCQlkX2FkZChkZW50cnksIE5VTEwpOw0KPiAgCQkJZGktPmxlYXNlX3NoYXJlZF9nZW4g
PSBhdG9taWNfcmVhZCgmY2ktPmlfc2hhcmVkX2dlbik7DQo+ICAJCQlyZXR1cm4gTlVMTDsNCj4g
IAkJfQ0KDQpNYWtlcyBzZW5zZS4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8
U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpMZXQgbWUgcnVuIHhmc3Rlc3RzIGZvciB0aGUgcGF0
Y2ggdG8gZG91YmxlIGNoZWNrIHRoYXQgZXZlcnl0aGluZyB3b3JrcyB3ZWxsLg0KDQpUaGFua3Ms
DQpTbGF2YS4NCg==

