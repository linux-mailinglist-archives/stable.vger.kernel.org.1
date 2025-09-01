Return-Path: <stable+bounces-176796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4EDB3DC47
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB3A17B2C5
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450525CC4D;
	Mon,  1 Sep 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz8uyAzg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CD26F445
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714999; cv=none; b=B/BnK2desjx/H8Z6AAjYM2JqKZr6hUwmq003NISDtvxl4Y3SFnYVazDTKyzVtHmsRz7irjxDRfa+c5zkkFFe0DB7aJRqGhms5z4tK87WS/Y3fVZVpw14R5csQankJ7L7Z3VfHa2exAG+Uc5tD4x+6zWR8bfjXNLJB5mvzfISKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714999; c=relaxed/simple;
	bh=1GRc8xrxN9zGX5wz5BhvKOO2j5zrzx4fFnKG/lVnDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8cb4qLXhrNTEVCHF7TJEIJSB2I4nhSSm2olwqWV+Vvr350zT6SJYhIfNPL/Md2JTbGPnEJ6SeRXOW9sZyvJUHrAtyoJNmqQn6e/jX9iNBJjgH56Z9c2Evw977OrPWH9eQSqeOaKBTZXdrcDvD5oDOoCq2IpDnA/ula63RgIyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz8uyAzg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6e0eed29so1602545e87.3
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756714995; x=1757319795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=Dz8uyAzgarZvRBDqWWnP+o0U86ka5hRrkwgV0NlTvB1H4KaavPr9OXtifRWGyBpZhd
         4RTS1Ii3q9rZPzEXv7pjrIuX0WiyIwNmB0j8UYGYKgzC0kYLccqV3fHDCbNXMZDtQjmo
         gQiwpG28ZWd1RO5BUKErdyIHmeplvRsTKAfX4KMeT2vNdi35UdCczvAp47o6gXIuRrEW
         4hAH1yjoEa5fO48bu4rAIl6QTIJptC9r251HxtiEPzW5fHQXTJ+LPtnTCykdnAqZLHG/
         cu9lewA9vJ5uQ6U/VqsrNIjybREuo4VgvovYZorEknE1YhCNECxrNloex32z6/yU791v
         /f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714995; x=1757319795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=ohTI2Ok7mqX3J+TcjS4Krjc9e18jbMMULsljXJtNmEvhDC3PpgFO7ftoaCp3kWEWCb
         kkSfvpn5jubXPSZJI1SrzIjIE+rVSKkimGV50QNVB+Nlj0YEF3WGdCsDjynw7I35HeHH
         O5zaP027c3426D+4DG9FpSxWe4EDf0Qka7w1tlnVpO3ibjitCwuqyvnUtMv0c5c9CFAF
         fXgA406JvapB3k80s8wcE4hZwiqsma+PvhLKY/jL6VaqeaNSui/L10allJWn5/6ug2t2
         qTJjzxFtCUxzwJu1ko1FsmEbSX7UHzOYkqRo+OAhU3t2k2aG2kMcubdivicttAw+DI6a
         I7pA==
X-Forwarded-Encrypted: i=1; AJvYcCW8G7A0v1HBp7VaIN+fh8FICr+u1j+t0pNMU9THbmbwTiej+o06sXHm9vXWOLTG2PHsX34lXHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAws3/w1YuGU95JtknB1nPviyPo0bcefspweJOBHbWf6hOmpsz
	sdAvtv/4EqMGMWZJLXXbYdYFN87p3IDC823fJJjwM0GiYYNf4IOrn9+uVrJIuKUPulr4b9CUZVP
	33vMJ52JSYvfiloW8ZHPPAW360qOfSSDevQ3c3HVS4g==
X-Gm-Gg: ASbGncuLVwqAt0uLHLfXcOX8LhpRn1kodF2l2A9Lbvcpcj2mRNrhV5PT+P6pA2MkBce
	/MTZgxXmW9x8lai9+exTpNEu8MIhj+WGxyWz9+Cuy7bnsU3ensNCWwWBh/C/piVBZa2mbPH4khV
	Vpvs3iqzLEHFF3ROY90kZ3AMFfXHYgcHA2m26mIzLQ5xbrsAwM26FTNP4XN/z/UGMfa3IJrkIxH
	MIwCbtR6NDOlNHJZQ==
X-Google-Smtp-Source: AGHT+IHVwIASRqXdiBtabwQpeTaLvx/MwfpuhWhcvrvqvY8VLXWEY8BeiyfCJbCTfLb/GJ7BJFbdc5bUK1izSWZcw90=
X-Received: by 2002:ac2:4c47:0:b0:55f:6186:c161 with SMTP id
 2adb3069b0e04-55f70a0081cmr1669470e87.49.1756714995167; Mon, 01 Sep 2025
 01:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901073224.2273103-1-linmq006@gmail.com>
In-Reply-To: <20250901073224.2273103-1-linmq006@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 10:23:04 +0200
X-Gm-Features: Ac12FXwOPFvcHfnOB3USWBMbhSfcVlBY0l39KH-IS_467sKxEs3coXt0xb6oRRE
Message-ID: <CACRpkdYVCU3Pb2u3r_G0BY19mbF8m1je696RNP_49rU7G4PvUw@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:32=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> wr=
ote:

> Fix multiple fwnode reference leaks:
>
> 1. The function calls fwnode_get_named_child_node() to get the "leds" nod=
e,
>    but never calls fwnode_handle_put(leds) to release this reference.
>
> 2. Within the fwnode_for_each_child_node() loop, the early return
>    paths that don't properly release the "led" fwnode reference.
>
> This fix follows the same pattern as commit d029edefed39
> ("net dsa: qca8k: fix usages of device_get_named_child_node()")
>
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - use goto for cleanup in error paths
> - v1: https://lore.kernel.org/all/20250830085508.2107507-1-linmq006@gmail=
.com/

When I coded it I honestly believed fwnode_get_named_child_node()
also released the children after use but apparently not, my bad :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

