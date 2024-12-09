Return-Path: <stable+bounces-100215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB569E99CF
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D60F166B6B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252521571D;
	Mon,  9 Dec 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or00Rwry"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B4223C51;
	Mon,  9 Dec 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756258; cv=none; b=Y0em3JYBCXy3LL/wy4ZzzO5OWtNBI5t5YO4fY6wkd0XDtW7WV+FYCbt8ukUIpGJvifdZ6vycCfomXJzRFOEcvhNP3I3l4hxaDZDTGpkBakmlucOMbxton0NEA+RmZfGsYjHPMwfew+gsRLZikIW4RsPQnEYpqGRRBiipgiPTS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756258; c=relaxed/simple;
	bh=tyXlgNbubyZRaCj9ILxBHCYPuAjJPFH1ZFZBP13cEic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbbN/2jD8HTbIGuXHWXMoaquPC4ymxqgmiDcl07sJg6zu0bHmcZkUUnrvSDth288EYSE3VppjFTTYDVd1fsaNL9U52I42gNeIqrC7clc+gIMXqXm56H6KW75pdQVwKAHL+le+0g3XXtWctMQBHLCu18GlJBxaxRdkqSlB9EPFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or00Rwry; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ed193c9eso905438b3a.1;
        Mon, 09 Dec 2024 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733756256; x=1734361056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfOsNmX/F3GyaRLWL8u5H/5XwBzcT0HwpDJYtaGYXhY=;
        b=Or00RwryOFTaSoXKAyCmiZ7K8Fh9m+c7yBT4ddFj+FGZuo3V0nKv4W+k3Ca8Jh+uHk
         cLPt1VPgNorGMuIM6/0YmtrfDbbqnbnZ3Wpe8CbyC67tu3bfyvzGIgVxAdumNurmrVlm
         zxZA8ERUt+YdnHm8DWuDTTHOmQpOpNm33Ei/gD6GtScy0/c+9CtLOyRBsQ9lvwft2Hag
         2L/u03J2urEQUE9Mc6be1vvllVSWeHISKDBmJaw8l4MO3Fk/kY4Y+98KLwGXaSCI6vUQ
         sJCfwdOYwe7TNTowWjhoaBtOGTVGZNTiNubMHjdwiFEXkpNZUwlJnns9ZAdvZvaiwwSd
         DgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756256; x=1734361056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfOsNmX/F3GyaRLWL8u5H/5XwBzcT0HwpDJYtaGYXhY=;
        b=eInG1HxFQKtVOcy50WzL6NwrXPNBTQM727lMPhEAbXpKKCzRTQ9tZsfJaSgX2deb3+
         CDdbDIlLd8zdwMk4oJPHUl+w8HjeqnybGoyxoIs+R821iiW3UGTK5roZ30v9CGcYMQXx
         Fc8/lVLEA6L+01zrRgA2PpCYvXxeOF4gJiMDakuaABPNjqlSfEafsJRyFAwf9wDBtPsJ
         hD+qoIheQ7IjQlKl7b2FaR/h1fwpNmchq2y0SGyRJGFU+Dfgp8VksCIOtXfNgoO46iBz
         DOD+ukrZooz58Sn24YB6PrBMk0+oXTMm/mtRBIiS68hqTpj6JwalpVg44unzu349GyQV
         TSXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7+oZcDowiFCPUjexM1EOFWuaNGqobkxU2/Imcp5vxWDbE3qoa8m8/UYPt7yljkg4ueT1JZdsM@vger.kernel.org, AJvYcCVntQhhF61+TpIwRuJYVrrOCMfzeeiyKASQbRluPX7upodt7qXOt9Dyr4dLRBHlr9ykbS9zzsm9aO96qxQ8MFwLFA==@vger.kernel.org, AJvYcCXe6iq1sKDUyvsXWJ+4IhxCgnI05eSoRiawc+5dBFyv3X6nhfqzjFmYAO8kf3gCVFN7XgLrTaJYJV/fGiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfEKhjQ3C53ucSOp3ZzuvprKkdot+NEHOZ/wezJDQ68u0wqic
	buj5+wKeIrjq3vIjTLgBY7H1WYUamdAGrK6zrdBB+nbC6YOqDXr3
X-Gm-Gg: ASbGncsxaQyV6lFrfiPsazjGFhBxrHvWkSk0TSw8/68B/yEIWMuTezcjxzwgMa9Cx5Z
	t0nC7mxM8c+efVPf0LHpHI4A8aWXmMUfJr0FJMdakLwnq3w7Ve1cSl4TkV6hVrpvFFxSmuxDVpc
	Ds0CIPBAe0IekePjXbztmKQ80/sYfJ+IbWlaBF/Ux7s0XyfBZiE3cHJAoc5uQB9ksOpuxz5HEnq
	nsPRgA+FccCl1S6hUmm4Td4Eh6qHU0PSCaSe1dQgK54DForo9efX0IFQuXjRhNxU7u9BMTUtbXC
	1DQM
X-Google-Smtp-Source: AGHT+IEAldgpnKUvE4CMroLq36NwavshPMhSgqMQYfaMUKqAKEu2cOTGnMzwBOoU2ITkNR6S/HAOZw==
X-Received: by 2002:a05:6a00:851:b0:725:d9b6:3958 with SMTP id d2e1a72fcca58-7273cb1be11mr1036676b3a.14.1733756255575;
        Mon, 09 Dec 2024 06:57:35 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cab713c0sm4565464b3a.33.2024.12.09.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:57:35 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	dave@stgolabs.net,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf bench: Fix undefined behavior in cmpworker()
Date: Mon,  9 Dec 2024 22:57:28 +0800
Message-Id: <20241209145728.1975311-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function cmpworker() does not comply with the C
standard's requirements for qsort() comparison functions. Specifically,
it returns 0 when w1->tid < w2->tid, which is incorrect. According to
the standard, the function must return a negative value in such cases
to preserve proper ordering.

This violation causes undefined behavior, potentially leading to issues
such as memory corruption in certain versions of glibc [1].

Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
compliance with the C standard and preventing undefined behavior.

Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/perf/bench/epoll-wait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index ef5c4257844d..4868d610e9bf 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -420,7 +420,7 @@ static int cmpworker(const void *p1, const void *p2)
 
 	struct worker *w1 = (struct worker *) p1;
 	struct worker *w2 = (struct worker *) p2;
-	return w1->tid > w2->tid;
+	return w1->tid > w2->tid ? 1 : -1;
 }
 
 int bench_epoll_wait(int argc, const char **argv)
-- 
2.34.1


