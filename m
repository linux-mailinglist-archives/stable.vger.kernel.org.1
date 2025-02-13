Return-Path: <stable+bounces-115116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FEA33CB9
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D633A93EA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C2213259;
	Thu, 13 Feb 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TDAgn6zW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MVWzcL1i"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3C213244;
	Thu, 13 Feb 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442440; cv=fail; b=k3rEsrAuQHioc0g8d8kqsI7jUPecKZjfCIEmHY2WLTN56SAGgzp54qKlZehG9VfJ2FfWLp9sU1boWqvWxjtceIlbIeaPPG94xv0uM4bE9v+Al1ZnBfsa3xx/kggG/TCk88ry/0NFIXoyTtG/JvZhxLyRpAXStRezBGmPKjcVvN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442440; c=relaxed/simple;
	bh=t2vv/nwrzBM8UwYb6wIWh19V8raPugn6b0Do9F8/X7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ncJN44JI8ZE60WfjvM9CsRCOTEEwhDmDQx6sjjZNFvWPt2Bp2cmuH5EN0QaqomPtRd3sVF99368L70vIMfgcZp8ksXow0+eU4JS2YsIHKDJsDFnIcCUJDoPUBOmJNjn9xJbBwwJ6BIHwrTdM0vi2zpyuTOwJa2go0LIq3d4cbpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=TDAgn6zW; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=MVWzcL1i; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D62r21009125;
	Thu, 13 Feb 2025 02:27:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=20XH+0aPQTwV4EuUdpbN2s+0jepremFVhj/oEOKFM6Y=; b=TDAgn6zWKBhC
	7q6yriayHrARNxdUJhNShCz4X7MRcUKpxLzwPSnjsVLQy6veMfCBGTSkC+z3c6W4
	FHv0qcsBiYq7/C5U9c4MPNiFba/i8CLwgyMy8GYi0E02Ig1/LeC5Ff7UDWQjMv00
	a422c61CxU4w0aUoYpRzKplOje68AMRukFDGcQV/O8SBwQVzC0G+SEvaqT4PR0Sa
	vfmpsLnklBNctbtzhsfY1SnES4aDZHegglpvDlaiM3wf9GOXTnUHozbj3MwecHQL
	1MeKo0Kp1/G0R02cx2cGDY+TMmXpVlArbwIYhdo63oxzE0ryAhTG4lVfTFz+B48B
	ovCfqeHRcA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44sb4gh00n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 02:27:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkjfeGWU5sBLrtM7L/1BMQnJPilqQCbGmvu6KyEnJEq3U1VTqcZhFK98GQS5+sLHjXCCfrKbJJtwmjczikpUFHOjymw5mLgxdA6zCJp5sNDB5aMkIGsL9qMMjNGgV9aAepOjyXAX7mETf7woe6nIm55kUeKxN5jEfvfdyifcad7wUgjH7PEdlTsRN+K707oSL3jStNqw88Wyl8TwSv4BTougreo/EwJxktEJw4Xsd7gOzt9291an5QHC00e9i6iG7VPeNn5l3uvV2ospN45TmPn1qODZfAYqza6WXPViH4XxTniZS01fQuF+xImKMdJ/0oIm7Qk2SPlQmLU5UZLdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20XH+0aPQTwV4EuUdpbN2s+0jepremFVhj/oEOKFM6Y=;
 b=EXFJmh2Q2RmLdj+yKixVsDtcQYyq6L8ZazECnR1/+pS6Dv/P+f8ICndxcXsiT7Fu22sy8V7enNhvgOdpz4IZczXTod38bPZyf4363eyOyzzeKKmvq9RPUvk4DNiT51/mTnnYizS8dZYM/I/Z32Ibg8VC6mgGIxBh5nj9hv/p2M7iXRm2D57FI2Pw/M+ptTKQwV78BRLo27WApSclbuosdugoQcRUwksCVFRlY3rxjMXDDVSvSC55Yr7qrnGbkxahfJTyy58E5FdrohNH80kvw0FdNXA8y21UZZ8nUDgEgM56HYz/D+2EOTc16X/ABfer48aXLa3fT3Ttgeu7t/w9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20XH+0aPQTwV4EuUdpbN2s+0jepremFVhj/oEOKFM6Y=;
 b=MVWzcL1igdNHoxNmZq1AVypO6KO+Yc0trd/87j18yQl1JGvXQBPBv/HP3vsK2FBrvh2emigkakvoBiKoN9H3YiScZ4MU29cJ1KR+fndN6NgV2tW952v7ToDQR4n79J8sPYu8kwarp5p6zNccwDmGKPZx36gfWdPrGBa2+W19IRE=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by PH0PR07MB10613.namprd07.prod.outlook.com (2603:10b6:510:332::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 10:27:00 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:27:00 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Pawel Laszczak
	<pawell@cadence.com>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net"
	<javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com"
	<make_ruc2021@163.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Eichler
	<peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbff/PyNY2z2E4uEeZXCoyn0/C0LNFA7/A
Date: Thu, 13 Feb 2025 10:27:00 +0000
Message-ID:
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250213101158.8153-1-pawell@cadence.com>
In-Reply-To: <20250213101158.8153-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTBkYTA1YTlhLWU5ZjUtMTFlZi1hOGNh?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFwwZGEwNWE5Yy1lOWY1LTExZWYtYThj?=
 =?us-ascii?Q?YS0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9IjM5NjgiIHQ9IjEzMzgzOTE2?=
 =?us-ascii?Q?MDE4Njc1NDI3MiIgaD0iYmN4OGRsSEIvekZHZUF1Tk5FenNjMUxkREtnPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFEZzFQZlBBWDdiQVdOblhyS1BDRTUrWTJkZXNvOElUbjRLQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQXNCZ0FBbkFZQUFNUUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFoRlY4eVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUdFQVpBQmxBRzRBWXdCbEFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFh?=
 =?us-ascii?Q?UUJoQUd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFaQUJ1QUY4QWRnQm9B?=
 =?us-ascii?Q?R1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFH?=
 =?us-ascii?Q?TUFhQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBREFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWVFCekFHMEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QmpBSEFBY0FBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNn?=
 =?us-ascii?Q?QmpBR1VBWXdCdkFHUUFaUUJmQUdNQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFB?=
 =?us-ascii?Q?QUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFGOEFaZ0J2QUhJQWRBQnlBR0VBYmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCcUFHRUFkZ0Jo?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4?=
 =?us-ascii?Q?QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBeEFFQUFBQUFBQUFJQUFBQUFBQUFBQWdB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQ2tBUUFBQ2dBQUFESUFBQUFBQUFBQVl3QmhB?=
 =?us-ascii?Q?R1FBWlFCdUFHTUFaUUJmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlR?=
 =?us-ascii?Q?QnNBQUFBTEFBQUFBQUFBQUJqQUdRQWJnQmZBSFlBYUFCa0FHd0FYd0JyQUdV?=
 =?us-ascii?Q?QWVRQjNBRzhBY2dCa0FITUFBQUFrQUFBQUF3QUFBR01BYndCdUFIUUFaUUJ1?=
 =?us-ascii?Q?QUhRQVh3QnRBR0VBZEFCakFHZ0FBQUFtQUFBQUFBQUFBSE1BYndCMUFISUFZ?=
 =?us-ascii?Q?d0JsQUdNQWJ3QmtBR1VBWHdCaEFITUFiUUFBQUNZQUFBQUFBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHTUFjQUJ3QUFBQUpBQUFBQUFBQUFC?=
 =?us-ascii?Q?ekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J6QUFBQUxnQUFBQUFB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFaZ0J2QUhJQWRBQnlB?=
 =?us-ascii?Q?R0VBYmdBQUFDZ0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpR?=
 =?us-ascii?Q?QmZBR29BWVFCMkFHRUFBQUFzQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdN?=
 =?us-ascii?Q?QWJ3QmtBR1VBWHdCd0FIa0FkQUJvQUc4QWJnQUFBQ2dBQUFBQUFBQUFjd0J2?=
 =?us-ascii?Q?QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhJQWRRQmlBSGtBQUFBPSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|PH0PR07MB10613:EE_
x-ms-office365-filtering-correlation-id: 935b4cdb-b096-4d3e-30e8-08dd4c18f39a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KJRaOXFzrHI/K/NTCQbnXC0oaPRpKI7oS5ZO1AXiqu8Vnng2R3revGSJcP6j?=
 =?us-ascii?Q?SuzXSIfJ+/mwkE2lTHnCuzTHIdrgp4FZzLqdwtbN5v+UcvlmXPrmi990EbuO?=
 =?us-ascii?Q?kGR/NaayxRwA4fuR2A81PE2NKi0IB3aNsiixPP0dmp/HUzFNiFzrqjaBrJxw?=
 =?us-ascii?Q?z3veGHJXyzPA6y8GFpU2nvFqwv7tQgTxKIlRNNi+22HkgboqbAnrXROGJQt+?=
 =?us-ascii?Q?h4Aj39r1yur8QneBIJDvW5Fk/UYFQc9TMunZa4imRGU+0wAOyAmHZ9gOzHfk?=
 =?us-ascii?Q?GFH+ApbKrVl1mz6HYXbwLvhcIbvH/rOfpsKpWXdgSLcsQzu7OiMU5NXpURy1?=
 =?us-ascii?Q?4aLDK16Nm/dmusPGgF19emQQvuYGdnut/HEhsOdweK40Ou3Z8GDn1p3ru1PS?=
 =?us-ascii?Q?sBRlPuRpqgaGzkT4b8PUnBc4Z0QY2KTVB7vQvd32kruYLmfGhl98vurOgMBJ?=
 =?us-ascii?Q?Vc5AbzESgZxKM3Hv4Pko571MthIunftHmk2fKEMTc2PCK27dRruKZGxdA85i?=
 =?us-ascii?Q?Zmly0SvzvjNIB4bv2UcoRVzxKZG4/D5cpecR4sCrjFQkUuYCtFxUTEXjVJ/D?=
 =?us-ascii?Q?oBPYIva+oBsnFX1NKMO5KVALXPxr0uCgtsjbz/VnpqYBC1KlohLrA+I2dQtA?=
 =?us-ascii?Q?LNhFhdoIlpQ2K4yPSGOikuGhFWBf+qRLoowUo1owIpL9ayQseX61Ydh/510l?=
 =?us-ascii?Q?mrnJEBuRvEJ22liiQea5E05mNeZ8Jw5REq+hvC+xFSudkBn74FCKOfm5RDZS?=
 =?us-ascii?Q?VR9tVsP0t4Fx54jlpCKUBvdM4kjkFfRA30pW/CTb4pHDQlHmZ4TZW4vJsFIV?=
 =?us-ascii?Q?xMiB7FEEvOqsiNqYrIcqx38l9WlHOaTcYn3hr5mmux8X/3pZWeImO/IAyGQL?=
 =?us-ascii?Q?aGme1P7C+PHphWRT8H+wFwE5U7AXUiLnFtTzMwwZavYfERtUc8gqZg+BEuEJ?=
 =?us-ascii?Q?6bViSnwpGABxNCf8HczxveG62eERzPEE3rNEguWnrXjiTGOcFT9khRKr3G6F?=
 =?us-ascii?Q?OHYAQTFLnChD72616VJkP60/71cNDKINV5/wOQJTb/28zCSo+tIvXahqDyw8?=
 =?us-ascii?Q?V79j0JWfioxQZj2QPYK+JTxzY+WbCtalNcDV5av7WtjrQkao6FYWyO6fdErw?=
 =?us-ascii?Q?CqA2pQX5XBlAwg0ma/q9df+xqLC589hC2mn8pRTpfB84YpN40bcoj3D5A4wT?=
 =?us-ascii?Q?DZ5aR2ED/Wa/gVJm/WJZOpeuoUj09q6YtEKsG3NPCX1uoU0XELAvXV0Js1QM?=
 =?us-ascii?Q?GDn1bix9io0Ve2NYRbHuEX9LdPYvpLTdAJbsfMgDTyOaLR4bkVXjkLnmTJdR?=
 =?us-ascii?Q?xwx63JNovTSPg4d9g9uRA9ZcIpclcOo4JyZ8/MEBx5iG/1RGASxDlLt6KAwd?=
 =?us-ascii?Q?aqAjEPgZb5VfdhMBGsnDWJ6vaL/1I+ZSziKErVFLBFUqpEWknLjvJfj8dDY0?=
 =?us-ascii?Q?Gk+CynUCdTzKEzPEehBUyyYb+g6A2NSn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N+sRoNAm6xjvCMX8wOsVF1xTkaME6sygzuwb/9G3rKMA+Ml867YmSSy4a96t?=
 =?us-ascii?Q?K6G4a8mgZRYwOLPxQyhrA0RZP2uwPv+slWnD34J/siP8mbQISC2iKQE1fF9O?=
 =?us-ascii?Q?/KhVPbiJG3MMn7xiT52czlIuqjbeOkyAKyHd1y8JtGyPyjTtmqrlhlhjwMoa?=
 =?us-ascii?Q?bfmLWCrJfF4Z/Y9GlVMRYsyqOGfMnJkC6sXQvedQtc4HtBi//Hkm0KRrz0tR?=
 =?us-ascii?Q?bHWy+fddgEYjInvjdWDte3JzVk3C5lIslUzE6NutLcJhgugNgB87MJcVeQVg?=
 =?us-ascii?Q?ZSZJyHVIqOPTNzM9d40VN4hLIcUMIP/sTAslDKDzEF9q0Gdg2uQUKxnXx57b?=
 =?us-ascii?Q?BV0FNk9ID0tHsM3kodAlVHe6X0mqKfSoSsn0HEsepqc3oJZVTvLH6G+thQ1c?=
 =?us-ascii?Q?ADFw8R4zXOdJRkDOaM9goZaYxX3c9/4vprytB1Q8Ti0O4KnP8ch8NhmVa9kF?=
 =?us-ascii?Q?7Jf2wDdC7jBFuadmv5d9MIZvEFhDFTPdzUIyBbDah80X0dkq+RIIod13wLXZ?=
 =?us-ascii?Q?vxyIN5hSFeAo4xBHHgjoq2lhW1WHknzUHI6Km7uMk3xGiVYmRT4oeWeP+NwZ?=
 =?us-ascii?Q?OsZe3Yl6uFsQI397n86kC3pSY7CV6mRcMJuY6zlm7gw0R6w8crFThZWadbP7?=
 =?us-ascii?Q?Y1rEMcAnYBPKMNoOIgs6TTZY//qEfO58mYN/WfcNurXB4yO1oCsXYAlRoSoQ?=
 =?us-ascii?Q?/yZqaZuLC1y54sDuzD6fzeLjVO4SUM9EAWiZFtT8B7vZ8L4s743HG19FgtPN?=
 =?us-ascii?Q?XhMaDcEd85sINa2QQHD7+3+efeyv1AX2CRXbucRed2GcAlsGMVINqjtm7L7b?=
 =?us-ascii?Q?z6axXfr3vjVte/3ArsbSka39FCZ34ZirrvFEnDFNQv8LWDhcTgKzOJCXwiWL?=
 =?us-ascii?Q?IWHffCILu3FB4M6Im0OKrVZRD7xzEbp5GIgNZ1dc+MDfKUrW2aVBG+Zgp2W5?=
 =?us-ascii?Q?chaNafK6p9CjKlDTsodFCfGx4EPH02gVuYvtMLo3zQPeIiPT2PvH/wyxAfpq?=
 =?us-ascii?Q?RYgZXEG89oVSsWsIyzekXAs53bHUa3RHGmH+xu0lw42K01ZUt2dLZ0DOBYZ8?=
 =?us-ascii?Q?7sC6Zh+M71MoQ/Z6+uo+8Mh5+7Vsyp98YKW2YVQFZDuGs7QBXwcZiXXn47lL?=
 =?us-ascii?Q?IiolfluS5QB9+UfVEqvwKasbqrbQ5dA/kS1SXBMPNySTvSXnJmz+Er+JNNON?=
 =?us-ascii?Q?2LamdRrtE4RgAfXmfbHhB89MXV0qeZcnsLSm73J0p27btYNJaHUpIX12xUwf?=
 =?us-ascii?Q?wcSfzxDaNlkp6bC92y0+WdwjZHsdy0ITnfXvmkWf3ox9tNEEV64NOR/om2Gu?=
 =?us-ascii?Q?6WQAoS+3ATceZyeEvyTgm9sIb8AjEdciQBnW8KfyXHTUozzrNPMSIkLbfwUV?=
 =?us-ascii?Q?W1Hz8ApNyHELpIsC3q9NB7x8OWhuFjJD1dK+8xlh3lInDvNm9Ke0H3kdjnQc?=
 =?us-ascii?Q?lV4+8A5JPstasVSDhSGmihhs/OJCHGMe+81D2km4bqkXg4ukUBz1CHbs+DIa?=
 =?us-ascii?Q?EGNUD0npdD7cyIKhgTtRLO8BmRUq4nyAmnjGcr236qm9mxcvtjQXt3keZqdv?=
 =?us-ascii?Q?FJ2hYoV4OoiMQa4Cpsm3d11qeOnD86hJ6hcXr3ir?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935b4cdb-b096-4d3e-30e8-08dd4c18f39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:27:00.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGM2UAo6W4FggnvXOXV5D8z5YUF5yfyeB9LCyIOUq5yLaJ29kGUuNT/4jHJwHnfns1RH6JuIA+ETSrtZd5pw8jTBleb+vZcbNXMWuy4bnY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB10613
X-Authority-Analysis: v=2.4 cv=F4utdrhN c=1 sm=1 tr=0 ts=67adc8f7 cx=c_pps a=sf1zYAMyThzbrKU8SMWnlQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=POOdd56icRyTAiQudxAA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: DCbqKc6R8TPBAGndNQdbXd9DjGGvoS_q
X-Proofpoint-ORIG-GUID: DCbqKc6R8TPBAGndNQdbXd9DjGGvoS_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxlogscore=932 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130079

The xHC resources allocated for USB devices are not released in correct ord=
er after resuming in case when while suspend device was reconnected.

This issue has been detected during the fallowing scenario:
- connect hub HS to root port
- connect LS/FS device to hub port
- wait for enumeration to finish
- force DUT to suspend
- reconnect hub attached to root port
- wake DUT

For this scenario during enumeration of USB LS/FS device the Cadence xHC re=
ports completion error code for xHCi commands because the devices was not p=
roperty disconnected and in result the xHC resources has not been correct f=
reed.
XHCI specification doesn't mention that device can be reset in any order so=
, we should not treat this issue as Cadence xHC controller bug.
Similar as during disconnecting in this case the device should be cleared s=
tarting form the last usb device in tree toward the root hub.
To fix this issue usbcore driver should disconnect all USB devices connecte=
d to hub which was reconnected while suspending.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/core/hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index 0cd44f1f=
d56d..2473cbf317a8 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3627,10 +3627,12 @@ static int finish_port_resume(struct usb_device *ud=
ev)
 		 * the device will be rediscovered.
 		 */
  retry_reset_resume:
-		if (udev->quirks & USB_QUIRK_RESET)
+		if (udev->quirks & USB_QUIRK_RESET) {
 			status =3D -ENODEV;
-		else
+		} else {
+			hub_disconnect_children(udev);
 			status =3D usb_reset_and_verify_device(udev);
+		}
 	}
=20
 	/* 10.5.4.5 says be sure devices in the tree are still there.
--
2.43.0


