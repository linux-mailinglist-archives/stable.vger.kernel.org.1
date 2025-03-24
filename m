Return-Path: <stable+bounces-125968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F9A6E30D
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC205189206C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49826656C;
	Mon, 24 Mar 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r9nq1kLp"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDB19F42D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843167; cv=fail; b=Xi9VlQhrDJmmVZSqhiUZ9ZEfuUaMAYqYeGBtyxaECqUc+QBhXpBN5avpLgVJBwWusZYmx4EGRGITYIAgvedhndjPiUG7BwHCIdo7JbNRcTuwIhW3Tn/QAWQW8VWnIjPPG7Ky098O6bDLGnPiTM4D95gVLwXsjQE4d+Rry5Z5Ajk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843167; c=relaxed/simple;
	bh=jbSvchrQxr48+LncRTsBazXdzsmPfO5yqzP3XtVtHPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwmTZZvLZE23iCpAzNed43/G/AIO02OrKupP6O5LbShztMMHyFntMJ/HQeeSJrcWyQIZeb5RJtkZZTrOGQEe07T1rrOYOQUszGG5Xyw69PJnNcq48uTLqyqk7V07SDXsFtAKKL0ARarJVTXprazXWM5t5k2Evxkw4ufpZCL8Ibg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r9nq1kLp; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKjA8nGEP9VzbF7KfbQmyExFcocmXW7v5Wk5KLG2wnz0zjrLtxKr/eNsw4ihnc20lfFkotNNuQsCx6cUtFQbFjiYAt1DQb7cVN8jLzFUYmdeLj38Es9W+MfBg2UIe+xN+74pOm/afyx4kVZSJW7PTkLLssW9nDOAnFMUNNYvPflEeK9yAObGWWUIEkkA0usGR7LfwhqmueprrdBk6AB1qhtmxVi4mjCj0eBCgkh0XWtnaD1g3K0gheP4mJU0el1ZCXNEGgUsp5qD5ysgqNm2aCYo06xbGBrXoUZ9hErVr1lrwCJ67L9FpTJJ9SwXeYkwpiU2soIaRBYR/oRgBFsxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbSvchrQxr48+LncRTsBazXdzsmPfO5yqzP3XtVtHPA=;
 b=vloyAcutyMISyYPVUzmx98w0upkAolB78AUGlwXnIz4qfTCNELpVHzNi+KA8ejkOhP1gxSyG+cVHZFKtqfJ16vslJLNFpYXbtxfwP3anCok8uIkbr5mRplUEpOtYqRaJj+2V62Uk5l3jMK3iDioPVWOG8W0zTccLqfLS8c2XuwTo0BvE/tOG1ZRVx7P5a81UAgvZsjN//uqmbXo7jkjacKjTOAou3MkD5AVxFI1JbXX0IwY9XdPyLorXQIGjXjm3Q0j+qpFAvwOJMlu1oPwm26vXu9+guBAierQ6jgYdHEEs7T0pyIy+fk+wf62kX0uolVHSkKwAFXyY6AjOUn4VGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbSvchrQxr48+LncRTsBazXdzsmPfO5yqzP3XtVtHPA=;
 b=r9nq1kLpEpDjv1mryPWE0gWLMtzlXVkGVfP2FyU0Hua0TENfl2D8bU2C+n4empnpUUZJ902/TB0Y7tzn1iTA1eU1zHMMN3/uJL2HT1HlFXlLugAUkGtpI8H1rCVJ+UWfVC2pkluoAIa/h/OJzLtg37fxw71hEupVQ+KTWOGPUY4=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:06:00 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:06:00 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Tsai, Martin"
	<Martin.Tsai@amd.com>, "Chen, Robin" <robin.chen@amd.com>, "Wheeler, Daniel"
	<Daniel.Wheeler@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amd/display: should support dmub hw lock on
 Replay
Thread-Topic: [PATCH 6.1.y] drm/amd/display: should support dmub hw lock on
 Replay
Thread-Index: AQHbnOuFmmGcEixnxE2VRaOpHAMHibOCpXUS
Date: Mon, 24 Mar 2025 19:06:00 +0000
Message-ID:
 <CH0PR12MB52849FBACCF4E7E21A984A488BA42@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <2025032457-occultist-maximum-38b6@gregkh>
 <20250324164929.2622811-1-aurabindo.pillai@amd.com>
 <2025032452-tarantula-encircle-6fd3@gregkh>
