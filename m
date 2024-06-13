Return-Path: <stable+bounces-52026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA969072BB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FBB28261F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6EA14373B;
	Thu, 13 Jun 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4qsjtFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8941C32;
	Thu, 13 Jun 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283016; cv=none; b=dGvhwCv4NG425Esq7vKlJIT6O2r4kyy/fQ9eMDeC61R1tJMiahkMqH5HA1fXZeb9EtSRsuI1YEN/FVbSRNYxnF8cLC3DXboHj22hQ/IswApc0nVED9rtnAe6J9AVm3yn1jgI8QMHE1e4i8n8s2KO0gfEM3bcCaCeP8ovXXtG7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283016; c=relaxed/simple;
	bh=9x+6gixQlDHDyzEty0w3B4FFwpK6piD2wipGz/UYM4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3I6BdUuVn9/gy+q0RMRprKU6t2kP4YTOo+Ry3K9ZTFa/NI4omBw375xZXypkkcmNxcQ+SeNNcn16tHYZE4GDeH3CrsD/1cnCm5lFVULZkfNP2G9F1XMPYaz9E4ku7ZufyIFy6L5kZNsh+E41/Yp9Px/6bqpyzJPUk+ccWsDiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4qsjtFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC21C2BBFC;
	Thu, 13 Jun 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283016;
	bh=9x+6gixQlDHDyzEty0w3B4FFwpK6piD2wipGz/UYM4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4qsjtFX5aLDeJwqi9mStD/w0LSCXUhqpa9zflGVlK7VcuacBhlLov6snl+LJxwza
	 30XtZkwkbRfB2cQMPF+AEZR2Y8LJ5yb4MvoeIZLKij67bri27nI6vDYuuBi2nbQ9D5
	 NT8isb3UYG10WBdKkRnJmMG0z2apdn3mgJu6L62M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Gilbert <floppym@gentoo.org>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 6.1 71/85] sparc: move struct termio to asm/termios.h
Date: Thu, 13 Jun 2024 13:36:09 +0200
Message-ID: <20240613113216.879075230@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
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

From: Mike Gilbert <floppym@gentoo.org>

commit c32d18e7942d7589b62e301eb426b32623366565 upstream.

Every other arch declares struct termio in asm/termios.h, so make sparc
match them.

Resolves a build failure in the PPP software package, which includes
both bits/ioctl-types.h via sys/ioctl.h (glibc) and asm/termbits.h.

Closes: https://bugs.gentoo.org/918992
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
Cc: stable@vger.kernel.org
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240306171149.3843481-1-floppym@gentoo.org
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/uapi/asm/termbits.h |   10 ----------
 arch/sparc/include/uapi/asm/termios.h  |    9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -10,16 +10,6 @@ typedef unsigned int	tcflag_t;
 typedef unsigned long	tcflag_t;
 #endif
 
-#define NCC 8
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
 #define NCCS 17
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
--- a/arch/sparc/include/uapi/asm/termios.h
+++ b/arch/sparc/include/uapi/asm/termios.h
@@ -40,5 +40,14 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
+#define NCC 8
+struct termio {
+	unsigned short c_iflag;		/* input mode flags */
+	unsigned short c_oflag;		/* output mode flags */
+	unsigned short c_cflag;		/* control mode flags */
+	unsigned short c_lflag;		/* local mode flags */
+	unsigned char c_line;		/* line discipline */
+	unsigned char c_cc[NCC];	/* control characters */
+};
 
 #endif /* _UAPI_SPARC_TERMIOS_H */



