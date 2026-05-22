Return-Path: <stable+bounces-253660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIf2AounD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF85AD8A3
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD21D301BEE4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73043282F34;
	Fri, 22 May 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaFU/UeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCE2BE05A
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410782; cv=none; b=Ft15BHxhusVjIZusHyeihmzEUw30t3RVz5MSYsz0Nq2noMcVF3Zk1EaVpT8q4NAV8ggPViW9btvawKGq382DYkNAjgts9ozxT/hjxwQMuI3E+GRXRsg+XIky0L7F8T0bgtwCN6NepWGJcqgBY6CRwNSJzaqmkv2IGhW8PY4f/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410782; c=relaxed/simple;
	bh=11XpadIVbnWDgGbnLsDIYuVi8q6V/iekBQR9d9ytC84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBuPzjdYnkbR+SmmeoiH5DmYl/tmRtgxjVIyaRxJ8m70bJBxK2317IM6Rl0m7a6dCx8kThOvQQXzgBlamffcpuYYmrzBuXJOtBYbr3ju+vui1/y0Z1mxBMNvrvJQhEI/r3H74ImCZjLgfCjrHEGsl4//9awvFJUxLNuGpHIegmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaFU/UeB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so11379475a12.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410779; x=1780015579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMhZs4Eu6gRgBabm++8DBCSAa+Wm8K3ZfuFNhzHSur8=;
        b=kaFU/UeBlIss72GXiYaegATgs/Oc7Yezh60PQPfKv3fNgmkRB4u7DgYZ/mZpmN5vio
         l6+yXwa7yll2A84LR0SMs0wwcHL0WbH3YGK44xyKHQAu0RUr5cTvSYt2m+pZHkQRnoH2
         zkI6e4bGm5QFPkmlW4eGLOah7SXpzHE2sQpHmzrYpDWtW1DkCJPL5RDmK1ShWJZreMuU
         7FtnrGMwa2fV7S0cnsW3DogbAK2gAwZiccgttSbAwu+yMMW/c2hHipFGGlZR6tdq3Xfv
         mdd2Wd1mafZk3rcYqajevsR2/k2K7/nwpY7eGb03NhtrZuAOSaVK6V7UPzLK26TbChMr
         rmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410779; x=1780015579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMhZs4Eu6gRgBabm++8DBCSAa+Wm8K3ZfuFNhzHSur8=;
        b=aSVExV2HPUJ0v5rdm6HQHDtRJ3qD1ZD9NAtw/SUf3Yzaz5OLKvB/rK4atRYM4h5/fU
         BNkIvZMCRbDo2eqo5zyv0VQmgXGlNpICL2C2oAjdOAiAWa66bK3QwY6T7snR6bPryrME
         SsSd/qMFmwDvUomjlmVDeSvdoX6ovqdKqnsE6kjx3A3ZLGuk7QCpfQTktQ6GeaadMCOb
         sGR4vaB5JMXEUfbW4DZYOD91+8af4wcmTutmnogzrjGCXr4pxvK4cZwbZCoqk/z6uckH
         JbgjeoV5tMa60l+viDnYvaCwrIvUEwVqL9olPAjVgIM3a2TcJvsR94ZROkJXgckgjFPg
         LQZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BpJkgxqT2b8kDLxpeDchI0AfMCHTZTl+wxGwf/Drkqok2lO1jqkLB8NJBuaf2V4DHy09/KkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+q5O3wgr6h+0vGg4vHJ5MEogXzdTYTbDZBMPLMz0A+2nFbuj
	0dq+/Nw4KabBMWYMidhoz01SZ2lq2HDoi+kZ4QW9+Lp/CHSUIIon6g9L
X-Gm-Gg: Acq92OGqQ1xYYKOgoJZf2i2iabuWYcCe6MJWvZOQD9ePAH0tYPoZALrGeyP7LIGZMUs
	QsQUqa6GbRBHmqK+2CZQVc9G5Kz8WyIXavlMYiJtCxWg+dPvYKvh9VBgbCf51zMgc+HsTEwHk8J
	/IK09D5Kbc3p9YIGeaTbrbXwqIgZE2b4NOKg0qpkmbhQ6xSI+dGtnKPEhddYn1M5w/BeTQ0UCrk
	lT/Et9Vn23MhMJam+M2olGb5yNwUCQyjZtxmBS7aekQVKkDpGl3hqcw0L2JBxX4rsUzVjoVouyL
	JnHa0MkP42rLRKkwD+h8ngHdYD9J45Ensad7aD3lfQc2zTsdv0w5QOpL/pSr9IjK6cGn1ThrWcX
	qmTqpZwqbHt+QXr1D6slGrIVF16AHC4a6OynjxouvBhfny2FNqUypvoOHoMsRLvqWs5R03Egr7w
	hQUfLJT1FOjpC/r031GzqJ8O6zwANg6RxswUZuNy1uYovqc2ldpYxT8se7oVUfGpJjSkeMbJnzx
	IQKrPB3cBn/KHfsXDx82UmV+j+BW7RGLy5heptUNpmVVcd3nnNxlVEBpWm32ybI4pZTh5VzUb/H
	x7731KGMOxGZk+9FQaf86Cfn3RBVGyWiJQeqCpY=
X-Received: by 2002:a05:6402:510e:b0:682:c363:d96f with SMTP id 4fb4d7f45d1cf-6889c44e129mr462567a12.10.1779410778851;
        Thu, 21 May 2026 17:46:18 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:17 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 4/7] staging: rtl8723bs: fix OOB write in HT_caps_handler()
Date: Fri, 22 May 2026 02:45:28 +0200
Message-ID: <20260522004531.1038924-5-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522004531.1038924-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
 <20260522004531.1038924-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253660-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4AF85AD8A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

HT_caps_handler() iterates pIE->length bytes and writes into
HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
802.11 AssocResponse frame and is never validated, a malicious AP can
set it up to 255, causing up to 229 bytes of out-of-bounds writes into
adjacent fields of struct mlme_ext_info.

Truncate the iteration count to the size of HT_caps.u.HT_cap using
umin() so that data from a longer-than-expected IE is silently ignored
rather than written out of bounds, preserving interoperability with APs
that pad the element. An early return on oversized IEs was considered
but rejected: it would bypass the pmlmeinfo->HT_caps_enable = 1
assignment that precedes the loop, silently disabling HT mode for APs
that append extra bytes to the HT Capabilities IE.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index e0d73c267786..dd34f229df12 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -936,7 +936,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	for (i = 0; i < umin(pIE->length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
-- 
2.54.0


