Return-Path: <stable+bounces-6593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420A811235
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D116D281F0A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F02C1BC;
	Wed, 13 Dec 2023 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5rvBkq7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE172EA
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 04:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702472399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wFCv+0tZaZnz6YeZzK8hxOwjz0J3Dsh5vJIVe/dhdnE=;
	b=L5rvBkq7WhtTSAr5d60UpyQkuONVIJszllE9YfmiaablMmK19b5Of86TWIgU+CBxQQVrE0
	iU769KPoCmTn9+BWqI3OP83FfRYe6lyvJIMrAN8wGULRwSc0x+VN5xW5Xn6fOochAoayWx
	h/idZuqlyQMGsCasW7MA5WfSNyUzzHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-_1ewMQSjMia1L5Y54fo5Ig-1; Wed, 13 Dec 2023 07:59:57 -0500
X-MC-Unique: _1ewMQSjMia1L5Y54fo5Ig-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c2c461e18so11757415e9.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 04:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472396; x=1703077196;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFCv+0tZaZnz6YeZzK8hxOwjz0J3Dsh5vJIVe/dhdnE=;
        b=j0i9HG/JhUsVI0gstO9ON0sqvdmTjbn67culHZ/qJ0UrhKaj1vMHkTkDwkDSEjdav3
         /tskpDh5HedjYPM/MtWphXgauzfBTG40fxlkV9zAPgePxIbJSiudtJ4wdfiHTRmd1W9c
         GpZWBECa62gWP2jJtXPUYZ69IPRZ2rVR0UxKJtMEe7sfc+uNtfSNiok5bVtaIsnYybzm
         taCHd3ykN6vYBFfnDsM7leXiCymC9NSOv/oQZlIw6X9/rGEzBmGa8ROG6zEW1WQWB9k5
         j6NSVXkhRrKNPYpzjkBQuYLVtm9Oq6AJ7H/HArCg7rL+oAfK3X260jH+zEp7MKu6Lt5R
         FUKg==
X-Gm-Message-State: AOJu0YwJQoagb5cFduKwxvSqeEBvjRcWgeZg0KxpY4WpZlAgw9q0u4Dv
	VKGBlDNT4LdG02CbbuLLmrWW+tSm0ZWcWIJVXwU/TTBWCTMQfoBxFEBxusjoL0m7NIhPqhLOB9A
	p5ULLvCHA6R9Ez/Rj
X-Received: by 2002:a05:600c:511a:b0:40b:516a:3856 with SMTP id o26-20020a05600c511a00b0040b516a3856mr9749072wms.1.1702472396613;
        Wed, 13 Dec 2023 04:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwXql9nJbq7x4v2uy9r9nzvBcsRQ6cZzXgBsR4vsn2vk2qU4KbpFlHbt/UWL+c1VfSst1fYA==
X-Received: by 2002:a05:600c:511a:b0:40b:516a:3856 with SMTP id o26-20020a05600c511a00b0040b516a3856mr9749062wms.1.1702472396246;
        Wed, 13 Dec 2023 04:59:56 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b0033609584b9dsm13081881wrq.74.2023.12.13.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:59:55 -0800 (PST)
Message-ID: <74219796e91675c533daea6a2a6afc6d06fb7461.camel@redhat.com>
Subject: Further cleanups for pci_iounmap() and lib/iomap.c discussion
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Philipp Stanner <pstanner@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Uladzislau Koshchanka
 <koshchanka@gmail.com>,  "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>, Rae
 Moar <rmoar@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury Norov
 <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas Gleixner
 <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 dakr@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 13 Dec 2023 13:59:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hola,

This is a discussion about whether we want to move lib/iomap.c and
remove the remaining pci_io(un)map() definition of s390.

That would be followup work on our pci_iounmap() cleanup [1] that was
discussed here [2] (but is not yet merged).


The summary from the last discussions was:
 * GENERIC_IOMAP is not generic anymore, but x86-specific
 * All (?) archs should be able to use generic pci_iounmap()


I've been looking into GENERIC_IOMAP a bit and am unsure whether that's
true. Notably, powerpc seems to do something with it; see
platforms/Kconfig:

config PPC_INDIRECT_PIO
bool
select GENERIC_IOMAP


I've had a few ideas, but don't really want to pursue them until we had
a discussion about it:
   1. If GENERIC_IOMAP is really x86-specific, that should mean that we
      could move lib/iomap.c to x86 completely, since that file is only
      built when that symbol is defined.
   2. If it's moved to x86, the question arises whether it's possible
      to provide exact variants for lib/iomap.c's PIO_* constants. The
      comment above them in that file hint at those being just rough
      estimates ("assuming that all the low addresses are always PIO").
   3. To really just have one pci_iounmap(), we'd have to jump into
      s390 and replace its pci_iounmap(), which might be a bad idea
      since it also has its own pci_iomap().


So my tendency would be to leave s390 alone, figure out what's going on
with powerpc and then, if possible, move lib/iomap.c to x86 and
consequently have the second "generic" definition of iomem_is_ioport()
from asm-generic/iomap.h removed.

Ideas?

P.


[1] https://lore.kernel.org/all/20231213104922.13894-1-pstanner@redhat.com/
[2] https://lore.kernel.org/all/619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fa=
stmail.com/


