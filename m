Return-Path: <stable+bounces-245113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECi0HVp+AWoMbQEAu9opvQ
	(envelope-from <stable+bounces-245113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34E508C04
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22691301DE2D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CB3033C6;
	Mon, 11 May 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="G7KiyDDv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114C2DB7A3
	for <stable@vger.kernel.org>; Mon, 11 May 2026 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482692; cv=none; b=Fjl0rVhsE0dlUA9aiNf4+hgHccCsky/DIWB7QVdRq9EQPYWwSIZ2psfjG9PxMKesOyCcN8E6orrRK5hnE2lWGTZtM8hDVVo6ic66h7SUSlA+Si0PwW+RsYevuZgRVlcTURlWOqAk0r18A+peMgBnU9CPMJd5F9rjG7A2uZLPZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482692; c=relaxed/simple;
	bh=pAfSR+l7wN17yt/DIe6cWy36lj4IM5O/wJ/9Kftnl3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1WXlDjYgWgdl9ZbvPMcuqgMgETQJjG32F8NeSmgQR4RsCV2Rl0X/BSdMDNdlD4XEQMjUi1J/6QATRhpgt7RR4fBu0LlffkAwwMmKo5W9qmUnJHWXI8ZhT1BWwHvifkg8UlVn6gywQbrXkpgYGgSWL+uflQ35mJfjWaAiMSgyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=G7KiyDDv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83537a80ab6so2514440b3a.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778482690; x=1779087490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4r0tJ9SsE9hnxxU34JfGu26fGcFCd7TwYQ/xqlalG2M=;
        b=G7KiyDDvFxCeMsvIKgsRcZ3MWZGAgIQBAq88EdM4FjOgvB3sDcSwxxeGufqcCGbWqn
         xpT6DLitSSDzXvMACVQLMTeahy6IlbaCoK55KvzdWd/UDZKSkEMA3qcxjPaPAVJmlVuk
         OznuusblkBXTd85G/XU4syUwUAaay9ZjpRyM9k5v9kZp75mTaqWAXBxv0fAVEZhvtCNw
         p6jaX/cwH8bdWu+2Vjnfw1m9d8ArX8D7cIHNp0F0fGWy1kiRE0veMoUb2R4v8sPAXiCH
         CLCvD9JxYhOIx2Hy4JdGeQlbdRVg8RiJiutZjQSFgoXTpVim6NezMzK1uRxjRmkAOc8i
         9ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482690; x=1779087490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r0tJ9SsE9hnxxU34JfGu26fGcFCd7TwYQ/xqlalG2M=;
        b=pJx/ioNPv45PFKqoO9jVXkxV6Zxqg1O744eODZr9ynBm4+uX8WoZVrtmzbpiey/L36
         xYZ1ac3hFqx55xjlgXLNvZJ5BcLK5WbSQmH8ByXm8Zof7JGhnxOdAHWgFTclKOyxKBK0
         LZWFZZwvsv3BEK8H/XV8EXzUEK5lGa2wW/t6zs5okJT8+K7/crwKCOq8cdKwn3eTZcbn
         nxeKs/QvTpPkB5JYOA5GYAmM9GqbxpQyarywUylSaNk4Un0IvCLIg35sI0+wJxVorNZR
         Od66yMC9e8y4EYL+55fPTx/jxY4u7JN6eoUBLtIodEli4436N8eox8FxYpEXY/I7kIvx
         2u5w==
X-Forwarded-Encrypted: i=1; AFNElJ+DPySolE7e4eJxZWTVsAV25e96Zd83xY9cMi36trsGPhwUvBAYKHwdbL2xfgYNDmDqyJigs10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQ9OXvnDk7RHCweDYzrxZnGINEsY/wbBndUMEG0VvEFbOUaOO
	Nz9oslxonOqjpvquIlVQBpnj++ORT5g3WsA83EVFAyJAZRKGPMbzVyWWztHFb1PeknY=
X-Gm-Gg: Acq92OHTYpqQCd9Eztitz8Ryt6Bpva6/XM4Zs9rWZxYQ7xD3AsSsgdusmgZuBU0cYk8
	aET9P8UVy7Eg6IU7Ocj+YyGZoLpSanJQI+ezZUtfw4N3aD9g+ng1lETfcxTzkYo+Fl3R73Ku9xu
	oV9JOjzN6K8qdyTDFeWMdUjR3wYyLmNNKSimGgXyXX5dkfxMcQdpwsu1ei4iBCV8TNdw0DaJlD9
	aotffJ5CexuQs7pQGTrxxnRilvVYzbRt/wWQXj+ssjt9qrYjutP2BTZ9vDMCalPyz+Q3gwAn/TM
	uABe76tI+yIdRqogc73U0DE3JtzFvXynCthmB8zMxV274fbKqxgg287dQCBOw6viZkiQfoF/+5W
	7nEsbrcI8ii86HqT/21u6YemtEAuSlPG7qSiEovHrcsFjPLA3M+d4jOJlLSvR4Kh8+Cx0c0rlny
	5f47YmRyDkH/EnR13Wqdqm80boyhRm0AMDlfJIFjkITFi4vWXowiT4xUBVTDdBAsWHKlLfTuDoJ
	kDsAg79ccEtONz8OV/n5wloX4aeVE/RTCt3vTOURKW6AzSDXxlZHoN5bw==
X-Received: by 2002:a05:6a00:2d24:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-83e3afd78f8mr8387020b3a.25.1778482689898;
        Sun, 10 May 2026 23:58:09 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-839679c861esm23913907b3a.30.2026.05.10.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:09 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ajay.kathat@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	claudiu.beznea@tuxon.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: Fix memory leak in wilc_wlan_firmware_download()
Date: Mon, 11 May 2026 12:27:57 +0530
Message-ID: <20260511065759.37713-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC34E508C04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245113-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iitm.ac.in:email]
X-Rspamd-Action: no action

The memory allocated for dma_buffer is not freed in the error path
following the acquire_bus() call. Fix that by jumping to the error
unwind path which frees the dma_buffer.

Fixes: 1241c5650ff7 ("wifi: wilc1000: Fill in missing error handling")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb250..4b116fe6f9ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1265,7 +1265,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
-		return ret;
+		goto fail;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
-- 
2.43.0


