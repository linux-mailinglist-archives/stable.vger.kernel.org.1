Return-Path: <stable+bounces-240656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOmNLYVq62kcMwAAu9opvQ
	(envelope-from <stable+bounces-240656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D345ED38
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 984C4301C948
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC826321F5F;
	Fri, 24 Apr 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8cjgfN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08261A682E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035844; cv=none; b=I8RjNKpchWIdJX+5oDMFydseqfC2ZwYWvuuxMphINsNXGghHGVF0YO14trejyw9G5Xj0pjfL8YDMlIjREkKLEIDE7LtwDvxBIoDjkYCV2GvPGZagxpUAx4q8hewgc2dW5q3y8ml2Ftl4v4fNBo/r72WkBHkuwj+piG2LGGdqcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035844; c=relaxed/simple;
	bh=i7TnAXtgn7PmUg5mgtR5ExsMW/AZHZMwUmvLdo2jp+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaArHBJb1ZX3RHOC8YId0Nf2W7y6I2Rx6bOjDL/mgRtRglVBIiC5ChTE0yZr1bWvrRdjt7clKxA7UC16EQrvjjPPzrdlRozfQTr0zfGzCvvmPOcPSazL7TpXzfLinwaD7z+95d+gBcPD15OHT4mKm6ktUOrRFK7Uvw2RHp/RT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8cjgfN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDECFC19425;
	Fri, 24 Apr 2026 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777035844;
	bh=i7TnAXtgn7PmUg5mgtR5ExsMW/AZHZMwUmvLdo2jp+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8cjgfN+hRlHOT8G1Im1KIsSnbCp1OMZktHZjc331yMRrFX9oy+9rpylPttHmXIY6
	 wwdkeAqqvZlFtcMaYMP2CpSjJ8pvB+ki9lRoMqWY0ZopJnOaNCL/5LM2VsDKbNeOR5
	 7JT6+EERUU49qrC5eWG/Ghlp8SBerC8Gy34Ra7txoKbW+99Agr+ruciF18jS4Kbftd
	 43WRbEMoUySQTyFgKdtI3wBde8G1AnzJaaCfyU/bIAApxH0ds6ZXr+WShaseZqOuGR
	 axKZ5EU41FrSTpaYsr/+8xtS0Xx8XCd2wdyBkTnQ1/YPcCaE/nLm7PdKjj6LyHmvjp
	 jDHZHtttbCtww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] smb: move some duplicate definitions to common/smbacl.h
Date: Fri, 24 Apr 2026 09:03:59 -0400
Message-ID: <20260424130401.1917926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042426-growing-dime-ce6e@gregkh>
References: <2026042426-growing-dime-ce6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 406D345ED38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240656-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit b51174da743b6b7cd87c02e882ebe60dcb99f8bf ]

In order to maintain the code more easily, move duplicate definitions
to new common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.h |  91 +-----------------------------
 fs/smb/common/smbacl.h  | 121 ++++++++++++++++++++++++++++++++++++++++
 fs/smb/server/smbacl.h  | 111 +-----------------------------------
 3 files changed, 123 insertions(+), 200 deletions(-)
 create mode 100644 fs/smb/common/smbacl.h

diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 05b3650ba0aec..31b51a8fc2561 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -9,8 +9,7 @@
 #ifndef _CIFSACL_H
 #define _CIFSACL_H
 
-#define NUM_AUTHS (6)	/* number of authority fields */
-#define SID_MAX_SUB_AUTHORITIES (15) /* max number of sub authority fields */
+#include "../common/smbacl.h"
 
 #define READ_BIT        0x4
 #define WRITE_BIT       0x2
@@ -23,12 +22,6 @@
 #define UBITSHIFT	6
 #define GBITSHIFT	3
 
