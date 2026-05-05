Return-Path: <stable+bounces-244154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPIdHvL0+WksFgMAu9opvQ
	(envelope-from <stable+bounces-244154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:47:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C894CEC2B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40549302FAEE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD747D93A;
	Tue,  5 May 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fcmf907k"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4B47A0D1;
	Tue,  5 May 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988105; cv=fail; b=oUlN+XrCmgYFRt9uYG/bgJq0M4PH5gCKV2/LIiZcDYlxapBw5p/xb9HmXMrXHQoqfpPPe6HA420TEP8FcuEqDIV3AlFi9Egr2HKsaId6il7WETOlCjQA7oKxiFEHK8fYTfiUkqGDEF1qBGsGEspvEkLSL2SlYRMJ/6HyzId9YCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988105; c=relaxed/simple;
	bh=TMpC+1OLYiS60ofY1GAqcVd2KGXc3wTyyzUGG4kf1Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p/xtWC6AvZwVPYKWR0mhIZD1SyRcDr2n/ecC2iOlrgYEhbLVG5nMbbL25XuaeZbuKE2X1UFIWByIk2d8xlK06/HKylCJhLDPtVy6zU8SERvakyRvyXs/dSNEvTIIcaAqG3MIPTGoJBt1YdnXlxFB7E98YZonDgHFEI068inoGHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fcmf907k; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWj7KMHke2Nfe/yoM2UCbP7U20KDikA5I9i/bYFofTUUhXvhkVf3K9fk1n+025s4WafjVh7umJYhhJuo+78RcOVnuuR2e3Umjm3cXMK1+uo99pkybG0jnqtseQzbTR8DskFTBZw6QV7lFjW5ECWbqx5ZfQpA+nGd91fkv6AqWX+d3+g7oTf4VEmyRDcyzgpG/zAeThRBMVIFsYvC42Qowo/tJo+yaiOlfqOfqxYtj7X9PirS4b4xVXGQkH+pRMQ7D1FrJA9078nVKwsZEXxawyxxpXn9OLPWzeHYz56o3X1xXOWaTPDac2vQzJpJvWukYVm+UWSbDSKStG48hsTR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjYJ5Joog7Nys4Vxqd+BRsgSTQvk+W4RVfvDAPdBSCE=;
 b=pNVnuKA+RzuQdg17+k5S0YvA3iLFs///DnJc/OIsnjJRh+43vdzRIP0tWfM3jPMXWeLTXbm/IoU46s/xfJ44wzz/oh2AAPj2qet4ZXDZSeVZarPSdY738dBh9YgrE0iAYVAyBDUgduDYa5Af8g1+dtXNZAW3K5muHBLjHP6TFPKA3AOhOQxvj3GkLF+ERSdn6sn+4Q1pt9Bh/hLMnP5ZESYq6/6h2zO5W/tYQ5gydiLIACl7ZeSStYAgS29lbuUmpIA/OFG3QctVrWqEE1tN8202CvgUliRTjW2rbFMg/ayY4ZYc0EKw7h/n55f3CSf56KBQpXBBwByuFxO48/3qZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjYJ5Joog7Nys4Vxqd+BRsgSTQvk+W4RVfvDAPdBSCE=;
 b=fcmf907k4lp5Qcxf78a3F40ePXS3uATwCuROuAQwRzmEZnTwmVwVPDgmqg4OAziHFN4XtqXYfEyZ0SUsXjHAEX83eoug7PevET839XJdWOWSXG79yRwifLmeQoOGSgPJ/hLk+j/O+6LzLTVxXPnxnGEQ3iJ2UmiddE+Z/CZWzJk=
Received: from BLAPR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:335::7)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 13:35:00 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::38) by BLAPR05CA0027.outlook.office365.com
 (2603:10b6:208:335::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 13:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 13:34:58 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 08:34:39 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 08:34:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 08:34:39 -0500
Received: from [10.24.52.136] (gehariprasath.dhcp.ti.com [10.24.52.136])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645DYa9U3061920;
	Tue, 5 May 2026 08:34:37 -0500
Message-ID: <1a379b9a-cd2d-43b6-ab90-c605fff432e9@ti.com>
Date: Tue, 5 May 2026 19:04:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: ti: k3-ringacc: Fix access mode for
 k3_ringacc_ring_pop_tail_io/proxy
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
	<ssantosh@kernel.org>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20260501124129.362192-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Hari Prasath <gehariprasath@ti.com>
In-Reply-To: <20260501124129.362192-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: b335beed-9294-4bf3-e808-08deaaab1a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sbTeJLezMk/LfdLiXd4Gm32C7CBUmcMhRrqdNAvybpNDFEX6hun6Tb49XqgzjqgHFjN7vt0PfNpK1KFI84cZMKuA1tXEoC4XClxouDm+5UO0ZlWx8aaJNI/yE2ZRoIR96w+9f133eR4G5xLzpmtSIV5xbEoS1nFyASIcb9Pnno3SPFwZFDhvext47xlm6b2cYTPZLG8VmEJnjm1m861gFGs93invZzYe2+sy+8xK+sIck6TVlQIuP44SGjGGFbnEts5/5AyhsaFwDXzZsXgVpoLACPhJicNWZG8lYPTxvUJRt33Rdqoe4uVwTh7m/tHRYXcedV29/tFf7fCIMz1SQR1oRlsDmpntMdMl7FK6y4ceVvr4LrvK2F5wWKRoXIJztHVCsmGVLs/pfM3jNgS9qkFmx0V8UfXWzMN4F8wW/z6RQgLEj1aRkKBU3z2hA7mwylMvJLHsRh8XQpGe6wg8CQ+2OdTZBwyAceB2k8nMJ8jBFcS9Gr9ys5F9UDM0mFmJRw3pBw6Vd2HWEZeUQdtPtEfZeOehBm/L86xfumfjDjvFDwnoIKdMdtRxhEJiCepbncRW6hrd9T5hBb7JkaOAg/3u7s5TUVIbU4DE6ekS+o4iXKHvfGD2Y2XtB/dLZoBAZ8mDjiw/8RGbShKpIWBjdOGGhFpVm8q1HHrwNi7fSpJ39lN2v+GZSAdmsiQcBFJUrmYDvIWYQDX/f9/WT9ucl3NbTeje6XHTvFruiMngQ6o=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BLfBd8LRuNeTlOLzSDINBnkZbs/qPNGYz4yuzKNFSqJE4+/KJfCx6LHAEqMQoVD/dAZoImbyG97dxF/AkXKBSl0dmG9wx0oiUHTSCo6LL+N3/6soVgpEpo4AjHGufTnhQqWcDqCWDyF34ZpmKvL2twDqM7LqFURIj0vD/0MCrQLpZ/DgqwK/iAsw5jOrCWiTw67D1h6B8BQp118z/ij6A+2zICi9oXWr526G5GIbme+a+vCyDsveP8CiuF70klgKnTOep3FXr8f6Oq7ImKdcsoIMUle9CclBTDk4vXHD/iLUNoVxH6tjDhOe8fY0MbJlHTDB4kBQ8BPz4uFhKs+P56voDlQaMCcRfAilNVWXsxWN0mifGymIsvnwQiw3GcqkEewR7UJwGs3ug2T/BMQIQNzxk1d6rgY28EDXAyeFcIrc0uXWC2aX4hVB8Ugt38zj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 13:34:58.6771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b335beed-9294-4bf3-e808-08deaaab1a25
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Rspamd-Queue-Id: 79C894CEC2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244154-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gehariprasath@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 01/05/26 6:10 pm, Siddharth Vadapalli wrote:
> k3_ringacc_ring_pop_tail_io() and k3_ringacc_ring_pop_tail_proxy()
> incorrectly use K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
> K3_RINGACC_ACCESS_MODE_POP_TAIL. This will result in ring elements being
> popped in the reverse order of that which the caller expects. Fix this.
> 
> Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Thanks Siddharth.LGTM.

Reviewed-by: Hari Prasath Gujulan Elango <gehariprasath@ti.com>

> ---
> 
> Patch is based on commit
> 26fd6bff2c05 Merge tag 'mtd/fixes-for-7.1-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> of Mainline Linux.
> 
> v1:
> https://lore.kernel.org/r/20260413065125.627180-1-s-vadapalli@ti.com/
> Changes since v1:
> - Updated commit message and fixed k3_ringacc_ring_pop_tail_proxy() as
>    well based on feedback from Hari Prasath G E <gehariprasath@ti.com>
>    at:
>    https://lore.kernel.org/r/d36239c2-98d5-4e5b-b99e-470f4d753a52@ti.com/
> 
>   drivers/soc/ti/k3-ringacc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 7602b8a909b0..e2ca380812d2 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -1012,7 +1012,7 @@ static int k3_ringacc_ring_pop_head_proxy(struct k3_ring *ring, void *elem)
>   static int k3_ringacc_ring_pop_tail_proxy(struct k3_ring *ring, void *elem)
>   {
>   	return k3_ringacc_ring_access_proxy(ring, elem,
> -					    K3_RINGACC_ACCESS_MODE_POP_HEAD);
> +					    K3_RINGACC_ACCESS_MODE_POP_TAIL);
>   }
>   
>   static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
> @@ -1083,7 +1083,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem)
>   static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
>   {
>   	return k3_ringacc_ring_access_io(ring, elem,
> -					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
> +					 K3_RINGACC_ACCESS_MODE_POP_TAIL);
>   }
>   
>   /*


