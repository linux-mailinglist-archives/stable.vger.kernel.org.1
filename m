Return-Path: <stable+bounces-1287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E67F7EE7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D9D2823FF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877C34197;
	Fri, 24 Nov 2023 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0b2Dqwa2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEC33075;
	Fri, 24 Nov 2023 18:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B0CC433C8;
	Fri, 24 Nov 2023 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851023;
	bh=iWKXkF/IeTCYYT68pRGEwOcw2Xj8xvUUccP3gdvhmQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0b2Dqwa27l6bqmBr+CzZGjCVZaVv7x135P5QdzFK928UCTX+H1YbA04S/2F5fAM8w
	 usemaUIIn7UuPbkWR9pBx/irtAMsCPCnAryCTpRAc8FAk8tniBGso0HO65tnhRNR0v
	 UXbQHnrAnfbCmsyZhJYDYzsy3q+m8ZJOjmRh9SZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.5 283/491] KEYS: trusted: Rollback init_trusted() consistently
Date: Fri, 24 Nov 2023 17:48:39 +0000
Message-ID: <20231124172033.077940304@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko@kernel.org>

commit 31de287345f41bbfaec36a5c8cbdba035cf76442 upstream.

Do bind neither static calls nor trusted_key_exit() before a successful
init, in order to maintain a consistent state. In addition, depart the
init_trusted() in the case of a real error (i.e. getting back something
else than -ENODEV).

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
Cc: stable@vger.kernel.org # v5.13+
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/keys/trusted-keys/trusted_core.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -358,17 +358,17 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_seal,
-				   trusted_key_sources[i].ops->seal);
-		static_call_update(trusted_key_unseal,
-				   trusted_key_sources[i].ops->unseal);
-		static_call_update(trusted_key_get_random,
-				   get_random);
-		trusted_key_exit = trusted_key_sources[i].ops->exit;
-		migratable = trusted_key_sources[i].ops->migratable;
-
 		ret = trusted_key_sources[i].ops->init();
-		if (!ret)
+		if (!ret) {
+			static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
+			static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
+			static_call_update(trusted_key_get_random, get_random);
+
+			trusted_key_exit = trusted_key_sources[i].ops->exit;
+			migratable = trusted_key_sources[i].ops->migratable;
+		}
+
+		if (!ret || ret != -ENODEV)
 			break;
 	}
 



