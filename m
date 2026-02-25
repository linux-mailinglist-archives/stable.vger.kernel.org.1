Return-Path: <stable+bounces-218691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIMTJpVUnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818518FD34
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7B330ED526
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CF265CA6;
	Wed, 25 Feb 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ejhYVzcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B9243376;
	Wed, 25 Feb 2026 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983550; cv=none; b=SJZoCz0AkHfrRF30g3gYORtAIBIIeQGvg//PYqiRo/LXX+KZ91Q4YfuKEEw3gKhKncQkz+WrZYdOMkkZACa6mPMWWcayxq16r0jasuU1kH4M4z13MjlxRuq6A6/kR3cqFCXWOyJekz/O3okBVxjezzrzaeJn0CkFyJF5iYsVFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983550; c=relaxed/simple;
	bh=XaesEADasfBUvHuzRN+9mT5kJoI+GNQGvVvsyx9DWnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfU3Z58oZit6SrBeIQ5v9gqvh86glLP2MV3vyS5Rj54FsCedRMGGJnSEnLwfQSMKyBfT0ezFJyqU7P+buqbwXPTiA63r1F1b5hHElhfioI1rVQvRnjdsmWsJBkfHq/9Cgnxv2DFqRVP6XZZcJWJMrtsrvOlH/9osGmHUV1Y4WXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ejhYVzcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B7DC116D0;
	Wed, 25 Feb 2026 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983549;
	bh=XaesEADasfBUvHuzRN+9mT5kJoI+GNQGvVvsyx9DWnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejhYVzcgEW768xMvJCAB6cMzDWxTcYuocWGYIaqeRemQRl3wxHJREwqHQ+ZZBKspX
	 yqVB8dknT1NQVv79xBnYWwoNgGPyR/lNuQ8dmqWFUzK3idJqa1E+2N5pJbtMw4FnJm
	 xH8EFtgO/f+OpEFdSrC66dDPJDRM/6GUTxVh9dto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 651/781] eth: fbnic: increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes
Date: Tue, 24 Feb 2026 17:22:40 -0800
Message-ID: <20260225012415.758816017@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218691-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,meta.com,gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,meta.com:email]
X-Rspamd-Queue-Id: 2818518FD34
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bobby Eshleman <bobbyeshleman@meta.com>

[ Upstream commit bd254115f38db3c046332bb62e8719e0dc7c2b53 ]

Increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes. The previous minimum
was too small to guarantee that very long L2+L3+L4 headers always fit
within the header buffer. When EN_HDR_SPLIT is disabled and a packet
exceeds MAX_HEADER_BYTES, splitting occurs at that byte offset instead
of the header boundary, resulting in some of the header landing in the
payload page. The increased minimum ensures headers always fit with the
MAX_HEADER_BYTES cut off and land in the header page.

Fixes: 2b30fc01a6c7 ("eth: fbnic: Add support for HDS configuration")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Link: https://patch.msgid.link/20260211-fbnic-tcp-hds-fixes-v1-2-55d050e6f606@meta.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 27776e844e29b..51a98f27d5d91 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -66,7 +66,7 @@ struct fbnic_net;
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
 #define FBNIC_HDS_THRESH_DEFAULT \
 	(1536 - FBNIC_RX_PAD)
-#define FBNIC_HDR_BYTES_MIN		128
+#define FBNIC_HDR_BYTES_MIN		256
 
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
-- 
2.51.0




