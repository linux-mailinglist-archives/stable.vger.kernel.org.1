Return-Path: <stable+bounces-67848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A82952F5F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5CE28981A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295419F470;
	Thu, 15 Aug 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hCi0U7CF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8319EED7;
	Thu, 15 Aug 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728711; cv=none; b=jd9IXb3rX42r5869n5zaFSr5PC/ATtKRhbUPc1ZAFWgaSlbOowZLR/GVZE8FCeFYTxr8jNxn4Bd+1a8LSgbCgEgCKA7RyJQLioOKdG8C5VX0R+d2n6JFjreZBu+INK0d7JNYlUvK18XmzUYZ2WKeEZr6J+ULIYPUW2pm97x6pV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728711; c=relaxed/simple;
	bh=hFc0rCr7gGLM7yFH/GFkZio0y0IBbAVKjGuaPs0XpjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkJq8+VESaAFjJrFB68ds++LbLZdbIVcZiCdo2ibsAvv4vBGQzLfsg4NIinpxm4Yh5xR+JjYyfSWkU6bDUVHAbhVTNy+FUM5xVQO61PYk8mhjieW+NYGZVs53g2aQcQ1jEeedaLZJHbo8R3z4m0+FGFrIT6B4CS52R4McIXbmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hCi0U7CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97484C32786;
	Thu, 15 Aug 2024 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728711;
	bh=hFc0rCr7gGLM7yFH/GFkZio0y0IBbAVKjGuaPs0XpjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCi0U7CFPAni9HpGlfoMg1hh7t2w9wX0YjBgU34JKCTy8GJ4D/t3T3yax6521+cw3
	 iCWZDWR+aYFN27EJLrmwHlGBhqo60ieT/n7lORkb1zlV1Z9bUtIQSgxj/UW+6yUlmV
	 1lN+hF4BoTJ7Gh+HqHZ16XK7YMeoeiE0lmJHR/44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Chakraborty <joychakr@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.19 086/196] rtc: cmos: Fix return value of nvmem callbacks
Date: Thu, 15 Aug 2024 15:23:23 +0200
Message-ID: <20240815131855.371981840@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -601,11 +601,10 @@ static int cmos_nvram_read(void *priv, u
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
@@ -615,7 +614,7 @@ static int cmos_nvram_read(void *priv, u
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -623,7 +622,6 @@ static int cmos_nvram_write(void *priv,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -632,7 +630,7 @@ static int cmos_nvram_write(void *priv,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -647,7 +645,7 @@ static int cmos_nvram_write(void *priv,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/



