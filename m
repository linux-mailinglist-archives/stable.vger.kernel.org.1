Return-Path: <stable+bounces-23653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE686716E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7EE28D9CA
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FA56B94;
	Mon, 26 Feb 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UePNgThD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F856740
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943442; cv=none; b=du4MStZKC9tzLjmUBlpE1SxXOMgudWU2I8JyKbYhPuX5Z2NxNxuUO37SBb7g9YAYd/+6EUDWaY+hE9LvlgsdFbNJobr86BX2jYI//32UXtorIdPqc7oV2XwKfaG/TtPHcAl3kGDG6bu1QjDCpKk+7KgIMV7PGmuxlVH29w0F3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943442; c=relaxed/simple;
	bh=L4GwXqdLopkKbcqeO01RkzSGW9F/JRX3i8Y2IjDpNqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZMT8CrNAbZ9YbT1vBprYBAWI6RF63QO3ln9JfWRa068mrsj0tvGpd2fbAaecWPN7z1G8c2+e8BfSwfNNrwy7EwdMQrK5maOl0lTg9sSjEubnySQvq7SKRYmN8L1lsItNUOqdHTgnoG4HAY7hXnydBRtFX53fX+Oi6LesW27p9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UePNgThD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QA3qhi017402;
	Mon, 26 Feb 2024 10:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=MTHTVJSC7NGvBQB8ApVbmZhc2WIm5s1EPLsRm2Antcs=;
 b=UePNgThDWvQm2elHG/2YVncz5GfnjA0vO3X/ReRyXj+ehKse8tukF6OigG1lR/3eEanO
 RFRHL+FaKj55/MHDLluVIOgKQXbED+GL6/038NMuTpddeURe4X5ibytW+AndujpJh6OQ
 EqOW4qxxa5s6pQwHDWjlBh6YFemGKceRUzAYlQHWmynqW2S3pRJ8fm0kU/mAyDTZziL3
 AVU68hxv/LYRwN9cpxZPinec1iF4cXigItKqKpZe3s3snOfoVn6rKJVJTWyTaMVXoDnx
 oU1eTWNipJTRlxY/NILv4Gy+xtyPJ3591dP9dQaPgkPYQS216aZ4bKvcBrpCooZ21ep6 yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdv9fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:30:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QAQ0Ji022347;
	Mon, 26 Feb 2024 10:30:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5f8rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:30:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QAQ0VM022375;
	Mon, 26 Feb 2024 10:30:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wf6w5f8jw-1;
	Mon, 26 Feb 2024 10:30:34 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: nspmangalore@gmail.com, smfrench@gmail.com, stable@vger.kernel.org
Cc: sprasad@microsoft.com, stfrench@microsoft.com, darren.kenny@oracle.com,
        dai.ngo@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y] cifs: fix mid leak during reconnection after timeout threshold
Date: Mon, 26 Feb 2024 02:30:25 -0800
Message-ID: <20240226103025.736067-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260079
X-Proofpoint-ORIG-GUID: tHz6yXOvhVnrjGylMNKBGM6yciwC5FU3
X-Proofpoint-GUID: tHz6yXOvhVnrjGylMNKBGM6yciwC5FU3

From: Shyam Prasad N <nspmangalore@gmail.com>

commit 69cba9d3c1284e0838ae408830a02c4a063104bc upstream.

When the number of responses with status of STATUS_IO_TIMEOUT
exceeds a specified threshold (NUM_STATUS_IO_TIMEOUT), we reconnect
the connection. But we do not return the mid, or the credits
returned for the mid, or reduce the number of in-flight requests.

This bug could result in the server->in_flight count to go bad,
and also cause a leak in the mids.

This change moves the check to a few lines below where the
response is decrypted, even of the response is read from the
transform header. This way, the code for returning the mids
can be reused.

Also, the cifs_reconnect was reconnecting just the transport
connection before. In case of multi-channel, this may not be
what we want to do after several timeouts. Changed that to
reconnect the session and the tree too.

Also renamed NUM_STATUS_IO_TIMEOUT to a more appropriate name
MAX_STATUS_IO_TIMEOUT.

Fixes: 8e670f77c4a5 ("Handle STATUS_IO_TIMEOUT gracefully")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Harshit: Backport to 5.15.y]
 Conflicts:
	fs/cifs/connect.c -- 5.15.y doesn't have commit 183eea2ee5ba
	("cifs: reconnect only the connection and not smb session where
 possible") -- User cifs_reconnect(server) instead of
cifs_reconnect(server, true)

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Would be nice to get a review from author/maintainer of the upstream patch.

A backport request was made previously but the patch didnot apply
cleanly then:
https://lore.kernel.org/all/CANT5p=oPGnCd4H5ppMbAiHsAKMor3LT_aQRqU7tKu=q6q1BGQg@mail.gmail.com/

xfstests with cifs done: before and after patching with this patch on 5.15.149.
There is no change in test results before and after the patch.

Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
generic/393 generic/394
Not run: generic/010 generic/286 generic/315
Failures: generic/075 generic/112 generic/127 generic/285
Failed 4 of 68 tests

SECTION       -- smb3
=========================
Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
generic/393 generic/394
Not run: generic/010 generic/014 generic/129 generic/130 generic/239
Failures: generic/075 generic/091 generic/112 generic/127 generic/263 generic/285 generic/286
Failed 7 of 68 tests

SECTION       -- smb21
=========================
Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
generic/393 generic/394
Not run: generic/010 generic/014 generic/129 generic/130 generic/239 generic/286 generic/315
Failures: generic/075 generic/112 generic/127 generic/285
Failed 4 of 68 tests

SECTION       -- smb2
=========================
Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
generic/393 generic/394
Not run: generic/010 generic/286 generic/315
Failures: generic/075 generic/112 generic/127 generic/285
Failed 4 of 68 tests
---
 fs/cifs/connect.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a521c705b0d7..a3e4811b7871 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -59,7 +59,7 @@ extern bool disable_legacy_dialects;
 #define TLINK_IDLE_EXPIRE	(600 * HZ)
 
 /* Drop the connection to not overload the server */
-#define NUM_STATUS_IO_TIMEOUT   5
+#define MAX_STATUS_IO_TIMEOUT   5
 
 struct mount_ctx {
 	struct cifs_sb_info *cifs_sb;
@@ -965,6 +965,7 @@ cifs_demultiplex_thread(void *p)
 	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout = 0;
+	bool pending_reconnect = false;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
@@ -1004,6 +1005,8 @@ cifs_demultiplex_thread(void *p)
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
 			continue;
+
+		pending_reconnect = false;
 next_pdu:
 		server->pdu_size = pdu_length;
 
@@ -1063,10 +1066,13 @@ cifs_demultiplex_thread(void *p)
 		if (server->ops->is_status_io_timeout &&
 		    server->ops->is_status_io_timeout(buf)) {
 			num_io_timeout++;
-			if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
-				cifs_reconnect(server);
+			if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
+				cifs_server_dbg(VFS,
+						"Number of request timeouts exceeded %d. Reconnecting",
+						MAX_STATUS_IO_TIMEOUT);
+
+				pending_reconnect = true;
 				num_io_timeout = 0;
-				continue;
 			}
 		}
 
@@ -1113,6 +1119,11 @@ cifs_demultiplex_thread(void *p)
 			buf = server->smallbuf;
 			goto next_pdu;
 		}
+
+		/* do this reconnect at the very end after processing all MIDs */
+		if (pending_reconnect)
+			cifs_reconnect(server);
+
 	} /* end while !EXITING */
 
 	/* buffer usually freed in free_mid - need to free it here on exit */
-- 
2.43.0


