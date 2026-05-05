Return-Path: <stable+bounces-244136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MjdE/rn+WmsFAMAu9opvQ
	(envelope-from <stable+bounces-244136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADA4CDF68
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3FD03001474
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D24279FC;
	Tue,  5 May 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1JnpeKb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191E37FF77
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985482; cv=none; b=r7+UYPK9rnZyH9WI2t/56uLAupN9Q4/vjvYetGxbHEBY+RBCP9jTP0A/bwEUoarJNtyEzhTHl7ow6deTW51Mqy9Wdk2NQWZi7awvOOjR7sixxljKgDKpBy8esHmMmOaXUbrCVzHWOGkhWyVFOhfD+YfgPGUAL0uTa2v8cPPVLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985482; c=relaxed/simple;
	bh=YP15g5syC1euDU71I9ODlE/E1phN8HeNvR5a1T6LETY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hzmvuM3QJnVIcaRetqO2v6DAiutOsnjtvLhhZYFdAY3uRiSqYPAiLFbSrtqIVsbhkChkZ72XB2DwVMlTE5exn5R2d6nEJhIIb9VcnTJIfjiCtCfoRWWJahyx4SHcRikX6rhLZkm3yMpY3OrVant+WGyY64sT9zkuauamriHmwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1JnpeKb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7e23defbso2951420f8f.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777985479; x=1778590279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UYQAESnOyxoMqRm/R2b1rrlMHxu5iHH63AuKOpb/GM=;
        b=r1JnpeKb/fDRyfpw0GKVZurbqWJMjhszvSShrUENtFuVLaZUSPtj2xo/urY00fzhlU
         UemjGEIj39V9rQEwn78nlZeKYKOqvNJLsAL3pJQZmOtsBoYLXT/En5xv45QelnNkrvnN
         pgaf30xnBVbXkZxBw3W5cNF+Jva048I9+B9C2C7MmOOo/jF/D17GPhckYbCfw1+HNA+W
         z/Jsbq/+uZVvm4kqYOjHPPX8y3feurM/16rhPd4hdSSSRecI1wEvpl03ALDNzDL2B2Gz
         TuG/xiX9yF18VhSCL0M+E1VT2C0OnnDx6tI5WDAsrNqMfyLCiRf6ViYQg08sImbg1uj1
         i0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985479; x=1778590279;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UYQAESnOyxoMqRm/R2b1rrlMHxu5iHH63AuKOpb/GM=;
        b=HZ8NckkNZ4TZmgAX/uCHHOFHSFykxZbqT0+ci87i4bp43yRbsCk8CwxnL+YA7qWlDk
         xdjPY6emdRWIbpKEqG/E/Ts0I1ZS6OzpLrsGHRvkB0Ki6xmbYvFRheLe2O3F51ffTaJm
         rnVKFCxkg9lIJxfsEN/LS2t7Isp1r9w/inMuAxZca1ZEcUns2fl/XY0OUeuJpmkvpX6/
         FUFrFafDDgzlA5BY0ytmWvaRlHzHYIk846iGYAJazgKVho2d/AqTpvtg5b1P8cN71yKB
         F3VL5dYU2ZLjz6r3qYz1brpItx49TMCMvnwxa1+MbeE6ddpxLoKxILwYdKc7ww5QwqZI
         2BMg==
X-Forwarded-Encrypted: i=1; AFNElJ8xafYVv3b4o2+8SWhGMz0voQdSFr+COJ+yDnbvfXQnsgcLYrYk6EuKaaGH90J4VBEdwoJqjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGyg6a2wraOIBZRLSiqvziJeHLKp/O6JZQ8yWnJBACXxJJI5f
	wuct2WMSTxZwiHVI5egBqF/EQ1RGvKr60zCvNk7S7lBeS2cj72oI8Bg8TSA30iJqLnQ=
X-Gm-Gg: AeBDievDN4UH/f2Gt4vbz5LitFezG0Mkzc2o1BXYsY+ttUJPKE/fTVodlYJoXakyx8z
	P8jE40vyacJI6eIykR2cw/38jKQ1EWMrXtxXGoKp5aRNxSOi2u7/IHbOL9cbY/zpVHQyXYZLyg3
	QSIGytIQ9xB4iCp4Qwx30fxJD7ekMxyhQQ99qZP1eAgcyyOAvjbryYgnScZKDzwtouiJhupE+Ak
	drhvb75Z9IwpGzIpDhWB2mRUVVWScKiJM0VUlwhfvWRD5OYeCCZuMU3mXVnyeawsNVawp2TWV4U
	ZacI9fn1/g9dVRRUh+sd/aUJXLrl57x6mueB5OG4Eh4kl0yF77wIloT3Wp3F7dmzeI8b0GhL0PC
	vMf5Y5xnNs/qIEXp5g2QQh17SHzsD9PblOdZGPXDH/bkcie9h2E8z+ooT3hLKf+xSOV1vXNVjdR
	1kONksyTAJDIdIivRGtCWZUqVf73rPvvi0v7YTtHwujbNj7IHNImkqsqs=
X-Received: by 2002:a05:6000:26c4:b0:43c:f247:4792 with SMTP id ffacd0b85a97d-44bb32fd802mr24179647f8f.12.1777985478915;
        Tue, 05 May 2026 05:51:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:51:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jitao Shi <jitao.shi@mediatek.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
Message-Id: <177798547810.553197.7357142190879759101.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Rspamd-Queue-Id: E2ADA4CDF68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244136-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,mediatek.com,chromium.org,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi,

On Sun, 03 May 2026 17:17:08 +0800, Icenowy Zheng wrote:
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

[1/1] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending disable cmds
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/570cf799e87ae805eacfab3b4ba66676b5fccdb6

-- 
Neil


