Return-Path: <stable+bounces-246432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNPWCpJuA2pS5wEAu9opvQ
	(envelope-from <stable+bounces-246432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADFD527379
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FB3130D381D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64410349AF5;
	Tue, 12 May 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKCdjKAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F203EDE68;
	Tue, 12 May 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609213; cv=none; b=cauxJ62O+M94U8TlKQ9V/3WJoZ6XdN0WaTzcbqw6PenpvZ5qAJQ5Pej5Fy8N8CH1/LsxYEVubRKLx3j/GnjRjLJLVOQcSZR/AC02uVuMoo+P0SAEBrOu5fJKna2r6hyzu/1qWikiajU0Jjf/NpQ7z3SxeuT03J9YNUsrNYTflV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609213; c=relaxed/simple;
	bh=GeHMOXG2bbfrNACNEL3l+KgYb3D0t7nn0HmwDeKtnVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah6HmnL5AhMhPmUw/m3w85+AiCaxWz+YRnD0yPuPWlp+aUvcurgxaq86y9odTBBLqEvKfFEvSngo5Q6Ps//bA4Jplk1UK0BYn0DPt7kSdVFX1Xoa9JDQTIWaNhxR0evVLhsfz5B9384j61BcQKv+ue+cAzl1DfmwICC7bVBbu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKCdjKAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF952C2BCB0;
	Tue, 12 May 2026 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609213;
	bh=GeHMOXG2bbfrNACNEL3l+KgYb3D0t7nn0HmwDeKtnVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKCdjKAeMX3IV/UBvAjEEmtHF7IVbMo+PamRAy/qU48VwSe1e5co8Eue2QzoguzuW
	 x7OCJqJofBOZLA+jHB1yM+zgF9BBGXoJg25B9LktDzNsAcluwIeoNT/zlcQjM9aQzI
	 stvq98pDYfgc/IGwqhzWc3lHkWCpQAxq+/AKC6fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 7.0 107/307] selftests/rseq: Skip tests if time slice extensions are not available
Date: Tue, 12 May 2026 19:38:22 +0200
Message-ID: <20260512173942.383729808@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AADFD527379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246432-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 02b44d943b3adddc3a15c1da97045e205b7d14c1 upstream.

Don't fail, skip the test if the extensions are not enabled at compile or
runtime.

Fixes: 830969e7821a ("selftests/rseq: Implement time slice extension test")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.597838491%40kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/slice_test.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/rseq/slice_test.c
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -124,6 +124,13 @@ FIXTURE_SETUP(slice_ext)
 {
 	cpu_set_t affinity;
 
+	if (rseq_register_current_thread())
+		SKIP(return, "RSEQ not supported\n");
+
+	if (prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+		  PR_RSEQ_SLICE_EXT_ENABLE, 0, 0))
+		SKIP(return, "Time slice extension not supported\n");
+
 	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
 
 	/* Pin it on a single CPU. Avoid CPU 0 */
@@ -137,11 +144,6 @@ FIXTURE_SETUP(slice_ext)
 		break;
 	}
 
-	ASSERT_EQ(rseq_register_current_thread(), 0);
-
-	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
-			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
-
 	self->noise_params.noise_nsecs = variant->noise_nsecs;
 	self->noise_params.sleep_nsecs = variant->sleep_nsecs;
 	self->noise_params.run = 1;



