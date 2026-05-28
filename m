Return-Path: <stable+bounces-256259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHmTKmyrGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:54:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FB5F9CF3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D596F312AD1A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB8330B32;
	Thu, 28 May 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivMP+H2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3E2F9D85;
	Thu, 28 May 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001199; cv=none; b=SaOPuszDsuji4QNU3UhqjPH5nCPdokCLQ1V6zymWIfr1IXrknqBKOHNpPMCgKRM78zUdiLF/Qs25fOJcytSxWKeOhFAf1dS+n6IZN7p+Fx6vyIDuMHQBVeC8NFVbNx35CZpDEToX+TKtk3C5U/i9Dab1V/8mR/NcY4y9AhGCNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001199; c=relaxed/simple;
	bh=+m2Pl/o51lv9PhYg2WLz4z2WWH24BmofUOx6n40ibLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHtrNOjTPUiTJoYd7LGt53qGT6zM/3SHfjm0W5RRErZ3lPYDkJ3WvbdUv0r0jpmQATo51ixgz7sYfy3PPvhfctT26krRcNiy1qDvPgiKXykzUC9/ZJTndmHXN40rcwMmOVALzfCdlxSUvsEywhl9TeGfRMoWiXHkTc0d4fORnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivMP+H2j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C731C1F00A3A;
	Thu, 28 May 2026 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001198;
	bh=0WOtDTKnhjIqPR+RtdkwH5hi3mnFEckIG+7KBTMyJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivMP+H2jYmTVFIAMjmADBbf82TIv5KCcl3KGw3JxPfm1nrFNuE25aeySppOubjnCX
	 6VgqSeNAgAauEZMyV2tKwCD5O5JhUkbBDiVl8DA6acz4HyvzoKhRC1N79mcX/pqX66
	 zkS+B2ZHnHc2J0P3rO/B3sqdTDUWqEnJGMskptCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ferry Meng <mengferry@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 025/186] ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow
Date: Thu, 28 May 2026 21:48:25 +0200
Message-ID: <20260528194929.639215138@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256259-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 314FB5F9CF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ferry Meng <mengferry@linux.alibaba.com>

commit af92ee994cc7f7e83a41c2025f32257a2f82a7ef upstream.

Commit 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16
DACL size overflow") added check_add_overflow() guards that break out
of the ACE-building loops in set_posix_acl_entries_dacl() when the
accumulated DACL size would wrap past 65535.

However, each iteration allocates a struct smb_sid via kmalloc_obj()
at the top of the loop and relies on the kfree(sid) call at the end
of the loop body (the 'pass_same_sid' label in the first loop, and
the explicit kfree at the tail of the second loop) to release it.
The newly introduced 'break' statements bypass those kfree() calls,
leaking the sid buffer every time an overflow is detected.

A malicious or malformed file with enough POSIX ACL entries to trip
the overflow check will leak one or more struct smb_sid allocations
on every request that touches the file's DACL, providing a trivial
kernel memory exhaustion vector.

Free sid before breaking out of the loops to plug the leak.

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c1d1f34581d6..9161e9d7ed24 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -643,8 +643,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -655,8 +657,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			ntace = (struct smb_ace *)((char *)pndace + *size);
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
-			if (check_add_overflow(*size, ace_sz, size))
+			if (check_add_overflow(*size, ace_sz, size)) {
+				kfree(sid);
 				break;
+			}
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -698,8 +702,10 @@ posix_default_acl:
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
-- 
2.54.0




