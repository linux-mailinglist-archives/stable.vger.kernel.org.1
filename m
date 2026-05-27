Return-Path: <stable+bounces-254614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCoqNmAKF2pB2AcAu9opvQ
	(envelope-from <stable+bounces-254614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D85E6A91
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0206F307B262
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9A0425CF7;
	Wed, 27 May 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgOZl3Y2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2083D646C
	for <stable@vger.kernel.org>; Wed, 27 May 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894521; cv=none; b=Dn2yDnOmpvFpiV6FPOJMTcpfSZjNKTjqITo88pc5Gf0i3wLP8DvSO442Jq+VFp5MB7w0popWJf1oXoQk2a8YsVfey+g/8ZqlGQfFB/6Mot0Nh/O9+nFUgHV5t1K5MjAlnAIgHzpTVUSEL+HcZ3L50cDJZhvmlnRcjA4Hqd+dwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894521; c=relaxed/simple;
	bh=ftJA1esdt5l+bw3g7t5Q7tLNGvcMDoD6AYCXN62BQ/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y0gHH9yNC8wO3y6VHlqepWMvny0RmyeHOepmX36GSQw6n4+uTzPRHXvlLDCn1AOqIzn7EgmXobMHauGqYdn1TEPfl4SMkigDr14gFN+F8oU+IG1ToKwfGyoRzhqAoGfhOunYG77w06VWHzloBNNMh8YLxMuE+gqSlAofsiS49lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgOZl3Y2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c801912c903so5256814a12.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779894519; x=1780499319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDJ8S5hbiqIsI65l369Il1cSJ90Nc3vvPmKDZOmRp7I=;
        b=sgOZl3Y24iuxBKWB2wwnZfzKq4WsTClNd1KQWZOxIFwyyWwfjYwHl4QzCrIkgsoBxM
         SByojtrQS+FSLZQPVAfPcHZCUHuAcNlrQJ8cWlMzrKMdr4fB5ROQsz4R9MzGDEIBHaJp
         HLYBpK0BowH868NVRPQv/zNtn5lFFUFeaQIzNzeVksf1ImYcoM783wMrCEuMA5X0774F
         lw1NA58Wug8jFRN5xks74FSXKGRxi8wqwxREgTFB7M95STFTeopgbVPj8F2EspTmGcxW
         PFM2M6W1VbL+fnG8oZfIhxZHe3ag8xbsoU2U46V4M8IJqIvf2DMykaUQl5FWwkTIF4tt
         Ippg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894519; x=1780499319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDJ8S5hbiqIsI65l369Il1cSJ90Nc3vvPmKDZOmRp7I=;
        b=HD4MfEA6mQ7FQ198QByUCUe5tYaI75ucfaetufkU/NxdQsVK+maIS8DA61Tiv9BqBM
         ZAo8IKpPTAaZtaihQgWQJdfKT3u4sI3WaL5mAJ5XhfLixVsrQdgqjyJP9MRH/VQV57uF
         i/REwbhwB0jFfDmddhE6NBXSou16fXgYzBHOhtyGhd/OyV5Gh2pguCbohh/4Ntv95Noa
         e/YWXj+ThVqsgpQ8HLMNEOPpyBRhHkSfHpMPQgDZjZVWYwp+4KwfV1Ytm5cx06CPZobt
         wuXnPIssrndZbae3+EOa5DT7qut9PLaswNqyfWH8kOCmjFbMXQfJwOE6rsIW70nb0QnM
         DKvw==
X-Forwarded-Encrypted: i=1; AFNElJ9MUD2xHAPlfSS0lwmhBy4GAeNVJisvEQ7XEenJzrv8pqP1W1dyr9l20cOW3XJNhhhoOfv0a9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPtghuuivX42rwCuMFI6cYUeN9ifVQtNzdYKft/Mi6KLKn5pR
	6uiRdTC+WSBBLrfyslpN2W2t/xKm8WS1KdUQ5CAT0JKFhRnmH2UUvZgA
X-Gm-Gg: Acq92OEP12eY/JhodVnF7ZVs4HiQfbV892VP3npJwolq8qBHkKi3bp4dfCO0fGmTL61
	ahienyUwSPeGIdaaxIYcE3bEPGrD37XeRw8Adsyw2BWS6I34sT382qSND3IFDgBdum0RyskrafM
	8vp5RWyy1GStomG7mQ9nBLY9Aw/fM7n61BeyK+cgEa3nBi4k+tfVUcwoLH7y20J0wmx61mvjUvs
	PpNrUmeG+8NACtSI2RfIll9/L4nTUCsslmlDG2zeUunQQsNza7xKNaFP2eouGlu5Q86Xc7VUAg9
	8jTQn4V6XxgkCP+FVMaIhHcg6hL7CCePN0teKhoTHdmBUO2266oJ09BdwAfmrDe4Q3TtBx98zGA
	brYlOleuYuvdBfO3elUx87+Sr1XsswYTHh6+quMRC0KdGqtJqzeDwJQU1AXJU3j1xOkbiJkpQok
	IYiz2NrFQ0s2TLIptB2rLCnUPKE2Jz+tptB5HcjitQwiIA0rWLJIhrX9ZTs2zqrSrZJxZ7Xw==
X-Received: by 2002:a05:6a00:3e06:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-8415f3e81a6mr20982338b3a.14.1779894519182;
        Wed, 27 May 2026 08:08:39 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d72eac34sm2874346b3a.49.2026.05.27.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:08:38 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler
Date: Wed, 27 May 2026 23:08:32 +0800
Message-Id: <20260527150832.2943293-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	TAGGED_FROM(0.00)[bounces-254614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A9D85E6A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The OTG branch of composite_setup() falls back to the first
configuration when none is selected:

	if (cdev->config)
		config = cdev->config;
	else
		config = list_first_entry(&cdev->configs,
					  struct usb_configuration, list);
	if (!config)
		goto done;
	...
	memcpy(req->buf, config->descriptors[0], value);

list_first_entry() never returns NULL. On an empty list it returns
container_of() of the list head. So the "if (!config)" check is dead.

When cdev->configs is empty, config points at the head inside struct
usb_composite_dev. config->descriptors[0] reads whatever sits at that
offset. The memcpy copies up to w_length bytes of it into the response
buffer.

cdev->configs can be empty in two cases. One is a teardown race on
gadget unbind with a control transfer in flight. The other is a driver
that sets is_otg before it adds a config. A reproducer that holds
cdev->configs empty triggers a KASAN fault in this branch.

Use list_first_entry_or_null() so the existing check does its job.

Fixes: 53e6242db8d6 ("usb: gadget: composite: add USB_DT_OTG request handling")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
This is the fix for the problem I reported on linux-usb on 2026-05-20 [1].
The full KASAN report and the reproducer are in that message.

[1] https://lore.kernel.org/linux-usb/20260519184106.2356558-1-maoyixie.tju@gmail.com/

 drivers/usb/gadget/composite.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index a902184bdf82..a5e7c6495949 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1863,9 +1863,10 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				if (cdev->config)
 					config = cdev->config;
 				else
-					config = list_first_entry(
+					config = list_first_entry_or_null(
 							&cdev->configs,
-						struct usb_configuration, list);
+							struct usb_configuration,
+							list);
 				if (!config)
 					goto done;
 
-- 
2.34.1


