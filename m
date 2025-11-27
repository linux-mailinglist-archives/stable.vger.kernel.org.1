Return-Path: <stable+bounces-197212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CEC8EE86
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59A544ED703
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2C32C301;
	Thu, 27 Nov 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wufeUshM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D731281E;
	Thu, 27 Nov 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255112; cv=none; b=cLGaHlAdBdWnRRrpqVM7C1BCZACPdRjuhfqq1GfXUfbcqW4QIcxmM/lsCFOSpb6QONbEbUFjsMcnlFOTbxWjnmSAx+JKKG0Imbe4LJArFwq5xVJuHiNJPJuB9WGcp8denkQF/lS3URB8D/2TqnCNoMjKALw9LMhWsvnFw/USqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255112; c=relaxed/simple;
	bh=FcI6EkOhD+D1s4WfIRnCTRCXPIL186QEVFr/THVzuSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnIpjfMx0tK/rKTHREUkLD0hYkJyZMr2FZJN0jmDHZFia7yRIqDzYtzHXCz+6zjcaA1KHb7wyGQnWxKczsCglLvwIxxX9PndXIx9yX+/5CIwIsdeP0oqSpzCU8/QgygRL1zASYqf/euyc8TGg2wNSkERgZs4UBaCHR1A3ei0Yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wufeUshM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F2C19422;
	Thu, 27 Nov 2025 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255111;
	bh=FcI6EkOhD+D1s4WfIRnCTRCXPIL186QEVFr/THVzuSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wufeUshMurQ64tMVXJzBtP1XioBhIvRjMHySmLQfaGzrVjF/+v/Qkmr+wzkqEW4vY
	 TvqjgUKpt873UewfJrp0+BTUvfNXNHbsX+8BMV9iiwRuPbXIUbU0Uz51OVPx/pBkL+
	 sGSTbZUqcZNcAd3N4ZTYo3uLT5QU8fyfRwuJIzys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Yuan <me@yhndnzj.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 6.12 012/112] shmem: fix tmpfs reconfiguration (remount) when noswap is set
Date: Thu, 27 Nov 2025 15:45:14 +0100
Message-ID: <20251127144033.179150294@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144032.705323598@linuxfoundation.org>
References: <20251127144032.705323598@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Yuan <me@yhndnzj.com>

commit 3cd1548a278c7d6a9bdef1f1866e7cf66bfd3518 upstream.

In systemd we're trying to switch the internal credentials setup logic
to new mount API [1], and I noticed fsconfig(FSCONFIG_CMD_RECONFIGURE)
consistently fails on tmpfs with noswap option. This can be trivially
reproduced with the following:

```
int fs_fd = fsopen("tmpfs", 0);
fsconfig(fs_fd, FSCONFIG_SET_FLAG, "noswap", NULL, 0);
fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
fsmount(fs_fd, 0, 0);
fsconfig(fs_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);  <------ EINVAL
```

After some digging the culprit is shmem_reconfigure() rejecting
!(ctx->seen & SHMEM_SEEN_NOSWAP) && sbinfo->noswap, which is bogus
as ctx->seen serves as a mask for whether certain options are touched
at all. On top of that, noswap option doesn't use fsparam_flag_no,
hence it's not really possible to "reenable" swap to begin with.
Drop the check and redundant SHMEM_SEEN_NOSWAP flag.

[1] https://github.com/systemd/systemd/pull/39637

Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Link: https://patch.msgid.link/20251108190930.440685-1-me@yhndnzj.com
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -127,8 +127,7 @@ struct shmem_options {
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
-#define SHMEM_SEEN_NOSWAP 16
-#define SHMEM_SEEN_QUOTA 32
+#define SHMEM_SEEN_QUOTA 16
 };
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4330,7 +4329,6 @@ static int shmem_parse_one(struct fs_con
 				       "Turning off swap in unprivileged tmpfs mounts unsupported");
 		}
 		ctx->noswap = true;
-		ctx->seen |= SHMEM_SEEN_NOSWAP;
 		break;
 	case Opt_quota:
 		if (fc->user_ns != &init_user_ns)
@@ -4480,14 +4478,15 @@ static int shmem_reconfigure(struct fs_c
 		err = "Current inum too high to switch to 32-bit inums";
 		goto out;
 	}
-	if ((ctx->seen & SHMEM_SEEN_NOSWAP) && ctx->noswap && !sbinfo->noswap) {
+
+	/*
+	 * "noswap" doesn't use fsparam_flag_no, i.e. there's no "swap"
+	 * counterpart for (re-)enabling swap.
+	 */
+	if (ctx->noswap && !sbinfo->noswap) {
 		err = "Cannot disable swap on remount";
 		goto out;
 	}
-	if (!(ctx->seen & SHMEM_SEEN_NOSWAP) && !ctx->noswap && sbinfo->noswap) {
-		err = "Cannot enable swap on remount if it was disabled on first mount";
-		goto out;
-	}
 
 	if (ctx->seen & SHMEM_SEEN_QUOTA &&
 	    !sb_any_quota_loaded(fc->root->d_sb)) {



