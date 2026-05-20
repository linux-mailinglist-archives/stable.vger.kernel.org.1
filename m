Return-Path: <stable+bounces-250767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJvlBwcUDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:05:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEE05991BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4488A380F5AC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D233DC857;
	Wed, 20 May 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VKJk+7L4"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F883DA7C6;
	Wed, 20 May 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296262; cv=fail; b=Miy8IvnCEq80SLJ6vfD5w/F55MDncFsknKEj2AXrd7ZcpB/CeROhO0kg+ZCfjOOyx0rIyt0N55MYAEJ5wLjZn2+Wi6uhi6Lc4fc6TuuLZR7ydAOyF5GA9CO7L2Cnck7ztc7Ll8qxp1+fSlTlfKuCDh7CjSu64Qqh5KoP9zXleEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296262; c=relaxed/simple;
	bh=hC3ldQjBX8EJen592GU6apJEqVVFN8B5Da4q8Ok4J34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ix3xeSzqHtXPAfu24KYRS1l5WDVTrs/nXnQdfF/oc215LFYDxOxsuu85VZgJjsRvQLnNE16sdChxfjlKdJOLeG3ohT1CmJawi5+jOtOtl7gme2izcToMxwtWOTqD4Op8ShbMa2LGLh3X//tNj5JofWxn8dVY5H1+q7usNeWwAH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VKJk+7L4; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDctrNR6+VMw6rB9/KYcsV9wDacYu2JhjOxPsIJZCMwPhIRHV/YSdoq/T9le4H/IxMrXAIC8ZHI07wFUqx3oe+lB/pjpN7VHiB7XMz8Wc+8M/yqy6rM9ZgGzCG0gjtWbLwOPXNKNWc2XJpl9BcNqHs3JWwj+AnB7qtWbP65ryEZivo6GbxrhYHiBjipSqjrt+NAkxd0RlsGU5fFpMXqgmZAcwqeL9LwXa+9G73C6T3/R730YNEHuZMTARBQ+0xkiAy/gUqGNB42dLxmK/yBqyLPAE9geyg7a1UBbVdkOeEiKdafak40XdgBic2wq4Vbdu67mHISbx7zI1X5X87KSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+wvHrQxtEh5tBeb6sDy1cEwwblRtepfSOr1f6JS/0s=;
 b=N4ablcsuT7OpRXxRMzRqs9H8DwU6mq1COmi93YkEBI8dRMrx5Jd4M4SpzErJj4pI4N3ffZCBaCSSCAAWVbPqDRipANOJMEDniTX7ZVuibXz/YlJCO+jsQ2gJ7D6jG/Wzl3EoI6hlmak//xSMh09H749R20NYfQ0ZJ58S4Mbk1prEW33OVnURlB1Ve3JOppVX7y6MaH7Jg3rHhXvJww2peih25LiYBe+jiFhikRGzoqb8M23VzGejjd/tQoGBh3eDlgM/4G+NktZivoUpF8RP4RjX9Vpb5eB4gaLQeOcXI7TwKPlkYASVYQd/1jP0qXT1VxuQ1cigO2H3QRy2KgrQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+wvHrQxtEh5tBeb6sDy1cEwwblRtepfSOr1f6JS/0s=;
 b=VKJk+7L4DMcsMMzkZ1WFlD83Id3eQc9/y/u/eYCj1nODa/jSgCreAcWIipVNITUj2Liza4YtuDzGiVTeirIM88TCUVoKUa06qeZwRIfr6g0K1LwClk13TqUJevaja8UzXNWCH8Mk8UmbSDw9Ug4Zfz+ySSAuAWddEEJpZ9wjV2PTsbyqt9eDjT/mBpPixwW27ZvUp+4iFUP7blWH6HjcqR18rog8nr/kUEWWdM+hoxsOJ1ufBxspghZ7ImlfiYwR9g43vGF/QplaNH6oWp9k8c17bwphnr3BiTcOF6UEGV0l0AzUU8+G+J4vQsps9NcC8ElUhCFdLH0ysfVXs/Up8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB12164.eurprd04.prod.outlook.com (2603:10a6:150:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:57:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 16:57:35 +0000
Date: Wed, 20 May 2026 12:57:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: broonie@kernel.org, xiaoning.wang@nxp.com, Fugang.duan@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: fsl-lpspi: fix missing RX DMA termination on
 TX prepare failure
Message-ID: <ag3n-DfzktuGIq6P@lizhi-Precision-Tower-5810>
References: <20260520094308.2882892-1-carlos.song@oss.nxp.com>
 <20260520094308.2882892-3-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520094308.2882892-3-carlos.song@oss.nxp.com>
X-ClientProxiedBy: PH7P221CA0060.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB12164:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5c9195-f6d0-4bac-410c-08deb690e446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	yEcubGAauIdUpME+7UpbYxKyqYNE41B58NzX8vVka4vFKqdDYyfRaNtEPWiKvJJi5TgoS7X1N5v7N0xltVI9gbiQeGzNSgMq2bX0dcEZSZcvsumwLTq+aZ7eV8TsOd2dYSxcA17NE+ihtnTv4PmFPphmY9AuKXyvwQkbijs7FE6iGDDYvFu7MCQacpeCwWDQhi+b8nB3txJ8pTWghqk6RAWLO6EKtYV036mGpbk2zBrZTOWR4RfwSa/OoTegUZIYLHICbn/t8TcBv+eJ3nEUY3zEok1shi/NlpoSP3lnkZ6uEFIas/WmCj+aFz+un9qoiX2+7ME7t2fFcKAHPYs4x3ZDVEoDNVLHINc1CJZJ6aeDhcu9pEJB9iQ0NU82AVscCtTei49G+p4m2iETk/epuanXel1nSU1J4IhGKHfrWhN5mVpS1+PC9ulvpy6A50TmXoHfG7W0Y44Zct5+iBHYGt7uliKEvBG+VkC8ViNLK7WC01LtpD/Z8xgBPhjHoCMtwonmk7fZM238tG1Iok76NnAEHCMkvYMo4UGBEXnhTRXmghcngcuAq1YlSI7H80NQeLNAhy63zcUSrJjVPrIDW2pKYb+GjD6QU3ooTBLlLGpnJ56PyvysFRWZLRBZ72TMZvmvHQS9bKQwYPJtviYytl4GpoJRsg4Qt4oTayEBng2Aa6CVRZCKamszSrk7HvtzWXxB+tEvxLqRXNW9H00lwJ0aDVOnsEDAyz3+JOFe0wyuNixYN/sSHtz7JICLnjSa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YE5Go5xencZJtQLfDPEoPs0ruf3tqNAK/mPgB446016a0tXmpnLWKLudSZ5j?=
 =?us-ascii?Q?cJd9MUD4acbzhMStki91VoaBh/vze24HY6NBbwdWp3/mcOvt5dIQylvnuvla?=
 =?us-ascii?Q?GqUmqv5BS1VQr9UoGcor14ZeuHAQ205BnlOfJhxCx5jibeTAToQf83btEXTD?=
 =?us-ascii?Q?wWNijL6TvcnF5IZRnSiBXl/H77UIvILd52awYXu7Uf/CpZHaaDVKr/WdHvwH?=
 =?us-ascii?Q?Kf+yG9r+Um1AktGcRSIrS/5cTLsZdLXLlDJi7+XRIDzqBiScQjiGgpsteBej?=
 =?us-ascii?Q?VkbmGi4/AGDvLkKih/eU+JNfTGOajUs0Oo/dM1rvaSKYfv5ypg2T/QTs87AX?=
 =?us-ascii?Q?xgoc4sAzeFAPQd1K9R+LhyFQQoz5KvfI0X4SKGlDdnZOGWlKdh6sPHWMBEGE?=
 =?us-ascii?Q?l/oXhvw2MAaAxCWBatFOFRTHVIq2Mw2EAS9zTI1X9XD/kD9AvHiNnwUn5kCw?=
 =?us-ascii?Q?S5wHfhx/YQTNSS7Wn6sfthdN49Qj4qAi8GyYqHUBATGO52cj510qRYq0edTv?=
 =?us-ascii?Q?QLtfgSzacpJB3/vzOu4nOJuA7XzBPJBiknBzKlor0QB7uFwgSUm9KEjq6Oty?=
 =?us-ascii?Q?0x6RT+FT/WB21okQamK227xbLmn8Uf3yeCYn2+mNYTnh+QQtCMAbm42/qbyZ?=
 =?us-ascii?Q?1aNZlEgCiFTplEJxCuTq86mcGYAZ+0/F1Y0RK5mkBSqizwNaOpxBH8bk1ZiJ?=
 =?us-ascii?Q?0YOQUF4GHHlyvqlSIY4t2uV6t8HHpE9XFPT+YR5cLq3Q6Gfk5A8cnv1eLUPI?=
 =?us-ascii?Q?E/moXhqt1QDf3y2YNHU/C29bj7tykkg3UvJdVnMSuIOga5qU1jZTfb7TVsiU?=
 =?us-ascii?Q?1re/wRbmAOLAH71+PQ+vc4UlTDbZOMS37qNJeMUKoakLdWJipp5W++xR1KSl?=
 =?us-ascii?Q?+q70FlHNiFFLrhxgsy2FIIf1IAZGzOdK977wnNV36Y5LekOfzeAyDkioKc3f?=
 =?us-ascii?Q?o7/nXYQj2dM63GHjtJ7oXT+uyMa/pF473FMnjAFRpBRREEsjuD/15aWbcd6f?=
 =?us-ascii?Q?wsqCAyOa5kXO1o17YCkHDBPpcLSohdLyxU9Jfoh0rohFZVIKtTpCVHaeCeju?=
 =?us-ascii?Q?2KiQTSBGKjODRfUFDmobX6T37xjOHSem+44BVdppynt+Zo1LIVUTCe4GAyUa?=
 =?us-ascii?Q?zdTFFcWlyKIpkMBsAxz89Skt7/m4O849RD8UvsiDQsL4A+JHsv31WHzAQCXR?=
 =?us-ascii?Q?guu+cm7ueLPF36WfDW1pHDbqtqIXQz0hPGBtny0gT8HPpNsf63ZBEvufjOCV?=
 =?us-ascii?Q?JPdowF3hBvbJGz5IWlqQGQinfZ1Wkv0OfZgQTJ1nTYao2zw0qewSO3aQpkyG?=
 =?us-ascii?Q?9PzNpqHhGmeyn3tPh3ivkQGwkZA7SwfHedRc7clFbi+Pwyo4Xla9RQEY/6AT?=
 =?us-ascii?Q?/r3kLOzvjNyi7l51OAkvc4aIuRqvnaVSYA88vyXUJLuDMc/z7sldH0G5zqHC?=
 =?us-ascii?Q?ZsKfysGsaX/Srd13X0b5D+b04jQoreoV4LWR6ajfdeDKSAqWGfGk2JzD+DMO?=
 =?us-ascii?Q?niYFDNuJsecMfdgobjMbyV0MCrEs12DnbZH106+nJRA4L3bkZp6NjUZhGnWe?=
 =?us-ascii?Q?sAKRRp2uFRWWIRZHfRQcuANZCr1UjHDHP6kI6/z7C0jrdMgDo7hwLi/DTAHt?=
 =?us-ascii?Q?pn0fSGbHsr0CrlvDZsvFHGJudVuTa4UVXKhBSbP91rD6Ns/G+qJu0+GHtZlO?=
 =?us-ascii?Q?M+hYmI7nvLNqyN5aHAILqFuG0KwLw2CQuP40HqP/unFJ5EgyHQK3g2F7gA2c?=
 =?us-ascii?Q?2mXmi4iFUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5c9195-f6d0-4bac-410c-08deb690e446
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:57:35.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NU/QwcI3Cz8ZXpICTvHDOXqjg7R3Wb4p9TCB2SV10RSImulhC0oFrNseYBpXWNmhkA0YbTV4rDUHP3LlgQOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12164
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 7EEE05991BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:43:08PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> When dmaengine_prep_slave_sg() fails for the TX channel, the error path
> only terminates the TX DMA channel but leaves the RX channel running.
> Since the RX channel was already submitted and issued prior to preparing
> the TX descriptor, returning -EINVAL causes the SPI core to unmap the
> DMA buffers while the RX DMA engine continues writing to them, leading
> to potential memory corruption or use-after-free.
>
> Fix this by also terminating the RX channel before returning on the TX
> prepare failure path.
>
> Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> change for v2:
>   - Add fix missing RX DMA termination on TX prepare failure.
> ---
>  drivers/spi/spi-fsl-lpspi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 1a94a42fac31..906892453a84 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -647,6 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
>  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx) {
> +		dmaengine_terminate_sync(controller->dma_rx);
>  		dmaengine_terminate_sync(controller->dma_tx);

Are you sure need terminate tx ? suppose tx have not submitted yet because
failure to prep.

I think it's should be typo previously, you intent temerate dma_rx insteand
dma_tx at beginning.

Frank
>  		return -EINVAL;
>  	}
> --
> 2.43.0
>

