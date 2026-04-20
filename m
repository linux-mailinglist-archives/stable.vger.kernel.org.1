Return-Path: <stable+bounces-239244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEG/CVNL5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:50:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A845942EA41
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFF4133688AB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240B2C028F;
	Mon, 20 Apr 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJtZKKAh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A128DB49
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696486; cv=none; b=VD0qjeSsV5ks1ybj1e9pYxD0oTTf0HmBJv4WguUnw71QYzkO5Nk/IKbmrqt71ckyQH4zeqMkXGFNEhGtoHbu6SpNHRHsl7yQtFAx1RBUkfqai2OI2upNG3wwWZW2Z89FpEI2OJDLQCVMW//AJwxoqa1f0ExO5+rx5XdKjO2SqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696486; c=relaxed/simple;
	bh=248LEv+sRvAPKQEXTiDFIqrD1Z8GTMB8AFG3XTGI1w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrHY53a3Mi/aqgc72Zm4gjK3CF+j9dROYmNsSxc05Od6JvN4c4d7nXnC54XaF/Y/eRrbwWwQ1VBrjJTR0Q8nmGrJE+MIAlI1t0uMsWseENRy86HbZVsjOVdFhlIlivPRx4/ph4h1pTA7e7DNLHU0J2MZzyRWEywOd9f47XNGfSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJtZKKAh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5c5033f6so9724711cf.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776696482; x=1777301282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gONB6BslV1gZB8sBPqe9TWmoGjs9CoGOCXEnrliVxGA=;
        b=hJtZKKAh4HinATYR9azugKKRHDVQVJIkh+8ggcFCTpetQxrZa0/tquKBacNPzjgXSM
         EBHYfW8rZOBYqn2UMDxMyVUMqJavPneL6HTlFC9FYi4ppt2bQHF0enOvYh1aOZSfhUfu
         w6fgsq4qlL411VoRhFGI7UXeKz4WsoMn9crsxxtFRspeFQSTsZERMNZ8sqFTTnYhnFN/
         pCWGhecZmsh2NqxC2buX0ZKqtfM6M8AFMlqVHifaZH2DJ6EdJuKtJpyn7wzADFnd0mx6
         5SiQXTfTbZywd9RvTmvAL6UgA4ZTFfyou93F7w+GUBaoBYaKn8RKSjOz3XGdo6YjiiO4
         6+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776696482; x=1777301282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gONB6BslV1gZB8sBPqe9TWmoGjs9CoGOCXEnrliVxGA=;
        b=N9T7JJbLL/mO1nNosS+eoN0aiWqEg/eVKSNEtctGJ13y+kMzjJUU5DAhReg6tHJSoL
         atL5mxQmrtzvfibufSYRdd4BBskLgNFszAPh3YPQGiDJ+8SgJDSMw07yJRPmsWpPYlqn
         cOFHc6Bws56yR/Wuf5cU47e7VbpOxdK1Gy55L7IeTG+/Yic74rUFjvhQPC1NbknXEKv1
         KV8+CTqiiFJctH7R0ti8pxowsQZqAO9X5r3c7CIaBFCdsfSVTjYxP95jv77orWO/xFI4
         hs+55pOXlYzHPAtKXfsEs8r6VTgJM6su99xhSHB4zavO/buhZaNu47HGcXnRQFe5XBx+
         XoTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LK4IOTE/bQyNoETj2z7Bti/0IWTX28vCDuIW3DCHOJjmBq4D6m9AXglFBhpwDug3tuGHpgzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbAY/DpBiopKTNRAkqpdXqYLi1WW1FomiQLiPF/F8Q6RaK7i0
	YHY4vCOfwfW6Ur5ajNBphXvNGOWzUpVw4SNJv5BwhegPSYBVqszskWtd
