Return-Path: <stable+bounces-242205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEeHJy+/82mw6gEAu9opvQ
	(envelope-from <stable+bounces-242205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:44:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 198404A7DFD
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAF1302F411
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9F3AE712;
	Thu, 30 Apr 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kbzIOYAy"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615453A75A2;
	Thu, 30 Apr 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581850; cv=fail; b=nz0ff0A933P4cEjdr4BXiFe4AnvkcRc4ugsTTLmqJtW7d3e20IqbJDwrrzzZDeJAdqIPyjkrvKOnWxK9hm0P/mdP3xl5E326Fl+msE/S5AM+mwmShcYX7fQUHNWWirQYcJ/LjM1+kdd85KYSdHfryJ+DcKPh+w6AMZMJ7afV1RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581850; c=relaxed/simple;
	bh=fkML1gVmL5aiVlom+SHX5xzWqz/HEtLOGcO+1ECvkUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhqBGK4ipK/u7yA/kWnZlLIS5qPqRIoEB8xTWcSYnMx7k68SHBxyme3H+AcAQ3cjFIvZbTbRJsLTe73nuzdRyhhlDzvPVQdKdM65sbU4M+i9DbR9T+/PCbQcklH901piMJko2tZ0+8rPUzNQGiJqoBaqDYvhg97JoEtv+Fes1eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kbzIOYAy; arc=fail smtp.client-ip=52.101.46.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odLHQ84pCCzzH+paYzC3Cfufrbh6+qUdvP/SI0ujoftJnyM3nKjts4MxVepSiRhVfJDs/eAdRhTkMlvFXx2Y+Ad19ni7bIsuuhxQNKprVt4dbJQbbwujNT1D61bLTxZ5dFHTsQ+0Re/FJDjMPoCqoOBtrGRqY0I1ROp3B4ySiu9qpHniNsaPfzmozyi/pNDIhZfTqPyuOx3hSl1Q2uQP/GPYgOFg6cbFHningbMraQEY3xTK2LehD5+3nJayMDHLiSlVKofU+G7RMBIYaDmnmQCfPUr8ndq89bR2SL/nvgBIvk9h7p8i2lBOVx86sz7ZWURxXWcJt3Zxs4V6lbK/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9NIoInk5PK6eKh9WrrG+OMbryDiooPwWHkkuIlY4xg=;
 b=reaRZ61y2I6PCwwW/Oew3+YtEBWxVCzTenPIlbvm1DOTvo9hlpwAO/+o8XG5Zwn1BB9cZyrdTwW7BYNWtRoYlMdsUQwCJz9B5tnYTXFO5xmKmzEsuQtFFWMJrzphrFuhkTln6HD0iMXhaowog9HUeICRn0OcXQt136ZX6+HkGPsIIIF3Mm2nJLsVouQBTl4+404x9VMISL7kpH6/GYrQW+wZ8XUnMLazT8dg2usdYX42oOHFl7KmwQABx2t8PWIUJvfMnBvVIzuf4dU37Ojo92zs0Sh1Pgg+lSqI5aZrIy2XwBE3MdJBTz/YNka8+2Oe2y4xSBSXZeGMcox7T2spHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9NIoInk5PK6eKh9WrrG+OMbryDiooPwWHkkuIlY4xg=;
 b=kbzIOYAy5ClRzl2Yo+6U3VSOkhSckoSuNdPOKYG8p27Z9LljowxGhp7s3dCV+bxEI6J+kk2CTdNdKQoTtbBYFouYPi7H7BUPFOoj/z4pZ+NcNdpKuuRfTyMv9qT8qVYEfb7k+AU2Z+U2NLPjNYi2D0i0pOO78iMlQBz+lETh1Jk8iWj3zG5o1zQuuOYD1vJZ2ALzPKmZUF7HN/o9QvAXhcXfOMLiiRND3mQnAfc3HZU+NIgFVnSJbiqxnpyWAwxwTq3VmzmeapKmPzH9oESV9zdggsV/Iu+FiT5G89oOVIB2LCi+u9+6npSxVN+8AcyBimJ9Y4jjSc8i9sw82Di2nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 20:44:03 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 20:44:03 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	ley.foon.tan@intel.com,
	dinguyen@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	preetam.narayan@altera.com,
	cheryl.bansal@altera.com,
	stable@vger.kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH v2 2/2] PCI: altera: Fix resource leaks on probe failure
