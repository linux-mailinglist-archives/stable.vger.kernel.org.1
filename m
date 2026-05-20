Return-Path: <stable+bounces-252854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKLROdb+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D245596AE5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97779301917E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17473F660B;
	Wed, 20 May 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jj+ZEUFU"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB4332EBD;
	Wed, 20 May 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301763; cv=fail; b=WSmV9m/LPAUFS6Z79i7MY4EBE4F7upd7IIKvWJEDLT6hwYAMa/EafBbdm550+OvO6dQyj7ePK5PIOvejSHWLB8VohI22hRX3TLKOi7m2sByM7S46bh8xS2+SFVvQC9g9Y2hm5Et6sdj76dXFH9Di0MQGWIqrljGvbggku6UNY5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301763; c=relaxed/simple;
	bh=WplV0ATrNwMbKGvbQenVXnfpNrWPYrSPr2zNAENhl9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bSjw2KwSbgk2lEuGyo7dIWQP7Io1IVHLWg+YH2SnY3shGlLg4ztjOTqXSz5ZH10oMZ5i1aVw+LgDwlMrQndhuop57vvJEY57vwuRvpg40waGpt/yLXys+Qd4hsdO9TEW5ucTRtPJGaWQQIchJB8RTsmyn4Ejjazvb9eKagNWJN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jj+ZEUFU; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2Fp/fH2LEC/BVitjM8EL31GqUpiWX2gQXaI2SQnCcJSXufydMmRn4BteDT1v4bUzzy4mfhjMjCFPsyX7GTmMsCnJ1AM2LWIZhc8tmjzQG4cvdMjRiwPFhWfpnq5rZnr35yDiWgQAQ543XI06mFcm86f+ZMAjTd1jVGOvvQWw/udmRDL/hGzcm+6/vPrs6H6AIBZWm+GLazRuhM2MhNzhQIXn99Z8lrXM29bYYo2ADjeDqQX94k9/Zwkj1LAjYbh5aB5aj0vIFIjPsDEffumGd+wJuVZpp/YtVbpLZJGuW6HEMYcD11znWrI8rcwI3ikE3gF97LvSbWEldtAGm81JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pooei0qzeU1Pl31VVxdmiBfOIqU0jFLjTBIcf0vO1Jc=;
 b=CKJ5nToUcPVBoWIgyhmld9nC1wdiVow7XklZ7odwSPCYUBbI4390+/nU1zcynCoSHoDq1TopylzxyFMnWHSK9QlGDV4YwJH0BSPpYRk9oErggI4Tq2DW0ABrnRdfCxqXXOFxFoCZNoss3CokzuWFEEF1txCaO54KgeSMUyYZPKx5bIJzPh9bHKQa8G66/Oe0fNo7CPZ7ddIU7ma2JgFNkNLkH/BxqssOgr6IHMQmCNEDFum0sysfsq7a3bgtPQapRw+n6UStL/dcxz9wmsOh9CbS1yk6SuzM7MFVXjnboeyAxgL/JMirjdAfZ6jpbSdSLVNeXVQ/gtIHMu0FzyYE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pooei0qzeU1Pl31VVxdmiBfOIqU0jFLjTBIcf0vO1Jc=;
 b=Jj+ZEUFUiW6ISHw7YH81S21+lQKzpMkZ1gQjovg74y+Q/v0imXASnEy+CltR8O7nAmzsLT/chBmHjRjDJrvkoHkaNrcs1Qp+kmHYY82mYm0jq5gqcfaUh+d7AFVtA6cwQGdLF/P8CUe3E38YVvVs892uqn9k+d1y5c2YUljyMrBa3iRwRys+Pwg389+8BTnVnO3pT+2EGW7wZgEOgGP4kIpE7SnaopndRv1hxe5N9Qu8QIaLRos3XaaFNptOmUWVj94zsJxHkYQh3KtBW6++tAWs6MXkKmwvqRK9Uf3lUqXIuDtBlWeQokxZVRmFxrJ5KnCmVKyvzBBuVu36UoEu4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 18:29:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 18:29:17 +0000
