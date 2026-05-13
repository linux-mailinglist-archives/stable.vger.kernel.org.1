Return-Path: <stable+bounces-246867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGuYHPeDBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:00:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACD5348F1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86EC5302FF86
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E2E258CD0;
	Wed, 13 May 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UvgaR37J"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70956253359
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680274; cv=fail; b=jX/0o/lpa4/wj0TWVMz6M/Px4FI5925Tmkx8FJ5KUcFFj0fsa1ohtrzCOGdS05R5YQgPZj2f8tCWfMegEorI9xxswTnGly1PL9AOQPSsDzle5LyTjT2cMJTe0vyoxvm8avpaOJ6QjEQ7JccbkBbyerNXKCGCONlMkWaw1uIMGT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680274; c=relaxed/simple;
	bh=OgdE9ErtR5jQykuVHUGbNecct8KBsxzXsQ7bAhXYOjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnlUYQ0BwdfeWOVYVhF1Lhct6sMHHOiW9SC4xJlJtzvL//PSIEF5S7/GiEjHSE8Jn/cKNXzJ09UODd+Oi2lIcM7oodxU+Olkh2MgaNafEnL+dBLDSqM4PcLKpQvpuJhWRKnQPkZAMZF473BAHSMpPbPZkci4XR4CYsBQPlUnaw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UvgaR37J; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfIt+KsPj9s/VMVz0CB3GZkFED0m497ChzT4jRiS5Y3nnUo7/cckt26+WGgchkplhMMFDy32DIEsdJ/8L4bVosPBOO9r2aLZLI8KQiZZ9IQf+wVPJqwauJaCHP3ceKZjY4Ee8NT6pXaPbnb0y30NJml4QGCktAtdUA8EFz2Y//cseQO3BcJ/Dc0H2hzIRECSm5BMBROzZKi0rtfeKFT4fQzFtsOllcjxqZ7n8jGwwjVpv0dmLFsI6iSKXgQL5gki7VDWKIMVeWsqwYiuMT46lZdGKKEVYXxhx7CplmsrSeqdUanDC8rhyfo7gaQkMXQ26DaIwaMlsDQBucfA/ZppcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYaUipLfQxVWwHIeuA+u819YnNdHpPdYEzS/7wTgkkc=;
 b=o4pjN5D6CLZUIzOMy7Td7S9aHIp6YX9Y1egQSvfa1ZWkZ0VDwqJpGhoujIDCPf+5mNUZMQ376SqfsCJp+Mu+JKcmHH/jBNW1s3nbrxEOWjX76wHUcqJ+irHq+/vjtohEMgf5OiHnB49GdXJwdOhcREWEFAUkdvWUZf7SQ3Ku2pTJHs+NFYmbZTyVIyjzCc68MgnanaA04VjsmQhM7JDDAF5oF1fLqmr+GMRMLJOCuZx3c8/mzmVcvDe17KUN7bPuibY3AfMZOU4sd9EzOGWEqEw8YNlsWyQpRHjW7R8/46CIsikGbFCulUf3IQAsrF9PvPAHgBYDgDkyNAUozNUhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYaUipLfQxVWwHIeuA+u819YnNdHpPdYEzS/7wTgkkc=;
 b=UvgaR37JBcI3fvNw0pAEIM3kr50jBuxUofNZIloPfcx1if1ViP6ChkZHdbHHRH366I3RKLDhBGZWX9QzdtyGFDeyvTUYB/SnhAYJ4yzA1nV1KV0MEQOFRlwJ+6zAYsBn/HVy5wk0WHMXB3PxGEuhgolfr5MlH8vbsbBgNIZdq9s=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 13:51:05 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::65) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 13:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 13:51:04 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:51:04 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:51:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 08:51:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DDp33M3826518;
	Wed, 13 May 2026 08:51:03 -0500
