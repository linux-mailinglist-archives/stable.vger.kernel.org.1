Return-Path: <stable+bounces-52260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F9909605
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 06:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8662830B7
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E848DF59;
	Sat, 15 Jun 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiyUjbxv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799B19D893
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426744; cv=none; b=LGjlZKxtQkrYEodqpmR1XEZJis91yq73xrA2LyMs4XJT8w3j2GS9pLGwTr5TiPJ1Lz0INu/PqTXKWgjj+VkFTdq7Q59P4XfN+9K9FIz1EtaPh7Op1UbwuRKFdeOUlvBSBqjDkHUqCMzbydtph+Pn2Ll6GPZvc3CMHD36M8VdGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426744; c=relaxed/simple;
	bh=FSYzqXk5GCVDk0+QYP2MD6C+6aLyvkArzgiSOUKHXe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lKmYfxZIDINZ1NURnyMP/n8owZ2Lm0IAQpxyiuAEMC2KIOh38VQBwCTl9aQxeOuTtHr7dEJA7UK8jkwpp11BsHlNCtAbWO13jup2XWyo91XJMOtBLg/8AUfncgU4vrd8xS5w4tXbmt2UZn68ViYKo4ZhwN6X0oUuNTtwD7uQsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--swine.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiyUjbxv; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--swine.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so300954839f.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718426742; x=1719031542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ux3AuQ+Jiebt7/7pb5tqKqqOopFVDXImGSpGZa//7ic=;
        b=IiyUjbxvrCsUx0r/zmlyuvWAmkDuQjhjIpTD2tcvIRgISnPXxpeaabaWU9klYvAaq9
         +I1IdsPzc01BlbQLrWFeb+YZP4Fy6IdPc1N8zebjLX+Sz7rQdfj2FhydlxIvQioMYl7G
         g4Je5VoupyT8is5A8fjnWZmc6FBBY4788T0vhlungml+tq2g2ylI8Ur3H15cfd8dX677
         c/e7yEDfZSPuJ4di9xlFnoJpkrMv9DdoHiFo7oIMs7uZ9E4t5Y6H4pFwfAqeyQgmIp1k
         BoKsxUWm39daWJ0NS2O83/0DW9jt/YGUAS695juyqe8TNmlJmOkUeidHqSY8goQto6lr
         Jguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718426742; x=1719031542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ux3AuQ+Jiebt7/7pb5tqKqqOopFVDXImGSpGZa//7ic=;
        b=XKTU9J/QqubCn8TS1sPhJwj4nFPKbJUfnzLTM7Pm1v4xvQzIrvQfsGxmI4ev7R7riv
         RAK2vuVzgPzP6VOmnsOzmErGtk94tpyQvq4S4k92XxuO3oX/hIkbG6mkXHeALHs6M5GQ
         WWuWPN90uWTriI7Xi4bCXZAEuHUMmtNW7/93z+Neqw4/JSssZHOsGamngZzyhPMK/YFx
         2s4hQLUfwWMIC5WScpOPntERQwat0rWj209jyog1ma+/qFXm223VkW7CYSyChxJz1Ln8
         +PNcKuI/H5Dd8mQq7cv7xOf8NxvokjMZ4EzzM8GPvyISjf5PrI92Rd6WbEehj05FbJwI
         CDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaeSrBe7ssMV7YTBp9E8U4wQq1dxP+L9GZ9n/r0pzM84XqPgn7/oWGsIG/+BGG2Ul5jr1zBt7lHV0cf9TrVpwa4Dnwtos2
X-Gm-Message-State: AOJu0YzvUOs5nqExEZuJoHmvbdjuoAenMeb72rIxkqeiQSXJew0fc8o7
	SBbxuUb7VjMrQzqyq0mKQOKxMKdkHaRjZ/cbK0ArJ3S9MLHnEL+2IUw3wkCQivYpBU5erGOboQ=
	=
X-Google-Smtp-Source: AGHT+IGUGZT+unoAcFN00GM2EaPP+12UITJqZXBTn9t/M+aCUTabZvkgCsvfjyJo9OXLHSzHG3V2S1czjQ==
X-Received: from swine2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b8e])
 (user=swine job=sendgmr) by 2002:a05:6638:2505:b0:4b7:cb85:c0de with SMTP id
 8926c6da1cb9f-4b9640b560amr207558173.4.1718426742571; Fri, 14 Jun 2024
 21:45:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 21:42:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615044307.359980-1-swine@google.com>
Subject: [PATCH] FIXUP: genirq: defuse spurious-irq timebomb
From: Pete Swain <swine@google.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Pete Swain <swine@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The flapping-irq detector still has a timebomb.

A pathological workload, or test script,
can arm the spurious-irq timebomb described in
  4f27c00bf80f ("Improve behaviour of spurious IRQ detect")

