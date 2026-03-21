Return-Path: <stable+bounces-227749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N93IHdyvmmGPwMAu9opvQ
	(envelope-from <stable+bounces-227749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:27:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D72E4BC6
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747D5303FF0D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BA2FC037;
	Sat, 21 Mar 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YFYSfhWS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937830DD2F;
	Sat, 21 Mar 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088731; cv=fail; b=kjy5Ea6o6rMLpLcHartFQg/e3blf2FR1cym4ertswIasqZnAgcFsWnMmCvYiuBc1JN52lnYCIY0zpcofjEV0O9GM3rdWcpVzB9oZj6UOkv5kEa7AFGiWjEk7yFKKjBr0erAKH5r5893YCh9Hrw88oFeuxURrPYwhaoeMtY61Z1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088731; c=relaxed/simple;
	bh=gH2xmjE33j7zCMksmhjTH4wMHZbZhvsaPl6/gthGu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RgSE3oD/wsUS5UasF53E1mMyODRN+sjDvHTes7x7MudvARDOQhFbUtVwij3o3RF6vtQVvT9CSX47ACo6gUb/4J0BrpI3kUHBURSj3qMgJ80PgnQerrjLkC+PX1QTDvk5f0RsRVwRctgQ27PkC3e8Vlg4Q95fNnXQTNP73pl0lX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=YFYSfhWS; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uEuD3525421;
	Sat, 21 Mar 2026 03:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9c72HpFyQE+mzeqBeh+6ec/nH+59n+IAstuOQQ1XDLw=; b=
	YFYSfhWSATfs7xtJ6OFCRghRxJiK4Tz+5G/1MxeH+O6HG/5tUadj+oWQAOaPJEVu
	TF3D03/FaGOjxXzorxEkRYbfbUEjdiiqeUayfS8KWGNgHvi4ndYVuBUYd1jeFBLO
	hiaMoKP7mXchyoMOovsAt8Ryfhs4SCj9VMZ9ucH2kbS015zYoYNmP6hpii+U4uUE
	iEOP+wdzr+D6ZLEjdx9RiiAb/1yQU8elHKja5m9gZOK+MMhlY5UbFO3FZZagGfOM
	bC+KyJY4Xqhl9eDlM9WpsjDW66mUc/eG2SeO9w5KzYfTyouo+uS4IUBBquGCzPqr
	2N9rcEY3mOm7SkfrMj7qbA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky834w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khunUzK8T5gWZo2UdtsCazv6SS7Fv8fjjKS3qVvVsXbiHGVhYExO6HTKoDSv1G3Pe0IDMVIX4qqtB07G1oCrePYc5vlRFhCLehF6aiIpaDW3Dh3Fea+amSNpgllrtTIZJ7lYTtWkTynBjTeNLhjzSgqh2ZFWZiawyOr0uMOix8FqyQjU9HeP0vPvIlm6Kr6XZaGCD/Awgj+sHltG4e7bpTLM2p9TKf9YbLg4u9FLPPsryIO7PvISP1wZl5gaCBbwFw1BrpF9v60C/bqZqkQe7EIi5lgRn/koU2Kaev9O8LZdBbKK3Odedl2JFLG75U9n6fS6Ek6FlkPybrF4BOs1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c72HpFyQE+mzeqBeh+6ec/nH+59n+IAstuOQQ1XDLw=;
 b=E2rub1G1d1omxWOYWs8RK3wUMZ5S395SVG3Ip3iHneB3ZlQJtc7qmEvizwQQDbNQNN2b5z1R32WrtrjaJx4O7hggIjycpXNX67zYqJaOF1cVT1INEGRf4zqVaZWsxvXzLbqBMHpTwG8FSaSMslT66p08f9lc+St7r8SoHIj+Fz/BPSoBxccy4hQRGJRzb7e0qVGeBHfiCFPM+EkrOws/+X4lFdg3+WT8qusDnwZ1kvY5KTHcQY4/3V8W54OennS5egorbkaURCExa4yUsLQmtxepYUXy03IElWG8Qfs8XIgU4J0Q/PY5WW0Jq6jYLP4KEGdsHcLsf7QtNDd82sgBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:12 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 5/7] timers/migration: Convert "while" loops to use "for"
