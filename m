Return-Path: <stable+bounces-70743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66E960FD1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2577CB27238
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB71C8FBB;
	Tue, 27 Aug 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q/wAk05H"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83D19F485
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770919; cv=fail; b=HUs7aUUUnEgXHsmYorIj6cVHbixRPchZJ0Y2aRZxgah6Ug1sSdusEWxlYF0areTn5hq2bQjcHgzBuyeezNnph6XNNa4z4yyA8Ae9dsOGpe9QiKMd7QHzP5dJCr/v/SJck48MiVoWR69Y5f16qwjToxJaWQjkQ7YDu9bLoue0on8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770919; c=relaxed/simple;
	bh=fNKH5AvZCpmOLfY7mjVtwWMPRhsCzyLvS3ALEkcs6JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxxshS4C5/PivpS40syuVmtzVtid6ldqBnA8mBXNZAklvGzY4DyLXtiTmuURxIi+38/SbMQE4jh5CIqWx+p08sCWVsyr/5A+alx7Lnzsc3LIB8bxpspRZTH9QatOZK48w69VeynZzxQKQ35yjGSBCs8jnKRkSsOkJL04K+pKQIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q/wAk05H; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bszEPqQmkDcrl1lfy7GqEJR5+ttxjSATlbBZ+lCVN1wBa/oyx0fgQZRu7grxpPbKwyPKRW9WpQVTOrsVT97yO9bqlmQ2f3StuqUNs1ee7xkw9lp7GWOqSLesTm5GnaBFskKUlwrTNqbZvYe0481xakTgysqMsuZfYth6VQK/6p6I54P9VxH3H/Mc81CFcFP/ZjLFIH4ZzJvE9pgtPyMD6yDXhAXIov5eHJk8ShbTc+3d09+VqjdC3kATnIhbHhzjMhzmL0Nl359g4tQ+8LOKcj2nuVcgGitkMHVSKVyiCH3lcD+tlyYCejUsfSXuo3bGTwF7OLJqjVQCq0Z1V8Anxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNKH5AvZCpmOLfY7mjVtwWMPRhsCzyLvS3ALEkcs6JY=;
 b=WYgbKBifY8xw7mOY2HUQmY1hWjAhBGWwbqB6ijeJfXOv70sE+y/qwscLwdXkR5tH+L1dGqyNj1QXAxav4hjJPq3lQUk6tXog7hy7JhT1ivqNB6mQb6V/JaGF1D/O35RdCFlVHUUZsziRKZBX4cv+Ap4aym1/1H+C0fOyywJys1vnApgiVogQZ9cAeXg7oTbY1sQ/mzX8rFt4vyh7AeMmkZ08sRwxnuw5icywrb7YfJReod4vEzp3WSvtK2aSLtXjABTE7r79L3orDYB6dv6wYD/uNZhGEvkSMTt0SpCA36vCGJumBfIbtA73SJ3jfCsEzLNqouTjTPUZRlX4o5jQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNKH5AvZCpmOLfY7mjVtwWMPRhsCzyLvS3ALEkcs6JY=;
 b=Q/wAk05HPioEH9KuUXVIF8lzX4uR5Nm9BPHo8dx9Ac6q7BViil94Wgv40k0IAhIfDAJK0jUZlFxOgVqQ++Phe/JvfTTHNZdSHbQyCWjvUJ0i7y6NZhzwEVTAx06DgYxWt/Kl7chEEo+J48FeB6FcFVayreYTCjL2f5G2npZ+Rag=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Tue, 27 Aug
 2024 15:01:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:01:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Topic: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Index: AQHa+IroFFYy5bnuIEmMsRfoen1WfLI7J6KAgAAKGKA=
Date: Tue, 27 Aug 2024 15:01:54 +0000
Message-ID:
 <BL1PR12MB514422F9FA07573AC2A2759BF7942@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240827141025.1329567-1-alexander.deucher@amd.com>
 <2024082746-amendment-unread-593d@gregkh>
