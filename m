Return-Path: <stable+bounces-191946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1997C26493
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5ED1A64FE2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C93093D7;
	Fri, 31 Oct 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9nHaUnf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8E30171A
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930371; cv=none; b=ZSVwFcBCoizorb7mngXBED4jA5bqrR6bA+av/scxYnCCW5s3DUKIIQp9sz4geZ0UTKCXu57+Rx8VoV6ckLxiq1x/gfrIg0fByMvK4Mm4ZiFFaZzr4VnGvuSA2J6WQX6gbbC+b4XefigSKQIrUzsdD5sTS08D2XpSWfLgvIoJhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930371; c=relaxed/simple;
	bh=QwYo/Yoz+I4T+rZY/7ih9WEmyZPRtgRok11KJciMVYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yl3DdwCEUSB9y5cbHODmamnZYoGkKwfjO4fOJ5aAojMSr2oWLsEK6UdTqa+1RJikKiZTGMqwho9+oBHRw6YzQMa5b9DBcuB9HOF4Wl2bwEtYnR98aPqzq2wEZpS+omzSNhaFwWs2b4swWBS/MJIq2rUowf5LO0Rds4mWaeqg29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9nHaUnf; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c530456061so4374051a34.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930368; x=1762535168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4ljaKFzmW3A8oE1zEU8ROXOLit9Ajx9xtSY2H7jXY=;
        b=G9nHaUnfUjt68aiP/CybRo7KmwBmq0K7B4ZpIEJlRCYW7Fps+ADEwraw2+Mk83Wopr
         //Ba16ZKuIb8LmVrMHN4VGcyZpQ+QKVis+CJxXuAksXD5PhnxTnysN79AZ5k5y6pUxC5
         VjNZr9+ciPUxYapnFnKi9VfN0MEgf8xsEstL5fN3GON0O0tt2GnLI8wMSU1bDw41Faz3
         QFw4iaUCIHgCgda/+/+nCwfe8erV8dOxdleg+ruabOBCH+vS5axxtU3uWnsOGbYAFogp
         m2wdvSjAeiy9MUFpg3PXT1UGyhrY74YuHkPEPPOATN2MH+GutjR4HM2HKDuC3wltCpNA
         +MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930368; x=1762535168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4ljaKFzmW3A8oE1zEU8ROXOLit9Ajx9xtSY2H7jXY=;
        b=pmiEOzIHnGbHQUHh7HlYcJ3KHZdSrlKEvW51vISCm/xzfhpDqIiSIDNZZYcghc/P5o
         1P8HWCn1k6wuvAPOpFi7WlM9sEuu83AdQ4zYy8pMmUxG4ZDXchgTRR9ofqFC+3BROUsH
         pEiCpWCaFEqbt2yXMxS+isZAI4gVX9Xob3BnhP0IlPT6rnNlMbW7vMkGLrqlr6oDn0nQ
         ZIetAurVOXjRP/14Y4/n+xYHfprPMVQCycrKpalMIaCKy6/LYAVW02HrnqwbIU9vWnR0
         UiudaBYLv/zgbrnidzBXS05lyMqU39Wc2lH7qhwJZZCx5WAeq3A8ieCIVgKlOv/W/yaH
         IKsA==
X-Forwarded-Encrypted: i=1; AJvYcCUAMrvBg2SbuTseQVdr644OhOBdrZJ8yJ9Uh+0oF4C7xhHpM5JGI+w0DXWqors2wPu001IK75s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7Wi4iA3KjeAf5BkCT1MG47/yjyfWc5eIKuisAOvz81tzsOLL
	vQMxwxV486QoWiWuNAbluTloYs19ELz8MrivbnzAM33CbQM3xG1CJ3hjnj+0jgvp7GRSOsMJ9OX
	PLbyBw9mG5Q==
X-Google-Smtp-Source: AGHT+IEnJVtmijC8TzZF5pGhOrZATGI47Fj98vUFRBqaKlvcaJ3uI54EHz3UXi30/Su9B2TFuWmC2JYVX9kc
X-Received: from otar9.prod.google.com ([2002:a05:6830:1c9:b0:7c3:e32e:483d])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:6110:b0:7b2:8ab:69bd
 with SMTP id 46e09a7af769-7c696847015mr2109668a34.33.1761930368062; Fri, 31
 Oct 2025 10:06:08 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:06:03 +0000
In-Reply-To: <20251031170603.2260022-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031170603.2260022-1-rananta@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031170603.2260022-3-rananta@google.com>
Subject: [PATCH v2 2/2] hisi_acc_vfio_pci: Add .match_token_uuid callback in hisi_acc_vfio_pci_migrn_ops
From: Raghavendra Rao Ananta <rananta@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Longfang Liu <liulongfang@huawei.com>, 
	David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The commit, <86624ba3b522> ("vfio/pci: Do vf_token checks for
VFIO_DEVICE_BIND_IOMMUFD") accidentally ignored including the
.match_token_uuid callback in the hisi_acc_vfio_pci_migrn_ops struct.
Introduce the missed callback here.

Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
Cc: stable@vger.kernel.org
Suggested-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index fde33f54e99ec..d07093d7cc3f5 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1564,6 +1564,7 @@ static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
 	.mmap = hisi_acc_vfio_pci_mmap,
 	.request = vfio_pci_core_request,
 	.match = vfio_pci_core_match,
+	.match_token_uuid = vfio_pci_core_match_token_uuid,
 	.bind_iommufd = vfio_iommufd_physical_bind,
 	.unbind_iommufd = vfio_iommufd_physical_unbind,
 	.attach_ioas = vfio_iommufd_physical_attach_ioas,
-- 
2.51.1.930.gacf6e81ea2-goog


