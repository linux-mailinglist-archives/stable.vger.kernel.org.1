Return-Path: <stable+bounces-240611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCFCL24762mMKAAAu9opvQ
	(envelope-from <stable+bounces-240611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC045C68E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB323015A50
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FD38B140;
	Fri, 24 Apr 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0h82kgov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054138AC7C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023818; cv=none; b=PQalW37vYMjM2D2A6xc/FK/s1Pz4A+exs/BRyzc8rl5GWFsT+WNGasaD+pBJJzVR5dvxBsIiNzUyfp2naUvhHt/Nk4vbzMsTXNuvv5Mw5DhVKhFiLQqNWEsbHgOQdNGAhHKwGhcIF7acFmEH5/tWJuBLQ+gkkevNBvWHvwOST5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023818; c=relaxed/simple;
	bh=5QLGY/jzL2KOI/dSbBloaaJ6Vfd56UOHGxofGr+jApo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SJ55QkjzXTpkunsjPD8hLRnBGc1Q8xoG8T72zXhhGot5wuXvjXizepGSIddAN/DjUeH8jlNOY3XIT2Z8Mzu2/QFt8TzjW+aT6fZS1Px1SjwdGQZ4iSxUKeOTaB2cfUxF4XS8EH/uGm1POzU07PHzEW/tCuCPjsYD/E6BCc2wCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0h82kgov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854E4C19425;
	Fri, 24 Apr 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023817;
	bh=5QLGY/jzL2KOI/dSbBloaaJ6Vfd56UOHGxofGr+jApo=;
	h=Subject:To:Cc:From:Date:From;
	b=0h82kgovm/xth6RE8RSEciAFPobwLWrTIAdJglfblvPUbXion2CinqmXUakBAFKnj
	 ZFS/qA+NPKpcwzT0kKkB3rkyYGhE0ZQujTW8dlVAS0ktPpvN3RScebXyl3U5oXJixq
	 9fOzn0IOYJqWsLI7aJMoATU+SR3d26FpPqU9ixMc=
Subject: FAILED: patch "[PATCH] ksmbd: validate num_aces and harden ACE walk in" failed to apply to 6.1-stable tree
To: michael.bommarito@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:43:33 +0200
Message-ID: <2026042433-grapple-overprice-ccf0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75AC045C68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240611-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3e4e2ea2a781018ed5d75f969e3e5606beb66e48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042433-grapple-overprice-ccf0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e4e2ea2a781018ed5d75f969e3e5606beb66e48 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 17 Apr 2026 14:45:57 -0400
Subject: [PATCH] ksmbd: validate num_aces and harden ACE walk in
 smb_inherit_dacl()

smb_inherit_dacl() trusts the on-disk num_aces value from the parent
directory's DACL xattr and uses it to size a heap allocation:

  aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, ...);

num_aces is a u16 read from le16_to_cpu(parent_pdacl->num_aces)
without checking that it is consistent with the declared pdacl_size.
An authenticated client whose parent directory's security.NTACL is
tampered (e.g. via offline xattr corruption or a concurrent path that
bypasses parse_dacl()) can present num_aces = 65535 with minimal
actual ACE data.  This causes a ~8 MB allocation (not kzalloc, so
uninitialized) that the subsequent loop only partially populates, and
may also overflow the three-way size_t multiply on 32-bit kernels.

Additionally, the ACE walk loop uses the weaker
offsetof(struct smb_ace, access_req) minimum size check rather than
the minimum valid on-wire ACE size, and does not reject ACEs whose
declared size is below the minimum.

