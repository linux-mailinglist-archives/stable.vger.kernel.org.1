Return-Path: <stable+bounces-214268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYlLY5vg2lqmwMAu9opvQ
	(envelope-from <stable+bounces-214268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:10:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04EE9F83
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43EA930996C4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371862D5C91;
	Wed,  4 Feb 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOi9kCYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B227702D;
	Wed,  4 Feb 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219121; cv=none; b=L00lvnnEbyX7u3p57opHmZAGvVEXU0B05RgQ4OQY6bg5jOC+cIIC3FgVSQkaWgznsYIRYntFidcdfcGrvQEv2y8TlvOuDVLkb1xxVxY8lyQ+1+EPF9MN5M5IVy1aRyCj2wpZdaVw9k1lPM/EsUMI0y2GJHl+K7XT52ttH5B9URw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219121; c=relaxed/simple;
	bh=eUdMCAcMiJ+Xqdasf0Neum9nf/QzUwBm8o5ZITPdPa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMgOqQwL4/4sf36XSXksfX1YvQoX9711hjZUoWStWV7WcO+M67DHcz6s/xhazUOs6lQRbvxQBFqZxEVlQw9vfFrTzX1zuXRacKY8p9X+edmNpgFgprY10dsz1UI/Vh0DD5iZ9zVavJeCShSObKQqoIqfX3bkgDPbyPKWMB9cJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOi9kCYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62812C4CEF7;
	Wed,  4 Feb 2026 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219120;
	bh=eUdMCAcMiJ+Xqdasf0Neum9nf/QzUwBm8o5ZITPdPa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOi9kCYm8FkS5WytYTCAY7QZqp4xL+2cPJptdDr9aNyTF/ySyvNwdxQuvAxPUSRrG
	 UgZHEYdo6P0kpD55eO4XS2tbMCRK2tMH6j3ngIIMxybLcNSu5XmYFMS9jPyNvFr5NW
	 /rcnxQ2nPtA/IeyQANu/WetmqhsoWcdgSXYnGlaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kohei Enju <kohei@enjuk.jp>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.18 074/122] efivarfs: fix error propagation in efivar_entry_get()
Date: Wed,  4 Feb 2026 15:40:56 +0100
Message-ID: <20260204143854.513548497@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214268-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CB04EE9F83
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -552,7 +552,7 @@ int efivar_entry_get(struct efivar_entry
 	err = __efivar_entry_get(entry, attributes, size, data);
 	efivar_unlock();
 
-	return 0;
+	return err;
 }
 
 /**



