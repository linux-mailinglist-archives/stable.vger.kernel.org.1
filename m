Return-Path: <stable+bounces-227822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPd2FGKsv2ng7QMAu9opvQ
	(envelope-from <stable+bounces-227822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:46:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF662E8A4F
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAC43011C73
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F21D5CFB;
	Sun, 22 Mar 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeulgSs8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F530EF84
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774169055; cv=none; b=ImgGWv39SQd0gjdn/dQW8E7aB60EPBHanNY1hHcderQHHVnNgNUCzG2HpM+pbpiY3gdpKqprHNdnFBshjSY25dr6MoDt6ds/9fM6hQMFa5Y4TlhVPDBMncVjyXRubE9tLQSSKdBVYMP+AwHdGbXnRtt7EuLBVxdQZTnA1VBLYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774169055; c=relaxed/simple;
	bh=ptUbi7coE8TiCTgvjCOJdhXmMm9zZV1RIxnNmpsvNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMuJ6O7gSNXgbr/6oxOWrN1NXC+kmF23iVQeyxqefVW7KiAWzU33vsqsKMzkOnWYWg7UmmCCnv/7UvH6hh5E3FpxQFJ/0kziZbN2BrqwaokjCgc6rA7dh1bc0lJGhSkTjlLdtic1cmqdKUPAzxG4Ay95mR8DOxcqsHKDwlbcbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeulgSs8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2282501a12.3
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774169054; x=1774773854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=UeulgSs8VLd2x0ryTJwR/BVbAAfsqBRf/MnTpUc8cuTXvNonNkhhbwLVlv2LiMPvr1
         w9ii+MvL3d66uALYSMHrIwubWzGoI/BE+b+ty43d+qgEP5wxTqKYbTCdFGp5ti4PfI0d
         nQPU4CQ1cOoflAkMN421Z6ASt0/B6lD91W0DfDr/v74fAiU+ZgYym8vcIEzdVjD7Qy9B
         MjEIYXGS07eRIbWdnp5UOml6Mwk1FaqhtYN+fKiP5BHFDZ6FxDG1O3fwpLquiRsGeM4w
         2JXo5e26sy/Lud1xZsV5QX0laUSTqdH1UOxaUFsO5ewHUgzB60aQbw+HRIzsM/GBkfY0
         TKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774169054; x=1774773854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=WEktkwoT6ww0GRvVpMsZ0e+SP+8RATjRimTntzxbatrmRC+l3eptIzqWrmGHqToSQ9
         pSamrGaiI2vPMqOQlGu/gFHPH76fOObpPFxJdx52uOd5O0RhUt4EPxR+hY1k54C9E4T4
         kYnQ8SAQ5EFuyO0ITE2mnx5PifxZDUbHMi3C13Aa/tZ3i9SWSkNMaFn2wp+n/fWKdwRA
         qsuSLwT8Q2p4/MkEh9QsK4Ot5Ug7ETbKgKaqObkRFuQ/b9T4YtAq2vEVDjBdHFvbsdwr
         QuKIJdWRyyOeI5vfOBSKdkVGVQNMaYdn01bxJsF8HILVl9kBNK9R3HqQ8+loYXtdHvNI
         9oWA==
X-Forwarded-Encrypted: i=1; AJvYcCW+HGkOaeilCtZ+3o14eMofVAqnNVYZLKS4k4zX/S06GDiDAoDyYGqNi4EfzfoeLqbeLli9b2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHbQDppgwO5CpzFpPjRSNkzlmuvPcRdGrHrZoNnXaz2LcFcAv
	Imva0z7VHwB/TV5L/0cxhkkVLntWFky6FP4gS5INyV9pZ46inpZHdG2j
X-Gm-Gg: ATEYQzxNimSOSScAD6Rodlh65nOtnw0Vu7nhHXW83G19XrBUzpqZjB2iMWbzU2ipYhH
	VV5q061UC31IGFRkMF/ZMTUnboIW+xGmis4BgW1poolDuvQ1Ss/OOyxR4pvuPP7FJ7LdDc3u0rS
	5xR38OlbOyvIDULkpzeIpG9/lv3gdNpwzxjTEFkwZO85aIi3E0mIdHSowK6RllIQHqBmfSAuBoK
	3HNAzn5CH1cTTjUoZ9yEwJ6thEnOjEtBhjP3xRKLISfDI3o/08sSBenBBpH8+7T0YhxwjzbYMx5
	7JO+clfWBHssv4zratXhKR9upTKuSTWRHRy35nPX42mQfwPV1/aqiOlE8MwsF2cegss+KuXeq5X
	3KcWAvDr9TCHEEttL4pMy6qglL010j1yVVNukTAtC/LkgHARsc/W5wM934hzC1YOEdmqu3yncnK
	O+EYxTp4yaQ08Zpwc=
X-Received: by 2002:a05:6a20:7285:b0:39b:e321:784f with SMTP id adf61e73a8af0-39be3217962mr5726304637.40.1774169053537;
        Sun, 22 Mar 2026 01:44:13 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74456fbfb0sm5157085a12.29.2026.03.22.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 01:44:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: 
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] maple: Fix refcount leak in maple_attach_driver() error path
Date: Sun, 22 Mar 2026 16:44:05 +0800
Message-ID: <20260322084405.868743-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABF662E8A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As device_register() calls device_initialize() before device_add(), the
failure path in maple_attach_driver() is reached after the embedded
struct device has already been initialized and its lifetime is expected
to be managed through the device core reference counting. However, that
path frees mdev and its associated resources directly via
maple_free_dev(), rather than releasing them through put_device() and
the normal release path. This may leave the reference count of the
embedded struct device unbalanced, resulting in a refcount leak and
potentially leading to a use-after-free.

A possible fix would be to use put_device() in the error path and let
maple_release_device() handle the final cleanup.

Fixes: b3c69e248176 ("maple: more robust device detection.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/sh/maple/maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..20b7c2cd852b 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
-- 
2.43.0


