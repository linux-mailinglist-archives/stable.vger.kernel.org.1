Return-Path: <stable+bounces-253543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBbQBD4LD2omEgYAu9opvQ
	(envelope-from <stable+bounces-253543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:40:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592C5A6128
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDBC5316F426
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F953CE0A8;
	Thu, 21 May 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opm7nRKK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCB3CBE75
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368644; cv=none; b=F3CPiaawwMiAb0mfmcpLFAoFpsAvpFtZryarB7EHKJN3TnnNfp+pjkmHW0IWPJ7ypusI2ynbJJFGFomyXTf9POcVEMx9n9vd3wC/SfmnTrA86H0oK7BGloc98DmddG4/Mj8E1PeVNWwWL+OlnB6nfLVx7Qniw5XbH/NYCLlQH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368644; c=relaxed/simple;
	bh=guw/0M339lqf3q+Se3RbL4Yn7HqkvsKcNxnXScWLqUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nf4gadG8q+3d/7ZCaTqZZb+uPtalIVbwR94kVeLpeoVvsZ0fLrNckB0IUPV1dWIipI1+qLG+Ua+KAu2XCQCS8WVBkoCyTanKKc0tD1hJR0tiQF+wI/BMkFsdGD8VcDtXiNHRR3LuQ8WUQ5OZQHT6xdYMv9SgmicHSXb2ksaiT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opm7nRKK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bce386d5b85so1002947566b.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368641; x=1779973441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pksxliDhN1xPi4Ml9hgRHYNl3ynUr9XDXR+rSuwcP/8=;
        b=Opm7nRKK5HF+jxtN5juEkuhQlHSPXV5F9NH9ziUk7RZewKgqNkpBuarCVseN7z5PHF
         IROD3wApG7WP91Z8cEvqdWEQLaVehD/RbBrFTxa1lpyxBfnI7cfGjW4wDoxlJwTTU/aa
         oPKP/+hGSw4chG8+bVn2Nd+epdo3QzdmHzY4WobCONlz6BLGWXpF0OLB3JLcHqiHQv5S
         8OQSLOTzHzoU0oaCyPV9pb1T2Vjjr7PvikNwzkKJIHsGRBX5mDXpGdtCxk9ubXLCyuoh
         NsRUOm/IGxOET0O4QS5/ocW71FrsqHFoH8VAxbz7FcQfwWJnmaCvzfgsrHRocARKVDdI
         tgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368641; x=1779973441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pksxliDhN1xPi4Ml9hgRHYNl3ynUr9XDXR+rSuwcP/8=;
        b=f6V9nZo02TkvYB0Yq8sMPMvq8pkD/jQ0+FVtpyq9kcGyZXL8VYC0LZ6Qc60B6LSCYU
         ZMr2lR3su6E0MJ8SOJTMm2Tl7sbRKydDSYgpP5qMFUarRqPn2a7bUDAmSAP7Z+DHWxE6
         GRFbMjnFUrG5QqmSk73GcmlNXlA0BwLwLfQw9zUvwFjXjH5kA6pvhXSPBng5Dvr8NwpF
         I0f+pmwlCm8T5mNeRdyBwwn1l9b5EdN9plx5Dpztz/M+tW1h0kiMBB+04ddvupk7CyWD
         ed44RsSbA75ID26KLvwqjvuA5sXldZoa4ixRbiMqp+6GsxwIFXhxJfYvdeyE06QBv/Fj
         V7hQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ucABrcIZVeq1+noFgTnckjJtmKx7cZudsmpspJvyMp6LYKjPMWngNORL+lfmQqL5swDNyiPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdatJ+eTul9m7NPFn9/I7iIirDAI+V2ClUJbPg1cwd0trPtGvU
	YgqB7WEVhA8XonWWvvBPhXdDdtFYokXAwnv5JjYy+L+GcoY/Bdfx5hNL
X-Gm-Gg: Acq92OGeXXKHnIbClDpeArraEitXw/rs9fKt1M8IO03JTB+fSmlrf5SUZn0o/dGDvDC
	g8c93/T+BAfEvvWvFWLE54tNiNmx7uQWY6E7/+VpP9/QldF27vAF2WqJKBS9YadImtXioEXpefE
	FLK9UmEPCjFD6NEu+UZBd7Tx0riniJJ9n2hyHMVM0D7gvsm2McBYdaQMzutMkJeBFFbm3JYkcCm
	xPpqonJDVyG0c5zu5/nBHnbcimKbK1tJTlXwso7z5So60FIoVK7x2WDXmEK+HCrshGdgG1pVpSI
	oGz+ct/F20LmZEpNUwbCKr//EgegkISoCISkn8m+jzXqUxKPfBZUxuhofr8s37uo0Hiuj748wyj
	lb4RJ9YNPTOrplpURTWKl/6M+H+SZS62hB8vmzh/cALxSXIIna1w1qksZ6KyAi5xMvFuFgo14T9
	3Domen181cGLigLCcn0dSGT9mtXKSpDM9qYragKQ17NKUlw1QYxL3Fvc9He7HMzUSJqSo/JhM/L
	kw0re40dkxAFzrQTy55bGuzzbbczBEZw+IGHXfyXLvs2EsDn2sxM07pjVqj+f6qTM1bxbSJYzGB
	8RvNI4Tpn7InTdWa+IxeHV446rZCzW7GAzqTZus=
X-Received: by 2002:a17:906:f58e:b0:bda:d08:35ea with SMTP id a640c23a62f3a-bdc15a3910emr145283666b.48.1779368641190;
        Thu, 21 May 2026 06:04:01 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:00 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v6 0/7] staging: rtl8723bs: fix OOB reads and writes in IE/attribute parsing
Date: Thu, 21 May 2026 15:03:23 +0200
Message-ID: <20260521130330.754181-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253543-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8592C5A6128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix out-of-bounds memory accesses in several IE and attribute parsing
paths of the rtl8723bs driver.  All affected functions iterate over
attacker-controlled IE data from over-the-air frames without validating
header or payload bounds before dereferencing.

v6: add two patches addressing issues found during v5 review.
    Patch 6 adds IE header bounds checks and payload length guards to
    is_ap_in_tkip().  Patch 7 adds header and payload bounds checks to
    rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr().

Alexandru Hossu (7):
  staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
  staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and
    join_cmd_hdl()
  staging: rtl8723bs: fix heap buffer overflow in
    rtw_cfg80211_set_wpa_ie()
  staging: rtl8723bs: fix OOB write in HT_caps_handler()
  staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
  staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
  staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(),
    rtw_get_wapi_ie(), and rtw_get_wps_attr()

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 15 ++++++++++++
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 ++++++++++
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 23 +++++++++++++++----
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 +++++++
 4 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.54.0


