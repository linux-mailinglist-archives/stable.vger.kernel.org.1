Return-Path: <stable+bounces-151891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BABAD1221
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB2D16A25D
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60270212B3A;
	Sun,  8 Jun 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIh0Rzrr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178411A5BA3;
	Sun,  8 Jun 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387290; cv=none; b=ZrA/XqKOd/XMZ88OehtNAzEy/E1AI0k7VwIpRzr0lCat+G3+tMHFTo95KGPFqQMfLfPq+Omm8KcBpIsA4RJRGbFt1x1DsKTSRp63mjMLSydwMWZq3UiIxLjDTdPP2yl86wvjvj/g903TIpxqY1d1cy/nwlvCpMcyqZSuc6qn3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387290; c=relaxed/simple;
	bh=RO8h4TwzukLCaOWZxdY/gavIFCDd2tskoO/5HAyVejk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SmYKyE3lBskQjDZV/CT1hi7ygn7Xhw2rJeONPjzY3YNMdZUIf8gI2a7B3nCL7XnVGf7KattJj9b3GubpeZn6V2XpAjXXI3jefZ+M25ODL6TQoU7WU8rtOdvY1+MVveNfkI/Ym+slE5twMul5D9/0/XDLK1cSQvpHHP7oaD2vbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIh0Rzrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0873AC4CEEE;
	Sun,  8 Jun 2025 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387290;
	bh=RO8h4TwzukLCaOWZxdY/gavIFCDd2tskoO/5HAyVejk=;
	h=From:To:Cc:Subject:Date:From;
	b=AIh0Rzrr0OinIXKKWFl4cNgacG9IDc9WgQA8yQDicua5NSpWNeKnEnmP8xeffM+ar
	 BJCAO+JfYHoT/nUoD+nwtzEWWIGzvOwXPuWQ7+5s9WYL2otDFEu4ee2vU7XLFaNu2g
	 1bVp9swH57OUW/PFiQ0kLbnLlYQ76/tLdCiiqxeZyci1cycGNuPcUgPGJFK8NiNOTe
	 O8VBGGvOXpxsp2XVh4ykt7o7RtYBU04+cvcORIuahX/dWeF+ZuAvXoKPXwkxYlxULq
	 gTnDaBw/dzVMYy4usocsAFT7t5ZONoDLVsr3yjsssKq7kHJKhL676h+WDDhi2cjo2m
	 8LLnHh7gCVZKQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Philipp Kerling <pkerling@casix.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	smfrench@gmail.com,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 01/10] ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
Date: Sun,  8 Jun 2025 08:54:38 -0400
Message-Id: <20250608125447.933686-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit dc3e0f17f74558e8a2fce00608855f050de10230 ]

If client send SMB2_CREATE_POSIX_CONTEXT to ksmbd, Allow a filename
to contain special characters.

Reported-by: Philipp Kerling <pkerling@casix.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of both the commit message and code changes,
examining the Linux kernel repository context:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Nature of the Change

This is a **legitimate bug fix** that addresses a functional issue where
SMB3.1.1 POSIX extension clients cannot create files with characters
that are valid in POSIX filesystems but blocked by ksmbd's Windows-
centric filename validation.

## Code Analysis

### Key Changes:
1. **Early POSIX context detection** (lines 2906-2925): The code now
   checks for SMB2_CREATE_POSIX_CONTEXT early in the function
2. **Conditional validation bypass**: The critical change at lines
   3161-3164 where `ksmbd_validate_filename(name)` is only called when
   `posix_ctxt == false`
3. **Structural improvement**: Moving POSIX context parsing before
   filename validation, which is the logical order

### What Gets Bypassed:
The `ksmbd_validate_filename()` function normally blocks characters like
`"`, `<`, `>`, `|`, `?`, `*`, and control characters. For POSIX
extensions, these restrictions are inappropriate since POSIX filesystems
can safely handle most of these characters.

## Security Assessment

### Low Security Risk:
1. **Limited Scope**: Only affects clients explicitly using SMB3.1.1
   POSIX extensions (`tcon->posix_extensions` must be enabled)
