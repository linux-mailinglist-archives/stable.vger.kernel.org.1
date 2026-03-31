Return-Path: <stable+bounces-231594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFpkJp/5y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440336D03E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CECC430AD7D6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22048401A2C;
	Tue, 31 Mar 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyBy+pRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D263E3D82;
	Tue, 31 Mar 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974573; cv=none; b=ePC1dFvW5iYEXhbf8de5YcaHm3nvU/IBFKxDCEfkSTxoHzEEhVSywl+nYD01ixS+uEoeLs5F+faW3Q4LGPe/ITud5Hz4OAcpzzhUafEwWyL8CZJzewEuotZFUPm0gQsjWya6IMXihdbH7ecL44PoHEJ6aZABn85ynnqT2vqQNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974573; c=relaxed/simple;
	bh=0kH3pI92jbYpRpw6ON8Ft4EXEibS1eLOnV7iSSWhvL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OomDyrexAujJqtLYiAKtPahL9GP6b1JvUaKc5XH5FtW8Z7Oln0/1roo6EVt8apXrfWwGD7w/3PpFJTff4EGbXMBEwv9IoWJk5AiMdLzBBatumd+DPPY0kzf5kN17TxJsH0agqR7AfjalEewBsMhC4vG3zYQIBZeZwZhHyxnrsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyBy+pRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34989C19423;
	Tue, 31 Mar 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974573;
	bh=0kH3pI92jbYpRpw6ON8Ft4EXEibS1eLOnV7iSSWhvL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xyBy+pRsbDPXkdC9aV1WCwGA++CaTX8gllqFabHpiNFWlHVx9I8i9CDSrsE7LsBCc
	 Obz6Sm0q690KmWnue1yREIiomOrULdWSM7qIbJJtL6ZWTkUKvqiz8QO+wPKkq9mGpO
	 8qVrMBKYMpchbdEpzMLZhydLYTSEUu3aYu8Dp+Lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helen Koike <koike@igalia.com>,
	Theodore Tso <tytso@mit.edu>,
	syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: [PATCH 6.6 137/175] ext4: reject mount if bigalloc with s_first_data_block != 0
Date: Tue, 31 Mar 2026 18:22:01 +0200
Message-ID: <20260331161734.820830652@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231594-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,b73703b873a33d8eb8f6];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,igalia.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 9440336D03E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helen Koike <koike@igalia.com>

commit 3822743dc20386d9897e999dbb990befa3a5b3f8 upstream.

bigalloc with s_first_data_block != 0 is not supported, reject mounting
it.

Signed-off-by: Helen Koike <koike@igalia.com>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b73703b873a33d8eb8f6
Link: https://patch.msgid.link/20260317142325.135074-1-koike@igalia.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3655,6 +3655,13 @@ int ext4_feature_set_ok(struct super_blo
 			 "extents feature\n");
 		return 0;
 	}
+	if (ext4_has_feature_bigalloc(sb) &&
+	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
+		ext4_msg(sb, KERN_WARNING,
+			 "bad geometry: bigalloc file system with non-zero "
+			 "first_data_block\n");
+		return 0;
+	}
 
 #if !IS_ENABLED(CONFIG_QUOTA) || !IS_ENABLED(CONFIG_QFMT_V2)
 	if (!readonly && (ext4_has_feature_quota(sb) ||



