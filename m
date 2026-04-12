Return-Path: <stable+bounces-235834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDWC0va22llHgkAu9opvQ
	(envelope-from <stable+bounces-235834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:45:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE73E529D
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C4143002B70
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483735A3A6;
	Sun, 12 Apr 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9/xkXd1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC42BE057
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015942; cv=none; b=tHo0Vy06AIezWl6Rn5xK+4k22ghSCsy0jH6LLoGAB9To6frvgA229USNvHuLkGEcuA0TEoe/3O4Qkv1LOGRsrXdGDBaQM0W5V6enaxJedzcNRbFhls/enlDWAndCx9EsPjXsP4m1slE7Lrkgra3yoZaOxm5bf8g43rcqi7CRfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015942; c=relaxed/simple;
	bh=MvFqTtD18D5DAv92JGkSRWZaXoO1lYwBKr6BusmvkEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw8/bu7xLI6O/FuSMhejleed1i6PrrFeKUQK+Clts49ouLaZnG9t+eIEPTb+CQyMrvqU5R60yJ9VS0C0HPoW3f+oWoQJ6MLWkh6H2n+nOc5VrEku8drOGFVgHSO4K4SrU27lW4tqzts1dGhaLefKZaMOqgKxWXmVDDEXKfMFMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9/xkXd1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827270d50d4so3367652b3a.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776015940; x=1776620740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OoU5jmpe1DqxkQY//ANPB23eMZd7k19jDj8fX9LlbM=;
        b=m9/xkXd1+VePVXd/wRrhpvwXmPE104FdETsUUVnDZfunl6jKJcgN51Hlw03J/WKWfs
         y68H0G8yiHjqUwkhbjpa/ZsNcp6NbFIdskZM9bhF7EY5pdzdpns2KYFMgrwNROuV+Cyi
         IscnSBfR2dRcctyrWX4CHALqRMrMEQAmXrbheytT0Zaso22bPPae4TM0YRRcU2o467Rm
         TFNQfXrfJ+Fhtjyk5JXYalukcJ+ElOeDrYe9L4Su01ijiJF+6a6nrhLGM9DWynCGp+rx
         zbz7peRrwoqUEOFMzyooImNMGy4Aqy/4HJLEE563ixx8OF6B+8MnpyYzQO+tV1lRzh5d
         sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015940; x=1776620740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OoU5jmpe1DqxkQY//ANPB23eMZd7k19jDj8fX9LlbM=;
        b=TTyFbXpc+KK1G989TdfI7UDTcs0IV9JwOEaMAYESzrUOLzG2cxhcRFgye9EyW0Dqgu
         T/6BPHa8VTpoSGPG6R0YrP/V4CnaqiPXuG0LQEhQq+HWQKp81NMyehZ2Km3o0XvpnsJV
         p5vdCWygA6XTZt0AlOj1QdEyoviThZ+3cqqx3eCZpEpxy8ucmgb1JsTbPZTxSfiFICIs
         wbfi/ULjNgk3v16Rw0geXl4rRrSYV3W0MrW5FjsWsRjqMVB4VKkmeeSvqqdzLxijvn5Z
         ZzSYk2Vry0OMasi7JSaOL/TLncP3g+ZdtZdDUoE0gHDwucM97gOynNbOOUCRusYNLSTn
         HfrQ==
X-Gm-Message-State: AOJu0YzK34vtC3ND+h7J97qd37BkvejiZLbLTnFU8lYkrBaoJ88lJ5a2
	IP+6SWGsngSaXnVLdde42pTYwExgSHF5ngAH7DUdMwt7p6uYMMya2uvg
X-Gm-Gg: AeBDies6n8bA47DtWCkkETPGjzpGl3KSzn1sq2yAOdqrzv3/n2Q2xRfOQ+GH/ni2OBc
	zPpJhFdEOcDOBvTDtDGz7aeC/Tt0RUf4fkWcANdozp15JlTdENk1NpV4RwI0GW0MVML4qAn2pvJ
	AsKeoxzOU8kMdG6+lwuMJAHYcZcoCGESAlzuN5Po/ggN1iDxNZ102hPYrj6V+gFWcK7Ik6RKWgH
	RfNjIa6uN111zybmjFPrWwA4ubZgBeQt27tWBOFC2hjWIV9ePn77QAqd+DnskgA1tq0OtSP7QTm
	JpSzcQDjMKmzSOKt6FYrn9uYdFWOeNXaU7Vj8uuwbABoCg2VMlFTrELAFzoWS4t2e/x4E0l1DPA
	H6+9zq9XgXqfwelbD0520yGeYhoVv7pC65YwNCs7oH3ioKTXdo0J8dE74cYsBLHmPZgw0C5GFw9
	ZhSEpQa2wFwKbS1vAncLjQwOnDTw==
X-Received: by 2002:a05:6a00:a245:b0:82c:6d88:2a8e with SMTP id d2e1a72fcca58-82f0c28903fmr11551470b3a.20.1776015940377;
        Sun, 12 Apr 2026 10:45:40 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6dbb:2e05:75d3:967e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm8999464b3a.45.2026.04.12.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hwdep: fix NULL dereference on error path
Date: Mon, 13 Apr 2026 01:45:29 +0800
Message-ID: <20260412174529.2597250-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235834-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[perex.cz,suse.com,gmail.com,chromium.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 31EE73E529D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_hwdep_new() allocates a hwdep instance first and then allocates
hwdep->dev via snd_device_alloc().

When snd_device_alloc() fails, hwdep->dev remains NULL, because
snd_device_alloc() clears *dev_p before attempting to allocate the
device object. The error path then calls snd_hwdep_free(), which
unconditionally invokes put_device(hwdep->dev).

This may lead to a NULL pointer dereference in put_device().

Fixes: 897c8882df58 ("ALSA: hwdep: Don't embed device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/core/hwdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 09200df2932c..aa35bee8da6b 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -343,7 +343,8 @@ static void snd_hwdep_free(struct snd_hwdep *hwdep)
 		return;
 	if (hwdep->private_free)
 		hwdep->private_free(hwdep);
-	put_device(hwdep->dev);
+	if (hwdep->dev)
+		put_device(hwdep->dev);
 	kfree(hwdep);
 }
 
-- 
2.43.0


