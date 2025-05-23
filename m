Return-Path: <stable+bounces-146218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3919AC2938
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99929A405BA
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45A299A87;
	Fri, 23 May 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmgGvhJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650629995C;
	Fri, 23 May 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023251; cv=none; b=MXP9qZSgktbtkNm0IYPGIqmSPwPa9ZHK2AYuGAmx9LBo9dy5fPw/oKILVf4lUj/q/tOtstdWWANreRJ4UqGmCC+uoztLsb6aGEmHauChiLAVrvUOcfheIx3AlTvE2iZW4m/jmj0CmnFO/Q/4mCZdzWjswpblqNM32RBuHyV/oGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023251; c=relaxed/simple;
	bh=P17Zfxz2n2RfzH4WAydSBcFAFtqOObw31Vg112Y7hKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMfT++xr+CqY/dXnUjh7aEX76pwnJRtoXzHzen/FPdzyhtTDrou9+KqhN11v4cxNlH64ZnvaWEoOKgYKrNnzrIZfdSDavqK9TbgI6DEbS6b2G3Xi3K9w5en16uFV+EqqnSEGwuZ/6iIkKcDKAEHVyrmQXnpVgMCMcLmHTzhIRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmgGvhJf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550eb498fbbso169204e87.2;
        Fri, 23 May 2025 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748023248; x=1748628048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxVuqRBC1GBPpIyaNgOIVdlRRiSNj7gXg2aZMTV46j0=;
        b=XmgGvhJfqT6TSQYnGmeifJN4N9MtNXy3UZfrqRZV/Xe93XAQaZ5mkiUpwkhLt4hJdp
         LaptWl24UIzqcuqMYmCmuZ5bNszeWpbzgdTQMOxzEu8r0lxSOBU42OAuIy3hQVY1Cmy4
         3tHdrIhENSLQ+g+DDYgIuH3VKG3kC1GdJpihudDWE3bf6coEdlcKI8TK+BV9NDYFssWg
         4CCJbOZB6U14z9PnOcTpiDnRdvvP9RLSTJNUsCpnDH/IhBha5vPeOgHdsQxnFqI91RAe
         AjZqoB3kq1QKIBUWA/EYod9CCEGwcn1OJD0MfTxUEG9uqEwnd+eQ/ZtgiCBitncLnx+s
         yoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023248; x=1748628048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxVuqRBC1GBPpIyaNgOIVdlRRiSNj7gXg2aZMTV46j0=;
        b=UcOZgOHR359Fknut+82zn2BwgfTUxSvlMXEp8/nf640ZUHWrCSgEarBRM3Ku7jtiUH
         ealjNZkLFkSp6iX3ytOMz8diriaYb1fB4XCZSqWc/97zjWrEpBWWG0mfJ1osBkkdR9PP
         q5OygZDc0hoDnh2mv8+N5SYrHE1B25GRLm8D/FxM4p10Ignq5Xnz3HFOjxTQjlm3ttXA
         rLPDWgiEGnG+iL64dGrQTIzLXGVzV/cy0010BSQsuaOlL4hJ7RooyIfo8h5IsMi2oUne
         hIV92QcP2XUsaGY3skun0e2bGW5SKZDIzYWyMLCwowPAjw6XW++NG1U4QNf/6lSSBxZ8
         plvw==
X-Forwarded-Encrypted: i=1; AJvYcCWbBfuqKhntAlb+KBxlqReoXXvB6lIyHIAy+6YL+2Cndie8njCP8r3nr4o61SjjI8ROHI/lWwav7+3/cEA=@vger.kernel.org, AJvYcCXF6SUPieM7Loge9NzFpVsb63Hlo3imMkBx/A7JZ5ipd1Cg2fxMGoOlawx8V9Hakbbv6flrqdHn@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6w23Pn1vp7+YPcjbWON9P+KHRV6Bh1N0P6Atznol79GY6QCZ
	PYeeiklTC0QSsikVxH3bw4tfDijqAv2tsfuDzzF6une1qhGPwDj7/kPY
X-Gm-Gg: ASbGncsqF2tHdTVhSPbaXhhNCDckcBgnMtG8cK/VOpoYJFgh0T44s5e+c0f2/QNhVkq
	/KCQFjYlFB4f1dviZvauorB6MCf9Uq/sDvRSsi6VKnlkN7y+/dSLKK2jrDJewL5ate/4yzCtMEy
	ONornTPH5heul5z/75kxWgrAKOH1BE+af5vN7Xk8EEnTb0Nz/Ez1+iFHLnOGadOcjCHBLZdssCp
	A6A3Uk0jaZooAK4/52yw4ZI/425UU+Ei0hbP5m2lzZ+n1OJZJl+S96VR7SoY21h9JVapVQMIi0j
	IyengI4BVJ4RyIfkfyEgru6fBz+EWibLyz7OqVyN8bqbB+AZFCurdCe7otIDIeWIG6My3DRvUAS
	pXWY=
X-Google-Smtp-Source: AGHT+IEE1zg3DVaFvcNyPaaw6b4BYZM56iOOj2+zeBW01gJZmH3b+cTO9ttWG5h1srT2FQxw42y55Q==
X-Received: by 2002:a05:6512:b8f:b0:54f:c055:dd7e with SMTP id 2adb3069b0e04-5521c7ba351mr113411e87.31.1748023247387;
        Fri, 23 May 2025 11:00:47 -0700 (PDT)
Received: from localhost.localdomain ([176.33.69.152])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f3148csm3943316e87.66.2025.05.23.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:00:46 -0700 (PDT)
From: Alper Ak <alperyasinak1@gmail.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	alperyasinak1@gmail.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/1] pds_core: Prevent possible adminq overflow/stuck condition
Date: Fri, 23 May 2025 20:58:35 +0300
Message-ID: <20250523175835.3522650-2-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523175835.3522650-1-alperyasinak1@gmail.com>
References: <20250523175835.3522650-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit d9e2f070d8af60f2c8c02b2ddf0a9e90b4e9220c ]

The pds_core's adminq is protected by the adminq_lock, which prevents
more than 1 command to be posted onto it at any one time. This makes it
so the client drivers cannot simultaneously post adminq commands.
However, the completions happen in a different context, which means
multiple adminq commands can be posted sequentially and all waiting
on completion.

On the FW side, the backing adminq request queue is only 16 entries
long and the retry mechanism and/or overflow/stuck prevention is
lacking. This can cause the adminq to get stuck, so commands are no
longer processed and completions are no longer sent by the FW.

As an initial fix, prevent more than 16 outstanding adminq commands so
there's no way to cause the adminq from getting stuck. This works
because the backing adminq request queue will never have more than 16
pending adminq commands, so it will never overflow. This is done by
reducing the adminq depth to 16.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250421174606.3892-2-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 2982e07ad72b48eb12c29a87a3f2126ea552688c)
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index b3fa867c8ccd..c2ef55cff6b3 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -413,10 +413,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	if (err)
 		return err;

-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
+	numdescs = PDSC_ADMINQ_MAX_LENGTH;
 	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
 			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
 			     numdescs,
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 61ee607ee48a..421371408503 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -16,7 +16,7 @@

 #define PDSC_WATCHDOG_SECS	5
 #define PDSC_QUEUE_NAME_MAX_SZ  16
-#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
+#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
 #define PDSC_TEARDOWN_REMOVING	true
--
2.43.0


