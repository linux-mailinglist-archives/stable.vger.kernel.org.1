Return-Path: <stable+bounces-206445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB5D089F9
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2753029EA6
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FF338598;
	Fri,  9 Jan 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh8RBW7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48243396EE
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955171; cv=none; b=gNDf0mUibKO0SyYyeFlTCEWVl7O6elKKfJqF2apiNt2mGuYr7obUaOsvw41MDCQ+1hioH2XxY5bZIHvXvKgWo8qINj9SiExfFaXoNU6S2JBXUFJt0+tIrWrtekHUzqoG2f3DYH4ZzV/BwP19JzRFHgFGQCk/Bxyk5fXLl/p4Dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955171; c=relaxed/simple;
	bh=zAbQnwKQSgBP6p7KWlWw9DcpzSJFpicgY3jt9qQvxcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyJoT7sFfkyw7g34YWuub8dGQlHwsFWDdQjnAgfODUHqe4Rx0T+A/ocDYt21mVBnpaeV96wJB2LadABcYH5iKKDcZlzjWo+zM/E3P4DjGuCjOxoj1MBWm79IDDQIDuxsEeWy5mDTlqHu5cfbfKsGpjK+5CqNrxkweOnM0Ks/Jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh8RBW7B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432dee2b55fso7888f8f.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 02:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767955168; x=1768559968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnq5gnjYEBiVhXaKRyzgwQ5WDJS4cAZPYtKFe/+ivNc=;
        b=lh8RBW7BYD++KMfj+WNAxkINQ3RgUvUQjlv3Ufo9JX7niyBShY5b4ABflVL1aPZVNa
         /SO101e39p9GLdwKB9bdPphgnRtj7/M3gDRt6T9zFLjULIqFfal5pJy3L7FLA1X8hehg
         wFlhQNxqpiHjbbb4EEmvVzvnL+Yg0fmZwXlqvbJ7eztZUUGEXfQoe3pWfp1+Nkbmpl/9
         C6XnmNerQvPpHBMMEZbc3K1Ex1bYpOi/TgQ0q3rS+QumrMcWOtB2fxHjgiZ7YZHY+K2h
         aax+be4/HSwjSct8OoJ1G0dp6fvlJiNRUHp58EEkSXtvfpYi28VWzKneRGrOgSXA6bTq
         pPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955168; x=1768559968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnq5gnjYEBiVhXaKRyzgwQ5WDJS4cAZPYtKFe/+ivNc=;
        b=PHKyaX25DNSh6GakYO4c3PA7TABfqhoMtXUrQmnMZP52WpITxWh8e08x3pvlWKXkHP
         6gZMP18+LXWIT4LqFu/gdR3p0pUIoMe7sB5Y/Cf+p24FBS1P7NUptPdbqTOXvIcIBQjy
         9Md0bB6xnkZp4sOMdVtQ//CTeQ2KYSk+UNfnVQDEDNXKAQYy+8rJuXZznZXIyIj7FWxn
         1dN1fbEXj2WQfKyHuefZw8JLEQyHBhCtvXJlapq7FYpaJx4Tzlz8P2Cllfzay2aQkqhU
         RFdqnjY5H2P3KLA8XP4NRJZjUapzxbH14tQ7KHOPF3veEcotb2hvGbQ3mPVLavZhFldz
         2/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZf969AprttEfpN2YBar6RdkvxFRy4IaQusophQLd8BrhHbozU6bvfujB1rBqOJI0Rgh6Ueg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagKge3YS7pQyrLriEklfR20SWnVC6TPpdSMbGONnTUlicvaZn
	dtKVBJ2exaUrdBWL95AYy7YzmbGxLH9RlthB0mr/ATtorrce7com76rC
X-Gm-Gg: AY/fxX7NbhiO7d0eMGnK7w+faqp5WTzZjwpyqTR6pZmc2QgmW0s1ppkVTIPQz5T4jW4
	Wn9sPWQ2aQl43H50b0+l5x/6MOOcJSd08070QbbPNOk8sUaNUiXtZHuO5Z+Nv6HG81+eWKAJKGb
	2RjIcPHNSxZ0rCWdCO96IVZpiuoaGvajniq+CJsNoWJ98DJow5Ryu/ZQS8D4mEERuANxsCUtMcr
	r0oKnRror+pTP/oywAqOVDh/4wdsQ2CUOwYMILR0CiPUYvcjUBVM/we/b/j95SDV2y1TrmtJ0tl
	szFGDhrf0hKgF5DskBeQGV/QBRlGZGie7x8XmHKIHL1IUEMaMrIsKXf1kS2VeAX/4LxY2c8FDRv
	4UYiqWBjC60sopYBtHVJWa0MvM0UrzMS0fDT7wHwH0wOkg17AAjgrJlY1+x1wm1FHZUddHm9YeE
	8MbYduUaspcvhmF0+SZzcjQDcBWVVEe8inanH/X0creqzv6eEviwGOuDuXtCAAYlIrmVwI0NO8X
	f/cP5g=
X-Google-Smtp-Source: AGHT+IHciyXHKUeAGcmyGH9e9/cNeiCCj6AtY6qRKQqbQ6xmqXicuHAMta4fNJAQ21qLP44qM8jCkA==
X-Received: by 2002:a05:600c:3556:b0:477:9fd6:7a53 with SMTP id 5b1f17b1804b1-47d84b04e1amr63078895e9.2.1767955167881;
        Fri, 09 Jan 2026 02:39:27 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm21697194f8f.29.2026.01.09.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:39:27 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: smbd: fix dma_unmap_sg() nents
Date: Fri,  9 Jan 2026 11:38:39 +0100
Message-ID: <20260109103840.55252-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 fs/smb/server/transport_rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index f585359684d4..8620690aa2ec 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1353,14 +1353,12 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 
 static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
 			      struct scatterlist *sg_list, int nentries,
-			      enum dma_data_direction dir)
+			      enum dma_data_direction dir, int *npages)
 {
-	int npages;
-
-	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages < 0)
+	*npages = get_sg_list(buf, size, sg_list, nentries);
+	if (*npages < 0)
 		return -EINVAL;
-	return ib_dma_map_sg(device, sg_list, npages, dir);
+	return ib_dma_map_sg(device, sg_list, *npages, dir);
 }
 
 static int post_sendmsg(struct smbdirect_socket *sc,
@@ -1431,12 +1429,13 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 	for (i = 0; i < niov; i++) {
 		struct ib_sge *sge;
 		int sg_cnt;
+		int npages;
 
 		sg_init_table(sg, SMBDIRECT_SEND_IO_MAX_SGE - 1);
 		sg_cnt = get_mapped_sg_list(sc->ib.dev,
 					    iov[i].iov_base, iov[i].iov_len,
 					    sg, SMBDIRECT_SEND_IO_MAX_SGE - 1,
-					    DMA_TO_DEVICE);
+					    DMA_TO_DEVICE, &npages);
 		if (sg_cnt <= 0) {
 			pr_err("failed to map buffer\n");
 			ret = -ENOMEM;
@@ -1444,7 +1443,7 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 		} else if (sg_cnt + msg->num_sge > SMBDIRECT_SEND_IO_MAX_SGE) {
 			pr_err("buffer not fitted into sges\n");
 			ret = -E2BIG;
-			ib_dma_unmap_sg(sc->ib.dev, sg, sg_cnt,
+			ib_dma_unmap_sg(sc->ib.dev, sg, npages,
 					DMA_TO_DEVICE);
 			goto err;
 		}
-- 
2.43.0


