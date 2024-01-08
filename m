Return-Path: <stable+bounces-10034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C5827182
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AA31F2349D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B161E496;
	Mon,  8 Jan 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bD8nXFtj"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B346B81;
	Mon,  8 Jan 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzYHg5r2r9FBG9JAJ+m3cIBIrhX5bwBzjA0zqVQlIy4oLZflKvDCDRcEDt/t6Gy1MU/6GWZwHZVEQP1QUtJmS0j7g8g8t52XcJLIAhMlgCAABEuHVYw9LyzZVNqritijaN7+lvEIvjH9EgDFfUKwec678cuH08D3FzUCjeOgiAvLvGhhJW+Tt69W+NtthnEVLjr8bBKk/R70uTzDxoiUO56janR2ze1YlXb7Ve2DYzZ03ToUJBVHg1B8oF9VsDQCt6jw8FIdmxPE54z6fF+0iz68qJN30M/Mp4NQ7bkrnE+RAFzL4oKKuqoY6zYAzHGw2PM+vTSsdtxPzHgFgcAGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl0B91oz0NG6sKsJO57PPLzXhIrKeAFuFL83vdTZPhE=;
 b=PKCCCnb8Xcx1vd4lFjRaj8tDLWfoJPMZXC3LFqL/cCyyeSpMjtyd20ysi6cxZ7sXCD9IIMa7xoL4/Cui3gXSI2r2DUJmvMEmyBJxrNo9XRkNYI/4mhbbNjBCkQV3AQA+eTWnR+5zLw+0rEVuOtPluD7l3U3zkrKPkyeH3OOXDYIRH0lpAxEv7jkW2/t7rwpVXKad6mOJmRTGQAZX1JqcSjMcGHWqDEBvvRARjeiFD06b6Hedbm0lJRAM28Xu3zUafFbJzOwRAKaqoCos5mIn7jRil/nR05xcHr7K6Kxqu78oquleUhSA1jr6kzb9OsUvfCfo1cTkoFVtE0OcACwMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl0B91oz0NG6sKsJO57PPLzXhIrKeAFuFL83vdTZPhE=;
 b=bD8nXFtjJ++6dPseffyeFUXfSYtHObc4Ew7w5jS7Lg8lGq/Kbcje8W+cNs6grRxOipXFFj+muh5EXLMQ1Ivb1X2XNzaDYm50NW0NfhQoaB0cmdRapJaKHkuiz2fI4JbpT/OQDNVBB6o8BXbYE0iion0We9+jOJZO5hd/bQmcxVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Mon, 8 Jan
 2024 14:36:18 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 14:36:17 +0000
