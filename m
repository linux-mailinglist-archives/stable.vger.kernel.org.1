Return-Path: <stable+bounces-200854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48812CB7EEB
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4643C30069BA
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3B240604;
	Fri, 12 Dec 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbenTyKD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EE274FC2
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516852; cv=none; b=q3zGHrdN/O0eHuJxC7uy60RWC3UhKKRASz3xi0PqXGjRoH694aqgMKjZZSOxddEvOOaBgd8l/0VVLglrsIRjPKZcqrofjIfH3H/27zQ75TAT/trRbbYMvQfZkFht1LKvI8OcT0KD9zyavGwayE2vxZ6UFsO136KFveSFYBkUNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516852; c=relaxed/simple;
	bh=ncSfG+DQWHiHJ5P/tpjPaAOggTR0P8F+F2Kj1x+1+9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGiC+OHus+9kb7TzIvufzMuMdw9CdaIzrbtMCE2jNr+LSbCMfEO4OKpHhHZo0nYpkD3ek9vN6JDj7zE1omRYFaNnuq42fLbYA2gTnoA5ur/lXiEHFGWcwg140URsIlt+xkL2Mem2+1oKN1BOhzW/B6SJUhkLxLVu5pf7FAOmOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbenTyKD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so742779b3a.1
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 21:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765516851; x=1766121651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=nbenTyKD85IF45r0eJAc4dm/Vo2aV8M/MP1G+y8CNfmbvnKoBNP6YbuM054uCj/M60
         wOIi7b+vC84BXcSxa+c9R/MTgy4YJWiu0NUTcOE+/CSTNyaQnxkMSXYgx+wAmlj3wuaZ
         NOhEhm7QU2zxXiMr6hqehalOz38eLOE7XxBAn5fKaDztt9VAOrrwarBTQx8tgaKSvn9T
         /YJEGGY7zatNJfjXfHccXHtuNdgcwyo8J+hnpnZnETAt8D2OtNDi2190IFIdlBqfZ5iV
         46OpYg9A1DsKb0dm72Vetv9EnqRRnivqkQavfU7muMdAE2vKxSh5dt08f0DFNU8mHwQD
         BH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516851; x=1766121651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=dNEUnyTGr2Kl7522zLNw8xnj0928MbAdSKoOUH1PWKUBLXVjQSw3qJqwCXDG9jW021
         McDIhIx76oBSWoNDceZercFtQAedqaR2UjJ7YkIyI2jzqNSNZpbxLdCWEH2jOZart6iD
         tKo5lOKn4dyDW+G3Af02GyZhdcBmmaK0ZIXrmu8zC3Sj8p4DrfXcGkw5hOISe1EIsIec
         vn9sd+bmTxZrYnJfy3L1hjapATjIfLVlvmrW5heG5+l631dSZS+xP2IKVHXjiGonhWv/
         Kq2Hz7FaYbNEeDNnwqSW4h9HfnleG/QtqRSFV8ezSjVlQ7NCKp0vLX/idJMk0HnYAfl1
         q4gg==
X-Forwarded-Encrypted: i=1; AJvYcCV+O8QgtRuy+FRqwAGThN5x5kRQP+IR9D7g3SPFvJ00zHl/p5RPB+UPtcLYGHEspdn+KO8Ubs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNqdd7i59snUo1wbJyp+A638JUow3qR6cUzXIBu+IwYPUS26q
	ceY8XJdHr1rCbM/0KB+PEcpZgXWIhCkpWAJTJ9LSC7dYPvTC0aPxUrL1
X-Gm-Gg: AY/fxX5+bZ9mDa14bRECa7d8BDBc5G8HkJMNEtBr3TjxUlHUaxGXFcgOqAiYs/4U1si
	zH2KyY3/mhogpy+Y69hRf6kBgGiL1WjE5E2OUAnyoa64Nk1OoLPxO51NIuLYh/3Vo8bdLpf8td7
	+suRIioMYmgseNLwEQNC1l3bWZd6da9Nx10VsIdHzlYIAACZEZE0UYBLkzFF60EXOSSzHu1j3wF
	EI1u8sK7HSy0G5VyVMyK+3Qwms9wf8MYvJdosNdSDPZ/wMK7O2dkiFGvhR9PkGfzsiOeavYaPth
	h7pj+h5IeaVBSGzQKzBgSvcGGdUmf05tTnKOrITCdFQO9YlzUrq09/AUa2dTdmObBScjRlqod2f
	vyoZPgYl8lw5+bIQR24xd4pojVNWvwd8DPAfbR66pdp1OuS4oUNv+dg++7mTr2mCMtoD5YrdmRN
	hh8/5gqcUZ1KR/tWBAjqV+D/Cj+mJC
X-Google-Smtp-Source: AGHT+IHP6/Gt3lDCHSB+n7Kyvc1rj2BmbubbeF4OENnzL/yNsMEge4agbPm5+387glQod3uqE8CWlA==
X-Received: by 2002:a05:6a00:1c82:b0:7e8:4587:e8c4 with SMTP id d2e1a72fcca58-7f669a9576amr1107664b3a.55.1765516850777;
        Thu, 11 Dec 2025 21:20:50 -0800 (PST)
Received: from DESKTOP-6DS2CAQ.localdomain ([211.115.227.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2bfa0165sm3789626a12.30.2025.12.11.21.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:20:50 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] input: lkkbd: disable pending work before freeing device
Date: Fri, 12 Dec 2025 14:16:23 +0900
Message-Id: <20251212051623.13891-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211031131.27141-1-ii4gsp@gmail.com>
References: <20251211031131.27141-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lkkbd_interrupt() schedules lk->tq via schedule_work(), and the work
handler lkkbd_reinit() dereferences the lkkbd structure and its
serio/input_dev fields.

lkkbd_disconnect() and error paths in lkkbd_connect() free the lkkbd
structure without preventing the reinit work from being queued again
until serio_close() returns. This can allow the work handler to run
after the structure has been freed, leading to a potential use-after-free.

Use disable_work_sync() instead of cancel_work_sync() to ensure the
reinit work cannot be re-queued, and call it both in lkkbd_disconnect()
and in lkkbd_connect() error paths after serio_open().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/keyboard/lkkbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index c035216dd27c..12a467ce00b5 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -670,7 +670,8 @@ static int lkkbd_connect(struct serio *serio, struct serio_driver *drv)
 
 	return 0;
 
- fail3:	serio_close(serio);
+ fail3: disable_work_sync(&lk->tq);
+	serio_close(serio);
  fail2:	serio_set_drvdata(serio, NULL);
  fail1:	input_free_device(input_dev);
 	kfree(lk);
@@ -684,6 +685,8 @@ static void lkkbd_disconnect(struct serio *serio)
 {
 	struct lkkbd *lk = serio_get_drvdata(serio);
 
+	disable_work_sync(&lk->tq);
+
 	input_get_device(lk->dev);
 	input_unregister_device(lk->dev);
 	serio_close(serio);
-- 
2.34.1


