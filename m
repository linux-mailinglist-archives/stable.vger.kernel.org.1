Return-Path: <stable+bounces-244349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KZVLXEF+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:10:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 428464D85FF
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99CCC300AC15
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040B3DEAC3;
	Wed,  6 May 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPmDfedE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3F322B8B
	for <stable@vger.kernel.org>; Wed,  6 May 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058600; cv=pass; b=gYZmaP3zk8l199n8MC79/Vc55bWkU+YH12WEhyS6lo1woqCaBkarI4MrtiSEwd+7w/SK9TJzsr6IBvhel8HIoS7hYswtLjodwRte6cXB2cfVRwSg+1FifIc3Pqn2UKJktvfMPS1GH7X90QuBYr+Qy3QbVrf7vRgyySKutSinxTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058600; c=relaxed/simple;
	bh=36tAG94Ia8jgi8QJHIfMyYsmOTCZP7DubPze3fZ1KyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAU5X3UgGJVcY6FrDkUE00aSG/BYt6tL0erpyPQ4nmOY1dZvAuX7rN0Gnmq4EPFI8R0L+Z+Fgf86bzKrU/UmRPqkFNNXmy3IoJc3qL6ZFkavcWUIcn9phZuNweaDYdtInQ7zorvt7Ipx66yQaW9gLhwf9aFpaFcF/Tn3lYr7Iqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPmDfedE; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64937edbc9eso5217215d50.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 02:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778058598; cv=none;
        d=google.com; s=arc-20240605;
        b=DOsS2iIL9umGYpw1Rqkpw1HWoV3YSBBicNHd+ZsMI2PMmu0qkiLRyLQfpbZm7ANrUa
         wkEhVu7uhQxn440digwGcV/uXosB5Cw7gPuUH119gSnhoOovGhKlMhGfOr71EpUAN7WX
         IYX2CAKwB2AaVDfRXj/Dua5C57nkDtkb9xvyI7kXcbFYkyA3/xwx7P1GmWw/9HlMRMl4
         vCKvwqOImEfOrlxlcCFY3Ou5kJAh4GuvDr61LtmnLRDZMUCwnMA7RWJkd4DnyKbxGu60
         fqi+t+YImSZGQXWeiKOr4yHojIR+yS1K/Luzc04WL1fKrFZDwoEIZaIeU2mTohqA6UC7
         Iy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
        fh=ipOquNs9dA/57v7OsQzW7tS0pquzzV+KB1AVLGC7apY=;
        b=geCYq3Ubuet7Q9R6IrHZn5PbtXjXkkkLEOCbLGy/qcJTQLXpZRqXr/yNSUEba/XTsi
         6IWkDcTFxCKaFtrRjIXtU5isbLFe4uh/l1XoAppw6BFKNYTLcrtZxS7kaf1h911TWLOn
         Q+ODTpwfsnZQGZ/El2BNoNqeKlvHUvzxRbTxkvppZiCHe6693Xd1EahCrnUliBMHrwun
         WWdJ7xSUHyw3nIkEoYx6nGVO3ywjQhEy+bb0gK6f524qoTH0PliMAJ0Sqtj+4Kz+zESK
         ClMUgFul+GqNIxZECYo4f0zRZVYOuyYzxkbDzvNlbelbPENusA2xrE+OaHZ3l0JQ08VP
         52cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778058598; x=1778663398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
        b=sPmDfedE5vVWP+lcZhlbbLVqkV5fwXYR8jvxuNv/7pzrXBC5UtXLjbNsSQklUl5jJE
         LqXDfUJaX1W1MiJ6in/UtkGSoxa7dLm645jba/VIjE0t8If7X3JTubE4/RTuSJXOhLEd
         nByr2pRHiazFgc+yXd0mWFn0KQ/T1Hv1+Wt7fcyEPv+q5bsf3BDfPK91NN/p1RlkMQl/
         uVXCXIgxQBu/zOOhnpYXbQkdbpNUcR/Fq69BKG+RDu5QWlye7dWBKFKJAKZ4EBflfvDE
         lgx53bQfTuW8eli4Cnhbhm0PndOupc6DhTXnzBzPS/+WrVWkcX7lTdo8kqgOtFBucxZm
         SP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058598; x=1778663398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
        b=kbxIcy27XVNzZGGbzLVAsTsrCCLSp9mijb6EHPQTOA9L9Ei/fj49MJK+PelOGOpQCK
         EH5TpO9li1tQdgQfqvR43TRNMHS5DK46FutLwLfMBCnWOlm+yJApSkskh6RbmC8Jn7om
         h+xiN65D86WgDUK0D2+1wWSL8LkO8HS6SCjPdvxpI/d4/KoeSa5AYu/nCZqSZN20aRwj
         3JLFixQuH7V/Oek6+AcffxIYdU6ob9OxEF9vjSColskDM4s1WpdviNhmr8hmAGShxnY9
         7OzeqHp0/i+N+U5NH3PlTwC3uf4qLqHLHaAWhgBDW11Al4OZ3ZtH4TgIePWDs7ubpP0D
         lTrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+osDWPmCGDyfHmm0oHs4gXaa8045INAZ0KOt9jNFhX+KaL46cY1Zttxlx0VI0vttBIu+7c8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLALp+U+of1fWj//Zi0txyV1AZhLPLnPN0P0pUDWZU7tDTiH2u
	J0C1TYT95NCT9VZC7ybezf/xM+H+6YU6B59jwpv7kWqsC3OtOzLMbkCtV8lJB1WGI7nClvEs8a2
	6OH0r517uyn6BdhecfwDJAGSulwu2LQw=
