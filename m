Return-Path: <stable+bounces-224926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE4BBm4cs2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:05:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1D278745
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63ED1301BA9E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2D401A2E;
	Thu, 12 Mar 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9vvXQS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAA2C032C;
	Thu, 12 Mar 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345897; cv=none; b=mrTmVdeq6mIV5KBd1NElNu4z1uOosyC/ggr0LzisZYsJ1ZsNRg3nqRJm3NfKuCSlluPmPLvbjBPt0589vKYoQ5LpXk8bkZHh8wEhhrwOgvL5dv+eWc/m1Wlt/8PRMTGGZdhdYIllc1x1GIzXrCwtnqjt4vQlgj3mcclgEs+whzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345897; c=relaxed/simple;
	bh=DqdijEHRsBZAVoDVUxzZIc9ch6kFKvow//pXumpEVYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN58nAudZskfLUMQ4OfBaN/hYRRvMkxh+0Fzo1/7g6FC8FD1WufCQSbvQLODdWw3vlnijhryEzqAF+LbIfBUuR8A6cpGLlL2pFiU31OHkYaOxKdvxiv+T6FdgOsaRJ6jnQK07IdQGuo+u8oO59eNmDwxTGXATGIXPyyt65fK3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9vvXQS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43945C4CEF7;
	Thu, 12 Mar 2026 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773345897;
	bh=DqdijEHRsBZAVoDVUxzZIc9ch6kFKvow//pXumpEVYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9vvXQS9EJGEGEgurAQgA1ew7BG40v9jUtUM0D61eMfaHWoNaMhNGuYgIRXPo4WoT
	 QewkwlmmWrncQdoTTpdUi6DOUQo++rzcsqNnsBH2f7vCI8Rhusox39WLKy/ynvHrrt
	 Sy3bz3dOwXoUo4YnN8jpowwqSFbDx0vLHIUd5r7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.19 09/13] apparmor: Fix double free of ns_name in aa_replace_profiles()
Date: Thu, 12 Mar 2026 21:03:41 +0100
Message-ID: <20260312200322.014295605@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
References: <20260312200321.671986598@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224926-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,canonical.com:email]
X-Rspamd-Queue-Id: E6E1D278745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 5df0c44e8f5f619d3beb871207aded7c78414502 upstream.

if ns_name is NULL after
1071         error = aa_unpack(udata, &lh, &ns_name);

and if ent->ns_name contains an ns_name in
1089                 } else if (ent->ns_name) {

then ns_name is assigned the ent->ns_name
1095                         ns_name = ent->ns_name;

however ent->ns_name is freed at
1262                 aa_load_ent_free(ent);

and then again when freeing ns_name at
1270         kfree(ns_name);

Fix this by NULLing out ent->ns_name after it is transferred to ns_name

Fixes: 145a0ef21c8e9 ("apparmor: fix blob compression when ns is forced on a policy load
")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1149,6 +1149,7 @@ ssize_t aa_replace_profiles(struct aa_ns
 				goto fail;
 			}
 			ns_name = ent->ns_name;
+			ent->ns_name = NULL;
 		} else
 			count++;
 	}



