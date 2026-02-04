Return-Path: <stable+bounces-213754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBRhJMhhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:12:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F14FE816A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1A8830576C9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C52425CCD;
	Wed,  4 Feb 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+OHSyTp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE258423A97;
	Wed,  4 Feb 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217395; cv=none; b=dXGttkPPHDPDd6cUCEiu6EbZN7u9BLy0mtZ5VtMOPgKqXqIKyxen3m7mWhpLeQBEUPFACqA82JsQb5Lc+F4siB6htrUFB8TUGUpnbcSIDEjAAVMxN6h5X1NDY7Qzcd2L6T+lq1sLLj63loJBQkcqu1up4Dq83zfmrn7d3lg6jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217395; c=relaxed/simple;
	bh=58fBoT+WzU0p9Hcl5z7b9wbOZGL9fpdtlbXd0288OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIZdPm6wgKRPUqn8hcifi9ph6EdGysgWi2iwc9dNjVVx1n8UEERIpJibm6PL4/YBnheT92xMMVWMO1Sri60cHXlVTalkk6tdZgYJtfNO6sjxp3+rSrtcHi/BtXlfj8GKr7H34WiIUz85if7HAYhHe282ib/a2YdNwAmJvpbN5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+OHSyTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5EEC2BCAF;
	Wed,  4 Feb 2026 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217394;
	bh=58fBoT+WzU0p9Hcl5z7b9wbOZGL9fpdtlbXd0288OBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+OHSyTpf+1aKKrWDPFHVrLTRUiqbkRi5Y8sdywBsy9KuXvKlQNSQeeCp03IvCV3Q
	 DfX99IuLC+Yd6w7c3zJ2iEFbk9YlNiPbP7QxgPI+vHwKnKTtBINnmgNCsHqn756yIt
	 osW8E1vQshEi1wbf6HTEZoUyG3i1uoOXZgnqNTv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jouni Malinen <j@w1.fi>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 203/206] wifi: cfg80211: fix wiphy delayed work queueing
Date: Wed,  4 Feb 2026 15:40:34 +0100
Message-ID: <20260204143905.540805147@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213754-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sipsolutions.net:email,msgid.link:url,w1.fi:email]
X-Rspamd-Queue-Id: 1F14FE816A
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit b743287d7a0007493f5cada34ed2085d475050b4 upstream.

When a wiphy work is queued with timer, and then again
without a delay, it's started immediately but *also*
started again after the timer expires. This can lead,
for example, to warnings in mac80211's offchannel code
as reported by Jouni. Running the same work twice isn't
expected, of course. Fix this by deleting the timer at
this point, when queuing immediately due to delay=0.

Cc: stable@vger.kernel.org
Reported-by: Jouni Malinen <j@w1.fi>
Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Link: https://msgid.link/20240125095108.2feb0eaaa446.I4617f3210ed0e7f252290d5970dac6a876aa595b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -1624,6 +1624,7 @@ void wiphy_delayed_work_queue(struct wip
 			      unsigned long delay)
 {
 	if (!delay) {
+		del_timer(&dwork->timer);
 		wiphy_work_queue(wiphy, &dwork->work);
 		return;
 	}



