Return-Path: <stable+bounces-112061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325EA26816
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1367318861EB
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 23:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC67211493;
	Mon,  3 Feb 2025 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EEEDueNZ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bdc26XQl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="p2MNgUKO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B220B7F4;
	Mon,  3 Feb 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738626996; cv=fail; b=Iv2upoBWz7+lRTCJSwh9lY5YDsTaMaELxp6F5zf9lFvq9NT9irwTiVdJNUzG/pm0LLwfYG+zFBU4SwJV14ZgCRK+w3r2IAOFEsalR9YmHr2t8waIektBZyupidq+TtB91aRJzhHjhilorFlhNTPKjwPYjHoMybMuNN854m8rB2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738626996; c=relaxed/simple;
	bh=p61AjGZ48YKRYo8E7HnDBqDxfmD+m1EVFyZvyCuE3rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAic5Fyf4sCaXU5AWtSFHWImv8DZ68nXYn+HqaFnBOe5z1zbiYIrWs0ZXBlQT3arl/DAxG5jm0S4JbFJZYLK0q19qchLKM6a+I+iQCcU6fWd65JVQuDExMwr8FKLoEzBQQgLyc4WmLEWWGZ9e81LuirQdJZx1syy2NR+7jyNywo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EEEDueNZ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Bdc26XQl; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=p2MNgUKO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513N5cDC018005;
	Mon, 3 Feb 2025 15:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=p61AjGZ48YKRYo8E7HnDBqDxfmD+m1EVFyZvyCuE3rA=; b=
	EEEDueNZTv2GgJscTcQFFgcRNOpBWvo+wNGPT1G69mP5MxLKKIY1pF6hRdkkiwas
	s5OS0ImMtIjsw9FD1koRXDK2Nh8FtjrbUShfi7oTG++BuA+s0ngf3hPo7FIEIkqS
	1wwZktrKQwBriLPqjqknTpIlvu9DRA7te8Ycl7kCbBQB0K2nSaCzcUwM5NaKMGV8
	QKyycjZHWg5RwbCmyI8fyvEOZ7/fdehuBxB0hpdl/IsuZmY2doJ+GUO5TCF+sD9Y
	usiQbhrzzhCWygquhgJI5Q8Jp+z/PMA3XjV59KJdE2xfsvWyGdTVzK3EY2uSzD7z
	ILYLSVYH/TJArMo2mNym/w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44jxbe2k08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738626986; bh=p61AjGZ48YKRYo8E7HnDBqDxfmD+m1EVFyZvyCuE3rA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Bdc26XQliS8kp24R8wECqEVYTgLL05fTPjS4QXGe2/O3f/1vjNTQJBKEaPpsR8IEJ
	 kQSYDyFHoBniHqzGkcyM3wRExEJbbNcvHCSZdbdaF331hRKyvZaFjYxFOpxLZEZ8vB
	 NvR1cJ8wckgx65djaQNyLC5RRsygTEZ8yPvukkvVjvgWG9yKXcybvDsWDvWxu1BEpB
	 ro6EJVhQEe5zerV4vMyYLRgATdEwDiVuo/Rg6J6AhEPvmIrBrpkPHuGRXDPpRUMn/1
	 UgZfBTUdQKex3Ui2Gjfgjy8EYHbMng8l3wg+c5Q0bEA7JronybMOKiqMRotKyQvohy
	 RdaWsWYZmCFqw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B4BFD40148;
	Mon,  3 Feb 2025 23:56:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 455BCA007B;
	Mon,  3 Feb 2025 23:56:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=p2MNgUKO;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1600940131;
	Mon,  3 Feb 2025 23:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2Tkiab8OtxXyGmOdlsS3zl5iYxpoOwnN7Wvl9M4DEKI3Q3WpYP3sTR80mHzlaJY25Nk8cIuoBH3Iday3ibAHj3+aRdgxpw6eM4L1ocWLlPB5HordWM4WF4FdlAtn/YO7ChfxNPjT1IQgS3cjChLTyVphhs3hcNyrfbTMdcx6xxuA+/MJoFpbBlB75zcfqW5CqsPLzK9G76dg8nj/d8Bs4Wzq4ZGOy52zBjnDiNJGSwqZefsvQ8JDJRqoDAo+bIQyx7PHf1VzoMDbqU2Vln/WVK2FCZlfa4m888PxjfZOzsAyqyM059YSAHqJraiMjcofUBu8NZWPEZpg5rlnt9KBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p61AjGZ48YKRYo8E7HnDBqDxfmD+m1EVFyZvyCuE3rA=;
 b=lPiOZB8yW/mb7oFc15UlC2FN+dmzmfMEK6p0O2/nZoDw0Am1UD2YMyKEfoAa6KY7WgFO57JdqJ1AeyUFQ5VKUMzUp/VrbV9YkMH6QoFliNS1a7UJyOV7IOwcd7qQjjpA5hI5h2//3oRipaqFy000zLaImDKb9fFkdZCWETfKowzzPNXqdrp8oedmW6v5HjJ70nuNgNfBOBqzQQGn8Zgfc1+cCXKJzxgilB5tFxkJHLv4Epr3IUrGuQsPpPIgm79pvhxb/bFis93HFT9xaVxXXzPz4hRF/vMaHlDpAVUqJ/KXma5liWF8yB5ywk2sP4tmLSPI//dIs7DjWfh5DJR9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p61AjGZ48YKRYo8E7HnDBqDxfmD+m1EVFyZvyCuE3rA=;
 b=p2MNgUKOMoCU7xM9fNpyBbqH6ZX7ZQ0O6eYs3q5ASrWbn8FJOMfKQ9SYt7YWVDfxXmwSIOL36J2heeA4Zy+KtVKmCYlkH3AtUsheW0sVRY0OkJMN+mA2vYy82H66Ij8+3XxaxfSTv/yX6A/FYl5tIhfNdSY+2RBDQbZnqgeVk/4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 23:56:21 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 23:56:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix timeout issue during controller enter/exit
 from halt state
