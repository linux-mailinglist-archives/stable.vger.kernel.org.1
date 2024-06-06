Return-Path: <stable+bounces-49930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F098FF660
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 23:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA9B1F2543A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42366199392;
	Thu,  6 Jun 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="H/KoR+up"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter02-out30.webhostingserver.nl (mailfilter02-out30.webhostingserver.nl [195.211.72.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A0198E77
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.72.193
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707997; cv=pass; b=atZa2ObMpkXd/KaZDuG3huHp9feh1ZEaQ+yMLZ8lVmO4igkKmQp2Z9BprlIlibOFSHoGNhutdcp3+du9I3PkxzORtIClDIDkdLGpjkI/9yghct41OT7JehleKJ69vOE5bFzPvQgXMtxySSnUuhujswbPtGC+4LFCye+JOSoiy5I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707997; c=relaxed/simple;
	bh=0LxJ/wU5deDOnAL0gaaMov0d5yoYltHA4deqIeDYEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGuaUcRc5WWS/2MrJVxYuIaxFS41gA9zqAOnN3NukeyD0GMGBalZ6/3JeYxIfrVUeaGqB9Nd19dGNCum05S2rkkdfUZzl2IPPvyUW9Dm/jXnYbrE0EFTmrPIc747ErZ50TTdZq720G3Mt/DTqFthALQxDkF6jCDBIwbgGbyt71g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=H/KoR+up; arc=pass smtp.client-ip=195.211.72.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1717707926; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=ytc3+nhwfR0gIiUH4+Wo+9bA43uPUy0NGMHS6MevCU3vBMEq0xNsecf1eVnwHBThBvlpBZ4LbZdGJ
	 vie2rIMvW9C85LTvH5ap315Zn7GkIa2PRUsEBEzIAQucHahdU22e59nG1wF92xd7+YGtnLPWvkib86
	 lU4+ym9fk83904vUgHCdT9tSfWlwg3MUBd3Mrhbvcwo8CpFHJ+sNtM+s019E6ALppGwwidZwJmXETv
	 BRHtTzliAAwXmdljx5amH6XSUFuu4wLMSIm6Ct58Y+olswp6hkiJWjLcUXTYBNiyQKhc4sViNC3O3w
	 pZRSY/KTczXRWbdOOfuZ6QnZb4xa9ZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=EKI97Lvf28y1ymmuneD6FlzohhD+JdA8V3mE6I22kuo=;
	b=QPtJGxhmNIb2iZqdl+26HdvxJ2TCDaJmokkzx7KGMRBKx8PoovBtZjavO/Vaw1uapXI4wOejmpyVM
	 IMEONNRLIeEeuPVTc5ZEA46UgJr80ga22uSIFOxdJeX2is79q4JQ08TP6ECdPnC/Ort7asSaF8GWy9
	 5y2tR6p/MgtaMrvrvYMfdMp6sB4lnTarpe/UvzbMcKfSleihHODHm5b1eArCESSFqgnzzMJ+sTzS+X
	 36RD/SXCiOSNQWnLt6dLaXC+GrmrOe8U5nGfOZyvoDfCnHGcXFBuqcwP9kI62VZmMm1O+cLqlRlABx
	 lWqp6FYvIHrJdpwgf5mKqZKLrCUdf9Q==
ARC-Authentication-Results: i=2; mailfilter02.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=EKI97Lvf28y1ymmuneD6FlzohhD+JdA8V3mE6I22kuo=;
	b=H/KoR+upqzVhSsBziv46qnRWLxKteKqoD69cbxyiXmqnQeZLVSmmKOt/CqaxJ0xCmRXIclxQOVrKp
	 k8kNwzH40yd6Ql7vqhUVfY844hNzIvTlOp1HVN3w5ekkVDNjFq2t/WbvNYiLMBUeP+86j9fhHcSRWM
	 Gam+drge0E2E8SqN1o2RNhNzVOBKEveTrEI/S+nfBFEd+OWyUIrQp+mm+va27UPCag1X3GjDtg0i7Z
	 N9wh5EIuko3HVp5gJe2c0/k1crGZCdHT8ZOeipsMaTmmYBEIKCtVXzOHtnJvmnxhCbCVMYhMHvt8kB
	 Yq0KKES9LYV3qNMR6yrO1iR+QmYcrsA==
X-Halon-ID: 7db8a552-2448-11ef-ae5d-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
	id 7db8a552-2448-11ef-ae5d-001a4a4cb922;
	Thu, 06 Jun 2024 23:05:23 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1717707923;
	 b=n4Iq1CG8ZkTaWny54ixSQz4ZXSLz1/qAkZp5pHu5f4pXmIsp4DLDMrNOOS/8Veudp29lGh6Wt2
	  R/fykgw1SotcsAdtbhlAPFOnziDLhTYYg+s8icb0v6QiWILB0Etq4qhdU/1IREZ/S/DSUO12wf
	  n9txzLWaQHxsR/wUemyXzR8jLVPx8N4fxjT0xnSq4/DznTGUZeTiEA7fUD1yp5JpCrbZm5PNgb
	  3wROyzW5wpQvD67O9yVR9q4RDP4HhvIv4bRzo/V32fOtDw4DQqHVz5IYzkHrQNCp/rG+AbJ7JO
	  wcv2TK+sd5k46JR8Z6CmmpuIuljrSmxeU9TuNj0NSGwQwA==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	iprev=pass (2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1717707923;
	bh=0LxJ/wU5deDOnAL0gaaMov0d5yoYltHA4deqIeDYEV0=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=qrRyC7X9UFxTh3HkMIBH3zLLHozLUpYJjUsgRamXw9wb128OwZeX0i/G3F84dqx3qbUYslrJIP
	  BbQcq3jv9cJ+H9YkXlV4iaN2vUhVXdbDppOb7dZfoDGz4R4si90kCXmkwKhG0RbpsOb5JDYMYc
	  8lo7+L8V1RDB1I8Pe9i38PLRKvUo3rBj8mgHYDMmI/fbDQRHN93Otw5ej0yANCAbpQf4JWmznU
	  viDM6WFDcI0ocXpStT5uGVUJ4CBc939IuxbY+3j0MPMsqykIA6SR7UliNGabGeL/Bmp5EcTNEK
	  2h4eXClXMB1jvRnGpyBWaZhcBB/eOvA/p59MKS2zLqrwEQ==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net ([2a02:a466:68ed:1:d680:309e:9a32:ec62] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sFKIV-0000000APHI-22yf;
	Thu, 06 Jun 2024 23:05:23 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Justin Stitt <justinstitt@google.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Richard Acayan <mailingradian@gmail.com>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	s.hauer@pengutronix.de,
	jonathanh@nvidia.com,
	paul@crapouillou.net,
	quic_eserrao@quicinc.com,
	erosca@de.adit-jv.com,
	regressions@leemhuis.info,
	Ferry Toth <fntoth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] Revert "usb: gadget: u_ether: Re-attach netif device to mirror detachment"
Date: Thu,  6 Jun 2024 23:02:31 +0200
Message-ID: <20240606210436.54100-2-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606210436.54100-1-ftoth@exalondelft.nl>
References: <20240606210436.54100-1-ftoth@exalondelft.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ACL-Warn: Sender domain ( exalondelft.nl ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info ).
X-ACL-Warn: From-header domain ( exalondelft.nl} ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info )
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

This reverts commit 76c945730cdffb572c7767073cc6515fd3f646b4.

Prerequisite revert for the reverting of the original commit f49449fbc21e.

Fixes: 76c945730cdf ("usb: gadget: u_ether: Re-attach netif device to mirror detachment")
Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
Reported-by: Ferry Toth <fntoth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/gadget/function/u_ether.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 11dd0b9e847f..aa0511c3a62c 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1163,8 +1163,6 @@ struct net_device *gether_connect(struct gether *link)
 		if (netif_running(dev->net))
 			eth_start(dev, GFP_ATOMIC);
 
-		netif_device_attach(dev->net);
-
 	/* on error, disable any endpoints  */
 	} else {
 		(void) usb_ep_disable(link->out_ep);
-- 
2.43.0


