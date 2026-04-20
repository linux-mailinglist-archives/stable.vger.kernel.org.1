Return-Path: <stable+bounces-238709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPyvDAPO5WlIoAEAu9opvQ
	(envelope-from <stable+bounces-238709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:56:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C1427841
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B088C30038EB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5E382F15;
	Mon, 20 Apr 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBtSvf9L"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE82EC54C;
	Mon, 20 Apr 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667913; cv=fail; b=kYcdGxTzPoi9NjHnWzLsigDKs64IYXP3UvQ9qo5/ioQ5E3h/pFOcZ1MPvk3SaRr5cgiNc1inq6R1PyRTYceqGQ5AmDl0fBRP7vCV18c/WqMO5w9YgMSO52GdfjTRfEStjGrOiuSCFIzI8iAa6r4jOE7VWKuBNcjYIFCcvvM9Ckg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667913; c=relaxed/simple;
	bh=QKGHnhOd54/eiv/oi7QFsdX7DIvVBVy6CudCjvifvog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uUEf8TqNdnGTcobjHLhyreMLMoNW5uWfMkMGPQ459qvwwyZCwNpQWpOs3G+HScrfpxUsfUkdHgfyUZwa70XFbzH91xvqfdaGDShZsIQa6vVufeeIka5CvTJd+lAARmBPT+TwS5fBFBr9IqLflxXt7QdgPtDX+Tlel2EVoShk0aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JBtSvf9L; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEVKDrFnQas/VqQTA3BTD/rXvLqFSVJ3fe2HJMeYCJ7S8m/Gv1JlOlpMIAxulGWWc1lXckOrPDCV/AlMIzfUI9LuGjt8tuZaK2cnreX3v1yaH5ITRRPGGEljcRSd0umPbDNUr9TYuRX3HzwAH4X8GFvWwlo2aQcu3yVjKwHQLkJsZk1C2pYpPlULksyE65My1weelM3qe45U3q0oZSmWfQA2M0HuKLMmcC08wlIKhVJHMgOcc5wQG3RIbVDFLp4fDqxscYjSfp0IucR39tOYsCXF/0CTGO+CDPXbAYvl+PrlIl8rh5me1fKYwhh5R/FwzO9L7TDULsNz5obQPthusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj+/dlppY5eXo7ILCRNIvyZo3wyBnizQYyMdYy/xCz0=;
 b=O9Q4x4rcB2Qu6a8u7/lN3zpOIEqfcVApRor4x+47zqqeUwxFZm/4LPeMXIYHWK1Wo2mQFeLcaypO0Z4JNiP2oEBuvsmNhmES/DhrGiqXKiUIOC7X7xzSZT0EUhe6vMsQm5wCG+ykJaycgoSROkp5EizZC65RmUY29LXAMA30iFyeOSrL1iL/zJhvccODoJJh86VmfNlSxWe4HaFf64tV7fNH4qVEmAjYTxi+kgIfNvhwhyIQ54nbg9CSJnQprJgLhFixYXFzLalubKZkC6mgwsCFY3DKKXS6VXgA4X8oeD6CRdr1zAK9jFtTEiB13RVfuQsgu5OENsm+W9EM/2/lrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj+/dlppY5eXo7ILCRNIvyZo3wyBnizQYyMdYy/xCz0=;
 b=JBtSvf9LPIzF4Hvd0W8/3yjqBO1CyX35pBbO36EJQ0reJfhPQeLtF57x6KTRsRWNf9g6LOmgBKtZXoP6wuitBe44R92B+gijk76zO2EeCPen9c3gm6eHcX7yngO3S0HqSmNpi4GlBz2mNBd0UgentdM7sbk/o+LuHp7e6ETKf9QaEZI2wn5QFbihYosf8T2H4nihaH+44UPkUlKIw7fjBm2CiZsgFlIm47atMvZWkrCifBmZMujLojQdxXicShp3fn3F/DXzTygMF7E5Boi8sF7wMogLkpvsv6lELYwdiefxcgapzosn4eLRnThjOVH6xiSqaRQjN3UZXhuv2AU3BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 by GVXPR04MB12016.eurprd04.prod.outlook.com (2603:10a6:150:335::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 06:51:46 +0000
Received: from AM8PR04MB7940.eurprd04.prod.outlook.com
 ([fe80::1fa8:cc0b:b501:6bc4]) by AM8PR04MB7940.eurprd04.prod.outlook.com
 ([fe80::1fa8:cc0b:b501:6bc4%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:51:45 +0000
Message-ID: <890be73b-f692-409d-84a9-a2ea68705be7@nxp.com>
Date: Mon, 20 Apr 2026 14:53:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on
 ERR_PTR()
To: Guangshuo Li <lgs201920130244@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260419122134.97529-1-lgs201920130244@gmail.com>
 <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
 <CANUHTR8FaXLX+Nbeb7+sWRF9jQ5SoBgWc2y_LVD38KE7TqsxeQ@mail.gmail.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <CANUHTR8FaXLX+Nbeb7+sWRF9jQ5SoBgWc2y_LVD38KE7TqsxeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0202.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::8) To AM8PR04MB7940.eurprd04.prod.outlook.com
 (2603:10a6:20b:240::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7940:EE_|GVXPR04MB12016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad7edcd-6bc0-4b72-5f8b-08de9ea94975
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 zmV1ZKhubt2gOsyR1GSbK0coZQqIw4XJLeY58KLbsBVMlkcqJRzPQFB42zrT9eeUWzdee6MEMc7UIgEqLfkuhCXUaitdOx+cqqMiPnpHOQBJ0Cu522IJ/fYEhE8Czy27nvVd/ypP3JkuUjR2fZ9PsdjZ8MB4dG6KXl33P0BLCeWewIsn5Lh9wIy6KnFEGjCMwWrziUTt7pR7ybPcmdZ/VPnFVkxE0iV3BRMu1EwL12KrHvr9MXtwwP7ROrrVUE4GAHQbcT+VIljNWUGmBIoEKYf8lzQieyGaO8aBnvnJ0XL2h2BysdgJ16gKUsx/GoNcDIYXEiG+DA08YI6FcW2E84xI/ZdrtHdr7NGU9/CU1QbZPHv7G5v3zcPAPgrbSnnZ+xIvQrJU5EmO+rOYBRKQjPE8Hfu+zks1cEYnTbDlTrtF48RiqN+gRZ0MPyxsusonvu0VUjqkFy828PdoD7LK2uHPTFGXFVNgB0X3uL4WRzfbzXz3zgZHyIBBAWojfOaBAZiHhtOPA5Z3PSmlZliVR22MYOlUypEaVYAwAeqz6N9t6kHCFncZMhJ9Udt6OUc2KHwk1PoLwSf4YSpIWl701m4l8mrqXVL0B4G6kwpRZ8K8aCPiAoX/FRFnMgD8j+Xnw6wCvEW96RAgc5qkvENV1rc6SN15KbpmTb/2IiNfe/HTaFhxx4ixk1dqweE/zp0G
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7940.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RXJXQWNvWmFkSVJvSU5jWkpuZkRJTXNyU2FPWW5mWlU2YnVabG80Z01vSSt6?=
 =?utf-8?B?UUxyMUl5cGZoYWJUZnFZVndCSnRaTUJzRTk2UlRSYVF6Q29PbEdYYXk4YVp3?=
 =?utf-8?B?UEY2MjJud1U4eFc2MmNXMmNMOFZBTGtJL3hXMFd3eVhpZXVveFhlK2pIc281?=
 =?utf-8?B?U1BLSmY1VmE2SFBXWkU3VUJuWWxRQ0hvR0V5YWpMbHg5QUlxVDV5SEZEU0I1?=
 =?utf-8?B?aUFWYXZ1Mlg3eERTS1ZJakVOb01TbDhRajFJMWtES1NrT3Q2OXVvbnVCaVVB?=
 =?utf-8?B?NFg5K0Z0ZmJ6UFFhMjRFTzhyem41UDNqckI2TkxRVHVsRGplMGxYdzdxaCs2?=
 =?utf-8?B?c2NTU0NVUDB2WTdnSDdnNzg2VW1yK3Roc09kNVErUGRnU3NLcHdhMXBZWFNy?=
 =?utf-8?B?Q2RhZjlzSE04c2JjQ1FHT2VZbmFHalVsT0tOQlFiSnlzdkVnSkZkK1MvVzdY?=
 =?utf-8?B?UEIrMUFyemVaZWEzbzhvR0laNlpwSFowdGRMRk5XU1NicWtGMnVPSmN0QTI4?=
 =?utf-8?B?NndEREZ4MDBjeEtDSG94cnZjUkg3WG54eTRpYjJqU2d1RTh6QWJsb3pISkNp?=
 =?utf-8?B?dzdNQzFsNmNJSGdEcThpV0wrY2VlcjRRSml6NXZPbVFJTEhyZmNqb2FVTy9x?=
 =?utf-8?B?TW1pY1ZnNWVwTU0zVXdNNlE3UTdrbUFhcXhGU0tGTDJ1ZGRFMnAvWWFiWkpT?=
 =?utf-8?B?bFBlYlcweXFNS2x2QlRRYnU1VDRTQVJHbXIrWE42Nlh3dUVUVHA4clFMQVhH?=
 =?utf-8?B?U09sSDdzZ29QZStrdDF1ZHZEeVF4STlCZVczWGhOOUZZYm9FdVJCZTFrUDF6?=
 =?utf-8?B?dkZPcWlnUlJhaGZBRHg4dDltK2JXU2JFdlExSHVCbmhJenFRQTBwWU9vRFRK?=
 =?utf-8?B?Z2JvM1pWTGVON0RWRitIZEpYNzA2L20rYUQxV2t5ZERUbW15OHlVVE9majBR?=
 =?utf-8?B?NDFGVlN3ZktPZjZLYXppdGhmT1p1UFltYmJoMFZPb3ZiU1NKdTFIL1FCSjNj?=
 =?utf-8?B?SzBEaHJ6eEdnVW5tWDJSMlNDTnludlhlQ1A3ZmIrZUg5NEJRSlB0UG9QVFh3?=
 =?utf-8?B?Sk1qSHViWU4vbjZBVGR2dkR1Z3NRdVhWYWRjSDNUMEk4bWVVWjdFWm0wdi9E?=
 =?utf-8?B?MjB6dXozVHQ4ZVN2MHRyZ1FTVmw2RGF1eFoxdmNrelNBSkg5YVMrYnA0VXlw?=
 =?utf-8?B?eW1ZOHRyM2NTakpzbFZCaVRPNjBxVVZjd3M0a0Z2V3pkTm1KMkNlYkdRU2lF?=
 =?utf-8?B?SHh2TkFuY3VTYk16Y3lIN3JMUCtNb21LeVhvNTB5TGg2SlFDTzRkL1ArWEs5?=
 =?utf-8?B?WDlEdnZCZ0hXbzMzd2hSSUpmQXpnZHl3VmJqdFozZDRReEJTWVNmb1FDWkVh?=
 =?utf-8?B?WU5yNnVBUmowdE9CckJpMmRwZnFYejdoZVZ1WUdqREQ5amVhYUZmOU9Cb2tr?=
 =?utf-8?B?K3cwTTlVQjl5TExKNVA1cnZ1QW0zOU5KLzd5Ujd6V0F5Vy9Ld21hUmI2OFJq?=
 =?utf-8?B?Qkd0REpvOEZWTDE5ZmFOOW53ZS9uL3BPeHMvbUVTWk03eHVhQ3Y1QkZFMEJs?=
 =?utf-8?B?RGoxRTRiMU5vMTlDOHhHUlRkNFVBVHZmY3lLRUh0SGJ0S3FlV2NEb0JXV1Zj?=
 =?utf-8?B?azYrandTbjVaMGxrYkRyeUN5b3oxSU96aGtXREh5M2M1OHQ5WXRNWmcwK2FI?=
 =?utf-8?B?ZEorRmdBc0NjdEw0ZDhjcU05b1FaMkx3Qlk3c2QyS2RJOVZFc1c3cURMUjhH?=
 =?utf-8?B?RENqdkMwN1hnUFIwQ0pBamxHdEl4d3haU2xLdVNLNmNpYWxHeEdZSFdzWEk0?=
 =?utf-8?B?NnRDSEtFNmtuZXZTbmRuNzhwYzFoUHZ4Ly9ERk1JVm9XMC9IRFc3Z3JNZjZm?=
 =?utf-8?B?TFZGYytMWXlUcndTcXF1UWY3bkptYkZoNnZnQm9YMHdzOFJnK3o2RGd4eXZv?=
 =?utf-8?B?NjFNS1JxOG9oSDJiQkgzSzJXbzkrbWtreUc3RklVeWZ3YjZhOUw5RUtRZVp6?=
 =?utf-8?B?emdhejRiM1l6U29GS0k5MDFGRHRUZGVEclcxaDRwNUNReldwQlM0bGlkMHdi?=
 =?utf-8?B?cGdvVURncFluR09XY0tTU05wcVBQMjdGU2duZWVPZGRRUllDUVZuY2NXQkRy?=
 =?utf-8?B?MTlzRG5ONTJjVmkvaXlYR0RzQ3BLUnlhWWJBU2ZwQURtWmlCMXlLb2E2ZW56?=
 =?utf-8?B?SXY1aW05MFN5b3d3OUJkUmVUZmlLYUg2eDBheGhZN1lWU0lJQ1F5aGdrVGdZ?=
 =?utf-8?B?dXIwbnIwTzVzWkJyb3ltREs2bVExZ1F0bnlHWlc2KzlGMkhlN3ZFYmRJZEtv?=
 =?utf-8?B?Mk1RVDFCWDVmQm1pT1Nmd2U1Sjd5d3AzYXpiR3ptSnZieU53a1A2QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad7edcd-6bc0-4b72-5f8b-08de9ea94975
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7940.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:51:45.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU5myGKXROVpiAtnRC9w+e9N6wh+2sic8UtzqHXHQtPDyJl/TD3y+2I1tqkKknQNgaau6XBTBo94aQa+BcZ6PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12016
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238709-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor.liu@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:url,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 897C1427841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:19:35AM +0800, Guangshuo Li wrote:
> [You don't often get email from lgs201920130244@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Frank,
> 
> Thanks for the review.
> 
> On Mon, 20 Apr 2026 at 09:56, Frank Li <Frank.li@nxp.com> wrote:
>>
>>
>> Please fix
>> DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
>>
>> If (!IS_ERR(_T))
>>
> 
> You're right, fixing DEFINE_FREE(device_node, ...) is the proper way
> to handle this:
> if (_T && !IS_ERR(_T)) of_node_put(_T)

This would be intrusive because it effectively changes the cleanup action.
A similar case[1] was handled by ensuring only NULL pointer was returned
on error.  And, this is actually what i2c_of_probe_get_i2c_node()[2] does
now.

[1] https://lore.kernel.org/all/Zw-VkQ3di5nFHiXB@smile.fi.intel.com/
[2] https://elixir.bootlin.com/linux/v7.0/source/drivers/i2c/i2c-core-of-prober.c#L38-L58

BTW, even if the cleanup action needs to be changed, the 'if' condition
should be '!IS_ERR_OR_NULL(_T)'.

> 
> This is a better fix than handling it only in this driver.
> 
> I'll rework the patch based on your suggestion and send v2 later.
> 
> Thanks,
> Guangshuo

-- 
Regards,
Liu Ying

