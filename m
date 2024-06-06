Return-Path: <stable+bounces-49931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810A8FF662
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 23:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A9F1C25AD1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AF197A65;
	Thu,  6 Jun 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="LGM/SHI3"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter05-out30.webhostingserver.nl (mailfilter05-out30.webhostingserver.nl [195.211.73.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD11BDEF
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.73.139
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708013; cv=pass; b=KJI0c9zjxqrSmM6Em+drxrR8/i9nQ8XgMRzz8PNuvLMlKssOx+KBfjUvR+PVTvoqIVfnaQ/vKRLjrxqan2e6dIc5bJqIfI8gIhihDBBM9yE3hfCwpLxOjEMvqcuxSYAJ5fn1Y2VyzUXc9WBgq/Ne0Zb5STDX1t/UuKvZ5oJuvqQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708013; c=relaxed/simple;
	bh=2LfGQsiTfKh7G/p03O+Vr+UYtMgWtbnVWvSWFL9ixwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2P5xtdccUTdjG8K5LYvva27Xx3w8flAARk6AIUtFIvaFNMa3B5G6Fes7j3D9gF5Apy98MSiZEPXH1MT+SwCVlkpcr75swkoL3TZx1f+hnrLlM14RsPwBBeDf6F6tcq7kpEqq9tIFvN1qE1P0sGcxHItK60EetJdYySiqPcI/U8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=LGM/SHI3; arc=pass smtp.client-ip=195.211.73.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1717707942; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=Lx1EwviNzU8Ka+W/2IBHCdBXZMMU0gALqLEXd4x2efXAUgHR9mWw04STFQCR0LXN2QlSuLfpdgUl2
	 LWKzkWrJ0bDRXp3aFE8YbIgn+m4f6fDWg+fimtRceidWs/tTb1zpnLLa75SNgElk7RssTJkQgNX+WA
	 Ae/jLrhPhaSxYNNIo0+yP4jn/w4Xkr8OSVl7TtmTweezv/N28YwP7d5kEswvEScZmOWztePSTgrrpQ
	 FJTk6DVBYfeKytc6yQVq1fy+a7DkGLz24iRs3Xkz07i4lxqz4ugXXx6JfTD3y7EjMvINxCSUqpGsge
	 rWYcwblUseCQykuA/L5sRqX6Emlw46Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=FsLnuFLGe0haxXdGehDFQL/y8+K9ZmLXTG4uRUF1/zo=;
	b=bEEb+jbTmBSZsQdvYYsT0BKZSgkaZDrQlVQpIqIT97ZUAlg/DWoFhrc1qVxgKV75ltJGOkFxyCj5d
	 +maXd/waTOdJDLcShonIe27zo+cFKifwH0z4X1nhvagB+8gKzo0DVdZnaR710v1uwycOiHMGVJ+HAW
	 2DsbaTJ1uPu5rkiNdgcSt3DB+xKeYasgvFoawItyKXGeijdN5OqITQJ+mWacyE5VUTVw5+m/wQD2kM
	 lVFA9XECRl63t2f5KF+DKbGCvk9BMF6kMrLKh1SwvkNzvQZlUwrzxCM7raZEpESu/z394CZowJMUUH
	 hr2sWKzarovZ1pAq0GI341oJd6v9+3A==
ARC-Authentication-Results: i=2; mailfilter05.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=FsLnuFLGe0haxXdGehDFQL/y8+K9ZmLXTG4uRUF1/zo=;
	b=LGM/SHI32TNJKiE3G9kJNz7clO/8LLwCawXsXW7xErcuDqIOJLVWb8Vga4qlVKl6HZ+eSZj56pBSo
	 xVoFv6gaBTnuQwv0k7Qe5nSjHaINPPVRZx/oro0BqQrSWyJagleE1OM0HHQVl4LUMYOQKUAS7TwwZ0
	 wLPikjmKJqhlhWyEoVawizIlU+fCOYm58c4wBlgvloKljokxFEwnSozehlTXg0ele1THfQSJdRuIfs
	 YCeiRtkxSFBa2+JO8hMW7oG9FNKYZuxEVB3nCVD6POcJOwYr/B9nT9ZXV5Y9HCR3JgZS8ftEddijxQ
	 2+VYZd99zGrV/P9H8hGFgMYzG0C6CTA==
X-Halon-ID: 878ee013-2448-11ef-9554-001a4a4cb933
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter05.webhostingserver.nl (Halon) with ESMTPSA
	id 878ee013-2448-11ef-9554-001a4a4cb933;
	Thu, 06 Jun 2024 23:05:40 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1717707940;
	 b=jVFg5tSPgeZJgpR42u9PofkZ2CoOYxrsE7PpLuVZSA6KvR+rZGaoQK90HOxWjiVHqz/z9w728/
	  5aOpbhx1P1kaXMuvx5okbRJS6L3/18F6Lnfb7Gfo7Z5UUKRBTFs68DAwyBUbheFRpXtt6g1QJe
	  ub7oQiOObFBKuIO0vT5iJyifMkH3Dga1SSXfnFCe00Rb1mKp1TWf12hoKUq9/WLbhNcMVbYS1O
	  JcTeWJz5mz/p3+R7Gl21Y6vnu9GkGzOXXz5zTDQxsEfo34SMvexzLNPEMkW3ELaPgFGretU43+
	  tZcEqWgSQoOdwuK4nU5GWrT3zwSWVIpj86JVqdWduC21Ng==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	iprev=pass (2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1717707940;
	bh=2LfGQsiTfKh7G/p03O+Vr+UYtMgWtbnVWvSWFL9ixwc=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=gWl5B4q5+s++MRB8Ib8PpyVSYjWKVF2vNydZ7d32FeeJEpJGQTfNJr3wINMlcJsZDnegrYpW+a
	  JHoQj82ra4e4WP18M4xo3sLE+8CMfHUOPx9z/J+RfI1c1+47DVXsKU9RFuRP2RHWJ+XX+55Mxg
	  PClkyFnqdFpL5lmt9F44ZmJSyIPIPgy/Og7UURv+8+QwlYNau2saKqC6hABQxvRGCpt3K010r1
	  qcGw2qcH+2WxLiMyjGnMsD7W8ktGgCY277begy/V+eWnwwm8G3OIMGgkVkHr2oQROHZQGetIio
	  5Qv/CuqSRL4HuS/GP5/TumwVQ7xJo0TdpAm4efXRTn0z7g==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d680:309e:9a32:ec62;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d680-309e-9a32-ec62.fixed6.kpn.net ([2a02:a466:68ed:1:d680:309e:9a32:ec62] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sFKIm-0000000APHI-0BCC;
	Thu, 06 Jun 2024 23:05:40 +0200
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
Subject: [PATCH v1 2/2] Revert "usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach"
Date: Thu,  6 Jun 2024 23:02:32 +0200
Message-ID: <20240606210436.54100-3-ftoth@exalondelft.nl>
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


