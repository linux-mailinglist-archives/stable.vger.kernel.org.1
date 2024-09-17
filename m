Return-Path: <stable+bounces-76561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A5F97ACA2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B59F28CBEB
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427815746B;
	Tue, 17 Sep 2024 08:11:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0D156880;
	Tue, 17 Sep 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560713; cv=none; b=RjJeiFE6nzmorgy974WIgaTrnpKp43MzfU3QtLv3D4pXfGlayhUzOiO9VR60aM8du6PN4hr2shoal9aB/okhWTAKXCdW0aH0+DLbcjCUjPs+rj6f+eCUYvt+Dugl5rYvTxJ8mnCrfmC5Uw562UMsL4nmV1/URwpypjGZZ/9nACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560713; c=relaxed/simple;
	bh=a/1tz75QzdpcS31Z0CzWe5FpET4xO7cfK9BF2WGH/9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvDcQsV2mpVKSNgel6si+lfUxAneesaGbPdlKsT9E0hZ/cZnsKQ0v35pYdQOcfboufG9dPmZPaqTodBkqk6XQ2NXNBaNW4SYASDWFWIH07aknK9bdffpATQLo+wN9n7C+/KsPCjBzl+7LQU6LdxNwyadyQElo8EuW6KadfQ469k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X7DyJ0GDsz6K5rH;
	Tue, 17 Sep 2024 16:11:36 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A9B4A1400F4;
	Tue, 17 Sep 2024 16:11:42 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Sep
 2024 10:11:29 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <alexander.sverdlin@siemens.com>
CC: <Mark-MC.Lee@mediatek.com>, <UNGLinuxDriver@microchip.com>,
	<alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
	<angelogioacchino.delregno@collabora.com>, <arinc.unal@arinc9.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <bridge@lists.linux.dev>,
	<claudiu.manoil@nxp.com>, <daniel@makrotopia.org>, <davem@davemloft.net>,
	<dqfext@gmail.com>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <linux-mediatek@lists.infradead.org>,
	<lorenzo@kernel.org>, <matthias.bgg@gmail.com>, <nbd@nbd.name>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
	<razor@blackwall.org>, <roopa@nvidia.com>, <sean.wang@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Date: Tue, 17 Sep 2024 11:10:56 +0300
Message-ID: <20240917081056.1644806-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
References: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> @@ -1594,10 +1592,11 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
>  	}
>
>  	/* Disconnect from further netdevice notifiers on the conduit,
> -	 * since netdev_uses_dsa() will now return false.
> +	 * from now on, netdev_uses_dsa_currently() will return false.
>  	 */
>  	dsa_switch_for_each_cpu_port(dp, ds)
> -		dp->conduit->dsa_ptr = NULL;
> +		rcu_assign_pointer(dp->conduit->dsa_ptr, NULL);
> +	synchronize_rcu();
>
>  	rtnl_unlock();
>  out:

Hi, I am a newbie here. Thanks for the opportunity for learning more
about rcu.
Wouldn't it make more sense to call synchronize_rcu after rtnl_unlock?