X-Gm-Gg: AeBDieuUkCxaDYIShdN8X+YL4KgyCTjN5/IM/9+2rWHwvzGQmK+iK9nAgbI4WHRwhVO
	UZGa6YiZ9c2vJI5IkOjjcYWQy95AAPtX+dm/u91LE/WdBohT+oA/Ji1W41rrGoCswSrn5BX5Ebb
	G+Ul2bSDrfs9ga0kZA0X3YtwnFhM/tt3Mmnq2K9sqXPr5NrHbzCrg9cTlR+vMNKrD+P255EwTD9
	U6gL8Ff9NwxOdhcAxAQq+dNRxhfQ/oJIWbXjbTgh6VrzYiu9w8ZS1Orh4zH5WfGzYX59S2VXG7a
	QBs/uCE3MnfHIy8TRp1T2Qnx0rb/4A==
X-Received: by 2002:a05:690e:1447:b0:651:bed1:19ef with SMTP id
 956f58d0204a3-65c79a4a569mr3077966d50.62.1778058598028; Wed, 06 May 2026
 02:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505082145.603262-1-lgs201920130244@gmail.com> <afrn-zcfiRpJzIcO@raspi>
In-Reply-To: <afrn-zcfiRpJzIcO@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 17:09:47 +0800
X-Gm-Features: AVHnY4Jk9YyDPydkL71fov0bFSSu9j0Lq1UdfKpQsP_hQX1hR4bNL4d9pygNLng
Message-ID: <CANUHTR8OD=uNMC3aVDc2oNeUwAWcsPsCRda+9RckpaUOhwHSqw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 428464D85FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244349-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Liu,

Thanks for the review.

On Wed, 6 May 2026 at 15:03, Liu Ying <victor.liu@nxp.com> wrote:
>
> Can you provide a minimal fix for stable tree by not using the cleanup
> action?  You can add the cleanup action with follow-up patch(es).
>

Yes, I agree. I will make the stable fix minimal by not changing the
helper function pattern. In v5, I will only avoid using the cleanup
action for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge() and
release it explicitly with of_node_put() after
of_graph_get_remote_port_parent().

> Why do you need to initialize ep to NULL?
>

The NULL initialization was only needed because v4 changed the helper
to use an output argument together with a cleanup variable. With the
minimal fix, ep will be a normal pointer, so the NULL initialization
is not needed.

I will send a v5.

Best regards,
Guangshuo

