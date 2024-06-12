Return-Path: <stable+bounces-50205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D26904CE4
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075951F24FD9
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDCB7F7E3;
	Wed, 12 Jun 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HrDrf3RW"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA256F513;
	Wed, 12 Jun 2024 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177702; cv=fail; b=mxTH+x0sV1BDEd04jNe4kC7ZS4m5apjLKSwyg34A3eBEyn1WYjWikWZazu5ONylBDS5nD/KHAOuKBtSgnJyqx6DQFMREaoK6lo1w5rAssoG4egVopSLvWasgmp5x9upT4EgejBb88/iN1F5Dy3AZ+R9gfsH4gJmJLiCeKGt6XEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177702; c=relaxed/simple;
	bh=ZutDprkBgfg+SRwDUi9Uscv3mfVPUOPAPLWDZ0nYhLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMIhkdLzPEiIByba9qZ+7iWGPooEFCu81e9Wjnz9yzY/nyRYIaSkcgFfRJU/bOReYqJrKQB3jGMCgdPog5jxJDlkNPgeJTKAUwQAJj5NpTdvks7zO77yN+1IgM7OvDGdN4i1sixqxcsn4EOdrMDKH1aB0PDFYrQUvkKmhQzpgD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HrDrf3RW; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBuwcOv0mxB1AmoZGzEDh9Lp1QRoTcSzlwNEeBdJES4uFb0e6p7ABIqHjVqzLw1VpkC/b77SQGGOe4ob+EghtgcYqr8DXnIFanZVZcBdUJapWsEfDhqs2PPkFvpD7m1k29Snls4CjZkbA6koIuC8d67Ow62hTw5tLJVEGNHkUb0bUWR3qvXsfo/wP5WGsV5oYHAePAAQD6lisd7Mpms96CFets5lsG8UUT004aquJbfV0GeP/BjFJQDulx7H8E8qSlgEjvd+ohc1TuHqcAso22vDCbpA64mMPHh1Ewpistm88fqkziDsPqCVKiakai7qmf1DuX8YmFBtCEpAqjX1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGyB9zHjCEgw7c/5sfEwjOfPNxaUVBuno1+chfO87Sk=;
 b=h+rTl9H2XlqVU0mitVQs36gfJIkaUepGRPTvf4MHI04kth/fmpIy/d1WvDwcKLL3X4MNCeFqVwl9M8a21uOpkdLzgh7T9PEAu8iALzd4rdQD+7YxJaETtIV6SiQNmzQeFnlfSn2Ri9TKmozUfAJo7+Ti6IYMBJbznO39P4EjB144adr4GIcHMJi8vBgaYDEpsuzTr9OQpiUIaGjpVAxcF1cCu7Vb2xy1LiHoS7ylhHOe1KrrDx3MErCLMpYwOkVR9QXqnehbUDhzSwvgyDpgReSxQGGshGzCwzh0Fx2x9/qhYma+d/deTyt0hJNrvE6lIdwTM3+h1adYPVK/VySUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGyB9zHjCEgw7c/5sfEwjOfPNxaUVBuno1+chfO87Sk=;
 b=HrDrf3RWN/UVn6JRXuGCbQkgHdX7sXDhG1W5lP8QqqVhthIVwC7P0ab/Z5k+Fkyu585SfDZKcV+3VLFckanOaVjSsdzNSPOgiJefip04SSsvJXIm2Q/GpA9YbX0Y82RzOBafKpYAftItjaPjSjl1bxpfWCdlI+ylL0aF9nhuhOQ=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 07:34:56 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 07:34:56 +0000
From: Zhai He <zhai.he@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, Jindong Yue
	<jindong.yue@nxp.com>
