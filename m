Return-Path: <stable+bounces-4279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61F8046D2
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0311C20D97
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273679E3;
	Tue,  5 Dec 2023 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnqEeD5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9466FB1;
	Tue,  5 Dec 2023 03:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C88FC433C8;
	Tue,  5 Dec 2023 03:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747115;
	bh=MywIHm9OjIUThFKu/d7EKfsYN3VU1VMfipWoko+k+yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnqEeD5bEJS8i6y3IZyT4UUBg+UjNMyeqPxIA76VN4jnMCz4N9QbJhy+asfztEaa1
	 fMllKwgdycKl/p7lVGBmTMXxCbjNls6e3DoCzhZxkpNAUxd6p+OgaeYGlMhAbFyQOK
	 Wbx4KZUXno9HAg+5azF5AjwS80llBTl1+BMgLxZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH 6.1 040/107] parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
Date: Tue,  5 Dec 2023 12:16:15 +0900
Message-ID: <20231205031533.924389833@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit e5f3e299a2b1e9c3ece24a38adfc089aef307e8a upstream.

Those return codes are only defined for the parisc architecture and
are leftovers from when we wanted to be HP-UX compatible.

They are not returned by any Linux kernel syscall but do trigger
problems with the glibc strerrorname_np() and strerror() functions as
reported in glibc issue #31080.

There is no need to keep them, so simply remove them.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Bruno Haible <bruno@clisp.org>
Closes: https://sourceware.org/bugzilla/show_bug.cgi?id=31080
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/uapi/asm/errno.h       |    2 --
 lib/errname.c                              |    6 ------
 tools/arch/parisc/include/uapi/asm/errno.h |    2 --
 3 files changed, 10 deletions(-)

--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -111,9 +111,6 @@ static const char *names_0[] = {
 	E(ENOSPC),
 	E(ENOSR),
 	E(ENOSTR),
-#ifdef ENOSYM
-	E(ENOSYM),
-#endif
 	E(ENOSYS),
 	E(ENOTBLK),
 	E(ENOTCONN),
@@ -144,9 +141,6 @@ static const char *names_0[] = {
 #endif
 	E(EREMOTE),
 	E(EREMOTEIO),
-#ifdef EREMOTERELEASE
-	E(EREMOTERELEASE),
-#endif
 	E(ERESTART),
 	E(ERFKILL),
 	E(EROFS),
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 



