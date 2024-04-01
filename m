Return-Path: <stable+bounces-34018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E42893D83
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADAE1C21DB1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A2481A2;
	Mon,  1 Apr 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjOnAZP/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCC4CDEC;
	Mon,  1 Apr 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986741; cv=none; b=UtcG0xGp0afMLndPN9YkpyR01PtF3lyZZwRye5wnH+FQB6YRg7WEUaHdGq/8eHQqox3SxEkR7SvcWUEyHEjc2q+0dih27gQHXuV/HhkcLimjxNE7OcCkxfsrSdSRV6I6nqfQOYX1OAAyk3n+d6n2I8n8ai6bc1K1BdFwaxY1qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986741; c=relaxed/simple;
	bh=YqOV7EntSJqHLOoSUlg8x3aP7VUDmrjtP4dYXZNN/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iahq7ktUInB2OuXCbvW3lAc7gVeBH/N/M+A0YhSqEYbCG5FMaYDA0/XOOmDNQQhKIEoAE+/kD1yA8MP+6XEk5E46EsYLeiPupGloZ2hNgD+la7FneyI25GMMTqn4FQNAqmyN7Uw5Y1OM19p/F2Trel7njI5sLlXlG23DpQW+axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjOnAZP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438FEC433C7;
	Mon,  1 Apr 2024 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986741;
	bh=YqOV7EntSJqHLOoSUlg8x3aP7VUDmrjtP4dYXZNN/i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjOnAZP/zvwhfJvILx4F69Tqpqngyo+vRumYSTG01wJlJN52G8+s07QE7w1kCkY8t
	 jPHLhFNbiLOw2ulAyb8xT1yJ8JOKXKkUt6DMJ7t6qcRCpaOSKOWXcOChByG85XfdAo
	 jx/7KJU0tmcM1U6vCwOPheNJF8/SI2TXS/WPN29o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 040/399] selftests/mqueue: Set timeout to 180 seconds
Date: Mon,  1 Apr 2024 17:40:06 +0200
Message-ID: <20240401152550.372423390@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

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




