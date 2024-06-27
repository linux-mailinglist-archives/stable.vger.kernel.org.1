Return-Path: <stable+bounces-56007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1091B25E
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF791F234FC
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3063019E7CF;
	Thu, 27 Jun 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0Y14yge"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AF13FF9;
	Thu, 27 Jun 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528388; cv=fail; b=GxJxKyuTPkg7YSBeIIWnpEj/HEFx/PrHAifM6JaiiJuY2dRa1qYJy5DJIdHcBf5Ajj5x5UMqtfKHC06GBFlJo7ALPyQZZy6sENv0iVLcoE/rzXYACX7s8ESfMYcs459StcdZhyNG4dcwo3lCj6ExO5RFv4ByJkRrlt4o/s1D4cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528388; c=relaxed/simple;
	bh=XBK4Qm2bWpNLsHIoMAZhfmgodqIxhgQma2a0l/JfeTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cer2kl45NK8rrxxo1kR+oo0MqhrxYbTvicGKR6l1NNX7WxrK+S67kgwBh1XY7RQhlN2v5TB3ncyBRdQDpjHqIpMKACaVeoDF3H3hpPrpFtd7Ac4y2hvSWAkUui0p4r2/994Bt4WheulEGcqxymHb9ioMtsVmOSa/sBju5IRvOgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0Y14yge; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta7So362v0N3qJMSWJYWTVCuVM9zptiKbVTnVwOmM3k79oL6/HlVmqPBB4OYQllxVHl2KAqiaCxITDLND7tZsGDjB7LJ4puXrPAqEqvHPognFBarsO7dZEWsM4pXAIFPxBllpWG/3RKh9Kf3DDNt6Es88FSLPnknzyou860oAZlaSwSj2FeyW9S6wtS0DQ94GovV9ykVbCl8REKWJM0lMdIgdSHzQXU14MERFCO0TUlRov7Tqa1Y4kBCtfCwtUVNbriAWDhbrz8mJ6U98u0MuxiHEHqcPDriZJ1J3r2pHUaBBS0NM6Q3ve4knvzIngWZCvrsLuviD3UgriOMBeP+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrdlN3pha+dh991iOk9EkAYGGZ1wNDxFTO4amcCrnVI=;
 b=dl0GVrLGSwju3XMcBIGDq6WwqLT/IRLs94rk60a/Va7sq6oViZBpJjvtU3olKkq8RzSL0fKfpjfOHfy8wkqRH38wCuTeJNe15vmq9DPVASsty5WM5VxV5GhRLTZ11oRUK6WdQIaVVkSlETwDBCC/lHxf5bFtPhQkyyPFwVChbZLon73IXaWOO8L5UzB5e5hEjLViT22u8NusvQ0+B4SoTRh91Yo6pxCSmLxnz+/cdkct1kvIqAlSgSVp3wN2OCtjaR7U+f+ZEnDxWdB4cq+qMN1ocQ8znQNQ1637f45Egm8HNJHkIeAsPqO/YVWAGTjrvA4SC/pOxQgLgwsxlSsMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrdlN3pha+dh991iOk9EkAYGGZ1wNDxFTO4amcCrnVI=;
 b=m0Y14yge1io5lFXsF8Nrgexk2sEee5dbAZvnB6iqg6oZR6IedwyPlmRiyvNicXn9Z4L4p4iJBClAtIcgCoHaeYqLp+3vAjMABpt4pyUV857LWs74++qI+STdfb3tKuarodRDPkX+erMfY+PCusTeB2GEpSeMoga1coCoUSBXwqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 22:46:24 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:46:23 +0000
Date: Fri, 28 Jun 2024 01:46:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	muhammad.husaini.zulkifli@intel.com
Subject: Re: [PATCH net 1/1] igc: Fix double reset adapter triggered from a
 single taprio cmd
