Return-Path: <stable+bounces-12366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF98363F7
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A14FB2BB6A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83A3B194;
	Mon, 22 Jan 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d2gTw+UV"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE243CF47;
	Mon, 22 Jan 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927931; cv=fail; b=PdN7+ElcRZwEM2mVMrhZmqWGeBXnD8VKXB5e37I87LfsshKSOQ3nk8gzMKRQ5Dsm8DGImX8hXN5mqvnwJTwpNBPxcjDJ87RAsfPrsNGCAD/SZdEasLm7IEtekN8yFLxUgL9l7O70yKd0kuBzWqKFxnAGAHbSXjaDyOPpLp9dmfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927931; c=relaxed/simple;
	bh=25YBNE2+bQQIz4RIhV7oEI1ZeeHNBsgEwurRgdG94HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9m6zO7PQrFdy8vSBHhG9LQKG2Jr5Sa7UqOc7/ZzNpLQfvMeVK11T9EkpnvsqL93WKkp5EBM9R+/KHZMfoNlt2vXYlJrngIDq1XuC9zfgXGXqAp/GYVMiJcqJ9pM7NE64vwUQHo6lZhDBOXygxm/CTekPRFw6wV7ns7328XU0wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d2gTw+UV; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/nZRyYKUHB6NZ/HL4SsKFaWspnHGUp/Qmm+iz7PveXucFDj0px3sDN75DmZF/gPXCSepOxzXxvEoTX/+SBtQmhHlafWSCPmVCiWAp34CDZAV6bb+OzHEcaAt+MiR1vmSQnTf0UEk59LtuKid1dnCKWb3zDhn12t8X5oJbr9hYc9yBpNo1EI3O8bPK5zdK+xCCc1PgeMwPpVExY3Hn9rju/clMfJpHvtyp3Z6bz6sp+uZ8EoYZMJ0+TlUf4kN6RwvnaNtCTABNAedezXIF9dY91WR2p29jhKFz2QK1epNEhVUi9FR8UujZK5QXW8b895Xv1lsk0e3hieLal4QaSfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hhif/0fywYnCKMPv0lD4rqH5sz1FKfDzrey6gmxskg=;
 b=mL1fRbN3+9cdyD7EmufWE9wTqKEXlCHk311bwWarkp4XQHtWISkPiCO3HUc8EG1mAqOnqRYp2FORFikrme4rkKy2Uq+XtZqWM8BFzwKWxs5elWOE+F6ooBzJ3e+bqyv32G3xJXQ70sAqOMtEI+6L7KkyWjllENJBypwxbkSQsynKVlUv0BcAewe+MnO5SU7Rwn01qlTj81u1sUdZZPhyyfFsvGVpw7l6eEpTTDeCK8l3kyLgxkfZc6uGwgVOF96juJFKd341noJ0cCP6nlUL+cF1qNCjfFiZ1HLpZvp9T1ap10oh0W5YSBficYJm6YtoiMxIRu3M+RtwTYg2tCaDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hhif/0fywYnCKMPv0lD4rqH5sz1FKfDzrey6gmxskg=;
 b=d2gTw+UVDUER2KO4tiQy54SXq/WXRHcIvzy0sdbPsFZG11AqQBPR0X0HSuC/zTd+OuvM8PBQyfI/sFbK4LNga8doBONLxRUPfs/NfZ4F4vyodadIkWl6qcTLl5Xz9wxqgTg5W9Wjz2mF8gAYVBjzjZ9WcWrIbv3kBA0YQuUb2tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:52:06 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:52:05 +0000
