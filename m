Return-Path: <stable+bounces-28480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9D88135B
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2B1F219CC
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E6848E;
	Wed, 20 Mar 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCqYw5Tq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD511EEE8
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945111; cv=none; b=NyrOkEiX+rZu1kOaqtmt4nVr4Fh562048DUCo+yeCZA2nzhb1atJMSJMyYbfVgIjYJugs4sDg/9zEjiaD/ig9Ol96UjTKfrR9GbIpyx72H/r3pg7QHLVt7LwyuKTQibtRQQJ+kwJbM+g6E0AB4nW2p26Hq3MUIpXNqyNKnVuNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945111; c=relaxed/simple;
	bh=qodn0HWT2NxPcmvoeYPkM26Q8diisbuBZbvrENJf1/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyUebGSwKO4PtM082VsVK2mo5gxc+hkLu6grcXZKfFhTyuWLkqwVWglcQ3SNnTlKssx4RGvddnHyXYorf0vm2u5HlOCWCWfN0bENPiY95t01/ceiaTKxNyerJyMvwfGHkb71i80xSsdJhWTXtgLI90WY5VSnxtsoFBLaqoEjJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCqYw5Tq; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6888358dfso1624024a34.2
        for <stable@vger.kernel.org>; Wed, 20 Mar 2024 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710945108; x=1711549908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/bYOBDcymvYGp78k9DLmQb5D/9HOUP25d/CXpNGP+TY=;
        b=ZCqYw5TqT3tLI0Gbf0OA4v1r2a6m4O6XQLna2dKCLw1LHy9XTh4aRcq9qesljD9kwZ
         OQQ3DLsvPvAwTQCKHMT4LJw7Hu06iVX5OZZdsXr7O8gqKXlze/P8SV4wTgfxIECdoISo
         NJOPNZ52abTsDYv68tiCZ6VFH7tks8vkgyb/e2bsbHMJ6cHBWfyQbHfB0pZv5NaEdle1
         uTersppPy0mmm7vA30DgLniOQQVMLuw3X7ud1BWriAiXpx/wX3h3XjQsNx+yotVv/d0D
         Ie4wvAS5oiEkCojgPWYmQq5WiW6Z6gEKlk+Oy37DqZGJ4pSEWKh/u7rBblYkxnZphq8S
         pb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945108; x=1711549908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bYOBDcymvYGp78k9DLmQb5D/9HOUP25d/CXpNGP+TY=;
        b=GoBNGJ0mkuP3CMqOtNwlXJeCII5M01eaCYtZi6rJMagQZTuJjMJy3dwMycYpZyOC/v
         SyoDfqYUjkz4xbKYGRC64Gg9LB70gEBhvTZFwYJrdJezlu4PARvitFYoIgdKHO9VkHcz
         5/n+RR0lI5v10P/nGCWt0eOqCMo1NcStU6dD246tEEuFjx+/i1LWWsR+vOy3H7FYdJfd
         67dXU8XAxEmS+ibvNor9iPHkYtieO2ouc9HvyzQY1xkikz/vYibA+ZhxYD3wS26bxYXy
         4b5cJn9wE20nwKzfz6q8ekH17XmnNs9w0k0n7+b8OKcbENerx9URVqwgsUChN15yiBfY
         CM4g==
X-Forwarded-Encrypted: i=1; AJvYcCVx+vVUX5K0Uf4cwoH8k0E1KsGqFjMKJTRTUUipkxYb5u68Xmg29cXixTip2RWhFZXencfkEzJqM9G2x+bvqlumCB38ykPD
X-Gm-Message-State: AOJu0YymBAHsk4z6jNKXmwq/gGBlFLibqI3FCTQiqKx7aCBPrOBweynJ
	vTYLNMqAfCCfYbj+IvyTx2v2GyxhZIjVEryODJTuZwM8CDTkEArmg1DgsM0vrKM=
X-Google-Smtp-Source: AGHT+IG4f+F2qucJVV9FVBes2/YroVqIfuUP0CwK01ziUO7zee4tZhWwEr3MnA5b3XjZeI/FRbG/sg==
X-Received: by 2002:a05:6808:1523:b0:3c3:87c0:7369 with SMTP id u35-20020a056808152300b003c387c07369mr10478864oiw.7.1710945108603;
        Wed, 20 Mar 2024 07:31:48 -0700 (PDT)
Received: from maple.home (bras-base-otwaon1102w-grc-09-184-147-116-200.dsl.bell.ca. [184.147.116.200])
        by smtp.gmail.com with ESMTPSA id ff16-20020a05622a4d9000b00430cacfe532sm4331700qtb.79.2024.03.20.07.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:31:48 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: gregkh@linuxfoundation.org
Cc: herbert@gondor.apana.org.au,
	patches@lists.linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: v4.19 backport request for crypto af_alg
Date: Wed, 20 Mar 2024 10:31:43 -0400
Message-Id: <20240320143143.1643630-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have found a regression in userspace behaviour after commit 67b164a871a
got backported into 4.19.306 as commit 19af0310c8767. The regression
can be fixed by backporting two additional commits, detailed below.

The regression can be reproduced with the following sequence:

echo some text > plain.txt
openssl enc -k mysecret -aes-256-cbc -in plain.txt -out cipher.txt -engine afalg

It fails intermittently with the message "error writing to file", but 
this error is a bit misleading, the actual problem is that the kernel 
returns -16 (EBUSY) on the encoding operation.

The EBUSY comes from the newly added in-flight check. This check is correct,
however it fails on 4.19 kernel, because it is missing two earlier commits:

f3c802a1f3001 crypto: algif_aead - Only wake up when ctx->more is zero
21dfbcd1f5cbf crypto: algif_aead - fix uninitialized ctx->init

I was able to cherry-pick those into 4.19.y, with just a minor conflict 
in one case. With those applied, the openssl command no longer fails.

Similar fixes are likely needed in 5.4.y, however I did not test this.

No change is needed in 5.10 or newer, as the two commits are present.

Please add the two commits to 4.19.y (and probably also 5.4.y).

Thanks,
-Ralph

