Return-Path: <stable+bounces-127811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8AA7ABD9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CA188A1B1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0065267B89;
	Thu,  3 Apr 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlO6MgWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD8267B7E;
	Thu,  3 Apr 2025 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707143; cv=none; b=XqENd/MCwH87VHQtVdcP1Vj533xqzuCiOuZR7lntV1ou7p384V2CSmj79tpvAEv+fI+XufkxRlLHUsI6U2Tr/HmPncT2fUbtr5T6YPdpsXaoH8xQg9O1YE6xN5zYx9BB9Bs1g5dPJmprjGsLUjOiQibMkEB0X5tOBGItqG5wp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707143; c=relaxed/simple;
	bh=MQUspQO7RbhBf6VrE3aC76TlO494LiaxWgiv3yMT5o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgkQpWQyI28ndOgoXo+Nc/Qv6uZMpzZl6zkJzp+b9sPsuuqjfJ3VzntrZ9s9CIE2vKR89N2ocskU8DoRDzgJ9XP6EIMAj4VGIa2ocHKlcOVfEKB3U6FbvhWJD05DMh5h6zDS+LQKdAYn4LaBbTQDMGqnUlMgkm0TLr4iL2C2NeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlO6MgWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53336C4CEE9;
	Thu,  3 Apr 2025 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707140;
	bh=MQUspQO7RbhBf6VrE3aC76TlO494LiaxWgiv3yMT5o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlO6MgWH623uBsUhmJhr5TcK1QVB00EitnNs1Y/UEo/5ViJyOQ6Ii78qs5aPnRvBj
	 Mh5kMGLLFMzouYKj1FniyV8fenVWD/U0Z5eSUn27JgDsRPwW0CvniJcVXZFZS4gou2
	 CTgYYK6/dadH5jr5MAO4koNXGXtkeb9yYI/Qd2xV/J2V7s2/cOaUgwTZDwNMycPv8M
	 sBA6ahAAs4Iy2CADc6f/dhTioH8numiIcClDf4I/eiFfVh1tC7PenHyVs3KcAoepeV
	 ggaKKarpmyK2ESLlQ5eo+Mugpkywu0mPn+UVhENAVNY9PSbLy97zrKyMfkBsKe9QtF
	 Hwke8G/vaZN6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 40/49] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:03:59 -0400
Message-Id: <20250403190408.2676344-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 770e7ed917161..3f1beb64a768d 100644
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


