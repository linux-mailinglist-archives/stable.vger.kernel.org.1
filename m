Return-Path: <stable+bounces-100629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D49ECF06
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169F9167F95
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885819EED6;
	Wed, 11 Dec 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yd/RFprO"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC218A6D3;
	Wed, 11 Dec 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928755; cv=fail; b=T+0CMHdtWzkebYMrrodgxjBC1R3idgSRIUP7NZtfSwwOMZeWDzNuvtYUBWVp4E/vl1bnnGrx1ap8Oc3F8KpGzs8HUsrAab5Xb1mHA+0b9qwWwzgeySOHejiR1lyubLUMjD3+m8ISPvipVpWYiw0TkVvVj5+3Ta0YGuvJNxPbmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928755; c=relaxed/simple;
	bh=55qvlISLx8cP57VclRhFyWAnz/9q8AGhve/OCbK/ZTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzDEcTYVOfvs4IRkB29gL1k5c+r88igVTFDnPQ17ReQMOL8ueSSWd7tumXz9F+AmeBFGPU+wzQLcUL1d/EVpz3PQX0nNwkDsn79+yqxUAs2/GFayWsw4cOjj1VcwWaSBBrvGpwiNhDdD4r9+FxHLBbzbDdZobqQaLNV+qt80vqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yd/RFprO; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UErRBK6IQJ95BZu8kms6Sy+zVuLbaf0f/Z/7IxPe2K6oHEq3BDpZ96T4be15dg7eoRgsxbTiZ5DZkOJtpdOKmdb2Pe8HdBQl+xsCf3oR3TdD7W1ucV7zoyBDrwV7ENgfcUtpU/WF8nQ/KxRv4ltU58VgupMJAeT/0zNfs00G0gVdGu1Bpswe7hhH1uHf6nOk+16ZWn6kWlugvMY3GY2A5g2Q1EgacpjuihNhnlMyZMysFEAbunf1wCmDFJ+cnfrXyuk3o1GbLjCv9xsbNImeuvx2sep9EH+ZO/dGQoUmniLfhGShlSS71a2YHpOMen3Tn5g3Vw6o7f3NtepDFJ2o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ7CeY9yOQsrxKMc+w/4PGzX0R0Mviq/3ghWH2E0TM4=;
 b=g+6IXj5Suj68uINVNTzTlhtuOfgKFTrjU6QptLCxtIx4ZasLjKYNb/KNqQnn4e7xxDQkNiZfdEWigwaRTkGH/tUaldF72ea84mYL32bA/hisKrD6cqinueW0Y2b2NbR5Yu6fPK03KH/jBnLuiIAHc4uf8OodguYGdON1Ck0AJSrIS76N5xyEhJM+M3T9sMCU6cwkn+8SNNQEkuWMzDR5JDjafebow2m8VxgaXj+LwwpK8HXLAdQmUodU8u8xvKuS5OdnWe86ju8/iF5Lf3y7Yco2IZ4nUuE9DFjuGV+Da9xhrh92LVhe2gvxlh2xVh9tf6hDoMonRbkzfaTlWrfaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ7CeY9yOQsrxKMc+w/4PGzX0R0Mviq/3ghWH2E0TM4=;
 b=Yd/RFprOWqM+RXk+SPEVd8MJwNmk1JVrG5T6tN9vk+wfymTg/GhUJ8BxDq+7et/XnMbO6Is4M4lUc852+rbc60Ylu7/notmSs8cX19TkwNLflJeuVhU7zcuFrEwx7072IWR5Q58ZuiaUEF/x3VfLvAmP/r9T3/viWROTFLf1ke71mp6P5ax81M+9A7MsX16sRtgeIP9n+CHVPMZmis8y2VbwcYwqpuvChmHytiUwM0aodWknyHhhSfWLc1roqlF1mJpm32Ov0pzgxPZoD7+2Yt7sQrpRvXaEuNhm4LS+lb4D3xO1XwLfh4tEYXECwt/Gm2VNMj9jNQjVmUiXTfMN1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:52:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:52:30 +0000
