Return-Path: <stable+bounces-12365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3F83633C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894501C22ACE
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D63BB37;
	Mon, 22 Jan 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SEHtaFCY"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7023BB24;
	Mon, 22 Jan 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926571; cv=fail; b=JPcRBhCQiEp6EJB9NASndTAJ4/kOWjNM/4axDWtMvOxhwAyqxf7NH9g/N++lAhiQCHNYxxtNigCreK8WK9CtHACDlynYwKuhSJ560jJGKRppN5cy4EOJHrBoRd+RhxBCFbRD9El8WnMC+Z6XE6H+lNLkN2DrST/yUyubd7uIFxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926571; c=relaxed/simple;
	bh=vNuxATwKD2QErL/JsXg9qlD88jRApjuQU3yxML6xhPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=daqPLda5H9NqgBoxp4Jkn0omxkKobE4KwCcpGl6POWpR9CgjitUTsf9rRvR3ytbKUK6lAoGImLVqkyXAmSHX3mPM3POOXTPCridl56D1Iy6z2IIQ8lB4jo1kPsIlpNbWdnsWuaC51zLsTQpjU3G0hrCxn+M85iPNgR12KZ9bR6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SEHtaFCY; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+LMNlkmrRB3el5n1MW6a/mKuSVrQptVvN91rj0NqkXRSQ1/TZzv5HoXktLWnS56RqkhDigv+XnT06yzEx/B/BrUWC2svGGSatX7TWZE38DNRAK4loHumKdSMxOLZfy4WOOAKdFrDPZsDUuaP26An92GNijyJ06jAbRUvxmPqP2j1z9seIPrK7iYqnncLxj4fHyhJdoL1AAcxPex9GxE7JswZMeC3vSneqY7OSmUkTCbgah+Zf4JrvCrLyRkPvQytVQ6vNHnRSOlgiRjBcTCH0CCbk6/AESmMqIaugZLKC4PZoXYQAt0y6aKer0j9AEatRHjZ0PWVbDCKyAKdk3V+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNuxATwKD2QErL/JsXg9qlD88jRApjuQU3yxML6xhPI=;
 b=N3Qw2IK2MvZsv1g5hB+A4uSS106j16mXFau/oel2qWNKXRTZcWSMeoyX36OUkE7l/dqr3cgdIurr3GRrMr1Qy0+XOkgSwaarvJdRNGDD8xgKVBnXJek0c0HHH34DafnaeYtQoYiAu0pwuoGuOJMDeroV8Sjz/0KzNcJdK0jpjh5U8IJq8loWHEXVtl+6xJhklcnqhZKO+ryryps8et3weuhfXNzT1hZ9ckPrNmd3G4inznT/SuJ+MmYOe8z4pwyhIdpwxRuDvCSJMk9/XpEEhuEYevl1+diy5hRuLfnZOp/jnVUvEbItO+PSD8753kahl0a/iKiBF38S2hNreAe/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNuxATwKD2QErL/JsXg9qlD88jRApjuQU3yxML6xhPI=;
 b=SEHtaFCYrLw1tQ2D9EMACEKipF0tlvOVR7MYwBu+5ODJfl+txcPSPA8ebsEjw2gxfpn8ZHzOmM8lnnGemWpOHx8ywmy6OxnqOf3h+WdYo4gDl1z47zoU+BxCp1z2n9CCKd2RVSS+rvifYzR+V+P7sfoWkHOUkfJgOsVcQTKCVNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:29:25 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:29:25 +0000
Date: Mon, 22 Jan 2024 14:29:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <20240122122921.sxdkiu6udgxbs247@skbuf>
References: <20240120192125.1340857-1-andrew@lunn.ch>
 <20240122122457.jt6xgvbiffhmmksr@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122122457.jt6xgvbiffhmmksr@skbuf>
