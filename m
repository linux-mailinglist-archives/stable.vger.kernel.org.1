Return-Path: <stable+bounces-268626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id woUGCChdPWqP1wgAu9opvQ
	(envelope-from <stable+bounces-268626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F516C791D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:53:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XI3qwmWD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268626-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268626-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2186330148CE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B223E325;
	Thu, 25 Jun 2026 16:53:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58F30D414
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:53:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406432; cv=none; b=VAz1n6VlWodTjKdgMNY6jVgVj0JBkl1Fa+95G1Rl4Rwp8kG0rjN679rhROVmUkuxNTLd16D4ZZbyiir7sWV5f38b1EozFgUBK59BLqIGdY5jRmpHBFBRmzgb7dI+0EXqW95StRY3oZrrlO3YGMu8siJt0DlGFBHwKtNBJuK3DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406432; c=relaxed/simple;
	bh=qEn9gVSp5Kgwj8A4/u9VXGBX0jAA+TWVYQEr9RU8X/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq381ilxl4VG1HXAW7LQc6lYiky6HAWL/Z6Sk0aUB2ZfjKkAHL0O0ERSjwGvexiYaS2eoh6brFsAcLo++Esr+N06jwAlgZQC5MSmkgJqBVSPnC1TW6qqN1n7fqRX3R564vb4P5ksyA6/MyYUBE3lEcvp8zcsjt9+Yulpjq6MwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI3qwmWD; arc=none smtp.client-ip=209.85.167.50
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad4f1cf3cdso1075484e87.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406429; x=1783011229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YFP9t0BEfAxf8MyUpEA7sGVEY2aYzoYOSU9Q/SX1T4=;
        b=XI3qwmWDORFpqpw6Tvi4GStaysY+2aETDgyxkY1lPJD6EZ9jFMQUl87lk1i0c3coiG
         YKAfl5XZlViO6Onpf93nYVd+l9WmXiNB9dNuEbepmTbhxu7a+847A3noBLfid6UmKxpA
         QalJp1/CTta6f4+8vIUb4h39FIXUZs2QxZ6ovHcBzwwZ1KzrkCT1yT5AGRD+AVigPPQN
         6aiYe9HaS16+fBj8MCk80rjvJvU24luqYkPx0J4J5rhvclNqSU1iJR98hlC8zBy7rf6l
         z9d6PChmt/LNcr2YPRI44CsI2REKXiXuJQvLJe+7ggkL4/Ye35/U9ACSVeyieUAOM2tc
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406429; x=1783011229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YFP9t0BEfAxf8MyUpEA7sGVEY2aYzoYOSU9Q/SX1T4=;
        b=NV/YpE/WacTYTZYhYWPQZtsV8bxFcOPezQwjAqyFYL9ZyVvqWwhOrBP4rCQmixFShG
         X4LitqgdBGyuzWOi3C/3KS4zeK9HdTtctesfpPfwVqOJVZej1AgaLdMLAf5VYJUciWug
         d1xzyPkjFNKqywUYeV0hzzssKHn1FkAvJGkkTzCT5l6KmjHw5FdPLH3Voi+WjdJnUeMJ
         NFzQRepKBdwdw7X/d7VDCWN4sxmNv+dAnYLezWiNdbsJSBdEB79hkC6aebCfhcyaEPF1
         gJU9SMNH2mMLlFS9mbnoog0e6Rk/CMz/Hs4fk8GnaRxkFydZipyoc9mFHuvFGAVIxlLH
         zOAA==
X-Gm-Message-State: AOJu0YzvtSSojNVn7IZcivypd2TYiquRcX/GgIzOUGWLpQkiLrEj3Nsj
	py9VSNpc10IkZh74L34DV/n7WYbFOI662oFqC4+8I0qo2UK1X/sLkfq1+bu0acAlFSFfrw==
X-Gm-Gg: AfdE7ckK1+YCMwgGqS4nW0lSkKxwURb/G6Oxuqs5GGtazYx4v25wemxrWSVaMgOLkfM
	5vsAy1l6wSTYTLISIWWo7M3kX6Md9TL6qkbW+f/DRVMxJ6VoOniNx8W1LaYaF+52IAwGxo85C54
	TLf2gA1B/nhT8ojNepwSsy6B79bUMLNGrtcHp74rY1Po2PcliObooVbBeYZc3GVNuy5Pw7SuUxx
	2C1hmhYzpcMO1BLgBLHpmvmCHccVMTVctsNBYM7p65SVAOsn7CBl1txInEu5pSiYGkcyy3Rannp
	uZPZgFzeOSXaC9g48+mPTWdYNV+JDW+fKfJ4MczntRr0yrxYOA36A/r8n3MeDP3X5ekPqSwSgmr
	304SlSlCTUXf7w6SipAguKQD2i40oHfo/CwTnaBYUJAng6KijBU+o98Gr/v+OBNAp8KAObeEdfC
	7nA1iaxAUBk0xq/cv4jnWTLow4sbkISSu21+qiroI=
X-Received: by 2002:a05:6512:6090:b0:5aa:4a98:bdb0 with SMTP id 2adb3069b0e04-5aea1e1f0b7mr1018255e87.4.1782406428458;
        Thu, 25 Jun 2026 09:53:48 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:47 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <amartyniuk@astralinux.ru>
Subject: [PATCH 5.15/6.1/6.6 0/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 19:53:31 +0300
Message-ID: <20260625165335.162311-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268626-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:amartyniuk@astralinux.ru,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[astralinux.ru:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13F516C791D

From: Alexander Martyniuk <amartyniuk@astralinux.ru>

Fixes CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

Link: https://lore.kernel.org/linux-cve-announce/2026062404-CVE-2026-53070-0031@gregkh/

Petr Machata (1):
  net: ipv6: Make udp_tunnel6_xmit_skb() void

Xin Long (1):
  sctp: disable BH before calling udp_tunnel_xmit_skb()

 include/net/udp_tunnel.h  |  2 +-
 net/ipv6/ip6_udp_tunnel.c |  3 +--
 net/sctp/ipv6.c           |  9 ++++++---
 net/sctp/protocol.c       |  2 ++
 net/tipc/udp_media.c      | 10 +++++-----
 5 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0


