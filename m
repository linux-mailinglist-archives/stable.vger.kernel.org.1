Return-Path: <stable+bounces-195430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD0C76A19
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3D5BA29EA7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756252D7DE7;
	Thu, 20 Nov 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYoxdzvE"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040682C3244
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681996; cv=none; b=ZwwKRcH/SrOu8lxKi5Fi5rOMn12UB2MsXaR+CQkn3rsglsaZo73GLahR9nMWtdWus/kkSAoFB+KylPs9VNykW4hUH5o0jTIlEcEcCUUEWmwm5MquNvn5MoNO69iqwLSP40CQESkv9cT0IGYzsfbvzTQKB7iuCGYZE5kBTiQEetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681996; c=relaxed/simple;
	bh=+3EbIaW84lTO86iIFzy/SflM9M4KNG5EVk8ttAiXMLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+XrSc5j0lp/0EJGuLEKYx33oLprP+cmAgqjpaHE0MGcT9jTHMyN9n+TCOy9oCmstIPIYabNc/GMN8m8XzfbX8NL9SownVfQ9PlC5uVvazV4QIGzFk634uZeCIhBu0ff+XEM53DQRouxP4FXU0OJxi3QZQYYEA8/Bqe+pPZ+QHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYoxdzvE; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763681991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLf/dd1zKfIPfCKbKoTJhnMoW1xfXHe5J/hRjAIR0pc=;
	b=sYoxdzvE5lnzArxnlTY9CamhYk26OIpUwo8SF4kNmOgO3UBdkhrR8eL5VT86c6OxL0vePN
	vPpsNHE7TtFMo8lwTtJOpCKCntZVahZLAoSZlkx1Yf8aU1jcAKa1cWcoeqqZNTwDD2xMsP
	FNQWh/6BudD8RhpmE5+jQBxPinFj2eo=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.12.y 0/5] LBR virtualization fixes
Date: Thu, 20 Nov 2025 23:39:31 +0000
Message-ID: <20251120233936.2407119-1-yosry.ahmed@linux.dev>
In-Reply-To: <2025112046-confider-smelting-6296@gregkh>
References: <2025112046-confider-smelting-6296@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a backport of LBR virtualization fixes that recently landed in
Linus's tree to 6.12.y.

Patch 1 is not a backport, it's introducing a helper that exists in
Linus's tree to make the following backports more straightforward to
apply.

Patch 2 should already be in queue-6.12, but it's included here as the
remaining patches depend on it.

Yosry Ahmed (5):
  KVM: SVM: Introduce svm_recalc_lbr_msr_intercepts()
  KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
  KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
  KVM: nSVM: Fix and simplify LBR virtualization handling with nested
  KVM: SVM: Fix redundant updates of LBR MSR intercepts

 arch/x86/kvm/svm/nested.c | 20 +++-----
 arch/x86/kvm/svm/svm.c    | 96 ++++++++++++++++++++-------------------
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 57 insertions(+), 60 deletions(-)

-- 
2.52.0.rc2.455.g230fcf2819-goog


