Return-Path: <stable+bounces-214079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P2wAy1ng2ntmQMAu9opvQ
	(envelope-from <stable+bounces-214079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:35:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F2E8E9D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF1D31CBFF8
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662ED2D6611;
	Wed,  4 Feb 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqwW8H7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967127F163;
	Wed,  4 Feb 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218493; cv=none; b=O7B1Zmsxe1k736ynnda+K/UTJfFVgWdt9T4MS8LfltbuWILBG2P47fJOrHsS5DTuoZOdqy+awGGLVORCTFcKSipJ9CdwsJHRbW7+HsyliqEXo9qekNAdEHKQfvL8xcbJ5FpYWGi2zRJe8DBHpQ8fJyYZbwoxbsC3U9bzSDAdfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218493; c=relaxed/simple;
	bh=czXbn2t4L6V5d33j3yQsHtb/AtK2dsnTsxmYJvI0Dc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZggnTWI7hgj3Fw0EgUpdatHh5GZ5VOTJ8ooZyxGzd/dHHocv3bnVwVelWNN25cTo27nUZ8lDxyVoZLPEzEH68AgTjv+0bj/LnKjt5Q314g+zLflT/Fav1v5T097YktEiFfPWZFSpgaRhtW9DVh2Nl/0PxqfgnQdHs0AuNEgG7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqwW8H7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8E8C4CEF7;
	Wed,  4 Feb 2026 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218493;
	bh=czXbn2t4L6V5d33j3yQsHtb/AtK2dsnTsxmYJvI0Dc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqwW8H7cWGLgJAg8pBE/ZPOFtUmtK3mbFn+HQO+NHT4j6KwFsVLwU6uMIcfoFL2Ye
	 XYFpkhk7a/pmnfwAvk94d1ejAGOZgqThMQGpCoRW6xWHEkiktU8zeht6vfGxQb4mDt
	 IMnb8I26jzlauVBxYAsG1/93hTpAR1XchVlZsCc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jake Keller <jacob.e.keller@intel.com>,
	IWL <intel-wired-lan@lists.osuosl.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 12/72] ice: stop counting UDP csum mismatch as rx_errors
Date: Wed,  4 Feb 2026 15:40:15 +0100
Message-ID: <20260204143846.061276065@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214079-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,cloudflare.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:url,intel.com:email]
X-Rspamd-Queue-Id: 589F2E8E9D
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index e846246261b94..72e394dc68f4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6711,7 +6711,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_len_errors +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.51.0




