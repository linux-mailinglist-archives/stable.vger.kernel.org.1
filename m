Return-Path: <stable+bounces-163267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5BB08E11
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 15:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BB0A65462
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381862E543C;
	Thu, 17 Jul 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mdrv4ggU"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131E2E5407;
	Thu, 17 Jul 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758610; cv=fail; b=VKsCg0aD8UUj3If7CCfrapP5OBJm78GQH2ERdkIg3njZZVjC029U3ADMNKZS3LfO7v8Q+4TPOByOrg1uGQQLWvDEET0Q+8NjVE2UfjfOwSmCamwRgvRrIUtAFt0yQo+FCZ8rzILSfIjLcMsAFCDWSHSBoS0rVdFmTZvtC7nzPE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758610; c=relaxed/simple;
	bh=DcymvbiQ6/Y7T1cadVICAcX5TGBHxa8gX1qZUd18G2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCs7hM3jMDykVqazl4SaGb5sKHco3PwiajYKuIwaCsb8dAVrEMEhlkkvbiw0g8ePSsQyOCV48Asa3JqR98Xt6DgUXIT4NnuTiD0Jp1v0hRayoUmJRByTQzyPL4TsVhY53xrshFxiUnH3PcZi/72AO09YpmNnv/kq31cFdvdOlGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mdrv4ggU; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5VaHNshudDqdJw+SHD1XdeOc5Q2muR0p6sGpHifBMdSAZ6LUdT9twAmO7CMIQ0b1ftm2NqQ3yhcXFXGzrmaNsE3NvHnVXIF8N59ormUFDJ8a8I1eb+PAjlAaLJHflriU8rf5X6Z4MWHli4cG1k9fRWQx4fVymBcBfroZigi73UAN0LPfMCKidL2Lw5yzSkn+U0yjTXqTbayZAagT8xJ4F8gglIcnStwDPmQYSguaS1ZGnf1O19pmCXlyXL0AgmmpdmOQruU+OU7B6bdSyzuTU1EIgWvqoh89+3LUikFtKJh28PM2uMw5uDtzyBTD8eir5Xu7tELXEPJRvDZmNld8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/pqXzsCI714BXQBWw5vrBs+fWU7ulSpgbBIpGIoRoU=;
 b=peHsO+Un82IqA8JoGV8q4qh2YNvEsBUZm9eSfngiRCBVN2q7uJXX/5RPorLYUE7pXVuJK2CBUClX3On13qjEGUMP4YtEuMWlxGKq983VuInT7A8oPo9eDYEISuo+qpnWwJsEXvtua/HH/3NepiVBiEswY58RzTPaCIpo1FWIq3MPgsIlcGQ/viuCrGiXd5RQtXFD2Xc6RVxtdtdHlKBo5Oku5IhsmuS8wpLi0Ozo8kg44M+WUQyII819x/XKD8UKMZLtOpcZSqMQ0DFdsC23peJasnQ2r3W7DgMX0MJpPdbf4rc6gbzMtooNET9CjyHcczah4HhrLiEY9W+e/loUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/pqXzsCI714BXQBWw5vrBs+fWU7ulSpgbBIpGIoRoU=;
 b=Mdrv4ggUxnfgxOA7tURDXwqAyX4QZCojPleclmIOCCK2Sd0iLWiqCJCEvvTBu+Z8qkqsM1Ptj6JvSHgZ8wtnKa7IoKPra5v8YeHqwlDlo1/E9wQCfx+PA4G4MDznQMLcm0dEOJxII5Y/jfLeUJro2xLTuMa9dlsmaM+iIQ7DGfWu+NJo7qYvlr+enlDKVbz0XeJhdbA0x5ZBZHxdbHcHEggz4JxAi/dWf/rzhfkzwKxtX/LSqWfBES/zQYDJgG8lBwWa2NT2rzdoRgnW7MDQxktsYwWjKjX6NWQrh9ls2Swo+6GNc6ZIrNenhQaCQPL7oB1PSVkhpZUTRIabtuFerg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PAXPR04MB9677.eurprd04.prod.outlook.com (2603:10a6:102:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 13:23:24 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8880.030; Thu, 17 Jul 2025
 13:23:24 +0000
Date: Thu, 17 Jul 2025 16:23:20 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] dpaa2-switch: Fix device reference count leak
 in MAC endpoint handling
