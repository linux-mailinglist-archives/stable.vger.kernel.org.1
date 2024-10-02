Return-Path: <stable+bounces-80194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56398DC5E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDF8B2651B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171721D1305;
	Wed,  2 Oct 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4y1xDX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95651D1302;
	Wed,  2 Oct 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879658; cv=none; b=aI6Fid6U2Fvro843APuBS6OWZhcD/eZp6FS+ezMUp/rv8q126HmyGsCHbETZd07j3Ae25jWsQ361ej/Q/EI4bbb2eL8p3ubYOxcN2XlbNO9zq/b4Oc7HIFk/68cMRYY7BsoWLK7sCHROuUHMhWoPf75TzgOX4uBA54JFPiSuE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879658; c=relaxed/simple;
	bh=qqDTZmpHvUh4vHTQ20uFYL3eY1Be6CDGmEcXkoFHRho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACoa+e/+Wv+beXHlUImonm7cqAkZvVKSVTXOODERyQIRO/cReULII9yqp1OShyeTXPDuzOPrVbWK3iEdM/3+mPCSFC03KubixEP1ggPhvtkkqQsWfD8UyiD3bOX/ZsLGgYHZDStzubflhbU5U6RndAquKnzHVOILQ4ubsv7dGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4y1xDX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B39C4CEC5;
	Wed,  2 Oct 2024 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879658;
	bh=qqDTZmpHvUh4vHTQ20uFYL3eY1Be6CDGmEcXkoFHRho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4y1xDX5rXjkULJaTVTPX9rDVwAZtxvY5cBlkNaKAGJpsSUKnZFZuOOiU9BvxNNug
	 V+T3x10rNC1GfZHo0YTuDENGmEMo0oanKRXbEyTtVfZ05+CeBvWTX510K4ov9Bfwbz
	 6F3qZnyaSwE7oNOiAwHsPTDYOyfmEORfUJ1S8Cmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 193/538] selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
Date: Wed,  2 Oct 2024 14:57:12 +0200
Message-ID: <20241002125759.874423936@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Ambardar <tony.ambardar@gmail.com>

[ Upstream commit d44c93fc2f5a0c47b23fa03d374e45259abd92d2 ]

Add a "bpf_util.h" include to avoid the following error seen compiling for
mips64el with musl libc:

  bench.c: In function 'find_benchmark':
  bench.c:590:25: error: implicit declaration of function 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
    590 |         for (i = 0; i < ARRAY_SIZE(benchs); i++) {
        |                         ^~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: 8e7c2a023ac0 ("selftests/bpf: Add benchmark runner infrastructure")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/bc4dde77dfcd17a825d8f28f72f3292341966810.1721713597.git.tony.ambardar@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 73ce11b0547da..b705cbabe1e2f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -10,6 +10,7 @@
 #include <sys/sysinfo.h>
 #include <signal.h>
 #include "bench.h"
+#include "bpf_util.h"
 #include "testing_helpers.h"
 
 struct env env = {
-- 
2.43.0




