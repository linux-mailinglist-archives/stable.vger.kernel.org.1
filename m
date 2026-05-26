Return-Path: <stable+bounces-254273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMhgCrZWFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:15:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB25D2512
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B61F3036EC7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FED3CDBC4;
	Tue, 26 May 2026 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="WNS7q74q";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="PI3Fd6mB"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812213C8C7F;
	Tue, 26 May 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783315; cv=fail; b=CnaAuiYoNkrLEpfkRFPJDiHUUfo1unvLMsOiCG9TYhyO9ZBZRdLbjO6s1O9Xo2ctPomwYpE2z11rz0p0b6O8MilNXRGiLmupZfdsgS3q5LbT0vivq5JEWYJRKERbNL4lHgIDBi5GUVDD8b74Qa8K4TA6MBbGsNhHmuD/3hg8jMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783315; c=relaxed/simple;
	bh=5i1ATSf/f5Q/qyesn1nx1V0NsUqR9JY5e0aJEZs//Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mv9nHwF/hAIv7IdMU3WyBRKrXLbP6jTQaFdELFXGGpXU0sy/tcphxuGyln1kqsEc1TpQKjOIAh6E5ydd6XCJ4fCAuyeEhd1P+GwUCxKxBLi77zG95TII1EAFVqSF7a87m/Y7usWkLoFzRjsXwItGkwUVBFH8iuN31WdtbX3cM/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=WNS7q74q; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=PI3Fd6mB; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q5U2bO1358694;
	Tue, 26 May 2026 09:15:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=5i1ATSf/f5Q/qyesn1nx1V0NsUqR9JY5e0aJEZs//Ws=; b=WNS
	7q74qTTl7luYpiz8oMHLkbDmgYIJzCSkI+OvEfO010KyqJCf/tWzhKaiOGVnZD3d
	ezDX+YWXNx/lZDXix/7TJdRvVBF1+pqlX+/cf1czVZKmnZQCz3Wd11Ge+dYfJTbe
	MZDv+WRnVHKsF7Joo4V5LHiTEqYAelPZuoR1bt83S+UgjMlTZZzPMWp5jVokJKgi
	8bHXQXJp0J6yCfqu3TdQJ8mZv3OR2WwPrdz2Jq31VoFmjw1fD7zmAwQ+zhd8WPb9
	Q4gw46Jvy0VM4T7rdPT4IgXJ75NxcSbFtEknYOAtxRnpOUdzzRwFtDCq9+ZL5muH
	X/iHElzvFV/gR1JFXjw==
Received: from cwxp265cu010.outbound.protection.outlook.com (mail-ukwestazon11022098.outbound.protection.outlook.com [52.101.101.98])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4eb2gpj3e0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:15:00 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsgPtRh27uOAwpLj7ioOI8x72uASqPIMj14iThua7D6/PZjY72Kl9nQbLNVp9oT/3HGHh3sA1nmlGezcxm+1nzZ1ZBICtBP6TFbtqTJ3q489RgA3hZbjTa8e89H7p+9cLaSUpu6AXMdxOUuuQerVNmi1kWChPgmgo+MLvvHkmQCj90TDFkjrOyOok0qkwFQqRJSWZCWRLDkP8wFVskrzo0ck4hHR908OtgeVnm16wU7elQBLOPlBSuN+pBQnAPFI5DCG1MDw2Q0+wCbywZzLwA8fQO0Cz/R1h14Xri2yyZo0Q/sGiKKKueoww21nTq3F5lXdHCzmJlOwFsJAza4pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i1ATSf/f5Q/qyesn1nx1V0NsUqR9JY5e0aJEZs//Ws=;
 b=RdaUxB30+0zOI+AoI4tav6Zx+BrgVoL0iSU+GkUkdQtrfU7mQ6VnXXiIEM4ecZ8Ru4cYUtwb6wuvtotVv/r+D98OB8BFgSnxmXF1HIjqQ7RXoMbhMQWdOvyEsBW8AJMjmnLyK3xTMh3yWG18Df0219PaO4rQ1cDstE8ADkXq+pPxgcfAT2OSSajtDW8PcGmRDNhjoUn3h7aqXhhjga1WIDygFbHl5/niLis2Q0ev7SqUyhGDLFYzj2xYjON7VPlceocSCBwdP+0vfiZYdj8ATqtQtCNqd5UHw2u5AsjwFrgoUqCpP0pQ4uS7haYB+6+cS2AohvUvV7q/qb4WY4hcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i1ATSf/f5Q/qyesn1nx1V0NsUqR9JY5e0aJEZs//Ws=;
 b=PI3Fd6mBRpnRZBV40Gm54tHpMqfM583dHdloPjdwRzotnlrKuMPwZDo8lZQC5laoMBc7gdSFBq+1SIOVPSJ2DwO4FZ4W4w/N6/ZzUzGzXYLRJwZsV/ar4wLGhQgcfcnede87cw5WChjCexvETVK3l8CMUF7GqPVvGDrYFOeTYqc=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB1636.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:14:58 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:14:58 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "simona@ffwll.ch"
	<simona@ffwll.ch>,
        Matt Coster <Matt.Coster@imgtec.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before
 suspending the GPU
