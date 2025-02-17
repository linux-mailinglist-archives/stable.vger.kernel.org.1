Return-Path: <stable+bounces-115725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBECA3448F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245047A1EE0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A926B098;
	Thu, 13 Feb 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKq+HG4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCD26B08A;
	Thu, 13 Feb 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459033; cv=none; b=UnDJVos6CJF5e/5kFJ2sMka+aPmBR5y6kfrrp1KQCrIJUJRKRs+skzu8hx5awOfyirwJ4YVdTmtIR9nJzreDX6jR0l0f3f1S00SkxDzElw8tRuvo6bRtMcXQHuY5HBejJeq69QHuLlrpZktIEwfH+wZdzFiFc4s3SxSCuIpVTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459033; c=relaxed/simple;
	bh=VRWbBDiwftCTpunqEaHpyVppUPDRaQI80oM/TvOLog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXRRJF9syHdzccDM/UU1Kgd17A3+dgv6BRjvGG8Wil2IgvONqIsUhLd0iyuRvCnG+vpwmfHLJw7UL0J6IJLHnBRVWpWf1GDNW4oU/3pSny6w7ki2ZYmmYgfROPPbfFXPX4obwjsLJzW4yh5Sz564Z5IDmTYDV7M0zYNRa4kK5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKq+HG4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E07C4CED1;
	Thu, 13 Feb 2025 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459033;
	bh=VRWbBDiwftCTpunqEaHpyVppUPDRaQI80oM/TvOLog4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKq+HG4yu3w4g9O0JkVTjjcMVsW5m4iyVaixwI6xtStZDbbY7kGj1vePSX1StTTbg
	 fB2c6vxzAKDJO5sVkP4iPv+55tQCdqE/7wheE9dwjijfPFDdr1kq56KNmMxhdWtq/V
	 8VShuMKJgVaQV+yzSkZ5STyH7MqtyH38aITBHFoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruben Devos <devosruben6@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13 149/443] smb: client: fix order of arguments of tracepoints
Date: Thu, 13 Feb 2025 15:25:14 +0100
Message-ID: <20250213142446.347030948@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruben Devos <devosruben6@gmail.com>

commit 11f8b80ab9f99291dc88d09855b9f8f43b772335 upstream.

The tracepoints based on smb3_inf_compound_*_class have tcon id and
session id swapped around. This results in incorrect output in
`trace-cmd report`.

Fix the order of arguments to resolve this issue. The trace-cmd output
below shows the before and after of the smb3_delete_enter and
smb3_delete_done events as an example. The smb3_cmd_* events show the
correct session and tcon id for reference.

Also fix tracepoint set -> get in the SMB2_OP_GET_REPARSE case.

BEFORE:
rm-2211  [001] .....  1839.550888: smb3_delete_enter:    xid=281 sid=0x5 tid=0x3d path=\hello2.txt
rm-2211  [001] .....  1839.550894: smb3_cmd_enter:        sid=0x1ac000000003d tid=0x5 cmd=5 mid=61
rm-2211  [001] .....  1839.550896: smb3_cmd_enter:        sid=0x1ac000000003d tid=0x5 cmd=6 mid=62
rm-2211  [001] .....  1839.552091: smb3_cmd_done:         sid=0x1ac000000003d tid=0x5 cmd=5 mid=61
rm-2211  [001] .....  1839.552093: smb3_cmd_done:         sid=0x1ac000000003d tid=0x5 cmd=6 mid=62
rm-2211  [001] .....  1839.552103: smb3_delete_done:     xid=281 sid=0x5 tid=0x3d

AFTER:
rm-2501  [001] .....  3237.656110: smb3_delete_enter:    xid=88 sid=0x1ac0000000041 tid=0x5 path=\hello2.txt
rm-2501  [001] .....  3237.656122: smb3_cmd_enter:        sid=0x1ac0000000041 tid=0x5 cmd=5 mid=84
rm-2501  [001] .....  3237.656123: smb3_cmd_enter:        sid=0x1ac0000000041 tid=0x5 cmd=6 mid=85
rm-2501  [001] .....  3237.657909: smb3_cmd_done:         sid=0x1ac0000000041 tid=0x5 cmd=5 mid=84
rm-2501  [001] .....  3237.657909: smb3_cmd_done:         sid=0x1ac0000000041 tid=0x5 cmd=6 mid=85
rm-2501  [001] .....  3237.657922: smb3_delete_done:     xid=88 sid=0x1ac0000000041 tid=0x5

