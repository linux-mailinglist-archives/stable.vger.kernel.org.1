Return-Path: <stable+bounces-242204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HMMIB+/82nO6gEAu9opvQ
	(envelope-from <stable+bounces-242204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826E4A7DEF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4052D303B8C5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39223AA1A7;
	Thu, 30 Apr 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="E/4Nzkf4"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021130.outbound.protection.outlook.com [52.101.57.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C537E2FD;
	Thu, 30 Apr 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581841; cv=fail; b=QcAlHHSbDL1hZgibpV/bbiOu7uPAzyhJemczInTRLA7yljdpbOv166KY01IBAP7Zo/hey8Q7rfrJXbu8U6/Xj5ltci+cu0oz1w5O40LPfpafeZNsDGaqZafTpydUM3FHusqdrj9+t2cJ3jeAoyC95bqHKkZkHqmqbE3TIoeC70Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581841; c=relaxed/simple;
	bh=iVXELA3dGr00Kx7tyxbZbL6nsKXAHlU/f131/3T+y74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guVfuNpHtldYCgRt2XF/yqxAe3u3ZFjnX6OYq02O3hELFDP5YLO+vRard28wNkgPK8e0TQKbchPnny88atoPUjhQmi0cqht3O9hDiX/xUG0h182I5v3Z6vEQKuniBQqzZQiy4fkSJKqP+EPkE4IrYT/EgezFeoOH75nzLpgaOWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=E/4Nzkf4; arc=fail smtp.client-ip=52.101.57.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVq5DouQjx9iE81Thzd/j75iijHzPGeh/MIk0IxLS+/rct/U6Du3Dc8bJwTAGMcNDkIV8s+V5xX1F6h4sorPZzku5kg6LeoGzU16sNX1Mq5ZRnECvE4Mys/TbUasgotsm0PbPwy3APdVXZaJhEIQ/3f06JxdZi/SO4NZb6IuW2a1ZaQRrnvcS+qxMC1VINNe3b9NM/1/e0prV52j3lLjSJcyVZgrxtHv6Ehh5xupIT06o33b86m5mtpGkwK2yJej9lfx5OlosxdOr10Pae9F6ods+wt+ZPnzh1Wc0uiLz25AIEdxyhM643gcvyrdimuWJfg56Mlt1bf8C6WlZM696A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHDW7QG7jDiBC+YUyo5xzASkCuu1dOjQxJVMB0R7ob8=;
 b=c0EBS0camcguKZHP11s94Hh/Y9qCvo4mshnaCdOjREhHYlzaF23ZKubQ3ftpM3vZF4sw2DcvqbLQQzv2iiW3H+tETwIMw7EtYaN6nSBnKVPXO2QodqGNvtP9NNd2K0gHAo7H963w5lazO//JIajzWypxecbF2VLAETqKqKHn67bK33yQQRisyai33radjrL62RviKqBpUkn+qNWm6WzmbPAfudR2hin/goE6k6c97lztsQIQAOIMP1upRFLgBH4Lkc3aSBvlIIS5IQWINgGGIv3lkQeB+JDczwsszTkOt91o6A+5FneZlbnLjnKg04vb/ZFwUsV0W/yHKmUpjlzo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHDW7QG7jDiBC+YUyo5xzASkCuu1dOjQxJVMB0R7ob8=;
 b=E/4Nzkf4+uFOms72QUFfcUbcNba1xWWVQOPFxQuBxLUN5HZSSqARCqSMvAyN8KeyOvkygYvgoZVFunNgmvRVZfTkVsD8gcTKs1qc+YmpfHrpNzKa8VJoF3t4lzNGtu72wXk5WFXd/AwMXiqwISeJTZJ/CExVUqxgw3OU2/lAWhwQZ8YYtBdSwzOri4d2vNP2V9NJD39Mw1+TBjG/n7Jj1PjOdEJo8qBhKd/dNfi6mTAc6OMcO34Ef7d/vZgn+NEx4Zp05hodQwxBctZv4Gu7lZlEDyf8cZJlKnYHl0sWCYu0lNtJJ/vaYxdCH7mpTVLOHd5pglsT9DGZMdjLvcceVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 20:43:55 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 20:43:55 +0000
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
Subject: [PATCH v2 1/2] PCI: altera: Do not dispose parent IRQ mapping
Date: Thu, 30 Apr 2026 13:43:29 -0700
Message-Id: <20260430204330.3121003-2-mahesh.vaidya@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 307510a6-e1fe-4e45-2d48-08dea6f931a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ciOil+d0XFriLlGOMv1JOioLxEsVlBmQeh+PxrFKsJwo/xHv9OjS0N1i4krU7BJTzD9s5bqntiD1krpUmZaXZIGWDC0Xwz1Bd1ShhJ3x6uRLopuW5KYGB7ZCSO423AryazOpdwc9Yw0ZGG08DXbKodVD3YTHA4JOhnS5Si//krk4UZRFiZ1pxq2VB+VbRxFWihf91aQNGzToTdVJwNNzil5Lmmc/d2VQOWf38c29Rc0toxe1Jzboxc6qoAWDLDgTpe6vdEfcSZIOF2OHUsLAQGpsXK16NNAIdCzIpfNhSGaBQqyG3gc6jRUrG/aKP16NN7HvS+tZFG+Ueq1qkLGl041kfhvu8YuYGwATnzk+amgReY8/OFDJrjb7GTwcbZBQNq3HY14b7tolGMlm6+rA9jg1Gd6IsnXmacmMNxi5S1fNO9THQMzESVpE0Qutp9CwkvbUjmDU7zATbkCb55Vzq3EZpiGBAlleXqIUrjpnmZE72REWiKOFQtqux0Vws4oWnopsFZFVsHmswM7NEgo7wT6AF6B48uFyV6idD+cBHC3COY0v3omFdG2+elqJCyu299muMqYoc42eXmaF4ZJMRR423N5pUnxm6THDYonreV2PDPnjtgRpX5lyfhGuN/zRnEUS3JM7nmnBq0vTRP9dCnTV+aPI6RyipFt1Ex14RJaRi3dpdaq15xOFXX0KDn0w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fz4q5FlTY7kWdtkkjJJnoiPRuorlQY+F99sFPFBajQ4Zhl+KRoCriEtj+jG3?=
 =?us-ascii?Q?kpecj6FZD59xgqUNBO9YoZg4Q6Qy1wwJG/mWEKJR2XLfEuq3ZSeFJWXxW1g7?=
 =?us-ascii?Q?6lHkDnh/QFEdTe/K2ZmkJxGQAfjuANm8/ZYLfoCPR12rYUPzkdg3eoKurGIc?=
 =?us-ascii?Q?uELrBbU36k6m8pVNwX4kaNmKsSVNIWn++ktTRsyGeCixPvxm12GHaQ68k6DN?=
 =?us-ascii?Q?iQcOVIQoDigK5757sk0HsKVRKOYbdjLODsEQLPK7N3qnwj5eJxqeEo6qQrEI?=
 =?us-ascii?Q?/hbICsjtoZtrntDIe00L2/hpM+VfUYI3vFGS8Y8je+XFahlT9v8wbAiA4taK?=
 =?us-ascii?Q?+cXGJfp84ah40tMbwnhVn5NB0k9+muzq7nteIDLLwHr2H7fmG/lIxNhSSGc8?=
 =?us-ascii?Q?Sfva3Z6RCbMN/Vk0WmrpiWReRrGv2UWYO3skvKl7vLgvxCrXGvdowfaqFq0K?=
 =?us-ascii?Q?hfABOLeVDEyVgRj6JPhBCtqlm6vE2OjlXLOpz/U5PCC1dqyYtCzh+yWcafrF?=
 =?us-ascii?Q?W/wobkAiDI7Y7SujG5WFMBL/Erf5ptJ0FIGNxLpiSIV3b5CIhgAXrkmggwuE?=
 =?us-ascii?Q?obVrDiipxidti9I9QgZHeUXapTOkk3Ke6H8DaAshevaFC1dCZJ1nB6Zb3tmF?=
 =?us-ascii?Q?iYdqGuStf3goMY70zb2QVWHtgaMVd8x4t8UhDrHpxqZU3IX10V8M/oNXXDfJ?=
 =?us-ascii?Q?uKZ6XF/QlfZqOHRF8gu5jAxsr4O0sVU2jDcK2FX7s1lCO3zKpiE+dB3M2Oea?=
 =?us-ascii?Q?jxXY8aOacgABtgQpniChFr8O3oz12fgZ9HHLtizBfPl+Pz+nR1nGOmoWVhQQ?=
 =?us-ascii?Q?rb8Ml+oPLDZeb2Xsdha8JV2w2uJjtlbz+zrFuCcS5NaHS31NaHSTxe42r5ry?=
 =?us-ascii?Q?fs88f6oxMBKiC844yODLEw/qwTBMR+VcuTrQnSu7C/liXVYYPw5SillwKENU?=
 =?us-ascii?Q?+/GJYpFIQg6EyocqAUuPb2NL9LxaUk5GbgZjjQaC5oTSr8xh1YBDvrRNF3Zg?=
 =?us-ascii?Q?BQwFnd/3NZRLeKKvzlhOKHhaMVgSLV50eEk0yeoE3mpTbRT1V9io6JUAGLPc?=
 =?us-ascii?Q?5WYWQOS7UdyxAjFGhagdXr4lk8fAJB8uIHDH0hnM843GicXKweK9RDSzbtGA?=
 =?us-ascii?Q?y9EsNc3wOkTwOqFx4WtowXLcesp2gaQFBBazMGfMUiLLIrBwZEJwDVF/WWuh?=
 =?us-ascii?Q?Mg8GfMfHipjKElguZVDmzVLiYnMkcaihMIrL484HuhgvdZ9wEp4FAOe9g0qi?=
 =?us-ascii?Q?TL+AlzoEjXeiGCoC8vQTL2upCukODJEgsQA523OV0skoyaye8flUp0co9vFI?=
 =?us-ascii?Q?VbCxBrfcoWaIrXjrd54/MLWVf+coWEvSfjagoqwtSy+JrWu7Zt9p6nLsCfRA?=
 =?us-ascii?Q?8RaPinWI5Q3pLU1IL8opPXvUFdacHgGnLbDon7GD+O+KpDwDz+8MgJPdasF+?=
 =?us-ascii?Q?98TddFHxTcoWyFfarDbM0jykWPgsbWv5FKylGJE9iWJrdHn41AN5TjrTVd1x?=
 =?us-ascii?Q?N9+Rf0NBrazUQJLgXey0HORNxYMPnmdQoAmjZiB01xTk7ghhk0HLK69UyjXo?=
 =?us-ascii?Q?3s7jg3HnQfl5b3rl3J9Qlk0rzU2tv/9sOdhU12/+0Xv51gQbDL4pgydLMZhz?=
 =?us-ascii?Q?N4GwZyOx45Wz/5HGBYg6cP3WQPwiDvl/W2TxMXnfInroL7rXH0H6U6zdYzld?=
 =?us-ascii?Q?SSO0wIrBhcwBylOzNBa8E7+pNHEqB2M0mPeOk6d1AaC95h3L0ATR+9u37kUh?=
 =?us-ascii?Q?zdow5W7ECxoONFGXeZF9ZPtYCVz4nz0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307510a6-e1fe-4e45-2d48-08dea6f931a0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:43:55.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZF+ZZmWRwRQXiWuM9TMK+Wefltpu4e9Mjif5M7DW6iJPZYV2Wk0NFMGQVML4+g177x7RpdhL6PrQVTrz2WzydqtfHH9rgkGf2MAENeJuA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-Rspamd-Queue-Id: 1826E4A7DEF
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
	TAGGED_FROM(0.00)[bounces-242204-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

altera_pcie_irq_teardown() calls irq_dispose_mapping() on pcie->irq.
However, pcie->irq is the parent IRQ returned by platform_get_irq(), not
an IRQ mapping created by the Altera INTx irq_domain.

The Altera driver only installs a chained handler on the parent IRQ. It
should detach that handler during teardown, but it should not dispose the
parent IRQ mapping, which belongs to the parent interrupt controller's
irq_domain.

Drop irq_dispose_mapping(pcie->irq) from the teardown path.

Fixes: ec15c4d0d5d2 ("PCI: altera: Allow building as module")
Cc: stable@vger.kernel.org
Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..3d3519b8d88f 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -868,7 +868,6 @@ static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
-	irq_dispose_mapping(pcie->irq);
 }
 
 static int altera_pcie_parse_dt(struct altera_pcie *pcie)
-- 
2.34.1


