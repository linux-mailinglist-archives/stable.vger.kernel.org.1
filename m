Return-Path: <stable+bounces-200127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95776CA752E
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1820233163D1
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626B346E7E;
	Fri,  5 Dec 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Da94QJXe"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692BD286405
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920322; cv=none; b=lGSuvdQCKUDv93jJfFTcBAV6xerULzhc+SoYTs3R0PMGA7jM0huOcOFZTbXN9ZHR16EPruvfR8fboH0Zcfo9YnRN26d5hnrgwoZRenQmRm5rQ12TmOEkLv4U8ELxxQci73PpfWM99JZgjqsQAcauOLiQOf4xIoTugWuoHYs6Bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920322; c=relaxed/simple;
	bh=aDlWSE6gEYQMGoorTOmHgsuBmbcCn7/649Gc3d3fS2c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C7AIMqBXQaalnGkSyWpfzT4YhvAtr1FYqdGhS67Ccjx3oypH7UodkYAZN/6jApNpgfVl+coOvVCfAaxhAdazjnxNWsmjilgj1jZKq5x9XrbZTalh8bK70nh8n5vXMkVMdg80YMEQUmkVyEYyENwpXloVbB93Dg230h1aMmNWDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Da94QJXe; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Da94QJXeboHdhHvbK2SdTeYJdFZF4BK/pL/6e5UjSkzqv2tbByir125rBMUiXFPtdh/8ipr05QMN3
	 //PSAzIIFDw4EUJ5kcF7F3qRsQiPfeJY5QgZCPOWhvu2ZjGQL9lwKgf0eGYRTrPiSIngCggZN3pEE1
	 rEOxSv59RQSUaVOA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.245.185])
	by rmsmtp-lg-appmail-35-12049 (RichMail) with SMTP id 2f1169328b2c733-1586b;
	Fri, 05 Dec 2025 15:35:10 +0800 (CST)
X-RM-TRANSID:2f1169328b2c733-1586b
From: Rajani Kantha <681739313@139.com>
To: norbert@doyensec.com,
	linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1.y] ksmbd: fix out-of-bounds in parse_sec_desc()
Date: Fri,  5 Dec 2025 15:35:08 +0800
Message-Id: <20251205073508.4650-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Namjae Jeon <linkinjeon@kernel.org>

commit d6e13e19063db24f94b690159d0633aaf72a0f03 upstream.

If osidoffset, gsidoffset and dacloffset could be greater than smb_ntsd
struct size. If it is smaller, It could cause slab-out-of-bounds.
And when validating sid, It need to check it included subauth array size.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/smb/server/smbacl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 90c5e3edbf46..5c05f0e8b6ea 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -815,6 +815,13 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 		return -EINVAL;
 	}
 
+	if (!psid->num_subauth)
+		return 0;
+
+	if (psid->num_subauth > SID_MAX_SUB_AUTHORITIES ||
+	    end_of_acl < (char *)psid + 8 + sizeof(__le32) * psid->num_subauth)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -856,6 +863,9 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 	pntsd->type = cpu_to_le16(DACL_PRESENT);
 
 	if (pntsd->osidoffset) {
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(owner_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);
@@ -871,6 +881,9 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 	}
 
 	if (pntsd->gsidoffset) {
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(group_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d mapping Owner SID to gid\n",
@@ -892,6 +905,9 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
 
 	if (dacloffset) {
+		if (dacloffset < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		parse_dacl(user_ns, dacl_ptr, end_of_acl,
 			   owner_sid_ptr, group_sid_ptr, fattr);
 	}
-- 
2.17.1