Date: Mon, 22 Jan 2024 14:52:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <20240122125202.yfyxz2flwpum3v22@skbuf>
References: <20240120192125.1340857-1-andrew@lunn.ch>
 <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <20240122122921.sxdkiu6udgxbs247@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122122921.sxdkiu6udgxbs247@skbuf>
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: eb79bc21-3aea-4867-a8c5-08dc1b48eff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fRB9CCGLcU+ueB36AQUW3e1CPbvnmMx71DiOoPYB7R0lm9qfOzWHoK5sint108K7avLVjNbbX4OhLt11vPvhpKixjQzADHgKkvaN1b6Up7qFMtn6i/tA7n7L+PIrQLHVlnzy7CNWuBo+sv9Dqc/FXLxC49odKIBxzSaa7XDxmjGZxAMaS+w+FxLJx52LTqswhfSF/6uwUdW/GqzMHb/8DOW/KcJNZ+BLYlFiGVSCi6/aL3pr0AoY+HW3ieqpe+11itgmwnF8K31mA4aq/9EgEppltbE4zHNZwoe/BhquOREqe8dL5v4HmdeQ2q1MjWsEsjtlDhZKTAXRf6J/ptcjN0jIgmTkVXhZ6bqeq3LX0Ty+HCQ6ziAEghPSKVtCQaM5XejcTJYxa/w1C5UlhgMvYGzT9odIhxZOV2IVs9mcPrid29QL7FYPo3aWImhQyrKKYIZcs92wmn6KaeVxHkjVi012pX7Arej7NC0WRwsEI9B97nRZnr817o4TUU1HRGSNyqUCbaJXtBP2tHQKZMT0PIjr6BqqOhrELxIXlpIUEbjWV5Dc7BcRqpKWOf2z2Eua
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(9686003)(1076003)(6506007)(26005)(6666004)(86362001)(38100700002)(41300700001)(8936002)(33716001)(8676002)(44832011)(4326008)(6486002)(2906002)(5660300002)(4744005)(83380400001)(316002)(6916009)(66476007)(478600001)(66556008)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTHcQyTOVSj5a17Ss7pAt+39WUlowaiEs+n9DvlPfoLKWlXCIrhSDCtSdjFn?=
 =?us-ascii?Q?llhCjnLHmiWuugazx64lxU6zEdVUsCx8Q35204aBmiSVUbG+5cgmNH9eLkzQ?=
 =?us-ascii?Q?v5Uzm3Kl8ce33D6GGDA+GmP/B48gS9vNHbwza1Kl1o+3KCLLddxGV5lLsT3n?=
 =?us-ascii?Q?SLa0arzCxT1uMzKn/kZdFta/US5idAVNl7utBZhg95zDgJFriY+W+3wJ/F4N?=
 =?us-ascii?Q?rSJBE13bksgLDYs4M5FygoLEkHX6u6b0CnilJKD4somPlB/jCbX5bnkiRoEP?=
 =?us-ascii?Q?sIwFig1MvXnnECZE4e+KVjmoaCI59DNP6Hv2ONvRBRz+dzE2THRsVjg3lan6?=
 =?us-ascii?Q?q6yNsjhSq404CFNbTzQsalgGHP2K8aSvW8Qgz79xPS/E3VDd/QWPJfUhM6NI?=
 =?us-ascii?Q?dHxP7/AA8v2FEn2Mhn7jri2tC/vM/Kg1Yh/t5GbOgoW9bNzN4jhkF8Od+t6h?=
 =?us-ascii?Q?GDxxOvw96NnAABvhbL8vs8Th/GtL56wtwSBJ7Vm4l+ZAsa0lmTLXC276d9EY?=
 =?us-ascii?Q?Q/wmOY9jV+3/nXvYvr3mC+fR5If9yYMIWbyOBMW+B5LqSRCovg3vUxumokpJ?=
 =?us-ascii?Q?sGRAUCz0PMyyYoOnVadGKchVCMU3esivp1xRcnFl/Vy64rMTPBFHSf177waz?=
 =?us-ascii?Q?F8hpC54hVs2PkZmwhKby4cNtmgMHZjpbaA0TYEieLNKfNNCDtKZtWFEKsJ4a?=
 =?us-ascii?Q?00w2+zSg75V7TMp6zUtpmKqYcDiBE0ergs8Jz+eZ1rSIONDB0XWFVMuq6rEQ?=
 =?us-ascii?Q?6k5b4Lo2Y+/UWcF69ZvveOyD4EgrnaQizMUC1m5FO9uEJGtYb+cfnFdlpHRs?=
 =?us-ascii?Q?mfd3n94ET6LskgHYzN9P0v9vxjar7LsUGiGwjlPxMc2+1+UKrdhczwFf2NVk?=
 =?us-ascii?Q?YlQ+PTa8MfHoqKVEVVVPyJUDazBMf4S8rZ6HtjL4eWbguTHmWjdR1S+YoVCI?=
 =?us-ascii?Q?P0k/rdtr8y8GAkMavz3UgweMvVkuxic7O9on5TnMXJUCf2wFyElLvuxepLhB?=
 =?us-ascii?Q?fGs8MlqKz7KtTK53jgBO4xjcUsAkosVXCv/LyHlmmWseKRattSuinHhWDfUP?=
 =?us-ascii?Q?4YPexPa48E0RAREn8O+js/M3/KP2X+hR83DRaUE470BmvOU5oJrEUZsjUwP/?=
 =?us-ascii?Q?VVsrOesJX6Q+K9dlpWxr5EDPONncaXm2vk75DCsHGNGcE3RVtirl3fhybONt?=
 =?us-ascii?Q?cMaLDHPWaKZBkuimNgeTwbGOcmfZSQUNxSD2l4k33SsqjQWdYEgG271R2dB4?=
 =?us-ascii?Q?kBukt3LmM3LZM15xKX//TFYytXqH0JCJ5kaHRQcU2cdSe5Pmh8P5TJSTqHMf?=
 =?us-ascii?Q?mxKM88esFKRRXzPd/3xeUwsy61BkvhmAEr9IPlTf/EA/fd7GdnN2qNbmO0tJ?=
 =?us-ascii?Q?yCor4KAF61U3PBtEZuJAWiZsRNxGa7emAlQL7j8SYy5orra80xn+G9QSfnIp?=
 =?us-ascii?Q?DjpmOvJAT/mocmiRhTvtrODG90TYJsXfhjFkcSsmYp82SXb6/dDM2bxD0yBf?=
 =?us-ascii?Q?WE6HxAwcsl7apMrmQasERlDwahjUVh6GXxvSdxBru2u+DyTEf6L7UpsbM66o?=
 =?us-ascii?Q?NV/LqU7j2OeSQTPE7F/AmDUmG/Op5ORsvXrM4lg2sv15j/BpCpfnzpXcgtX6?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb79bc21-3aea-4867-a8c5-08dc1b48eff6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:52:05.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlH7k6g/bav9ETgxBgcf15us9V8f4BqrR5m3JLDNw691Ln8iYCdIhzPsZTJSNdFzWSLTnfTMUvbw1xBBeGbFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

On Mon, Jan 22, 2024 at 02:29:21PM +0200, Vladimir Oltean wrote:
> On Mon, Jan 22, 2024 at 02:24:57PM +0200, Vladimir Oltean wrote:
> > > Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
> > > Fixes: da099a7fb13d ("net: phy: Remove probe_capabilities")
> 
> Also: commit da099a7fb13d ("net: phy: Remove probe_capabilities") is not
> a functional change, so I don't see why it should be blamed? I suppose
> 'git bisect' would find 1a136ca2e089 ("net: mdio: scan bus based on bus
> capabilities for C22 and C45")?

One reason why this patch is not better than Tim's is because it does
not tell phylib straight away that there are no C45 capabilities on the
bus. It lets phylib scan the bus for all addresses, which yes, is not as
slow because no actual MDIO access is performed, but is also not as fast
as simply omitting the c45 ops altogether. I think it would be good to
state what would there be to lose if we just went for Tim's approach.

