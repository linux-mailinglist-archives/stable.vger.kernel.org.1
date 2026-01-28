Return-Path: <stable+bounces-212187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBwxCxMwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:49:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A91A47DA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5AF53057FD5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EC2D73BD;
	Wed, 28 Jan 2026 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I73KALv5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C902D0C62;
	Wed, 28 Jan 2026 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614679; cv=none; b=FDXVnwr4VQiCv31ItS/Eeob30v073GpiZUMRvGpx8SMOYwrynPZVT9lzTYdCiq3YoRdNswl9jI9Y1/CACjk66l2QhccDR8O3E5W4SgXYJtcIcQpY7iAQKhbS3U+Y+S58rDFYP3ipz2fT4a1GGnpG0J26WFhTiDnOozYi+oCs0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614679; c=relaxed/simple;
	bh=QU0ObblmPn0g5UTEaUGtDIihxFnTNqAN+94Cnc2jz50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0fC5FziSfPR7cDRFYO28LJ1VdRfHKvzWO9p5eFx9TAn8wyi08ySOPMYZcocXYFJYj1/a2fst2rLU86jwll0siGNWsG0Qk1FjAHyxb1paZDh5vltaTo0vzXH0OLn/l1/EpFkeAYUPU9/snW5O30v/T14wwz5qFA7CvrC9PqqpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I73KALv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A179C4CEF1;
	Wed, 28 Jan 2026 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614679;
	bh=QU0ObblmPn0g5UTEaUGtDIihxFnTNqAN+94Cnc2jz50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I73KALv5fUE2DeoY5eRaF/iIwOYrNCR5An1gb8FyKBMe70H4uqGOWM8SFIPKbquWl
	 mEgYk50ictKwe379cmWYBTCzGcrLWc3u/BHffGPh1gh9o/ctElIVgAKAk4FV60kIrE
	 otpHmRVHaK1KnWcdnvQ8psEPJXFXFXJnDaRb5LSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 176/254] net: dsa: fix off-by-one in maximum bridge ID determination
Date: Wed, 28 Jan 2026 16:22:32 +0100
Message-ID: <20260128145351.139153601@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212187-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17A91A47DA
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit dfca045cd4d0ea07ff4198ba392be3e718acaddc ]

Prior to the blamed commit, the bridge_num range was from
0 to ds->max_num_bridges - 1. After the commit, it is from
1 to ds->max_num_bridges.

So this check:
	if (bridge_num >= max)
		return 0;
must be updated to:
	if (bridge_num > max)
		return 0;

in order to allow the last bridge_num value (==max) to be used.

This is easiest visible when a driver sets ds->max_num_bridges=1.
The observed behaviour is that even the first created bridge triggers
the netlink extack "Range of offloadable bridges exceeded" warning, and
is handled in software rather than being offloaded.

Fixes: 3f9bb0301d50 ("net: dsa: make dp->bridge_num one-based")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20260120211039.3228999-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/dsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index c9bf1a9a6c99b..ea30827409367 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -158,7 +158,7 @@ unsigned int dsa_bridge_num_get(const struct net_device *bridge_dev, int max)
 		bridge_num = find_next_zero_bit(&dsa_fwd_offloading_bridges,
 						DSA_MAX_NUM_OFFLOADING_BRIDGES,
 						1);
-		if (bridge_num >= max)
+		if (bridge_num > max)
 			return 0;
 
 		set_bit(bridge_num, &dsa_fwd_offloading_bridges);
-- 
2.51.0




