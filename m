Return-Path: <stable+bounces-229484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O0/FM5fwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0892F6CCC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EE3E30D019C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC127A10F;
	Mon, 23 Mar 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a626mswN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25222798EA;
	Mon, 23 Mar 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279381; cv=none; b=HHoEuGq95XyuidDp4gBDDkUnYL4eAQ9pKDALjiEmTTdjGWc/X+30miTXFEDJgR+WUjNCCU71t+d6KM/OBQzN6D6skesx6p5DiGYBqdeUNLSbLOnaFLTb4cWLybJdzH0YnXWGeSLCYx1sBDx88KMWaMGNWPe1B1mWtuT0jKiorMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279381; c=relaxed/simple;
	bh=rH8H45XR/jsBU6tocEnGDrbi+T4XXSm94uLLKTIF2ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPoz9xeoTlhDyXeLaPGD2QtK2k0PGqdRcSsnDT1tMls/gF2rh6wH2zg4EiW7y4iNh9PXmQpoMQvRq0P+cGLFwddH7drwfWFpcsTATRLoGUhJKzZvj4QIGXVCkxD/z0h9B2hVn+ibLWNBx6YSZ16kQ9z+IN/+Lkup6rjyEsneNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a626mswN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267AAC4CEF7;
	Mon, 23 Mar 2026 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279381;
	bh=rH8H45XR/jsBU6tocEnGDrbi+T4XXSm94uLLKTIF2ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a626mswNM1ZcRoKntwTyubkmf36k8Z1qKVSTvnoVVXWvZ90N+j/PpujKFRscUmKyI
	 sQ9JhimL5r+BnjLaAK1iUV0am/J2u46i7vVMhSw7fHJqq7keSd8m5do8hTvlEn+eUU
	 bWoZKCNPYfXtfrSpfbIyrNZbzgf2swcglN8J1woQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 566/567] lib/bootconfig: check xbc_init_node() return in override path
Date: Mon, 23 Mar 2026 14:48:06 +0100
Message-ID: <20260323134548.024512476@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229484-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BE0892F6CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Law <objecting@objecting.org>

[ Upstream commit bb288d7d869e86d382f35a0e26242c5ccb05ca82 ]

The ':=' override path in xbc_parse_kv() calls xbc_init_node() to
re-initialize an existing value node but does not check the return
value. If xbc_init_node() fails (data offset out of range), parsing
silently continues with stale node data.

Add the missing error check to match the xbc_add_node() call path
which already checks for failure.

In practice, a bootconfig using ':=' to override a value near the
32KB data limit could silently retain the old value, meaning a
security-relevant boot parameter override (e.g., a trace filter or
debug setting) would not take effect as intended.

Link: https://lore.kernel.org/all/20260318155847.78065-2-objecting@objecting.org/

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Josh Law <objecting@objecting.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 82f21a9b0aaba..675f34cf32f0d 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -714,7 +714,8 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 		if (op == ':') {
 			unsigned short nidx = child->next;
 
-			xbc_init_node(child, v, XBC_VALUE);
+			if (xbc_init_node(child, v, XBC_VALUE) < 0)
+				return xbc_parse_error("Failed to override value", v);
 			child->next = nidx;	/* keep subkeys */
 			goto array;
 		}
-- 
2.51.0




