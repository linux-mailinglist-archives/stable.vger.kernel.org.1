Return-Path: <stable+bounces-77047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F3984B3F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8671F20582
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941391AC8B5;
	Tue, 24 Sep 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hewVFhhz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32A1AD9E8
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203455; cv=none; b=K3G59TCtxizESXECzZJGSFqlHbuIYzvQ5eL/jSIkPUTOWFg5K6tP4Xg+Jv4ZHdFeJHGN2N/M4kGSVntt9kWK5PAppjABK1xpguk1QsriTeIr4RiNvKPGD1D7p2F6ftAVRZ/P2EdIeyFDX4i3TULPi2XPzLb9OH5oDPVRN68Ufs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203455; c=relaxed/simple;
	bh=04CSVSNbQAoz5nJrui7w9wr9IJQYbvvCjU2rJHdTZ0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGOn8Lub3Ahr+PLAC3MzsKq2g2aAGWd7fnEY5hAnAz8nPdHdc/6PjH+6kWWJpI7+OEqhVewSRdpxwdc2vltgp/NAbhaDX+4GUoHPTe5MGqOSoXJhuo+Vw68X0dObFrga95iTsj2gNpIOiH+Nr2w1ThXGELuIb8n7ui0MPksUN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hewVFhhz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d50dadb7f8so84564a12.0
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203453; x=1727808253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbeoTgd2+9GtK/0uZbn6j9cZRGaoAw7YTDGHmlJEwk=;
        b=hewVFhhzJ88PLDi46vxv7W2eDE0atPzfZNSfzwXmpyjbzk8RyktM70wsdIPqMUlIF2
         xFV+RDvRMGUjy/W2PMArtGoSwi2emHqE6xhFMCh2VGBlRyAB4DrBQ4pXzwNQ61l9J7fz
         N21DqmY3qA8jPZTxeiCz7ebnzwr+xEzYB4nr2htY1zD+/CKfLaUzSo12MbqRYxJTlzUe
         pj48o8ppqUq9Q9awkMDaNj9gw4BCp02YtzaHtE5b0825jLT8YYkckcsfB/B65A5wBj7M
         XSiBiuq7gGcgis+BLeM6g/zw47AxBjBGjAi0vkJrSmgCVL3q8joBC1QZmqthoyu0clu3
         fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203453; x=1727808253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbeoTgd2+9GtK/0uZbn6j9cZRGaoAw7YTDGHmlJEwk=;
        b=qtEk8k/6OkFBNqJOcOj0ofXX4Z7Yy0M6rKZTQnMRnUe+Ok5PSS3ZZROAjo/HmQCrSk
         8DzS3NcbFJrs6+HuAIy1pJ/GCBY4RFgmua8hJlvi67uOZAQ9ELBv3zKFjqfKddDlla6i
         pJbStL6SpozneAJFUlH1kPEJkRDUlsBnoYV9+Ro2jZNgnmsR9fS+5yzkZWh8S9gl91wk
         F+ExJkBaxtGxt9bH4SEN1hSvXqkZ+gmpG5WHHidkVHEXxzncxXpjaXWy8yzcb+oOdv00
         2P6cAoPbZS+S0BMwpCd0yLYxApuEUL4fpPllHAWV3+d4dmWwsvwQOUoahbv8SWuH/BSI
         tb6w==
X-Forwarded-Encrypted: i=1; AJvYcCWnZppprFZn4Iu6uT+N8LU2YjCLFt5cirmHGGjkWRZRWYreWP9/mk7xQZatY0by5CXDwAI7M0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5uPxiD8GxOB2Ivcc7ivsiJ4TWnflmXcHwJ8Elg5u3MeiWMOK
	6SXe7Hkm97YH4w41qbAzGrgPZZaTgGLLkt7yCjyBIR1azF0SuHVVn+asNFJnk4q7MupeoWoy4Vj
	3J1Rr+Rhyyw==
X-Google-Smtp-Source: AGHT+IHcLZagAFVZvHn7R6Bk0sNRHbmj4BNbuwjtI6JLKo9USznZI2FyUOXL0EqWX8s17YI5FdFghtjemXEFKQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:3a8f:b0:2db:f123:60b2 with SMTP
 id 98e67ed59e1d1-2e06ac92ae5mr428a91.4.1727203453216; Tue, 24 Sep 2024
 11:44:13 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:56 +0000
In-Reply-To: <20240924184401.76043-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-5-cmllamas@google.com>
Subject: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
entries and it shows up as "unknown work" when logged:

  proc 649
  context binder-test
    thread 649: l 00 need_return 0 tr 0
    ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
    unknown work: type 10

This patch add the freeze work type and is now logged as such:

  proc 637
  context binder-test
    thread 637: l 00 need_return 0 tr 0
    ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
    has frozen binder

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d955135ee37a..2be9f3559ed7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
 	case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
 		seq_printf(m, "%shas cleared death notification\n", prefix);
 		break;
+	case BINDER_WORK_FROZEN_BINDER:
+		seq_printf(m, "%shas frozen binder\n", prefix);
+		break;
 	default:
 		seq_printf(m, "%sunknown work: type %d\n", prefix, w->type);
 		break;
-- 
2.46.0.792.g87dc391469-goog


