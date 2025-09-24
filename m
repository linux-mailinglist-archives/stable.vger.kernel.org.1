Return-Path: <stable+bounces-181562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2111B98072
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 03:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6724A8168
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63C1FDE14;
	Wed, 24 Sep 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBZWKktT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E6C2E0
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678577; cv=none; b=oGP8JK9FqWus3awIf+XgNPRKcv1WE0ZwP/cp6DP6hvTIhHPS6u2D0H2XeSZU74Aovj4Jegs8fKA4iF+RQ39tig/eUMp+vGh7GR7gW5Xo5vKV+PNx+ERS37erFko2mFlG9AvEquHU+NseWgsWDJuKZNjcd3hEc9k44kk1ZtKAfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678577; c=relaxed/simple;
	bh=kqwBAp8eLZsgM9ZcktYb+i+BnIyf5jtMDwEu8f3+z9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6ByKyDz3lbYZk3kshRN0g/1LpBrZ/O5d7joj5pz2xU9eFRtwdd8g8C/NYh3IrJoPQdd4zAm41vhnV0Yl2QlK6PCYBq6okDl6ybLYuWVGZWfqXWlNwF5YtJghCQKj6J3TGf/KAb4o70M1kKrMsKDTP5nMATAXdOj1uK3RNQUfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBZWKktT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d2c35c459so11018695ad.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678575; x=1759283375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+63vGgkh7UGktsCdsW0b30BT1FgIBWocMf/422wjyPk=;
        b=YBZWKktTyajDtxgYhZx6z9V3mM0QVaPwYSAIuhOAvzXkHsei0gjqn1mJYU1jGpYXcL
         W/nviBR/FkU0WH+eXGvY8Y7qUhHDo30vnFnM8gI+0EPkKjWTFJt3Yjk1ngSGj28AzBDb
         6z4v2Q3UJRDblA963SciWnh64rpcSceL/qmxJlJ0eR3xD+kPUXXdw5cIx1eCb6q/ggvJ
         GVKCIvndPMTWExUFz4eepPdBKEAE4HNK2jafT5yEfHkIGDiOpPmi1nDemm8lHQOwdGoM
         eIdSR2MKbWx0lFXKaMqA2NYnrQDkd5CEJbS/zXKmPtiDhJaofuV20ov3ZSzF6F6sj8W0
         zTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678575; x=1759283375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+63vGgkh7UGktsCdsW0b30BT1FgIBWocMf/422wjyPk=;
        b=tZH5ZNytMMvUkibf/JbZ285Ri5A3OSu5TqFrnkOivFxdwO4KSA3wbiRS9sj5Ed2Y5C
         ljP10fpH3CCYL5Tdy/9acbDSOnXFGD/LgmdUPuSpSMQ9WO4YOlQ+sE0m6QVtk4PMg7xr
         8TDKJiRf3mcTN0yZPJ9qH1wb9cAZop1B48uXwerp4huPPW0csrdUojcy2H5fGBZGeS7o
         +nBcQdVSltQp2exny9kJroAVjCKt/6rUZck2k//hwiz0ZiGVo6DE2JBEr/h89NNE0hEy
         XwqL1CCc5dqSU+fEDjAXA7TXTuCN5InkqXfJMD87vdLKxOAWkJbuOeHYMdrCdDa/DRkg
         W9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn+meiGUUEq+WMiVWTZflDgVe/AoDhDaI60D8qH44UEKJk0zfEojleVxCB4F/VraCuYPhlpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPUX1L/KJDXNtDAH10FTOeAE0ZV6xoYlArXaeZ2o9Ahpz2J+w
	w5lecBLKCiu6zKpVGzBWpGdVRnJXOPoi1LhAXlsBZoVCv5yERxcBdsAI
X-Gm-Gg: ASbGncuz7YBPEbRrKfc7xRyyTiHl8E4Neb4isZIt6LDH011peeiyOp3tS/7skVs82yp
	MHzaxbzrXRI49suAUQB+nkpFCKBp8mTImc/3ENno09fPcFHCd79IyQUHwk/E4Xa08f0/h7FAMQi
	9KKhl0OUS+AlZcEnh5GfFhPS13zpV++JRnLDTJ51cAp4QVy8AJHRiJn6/uESmyWL1iQ2FOM/OdP
	LZjbZKw/Ww/UPz0zWPivGmwrhJvVqcK091dq44MywFOIMOmeHvDqafxq+mxcgKn0rk3FMFYiwGy
	sYsnYX5Il7c55gd5SC2SVI9tFO1N6aheJXnXjRuORfXfvvC6ILOgtE3JcS+vAzAcSzR5wNf3ald
	yhnKXxmbtmO0cBfysewMy5Hy3F+Gz39+oZwCZnxv8IhE9bbSpbFfobuMYuDOImeusZeuNOzxJp/
	20uw==
X-Google-Smtp-Source: AGHT+IFbe5C72lGCV43OyzjC3oiJ//nyTG0JOGFH67f/AZRsMpwEcTn0U1ZQbj273YRI5mydzlOt6Q==
X-Received: by 2002:a17:903:1a43:b0:267:ba92:4d19 with SMTP id d9443c01a7336-27cbab337f3mr51343575ad.0.1758678575425;
        Tue, 23 Sep 2025 18:49:35 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1550f70asm12120722b3a.13.2025.09.23.18.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:49:34 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Wed, 24 Sep 2025 07:19:29 +0530
Message-ID: <20250924014929.1097959-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The comedi_buf_munge() function performs a modulo operation
`async->munge_chan %= async->cmd.chanlist_len` without first
checking if chanlist_len is zero. If a user program submits
a command with chanlist_len set to zero, this causes a
divide-by-zero error when the device processes data in the
interrupt handler path.

Add a check for zero chanlist_len at the beginning of the
function, similar to the existing checks for !map and
CMDF_RAWDATA flag. When chanlist_len is zero, update
munge_count and return early, indicating the data was
handled without munging.

This prevents potential kernel panics from malformed user commands.

Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/comedi/comedi_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..786f888299ce 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
+
+	if (async->cmd.chanlist_len == 0) {
+		async->munge_count += num_bytes;
+		return num_bytes;
+	}
 
 	/* don't munge partial samples */
 	num_bytes -= num_bytes % num_sample_bytes;
-- 
2.43.0


