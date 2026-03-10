Return-Path: <stable+bounces-223741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDM4CBOHr2lvaAIAu9opvQ
	(envelope-from <stable+bounces-223741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:50:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B614E2446E2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EAD1302F726
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 02:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25963ACF0D;
	Tue, 10 Mar 2026 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCg21grW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3D3AE6F4
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110918; cv=none; b=pCxps5C6ulY7QW8xtJCIZaOq/2Afa1T9alnKR3fSksTHfv9mRkerAkddVxLfCH2aiQxIcd50vXUqZD1tqjd+grInpvEmZ/T4A8qbjbIYWrk0K2bxtsvJEdSEPGrqnNn/KIXw9Nj1+4MAHTFyhrN6vssyIYTDxIkRwhJktAuaccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110918; c=relaxed/simple;
	bh=HDGTFTbknOwHnTNgI7XPMj8uftJ4hnf0k754gsu+X34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ip+lHkLu3zyGKWE3kegTXintyb99K72HasQEIy41ny93kgnb4xnerPsGOEnfIeM+m9aijXSCxWsJzopcmPg4jPifwolCMFl8F8plb2DG+vI14XIu3x5XTBcvWoXoNiVm7+kacyGEE8Kb2+L+im3ToPfoLnaPGXRQXPUGwVu+tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCg21grW; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64aedd812baso11077765d50.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773110916; x=1773715716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKkjb5q7+m/dd9uEkTFvuvxaOIXoo7ahY96k+TRq5tw=;
        b=eCg21grWfuQ0hjGXWi9jftNc2Wa+KrFgXTZQ/BlDiU3BgVfweiZ4lv9X+hiz3ToyBp
         KZ9AabL9YCGxsgSq/j4ofDRuXNJ0hKXWYKVSliUeBWPx7bTidPx+3J9rXHG0qIvpq53E
         yuC6cMLvdSL+Xqtj/UL7GqxPKBRSgxnWKjINb38FSjQRuzn0Knt4uY4a+Jue5h1pXOPa
         VLJbeMGhNjOQvDKAckjnVMMZPPvkd1AjUFWzBCDIadh7nFcLabLooqQppj5Tnz7/2l/K
         nihk6FGab+R1jxrZuwwT/XCIcKcE+axGzD6dbsIl4gwc6FrujL8yLafmy5CcJfnuWrO+
         Dgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773110916; x=1773715716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKkjb5q7+m/dd9uEkTFvuvxaOIXoo7ahY96k+TRq5tw=;
        b=phteA9ScTsqfLjtmdpRWChBgIqkDhOCnnao4Jfq4nM13JYsdEQF8473On8+cIDrEGa
         kSh5EWcvYlyzp7wA6QPhKLmQLKURaKRlf1LIj//IdvF5Ta95yotLbarMgQaFq4PjxEVV
         M4ggVqvao0oXNOOgJiW4bbc0/CQf1uETFZvvh4PFcTj0y3RQqWpMeFhZduSnpB65KOVn
         yLLgh+dH9t+gvPGA/439hKkr+SKOH5Z6LCIo4e912m/l/Dmau8hRFe6GkRfXFojW6sBx
         Oz+vySUW3FWfUGgQDhiyFZu9K1Ok9vGpliWzMvJLEPGugBe8YbQW0rkHzZ8vFW/XbUFY
         9M+A==
X-Gm-Message-State: AOJu0Yx8CsO1UI2LV7YhteLCyRhphMYElHdJm5tjD38QevEX9Cxj5Uyb
	uva72XEmnyy1Ruq93yVg49lqaLdT8QXW8OWNexgqZY6oxBHD9xTp5WThrWzoSA==
X-Gm-Gg: ATEYQzy+u62iQv5GWTjB/bfRfj73azAHbx4gwSgajCfiHQbu+iabB9WMsJBr7b/AP9V
	4FDxPQyl0/1Ro79001OaLuAO833wDeM63Vf6y6Zqf6p4DDk8TzAFOXrg224RYjsG9emfieaVy/7
	okWojqtZXRGkm7O4aIDqZNgrQEmdrzeWiYqrByJQuYlcJ2YdSuYgyJf5OV0BcFLRihYTTIwTvTY
	UM+ZYudf0VC4lSLkvW1/9Lmtm/5Cr1bUnu8flPC4cRIHp0f1j322rKyZnUDhcb2g2MflMpZDlv8
	APQ+82vw6zUNyaLMipZS94w1zYvZNDOq9vDu6uFmdQGTdUfHthwNcUqYdlLmWTEarUzrwBKZq1d
	c0iki6QOV2JXNxOgjDHWitRwq5OuIeIhZV4W7IApy5A8K5kuYxJB6iPzg3gGCpA5IaiYCxqPd4H
	yAr1DPJe8N+i6qOIJfFhzo7K5nuxvNyDNlsaHfSUkv+NsHEyUlfTNoTJEzqb1naZ7Oc30NFaBOs
	znSTkf2+3giRBDLc0UZUZwm
X-Received: by 2002:a05:690e:c4d:b0:649:ef06:15f4 with SMTP id 956f58d0204a3-64d140abcbfmr13286105d50.15.1773110915892;
        Mon, 09 Mar 2026 19:48:35 -0700 (PDT)
Received: from tux ([2601:7c0:c37c:4c00::5585])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d175e3061sm5725230d50.6.2026.03.09.19.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:48:35 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 5.10] staging: rtl8723bs: fix null dereference in find_network
Date: Mon,  9 Mar 2026 21:48:15 -0500
Message-ID: <20260310024815.53668-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B614E2446E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223741-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

[ Upstream commit 41460a19654c32d39fd0e3a3671cd8d4b7b8479f ]

The variable pwlan has the possibility of being NULL when passed into
rtw_free_network_nolock() which would later dereference the variable.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260202205429.20181-1-ethantidmore06@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c index 364e6cd76054..0ee1022b50d5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -967,10 +967,12 @@ static void find_network(struct adapter *adapter)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
-	if (pwlan)
-		pwlan->fixed = false;
-	else
+	if (!pwlan) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
+		return;
+	}
+
+	pwlan->fixed = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
-- 
2.53.0


