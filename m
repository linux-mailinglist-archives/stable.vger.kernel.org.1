Return-Path: <stable+bounces-75914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB0975D08
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C081F21761
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CF1ABEA0;
	Wed, 11 Sep 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZwrTr67p";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gPxUjKfW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bkcrKrYO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED61156962;
	Wed, 11 Sep 2024 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093198; cv=fail; b=l9HXgu1somkXV3saDfnH4L/9Lz3AORhpvQcbZq+2LR0+ZhGS2nIcnoPkuzeQWGndj58Osisp+Hwkf/Lw5m7HUk7lAAT2y/h4pc2loXivGIuysjDzsy1xLnp2Bh7Zh/mAtzu/raGc9MX6EQVrXHqAXv0fI7wq8iJE1Q8g/FIokd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093198; c=relaxed/simple;
	bh=EcLrj9lPwhTmm3MiaaBGX5Ls6b/Nwr0uAyDyEmxDBCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnGT/cEv6s5yyB34NSuSNB3+xJNm0gAqa9ny5gXxKz8hGHQLk6QkQBcyzIKG0nRLU6NvFLV2ZZP9dyj1rCRPsiufZ2Ry6shQ0feFnwSUnsOWD7uHdeoiqe6jKPiLdSMIYIgVF7sBOF/BPpqAA6FbN0DOYocT+tTtfQqqhEqpzPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZwrTr67p; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gPxUjKfW; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bkcrKrYO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BKcxlp031295;
	Wed, 11 Sep 2024 15:19:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=EcLrj9lPwhTmm3MiaaBGX5Ls6b/Nwr0uAyDyEmxDBCE=; b=
	ZwrTr67pkBqgFyWa8/HZnWAQdjRKGyP07odJCWzBu6Obi/CZBM2wPzK73uDrllQ6
	rY3z71QdxjbOMkw3Ft0GMJ9t49ME5FqaC2wxkaWeUeBubTVim7IHTfvbZ135bfNJ
	ggnIl7qk8hjb4c0mSDbDhPHHKV79OOM3CtWSY9J2JzlW1HMcBCOojsrnObH1dQBl
	q+tTm/3ZHAKBP5PpsSFm+dY89bWmO7tUypiqEQUbThzP1BhnDVz7HVMxfnDP6Qte
	k5zjrS/vf40AU+dk1KVjFDm67IXI5jpVhrkQ8DaUfVisPr6OyVSkPDV0T5BTtLF9
	5FVwGlj3o1j7T2i+YwnJmQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41gy8jxpyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726093185; bh=EcLrj9lPwhTmm3MiaaBGX5Ls6b/Nwr0uAyDyEmxDBCE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gPxUjKfWj7ueeE/fySkQSyYizMBqQiFcOtq7aolL9TLNTB78mrd5QbamgK8CcBxnV
	 1+NTIjW1uhhu/OoavPZ288wLamiE6Z88i7WLdO8NSOKRYEj+TTCVHYquOdjAB/nxRn
	 BSFtmK+NEbfvdS8Xc7PJthsMgQMBLd2bOt/8C/ZkZwJGeYffa1SROLpHnkpHpakweT
	 HZt/2JF7OMukPTUQ70l13aNcVHmY4zhPitczKT1IjMNZwEg1qOC7ePCIInwlLhzbi3
	 0nPU9bIqoq3B7OtPsEOr71MqxDSvA5smgJGrD3nTGdZCKhSPPo/7kh5hXgWJTD6UV9
	 mhsxjb0fiNCvA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E15ED40130;
	Wed, 11 Sep 2024 22:19:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8AB0AA00B9;
	Wed, 11 Sep 2024 22:19:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bkcrKrYO;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 13E5A40353;
	Wed, 11 Sep 2024 22:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyCiKi02yzCc3GiLNjU681kB6CSGal3i5lt2rasSMwITTO80xtNlQvQjKXUa+INab8J7Y83/i3JQ4TwGQnTr4QIdvMbweFSYC4CtthgdjcQ1qjoyxaaTrV8IyUB2VywTrF+yz0yT2ZYpt/Is+i4FYELkV/Xsb4uok8BuZvfXes0QKnylvO6KWinb28LDd0MccNbiYOjNaRrtDaxZ/ZzZhq9elJbDZbX8SH4t8viD+Qslg1G0dM0MNhexB9EkNp36FsWg1ia23gYDa5t3e3UlflMkGeVD+mxx568Ale+COB0CsdrlYHsqarNwgyMgb6oYjak2luz81bS+gNq4dr1sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcLrj9lPwhTmm3MiaaBGX5Ls6b/Nwr0uAyDyEmxDBCE=;
 b=WxnoF/cKq5sHmUKk3j33oSX1HRl+9BGlBhOM0vm7nbcn3raG0BOZo41A6dfqCGIkA8SkTv8FPYoUDoMq+7hW/JBtqN1dLLF7hUKDr/OPkXHYPbqdLxyQoPFyGB+X0aJ2Kv/FE3V7HmKI0NpSJnFJi+pRbSOcCVbbyfHisflGtvsTBGglU8r9tJL6lyWUuE8/i6i7tPvQPZsBrnZ0Q5SPHiSx0zLZchkg4u+amOebv8JkIKW67VTBPpvaxH+ALwpcY3wv6GUvwAj4grFxnZ93nDhqCt790jeH8XjtvVy6mWGpzF2rHCvdmmCi9fOUADqgWCeh5D77k/lQKA/bIpA8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcLrj9lPwhTmm3MiaaBGX5Ls6b/Nwr0uAyDyEmxDBCE=;
 b=bkcrKrYOkgIqwzewsIiHypoNIm8mKnRrO4+EupkJS2C24wW7Q1wYbSlPtYO3pb2QsBWsdHYR3nlcXr6cwsUqUKrlRdyEMxhsb9wR3RtLrjFRAjsI5xrrvZb+7OrmyVsbV08URzb/BdRRbfYcS+DpJsxrRltI8LiAbJCZXZ+X4iY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 22:19:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.017; Wed, 11 Sep 2024
 22:19:40 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Kyle Tso <kyletso@google.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "raychi@google.com" <raychi@google.com>,
        "badhri@google.com" <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Runtime get and put usb power_supply handle
