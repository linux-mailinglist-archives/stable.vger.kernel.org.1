Return-Path: <stable+bounces-227394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBWLKkV9vGk1zQIAu9opvQ
	(envelope-from <stable+bounces-227394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:48:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9FB2D3BDC
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74D8307C191
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39A3F8DF7;
	Thu, 19 Mar 2026 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ntbsmgrp"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807D43E49E
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959646; cv=none; b=PBxFbN1pkt9mW2I8MquxmWNttoIcwRTYpUOKFlTUVXb164Vs26i14eYu0c8V6GVRRqhiSEnUaIOBKaIeyvG62+k/uNa5mHhuR4DihzzH9/Qbk6k1NeVyp7PIRJBZuJ/6+Ndykoce4d73tYfL6vcEWF5lu0fAiv1sj7o9N5473mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959646; c=relaxed/simple;
	bh=3Qv2zT9NqD1JiNMn2HZomKx5PufddmrhISbZrI6EHXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl+/jN83E4RYBLexWztII7jWwsHAlpCUCHhol/wiltjLdnCyyIPRkdt3v0OeDGJxtT13usVCTt6wRJxyDpGPgNGOaPiKsWdCDP7uFYTpHjXIjEhwhIqeG3JiU/Hi5zGr8ggLDCj+UPRyXoKWMEFuKs5xH1cxsINu8KTX2XSIxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ntbsmgrp; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773959644; x=1805495644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Qv2zT9NqD1JiNMn2HZomKx5PufddmrhISbZrI6EHXk=;
  b=ntbsmgrp6ASbm4dlAN2bK+mxr7MDG1db89vyeyMHj+KolI+fcQcYp6TZ
   Wq9sW6Y/LM8i94pdBt/GuzZyqO47PhNBw8X+49DaoOAs3UclUjSer5RTI
   nzN7IqUUh5snvjfzhXRQttNlmXGiUsbDdtQyvYURKYKcDtwA6OGxJucqE
   e4VnXOwpOYB5WyHoZpJzDFobIXyTfsHne+x7D5wOxyIcLXt0/3Z1YYYiq
   FlnpMVBiTK1jjUh00UZbtR0qVq4HCAZckMln1Hc0DRaXSusm+lZQgvJdc
   gEC/htHP+m07PaFYuVi6VbvHw7EPiGFbL8vYKy9s8c1tTupZg5Psdrdgn
   Q==;
X-CSE-ConnectionGUID: lDMaIXO7T0iW0ucHOjaU5Q==
X-CSE-MsgGUID: n7iEirdQS7WgEl96QvaAew==
X-IronPort-AV: E=Sophos;i="6.23,130,1770595200"; 
   d="scan'208";a="15202570"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:34:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.164:2525] with esmtp (Farcaster)
 id b22efc1c-6853-40e5-80f6-1d4121482b98; Thu, 19 Mar 2026 22:34:03 +0000 (UTC)
X-Farcaster-Flow-ID: b22efc1c-6853-40e5-80f6-1d4121482b98
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 19 Mar 2026 22:34:01 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.36) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 19 Mar 2026 22:34:00 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <ap420073@gmail.com>, <kuba@kernel.org>, <patches@lists.linux.dev>,
	<sashal@kernel.org>, <stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: [PATCH 6.1 148/280] selftests: net: amt: wait longer for connection before sending packets
Date: Thu, 19 Mar 2026 15:33:39 -0700
Message-ID: <20260319223339.31004-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026031920-switch-coat-6f81@gregkh>
References: <2026031920-switch-coat-6f81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org,amazon.com];
	FROM_NEQ_ENVFROM(0.00)[zcgao@amazon.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227394-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5C9FB2D3BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Here is the reverting patch:

https://lore.kernel.org/stable/20260303143750.57741-1-zcgao@amazon.com/

Thanks,
Nathan

