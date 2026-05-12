Return-Path: <stable+bounces-246446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKBJIMdzA2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:39:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB388527EA6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E117322B7EF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00982DE6E3;
	Tue, 12 May 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oY2IUD0c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633893EDE48;
	Tue, 12 May 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609249; cv=none; b=Jst+6KJZ5+nndzs9xdiBvXqEA/FX41I9sHWWRfhY8k5dkDaMpMuCM6TwZTVE7yomMLA2PVYlY3QYDr1YtfT9ZVuMc1eXTS3NobXByyFH9N65ZvVGrtJAgP5Oa6o71YjRPNmaDhKgo4KR0acpL+y2uKaK0dtiJpPrdng/rKPig7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609249; c=relaxed/simple;
	bh=GHsqL6JUxJasZGsFFhcjEIsVpfeIngIKscQOh/y30B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1nB6qkWgM7APSddJB6E1EdG1qSdmldnQyOl5UbrjC4toRaG8+4bIQZ1puO6SL8vDiiNPhQ1WupEhubiN6wvDabGlMHTcPWbWj9rwxMlwPaXTZCtJrhj2Vh3t1FLRnwk1dEOnHv2Xwa6Ifnuot9h+7Qk3ziwBaFiizLOlviRijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oY2IUD0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C25C2BCB0;
	Tue, 12 May 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609249;
	bh=GHsqL6JUxJasZGsFFhcjEIsVpfeIngIKscQOh/y30B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oY2IUD0c6TBnTD87ibx26CnpW0C1wSl1vnLOLj7ZUya93PUIBX1VC1R/J/lcleYwk
	 Z2p93SFVGQ2LAZevUk7T127w/zJxUz3CGUOZ1Br9HjOLslMLwBNWE6hmPOwWXqnAGL
	 XcWXfQX0npQUfPo76WK0oZgNkwiWJ5vNSZjXS9MA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Walters <walters@verbum.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 7.0 123/307] ovl: fix verity lazy-load guard broken by fsverity_active() semantic change
Date: Tue, 12 May 2026 19:38:38 +0200
Message-ID: <20260512173942.725345572@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BB388527EA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246446-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,verbum.org,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Walters <walters@verbum.org>

commit 0c8c88b8eb82a2a41bec5f17c076d6312dc40316 upstream.

Commit f77f281b6118 ("fsverity: use a hashtable to find the
fsverity_info") made fsverity_active() check whether the inode has the
verity flag, rather than whether the inode's fsverity_info is loaded.
This broke ovl_ensure_verity_loaded(), which wants to load the
fsverity_info for any verity inodes that haven't had it loaded yet.

Therefore, to check that the fsverity_info hasn't yet been loaded, use
fsverity_get_info(inode) == NULL instead of !fsverity_active(inode).

Also, since fsverity_get_info() now involves a hash table lookup, put
the more lightweight IS_VERITY() flag check first.

Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
Cc: stable@vger.kernel.org
Link: https://github.com/bootc-dev/bootc/issues/2174
Signed-off-by: Colin Walters <walters@verbum.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20260505224257.23213-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1379,7 +1379,7 @@ int ovl_ensure_verity_loaded(const struc
 	struct inode *inode = d_inode(datapath->dentry);
 	struct file *filp;
 
-	if (!fsverity_active(inode) && IS_VERITY(inode)) {
+	if (IS_VERITY(inode) && fsverity_get_info(inode) == NULL) {
 		/*
 		 * If this inode was not yet opened, the verity info hasn't been
 		 * loaded yet, so we need to do that here to force it into memory.



