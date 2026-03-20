Return-Path: <stable+bounces-227484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEAeLPALvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3E2D7981
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4A030C624E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E037474A;
	Fri, 20 Mar 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+czy6SV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00925364935
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996919; cv=none; b=F2LLxkk1NJMORU2mDY+RU2iJrhBse3YiGl8F8elvTKZZ5J8xVNGpuu8DevUpH/D3GxAt44TjC2aEQ8HygflBqSElmA4LWiGhC4By6ni4iL/OXGQh58nWGpETdzlrw118B8OxEc1s9RJ4OaQzX7aqWKItpT5te4YDtKrhtimLEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996919; c=relaxed/simple;
	bh=BY9lnxzfVx13xGxc8xg0J0BlIkyPA3gqsCtoN6f5dtg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GCO0qNUBotPSj1wHIevDA3XFGjxlJivfBuvNejB2pN/X9ijJujj9j30MKanz4fjMjI6PkyLFWaxny1YiaWiNOhv8kGwjttDiWfIi4CObUXYQbQltwmQY+E1pqaUebrydrTKBxWYLE3Tf5Iqc/J9SL0CFHcy9GaLpPyaJZdlzR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+czy6SV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aecfe69196so18006485ad.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996917; x=1774601717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wOrXz3SlvRF4SPOq8TigP9z9rmhnBKdAlY+CRijedw=;
        b=Q+czy6SV8K0oMXuzKC7hQbvcrT0XaT5ldIAdeExj2JTW787g2gNutVCULjW9ifV1dq
         WwnMX532jfOXafHNzMTPWrUcxKCPiy27AlXyDGi4+AYm5tPzRM0qCXH73O/wU9nkqWDB
         pzwSqnas8MvWYUso9lVaWvcXLUVr2u5XelUbIBg9cFp13TmkSAsZ9SvzgbTg5mK+MSzJ
         GyupdFPp1/kQyXmo0LREQ10NGmdM6/XoOVa1ZAc3kZt4iHeX1iQTw/Uu0SBIFVa3k2Ju
         fwAm37nu0VTr9dbXj3avc3m+xZb1D9ZYPKy5P+xVrZ0M5OE5m5jXNo6dAom8WEOn4zgh
         epgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996917; x=1774601717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wOrXz3SlvRF4SPOq8TigP9z9rmhnBKdAlY+CRijedw=;
        b=suiYfr2fzcEea3LXQqwQlaxWqYWXVCc2K1NKxewjomVGhvJF2C0XWSxO26+UWym5yk
         ms4jaXgZHc/ReDVssZaF3GLwkn2g/8yw7eCj+0aWpw1hGNRvupWaeZFkwwCTrtxmErVa
         6x2PRSTI7a5wLUjIIUWOPPx+W5cggmPC/FnNeYSLj6XD9364oDjvXUMzS/Sl1zaLmBy4
         QS8NOhL9bC05aWDwCrARNR3ezO2JzrnQ/cKpoHDTXUG/HluJTfH9qHuGpeIFcse/63kx
         EtyEG0ZFli+hE9WTblO98Tva1TlK8uFSsp5TICTTpgdb/03POOs3hwFRtWtJIqemRfAl
         Krzw==
X-Forwarded-Encrypted: i=1; AJvYcCUvBJKeVS2fAv0Qu3HkUYhnnaND8bhIU4RusZypEq1XIgDmXWaKGGgZ7F7CrR60bqEp1OTPe0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5pj6xzWHL3qL9okvXr+hjKYDV5nDilPWowvtddm6tWu9LfoA
	nvJTJPIiBjIatCGELh1FCi6Yjg9YRZ/j+dRPhkNLm1SQgccaxrE++kzUgbQN3QODt/dEsNQWa/a
	+1qO8xg==
X-Received: from plgx7.prod.google.com ([2002:a17:902:ec87:b0:2ae:4060:2b13])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4d:b0:2b0:5661:e118
 with SMTP id d9443c01a7336-2b0827e4556mr25854955ad.53.1773996917236; Fri, 20
 Mar 2026 01:55:17 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFMLvWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMD3dLiJN281BLdnMy01OTK5JxU3eQUU0tDwxTzVANDYyWgvoKi1LT MCrCZ0bG1tQAjVsNpYwAAAA==
