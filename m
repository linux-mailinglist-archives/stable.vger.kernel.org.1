Return-Path: <stable+bounces-245082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDpTLJb9AGrxPQEAu9opvQ
	(envelope-from <stable+bounces-245082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:50:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE250690C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB4E0300650F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013B33E360;
	Sun, 10 May 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="N9amWET3"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9633F58B
	for <stable@vger.kernel.org>; Sun, 10 May 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449811; cv=none; b=VZBCu1602QZsjrH9z5IJwte+L/tLpA+mkAhifUCnEAEBdALcrqc647ouqlcPBlDJfTHkzFIleuD+cBfhXH2k7x1tlxQzwUv0ljcnIO+3h8QD/yWa5lUTdhM9jvzGSERrnoEq0Yq0Nulsa5Rj9JI96Q5LdYeztBibu1/FrakosaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449811; c=relaxed/simple;
	bh=FhtprMcTcaqXXpodkY5LXWRut0JA3vN1zuPNnBo9GUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOU1IvnU8cHZvCqi4bziuQ614gdXKF3fr0ocaik5VaveSJYDqszOPnAPcsH7WCiHX7fzWHD0FItxALE1rw0pasO2FZXn26LiWzuZG6wWhznqqjfxQGw/m6Ok75sSARHvxelE5EwnLlVpw8JlZIyZ890tepFG/XNuhPv6wHLhi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=N9amWET3; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778449721;
	bh=FhtprMcTcaqXXpodkY5LXWRut0JA3vN1zuPNnBo9GUY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=N9amWET3WRnz7npHi6Z8RTnvmRU3uF2praW9vwtQOJl7ly/mItJnR/Y6nBHM0v21x
	 OS0tUmPrB/o0Bq+FqtjQ730rseN/EnF13k07q6BPcAsDHie0kR+rzzhKnI9sr13qLv
	 DDB08J1fTbXMeZ5GJjjLaFM8jjjoGGGUhPgTYN1g=
X-QQ-mid: zesmtpip4t1778449715t6856393a
X-QQ-Originating-IP: fbBDhnjA+Nbu/AQvLON5YgzpSDMDQgNfWfBvP5OUc8Q=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 05:48:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6667188648079557454
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: jaltman@auristor.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Backport RXRPC for 6.1.y from 6.2
Date: Mon, 11 May 2026 05:47:17 +0800
Message-Id: <20260510214717.5125-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <DA1B1E18-0F4E-4399-84AE-75EFD88713DE@auristor.com>
References: <DA1B1E18-0F4E-4399-84AE-75EFD88713DE@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mp4IayM4AU5skytIf35aHtEOpfUg0VXGBmguL/PA2fb6BfIYHK8MaWLS
	aWPIzPQe3/LfsDxHkXLTGZXxtJM4PmuZ5caq0Bizl+yAuLkD2vffMdOl2l/udojnltCYdyU
	cn8rZYWRDgIhLcdf4n7yQ4sPeYgU0q5RiSnJhtuC/MMmETNIfgn7mYYL4b3XXO+rYWynVFA
	BDi712LcXOv5duulAd4b1XuJDVV6b7hqsjwHAvztelueNrIgwb8yKhsF/PIgyqOpIu4Q4ql
	dlTqeErydw2bPCEAF7tTtT+0d3Oy+X3hcNkqTsXK6oDrN4Or0vmX2lV3C9VJrHEQ2TelhQW
	bhh3gbvQ3sM5d+0HPekwq1837ZV4n0b+Z9euKRBq84LtR4VaudAyXl1j8FAMpLOmBIvtCgo
	gsiiQXVcL6qWOAFbvmo5R8D6ZmhS1ywh0gQmNDmFT0BuSJRTdHr84uTBqVGOW/o/XN1SIXx
	GoZmR9DFwj7vttw3VYAcNFGAIPMw8KRcNH5Zj/YdxXx1E2AmNrjglBIiTvcz+Cohqv10LHy
	z52/ODd7dZ4ci3xr++qg+Zhdr9BhhaQ+EqByA9+EVFy4zWQbjDWrBf7Syz9ArstxskEq0dm
	WoaVAEANjLoLrHE375EmUucSgeQCpBD9sKfY/wQM7QeTzhfh90GgjIlQF6L15Eiyg9207Lv
	k8wcibGVHv1r+TnzTmCOkuoU/IHUBx0lCED0kA51uPPHreF7CaHP7DvkGG6gk3MiITyNgyA
	RvUk3M6XSs5mVVvZ5RIrPCaPNv5kf3oCggrwQomE4uKqMixptwlhawKOZOqsX1Ni5k4r7xN
	38MqAIrMfJVBf/qtccJgU3cbTz6jDRRtHMtfVYjPG0GY0Ma6eLBoymTnLObR3uszahU3mlN
	gAoy7f2ZyPgi2FfeOHjmAdgPXJmH7QxiEq+PjLWnWkpkPlXu7T+sF4XBfmvi2+ldLTzCO2T
	muesbyua6FMiOO+0KS1t6yTim/q1fHhCMKTem0xlSo6P2TKQ1y80Ugp6eSdwewjGsu2L02f
	4cfJ5+VncUpNbi+Fb6SDqbqeQK9WgnA/yqe6SSWw3/s5Z0XHX+RVGmx1auMgSzbER6H/m6d
	NMi+kBJ4hR8FORzU6YSXmsiYOXLW/LOrA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C1EE250690C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245082-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

FYI, I am bisecting v6.1.73(poc fail) and v6.1.70(poc ok).
Also, I checked 5.15.206, it is strange but vulnerable...
I use --force-rxrpc and not compile CONFIG_INET_ESP to avoid gone to esp path.

BRs
Wentao Guan

