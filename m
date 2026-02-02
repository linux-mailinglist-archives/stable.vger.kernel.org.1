Return-Path: <stable+bounces-213099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OGZCiIPgWnmDwMAu9opvQ
	(envelope-from <stable+bounces-213099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 21:54:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE0D1560
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 21:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 126A73008D40
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958430E83A;
	Mon,  2 Feb 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npi9lyhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2F2DCF70
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065695; cv=none; b=UO4bfMESfoQ9MnmQWC2BlIDXbpZiO9pxfWgt0Gnd1IdFHXs4aUkzQOmscnGiP9QQsExPLqdmK4F460Br9JE6rGSQZh8GX63yfmujQzC5gU5C5IighpqXoc2HV3salC92b4OXxeMfXdFwZPZF35MGrEzWgYgLtm3ZHXkIUgD3aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065695; c=relaxed/simple;
	bh=xbzYJNxSCFjkiffSM6jyIjz1IvRu/q+sVuB3QG1dkqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RI/DTxKXi6MAfXqOOq6zp1DzqFp6oNuZLJsyP6L1b7eHE6Ez3Phs/p3pczCKA/vvplE0aCTuzgFt2NE36nA4kF0ktrsh2DItK8QoypC9ZcNrJ/YALcrq/rkachRjmR7J6MSnTc5oJq8TaR30qOmVHc6Hf8gNzdbOAMaABrEI9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npi9lyhQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794e95357cfso7841737b3.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 12:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770065693; x=1770670493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1iTIQduAX8adZigUW+P0nUWVGs+OtfVrnk6DuA8/cXI=;
        b=Npi9lyhQj185gn+HBA/vW3MF6j5rEKWWuHNnJ5qcKy8svTcMr39WAsHFxvDtKNsnc5
         LzSiB51D3y/9XXWTdowdv4lIv6O/rmzrbaLR68hqtQzmGCR6fflKB7nU6S9G6AVGNvx7
         mUHP7esEMvnroKA7tu9/duT/BYoiCdgFcL2R+o9eI2C6pImF5Dwg/vwWSn/V2tAwux0O
         z8hutgVSa+fHkrOlen0Z7jKOdMPv5N7YZRa/7JwQVpMDtvfVs58lJ1z/X7PbdtglxsmD
         oZBjg+ZtLx+nBN8lxZtsBGlxGQcALno9rA2ulbsMrLfRk0H4kS3itcSNBduLg6Cstwee
         lGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770065693; x=1770670493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iTIQduAX8adZigUW+P0nUWVGs+OtfVrnk6DuA8/cXI=;
        b=OxYfzjKQho2Z8/9fD/wX0j8ZK+zgOuHgqBwg62HQSBtscXA8gAlUg4yKdGytgYmiQF
         fb4YKTlgXo2cj3U7WvAFbfotb6DtzrNGmDVQluRw69YMH4sQDjEfjodorpDfd3mdVviY
         kZuSjSQ+NMs6wglGKrxmGFE3zQK+iIEUpzQ3euQ7OngPGNygHFjQWdDxdE+Y6jmpt7ov
         BXaF3WH1IcAaZm7nLRCL+3FqjQw5UxG6H3bLFMnZFMnUUaBj7vM2k0jWt0W8Zt5ZQ9FX
         +uOnWoeD+MVw5YmN2RINEaiuVvHDueh4T/uSu4gVidIncxu9OWOvwyzs4w8bjD5LmouG
         crMA==
X-Forwarded-Encrypted: i=1; AJvYcCVsIgSW+dTEkfqqr1cqb7Zja9a1EMphEK98nFuNlDP2IkKZEeDbudqUlOzfVb8B+lFRDJ4Mg0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TFn6B4QCW5F6WZWU/piNLLUa/zhFNRfuSs1ReB842yixSN7z
	XIITjqNL/a9debAW9M593UKgfdRxsARO93J8KfwWsuU6lEEeqjf95Arj
X-Gm-Gg: AZuq6aLVe02eX32NtN9mt4npjdnMXEfdPk6mJ5jZDN4+01LQvb3e3/5GyobOArQpTCd
	DfDJdvcxq+kcFYV24SxvfWPwKtD9R3fgMkW4qmcV3hA0gpwx8nZIlrCQIYTE+jKW+aDS7g9IirE
	fWkRhy6UUgI0CEg7mCu5On+BLzUMVJH0LaQUMENZrvdpabP5voWju1VEe9Rb2lleXOLhwHl3FkB
	3Uc0Z9D04kZp6xtjRby90dDFl8pC3TeHqf9XecherlnlZJedvQENIyswi7Am1uqD/kQnfRr36V5
	gbEmM/abvd62d3wsKCipZNIH5GnPmc2EjLd6Qfm4eOo1DdQ/vDu0me4TLxK2JLbxBeuxCC/Dgsj
	RoRvKAj/xDW8rIyIAvzLriJNk/uaFchPsZiB6c9qYwMsnOq55LyMhv+Xhk7osotCP0HMZodULTS
	toeHIJiaSJjVcozrOyWyir6kI=
X-Received: by 2002:a05:690c:dc7:b0:78c:2916:3ef5 with SMTP id 00721157ae682-7949de63e70mr120040087b3.8.1770065692890;
        Mon, 02 Feb 2026 12:54:52 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::9944])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794b2468901sm55977777b3.22.2026.02.02.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:54:52 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: gregkh@linuxfoundation.org,
	straube.linux@gmail.com
Cc: dan.carpenter@linaro.org,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix null dereference in find_network
Date: Mon,  2 Feb 2026 14:54:29 -0600
Message-ID: <20260202205429.20181-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213099-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFBE0D1560
X-Rspamd-Action: no action

The variable pwlan has the possibility of being NULL when passed into 
rtw_free_network_nolock() which would later dereference the variable.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v2:
- Included more context to demonstrate possible null dereference.

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 8e1e1c97f0c4..e734d35c11a9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -828,22 +828,24 @@ static void rtw_reset_rx_info(struct debug_priv *pdbgpriv)
 	pdbgpriv->dbg_rx_ampdu_window_shift_cnt = 0;
 }
 
 static void find_network(struct adapter *adapter)
 {
 	struct wlan_network *pwlan = NULL;
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
-	if (pwlan)
-		pwlan->fixed = false;
+	if (!pwlan)
+		return;
+
+	pwlan->fixed = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
 		rtw_free_network_nolock(adapter, pwlan);
 }
 
 /* rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-- 
2.52.0


