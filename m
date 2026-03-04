Return-Path: <stable+bounces-223013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG56FA/up2mWlwAAu9opvQ
	(envelope-from <stable+bounces-223013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:32:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D41FCA69
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3C53086A7F
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F55347523;
	Wed,  4 Mar 2026 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kYVWF5w+"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B9391515;
	Wed,  4 Mar 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613043; cv=fail; b=AMyf76PV5D37LlHuB/JESVxgcJ/iz2fNR1dQk6To5jhonEW0Hry6g1STvJ/XHOQCRprOKs/2IJ68SPSs+Lz82onvMkH+k9F084d0IKkV9D6lkgG0M4t8Pfj9syY6++PKJqJgttkty5T15kxujiopEF8iWqm/dR+12z/1Rr4Q0no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613043; c=relaxed/simple;
	bh=8CEIrZVyr3DCHjDNj7MYjuBS6/dRhCKAu/QdsE09w6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlqM8BDhHZh3QBW2Yc5TWSEx5/hr/VRCncTqAdbJ/Vnr67X+WRyU85UX9q5yZaCsVrF+RQJGbNRUTNzKheGg+cHJAA38nAyv3/qaViIWWEUrYz9URZnzLjn90oQ4KvF8swJXwrueGIB5f0j6/5xpnri9XFGMb+0s9vGgxdVqfns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kYVWF5w+; arc=fail smtp.client-ip=40.107.74.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsFYU5XeNYWI9jsngC8sfebFYcAYuR/VD1jfU/3VghFSzpcNCKCtTFKuHR+mSFdh+nKHj1E08rU8Fh+rEgK5/Q6W46ZW4BMLcxMb4NIbhzxGhRsaRJEr3yyb0MdzBXbvIxSYTHnvD++K2XxUZ695AWaqn5JsXz/puQIyoH5ZI2lD7utwI33XFNd+PIlhggF8tyCW/3EQzSwjmEv84BtQSIQ0yAuPl2N+F8IiRsW5ITsr40Ue1t8wzwnVhuH8Wg/Y5uHvz6MJVvCtGE/OIFTj9UaVWvMqBbHYtycLIFlJH6zXri0gczNc/tnhQIxBZTV2/VGy5T79Ju81g1NWa04B/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N57HJupNjjjtFoMABIRR4LkUpUJ9jiavDE11y1tUSa8=;
 b=g5HyKP8/pxgIlQksYDA/2tUHClvI6+KuQO2Ucfnd5pBrJ8c0MZ8LGs/k6c9UuVnYgBIUnZHdedLAe4SC+S/pwjOWvaxWvnxa1P9sNcfIsJ2qjKL3lMd27Ab3mrCBWWTNxzHmbOxDIhB0sH8p2aTUuWljMd4MW8dbgLTDz1xAkeHlBFWTwLCg1XxknEsxnx10rgOkQGfyfFvll84zmU6NyR/5hz7TUWF38Bc+kOGSCDnQTnQ9JMvabB4WU4NAk0UKrrnCpawrveDnFausJ8e4P+5+RvFnNC0OeJ9zMnumxKENNaGXYAo9Dk49xB/Offncj3FwWCEZmb6HXnUk4y7RVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N57HJupNjjjtFoMABIRR4LkUpUJ9jiavDE11y1tUSa8=;
 b=kYVWF5w+SuOWvMnuzwdvA66DOcqXwHtz2PKxWZCNJi/nU4wFnoZq9PZTjElJAl/M4RO9FFD3qtoiE98rwM8zMxC1vaKbYgQYcbmEWBmb/3F4Vw3Wtz7wSyI2J0FprA9KjS7KQCyGPp/COJLAaMXZWly9moA2o22n2mxow0+c1sU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5686.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:30:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:30:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] NTB: epf: Avoid pci_irq_vector() from hardirq context
