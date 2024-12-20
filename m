Return-Path: <stable+bounces-105404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2539F8E8F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAB618854C5
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD91AAA1C;
	Fri, 20 Dec 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vuWkiM2X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6051A7ADD
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685429; cv=none; b=Ct+vk9hB9Yu7E7I0ZKyITVRkhEw3Srp0N/540c9kMW9F//L9lsiUzbKpC/3kTMoMsYdBnenFC/fDvbcd5pKUGN3BsHBXgLbAzgRdirDP2khO/05aW6jn/CLZzHejlEE18nVfUMHa0gEHUAZDb2E0hcznVcsONKLg3KjFLVTki9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685429; c=relaxed/simple;
	bh=DbfIVgwdPOtjGyPYp3zFC8cSx0e4NRwlmaO+ILtD/1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rwNmQh9/+s7CjyssHbM4b+UbLdma4s5pDvUeAnfTdY63eHbV0tfg1N39x1CPUuAt35LEJULsza7xuMbVxxi6yvIKApJQtZUXDugAVaIjYvyPFRhVqNULsmxgeVM4cLBGX3UqhZJZZBBdOjQypqzbo3jULLBU7oqTinh8OOfRx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vuWkiM2X; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434e3953b65so11241885e9.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1734685425; x=1735290225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKQF6v9mjJTHAGrz+anbwJhJc4N1fYhnSvoLIwg6Hw4=;
        b=vuWkiM2X2LurHfl3/g+Jj7uFleBh8ZZDzDqFryqzDp9kC5QIc8gZ2WbFhc/TTsyN5x
         IZs3kh9hl0UccvbDEYBOQlMdhXagX4bHcRRIIpbJXJTN7sFNvQdDSmtaXQhTOYRfeOOz
         M4ZKV9qzuxEcw3FGFo4lOazlVpYOIrfLPFZBui5clscZelSHKo2L/PXSSuIa1Qknaf6K
         UG5DwwVxu45S4zgKRNtr7m7EfpT5X8/rjvxsgFYATcKobrG2D+935LQAUH5+Adufgl6o
         OTEuaH51tfS6q5fjpO1mnZTTH6XBgcHK3oKjQB5mT4ylM/e6BD8ldfwIbiri9Qp7VUDh
         tE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685425; x=1735290225;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKQF6v9mjJTHAGrz+anbwJhJc4N1fYhnSvoLIwg6Hw4=;
        b=F6/xEzy35BRPZru0lNYfrzOeYCsuG3p1JEPjWR8q89u8EfFqRq+Qf6I60de9dPyEyH
         cI/f49mQpj55hajfbjvok8TIAVuHtYh5U5Lmu68VzS81tnFAyIgsokZNFMwrQ0xoJrvq
         UjqGoaYD2HsrN3ocQQYUfufS/ozn7beFWr+UbJmPGKpKICB+LDhhi0cu0Tky7DdrSs+Y
         k1jijpFlyHr+5nx30NqEDku6Lu1Dp1W6NOnLMksLSZesUied0pIgTklS0OjzdIyYOONm
         zt55K9BhIvuiAsQAbO+Jtmh7dy7P1P2i6qALrc3LWoVa73igpAv9xnE5IcsXKcHWSG6r
         R2jA==
X-Forwarded-Encrypted: i=1; AJvYcCXjSItGIIkey/sKGOGHLUl3lRc9vvZpL8HTTukUrhEcpAKiG2pHRo8IN+phhvH1+f1T6+aCiMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TtmGd4ERozoYGQ1l5veKNTQjpEqOrmXaow35GAhDTMYnTlmY
	zWNxxfRLA69uNav4HWCl+ARn8+4LDQTs0pjgnO0HxGWbBAsH6rvTwvJrPqcHHvFhhR/eC1fKLGX
	pq7s=
X-Gm-Gg: ASbGncvD+WrUuKcp/UP/NUkn/Waju3oDFz9SXDk9eclgPZGpEidkCAPUWBn5VNXYw2V
	WRFMtziwazToVhcq9/5JnnxKBY/q7iMW33jMmJRYq1Qkqg4B6PtF3CuecSHH2cGOenDSlm/Qrbn
	Q06fI2SuzHvgkfH3w0+CqL8AyjzbDxPCnjG0zwFmQLgtd/OS4bOIMNzJrEuWzQiZfakVNyXghgW
	XT+B4rqC/srWl9wyHRF9Hgi9rvGW1wQDR9PR6SWiQ9Q8QfR9M/Q7mq1Ws4RUucvgtt/jeAUpVnC
	JzHb0aXAXXT9/ruA9rIIe1Eor5CI2w==
X-Google-Smtp-Source: AGHT+IGSHfVV7ZgeNmbzBWx67alIxQ8s1vI3ArjQYk5K4x5dU5OensPI2MOkBdI3RPTXPnjlqYDKeg==
X-Received: by 2002:a05:600c:4f51:b0:436:1b7a:c0b4 with SMTP id 5b1f17b1804b1-4366854850emr12697055e9.1.1734685425468;
        Fri, 20 Dec 2024 01:03:45 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm40610375e9.7.2024.12.20.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:03:45 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Add missing parent_map to clocks in SM6350 clock
 drivers
Date: Fri, 20 Dec 2024 10:03:29 +0100
Message-Id: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOEyZWcC/x3MSQqAMAxA0atI1hY6OF9FRKpGzcJaGhFBeneLy
 7f4/wXGQMjQZS8EvInpdAkqz2DerdtQ0JIMWupCaS0FH5UppfA2oLvGw3oxS4PtVClbqwZS5wO
 u9PzPfojxA5EIHo1jAAAA
X-Change-ID: 20241220-sm6350-parent_map-c03e9b61a718
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If a clk_rcg2 has a parent, it should also have parent_map defined,
otherwise we'll get a NULL pointer dereference when calling clk_set_rate
on those clocks.

Correct this on clocks in both gcc-sm6350 and dispcc-sm6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      clk: qcom: gcc-sm6350: Add missing parent_map for two clocks
      clk: qcom: dispcc-sm6350: Add missing parent_map for a clock

 drivers/clk/qcom/dispcc-sm6350.c |  7 +++----
 drivers/clk/qcom/gcc-sm6350.c    | 22 ++++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241220-sm6350-parent_map-c03e9b61a718

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


