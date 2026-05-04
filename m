Return-Path: <stable+bounces-243901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNedLezx+GnJ3QIAu9opvQ
	(envelope-from <stable+bounces-243901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:22:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1844C32A0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5BE730725D5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA033F23AA;
	Mon,  4 May 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="djqQfk8h"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B33EF649;
	Mon,  4 May 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921768; cv=fail; b=rXzJh6TMZ0eM4Lbj9PykVI7QQFQ4xTWwfWiWEz+GnWalR7zhl6EWRumOiGNfZw9seYWgLcZjHCBV023g7buo8tqlQx28HhtZW/qDVcGHfzo4PQFg40TsgBR00Et0IgCNXwiAlr+i8wqwtVzpmfbR/0o40o+cyRwk8XoIqRpnsg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921768; c=relaxed/simple;
	bh=rFyXfTJol9Ke5575FvB5QQyJisWnCJ1raNLY0KnUuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N4PwY+39JRZfb8zhB67Hvmr2cvCKLPXZDn48Jyn5BJHuPVD5vsIW8pGNLOzM7GovU0JDwOfAytezuMmbGx5eKYZymqsWR37vnvcoccGCMmrL40+mstRWNIiyV0bMTLtkqoCCDGiZwVYmzTmr1+8HdxGwnouG+pX0kZCS7mvZ5pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=djqQfk8h; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpNLRmiVafWPtMzQydc3603wsqeeyBMqmR+SQH8RiIhqFhWW6mzfozpusToRxMT9rHKIjeeuUBOYEjqsESQNEaLalLSg4VVfPiu5TCRIgPAP5vOfvln9Ko+XLHoYYGBfyI6nkpZEvikqgRWfX8xRreaCVGaX1HZQSYxM7jFx0/MS9zuKXo1svQfy2X/9L3XDH2rxB2HJ+mIXr+jhad00ZPIl1/JGUgE6EuSkY8UVTzRApO9rdZAA0HJvzXFnvAxtxP6ECfy6eAckvGJsE+JmyYxiIpUdmYBg8SluxenxfGhPqL13CoZyO+E+SR0ZLhA0KfpmZiJF4+S1n2bkjOsGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di+i30ZhNrDf9X225GCgPSfaPIxf6vPKqBNRVmvdYAk=;
 b=oAxT3mMdGMHvZVsoG1/32QBZLTH0rgWL1l3XqHYwDHO2Tc71qg3LJz3BFr4x942AfUBvPZdLfXD0a9HmoAaf9BzECuDrS0+FkD3UBBGgR6P5fUxXV6fN9xb1orprlSisOn2LDkvlQMDRCwsqbiLntfJJ45oGCvpu9dK4SSqTPWeYMTFKe6qcHZo9r+wIDXwbHDqFHZAPa9FGaoLFVF0S9K46W5+52sTxGIrz4NemjBxWsInO6cPSHpTkIJqdP0fqYAnhI6kF5yw5cFHR/whDRsgjZZ0PG0a9eDKDQ/RQvbSdudjQ7NgO6qGSDdDGk7viHGp2r3eXyJ8wy0Y2U+EFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di+i30ZhNrDf9X225GCgPSfaPIxf6vPKqBNRVmvdYAk=;
 b=djqQfk8hx+MI2nlpHRiS/HnHxJCJuCRqg+O3nfVHtbajzvnaVLPHajO8eCOuKQcYJJzMQ5HVStI6XutQDYv/+unb10BmNJFu7Rkllc0HS51ngFKjjJNv0gwzKXQHnUV0B9xGOVN3kHtN6g96Tchv9SYMcoB71rkoOrqYOGDcw9iigJwED6efptdcPt34XD7jueaUBypvh3Jga3JpPUIwfaxymBV+cpdtRh3kM9YnFmPhc6jaAHcFjaSL0mMVI0oHh1HWLfz6XXF/nwMvBFKy98bafnzE/P5JE1iHTLDyRiqJTPLodpHCtRKm/JXPMRrqfq6ppoKmFXSLnz/eiZbkeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:09:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:09:22 +0000
Date: Mon, 4 May 2026 15:09:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <afju2dg8fZ_RSD7-@lizhi-Precision-Tower-5810>
References: <20260502115528.530401-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502115528.530401-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PH8P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0d5b53-4761-4900-308d-08deaa10a6a3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 yaIkLvkjnnBsdES9rurlg5rxff9GBwLMFkqAILh9iEHv1MTxxknMF+52Yeg2/N4SCIT7GA0rFsSCBQqK8zT4kZK+d/Q4YCKto4Pco1CFkvquOvuxa9hawsdsel4Bbm3uXS+Yf9aqyb10E5ExTrD3q627SoOlTXsRSo9QW66SOBiM4kkRSBHIKClm6PUkLnAjsrVHwH9ziwmiEEeAspRmNzg1KLqjQIJClFmWdW+vTCKH8ZLDg7cDtxOfyZAkG3LIrP4dkClwfM3I+ZDTIt48MjkFruLKUEjq1IAseEPuRzhnC6Sn80/utFhUJDR9NW9AUND3z4bqdHUxV0Pka5zmVPySdxyWHFLNGj24ull6TBkKxaxm79gdah1/yeFzGKcJRnJzw4M1O9WHDI2TchmA7Tri9AWA9HaEntdrXqBRbN2eYihYmzJ72jJh+yp9nWQURzWD029pwdB7VxUrj+ET/mdTT85MUw2xhqfTQo8Fl0jkj1X3BLMUFYv8BPVy+Qp+GzAO7zavgspiszge3oEZjOgr3dhyy+i2/3OUdzp/G7kvyKml0R2PhMTb1jyBN628msQl9tnM7rZ0AyJCr1oTsGATnlgt+Iux37DA4AjIR4BHdnsw7+NE6l6M+B5+1IpcYNHwbcrNcFe96zfCNWUTLwZR5e9/8VhpY2i/6v/fMp5KDwcdpNWXJH3wARZ/EP7UJlI8XhzS3FT9mmaslidGQSnoXDR2Ji2PazGvfflRooAj1Z8RE5s3zO/iGIEHYCiI
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8BlNAMpyYqv84z/VTY+eCv8+DmWvtz5caWaLG/fflPl5/ilnIkK+4ldPjfv/?=
 =?us-ascii?Q?fYSWNnn/sb9wLjtLVCNdEr1rAer3kp0FZLeUd1lX9MLJ2p6n4bpAt8ORYJ0C?=
 =?us-ascii?Q?KbelX2OyuaYybgtxN+pkz+hM3pZOL/xdWvGnESKmEwkafXJUj4sMlf+ZMYUO?=
 =?us-ascii?Q?OH7NipRao32UsUpvP9YpQmXSBX1WJYEzryC0Z52ibttk5GDL3MdHitypm3f5?=
 =?us-ascii?Q?iz1bG9LL2vJM1Lffdqg25N4UabRq0/Vj4/JLV67bQuAD1DB1oORHDVHTYyt+?=
 =?us-ascii?Q?YV9Y/FfUeM3wSpbyrzqTUHGKcZUcuie4gFgUMB2HgwvlroOHFzLeznLcrl1z?=
 =?us-ascii?Q?sAjmuTKfVngZFWa4cMJ4Xe0ZOi9LXTE9f4T0RG7YD4RU2dykCnVlVmKsMUJ8?=
 =?us-ascii?Q?AKWgKGU29xw54ypa/FB9fQ8Sptsfv6aElGhTVlRhH0KiRQhrrrs5q0Iar7BS?=
 =?us-ascii?Q?j8FKYkTb3xx4sSGssLz/UZ4pw9uS/Tjuq2ao9ToHT1FkZ7AD+alAfaNc/kgy?=
 =?us-ascii?Q?jBnxUNIJdxkY2dE+uefVyElwGzIr85o44+XURenXu1ev91fq0hFrwBECYLdU?=
 =?us-ascii?Q?jidHfT26eieGtlysBHIG1K5rSiVTI6mqUsJBA2nI4HVmU+VVvX4xK5YxkUjJ?=
 =?us-ascii?Q?kfM/LMQBcCP1gpYUA4Ra3LqhGc1lbhK2Pbxy1nHrhsMeotvJLG76M/XJLlZU?=
 =?us-ascii?Q?7Lm06MOAehsQJ8sj+olS2JoHpobhp0RRSUuQ6j1gQ330bmcTaLDYe8i4h6zC?=
 =?us-ascii?Q?6UupM6vlHGL1scub5eiaRlLZZvI28Rk8UXpGfYl2oVrjNwMoUITv8b2Z2fsz?=
 =?us-ascii?Q?+PDw0/1UmG6FYDBTImEvr+eR8JNxapj/LWip2uvao1qyVJ8gunXRhb/94KbX?=
 =?us-ascii?Q?m2ZqE9RLgWFSxQ/i5RJdKzE7eb71fwi8lkOdiH+5Dda8B0DbLWTyFM1vj9oJ?=
 =?us-ascii?Q?duqzhZGNThdvaoGc7iSSpw8cE/MJNhYhxFrOJxqaUXVhGShf/8mvdZiX3w6h?=
 =?us-ascii?Q?JMDfpSBv8ggBbtRGpcvsUXmMp3ERm8ew81IOPrGMoGnBsHmuIiQlaP1KJmv/?=
 =?us-ascii?Q?XjRragPgUiymSospxxNzj1qnvfn58W5BmG2xOkGYjWB0rcknQiZrqWy6YfLk?=
 =?us-ascii?Q?07+RKMdmPgF03dlhfZUwbyfz6NnkuKwpArd+5cU90Tnlc0oIdzhxrNsIvDNY?=
 =?us-ascii?Q?ZUfi7wpKPO02dLJAWicGWh3Sbq/emU5dLejpHhVp2MOKMCVs7yLZnbucteZn?=
 =?us-ascii?Q?RirBPCQk6yKa9oEflko5UjxxMFm70H4/s+Gfod2XsJvMoUh8Ua2UUxuJ1cks?=
 =?us-ascii?Q?L3hilxNhkfUBw0XuH9g6+EvQhtR21MA93QXCT11QBs1IivbpJzrTwsJGtit8?=
 =?us-ascii?Q?RbP6bvQ/fmeIrrcBwXX0wU8lfImt3jg1Bl117WBC06Q5G6gZTMjd0OuO1b03?=
 =?us-ascii?Q?EYeGvKaWLUe/ghi2mVNiMcHct9R9mwGDKCZHAEXNtBeiBGyhNvFItEPPKhRC?=
 =?us-ascii?Q?3d1EBKPneOenGJwwRoOOYnviG0sOum/hstrAL3zwNZkImGkTRT87W+WnNOzE?=
 =?us-ascii?Q?NwP7hFt1YsbiEhxEOoggAT8HynlWchBginSS5vya1yGM0sVJj96Fzv5anbej?=
 =?us-ascii?Q?mp2/e31EA3st0ROL4lHYKY7KAf9TOYWU+9RMHP3hoNBzSZTALYaHesSiyKap?=
 =?us-ascii?Q?bf8HN3Xi64qpLiEjxk/ghcOuEPVER3f5vrIi81jGoTHxY30k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d5b53-4761-4900-308d-08deaa10a6a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:09:22.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv72F5RsEN0bXBsy6CbSt+tem2hefYnhtyVJ4tJG5ZHUDuMsXG3+HMk+37o05Z8u4essERPz1sWsHx/KFSuKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170
X-Rspamd-Queue-Id: 2F1844C32A0
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243901-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[nxp.com:s=selector1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.385];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,0.0.0.0:email]
X-Spam: Yes

On Sat, May 02, 2026 at 07:55:28PM +0800, Guangshuo Li wrote:
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
> This issue was found by a custom static analysis tool.

Nit: needn't mention this.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
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
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 55 +++++++++-----------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 441fd32dc91c..a82f10218707 100644
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
> +	int ret;
> +
> +	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1, &ep);
> +	if (ret)
> +		return ret;
>
>  	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
>  	if (!remote || !of_device_is_available(remote)) {
> @@ -287,26 +287,23 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
>
>  static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
>  {
> -	struct device_node *ep;
> +	struct device_node *ep __free(device_node) = NULL;
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
> -
> -	return ret;
> +	return 0;
>  }
>
>  static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
> --
> 2.43.0
>

