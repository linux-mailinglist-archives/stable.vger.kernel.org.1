Return-Path: <stable+bounces-224860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PV6NrnCsmmvPAAAu9opvQ
	(envelope-from <stable+bounces-224860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:42:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E648D272C9A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D4F7308AA05
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2D2836A0;
	Thu, 12 Mar 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="kdDy2zut";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="BjVQcJX5"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737C28469B;
	Thu, 12 Mar 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322359; cv=fail; b=lqqRcRZgzi1OGPDDYbvEaVxaB/DJ9xENa+NPRPjh2Ybv6yagUXgNiBPQAlqEUC8sKH/rQRoVs21S729u9EFtPEKWqaBMS7x/HsbKp+IMLM8RZ+cFpW1h6utj2q/8JIxRKcfmB7SV8LNleEsqj9qhb3Uss2DQaAoTlbS6kwdT9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322359; c=relaxed/simple;
	bh=mqiJMBdopkpBKdk7pwH5o+rU7xYQWjOOR0eAQsS88t4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvN1BsZu0qW3JqQ4KS/sI4b53V9eZhG1vgmwvwr6/iktrMks2C3k4Um4Ui+RB5yx1W0tM/UW9dSmMnNJGJ4zkQuw6vzwdYmQSxy+I5MWKkUL+YC6Pgm5Bd3MevuZiVMogKt7VYZXFijaNZnl2MBJw1E8UIbRlpgd5rk4GVM4zqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=kdDy2zut; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=BjVQcJX5; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C6C66u3984755;
	Thu, 12 Mar 2026 13:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dk201812; bh=mqy0Gx7817wvY2+A3x1Bl+tt3
	5GmP66skdmCgRKKcvE=; b=kdDy2zutbURJmssbk2yeW6cCwNKH3n3PAlNXKBqrR
	HXiSg+8od5wjini0nyw0KdgsV4/k+3kEZFBh0rXDqW9rJl0oZOwyKgBo5I0Obk/f
	uq8MlO9SXbT+QhePoHiV7fwldYgu05MpdshwbCr4w9KIkPE/0sQt7WwJTfi6kV9h
	62wF+bkFeyQbuA4C8kdUfZYbVOWGL1QWUWs0k1NkY8Qq04mEdfD1ARV2iIn5j9Yu
	bKYgNigHaEwg/w4Nf+eJ0AT6U1dBxZ+Lf8OmA+QGc7Jw92v/PlnM0f+7brA4AWp4
	vUbEhVGoKKZD05xvRHV9pV8DTjsNxltUTPls79jv9xsBw==
Received: from lo0p265cu003.outbound.protection.outlook.com (mail-uksouthazon11022143.outbound.protection.outlook.com [52.101.96.143])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxyghjx7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 13:32:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn8g98Usi496zZGfK+tTYpS7W3j0alm9bK3+G4RzA6RiH9/+SVirxwegqQNmR74WrgMo9DMBa3zVtxRAW649RerSEOsi3ylfh+If4GZTWLCor/Gd7nxscTGtnzIRrsPolgVXzR4lOcLJTTo6vej8hKkuRf6jf/7dR9q2cZph1bhUA4lEAj/RYJb/2CK7S0wYmgA1t/ENZ5tyin+x34TCa3sLmrlqtA0ZChOUzWsjDvkhWO5RI70EgTrOJ/htovQ7XFdmZfdCx4RS7DcZ31zht+dbNquvRkYjYLEcuMhZMa/B0IUu+lN+tsyydWPBdhcVnYke/FTrWEFFlpGv9At33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqy0Gx7817wvY2+A3x1Bl+tt35GmP66skdmCgRKKcvE=;
 b=ZMTDyeF/d0aCMmYnJWr4r/6GpKG6nyg3WoO8MeviK4lt5bmTbsgbY7eznXwtFPIF7z6fLafyzB6gByaJusb/UWeJkoh3rnXjoCESqkLe5hp9oX0D+kSxSK3QaSW+GXloJUr/RMpWVcgwqmAWx2DRFoUV95KBaTgJVu5wuTlWQDOO/roze4eCN77RURFPSrJW+ZzFQhyEUsNYP9ZQrkQMKgOvbMQrvyRjVTYzPO9cFBp+w6M/eAcHjyw4neJeWSue0pTyB0FjzMJK9bpjBtyUnWqzacIk04BOj2QATv+16zZ8NKjDfmJG8tFZlxo4c5OTkMKKNyFJfZcsrzXT2Zh3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqy0Gx7817wvY2+A3x1Bl+tt35GmP66skdmCgRKKcvE=;
 b=BjVQcJX5MzeWWLb5xyLLRO2MAX2OGN7/YkGvp8YVk+1FRDV8aR3EMO8eYkpnj1i71eAnV77kWoBCuiY5VYk/8P6eOy/11b2DuhnNRXARgVKRY9Lc4kGOd576XE6hWfRn6X+WnIijyPsKjCJDow8Q1yo7d3H8ij6AjPIMNsMBU4c=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by CWLP265MB5578.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 13:32:05 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 13:32:05 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Alessio Belle <Alessio.Belle@imgtec.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        Alexandru
 Dadu <Alexandru.Dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/imagination: Drain interrupts before suspending
 the GPU
Thread-Topic: [PATCH 0/2] drm/imagination: Drain interrupts before suspending
 the GPU
Thread-Index: AQHcsILeKI1jLLjePUeijw8FtkQpkbWq6DQA
Date: Thu, 12 Mar 2026 13:32:05 +0000
Message-ID: <008f3c3e-bcb9-40d9-a1ad-bcf68c7940ef@imgtec.com>
References: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
In-Reply-To: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|CWLP265MB5578:EE_
x-ms-office365-filtering-correlation-id: bf503b17-5eac-4cb9-6ee0-08de803bc070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|1800799024|376014|38070700021|4053099003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 aqDSha5fPUT0+UqGkbLuKcVNvj/JvxEniLzkgVe4zga5kKllo8sQwzseoxbg6lXLk3RSC2/1Q/TPFESfSKsrgoYLKtQZjQQ2SGmuF07wgzK24m5FAbj75svkGvmTV61ApucN6xVXVhTvXHOlVXoeb/9gaG82bs0d1t1H+5AdvtK9FBwdLX7kLeGvFtZD0G9F4fhjKlZZwRfsDlLNtmWf6wqDyp/hpS8jleRaUZa98xdhOPzxIPt1M/7mYZ/1wtlpxJiN9Ym3TbbCQj4GUZab8jcazirElm6my8yf11wM43ZFu2+ACzI+xPq4CNinhmCdu9zbJM9FQnVJzISQaPUMmvTGwHFguSZuEt/pctQ8d3gP907AX7m0XX1WIgEai+QSm+RWVzLuMcWHdQLKk+DA9w263rkhpNMVsDLNlFjweJ1ENeKguxWQBtFcpik3sZqhTAzS9wdi8TKL/MWGuU0FFE5keUxqVryQH0jGmCvRTXjFS0KLu73KLLeBQMCe+T+Xt7LZkOyq2vEYC6cBin1euNoSAJDY7h/gm++G8NWLiJjC2RrwHXSc9ybq1l1IKMsidzUoE1poew9cgCqdwaB0hOm+Xlr00smm+by8SonhN0x68UJIdAFMHxUW98LFXhF6JQxIaK63xUMDmMA4OtPSPm5SV71Py/KC0malVEP/SQq3iJGWAxJ/Dpqn7jlzup98ysIBX7nkAtpGdhV320Wtcp1EkrEt5bEPkMEZ0posXGeVp0m68HOdF5jiscpqvMxXcqFrJXq6xu1YGWcGdtNl92Ad6D9wl+me8WoT8AvEcbQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(1800799024)(376014)(38070700021)(4053099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3lVcG8zcEppZno0bTg5SDlsaGdLRnl4L09rZmUzbWMzc1p1bTd0N2ZIeHhi?=
 =?utf-8?B?ZzZDZFhTMFVhK3hJR2N3bUlJS0o4YWEzTHVDWk9XMHpQRkYvVllYWWtRV2pa?=
 =?utf-8?B?WTFsSEcwb1NUNER5SUlhdC9wWHhRY0tWTFZxUi9uT3B1NzhEM0FIR2tiWEZ0?=
 =?utf-8?B?T0NPZXNDSzVxc2Y4TWJsNk40LzBLK1kwYVkrT2JnVmhZZzFzdlZiYlk4OThj?=
 =?utf-8?B?Tk5wWHVUWXdjaXhhYUpSUk81Rnh6RWcwWmlZQ0JLZEU3RHcxWmJNQ3ZMT3Rn?=
 =?utf-8?B?bjc1czV4TTd1RlVjNEpaendEaWNXeTZSR0YzcVlkOFBXS3NwVUIxd3RjUHBP?=
 =?utf-8?B?MS8rNld5b0VVcTlWQjdiSWd6VlpENkh4N1ZOQ2E3U3BhOFB6V2JCakFZTXUw?=
 =?utf-8?B?dk1SUXphM0E5K3B5OUNwTDVaeHQ1YWZ4Z0Y4b1BpYndnM0FsNVdWeVVjOUZX?=
 =?utf-8?B?Nk1FeW9VeFpWS2x4Mi9ldTNLcUc4OVdVa2tNdVhkampBMmRBZitMNExHMzBv?=
 =?utf-8?B?a1o1RGhQS09kbVN1MDlSd2JUTklzd3JKb1hPZlBDdDc0R2tZT0lOMEVEbXZu?=
 =?utf-8?B?Z3ZzT2J3KzJkbkQxNm0yOU1nOW9SL1B5b1ZCa0tjSmpHZHF6ZmhwVlJudk4w?=
 =?utf-8?B?SWVWNkFvSXJsOWNBWkNFZXAxYUtaaGFmUlZwWnRrbmZudUpOWm5SNjRkT3Vj?=
 =?utf-8?B?UHBKL0xwRVBGa01VWkEvQkRtTityRVdpUjZNSlFKeWtoOGNFbDlzR3JHUXZL?=
 =?utf-8?B?M1A5czhQaUg0cUtvNTlEREg3VGh0VzhEam9KdGdxZmtqVUowT1JQQmRuT3VU?=
 =?utf-8?B?clVEVDV0cm51Qy81MkM5UWlNc25mUVIwcW9BajRxYnNXNFlsMnZteFZmSmZm?=
 =?utf-8?B?OWJjdy9URUpudjlabURyS05zM3kxd2NhRCtRQXRobWxTVnJ3cUo4SUxiQ1Vy?=
 =?utf-8?B?NExjMGY1Qno0ajN1VFVxUUtMYUczSHR1UEVndU93bElXZFJOd1Y4UnVGRitP?=
 =?utf-8?B?TjFNaVpTdFlVWE9RaTJweVF3b0RVcGZ5WmZOZWRQMlg3aCtyYmFmU1paSkdu?=
 =?utf-8?B?T25may9kaEg5T0hLL2FBeVFZTXVVNDVUb1BjMzBaMkU3N1Q3eTlnTGt5c1FS?=
 =?utf-8?B?aE9rcEVmaGxZM245YXFQUi9mN0c2SmdUdU0wV2t3SFdLYUxJUk9BcERPK0Zu?=
 =?utf-8?B?elA0WlVMUEgxbmNYdjNlaUZTaGE5dit6NU1yTGlKVlVwYzZWMy9TZW92QWlZ?=
 =?utf-8?B?Nzl0bjRucDRJc0laTncrb3hOVzBBeUhIM1pJb1dPenQvUGN3aGQ2a0VTK1E4?=
 =?utf-8?B?Mk12LzlnODU5MWFMVnJTdnVVaVFTRzV4Q2plSk02bmJRdG0zM1doKzdWNFNj?=
 =?utf-8?B?WmJtcElGTlVsMkpkTnFuRFVkOFVoRjlqWWYvd2xWU0RrQXpsTmp2c3FJYnly?=
 =?utf-8?B?R1FYOFBGUHRmOFZNdHZidEVxanV3SHBKaDZodlkwQ3lMSVFINnRzMitZcEN2?=
 =?utf-8?B?NWhjODhDczU0M0VYNitLY2kvU0QzL2xsVldVam45UkNXc1MyMWNnd2ZmR3l3?=
 =?utf-8?B?STg3YWZmSWMzMnRQMUMzTUlyNVRpMWJja2loWkFYOFZiSHcybDM1alJ3M0JC?=
 =?utf-8?B?ZmZISnNaWTMyVkhVdXdqTm40cHovREM0SEdVYTZRSUlxbis0RU9IM1VQMHpt?=
 =?utf-8?B?VUt2ZmpGYytSZTVYS1J0U1lSbGFxY2diUDg1QmVDUTBjM3FybGQ2bTNIWEJJ?=
 =?utf-8?B?MjRqTktxNTAzVjFoMGxGSGJSMzhWQVVieis1UG9ZR01rTEJGUGpYblJsZVBy?=
 =?utf-8?B?YnE5VU1yU2Vwazc0dnFIenV3SCt0dVJtc1QxMDdOWDB6TlJ6QnVWZVAxMEhv?=
 =?utf-8?B?ZjJrL3p2VlFXNXNzSjlMUncwZWlyb2I1OFZKZVlyK040elF1WEM3aC9nNi9l?=
 =?utf-8?B?d0x4Nlg4ZkdCY2tWNWh1NVRKM2trbzJUR0t1VEFSVW9USUVzMHlWd0RSTG1m?=
 =?utf-8?B?Y0lKblB4dk9QV0FCWTMyK0drOGNGTE1kSGJtWkFkVzNPWkhkaS9nSCttYlJL?=
 =?utf-8?B?WXE3RDI0WGduQVFRQmptM2luMkVTdXk3eVFEVWdrUGN5SlhOcjNYRWFobjVG?=
 =?utf-8?B?OXZNb1pyR3RaVExDSkZSKzhlTk5hSkZpRXFUQ1Vtb2pQUFBxNFF5V2xmUnpr?=
 =?utf-8?B?OEpobUMrdVZYMkNSUXFtek9kRGlvd0hsa0xQR1g2clFXTHc5Mm1zV2FIZ2Zy?=
 =?utf-8?B?cVRZK3VDSlZEQ25LVEVVMHU2TXV2TmI0aGhoZDRxdmFDVEhQMFlwZTAwVUtk?=
 =?utf-8?B?aVdFV3VMbmhyTlBsQTNvNjJ1am04RXpQVGRGUmsxN09YUThQaGdWSGhXWGJB?=
 =?utf-8?Q?AZ9ZngknPH1iCbHY=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------KzkfmLUz5MdQXfKqUzL47Gk8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nG8+Jr3AJgVF9TB/39BRFX0tiIWrwJerpeM+f11ttzHB4QbSWQmG/lxBGmEi8R2JgSDD370OKOXsNBUbu+217xTKXVge6s6sjajCER0iRQiefnxD81t6m0O4eq0nlbebK0gfLMKBoRA8TNw008zM9Cl6RRgVDoNphsDATZ8df6Ok+CmbcMrEZrU+sy13+U/G/FaNltfRAPZOQdArGJevdNUTkfdlmje5ni1hJhC84pPq09m/rLFarqia2noinXAHoD9A8BQrTRtmGnfRk7Qsah1MsXCHfuNrpPe2YPu0HYs0D1A+dDmmpv7NT+hoT622QyswKP/VzJN8TVV29HCksQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf503b17-5eac-4cb9-6ee0-08de803bc070
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 13:32:05.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6x7OM5lLp8Vk+izMsFk/nCkryZ1TzBwb3T0p0oWmuCM3Bqa1ytGTkA3+jIZwf87RzsVUYol8aH1K4JukZZffig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5578
X-Proofpoint-ORIG-GUID: XpcLoMzhLyibqSYKg-NPiqS2QvUMiGqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEwNyBTYWx0ZWRfX7r4vCGXd61Cy
 311UuguvAMwLpWGIzSYR8LkwnIjuajZ9po5C2ImRkqTHG75cqHBnKcFl0/6BzjPreVb7JG7ypzP
 S7vqr2GQfB0XJKn6EO06Np4ORWMoUaSQFvn/XpHPHQEWlqqeo9tWxzFo32GmnA73GwuEQrebvqj
 E/mC2gprCFc2+Mu8i9mFeDDccT8rPVyuolfKqo+0kbWSeYkR8CALonB/N8ZzOyI3fkh4/TGF3xs
 hOI20UdNEcVWioUCw+fcAS6KKgpCgq8i1bP4+yIl96scU3qjCNGrqfu9OkuAbI4RUJTsMvl5Aqw
 ByDfk6wQ72HN0GGuClQexkn9ETqxekPHH3s396Hb3kM+JRImW3Y6w5ASZbVMk5SwIgsZaf7XFyt
 UKhxvdAIQkHZqjxUqhoV6DgqRVYPo6Rdx9S/hRlADpyFY8zMZ1ELbomr6+lH4bTznik4czpiFL3
 ptDqfg9Hi/wGzw7198g==
X-Proofpoint-GUID: XpcLoMzhLyibqSYKg-NPiqS2QvUMiGqe
X-Authority-Analysis: v=2.4 cv=NevrFmD4 c=1 sm=1 tr=0 ts=69b2c05b cx=c_pps
 a=KeprtYQnYycZG3mihyX27Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8 a=yuQPPJYho97F90SWNWQA:9
 a=QEXdDO2ut3YA:10 a=M5VlQa-rWNmsoKs23CgA:9 a=FfaGCDsud1wA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812,IMGTecCRM.onmicrosoft.com:s=selector2-IMGTecCRM-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224860-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,IMGTecCRM.onmicrosoft.com:dkim,imgtec.com:dkim,imgtec.com:email,imgtec.com:mid];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[imgtec.com:+,IMGTecCRM.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Matt.Coster@imgtec.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E648D272C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--------------KzkfmLUz5MdQXfKqUzL47Gk8
Content-Type: multipart/mixed; boundary="------------pVFob0fEvH9cMcgu47dQBB89";
 protected-headers="v1"
Message-ID: <008f3c3e-bcb9-40d9-a1ad-bcf68c7940ef@imgtec.com>
Date: Thu, 12 Mar 2026 13:32:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/imagination: Drain interrupts before suspending
 the GPU
To: Alessio Belle <alessio.belle@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>

--------------pVFob0fEvH9cMcgu47dQBB89
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/03/2026 11:41, Alessio Belle wrote:
> The first commit is the actual fix and will need backporting to stable
> branches, though some of the code being removed didn't exist prior to
> 6.16 so the patch will need adaptations.
>=20
> The second commit tries to prevent similar issues and doesn't need
> backporting.
>=20
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>

For the series:

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

Cheers,
Matt

> ---
> Alessio Belle (2):
>       drm/imagination: Synchronize interrupts before suspending the GPU=

>       drm/imagination: Disable interrupts before suspending the GPU
>=20
>  drivers/gpu/drm/imagination/pvr_device.c | 17 --------------
>  drivers/gpu/drm/imagination/pvr_power.c  | 40 +++++++++++++++++++++++-=
--------
>  2 files changed, 29 insertions(+), 28 deletions(-)
> ---
> base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
> change-id: 20260309-drain-irqs-before-suspend-8f9c656516f4
>=20
> Best regards,
> --
> Alessio Belle <alessio.belle@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------pVFob0fEvH9cMcgu47dQBB89--

--------------KzkfmLUz5MdQXfKqUzL47Gk8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCabLAVAUDAAAAAAAKCRB5vBnz2d5qsO6a
AP9aUn/wDjS4AWDRGG5biCF5Qf0EDwMubHlc+WSB+rlO5QEA+YAzM1Z8lB13hjgojVfLthhVmJ19
IMi7s6FhqjNVkQc=
=3vX5
-----END PGP SIGNATURE-----

--------------KzkfmLUz5MdQXfKqUzL47Gk8--

