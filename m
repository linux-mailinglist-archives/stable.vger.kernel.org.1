Return-Path: <stable+bounces-10400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E4828C50
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666A11F27474
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD093BB3A;
	Tue,  9 Jan 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRQLx/48"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8333D0A8
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbea05a6de5so3519221276.3
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704824245; x=1705429045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3O3ZA/l4pzFbG0RopZ5eYIp00WCcdEIP2ujlegYMRy0=;
        b=xRQLx/48kjafNaP++8H6Ez+PeV4tghNVikTFVMZD81TkhGm7eCnZPBl0cCFAKbxYWE
         8DS7gset6Sy+dVL61qK6/uKHgsQzaLXihXpIYCWaQ+KXCGtyYlYVauyPiD925DUaCN8r
         kejNO2IUQeg/JY7Ki7juCgfy7hYXKrEAmT4FUHBjnGvHimHA+v7IRT8awtYHf46PJrT/
         Ba+P2zRuLhhcrL+b/W5TgJmBmmGoww/8o1ig2+BxCVSk6G0x1YV9StPUd/jiPr+FT/Tc
         d2xD6lzihR3UVPlKa8wvmUgbfHa7ouFSIRTR7vHTSKSekhrFAuzAv+BNIrPp6pThbgaJ
         zapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824245; x=1705429045;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3O3ZA/l4pzFbG0RopZ5eYIp00WCcdEIP2ujlegYMRy0=;
        b=YidAMRGgTnWXnQfQnPlF9GNhYLjuYhoiA5tHn7XwIR6CKnYsFbWsfD5reRm2o6ur3q
         Eu9s7y7yfZM5GXkQT31ngkYx0QG7O5iXK/fHQjE5yd4r9GQRnqHFA2XJvCd2wl5od4ZF
         t1dLmuVwWSqxxyTatAvKnomsNXXNfV/zwh4VNAg1KvKSXyfaQ2eP5mvPOIqYF2DcxWo/
         8HfsMZnnyl1/kHHNVZMUBnWo4UIBRk7ipRSqEnl3phMLC7eemQEYvv/ypLTUG8+k0fTJ
         VuFq4nNcFAa6Mpsbs2ElMQ8mj4JCpa9vLU+649FpUU5KxX4Sm8YkbIlhh6ow2t8dhxz9
         p1ew==
X-Gm-Message-State: AOJu0YzzYFMFlT7YyJON9jQridQAyjCbwk1j8tVaoYHaRbJnJyvSR0px
	JDV+bByyJG7jd6BxFXDZpwsM+BaAZG+luW4xtDrqGg==
X-Google-Smtp-Source: AGHT+IGWMruYM2IGEpW/Wzs1QzYPqFF2y3cxBj33maPl8AD3opKxTZOu26tWCKRS81IiyNIQu2xXII1BaxTB064=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a25:824c:0:b0:dbe:a677:5de5 with SMTP id
 d12-20020a25824c000000b00dbea6775de5mr197494ybn.4.1704824244782; Tue, 09 Jan
 2024 10:17:24 -0800 (PST)
Date: Tue,  9 Jan 2024 10:17:22 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109181722.228783-1-jsperbeck@google.com>
Subject: Crash in NVME tracing on 5.10LTS
From: John Sperbeck <jsperbeck@google.com>
To: Bean Huo <beanhuo@micron.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: khazhy@google.com, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With 5.10LTS (e.g., 5.10.206), on a machine using an NVME device, the
following tracing commands will trigger a crash due to a NULL pointer
dereference:

KDIR=/sys/kernel/debug/tracing
echo 1 > $KDIR/tracing_on
echo 1 > $KDIR/events/nvme/enable
echo "Waiting for trace events..."
cat $KDIR/trace_pipe

The backtrace looks something like this:

Call Trace:
 <IRQ>
 ? __die_body+0x6b/0xb0
 ? __die+0x9e/0xb0
 ? no_context+0x3eb/0x460
 ? ttwu_do_activate+0xf0/0x120
 ? __bad_area_nosemaphore+0x157/0x200
 ? select_idle_sibling+0x2f/0x410
 ? bad_area_nosemaphore+0x13/0x20
 ? do_user_addr_fault+0x2ab/0x360
 ? exc_page_fault+0x69/0x180
 ? asm_exc_page_fault+0x1e/0x30
 ? trace_event_raw_event_nvme_complete_rq+0xba/0x170
 ? trace_event_raw_event_nvme_complete_rq+0xa3/0x170
 nvme_complete_rq+0x168/0x170
 nvme_pci_complete_rq+0x16c/0x1f0
 nvme_handle_cqe+0xde/0x190
 nvme_irq+0x78/0x100
 __handle_irq_event_percpu+0x77/0x1e0
 handle_irq_event+0x54/0xb0
 handle_edge_irq+0xdf/0x230
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 common_interrupt+0x9e/0x150
 asm_common_interrupt+0x1e/0x40

It looks to me like these two upstream commits were backported to 5.10:

679c54f2de67 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
e7006de6c238 ("nvme: code command_id with a genctr for use-after-free validation")

But they depend on this upstream commit to initialize the 'cmd' field in
some cases:

f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")

Does it sound like I'm on the right track?  The 5.15LTS and later seems to be okay.

