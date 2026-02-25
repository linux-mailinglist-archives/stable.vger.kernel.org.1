Return-Path: <stable+bounces-219584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEEGADLZnmkTXgQAu9opvQ
	(envelope-from <stable+bounces-219584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:12:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB491964BB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927123068F10
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECE39282F;
	Wed, 25 Feb 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l3XNqV/J"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCE213254;
	Wed, 25 Feb 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017880; cv=fail; b=kzXNo2Ca3iSUi5ZY8J4EYgRyVYJ54/zF/GSsVOPdgwYPdk0+pW3jjyg3piX8LWWB3/87vqu0GZEJt8+UAtN47JdKkbG554LuCo8duqzEbgDM6tNDBA9F2+n2nsTWZ2r8EVa8iPePripWwN+iLCHtRaTsm301y5aKWcVFnoP7pkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017880; c=relaxed/simple;
	bh=YklfWistw3bHhmveG55kR3uK4hOBVKkZltSnx433agU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3ufFF518CuxHynAW/tA4jvuRhTEFrqZzt3Xtdj5tR/TJGo2VG95ve7jdSnXDS4SMhDpgkBAjPDYph26jC41Jjw9bh677t6hji7iUJdkb5Z3C7YHh5iTzQTx3oln53QFNEyMQ68z6e0n/Prn5RF0gFPe2/NWoJwovjTcbGhxiGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l3XNqV/J; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAHTSrkj3l3yznaZztLh6mfUkbBH6O3t2Gfv6NJRR8sGAmKGzBtT8Gr6bfOGgHyR2hP++fPW/8+emvgT72NhIIxq8OWNPbUsV6qVTWOpD65wb0oaUhe2QVJmxylUDdoEjTXoAy+I0qyCnWWQp+M2IaldQ4s4/9CmLtJxzQ7sDP4bgL7kcqG8C1P6zDTC9aahZH0KlpVU6LkmdqzmUPKTxwoJo/DibMnZ2plczC03YJscO5HRd5HEiK5dRXX/IYTjFWA+evhZeVMWMa/Zo6zrmusCUiM0NSLw8zNz4lY7a/8beCa6ch7XavTgCrTzxG4hdn7nFgH5eNdHdhwAOlHaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Ma+lxDU7ERUeRkk9dh9RNirepwnoT6BNtPHK0qbdk=;
 b=JOxbr+8z3LIJkVlM8/AMRnsPaHwlwC0GTMypeig7Km3lSQkutkuYF/rqiTrKJQpN10yI6KefWvZgkCKCmY+AxE5PTWtEeC6E73wuMFK2Q5sUA/U8MPG46MD1aUDsXJAB/ckvuf4ddzeAYNlr3KgsPUenjkdFQTIp/3QdmR50M+4EapAZPgZyYGSmxz0cYkeQHwDChJJbUum9qTQ2ABmq9pk6RPEGSXzX/8QFcANP22bqkvnbK5cvJSYL7OhYkCcuTKpY3jMCMxx8FmIJiT3Jf89t+U8DHNqNhhwy9SsAk5sfTgkeYXqx2i5cuqtFC4eRllo9Z7f2OYd+VYuJlCvhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Ma+lxDU7ERUeRkk9dh9RNirepwnoT6BNtPHK0qbdk=;
 b=l3XNqV/JiG23IYA+qF73071BTncVla1dbFYRLu2Be6leUANL+y8NkRhcXPH6CKqtNLfTmmNMnt4fdrvI2raumB728rKW7fkGEF8SA/gZrT7/XWv41NbzbQZx1nk54cRieLJ2pLWteebDkGgggTVPAM+wfN+C+pvVcSN9gG0crwU=
Received: from MN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:208:52d::8)
 by DM3PPFBD8703CAB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 11:11:17 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::5) by MN0PR04CA0016.outlook.office365.com
 (2603:10b6:208:52d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:11:15 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:11:14 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:11:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 05:11:14 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PBB8c14039653;
	Wed, 25 Feb 2026 05:11:09 -0600
Message-ID: <166cf8ef-9991-499d-902a-58bd1e227388@ti.com>
Date: Wed, 25 Feb 2026 16:42:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
	<horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
	<vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
	<vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
	<stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw-nuss: set
 irq_disabled after disabling RX IRQ
To: Jakub Kicinski <kuba@kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
 <20260220041431.372610-2-s-vadapalli@ti.com>
 <20260223184803.739c17a7@kernel.org>
 <c9b1c5c2c5f9587c31132586fddb1921ff6824a8.camel@ti.com>
 <20260224155432.15ded392@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260224155432.15ded392@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM3PPFBD8703CAB:EE_
X-MS-Office365-Filtering-Correlation-Id: 82774578-3419-473a-1a22-08de745e97b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34070700014|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	j/tN86ojUqOEFBIhw7cLMG4tg6BPqivRoM1YzyDkwAW5ULJy+Ik65R7Jkv3Vo7+97b/WGOUgx4SV5u1wbZVXmWBLP4ht1iy+k/Pq0vP8TdL6fKDy83vIm8KBE4PrCSy+6Y9TAXakhxr+AUpYI6DO2L37qrVN1U5aEqLI7uAFE7EtG6tgNiK6f16sw8icG01JH54UPKFmO637qm09IQ5ejbAUW1VdcUrqlKvG0Gpog/ehcazyXTQNFVR65/Qkp5f3ObgoOxJLxYH7SOSEvWkEj6ozSYUFW4kaqcWulsbxrTQaYsm29m7Qzlfg4O93Fse5pl9ZlCknDODQ0YmprYULy7+YhpMJ+csxRorX4gONw57SOLrQheSEv1R/BT8MuSTW4gvcpDpRqIiad1giULlxaJXGqu0ovpE7SpjgO/zsEdml89DMLF6yNO5/bOVBn40jIptFfTMLtaT9NbtPPn3MIwCR7o8jcjPg/nEL9sGOUrK7+VDMGHjhAD9RsWqeIWUIlkay0k0C56CvToGavNKrqLpHIuj5YoNueXXZPIJWAu/3D8jUiubMCfMZb228HqwzYtuuG8aEBjB0pDMNyBqyzZ8pdX/gihDFVgzisE0cMAcu6/NcioaV9p62mwG235EFtKwN6wu0SpzYh41wnK+EVkFpEw67FXpISvfHSSKF0jDCakbgVhM0E1wFZVAcvzE2Y4VC/1w+srlkg9lNaifC4Z2HYFfGMAiC6mNXjPlRQdAv9Nbg0z7Ui4abK3aCt9TArPyFjTPDAJevEFoijeFIHa8mHp5nSEa8A/AKAvCo7Vw1jrx7zvXExho4XjbAukK7hqCmQU2YFeoXhFwAfpCmUg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34070700014)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V07cf7qAV8/VsNW5aaNCP8i7eoJetY4mEtb1KWgbFyt1Gsc3K6313fVT7BQB9YXHDpKAEbWRmDLmSrklXNigt5G112mj+71QPtZbIGiZLv3xzXo6X1jNl78D/ugPHKXG+wz6xiPfvWmoZlwoja8bBOpm485Bi0iN07ExLrTTmYmz1mKzbBEx3l88CQLU9T6/VOs/A3rc37pLfCldNjqQmShXcog7/86wU495sujz/eQyvmbQ36STFpM/YcjOvNVaiJ2y/ZV6lU79MTFJ58PLu/ZAiKRj5FU8ozxKFdw9s1d877LNIdVF3dOvfnnP+IFoaXBkK8rSmfkzBWy5Clp15i9CWiMiMTIatWX1fn7HFcBMGLGnGRDN40li3jdW2z91PvRFeuI37Td6MHk2UKwFDzamo3XtXZctlkiYtOjHu2yxiO2l0mDxONDswKSKhhe3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:11:15.3063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82774578-3419-473a-1a22-08de745e97b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBD8703CAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-219584-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4FB491964BB
X-Rspamd-Action: no action

