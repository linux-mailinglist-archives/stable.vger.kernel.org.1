Return-Path: <stable+bounces-242337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA2gFsaQ9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:38:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A84AC187
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363573055D51
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA739C014;
	Fri,  1 May 2026 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F7deDkVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D092374721
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635187; cv=none; b=Uhm+ojsbpx1dSs/2I6KQdHWrNKcjLR5C9Ph6CwgoTJYLU+57s+BVgaoqBnmA6u9BR5jpdA6mHVjBFd7LPW+afs+kxt+ZxO04GXGVJCn+QMNiHBRkiQ4lwFzTSjJk6XcCCy8nsKxByyo44QqOoipRNpsOzDjb0DWBtkLTL7alL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635187; c=relaxed/simple;
	bh=1hqe5xk6q8A/JJ7IgDYxkmD8c7CkAOuEyy57fGoNOLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxsR3baK5C39IpKoEJQgqmxqLVuYlgcYJ4Y4aaak4NCuPbc6xH0+Q9E5Ax7b0juPnMaP03QiqNL/LA7UDgep3MuLNLvpqNCFQ8BCE12gw/TlhM3WAvL3agcu/xjphGokdrW5xa0kfT6/xWv5OjUmszhO3FjxssWAnK1hPqD2+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F7deDkVs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so2487901e87.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777635184; x=1778239984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84cmq9M5CJzu1gj8OcFfHRDpQSy+05+lbM8dfJHx98c=;
        b=F7deDkVsXqiV7VzVL9yQgZPjyOxsgZoMzoZKevlFDi1TcZpvBUp3CX23UcMcu/aCip
         WEbWJQJIcfpylAcKpPQH0hr07dQfKKqOCbdB3k07XobCDRvOdN1rSBdA/mcuURpwgt0+
         ISNECkOGqoXwwpSrWsqe9AWtx0iwDaZ7rJM4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777635184; x=1778239984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84cmq9M5CJzu1gj8OcFfHRDpQSy+05+lbM8dfJHx98c=;
        b=V1sCye4Khw0Z50B9BmQ3emlILGkAxEen98xN5WUJvjSl24E+PR2pO5fh2DGeVteLud
         Ce5KsaKoTw4AIO1BHFOECfXkFY5wBiCeP6oTWDxYAnLLI7XD3F7/6Cuz22pQiYcZzvP5
         Jeg7IOGnBseef1zDMfZl8prugfSuZx209GnyhsXVh3UbvUSXOvkdrUyPzrX6Hdq0JcDi
         Uvch8KUSnzf/w6LMLawE/JDpLNkjsfB21hTXMwNmIZV2y/YsRe4bTC1BPWEpNC78Kk/J
         lmc53Wyg5iNs7BWWKW81Ibx45fEoj8IkBd+p7x54JuqhaBFBqK3UQoTz6NDeBnF32X6F
         gZ6w==
X-Forwarded-Encrypted: i=1; AFNElJ9wOD5Gur7sg8R9O4jaULzaFP/7HV2vlXbW0OLY9rRCfTg++aRVlLsUbfZIlEboppoQfzAaSeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxem5gRtUx7M1rD/s8j1tBcWbH90GrVktSX1No0FxvWWEMHqFwv
	57i/3CozaA6hhabNqgxklZZ4C10wVSIJW4FK0HPpAubqTOW9WLiMPs3WXltU7rtPiOKXq0Uaw7e
	TLn0=
X-Gm-Gg: AeBDieurs0imluAN/lZQG3B8hj88k5RZP6zM0KO/+O603xmKzFoHeDlxQ3nEzUM79Ki
	ahtfFRQ82bzcFDs0//bZtoqv+uehkX8g9U0rOmVI2UEhKrDSrpOCBqp8rJPjAt01DocP9UUoVcK
	AD8fjR6EZ6KoT6f4rPQVASw89Ve+MEn41s+mPnu3GOzSKLz1xhHLDKStWpaETBg0AsyxBzTGuEY
	dh8VYRz2lRLCqHwQHuJbWTp0I0rxskL8uUNFvRJX0UEyzNvJSAc+mFgPKBi2acsdzlBn/zQ8YT7
	JFqdHonaIW32gXisUl6LDVTC6HrXNgZNLe81MX6IUCpFA2D9izgKTL5yQQZSFP1DAJH0uRkvovf
	+X77WaDmHuWvGLhSI5kWvu8KiL04IEQUHQmiDL01pXNnT2M3Tw90Ad/kwW0HxsYvpx9miHQ8+rG
	qwP/zL37xP49hetbCRcT2gduPfZBpeP7FMJDGGxNlajmiCpnZDxH5eC2AfwSJU+1s7ZZOVQRL7J
	CQbSwBztJ8QMtP+vLaEqvw8eclc
X-Received: by 2002:a05:6512:1288:b0:5a7:46e6:74c4 with SMTP id 2adb3069b0e04-5a8522bbeb8mr2381457e87.9.1777635183776;
        Fri, 01 May 2026 04:33:03 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c346c02sm429166e87.74.2026.05.01.04.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:33:03 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 May 2026 11:32:50 +0000
Subject: [PATCH v2 5/6] media: staging: ipu3-imgu: Add range check for
 imgu_css_cfg_acc_stripe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-smatch-7-1-v2-5-a2fcfb2531ac@chromium.org>
References: <20260501-smatch-7-1-v2-0-a2fcfb2531ac@chromium.org>
In-Reply-To: <20260501-smatch-7-1-v2-0-a2fcfb2531ac@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Keke Li <keke.li@amlogic.com>, Yong Zhi <yong.zhi@intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: A91A84AC187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242337-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,chromium.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If the driver's stripe information is invalid it can result in an integer
overflow. Add a range check with a WARN_ON to expose this kind of
error.

This patch fixes the following smatch error:
drivers/staging/media/ipu3/ipu3-css-params.c:1792 imgu_css_cfg_acc_stripe() warn: 'acc->stripe.bds_out_stripes[0]->width - 2 * f' 4294967168 can't fit into 65535 'acc->stripe.bds_out_stripes[1]->offset'

Cc: stable@vger.kernel.org
Fixes: e11110a5b744 ("media: staging/intel-ipu3: css: Compute and program ccs")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-css-params.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index 2c48d57a3180..92cce31e35c5 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -1770,6 +1770,8 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
 		acc->stripe.bds_out_stripes[0].width =
 			ALIGN(css_pipe->rect[IPU3_CSS_RECT_BDS].width, f);
 	} else {
+		u32 offset;
+
 		/* Image processing is divided into two stripes */
 		acc->stripe.bds_out_stripes[0].width =
 			acc->stripe.bds_out_stripes[1].width =
@@ -1788,8 +1790,10 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
 			acc->stripe.bds_out_stripes[1].width += f;
 		}
 		/* Overlap between stripes is IPU3_UAPI_ISP_VEC_ELEMS * 4 */
-		acc->stripe.bds_out_stripes[1].offset =
-			acc->stripe.bds_out_stripes[0].width - 2 * f;
+		offset = acc->stripe.bds_out_stripes[0].width - 2 * f;
+		if (offset > 65535)
+			return -EINVAL;
+		acc->stripe.bds_out_stripes[1].offset = offset;
 	}
 
 	acc->stripe.effective_stripes[0].height =

-- 
2.54.0.545.g6539524ca2-goog


