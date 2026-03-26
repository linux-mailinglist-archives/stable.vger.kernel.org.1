Return-Path: <stable+bounces-230504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEZ8GpZqxWl1+AQAu9opvQ
	(envelope-from <stable+bounces-230504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:19:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F803390F0
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D803043BCF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4B40756B;
	Thu, 26 Mar 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIHi6Sg6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6630F547
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545269; cv=none; b=km9GnzNF92l8suasa4B9HU1b9U7Ach4GNH5ShDIYN6IWnVSPfAiBUmrkgcupoSyynbN2cpvJN0+8HUDWUNBhhFkYLYQ8KGJLtzcFwAlj/CzC5RBUJG0aZa81Oo/7bSW3x9vyDzoHop6ovy1PRdKvKHtQWuHYwb08LvS85pvkP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545269; c=relaxed/simple;
	bh=kYbxmcPBnLD1OApRLqHNDk2P4GKrfRRDsbXWsTNsNY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBcvQMQtKu5yzn+C5j8fljqJFMZCPOtmwMdMZdSBS00e0MzfK8cNDefsTsaNybvD4/PwrbEp64V0HMJAhER96n1Lk/4q3FWPDVOYawHRyKF8edbWqoyd/ZZvJh9/MEeEOVD29qtnAF31RKwfr8elJRAB4jpo80vNtJhDEgDGquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIHi6Sg6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82ae378fff8so852417b3a.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774545266; x=1775150066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EYLAxpZw5J+LWwefp85cIa/Oa997GC6rvGojvQhFXQ=;
        b=WIHi6Sg6petVIefVuDLB5XIYloIw6Kt9g4ByZYY3w7IGizJtLLKYnAmkZORYIbpEXX
         PV53KlNWzOxHXzkEhcUlH/KppuADhmuZjMr+MC0sTMiUiJynLrBcfmbLI6mGdJcg/2e+
         OBE65143YZtEMyDsk1FWEUjPJM+f0Y6xdt7u7JDoFn9e5k2TtNJoS9rn8JRVLn9fX780
         k1xKf8Q+QafM12o0v81RxikqhAmPhzx9kfSssEhPZfEY3Gi2ytfnMQ5B2wZq8Jb1SWtz
         0R7w5G+RuTCM0XPvCdPna+8mXrQALusg9XaXqMlMGGEYDz4qKCEg6q4W/OJ/+uTmhx6o
         5v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545266; x=1775150066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EYLAxpZw5J+LWwefp85cIa/Oa997GC6rvGojvQhFXQ=;
        b=JxibpeNpirCcpRCBBnutknbxsQCo3W8+pTfE1xP4kJYS503oHnz48cafrk4T0OriRx
         EiPW+hCao7+obp/zkB5VEPbpc0nC8aLYWoL9QSIJ5lXwkq2LyVLLUG5cpQ1bxLsnHVVO
         36sCzRdZieDiU3EZq4d2t7HssRm6aANgBB+zuh2ZCAXDkoeRkct+dC7ytSUMo+wsUZ17
         AtAzsj+ihpyKi3Gz3g2kZjY+/YDAQE59/nMlmEhQlc6migztRBOkRnYT0HYMZFMr4BfB
         hLlGJXMZzgQSKK04+/YQnWucUmMiNXcyASWnfHZkHSDuQgpKQLE1LNKKiZDYg3VjKDem
         1mUg==
X-Gm-Message-State: AOJu0Ywl7a6fO4tYGZ6GtYjRWGnTOSKarCb1HZUILE+GhaUa1CKnqHA+
	FXgIEi2J0jOKxGc9lvz1sivNdJOwWHnZIODrHs/FvzKLqVwOlj6n93Wf
X-Gm-Gg: ATEYQzyH+uCAroOHQTWQfeAPBhiO3sgkCvDJDk8/2Z4Yrel35u5O4FIngPLotXHmmpV
	f4+YP1Rc89BpgIvA3NORW5eW48ZYhq263UObyUSm/aiCCm7EnZrM7i6enanzaJFNRIQ32spLXgF
	70vJZvqc14tGO5lsPPkRbdn0fgPvR9TmQQDRXYHX6bJoH/Vm4YsMeyJzZACSzzuL7Wyv6CARfl7
	I7mI1Z0zLc8qWB2pdtIxHt/ps81gHDxx9qW0QjLQd55VlLx3yGn9uLLq8Yydj3JqtH9FMqCO604
	HfaGmtjz18+hoJ2bb9zVULwvMw5bM3AV9hSc7EF17ruLWC2pshqfnAyd0G6+YRrCkFe7MKsZ+tT
	vAklPfXEI5Slt4mfGyK9n+wCNumKPIvHyFXcK6qV5V6P0dXJhMCeLuwDbOCamnNsnnqvUiggBnE
	vtfN3EdQ==
X-Received: by 2002:a05:6a00:3e0c:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-82c6de82b9bmr8842560b3a.3.1774545266478;
        Thu, 26 Mar 2026 10:14:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::c181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d1e5ee6sm3119480b3a.7.2026.03.26.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:14:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] auxdisplay: line-display: fix NULL dereference in linedisp_release
Date: Fri, 27 Mar 2026 01:14:12 +0800
Message-ID: <20260326171412.1109402-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-230504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux-m68k.org,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0F803390F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

linedisp_release() currently retrieves the enclosing struct linedisp via
to_linedisp(). That lookup depends on the attachment list, but the
attachment may already have been removed before put_device() invokes the
release callback. This can happen in linedisp_unregister(), and can also
be reached from some linedisp_register() error paths.

In that case, to_linedisp() returns NULL and linedisp_release()
dereferences it while freeing the display resources.

The struct device released here is the embedded linedisp->dev used by
linedisp_register(), so retrieve the enclosing object directly with
container_of() instead.

Fixes: 66c93809487e ("auxdisplay: linedisp: encapsulate container_of usage within to_linedisp")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/auxdisplay/line-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 4e22373fcc1a..e80e94262830 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -365,7 +365,7 @@ static DEFINE_IDA(linedisp_id);
 
 static void linedisp_release(struct device *dev)
 {
-	struct linedisp *linedisp = to_linedisp(dev);
+	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
 
 	kfree(linedisp->map);
 	kfree(linedisp->message);
-- 
2.43.0


