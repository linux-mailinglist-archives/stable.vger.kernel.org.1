Return-Path: <stable+bounces-144565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C880AB92E1
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 01:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F2BA20C3B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825E28C84B;
	Thu, 15 May 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PbNYNoMU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mTrlat39";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gDDWiZpN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2D1A2396;
	Thu, 15 May 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352597; cv=fail; b=Swda1/TmE6QKeorVd7Iv3xSL+KlUmHoZw14N1ZZal1HNYqky9Vg4LyXov3Wl46KT73mZsT5ID90yPYFvai2JMRnRauGGX1SuGvUBH8bCzwUBm/Dr3XiyXTFrrLx9JJxHPW56hWbpQQI/I6bxy6SK7FU8ccuEB9Diyx/O8A38IAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352597; c=relaxed/simple;
	bh=ItbZBnS3dHX/bQ2EYFrmeWfkRKjfg0FqqaM3ciOtgls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bl8kARVs6/XGC244rTb5NCyCyjpC2U4SjMXYu6zu9R3fBk0sw+HA9FDmJURJx6G3I+0vzXrnoLVBmhD31Jp9eVrAcDPx+lNUC1Y/uRtbI729aSCYyhjGsvKk72h+ap46cxfCqBzwUlkkhHa1QBDz9LGbK5lAkcHosUNJI0hguIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PbNYNoMU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mTrlat39; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gDDWiZpN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FHQKQf012115;
	Thu, 15 May 2025 16:42:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ItbZBnS3dHX/bQ2EYFrmeWfkRKjfg0FqqaM3ciOtgls=; b=
	PbNYNoMUU+1QFbp4pZYHGOMaEHwYa8Hr+nHKClRufa0EhXWO4jUff9OMYSfjviff
	1s92KhK4u6/5F0TSmrK/VyLRZ3aLX/KnhXmBr6/CmpLQnjGPX3R1r0Yd8eKJflM4
	nbJxDYgBThMoG5ImeR0TRYfd23f2Snrfj/JU2/tdVfpw6NwMufkqCmzK57nASsa4
	ubs4wWt0xPXWi/bBVbU2n7EzLmbKNtPQ2Ql1T5zQBVabcUMQUI/1USLsk6rbAQY7
	PryT6xazUHo9sOCfDTtJ32UQye21mle5iQh0HfwjWAftLUYHfbacqwOpXrqATyRW
	9JkJv7eMegKcDvTUCBLHfg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 46mbgcgkfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1747352576; bh=ItbZBnS3dHX/bQ2EYFrmeWfkRKjfg0FqqaM3ciOtgls=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mTrlat39nrL7W3AaSrecz+nmgE/YNJk3QKvxn12vvZvFiQKGUS8sMSeWG/FkcN3x/
	 03S7AG67wWph+4+VHXvgycx2VHKIz7FN0qMLmVlZJD+2tzAKy4t2IqzYNjDLWwjPGd
	 x4WTtwmtBcPmNY/NH0Irlexuc2asxJWUoLlqzY821v5ig1AGh9Eu/3ji/x6jn8WPWl
	 9PCKlXLaA3N+lsXp22nWUv57map8ebVSgrKzDACqj+3LyEKyn1OwFJXk6CsrVERgqf
	 cQRyz7eB/wMDAX0S/BP8pqNgjjLjce5fNM+FKDEjipcuPcxkuaILJfZhVJpMfSYdR8
	 zlwFPanY2gJCg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7BBE401CA;
	Thu, 15 May 2025 23:42:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B00C1A0073;
	Thu, 15 May 2025 23:42:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gDDWiZpN;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id F275240120;
	Thu, 15 May 2025 23:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF5eHnMSuh7H2vpU84uhgLJoecL+9jZCoNE+DeRO1iqd1CLMI6fatodJ8KXyIXyaMl4/jgteXQkR+spZ01rSAAGO+SeV14HHEeYjwXIxkXxvg3DeI6WeW5TTwH/9zug2+GXYaKyg+K5hvzZXSZ92/TbbZ1PJcZCAYk8JZVUI66H+uoiSI3KZj23tEv/N1k3ALe321xBddVVFlruObjw/gE7g1oYrRe7fFOgyUm3lRNP69klxD3lX8fWHd0AbCz+J/7nwYFK/N86JLCkf260y6VDGpZn5sz0QLOMBwIX0cj8gtqsk/RyZ2knJFAa1Y4k3OpTB+L44EZD+ZWqUfyxcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItbZBnS3dHX/bQ2EYFrmeWfkRKjfg0FqqaM3ciOtgls=;
 b=e3FOg1tXWlke9bpcGO71NgghZA6xukHuD0Gacc75r+fWH29Kl6mUODIPFUDFnxt68yYFIk3Qf3NCwjFd9eFIfdA9JohCNUfK/7uyXRxLgo1aT7jKnY/bplBaQucwwv/sod/Wf+TWynuFKLIsqSsMB85dj+atEAqJYH278lfin39Yk3DfyxUeFB4s7ocTJZfVK0VdtCUJd1hLBJFDd3BYJKaBG7XTs72H2VJDcVbhXXN2X9qHuDxaf2wkksPGj7r3eon/F85nXV9TphS/E6fQRmI3Wf+87hrvueXmu8U6kC/2Z8Xey8//g5jfy5fuM0BU4fAF9KvyzxXKOGBP5AZ9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItbZBnS3dHX/bQ2EYFrmeWfkRKjfg0FqqaM3ciOtgls=;
 b=gDDWiZpNlqsFxu1Wyi3sC/VIAQ1XZKpxwEZtrFSiQX7c8k3Fq0dwY1pf58Y75jjL7cLNm96gZOfib2HNMC0WTHn7alIHm+W1WJXBOmsaj6+4XdA4gYzhqnPxkeIYZHlHkAvmHEyMxr8yOWhYLktQj66qfOQ5X89I8A3MV0R5Dv8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 23:42:51 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 23:42:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Thread-Topic: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Thread-Index: AQHbxcqMuLhsoUUr9EONfc+97j2L9bPUWoYA
