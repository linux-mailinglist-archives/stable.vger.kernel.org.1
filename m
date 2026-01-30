Return-Path: <stable+bounces-212898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLDuAZf1fGlVPgIAu9opvQ
	(envelope-from <stable+bounces-212898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:16:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E1BDA58
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F97A30039B2
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383437F0ED;
	Fri, 30 Jan 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/B+PItv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244433FE12
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797005; cv=none; b=uqkU3NMfv2XVAGLE/ayW6w20cudLFCIZz1ttW07ewhJYF5s+kgcXLnYa5fTFmX2aIs/0vIfyFsk/8im9I0Bq9hMD8/OP+SxUeUgSNAkISmanVSDDS0101rJkrs3/6SnAKxo+42tXhIqfp8CMfBnY1RUXR1D7fD24qOJRNFu4uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797005; c=relaxed/simple;
	bh=54jF80axLN2UJAh0SY0zu8J2BqHK+0mKcS7a+qODr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWgSXwYYButSy1zAbA+wmCyt74CfNnRdpnpfV01HMx6BUiUVCV0vJX/QZTXfc0EZGp1k9ypjK+4SvhVUplqVi6gvS4FQ5IVAO7Kr89UjsjX4MYRKhWi3c8rMcoTUSWkBIOLpvQeuJta+nJvz2OpI8kBcvKC/Ggv5y6m996YqS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/B+PItv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-480142406b3so18454275e9.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769797003; x=1770401803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=h/B+PItvtCLrF0JiS1yXe9+U3x5Rio87GZyET+2RaQ83/LGjt6/RoEsU3jFV3LWK2I
         /RZ68vT8OulcHOrpx3qeYEBdvwUx2XzMSmnFFxXLrngFKsPBdswyuNSsVIAktkTINXPV
         ha6+sqzr2TAtHh3Bamk9VcMUVqZJBM+l/3Od3HFyIBhqsOHdySwFVVA+XPS+Btr5PUPr
         Ghz2Ix2vnnX2yLd7q06b0v9ajr2fBnaDU2n79qs+09EjMQH9uco8euOGksMVy83ptabI
         Zu+nH9dfb34g82c1Iq9Lrx2U5R6IDZrD8OsXMN67/KuKe/8PWp2n0wGpuY8lFk+tjPFZ
         DXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769797003; x=1770401803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=wJEJNE5fdX+2rwXXfTQGaix5ff9ZrGmxnLxRUw5eBiKg3pcA228RWrrksNhJMAFT8c
         d8RdnUp79P/E2Pi/MTKxpmn+NFXoIiXDWtejw8PB+2o6uO/ySWCvgumXB6TXA3fY4eHg
         sFXifEWnrrrvl3g9imnLvdhXNvFMgoHmhYnDqnwecMp3m1WgtFa5U/9Ff3c5w1XFhlS1
         fpFREu8Hk3jxwyFwCQxlIVv3JZh7a9mYWduqggfUl/UtRYE9q1gwJtGrbxgYJEJHFY+L
         T3FzPVrfs8F1fe1glG3qUlmuHy9xmZGY6/17pM4KFS7/absqHg7cNu6BwjnbiRnfMhmE
         guHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UW8klJz9caK7ADtoipuOog1JI5132I5M05WvC30J7UillcNtHscTQmftvf3BduNaU4dADm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatqNb7cpWvD8MjPD6CAs74D+s2K/Drywd6HqHvKIrZYMQD1tT
	YuR1CtlwkG+wz9BnfYtoVF1Ug7gzkVjFvyVJvPmN/BahHofkwbfSmgc=
X-Gm-Gg: AZuq6aIi4bjjaTIwhNmjA57yTuqonMrdB4PjIJdyCgB8rQ0vX0moqLMju2WFXqdaqbK
	bnhdveGkQqSyGhva49EVuSYZyqPlM54QmGGgYC6Ut4YYSyeF7yTpE9BHvZrmbchrH7lSy+If4L/
	XSpvLSsdrQEx+lMyMKvD/LBCJPBDma5a6MtKF1TAfgheQFL3T8kvffh/a6/FBQmYIIDf3cDFhRw
	8Wbth1aMgrpi1P2D43pO1yhwcCgvnl9193OZt1lDlIlq9Em3BcEL90sT/W1HVtcooekZ7Jj8CmC
	x6os3tlfgLVE9UeOQmAIauuWOiD3anXxcp+OwbnYZ5Mn7KyJptSQOlgj1yQzUoWj1fs3JHpkNDu
	nPBA5HM9WjWS5Gy24jtAAqTFienTjROhFAhr76StquaF1dTtA0RZaHew9sYPyyhxDpK3GjCGKtV
	pDRkyI7WxC3OzK+mgTudFPK+A6o5E0Edj046pO1YbOm6JpLbLII1gin/brIDVBqk4mQiRKDaT+
X-Received: by 2002:a05:600c:3e1b:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-482db45129bmr44705235e9.11.1769797002303;
        Fri, 30 Jan 2026 10:16:42 -0800 (PST)
Received: from LGPC ([31.223.131.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm280571025e9.13.2026.01.30.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:16:41 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <lukagejak5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/5] staging: rtl8723bs: fix potential out-of-bounds 
Date: Fri, 30 Jan 2026 19:16:16 +0100
Message-ID: <20260130181620.199152-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130181620.199152-1-lukagejak5@gmail.com>
References: <20260130181620.199152-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212898-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 986E1BDA58
X-Rspamd-Action: no action

The current code checks 'i + 5 < in_len' at the end of the if statement.
However, it accesses 'in_ie[i + 5]' before that check, which can lead
to an out-of-bounds read. Move the length check to the beginning of the
conditional to ensure the index is within bounds before accessing the
array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179ad35..7dfc2678924e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