Date: Wed, 11 Dec 2024 16:52:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_ocelot_8021q: fix broken reception
Message-ID: <20241211145227.k2azhkaeqxz5szmh@skbuf>
References: <20241211144741.1415758-1-robert.hodaszi@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211144741.1415758-1-robert.hodaszi@digi.com>
X-ClientProxiedBy: VI1PR09CA0133.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 066809a4-8921-4bba-371d-08dd19f36fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Za7HoCrdoMFFsSgflmMOhtxOAL2AkQwgkjRC/HmyDHmq7UX3PrHU31wxHoB6?=
 =?us-ascii?Q?5puQ3ecYmCjVy/bZRV3aaUh2etTzJCEYaPzwdTqp3VIE92YdbDmTEcL5LddL?=
 =?us-ascii?Q?M7rmXQK7HRtfgLmM/si/QXQdUsgWu2WnTniTDxmieELID5YItFLs5w8K666w?=
 =?us-ascii?Q?XwjxJlSF2tPYlYz6VSQixngTc1SxEzVVR7hiNs5+uVlsXi8JjIxgs7Hy5vLa?=
 =?us-ascii?Q?+4FoWmkHJqP5lb6LsA52lQfSekZEmOXMEat8abZevSP291w3B5Wx+kFqMAcm?=
 =?us-ascii?Q?QdN5lpMcKDsapwO6tShDrFdCDAdb5UImovlZcZahZXvnxncnMcc33zHNPPNQ?=
 =?us-ascii?Q?sphmkFEDgyNv+tnb+C7sJp5I+xrm3/JXjdZGuBhi/AYBuIxH0zzbAOuPguUk?=
 =?us-ascii?Q?yRG6U/iEdnHpUD5nbQjcI3QPcTKWM4BQRzr92uLG3OvbZJ2SOcpOAjav1Oyx?=
 =?us-ascii?Q?yvxDoylGEaomnEXAXKwHwxYbegfd2PvqXvG5G70I7wmlF6CRQf4GH3bE1FQR?=
 =?us-ascii?Q?b/yKqcGTH8E8ub2ri4mzTZoXRUMGMvw718azrtmRxycr4EZKNEgCVZMUnVAN?=
 =?us-ascii?Q?0z8YVkDHxk5lcb8/V6uHTh8V0+Vm30SD9CVp3aPxKqaxlMEmgRWHi0BIpC3w?=
 =?us-ascii?Q?NIkyL3dP0dA63Xh8xkGyMZhxqhzPEb/iaaskniV2vjrZgiIgs122+7JdHD+t?=
 =?us-ascii?Q?QEuF9tsUCiYoy3IO6GUW+RTzTyo/oV2lbZQK/6593x3lBZrwgbyX1k3Jx085?=
 =?us-ascii?Q?nf/lLcZIp0PTdW+g0mGDjK7SIEgN4g+71RanFQH5D4iD6G9+cMe24Z6XTsWm?=
 =?us-ascii?Q?ueKKb/3alnsFf6oun5GcMr0FcITZd2zquFloFAqsV/xfNwRo83YQOMXo/tEJ?=
 =?us-ascii?Q?JvsHuMtzeZtaYlG0HrVi3elH77kJED/Lth9xwyS28ulFYUTJc+i4h6OW0AWd?=
 =?us-ascii?Q?MlxY0BtEoE4aXRZje8P1frG2Lj3zZYN8GsVAzDf2GV+px1BdpBvx8H+cEYk/?=
 =?us-ascii?Q?1jITtDOn843cdPs0JNrr3GhEPIAMxA2P2hmJhHwrNJQF31H4Y8SeLkeed+oK?=
 =?us-ascii?Q?zpG+2Jri2bmEyDZMj7lkibUBi+0ZCMMI4grH0z7GvzUmIZ90iPceoEx9VRL9?=
 =?us-ascii?Q?T0yDJu2pYM1s08q0T1bHMUFfNjyDnGHNCjupKiKTvl6Dp/7e45a6LVdUxBvq?=
 =?us-ascii?Q?SJJEAco40DJ6bD7dWHEmldwjxrAJM+LRP/rZkraJIe4VdnIXfwwqnjSTtZFE?=
 =?us-ascii?Q?3wrVQXTd8avq+3ispkhrdaNwNNWDrzXL5+ymrWYM0xbzwPnqXSUgYnrsMF9Y?=
 =?us-ascii?Q?A1Fjeb29Fuw/32xmyzhXl3l0FxHhnP6FG30XIO3pCGnPdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mSQDLO3y+kJ3gduyB15d7WmSY6+MIwYFlsCCe+AQcsNnkO6O8THrkNzh3F1?=
 =?us-ascii?Q?1KKW7huxIbveLImeCCge1Ask/sV6WOkprnM2Bjp3FXbO/TSfB3uJ64MbvZ5c?=
 =?us-ascii?Q?M8Fe11NROvS1Z1qxKkOvCEBfbmOQhWdci00gzA4ECvU2WRqAgpBsJuZPEOSj?=
 =?us-ascii?Q?0M0rQw8sx84hN9lDExbLXUZVawv2J1fsSK2zqZ5IqvVfJVUZaW1YLXmw6wbl?=
 =?us-ascii?Q?nTSin669BS/AfBeksyKtRIB0r+21Nr8fXz8dkDCs0HNqMfUM5SYYp2/n752U?=
 =?us-ascii?Q?a7aUGJHfHzIgRvNiJV+a+CHyQvt/v8I5zprcLNjRnBeHpKiyOGKYkdeh1DmE?=
 =?us-ascii?Q?LpBF7wcAA3HFj4jd3SzN2HdLbgp/Y8nx+XcciVkBbvsG04ipXP+DWmYjsIDR?=
 =?us-ascii?Q?3sPZuAAIZl2nwM0AMeKH9QmphLkP0cdfV3rMyNqseQlU6w/6YCaQ+upNHU82?=
 =?us-ascii?Q?9mKwvZg4EHJ4jLpQTelkH/km/IdUhpTzB2smK5b9Js0b4rK+Ogt1DC6ffzT+?=
 =?us-ascii?Q?HZWZShIU0dXNMtxfhE21VAp3FJ5EfRCW7EOjfgrxz7P/eBgLuxXELD5J3Z0U?=
 =?us-ascii?Q?7VSHQhwiBDNDwm38UM8DKonnMb4lu8J7pFM6Qv/iCXHPUvT5uI1gBIJscC9e?=
 =?us-ascii?Q?LyMX+iePM2RjqaW1o9YpKolHjxgydfGHEXNeOYS1oIbn1eUKDdfbAMNOYJbc?=
 =?us-ascii?Q?yWHL7dHQjWkWdVa63miWs1puuprATIYvbcnd9AI9CoTc4Bcpjzc9KmjGlu/R?=
 =?us-ascii?Q?dtxOv0x7by6wKDMPRYaQuhw9M7TV6CP4hVWhlP5tW1kkdu9r0hJ6i9INtDA+?=
 =?us-ascii?Q?X9dpL3QtGawcXrI5WUOOboXeST8GpzHkDcxfQnfkBYwZZcShXFggddfuInBM?=
 =?us-ascii?Q?gaDYFT9SqbcNaIu6GByaefS3qvo23QWo9r/++OYn6Wjazxy2vQQXUgRaUBiX?=
 =?us-ascii?Q?c8/eCo48jnsd3A8wJ6gjyhbMz62iBOndMbeGjwMWK9RHuFHwCNBqUQULdXQ7?=
 =?us-ascii?Q?JgdZ6FhLMlW5AbhUvQnCRUOxEcDjtISScQOfSDG15MsGWrIlKMMlU2pQaOh9?=
 =?us-ascii?Q?pJp8/q+XJby90HY6WSpY3Vf+T9CmLt9kDnsWeQsZfREmketR2CXPKK768kBz?=
 =?us-ascii?Q?SHzjoQeuZ9VhQr3/s21ST32dwDnwfMNGSvCux2Jz7glJnd39YZSbH2ciT2R4?=
 =?us-ascii?Q?m/ib3KhajQMhDIJ7uH11iTY5AIdmbWZo+RnnFnNEvql6Noe/bw1yf62I+cC0?=
 =?us-ascii?Q?bKV2c7euixqiR/9LUweIDAgfwbndIlkdcTmEx3At8d0EMRYX9QLl/bgGCI1i?=
 =?us-ascii?Q?A26xYHosDuRZMIk2/R/A0V20fYYJr8ZKUk/1btg6y6YgFS+Yqu3nzweLl94R?=
 =?us-ascii?Q?ScidyWzkv+EgILkIP9pEYSKlaNbMB4iay4JhTgqEWcZYZvmsR3CrKxO2BJ6R?=
 =?us-ascii?Q?yVak4/VPDiASj/zCa3/8Llcl4l9Y7EbL/QsoqpKu8E/OWsQ/MwCz80zw09Qa?=
 =?us-ascii?Q?yP6ZVVoWBXx3GuVU29muoPqI0d/xdPetcL0L2VxVtooTSL/d6F0aRuWg2U6O?=
 =?us-ascii?Q?mKwW/wDD4BsZ+Hkq1ODTEXLz9SVhrmuYY6NWCYhvblfTTW74qqhTZpI3CU/S?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066809a4-8921-4bba-371d-08dd19f36fd4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:52:30.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kZc/IvvhlL60VZFYcrDcnf6uBWYhIPVyPa8vAfKVPP4/bw7u26m8NnArnEP1cDsaHJOnNiOMTFWIiL8HdETGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

On Wed, Dec 11, 2024 at 03:47:41PM +0100, Robert Hodaszi wrote:
> The blamed commit changed the dsa_8021q_rcv() calling convention to
> accept pre-populated source_port and switch_id arguments. If those are
> not available, as in the case of tag_ocelot_8021q, the arguments must be
> pre-initialized with -1.
> 
> Due to the bug of passing uninitialized arguments in tag_ocelot_8021q,
> dsa_8021q_rcv() does not detect that it needs to populate the
> source_port and switch_id, and this makes dsa_conduit_find_user() fail,
> which leads to packet loss on reception.
> 
> Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

