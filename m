Return-Path: <stable+bounces-224856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KHUCbuysmmYOwAAu9opvQ
	(envelope-from <stable+bounces-224856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:34:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB8A271D49
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9987305B962
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D2314B9D;
	Thu, 12 Mar 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="1ECajMXD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504F2F6900
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318808; cv=none; b=qc+f4UknIHNlNHoIlSMusKBxQbiPRCUtGKmZCkQzZ5wGC6LobGS8sLUZLLrfM6c+xGteS/0mfT80Vfh4hRdFZxg2GJ0H/rfmCpdypMg1xKST8aFViaodZLZgH7jx5fGJ94z0FnwBqVg3eFs5wG4ikft7W6/Lwke85bcIasocC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318808; c=relaxed/simple;
	bh=MqTuZ66JzGO8ml01Fq53svdMcGAX8nJcWPrEiuKJVW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqsdTtEsipetOi2r/p1clWXvqy61Burea6OI5b5fI5JVkJsbnA5MWfAYTjnpnOqtR44IHCGXg32i/l67KCHpIAyTPSP0Dc8cCht0EEQMkMnHhMmnAsdESOQH4dOqpTqcOEDjm+TkDGXms/+CiazbIJSFAeIWVOFgOhIYjGr+RXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=1ECajMXD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab232cc803so4993905ad.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1773318801; x=1773923601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxbk04fd4kGg1i1zk9iwOBpm9KQOAzOfMWKxGAIYdo0=;
        b=1ECajMXDBM0f1Jzhvo1yhoIbzb2VLEu31mgr1m2w1ueVuYG6v9gAqy1B8kReg258F+
         +csLK6VeKehqZTa7oQJ2rYak2yp3EJI/E5kLZAbTVFaPzuaRjKzCwdozOkdaNpesi0CQ
         yw3YWqSkb4ekgqM8Em8Hye0DjWdwOsjV2SjQw+VNZtLgMftl1410nFGk51tV/NbwfQel
         XW3qw7hPZxGPsJPMg33PvklSqoOFtsj8DxYUdyYl6XGFL1v9kjv3wMoanPnu2EXr5sid
         ogthGrhRuRQASRItScZhFWxt96mDYv4qHiQROJfyWCLo9FD6QHFpGFbqYiUlW5DA01J0
         EsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318801; x=1773923601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxbk04fd4kGg1i1zk9iwOBpm9KQOAzOfMWKxGAIYdo0=;
        b=ZdnQf/4qzLSdKgb+ptcmZWwhR/lGs9aWvNXIHN/GwNY8kEnxUXYrfxRElsAtARKPrY
         3b3aWCH4uAL2dF0FXObT2xr5orhjbD4Wjoinvb7QoF7Ot+urod86dIuxjfJsQiPoPVs/
         WLtDyyNxyTo6yu95z3/UypzGOPWiZyHyORYI01wYEeNwsDAHva1iUjuVKVvLPOzVUJDQ
         hx7ddprJhZ84SYJYxcIlLnR7tBg4FZtWKVKsOQlMNM+apUo3X4z+7dO9UZEZ6fmjwwMf
         /aaeo8+0rFEzwoQ/KEDGVBtTTFWmCJ6J99voOF4qF+kXN3GAm29fb52q8dxDfpMMmkMh
         up2w==
X-Forwarded-Encrypted: i=1; AJvYcCUPOf5udy4u0odNkz2tevwYolkLtiH4OeSKCbmTggebZ8+bfKcjtQoB9Ii94eqPuMyN552z7N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySoMFjjLRaai2+bamRE3poPifzAUeYpaMSXYtlvmQWwQYmaMZA
	orPh8fn/2Mwxov9M1Gr4PXCDx+9WJJ0UlVpBk2+GdNcEgha56UkkiMEb9hfpAt1fqbs=
X-Gm-Gg: ATEYQzzmgiF1LOr+qZGDiWyABJfuMOUuYo2pEsgl2410L57A1avRK5DoZkbQ6iVR31Y
	7/pxQNmNcsOePpSbJhn2ar2DLoZ6CyT/iU678tGhAwAmOETgLQ4Nl5Pq1wSI0Q3Gw9fcTZXo3aw
	bjyaRLOhtak7aGaNgsAaEJpd1KtNuhFjpPdsvP58X7G0yAX+qAsAv0Q2bPZn7whlO8BSKlJBODs
	QyZEnQ54T0m0uwA5+fz4Go3FkkofClVkr1zzHbh+Z4icRkZ5ATRlzN7y4nR/679tgI1VSL1bapA
	LlR7/0OZ9KPlNkzyQbgARz0NekhRVdf4z5Jr8NF/2elhp6VDxbwDbtGwZdn0GAoAth4YwcsY53k
	+dnCuJo4SQuQ9PK8EQ1cQY6zRurR+RegZwLToyJ8m84DgjTLjkaD6C4HuGgetehAWcBa3dyZhik
	QMq/zr31EK7amLrAFjcdJ+0qJ9G9aAaOi1VDEQrkMOT3hqqKs1BACB8+EjcVhP9JPM8HuaNKDmj
	cWX/OyFO+RPnEOt9jthqGJIKLoMOE+6gvzgvU1rQOIssxIQmaH2iY60tQ==
X-Received: by 2002:a17:902:d2c7:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2aeae78c614mr59713375ad.6.1773318801385;
        Thu, 12 Mar 2026 05:33:21 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.36])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm55220555ad.4.2026.03.12.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:33:20 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: clabbe@baylibre.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	mchehab@kernel.org,
	mjpeg-users@lists.sourceforge.net,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: pci: zoran: fix potential memory leak in zoran_probe()
Date: Thu, 12 Mar 2026 18:02:56 +0530
Message-ID: <20260312123303.73358-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224856-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse-iitm-ac-in.20230601.gappssmtp.com:dkim,iitm.ac.in:email]
X-Rspamd-Queue-Id: 7CB8A271D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The memory allocated for codec in videocodec_attach() is not freed in
one of the error paths, due to an incorrect goto label. Fix the label
to free it on error.

Fixes: 8f7cc5c0b0eb ("media: staging: media: zoran: introduce zoran_i2c_init")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/media/pci/zoran/zoran_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/zoran/zoran_card.c b/drivers/media/pci/zoran/zoran_card.c
index d81facf735d9..f707bdc1fb0f 100644
--- a/drivers/media/pci/zoran/zoran_card.c
+++ b/drivers/media/pci/zoran/zoran_card.c
@@ -1373,7 +1373,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 		if (zr->codec->type != zr->card.video_codec) {
 			pci_err(pdev, "%s - wrong codec\n", __func__);
-			goto zr_unreg_videocodec;
+			goto zr_detach_codec;
 		}
 	}
 	if (zr->card.video_vfe != 0) {
-- 
2.43.0