X-Gm-Gg: AeBDieuHDJO1QOTDe4b1JA5Ag6byKzhje9JKcDYQAlbBplQa7GUG39cRqLYS7ldAR8X
	9BWA9vGVkOA0whN2XLoVKAwdQLUPRMDDOzjyjtfldCOhFdKIime/VSU1nu3CYhyFk6wIFp83I1M
	BnQOyNfuujWqgAjsU5K+hKAc83WawRqgUv3cFzzYcWsU0g1AU/wMxBCtqB3qVL2cOMfRrlm9sAL
	bH2Cw5nHcjKv747n5IlW9SDFRYfCwrWHsMz0e+ijgODWc4wTyHPKQDrExozJOMz71ZeQ73K4DIl
	Oy/9kreqJuUCu5XKWzfNY8x0SQvKMpH5S2It2J73tYMWgWqoCNjefQ9h7R2XWLStU6JmKQb/pec
	QH00gkNf5BdVAg3/DXQj1FdCF0cx9UYyuHwFUuFDsNMoIoMC0bj6kWjaxsbN2FZFM6JWwcK0Zfp
	DM9vI5e5d0qstwcxYtefBRl8RQTHyEHDZzDTpEvOCFriFfcrcC82n3+gPPHFs4+H5Gdq2c9dpEJ
	udPuEVsDf5DA6hBXhVpjH+0rkueYJQ=
X-Received: by 2002:a05:622a:8404:10b0:50e:57de:40d7 with SMTP id d75a77b69052e-50e57de4894mr54079011cf.19.1776696482038;
        Mon, 20 Apr 2026 07:48:02 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39495192sm85384781cf.27.2026.04.20.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:48:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: validate dacloffset before building DACL pointers
Date: Mon, 20 Apr 2026 10:47:47 -0400
Message-ID: <20260420144747.662761-1-michael.bommarito@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,lists.samba.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239244-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A845942EA41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

parse_sec_desc(), build_sec_desc(), and the chown path in
id_mode_to_cifs_acl() all add the server-supplied dacloffset to pntsd
before proving a DACL header fits inside the returned security
descriptor.

On 32-bit builds a malicious server can return dacloffset near
U32_MAX, wrap the derived DACL pointer below end_of_acl, and then slip
past the later pointer-based bounds checks. build_sec_desc() and
id_mode_to_cifs_acl() can then dereference DACL fields from the wrapped
pointer in the chmod/chown rewrite paths.

Validate dacloffset numerically before building any DACL pointer and
reuse the same helper at the three DACL entry points.

Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
This applies on top of

  [PATCH v2] smb: client: validate the whole DACL before rewriting it
  in cifsacl
  https://lore.kernel.org/linux-cifs/20260420001131.2865776-1-michael.bommarito@gmail.com/

so that the new dacl_offset_valid() numeric precheck sits upstream of
that series' validate_dacl() structural check at all three call sites.
The two patches are independent fixes for different bug classes on the
same three entry points; applying this one without the KCIFS2 v2 patch
first will fail on the build_sec_desc() hunk because the trailing
context line "rc = validate_dacl(dacl_ptr, end_of_acl)" only exists
after v2.  If you prefer a different ordering, happy to reroll on a
plain mainline base instead.

 fs/smb/client/cifsacl.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index cb4060ba5e31..87d2a58fc8b4 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1263,6 +1263,17 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 	return 0;
 }
 
+static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
+{
+	if (acl_len < sizeof(struct smb_acl))
+		return false;
+
+	if (dacloffset < sizeof(struct smb_ntsd))
+		return false;
+
+	return dacloffset <= acl_len - sizeof(struct smb_acl);
+}
+
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
@@ -1283,7 +1294,6 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1314,11 +1324,18 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		return rc;
 	}
 
-	if (dacloffset)
+	if (dacloffset) {
+		if (!dacl_offset_valid(acl_len, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
-	else
+	} else {
 		cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default perms? */
+	}
 
 	return rc;
 }
@@ -1341,6 +1358,11 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
+		if (!dacl_offset_valid(secdesclen, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		rc = validate_dacl(dacl_ptr, end_of_acl);
 		if (rc)
@@ -1709,6 +1731,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
+			if (!dacl_offset_valid(secdesclen, dacloffset)) {
+				cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+				rc = -EINVAL;
+				goto id_mode_to_cifs_acl_exit;
+			}
+
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
 			if (rc) {
@@ -1751,6 +1779,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
 		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
 	}
+id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
 	kfree(pnntsd);
-- 
2.53.0


