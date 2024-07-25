Return-Path: <stable+bounces-61465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C2F93C478
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10968B2492A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8E19D090;
	Thu, 25 Jul 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0D7YHYNV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774919D066;
	Thu, 25 Jul 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918396; cv=none; b=TPO4eabPycmlUVe4ibtSsnpDfDtWEB8gohiurb8eNUt4hW+OLbL9jmz96bfEQqotJvSQx+wGXX7UpE2WKLmUUcWaLf+k2C9yxtnIqqWhUD33fHPU+xRqAN7jBx+6y9PQtV/Pj7tThnGvV1Fo1YfbneWk/rS1DIdM1yDEMam4yLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918396; c=relaxed/simple;
	bh=UqVVNUYcZ2jtTayGoarvFFhz1NJfPC8rtmJGKAYzXBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ+7xxYYmDMqrwWHE5KYpXS0fUkOUJobiU4sstMA4afMF8wi/8gS+d3lXEvPMdLMHJALZbR98fFgboFqQA8ST02bvh2vedHFBwico1DU/hWafNkAXUmqoEPChAml4n6rErAozIMFGVi371S7zXAE1yjyt63ixTPmU8eEHqCuRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0D7YHYNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F366CC116B1;
	Thu, 25 Jul 2024 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918396;
	bh=UqVVNUYcZ2jtTayGoarvFFhz1NJfPC8rtmJGKAYzXBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0D7YHYNVyR6iM+oRuIYpHmJUwcmzma6b6U1MG9kNWWfqD2zIJaZhJB70AA1eyZS5D
	 3Fc/R8fPV1WDzw3kLVdVQ47pWA6PxqohXY/PPIh492tMuhjLX0Xd6kQNzB+MLAPyZ/
	 +so24eF6B+P5uPmrcZp1b2xAHb4ua+ldQeRHv+xA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.10 29/29] filelock: Fix fcntl/close race recovery compat path
Date: Thu, 25 Jul 2024 16:36:45 +0200
Message-ID: <20240725142732.910355481@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
References: <20240725142731.814288796@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f8138f2ad2f745b9a1c696a05b749eabe44337ea upstream.

When I wrote commit 3cad1bc01041 ("filelock: Remove locks reliably when
fcntl/close race is detected"), I missed that there are two copies of the
code I was patching: The normal version, and the version for 64-bit offsets
on 32-bit kernels.
Thanks to Greg KH for stumbling over this while doing the stable
backport...

Apply exactly the same fix to the compat path for 32-bit kernels.

Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
Cc: stable@kernel.org
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/locks.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2570,8 +2570,9 @@ int fcntl_setlk64(unsigned int fd, struc
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->c.flc_type != F_UNLCK &&
@@ -2586,9 +2587,7 @@ int fcntl_setlk64(unsigned int fd, struc
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->c.flc_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}



