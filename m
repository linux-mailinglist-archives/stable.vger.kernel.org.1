Return-Path: <stable+bounces-124213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED57A5ED22
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B2C189A3FC
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4A25F995;
	Thu, 13 Mar 2025 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="rk6u8jOt"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9C13BC3F;
	Thu, 13 Mar 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851643; cv=fail; b=ltOfmahlR8xIRRIqFBLWOGIjB36Z9QVMGzHiUbjZ7qe+ZnTw1RmzkUuVO8ofwzgZYnIq6vjDPoGpjCM0P2sJlNhsuEa+8xOYJOFHXX8XZ/HLxrIFXttWf5OFd2MaqdOJbog3tqov38QuJPqUolqb0J4vIFpIFPQyhato+I44tHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851643; c=relaxed/simple;
	bh=g1X5ZLoN6x73bO98Tdmo6oFTesxZ3bBa3UUVJ8IR57o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTc6qrE6yBx1aGNtvbdOPuKtZfkjx4BbIhT0TUfUfk/O/0AwegTTkeqEILvVq4FEiUQmpjPYeyfUl8xSs6bhkMrcjaJ+tb6PxZQBNMSQo0DUol9ZArBqNhUsvGRPcqu1OGiI4XqGgGLICDdGeQXyj2xecREHvRhghYVG7wh89iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=rk6u8jOt; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ay7taXKv/4r2vvcHzRRouKrdabS1Lq8T759HpU7axkxlfi2utjvFH3UmrsInqJiKSYSYA9ZoIQRpFMbdYGn2/rIbgdRYK62oLOIBJr91flBbWAmIbfq8PNLphfndZqAefXTFoX+VEs91HZMCBsYPbmqCqsnP+eiJKK1c9cliyJGYMKhnh8Ru1I2RNk074ax+j81WxbBBiriAO/diyfn3RBDawrx9Dx7j3jTIaCq7QKc3nRcl5Hxw9jsh4G51tYPcriDcwf7g2MIFzBkTNGZnS98iY3kKIBx8DEDZ2fHGnTOnn/6p6wkAsNr+LGbeoz1+TfHf3oaBpyOpcKuC46OTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6Hg9gE+yVG4Foi/jQdZjEsDC3rXQ4+5Y+VQ2vhzNo4=;
 b=mjiM1pthZirl3E78DKUEnoLtRWYODScx1ptQ8lxu+aZl1Tt40sH/lixwNX5qYN8DEto6/nt71CynMUon69drCOg/6gs7iT3lAfQBAQLDxNuQxs+kY1rvDnmeeeJbKQJ123ll6ORVmQt/rRE9AOAC5r9TXTWqTWP3lau+mdEsljbjIi958jbeiR5Gv0ASKuViX2K62RZ8kp7LM3eC09Oa+LUNQWjEJV2aIi9s9EVRUKUJGYR598CC/ciaeT1T491wrNbXZ960vK5Qkqt3D3rh60VmPhfLZucP+cggGCxlwWYKlSkSWBl4w7BYW41Vy9/7tIFS+DaUBeLpaNYlR26p0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=chromium.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Hg9gE+yVG4Foi/jQdZjEsDC3rXQ4+5Y+VQ2vhzNo4=;
 b=rk6u8jOtpl06bOYWLATDkkp+3tlzUUVKUVEEC7pv1XeKz6ayIOWqxGQViEd4WHhN1YJP0s2KavpU74aN6lOh+idJsDJRbrX8UTLfo9bi4MSU+k8ulyBCEX3h4FragTyzb0TgQiHdVcl6wl74q7ufSUzYmLVtxnALIDgVxsWDRCo=