Date: Mon, 8 Jan 2024 16:36:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: stmmac: Prevent DSA tags from breaking C
Message-ID: <20240108143614.ldeizw33o6l7aevi@skbuf>
References: <20240108130238.j2denbdj3ifasbqi@skbuf>
 <3c2f6555-53b6-be1c-3d7b-7a6dc95b46fe@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c2f6555-53b6-be1c-3d7b-7a6dc95b46fe@bootlin.com>
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: d98479b3-ee5f-4bf8-8854-08dc10572c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WK2RC60ueJPPwNa0P3DuXqJ7QBioqkt6D0dkR7wBAqk6+C8M5SAcocVJ6w7f2nlzCd0+kEBkb5fkrkyPMFlrlCZIf9SFJJn2z8zltv6uhSiiowke62SCL03mJmR6Ya88c/XIXB/AEjuYrnABgpeM6GP5lHUx/DdkXHm2l9Kq04v7+HJYt9cbV6ERbOHwZwVVjUOgp15/FU0uZ370ECzum2zue8c1CbSYtcX2fJGf+gKc/4JcoaRog1zSduhiehKSSFloOlQWIqOUc9ZuzEmQ4n84tf33PPZlXJCziMZ7o0Bkk05Rt7B8fZUZka0GnNhAiV0wek/O16tJaWIUlTZiig8UDWWDA7Fwg2PYXCFtvUxiSLAFiZ3WGT5DZrECeL/e67SQVGi/Pixj3pcowBdsnXWs6I+mikSSAlKMZiGawbAICAYSgM2pblwPVvUltcEeR/3Yj+v7NSzCYgkODQxY4GkhRuLhVtXyiyEovxuNjbOx841fd36eoYp1DFEkqw+gcOJ/dVsY91gI/M5i8BAFj+Sy8th4HBkbOPZeKvGblGfyn+QGLviyaYa/H4UYzyKu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7416002)(41300700001)(33716001)(4326008)(1076003)(44832011)(26005)(5660300002)(38100700002)(9686003)(316002)(6512007)(6506007)(54906003)(4744005)(6666004)(66476007)(2906002)(6916009)(86362001)(83380400001)(66556008)(66946007)(8936002)(8676002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXxVqdQU3CUwmICrgaVVYlthRV4TKDe+dwSVrk3027HjG8G2Swr1o1Vhp23F?=
 =?us-ascii?Q?Qqkl96PiAzSdpPDnDdM8Gv26sXu2z0azqTGSRvBfHQ3m4fGKWNUgFFad1/g9?=
 =?us-ascii?Q?kIbVG0lUhUo2k4p9qJY49S9sNZIqsVjwaUIu99U/9PMRQSZ9LG0LNdLv4Sg1?=
 =?us-ascii?Q?DKoOwDzi5XL0lN/4z2gbiCbahpZ9CD5aWiH4IZ0hLk9Q0Oo8nOCx+RBWw1ss?=
 =?us-ascii?Q?B7BmV9aAmIiqUwtfia2N+tap3GlEvrtccLrQM5/dBrUvGhOxfrDKNsVc7Y8f?=
 =?us-ascii?Q?7GUaJPSx2o3HUwLyNugH/VF8eAedtDBn8VvryIKtV/DID1VNLDydPaalCgLx?=
 =?us-ascii?Q?c3HbEX360f5bcGoMZ7y5FLsxAczvsXuj9/Y9+EqUdy3Hfj9d2VHzlPxOF34z?=
 =?us-ascii?Q?aWSCTHDT+iHgD1VxgU2EBdZuA+HxDdWy69oRIznwaCCT7fxMm9pIbHx3BWY5?=
 =?us-ascii?Q?8/ocZQYDRkrTDrHxXcKM4xUxlZloTxuJFSV3FE5wCNBa3XmJ7oyHN95vXRVO?=
 =?us-ascii?Q?EYk49xdjzgbOLfvVXN7MzDpO48Wj8mFWw9IaBYeetanOSVoH4lywF69arKxc?=
 =?us-ascii?Q?BB9S/EdTNcqgZ47OmzATi/o9AlKHgYgmMAVsOyuoG5BgAj1VKY8SJfbFLUJl?=
 =?us-ascii?Q?eHb5gNpcUnOHXRjqUvPyUtDwIM7jP2KI+vtu63JIeu5qNbs1GIuXlMBPOvmQ?=
 =?us-ascii?Q?1Y2kGJmrep49+hvk0hKmeMzh69oRZOevgdkEUOIjdUf7eGI4+2m1EWXiaLa4?=
 =?us-ascii?Q?gWgai6e1LVxTeXtCuzJvS938srjWuDyZ9wIVeZE9MTOzauO8nO/NP+QpZoMr?=
 =?us-ascii?Q?S5VDkjeazjwnB0va7yybP2w+1Em0vrP8EigrPE8lmPzfex7QRZul1fUWp5io?=
 =?us-ascii?Q?gXKyaZbrUDKA5GZqSZNzyXm884fVtYqSeQ/SxMokIKlbFmfH1xPeKyax2OMZ?=
 =?us-ascii?Q?apVGdQXfFjY86/QAK7/IyGQIat8JnL6KVV4eFl1k4owIT9VmwTBoegQeQRZ2?=
 =?us-ascii?Q?e7oK5DqfvfUT7eE6WfAFTXhDG+T9q2QTNTGCMzHyxft2VqEr96PMSUg4nNgE?=
 =?us-ascii?Q?SZCA7SJGFc+sSAc+A0zZTx/YudLP6Qgk+++FqX6ZYvDP56MW1kHaC/zK5tFC?=
 =?us-ascii?Q?cVMu32rKyyFWUJVivaxPfg6t0X5keqF+GwEkzMy5yu0RPs+DU/L/75uZjMIo?=
 =?us-ascii?Q?JhQFRfxwulCPVXYhCn/MqhSkWXXJzOqPfFvgVRZN3pewCVoqv0w1rEvUQ95U?=
 =?us-ascii?Q?0TQh5QmZjogjm71IDcGPRr4hM+MUN1OBOPUhdLyEFVycNk9ypsOeOKPKVLyd?=
 =?us-ascii?Q?SSTrebXwuF/1l84GVKq9vMe2PTc0XuovBrhBOESeAEddp0INot50zC9sEzCj?=
 =?us-ascii?Q?obQr0QPnt0449AOzmtvS9wBluZVfI5w6hO2sGz8DHJy4N3QHDwXZ9Agt6b/X?=
 =?us-ascii?Q?TZElwohCD9xDX4O7vS3EEhdJGTwc8WN7JnqIgvdjGnmBcx7XD30VYJgFIVm/?=
 =?us-ascii?Q?ijOyPR9Afs4ernD1lKfWppXoCZCuHpV7GS50PWaOe46N3Ttl4suF+m2CimrP?=
 =?us-ascii?Q?QmDzg6OqSdZ33wmqmUrYzamZ8oG4a3YJDg3E4Nwj2PAkS+uhH0NRzUJoUEFz?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98479b3-ee5f-4bf8-8854-08dc10572c39
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:36:17.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmg4PylvcU/QUIi5iyLKJzBupQYfQpFp7WY5mGM68Q5Vf7WwAHG+/ANYadGHEWDYxn/xKxjXLOeL0cvl+2t55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

On Mon, Jan 08, 2024 at 03:23:38PM +0100, Romain Gantois wrote:
> I see, the kernel docs were indeed enlightening on this point. As a side note, 
> I've just benchmarked both the "with-inline" and "without-inline" versions. 
> First of all, objdump seems to confirm that GCC does indeed follow this pragma 
> in this particular case. Also, RX perfs are better with stmmac_has_ip_ethertype 
> inlined, but TX perfs are actually consistently worse with this function 
> inlined, which could very well be caused by cache effects.
> 
> In any case, I think it is better to remove the "inline" pragma as you said. 
> I'll do that in v4.

Are you doing any code instrumentation, or just measuring the results
and deducing what might cause them?

It might be worth looking at the perf events and seeing what function
consumes the most amount of time.

CPU_CORE=0
perf record -e cycles -C $CPU_CORE sleep 10 && perf report
perf record -e cache-misses -C $CPU_CORE sleep 10 && perf report

