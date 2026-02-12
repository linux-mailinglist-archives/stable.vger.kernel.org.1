Return-Path: <stable+bounces-215917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMbVHC2EjWmQ3gAAu9opvQ
	(envelope-from <stable+bounces-215917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:41:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C4312AFCC
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 155B4309EB91
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAE28D8DA;
	Thu, 12 Feb 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="hFdRZU53"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253E28F5
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882089; cv=none; b=PboEc4eDdlEy+vilW3XDY3eBzTq/TT1ysnMDc6OTGUf8fTEXfWzp0PYOCrcg2epwtFJ8toaQ6nhTz9MuWTaPKks0syg7vkeikSDSA7OdmKsZonwi4Kn0Y78OkGC0ouv23UCFjaiHJUXS7eOPDI0GD+8tfhrC5d120BcJznaNqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882089; c=relaxed/simple;
	bh=Bybq6YVBkqHEowrDi0KJ1icafdlKDBEW945WLREiWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpMKm9iv5Rcfig+fz6dU/vBc9adTAYUCjsxGOskknVuaR5gNZ7XgEz4jDvMVP+FHKZvgWeXhNu2HxCX6sLTL+y1n+gcEOlPi2rJgNMydWbzsAiU9CbdIHzYek0wx0j/ybGAtVE6SWsQqRC3+O6Fx4aUCF8CllYn0ZUxz0v8oLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=hFdRZU53; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48069a48629so68210865e9.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 23:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770882085; x=1771486885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dcSnhEINyICNkHx9eepePnYVOOlEAglwp8cHbM0S0Y=;
        b=hFdRZU53ovu9sdBUVPauU1F77o+Jawo+F1y+KUwpFhjQ5VJb9RfqEni/RQYCiNaRyr
         97yuBzwsZgxWMmsXve8zD0NCtBiproGkYBKGx0kaPz8Mn2hYbxI2F9jvb8fKBZfPbIli
         mUvq60AiC4YbzSfEJk8EHGWykTmwan12D0IeWyRIICuTZdAcBw3RNsocN7wKeZh1uEa/
         BwmfTLYYFIZnKlCvfdJmHhVzANFbb1LhxJKOauD82x0UpmKkOEEfdbuz0bN002EoDaKK
         SMVITj8qXk9oR8bIm03/wlqj9uRGq52/4NwHT4RKjh9n7Wa5DeSylqEqfgkTEdy2sGEe
         R8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770882085; x=1771486885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dcSnhEINyICNkHx9eepePnYVOOlEAglwp8cHbM0S0Y=;
        b=wFFndvoi/qBAmrhYT1BJQ4KkqZ+lalzfV4ikuAcZRtrEhyccJB0q+k78F0V6BSEO6i
         GIhQVgeWhK44KM0YOjEoMyL2DkVcZelpqGcHKqB5AdXkZ8gj4DeAl59MTGDI61BnczJP
         H5lDjWCzXxQQfr0u1Jw8chPDNK1xYhnXmJIWbKsMpySR76Z+s0e81c29pMq7jVjUlztG
         xEVvL71/bBn69fX8NhD6Fazl+c0nX+kHq7ePMC8BRAcKjoUQWlZ6aNZ9TifYOWRWFl6V
         QUOxU2yNj5rviSkSlpf0+GgCByodyPX1a9xYTPs2kgMQp9v5N5eqpldVFV8FMFBZ5Xuz
         2bMA==
X-Gm-Message-State: AOJu0Yw9fYRV7D01Rz6Mz4x6e5dB0WDfGAV3dB+j8CagTNU9S7oFQ7Y3
	FS5I4gXypuLQZLxB3LqoMDdHE3mf/4AUd9VrTV8mYp460Q5N5C5zRkiQ2/yq+Gi9FIwXV1jrbgb
	rQ0HPFu8=
X-Gm-Gg: AZuq6aJFxKW7CjwHKYgFzcTmCKxgNfRpmLSmS5WZlA2wmqgITPaEdsUKPBahEWJCgeF
	PY3S/jYgdcOaykRv9pPxU7s1WkauU16Ta2lELy03gmM9cOBDI1DGM+hKZ5FdlW8++NhWMI4j+dr
	K6Rq1ZRA/vtKKnKlkdALLhu5i303JNXdxkIAQXgyL8vcQ5kYUEGL2Zmh4ZlJfyMkpBhdg26Wp2p
	ZIsQ15+52NuDzOcYIdDjsJnd40wpIX7pag/tQoSvIm+vWh3+b6DKCQcrYA7/6GDM6imGZAQhbWt
	j/KuudtTXkCoMAqlWyUCr9RO+7Y3gvndqiJPyK6NHIZCsRLSvNrn/HCmweRTv44CqSbZCFeZz+P
	jyhfjKjmGEI8IwVsyjwMt1jLBSW+1RytAoTLqCajq6r0WTgfQkIvJMtt37gt1Lh/9fsIEo5qKAw
	XlsPvJmC8zwiL4EuW3I4OB69F+SCZs
X-Received: by 2002:a05:600c:3147:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-483656094dfmr23961805e9.0.1770882085434;
        Wed, 11 Feb 2026 23:41:25 -0800 (PST)
Received: from localhost ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm190614435e9.3.2026.02.11.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:41:25 -0800 (PST)
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix CIS host feature condition
Date: Thu, 12 Feb 2026 08:41:11 +0100
Message-ID: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[codecoup.pl:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215917-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[codecoup.pl: no valid DMARC record];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mariusz.skamra@codecoup.pl,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[codecoup.pl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9C4312AFCC
X-Rspamd-Action: no action

This fixes the condition for sending the LE Set Host Feature command.
The command is sent to indicate host support for Connected Isochronous
Streams in this case. It has been observed that the system could not
initialize BIS-only capable controllers because the controllers do not
support the command.

As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
supported if CIS Central or CIS Peripheral is supported; otherwise,
the command is optional.

Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a9..0b0dc0965f5a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
 	int err;
 
-	if (iso_capable(hdev)) {
+	if (cis_capable(hdev)) {
 		/* Connected Isochronous Channels (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 32,
 						   (iso_enabled(hdev) ? 0x01 :
-- 
2.53.0