In-Reply-To: <2025032452-tarantula-encircle-6fd3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-24T19:06:00.125Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CH0PR12MB8530:EE_
x-ms-office365-filtering-correlation-id: 8e113f83-506b-4216-3432-08dd6b06ea89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?t/DnXM/15tOMu315ZVhgivgSqXv5weQGkGzE0LrvJqpSMFlkx7iUAm37IA?=
 =?iso-8859-1?Q?C1ZwGQ3e8lUEh3uOnIu24ThJI3AxpwmT59ISL7/lp924gG/7xY1kNawvSU?=
 =?iso-8859-1?Q?wkK33t+EcswTu0YaneekOq4BgZu19iJLIo8EWTq4t7HTnQLZCk8lh11TXf?=
 =?iso-8859-1?Q?EC58k1pY2UGuEsYQlUUmz5nK11CHuT7vvsH8mt6OZ3gnAHEsXyeei5SuO1?=
 =?iso-8859-1?Q?duzufE28ILAlBNBcNUN3qUmSlhp8sC1B4ynmVntASqRYPGIq8cpuBZapfK?=
 =?iso-8859-1?Q?m8wHV5J9MePmhsvaQIrmqBLJ8457bZQHAgUm1X/aAjMhQ7eeiFgqtL+UpY?=
 =?iso-8859-1?Q?3mh1aFbgZfUB0dRemff1oex9/LGTbyopj8wRqRLHmfehZ5TsQrAwRUJpDk?=
 =?iso-8859-1?Q?SrRt2Col1QcdT3by6GstDFnlsSykxUjFtZj9IIT2wHriOkNxyqV0CkOgNB?=
 =?iso-8859-1?Q?xjErFvXc4QCYtig2GKFLjBSoGW7DexWYxlglWCorp8i7L1zFzBGr9t2VEE?=
 =?iso-8859-1?Q?0hHCU1OCfcjr6g5eERgTtqWuUJkX1FlsRpVFmWxqb9cmE91bT9ZAvECem0?=
 =?iso-8859-1?Q?pBE6ZmeSB0wexTeKhLb5Dfl0UC7YnGOwzVpOmxtitAGR1QqdK4Vh6pmMC0?=
 =?iso-8859-1?Q?yQHkiZiXuTXRoAYNCv92DdptuECIWkqmNgHadVwnyoFAhpLC1iFsSNP98t?=
 =?iso-8859-1?Q?mXcgaiBCfoOge3GFyJix2YLUNMqjTSXFktQI9PBh+0DU85NiIIDFMcqWmf?=
 =?iso-8859-1?Q?1jLwLJiNHrpshaKZgJ4t3GCrEpiDzIUfolRT11bHFdvqX3/Ir8DTaxK1e5?=
 =?iso-8859-1?Q?rjwyqQrfMNVtPax5AkNKqIbZS/sGRULHQmPz0bzNGM9N0bYxbWsVHMUU4Y?=
 =?iso-8859-1?Q?/lzn4T+o5ZXfnbPf4hWS7hHYZHqrWDM6PTPpLn/3y7SEMysU0/gnyvZK4Q?=
 =?iso-8859-1?Q?q0vqC3K5uheaMHnF+Ef73bgtZJx/CaTRON6XuMEf1W63Vj6fAwh9E051fy?=
 =?iso-8859-1?Q?udrhsM5bNanU+3QBqGlTrQfHw7rt5/JqvjrYkGbUbRuJpSNJL1spNdiXgr?=
 =?iso-8859-1?Q?HRQhcLoD79mHG7m8IC4gnlRVgKLK1a8YhHoemzFratPUvpRT9i4BqvKauQ?=
 =?iso-8859-1?Q?dJzeGt2zBhfPmR4ocUIE7HaKytZlhp9+cJrEJJs5i71HpHkd0sEsCLjyZ/?=
 =?iso-8859-1?Q?D9eBLMSZm/q1DZq/OZeHVVKGl3krNPpGxVyjiXjXI5mS432hhZR8Swlusf?=
 =?iso-8859-1?Q?uEBSNbC0PybSCIIXT9gd7KH5yePD+ZHJOEYlOrBg0igptPXKga1rHckvge?=
 =?iso-8859-1?Q?LwfGf7itLCRWVLbNNrxTHR96PmORzHN65hEiUtWHYpzImt3+jbgvTEsN5o?=
 =?iso-8859-1?Q?9xVjYA64pIcRRXaP4GaQg7B9V818fyVmrsl00wO0pzGtMr3SOU2YGhytoF?=
 =?iso-8859-1?Q?mvrFpknvWqW+8sqle167K4y/BcDAP8REhYinKJjmv8LXmQFJ9rl+r6uqGe?=
 =?iso-8859-1?Q?hHGS8QB7LEokXMFKrHkE8r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UHa4LjcHAu5hkZ+XAv1vsiEHAEvLpoSua8lBrlnhwhUwySF4UhkbRBvV38?=
 =?iso-8859-1?Q?eHJVZKQI2fGRy62d/InG1gwwnI6In3VQBWedv68Za4pN7RgM672pXNB8MS?=
 =?iso-8859-1?Q?2qx9NCp3o4svaK7xHsUOqQa0deUWFB16NsEC6EUqU/y370jgcprfP+wqHD?=
 =?iso-8859-1?Q?7FTtR+/xAUUvsdfZoYZgZ4o8zk+oMZVCidDeJ5o0f46kzSh6c1GZaL8fBI?=
 =?iso-8859-1?Q?2hzfXUkFdIsOTn5JC9Dli+ZtCw4IQe6hknpF3wTBIW8exs9/Cr4B5tfoOX?=
 =?iso-8859-1?Q?eBZhEAKXYwyhJi8dj1piZGn8grxmQdlaIIW1L8No9Ga4D5Yob0kQuNnMyd?=
 =?iso-8859-1?Q?7l7CrkzVCidYga5qnkKXDKj3ZjUxSFH7je3hTT6CyC1tsv/Y5vCk6qGZRv?=
 =?iso-8859-1?Q?L3bX6nxxi40Cl7x0niCpAnZ9Em6187DPTNR8Q209I3HKaC7INcwtVcyzUU?=
 =?iso-8859-1?Q?fyCW3hE9De94w8NLnCdFJDaq9Uapq6lXpT4Aii4QB4q99FYZXr32BrsZNp?=
 =?iso-8859-1?Q?Sz/sgD07dDHhHo9dvybUChXJChlLyp3qVevX5nIKvfBUXmE+Zqt08aZQZy?=
 =?iso-8859-1?Q?nNlDOBDe/taT4Ph8rM67RJdwBMzy2lgxBFcRxDmdj4xKueptFWKHcQGCnL?=
 =?iso-8859-1?Q?v6uSHwdonsQxF4iZt5ZNtEUxbeAQh0XqeceqQn8Rksh5hw1alDXxq+EZ3b?=
 =?iso-8859-1?Q?Jq0kE0TG9ATaXlfXuxHyavIqcMFzYsrgT44oe95QcE49ZIR/9lVZ6l4AxW?=
 =?iso-8859-1?Q?XlUvNiWN8P1V2iGu54YB8jFfYECvZWRmTN/I5ukhggCScHRbpvEMqclxxV?=
 =?iso-8859-1?Q?1rl5rCcvsY3h4iRLh/ktYyjjDv0sLCi9vqWvfruYHQzRf3a5+0G065EX/Z?=
 =?iso-8859-1?Q?ZKngYDB4z7KKoRzXLcar0fchq8oKpHIuX88dP3dVKpWJCI0NUcQLJjfpob?=
 =?iso-8859-1?Q?pqU+c4Xo42l37wK9Fjea0ffyA15K4vDpzi/yQHjN7WiLSLx3sk9yMKnfaS?=
 =?iso-8859-1?Q?ItIXqKTuClq13BC5tR2mPOh6HnR4xJiq7+a7Lgg/KMffc6bDUev+3W2kLa?=
 =?iso-8859-1?Q?FWLY3EwPYaUs3JaL+KIUJd8FWcm9rTik4spJWYUsrKikE7OFnmxGHbG85F?=
 =?iso-8859-1?Q?wLlcvK+I+njGfKhudSfrLuK0rrqIfgFuRYJmR110AI59p2YTNbhuacPp0q?=
 =?iso-8859-1?Q?rOTylEHQPLtM4wn507FPGmrmMhIq1+zbfMk2BaiSrVi/pBTP6/FwLCj6Pa?=
 =?iso-8859-1?Q?qObZm3Cp12b1Y6m/Od4GbXZEdJxyZ7EMfiWbDcmjqGE1LbK+DNmB6dgnop?=
 =?iso-8859-1?Q?55T439fs9y5shma1VPxBCg6IrnF88RHKudKE5uv988QxLAu+rEm+nQqfOG?=
 =?iso-8859-1?Q?4vZOA43CysNZRS9L9GHOwXwppDVW8gSRUcqBi620KFXzuP9LZsIfmWz0MX?=
 =?iso-8859-1?Q?HaGDa7VL5gZ0zxchDfheUzQ8M3oUUqNGxX7+CviBjofbz7MyIM/FFFvIbg?=
 =?iso-8859-1?Q?leUQ+tDDWyQ3w5uor6c6ixbENkaLTx6hynHz32BmPGBrYui0gSP5/y9tM1?=
 =?iso-8859-1?Q?akGAUX4Xik76Dv9PLWBn2THz6e5VbhXUP0NBUiX/Fw4kdvEh+KfL1HSbp4?=
 =?iso-8859-1?Q?MSzWwJdBSUOJY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e113f83-506b-4216-3432-08dd6b06ea89
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 19:06:00.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BW9knPVniUc8tkIJmKKTM1hab500YbFQWsSNDX4GbfnChTsnMVE4YmbirhS6imx9b4X0hEZnz48b+FFf9W0Wrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530

[AMD Official Use Only - AMD Internal Distribution Only]

> Does not apply to the tree at all :(

Hi Greg,

Sorry about the error - I was on the wrong stable branch.

But please drop this patch for 6.1 stable, since this tree does not have re=
play support, so this bug fix isn't valid.

--
Regards,
Jay

