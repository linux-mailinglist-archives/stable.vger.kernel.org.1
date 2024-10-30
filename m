Return-Path: <stable+bounces-89343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4E9B6841
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC41F2350E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346B2141D3;
	Wed, 30 Oct 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSutp/5i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89142141A8;
	Wed, 30 Oct 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303199; cv=none; b=jwcMoI+4lob0B4ufFKdqSyLOyBW2RNH/GU51zKGSzYx0na33rkmYQ7vIwtkznx3isMUF76LNEOJhtSuXVohV5qjNwuc/0J7ZFTQQlkFt517JthefjFngpqZzN/cZ3P3HgSfulMYh7pztQxnpfUzpZGSlNve6rNFN9JpXbRfINkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303199; c=relaxed/simple;
	bh=r7QF4PHLX5P8h0FpkWDd8f0d9a2be4wo41dlp89hp4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8Lt72oeiIzHP4xkjTM1KNlUEYIvRpr+8a02jS0f2iOR8xmpTDV17+5nBP/vRLFJlFC8pg+bbvncBaTi6y9B6BHC111StzBGZdNWH/WaV5cU7CpBhaenZfeR0AOTh8AHkmHj88C1Jyj2MR8ChQXADTaxF83rPlL4/NjAY+FT3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSutp/5i; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso1046232866b.1;
        Wed, 30 Oct 2024 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303196; x=1730907996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxasEsCWEIGpOvNzhH8eScxatYKa4d9obCKEvyxu0Rw=;
        b=DSutp/5i4k6qJNVXlvyPyRuSfzMNOF5aJqP6bUOJBlFf5dgYNbSh3K1A1aX01h3FXk
         rUrkU+FepANArsU5fkXfwXg73d5o94Renms9UbnClJ2LgFJeSUv5ceK2tjqePpjxx7uh
         Z2zpUcrCR9kJsO3llRpaI8fUpYu7+dFd9qRojbZP5R32u8FE+6EUF6mKEg1fwx+w/mu7
         dVWWAIgw2u0tRPDuL70mJu9/j1gJ5JxYxIVoOXJMmSUZLiOERiJ83z+x3nkwj8R7MZm9
         k7qZ82KpAsr306VVHusa1U2KyJ7dBhrx4Pcx+lCkm3V8VM+ygHskayRPb00rxM1lXgXo
         G+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303196; x=1730907996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxasEsCWEIGpOvNzhH8eScxatYKa4d9obCKEvyxu0Rw=;
        b=S1AZ/LXoPORKAgcGjtqFeLaOUZKX7I783Q4VTIQire9H0cdhJncjfrWFobrhhg940G
         JD/nWT5CTuR72NmzUt76hSv2cvLZ2TZa/Hg9DcuwCjE0kc80JE3v/YWwEZPs9du1wYb6
         XCgQTdfjQER8rlgWjQ6epVV36Ip45K1jly79EYOD3Lof6s2o/Np3gLq97wM4+ImHHRKk
         DB+axi1VABm/5FUs+rew5IcK7NDjGmxBFKXcgGD5VJfCjlh0mSkPZn5I7KN2fSdn9F+y
         G2+/uczx3DZ22WlWbDAw6vh1MiZB4hHLq2q9saUFBQ1avR5muzeRDFgXM2asIpY7xfYl
         zySA==
X-Forwarded-Encrypted: i=1; AJvYcCW/A5gDvNY1d62XRSANVXOWhoyrGrR5a/8lXvRikgqnoEqRr7h/moIEdJRrrYwNniogkeP3j0sv@vger.kernel.org, AJvYcCXC0UDygpbMi19TDvAm1DG3L5aFGOm6zpYv58227VuCXstxdoJ3JLZ8RqRRJZuPQyfeo2sunPU8rrhz22Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZ7USRdQVnYSUVYPZvY8XUlf+p3LdAk8uwg441A6uixPkziBA
	7jSG545zEcHKn8FpcwAoxN6bfk0fanCUMh9qBCc+57j/ATq8xWpjpYhEYg==
X-Google-Smtp-Source: AGHT+IG0Fm32mxDJhFWquwLn6UmkrmH53AH/udH8AfgwmH9oyvfEAaTYZlTD6ByYK+ksWsj4jcQu5A==
X-Received: by 2002:a17:907:74b:b0:a99:37f5:de59 with SMTP id a640c23a62f3a-a9de619182amr1430120266b.53.1730303195789;
        Wed, 30 Oct 2024 08:46:35 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086de0sm580414766b.218.2024.10.30.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:46:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 16:46:21 +0100
Subject: [PATCH 1/2] Bluetooth: btbcm: fix missing of_node_put() in
 btbcm_get_board_name()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-bluetooth-btbcm-node-cleanup-v1-1-fdc4b9df9fe3@gmail.com>
References: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
In-Reply-To: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730303189; l=985;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=r7QF4PHLX5P8h0FpkWDd8f0d9a2be4wo41dlp89hp4o=;
 b=0Br1VOjdEp367ZTVHtMA6gyBQa87HqXCnGFw6tV8ZDpythWn/3AZXZrGa8jRqtoN28TJvma12
 PkV5nIL6evqCkgNqVkCJQpKQkUTRyySsDLofqDDnkusU24z5sjI28UI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add the missing call lto of_node_put(root) in the early return to
decrement the refcount and avoid leaking the resource.

Cc: stable@vger.kernel.org
Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/bluetooth/btbcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index eef00467905e..400c2663d6b0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -549,8 +549,10 @@ static const char *btbcm_get_board_name(struct device *dev)
 	if (!root)
 		return NULL;
 
-	if (of_property_read_string_index(root, "compatible", 0, &tmp))
+	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
+		of_node_put(root);
 		return NULL;
+	}
 
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);

-- 
2.43.0


