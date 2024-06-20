Return-Path: <stable+bounces-54777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C29113A4
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21971B20F63
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7334762DC;
	Thu, 20 Jun 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="FFfDeY9P"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter01-out30.webhostingserver.nl (mailfilter01-out30.webhostingserver.nl [195.211.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAC7602B
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.72.101
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916558; cv=pass; b=hlRumE42flBx6J7UkZEeA996P2I9J8CmGZQP3dV0d9zFTa1NRfAlGCDvjVMqlu6odsSkcduQi+8kjejPEKmap4n0PwX6O1g7L4BJhWbCGfjNOCE27gTTdoue/FsqOgnu3QDGaYXRUhcAcbGHg/7ggQ35cWEvqRFcWw50/qRNZW4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916558; c=relaxed/simple;
	bh=Ld5ASmG9FMMRdEUjUfMH7sWmeNaTeG016GMjdzyYZPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9rZT9hbsgDmZdFAmyJwYN5/J1tfIU00fLKPeHl7gcYPc4+dwPUIC1obfR5Gyd495vKjTsUMmaLftCw1NGa2SONTaEdPnsfwvjwJ/IRyD19+OiCU8qHgZR4YVyk5C9XkMKakShPCVuoAGmMGRJcRSHwopOZcowo2qabg6oQ7FhY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=FFfDeY9P; arc=pass smtp.client-ip=195.211.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916555; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=m92bH04fwqa3sjYGaYoEAfoUt1MrkquPul32ssSU6Lz0CoWhvkT8X3nnY4RXM69jYYdSpjlz/e+ld
	 bg2ICijDchpBcV6lW+xHFjMywotWeJJb0/3p2E7cN8PZ6mDJ/f9VsHDgdqaXF6VebxfBXfl3bxhTBT
	 SBVyQroWOJocvPozMWcZIgDzWZka7VOUQWUAOg9sHwomNaTAv/NhKEWQF4i59BRK9/KG+Ek6TXTSd2
	 7VZ4/iZjIrB86DX5nSHoRwGHccLqqf2qNr4OoOeqMOIOhMxrjNJWx7O7wwl/0F1ajjTfV58z7+ca/h
	 tyDQG7p83kHSQ0eow3UrWfUZKGyaIZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=LrKKBuRVYfy5q97eN3qeR+FCdiBw0++yHl2osFhoIYQ=;
	b=j/sVmzw/cUXlHh12MAICtkHLdN1dNeHKDR3d3qGmSYny4JHo36PqTFj4dh3PmO0thnIJlRxl/yBmH
	 fiTgeUP3vNv9wWmWFPIB6urENA+MkOXF/yOz8xJ1yT5DS3I/aRyjF0meKl1LKQyvFtCXOxpnhKcynU
	 kIej+vG4e2fKFK/+d4b8BSKoBj9s/YNr+Ds+epm1Q8vekv2n6mYZS3fXQwSq5b0bWn3sTVT3BwnPmT
	 lgCcxxXrSVp7FSTqNjysHky2DefTDNa1TQ0RUKeSApeyP2IZ3pcjJFONZLW305nXFC9/kLYilNQHtD
	 uo4afIFNfYqZQsqnup6Vaj15oYD1lAQ==
ARC-Authentication-Results: i=2; mailfilter01.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=LrKKBuRVYfy5q97eN3qeR+FCdiBw0++yHl2osFhoIYQ=;
	b=FFfDeY9P6QUEK1fUJmKsIv/7Rv6hML6gXfjCTu2ENdF65pzjJP8Ad2y27vsHw1rtZQ+GvkE9lQBCi
	 c95vkWdChmr8qCq6tQFshnfam7ph9mwEy5xgZeS6vonsApPP0f5FUb2IuLwXDtpUgLl4nCMDseyQmr
	 o6GLC0Qu04Wlnq8lk9u/UcuLJcVeiBsUdgAx3ZDYFaSq2hsWiHhTljXT7pzmLrlgujflO/S3KMQo0z
	 X1nzbPjLlCLaqhjk5j1AO2a/7iNBq3bSJqop/Sntdxi0v0h65SZwilT12DklyRBgOWh0GSXB3TAHX+
	 6psTkFJcxpowAARK3voACz7HO1qMEqg==
X-Halon-ID: 8d18ed33-2f46-11ef-8d21-001a4a4cb906
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter01.webhostingserver.nl (Halon) with ESMTPSA
	id 8d18ed33-2f46-11ef-8d21-001a4a4cb906;
	Thu, 20 Jun 2024 22:49:13 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916553;
	 b=KBrlsz8HN5oKRCKtlZ+iihffjXGAE0tQavr/swym0wpQN6sElCAp7uNgxOtD2MCN3K+5/cF3tB
	  c/KzkKCKf2widX9i82QDKP5184k6aJIbvBxIg32fkJBPLonBS904cn6VPzhZHRnY+5ByrULcQq
	  5tSD9JUFYY5EqLWG0MuH1UrrFkYf2UFdm7mz2jLAfYbQBErmpq7ce2ukLUIxP7AKxnGSEqUYgj
	  6JWORy4PbskWvY9tjlf+kEvYcX1kE/hPYrqA4YFajS3OVc3ErdAVfJMNyA/cRPC8vZ6kzknuYg
	  u6SRhx1M6m0CUUxbZvk8EwImyk/IBNxQtyqhrNkUAFfcxA==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916553;
	bh=Ld5ASmG9FMMRdEUjUfMH7sWmeNaTeG016GMjdzyYZPE=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=ydd/Q4KFL9WsBVly2PEfT/5PWeLVYJ4vqH/T7S/wQNQYNCbrIuDdEdJpQk/ioD9sYBPa5eWCfp
	  2Sqxl5/3UflNmiL86JvecK6y4yZDQ0MLRNXEp3UGsa/mvr5Dky5BPieiMltRo6kNxVVjeKJnoE
	  LeBy7Zuydki0+Wq9XxLijIzCMMjZadtr0Iwzmtb3oGTGHAjWmje/6wTikdPWg4Jv8OfrzP242j
	  p++nvbJeQCC61AQGnvWM+102RgcFVUD8mfzcRA1D73qbvElXXpTOGezXyX8FARiq5fdfEAyB0x
	  6k/bSoHswdcEFQ6EIrRweMxpGm2brcpo7KemmNc7/5v4tw==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOiX-0000000CsKj-0hdm;
	Thu, 20 Jun 2024 22:49:13 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Richard Acayan <mailingradian@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
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
Subject: [PATCH v3 2/2] Revert "usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach"
Date: Thu, 20 Jun 2024 22:46:42 +0200
Message-ID: <20240620204832.24518-3-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620204832.24518-1-ftoth@exalondelft.nl>
References: <20240620204832.24518-1-ftoth@exalondelft.nl>
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

This reverts commit f49449fbc21e7e9550a5203902d69c8ae7dfd918.

This commit breaks u_ether on some setups (at least Merrifield). The fix
"usb: gadget: u_ether: Re-attach netif device to mirror detachment" party
restores u-ether. However the netif usb: remains up even usb is switched
from device to host mode. This creates problems for user space as the
interface remains in the routing table while not realy present and network
managers (connman) not detecting a network change.

Various attempts to find the root cause were unsuccesful up to now. Therefore
revert until a solution is found.

Link: https://lore.kernel.org/linux-usb/20231006141231.7220-1-hgajjar@de.adit-jv.com/
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reported-by: Ferry Toth <fntoth@gmail.com>
Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Toth <fntoth@gmail.com>
---
 drivers/usb/gadget/function/u_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index aa0511c3a62c..95191083b455 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1200,7 +1200,7 @@ void gether_disconnect(struct gether *link)
 
 	DBG(dev, "%s\n", __func__);
 
-	netif_device_detach(dev->net);
+	netif_stop_queue(dev->net);
 	netif_carrier_off(dev->net);
 
 	/* disable endpoints, forcing (synchronous) completion
-- 
2.43.0


