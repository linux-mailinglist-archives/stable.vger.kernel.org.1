Return-Path: <stable+bounces-10013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FD826F26
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBA6283B76
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744A41202;
	Mon,  8 Jan 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WepI4H2A"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3434174D;
	Mon,  8 Jan 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecq+TfZdS3zn1ZXqoo9P7TQk9EuU5KgkgywCf790Jy7QcMsSbTa/X9gDMl2MUcs3H8mimnrW/7gjacpY8+J1rdxpIerRAB/bn9CfdT68NenOCmSZy+D1r6In9GwRgpYwzq/M2XA6UGzTthzFwfSOIFZ2oHN7OWQTTS4X3/VmHOe0N16P33cLYtsSLajn1ziH1GlxABusM5ukQx2upZOEy5tX3KXNYdn8LaSdQxiC9IahHfrx0KLJVD/5WKTFT/qnjNzJiMHduszOnpvNlRi+hXJ4Wzp++G4iQsteKFhMZgpZVaONna3y56+HwZmMKwuPEL8Pr+9o6aY0TUq9NpZzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF75R2+yAB3PeaWuYuc9piI7mmq9LrXnqIs2k6uuze8=;
 b=PrXFbozhZT5TIofOg/UCD2hA44R/9vBhjWNK/rUmamBuSUVb2oTtMGD1wdnI/xaHwYQJ/dNSiVTkMS+R8+Itlg6NYmCYxdScGCCLNB17dH1QPpGK350yvrr6JA79IWCbTb6gIgx3ZmjCvltFnqbhy/1IeExiC0CPBOj/pMRR587/FejS5/aXER+usUipf4F4rudhCmE+k/7ZYasRVCtlwEmE7tp6RX8U2XmryL6N8hLcaYzRtNp+MXJKpnuFFB020YrtWKa9cpRpYtroGCHw+4uKnx7r4+k2zAA8Q9vPL48mbUToIqifvdHSCRTurqk+DJvWbrbmNCGk9kJCk91GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF75R2+yAB3PeaWuYuc9piI7mmq9LrXnqIs2k6uuze8=;
 b=WepI4H2AVjMc6Dyv0Cb90zOsOPvfdy5chtnQA1a+HhpuTglDasu3Qc8WrgFhP/1K3zycfa+QkHE3TbVWDYN1AoAgkYoX1tLhztt5ZzwlRWlmwG5VPxXfsU3M8PXAPeBL8tl9xOh83tpS7TlMmBhASxWVFypC5euU27tOxp+aGVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:02:42 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:02:42 +0000
Date: Mon, 8 Jan 2024 15:02:38 +0200
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
Subject: Re: [PATCH net v3 1/1] net: stmmac: Prevent DSA tags from breaking
 COE
