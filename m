Return-Path: <stable+bounces-244327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKPgHLjn+mlIUAMAu9opvQ
	(envelope-from <stable+bounces-244327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:03:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07F4D6ED5
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDC4E301EC7B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70132E141;
	Wed,  6 May 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqaabRXa"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EA2EA749;
	Wed,  6 May 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050994; cv=fail; b=twwkYbFepk/DAV2dBZNIoou0yamp74kkCOE0+A2P0IAc+D5aSlApJ82NPiwdmUSH/FfsO5APavGhZJXXOTxzrC4PCV/MKYTgQahfnUuNYlojQyzveafpoyV8jnS4eOuJclTvofy5OpJ2zKUNxL0rXEUtvUuPgvUAeCf9hkZ9tWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050994; c=relaxed/simple;
	bh=Hpgxtv6gih6Yt52645HLzVBMjRrdHGnm9gSvlrA5Owk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNI80Ks1ViSPir9GlcCe0ToI8l/CKx9Rb+bAy1w4S6EhikZBCZ+b9M5+JyTpvo5lJ1xvp6kEMOluLhcGx6XeNGGtA86ytC4M9mowReRq9lbepBOvBrXxp+MQ5dYsmwesBpTX9gEWfxmW3ePOlNu84EvIL3A0TV5SbzIA5PBI/uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cqaabRXa; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjSHVLn4zuq+M2zZCgN+JFvbkyZdj+EJLfR3JVUaoWZynkNIY9UdXSswOg9GYLJgYd+eOUjayKwXgUrh++FCCodRAgxCFNfOD/dDH+xwBDnE1Ao5PWWsw2kET4SQTU9wxxYWylnaJDuYFwGUH/kRDYtqA1TLUGQZGL2DJqkMp+Py1s++VV9NC7rEmLSJvNV1xKbh2fgrkB/VlYADWUXzxgjyt36EwWSh/i75CT/uxsjHGIGWwaqA+DBz+RcV8r9E81A2KzV04UCL9YarzNEcGmN/Ju8S90J3glwcEFAx0cd0E69gUlaomCTw7sV2TAwT5I1LnT7ONXCwa/sUcPh7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JA3nIN660S/nrqXCDDx9Bd65PjBY+s8DMW0UtiIyp4=;
 b=SoCvr5lig9Xka6GVR9B0SSUlTlmw+XIRDQHDZWxwM8JCTgI/+NyFXIUk+XJRO0HHemYUU/lZoMGTCBBcbMXGrgFVr+twmOp8PuMXFMSyA49z27Nfm0KE/vVPRA3FPpfX0KEraTjh9dJY05PkG84vh4bvpENeY0H7kml7d9sjTBBdiISdvbdK03QZp6H3aaoUnCpX/hLb08vl0/O3SH9es+iVJiO7cMb86ZS5kQvlZKTzq7RhSavMuCGBayXKrs4V815v0FK8fWCaImxieeI5h8mdm9y7FWoDsc0EmVOFgayid4Y8UlSJE/fjx+qxn4c/nt4K0NGiPabydFVKTK2Y5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JA3nIN660S/nrqXCDDx9Bd65PjBY+s8DMW0UtiIyp4=;
 b=cqaabRXaW+Fy5DnXtQAokMrzTVriZtEzHYUnpUFDWyiF3hXeXvtNJhB4Gd+Zi0EfU/rM0vK5+rU63ZO/ej12vmk7W6chu8yWLp2gak2nJ1q23EhGVO1GmuZ7HDWPt8pIhZP5D7P0tChWWzh3VYZV674L8yzs6OD5oyB2dYeu7rcg5yvpILkoE7GsMOHHUBZm9fSyBUB24tcOo3nXpYCk2R+BlqNTpHby2DDIaFLmxomtwWkMvSlZ9Ii34MimKaM1xeEBI++pQCqEW37bfAdbf+F9ZWijspikCuzJAYa4C1PMnwUQ4aai0n5j+4pIVSjMHsAXuMZ7fmMKBAmUhe83Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:03:07 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:03:07 +0000
Date: Wed, 6 May 2026 15:04:27 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <afrn-zcfiRpJzIcO@raspi>
References: <20260505082145.603262-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505082145.603262-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3125bc6b-68c5-4b5f-6299-08deab3d868c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 ao7/mt1/B69IMg3vA+wusEJnww8pcd0GNVBT6TB35Es7KKBnoIJ0otB3reom1MfOQbOaedoaKCywMHK6lg398eeqz+XwDDHbKcQWh6rgjAbculP0EDDMjc4US7ytDyp1KCrhWAf4LrrABjww9QzVDZ6hHi/t8e9OP1DmJqfH/X/JhGMx59yfymSdBa5q5G0uzZj446MEEQV95IWzUqhlumpPkbre0R2F7Zag8ZzEuVZ2PSy4xC/7bmIXht3e4V51p3MbBRlc9cAuxShW6GSGis9DzvWofXFSkd5fgkUJvLupNKi1aVRY31IPOG/DDcl5h6VvykEeDrH2XO61pWwzWk79ngpeBfuG97uEQPXTEUWRH7JzVIpvXkozrSM2ujQ+hqbL8RiSP2zCXrOPdvK5t1e+TIfB5K9ncD4qGmSCGUV1JoL9zvYF5TAnjg+po1lwVedzJdC9TnQXQc9xwHo4BqH0X6hmwvIDUMLfZr05WLjAFdRMwAXmRBLFHnhTnYHxn0H3rjVEUd3dvYowRI2miQqtYKwwGFh0dGBKXhDTe6n8rKU4tZWiuXSx3+gMOWYkak0GEF8Y/pBXHfzQJexbyYIr6W5UmkDJCf2Oo4NiXH+CsiUqhWYrNJ1b+/KUxiP17nBVzxz7T4iUPPebN6ucS2Wi5AXkHfNbtY9Ap5NbXrNNfw+oTNgi+C4uJqNsjVLv
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Uh3Jv9nUIR3tbCrQlTJCCrzdZ0Zo+OzxM0nA0p030+sFbVSs1fGxiQrnS9CI?=
 =?us-ascii?Q?e1elFj3ZVRQ/Weaac3MT5B3kEmEPq0kiD5t6S+xoDZiF/vXFIAAkPCeUiTbO?=
 =?us-ascii?Q?ogzAbNyuLzNesKrp4+wBSf787x6CUa0Sze1u0LWmtg9z8yiulg/261BBSAHq?=
 =?us-ascii?Q?W3B3BvP9OA+JvU2orQ7oypXN4lH+ACcXtV7moN+D0XHqUbE3czh0H9Z9orzs?=
 =?us-ascii?Q?ebVqj28ylL5HaLD9FqQ98zP140rLdaF2ciwDmdWNQ4JrPZ+7evuXKeV8j+sm?=
 =?us-ascii?Q?YFgjA8FjoZ4Q1TqxJOzfG3SP9d1ysY3B71z5ej2u30W2SCIY1doPdLapg2k0?=
 =?us-ascii?Q?s6+9hhg2e9j0gD00+cwaI7sc1T9xabHI51rlSAPGdaebysBfxsad0lyhOQMa?=
 =?us-ascii?Q?XXr/jaaKgn5LeTDk+YnhWzJ3XWaJLiscQpEU0jrK+yaGbU1u3vnCVKAHrONr?=
 =?us-ascii?Q?I/JP6cNfAVu6GCseSko2Gf57CtySzbu2sLecSb4Qo9G8mGT1S0FMpSKNzDiq?=
 =?us-ascii?Q?bOk70EpUJZt3tn8rIhaZpViGyY+sEH2fyR4921VjLCXcJ0RX2NydvMTBvH9Q?=
 =?us-ascii?Q?Es0T298ljKjEwDCe/7UiPxUcEpziFkxJW88oHckhWQYn3OyYQ5qeroBx6gEq?=
 =?us-ascii?Q?UW5JGPdBbMDOjkGkHhiwFxkc2Ak7rK4aULNkqvpFmOYFvT53f8m2XU+ma3pX?=
 =?us-ascii?Q?gB86422Zhnf2mTr7go9L3C384ypPZrRlLhYHWOJKOzMuDmP+5MLH+y/lJn4Q?=
 =?us-ascii?Q?DBcg0pi69yBtInszmKduwrZA9OS1Jaftqt8/YQcvRfEiwRLMw7OiI2BVac05?=
 =?us-ascii?Q?rJOtVawE0l8xaofLThDirpeLFE7jpmp0bRe2IhYrpcaeWWQY4BBQcB7CCC/H?=
 =?us-ascii?Q?H8ouJkWDHA0wVmdW0ES15wiDKUCXoOEPUns1CqxfzFghW1FS6UjMthUfdCzN?=
 =?us-ascii?Q?Jv3RjJUVnXC8ZuyHhjrENcHRi1qZ5fqZj2q20kZH5+RRimvMovY+YwPsLdWU?=
 =?us-ascii?Q?pcZMSabQrjDNCr75JZ38zc7Gu8yOG9sNORJYJpXwQ9hJj3Cn+Ui7g7cN5QC5?=
 =?us-ascii?Q?iExJVmrguInmfdyVnLsxKD2ouv7hOoS6lyWTCNlSQ6BdrR0sf3hvHGjRsILk?=
 =?us-ascii?Q?mduyaJ64X0WlVEY9NbfAYArtTpR7QyFwR7GlzlUMh55CK8I9HHg5p4HhBQe+?=
 =?us-ascii?Q?HFJk/4TdvkfuvcELQyWDIcZI4IsGF0OS7AUYK4p6FAcp0UnQoUbogTbH3g1B?=
 =?us-ascii?Q?+w90VeW42+Ys88tkbTMIUkr6c4WdLV9gjXZnL11sorsUiSGPpCQKezX6/Id7?=
 =?us-ascii?Q?SxK7WfCizNQfTJ0LpdfxoLk9ieRQ4FCA8QAyA1Ucd0Ttn1dz+ctaBw9w4WdZ?=
 =?us-ascii?Q?jBfxS3CKubGj/j7IIvfnIIDL24oeMEAPH95/UCYrL9zuxgvYvDJPbHyu7wWR?=
 =?us-ascii?Q?wMgFKODyr0Uj77FWdTg+s8GJmfjNDdUoRNkbuZPcRBYKoCe3b/RVrXJ5EBXA?=
 =?us-ascii?Q?J49Z+LCOsSc2Bp5rFtSf3F0iBJrDny1M1xWjGaMwayAJiEVrRGgqGc9Jomj+?=
 =?us-ascii?Q?2xCltKO9UFpqRZWPp1YK4tQ7M6nV5vgLCSvt0KYRpXr1dfTYC6+hu0B3SYvh?=
 =?us-ascii?Q?nfMW0EhUcmuU7IpR9wNXkNr1eKw3a8Ie8ggxOfTKEytvX45fSJhrnGTu7CHC?=
 =?us-ascii?Q?q8YZ+3DCtgBfSKv2BmcNzWrGrY2SpQHQl4qvAtxuwDXhuSYWRDG2abRoYttm?=
 =?us-ascii?Q?74wf2UqKeQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3125bc6b-68c5-4b5f-6299-08deab3d868c
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:07.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+cR6BGgtkI0YOxgjYXg0oMRDeSBorzdE1stSdPqwFzRCxf0j0UpN85d8t1Pqaq25HGPMDYxc/fCb2mfsXI7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851
X-Rspamd-Queue-Id: EC07F4D6ED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244327-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[nxp.com:server fail,0.0.0.0:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[victor.liu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[nxp.com:server fail,0.0.0.0:server fail];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email,nxp.com:dkim,nxp.com:email]

On Tue, May 05, 2026 at 04:21:45PM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
> on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
> value in a __free(device_node) variable before checking IS_ERR().
> When the function returns on the error path, the cleanup action calls
> of_node_put() on the ERR_PTR() value.
> 
> Do not let a device_node cleanup variable hold error pointers. Return
> the error code from imx8qxp_pxl2dpi_get_available_ep_from_port()
> directly and pass the endpoint node through an output argument. This
> keeps the cleanup action operating only on NULL or a valid device_node,
> while preserving the existing error codes.
> 
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v4:
>   - Drop the sentence mentioning the custom static analysis tool.
>   - Add Frank's Reviewed-by tag.
>   - No functional code changes.
> 
> v3:
>   - Do not change DEFINE_FREE(device_node, ...).
>   - Fix the driver pattern by making
>     imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
>     pass the endpoint via an output argument.
>   - Update both callers so __free(device_node) never holds ERR_PTR().
> 
> v2:
>   - Fix DEFINE_FREE(device_node, ...) directly.
> 
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 54 ++++++++++----------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 441fd32dc91c..881ebb811eb3 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -222,52 +222,52 @@ static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
>  			imx8qxp_pxl2dpi_bridge_atomic_get_output_bus_fmts,
>  };
>  
> -static struct device_node *
> +static int
>  imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
> -					   u32 port_id)
> +					   u32 port_id,
> +					   struct device_node **ep)
>  {
> -	struct device_node *port, *ep;
> +	struct device_node *port __free(device_node) =

Can you provide a minimal fix for stable tree by not using the cleanup
action?  You can add the cleanup action with follow-up patch(es).

> +		of_graph_get_port_by_id(p2d->dev->of_node, port_id);
>  	int ep_cnt;
>  
> -	port = of_graph_get_port_by_id(p2d->dev->of_node, port_id);
> +	*ep = NULL;
>  	if (!port) {
>  		DRM_DEV_ERROR(p2d->dev, "failed to get port@%u\n", port_id);
> -		return ERR_PTR(-ENODEV);
> +		return -ENODEV;
>  	}
>  
>  	ep_cnt = of_get_available_child_count(port);
>  	if (ep_cnt == 0) {
>  		DRM_DEV_ERROR(p2d->dev, "no available endpoints of port@%u\n",
>  			      port_id);
> -		ep = ERR_PTR(-ENODEV);
> -		goto out;
> +		return -ENODEV;
>  	} else if (ep_cnt > 1) {
>  		DRM_DEV_ERROR(p2d->dev,
>  			      "invalid available endpoints of port@%u\n",
>  			      port_id);
> -		ep = ERR_PTR(-EINVAL);
> -		goto out;
> +		return -EINVAL;
>  	}
>  
> -	ep = of_get_next_available_child(port, NULL);
> -	if (!ep) {
> +	*ep = of_get_next_available_child(port, NULL);
> +	if (!*ep) {
>  		DRM_DEV_ERROR(p2d->dev,
>  			      "failed to get available endpoint of port@%u\n",
>  			      port_id);
> -		ep = ERR_PTR(-ENODEV);
> -		goto out;
> +		return -ENODEV;
>  	}
> -out:
> -	of_node_put(port);
> -	return ep;
> +
> +	return 0;
>  }
>  
>  static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
>  {
> -	struct device_node *ep __free(device_node) =
> -		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
> -	if (IS_ERR(ep))
> -		return PTR_ERR(ep);
> +	struct device_node *ep __free(device_node) = NULL;

Why do you need to initialize ep to NULL?

> +	int ret;
> +
> +	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1, &ep);
> +	if (ret)
> +		return ret;
>  
>  	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
>  	if (!remote || !of_device_is_available(remote)) {
> @@ -287,26 +287,24 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
>  
>  static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
>  {
> -	struct device_node *ep;
> +	struct device_node *ep __free(device_node) = NULL;

Same here:
- Can you provide a minimal fix for stable tree?
- Why do you need to initialize ep to NULL?

>  	struct of_endpoint endpoint;
>  	int ret;
>  
> -	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0);
> -	if (IS_ERR(ep))
> -		return PTR_ERR(ep);
> +	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0, &ep);
> +	if (ret)
> +		return ret;
>  
>  	ret = of_graph_parse_endpoint(ep, &endpoint);
>  	if (ret) {
>  		DRM_DEV_ERROR(p2d->dev,
>  			      "failed to parse endpoint of port@0: %d\n", ret);
> -		goto out;
> +		return ret;
>  	}
>  
>  	p2d->pl_sel = endpoint.id;
> -out:
> -	of_node_put(ep);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
> -- 
> 2.43.0
> 

-- 
Regards,
Liu Ying

