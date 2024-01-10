Return-Path: <stable+bounces-10353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F73827F24
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4331C23694
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D142BB666;
	Tue,  9 Jan 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3+vuaOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEEB65F;
	Tue,  9 Jan 2024 07:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10047C433F1;
	Tue,  9 Jan 2024 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704784722;
	bh=OS1e1e9Ztx9o8YppYunorF1HfEoODsm0pJfv21t2r9Y=;
	h=From:Date:Subject:To:Cc:From;
	b=W3+vuaOxhM2h5cjJ/xavzoJktSXMYsiLelDal5SiBb1l3TnqLftH5O/d9P9UojJQD
	 FWY7/F259EZYEth9wkL/U3XfI1GmAJjz/ZSqQ7SRw/IMkCj/evNgBycpHjvAmaJdgf
	 1nAf0UGFYQ8BGKP//ZAwJs9L0EX2LiwTd44ck3msUv+BAv42b0IP0JzPKbwwtiLOYV
	 WZoRx51rpTPfXwGpa7UeSzand0SukTzlgZsWKyjNlTqjq/DLbkynSC99kgrB24tlmP
	 5a5v4GjeZVT2Dk1/DLnSr2vG/yHd08TpiUFBb4jM5RyQ7JdzBtLVv+q27noZ8FK7X8
	 hUXBJ0Ke5I+QA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5961a2726aaso1576625eaf.0;
        Mon, 08 Jan 2024 23:18:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwxX2VI8Vw8dbq1pIc1GQovYUctdVyihgI1XIlxw0t6RdyFbRkR
	jxrRLb3+PPufJUEvXWyZjueNwq/O6VyCYf5oObY=
X-Google-Smtp-Source: AGHT+IEHK1Opfddrg457e2F92T7TXBjCQ1MfjhQBw7C9hy/9Ke0DCVHHyPkqrBSMCnSxqjtqzxQN9Z6ZP9Z6LXBnHlM=
X-Received: by 2002:a05:6820:2583:b0:595:21e7:67a1 with SMTP id
 cs3-20020a056820258300b0059521e767a1mr3481106oob.18.1704784720352; Mon, 08
 Jan 2024 23:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c13:0:b0:511:f2c1:11ee with HTTP; Mon, 8 Jan 2024
 23:18:39 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 9 Jan 2024 16:18:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-aYvX9nOZ=gjruv5Mk0eS9ZdF569QBk2YCqEvR_nwxPQ@mail.gmail.com>
Message-ID: <CAKYAXd-aYvX9nOZ=gjruv5Mk0eS9ZdF569QBk2YCqEvR_nwxPQ@mail.gmail.com>
Subject: [PATCH 6.1.y ] smb3: Replace smb2pdu 1-element arrays with flex-arrays
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-cifs@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Steve French <stfrench@microsoft.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Kees Cook <keescook@chromium.org>

commit eb3e28c1e89b4984308777231887e41aa8a0151f upstream.

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

Replace the trailing 1-element array with a flexible array in the
following structures:

	struct smb2_err_rsp
	struct smb2_tree_connect_req
	struct smb2_negotiate_rsp
	struct smb2_sess_setup_req
	struct smb2_sess_setup_rsp
	struct smb2_read_req
	struct smb2_read_rsp
	struct smb2_write_req
	struct smb2_write_rsp
	struct smb2_query_directory_req
	struct smb2_query_directory_rsp
	struct smb2_set_info_req
	struct smb2_change_notify_rsp
	struct smb2_create_rsp
	struct smb2_query_info_req
	struct smb2_query_info_rsp

Replace the trailing 1-element array with a flexible array, but leave
the existing structure padding:

	struct smb2_file_all_info
	struct smb2_lock_req

Adjust all related size calculations to match the changes to sizeof().

No machine code output or .data section differences are produced after
these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smb2file.c |  2 +-
 fs/smb/client/smb2misc.c |  2 +-
 fs/smb/client/smb2ops.c  | 14 +++++++-------
 fs/smb/client/smb2pdu.c  | 16 +++++++--------
 fs/smb/client/smb2pdu.h  |  2 +-
 fs/smb/common/smb2pdu.h  | 42 +++++++++++++++++++++++-----------------
 fs/smb/server/smb2ops.c  |  8 ++++----
 fs/smb/server/smb2pdu.c  |  8 +++-----
 8 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index ba6cc50af390..a7475bc05cac 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -34,7 +34,7 @@ static struct smb2_symlink_err_rsp
*symlink_data(const struct kvec *iov)
 		len = (u32)err->ErrorContextCount * (offsetof(struct smb2_error_context_rsp,
 							      ErrorContextData) +
 						     sizeof(struct smb2_symlink_err_rsp));
