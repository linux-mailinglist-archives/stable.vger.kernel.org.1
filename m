Return-Path: <stable+bounces-244787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGG3FyIG/mnumAAAu9opvQ
	(envelope-from <stable+bounces-244787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 903014F8FC4
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEBB7301C8CB
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCA2F99BD;
	Fri,  8 May 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CXZYGH3c"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B62F8EB6;
	Fri,  8 May 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255210; cv=fail; b=paMFkjZIyRHkT6WFY67trXagkU68/bVbXfYIvJOp4eRs1yVWtBomOeAb05XYenIVLE/hrene+MDEh9kPMZh6wbFceahzChNxWV8y1lowLUfCzDII5rEEMURGgenmFYgqy0sfe+bkm964t4Fnt2Ag6+Yqnx/If2fuYhIPyYk5RTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255210; c=relaxed/simple;
	bh=WgKc1SSs+MP1eZaarU8pRJmoRhoTtnnfBekb/s2OFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cwm1c0Y9nYV/0q/yXqw3j1p2XxUpQAQjSX2uAPqfSCwA/b6vO8m4fK+LudY1DVDv4KMF5hsEQ9n17NmJWA/rXFPm7TPiT+S8HjyallD4w3wL/kJXuafJ3FqA25Vk5gJ3ysRdVnYX0DJJuXUcrnwpY6bahJNVuYFsRrDA64Jc8SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CXZYGH3c; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489hDO6330759;
	Fri, 8 May 2026 15:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=WgKc1SSs+MP1eZaarU8pRJmoRhoTtnnfBekb/s2OFEc=; b=
	CXZYGH3cZWq37znlQznp506828efpBNJdVgkJXZmk9GZ4qqzJ3G41PAKrzb2KfQE
	6XfhJiSKk1D4MILI5DSl456pwQdcNmpY2BdiEul9C0WfQC9WgclMQUVVe5xvkUnF
	X3GtHL2vJ2ZoUw6ea8TlOlMWp7dID7omy5qgLDpOzfSZuFmvyBy23Foyv30xFd3K
	ltj+pLgMgs5dI5tCri/LG18g3sYw9Hnxhqobv+bu5jKDiCRWxvbm2qAoiQDuUZDs
	ltbC0LmI7hOPiSz52j4gJ42QKM+3+mhv5srfL1RFsjbqzx3p4QFi86vzQQYoLrHx
	X+iwUPrux33j9O5u1l/Z7w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1cbvrerd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 15:46:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnwKscG8/bllhezls8tQ7IQD3o3rHI1ZGNIxkQ9Ff85+dBEdUX83lqPrEaIcFRCOs/CL0WTKRpLwKUdYEFhwGX50kOAYpQUnyjHBLrlEQWvdpcfWK4MI5qLqETeqw702ctjyUyMrx8LhVbvCwTN29IMuzj/Z65fIJGQtftMTAD2CIr8V/Cej+YC8cM4yKU/c77GUHZzQwLKf83Hd8tmCxx+WSAZ60dpdlsxrdNeVDyW0z77+9WjNCS7USoiJcoCYf6V8wicaKQusY8bC71XUEA+L7v8+NGc9i18IQy/ezo8BR8RG1h0UH0hnK/fQp2XeHYYLi0q1JxXrI73+b5sLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgKc1SSs+MP1eZaarU8pRJmoRhoTtnnfBekb/s2OFEc=;
 b=geKSM6eMvT3+q8wZiOqMbrIgzHYpkdyNxPYGHtRBOY8xhuKw6RmGgOXnJ3FZdxF918BTe7+FF/+zo/vM0IIcTWdC1vnx5Y8aNoWs3APufcvMcKYAvyVdHkzMOuTZ9Dumhb5T/JRS6SVr7c7ZJf3jIZkqdFEX9BAO7xUZS8eVE1SYajGF/SDXkf1LC9g+6wzuOTqiINpvtOFrBUOIRpn7U7+Ty07uWp5Vckp56p/+WJd5IJXzcVtDppZb/79jaNlheOyeUV1L28QZir7Xw5pkI635bhGFB/2OnI4iG2yflo72bLo260BfKmDjokxKVhc2L1f0XBhD7KmhpfcgavQedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 15:46:32 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:46:32 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: gregkh@linuxfoundation.org
Cc: ilpo.jarvinen@linux.intel.com, stable@vger.kernel.org,
        linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        ionut.nechita@windriver.com, chris.friesen@windriver.com
Subject: Re: [REQUEST] Backport 8250_dw BUSY deassert series to 6.12.y stable
Date: Fri,  8 May 2026 18:46:29 +0300
Message-ID: <20260508154629.530915-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508151614.498810-1-ionut.nechita@windriver.com>
References: <20260508151614.498810-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0305.eurprd07.prod.outlook.com
 (2603:10a6:800:130::33) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9797ca82-bc7c-4705-b896-08dead18fa49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	74HuMSl4W4Adn1ERcxdUR8hwHhC8ktKArvwlbQ6Glyt0ki4/0sENn0vmRSE7PjBJ0RC1lhOLfBJHUqyV7YgT2rOr0f67dvy4+Y7mW8xzhSrPvQdke3FV3kkoPvcMsWLRWIXw1vy8u7sLnGM0Any8zz4+xJYIoODTk57y2s3Pt0gEQtF8VWsATJcjKhMmNakhsjCuYDXsQGCZX4UyrqqecTFeEOkeNdQsI3TR3FrorSwHbH3Re7uZifhXtt0+3qGGyYKgZdufi6QeltoxRDdZs2CsNgq6jtAhoVWjTmdNh8xTHZOMBTdoAmExOfA4UJDMQkLTgz26rZCErcgpHcFpJ5b03baCaLV+zZNqtCxIYQ+Sa9Qp/KNzM8dfCZR1X11LaeTyBZ8rxpwbeKDl4gZXdWOjaVEClHJyXJ2jEbYDbSJa4BVqQac0bdYhWSZ1FaX4TMOTdDsX9/dVfHlfNL6JzNB5w3d1dxoFxs35dTJnNpS9pttP9kzOJKoX7Qmyyph2wMRHhKpY+9xxJKSJ3tdXasM4DZMUH3GpCqVBhTREdmzcbpATZkEZ9wYOeX518cLkeIdOEYyvXtYTDk+ZqD8At6JYahPedc3UvRe+iOCb0EcEYE3ed0KIcq01SD3WUFMgMBpPhc3xAF5FYQxQ7jIhyxhW45AYt+oRhKaFRoFFft5rTESLJcB+XnrGYUbko2TMo+5cXFfsct5GBb4z3cNdDdIVRSeOQRzQRKAu/rL+ve+iVN9orZKM6UZ+N3vmQTCH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW9pQ1ByYXBoQ0hPNUZTUUc3NzVRTUQzOVRpa1JCOGgzZ3dkSWc3cGRmQm9o?=
 =?utf-8?B?cnZ4RGh0WVRjZkd3eGEzYkhWYk5QcFRWbDBRTVZiWGRaeTdIeEozUGNSZUpu?=
 =?utf-8?B?KzZ4amxBVlJRaVZFc0h2YXRWWHQwTk9Jdy9DYjZMNTlldXZBNUk3cmJqMDk3?=
 =?utf-8?B?SVZlWU8yZHNUWGt4VDQraEplU1FwemVtK0lnZ1R2RzNIT2pqYVJSeCtYLy83?=
 =?utf-8?B?akdPeExha2JBVW1nd3pheXA2MFNHVUZ5U1JIR0UzaUlndkZaWlZUSlA4TkZa?=
 =?utf-8?B?VlpwUTZVZ1lXbHZzRTFRK1hObzM3VWQ2OVhFTmhJcHpINjE3THltQUJyTWd6?=
 =?utf-8?B?eUEzM3BIMlloc2ZBN0UxOXRUdk5NR3ZRek1ZN0hFUTJUUGZnbjFDWWhiN2cz?=
 =?utf-8?B?Y1FCRUhjT3gvN3dHRU1SbXlCcElwSkpoVjJ3bUd2V1d5RWd3WjgzWlNyUzg0?=
 =?utf-8?B?VngzUmxXalIvSjJNYXhlVXJERjdzVDZQWDR6dURnbUk0U0FDUXdPbDhDRmJE?=
 =?utf-8?B?MW9VN1ZBTmw0eFBlVVlPeWRvWFl2SDlJeE5wRlovblhRVjhRSlVFb3NiQysz?=
 =?utf-8?B?bDJkUmYxZE1vbVFnQXE4dER1bEpNWEtJekFOc0VqUDhlYjd2QlZIbVliZkhv?=
 =?utf-8?B?RTQzTm9EbnFLM21OK1E2aEszQkllUlBlTXlGamhqUW1uUXJ3OWZpTzVHOFpB?=
 =?utf-8?B?bmlQV0k4djc4OFpDNzZybTgvM3MwOTZSTENPYVRMT2NDVGZRaFkrSnRsd2RH?=
 =?utf-8?B?UnMxRDFWVm4wdjVMMzdSbmdWZXorblRmZVFrQUtnK0xvcGtFRFVaVHZWU2ZV?=
 =?utf-8?B?Y0xwNnBaaTRSMEVhQTFiTEprOFdBSUNSQ1BlN1VUOUQrMmhOZi9Ic29Xblpa?=
 =?utf-8?B?TlAveDg0Y0xYckJyQkJxS3pYWjRmS0NDOGtrbUFIVm5waDNsOUIzYkNNWUhK?=
 =?utf-8?B?cmprYkw0SFdMUnFGQjFhSDFwUk1zVUp1RWMxK1JqM3lLQjJvSHBZc25vRi90?=
 =?utf-8?B?R3VERWRHdzRKMUZZSWRDL3oxK0lzV1U3VHpsSTZmUUJBOWVXWXlVQXZ0ZElz?=
 =?utf-8?B?TW1ibGNnSEtqL1NML3VETU9xS3pneTNhVWFuUFpzS2doQzROZk5VeUIxeVhU?=
 =?utf-8?B?anNlL2wvc0pJWHJNeENpdnZxcmlqTm1scjJqNEVGaEdGbEZyRUNJNlNkeE5w?=
 =?utf-8?B?bHltaExQTXVXN0NFeXpiWVZaWktpaDQvZnlpVmgwdlVHMngwelBCSjd6SEEx?=
 =?utf-8?B?TUpMNDdWeGsydlBBYTl1SW5hU1VQa0ZNWXkweUl3RDNzSm9PbnBvNVVxRHU3?=
 =?utf-8?B?Q1V3MjA5STRYVy9yLzltdVUrTTlOWm9LMmNhTEZBOTA2YzZDZEFuOXhJTExt?=
 =?utf-8?B?U0JRR2J2aTZ6R1NjRUVsT2VTa2t0THdNZTVEclNJQTVPblBjRllyS28zTWJH?=
 =?utf-8?B?bGRLWElHZHRiaHI2QVJuRk4zcStxV3BIeXdNV0R3cExzZ3dRQzJRUldLYzNO?=
 =?utf-8?B?dWNOTWpoaXhhdXRIYW5UdG9UbytHdlllSEE0bkdrQ2NHb0ZGN2ZmeDBNRjZy?=
 =?utf-8?B?cEU5aStuK3RWS2V6R0F6bnRYZmZ4N0pja2hibTVvN25ROVVnMU4yR1h0MkVl?=
 =?utf-8?B?T1cxcUpha2FpT1l2QTVhYnlmL0N4cHZRbEp0UkN2ZldHeWdLT2VRLzRTOFRO?=
 =?utf-8?B?azJuczFnSW84Y3lKUVNadFJWWkpIU1RIbm1hSUpOc1B0OElPUC8zN0tzZHRO?=
 =?utf-8?B?bDFRRDczNWZLRC9uWUhPMGpSTEdXd3JEMmt4b3lXS21vdFlBS3RGc1hSTzNK?=
 =?utf-8?B?TDVZc2dQUzBZeGQ1M1V1dllZM0QxSFlCMWQ2ODJmL05LT09Tc3RXTHluT25T?=
 =?utf-8?B?bFlkYmNQSTJRbDJ5WEo5OU13VWxlVElvVGJObjVETzdQR2tWejBFMldDelVV?=
 =?utf-8?B?L2lSV1VuZHpEMldBMFpROG9RdWYvSHRVLzlVbzBNVitNZnZJSWVIaGV1cjQy?=
 =?utf-8?B?Vm92VHFpM0pCbXZTWm5lSEE0YVpxZkJNVTZNN0xCOUpHNUNtb3RySDRCMWV2?=
 =?utf-8?B?a0lRSWlvbVZvMHJFUWliRGlTbkpnQ3lWMlBoeEcwRVZZSFM0bUY2Z0NQYWtp?=
 =?utf-8?B?TFZHc3pXYjQzaGlsNFFTb2QwMkFiSCtnTjJMMmx5Q1IyNjdoblFpV2VrN2tu?=
 =?utf-8?B?TkhwZTNQeWd1bEVJVGkzY0QxaURXb01RNmNOUkJFanhuQWhwSmIyeVIyTjBW?=
 =?utf-8?B?TUFEU1BtUTNSY25MQitvQzJtMkZISitxUGwwNEJUWFFGbUZwRm0vYXIvUXQw?=
 =?utf-8?B?R3g1cHdpNDdFUHFoWEdKamJkbjF0KytWeERBdk9mVmtxWEVHOVdWNmRsUmJR?=
 =?utf-8?Q?YLYPgDiX9BcXg/eU=3D?=
X-Exchange-RoutingPolicyChecked:
	nIGfP2iPlXQVlUDR3q7qg8/q/V/5z3FpxEVAPQTeVcqOw0gZvLclfDLJxVjNHos4hSXCStbmQKuYdHRzva8xYCXOu8/XtSxUrcria6QpZUPBwwqPAKeESrJc8hopYpdzPzL4sBiBtyOS3eyQ/5pKeyRJFQigeFlWwo458h4Tciy+APYPrUTRhFUmc7srLgr77oKtcShQLjY/4Jc7ERo8W2s197roWIqIxFP8uIzH0RrxY+u88BP8b0karh8cvG/poPGc20OW5LftPzVlwRdGsN+TndiwhjntMuU2lhgeOSefDiLdTRRSZkIci2K5Fo9a9KgorcZA/N7XaFHJQtWLow==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9797ca82-bc7c-4705-b896-08dead18fa49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:46:32.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUeqwvXQIRwy2Uhpa1pQs/bHact8tk150q2aenvukI3FllGwIHrSjrFmb6wZvKsdQVu8OCfUnlxcu2m3gm7EXWMKqBxuTdAkcJwiOl6JxRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-Proofpoint-ORIG-GUID: c0xTQyl81zos05xzCjUTYICSFAOS6Vgm
X-Proofpoint-GUID: c0xTQyl81zos05xzCjUTYICSFAOS6Vgm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NiBTYWx0ZWRfX7089+twegDAp
 0jvNCQPFirRyXiVu75CXWjXLNuZ2ECAvRNO0lGjGl3UIlB7RKJvmWx/yHdDBrJVtxBmDue6BqWy
 s+iAcqeZigLdGry0q53NYZdwcw+jGBb8R0A8tI9xmRoaK640atRmlw9FfhG6cR8hrWYnkKbWdGe
 UzKddmOFUKqCI1DMWuPvr8yD1j4rFSKnFtn2rHKVwjwXE4ZfoQdtdH2ArdRwlke5x8Hhn6azkDu
 qIhSNDG9nBFGHFfNlCaPi6kgEiKQTMoVhe+jGvP3TemCUBVShIDYye+j1sHhjbob7nq+gippT8J
 zEMJ9RvqqMOtaqFl6vL1TrGiilNvN+4O4OrSwRPRsDp7K0B4lvZa32cS6AwsPwSBOwORGM/8AQg
 79kK9U3eyceeWA/27A1dEOJcmAmek/0iuoDfLTWnCwp+iMU5k1nRWEiYiXc5+g7AFjVFMpgSAji
 SOCTQfIyBmn88xEIKVQ==
X-Authority-Analysis: v=2.4 cv=U9iiy+ru c=1 sm=1 tr=0 ts=69fe055d cx=c_pps
 a=mkiEHwHV8KLcq3bIK/dapQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=ie98Qm6a0fxx8ZVdeqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080156
X-Rspamd-Queue-Id: 903014F8FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244787-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,windriver.com:mid,windriver.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Greg,

Fair question. We're shipping 6.12 as part of a certified platform
(StarlingX/Yocto) that is already deployed in production at customer
sites. A major kernel version bump requires a full re-qualification
cycle across the entire platform stack (RT latency validation,
out-of-tree driver compat, storage/networking regression testing),
which is a multi-month effort we cannot justify for a single
subsystem fix.

We are planning the move to a newer LTS for our next major release,
but for the current production branch 6.12 is what we're committed to.

Since patch 7/7 already carries Cc: stable, would it be possible to
pull in just the minimal dependencies needed to make it apply on
6.12.y? We're happy to do the backport work ourselves and submit it
for review if that helps — we just wanted to check with Ilpo first
on what the correct minimal subset would be before sending something
that might be wrong.

Thanks,
Ionut
---

