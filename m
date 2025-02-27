Return-Path: <stable+bounces-119803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9AEA47643
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BE23B1789
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C422068A;
	Thu, 27 Feb 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g0UlUmwe";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="U7dYlL1z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEF21E0AE;
	Thu, 27 Feb 2025 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639932; cv=fail; b=PH+P8YGEl7BsCtbAo4pDNaNvg9u6ZCYhd9ZUUBUV2IVS4o1jKZgP7Z6pgPdpjl74I0ku5SOehtzAW6d31o75E2IzLnQwOtbfZ9YP9oCErtsb83FtFJYI5hwz7wfyXuwvGmSGHQePAnUIAxIipfhqmqi2ODLrTxsPGs9jqxDubgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639932; c=relaxed/simple;
	bh=sL8DusLrzxoWZSzsCRUcayE5bRozBQmZXaqO1EW1tIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOdqtrO5+2Ev9h5shD+F7itESIvgE+bb7pF8qVkymXumbyCzlFi5rHG0i+nYwudOB3laVfGU305qRJAFqsDioMs5rGESX78TzEpA4trKTRA+PFsK4LzcG9EQA/N0OGrMdAPrd7C8dTLSpGfdasoeOGkevs/yl9+CrHTh8HV8uso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=g0UlUmwe; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=U7dYlL1z; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5AJ42026047;
	Wed, 26 Feb 2025 23:05:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=sPnW6KLUcnsvjwFGEV5NFRzN7R5KaJnIqYO2E6dmIi4=; b=g0UlUmwelQX9
	UXICcRsGcf4ExDnldgp4Okx2xdOcja5Omovwnl2Zq700k+MW4oEqkSfK9GRGdRoa
	tPo00fMxv1CoVJ4l0MunOLhs8/3K5922cCVZZC/wY5pM1C+FN65ifV66rwgvoRyD
	63oifW0dsTTsbH5C3zk9FVyDeH+aSsLa5mh6UceJk1DZ+9Bk+jFo0hcIcDqHhU5k
	PCAWd/25zLIDe9sj7MuIYr50X4zm7wHrFDUCsYpn4IAtlEHHpthznlS38lRTmrf4
	Hhd/ok812dq7uq+YmMzBtOW6FvoF8lMusYAgu+j6teqy62Ts++zx+aH55byzhUWX
	zK+To8jqzg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 451pt7pf2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 23:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ88Y9aMAKklsi+anMtEn9YVQgtYU7cKzGbptq3bnRBOykLw7AEVONOSLuwu2uqHKU19zgU4eKWyQBvJc8dUSuxbNUQb7zRVHcHDpT1Ioce7BfG1EIuN3bkE5A7Um9svqOi7mCaf8wj+9n/cXZgBUbi/XKTL9vTqnf+G3twiJzxclS7EyV5BxjjQ7hnQtDuA8yZ3ojS/TCqacAmM3E0HvB2/lQUNRotI92pdAwnD+8uRTJnngzBE9zTa/wcOYjAJDgIRU5fgJZFb6B2TE4jH1PwmYDdc95GBq7Q/Ub5mskVb3Bmpr+JILJr1aRkz105eEfYaN95fGTfRm8iuPl+rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPnW6KLUcnsvjwFGEV5NFRzN7R5KaJnIqYO2E6dmIi4=;
 b=sZ/yZ+u/15A5O+JQcnLc8g/VYOAje4G3NWdMMU09vv1ktIcaPB9oTbh8QdnA6OtXxAn8juKnxNmdGbBTYYh04St0XtRBmZZwQEnnAlRGCB5EA1p8EjkyV0UjiEg7EFDBD8TL2oeOrUr7nPug1yLcMJ8nn2R5Rgsmk7uK7qvTuYYJ0Shdxg/RwOpQDwEBxHQvT1FfuoKEq0ScaZfKZCxREvS2nT6X5j9tIWYfhG1acbxDonpG3iJR6p3SbZ0A5cGfKkIsTrz35NvHUd5IegtR9/JamV8X89hGmGTHyHhPnTJ+TWEXsjmP2FL9k01ENEk1viXT+r+FTKbPnHSG2Rvh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPnW6KLUcnsvjwFGEV5NFRzN7R5KaJnIqYO2E6dmIi4=;
 b=U7dYlL1zvP/r4lJF+stxofo4l7gOl4zmNTNP2ciQUtZAa82W5QRPnyRxqKgqAWywO1FGbin3ruAjg/NcjvDAO+JkCOD2ZAXglh/eY+ER/gjJYgOJJTuhapndSJ1RHlF/4LYNDPlLSgz/SYtHXUGa+4aaW37PofbieLwD3JLZR+A=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SA1PR07MB8625.namprd07.prod.outlook.com (2603:10b6:806:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 07:05:17 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%7]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 07:05:17 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH v2] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH v2] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbiB5tjmnPswcsHkKXQ8kMhVwcYrNZLX9wgACNrICAAPuRQA==
