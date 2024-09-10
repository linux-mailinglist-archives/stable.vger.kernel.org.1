Return-Path: <stable+bounces-75665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5194973B63
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBA61C21115
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168B196C6C;
	Tue, 10 Sep 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apnelw7g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6419B595
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981536; cv=none; b=hEgEMtWZNxVnfMCm6byHwsSMtQjGGoFOc7+bInGyu2k+1cQ+Y/Z68Kl7NTy5bGLrak2HPMCooKzRophA01KDhSdvsUNMwcwYIamz4bSqyZYFj3xmp0IYnZLeTzclq/5PrbdXt7/IXfFZgSzJ3dZvFRJrS/isiwDHP0CxydlzdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981536; c=relaxed/simple;
	bh=m1Pn/KkRj2ZPkH8DBRo0fdI3rI6gzTrHrZL6df6dLMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCYijtuzTe7Z/+ZdpIcFwhJ25ujncFSBvBxI/W7HIJ6W0SSnqprAnsrpIv5K6abgJO5ylkPZ82TFwltoUasJHU67RzOzJEK9p+AiDVj9+hxLIk6QM+QvIMVNvMvG7gf2JBGD0vxizbezhd4FZxrYg1fqE9LbteiI4qpZGwLfusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apnelw7g; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7184a7c8a45so3521474b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725981534; x=1726586334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2hTXAsykVccNye6ZqFtxEYDk7Om7KjrwoYIa36NzS0=;
        b=apnelw7gKgt4XTBtCjvgLOpLnSfaSTcfbcNdfph81qtboj/bw0iYG7lLP8hoftlFvl
         lNib3gqLLe4J3EvSasCtkbj4QDDAblQCKt0t6Uw4zQ1AZljyDpanF01EABlE0mEfLQH3
         YcikVXNlRGbv8ZCe5QCosq64KVum0A1WaLfBD/j4rv5rtDT8sU7z1a/yeplfSqoMhtkp
         RGkVYOJvpkFfSqfNzsB4nOY8TCLZuaodgycSjSGy3gIzYyIrtC8fKW0tEXmmo97vAsUZ
         EymJdpPP8EWCxyg1J0xG48Mfj/6iFLRNye1MKrI6Pvg3w0+XzStMY/bLKXC7fGraDTpG
         M6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981534; x=1726586334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2hTXAsykVccNye6ZqFtxEYDk7Om7KjrwoYIa36NzS0=;
        b=Yoop4dTq95hOm08+WvIbJ7mBJWPYTr7Jm27gVQXug1R5InMJNvIsJOoy2deuBJOCYc
         4pyMZ2909l+3LwC1ekZIZ9XJsF59jqjcZydr2N1ympzU6vU54MAIu7fro0DS5K42rvlf
         hnfEXH5sZHwwtMSWj4lVDyt8rfWx2HdB+1gLQHJMnRS8LjAPY2hoTirrWnlX211ZWeVv
         ep9I7LOX9B8lzWVmAK9uikZl2fVAANreqqiR6xtdVs7FjGV5esr3WfpPBbYJZIQfuWFZ
         Rg3H3pGUEmY1pRM0TPAEmB0HflFqSE+O/KKWTN0aG5Gv+QWBtbW7TXgcz1xGYPfzbyuz
         q4gA==
X-Forwarded-Encrypted: i=1; AJvYcCVhRbIu1hgdicEDghyvAKCLcky749VE8ngJOwpNpSSlu7vyLBlnctXC64jWicbwOxC4drqRfSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpf1D/1zgyvwCMtFOkJzzMhKDNxJKRuBmMyO37zGVbgXbnpLiX
	7WwvKBQFbasd3BiZiELXObrwiMrPRmtzbhjtu0Cv2/OpyxHz2t29gmdXeNUFttPWDbe1
X-Google-Smtp-Source: AGHT+IH98om1T5U4g5ChHra1MPoJ28SI7omuVHtAA3HaqAdAn34ErYy7mm9rWf0dk9MvjoSsW46BMQ==
X-Received: by 2002:a05:6a00:cd1:b0:717:93d7:166b with SMTP id d2e1a72fcca58-718d5f1879fmr23538716b3a.25.1725981534363;
        Tue, 10 Sep 2024 08:18:54 -0700 (PDT)
Received: from penguin.. ([180.254.76.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8210sm1493952b3a.36.2024.09.10.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:54 -0700 (PDT)
From: Ardi Nugraha <0x4rd1@gmail.com>
To: ardi.nugraha@provenant.nl
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	ardinugrxha <0x4rd1@gmail.com>
Subject: [PATCH 01/12] clk: qcom: clk-alpha-pll: Fix the pll post div mask
Date: Tue, 10 Sep 2024 22:18:28 +0700
Message-ID: <20240910151839.169699-2-0x4rd1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151839.169699-1-0x4rd1@gmail.com>
References: <20240910151839.169699-1-0x4rd1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

The PLL_POST_DIV_MASK should be 0 to (width - 1) bits. Fix it.

Fixes: 1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Link: https://lore.kernel.org/r/20240731062916.2680823-2-quic_skakitap@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: ardinugrxha <0x4rd1@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index d87314042528..9ce45cd6e09f 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -40,7 +40,7 @@
 
 #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
 # define PLL_POST_DIV_SHIFT	8
-# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width, 0)
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
 # define PLL_ALPHA_EN		BIT(24)
 # define PLL_ALPHA_MODE		BIT(25)
 # define PLL_VCO_SHIFT		20
-- 
2.43.0