Thread-Topic: [PATCH] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
Thread-Index: AQHbc9CSbThlP1CLokGyOvQEPDScH7MxlQ8AgAEmbACAA4tYgA==
Date: Mon, 3 Feb 2025 23:56:20 +0000
Message-ID: <20250203235623.65frpwm74ktdm3gl@synopsys.com>
References:
 <CGME20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3@epcas5p2.samsung.com>
 <20250131110832.438-1-selvarasu.g@samsung.com>
 <20250201001506.jr3yw4twwr7zutzd@synopsys.com>
 <1ef209d9-816f-4446-b658-846825e8cfe7@oss.qualcomm.com>
In-Reply-To: <1ef209d9-816f-4446-b658-846825e8cfe7@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8100:EE_
x-ms-office365-filtering-correlation-id: 57e7644a-12ca-4eef-dc29-08dd44ae5b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnRvWUNjM3VrWEdZSlBrTE5qZ2lkdDJLNFRqTzQwN3M0WXhDS0lQbytjK2ls?=
 =?utf-8?B?emJVbWFsM0UvbnBheEY0SWE3SXlheGJ2b1A4NjF5VnprS3BtSjdpUGR0U1Jl?=
 =?utf-8?B?K04zS2UzTHV5QU5rd0Y4K0RWNEZLanBFU2JBZm1rRkxVcHhyT3Q5L1VQVllh?=
 =?utf-8?B?ZzJLWXptUkNzWWU4Sk1uRmJBV280dHQ5WW1ORCt4TDhpNnkwUDZjTXVrVytW?=
 =?utf-8?B?VHdNdW1xbHBZZldnTDBDMzRISE82RFpybG9haFVaa2N0a0luK3o1c0xtYUxi?=
 =?utf-8?B?OUhjNnRzR05yemtrdUFlVlhFTnFwZjF5djJBbkxqMzdlWGlnWlVVR3JZMVpF?=
 =?utf-8?B?Z0RpUldGaWNmQnM5WmpUR0FBOGkrUlkzWUFYSjUvTVkrdWlsd09maTliU3du?=
 =?utf-8?B?TmFqaEwwNGZaNHhXTU9VeDdDWnZWaW9kSXhKREZvaGtOT0NrYnphMlNWODhp?=
 =?utf-8?B?ekRxY1MwN3ZqY2h6Rmtxcit5UGhiV29ITEJDVFozbDNteWs1ZWt5VGxKeXFO?=
 =?utf-8?B?d1NFRStnOEFGd2lVQkFOa0ZaN0cxT3BWNnF0dGpmRmxKeUIzS08vaEpoNnll?=
 =?utf-8?B?MW1jbWNhYkVHOEtycWIySE9XZWJlS2R1S29hbUoxelUxYTRNZDc4NUYzeFp2?=
 =?utf-8?B?NXRWS0VhdG1zSjQ0d2dLc1BqTDE2dWQyNXB2cUxrOE41M25leW5aWGtTWVJF?=
 =?utf-8?B?ZDd4c3pzUjNUQ2U2M0V5ZFhRUWpjQ1AyYnQzeDEyZTVuRmpobnhCeWRmYXk5?=
 =?utf-8?B?RVRoQVl4bUhRTitDRTNydlE3THY1d1hHUkZHblZMaDJ3MExWck5xRGFNaHFY?=
 =?utf-8?B?clBiN3orRXNoS0psNWxXdE1UeG5iejdFOEpQdUgzekFua0JqWit1TlM0bVVw?=
 =?utf-8?B?bS9ZWWltd0ozSi9oWFpXM0d5MmpqNTFGZ01ianNUNHJSSTlOM29Tb1BYVnlh?=
 =?utf-8?B?NUxzZ3J1T0pPc2VNc3p0UFlKYnNwQ1BGMFRpeUFBeHc4RW8wS0FxZFA1WTVO?=
 =?utf-8?B?V2N0SE5uVHMzNWtpVythbjBkL0tVQ081dkF4ZU5TSmlnenY4RHc3OTdHODdt?=
 =?utf-8?B?R0VpaDFIRkFpak1RSlk5QVNGQVR1RkFrUDZHclljWG0rNERnZjYrbk10QmRX?=
 =?utf-8?B?ekxPNExVREpIZDc2UkZoYlk5dURIQkszbWc5ZW13NHlnU0tqdy9rT3N6anU1?=
 =?utf-8?B?cCs4dUgvTFIwM0gwNEphSU5jZ1UxYWJIRVE5K09RMTZINlJaQWJPQTJib3Bj?=
 =?utf-8?B?N1hqZVpmM25FUHFNSjVyL3d3eU12d2l3QmtCa3IyWDc3ekZmWmsxRzhwelds?=
 =?utf-8?B?bWpWRkxlS09hYU9mdS93RUZhd1pGbUdNMXYwbHNrMVpGZFRtQVkvTW1CUjFy?=
 =?utf-8?B?dTFEdkZxU0l4eUpxK0RwbzNQWkphTW52anAvMVZGcU9qWVdVeVNTV24vY1lJ?=
 =?utf-8?B?eU5Uajg4aHM1dkJnYkVTc2ZUWXI0Zk41TStMZzQvRFVLMmhEdlVRVEVCZStR?=
 =?utf-8?B?R1J3c0RPWTA4b0ZZWThhMVozWmZsc2JsNlpENmczMVlvSCtrS2JreUF3UGxq?=
 =?utf-8?B?RE9hc0hjQlR6QWZqNnB6SU9lenJQMHZiRWo5dngvTVlxckVvRWh6Nkt0SW1x?=
 =?utf-8?B?N3dnM0tocDRrMjdnR0R3QlFtY0EwbUhrMTRnU05BS29QbXVVUE5rYXJtOU9O?=
 =?utf-8?B?Rko4SnZ2UThSa3VnTWxNcktpTHFNVVJJbE9GaVFYa1g4WjBVY3FzZDRTL1U4?=
 =?utf-8?B?MXBObG54OHdPZkNiSjBGdFA4Q3NCeXh5ekR6VWczR0V1cXE5TC9YZnMxLzE5?=
 =?utf-8?B?S3FIelpJNUpMSXR2bGhmeitqSkMvQlBoMDJHRlQ3cGFCbVZaZVN0c29pZjVN?=
 =?utf-8?B?UnFEbWU0VmxMeDRWbC9IbTNKN0d2UklEa0dNQmhUbi9vRWFoVW01aUt5Q1Z5?=
 =?utf-8?Q?Bska59/PmSdaVGxRmFiTG1cbocv3QDqs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGtkbEUvbFFoNlU5bnBxeHowejExYkpiMG8yUVdqMEpyRUJjVkFZd0ZrM091?=
 =?utf-8?B?UERuU0xKeTVlSDRUa0RtQzUreXowc1RpeHpDbXBFSzdRQWpmcHdXQXBSOXd1?=
 =?utf-8?B?QXMzc1lNSjZUWWVHVHdETm5aWHNhcVRSTHlweTJKNUdwdVNFeS9PZmh2Si90?=
 =?utf-8?B?SExPNW1zQThzOVpWZlNnR1hSRWlkVHR1YXpUTHM2TFA3UTdHZzNFdng3WlUv?=
 =?utf-8?B?TDhkMVhWVWVmWnZWNlQ3SkF4dXNWK3VnYm90dVZHaFd3VlorcStuaE9kV3Bu?=
 =?utf-8?B?TVV2dGM5S0ozRU0yUW82MnRvd001QnRZMTNTZ0V6dlk3dm9vcTVWTzVUNXhQ?=
 =?utf-8?B?dkk5cGlBQ28zQ0t4SXdrOTFxZ1NhSFd3R2tGaDR0UkNRZVorSlZCUFArdXRR?=
 =?utf-8?B?UWR0eXBZQkF5Ry9hZy9XQWRZVzhmeDZjWXVWTWZnaWJWNEZnc1ErNVd2NkxH?=
 =?utf-8?B?cmN4SmsvTi80L2c3SzdyVitkQ3lMYUlRODNrQkx6eFg4aU43OVRBMmswTDIw?=
 =?utf-8?B?QVl3TXIzRkUxemNIRW4vYkNkUm9SNE4ycWwxY21sdFA4RkRtekZScWFuY3dR?=
 =?utf-8?B?ZWV0Z3JHbUQxck1LcVlLY1RlYUpWZ0Q5VWppbXNtRjZINlZPTkVOanczZDI5?=
 =?utf-8?B?MmJIbUI0dGpsMlVWK1pJY0MwNVAzTGxNVXJVUElBWXErdndJbzB3Y1o2U2Mw?=
 =?utf-8?B?OXBiV1BTNUFwQVVZaXMvbDRQbVBJWjlVeHg3QXNsRjJqcUVnSTY2QWgzOW5w?=
 =?utf-8?B?a3VySm0wdjFZTG5TOEhaM2t5MlFYa3l4aWpERjZMZW5LblRZT3p3UTc4RHh1?=
 =?utf-8?B?TnpXZG1pb1pONFVNVFJiMi9zWXduZW95QnRCeEtuWVVXdGxSZldHQzcwY25s?=
 =?utf-8?B?VjJNODJZcjZwdEVUVXRPOFJrNWEzVXRQZlpWQm90R2o0ZFdtL3pQYWpmWGZo?=
 =?utf-8?B?K2pPczNsa1NTWUxEM0ZTTGpDK2pwdk9uaE1GajNHMXJVNVJYbHRqc3lsUytt?=
 =?utf-8?B?NTZZOEdjOEM1ZjJiVUN6M2hBMXlkL3YwTkdEcitZZ2ZSMEVHN1lYWGFPNy8v?=
 =?utf-8?B?ZnV6cjZsVllqQmtSTUxLSnByb0NZSkdhTjZhMk13Q0xlQUI3SDRsOHcvTkJG?=
 =?utf-8?B?SHFBeDgvdWxUUHJvMncybDc4aC8zMzVieExmVHR6cnNaNk5OWmJoVW5NUWY0?=
 =?utf-8?B?emZhSEtVUk9jeEhBWkhHOVJDdjltWCtsOXY5RVdDLzRZOGJaek91V1I0aDFK?=
 =?utf-8?B?M1ZWbkJsbHR5Z012aU5XaXNOSUovSEVYR04vRmZTMTRtcCthWUFCTkZUQWRU?=
 =?utf-8?B?WFFSVUxJS1hLQkVXdTZ4dmsyc3R6WWsrTTVnR0QxRGxtWnduNTh3cWZhbXhW?=
 =?utf-8?B?K1NmbzNsTzdGakdkbU5OdFF5RGZ5bXFFa2FsZENMRnNrZXJFaDZoV25Bd3N1?=
 =?utf-8?B?bGZRa01FZXZaYnFzY3NqZUlCZzNiU25qNlBFdTV4ZDlYUEJBTzdRdXY5OUtR?=
 =?utf-8?B?cDJYOVlrazBVSTB1dVZ4TklReGNVblhmbHU1bEFmeit1Yis3Q3l5Vi9GNUhR?=
 =?utf-8?B?QjI0akdDcER6U0pBaFU3QlBpNklUSXo2c1Z5WnNvc0xIT05RMHBQajBxYzhU?=
 =?utf-8?B?S0tSK1hrYklqN2J5b01KNStWMXJ1cjUvWUFRZzFiVWtkNFAySWFhQW5OVlNp?=
 =?utf-8?B?ejViZGl6ZS9ZNDhHMEJWRHdzTzRtMDV3d3dRSGJKM1YySy9RR2VUQStmRm5p?=
 =?utf-8?B?NTY0bDlydm9BL2M2QS9xR0k4Ly9hbjd0eWV4azFjM2RzYU54cE1RRW8rcXhD?=
 =?utf-8?B?TDZvOS9rQmdDTFU2ZndZRTRLMllENCtHQ044d3lUc3k0WHFHNCtBMFlXNWFP?=
 =?utf-8?B?ayswL2pPanlubUNpKzRpSFhESlBuMUVQNWM3YktsU2F2MWJpOEpQTTZhNEhO?=
 =?utf-8?B?WjM3cTlKTFNaekREUjVxNnBHcFh3bTZ6c0hYOExpVjFkYllXZ2MzUWNrbWI0?=
 =?utf-8?B?eElHdG03RTNDUFN4ZnBwU0pEMSsrSGcyQnBPeWZjeENzcHJrT0phbWRPb2Q1?=
 =?utf-8?B?TkJxa09sMy85WGt0R3NUL2JqMmQrVWN4aFZKMXR6MHVMTHJSVkJYM3I1cm54?=
 =?utf-8?Q?+EAzAVyCoUAkqi+19/Z+03Rsz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68CD59EEBBC60B4C92191D389F709C4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	emmmkFXJEIAomrqraRiLblc83HhORLw8I7vrrv3TKZ0IS6kYJmuP1+c8Kw8ychTjodMQmJITe1nvwC0bnlkJHNYIzILiiLAlTdn4O44uuFmNSOYP2OIboCBbgYZ2xc33RYd/rx/saylNDHqmiKWAxSFAOljNqJQht0BGgacz2ZNoMlQCfsdFaoQpGtMTI8qwH2AqkttHmJ+kIRqr9Gej+OxfLpktpYGpfP/lzSNgoBXgpOcQp/cG86xG+nWNY6Va/By0gqiM7Z9xFwVKbBGbdqqI6pGP6nDzgcppuCDnuOaU0bxwP0agQdbLFmT+1X/uj2HUwkCEC5X4lyd34UClwEnqux4bamSjtpObQWAJAd88ydjRN7EGa0+ZbY+l1NTQJNrEvGtdQfdZenL5CCwm5JYKb/Ekf2ygXdGOMaTI7WH6vX737d7WrUIVxyAs/dXPAVnTUI7bC0Nu7PJE/c6/3RJ/8Gwo1voX9IzYVMyc96YVbJFC/IvQ8/eVbBY5KIhbDKaJywM/KTuMHLZJ4/X4Qjz66oyzOF1wOtxkQ58g4iKfRo18fdTHpDDGCtoRQg/XSU6qtoOIfErwlisFWITsHVw5ckAXzisbbAlLXI/TG8F8QtOfeSNGOLAhMKz2dKiFhRTh9+wNcBFnap8Kq7YSLw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e7644a-12ca-4eef-dc29-08dd44ae5b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 23:56:20.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLesbzQouu2dfc6pbobMA11kz+qjfdNnUoH0GARxVto8dMzHYNG7fG1oNaGAcrxj6JkRmP0kFO78m6yPaVtPmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
