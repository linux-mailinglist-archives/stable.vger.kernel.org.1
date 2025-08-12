Return-Path: <stable+bounces-167139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB05B2256F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B331B65624
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0862ECEA5;
	Tue, 12 Aug 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcHQJVE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE12ECE9F
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996811; cv=none; b=JUbLSsUdAkC9YyYzFId+jVinkm7z6ZoQZ4z+84ME7vKiJjf9KTABDjeKH36SUKNaIuB/at4A6QGroF08UY/+sla6T66qgzQQPwnI9HXooIWLncVPI7kHE8Rhe2oK6wSSxpmKJECMZq5mSXsKBzv1l/GWDhOX5MZaVcz8HE/+rjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996811; c=relaxed/simple;
	bh=Iy+J9RfRoO6ZJ95Z7H1Z4qnyVl4kV2epJVPcIn+qOuQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XEuOxUyJao9TIj+yCriB4P+JNkTPCSGKKI9xJndxQtvLNQV/gFEKI5QOfySz5Bs5A2jtKMMvUu9pfsfSlzpGWV7gEuCpL5zBU3wLFgOcOiKYrNdgkAYRlyMLyYG4G1IdZvVI9ZSVBuF0/LJ1D7PXvce1i4FN8CRH6rbtFQRRKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcHQJVE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA90C4CEF0;
	Tue, 12 Aug 2025 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754996811;
	bh=Iy+J9RfRoO6ZJ95Z7H1Z4qnyVl4kV2epJVPcIn+qOuQ=;
	h=Subject:To:Cc:From:Date:From;
	b=fcHQJVE3qsRTCLnHFysXm2qzVT0BiY7UFOUbkGzdfe3A4TFJzdi2gb4lQdVHP+Pdt
	 8haZFxLhl4wI6CxSxRLMIJFEeQ2wv5VyS3geMrKhowJqe6qZ14y3g4aVciuAMYOHR8
	 eUZuIHqX68e5nw1277QOKl99e2iSQczhd788BZk8=
Subject: FAILED: patch "[PATCH] smb: server: Fix extension string in" failed to apply to 6.12-stable tree
To: thorsten.blum@linux.dev,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:06:44 +0200
Message-ID: <2025081244-octagon-curve-7925@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7d178d06e8937454b6d2f2811fa6a15656a214
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081244-octagon-curve-7925@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


