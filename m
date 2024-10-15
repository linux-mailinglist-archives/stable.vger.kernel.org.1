Return-Path: <stable+bounces-85496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39FF99E791
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F4D1F213C8
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23381D95AB;
	Tue, 15 Oct 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1COKTWJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B11D89F5;
	Tue, 15 Oct 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993311; cv=none; b=Cy7w+EIozhWM/IL/NDiNG+vjLBFZXfCYWhMfWMVCcK+LaECBeYuwj+mgS0IjgFgsIwLTlfHIgTczk/EP6BndtI3uZDxVErIBOjDQEm6RjvfTUE7B1NHc34O3Sg1l5ryAcICptQSasJxDHHGeOoa+LEruKahfGxiIO7LUTDmiaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993311; c=relaxed/simple;
	bh=WMjC7JGzwJyNczXdy+71g1TXzohOoUIQSPS/4KVmM3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uly85JzJ3/1oOCfQ4+Sqj/+aP7u3Ks95O8DbHl+iJtxB6YJtma6ImpYmzR38v5S9rzU9pDfRFXrg/EXdOqyuSMHTYdvOSAp2Z2s2uJKzCd/u3d38crj1V2YccP/QuoOFDUVW8D3w9rEWlJtudahcJriLUS0yc1mWJv+LcsJfz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1COKTWJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28B9C4CEC6;
	Tue, 15 Oct 2024 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993311;
	bh=WMjC7JGzwJyNczXdy+71g1TXzohOoUIQSPS/4KVmM3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1COKTWJm98ZIhqM8MYIg40fYCz/TqB2ANZcyONUNZDjwn/9caLaPoPejsE0MwvmbU
	 8C21WKt9Z3JUW3+lqf5skqZANHAaTgKibHCw03huIC6K1zC5BbcFOLOZ5rGUsImSdn
	 XIUzD71lWsaogB/yX8uN71vjbw4gokxuLmO6oNHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 373/691] static_call: Replace pointless WARN_ON() in static_call_module_notify()
Date: Tue, 15 Oct 2024 13:25:21 +0200
Message-ID: <20241015112455.151571562@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit fe513c2ef0a172a58f158e2e70465c4317f0a9a2 ]

static_call_module_notify() triggers a WARN_ON(), when memory allocation
fails in __static_call_add_module().

That's not really justified, because the failure case must be correctly
handled by the well known call chain and the error code is passed
through to the initiating userspace application.

A memory allocation fail is not a fatal problem, but the WARN_ON() takes
the machine out when panic_on_warn is set.

Replace it with a pr_warn().

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8734mf7pmb.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/static_call_inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 075194d9cbf5b..6f566fe27ec1d 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -442,7 +442,7 @@ static int static_call_module_notify(struct notifier_block *nb,
 	case MODULE_STATE_COMING:
 		ret = static_call_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
+			pr_warn("Failed to allocate memory for static calls\n");
 			static_call_del_module(mod);
 		}
 		break;
-- 
2.43.0




