Return-Path: <stable+bounces-72118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E46967941
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ACF1C20A00
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57F1C68C;
	Sun,  1 Sep 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IL2Q5oPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C72B9C7;
	Sun,  1 Sep 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208899; cv=none; b=J0+CPLHrEBICrJr7vfQb6nHumdRD4JISGoL9HPpEfT1iu2V7Pypw2Y6KCKBoow+Gr9NiulUVn7qI/Is7VFt1k/Ty/w8MLdsd97QaTR50xZm4QEw4R4n04FUx24oRdkVvH+KSuNCf1lXXjo6A5LoeX6TvNDbfPgPCNdvmDg8tGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208899; c=relaxed/simple;
	bh=m7SU5clOEfJfhgRrd2NcCUdc/FgW8EM1gT43QeBiyyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+hVIajY5jquS1UDJUNIb0/V7KCGeOavkOquErr2oNpE/9MpG0c03kTLXUa3QtRchAumPpukjvkxdeumnVMu6pntsbfBLN09oMxS/mzZSOP+tZX3wyc/SeUTH5QK4KN7sUiLkwXKwrlGPeBze2/L0vm6w+2F1ESsLTB2KqSBl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IL2Q5oPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC48C4CEC3;
	Sun,  1 Sep 2024 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208899;
	bh=m7SU5clOEfJfhgRrd2NcCUdc/FgW8EM1gT43QeBiyyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL2Q5oPIxO/p5wn4EEO7eS0Obfb0iuVQdcHz9EEpU3bddPYi1bPvA0EBKWXiN2bi/
	 NM9KRoODGgVdJb/GvovqkY2F6ZYe3ZPC0P/2HdNOXx/Yrepi9RhV0kfsJee9Mv5/x/
	 Gji35WzR929ITansFr30ecxJ6opJ7TdRxC2foKS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Chang <phil.chang@mediatek.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/134] hrtimer: Prevent queuing of hrtimer without a function callback
Date: Sun,  1 Sep 2024 18:16:59 +0200
Message-ID: <20240901160812.849159444@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Chang <phil.chang@mediatek.com>

[ Upstream commit 5a830bbce3af16833fe0092dec47b6dd30279825 ]

The hrtimer function callback must not be NULL. It has to be specified by
the call side but it is not validated by the hrtimer code. When a hrtimer
is queued without a function callback, the kernel crashes with a null
pointer dereference when trying to execute the callback in __run_hrtimer().

Introduce a validation before queuing the hrtimer in
hrtimer_start_range_ns().

[anna-maria: Rephrase commit message]

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 1b301dd1692b8..2e4f136bdf6ab 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1183,6 +1183,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
-- 
2.43.0




