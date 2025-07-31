Return-Path: <stable+bounces-165697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1BB1790D
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B9E1C80A54
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9122701DF;
	Thu, 31 Jul 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIZ6GS7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA38265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000361; cv=none; b=eZpXl6cekcf9XityKKMBQ+F0tLb8Ch/waGJVNJRtIi62rbamiSLUz5g1dmnhGhlwYaGUG3q9nQF01srhljCaAjsRqoLBJPxDyfrjxCZXg0REC/HUIjGNcz4FWCkgl4HXcEkbC45MNqEvVzRA5tKhU1Fxsw8ISvbOvco8TaOygpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000361; c=relaxed/simple;
	bh=F+PO65dkgjpGCHWlSXmJxBA73wFSU3IL2qiIgD96kXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er3CPZeWXal4joHwq2cwgE53z16higgDzsEwDMIEGXYl/9SQakW7pzCnHbTtlY1ZWL6g8YQNY4Lv7AYV5a26M18OR5tG4lvOn0FC94bbaidKqoO924B505i/3gvCRWOlmvmvPeeoiqCOs7XOrWzuujOPpgaoYkuyfDj9cd1AzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIZ6GS7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A491C4CEEF;
	Thu, 31 Jul 2025 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000360;
	bh=F+PO65dkgjpGCHWlSXmJxBA73wFSU3IL2qiIgD96kXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIZ6GS7/T8QyBg4X3OY8armqMcdolpIw4g/8UxEf5qzphHGKGVcm5DIpwHwP/K+Kn
	 HFpxm/EK2/A8iwv1NiJeaX3RSZq7D7AXHbho6BBLtf+Bd8T+7PWXyVN6eX0ZXALyLc
	 KhPsNAc8ZshQPewvw+4FcDj6c46p2Fg7YOLUTdV/Csgm8QvD7xl9NddurwPz4CsLDi
	 Ni4C0tffgz1L/ohWhBuCX9KrHaFFtgon6UBikzqSLchXGiCYCRNKH5FjM7032VO7+P
	 zLeLn+WFzeN0Uk1YaKcqHrYwapYmcAoGxuR5JBKVqtO6saz7dgI4oHWWupJQ6radOE
	 2VewUeTuXHGqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] Revert "bcache: remove heap-related macros and switch to generic min_heap"
Date: Thu, 31 Jul 2025 18:19:18 -0400
Message-Id: <1753977355-5eb688b8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731123819.31647-1-visitorckw@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

Found matching upstream commit: 48fd7ebe00c1cdc782b42576548b25185902f64c

Status in newer kernel trees:
6.15.y | Present (different SHA1: 875dd4b6b0f3)

Note: The patch differs from the upstream commit:
---
1:  48fd7ebe00c1 ! 1:  79c6a7994d93 Revert "bcache: remove heap-related macros and switch to generic min_heap"
    @@ Commit message
         Cc: Kent Overstreet <kent.overstreet@linux.dev>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
     
      ## drivers/md/bcache/alloc.c ##
     @@ drivers/md/bcache/alloc.c: static void bch_invalidate_one_bucket(struct cache *ca, struct bucket *b)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

