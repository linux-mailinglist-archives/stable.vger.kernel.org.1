Return-Path: <stable+bounces-81605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F72994857
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B05284393
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA51DE89F;
	Tue,  8 Oct 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggyNHyUI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF81CF297;
	Tue,  8 Oct 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389519; cv=none; b=njpQ/j+Ws2pfEYWHv7OaSUsDLp1y+uzoHaA2NzpZcfRU1inUsyPh/vYjwNiTpZLggFsz1NyiAqLrrQb5WUVN7I26Ezl7DdsrmU3hD0PNp7RoNnc/1KNUYFkArMrEEpOZHWotY15uRuRgTl9WLpdrTyo82gbHvbB5I3tieO2Pvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389519; c=relaxed/simple;
	bh=F30WaHFYaYfw+jW/niVy2D1pCgZNSL5K8dLVZRVLMSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVUi6wfu0dayi6JRm4KkkbLdMzabQJ4EGdCt0dXUsejwHLzI8nMuI2KE23SGiO+UOSgOD8ziO2cr+QPxzP9IymerQN5Tb6hkEFIrmBkqrSRxbH9ywVtoCWIUmFn6jZuoVrQTeVo6bj/645xKpfGxFyHd3MqM+383WpWrwJpcpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggyNHyUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54738C4CECC;
	Tue,  8 Oct 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389518;
	bh=F30WaHFYaYfw+jW/niVy2D1pCgZNSL5K8dLVZRVLMSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggyNHyUIl5c6dc+P8G5LFUEFPjvhUjfZ92xjrqlCjP0ij30Py0SujwhWVktbmhGOr
	 AwCIBCKWCcoJm58V5rj2Szobnm7xl2ZJxfBPIf6q8j2d9lvEtTAzoB7ElDH5lXJfqn
	 lV+IdwJiaNEPW4kGB7tMnSuqUpD3lwhe1jFaJ+1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 002/482] static_call: Replace pointless WARN_ON() in static_call_module_notify()
Date: Tue,  8 Oct 2024 14:01:05 +0200
Message-ID: <20241008115648.388174535@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
index 7bb0962b52291..5259cda486d05 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -453,7 +453,7 @@ static int static_call_module_notify(struct notifier_block *nb,
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