Date: Sat, 21 Mar 2026 12:24:38 +0200
Message-ID: <20260321102440.27782-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: ea388394-c864-4e73-3eba-08de8734228a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7DFvlQFe9z1V/763VOXzj9cPz4v53nyy9K1imDVPQLFJhESdJzvNkqoER4XMOLhq6slZhwFDacX//XRy1EI/8zXyUev1O13NCC+tn+L9Cwk7uE1K/e92RpmtJdvkf86jbtEpk4J2uw/X2LXahVmt+VIRRQd456hkYM90H0eTf13q3ngUp5NEOWkw4tLYzSJ+a7iLf7764ZQW1deDuYYZ8NRMgxsh3FudInYsxrZ5Bvu+RvJK9zYXnPfaRIjASZ42h85h8IXq4XJCWY3G6KJ0szROm5dycV2rEKgE+3LdqZa25vUQY8A2dcyNZ+1MLyzuQchHqNf5mZO67CUdvA9NMekPM/G35afNttDrE0x8RxJqcNopOiKVm9vNbXnJkUJkIuhadQ1cCk74sFB8/MeMex0QD5bLrmsZnuJz2MFpvpP6GFgmFVoMcO7FO+TUxWM1OdZKclfltNtVF/n7Sdmmer3Yr9d90GOVhzcuNNpeOTA1A7VqX/U0+dz2SzVI6Dhp2/OxMork1WfxL2lg7X5qOxm4UhHW48puFxGdl5DffZwbtGBe7bBSFOmY2y3HnwBtYafPy63tg2j6XhdZi5qh6n3K1uUncR+FI1z4HKjzZ1zAZnO+RLVzS9cF8x8qzVlqeRgKnsIbtKcwCAK5Zf/HVS7nrLPsT6fewtTb9GpyPpXhoz3+55BrJ7X06xcR/ZVCHrzPiijlADOHE5g5DYEB0mGJdj0HwAiQnPybZ9mPDRYmfcCQ45MCJLzqhWy7cyzB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QtQS4ZdLz0+jqXcjgcBnhBoRenOwtY8fZ6BfZCQId1M+d3cZdUhlQrK/DNk?=
 =?us-ascii?Q?KoT+r2pIpWMF9uZIKCzNBJIQwgN1AkFWoFlO7WGUmjDIPQuZOiyjHCBOcbol?=
 =?us-ascii?Q?/3iTulKnFX+K1AOhCHTfKeW239G9Jt19fVKh5z07wvqqHP3xy4/NoPM8Gkq6?=
 =?us-ascii?Q?Oq9I1VmFtfIONcEzQqqv+AMkrzE9myLLkqrYUcFhS6xcOYeD1p9i4KhZykv4?=
 =?us-ascii?Q?PBRv8CwihjtIrpHX4qFMJqZteJ/KvLBivYIIm6eOJWeTvhP2rGJluJ/F/dON?=
 =?us-ascii?Q?ygkOGrburjk8uwfx+eEf59Hx4//UAHxInwtzteM6SZz9qQeXLI1JXiUMmRxR?=
 =?us-ascii?Q?1Bri7QcmIHimWCICAqfFjmJJ9wK0kBGTNaPGwD3LKCs6nLxrXjjZJNgFPQqt?=
 =?us-ascii?Q?L0wQASD2AlHegvGWgQqf1K/OFZ6YheW6rJWZOG8w5KBhDw54gUEDaIz74yIa?=
 =?us-ascii?Q?ofWoVkV8yg+K2jvraolwt7FXZobjTYThWFHyHaVIKootv6TOTZk0GFRdK8Kd?=
 =?us-ascii?Q?CrC67d6bfF3qg+FuMlsuer/wm49oqMiDDxbPslCUcVIVExiGYhgrkNs4bGn6?=
 =?us-ascii?Q?I7blTo7UkeYjmGMdFTWBZUo7JdZ69jZVY/PMpldX+EWuU6UHEGY/m56qHGyq?=
 =?us-ascii?Q?b1xkzKApBN1ALs/mCMUDAN1i8Zi4hTU9vFHmCCKS+Op4ACJgxQSWBYZSOS/E?=
 =?us-ascii?Q?As/ApEaYG/KKnEpHSShIKFQlvzJEJyrkSB7lgmc7ikRUII5/QQCUWGbwiK3W?=
 =?us-ascii?Q?uk6YU5qly+lsEgfMzGurtbeGiJ4AVcHCpLkGE2bmt3TbctcmoVNTOulwtT+y?=
 =?us-ascii?Q?YhHzSrj+3G/TgWJs+xVXFJTb0w8YZtw7fk2/2r334z7wL59qWqaAYjK+NWvj?=
 =?us-ascii?Q?wl1PBtLR9coMxA1NG7kGTb21XRlRgVtAm62BLU1rZaToI6qExtJx5PnfTk4y?=
 =?us-ascii?Q?zVhECgPfQQodPUw3VH47fBHy91FSUzXe0HXq9kRQZtJuCk+LEgxwttTL3G8S?=
 =?us-ascii?Q?27yUU/vtREjlL1XsodUPDQjVVDJuQY5s6npaLeZpKx3icd5v+9ta+AJMHuOA?=
 =?us-ascii?Q?Mnyppb9e1SJo3vw/DZsaTQO5Q1Ix/rH8JxltvB0vgamNfnvrDkQxT2QKudqm?=
 =?us-ascii?Q?IjOU+p5DV/7e7AHz0unLq28EmKmOgE5yu1NgnngjgzSIGgyatXgJnInCb160?=
 =?us-ascii?Q?4nPYGpMWdx7/w6ebBnvubQqv9bfr+caJ3Y1kxN9ef2TA3EUoiA8QYDCYxHb2?=
 =?us-ascii?Q?ODZkFFZ+afmKPjQ3PveLxa9bc47wgi1NwbtQ5t4mjvO4T4h63plfqAUTVC6O?=
 =?us-ascii?Q?Jz1VRGgEpyUJn1cxDJMVKL4VvFZNNNP0BRT/XBYMT32vucu1FYJVbwUhCHVr?=
 =?us-ascii?Q?SRUKFOgakNRNHfebqRUKUjVLbFIJXm/c0lKvesvdmBrdvmcyP0Iq80gEhzTN?=
 =?us-ascii?Q?IoU1bg9YvfGWWs7KqiJAxWZjL7MGAVzk8ruDRvKUJ9SnXW9spYzSTr1deRVt?=
 =?us-ascii?Q?7RnuXm9mBR6K8PdC8Q97g7hHb105N6FhSZOTGdZzAjA5lRG66c5QzfUaH9cR?=
 =?us-ascii?Q?tQ4FxJ3r5brFtMX1/OWGpRZZNhId1IpHoMxvyU398sNfXUc8pLqPZZxQcl/T?=
 =?us-ascii?Q?MtvA/OfI72681138LGVBTefyYMZDs0PPHFlfn0ZMth9G7KPVccmVzZoz4s0m?=
 =?us-ascii?Q?IsW91p9qQjq9rdN74ETqfCR7VicGLHoB02peY3cgX67UaqV848zrX1TCGgNU?=
 =?us-ascii?Q?OJ8i/eYjlsV0qYl6HGWlAwRClWGfv4E=3D?=
