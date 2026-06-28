Return-Path: <stable+bounces-269537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ha6HThKQWqqnAkAu9opvQ
	(envelope-from <stable+bounces-269537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C32246D45A3
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=temperror ("DNS error when getting key") header.d=uniontech.com header.s=onoh2408 header.b="SOUc1Ug/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269537-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269537-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=temperror reason="query timed out" header.from=uniontech.com (policy=temperror);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E0D300CE57
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB06548EE;
	Sun, 28 Jun 2026 16:21:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60DBE63
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663719; cv=none; b=hZn4UVdCKgyBvn//9LLQFyDgA7R+g/ccgAYKlOfDVP/j86pomFyD4jrdFt7fwGlVU0AjWZOnr7wcz7fdXSvX2qJPkA5nbT7QAgG55lym8Zk+0fOoiGpjJkD3x8AbK2WoOADzQeXfcBeD5b2lsdtfy1zMz7utRkJxmHdQfE9LUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663719; c=relaxed/simple;
	bh=V9dPZVhSl1WmXIHqxsuOZCctoAvl0OPrfAf+tSMSN6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmJOfD5DqXlVHKF92az7cJYm/hxIqaIJGLXqkvRPmi7EGPky7FGHq6Uflx8uaubFD/sUvVKac0zg8RaxkUkWrIZvb2R93NX+gcwR3MsPajUaSIN1XN0ZU+WuWAntiCZgR/RWI5lsnVBOyvBoJD0wr/h+z3hR1Ad5V0+9gXu3jgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SOUc1Ug/; arc=none smtp.client-ip=18.169.211.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663602;
	bh=oRufOCmVA0Ihg9851JZMkHYDljX0/aDamz/obioBOSU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SOUc1Ug/VmnPFiiGl4n7mF6N4/3wubko1LdU7ATowQ3kJpBP7miTLdhjcPm6mm2Ax
	 Jx2HSHUtACBC/hWN84cmZwvuaT6EdZxQTkg8aVj8gW7J/ibYsn+oAYKXbO7gRaxIs0
	 /s6RymwqLNhiKEZkzamwMU53R8giefY+OSUtE3DI=
X-QQ-mid: esmtpgz10t1782663582tff009cf0
X-QQ-Originating-IP: 9tN6RBIUr66Pf4UUkXoMsMGXO1fKTr5edDXYCapZM3c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:19:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2034262738733494244
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/9] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Mon, 29 Jun 2026 00:19:25 +0800
Message-Id: <20260628161933.532572-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OPdvjVtisQSKdlJzx0CmbsfyZL/ai7OvFAyIwAmfmghADBU27JxvzLht
	OaOjqG2ivcskW4CfcWapwt+BmWguh0jTyZhorjHXUNQ1LIlRVBzJhXaSwdSx07Gi28C+kw5
	5pFh0HX5t/662eCg04/A392ZGQiHbJzBqhKkKikD3FLxsUqUczo/YJcDWt3dyAYvu0DVWdj
	yeN1NzHxN85/xlklgL2D4QRDGxbq8WIVhOosVIEcQrhWQjseGOg+OMo7PTk5/1c9bJNc2ai
	KdLGvcSSb/FJy8NfWmMCOoDRUyWRzCxG5sE8ue1h9xIfNnapXXYHpbRT2y1ObPWiHkaYJ49
	ES84Nwk3AoY3aP2xVuAHpsF7lVEr+gX/j/diSdDRKQzK+itW/ef6fa+pZa9jxWhYlZ7vV0+
	c1z6lgDrUo79qnmazoloCeAOGGXSnEz58EwKcV8uyqYKHt0RUcWXBaQqKz1sh8HkMQLIX5V
	KoZgm5sXkhJ5NELHxS8KYPIAwaNnbtBtFJKXPBtnvfGFd7tLJTK+3bCCwgztO3DXf2ps8M5
	KPXupLbnVIruDTzuvgJtRe8ytWlfvB4Wdp5FFSxxXsdXPJgZyGF+YHELL3dX74EJAv/y8V9
	83JciyD+4x0nhtppMq8pz+ddd0ucWtmaJSWGnKWrBHb0GyIMQikQFjCnyCwg53cvcz+9Oew
	T38YjPnBs7OyBWxiBeW88H2PVOacSPI3KK8VDvl4v9nhIus2FiAkUTItYMSDfgXWYqfA8ju
	JXERWnUmPpLcHjkeEGpbs4jEH1xWYBj/Eh+hk1x25lu5hdk5YREeClQS0nlPo9iYi8vrCUO
	flO33IqGZEu8JX5O1uGhonE6Fsj7vsjau1MGV1gTX1xXMe41ErKsTRac2sW9p5tyu+RRRQI
	z5hgz6ahVfxUYnKgqOdfuJQnqPNZwUS9OlD3DXA78LdBNLS24Dn9eFpW0lnfhGAOPy6BrHO
	y59g1eJ5880nSbuCLj3b0koYAKEQt/fK0puLjUXduW6JXkcVmKy9M28MN68OPj/x6xifZQc
	gJqxfS6QRtQxg2PMSMplfldFlryrP95Iuq7TjOUSup26o1/ocuKaq9L7mj8Bs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269537-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[uniontech.com:query timed out];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:benh@debian.org,m:brauner@kernel.org,m:foss+kernel@0leil.net,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:foss@0leil.net,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:?];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[uniontech.com:query timed out];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_DNSFAIL(0.00)[uniontech.com : query timed out];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	SURBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[uniontech.com:query timed out];
	TAGGED_RCPT(0.00)[stable,kernel];
	PRECEDENCE_BULK(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[113.57.152.160:query timed out,100.90.174.1:query timed out];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_TEMPFAIL(0.00)[uniontech.com:s=onoh2408];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:mid,uniontech.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C32246D45A3

Fixes CVE-2026-46242 eventpoll: fix ep_remove struct eventpoll / struct file UAF

base on link: https://lore.kernel.org/stable/20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de/

add commit ("file: add fput() cleanup helper") to fix build error in v6.6.y :
error: cleanup argument not a function
struct file *file __free(fput) = NULL;

add commit ("eventpoll: don't decrement ep refcount while still holding the ep mutex")
to fix context different in v6.1.y

Christian Brauner (8):
  file: add fput() cleanup helper
  eventpoll: use hlist_is_singular_node() in __ep_remove()
  eventpoll: split __ep_remove()
  eventpoll: kill __ep_remove()
  eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
  eventpoll: rename ep_remove_safe() back to ep_remove()
  eventpoll: move epi_fget() up
  eventpoll: fix ep_remove struct eventpoll / struct file UAF

Linus Torvalds (1):
  eventpoll: don't decrement ep refcount while still holding the ep
    mutex

 fs/eventpoll.c       | 152 +++++++++++++++++++++++--------------------
 include/linux/file.h |   2 +
 2 files changed, 85 insertions(+), 69 deletions(-)

-- 
2.30.2