Message-ID: <20240627224620.brr6kivuotedzy65@skbuf>
References: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
 <106e0d31-c520-4ef6-994e-df1a4c9a986e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106e0d31-c520-4ef6-994e-df1a4c9a986e@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::14) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: dc10800d-eeb0-4977-7f5b-08dc96faf88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KzTo6IOVUkJx8/h+ot+oAUb+/judWKyw9jRpbIekBYtApW4bXTclYX3RN8Z1?=
 =?us-ascii?Q?GaV6eQycAvNxLUHI+p+C7aPcxQ5bZbH4AdbxFP+GfO0NCl2JjKqFnqiEPNxP?=
 =?us-ascii?Q?x/0SCxODT+Bw5o95V0WstG/05vxr29aaBillDBcQopSgVocRfiVYLwJSqBYF?=
 =?us-ascii?Q?idQ/ZjQWpn8JGJzFyNg0g+CXlJ9AQAMHq3wyKZmvGtgVT+zaLiYi6CkBf+SR?=
 =?us-ascii?Q?W4TRmhAQfoiDqvTiyDpUSPxEHPVX8OLUHjIJsGgV5wuJbv4J7d5DvBvIfytE?=
 =?us-ascii?Q?Qy0z8/KLDTi+bMLzlh5zLUIIpFvUZhi61GBWsQL/B51gYxLuLxM4JKRq9U3d?=
 =?us-ascii?Q?If4zi/qtzPGyOhV9F2BZDK/HMFnK4sy1bNJARo1s4P2Mv5l1Al1PlQ606Yue?=
 =?us-ascii?Q?BqXc/eOEpwRCX70AumKuqJ56x8wGsRDnxGNxQFiYrCa9dZ2SC0qEciSBBKrC?=
 =?us-ascii?Q?JMpS9yXV6QfhoUq4cGidbygDyTwZGCCm/i/ANdAvG9gMgMgH+KCItpBmDJeV?=
 =?us-ascii?Q?TZWVjqfchDc8ngbovj3W1xXy4h+4drVVXXHt/dLDWhz9Ua3PLRADqZl1mS6H?=
 =?us-ascii?Q?HiG2T1nF7SbBCceDvwnwv1+U83hZRT5j++OJRPdhuaYekx8nRVSbpGIoe4XS?=
 =?us-ascii?Q?agiM6iN43Wo/U44qQReetbByWifCIdlEoNx1GoulAbxzhLClFh9BRuPgB2eq?=
 =?us-ascii?Q?D5duVqkRNF95Y0BXY4Eh3+NWi4JuqmtJNzqzCfE9CEgaTCdtkm+UzamECRqn?=
 =?us-ascii?Q?8qw0G+L9Z7vq3U8FdgWzn7um85zFIqANroaTpd/hIDm+UN2UubJSVak6YauV?=
 =?us-ascii?Q?4tSZAZyuHVR2+D18F97sGwLyfYQic6aMsygcmWcL25xHDD+RjlCFWXyzHBfL?=
 =?us-ascii?Q?J8UxJt/dXSuAtkmRGat6Qx85F+sjLb0tA91htXRvyY3zNxpMvZdXH8WkcBh7?=
 =?us-ascii?Q?mOnwn3w6H4+cetUgvHbLFi5MMxUr4JKQIGwpz5pnLL1pQaSQQW6RJ0Hj3h6d?=
 =?us-ascii?Q?vFFu6BVzpT5ZoNjSwOrkAstpn6hSVUkwD3P3MQ3iLsf83hJuHE17WYTBRGIO?=
 =?us-ascii?Q?NFlIpkGGmjn7NclEjk7zweOoF1BVLPfLgdG0K6n4IUsi2tINfGSVsDtArzFi?=
 =?us-ascii?Q?EjsYgOYDX7bzpeG9b7QWqZRf8LN/hV1Izyd471bSk5SIeRZ72EzhtOKJx/KF?=
 =?us-ascii?Q?2TFx1UPKpi93mYdV2nXycC3EW9zb+ei6sMLKVxx+AS3MHA4/bh2FiGmRruHm?=
 =?us-ascii?Q?RZY4/slLiwqLTK7eUJ3YMPnLcIC3ikm3ag4y/BMqTnGbCdAFjQsK534C6vOf?=
 =?us-ascii?Q?YzsKXoiCfMpu90OgkMcj+7gLxO9r/c7EIOYJX+WFkC8e0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iYW2uuG6aPBpK51FpT1GZYr3nVmF/y5NovX63zYNq3gaAt7+BsmYiJUvFbz?=
 =?us-ascii?Q?g1hFv5mKv06nxpsKTB54rNw+APeBi7r2KkOzKyTQ6/fXqX/fM3/yEgKlj+sv?=
 =?us-ascii?Q?o9APNYl5eDRK4vaDf/H3uBv6i8N2yuOPev6OUeDP7B16XX7T73NZ50oixR1o?=
 =?us-ascii?Q?In92HHhnuxol6SQUyyivsGmV3F4SlmUK6m/fQS94si0Rl8wTu47qfcJJ9IPx?=
 =?us-ascii?Q?s2icfDn2KYNAgq/hp/v7DoMgEQzKn9Bi3S3kZ0dyWcz4vWGYpAKEITDG/YJ8?=
 =?us-ascii?Q?+KnX0f58xurYp9E5JVbpBbXOUA7GvY8MKVFGawKZDnG3xhff2/RDwUpezqm/?=
 =?us-ascii?Q?gOoaFoVUnDIvgdAlKkewWYMc3UN8Y694aAeVMXG79LcRupnSnJVjJ40b7LTr?=
 =?us-ascii?Q?Z4BbTsHfq/vIx/2+WJnmPa2zkMONoguF5hD6jcZOF9VCiqcm0ZScQwGTXF0p?=
 =?us-ascii?Q?9NeBy8QdiOhu7B0s5ZwHxD7tFWY335kzNT8jMpx2j715tz3hCmjIamDWgC1s?=
 =?us-ascii?Q?V/i/NIdEm36rUQC0+TJlQP1fHEX8XSZv664yaAp/TADuMniJW6hd2wAcMtYX?=
 =?us-ascii?Q?LIzXfqhBarm3gGdUp6BakNfb/1S7P+ilL8z2URtSn9U8wWs7DLzQlrcrdOm8?=
 =?us-ascii?Q?8GetfrzwwwnZw/ThhdQUsku/sYbB6ljFn+GFh65trahP5vdfAaaoweINVrbH?=
 =?us-ascii?Q?IW0ZG8a6hxZn4QCMwhTQypHmbh7glxnYMnFtfE/UqmOo+tglmqBV6rrPJ0j+?=
 =?us-ascii?Q?a2b4ogbdpA2HF6PZ7viOZqj/qHdmlAwZ4ioUAhrMNviNRqRM647oaWb7gY7Q?=
 =?us-ascii?Q?wUyYF+WIa/YRN/tDyFPA5ew2qvukLeNW2uj13rySHJWgoXVVIV/JtHLFGxwr?=
 =?us-ascii?Q?63QzRVL5n1qRmU906plUVlIh1sWRK2gnJco2IAvkqcFObkpgMlga/3Hf+L1B?=
 =?us-ascii?Q?jCrRusPmh6X6V8a75V9bf12gHylINBbeaEOAeJnRH/wgV/m+brHINSNW+kmQ?=
 =?us-ascii?Q?OBUjvFgEgqrXUkInXMZjI9oP0/9gtSkas6WCU7uXt5YlZAIdAi4gDjEKtzhe?=
 =?us-ascii?Q?BMv9P1oiNmwiYyie+RYbJsbUwWgCBbWOZ4j2pqN6EvTSd9iWvNlVKyJ6jM6M?=
 =?us-ascii?Q?3YVAhUF2WLO+3L4mOTcyKqe4HKUlbEBYKskbI6drUT3MWShVy4aLu/9dK2hY?=
 =?us-ascii?Q?yh82EfyonUi7N0rjWOU9zhVkb+Dl3UjCKg4XU5osTmmr+U4X6DQXyBZg1jAV?=
 =?us-ascii?Q?K0Dy4T5q7tLIfDnOAdBa0JvVPqtLT1uEvDBTjpSTrIjt0d45vyvs510fAvNZ?=
 =?us-ascii?Q?PlL37ems+URvD6qu1zW8uIw9nTgo52aj8jOUGV/4DBI3jQb4E6i7dOvk/2zh?=
 =?us-ascii?Q?W6sdKpmWwrhZV92//zOTD3INWmKLBOlZn3UWd/TuClj0ab2H4MGoaNnGN7wb?=
 =?us-ascii?Q?dwr/wEJ0x+FOB9JhfOskh5ViTDSeBfQMBRlVoBbgWSO0xSVxJ7tsLPgcahvX?=
 =?us-ascii?Q?W0jB3m3dgRXCLBfxqsqaZV3Bgd2cunyD0MuYu6t6AZ6xe6qaMY+2K6l/S1Hx?=
 =?us-ascii?Q?r3rGAiFBfAwS5Ml3xRu9c0sc2V6Kwgp8spAcvmZSKvaa7NuKcaKw3tQ/i32T?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc10800d-eeb0-4977-7f5b-08dc96faf88a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:46:23.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8B1y62eqW58vlrrjJ8dqJUTp5NsW9ZeAh4JSW7EOW4whkI3PNE3dD3sTACCnj9IfOQAm76iLxl8w46pcm+J9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145

