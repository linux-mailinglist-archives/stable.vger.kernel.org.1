Return-Path: <stable+bounces-187564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7EBEA7FE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47F5F582DAF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2A330B00;
	Fri, 17 Oct 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhv8QDSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBC330B1E;
	Fri, 17 Oct 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716434; cv=none; b=XNsJHBbHY/QfYXnPODcnUJNn+EHi3ohuHX8P4HTz8RA/CEgH3iEUDrLJZyOVNAgh4KUqffTSu/hEA39U47dTcsq4mQmX1ULdBjsyOg/Gv0DCgN6tATu0Rtlaq9xhTIyXCurFNOCDHOGh4BdLfD4Bvk/LrNv1dQ3lslFme0zUl80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716434; c=relaxed/simple;
	bh=S24wiqjIAXDg1tVADkkc4bu7okNZS9rvUyGMZKVeICA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVjRpRsGiY9ZqVzsqoOrVBP/6neFyZMoffSXoAM1v76zrzaJTax+hTTwiScXv9muEPA0FwHHOb9fBcAy71BPrqi2/9b9bq+Yv9HlmxmCCmsGjNktsw4Ltb3rVTTysR4HCLt1z8D51iLSGabmvIoJSDiLX7np0Pxc5l77PkQ2cIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhv8QDSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E188AC4CEE7;
	Fri, 17 Oct 2025 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716434;
	bh=S24wiqjIAXDg1tVADkkc4bu7okNZS9rvUyGMZKVeICA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhv8QDSsz/MuteUJPtBv1o3R3lT/BQTgXAA2kXeQwjF/uAWLDhlTDp8+h36QCUBgJ
	 oK0zdzS+yHxCWh0czcfcKVyjhCaMHy/ZWptfHRQ8TH6+HNZ8mLhCSGhaTSD73XCgMW
	 q71hVEEWmXO1bFOF9AJ8HSz729jQHERBo9tyn5a8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam James <sam@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 5.15 190/276] parisc: dont reference obsolete termio struct for TC* constants
Date: Fri, 17 Oct 2025 16:54:43 +0200
Message-ID: <20251017145149.406983016@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam James <sam@gentoo.org>

commit 8ec5a066f88f89bd52094ba18792b34c49dcd55a upstream.

Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42
drops the legacy termio struct, but the ioctls.h header still defines some
TC* constants in terms of termio (via sizeof). Hardcode the values instead.

This fixes building Python for example, which falls over like:
  ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'

Link: https://bugs.gentoo.org/961769
Link: https://bugs.gentoo.org/962600
Co-authored-by: Stian Halseth <stian@itx.no>
Cc: stable@vger.kernel.org
Signed-off-by: Sam James <sam@gentoo.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/uapi/asm/ioctls.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -10,10 +10,10 @@
 #define TCSETS		_IOW('T', 17, struct termios) /* TCSETATTR */
 #define TCSETSW		_IOW('T', 18, struct termios) /* TCSETATTRD */
 #define TCSETSF		_IOW('T', 19, struct termios) /* TCSETATTRF */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x40125401
+#define TCSETA          0x80125402
+#define TCSETAW         0x80125403
+#define TCSETAF         0x80125404
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)



