Return-Path: <stable+bounces-127292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B091A7753B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CD6168FBC
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A81E7C18;
	Tue,  1 Apr 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfXuzOGf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9E126BFA;
	Tue,  1 Apr 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492649; cv=fail; b=bKP7lzZXobYPPKi29//YiLlf5vv1kNc1wHMOgTYuy34fNnx1XDUn4llJQGzku8hBXuVHmRLeWuSOwVnhFl9A2Y82DAAsrflA0SofzxcsH1dhephlEJu5pYMaeC5HurEN4DnMymuVjHNumwVGZr2eujTERYyRd4hUaDxuKai8F+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492649; c=relaxed/simple;
	bh=rtO8eX0LmEYPFOJVLo8WsUbgJCEz05S4nqWphcU43Es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dn7+MDOP4xr7OhG+GJnlVrpLiWxcvg7KIZff6k3//gvo5Nh8emT1y2/gI9uoQM+BCQ9lkaDvC7ExBsrCCYGsP2M10akbDX14E/4CjuYPSTRgchZ7un3xl2M+BY2FieeDhebaid8mbRasJh/Fo9Bp2J+1eyyoKGRQcdbBbUEXh+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfXuzOGf; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBk9tyJVwOc2tNjfOJFOw+Z5xkPE+IFiihhI/RZW2c9eYIqHgrRNcP+Mp4mUJZjIayxAlkM77AuQwNDX8Ix4m3a3or67wcN8i/bBXSVrNy/A8/y88efuugOKXhij/Sr4ALId8aocymYC/LeXqtx0sQg22YeyMmeIohrtiC8P+EO6KDXtTqD45ASitC9F1u1CCAU6rypTlrwzQuYscZMlysrenjWRHfXdJHmIeLNX2zg5/tyOQPJHHyvLNebISdvZdyEO3nhQEp4lx16PWu4hWTnhFyogtGViA9v3M4C1b+4pOHUHm9Ck8Nebhv2SiTEngcPphb60DU0vzqEwxfMxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtO8eX0LmEYPFOJVLo8WsUbgJCEz05S4nqWphcU43Es=;
 b=XA3uCIxwZ6DjjQxNh4IMNc3ZRc+J/ugvhT0nrg+zsfBJT+vDI+lZ7fYQzZN2pf+oweNHQDQAaZTpH9ZDBDNyvNTiZA8DeYPdmBp+TPdpwu5oMq6LHB/HNqAj+edKjgnJHm1rdxJcV3GuKXjRpRCboyibZ3WQHD0xlbgrB3Ui/Eoa3gtA+lKY7P8OrLq6GzywvqR176NIcm8+RjJU0I1arUf+F1e5Ru6t97h2UzMjyw9kwYcW9yHJu8dhzvMrYzXwT0uSTV4e1z1gGey2bFndaRhsKPVfEQPKHVs3fsfusVsSXCZ6qN37QE8ietLrCbvgCZfMyPh6WTfMt4wfYeL6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtO8eX0LmEYPFOJVLo8WsUbgJCEz05S4nqWphcU43Es=;
 b=mfXuzOGfQHOLbPlha2H3ZvYDrAOyjhoU9ZX1j31Bve2i/qC/GuWX5+sn4c8jh9s73HJv6v4Sh1EfEjrek4pdE9ELEDoCi3SkJCRkKmojRZOdN0O00zCl39urbXCPgCEjGdreldPkteQsdGebzufvgDyAxIFrFlw8ia6Rny2oW9/yFkpMa3fQbhcyDOYEiB9FJS9fLqMDEo0Y4mTHmVaJwVRVot3kfqYbPaYtOU0ueI/Ut/zQAsW1Ma+ouMYhmoFalVU895+vGvsudQ/fKhLGKwMv693/AubW8hNfBnOcfn0c9kmRPZH7wjbuJ2+epyb8SKeUOXanCdstt0MC4W02Mw==
