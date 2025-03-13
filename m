Return-Path: <stable+bounces-124212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AACFA5ED1E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C114F3ACA72
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592725F994;
	Thu, 13 Mar 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="IUK/glcJ"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404F13BC3F;
	Thu, 13 Mar 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851417; cv=fail; b=TnmoRFJZbkeqz09YXJ0OrBVvuYXiT5tKy2upF0gR4ypQel35U++Yoyw+10vytPM3ZUVWbmhY5QRIVGoaGZioYAiLahWKkg/wmq4CicKaZsJypngwRXLJajzlnduQdqnJeXLpV+9Y/Wq31WLM2B5K0stFcHY2w+356nLy6vFSBcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851417; c=relaxed/simple;
	bh=NSFOtVIUC6BTn9ziAAVIEP9CzsMEam+5Q4tPmieDVxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvPmw3iH48CHZhdoXEDHupzSsVwyQ9llY/5vwYRgxgnb3ZrHSAOZ/uT6VhNDm4kGAu2xK8TQwwTU3jFmwIrDwEnTPUJ65Xi2d9daNH07yOEFm0l1F5moKXrBwkldOCDg30mb4nDpcDTN8lGCRn9JmWTLDjBzLOZZ7h4JbOH1zoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=IUK/glcJ; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0spTgP66bHLwK+ylu+3kbYHYc0ENWgOcT76r9ACA73xKas5R6I9Oo28hTYcyt4R1lwVHx/cVWnDaVis3e1bKetwdyt/mRIsPWMWE0s1zLOercQiQ+4M0tAuLprCng1ZCioggUL8YsxMJuK6+cf57xfQhN4ZbZ1uYR/lHHQngyl+Z5LIOaWOFWzZ/3oJc5vyTbvoEYO0qySGmT/zm9YF+uuqEnKzx+vcNaMnBcGGaRj1qQVbQXjsXAJkYBVz/wTeFPoBdAlfGETNW3F40Ty77VKJoxcq2p09rTZbFrNbNELgMS+g0fG7dkj/Zpr3z60AvPqVaWcDKkfdlFXL24/5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wxyyEMOC83t3aXL3UnOiqtjK8mWbCIgQAHULQv9clE=;
 b=OCbUAByAoD8j/lrfYTZylv1+vkJOD1yuimfsAYLcJMJtyvPQIxTvMz7xeEb1JGdrQV49HBQWJcp1jJM1cjcynzZxcUQqHDa1LYDpI8bZzCed7Tx6VOktGgg3avCP/3m31ZuiXYjUNWfHa8Dry/LryUXEsq9+tk4ov7iZhAFm3NYTQO4hXFwNJnA1oxfcioO9HgpGrqANtpuItjRrzz0yhzkAQXkso1/Qx8a7f762IR2Rxa4uixLheZbMdDaUMlBFVZyN2FLeWPQmefokIa/vr5/iJmVp6iFYsqxBI7KOz3ZFwe5u7vm04L2vMAjssrvm4Oq9/H48ugEV44TEsM+8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=chromium.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wxyyEMOC83t3aXL3UnOiqtjK8mWbCIgQAHULQv9clE=;
 b=IUK/glcJfSEUwr/gtkgg6k4CDcl4WLGOPoEI9AKrRkfOy7Nh7grdEYqrQunYPKQzVucxFLDdrrApM5AGYHNY6aS81btHWP58oyMm30P6kVN+NoQVEjormW6CXCr3B8jgc+4gFfWj+8c/zFZ37yF7UY0U1vHiRFLGn+wjtXR1PZc=
