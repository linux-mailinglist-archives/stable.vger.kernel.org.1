Return-Path: <stable+bounces-213683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMOJEJNhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:11:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F1BE811A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDBC318F7D1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67E42188B;
	Wed,  4 Feb 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/U6Ply1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B27421890;
	Wed,  4 Feb 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217158; cv=none; b=E/GJWZgznbE4CdXcOIqqevf+7W451taLt9ZhsHiZ1+sOk19ttmJNmIMQlUIJTLMQVff4j7b8oXh7N8DH2hdm5SCyUebeINsOg6rq9M9VzcDgBmC4qkc2e0bMfvDt75ys2H6EF4J/kcJYv0Nul/Aky5fCx05o00oLE4SJjuhZqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217158; c=relaxed/simple;
	bh=VMpboJwLIRmyD2GV3kNW3P+AIycb951z1/sueT8vRWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ8/qQhNhyZRLHRn9+9OJeAMelhXWkKRwLFQPxizTSN+AE/7X+jPHpJNxcdu4jKJ17KRvu/x57gerJ8UKt24w3VwdLVvisfK6cffUTq7dEDWUrlTPSb3YPyCnWgU9Oo47Mz2FYtLybidWnaiYxC6eFGL5QrWd2nKsxvCDWt828g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/U6Ply1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278D1C4CEF7;
	Wed,  4 Feb 2026 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217157;
	bh=VMpboJwLIRmyD2GV3kNW3P+AIycb951z1/sueT8vRWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/U6Ply1FqwQYnmtAohNhj5vAOvgHfH7JIJGmTRiBrDIjuSBDsQDQ9izTE4fqQFr7
	 3yOvjHRKuCv708LQqIWWEtFvuefeYVzWghNRmrgSe2XpSf/baeb0qWk36/cMzCO2hh
	 E60vQAE0RJzj98Q6kZew68ioOJu5/EagzywRFtko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jake Keller <jacob.e.keller@intel.com>,
	IWL <intel-wired-lan@lists.osuosl.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 141/206] ice: stop counting UDP csum mismatch as rx_errors
Date: Wed,  4 Feb 2026 15:39:32 +0100
Message-ID: <20260204143903.284706192@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213683-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 89F1BE811A
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

[ Upstream commit 05faf2c0a76581d0a7fdbb8ec46477ba183df95b ]

Since the beginning, the Intel ice driver has counted receive checksum
offload mismatches into the rx_errors member of the rtnl_link_stats64
struct. In ethtool -S these show up as rx_csum_bad.nic.

I believe counting these in rx_errors is fundamentally wrong, as it's
pretty clear from the comments in if_link.h and from every other statistic
the driver is summing into rx_errors, that all of them would cause a
"hardware drop" except for the UDP checksum mismatch, as well as the fact
that all the other causes for rx_errors are L2 reasons, and this L4 UDP
"mismatch" is an outlier.

A last nail in the coffin is that rx_errors is monitored in production and
can indicate a bad NIC/cable/Switch port, but instead some random series of
UDP packets with bad checksums will now trigger this alert. This false
positive makes the alert useless and affects us as well as other companies.

This packet with presumably a bad UDP checksum is *already* passed to the
stack, just not marked as offloaded by the hardware/driver. If it is
dropped by the stack it will show up as UDP_MIB_CSUMERRORS.

And one more thing, none of the other Intel drivers, and at least bnxt_en
and mlx5 both don't appear to count UDP offload mismatches as rx_errors.

Here is a related customer complaint:
https://community.intel.com/t5/Ethernet-Products/ice-rx-errros-is-too-sensitive-to-IP-TCP-attack-packets-Intel/td-p/1662125

Fixes: 4f1fe43c920b ("ice: Add more Rx errors to netdev's rx_error counter")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jake Keller <jacob.e.keller@intel.com>
Cc: IWL <intel-wired-lan@lists.osuosl.org>
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 04e3f6c424c0c..db5319a8eb241 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5841,7 +5841,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_len_errors +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.51.0