Date: Thu, 30 Apr 2026 13:43:30 -0700
Message-Id: <20260430204330.3121003-3-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
References: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|BY5PR03MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: c75a3e82-0981-4212-ff52-08dea6f936b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	FLWMp8t+p7PSRXf4ctqnLCLKKO2QBCKqOWr3SPXvWneiRnlQS9XzhHc+jrCNKw5zMcgYH2BFI2Q54F75hzc86bcy88AClHxCydLumnGLBpejYuuh+UpFu/r5nnT14hQfZTigtdCFZgmYUjrpLb/HFg7RZWzMJHlwIGjXCVEao6xgribnySLe7YgyhLfKp7y4L5jL6DkUxLIm9oXYOiagZ8EvB7wrWXRJtoNi9rxy1eWpcN6slcgQuGPgoHIdAQJ93qo0Dit9gBNKiClSvhhB3Loi+FeYpngSDEVIl12tpIuvON/gxO4433zxSlsuj1CBKVvt5Fr7LeynLxJEDXPHudune0qLJV3aNeZF+HXLJs4sy7ZeicQfSB+yvsCGW6BFRNWyqTTe2emEIuPDk5x89YC2sUwPmrRMmpUkhVNpYcGtmY8T1sjn6i6WOga1G5hmojMjfQOKbr4jgT2F0gC13Pxs0A5vshJ5KY96yaB5pNXMk6rTsxuBYBqFCG3DjTqojS6mHLnwZ9xoPJ16vnD50Tp8VVDC0wV28oP3lhB73f3wUX7uCk0w2okTo5uWEfw1r/CKLKlhTWFORq6YLT1vKyV5TvXIpoB1lC0plpzUO2h1jd60MFYqoBLuBKyvmCifJaKIOvMxXB0mFlppiVYSPl2R729hrAQsFT6bjQFuJUCNaNBoTh40EBEbw9Qhvq0Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldeTPxenXJJkKtdhK9CoeKpNeiLBZO6YEKwFDyty08vgX3F59D3GChUCQg4d?=
 =?us-ascii?Q?slxbbK/yCtwofCZ5ccXcoewmVeMuG4a71NXEmfMVMK23Go9MflvsRrzNEcWo?=
 =?us-ascii?Q?oQasE23uEV2dE5h//pniXxPeDqFVFIGWWGjbSKPYGepxtiAREnEgl6hvDRfW?=
 =?us-ascii?Q?uhrJtle2emzQ/Y7v/fr/xMTqQZ3FJP/xTViboAwTzUYU6hyHcOILNu9WHB3W?=
 =?us-ascii?Q?jD32BwjwUJZlEA3aJYIu0Zgdx8eLKZ8Ye3rz0YVxDSkoPovKM25xlmfKLwHK?=
 =?us-ascii?Q?Aauq52PZiLy3U8JMhbknMRIRF7JYXHRJ/0d6uj2COjHybJgi5ZEjtXRHtdSe?=
 =?us-ascii?Q?mqk71U8zTM8/jgXr+gXktF227Fc5+oPCr35yNFMPs3Vk9TNbyjcrsy+zNEHP?=
 =?us-ascii?Q?kTD+CykcXgIQE4rFeKZot4+IdpVKZxPK3d2wQHKefRW1GheCYCUUmH7MjADm?=
 =?us-ascii?Q?n9vv/AbanYhmPsYE9cG43Dx1AACMYSq2X9y6DU302/UIryZYkEWIRpKQPobv?=
 =?us-ascii?Q?uWvK+bEtIi/1gR9bGEJ5xXf1JKJfZUttR700Dh/jpEnZQLPRcuxx5jlTcs1z?=
 =?us-ascii?Q?02uel7SH+wSb1M+55Y3w8Y/tEqxwxBtHVxBhpbWUgwsBGsutcrJ3ptegE/3b?=
 =?us-ascii?Q?oANumBkN5bRUgnqhFHQmSpkXu1pYA4kFw0CfGm3da+GRx2YBOpI5rs6jqfmt?=
 =?us-ascii?Q?XVcuKfu/5OG9RdPfkUqltWDiixFx8GZO9dqDG7rcV7V8YOL2NYNaa5RbdKCQ?=
 =?us-ascii?Q?KmG5eAMIKEXVd5vrhhxSW1cbR+9mQFppYq4B4RSd17rXoKw55hdk5YWsieZB?=
 =?us-ascii?Q?hbQEPX9RcuoOu+BoqzNb4zD2IfO39jTRfVkXG/9+GsicEfqV6wmfyfjk8XkU?=
 =?us-ascii?Q?qUZUcB6ZfDqgnl8yfceP/EqBT4jTeyD+6aMtKIjC6BKSyvKssnBKiSWmnTOP?=
 =?us-ascii?Q?kuZth68LRkxcHP0M/p+w3uut5j6thf2kMqh7pYm9gnjhDUcmnVoZHyoJ9/I4?=
 =?us-ascii?Q?qXNxPlRPiRorIqfRyEDMxVRwo4pw4rpJ1aA3g2FVmWSpFDjnLCZ7g5X2q3F5?=
 =?us-ascii?Q?bBjG3RUsK1//csAq5/0hjgck1LnrHUvsEaFiq5vaazviY3xwEUYNrHEd8BUk?=
 =?us-ascii?Q?bDeme8DyM6Ji0Wg8PE7dk++6wlgy6b1klqBx9NxlFSDc/ui1r7hhGc/GuIAt?=
 =?us-ascii?Q?bmOQ23KpagRUkcXyrQmf08KVCLQOzLjxI+bT2OuHpZETATtDaGkRiGYi+7oN?=
 =?us-ascii?Q?itLIP1Gpfladl1AthNe7qmODqPoxdyKZJQhVXEbe4uyXUCrECIifP6fVSQVA?=
 =?us-ascii?Q?LtLDgk1jVCk7pdoicCIC7DZiIYN1GdI8ADjhiIFJr/aDZvwRMgSxS/FwgcP0?=
 =?us-ascii?Q?ce1jIygZldz+AYMkW0AqNJkqIS/Bjn6bI2fww/zsHUiYum/pxFcKp5kRQRj9?=
 =?us-ascii?Q?mBJDApUcCB+wb2kiacTMH9tQAr7UEeCVb8UQ7RbCxGTuxKeNGnc5LvxtiSsf?=
 =?us-ascii?Q?CeSeee+mUrjvoYST8lNMyU/bi8znQo3JpNVLXt5+3yTrZc4uwsAjEY3YjgT9?=
 =?us-ascii?Q?pj08KqEtiXQ5imQPL/eOroJgubYypQ7/LSH3kMCcE2bRDqPQCX8scvnAiHQR?=
 =?us-ascii?Q?x25usLsp390vP80cf0kUaTH9XO6imePv3fI7lqbm8BuzSpDjZOZ9jb1bv7y0?=
 =?us-ascii?Q?7scc8e/jcnHDOOWAo+UiKVzoFax7FCw0yj6iQ3uyii0Cp5RCy91LRlYPFMdK?=
 =?us-ascii?Q?dMphAYVnE5x8y3PdchE5zGY8CVsG87Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75a3e82-0981-4212-ff52-08dea6f936b3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:44:03.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG9df+bwCVLJXmm74rViWemSNsf6QkR+Edx3fp9cxmQtK9xfHmcjCqDd0r5ODC33VZ8pfNJ6FR2LeG0LrzpClrKeKuSd4tPUp1VGWCeYcWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-Rspamd-Queue-Id: 198404A7DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahesh.vaidya@altera.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid]

