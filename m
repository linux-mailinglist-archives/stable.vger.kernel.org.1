Return-Path: <stable+bounces-116528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1C2A37B54
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB916BB91
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBED18DB1F;
	Mon, 17 Feb 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="e/mSDMEx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YYBDyiPu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE050372;
	Mon, 17 Feb 2025 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773581; cv=fail; b=nv5lZ0JtNdyuz+x3ntDa/E9XSCJxknksTFnS50g0oGglI0GfCAhaMDsU/gtHRnkYJaElOGQOt0IqNvKvpfOe3RGM0oSKH79vXiJNCMpv0gG6fYnRMevNIqE/9Xpz6QIbXksGwHnrrj1tajD6nVKenILjQpOMRayyWvgIM+W7rKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773581; c=relaxed/simple;
	bh=arWwXPkE1K4RhSzgMyf4YXA3SYNV+rM9eojYeLkDACs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryZFEwP25iawztf8kLYwAY2zGkrOVLs4FqpuYkLQHKfnNJzuU+CtUgIuAZTTIcAVL0Bs4Gm4gA0IM3ebDRV5V2qqYeW5zbCBDqHR9FML4OhIkxD8SnHyZlypacTjOgMvEOcCmGHjwTW1xKxjxeVU0kcAntBqqsj98g5nFG6TLBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=e/mSDMEx; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=YYBDyiPu; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GLl27k024700;
	Sun, 16 Feb 2025 22:25:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=jiYW4m2o9wZq0clkB9guH8mPZxMFLRMTSLYHJrYW32M=; b=e/mSDMExKWHF
	MkuJ8W+WeLiMcmYrOzClMs/caF0oOtHrRDH9yQ99O4CKBgeM8hEaZxf4mqh6GNmU
	XRxS9Vh46AHL/y07u3mdAm+vGClQ2KeKthky2Cw0ZKUc/7UDLsHczbHu/osutRGc
	IrwRemFsqkZlK8xs882uvfbsa53BziMDTgCeFY/tdiUEDWL6LTfC/EtqKR4XbWp7
	8Q65Fnn2DYD6GI4/F42KKWg75MPTCeJP7/Qzu54krAELrPjzRna+ygYpWukGd3dk
	mDWbV9RCtc48NbkBAvU/Gtz+AgjyWE+jwBekdZs7TpAeKPw1W2Tu/uw3xfo05k2k
	2VgCXFfLjQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44tqd1475k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 22:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2SLwxjFed+yl43kr8jIEnnG2Zk3RLdcKVRpiQKQ00C1V7B6vbZw1NjGpdkBMmdPyQeEAKOtk0B4bw9esr7p7fx50j0S+rsqWNbOfyv79VJJdFIKvaw3rFPcI52l0ogfD7QS4pz4TDXDk0R4ZiIy1fFj0ehF5qL+0tVGdDJQpkUOXvomXK2EP2O/geT0hCRt5f7KTjljD7K4Bttx+fH5yUjj9VgrUpuqDkpMuC2ZbQud5REcNEoIfj9epex7xs1jqbfHEK+O8wJf127AMgvMdOdzEbR/EB9VMlbu7RStEfcTxYZfayruHU/AfspiiiqtAlVbHKkKOr0guFuYRcdFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiYW4m2o9wZq0clkB9guH8mPZxMFLRMTSLYHJrYW32M=;
 b=XlZcQ1hNNb+JZA3zolB9VDoUHQLfvdl1M0ezwTKpplSqZW1wCvGWAU4yxnqrn6002YvN3K1zD91JRuI3P7YXpszokzQ6UksQ5NY2bqOsMdOk9UOYs3rTzf68aE6yj8Cm9KkvDcpp+YLzGo0Kq7MOBTOPwfmepYss4bhgdvuflFv2YaiGI94UgBlCRDz4rxXv9uMvhAe9RXjz3lqoYne3bHMXfdsI8Sm4ipZ91jYn1v20F/kQ7qu9uRX1FEJP/fibqTCXKZBqLKIItW8aaK007byz9XiRCrlnG9kX8th2kwCq3T+U616yZ748+maQIXAsU5fw4q76hvfzxwrnIvZKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiYW4m2o9wZq0clkB9guH8mPZxMFLRMTSLYHJrYW32M=;
 b=YYBDyiPuDxBa6OpPM9qIn7PKplUqVt+MuSiSM9TMdsa+G/FHsRwl0e9hjLTUP5ieotfBy4SB28PW1NsrRsPtkqbgAsHHIPIcFanOpCJKeXSZD9jP8oXdc4N88Rd2k9yDdPGL7YDFbd6/t23ZQOz7QavkGkJMnIntFc/AjQnwAlM=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CH0PR07MB8906.namprd07.prod.outlook.com (2603:10b6:610:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 06:25:35 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 06:25:35 +0000
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
Subject: RE: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbff/PyNY2z2E4uEeZXCoyn0/C0LNFA7/AgABYk4CABa79sA==
Date: Mon, 17 Feb 2025 06:25:35 +0000
Message-ID:
 <PH7PR07MB95383C03E64507BED1D64222DDFB2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <b39d468e-beb9-4a44-8fe6-83754ffbd367@rowland.harvard.edu>
In-Reply-To: <b39d468e-beb9-4a44-8fe6-83754ffbd367@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWZkNTEyODJlLWVjZjctMTFlZi1hOGNh?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFxmZDUxMjgzMC1lY2Y3LTExZWYtYThj?=
 =?us-ascii?Q?YS0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9IjQxNTgiIHQ9IjEzMzg0MjQ3?=
 =?us-ascii?Q?MTMzMjk2MTg4OCIgaD0iMUJmdGhiR2VySGl5ZHJTSXpJUWNnRk0zRnZjPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFCZ1hxbS9CSUhiQVR0QjNGdFZGOTMvTzBIY1cxVVgzZjhLQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
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
 =?us-ascii?Q?QWVRQjNBRzhBY2dCa0FITUFBQUFrQUFBQUFBQUFBR01BYndCdUFIUUFaUUJ1?=
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
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CH0PR07MB8906:EE_
x-ms-office365-filtering-correlation-id: d5f0745f-4212-4d53-0e7f-08dd4f1be351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BUsa6wCBjhidwsX55kDxVmMlQ7wk34w2z4T6kdhM21oSsYc0uHJHMBc8oGrU?=
 =?us-ascii?Q?o2ywPIBw9xwuSxrmzILIbkEeP5mfM/g3iWUtsRqUFyXkFMsHu+sPQ3M1Lrgo?=
 =?us-ascii?Q?121x4hbOukk37oFxYhrq2MMFCzfoqqq8Z104jxsKPdfwPm/fDgJYIWy+72Oy?=
 =?us-ascii?Q?yUURyoU34wdB+ENQlE9KGQy3hVeMQfCKvP+mmF0ggntF8h7HL5KlBmjdETcn?=
 =?us-ascii?Q?x9d8C6txeyRL04JLG6DmMPLvstOyzLkX9CDT3r2E4XCIoQde3y/B/dUYRUWN?=
 =?us-ascii?Q?U/5qZdGfkPxEflY8Ik7SCsv+hy+VNcYHHQsPCrVvg1Ue6CpmPSZ/rW9X1d9P?=
 =?us-ascii?Q?FTwa4usQ04Gd0LFs45VawjaL6jY7CdPSE6ODiRN4RZ+pPgnBxLU3Kr1MPg9H?=
 =?us-ascii?Q?IayUoPoxGbk1dJi+QGoxqPsMIQbeiVxh1JNjJ53DW7dYs7wicUJFVrORhH8k?=
 =?us-ascii?Q?xB+GH0JpFm67w2I82v4ARjU6Shm6PJN1OOgh4QNfzuB2H96b9TbVT4o0qkLa?=
 =?us-ascii?Q?FQKrdPVpaQNUZtkz3VEyTy/tG/jTMQ96nKFa8+KZZBWiiD/F2VD+tliEhVA2?=
 =?us-ascii?Q?AjiAZyf0YWl1jDa4U0mnGM19Uo8B5VZoJQbk0TDISpvWEqWC/Fv7jYCadLb5?=
 =?us-ascii?Q?ewGiiOxA2LdF2fnm6EN1bj9/sDZqQNIXzPX5iH4Kf2LYHlCAH89Hdc6zm7Nn?=
 =?us-ascii?Q?dvL2YOA4NwD7OWdq4eDPjwu8iM5UXgbrVWybxB/FMGebZtIGA6u2dml2bLSY?=
 =?us-ascii?Q?5Ic/cdGRr4cgqg847l5qV2cjd6cpBI8CcQbAQWhA0cBuvBciRMk4q+eItZ2p?=
 =?us-ascii?Q?wNeKmqASYnb7UBQM695x/I7ImuRqWO3dsqvc8258r/zYlHa4w94vX2uJNQml?=
 =?us-ascii?Q?SrJnhaS08pAOQ+LZ4r0fWUj9R7s20Y8DPfNjjajqvmxbD2qqUpSkACP5UgAo?=
 =?us-ascii?Q?gL0obnjpgWe6d44l/SykPDXAVJNY0+QVvpUPaUHHH95VzpMEgg75mp+LdXyZ?=
 =?us-ascii?Q?SNP33h5Bz5gbRO1ROBrJ3aY8w0LDKCAtYRGXYQwZP2/eNxIgB3AiaYW1A2Op?=
 =?us-ascii?Q?5P+QaQDdW3tmiJrn/xXKa3mLPxyfkQDmdM0LW/pQTbuyhlr0XgKl8r1KmWzX?=
 =?us-ascii?Q?Wn2WJrNA+S1qKlJsxqQUBu15/shMiVCG6+6uCRSkHo96g2uRRAZh6x264q22?=
 =?us-ascii?Q?/27tvoSKTHfXuY/moFWt9nvaWCxW8v3RcD71eOW3OPKlN+YhdcQeHxUDR10h?=
 =?us-ascii?Q?jC1q2BcyN+3sbmp6kfeCrNfFin7X5SMauRTgPy/RM1t6M+BNREAsvOdeaD4b?=
 =?us-ascii?Q?QWl6epKbjQf/iN/v2FAp11Dd6tX9hl5a6AFYRSflaLGjYTCZoPK7rHZLfALg?=
 =?us-ascii?Q?Dck0JYOFLyFPAVfiyZDVrSWjaAyq6ZJcMAsjREYaACla2hKQERvk7szUPhmo?=
 =?us-ascii?Q?qcOnjouLAnmbsrkhP4NGkuB7C2H0zZfq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tEuJ1gVjSDnEH3yDcF0GgOwbkbZ5X5HOsCVcWLyFQwWasZuS3zOLkg0YhtRu?=
 =?us-ascii?Q?9lrIAmhfwZzHjdl9ZOy8hZanuiaC0jPNFGFeOnf2og8pOYPv2KvwjkC9Z7HE?=
 =?us-ascii?Q?h6/aUAiW5INY1OHq0J4Uf6hPxD/ZWnyqe9LGgvFy+SffqjOpQaD9e94PyBB8?=
 =?us-ascii?Q?Djhh2JHFPsk/zXhFfakDYfMiVopfrJoiBVDGnCq0c0SIgRauRhOCNPcD1WH7?=
 =?us-ascii?Q?M6nqlDjMQcrBqfgJu6U/cyWoOYT/YLB0aR6Fe2CjrJl05TTQHg5nX4FoV/xE?=
 =?us-ascii?Q?TB9Y9M9et9QCE6Fpv9k9TkxUWpei/gtRbwhY7xatxFCWwvCoxqXEqIaN5tXL?=
 =?us-ascii?Q?C35mEeTJtimFBA8ItVDvRT8lxqcewsS0UOZxA4qDpJ1ZoH7YEKPqKFLfiqeO?=
 =?us-ascii?Q?MevGd0rY/xjg0ERABqnT9PWM3OlpG5xmhjbdXneIuD+ujgH9t1sIa5r3dn2A?=
 =?us-ascii?Q?dDJouF3DMNSyM8YfCoCTCKKM++1LmxKP+6TvXswxscX3nLdEmBK9al6OWAaP?=
 =?us-ascii?Q?glVSDunjzYo4tkYLi7nsG18WnYX+ZTONsv74Vj7bQM8mqMmEgseeFv3cGkDN?=
 =?us-ascii?Q?BQQRbblZqYlwUZ+XPXJzj1Mh0MNRE27nRxckVzi9o246cEZBBpnsNpSq9aUl?=
 =?us-ascii?Q?z7NQ7VGKegx4QSwR1dJqnmnnZMi5dKzOX1w8lXv2adxHa1xEAXtoVgHipHeh?=
 =?us-ascii?Q?k9nb3PjgCryg+jyUrDHoSp3SFnQ+q1v2ZlbTA9pDtzhNb0XBrfJJF9bIC3wm?=
 =?us-ascii?Q?hHqg3sv0DQSKOqHAhsgNWZAbEOMcHQtP85HVQXhi1d3hPxdAdGv2zOEs/sPn?=
 =?us-ascii?Q?pt2ebqCgfSzLDyZ/X37l9QUU+QQPSmZaG4UvWMatUSPbn+NDMAox+RjB6sNn?=
 =?us-ascii?Q?qnDfILf/DwLM6MUy9J9/8XOPj5Fp+jd3VSzOzy54SWjHexQPcxMITcUgaIii?=
 =?us-ascii?Q?yPpZrmnTvB9+B5FjvazEWynVfgIaDV/IIVSyrkKKJmtqTSbZQEoYNIX8/U66?=
 =?us-ascii?Q?n8zLD09S+BbqRbEgm70hznFpnQBWCdhmsZOQ6gREPx1GPap1uDJ2jHFvIT1q?=
 =?us-ascii?Q?9UWjLTFFYxhot4+GeIOXNlmOz1cbvWjm6jSMZV0KEW4DelqmH7kZtpcBnAf8?=
 =?us-ascii?Q?zIk07jSCD+aAkqRUq8NnEqxtaDtoIn9oEIsjBTiBjkShARKohzp8zxyTp86J?=
 =?us-ascii?Q?RnGL14iU5+nmMbv5miacMbxUYR4T7w7O4u1W5xpAYaZiW/9uHEI8n5Nc3FLz?=
 =?us-ascii?Q?p6L7B6PBg7hNxu8mklxr3tg/iGBNE7BHoUfVFG/H+Df7zhKgPk5MAeDg7q6j?=
 =?us-ascii?Q?RPjkxcxQdydVLXz01HIVPfaPHWme1DyqDxsEbwbL5awxGz6i25KXAZAw84Gh?=
 =?us-ascii?Q?rOyXHXEKXRe10dFxCKIuQmh/25X0B3EZqMyui1dGZW88PWoCkLjlfqjASXFQ?=
 =?us-ascii?Q?DU65XUJJW25vx60Ekpo7GQacNDI4VFx4C+nRu0MKofNVZU4bEF7rFuKMu2Gp?=
 =?us-ascii?Q?806FxCLYCKVsgaq9OP3PiqBuibxUP4Rc1WOqXGp1Ef8kSCpk+9RBOGM1uLVZ?=
 =?us-ascii?Q?nQLHziVDletggnF1rSAytlDOjchOZu973J+74seC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f0745f-4212-4d53-0e7f-08dd4f1be351
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 06:25:35.2708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cES1fVtoBK6UbJzE7vT++SNRbBYI5zvqaY5gpH11Yi0wpGPXnvyJXrjbtIYNKdWSUFqAi0JkeKViKjQqW1lGrgHe4Q8jWI8vDKLQ/TDp0xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8906
X-Proofpoint-GUID: IBwx0UudUs-x3ep8ViGM4eAveWNU861F
X-Proofpoint-ORIG-GUID: IBwx0UudUs-x3ep8ViGM4eAveWNU861F
X-Authority-Analysis: v=2.4 cv=K4LYHzWI c=1 sm=1 tr=0 ts=67b2d662 cx=c_pps a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=daS0RHY31lWXCLOSzBoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 mlxlogscore=878 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170054

>
>
>On Thu, Feb 13, 2025 at 10:27:00AM +0000, Pawel Laszczak wrote:
>> The xHC resources allocated for USB devices are not released in correct
>order after resuming in case when while suspend device was reconnected.
>>
>> This issue has been detected during the fallowing scenario:
>> - connect hub HS to root port
>> - connect LS/FS device to hub port
>> - wait for enumeration to finish
>> - force DUT to suspend
>> - reconnect hub attached to root port
>> - wake DUT
>
>DUT refers to the host, not the LS/FS device plugged into the hub, is that
>right?

Yes DUT refers to the HOST.

>
>> For this scenario during enumeration of USB LS/FS device the Cadence xHC
>reports completion error code for xHCi commands because the devices was
>not property disconnected and in result the xHC resources has not been
>correct freed.
>> XHCI specification doesn't mention that device can be reset in any order=
 so,
>we should not treat this issue as Cadence xHC controller bug.
>> Similar as during disconnecting in this case the device should be cleare=
d
>starting form the last usb device in tree toward the root hub.
>> To fix this issue usbcore driver should disconnect all USB devices conne=
cted
>to hub which was reconnected while suspending.
>
>No, that's not right at all.  We do not want to disconnect these devices i=
f
>there's any way to avoid it.
>
>There must be another way to tell the host controller to release the devic=
es'
>resources.  Doesn't the usb_reset_and_verify_device() call do something li=
ke
>that anyway?  After all, the situation should be very similar to what happ=
ens
>when a device is simply reset.
>
>Alan Stern


Yes, I had such idea too, but the current solution is simpler.
I don't understand why in this case we can't do disconnect
The hub connected to host was physically disconnected during suspend, so=20
It seems quite logic to make disconnection.=20
Can you comment why we should not make disconnection?

Thanks,
Pawel

