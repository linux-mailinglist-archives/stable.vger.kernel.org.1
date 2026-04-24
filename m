Return-Path: <stable+bounces-241011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA72Hkem62mrPwAAu9opvQ
	(envelope-from <stable+bounces-241011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF19461D3A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3034A30581A5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316C3D170D;
	Fri, 24 Apr 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHduZfUT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96F3D647C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050457; cv=none; b=ZJdWgL9JUXOnaUS146RLtJofW6GVdhN2KRFHBmPtjdw2s431o7hIxnqTbXa2i1U8I267atOOEYFlbaNAJVP0Br03hTwKH76wC5Wgqo/SPV9IZiq/U5Y3CGFb0qnCKg52aEcTpdsjWmkMp6kJA/4gCpbTHH3De5nnmO4tiL+4/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050457; c=relaxed/simple;
	bh=pRhvZ9KCVux5KCVBEBzksHbQIt+uSWHypEMOvqUP0FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0WTZabOybQjtTzM9Ef4BUWExNIwF9tfjWxP1uqV2s1ajYvPHsW/7GglZR+at+4cPWDAlmpeXceL2+qU1eVpjVrkX0J6FQ5s4oIZIztDn/6c3kp1jaXrZw/zD/1tsEOs/iP9nXh4vmcvc33gIkuMcwsD338ZoRk+Kh+zeaYveco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHduZfUT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso3744403b3a.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050456; x=1777655256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2tyqV7NYkcIHpynPQ745IDJ+MBrRCWvGF7hfjz6lJY=;
        b=UHduZfUTqRYktk12j7/s37RHPJXmK2V1sq/Zi5HfYNU+uNf7heVyvogmQs9LOBzWp3
         j25lZfPd4H1MlHFrw5i4c1PfiWHld4CaIoJYxw91D2yWF360UsArTslN9uk2MfEq5NK5
         qkLiv8wH3u+tHAj2/FcFbqVcIgE/Z6vk3qt+MTDLE44mEhrKnfe4nlPOt8psR+TGFkNP
         k+QOIQGqhv6dFFb+AQavt47PJiuAXg2ue02oVPbMWXiYbUnANwCsp6GMntcZ5Jx3XSbX
         ZtVSFrdEo7SnvSYx32Q7KAVOGspvt4T0H3rtuB81TEVBbo9T1UpxM3mn6LNLafAFoCuN
         6x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050456; x=1777655256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2tyqV7NYkcIHpynPQ745IDJ+MBrRCWvGF7hfjz6lJY=;
        b=PsUK/fmpkn/xK7VU2645cPqWdz68L5PnGkd4Eg6V0ite9tVAYVDMtw9UeGBhZ03lYD
         F7CcpGcGvrJgUIiQE3vwrtfRP70/f8BDC3NnG31m3/5LP9/zQ08aWSWF7DNLTkeQ2piy
         Y0zg6pqK2RP0LGQz5nJcVhVWRIR2dc69GGge6fs7L3YqBL3xAaZGVAvgKHdxxn/nb5dT
         CUfkqQjYX6jS+P9dUNdNb9cjHZqV96pjBEXyQxfyZsJiuOw59It2EobYfLDXIwyaPbs1
         9KhigIx75zl6um6dN0+Pv0nfJsdTR1bMxnvv8zZNvFcM3l5IWgsZUedAeXvC8jFcwrBq
         lsCQ==
X-Forwarded-Encrypted: i=1; AFNElJ982+LmiCpxaJMzpEsavtLY+YSorY2rjmw6PEfOFEV8SQRyNd2+9auuvQBC0HWGD8chww1Gylg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEWxTL/lTTnHPnqzzMngkVVgT2wc2fJX016pN0VqBfD9shHjb
	Fyq37NwoRaNtIO7DJAGeuNLY2JMExhC9kZ/C9jnFcUqXY+aZIcIYkr8=
X-Gm-Gg: AeBDietL/R3XMwTbwFBb5WSsIOgqOCOTAhbYZQkWRvz1UG4iW9RPa7T4sndfkKKAaMo
	gQI3JDAoMmZZaBtWXCt6+j/d1Tnj3I0K9zSHol820U8v931SvghTATrv0jAO1T00k0IGRCqS5d2
	janiP1QZ0ueRGPXFnahuU9DYmdI8KQ+Bb48LgHtCO0ktNLXMz821Bc9at06zFGOJEN7rMVvvOfm
	4hdQCf2w5VpIs0ovVEdEwGnS4IeIbgtPTdBBje86P0HA9Fa7h0aD50b6ILQGg96DX/5KsZ+TnL1
	3EsQobjOFs98ZBGD1F4PwByn2L/S8mxTcg6a123RpWxeSNxjRaX6yDfpGP9f3l6KytsjH1roziw
	XG2KOFpM9guh0iwYFLV5J1JCzfwroMCBvu2GiBvRt+mbtZkCVxrU0ZII0id9ybbKW4bTxA5LH/0
	hlDlyO95SECCkYyWCx/geFiBr2aly/OeDANtEHwbKC9BOuAYVjJE7NKRMN0fYIDpQXT2D7324aS
	/hFWFSS79FvSIsOIhMVlzBh/ZCkUKQJT0cSMlxZPMg96ng=
X-Received: by 2002:a05:6a00:1bc4:b0:81f:4a36:1c7c with SMTP id d2e1a72fcca58-82f8c8c5b5fmr33371276b3a.23.1777050455735;
        Fri, 24 Apr 2026 10:07:35 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm25096419b3a.31.2026.04.24.10.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 10:07:35 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: microchip: csi2dc: unregister notifier on probe failure
Date: Sat, 25 Apr 2026 02:07:16 +0900
Message-ID: <20260424-csi2dc-notifier-probe-unwind-v1-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EF19461D3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241011-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]

From: Myeonghun Pak <mhun512@gmail.com>

csi2dc_of_parse() registers the async notifier before later probe setup
steps can fail. Those probe error paths currently only clean up notifier
resources, leaving the registered notifier on the V4L2 async notifier list
because .remove() is not called after a failed probe.

Unregister the notifier before cleaning it up on probe failure, mirroring
the successful remove path.

Fixes: 2de0b3c0f678 ("media: atmel: introduce microchip csi2dc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/microchip/microchip-csi2dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/microchip/microchip-csi2dc.c b/drivers/media/platform/microchip/microchip-csi2dc.c
index 70303a0b69..59574258ab 100644
--- a/drivers/media/platform/microchip/microchip-csi2dc.c
+++ b/drivers/media/platform/microchip/microchip-csi2dc.c
@@ -736,6 +736,7 @@ static int csi2dc_probe(struct platform_device *pdev)
 	return 0;
 
 csi2dc_probe_cleanup_notifier:
+	v4l2_async_nf_unregister(&csi2dc->notifier);
 	v4l2_async_nf_cleanup(&csi2dc->notifier);
 csi2dc_probe_cleanup_entity:
 	media_entity_cleanup(&csi2dc->csi2dc_sd.entity);
-- 
2.50.1

