Return-Path: <stable+bounces-212901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBXAHyb+fGnLPgIAu9opvQ
	(envelope-from <stable+bounces-212901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:53:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8314BDFF5
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C4E3008A74
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168637F735;
	Fri, 30 Jan 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5jD6lun"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325D369975
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799203; cv=none; b=jBDy6RjXnsjhhGDFrgI5fEiCM3RMUl/VZZzChHBLUaqYIrGXJyg/KoTWskxWsJKrZ9qPAx2yxupb3oejZFUzGUVtxsI2Vytu0f5bhX86ceM9yJg+pLE96Y4lyxaIWku5E0Rxlh7RRIA1zfWTDjJ7maG4uuOkUWPwB9cjGsh4qAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799203; c=relaxed/simple;
	bh=54jF80axLN2UJAh0SY0zu8J2BqHK+0mKcS7a+qODr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUY8sCjY5CCI/rMFtnsnXrM1Xyb5vkbQvm/2K8a7gUEf/R+UOETVs79/DyObT8B4EPwzAcnQad8zvUQj47HQk5oP9zfUsVJW0/qn+enfmn+/1l4q4l+mfINp0LvE0CDxQNH9Zu7vkLxJw/v8sRvOLjUqY1fz2UKUSH7iLjNhGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5jD6lun; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2670932so2323926f8f.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769799200; x=1770404000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=R5jD6lunnQyUEOnslIKzYTP98T6ee9FQW9WuiqZbCBOPrJ674fcC4yVGsdL8v9ho9M
         4dEGXZ3r+ZPu5L1kOFmZgx13ftBQQYyh9OPcTD/hjQjARSNaXdDSQRgd4Iilo6Hrvc+e
         FL2NYPfXcomWhuBz2YqmNlIoTausmMpqIQ8EwvTXGGN0Bw2PBA00fVcgdMCpJp8uh3yk
         l/T9QeaBS+dM0GjEJD6yu3PTynhLIbtV4xfEA+QRw56/Dh44ZUpFMbtxq/DkBXQNXGn6
         L2fMQZlQOyD7/O/3BqYlDYwWN0iiUBgExlVjLhzDJcD4z+tSojmyLmgs6vagYxICT+Rc
         U/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799200; x=1770404000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=rWOFV1eH1zo96Z+eTmXtA13M1LFw13sHbTzuKBWpGpf07e8mOJwfeCBNPr5ev859D6
         plZYRZcfiNuJ8PO+Hra6FsUeFm0tdJMEFf1uA4RS1G14Cn3fU9WDDnzS/Q+THKfWdkHA
         3tIRRzCB3AA4Qiasf6v/dQSbmNOiLn7jAtkZq09ZgKVFeusbzdjMtcceo02TtKEfJ5si
         LbmDvJM46qOaLeDIN3XWBBRoiYlJNBgNyJdKWUaxUQXtCzajJzvvxoLCvG2ab567LJ1u
         FhoNRN1SAesa9IDQ3Ab4khNrqn+ljVpH5tSIHnxiMMa5GapEl+AMMa7vg38E7y4wXo4i
         pZ+Q==
X-Gm-Message-State: AOJu0YyDeozVsoJDrBB9UB0mdJHrdDJVPEr3igtNtxYS3MiDzgZyJBA7
	QXk+E98VQu0Q0zP4WzGz9m3/souwyD087xlxpfM5EI5z+gE7S9VnSDPxWGdPhoQ=
X-Gm-Gg: AZuq6aIN5Kjtr0wyxpv1K8bqnbmaqWEBMziAoxk0uy7tHJSIIQjgJ8WcZQay/IB+Dis
	/4ZxOWFsFwviul8T/Uzu2h8M/A4dHlGxYzbyvcKvtFJJ184jmCOj+Vu1PudPCRvc1jO/if5mxEI
	5aeNz68AipVJ9BeL+oJ/0k4hY5mnaanCwvYv2FwqhuFTJ/HF5rDN82bwsR1FLRwDNRuKEftpGdk
	m8aM07NIqMgy6ebJb88P/OWPL46M14XWdMISPaT314PQwe+0ZrPh0Xhcu6e5H6p4O6SmkxcKZC/
	ZUaT3zMxk1zEk8oP+mYfVH2W1Rsoi0ifvKD5cdICuiTDq3QH8DnJX/Ly0dTRL7DBRrCbaaIQtOj
	ymKFV5QjU6ZyvdCxB7mV8Ggl3K0KeMpCtPHB7ZPiFiz2d2egV9tRKtClHtulIRfNzBRvTGbUYZV
	p6swa3I4x7qmhSGluTSr+ONRV7FvT/gJVOsCADp8tjnGpjV3Qrac/XZgFwJvWR1w==
X-Received: by 2002:a5d:64c9:0:b0:435:a0ff:a732 with SMTP id ffacd0b85a97d-435f3aaf7e4mr5866774f8f.50.1769799200199;
        Fri, 30 Jan 2026 10:53:20 -0800 (PST)
Received: from LGPC ([31.223.131.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm26448652f8f.13.2026.01.30.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:53:19 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: lukagejak5@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds read in  rtw_restruct_wmm_ie
Date: Fri, 30 Jan 2026 19:52:46 +0100
Message-ID: <20260130185250.207064-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130185250.207064-1-lukagejak5@gmail.com>
References: <20260130185250.207064-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-212901-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8314BDFF5
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


