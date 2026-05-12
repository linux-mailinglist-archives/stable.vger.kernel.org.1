Return-Path: <stable+bounces-245838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCJgG+hTA2pq4gEAu9opvQ
	(envelope-from <stable+bounces-245838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:23:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4D52497B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58C233003529
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249F390603;
	Tue, 12 May 2026 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l0y66MK1"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA273CDBB4;
	Tue, 12 May 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602665; cv=fail; b=Y+HWdYfhuHCvXOaGIHn7IJTR8N/B/pesvV1TVLWYJtYtd+QKJlRowLwyOvQTRDNJiIfc6CimJNIQtVpTsoeo+PaJTz9c09pxeNtwQ9rfVK37C7EniNrHY34MDfniJyqktbRF3U8lJH+oLTSLPCGm0cJkUwbjQVGL30bTaEbvB98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602665; c=relaxed/simple;
	bh=BLErYrhlofMyVuQzSac7G5Kp9A7h3dvmr+AX1DgTMBM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5P80sG9SXGtEI6af7NNv9bwKDF5vH7PcY4sy3gmALv667T1xwZSLPyLzFqyyHh+Fmi7K4EE/U9JoVdE5mQClpWZuT7lUypkgfq6oODoo0RAXx9Vu5lr7gYSAzXXvreGCm/vLD8PwY1pLbfn7ny+POgxWwdAwghAuicOm6Pj7Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l0y66MK1; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtRSIS3BtbTqKfq1ZEeUH6vnja8DRTe1hs9FCxTVlnPgB/tcqG9ZZzEGQrTXtBX17CN3dAYg7xBQWL6SR4MKEdqU6z9A8BSeRhGv7SDB22NuHVSNW+mBFgLQYTQh6cQcXKy1JPxc0Q97e0N5bsw/z9ORc+vc2Si3KAfUGof0ulnRMfFtnHmmdhEm0mgrGec75yWfoZNh11edAPlFYR/SWLSA2FI5RmNltP7/rfTA1Ep8OK5bFCdDj8jG7Er9C2qS4cp4w+tJouo/AX23EXb0EvBKyu4KtrHiju2LJWZsCIMIUsCEzARwM+nAo3ZT6xAsYsShdC4N9jKBwUw18DTK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za6grCrNecMkHljJ/y7tcLqNAzMXsmuQ05DMz9OHhoM=;
 b=ZDWxBuaGxb5Bc/mACGA1Px392+/aqigHW+oXCB4S2Spbz0upk83QtWFJZmrl+5Q9D8dKpvhVKZe2NQUZZmjIK8zVVWJu/xE29NgKqzPJycD8kTLDo0PrxmXSfxVE87UmagAfpzbgr23XNEKYafiCzINM0lbamCUo6XqUo/qIbq5bdIF3OnBaE3ur4uQP6idUHypDXugWSMaTb8Lt8MMOVogMBNUkExHqHCG6idl80PmVognMCI/Ieggx4G1uI6sDUBZ//KvBss7sjEYJlMZE5xfwG04nb+Un33wFET8n6OKFoFjjFmFoRV+rFRwAftItH0zMpNxm50HjN33CRFstSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za6grCrNecMkHljJ/y7tcLqNAzMXsmuQ05DMz9OHhoM=;
 b=l0y66MK1NAc6y8jKgYoCu7C2Y948AcUIn2Fzid01C4AUvqx/KzoOGKRToPEGPNcdY5YHhCLXwqLOg9U2QxTVhIrFV81Vh+2DmjDN+4M0uvmORwx6Y4NheTOZbdc6vTWTo6ienpMhXpfne9v8ZryA/ISietvYkclD19SgmGKIKqw=
Received: from DS1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::16) by
 MN2PR10MB4400.namprd10.prod.outlook.com (2603:10b6:208:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:17:39 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::26) by DS1P220CA0010.outlook.office365.com
 (2603:10b6:8:455::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 16:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 16:17:38 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 11:17:37 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 11:17:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 11:17:37 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64CGHbKp1803413;
	Tue, 12 May 2026 11:17:37 -0500
Date: Tue, 12 May 2026 11:17:37 -0500
From: Kendall Willis <k-willis@ti.com>
To: Vitor Soares <ivitro@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Kevin Hilman
	<khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<tomi.valkeinen@ideasonboard.com>, <sebin.francis@ti.com>, <devarsht@ti.com>,
	<vigneshr@ti.com>, <vishalm@ti.com>, <vitor.soares@toradex.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent
 devices of wakeup source
Message-ID: <20260512161737.pflweaz2r3q3nrfl@uda0506412>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
 <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR10MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fba6018-f394-4c75-b13e-08deb041fc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jcZtRxOYBzEWWhz45FPw66szuCtzmXOEfXqxl45qoGKi07TaWx2XdXZZeC37Ov7nuXpEdGN2pwlAdMdhTibe+MJNpOAwVmmkFypZnyXmqjEWgT0nlxaPuClaBeQGg+4gbdfzPV3m/q4OB5EmlckIjybx/Nlv0fRwY46kjuXePrHm99IXeNcoS92CmPsXkIWnoC3EVMK+UDcXnuHGrBPLOQgW37x/k8+KfTtVuFa9GJQjU+/pR1b1YElxfW3X95W0RVTGzowvl+MgjgDZhQTONIYroIHPpb2WtxB+NdmA/ss72cJfOdtKM+P8nJXAI3XcqNxV/MpIabXD5DBov4PX7r2mOTsojtrtQFIfsbeYCpnBmu5d0DIBZn297K93heML8CK1bQLcrkBUShzG6gsF7TGhIBjmDoJF2aqSPzXksPwHjwhxKfbnLioUNnOBebWJmMryZbVXhBiPakWTvWEWpq7ZazsQf8iqp5bR8merqo6QOTqHkSOqXFQA6b3WovMiQXoHQCleX2s0T+zCKXL626Xi5HTa4+3lt9L8eMdKaf4ZDJJ7VYdXadxTw5a4RD6YjzFHmMlVCLtucDlDmTrHvrVEm0uIXgG54rUsHS55eywp8HPhuHTLoO5lSKBaeE8Q64U2QadAzS+ZlzFrUZxdyfxv/Q8Dv6jm4HUVZqLuzDHRJs8Zt3zAUgAdAjC6VNm+bZWWwQ+YuWjKJ80RnDsjazBef9pihaZKEX3tAOCn2VM=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ip6zbDN6cNE41Lcry5Y03uzfALPOIGwY/ZSooWNYOd6bekFCSBh5fLIVAibxXOtqHVfzI5VyyFZlRNMCV3dtzDXbYUFx+UHM13bAssLrstRnE8Eq7WVZPfG6GrTl9BL3ioQLPojWBrXI4y6Xxvcwk6Z2t51cN3P9qTzR2Upq2IiTsqL0NujDWcwlwGAK1szdkAuLlSyTAqN6Nsvw668Z/3bSGU+uYHNsZoad93b33qvIDSEV4go4UNumduR5HUdriSPQE9R/s2r4IqPBMS9SFHttmOHg9UBDXTP8miqFQOyAX42Z5a2tFrfR49nQgxGzrDbh/UgtW8RN/0uM4vmJ0ChXbtgMTJtbpcw1dpz1OT63LLMFrct8+UQEWMmmLbFFFx9vbPOc4Nl9TkoSJXatAqCZZbdSVRODeCKc+LGL/BmP0fdFWlbyrLkfb4JzPTOp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:17:38.7030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fba6018-f394-4c75-b13e-08deb041fc77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4400
X-Rspamd-Queue-Id: 09F4D52497B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245838-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:dkim];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 17:51-20260511, Vitor Soares wrote:
> Hi Kendall,
> 
> On Wed, 2026-05-06 at 22:16 -0500, Kendall Willis wrote:
> > Set wakeup constraint for any device in a wakeup path. All parent devices
> > of a wakeup device should not be turned off during suspend. This ensures
> > the wakeup device is kept on while the system is suspended.
> > 
> 
> Thanks for the patch.
> 
> I tested it on our Verdin AM62P. As expected, suspend now fails cleanly with "-
> 19" when an SDIO WiFi module is registered as a wakeup source, instead of
> crashing on resume:
> 
> ti-sci 44043000.system-controller: PM: failed to suspend: error -19
> 
> I did not test the IO daisy chain wakeup path, since that is out of scope for
> this patch.
> 
> Best regards,
> Vitor Soares
> 

Hi Vitor,

Thanks for testing the patch! Could you add your Tested-by tag?

Best,
Kendall

