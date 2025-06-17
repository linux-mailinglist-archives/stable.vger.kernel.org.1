Return-Path: <stable+bounces-153058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF14ADD256
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559EE7A4027
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11B2ECD0B;
	Tue, 17 Jun 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKxkduTE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F02E88A5;
	Tue, 17 Jun 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174730; cv=none; b=rZyrjRQCVd+BFvfZ4AkV8uaumQXcbfkTsSAAD82ragBefiAtKawsqOk4hj+2CTtmL4aYYrcwqOVyf34fAZS6NSsoAKO9o3l7YJIrJHTKnr1J70soVq5KLKCRGFPJ2Njd7ftsk4RmLlq/PlgVMrbW1TH3hxnXtK5L55/66RjdmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174730; c=relaxed/simple;
	bh=Dxs9SiARaLNgbLYtXrbSO/VzZywDAdc+TVIB7JrWZw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amkWcgNGfrxrrYIesn5YFCH2ai7+qPPW2WvmYQyugnJMs5drNp3QWPUZDFulSCdgJ8HLwiPcEyWSeXHHL/hXAVqacusx/wPnjjKr5Zg1i2xvU/s7eZV2r3tRRIDeQSdlSkMzsbqJwd2fKgv6BQyO72oePQcePC5rQq0O4rSYNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKxkduTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109BBC4CEE3;
	Tue, 17 Jun 2025 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174730;
	bh=Dxs9SiARaLNgbLYtXrbSO/VzZywDAdc+TVIB7JrWZw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKxkduTEzemG+CRQDtff/S1lplXs01m3XkutDLwgD9OtRlP8JO40hKMM5RQ1wvv8f
	 /sq7FEeVI8qNvBrn49zp6xR0b50DgFUehiRG6g8KMn8MIRL5nmoccCHnHv4URQR5n6
	 icXu4NkTClOX4OZ/kcX30rwgURwDXu3vl64NrEGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 034/512] kunit: Fix wrong parameter to kunit_deactivate_static_stub()
Date: Tue, 17 Jun 2025 17:20:00 +0200
Message-ID: <20250617152420.936862081@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 772e50a76ee664e75581624f512df4e45582605a ]

kunit_deactivate_static_stub() accepts real_fn_addr instead of
replacement_addr.  In the case, it always passes NULL to
kunit_deactivate_static_stub().

Fix it.

Link: https://lore.kernel.org/r/20250520082050.2254875-1-tzungbi@kernel.org
Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/static_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
index 92b2cccd5e763..484fd85251b41 100644
--- a/lib/kunit/static_stub.c
+++ b/lib/kunit/static_stub.c
@@ -96,7 +96,7 @@ void __kunit_activate_static_stub(struct kunit *test,
 
 	/* If the replacement address is NULL, deactivate the stub. */
 	if (!replacement_addr) {
-		kunit_deactivate_static_stub(test, replacement_addr);
+		kunit_deactivate_static_stub(test, real_fn_addr);
 		return;
 	}
 
-- 
2.39.5