Cc: stable@vger.kernel.org
Signed-off-by: Ruben Devos <devosruben6@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/dir.c       |    6 +-
 fs/smb/client/smb2inode.c |  108 +++++++++++++++++++++++-----------------------
 2 files changed, 57 insertions(+), 57 deletions(-)

--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -627,7 +627,7 @@ int cifs_mknod(struct mnt_idmap *idmap,
 		goto mknod_out;
 	}
 
-	trace_smb3_mknod_enter(xid, tcon->ses->Suid, tcon->tid, full_path);
+	trace_smb3_mknod_enter(xid, tcon->tid, tcon->ses->Suid, full_path);
 
 	rc = tcon->ses->server->ops->make_node(xid, inode, direntry, tcon,
 					       full_path, mode,
@@ -635,9 +635,9 @@ int cifs_mknod(struct mnt_idmap *idmap,
 
 mknod_out:
 	if (rc)
-		trace_smb3_mknod_err(xid,  tcon->ses->Suid, tcon->tid, rc);
+		trace_smb3_mknod_err(xid,  tcon->tid, tcon->ses->Suid, rc);
 	else
-		trace_smb3_mknod_done(xid, tcon->ses->Suid, tcon->tid);
+		trace_smb3_mknod_done(xid, tcon->tid, tcon->ses->Suid);
 
 	free_dentry_path(page);
 	free_xid(xid);
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -298,8 +298,8 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_query_info_compound_enter(xid, ses->Suid,
-							     tcon->tid, full_path);
+			trace_smb3_query_info_compound_enter(xid, tcon->tid,
+							     ses->Suid, full_path);
 			break;
 		case SMB2_OP_POSIX_QUERY_INFO:
 			rqst[num_rqst].rq_iov = &vars->qi_iov;
@@ -334,18 +334,18 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_posix_query_info_compound_enter(xid, ses->Suid,
-								   tcon->tid, full_path);
+			trace_smb3_posix_query_info_compound_enter(xid, tcon->tid,
+								   ses->Suid, full_path);
 			break;
 		case SMB2_OP_DELETE:
-			trace_smb3_delete_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_delete_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_MKDIR:
 			/*
 			 * Directories are created through parameters in the
 			 * SMB2_open() call.
 			 */
-			trace_smb3_mkdir_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_mkdir_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_RMDIR:
 			rqst[num_rqst].rq_iov = &vars->si_iov[0];
@@ -363,7 +363,7 @@ replay_again:
 				goto finished;
 			smb2_set_next_command(tcon, &rqst[num_rqst]);
 			smb2_set_related(&rqst[num_rqst++]);
-			trace_smb3_rmdir_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_rmdir_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_SET_EOF:
 			rqst[num_rqst].rq_iov = &vars->si_iov[0];
@@ -398,7 +398,7 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_set_eof_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_set_eof_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_SET_INFO:
 			rqst[num_rqst].rq_iov = &vars->si_iov[0];
@@ -429,8 +429,8 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_set_info_compound_enter(xid, ses->Suid,
-							   tcon->tid, full_path);
+			trace_smb3_set_info_compound_enter(xid, tcon->tid,
+							   ses->Suid, full_path);
 			break;
 		case SMB2_OP_RENAME:
 			rqst[num_rqst].rq_iov = &vars->si_iov[0];
@@ -469,7 +469,7 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_rename_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_rename_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_HARDLINK:
 			rqst[num_rqst].rq_iov = &vars->si_iov[0];
@@ -496,7 +496,7 @@ replay_again:
 				goto finished;
 			smb2_set_next_command(tcon, &rqst[num_rqst]);
 			smb2_set_related(&rqst[num_rqst++]);
-			trace_smb3_hardlink_enter(xid, ses->Suid, tcon->tid, full_path);
+			trace_smb3_hardlink_enter(xid, tcon->tid, ses->Suid, full_path);
 			break;
 		case SMB2_OP_SET_REPARSE:
 			rqst[num_rqst].rq_iov = vars->io_iov;
@@ -523,8 +523,8 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_set_reparse_compound_enter(xid, ses->Suid,
-							      tcon->tid, full_path);
+			trace_smb3_set_reparse_compound_enter(xid, tcon->tid,
+							      ses->Suid, full_path);
 			break;
 		case SMB2_OP_GET_REPARSE:
 			rqst[num_rqst].rq_iov = vars->io_iov;
@@ -549,8 +549,8 @@ replay_again:
 				goto finished;
 			}
 			num_rqst++;
-			trace_smb3_get_reparse_compound_enter(xid, ses->Suid,
-							      tcon->tid, full_path);
+			trace_smb3_get_reparse_compound_enter(xid, tcon->tid,
+							      ses->Suid, full_path);
 			break;
 		case SMB2_OP_QUERY_WSL_EA:
 			rqst[num_rqst].rq_iov = &vars->ea_iov;
@@ -663,11 +663,11 @@ finished:
 			}
 			SMB2_query_info_free(&rqst[num_rqst++]);
 			if (rc)
