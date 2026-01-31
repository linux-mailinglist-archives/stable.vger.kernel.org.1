Return-Path: <stable+bounces-212935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNmUMz23fWlwTQIAu9opvQ
	(envelope-from <stable+bounces-212935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 09:03:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B04C12BC
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3028300CE4C
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F82EDD4D;
	Sat, 31 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMe8LG9p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2C2BDC27
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769846585; cv=none; b=ggaRX5KoYe4C79fJkO4m/WqLsO/GM/aBIuHcyiWrFHMeDBRX0LzD9hK1oNfSmnIwtDGuPew86oCOUxGA8GHd5i2+GdDo4YbUalDgnkdMSCYhcmUdLWFHrPMc1jCSY3uOB/HvKIXnzKHr7PEOLATjjc6B1kSnNkfJfbsdGg9uKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769846585; c=relaxed/simple;
	bh=dBbkA3s8ZDlYOu+fYRUqtVqIzyY2MkklyEgHq02a5fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrNZ+5I342QaUtsqTAlD/WPUGjWlYfaRax6p24KDhEKyzvPM3IGbZWOkGoj5gzr3R7kB6CZbt2RbxTQv1PpuhZVH6aq0+wlo7/bxtPq0w5WIhC8+PpbP/cCt9pFU4h1qNHXdBez01O5ZVzS0X1XguK8TDof9BQ/sAItFEphiFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMe8LG9p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso1169644a12.0
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 00:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769846583; x=1770451383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XcWW/vYfFgkZEN1KNi9wjY+Xh26NCKHQFJADTAEK40=;
        b=VMe8LG9p9LvaiT2CX/lJZ7XcM0lCSdiOcrsZZ8H+1r8VoeDcTVON+rAcA57oZaDid+
         xh2wxKeZ0F8tkKjtbJga4vPNo9c4xJssQZpwKZjGMtmFOIMRN6flPYSdVMUS7OdEfVLD
         Atx3Qh2tKFYXzteIRklvb7ZmkujzqcQsmXT14PP4E+36lDHeuCJatNZSb6aMSJQF4w3C
         mcknrpxThbRxHzIUH7sD3zmVxCaTjdsV7NWWE8gkW+2xRJZJinpN2u6nUp/y/y0141nE
         3K9u3MgVVTOLEl+3T9algye9YB1gWeV+sOwPtzzatkxUuF8SaL/PycHy9OpBeX2aTna0
         gGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769846583; x=1770451383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XcWW/vYfFgkZEN1KNi9wjY+Xh26NCKHQFJADTAEK40=;
        b=E+zxtrbmLOqdtg3jcZyH3YVYHtTTTnGKUXjJiZMmkIuogAPUknsBhSM4OTJdeKdZ9u
         EBg65PdJgGoMBPv1q2jfBe6Kt0a4TdA1PTgoiAHA84vTb2U5QSwxwCF6/XjlQ9ko4E+u
         WR0f4EbMPseAzC8vjrFldXnhXJABg34lmMF35YzDmM845rzPS7IGeYGEYg0hRDT5xyay
         fTq3mfx05g20aS0TteM7XIQVw0D/8w5teKXgldcQEQnwXKSR7n9MKxa+RazRA5iGD+pP
         Gb80LM/DKEpAJWBbB9wRRSjRwEbfpt0MP/clUnN0QJFFEFmEjV0qbfSQWYOl61YymFH6
         rsJA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Rj3Wi5cy9f4OKdiR4s7wsR5masujvNLB62qDaZT3cfbj4RQPo1c5S8VSbGSUAp9vjY89HBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtmpvfClRaRn5EFmmIo1jv6z+eLyR0NtDc2lidM9Agjg11vHK
	4wwB2gd+MGxIdvePBjsEM6RVN4VCCncZjE33sVLoutYjsoy3FQXHRL6a
X-Gm-Gg: AZuq6aIc6WRKDjhM2i13rQlFSTeJf07iFacXJxeZA1uvqg/Ql3ijRNnpH5n7yRxkIUH
	SCfZsczgoFnose05txkmGDSg/EtZ29Ix3/4Ks/SroL9rKGnXK/suMDwJDe07tgJ7p/m9JcbSU9D
	J/4K31TrC2PyxBnnDeE2qDkslsGeN60QaPnTqFtBgZECIjfAH07tMyWSGXCf+z5ie3orP+rLQcq
	eNB24Nb6QgnE8sPwVwcw46gX8CTBKlwsUocKFoTcwMtCQPy/VRb7kPupGyDyaX6ARSgrNmyhOVx
	F51jA1bJLkRsvVyne4A4NnWG9TYOvb22L3eG1wuBj/Jm8TkhVNH3oVA9E+BiO2jV+CmjqXqQkI6
	qHuRfOjKk3RMoTYOgiL7FtXgfZ5b9Ojh5J689qoNDQAHWwq1wUcayoK6yUpk9FihU7htkfNf5Um
	KSmKcGATOWfx7LfRGphUwZ+EKPur2lGnqGrzMOEmHG
X-Received: by 2002:a17:902:e88a:b0:2a0:c1ed:c8c2 with SMTP id d9443c01a7336-2a8d99458d9mr49139415ad.55.1769846582973;
        Sat, 31 Jan 2026 00:03:02 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f6c7csm98853045ad.98.2026.01.31.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 00:03:02 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cifs: Fix locking usage for tcon fields
Date: Sat, 31 Jan 2026 13:32:16 +0530
Message-ID: <20260131080239.943483-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131080239.943483-1-sprasad@microsoft.com>
References: <20260131080239.943483-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212935-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org]
X-Rspamd-Queue-Id: 49B04C12BC
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

