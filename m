Return-Path: <stable+bounces-130758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C578A80616
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EE018951FA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906B269B0D;
	Tue,  8 Apr 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5h+5hco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB420268688;
	Tue,  8 Apr 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114573; cv=none; b=nYPaUTZgzMdtxVl2nKE9a/uXUXvDCE7Di5qZ3wh8MI9yrw/v0jklq7qeIUEZn59H8ZmG8IF9MFZm8uwU5S2ItlYTnPH3/OuUwGuMwaDICVT+gzqsr19IW8kJ+OjzBFmGH2lPj4lDXdm2LR/rq6aR8WoMP/cJHRS5TvRbheBwd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114573; c=relaxed/simple;
	bh=vWsSMwXNWa95ZCEDqo+JAEiKORyA+MRjHOhiLAGUemI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWQta7QGwlFd7XcQAOzqfrgMERLODMrF+7TPxkUq5K17HGI0IMz8oXGyXAweRO0dK3k4YfT97hvI1+v29QnpJpWbD5MxMHZWfjADd8ael4a4sZ0cuXos4bKWyvDHR+ON2F5VHUT+Wm8lHEG+sbDGOG0lMQbQv2n0xT2yAfJ8nNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5h+5hco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E7BC4CEE5;
	Tue,  8 Apr 2025 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114572;
	bh=vWsSMwXNWa95ZCEDqo+JAEiKORyA+MRjHOhiLAGUemI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5h+5hcoy0G3uvnTkSdW/C/kqmFYJPQX7g8jRBtw2hfaH6vOz5kXI/qKFiHGL2jQA
	 dDD0+/jQzHna50wpSjx995sFKmOOD3VU/rPOZYaNp4xWVsxqHOldj1Rl551DY5iHVT
	 LJYGvB2I5VaMiSQHrHSHxKFvhC9UmUi1nJ4GxcwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 155/499] bpf: Use preempt_count() directly in bpf_send_signal_common()
Date: Tue,  8 Apr 2025 12:46:07 +0200
Message-ID: <20250408104855.048525550@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit b4a8b5bba712a711d8ca1f7d04646db63f9c88f5 ]

bpf_send_signal_common() uses preemptible() to check whether or not the
current context is preemptible. If it is preemptible, it will use
irq_work to send the signal asynchronously instead of trying to hold a
spin-lock, because spin-lock is sleepable under PREEMPT_RT.

However, preemptible() depends on CONFIG_PREEMPT_COUNT. When
CONFIG_PREEMPT_COUNT is turned off (e.g., CONFIG_PREEMPT_VOLUNTARY=y),
!preemptible() will be evaluated as 1 and bpf_send_signal_common() will
use irq_work unconditionally.

Fix it by unfolding "!preemptible()" and using "preempt_count() != 0 ||
irqs_disabled()" instead.

Fixes: 87c544108b61 ("bpf: Send signals asynchronously if !preemptible")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20250220042259.1583319-1-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2c2205e91fee9..85ddb0549d93d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -854,7 +854,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 	if (unlikely(is_global_init(task)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
-- 
2.39.5




