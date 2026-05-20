Return-Path: <stable+bounces-251929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DvjJRz9DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:27:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE1596363
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D41B73255E6F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F53F23BF;
	Wed, 20 May 2026 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdPfeXfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08E3B0AD6;
	Wed, 20 May 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299299; cv=none; b=n1Nrz9grdVtYsDN1MxPwPIjNjWqJWlnMsYdvmiz/ezE1OTjUpafXuXczAAm8Bg113A4Hkc9XRD7V91CnISyQP2v+vBbIdiSa/GjBZwmPDPTujVo3P/JqzaDcGoHqKJuPkYF1dxnHUVEYwc3JfF4ETNAPJ+vAemW6MEM3vuUuWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299299; c=relaxed/simple;
	bh=Th+9Y2/zHXwX4ZAb+rYbBkK+MpO/GYgHu5Q7ZSZ9DVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBL9IHYPHNKvIDQXthYlhtn4Ek08KvWaBGyFXL532sBFiygCqa9+he4Q7Etlm/HHuKBH9FeaYZbVMjpQQZIw6CLyzkOPIzinsBXSGQb55UBq6ekXfJA/aP+djFO0aiWo8k0lrrvW5bdopjhY05XQqQeOcLXdveXBmADgSOKHvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CdPfeXfb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB9A1F000E9;
	Wed, 20 May 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299298;
	bh=rm+gfWPl1Swpq0tTFds3DdtfoPJUuwRzghEGHhKEblc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdPfeXfbq5SZmKShnomerY2VkbcL0SX4IL3dN06oHE6qW7fpOpPvv1hM/PLtzXmq9
	 r/waE0uFIG0akPRCr+B8TMAUCeQdDOBEnMMP6GTs186QvY6QqI1Ua/JXOqMS5+lL+8
	 12r1eJtBVOLDo3F4HY7M1Gcw527i4DwrNfysbJ+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 720/957] eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
Date: Wed, 20 May 2026 18:20:03 +0200
Message-ID: <20260520162150.163307899@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251929-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 00EE1596363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0feaf644f7180c4a91b6b405a881afbfd958f1cf ]

With __ep_remove() gone, the double-underscore on __ep_remove_file()
and __ep_remove_epi() no longer contrasts with a __-less parent and
just reads as noise. Rename both to ep_remove_file() and
ep_remove_epi(). No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5d982c2503d68..68607634a60df 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -830,7 +830,7 @@ static void ep_free(struct eventpoll *ep)
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
@@ -854,7 +854,7 @@ static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	free_ephead(to_free);
 }
 
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 {
 	lockdep_assert_held(&ep->mtx);
 
@@ -900,9 +900,9 @@ static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 		spin_unlock(&file->f_lock);
 		return;
 	}
-	__ep_remove_file(ep, epi, file);
+	ep_remove_file(ep, epi, file);
 
-	if (__ep_remove_epi(ep, epi))
+	if (ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1147,8 +1147,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 
-- 
2.53.0