Message-ID: <20240108130238.j2denbdj3ifasbqi@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108111747.73872-2-romain.gantois@bootlin.com>
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bbfbf7-7130-4855-feae-08dc104a1969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aamzKXk4L+uX9wBVV1E093op4Tmv/GT9+9cYhOULgA71xiB/F5NfO2Wx4soLW4PV/Nbn5UzdS6QYwn6VKuD0GDZy49LRwsbIbl2lZf1mYT7B/o57txInuwGmO40x0iXcZ5qKHCowkNEW+N0wQbj6yEQkE3TD5mQoKzOw9fAUl8MJ/pxt1kSd9UfALYOODYbN+oWTnsJKEJEd9a/07NBIGot+Bm9r12RLo8+KS0Kn8GrD06Gd0HbfDZ2wujbTMaQAiKNBXClfA6n6gHvnhJZFhLyXnUCwh3DqaqjCVPwhrnuZch3POnC+9PpjfcUfzw+drTOby5vfdozntgoz42Hz5a+sXA54+3IZh/xzEoA0k+EduMypX/ctMs367n1KUbFTF/310zR/mxBuHqMepZD3tVvwjaggX1gEcdV+smITa7OCPs7OS5B4tLFUhkyrc6+f95uPOnVzGreGSr1hASybjnte+i27BNOXWoy+BduZXPmzHd9N0/cEUIowctYyeT7JA9il+O143/XU5Xu2FGFt5bRXa5h7MXkOB6Da3WepvwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6666004)(966005)(478600001)(38100700002)(83380400001)(6512007)(6506007)(9686003)(26005)(8936002)(8676002)(316002)(54906003)(7416002)(44832011)(5660300002)(2906002)(86362001)(4326008)(6916009)(66476007)(66556008)(66946007)(1076003)(41300700001)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCWDF/GjOddrEUuOsa27u4Oqvv3mH9pkcMNbU8peNLcX385DU3/X3KIg6dmJ?=
 =?us-ascii?Q?GDnxyP8WPxvoEhR8o9+pLZzcw1+fIXkpoOxe/zuQMbHEofCeW7qYy80iit30?=
 =?us-ascii?Q?8V/HPiq9GFDAdy7jfphY6RUXFrr+TeuDasDR/6g1avS/HrrRJjHKnRYZVuA1?=
 =?us-ascii?Q?2445M+fsJ9V2PGB3G/01DK3k9aVDJwbCeuSGGaDbBFxpgF2YtMSm0kFLw9zJ?=
 =?us-ascii?Q?68XgC6lgwtUe0FvtwhnztbjwD6yLSLs9c7L0wMCTd8cnc4Nw8PzEKpOAiaub?=
 =?us-ascii?Q?yaOzakcFxcwM6fNLME8jSNLRdnsSDNIYeCv8zBJ95NJ4Dn1FdyLZdc5ZeUIg?=
 =?us-ascii?Q?cA1vnv4ZCGwKIHxSgUn0Dl0uTneTbNCiv80OYU8lYrRJsD81Ux8sxw0xbb/L?=
 =?us-ascii?Q?/a4v9VLIPZ3zfQjX+y6uzKJAY7/kqIwbIbm5fcpnkcCRnrT6M4/Myt4Oxx9Z?=
 =?us-ascii?Q?FmRqtISuDyuEy17qN/MLVO2OIjK7lqMDg4lUNEZ33x8ST5ut03i2W2CUBpag?=
 =?us-ascii?Q?+q5k7xN6M2HGGmqjm4gsyx7xZOHMrUUNX9DHFJY+cEtzuZ4iPSUge2AEdBtp?=
 =?us-ascii?Q?OBqVhnSMXnzoGLCj9zZe4Gw0GPW0L3gfuUrOSgL3yb25JSEU7qZ09BoG8JtF?=
 =?us-ascii?Q?unxmBkSkDKUi5coKUxhoi0mt75D+j7ARZLt7nFnEDx15ZmXdIp2v6n82xavT?=
 =?us-ascii?Q?8qNdrf/mcROKWtlKl4J4wHfVs3hWu/dr2IlGjjWGnTKzIiqjVsPYeFfIgFHx?=
 =?us-ascii?Q?EPOB2Xc5LC7CqUEIG1gO5a5kV7TjruQREypKNdZO18zArtL3IvWTe64BGrXz?=
 =?us-ascii?Q?ciXyUvwVxL8rjIL1HEVRfqRZFlDczXNh/9V7nRtLFZzguXiUgDGzBZOrmQiY?=
 =?us-ascii?Q?3DkqD/J7Afzt+FgddMrzoSjE6GR1KcCOMsthy1dEzuwrIt2EnA9k0z737RFQ?=
 =?us-ascii?Q?EIF8AEQE1WddzetpdGcpV0Ne2di/FylHFWJkcF465RDgKuUI/rHsRuIBKIsN?=
 =?us-ascii?Q?tDb8xUUPRTzZIwTI91qQCKGqviF2rz2nRbI6tFRQiPXOX4YEvymdpUmsVfWf?=
 =?us-ascii?Q?LqXiADQ5TUeoO+wTLZWVolNR+OBJ3ffkR7WV/twrf70ubn/5a0/gIsKtSSYc?=
 =?us-ascii?Q?2/g16P6n0Pm9YfQCfv8HFhX+JE8B1iOJnXJzSGUnSbyNpk7XNxsBcn6i0Gv2?=
 =?us-ascii?Q?+JRWqSOlQSkUx+CjBlyv9GUHmto0MyovD+wy7FoseR3sgZ7au4+sVCntY6ZT?=
 =?us-ascii?Q?KV6Hj+Mo8hL2kG+32irD2T3CH0vDw+XrNskR8Lh3OaGGKb8BXe6qqHYghueJ?=
 =?us-ascii?Q?MIwdtE20CeO6jNXshEHzoTpRiMeZ7yLDY9y/UdOURxJoWnz4BDmzd8yA240F?=
 =?us-ascii?Q?uj9ZmhgqfdWReE0+8uWWDY3bV3K/E/YHxEC7zULFhqH4YRtcwwPHMMaMGMXw?=
 =?us-ascii?Q?t7Y9WPTDrggvVCmRLs6umBzNcIlvXWUu4qoe1lKj6NOi6Op6LZQoVDzzSNnu?=
 =?us-ascii?Q?ys30N1v1ggYWwcvP7Vrqsp6f3bsubN9aW7b++I9TBYENmJlL8nNDG1Gz/jE6?=
 =?us-ascii?Q?klyvR0Q6iRsJw4FTqsnu1CQMEA+fHyIGfsRQCZRAnYkk87/Z0masbdFy83Al?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bbfbf7-7130-4855-feae-08dc104a1969
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:02:42.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi4o4taw4htkv/lv6yUnbNukerHBzWWT3IJ7NQZS/tUo2+JEDZG7vo9Z/kYidKOU8ZDkNCK4vtU3dQV89lNCCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854

On Mon, Jan 08, 2024 at 12:17:45PM +0100, Romain Gantois wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
> frames are ignored by the checksum offload engine and IP header checker of
> some stmmac cores.
> 
> On RX, the stmmac driver wrongly assumes that checksums have been computed
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
> 
> Add an additional check in the stmmac TX and RX hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> IP header checks.
> 
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a9b6b383e863..6797c944a2ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4371,6 +4371,19 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +/* Check if ethertype will trigger IP
> + * header checks/COE in hardware
> + */

Nitpick: you could render this in kernel-doc format.
https://docs.kernel.org/doc-guide/kernel-doc.html

> +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)

Nitpick: in netdev it is preferred not to use the "inline" keyword at
all in C files, only "static inline" in headers, and to let the compiler
decide by itself when it is appropriate to inline the code (which it
does by itself even without the "inline" keyword). For a bit more
background why, you can view Documentation/process/4.Coding.rst, section
"Inline functions".

> +{
> +	int depth = 0;
> +	__be16 proto;
> +
> +	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb), &depth);
> +
> +	return depth <= ETH_HLEN && (proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
> +}

