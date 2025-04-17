Return-Path: <stable+bounces-133954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E2A928B7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BE01B60C33
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885725F996;
	Thu, 17 Apr 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYOzMs+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88111CAA99;
	Thu, 17 Apr 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914649; cv=none; b=np2P+AhE0UfCZaK3VGbxceVRm+PvgB+CT5LTVjpJEz7tsXeQJm0qCZdzHIuM1hhazMXo68d/ZvTkMmGZprB8exWLB4N68etR1uC27eQDcw1/gvU3Codsn8HPOjNeotQWwpK5haYrQ2OTSwGTNTksaWdczdaUEpmyEhHjB/DGYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914649; c=relaxed/simple;
	bh=ETz+FzFk5U7An94vdBNX5G0Zw0I2cu69mn33CVRkqdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn1u3LW47AcPrDCAg+wNs0I+CheUgcDRnwatDuwSbdnGEF4SpMxtVFB+4rOQckgQS5fPNs2kqo4Eon7/rDp+rOfu45qs07db9sjnNszuy/HNV9KyQu8lUD3UHYyYKVU9u+dGg/oSW9jqEoEe7cGdaVNEm1J8yoEHZ02QNDqzZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYOzMs+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B76C4CEE4;
	Thu, 17 Apr 2025 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914649;
	bh=ETz+FzFk5U7An94vdBNX5G0Zw0I2cu69mn33CVRkqdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYOzMs+C1PL3kiZDY2eq8ypHGNnzqCXT0WVQX9Qdk5xOVijEs9pKVJAtu3vMhkZhZ
	 +CARyEC9ZOiwSaQ7r7Z5Gs0cXExBLvMQ4ax3QUBaxEn0/QRY5Nsz0zP+v31nJ1kLdj
	 uBrvgGkoZ75/l0H9MEjvIw27d4QQ1DuPdoBrcCM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Berger <stefanb@linux.ibm.com>,
	Petr Vorel <pvorel@suse.cz>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 6.13 286/414] ima: limit the number of open-writers integrity violations
Date: Thu, 17 Apr 2025 19:50:44 +0200
Message-ID: <20250417175122.930747307@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

From: Mimi Zohar <zohar@linux.ibm.com>

commit 5b3cd801155f0b34b0b95942a5b057c9b8cad33e upstream.

Each time a file in policy, that is already opened for write, is opened
for read, an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list. This
occurs even if an open-writers violation has already been recorded.

Limit the number of open-writers integrity violations for an existing
file open for write to one.  After the existing file open for write
closes (__fput), subsequent open-writers integrity violations may be
emitted.

Cc: stable@vger.kernel.org # applies cleanly up to linux-6.6
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/ima.h      |    1 +
 security/integrity/ima/ima_main.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,6 +182,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_EMITTED_OPENWRITERS	5
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -137,8 +137,13 @@ static void ima_rdwr_violation_check(str
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+
+		/* Limit number of open_writers violations */
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!test_and_set_bit(IMA_EMITTED_OPENWRITERS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
@@ -167,6 +172,8 @@ static void ima_check_last_writer(struct
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
+		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||