Date: Wed, 20 May 2026 14:29:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: aisheng.dong@nxp.com, andi.shyti@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx-lpi2c: fix resource leaks switching to
 devm_dma_request_chan()
Message-ID: <ag39dZ9ZQ-ewu3cL@lizhi-Precision-Tower-5810>
References: <20260520093323.2882070-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520093323.2882070-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c51be7-db18-4d4d-b8f1-08deb69db3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|56012099003|22082099003|18002099003|38350700014|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tMDSufcA0NAmxV7lSbZSo2GeN5saF/KyLDftA2U3IbskB3fvPB3tNeye/Whb9yRXTdSQ6qGB3hoz1nj3gSpFrvkVrH1wXPX3S89jHVETJd+DM5cHFDWEbNy7jqCcNXjFAfe65IVRwC0+WcJKsYxJeryr6fy5xv/m+BUs4POoHYUfc6sT+VCL72wSlhoovP+/bFJ17qYBT6TzjEfw+JwsuBWzvx2SAUAYZqFsrWIWGofzdmYBQ78X0i/OisJpz4r/xhznaW5jLk7l1PpDCEBmXGQSdJ13ajYw2y23a7LkXuQFhWkP6GBqRMgc5DuUlfUBuPQ1uxmXHU0fVEp6mCNfVNOqbBbo8nVVilfnDpWR802c79CaB/M+/80EbH8AKdcMlPyDevkPDncojaoZtnwo/+s/skr2q/kOynX7EQC2TR27L0Jx//B1GHTiDjmfQ9cq04fIZgZt3SWQdD5CKg6GhB/pzWxfq+viX6z8xif/9py2tWgohg9/GnaWfgsvXbFP607h+c8ALlcm6/d3r5gtEJ4NYedMClx6IYFDdfR+LPv8uD2pdsXIRNiQGNrpiJuG60baJPXWAl03D0Hpshc+0vdV90mNTvduZJ2dnWIMRm2yyEG5YXSer6m0q5SVdRSK1zdClsagR/yM2LmyQyp9Vk54lSpjJpn01bTyhbJoWapUiae/s2hQkcpAzxUMDGCDZulRYt2RuRjV1lfThoY68wosWsRNL6fyyXsCd2rQPTCWRpVdCuO1kloIhG35FRM8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(56012099003)(22082099003)(18002099003)(38350700014)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQ825bHEMUCUAva5p0W2wA4ezpO7NhZnzrHBtv66ZDMcTupE17hT8P16lixg?=
 =?us-ascii?Q?J2FPPV4zoG8/5ihdnAEm/1tfiTrXX+7qA7xhAsY8vKFleSl/2r/QfMuNg+7v?=
 =?us-ascii?Q?a4vW6FhHg1iQ2pItFFCuxCHExnvdO1sm77Af+i0r8c7/bJa3oRFr0AXsQe4Z?=
 =?us-ascii?Q?LM4ag0VY0FB5Y3TDf5ob0GNqBuWIRtBjpnjApn1RriYFl13fiQiWz2a/hOBx?=
 =?us-ascii?Q?m/4Q5WXQAL3UdEbdxdozgzaHD+oQJc8yrC6HcWENTYUpncqD3bkI0ad4Rwpw?=
 =?us-ascii?Q?2lx1H0EHxmjHJeRFqHkKROFtZO88OQUbDw3qsLWZYDxBypLgw3k7trfW2bnK?=
 =?us-ascii?Q?zpm21/OR0cYWJ2KpPkw46u3t7gLh/pQih6NFksHAR3VH7hRLohGKhbHix/dI?=
 =?us-ascii?Q?U70r/r9StXqtE8g+OmmElowweBWHzqMRIdowSvJV9r6BHBVJ4TUxz7Hfsj5K?=
 =?us-ascii?Q?UyJN/yeZsMdXNQcT4MkwK021zdZzzBbacrwK/5OuizUdsLBnlrIocxVNhyF4?=
 =?us-ascii?Q?gKo1lEpyvL/2apExlFz9PjsjjX00ZVuGMbX1Y25nz/SV2UG3ZKXAWuXET+Xr?=
 =?us-ascii?Q?i+sE4x1H71P5LsXsdyQSTy3riczyyWacnhyMpK8UmOWfHwcWQDsHr3kExf6K?=
 =?us-ascii?Q?WEyjwp0P846/6ZnofzlKhFLx+5oLtQi1E2JQnN41x68GEPPYfY17a7jukgo7?=
 =?us-ascii?Q?HggyWAJM1NgbejgsAm/7AR35zSNrwcUNK/LkxJGXDthYxEC0Xz4Z2JDXfU7t?=
 =?us-ascii?Q?2OGeeSVqdW0CxeMrH6t/53/uQCe2z/P8upFVBKPOyNVYijZCzIm6yKEDv1l8?=
 =?us-ascii?Q?aWNYOSJmIzJ8TUNUjdWddH1OV5RzPTMtYO35afOdVuizRCBGjq0/18YTmztV?=
 =?us-ascii?Q?ZUPaDMDmMtgjX3QT/LCk9Nsm7yhE/XhLdkeUyqOtGxOfUCaaEWYlqjaICBuW?=
 =?us-ascii?Q?wuWntXv4ZpRZ2aSusRR7d0imeIj+5QqviO156wzPR+FfkipJaigii6giRs+u?=
 =?us-ascii?Q?RQq7xBF8AQ6Ra88awEIM480E0epDkzCqEekqXPL67v2g4Uu1XWxa5vd/DY+N?=
 =?us-ascii?Q?B+LRoXBHfKSkVvz53v1L9BdF8P00XwjkkoTvCppFbANJEuZUHhwiFgMUOMVR?=
 =?us-ascii?Q?fUvWNHmuwme8WMrmh2rgnzbAT9d0aKRyaQwwyJeT205rgF1jzeK6+XRPHabc?=
 =?us-ascii?Q?G5C9I9CDVFmwMBwPZbk7ISTnc1QYFXSygNmIaP1Xh7wdRq2bpssA5p3vAHle?=
 =?us-ascii?Q?Im5cQ/NTxq1Uf3EhbPVqEwa9Hs/6rr7bBLHE3wfEoX0vT3IlAzVxtKx6UYBQ?=
 =?us-ascii?Q?OS6DYq6FMDTwSTu37qR42gOpKP1aHo7zH2ggq4Tob5+tL+bfoNfdzFw17JQb?=
 =?us-ascii?Q?pjUIuejqktbMEyDIsl+OC5mpJWoRXg+c063/+J5hEJnSElM1Qmf29r4EFRz6?=
 =?us-ascii?Q?2JchqLCN7XQDODxquAxZlhIRK/F2zLPwGiaBniq9V8xgwDkhXH9imdBb6gEO?=
 =?us-ascii?Q?OUG7J+gROTNuZ4NLIzUTbyzJRuf1Vp5e07FT8zoVfxbExMlFZtYWeUZ03eYa?=
 =?us-ascii?Q?yRo9cVb2g/j2hMUxzf3YXorQYvlAiaStyjDvPqve0pg3zx4c9iJjneY4nGIm?=
 =?us-ascii?Q?QczLUkj3oLcE+HSAKfAzOXjO3de4nu+PkP+5ligaqCdNx7sxM+PNzrk857V0?=
 =?us-ascii?Q?lTAuE74dH58YPUxg7H2NEgrRNtKK6F9f7crbjz6x7zrntRSq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c51be7-db18-4d4d-b8f1-08deb69db3c7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:29:17.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjyUld8sKU4YF2zKKqxN3vM/foD8DMgnzQR9fplDiz53lmYP8KbZaCPB9HFqLPQZ+aVIWg9TjIa79tjvdcm2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252854-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 7D245596AE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:33:23PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> The LPI2C driver requests DMA channels using dma_request_chan(), but
