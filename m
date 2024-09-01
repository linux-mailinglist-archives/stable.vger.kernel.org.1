Return-Path: <stable+bounces-72121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020EF967944
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B27B21CE9
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86217E900;
	Sun,  1 Sep 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcT9Q/cI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B61C68C;
	Sun,  1 Sep 2024 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208908; cv=none; b=OI73XfrW4fz7VkoKdcNRWM/MAlE1o3bQrE4DPaZ9uG/DJA/DaVf2tzYK17DVRm+mj8A8CWcJCN7Q+/O3LdhdwQ0HmdhKnUJGFQhPiTEE5c1iP4dx2QovjaHodze2L6fTX9ewJLvuof3F0FvcOAPRpThvn14tajcXOEgLKs743XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208908; c=relaxed/simple;
	bh=OfWwitWIt/xoiYTo7uqta+XWZtJRbfpBxNijol8grfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmulHrpqXvKKpK86xPTi5zdczqlLah08Cpf7AJmVDW/gtwUfmmok1+iXn0iIIbLHgRuZtwgAke+oj0KT2IyfmfovqRSm+EYYqSQPqy/+7WKzvwfVBgijen/zs6vFi1EQ4Ru6N8RQcAZOVyRVk3vd/NBsTiX1E40940OoAvI8d2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcT9Q/cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CFC4CEC3;
	Sun,  1 Sep 2024 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208908;
	bh=OfWwitWIt/xoiYTo7uqta+XWZtJRbfpBxNijol8grfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcT9Q/cI0hC7zAEGI/zmzaElyHenGBzVeO/5aVVHhmCrXn+8Bqjhlh8iiPEtzxt1G
	 sXv/oHJcLzKKHae/AONo0zWgnWcmBOtucK7+1AMwpJ8wqRBNgYTf/mhzdmv/IxybJJ
	 PXfjzrFaiue3mQiE+Y05XBc9K6gq3PJ7OVALOPYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Slaby <jirislaby@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 076/134] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
Date: Sun,  1 Sep 2024 18:17:02 +0200
Message-ID: <20240901160812.961417803@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Jarno <aurelien@aurel32.net>

commit 31e97d7c9ae3de072d7b424b2cf706a03ec10720 upstream.

This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the solo6x10
driver.  This improves the readability and more importantly, for the
solo6x10-p2m.c file, this reduces on my system (x86-64, gcc 13):

 - the preprocessed size from 121 MiB to 4.5 MiB;

 - the build CPU time from 46.8 s to 1.6 s;

 - the build memory from 2786 MiB to 98MiB.

In fine, this allows this relatively simple C file to be built on a
32-bit system.

Reported-by: Jiri Slaby <jirislaby@gmail.com>
Closes: https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
Cc:  <stable@vger.kernel.org> # v6.7+
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: David Laight <David.Laight@ACULAB.COM>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/solo6x10/solo6x10-offsets.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
+++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
@@ -57,16 +57,16 @@
 #define SOLO_MP4E_EXT_ADDR(__solo) \
 	(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
 #define SOLO_MP4E_EXT_SIZE(__solo) \
-	max((__solo->nr_chans * 0x00080000),				\
-	    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -	\
-		 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -	\
+	      __SOLO_JPEG_MIN_SIZE(__solo),			\
+	      __solo->nr_chans * 0x00080000, 0x00ff0000)
 
 #define __SOLO_JPEG_MIN_SIZE(__solo)		(__solo->nr_chans * 0x00080000)
 #define SOLO_JPEG_EXT_ADDR(__solo) \
 		(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
 #define SOLO_JPEG_EXT_SIZE(__solo) \
-	max(__SOLO_JPEG_MIN_SIZE(__solo),				\
-	    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),	\
+	      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
 
 #define SOLO_SDRAM_END(__solo) \
 	(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))



