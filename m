Return-Path: <stable+bounces-72333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B7967A37
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529BA2822BA
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6617E00C;
	Sun,  1 Sep 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+Qf60Kj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3C1DFD1;
	Sun,  1 Sep 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209582; cv=none; b=vDiZ6jn/0oVc3akeAXoLgidu37oVdEoq8BSYrThKG4Vf8EqUmTjzhCMkxennW987L6f4NQmXM0IAq452HMwynXBQAYwLMC98AZ0JYUstcM6oGPinzjuNP91TvMFBbByajYvverVBV2eJ+I+UwbZm6bRwnaTISVgms4aiyBirZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209582; c=relaxed/simple;
	bh=0tx9GUZG7a8tC+fdChdzeL+sc9WAN/HOcfIg1CgBvlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/qL3vltqGP7RCeo3EBOPy0/5S+cyQD6e3qJfY98usOgqxbC7t+BIujYdiFjvdoVTQAndlFl3pgP7zTalQ3V4Yt/JSc+P19JMHHqg1B8MrFZfl5ShSITgaB6gah709j+mXUF3ODtUeMnm8uhiPY3XGQMttUDM1pDI0Ld6baKzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+Qf60Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7BDC4CEC3;
	Sun,  1 Sep 2024 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209582;
	bh=0tx9GUZG7a8tC+fdChdzeL+sc9WAN/HOcfIg1CgBvlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+Qf60Kjk+kcJVODciMfmaZoW3xuq2FIPbiXaQ+VgO3xbQz4Qv0iBdutU6KlFC7Fl
	 rTsktniH0eqE7C0l2eYXFRkW8LQmiHNZuohjx9XIcr8ITre1Z+a/9X7Eq5ARSI33jA
	 cnAMLhnoR93Qgdth22I8BspxaCZyDj6BgvpyGL8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Chang <phil.chang@mediatek.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 081/151] hrtimer: Prevent queuing of hrtimer without a function callback
Date: Sun,  1 Sep 2024 18:17:21 +0200
Message-ID: <20240901160817.168354892@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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
index 2b2a6e29219dc..16f1e747c5673 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1182,6 +1182,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
-- 
2.43.0




