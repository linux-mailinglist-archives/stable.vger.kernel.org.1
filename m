Return-Path: <stable+bounces-179413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C4B55ED4
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00C21CC5DB3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A94B25F798;
	Sat, 13 Sep 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMtq5NuZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65627511F
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743264; cv=none; b=L6g1hUBQXGGhTJxL/d3caGyoU0xKRaRwbUyWz9vosf3PZi9RB3oEZHfsfRJpcUvrIW7yxiS2td61A/JORGQd95jeELad/1kUngpLM8BhOhfIqiT35C4wb2J5tBNFGPSEGsPLivHj7gwMSdhgGoKz0EoV4pZ7ydfObCfRFSuujLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743264; c=relaxed/simple;
	bh=mveThYS13G+7KNQwz76VZIIbZN3IajdbzskP0SwjrSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTwsI1gw2dMFU/sh1+LkQLwFHckbcVaGDGoUgE4ncub5MrWqDksV0AoG+MCzY4ienmCXK/DTOSjWlPH//2A51EOAAnG/HqF5DER9OTrHoo8K+D2usYf74DXaGNZiYR5Q9hNTR7k6vtFwjZD2b1YTOdj9EJwpTKTNPCjkKDFFCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMtq5NuZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso2277831a91.3
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757743263; x=1758348063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=ZMtq5NuZxiCp3OhYgGPP2ilovP1v7lQ+198qY7y4GV0HWsvF/aqTKlhU+afRz9x2CF
         +byRWJ93rRc+RMXK18No/Oa9cXN8+2ScAchBCJosr1QBlBQB7t43W1qvFAw4eP2JvRep
         FyfACmoFHxVB9auAVwISZD6wuSUvpUPvYcjmFEHC3HJLjPpnCV1krM6VPNGEzEt3cSQH
         JpOK3zpVSKWg0B7p+eMbNb3SluXlqn5Mxccybiw5ZjrDvbxSk1fUWrXUapcqqdAeN1eG
         Td5QtFnTQD7ZkdDYyWRVQX+YCyk/wU/ht13jhU8FP55MFNwFXApMgCDenia9ZW4jKPny
         +cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757743263; x=1758348063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=J1ny29HP3Q8IyCVTO4uwKVOVFDM4AGg7PIKX8UbiwxCdvEDbWJW7x9WjTLSX92+mwV
         /453bnGl/9l1ZEKHppdrjc7coFDMCVC3kEH7/azP1SIdSGKHw3sPsjGt6+82ngx5+Z3x
         DbmIHAjx0c1M4yfP5tooZt9amaJGKyUJY8Gq7aIsK9YAVJDQw3DplfJMt7o6StIErNi6
         8relkLFqh84mZ1VaiKnZK4zTyB6j1sWcqR4qMvqNAIlxSuCcTCqrQiOMs/91b/vvHklw
         SSb8Rfv7MR9Q/3Fd3DOlhBgSHZIOFCUSLHOnQp1JbAtEWyClTY/QUiDy3gWtGRoIG1Pf
         hfXA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLZpWa80t5EqBox5K7ghEdv6U0znQ8Q5V9edutFlkCgpV3K0EjGa5jbOQT+4K6Kd6Jah0ni4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyM3XTk22hoayAdtZKmYGWkG04noEJ4sy3wg/v6kA8ZkLxmq/
	PVqLEyWsL7XqiOZ7G9g6vXwGIi0zWbe9K3RNLmSVZYnL2DdPJAOPlze8
X-Gm-Gg: ASbGncs9CgCdsRxzB/M4DcHxTFSn7zpiQ/cHj4hpcIac78AF2WI38psoyl7e5lfcR6/
	TYJcVMVJ7rvqMTrwHXlY8iqOyEJImYdHlxl52JjpYEcNS88s0t3sUyA98cYOyxZGo6PioXBiCsF
	YVssIQxic7VeSzweWOiBsPFJQ2rANQ8Ue55BvXMm6kEP8ftkziCFebzUmehwkvn6JHMfiqxpkNa
	6Kmr+UaAN+h5/dGqZ7dTT5PjtsC5UOZWPf2TIAh0KLGVLJVk0XstSO6FzLJfgFTrsukvo5PKqoz
	6sne7ZyJA2A4hwnjyzaD3BK5v+BGqI3E/GfPq7Dy5ZT8d/wg3oznoAVpdK/9sufybW7SJ5KizjP
	RNeFnLyJJ9RcM9rN5AwCvGXp2vryqOxuEYtEJfgMAzaEn14ZJppXz/NIXv+lpPu9l/ZCyxu5Res
	pH/i3PLtldI/mn+g==
X-Google-Smtp-Source: AGHT+IHvnnWKFwToC9Y9pMYwL6r7so5gaz/XND2NOfznvp/2UXSHEFi6jC590CjlWuyJYfZVJl+BUA==
X-Received: by 2002:a17:90b:534e:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-32de4f8507bmr5925124a91.20.1757743262562;
        Fri, 12 Sep 2025 23:01:02 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:6378:de6d:4719:f31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd620ab73sm7947981a91.9.2025.09.12.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:01:01 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Suhah Khan <skhan@linuxfoundation.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Sat, 13 Sep 2025 11:30:55 +0530
Message-ID: <20250913060055.38319-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


