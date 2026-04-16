Return-Path: <stable+bounces-238359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHx+DCE84WmaqgAAu9opvQ
	(envelope-from <stable+bounces-238359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F03C414440
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45867322060A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA634028B;
	Thu, 16 Apr 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IluCM8BE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C0279DC9
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368067; cv=none; b=B2noMrFCsd7Hs4piNDEBYPFnPEZI/5ElZKS0tU+ZjGi4fLCOdUjL7kySBfuYK8jvi/0nMBkcnXxRJzH67M8BFRoqXYeYfR4jW7CSqULmX1Tgrpm8sXWdzRq0S1P3Bi1d0FRimzFp/j0N+/DSBxRSP8w8eYDEkcNKa4yb2tbRVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368067; c=relaxed/simple;
	bh=RFC3QVim0arIk7Lv3+cfW3gLQfc41MwZTxdP0bP0ces=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IiaqgrqYt89huEnK0LcRZb0vtO/CLJ3yA6oEuKKcdyoWAUKFfvUAODmHGPqzYR1zo0YHA58AH80LSQE9jJl8zpsRQemGaJ+uvWMOY7esb7xn9/ajXlHOJoFZVi18u5RSUWHueYx2h5nZ3rKahjgOqNAAfdFr4I1VtVIcZ1N0h04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IluCM8BE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a60975dc5so98397897b3.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776368062; x=1776972862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDgrzdmqtoSKjkQ3Rpvi5tSh9COrIxr3KsgGxPSv/G4=;
        b=IluCM8BE6qXvwb/XaHTy0ZndDb8hI3MN/AXSVSzL1aW1CWpSKx6nJQq2P2bzSwQLgg
         xiLog1LrAMWDKcmo3SDbeUhd7nOVaREjRih8rYnWluVb1hXx6ADqpC9DLyPo8pBTDtxw
         b/kG1oIHIUxgeum6GK9nR3fQl28ivhGWQHcT/SveKHt1VWvG9QNY/WkMzE/jcqqzD0IT
         fbXen9ybJzTa5S54A2BuKQLp69R1eOBtOJ5VYC+iLtE1p0LE0uRrNLbWkxZJyrJYdDpm
         FIIYEmTRffJHM9xrP6hw+CwymuFGIT8Mud2ml6gHpBKsFYtoWXRHMt+fLtZfjXlEJJAw
         upTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776368062; x=1776972862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDgrzdmqtoSKjkQ3Rpvi5tSh9COrIxr3KsgGxPSv/G4=;
        b=eGWDb5/j2YfZTWw6Eu0+03nzDy5Kpdv+mt/+N4E8qmXSmN2hwY4Lkzn83QgQiHvfzy
         JYX9LZ9EJHc5UHS4fvVULT0hYObrQPDCYnadhYVyUDHlnGwHjmAVVstzft4l4X66MUSb
         6tnDBZgNlBAKicPDLk+ERerNu3Vt9ZtveoyTbiSzsZ01L4/k8Eo7IVcMPTI2iJsuDKkk
         2oiQINRkSLF02kPZ1jWHiNS93zjKBh6+nDDq2rfbzV+THkDXfifjJ71yRlrMRGN17pki
         S24/16PgfoTe6wmKmF7LyFiX/TX3l5w0htLiE0dgynukNtvB7X5F0zFLT4a75TYXbSkk
         kj2A==
X-Forwarded-Encrypted: i=1; AFNElJ+rA3AN1ZHYcfrv9Iw8q2D/pCo5avYhuV1AIsovdkGVSwAMGM/fbZpYV5Bvh+7kh9rr2WR7f64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEPJJU1vhcUDttWMXZeKcoEMvOI02zgSh42yCl4kj7BFBRNla
	JTedZ6XA3NZtqQ+QnLXGCfg4AS+mQdDU3TWqVm+hwGyQJHZihnjwT9Gl
X-Gm-Gg: AeBDiesuTiy5Q5ECEmCYn/9NV9Jt71rr/BrWAupBbRaN7SgHiKVdPGaLKe3vl8funv7
	ZOdhmzbif+h+V0vkGc2mjGkYBdwFSOmWUQ82eiy50vnP26v1XMSAh/Wbhd3aF89TexaHEvQc5Is
	6ub5KEwKbN+Ynlp+o/kR4sCXoYjDKMRn0Y54xz9kFRV+VURK74aWeesjgbmxgUBqE2K7V/qq0ub
	aX35vCtZcgX3YwJB1hyNjsDCr9w7uImmdL/0Zm1LGP8Xit1Ymjvf55qtBskcNOyaqw+azX5Ucw6
	xv6DB5W5RDcMtJIs2URGD0n4zrL6Njauyo2kv1G2RqVoUaYaBAtEzMdCamEGK3CNa3SJyPsGGms
	Is6UeaJDEfknXMsDmV3yaS9qR0yyoqZy7UYospYP6P8i5gRBm3DABccDlO5bxNu0uYeMGMeiR15
	ilT+76BPzJ81J9PPZaRQkIl5gZ48kB3r4fzMiWGKr72hooVNhZ7OQ5bc5tjf4UtYVWhCqztFLA0
	6b7LfRmxgaQBn9nqKa4Vm3Xj7Cq0F5ovCCY3mdQdgYIhfOI7x25fw==
X-Received: by 2002:a05:690c:86:b0:7b7:c69f:22fc with SMTP id 00721157ae682-7b9e19ec401mr4952117b3.10.1776368062426;
        Thu, 16 Apr 2026 12:34:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cda9277sm42594576d6.41.2026.04.16.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:34:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix OOB reads from server-supplied dacloffset in cifsacl
Date: Thu, 16 Apr 2026 15:33:25 -0400
Message-ID: <20260416193325.2950619-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238359-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F03C414440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi again! Sorry for the piecemeal sends as I work through triaging
all of my personal "clanker" pipeline results.

Here is another malicious server issue, this time in two call sites
in fs/smb/client/cifsacl.c.  We compute a DACL pointer from a
server-supplied dacloffset and then read struct smb_acl fields 
(dacl_ptr->size, dacl_ptr->num_aces) without first checking that the
8-byte struct header fits within the security descriptor buffer.

1. build_sec_desc() -- chmod path:

    dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
    if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size))

