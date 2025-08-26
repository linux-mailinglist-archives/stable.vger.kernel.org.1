Return-Path: <stable+bounces-174126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1370B3616F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DBC189A247
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A422DFA7;
	Tue, 26 Aug 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CqRMabvh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5941ADFFE;
	Tue, 26 Aug 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213562; cv=none; b=Oz2LbrRMxnEp+FI+FQqaeqzvfiFQbyo2E/0OfxJ1HHXz9HxzMk5NwmoSBUr7SYo7pfHuw1xhD2ojtcwOK10K8QujczR8lFVtwa0CD4RUlrXF35mmu1Vi8GiWa6a+6k/Nd/GwQ1onK/28q5VbFyd0gPsFag+eaozGqCjnvLui9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213562; c=relaxed/simple;
	bh=n54EaMana1nSSufti4BdL51Sscv1IKK7kFf1VwBsLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd3gl9vdfpRz0J3Ikrll02M47H+ax109+DyfmPntb14LGEBCyHTC13PGfl7qg0pG2IxjPAJg97/5V2RU3am1JoSO5s45rJN5Uov6fVy3DkQIEpQ0b9vNZlzGfbBvOjaD+sPqlcBzgDL9hWJLKguG94CcyQWSin9ZOBOWmvLITkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CqRMabvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21031C4CEF1;
	Tue, 26 Aug 2025 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213562;
	bh=n54EaMana1nSSufti4BdL51Sscv1IKK7kFf1VwBsLLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqRMabvhgQ2LHypG25uIl4ZDmzxu6SqpZIIKTAM5pWZ8zhiu0FPdDxJXqNZZDRIKF
	 thCgViRWpBAxJs8QEhrY2r08WwWQsWbtD5zHE4YsASYHIJRbtV8YOuqOgXugUlGobW
	 X+mczC54twSLDj+l17hg9TnVsC5CnSynkJNYfvJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 394/587] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap
Date: Tue, 26 Aug 2025 13:09:03 +0200
Message-ID: <20250826111002.944113478@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a upstream.

I have observed warning to occassionally trigger.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -841,7 +841,7 @@ void flush_cache_vmap(unsigned long star
 	}
 
 	vm = find_vm_area((void *)start);
-	if (WARN_ON_ONCE(!vm)) {
+	if (!vm) {
 		flush_cache_all();
 		return;
 	}



