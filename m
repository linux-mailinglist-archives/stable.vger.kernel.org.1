Return-Path: <stable+bounces-217033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP/8HqvTlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:46:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC1150418
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2BDF300E62B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB51266581;
	Tue, 17 Feb 2026 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZlrguF1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9129A1;
	Tue, 17 Feb 2026 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361193; cv=none; b=GqLsY61SWj+5J+CcslmG4QL0xGdf9DhD6vbI8hV0G3pH4nRxg6QLMTO/tFsg98rhieDQFYfwhez4IdMqy5XxfL0MEFGHxu0rFwcMAlFkKZMcW3KhhPovXn/0njPoB9vftxBQ0bt14wOgR7U/IBJAdI3XPh/xdyMB6KhuJlmYv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361193; c=relaxed/simple;
	bh=MmUrVW4O9PNYsaDu3si3+uxqzfkzrTDyYeVOEQyMgW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI/2trHiRXMhDabBfdIOLJ+K04pQGn8xdiSHcbFhhNOkpacFSKuZ63RuA1zvzuQNL9fSzeFq0wCLBF3KrcLblJeYOyLdP8E7W+JagZ6IB5MSJm/ugB3fzPF6K7Fn2ARWNUu6bwgoGhuWXKC8qHvwhQsoQZPPEovQwsC+h2Qdkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZlrguF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D8C4CEF7;
	Tue, 17 Feb 2026 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361193;
	bh=MmUrVW4O9PNYsaDu3si3+uxqzfkzrTDyYeVOEQyMgW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZlrguF1TkOCQkGcz+SXCiGsFR9fC0/GWRujhjmclPezSmG9hsYUvCp/Ojuum0Do2
	 z+vWUe7SOFN+IWWJ7L7BYisMUodk/NmNDBXyan8Z7+dqot0Jzor3/IKtrAYkuRFrsC
	 lIocWNsS7yxm1z1AajNqXGMmAkRSxCbAOuB6IDNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 04/64] crypto: octeontx - Fix length check to avoid truncation in ucode_load_store
Date: Tue, 17 Feb 2026 21:31:00 +0100
Message-ID: <20260217200007.674285368@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217033-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linux.dev:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1CC1150418
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 5565a72b24fa7935a9f30af386e92c8c9dfb23b9 upstream.

OTX_CPT_UCODE_NAME_LENGTH limits the microcode name to 64 bytes. If a
user writes a string of exactly 64 characters, the original code used
'strlen(buf) > 64' to check the length, but then strscpy() copies only
63 characters before adding a NUL terminator, silently truncating the
copied string.

Fix this off-by-one error by using 'count' directly for the length check
to ensure long names are rejected early and copied without truncation.

Cc: stable@vger.kernel.org
Fixes: d9110b0b01ff ("crypto: marvell - add support for OCTEON TX CPT engine")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1337,7 +1337,7 @@ static ssize_t ucode_load_store(struct d
 	int del_grp_idx = -1;
 	int ucode_idx = 0;
 
-	if (strlen(buf) > OTX_CPT_UCODE_NAME_LENGTH)
+	if (count >= OTX_CPT_UCODE_NAME_LENGTH)
 		return -EINVAL;
 
 	eng_grps = container_of(attr, struct otx_cpt_eng_grps, ucode_load_attr);



