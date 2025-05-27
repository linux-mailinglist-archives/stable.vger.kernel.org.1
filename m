Return-Path: <stable+bounces-146973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF30AC5571
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B884A3E98
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84E253B4C;
	Tue, 27 May 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rDqu1FfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808986347;
	Tue, 27 May 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365881; cv=none; b=oq/R3nTUwtgBHasMBIn0T7IfzDW7pF9HeWLxzGmA45Nny4Hj9qoVn2QmX3keJGQjJW2mUHliRUKRj+Z3O18QBC1fpaqjh1Y8SSrpWNdsrjx74EZnanhMCl82rdZCMYT+atF10DZsk9Ee98PPT+kHAJr4oAWXhpEWpKJn7kQ9laQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365881; c=relaxed/simple;
	bh=vzGmQOXrUKeIOQCLMwPSbdosaJWodZDlF3bjULg0Yuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBqPAuVl3i0dkxUieJNFo30J1fmkq0wq99TShTbU+w7uit879TxthFoEMVpOyzHwbd4s2b1Tsk35OYTAd+dtpMnBE7XMVqO6VGVEMja/FAQQ77TO+o4D2l1w97iFXEXtok8diVAgKa2V1tL7FBQsgNdkoXNZbCQthgabjjVs01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rDqu1FfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFBFC4CEE9;
	Tue, 27 May 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365881;
	bh=vzGmQOXrUKeIOQCLMwPSbdosaJWodZDlF3bjULg0Yuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDqu1FfPLNR5JUrQ7KTbuPA41zYH/PLRb2KrRBXl3WwNV+E9+kHI185B6MVgFjCOY
	 axlyClpI00NjRpzG4oI2YBjQ3djlVxDdrdBMN0CQuDXeozSpjFcBSakODOpN+ADNLP
	 fm7u2BAju+BQMn30WSQIf2jeoDVPW8lEbCbO6N+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 520/626] cifs: Fix and improve cifs_query_path_info() and cifs_query_file_info()
Date: Tue, 27 May 2025 18:26:53 +0200
Message-ID: <20250527162506.095173628@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 1041c117a2c33cdffc4f695ac4b469e9124d24d5 ]

When CAP_NT_SMBS was not negotiated then do not issue CIFSSMBQPathInfo()
and CIFSSMBQFileInfo() commands. CIFSSMBQPathInfo() is not supported by
non-NT Win9x SMB server and CIFSSMBQFileInfo() returns from Win9x SMB
server bogus data in Attributes field (for example lot of files are marked
as reparse points, even Win9x does not support them and read-only bit is
not marked for read-only files). Correct information is returned by
CIFSFindFirst() or SMBQueryInformation() command.

So as a fallback in cifs_query_path_info() function use CIFSFindFirst()
with SMB_FIND_FILE_FULL_DIRECTORY_INFO level which is supported by both NT
and non-NT servers and as a last option use SMBQueryInformation() as it was
before.

And in function cifs_query_file_info() immediately returns -EOPNOTSUPP when
not communicating with NT server. Client then revalidate inode entry by the
cifs_query_path_info() call, which is working fine. So fstat() syscall on
already opened file will receive correct information.

