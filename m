Return-Path: <stable+bounces-127890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717FA7ACE3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F97188F3D3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D412857CF;
	Thu,  3 Apr 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOZpkSDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5832857C3;
	Thu,  3 Apr 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707323; cv=none; b=EpUexMsr4wPd5xxZpxkqjoGmPw3+CkZwGRDm0LxTKE7eFGdaF8aIrEw1u9S1ALDxW15iwd41UGyhAnS8qgr8mSDhAOsA2aF1vDEB11KXPUCQmlFYFaRkua84a98Tu22lLEThH0UexNC8S5HoMvYY7PLF/KCTbEsXKEMIq1sdyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707323; c=relaxed/simple;
	bh=FmtfTcgXRwd5icoSyu2hOBExFaFZrMfBPbZexhhAIa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlvOBmebvcfDbmQ3WCGH4mIedqqckY/JJW/Zlio2LGzZLFUmmdY/J/buKkl8gd8e+n6VDKxnBZjAg91z7fQsX8iiAI8wFxiwJBVZbkPL3ZPGQsEMIOKO7VKIAmKX4tLx0x8I45UgAizNF0jZIq/UFzXseHa/Xc1k4HFjSJrJ92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOZpkSDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44C5C4CEEA;
	Thu,  3 Apr 2025 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707321;
	bh=FmtfTcgXRwd5icoSyu2hOBExFaFZrMfBPbZexhhAIa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOZpkSDyAmfIJ3xZqo77xwcx9Jwrp0jR+Ghn6mAp+hUOBPunN/scVCD0jnePC3W8C
	 YXXocMYubxSAI3gOcQmkDgdLRR6dPtehrWthLlg6kYcuJqH9XkzIlc4+CJkQwzQ4FA
	 g+fBPMdRkuyDa+xtQ6mfwWnkObyodWKUN5Rc/Zh/YN1ltnnov5PEIYXPLa91IptOMc
	 LhvDdM4Ssl2LgScTAo18xdQcj++WPDq5g0KaPMJP5/MClFfQXRV1jQ/R82lbgweLcb
	 sHoSjpDSL/VbtDyBI0x8Dl/0KyJ8hq7MrpIGl5cTbTxbv4PU/6kqBTFbd1sTu2U5mo
	 HsEEsM5YVpXRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/26] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:07:43 -0400
Message-Id: <20250403190745.2677620-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Gabriele Paoloni <gpaoloni@redhat.com>

[ Upstream commit 0c588ac0ca6c22b774d9ad4a6594681fdfa57d9d ]

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller, and it raises a warning in case
of error.

Link: https://lore.kernel.org/20250321170821.101403-1-gpaoloni@redhat.com
Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9d22745cdea5a..b6fae597ee5ac 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.39.5


