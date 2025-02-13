Return-Path: <stable+bounces-115119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A9A33CF7
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F83A659F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38621324D;
	Thu, 13 Feb 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mB7Km84c";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wPYjK81G"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0041C6A;
	Thu, 13 Feb 2025 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443826; cv=fail; b=CXvQs6fLgEgb+7iyBUwb0x+fWnpocOagQivvQVJ3HgBk3pWM4WETzOc6s9bfZL/RoK3lq06inOtBlUe/PQAVO0ZUAPpqEW2N+2sFegdukUVAuXMT/DSusKUjHzxGcZzY1qH2aa80mzwjIGjEsvMofJQjCx31I7/YZVKfdKLWJTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443826; c=relaxed/simple;
	bh=5erAhJ+B2DwhUEvkUhlTGHjRCt9YW3dqXIEX4Wg7+lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxrVtTm/TLnNGH6qWzhXie3FkXH7nvXlJi7N+zdNLQuaidjOqRLBEuglqgRHwTJYR+Zpmd037NYQi6+wB/QkHBA7jH7GOvX51/n9wjPZ21o3qXtoled4zwrfpGnlZFQOwnmQjFoWMetFxcMleMIcgpN51VXJUVdnr9KFXWZAUYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=mB7Km84c; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=wPYjK81G; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D62loZ009026;
	Thu, 13 Feb 2025 02:50:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=n7FBmbuX1ckAZMHA+yQ9pJm89W5z57XvuW4J0XECOFA=; b=mB7Km84cYbN2
	OkfwdXTwCX5t6IR0HA/HdDZ6aINkh8Z0x+kH2tA8uWsMca/KXJyzNyhrT9KeOwYj
	rh7a9dNeYaMuf7tEuQLb4Z9ej5UNb0RCfE1G1nrmT4q6W7uqWQFv9Twgj+WxBOP1
	R8DfYqp0xg+9H+sixqTI1cM4wZJrwBIG739RFkCmvx542Kf9urr03v4jhHm34pIc
	doEh4846vJ6OXEOweygLSneY1N2mEu/ju3irdIiCnE0AGFW6KqhbjKZVeMNPubXi
	X3DPRK3cn0rcdOHje172HFy8Q5pi6uqmO/Z7dHVrziau3j6cujnq1U0S4JTVRXvw
	TWoGkz9UBw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44sb4gh27x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 02:50:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtqJ4LPkZOVfMP2H8d1GMXlRyFjgt8qZg134W8Tn+WbIlBuzAkLrgNvN13hr9hC7iaCeSrjXYx00E1Z9tuyLPkrMmjkPC1twoyT9yqV1D+LBnX/EMatjlCnSPR7FMTOpCD/u1j3RSweq+PrPBxzsXpuawV9Luesy0lFSoWFcwpsQ7jcClzDGRnEzSIv8vWw2zxCnUNZAnaabSQqDv2GiawQHvvGaCURNJcz+4BOAweA1s2L3/yXXMuA9ZXHOFCOXj0j3b7W/Ksec7TNzqMfe99ElMrUlmVRo6PjENIqZ4sfSQPBPwmL21l8YpT75JgHi4Ca3cArcYQG1quJEIuE2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7FBmbuX1ckAZMHA+yQ9pJm89W5z57XvuW4J0XECOFA=;
 b=uIHLuCu6ANN6GJSZvh4sCjrahntn9vW88/9XNKKcwlwGIPzBTNVwOl6gIBIEs90ZJXsZ1xbemkgnHjsAU+Nf5wbapLdQnVq5+i2KMSZ0YUPX1y57bvPY2fi36m9qVIpdNsx16w2GsrUA0hT8UdT5f/SlikYw/1D6PPi5RUgMnlAytlLQXv9wkMP+clzwzCvFZtyqz2zLIRljpinhQ8VwDk1RAl1Yr7Z45pKVmncctWbhba9+Zdbx92R8X7mhzI0qVoNm0Iy9JZug38CkzKDaquDtoAhKOp9ZLFu0kRxeBAWJjXQzkZLCcC2g01UfzkX0bcx6aRpaFtZ5ToefEmLJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7FBmbuX1ckAZMHA+yQ9pJm89W5z57XvuW4J0XECOFA=;
 b=wPYjK81GuImcm8Ou8dcvpX1Vi02k+N8Oi+4/b4To8zvf/b8joz9ryvOOdabapkIbW9P1IiQpUEqbhkJoHBf9lfXY1sT9xG76UnLRMkP5n0W+wjI6dcjGFNKN+um40fHNQ56UMKGWf6yvtIrkrlbRdshGv4/UOZKREKC1EcoyVzc=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by LV8PR07MB10116.namprd07.prod.outlook.com (2603:10b6:408:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:50:14 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:50:14 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com" <make_ruc2021@163.com>,
        "peter.chen@nxp.com"
	<peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Eichler <peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbff/PyNY2z2E4uEeZXCoyn0/C0LNFA7/AgAAGEwCAAAN6AA==
Date: Thu, 13 Feb 2025 10:50:14 +0000
Message-ID:
 <PH7PR07MB95380723CF45FA2204933E70DDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <2025021359-culture-wow-55d5@gregkh>
In-Reply-To: <2025021359-culture-wow-55d5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTRjYTdjNzc5LWU5ZjgtMTFlZi1hOGNh?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFw0Y2E3Yzc3Yi1lOWY4LTExZWYtYThj?=
 =?us-ascii?Q?YS0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9IjU0MDIiIHQ9IjEzMzgzOTE3?=
 =?us-ascii?Q?NDEyOTA4NTg3MSIgaD0ieUNHd1NoU1V6cFdHZllleC9tekUzZVY1UmVjPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFDdjdmNE9CWDdiQVRyZTRtM1hYM0VoT3Q3aWJkZGZjU0VLQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQ0FBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
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
 =?us-ascii?Q?QWVRQjNBRzhBY2dCa0FITUFBQUFrQUFBQUFnQUFBR01BYndCdUFIUUFaUUJ1?=
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
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|LV8PR07MB10116:EE_
x-ms-office365-filtering-correlation-id: caa3fd70-b11b-4969-40b0-08dd4c1c3254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0FBoSv5LIysqgz+6iVCVY7QkDU/fCX53ttt/MbohEdyYXBnG+YTIiGkOnWWr?=
 =?us-ascii?Q?y7CvAaRyAoUAOfWP/NTVMBKyC4GEDY/O9Kv0LYTOSo746HU4BPYm7Txpx2Ih?=
 =?us-ascii?Q?y/AKH3/Bh2qx9Vxqu2O0qIZDvBBkpw8zH9L/B1peIKRp5XiWe4AWIgUBYutg?=
 =?us-ascii?Q?ALO/M+5QGzayUHZWZm0lR90AbAw2I00a+RxkPv+ELAtlAPTBJE0Bz3TEhzHV?=
 =?us-ascii?Q?IyzBt+RUkHLWKxXd7wPM3ixUkoy74ksphWDvdKFOMLJPuaIMq9CdJprL899D?=
 =?us-ascii?Q?uT76wwfsMn6P23KDy4cHnFzjZS6xxGhdT5d4+PeK4DE5skTHJbmuFAwgcuQg?=
 =?us-ascii?Q?2ZZL58FcTIrgnLY2sycJKK6TgCNfEjjde3JgcrchqO1oaVodbTyRV+aadUgD?=
 =?us-ascii?Q?fnTVIh245sJ7908rVwxWrwFUNU7gNxRBeU7qX4i9F6qv9if6a7R4V9l+kiwg?=
 =?us-ascii?Q?3CWsWQv+8gFALi/aVYLgvs6xCyaPfZTg4UB9qA48gNkYed/ETIhZjY6pOFzT?=
 =?us-ascii?Q?1GnUX8pQv5TywhC82xfUoupp3Au+DmF9yzOGTeKBRqqnSA1hrLIlMWzuonbf?=
 =?us-ascii?Q?66sMG7kAwShjeL6bxy6C8Er8aQgTQ1iLh8UCglCwU6YWgYk18157d3M9VNP9?=
 =?us-ascii?Q?wASoC4v15sFA+/kCSq6iLQj8Sq/FZ0asn1aaZqlVJqR3r06waOw1U3X28jpf?=
 =?us-ascii?Q?GUB9pPWlQdHX+ohGZbznnAl67t5MAcROF+6CO9EWqtzVLA+hcu3sjjpCJrPy?=
 =?us-ascii?Q?j47A1b/cWSR+ubXPZ7NAGi40YEsNPFEdCjVMvgcVUuDr4iZ0eg5zz7q7du/m?=
 =?us-ascii?Q?2/DEzx1YwIzscFbcXqKOg/HY06eF8I1WQBLl1f2fwKUqtItk9t3t+arAjus8?=
 =?us-ascii?Q?qHDYBDlurdPPrhs1lkKw1SgNNBPL1SyoX2AJTmFYr55NaDmCdx/+fUhP5uQl?=
 =?us-ascii?Q?d00Hl85HUa0ewYFpDuCHEnKmIGZD83qbD5JQ+6PMbXfYdcSLYF4SX0/aLUBd?=
 =?us-ascii?Q?V3JbxzDPYvW8MFTrdpGMTTTITYqilWZZO52CqD5QETgYnY82up+bmT8kUQwf?=
 =?us-ascii?Q?yQu9Wweqvs99lOuouujVb6YFltAW1egFV3gUW/ZNHyKFWRFcGNd/N01aaVWQ?=
 =?us-ascii?Q?KraJgeX+scopIP7CnPPS5jn4LEjnAvc8X2DSMy7UecvzQjipahtw0zs5+sYU?=
 =?us-ascii?Q?UwO5qNGmVBWi9JoLfDnPhspc3CXACIaJAlxxQjTxcHDNzYIdny0Qq8BOjEre?=
 =?us-ascii?Q?CW7ejVM9pA+P6DajRcDAdjmlJgHJ+mCpH80+SXjyiouqZiubxf2LX5qKi5kw?=
 =?us-ascii?Q?P102DCrj68ppEoLdxj0C12u0RrXQbijM1piG800YRlQ4cJJTHm/A9Jo5cpmS?=
 =?us-ascii?Q?47Y+5T9VTl5HaC0va8diMy0EgMviQParntxl2rJR7GDIz5l6CUdNf0LROG1z?=
 =?us-ascii?Q?Ua+np5s1LteFX5bvwIR4+TvPihb9837Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7JtwJen0A7xQ7hzl3PUtBMGQZDgeRIb7BJnbAXbbiRa0EEoMHpsBTpUU3Ssv?=
 =?us-ascii?Q?0yr4WI8zCmYFSDdiVYiMJe89eLRfRh/joJxHUpERnFJlg/1tIpRpq4K6/jof?=
 =?us-ascii?Q?MgXHbmlL+4xtdRr0gQsGH2wpQv6YWq1KtdOWvY3UTKFVj4mwN/BGr9JFHUeN?=
 =?us-ascii?Q?TfwfdjlzOnTWbKy72vXZvkqDSRV90/WJgdKwYaYn5ykqjce0A2+k+4vWnacT?=
 =?us-ascii?Q?uBy7Kd/TUsdoPRR6v1aQOwqPzLDEEQgWN2YJzpoK1VQMp4dHHSAG7D8QMfAg?=
 =?us-ascii?Q?U+Zggpbw82f6AEgZa/ldjhk4D80fKGdxuNzkS0arjIvvbbra8y16UZ3c0h0q?=
 =?us-ascii?Q?uh9ingB4TBIGFITMSFutsXvr6lEmcJeCpa7VHOqEsQXwtSKrkOvJahFFwVrm?=
 =?us-ascii?Q?hqu+WdK8Btz3tFzaR7cLBjebP2jnAIZgVtkPLQrnm0KmuHjIK1fWkHXFp72W?=
 =?us-ascii?Q?f40dryaVe3enni1LTQ8D/V77/S0vCDdNzjEtnvGvXR0NH6opfGlh4HSTniAu?=
 =?us-ascii?Q?sfwqebWXN1Q/V974eYE8pRlF3Bq/uE+yQzxdGqdI11Z6ENVYNZF3JZEYoD9o?=
 =?us-ascii?Q?orcf+AvH152ohMIBFmRi4hjyf1UPulit6FrvHtltZNsCRjs4QGsukSCRzIvc?=
 =?us-ascii?Q?KdqKgGcaXQ0+gXELUUOW7lxaDe+fBIxqDUJbq2e+CKc3ZqnvS5FgCVTRbZL5?=
 =?us-ascii?Q?jwdHvOHdbKGqZzq+VaBgGZJck4gi2tnamvVLvypaPeLjht3/e+yDz1Y1R2gQ?=
 =?us-ascii?Q?8Cudl49uRnq227FOszQzn0k5aDKbnCHaSVsAr+pUoTGQBCjt0/6ApEMtjwn+?=
 =?us-ascii?Q?rI2oZctvR8axJHlLL9Udspz06aAPAjqvAYmSO2k9BrLe6qLy1mXFiSKS/ReP?=
 =?us-ascii?Q?vOhdjZ81Z37LIGbwCMFo9IHmrN13dJVxf1HpNXvpeVC5JSkEs7sS/G6Qazx3?=
 =?us-ascii?Q?rx4dkueoUvX78bsA1lbZ9uKv6/slN0u1/5EpZWCeeF2hq2MzntEvWFA7LKDV?=
 =?us-ascii?Q?ifbTzbzRLsfoFOTXiEBbKsgIulsSx84Dy36CkA3X3K/2QQgmcysLNAl7TwxH?=
 =?us-ascii?Q?c8XDzWrDrpCtoCqzHns/AAm1AIeMGiOeoVqn91nUoEfFc5CjhTcmSx4QwnJp?=
 =?us-ascii?Q?QbUF5iBN6zD9Z0iMTLxj6IpWrzafjYXZoEMzXXAcknNPLLS3bOd4Mv5h6Lk0?=
 =?us-ascii?Q?3cx1ecS+BI9l7paGdbte50qenDLx/veEYXoQsG+WOd5bb5oRPpYJToaYfF95?=
 =?us-ascii?Q?7IW/678w0q8XXqdKggVFqUichQHN9D9FhpeT5H5geWLcjB2GcZSkAc8xMCJB?=
 =?us-ascii?Q?0aOFoDSwlzjfGUlFeS7PUv9qVozMs40p4g18nsXPMhPGwYtVSujlAybEuug6?=
 =?us-ascii?Q?+I6yoVN7XADEj0lGNzVgnWiGIsUeS5244O5SGsLG1LljdWNuAuu7IV6SEmW9?=
 =?us-ascii?Q?UDwdtr4fCjuezb9RDmGomXAOH2AeI1IEj6+VZftg3LfYeRO0JQuXzydAS3rr?=
 =?us-ascii?Q?09XaWQOGE1YX9cyf9rwFyoxE2MF8SleYkQa4E4bzc8qCygVVKb13b2F2XYpL?=
 =?us-ascii?Q?W2u+0HJGgLy04/Rj9prxYOimGbYhD0/xX/XPKD0B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caa3fd70-b11b-4969-40b0-08dd4c1c3254
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:50:14.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtCcEzXC0hLegOArhz/xxO++0vTw9FX5SxqFwm+It2PKxgH8Rpb7JVvZxr24saO3xFinI+359MU3QsXMTpvVzbbJtVLPUPGVdQ/Ny18tkCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR07MB10116
X-Authority-Analysis: v=2.4 cv=F4utdrhN c=1 sm=1 tr=0 ts=67adce68 cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=n2JghVlFKD1b0aMMoRMA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: RZkf-qfYXG9mE0sqgXt8YF5IXHH_IZ5Q
X-Proofpoint-ORIG-GUID: RZkf-qfYXG9mE0sqgXt8YF5IXHH_IZ5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxlogscore=987 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130083

Sorry about that.=20

I've checked it with checkpatch.pl but I had to forward patch from Outlook.
It reformatted the email.

I sent it again.

Regards,
Pawel

>
>On Thu, Feb 13, 2025 at 10:27:00AM +0000, Pawel Laszczak wrote:
>> The xHC resources allocated for USB devices are not released in correct =
order
>after resuming in case when while suspend device was reconnected.
>
>Please wrap your changelog text properly, checkpatch.pl should have
>caught this, did you forget to run it?
>
>>
>> This issue has been detected during the fallowing scenario:
>> - connect hub HS to root port
>> - connect LS/FS device to hub port
>> - wait for enumeration to finish
>> - force DUT to suspend
>> - reconnect hub attached to root port
>> - wake DUT
>>
>> For this scenario during enumeration of USB LS/FS device the Cadence xHC
>reports completion error code for xHCi commands because the devices was no=
t
>property disconnected and in result the xHC resources has not been correct
>freed.
>> XHCI specification doesn't mention that device can be reset in any order=
 so,
>we should not treat this issue as Cadence xHC controller bug.
>
>But if it operates unlike all other xhci controllers, isn't that a bug
>on its side?
>
>> Similar as during disconnecting in this case the device should be cleare=
d
>starting form the last usb device in tree toward the root hub.
>> To fix this issue usbcore driver should disconnect all USB devices conne=
cted
>to hub which was reconnected while suspending.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP
>DRD Driver")
>> cc: <stable@vger.kernel.org>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/core/hub.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
>0cd44f1fd56d..2473cbf317a8 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -3627,10 +3627,12 @@ static int finish_port_resume(struct usb_device
>*udev)
>>  		 * the device will be rediscovered.
>>  		 */
>>   retry_reset_resume:
>> -		if (udev->quirks & USB_QUIRK_RESET)
>> +		if (udev->quirks & USB_QUIRK_RESET) {
>>  			status =3D -ENODEV;
>> -		else
>> +		} else {
>> +			hub_disconnect_children(udev);
>
>This feels odd, and will hit more than just xhci controllers, right?
>You aren't really disconnecting the hub, only resetting it (well the
>logical disconnect will cause a real disconnect later on, so this should
>be called from that code path, right?
>
>thanks,
>
>greg k-h

