Return-Path: <stable+bounces-242338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMGnEqqP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 276494AC0FF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEDA43004F01
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A065D39EF09;
	Fri,  1 May 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FuwyeX9U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403F3947B0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635192; cv=none; b=fdELJ7kLQIPZFrSDQBsmv9eXNKuVHGZ5rj1RPu+2GjwfwN9dS6jW1hm1m6ET3Wqhh+oXyP0BEJ+xKItOQO2k0xSTprmRlUsT+ZiFTxsKAl4U/0R3SwEB0n4m3m23CMz4/d2GUfcJsvCQbI/r7ZtOCujeHia1XziMP8zA8DGMGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635192; c=relaxed/simple;
	bh=maPN0uAGh5T9TmRwUDufwkMVbmorC5oANIGuNmwR7ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2BDrGzarBFU0dXe0ku3DAjNCQKcehydgM8MeseUAQIxoAzzhx+tWDPzMH/5xvVzWhhZfP44/R6KAG0gwxZEKfoWz1LMO8Lng0n+H6zR+PNKO6E79NwHTopV+wbgmP8JybCuGeprLpdgo9H9Fg445buT3Lu0Cnljvc1ttZOLQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FuwyeX9U; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a4113ab355so1916998e87.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777635187; x=1778239987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kcPDoUx1Q/YaISrAn+S58ePlDUIO7Y3t/DDUcj1x4Y=;
        b=FuwyeX9UgcMIM4AW2mDRMHVqdlSsYKq1SloYu1Bm4Et1u2Of/VBjY5XQT1JLiBm7Xh
         Ujp2EgH8yIpFsgoLGDdzjw0g+UQ9vei1jrz2CcMk/zCNnbLyb/GzjbMELqBVM3UIIxge
         /uDPKD++FEnmmtWBSreNNhwIO0/UMsOdd//Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777635187; x=1778239987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1kcPDoUx1Q/YaISrAn+S58ePlDUIO7Y3t/DDUcj1x4Y=;
        b=ACmYJpIFa7lqL2OeuPWfNW9snOaOX6UBNhN/MeW55VAXdO5SM0ViGr5ll39+YHJCfg
         VeJNd8JyFIrSF2vFbO5XdVOLaH03EwDd5U6EDbJDq+ngsYG9S6BHefRFFjLaJkFOQaxj
         ZlTf1Ib0/onCuw6LDFKDBZ70FYrnql9NhyVTWTbaRUIGi6a2LDBvM0LUtzmitzxpKYQ5
         lusVIOAKsRF2377XcQpPz6+TZOsRwNJwNpk+2pJ+ROMDr7jVq/3DEbU0KJ1oOVl9T57h
         TuEfX8jGlcYsvx4uJ8CLt0LIDBq3kEvR6Z6shb2kG9hvmGV9gwRLdAOQuBk/vEzzdabn
         p60w==
X-Forwarded-Encrypted: i=1; AFNElJ95bPHLw9LhPJXWfzblfjqJOkbH7J9HxQyuxN0ibUfqcMqCpPRoktspBrGaTGxxZ+a2RF1Pgbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9O3xbMJWRyyI1tb9xRJXZAkE1FV3HKOkWxI87u9Yo7MRf/Fvy
	QPmzUX7LV+VF+cWuxfFgqXKggx1xdm0TVDvEUDrKrQBreS3ejJS9SF0TemdPP5qGqQ==
X-Gm-Gg: AeBDievT78JMmq9YXSgk0qKqJ9/f91T8LIe4A3zVgAilP4jh9yn5zSBoQNmoh7gUHV/
	ss7xSoSegXINwcG/bmYXx3Zij1H4pKVKAdrvo15mzNZLepOSBvFci9c4pvr8dE6PbaUHq9lH8vT
	NXEKcvb29oigq186bCPflaFlqyJ7IHRghzEIU7/5zPFhaz/2/Tns3N+CwmEIycLOKoQWK2ZkM0y
	FvzFL7v14EDd31ABmYoVhOSwEM7PKce8Y5oCRml5nVgMe6jZlYZBvJakpZ+f5WGVafvLRbzk1a8
	X95+9ceYaQ590OAj+/y6SevBP+zw6hJ1AsALBvQkevL+BkTgQXDD0+e+e/9xbhcz1Po2rMTRP7L
	uJQfZEIO+kvMZSHIbKr+Dngu/QzWd49SSm/sKBsBd4i+OVIlu7tQIKqGSMqPpMerrDPFIZtL3e5
	h7aBLkQ1hU1Eyi8x4tujfXjHwQ9u99GopRp6vS1gmwVwaqFqmQGiOvhdq+/7OtNADPwTA3eOrMj
	0l+Ark9nE+eLYK1YQ==
X-Received: by 2002:a05:6512:10cc:b0:5a3:cd94:df73 with SMTP id 2adb3069b0e04-5a8522dda2emr2212355e87.38.1777635187389;
        Fri, 01 May 2026 04:33:07 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c346c02sm429166e87.74.2026.05.01.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:33:05 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 May 2026 11:32:51 +0000
Subject: [PATCH v2 6/6] media: amlogic-c3: Add validations for ae and awb
 config
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-smatch-7-1-v2-6-a2fcfb2531ac@chromium.org>
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
X-Rspamd-Queue-Id: 276494AC0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242338-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim,chromium.org:mid]

Avoid invalid memory access if the zones_num is bigger than
zone_weight.

This patch fixes the following smatch errors:
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max

Cc: stable@vger.kernel.org
Fixes: fb2e135208f3 ("media: platform: Add C3 ISP driver")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
index 6f9ca7a7dd88..aec3eed0e443 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
@@ -104,6 +104,8 @@ static void c3_isp_params_awb_wt(struct c3_isp_device *isp,
 	c3_isp_write(isp, ISP_AWB_BLK_WT_ADDR, 0);
 
 	zones_num = cfg->horiz_zones_num * cfg->vert_zones_num;
+	if (zones_num > C3_ISP_AWB_MAX_ZONES)
+		zones_num = C3_ISP_AWB_MAX_ZONES;
 
 	/* Need to write 8 weights at once */
 	for (i = 0; i < zones_num / 8; i++) {
@@ -220,6 +222,8 @@ static void c3_isp_params_ae_wt(struct c3_isp_device *isp,
 	c3_isp_write(isp, ISP_AE_BLK_WT_ADDR, 0);
 
 	zones_num = cfg->horiz_zones_num * cfg->vert_zones_num;
+	if (zones_num > C3_ISP_AE_MAX_ZONES)
+		zones_num = C3_ISP_AE_MAX_ZONES;
 
 	/* Need to write 8 weights at once */
 	for (i = 0; i < zones_num / 8; i++) {

-- 
2.54.0.545.g6539524ca2-goog