On 25/02/26 05:24, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 10:40:05 +0530 Siddharth Vadapalli wrote:
>> CPU1 sees irq_disabled being 'true' and before it updates it to 'false', if
>> CPU2 also sees irq_disabled
>> being 'true', both CPU1 and CPU2 will enter the IF-condition and eventually
>> invoke enable_irq().
> 
> I think the races are just between NAPI and the HARD IRQ context.
> There can only be one NAPI scheduled for a queue, I assume.

Yes. An already executing RX NAPI Handler (scheduled via net_rx_action) 
sees 'irq_disabled' set by the HARD IRQ handler. The RX NAPI Handler then 
executes 'enable_irq()' for the RX IRQ before it is actually disabled by 
the HARD IRQ handler using disable_irq_nosync().

> 
>> Please let me know if this is what you were referring to. I will use atomic
>> APIs at all places to update
>> 'irq_disabled'.
> 
> I recommend a spin lock, unless you can measure as significant
> difference. Locks and atomics have similar cost on many CPUs.
> And juggling local state, IRQ state, and NAPI state atomically
> will get tricky.

Updates to 'irq_disabled' are performed by:

	1. Hard IRQ Handler sets irq_disabled to true.
	   => Since there can be only one IRQ for a given RX Queue,
	    we can be certain that there is no race w.r.t. setting it
	    to true.
	2. NAPI RX Handler sets irq_disabled to false if currently true.
	   => This is the part I am unsure of but if a single instance
	    of the NAPI RX Handler will be scheduled in an SMP
	    environment as well, there won't be a race between
	    multiple processors as the following will cannot happen
	    simultaneously on multiple CPUs running the RX Handler:
		irq_disabled = false;
		enable_irq();

Regards,
Siddharth.