-				trace_smb3_query_info_compound_err(xid,  ses->Suid,
-								   tcon->tid, rc);
+				trace_smb3_query_info_compound_err(xid,  tcon->tid,
+								   ses->Suid, rc);
 			else
-				trace_smb3_query_info_compound_done(xid, ses->Suid,
-								    tcon->tid);
+				trace_smb3_query_info_compound_done(xid, tcon->tid,
+								    ses->Suid);
 			break;
 		case SMB2_OP_POSIX_QUERY_INFO:
 			idata = in_iov[i].iov_base;
@@ -690,15 +690,15 @@ finished:
 
 			SMB2_query_info_free(&rqst[num_rqst++]);
 			if (rc)
-				trace_smb3_posix_query_info_compound_err(xid,  ses->Suid,
-									 tcon->tid, rc);
+				trace_smb3_posix_query_info_compound_err(xid,  tcon->tid,
+									 ses->Suid, rc);
 			else
-				trace_smb3_posix_query_info_compound_done(xid, ses->Suid,
-									  tcon->tid);
+				trace_smb3_posix_query_info_compound_done(xid, tcon->tid,
+									  ses->Suid);
 			break;
 		case SMB2_OP_DELETE:
 			if (rc)
-				trace_smb3_delete_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_delete_err(xid, tcon->tid, ses->Suid, rc);
 			else {
 				/*
 				 * If dentry (hence, inode) is NULL, lease break is going to
@@ -706,59 +706,59 @@ finished:
 				 */
 				if (inode)
 					cifs_mark_open_handles_for_deleted_file(inode, full_path);
-				trace_smb3_delete_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_delete_done(xid, tcon->tid, ses->Suid);
 			}
 			break;
 		case SMB2_OP_MKDIR:
 			if (rc)
-				trace_smb3_mkdir_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_mkdir_err(xid, tcon->tid, ses->Suid, rc);
 			else
-				trace_smb3_mkdir_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_mkdir_done(xid, tcon->tid, ses->Suid);
 			break;
 		case SMB2_OP_HARDLINK:
 			if (rc)
-				trace_smb3_hardlink_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_hardlink_err(xid,  tcon->tid, ses->Suid, rc);
 			else
-				trace_smb3_hardlink_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_hardlink_done(xid, tcon->tid, ses->Suid);
 			SMB2_set_info_free(&rqst[num_rqst++]);
 			break;
 		case SMB2_OP_RENAME:
 			if (rc)
-				trace_smb3_rename_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_rename_err(xid, tcon->tid, ses->Suid, rc);
 			else
