Return-Path: <stable+bounces-176592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CAB39A98
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD421C21358
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773630C614;
	Thu, 28 Aug 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFPteGie"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA2EEA6;
	Thu, 28 Aug 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378025; cv=none; b=s8XijwHRfnYOOmdne8rrV1VstSYSvmTW2TEfbLP8o4KD5zHOoLPcs9yeCOlbD3dVBFM4+SW43KtHR32iVJEou7NALdFj2vj5wezm/52T+oIU2LMqlALO0mdlYLHhVlMQcexd99LIDD/r3LsPyuHbT2pcc7HezGTkLvMur77CopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378025; c=relaxed/simple;
	bh=ukKS7ZZ3u/qzYn4nLPjBatLASlISQEt0TGnDbHLRsTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SzqwEKu8GFzMo2/AeL502KavLH6jjnowqbJR0P4tXtmoz586Evmq8muOslAQSwmTXC8xVG2Ld570KvKTW7FcQMrhSaO7/abQoUlgMYAmQITpsDirnndORHgjrV/ovEdWNzzEkvq7bLutF3zISEFS0uvaIfZKbj6Pm6uEZ4jCwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFPteGie; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770522b34d1so1428711b3a.1;
        Thu, 28 Aug 2025 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756378023; x=1756982823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Geto3R8HUYfUSmnEC5IRYIjX7/GVhsDudTJeIQdvk=;
        b=hFPteGieZwIpJe0UChTUoHmXEUSyRqQ0iUtWxKI84UYJXipIk0Ukaenwu1z7ETvTcu
         Xi1QO5lKWFdKFmO9JHx4cSKOcsTOMUfz2+40sk+tCN1eSX9XYL9utVaJz7RXnLvIjmYg
         VUMH8jCHbG7r+3ikQDdKWj5j4m/b/vBa0Huo8ojn8A3ePSWcBi8PpXMM64ji8qyjDtVj
         TSWyZsJFb8eSLkexRFbLmNjibrJyXaQxTIV1nZQg5OiWrZgA7y/oW9mQi4ssdEknleM/
         lFfRgImaLO6ta3S2LvqPl5KneU0tYbkeAGdUZQTpdnwI/HjMKNNkJ4ZBI8uVyqAkzlZr
         mg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378023; x=1756982823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+Geto3R8HUYfUSmnEC5IRYIjX7/GVhsDudTJeIQdvk=;
        b=Gq7qi8QZEmnPNEmgGZiAFRSNj3uXUzV/eW8nhJFkUME4k+odPaBA5i28VBq/HIybX8
         6GCQOuNnaaqNgdISPMJ9A1LcCseV4Ttycsfkd+cBhF5jGFCOKTI6M8C9FujM2Q68/S+E
         kdxgUlRjsMflOm/6bXZyk6b49u0l+DtLz6sQd55WqOMutZSqhOAtCYTApHG0TEMpAUhp
         /u/rIX2U/6o7uSla5EsIczNMWUh7szuG1qUnoaJ/uCPCzdKUBPPJ2esiF2QAtxSyyYkv
         Ld/qxP1ZpZv17PXG61Nkt5orz0y64fqLyy1NECclB+Kh4pYapHHUb5sN3W21wNIzWhM1
         Oumw==
X-Forwarded-Encrypted: i=1; AJvYcCUhntdZF2j2+x7hU3smrclGkrds8SGG0FegaLr8ReCWAdRB2rWG3r1NvKL5d4OohnPACxF0Vpe5@vger.kernel.org, AJvYcCW7kKUf9KvbLG42PyLDz7C7z8mC3Bz0VySoqgtwCdxOJ/giQsm2bip6iEqeqgNo3dbHmrcITz/yg8p/0a4=@vger.kernel.org, AJvYcCWTVX3vyf8VcMtGyzFtGpBIXaoII+E9het1K7Z0soDIjSKfVkdoHf3uvHn6OxtpBMP13wh9qB1rbCO++k/us6dggg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzffMQ7IsfE5+CgaEbUTXccr0Lhlz6fw8ndxupb2V2JcdSY1naf
	KYW1TMIhHqnRD4N+WJDZyRnse3D7aQgTJoHzBHH0BxngWwXQRpzyyagi
X-Gm-Gg: ASbGncsMORqc3L4SLKyYW77Q4XRzTiHi7/9W8F/S08nH5Eh+kPdugCRQnqcMP35q8s9
	wxq9XjB++sZdttUVZ1mFXT26P58wxXVuxD9QsoYkhm5UzAOaCZayL4d6sET+AjrK1BD83NMFMvh
	iJNovhXBnGO/Nb5j02QQvpZHaUTN6OAsGZByX70pm3h87WR234Iq/J/hlp0Hz2AQ5hqzs9kl1WJ
	KKlaV4oseGPaNcgfCkWM+7Il/8UCTXNzIkwrVgFh94qUfT4c9M7BaBzhlbjWs9Cf361ucQlyZXu
	5mohS9J9iFJTcEJ4C7CETOrb4sx5YPPT6WDer4xgFE1ElvOIagSx3s2iK7baKkMi3tEr2Aufjpt
	wPvv8ILov0dr5NPTgZbmHLH+HtAJOF/66BdvUn7O4QDDQVqepN77L7CHwK4IAw6Xe5c0YCZi3/i
	i3YaWqoJaX8/k0dPuDnYQXOg==
X-Google-Smtp-Source: AGHT+IHuqquBlkUNoEyy8h3nJxj6ovCF6+hNgLF80b7TrgDW5gpA2Neqnmsf8QJHC03IHMMKvCZ46g==
X-Received: by 2002:a05:6a20:4328:b0:243:78a:82c4 with SMTP id adf61e73a8af0-2438facf03emr11721742637.25.1756378023170;
        Thu, 28 Aug 2025 03:47:03 -0700 (PDT)
Received: from localhost.localdomain ([112.97.61.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b5d5sm13701565a12.33.2025.08.28.03.46.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 03:47:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] perf tools: Fix bool return value in gzip_is_compressed()
Date: Thu, 28 Aug 2025 18:46:51 +0800
Message-Id: <20250828104652.53724-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gzip_is_compressed() returns -1 on error but is declared as bool.
And -1 gets converted to true, which could be misleading.
Return false instead to match the declared type.

Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 78d2297c1b67..1f7c06523059 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
-- 
2.39.5 (Apple Git-154)


