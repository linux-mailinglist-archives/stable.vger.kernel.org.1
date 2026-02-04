Return-Path: <stable+bounces-213963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPiJ/dpg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-213963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:47:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85EE95B4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542C0313BCCB
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D099F423A8A;
	Wed,  4 Feb 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UWzcKsY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5E2BE03C;
	Wed,  4 Feb 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218098; cv=none; b=bAu1ztfdC6I6ORj/+PSpm8bFhI49/5/y0eJr+gZY4EdHdqJTTnl5DZ0ziwEVGilMnXmlJPAjKeTNUWEeBqsf/Q9cAOcd8eKwUoKisFkIyPYp2wpINFDtkczEACDH5tEHR30s5dBYPnGLlxbz91l2EZ1DmNOpdlv22e7rx/2XXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218098; c=relaxed/simple;
	bh=WLK4wQ4Tpz1a00GZZLipyOBUPgY2NSsrUWzhn1mQsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK1qE6/CF2wfp5Dy1n+Wt7CyPL0jt8RJaPRWy+TIp45XgdGu+JiPLcA5KSzndgW1x81iujwGNB5h7jM5NS+3qaWXtn4vGUyzTrQOEom6VqVOmpgKSf6+Q/A5VW9bvVuwE3HgXU3H4JazGdAR/BjlAzrp34GtiDQxdZz7sG/BJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UWzcKsY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A2C4CEF7;
	Wed,  4 Feb 2026 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218098;
	bh=WLK4wQ4Tpz1a00GZZLipyOBUPgY2NSsrUWzhn1mQsOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWzcKsY+zrADAlsaqAgxPweSxNbKrbpduEm7vNAvrz1HDrKPQ2XW8Me79OYiKIRcm
	 y+dw93qMLReToZeM9fvofWfVByJlCsOO8PE9B+7HkLMsQSW/LUZTSCGQf5O5Dm7EPW
	 XL/h178aktiDLoB/U4L0k3e4o+0E/xOa4R9oCrLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kohei Enju <kohei@enjuk.jp>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.1 212/280] efivarfs: fix error propagation in efivar_entry_get()
Date: Wed,  4 Feb 2026 15:39:46 +0100
Message-ID: <20260204143917.238431314@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213963-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EC85EE95B4
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kohei Enju <kohei@enjuk.jp>

commit 4b22ec1685ce1fc0d862dcda3225d852fb107995 upstream.

efivar_entry_get() always returns success even if the underlying
__efivar_entry_get() fails, masking errors.

This may result in uninitialized heap memory being copied to userspace
in the efivarfs_file_read() path.

Fix it by returning the error from __efivar_entry_get().

Fixes: 2d82e6227ea1 ("efi: vars: Move efivar caching layer into efivarfs")
Cc: <stable@vger.kernel.org> # v6.1+
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/efivarfs/vars.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -609,7 +609,7 @@ int efivar_entry_get(struct efivar_entry
 	err = __efivar_entry_get(entry, attributes, size, data);
 	efivar_unlock();
 
-	return 0;
+	return err;
 }
 
 /**