Date: Wed,  4 Mar 2026 17:30:28 +0900
Message-ID: <20260304083028.1391068-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304083028.1391068-1-den@valinux.co.jp>
References: <20260304083028.1391068-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ead8f8f-b3df-469b-2942-08de79c84e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	xTEffYbC9aS7mLKHcszpYAz2fJZuIURGXl2usWnx4pG0RlyaT87grvWjMmVJgnyglg0JnDdtjSKejCrsN53tBgjUPvZVNqJmF4Suhwx0sOPHIZZk5fheDAorQA9Nsx16IsGc1FLppbolXcimIM64wsx3gqtP3hpe7N5WKnWeRlbzbOvK2zemPGJlTL7Nt6/BF9goN5dQXs19begRTpPWpDHLFuHHD24kxdCj8g0bvn5UgL4BA/35E+cq0uIyIu/f67pFEmb3sNKmm2x1XEo26XeYEHR3tbjWJorMIiQSEdLIKZOxtJwYLd7ZUCfrt8RAucdpxh4fNf5ep7+ACqAd5QknVlZ/WOsMqsL1wOETek9petJvLsBjp6niK+I+MwAobSmmM/qTMtSv1ql6S92WDOlIrBUhZwP6s2ez9so/6LMJyOV5SxfauuETdspfeHXJhFE2YfUo/fZo3XZpgCHsBdXkkPNWhEgqbHJEJ8oRnXEfw5rc5rZKKXBHkX4HovvvvYL2ekEAQVSWrhVAjisdIAFyFl9uj0p1E1y6QMQFErVM4ZRcDEI1oAlWI57dNeO6GUmMLHmYGinFJu2I8f6L0Av3gvWP7eoMmvbyUKlrLj2QSSyn6/rxU+u4zdieuDmFWbfkRugYuzyI1UMKmft1jPqigDyXzJfsQGbBjqReBTchnxpzlA48N0tYALPsH36T5CwF8yCxJMauUbjeGFnnOSHBRFaVV6jeLY1SLotTlwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2xIkfBA8A+euvh2NAEmKj+pvFCFSH4rGGTr+8ZlStZnvLiePTtlJMktt1ls?=
 =?us-ascii?Q?56Z3En7sg2kHyc0XzeBQ7OeqweXN63BC4cCi7nABUn0UfeVHBsoAZ6LsBMRx?=
 =?us-ascii?Q?rpW0oex+wXE36/O5ejc194Nsh8CeQr7WRdraUfkfmiYDQko4bElqYRmiUj/8?=
 =?us-ascii?Q?tZs8yRP2FxygZEOn41PtrNTpeQ4iU5ihvZQ/7+fH5SJrZZtVE97xhBkWu3xI?=
 =?us-ascii?Q?blEKOTp0orPheiGceygHkYYJDnfL8ecWiL1jKFn6C35m3EnQQxNMr4y5bxSz?=
 =?us-ascii?Q?Xh8crbVLhtYGxQZoskRrhWg0xFzZlS2vRmb4t8Xcohs39hf9y3quD9IiJXkk?=
 =?us-ascii?Q?qqLfQfi4z8LNcE6//7KvmZQzlML7p3sbrKvEXKYw1KyaS1eGZHcc/PbyMzk5?=
 =?us-ascii?Q?ce0pEBniDX7OddJqKb1jLgqJZsOibnr6SXFJlyOBZlXD3oahXomu6ARJJCgc?=
 =?us-ascii?Q?R8ePyzgz1+qS9NFbiS9wULnh2c+5YN48cAFVKDCSqOfrbJO7wkelKZrplSzH?=
 =?us-ascii?Q?+AYLkS8kc7wn5xMjAdSYLbrYwOkIvmPqkabHFEzZAKESz66qoILUnk382mQZ?=
 =?us-ascii?Q?M9V+iqsYpwiAqcqK2DEQqL2Yzt3vFAiLOmBFa80hiUoeeUnt+EEtRo3+E8Ce?=
 =?us-ascii?Q?4u9+06CU6bMuoT5ZJxkIq0p7y03FqnzARoDyGWZrrd0LEYClClKF1gSZvNJv?=
 =?us-ascii?Q?3XGNMX5gaf4MIqPj6rc5uSHIIb73Dtkdd03RgClwJRFY5v7c+0B36Zf0gFVr?=
 =?us-ascii?Q?X1aXqy8jgZOw/so7KCJEPmmY/hWjkx8vwb+OHS1QpvlAjz2AQnUjPIJvPbFs?=
 =?us-ascii?Q?v0of7zaPZhgZKx5kFiypxlBnpmbdX0iA0ArMy04oGqmWfSWhUfGatQkihstZ?=
 =?us-ascii?Q?mItFZJlr4ws8njbv+HwGRMpSzgnGg5O4Be6ItYp1VcIegq4zYTgMv6oUuPvx?=
 =?us-ascii?Q?R/e/IFnYF1uMrXoDyeJyluMQEr4biFWlNi/DuAJdYBMY6TsV7E2/Yagzybwr?=
 =?us-ascii?Q?8qAP1evYst2WGGsbCD6l4Bl3UdZ0Z6IJoO1QPpWHt1aLesux0hz1ssohk+fc?=
 =?us-ascii?Q?yk6nNYpUdITZWYqWnk0HHYm7mZ43a60J0TS0xpMigPLjAg2g7JI+qCtrz1GY?=
 =?us-ascii?Q?KTk8HWpCVINJDV+Xgod1dvVbOzn95EC4gVyccq3h/Tey/Ua4E78/3r+UV/76?=
 =?us-ascii?Q?RhsRcXCfPusI6lokCkkmF0PRqe3WpF8AUdyXfa/Uy269bJDKEjx9pbEnUquQ?=
 =?us-ascii?Q?agNs+9ZIJOBx5GqxI6SKo6sqMRfkH+o5UmwF8RxOqS/C1QlP0y2zUC2nd+PY?=
 =?us-ascii?Q?GBd/aUBMqw74B/J7L3GUQrnbjusfk4tvC/AzY6TaWoi7wrSfhSXmb0oQbN62?=
 =?us-ascii?Q?bABw4I11R84M+fo8r0vbVaVVctp5a8aa1moSLTyU6XGRBfxiv2jIONKlRBhC?=
 =?us-ascii?Q?z1IcllTep5s5RbSzUBDaG/D13cXd1i3C2Zl1LZjQs2hc/QbdcOlwMp5ULHH5?=
 =?us-ascii?Q?yqOzrTtNSGzpslwhcsSr2nR99LFnem6wLvax1BduZnP6MX4TYyGsI9OECFCQ?=
 =?us-ascii?Q?ECqWvUYcWiJAMF8rpstLYMc+cVE2k+cwLiso9kTBMouZSeGTJLsPoVREqvo0?=
 =?us-ascii?Q?WL41g/xN56PU5hVCNYxyxJoIyQSGpLRWPYZOoki/TNcyk15bulSLcXagUaos?=
 =?us-ascii?Q?bNGCWb7msRN7qzqKHiiPkqao7MzPK2/719X/g5JRMuAeXGMwayE+5HVUpRft?=
 =?us-ascii?Q?oyOCuBG2QasrFVClfz0w0sEG5tKaFK8D6CfcowA2iwNKv4qol0CT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ead8f8f-b3df-469b-2942-08de79c84e6d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:30:34.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6c0a9J4vb+98AGo2737zs0Rz+1dnqnLMaih/d7AJYGEW46NiXdv1X+uNEjqcKDYG1liDNhzBiCCWyc9EeFNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5686
