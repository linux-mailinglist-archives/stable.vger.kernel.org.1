Return-Path: <stable+bounces-78583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBC98C750
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E148E286203
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5E1BD00A;
	Tue,  1 Oct 2024 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi/3XU+l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527114B972
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816972; cv=none; b=qvJrWoyaxwCANrHklwztwRSWSTsk3abXeL3mFafenq0MWmGm9Z/Fr7a+5WpWLOugCdr1w8/oODxGHyO732EIg4h6YhKAeqbLplG5ZmI+Qw44yhn0HjvYb4A2LuR901E27FFlC6Xkif3jEYh88gO1HfcazSrsBOSQ2Fuc+VTxeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816972; c=relaxed/simple;
	bh=PdoK5q9uudg99L5nTdeisnRuv+3cJb3MgbZm9wA5SrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1VZiEb/q9dA8L607mQ2nliWzJ75pt2EDC9NllK+KLT+Z0SazIxsfA9oRq1+rgwp3W8KIHzcVJK0ZFna6hM+vX6LbIvrUuTyWjoJEVAjW7pAnirCsIXMD2Eus9Ud/faeybtkWL3xnL5OuAPzS2Yp0u62HoYSlKKwcz7WDdPyCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi/3XU+l; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-208cf673b8dso60806035ad.3
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816970; x=1728421770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCCAqs9pJHuT49eiaRee5PgHVSfy9yOd03j2lpWuHmQ=;
        b=Bi/3XU+lGLT61VxxqyuRpx7hwIdc1TzgkSeXhhHA67G5hocy4aiq+GJ4Os6w/SywTs
         b9WVje8PPM036bLlLrACscAFnEHXR0+jEQ+Z2JeKKWjbgjKi7/0jtvNRzUOpH9ih2Jp3
         nZoSlxL5KW0Sfpg6e4O/ab1zvYFAwGTDcpGf6irrP4JbIakRooeQgn3FKAI89kS7q84T
         0rR0UH3sQn5NN5TftYqcVPOUwkTN0FuVnlxaZV1aFfIbVFQszUrHMedWEKpwe7SNerp1
         oARTeoVCstLkCocBY49FsOc028qdIjwfAfc8fufLIVvHOEmb1EOVt9vaHKc5Ghvpsuy+
         YTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816970; x=1728421770;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCCAqs9pJHuT49eiaRee5PgHVSfy9yOd03j2lpWuHmQ=;
        b=AAHS0AVOpGpL1ER8Hl50BrajhgUIdU0z+ef2sSihOKRdwTgbn+CWhj0nj6Co4K/f5j
         eJDYOL9MOiuNV+VR+T8X0gyD6BEk/KiZLf2iP5n/blBdwV9p3LN3fh73re2CHauwAJcw
         PNTMBES5PtPDCo5xycEOLdtdIvD89o7hh9IqEbhfTL0jz+KcbwQj2UTeHh+svZco3kvf
         7yjPt3GwtWNKwcHCuynTRkJP+zLDyTPF1WcK5qhjdgBs101pK/EzdXQdeQ4u+BPO+ypO
         aPndlBsgbMAMnbfbix+AAfwKADymBi6qYkYTaXkSj8vdMkOtsDtQAEj/viWHAPEP0Jnq
         RM7w==
X-Gm-Message-State: AOJu0YwlYWovlWBLReBRoHQnavjifaMd0lQ4xj2yiAeLGU+R2D/anRwr
	v4uMp9Ur5uGK8EruHRXy3AwAxVKyA86Q/6TaDcW6Qg0aA/wLs7mdj6gt7ttAg/0=
X-Google-Smtp-Source: AGHT+IHajQOPWDBkxJzUug8xXA3uwWpDN5SZryzyESz6gH05/7vB3YhFgJ6od3pmXyrdiKmR7a8A5w==
X-Received: by 2002:a17:90b:104:b0:2d8:b91d:d284 with SMTP id 98e67ed59e1d1-2e18468c3cemr1237842a91.16.1727816969818;
        Tue, 01 Oct 2024 14:09:29 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f798037sm34307a91.25.2024.10.01.14.09.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 14:09:28 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sam James <sam@gentoo.org>,
	Daniel Dao <dqminh@cloudflare.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption with large folios
Date: Wed,  2 Oct 2024 05:06:22 +0800
Message-ID: <20241001210625.95825-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.46.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series fixes the page cache corruption issue reported by Christian
Theune [1]. The issue was reported affects kernels back to 5.19.
Current maintained effected branches includes 6.1 and 6.6 and the fix
was included in 6.10 already.

This series can be applied for both 6.1 and 6.6.

Patch 3/3 is the fixing patch. It was initially submitted and merge as
an optimization but found to have fixed the corruption by handling race
correctly.

Patch 1/3 and 2/3 is required for 3/3.

Patch 3/3 included some unit test code, making the LOC of the backport a
bit higher, but should be OK to be kept, since they are just test code.

Note there seems still some unresolved problem in Link [1] but that
should be a different issue, and the commits being backported have been
well tested, they fix the corruption issue just fine.

Link: https://lore.kernel.org/linux-mm/A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io/ [1]

Kairui Song (3):
  mm/filemap: return early if failed to allocate memory for split
  lib/xarray: introduce a new helper xas_get_order
  mm/filemap: optimize filemap folio adding

 include/linux/xarray.h |  6 +++
 lib/test_xarray.c      | 93 ++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++--------
 mm/filemap.c           | 50 ++++++++++++++++++-----
 4 files changed, 169 insertions(+), 29 deletions(-)

-- 
2.46.1