Message-ID: <4oylx2qkf3aagntqhmmmse74l3hjolylf3hgjym7l6motnbmlp@mpjsoobpec25>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
 <20250717022309.3339976-3-make24@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-3-make24@iscas.ac.cn>
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PAXPR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: a48cdcc5-00a0-4575-b67b-08ddc5351b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aGZy2h7ZHNsz8P2tGK6AqQMcTvajmtOHOyQdDYUcfuRAty/UF1G6o6m8PULk?=
 =?us-ascii?Q?Plzvt1wnVn24EdrfMSeM5yWcVZuIJJWpd7rWCyV6C1h71S6Sc/OEeVDdzOEG?=
 =?us-ascii?Q?s7ZBE58WUCT6whSudP22+8SgMl1pe0rlCWZRl7lWUkQq5QEcNaTvreSm4z1a?=
 =?us-ascii?Q?GoCwGOqMBZFRSXS6vezHwmeZSNqWnrZ5+8mXiv1LXcvI5iOXdukLLcI3OrNt?=
 =?us-ascii?Q?lsxMy2vIKUrqqU2tDZkvi+VSOJ/XAtRW9EeuDkKbsZAQv/msjGN5FaPBofCq?=
 =?us-ascii?Q?UHNL3UnTYjfICcZGFjM8JdNNwL64zIFveDDm+/y6uI6lsrHw9mALuJOtEohK?=
 =?us-ascii?Q?J47T8EN3Qs/lpiYkmaBcyfRVxKIDKuw+gx0+FWx76huvSJDIzlnRx6Us93aW?=
 =?us-ascii?Q?ih5nXPUt1MiO4F0BYcB3CkuhSXOQKsoS5NozHiVAGVw1/Uy1697/aWsonbpf?=
 =?us-ascii?Q?1i7HYyUW0ha2SHDpAxuFwSrah+C5ibxUmO7wEHrAFiqBQe3GRZTLDQodhHMj?=
 =?us-ascii?Q?pY6Re4jBbV+MMAYTqYnL6ZI07KhEQA17k06UF22w84LKnKsdNCrgFpcAwDxJ?=
 =?us-ascii?Q?JBVR8Ak8oS5MJVz6aMUOO/6XRjFhaJOymdnGDEip1ZcaguJ45eKHZNYXTEER?=
 =?us-ascii?Q?YYM6xo5xJaFw00gbZVbamt5+MUEYivOTQ+SYxYRTwazUbRWNzMiK0d72LxFj?=
 =?us-ascii?Q?Pm3Joo0xH9Hq7LEB0nuAzNWqYey7+f7cADGmXD9JgyZ5kxEHL1xUrF4Bzz9d?=
 =?us-ascii?Q?q0m+rAn/0WHvoWgJH5BemJnB151dzzggybzsNcC19aBYcBmlo8rz3xjqVflT?=
 =?us-ascii?Q?jlFWGmtX7R5dYPYGOUp56mBLjNLvEK1Gutco4LF0IitxNKoHiK9dijBy00A2?=
 =?us-ascii?Q?iNLz7LZC6mHPMhTHbxRjBsVtL0i+3pDkYV4K1mGAPB9ejmd6NnSxBSNwxuRj?=
 =?us-ascii?Q?il/YWnspnOjfSdl/01S8r6GUwKz5Fl243t5cFIuF3jmqbS8sy7k0y5aPoovG?=
 =?us-ascii?Q?iGk19kWvkee+dNebHFAhRIoDIOFOsQKXoTVx63zQHaE0OwMr+ehmnw202uFk?=
 =?us-ascii?Q?NqxSKU/5pyFDAD2gU+YB+IuJzeBpMX9yPbneWkq/kbahluJFm6JmmbL7VKMk?=
 =?us-ascii?Q?9ec4G6UYblMmVtaEwVggO/Cbug6kmG5rTfLWWU3+HX5JL89wu1AZ3Twb2U0C?=
 =?us-ascii?Q?S3XvjWstbNKghbRsfeaW4fM/m8ytNBCb5xu/ujdTIkNH7snscelJT3j6MiaS?=
 =?us-ascii?Q?mg1LkPDIpQE7AqBHXXba0b1sakxF/vWskWewK0ughwMWRUIvuyLewDx81K59?=
 =?us-ascii?Q?XEG7/GChbnwQeLgppItcSXfK2YatAeGAUtfnet1GmlVqDRJjoEGEL/ENicoj?=
 =?us-ascii?Q?ACO9ZtTr0ofNFnWRbiDfpzw3NWSqNgasUGawp1ZMQYGNW7+CyCmg850tJRdc?=
 =?us-ascii?Q?AcQScRb7GiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ijj3cYmNtHCM+iIaggEWm78pWIGytm+BglaXuMG0xKoqS0eqdoKpyhYy+3hm?=
 =?us-ascii?Q?n1YR2UPGHQxquQfwN8cQQr+a/FaFyrZ2jIYKo37vqIoRfCgkg0bf4QKyJ6Tj?=
 =?us-ascii?Q?IE38zwCpYK22Y1HuXjzF166M3nbThuDJ0dPiMWR2202jGOCUuWNsokqHukTd?=
 =?us-ascii?Q?Xbz/I4AytLfN7yfJS4TbCK7OFHIRevvna5TTkNXzIVaGGNVAZO+Vr9piVh9V?=
 =?us-ascii?Q?yjt/SXgX+d1WM96r7PW+Ttp71Bsmd3l7Y3mm2rtyXEpsjelB4btHpyLFGA99?=
 =?us-ascii?Q?9RbzfNdKu9GMkSy7ncPqRY0elIAxnN4cz1lNjN8AkCqOEnvhD7TST1QRAxd4?=
 =?us-ascii?Q?FKxO8dKYNtp0yzHW5yyZwFt7RIQyHVoV/LoSZkPq/SdwSFS7paTuOw8JsFF2?=
 =?us-ascii?Q?8VX9oLhTKnyz2YLKkMe+PWwKdisOHpAK7V6/U4qCX/W4hNPOBK7BO8jOFIpS?=
 =?us-ascii?Q?O3yzkbJlAxuNZwId1CVo6U9zJ/9l/cOTHZlsZuUWzKXzhxBOrjnapoa5dR+Y?=
 =?us-ascii?Q?HwumkXc65iIORQ4gbzz6bq4VMgDdb3eGsLdLEEjL6syT7Wnddd/I+kqBqRIB?=
 =?us-ascii?Q?pC056SDCZ6vE4ApbqFh17s29ihq2DHjwfG8u9/gwW3PAVwj9p+m9mYK00nzA?=
 =?us-ascii?Q?4MI2CZzY932oH5/yhlww6kyd1KKk2a9dWdh5zwH8LzbYRSHaDgZ8MXxWRLAI?=
 =?us-ascii?Q?HUqpUkwa4IxO9Bh7/eKiXZ0WdqyEacA60NaS+gGwWMdwXerByQE9Lh/8RBIK?=
 =?us-ascii?Q?1MuAmwo4In9y4Oi6wvPdUT5so7Wp1Hf3fE98YgAK5TpUy6vwcPZdAFHgBdCN?=
 =?us-ascii?Q?LdvmI97aBaaMpOkdSkjh2NBUUHInNbkhNFiHZqMu6aWFzXJhWd2EKz8la7XW?=
 =?us-ascii?Q?sEwysoTSTKKB1tUB8ufGvKzYc3nL3luTvkaTJpfPJOQUPgSV6Wd6Mjh0Z0K4?=
 =?us-ascii?Q?lsZCh63pV/sa3CnBUmu8pNKRmRKT9c2r0CZoBLmNSZAWfNiN9ujqmul8yFZV?=
 =?us-ascii?Q?Ztl0Uq7hXbUQVWBZ6mlvABZ2DC6Ejo6vKWINAPhShMIuTxKy6smZ3tmj+Ckc?=
 =?us-ascii?Q?16gFDeZahYTc/PIn7USGKRZrz/M8+WQDMUUusI3wQvdKfyIdxe2WAerzDTq2?=
 =?us-ascii?Q?c1p5PgSk8HFCfXK60hmOsgkE+UxFqOmua1vjl2XGEuplFzNs0ti9P2Ja/d9E?=
 =?us-ascii?Q?4l6N/oJWuInEii4Ou396PaCeVha/IcbginJCzieAcXEcMk3F+FSY05oL+XZj?=
 =?us-ascii?Q?QKVL1tr8/Ihg2cQQlaizMhJCblXeMHsCBEd0DEVPmpIwtgxCml62QUGp0OCd?=
 =?us-ascii?Q?uQwJK24Gjornu/JLyWJQkFn/OycT+XE6M3Cd+W+eVYUxFGbPUBgsu0qIZPCu?=
 =?us-ascii?Q?/ZBzLYBYe1BtfN8P0fral8OJvOmkAyQOHtQLWRT7cfdr7cmx64NEWzgRJpJK?=
 =?us-ascii?Q?ysgQjQ7TjVRB+BIsgJbUGnAaXPhFOEbqqv0wmcUvQqXCDBDKMOdM9v40cdNZ?=
 =?us-ascii?Q?YgYlasl6QNInlvp5yh2bR732XNdb7sZh9zGLfrxn8dqtwW3Hnh3n6aksiMFk?=
 =?us-ascii?Q?ZGckKjLEzrBrAZO04Fy+aCe32b2KyHjIqXKx3ncR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48cdcc5-00a0-4575-b67b-08ddc5351b3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:23:24.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyDx8Zx4sMBbmxztx2TiNxY74j2/H9LBFCxNuVdMgrvoXd+9KQ+ua9JTjSGY6+4rvWo2pGBfmyLtZvSuwn6I9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9677

On Thu, Jul 17, 2025 at 10:23:09AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function uses device_find_child() for
> localization, which implicitly calls get_device() to increment the
> device's reference count before returning the pointer. However, the
> caller dpaa2_switch_port_connect_mac() fails to properly release this 
> reference in multiple scenarios. We should call put_device() to 
> decrement reference count properly.
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


