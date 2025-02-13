Return-Path: <stable+bounces-115129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75769A33F11
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5113A2B0B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D621D3F2;
	Thu, 13 Feb 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BNdYbeFR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MdskIMaP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDE227EB4;
	Thu, 13 Feb 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449558; cv=fail; b=Pp41Q3F7v7fcm+uMUxtCh5VKtGdSHzrr3xsmlOdbppyp304/Fjv0rBl2WLpk8LETCFWPwDEy1OmrfNc3QrywjjDuTUFcFQBQU4lnPzCQCmFBROw0kGMQfKHHf7wNtzbW3gzAhEXEOkWYHIhii1NyIJhSdA1YggdR0MqjoZ9zER8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449558; c=relaxed/simple;
	bh=JzXOEJqsdcdTpazbv9sGVvSatQ4dVpZxvBP9wMDkgVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUxPjLC984L++Ad3MK3EeTvzXELh+ZMD4u4CEHlG8ajSepdytvBtLqI/fUXzSNSRYAEaW6T8+bLrFgAWu7oitQjzlkQvmhUQD9DwTyUSRZT8aOJy/RJ+frUz+ezVRg2Qfp5FVR5ju9KGtT50J9nSD8/TJGXuKbgfPRY+/nZDsZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=BNdYbeFR; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=MdskIMaP; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D5VnSo016674;
	Thu, 13 Feb 2025 02:46:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=TbkolBrM/xcZSM1FaLd79ghjVY9pubj4VyDFB1rChnM=; b=BNdYbeFRL52p
	YQWb1v6R6ITeE2zGSczd3sfFM38kKJW9qTyhu7HboBvoMVUA9Ast+qHQ5pRqLmYb
	kDeZHnJ29DiFXE/4UtNNs96kLS0dCkr4sQhc2CTNPPDKjevfuo84Vg97zOMFfkqa
	3Pqwe9SbiH9c8wSV8KqD1Bf7Ufqp6tiqhod0oUoad3kADYP9QaLnAhK5sU0ZnzBE
	IvHwJ+P/LBPmJz53rJKUGU7vp6XqhujoG/j1HoBTbc5saEoJz10DDzmoCsdWzHR8
	MsVIV5yYitGfSCpD27Xydzm6yWVXn2ootlQDK805Vbh6DIfsBMd/UQYwrNDBckyR
	FDScdhHVDw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 44p4q1y066-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 02:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0JqS2s0Z8KAA75QzSBry+kIz7YYRTP/L9rIVsYcsy5ahvCV1jafeZuIWQt0DS2TOmI/Hne0fz5ggIsPNK/ebn85iH7B2z0QB+ZhoBYr1nXbROBP9JCKRcVYIbuT7IB6/hd8fjUcsRpyk4MgDom2zHL4F3zu/xjYD5aBM5G4mQW+OX6PrSeasLTP1i/ETeySfqzvr2J5+2vLEpZcy5lQpwR0Z1J0VaxKWwqYh28ykq1bty2ysMHe6D8jIBJzIwj9NGI0ctLnHLcAAjDOKE35e6hnvZzvdNqqx1TTgteZ54vzWQiObfw6r0i9uxJbX6AfiVEPOzMtj6zc+TjJM0v2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbkolBrM/xcZSM1FaLd79ghjVY9pubj4VyDFB1rChnM=;
 b=fQ4RoSwub+nb3E3c/ILNk+SzP3SoDHwBrhARefKYGQUgW8Wu5z8Fa8A0AlBxZ5gnA11X6fHdIvJGKvXSV7GcTcvbPJ00PHF7pPFU7PsozYf+UAink+Ut8+HY8i2HHcQWQuLDImBd48VOdmAMoFhunB5OuvP0W9zXF/HoYtwQ9kmysOHmCkOZ75zTGC9mWCDFphp6NmLipuzA6mU3w7xFwt3jOOPrFuluaCvx1imcoHfKvSjz0PJSflI5BwOiCza3KfyqacwKGYbBXQXRCmPYM9zw2f+JXVuvUmDUd7FtxabdRK1tsRPJsepOXitnwbAMSeRqg1CUSpbIHV5ckDGe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbkolBrM/xcZSM1FaLd79ghjVY9pubj4VyDFB1rChnM=;
 b=MdskIMaPyo2YgQKMFQ4aH+VnHJiUFVc7jar3/3YLzAbcO4QeT54H73V4f+3iekIqmwKsOWKbfA/gFnlX29GT7WwatEGZAp84dwcYnxKwv19ZA24b7w+Gd6yVk9TBODCSqvgjOw9tsOlmrUn5hpMb+dQbroiQEmsjLEiGDqjCaSc=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by LV8PR07MB10116.namprd07.prod.outlook.com (2603:10b6:408:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:46:07 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:46:07 +0000
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
Subject: FW: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbff/PyNY2z2E4uEeZXCoyn0/C0LNFDHGQ
Date: Thu, 13 Feb 2025 10:46:06 +0000
Message-ID:
 <PH7PR07MB9538F08AF8B1D7FF5070DA76DDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250213101158.8153-1-pawell@cadence.com>
In-Reply-To: <20250213101158.8153-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWI4ZDIyYjRkLWU5ZjctMTFlZi1hOGNh?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFxiOGQyMmI0Zi1lOWY3LTExZWYtYThj?=
 =?us-ascii?Q?YS0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9IjM5OTQiIHQ9IjEzMzgzOTE3?=
 =?us-ascii?Q?MTY0ODg2NjkwNiIgaD0iNjJmbGdpTFE3amltZ1JQSFFhRVErQmV6V3UwPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFCYXlpbDdCSDdiQVEvZ1EwQS9TNlN6RCtCRFFEOUxwTE1LQUFBQUFB?=
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
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|LV8PR07MB10116:EE_
x-ms-office365-filtering-correlation-id: 3634c4bc-75ec-46d9-ce62-08dd4c1b9edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m0y9l27T9sIUzdA3gaD4BgU3iN3uKAz+PjN5ENH/UoeWuWUp5/VHJXYrbCzM?=
 =?us-ascii?Q?Aa9pDk2loI0obp12bv4B8qD1pzbhwI56sxoJViNznor+5j803r9CiSABCenJ?=
 =?us-ascii?Q?c7M3EyF+HKaqcbDpEb9OZf6wHTGpfRjH7iCzLJ90pYlokf7udu4shTqGE1Z7?=
 =?us-ascii?Q?4nHt2iPMHYQW9POWenvmPe4fGmAUE2ZPX2zYH62EbOmE5u6uLkscVEFvABya?=
 =?us-ascii?Q?2zcHYPkFHobg0gNOa1wf5s/aIWr2J94B9qfIyPs10KYBcI+2GfVIVdHEoTvM?=
 =?us-ascii?Q?sDc6uqFr0ZNOJRFh8Cw3lm95VvogiZeLuGQVVzEnzl8HBpxX2M03E8pCHH+l?=
 =?us-ascii?Q?ZKHiXq5CqOe9UnDdDlnYlf2iLIhtfcNzfez/zjxYonNBDimPT8CyqStk6QaJ?=
 =?us-ascii?Q?9FXqDg/bQi40HJYc6VMwfzdS5b1kaaQhwt+7Zs2nl0bZFjbJj/YhFIOzePNf?=
 =?us-ascii?Q?/p6qQXvnU9980EXOr5p5+jJmUSijySsdVWGmbLCidDxQjhHDdS0UTnV3InRu?=
 =?us-ascii?Q?FlOO4PbWc5MTqpEupUbljbJBF3DQIlYlNH5uwdhwXlgS/nmlaRZbEizdkdAq?=
 =?us-ascii?Q?w3w+4vCR6gkg9woTMZPaR8dmYbhHBAbY1tAqvDCbYmsfYk6IHwjKTQyVTWCU?=
 =?us-ascii?Q?z14GF1ipDEImmwvAJbJIs7RZ0/ONZAbqAIvTNGnZlY7oIW88BbabXa/JgYv6?=
 =?us-ascii?Q?ZULhA1BhJqJWjqeph7D6jlIFJK9AqGmscreka1ilhupijRSyKxUUevXA7aAq?=
 =?us-ascii?Q?Td4iYVn1q08M3y1AT9Sd7o4LsPigvfJt0Y/BfIHHGUPm+zpD/lpdxftAXJrD?=
 =?us-ascii?Q?94TZgUt6SA5YpRKCj0p2t+SpRzP8BWc+nvEKArw24DfBdamyqKGwJyPzDalk?=
 =?us-ascii?Q?7IfzR2NPUttJvAbW6W1REEtum29h+pg96pGYMEx03tjSpy3OI6zN7rPObwr/?=
 =?us-ascii?Q?G/G44mW4UQdmVpnSTDzfJhA+ywgOsHnOJYjzyuwUiVrLR+T/HBElMjmV3uUH?=
 =?us-ascii?Q?pqYpMHHq2kVxBsN7yfFFnbv9qWK7Wwx77gh4LLu/nmLV12Gm6mvv2IvzRU5z?=
 =?us-ascii?Q?VX4sSQ826eBtL+709gHmMuHeNWf8RbhdwgWib41SzQnXrsvRSYF5SrflvJrR?=
 =?us-ascii?Q?pz0rV3hb4XdWRbgAA3rytCnDCvLbw3N0DnWaS32TMqbgp7R21F+S/ag4YY2R?=
 =?us-ascii?Q?b8Jn4vK+AWlTmv2sfcp2JMVAOWiyWOaextnR/vEjFZPnYnYxUeKVPsLYvVdS?=
 =?us-ascii?Q?AJyFcCErPFrStlXXP1sjLM5MU5tJr4oiPzlBXOuNoqWps9mthaxXVPMxLCLR?=
 =?us-ascii?Q?ZpW+lB7bUBRYxBbOKGh/Y6lCDKptM/SuhrVizm1e92sM663NKEbVBhqg5bQx?=
 =?us-ascii?Q?V1URsyV5LLoO9qK2/dc8704QEqrqJZR3dMuX1zYXyiHwSA23QmltUN+bwzmT?=
 =?us-ascii?Q?SccUqPKzi3AZ7qZmMgTJj8Pbrrp1XTzh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oDtQzHmgvMF4wO3DefgFRsXwFn/eSbakm1LvKbLDscpX+Bw2hBh7tI1VC8Z1?=
 =?us-ascii?Q?1allW3jfIXI+6+wNDbXGzjphN6mokisYmN6OaozmLW3IuR79KZRXQHAMlFSD?=
 =?us-ascii?Q?is/EsGLB+e0F6g+ypmz/8pJQbDaxqAefsdpVAuocWz7+EvN7/RyeN5uaCPO6?=
 =?us-ascii?Q?SEhdvjB+GD6RWafchsvBq1uJ9uomzNjIBhzdBcVYGfbpmXsDeE86u+hGGzem?=
 =?us-ascii?Q?Ej11oEKEZFd+w8k7/lLw0RBderuFERIgFUuWBwAws/L7vxpqtHDBXr+A+GYA?=
 =?us-ascii?Q?I4lMCgtkc8ZDC5HnDMQI3eZPhYQmeRkpA3V5SnxETPIq0OQ0izJBQPFnX1rH?=
 =?us-ascii?Q?rH07iEaBwyRZlsDDzdVN6LHh1/1ltveT318KVj51NYSarDOBZ8MLfML0mPF0?=
 =?us-ascii?Q?Rmi9Ik+6yt2fGLZPS4rMmZJJIzFF8kovi8cbpTCfWNSQdz2QA3ilNjuYPsU/?=
 =?us-ascii?Q?jK2Sp9cnzC4iDe5Gyh9S7qlsGgyM9iOY6HsfXXUKKPTJdU+5RpiRrplAhQmR?=
 =?us-ascii?Q?7BKpV1H4m1A1fcAyUV8aTEyk8e+rLpyJUy/NCYduvq2u8CgUcYDNG2X9X3UO?=
 =?us-ascii?Q?JwKdC/7n0faplW+CSTwJzSUP0FUl7MjQdpNeIqdp3qmlZXRaFbh++EiArnbp?=
 =?us-ascii?Q?0E0zoIgLKOcU0Y9KMXVTDouB4TL/KYkMd4mpILXWay5JCf6vs19vDTQ0JNkm?=
 =?us-ascii?Q?iPlspfK8Hbgj38QNYxZtyMq06K36YmmSn+iSpuAyxo0rPI/q+O352QJGawU2?=
 =?us-ascii?Q?Jt5DRfOqIVZtv1UAtrN5ioS2DbsUKXX8ovkc9BiHuJd8lIpOgQb5z7DA5ckN?=
 =?us-ascii?Q?3PnT0VpdHHhV5ZcnKjGYSwfW35rCgGVHCwq5nx8Il9nI1NlFs8XNlyOC/EYf?=
 =?us-ascii?Q?bfAuVMnL8pqef8EJpipuSFG/Za0ChQQraVLfNrQXt0rXU0nNtYe9jmfIy13i?=
 =?us-ascii?Q?npm9ZUSYK+MpUOCxnMje7eOdzLzmJN2vfKAuivnn7egegwf/79L+zLzCJv62?=
 =?us-ascii?Q?Rpb5/r4hJG8SgIV7nRIJC4i4GVTVNrDgRARWNNYdZiHyOPosWX3Pz/OV1Pdc?=
 =?us-ascii?Q?gL1qtPmhCAPngWFvl7jNufr4teefkSAdkJj82VQCyZX4uYG1N3XeZzOkJi2W?=
 =?us-ascii?Q?HYVDIWagkwGZ/RtCO8kaQDv7kmc/hmshfL41cxGSwchk5lzCpDZW5R2vK6EL?=
 =?us-ascii?Q?juLeZtthQ+pvRoCrg0KK9WRA3CYGdQle3Dn82xN5hQV8k0sj/DpuyZNuUnOr?=
 =?us-ascii?Q?dDXTk4t0+sXtjqz+hGdy+0UNkv/Yg3RxfSAU11tUUtcmE6kKEZ7CYas/9tb3?=
 =?us-ascii?Q?K8VwXsUyK4+xK83+KZwnCCcu/B2K+MSimER9F2rk07soG84SHJUTeNSuBmG8?=
 =?us-ascii?Q?AhlCcub79+BaffaQMrMKYfgNi68NeObMN7KleGNBHcXlGhFtY0KSRGISsrIT?=
 =?us-ascii?Q?OOYmdeOIj8aDsAC8VfAOZSNFDD8U55PCuSQDFliar/naMdgHQ4iQEq06ey2e?=
 =?us-ascii?Q?88g8/5DJ/sIU3WyAtQDhEDTzTgQDCW5ghHyV9CSBODefW5OitltANppe6npo?=
 =?us-ascii?Q?ZYK0WbOn+42C67jkDUTvaAuH6UrhM6GjARmbsJUr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634c4bc-75ec-46d9-ce62-08dd4c1b9edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:46:06.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCdzedEzEZzyA71ACsbNR8YHQKoyv7t5NuFoJhiWR7n+C54K8A4A2slHS+xOBS89rZmHUbcY1+VmovszkkYdm8XfEloI9FnTB3XZncbmmHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR07MB10116
X-Authority-Analysis: v=2.4 cv=Yrj1R5YX c=1 sm=1 tr=0 ts=67adcd72 cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=POOdd56icRyTAiQudxAA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: oU8n0k4IrlUf_EEfQEkbwRGOLcIzN7i_
X-Proofpoint-ORIG-GUID: oU8n0k4IrlUf_EEfQEkbwRGOLcIzN7i_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=972 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130082

The xHC resources allocated for USB devices are not released in correct
order after resuming in case when while suspend device was reconnected.

This issue has been detected during the fallowing scenario:
- connect hub HS to root port
- connect LS/FS device to hub port
- wait for enumeration to finish
- force DUT to suspend
- reconnect hub attached to root port
- wake DUT

For this scenario during enumeration of USB LS/FS device the Cadence xHC
reports completion error code for xHCi commands because the devices was not
property disconnected and in result the xHC resources has not been
correct freed.
XHCI specification doesn't mention that device can be reset in any order
so, we should not treat this issue as Cadence xHC controller bug.
Similar as during disconnecting in this case the device should be cleared
starting form the last usb device in tree toward the root hub.
To fix this issue usbcore driver should disconnect all USB
devices connected to hub which was reconnected while suspending.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/core/hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0cd44f1fd56d..2473cbf317a8 100644
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
--=20
2.43.0