X-ClientProxiedBy: AS4PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::6) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a19d34-c02e-4d27-900a-08dc1b45c517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhG8YPR4/rtcLjSyuvTRVYpaeg/31CmjxYr3LIvhocgEZcTJJarHKf9L5lVDmsUDXQgnMqyPkUivEeVkz+EsslzaNf37rxAO3720qSYG99liBDahQBEvRFI4EqNVmXZYaTUOBDGEGPDRAoMLZ3dk6Boxu+JdaZr2MSMMJoPedDxnmZgPrx+yS3fo9zjF6on5h5blqB7TEqDCCJoaftb0EOmXZb9Ijw75nkEjqfkkxjOiRdWTzPXBhChUYU3DUCgkFRHCfF5lHfoLwANuCeWZjWLEQ8+xyELx2XwgQ8aaJKERfUpTSJv9Ae7PqXxfprzxG8/MbEGgCTjYSSpony+uxmnirB1drLcWlqIwUbyrnfWz6HvJMHbjDEY92whcYweSy18BM0QcLHaetOSIYC+mC4xvFOwMB2AvBx3aIwwxlkJcFCsOlRsNFSKsHgSDlwEXd24bZ8UC/Bv/rrJKD/gvZQIk6U94G95UoqszSVPwcvSm5FBPaN78QXS3Kp+6AfOboARAIEcAtrILwQRxlr7KZBzW0A7YjmoLu3EkYGpO2Oh5E42mahThAXaV/5Xj1H0s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(478600001)(6486002)(4744005)(26005)(1076003)(2906002)(33716001)(4326008)(316002)(6916009)(44832011)(6666004)(6506007)(9686003)(6512007)(8936002)(8676002)(54906003)(41300700001)(38100700002)(5660300002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPAwg3Wwtv+2Z2ezwuOMK7/GqY2/pzUuCwtJpnjNBXfLsd8py6+8AjHbI36S?=
 =?us-ascii?Q?8QYSVKKQ+YVpHHiuhyVAMFh6hCVj2Td94bfau9IqcPInd5jew2nbxS7Q+SaA?=
 =?us-ascii?Q?GRq2lwIq+rZYlp7zXBbETYy2jsW3lc4bjrhF/3gWjMKz/V7vu8uAcWumwMoN?=
 =?us-ascii?Q?8wyZ1vcI8fW0uDXr4oTE6Tx+BWdPP5TYkFWVw8ge/PfvV61uZ2GKm9TZVPFu?=
 =?us-ascii?Q?M+a7+ye1TllHfKRXNWeMMfWqm1/OxWPYPYXCsDarbxV6S8goyBmxyWXll5Qb?=
 =?us-ascii?Q?6cNlewgz1ZC3X/6MTazh37fg5bA0flzHmQVOZJgGm1ZSD09ifDE2Ht75Hwzf?=
 =?us-ascii?Q?7JVtkapljenroLzLLW1kvUxBTITamo6mITnakAODAQHgdt/hyClyxb2Sg5kV?=
 =?us-ascii?Q?feMen0fntpUpt0o4HEdJg0OJwPdtsxgiB930b7OAmoW5JCapi6+gb3g0Bmo0?=
 =?us-ascii?Q?DiTj1C6EdIi/PscOJW0CnSdwu7CD4JPLWMpIwns7TRFNIDIN1nDAD17ceyEZ?=
 =?us-ascii?Q?iHuCsiWZ/CidJ+daxK/SXIPpWhbvvsutDSoGwQRXQPLi5WozTrBcRkJ4Ecfd?=
 =?us-ascii?Q?N7pnBn6Rm5DZIvGLoCSBYLv/ErcqnlJFDTcLiOyYJLOphObcVL/7WJtz8yxO?=
 =?us-ascii?Q?VnpqJgqOqLUJJPhn4fnYykTWZg/bO2YtI/q4RuCoq49p91atUq2dyCRlCpkO?=
 =?us-ascii?Q?fL+Zdjx3E4fUr1PWoTWiVHOjmOePPbdqMzcap2GSt3YER3pEcwgRL/NSyqez?=
 =?us-ascii?Q?qiMILgP+p5KX+ancGpTfeib9W8b7s59ZMlt920LvpX/DK5MgvXrf5d7DR11p?=
 =?us-ascii?Q?i0aYIIEdTIhQP8JyU1ZtrNAxn8ex+6sQKgEmMAB0v/v08YTO2uqKxSNV0fQv?=
 =?us-ascii?Q?Db+wJBocsUYJEdy7g3JK5CVKRG2I2LF+E+Lfl4FmfKB/M9+PD/kBDnz2Mr3Q?=
 =?us-ascii?Q?mYWucsxuW0+Csq5+ozkvD/bcT0TSKC0B0k1+FtGszIVNE7EbMMW5orG083ZA?=
 =?us-ascii?Q?LcyMJHzJIlgWAHSQre0c6myntb7dHEG64UP6ztjJWr1/NeUfWfuTg9PhhBv2?=
 =?us-ascii?Q?QsWlIk5SAOlG2B8R3JdYvHp6BHsUuibZkIHpoSAqArtJt+8PH0KkIvWaGctx?=
 =?us-ascii?Q?Wan1PBJDr9/DEOIa+eUI8y8vMmuwMt8OmLVIDJSwPZnicyGkVTs1bTZ1fwdF?=
 =?us-ascii?Q?uogGheH0LXXZVZEp9aqniMxQTw4yx+LCRFYd8NDLjGPfSCGXnwnIkDfObkET?=
 =?us-ascii?Q?V6kaeIBMeIXEkEwhdIK8Y5QPureKJDbkb7lTDYQaMayxUYLUSjbs9WLLIhjq?=
 =?us-ascii?Q?O6FDNsgofrDkFTA5T/OuNxNK1CBSP2w3/OwGfxvVzmxxBSfbq2sbxaXo424l?=
 =?us-ascii?Q?WZ6FV2wf6ytE6/2jayk4Z/c9i2SUhOutKBhhquz9cFcrlAbnwiVIE5ekp5ZM?=
 =?us-ascii?Q?YX1wa8mU14ioy9XfefC5lknY8LxYo+Uhn8gauk4LjVt9lZvb/ICdp5TGK+6U?=
 =?us-ascii?Q?jryMKK2gT1N9xnr8wcpiRJ6uYG0uqJTSRrLACBpNUt3wVJvLqQdZUlEKWMW0?=
 =?us-ascii?Q?j5lnWy3lZv54hndqJVClS07qiiWGxBnt75GYch0hm6DTTYzHTGRwz4M+C2mL?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a19d34-c02e-4d27-900a-08dc1b45c517
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:29:25.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrYHOtY5iYIb0nrgRT4yE2vv+oBfz2y3PAz+++CLO5ctJup+lOFiXOd/iXtzh0VDUPjpIWIDdFwwQLXjL4dVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645

On Mon, Jan 22, 2024 at 02:24:57PM +0200, Vladimir Oltean wrote:
> > Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
> > Fixes: da099a7fb13d ("net: phy: Remove probe_capabilities")

Also: commit da099a7fb13d ("net: phy: Remove probe_capabilities") is not
a functional change, so I don't see why it should be blamed? I suppose
'git bisect' would find 1a136ca2e089 ("net: mdio: scan bus based on bus
capabilities for C22 and C45")?


