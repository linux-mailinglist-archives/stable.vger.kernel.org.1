Return-Path: <stable+bounces-58210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A092A1AB
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36A41C2124F
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4C56773;
	Mon,  8 Jul 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCw9W0ax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD93BBE8
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439572; cv=none; b=kQFUqAB70J/oK8sxOh9DFM795SYxQfe+nTkkzSJ5pyeb4se3Ii9HKY+Zfi9aiVcg3eLWnPLj9AC6w/PB9c8yp02RYCUhvObvMXSlVADxUv/98Y/9TS2ysl2ZFDMd+TvAgbvvC6+SjhKsrLrfEG2LLBzka6rc+QGFt5ppx8r51dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439572; c=relaxed/simple;
	bh=BlvgaaKcLgvm4ZhDrKZYxQ9mO/1j9IEiXez3u6Qmfe0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q1nmShoy1jgI9JbqNyab9ws7XWkqp0OeZP899HkjYX2+VcUOXo9npDWo42NytQt9nnriwj/BDgBJ32OnkX472vXkf0P4cvYB98pvhJ5uCqsqeq9xmbga+CVx64v3V2l4gv2JzlhAB6TNMdijSomt3epfMHgWo9aGrMJiF/sr8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCw9W0ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C7C116B1;
	Mon,  8 Jul 2024 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720439571;
	bh=BlvgaaKcLgvm4ZhDrKZYxQ9mO/1j9IEiXez3u6Qmfe0=;
	h=Subject:To:Cc:From:Date:From;
	b=iCw9W0axY1XKFeQdI/JDo/OANI4GQ76aSd0mXV5mlBI4D+Mv4ljhrxdXlGthXVfr5
	 qbWvOKrY3mbt1BlF86MX8jW32aDWo1epGfaiJesb9Up06po2RPwBVeUA/4F5pBF+H/
	 JtGuQhw775a69+h1pHA9EOGKd1L4d78mPpIou8AY=
Subject: FAILED: patch "[PATCH] tpm: Address !chip->auth in tpm2_*_auth_session()" failed to apply to 6.9-stable tree
To: jarkko@kernel.org,mpe@ellerman.id.au,stefanb@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 13:52:49 +0200
Message-ID: <2024070848-graveness-probiotic-9eb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 25ee48a55fd59c72e0bd46dd9160c2d406b5a497
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070848-graveness-probiotic-9eb0@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

25ee48a55fd5 ("tpm: Address !chip->auth in tpm2_*_auth_session()")
eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
699e3efd6c64 ("tpm: Add HMAC session start and end functions")
033ee84e5f01 ("tpm: Add TCG mandated Key Derivation Functions (KDFs)")
d2add27cf2b8 ("tpm: Add NULL primary creation")
17d89b2e2f76 ("tpm: Move buffer handling from static inlines to real functions")
cf792e903aff ("tpm: Remove unused tpm_buf_tag()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25ee48a55fd59c72e0bd46dd9160c2d406b5a497 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 3 Jul 2024 19:39:27 +0300
Subject: [PATCH] tpm: Address !chip->auth in tpm2_*_auth_session()

Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can cause
a null derefence in tpm2_*_auth_session(). Thus, address !chip->auth in
tpm2_*_auth_session().

Cc: stable@vger.kernel.org # v6.9+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppc
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..2f1d96a5a5a7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -824,8 +824,13 @@ EXPORT_SYMBOL(tpm_buf_check_hmac_response);
  */
 void tpm2_end_auth_session(struct tpm_chip *chip)
 {
-	tpm2_flush_context(chip, chip->auth->handle);
-	memzero_explicit(chip->auth, sizeof(*chip->auth));
+	struct tpm2_auth *auth = chip->auth;
+
+	if (!auth)
+		return;
+
+	tpm2_flush_context(chip, auth->handle);
+	memzero_explicit(auth, sizeof(*auth));
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -907,6 +912,11 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 	u32 null_key;
 
+	if (!auth) {
+		dev_warn_once(&chip->dev, "auth session is not active\n");
+		return 0;
+	}
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;


