Return-Path: <stable+bounces-225178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKLGNLUhs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:27:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5B27915E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6EC3043D09
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3564373BE0;
	Thu, 12 Mar 2026 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNIn6VFk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C0318EE1;
	Thu, 12 Mar 2026 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347250; cv=none; b=PhC/W3KtdZUbo1qj/nABQ4H6BI9EnZ3wIQ/toDRNLonIx5K/yJvMZKrpTdR7DOr6WhEF+Z/ssrow8y0tBRGDi+QUspBe7x+d2N4kWZGVVjS71a+SaPWizDffZ1RvLs+Pf3g7H5thmHIsi4VtnDtCHW1+qmf+R29+fx/+IQBcKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347250; c=relaxed/simple;
	bh=YTI6yM3vxVwVO4kiJsUSKeUE6c3FEkkuzW2ZCCGbfiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJg4+GwNmJKEW0kHBtj3WoebN9XwH/mNhdJhj23Seu58i2ajgAyDx6Gct8mu63ioaZ3GqhPth2r48OEm5yLdE+stHAh0A9hKcgHq4cYKehNNUjpu6xVE6aqS71bUfPp5rTJwN80/ZgXGanhMJ85ykfEWmaSTb/ZAPJu8uPEOPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNIn6VFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1039C4CEF7;
	Thu, 12 Mar 2026 20:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347250;
	bh=YTI6yM3vxVwVO4kiJsUSKeUE6c3FEkkuzW2ZCCGbfiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNIn6VFkJDsKw6I1XqrWQPKafwiUdp8n8cuRx7Q8DcEEMb7BGbLMdgDVk48Mk+92e
	 9+Wtfr1gFsZ2aucI4TPxEwf1ptpd9q9N6fdhsv09uXMtog6w5oom4bJBQxQlecytit
	 XRsJFO9DhvffIUTZsMuCNrywOVo1CHxKbe20mu/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 243/265] xsk: introduce helper to determine rxq->frag_size
Date: Thu, 12 Mar 2026 21:10:30 +0100
Message-ID: <20260312201027.115340445@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-225178-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 68D5B27915E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit 16394d80539937d348dd3b9ea32415c54e67a81b ]

rxq->frag_size is basically a step between consecutive strictly aligned
frames. In ZC mode, chunk size fits exactly, but if chunks are unaligned,
there is no safe way to determine accessible space to grow tailroom.

Report frag_size to be zero, if chunks are unaligned, chunk_size otherwise.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://patch.msgid.link/20260305111253.2317394-3-larysa.zaremba@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xdp_sock_drv.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 27d0068d0b704..997e28dd38963 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -47,6 +47,11 @@ static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
 }
 
+static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
+{
+	return pool->unaligned ? 0 : xsk_pool_get_chunk_size(pool);
+}
+
 static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
 					 struct xdp_rxq_info *rxq)
 {
@@ -296,6 +301,11 @@ static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 	return 0;
 }
 
+static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
+{
+	return 0;
+}
+
 static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
 					 struct xdp_rxq_info *rxq)
 {
-- 
2.51.0




