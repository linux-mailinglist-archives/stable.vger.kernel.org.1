Return-Path: <stable+bounces-253889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNzfAPM1EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:06:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8B5BD302
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 647FE3021640
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30343101C0;
	Sat, 23 May 2026 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUDmJlwP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A288312837
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512804; cv=none; b=i6fYlSsJoBtoN4GCR3K3OzskOHxWflhzTDbvBz/9qusY4knDWatPiITnQh4zBcwxrW+geAIkRcCvgeazcIHX+R8xEpEQvmlS7txB9j1JQJJrUNl8N4BnGduvCWIAIZAdjkYd491i4qmqbVZGo56wdTUB9fPz8PVhz7imTyJPVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512804; c=relaxed/simple;
	bh=Shgi5jElQdfBIcR6Rb8wt7MvaQ1F9hHKWfstV1Edmk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjCeaUm4KFke0i6UUBaCIcZziKmKDVraoZmib7cixftvIGJuYyORaUMfelpRR4g0nv6kCx0ZDg/Hthx5l4qaw9ywDcHrDHzQZh7fX4L/wE2Y9lcsVfHaD7VNOlL2/ERSVOvCN9LWmN1U7F8lvK1tu8QRcZUFSzOsCIl4gFY6crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUDmJlwP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0ad52830cso10363293eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512802; x=1780117602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJRSgIm5PQp/1IbzKWdJwM1Izu6wojlwAOub5x9zwME=;
        b=KUDmJlwPsq8EcNVP9lNzpO7gjE6BbG2YOQn2Ctf6GZaQJnjlg02LkcHRufCcj1cF5I
         +wJHX3rOyppG/DRStVmP4R5xAhC6fjdq9FXZlMrN7qRb09lf5UYKIYhe5XMrKSOY9H2S
         qaemq+L+pEqfjlFzjI11gbtw52aOPCVWlL9o8xctuC179B67Li6s4Au3tfEQDxQUlaMk
         96VrcZ+CG0zfkiPFGE6tokzXu8IpCa8t3g6pC2+T3+YVwpw59GL/SF44kqa2LyE6H7Bn
         gpIId+FebuwU6O09LK1I92NvoaG4hc72YJVPNpfvykR5fU7C8CpNl3NdPX1TIcpasT2I
         u9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512802; x=1780117602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJRSgIm5PQp/1IbzKWdJwM1Izu6wojlwAOub5x9zwME=;
        b=LByivnqy91pihAvnAk5aUzyXEbOfgksaqT8M9DmjbUwHZu/uZfZ/FEf8cbvWZmwj7V
         rGMhaG1x3DkO3R09PtRa0tPQtD5g9Ow0HGUpw95rEV4IIAQqvDMcHpLaC2qRS/prZbQs
         k3ezxJxDNT1Pi/RQhc9eS+WS3yVPwo/Si0Q/178wmxMSvIx7cQtb5uH5dcWjPCTD3NKX
         lP29HNTPvPaNumcVewv5wUeQ2SUzDvqBaEG3hnbVeGOc9PIH8OGBZr8LDxOuc2iQZmJ8
         /WVcb0hk3jmuojB/cD4rhUoIUSeV0cWrgw5Sqh9JsUBvl9NWVXKMnwEL7eb76SBUY3Cu
         GlxA==
X-Forwarded-Encrypted: i=1; AFNElJ9TdGGnRN+wMZ+lRSxZ0lmwTsBS+QABexK0mf/Lw5eejWQm68ApSgjGjOfl8dSb6MwmtuavxzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCO5YAXzWqV+4Qv/KZI5UIawBMTkG7oED1nIsLu+nNbkLDR3cd
	+f6HunBTdLxGxH2DGu2UemyrGki8HID4RxfBkC4/pfR74t0NuDV1RvKc
X-Gm-Gg: Acq92OEfakZArM2wKgoSDFJ6G8wSrX+pslt1LoEzlsEdm/v8EGIU+NDkryudqqR5kmO
	2bDQ93W84lBhkURnFXAxHGjfmohrTUMYuLW/Xr44HreHQYOPRQDcpygwgHlczm7W9zVKX03hEk2
	tfDnMe1dM0tylpG3akaOQPInd2d9sXOS68omDveVVC0q/4//1vT9xHX1+HQ0vtSmDmL/IlqztUq
	SI+zt9dtuC6gZVoLwiecNLIEckeHyCvxRRjB7Yn/gc65kefqKYtEuzAE75gnYJOrFYLZTsolxFr
	C/hU/zRownyQinND3QwCyxp11AnkJRebrIsUHmbG9LWM9wnC1YibMj2N9GyKgY2YnU/uYHTZnl+
	H+s/U8DuZVWvWotVWtHg7MAkLbWx3uKEbg3Koxn58LEHw12cO1AUxMyE5GF4tIaN/HbSg857Jug
	I6o29mjcicC2FfeuK8vj5b3emzRK2vqSdFkfgb/TEE1L7pDg70/LtjeoMQjswSz1i+P0Id/+j/2
	U3n1Dj4dd+Jz+BT0PneSAL2
X-Received: by 2002:a05:7301:6704:b0:2e2:d94d:6188 with SMTP id 5a478bee46e88-3044904e1e6mr3083881eec.7.1779512802332;
        Fri, 22 May 2026 22:06:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:41 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 03/11] Input: ims-pcu - fix type confusion in CDC union descriptor parsing
Date: Fri, 22 May 2026 22:06:21 -0700
Message-ID: <20260523050634.501509-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91C8B5BD302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver currently trusts the bMasterInterface0 from the CDC union
descriptor without verifying that it matches the interface being
probed. This could lead to the driver overwriting the private data of
another interface.

Validate that the control interface found in the descriptor is indeed
the one we are probing.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index d0934d577b5e..a134483e543b 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1693,7 +1693,7 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 
 	pcu->ctrl_intf = usb_ifnum_to_if(pcu->udev,
 					 union_desc->bMasterInterface0);
-	if (!pcu->ctrl_intf)
+	if (pcu->ctrl_intf != intf)
 		return -EINVAL;
 
 	alt = pcu->ctrl_intf->cur_altsetting;
-- 
2.54.0.746.g67dd491aae-goog


