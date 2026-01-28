Return-Path: <stable+bounces-212252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPbkGiY3eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C157DA56DC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18C032633E2
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCAC2F7ACA;
	Wed, 28 Jan 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdzYIfK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F82F7AA1;
	Wed, 28 Jan 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614894; cv=none; b=V4RGiaVjdsURYLT28Gsy6WC5neIYBonu550uIlOSeJJdcka+TX1ZD02b+MD6vfELc0yrRrU6rp8rR5C5GkTd7Dm1hC6lxbNSHIjZXEqeya7D56Vw1YiDk3dMvzl7sLG9m4ZV9oKZM1WNhSTaUNcOtxKjMTBvXTvjDMA25CESZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614894; c=relaxed/simple;
	bh=wkltYFV6hQMXe/ZpwlmGxufIxe6hQKWs5dVf6uDO1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVSaizBeqtZNTOhSqqy0LJjNky94avZdiXZqiTDlCp60NkX8ICOkyheLydxrbZHuVO1J8csRTxKNZ7iXR828OhiZnBRpU5FOAv4S976vDec4TXM/4dUI6HApnGP517326rxaqWOYsMF+uqglKfUdZt2rDIbRJgyquYsyQ9JfJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdzYIfK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1557CC4CEF7;
	Wed, 28 Jan 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614894;
	bh=wkltYFV6hQMXe/ZpwlmGxufIxe6hQKWs5dVf6uDO1Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdzYIfK6DDp932FFo7chl+VU5YrK50dqCNKwR0jHjIQBFCMUYBYi3FKCnM4t3BEsC
	 FaIm072AzNkzBnuuomBtPZM6lxLVqnuQ8N/o4hvHXgKp5uZBLUfKWpt/b0HJiv/691
	 w0ATYZBUuuA9g1Y5GOhjCKtkgF27R26HMm10HcZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.12 019/169] ice: initialize ring_stats->syncp
Date: Wed, 28 Jan 2026 16:21:42 +0100
Message-ID: <20260128145334.709458395@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212252-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C157DA56DC
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 8439016c3b8b5ab687c2420317b1691585106611 ]

The u64_stats_sync structure is empty on 64-bit systems. However, on 32-bit
systems it contains a seqcount_t which needs to be initialized. While the
memory is zero-initialized, a lack of u64_stats_init means that lockdep
won't get initialized properly. Fix this by adding u64_stats_init() calls
to the rings just after allocation.

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8961eebe67aa2..8f8bdc3072ccc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -394,6 +394,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(tx_ring_stats[i], ring_stats);
 		}
 
@@ -413,6 +415,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(rx_ring_stats[i], ring_stats);
 		}
 
-- 
2.51.0




