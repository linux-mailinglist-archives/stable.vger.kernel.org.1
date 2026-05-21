Return-Path: <stable+bounces-253551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMV6Dl0ID2rREQYAu9opvQ
	(envelope-from <stable+bounces-253551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B27035A5BF4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7659F306BBBD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5C3E5587;
	Thu, 21 May 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmofE2sK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE273E2741
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368762; cv=none; b=D18SV/pgmhHvlU/bl5/b5J5FrrAqYLlzJNXNPfGizq3SJh9JsTOsG1W8odPt5XwznMdCSLNC2OY1nAu5W9Sp0InFVsYPh5g2NvRb2mQ4KbCY1qFg2XMON8wFeJxxexU1a1GubcLzgXKwTJLU9rlOjdX1wZI/s3yKgd5gFZkz0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368762; c=relaxed/simple;
	bh=hqKiK8juCbX/72r301i/Aho+LcG34a9WwFp2trnFGUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yya3ZX1I1bUcCoj0IQta+Rmro/WT6MpHhMzMtpHKL1xygKlokYVcDMeGD5nh2sUdMy9TzZaJs32FXDIeQVyUDzrYTmPteiN4yI9SOaTuXILJrcTrOL9fuJyGF8XQ0gMNrRSBp4gWJj6pu1K7RiVsg4DDXbzfKXf4WGBz5OsaLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmofE2sK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so3115469b3a.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368761; x=1779973561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BA6oMBZIOnaYJGcA6PYPSFSAoPLy1EkjtV5+/qOxqk=;
        b=XmofE2sK9jS0l4e2Hu7o2ckyacrOa76T9z5cjA1D93kOVIvj6G2Y5QUT4Va0oGbPo1
         HQiOKNtV6nNmlBGr1da1lB27xT0lPhXo6c98VNxq0/VA+1tafS+ssIDfbrf+g1hFYfQH
         c8cirSgKYamaUorTK+u5vavJ9CX9IH2JLderYXKCNGNcGQJSFirx3xgoAwOI2YBti3tH
         EHL4hFLxOCWJwFMddUuK7YT8qq+iz0y6yTxlaNLSJSmiN20dYuOu2t3odgSUudvW8R52
         qL7jnqfLGUNJnMOceqlnQrcofBpEaYU3gew5Nx9ivl/gg38C0tLzmuhHwux05TwrofAW
         +fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368761; x=1779973561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BA6oMBZIOnaYJGcA6PYPSFSAoPLy1EkjtV5+/qOxqk=;
        b=PBXvjRdnSL6H7MiceW2iLj72xHqcawovkUBnVlecHaZcCEmRwVFbWRCEIHAow4w1c6
         ebqOnEHHu2VK/CYvX+n2W3E9jT2V2Awdz0gb5CsztA5e+XlfcCn8LkcpFYGZyS7fTn39
         pdMN5hHMIEnHbu9Oh5g97JCChfFp5sRW7W4pDbi4Xyx6hf38ORoLLvXA+qxv0U4X0gyY
         YoGdE6wi9x7F1E7aC/+S98PNKw+9p1NnRNri3SC2dYS0Bor6TmiQwJHsmSzQMm2Hxht7
         kr7f8K1hwOD502x4z98QOeHBo92+oOIY03G9F8UPFAbua+9OhAecgjZB71Y4F8fW0jKv
         vY+w==
X-Forwarded-Encrypted: i=1; AFNElJ/++B75VipeXxPj5+0vftYeexuOJevliZ3v/iJ31hNSf5K6yxav6d29kjhX106LKGuyxjlpwPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/g880r33tVbgocxZTP/K/KQywiaGdmrtPVWjtXkSfhYzVVY+
	MilnM1JrBTOP3egouxawMDetzV54fdwxdAtaz01DkHGnl0Sxt7sN1thMU+/dNw==
X-Gm-Gg: Acq92OHRyfmfkbxiJdALG7aHE27Xb86Yk5kV7gqahAC/nOU6gcBxYz2AuIDqYh5lg4d
	nZXMj1lqBt32in4YxpX5WUDfc+FJZlr3hOKrge16pdTENjnySJrU34+4DmFGxPATQGcbT0HXfgO
	oPSMsPtUE2Kxy9biXi2ZOkaZO+5E9XpwrJd1skEQr62izIuI0QGqhDNRDESu7IXzLwKL7XjucyE
	viQndUuY/HzMVOz3cKJ4bZgrh6FnpeF/zCZBBHqJUzzljtgXYLFlOnT5VMriloyGbksCcBCTyO4
	cqlnC0hlXtP+umfukkKyMIC9XplN3gHTbr3bqmz6tXqIbRIHVsqmuJHf/r00ZQlV791OXopNzkc
	99HuPFTt/3KJE9dQDdS/CHX77rz219yb8aTaWXK7t3Ahw4dzARr5dMABelDsUxyJrweC/W1m7cM
	IRWgQ+UymbbTRFMDmkHq5dIQR8RZleh1aGz654eIEcda5oN+tn
X-Received: by 2002:a05:6a00:4392:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-8414acdc882mr3105878b3a.13.1779368760666;
        Thu, 21 May 2026 06:06:00 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:00 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 0/2] ip6_vti: vti6_changelink and vti6_siocdevprivate netns fixes
Date: Thu, 21 May 2026 21:05:53 +0800
Message-Id: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253551-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: B27035A5BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3 -> v4

 - Update Fixes tag on both patches to commit 61220ab34948
   ("vti6: Enable namespace changing"). Xiao noted the old tag
   5e72ce3e3980 is not the introducing commit. dev_net(dev) and
   t->net first diverge when 61220ab34948 dropped
   NETIF_F_NETNS_LOCAL and made vti6 devices movable through
   IFLA_NET_NS_FD. Same Fixes shape Jakub took for the sibling
   fix 1d324c2f43f7.

 - 2/2 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) inside
   the non fallback SIOCCHGTUNNEL branch. The check at the top
   of the case is against dev_net(dev)->user_ns only. A caller
   in the migrated netns can pick params absent from self->net,
   the lookup returns NULL, t becomes self, and vti6_update()
   inserts the device into self->net's hash. v3 did not close
   that path.

1/2 carries forward Eric Dumazet's Reviewed-by. Only the Fixes
tag changes there. 2/2 changes the Fixes tag and adds the
ns_capable hunk.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

 net/ipv6/ip6_vti.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--
2.34.1