Thread-Topic: [PATCH] usb: dwc3: Runtime get and put usb power_supply handle
Thread-Index: AQHa1mLvRzGckrXJrkSDd2dz93aZi7JS8ICAgACUF4A=
Date: Wed, 11 Sep 2024 22:19:40 +0000
Message-ID: <20240911221935.ghyfhwuzmezai6bv@synopsys.com>
References: <20240715025827.3092761-1-kyletso@google.com>
 <2024091114-armful-lure-1725@gregkh>
In-Reply-To: <2024091114-armful-lure-1725@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY5PR12MB6251:EE_
x-ms-office365-filtering-correlation-id: 138b2ac6-9fa9-44e3-8849-08dcd2afd451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THdQa1BUUmQ5OG8wUnNyRnNCQ3hwQU8yMFpOcU8yTURWOWUycytzMERCckJ0?=
 =?utf-8?B?VVQvU3FJVWd5d1ptbjc0V3lFam1UQzZJWkNtU2lkZ055ekpITlkwd09Eci9N?=
 =?utf-8?B?MmVkZjg4T1VkdUhKSURDUW1TME9uVEFuY0xXTnNualpVM3JxRGNWbjRDT3lV?=
 =?utf-8?B?NDA3WjdheDNHMWF4WTV6SE5ESkRPeHZaT0VUaTB4dlVRaXZHZUZnTW9PanRB?=
 =?utf-8?B?bTRPUTJNYU9teEtLSFEveWdudHcxd3VCVjhqa2hBUEJJM2xhM1NhZ3JlRWtV?=
 =?utf-8?B?WHgyYmEyazVGaEZnMk43d2Y3djIzZUl2UFY3dklnVnlucTFIVXBVQ3ltbUo5?=
 =?utf-8?B?aFVtVCtPVXhQcHVOd09FZVNhd1dGNGZtYklNTFZnZVM5MHArVkptN2UwYWZh?=
 =?utf-8?B?M0pMMDRnZFJ1Z0ZmdnlzSlVhckRENENNNDZRZy9sbUVQQ1g4K0FKRjAva1V1?=
 =?utf-8?B?eVB5dDJVbXhyQnpnY3QxOURXS3lPUEVTeWZZRnBEeEUwNEVLRFNUZkdPYjUv?=
 =?utf-8?B?K0tObjdFY202OE5kZkNOSEd5SmdjTHZaOC9JSEp0WUtIWEZoNm5UTUdCZUxi?=
 =?utf-8?B?ZmhuZWUvd0JsZXUvNzRpMzFvd0d1b0E1QkgySE5WbjlwTXBhbFJDL2hCcGhT?=
 =?utf-8?B?R3R1S3BJbVJsSE96eTM5Wnh2RjVuZlpyMUJJTHVySXhMaGxCWlVmaUNnYjZn?=
 =?utf-8?B?dWNkRU1oODRDVmI5c3FpdkhTQjZHWS9IUmVHZ00zbmZCTEF4ZzhweDlWUmtB?=
 =?utf-8?B?aVBHZkpkV3EwUDFzTHVIdnVmSDFCc29ybDUrU2dBY3VXc2dnZVBOS0hRVzRT?=
 =?utf-8?B?VFI1d2ttMHRJTTFJNjhwZU9ObmFOVzVmbFlaS095L2xwcDVSY3RNL09Cc1lq?=
 =?utf-8?B?c1dpOGJVTVB4ZjYxMnFYdVFUL1Z3TDlRMm1sY3JmVDcwZUp3U2ZacHoxeWIr?=
 =?utf-8?B?RlFXaFJaVmUwSHJPNVBIN2VjS0lxY2lORE4yWnp5cVFaQTdwSFIzYVcybkpx?=
 =?utf-8?B?Y25oNDZ2aTYyeERMTUMwMG95djdUMGh2K21tRzd1YS9xZ3ZhVlhoK3dDNUhQ?=
 =?utf-8?B?a1g2aDJCSDhwVzBXRmR5UStrVTdkMXpVZFI1SlZVNnNtcms0Rzh6amlVb0VD?=
 =?utf-8?B?RVBKM1BzVmdockFMWFFKdm03MFNnMDBOc0o0OElTZ08zK0YwaG5ScXhSQlBU?=
 =?utf-8?B?K1oyejNBalRBaXdCMFBrM2lvVU9UL09wYSs3VWhwVWZjOFZkejFkVUpXanI1?=
 =?utf-8?B?Q08rZThmVTJaRStnZS9iTFY2bnZwSTNibjlFc2tkOVJ3VDJvZWJweGdyR2ZQ?=
 =?utf-8?B?L2djRk5pTXhKVS8wNzl3alcvT1hIWitld0huZDM4MTU4WHJFV1haQ2NhTVcz?=
 =?utf-8?B?aUNZVkpCMHFIaGJIN2VpZUorK3U2TkZ2WjhOWFMyeGdUN2hEVWM2Yld5Y3hX?=
 =?utf-8?B?SGhIbUhhT2VZSkRnWEJFcmp3eC9SYUFEOW1KUzYwclhBRUFPVzdQak14bE9B?=
 =?utf-8?B?QVZNQ2s3N1JkTlJFU0pmVVRac09FUFRZM3ZhOHc0d1VTbllvYTFtc3U4Mmlo?=
 =?utf-8?B?bnM3SFpadi9WS0NVNjd5cTFHY2RTd1lJaUVITjFxT2RXblBPUEJGZ0xCdXJB?=
 =?utf-8?B?TVlyTnVqa0ZER0IvMlFucUNzTm9xQlBFQ0NRMkdVSFVhandRNDN5cW9VWTVY?=
 =?utf-8?B?OXVkQlIzSGpoMUlKeXlnRU1HRG91djFicm56cFNwZTlUbnFUSHlOZ1VQZTNU?=
 =?utf-8?B?dUwwWFVCM3VJQVZLNVFmTTh3bFhjZXVGaHdWanNaWkNHb1ZSK0tUYjY1QXA5?=
 =?utf-8?B?dWh2NU5STlo3WmhEeG5aWEZEeHRJTUl1TVVuNGxmRGttcTF0WlhvQXNTb0tL?=
 =?utf-8?B?SDhPb2h4OElpdXBPM2pabjdGR3M1WFlFK3VXTnl1TXBCV1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjZkaXRSUFc2c2M3Y3U1TldrWDltV2hKUEFmTlp2Z0JXamlUNi9DOENVUFU2?=
 =?utf-8?B?K1NDTFJWYURFNjFYY2ZuTUZPVzF6UFgrMHBpRnFEZmJZc0xGbGZESGFkdCtx?=
 =?utf-8?B?TDhuNnNYYWZyYllRM3dnTUFVeVNXWGtmVm5qR3dLMmplQjliQkdncGZDclo0?=
 =?utf-8?B?SEpJTXdpYXVVMmRzYzVyaklvbng4WUt3S3JZWW1ESGVKZG5YU3Bwd1ZCcFly?=
 =?utf-8?B?S2Q2YTNpL1R4eDA2YnJTemNOWklWWVRUVnJVSVNuTWgxTjJVWmJ4aG1ZWW5Q?=
 =?utf-8?B?SWI1NFdwejMzSkxPUGh4ZUlqcExWMXI4T3hOMFhtb0YxK0RmenNicVdEcWtT?=
 =?utf-8?B?UnFJU0RVcGZ0QU9ha3JCbEVSK0c5M2pMazdiSVJWdE10YUN5d3dkS05oZm1V?=
 =?utf-8?B?N0NYY0hPbXJQcWlyQWlOZlordis1QllJdVlWYzUyQi80anR2Zm9aVUhRUitn?=
 =?utf-8?B?UXNsd1ZYUDIrSzhPdjlvTldaK2tzQkszOTF1b0NaN21PMlJ4QnlMUTNwdGpa?=
 =?utf-8?B?a3gyRStRWUh0dXc0Q3BjclFRSEVIU2Q5T0FxZ1BxOFFhN2xDS0RKbTRJQlVp?=
 =?utf-8?B?OFlackdGVDg4TEpjRE1TSnRZMk5QVUZ5ZW13VnBsejR6UDU2Z1RLMnhyV1Fx?=
 =?utf-8?B?MFVVSURhQWNvMnNLZ2RKUEcxQ3lNUDZPS0FpYUhCQXZBOWNxQ3ZEdE5oNFcr?=
 =?utf-8?B?WjM0cGlsOTNqSDNpZEdJUmJLdzNNSzJnb2k5U0RBWXV2ZWhhWUtkZ3hlZVpi?=
 =?utf-8?B?djRJU3NFOWxtME96R1ZDY3RNNUtLV2M0S2NvclBrRk02YjdIR3RUUk5Gd0Z6?=
 =?utf-8?B?ZFNZUDdsWTBFUjA2dm1LVFFKMzlSTllYdng1QmxYUFFCSG9kbjJZcGN2RXJX?=
 =?utf-8?B?Ylh5KzBpRTh3L3pVUjE1c0Z4QWhBWHN5czgvbVJXdHY1c3V6bTFnK0JpRzRk?=
 =?utf-8?B?UE90SlFXeHQzeWRXdCtOUkVXbFd1TnVnUjNHc1YrTFdydFl3M0lYZzhZOG5t?=
 =?utf-8?B?Rm44L1A4aUlQR1RhMXRKTnd5eWlIcDFZMTR1QllSbCtUR1JsSkdFMUNYVC9G?=
 =?utf-8?B?NER2MTdRcnptT0ZkVWFFQUpWUHluVGJPVXJIMHltYXFMMm4rZUNtL1Q0M3g5?=
 =?utf-8?B?dzRPVFNNMFY2TjRmOFBqMWlIYVNOc21TblBCbDEzTENzdDZaRURoQnJKRGoz?=
 =?utf-8?B?L2draytjOGNXVWZIMG1od2ZydWNhWUpnaUNjRzNwTHEwNDRvZWJvamFIOEQv?=
 =?utf-8?B?SFB2MEh3c3B4RWtOeG1FMmIyY1NMQzRvWmg5VVNKYklhWTlkL1BJSUJPZVZ1?=
 =?utf-8?B?T3JpZlh2M0tWVjVsZGtCM1VqZ205VldtMkJsbGg5N1lqNHB2L1ZlUi9lcEdP?=
 =?utf-8?B?WkhyVzhNZm0yWHJEY1dTdm5wcm5FbC9JcWlrUWZBMlgvcmtiZlltT2tFeStK?=
 =?utf-8?B?SEVLdjB1cGd3Y3E2cUxVS2c5K3hKR1ZhUklUWlFnS0d3OTF4TVU2QWRzU2JP?=
 =?utf-8?B?YTZRZTVaMVhGNkxBNUlteFREaCsxNjQrYXZJb3FXWWNSOHFVWGxXNU04S2JZ?=
 =?utf-8?B?ampyUWdMaGJ1UUlBQjhVZGNGUjdTbmZoQmdaZ1VjUjltRy9yTzlHZDl4T2l6?=
 =?utf-8?B?QW9zQTFId00wSTJVRVBkMG5HQldZZVNmdlZMOHpIWUw5TkJjeEUzQndVWTdC?=
 =?utf-8?B?ckh0UWZQSzYwYk9oNGlma0NmRHVwZ3JYV1c4VEF1UHZwOERmdmR0MUsyc1BK?=
 =?utf-8?B?OFprampyM3VMOVlLRzBSWkREN0tZdEN6WHVUT1c1RXJCZGlUcG5yUTlqVTBQ?=
 =?utf-8?B?bE9OOXM1ZWFDV0RRdnBxUEk3S1dQUGxFQVYyd0c1Nk1QWFJmSmh4dU9BeDhp?=
 =?utf-8?B?VWxZSHJQYlBlRzhFUnQzd2VGcFZjSFFnclBiRFhFLzJMM3FHVHFzdzJMSDBn?=
 =?utf-8?B?UXI1S3BLRW9YTWVoWlRXWlA4N2FIaVdFM25hRHBKcjFzZHlnRjNIc3V1VGxN?=
 =?utf-8?B?SmJSOE12N0IycWo0Q3FmempaUW5xb2I0Y0VkUUNZWW50a1BFZkZNQi9qRnc1?=
 =?utf-8?B?TTZmcFVndS9aMmxmL0c4Z3ZkaHo4aExDTUtlbFpTcnF6cnBTckJDcGtOMDI2?=
 =?utf-8?Q?tOnVbcT/sPyqcHLykgScziMiP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2B6C6367AFF942A8C56C256F7B5286@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YGj8pKQO+wVSz1Nk+9STGk2QafuUeadesYTrT39/TmaRaUMGV8n1lrag4GYPHAdiuLSsKLecH3GbqEtYEXxXPRClqNKaLSmlIDv8To/CnOsURsRHx36f3QTFlAnN1yASrGbBGlMJDbKA7YuEZFOnZK0pDi2dUqJ2jV2amXEE8N87Ne3sZYxd9eOqdzsWG+lg0VgGAtAG8NEyJRde6wtuFf36g1csxz2EJtXKDF5dpTpLXrObqtBiIceDqlu/234yMRc3iM/XLdXxpG3MyV9aJsoYQNbx7dHsG1fN9VDGl6uWtp42kCgkrVgJRGvVWnG19H9E3qRPqOGYqWORITKm1tH+GsAzh1Lp0QO1veL4XVRYg6ZiaKBCFj/RA6SWFvxS/GT0niWCCpx1LGQBhCTFgLFpjDSpiH76FOk8bkEJA+sLZfuHXf/3Tluu+B27C7brv0dAgRhZsz+695oz6OSkXRafX9cwM0wQAenRfsy/lVxW9pLjLGarD5+OmvmA+jKkYQwq/RB9vjoGAt8sLp7wEGVxM0TyvVsoUbmeZhEhgN2b18Krv6OiTOKphAz+fPetbViJqr4ClT1Q3w/TqrPrwGwQDYJN6EsZGiZUIfW3eL9s5i/mum1sNlLSbkEuezdyR5hoTEyO2Sx88NPWAQJuKg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138b2ac6-9fa9-44e3-8849-08dcd2afd451
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 22:19:40.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOfvM6ZPpnpDcUCB3bC6fea6rl0I/bmm0OreznkfYKJjWGCA8k9TyOGgiKYTCalt29OE/gvHzbUe9G62i1areg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
X-Authority-Analysis: v=2.4 cv=cLmysUeN c=1 sm=1 tr=0 ts=66e21781 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=WvqdszzM0HORBBnp898A:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: PaSCtYqwblJGYeGcUqxhGedRTxUB9PDW
X-Proofpoint-GUID: PaSCtYqwblJGYeGcUqxhGedRTxUB9PDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=564 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110169

