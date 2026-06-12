Return-Path: <stable+bounces-262891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyoCBNHLK2qwFAQAu9opvQ
	(envelope-from <stable+bounces-262891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:05:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F326780C5
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:05:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EeS4WZsP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262891-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262891-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3E334A7648
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BE3932CA;
	Fri, 12 Jun 2026 09:00:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C9384CE6
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:00:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254810; cv=none; b=ZIvyp2HS56BhpTpMsGs6eGulsLN/nAUC9EdMZQFHm7HOw9ScDmoenhX3E4UaGvJQA/x4i/BBdiwjCo3i0pX7LS3W9MLd6FMLR5el6fKBGyUcgBc5RpXDcf424SXjB75j0P6i02V3+k5x+9z1pAqsCZF5x6NHQELdeHns+tomPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254810; c=relaxed/simple;
	bh=rGPF2wY1k3BAkSjSLw+YNJLWFe1bXipRPIKGXN0WZ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGmRkFl55rZ/hK9jH1JOQjOyR/KsGQOTEIVL7hPn7/1FSTFTvepxMl/qodkXGE7XUY6Ptf2mJXGjPOGiuzePk8yJlGjQegoeA3rIN04wA7eVY3dHnuMCg9yhIxL2Naq4+N50q4tGWx2tuOAW54ZJ7qva0tj7EWrATVi6+My+Eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeS4WZsP; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8424b6792efso365375b3a.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254808; x=1781859608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/VmWPOMWT1TArRP1kFHQW8HKFH/Pq0Or4cO7drGpLY=;
        b=EeS4WZsPB+lcGaG/RfMQKAJBgXkkaBpP5Wv2uE7LKIhozcKzgQwgUQVB9spKtMwpY3
         LqlrFQ/MsPoysw1uHhJz+DkGV1Wb/QO5Y3N4L3Pt7KxrpDcNSDL1OWCU3zfTWe16OGiV
         uQIzZbendtF3MSdNXs4A2IE8U3S/tjbqKi1RP+LisZWNJwqyCnwc8P7+sJAPdiJOWTA8
         ycDjiyn3k4aQgLjPsP7Yj4IgypfJUgCxMXuwbB+H8FHa4GePnTNOmhzfy4XGyCphf62e
         2didOQ+GSiGGDvBn5olNDjUN7U03MzM/wdCY2m0/wDlKcmll/7OrtXwjmzuuIuodWTX6
         WSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254808; x=1781859608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/VmWPOMWT1TArRP1kFHQW8HKFH/Pq0Or4cO7drGpLY=;
        b=YgJ8G3cZWem7eT/DViq1TIxF9aeYqfBW5mnnO9hs6p0zgng4OK2VsprLCGjNs3+A20
         DCeqps6tr4l+AVvD6a79xgyto4zczhxE+x13HGXRTttD+A9rvz8MDWVPwcKvTBCgX8Qu
         Ki+5QmuAZlfr4HrGEd3M+KtnB2ABMSoPz3H5iNQsIOoPcYyhgSo0gOdAT+4s1Lqh/KLi
         GrNmruB2bg0rS938t30+oeD1g5vhsBoVWyTEPNClbFOiMAQNVy+NAU0TN4//WsTT2iof
         n8BsWFvlKXdX0mvcy4j4mw95nVnnv5OireaWT0Qpo8Z7pA0Ro/vf6V8a3zflgNjIwdaM
         WSYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9k5iuVNFF8rzbsSdHQUnxwDQSNRTenov292aKOTV/slH+AQHI92y3ednVczH8lUvrEnM4JsjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPi5/2YD5j1a/utCJSLuPd82uQWm5IBNZq4A6nJRl0iU7HTin
	TDGOWo2jbL8A/so+50Sfq1fAsTB7clBaN01/EFWxznqh7Gl6sfHqoAlC
X-Gm-Gg: Acq92OHqOJLW913Wl0wvlEExQy0rtNPXD5pZHpGZRPl2MtRLFM/HjL2M2X2hBy+C3xL
	sT+1ERxl2L98UlvTx9agDzVhRS7SNOD0O/+Xbz0sE6TE1WhH4aBk+AbZUfbXmsilw6b4xxnB+pW
	jJeg4HMIppnb4dEAXEk/6GRzeNCMoeE3oEynsBxIScz2v1biPdXVLin5s1aFGRW8VBz1aWDyStu
	Ts546+ZrJp4UFRC/Zhp/bhjq45/ay63HM129bq+IwRna07GSeO+jWc5uQIpEHIZn5abnLmKl3M1
	z6EA9nTTJ3TDxOMD4UJx39RK1ZYDEYXevwda0EHWhRpsiCcNSeK1meGGMk9K5vc7wsYyamXHDB7
	24y1o8JceAq+smyF6VdsUvEvbev/tQWq5JL440mdDA5krywqZtSdNM+cwZ3zBG/CgaUtlWE18x7
	eVX1N7OtqnHMTymJ3umeqG2/8z6Qbdoexok9XdvUJs2Se7ZYGq
X-Received: by 2002:a05:6a00:84a:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8434cadf0famr2119790b3a.1.1781254808571;
        Fri, 12 Jun 2026 02:00:08 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:08 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 6/7] net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:40 +0800
Message-Id: <20260612085941.3158249-7-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-262891-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,google.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72F326780C5

vti6_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate vti6_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index d871cab6938d..ab94b3a4ba9c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1046,6 +1046,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
-- 
2.34.1


