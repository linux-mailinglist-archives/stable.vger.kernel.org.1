Return-Path: <stable+bounces-230420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMfQFffKxGmA3wQAu9opvQ
	(envelope-from <stable+bounces-230420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:58:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 079CC32F8D4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECD44301DC16
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C53A0EBB;
	Thu, 26 Mar 2026 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf02eqKN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A63009F2
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504691; cv=none; b=aq2u7izoWD4Re+UsjrJq9FGR9wVhMaUFAEeKR+n0nIN7GAQh0Xy/nO/gjI9l5Q0UgRP9f716rjgPSjNRzay/wVCzN2PlYwQLkJpqE8JiV8LgBSsapwoLn2Ymbr6onxpnIsQQpkAoPIqGZ7CjStTGC4LTXka+3u5bqU8eeyOzo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504691; c=relaxed/simple;
	bh=wkCtGoeiLb2rfBjVCj0WVbn1wECQPqQ3lVJV8ZIDHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoHUAxZzjc63dbHau9vx30QwyyjS+jBCh7JWpi7taM+UcATCymZiZaJxmCTcR+XA1SFZzO+fImxcv267RO3nTAgHTmDSbFJSujnw1Ez7zna4Rnblk4wbjTLUYsFzwqGUPgDEOUzIy3E6tc0nYMWTjYsfV8C2SQvSOkHpaPcg7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf02eqKN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7412b07f22so777624a12.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774504689; x=1775109489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/WFOK/vH5ISCB0eof2793eZ54ZVXlOYGnEGW6kLrgQ=;
        b=Cf02eqKNdiPZfd4L6lEwKXQDZraOKDys1Wb8EpvPaDiSBihjTfDPUE2f+hEDvYlWbU
         j9jrPHH72OMj8XZ4Kz2Lc0IrjXVgwdaKk6th0lLw05xoEF0YjNNNES7bJ606Wu4ZfMU2
         v7Yk1qXT9+BMuE0binTTmevqWujnWbatsZfdlNQ7EebMxbiv0y/eR64SUMxLw51jM1KI
         E1eLePOf/33HE80pn/9LEvrFBotVhz9naBUWE+Z2aqt/uebZpG7OJIpGfmNpVZJIoJ7J
         0M/gQpmV6NtKAe0Y8FyHGAB1untwW5qstCA1dPlc4y0YHx4iqP9+YGqs26qjgxU/U7Ps
         7+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504689; x=1775109489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/WFOK/vH5ISCB0eof2793eZ54ZVXlOYGnEGW6kLrgQ=;
        b=egpe6ddmP1Q9hfG1YbA1wb/V0jiphCigtMUSu90KDPGRA7Jh5DxrlRoXd/T2mvmVvd
         hLhUMNuaRQRDc1LTTzECF5XdgAWCdjLvGn2vRbcNzN/sZmrWrLbA6LKgTCi0HIDFQtPZ
         89MIToZNcdCOeRAQwcto2MOAgXVuy69yZk+33kA8U+qdD0K78RxOjYmRgxusUBpHq7Bb
         fsFFAOK0Od2y0AptxEaSGZTmjuITEZHW69yfn0kBCdn3kgjP7gASd12/OP8e8poKeAah
         k4n1ADJ4v+EcQeccw4ILnkmWNnKqwmv1MNFw3sHYXuzSGv2ry1FbU5Qj+DXTTaMwCFos
         s37A==
X-Forwarded-Encrypted: i=1; AJvYcCUQq+JvWkZfd4iba4JcStvJOl9XFya6O6gRMAsA2P9tIBv9uswBg3yYGrCTGyCXn2zFrc58TfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aO4fq3ojeVBpZNmIMi0c0RVED9DBlkoZZq/BF/OnyVXQAqHl
	Q+mLV/blTnQjh2hUaPX1qGEom0L7F9fmI+JLyaw/lQSk1rUb/JPyicUM
X-Gm-Gg: ATEYQzyOv18E4ediujCroSN7zQDcX+XOd/O8SdusNC5xiICcrHlGO5TB4J0Bu9M4ZUE
	hYWOw64PxaUomMsSwQ5haeMGdgT2vAQemggyJcw26lo0HxmHHk+jn5QDoTqX6zaGUO7I+jOvLhn
	6m7GNTejrPL79NJwtoHck1BBjgY+TpgmMVb5nE/q4IUY9PVUYYeJocUsgHB/xPC5s4An3LyvOpa
	jONZJcVKgkqJl2vfkm1Q9CiNRnPPCF8utKrEpXp8iXFM4RiHF5GI4aH9wYuwKv5yoSQfWkP1LoI
	TsjrnqOqA5M6w2E7/DkHJrq0fXYFzfRpGIWHd7uBsMsFtFrA9UDXDjuhvWtA21/igmagskyu+ch
	RM17+FDSpUdkh/9HgxWu6OCV7uNUWwQOhtuQRQ8/TaxlKdeUryCGVrXjYRyjhdpd2BxzIAmPmDZ
	6CpeE0nb6nDoBIq/tajZwJ01g=
X-Received: by 2002:a05:6a21:6d8a:b0:39b:e810:f625 with SMTP id adf61e73a8af0-39c737ca6bdmr371571637.32.1774504689213;
        Wed, 25 Mar 2026 22:58:09 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:3001:9be6:4399:d681])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f28d6sm1243558a12.6.2026.03.25.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:58:08 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH net v3] xfrm: clear trailing padding in build_polexpire()
Date: Thu, 26 Mar 2026 14:58:00 +0900
Message-ID: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230420-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 079CC32F8D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
v3:
  - fix Fixes tag to cite the commit that introduced the bug
    (was: e3e5fc1698ae which fixed the related build_expire() function)
v2: https://lore.kernel.org/netdev/20260324013742.939533-1-yasuakitorimaru@gmail.com/
  - add Fixes tag and Cc stable (requested by Steffen Klassert)
v1: https://lore.kernel.org/netdev/20260321210421.2504711-1-yasuakitorimaru@gmail.com/

 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..ee31ef482be4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.50.1


