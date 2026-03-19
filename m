Return-Path: <stable+bounces-227311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOCnBbIHvGkArgIAu9opvQ
	(envelope-from <stable+bounces-227311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:26:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 350052CCC69
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80D363025434
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601C30E0ED;
	Thu, 19 Mar 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jysrWJAT"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D808317174;
	Thu, 19 Mar 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929833; cv=fail; b=fVIoOIWpriy+JhqaqOkv0dOECguFL3KLRTAdRgcOlgf5caa+QAV2EAEMfv1M/TMzENftX8p4iW4cS7uKPGqM27Mnk9kCtAeLFEqXG75RhN1tfQImd70L3Y1zvykB9T9t2yLfCEh0Aj4ZKbmPChMAN9PIKImuMrNjqViURvD9VNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929833; c=relaxed/simple;
	bh=wsKGm2iw5zNYqcNT8dHZtVBJ+QiIUqFBcNAeNBaU/+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JrH6J5o7noHh/UtomjPUApemNFwTsNpQc6HCtNMvjxolewe774uzBSNMAaQuvzGRyZ5ioGgvQyDv1DqBPIxRdepBZucBswHHydykqMG639nlLdU0hX7QIkF8cN6CC/NNBkYlEMht31BJBy+DUdXJPG8lmSzz21Jkhu9zwtmtQIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jysrWJAT; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JB76vkhCOZNJuXEAdBUhC/XLBS/AMDBJ2GUfowgqCwkz9+NC3grIO1gNp2ygDnwygDwjQhWoO3uFXZ6Ht++/hsa9FHevAWB5j+8tUkMCJYaceXhkYfqvjRfIuHDP2rAh+v+t8pMPz0IbB76r83VS/lrDdS/RseW0vkGkSv+mEeUfAIOKmShPJ7DiXNQwb/FmaW2IUM2ryYnHq4bAMNOFIYWhHz4oCTmg6ENQ7e35atlhjf0zaK+qGVXY7dDskFXoCCD1krHEuV+7ftBTBMBQd3Sj49couyeB3wfrG3GgflpchRqmF/d5c/rBdnacDaokjqxQ6VnU3gY8PJZG/VJggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pym4e3xrAUvIE60CJ728tnQHyAZi/yXkfvFfGMiiqHs=;
 b=cgpNA2vhTRZbJoY/9j7gbhlD7ymHqMrgSC8Pbf9lQ2hRgCYVDkppG9a8QQDO5sr66UIfIptl6MzUkFiLXeQbT+3LaFQ+hlXfTLVyPKr1A2ySqiJUkfcK0iAa6fN7/DLCjg3x2C7WrdixGrc10ncSzADRR+olS7nyuIH+/7GcKZ5tEgqdHnCX3zAD8746k7OuVqZKMca55u4DG+4iDJOwPJUPpSMfj16MwUvd8cgGe9OPtq2AFazIRGoleaYRmWy0wnfvHj6JTa2HiUGlOxpOqgDX5IWcU8olVHveIP0uGdh2HR8to3ui3RLJ/8K+u2UzKbIhdr2aYHE+3ujwgFmkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pym4e3xrAUvIE60CJ728tnQHyAZi/yXkfvFfGMiiqHs=;
 b=jysrWJATV+7tJjv+MIZtYc4w2wVtdJu8lI6Mu+aXliww7VIgCN1yfNQucJzK4MjMQu5/7dEP0kwgShDdLFWA4SXMhMduYlyuVBwRPCQqXuugsg8OyLI5piIgqtDS9gQP+Kq1pKq3mOvJE7Ka3RbmO5DvO3bueTeGMcbYOi2Zk97RnBawaw6RcIT/BxKCujmJcr1vblVpoIyOHVrnJlLT2TQsogOYtB+I2sIWE+6vTuKegx6JBokKoascjCRmXK2w12A8X//poOCHz2kX6O3V1ahf5cCx/Wcor4wnv2UtXvzWLsYtFkkncBYTjBKrrqJ9aJLE07eSZVo3EKbx9tpFAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:17:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:17:04 +0000
Date: Thu, 19 Mar 2026 10:16:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Message-ID: <abwFVpxrriV7Bt2L@lizhi-Precision-Tower-5810>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319091823.446030-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e4c20a-1b0d-41df-2ec9-08de85c23217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	3Ct88AG1JOvxkO1SGvdrj4QCYbqoP3pYc9bWBU6qRTjxcKqPwB2GwgvmfBk6wegOR8UaDjgYg6eU27qK4b43EcwCW/XBHLbB6iHWzHkIh+Zw/Jx0o38yBhtcQWIQPmGJHVmJKyz5nSoR6mtoy7vy1XOunlMTcyInTFA2qRdUxzPFX7A9p59VzXOxRawl+0yh2d7Yk22JKir3lSydAbCqLsYOblQyre+phKHHZAdhtJNna7tIzSdBcqFjFCrRV3IFGRPUYZBON5EQE2h7MQRd8Dc6vlbnYPLzM9RdPxsTXJqvLLhmi4NKd5kGDHnZpYS9KhhbbeXATeUs7MZJnVuK5FVWlokVynQqhtQpUc45ptoFekuDVIY0OTTyS7DuAayOSO73ybazDSZ4yRvijbcA+lpGM28xPwxZXFP+IYAq+GyY6602jDV8r9oZpYcbnK8bl7H1dU64cR+sFxg9OEIiIt4AKYZoK+OARnpJ8z7hnDtEjR+rv7Nb6AvLlkwycbKDaLrNqNVE0IjdEqWglBekxybS7HTGNvOYQAHvUpwZupNmtolNC25GA/zWSeSp+VmKe2rgyPtjiTmhQU1YCxvBw1qbk9WepAC/L+MQOiX8dkYTXyltfy6Tl75YAi1fCg2E++aTsWOahxGByZPPAZv1kl4lpBKjoRnyWLaD3/kIBEBhrClnE6lIJFbtZ7KmE0lXSVI9kqezrzRv+QrqmKZepnc23QfC+0kTPjsWcRUWDFdTf0lnTL6sog0qVQ98HRGEQE73yF0e2bNwkUNySsFZ0Ss+hBk0RFXp3/svUinDokY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8rHgHtyePxToT9MeMTfspvZF0/5ma6v7XWPxlYlFuKLCZ1UbODr1yRH5ZTc?=
 =?us-ascii?Q?Ovm/5QvpvSuf1s+k2xbPyik30SrY2g0kaxIvbzdqENOfbPor8Q1twBRueRCj?=
 =?us-ascii?Q?8Q0e32cXSSYXvvJBheTLIdikq3Hr4I+LASuOKvwF4OG71gtG8hMhXb8StBZE?=
 =?us-ascii?Q?c/AK0GCuzhQvecYkLmbagI0n74TxjD1saWL2AZuRJHIqmnvMb2V7jqoHqBR0?=
 =?us-ascii?Q?ZxnF1UTuL/+ovqKZ6K5c70PEbMTuJtAx5x7r/kyPVMTSJK9Qh05dDk8ek29G?=
 =?us-ascii?Q?KuX+M3eRxtlkB4Y5S8sOBaJaNHsh9nWu+YBaD5oO1uXQyE7nNjQ2F0V+x5I4?=
 =?us-ascii?Q?4ffMGayxNZwMGq0pTgr9pbdOuYCd1j+SIutjDQl/qJrQdge6Y4L/NZ4TXIKw?=
 =?us-ascii?Q?EQ7w2YuMR+s+RU2ysKrw9eGgCRgAsE/Ud0d96GfAVQGYGpDgLKMo1ZuO6hzx?=
 =?us-ascii?Q?aCGwdCMETmsHGMRVMU/IfEgQ4OZzDQtZPuGo7UQe5bybwLx6nqANWTNFcf+O?=
 =?us-ascii?Q?VgReGtcMdSMPuelsDXesUjdt1v+mNPn5jzw238xDzw/+2B/glnS9eckDKCry?=
 =?us-ascii?Q?B/7iS6BvF0HT8RCvHx5B59LhuaVXVWR2EHML9cOk1uYU9Psapz1E/0aDwr2f?=
 =?us-ascii?Q?XG5wWhr44KfRHiV5x6WCleInOWWa1DqH2oFIgoWVoAU9B4RC4XBaBvRNP4Qv?=
 =?us-ascii?Q?YOPVyCrHmvqeYc59k/HbSIOmKoM0NhVpXDIPimdSWj6KQ8DMo/iHI/luyUeS?=
 =?us-ascii?Q?GctIpmNxb7yIvTPifZyrgshF99r2vY9bIGkDvZ68bQpeTBCLfUKuCKDgEA6p?=
 =?us-ascii?Q?3dX829vU1J61iF4vmxKHYMMQaH+CJKBfwQdfTqEeZo55s2RmNLrTG/Vw/+xA?=
 =?us-ascii?Q?aDigHaM0YmL6Y5CfgTkLxufOsVTM0GgkAo5CaGC+Hdx91qPkytrzOnmzupyi?=
 =?us-ascii?Q?3v+5ZvNYQdKlV4F2PTx0zk0GUyFekG1HqwpDGH9r+3KZFALNQh5H2+7yFYo5?=
 =?us-ascii?Q?sqAQadJAQBO65qHLQxFAPDMd+AMIulASA5KO3sO97WGJO1K5BwZi4c6OL8Dp?=
 =?us-ascii?Q?50J29Xy8+lPfWWvYtI7TPl09SixaN6V7w27LE+TVbi2Dpk+qx/nr5WkbeeCA?=
 =?us-ascii?Q?dfWWnTRYWxb5/6QIUyF3ziBPKybRkC9y9a3CJnGqcFOBb79qF4E5QrKD6kP8?=
 =?us-ascii?Q?VzP975L2ptb2w8NDGdcMLKYCgbTKprGREilA3SHWVnwEtPFX/elAg+IB1NMv?=
 =?us-ascii?Q?4d5MPbF55vFvYuQuNDt95F8OjAZC1y9onPXMMON94vw7st/Sw4SOiP6FI+ew?=
 =?us-ascii?Q?Tvxqxl1PHx/HqES7jMj5z7kIbz+Rlj5orPE5NaJAGhyVWZ3UO9nGvToJE7v7?=
 =?us-ascii?Q?pqeYf9Rbc7AcZZlooAusZjmIEGCcyiT9aIVFS0YTIKuNvIXpg+npGJQjRVcc?=
 =?us-ascii?Q?UUTV+sGBVB8q1LCNrg1CroVjvmSsLCPKe+mVoEYVJ2buU7BV4OgSXdOEfVFh?=
 =?us-ascii?Q?Kupos9Ycz/JaZE1bE/kanrNBDSM2Q6I0HVu+CspCnEaLaMpBVi6fFnUgbfH9?=
 =?us-ascii?Q?tU85F9AUVJybyQUhiCEwjqgqbG77p7LJbpiKz3R9NPKB3z3OBK+Jc85JgNbt?=
 =?us-ascii?Q?FzMOsL1SZhNHG8GEdj4LO28Zg+2GHfHiZniTOLa4Nl00O5iZ5bEls3fhJvMW?=
 =?us-ascii?Q?o8DHN5LrBzF/OfL4QRwsPlJdgGJ1en4nWymedUmXZXWf75Ht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e4c20a-1b0d-41df-2ec9-08de85c23217
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:17:04.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqwWYzD/oM0TjUFXCuFsvObVloxZdHEUsaW52Wk+l67lNMS+EHnCqp2OeilVbD4sLXCn6eCb2zsDP8yUefj6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227311-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 350052CCC69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:18:23PM +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
>
> Preserve the MSI capability for i.MX7D/i.MX8M PCIe root complex to
> maintain MSI functionality.
>
> Cc: stable@vger.kernel.org
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")

I think it'd better add another varible to check in f5cd8a929c825
if (pp->has_msi_ctrl && !pp->xxx_broken)
or direct use IP version, which already auto detected.

Previous patch have not consider this old version controller.

Frank

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v2 changes:
> CC stable tree.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 20dafd2710a3..0b0d6a210406 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,6 +41,7 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> +#define IMX8MM_PCIE_MSI_CAP_OFFSET		0x50
>
>  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
>  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> @@ -117,6 +118,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
> +#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -976,10 +978,17 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
> -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset;
>  	u32 tmp;
>  	int ret;
>
> +	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_KEEP_MSI_CAP) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writeb_dbi(pci, offset + 1, IMX8MM_PCIE_MSI_CAP_OFFSET);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +
>  	if (!(imx_pcie->drvdata->flags &
>  	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
>  		imx_pcie_ltssm_enable(dev);
> @@ -991,6 +1000,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * started in Gen2 mode, there is a possibility the devices on the
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  	tmp &= ~PCI_EXP_LNKCAP_SLS;
> @@ -1897,6 +1907,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> @@ -1909,6 +1920,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> @@ -1923,6 +1935,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHYDRV |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> --
> 2.37.1
>