We used to use the cifs_tcp_ses_lock to protect a lot of objects
that are not just the server, ses or tcon lists. We later introduced
srv_lock, ses_lock and tc_lock to protect fields within the
corresponding structs. This was done to provide a more granular
protection and avoid unnecessary serialization.

There were still a couple of uses of cifs_tcp_ses_lock to provide
tcon fields. In this patch, I've replaced them with tc_lock.

Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/cached_dir.c | 4 ++--
 fs/smb/client/smb2misc.c   | 6 +++---
 fs/smb/client/smb2ops.c    | 8 +++-----
 fs/smb/client/smb2pdu.c    | 2 ++
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 1db7ab6c2529c..84c3aea18a1a7 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -788,11 +788,11 @@ static void cfids_laundromat_worker(struct work_struct *work)
 		cfid->dentry = NULL;
 
 		if (cfid->is_open) {
-			spin_lock(&cifs_tcp_ses_lock);
+			spin_lock(&tcon->tc_lock);
 			++cfid->tcon->tc_count;
 			trace_smb3_tcon_ref(cfid->tcon->debug_id, cfid->tcon->tc_count,
 					    netfs_trace_tcon_ref_get_cached_laundromat);
-			spin_unlock(&cifs_tcp_ses_lock);
+			spin_unlock(&tcon->tc_lock);
 			queue_work(serverclose_wq, &cfid->close_work);
 		} else
 			/*
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f3cb62d914502..0871b9f1f86a6 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -820,14 +820,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	int rc;
 
 	cifs_dbg(FYI, "%s: tc_count=%d\n", __func__, tcon->tc_count);
-	spin_lock(&cifs_tcp_ses_lock);
+	spin_lock(&tcon->tc_lock);
 	if (tcon->tc_count <= 0) {
 		struct TCP_Server_Info *server = NULL;
 
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_see_cancelled_close);
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
-		spin_unlock(&cifs_tcp_ses_lock);
+		spin_unlock(&tcon->tc_lock);
 
 		if (tcon->ses) {
 			server = tcon->ses->server;
@@ -841,7 +841,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	tcon->tc_count++;
 	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 			    netfs_trace_tcon_ref_get_cancelled_close);
-	spin_unlock(&cifs_tcp_ses_lock);
+	spin_unlock(&tcon->tc_lock);
 
 	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
 					 persistent_fid, volatile_fid);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index c1aaf77e187b6..6f930d6c78adb 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3091,7 +3091,9 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 						struct cifs_tcon,
 						tcon_list);
 		if (tcon) {
+			spin_lock(&tcon->tc_lock);
 			tcon->tc_count++;
+			spin_unlock(&tcon->tc_lock);
 			trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 					    netfs_trace_tcon_ref_get_dfs_refer);
 		}
@@ -3160,13 +3162,9 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
  out:
 	if (tcon && !tcon->ipc) {
 		/* ipc tcons are not refcounted */
-		spin_lock(&cifs_tcp_ses_lock);
-		tcon->tc_count--;
+		cifs_put_tcon(tcon);
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_dec_dfs_refer);
-		/* tc_count can never go negative */
-		WARN_ON(tcon->tc_count < 0);
-		spin_unlock(&cifs_tcp_ses_lock);
 	}
 	kfree(utf16_path);
 	kfree(dfs_req);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 5d57c895ca37a..c7e086dfb1765 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4239,7 +4239,9 @@ void smb2_reconnect_server(struct work_struct *work)
 
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->need_reconnect || tcon->need_reopen_files) {
+				spin_lock(&tcon->tc_lock);
 				tcon->tc_count++;
+				spin_unlock(&tcon->tc_lock);
 				trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 						    netfs_trace_tcon_ref_get_reconnect_server);
 				list_add_tail(&tcon->rlist, &tmp_list);
-- 
2.43.0