Reproduced on UML + KASAN + LOCKDEP against the real ksmbd code path.
A legitimate mount.cifs client creates a parent directory over SMB
(ksmbd writes a valid security.NTACL xattr), then the NTACL blob on
the backing filesystem is rewritten to set num_aces = 0xFFFF while
keeping the posix_acl_hash bytes intact so ksmbd_vfs_get_sd_xattr()'s
hash check still passes.  A subsequent SMB2 CREATE of a child under
that parent drives smb2_open() into smb_inherit_dacl() (share has
"vfs objects = acl_xattr" set), which fails the page allocator:

  WARNING: mm/page_alloc.c:5226 at __alloc_frozen_pages_noprof+0x46c/0x9c0
  Workqueue: ksmbd-io handle_ksmbd_work
   __alloc_frozen_pages_noprof+0x46c/0x9c0
   ___kmalloc_large_node+0x68/0x130
   __kmalloc_large_node_noprof+0x24/0x70
   __kmalloc_noprof+0x4c9/0x690
   smb_inherit_dacl+0x394/0x2430
   smb2_open+0x595d/0xabe0
   handle_ksmbd_work+0x3d3/0x1140

With the patch applied the added guard rejects the tampered value
with -EINVAL before any large allocation runs, smb2_open() falls back
to smb2_create_sd_buffer(), and the child is created with a default
SD.  No warning, no splat.

Fix by:

  1. Validating num_aces against pdacl_size using the same formula
     applied in parse_dacl().

  2. Replacing the raw kmalloc(sizeof * num_aces * 2) with
     kmalloc_array(num_aces * 2, sizeof(...)) for overflow-safe
     allocation.

  3. Tightening the per-ACE loop guard to require the minimum valid
     ACE size (offsetof(smb_ace, sid) + CIFS_SID_BASE_SIZE) and
     rejecting under-sized ACEs, matching the hardening in
     smb_check_perm_dacl() and parse_dacl().

v1 -> v2:
  - Replace the synthetic test-module splat in the changelog with a
    real-path UML + KASAN reproduction driven through mount.cifs and
    SMB2 CREATE; Namjae flagged the kcifs3_test_inherit_dacl_old name
    in v1 since it does not exist in ksmbd.
  - Drop the commit-hash citation from the code comment per Namjae's
    review; keep the parse_dacl() pointer.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index bba26a0355bb..a1de89cc09be 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1106,8 +1106,24 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		goto free_parent_pntsd;
 	}
 
-	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2,
-			    KSMBD_DEFAULT_GFP);
+	aces_size = pdacl_size - sizeof(struct smb_acl);
+
+	/*
+	 * Validate num_aces against the DACL payload before allocating.
+	 * Each ACE must be at least as large as its fixed-size header
+	 * (up to the SID base), so num_aces cannot exceed the payload
+	 * divided by the minimum ACE size.  This mirrors the existing
+	 * check in parse_dacl().
+	 */
+	if (num_aces > aces_size / (offsetof(struct smb_ace, sid) +
+				    offsetof(struct smb_sid, sub_auth) +
+				    sizeof(__le16))) {
+		rc = -EINVAL;
+		goto free_parent_pntsd;
+	}
+
+	aces_base = kmalloc_array(num_aces * 2, sizeof(struct smb_ace),
+				  KSMBD_DEFAULT_GFP);
 	if (!aces_base) {
 		rc = -ENOMEM;
 		goto free_parent_pntsd;
@@ -1116,7 +1132,6 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	aces = (struct smb_ace *)aces_base;
 	parent_aces = (struct smb_ace *)((char *)parent_pdacl +
 			sizeof(struct smb_acl));
-	aces_size = acl_len - sizeof(struct smb_acl);
 
 	if (pntsd_type & DACL_AUTO_INHERITED)
 		inherited_flags = INHERITED_ACE;
@@ -1124,11 +1139,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	for (i = 0; i < num_aces; i++) {
 		int pace_size;
 
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 
 		pace_size = le16_to_cpu(parent_aces->size);
-		if (pace_size > aces_size)
+		if (pace_size > aces_size ||
+		    pace_size < offsetof(struct smb_ace, sid) +
+				CIFS_SID_BASE_SIZE)
 			break;
 
 		aces_size -= pace_size;


