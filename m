Return-Path: <stable+bounces-67721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29E9525E7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25E91F226EE
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674514B06E;
	Wed, 14 Aug 2024 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HRdV+TaH";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MGnEiJPA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EDTzbd9Z"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5A14AD3B;
	Wed, 14 Aug 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675321; cv=fail; b=MKfzxHiKF0Z7G/2MVsQZIic8WoyIFksr/WAFEeTcalqykcNksf/HV1M28O6JIu6A19dBaExacFfvLEzaS+BIyHI/iY5X3IjnTbHUaWBDVd9rtG6ALn3Jf8VyTBWrdfd8TnTATOtIAL8dmJ3kDLL83zegIzI3mW27p3SNw/+B+OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675321; c=relaxed/simple;
	bh=0JHbgbSWXuePb0NEeeEDUNMOhI2GJhPDb0i77V5m2QY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=br4TZm3J3wZyDmrQ1mT8vmtpa9sUl0P4w9c0h9L08Y3y3ef+Q6xJ2PiGUgbwHneoCpvllurrDS2kn5jePL2U2UirEzcP6PIcpFOFA/JOFd8GOaOiL0VimXhHzaq1u8MjahNXrhdt4tOLMEudkxIpufA+pUArB4VsalfRpAkVarc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HRdV+TaH; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MGnEiJPA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EDTzbd9Z reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHrMm3001758;
	Wed, 14 Aug 2024 15:41:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0JHbgbSWXuePb0NEeeEDUNMOhI2GJhPDb0i77V5m2QY=; b=
	HRdV+TaHdeU21ulBr+dKsVkj/O5+xmVPaVTY+eK557aBKRPPJGNYZu0/WOLC+8SY
	lLzcd2KEhyMjTxYqBx/zyw9TxJKNGxubXIbg+N0mFcyp5DFC6Rc4Hbvon5PiK+fj
	TRKltRQfe4wcXKbW0D4R4tBO+J5CPqi66J59sA5+T8NjcAHqvBE6lSWCHve/sSaP
	EcxFpXuKSuIhKyyHRIy4CTnwzUAZdsgOx14v2bkIPbYP/HcO6DKTEBP1QtYs1W+c
	PtB6vngvBpg8UHRnRcyxaFiBtTxnuAkaNI+G9b+Qzrk/3uHF890PbP6MXXHEalGL
	TR7PbgLKd/Jg0TQszkHI9g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4111c8s22f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723675286; bh=0JHbgbSWXuePb0NEeeEDUNMOhI2GJhPDb0i77V5m2QY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MGnEiJPAXE7QX7hM5oMrcfIRU0did+W0tn7he20mfdtLD/lLX6/AdusfP5V+dx6IM
	 s7oIp/JvKJPWhX6q8/lhk2WkilhftBHLAtePNzJ1WL1HRwNaAIjjWSrWqji+lJ5TCQ
	 pNzrYTbkdpUkLHjBy7fAQ5syXXqUx0YS+DmKeosl4ijFluRQqT5I1Dklh1voC5pfsn
	 MCfeMAVNO/bLItDlqyOA5FYP8GHhVKwzENQExyo1thcb9k7PCc1SUouTn1dVKVpB4z
	 yQjyiAmhlRYGVC9sdaNyOd+5QwaPGyfRjjUNL0hTHV8RmxqkBaHs7jbf4mMUhkr+E3
	 vEQ8LVcfEWz0A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0EB1A40353;
	Wed, 14 Aug 2024 22:41:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7957CA006D;
	Wed, 14 Aug 2024 22:41:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EDTzbd9Z;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E3AB24035A;
	Wed, 14 Aug 2024 22:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+wOojAXnPRvauwK8l96iathpxWRikuLzLT2ABOaiTBnUtccyvIzbsYuOwe0wpPVfzBk05ZWzk12x1Q3aXymke0/2AfdTHVhuxS4GQ2FD0WW25H1xLpcMbKgMmEBb2PevQVpZLN/CExlTrUhMWGU+aNzekf9twFhjdIsHAboChWyViST2M6jEQWhP5mFoJ8LtUwZN6RBv3TvlW78+y1yDhWbnWn0EagUWtBGlZquDJ28D8XkUKyjbpHaCqKbn6sab3kTb6vxriDHxt24ryWKUYwiFm7BqexgILLA4zP6IlqMEbeVcc6x1UkcLqpQPb4vbQMoyt+tXYCprEd9Z3YZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JHbgbSWXuePb0NEeeEDUNMOhI2GJhPDb0i77V5m2QY=;
 b=JUPYuMiWg0WldQU26nd9U3o5lVeQAXnRuPC44RK3XOIZQhtP7blrt809OW8jdx/byyIp9lpaxWB0oK2vg+8NJm41/2Zxlcb9ELNt44JALOCCPHkf2lvrhD36+n2qXdFZVNfeZ3+T6Vh8UYjBulfTb9mECaqYMg8uAZPEJ+p75RMf0TEvUjayqMM249bcvASl8SdnBEDGQVvKeRbAsE6pZKjHWptkObAgRuCiGCcYyrD0fi5Dt9upgW4QCZCs4UnOInOPp89/ybsleu7cqUcDs/MO8YHepnvt+2xmqqjY9CiV4f5i0YA4lCpNJWbfgqLFI4nkZf2zu5NLhd7rWvvBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JHbgbSWXuePb0NEeeEDUNMOhI2GJhPDb0i77V5m2QY=;
 b=EDTzbd9ZNmH9HMKWBE4eRfUptM92/ni93JNB7Pv6ta2evmSuDvTvywz2j9AQd5iw+z6W7N8zrSOWVkGKpATbWE5xVuwH52xqumi5/p+z1ZbIoHRGdeM2okVJfwRXtUz/zc8AH0dhsiOqr089UpV5hg0/Q3OQFUDPLyChmRsBHPQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 22:41:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 22:41:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Sergey Shtylyov
	<s.shtylyov@omp.ru>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Topic: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Index: AQHa7nDk1dgqkywC+0uFNhKLhSI/DrInN/GAgAAAeoCAACDLgA==
