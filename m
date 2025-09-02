Return-Path: <stable+bounces-177542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6390B40D5F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 20:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148043A98F6
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C1340D97;
	Tue,  2 Sep 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T9teZ8VT"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B89285C82
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839175; cv=fail; b=CE1zv6C+KxMpBHyzAGl4Ec6qBq10RCwQkMyAEqnVN/RpbLvjJg1BBAcB+dA+A7M+8oPukZUDO3uC4n6UcNIiWZxEdlzykZePcEImMoggsYdIIr94wMp0t6h+JJqq4h35PrtqtxcXovn7zlyir2g/SeyLKh3q5jP0YwfU2NCwR3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839175; c=relaxed/simple;
	bh=ti4x3YKdSwXlJ4ly0VALdqhUcpYdbf8wV+6c/1Kzh2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXxRHxTRML3k0hdDx720XaKgJM9tl+8rhPCYvoxnGXvkaeqAhRntE5J6LeVl4HWVjv+5TmgGWRvMuZbbpw72AhW8gEe7i0QjhziM2yqCebnAm8bcMC9EAdv3cxuHH2GNZaaEkY/m5c/BTNgyXjaMcZrm9yZdHgARTRBO2MrGSyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T9teZ8VT; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouC13sxLSOSzzvXTf3yylxjEQcWGNOJTvSSHagqewMiGx1Z6OqOVD4SpzZKQyGRTULxbyXPx+zmY58CwM5HRDPEdAKZ3IWHrdv6M68enq8SNJlk42sab/hB6JIVJVjPZq8pUirhKJwOVTQPdxD798C0bDWQ/UMQbOuTdtmfoG/738Fa5CzQRsiZDnfxi/sU3pOJwlY3ivG4+94Ak/7mSAJ2Mv7fffaFM1d/+zU+dJPVkMUooD//wD05FF/0Tp8eRycZ5dgWWxwb0oymT72fIO5wLda4E/czmHxz0MHPd6PDQKBbY4AIenTmx6YkrMKyRepqVes5ELFg3+x2xEEvGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyp7VO4oIy0GDKiWidamq8PCsOVFLheO8kmenUfosgQ=;
 b=ITL317PCTgQWCO4dKVouckISY72y6R0TeXM64vq7SrtjH30FqS7bUUcntpUUZaWo9gPd8UXq+i0YRSKNPOHTfJucATMxcNIhL8Ug4QY2eAuO6V5lV1CmAuA/jyhgTmq9PrXyrN+CB5rYfxLfc5DIjHjn5KMqYH4VMvOmJdaV6brE6cz0gNYsLyUOdpUmAW3vErqORxY9n3Xifmshmuc7qUdS5EjfVWbSIMWRwQbYZPky5EVlxwxa3Hli8ijObXcmu5sXFmwOy+RNn6NWmAKWuD3gzFCh/yKBKzgdBXrX+P66G2C07rDX3e8BzAF3AKaVZgMCjlIZMvBuiIiyz+VdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyp7VO4oIy0GDKiWidamq8PCsOVFLheO8kmenUfosgQ=;
 b=T9teZ8VToOoQrI61DYkMhM/q5L7MyHfeRzIlemOS2nTLQKixYrXIMbeSandM3N57CakwIvqW/nLZtN0wq3G7pY2+AN5cfsdN+D39CF51pRMfhNUi8b1ZiDWy5XZ/DGVY/+Eq+ZfLAEOdp5xrZrhUM7dsAOrrPBqOAnl3xuH0MMs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 18:52:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 18:52:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: Avoid extra evict-restore process."
Thread-Topic: [PATCH] Revert "drm/amdgpu: Avoid extra evict-restore process."
Thread-Index: AQHcGRxRPo/hAeoIR0ulwLB79mafG7R6ub4AgAWJFrA=
Date: Tue, 2 Sep 2025 18:52:49 +0000
Message-ID:
 <BL1PR12MB5144E5ED76DBCF76F6492F8DF706A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250829193652.1925084-1-alexander.deucher@amd.com>
 <2025083040-startle-shortlist-3f48@gregkh>
