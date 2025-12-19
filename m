Return-Path: <stable+bounces-203075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904FCCF932
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE543019B42
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1C3176EB;
	Fri, 19 Dec 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="BG0Xw7qK"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E528316917
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143860; cv=none; b=nqj07hAUOfz9NwX29HHWzie70asnfTWMS0XglZcFrh2I8HE5fxYzZwL5fOAllx2gtGSnzQBT9Pch9nTY8q/ZvcJEkeMEYdUxQAZxnitFXFAlxItcE9TxdtDv6yW7If5V7DqzVBh0hTyrLCQq7bQ3wA1eTpR8l88SxLVprDWyJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143860; c=relaxed/simple;
	bh=mNgWqOCOsQ6WD6Sa3R9N6nDM2gk1cL3HeNVSNZG8O/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjfSVewJK6ayLPCN4Bewu2c41uCjXyq9dX9+RqAKUlin6xZcRnilimXadfd/LWZZKfRxxLwvGDGdwjhuZ9B7ikn4wYEDNdUT+1O6xY4YRIOw3CT25mjzCboOZ/MZPoMzRFG0/1yEyn5Sv2Y8bTcsfp3PZAHhFGpKwU6PQM8B5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=BG0Xw7qK; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=BG0Xw7qKPBPCpqwPMHsf61wJIhPCL5WyB8soMJVjJ/h3Itc7BXEa3ialCwpCQ8SpL6AVnsHbiSdZ2
	 Ngi+2b38QhU0wbsybPLu25Ug+xocacgjVp5Ki12mMNK0KjRncoXjLfrzKx3mEaUiLstHpSk77y1srH
	 xN+DxrtMdXW85cIM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.224])
	by rmsmtp-lg-appmail-21-12024 (RichMail) with SMTP id 2ef8694536a0961-0da3e;
	Fri, 19 Dec 2025 19:27:32 +0800 (CST)
X-RM-TRANSID:2ef8694536a0961-0da3e
From: Rajani Kantha <681739313@139.com>
To: harshit@nutanix.com,
	jon@nutanix.com,
	gauri.patwardhan@nutanix.com,
	rahul.chunduru@nutanix.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	pauld@redhat.com,
	william.ton@nutanix.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12 0/1] Proposal to backport Fix race in push_rt_task to 6.12 kernel.
Date: Fri, 19 Dec 2025 19:27:24 +0800
Message-Id: <20251219112724.1960-2-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251219112724.1960-1-681739313@139.com>
References: <20251219112724.1960-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Harshit,

This is a backport of upstream commit 690e47d1403e90b7f2366f03b52ed3304194c793
("sched/rt: Fix race in push_rt_task") for the 6.12 stable series
(and potentially 6.6 if applicable).

From code analysis, the same underlying race issue should exist in the 6.12 and 6.6 kernels.

Since 6.12 or older kernel doesn't have commit:af0c8b2bf67b("sched: Split scheduler and execution contexts"),
so the backport patch removed BUG_ON(task_current_donor(rq, p)) in pick_netxt_pushable_task().

Please help to review if we can safty backport this fix to an older
kernel, thanks.

Regards,
Raj.

Harshit Agarwal (1):
  sched/rt: Fix race in push_rt_task

 kernel/sched/rt.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

-- 
2.17.1