Date: Wed, 14 Aug 2024 22:41:14 +0000
Message-ID: <20240814224105.3bfxvq63zpa3gjzv@synopsys.com>
References: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
 <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
 <e26d660b-ce53-6208-d56b-b33a1d1b22be@omp.ru>
In-Reply-To: <e26d660b-ce53-6208-d56b-b33a1d1b22be@omp.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB9447:EE_
x-ms-office365-filtering-correlation-id: 60fbe4b0-6803-4eda-4740-08dcbcb2346e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlpvaytoTDRzckwyVG9td1VXeUtZVk9yYWJUeTNqQ2pyU1dpNXRjUzY3dzJG?=
 =?utf-8?B?dkxDN21LUVo0UHNlVkNycVFEL0xoa1VxNG5CVjUyZlRtb3gxbWlScWVmY1VG?=
 =?utf-8?B?c3NVd0NDNDhZcWxjenA4dk5wR0dGYU1PNGJjUFI1UitqUnloVm9zd1B1a1hL?=
 =?utf-8?B?RUVGWnBqOGs0Z0FRdHVsczVsWmh4NzZzMFhWZHhtdnljUFBhTGs2Y09kZ3lm?=
 =?utf-8?B?bDNXLzhxTDdieEo4eFJ1Mng4MmszWWZMUHZ3T3VYcGFQMGRrT1Y5VXAwa2hG?=
 =?utf-8?B?d3lSUXpmUktSODFSU2plSStrYTZIRFJyVW4waENpWkRzQW9SWVNhYnlDYklz?=
 =?utf-8?B?eXBFNDZRaEg4dTIrVFREdXdwMXdIQmt3TTlLQmE0WjFLdEdlRmRzV0dZMWxX?=
 =?utf-8?B?WFg2aFlPcXprMDVSY2VIOGhsUDIwWEpoYnl6RkhQbTZrcEZzK0YrbUg5QVRr?=
 =?utf-8?B?b1EwN1lMcExjTWlCQnZTa05veWpuVDMrSm9JMXdlbllkZHFEN0RTdE81ajhG?=
 =?utf-8?B?a0p4U3pCbzhYMFQ4QnRFMVdjdW0weVZlWHJmaXBITEwxamtTR1RjK3liT0dN?=
 =?utf-8?B?U20xd1hyZW9LSGNibStkSWFBbzQ5SzFrdHRrUUtuNDFmdndUZDMwbXVvOEVH?=
 =?utf-8?B?TXYxWTlKMGM0VGJvQ21sNXBSeldpLzgvZXRiOS9hZ204ZEMvbUpvM2xvbEM2?=
 =?utf-8?B?SlJjQW83cXEwKy9DRnhYU1JsVDNvWmRBbDIzS0xpNWNSSWtmQndRNGZoQy9I?=
 =?utf-8?B?eW5NeFVGR2VyaThjV2dzUkVyL1paWWllT2J6aU5JdFR0OUhHNm42OE9rQ0tw?=
 =?utf-8?B?a0Y2ODdMQ2MxTmVQTVZhVWJTRm1yR0xRRUhjZ1JVWkNxUE8zN0d0dG1weTZP?=
 =?utf-8?B?SVZVL3ZtYW1vN0lTV1FtUWVkUkdSemVnSU9ndVZaL1djcG1jNnVjQ3dRNkJt?=
 =?utf-8?B?ZjdJVzJYQ1FKQXlqUFV5VEp4Rk5FSE1CamVxSktjKzBET1FiaTBvN0FMdUR3?=
 =?utf-8?B?WXJOQTNUVXl4dndwWFgwWE1WRTdvNjY5ZENkRzZFTy9YekMrK0ZGdVBEb21Z?=
 =?utf-8?B?aXVMaEgyVjBEZVRhUW11YVAzUXp2cmpHNFg2K1dHRGxITDhmeWVZYXUxUXJa?=
 =?utf-8?B?ZG15ZWtVTHlMeU1jUkt0d2RnVnFQMjJ3RWpuWDdSY3lWQlYySnNNbmJCVWZn?=
 =?utf-8?B?TnV6NUt2cHo2V3JRQ0ZOTDh6S0pqcVk5OUNkYlp4bDF1TjBPaVg5UmdNWWw0?=
 =?utf-8?B?YnBIdmlXZTJsMWYwdlNmMDkxSlRaY1JPbi9TVXBwNU9kekkxYmJuRC9DWkRm?=
 =?utf-8?B?T2Jvdk5TNjV1WkJuYkY3NllhR2wxMHkzcHg1QjNVaDJtem5mKy8zS3diNXFz?=
 =?utf-8?B?Mm5WN3I1VmVtMm5ZSWxaVU4wSHU1Y3F0TTN1WGl3NkxpMkR4ODd1VzBISDRE?=
 =?utf-8?B?R1pyTDFQb2s4WDNoOVlPc2ZBN3FxTmNMeDErK0NEdjZMSDgxYnBJMGhoR0py?=
 =?utf-8?B?Y1ZRYUdCa2xsZFEyRGIzVzlsMjFpK0l3SzFkdGU2YTh4NWc1OWVjem5BZmJV?=
 =?utf-8?B?RDhaakJETmJjYkQybVNDWDRsaGNZZE0yWG1SNHNTZzMyYVdUUGtsOWx2UlN0?=
 =?utf-8?B?RGRMaGxMNWhvNHBPMW9Rb1JhUjdWbmF0b2ZGb0xvTUpveTFqVktOMUl1OU9V?=
 =?utf-8?B?TlpBMnpZZjN2cGhMZHFzelp5YytuaDliYldUVVgxb05hbUNvbVJUT01HWXJE?=
 =?utf-8?B?S0ZWYzZZbDVFeHZHQ1VpcUg0YmdhME42UzZXbnR3TFdQNWltRkQvTVM4aXhU?=
 =?utf-8?B?SEhOZzVNZXhDK1U5RVJQak1IVFhJbnpINWhCS2pQRGpkRnc5ZTY3ZG1KTTRs?=
 =?utf-8?B?ODBVMHlsNEhHdzN6a3k4c3dwbEpwM29IVFdEUU1zUmtZTEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGt5OVdyb2lxSi9oTVZ6RXRDYXNxcG5STWpVZDNIQ2FlU1VCMzl0dUx4a1VY?=
 =?utf-8?B?YlRPWFBDYkxITzc0MUVxM0txNVNEK1I5dk1RQ2Nyc1RoVzhpRGdaWWJOczlO?=
 =?utf-8?B?OG9PdzNKSHZvOThkOXd3NWNwRk40Z1YrSCtROTFBVmhJWDYvOUtBbXlHRGcy?=
 =?utf-8?B?anhTbGNzajRTR2lpZmxQR1RoZUN4dDlMVkhMYjUyaktJYTk0Y2hkOXR1MEVn?=
 =?utf-8?B?T3ViSFd0ZUYzdjMvQ3o4SXh2THczbCtDcFZ4TWd4bk1obXZ3QXJseFJZeVdC?=
 =?utf-8?B?aEhBTzRPcEM0K0xpai9IeGpUMUZ5a0NxL0NBS0JFNG9oWmc3eEJFQ2VmODJu?=
 =?utf-8?B?elZhbjRwN29lcjA3VlYrNHVHQjNYNlVvQVhLVnBwalJ6NjFjKzk3ZDBHekQx?=
 =?utf-8?B?UWRiRURCeFBBbmovcDZZTWNLU3NEVTV0OFNBVStOYlBnRjJoUWlJdUpyeFMx?=
 =?utf-8?B?ZnRUN3MxV2ZEa1pmaXpnclJYOTRwOWVwRDFwVTRodDJTNVBzNE1vbldYRmti?=
 =?utf-8?B?TjlsQ3RYQ2szSEZORjlaKzM0c0FJWWdwQk1PUktRcDBXalNITmlyVHo2ZUMz?=
 =?utf-8?B?VmNiMXo5NlYyVXl0VmxZYTVQM3lUUCs2dGJGOXRkbnZTTnFscWEvNlNPSlZW?=
 =?utf-8?B?amFoRTdleXovRGRBQlJnOXA0STZ5VVFBRnhZdnNTKzFleUFaT1k4OFVhdHRy?=
 =?utf-8?B?ZVJtUTI2ZFRjTEtWNVFzRk5Ta2x0OFBkYy91NTBBNmdXSDlkZldFOW96SUxR?=
 =?utf-8?B?dEZsNVdBYnREa3AzVEFuQ2FmZWk5QWJqNTk5eENtMkRhMTVseDFXTFIvUytp?=
 =?utf-8?B?T2FHbW1GN0RET3lNUlAyQWJNdzU4V1RzL0ZwUTBZbkJFUzVocEExVm5nMnZK?=
 =?utf-8?B?VzIxbzhJL2FMOUZSTGZPakcwYkJHSVNpT09uOWlNSk9SMG9CQzZZMk1UV0NL?=
 =?utf-8?B?WVNuNFJKNis4UTByREFodlRFbDdzOTROSExVQlBwNlpDT1kxUjFQSUw4QlBq?=
 =?utf-8?B?d3JqdHpqekFnY2NCM240aG1WT0xGZ2tLYWRXUVpyMFRhS0VMQWFKRGlhbjJQ?=
 =?utf-8?B?endJYVlGYzRTQkJFRUNqVjZSSTVOYkFiMXQ1Ny9oRWd6WWwySjQ1alhBajR3?=
 =?utf-8?B?cTFWeXZWMFJUMlgyZ0s4cXpmTm13S3NPaFRLNzZjZ1B6OG1GZmJZRG5nL2Rt?=
 =?utf-8?B?MXBWRmxaS3k1SE0rN1ZEWitkNGY4T21zZGFRNGMvMTltdi9DSkNQWkNrcHcv?=
 =?utf-8?B?QnoxM0J0dG1ORzhtZlZsMVpjRFMzdk5GSnJhMnU4cmdDZlJRSzRjVDd3NWcy?=
 =?utf-8?B?M0xZVGV0TS9zSG8ranBROHlWSmFBMlIrNmFoZWpCNlhsL0drNEJySGxTYzFy?=
 =?utf-8?B?R0ZoSmpLSjh6Vlp0ODk3MC9FRkdTeVV2YjVkNnRwWmZTNHcwTDE2ME8wQVpw?=
 =?utf-8?B?NTFhQy9BNTdsUStMa1FDZGtZMVVMZHVJd2tmaG1nQVJtZGR0ZlJNUmRLeGhk?=
 =?utf-8?B?c1FzTTgybHR3LzFWRTM5VEhqUS95N0luUFZLTnlTMzNPMnlxSXZlZWU2SGhr?=
 =?utf-8?B?WXlHVXMxbkcrb2d6bWVXNkdVNmNHODUzbGQ0S0g5QTBXR1pybCtVTUpHaGxN?=
 =?utf-8?B?dXVHL3Vod1YwWFRYTnpFVTF6ZmhLb0tNc2lKSzc1YU5ydnpGNmVRc1I0S3lj?=
 =?utf-8?B?NE5BRGNqd1NsbFNaMmNjVkszc3BGa3J1RStjdDhYU1RrVEJleXZVeWlWREha?=
 =?utf-8?B?NCt2aU1SbnRrRUMyR2NpazAxUU9NVTV0T2NURGxIMm40MzFOc3J2dytDa0dM?=
 =?utf-8?B?UjVRMlpLTWdISjFjNENqbi9BSFYwamRub3YwOWIvZ1QyaVZqOEVjRHc2czVC?=
 =?utf-8?B?OHBIb3daZlVTdDhvNkFRRFZMRWVKeTUwaUNPNmJnbGk1c1BkdkdIMVpWdG1s?=
 =?utf-8?B?Wjdtd1F0V2N0UWFvU3FkN05hWTdIOGNQUkJLTEY0RTI2L3dRbGRvUFgwNm9D?=
 =?utf-8?B?QThVSlF3Rkt3R0EvT05rMFJKYjB3VHM0d0pCczMzektEZ2kxblBDN21JZUFP?=
 =?utf-8?B?Yi9nd2dvSEtZZ0N2bXp4WlIrV1JEYUZ0NUhFcTVaUEdhK1dIM0ZLUExLZnVU?=
 =?utf-8?B?bktZdVgrR2NneUF5TFZ4Z3ZsOVhscnp2K1h1L0FEWjhyQ28vMmJRbEt2TmFE?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B6A644AC1C1C4792735C13B2071F46@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ipYYDd4JmBnQwdNR7IT/tioBKCoAZBMUL69QxGdcOmVDx2ZYTSXIf48xB5OodcrLXNFAHb3angSOW/Y/pmzA/lbob8xsduNOB9raQ1paghosA7KZVt3mMNZr/MguPKSlgj31ugUE+MrtGAHZMMoQjw/F6ENr7Vqk91QH2dyrzUlf1/RjRRtXnnE9dIHHUVqHOBfXHpeRLZiv7PyPdang11xufQ6McaACv9wphYLInKVrqsV4cSBiCCwJ7OJi3a9roZNnJYfgvyj+QIydOp+UOADd4bvg2UufaFmHEmaB+r5Mx40z6c3jppryiR46jwum/ZDj0yHH6E+nvqFztLISP7UbXnRyNp5PXoJRY0lRlD9hgnBqjpiAAgb+pX40aXgmtUZiwKmvir8TLeWpEFksvN3PXEc3yFDWlNQS8Ti5bnFws1TMpcU49LXImuZJiR4uLmCTOiB98omaKiQccsBLdpXa8Md5wnJ700ED3ggHvzCqCKziJHyMERkgPZ0KwtJDzzQmAcSzYOBf2T7W8z588TzmhZEH+ssJxF6kYgTnrWdL0KC81t06zyzl9DXzrDG2f099VPeqQ8lE6l6U5hYcUO5c5hjmWGpKaj7xQ8fI8nQ0BtroJzJARGFLHGt921K7+O0IqhPEp7t8ZXV1kXIRdA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fbe4b0-6803-4eda-4740-08dcbcb2346e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 22:41:14.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey24tHkG0W5qvIa3nNDNMJ8bXqnuadArIxYDsB8ZV1YK5Mu/UnU5Rhtw+dPnXlLac8A0CNMbNbCPgN0vWXaXnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