X-Rspamd-Queue-Id: A90D41FCA69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,baylibre.com,nxp.com,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223013-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Action: no action

ntb_epf_vec_isr() calls pci_irq_vector() in hardirq context to derive
the vector number. pci_irq_vector() calls msi_get_virq() that takes a
mutex and can therefore trigger "scheduling while atomic" splats.

  BUG: scheduling while atomic: kworker/u33:0/55/0x00010001
  ...
  Call trace:
   ...
   schedule+0x38/0x110
   schedule_preempt_disabled+0x28/0x50
   __mutex_lock.constprop.0+0x848/0x908
   __mutex_lock_slowpath+0x18/0x30
   mutex_lock+0x4c/0x60
   msi_domain_get_virq+0xe8/0x138
   pci_irq_vector+0x2c/0x60
   ntb_epf_vec_isr+0x28/0x120 [ntb_hw_epf]
   __handle_irq_event_percpu+0x70/0x3a8
   handle_irq_event+0x48/0x100
   handle_edge_irq+0x100/0x1c8
   ...

Cache the Linux IRQ number for vector 0 when vectors are allocated and
use it as a base in the ISR. Running the ISR in a threaded IRQ handler
would also avoid the problem, but that would be unnecessary here.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 5a35f341f821..8925c688930c 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -92,6 +92,7 @@ struct ntb_epf_dev {
 
 	int db_val;
 	u64 db_valid_mask;
+	int irq_base;
 };
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
@@ -318,7 +319,7 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	struct ntb_epf_dev *ndev = dev;
 	int irq_no;
 
-	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
+	irq_no = irq - ndev->irq_base;
 	ndev->db_val = irq_no + 1;
 
 	if (irq_no == 0)
@@ -350,6 +351,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	ndev->irq_base = pci_irq_vector(pdev, 0);
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
-- 
2.51.0