On Wed, Jun 26, 2024 at 09:19:12AM +0800, Abdul Rahim, Faizal wrote:
> Added Vladimir and Husaini in CC.
> 
> On 25/6/2024 4:26 pm, Faizal Rahim wrote:
> > Following the implementation of "igc: Add TransmissionOverrun counter"
> > patch, when a taprio command is triggered by user, igc processes two
> > commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
> > commands unconditionally pass through igc_tsn_offload_apply() which
> > evaluates and triggers reset adapter. The double reset causes issues in
> > the calculation of adapter->qbv_count in igc.
> > 
> > TAPRIO_CMD_REPLACE command is expected to reset the adapter since it
> > activates qbv. It's unexpected for TAPRIO_CMD_STATS to do the same
> > because it doesn't configure any driver-specific TSN settings. So, the
> > evaluation in igc_tsn_offload_apply() isn't needed for TAPRIO_CMD_STATS.
> > 
> > To address this, commands parsing are relocated to
> > igc_tsn_enable_qbv_scheduling(). Commands that don't require an adapter
> > reset will exit after processing, thus avoiding igc_tsn_offload_apply().
> > 
> > Fixes: d3750076d464 ("igc: Add TransmissionOverrun counter")
> > Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> > ---

Thank you for the patch. The code organization is much more logical this way.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

