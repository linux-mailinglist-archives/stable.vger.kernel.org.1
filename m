Return-Path: <stable+bounces-202916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D197FCCA1E2
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E798C3018F7E
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF012F5485;
	Thu, 18 Dec 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf/KF8kA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED31F9F7A
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026782; cv=none; b=kh53Yhivwk8hemwG7uMEIVtQEhysx5WHNhpTm41YnczKdiTOLzYw5co0c3S7tKBDANQ+34LcxqJ9PjfMKUtwHBphb8hoVd4CNxlhujVZD2Mq/0r5OYExnAtXnvMS8h63g3BOv5GLu3qWoDty4TLskxDE8Gd+7FDKxBVXQjfoVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026782; c=relaxed/simple;
	bh=3yJqIUEUeZVkFXlqRTAntvExydA8frPoRSgPiza+JEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3eMazALVMZYycJNeE29cfFhp1RSmQt3Jx7NntjErfIMtXBET4XYaHN77eBEJP9U7go8zem4ENmFicRQNwTN6+yIXIT/7J+p2p7Mkcgyopo9822O4BO/NMRAAH4WwlC1XxD3TZA0sFlyVg3ufXICPFIBF5v9K1z3hNfxgxz2pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf/KF8kA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f3018dfc3so383325ad.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026781; x=1766631581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEuwYEAlKeJ7VBeR49Tc0CIfJrf1FLJO2ifR5/NXxnU=;
        b=Kf/KF8kAWAhe5SrbJeFnD4qZOL2c/yZtigs/SYDh55h1EbUoBC9GJIBicGCpo3c07X
         s81yVmQIEsl/2MLjjtD9SPQmJtCJX2DQRdeU8J0QNV/TPn5lbN547sxxwd+qT5l9E/CL
         JfMok/nR5v7YSLRPjIoP1Yo2ijufYx/L/bK1tmwlddJp/9e8n8LrhwxnLzVBJUcaynYh
         zzBvzyJRDhcjJZsDrZ3oeXnDiGcSWfGeHPwMciOvQylXcZoyWPnxpg6pjUBZkJ3Kq+lS
         ORWy70qcbdst8NI/LsfK2UOIGtm1mGBKwNu2l9ZzVYc4KhC4c1jRMpH7JHIuM4XfpUuv
         BEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026781; x=1766631581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEuwYEAlKeJ7VBeR49Tc0CIfJrf1FLJO2ifR5/NXxnU=;
        b=I3uPadPnKXJTtt686IZfyICjFCaAjrwdouI0oZdBfmnYC9PpD8qpqji2JIlUJRGXfR
         OcStanRbfiwIMpmKK01PlAQAdcSxOynkMRu5D44E7oLorKT7M6oopl8gu5voFX3Tvslp
         CKllUib7oeUdOKcUE8ciOqGyjnmgXH0Hmuj+Fzms7QQxJIQqv/mUJS7uwMRo1qww6Whw
         IOhRBOwGFTlxliHKY1RHFwFLxFazBHP9cPstKKbXfH/1AMftZztYCp0h6GgSpWZZD4P3
         clp3ZN3RGuzSwD2dZ54xUad9neAdUVBNDpB6VqIDKF399tN06hC1VA4CBNgsjZDnBUtx
         KOZg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2uXVH0wurQTmpVmvt9HVEey1j5PEx92CJQ9dINIXrgI949AiJ8HIF933wnxcSpgU1d6J8vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJFxVws3wn3wkdsURiT8JbIPC8zapyoiHst7l6KoHsxskG0Ia
	XyUiw1VZGp6Pd8WrlbsiJnoRkoYO2E6lVX/czZ3iCsrl1fXlddGIKi5v
X-Gm-Gg: AY/fxX7kS3K8nzM2+jOkBXYdLeVcnnykroMuCn8CQNtRFBEYU9/KYegLkxBfeyI1MkJ
	supCqGZpuMfeZfXprpi56RORaufgu74RHmwnEHEaqn6wd5qsJbAajuEKdXpWF1lGe//paWvufvB
	KrziZfoAi7VAZjxQaIKBmUdVWbq//Jtti1AKIy7ylhz6PUpk9Zml/NllQAPN7CNGIk24yhFRJMo
	UHg4GCV5iGqOCzx5XxnNRvpB3zDD0I9UK6UyVnveiGS/PEJaMhmeXLB6r55oftRjWIFSPU+iSGp
	egKxVZ9DvBXGHG9HIOsq9G7AKu3D6xsVHZBzMRJWPWOE/7i8kmdAZQ/+mSoaHzYkfcDiWgNvzSq
	spdvj30Ei0bguUgjyr66PQOuikDzOSR7U6i+n9WgRzzz4RlKAMG/NgrqkCQ6FtHJv25M7ysEVKu
	d10blpPdpYYdB26vF/RHmdQJHqHYIQ1lmP/fYnjQBHIt8K/kz2IqBIIeu6wDDfhILgE9OHCbvd
X-Google-Smtp-Source: AGHT+IFCBiK4vkjcQkByNE/wNdhbQo7lMtKJmkgvLn2E0ZvZv7wYpskVlyPQVdr53mJhO4ELd2OXcA==
X-Received: by 2002:a05:6a21:6da2:b0:341:fcbf:90b9 with SMTP id adf61e73a8af0-37590b7592amr547611637.4.1766026780872;
        Wed, 17 Dec 2025 18:59:40 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14a5727fsm800985b3a.69.2025.12.17.18.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:59:40 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v3 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Thu, 18 Dec 2025 11:59:21 +0900
Message-Id: <20251218025923.22101-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Wrap commit messages to <= 75 columns
- Use 12-char SHA in Fixes tags
- Verify Fixes with git blame (both handlers trace back to d646960f7986)
- Run scripts/checkpatch.pl --strict


Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


