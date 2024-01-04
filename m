Return-Path: <stable+bounces-9653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7B823E34
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 10:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FE6B2396B
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD9208B3;
	Thu,  4 Jan 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr7SAUqx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536D20322
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704359246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=Pr7SAUqxYRK/Ic3MQtOTVajIXgzT6vddh1Xu1NxeMgCFU0C7L7fiUJn6OUOelq3im9hEyk
	T7os/DUsB3uLeqRYj4cEg3tMM6l6QgpMAeY4p+SB3MiszkJheft8FnIde87tivHEMGhwWv
	I7gb6uOjhk/wUSwUDtr1Ns9B1ZmJoA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449--txIzPRwNq6aCe5Xu90V3Q-1; Thu, 04 Jan 2024 04:07:24 -0500
X-MC-Unique: -txIzPRwNq6aCe5Xu90V3Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so68885e9.1
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 01:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359243; x=1704964043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=itxbUYjnrLHQ+ESsJxx+Rba8gTrjfgAUAyEdicm3491WOQ5R+gyTaULNHHvTmL8wY2
         kMjFvzZL7kMweWkWPYmuwWREUanKERS9TEphlt6j91oMDBMAUEewqsGXAWs168qEVGth
         YzeusR+iRLvkXzDlJeyrNkK1+9ELUityvPia9nP3+/6Pu8ZLHlccYc03C+1qHMtxzauJ
         Xa8ic5uXlDTVz45435mEa4UfMQnMM5IPyVCRM/ddptTwbzAD79SaGMuWv4dyynWAviKZ
         fARGD+sbDH2LqjZwi6PEqcJoS3O3MGn05IxLf294GuVU9J8Kw2NlYngMsdN2+8RXd0uU
         9j0A==
X-Gm-Message-State: AOJu0YzwgoHF0dI8zF9WtfqD0CV5bHYjzThragDxItWIwDBBQy38Npeg
	7r+VU8XajB/xf0TNHS9kJ7/eOSXAnlGcztpf5Xhq4w4Vo0TnpoXqVK4PPZlPbKahglWre7GNQ3G
	1tsQWj3C7lM/aNX574y4fB8zT
X-Received: by 2002:a5d:5f95:0:b0:337:3cf6:ed4c with SMTP id dr21-20020a5d5f95000000b003373cf6ed4cmr443080wrb.4.1704359243220;
        Thu, 04 Jan 2024 01:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzNqzW8kqtKPV62b5Zy3H304bH+UJk2Jf9aXIbT0CMRfAzqN9DqxRHxNyFzZiNtek5M5OJQ==
X-Received: by 2002:a5d:5f95:0:b0:337:3cf6:ed4c with SMTP id dr21-20020a5d5f95000000b003373cf6ed4cmr443049wrb.4.1704359242584;
        Thu, 04 Jan 2024 01:07:22 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d430f000000b0033740e109adsm8720864wrq.75.2024.01.04.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:07:22 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v5 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Thu,  4 Jan 2024 10:07:05 +0100
Message-ID: <20240104090708.10571-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104090708.10571-2-pstanner@redhat.com>
References: <20240104090708.10571-2-pstanner@redhat.com>
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