-				trace_smb3_rename_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_rename_done(xid, tcon->tid, ses->Suid);
 			SMB2_set_info_free(&rqst[num_rqst++]);
 			break;
 		case SMB2_OP_RMDIR:
 			if (rc)
-				trace_smb3_rmdir_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_rmdir_err(xid, tcon->tid, ses->Suid, rc);
 			else
-				trace_smb3_rmdir_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_rmdir_done(xid, tcon->tid, ses->Suid);
 			SMB2_set_info_free(&rqst[num_rqst++]);
 			break;
 		case SMB2_OP_SET_EOF:
 			if (rc)
-				trace_smb3_set_eof_err(xid,  ses->Suid, tcon->tid, rc);
+				trace_smb3_set_eof_err(xid, tcon->tid, ses->Suid, rc);
 			else
-				trace_smb3_set_eof_done(xid, ses->Suid, tcon->tid);
+				trace_smb3_set_eof_done(xid, tcon->tid, ses->Suid);
 			SMB2_set_info_free(&rqst[num_rqst++]);
 			break;
 		case SMB2_OP_SET_INFO:
 			if (rc)
-				trace_smb3_set_info_compound_err(xid,  ses->Suid,
-								 tcon->tid, rc);
+				trace_smb3_set_info_compound_err(xid,  tcon->tid,
+								 ses->Suid, rc);
 			else
-				trace_smb3_set_info_compound_done(xid, ses->Suid,
-								  tcon->tid);
+				trace_smb3_set_info_compound_done(xid, tcon->tid,
+								  ses->Suid);
 			SMB2_set_info_free(&rqst[num_rqst++]);
 			break;
 		case SMB2_OP_SET_REPARSE:
 			if (rc) {
-				trace_smb3_set_reparse_compound_err(xid,  ses->Suid,
-								    tcon->tid, rc);
+				trace_smb3_set_reparse_compound_err(xid, tcon->tid,
+								    ses->Suid, rc);
 			} else {
-				trace_smb3_set_reparse_compound_done(xid, ses->Suid,
-								     tcon->tid);
+				trace_smb3_set_reparse_compound_done(xid, tcon->tid,
+								     ses->Suid);
 			}
 			SMB2_ioctl_free(&rqst[num_rqst++]);
 			break;
@@ -771,18 +771,18 @@ finished:
 				rbuf = reparse_buf_ptr(iov);
 				if (IS_ERR(rbuf)) {
 					rc = PTR_ERR(rbuf);
-					trace_smb3_set_reparse_compound_err(xid,  ses->Suid,
-									    tcon->tid, rc);
+					trace_smb3_get_reparse_compound_err(xid, tcon->tid,
+									    ses->Suid, rc);
 				} else {
 					idata->reparse.tag = le32_to_cpu(rbuf->ReparseTag);
-					trace_smb3_set_reparse_compound_done(xid, ses->Suid,
-									     tcon->tid);
+					trace_smb3_get_reparse_compound_done(xid, tcon->tid,
+									     ses->Suid);
 				}
 				memset(iov, 0, sizeof(*iov));
 				resp_buftype[i + 1] = CIFS_NO_BUFFER;
 			} else {
-				trace_smb3_set_reparse_compound_err(xid, ses->Suid,
-								    tcon->tid, rc);
+				trace_smb3_get_reparse_compound_err(xid, tcon->tid,
+								    ses->Suid, rc);
 			}
 			SMB2_ioctl_free(&rqst[num_rqst++]);
 			break;
@@ -799,11 +799,11 @@ finished:
 				}
 			}
 			if (!rc) {
-				trace_smb3_query_wsl_ea_compound_done(xid, ses->Suid,
-								      tcon->tid);
+				trace_smb3_query_wsl_ea_compound_done(xid, tcon->tid,
+								      ses->Suid);
 			} else {
-				trace_smb3_query_wsl_ea_compound_err(xid, ses->Suid,
-								     tcon->tid, rc);
+				trace_smb3_query_wsl_ea_compound_err(xid, tcon->tid,
+								     ses->Suid, rc);
 			}
 			SMB2_query_info_free(&rqst[num_rqst++]);
 			break;



