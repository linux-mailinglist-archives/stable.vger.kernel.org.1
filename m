Return-Path: <stable+bounces-173066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF778B35B55
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15BF7C3AE0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00D319866;
	Tue, 26 Aug 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ewu5dlVD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADED284B5B;
	Tue, 26 Aug 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207285; cv=none; b=hnhYQlGJpuesE+Zj+Scmbn9T2S0S1X9+OtrfFjJlKZDxnvjXYXAykYyue24TJmY/veobREkO03Fv3QUutBU2R9KsUOcabakF19plDljPAEIpLpj/ToqO1ShdLZGXdOVL2sSy4wDCk7kn4dAg0InjgccEjH4fByYGTXtPtePuMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207285; c=relaxed/simple;
	bh=XcG3msn2dEyMJy6KXdmsKyrJev7PxbSEz2MLBHsNMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbYyjncF9GyLUgtOI38/S8ja8wbh7eOVM/ZUAu+YcbDjZ5ZmJTQIbEytZOb2fXYZm/ioeiMliG9E5I4gC5kZSCutcpsNHpf+MhtEsNET0UBUNS3v0QnLabgzwhSpKO/uRMVUH3oV04UnEz4LOCn0FsS1cW3FSZi406kxrTnF9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ewu5dlVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB2BC4CEF1;
	Tue, 26 Aug 2025 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207285;
	bh=XcG3msn2dEyMJy6KXdmsKyrJev7PxbSEz2MLBHsNMUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ewu5dlVDoClX61ipsAaQdiPBLLQmDpTKeEO/7rs0EgrEjh9+ucoi+5V5DCaGk7ydv
	 I6hYeTwp/QRFf9aYrOlIF6CyDn9kD0ffiB2Q4JKMcSFZbqUxWvJaytLrLJk+86Fk3k
	 4Rqii36IbjPjAMHE2MjsuKdrL9pnfNGXWxBjsbA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.16 123/457] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap
Date: Tue, 26 Aug 2025 13:06:47 +0200
Message-ID: <20250826110940.413585970@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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



