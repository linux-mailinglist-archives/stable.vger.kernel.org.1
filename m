Return-Path: <stable+bounces-219040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHTpKylWnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-219040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746011901E3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBABD30B096C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BD24A05D;
	Wed, 25 Feb 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sDYYmbIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195361D5ABA;
	Wed, 25 Feb 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983960; cv=none; b=WBsD9HEnai2CWAdcbEHs7iUydayu8poKHwmKwiHWsaA+3mdhG3SS8vq94Iy3CgMUFCwOpQyf3WDQp34ikBuOcCkuQQX7FR4RIj685TorT4z10VecyFVv0LXDg0XJlI9m7OgnINhoCpnmaAjYPvVJcGviSfzPqyvcZT5KX1bIl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983960; c=relaxed/simple;
	bh=62pbhEh/RnBq8XpDxyb1Gw542gkQOe6hm54xhwOboQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr9Mz56bgtPSMofLMtXBHg9riLeql+CZTHiGHDxag/BqqnnnCcEQnlHdJs3iDa9N8CiCE02PcZls61r0byIvM3+DsJ0740RLFJd2O9v4HtHn3EmM7qOJ0D8S1ceGJLU5N+ySEu5F4N/OvEGez/0lgR++gEHIcrl1F1RXsnQysL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sDYYmbIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDFC116D0;
	Wed, 25 Feb 2026 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983960;
	bh=62pbhEh/RnBq8XpDxyb1Gw542gkQOe6hm54xhwOboQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDYYmbIuBfquXSgR0VA8S3wIlxOVCKO7kHDqprHY0KHovFro/WYpEzEYCeIaiEU2T
	 v7GQ5T0F0MVHYT+QXLl9iekFFWtJ+/6OmuB7mt48LC7EDUqU3Flq3Nnmc0NSi9ksNi
	 zhQrzbks7DmoDtwn4Gmp/7W5rWywc1KklVlItKP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 217/641] evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac()
Date: Tue, 24 Feb 2026 17:19:03 -0800
Message-ID: <20260225012354.190425027@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219040-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 746011901E3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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




