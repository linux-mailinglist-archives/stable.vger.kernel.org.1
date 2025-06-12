Return-Path: <stable+bounces-152539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98400AD69F3
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 10:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6553A7AB6
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365B21CC4F;
	Thu, 12 Jun 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eeeec68B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBE1A2381
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715643; cv=none; b=sp+I6y+vKgZaHs4MbwnABbZQ/wT/XvBOaOR7+s7BTxMs3KqC0k6wbISXqOwiGXj5cS/dWn5wAQJ2eaG3PlZPY1YUa554xbWJg3zfd0QX26Va0JL2+L2GnD4lkpuSbYdlHDouiE3Jgw9u6S/2M25jXG2YgW5O7jEdU18JHTIiIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715643; c=relaxed/simple;
	bh=8tDz2WWtHl5iNiZtu805A7AYCZLwxYys726Q+3nadXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o1g9ZhClRFP7yIHUoRUTfkLWIGmxC0a4y3PNsKp+HPby3KPDccP2a7MDcoiuWD7MD7X2Ya03gx+fL7Wl5AfZHVciZm8blUY+E+lUtyV+StaHrpO8ikaZSlyIbIupFen9mGlsa3DafY3mTdu/snoiEi+dc0XN8N/yjK91UeK5wR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eeeec68B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a510432236so636133f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749715639; x=1750320439; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EsXhAjGTTQWpaDRlErU9rdRhfOKTZnFTlIFcBZuhGs=;
        b=Eeeec68BK+ZVINceo2v3/MoOp6XZjFie5jO82x99y06q5MJctyeOMq0LVWL2idfgxn
         pXuVu+z+x1M6hjoATQ/YPBdwNryPfRH8/dol1IoTwZ5ClwNimNCtMrZv3w4gsSXMTDFC
         Myy72ZJis11uL2KuIh9rmFZSQrPL2CVTd6w6pVXJtGFIvZINUBr+HeOxzIFR7R872qMI
         8Ows8AGMrBqKwpp+Gz94kqnESkDiyO1UgIOP/haZbZQOKhKDu7H0SyYgcG5+9QNcm2Kb
         dy+bnPa45mPbUxAWaRCizI2SnW51CLdF7f4083CE951yMxgOLgR/hQcV7GTBmhwzzf+Q
         GCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715639; x=1750320439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EsXhAjGTTQWpaDRlErU9rdRhfOKTZnFTlIFcBZuhGs=;
        b=iWnH0tbgt1Ww6Xm2BDVSWPsFEZ+tBgqnxjA0+WTgbvtEqSrd7RAZ7EuoDYhOECpeWj
         5SB2X1GLDBmlSDcKy+qZ4HEg/DJahtGypCBIJBX5kyFgB17rua/4qXLsICfqcmlgEsOn
         lyZhaRHXHzlW8LtQyyQHPTb4tY4cB0leGieEdYi2/Xik2z8agHdINYL+e3/xhtTFNh8d
         BGuc2memqbc5O6UFpKkMCs6+IGTeNlg/KfD9io4VzLCIqaT5BQaRxJebiPI3blQXkgdY
         NafHK/804X4GgHK5muufPtmlEK/AllEJLT6s9vK9TkAUXgBPJidYBU9fQgqXP0/AKZ5S
         Do4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ+CcL9t54nLCr6RjZGXSKU7B+uuOUckY5FHRjgJf4l0QpuYYK/qCbd58WOPfcWG5LXBI1Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkg/O+iEg8F9Uo38nPeIEVo7x7RRftADvXuZuz2P45GdPssI36
	VVVfaY8wu+4D3K9o7hYyRIGdKSXtou5f/y+fr6M2g3zCtjqMxDYarJWwQ1sFb+IU+cQ=
X-Gm-Gg: ASbGncsXY0FsP8r301YLLvNju/9Tlyg/7PF9e83AYAuIzwM1TPg8IhyzYsi9EiUkaAq
	HaaWVqoOgPEJtYgpKuaiRIC4C2KnUGnbl9pZNydyesQ6P41I7XVGE/2Mi4KjnQ5WvG5BfYi5f3f
	lBeCFjfySiFGwC3blzY4Sn0/C50IKbqVlQjXlcvZtAwQH4a8KX1xdRDvlqA4FkBXUUppZJ0JKed
	W7EupbPn02SYqLN/JRmLMa6/x8UgRB2v+UfoSriknCNvyn9HfSURtuy7weP+0aMDH2V91WenmXI
	RBw5HvafOGGQ0znDTOlZ5Y6fPVX9fciLFgr40GqG+6U7AuMFmh53cKsHojERhIKl7lRPEesDorF
	aAB/Br5Ip2Xp6Ou94Ch4PG9o=