X-Authority-Analysis: v=2.4 cv=GtS4+l1C c=1 sm=1 tr=0 ts=67a157ab cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=BI1fWwdpW2sTb_3iHmoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bKuPc5YmzxToFDwUYKP0zaFKCA8zIgIq
X-Proofpoint-ORIG-GUID: bKuPc5YmzxToFDwUYKP0zaFKCA8zIgIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030175

T24gU2F0LCBGZWIgMDEsIDIwMjUsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IA0KPiANCj4g
T24gMi8xLzIwMjUgNTo0NSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgSmFu
IDMxLCAyMDI1LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPiA+IFRoZXJlIGlzIGEgZnJl
cXVlbnQgdGltZW91dCBkdXJpbmcgY29udHJvbGxlciBlbnRlci9leGl0IGZyb20gaGFsdCBzdGF0
ZQ0KPiA+ID4gYWZ0ZXIgdG9nZ2xpbmcgdGhlIHJ1bl9zdG9wIGJpdCBieSBTVy4gVGhpcyB0aW1l
b3V0IG9jY3VycyB3aGVuDQo+ID4gPiBwZXJmb3JtaW5nIGZyZXF1ZW50IHJvbGUgc3dpdGNoZXMg
YmV0d2VlbiBob3N0IGFuZCBkZXZpY2UsIGNhdXNpbmcNCj4gPiA+IGRldmljZSBlbnVtZXJhdGlv
biBpc3N1ZXMgZHVlIHRvIHRoZSB0aW1lb3V0LsKgVGhpcyBpc3N1ZSB3YXMgbm90IHByZXNlbnQN
Cj4gPiA+IHdoZW4gVVNCMiBzdXNwZW5kIFBIWSB3YXMgZGlzYWJsZWQgYnkgcGFzc2luZyB0aGUg
U05QUyBxdWlya3MNCj4gPiA+IChzbnBzLGRpc191Ml9zdXNwaHlfcXVpcmsgYW5kIHNucHMsZGlz
X2VuYmxzbHBtX3F1aXJrKSBmcm9tIHRoZSBEVFMuDQo+ID4gPiBIb3dldmVyLCB0aGVyZSBpcyBh
IHJlcXVpcmVtZW50IHRvIGVuYWJsZSBVU0IyIHN1c3BlbmQgUEhZIGJ5IHNldHRpbmcgb2YNCj4g
PiA+IEdVU0IyUEhZQ0ZHLkVOQkxTTFBNIGFuZCBHVVNCMlBIWUNGRy5TVVNQSFkgYml0cyB3aGVu
IGNvbnRyb2xsZXIgc3RhcnRzDQo+ID4gPiBpbiBnYWRnZXQgb3IgaG9zdCBtb2RlIHJlc3VsdHMg
aW4gdGhlIHRpbWVvdXQgaXNzdWUuDQo+ID4gPiANCj4gPiA+IFRoaXMgY29tbWl0IGFkZHJlc3Nl
cyB0aGlzIHRpbWVvdXQgaXNzdWUgYnkgZW5zdXJpbmcgdGhhdCB0aGUgYml0cw0KPiA+ID4gR1VT
QjJQSFlDRkcuRU5CTFNMUE0gYW5kIEdVU0IyUEhZQ0ZHLlNVU1BIWSBhcmUgY2xlYXJlZCBiZWZv
cmUgc3RhcnRpbmcNCj4gPiA+IHRoZSBkd2MzX2dhZGdldF9ydW5fc3RvcCBzZXF1ZW5jZSBhbmQg
cmVzdG9yaW5nIHRoZW0gYWZ0ZXIgdGhlDQo+ID4gPiBkd2MzX2dhZGdldF9ydW5fc3RvcCBzZXF1
ZW5jZSBpcyBjb21wbGV0ZWQuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiA3MjI0NmRhNDBmMzcgKCJ1
c2I6IEludHJvZHVjZSBEZXNpZ25XYXJlIFVTQjMgRFJEIERyaXZlciIpDQo+ID4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVz
YW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
ID4gPiBpbmRleCBkMjdhZjY1ZWIwOGEuLjRhMTU4ZjcwM2Q2NCAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gPiA+IEBAIC0yNjI5LDEwICsyNjI5LDI1IEBAIHN0YXRpYyBpbnQgZHdjM19n
YWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uKQ0KPiA+ID4gICB7DQo+
ID4gPiAgIAl1MzIJCQlyZWc7DQo+ID4gPiAgIAl1MzIJCQl0aW1lb3V0ID0gMjAwMDsNCj4gPiA+
ICsJdTMyCQkJc2F2ZWRfY29uZmlnID0gMDsNCj4gPiA+ICAgCWlmIChwbV9ydW50aW1lX3N1c3Bl
bmRlZChkd2MtPmRldikpDQo+ID4gPiAgIAkJcmV0dXJuIDA7DQo+ID4gDQo+ID4gQ2FuIHlvdSBh
ZGQgc29tZSBjb21tZW50cyBoZXJlIHRoYXQgdGhpcyB3YXMgYWRkZWQgdGhyb3VnaCBleHBlcmlt
ZW50DQo+ID4gc2luY2UgaXQgaXMgbm90IGRvY3VtZW50ZWQgaW4gdGhlIHByb2dyYW1taW5nIGd1
aWRlLiBJdCB3b3VsZCBiZSBncmVhdA0KPiA+IHRvIGFsc28gbm90ZSB3aGljaCBwbGF0Zm9ybSB5
b3UgdXNlZCB0byB0ZXN0IHRoaXMgd2l0aC4NCj4gPiANCj4gDQo+IEkgZGlkIHNlZSB0aGlzIGlz
c3VlIGR1cmluZyBwdWxsdXBfZXhpdCgpIGluIFNNNjM3NSBhbmQgU004MTUwIHRhcmdldHMuIFRo
ZQ0KPiBleGFjdCBjb2RlIGxvZ2ljIHdvcmtlZCBvdXQgZm9yIG1lIGRvd25zdHJlYW0uDQo+IA0K
DQpOb3RlZC4gVGhpcyBpcyBnb29kIGluZm8uDQoNClRoYW5rcywNClRoaW5o