X-Exchange-RoutingPolicyChecked:
	H6nY+5mOkPAO/4BXC5aRaB8ra2Ri4NXqtKl8XnHPWAopkP/tBndpvh4oYw0HE8Sw5fP4WOCSYVWwWeVph9nAqwTB1laFvrm13qm6j6L/rWQIAHN2TH7EIIQvoJ8nDjcAaTFjJRzrh6aQ3z0xQedd09mko2eeCGnxppN7gwREDfcgjC6Xg4ZCObrwNYJVx/TOSjrRtUWOMY/v299gw76BUppsX248apc62j4gbNold8O67sdryASGJXq6JKeQvgVyRUGInC0aJoZaJgilRDvycxuAzaPP2t6rOcuE6JSSmak72jMuai1MkgsXUA/IkXCZOWUUpLAjoIVjqJFMFCn0UQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea388394-c864-4e73-3eba-08de8734228a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:12.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45G79bN5pVBnPXf5E5zX+IXJaNlNzNU/x4kTWREkyfGywa2NKMXTlEFO1wMjtwysXwr0Nq2nWFDzfgBguUouPf7VjnXzhjX2AI1nsdW0ixk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX/9zluGIdLNze
 qeeFJ6CUXsgUQckBIyDsuSLsC/eRduPBdoW14cYxE8X8JHWFuyJs8AyyI+MJbFIK29ISXscS3sZ
 9aOhQfdKWmuhLWLrOh1CoIN2DUIAfblfvKG6KOJ6jVSTGph08pVTjXjuhvY1F4jEVJO+ENmMYFE
 1yz7+FKm9uhvF/OZMZRZe8R40pLmkjGgh72woJ4Aw3OzzJOXVW2hX4axeTpj7RpEqgVn+B/iGhC
 PSLZ+JM2XCzqFPS4tCeyGEODSIxgTsy01h5LumCCubMVqecxrSJj1wfQXCErtpqDw958tcoCfBe
 cJt+rZ/OdzTGGFGgWHj3EVN3Jr3VEp0I2hNurhsnQL9fgffSdNCov1IFxA9gXuHcaLhBxJwtWXV
 ngnbIvCC70KfRseNBDOTS60zwV8YmNV8P62ZLzlVHxpUX5W/quVltWd7Jwc3S3jrRbtGRd+Z2Qj
 8nLCQDLXmi7tpKySjzw==
