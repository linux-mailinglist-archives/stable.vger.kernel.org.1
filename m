Return-Path: <stable+bounces-188357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2212CBF726F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDD4EDDBD
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA52340A64;
	Tue, 21 Oct 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxuUDRjW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776733B975
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058000; cv=none; b=RE86dVmek69zdvecPBhdgeRNw+jHb3oXqkqtWoQdWoZb6dEvV5Z+lotj0BomKl3pv473P4NBQwuLEteaYlqO9D7sXP8Gd39iGcO+ka7lFTuFZPxEZKx5yJMBscu/ELxA7cTQp1ktKvz1E/lg4KxFypIDwfUEeZf5xWNLfSQ3FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058000; c=relaxed/simple;
	bh=DfZMU0R0dRnRuQiWcl7q8VsHGYmCXQ9jXTVQm1yN/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmnStUv53Scw3KkUevUB+n9HjgqS1Qet05kXlST9TCJiXBLW+cdD59EghG7t4q6DS6gP8PdrZQXu+HpaJKfXlHa3NNI2XwdrtvizWYBqMi375HxS+FqNAfq1q5m5a7S23hp7G0h5KLWn8pVDQCEa535tiJYo5e+mhWSz7ARKTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxuUDRjW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f68dfe7d9so407445b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761057997; x=1761662797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=PxuUDRjWhjWUQ3B+hAGIeDC+eY5/HMdO0MfFdIKCsWf2WDjysEB6j7FFO/S8rK2cWd
         HkW1PDhQH7EvWXbX4olKMDYqy2RJK+6GhIW2DUHRiN4tD6sXrc2nZ6mgGkTup9UjUZGj
         KLGipUI1umAhmhn3PCivDhQqlDVBG/wHtfKG7miOB6BbuEZkdTJ4cMNa7TRAdZHSQE4t
         kmKkedbm45obfnRGa1zUqSFa0Nufu3JbOKDSb+16xmFUdeUQzWCFIgf4A/R8KRmRlfci
         HwmM6Nv0f4s0tl6NfwaRhO6tUmKHuzIJengLvbUUGzzWG8+85qwXTkl0CVtMRomRRRja
         Xtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057997; x=1761662797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=PTqa0yg5MwMKBGaiCPRaug9dyNEq0DJsUmk9xVmhRRvpttv5N+gJ2L5uM+NeXRm91m
         nEpIkoXTzKq3zMGh1HGX+1QELFivB4hbcLkZlw3jE2Yo7cEeAVbm5ElednHIXIrE6Tsg
         GHUZlF49LPK7SEgMCqNkUeaJry5PLFzT5S0oX3v+KX19ev5LPovYG7n8jlOeu8tAOudZ
         ldPMERMlLxy/R5YvylU2CZDaunLWxzsJwbLWtMJbVCfFIYuyz0iZ6R7LRJf7Lp4mP7kU
         y2xlehkNvhLrU9p9nsuNcokyBAbvycc6oQupAWq1qxkmQy1UZTl7bm78jTbLYxrmf7jO
         HKbw==
X-Forwarded-Encrypted: i=1; AJvYcCWdY8NIep6pv6m/QE0cTZW0bKNiPc1Qq2HN+GFvJHY0j9+mXeCxjR0hDLdZe/trxW0YX6NqYZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWKu+uhCYVn5IDLjNKLqvWni/E8q6k/JOgsuiFJDj5LLkeJkV
	RLnOKGb2pt44xj/NbaWtI8d636ZXb5jJZXYHt5w6+z4zL5pKeTqJD1vYGneC59IG
X-Gm-Gg: ASbGnctfglYXqPLOBznGrfJb4s7XLJ2OVeMKm8BOFz5sWJp77l1ePWDHMTVlW8oydBT
	zmr9wNbl6Fg4njbh1tNt1yZF7SLboWZ+vYp81lNNlOHxaHmUKAGPPcHZ2TQcx8m0Avzc4xoSk7u
	xbbync4lUeZkIfmqY44CGpcphSyafYNu/3Evn0u+PMBV8KGV9e0YMsRKZaqvByBxywDOiU5MMcH
	vWcosLMV7dV9YZA1Lm0nATeZ/szGncjnXx+9rXkmuNjqfo6Kv3/4iRkncxUzcviq3VIvOAG39hl
	2A5dhhs0wQu5QFyqY5hdKjB0oOUwgJFcEaWQphXpcCh4cTfPxyhUvh6vu2Fa+M8ziIXI8d1h0rE
	ibMT14hNdNoZoad9sj8yGKG+cGuhjS0HPmJLcF3xJp2bEaWeLHL+pNgTxI5lIujrFFIjt1e9dd5
	CF7fpttGguqm9Poybh6F3GWxNU/Tx3rL7RhT8MweAjIMZspEpAFK+HtTWsTFbxjJJnu6Rss5B/W
	NXzGXVZcFY=
X-Google-Smtp-Source: AGHT+IH+6S5tydaEC5w0t3ABTMCkv48wPA62Xj3S7Ydy/DqQXwtxS+amoxYPHQbPejtDF3dxTsEwag==
X-Received: by 2002:a05:6a00:140c:b0:781:18ae:2b8 with SMTP id d2e1a72fcca58-7a25727182bmr2687642b3a.2.1761057997446;
        Tue, 21 Oct 2025 07:46:37 -0700 (PDT)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm11591703b3a.22.2025.10.21.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:46:37 -0700 (PDT)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: harm0niakwer@gmail.com
Cc: Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: transport_ipc: validate payload size before reading handle
Date: Tue, 21 Oct 2025 23:46:26 +0900
Message-Id: <20251021144626.473844-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_response() dereferences the payload as a 4-byte handle without
verifying that the declared payload size is at least 4 bytes. A malformed
or truncated message from ksmbd.mountd can lead to a 4-byte read past the
declared payload size. Validate the size before dereferencing.

This is a minimal fix to guard the initial handle read.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/transport_ipc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1ce1c..2028de4d3ddf 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,6 +263,10 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
 	unsigned int handle = *(unsigned int *)payload;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
-- 
2.34.1


