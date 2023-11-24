Return-Path: <stable+bounces-1675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D297F80D6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D6C1C215F7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AF33CD1;
	Fri, 24 Nov 2023 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZrMfBfLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2842E64F;
	Fri, 24 Nov 2023 18:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46012C433C8;
	Fri, 24 Nov 2023 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851994;
	bh=iHIKwJruB16A1ehUdaKt6yUYMhXeownTzshPaJeJdTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrMfBfLGL752I+ltcfW05dX5zvQgLjgQ1hELpo3Fe/p6a4TJee5SZ+J7qAffithKt
	 MexFW90dVQcVkuOGV1fL8nqJ31k3uAR33yB/ouNby1o94OGiBi4zY7bfEiUxSWOC28
	 +v9nAyiWA2QkEvABRzUhultfL3slVJYFXv2OqYb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Artem Savkov <asavkov@redhat.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.1 178/372] audit: dont WARN_ON_ONCE(!current->mm) in audit_exe_compare()
Date: Fri, 24 Nov 2023 17:49:25 +0000
Message-ID: <20231124172016.399905708@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Paul Moore <paul@paul-moore.com>

commit 969d90ec212bae4b45bf9d21d7daa30aa6cf055e upstream.

eBPF can end up calling into the audit code from some odd places, and
some of these places don't have @current set properly so we end up
tripping the `WARN_ON_ONCE(!current->mm)` near the top of
`audit_exe_compare()`.  While the basic `!current->mm` check is good,
the `WARN_ON_ONCE()` results in some scary console messages so let's
drop that and just do the regular `!current->mm` check to avoid
problems.

Cc: <stable@vger.kernel.org>
Fixes: 47846d51348d ("audit: don't take task_lock() in audit_exe_compare() code path")
Reported-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/audit_watch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -531,7 +531,7 @@ int audit_exe_compare(struct task_struct
 	if (tsk != current)
 		return 0;
 
-	if (WARN_ON_ONCE(!current->mm))
+	if (!current->mm)
 		return 0;
 	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)