X-Proofpoint-ORIG-GUID: 3ZKtue35myQa6xqHHB0vy8RfJUReyK_L
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be720a cx=c_pps
 a=dImUGf+04sfXZTE2vAy0Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=uKeqS0WbUAxLMEKsOFcA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3ZKtue35myQa6xqHHB0vy8RfJUReyK_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227749-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 287D72E4BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Frederic Weisbecker <frederic@kernel.org>

commit 6c181b5667eea3e6564d334443536a5974190e15 upstream.

Both the "do while" and "while" loops in tmigr_setup_groups() eventually
mimic the behaviour of "for" loops.

Simplify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-2-frederic@kernel.org
---
 kernel/time/timer_migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c3..1e371f1fdc86c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1642,22 +1642,23 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 {
 	struct tmigr_group *group, *child, **stack;
-	int top = 0, err = 0, i = 0;
+	int i, top = 0, err = 0;
 	struct list_head *lvllist;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	do {
+	for (i = 0; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
+			i--;
 			break;
 		}
 
 		top = i;
-		stack[i++] = group;
+		stack[i] = group;
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
@@ -1667,16 +1668,18 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
+		if (group->parent || list_is_singular(&tmigr_level_list[i]))
 			break;
+	}
 
-	} while (i < tmigr_hierarchy_levels);
-
-	/* Assert single root */
-	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
+	/* Assert single root without parent */
+	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
+		return -EINVAL;
 
-	while (i > 0) {
-		group = stack[--i];
+	for (; i >= 0; i--) {
+		group = stack[i];
 
 		if (err < 0) {
 			list_del(&group->list);
-- 
2.53.0


