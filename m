Return-Path: <stable+bounces-253414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNPXLbBSDmqm9wUAu9opvQ
	(envelope-from <stable+bounces-253414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:32:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9D59D4F7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B90343036E7F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076F24DD17;
	Thu, 21 May 2026 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzSjS7pX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57F203710
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323561; cv=pass; b=Xln+lhmUfhoE5s+RaWZQLMnDhZYM5kYNtKJ/bCMi9/hCQX6BwrlPYOXpMgks8Wyqrho0a6ffc8LpbdbSAa15hCCTWAPufL0hzXyKG4GRsoabkF3mdLueRVI04b7bxLlvcF/B6QllV24bu5U7MmYpROcvPeWizbfn//GZYJOKyoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323561; c=relaxed/simple;
	bh=OP0rzISuFZMersn24fxgds7E6SVOSrMeIz6B2yS4+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEkOUJJe67dewOiJgB2T4ot97f1rPfz5Wo9OZRdKAd1aj3Zn7UA+7d/aGdAkG2baYjVeqihW33Dmf/P6CBDYHqNJBrcylk1Lr10DcAknKsuky1Y9u0ZnzhJV3C71PU+Iz/LbI817ruMDTWt8xtVOHifFnETkwRaeBGbzfsDgCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzSjS7pX; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bd6f65c781so45330457b3.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 17:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323559; cv=none;
        d=google.com; s=arc-20240605;
        b=apCiE7VuPxkCwhjQzWG2JmiVR3yve7C+6XesXqLI7mteEUGnpbqBH8wTIUXKAZjehh
         zXzWvBAifrdAjqtQKbH9rxtlGmQixP+adsa8LENFR5e0UocSguj5niQQ3RqjATD/rueK
         fmax2zGAszKxyA8zz2g9RIIb0FWJsV6rF6z3Tcfm7WnBR/n7O/yb64xxHuuG4ic6JkjY
         b59cxN2y7iewOrAxR4bSUh55XzJez2Xnt6fcAf+UTf46Yu9Yd87W0mqufy3UWU/yoU7H
         V0yY7BYkczVZyyj8a+zuFt8acSKnrLpaJTjmCN5Mpm+RVQzdM2oladdllcbbS/WD1mVW
         PIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        fh=m8sBY9FRTZ2Lhn+vkUK4BkoKgN7O/GPQlnoUHuAYBqY=;
        b=i71GqKhDKbrBdiiZghtz7AaGfa4N9XtWkPcdf8OK6kVsQpFyEQXfx+xZQ9ddvmR4vi
         ry2WqblUJRc2eGvoW3JXdlMifyPpOCq/rXJsZ9TlLsfzCqSZJtHhaSmSqpv2Rka7mCB1
         hmKKoDikwEtYdx/mF2KHxLj4eutnhbfUYHbfHc+t0PPsyPFk/jvk4IzQB3lnpHIQFvh4
         JbOkMQM3QgeWU3iQF/65Nic7FtTIMxFnREo2pr7QcpQfsvdNsCDUSKbSBiR0MlCk5yRx
         0buwCmJKyIirOniGlTyRVo595s1FJEarGST+1OEgm1eXtTgzcVwH+G4Lwu2jaPV1zaao
         MpfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779323559; x=1779928359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=GzSjS7pXFONvmIVxUl6Pi7we9+L+uSqnJMptkrS2ayj9l5xwIprKGk0tGuwSt5Nd7S
         jyeSDWJqSVxPkAe+bI09V5MG1+d1UMWR5dj0ppsbn6UHWfZI3PMMsFD6LK78E74ttyoN
         qL2Z2J1vzDs/BDh7ylbDigCbnYdaaOJOinLGU0KFwonifB1kXp+Im3iuMdj35l7IqbSE
         nb5nMujH0Rprof/9IyIlvoq/b5PDuxXCTa0uAd+6aAvAuJ8kT9WAIVjLWVSNeYiD3BzP
         WEERrk+GHQYOMMLxD9CBCaL+u6+n07VidQYjvwvWR1nKg5WbjalxIu16qOfXAurzieyt
         ninQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323559; x=1779928359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=e/ogg4P/1nUZKFTH00PsxnlS2hw+upH/nTchKvorHg+6m2HQz2ulg2WREdwapY/nho
         xFnWyMfO0myXBY7ZApS0BHSlD5ueV4edQ5qGW9qhVLPW2hYm9QdGNHqStbhUAHZqnsnL
         b9KU+yDKTGYAe84UqBnRn4xvLfnE1BFSFCnbCyA/h0CEwxqwHYGw4hhT5wcGYT1+YDxG
         YYuyJKeldzgDu4kMqWRUYUMTEafz9ToXcxqYatcUY9CZ5JFMx3W+Ojqy6MlUEi8qzCDy
         pXw1uZJrpm3tFlqwq062EfA0fvkuXVI6EO19CM1gHvQvVPkNYn4j0YZbQOE8X+FSbx0b
         mqFg==
X-Forwarded-Encrypted: i=1; AFNElJ9AORZSTUbTDGVDkD8jf1vY94i8TOVBKN+na2ZcNuxHDUqGrsNaAtxYj+l9VyPkquFMHB+zZmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dxjum6+vZwxgwzmUKrE3XM6qDEf0SWiq2GhGiwxDV0inTg8o
	Hl2Ppew4jx8hAnmqHr6q/zUMMkZl9AaGXExvBbchgzOLBd7cdJfHBmQ7MVkv1cl8Jpd0H1nyN6s
	MZNltBfY5sUZmm7Mio1WcASv1flu7fcoTlK6AteU=
X-Gm-Gg: Acq92OEQhsdWmHxrY3w4Z4MTTLnGpxfKdWEGjn4HWcnwxewdqUjfPM5Koz8xyw2CxG7
	nH3oCIqpAygFvYesgN87TyDv+UwfwQhTnBvcdhvcdPsOOOx5pnvx8GxyXM6CCYR/00qLEdkfzD9
	tTiZxySw7OGGBnZYfbqh0DwUVtJCEoPOb1iaFFaOzRzDD/74i+E0CiEoqUKSM8cwJgkcSmY6Nv2
	34nc9r6WWVph9QU8a1u1lbvpX5zZUnQLXS3E3mt6u15UAhCd7mcfN0HjFhbFTYkbkWvw675uGvJ
	40UT6mkJAPMEGcjZZA38c0ODo4RltFmCBEsThXkF6Pw+fpI=
X-Received: by 2002:a05:690c:9c0c:b0:7b8:567e:d536 with SMTP id
 00721157ae682-7d2121b6483mr5682507b3.2.1779323559343; Wed, 20 May 2026
 17:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521001327.3729880-1-michael.bommarito@gmail.com> <20260520172609.3034337f@kernel.org>
In-Reply-To: <20260520172609.3034337f@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 20:32:28 -0400
X-Gm-Features: AVHnY4JjnwDy-U1Kl80IaCEyqbkQHgbt1kHT_KAMJQzF4mArDJ7BYqgCfg1ZDGQ
Message-ID: <CAJJ9bXy1xQsfRd_DBiFjTj6GjkDDVFU3w_5xjXvZmp8CXnkz5g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253414-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,davemloft.net:email]
X-Rspamd-Queue-Id: 39F9D59D4F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Please (tell your bot to) use the get_maintainer script.

It (and I) did, but I think this is because net/bluetooth/ matches net/, ri=
ght?

Here's what I see when I run it.  Is there a different set of args
that I should be using for netdev or net/bluetooth/ in particular?

Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH SUBSYSTEM)
Luiz Augusto von Dentz <luiz.dentz@gmail.com> (maintainer:BLUETOOTH SUBSYST=
EM)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)


Or did you mean because of Fixes:?  This dates back to original git
import commit, so I thought the practice is to skip a Fixes: tag

Thanks,
Mike