Subject: RE: [EXT] Re: [PATCH] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index: AQHavHGkZTyTCQFvRkmi7u0XTDNkkLHDuP4AgAAAofA=
Date: Wed, 12 Jun 2024 07:34:56 +0000
Message-ID:
 <AS1PR04MB955995BF689849177D95DE28EAC02@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612023831.810332-1-zhai.he@nxp.com>
 <2024061228-unburned-dander-c9a2@gregkh>
In-Reply-To: <2024061228-unburned-dander-c9a2@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|AM9PR04MB8273:EE_
x-ms-office365-filtering-correlation-id: 587e864e-f61e-4cd6-7823-08dc8ab2282e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|1800799016|376006|366008|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cklo/9rBjXm/gL8ZpuEc0ZVHYXzI6ghYz7cVCRMpMUuBzzZ+y18d+uNMyLfT?=
 =?us-ascii?Q?GE0Et9fKmT4OG7vOTHzPDL4jD1OmHRGNvWkzWbbbvA7u7BN1+ladncQguPE5?=
 =?us-ascii?Q?fekbGHbNgZMFO1QqUCSuY3tKbZTgBcGPH8QIOsioGQwidPBDg0xgynoSPvzv?=
 =?us-ascii?Q?+fcv4ISG+zKohndjB7HWzrfD+Hsh72mjyyy/QOmIP1Ng0QjKxKzWgj9y83T6?=
 =?us-ascii?Q?j0vN2qZf3b+FhFF678AXCu/gXYVejmLH5Do1iXw2PGNA6Xj+hYNBzky9+ecT?=
 =?us-ascii?Q?dZ0f4HidU4IfLzuYRCkmbPD2ubFhlI7FX/DJt8jtbdafKV6eXDiCoQhYUQ2T?=
 =?us-ascii?Q?Tu8Hal7LMZIeiFzvfZ7V+5jIUndPZ+QXLqLX1q2zgaDTlJGXruhlc3B7UqF9?=
 =?us-ascii?Q?bo1W66D9BTFgH0XD/kIN0T3zJAZA3A/OvNOO40skr53oY4O/T8yVazfgoSPn?=
 =?us-ascii?Q?tVBIIW76gn//mNV++ctlk1rX6H4Km2zZAnjq7gPltt82C26XMf/9UydDKtse?=
 =?us-ascii?Q?C4NMrttO1IOAWjqH0DFIu4+OO7xOpZ2Y6xXM7cJrQAybaa4ttZtiS9B2eChH?=
 =?us-ascii?Q?v6D7iAP5YelbGn+tGI5vomGld/Ur2MIbaYYa2dHPqCV8LVNDmAzogcT+AFWk?=
 =?us-ascii?Q?YnUZ2MBpu5yAFnSp0iJJxTNshBM7vZcuZcEGIWFGRnLGkYRZ7mZy47JZwhZS?=
 =?us-ascii?Q?z1yFgkiChO1mlrGZhgFaWxY5bZH72tN4GScwTJ2AXwj98ckqihktCDTsi3ol?=
 =?us-ascii?Q?twjMQzw439c+q4T79IttAaC/aPXgjGB+c19WF9qyk1548x6wc4x/XJSnS8n+?=
 =?us-ascii?Q?m+k233oFVS/ryIDucW3V1YJ+cokNhGlpjcnwbhG+x4ILqZuToC8AVke3ae79?=
 =?us-ascii?Q?5BYpzbXvNyrPEX5/eBYK3d/L8GPCdrXvU70+a+rxEiqWslb/1MtnzuQOTF3I?=
 =?us-ascii?Q?aLQPcv/O5XUTfs3PoXxFvG8sCCsm+ehcm937dkwU+Uu7LxDKDrSed30ggRRk?=
 =?us-ascii?Q?35FE9IJMaNvISj6kfSn8BfLXuMZxbr3B6yyalbgKM0j2/0GK6xESadQiVuwm?=
 =?us-ascii?Q?WeMPupOPjPRlQ6tg2WsopJmL6G6kWj7n7I2oUANDxupuCoG2IR8bBB2OrtVh?=
 =?us-ascii?Q?oV9DJIVG8QHH3MiPVANLfHeIw0gHTvJdI/tJvyjhHUcuyAjrxzptlv2ZjOrQ?=
 =?us-ascii?Q?gs98KKQBioEkgKHS/0PGEnCC29P57WE1spkePM2fCgoQYjwf4nmu1GfuGzwx?=
 =?us-ascii?Q?Tt94Gfpd0huSM/bAxDGtFeO0k5qaiwU9IXzG07MMNrePhBIAh/So1m1KCmdQ?=
 =?us-ascii?Q?STynw3NQzh8p0ajs+GqkboSFN+5Mby5+tWAJcZsvoejFh++IlGlQWNHWlZUY?=
 =?us-ascii?Q?dTqOBte84wu53nZNxdiXgfCSHf50?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(376006)(366008)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eCBoBbFoh49WlM+m4pTsK6cUdiFOsKfhsQCy75uT5k1B9Z2VhN8BfMgOwFsQ?=
 =?us-ascii?Q?5MLoiSvGGBidZxRK8mCWJ4iYVF/mpUJe/vSolcYD1EIj8zoIA6zudP+xP3Y5?=
 =?us-ascii?Q?muVnxhyNfDdk2YdLkLHCknNYblqby94zk5SxB3oJxjk6EHmo7pEF8mVuaibf?=
 =?us-ascii?Q?VmqrUcRB1VqDnQWTxbRAaTGQFcw3iQ0HFH7JpFsk08CTCmr4lwzxbob972VW?=
 =?us-ascii?Q?9ji2Z5mLwze2JaU3nVyZfuh1ve4QULQHRptwV5UWCUsXMHexLPDUygOH2Ofh?=
 =?us-ascii?Q?0u7Dr0UeHA9KXo2mC9nNEfmfv+ESj9RHDm4pBKbtx3ROVlnoy7/n12u4Lf0c?=
 =?us-ascii?Q?YnV9a4EglL/UY/HVSAMXCYh1ILbpfzU84SWbyWYyxKebnZXzCeOS4G+MwC/W?=
 =?us-ascii?Q?ncy5u17CeBFejzUfLBJkf4+Vj3Vv5rL+fshxhI0TkByFLbxkeI3kO8ZTUEi2?=
 =?us-ascii?Q?Sqfp+OJPDAz02w7wlL33aABHYhRocQrHAF3b5FqSZCOtzrFuV2KoK8oehkXR?=
 =?us-ascii?Q?fDZE5XyIdDseODMF+BWCNuw/rp5w6CljFtcC81/lzkpB/w5r2hS9yilYyn0E?=
 =?us-ascii?Q?KlvW9I7j6yhN1qMT5VaBk8iCKW62N5jq6TdP/JSa1qBS5hTFtBetUC+MWCpf?=
 =?us-ascii?Q?HziO/xvW0Av1KKVUOO41cJBKwSqsgL7NIlVpu+F5/IKJLIRwB05mYTfNDJjb?=
 =?us-ascii?Q?FK53rXBmv1zyF5ZMpR4MII6bvpehv70NaaZRh7XVBEUR91Vd/cOfrglrg90i?=
 =?us-ascii?Q?I8IpuDeQdZDO6UhF/p7edrlSnEwwP88eRwSxjBapgzgkss5WtG6ZGVYMscrP?=
 =?us-ascii?Q?rKJ6xzwEzX7e287SEk5A8vF6IV5qVgN9uh6lACcy7Sk6MBiBg/DhhFtdLEXn?=
 =?us-ascii?Q?Y4qJtDmVj5zSlsLnoYH17oLJGUTcckFtuo1TJtdRPyNVY9qpdIHwlUn98bOh?=
 =?us-ascii?Q?GtNR5Ycmf+XRzfhiI2fZOHrULt1VTgBosoOsgrPn8PPdqhxeadSZZoxMxEXJ?=
 =?us-ascii?Q?uqNsiwcozCwNlllS6db4GWlEVG3ZP16Qq8sB5irCR8Kq9v6ijZ/OmKTujyqX?=
 =?us-ascii?Q?pZUiwzPGznfpjTD9s4ADz0pBLe2RRLyILG32988jiCRPjBNUn9I9NDrsWA90?=
 =?us-ascii?Q?yuTCsagpNw7wAPZ528xgqZHYe3pkKrxSe16G8gYsdEwNBo5pFwVVgeOkBdFo?=
 =?us-ascii?Q?1tqiin4TbuXMxOb7NQEDxLrBYC7BFWfq5xyeORPpZCeA4FzLyr6iX9lkdZ7q?=
 =?us-ascii?Q?HkCyAwm0wu7U3ru2BwbLXPimMgEYLIyiNosbrlLDPtbBlquOEN4tRl9ro582?=
 =?us-ascii?Q?4phTVVpXWhqaOfzl9ImXHiRFKQ5TDsb3ihXidCeVXIWTcFNvpp6nGkonqo2U?=
 =?us-ascii?Q?A0TPIFcFBdmF54+pHgRNMAN2nCv0YRwMP0u6nodXOBsmXG6V+GcEttBsLzgq?=
 =?us-ascii?Q?fKuRDK2jDJk1yH9O4d4qtjVeVmovqlp6RwH4xm+T8heVfF3fQG5ez3quV1x+?=
 =?us-ascii?Q?+NoxzUKUfCR2IE28xx3LzM34rG/NrIQhKLRbVhV3cyakqEbRRRaz7ok08mK8?=
 =?us-ascii?Q?KNbOsyb3F9b+BelYm7c=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0094_01DABCDE.12041530"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587e864e-f61e-4cd6-7823-08dc8ab2282e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 07:34:56.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hfuy92uWCmXcIv8Wdt+gdQNQQx0dmfSlrvBOKnor6MwcWEp5g2tLJ30E0zxrcHuk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

