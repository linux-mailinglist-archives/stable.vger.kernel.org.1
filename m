Return-Path: <stable+bounces-210238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD8D3994E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06BB300D49F
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D022727EE;
	Sun, 18 Jan 2026 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blQ2uLkZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391822F386
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768763129; cv=none; b=YbuzRnMT5/bEIEMewsXh4EVqeczHFrpfbC5z9P2/9fiMKTreyBj4y1pobUID5GkoMKKrYEy4lL8euSq5YaXSVN/lTFjo74wazh/6Hn2A8dslmmjR+cRHsCsn/H69wy4e0HElrf0KDZrnVQ5SLXYBDYnSPJd95g9DZOR1dtEDQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768763129; c=relaxed/simple;
	bh=S8kEIvQIwdZFXzIF8ztDvmPcfyBILoy9bD1nB3RaMDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSXDOjKkooxDyTN8YBF49VzOWz0nzgVy5C8IAKO9VALPrBqPsSLzw3/2fYAX+vRGZsEWoLfsf6iaJTU2dsk1gdYEqrRUs/xWu/raSJYPkJ0jqKLSAS0Tb23eovkOZX6eU01b3B0CTME9pF/pkD7C0/AMZkw+nEzBtrnvbHzR/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blQ2uLkZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfdf0c8908so1598034a34.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 11:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768763126; x=1769367926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1v8LCOXMXHNC92zsw7ixC/eJfK8qg6Eg2mhXIIp5gk=;
        b=blQ2uLkZhtptCdUJY8jhSzg/uL0JhtGVtnTqwuor31oZpCrpuFJEn7SOY8frqE0re9
         B6mxRlXOQ//2ei/FZoycAmFFTcGWj5FIv3GpS7w+aXvtczkzp/6N4nt5GklOjITS5csH
         7bI4SCHFz3gWLMKA3cgFZkHx7B3t68smKCxFO+izkljclGHJbXrHNTy2GHefoNjveuWv
         n+MS35LrvVchrqjoIuUYExhd81DcvxznFFZkAYIdXRb5IRSPm9h2rGk+qWbrVwRY741z
         AOnVOsmjjyNUSrgl00OJ/17SMM3BPEF/Z25VByRALUkqCwygaLiHK8GfA1GZbZ79tJXj
         L+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768763126; x=1769367926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1v8LCOXMXHNC92zsw7ixC/eJfK8qg6Eg2mhXIIp5gk=;
        b=i9hptF202NRFMe4C94MogTlUNqXL0UeZriFi0iUVhWBS964qxqSoczqss3+WXYewof
         rdLRUGrfweGgGnAlVZTe/iziKxtCWr+fhGIep2f16D7xGYKqOplxShxp+D4bg0Tn640v
         PIMgqQR0+gleCt6CzzeOytybeQbQc1ChvZqijP4w8nHRGcbsN1zMikR59AusW0i3lHrQ
         nHWDEekcF0RkIfHHo7Nw0nI9yplk2zKzRTvVLLi/ghcf2W9rn/g+3090pPU+lQVFYbZh
         4cu5f8LqXojqZkA/VWC7mpg/jbzPmoiCe3n5zaQfv+0HbqwtwqbICq3OC7GP6eYF7ql/
         Y50A==
X-Forwarded-Encrypted: i=1; AJvYcCWbVgLIYPxjHxgfG3l6v7vfYskl38N357xemZMuwuE0mw5tuWB1V0h3e+WM2eJBNkTKTWNVqUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mpxKqKtz9i6SNHk0N3Sn3vKeEGe53lYduz/u7rDL8upPdFUT
	Sp4NIyC22Eyvx1H1qtHXLn7GPn0NLO9Xl546SDFfy2y1qI8+R8jIWFd3
X-Gm-Gg: AY/fxX4mFz2uLbvprGYSwUkRnTgUH9XSW9B+r+rx1L1Du72gcIqnjXITos1Io+1hd8e
	vfk+x+qJKORyhnfC++VuyiTgI3Bv7TO7Wdpommzl3ryDPNg6w2efxmH49mImcq41SH6s0RrZKVK
	+IT9zpxHI625DMfc+cgaV5lSrwI7ZsTacpYR6WXmGGnakhfJ5ndxvS/QrYHmw2+oGwkrkdHedQr
	8iw9nRrlpsBRec+4BYVY1TFhQPe9EkY4Sv0vUsyVWrMk+QQfVq4YOnHi3UijoVpRC227shFqZYj
	8ar7UlMrGA+nPAXqui1UH3dAhXpOOCOkGmtPxdL5ivFTEZRIGbZFT1vtcIzkK4VGmSpQkYeZWHM
	Mf34U87vUoIV7dCcWjVry3V33j+I4UpWosE4+hjtyylRPaH3DMc+7gDMYhv3LWhXpdQiK94HsjP
	AWw3rwWWRIbEQ9sB4s4OUDqK5eOFaugSb+
X-Received: by 2002:a05:6830:2a91:b0:771:5ae2:fce0 with SMTP id 46e09a7af769-7cfdee132fcmr4813328a34.20.1768763126190;
        Sun, 18 Jan 2026 11:05:26 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0db2c1sm5540750a34.5.2026.01.18.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:05:25 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: markus.elfring@web.de
Cc: jiashengjiangcool@gmail.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] ocfs2: fix NULL pointer dereference in ocfs2_get_refcount_rec
Date: Sun, 18 Jan 2026 19:05:23 +0000
Message-Id: <20260118190523.42581-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cfd0e0eb-894e-48c7-948e-9300a19b9db7@web.de>
References: <cfd0e0eb-894e-48c7-948e-9300a19b9db7@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ocfs2_get_refcount_rec(), the 'rec' pointer is initialized to NULL.
If the extent list is empty (el->l_next_free_rec == 0), the loop skips
assignment, leaving 'rec' as NULL and 'found' as 0.

Currently, the code skips the 'if (found)' block but proceeds directly to
dereference 'rec' at line 767 (le64_to_cpu(rec->e_blkno)), causing a
NULL pointer dereference panic.

This patch adds an 'else' branch to the 'if (found)' check. If no valid
record is found, it reports a filesystem error and exits, preventing
the invalid memory access.

Fixes: e73a819db9c2 ("ocfs2: Add support for incrementing refcount in the tree.")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add a Fixes tag.
---
 fs/ocfs2/refcounttree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index c92e0ea85bca..464bdd6e0a8e 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1122,6 +1122,11 @@ static int ocfs2_get_refcount_rec(struct ocfs2_caching_info *ci,
 
 		if (cpos_end < low_cpos + len)
 			len = cpos_end - low_cpos;
+	} else {
+		ret = ocfs2_error(sb, "Refcount tree %llu has no extent record covering cpos %u\n",
+				  (unsigned long long)ocfs2_metadata_cache_owner(ci),
+				  low_cpos);
+		goto out;
 	}
 
 	ret = ocfs2_read_refcount_block(ci, le64_to_cpu(rec->e_blkno),
-- 
2.25.1


