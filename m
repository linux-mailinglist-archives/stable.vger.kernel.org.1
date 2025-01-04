Return-Path: <stable+bounces-106749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D964A01531
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D0C162799
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890301B87DE;
	Sat,  4 Jan 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRhGcIJ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F931B86F6
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000423; cv=none; b=alISXNx9v3dOTpjg9oc6Ol8KX+wA5amF503N9TG6mV/JnN3MPG42QkDjuIuNO0bAtkRnm2xaw1Ke097BLzJOVVmXj2AOnAHq3b3leO3VVlVohreABKHwdKjWcySvnzlB2VDerdDg62zL+3T3ycZS0KrdvB8to/zxQn0mLi/EqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000423; c=relaxed/simple;
	bh=wlgxcR91kdVftL/+E8lryPKTkzfeghmha9JvjrZypF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz4thRw4wEz0Qtd7//1EFPi6sdiwJUEcXbBWpWIU2vjHmLmfgxstnIzh1Jr5EuTMgLt2EQQTdTPyCcc89JYyxarUYaULaqCoQGu2pQzb2/QguAXlENziKKbnjMCndlNZaAnHrOcbhCDFKQ8ydnDFsRhO2tz8XhMJYNuGAIuDkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRhGcIJ3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d8753e9e1fso1856694a12.1
        for <stable@vger.kernel.org>; Sat, 04 Jan 2025 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736000420; x=1736605220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNm4lO8LttsScN/mHpd035i5M1a7i15vRYx1Fsr1FUU=;
        b=qRhGcIJ3+fDfijG5ynnh4saEumJ1gmBomtLmZmpfmdgwY5zdRu2XiWuVrt3fg+D6YE
         IwpQaFI07bG8sPvlmMjPm38qcLqOw0X/5EWI5DvBZLmC5VD7Ef6NltCD8AxSS9zWSYBU
         gV9tsrBs+4IV9sLN4Q3Bvd9ggRs8uxzHoIlYX7cT9NbvZwuAoNKGJHwrQvxfc4rnxPwi
         KR/5k/79PkxKgTKbeYKGdujjAtXf8Pk9n6z5kHWHDw5ltNMXA0LmMBsowbAHnrq0SE8L
         GcdGb4blCKPIuBNHcIrihKS8+FaNiEuQzhy1pL4DibKMVvc71J3SGMSGcHSg7dJ5KWFu
         hyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736000420; x=1736605220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNm4lO8LttsScN/mHpd035i5M1a7i15vRYx1Fsr1FUU=;
        b=TtGC72D8IhUt59oLP7+suhQlldQSpIyIfvLgLwlyEIFlSqV3U/4LolgdYHB2NQo7zW
         H4EEth623IbDjK/1MOPtelsvGef4ZZ2Sx8IWghBqvR9RbOJ1V9zXr+5Slzr5ifWF2aQS
         etGOhCdE14uUM7ntnMxTsIlACiRI6en5pczN1YlKL74MjAlAeGEoydbU5ZiOr5r6gkYx
         k4fhV8Uu65VmCnSbdV+kWXBQvbAKlAey5vzy5g9d9Sv6wg3Dx/aa/eRASH2v04Q0X7K3
         fMxYModxHt5khN8+5VMRe5yeTfBF1ZB+0I+j33pboiOw85iaWyEvPBFZEC4KBzJ1L/YV
         4YsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/6bgNPxTOu9cxmqjFKIztn6dHcO245/vgdfeeEZU+oh0Uza8l8KfQzupuMJtnN9PAV3ysMQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjGl+Hd9u5D71QdvxJqojqrvnDnz1uht9fPS6X/z7NHjN9Pcv
	tPSvlTNwfMM5s/uo/wSneg18kAdrjdEboWYXr7EdnCN5gopvo174I40hw6/HPfw=
X-Gm-Gg: ASbGnctL1ucKZiC7YjxiitOeLimm9Y8Bjg2wIEzeAY5fdp3R3d2+qp9djzIRtC/hwmC
	Vv6TGnHNF6go/eE13t5cRqZ1u+wP3BJm9Dj4UTgk5DqrJLIHuvHzu/FMM85WjLhvkx72YUQm8Af
	WSZXfiba/dAg9M2p4XSGo3kKbABO508a8RdnILkW3stC+nrCNWkmB5nRUfho7sUKZvOhwp48/p3
	iVEkqOWlH9hZd1qdbPTXcpeqNr19ihM+CKjTKe59KNhY9Qm0r6x+iclBc+n3c1ubqg9cGo=
X-Google-Smtp-Source: AGHT+IGPmJFIHjn+qicLAczIza9y3UfewpY8vqEm6a6NDH7ku9/Oq/dk8QplINPtjBf7vNpk6BgDGg==
X-Received: by 2002:a05:6402:3221:b0:5ce:f524:c15d with SMTP id 4fb4d7f45d1cf-5d81de33f7fmr16791923a12.11.1736000419643;
        Sat, 04 Jan 2025 06:20:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fed4e1sm21376270a12.70.2025.01.04.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 06:20:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neal Liu <neal.liu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove
Date: Sat,  4 Jan 2025 15:20:12 +0100
Message-ID: <20250104142012.115974-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
References: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver removal should fully clean up - unmap the memory.

Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/mediatek/mtk-devapc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 500847b41b16..f54c966138b5 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -305,6 +305,7 @@ static void mtk_devapc_remove(struct platform_device *pdev)
 	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
 
 	stop_devapc(ctx);
+	iounmap(ctx->infra_base);
 }
 
 static struct platform_driver mtk_devapc_driver = {
-- 
2.43.0


