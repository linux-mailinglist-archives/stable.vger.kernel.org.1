Return-Path: <stable+bounces-92863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB309C657D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4531F25847
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805421C185;
	Tue, 12 Nov 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cE2mp39U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B2FC23
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455431; cv=none; b=ValRQQgFQRBeUWD/k47weAO0/amRSpzh8NMANuMHlfhdtIDWuSw3l4X8SshUIesGE3RFXkeIMSpFqo7vdpkW8Fak8oS3HGb9W9UGB0SVIhd/uioF2meOO91OfYDXB0XEz8nCN5MpqbmvxW4vdV8CEh7EpSeFPD2FE/v3SxJxsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455431; c=relaxed/simple;
	bh=jGUpsTFomPWWXjw46qZdwcX2deTWeyqCjUsdBykdJDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiYbvY8e2SV67c3C3Kb+agv27iA23uw+x3SsQuSvnUUEfqmzPQN4UA6MeVGzMluOkWIpTQsyeqjcOuKPGrNVrHpM6V8xWZVnwdctElyZs3zl+feh95+taYlb1ENoUvsIF3PZKuqaBoW3b5k/WqKNP7VnOyrf1Chcgk+Ljtv8D+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cE2mp39U; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b13fe8f4d0so400102785a.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731455429; x=1732060229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=cE2mp39UmruhVSbqSdTUKP3ZntEeFK3I/bIBI+xCdVxM36dsMSXY8Fgl9Q7H0wiZar
         9eKOxy5hKMaTQNNoRPNhhIDW4MN1rPCpJFQV8/YVnomW/GZsxNgq1kHrcweAo8HKu794
         TDTF8jic3hUlrlRCZy5M32Mye1MUXPl6+ToN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455429; x=1732060229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=vNo64+jd2DScl3KruY+KBwinaLco41RgYj+3GsajsH/AbxqJ0JgsrYdyltztWPSf4T
         u2n2Ry7YAqPMcgXOVs/1YKEJdyj0g3jC0mj6V9hsShkCLGHdHIvyDNlacVdS+VBHX7d2
         Tp3nHlPPmn2L2yrwfwYD6fFAKnHxyNj08MiGZ1UwzLEfShZNPEouwMLvYzAt2juStKC+
         Esy5a5uy/iPxHkuZt+8sh/xVjWNsTCfFaCa+/TGZoUK0Upc/PnOluY5f1by5PCyKXswb
         xXh+C7VyNFNJhvWFdn4wAU/SQ4RvbViZmABIrDEGPZt9Wc0ArvzEzGITQR0WA/xcD3Mu
         M0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUeFnc+ZmVwARu2vTahv1L3o6m7FiQqkMkKjDigyq847AB069ZCuGywAOTL7ian3dbmDS4M+vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHj9WeGTb1UOEO7uy8jdQoXh4nvD8/SWfhTq0ph8xbgMkONA9
	Cp/ox1VES+1clEJ5914eQCUt3qN5I/m1VTiOkUbLYyG6vpZ2J0CYfnqRTC40w+xPxXojAEbVwXs
	=
X-Google-Smtp-Source: AGHT+IHGZMFCkebkrnfaoDI+6pcdjcBsJC+I6PNu9SuimG9cg17ChQxVCcXVN8XZtd0cIcvmhI+yKw==
X-Received: by 2002:a05:620a:4482:b0:7a1:df6f:3625 with SMTP id af79cd13be357-7b3528cf50fmr98703885a.37.1731455428946;
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae4d6sm640019485a.79.2024.11.12.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 12 Nov 2024 23:50:13 +0000
Message-Id: <20241112235013.331902-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
References: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21fdaa19229a..bfc902d7925a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17503,7 +17503,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24691,7 +24691,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24719,7 +24719,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.39.4