Received: from DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) by GV2PR03MB9401.eurprd03.prod.outlook.com
 (2603:10a6:150:d5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 07:40:35 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::fc) by DUZPR01CA0212.outlook.office365.com
 (2603:10a6:10:4b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 07:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 07:40:34 +0000
Received: from n9w6sw14.localnet (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 08:40:34 +0100
From: Christian Eggers <ceggers@arri.de>
To: Doug Anderson <dianders@chromium.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] regulator: check that dummy regulator has been probed
 before using it
Date: Thu, 13 Mar 2025 08:40:34 +0100
Message-ID: <2729466.lGaqSPkdTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
References: <20250311091803.31026-1-ceggers@arri.de>
 <20250311091803.31026-2-ceggers@arri.de>
 <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|GV2PR03MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: d083df53-1158-4ef3-755f-08dd62025742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzU3RVpXbE1JUWk4WWtsWDlneGZkRGV2VVE2R3pCK0hKS01FQ1J4Y1hiWmMr?=
 =?utf-8?B?dlh2TDVSakhHZUhGMGVYUGQ2Rk80elQ5am12NFJHaG9GS29tbXBtWDR5cWFQ?=
 =?utf-8?B?TTZEVFB6Rzk2cXN2Q1J4dk53NGVjZ3JHVFhUSG9YM1VUTHVXU2wrR0FQQkYz?=
 =?utf-8?B?SWQ2enRmV29ZcU5IbWFlbS95bTJNa2MvSDNTTlNiTTAxOUVka1cyREY1ZUNT?=
 =?utf-8?B?WUgzWHdQa0FsQ25yOERERGFtTE5SaGx4b3AwbVJyVnFUeWdYNFk0M1QyZUVY?=
 =?utf-8?B?WDBHUDJhQkNVMFdHRlVwcjl4YkJJL1dxaXNhRXhxSzNRY0RzZGh0RWh5Sk44?=
 =?utf-8?B?NHloMm1EcVlnQUFmVklYZlI4L1lUak52bDZEcE1vb0w3c28rclJVR0VqbGJU?=
 =?utf-8?B?M3VReXdvMHNucHpTY1V1VDZBWW93T01JL1p6UUhDc2dGdUVHckUzQnJ5REU3?=
 =?utf-8?B?T1dLNmR3bG9zWWptaEp6OW1MU1ZISktDMkpJY2VYQzNINkd5WVBFaFd1OVpS?=
 =?utf-8?B?ekVKdWFXQTNhWGlqQWxNQ0FHRFJneTgzOHhta05NT0pjMEwvUVhyNTc2WE9o?=
 =?utf-8?B?Sy9TZ0R6TDBGWVlaV0Y5bWxzOGgvSUVGcFlGYTdyWmU5dFBZN3FHeGREVVJs?=
 =?utf-8?B?bXhhZlA0b2ZIS0hEQWJBdEJtQU9JL0d1czRQa3IwVmQxL0Q2YjJ1QlpPa2ZO?=
 =?utf-8?B?UmVTbzhDYXNkdEZPL3JLQ2JVVWZrdXJoNGJqaG1LVTI0Rm9EZXcxcUdRR1Zm?=
 =?utf-8?B?ZHNIK1R4S1lGOUR1WXV4SU9XWmd2QVQxbWhCTGpMNGh5THdvMVJtUytWSmh4?=
 =?utf-8?B?c0owS0tpdFRrTVhSamxCcDRIUjMvdVNqSWJzMHVFTnNOSVBxTCtMb1BQNGJx?=
 =?utf-8?B?MjhLN3RBbVl2K3FWVWFibkJpVGswdjJ3WFFUZXhoekRibWlVME5PVDcrNDRT?=
 =?utf-8?B?a01QdzBMQkcwWGR1d0NCK3RYamRlS1RLS1NYTHd2TkpUWDdMS0RwUTljUnVs?=
 =?utf-8?B?Vmx3b1k3K08venZ1R21VSUtlQXN3WjFlbVdnQXJWUTJyRm1xQlBpOWc4bUVX?=
 =?utf-8?B?cm55aDllWjhhMUFTbDZnbzNKSlhwQVRCaCtSTEVvSFZXZUwwSlFmNUdraEdG?=
 =?utf-8?B?YTd5QlNZakRSeDE1RjBZVHN6eWN2NWZPdm42WEpuTmpyZ1RuWGRNa2RzNVlv?=
 =?utf-8?B?aVRCMDdKTjBVRERiWHdmV1ZESE84VFdqZkFraG9LQ3BLYUw5clEycmFhSjg5?=
 =?utf-8?B?eGZydE5yY2R0K1lueE5UVStzSmVpdCs4bjRqRGtPRDBucWZ2RUR1Nzd4NFI5?=
 =?utf-8?B?THV1ZXJPbzFJODRMNVEweGRza2kwRTJJZWtqY2hCcWZicE41c0FOUzBoUkpC?=
 =?utf-8?B?OGtjRmptajR4elY1bEZhY2xMWUFJK1FKenE4RHlFcVhGWERkLzJSbDcyaEls?=
 =?utf-8?B?bm9UYUptcHRCU3E2VUpCd29xeE16QlFvdEoyM3NLb3NCbVRFS0tvZXhWOTRE?=
 =?utf-8?B?SmVLYk0rbzcyWktmOHFMUEdQTjJXeWhMeWJCaXp4MXJ5WloxR0J2elVkcGo3?=
 =?utf-8?B?SjdHOHdJUDdtcjdxeWgxdFNNdVluUys2S051elljZi9XTVp2cm82M2lvRG9k?=
 =?utf-8?B?U0oydXF2UFBQOVhZTlY1UTN2d2FSWGJNM2JvQ1FzS1dPN3Rla29Ub3ZzczZR?=
 =?utf-8?B?bzlORHoyTktLclpydjhUSG5BZjVaQndUUlBsSmlYZWFlWXJkL1JIbXVWanNL?=
 =?utf-8?B?SFhPUUNIUnFvN3prMFRSRUt6cTZrL05VTkVaZFFPZWp0RXl2TXgwbmVWak1T?=
 =?utf-8?B?cldoUGo5RVhZZEloU1VaS3lQMHBncWg5azNqc01MOVFuSEF5STBSSkgzYi9u?=
 =?utf-8?B?amRRcFMxYUhKL3ZESzcxSU8xSHNxbXF3RU1SZWEwQ3lNYnlybi9DRTUzcmgy?=
 =?utf-8?B?aU9tSklCWWlHNXRINnJjM1Fpd21tSFV6QitHcmVTb29Ed2tZMms1NWwxeUkv?=
 =?utf-8?B?UEVaL25CMEdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:40:34.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d083df53-1158-4ef3-755f-08dd62025742
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9401

On Thursday, 13 March 2025, 01:46:43 CET, Doug Anderson wrote:
> Hi,
>=20
> On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > @@ -2213,6 +2221,8 @@ struct regulator *_regulator_get_common(struct re=
gulator_dev *rdev, struct devic
> >                          */
> >                         dev_warn(dev, "supply %s not found, using dummy=
 regulator\n", id);
> >                         rdev =3D dummy_regulator_rdev;
> > +                       if (!rdev)
> > +                               return ERR_PTR(-EPROBE_DEFER);
>=20
> nit: it feels like the dev_warn() above should be below your new
> check. Otherwise you'll get the same message again after the deferral
> processes.
>=20

I actually had a similar feeling during making the change.  Having entropy =
on warning
messages isn't very nice, so I'll send a v3.

regards
Christian




