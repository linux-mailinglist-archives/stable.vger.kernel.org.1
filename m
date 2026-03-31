Return-Path: <stable+bounces-232171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIdNF+/+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99036DDC2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B0FB30E1F3D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918DA426D1F;
	Tue, 31 Mar 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPUjjKCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B734266BA;
	Tue, 31 Mar 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976060; cv=none; b=KbtUc/BQEDAbNaIx5VqToh6KZOryPsy5ZfXYZTRpc00qnYfbdVpM8D30uKp29ajTxslTh3qbbc/Xn4PwA+ITzVI4/LHumjWZuMkztW7y2x2MCNwE2iQ7Hj4tOmCXw93UB3shfM0Z+vAjXaQTjx8rgmloHQRvGQ+gU/IrpPH+/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976060; c=relaxed/simple;
	bh=DbRkXO9/JQpUNvoXJCtt5eXvcFcatmF/lf5Gf+11vx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q16D4ZdwNJG81qyrzIBiL4CQIOkEPY81yP2it3i6hric5atRGhPixM98OZICvhcQM3nkvIzWWzQ2Z/4RNemAo8dWADSFk85CRPkdGIbAFfDpVSHl75QII+Uj44uIkzXMvlEY+/uXYMv3GHtmejolmjwN1WPkS0IbKejiojKow6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPUjjKCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD6BC19423;
	Tue, 31 Mar 2026 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976060;
	bh=DbRkXO9/JQpUNvoXJCtt5eXvcFcatmF/lf5Gf+11vx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPUjjKCGabYvG9jNh0k//xjkqwf8GGMLyKFv9/Yj3GrxYE2+qWHNnqYfJm7kIddPM
	 77xSIP3zaCuqG7F8chlabjqC4OfJ3UHqIrcx3IrUEo8+G1vqo+CxQPHdsXUcx1disY
	 V5pCVhU2r7TIzDx5yZZJ3M9T98z1sRiO0g62dSss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helen Koike <koike@igalia.com>,
	Theodore Tso <tytso@mit.edu>,
	syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: [PATCH 6.12 192/244] ext4: reject mount if bigalloc with s_first_data_block != 0
Date: Tue, 31 Mar 2026 18:22:22 +0200
Message-ID: <20260331161748.843295994@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232171-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,b73703b873a33d8eb8f6];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email,syzkaller.appspot.com:url,msgid.link:url,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0B99036DDC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3631,6 +3631,13 @@ int ext4_feature_set_ok(struct super_blo
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



