Return-Path: <stable+bounces-219976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMkDKaywoWmMvgQAu9opvQ
	(envelope-from <stable+bounces-219976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:56:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 899221B9537
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D129E3020501
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6226442B735;
	Fri, 27 Feb 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f32IJO9L"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387C42B75F;
	Fri, 27 Feb 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204197; cv=fail; b=SHUgRzXL4Qyqq16M4odfqklCXpERJPiQzTC2OnK09jx9xQyka7y2IV0wnI94r4pTeJuozZPyJj/HVbeMH9ouqzkYD7S51yyfdjiiMDgNLC0clYmV4UsJgjbHOikX8tUNqVANQe4rm9DqSbbHhI+88CNDv9uDQQyf4ghoy35bwdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204197; c=relaxed/simple;
	bh=uGwMqmqQnNMO9noB9BeRh/t1kUQ0dxzKWDTvGcJTHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cPwcPrXHgow6u2anhzn6qCttKGB/CEUtTgsx5ptxANFscLJ643yIuOgL4fMYOxZBYNmZIGPq68BqHj1d35VN8Rc/mvOhoFbmfVR5BMQa4WKueNx2I0DoeoDRW13QLOGoTUY0c05G9V1P3SVAOHBxfhvYQ0Lbs+3QqSyizBnzeHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f32IJO9L; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5q1y9m7NNoCR1eUBXsrL+2gt1l/lgKe1X4i5w6TMjD/qelqOysAQl5lbO+MilCp7g2p685EDXdCv0MGIi18YZp24p/okntjTid1SNP2soJXxjv3xxNkn0Xr4g05q1O7wys02xNmvidANIMQfgtoZzKfV9f0QEcszOPNT6v0T4rHXkU6GQOrlEeQprirtdTMOmovp8YMk2lM2Aa2zMb2kY4ruZqNWoBXZsuDnKSBXEwNez/O0T9WxI3DXPPifqg3gC2WC24KO869CM4Z+GXD57PQfDqZF4q7Ts3AlzWY4b78+/VK97V1Absa9Ry6NTiOUkDmArWQqDzr5YsrsXROsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Rt+Ks7+gn7FRCQRhglV8KhTHOoPMRo3pJmpII6a8Q=;
 b=YIqT+3XjZGsrWkfg/V8CgR7xX3zfBd+16CzbaHvxPlFosa+dJoki2pXaMHesJfvdQanUhcMmfvONV7GzlTKvG3UmuIdzpf5HxWFBxRDwWn41WHIzk9aNLPsxT/xJgbkry6jG25jo1Ow7zK5rmlzmD6VJArO4mjoqXvsLs12q1gVso9NKU5MhL1oYcw50xMbaNbB5DteClvRRLjkgAA+StwCMxW61RomDgaLqt0ZklwKYmOyy+oJFqvD/6yGXKkmyU0BsaYvNUxbt6o/OyQ45K9CWoZbI8gvjkYHLId1CKYF0z1/e4FVGQDTw9lqgocpBvkao+myyfhC4IoKbzm0zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Rt+Ks7+gn7FRCQRhglV8KhTHOoPMRo3pJmpII6a8Q=;
 b=f32IJO9L/YzIlBVq5zZ9aB3tNVG3f8ozGb2fAnebZ1+EOplSV5+u7HcXJEDW3xgbcviQWlHGlcXHHkrc07a7tg8sm27vpnloELLsHnIWgOuoYtnqiWdM5mJ/RA2iyCvY7jg09+9a9rFxRCNOrIwnEytuyt4o8uYfcY91jhBy7UYubQSlQs8kGEUNqYq6fMcMm2AoNWssoHGrECWVBTQ030Sx+lKLPRVVO3am2Ob9ycLf+5v9HNjR9gtcqrKJuFv1IsZwMEXau9WjrsySexTtSByQHmrDjbxFFihCIhJAaFSnhS1nhDX2tHMinLaGFMtU8AWNFM9/JfeFZgH6lyB63g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11576.eurprd04.prod.outlook.com (2603:10a6:800:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 14:56:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 14:56:32 +0000
Date: Fri, 27 Feb 2026 16:56:28 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
Message-ID: <20260227145628.hcqon4eokhx54ai4@skbuf>
References: <20260223150512.2251594-1-p@1g4.org>
 <20260223150512.2251594-2-p@1g4.org>
 <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
 <20260227013151.qaw4hvb4fyt5roeq@skbuf>
 <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
X-ClientProxiedBy: BE0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11576:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ec89ba-ba9f-41ae-e3d0-08de76106506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	tcGB/1boHUJT+4iPSbNpVpPLNUdT8OYxYBcgau1xwUyfuuvWCjinJXnXPaCKosDo1FH69+k5bPv4O6GGwiDb0jsY+uZud3036X/AHd/oSffnXbTeaN/mhmWKgRF0cYTDJXXVR85uUX2lknNO56y092OjEMxfB0xwknxAKipsuv+5SNPWYeYtN4CpcPRQ1X1kyNbLEU/LEaxWJBmWSLd8PsYtKLTgUoi042asX7JILou+TOZOtISSU/7JJgRd54WolVGRAAqaP57VLyTg9EbCxY7rBE+C/yQjsSE3rNSL3pA/kpS667aoW51k32IxrDV1nd04BaB4u5/73koQdtVvMyf3UX7RSIve93y+2qsOEciPmAqG0dsZdkcbRAQnkuVibsXevmKCiUr7uvIjyCBbryqUcxwumFvBH2B5w3teQMe7XsKnuPBgI2y6oNuIEKp+HfjIq83MJgv0On0txQn9dw5db4T8NSlNnlqwUh/S843Ieo1ILmSdvbu4D6tPqFmBFyPTPcxvJVBT95AcAWL6rLZcYe66g9GfW9CVXUMzo1ytRNDc/rwTUhtzL+For787aOE8hcdP8pdJZqGK6IgeORTdqFSUY6yOH8kE3rpCwJ9Y9ndUPkNTwRkvHByQwjuWdyyb1uv55PTRjQ8vBK+ZILZwBHB5o85YY03tyQO07IuL7WnA0i9+PtrGJCB2uJJ+dFXJ7Xszl+lWlaJ3H0WwhXIOHmvQwrrFqUgo2yZ7e40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkVkb1Aht71sA9WqvQTE0eW78opySib2fbAM1/ipOGQNzF4RVK3xxWSzjpUR?=
 =?us-ascii?Q?6nAtG1CCqdiJBjm1z9wPps8b3lrepbYg9Pn13j6oO5uvv/uZ+88vZw/HKugv?=
 =?us-ascii?Q?pjmqc7V0Ao56Y7STpSsl4EjOckxatz0ntevkdCmekoHYUd19oMFBQyWZ+J34?=
 =?us-ascii?Q?Urab3hV1WQlK3O3JHY0j3ZMBgoPUPClkK5Bzfutbt8OIkTx00YumCIODONf+?=
 =?us-ascii?Q?AHwApAMH/rLX+52bG5UpspznIpReuegqr/Stg95hTsaiMdkpcY2M5eAME7h+?=
 =?us-ascii?Q?Akj8E1ccV86oPU9Pti85TfzoERTsd4rgNOpNAo+SZk01a5qjuytGA+PMqf4n?=
 =?us-ascii?Q?/YRymmqITtGzPVEJAODCC0MWvLa0IbMQPWSwCGUIkFO+HERA+7cJzrTYcd95?=
 =?us-ascii?Q?MPZkFA/X30bucG6+nFEkx78LFdetOX1HRVJ/tWFBRpimQ1FM9u7QWwxamWe7?=
 =?us-ascii?Q?JDs/9fp4JWFcDIuhApHoPnLICAjvGjWauvyhXeSseB7MtGMDGvtLAWvITYRK?=
 =?us-ascii?Q?96HTO9x5nKsv97KkIa276El31pN4peSNipYBAAp9DXzdeh0QFoN6MFCBAfMF?=
 =?us-ascii?Q?N/U7OD4tA0Pk0JpKEJzbobAdgJyftI0NXlITc9+PP0oKjhdkEZbzXm26Vy8y?=
 =?us-ascii?Q?AaLaHFUyzDTNUQxfCJ0ALiacnAfbxBMrUZUMmv5lPkIJFx0NUyRMyPm/TvhR?=
 =?us-ascii?Q?MSxE7oG9Jdb7nCYnGcULol7iSWEx/DigYJOPq5x5LGrWJpOKOM7ma6aZB0Ei?=
 =?us-ascii?Q?66GWKluxdHJVwYf26JxbWBlr/8AAwYBxUzamqmdUE06F2MaA/kpvFQwLA3YW?=
 =?us-ascii?Q?T+sznncCmTE2mDTD+XVFnIdlGVpbqYgeF7ewQkEEmHSza6PhigAu/DFgFmRI?=
 =?us-ascii?Q?T8aZ2FklnNsEMTGbidr63eSv7/xoDMoPTcMBl65zHrlv+dmh9A9KyBq2kK/k?=
 =?us-ascii?Q?jOU7b58LWpEqHlmyQ1Np6Al/A3xod1WOeLarbQRW4BRKNi5wBbSYqTi6oS35?=
 =?us-ascii?Q?dltYucl9yXNgKRfOQQqhFfOWiXv9Bc9K0L88vbPNZo95Eq/mdcHlTZqFMDNl?=
 =?us-ascii?Q?7B+S3xpLsnwf+dRozbyoAmZIZ6d9OhCMnrrJ5XnapJqy4zR6+rHQ5YMBiZrH?=
 =?us-ascii?Q?wmHK8Uw6jGwhdwlbMbVnnNTOzzbnvIupXRbM5OVYUF8vZy/AospRm1oHQ/Dw?=
 =?us-ascii?Q?UTg69SJvw4yvxN0UEfejbIReC1LKtBNZrbhzygwzmXqpxHWHVgbtnpILKOGS?=
 =?us-ascii?Q?vZ1xiF275yTbZfLIbaLT9RRYFTM74O5kYG/UUaRa6bR7IAQxjtwblswNLF5K?=
 =?us-ascii?Q?TxGXf9sflEHH10WTns/LUHWwNol9BLfeyjE7MNWg4dZUpmTgIb+hbnIuWrSZ?=
 =?us-ascii?Q?f2Ge9gQONJmLoBEz3Bs5O1c+p0Vq6/bdvf3LDmLsIOZxhr7KfD5ANaXzfn1A?=
 =?us-ascii?Q?2vC1Iy2Q47D4FgfrHNEFn76I1e6EfffTrYVgdxH1ptmYCSJxwtmF33LbwMhm?=
 =?us-ascii?Q?94s0K6AppzCvPYy+7esqtRvl9B1WFRCQIuCjyd72kJF6fba/V7KyauAkVoCf?=
 =?us-ascii?Q?saXExkZjA7cAZQu7gWLOHf5ZTKgz90hBiOY9h3avRhL09BVCW6loq0UOTyxC?=
 =?us-ascii?Q?+lUbr4HiSjLifQJXZAWv2EE8SEqeWNJMJWNwU42GANiKJgrmkfT7OWyIUfXR?=
 =?us-ascii?Q?YJeP88lO0T7vFWU3QcJkyQNe4vVYDUA4dTPtPgARj6MZojUVldqNX19lFME6?=
 =?us-ascii?Q?iyUfzeWBBubaH857F9dzqGxBovUe1ZQRzWRBiGa0prCf62Sn7smi2obGg2JB?=
X-MS-Exchange-AntiSpam-MessageData-1: odEyl8ZfPUkyW+Pn8BDLyDbL6mZs2fVM6p0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ec89ba-ba9f-41ae-e3d0-08de76106506
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:56:32.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2+HUSeQWcs9yejNF39qk12qh0nq8ePhr/bjeM/tHOY2kg4QhMUyrktSwWEnnrUlo4fpiyrmSqZAEGVHrpwXnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11576
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 899221B9537
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:07:30PM +0000, Paul Moses wrote:
> > The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_ACT) so it
> > doesn't notice changes made to the action using the "tc action" command.
> > 
> > If I make changes to the "tc gate" action parameters using "tc filter replace ...",
> > then I trigger the "The stream is added on this port" extack error in the offload
> > driver, which seems to not have been written to handle parameter changes very well.
> 
> Thanks for testing. Just to confirm: unpatched kernel returns the same error?

Good question.

Yes, same behaviour.