Date: Wed, 13 May 2026 08:51:03 -0500
From: Bryan Brattlof <bb@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <stable@vger.kernel.org>, Daniel Wagner <daniel.wagner@monom.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
	<nobuhiro.iwamatsu.x90@mail.toshiba>, <pavel@nabladev.com>, Russell King
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260513135103.tt5tqzcxrgjefewr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3224cd94-7f8d-495f-c836-08deb0f6ad0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z3O+pVQALer0U7ciQeMV3m+F70OMJ3mXBJNW+2HFfSYzL8IYSTTLM7fq5mVONR8U36xcQlf9iSQ59XVh2XuUA9Ct5eJ0A1Fdow1rXNqgxeFGK9gQ+oTjGZUGZfCml0t4JNnKIvocezzvKPtPr05qLPx145BEnVTO7cquHR3/uvH3fD7rpJTzHAah0BPEskzTB04YG/j27Fc8o1Sjzi7YzAiBA31GrtRU/4Br5rEl9ZrPKkxPTsxylRY+2yfNNO/2rzAjoE8YVNoStsd34Vq/89XzUX9YBmXpbWpuEs/He6y5H0SBqdey9SP6A6FDm2m9vNZKHdMHLPWiE8/dOz3yCIYPuoz8Lh1utBQ7lRF9mpBzPYPHba+iIC4OktHbsdLGXpO4wIBnEPZVWb5gg6TSHdCm+z6r11LHHXhMhK9UkOxxRVjZSuZoPPYuyMQTwwJePjTr3cFMq4LDS8gvSEbvcGvE3FGVOAD9CSG2rE9AYYESGDOovfSsyhX3t6wKjIynFwQA4NfgDXFwzeoqCNaqTupA5x5SzGbtq5V2ncKD26OJz+HC/8dygifnJfM0ksEs/JQmMxwsDb7Q80QQz8exLwF/tvzQL1VGpUua50gp55LWMtBCaWwNHaka7NTMTqpfSOIodnil9R90Tdx4vnHJ+xk/c6edET2jWB1gxLSCxiHjMYJb3pYpBpf56d+FGuAnKQFqNDzGZN212DMHfKzH6SaZvba5zt1FfoyiFAMeE4s=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wFTbYzEtqdKEW/vBv3dB4cOpFAUaQ197XRYkgtapUajDNcnUGhZA40skGB9j+xFB2SbS1XD8vGdWVW8mYQcTU0pmEr6HTnhUe0SVRwYh3PJmItXMvVR1q3qVLiYnrWYyGxAzh0DTTxmq0ckDsVSUaCNtB6To9P5iiGLgKgN3+ECwXl7fdOdf9AoRkVe4gkQ/lcS1IbGiERdlxFPXH0XkKrSw9Wt6vubSn5il1BlN+PZKNN4blU5a0aEa0JH9EJL3LBEnJTGREyrLL3v4F0yuWW+XGQkkDjAkMWQggO9FNSac3qKP5SkA93Jnf8IiBoTDeS5FWdJT2cbnF+FjFcJeAE3vZfm+X8d5Du+bN0ejFNqx9y9WYbhPTagVDPkpwB5MdD93DDOXWDb4XfTmOTIOg32qwhJkgf4SHR/S79Et8zbINQQxX6pTR6THpQAOV8dT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:51:04.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224cd94-7f8d-495f-c836-08deb0f6ad0c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
X-Rspamd-Queue-Id: 19ACD5348F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,bryanbrattlof.com:mid];
	TAGGED_FROM(0.00)[bounces-246867-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bb@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Thank you Sebastian!

On May 11, 2026 thus sayeth Sebastian Andrzej Siewior:
> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
> 
> #1 and #2 are prerequisites for #3.
> 
> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
> 
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> 
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.
> 
> Russell King (Oracle) (4):
>   ARM: group is_permission_fault() with is_translation_fault()
>   ARM: allow __do_kernel_fault() to report execution of memory faults
>   ARM: fix hash_name() fault
>   ARM: fix branch predictor hardening
> 
>  arch/arm/mm/alignment.c |   6 ++-
>  arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
>  2 files changed, 80 insertions(+), 26 deletions(-)

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

