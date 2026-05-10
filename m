Return-Path: <stable+bounces-245046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id htTlK8S0AGo9LwEAu9opvQ
	(envelope-from <stable+bounces-245046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:39:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7085505249
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9639300A776
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A02364055;
	Sun, 10 May 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UCshBZsY"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8C32BF41
	for <stable@vger.kernel.org>; Sun, 10 May 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431168; cv=none; b=j8KZVqYnc9wIq4Ss8jkwa+cv24PLBZRwj6g18sJiIEfLSFYNS7/jfSfjMxIO73BWvesFv+WKd0vP030ec4RiQE1a7Dfngkx807oCGeAHPY2JBSEz/UMUotStR1SueI0v3acXkZh6NNGvuIyDIFnQ7+OWvr7rUV0ShijGY1IeACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431168; c=relaxed/simple;
	bh=Odty7YJ7b8vxlfHfe6mj1Jd6dYMYqN2XdIVdOrFCJRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWJm6jhXgH3WRLk7nnHbnLFePwyJUNJXE4qMykKQC2qMaW9+E8f/KFulMtbusbEHyW0+2imkgwRb8jgtAIVtAfJ4LhlwvyQyGfnu/oCY0CNo4uYhUWENquOLz78B43In5sAoaxcvL7Sqq+VUojpYhkE9BktTlHN6of+Q1uzC7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UCshBZsY; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778431080;
	bh=sDFKyKYY+B11j/EB5MJf6LGn3swwcPl26xUwyvP3NuA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UCshBZsYkAmeQQVyPK/6BMXyOV981YrqS3EkDZbpRDXBVQaY5kwyRjwSXmhiPUnv7
	 cilXoIxEIeNiT6UmTEdSiVc8Roa6b0/3cGu+pu2/iMS039UmVSehRsHV63Cdu5xyEu
	 Y24gg6OG3Iyr6SREZfaGp89PQpNoaArsNix8e3dA=
X-QQ-mid: zesmtpip4t1778431074tf8966068
X-QQ-Originating-IP: mIYvrhuV/dc5buPZWjvupFVUtSMIqNRG0y4cS1J8ZUc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 00:37:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7177602246040012836
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	horms@kernel.org,
	jaltman@auristor.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Re: Backport RXRPC for 6.1.y from 6.2
Date: Mon, 11 May 2026 00:36:36 +0800
Message-Id: <20260510163636.260801-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051040-primary-anyway-9a79@gregkh>
References: <2026051040-primary-anyway-9a79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MVxUJtUPrfeCHs5AHRSUHqdBkyH5vrgM1dolChAMZTlaDassCsre2mwi
	oG8uVKVOXhURypnS+FYlkul757P+16usxhho281JtoZzzmJRHuFji73+vqqlxAR3GaBLFdR
	LpQCOZKAyiib7HfpZx/GeSSp8GZXaHWbW4HYjtmA+F3wmAJgqaE3U+bGs3ZUGrJAaFLouLE
	rKznfrWb4leRzfKcW8uFOV7zFLcNLMvMFh9ZNm1Sr1Z8w3BYMQt2dEaQjYs5x+S2C2VfAHQ
	4PQxvnr/9Ojck1SonoSF7G6ULOEnqfZA44Lt235E0EgkLZswSFql7PhZOr2AXpzNTA6mkSB
	HyaALuyjw4hW9yb60wktKvB/wosbPOcq0c9M1RY8uIflm6CGQE5upIOB6tizy4e3Jk/XBYy
	PDo6jblE8+nbQudZbwoEm1JdmGONR4dlAJ8E9O9wDxGno1UPRq58zfIdrHJCyXNMj2Xw6CJ
	1r2cNpIc9x7QjtrSxuOBsL5kbrCVv2o/tUuoDig/pB1v8CQnDWGnBhKWOkJQi+5HPVWYmRh
	FZ2PTwseiB6mF/Q6Y2G31DzaTEOI330XiZCggbD2I1WRZPMHRRlhMhDQJwPoiTNLK3TOhtG
	A4mVtLBD6LovRHhuAEY9Ncwp5uTpdF+5qOusmU5RuAtxhYW4kqlX/rqmqL6rtUQcJiVHt9x
	bImFDg53EB0sF/fjS6nn4qy+Mc1VEdH0gmRfdfz+TJQ+Q11GxLp3aNWCgx7TXXsEAF34Jl+
	CU6D9rqNG9PYKZ/WUnDvc5szCDU+Vlh8zodn5TiQtZVI1vdEBJw6yATBzXL/D+Y2aIAyGwy
	ypj2qvIdWdv7XGfEnTRYeX3Cbk/OGRYVqd1aC3IFe0Nfx2nwb+Wf9Gwd5JlctwUVvu+ZOAw
	Tbu1wlKvoo+R4yWbYiXLtrImaPqVqU1dN9EojfpN2RuHDN0SX4gALDykadm69D8GaL6kyXC
	28nUnDNBzQlxFULtcses49iXV1eRnIfMWrJLIYgNGtdwacdNSIhfokXzlOGJDXuZc566BFB
	2zuliiV2RcDVoqedoxqsQs2376tMVzoDycXDQEYg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: A7085505249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245046-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Why is this needed?  If you want this, please provide a working set of
> patches properly submitted, along with the reasoning why you just don't
> move to a newer kernel version.  And do you really use the AFS
> filesystem in a 6.1.y kernel tree?  If so, why?

FYI, there are bugfixes such as ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")
affect the 6.1.y kernel, and the final goal is clean apply fixes for CVE-2026-43500 such as
("rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present") in maillist.

> move to a newer kernel version.  And do you really use the AFS
> filesystem in a 6.1.y kernel tree?  If so, why?
NO, just affected by compiled kernel which enabled the config:(,
we are preparing fix such as disable AFS and AF_RXRPC or fix it...

BRs
Wentao Guan