Date: Thu, 27 Feb 2025 07:05:17 +0000
Message-ID:
 <PH7PR07MB9538F28D5F4F6706363CC78EDDCD2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250226071646.4034220-1-pawell@cadence.com>
 <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
 <a78164bc-67c4-4f31-bbe1-609e19134ddf@rowland.harvard.edu>
In-Reply-To: <a78164bc-67c4-4f31-bbe1-609e19134ddf@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTMxMThkOWJiLWY0ZDktMTFlZi1hOGNj?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFwzMTE4ZDliZC1mNGQ5LTExZWYtYThj?=
 =?us-ascii?Q?Yy0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9Ijg2OTYiIHQ9IjEzMzg1MTEz?=
 =?us-ascii?Q?NTE1MDcyNDc3MiIgaD0iK0MreVlXY3FWUnlxZUdwNHBvN3puNTJoZklrPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFDa0ZuSHo1WWpiQVM5N1NWR2VQRk9mTDN0SlVaNDhVNThLQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBTkFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
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
 =?us-ascii?Q?QWVRQjNBRzhBY2dCa0FITUFBQUFrQUFBQURRQUFBR01BYndCdUFIUUFaUUJ1?=
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
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SA1PR07MB8625:EE_
x-ms-office365-filtering-correlation-id: 916903b1-bc7c-424a-f860-08dd56fd173d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0cxYwPxLoLtRH5xLmdl9Qm+xWapk95TTa9CWCPlkaa90pih4UtG/2IpsSqSj?=
 =?us-ascii?Q?41wKdbWkXY/SSe7qYKi1ksaYEzOx20X51tPs5zQ7j3dkph5gg2iyh1GcHJ/X?=
 =?us-ascii?Q?dKKS1wDDOBSErhe54lvcaip68XGfAkUxG9Mfow3nr5ec0/IZ8UVlj2TycHs3?=
 =?us-ascii?Q?KLMFFo6rQ8QQoq16egom8RCy7xA99j+cksfYWw7tGF+Dhtu3FZi1i+ohTOEY?=
 =?us-ascii?Q?oK/gdCcfcq3LRmlMFHvzVqTf4nXI/3kD/Cw90rrLnkHSCPBnHClqpFFbNSpI?=
 =?us-ascii?Q?A49CKczXSQEJhmoyrNrVf0Kw32YIIapN4mjK7BL/OWL+DE5xK13GNVrUuvof?=
 =?us-ascii?Q?D6JEOQDzU2FNKgl6PSGj94nvyUC2+046LfPZIHlpCMiDUIP21u1FGBzNxj8C?=
 =?us-ascii?Q?4NcNEOU6kVlQWrJ7tWmi3g5NMjx8bg6IWOjs2x4BkCvSvDvb7SaZ864yebrw?=
 =?us-ascii?Q?xmQVRd59alpIdA0XUxo13ykKwRZ7A/GUWg3y1RxKZ4uNfXBCOP7JyYf+gdsS?=
 =?us-ascii?Q?WQOnVKaTxAevYdyhGhB2OEgcEZX7Xm6GEDPqGxlDDDr15az21OKCUVxXEq1c?=
 =?us-ascii?Q?a53vjEIrxupm32LcIZ/LIStC13a9DwhtPJWDm/3EElaJE0h1Btiue4jokv3T?=
 =?us-ascii?Q?1eDbGnfU7G34qbxf4LeDXM1g90ecuPZ/nH6jYDBLEoKysTq3Hz8UiXVpzY9C?=
 =?us-ascii?Q?oPomxwAdX07MF44eO0TP2p8XDeMjiwu2LcFjH4WmML0s4f9bh072Trs4++bb?=
 =?us-ascii?Q?RSYDKIz4sM1F4JvhCYQqJjO9OBZpNWqB03CtqKLHWmQ7LarjKDi8nobCiOdT?=
 =?us-ascii?Q?2yfvaQs23PJ0jdM0Kk7fAhjuyO0hTeiVLk/32w3qUWE49skU3RJOjd1RmKB4?=
 =?us-ascii?Q?vnWf/jE2KrXnCTVCJMWlr3jTR+vNd3X8tpn4lOAsGTb+gatC1ann99GxYUMP?=
 =?us-ascii?Q?a2m0dlmSrlxBEqk8rPMi5yvtW0H4uo1vlcAVXDpYEqDOa5cTwIJ4OAHvighs?=
 =?us-ascii?Q?Bv/yeaeZtMU1uOpfi+p+RpAj8CQ7KzHGGR+3cGcLPAxJoD6kYap3Wril9YBZ?=
 =?us-ascii?Q?ps9s/oiREPMNLhYyacPZvwK+mjtFvMrwIpW6Umwcpr2t6Wq3SjJKAdUJRyRG?=
 =?us-ascii?Q?ARgJNS8VbPHBfj0ndkc95/XWrHRCJXmh87tWtgLAFfk0LR9slKhC5zsSyOVO?=
 =?us-ascii?Q?y6EZpmKYKw+aNcJ9Sq7Puaaz2nfTB8AHuRQ83gUYyAgp3iLzUPiHGsEZsln3?=
 =?us-ascii?Q?/vUoVaEB2hsprXHTKxZ5JHQE4jNnbiII7kNuEmkk4SzZTJjzgGWxFUNt5f6W?=
 =?us-ascii?Q?ieLWDERgqsqFIAGITlElFbuYu7xAskGeQPsn/o7dG1Cuaal6sPL0e3lgBjhG?=
 =?us-ascii?Q?yGsEvUfN/V2G7mRA5VCy6u41F+NN20yHFzeKuaWVf0uvnTiC3p6HRGxArlAl?=
 =?us-ascii?Q?rplyQ7i4ZC53P4wNGToGejDDvAgj1cWH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CZZ6v1tQeiv+uYgmBHGX9a3K2HqZvoOULccTQx9squt1j1Q8CV4pNLvsBzba?=
 =?us-ascii?Q?SMMG15MaSCog2J7Uoiozgi/cJpEGgE37DN7GKNZWILNXIHriAdgRtp98RlHZ?=
 =?us-ascii?Q?KVfxRilj/uTgppfH9CcSXIu539DiCtZUnw/PLsmDe8r784yHMB0mDHLj2gat?=
 =?us-ascii?Q?7S8TbIZvXpGLuXfeR0nbj7f5KmFGRJvNnD2ECkapVv8Re4ZFXqZduaMPZa//?=
 =?us-ascii?Q?j/BAbBAEBfqsXAaI5fQSK+lRhUic5Ep/mUGg8Ct3yXLlbLMABvwoyx9CfjNV?=
 =?us-ascii?Q?TG0ZOTpGopMKkaHqxqKBJKscz6jDDU4RMOY1uZgb9L8Arl2qp7XUAMlvgYcW?=
 =?us-ascii?Q?m3dWkcgR091mjInL4f9RvGgYQlL0M5+r2rT7oKf3oG1osDAx5rx1oi0XJFRM?=
 =?us-ascii?Q?NEFlQ1CnCsPJWuvITsGEE6tCVkpYtjgRh54WithGMDu/F8PFhQ2hOI25pTWA?=
 =?us-ascii?Q?SMOpk0WZQZDKZM4HKYphgUiXZ4TqR6sQOcKmDbjxj19xtzNlCm670AxOjcUW?=
 =?us-ascii?Q?7V3YEvvPVIX8O6tsJnTNm1fbLXSDRrl1t+8ufHRB7hBAQhmT7ofVKGLOeSEW?=
 =?us-ascii?Q?lG8+vV/WZD2o6/rM9JW36Fu08LypgBg2Na4G1bZSbszhRwGFCHItJOmDzUWw?=
 =?us-ascii?Q?Xwlma10pThKVGp4u8ueW7072PDqzga6Cq6biFIpF4hhs2brZepYu/lFVGm2c?=
 =?us-ascii?Q?tmkThHQ0NRMeRj+Ehl5P156LBMWCdUpg+zKrTTag6Ql/B4WYXX8hWemT81Dx?=
 =?us-ascii?Q?WAFISVFyFhCGeidHsPwuyanyG9mlRIt3o0U4IHi+S1oETFVSLTy3e/mDy6Rf?=
 =?us-ascii?Q?X0y0a+vZNsHpRwo2TIucUQBzj4p9MOLQ5fHBpZ3vvAZrI1cGkbw0DDeN0MAg?=
 =?us-ascii?Q?KXuRwlaAnVpymPsVAm5AmdCIi09gDptjFxMPr219p8ixnH1zo+TIZEs6aBkG?=
 =?us-ascii?Q?a0PugIgEls/kJnAECUF5sBl+wGDbhqtKWAnf4xGgyGVCrRet+gDK9UmdXzSf?=
 =?us-ascii?Q?pMJ6r2OEbMyAxUehN+ToOPFibNOqlsQn1R2LLzhq+zUhtJwX3w0jrb9/3mq/?=
 =?us-ascii?Q?X7JQzst0kqfoUb5wX4ZZSn6UE5pbU+S9NlmXxh/ldiW4K8jFG7mAdBz1pMH7?=
 =?us-ascii?Q?ZI8w+MhmYUz7j4UjApP/MENWiilzMvs3a0LEHPn2mEESwylf7z3e6tZjVxhl?=
 =?us-ascii?Q?ilv53y/hFvaj4iYPZnSpOqt6F7svCXkzzHyUCMNYOepmg/Y9de8x3ex+TAIJ?=
 =?us-ascii?Q?ubExPrw7teLfFQJwF+ivfuIXclC502BNkpwCWriA+0pQh6sqcP75n7ReAATD?=
 =?us-ascii?Q?snP2ptAj+QEZlnjlU99d6ktaNjvlIoYOj6w4mrfQcd7w0pZcMPh4HZETGjU9?=
 =?us-ascii?Q?2qa7zhrZrvdTM5WJTXp/Wi4IBsBLyOW3uLJ8hSxaAAmnsvlYQkTVPtU6s/cy?=
 =?us-ascii?Q?NBYtfMJMm3Xq5FGbC8V3aoGzBxjERbHB/fEaUq+c1HLb7DSaTY2oznPO+kpT?=
 =?us-ascii?Q?HZVZHkj6+LX7ZmgZ4N1fgE0H3t+rf82wi7Kn9AiARlY/mRWpM7pnmoLTICpn?=
 =?us-ascii?Q?yH6eHxSK8YhjHK+bOfudwnoA3C1Ad9OEtmsTFYVc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 916903b1-bc7c-424a-f860-08dd56fd173d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:05:17.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3pH2s/O/74WnrNzWR7nl51rcj3LjKDT1wbudV506YKl1pG7SahhDq+JS9kLG6+fYbc/lMYV9n8CXv/xerHWEFeq7S9gBG6buzv8CSx2lr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8625
