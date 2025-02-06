Return-Path: <stable+bounces-114021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB84A29EDB
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 03:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A4A188958E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269A136358;
	Thu,  6 Feb 2025 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFnNIHB7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9F13959D
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809426; cv=none; b=PXmgjJLqFTAzGy5wtRLcg5PR/M41MCxbebbh038eqszs7WRfntTA2ELTUEVj2kTkRg02lEWz8sE2l8u8eWrwcbI2Ab1d+xMeaE0I0+z9N+GevJc8zl4YGMJtGZyZi8M51DPw2zbTv4zyG4x+eK8tj8kaCtqmw9YihfJXwwR+ZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809426; c=relaxed/simple;
	bh=sw9zD1D1sqWvxw19DBsDi7y/5AEgnjxMKp/xdrQhVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORBMoY3yhoM5sn48i/uwz8lm0cvWi0soH2lMkwqDRtW/qYe6bmg3271R/FIAqVUkPt3UK3iAynozf7meBCr9WDrbZaVqT10Iqbs1jy7UNiqfX1mPC9K/KQdlMeQMfCWfHYlq7TvsVUl6AgXL5zUKltzZYdIqdDl20JADTw9HKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JFnNIHB7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gLhJ005059;
	Thu, 6 Feb 2025 02:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=qyI1+gdNHiuziTX4lAju005zwyNFU
	VHNwhS1bWk9L8E=; b=JFnNIHB7OsLfjYfbsWfXz1Ey8M3dJ7IFfFnW2VuhGFJBL
	VF9v0fo+L+K75g/nA6ArT76GKa21sWsW33FBWtluvCsnjBHpOwdjwfpfQ22J1dPA
	jXNVVlyF+ykY9LJgq9S8P4z/tCjtBJanBiAfTJIISVYhusW4ibBasCNne91YvW4E
	CHO4oaMIVxraFJpVDRwctPt7uifGP+KzV90i2Gl6E5MeJBgVXpm9IBDRDk+7BQZs
	DtHYZZbDTTkkXIyzERcJOwDNEZADUqmt3V8OPiUNOlhe2aldwS72WbcfmM1Nw2jM
	mKJ852LaMMSNd+cWYi1EELTSy/wlMtZxDOy5TpARA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju0d5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 02:37:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515NOBFF027879;
	Thu, 6 Feb 2025 02:37:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p57guk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 02:37:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5162b0mQ018912;
	Thu, 6 Feb 2025 02:37:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44j8p57gu8-1;
	Thu, 06 Feb 2025 02:37:00 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, stefanb@linux.ibm.com, zohar@linux.ibm.com,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 5.10.y 5.4.y] ima: Fix use-after-free on a dentry's dname.name
Date: Wed,  5 Feb 2025 18:36:59 -0800
Message-ID: <20250206023659.1217450-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060019
X-Proofpoint-GUID: jlfvNZXu4Vdwcovf5bGEgXM2W5CP3ute
X-Proofpoint-ORIG-GUID: jlfvNZXu4Vdwcovf5bGEgXM2W5CP3ute

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]

->d_name.name can change on rename and the earlier value can be freed;
there are conditions sufficient to stabilize it (->d_lock on dentry,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met at any of the sites. Take a stable
snapshot of the name instead.

Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
[Samasth: bp to fix CVE-2024-39494; Minor conflict resolved due to code
context change]
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 security/integrity/ima/ima_api.c          | 16 ++++++++++++----
 security/integrity/ima/ima_template_lib.c | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 70efd4aa1bd1..285d6069c32f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -213,7 +213,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
+	struct name_snapshot filename;
 	int result = 0;
 	int length;
 	void *tmpbuf;
@@ -276,9 +276,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -391,6 +395,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -404,7 +409,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c022ee9e2a4e..f72a2564fd05 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -385,7 +385,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -398,7 +401,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -407,8 +413,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
-- 
2.46.0


