Return-Path: <stable+bounces-203098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B50CD03D5
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 15:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F5DF3042296
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F032AAD4;
	Fri, 19 Dec 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPdN/Lgn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04AC32AACA
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153535; cv=none; b=aSEmuj/EU6ZvZudk24GHVfDNCSdpdWEmJVd7etshNWdV+/nesUVbBc4x1kE0OubldDljpPHfvQFnQ5SZVKBfSawt6jkj0u3IdYrW8OwvjHAQRw5oeNwjPUkX4OBxQZbF84ZRF7m46MS8P6yuvTyyPz8h3Bh1U7wWHpaffW/ZRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153535; c=relaxed/simple;
	bh=+xw4qquMEDbOQ0hHhHQ1WQmmUVl9QW13/nMJlxdvFYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gubSOMk6yTARJ+0wz11JGbz+lEHgySHs4yWwSpxYS5ga1FigDGdqO67sZfMdoxAl4hbECK1EgU6eboOx5S5qRKyjRyjmTpPtS/8O/V6VjSSq/27hmil0WFe/d1NeM9asbwLIprKoPBazQhrc88VWAHPyfPDP/Y7NNHEzELyylwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPdN/Lgn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0bae9aca3so25290015ad.3
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766153533; x=1766758333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuVMIXJCkydm5uVU2HdEfL3gM/1O7B3pxM4tR+qCZ7c=;
        b=dPdN/LgnjJZmW5I6rnC+wXQBGwf1nnmsWDkRHS1sUtKzpb0AmMIreNvj77gWCCUzUj
         ihzfAAwSwRG+TfCWYK9jwvr9dELoE5psQxTqzD0emWx/gAlJ5OXW5qTqWTr2zsAVKnno
         LNNrqLrHddMZv1ySa4GU6pm8GGnFqvsoreIk62Tiz65mp1eyBRO0lcMES9Y1jIPTgGUy
         G5hoCdK0nRUh+EAEElh7lkW02Ypv0gCqHNR4B6gbyil6JuFtBeIdjd4zfyp0ZlZfU3OT
         ZtdrKJ0tCMBg7OI/SOtYDFgSj4diBxzN82a1BsKDJ4IAC+Ju6AdWE11e7r2kiJlWO4zK
         k/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766153533; x=1766758333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuVMIXJCkydm5uVU2HdEfL3gM/1O7B3pxM4tR+qCZ7c=;
        b=RYlIxlINMp5I5ToiYP2Kf/TrWvinKUjzWIe3KWiWIl/4TJkPET0kl2IvQ9a6+R8lIi
         ZcZ7Fka/uVVuNuJXNkJLT1IlFhb8VwSWeiGsksl11oW2EsGfzLkCROkWUTZsHfxOQWvt
         sbQ5ytdRPnGV6UYaG9I1cz1MdNlpsIFlJm3H7a09HLxtfNjYgVS/Rc6GMhMTScnIhARq
         gcrWEWkIR8Ewf90cc9XIJMowSKc5qiJB5V/I8BKrGTcBawb0mKSeHSxZbc6vHRF/ZuFE
         NytgdR0j8qQw+lVwuv4mW15+kY9Dk7IGsS3qa0zV/+2HUmTuUecyPmFqjkV+Lfn8L02q
         VxUg==
X-Forwarded-Encrypted: i=1; AJvYcCXsmLF8yuDRsJunRkRys2VSCJxYFoYz1nysLy6lzMR5lKIh5SH5HIyaMgO3GWn7ewPWSUO0LIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5jnAoEOxQZcK9OT7jJyAqet6Um2ZUkCgDLssG1jb2fPvuDB1
	KAXQA5h0LM9HrPwIkqE4KMJfXX+blJqaNROq8mH45J40EEcTBSwgU7Wm
X-Gm-Gg: AY/fxX5/2UKu68YKQX3VJFXvPSSrM43zUMInHKyKbFExd5mVvYqSCnXt2OQqGYFrKML
	mk9FlNb+J0S2pvbKxxhG5anXcOUbm3q+Nw7EiTnVRNhoajxufmNq72dgAYylptLWmFaxX0uiav6
	cSaQQocqpg1kKxOPvIbj2EZjvUYBoCUeHPeukTTur6dl/dAlbb+atA3v3KY19TWLj7kixinb4AV
	JveNt/X9SmoNN44dglfGpEMWVOwPB5tO0pWAuBHtibg2Ye+z20MDFyIsArekyPC+Wcmdwz58A0N
	CS/cpBXhB+bOLjEvGQCC2C0e2E971yktbZYDIY/R5XzF1/kaueGZgfMvyujwsJtAaLaaKrJ+4Du
	ZcZ9DUyIej3PSG/+7vOfxR3oYVRI29cwgtcXK/iUcqhod3z9A7HvBHmADqEXYe4W1FYV9HoNizq
	fBOw==
X-Google-Smtp-Source: AGHT+IGcjUWbmQcnlK1lPDMoiPsmtQhZgZ2i/cO1uiw7CWc51irQv/t47qGon7vqj0W5GmseeOcU1A==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a2f2212bc9mr31352275ad.6.1766153533039;
        Fri, 19 Dec 2025 06:12:13 -0800 (PST)
Received: from lgs.. ([103.86.77.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c820b8sm24081435ad.23.2025.12.19.06.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:12:12 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Scott Branden <scott.branden@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Olof Johansson <olof@lixom.net>,
	Desmond Yan <desmond.yan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] misc: bcm-vk: validate entry_size before memcpy_fromio()
Date: Fri, 19 Dec 2025 22:11:57 +0800
Message-ID: <20251219141157.59826-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver trusts the 'num' and 'entry_size' fields read from BAR2 and
uses them directly to compute the length for memcpy_fromio() without
any bounds checking. If these fields get corrupted or otherwise contain
invalid values, num * entry_size can exceed the size of
proc_mon_info.entries and lead to a potential out-of-bounds write.

Add validation for 'entry_size' by ensuring it is non-zero and that
num * entry_size does not exceed the size of proc_mon_info.entries.

Fixes: ff428d052b3b ("misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a16b99bdaa13..a4a74c10f02b 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -439,6 +439,7 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
 	struct device *dev = &vk->pdev->dev;
 	struct bcm_vk_proc_mon_info *mon = &vk->proc_mon_info;
 	u32 num, entry_size, offset, buf_size;
+	size_t max_bytes;
 	u8 *dst;
 
 	/* calculate offset which is based on peerlog offset */
@@ -458,6 +459,9 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
 			num, BCM_VK_PROC_MON_MAX);
 		return;
 	}
+	if (!entry_size || (size_t)num > max_bytes / entry_size) {
+		return;
+	}
 	mon->num = num;
 	mon->entry_size = entry_size;
 
-- 
2.43.0


