Return-Path: <stable+bounces-206061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD622CFB661
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA2D3021059
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C82FD685;
	Tue,  6 Jan 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBjqIdvB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883F2D321B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743953; cv=none; b=swKr/mLhpgETCHI0m+tfjGyAu1nOa/YyfpAyltO8zrx/Qa4E3XSj8fv/vvv/bEOaUFaVSzXpWTs2Uu5sGIavXFCQdLQuGQZLGo2WmNgIJe+Nrj6gUBiGBpejlfTFx6YSWeNdENdSNidTR7V6A6VZpyB/04e/91MYUnQubdflMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743953; c=relaxed/simple;
	bh=Qk4B1BQlCWLjCwn1qd7LA87Fg8Y70vCSqNKFz0DcYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U601GSyi6yrD7Q/guldMlI+9NlICKpANkGb8aMWSIpGzcRFk4Nn9euxTRfwqDOyaRY49SudHiI/dti9RDf4vb6yEyflffSpHdU6X5ZMecezOQlc74SB+ppIDVRvhowwvQrchka3rysfmKLCDMDKHLGg8o06BwsjyDPROetCx1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SBjqIdvB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7a02592efaso248907166b.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767743949; x=1768348749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT1w68RGwKrDDZHtEQnhlyASoBy2XlIjZ9waRP+OZtA=;
        b=SBjqIdvB7fzsZrFBJLYeGluq2bkHnp7b3k8ClARtfWm3/QsCB1uxfzyd4eMM9YPt7r
         9WXlh5EnDdDr4E7pnZJMkTrdNZEZy2neUDceFLGDXZatFXgY3qYv9rBCs4oZfE0qjy6s
         84iLQ77M15vKHd5D0zrejWL0OMwq6FgcOM6/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767743949; x=1768348749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uT1w68RGwKrDDZHtEQnhlyASoBy2XlIjZ9waRP+OZtA=;
        b=kWhGeO0xzJ/48il1KjfYabvSQ3WnO4FlrRg8UW6kP7DtQ6p9yuFT+NW9cfQZYRxRcm
         gsWDL/q51A4vs/bmcwsl45kpBIGEGg0Zex+D1xCYnzMnMcqWwc2727ZhuFp6IVoX9POy
         /Pl/7cXiRwmTGmFkU3DJdUO3PP/KFZLe9YqPcWFeENMETIK6aW3EDiLV4uwqLMF4l0vd
         0GauiT5nyWpuT7ysqRX1V+kLuTeqMtY/A+e3XbctKHCn9QbaeZa7cXUoX/6pE5JjUtvL
         CcJV+bkkhCZBjuL+ozEAdLx8mDBHoiyPRSWX6L4ku0frN71yxkNvkKPlXpMw7iNt1EAt
         V0hw==
X-Gm-Message-State: AOJu0YxnFMJWda3b1qHaQ+JZ8ayWW/7RhjupNhXjUvlNg2zLJP6dN0ta
	OS4yuahWdJvwmiGvN6ZlLgegTUU3eXmz4/co//DaJSBxkCxP5rPW3QNdnVjyfys7JXLIJJccpFi
	DJ+LngO8=
X-Gm-Gg: AY/fxX5BPUxd6afqbJin9kO9iTFpyzPv7s2LdvhRaRWgxlWCMdd4BcozDKuFuaMm3rX
	3FM72SjF2dUnQLvZya6yD7Nu7x3ili99KrN/HYcJCx6NDf1m4LnIbS1IIzxhwfqDRKx3ep8TrDB
	w20oxtw29pPOyLihCKt8xaqqturyffzWKlsbMirfxqW2Ps+9Jd2lZZWnuFp/G3LOsEzVIiAvtyA
	zcKIKo1hVPK+noRH4Vn81sRHFS0ammUN75KdpzjZYLgp/JChuKZoyESHwAh8fxGflXcte4sctS8
	sB7mjlf6SZE1lXNvkbv3UaG4QfPRy+cUw+fE67LEVo6yq+GC7mJOXGlJQl7+X0Bu/llwRTgIwX8
	nnLnIU7+DPOfeGoHyJr4/SFFjudcw2QlgGR/tsPkuHnq/BIXaCnD+7LdsuBoIgg8hRoe5AoLaxS
	foV+KnlIHAaCOFY0NvwnEBghq8+kUrvcWVuhQfTXYlcepJmOVSfORpdKBy9flH6OorZkNFduHNT
	w==
X-Google-Smtp-Source: AGHT+IHAr53+MtuRfVModHU2JVKDHnuHdj0K2pgH0bHOHvYvnl7Y02fkmfnzqT5vgPM6LM7DW6+snA==
X-Received: by 2002:a17:907:3fa4:b0:b71:1420:334b with SMTP id a640c23a62f3a-b8444c40046mr80579566b.8.1767743949289;
        Tue, 06 Jan 2026 15:59:09 -0800 (PST)
Received: from januszek.c.googlers.com.com (3.23.91.34.bc.googleusercontent.com. [34.91.23.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a511546sm344187266b.48.2026.01.06.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:59:08 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] xhci: dbgtty: fix device unregister: fixup
Date: Tue,  6 Jan 2026 23:58:20 +0000
Message-ID: <20260106235820.2995848-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <2025122917-unsheathe-breeder-0ac2@gregkh>
References: <2025122917-unsheathe-breeder-0ac2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixup replaces tty_vhangup() call with call to
tty_port_tty_vhangup(). Both calls hangup tty device
synchronously however tty_port_tty_vhangup() increases
reference count during the hangup operation using
scoped_guard(tty_port_tty).

Cc: stable <stable@kernel.org>
Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 349931a80cc8..9cbeae487736 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -515,6 +515,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 {
 	struct dbc_port		*port = dbc_to_port(dbc);
+	struct tty_struct	*tty;
 
 	if (!port->registered)
 		return;
@@ -522,7 +523,11 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty = tty_port_tty_get(&port->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
-- 
2.52.0.351.gbe84eed79e-goog


