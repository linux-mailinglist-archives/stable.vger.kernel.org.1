Return-Path: <stable+bounces-124840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EDA679AE
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F768872E2
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465521146C;
	Tue, 18 Mar 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G00vL180"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E0211283
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315422; cv=none; b=lyZkNi8D/Agm4N/W71WynEv0V/qgTBsTIKMlDaozUl5AaYilc5FS2ulpilkejk6JVptJCvfGwPmKuimmO5hdD+kQ0ULg36GuBkOUu9sM6WfuFwKXjFmiwQJdJLspmYB44A/E73wWLIxIUq2h0Y6FRZ6PvhsJ2eNrVZoy9zvGUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315422; c=relaxed/simple;
	bh=xZaWexEDQ0Q2wevcBVlIoz1JKXTpd5HEmCRzQZwf9kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoXLk0a4PgymaCNZv/mokSlw+xmslE6VV6NC4Z+Kdc7WUT4EGSrn+2b6eIJHMCXwGdLiF1x4jwHDgTLFTsub+MLS3g462se/eHtFg4F4Cs6+L349bbz2MHGT7l+A7eybT+G0kzUuKPQNZs8IpzZD00xRtIThWs4oB+IzbnN1YsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G00vL180; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH3w01gWzH5m;
	Tue, 18 Mar 2025 17:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314491;
	bh=4Ty/PA3beqWO8MWsel8drwatVfnYdf1jE7VZ1AhJNG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G00vL180SUrGBAkP6sWfDo1AB0CMk7bkeCr10+9B+4kndaDxa3y90PvyXUAvKz7Ra
	 j+W/o73fGq04/1K+pUtKEgHELraCtkqw+jq54rJCtVTnpZTSc91TxxK/cpXIJVfnJY
	 TcUa0kQyc5Uh8DVEVfqdUqeI48deGOVWEVt+rP2w=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3v2mcYzGLQ;
	Tue, 18 Mar 2025 17:14:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] landlock: Move code to ease future backports
Date: Tue, 18 Mar 2025 17:14:36 +0100
Message-ID: <20250318161443.279194-2-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

To ease backports in setup.c, let's group changes from
__lsm_ro_after_init to __ro_after_init with commit f22f9aaf6c3d
("selinux: remove the runtime disable functionality"), and the
landlock_lsmid addition with commit f3b8788cde61 ("LSM: Identify modules
by more than name").

That will help to backport the following errata.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-2-mic@digikod.net
---

Changes since v1:
- New patch.
---
 security/landlock/setup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 28519a45b11f..c71832a8e369 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -19,6 +19,11 @@
 
 bool landlock_initialized __ro_after_init = false;
 
+const struct lsm_id landlock_lsmid = {
+	.name = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
 	.lbs_file = sizeof(struct landlock_file_security),
@@ -26,11 +31,6 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
-const struct lsm_id landlock_lsmid = {
-	.name = LANDLOCK_NAME,
-	.id = LSM_ID_LANDLOCK,
-};
-
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
-- 
2.48.1


