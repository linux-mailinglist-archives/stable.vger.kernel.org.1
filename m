Return-Path: <stable+bounces-242548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMeRK9Iu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D377F4B01AD
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1180300AD9A
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDE8378839;
	Fri,  1 May 2026 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4HB6Avd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AA37CD35
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675979; cv=none; b=gPtllRMxeRiEFxRO/zkRB+FhtfBGGyoHFgW6fWhSLbe250o7nEHPQv8wxrlEX0UaQ3S3CQaZFUCVWcYflw2qHumrSjZ7oCyxt28SFcbgy5s7qNT63435iRg9A/msCFVSFOdVSdmuCBU2abLfeFFkhdRF4eN+WdIMtDZ7ZNhEUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675979; c=relaxed/simple;
	bh=3izMdYi0Oj1T72GfhQd7zAMqTtdcIaItfGc3eM1Tt0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJwoSKsf3xVP6gHksGkdK1FcfARtaxWxZlkwxr/a//GYlDJ4bqs1J2AUNAiy3wcN+LBPDFOdgwCt/zDQccWq/0vmCNiwQLPg58z+9jCONF2QU90IyVDyMauUAr4Vc7EX8xSiSlPdKgD4vCrRkUCE68tiGi2axDsy3ijy9TOMc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4HB6Avd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso29629775e9.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675976; x=1778280776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxJdrCJuTrOiQKeCXfwytRR+Gy/EZWJBx9r5t8TJi68=;
        b=s4HB6AvdtsIEZrWYAx8KZuGFYSqaiTHI4+vYSo6kHESCIuIOhAG8fj0jKA2lcd5AYS
         gZkHbfvCb0fAa+AAR7AENx762y3YdIFapCCwbUu8/76EI1cSvKNMto6lYgWKZWxTjai+
         jTar6zie2vYT54VFOwDIZSOdbxg/8aF1Bj0DoP6362lGT24fvgeX7pcxAjx3esi2jv/O
         1g+c7sD797tZY3kV3G3JGRpnpv5O88oDUt7ITuCEtbVzHuFQbW2ro/wqA9fUEwe1fqq1
         2cPcdXI/qbXpuxF1dZyG6IHGGq2+Qv+r8DKfeHQROmSHxcUCWleED3yRVPClGT4xmT6m
         y5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675976; x=1778280776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxJdrCJuTrOiQKeCXfwytRR+Gy/EZWJBx9r5t8TJi68=;
        b=K315vjD2/4A9OoO2jDNFPCKMf+yxqDhTLs+GR4z3wcB5PtMhfwacRyYwQLgWWqfMB9
         C6VhXqz1Z1Ror3jRL6PA3dYRhF9pzoy6/flx99J8isBa1ekXv7bX8KfVr3z+DC5lgRNg
         6tt/D+7LJXYCPHaOXf1qZWkcSpV6fwXcFjlwR6R+SDbPdrFOtfcezj7TAiV7ZmkYmvOf
         w/n97uA6/Wwy5Fg34LTHdD/zrFmZuOvO+DqByIkNdKedn24R3yDXHDp8B+WyCCpqRppU
         w7zQ6j4BACLSx2BKKYxzYxBcVLbnsGjKhoNGzv+GquOU3tYb8baYDfni0yXpjaj/49jg
         9Zjw==
X-Gm-Message-State: AOJu0YyEmeWz7MsoqS9Lq9kREL5mEvJMgx1NSNpiLi4bKU90ep94nqsf
	VqIoGVt9sJnf+K2PPIvbThYDiLgy5iDvvngyt6I8/vqg2AjTRbjvoPKv3tz2nI7k
X-Gm-Gg: AeBDiesjDgOlS+1DFYKndtAitrwjwOCo1/fKRnFd90OFtvYWAUYekDzAnTQJr+aT0Pu
	7CVzjqhxwOJZbqVygVBvNbdEF6f1HY382c74WSJEn2JbpelmY1Qj6wwEahYrxuXGNQQd8VMUrDu
	ubJLbORpCKGGiP5Z/EBTTZ8uYrlp52aG5mXIvqvd5xndOASFyN4FvLPCF+GXZRIC0qsFOa2R3i2
	FMX1EcqQ+k6NAyCiF7PGsZyXO1vnDZl05ixySI/xyXimzqOZ8tkDa8DUfgL+xnUVcZ9d5eB8Jyd
	wJPl3X5PYwYOn+b8eSib5NEo7GtKOZhXjtpLh1haNgeGSjFpyo8zvpD4yffEiXTU3OMcbIV57xo
	67ciHEgkEk2H9txJNztNbSN74xEkozrEK1W1huz3YCFUvgrmj/3iwukX+BPNguUFsgugpsermDr
	eehtdo0S4hWG3qwrg0oZOISSZ61GMh8Z695Bui/zXYhuGAYRT5rI8pHv5oOEdb90xH4fjfTWqt+
	BHhgJPjzG988tKzBr17GOYuyFVJU/LEhIVH
X-Received: by 2002:a05:600c:a402:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48a9865f7c3mr10441055e9.15.1777675976196;
        Fri, 01 May 2026 15:52:56 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe93266sm23857045e9.3.2026.05.01.15.52.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:52:55 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	axboe@kernel.dk,
	io-uring@vger.kernel.org
Subject: [PATCH stable] io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
Date: Sat,  2 May 2026 01:51:57 +0300
Message-ID: <20260501225250.90152-4-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
References: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D377F4B01AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242548-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email]

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5 ]

Commit aacf2f9f382c ("io_uring: fix req->apoll_events") addressed
synchronization issues between poll->events and req->apoll_events.
However, a subsequent commit failed to maintain this consistency in the
EPOLL_URING_WAKE code path.

The patch ensures that when EPOLLONESHOT is set during regular
EPOLL_URING_WAKE handling, it's applied to both poll->events and
req->apoll_events. This prevents a condition where "IORING_CQE_F_MORE
is set in the previous CQE, while no more CQEs will be generated for
this request."

Backport notes:
  This patch applies cleanly and identically to linux-6.18.y,
  linux-6.12.y, linux-6.6.y, and linux-6.1.y.  The io_poll_wake()
  EPOLL_URING_WAKE branch is byte-identical to the upstream pre-patch
  state across all four trees.

Cc: stable@vger.kernel.org # 6.1+
Link: https://lore.kernel.org/io-uring/CAM0zi7yQzF3eKncgHo4iVM5yFLAjsiob_ucqyWKs=hyd_GqiMg@mail.gmail.com/
Reported-by: Azizcan Daştan <azizcan.d@mileniumsec.com>
Fixes: 4464853277d0 ("io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[backport for linux-6.18.y / 6.12.y / 6.6.y / 6.1.y, verified 2026-05-01]
---
 io_uring/poll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -417,8 +417,10 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		 * disable multishot as there is a circular dependency between
 		 * CQ posting and triggering the event.
 		 */
-		if (mask & EPOLL_URING_WAKE)
+		if (mask & EPOLL_URING_WAKE) {
 			poll->events |= EPOLLONESHOT;
+			req->apoll_events |= EPOLLONESHOT;
+		}

 		/* optional, saves extra locking for removal in tw handler */
 		if (mask && poll->events & EPOLLONESHOT) {
--
2.43.0


