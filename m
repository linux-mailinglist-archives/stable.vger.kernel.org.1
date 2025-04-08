Return-Path: <stable+bounces-130193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FE0A80343
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091E6460F69
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04469268FEB;
	Tue,  8 Apr 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XrEAXDgY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE9227BA4;
	Tue,  8 Apr 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113065; cv=none; b=L7pIa0SpHxB57oSu+Na41BiPinpnj/IUBiwe8hZUM47mY4do+JNdWHmG0XFiBEirZU4RGWr65FM5vyPagLGW3Ssz0Om/UYkGuezGGg9KvGGd5adqmgvbYOSmMN10YiWdVsPbEpa9by5vGM60kb++xiYKasAPKVlxvOnwsRaajjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113065; c=relaxed/simple;
	bh=j47iEghIuyDcj1xdTlqmY9ffXkbKtZUgYpnB4Z+QqNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj1WBnpeSNswgjfuMaYxzedon4SMl42Etp9FXB/us+dNKRxHShevA8jInPjRwUwSauiZqRlVf+xEQ5lTphQGDL+v2VZ+jsAbSm3Efq5J61wUJGo3ukVNOZ62tBDzhAFPJ/pPQIExyNy1Elg/MF06CF8fdXAYkfQqD+Yc5NSrbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XrEAXDgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370B2C4CEE5;
	Tue,  8 Apr 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113065;
	bh=j47iEghIuyDcj1xdTlqmY9ffXkbKtZUgYpnB4Z+QqNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrEAXDgYLRUXRUcpjaPvqqpFJbqfVScRowslNiOYl+SBSONOw110CwxEX17cDSsTt
	 xy3uR185+g78Hy7K5qO/fPLK1ClTuxpU/SuwX2gX2aUKAHsNfrBY/QQjjGpwZ3aXxc
	 BbBXVTJxGOionLYhe5n1defZGAuG7nGUMybB3W8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tao Chen <chen.dylane@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/268] perf/ring_buffer: Allow the EPOLLRDNORM flag for poll
Date: Tue,  8 Apr 2025 12:47:12 +0200
Message-ID: <20250408104829.081900367@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Chen <chen.dylane@linux.dev>

[ Upstream commit c96fff391c095c11dc87dab35be72dee7d217cde ]

The poll man page says POLLRDNORM is equivalent to POLLIN. For poll(),
it seems that if user sets pollfd with POLLRDNORM in userspace, perf_poll
will not return until timeout even if perf_output_wakeup called,
whereas POLLIN returns.

Fixes: 76369139ceb9 ("perf: Split up buffer handling from core code")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314030036.2543180-1-chen.dylane@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index b0930b4185527..52de76ef8723b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 	irq_work_queue(&handle->event->pending_irq);
-- 
2.39.5