-#define ACCESS_ALLOWED	0
-#define ACCESS_DENIED	1
-
-#define SIDOWNER 1
-#define SIDGROUP 2
-
 /*
  * Security Descriptor length containing DACL with 3 ACEs (one each for
  * owner, group and world).
@@ -37,88 +30,6 @@
 			      sizeof(struct smb_acl) + \
 			      (sizeof(struct smb_ace) * 4))
 
-/*
- * Maximum size of a string representation of a SID:
- *
- * The fields are unsigned values in decimal. So:
- *
- * u8:  max 3 bytes in decimal
- * u32: max 10 bytes in decimal
- *
- * "S-" + 3 bytes for version field + 15 for authority field + NULL terminator
- *
- * For authority field, max is when all 6 values are non-zero and it must be
- * represented in hex. So "-0x" + 12 hex digits.
- *
- * Add 11 bytes for each subauthority field (10 bytes each + 1 for '-')
- */
-#define SID_STRING_BASE_SIZE (2 + 3 + 15 + 1)
-#define SID_STRING_SUBAUTH_SIZE (11) /* size of a single subauth string */
-
-struct smb_ntsd {
-	__le16 revision; /* revision level */
-	__le16 type;
-	__le32 osidoffset;
-	__le32 gsidoffset;
-	__le32 sacloffset;
-	__le32 dacloffset;
-} __attribute__((packed));
-
-struct smb_sid {
-	__u8 revision; /* revision level */
-	__u8 num_subauth;
-	__u8 authority[NUM_AUTHS];
-	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
-} __attribute__((packed));
-
-/* size of a struct smb_sid, sans sub_auth array */
-#define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
-
-struct smb_acl {
-	__le16 revision; /* revision level */
-	__le16 size;
-	__le32 num_aces;
-} __attribute__((packed));
-
-/* ACE types - see MS-DTYP 2.4.4.1 */
-#define ACCESS_ALLOWED_ACE_TYPE	0x00
-#define ACCESS_DENIED_ACE_TYPE	0x01
-#define SYSTEM_AUDIT_ACE_TYPE	0x02
-#define SYSTEM_ALARM_ACE_TYPE	0x03
-#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE 0x04
-#define ACCESS_ALLOWED_OBJECT_ACE_TYPE	0x05
-#define ACCESS_DENIED_OBJECT_ACE_TYPE	0x06
-#define SYSTEM_AUDIT_OBJECT_ACE_TYPE	0x07
-#define SYSTEM_ALARM_OBJECT_ACE_TYPE	0x08
-#define ACCESS_ALLOWED_CALLBACK_ACE_TYPE 0x09
-#define ACCESS_DENIED_CALLBACK_ACE_TYPE	0x0A
-#define ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE 0x0B
-#define ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE  0x0C
-#define SYSTEM_AUDIT_CALLBACK_ACE_TYPE	0x0D
-#define SYSTEM_ALARM_CALLBACK_ACE_TYPE	0x0E /* Reserved */
-#define SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE 0x0F
-#define SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE 0x10 /* reserved */
-#define SYSTEM_MANDATORY_LABEL_ACE_TYPE	0x11
-#define SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE 0x12
-#define SYSTEM_SCOPED_POLICY_ID_ACE_TYPE 0x13
-
-/* ACE flags */
-#define OBJECT_INHERIT_ACE	0x01
-#define CONTAINER_INHERIT_ACE	0x02
-#define NO_PROPAGATE_INHERIT_ACE 0x04
-#define INHERIT_ONLY_ACE	0x08
-#define INHERITED_ACE		0x10
-#define SUCCESSFUL_ACCESS_ACE_FLAG 0x40
-#define FAILED_ACCESS_ACE_FLAG	0x80
-
-struct smb_ace {
-	__u8 type; /* see above and MS-DTYP 2.4.4.1 */
-	__u8 flags;
-	__le16 size;
-	__le32 access_req;
-	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
-} __attribute__((packed));
-
 /*
  * The current SMB3 form of security descriptor is similar to what was used for
  * cifs (see above) but some fields are split, and fields in the struct below
diff --git a/fs/smb/common/smbacl.h b/fs/smb/common/smbacl.h
new file mode 100644
index 0000000000000..6a60698fc6f0f
--- /dev/null
+++ b/fs/smb/common/smbacl.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   Copyright (c) International Business Machines  Corp., 2007
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *   Modified by Namjae Jeon (linkinjeon@kernel.org)
+ */
+
+#ifndef _COMMON_SMBACL_H
+#define _COMMON_SMBACL_H
+
+#define NUM_AUTHS (6)	/* number of authority fields */
+#define SID_MAX_SUB_AUTHORITIES (15) /* max number of sub authority fields */
+
+/* ACE types - see MS-DTYP 2.4.4.1 */
+#define ACCESS_ALLOWED_ACE_TYPE 0x00
+#define ACCESS_DENIED_ACE_TYPE  0x01
+#define SYSTEM_AUDIT_ACE_TYPE   0x02
+#define SYSTEM_ALARM_ACE_TYPE   0x03
+#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE 0x04
+#define ACCESS_ALLOWED_OBJECT_ACE_TYPE  0x05
+#define ACCESS_DENIED_OBJECT_ACE_TYPE   0x06
+#define SYSTEM_AUDIT_OBJECT_ACE_TYPE    0x07
+#define SYSTEM_ALARM_OBJECT_ACE_TYPE    0x08
+#define ACCESS_ALLOWED_CALLBACK_ACE_TYPE 0x09
+#define ACCESS_DENIED_CALLBACK_ACE_TYPE 0x0A
+#define ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE 0x0B
+#define ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE  0x0C
+#define SYSTEM_AUDIT_CALLBACK_ACE_TYPE  0x0D
+#define SYSTEM_ALARM_CALLBACK_ACE_TYPE  0x0E /* Reserved */
+#define SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE 0x0F
+#define SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE 0x10 /* reserved */
+#define SYSTEM_MANDATORY_LABEL_ACE_TYPE 0x11
+#define SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE 0x12
+#define SYSTEM_SCOPED_POLICY_ID_ACE_TYPE 0x13
+
+/* ACE flags */
+#define OBJECT_INHERIT_ACE		0x01
+#define CONTAINER_INHERIT_ACE		0x02
+#define NO_PROPAGATE_INHERIT_ACE	0x04
+#define INHERIT_ONLY_ACE		0x08
+#define INHERITED_ACE			0x10
+#define SUCCESSFUL_ACCESS_ACE_FLAG	0x40
+#define FAILED_ACCESS_ACE_FLAG		0x80
+
+/*
+ * Maximum size of a string representation of a SID:
+ *
+ * The fields are unsigned values in decimal. So:
+ *
+ * u8:  max 3 bytes in decimal
+ * u32: max 10 bytes in decimal
+ *
+ * "S-" + 3 bytes for version field + 15 for authority field + NULL terminator
+ *
+ * For authority field, max is when all 6 values are non-zero and it must be
+ * represented in hex. So "-0x" + 12 hex digits.
+ *
+ * Add 11 bytes for each subauthority field (10 bytes each + 1 for '-')
+ */
+#define SID_STRING_BASE_SIZE (2 + 3 + 15 + 1)
+#define SID_STRING_SUBAUTH_SIZE (11) /* size of a single subauth string */
+
+#define DOMAIN_USER_RID_LE	cpu_to_le32(513)
+
+/*
+ * ACE types - see MS-DTYP 2.4.4.1
+ */
+enum {
+	ACCESS_ALLOWED,
+	ACCESS_DENIED,
+};
+
+/*
+ * Security ID types
+ */
+enum {
+	SIDOWNER = 1,
+	SIDGROUP,
+	SIDCREATOR_OWNER,
+	SIDCREATOR_GROUP,
+	SIDUNIX_USER,
+	SIDUNIX_GROUP,
+	SIDNFS_USER,
+	SIDNFS_GROUP,
+	SIDNFS_MODE,
+};
+
+struct smb_ntsd {
+	__le16 revision; /* revision level */
+	__le16 type;
+	__le32 osidoffset;
+	__le32 gsidoffset;
+	__le32 sacloffset;
+	__le32 dacloffset;
+} __attribute__((packed));
+
+struct smb_sid {
+	__u8 revision; /* revision level */
+	__u8 num_subauth;
+	__u8 authority[NUM_AUTHS];
+	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
+} __attribute__((packed));
+
+/* size of a struct smb_sid, sans sub_auth array */
+#define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
+
+struct smb_acl {
+	__le16 revision; /* revision level */
+	__le16 size;
+	__le32 num_aces;
+} __attribute__((packed));
+
+struct smb_ace {
+	__u8 type; /* see above and MS-DTYP 2.4.4.1 */
+	__u8 flags;
+	__le16 size;
+	__le32 access_req;
+	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
+} __attribute__((packed));
+
+#endif /* _COMMON_SMBACL_H */
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 2b52861707d8c..24ce576fc2924 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -8,6 +8,7 @@
 #ifndef _SMBACL_H
 #define _SMBACL_H
 
