Return-Path: <stable+bounces-41392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578A8B1635
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374B21C22A3A
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 22:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52323BE;
	Wed, 24 Apr 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guZZAZsj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDC15ECEE
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997974; cv=none; b=A/CEwrHi7Ruay6I62pCuA7gL0evE00KhGKMLBD59vRRCVHMpwl6/y5tN63QBkA1IgPTQHiZGu9RmOn5LzOlpSrQLtFo9mibIt6qXyys0y2jPL041gZbcfgxEyvsqjeR4nEGf12COHB0E7J4PoxJqCGPCy5G6UbUFxMZZ/VQr15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997974; c=relaxed/simple;
	bh=W8L5h+SzHiautt9SqcHIuNkveUNPF0/akp2X0XV3TX8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NkIEjsy3XR71LNqR4Gmc4Nx2C175Ii5B5BtyFAW5njF9aIx4Sin+puTQideQU36MA0nyHF5v1BEZXRRBMgSMMZMOF8nRKP4MknjwuHh26XYB/EFUX7vNG55Qf3a9NIrDIUHQn2+w513SRQ533+t+K07/xK/5CxQSRQcpOXt68VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guZZAZsj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5520c25f0so792794276.0
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713997972; x=1714602772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NbcoiaRXrJH9+uu8XHipFnZdxDGtv91eD3q0pnQrtk=;
        b=guZZAZsjFFEmc9Y70Bii2275K6ywVGJRSZVAa3ZQeOPI4SHensdfdc518JrW5rxiNU
         0GmPgzYBuFyDg+mX7wOUSo25inhHowcA173zPpyntnLPJ676zNqk2XLuP2mK0dCk9pMH
         /OSUkOms7h1fq8iY8lnIkw+O2ZyxeBKi3uwuW9gbu6rGydfqzMV4QoThhr9q0m8/gmKR
         wBlyOhMfLL6vbDHmvfwmQWLi6plnuT4NeKwcCCGN8oROdYaGVjqFIVf5iPuU/O8jZi3C
         Sdsp5MFdIqyIuUMHBVzME+BSZRtTmS2lzol3/qn2HJ2giHolLMoPRYHH43RjoGdVYqyX
         RfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997972; x=1714602772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NbcoiaRXrJH9+uu8XHipFnZdxDGtv91eD3q0pnQrtk=;
        b=lUZU0GwYbbyrWaJ5PgUDmbWNKryoc+g/C5y57A3grcC8VPPka4oWhoXbxeMzCwLrhf
         d1WcdBbv6BYAZe3ORLohXjFSpqoswJ0I4223SZiW5fg2mdTuKmlTaL8e29msWbmUEbcX
         mc2lBk3eOhsikCeKy9+9NZgu7I3beLM+XxZ+vgPQGwg8SVrf2Ulu+tOYky2GGRTF7PKF
         eiqpNRG3ZnAnAYoWrdQc6lqlnuWj3QVZ34DjLGM2gsi7G+rMIdmSknAAYrEYxfKaCdtu
         cMqcLfhEdiidrQqCLfOKy9LaFH6oj5Hdlc8hRR8Q0fzuxB0oNH4sUlGML6H9FKMXw0vL
         EWRw==
X-Forwarded-Encrypted: i=1; AJvYcCVP/dYJ+Y74oxBqZf4irYDxVwYXjVu8pNkaD7BHEhqwL2s8ULfmYMc2P6q2/UmsqU9ttFfZ4XpzrlY2q5UcO/o63zvc8AOz
X-Gm-Message-State: AOJu0YyN5PwPSR81kMzXzS/7cuiVZfARSPS+MAThgKDh+aJxMK5OU4kA
	3eAgnPG5tP8cN4RQtz7QSktH4xygHaYvwdaAouU59mRoEWi/shdr+w8vAN+8DVLsCi5nWv7VWTF
	BAQ==
X-Google-Smtp-Source: AGHT+IEgyiK0mF15tmGzPHN/qd3iIL6vfDLxMFx9Q1Dz4XF8BvW7SaW9Nw5e/kMd+OXWdBo6XB2GfwuDVMk=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:d509:0:b0:de5:5693:4e8e with SMTP id
 r9-20020a25d509000000b00de556934e8emr371664ybe.11.1713997972127; Wed, 24 Apr
 2024 15:32:52 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:32:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424223227.1807844-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: tcpm: unregister existing source caps before re-registration
From: Amit Sunil Dhamne <amitsd@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, rdbabiera@google.com, 
	Amit Sunil Dhamne <amitsd@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Check and unregister existing source caps in tcpm_register_source_caps
function before registering new ones. This change fixes following
warning when port partner resends source caps after negotiating PD contract
for the purpose of re-negotiation.

[  343.135030][  T151] sysfs: cannot create duplicate filename '/devices/virtual/usb_power_delivery/pd1/source-capabilities'
[  343.135071][  T151] Call trace:
[  343.135076][  T151]  dump_backtrace+0xe8/0x108
[  343.135099][  T151]  show_stack+0x18/0x24
[  343.135106][  T151]  dump_stack_lvl+0x50/0x6c
[  343.135119][  T151]  dump_stack+0x18/0x24
[  343.135126][  T151]  sysfs_create_dir_ns+0xe0/0x140
[  343.135137][  T151]  kobject_add_internal+0x228/0x424
[  343.135146][  T151]  kobject_add+0x94/0x10c
[  343.135152][  T151]  device_add+0x1b0/0x4c0
[  343.135187][  T151]  device_register+0x20/0x34
[  343.135195][  T151]  usb_power_delivery_register_capabilities+0x90/0x20c
[  343.135209][  T151]  tcpm_pd_rx_handler+0x9f0/0x15b8
[  343.135216][  T151]  kthread_worker_fn+0x11c/0x260
[  343.135227][  T151]  kthread+0x114/0x1bc
[  343.135235][  T151]  ret_from_fork+0x10/0x20
[  343.135265][  T151] kobject: kobject_add_internal failed for source-capabilities with -EEXIST, don't try to register things with the same name in the same directory.

Fixes: 8203d26905ee ("usb: typec: tcpm: Register USB Power Delivery Capabilities")
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ab6ed6111ed0..d8eb89f4f0c3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2996,7 +2996,7 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->negotiated_rev };
 	struct usb_power_delivery_capabilities_desc caps = { };
-	struct usb_power_delivery_capabilities *cap;
+	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
 
 	if (!port->partner_pd)
 		port->partner_pd = usb_power_delivery_register(NULL, &desc);
@@ -3006,6 +3006,9 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
 	caps.role = TYPEC_SOURCE;
 
+	if (cap)
+		usb_power_delivery_unregister_capabilities(cap);
+
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))
 		return PTR_ERR(cap);

base-commit: 0d31ea587709216d88183fe4ca0c8aba5e0205b8
-- 
2.44.0.769.g3c40516874-goog


