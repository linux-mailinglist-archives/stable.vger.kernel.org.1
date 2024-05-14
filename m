Return-Path: <stable+bounces-45108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12FC8C5D66
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 00:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F542826F4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFCD181CE4;
	Tue, 14 May 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQSNSf6E"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B404181BB0
	for <stable@vger.kernel.org>; Tue, 14 May 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724101; cv=none; b=q68umUn6gec+ckXugbVADr+KTLxwJYedHfZfOXIb2CqJ1suggeQmrXbM60ptks901sBTA9YO5BzLpwnnwFOUfRHNiykOv4On8CbRGGb+wOKXMQ0GAsV1NP0EeuNWyWm5VMNL1iqis6kFZtAJa8Lk9U103ZhRMb3TCpw9E1O4CuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724101; c=relaxed/simple;
	bh=S1tIWGM3NKAB6bQddDwAPW4gGwnmbTJEnABhbu0cG9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LI1/YZWufilR0OqpxbYhnY6xmw665/1x07oBFOW0zrS/0HLlWytm/hINSlmfZTWKW1EZiQgHsoq1b0i4R/3XAxfQ5JEqy1h06x2zLWyq/m1KaTQRHkIEe1u0GygIf8vqp6+QK4JyeEk1VIOc6MzfsUE6D1oTeFt8DsgVCFY+nE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQSNSf6E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee8315174dso5288788276.0
        for <stable@vger.kernel.org>; Tue, 14 May 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715724099; x=1716328899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fyYQsAdLlgEZ2rV2qIpyKWvlc+8qV4Q0/4ynMYRrvhE=;
        b=OQSNSf6EZsAB2MBPN+rntvz3u1/3Me76bPtKnPMC8np7XFV4Z5adN0LjEP35NoR+ag
         3hhYhHrtx/u0pHnpsesMsw04Ex1c8cdI/zdAiLva4pcfLrcBtvPU3T3DMM8gCjIlqyLE
         FhqUyyX+t+4f/q3BD6t6IRMRyFB0uPuQAaCcFI9bxMtghWRyCwIBCGB40eC9q2hVtHtI
         jzYqaJD9n8rdBx0Ys7HX4wVvqi9SntuBJDDvZzmBmgLZKdsTrLCmGihqUoONYq0RwGDB
         MO27gbAH6JLIYOidikk21X6QJzMGi2ixr3A4bFDd5CR2YVO9AlavLL1JLP6F0kS3uDlu
         kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724099; x=1716328899;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyYQsAdLlgEZ2rV2qIpyKWvlc+8qV4Q0/4ynMYRrvhE=;
        b=RfbIHdFtB9EST1eGihRnJ0MnZK2b9ZfoI+6mNMC6jGvazRMzT8Z3bjcuaZcFhuwvRk
         3PdAec+deByKKF6RtoOXcFQEsvyjisM5Xa+dxei1OQ9kCvcuYPWauqK3acxJoC6um85C
         KSTTWhrZm2rsWRvw8MVBJQk29m/OCcLbXz0Mfh3LvxnvIlJ6QulpZ9UHxd49C+k9Vfwj
         foSaMSvI09+/jrU4qD4uB6p8IKrQcNKMG4WRqcLfQH/fmphE55c91E6n1nKdMKuxWhKA
         VzHwkHXOL6j8uEUOiO1Z+OKkREchWVNTTwIOM3/2jYbUKhPvJJw63A1DyKMK4aQAcwro
         lEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWUhuy41EL7p74Y2+a2hERF7S29uOS0dwx4H6c2FYeQZSuzAj0hTtb4NjFf9zX+b5ovuyf1gIO2m31AHSnSJKXBT6sd/6x
X-Gm-Message-State: AOJu0YxUsVjSsvGHtyxJsCaCsStPrbq6156PC+em0gmKPTU57hIIT0c5
	D02bGX5pBN7cM7PtBqPxK+P0cqrYan8D6F8vZw/eSWfUuNMBJTsRRGI8GyqZI+pFKdMYt3PQ6t5
	Wzg==
X-Google-Smtp-Source: AGHT+IFQuPmXbAuMV4yHfCbocvMCwkaDmQTqNl+j+oT+iNlZrjwgKW3FanuU4+YpCrGMlG3QFv2xd8A+IXg=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a5b:a51:0:b0:de5:4b39:ffd0 with SMTP id
 3f1490d57ef6-debcfa7dc5emr3713479276.0.1715724099609; Tue, 14 May 2024
 15:01:39 -0700 (PDT)
Date: Tue, 14 May 2024 15:01:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514220134.2143181-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps
From: Amit Sunil Dhamne <amitsd@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, megi@xff.cz
Cc: badhri@google.com, rdbabiera@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There could be a potential use-after-free case in
tcpm_register_source_caps(). This could happen when:
 * new (say invalid) source caps are advertised
 * the existing source caps are unregistered
 * tcpm_register_source_caps() returns with an error as
   usb_power_delivery_register_capabilities() fails

This causes port->partner_source_caps to hold on to the now freed source
caps.

Reset port->partner_source_caps value to NULL after unregistering
existing source caps.

Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8a1af08f71b6..be4127ef84e9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3014,8 +3014,10 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
 	caps.role = TYPEC_SOURCE;
 
-	if (cap)
+	if (cap) {
 		usb_power_delivery_unregister_capabilities(cap);
+		port->partner_source_caps = NULL;
+	}
 
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))

base-commit: 51474ab44abf907023a8a875e799b07de461e466
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