This leads to irqs being moved the much slower polled mode,
despite the actual unhandled-irq rate being well under the
99.9k/100k threshold that the code appears to check.

How?
  - Queued completion handler, like nvme, servicing events
    as they appear in the queue, even if the irq corresponding
    to the event has not yet been seen.

  - queues frequently empty, so seeing "spurious" irqs
    whenever the last events of a threaded handler's
      while (events_queued()) process_them();
    ends with those events' irqs posted while thread was scanning.
    In this case the while() has consumed last event(s),
    so next handler says IRQ_NONE.

  - In each run of "unhandled" irqs, exactly one IRQ_NONE response
    is promoted from IRQ_NONE to IRQ_HANDLED, by note_interrupt()'s
    SPURIOUS_DEFERRED logic.

  - Any 2+ unhandled-irq runs will increment irqs_unhandled.
    The time_after() check in note_interrupt() resets irqs_unhandled
    to 1 after an idle period, but if irqs are never spaced more
    than HZ/10 apart, irqs_unhandled keeps growing.

  - During processing of long completion queues, the non-threaded
    handlers will return IRQ_WAKE_THREAD, for potentially thousands
    of per-event irqs. These bypass note_interrupt()'s irq_count++ logic,
    so do not count as handled, and do not invoke the flapping-irq
    logic.

  - When the _counted_ irq_count reaches the 100k threshold,
    it's possible for irqs_unhandled > 99.9k to force a move
    to polling mode, even though many millions of _WAKE_THREAD
    irqs have been handled without being counted.

Solution: include IRQ_WAKE_THREAD events in irq_count.
Only when IRQ_NONE responses outweigh (IRQ_HANDLED + IRQ_WAKE_THREAD)
by the old 99:1 ratio will an irq be moved to polling mode.

Fixes: 4f27c00bf80f ("Improve behaviour of spurious IRQ detect")
Cc: stable@vger.kernel.org
Signed-off-by: Pete Swain <swine@google.com>
---
 kernel/irq/spurious.c | 68 +++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf07441..ac596c8dc4b1 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -321,44 +321,44 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			 */
 			if (!(desc->threads_handled_last & SPURIOUS_DEFERRED)) {
 				desc->threads_handled_last |= SPURIOUS_DEFERRED;
-				return;
-			}
-			/*
-			 * Check whether one of the threaded handlers
-			 * returned IRQ_HANDLED since the last
-			 * interrupt happened.
-			 *
-			 * For simplicity we just set bit 31, as it is
-			 * set in threads_handled_last as well. So we
-			 * avoid extra masking. And we really do not
-			 * care about the high bits of the handled
-			 * count. We just care about the count being
-			 * different than the one we saw before.
-			 */
-			handled = atomic_read(&desc->threads_handled);
-			handled |= SPURIOUS_DEFERRED;
-			if (handled != desc->threads_handled_last) {
-				action_ret = IRQ_HANDLED;
-				/*
-				 * Note: We keep the SPURIOUS_DEFERRED
-				 * bit set. We are handling the
-				 * previous invocation right now.
-				 * Keep it for the current one, so the
-				 * next hardware interrupt will
-				 * account for it.
-				 */
-				desc->threads_handled_last = handled;
 			} else {
 				/*
-				 * None of the threaded handlers felt
-				 * responsible for the last interrupt
+				 * Check whether one of the threaded handlers
+				 * returned IRQ_HANDLED since the last
+				 * interrupt happened.
 				 *
-				 * We keep the SPURIOUS_DEFERRED bit
-				 * set in threads_handled_last as we
-				 * need to account for the current
-				 * interrupt as well.
+				 * For simplicity we just set bit 31, as it is
+				 * set in threads_handled_last as well. So we
+				 * avoid extra masking. And we really do not
+				 * care about the high bits of the handled
+				 * count. We just care about the count being
+				 * different than the one we saw before.
 				 */
-				action_ret = IRQ_NONE;
+				handled = atomic_read(&desc->threads_handled);
+				handled |= SPURIOUS_DEFERRED;
+				if (handled != desc->threads_handled_last) {
+					action_ret = IRQ_HANDLED;
+					/*
+					 * Note: We keep the SPURIOUS_DEFERRED
+					 * bit set. We are handling the
+					 * previous invocation right now.
+					 * Keep it for the current one, so the
+					 * next hardware interrupt will
+					 * account for it.
+					 */
+					desc->threads_handled_last = handled;
+				} else {
+					/*
+					 * None of the threaded handlers felt
+					 * responsible for the last interrupt
+					 *
+					 * We keep the SPURIOUS_DEFERRED bit
+					 * set in threads_handled_last as we
+					 * need to account for the current
+					 * interrupt as well.
+					 */
+					action_ret = IRQ_NONE;
+				}
 			}
 		} else {
 			/*
-- 
2.45.2.627.g7a2c4fd464-goog


