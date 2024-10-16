Return-Path: <stable+bounces-86482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEB9A082B
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8D3B2497E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040A20899E;
	Wed, 16 Oct 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ailUwRxU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqNCwMtB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC87202F98;
	Wed, 16 Oct 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077312; cv=none; b=rucl5WgS9PyeUjH6pL2Cxh+5wCcarVo/1CUitLRAVlaz1re4ldrlhjQV6+GeAbZQNYSJ5RUydQ6yrC97wYyve1HOf7/tefBd61F5SUFax9l09PfIdKivdnL7Qn3/poOZOnERHV91tB/UUZbPLs7Q9K5LnrV06FRP/jxMN2VK9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077312; c=relaxed/simple;
	bh=KeXYT7Y2Y5kusM4KVM64TAK3+woLAQN8jJ27LWspqwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QY7EHRM5hPL6odO/lxq1jvbm7Ubb6Tqg+c9AcyeVAA4Zalwy5kGXsJHQWTQ1sSZVBOgVimJxVQVMVCQe+9BVIgGlpEGSOgQWd3hu0h1D+Zy9taD4R3K3xVp2BIoVBGtuoPriAPaZ50TwvMBHlmiJRmNrijDMTlRMPt7PmBzaZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ailUwRxU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqNCwMtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729077309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=taMxV9mtk3n69MLoKAdYPROfMQmRFolbS3Ztd5Pnu6o=;
	b=ailUwRxUPhMswFw6KNbD9qLockidc3EcNGUOaMUbL91aUGwePokXSpGsGaS0UvAfqRBpml
	60h1gEn351uOPQiPOkloVnqaPfaFXKzoYXTGlaeOhjJvj5AP1aXn/rqYHAl04jER2wcX/q
	W8lBjirowRCwdYoI9JjgpMxb4hdLtGHAbxtiDAzaIGu6NlG8FVUSGQWyihRIiUt9J+WgMS
	iWMmRSdGNJRz5uvKiXh9pRd6lMP5KXAhP2TiERZKJ1VBHCweZJG5aUSRPiV6uD4oIgkEJw
	ba/aFw5ApuxXhnKzYkCuRbDvGhXI014402yhhqZLeh68AeIDOZUpKRiOLqkGFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729077309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=taMxV9mtk3n69MLoKAdYPROfMQmRFolbS3Ztd5Pnu6o=;
	b=xqNCwMtB8BWzTliqAWJ2BpTVRFKQvciCUP6FsKMjnCJTlJy9QGiNuw75HZN9yJIKy4/ZA+
	G+h4YaWSABZXBHCg==
Date: Wed, 16 Oct 2024 13:14:51 +0200
Subject: [PATCH] tools/nolibc/stdlib: fix getenv() with empty environment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-nolibc-getenv-v1-1-8bc11abd486d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACqgD2cC/x3MQQqAIBBA0avIrBPUJLCrRIvS0QZCQ0MC6e5Jy
 7f4v0HBTFhgZg0yViqUYoccGNhjiwE5uW5QQmkp5MRjOmm3POCNsXJvjNdudF5ZB725Mnp6/t+
 yvu8HXNSq4l8AAAA=
X-Change-ID: 20241016-nolibc-getenv-f99f4d3df2cd
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729077306; l=1279;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KeXYT7Y2Y5kusM4KVM64TAK3+woLAQN8jJ27LWspqwE=;
 b=fkJhst66dWkETVCllsXXJUUPP1dDlpIoXVGm5mQQuP/MTWhXozSINhWUWHK1UEhPiMTMRlanl
 Ar/G9Lw3eqeD4N8E7WkEos2R5kiOsqgo5/ScpOpYmpaG7NomsAolFPe
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The environ pointer itself is never NULL, this is guaranteed by crt.h.
However if the environment is empty, environ will point to a NULL
pointer.
While this case will be checked by the loop later, this only happens
after the first loop iteration.
To avoid reading invalid memory inside the loop, fix the test that
checks for an empty environment.

Fixes: 077d0a392446 ("tools/nolibc/stdlib: add a simple getenv() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdlib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 75aa273c23a6153db6a32facaea16457a522703b..c31967378cf1f699283d801487c1a91d17e4d1ce 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -90,7 +90,7 @@ char *getenv(const char *name)
 {
 	int idx, i;
 
-	if (environ) {
+	if (*environ) {
 		for (idx = 0; environ[idx]; idx++) {
 			for (i = 0; name[i] && name[i] == environ[idx][i];)
 				i++;

---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-nolibc-getenv-f99f4d3df2cd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


