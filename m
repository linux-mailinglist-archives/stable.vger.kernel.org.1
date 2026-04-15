Return-Path: <stable+bounces-238082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DJWEjVd32m5SAAAu9opvQ
	(envelope-from <stable+bounces-238082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:41:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DE402B9A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 726F6303E595
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC35433F8C6;
	Wed, 15 Apr 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlR+Kq+a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307733B6F1
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245993; cv=none; b=tDqUd99wBTHZ2LPSaQPgzwaBqksoouPJZeg6Cq3EVBxHBQwYF+NQqq4yJQUwJBc5FeftHUTg9qx3o0NWqQpwjBEZLkGnBqjXGXEYNeoL3ijlfJOY4ATkeYXCJpEwuV4Jgio6WOTeprAsrwySoBtkUuhuYEc5rzcXpUzS8BPUpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245993; c=relaxed/simple;
	bh=79jkhX6L0rBiDaMw9KGCWokyNHaYfAJhroi5fbYnBpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYynGVyb93XTTrBs4N4r3HwLEr8Z+pf9MuYb4nHke4+e4FWjj02LHGDL+ntakHsl4bjiu2xVuAK/eD6bTje4Yh1yun85M+e0au4qiv9Ys3Rjkz3FjEUQmo0uaBRO834PVi6OPQoju8avv5HY7a4prc/Tb8xxjT8+dPldyWbd50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlR+Kq+a; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so3653944a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245991; x=1776850791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqKmK/JJrk93cYqAAf+AkPWuMzdPTTW+W1yFJW42aNc=;
        b=BlR+Kq+aCUlVtBdeLpWhbdL6FHLS8clxw85Bq1RiPFeJTTznlFO/dYNpdmma9D+e36
         dKzoPWCRIcerznhX8Ra6R6TJnNiaO6Ca+pvt0o91LyxhKqn8gctuSivAgUwXrL4QXIZp
         PsAMKo/0zE1Q6xX/F+aR3VgKnOQAIfrouU5qenb7u+SJIFLwuoNzYgVRV+HncA1wxJDy
         glwi0kJ2L4ceg0KzYtJ/ey1EsqKVzdyw5eh2oPaNQ5L9A8p2LnKnAcqzelrcyLaStMFy
         31nXcJsANWtMEDc7trt/LKFH2/lWi1eOherb7W74RqqUxUTQUdfXbPcwSfbbnOzpKCQN
         5wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245991; x=1776850791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CqKmK/JJrk93cYqAAf+AkPWuMzdPTTW+W1yFJW42aNc=;
        b=r7OqYbQVQ6cZDY5DnohEdLSbvphe676yUEn/Oz91EDdI6pRs3FxMfRfdRmy0Nk3ixi
         7rndamk6+myjL3Vz/twp9TNlp50Ung0RwLoQJ0/koK72ODl1Igg7Dowi/jn5HUY7HEf8
         CUKkAk3S7WV4Th3+4otA8mK/f2Oe392lhzlMl/RdUqrmEtc3KDpDXg1d6YJdyyvnap0D
         LQl8ZXphjTvc7hfQC8OICKTvFYsIH+EtF3vULKbPnoKi3VG4lXgkXOK2CCH5IsVF7o8c
         G1RX/nHptboaiOryFQfKFN7h1YBFMcmt4KB27K6NRYqnQMWuZ/jVAtTmYT0WQbQBA+PF
         lv4A==
X-Forwarded-Encrypted: i=1; AFNElJ/wVY92YRtQ657DFIbwTbgTL+bPCGWIu/jsflw7zjYJgxtCtJupuIYh45QIzy4OKNl3lkxWbTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxqD/7mSkr/hMZSBoHZ+iyyGDwSY017DXInQUI3q0WAqF0/sJ
	JqF0DqCQ8CZzXrIWkIzp3q5fKkpz2IprDadE1BCPiu45oU052K2HlWdT
X-Gm-Gg: AeBDietdydGbZBNK7o1VYhave2excriEyStAodqnMZolDadwFLJyHyPgGLv2N933ya+
	yYfxJHwY5YBCJ9LhF51xwsVC7uHXu4b03bYYjR0nveLBDzsemx3c1RjrNRfmlLORbDVMHWdy4v4
	lHBMk4otthEghWCZajUUop5KWGU5Y9Pfnf/64/kVJ+MU2/YaB/kgtxfxpjJVrwv2WyNi9N8T0PY
	jM85V/ZK3/6lBWn6HAvl8eu+vtx0Pz0d7GdNKPjJVT73Wk8dC25NPS0GwEwHulSljUqhOvfsSFS
	nTxYFKcjh+WkbgUD+3hEfYuKfRX9VSLsBjdVGxpUs4fspRF465kcuVtDWX5Y5DAq4pqKH3cYJkV
	rb0XrgMRXTKSfAnY535Ee8Hp+xzjpYVgPaDgVuHRlFqNVcegAJM9jI+HoE0kIzbKgs1USUvX4X0
	8bzm2a2SX37YgnBdclHGVV3zUJwGMW1sPmv40LAQNA9qYV52ZX8ZVZHGv6R5IcBRcYqG5V8L8ek
	L22lYa9l63ofbBWjRJb5caSH5bfLaF31yI8q3Ffza+XvXqrakuXCg06P3OMlpAvjmm5GbycCT4S
	lqoCtrRDKFkuC9Dz
X-Received: by 2002:a05:6402:46c7:b0:672:f3e:1475 with SMTP id 4fb4d7f45d1cf-6720f3e160emr1674008a12.12.1776245990555;
        Wed, 15 Apr 2026 02:39:50 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d8cd5esm252223a12.11.2026.04.15.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:39:49 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v5 2/2] staging: rtl8723bs: fix missing frame length checks in OnAuthClient
Date: Wed, 15 Apr 2026 11:38:19 +0200
Message-ID: <20260415093819.1112313-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415093819.1112313-1-hossu.alexandru@gmail.com>
References: <20260415093819.1112313-1-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238082-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF4DE402B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OnAuthClient() accesses pframe without first verifying that pkt_len is
large enough to contain a valid 802.11 management frame header:

- get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
- GetPrivacy(pframe) reads the FC field at bytes 0-1

Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
unsigned subtraction passed to rtw_get_ie() wraps around, causing it
to scan well past the end of the buffer.

Add an early check against WLAN_HDR_A3_LEN before any pframe access,
and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
offset to guard the seq/status reads and the rtw_get_ie() call.

Suggested-by: Dan Carpenter <error27@gmail.com>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v5:
- Resend as 2/2 in a two-patch series at maintainer request
- Add Reviewed-by from Dan Carpenter and Luka Gejak

Changes in v4:
- Replace incorrect Reported-by with Suggested-by: Dan spotted the
  missing length check during code review of the heap overflow fix;
  he did not file a separate bug report
- Add missing version changelog

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 90f27665667a..884cd39ec756 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
+	if (pkt_len < WLAN_HDR_A3_LEN)
+		goto authclnt_fail;
+
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


