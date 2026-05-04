Return-Path: <stable+bounces-242851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LlJHURD+Gn9rwIAu9opvQ
	(envelope-from <stable+bounces-242851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:57:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A44B913F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34061302B821
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA92FFFBE;
	Mon,  4 May 2026 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMfghY/w"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB22D5A19
	for <stable@vger.kernel.org>; Mon,  4 May 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877661; cv=none; b=h7IDG0K1Sz9AhbzGc+yTg5stU99wgHclYAjf57KOtqE7y2aT7SYUn4w3ES7zou345AcCDu5kp3x28SDBXRvzIdvycp9VHGLr1XOxj3v2J7ZUyiYTc0GbB6FI1IXt/iV1G2m9cq72y5n5b6fyGlYkPrPSMIZEJQ9jN4afF4Ev0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877661; c=relaxed/simple;
	bh=1hqe5xk6q8A/JJ7IgDYxkmD8c7CkAOuEyy57fGoNOLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTOnSXjSkTBE2Vh/d8r3BvhvnD3qjobEYN5arJ4w7fDtcgP6T1pMxoIT4M0ZNOscsF4egCF+gXjdJmvWJQXOkcGDvhJ4kxiamz/Mk1Hb3nSpq7I5MuVAqMKNpID+ulahcGmhDAhqe5I/9cH9cLnBwkcwbYr1VGVLPmTFVjRw8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nMfghY/w; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so2438956e87.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777877657; x=1778482457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84cmq9M5CJzu1gj8OcFfHRDpQSy+05+lbM8dfJHx98c=;
        b=nMfghY/wkxLJw9I8Y+mea44qibD1UKaUCIyowg1pF3FCLjHdOB2e2bWXwO7d9nZmSs
         BNxdjJZtZr7KidsEGBKLKaF/3ps5TKCQ4I2kXhE2B6Jn4BtW4bp9oTcbxUy4tnOleFmk
         VwcnS88az2vzB6Q0CqbOg1Kc6n0X7I64/ZjXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877657; x=1778482457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84cmq9M5CJzu1gj8OcFfHRDpQSy+05+lbM8dfJHx98c=;
        b=Joy4Loo9q46N8A0aDYwtM9dEH4LAAF26XKqE3hIgEJvuhoT7Mx1SeS9uSbYmpEoO48
         6/spFdwQpblpMcOqQdc3MUhyLT9jULauDgy3ouwIa5DFCuItGXLBQqbMal3tdTOCPOqZ
         QUzjf0tNs0f5Vs0MXyTkv3zQ9OQM54MhaMGFAc0rXZQn6pQqIWCr09RUi/77JMx8vVer
         VImyouGitFnyjf8ViH6mKNUmKKE1POnoilXOgfzpRjMXPYVvO1NmGbA8M/T0k9Efc8xO
         bqBYPvPhpXXAY7qZpCON1ux2YcYa3MK9ENuWUUJ7wTFEjgeWvBWLOzzNOQgsZ/AU3hqF
         idEA==
X-Forwarded-Encrypted: i=1; AFNElJ+cycpNF4kMHqRvU3Df3g8eZl+i7MgIEHf9xxdLRs0TXMsXVEEFLtaBbadbey1ZwRtYw22LwHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7drpQWjD6qAZxIimCnvCNldMw3QGZEwuStBUhFElrI+NCk36G
	uCPI7C3jzysVx6iuUWDJbBet9UC/CHuGSp2BQ1Ainjr/cHRwY1c7Lty1Th/9OaWWjQ==
X-Gm-Gg: AeBDieuRQnIQdXx+EPx8Vz3C48Dqanfoc5io7IQepviLkMIYyPWkwRpCfpSgLY1LxIp
	TCwhrX4veCNZYvDSy4Neb7RIZrD6te5VWPfpYDZc4H7dDiAjtnTqM0zAb/dvyxjf97PEQSbpUJW
	65FwzeGA9F5dbr/npvPxgVOcUCPglIAUtRjiWPwq8gmUfLwbZRjvfuUgRjuLWkRc2CviscvbAza
	89wrXidn4gC4jpRFAuRNs1fU4N3os0zyuocpBnIhpBlGs3R0ycre8v1wC82JvPHLPWkIaTN8+BU
	V/wchh8rxKXatFIr81M/VhTk0YCpb3FrLD8SF5Gnm4aLsl4iUstdHckwJrzs7iIGKLsMjy6KVl6
	pOIj5WofnWKIb5y+m6Cbt6XGjb7Jp0ufB/1Ubaab/vMiAhcsS4xh1kp6EMsbXIBRqe1Dlyqdam0
	uhuX27OvcoGUH+BTsWbe2yjYpBJ5TlW0XDjr7mYsjE8ToDotCPIgVllAK1Iw0Gj+NBtn8f1FGwf
	KdjFfbzeNpdTOQYNQ==
X-Received: by 2002:ac2:5599:0:b0:5a8:6b4b:bea0 with SMTP id 2adb3069b0e04-5a86b4bbf45mr1130311e87.41.1777877657467;
        Sun, 03 May 2026 23:54:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c22e1d4sm2674579e87.9.2026.05.03.23.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:54:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 04 May 2026 06:54:08 +0000
Subject: [PATCH v3 5/6] media: staging: ipu3-imgu: Add range check for
 imgu_css_cfg_acc_stripe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-smatch-7-1-v3-5-fda125c30058@chromium.org>
References: <20260504-smatch-7-1-v3-0-fda125c30058@chromium.org>
In-Reply-To: <20260504-smatch-7-1-v3-0-fda125c30058@chromium.org>
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
X-Rspamd-Queue-Id: 015A44B913F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242851-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,chromium.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


