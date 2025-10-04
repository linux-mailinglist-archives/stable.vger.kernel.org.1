Return-Path: <stable+bounces-183351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F00BB87AA
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 03:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5825819C54E2
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25F35959;
	Sat,  4 Oct 2025 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k31ZZfSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FF12B93
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540534; cv=none; b=KGbcpy5fh86BOvqWGzUIszDl1gfGrQAZGp+RpsnBEoDOLy5+M90AVEWPADoTn/36QW8xkCJG6SGdJE41kIigZ9WDDSn+Db76MMO1TWKVHjPFQU2XUWfthvrSop88p+C5bqUDArfqpykoLCtrFT9fRDVWt0xxYH3h18m1Q5QMzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540534; c=relaxed/simple;
	bh=ozrD/peI6GWbnjfEB0am4HrVU0aHO2Cal0rob+h8+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WE4I6drVbiEHNgfEWhfQ++bJ4swQxuK1+3tKOwA3Rz/S7WhHz/Hx1+JkOxrEmRrjiWUdHDtxYS+ZD6PbaJooi/pxh0AUadSswWXGk/6Op/j7M/qPV37XBJ3C0WXILfRtuUXUl8DIKSCfoSp46K4D9gxozQDFLtyElB2sH5egKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k31ZZfSm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d2c35c459so20151665ad.0
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759540532; x=1760145332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4oJcHCndXOje2FL6bfxG8G5ibctH8M0O2TsZseJRA=;
        b=k31ZZfSmBhYF+LpSypimkNtQ3SqtEZmF1mtB0zwblCKVzcx02P8k7FKAhhRJMeg4ij
         osEJoh4cqgdV3941Mng/lK6FRx6LYgeksKyp5UUWGiGpC8p46hlYVQ0TJlQx8KrLFKM0
         9s3oU5TPG6pkxBw+ClRwLy4I4ke48k2Cw1t7ULCheDPFJAte4YfFCMNeqFuTnUmmPcXw
         7ae1XS+Dk8eeKEIq0YH3NiHqha93mKCmXGjOFRFIVm3upvFwM2NBucUKhpIX/wPFx25t
         SifAHexwR4PETDdwYcCaWXxZaK1o7DXFPZUls65egWVr7scv6bPvNK1wpLLadFCWsQl8
         YkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759540532; x=1760145332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft4oJcHCndXOje2FL6bfxG8G5ibctH8M0O2TsZseJRA=;
        b=XpSos9vcYiUE5Og4MYQVYGGV7bPvhtFtIKdy0ziLzmpTVAdPdmjEsaALzBI+MJufx0
         Fy55OtMGu+wGQbLYfaULGybXPrPy/GRN66wbuous66Khbwgj0D6suEHgZmb/4ElO+bz3
         WQu0z4kjQulNPNzCq62gvxaS8eDiNfZ9o9yO1nFYSu1OhJYcfugYMZwxCT2NdbR9HhTh
         VftevHyIaJyP++jIXa4AEG5tl9X6lzb8JOlQvuh7MWrz/vV6U4m3hQTRHqT3CLNeEOOK
         l9q6VUVkhnMl1YOMoyDOKPbo9HhmDp0rjN2AD2JnlIsevKZK4wLBrvZW13K0mVTkqhqk
         wyqg==
X-Forwarded-Encrypted: i=1; AJvYcCWL/PTZgZfvyCbejkheZZBLLM7o92BEQJS9XWRLLnk/HDHsbJ4yAJvEkxKngueEb+H6l6AFBt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFobRFR+dosKW8rHjnOPvBmwH3fU1CbqXCzaDpnXX/xx7tVswO
	X40vQ4i4UryW2G9E3x3lL5TnW6VPyXhq3Ssr8qvHQ2p4eeYe4goTlO8Lucb5+TgGtPo=
X-Gm-Gg: ASbGncvyoGq8HZqN9GhQtps3bf5aENI93pI3R/CuXlUoBokkrCSjcP581N5jqfr97Sc
	ZkAylxzgg0d2Mkt6Ra8P4Yfd2nsYq/fiApIj6hkOTTBAh1noNXRxIHX6+WNvuFTt1ISflpV0ovH
	JVjq/Ia4NfGZbCB9ZgIMD+flmfD9f9/6f+FErVnEn+qCcJqO+6nJVljWlEXipYY26uo41vpDpx8
	n6Ai1mSj0KlrgFVHiVvvEjeH55Qdk37V93DojoOsfdUQ+nIoh8VDKXBqgr5TbsuX9r+NtaMZ8QX
	V0DyoUljdy2twXZcj+MoBHVFdFbjZvLS3+dZ7RtZjmAO4VbaififXnDCA16kc8+dMg+CkHgLAfT
	e9mzsbaC8Zb8vpssi8JUbAyzeslBeydtMfZa4WxQEqTqIpxBxCppS/rThK+WUkJ3G6B0R54De6J
	PMI78stdJ/PDbVfNyzx2Ny9zzzA8o=
X-Google-Smtp-Source: AGHT+IEyCHmvms5vErzLy5gTZbE16mnhBHhNhmvwIzKJKVDW6N1jGKpi5QbCIBUQ7oN61aL3umREug==
X-Received: by 2002:a17:903:298d:b0:264:70e9:dcb8 with SMTP id d9443c01a7336-28e9a6fd918mr56953665ad.55.1759540532424;
        Fri, 03 Oct 2025 18:15:32 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:5d47:aa18:ed90:18ec:5962:971a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d574csm62324145ad.108.2025.10.03.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:15:31 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Sat,  4 Oct 2025 06:45:22 +0530
Message-ID: <20251004011522.5076-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello Ian and maintainers,

Just a gentle ping on this patch. It's been 10 days since v2 was sent
incorporating Ian's feedback to merge the chanlist_len check with the 
existing early return.

Please let me know if any further changes are needed.

Thank you,
Deepanshu


