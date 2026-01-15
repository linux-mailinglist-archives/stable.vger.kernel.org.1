Return-Path: <stable+bounces-209388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8BCD275FC
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB17D3320014
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594D3C008E;
	Thu, 15 Jan 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMZoJDx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DD3C0081;
	Thu, 15 Jan 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498554; cv=none; b=neKNgECqUAvqV0jbC8q6aRox9TrgqvAt+NRF+1H4J1cp5twY3deA9JbX2C9wnQxo+mXkbPcR/KxTDdnfC4jlnr9jTFWnZr6nCuKB35dRaYIZW+kiobw9K7be2PDbQlDLXlUtXmK+6U4ota82UAaG/rgAQpBFh/812vVyWn59u0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498554; c=relaxed/simple;
	bh=PEkeuY4UXTXErZLVTaFaAfzxQmfZXGJVvVXD9t3un4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax68TR7h3r2aQAuiRReZ1Zaj/JNqZXNSp98vVoVGEfZELUXfFJPQhOuTv7od78gbmtxzXxZQEU+Lr5JOb9ubZaNu7fUCJfyQK2aPMRj3sKgrYAI1DE2IjA3VmTQji2D2lI4oybj+ShvVMCuvJamwVYpzXn1JVDsNk5Nm3359YpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMZoJDx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DDFC116D0;
	Thu, 15 Jan 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768498554;
	bh=PEkeuY4UXTXErZLVTaFaAfzxQmfZXGJVvVXD9t3un4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMZoJDx98KpSNdLeubPBw96jAhFiuXf4H2RAU+W5944pN3MZtBrCWkmEV7byCd7nB
	 EpMnq8YwUPW8O08xEXCdk3XLPrnoJfIWdONZeyxVRo7qASxUmRnpKk24OmgGm+TBGj
	 8awcFyDpODQVQlyZZtFxiJGdn08z8MlD2evAEeSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 473/554] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Thu, 15 Jan 2026 17:48:59 +0100
Message-ID: <20260115164303.420492419@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a ]

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-3-david@redhat.com
Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/cmm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -550,6 +550,7 @@ static int cmm_migratepage(struct balloo
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 



