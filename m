Return-Path: <stable+bounces-211662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AdWEsCld2lrjwEAu9opvQ
	(envelope-from <stable+bounces-211662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793CF8B875
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4DB3026AB8
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C734D38E;
	Mon, 26 Jan 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHXpl30Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74B346791
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448893; cv=none; b=G+DqF9AeYLnknCMWienkjXDpIJdP61u9uA5vSm0cwmE8O2h4NE8KSWWUtx9t/32hP1MlmWoiq6MF8741fv7qJ6BkhCLXWUHj4MP6QlLa2YCgLBdf1YsWmjKZ/V+GYuT3zKkZFlE3TxMGdCiWiy9k96cW8pYPQszZvoXp7fh2MaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448893; c=relaxed/simple;
	bh=h0/ub/2a0CH0c01bv1YE6IT1oluBRPkEI00u7f+PX50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4R5+ECo72kb2jcz2Bcrjf8nmSMlB/wRIu69fh7tfx6QpY5TRvlT6YxofY+TPG51NKFjlZk698A6B0I9otbg0+vFnuVoAwMuwgRXgMKN38n5MP/xQ8az5qLW4gkcDxuW5f+38aVT8KOWuQ6uY+EPGHW2i6MW3EBo/ziTw9BW86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHXpl30Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7b23dd036so24637255ad.3
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448891; x=1770053691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjv9fu28bLwysGYF55oXTU3CWsx7n76bAr9kUcIOrhg=;
        b=jHXpl30QutwixtbLbABlv+tUAZiY+krcW8bp3F1VDwy5zyH3t07w1xTt+yg6HvAuG9
         s3VZZdsD0qs0DWhHjpETeqRHjaDV3gLcMtAICBmcUM6x01bIEXWe+Yok3pKjsxO3+8+r
         TXwUdMh8u8FzBI+PaKN3q/aGGkiSbq0g5nZ+6ljBYdhwdNBCPh2wyPYHLaC+EV2w9/V7
         LZGYza7ykHIH1lXl5dEQ/T+WrLc9Pr7h97fvOEx2+y9WoqtonpymuvF78zrltPO5K6n7
         KGcikTUDnrtYpR68XKm9Oz9Obm9/ePInqf8POm4Q9vlXJR/OKZwehqzhrE8mMEziXoqN
         H22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448891; x=1770053691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjv9fu28bLwysGYF55oXTU3CWsx7n76bAr9kUcIOrhg=;
        b=G68HGZy344afDazlm7lx8ScrXy0HdEoGOA70mGXB2jgomsdfkxmJ1AQAf8j+NnHqrx
         CqhyshsPc9KjfYgC2I5yBZN3OBX2cA6FNOm932MSwH696MJb2l/alEYh1cKBmHWqRXHi
         vV+ICsLUxQVWgM6OTQj/crbGrPOo0owp6Er4AyKT0cemi+EDAwETz9labABy42nrCrqo
         up/OrCMtUD/OYq8txMHKyXwcI2YKgfJjtfQYRC+ZUglTIeLleIlqTykbAiCm2pOhC45w
         ZSBpqrTLAX6dkraGO99kVMlcjd3RZV+qHRRZuPcRpD53BSCuaz9NZaqeiqcRlFOwCP6L
         +lMw==
X-Forwarded-Encrypted: i=1; AJvYcCXBDjwqDNh2jIQUeSBh/zr4IV565PmJRN7b4Lwtc56r+3/lFn75K6IAF6bT6ika14ijik6mU4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPq/rCJA1v83UEVknDWQiX+EJb+v6xfncrXzkynkDpVRQscXsq
	v4ZLogQ0OKipSon7xpKfOcHXlqY3l5TXg7lRZy6NzGilx3E4uRBeWk0Y
X-Gm-Gg: AZuq6aLi2ZkX22TOuotplpBRB1kP94q6Lo/Kuo70XWCS1SX4DfF+/mG7+F1uFw5N0T+
	xLIx1r1YtT3WZSM4HxuIsRgNZals6aFXmoY75fXTyvRlCpM20W8+p/PjwQM716tH5A7SEv4ElG2
	8OyLOIHu7vAD4mfpIzF58qpdm+8LHz8V0z2Q2JW604mff9y6Fn1wzKaPVWzU8XM070MwWy516rn
	+//bLiHc10mop3rpTrEPhmIPuMOE7DorQ1+8KVsUhsixIEMsCMTakCUCI5XD9OyQBdUiNLwo5k2
	3DvJ51FtjBr2I4NeLz7eVtaMdaq+KWskiPJWqhRco9nOejLDbCYkKX/MjpOs0cJ4rRdVc+ma9uu
	+K31+Kx1l4NS89DLvOms/2niDQlHNH4YeSjFJBqHD0PKPmp3ba1Iy1oCINqhBoSCB0chyo2j0O5
	QysZWAlFXGf9eunauamXod89XM0jlEmkAF16pn
X-Received: by 2002:a17:903:3bcc:b0:2a0:d5b0:dd82 with SMTP id d9443c01a7336-2a845323587mr42365825ad.61.1769448891061;
        Mon, 26 Jan 2026 09:34:51 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:e23f:af76:8280:9d84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61292bdsm86787a91.6.2026.01.26.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:34:50 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] media: i2c: ov02c10: Fix brownouts and power sequence
Date: Mon, 26 Jan 2026 23:04:41 +0530
Message-ID: <20260126173444.10228-1-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-211662-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793CF8B875
X-Rspamd-Action: no action

This series addresses stability issues with the OV02C10 sensor on Qualcomm
Snapdragon X Elite (X1E80100) platforms, specifically the Lenovo Yoga Slim 7x.

Note: This series supersedes all previous patch sets submitted by me regarding
OV02C10 / media stability and cleanup on X1E80100 (including the 'pipeline
lock' and 'brownout' series). Please disregard prior versions.

Problem 1: Brownouts during rapid cycling
On this platform, the RPMh-controlled regulators lack active discharge, taking
~2.3s to passively discharge. Rapid close/open cycles (e.g., WebRTC checks)
re-enable regulators while the rails are floating, causing the sensor to hang.
Previous attempts to manage this via open-loop delays in power_on were deemed
incorrect.

Problem 2: Incorrect Power Sequence
The driver was not strictly following the datasheet power-up timing (T1/T2),
potentially leading to race conditions between the reset pin and power rails.

Problem 3: Race condition on removal
The remove() function freed resources before powering off the device, causing
use-after-free errors if userspace (PipeWire) accessed controls during removal.

Solution in v3:
1. Implement Runtime PM Autosuspend (1000ms). This prevents the driver from
   cutting power during rapid user interactions, sidestepping the slow
   regulator discharge window entirely. (Patch 3)
2. Enforce strict datasheet power-on sequencing with ample delays to satisfy
   maintainer requirements for clean boot. (Patch 2)
3. Fix the remove() race condition by reordering cleanup. (Patch 1)

Changes in v3:
- Dropped the "always-on" regulator patch from v2.
- Added Runtime PM Autosuspend support (Patch 3).
- Added strict power-on sequencing with 10ms/20ms delays (Patch 2).
- Added fix for use-after-free in remove() (Patch 1).

Link: https://lore.kernel.org/linux-media/20260125171745.484806-1-bjsaikiran@gmail.com/T/#t [1]

Saikiran (3):
  media: i2c: ov02c10: Fix use-after-free in remove function
  media: i2c: ov02c10: Correct power-on sequence and timing
  media: i2c: ov02c10: Use runtime PM autosuspend to avoid brownouts

 drivers/media/i2c/ov02c10.c | 70 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

