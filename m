Return-Path: <stable+bounces-141359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C0AAB6D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A763A6575
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08991293457;
	Tue,  6 May 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2rvLQQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1C3703D6;
	Mon,  5 May 2025 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485901; cv=none; b=lhpbyCw3EAUZ6C3ZlOtRqTl6pwnfy/RSVicPKiKffixQPJdy6Cqleo/DYOIhuCRNERLFOrrNX0yVKtWjLxs62cBydEpke0uFsVKZ+E3KhsONo2jXG+9PfcPOzg4SIkFntt09gH6+5LEXkM6GcL7VrdDPeVr5ntlRXwdg1VlOaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485901; c=relaxed/simple;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gg4E6/qefx+SK/wOy2BBm4XmYXnns0wKfNG8oq8eaYvIEWsnB+jnKV94xfkKWxcMW5eaizH1a/VGJzO1pz45ATdVdqEytVpo7UhvMetmIuBGja2v6xbxNEf4mQTYVdrcygq+4H8Th6Kli8Jq/j3DRRG+btH44Rj6bzsfM1auaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2rvLQQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA8BC4CEE4;
	Mon,  5 May 2025 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485901;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2rvLQQzRDJ3JsLrKEzd/ot0nZ2Gf34/MzzJ6uWzRWjD+ncZ1w6ZkC/dUwKlb/kfC
	 oyEycdzXDsm8XfTKGTPM+Cf0cSjWGFT1hT8eq5Mr6meSUjmOWpO5MR/iHsqCGkKfpO
	 SoGnRvCYjJRVZ5GB6n+WiryMbQVzyVa4aWWd5dXueTj18Ruq3UTZPHI+UGzG9H9jDZ
	 wFDMSPxCKjakJTuTCHN0Htes/Hg6eormlulUbV7MtMZ6rnCsp2IyHuyreAnbuTM9s9
	 T+S3mjgOL2uGdfLMbcddSk+iETMpKKKH98aq46xwrTib9Ko5dlS81Cy5ELY6yo1zB7
	 xppwSbHuPiSYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 055/294] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:52:35 -0400
Message-Id: <20250505225634.2688578-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579bc..f6c766b2bdf5e 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -68,6 +68,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


