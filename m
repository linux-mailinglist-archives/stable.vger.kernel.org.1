Return-Path: <stable+bounces-64516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B5941E2F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9891F213C2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E901A76C6;
	Tue, 30 Jul 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tB0mHmd+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E71A76B2;
	Tue, 30 Jul 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360382; cv=none; b=NBpDcsYQ8uDbclo7TCqwNExw30nttjvMYSLyw33uQCf9cLSJaUYqMS1PB3XwuNeaKkVKzE0xbm38OywmbUzylsZdrspKp0ESFFMFkGZAUCnrbk1NwYiF7w/3W5wvLnVC2dQJXO0pPyiL82iN3lnjbbJd+P0Sqg7Xkcf9jUWD4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360382; c=relaxed/simple;
	bh=FUVmb281mxuDIx8NkU2nZEhJUKjjsOBjgi1sHBvzl28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eljtq/q2zLAGlQGjMHdM+5tcmH0tTaeSH92fNUcqcOlo65dGnuglG2JDdoIlwi0nf+FCNQ701rPdzm7hNKepXwBphZBoh1XLE7rrG7Ja794V/k7YjfA2n6geR7DKUo4SAGmzGOASB2DbndbszAO0mb66UxFS3BFvYATPwF0iJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tB0mHmd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE62BC32782;
	Tue, 30 Jul 2024 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360382;
	bh=FUVmb281mxuDIx8NkU2nZEhJUKjjsOBjgi1sHBvzl28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tB0mHmd+jwSk9MCIk6dKWXilI+STA/5CZkjXMsyt1hT3+uXwex3xsSNwI0/dWolKt
	 vrP5BmrsCZKVlHXLyBQzNuTjZXrVH/YYWaFavWG5NbHBt7wcd0KiRC0O/qo+tqR6Br
	 K/7XkV3ULygtze1Q9cTteMAVFdwHSdkeKLQ8HkVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Chakraborty <joychakr@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.10 681/809] rtc: cmos: Fix return value of nvmem callbacks
Date: Tue, 30 Jul 2024 17:49:17 +0200
Message-ID: <20240730151751.806581411@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

From: Joy Chakraborty <joychakr@google.com>

commit 1c184baccf0d5e2ef4cc1562261d0e48508a1c2b upstream.

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

cmos_nvram_read()/cmos_nvram_write() currently return the number of
bytes read or written, fix to return 0 on success and -EIO incase number
of bytes requested was not read or written.

Fixes: 8b5b7958fd1c ("rtc: cmos: use generic nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20240612083635.1253039-1-joychakr@google.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-cmos.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -643,11 +643,10 @@ static int cmos_nvram_read(void *priv, u
 			   size_t count)
 {
 	unsigned char *buf = val;
-	int	retval;
 
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		if (off < 128)
 			*buf++ = CMOS_READ(off);
 		else if (can_bank2)
@@ -657,7 +656,7 @@ static int cmos_nvram_read(void *priv, u
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -665,7 +664,6 @@ static int cmos_nvram_write(void *priv,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -674,7 +672,7 @@ static int cmos_nvram_write(void *priv,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -689,7 +687,7 @@ static int cmos_nvram_write(void *priv,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/



