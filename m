Return-Path: <stable+bounces-54775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAE911385
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 22:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23B928185B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89E7581B;
	Thu, 20 Jun 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="lKfjTQxM"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter06-out31.webhostingserver.nl (mailfilter06-out31.webhostingserver.nl [141.138.169.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20B5EE8D
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.169.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916115; cv=pass; b=gCMHGfAZ8Rcp9fi6p9Uy8XNlO4v+IFS5Pp2pJIdguXaov/nWO0kTq9lkDSJ6EZyQIl6VHzNWQTnOP16jkizK6EWdavpRyeam3ziSzgyx8zKf2ETo/XUx02DM0saQOzaRKaaNtroehRtj5brthvcURtnZgWU8BR7fbQwwSOFOtPw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916115; c=relaxed/simple;
	bh=2LfGQsiTfKh7G/p03O+Vr+UYtMgWtbnVWvSWFL9ixwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW3rtBwiHrli3KIxj0TcvfN9Rj9RebEjwGdDgYm0KkVbTvS9OjGXH1GeWhWqaSJ3i+WCq2YYKtrJrk2E/FwJ5MRVaRWT7lLcETZ6//iyyk1+svYDtz7HmIEeDOHU0NqNaLkLrDIRZ6HhJ/UjdAEYZ2gyz0Hx1gqhFO3tCn/2A1c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=lKfjTQxM; arc=pass smtp.client-ip=141.138.169.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916044; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=DIBJNlF/7sYFBVmECmPGxK3epF/JAZOFck9JZRkKTxoEGcPQWgPqFenyhDLsWHhQEk9T6HU/9LEHi
	 AhGHAW0PfLpoi3GIbKLdfhYq0c3vT4s3Dm+hwkAoqr+AnNb+jPB+GuGWHByeQEg/RQXYz1/UZqgxCE
	 abr0tNqR4G24mTJ2TW070oumeKI380r0swe3/kKoJnxoWDT8Ay2FMFQp1XP6g9n1Y792jvSUZ92Dcz
	 WKklw+wQabjRnGirV30TUT/jZtABFDdZFGbgP+j8XPI0X5Ho+DuhprLDkPw9sxqIbAieV/GBrSmAyk
	 GoIiTNxYP/F/GpGA3Li+wPuj4J5ZSsg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=FsLnuFLGe0haxXdGehDFQL/y8+K9ZmLXTG4uRUF1/zo=;
	b=Bn4/OKN3A7NA19dfI6ui8II6bCVsYhELe60i6kx2MY6Ib1EISe8EFJAJvKspmjSGL9ha8poPo25rj
	 bkysbx3aXfhiflFoTQ9gkz6hLRQRBlnbTPoP7VGk/aXd4uDjQy97HLlYpkZqJNSxTEPsbIRRJGFG77
	 K3LTpmHLpftWTDRdilgs2dgUYMf8aIksMSm8TgzqPeDaWZIZHDwwtEHDj6omhX4cSuGb2TxZp1vP52
	 7foJ4WYcvVhOiJONf/UEIBS/QlD7PPa2xgR0N08PHeYvPuyyMJtrxVtaaifB0LYczbpGr448UbzXkG
	 MMD+MjmB4pnUoyGkxz9qiFeV4goPGRQ==
ARC-Authentication-Results: i=2; mailfilter06.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=FsLnuFLGe0haxXdGehDFQL/y8+K9ZmLXTG4uRUF1/zo=;
	b=lKfjTQxMd40s22s91x2niTfqbTmK2j5FC6LvRfmvj5fAUOL0lCXs0zEladHDsWAF78G42sCBuJgmy
	 J/avCq5qeT5ZZfsL66Fs4uginmTrKo0KW1N1LdOQ4TCkmlfUT1pJcnE3Q8ThjO2FaONErexWa51kMb
	 Fk9mWPI8H5AsHKH/axRGUAVUgbuEX56ZXq49Hwr/ioi+4/uFSUjRhSrU9lMCE1AnTPSdls+Crdari/
	 EqZZvr5BR5womKDM/kU9pp6XaouACgX76E5b4nd+LweGtjNnn+h9iHmCC9Hs3RAO2dQ8/oTx1V6/HH
	 vPxhKaDmA5rIlR2u6yfMEXHe7xDpu7A==
X-Halon-ID: 5c8f9e2b-2f45-11ef-a465-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
	id 5c8f9e2b-2f45-11ef-a465-001a4a4cb958;
	Thu, 20 Jun 2024 22:40:42 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916042;
	 b=XKbj21OChAstn4hJjYm0/lFYJ9YUFrKTBmmZk/L5c0PVsEwPopJ1UvJpuXxssLFfzu6PZZ5jYs
	  2Ga1qBgyVntfnmzIvI3Gou+427IxImA5x5lHgtREUUR9LKg3w2aceO2vMnT06OXyadOcapm8zK
	  d/wjMsR98fXKTtwyr1PQQSnVOJYgzTDnrLiPa6OKxvimtpPRlmjLuOEkmHHhVm9+GIQ70yYMBm
	  z7qp8OqB9Q7wv/TbzCPwc77ayWmtkz7CW6ioBzuSvdNXzxt0p/yGph9kMK3QX6Qigi0888l1FC
	  BDobtVPMWy20Ak2DYCjUmrERw4V03FaJsIoWhKaHEmYC1g==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916042;
	bh=2LfGQsiTfKh7G/p03O+Vr+UYtMgWtbnVWvSWFL9ixwc=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=kdOexz7d0KolgugU+OymvcIwmIXUOQ4VTE9btnGJde185fBspiwBwYe/ynRiveWTBN2g0xdvaz
	  t0nZDal8JwR516/SbmtM3ZUPTGVB8Mz9tzjRSLOPj0ER+ArKEUtxvGUBf2wLvFyhQe0QL5BOR6
	  u1YF4vEZsDDwu8CVkCAQejPxR2PhrqLiu/DlN8tOhUVtl4Ah5sE3+Dm1NCzALB6RjnhN2cxZN9
	  XgXsqYQpq4lAG8grMeFVdm3SWgPZp8RCQCM6vv7DRLyOKVMwzauiP0HKYWmFE4riO8wfOph8rs
	  X6BB3tS9RNtmY8BQVYRV5fpsUsLVNK2ZFozk4tTfuCNhCw==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOaI-0000000CPjK-0j4N;
	Thu, 20 Jun 2024 22:40:42 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Justin Stitt <justinstitt@google.com>,
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
Subject: [PATCH v2 2/2] Revert "usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach"
Date: Thu, 20 Jun 2024 22:38:31 +0200
Message-ID: <20240620203954.20254-3-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620203954.20254-1-ftoth@exalondelft.nl>
References: <20240620203954.20254-1-ftoth@exalondelft.nl>
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