Received: from BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 07:30:44 +0000
Received: from BL3PR12MB6474.namprd12.prod.outlook.com
 ([fe80::6e55:f98:3698:8ce4]) by BL3PR12MB6474.namprd12.prod.outlook.com
 ([fe80::6e55:f98:3698:8ce4%2]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 07:30:43 +0000
From: Wayne Chang <waynec@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Jon Hunter <jonathanh@nvidia.com>, Jui Chang Kuo <jckuo@nvidia.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
Thread-Topic: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
Thread-Index: AQHblLN9A+bf76qItkunyVgUws1mpLN9jjsAgBD4UYA=
Date: Tue, 1 Apr 2025 07:30:43 +0000
Message-ID: <87b2a1a0-a3f3-491f-bc54-73631a5c2f0a@nvidia.com>
References: <20250314073348.3705373-1-waynec@nvidia.com>
 <rxr3a5gzlmb6z2x36bwiy6lprdbrjgiojyoqznybyzglpeor7b@gy43enunoxyx>
In-Reply-To: <rxr3a5gzlmb6z2x36bwiy6lprdbrjgiojyoqznybyzglpeor7b@gy43enunoxyx>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6474:EE_|PH8PR12MB6746:EE_
x-ms-office365-filtering-correlation-id: e09c176f-838d-4f1e-ef5c-08dd70ef1c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1hwSktBcW5JK0llWnVHUnYwNGFtM00wYm5PM0JxMkRXZXMxQTUzNzNLajk4?=
 =?utf-8?B?RnNwVjkvMDlPV3BMNFJadFk0eHp6UzlQaFlkWkVXOFArMVFZTnhzYXgyZHMv?=
 =?utf-8?B?OTNzc0tYcmVmVytJZGtSUGttWWpFZjNMWXFIZUp6ZkhiNWkyZHppNXJwM1k3?=
 =?utf-8?B?V1lUZEFiMTNtTU55MFBiNTdMT1krYXBuMGtFT2ttemJxWDcrWmp3Ty9pLzR6?=
 =?utf-8?B?NFR5VmkvNGg3VlYxQXYwWWpqMnFhdWVpK0t3Y21kTm5LY2ZQcE83eUN3dEVx?=
 =?utf-8?B?MXlqNGxMcjhZRXZxQUZ2c2VudUZ0T1ltekRKbktJbkxZVjU4M082V0JSTE90?=
 =?utf-8?B?WmczT3AvcDZxakEzNUI5ODRuM2JQUnJORnhtY0l5TXFUdHJxL0kwOS9OU1Vu?=
 =?utf-8?B?YWFrSjN5ZVFIOHFMTTdWYUFGcHlDR1FHajNjWldqTGtYdG9RSUJkN1AyWi9y?=
 =?utf-8?B?bmwwMERDVnNxTUwvdWtsY2sySlNlbEhFQVpkWmw3MGowemNKWk5nRkp0dzly?=
 =?utf-8?B?dG1iMVZLRGMyVGwydjNDaEVpd2JKMkVqQ1huQ3Azbm5ZTDl2OW9JREk2YUhO?=
 =?utf-8?B?S0NUdjlHd0h3Y09wUmVVMjJ5UUVFYkxya1dMQk83endvV25TZVovWVRhZVox?=
 =?utf-8?B?NmhodGp2OHcxeW51SUlRVkd3SytqNS9WcEVUc2podmUvVWxIdkQxemZhbzNh?=
 =?utf-8?B?VC80b21UNzhXMEpCY2FrMWM0VlRpMWVtWENQaGQ1NEt4UXdGQ1JyK3Yza01H?=
 =?utf-8?B?SVlIYWtmT1pHRlBZSkRFRlRLQmZLaGhISmRGbTRVMXV0SnRRaXFKWUFvamhI?=
 =?utf-8?B?TzZLdnlocnNRT1ZNN0lzN1dUdUJkajBXU2RNY3owbkRJZ0hzdXRqWFhWYnMw?=
 =?utf-8?B?ZExYdEpzZk1NcGExUmk5clpIWEl3ZVhaa0M4Ny9MUFJmMkJnYnJiM29iYS9N?=
 =?utf-8?B?Z1doSUJJdlNWcFFmb0ZEMC95WkdjWVFlUnc4YnFQWVVCYTFvT2kvU2dzaGMy?=
 =?utf-8?B?VTJzOGNQSXJlUnhMUC9iR1ZHK3lHY3VQWlRqaWdQREpWdUw3N21WRFIxOVlj?=
 =?utf-8?B?N2RuVXg1eHp0dCtXa3UvOFNlaEk1c2pMYkkzcU81TEd6NE1LZ0NoVVZHY3R4?=
 =?utf-8?B?NThNM1lhay81NVRrVitPSUI5cG9UZXNxTDVaSExURWN4Wm1Td0h1VGp6aStT?=
 =?utf-8?B?ZmpjTG40eHRMWThpSytRaUlXSmV6NnVqTlA0REV3V2NLUFcxdkJuTkVvcHEv?=
 =?utf-8?B?QjYzOGR0SG83aGcvK1ZOMjBrbVZxelhCcDE0YzFGL0NLVVV5R04zaW81dG4x?=
 =?utf-8?B?Y1YxSTFTUFFZQTRzVzVvbGZRM0hUTGNESU5PaEh3T3NCb3pEWFNZMWdaMlRR?=
 =?utf-8?B?V0ZRSEsrQ2JwSnBsa2JBUTdrTFpYM2k5Q0h6OXAyMmQ5aEQyN2xWNTZaekxi?=
 =?utf-8?B?Y0VQYmtiNU52Ly9IRUVsTndwa2IraVpJa1pvYzQ5cjhuTVBJOUs0Q294U0VD?=
 =?utf-8?B?WmJhbnR6cGVQc3ZqakxybGM2MDBVMGpCWkJESUJkeGhsb2lWMUxFa1V6UUJE?=
 =?utf-8?B?SlkvN2swcW9PTkhvY1VGVy8xanRTZktLRHRXMTdYcTVvT3A3bzdRZXl1c3dQ?=
 =?utf-8?B?T3BydjM4cVBreXljOVZvb1BsaTZ1NmxNUy85WU5aS0dwTWJCT283c2J3Nklz?=
 =?utf-8?B?MDlxNkg2R2JaWW5MNEJRNUhKcjFUSW00L0htN0NKVHdUeDBNWDE2UlNRckVy?=
 =?utf-8?B?Uk83NFA5RjhzbE9yTWkyUFk1ZkRsd1ZQd3p6K0Q1N283bjh4MXFGMkJ3T0hI?=
 =?utf-8?B?am9EWWdJQTBkcVJQOWlLbTI1TkVnS004Zjlzc2oxSFhqdklWRVZGU3lqNVpH?=
 =?utf-8?B?QzdXSXZFeG9jVHd0b2Q2bUswU2V4Rll3aWMzTnZuUzkrdFNmYXNpWDkxSEJD?=
 =?utf-8?Q?fE45gWeuY2r9xn2kgVxW7Trk46GUAPB9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDE0UTQxUGNEeEk3UkJwOXZSZitka0NpQVc0NUpmNE1YRU1DMUdQRlNDbkxH?=
 =?utf-8?B?d3JudnBwUlQrUFR4TkF3THRxVEtGWk8xQjQ0cWszTkdxUTR3WTJySUVpM3ZH?=
 =?utf-8?B?cXJBOUtkOFJPaCttZnViWjg0djRxQTNRQ3JlSCs3S1hjQVRnTW5MSTRSaVJF?=
 =?utf-8?B?TEdnZnJhbkE0WHlCL05KV1BLREt6eUhXWVFVZFY5SVFYZmVLcTBJK0xQSFlR?=
 =?utf-8?B?VVIzODBBQmY2MnhNNUFlTFVhQ25Qck9IWHRSaEo1aDM3TG1ML1dRRExpekdw?=
 =?utf-8?B?eXg4Nk9oMlJ4NmtzdEt1U1JtU1NNQzFBamlBdUd5a1VENGpUMUJVbndQMmJE?=
 =?utf-8?B?azJzTVZiWnNSV1BaeWlCZ1NuOW9UdXBiN09FR3ltMThWTlR1ZTJCRnI2eWJp?=
 =?utf-8?B?RGYyRlVZV2Qyb011SlFCeTl5OTZqQWtkVTc4ZkR6L2RheW42UkEwM0NxN2Mx?=
 =?utf-8?B?V3hDODc1RDlNWTYrc3M0Y1JCT3NiUDZ1cGVVOTh0aGVuY2Y5UExTdHVBYUVj?=
 =?utf-8?B?SmVCV0lLVW92Um4rTG9JbHk5ZHVPOFRuMUlNK25mbjR1N2JPaWFicUt2UEpr?=
 =?utf-8?B?a1JpSDZSVzl1MDJhTytKUXl3NUFhcWx5YUZNK3hLQ2p1Umt3UktzSVUwUU9I?=
 =?utf-8?B?UkJLVWRqVkJ1czhwL2NYblBUWkVlaHBtL0JtNmFCRXNJdy93U1diUUFobUwv?=
 =?utf-8?B?Rkx2WkYrdmZrZms4b0x2eGV3Z0xoeUl3OTgxejNFd3VRUEtXNFZtaVgrZlpI?=
 =?utf-8?B?T1hldDRjckxTZVFhcmppczNYUmk3VW9ZZ0x1UU5YeE1YYnE3UGZoZis1dXlk?=
 =?utf-8?B?S2N5UGxEWENzeEMzYy84a0UvNTQzM1RIYXNiZi9QUWxMd05QTjl1SStvYm1Q?=
 =?utf-8?B?L0NzNXl1d2o2VXRYR0ZZbXFqWVNFVkRQaWNyUXc3VHlPeVRHZFZXUk5GVjhP?=
 =?utf-8?B?YXRaVXc3eWZlbWg5VytORGUyU1VRdDR2Mzlzb0s2clVKaUhsUW1uTStPS2kx?=
 =?utf-8?B?WUxET2RGMTJsbStOem4vS29LSVByWVJZL29XVGM4alhnOStTN05YQjlITVkx?=
 =?utf-8?B?TElqcTEzaU5veWRWWEowSlg5UndjNmw0SUNQcTk1N2F6T29VUzZ1Z1F5dHJ1?=
 =?utf-8?B?Zy9LdnRRRGxJQWNYUDRkeHA0YzMzc1h3USsyMTRubnRQR1MrZXZ3NDdldTJu?=
 =?utf-8?B?WTlSTWFjWWFtZFdJQm1wcEh4T2JaZUM4OVpEZitiaVpIaUt1ZzQ3a3FUUnNL?=
 =?utf-8?B?enlaaVZLaXNHMXFiTEFkOHpheFoxakE4bUxzSlhWeXgyYUtQcDZYdVFFN2RB?=
 =?utf-8?B?M3E2WkZ1WGlWWTRPelpOVGtyL0xWNDgwMXE2bzZQbUVraGtJeGtOSkZuSkZo?=
 =?utf-8?B?dWo1c1kwbksxTlE5cHRUdFM5elRnQklyRDRYZ2MvS3pQdGY2S3M1NDF3RHdv?=
 =?utf-8?B?Um1NOGZHQ3lYSGNIa2R3RHBTQzE3ektnRXdqTCtNVU9zbVNCQVgxaFE2Y05Z?=
 =?utf-8?B?TFZYVXUxZ1lERS9QWTgwKythRHdoNmd0NXlLTVBiVlVHTmdFa3FIQlBTdzVk?=
 =?utf-8?B?eUducDhGS0czUlBEQjJMRzVHRm00ckg0UDVXZ2dXRzg0M1dxNnNXdlFUVkpO?=
 =?utf-8?B?TkpJUGQ4MkxFU090U3ZNSTQxSmxRTGZBRlBBRlJ1STFBcVhlakJoUk13SVFH?=
 =?utf-8?B?NGUzbUJpeXkvQVp6RDc5VzlJN0ZXYThBclYwRTY1NG11azBPS2ptdnA4MGxw?=
 =?utf-8?B?aFJWeXo5bFNBOE81eXJMWVMxT3FGZmQ3TUVpcVo2cFF3SGR3bTNNYXJOZG4y?=
 =?utf-8?B?NTVQM09tK0VwSzN6dWVqWFNHRmxodXU3bFhKSGRTUU8vYkx3NmozYkpvb2tR?=
 =?utf-8?B?d2tWeTlQMU1IUk9rQVgybGdpVjNGcjV3ZnZmblg2elhPWUNQTVVoaXVTNkJo?=
 =?utf-8?B?Zndaalh3S3FNdkFWcnJaKzVIbWVuRWxZTXpKSzVvWjNTZ1NXeHZabDhWMmtx?=
 =?utf-8?B?WGFFTGVpSlFUVkMwL3pHc0ZOVUhBNlU4cHZVZHZBdk1ONzZlQVU5aEFlMTB0?=
 =?utf-8?B?TnVNbDdScWxpNTBsekVSaTRXYW4yd0RaMGNwdEtGMlk0ZWtGNnh2OE1LQTM1?=
 =?utf-8?Q?qceIegnxg06H0fpD+mr7TOyH/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5B2BC026E8AF8499D0A8F3893003150@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09c176f-838d-4f1e-ef5c-08dd70ef1c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 07:30:43.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2PMl0MBL9VN3UgPnybolCflHnOxBMTux+nT4/y/IG06rBhyzG7rvnBmozNI/aaEwrJhlCRqfx9xtsv04yJoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

SGkgVGhpZXJyeSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyEgSSdsbCB1cGRhdGUgaW4gdGhl
IG5leHQgcGF0Y2hzZXQuDQoNCnRoYW5rcywNCldheW5lLg0KDQpPbiAzLzIxLzI1IDIwOjIyLCBU
aGllcnJ5IFJlZGluZyB3cm90ZToNCj4gT24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMDM6MzM6NDhQ
TSArMDgwMCwgV2F5bmUgQ2hhbmcgd3JvdGU6DQo+PiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biB1c2VzIGJpYXNfcGFkX2VuYWJsZSBhcyBhIHJlZmVyZW5jZSBjb3VudCB0bw0KPj4gbWFuYWdl
IHRoZSBzaGFyZWQgYmlhcyBwYWQgZm9yIGFsbCBVVE1JIFBIWXMuIEhvd2V2ZXIsIGR1cmluZyBz
eXN0ZW0NCj4+IHN1c3BlbnNpb24gd2l0aCBjb25uZWN0ZWQgVVNCIGRldmljZXMsIG11bHRpcGxl
IHBvd2VyLWRvd24gcmVxdWVzdHMgZm9yDQo+PiB0aGUgVVRNSSBwYWQgcmVzdWx0IGluIGEgbWlz
bWF0Y2ggaW4gdGhlIHJlZmVyZW5jZSBjb3VudCwgd2hpY2ggaW4gdHVybg0KPj4gcHJvZHVjZXMg
d2FybmluZ3Mgc3VjaCBhczoNCj4+DQo+PiBbICAyMzcuNzYyOTY3XSBXQVJOSU5HOiBDUFU6IDEw
IFBJRDogMTYxOCBhdCB0ZWdyYTE4Nl91dG1pX3BhZF9wb3dlcl9kb3duKzB4MTYwLzB4MTcwDQo+
PiBbICAyMzcuNzYzMTAzXSBDYWxsIHRyYWNlOg0KPj4gWyAgMjM3Ljc2MzEwNF0gIHRlZ3JhMTg2
X3V0bWlfcGFkX3Bvd2VyX2Rvd24rMHgxNjAvMHgxNzANCj4+IFsgIDIzNy43NjMxMDddICB0ZWdy
YTE4Nl91dG1pX3BoeV9wb3dlcl9vZmYrMHgxMC8weDMwDQo+PiBbICAyMzcuNzYzMTEwXSAgcGh5
X3Bvd2VyX29mZisweDQ4LzB4MTAwDQo+PiBbICAyMzcuNzYzMTEzXSAgdGVncmFfeHVzYl9lbnRl
cl9lbHBnKzB4MjA0LzB4NTAwDQo+PiBbICAyMzcuNzYzMTE5XSAgdGVncmFfeHVzYl9zdXNwZW5k
KzB4NDgvMHgxNDANCj4+IFsgIDIzNy43NjMxMjJdICBwbGF0Zm9ybV9wbV9zdXNwZW5kKzB4MmMv
MHhiMA0KPj4gWyAgMjM3Ljc2MzEyNV0gIGRwbV9ydW5fY2FsbGJhY2suaXNyYS4wKzB4MjAvMHhh
MA0KPj4gWyAgMjM3Ljc2MzEyN10gIF9fZGV2aWNlX3N1c3BlbmQrMHgxMTgvMHgzMzANCj4+IFsg
IDIzNy43NjMxMjldICBkcG1fc3VzcGVuZCsweDEwYy8weDFmMA0KPj4gWyAgMjM3Ljc2MzEzMF0g
IGRwbV9zdXNwZW5kX3N0YXJ0KzB4ODgvMHhiMA0KPj4gWyAgMjM3Ljc2MzEzMl0gIHN1c3BlbmRf
ZGV2aWNlc19hbmRfZW50ZXIrMHgxMjAvMHg1MDANCj4+IFsgIDIzNy43NjMxMzVdICBwbV9zdXNw
ZW5kKzB4MWVjLzB4MjcwDQo+Pg0KPj4gVGhlIHJvb3QgY2F1c2Ugd2FzIHRyYWNlZCBiYWNrIHRv
IHRoZSBkeW5hbWljIHBvd2VyLWRvd24gY2hhbmdlcw0KPj4gaW50cm9kdWNlZCBpbiBjb21taXQg
YTMwOTUxZDMxYjI1ICgieGhjaTogdGVncmE6IFVTQjIgcGFkIHBvd2VyIGNvbnRyb2xzIiksDQo+
PiB3aGVyZSB0aGUgVVRNSSBwYWQgd2FzIGJlaW5nIHBvd2VyZWQgZG93biB3aXRob3V0IHZlcmlm
eWluZyBpdHMgY3VycmVudA0KPj4gc3RhdGUuIFRoaXMgdW5iYWxhbmNlZCBiZWhhdmlvciBsZWQg
dG8gZGlzY3JlcGFuY2llcyBpbiB0aGUgcmVmZXJlbmNlDQo+PiBjb3VudC4NCj4+DQo+PiBUbyBy
ZWN0aWZ5IHRoaXMgaXNzdWUsIHRoaXMgcGF0Y2ggcmVwbGFjZXMgdGhlIHNpbmdsZSByZWZlcmVu
Y2UgY291bnRlcg0KPj4gd2l0aCBhIGJpdG1hc2ssIHJlbmFtZWQgdG8gdXRtaV9wYWRfZW5hYmxl
ZC4gRWFjaCBiaXQgaW4gdGhlIG1hc2sNCj4+IGNvcnJlc3BvbmRzIHRvIG9uZSBvZiB0aGUgZm91
ciBVU0IyIFBIWXMsIGFsbG93aW5nIHVzIHRvIHRyYWNrIGVhY2ggcGFkJ3MNCj4+IGVuYWJsZW1l
bnQgc3RhdHVzIGluZGl2aWR1YWxseS4NCj4+DQo+PiBXaXRoIHRoaXMgY2hhbmdlOg0KPj4gICAg
LSBUaGUgYmlhcyBwYWQgaXMgcG93ZXJlZCBvbiBvbmx5IHdoZW4gdGhlIG1hc2sgaXMgY2xlYXIu
DQo+PiAgICAtIEVhY2ggVVRNSSBwYWQgaXMgcG93ZXJlZCBvbiBvciBkb3duIGJhc2VkIG9uIGl0
cyBjb3JyZXNwb25kaW5nIGJpdA0KPj4gICAgICBpbiB0aGUgbWFzaywgcHJldmVudGluZyByZWR1
bmRhbnQgb3BlcmF0aW9ucy4NCj4+ICAgIC0gVGhlIG92ZXJhbGwgcG93ZXIgc3RhdGUgb2YgdGhl
IHNoYXJlZCBiaWFzIHBhZCBpcyBtYWludGFpbmVkDQo+PiAgICAgIGNvcnJlY3RseSBkdXJpbmcg
c3VzcGVuZC9yZXN1bWUgY3ljbGVzLg0KPj4NCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+PiBGaXhlczogYTMwOTUxZDMxYjI1ICgieGhjaTogdGVncmE6IFVTQjIgcGFkIHBvd2VyIGNv
bnRyb2xzIikNCj4+IFNpZ25lZC1vZmYtYnk6IFdheW5lIENoYW5nIDx3YXluZWNAbnZpZGlhLmNv
bT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3BoeS90ZWdyYS94dXNiLXRlZ3JhMTg2LmMgfCAyNSAr
KysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS90
ZWdyYS94dXNiLXRlZ3JhMTg2LmMgYi9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLXRlZ3JhMTg2LmMN
Cj4+IGluZGV4IGZhZTYyNDJhYTczMC4uNzdiYjI3YTM0NzM4IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9waHkvdGVncmEveHVzYi10ZWdyYTE4Ni5jDQo+PiArKysgYi9kcml2ZXJzL3BoeS90ZWdy
YS94dXNiLXRlZ3JhMTg2LmMNCj4+IEBAIC0yMzcsNiArMjM3LDggQEANCj4+ICAgI2RlZmluZSAg
IERBVEEwX1ZBTF9QRAkJCQlCSVQoMSkNCj4+ICAgI2RlZmluZSAgIFVTRV9YVVNCX0FPCQkJCUJJ
VCg0KQ0KPj4gICANCj4+ICsjZGVmaW5lIFRFR1JBX1VUTUlfUEFEX01BWCA0DQo+PiArDQo+PiAg
ICNkZWZpbmUgVEVHUkExODZfTEFORShfbmFtZSwgX29mZnNldCwgX3NoaWZ0LCBfbWFzaywgX3R5
cGUpCQlcDQo+PiAgIAl7CQkJCQkJCQlcDQo+PiAgIAkJLm5hbWUgPSBfbmFtZSwJCQkJCQlcDQo+
PiBAQCAtMjY5LDcgKzI3MSw3IEBAIHN0cnVjdCB0ZWdyYTE4Nl94dXNiX3BhZGN0bCB7DQo+PiAg
IA0KPj4gICAJLyogVVRNSSBiaWFzIGFuZCB0cmFja2luZyAqLw0KPj4gICAJc3RydWN0IGNsayAq
dXNiMl90cmtfY2xrOw0KPj4gLQl1bnNpZ25lZCBpbnQgYmlhc19wYWRfZW5hYmxlOw0KPj4gKwlE
RUNMQVJFX0JJVE1BUCh1dG1pX3BhZF9lbmFibGVkLCBURUdSQV9VVE1JX1BBRF9NQVgpOw0KPj4g
ICANCj4+ICAgCS8qIHBhZGN0bCBjb250ZXh0ICovDQo+PiAgIAlzdHJ1Y3QgdGVncmExODZfeHVz
Yl9wYWRjdGxfY29udGV4dCBjb250ZXh0Ow0KPj4gQEAgLTYwNSw3ICs2MDcsNyBAQCBzdGF0aWMg
dm9pZCB0ZWdyYTE4Nl91dG1pX2JpYXNfcGFkX3Bvd2VyX29uKHN0cnVjdCB0ZWdyYV94dXNiX3Bh
ZGN0bCAqcGFkY3RsKQ0KPj4gICANCj4+ICAgCW11dGV4X2xvY2soJnBhZGN0bC0+bG9jayk7DQo+
PiAgIA0KPj4gLQlpZiAocHJpdi0+Ymlhc19wYWRfZW5hYmxlKysgPiAwKSB7DQo+PiArCWlmICgh
Yml0bWFwX2VtcHR5KHByaXYtPnV0bWlfcGFkX2VuYWJsZWQsIFRFR1JBX1VUTUlfUEFEX01BWCkp
IHsNCj4+ICAgCQltdXRleF91bmxvY2soJnBhZGN0bC0+bG9jayk7DQo+PiAgIAkJcmV0dXJuOw0K
Pj4gICAJfQ0KPj4gQEAgLTY2OSwxMiArNjcxLDcgQEAgc3RhdGljIHZvaWQgdGVncmExODZfdXRt
aV9iaWFzX3BhZF9wb3dlcl9vZmYoc3RydWN0IHRlZ3JhX3h1c2JfcGFkY3RsICpwYWRjdGwpDQo+
PiAgIA0KPj4gICAJbXV0ZXhfbG9jaygmcGFkY3RsLT5sb2NrKTsNCj4+ICAgDQo+PiAtCWlmIChX
QVJOX09OKHByaXYtPmJpYXNfcGFkX2VuYWJsZSA9PSAwKSkgew0KPj4gLQkJbXV0ZXhfdW5sb2Nr
KCZwYWRjdGwtPmxvY2spOw0KPj4gLQkJcmV0dXJuOw0KPj4gLQl9DQo+PiAtDQo+PiAtCWlmICgt
LXByaXYtPmJpYXNfcGFkX2VuYWJsZSA+IDApIHsNCj4+ICsJaWYgKCFiaXRtYXBfZW1wdHkocHJp
di0+dXRtaV9wYWRfZW5hYmxlZCwgVEVHUkFfVVRNSV9QQURfTUFYKSkgew0KPj4gICAJCW11dGV4
X3VubG9jaygmcGFkY3RsLT5sb2NrKTsNCj4+ICAgCQlyZXR1cm47DQo+PiAgIAl9DQo+PiBAQCAt
Njk3LDYgKzY5NCw3IEBAIHN0YXRpYyB2b2lkIHRlZ3JhMTg2X3V0bWlfcGFkX3Bvd2VyX29uKHN0
cnVjdCBwaHkgKnBoeSkNCj4+ICAgew0KPj4gICAJc3RydWN0IHRlZ3JhX3h1c2JfbGFuZSAqbGFu
ZSA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0KPj4gICAJc3RydWN0IHRlZ3JhX3h1c2JfcGFkY3Rs
ICpwYWRjdGwgPSBsYW5lLT5wYWQtPnBhZGN0bDsNCj4+ICsJc3RydWN0IHRlZ3JhMTg2X3h1c2Jf
cGFkY3RsICpwcml2ID0gdG9fdGVncmExODZfeHVzYl9wYWRjdGwocGFkY3RsKTsNCj4+ICAgCXN0
cnVjdCB0ZWdyYV94dXNiX3VzYjJfcG9ydCAqcG9ydDsNCj4+ICAgCXN0cnVjdCBkZXZpY2UgKmRl
diA9IHBhZGN0bC0+ZGV2Ow0KPj4gICAJdW5zaWduZWQgaW50IGluZGV4ID0gbGFuZS0+aW5kZXg7
DQo+PiBAQCAtNzA1LDYgKzcwMyw5IEBAIHN0YXRpYyB2b2lkIHRlZ3JhMTg2X3V0bWlfcGFkX3Bv
d2VyX29uKHN0cnVjdCBwaHkgKnBoeSkNCj4+ICAgCWlmICghcGh5KQ0KPj4gICAJCXJldHVybjsN
Cj4+ICAgDQo+PiArCWlmICh0ZXN0X2JpdChpbmRleCwgcHJpdi0+dXRtaV9wYWRfZW5hYmxlZCkp
DQo+PiArCQlyZXR1cm47DQo+IERvbid0IHdlIG5lZWQgdG8gdGFrZSB0aGUgcGFkY3RsLT5sb2Nr
IG11dGV4IGJlZm9yZSB0aGlzLi4uDQo+DQo+PiArDQo+PiAgIAlwb3J0ID0gdGVncmFfeHVzYl9m
aW5kX3VzYjJfcG9ydChwYWRjdGwsIGluZGV4KTsNCj4+ICAgCWlmICghcG9ydCkgew0KPj4gICAJ
CWRldl9lcnIoZGV2LCAibm8gcG9ydCBmb3VuZCBmb3IgVVNCMiBsYW5lICV1XG4iLCBpbmRleCk7
DQo+PiBAQCAtNzI0LDE4ICs3MjUsMjQgQEAgc3RhdGljIHZvaWQgdGVncmExODZfdXRtaV9wYWRf
cG93ZXJfb24oc3RydWN0IHBoeSAqcGh5KQ0KPj4gICAJdmFsdWUgPSBwYWRjdGxfcmVhZGwocGFk
Y3RsLCBYVVNCX1BBRENUTF9VU0IyX09UR19QQURYX0NUTDEoaW5kZXgpKTsNCj4+ICAgCXZhbHVl
ICY9IH5VU0IyX09UR19QRF9EUjsNCj4+ICAgCXBhZGN0bF93cml0ZWwocGFkY3RsLCB2YWx1ZSwg
WFVTQl9QQURDVExfVVNCMl9PVEdfUEFEWF9DVEwxKGluZGV4KSk7DQo+PiArDQo+PiArCXNldF9i
aXQoaW5kZXgsIHByaXYtPnV0bWlfcGFkX2VuYWJsZWQpOw0KPiAuLi4gYW5kIHJlbGVhc2UgaXQg
aGVyZT8gT3RoZXJ3aXNlIHdlIG1pZ2h0IGVuZCB1cCB0ZXN0aW5nLCBzZXR0aW5nIGFuZC8NCj4g
b3IgY2xlYXJpbmcgZnJvbSB0d28gcGFkcyBjb25jdXJyZW50bHkgYW5kIGxvb3NlIGNvbnNpc3Rl
bmN5Lg0KPg0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCB0ZWdyYTE4Nl91dG1pX3Bh
ZF9wb3dlcl9kb3duKHN0cnVjdCBwaHkgKnBoeSkNCj4+ICAgew0KPj4gICAJc3RydWN0IHRlZ3Jh
X3h1c2JfbGFuZSAqbGFuZSA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0KPj4gICAJc3RydWN0IHRl
Z3JhX3h1c2JfcGFkY3RsICpwYWRjdGwgPSBsYW5lLT5wYWQtPnBhZGN0bDsNCj4+ICsJc3RydWN0
IHRlZ3JhMTg2X3h1c2JfcGFkY3RsICpwcml2ID0gdG9fdGVncmExODZfeHVzYl9wYWRjdGwocGFk
Y3RsKTsNCj4+ICAgCXVuc2lnbmVkIGludCBpbmRleCA9IGxhbmUtPmluZGV4Ow0KPj4gICAJdTMy
IHZhbHVlOw0KPj4gICANCj4+ICAgCWlmICghcGh5KQ0KPj4gICAJCXJldHVybjsNCj4+ICAgDQo+
PiArCWlmICghdGVzdF9iaXQoaW5kZXgsIHByaXYtPnV0bWlfcGFkX2VuYWJsZWQpKQ0KPj4gKwkJ
cmV0dXJuOw0KPj4gKw0KPiBTYW1lIGhlcmUuLi4NCj4NCj4+ICAgCWRldl9kYmcocGFkY3RsLT5k
ZXYsICJwb3dlciBkb3duIFVUTUkgcGFkICV1XG4iLCBpbmRleCk7DQo+PiAgIA0KPj4gICAJdmFs
dWUgPSBwYWRjdGxfcmVhZGwocGFkY3RsLCBYVVNCX1BBRENUTF9VU0IyX09UR19QQURYX0NUTDAo
aW5kZXgpKTsNCj4+IEBAIC03NDgsNiArNzU1LDggQEAgc3RhdGljIHZvaWQgdGVncmExODZfdXRt
aV9wYWRfcG93ZXJfZG93bihzdHJ1Y3QgcGh5ICpwaHkpDQo+PiAgIA0KPj4gICAJdWRlbGF5KDIp
Ow0KPj4gICANCj4+ICsJY2xlYXJfYml0KGluZGV4LCBwcml2LT51dG1pX3BhZF9lbmFibGVkKTsN
Cj4gYW5kIGhlcmUuDQo+DQo+IFRoaWVycnkNCg0KDQo=

