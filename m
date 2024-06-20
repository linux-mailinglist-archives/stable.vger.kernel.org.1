Return-Path: <stable+bounces-54776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2091139F
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B60C1C22010
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418467350E;
	Thu, 20 Jun 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="eF25cACS"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter06-out31.webhostingserver.nl (mailfilter06-out31.webhostingserver.nl [141.138.169.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0143D3B8
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.169.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916542; cv=pass; b=AgDUMcqcqlUbqFxQWSGtzBEW9BVmIUL4reCIh0lpbOWr1A5/ueT2qBUYgZMSa4ZlwYCvozBUyTiR0QORw7nGUdUjwNcZOf6JAH+KcqKc0/5IQtQUYNIha/XyPwQqo1LTghRzcdGXv84db6t5UwNYegK7k6QtnIopdJlU0TXGQ8s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916542; c=relaxed/simple;
	bh=WQfWA9pWj28tAnlp6qKhzkPBbr49eLKCYOtBIHbxdV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odqjuXy6LZ4Gl5KA6dEAi30hcy7iaNt1yz3sPkCnoXeWfi99yk1JHlsPcoXuPKyHNhOqajXGEY9QnPzxhOIHwZ0OYrT/5XoaCpXiudS4jMW9b1xcKI6BMM0CB+9EVxFD7tExr5+zWnUS2kGSC5CCOXCLWwhIvYw0hO63WazaYzo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=eF25cACS; arc=pass smtp.client-ip=141.138.169.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916539; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=ex0miRf/mxahNEN7I3F8iCuOTSc4QjAQ6oWZxEubI0T2SYKr7szAYzNfXWnBZoUe9o15faPvGn8V/
	 ICRbZqq39EFJCLoMxyL2/YSBUZFv4xe3QnYrcEH6tZM/5yjZ89FvyqoxxZEdSL8G8iO2/OvnZoqx1J
	 va2/oO3d+17Xap/SFfqPEKXbtjk4WTa4NnVRd9s21q22RxckYDEAQbNqwVBjIEIx+T4ElUCa59Opyk
	 NnzaeenoV6Hm+WRy09H85FzUSA4hVipgAcwfPgzAk49+j2WhCCffgSG2nvevdNDlkktVgirsi47AA2
	 GTmrmNDf9HCHlRXg1f7zJiOLlWciTsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=hpVoyD7kmqYLshDxr0INMLqaN4QtxrWTPaOq424wxFI=;
	b=i2iKlTGh45w0iI4ZClvtjEMDtnmo7geV8bQ6+xRhjISa1Ej2g3x/iNSFEdUZ6m/c2PhD0kBNTrqzP
	 fkxSoRb4b9FbTDkqwdkaZohMP2uihLtqQ/ZyusaLT/bBocj/fOPgT6E2I4S8cEU7VazocxaWMb3eC3
	 c7xMZEUlcegGB+2L9nBW030+xdaV16QAGnkm73XJwiwAZx5AUil+UIkRg1O+KwkL6aZZyCduDQuCPD
	 Sn80AfzA9Qb266i7IfKXOWgEj/Y2+9w6Sms7i6rSuegmJbvN71I2GP9c3CqMPXiZ4aj0tFVK2pO0ny
	 OhAi7uT1okpyjzY8Uy17oM8fCEHu32g==
ARC-Authentication-Results: i=2; mailfilter06.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=hpVoyD7kmqYLshDxr0INMLqaN4QtxrWTPaOq424wxFI=;
	b=eF25cACSkn8vsZSZMyejrB//nSjAj3RiFY/RQ5BFVZJGWN+mDkerVotmXiBMFrgLizjVOf+jMvIdU
	 X+PSATEU2SCm6elCXNNXyd0JQHtCglXfnu0SI/3C9XAj8K87XOxZvrcSIn4Ibz+Grh5vbzIuPFBA3j
	 7FqP1ZyUdrofmgQHZgnEqncfprT5i0N77MnMKyP2FJ8OT/6okZ+KS9dE13VgRfhWLs1lW2gylU05LL
	 i7nA2T37Ha1zgIQkWJs5qJW5/KJF83MXkmX3QfCnidduy+x3x9GErDSw3PIfnuLOhODZ09bNYXvkko
	 ZmljHvnlrOO7ID3byHq/w0x8H6BOmlg==
X-Halon-ID: 83f0936a-2f46-11ef-a465-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
	id 83f0936a-2f46-11ef-a465-001a4a4cb958;
	Thu, 20 Jun 2024 22:48:58 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916538;
	 b=K7W8IqVmlaBTwhQR9+b0mVznqP0jBZIkosp4FG/FwcEEAiupT4PWchpn9rOh40IsvsC/JDPrpi
	  PaSv9zoqTdneidFslUUXNkWlBH1/8BERIYOCA3sf+2me4wk0W78OTOgT0VHIVjThpNQ/RCUEgp
	  S/PGnzPS6yFozeZJCEqOE9Hu0Ii1uiF9q+AsC5IYSviPGqUfW0VhXJOltEIp7/Tg6SF2qTFRQH
	  bN/IJAi6w1Q7/FhW3epM/mguIJfWaXXeJJie8gP03QQTBXaVJMqX9Fdqzwgi1fwBSL6/d0rFwJ
	  BI69oMvuDJ44tACkLRChQbVVZct1/ki0eTUay5Iq6F4vMQ==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916538;
	bh=WQfWA9pWj28tAnlp6qKhzkPBbr49eLKCYOtBIHbxdV4=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=IJbC+57ik9ruD4X8y4l5/XiSaQd/vZ5KzOvKeWQFm2eCtjDr3bgM5W3yosgFQeRPoZ168lGFEb
	  qzMVrjqMbcFXghyW93C9mGbdtiq6Qu8FIiuNp2dKZITXkU0aQlrDqeQKD8hWesc2UH3LGSYmUR
	  esGBNIVW5NjQxNlm55mQ4H5cD8qU9a/t+YQZ1ldrHBskGUvyR8Mb8OoQ7kqeTBpk94NSSVfpAE
	  DTnEiqm9rZ6EdCWEvBiWfQQvQbX8AikPk6u5Ykwj9t/ORlnaVwIumvIkLlOWhRoc50Evwua9vu
	  EzHhIIgFw5/Ca4KkxWpClTAUNvQaKVcF9KOzubnSJEzBAw==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOiH-0000000CsKj-2yvj;
	Thu, 20 Jun 2024 22:48:57 +0200
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
Subject: [PATCH v3 1/2] Revert "usb: gadget: u_ether: Re-attach netif device to mirror detachment"
Date: Thu, 20 Jun 2024 22:46:41 +0200
Message-ID: <20240620204832.24518-2-ftoth@exalondelft.nl>
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

This reverts commit 76c945730cdffb572c7767073cc6515fd3f646b4.

Prerequisite revert for the reverting of the original commit f49449fbc21e.

Fixes: 76c945730cdf ("usb: gadget: u_ether: Re-attach netif device to mirror detachment")
Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
Reported-by: Ferry Toth <fntoth@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Toth <fntoth@gmail.com>
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