X-Proofpoint-GUID: ybJU7qbvnxaTyQw4lfx0T-K4WugTQCi2
X-Proofpoint-ORIG-GUID: ybJU7qbvnxaTyQw4lfx0T-K4WugTQCi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_18,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408140157

SGkgTWljaGFlbCwNCg0KT24gV2VkLCBBdWcgMTQsIDIwMjQsIFNlcmdleSBTaHR5bHlvdiB3cm90
ZToNCj4gT24gOC8xNC8yNCAxMTo0MiBQTSwgU2VyZ2V5IFNodHlseW92IHdyb3RlOg0KPiBbLi4u
XQ0KPiANCj4gPj4gVGhlIERXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEIGZsYWcgZW5zdXJlcyB0
aGF0IHRoZSByZXNvdXJjZSBvZiBhbg0KPiA+PiBlbmRwb2ludCBpcyBvbmx5IGFzc2lnbmVkIG9u
Y2UuIFVubGVzcyB0aGUgZW5kcG9pbnQgaXMgcmVzZXQsIGRvbid0DQo+ID4+IGNsZWFyIHRoaXMg
ZmxhZy4gT3RoZXJ3aXNlIHdlIG1heSBzZXQgZW5kcG9pbnQgcmVzb3VyY2UgYWdhaW4sIHdoaWNo
DQo+ID4+IHByZXZlbnRzIHRoZSBkcml2ZXIgZnJvbSBpbml0aWF0ZSB0cmFuc2ZlciBhZnRlciBo
YW5kbGluZyBhIFNUQUxMIG9yDQo+ID4+IGVuZHBvaW50IGhhbHQgdG8gdGhlIGNvbnRyb2wgZW5k
cG9pbnQuDQo+ID4+DQo+ID4+IENvbW1pdCBmMmUwZWVlNDcwMzggKHVzYjogZHdjMzogZXAwOiBE
b24ndCByZXNldCByZXNvdXJjZSBhbGxvYyBmbGFnKQ0KPiA+IA0KPiA+ICAgIFlvdSBmb3Jnb3Qg
dGhlIGRvdWJsZSBxdW90ZXMgYXJvdW5kIHRoZSBzdW1tYXJ5LCB0aGUgc2FtZSBhcyB5b3UNCj4g
PiBkbyBpbiB0aGUgRml4ZXMgdGFnLg0KPiA+IA0KPiA+PiB3YXMgZml4aW5nIHRoZSBpbml0aWFs
IGlzc3VlLCBidXQgZGlkIHRoaXMgb25seSBmb3IgcGh5c2ljYWwgZXAxLiBTaW5jZQ0KPiA+PiB0
aGUgZnVuY3Rpb24gZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQgaXMgcmVzZXR0aW5nIHRoZSBm
bGFncyBmb3IgYm90aA0KPiA+PiBwaHlzaWNhbCBlbmRwb2ludHMsIHRoaXMgYWxzbyBoYXMgdG8g
YmUgZG9uZSBmb3IgZXAwLg0KPiA+Pg0KPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiA+PiBGaXhlczogYjMxMTA0OGMxNzRkICgidXNiOiBkd2MzOiBnYWRnZXQ6IFJld3JpdGUgZW5k
cG9pbnQgYWxsb2NhdGlvbiBmbG93IikNCj4gPj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBHcnpl
c2NoaWsgPG0uZ3J6ZXNjaGlrQHBlbmd1dHJvbml4LmRlPg0KDQpUaGFua3MgZm9yIHRoZSBjYXRj
aCENCg0KSWYgeW91IHNlbmQgdjIgZm9yIHRoZSBkb3VibGUgcXVvdGUgZml4IGluIHRoZSBjb21t
aXQgbWVzc2FnZSwgeW91IGNhbg0KaW5jbHVkZSB0aGlzOg0KDQpBY2tlZC1ieTogVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRoaW5o

