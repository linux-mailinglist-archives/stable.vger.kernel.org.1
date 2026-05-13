Return-Path: <stable+bounces-246818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFeMDGJlBGo0IAIAu9opvQ
	(envelope-from <stable+bounces-246818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BAB53285C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFD930891D7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450103FE66F;
	Wed, 13 May 2026 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2qtdvvC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5A3FE651
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672969; cv=none; b=Co76imsSDeLA5c93NcPI32sZ/sX17maIFQtXH46DiaR98t0qwo1F9wZQb4b4z8XLSDIT/AgPucvz9x5G7x9Jxqrd9QdjZ+jr2Dj3UFsXeI58e4mPk0D1NJwAgmtTbSiCRrTGyeegzqwcFnPOJyC4sAkIy6WZznGdYeKp1zHVhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672969; c=relaxed/simple;
	bh=vAkIGiYGK0mFnoutUqEZ5X0x7hZrx15F5vAL3EW+k0s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hAt74EalMGPNydXiN6eg0KMxh3Rla44YT0tcZcK6ggU7EUeOkDHo4fSAmUNiwdzYP2q1piDiPMbvq4pHfzZH/cYbYHXKyGTCwol2e0YbR+BtkOgn5cib7dFgaLGrFUlpJFEqJuCinyLx1dUIMNDE+uPsOndXOvMDOsn3oV8K+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X2qtdvvC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so3299300e87.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778672966; x=1779277766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZx1iG1yjmYPW5Dnpv606Gq0MMu0AwR5t3vdLHWN1uc=;
        b=X2qtdvvCqTc23BvBSXigJc12d5tGg02oa3tTZ2OB1h2zAAv8gqx7XCN8SAsEUlJ7yu
         11kZKgSO+PsVYsKgHbujFfW/Ma3FWHOqCgZOSrZvtzRIVKd5o3SHXYT9IQXHrFXZEQaI
         3um3cXc9l+W126syS7dxHobn3azqq3nwlosPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672966; x=1779277766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZx1iG1yjmYPW5Dnpv606Gq0MMu0AwR5t3vdLHWN1uc=;
        b=eK8QO5Y21uZ9mmEM093RI6O/vYw96U59VF25Xun3b2zAhc8s48AaNxh6YXrxhUitN+
         U7J3ClsVyW4eO6jC8rfYxPGA7v6DO+S2OzlzL7htsTtKrlw7uYTJd3HPEmvPZSitnExt
         cLGHbWRZkEThOvJdXfSNP1ZMWR0fZBXO2uGDcwf9E8clSWUzI7ri0PuzYO2vCN+UDyya
         JBZo35lsWuE5mz7TWV18vAy2hMqWNsHRPCXbTG21xt28wVsv3ZRng40beG0/7r7p+WEy
         fXxBuNekuwHoozdO7PpgXCj26BGqn8iQTKM47hinsBJSvXe3PgLR63klLbb+ZALbx9P9
         3ivw==
X-Forwarded-Encrypted: i=1; AFNElJ+oILdq93brq8lFkrEW18CJv42Qv+TsDhXqeIL25wJsinkvysCC5E/8sjkUCj9YCYbRrFC2HUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8a8S55biTe9arE1PqRbQfGmWEbb3H3rbG5PdegDYfoEp8Q2X
	OoAQ9dwzAZipcE3jt7/1GV6U1SNcIuAgKMgQFzfTMHoX1s1+IntXjU1ROBbu4tXJPg==
X-Gm-Gg: Acq92OHDpTCOt2uTt7tlksSw63J4HQtBl0lqeIglBgXFnNrwQZLpA+kQTWosvpeVMJg
	Z8gXu106aQqSGQNJttQJekIbKnjr704wiCy3tGkGnFfbL7LGFNaxyhuXrQNqHeAxTptek69SglE
	fK86rKmL72rHUJkCJpUo/F6Lym3hOvcW6I7FUnCOLTWPIx3Tuy2leE+fYidknu/S58VXckE19Xo
	oGY+aDlKN8zkOA6vw7+nFYAQB2JGLBDQNT5T2ve/fzM/sld+kJ2AObFIPjbqKS+TltxoCjP5im+
	xXDEA3aWYNblQ3mTw+rUE0pUpgBDYkTAyYG/9bqYQlB/4/dEueNQPSdqGktR64F0nH4eTOIyfBb
	CE9u4+1Fw1/QHiRGqS/pnX1ZiPDjA8UtPih5mee5OGCVtn2Qt1EPlpjy/242gydlpn06t9u71zp
	xzx/asm+ZGOCa8OFsQExwS5V/Ob/s4elZ9+Ev+dHp+jM+vSG7AHqFRHeiFUZMsIYYVsw4Ax0PYz
	w==
X-Received: by 2002:a05:6512:68e:b0:5a8:6e82:6845 with SMTP id 2adb3069b0e04-5a8e0f353ebmr2903738e87.22.1778672965627;
        Wed, 13 May 2026 04:49:25 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm40971071fa.27.2026.05.13.04.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:49:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/6] media: uvcvideo: Fixes for hw timestamping
Date: Wed, 13 May 2026 11:49:19 +0000
Message-Id: <20260513-uvc-hwtimestamp-v3-0-7a64838b0b02@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9lBGoC/2XNQQ6DIBCF4asY1qWBQbR21Xs0XSCizAI1oLSN8
 e5F06RJXf4vmW8WEoxHE8g1W4g3EQMOfQpxyoi2qu8MxSY1AQYFE6yic9TUPid0JkzKjbQF2Wg
 oW1lyTtLV6E2Lr128P1JbDNPg3/uDyLf1a4E4WJFTRpXKwYhLIYHlN2394HB258F3ZOMi/AjJ4
 UhAIoSGikldClHXf8S6rh9BTRr/9AAAAA==
X-Change-ID: 20260309-uvc-hwtimestamp-f25dc27f5711
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: A5BAB53285C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246818-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,chromium.org:mid,chromium.org:dkim]
X-Rspamd-Action: no action

This series introduces fixes for the hardware timestamp calculations.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Improve the sof_diff function logic.
- Split "Do not run expensive code if not needed" patchset in two
- Link to v2: https://lore.kernel.org/r/20260512-uvc-hwtimestamp-v2-0-3c2905c733bb@chromium.org

Changes in v2:
- Fix comments
- Add UCV_ prefix
- Improve commit messages
- Add "Do not run expensive code if not needed" patchset
- Link to v1: https://lore.kernel.org/r/20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Fix dev_sof filtering in hw timestamp
      media: uvcvideo: Use hw timestaming if the clock buffer is full
      media: uvcvideo: Relax the constrains for interpolating the hw clock
      media: uvcvideo: Do not add clock samples with small sof delta
      media: uvcvideo: Do not add samples if dev_sof has not changed
      media: uvcvideo: Only do uvc_video_get_time() if needed

 drivers/media/usb/uvc/uvc_video.c | 72 ++++++++++++++++++++++++++++-----------
 drivers/media/usb/uvc/uvcvideo.h  |  3 +-
 2 files changed, 54 insertions(+), 21 deletions(-)
---
base-commit: 10f943b12e7cb338da00f10e129043ae27b33af4
change-id: 20260309-uvc-hwtimestamp-f25dc27f5711

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


