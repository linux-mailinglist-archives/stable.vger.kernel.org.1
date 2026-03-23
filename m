Return-Path: <stable+bounces-229137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDu3CAdYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C73EE2F5ECA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20E18302DD6B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA578285061;
	Mon, 23 Mar 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBsik0jH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5FC28488F;
	Mon, 23 Mar 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278177; cv=none; b=n7WE5J67et6pq6PupUVWjed5F2dj80vD3aVaOFQ5bZlAX9jmEcXOe5MOXn1awQ4oVXRevW3LlOzhjNjdKAjoaAcRijzeA9/5nq6pUKMMXBUXi0i2+0v0EIa0uZwcHR6ZY+ESvaVH6ONLEmMvnkQ/8Kf1Zeez1KILXVjTd5BoiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278177; c=relaxed/simple;
	bh=evQ9ivZM7xQes2EtbpfuCKSxWrQ1Sd/MoyBse4lGdBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqAbIP3/idgR2yBO+ep6n13jErn3yvac+fVVGTSxt1fGZMDGZNy1IW3VQRazNtlTib3ZWyVSUClY8JyThz7iu7guRtcVR4DIuM9+4u4sXoAVZQ1eZzJi53IH7uo1c6AGXjazBGjz+RGKwHyl59aOx52ypvOCZPvIqYuWDQt8pEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBsik0jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0197C4CEF7;
	Mon, 23 Mar 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278177;
	bh=evQ9ivZM7xQes2EtbpfuCKSxWrQ1Sd/MoyBse4lGdBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBsik0jHqpvzKKbYIWLFkJt0itIzEyBm/pi56PksSZwy0V40k/laO6HhfbIPD3+u6
	 KvL9/ctqp08thcn1FxSzcIs3QUIEoGDdtPt+Dttgv0FGLz5tCgAkEj7cfTcklarlTZ
	 Nw4/hFlSurE9zqzXQt1Vv8BypkfRLsFe6tT/exm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6 188/567] apparmor: fix memory leak in verify_header
Date: Mon, 23 Mar 2026 14:41:48 +0100
Message-ID: <20260323134538.505442132@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229137-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C73EE2F5ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit e38c55d9f834e5b848bfed0f5c586aaf45acb825 upstream.

The function sets `*ns = NULL` on every call, leaking the namespace
string allocated in previous iterations when multiple profiles are
unpacked. This also breaks namespace consistency checking since *ns
is always NULL when the comparison is made.

Remove the incorrect assignment.
The caller (aa_unpack) initializes *ns to NULL once before the loop,
which is sufficient.

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy_unpack.c |    1 -
 1 file changed, 1 deletion(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1132,7 +1132,6 @@ static int verify_header(struct aa_ext *
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!aa_unpack_u32(e, &e->version, "version")) {