In-Reply-To: <2024082746-amendment-unread-593d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=467e0491-915f-4382-a81b-2dac87350cdc;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-27T14:57:26Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: 30b9c46d-fdcd-4858-65ba-08dcc6a9308b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wxtLkculiR0MUhbAbfDHRczBFHfaOYYTZDaTGdFQh464waTW4BKPfoyOFI5s?=
 =?us-ascii?Q?WSrFWA0J1uaITwzLoCjl+/hV7QBWwOxpFXwR1JbsCE6w4NNkaqQWu6avvRXZ?=
 =?us-ascii?Q?jqDMECqQz9165hPuyBGZ9jEZ49ma2ZtvSgH+bEavYdLZ1BZpk62VixvlkWGh?=
 =?us-ascii?Q?tI1hLqVfTacPAhgEo5hZ6a+RCNTcIdU65FazRVGr01oNCgDxGuBPcxNPQnIt?=
 =?us-ascii?Q?FgE2v9ioAcBkPkUFj9aOdUzmiy4RZIRQK3cIq2kBjmf4dX4qykRTJMEd8xJD?=
 =?us-ascii?Q?MrAE+VvO2uEz/qjyC2FT2FQsCbkEUMVUwzlw4KNK7VKjMoYr7cgfxh4MCmEh?=
 =?us-ascii?Q?xYVsW4XV83Qzp/3+qE0OI4XTF4IHYgRtMms7xRdLpMEEATYbfHASuhNSYw77?=
 =?us-ascii?Q?XWERHrAvZtzxfrdAqddfk2N8ULHY6ysYH9YgwSff4LahbMHXvPFywqN+LbN3?=
 =?us-ascii?Q?2PAoYgJ+/n/gDsZ4Efhk0HWOKK/v/rRe5tSOC/hDj/QKA83c2fl8i353I9gh?=
 =?us-ascii?Q?0foaCKUK48mW/es1qiZN6ZymBWsXwoMhZdTmknD/wS7tIKsyPUYnbzS2MRpR?=
 =?us-ascii?Q?czmQgcp4PoQAtaIR7JH2IVr1BamKtv47rrgaCOmoV78rzOJenIBDi0Q0ayhx?=
 =?us-ascii?Q?x2VjV1XQSuNuZNP8BlLMjfvqwzHTqn07raQEQhA4ISyMhKC1W5aRkH++XCkw?=
 =?us-ascii?Q?s5VfOb8HB3e1IywenB+4hLu/zN1BAc7wUDItidnfeXXaUvQciOo2aJ/nobJl?=
 =?us-ascii?Q?9zyfYunan5Lc72vPIzKWr23ZG9DV+vmFhcD04HrGxVkHbe1ldHdc06wz7Va7?=
 =?us-ascii?Q?dU6ZAWFI+w4P7krfiVu5QLQBNHA0KUrGLgUx384dwvUsQGK6qvnyJV4G69mz?=
 =?us-ascii?Q?69RI2Moh4tlWSdfGSVLuRCfZNv2RmyzBJsx1QUVOunS3Vmt6rthpV4X0kcX2?=
 =?us-ascii?Q?OPuP7cICrEQulUFwsvSRAXgd5vca8/kbBwP0JzuF5nqGXIwgwIthk+3gxSnU?=
 =?us-ascii?Q?D4J2FPe+WxYS3h+SFoDrMnbLmEBMolLxSeyP5PYzGG2fAsFU6yJcKJxjLctt?=
 =?us-ascii?Q?j20ierIzMFblqMzbXPa/EnQeKBF3SH3ovxzR0Zlwfy6wQjCZN0fFOvKivxMf?=
 =?us-ascii?Q?9WqKUX/VmRtaAw38xcmBj4SujC/uTbN4hecSqlonaFB5doZ+CuqFasntl53Z?=
 =?us-ascii?Q?7Y3MiGfivtVwd3wxrUbmWdOskj9OvRlu3PUQ/9cQPyBSfM8ALkiwETXgUGn+?=
 =?us-ascii?Q?lcY6ZqpD+dLXsVpojYJLgqFfwG8YLqpqqHqWx37PBem6xgiERQ5fD8D2yGrJ?=
 =?us-ascii?Q?KRu3IZGPrDrHTIvZiyaKU9FPNho91xz6s9VHK9oDuwLba8DzfoIOAGan1A9E?=
 =?us-ascii?Q?kOaJcVw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HhP/iT+DynkenV+d72Iz7ubUuGr74bRC6kl/wq3BMILp8+Mjc8iz+3Uu9BGr?=
 =?us-ascii?Q?e8hw8T8mEOz+EHUW7Oq4sfxmKVnZJlZAFeNQsA15lrJFa/lgYVogyIb2ZAb9?=
 =?us-ascii?Q?s+eAFVNqOAbjN42NiKwnvZ79UxCp1/p3RlNDm6UPDNJm8Cwe4BBTmilKEcYz?=
 =?us-ascii?Q?vhcnuSSvGUb293YgjlyWZ8sik9476PB+OZFhx1e3UUftFlSAH3EmxHJ5ylof?=
 =?us-ascii?Q?XWIeheCOXN/SZ0gUMbuU41ELzZy5sYK22ytXsJAw9K5X0aHxSeUZnuhp0UmA?=
 =?us-ascii?Q?Nbf3KLd26cY/H/9MbSQah6146oNDE8+3BrQWnrS6ygAeudB9ZqBsNyXVRdCQ?=
 =?us-ascii?Q?RWf8oCH443+0eHaZHS5WTfUxJ2idPzONl6eQTailUo/OBOonjl+cvcSeWz64?=
 =?us-ascii?Q?dKMr2k/3iuGkmUsMMsGk6IsKSawp0qa/DIVe42E0R80Zpcj88gzHd5I8GnOt?=
 =?us-ascii?Q?pyeb9oiCVu/Hkpg3EVDw456svTyNNApNaExQDD9araTStrZKjG7FEJCZFztU?=
 =?us-ascii?Q?D68e1Do9CO45+ZDDeKzhPcB6HUKR1+SUpqQU6L7YEvJnejX67LwGcHPTHWfR?=
 =?us-ascii?Q?ABHjujZpKp3GuZgtUwmS43Gd95xwyAKzjc9R1eguMR+dJlDNwDfeZrADtVqJ?=
 =?us-ascii?Q?h89Mm758DonzcaGJVzz6vXPp3ON1LWtWpXIFJh808REl4nCaqvdDvPD6YF8v?=
 =?us-ascii?Q?O4cgbcc9wxZN+h00XQ1IPnSaLR9IJRZzpsS8L59+jbNfuupFxScqJcmwhgzm?=
 =?us-ascii?Q?CxMlwovzkowzkRTq73CSOnAZaw1cm4zdqHMKwEZlmJ4y50HSJdIUE0eEjL5W?=
 =?us-ascii?Q?spjIabqhJLv9wPNULOtnMWIlIzvlUkk1YydGUr/UfDY9jxKypGTHDU723JP1?=
 =?us-ascii?Q?b+4tBThwi+XR8Y2Y8ZlBLf53DSFR7mMPtzQBuilO9OCLXu+IQUl0I/KuCUhM?=
 =?us-ascii?Q?JvVudjPgUipGy6t2nw1PnGTNGMOQd5/YKrmiHxIy3/56xurp9xWjmPZ+cHcd?=
 =?us-ascii?Q?0p7zUMhB9PcIFBlnEbtEhwQkgxAYZQs71EgNSzJCg50n8p+72nmq6+/ahzZu?=
 =?us-ascii?Q?ZaOfU80gr/TLmJPnegQIq44xO4GegnVnOcG/hf86IQ7/7HY1/EEh5GHQ+xTp?=
 =?us-ascii?Q?YpISgLX8jMmpTd+4e7t4DZEa3YUt2bUBliZVBa3mTiM2N9QuBKPO1SV4M6sn?=
 =?us-ascii?Q?3ADTMIb+Pus5S8HqJaj7IkjUfsxZKxYoaDgwuEbh8xhb4JqV2TTDYnYZDTec?=
 =?us-ascii?Q?VXD9MixAKDgFypy1THuP+wJIUfCk71Fhhz2VnyUd212ge550eOah2U7qEGQ5?=
 =?us-ascii?Q?ul8EgsUwTuGh0jn9niZaSYqwkM8hSqhMj3dj7ua87v7RLiRsh93sOZRz+b2V?=
 =?us-ascii?Q?WjTfBGo1xR2Cp1/pwmozVFmprcMnx3B5lNzYtcHHqXBbzCgOcNiQeUdyXjHW?=
 =?us-ascii?Q?8ULVd8lLz8uxdsOo1h7uWHIgOeBx/11i63x6d+Mp4LFBQvEplOZZHBfdaujO?=
 =?us-ascii?Q?Xody1UOfBztGMunG8VYD9pW1L9RP8mCEtj6VOVYqHjlfCgFoW5s/N3ZUXtMh?=
 =?us-ascii?Q?soWKQyM+n9W2Geg7pwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9c46d-fdcd-4858-65ba-08dcc6a9308b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 15:01:54.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XluOigaDuo/dTp16NOkEKp5qaBJ/0ykNv806cipThD9eUTagT3kcIOkcPO7zr52ezCIqHqjECJdd4vNu99Oi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, August 27, 2024 10:21 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org; Xiao, Jack
> <Jack.Xiao@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
>
> On Tue, Aug 27, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> > From: Jack Xiao <Jack.Xiao@amd.com>
> >
> > wait memory room until enough before writing mes packets to avoid ring
> > buffer overflow.
> >
> > v2: squash in sched_hw_submission fix
> >
> > Backport from 6.11.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3571
> > Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command
> submission")
> > Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")
>
> These commits are in 6.11-rc1.

de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
was ported to 6.10 as well:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/gpu/drm/amd/amdgpu/mes_v11_0.c?h=3Dlinux-6.10.y&id=3De356d321d0240663a=
09b139fa3658ddbca163e27
So this fix is applicable there.

Alex

>
> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> (cherry picked
> > from commit 34e087e8920e635c62e2ed6a758b0cd27f836d13)
> > Cc: stable@vger.kernel.org # 6.10.x
>
> So why does this need to go to 6.10.y?
>
> confused,
>
> greg k-h

