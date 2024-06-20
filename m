Return-Path: <stable+bounces-54774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0BE91137F
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE641F23C5B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25F6F307;
	Thu, 20 Jun 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="IN01Xz3Z"
X-Original-To: stable@vger.kernel.org
Received: from mailfilter01-out30.webhostingserver.nl (mailfilter01-out30.webhostingserver.nl [195.211.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE359167
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.72.101
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916099; cv=pass; b=Brt68S8o1BM7ShEEoHeYLiXGSvPMqp1beFuTk0sAuqKnfXGoEPIDM3YFjLoDNDBh8gHsnz6rsFU227ZfhfRuO/7snIYtNjHD/APP3RuFw9j4n9psqgZQ3tywShS8dGYSCB9Tk1QTPQn5/H8H7du9HgYHH7QTTeXDPpRw//PlK4I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916099; c=relaxed/simple;
	bh=0LxJ/wU5deDOnAL0gaaMov0d5yoYltHA4deqIeDYEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVv5lEvzljFlPiX483VAsS4EjkFx41/65EjeEO3r1TyCAKq/UVh0GOS1zAbaYD2bBBeH0sJuprmHTQMdq/f4yvQhQJj01N71MYEiE37Jt9snit25uTSJAIlNmcIMFC/Z38XKH+EYmIgF1zkUyII2hCrQmBhvu97iNAdaDlnXaxA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=IN01Xz3Z; arc=pass smtp.client-ip=195.211.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916027; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=CESL/oFkjGvCqHNXxH+zW2j6qryvpA+yqMKYLwfXhfNmUCHsBn7Zc0A8X3NRWlRt/WmhcIVscYdTD
	 7l9T8+v9xjdHoam/G8x0fPiZ/ktL2S5TjgzZQFauFnHW0lPfjun1uIr8vyGVQjAYtpAda+JFPJ0ud/
	 440dYEGA8KCQM/7anCCI6tlfKsk0LOGwWXKdeEsgvLg+/omUYXRmzQ2XLVSZFtFHw2O2f7LJuFcZLZ
	 KzPV6WCkdyrTWOLr9jxq4u4nlgqO6xVAaVQ+/suTbni7SRXWHYqLuR6Uh3uoLFQy9T83Ii5M+lT0oq
	 wBs4slJv9MdzdnlhtRiMNEOKUvm42eg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:dkim-signature:from;
	bh=EKI97Lvf28y1ymmuneD6FlzohhD+JdA8V3mE6I22kuo=;
	b=T2KNHMTfXTtiqBk4r9MoiNtwhztiMHjjH6sa7HIjp1CCOEjng3xIlAuENe0/tc1fLI/Qhr8+mw0vY
	 xbjRfI1lwClGCmL043qNRm3l7gp3G7UN3SCvTDDRkrHt19W93PjBqVdXqxaoGshpXHvy1PpvdxVcwh
	 OB37itMe8qiCVxfDWlTt8Ti/6Tm79Oy0h4vlanZw2h3jBiErin0cd0xe62rd9mveKirwjaFr5qKEhQ
	 dWUT5xOYMz2CpOe2Xh/KqhYfaKk152qgoTwPHJHoN7eJFsdcqB4sTjkkRGtAM5le5OQj5cH5tf0uJ1
	 d3HZYa0r/0FwzFV0KWB1KkbemnpwM2Q==
ARC-Authentication-Results: i=2; mailfilter01.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=EKI97Lvf28y1ymmuneD6FlzohhD+JdA8V3mE6I22kuo=;
	b=IN01Xz3Z+fde8v0b0TXXH8QlldNmerLqjfdloySAMH2xiNUVlFzAJkgHNiykkHabD4lkq6FYt6InQ
	 cqX7PMXCz+0kv5A64Z1w8xfBu5tijzPWJvWcjwnY1tHaU6Ztm96um4WiQn6PrMsn5UCKGjvhZgWXqb
	 /zeJqxLsx652aobWxIfyVBfmOXk0OS1E5/392rv5TiGRk5hltmc+Ork0zRwgKlPN9nAZKP64mCrJGe
	 +QCDgfhSVWAganLeoQ4AdFhyjfXZuc+6CsortQOQtP24dME1Ifrz64B+aKO/TdmcENWxu57GEGSWG7
	 20H/yYHuVquDRP0yfaOtfFx25YoSr6A==
X-Halon-ID: 52b7374d-2f45-11ef-8d21-001a4a4cb906
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter01.webhostingserver.nl (Halon) with ESMTPSA
	id 52b7374d-2f45-11ef-8d21-001a4a4cb906;
	Thu, 20 Jun 2024 22:40:25 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916025;
	 b=JvTSQErQLLgb7IA8p3zkaKqn0gu70rBno/jSqSAp2Vz0GGbg+YxzjoQJAswx9MUobyivCJHdtP
	  CK7RTaTxwBGG6oQb0FZwSZ+5XKJWpN62r91Q+oJ+Tf27qOlPI1Y0uaRqM5cjgGo2GC5ZyQZgdd
	  hB2IHB7K4fCGr5k5GmeoHxPrEHDtxhWRtx2H5kjMUugxVDxVQi6VTdWoViy0k3a20sfqJBgweN
	  sPCP6GDUbW6b4EVAGgzbRvrAirnsNhQn6mkLssATds935BhxzZfFgbdp/xKFBANBTsVZioptTb
	  PwkElU9uJ/+MjsjWNVPcVLrur9okWlzQ22UOHfK/OHZGEQ==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916025;
	bh=0LxJ/wU5deDOnAL0gaaMov0d5yoYltHA4deqIeDYEV0=;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
	  Date:Subject:Cc:To:From;
	b=shS2ybvnw8pzX23x8sD59m9FcJuycyCZBo1yv8oTvgzbEzKZXUJSws5JrS581JyBS91t50vGkk
	  aMN507HOxve7l9ltQ/pKPBFPa1iAe5ovRx2+h/CJDQEBkGaR3RTwHWXXJ964mDa06uZNf4f4bc
	  UjFm8RCNLgCQbxzGjARy+yl5bjAhV8Q1BM/peQe1LAkE5XCdGXaDKRCxwrh3YK9B4iwnhX3RI8
	  X8HZ7XrE8kOJdUA3szX9p8Us82r77zfTCND8eIPonpVyr5wdVcZ3Qcbb9bf5vi5Ycu2VLaMG1P
	  L+vE7Gv3xxsR2sn64gtZ8JidBms8kcnxzofYQBwQ1W9sTQ==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOa1-0000000CPjK-2hJn;
	Thu, 20 Jun 2024 22:40:25 +0200
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
Subject: [PATCH v2 1/2] Revert "usb: gadget: u_ether: Re-attach netif device to mirror detachment"
Date: Thu, 20 Jun 2024 22:38:30 +0200
Message-ID: <20240620203954.20254-2-ftoth@exalondelft.nl>
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


