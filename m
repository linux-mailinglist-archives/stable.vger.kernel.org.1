Return-Path: <stable+bounces-213025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL+QII5GgGkE5gIAu9opvQ
	(envelope-from <stable+bounces-213025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 07:39:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A80C8DE6
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 07:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4273005D0A
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99152FE596;
	Mon,  2 Feb 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfUCXixJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEB1494C3
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014308; cv=none; b=hwu0n1ixrm7zc/1fbQsdRRMeXm6OSJC0F6chaRYBFL9OxF6VUnhe+KN2ha2m8Rgy9OSKDdUzCznR++WnlG3D+mg1hyCTs9CA1gyTzIuKQci80sCt8wHwMbGNn3FJOhf3coA8pawe8UFcvfFcsbQqR2qxLjMTyObRJzLNh6JYNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014308; c=relaxed/simple;
	bh=c2qyeHjVaOmyrtgY42eDuxJJm5mkYDGCfcQLnxJhSbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjMG71zN7kilY91x9WNW1yBK/LUJPnQwMBy/nmYmTAIJs+QV4bSCFcpEUwmiuXX5lDOUyf5FNT1OcYTn90KGZyLCacHVR7VWUl26Vr1HIow9zwdguUyAxJ4iwXTQM3POUcCCMpL0uQ7qwnDSn2nhsuWE7JrrgYmog6v8+0m+czE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfUCXixJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649bb5a0ba1so1049707d50.1
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 22:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770014306; x=1770619106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAfwHYV8/UgKwbTNXtNiOxc4+en9+lyKeBe4ZozbvW0=;
        b=gfUCXixJssuagAm4kqhHdDDUyuZ205dOp9sX1frcpd57hlz/8tYoI8cR0G0/TDPtkQ
         xDxjz68us98hsYSGU2s487PuP533lfB0J7mR0dcl3PbJGlXIROztzjuam/Ay+dJ6MTOz
         PLUq76jQO2yH71FHlUylbvmNKfY0JvsrgUcpPYE37R8xFkzF5WeAb6HWZWOq4l4J2myF
         ISWmCAvJW5TQC0ZEF7IRZ8kmzmt3+dW1mUfYwmLmLdaL7+NizxyE5TIRhAxq4VnV6KW2
         yugmWKtH1og6AfWWlzzDxW+uEJBdWv4lFexcP8oTM661GS0eSeRORrCRHgZPk9idHeWb
         ykPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770014306; x=1770619106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAfwHYV8/UgKwbTNXtNiOxc4+en9+lyKeBe4ZozbvW0=;
        b=t/guzvGcPXBlwqaK0v9UcFqeRCKKzGdWwD+NzUm+riM+HOQe4TWHenS7+wke9iBlU/
         Xy3hwk49+tCMkxBXDnskhkjvI+NpcFZA9f3OYvXPWUSMumXIakyfWXVYCoJ722WSLMZk
         9KISmOdPBFZHClmdV5gHi3Tz86nSh8L8UOOU1Ub9ej769muBjZBNNc2FaVZZ3CKM3R4Z
         uo11B+w/VGoiaOwQXP4Oc5uTpMmWJlqMhokGxC0KDKxa4qE+9pIzOtz6YceGeufozoty
         rlCuQcrzqTfWHt3FnqvZOcmhvcMB7UMV/oPX0J6hi58Vu3u8rjaGNW5ONd1UUM1Cyf6Q
         lyhw==
X-Forwarded-Encrypted: i=1; AJvYcCW/96vNFdkwC6DyMId0zYvPWPfIBjRV+2Mivx21W/8P4J6im40jA9V7JA+bwVNNJQg3dJF1xh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYipHfgsuFgLLJmFL6V1AWEsDPD1WRHVq+LrVQC/l1YGLRcb+p
	tlsf3RZYpD6nN34aaa8R0WkGGDbD1hKjoaLopi+6QtZLTkPJYCnto/Ju
X-Gm-Gg: AZuq6aJ5nUJs3PBiS2VK1CyL0rUVH2PTAFONXpBQyXSed70LX9p5y2UufpECN1C8hol
	7SS51qWvOb3wXO1SSJuIfgDw84i4RL6DNIo/tStOEMDxrzXV1OyZco4YUkoa/hKpWrFedsE9kXU
	cTk3s7DckLJx750Ywq4MCQj3sXjEvzBsUtOMwkOC4gq0Ftjf/qJ/U4FHPmPGRb4hGEQWTiVTFXM
	830UGLs/0tAGmpFRbTekdP7YrP7kXLGAPWMd2jxdqQ1wgNJRZ23GPZrMO3D4eTCMzm5gGppUHZu
	WKvZSZ2+tjP9zdtkVKoK0SGh56QKv9O9IjCdl8vdBdruacSmmZdPi+8Y4pWrOCEIJyohhOE17eT
	j62XyKBS0Ra7CFQLpmfEHrshb8dR3rTec8v+LUsap6LBAc+eOtjED/S8uaqLGl3BeobB92ZFhMH
	q4U4qY2wwEg+99Q4LVKpE3+S0=
X-Received: by 2002:a53:ac82:0:b0:649:2e3c:7d76 with SMTP id 956f58d0204a3-649a84e5c58mr8022667d50.69.1770014306344;
        Sun, 01 Feb 2026 22:38:26 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::9944])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649960e0965sm8478547d50.13.2026.02.01.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:38:26 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: gregkh@linuxfoundation.org,
	straube.linux@gmail.com
Cc: dan.carpenter@linaro.org,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] staging: rtl8723bs: fix null dereference in find_network
Date: Mon,  2 Feb 2026 00:38:08 -0600
Message-ID: <20260202063808.664468-1-ethantidmore06@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213025-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9A80C8DE6
X-Rspamd-Action: no action

The pwlan variable has the possibility of returning NULL and is not
checked for NULL and then later dereferenced.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f81a29cd6a78..29dd0b56223a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -835,8 +835,11 @@ static void find_network(struct adapter *adapter)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
-	if (pwlan)
-		pwlan->fixed = false;
+
+	if (!pwlan)
+		return;
+
+	pwlan->fixed = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
-- 
2.52.0