SGkgR3JlZywNCg0KT24gV2VkLCBTZXAgMTEsIDIwMjQsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIE1v
biwgSnVsIDE1LCAyMDI0IGF0IDEwOjU4OjI3QU0gKzA4MDAsIEt5bGUgVHNvIHdyb3RlOg0KPiA+
IEl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIHVzYiBwb3dlcl9zdXBwbHkgaXMgcmVnaXN0ZXJlZCBh
ZnRlciB0aGUgcHJvYmUNCj4gPiBvZiBkd2MzLiBJbiB0aGlzIGNhc2UsIHRyeWluZyB0byBnZXQg
dGhlIHVzYiBwb3dlcl9zdXBwbHkgZHVyaW5nIHRoZQ0KPiA+IHByb2JlIHdpbGwgZmFpbCBhbmQg
dGhlcmUgaXMgbm8gY2hhbmNlIHRvIHRyeSBhZ2Fpbi4gQWxzbyB0aGUgdXNiDQo+ID4gcG93ZXJf
c3VwcGx5IG1pZ2h0IGJlIHVucmVnaXN0ZXJlZCBhdCBhbnl0aW1lIHNvIHRoYXQgdGhlIGhhbmRs
ZSBvZiBpdA0KPiA+IGluIGR3YzMgd291bGQgYmVjb21lIGludmFsaWQuIFRvIGZpeCB0aGlzLCBn
ZXQgdGhlIGhhbmRsZSByaWdodCBiZWZvcmUNCj4gPiBjYWxsaW5nIHRvIHBvd2VyX3N1cHBseSBm
dW5jdGlvbnMgYW5kIHB1dCBpdCBhZnRlcndhcmQuDQo+ID4gDQo+ID4gRml4ZXM6IDZmMDc2NGI1
YWRlYSAoInVzYjogZHdjMzogYWRkIGEgcG93ZXIgc3VwcGx5IGZvciBjdXJyZW50IGNvbnRyb2wi
KQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogS3ls
ZSBUc28gPGt5bGV0c29AZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgICB8IDI1ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggICB8ICA0ICsrLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IERpZCB0aGlzIGdldCBsb3N0IHNvbWV3
aGVyZT8gIFlvdSBtaWdodCBuZWVkIHRvIHJlc2VuZCBpdCBub3cgdGhhdCBUaGluaA0KPiBpcyBi
YWNrIGZyb20gdmFjYXRpb24uDQo+IA0KDQpZb3UncmUgbG9va2luZyBhdCB0aGUgb3V0ZGF0ZWQg
cGF0Y2guIEhlcmUncyB3aGVyZSB3ZSBsZWZ0IG9mZiBmcm9tIHRoZQ0KbGFzdCBkaXNjdXNzaW9u
IG9uIHYzIG9mIHRoaXM6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0
MDgxMDAwNTYzNC42aWcyZTNoZHNneDN3a2FuQHN5bm9wc3lzLmNvbS8jdA0KDQpCUiwNClRoaW5o

