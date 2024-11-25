Return-Path: <stable+bounces-95377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04409D871B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F837B390F2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADB1A7AC7;
	Mon, 25 Nov 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUG+O85Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FE199EB7
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539234; cv=none; b=SZ7dph90z1rblESE9xOjXnvLJHNPOQJMvsDIA7hv+nTEy6yI/c6tcvslza3aZ7yCIaWIB7Hb5ePRBydX5Aaorl7di2ZQU/tN1rs9aX19Q0X9Pn2ZAc63Ifh/Ajge91vcB7NFXbqVwm4s0ldzK2FLL7YgDz36wo3jIkdQYrIByjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539234; c=relaxed/simple;
	bh=qpn3nL4ruTIH9jcXSn5EnaywmyoyKdo1VON2EkUGiV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ccDXdu6W4SnlMDawdfUGIOSTYktkUkwX0eUXbbNQyN5MFOzhAgWUv9lsQj76ToRRKAtBCXpUYTLOimkqIXQ76Pk6c/VHCsbYILGeDes62jTq8URwvOKpEyaNAT7PPLz9m7H6M349nSpzsesvXtP/7muKxRY+I0oO020JlUl/VVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUG+O85Q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb8aa2280so68774447b3.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732539231; x=1733144031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQ4bkEkWXI9460U69LX56jW+n+QgNq12f2hQHN4SQHQ=;
        b=EUG+O85QFtdwdD6iurL9QkH6pPPod3l62m7vNUX9J3FmJUZKaKGHjJWuAEvEP6IaiC
         243biEHaM+xutmCgPZKUi+md/TMW1YMwKMmi4c/utrXUMHf7bxsRN0jUS8XQPOqmMj7T
         7vX/EoGITzMMwlkEVDdqhhad+1hEdfy1OhA1109t38JlDjdMU8Ps3XPVNPRg0zsyPAfo
         9elHJzUlARNBBtMAitm9l4wmFKSPTuiW3kaG12RIcbv/OxawXWbJrCYZ0275oZ2zCkif
         iFbUoouo7sDug8gEDKWEO3bSNUZ/bP1eWPAkdHrJ2UjyrJjCxykodETqOrB+Pvxgvswf
         qYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539231; x=1733144031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ4bkEkWXI9460U69LX56jW+n+QgNq12f2hQHN4SQHQ=;
        b=sCft8A4hkw7/fB7t/b5Pz2EriL5ZTtbpc2eiimihoZank0jsTDLQBdrc297S5qqYuT
         zcscN6H5GXoA3ZbhYZ7kE8K3lB7SmRQuM1m9o5Tz8oHSD5/LbRv06PKuX9a2DemM3VP8
         apGiTMOlGgdQJI9WUa8uGDSXXxtCcHaIUNBCqy+UjfBLZM6DFOw8d7lUa2/hH2QKiCl2
         9+ludIvCELQhJYSixwfuDj/8DyiVS4QQ1DR2WreHnybFGqf5SyUtzeFituDGjK0A60e0
         MBr4hYhtG9rTPbd7gaOvctKPk4QFdabQ9RHhkxG2+37n9J9f86ztbtANpD7XKQno1WlU
         MLrw==
X-Forwarded-Encrypted: i=1; AJvYcCUp6gjLe1p6wOKZM9oQeUaGdCKlD0rGcTpiFuXKEjLA5Ptrv+lxZy7MpRcEpjNYUpwrllcbujA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+log4ot4QV/VYztaUcH8c85r9OlO5HgEA2qnpEuZAS9KQYoSh
	Rnsl7j8Fy+FXx3VSfYmc6oCPu7lef2UKgUA2faqqCqcR69II0kbjfotxzFG9HNlQpqHnCc4TnaK
	zk9R0MRdegS6toR8q0sch5MOGZ0TWIQ==
X-Google-Smtp-Source: AGHT+IE19EwzHoDlqo1+yfATE7tPwcQWjdN41993yStl979u2Ve1bKHZt1w5Eo8cthREpp6xIqRXTv4idhncz1Ja+bW0
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:6709:b0:6e2:1713:bdb5 with
 SMTP id 00721157ae682-6eee0a39166mr522877b3.5.1732539230924; Mon, 25 Nov 2024
 04:53:50 -0800 (PST)
Date: Mon, 25 Nov 2024 18:23:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125125338.905146-1-vamshigajjela@google.com>
Subject: [PATCH] scsi: ufs: core: Fix link_startup_again on success
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Set link_startup_again to false after a successful
ufshcd_dme_link_startup operation and confirmation of device presence.
Prevents unnecessary link startup attempts when the previous operation
has succeeded.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 7caf489b99a4 ("scsi: ufs: issue link starup 2 times if device isn't active")
Cc: stable@vger.kernel.org
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index abbe7135a977..cc1d15002ab5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4994,6 +4994,10 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 			goto out;
 		}
 
+		/* link_startup success and device is present */
+		if (!ret && ufshcd_is_device_present(hba))
+			link_startup_again = false;
+
 		/*
 		 * DME link lost indication is only received when link is up,
 		 * but we can't be sure if the link is up until link startup
-- 
2.47.0.371.ga323438b13-goog