2. **VFS Protection**: Linux VFS layer provides underlying security
   validation
3. **No Path Traversal**: Higher-level path validation still prevents
   `../` sequences
4. **Standards Compliance**: Aligns with Microsoft's SMB3.1.1 POSIX
   extension specification

### Justification for the Change:
- **User Report**: Philipp Kerling reported this as a functional issue
- **Interoperability**: Essential for proper POSIX-aware SMB client
  functionality
- **Standards Adherence**: SMB3.1.1 POSIX extensions are designed to
  allow POSIX filename semantics

## Comparison with Similar Commits

This follows the pattern of other backported ksmbd commits:
- **Similar to Commit #4**: Another filename validation fix that was
  backported (moving leading slash check)
- **Similar scope**: Limited, well-contained change to specific
  subsystem
- **Bug fix nature**: Addresses functional issue rather than adding new
  features

## Stable Tree Criteria Compliance

✅ **Fixes important bug**: Enables legitimate POSIX client functionality
✅ **Small and contained**: Changes only affect POSIX extension code path
✅ **Minimal regression risk**: Protected by existing VFS validation
✅ **Clear side effects**: Well-understood behavior change
✅ **No architectural changes**: Simple conditional logic modification

## Recommendation

This commit represents a **low-risk bug fix** that enables proper
SMB3.1.1 POSIX extension functionality without introducing significant
security vulnerabilities. The change is well-scoped, addresses a
legitimate user issue, and maintains appropriate security boundaries
through existing VFS-level protections.

 fs/smb/server/smb2pdu.c | 53 +++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f2a2be8467c66..d4058b623e9c4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2874,7 +2874,7 @@ int smb2_open(struct ksmbd_work *work)
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
 	int contxt_cnt = 0, query_disk_id = 0;
-	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	bool maximal_access_ctxt = false, posix_ctxt = false;
 	int s_type = 0;
 	int next_off = 0;
 	char *name = NULL;
@@ -2903,6 +2903,27 @@ int smb2_open(struct ksmbd_work *work)
 		return create_smb2_pipe(work);
 	}
 
+	if (req->CreateContextsOffset && tcon->posix_extensions) {
+		context = smb2_find_context_vals(req, SMB2_CREATE_TAG_POSIX, 16);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out2;
+		} else if (context) {
+			struct create_posix *posix = (struct create_posix *)context;
+
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_posix) - 4) {
+				rc = -EINVAL;
+				goto err_out2;
+			}
+			ksmbd_debug(SMB, "get posix context\n");
+
+			posix_mode = le32_to_cpu(posix->Mode);
+			posix_ctxt = true;
+		}
+	}
+
 	if (req->NameLength) {
 		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
@@ -2925,9 +2946,11 @@ int smb2_open(struct ksmbd_work *work)
 				goto err_out2;
 		}
 
-		rc = ksmbd_validate_filename(name);
-		if (rc < 0)
-			goto err_out2;
+		if (posix_ctxt == false) {
+			rc = ksmbd_validate_filename(name);
+			if (rc < 0)
+				goto err_out2;
+		}
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
@@ -3085,28 +3108,6 @@ int smb2_open(struct ksmbd_work *work)
 			rc = -EBADF;
 			goto err_out2;
 		}
-
-		if (tcon->posix_extensions) {
-			context = smb2_find_context_vals(req,
-							 SMB2_CREATE_TAG_POSIX, 16);
-			if (IS_ERR(context)) {
-				rc = PTR_ERR(context);
-				goto err_out2;
-			} else if (context) {
-				struct create_posix *posix =
-					(struct create_posix *)context;
-				if (le16_to_cpu(context->DataOffset) +
-				    le32_to_cpu(context->DataLength) <
-				    sizeof(struct create_posix) - 4) {
-					rc = -EINVAL;
-					goto err_out2;
-				}
-				ksmbd_debug(SMB, "get posix context\n");
-
-				posix_mode = le32_to_cpu(posix->Mode);
-				posix_ctxt = 1;
-			}
-		}
 	}
 
 	if (ksmbd_override_fsids(work)) {
-- 
2.39.5


