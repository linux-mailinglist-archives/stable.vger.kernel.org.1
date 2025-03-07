Return-Path: <stable+bounces-121447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BAA57322
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 21:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584DA3B2F5B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B925742A;
	Fri,  7 Mar 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JDsM2qIM";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="y0X5NE09"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33623E23D;
	Fri,  7 Mar 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380914; cv=fail; b=uqdGzihhIwqhZofwvcAjlQGcSSpqgnEP7I64bI8R4dFKOwTwmF1Tr/qWY54376JcEScyjmyZ0Sf6JPHjAzkEpGMG3dF0VmhK/ZLauwquWlNlLfW7m4I9AWtG9ZgxpZ2qlg05f23zFCTT7W5Pg2Z3glHXe71p55VRfcWUODhkY9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380914; c=relaxed/simple;
	bh=9ehW+CPCeNYJJlIKpKyCi9ERoQmZKV6LRCV3hPaOIGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuLbqjD7g58yITpmd19vqf/1HzSpABamsQjtx86/dc+XPK4KyW/T8H0bvT5n4HCmvkh/I0/+74OGhfpG5hpStQ8PfyxHLeTD9vsUfS/SigFDXoRERgF9yl33LT9eiBS7+W3gcqdwc9veuvQGE/CdO4/CVlMWwq/SRWJNDGNvtWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JDsM2qIM; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=y0X5NE09; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527FepLu010494;
	Fri, 7 Mar 2025 12:54:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=9ehW+CPCeNYJJlIKpKyCi9ERoQmZKV6LRCV3hPaOI
	Gk=; b=JDsM2qIM+DtxiphfLTK1xiIu7YB7r4WViQw3/lYQqyaj9o2ZqxXE18eMZ
	cBpRXS/AsE0DhdJWx9fFQ6M7at86LmB6yNTqOH1O7dUGU8UoK4YBm7yhXxoB1W1i
	8rXDMn8RKeq6vzxDavSUAstPOg7IPiWV+3Sj70LwsDxFbWFpTs4G8Eell80VOEG/
	GAyVQCQIKdxaLlJHSOAqQ+99zOYPceavmcAsU1gdYqInVPlkBvocBft/3dXpQMTw
	x9iNGNtWrMqveu8te/Swc3xHfhB+Pw5NPgTuzlHrlc6NDN+0Wr9jyYPfIeYB3CEn
	lY4pJR1VWiOvpHL4wJk6kk2fEo/Zw==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.8])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 456kny7re1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 12:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/uDyoG9Za2Mo9ZuNEvS3ZiZHBL+SBym8Bb6IqsBEI1rFY1Q9M71o4cePTAnEOAkWaU5XfUBlcbN3MCxqcxwm1rxCsxwp+2j293y7gSlKOAdu82Z+RjmVKn8KSBxwRee51ug7S6rOt3gco8agAP1gqvYbKSExrK7P+psFN9YnLXARkNT8bMXRHH/1DYhOwRlYZ6UURXjnfbJRAZ3pg18RY/Z4ufsBjZV51NuvSRPTOQF0ciR8oJ4OZI6cz/8YGyhjbN3y6llnuP6+MP1SdFKYJ0zOgwnN0fRrBTn63Ay4CIT1HXgSLslk4VfbKT2Whc53w6fiqyjgeDyUoXDw16o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ehW+CPCeNYJJlIKpKyCi9ERoQmZKV6LRCV3hPaOIGk=;
 b=ptPebptV8dxKNb4++IAfqzzxwPgBEggPnE8cal4gS9M3BWfCWGG2ou8zzhQ6H388FcVzCCHcAIrt79wZW5T/EkCvKR0GgSDaUJiJFp8nH7DeGMZNhHQd086RD6+Nb1wvlszf+N/PZyDtGyf8DfmfPhhrmMyle6nJcRQCfnODT1zNjeq1npiGftYwk12VnE77Url1JMgctAX1bgk6jLHZruE5fCtVuc1plnTVh+/WbRZMtTXPVAr3kmyLUAMNbqEbwtTcFDmISfW15aZ12K94fUx0cgjREHP2yHQMbDezZB/cOCOquEjFp7JfTeN5pf5QTo86PE+e0D3AtNMB9X420g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ehW+CPCeNYJJlIKpKyCi9ERoQmZKV6LRCV3hPaOIGk=;
 b=y0X5NE09KZ0T8KZoqbUaUQvJuVEgWrA4o9sM2VMz58KwcmS9RtKw03LyG9OXpYmpQ1p/HnnHZwMHB0R5FCNjKkKSuBM28jc6CWZ+ivwZ126MXJQ+2izyK4IWdpXTzlCvYU92p72FQYcehhLiRDs43qOzMFISQ5Iv4elCK2UbzplVQltKM3r6tKsUaeEaRE2go9GyDUKYK9bhbTZPAq/UGknTDA+y1eyU0nf7DZ5yMYipuMmCoLFt3TQq1QuRcFc53N3+tVO7z8ZEmiOO7DWoH8TSfuL2y+Q0/Yc2rnOo9WoIu3GpGm+XzQHkvdkmyzEVPkmN31FkZ1RXbZmSOTqDxg==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by PH0PR02MB7143.namprd02.prod.outlook.com (2603:10b6:510:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 7 Mar
 2025 20:54:56 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:54:56 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jon Kohler <jon@nutanix.com>,
        Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru
	<rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Index:
 AQHbh7ASF98xRUPde0yBoaYiJ5HLYLNivLCAgABohoCAAA1zgIAAJnEAgAEOf4CAA89WgA==
Date: Fri, 7 Mar 2025 20:54:56 +0000
Message-ID: <0A8AB856-E7D0-4383-BC16-8029BC354C27@nutanix.com>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
 <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
 <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>
 <Z8gq6bWNPDtnUYsW@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z8gq6bWNPDtnUYsW@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|PH0PR02MB7143:EE_
x-ms-office365-filtering-correlation-id: b530adeb-62bc-4447-f7e5-08dd5dba5109
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU1EZnhVVEJTY2kxQUsxcHEzQUk4QTcvdzhtczNPWS9janh3VGszc1BMWkty?=
 =?utf-8?B?MEVjYkRiekwrNG5sQzE5MXl3QmtLaE1KYnlnTnhrcExtc1lZb0xHM002OHp4?=
 =?utf-8?B?dHN6REtYMitNMmNwV0lpZndmdlUwcWxJQnVnbmx5a01lc0FxQmVOY09HcmVm?=
 =?utf-8?B?NENrR08yNmlkaU1ULy9QTTVuSGg5SzF0R2ZlajNRd1lpQzRUT2tMazFpQjQz?=
 =?utf-8?B?N2w2ZktZbnp2K0NYUkM1aVhPVkJiNlBJZnNuekY5WXVlZnJhYzhha1IrdTha?=
 =?utf-8?B?SE1EdGJ6dUx3ZFJwL0g0cGxJb3d2OUVjK3NTZEJpZHhDeG1GNy9HVlc4SXJi?=
 =?utf-8?B?amFFMjByRmdoN1htOW9tcnlwdG5paXk5cG41UUNIdVhiUTV2Qjd0VWZVeGtO?=
 =?utf-8?B?SEg5VEdPaGVjajhxN3FhT1dPVE10Y2JhZkErM2JUZUp6Q0JLTjMwa2hyWTJE?=
 =?utf-8?B?ai9TVHdrMTBUM0lpZHc5ME5UOGlxYU5Fd09YLytzKzlZQjJOV0gwcDVlZEcw?=
 =?utf-8?B?a09hT2tLNVY3V2VEczdzczc0TEpFTkpQV2FsQm1xNlhQMXJsd0tNaHRVbThZ?=
 =?utf-8?B?akhYVGhqSXFoMkd1bzQxcWt1Sk0rZTB0dlE3TFlEb1M1eFRRT0NwYVlhdzJ1?=
 =?utf-8?B?OGJvNDZ5VVB3cGhRanYyUjhhblFPa1ZRYit4UW9zZlM4SS9DOFArM3dhTHYz?=
 =?utf-8?B?eGxtVXZpUFBieFNqSDJzWW96U0h1MnV4MkNWWVcrditraTJtTGwyRFJFN0hr?=
 =?utf-8?B?c3ROS2dMc0x5NjAwdHgwcTJIWXJoUHZQSllzd21UajVzcXhBK0RVNHBxNFVh?=
 =?utf-8?B?bTJQSzE3cUFJUmx4enpNbTJaOS8xbW9nNnNGODB6RGRHZmRQa1FsQXJ4T1U2?=
 =?utf-8?B?cGc3RkdtSkVJRys0UGRHTWc5K2JHNlEwRGp3M245NTRQL3lmd2JhY0dNU3Rx?=
 =?utf-8?B?MytGaGNzMy9IQWpVa2NOU1J0T3ZGdnJHdks1MXo0bzZuWHVZVTV4c05vUVNw?=
 =?utf-8?B?bklyRHlsRVQwMlFLM1p6WlRKTGlYZmtTVVF0Rnk1K2R1SnJKN3c5QmhLblZ6?=
 =?utf-8?B?d1ZKRHJZd01McWswelhtcUQ1eG9wTi9CTXZqYTcxWlJPeW43dTR2ZXhBYjI0?=
 =?utf-8?B?SCtZYXZESmt1QUpPV1JwekZIMEkybmthWi9VQUhqWDBRT3Z4cHA3cmhVZEF0?=
 =?utf-8?B?c1Q4MDJXMjdQTkdLQUF4RHRpRFNnVHJoZTJMSmd4cnV3MGdaWFhmVGRmRTB5?=
 =?utf-8?B?eEdjVURETkgybEcwbERoYTFtbU1weGVISGxoZ2FXTlptNlZvT0NQRDlLQWJW?=
 =?utf-8?B?Ulg2dHZDRG1CRjd0YVVuOXBBWXhoa1lLYWR5NnJrWWlRdTY3eHBSWVdjNldC?=
 =?utf-8?B?SnBWQWRVbHltQjRIaVFpdk4wK25OQ3lmc3J3cTl0Ymd2QWVqN3FvMEVxZlNZ?=
 =?utf-8?B?OWNCQk1BdzRvaTljd3F5ZXVJeTY4N0ZKb08yVVkrNkhKRDRVVGsrYUd4ajhV?=
 =?utf-8?B?dWNNWGNsaTFNNGd4OVhiWXc4cjZBVGlWOUJycjRqL2FUczhETnhBbEpZUWpB?=
 =?utf-8?B?Z3M3TU5ZbFl6UHBmbmlRVmtvYVRvcWR3bDU2RzBzeWdLYkRONnhwMlArSHlk?=
 =?utf-8?B?eXhmQjYzV2s5RThQQndQMWNNSGo3RGttem5EZ0RlaWFKc0VnOWJlNFhIdENk?=
 =?utf-8?B?a2RhZDFSNlNRcVl3MFV6cXlPNGxBQkN2WjNHeFNqQ2RGK25iVkNSa2JxZmFv?=
 =?utf-8?B?c3ZvZEg5NWtqMHp4L3VLWjkzSXo4Tm8zQmVUV3hXU3NzaUhQdmFWbm9aZWww?=
 =?utf-8?B?Z3ZqQzVLYlpTQm5waHY4aUtmdkhiYkJjYVdzSlhxNS82QTN4cjRKcFlXb2Zo?=
 =?utf-8?B?bkRDVEVEWk1EYjdrZEpxWmh2aCtScmVBajBzeEtJQ2VOVTVXd09uRXhnMDVz?=
 =?utf-8?Q?VvExQIiKLKCgiHErIeIDIgGeGBDUI2Z0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFRNNG5aUTNZWk5CNG9MK1EwUWdCcmx5WXdvVU5PaE1mbTc3R3lvbHlvZDdT?=
 =?utf-8?B?QVplVkZ3NTRXSDUxNVNsWmZtT3lNa2ZtZ0V1SDl3VzhobHgrN0R4SXV6ME4y?=
 =?utf-8?B?Z3duYi9NMkV0U3Z6N2RsWXVtajNRTnFlY3JVRHphTzVnY256K3VOeEE5YW5Q?=
 =?utf-8?B?Q3hVcHlRK1pBczVuOHR0VFljallibmtOK1BFaTk2RytXbHNUWTRlMThZWk5l?=
 =?utf-8?B?RGQ3WDNNcWJMSUlGdVVkVDh3YnhteHl2dVhFNWhxaW90N29SMUtpQmJqS0s1?=
 =?utf-8?B?VnZwTkpkWTRaeUlsckE0ek9DSGIrK0l0R1I4RzRzRTZpUnlaYTNqN2FqTk1w?=
 =?utf-8?B?WWsyMW54MFRSR0V3M2Y2SXFSODZQVk1XWnVKUThQSzg0cUdYakNrcDMyaHR1?=
 =?utf-8?B?YWUvejNGV25PdWdnSlE2cEM2MFdXKzJaN1BnM2xQTWpsVVB2aGV0cm0zOEhi?=
 =?utf-8?B?djF2eDQzdzNQWEhxbEZDeWtQaXBxQ1IxL2lMSmJFYmFqUUZQN24wZkRMT3Fy?=
 =?utf-8?B?SFpQU005bHFaMlN6MUlBTlkwZk1OSDdlTDZDdjlmUWM3dTBGamh1UjA5Q0E5?=
 =?utf-8?B?TWF1WUJjQUxsOEt6OThDYSsvdGN1NzMwdHZPNTN4L1BPaDVHM24wZVkvYlhW?=
 =?utf-8?B?NXFKa0pJSjRiYVljUTIvckpmKzYwanc5VkdtZ0FTSG8xM1gwUGZPS0hGTVNE?=
 =?utf-8?B?cjN3dU9qVElLSitYcUU5LzkvTDg2blFvZmZTd3JrQWpiYlVoMGt3VlZIR2tT?=
 =?utf-8?B?RWkyU01wQUJZUnMwWkNvMlFOK1dRWjRFSnBBZTY5SG9oRFkxSDRQbCs2OHRt?=
 =?utf-8?B?K244T3U5SGFZQm02ODFvdmZFbHZFTnFEM3dzb3ArK0NlYzN3WDgweG91YWVP?=
 =?utf-8?B?eUdjZC9XL2p6SkV6YVdEeVNveklzNDREdTNXVWlGa296N3o3Ky9hUDRETVVY?=
 =?utf-8?B?VzhlYzhPa1A3YTNuSWVQZDBObnJHcU1jUUlCVlNpN1pGYjU4bkdhSlhPVklG?=
 =?utf-8?B?RUs4dkVDUXhaejVFeHMvcEhhTDhvZlpneDlDcW1MYzRRck9BMG14V2trTDcw?=
 =?utf-8?B?YXhBZ0ZJL2hlWXVCaVVaazNnS09WVkJwckphWU1hVVlsUXN2ZFcwRG1yUGNJ?=
 =?utf-8?B?emNlQzB4eVBaU1RDTUlrc252MTJuVGpNT0UvQVpOSjZmeFlTOXQ4b1Q3eUFq?=
 =?utf-8?B?N2o0V2l5WDRtSW5pemU4OUg3anUwTWpyMVAyOVd4ZlVyQnNJQkUyNWtFK2Rh?=
 =?utf-8?B?SlIrMHkyYkYvWW9Sb2pqa0FldlJkamZIeHZKQXByTmN5ZUErVHVVOFdDSVBV?=
 =?utf-8?B?L09Pb2oyVno2YXQzOHh6dVlBc211cHhoOXc3NjB4Y2tBd2ZtMERwaGp5MTE4?=
 =?utf-8?B?aGw3Zm1zTlVIdExpY2lKQmJndnZaTHh6TDUvS1o4cUZ6MFJWdTlMUEFqN0ZY?=
 =?utf-8?B?QldJVUpONzk1Z0I3cEJjNVhOeEpZcDN3cDRTdU04dTVYUEhFYjcveFpBaG94?=
 =?utf-8?B?T1pvaDZUUkhVSUFGcGk4NlRVRkZCL3BmcVJtUWhydXMrRk1nMUpvRUNOMjZI?=
 =?utf-8?B?UDRRNmpISmk5QmF1V3ROQkcrNEpuWHJxSlRRc2ZNM21sSmMwVVZwVEhNakZK?=
 =?utf-8?B?dXJoeXJ6SWd5c0l6ZllYamRpaTR2Q3QvN3k3L2sxaDdLSS85ampsM0FRQWV0?=
 =?utf-8?B?VEN3alBWWTFJM2gyUTZObFNpanM3ZUY4Y1VIRGI2d3FUQlhsTW1jYndUakpq?=
 =?utf-8?B?ZDMvQXZaVkJzb0JyM1dFM1QzQXFFMEpVdVNWN3p1ZmpmWndNdVBaRCtFSG5i?=
 =?utf-8?B?YkhKQy9MZFh2K2FMYjE3OHlZOXIvbmd0THZ0WFJ1Y21PZ3hrMVpCNFVuQUVO?=
 =?utf-8?B?TFNKanRZNnV1Wm5NQlBjRjZwanNnMVVNQ0hKRTZXaHhmYURXamQ2dGVNdFVN?=
 =?utf-8?B?bnRNd3NWeHk0d21ENDZjMjhxSlhDTnpLT3A4UElOVko5QzVyV0c5ZEhyUFVZ?=
 =?utf-8?B?S2k4WVJrd05wK1F0MXYvVS9ra2VtQktnK1hpNXdQeHZtRE9yUDEvM0JyMUF0?=
 =?utf-8?B?Ylg2eloyb1hXNEZic2JpZVBGaEo5eVRLOU4rbEJNS0hLVHZmTXpKMUc1M0Fj?=
 =?utf-8?B?dTZCWmkyS0JsSjBSdFRwZlRKYWZSRDA4MmJVUmVMQ0s5dUN4Nnd5eERCTklS?=
 =?utf-8?Q?FLJJ05YEq4T7SOQo8YAeScX4p4ArWuPPXYbCElhjtdGz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <165A80BED0CFD645997D049E0D8D05CC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b530adeb-62bc-4447-f7e5-08dd5dba5109
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 20:54:56.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgjMluJYabbG9e1kiO/nwA6gPlLMI63FmcMMKTxh+bHqlWUgutY5m3reeWdX2rGITuJ9lRKpU/vRx8Im807zLHhRgxY/+EKwOruepKjNC+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7143
X-Proofpoint-GUID: qZiDh-gvpp9JYmutHYQ6XAgIEx9caZyv
X-Authority-Analysis: v=2.4 cv=cNYaskeN c=1 sm=1 tr=0 ts=67cb5d23 cx=c_pps a=Kq952KYlFoMAqHE57MuLQQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=bImBp4TAU2e0gPXC-gsA:9 a=QEXdDO2ut3YA:10 a=iFS0Xi_KNk6JYoBecTCZ:22
X-Proofpoint-ORIG-GUID: qZiDh-gvpp9JYmutHYQ6XAgIEx9caZyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDUsIDIwMjUsIGF0IDI6NDPigK9BTSwgSnVyaSBMZWxsaSA8anVyaS5sZWxs
aUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IA0KPj4gQW5vdGhlciBvbmUgaXMgZGxfdGFza19v
ZmZsaW5lX21pZ3JhdGlvbiB3aGljaCBnZXRzIHRoZSB0YXNrIGZyb20NCj4+IGRsX3Rhc2tfdGlt
ZXIgd2hpY2ggaW4gdHVybiBnZXRzIGl0IGZyb20gc2NoZWRfZGxfZW50aXR5Lg0KPj4gSSBoYXZl
buKAmXQgZ29uZSB0aHJvdWdoIHRoZSBkZWFkbGluZSBjb2RlIHRob3JvdWdobHkgYnV0IEkgdGhp
bmsgdGhpcyByYWNlDQo+PiBzaG91bGRu4oCZdCBleGlzdCBmb3IgdGhlIG9mZmxpbmUgdGFzayAo
Mm5kKSBjYXNlLiBJZiB0aGF0IGlzIHRydWUgdGhlbiB0aGUgZml4DQo+PiBjb3VsZCBiZSB0byBj
aGVjayBpbiBwdXNoX2RsX3Rhc2sgaWYgdGhlIHRhc2sgcmV0dXJuZWQgYnkgZmluZF9sb2NrX2xh
dGVyX3JxDQo+PiBpcyBzdGlsbCBhdCB0aGUgaGVhZCBvZiB0aGUgcXVldWUgb3Igbm90Lg0KPiAN
Cj4gSSBiZWxpZXZlIHRoYXQgd29uJ3Qgd29yayBhcyBkbF90YXNrX29mZmxpbmVfbWlncmF0aW9u
KCkgZ2V0cyBjYWxsZWQgaW4NCj4gY2FzZSB0aGUgcmVwbGVuaXNobWVudCB0aW1lciBmb3IgYSB0
YXNrIGZpcmVzICh0byB1bnRocm90dGxlIGl0KSBhbmQgaXQNCj4gZmluZHMgdGhlIG9sZCBycSB0
aGUgdGFzayB3YXMgcnVubmluZyBvbiBoYXMgYmVlbiBvZmZsaW5lZCBpbiB0aGUNCj4gbWVhbnRp
bWUuIFRoZSB0YXNrIGlzIHN0aWxsIHRocm90dGxlZCBhdCB0aGlzIHBvaW50IGFuZCBzbyBpdCBp
cyBub3QNCj4gZW5xdWV1ZWQgaW4gdGhlIGRsX3JxIG5vciBpbiB0aGUgcHVzaGFibGUgdGFzayBs
aXN0L3RyZWUsIHNvIHRoZSBjaGVjaw0KPiB5b3UgYXJlIGFkZGluZyB3b24ndCB3b3JrIEkgYW0g
YWZyYWlkLiBNYXliZSB3ZSBjYW4gdXNlIGRsX3NlLT5kbF90aHJvdHRsZWQNCj4gdG8gZGlmZmVy
ZW50aWF0ZSB0aGlzIGRpZmZlcmVudCBjYXNlLg0KPiANCg0KVGhhbmtzIEp1cmkuIEkgc2VudCB0
aGUgZml4IHBsZWFzZSB0YWtlIGEgbG9vazoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyNTAzMDcyMDQyNTUuNjA2NDAtMS1oYXJzaGl0QG51dGFuaXguY29tLw0KSW5zdGVhZCBvZiBj
aGFuZ2luZyBmaW5kX2xvY2tfbGF0ZXJfcnEsIEkgYWRkZWQgdGhlIGhhbmRsaW5nIGluIHRoZQ0K
Y2FsbGVyIGkuZS4gcHVzaF9kbF90YXNrIHNpbmNlIHRoYXTigJlzIHRoZSBvbmUgYWZmZWN0ZWQg
YnkgdGhlIHJhY2UuDQpJIHRoaW5rIHdlIGRvbuKAmXQgbmVlZCB0byBoYW5kbGUgdGhlIG90aGVy
IGNhc2UgYXQgYWxsDQphcyB0aGUgcmFjZSBpcyBub3QgYXBwbGljYWJsZSBmb3Igb2ZmbGluZSBt
aWdyYXRpb24gY2FzZS4gTGV0IG1lIGtub3cNCmlmIHRoaXMgc291bmRzIGZpbmUgb3IgaWYgSSBh
bSBtaXNzaW5nIHNvbWV0aGluZy4NCg0KUmVnYXJkcywNCkhhcnNoaXQNCg0K

