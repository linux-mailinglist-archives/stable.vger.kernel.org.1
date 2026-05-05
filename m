Return-Path: <stable+bounces-244137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLgMED7p+WmsFAMAu9opvQ
	(envelope-from <stable+bounces-244137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EB4CE082
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F303091442
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9972438FF3;
	Tue,  5 May 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G974Efue"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C023815B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985483; cv=none; b=o32zKeg+3l8jmapOXPIfZIfal9vptYKgm/0ofwC9Dra63UgF1JD0QKsF6blz2IEZKka6p6ogLX4aEn2gH7BuBqtisWrIByYyefsKVoo8N6aSbPtyoVTEJkNsl9iOo+6XYpsp5zNts4YLoqb/T7W1BS2rQ93RsORximRkPdLarV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985483; c=relaxed/simple;
	bh=kUAYJgjOB5UJXyssr/If7hkljaS41Y9K4F9IcX4EkHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fSU3AKjyMS+2IeOjdYHsBnSFcFgApjaayc5V3G3j3/BVISe2DXkYKWRhTcOafp9j+AVE8GbCcUwubZzDepHyDjLuBsMVBKg0wp+zalaWKvkfJsVByHHOpd8aIFaVhzNzmyGnGH7h0o9TmlQbJrgiM+2WYRSd7xyfBRytMqmuxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G974Efue; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d75312379so3560368f8f.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777985480; x=1778590280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYjSXtv2b2p1dWmem9U9G4n20yFMMRsWm/tKYwxj1Zk=;
        b=G974Efue6LERP5MZyOkpy63nWRHwUTmnuxh8EUrKmIO6ukqTbDknDeTeDRKKZSTL/a
         yGPHjP8SPmN7Ld1ttblpSUl8ugI8qF6Fk5uVd1o4HE9T75Hf1x4oNP84v1xWOGx4aaQu
         +w8Eby7dQhjDiHCoVy4fQ0n1y7c/+YlkmV6REw9C/m735QvUc1pPxA2ZtIq2ThY9SADZ
         tC07QKz/Gz7F8IEKjtzbZScTI20FeDPhI+GGucNCpPp0zYExPSnRyJHHg9c+ADRPxq/b
         xDLA2jyAkEVK8gK401P9Y67Ukc7JZlt43yrFFY4ktooYGiPA7bP4/7lrGrHSRA2g/ozt
         IfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985480; x=1778590280;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYjSXtv2b2p1dWmem9U9G4n20yFMMRsWm/tKYwxj1Zk=;
        b=LDZonxVWGwyJN+LrVuOd1qIwF6zm1DCfC1w+uolqubhdP5s5GkJF/IwI8p8cvaXmqk
         H4AyerR8zEqGyU/dnZvn3gqk+q9Wr6fJo1ldYsVL1eP+M/S0dMPe6UPHUnZUAYk48qGC
         uwiqCFvG1Pjrgt6diXdmxBBCYKuV5zQBSXzT1dpma7FOgHNVM2GFMoANHFwaFpVmG+tV
         otsSpN4DqQw5j7tzzkzQrzdP8Igrnp93lwWk8eUws0LE0t2u1H1JAUXbPLDzZ4Fc7BF2
         qe+BVHhYI//F5e95/0U+retxR+Fhzlj6ZcKJHkAKWgy3krtNOjsp0d4GvtOUJ6EHAzjV
         dYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EyxdP3kBjHp5lTNU3nbjkyk7dIZHvdUisQ9WMnHWqJpZ+D7M5ojQ+Sd0tiApAuuma0PGGips=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWUoyeYgp4j8eKKFZny8gtfjlR5ynwP7fgxOlOl0EVF52jwqt
	s6oMAEUIG3UA6fKp/aKEacEClrMj3xLg5upXLJDkK1vMtdIuy68CvVCESD38xM2BE2E=
X-Gm-Gg: AeBDieswlgiv0O6jb3QK7OUfviHh11smT5sAfKt1M5BL1G0qJDyrKJK8X+IugcZoZz3
	B9XLrnbQkc8/XoQQmzDJqCohEPV11Z+oedHNboKvZYj66qnCjdAVxnmSnQd1iWh4IFGSAiQc35o
	NsVYn9/CFdtsvHB+GbhG0U0QXDMHxNKmdp0hbwevS8fhxwRuGorwALjsXprcL9SbQHWpVyDN1hm
	w3pxX972jbj8Jo9jfmLECtiwod3eFXXrvLmKuPmcrnigYgUpj/C4gHdzrEKE+2zwwjElDylZcQF
	IUWh5IoCqL4Q1uiUC0kWuEcjIWA5sfv56qvn1HK0i55rGeG7iOFSRuQdM3+NXYEAOwKFTeOcdRw
	QMgNKSon2P20y+NrJjYZxsv9GQE2elVT2D8FCX014UJK4STa9ybrkLxviuAyA/0lXV+zwi/L/ZO
	OgIBkboOWCi/t9owyf8379Q2WWA5wJRqFucA7W9IXI9OnXekl33paa/ybvUCo2ygv3kg==
X-Received: by 2002:a5d:5f50:0:b0:449:31ca:5e53 with SMTP id ffacd0b85a97d-44fdc4fc60amr6655328f8f.8.1777985479921;
        Tue, 05 May 2026 05:51:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:51:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after
 sending disable cmds
Message-Id: <177798547910.553197.2210349130446801175.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Rspamd-Queue-Id: 891EB4CE082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244137-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,chromium.org,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,gitlab.freedesktop.org:url]

Hi,

On Sun, 26 Apr 2026 00:57:51 +0800, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2d4e80271f784aa0c7b17676e9762c7e8156be1c

-- 
Neil


