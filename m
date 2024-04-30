Return-Path: <stable+bounces-42201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3478B71DD
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60E31F23243
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCA12C530;
	Tue, 30 Apr 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LOV5hkfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C512B176;
	Tue, 30 Apr 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474895; cv=none; b=us4vLdf/2NUKaboBbtdR9RIEKbpZlFg37fZOxnYSB3B8ZRNpWU6+mxYA1ABWdrP1P6gt5hZVieyoqVf6DWVlOS+NtcNCzT6IJ4OwMKOSFCTJ9SwO1k8htS73QZ0tl0RbUe/9LWdX8sLIV8mnWEUIWNXKq6NpFzetdmTOXL6azhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474895; c=relaxed/simple;
	bh=OIQ83GnHu82uhUfRDy9aN3hpwc/aPZMQLPDT/PZPLII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axmGS+7XH512jIK8UrOdk/ohWnf3ayITAtmSKK9guz41RPXRC5vLxzXuZtQ0Q73ajVLxDc3KXsp0vPMbef5WTy62mHMtm46oh8f7tPR5tmjE+5OlxDOu8rTj00Pv+xcuIewWqR/qZqhbgJ6uKDg9+oOqyJOTn9Qe31+O2/PorMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LOV5hkfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928B0C2BBFC;
	Tue, 30 Apr 2024 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474895;
	bh=OIQ83GnHu82uhUfRDy9aN3hpwc/aPZMQLPDT/PZPLII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOV5hkfXgodnUF3vlGlnt+kHz++wfDF/yPpBlaZPlS5QaMzJ2XWcOWIwH7dyForzh
	 hlfv8n/j8/m3B/ah7bXqqQIZ5oUZ7NEHUDZHqJHpQMvkh6yXZ+w0jpKtSePrHfVNe7
	 xob2IQ0msJ80kTkoJiQfOGuKpBA2hdQy1KqDuJkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuntao Wang <ytcoode@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 5.10 068/138] init/main.c: Fix potential static_command_line memory overflow
Date: Tue, 30 Apr 2024 12:39:13 +0200
Message-ID: <20240430103051.423242624@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuntao Wang <ytcoode@gmail.com>

commit 46dad3c1e57897ab9228332f03e1c14798d2d3b9 upstream.

We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
static_command_line, but the strings copied into static_command_line are
extra_command_line and command_line, rather than extra_command_line and
boot_command_line.

When strlen(command_line) > strlen(boot_command_line), static_command_line
will overflow.

This patch just recovers strlen(command_line) which was miss-consolidated
with strlen(boot_command_line) in the commit f5c7310ac73e ("init/main: add
checks for the return value of memblock_alloc*()")

Link: https://lore.kernel.org/all/20240412081733.35925-2-ytcoode@gmail.com/

Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
Cc: stable@vger.kernel.org
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/init/main.c
+++ b/init/main.c
@@ -627,6 +627,8 @@ static void __init setup_command_line(ch
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
+	len = xlen + strlen(command_line) + 1;
+
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);



