Return-Path: <stable+bounces-178380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09EB47E6E
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2902A189FD01
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F321F1921;
	Sun,  7 Sep 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q6Nu8jNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126F189BB0;
	Sun,  7 Sep 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276651; cv=none; b=o5IqKD+Oere9/DWs+Tur0L6Xau/xZR5S7fXUb0Pr5kv0VKBLO1xuIHCU2m8031tq9Ccjh/4xE2w6A5Q73oA7mBGM7WQXNqlIG0KCaOEQQzkeMr6c52V0x6LcW5+GzFhm7ELMTufAiLGtqa3YeqsET2vqllhHHibQ17A1nXlBdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276651; c=relaxed/simple;
	bh=dbMJbiajU2zfee9HGm19yh4UvBCB07FAPbcPur9me7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9yeohyUc4tr1t+w04zjiI2bt5QNgBxxx7pXoI300qnmX/rCJfZujAW88L6YEAs43DdVnnPX7CJftFX3oEruUoK131ZdG72PSI0bIi9hCkKzmqZJ9jPofNy8L2vKA/Q/mNhLDdc3VoV5p40DE68rAMh1mEnfj7DsDmZaQYmNrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q6Nu8jNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6FEC4CEF0;
	Sun,  7 Sep 2025 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276651;
	bh=dbMJbiajU2zfee9HGm19yh4UvBCB07FAPbcPur9me7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6Nu8jNgmbFHhrotCJPMqJLTYEw69gZOfkH8ovNml7D085eJ9DlnqEDZYUv9lmsZq
	 nAc0M/4weY6a7uhE+OZB4qJkiiy3soLWtRyoErX7CBc2QzS/bSF5RksxOChje1Z/Z9
	 Cdo3a2BSLNtcu/cYE8fZWvG790Ak7Zb/8e0Zlapk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Makar Semyonov <m.semenov@tssltd.ru>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 067/121] cifs: prevent NULL pointer dereference in UTF16 conversion
Date: Sun,  7 Sep 2025 21:58:23 +0200
Message-ID: <20250907195611.557553691@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Makar Semyonov <m.semenov@tssltd.ru>

commit 70bccd9855dae56942f2b18a08ba137bb54093a0 upstream.

There can be a NULL pointer dereference bug here. NULL is passed to
__cifs_sfu_make_node without checks, which passes it unchecked to
cifs_strndup_to_utf16, which in turn passes it to
cifs_local_to_utf16_bytes where '*from' is dereferenced, causing a crash.

This patch adds a check for NULL 'src' in cifs_strndup_to_utf16 and
returns NULL early to prevent dereferencing NULL pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Makar Semyonov <m.semenov@tssltd.ru>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_unicode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -629,6 +629,9 @@ cifs_strndup_to_utf16(const char *src, c
 	int len;
 	__le16 *dst;
 
+	if (!src)
+		return NULL;
+
 	len = cifs_local_to_utf16_bytes(src, maxlen, cp);
 	len += 2; /* NULL */
 	dst = kmalloc(len, GFP_KERNEL);