-		if (le32_to_cpu(err->ByteCount) < len || iov->iov_len < len + sizeof(*err))
+		if (le32_to_cpu(err->ByteCount) < len || iov->iov_len < len +
sizeof(*err) + 1)
 			return ERR_PTR(-EINVAL);

 		p = (struct smb2_error_context_rsp *)err->ErrorData;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 88942b1fb431..fdf7a7f188c5 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -113,7 +113,7 @@ static __u32 get_neg_ctxt_len(struct smb2_hdr
*hdr, __u32 len,
 	} else if (nc_offset + 1 == non_ctxlen) {
 		cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
 		size_of_pad_before_neg_ctxts = 0;
-	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE)
+	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE + 1)
 		/* has padding, but no SPNEGO blob */
 		size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen + 1;
 	else
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 285d360eb59a..4596d2dfdec3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5764,7 +5764,7 @@ struct smb_version_values smb20_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5786,7 +5786,7 @@ struct smb_version_values smb21_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5807,7 +5807,7 @@ struct smb_version_values smb3any_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5828,7 +5828,7 @@ struct smb_version_values smbdefault_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5849,7 +5849,7 @@ struct smb_version_values smb30_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5870,7 +5870,7 @@ struct smb_version_values smb302_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5891,7 +5891,7 @@ struct smb_version_values smb311_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 05ff8a457a3d..2dfbf1b23cfa 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1386,7 +1386,7 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)

 	/* Testing shows that buffer offset must be at location of Buffer[0] */
 	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req) - 1 /* pad */);
+		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
 	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);

 	memset(&rqst, 0, sizeof(struct smb_rqst));
@@ -1905,8 +1905,7 @@ SMB2_tcon(const unsigned int xid, struct
cifs_ses *ses, const char *tree,
 	iov[0].iov_len = total_len - 1;

 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req)
-			- 1 /* pad */);
+	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
 	req->PathLength = cpu_to_le16(unc_path_len - 2);
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
@@ -3796,7 +3795,7 @@ SMB2_change_notify(const unsigned int xid,
struct cifs_tcon *tcon,
 			ses->Suid, (u8)watch_tree, completion_filter);
 		/* validate that notify information is plausible */
 		if ((rsp_iov.iov_base == NULL) ||
-		    (rsp_iov.iov_len < sizeof(struct smb2_change_notify_rsp)))
+		    (rsp_iov.iov_len < sizeof(struct smb2_change_notify_rsp) + 1))
 			goto cnotify_exit;

 		smb_rsp = (struct smb2_change_notify_rsp *)rsp_iov.iov_base;
@@ -5009,7 +5008,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	memcpy(bufptr, &asteriks, len);

 	req->FileNameOffset =
-		cpu_to_le16(sizeof(struct smb2_query_directory_req) - 1);
+		cpu_to_le16(sizeof(struct smb2_query_directory_req));
 	req->FileNameLength = cpu_to_le16(len);
 	/*
 	 * BB could be 30 bytes or so longer if we used SMB2 specific
@@ -5205,8 +5204,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon,
struct TCP_Server_Info *server,
 	req->VolatileFileId = volatile_fid;
 	req->AdditionalInformation = cpu_to_le32(additional_info);

-	req->BufferOffset =
-			cpu_to_le16(sizeof(struct smb2_set_info_req) - 1);
+	req->BufferOffset = cpu_to_le16(sizeof(struct smb2_set_info_req));
 	req->BufferLength = cpu_to_le32(*size);

 	memcpy(req->Buffer, *data, *size);
@@ -5440,9 +5438,9 @@ build_qfs_info_req(struct kvec *iov, struct
cifs_tcon *tcon,
 	req->VolatileFileId = volatile_fid;
 	/* 1 for pad */
 	req->InputBufferOffset =
