Return-Path: <stable+bounces-92923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DFE9C7451
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6E61F21FDF
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749020102D;
	Wed, 13 Nov 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PwwG8BwX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59991F9EAA
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508079; cv=none; b=csRzvAUT6/0fGYq/+R0Yr8eLUGowqM2hf9on7Ua/g2ne9z5PGZCazCPYIP9icerg1v+QkwsNPvGrx/njrdW8BiVevUlwtiMTq7zRhy5FFn/PG+sgnzwwjMBle58sRmZ3ffMWF8DHgY7wohF1ERZoOhYM6n9ul2fzi8wOCsne9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508079; c=relaxed/simple;
	bh=Y+2H4LdN8mN6PJGaLKpXtkX3V6r/tQyzwkTwSod6FNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvxvNus8FUtGlMPRB4BwKXSE1YH3wsDzY3DAp84K7BB4AwoZOp0AvV8xH6CImGONDHax1uEnjrN0DS4hiylCrrn05ygAYOqlaBVZjPIXM6xJkQYDtzxF96/AtyT2uRkaEfue7+WajPIEU9695w3n01Tna6am3RCICcvXpbfyT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PwwG8BwX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d36f7cf765so54428976d6.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731508076; x=1732112876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=PwwG8BwX48E7l1wlbo6E2QcTFnMrvTuVrxgp4XINPytAvgCn40NKTTgmeR0fGLvfi4
         LT/gJEXucqr4713/yh+NQbRYIL5SLuRTgc2z3ylGC3+CIawGFUgViVNwl+rH1imXU2i2
         GIee5wJT/p1vPKOZVcQuTEsT0mTXMENe4xZpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508076; x=1732112876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=H6ehXWq810yEI+TvJiJXy9qmmHz3aJ6UwE+09RfxdQ3Y5fwY5QJAEDNkPo5xxzcbZr
         ybAoDBpZZYueu4ipxu1LddInpRWzlKLb35lQwhdIDualYKRImoeakJZYVegVZWX4suzy
         Cv4Z17eylTyBqijmm91RFwP3yEtjwO+lqMEtYmHdK/JgQf7MU8R9NGLfY+V/o8IzpkoV
         NL9rJqRdGNLJDwHsIqv1v5NhWWaGj5Vc/QyHnP3IZv4SqrJx6H+NEz8vZZtS7FC07ClE
         0J5d/dToRhWwr8QpXDoK8hJTKGdsPFPmxbpFfZhCsSlKox8+YW3aSyvBtWLdfMjhT6im
         /Syg==
X-Gm-Message-State: AOJu0YwUB03pEucMD8qsFSxSsSJp48DGLeJYgUihqAxCYRS+01Q79ERB
	+izMD5yNZKgCMQRLOH/iGajjFAz0bLBqlXVZ+nvTa7wPKJ6KBCSuIHhwm9S1i4tCsbxpA/NV9OX
	lW9Rx4eZZFCVy95OXskFRhsfrmcnglpoXZLjX0R+KhYs2FC4f4yYrIxjIlQFpW7G5AYqS/0UAlJ
	obWjy/ijmDzjOv/2gazm6Sqb7d2RY8VKLaDpIBCtiuczYelHTqM9Cf2I92mIVPkS0PpQ==
X-Google-Smtp-Source: AGHT+IHNU4BkuDoySGHigGN9ulN/IS07Uo7ecwBFdjEIsUxAiHxHdOdLhRm/oLLAi1XFBjrIj/1mmg==
X-Received: by 2002:a0c:f64c:0:b0:6d3:e7f8:e486 with SMTP id 6a1803df08f44-6d3e7f8e4ddmr746996d6.15.1731508076325;
        Wed, 13 Nov 2024 06:27:56 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defe5sm85134976d6.10.2024.11.13.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:27:55 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mqaio@linux.alibaba.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	andrii@kernel.org,
	jolsa@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 0/2] uprobe: avoid out-of-bounds memory access of fetching args
Date: Wed, 13 Nov 2024 14:27:32 +0000
Message-Id: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include additional patch (Andrii Nakryiko) since its a dependency

Andrii Nakryiko (1):
  uprobes: encapsulate preparation of uprobe args buffer

Qiao Ma (1):
  uprobe: avoid out-of-bounds memory access of fetching args

 kernel/trace/trace_uprobe.c | 86 ++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.39.4


