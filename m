Return-Path: <stable+bounces-4010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2E8045A0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685721F21353
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31F6FAF;
	Tue,  5 Dec 2023 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dG0qx25B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21F6AA0;
	Tue,  5 Dec 2023 03:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABD7C433C8;
	Tue,  5 Dec 2023 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746374;
	bh=JIMgSIZQwmO7J/e7lmuHsPuLrxq3d/RsgiLxkFpyYfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dG0qx25BZIkV+VEngg8MC5917NAW0Vx5kyhIpRhiLY8mxmzWzBo2IBOo/VyWw91Uo
	 hl+2hR3TYwx1cGk2nrPoQv1cfVepFwaOfRgHZCvQmgKp/pttkDhOhP9X2fyRTTfa8q
	 hrPGLqwE1MbR3GE838FnDs88/wQeGdkrpggDd3lc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rand Deeb <rand.sec96@gmail.com>,
	Coly Li <colyli@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 15/30] bcache: prevent potential division by zero error
Date: Tue,  5 Dec 2023 12:16:22 +0900
Message-ID: <20231205031512.402440392@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
References: <20231205031511.476698159@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rand Deeb <rand.sec96@gmail.com>

commit 2c7f497ac274a14330208b18f6f734000868ebf9 upstream.

In SHOW(), the variable 'n' is of type 'size_t.' While there is a
conditional check to verify that 'n' is not equal to zero before
executing the 'do_div' macro, concerns arise regarding potential
division by zero error in 64-bit environments.

The concern arises when 'n' is 64 bits in size, greater than zero, and
the lower 32 bits of it are zeros. In such cases, the conditional check
passes because 'n' is non-zero, but the 'do_div' macro casts 'n' to
'uint32_t,' effectively truncating it to its lower 32 bits.
Consequently, the 'n' value becomes zero.

To fix this potential division by zero error and ensure precise
division handling, this commit replaces the 'do_div' macro with
div64_u64(). div64_u64() is designed to work with 64-bit operands,
guaranteeing that division is performed correctly.

This change enhances the robustness of the code, ensuring that division
operations yield accurate results in all scenarios, eliminating the
possibility of division by zero, and improving compatibility across
different 64-bit environments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20231120052503.6122-5-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -831,7 +831,7 @@ SHOW(__bch_cache)
 			sum += INITIAL_PRIO - cached[i];
 
 		if (n)
-			do_div(sum, n);
+			sum = div64_u64(sum, n);
 
 		for (i = 0; i < ARRAY_SIZE(q); i++)
 			q[i] = INITIAL_PRIO - cached[n * (i + 1) /



