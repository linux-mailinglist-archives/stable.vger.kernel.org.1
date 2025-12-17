Return-Path: <stable+bounces-202822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB386CC7C43
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE64318689D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457634EF01;
	Wed, 17 Dec 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGnsDQXA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02C34E25D
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976282; cv=none; b=WRRL6MM1NH/pQ8Q5XJBstV+GoBWgZlwh3iMHl6F5zvFJ+txKTHWik3ozJhb3p6TBOyP+FjNGc2HbM3V1ks3nM38GfnrTQbOsgNYw931z9OOIfDQmD7KB99xoSKOAPtfBZ90fFgtMFDq5ABdk37gJzyl+wP9BoWUjHiDMYjPARPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976282; c=relaxed/simple;
	bh=JR4+kJaBlmpbY4kjmuT+WtD5sCcuiWQvS1lbYm26OEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1llLtK/6ROBbr58SuEk/bBlQmls1wSE6ea1hy1JjZzau6VBe0n2C/3Aj62Y/9J6REviqNrd+5g8N6bAFXvsKjWN1ofLFHutdjQ/LSEVECz64KOlx3iS1tRqlq4ithpAjmlivlDLYtI1Q6lY262QJnUjdulHfF/RCRpZn9UPwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGnsDQXA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7baa28f553dso153391b3a.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976279; x=1766581079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=NGnsDQXAh6iw+EUoYkWvRRhp9aYu8icQkynwWnGh4a+pf1/Rt6P+GW9JVDAKtPDGJO
         gbBvgnsUsf35lp/QxcpTeauUDa7gz2a16pdAAbPfkmEZNOQlZ9/zdu0WMpgntfd2rz7w
         gdhHXo9n93mxq8Smv6NtrXh91Dieas/ndTGJnS9hWXOeSavmR4W6oRcKgTzDZ969Gl9Z
         jf1TwL/GHmzvbknaOnz5qy61Xx7QCFlF3hg/05SCKDYyNqfjdxMnja5EQ+EeBp2mP0sv
         VrWiwYwHN2/SiYp8dlQyGsa0SevLOeLSriLH1RWUYXmiAOvi82e1GVEZMeLrBWftk1W7
         EDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976279; x=1766581079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=GiZzTvP3f4R+gkgy7XC2KBfenCljSYc321txVVjGYfNNgXeBYspoI6uzwNWYqBWU2p
         2H+/wM3+XLUwX1PcAJ6ytd122aNVv0ipUocVh4Atv7WTpWPs0/qnbh9p8z4YVz2fAkJT
         OCJP0r5ZZhdtkxsdvoT4d4PYfuDPJu4VXUQjHimFvSjmDzEuGykUswr3bPAlgLRxjJhr
         BdUdOssqYKtu0EwZB6Xw3BcSHWnqD8mnsRSJv+w7AhUBw6VlLl4QdMlp9qGCixxmR7Yz
         DpuF96irdqQ4PMlt/2/VHwqDrrszaHLZRYpQWF83uKEebxTl3EXJH3nzWzINCVgxRN/L
         3W+w==
X-Forwarded-Encrypted: i=1; AJvYcCXSK4gQ/ZkqJWpjqGjfUMn8UoYoWzQZAByNWL32RDTG673ewNuDzh2Y2q2x0ZwWaI/CBDW50es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8sjD1ctQMZbQGt8j8tGgIy7dlPutRLVYFqVfgvj5a0l/wRby
	OSb28B7ZTgXJBQuEZ+YDRAHuAVrjzl/FKxh+HisLOmUYDFTIJ2C6ZbHI
X-Gm-Gg: AY/fxX7RojAZMnH6UXBgCvdb6NN2yzwiuWvlzM8GCnX1LUINcikQ7bdm1ZU4yM8ueAI
	iTvBiWPIGX/7yNYO/fnh/rTKUb7UkPz9w9UrPisJTrW5gBrnUPW/+7TypBygJ4NsJjv3FnkZJAb
	j8Qkf9AIAyVh8Sxkf/CrpjNKavTmYxl25QJ4A6Fq4o4atK21Y6UOkrGyTe7FM2VesaD3qUUdhid
	TyXmlZvyvZA6GMXEcMfyc7ti352gxjVSxCuAINkeUvPCQASa0IEU6g5iKpjwarVzTBE40p2SUA9
	doA8C3U8lP/lZMBGnz/k8vsC//okitTU6x0qSGhArkPrdzCF/PGPk6mZobN1DId9DAroAUrCKco
	w7SrAtyOmQWhiAXHod0lW0JQeDjYQALttyqPu+hJTjHxdlBZMvPFY7xXXkgbLoqVjQy5Q0txKKR
	Myhb9kVAqwa6/jZTwTfHvTwzA0IYhKJHL6GWEOMg7rL3Y+IvfCgtYLaGVBkpiy82/BvJ4X8gou
X-Google-Smtp-Source: AGHT+IHeFwiM3NT69mj8CR+qRtoImQENjTvcoKBveMjhuZe4k2Ra/OXcxgpLyAQfJWV1SlZBc8mGVA==
X-Received: by 2002:a05:6a00:2290:b0:7b8:bab9:5796 with SMTP id d2e1a72fcca58-7f6690b510fmr15170891b3a.3.1765976278489;
        Wed, 17 Dec 2025 04:57:58 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:57:58 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Wed, 17 Dec 2025 21:57:44 +0900
Message-Id: <20251217125746.19304-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a refcount/locking imbalance in NFC LLCP receive handlers
when the socket is already in LLCP_CLOSED.

nfc_llcp_recv_disc() used to perform release_sock()/nfc_llcp_sock_put() in the CLOSED
branch but did not exit, and then performed the same cleanup again on the common
exit path. Drop the redundant CLOSED-branch cleanup so the common exit path runs
it exactly once, while keeping the existing DM_DISC reply behavior.

nfc_llcp_recv_hdlc() performed the CLOSED cleanup but then continued processing
and later cleaned up again on the common exit path. Return immediately after the
CLOSED cleanup.

Changes in v2:
- Drop Reported-by tags
- Add missing Fixes tags

Build-tested with: make M=net/nfc (no NFC HW available for runtime testing).

Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


