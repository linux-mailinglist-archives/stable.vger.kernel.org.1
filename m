Return-Path: <stable+bounces-218375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFxbGolTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BC18F8D5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AA50309B9A0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5E1F03DE;
	Wed, 25 Feb 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWt9wieI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FD18DB2A;
	Wed, 25 Feb 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983186; cv=none; b=c81znteDlqejXbVtpVp1ZdLV4vkFerK0xzM/SwQRsHGaz0ksqR+j4dXya79ljiHVkwSx7ZGZOPIMp7bohBBnsUD+fZ8t/15rJpyaMneCN8jt3afk2H4xpu6fM3+4Q6oDbWvyk4pfEe7M9CJWQov4ZfGtrZak5L/DuzgRfJLEhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983186; c=relaxed/simple;
	bh=vfZCQXY1btQ16dHnfIHsPsMZkongTOLUYLCl4SPdULw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/eeiZjHByuNncQQslOd6YMGwxaR26/EAODvW98vyTMtO4G6csBatRVJqaH5NrJozDBivoAsRyeUBNJnaH8N9biqf6S0FbkuXB4xxb6/VQNPSi60OpJJJovcESdXxyfqIEhAjnjFTpJ6hoF0f5amOSvj8t0PB8pjvyqg83Gr9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KWt9wieI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33866C116D0;
	Wed, 25 Feb 2026 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983186;
	bh=vfZCQXY1btQ16dHnfIHsPsMZkongTOLUYLCl4SPdULw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWt9wieItLYPjVYs0mzMt/+CQZBP6xjMkF6yHwnCtAwBbFN1wgcnos3saEFFbc4vT
	 /5oZDCbC0jXBPzUks14DWGSB4KNh9PNPRA0+tBYO2iPo8ZhagNwkV2GN07DBC/zG84
	 h9WbKoaLoqk4u5OwTqz2zZL1tzvPbNdyJh1jW7ow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 336/781] wifi: ath9k: add OF dependency to AHB
Date: Tue, 24 Feb 2026 17:17:25 -0800
Message-ID: <20260225012407.936884163@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,toke.dk,oss.qualcomm.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218375-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: D15BC18F8D5
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 125e7b31f041cc0a4ede1e42bef69915f0a63a35 ]

The conversion to OF missed adding a Kconfig dependency.

Fixes: 2fa490c0d759 ("wifi: ath9k: ahb: replace id_table with of")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Link: https://patch.msgid.link/20250802000432.3079550-1-rosenp@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index 0c47be06c153b..47d570a5ca6a1 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -47,7 +47,7 @@ config ATH9K_PCI
 
 config ATH9K_AHB
 	bool "Atheros ath9k AHB bus support"
-	depends on ATH9K
+	depends on ATH9K && OF
 	default n
 	help
 	  This option enables the AHB bus support in ath9k.
-- 
2.51.0




