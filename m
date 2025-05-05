Return-Path: <stable+bounces-139879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74576AAA171
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486C17AC1DA
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBE2BE7CA;
	Mon,  5 May 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhUOn+Fz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD762BE7B6;
	Mon,  5 May 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483593; cv=none; b=RUT0hLtkNjYPPZLmG5RlTPjZdz0OolsFiGTpNJFfxyComa6k4biD1uUoEJ/AeIfd8k7VOxKGP+tjAFAo/hxGXAg8mYgoifU5ajmvMY85xY8mivbel7/Rx53x9OUL6xU2mTkoZWVYnEUlRIQQ8rVE87+i+j6hdovLLpj4Jao4lWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483593; c=relaxed/simple;
	bh=EB3Z40hdELsKY4Y74mx/U/vMexmdSo9i9XzsGTbvJ3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8vUxUhtBXGAg2k23xh3pc/frrPyFShZeCfed7/ZnoUl7KSnEzRUDiHkUAtRPvft0Zs2LjcKLaSDEfQF1Y4jljpnK6uMQ/MNieS5GqxykqLfHzfMdj5irvSZdClvaAbQiwSdy9GMJz9yiJva3+a4ips3c+9BQrCWOBuyrV4TsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhUOn+Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F2EC4CEE4;
	Mon,  5 May 2025 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483592;
	bh=EB3Z40hdELsKY4Y74mx/U/vMexmdSo9i9XzsGTbvJ3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhUOn+FzNgpeIbhtc3cezsI85oP4MSDkpDwH87AJ4fPfdKX5aAOYGXfTKkhjz7cJO
	 6ZA5wGhXoc3rhoGLyqVnWU06mBTGLGj2YYrgLzGIzD0odSizJrxVzmn4d73nwPBwcl
	 tA2TtzNhge8u1aMzQC7wTCyDzXGC7RHlvvq1Lwr0S2SHV9uQI2AhYV+5CTjuQfy0TV
	 fY26lg8Xo/SvCvafJZhr1YefBRrdzyU5h4n7IJ49truSMiNenK9AXG4Vv0QCk8AKMo
	 7bOtXyG5CcvSo/Pb/LzY4eEG3fBzyUjAbEoonpzGbRBy24F/dCA24cRQDhn1TVEHgr
	 PRLap6i4XojVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 132/642] objtool: Fix error handling inconsistencies in check()
Date: Mon,  5 May 2025 18:05:48 -0400
Message-Id: <20250505221419.2672473-132-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit b745962cb97569aad026806bb0740663cf813147 ]

Make sure all fatal errors are funneled through the 'out' label with a
negative ret.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a29e7580129ed..6cbc655db340d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4632,8 +4632,10 @@ int check(struct objtool_file *file)
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
@@ -4650,7 +4652,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4686,7 +4688,7 @@ int check(struct objtool_file *file)
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4749,7 +4751,7 @@ int check(struct objtool_file *file)
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
-- 
2.39.5