X-Proofpoint-ORIG-GUID: VY8P5zWsqEwXJcZ3QJ_7NpLLCjnsFypv
X-Authority-Analysis: v=2.4 cv=B8xD0PtM c=1 sm=1 tr=0 ts=67c00eb0 cx=c_pps a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=Zpq2whiEiuAA:10
 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=09VfWx6Ys3mR9M0tdu0A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: VY8P5zWsqEwXJcZ3QJ_7NpLLCjnsFypv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=543
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270053


>> The xHC resources allocated for USB devices are not released in
>> correct order after resuming in case when while suspend device was
>reconnected.
>>
>> This issue has been detected during the fallowing scenario:
>> - connect hub HS to root port
>> - connect LS/FS device to hub port
>> - wait for enumeration to finish
>> - force host to suspend
>> - reconnect hub attached to root port
>> - wake host
>>
>> For this scenario during enumeration of USB LS/FS device the Cadence
>> xHC reports completion error code for xHC commands because the xHC
>> resources used for devices has not been property released.
>
>s/property/properly/
>
>> XHCI specification doesn't mention that device can be reset in any
>> order so, we should not treat this issue as Cadence xHC controller bug.
>> Similar as during disconnecting in this case the device resources
>> should be cleared starting form the last usb device in tree toward the r=
oot
>hub.
>> To fix this issue usbcore driver should call hcd->driver->reset_device
>> for all USB devices connected to hub which was reconnected while
>> suspending.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: <stable@vger.kernel.org>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>
>> ---
>> Changelog:
>> v2:
>> - Replaced disconnection procedure with releasing only the xHC
>> resources
>>
>>  drivers/usb/core/hub.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
>> a76bb50b6202..d3f89528a414 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
>>  	usb_deregister(&hub_driver);
>>  } /* usb_hub_cleanup() */
>>
>> +/**
>> + * hub_hc_release_resources - clear resources used by host controller
>> + * @pdev: pointer to device being released
>> + *
>> + * Context: task context, might sleep
>> + *
>> + * Function releases the host controller resources in correct order
>> +before
>> + * making any operation on resuming usb device. The host controller
>> +resources
>> + * allocated for devices in tree should be released starting from the
>> +last
>> + * usb device in tree toward the root hub. This function is used only
>> +during
>> + * resuming device when usb device require reinitialization - that
>> +is, when
>> + * flag udev->reset_resume is set.
>> + *
>> + * This call is synchronous, and may not be used in an interrupt contex=
t.
>> + */
>> +static void hub_hc_release_resources(struct usb_device *udev) {
>> +	struct usb_hub *hub =3D usb_hub_to_struct_hub(udev);
>> +	struct usb_hcd *hcd =3D bus_to_hcd(udev->bus);
>> +	int i;
>> +
>> +	/* Release up resources for all children before this device */
>> +	for (i =3D 0; i < udev->maxchild; i++)
>> +		if (hub->ports[i]->child)
>> +			hub_hc_release_resources(hub->ports[i]->child);
>> +
>> +	if (hcd->driver->reset_device)
>> +		hcd->driver->reset_device(hcd, udev); }
>> +
>>  /**
>>   * usb_reset_and_verify_device - perform a USB port reset to reinitiali=
ze a
>device
>>   * @udev: device to reset (not in SUSPENDED or NOTATTACHED state) @@
>> -6131,6 +6161,9 @@ static int usb_reset_and_verify_device(struct
>> usb_device *udev)
>>
>>  	mutex_lock(hcd->address0_mutex);
>>
>> +	if (udev->reset_resume)
>> +		hub_hc_release_resources(udev);
>
>Don't you want to do this before taking the address0_mutex lock?

I will move it.

>
>> +
>>  	for (i =3D 0; i < PORT_INIT_TRIES; ++i) {
>>  		if (hub_port_stop_enumerate(parent_hub, port1, i)) {
>>  			ret =3D -ENODEV;
>
>Doing it this way, you will call hcd->driver->reset_device() multiple time=
s for the
>same device: once for the hub(s) above the device and then once for the de=
vice
>itself.  But since this isn't a hot path, maybe that doesn't matter.

Yes, it true but the function xhci_discover_or_reset_device which is associ=
ated with
hcd->driver->reset_device() include the checking whether device is in SLOT_=
STATE_DISABLED.
It allows to detect whether device has been already reset and do not repeat=
 the
reset procedure.

Thanks
Pawel Laszczak
>
>Alan Stern