X-Change-Id: 20260320-usb-net-lifecycle-cd5911d7e013
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=3220;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=BY9lnxzfVx13xGxc8xg0J0BlIkyPA3gqsCtoN6f5dtg=; b=VUaD9d/P+9nRlvzflRF8h1uPbQ/Ee4AffIFdBQ503s3nYa2SSoQHASIna98VOiscLLgp9k5Ak
 Dcc3SijJiBCD47+jei07ZJfiu83+aqng/aMTDdQyXS7sqrqjUpowBKn
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Subject: [PATCH 0/7] usb: gadget: Fix net_device lifecycles and configfs races
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Felipe Balbi <balbi@kernel.org>, David Lechner <david@lechnology.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227484-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30E3E2D7981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This patch series addresses dangling sysfs symlink issues across the
remaining USB gadget network functions (f_ecm, f_eem, f_subset, and
f_rndis). It also includes configfs concurrency and reference-counting
bug fixes identified during the investigation.

Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle
with device_move") introduced an architectural fix for f_ncm to resolve
an issue where unbinding the function resulted in the net_device
surviving the destruction of its gadget parent device. This lifecycle
mismatch leaves dangling sysfs symlinks:

  console:/ # ls -l /sys/class/net/usb0
  lrwxrwxrwx ... /sys/class/net/usb0 ->
  /sys/devices/platform/.../gadget.0/net/usb0
  console:/ # ls -l /sys/devices/platform/.../gadget.0/net/usb0
  ls: .../gadget.0/net/usb0: No such file or directory

This series applies the same device_move() pattern to the rest of the
USB network functions. Temporarily moving the net_device to
/sys/devices/virtual during unbind, and re-parenting it back to the new
gadget device during bind, restores proper sysfs topology without
leaking references or breaking legacy composite drivers (like multi.c).

To ensure safe teardown and avoid regressing legacy composite drivers
that manually pre-register net_devices, the bound and borrowed_net
flags now strictly indicate if the device was shared and
pre-registered during the legacy driver's bind phase.

Patch Summary:
- Patches 1-2: Fix an unbalanced reference count in f_subset and add a
  missing configfs mutex lock for RNDIS options.
- Patch 3: Add comprehensive kernel-doc descriptions for struct
  f_ncm_opts to match the standard applied to the other functions.
- Patches 4-7: Implement the device_move() lifecycle fix consistently
  across f_ecm, f_eem, f_subset, and f_rndis.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
Kuen-Han Tsai (7):
      usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
      usb: gadget: f_rndis: Protect RNDIS options with mutex
      usb: gadget: u_ncm: Add kernel-doc comments for struct f_ncm_opts
      usb: gadget: f_ecm: Fix net_device lifecycle with device_move
      usb: gadget: f_eem: Fix net_device lifecycle with device_move
      usb: gadget: f_subset: Fix net_device lifecycle with device_move
      usb: gadget: f_rndis: Fix net_device lifecycle with device_move

 drivers/usb/gadget/function/f_ecm.c    | 37 +++++++++++++-------
 drivers/usb/gadget/function/f_eem.c    | 59 ++++++++++++++++---------------
 drivers/usb/gadget/function/f_rndis.c  | 51 ++++++++++++++++-----------
 drivers/usb/gadget/function/f_subset.c | 63 +++++++++++++++++++---------------
 drivers/usb/gadget/function/u_ecm.h    | 21 ++++++++----
 drivers/usb/gadget/function/u_eem.h    | 21 ++++++++----
 drivers/usb/gadget/function/u_gether.h | 22 ++++++++----
 drivers/usb/gadget/function/u_ncm.h    | 21 ++++++++----
 drivers/usb/gadget/function/u_rndis.h  | 31 ++++++++++++-----
 9 files changed, 204 insertions(+), 122 deletions(-)
---
base-commit: f50200dd44125e445a6164e88c217472fa79cdbc
change-id: 20260320-usb-net-lifecycle-cd5911d7e013

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


