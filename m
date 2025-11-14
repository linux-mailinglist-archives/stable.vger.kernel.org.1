Return-Path: <stable+bounces-194803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE2C5DD3F
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3507386EB0
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB352192FA;
	Fri, 14 Nov 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OCaSqo1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710231B838
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132529; cv=none; b=mkwgQQAZNTEouIyEhcmO1hufhj1bEqRCSUfmpLeRkXaBUPnX9XwOZ8U9u2CwyoFWSJrCH+S+GN9QVyztzXBpJwKUE170FqWs+YQhfizvlgp8o6Gn3mAf0p0ft1PUiC+9dCPE1EiEQ5e2YaYbaMmoMxsNV4HQMFj3tFCBf9SbrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132529; c=relaxed/simple;
	bh=7hDIzYuRMaUA+CS6rtwwNGgsxQ6FJEV9z4I0sOXi9tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KEJrZaZn3syWZraT2LzWYH3vwEqv/uwywT/djvppBANVMkzEf3BAoWQrg35+oD3xtFZXYCpOyl2sT5kTQekYbNHRMRGnw9PLHrObBNQzgJR6SiHGQozC6ohVVAr4qpDsYJC5rf0FFmEgD9RqnpB27RFnV31qVT/wP9FK94QwnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OCaSqo1J; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so3619025a12.3
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763132526; x=1763737326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U955yxDhLV946qB6zlVvcTRyppSCB6Gss13CWqZKxx0=;
        b=OCaSqo1JXxeR+iZjyNdXkt36ka51fgtbzwH/nsRrdKOKj+Ss3CjiSkr0klgw0597dd
         AiQkC2MmC4z2c428TXJdtl3JL2HQf0XihOhp68Tqa2rrnZO+1GA5GP4/1WchR6D0FUW1
         n+anwD6ZcxfGc5QbmnsFulXq8JQm4ztst2qQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132526; x=1763737326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U955yxDhLV946qB6zlVvcTRyppSCB6Gss13CWqZKxx0=;
        b=YwTjQtCjpAugpLgogzBYe+diwEjy4mSNhFMO5fXgQxVjGV3ncYx+H90Ntv6/7D5Mn7
         /1GJOFMyfIZ5T5YaodYTPe6FHrbBR4W0OpF8WGElyETH6eDltNyRDN9sKjWKkaOIpCWw
         ZhGbE3i/oIHltNYzz8F68zCSiPpKSCUECuunXUZLb2QxdK3AlTCZPClVj2KnizJoWFEj
         v2AWMvpQ+8myPAoUIdCBGI7uvieMa2ozlPfAAyHGXAFNMJ/g4VqC+sFTZxGbml1VR6KW
         WcM2tVZH4RTRgwjzomQMg3RL36eN1NvrEJRNejNpBMGuQ0NK7PfOYfaqR5Gp83C4pqG8
         Xe5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHhz6gNNujrhs4pMWpbC6wZ+IHuD3FApH62gzXuie1ju5WsG3x2TVaQKggS5wY1VKvOJiZTpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzKqsn4Hr4bjuBnGAXAevoRuDfJWfjsk1P8pboZhmykjtFngI
	2diQfBjJxRiludQsbElj2vKEQnPhqUxUeetVZdLVh0TWgUxf2JrjnZjfC2x+EZes
X-Gm-Gg: ASbGncvGgEC3fqehiOOvFvw9shKQUc+uI1cSJHXBrforZcoxRz+HgegiPOCXIw1MhRK
	S565H02b2w/gAzN6FWHnVV9Pvjytq8pQ9IpCBiSH7hXKrRpLHTf8Vmba/kIfxtmOLgU+nvWNji3
	ph36ly8pttXAY2GIVoo6VBNaFE5uYWtOauVC4DkHwMvXuEsCgK1iYdZuHl5w4h2z4H6KkBg8teI
	cQDCl8PEMiMB/0KZAUcag96jT9pBuWs1lZkx/ZLaKW6AcUIa3JzDvmKq9/poFEHkjRDJMVSzKII
	5KU8HGvPPkzWUCmxfFkLVzEvj7Z5WMNemVeFA6Ao+HNJJdNZfC6QabsIkj4Lk0TiPrCWpiytTZP
	JAO8fhC38CXClUjhWugNsqlPnH7lbrSF0x7tqygwbOR773Kdo64Us5Z/9E6q+2rr2ChZEOLdyCi
	Lr8w9X6ILNZbHcq3sY08DmgTc5kBhlObB4/kQn1LBQ+p9JKu9XRD3r
X-Google-Smtp-Source: AGHT+IH1ZaD0cNEUmxmsSbxX1WsTY12b7jEcC0kAdBTSwfSu4aGWBZLsKMlZ0rahA9JVz3cwyWG2Ig==
X-Received: by 2002:a17:907:86a2:b0:aff:c306:de51 with SMTP id a640c23a62f3a-b736787e24amr358333266b.4.1763132525486;
        Fri, 14 Nov 2025 07:02:05 -0800 (PST)
Received: from januszek.c.googlers.com.com (5.214.32.34.bc.googleusercontent.com. [34.32.214.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80d27sm403941966b.40.2025.11.14.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:02:04 -0800 (PST)
From: "=?UTF-8?q?=C5=81ukasz=20Bartosik?=" <ukaszb@chromium.org>
X-Google-Original-From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@google.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v1] xhci: dbgtty: fix device unregister
Date: Fri, 14 Nov 2025 15:01:47 +0000
Message-ID: <20251114150147.584150-1-ukaszb@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

When DbC is disconnected then xhci_dbc_tty_unregister_device()
is called. However if there is any user space process blocked
on write to DbC terminal device then it will never be signalled
and thus stay blocked indifinitely.

This fix adds a tty_hangup() call in xhci_dbc_tty_unregister_device().
The tty_hangup() wakes up any blocked writers and causes subsequent
write attempts to DbC terminal device to fail.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 drivers/usb/host/xhci-dbgtty.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d894081d8d15..6ea31af576c7 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -535,6 +535,13 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	if (port->port.tty)
+		tty_hangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
-- 
2.52.0.rc1.455.g30608eb744-goog


