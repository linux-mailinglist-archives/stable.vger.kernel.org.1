Return-Path: <stable+bounces-200855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B4ACB7F3C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 578903009DA4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912F30E0CC;
	Fri, 12 Dec 2025 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpzvfup8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B327E1DC
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765517388; cv=none; b=NjCCBi8oX3noYes5J26/40KJYWJlKI3QHsnriCO+jr1eAdRPCNtbJa05JIkXZ+AKqZmAb0CSTCtylHn7S93+E4s/q7rpzsRbC4V1u6EjgELIPGcB/daphOdGSSGt8v+ugl+r/15nJONFFoBCln9K2j+CnKkioAVX4rhGPQkbrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765517388; c=relaxed/simple;
	bh=ncSfG+DQWHiHJ5P/tpjPaAOggTR0P8F+F2Kj1x+1+9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dL61tLeWVy3gtqAxL5WBbi8m6ZVoFedNgsGHbQd+oLg8Jt9WPciebvw1+rch5MW5kM5TpR2C9QFIQx8KgQTC5E0y79xM/D4syjlntFEyhNugQ+8F0d9VRyCMgwSYGr4db8qAbm/6U6bTiMCUyn6a2EoMKXudPqzJcBvvqhKCUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpzvfup8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29ba9249e9dso11663425ad.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 21:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765517386; x=1766122186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=Hpzvfup8CWjGds18idPq9BC9s9Bk6qVo2VlkxMZZvZ4GIMNEnnk+g5K/Z7XsJrjnZw
         zO0XY6H0q2BYMBBYH/TS0WnbsyowoDyI3KdjG77YXpHaF6p4RGQFY0qZPkUds8sQ4ypz
         zvfbtUac52fkeKqLqmGYgLnuN0y65FydnfNrbG2glBLtkbkGq7IwkiXN6Sow0naSr2Dw
         bxdCdz+ZJq180QzEUkIuoTjbgVDn1FPDmfbEo+zqUkPURk9ZtuU2QT+t/OM6daC7pzg6
         7BXof9TUEikDhd9UKts9a3XE45HjwV39zu70mMdbjzAdlKd9oFOurKh1s/QPkOVxBT3s
         gmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765517386; x=1766122186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=H62xj438QcvHmPIqzK83yGHWx00yFu0lbsfY8cUbzl9eBr1lPPAWCy6FHuaBjzJYnm
         gbaqDFMw41tnjVvFLCb4TfCYycDWHGI+fyvIWJ0/jUyHIk7KuQNHuR+JgrAwriNpS9c2
         +VolAdbBob20ChWksAnGDKns7u8djgO2ZkPRxlKVWh3yf16ACb7mkYQolFrJTjCoPWc8
         uNassfhv8uSbCGIGgbKQyqHC3KyAaL47oOeHUoueR9TKXPxFfK6GNKXYIud8LGyGIn0n
         mDxFvpmYee1spOcYqixQCKhwzLnP7Igg2LCzQMIqtM0/jwHQ9rQy+BDwEzyfxJTlt0N/
         6xCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCFO/1LRDLl76Eka9MuHfsH/cBeIsTNg0RZY5KFGw4D3r0G0EaWJIMeLPKswenvvV9vsjc8zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXlkMXMJr6HI6TRtmwqoL3biMPGyCJr3XhbsVW9zjxSMyp07l
	XIV0S4S0lpCcvXTjSORvF5W3qZ3lgfPA1WDGokhFYzH3VYlNqz3f6pRE
X-Gm-Gg: AY/fxX5nHBKZAI3+NZt1crgzjDgnD936cXl/RHsQ8CiNKANPbwErc0R7DXovgGj3aCe
	DWGDrJd8KqZO+AT5m+pEYtRAUoG60esI0CnvHy5fSW2ldpgClvU3++HnIGD9WuyyAlBb8Jhku5f
	j+AV4GF5HNL0czTs/ejyigpjiUr75fNMes1x8CER3cukjl3Y8FxMCepRYPZLRuo8SZsSCbkzsOa
	349A6V7tBZGDTwPdrAqp3EynTlMMsuEVWmLARrYK7U8piaT5f4mUGll/m18IdRtGF7KDnHYEvS9
	hTigjeeUtvA4IxfuHbKWM00u6+XKlRvna3iYdg5kAEDn2P4D7MGVZWvzokiyod0nvUnPuZjd0Ib
	0BOXjPJuxjSTfqjzeqyFkiUoLWx8/aUh3aCEQhd5Ag4hEZZ4FAjh1VTChiIiChxPsCJnFbhdKik
	2ZBuqLUrF8mFBw2QYYq4Hd6Iz63L4K
X-Google-Smtp-Source: AGHT+IEOsPxs15DqmPE193WrrqWLMX9iYaahF/lhuJg5vO7TdIm8fmfokib6VBzwJtZ1UOig832vFw==
X-Received: by 2002:a17:902:da89:b0:295:275d:21d8 with SMTP id d9443c01a7336-29f237db7damr13746115ad.0.1765517386109;
        Thu, 11 Dec 2025 21:29:46 -0800 (PST)
Received: from DESKTOP-6DS2CAQ.localdomain ([211.115.227.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06b49csm41486705ad.95.2025.12.11.21.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:29:45 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] input: lkkbd: disable pending work before freeing device
Date: Fri, 12 Dec 2025 14:23:14 +0900
Message-Id: <20251212052314.16139-1-ii4gsp@gmail.com>
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


