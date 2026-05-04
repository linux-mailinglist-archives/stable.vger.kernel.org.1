Return-Path: <stable+bounces-243927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNu1JGEi+Wmz5wIAu9opvQ
	(envelope-from <stable+bounces-243927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:49:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003454C4905
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49965301CCEC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AD3803EF;
	Mon,  4 May 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZN5OymV+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9138655A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934699; cv=none; b=IIJctXoxp/nPPbopDsVU1BUfFqQqQxXKpTVauZlKizggmHznvi54ELleRtXOXXJhheF25aSc1ITZS8FW8ZKfLDvbaw9a9IswoCxdz2BOouPPj6c1b9T8ZkGhM1VcZfPpaYgmTLxWhW75ecG4kCjWYEq4W6wqqcue7ie9abV+qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934699; c=relaxed/simple;
	bh=HFtkBU7f6FVMDPBQ8Of1+bl+XgSODl2khgc8+JT/6EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBXkvbyTmqrIkv4IsPokaOMHa8fDt7K3672DdBu097YVdRfP68PDI3COBvWNu/+H9YdZS6dBAdlWwq+FsEeSA3YmkVI2qxoCjinBtE9Pet83DWuE+oyR2NKEOzPUBNrOwAcGS4ey/8rCqUmZK4zl5MzFMXbwIO9DlvjB+EF9nzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZN5OymV+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bb962ce4dcfso702708166b.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777934695; x=1778539495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCtqeJ6w5ygfROMjoa3DM/xPDegbtqzB5MET+XvOzy4=;
        b=ZN5OymV+RlH8LQnp3K+nisnUuu+l955V2h0G62mWMIl3U6ngrFhs2hGLFBAzRistR1
         20U6SDasCn/kt7MCGmcIVMxw7biWdaivOC06tIQc+xME/6ufHJfIqePsH1aI2sKWkCEX
         Kmh9ZnZnpKJ1ygu3V5lEVK2KbSoNqWxqp8T1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934695; x=1778539495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SCtqeJ6w5ygfROMjoa3DM/xPDegbtqzB5MET+XvOzy4=;
        b=DY0W04+SqfR6LxQCtI9pawe/T/KuHSOx4yZEIlWR6edZExSlzW6Agop/+2969PZGsw
         IyzccLGfhhSLVHe9J4mWVAw1Nmp6bgozHrins39YXGcTBQsTOJ7g/sv4Ju8QohEUu5tW
         ZElgTWptKwcxi9ORbz7tWNg5xCFdqPRm1cZTssplvd6lI5KelEBP3Ezh95KowDdZqx3O
         ogWAsmOKpVrR4agdBuJgye0lbdi8EdCHf3Vc4ovAx12Ptj0fbF2sy5nbvz1wPDli1J/l
         tXSnsJXBpRUEeTn5sZZZdU2OV0AWuEhoLUWSml+pGcUFM9+fTuGLxd2gdSUAhpPMVbkQ
         XwHw==
X-Forwarded-Encrypted: i=1; AFNElJ9BHrmd7xTetLdi0pvTicmJkLsgMNrrWycMQ2bWftS/wCuX5O3Vn5MQH3fwv0AaWa3AnuE2dPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ywl7InqzpTzuXsQFixjTaNw2NtkP4GQZOaZPRj1EW568CBY9
	Q/nV1iuG1S/ryKUT4na5wv0prH69oLdskXE9ChakUcE0qEi/WGoP9uZh85N9yYqcGuN/1tLXNiX
	NFuakKw==
X-Gm-Gg: AeBDieux/m5tXqYj3GtrwpDB71qz7Q/z98MxvAWkUJn7Z7xw4H2jdf3FvOkjI8VP/bB
	I80k/hSJvDSVyQ8W4LkqmkQGcBKh3V+KTb3ka4XxA2nH11HjBfOJ/ksG+7AKxx6jxYPsun4+VzB
	/My43CuD1tvxTw3SvfeJkWJENAIFZudjV3p86y28HzhEIbvI0glvoeiJbA1LznDho8zzkS5GCm3
	/nIoRMAPeV2KGd7/3wcfq9rFG8cE+hrbOCR0yfYirzIFLGWk+/qn4XXlLrw/sWZnn4WLMfaGVMs
	GMND0UpweBvV3LLmdAdZD6fksPKf6XDf8QFcNY3lLCFcVUzHBGh6HYJd83IBkDDzjf37/QH1EbK
	Bn5rralHkD2fHGfO5xe6VKtUpiiC1MFIzotD+dARpT1Bs+LAmUS32jRtuG5wuX+2SKI11FBm04s
	dvsKxNjgxD/4BHlAEV/qQoEPbJ7PvVFDcQi45oiyfFB39VZX/fJWyHiUd7lnQgkU5Z28zQ5yEi
X-Received: by 2002:a17:907:dac:b0:bad:a86:33c9 with SMTP id a640c23a62f3a-bc41000f5a2mr24104766b.41.1777934694618;
        Mon, 04 May 2026 15:44:54 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6a64d990sm445301666b.22.2026.05.04.15.44.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 15:44:53 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so67104155e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 15:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2fgUNhPMQCLGQCm4JEvfr4nYyRwxHbFiRFyOYGVPN1qcoOzrTpuZ68+aKBHoh6oJhohsrokA=@vger.kernel.org
X-Received: by 2002:a05:600c:a401:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48d18ceab19mr6062235e9.27.1777934692325; Mon, 04 May 2026
 15:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 May 2026 15:44:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP=VTg-AV6nmyA55+Vtr380Et=B-tPvz3GUso6cGVF1Q@mail.gmail.com>
X-Gm-Features: AVHnY4Jg0cHGDRcJW7kbYyloRz7Kb98N0jv6U-blFJnZEpx4hOJ1n6_1CgkshL8
Message-ID: <CAD=FV=WP=VTg-AV6nmyA55+Vtr380Et=B-tPvz3GUso6cGVF1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jitao Shi <jitao.shi@mediatek.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 003454C4905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,mediatek.com,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243927-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]

Hi,

On Sun, May 3, 2026 at 2:17=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac.=
cn> wrote:
>
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
>
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
>
> This fixes error messages shown in kernel log when unblanking on
> mt8183-kukui-kodama-sku32 device.
>
> Cc: stable@vger.kernel.org
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi v=
ideo mode panel")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

