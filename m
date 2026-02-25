Return-Path: <stable+bounces-218326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKKSIZ1Snmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9518F462
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 022AF3198AA7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6E2417E0;
	Wed, 25 Feb 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5ur/b6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CB18DB2A;
	Wed, 25 Feb 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983130; cv=none; b=pO7IzEriceuIZu3LGn0JQEYDa5jW8oYl5HZs7/CorNfSlljpXsJVne5Hz2AI6OhAO6+fVzVjTc8yqjd4OJ5T/2F9ElyUs5Wpe1c9IAOGhlHYzNaz4rTJV7XodKlvwkCUMKfQqsNzEd51ohN0vpW20C6gLoJDWKpeTmomHioU7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983130; c=relaxed/simple;
	bh=XrYnjl+6zxq6P5pi3BQcqzsgS5ykhIFmydkgWi7fDsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXsx+WLTHTrVs8wyxsUrrMqn5S9e09VBHZ6XM+acEHXzjkZYjgo40cjxFbbd5C0Yg6SEvWmdzRZayQswEgAJtfaqFvoMihn+qVUOp4dMX/vHEWvLUjRrCgOCLbgYc3uFH8maRX8r1z79ea9Ay3VgR+O17RX0I4u6bsqOoRKFEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5ur/b6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D9BC116D0;
	Wed, 25 Feb 2026 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983130;
	bh=XrYnjl+6zxq6P5pi3BQcqzsgS5ykhIFmydkgWi7fDsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5ur/b6jG/l5tzWNiR26mZ0bFqCgG3EVYhM8SGjNdNLaMbxqDoi6W//vInHJfqqJH
	 Kx2LcgXYMFup6OZwtnpHkBZRu2nHTMwMucFSb/1lh1JpzLC0H7904Z8KvDHcCG2PFm
	 4Ex2dFwcghN4nhCpL7gTEjf/BodtzuVlKxAXbzu8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 287/781] evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac()
Date: Tue, 24 Feb 2026 17:16:36 -0800
Message-ID: <20260225012406.746325959@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218326-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 15E9518F462
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 0496fc9cdc384f67be4413b1c6156eb64fccd5c4 ]

Commit 8e5d9f916a96 ("smack: deduplicate xattr setting in
smack_inode_init_security()") introduced xattr_dupval() to simplify setting
the xattrs to be provided by the SMACK LSM on inode creation, in the
smack_inode_init_security().

Unfortunately, moving lsm_get_xattr_slot() caused the SMACK64TRANSMUTE
xattr be added in the array of new xattrs before SMACK64. This causes the
HMAC of xattrs calculated by evm_init_hmac() for new files to diverge from
the one calculated by both evm_calc_hmac_or_hash() and evmctl.

evm_init_hmac() calculates the HMAC of the xattrs of new files based on the
order LSMs provide them, while evm_calc_hmac_or_hash() and evmctl calculate
the HMAC based on an ordered xattrs list.

Fix the issue by making evm_init_hmac() calculate the HMAC of new files
based on the ordered xattrs list too.

Fixes: 8e5d9f916a96 ("smack: deduplicate xattr setting in smack_inode_init_security()")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a5e730ffda57f..5a8cef45bacf0 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -401,6 +401,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 {
 	struct shash_desc *desc;
 	const struct xattr *xattr;
+	struct xattr_list *xattr_entry;
 
 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -408,11 +409,16 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		return PTR_ERR(desc);
 	}
 
-	for (xattr = xattrs; xattr->name; xattr++) {
-		if (!evm_protected_xattr(xattr->name))
-			continue;
+	list_for_each_entry_lockless(xattr_entry, &evm_config_xattrnames,
+				     list) {
+		for (xattr = xattrs; xattr->name; xattr++) {
+			if (strcmp(xattr_entry->name +
+				   XATTR_SECURITY_PREFIX_LEN, xattr->name) != 0)
+				continue;
 
-		crypto_shash_update(desc, xattr->value, xattr->value_len);
+			crypto_shash_update(desc, xattr->value,
+					    xattr->value_len);
+		}
 	}
 
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
-- 
2.51.0




