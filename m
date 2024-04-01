Return-Path: <stable+bounces-35218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC48942F9
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379811C21E9F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5DE482CA;
	Mon,  1 Apr 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXpsN1VW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137771E86C;
	Mon,  1 Apr 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990682; cv=none; b=QQx77Z68MDzi2N8fqStoULt+0+RYa6HcFmsQDVKBNjTteVp/3CNsLcfhiK5OYMRgY6WKVejmrrioJX+LJ/yK/sC+Ph6CQTuPtKzTEX0S3HwX5aJeKSEi/01W5b8+DCNcR7IfGveTnVlkXzXS5O7CEeTp8EI3UUIJHDI4TJrA4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990682; c=relaxed/simple;
	bh=Usw3Yzr5ZINFu1zowTEsIPRZUBvZgsiQC8N6o/TFMPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPhhGjEk6f0LbigPn6iTRnuweA5bjTfRP9tzhcqvbA81Gm9ThN7ngbtrKnXkIUrWyqm8vntNhG34G2pN+c+aZk03xs0ddhW5mqqI35bPjkaBYvsiWtI9FRowZLEVvIcfV95QeBiIX6EESgY5D2mtKuhP2BLc0jMhDL3wRDcw700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXpsN1VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEAEC433C7;
	Mon,  1 Apr 2024 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990682;
	bh=Usw3Yzr5ZINFu1zowTEsIPRZUBvZgsiQC8N6o/TFMPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXpsN1VW4mw5rnjWzgEENxsUyPJwBwp29HGCDukc/gCwb7xv690fn4Goe2rNILa6q
	 LyD/RbHazN/Ks5kjFYRJVSd76qBqVCYWWcDPZbRQYsGaD6x4w8RMyBFjZGu2JJpsDd
	 6ITiyqhQTFYyorNZmXK9+6Cqx52uKYZ6WUQOtazI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/272] selftests/mqueue: Set timeout to 180 seconds
Date: Mon,  1 Apr 2024 17:43:44 +0200
Message-ID: <20240401152531.436167145@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 85506aca2eb4ea41223c91c5fe25125953c19b13 ]

While mq_perf_tests runs with the default kselftest timeout limit, which
is 45 seconds, the test takes about 60 seconds to complete on i3.metal
AWS instances.  Hence, the test always times out.  Increase the timeout
to 180 seconds.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mqueue/setting | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mqueue/setting

diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
new file mode 100644
index 0000000000000..a953c96aa16e1
--- /dev/null
+++ b/tools/testing/selftests/mqueue/setting
@@ -0,0 +1 @@
+timeout=180
-- 
2.43.0