> never releases them in lpi2c_imx_remove(), resulting in DMA channel
> leaks every time the driver is unloaded.
>
> Additionally, when lpi2c_dma_init() successfully requests the TX DMA
> channel but fails to request the RX DMA channel, the probe falls back
> to PIO mode and completes successfully. Since probe succeeds, the devres
> framework will not trigger any cleanup, leaving the TX DMA channel and
> the memory allocated for the dma structure held for the lifetime of the
> device even though DMA is never used.
>
> Switch to devm_dma_request_chan() to let the device core manage DMA
> channel lifetime automatically. Wrap all allocations within a devres
> group so that devres_release_group() can release all partially acquired
> resources when DMA init fails and probe continues in PIO mode.
>
> Fixes: a09c8b3f9047 ("i2c: imx-lpi2c: add eDMA mode support for LPI2C")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Change for v2:
>   - Wrap all allocations in lpi2c_dma_init() within a devres group so
>     that devres_release_group() releases all partially acquired resources
>     (dma structure memory, TX DMA channel) when DMA init fails and probe
>     continues in PIO mode. Without this, a successful TX channel request
>     followed by a failed RX channel request would leave the TX channel
>     and dma structure held for the lifetime of the device.
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 53 ++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index 6e298424de5e..dedcc24e63ec 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -1383,55 +1383,66 @@ static int lpi2c_imx_init_recovery_info(struct lpi2c_imx_struct *lpi2c_imx,
>  	return 0;
>  }
>
> -static void dma_exit(struct device *dev, struct lpi2c_imx_dma *dma)
> -{
> -	if (dma->chan_rx)
> -		dma_release_channel(dma->chan_rx);
> -
> -	if (dma->chan_tx)
> -		dma_release_channel(dma->chan_tx);
> -
> -	devm_kfree(dev, dma);
> -}
> -
>  static int lpi2c_dma_init(struct device *dev, dma_addr_t phy_addr)
>  {
>  	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
>  	struct lpi2c_imx_dma *dma;
> +	void *group;
>  	int ret;
>
> -	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
> -	if (!dma)
> +	/*
> +	 * Open a devres group so that all resources allocated within
> +	 * this function can be released together if DMA init fails but
> +	 * probe continues in PIO mode.
> +	 */
> +	group = devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!group)
>  		return -ENOMEM;
>
> +	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
> +	if (!dma) {
> +		ret = -ENOMEM;
> +		goto release_group;
> +	}
> +
>  	dma->phy_addr = phy_addr;
>
>  	/* Prepare for TX DMA: */
> -	dma->chan_tx = dma_request_chan(dev, "tx");
> +	dma->chan_tx = devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
>  		ret = PTR_ERR(dma->chan_tx);
>  		if (ret != -ENODEV && ret != -EPROBE_DEFER)
>  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
> -		dma->chan_tx = NULL;
> -		goto dma_exit;
> +		goto release_group;
>  	}
>
>  	/* Prepare for RX DMA: */
> -	dma->chan_rx = dma_request_chan(dev, "rx");
> +	dma->chan_rx = devm_dma_request_chan(dev, "rx");
>  	if (IS_ERR(dma->chan_rx)) {
>  		ret = PTR_ERR(dma->chan_rx);
>  		if (ret != -ENODEV && ret != -EPROBE_DEFER)
>  			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
> -		dma->chan_rx = NULL;
> -		goto dma_exit;
> +		goto release_group;
>  	}
>
> +	/*
> +	 * DMA init succeeded. Remove the group marker but keep all resources
> +	 * bound to the device, they will be freed at device removal.
> +	 */
> +	devres_remove_group(dev, group);
> +
>  	lpi2c_imx->can_use_dma = true;
>  	lpi2c_imx->dma = dma;
>  	return 0;
>
> -dma_exit:
> -	dma_exit(dev, dma);
> +release_group:
> +	/*
> +	 * DMA init failed. Release ALL resources allocated inside this
> +	 * group (dma memory, TX channel if already acquired, etc.) so
> +	 * that a successful PIO-mode probe does not hold unused resources
> +	 * for the entire device lifetime.
> +	 */
> +	devres_release_group(dev, group);
>  	return ret;
>  }
>
> --
> 2.43.0
>