------=_NextPart_000_0094_01DABCDE.12041530
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Greg for your review.
The reason I changed the error level is because these logs will be printed
when memory allocation from the specified device CMA fails, but if the
allocation fails, it will be allocated from the default cma area. It can
easily mislead developers' judgment, so I changed it to debug level.
I will not use "__func__" in the next version of this patch.

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org> 
Sent: Wednesday, June 12, 2024 3:20 PM
To: Zhai He <zhai.he@nxp.com>
Cc: akpm@linux-foundation.org; sboyd@kernel.org; linux-mm@kvack.org;
linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhipeng Wang
<zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>
Subject: [EXT] Re: [PATCH] Supports to use the default CMA when the
device-specified CMA memory is not enough.

Caution: This is an external email. Please take care when clicking links or
opening attachments. When in doubt, report the message using the 'Report
this email' button


On Wed, Jun 12, 2024 at 10:38:31AM +0800, zhai.he wrote:
> From: He Zhai <zhai.he@nxp.com>
>
> In the current code logic, if the device-specified CMA memory 
> allocation fails, memory will not be allocated from the default CMA area.
> This patch will use the default cma region when the device's specified 
> CMA is not enough.
>
> Signed-off-by: He Zhai <zhai.he@nxp.com>
> ---
>  kernel/dma/contiguous.c | 11 +++++++++--
>  mm/cma.c                |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c index 
> 055da410ac71..e45cfb24500f 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct device *dev,
size_t size, gfp_t gfp)
>       /* CMA can be used only in the context which permits sleeping */
>       if (!gfpflags_allow_blocking(gfp))
>               return NULL;
> -     if (dev->cma_area)
> -             return cma_alloc_aligned(dev->cma_area, size, gfp);
> +     if (dev->cma_area) {
> +             struct page *page = NULL;
> +
> +             page = cma_alloc_aligned(dev->cma_area, size, gfp);
> +             if (page)
> +                     return page;
> +     }
>       if (size <= PAGE_SIZE)
>               return NULL;
>
> @@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev, struct
page *page, size_t size)
>       if (dev->cma_area) {
>               if (cma_release(dev->cma_area, page, count))
>                       return;
> +             if (cma_release(dma_contiguous_default_area, page, count))
> +                     return;
>       } else {
>               /*
>                * otherwise, page is from either per-numa cma or 
> default cma diff --git a/mm/cma.c b/mm/cma.c index 
> 3e9724716bad..f225b3f65bd2 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -495,7 +495,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long
count,
>       }
>
>       if (ret && !no_warn) {
> -             pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu
pages, ret: %d\n",
> +             pr_debug("%s: %s: alloc failed, req-size: %lu pages, 
> + ret: %d, try to use default cma\n",
>                                  __func__, cma->name, count, ret);

Why did you change the error level here?

And when you use pr_debug(), you NEVER need to use __func__, as it is
already included automatically in the message output.  So now you have it
twice :)

thanks,

greg k-h

------=_NextPart_000_0094_01DABCDE.12041530
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2ku
bnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTUuY2VyMA0GCSqGSIb3DQEBCwUAA4IBAQBQ
ANZHE++z2tckAQ9ObZ4eEQn7UEflxd+Xkx2j/vosLOTU4NpZDsZsSUp+Z8YCCDdDVUa/gm/HoUt8
qY5vqPCClJUcHxGdT0SkBtQc+D1tRwcprixoKQcjleQQkq3o4tuBWnE+BRsGz12ffGhQuDy7Y2ox
6rHRfU5AaYjxK6MLQ8HZqR22MPZlTVNNbw5UPmT9HghAbLk3aJLVr96cRPp2m0tfJ9TNxIFqK/jt
XC3xZrv7i8VVM3VH89qZdsb1s4WXa7CmKbahYqPzGVWS4B24Dbkz7WPrp2qu/9eV0PLhMpcKROaY
RXaGJWGFiScaH3aGLGxcJq18IgPigFs6TnrXMYIEszCCBK8CAQEwgc4wgbYxHDAaBgNVBAMME05Y
UCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UE
BwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2Jp
MRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAIT
LQALnyoAQInA/QSoDwABAAufKjAJBgUrDgMCGgUAoIICuTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA2MTIwNzM0NTNaMCMGCSqGSIb3DQEJBDEWBBS1ptE9D+TR
p7NMuwagmMOKTHiU0zCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQME
ARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATCB3wYJKwYB
BAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJ
VDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQt
QnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmS
JomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AC58oXPwK6O6UsbsAAQALnygwgeEGCyqGSIb3
DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJ
VDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQt
QnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmS
JomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AC58oXPwK6O6UsbsAAQALnygwDQYJKoZIhvcN
AQEBBQAEggEAI1ZTYF+hUvPKZ30FejOODmLr5zkyDuV8Tlxax8Me7kd3jrfohA9uK61b8mQOiTiS
3WEGahj5rqp6dm873UeNH5wL2zAxE5ZYNcadEfLO+XSv10bgFuR0ZUFpdXT22+u0eDPrnmLlnF+z
0zqO7HPfJV4+9ttHL619fj0arAEZqj3Z6hgdg2tqImAR18qAuQQq/Cy5LF8HKNjXyJcgj4sUbIxS
dq0WW61H/SJyeXE+l63p9KgcEFkLQcyCzSoWxRyv2pmnJGtMvMTMcKYQLCVo/e3rh5DVmtBzdl88
D3p/NYBhJS5cxY05ECG4QFL5NW+RtHa2nQCxItvXsOfyAI890AAAAAAAAA==

------=_NextPart_000_0094_01DABCDE.12041530--

