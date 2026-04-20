Return-Path: <stable+bounces-239937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJUDE7hp5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:00:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD50543262A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAF9316EDF5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFD345CD8;
	Mon, 20 Apr 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1z4873Ve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B324346AD5;
	Mon, 20 Apr 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701752; cv=none; b=pDrmPG8TsF0MLiw/99wETn58ii4UViRP9fgWbs3foAeDhTI/idA5iscg1iOYVQpujhZRp3Z1J0Q/DOLo3x3+TtGvRkOu6nqjwsWb/to0mlVO7bNVK38AQupqBbmwBvnp9NdUejCllVmEP7cqv0eH2HOLsjCY4ri+IVd4IOldGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701752; c=relaxed/simple;
	bh=SIqvaC9CfY3BIJaBDtKgy/jvX0cblkLvaucgB80aSuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef7S7/xYJuzma4VS34mPg0Q27HUQof/fLbAf1Zamu7uCs8L03DQF0D0sLgiE5Ka9LGXOEV+FhNG8IaUcPRkzRkzlVFf9arsmiZp3RQWaoCP77racJnx7z18Mns/r9LGpbm7lU3DSYLLyqWJRRaWEL2l/4L38T7ZD35MVq5Z2K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1z4873Ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE666C19425;
	Mon, 20 Apr 2026 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701752;
	bh=SIqvaC9CfY3BIJaBDtKgy/jvX0cblkLvaucgB80aSuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1z4873VeCtAbO9SewZj0WgdLgTzwU6HKLQKRKD4dTIsT/pjMFdFWKYrnBqy0DwZRh
	 8vbEdZ84K38b2sUR7qYCJNSL8FdXP2Y3+0qkGiLtyOPfHOBX8sdH9eqKpykc2y6HuI
	 /sftcKhDZIMi0f08aW4cR7uHM3S8RQTVJxPPrSls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fredric Cover <FredTheDude@proton.me>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	Henrique Carvalho <henrique.carvalho@suse.com>
Subject: [PATCH 6.19 033/220] fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath
Date: Mon, 20 Apr 2026 17:39:34 +0200
Message-ID: <20260420153935.227323600@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239937-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,proton.me:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD50543262A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredric Cover <FredTheDude@proton.me>

[ Upstream commit 78ec5bf2f589ec7fd8f169394bfeca541b077317 ]

When cifs_sanitize_prepath is called with an empty string or a string
containing only delimiters (e.g., "/"), the current logic attempts to
check *(cursor2 - 1) before cursor2 has advanced. This results in an
out-of-bounds read.

This patch adds an early exit check after stripping prepended
delimiters. If no path content remains, the function returns NULL.

The bug was identified via manual audit and verified using a
standalone test case compiled with AddressSanitizer, which
triggered a SEGV on affected inputs.

Signed-off-by: Fredric Cover <FredTheDude@proton.me>
Reviewed-by: Henrique Carvalho <[2]henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index e0d2cd78c82f1..e61bb6ac1d111 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -589,6 +589,10 @@ char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
 	while (IS_DELIM(*cursor1))
 		cursor1++;
 
+	/* exit in case of only delimiters */
+	if (!*cursor1)
+		return NULL;
+
 	/* copy the first letter */
 	*cursor2 = *cursor1;
 
-- 
2.53.0




