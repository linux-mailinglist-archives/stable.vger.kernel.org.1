Return-Path: <stable+bounces-92819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600A9C5EA6
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B346282EBB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250D1FF7A2;
	Tue, 12 Nov 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b="QoBMY5hs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CF20D515
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431839; cv=none; b=SrXfrW1SW2R2cEwWZLKC/V62ujZJ7hIXfWKo1VSZn/j9T/8uuA9VPyMHk3Tu4dGgTd0nRONOXNyKgeYm2j/Gpgpry6LxLysFUcp9O7CtjD/G6MB9/4UjbsJEETum/KEEGzm2I+v3HWlOR4N0MoMXa6N0kHPctaqKisT6e+vy9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431839; c=relaxed/simple;
	bh=AD39npRnZp76MJARZ59TlSrkX85P6kcuVPrlIc0qGzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0v0sEdQgxAOwkjxEOPDYzLa2xvSyjKo6YhqAf5wp/2MEQ9Mr1OTgjj6qCZxAilTNFxx8iYK77L/nn7UkpcnqDLOkm8V9wXFq0dwLke1B0njRpzCteoLPvvRoUTJ0o5M+YWz8P5UVjLp2PDC9YvbZVMDGyrPedNldLEWZl06mSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt; spf=pass smtp.mailfrom=jakstys.lt; dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b=QoBMY5hs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakstys.lt
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso8143892a12.2
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jakstys.lt; s=google; t=1731431833; x=1732036633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8QARBTOrEr1jUq9d1+48ytVIG5GO2275wa3LHpCtbk=;
        b=QoBMY5hsEtkMnuRVWmN7KzmWUgy7biTTAen+myFIkEIQWEnLcpvY3poSOtbJtzv/KC
         xuLw+ZKK1KJZQpJ228I2ekia1DBxo86F1nM/COgBln+TK5HMHOcEo/S5ovdTqzYMVeUX
         Sd7AjlrXFUHVOf29iPC+4/mdErPtv4GJ+c2nEkTW8BqYcCcNypluwWwO8RLJXx9HuLBh
         lP2kCOKu1X4YD23BzCjLSozWLmNI3SQ3waVVxlW1sRuWqss348JpbpGgQDWfD6Jo7dKv
         KIhzUdcL9kvBm84gezVBIaUWRYQZVoBjrGy79wLBZVIbl9pXCa9tXnnLoF8owdVLDPW8
         d7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431833; x=1732036633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8QARBTOrEr1jUq9d1+48ytVIG5GO2275wa3LHpCtbk=;
        b=cGlCijckQBzemK9mwRE380lzjjo0fWMX32EmS2paTemIsYMRNEpc4AcFW1YVcvV/lY
         wj3iG95q91L1L3KFpqoOSMply2OFzrRUkLhkXvY44X7oCAAlCK4wUWFgo3HOqE3H4BUO
         DfofzDTWjnMBK2jG4gk08gvPAFDaTxlzCXf6qN7hQpmYJVIeSS8i/i+tr6NchViq6AL/
         9Qa4cU8T/8CLNzrMsrvM1UFH/NeK/asTlWuOXg+vl0huBea3e5GE7rngEWZ762M4WYS/
         c4dHiqvbDJlWwTkf/k92rIYHuN0UvEcqydw5jFOPFAQXpDeNW4WtUwPc7eopJp8cV7CA
         RjBw==
X-Gm-Message-State: AOJu0YwHR+bZifXjqBluNYKNnALL/dlogwZFaHtdV3SiwmJkgKHC4gQN
	//7Zi/6lOJVCD+t5zJXiwZdX3S8dLstCNF2donTaloF/3Nv6YB4CZMZO8QTZ3CFstdbxwDWsd74
	=
X-Google-Smtp-Source: AGHT+IGYlbJj7N4kYrGVX8KXUmt7arrPzVNNdlq9/30jDjCUugJ6j8PXX6SJqd4BL9IhbwCLKjBWUg==
X-Received: by 2002:a05:6402:5192:b0:5ce:d43c:70a8 with SMTP id 4fb4d7f45d1cf-5cf0a444352mr13383988a12.25.1731431832976;
        Tue, 12 Nov 2024 09:17:12 -0800 (PST)
Received: from localhost ([88.223.107.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7fcasm6443923a12.52.2024.11.12.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:17:11 -0800 (PST)
From: =?UTF-8?q?Motiejus=20Jak=C5=A1tys?= <motiejus@jakstys.lt>
To: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Subject: [PATCH] tools/mm: fix compile error
Date: Tue, 12 Nov 2024 19:16:55 +0200
Message-ID: <20241112171655.1662670-1-motiejus@jakstys.lt>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Not much to be said here, add a missing semicolon.

Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
Closes: https://github.com/NixOS/nixpkgs/issues/355369
Signed-off-by: Motiejus Jakštys <motiejus@jakstys.lt>
Cc: <stable@vger.kernel.org>
---
 tools/mm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 6eb17cc1a06c..bcac7ebfb51f 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -420,7 +420,7 @@ static void show_page(unsigned long voffset, unsigned long offset,
 	if (opt_file)
 		printf("%lx\t", voffset);
 	if (opt_list_cgroup)
-		printf("@%" PRIu64 "\t", cgroup)
+		printf("@%" PRIu64 "\t", cgroup);
 	if (opt_list_mapcnt)
 		printf("%" PRIu64 "\t", mapcnt);
 

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.44.2


