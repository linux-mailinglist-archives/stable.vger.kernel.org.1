Return-Path: <stable+bounces-78953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BB98D5C9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD399288E94
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF71D07A0;
	Wed,  2 Oct 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMGQeahB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B01C9B7E;
	Wed,  2 Oct 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876010; cv=none; b=GwqCttC+2pIBjB3AClRNrCrD2FlbLxpEoVWyahg6ANxyNv4A+/xAJNPiZDHMFz+8bP09wcC7NXhQKFEKh5BLdzkcSTJ1oZ1UTFOgZHZJt8ckyuNy+lecyJsrGcAGFJnGUOn6ai7XHQQHIt9OZNOOjKCcppZkwe4ZDC5D4yD9aF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876010; c=relaxed/simple;
	bh=9gQYmkmgZVXIhz9PyKURx7Y9AK67/DLhRwlPrfp7MUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXO/gmqVcXKU18pkKUJj+PnOjKAM3Jvvrrx/rXK1SbOxK9nPIeYc0Sn+/m3J2J11RtD++afYLDe06d0hAM1BLhUC+jPZNosif6b5us2Gzlx5qSThkIQvsDYpdExejJ2ao8slxPTVtST2aDMwQngYywTb9Sd9EidFXM66YH685lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BMGQeahB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8F9C4CEC5;
	Wed,  2 Oct 2024 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876009;
	bh=9gQYmkmgZVXIhz9PyKURx7Y9AK67/DLhRwlPrfp7MUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMGQeahBJwWztppf7zKsa2DARFZt7YiAb6TRD6vjfty/PcTb1+Ti5FlpOZaMFsiYe
	 i+EsJAFPYcq+hylopbzAaymw6LSVdCLvEPZ0pn+RcSZ50hQYLrCxWIjilsMq2lReGG
	 H01lHuJwaaSe/r2+5/OZhN7iBYdbPbM91435hj6o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Hao Ge <gehao@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 298/695] selftests/bpf: Fix incorrect parameters in NULL pointer checking
Date: Wed,  2 Oct 2024 14:54:56 +0200
Message-ID: <20241002125834.336149621@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit c264487e5410e5a72db8a414566ab7d144223e6c ]

Smatch reported the following warning:
    ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 454)

It seems correct,so let's modify it based on it's suggestion.

Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
check in get_xlated_program()") fixed an issue in the test_verifier.c
once,but it was reverted this time.

Let's solve this issue with the minimal changes possible.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Link: https://lore.kernel.org/r/20240820023622.29190-1-hao.ge@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 4230420ef2940..680e452583a78 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -451,7 +451,7 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 
 	*cnt = xlated_prog_len / buf_element_size;
 	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
+	if (!*buf) {
 		perror("can't allocate xlated program buffer");
 		return -ENOMEM;
 	}
-- 
2.43.0