Received: from DU7P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::32)
 by DU0PR03MB8669.eurprd03.prod.outlook.com (2603:10a6:10:3e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 07:36:46 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::5f) by DU7P195CA0019.outlook.office365.com
 (2603:10a6:10:54d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 07:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 13 Mar 2025 07:36:46 +0000
Received: from n9w6sw14.localnet (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 08:36:45 +0100
From: Christian Eggers <ceggers@arri.de>
To: Doug Anderson <dianders@chromium.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] regulator: dummy: force synchronous probing
Date: Thu, 13 Mar 2025 08:36:45 +0100
Message-ID: <4942246.OV4Wx5bFTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
References: <20250311091803.31026-1-ceggers@arri.de>
 <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|DU0PR03MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8ada07-4572-4b30-21e1-08dd6201cef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhEVlBSbnBHSDJUeW1EeVQzMyttUnBnRE8xUEpiVk9SZDM1R3Q3WGQvblVY?=
 =?utf-8?B?VlVJYWd3VUhTTEdiOXFxMUs1UXlGTEZDck16UmcrRDFGWVlNVm1iZmgyODM2?=
 =?utf-8?B?dGJQVm9jVTdwd2l1LzFVYWdBNnFzdU5uNlJPNllPMmp4Zk1CQUdTaTNvQThP?=
 =?utf-8?B?UTFVOXFMY1RpblpXZ0RZZ3BQUkJaMU9MMEtMblYxUlQ3VUdSeEs5d3NBMHBC?=
 =?utf-8?B?aFRlR1ZmbWdnOEFqN1VYUVF1aWxscFBrU01LVW5HVUluWDFjQmlUOEoySlUz?=
 =?utf-8?B?UVJnY2hHZkJSVzIxT2VUUi83bUZpSEhEaDNqVm1tclVHUUI2ZzFSZFp1aHJp?=
 =?utf-8?B?M3E5UDBqZFQ5MGVmU2ZCZG5la1NTTERNcjRKY1RGL3o1eXVBWXpFbEZDbzRr?=
 =?utf-8?B?Z3M1TFEvay9vaVZnbXlxYzJnY3lZa091amNWRmtOc3ZUaFFFNW9KQ3RKdWpR?=
 =?utf-8?B?TWxXY2c4R3lPME8xZkQwaDg1NUhzRWRueWJuR2o2Z0lNVDVqMVM3MXptVmRq?=
 =?utf-8?B?bU5aa0NjWDF6eGhVcmlUV2dmUk4zbXNGMjdHOGtmZkZSTEJpVys2cVZwc2JV?=
 =?utf-8?B?a3BsSXNkditDYjRqdDZkQlZGdDhLc3YvbnNINnh4a2REQyttQ25WNVV0TUlj?=
 =?utf-8?B?NjZzSGpjV2dOaksyaWJUbGtaQVVqb01mTytkWGpwalBJV3pLTWVVVTdraVhs?=
 =?utf-8?B?UWlwZ09CVjFqMTVXYklPSE5Ca2lEQlhyODZ4UGcva0hrQ2dGaCtyd3U3NjF1?=
 =?utf-8?B?Y1I1eDBYdmtveFQ3NTUwZFFsaFk3Y0NpWTVydGZZbFE0QkFYb0JGRUhMZGtB?=
 =?utf-8?B?UUdzeGtnQ2ROZW13ZExqUnI2eC83UDU2RXZnVGF3aGN0RURlQ0ZZMlR3WmtW?=
 =?utf-8?B?Z1p6bVhmd3JQcVlVNjV3azE5VEUwWVE5WUp6U1JReVF2Z1RXVkJrL1laOXdJ?=
 =?utf-8?B?cXVFU1JsNk5EcGpGSm5YTTVsOStqdFR2cGRZck53M2I1Vk5kZERNZERkblIy?=
 =?utf-8?B?b0ZFb2lOR0ZQbmtwQkFScm1sbnp3eldLM0d6TXl0anM2TlpXQ0wvS28zNENy?=
 =?utf-8?B?c3ZUYS85OGk3SVpBb0FndTl3enpVWWsrWGYxRFVxUjhpcXBNSXhLWE00WUVu?=
 =?utf-8?B?VS9paDN6ZUJoZWZZRmptem4zK2REdTM3Ykhva2NFZEJnTzdjNkorYmJrRUhD?=
 =?utf-8?B?OWlaRXlGQ2NHQlcvbHc5T3Btb1RPZkR1eVFtMjlpT2VNWVlHZjlIWWtGa3lJ?=
 =?utf-8?B?WW5IOUo5eFp3cWxhYVg4MTd2ejh0djU3Y1pVay9XV0dHbGR5SEJ6N2dLeFpy?=
 =?utf-8?B?NnhnVzNCVS9vREJ1MjJnM3Exc0R5U1BJT0dRUmNiMzViZXhlVmp0NkNXdGhr?=
 =?utf-8?B?d3JmdTFiT1paMFJRblRvYytJM21BYW4vbGNMcThNTjRBOXJvbzRPK0RQMVZG?=
 =?utf-8?B?QTFlbEliRE5aSmc4WkNUQ08xbkVKeENHaTBRV01LTTlhKzcyTlJ0cTY2em1j?=
 =?utf-8?B?WVdpajZRWFNGeVZIa2U1Z1VQMTkrcjBBQVBTKzlpZTN3alJ5VUxPa2JyOEho?=
 =?utf-8?B?czRRUXJTVTFSUEkybXJ3VWU2dGNLR2cvK0d3REl6VmEzOUgyd0ZUcThwc0tz?=
 =?utf-8?B?eEpJcWpsNGwzd2MxN0Y4d01BbTdkQmsyNUhzdGdtY0tSU1ZmUWRVNkFyTkhP?=
 =?utf-8?B?WXRZSzFVcTlvNjlFYVo5MzgyQ0orMXZGeTJ1dnlKYmlQL3FxandBVWROVzND?=
 =?utf-8?B?UEpZdFF1ZVZpbURxdWoxdDZlOHdxYllWMzR1a1R4WmJpcDJldE1xbUNmcFJH?=
 =?utf-8?B?YXRzRmUwWjdaeUZncHBrcStMc3VBUDBDazZIODBKUExIbVRBODBYV3NqZXFK?=
 =?utf-8?B?QUd2SWdMNFpNNWI2VEZFMGJlWEdwa1duZ21qNXk4ZHRuMFlZL3NoYzVXOWtZ?=
 =?utf-8?B?alorMUVUNWIyTmpsUzZQYzkycXV5UXJPTHhmQXgraGs4VnVRbUtXUmlnUkgz?=
 =?utf-8?B?aTM3TC9TdDV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:36:46.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8ada07-4572-4b30-21e1-08dd6201cef3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8669

Hi Doug,

On Thursday, 13 March 2025, 01:42:14 CET, Doug Anderson wrote:
> Hi,
>=20
> On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > Sometimes I get a NULL pointer dereference at boot time in kobject_get()
> > with the following call stack:
> >
> > anatop_regulator_probe()
> >  devm_regulator_register()
> >   regulator_register()
> >    regulator_resolve_supply()
> >     kobject_get()
> >
> > By placing some extra BUG_ON() statements I could verify that this is
> > raised because probing of the 'dummy' regulator driver is not completed
> > ('dummy_regulator_rdev' is still NULL).
> >
> > In the JTAG debugger I can see that dummy_regulator_probe() and
> > anatop_regulator_probe() can be run by different kernel threads
> > (kworker/u4:*).  I haven't further investigated whether this can be
> > changed or if there are other possibilities to force synchronization
> > between these two probe routines.  On the other hand I don't expect much
> > boot time penalty by probing the 'dummy' regulator synchronously.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for driv=
ers that existed in 4.14")
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > ---
> > v2:
> > - no changes
> >
> >  drivers/regulator/dummy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Not that it should really hurt, but do we need both commit
> cfaf53cb472e ("regulator: check that dummy regulator has been probed
> before using it") and this one? It seems like commit cfaf53cb472e
> ("regulator: check that dummy regulator has been probed before using
> it") would be sufficient and we don't really need to force the
> regulator to synchronous probing.

actually I also tested successfully without synchronous probing (only with =
checking
that the dummy regulator has been probed) and this also worked fine (just to
be sure, I also added a temporary delay in the dummy's probe routine).  But=
 as
the dummy regulator doesn't rely on slow I/O, I felt that synchronous probi=
ng
makes more sense than "busy-waiting" for it.

>=20
> ...not that I expect the dummy probing synchronously to be a big deal,
> I just want to make sure I understand.
>=20
> -Doug
>=20

regards,
Christian