Note that both fallback functions in non-UNICODE mode expands wildcards.
Therefore those fallback functions cannot be used on paths which contain
SMB wildcard characters (* ? " > <).

CIFSFindFirst() returns all 4 time attributes as opposite of
SMBQueryInformation() which returns only one.

With this change it is possible to query all 4 times attributes from Win9x
server and at the same time, client minimize sending of unsupported
commands to server.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1ops.c | 103 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 71fe5aa52630d..088fd84188b95 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -541,24 +541,104 @@ static int cifs_query_path_info(const unsigned int xid,
 				const char *full_path,
 				struct cifs_open_info_data *data)
 {
-	int rc;
+	int rc = -EOPNOTSUPP;
 	FILE_ALL_INFO fi = {};
+	struct cifs_search_info search_info = {};
+	bool non_unicode_wildcard = false;
 
 	data->reparse_point = false;
 	data->adjust_tz = false;
 
-	/* could do find first instead but this returns more info */
-	rc = CIFSSMBQPathInfo(xid, tcon, full_path, &fi, 0 /* not legacy */, cifs_sb->local_nls,
-			      cifs_remap(cifs_sb));
 	/*
-	 * BB optimize code so we do not make the above call when server claims
-	 * no NT SMB support and the above call failed at least once - set flag
-	 * in tcon or mount.
+	 * First try CIFSSMBQPathInfo() function which returns more info
+	 * (NumberOfLinks) than CIFSFindFirst() fallback function.
+	 * Some servers like Win9x do not support SMB_QUERY_FILE_ALL_INFO over
+	 * TRANS2_QUERY_PATH_INFORMATION, but supports it with filehandle over
+	 * TRANS2_QUERY_FILE_INFORMATION (function CIFSSMBQFileInfo(). But SMB
+	 * Open command on non-NT servers works only for files, does not work
+	 * for directories. And moreover Win9x SMB server returns bogus data in
+	 * SMB_QUERY_FILE_ALL_INFO Attributes field. So for non-NT servers,
+	 * do not even use CIFSSMBQPathInfo() or CIFSSMBQFileInfo() function.
+	 */
+	if (tcon->ses->capabilities & CAP_NT_SMBS)
+		rc = CIFSSMBQPathInfo(xid, tcon, full_path, &fi, 0 /* not legacy */,
+				      cifs_sb->local_nls, cifs_remap(cifs_sb));
+
+	/*
+	 * Non-UNICODE variant of fallback functions below expands wildcards,
+	 * so they cannot be used for querying paths with wildcard characters.
 	 */
-	if ((rc == -EOPNOTSUPP) || (rc == -EINVAL)) {
+	if (rc && !(tcon->ses->capabilities & CAP_UNICODE) && strpbrk(full_path, "*?\"><"))
+		non_unicode_wildcard = true;
+
+	/*
+	 * Then fallback to CIFSFindFirst() which works also with non-NT servers
+	 * but does not does not provide NumberOfLinks.
+	 */
+	if ((rc == -EOPNOTSUPP || rc == -EINVAL) &&
+	    !non_unicode_wildcard) {
+		if (!(tcon->ses->capabilities & tcon->ses->server->vals->cap_nt_find))
+			search_info.info_level = SMB_FIND_FILE_INFO_STANDARD;
+		else
+			search_info.info_level = SMB_FIND_FILE_FULL_DIRECTORY_INFO;
+		rc = CIFSFindFirst(xid, tcon, full_path, cifs_sb, NULL,
+				   CIFS_SEARCH_CLOSE_ALWAYS | CIFS_SEARCH_CLOSE_AT_END,
+				   &search_info, false);
+		if (rc == 0) {
+			if (!(tcon->ses->capabilities & tcon->ses->server->vals->cap_nt_find)) {
+				FIND_FILE_STANDARD_INFO *di;
+				int offset = tcon->ses->server->timeAdj;
+
+				di = (FIND_FILE_STANDARD_INFO *)search_info.srch_entries_start;
+				fi.CreationTime = cpu_to_le64(cifs_UnixTimeToNT(cnvrtDosUnixTm(
+						di->CreationDate, di->CreationTime, offset)));
+				fi.LastAccessTime = cpu_to_le64(cifs_UnixTimeToNT(cnvrtDosUnixTm(
+						di->LastAccessDate, di->LastAccessTime, offset)));
+				fi.LastWriteTime = cpu_to_le64(cifs_UnixTimeToNT(cnvrtDosUnixTm(
+						di->LastWriteDate, di->LastWriteTime, offset)));
+				fi.ChangeTime = fi.LastWriteTime;
+				fi.Attributes = cpu_to_le32(le16_to_cpu(di->Attributes));
+				fi.AllocationSize = cpu_to_le64(le32_to_cpu(di->AllocationSize));
+				fi.EndOfFile = cpu_to_le64(le32_to_cpu(di->DataSize));
+			} else {
+				FILE_FULL_DIRECTORY_INFO *di;
+
+				di = (FILE_FULL_DIRECTORY_INFO *)search_info.srch_entries_start;
+				fi.CreationTime = di->CreationTime;
+				fi.LastAccessTime = di->LastAccessTime;
+				fi.LastWriteTime = di->LastWriteTime;
+				fi.ChangeTime = di->ChangeTime;
+				fi.Attributes = di->ExtFileAttributes;
+				fi.AllocationSize = di->AllocationSize;
+				fi.EndOfFile = di->EndOfFile;
+				fi.EASize = di->EaSize;
+			}
+			fi.NumberOfLinks = cpu_to_le32(1);
+			fi.DeletePending = 0;
+			fi.Directory = !!(le32_to_cpu(fi.Attributes) & ATTR_DIRECTORY);
+			cifs_buf_release(search_info.ntwrk_buf_start);
+		} else if (!full_path[0]) {
+			/*
+			 * CIFSFindFirst() does not work on root path if the
+			 * root path was exported on the server from the top
+			 * level path (drive letter).
+			 */
+			rc = -EOPNOTSUPP;
+		}
+	}
+
+	/*
+	 * If everything failed then fallback to the legacy SMB command
+	 * SMB_COM_QUERY_INFORMATION which works with all servers, but
+	 * provide just few information.
+	 */
+	if ((rc == -EOPNOTSUPP || rc == -EINVAL) && !non_unicode_wildcard) {
 		rc = SMBQueryInformation(xid, tcon, full_path, &fi, cifs_sb->local_nls,
 					 cifs_remap(cifs_sb));
 		data->adjust_tz = true;
+	} else if ((rc == -EOPNOTSUPP || rc == -EINVAL) && non_unicode_wildcard) {
+		/* Path with non-UNICODE wildcard character cannot exist. */
+		rc = -ENOENT;
 	}
 
 	if (!rc) {
@@ -655,6 +735,13 @@ static int cifs_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	FILE_ALL_INFO fi = {};
 
+	/*
+	 * CIFSSMBQFileInfo() for non-NT servers returns bogus data in
+	 * Attributes fields. So do not use this command for non-NT servers.
+	 */
+	if (!(tcon->ses->capabilities & CAP_NT_SMBS))
+		return -EOPNOTSUPP;
+
 	if (cfile->symlink_target) {
 		data->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 		if (!data->symlink_target)
-- 
2.39.5