Date: Thu, 15 May 2025 23:42:50 +0000
Message-ID: <20250515234244.tpqp375x77jh53fl@synopsys.com>
References: <20250515185227.1507363-1-royluo@google.com>
 <20250515185227.1507363-2-royluo@google.com>
In-Reply-To: <20250515185227.1507363-2-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8478:EE_
x-ms-office365-filtering-correlation-id: 50436ce2-8738-4434-aa0a-08dd940a3480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UW9UMkFXQ0Jaa3VvTHpyRXoxeDN2VlNHUDUyN2R0ZWRxM3QvSGtrUFRnUWlw?=
 =?utf-8?B?Z1l2YjBXbGNDa3JYL2dNeEE0eVY2L3Mwa2F2dXgwV0JOblY5Z1p2TDk3UmpD?=
 =?utf-8?B?UWI2NE5RbWJFU1ZudmFlcnplRUxGSWV4SnpBWGVad0p0c0pSNGp1ZXdTOHcz?=
 =?utf-8?B?SEZhaHJTVkhzLy94MFhzNERtM3lqbW4xeGM2RHNSY2hNN2NDZ2sraEh4YVI5?=
 =?utf-8?B?d1RobmpGWkdXRzZzdEFlLytsdEMvRTJFZGRkWmVPR0xFV3hqTFV4YmhPV0ZF?=
 =?utf-8?B?dmZZNXNLRjQ4QkxHNk93anVvYWFZeDZSRVZPSGdjNVlHdlJqbXgzdkZrdlBn?=
 =?utf-8?B?bG5nM0ZIWVFDdWhreGQxM1pZTHhEOUZOcVNMM1hMSHQyVktBdWhteWdzWWFa?=
 =?utf-8?B?KzE2VDdFeWNRWk8yZHN0VlZxSzhCZ0dhNVVpT2ppcS8vTjVoWERRcEQ5VENs?=
 =?utf-8?B?S0kxN1FGTzVZRmxUTXd5SEYzZ1ZSMTlzd1ZKS0pab0xHc2VJbWIyS0VDZ3o1?=
 =?utf-8?B?Ny9vWGpiZHMyeU50ZjU0R3hoNXJIRXlHWUM4alZZUWpjOUs2UHVMSzdOcXR3?=
 =?utf-8?B?Nmh5ZXNmSnlvSXFyT095a1Q4Y1lDdXhJaXJQVnI0V2JUazJ3ZFFwblNhZkxq?=
 =?utf-8?B?MzJ3eWw5UDlaUUQ5YVhUeUZGU0RPZHlqM08waWY4VW42SmN5VkppaGZQYld1?=
 =?utf-8?B?cm51aG1QeFgvSkZ4RWpYcWFacFJDV1c1aDBhTWRCRUxPb1llSGFWMk4vTlk0?=
 =?utf-8?B?aTRzMjUvUFA0WGF3VDJINFM0c2RZV1htS05uMjZvQ29PeWY2KzZHcEFtTlhq?=
 =?utf-8?B?TzMydks2ZUdEUVlRZ2ZUQWx0NnpCY2tKM1RtMGp5L3hYWXhwanJmMFVuQU5s?=
 =?utf-8?B?eGZ0NVJSTDRxSXNZdkZobU5OeWFkOU9RL0lyUVpiUzBhWTNlOWJhVXA0ZHR3?=
 =?utf-8?B?NVJEdjlFdWhiVjFxZFFOWWN1RTR0bGN6RGp4UXNZVmt3Z1IvakRnTjZHbHMy?=
 =?utf-8?B?bVd0TnA4MFdYTExYcU04QzBMcXU0UDcxYnFWaitWYmo2YVUvYU1kakVuclJU?=
 =?utf-8?B?R1E5RnZaRlpZZGJ1ZVdPVTV2WHJRZkRzc1NEK1A0ZmlNSFB5dzZjUjUwWWQ4?=
 =?utf-8?B?U0ZNM0xWRzYwOWNvZXBDVmFOMi9DWCsyaDg4anFQcmVRdHNFWTN4UjRlSlh4?=
 =?utf-8?B?c3hCeElBLzBZTEVVN1ZmY2p4Ylp6OHNJMkdrWDlSTDdhaUZKeG5YY0xlamJR?=
 =?utf-8?B?dUVIZk44djZVSEducS9IVVdoNWFBNXBON05jWnhKTTRQZURoQmtJVDN2OU9K?=
 =?utf-8?B?Ry9zakdYbnR2V0RpRUhHQThKdS9wRjF0d3c0bEVTbjlxcEd0ZUQ3QWc2Skty?=
 =?utf-8?B?aURiYXd6SGVoSFBzM1lvV3lSTDdBY3JscmtucC81K1FKeHJhYy8xOW9lbHND?=
 =?utf-8?B?blkxMTBVOTZETEpVd0RZUVJYdU9QVDR6V0NadXRza1VtR0V4anRLaXcyUWJC?=
 =?utf-8?B?NkpJL083M3V3K3hYYndUOFliSlZjdTV2dWkwcm9JVzh3N25VSFk5OG80dFNa?=
 =?utf-8?B?MjB0UlRKdFhaZmtDTW51a3NhdVlZbnpZZWllWkhHQkN3S2lKYW1hNjhvNUVP?=
 =?utf-8?B?OForQ1lOLzJGdGV6dFJ3eXplKzdHNkJQVW9lT0Fic2F4SFJzNmZQcGJVbXAz?=
 =?utf-8?B?MFg2R1lCbExoL0d2Q3VzNXIxcko5ZW1mMGVXK0FDdEdBTFc4Y1hLRmpmVjhF?=
 =?utf-8?B?aXdMZUlMK3N3SlpkYVJBWjdDWEFxbnNzVTJROFlsMnlINzVid1U2QjhpMUFj?=
 =?utf-8?B?NC9rVUZPZGFTdVc3VUF3STRTTjd5bWVzSkhJNFh4TkV0dFZxNzRBS0t0TnZD?=
 =?utf-8?B?SGJFSmpnUGRqYW94RGpVTFVkcnFyZmlJdnBNeUlhMUtXeENXbVhCc2JPY3M3?=
 =?utf-8?B?UWh0WERTaSs1VkJRTnJjV1hVMUVMZ1FvblZnVCtiVEo0UGVjK2R2M1RjdlBr?=
 =?utf-8?Q?v4OfnkYyE/a2H+hEV5EBJjM4Z1nFyQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THpsZU5zMEZoeTA3N2R3NXlGajREN29xKy96KytPR3o0Zjlud1Zvd3loS05N?=
 =?utf-8?B?SXRIV1ExWW44YVpnRFB3SHBPeUNraEIrbytjczZEM0FtQTF4NUdaRHp0UXo4?=
 =?utf-8?B?TzN2clFGcTRsbXhIcHQ5U3llYWtwUkduOUNsT0w3TGllZzFiT1hTdEtmOHJ6?=
 =?utf-8?B?MnhJeHpEWlJiT2V6M3pvWnM5T1htYTdpQlVyZDkrbWlnMXh6NGwrczFkZjMx?=
 =?utf-8?B?UGFxclNndm90TEt3c1ZwdjNtTFI3U2RyYWVjdk5mdW9jZlBHaU5SUlVDV3Z5?=
 =?utf-8?B?cWtibmVJOXhKQWEwL1dya2F3TXlxR3lxRFJPNWZkTnFDUm44VzVYSUMrTXB0?=
 =?utf-8?B?Y0Q3UlVveUw0bUZPQnNaclZEREpkMlkzM2lLakMzdStHR2U1MzBlalNySXFP?=
 =?utf-8?B?VFU2bjR2Z2xrQUhmWDZZZjNKSWR6M1B2MXBOZWJhNzhZUnFTbUhuWEFVaWVj?=
 =?utf-8?B?bmNhQ2Y1ZUJhczlkclBnZEtWOWJKeHY4TmRqNmRtelZSVzhNcklOY3FtdXVB?=
 =?utf-8?B?eERlcUxVcVJYdUZwMXJvODVaV3B4amt2K1FLM0JKTzNTWXJDakV1NEVCQlBC?=
 =?utf-8?B?bjcxK05aTUZHRWR3VEZQeW1YaDJzdnhOS01BcU9XZUhkZmRmN2EwTC9heUpI?=
 =?utf-8?B?b0FsV1JyVldyOTRMK09GS2pnN0U0Tm1LSHNmS2JtcS9EY3AybmdBa2VDdE9O?=
 =?utf-8?B?U1ZmcEdmMisveDU2c0J3Y2lBb2g2S3NadG9waVIxdnBxTUg1RGQ3R1ZmczJn?=
 =?utf-8?B?bm44aFJNTndseWtPUTA0QkpLRDYrbEo3RDJiM1Y3R2JXMUhKcFhGeXg5TXJD?=
 =?utf-8?B?aCtDRGVVWE1VTWdiaFZxVThibmVrNmozUHNiemt2YmxKUDllRU1iZE0vUVcy?=
 =?utf-8?B?WWl2RHFTS0xoRHdRR0pjbWVBV0g2ck50dDRVK1JjN1dIRVE3dnp4Mi9PMUxr?=
 =?utf-8?B?cmpCSHA5dXdtMTMyOCtOT3NJUU1HUm9kMEMrNDM2NFJaekhKZG4zV1plODRz?=
 =?utf-8?B?K01KbmdJVU1MYkxhcmw2OHhkbWR5VU5nQ2t3aE9mZ0R4bkNhRmxYOW9MUG1D?=
 =?utf-8?B?WUlZSThMVWJCa2sxd2ZoK3hSTTZnbUVOSkVPNUMrbm94WlhYclU1eEtETzRW?=
 =?utf-8?B?Z1RENG1Na2x0Qk5Zc3l2OTZWdWtMY1hjOUZRbk1tZGJ0ZmZSTUQ5RllxbkM0?=
 =?utf-8?B?OTd0d1FHQ0JLM05UZ1JCZTBVaEI2dUN3OUN6d1dzbysva0ExL2pLdWY5U2F5?=
 =?utf-8?B?NGZlV2xkeHo2eUxRWEhQRDh2MzBpUTdDZkJRZlBkU0pjN2pieDFrdlpqczZq?=
 =?utf-8?B?MHdjN0F0bngvQm9Yd200YkoyNHhYS1M5dEhCMmRFYlVvaVM1NUx1dWJJTDB4?=
 =?utf-8?B?MFM1Vk8rS3U4SFFUNXl5NFpMRVYrYTB3WWZVWDhrR2ZYT0tSWFJQcmNLa0t4?=
 =?utf-8?B?OTY1U2Z6WXBLL3NJdk1WK3VzL0k1SGZMY2tJbHVnbkY3YzJLUjgvSmJvSU1p?=
 =?utf-8?B?K1pYK1RhOXppUldhOVE3OU9GZ052cmY0Yk1xNEVFeEpEM1NCVFpoa05DS3NY?=
 =?utf-8?B?N1lBVkQ5TURlQXZuUEJaOXoxZlhsNW9sdFl0OHk3TzNnTDhCYUYwakExblBx?=
 =?utf-8?B?LzJHd1FsUWtHUDBQbGF0U0srcmNiOFBWRlIveDl1dTF2eTVtMHRhY0dFa1d1?=
 =?utf-8?B?ZU96VjBRUTE2cnVlYjhsWVRLNXBVcFhiVzlSYy9OUEhBV0FKT0JnTE5nTk5U?=
 =?utf-8?B?SlJWb3ArNjQxVGJUOVpYY3FCZzVuQjU1RjdaS21rZFhzdlUwd1hBSEJ0dWIw?=
 =?utf-8?B?VzFzYlRXeUxXTFAwSXZTZDJPNXRHWXdXZXJvRXk4Qjg3VUZLdHd6WnlYNDQr?=
 =?utf-8?B?RFIxbWppK0c0eWtWaUFQOHY0d0QwbTI0cWRYWThKYXVaZVcrdHJvN3hGV0x2?=
 =?utf-8?B?V0lzRUF3Q2x1UTVKMExOVkZvY0pFV25PN2RLc2M2bExPd2F5QTd3MTI2N1dT?=
 =?utf-8?B?TGZLY0pvRTlxdXNGSE5YeUg5eloycnY5TnRScm8zckdZcVE2ZlRMeGdKdUhr?=
 =?utf-8?B?ZHJESjR3OWMvQzNGY3ZSUTkyNitITGNVODBteXk3S2pSNjFUNWFqdUZCamRF?=
 =?utf-8?Q?E+uI/PMoSYDj+xQrDPAjFAC1G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D235FDE6E747264ABFD26972FA18903D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ma/xOKmr1DWm++7xjHIR4fwoHNN04c+f0RiiRBgHkjwIR6h0mRRr/Nj0icDWg2b8ulqOx3quZBn3xQwWEix6YAP0aifyS4wNlrjj53B3P4eUVg56XB7M/aZlHbeUrtO1/LzoedeXNHcC0JF9K7kYiLWfp5Uk7+G309UYbotY3RgFz01qFxv1rMb693b/1sjx8MaCFBvtC8x8NcwhEmHiWakh6LIDsE94ji3R4VX0KvDSFaJhdUKGsTBEJTAb8djiJS3qht5+cUStyy9uDR9uSBj1eSnOfJF5yu9y0fmLIK5jvuLMPO9838Ck2SQ3BB0nfG3vvKhl2NCNeMO4AUcHNARA5hdEVFnUW/u7YfVX3RSjq2FJNYClOywThN+sWfPLN1mINSCkNkJJ91nrUV2Hpe/tCWs5j6HpWWDD1nCmdUlpej7VZ5wEr4Mu/cmQp7c7l0XVlsnuLiJjCgFuZOg6Hu1eH3webqno4iqiNgAPAifK26d6IvD7PUMrPryG5P4ZyqvC36+i1s/pbRwp7U9vWcqkACjeex4qKKzsGPVxbActOdOm1NX0vUICbTDSSPi6Ui62GNUU8kTvcBcyim4WqFFf6jzC/F5pDmVUycIpnMx0ZfyvCb/n1DZoGQd/q+5PKEJtnZceYWbixRr37lGcbQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50436ce2-8738-4434-aa0a-08dd940a3480
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 23:42:50.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvhO2L8fpaFrTLrmtoSCbC7urZJGDCH/WcemzwqLycraUIn2+yKYawnoQ2HnfSw3C9kXIZJOGYaUhUPxZTv6CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
X-Proofpoint-GUID: ns1MDFmLyJ6XGkc_yvuP76XBXIEa2z_-
X-Proofpoint-ORIG-GUID: ns1MDFmLyJ6XGkc_yvuP76XBXIEa2z_-
X-Authority-Analysis: v=2.4 cv=OtdPyz/t c=1 sm=1 tr=0 ts=68267c01 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=UHEMycVIqpxr96VE:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=72KVsjNWFVogDi-bZm8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIyOSBTYWx0ZWRfXy8BAsZalTdRo
 GWKIYKgOEAnz8Iu6W5y+e6R/BIATWPcj8L68A028BfCFdPUYCb2VdEqQ0KfQRLiaUAhEx59SPPt
 0M0mVaCxCgleqUZa3KQXKQKet4pCs+06n5iJ3k/d2iv/oIND88H3qiNh38CIPIUK23O9lhenzim
 Dx2h9qdXeeAEN2w7SE/U4Y4dEsF0wki20S1MQ/YCHEW/r+lKwel8hbm0dh3od6kNlaBKD0x6DUr
 xnKZtK7AHuAhqJ9bGU30+jk7ZvtzOd1csuQMULWgurt5hsfi779xlI5TZ3oVIXLoWsZLXOLYvH3
 tl2WNvmWvWKe+syc7+cJAXNWHoLZ3SpzWas3CP0U53eCd3bW/w0/LCyjqns5/t+7ZXkruL9us7Y
 gAySVxx78UoePOE4/9ofs0FBxN02R2Ek26zziyB1J+4Rgy6cw0WlkHxmEbCYMCocOcwL2/C/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_11,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000 definitions=main-2505150229

