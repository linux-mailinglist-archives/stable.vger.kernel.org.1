Return-Path: <stable+bounces-252776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGtGLnX+DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35D5968AF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9D8930F07B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390AC3FBB45;
	Wed, 20 May 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZ+Z3KUR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FE3FBEA2;
	Wed, 20 May 2026 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301561; cv=none; b=SEIj8zhSTUlMStRvn+VZcebCQ3aiqPO4Otm/uVpKCYAPajWYYsRCfmrK4EhMpKQrLCWhIcTacFnkcxPMEgu+YI9bafnC9yMubMySsHBbvW3mt+tTdzb4rvcQa94azqH9iOgAq+o3TgrjOXCgF1nv1VZhEtY/4XDbjGrn3znhVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301561; c=relaxed/simple;
	bh=aeH/ajMNHeI8CtZXuXNmKXvSQF27QNCjXUxuFl2EGho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIqHUS/i0uj39Y56bzzObFEAWCOHu2kA3Oy6ZVYEUpsU7nQC8AUROmlcUwtPwofoBjfhV7v62gkscF5dOgLuqUsxwobModGp9NfRsMSBTs34Sfi27gIVOxwncPHOiHgFX6HLVQfXPJDIvdxpRD1XPmv8Ffh9ZdJDltG9TTaH9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZ+Z3KUR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAC21F000E9;
	Wed, 20 May 2026 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301559;
	bh=x1PyW9jBYnVVzX8eCBtq12DFYtus+6iV8KCkmVX9OWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rZ+Z3KURvJsHv5GcNczUNBIJYBRqy0JTxWitI6OQxel1qCbN5A7R6Hb/UoLw0jLWi
	 X+0NmILwWWZuURm0AKCXhF+V0fDhrVUClF0WXUmv8JGcbMzb+WncutVgmuyf3wUXQt
	 nCjP0RCRF08102eTAho0ooYHPWQwyrpDcarzlVRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 600/666] erofs: fix offset truncation when shifting pgoff on 32-bit platforms
Date: Wed, 20 May 2026 18:23:31 +0200
Message-ID: <20260520162124.271579758@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252776-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: 5F35D5968AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit c99493ce409c3b98fec1616dbcf24c102e006deb ]

On 32-bit platforms, pgoff_t is 32 bits wide, so left-shifting
large arbitrary pgoff_t values by PAGE_SHIFT performs 32-bit arithmetic
and silently truncates the result for pages beyond the 4 GiB boundary.

Cast the page index to loff_t before shifting to produce a correct
64-bit byte offset.

Fixes: 386292919c25 ("erofs: introduce readmore decompression strategy")
Fixes: 307210c262a2 ("erofs: verify metadata accesses for file-backed mounts")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/data.c  | 2 +-
 fs/erofs/zdata.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 192c7ed885acd..21476bd6ae9de 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -39,7 +39,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	 * However, the data access range must be verified here in advance.
 	 */
 	if (buf->file) {
-		fpos = index << PAGE_SHIFT;
+		fpos = (loff_t)index << PAGE_SHIFT;
 		err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
 		if (err < 0)
 			return ERR_PTR(err);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a81b6e6aee59a..e438b8c9bf03b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1853,7 +1853,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 		if (cur < PAGE_SIZE)
 			break;
-		cur = (index << PAGE_SHIFT) - 1;
+		cur = ((loff_t)index << PAGE_SHIFT) - 1;
 	}
 }
 
-- 
2.53.0