-			cpu_to_le16(sizeof(struct smb2_query_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_query_info_req));
 	req->OutputBufferLength = cpu_to_le32(
-		outbuf_len + sizeof(struct smb2_query_info_rsp) - 1);
+		outbuf_len + sizeof(struct smb2_query_info_rsp));

 	iov->iov_base = (char *)req;
 	iov->iov_len = total_len;
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 1237bb86e93a..a5773a06aba8 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -57,7 +57,7 @@ struct smb2_rdma_crypto_transform {
 #define COMPOUND_FID 0xFFFFFFFFFFFFFFFFULL

 #define SMB2_SYMLINK_STRUCT_SIZE \
-	(sizeof(struct smb2_err_rsp) - 1 + sizeof(struct smb2_symlink_err_rsp))
+	(sizeof(struct smb2_err_rsp) + sizeof(struct smb2_symlink_err_rsp))

 #define SYMLINK_ERROR_TAG 0x4c4d5953

diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 07549957b309..5593bb49954c 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -189,7 +189,7 @@ struct smb2_err_rsp {
 	__u8   ErrorContextCount;
 	__u8   Reserved;
 	__le32 ByteCount;  /* even if zero, at least one byte follows */
-	__u8   ErrorData[1];  /* variable length */
+	__u8   ErrorData[];  /* variable length */
 } __packed;

 #define SMB3_AES_CCM_NONCE 11
@@ -330,7 +330,7 @@ struct smb2_tree_connect_req {
 	__le16 Flags;		/* Flags in SMB3.1.1 */
 	__le16 PathOffset;
 	__le16 PathLength;
-	__u8   Buffer[1];	/* variable length */
+	__u8   Buffer[];	/* variable length */
 } __packed;

 /* Possible ShareType values */
@@ -617,7 +617,7 @@ struct smb2_negotiate_rsp {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;


@@ -638,7 +638,7 @@ struct smb2_sess_setup_req {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;

 /* Currently defined SessionFlags */
@@ -655,7 +655,7 @@ struct smb2_sess_setup_rsp {
 	__le16 SessionFlags;
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;


@@ -737,7 +737,7 @@ struct smb2_read_req {
 	__le32 RemainingBytes;
 	__le16 ReadChannelInfoOffset;
 	__le16 ReadChannelInfoLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 /* Read flags */
@@ -752,7 +752,7 @@ struct smb2_read_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;


@@ -776,7 +776,7 @@ struct smb2_write_req {
 	__le16 WriteChannelInfoOffset;
 	__le16 WriteChannelInfoLength;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 struct smb2_write_rsp {
@@ -787,7 +787,7 @@ struct smb2_write_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Reserved2;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;


@@ -834,7 +834,10 @@ struct smb2_lock_req {
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
 	/* Followed by at least one */
-	struct smb2_lock_element locks[1];
+	union {
+		struct smb2_lock_element lock;
+		DECLARE_FLEX_ARRAY(struct smb2_lock_element, locks);
+	};
 } __packed;

 struct smb2_lock_rsp {
@@ -888,7 +891,7 @@ struct smb2_query_directory_req {
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 struct smb2_query_directory_rsp {
@@ -896,7 +899,7 @@ struct smb2_query_directory_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 /*
@@ -919,7 +922,7 @@ struct smb2_set_info_req {
 	__le32 AdditionalInformation;
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 struct smb2_set_info_rsp {
@@ -974,7 +977,7 @@ struct smb2_change_notify_rsp {
 	__le16	StructureSize;  /* Must be 9 */
 	__le16	OutputBufferOffset;
 	__le32	OutputBufferLength;
-	__u8	Buffer[1]; /* array of file notify structs */
+	__u8	Buffer[]; /* array of file notify structs */
 } __packed;


@@ -1180,7 +1183,7 @@ struct smb2_create_rsp {
 	__u64  VolatileFileId;
 	__le32 CreateContextsOffset;
 	__le32 CreateContextsLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 struct create_posix {
@@ -1524,7 +1527,7 @@ struct smb2_query_info_req {
 	__le32 Flags;
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 struct smb2_query_info_rsp {
@@ -1532,7 +1535,7 @@ struct smb2_query_info_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;

 /*
@@ -1593,7 +1596,10 @@ struct smb2_file_all_info { /* data block
encoding of response to level 18 */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char   FileName[1];
+	union {
+		char __pad;	/* Legacy structure padding */
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __packed; /* level 18 Query */

 struct smb2_file_eof_info { /* encoding of request for level 10 */
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 535402629655..27a9dce3e03a 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -26,7 +26,7 @@ static struct smb_version_values smb21_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -52,7 +52,7 @@ static struct smb_version_values smb30_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -79,7 +79,7 @@ static struct smb_version_values smb302_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -106,7 +106,7 @@ static struct smb_version_values smb311_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ea48dd06d4da..6e5ed0ac578a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -294,8 +294,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
 	err = ksmbd_iov_pin_rsp(work, rsp,
-				sizeof(struct smb2_negotiate_rsp) -
-				sizeof(rsp->Buffer) + AUTH_GSS_LENGTH);
+				sizeof(struct smb2_negotiate_rsp) + AUTH_GSS_LENGTH);
 	if (err)
 		return err;
 	conn->use_spnego = true;
@@ -1263,9 +1262,8 @@ int smb2_handle_negotiate(struct ksmbd_work *work)

 	if (!rc)
 		rc = ksmbd_iov_pin_rsp(work, rsp,
-				       sizeof(struct smb2_negotiate_rsp) -
-					sizeof(rsp->Buffer) +
-					AUTH_GSS_LENGTH + neg_ctxt_len);
+				       sizeof(struct smb2_negotiate_rsp) +
+				       AUTH_GSS_LENGTH + neg_ctxt_len);
 	if (rc < 0)
 		smb2_set_err_rsp(work);
 	return rc;
-- 
2.34.1