X-Google-Smtp-Source: AGHT+IELKF2BpPbSWqRYk4Gz6CQukHgSMRWMkrUf0ssis7ZGRpZXgfdefuUMTWLkzrdWYkstVJZCJA==
X-Received: by 2002:a5d:588e:0:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3a56130ce70mr1541851f8f.55.1749715639161;
        Thu, 12 Jun 2025 01:07:19 -0700 (PDT)
Received: from [127.0.0.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c64esm12942335e9.7.2025.06.12.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:07:18 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] media: qcom: camss: Fix two bugs in mainline
Date: Thu, 12 Jun 2025 09:07:14 +0100
Message-Id: <20250612-linux-next-25-05-30-daily-reviews-v1-0-88ba033a9a03@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALKKSmgC/x2NQQrCMBQFr1L+2ge/sbHgVcRFsK/6oURJtEZK7
 97Y5SxmZpHMZMxybhZJnC3bM1ZoD43cHiHeCRsqi1Pn9dQqJoufgsjyhvNQj6NiCDb98Nf5zeh
 6jr4j2TNI7bwSRyv743Jd1w05S/pscwAAAA==
X-Change-ID: 20250610-linux-next-25-05-30-daily-reviews-47ef54eee7ea
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Depeng Shao <quic_depengs@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=8tDz2WWtHl5iNiZtu805A7AYCZLwxYys726Q+3nadXg=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBoSoq0qnkiS+TZmmJnu9CFHauELJP3na1Z5aUm+
 he35PUBSsOJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaEqKtAAKCRAicTuzoY3I
 OjYpD/90owDahLx/oFJlZo5Dugmf1+6K/ibsQ/tHTcVrnVzTfDIQ8SgAsyKaCu3rT9x/pIvsRoJ
 8swTBTOFm1n9Zvjt+i0lDh5FY+gKvOmsu05f0JNTzBYZjjFkv1aAE7Noh48Zqrfjym5qBmeIet9
 VTxj/mDb5wyg6Tx7A1/te2bhnJXqaBl2/d988Ouzsg8DWMxIAfZlLrQ76dG0JQ2deoFiMHTvE6V
 h0O3k1rgwBE9nSHbqUrY8n2t2V8y5GByYHrezqpxswjMfdQ4wqhFaulTgLhuSEq+dl49QVpcRL9
 tPxXcEqzxzpATIg9Ep7CLFXH+eAkppLZfcDEiXIK18GdFgOJhTxW2ppSvlNNOXtDzH9XgkqLTW6
 lgZ1tWxtjhdDkiCxN65I9vn6cbKELju4a5VrS4qH4jsufLB4ebc/XAfX7QLGCYyIBNPn+dhBglo
 Edp9BoOx0kNd09gFw/qZFIKrzZupQtHjB2oqLjREzpcr9Mqn583jai+4UKPfjoqa+3eH3N9/BjX
 AGQOM6v+uBKPXB+ai/pbih3ZeEZFVaH4T2mJkZ/+vKR//o3sS61mdXMGJYPqQ6PxuFCJiZOayj+
 1ewPnybUvQR0MkXP75LDSIcac07osETEn+xRX3NjvAD4mWIFHhGjCS0rdQEcxWziJ0UEv6/nc9T
 OQxxF+8eicIIwrg==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Two bug fixes here.

First up SDM630/SDM660 hasn't been probing because moving the CSIPHY gen2
init sequence into a common location also moved the default case of the
switch statement which rejects non-gen2 devices.

Second is a fix for a very longstanding bug which is a race-condition
between fully enumerating /dev/videoX devices along with all of their
dependent data-structures and gating user-space access to those devices.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      media: qcom: camss: csiphy-3ph: Fix inadvertent dropping of SDM660/SDM670 phy init
      media: qcom: camss: vfe: Fix registration sequencing bug

 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 3 +--
 drivers/media/platform/qcom/camss/camss-vfe.c            | 8 ++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h            | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 8666245114d979b963dc23894a03c74ecab8a7a6
change-id: 20250610-linux-next-25-05-30-daily-reviews-47ef54eee7ea

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


