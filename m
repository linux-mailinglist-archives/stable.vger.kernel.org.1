Return-Path: <stable+bounces-9651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF398823E26
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01021C214D2
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268881F5E7;
	Thu,  4 Jan 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqdmN48G"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0A208A8
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704359169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=GqdmN48GbQsKvAsibSdO9FcS+k2OR3rSI3qZk0TgstQA7HpSedVJ51l4KIpLTgwlEL1FFs
	Ek8Je3oRxZLemMqtD8SCEhGfq8r3GCQjnW34ytWn9FQsBf8YFFLdRDAoqyDaEph2AOY9iI
	IGTQrr87OE57WCXxcPYpf6oDXMLKz+k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-4O4Yu5mJO2SX-Gl-M8ydAw-1; Thu, 04 Jan 2024 04:06:07 -0500
X-MC-Unique: 4O4Yu5mJO2SX-Gl-M8ydAw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d87d87654so726325e9.0
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 01:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359166; x=1704963966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=R/GluhMu4p+PezABlPUrqrZZ15fM7YiI1rBonVYWIEiv7eZES5labzfxHdC2/Dt5M/
         Cgf8uUGCbZ+QAsCZ7dHqcOAIfv1EoO8+jzADOmBd/PTpVCWIOc0lftKuh8QgNn2EtACY
         uWYac4zhqvgmNnKaU49xspVkBH54CEEpqnV0dKAw1Iz8BnXgWASZrkq5QK5Y0k9wwRiD
         tKyw/OluDiArX47jhWSxV2LANVBIUgTWHPLVsR06LRFvNtUPD36N+nAzTG7PWWs2vSK/
         vR9qwoP5kK54RNPEYP5ar7lrupPmQf/tyOU3gsKGEvjZjTxziii9g7u6raoXwl/L4GVR
         YtnA==
X-Gm-Message-State: AOJu0YyjxEdfkprEabYv1OIwTi1iwKhjI1scgok8BS3TcsJTfdeFXojh
	5TGbN20RDDp7JuaSwcQzYslofmHfsFjvoP3E2Bh0zK4zxNLfuIQxTQkly3vv7oNldWHomrsRoyW
	pqJFfGMPxNF5v6pt6s+tCC+2W
X-Received: by 2002:a7b:cbc9:0:b0:40e:34d3:8f19 with SMTP id n9-20020a7bcbc9000000b0040e34d38f19mr330841wmi.1.1704359166751;
        Thu, 04 Jan 2024 01:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwL8Buv1shzGGOWOGgnChO26smQj4LvrqxVkJiXCoS1SzxYqEnA7OUwGXm4mJelRR0UVK9CA==
X-Received: by 2002:a7b:cbc9:0:b0:40e:34d3:8f19 with SMTP id n9-20020a7bcbc9000000b0040e34d38f19mr330829wmi.1.1704359166445;
        Thu, 04 Jan 2024 01:06:06 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040d8cd116e4sm5012644wmq.37.2024.01.04.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:06:06 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: stanner@redhat.com
Cc: Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Thu,  4 Jan 2024 10:05:36 +0100
Message-ID: <20240104090539.10299-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104090539.10299-2-pstanner@redhat.com>
References: <20240104090539.10299-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
is within ioport-range IF the config specifies that ioports exist. If
so, the port should be unmapped with ioport_unmap(). If not, it's a
generic MMIO address that has to be passed to iounmap().

The bugs are:
  1. ioport_unmap() is missing entirely, so this function will never
     actually unmap a port.
  2. the #ifdef for the ioport-ranges accidentally also guards
     iounmap(), potentially compiling an empty function. This would
     cause the mapping to be leaked.

Implement the missing call to ioport_unmap().

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/pci_iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..6e144b017c48 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 	uintptr_t start = (uintptr_t) PCI_IOBASE;
 	uintptr_t addr = (uintptr_t) p;
 
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
+		ioport_unmap(p);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0