The chained IRQ handler is installed during probe but is only removed
from the remove path. If pci_host_probe() fails, the handler and INTx IRQ
domain remain installed even though the devm-managed host bridge storage
containing struct altera_pcie will be released, leaving the handler with
a stale data pointer.

Interrupts are also enabled before pci_host_probe() is called. If probe
fails after that point, the controller interrupt source should be disabled
before the chained handler and INTx domain are removed.

Install the chained handler only after the INTx domain has been created.
Disable controller interrupts during IRQ teardown, and tear the IRQ setup
down if pci_host_probe() fails.

Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
Cc: stable@vger.kernel.org
Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3d3519b8d88f..902ae2d81763 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -864,8 +864,23 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static void altera_pcie_disable_irq(struct altera_pcie *pcie)
+{
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* Disable all P2A interrupts */
+		cra_writel(pcie, 0, P2A_INT_ENABLE);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		/* Disable port-level interrupts (CFG_AER, etc.) */
+		writel(0, pcie->hip_base +
+			  pcie->pcie_data->port_conf_offset +
+			  pcie->pcie_data->port_irq_enable_offset);
+	}
+}
+
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
+	altera_pcie_disable_irq(pcie);
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
 }
@@ -890,7 +905,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1019,6 +1033,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so install it
+	 * only after the INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1036,7 +1058,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)
-- 
2.34.1