2. id_mode_to_cifs_acl() -- chown path:

    dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
    ...
    le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
    le16_to_cpu(dacl_ptr->size);

In both cases, if dacloffset places dacl_ptr at or past end_of_acl,
the le16_to_cpu() dereferences are OOB heap reads.

Reproduced under UML + KASAN by constructing a 20-byte smb_ntsd
(sizeof(struct smb_ntsd)) with dacloffset = 20, placing dacl_ptr at
the exact end of the allocation.  The le16_to_cpu(dacl_ptr->size)
read triggers:

  BUG: KASAN: slab-out-of-bounds in kcifs2_test_build_sec_desc_old
  Read of size 2 at addr ... by task mount.nfs4/220

Confirmed -EINVAL without splat after patch applied.

parse_dacl() already handles this correctly with a two-step check that
validates the struct header fits before reading the size field:

    if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl) ||
        end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size))

Apply the same pattern to both sites.  This is the client-side
counterpart of commit beff0bc9d69b ("ksmbd: fix overflow in dacloffset
bounds check") which fixed the identical class of issue on the server
side.

Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/client/cifsacl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c920039d733c..115990467dfa 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1293,7 +1293,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
-		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
+		if (end_of_acl < (char *)dacl_ptr + sizeof(struct smb_acl) ||
+		    end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
 			cifs_dbg(VFS, "Server returned illegal ACL size\n");
 			return -EINVAL;
 		}
@@ -1662,6 +1663,14 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
+			if ((char *)pntsd + secdesclen <
+			    (char *)dacl_ptr + sizeof(struct smb_acl)) {
+				cifs_dbg(VFS, "Server returned illegal dacloffset\n");
+				rc = -EINVAL;
+				kfree(pntsd);
+				cifs_put_tlink(tlink);
+				return rc;
+			}
 			if (mode_from_sid)
 				nsecdesclen +=
 					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
-- 
2.53.0


