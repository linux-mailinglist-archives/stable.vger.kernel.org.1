Return-Path: <stable+bounces-180901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3531B8F8F3
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3226C3A571D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F24283FE4;
	Mon, 22 Sep 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaUiA7u1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFB284898
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529987; cv=none; b=Qgq8aIkERDNHQTJ/AULrOLgchpGPn+OhR44eyvewPVUNz+G2JWK2cQvD56LAmpIcIt2Cpq/x54kl2EI4Y0Zy1w+I3qBbTFtTY2iGc4O5b1N1FD02Il2i1lPw4OhbcVrwZmuDSfgWTN9msG2E/PPCj3sbi506YYzU5Gv6kAj6pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529987; c=relaxed/simple;
	bh=TUI935ItxNpscDFWb4m1nohbc9W1iX69LCA+S9hjKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLO2CK53PjIf9wyvw0B2+aGrqG3G2JbAmCw330mjiQXx2lY5EW8L+EsmL/VQNq9b21vAsaRQw8xN4sDLDukJiWi79wJbE0KB50HTVolZEua9AOyMIJ/92J1Ba2n7ZSx7o+K1fg0kxeY0WTOTEkyFAaaDU/hO3/SAW0sUt2LmVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yaUiA7u1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b042cc3954fso668836866b.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758529983; x=1759134783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=yaUiA7u1evfxzBqxE1ucDiUZbqjEa4j+v2tjSVi534mIQeD8L/n3tABs7RTACGTrmF
         p/saExUy78UEqp95unTG4m4Cd3prTurGCFsdf3elCcBd5AvW/ZeuqiEkS0e30zTae4c7
         yocrb5equcldLA952hC2ZAOVwxkr1InOhA8ruJoUKYAmPSwogR+5K4WU3dN9blf2l8B1
         fXjG4CK9TMZAddlGjju6SMjB4frHSbEb86tUuZCFSm3ktRxpSFZXRJBfwqQsSgu3jpQM
         R8/cEuyAavU5qV41Ccde4zWoXF7ssCvq/JaSzuhHxYJLmmo8xqJag3C2f++2TiWDGy7o
         vZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529983; x=1759134783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=NhzieEXA+aUY8HJQu58cXtZUvF9cbqj6EtS71nLCzLMrb8lNLg9bzCKCJuPMHISmzh
         XZvPch+y52ZNXi/NXZS4z7vNvZB9GZcIqWGBcUkXVt0d40y4RItcJ7yjjuIEYldSTQ2C
         bdcCmkH8UEofJmkSbYcgek7pu04CJqudeMSIQ8GE9f85qgQpl8zVpH7o45iijYWpAWZ7
         ihRve80wYRci1AHvdQL5O116FFPklrOCLNIKCHu/x+ENsPW1VsmqI5/JQOLcXUT8lKc8
         IcuYwHVZDjXRp2oObNcBJeKxWxhilvrMdByokUc+FYLKlZQALtdR+cq7WHBZh61ZfYOS
         mdZg==
X-Forwarded-Encrypted: i=1; AJvYcCWbss/s7PhHWZqt4jketf4ctxhHN11QtJ3uhycD+t9Epsk+Nd4G4iXdLJcdvAGi+54RTgygwuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQ1CLG7vEP+KMYNjRIQM7G3fqQh/jmhNhIO32hVDs8u3Filk9
	MCjmg/j6do8yKQtxVa9uGJ6qgOnOi5xEQvMlDzbKUbtd6JVIhOfI7Sh2fC9aTTnnTUw=
X-Gm-Gg: ASbGncvOZbKMOmzwkNIrWDJo8T1tNw0SUTVofu0WTTVKqnYLDbEmF2T74ll83IlDLxX
	Io3H3UpqL712EtHZMC8koNtJHPteHM4r4Y6lh8SBVKA1l97N86zlUAuTPb+rsCYEDvRuwy4675T
	aEO2FGUG55DY+uskY0AOnbKjTq21Xaaq+ubY+QJOQHmil/6eA5wlaMpwxzzT7yN7G6yvwYLuD8N
	zU9ze0+CTSYBh1LjoC48lacffw+OCgbZsFPMvCrayEWKo2oP8sS/zTHvNYI7TELL10qboMNVWo2
	oi6hdoATh20hQf9cgfnEoZhPmF6EOJALLQUMIyDnlnSclN3aWZz5k5J0OjD/j6s73+VXE1IQd5F
	QRV0Xjnqb970rHVPwKSU0Nj0aVg5H7eXQGFKfkQh2vJL+ht41P/cVuqV91PMD2epoTbP/WvKxCu
	0=
X-Google-Smtp-Source: AGHT+IEbPgqjM7/4K73DMablLEbgOSElJBbGuyrxWLRLXPYLxggtPsrNtX/eVEM7H+fF9kMNQPcKqQ==
X-Received: by 2002:a17:907:3c92:b0:b07:e3a8:5194 with SMTP id a640c23a62f3a-b24ef97943emr1080157566b.22.1758529983418;
        Mon, 22 Sep 2025 01:33:03 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52a2sm613789966b.53.2025.09.22.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:33:02 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	stable@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH v2] tee: fix register_shm_helper()
Date: Mon, 22 Sep 2025 10:31:58 +0200
Message-ID: <20250922083211.3341508-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_shm_helper(), fix incorrect error handling for a call to
iov_iter_extract_pages(). A case is missing for when
iov_iter_extract_pages() only got some pages and return a number larger
than 0, but not the requested amount.

This fixes a possible NULL pointer dereference following a bad input from
ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.

Cc: stable@vger.kernel.org
Reported-by: Masami Ichikawa <masami256@gmail.com>
Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
Tested-by: Masami Ichikawa <masami256@gmail.com>
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Changes from v1
- Refactor the if statement as requested by Sumit
- Adding Tested-by: Masami Ichikawa <masami256@gmail.com
- Link to v1:
  https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklander@linaro.org/
---
 drivers/tee/tee_shm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..76c54e1dc98c 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	if (unlikely(len <= 0)) {
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
+	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		/*
+		 * If we only got a few pages, update to release the
+		 * correct amount below.
+		 */
+		shm->num_pages = len / PAGE_SIZE;
+		ret = ERR_PTR(-ENOMEM);
+		goto err_put_shm_pages;
 	}
 
 	/*
-- 
2.43.0