Thread-Topic: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before
 suspending the GPU
Thread-Index: AQHc6e0QbSSpjtoFoEiI2QvzQN4c5rYdGHwAgALjJIA=
Date: Tue, 26 May 2026 08:14:58 +0000
Message-ID: <08d2dcf562adb5dcc2153dbbb97dbdf16dfdbc84.camel@imgtec.com>
References: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
	 <20260524-stable-item014-reply@kernel.org>
In-Reply-To: <20260524-stable-item014-reply@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB1636:EE_
x-ms-office365-filtering-correlation-id: ed22cf8d-70f3-40fc-cecb-08debafee062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|4143699003|6133799003|18002099003|22082099003|56012099003|3023799007;
x-microsoft-antispam-message-info:
 X+mRzGagWH4Zfq32Rxh7mUQ5CPDotzhzqb3SXILrHpwDX6Iwuo+6411cv2uLG1WlugymIZviXWq2fVAH046hIpctNmldZKTTfyg2w0MdXlOR36B3oVWs3mx0nD7tEclOZ/hA2f+shZRZd4sA4/fO7qxFgL5BQ+G46L0j8nStbV+VlUSjlcT4iTKwabN2E2x+uAv04qxx9X4ay6SuzvqFz3uetcy30QdpxWcahK0vgKeIuUITpSYZzv2kuTj0ai+G+fU4odIpZaGBnEvyoKAlpMcgNh7bMY/fNgixPlbHHxDMrgOhooI10N7RSURD4sQCz8DUmKvH9SyU2rGKQfrnliI6WWbXUrbso22xWlck4jC8Iso+ZmE9zrXeTfZmQtowiVgh3k5sr3sJlC54X70X2SoySbNrTGBT1a9MHTOpPhm/yUUquW9y5E8SH9W4PUl8iXWk0HE4cYZxayFLM+ukMfHwQZDQS92uuudrqFFdwd+RgDUM6LTF2sXRAQ3dp92u4tjeuKbCIxEpmaNYebXOuIM9m9PgU7eFZDy7UQ+Xo20CehBg8AP5HgD9PB5l5CLXLDJo1oF0Phrl6beMEsEtnPBQog1sTp3CzRe/fTLTNY4AEFGzMUhtg9PTT9m58BXDu2iG338onwNVEHjhZx2KmvNH7q7P33ekTvkN2viZ0m4YHQGairgMAbRUBkc5vN+ZMJXz2KV9JnrDCYtjXrQe+A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(4143699003)(6133799003)(18002099003)(22082099003)(56012099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alN2WDJnMkNSNUV0eUEzTnZPVFAvK3Q1cm5lY3pNRFFFYXpMUXkzN05uRkI0?=
 =?utf-8?B?OFZKTTlpL1NZeXpTVkFEcXR3MnJwbXNkMU0wMlJ6SE5LOG02TFB6NE1mWnlK?=
 =?utf-8?B?NmVSYUFBWjlQWXA3THV4SVlwVWVhNFlpWkRvemx6UkVtRmY5V3c0UmZYUFNn?=
 =?utf-8?B?bmhWaUljVHY5YitkdXlMbkxyNTJNTHBOUlFIVm9ZV1JwQmxiZis1cHpVKyt6?=
 =?utf-8?B?MmZHNHoyT0pSc3ZVSjYzT0s4WEZYbWcxazU0R1REYVVrNkFXdURXRUVHV1Q3?=
 =?utf-8?B?YUdxclhZRmRIMUdLajVwaUVUREV4ZFJ1YnBsZHlFb05VWmNKek91bTdPWFpi?=
 =?utf-8?B?eFg2WnltSE0rc3hxV2FWdmNpeHRFaWJtYmlZL0kzRGFKcE0rUHlqU2RFQ1Zv?=
 =?utf-8?B?RjFqTGN1UXdVRE80YmpxL0VleUZvMk1RNHNENkN2RnFxSW9TL2VCejVBS09o?=
 =?utf-8?B?TGRhRiszSEpNbDBCcm41MWNXTFo4NzNVc09jOTVlcmFjd0JjWTlPb05DbHJY?=
 =?utf-8?B?QXQxVHZEc2p4YUY5My9BVWhlR2k1U3lmaSt0anh2Qjd5T3hsLzJ6YkpheDAv?=
 =?utf-8?B?aEMxRytFV0kzVFFYWGs5M3EyK0w1VitRTXhjdkVLdUordEk1M1RxTGcwLzNa?=
 =?utf-8?B?ZXZwYVhjSERYbFROK0IwcVVBZVFJZEgweXJDU1RkeW9LTCtuVmQ2MWtOM2dC?=
 =?utf-8?B?bDVsYUtkRm5sREZXSXdXSWllU2Z3alVCOTd0ZVNVeUpGdjErSGZ4QzFIaDRS?=
 =?utf-8?B?cVE3UGdodGZxUE1qZlF2Q1dWYXVySWZoRFJlTC9zdnZPS0ZRQlBPRGRiWFRu?=
 =?utf-8?B?Slk4VjVFVHhBa1pnUXlEV0Y2aVRVUHZ6ZHNZQjlMc3JMNjdrbTZlN0hqaDBL?=
 =?utf-8?B?dzZqc29sazFMbGlpVmVwWG5HZ0N5bTBzeW5RRHRoTGQybEJSQVN3VUVFMDdO?=
 =?utf-8?B?RDBtbGFvUm1IYStMYmhubEwvOW1TcDZlQXZneGR3NlFOTWx1MUJienpBQVdz?=
 =?utf-8?B?Q2dma0JCbVoyTjEvbkFRRUp5dWdqYVRJTGFqSFhvVFhmYlJ5ZGoybG1JRmFo?=
 =?utf-8?B?TW16RVlybzRFcmZJeGkxeUVRV2hTbzJlSU1GZ2VEaWVLWDMxbjU0T1ZrRGZB?=
 =?utf-8?B?NHdtenpSbUYvanlqempDa3FUN1E0em9ZOG1nK0VmcHI5eG9XL1VTbHRIVmx0?=
 =?utf-8?B?bllwZ2hYVnBDcS9nMFo0TG55RGFMOCtTZjhYcUtUZVVEMkJqR2t2S3hzNUFM?=
 =?utf-8?B?czU2cExoSGxFUUphWEtvdGxkcGFUS09yQWozTm1mMmEwd08ybDJPcW5rVk9F?=
 =?utf-8?B?NVBBY1doYmxuNjFjR1lPRW9lcjlWNU5ZbitDN09nQ09pTE90bURacXMvZE10?=
 =?utf-8?B?N2c0S2xFaFpqWXcvWmNDYzFHcjNtZXV5NHlJWlRBcVBqbHJkbXhOS2RBRkF3?=
 =?utf-8?B?amNOOEIyUDJiWXFnOUw2clBWZUVwQ24wYWduUDBILzVqL283TmZzMjNhamtj?=
 =?utf-8?B?eFltaThhUWUzR0NTWkZmZlI1cnBYakhERE56c0xISm9qSHVwcWJPTjZKTFpu?=
 =?utf-8?B?TXNTN0o2aWNjZjZ1ZWVHUU1pbjgzbUphaEJTWm5zdk81UlVaYWRyUFJjL3dz?=
 =?utf-8?B?TGZpOWdQcXFuSHIzWWZRdmpSUkJ1NE5qck5zaFZLb2MwRzRoWlBxeElMaTFy?=
 =?utf-8?B?UHdCaGs4SzBJZ0thWHd1QlA2SjRwSEVVbGJFNElOZVRDMllJL0RLdTIzYTBT?=
 =?utf-8?B?eVRraFNRTHRta09ndFI0dEFXbmpiay9QaFk5SHpoaTg2WmIzbVhYVWVsaGFP?=
 =?utf-8?B?SHlBTVZwa3lwTXc5ZGkxd3VjaEJqenFkQVV2cDM4cHdYRmJlZUFzU05WejhT?=
 =?utf-8?B?ckh1TU9uNjFWcytocXdjdDFseVY2Nll0c2NieG9lRzdycldlQmFBT0VVQ3dC?=
 =?utf-8?B?eE55SFZ5bVkvUUFGWU4zUXZ0YU5HNEx1WUd0b0toY1V2U2kwaEhnUGlNbDMr?=
 =?utf-8?B?aGxQOWRDOVZ0QWF1a0JhTHdacDJLR3RNS3ZlQXluVXBkVU8rbjRhR1JrWUUr?=
 =?utf-8?B?aVlBSDJUajVjYlR5ak9zblp0emEyMVBKMHRpR3dVeTI1QjdONVNJckE5MjBa?=
 =?utf-8?B?ZkZnc3lYRHVGRjVCUDRnYk5lbjk2WHpYRVRlTW5aYjNmbUFOMVQ5REhMQnhS?=
 =?utf-8?B?akFJRG43YnJTSmdwSTlXNk41ckhjdTU4TVJnTXd6cU1NTVFmaDBuelc1QUI4?=
 =?utf-8?B?UVdqOVdpZjI5dmhQYkVWNUxzeGpSVHlzQm56NENPSHk5NjY2bFFSdVVUU2F6?=
 =?utf-8?B?VWc5Q2FjZkVFeVVJeWMrS1pqWjVsUEl1VzBNUzhXRnc3Z3hYS3RmOWJpWEg5?=
 =?utf-8?Q?LVZZqrxjx3rXCjMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83DF6D135DF90C4CBF913AFF9855F542@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	heWjKNVXnOoRqjDfTJYmMTJxNvCAyEdX3QcIJi4lK+QBF0WDuD7mGLzhDLEG+uLS2uqZA+m+S9+RklTfYDnS9uXc1J2Ze+E5Lr+FKruq3GwwB2y3KRNgjIBcIXUrLEqNBE3VAd9zJZdBrAsegB1WV+A4yWcChBaQB4u2syk4L8wTIHv5YnJ1zDzqkaKWfjZuXzxRhgrXgJtjVVwo7d5O9fDy/OwCL6UOJmgV58lZ2HWkp7TRVq+CjLCTL6n2tWKHN8/QrQ4yOsq9dmqa6nvgZcHGM8gJPRU8KSy8T6/HPFSIbp4gtAMhqe1+jTDQ9hzdWeZGMrblKFUmAiUbLixhhQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22cf8d-70f3-40fc-cecb-08debafee062
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 08:14:58.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8T4xrz4HGMp6JYfBQAK8jdgwKPoGy9+vzs0ij+7r1aA7j1X+uOleE7OzSCyR/H+hSVW7v8IdAVSTrktbEvoqx4YfJKpCtOD16NQ35pMqMxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB1636
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3MSBTYWx0ZWRfX79AzTQ75pJr7
 3u20U8I/Jng094FuU2c/i3sF53vTjCAWTsqTWy34qyrGrX7WT8oL8+Rvpikw5JYmKGrqpn5lruB
 sGYt4le8BcFzIjEdj+5+R6j1udyReiboVVk7Vhytbltm+vT3FsCzDlJVQaOhTv5rArUqx9lKHKN
 OgIg0pa/HudWbgMJaB4J5uk1BQ33M0xA1QxPdAFxyCAI5VPk5YPcIsA8DMevu/8fFlddqXR2lhf
 YQXkh43F5uZZsGrhzua+0iSnSFhTbd2H5PhRthu5jRGH27hY7DmJ2iO1x/7Q9jJ3yp+9EgPipAV
 vn6+i7z9MBe+CZwCzP1EmLyUcuihx18nEmUSD3Bzc4THWnykf9hKmdk0tc+f2ZQH6KZd2z9t9OJ
 TovIgdnHNaLF5cAJIKaPwiiBNs+SnluBJpKUIkwO6jyHRCjm/YiTKLW6HVylV2kbhxk1gicTesv
 5qJki1/7CGh/SBPFFCA==
X-Authority-Analysis: v=2.4 cv=I5xVgtgg c=1 sm=1 tr=0 ts=6a155685 cx=c_pps
 a=xnyPUJQPCBIbTROBu0NgLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=PY-OiBSF2bnXRlPoZgsA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: vse-AZkQWpbm61EJbrjujPtxgZzEmqz1
X-Proofpoint-GUID: vse-AZkQWpbm61EJbrjujPtxgZzEmqz1
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812,IMGTecCRM.onmicrosoft.com:s=selector2-IMGTecCRM-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254273-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.de,ffwll.ch,imgtec.com,lists.freedesktop.org,gmail.com,linux.intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alessio.Belle@imgtec.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[imgtec.com:+,IMGTecCRM.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4DB25D2512
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgU2FzaGEsDQoNCk9uIFN1biwgMjAyNi0wNS0yNCBhdCAwODowOSAtMDQwMCwgU2FzaGEgTGV2
aW4gd3JvdGU6DQo+ID4gY29tbWl0IDJkN2YwNWNkZGY0YzI2OGNjMzYyNTZhMjQ3Njk0NjA0MWRi
ZGQzNmQgdXBzdHJlYW0uDQo+ID4gDQo+ID4gVGhlIHJ1bnRpbWUgUE0gc3VzcGVuZCBjYWxsYmFj
ayBkb2Vzbid0IGtub3cgd2hldGhlciB0aGUgSVJRIGhhbmRsZXIgaXMNCj4gPiBpbiBwcm9ncmVz
cyBvbiBhIGRpZmZlcmVudCBDUFUgY29yZSBhbmQgZG9lc24ndCB3YWl0IGZvciBpdCB0byBmaW5p
c2guDQo+ID4gWy4uLl0NCj4gPiBUaGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIGNvbnRhaW5zIG9u
bHkgdGhlIHBhcnQgb2YgdGhlIHVwc3RyZWFtIGNvbW1pdA0KPiA+IHRoYXQgYXBwbGllcyB0byA2
LjEyOyB0aGUgcmVzdCB3YXMgYSByZXZlcnQgb2YgY29kZSBhZGRlZCBpbiA2LjE2Lg0KPiANCj4g
VGhlIGRpZmYgaXRzZWxmIGlzIGZpbmUgYW5kIHRoZSBzeW5jaHJvbml6ZV9pcnEoKSBwb3J0aW9u
IGlzIGV4YWN0bHkNCj4gd2hhdCB3ZSB3YW50IG9uIDYuMTIueS4gSG93ZXZlciwgdGhlIGJhY2tw
b3J0IGRyb3BzIHNldmVyYWwgdHJhaWxlcnMNCj4gZnJvbSB0aGUgdXBzdHJlYW0gY29tbWl0IHRo
YXQgd2UnZCBsaWtlIHRvIHByZXNlcnZlIHZlcmJhdGltIG9uDQo+IHN0YWJsZToNCj4gDQo+IMKg
wqAtIFJldmlld2VkLWJ5OiBNYXR0IENvc3RlciA8bWF0dC5jb3N0ZXJAaW1ndGVjLmNvbT4NCj4g
wqDCoC0gTGluazogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLy4uLiAodGhlIHVwc3RyZWFtIExp
bms6IHRyYWlsZXIpDQo+IMKgwqAtIFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgQnJvc3QgKHRoZSB1
cHN0cmVhbSBtYWludGFpbmVyIFNvQiB0aGF0DQo+IMKgwqDCoMKgbGFuZGVkIHRoZSBwYXRjaCB1
cHN0cmVhbSkNCg0KRm9yIHRoaXMgbGFzdCBvbmUsIEkgYXNzdW1lIHlvdSBtZWFudCBNYXR0IENv
c3Rlcj8NCg0KPiANCj4gVGhlIHVwc3RyZWFtIEZpeGVzOiB0YWcgYWxzbyBsaXN0cyB0d28gZW50
cmllczoNCj4gDQo+IMKgwqBGaXhlczogY2MxYWVlZGI5OGFkICgiZHJtL2ltYWdpbmF0aW9uOiBJ
bXBsZW1lbnQgZmlybXdhcmUgLi4uIikNCj4gwqDCoEZpeGVzOiA5NjgyMmQzOGZmNTcgKCJkcm0v
aW1hZ2luYXRpb246IEltcGxlbWVudCBSb2d1ZSBzYWZldHkgZXZlbnQgSVJRcyIpDQo+IA0KPiBZ
b3VyIGJhY2twb3J0IGtlZXBzIG9ubHkgdGhlIGZpcnN0LiBJIGFncmVlIHRoZSBzZWNvbmQgRml4
ZXM6IHJlZmVycw0KPiB0byBjb2RlIHRoYXQgZG9lc24ndCBleGlzdCBvbiA2LjEyLCBidXQgcGxl
YXNlIGtlZXAgaXQgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlIGFueXdheSBzbyB0aGUgdHJhaWxl
cnMgbWF0Y2ggdXBzdHJlYW0gdmVyYmF0aW07IHN0YWJsZQ0KPiBjb252ZW50aW9uIGlzIHRvIHBy
ZXNlcnZlIHRoZSB1cHN0cmVhbSB0cmFpbGVyIGJsb2NrIHVuY2hhbmdlZC4NCg0KSSB3YXNuJ3Qg
YXdhcmUgb2YgdGhpcywgdGhhbmtzLg0KDQo+IA0KPiBDb3VsZCB5b3Ugc2VuZCBhIHYyIHdpdGgg
dGhlIHVwc3RyZWFtIHRyYWlsZXJzIChSZXZpZXdlZC1ieSwgTGluaywNCj4gU29CLCBib3RoIEZp
eGVzOikgcmVzdG9yZWQ/DQo+IA0KDQpEb25lIG5vdywgd2l0aCB0aGUgYXNzdW1wdGlvbiBhYm92
ZS4NCg0KLS0NClRoYW5rcywNCkFsZXNzaW8NCg==

