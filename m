Return-Path: <stable+bounces-144552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF35AB8FED
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AFD1BC5B35
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CADD25C6FA;
	Thu, 15 May 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eQelwtN6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B0191F6C
	for <stable@vger.kernel.org>; Thu, 15 May 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336978; cv=none; b=KSLGkTaSJLo75pXnq2cIkANq+O/gqwIBabAVALmOT5ty4WbH5uMems0A4FQ5vOInA8rDqPT8fG6erWidRw5ECz0otOoGN3rrMfgDpV575pQLaevFYoPqn0qI4cAONfDAGEJK4uqkopNfkqDyXDt0nbYw6d6FjTjPxBqLh3WLIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336978; c=relaxed/simple;
	bh=96N46iqOIStqCIhFVpc7U2TEDGtEL6hnmfMs56TVuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTAb4VkEilAPKuf65m9IilFSuOp4d7uxX8Pxjoxci28KSrGJLlWH/kNQmF11GiWl6aa7NAZO4VIL3KsL9aa7fA9afTNZIjdvZ2woFPqiZ1CWa7Zz6QCgHK4mSq6M2nPbymlgUYeacoD7cTFzfTh+5kZXroECmLUEvg6se1/e4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eQelwtN6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74248a3359fso1486012b3a.2
        for <stable@vger.kernel.org>; Thu, 15 May 2025 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747336976; x=1747941776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyWm0rF9eCaDvUShSNc7s++hP2H/Glv+MtPcJ7Ax5f0=;
        b=eQelwtN6xcwH2rQghkkeaj12hIAqXyv8M9NeiQZeO4eL947l4e5ddGG7KzLFavkZw/
         oj/uEVfSCYXaDRymncHTSShDyQRDZJNBuMap4r7IMp+57Rzj0ZjtiOTqDvu2XO8RWQg0
         hxJG2TX0vZXZRB1vV7z29+2Ao3ud3jfezDEpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336976; x=1747941776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyWm0rF9eCaDvUShSNc7s++hP2H/Glv+MtPcJ7Ax5f0=;
        b=WZ1Imfe06r45KKfWEE4OEPMMnJIrFPqUin3XPzzwXQi8G/kRApBs3rq4+c5QcUJut/
         27zbmPWQkKejw0N17kur4BuG87jYvvIyfBeNmOVlrpqRcWrgyvsFFMfWmCUzFfpX7+WT
         MbI4j8LA/YSDuhrC7geWewtc+UNdPqb/6pzTZs9DSxp3KfEzX+McZiMlegHeqfiwcsh0
         G4FAyiQaKT7Wtug03BmHASdhZhkTmJ8rR/rG3PLxrq+N1l9Y9oXBzQ7YoIxmpYH6O7Yn
         IZzRIU8UzXfSOQaHGa8ntE02RL2UbgdwoJWcGQZnrdYki4n6s7k+FxCD28a9S6BZJRMl
         Q18g==
X-Forwarded-Encrypted: i=1; AJvYcCX/O5+U7BIYLlXpecL0wIYdpo7BGjgQE7g4QGrDODNu1PB6EdV3JZv7rfcCnqsyrYX6zq0Tly4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOIA1PNrGf4YOj3Q8GOdnSyD3UXmWVBCN3zJvzTDyrUda983m
	Wd+/LCBvKEId3tAFEsPOmqKjs2VwXzs51whve/Bkd1CzyfEdhCCW2bek9vrTe6dyQA==
X-Gm-Gg: ASbGncuXOrJs2odx+zq/W5CnCisPXa6VA0bLLzlMWvzHRuIweI8cINefhwozcp4+tqT
	s10dczOQtAj+AfBAgKPuwy0HR3LGAbMiRPAYg6NvZ7c7dDY6Mxhva9FIh6TKQiwzQE60dFWWMV/
	5zHct/bbVKQJRdw5dGxwX/i5OIjKKUrbBCqTVXnCnS50IGAWHNrXIJkH+4edZbikywY+Oms8p4f
	a4bg/gzc65yMO6Wl+UzeS4TD6Oh98Z5wT9N6N8qPMr5HHGwEID4tuacoM+g6x7nkoT5Aec6ZNr3
	nMVv7JQ4mCIjPLHQisHau20n1ywcGEt6Aib/xv1AnWnvOFQGtGThSTKFssO3unHjyM15P9qHHL3
	b
X-Google-Smtp-Source: AGHT+IGjWfUdXhgZL/hXJdI9mgEh2fOX9YaRz+9pHCBuN/jVr88KABTo2oYP+8cK+POae/uJK9WdVQ==
X-Received: by 2002:a05:6a21:3289:b0:215:df3d:d56 with SMTP id adf61e73a8af0-21621902575mr851830637.21.1747336976503;
        Thu, 15 May 2025 12:22:56 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0b19sm255222a12.74.2025.05.15.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:22:55 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: netdev@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	stable@vger.kernel.org,
	Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronghua Zhang <ronghua@vmware.com>,
	Shreyas Bhatewara <sbhatewara@vmware.com>,
	Bhavesh Davda <bhavesh@vmware.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] vmxnet3: update MTU after device quiesce
Date: Thu, 15 May 2025 19:04:56 +0000
Message-ID: <20250515190457.8597-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when device mtu is updated, vmxnet3 updates netdev mtu, quiesces
the device and then reactivates it for the ESXi to know about the new mtu.
So, technically the OS stack can start using the new mtu before ESXi knows
about the new mtu.

This can lead to issues for TSO packets which use mss as per the new mtu
configured. This patch fixes this issue by moving the mtu write after
device quiesce.

Cc: stable@vger.kernel.org
Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
Changes v1-> v2:
  Moved MTU write after destroy of rx rings
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df6aabc7e33..c676979c7ab9 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3607,8 +3607,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3622,6 +3620,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3638,6 +3637,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	}
 
 out:
-- 
2.45.2