+#include "../common/smbacl.h"
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/posix_acl.h>
@@ -15,32 +16,6 @@
 
 #include "mgmt/tree_connect.h"
 
-#define NUM_AUTHS (6)	/* number of authority fields */
-#define SID_MAX_SUB_AUTHORITIES (15) /* max number of sub authority fields */
-
-/*
- * ACE types - see MS-DTYP 2.4.4.1
- */
-enum {
-	ACCESS_ALLOWED,
-	ACCESS_DENIED,
-};
-
-/*
- * Security ID types
- */
-enum {
-	SIDOWNER = 1,
-	SIDGROUP,
-	SIDCREATOR_OWNER,
-	SIDCREATOR_GROUP,
-	SIDUNIX_USER,
-	SIDUNIX_GROUP,
-	SIDNFS_USER,
-	SIDNFS_GROUP,
-	SIDNFS_MODE,
-};
-
 /* Revision for ACLs */
 #define SD_REVISION	1
 
@@ -62,92 +37,8 @@ enum {
 #define RM_CONTROL_VALID	0x4000
 #define SELF_RELATIVE		0x8000
 
-/* ACE types - see MS-DTYP 2.4.4.1 */
-#define ACCESS_ALLOWED_ACE_TYPE 0x00
-#define ACCESS_DENIED_ACE_TYPE  0x01
-#define SYSTEM_AUDIT_ACE_TYPE   0x02
-#define SYSTEM_ALARM_ACE_TYPE   0x03
-#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE 0x04
-#define ACCESS_ALLOWED_OBJECT_ACE_TYPE  0x05
-#define ACCESS_DENIED_OBJECT_ACE_TYPE   0x06
-#define SYSTEM_AUDIT_OBJECT_ACE_TYPE    0x07
-#define SYSTEM_ALARM_OBJECT_ACE_TYPE    0x08
-#define ACCESS_ALLOWED_CALLBACK_ACE_TYPE 0x09
-#define ACCESS_DENIED_CALLBACK_ACE_TYPE 0x0A
-#define ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE 0x0B
-#define ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE  0x0C
-#define SYSTEM_AUDIT_CALLBACK_ACE_TYPE  0x0D
-#define SYSTEM_ALARM_CALLBACK_ACE_TYPE  0x0E /* Reserved */
-#define SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE 0x0F
-#define SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE 0x10 /* reserved */
-#define SYSTEM_MANDATORY_LABEL_ACE_TYPE 0x11
-#define SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE 0x12
-#define SYSTEM_SCOPED_POLICY_ID_ACE_TYPE 0x13
-
-/* ACE flags */
-#define OBJECT_INHERIT_ACE		0x01
-#define CONTAINER_INHERIT_ACE		0x02
-#define NO_PROPAGATE_INHERIT_ACE	0x04
-#define INHERIT_ONLY_ACE		0x08
-#define INHERITED_ACE			0x10
-#define SUCCESSFUL_ACCESS_ACE_FLAG	0x40
-#define FAILED_ACCESS_ACE_FLAG		0x80
-
-/*
- * Maximum size of a string representation of a SID:
- *
- * The fields are unsigned values in decimal. So:
- *
- * u8:  max 3 bytes in decimal
- * u32: max 10 bytes in decimal
- *
- * "S-" + 3 bytes for version field + 15 for authority field + NULL terminator
- *
- * For authority field, max is when all 6 values are non-zero and it must be
- * represented in hex. So "-0x" + 12 hex digits.
- *
- * Add 11 bytes for each subauthority field (10 bytes each + 1 for '-')
- */
-#define SID_STRING_BASE_SIZE (2 + 3 + 15 + 1)
-#define SID_STRING_SUBAUTH_SIZE (11) /* size of a single subauth string */
-
-#define DOMAIN_USER_RID_LE	cpu_to_le32(513)
-
 struct ksmbd_conn;
 
-struct smb_ntsd {
-	__le16 revision; /* revision level */
-	__le16 type;
-	__le32 osidoffset;
-	__le32 gsidoffset;
-	__le32 sacloffset;
-	__le32 dacloffset;
-} __packed;
-
-struct smb_sid {
-	__u8 revision; /* revision level */
-	__u8 num_subauth;
-	__u8 authority[NUM_AUTHS];
-	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
-} __packed;
-
-/* size of a struct cifs_sid, sans sub_auth array */
-#define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
-
-struct smb_acl {
-	__le16 revision; /* revision level */
-	__le16 size;
-	__le32 num_aces;
-} __packed;
-
-struct smb_ace {
-	__u8 type;
-	__u8 flags;
-	__le16 size;
-	__le32 access_req;
-	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
-} __packed;
-
 struct smb_fattr {
 	kuid_t	cf_uid;
 	kgid_t	cf_gid;
-- 
2.53.0


