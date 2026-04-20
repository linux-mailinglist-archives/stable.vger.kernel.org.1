Return-Path: <stable+bounces-238680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJErMoOT5WnqlgEAu9opvQ
	(envelope-from <stable+bounces-238680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:46:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED8426624
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA9423003807
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145D37E309;
	Mon, 20 Apr 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5O8dowY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BB2AF1D
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653180; cv=none; b=mhaGmMkgPq2P4XjGBbHkL8yKQJLSZ3kU3TIZUGepYU4358abIrpOd6PgnqRSe6CU3z+HYHhPFlUbjeEYAYxkispf9jVxCX+A0i965iN2ENyBgc4JMRIbmXRzXr2ziJXiD/noI/moHyXuWsjZp37EeZSAhOJjkb5/u7jUrSHin5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653180; c=relaxed/simple;
	bh=bJZWL3XjU16A/mMj9ogl96Ckj2uQqXsZktpSDcOhYzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axt83sW8zvLZyDkROGNrRAu/o/SCBb3QqGOFjbI+3TQle8+3yMUK1bm9xmVkH+ZJTcfn10Sl9ASyladj5OWsMHB3g/kyC0vSFkncoIn2z3DtHpZ9O/qX0IDU+MILHSe+8foO/+OZahbP/ex7JeTJJXxxfoTZCrmtytsoHl3aN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5O8dowY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1444545b3a.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776653178; x=1777257978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK7WMJJgOkD4ogsiZrKHO2rDgX1emKX8e5Nvoh140S4=;
        b=N5O8dowYKOZpUjXfE4jCBJTb0K+ZfcUrJIUN07+B+nAxz6XNVovQGqqr1grZT8tPRS
         uN043JDKc3G85BcrbDYfbTACROhd+kh1p1RogP17pn4mDd3E12E3wLwexH3OgfSfPXwl
         /H4JvdEXdfULKbZtUqPIMHyBhDaw01tGr6fOxanXqQjclDq4NXXEcMz7kz+xCQ0Wawyv
         XY1KnGOYIzirjaztPti/qKjXtRpeCvUeDTJ7Ot7qbXrvhFx0lq1sHBUlW6pycAfk8jVr
         +JZYX7m9HWo6IbMobcWgS1NM4Kw6UalFyAe5806h22JB4wb+sQAhwOQQMXMe/P0SJZBf
         a8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653178; x=1777257978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK7WMJJgOkD4ogsiZrKHO2rDgX1emKX8e5Nvoh140S4=;
        b=UARgxunufk9Pq7Bhb9lcXC6ixEbMgZCsPwAFAAy/NYfSKQGdq3mxoPSQPzahTaP7jh
         H8yPBcnMqpfCmU3niq5RXmavxXLZ7IiLb6gKvcLNvpGL3fphDQxhL1SeAiwopkcgP3se
         flywNlrwrYYnOVKb9MdBrMyfWaN6E34ka5/C11cU4o+BxFqp98pkOLjU4d9EJe7rmwFd
         WUjYnYHJID43w7lwgXqiWtjjaKW02d22NeOQ/q1RxJEm/6Ka+u/6Mj2sio18WKyit3Wv
         TACYwaoqoGGW3+fGPKXNJuW91I/0AlLxZ5wfv/gS9U140Lcz83U1917ihVo4ugbqNvx5
         9WWA==
X-Forwarded-Encrypted: i=1; AFNElJ+V5hKoUDUbwaaJ6dCS+6YPA/7mWwbCMmbCR2qABv5jilOUMP4SodWrVviRUWxPNHg2yesRB0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxMKZPtLgKPvLc0jA9i/h4tBpvw3v+m+6e1FZ1f8hcaD8C6M7
	xcN1WE/8p2XvSMmDxtMX/bvSgQzbVfg6igTC2skQGEV0xLDxBT0K6LPr
X-Gm-Gg: AeBDiesOmnrYxSdMYuHbz71tQhLZtPBdvYsebabTL6b9Lam+aosFAYQWCEvJSPJ0ND8
	1ZT/IRERliGdzwHcjozUTfhH19VEQyKqiHfJym5IH7vCbomfvIsWYJ37sMxTexOgELk5uBSi1ug
	kbroqH6DfmMTQa1D4N65CFmT86BGspzNflH2HuPPbuVz8lhfk1L/dzcx35Uqkl524YJRInWpbSw
	gAm5Wdh6lvB8BlZIMhZEquXkfcRT8I9s7Z4KqcakVlS5ksnmiMkTfbwf4w9iU9EfxXbYuhNSj2a
	myH4rf/enaaC4NVwurmDb0thuPrpX2ih60Ckg2aNMz/zTv4n1Sb8Da4yRdCtB93Lsi6yFUJooos
	MNsQnr8imhcJb//OHwyG8VK1j2a64o4gI7gIKN79p2HkoRQng+c8+4qvBrP1EuDqEXRWDUYkFHs
	0aasuCD+D8Ufc6Sv8c1p4neJ6M211+wPLOSBw=
X-Received: by 2002:aa7:8892:0:b0:82f:1f43:7190 with SMTP id d2e1a72fcca58-82f8b32160dmr10160174b3a.3.1776653178104;
        Sun, 19 Apr 2026 19:46:18 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:4566:2520:8878:87d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe41cfsm9351203b3a.43.2026.04.19.19.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:46:17 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on ERR_PTR()
Date: Mon, 20 Apr 2026 10:45:59 +0800
Message-ID: <20260420024559.114664-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238680-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6ED8426624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

imx8qxp_pxl2dpi_get_available_ep_from_port() may return ERR_PTR(-ENODEV)
or ERR_PTR(-EINVAL). imx8qxp_pxl2dpi_find_next_bridge() stores that
value in a __free(device_node) variable and then immediately checks
IS_ERR(ep).

On the error path, returning from the function triggers the cleanup
handler for __free(device_node). Since the device_node cleanup helper
only checks for NULL before calling of_node_put(), this results in
of_node_put(ERR_PTR(...)), which may lead to an invalid kobject_put()
dereference and crash the kernel.

Fix it by avoiding __free(device_node) for the endpoint pointer and
releasing it explicitly after obtaining the remote port parent.

This issue was found by a custom static analysis tool.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Fix DEFINE_FREE(device_node, ...) directly

 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 2b95777f16f6..600a6e8418bb 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -135,7 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
-DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
+DEFINE_FREE(device_node, struct device_node *, if (_T && !IS_ERR(_T)) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.43.0


