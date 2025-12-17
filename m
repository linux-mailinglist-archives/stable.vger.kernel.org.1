Return-Path: <stable+bounces-202907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12495CC9B9D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 23:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B38F303B494
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC29313530;
	Wed, 17 Dec 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="h188dOBO"
X-Original-To: stable@vger.kernel.org
Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA630B53F;
	Wed, 17 Dec 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766011306; cv=pass; b=aPEkZYluS1EB2UQNSf/xl2woSMEa+Eqek4U0++WTFQVrB2Ot/8olYLB104SEABPfaePwVlmKm/XLPXQt13hKhruf8i/a26YqM+F1rSW3EbQ7fcmkPXZ4WGK1/qcYHIIXJoKHeiWWKgMtDiBZb3fNqT/E6BUk8aAQr/8R2xTyPDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766011306; c=relaxed/simple;
	bh=Xw7pAZ3tecQ5tyn5e5+anhkBPw4nMmP5QuyB8XoHluY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcVG40bQG458mbAcT4L99879t+k0oGNsY/uCpu6gLla7i2AgjOz/2fu39fZo5e14ELoiyAXxLAb4KDp3Pu9S4jz3kczzBwzvvaQBKxc2tPpfiFwauYeplAQdsUPAWvorrAFRyR7A4uKN0OcRitshkktWRmFoN/iOonST4yBvRDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=h188dOBO; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 996BC4619EF;
	Wed, 17 Dec 2025 22:41:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-103-186-183.trex-nlb.outbound.svc.cluster.local [100.103.186.183])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2199A460BC5;
	Wed, 17 Dec 2025 22:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766011303;
	b=2ws4TLG9rKFiC5eRcqyW5tZrQM27474IcagANyEruoEWEcgV7yaIUdJCgRos2ApPJenWaT
	VFYVWlwMMTFQS1giMIzsDifJR4Orfh9w1k/pbD4fo4Fkd83Pdvj0AsTcwC95P7vrBWLwja
	CbywGqsFBP/eU8CS3+dNwUplNcho04iamQ1xZcHMqo8TB6zafaI9mC1iCv1Lpfx5jw7R0w
	VGaZh30mERpr+/ik6eDaxx5jSGhnVVGkETx3Dhzpg2jt8K7PgKXBvuuJDMlYuMDRrui8+N
	4cnZH+Q1trroXyN3VI+QCBR2h0xIyv/cG9fqyT9vnBA8+GqG++rLodaJNBEDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766011303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8Ygin6w7FA2VrPO9XI0JOikCLVny+JD/M6BqEleLMlM=;
	b=ynb/yoM4AtL3RlbfAWIuJ99k1iRf5mAXXuftCD15djbbFj5CpqDcgvAiOZNhRotEixNUv8
	9Vh5cz5isr9+BYgPqEWe7rsTee86Z1I8x3VIMdo3Voa5lK3M5SDLZfSE2G8A9HO48Jm1aN
	ekuCW5xkTgWnvwuxnH9uKEhw4/X8LHThz/Gj0Ng7/CnwuoYYHpmor5c8O5GrJVsjKBb8yL
	kZ/VxPW8mKrFa4VVnxoZTaGhaI+LoHvmJ1kLCJRD4bZeCJOFtWElTxVDzdEuJyW+Bgrgl6
	lVxEO9oNxIzuwe0YZfjm4YZ0U02O1RnCyooWFFBCNuzrEjPwbbVUbNoJFLIriA==
ARC-Authentication-Results: i=1;
	rspamd-659888d77d-mh4kt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Trade-Eight: 77eefdfa22a2a0c0_1766011303389_446266803
X-MC-Loop-Signature: 1766011303388:2288621669
X-MC-Ingress-Time: 1766011303388
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.186.183 (trex/7.1.3);
	Wed, 17 Dec 2025 22:41:43 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4dWpgp1sSnz1041;
	Wed, 17 Dec 2025 14:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1766011302;
	bh=8Ygin6w7FA2VrPO9XI0JOikCLVny+JD/M6BqEleLMlM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=h188dOBOMCKz8fokSnqDRbWCQl+vxNlgeM7zn5Im1+A0Ern5Jus3I6nO8cRNMjsv5
	 /NDWMpb0z3Ea0bfs9vr7+ic+eOJ+f8vHNseaJnM5wtvWFup59VgXQNl+0TtfRAxbKV
	 H0R8z1DoB9/5gISJbGWGbO3gFaMOPA7D/lzEO400W+ZSih6ySq8eBaKUv1lweQvEPR
	 nfbSt+uMDMCcoOyByC3fJ/7UCVHypqvfGr0fPU7HG1xshf+iTB7i8v5P+zG6pLMf6b
	 l1buAKuvtav/nxlw5WoFot2FwSgc0bgj5SW18pQpFz9QCtRGx/d6V+umk7hik6Fcik
	 Z92+OmnEbKGZQ==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: rust-for-linux@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: Add -fdiagnostics-show-context to bindgen_skip_c_flags
Date: Wed, 17 Dec 2025 17:40:50 -0500
Message-ID: <20251217224050.1186896-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217150010.665153-1-siddhesh@gotplt.org>
References: <20251217150010.665153-1-siddhesh@gotplt.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This got added with:

  7454048db27d6 ("kbuild: Enable GCC diagnostic context for value-tracking warnings")

but clang does not have this option, so avoid passing it to bindgen.

Cc: stable@vger.kernel.org
Fixes: 7454048db27d6 ("kbuild: Enable GCC diagnostic context for value-tracking warnings")
Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
---
 rust/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/Makefile b/rust/Makefile
index 5d357dce1704..4dcc2eff51cb 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -383,6 +383,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
+	-fdiagnostics-show-context -fdiagnostics-show-context=% \
 	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
 
 # Derived from `scripts/Makefile.clang`.
-- 
2.52.0


