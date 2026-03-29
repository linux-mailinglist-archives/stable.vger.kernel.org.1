Return-Path: <stable+bounces-230958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGYfGGhSyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E07352E20
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69124301C17E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699B373BF1;
	Sun, 29 Mar 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxYsCGFO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3135FF58
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801346; cv=none; b=jl6dSNgli/isEpsyIcjOrCId4wpU/zqi3N8IjVCccCpeyzIREO1z35RsIsZ9JoOvHU9d3zFlG3EqTrVuf8drgAH4FlNEuwWdX9PSbT4aNE3abGQEejS0wxUrZnPn8PKWAk+N9xbbbOCUPjrHqE+ssIiaZ12Py8v1ZS0/d+F69r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801346; c=relaxed/simple;
	bh=y5/H+TqDE4OujzUA/5gacU9H3XM10J/mK0k1UKIflqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avb+MQhkK6ufKRWKNcJXEi358InMd4mS32GE9SmxSH2fKUxTMiLvvQ7ZzdqesALS/t6/A3jh2FF5NN0HwO0eUlbbacPjCCaKFeuGvlS6LnfCj+usPFe0RJ/PnrqyFulkjlgY9pXrn1nzpbJ8UmkLxw5lORFB58np7nibpB0UHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxYsCGFO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fc49c5c0so6145575e9.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801344; x=1775406144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39nWh5Sbwqb3QyZ67qx+99ZIlQgRVmnOj8xt3uyYktk=;
        b=MxYsCGFOtAdujG99DC3NLSrN+NUhC1hI8/fROaAwLyGUJHnZXM6b9fK0BBl6JGd4aa
         oPZV8Ywjjiw/QETPlnzUlLpFCLvGh1KHH3dcrhsGxxf7Ex+Ti7RyAKA0patUiJx+VFKe
         04cJI7wTl4DOXen+MwjwHSzZk4i34QbtyOriAPDLZxKlVE6YB0gqaCFQU07wc/b5rR2p
         TOn1a+P7I9rkseRoyblwcICO3DdfG4ft3gBA87IGxMRAh2ql2siZx6P8cPAxz0DwUl+/
         DbVl/mFl3Get7haSR+OGl8IKF+pLlrnTTaWH12uemZKxSozO+8eKreEaja919Eu7kr+f
         gMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801344; x=1775406144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39nWh5Sbwqb3QyZ67qx+99ZIlQgRVmnOj8xt3uyYktk=;
        b=V4mmhjYh5EeL+QX3gLm70YKzl2GDYt4Smv/GLKJdRQCvgu0m0bVV/UuCIKcqROMg23
         /USio8I1y1DaWf7kqtQ98iulpeqsC7miiHV8ttRQl7wsZ/EiwfrQa7jbMwqPiu8/vpvM
         kFvUJMEFbnhsuj5mr1SLFY9NytOIc6z7s8jLmrXfpnn14F5v8NMjUgpMvYqqkNiMmrbo
         +86jNSDbHgdk0ZcS2KvHiOouLJtruP0OQTCSymnZmKdMwLQ7mr0NcPRzr6VxI71ZS10x
         Nb//Vk4Tbt4bkWEwKZI2swm+pyiMZy0zTwJ54+fsO0e0KD2P+0KtGha/YY/2SisNxojT
         Y/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNj7TskQHCNm+k2WcEkWETEqXaDYyXqAagx3449HhzD5xs2axvhFfR8OYNPNspkIvdwlPBksM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmOnGCSXv4HMnj5s6tlevnCcb2ez6NzGK1skC/h1hid9kTQEk
	tVmzevA6F5LciuFPMhYLLmA809kGQbGA7tD0br315YhzwOg8xLKEA/6v
X-Gm-Gg: ATEYQzwkRahhriG1RTAc2vptpaVs1b6QrRPjHHZneXy6RxUfxCPHDa+RQcmdAHZZTYJ
	CcMOfDu53EmAO/bEIROcrou/ZEo2O7voiWAHTkqJzKwW9Hi2avkiaQj/u0ZT8VENq4dXtlz+2Hq
	ERHK1x66b9dkl7BTLFPmOYp2R+/EceC4moUU1wEczhbrHyk6cZKLBKA0zP7HfXuKK1lLS+7/ex+
	XKMEIf0QE1juUreZwxb4e7NhguLP7zux+JfjNxhvXyd5urI1PEMmhprs5Im0upDX0QpcBUk8Wrn
	HDo5jxCUwMW8bTPSXHWmIV4xFgDRS8rzZ0IhNUfiQmPyy4c+KOjt/WBOTuFfXrYEqjpTHKdUcUb
	UNbHNH005K8jbSkwOoRhku6Hn87KLG4KYPnEr1YPlpwLXW9h2QfdxpHb2V+zR7dm0R9gUTUUYAn
	sELFhriCzdCzSe2oqGWaEafikZInx8FpsWqZSNzW3Z3/uJsVZkNUoBfbHW39cxYGpySz8EUH2jw
	lAI5tA5NgHylaJtuKo9T/MwwQSC
X-Received: by 2002:a05:600c:b99:b0:485:39a1:bcb3 with SMTP id 5b1f17b1804b1-48727f5f8d8mr76636175e9.6.1774801343387;
        Sun, 29 Mar 2026 09:22:23 -0700 (PDT)
Received: from localhost ([2a01:cb1d:4ec:6700:174f:90cc:2ec3:a84b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24707f2sm12760803f8f.26.2026.03.29.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:22:22 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	arkadiusz.kubalewski@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH net] i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()
Date: Sun, 29 Mar 2026 18:21:51 +0200
Message-ID: <20260329162151.2043655-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230958-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3E07352E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In i40e_hw_set_dcb_config(), both new_cfg and old_cfg are pointers to
struct i40e_dcbx_config, so sizeof(new_cfg) evaluates to the size of a
pointer (8 bytes on 64-bit) rather than the size of the struct. Likewise,
&new_cfg and &old_cfg are the addresses of the pointer variables on the
stack, not the addresses of the actual config structs.

As a result, the memcmp never compares the actual configuration data,
meaning the "no change needed" early return never fires. Every call to
this function performs a full DCB reconfiguration (quiescing all VSIs,
reprogramming via "Set LLDP MIB" AQC, and reconfiguring VEB/VSIs) even
when the configuration has not changed.

Fix this by comparing the structs themselves rather than the pointers.

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---

Found using Coccinelle/spatch with a semantic patch that matches
sizeof(ptr) and &ptr used together where ptr is a pointer type.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6904,7 +6904,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
 	int ret;

 	/* Check if need reconfiguration */
-	if (!memcmp(&new_cfg, &old_cfg, sizeof(new_cfg))) {
+	if (!memcmp(new_cfg, old_cfg, sizeof(*new_cfg))) {
 		dev_dbg(&pf->pdev->dev, "No Change in DCB Config required.\n");
 		return 0;
 	}
--
2.49.0