T24gVGh1LCBNYXkgMTUsIDIwMjUsIFJveSBMdW8gd3JvdGU6DQo+IENvbW1pdCA2Y2NiODNkNmM0
OTcgKCJ1c2I6IHhoY2k6IEltcGxlbWVudCB4aGNpX2hhbmRzaGFrZV9jaGVja19zdGF0ZSgpDQo+
IGhlbHBlciIpIGludHJvZHVjZWQgYW4gb3B0aW1pemF0aW9uIHRvIHhoY2lfcmVzZXQoKSBkdXJp
bmcgeGhjaSByZW1vdmFsLA0KPiBhbGxvd2luZyBpdCB0byBiYWlsIG91dCBlYXJseSB3aXRob3V0
IHdhaXRpbmcgZm9yIHRoZSByZXNldCB0byBjb21wbGV0ZS4NCj4gDQo+IFRoaXMgYmVoYXZpb3Ig
Y2FuIGNhdXNlIGlzc3VlcyBvbiBTTlBTIERXQzMgVVNCIGNvbnRyb2xsZXIgd2l0aCBkdWFsLXJv
bGUNCj4gY2FwYWJpbGl0eS4gV2hlbiB0aGUgRFdDMyBjb250cm9sbGVyIGV4aXRzIGhvc3QgbW9k
ZSBhbmQgcmVtb3ZlcyB4aGNpDQo+IHdoaWxlIGEgcmVzZXQgaXMgc3RpbGwgaW4gcHJvZ3Jlc3Ms
IGFuZCB0aGVuIHRyaWVzIHRvIGNvbmZpZ3VyZSBpdHMNCj4gaGFyZHdhcmUgZm9yIGRldmljZSBt
b2RlLCB0aGUgb25nb2luZyByZXNldCBsZWFkcyB0byByZWdpc3RlciBhY2Nlc3MNCj4gaXNzdWVz
OyBzcGVjaWZpY2FsbHksIGFsbCByZWdpc3RlciByZWFkcyByZXR1cm5zIDAuIFRoZXNlIGlzc3Vl
cyBleHRlbmQNCj4gYmV5b25kIHRoZSB4aGNpIHJlZ2lzdGVyIHNwYWNlICh3aGljaCBpcyBleHBl
Y3RlZCBkdXJpbmcgYSByZXNldCkgYW5kDQo+IGFmZmVjdCB0aGUgZW50aXJlIERXQzMgSVAgYmxv
Y2ssIGNhdXNpbmcgdGhlIERXQzMgZGV2aWNlIG1vZGUgdG8NCj4gbWFsZnVuY3Rpb24uDQo+IA0K
PiBUbyBhZGRyZXNzIHRoaXMsIGludHJvZHVjZSB0aGUgYFhIQ0lfRlVMTF9SRVNFVF9PTl9SRU1P
VkVgIHF1aXJrLiBXaGVuIHRoaXMNCj4gcXVpcmsgaXMgc2V0LCB4aGNpX3Jlc2V0KCkgYWx3YXlz
IGNvbXBsZXRlcyBpdHMgcmVzZXQgaGFuZHNoYWtlLCBlbnN1cmluZw0KPiB0aGUgY29udHJvbGxl
ciBpcyBpbiBhIGZ1bGx5IHJlc2V0IHN0YXRlIGJlZm9yZSBwcm9jZWVkaW5nLg0KPiANCj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4ZXM6IDZjY2I4M2Q2YzQ5NyAoInVzYjogeGhj
aTogSW1wbGVtZW50IHhoY2lfaGFuZHNoYWtlX2NoZWNrX3N0YXRlKCkgaGVscGVyIikNCj4gU2ln
bmVkLW9mZi1ieTogUm95IEx1byA8cm95bHVvQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvaG9zdC94aGNpLXBsYXQuYyB8IDMgKysrDQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ku
YyAgICAgIHwgOCArKysrKysrLQ0KPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLmggICAgICB8IDEg
Kw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXBsYXQuYyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1wbGF0LmMNCj4gaW5kZXggMzE1NWUzYTg0MmRhLi4xOWM1YzI2YThlNjMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMNCj4gKysrIGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLXBsYXQuYw0KPiBAQCAtMjY1LDYgKzI2NSw5IEBAIGludCB4aGNp
X3BsYXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGRldmljZSAq
c3lzZGV2LCBjb25zdCBzDQo+ICAJCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKHRtcGRl
diwgInhoY2ktc2tpcC1waHktaW5pdC1xdWlyayIpKQ0KPiAgCQkJeGhjaS0+cXVpcmtzIHw9IFhI
Q0lfU0tJUF9QSFlfSU5JVDsNCj4gIA0KPiArCQlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9v
bCh0bXBkZXYsICJ4aGNpLWZ1bGwtcmVzZXQtb24tcmVtb3ZlLXF1aXJrIikpDQo+ICsJCQl4aGNp
LT5xdWlya3MgfD0gWEhDSV9GVUxMX1JFU0VUX09OX1JFTU9WRTsNCj4gKw0KPiAgCQlkZXZpY2Vf
cHJvcGVydHlfcmVhZF91MzIodG1wZGV2LCAiaW1vZC1pbnRlcnZhbC1ucyIsDQo+ICAJCQkJCSAm
eGhjaS0+aW1vZF9pbnRlcnZhbCk7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiBpbmRleCA5MGViNDkxMjY3
YjUuLjRmMDkxZDYxOGMwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4gQEAgLTE5OCw2ICsxOTgsNyBAQCBp
bnQgeGhjaV9yZXNldChzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIHU2NCB0aW1lb3V0X3VzKQ0KPiAg
CXUzMiBjb21tYW5kOw0KPiAgCXUzMiBzdGF0ZTsNCj4gIAlpbnQgcmV0Ow0KPiArCXVuc2lnbmVk
IGludCBleGl0X3N0YXRlOw0KPiAgDQo+ICAJc3RhdGUgPSByZWFkbCgmeGhjaS0+b3BfcmVncy0+
c3RhdHVzKTsNCj4gIA0KPiBAQCAtMjI2LDggKzIyNywxMyBAQCBpbnQgeGhjaV9yZXNldChzdHJ1
Y3QgeGhjaV9oY2QgKnhoY2ksIHU2NCB0aW1lb3V0X3VzKQ0KPiAgCWlmICh4aGNpLT5xdWlya3Mg
JiBYSENJX0lOVEVMX0hPU1QpDQo+ICAJCXVkZWxheSgxMDAwKTsNCj4gIA0KPiArCWlmICh4aGNp
LT5xdWlya3MgJiBYSENJX0ZVTExfUkVTRVRfT05fUkVNT1ZFKQ0KPiArCQlleGl0X3N0YXRlID0g
MDsNCg0KVGhlcmUncyBubyBzdGF0ZSAwLiBDaGVja2luZyBhZ2FpbnN0IHRoYXQgaXMgb2RkLiBD
b3VsZG4ndCB3ZSBqdXN0IHVzZQ0KeGhjaV9oYW5kc2hha2UoKSBlcXVpdmFsZW50IGluc3RlYWQ/
DQoNCkluIGFueSBjYXNlLCB0aGlzIGlzIGJhc2ljYWxseSBhIHJldmVydCBvZiB0aGlzIGNoYW5n
ZToNCjZjY2I4M2Q2YzQ5NyAoInVzYjogeGhjaTogSW1wbGVtZW50IHhoY2lfaGFuZHNoYWtlX2No
ZWNrX3N0YXRlKCkgaGVscGVyIikNCg0KQ2FuJ3Qgd2UganVzdCByZXZlcnQgb3IgZml4IHRoZSBh
Ym92ZSBwYXRjaCB0aGF0IGNhdXNlcyBhIHJlZ3Jlc3Npb24/DQoNClRoYW5rcywNClRoaW5oDQoN
Cj4gKwllbHNlDQo+ICsJCWV4aXRfc3RhdGUgPSBYSENJX1NUQVRFX1JFTU9WSU5HOw0KPiArDQo+
ICAJcmV0ID0geGhjaV9oYW5kc2hha2VfY2hlY2tfc3RhdGUoeGhjaSwgJnhoY2ktPm9wX3JlZ3Mt
PmNvbW1hbmQsDQo+IC0JCQkJQ01EX1JFU0VULCAwLCB0aW1lb3V0X3VzLCBYSENJX1NUQVRFX1JF
TU9WSU5HKTsNCj4gKwkJCQlDTURfUkVTRVQsIDAsIHRpbWVvdXRfdXMsIGV4aXRfc3RhdGUpOw0K
PiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS5oIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLmgNCj4gaW5kZXggMjQy
YWI5ZmJjOGFlLi5hYzY1YWY3ODgyOTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5oDQo+IEBAIC0xNjM3LDYgKzE2
MzcsNyBAQCBzdHJ1Y3QgeGhjaV9oY2Qgew0KPiAgI2RlZmluZSBYSENJX1dSSVRFXzY0X0hJX0xP
CUJJVF9VTEwoNDcpDQo+ICAjZGVmaW5lIFhIQ0lfQ0ROU19TQ1RYX1FVSVJLCUJJVF9VTEwoNDgp
DQo+ICAjZGVmaW5lIFhIQ0lfRVRST05fSE9TVAlCSVRfVUxMKDQ5KQ0KPiArI2RlZmluZSBYSENJ
X0ZVTExfUkVTRVRfT05fUkVNT1ZFCUJJVF9VTEwoNTApDQo+ICANCj4gIAl1bnNpZ25lZCBpbnQJ
CW51bV9hY3RpdmVfZXBzOw0KPiAgCXVuc2lnbmVkIGludAkJbGltaXRfYWN0aXZlX2VwczsNCj4g
LS0gDQo+IDIuNDkuMC4xMTEyLmc4ODliN2M1YmQ4LWdvb2cNCj4g

