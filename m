Return-Path: <stable+bounces-206276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B5D04A62
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C63C33B2F4E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8533B9617;
	Thu,  8 Jan 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YCxRmC+O"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC73EEFD4
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863443; cv=none; b=eJEqtOj22Xdj3/GhzdQ9IPxCRovTlbkG22p2IDqv3gy5he4mJHGGGo06vutE9N4S87ntiCMqxTuEPehoAjKbY666gWATbjeXzR+WEZB2ROZTQK1qeraf4+UgtdaOqVQzjWrytIIbo0so35C5T3rPMUmERDDlsJimLlFbYJ5n05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863443; c=relaxed/simple;
	bh=My9LdPfbtVFSB3sp0w6t1oa4q3QaS94XKVQNWPjyMq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzG6flrNZWHycKvf7/iq2UKVFmZFsIRJd1SJCOf3xcNgwAesxC8e2t5HjIffia8Vd+v1/B8Q3mjOuoS+Yp+x5so/7OO10B/KqM8nGhv/yj16bK8LVowj02UWzLsD5EdYSkCf1e2NC2Ab6tMn7bKDoV+sfhwU8ygpSdmB8zugiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YCxRmC+O; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8907ec50855so31364966d6.3
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863429; x=1768468229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiMjUjf8apd8PnqE5AATGbYetcy2Uw3TxDHDwt6y7V8=;
        b=NMzBBN9L8indNyeMZSmPwNQbMhOd932F/opG8OeQkrO9B1/Hu+lOlw1YSXIxrKTHiB
         C7pSBpDcvZv4/v0+EFugtbYc68n0FKUf8r3N6/m49F1aU86ppu+f1BJDDftqQgWxZBdX
         1oSn2zphZEUPLwaWFiIqAgjjPCWqtsg8au6xD3KeEA1bkvhTvb8jue1pW9NRu7TKw74Y
         hVjfIMNnLKLMLLqT9kvQ1eD0a1NoVlWVs6FUxLuUoyp67yC7VxzRCvaHhbeuMxvBLht8
         M7oVRCtGC05CWdC2DqtIjkcJzQen4SenocBgMvGr8K6SkF8ZCjRzjOhE3C++pVKPf3nz
         vvJA==
X-Gm-Message-State: AOJu0YxZ2t8XfOdHdpOMI9ptmO63qHmABi2iTPwlsxCQySk1h3J4ghQF
	rbUiUq32H/xKiclSeZ+CkKTBsRJ1TKmv7Z5hvYyHUvZXg3O4EF8crRcXs3GUOi7V2iPM2xUNyw/
	L3oZ6WdOWC6wIP4LIVqgdFYVaTSQAHzYC44jSB9cKtNhlIuEqx42pU+Q899Lizq3qcXHm4zJQNB
	n8fgfnUya2JdZjIiOqnUlgHwspMGZszEY0td9GMky5B9mGEIJgKoxQ4jB8J899el+hNIK00XhG4
	AJIJHzxPASVLxY+Tw==
X-Gm-Gg: AY/fxX4P+HPBK95UqPK+MrXxPmqKCDgnyLqENCUWGkf8IM/c2VbltQeHe0EwEF/3TYc
	CVbbOTjoYeErnN70xpFuhhlwOn2UuVh7PJiTzORCfSZc9uozSJVTwj1ruKfK7r5kMJbcZQe/+mH
	ozMUMHtB2p54lH9fypFuJzzol/JKBMSCo+9JK3LFS9hiMicy+bhRizzinPqW2sg/xJWeeqdce18
	Ceuq5u0KC2ySQrW/KpuOjn50PtlVatQsvcbaicjdjyaTjAL6uYxTWVBKm0nRtvHMVGk1mYQN2zI
	wFjq9ImiaAW2GaJWsmyV2q7Gg683js+IQL/RpUdrzeqxtqU316syaftWnMri0q1XALPHQW8rWTJ
	636DpfQbZ3ZjPtVwrLBh6UJ+f/Wp2KCpjMo1RhO6DSIH4lyWCfn5QUQakcGKClAgunFSjN/+I6h
	z12pYg7t6D3kCwxjvCsfm8yQtir+kLcYwcVqnTThlLYbQ1pQ==
X-Google-Smtp-Source: AGHT+IHUZr3fRmJd5SF8zJMsx7oI8lYNZfAkWzP1iKmkSPQtY9CDSJRmR4x7JSzILUcPIR0qUcTIeBFtTzW3
X-Received: by 2002:a05:6214:485:b0:890:5770:7f7f with SMTP id 6a1803df08f44-890841a4b0amr72971496d6.21.1767863428643;
        Thu, 08 Jan 2026 01:10:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715ce0esm9418956d6.29.2026.01.08.01.10.28
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:10:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12175e560b3so3402213c88.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767863427; x=1768468227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qiMjUjf8apd8PnqE5AATGbYetcy2Uw3TxDHDwt6y7V8=;
        b=YCxRmC+OsyOi89py4gTyrZZSe+O7wXRx4BNQ133qJOA4+Dfv6Faz7VszQ/D/XAM395
         UzpUTeLyFBUIIcWnPMeHUEhgs4BN0FDPUmfwoRf4ooGuQtYlI7JSDdHRPh6ZxcJ9Xnv8
         6CuFtwaJWov3pt65U3NL//GJxIaZe+/DziOlU=
X-Received: by 2002:a05:7022:493:b0:11b:9386:825b with SMTP id a92af1059eb24-121f8b7799dmr4741744c88.48.1767863427048;
        Thu, 08 Jan 2026 01:10:27 -0800 (PST)
X-Received: by 2002:a05:7022:493:b0:11b:9386:825b with SMTP id a92af1059eb24-121f8b7799dmr4741707c88.48.1767863426192;
        Thu, 08 Jan 2026 01:10:26 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24985d1sm13267619c88.16.2026.01.08.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:10:25 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mathias.nyman@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v5.10-v6.1] Fix CVE-2025-22022
Date: Thu,  8 Jan 2026 00:49:25 -0800
Message-Id: <20260108084927.671785-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2025-22022, commit bb0ba4cb1065 is required; however,
it depends on commit 7476a2215c07. Therefore, both patches have
been backported to v5.10-v6.1.

Michal Pecio (1):
  usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Niklas Neronin (1):
  usb: xhci: move link chain bit quirk checks into one helper function.

 drivers/usb/host/xhci-mem.c  | 10 ++--------
 drivers/usb/host/xhci-ring.c |  8 ++------
 drivers/usb/host/xhci.h      | 16 ++++++++++++++--
 3 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.43.7


