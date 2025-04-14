Return-Path: <stable+bounces-132565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C73A88364
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E661892081
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201DA2C2AAB;
	Mon, 14 Apr 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS0jcChJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257D2C2AA2;
	Mon, 14 Apr 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637421; cv=none; b=k/hqAlR+9aH8KIkrPKAgqcTOOaEqVYTPQz6/NpNmfbOfJLKYtIYzCx6gG/NZk3D1RLiDDWoe69cPHQ0fZ6sEwThLoBeDjm/ZpsbjH+QE3jV6AbKyucTCZsSMrKR06eJ19MmKzXAUgV8ExXqeYQ+daQPfBejWdcdPfhe6wPa7bc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637421; c=relaxed/simple;
	bh=mrl33OR0fU4Et+K9HW4K498PEpsbz1M0/gpno/iwQhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhukWIZN4nVDWGOTpgdtC0z+ti0B4xNUJpykRgegnYh1U4tw6TaSNaAtDtTxVjmgzMzoxJonxe9Jg0T21yJuZy/IOTltg3WflRh/lgQW11xqfmKWZlcd1Q/5CwRXQhqVIuKsnmx96B+SXenp2R34mbGAUOjusGfktCBz26OyppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS0jcChJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A065DC4CEE2;
	Mon, 14 Apr 2025 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637421;
	bh=mrl33OR0fU4Et+K9HW4K498PEpsbz1M0/gpno/iwQhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kS0jcChJeZAAPN7dALvcqqCxvnhYQvSbJqL4pYXdqXgXGpBdV5y/n2Mci/GEhwX+X
	 TLj4Y/tsjGmjViAfMj10Y2eub694VTYceRjWxhikPTRD1uZHViG2Efk858DD/4riZN
	 VqELZxlgPAtoYw49y9IPS6LH5x1G1XqC+01tLOFaoiZsTT0XK9Zp/v7NmmDQWQQC1s
	 GocenBYSlDfQ5B/uqHKRBGVNDmsfqaf/0+N5Yeqr3wHiMwBNWcKBRD6P8GdStGrCah
	 t4fPnXsZ7FTzeuvqMbj9eh9Y6Dihj4Rm1w/wSJtz7EW4XEO/VnetT06jjQEYYq3HcL
	 ROqkqgIUDaWFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.6 12/24] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:29:45 -0400
Message-Id: <20250414132957.680250-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 9f9cc012c2cbac4833746a0182e06a8eec940d19 ]

In preparation for simplifying INSN_SYSCALL, make validate_unret()
terminate control flow on UD2 just like validate_branch() already does.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ce841269e7e28c8b7f32064464a9821034d724ff.1744095216.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9102ad5985cc0..78f38a74bd398 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3935,6 +3935,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_INSN(insn, "teh end!");
 			return -1;
-- 
2.39.5


