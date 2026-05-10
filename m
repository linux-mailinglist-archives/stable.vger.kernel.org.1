Return-Path: <stable+bounces-245069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HxKC7TpAGqMOQEAu9opvQ
	(envelope-from <stable+bounces-245069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5D50636E
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFAD1300B47F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A82331A78;
	Sun, 10 May 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Zdm6y2We"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FD30E847
	for <stable@vger.kernel.org>; Sun, 10 May 2026 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444696; cv=none; b=q1fgGX4dyEPPnimKHpVTdB20l4Q61SzW/0Tizpd/MX3tnWM0i0p+9dnaUw347dDNkQUMM0S0BUBSud+DTjGust0z7+3cFfYsloSkt3lS3PzDIGBoNWVcEiargYSZbwgHTp2wyK7XyZZ3WcqeEwi9Z/aF4DyyJIT4GydoCUKtT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444696; c=relaxed/simple;
	bh=HHPyy8gWfc3MIyaTviOF87uiZ/gllamOt7l8DIpr8Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMRrEZ2MFALbM38+ehBVknhaIP8LGX+C+WBFQPhK2xsGbRC3IvxxMQTXEmfEBkj93mV/g88KcOwJv9TatJ8+p3TPTtICRlC+4ru9DXfBc+CQBKZz1paDSWZmurXTQgB6ZNfbAoYxHQlkdzQd24OryHPu8FH2DAvtr3GNhux1amc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Zdm6y2We; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778444603;
	bh=WxB5EV3VjSNTdo9nfYZQjhTTa5Rx1j+zvDIjTaw0ZEM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Zdm6y2WeJMl6KdzLUZVH+UJ1wuMHZYKcOJoIifPR+uQ3lDSGuhl7nJSe7MKtuvYBx
	 belKCvTQl5e7BUgvNtz9nfKZT6hdWXv2VRvWOW8caHpkPHMYnXFmrRx1Eb8sCD/v1G
	 S66WMvErPivU5EglZHReZ40vsGjOpEHrIFu5T0+4=
X-QQ-mid: zesmtpip2t1778444594tbbb54886
X-QQ-Originating-IP: Qde/A4x5Qku0aukZg2oY+E4P5UkCcVXmUmCB8l6VSek=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 04:23:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6019607602237302897
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
Date: Mon, 11 May 2026 04:21:56 +0800
Message-Id: <20260510202156.273826-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <379c4dcb-11ac-43fc-a539-6cb5de9eef3a@auristor.com>
References: <379c4dcb-11ac-43fc-a539-6cb5de9eef3a@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OKFKhW5NWvU8fr3CISuTBG+6u4ymfMuQevZu0QaKhfJe+g3i4EUferU5
	H9l+xYST0tul1Txt8xqFSATyasWshHfvkiTjviSn14wrFkg6PTcNg2qI9vhi2bVYs4E4ehM
	0svwr/J73BMOfIaxTQ+lYZcooaZeF7N2La5d3LOhBe8Acs4eVO5c7Wc7OjBm0WnvYo+jf8X
	Lsw3nnlsHPe6Uw9RBfTAopjDLEyCwG3ejLDwh/xF1HB/QTSDr/7tWBImlT+ZrK0/Z49xyjC
	ZhVE+thqqEiPos4SCkq6wDEV8VbffAm7dE2kRS5lq2TkhFs2D+kx0WYTpmNL6ucPn21A9gX
	yuqL3JxL+zNHjQ90Vx1aJq+uWXj/jaEZEtpyyU6IsfBOna3xfa7hYp4tBpO2iibDJizcKsK
	kzFW5dYoN9YlGJlCYswNXC0zb3GSST/BLefj+wJ/ITh5xwm/7ZOh73msSkOd5HbqR6KLvRA
	fdLibU5TM7SCbzkgRoE4xFqUf6UIGWNGiUTaayFOjgU0J3JTbO0PXPEyr5KGEwFAMpdIgmU
	Rf01eGHfNoTfAa3gFs90PRqz3EDd5KBQZBCleb9cbBNq234WNY7eZPJl1JJLojfX0MMpKvV
	k4/Nbn9NG8vlJprKq7Uh9iNumTNl40dN0ZRn80xM8ZzxK2RYOf1BSBwfqE72W0/3uGomqbG
	f8Up/+G4tjsQ/0uB4IjIokT9IkLJsboQtcHFup2U5B84ykGmIuFYk8kRRhEdrSb8HGSxEhF
	ZZnLJxc3DzpBHTESFTiPIsK/qm3vjibtVmwWWeEg5MbDJBPAlzIwL5Lnym8ybOnfpzCtPLH
	HMKShpPIw/FNS9NxSbqWdTKrUO0PAA/d+bwDfIeE9Sbycl2buJd8lsL6E+nBuSiXkl8oWER
	IhBZkW8AQQ3/bZzV4k1Jqo1R+kiiK/6AaTj8OypZUO27bDqHnbXw0zjjjiNOyy4e30Pi3sK
	bFrxbsapizgdFE3xk/55x8YjjTOExNwPzFIW1bNwHHbRfyxtYPWjAkf/07IOO7MJXmuvygZ
	KxNlDAkenQTPWcPcBZzKVOEfbrOKRsUkLSAcDpElj0IJJGL1FZvCWGW/8OfyaHFeiHC6dN3
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 25F5D50636E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245069-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Back porting many years of RXRPC feature changes to fix this 
> vulnerability if present
> feels like the wrong thing to do.   If the vulnerability is present, we 
I confirmed v6.1.70 is vulnerable with the poc, v6.1.172 not ok, I am doing
some bisects to figure out which version vulnerable or just fix poc.
FYI,[PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
... Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
is in v5.3-rc7...:(, so it will affect 5.10.y 5.15.y 6.1.y than someone says >6.5 ver:(.
> can try to find a

> branch specific fix.
I am glad to see it:). 

BRs
Wentao Guan

