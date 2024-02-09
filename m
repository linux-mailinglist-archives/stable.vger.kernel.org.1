Return-Path: <stable+bounces-19384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3C84F99B
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 17:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D601C24F74
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34A7BAEC;
	Fri,  9 Feb 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQan3c2J"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6778693
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496069; cv=none; b=NrIJ7iblIW/VIgEuBk9SlZszvwyOpXEyBdEujiAormM9rIOEg3NaPCzhhUMXqYmkjMLdyV33nXceiJNJ7z7jmiMhPWJPNoj7FJH/oVzimARhbw5id6SGXufzUjcf6PPTcetLxTrnV2shKx3gltdJuetjxvy2OZRpZekRWKPqjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496069; c=relaxed/simple;
	bh=3pwRrT1FzUpRhtkgskkOYTdVmVY0rUPsoZN/JPdgmCQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i7UdXBya8E2yJ7DRZSbdbH+TPW+kxRA3Q9QZcl21YfIk3e1z7lJ49cclmFTsEnW/AlBNsXT1S9rlqjsJHz0NQaXTw4mc+JOX4M1Zpsu2ekSc7LKLpCizpHg0kPc8Qq7OseDK9NSWBN+hDRiY/DMkAqJakgBEuvYrq6zXFaIUDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQan3c2J; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a4923adaso21314627b3.0
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496066; x=1708100866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdv9R8T1Hiu5dOrjXjtGbBuu1N8RDpvYkY9+ULr5or4=;
        b=VQan3c2JhNZTCusFC2mFfyhmkpb8wcKj8JAt6thaPmZTMU7k2wAGGUNiMywUQ5RCew
         YFWm8sEXucdHIDsc5oCZ/wOboBvtV3SKivNW18mALCLJ4R7gDJERQmn3sWXZmeQTG08I
         PGFZuT8InGXWvEJxvdcT2FLgKtO8iq+JE1swwndhHBBBj61PMp34tSwBVM5EppHZwZtM
         POROjd86VaprsHVbarW8ptEH32jJrzozdUuLk2ks7O8K6e1eUO4Y0+pvLQ0iT5wlTL0J
         f7okBzq8IL7Qa1mjarzmXgCeXeruWarlIBiUdMhrM6qMk+tN/+2Yvw4zPqteLH81OWLD
         Jw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496066; x=1708100866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdv9R8T1Hiu5dOrjXjtGbBuu1N8RDpvYkY9+ULr5or4=;
        b=q2GwJjDc22QOTTqmJR5rrtlEYwXeG+LGsTJI0kI0F3+F+WEz9AnL4D+zeGmUNwHCkY
         Hn2jyGUVODT69FSByNYImiLdVX2CSWxjf+Jpxompb7+8QKeaud1qWjuP9abCEqDpXlQ0
         qPrKdbY2QUy+7puPftc37Lfvdr80YX4L2CKXlvd/J9eC5+xN5yIGFo6tI9+bGoczUGTq
         p5YC0FMqsAnf3UpZiwX3mFI2D9r/JvRPwTgT/VqauZa3a6cX80LnwH+dU1LQYpMpRZ66
         mISWLNcvS0K421AyCJChwNyu4zFwt/CdCEAlttUwecKWZuGUq++CS0iqf9waitwzjtLh
         Oj7Q==
X-Gm-Message-State: AOJu0YyMvWwFjYj4tIYSRyxhS82Pu9HnWIPsAkPoNcpiZkAiBqUfgr+G
	Q1YAd8hptgejQcDvQIchXluRHDm6XkfnmI4gdku8XqQ2pcySgtnAVt1no+gLQMsEDs4xk7OTzhd
	eCl8sThpxb3rIrFk/WKNQbdDMkgSo6U2DORiGcR54rLfsaYEddY7rTonYidP5UBC5HZlmV+TkVj
	mAKyMH2R7qOOvhHkXGNK5g/Wot86Y=
X-Google-Smtp-Source: AGHT+IEAGiwe0VbuqCITbAvd78XftZ87EeC2xxoSH1w25UL0kSiVU8Dy09ZADZSkAv8g4iatBivJngSwcw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:6cc2:0:b0:604:269:9d85 with SMTP id
 h185-20020a816cc2000000b0060402699d85mr271803ywc.6.1707496066427; Fri, 09 Feb
 2024 08:27:46 -0800 (PST)
Date: Fri,  9 Feb 2024 10:26:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209162658.70763-2-jrife@google.com>
Subject: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
From: Jordan Rife <jrife@google.com>
To: stable@vger.kernel.org
Cc: ccaulfie@redhat.com, teigland@redhat.com, sashal@kernel.org, 
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com, 
	carnil@debian.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

Backport e11dea8 ("dlm: use kernel_connect() and kernel_bind()") to
Linux stable 6.1 caused a regression. The original patch expected
dlm_local_addrs[0] to be of type sockaddr_storage, because c51c9cd ("fs:
dlm: don't put dlm_local_addrs on heap") changed its type from
sockaddr_storage* to sockaddr_storage in Linux 6.5+ while in older Linux
versions this is still the original sockaddr_storage*.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1063338
Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: e11dea8f5033 ("dlm: use kernel_connect() and kernel_bind()")
Signed-off-by: Jordan Rife <jrife@google.com>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 72f34f96d0155..8426073e73cf2 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1900,7 +1900,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+	return kernel_bind(sock, (struct sockaddr *)dlm_local_addr[0],
 			   addr_len);
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


