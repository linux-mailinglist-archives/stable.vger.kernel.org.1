Return-Path: <stable+bounces-180119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C7B7EA9B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DAB52361B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC862FBDE4;
	Wed, 17 Sep 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTz+NFny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D32D7DF2;
	Wed, 17 Sep 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113446; cv=none; b=FtdJmxj0H8d54JDFchWEguVO67TLjJAxTQODbsKXkbQnvla/G4J824xug3RcxWRPyINSN/eEfVsHe3CsmFzQGChA7CKh3QttBW5kXYXL3VyQZwyhOTeI55XfbKIaShe/S7O1aitZcg6YsQTjJVy0+c7SHipQIzi+3p4T90Jj76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113446; c=relaxed/simple;
	bh=Ke6DPWOLfoyJHvDDhUuDlUgdpbrHKhOPFesvz/7duqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT5gWzF+oHf3cDkfAFtzjWftA9RzajXe8/AxzE0KoScM4mBoNSJT4xMHOzbCE70drPxdMmkSGIUOpSgC5515VqQKDgbhF1fYCZfK6A/V23PIWUZYk2oiZ5jHHJ7la/R3CcWQGOVo+waGe14/oFT24nEOsxEUb+qHgcxrIApTeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTz+NFny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874FBC4CEF0;
	Wed, 17 Sep 2025 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113446;
	bh=Ke6DPWOLfoyJHvDDhUuDlUgdpbrHKhOPFesvz/7duqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTz+NFnyw7FFfl1H3QcJV4qJPSEtGrv/GTnMkvs4QvacEs7USXKNtKI6u1oeBCQHa
	 alGyjyrs/Isqg0ur37J4wAOn25pqfolVjdQtgd+jmxvcWGXsfVNF8ARYwbLAqsJf2a
	 OcFHs3IXNC7lZs7K75pmPZu1yNM6xlZH7kquKKS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 6.12 089/140] tty: hvc_console: Call hvc_kick in hvc_write unconditionally
Date: Wed, 17 Sep 2025 14:34:21 +0200
Message-ID: <20250917123346.481623004@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabian Vogt <fvogt@suse.de>

commit cfd956dcb101aa3d25bac321fae923323a47c607 upstream.

After hvc_write completes, call hvc_kick also in the case the output
buffer has been drained, to ensure tty_wakeup gets called.

This fixes that functions which wait for a drained buffer got stuck
occasionally.

Cc: stable <stable@kernel.org>
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1230062
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Link: https://lore.kernel.org/r/2011735.PYKUYFuaPT@fvogt-thinkpad
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/hvc/hvc_console.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -543,10 +543,10 @@ static ssize_t hvc_write(struct tty_stru
 	}
 
 	/*
-	 * Racy, but harmless, kick thread if there is still pending data.
+	 * Kick thread to flush if there's still pending data
+	 * or to wakeup the write queue.
 	 */
-	if (hp->n_outbuf)
-		hvc_kick();
+	hvc_kick();
 
 	return written;
 }



