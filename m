Return-Path: <stable+bounces-167140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B3B22568
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD605657C0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C282ED144;
	Tue, 12 Aug 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMmQqr98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A092ECEBD
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996815; cv=none; b=P9X6CVlUwU3LQ7luVMC96BcLzpl4suIE8ILluBngSnysME5OrOiXg7ohg9anlYKEblepw4A/GeXTm8m2RhirOzpaLRqSka0GUoX+kaED8sGz85c8Tof6Jd2lXYjAJK1JvdkUaTpEvPKOjghDLJmk2H2WkRBMYRhtBPWboThrIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996815; c=relaxed/simple;
	bh=z7KDX2phIHN69DwyQDWAZ130/cXcdbOGeZZN5kSuUzI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P1D7NL1Zh3f8zQ5iiMpkKphUYwrio620/8tDMmGHPSUYHejCW3fuDzTvwMSlREwXIzTixBRT0DbNPjrnIWLX37XvDEZuYqEMQy2vrAr0hMb3x1h6StUjDMPH3afFiRjpTLE8fKieBblPSJGL5T2v9+C/gZdWEK2ZyZwyIQJlgBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMmQqr98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85895C4CEF0;
	Tue, 12 Aug 2025 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754996815;
	bh=z7KDX2phIHN69DwyQDWAZ130/cXcdbOGeZZN5kSuUzI=;
	h=Subject:To:Cc:From:Date:From;
	b=sMmQqr98X9fCJj3P5pumoQRdYS86IaAA6PNwRkAvJc3MpkX9baIgfad6QLSEllZ5R
	 HOjBXwS/Y4EsVYklbnHniXF3g0Zzt5JxTVF2ao2+oz3TWyCiMClgstCpg99EaTtpJ3
	 eNDvzrY7z4B2xVvTyf/VHaN/NTumeBKzsuy+7hPQ=
Subject: FAILED: patch "[PATCH] smb: server: Fix extension string in" failed to apply to 6.6-stable tree
To: thorsten.blum@linux.dev,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:06:46 +0200
Message-ID: <2025081246-wasting-private-5dd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7d178d06e8937454b6d2f2811fa6a15656a214
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081246-wasting-private-5dd8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e7d178d06e8937454b6d2f2811fa6a15656a214 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Wed, 6 Aug 2025 03:03:49 +0200
Subject: [PATCH] smb: server: Fix extension string in
 ksmbd_extract_shortname()

In ksmbd_extract_shortname(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in "__" being copied
to 'extension' rather than "___" (two underscores instead of three).

Use the destination buffer size instead to ensure that the string "___"
(three underscores) is copied correctly.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 425c756bcfb8..b23203a1c286 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;


