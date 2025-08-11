Return-Path: <stable+bounces-166989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7612B1FEBD
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD616FE38
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AAD277807;
	Mon, 11 Aug 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D1IIZlpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61026F46E
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890835; cv=none; b=jLqnsEsMV3KQ1TwLDghbwe8Ch4vO2r4pfpuqzxP8LINaopMrdRxKwqHDOUjUwpNl2jMwCRuebMJzI/uC+/U94KMEw5MidC7DHEQ0siUxPcKiqlwGPWUQv21jy4ZAfp7HO6m4Z8UyrxySOEPkD7YVkJpknyeKocavli7bsXPnfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890835; c=relaxed/simple;
	bh=X+DIeX+XsZPowEusZeMzAlLnoQlmyKNcBOTFUWpiNsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2ESqBwy7/UZVtZMzoabae134LC0vf6XAHXzxqNYgqBufLD/Pk2CTA7M0wp8IdHUzPS18/0vbRm0cANB/CVWrkFNqiQNffq1NADiFKHqlxnmUhMwLmBTKehfQR2Q1w4vtKwrw/k5UokcGukk8GagSQ3S83xpOGwvBswnuy0UPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D1IIZlpQ; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e53c490c22so4811345ab.0
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890833; x=1755495633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpH6x8rZ+rgBdQ7TOKJbwRYB5Ad7cxy49v5qCgwdE24=;
        b=IerebrVf7OOJlywMC8UTXURzbMRY9uEEhXwWF8t7ohaeMp0eztuHbYPCk/oPnOdMZ3
         aAtwfBcLdvUCpET3Z7NZib5gJaeZFDVXt2w/c5z+a5l6vcHjVMUgD5wP9dNzTu7ajWAj
         ud7dFy6/yfP/x2PaRUoHsX+YwgkMWtwPJHhDnNo5/KEC7vhJweqmggjbmKm7ZqTlJ/wb
         PRiFswIehQqUrQ198TV1ttYaPSjYmoc7TTwileDqOpnUTG1dWxM9CSUIXQL9o8lpE1i4
         EQrz+MUCt2+8mO7OCedNyzFVkF+nrcGPSUGqdIBLYidzcVFuXwXpFnOLdQMnRBtwAS1W
         dg2A==
X-Gm-Message-State: AOJu0YxVfa6x/abuo5mvWc29FPQtaO81/xLMMqqh4t9dkdqyCzTLrNK0
	BU/WmIivkGJhQzlQpTbsk5+e2H+pSVmLn5n1epEHTdJasQMvlUOK4P6ZnKZ+87/UuPbUy83JhPW
	CpVueDlT8SbrBPBw2+WoSa/O4qQoaaWXFXpRSXWE5let4eP0YTZAprmS+Ie5DMfxDb7s70XVuny
	wwf5m9DzMS9QwCACxyT9b6K3QuezYCOmR4kSlOpMUkYBpdmkVcifT7MaNfnOYya/QVtW0cqBjxn
	UJUa0KCTLNGhsjeSA==
X-Gm-Gg: ASbGncs0kUllwS5zX8LuDwXnFU32g/lhDNTpAIQ9kaqgVmgrVdVAPmVtYVpbahKP5cw
	Z+FvEtj8EVNGnphvYsMjNL6MH4LzZvndpVn4Vd9zGXBaFya0o502KQWzn+dNduNyPWhrki1UYpH
	y5rIETEUmk8Eg70U7wJV9ld2NNoaPgqiKD0qGxAE1YxVMk9LW79FCdNPe5WhtXzm0wQMz4K8Loo
	ipCBRDz+sNWDeH7KBTn7H8U04Udpy+NucWnPQYAg4586c2UGjt1CZRA3FcIIout3qaFaRZoJSQh
	ZhztxDk/RtrPV6ou00X9d2qgn5EBBG9EV028Z+UYRHfs0WbawPBaZtOltJNS9VRmfoRtq9c3v2f
	6xJhdViePz6mrZJX9W6xbYycmfQjO93g8plmcp6JiFfhzWlfJEUvVbaodiBDL6tncK2csJTecSy
	QqWf3Jag==
X-Google-Smtp-Source: AGHT+IG30UhRAzlG01uuXSzPp42KwX/cRrbJdtCP/4jDNdxRSRpG38sz3kcVDkfrukgOUDZ/bz28TJDQFXiW
X-Received: by 2002:a92:cd11:0:b0:3e3:b35a:e8ff with SMTP id e9e14a558f8ab-3e5249b2f96mr211186585ab.6.1754890833344;
        Sun, 10 Aug 2025 22:40:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50ae9a3dcecsm533814173.25.2025.08.10.22.40.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7074bad04efso91412656d6.1
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890832; x=1755495632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpH6x8rZ+rgBdQ7TOKJbwRYB5Ad7cxy49v5qCgwdE24=;
        b=D1IIZlpQlus+l+dkaXItyCYWU4aOG5witaWtn0qdbzAZmqBF5bXnJZXtIXeDrEJUln
         /eNVk52WFqZeuDPafJYoPyzToqre8Pyhmmpq5CL5eEAxNDa0PowMyYr9WWkCQzljWr7I
         oWsFQ/Xi0wyAD/ZG9Q0CCrWim58Iw1kc3Ykl8=
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154030696d6.8.1754890832005;
        Sun, 10 Aug 2025 22:40:32 -0700 (PDT)
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154030466d6.8.1754890831489;
        Sun, 10 Aug 2025 22:40:31 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:31 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2 v5.10] dm rq: don't queue request to blk-mq during DM suspend
Date: Sun, 10 Aug 2025 22:27:02 -0700
Message-Id: <20250811052702.145189-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
References: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ming Lei <ming.lei@redhat.com>

commit b4459b11e84092658fa195a2587aff3b9637f0e7 upstream.

DM uses blk-mq's quiesce/unquiesce to stop/start device mapper queue.

But blk-mq's unquiesce may come from outside events, such as elevator
switch, updating nr_requests or others, and request may come during
suspend, so simply ask for blk-mq to requeue it.

Fixes one kernel panic issue when running updating nr_requests and
dm-mpath suspend/resume stress test.

Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/md/dm-rq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 7762bde40963..a6ea77432e34 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -490,6 +490,14 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct mapped_device *md = tio->md;
 	struct dm_target *ti = md->immutable_target;
 
+	/*
+	 * blk-mq's unquiesce may come from outside events, such as
+	 * elevator switch, updating nr_requests or others, and request may
+	 * come during suspend, so simply ask for blk-mq to requeue it.
+	 */
+	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)))
+		return BLK_STS_RESOURCE;
+
 	if (unlikely(!ti)) {
 		int srcu_idx;
 		struct dm_table *map;
-- 
2.40.4


