Return-Path: <stable+bounces-158982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABEAEE565
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98FE165FC2
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48F2957A7;
	Mon, 30 Jun 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpkAvPto"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1E2951D8
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303360; cv=none; b=r1+ecfOtQJOsfmg47Z3dE533iDQIdrCCpEc7OJdUL1ErTmrpZG81g3ETBemHT0njktI+0W81OQcrdXYKQhaLfDYTvaauP9y821A6Wum6mWaGETv0RxtUWD5Ulc7jAlSvs04sef1iJkH21w2j4+mzNn/KIDXKk1KAOZ32fBOViGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303360; c=relaxed/simple;
	bh=UUSKaxqW2JiZ6k8aAINHbR5UNuJdzh+o69P4Z8rDROo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IoM9Y+QL+GgdRXtiMVr8rv/9Lji5cLywgMn6Z5sdz+ToXSUy/u76cQSYB3aVklwQX1n+M14TnUXmG2tN7ZcRH0t5K8f0bOpVLTUEKuYyXLsLKU5gLmfYxYS2D7wZuQw3Qqbq22rLenYIqSR4VYvzALgjUjYaYcS8SPC0oG5JyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpkAvPto; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45311704d1fso14437245e9.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751303357; x=1751908157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kM+poFmpKItXkYaDEhmuFa89I8i1fFFkiIMelce0Oe4=;
        b=fpkAvPtosy3mbcWEeN9ocHxwPv/cCBOvKQLhH77veW3Use6wVoR8I7A4m9OpeYrfNG
         0YTaUhsWfF9PVuWzomVHetWHh8s81r+7N0WlMK/46h94PQwRAiDnXykvZ9SV14+LIQBO
         Vv3YE6pGdGZVZhsncFidxGKlPQRupF87QTeKmfkVvUsc8Szvtc4u5U5HaUwe3N1G38Yt
         g+7xfDeNEPDTs+vuL1u3HySwY+NDR7+bqGY62nNQeLK6Gzr6zQ76PG2zhpeWBZ9QWonE
         Rup3Huy0tJ4oriN4rT6o6DntRkT9P1JGV0yjm1G3mliAh63OtfkbeRrby2O98vFraYL4
         IA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303357; x=1751908157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM+poFmpKItXkYaDEhmuFa89I8i1fFFkiIMelce0Oe4=;
        b=VvYex+ciZQS14fv3xQbt9q7ZvAoPzXY2SZ3PDq4HMi/A7SKXciKvFENtKqyt2lUVl5
         r0cYQWCoi85D4jjLtd3UWRFPp/XYBdYdjV9oPPdMWnCoLVgEeDgbHXZ+/+zlKZG0DMEh
         y6JWs+m4s+EnOUBW3M7pbhzVnvDmjB5RB6RDgW3yRGInQqPGh02N1MBljInr/5ft4fvt
         7KauzJfhYY78gLcwVcz/7LPgpVHjNlezfCOVCbibI3NQpohw/0Pe5wYP/wTsji398PLJ
         SHLjYxlMrqsP+Yr0TVfdsMXnF0AFR8mC069DvayqYTDVxrUSmkzM9phUdxHdFhST3pTs
         u/bg==
X-Gm-Message-State: AOJu0Yy1+i+8jQZ2lNUD/Pj110CMm26nYEmLrkswXC7QLTEh9CPZgaVg
	pto7qz952lt7jiA27E+Ar9CfIKrGcPeXutWiUdxCX5gsuQoLxi11BgbrDbHFsTZ04TBPZ6Y46Sm
	3o3i5EI06aBEYAaSQyo3jT7G8Lo5dqkbMs4P3OPLs2cq4FrSHkYT9vQEEMAVr32jOPk9c2ChV0H
	UG8h4GUXiH8+yrAx25Png5hARlnxFOWYiwuZG5aQiUDFdOHXI=
X-Google-Smtp-Source: AGHT+IFZGpWbed6vexGOhMFfsFnZUtmsDJtWbg/hA2nciuk/aGV5FLxw5JHySasMeCX1Yv92C2NXaTWKwGhhHQ==
X-Received: from wmbeq14.prod.google.com ([2002:a05:600c:848e:b0:442:ea0c:c453])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd1:b0:453:6f1:bdba with SMTP id 5b1f17b1804b1-4538ee60a60mr116785185e9.20.1751303357487;
 Mon, 30 Jun 2025 10:09:17 -0700 (PDT)
Date: Mon, 30 Jun 2025 17:09:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK3EYmgC/x2MWwqAIBAAryL7nWCG9rhK9GG21kJZaEQg3j3pc
 4ZhEkQMhBEGliDgQ5FOX6CuGNjN+BU5LYVBCqmEbgSn6yDu6OVWaeVa0XfGLVDyK2DR/2qEeJt 5R5hy/gD2RrruYgAAAA==
X-Change-Id: 20250630-ipmi-fix-c565f7098afd
X-Mailer: b4 0.14.2
Message-ID: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>
Subject: [PATCH stable] ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()
From: Brendan Jackman <jackmanb@google.com>
To: stable@vger.kernel.org, Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>, openipmi-developer@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Corey Minyard <corey@minyard.net>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

From: Dan Carpenter <dan.carpenter@linaro.org>

commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream

The "intf" list iterator is an invalid pointer if the correct
"intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
and invalid pointer will lead to memory corruption.

We don't really need to call atomic_dec() if we haven't called
atomic_add_return() so update the if (intf->in_shutdown) path as well.

Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
I have tested this in 6.12 with Google's platform drivers added to
reproduce the bug.  The bug causes the panic notifier chain to get
corrupted leading to a crash. With the fix this goes away.

Applies to 6.6 too but I haven't tested it there.

Backport changes:

- Dropped change to the `if (intf->in_shutdown)` block since that logic
  doesn't exist yet.
- Modified out_unlock to release the srcu lock instead of the mutex
  since we don't have the mutex here yet.
---
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e12b531f5c2f338008a42dc2c35b0a62395c9f3c..6a4a8ecd0edd02793eda70f9f9ae578e37da477f 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1241,7 +1241,7 @@ int ipmi_create_user(unsigned int          if_num,
 	}
 	/* Not found, return an error */
 	rv = -EINVAL;
-	goto out_kfree;
+	goto out_unlock;
 
  found:
 	if (atomic_add_return(1, &intf->nr_users) > max_users) {
@@ -1283,6 +1283,7 @@ int ipmi_create_user(unsigned int          if_num,
 
 out_kfree:
 	atomic_dec(&intf->nr_users);
+out_unlock:
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	vfree(new_user);
 	return rv;

---
base-commit: 783cd2c3dca8b6c434e955b84c20c8940588dc68
change-id: 20250630-ipmi-fix-c565f7098afd

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


