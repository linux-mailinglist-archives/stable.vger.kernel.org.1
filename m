Return-Path: <stable+bounces-249344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ITwFBxEC2qsFAUAu9opvQ
	(envelope-from <stable+bounces-249344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:53:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB405713C4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85363300FFA9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38622405C48;
	Mon, 18 May 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn1wewad"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BD494A0A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123215; cv=none; b=ZYd3f7298TuSlpU7+RrmPhEPFrbv+2s7f13cMAXaNSJkl9nf2YvaPnbzMsIzGWyZSys/LK2/DMbELnGll4kGfRefxn5Zq2CD2rEn1EZdgNmoJJoxVPKSe7k+0+RdoOYtcPG5LXZiFMy9ZWia0lNrcR3La4gFSGbgfsADxZh4fLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123215; c=relaxed/simple;
	bh=URFYTieCVSZC7c5z09SQJ1b36jUaan5k48W0s0/ZCLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqVGLDzJzJZ92BaUBP4pSONTkj7RDwVcIedjrJZvfgsptgkxJGwlTzqv0k8WO2G0dm5YokdNkSmornvy+9MrZdqT5gtSZ47ZnZ5fCl1Z+5bub4TpyiDmjzUFoEltA1VNwlLM4jMZ7mxwouJAVzZM6wVCmo8wEkBdOG2LTEh0gLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn1wewad; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65e15fb394bso1880373d50.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123213; x=1779728013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qta+TGt8f8bCNU5lXsak/sMOHDnwEN56jda27IdO8xA=;
        b=rn1wewadbMdYNBApEV9E1quik05bze1uz5pNbmVDetrKQLcHduphxPpJqPOlzFz4Ha
         bemBwZR+M2j1Zy8C6IvX8LmT4YaYy/AyHH0TzZuB3J7P1Y72vmYNLnMWpcPrrZtZNVVe
         G0fkHM2WnxxnDqPyBgAvBhfew7mxF/OzaXKV+Z7rN1MK3VWDYYpHaPTqWApqJ2bn/EYJ
         kI2470hRWueZen/ObOtLjqSaH3TNn5QkaOlG/BLLlG20Wiamq6G17jxLIyYC8n8t3+Ze
         /0Ot75kKWD0FRqO88wdKxQLWSAmF/3XfEnckEH5P1zDnjArhGInQnOi5pyG+aEoX2oAa
         GYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123213; x=1779728013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qta+TGt8f8bCNU5lXsak/sMOHDnwEN56jda27IdO8xA=;
        b=B0Fk5/x2ugLYbQqNPEGTf4eG+QQ3WUfPub/iElQZfGt3njqMfQVLtx5IqKeN0DXsAl
         qT8gONAyllUQUIFfKB+PJMj0Ew1GwEQvZTySuyJIn9VNw2eU0/ayxE5lNXrKvby18oZa
         vPWt4Dq5V3Jl/HGIiYhKDYs6HllkcYH87ISisI590kHgBMa9retnnPNA/enHg5grjH2D
         j7wDBYk9hs4jBONPBYKJGcMey53N8KR8BsqJNKBaWJ45OOANv1x7ANo6K2pY3ZxmSnMH
         C94NZGG3EvHWCUe9476d42AaQAYY4wAPJM/DFKbiozg1Ob6yfTNhAvdM8tVRPiqHphQf
         WaLA==
X-Forwarded-Encrypted: i=1; AFNElJ/a/ug5qU+55vEOq951ONgjIQ4d1XX9b9wc0olJyXhZ51HuN9m4sOKFtKm5KoHytJFn02mPX/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OCZ1Jv+gWYjCftkktYpsB9Qi2R1ZBncU3Hry0m3CIXi9lt9v
	7XZnc43GN+Gm8mVGXetYUcnU4SkZgp3tgh/YcKAXrnybXUrdGuhbZs4E
X-Gm-Gg: Acq92OEo9FOezS2dqKeAg6VFe4hoBz0rlUtybaEjkKjA82EykJSOKN1VZiKI00GWiyS
	Z2vUc1A/S+2+6r3mzRsZEalZv9qQolHQuu0n3YeoJI5IGju/dYh/ZGYoAoDAlXHxbT+NA0a7Bus
	DxS1qCPjoUF9cywDK1ibG0UUkTEgGrtHkHa1+DfP1XZuEm9SQnR4+a5qi8kWywiWMdsdBWKH0ip
	kzFDIhtuYjvV2Nr+6pQLD75UD0nvHuY15bRMM61OGCZ234GUF8FtVryL4fCoo/VJECweqfA68sq
	uR+aYWQ7i+Q8ePjKNYKZQL0DpuEM78sQfTY62pUwaqs0HUP2KDEHmdN8M1sXh/Tu6BbAIySrxoy
	l9Oc9FGM1XAr9UVKA7zwFotoCpZLk016WCOzzefwNR56icQguIaPcKV6ATqcdaF+8o5jPg9GgmG
	a4wbP1mu+rrFHId/k4I675ShOSyvlykTHpjid0xw79vDXV7vUq9x82Wv0PfA4/dtTZ/5xY7YIgL
	FKGNoMzTZi0q6UI
X-Received: by 2002:a05:690e:1482:b0:651:b13e:f9ef with SMTP id 956f58d0204a3-65e226d2c42mr16777704d50.14.1779123213099;
        Mon, 18 May 2026 09:53:33 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:32 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon, 18 May 2026 10:52:16 -0600
Message-ID: <20260518165218.35388-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165218.35388-1-sebasjosue84@gmail.com>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249344-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDB405713C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: 4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v7:
  - Correct the Fixes: tag commit hash (checkpatch).
    Reported by Xu Yilun.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Add blank line after the new bounds check.
    Suggested by Xu Yilun.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36a0..4c63c7c85 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,6 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
+		if (size > max)
+			return -EINVAL;
 
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
-- 
2.43.0