In-Reply-To: <2025083040-startle-shortlist-3f48@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-02T18:51:00.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ1PR12MB6243:EE_
x-ms-office365-filtering-correlation-id: b3b80a5a-6fab-47e5-5459-08ddea51e9fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oWnvFuxMMwAiIqK4tG30pzaFrSZhvqKJu2i+6QVDgZImEVjAaPvDyCJG2vM7?=
 =?us-ascii?Q?Y/9s4ySdwAbqrIz0RSF9girerV+PWpIfijxuCnDfeFvg9cLj8GVDd9gMOrHp?=
 =?us-ascii?Q?ZBlduMOwVsCprQUWQ1+xfieOtlYJcosFdZigKHszI1wKowPA0IJAZfIVpyen?=
 =?us-ascii?Q?4WAzyjuUTm8+etVzReqpHF3B4ZflOY9mzPmbquoUDE8x5Vp7Vj2Ny9k9vREU?=
 =?us-ascii?Q?nAI6DfA2+Cew7VIcEBqYQOEm04FauF/IVBLqXJi1SHwqfhDljALYTl5Fl5ZG?=
 =?us-ascii?Q?oCXv4/p6b04nNOWiwzjWkSuR3CTSZdF2AFWBLG/HpWSJ2i/4iePsWk9WUlHx?=
 =?us-ascii?Q?K/a0fLjaJ7Tatm7xzjYB1gJqVgGwdteY5/vOvmH4ECQGGO3fMI3FGgmovlLv?=
 =?us-ascii?Q?oakTfPa3fvRU5by94g6mLpqvIaejESChGs4cLL9KtVeSUG6PGSu29370ONHD?=
 =?us-ascii?Q?75QQmcmJ8V/cTzV4Cn9IzGnfKWJCHmTrvrsBrQVREkMg7xWPNWi7h8lVbpWD?=
 =?us-ascii?Q?5CtndOzg7DieS7FUAXxdCgd1lc3/80tgV0rgNv5CUnRrFyMqWsTDpL1cy8Sz?=
 =?us-ascii?Q?BYTXax9UU1gtnT28SP7d6Z6aRmS2ROh4y9JX3J50BaU2/1IMj3a+C78IgcBS?=
 =?us-ascii?Q?n5RgNs+WWfNHLZVBdsQmLMT9k+zL3L7TUgGc9RxjWzzLkOxo6JQCnuaoqRUG?=
 =?us-ascii?Q?khauv8LC8AC21y/i4isrEwgoUeOwF879BZuFIqU3IJHllDWCS5Ybov0TseAW?=
 =?us-ascii?Q?L5REpTxkYhIY/s9+ASRRXc+z1cK4sQZh85IXfSVHEAS/FcOZ3fsgi+PADS3y?=
 =?us-ascii?Q?+11lLu9buk9NdqAw9tKgdAmAr6qEwq14Yir4iRi34dd3a9zcZiNXeIGRaG2f?=
 =?us-ascii?Q?C+rtsOCXAp3GBhlIYJY9VHnEs0lXXrUeEbfK4IGXRGYz+jGlN6vRBZjAnKRC?=
 =?us-ascii?Q?lz57CRVHphyFFr9OddcaCfMeaFQ4Ypx/PDZ3HHysCBwOjX674Ocih87Kjj7J?=
 =?us-ascii?Q?TZ8zqsIayZ5ghdSb+ydS7U6GYOZwmMvb3LI2f/ghoe8Acb0Ygy1Olg3oB0Ak?=
 =?us-ascii?Q?+70Wy2FqPcq+y/KWO/VNNrSKqGS3XBDg0KTpO0bIAv1FHDCwQAyEklvtZcu3?=
 =?us-ascii?Q?keTOJBGJ6hpYSeHaYM71G6XtYXg48Ow5Feri8RIe6F3mcOF9hXNeA87R6Lj/?=
 =?us-ascii?Q?nDx+yB4GmMUBmTSJ4Flg68VsV7Wxt9CTEZJmubwaK598ciaVYbTGew02juw2?=
 =?us-ascii?Q?veGi270UzJFWEDsdZSa8IKznj1brJeJzXf8bxjgT6BlTsPdjjve6jdtbSYNy?=
 =?us-ascii?Q?de7pLdlaDPNTS2jy0fDROeMZ84URm7f6v8ndxbVtwtFrUhiWcassLdZrssMx?=
 =?us-ascii?Q?KNHXHbp4DvQ2xnfxNwtbRzcONxUdCo9CGUThXYIZAww//t9Kc+EPeP3aqzoA?=
 =?us-ascii?Q?pnStCT0S+6qH0Jbx1BPiVESdHv0iG6rQrxVUcKg1fvBze9q+lHvn4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7jqxPpTTR04YzMThA80TreVmUv8ohTz4AHVl/en1bTzaU1Rtdc0XcYwbLbYR?=
 =?us-ascii?Q?5hJFXJjjYoJ/YLoA9y1AUDBpRkXEKrQkw+tMgfhzr24Qlotx5qIxdrw/mVX9?=
 =?us-ascii?Q?uEN7TZOwq3LyeaN2j62wAnv+zhz2xWBv4Ynyk68p1LPUrDYWKILxkZAhyFD2?=
 =?us-ascii?Q?gJbtqOhY4UzsRe6XkNtZfh6qmVGU5ow/EU/RlyB4jfkH4yibX2qQRGWZiVn9?=
 =?us-ascii?Q?BNRck/9Doi10HN8ZBkfuV5qSyN/AbQfs/3Hv4QmsZd6GMq+cyCmatMJxM1wX?=
 =?us-ascii?Q?/XdloRdwL3MwumddRMtehLh2Y9H+tQFp/Fdf86P/ujjVT11q7BJuHhI6d6mm?=
 =?us-ascii?Q?f58b/EGdOgIrC0Lj02vCaE7v8Cc7QxytUwQbACY0ejZ7ZX/NxroQjpFDpzVy?=
 =?us-ascii?Q?bDZTmo5OQeLJkmhQwab6tv81uRBotD+xpanyS4tuNExHy8b7C8ehEzXySoJf?=
 =?us-ascii?Q?7RMs0DhyhSyBv+ddtV7Oh9EKQsns/jnqbh05daS/AC11fru3Wj1v3gKJx4Dy?=
 =?us-ascii?Q?ZnHJI6kdbY1xkk4kwHnq/qZ0jd3jKJTQrWpXMr4JfHjXjgAHhNY628wJ+ZK2?=
 =?us-ascii?Q?ILV9XBep/HTzyN5xIJ6WZUJLuNkte58aZTDRLuyVoGHzR3dZe0N6lvT78U3q?=
 =?us-ascii?Q?Vvbjr9XzEGp2FpQqoDEWkpJP84a5qxnXL4QbEuT/k4HgGZB9UDoqknatLox7?=
 =?us-ascii?Q?89vUPvDnfolANHqbAjkJQcPJQU/Vfoz7rH4AFHWhx9wnhhn67WPPzR8EoZYI?=
 =?us-ascii?Q?rxHsXLQZiO2e7HuxcMLKD6R9NxJcMs0CmUyIvrdF1PZ2MIbr8NLRTbMUPSxr?=
 =?us-ascii?Q?fivEiZtA8Ao5Y3d2+Ogz5h5c+aaSonSKwNRmwa9xDmNaaCwtNsVY90MyPkFS?=
 =?us-ascii?Q?JpH7UN04ECnhgZvhVD3HID+V2POhEXyIQrw1Jtx8XpkyqVxsxL0wVig9ChxZ?=
 =?us-ascii?Q?EsXq5gy9obsGrXeZdgpWhaD4//OwfnhIK77rQtCUefdQzsHAd7AfVL0jXkq0?=
 =?us-ascii?Q?nVeaN3nTv0jJ1hOv28cz8gPCvvzRr4wr8tzvSI7hRG4K6vyIlVBinxefZKEI?=
 =?us-ascii?Q?lELzHk8Po0kHAi+YuReKKXHMjt20nBK0Iooczhblf4y0z5Z+mMIKl86BqgCj?=
 =?us-ascii?Q?/NObhkTy9MongprkCnkgNryDktn97j5luTd2sBzIlBQfySYO0Ado60vn5P5m?=
 =?us-ascii?Q?mR7L5DS12Wm5FRZq8BNsrTco/Bj7Ho+Nb/dFngepb5ahOGkzGyk1TF97aEPu?=
 =?us-ascii?Q?NSvcaU/HTSqwxp1JG5SsjH4yloQnqWPL2Oet3hwsQdVGOdBElAVlLM2K9UdD?=
 =?us-ascii?Q?p5XVacp7hzXDO1Ez8ArnNO1f0h5svHt/xW/xLP36RjOb5hY3/qh67+EPFU+m?=
 =?us-ascii?Q?BeaEq7j21QXofmW5M4EuzcxYcYHJf+hViJx75Rxwq+ErFUNm9+GdrQaPgu8T?=
 =?us-ascii?Q?Cc3D00X9PHVn+1TZy/VXNK7ckyR69Fechkfofsf38jq6fxWdnNBCzOTG2hkr?=
 =?us-ascii?Q?ybyxyjdT2WATaYdcFMnrudrhlgruAyPndLU7NCUqTwT+HjaxkJhw4tH0PleJ?=
 =?us-ascii?Q?X7OlQiELJFVHH8dO8bg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b80a5a-6fab-47e5-5459-08ddea51e9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 18:52:49.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eb+7O346OBRDVyE98JagDFhVLhD2caGZW14QwsU1n3hv/aTcydzVE6xdtnsUwIe1GFbCbBIddpMBg5zEOFIn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, August 30, 2025 2:19 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org
> Subject: Re: [PATCH] Revert "drm/amdgpu: Avoid extra evict-restore proces=
s."
>
> On Fri, Aug 29, 2025 at 03:36:52PM -0400, Alex Deucher wrote:
> > This reverts commit 71598a5a7797f0052aaa7bcff0b8d4b8f20f1441.
> >
> > This commit introduced a regression, however the fix for the
> > regression:
> > aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission
> > during process kill") depends on things not yet present in 6.12.y and
> > older kernels.  Since this commit is more of an optimization, just
> > revert it for 6.12.y and older stable kernels.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 6.1.x - 6.12.x
> > ---
> >
> > Please apply this revert to 6.1.x to 6.12.x stable trees.  The newer
> > stable trees and Linus' tree already have the regression fix.
>
> What is the commit id in Linus's tree for this fix?  Why can't we just ta=
ke that one
> instead?

The fix from Linus' tree is:
aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission during =
process kill")
However, as I said above, this fix depends on changes that are not yet in 6=
.12.x and older.  So for 6.12.x and older trees we should just revert the o=
riginal patch.

Alex


