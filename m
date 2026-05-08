Return-Path: <stable+bounces-244827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN0VIchR/mntpAAAu9opvQ
	(envelope-from <stable+bounces-244827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79C4FBCDB
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D733056FFD
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD3423162;
	Fri,  8 May 2026 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyeV1EnC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654242314F;
	Fri,  8 May 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274714; cv=none; b=a3IR+eGnQJd6MIFQO8W4k/7s8YxQ3RMu1abUtiYfOuRaJDpywbY+zjXVBJ6WHEDCcSOdwnfO4ampZ9Ce937VQyHvQ8vJcqn9GRiMHd2vXqbcLTpFCgj9GQkWPrSBr19yF7HdfFbd2C8IGo6oBFf41ZBb6N+/davY1XcpxyaPXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274714; c=relaxed/simple;
	bh=Wm1oFhjlDHVMbWPEmGFvlTH0XsXVNjxx5xMjj8qlXUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLly3sNDDnKVTbaM6B746ma5CP8sL2roh+Vem0z0gFyT30fkBxGFk1Mz6lYYzlMuj9unwVfZBmWWJX9bwB0bXUA8ahozYmjsvgRnmhCK7FKE7r4xOxL/eJFqtmxYPNOMOOZ2/tW+BR/VKTVHGP5nCSXLRGk3oM5O1hSWBXZ+EjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyeV1EnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E699C2BCB0;
	Fri,  8 May 2026 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274714;
	bh=Wm1oFhjlDHVMbWPEmGFvlTH0XsXVNjxx5xMjj8qlXUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyeV1EnClOq6luiXdvvic554mXNaVkpH3fu2P3PVuoKrluyKZFRajvjs3v0B8nnxe
	 GEJoJxEd/ml6VGZCBcPac3MaZrwIlxNV7S8t6fLanrtt8o1bjt0783CewWfeJbMJmq
	 ly0/bfV5i1LYICz0DZp7Q38J0kpTLKU+BoTJq/wVvQYGA63cZozh3sfRtl/zURyBJj
	 UBebsJg49iS8Mg9qcZxz1Xb3+1OeteNvQwxZ3X8QGq2UnJSDlVxHXYq0RdhR+qKScI
	 O/nBEtIb5tqFHiN7Wgc2mMsNFmCkDBYiuZkwSt1M0mRgr9AInp5Wpt1Ngi9KdHGqP5
	 ezT1/9JQV+ZGw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	senozhatsky@chromium.org,
	sfrench@samba.org,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	Li hongliang <1468888505@139.com>
Subject: Re: [PATCH 5.15.y] ksmbd: do not expire session on binding failure
Date: Fri,  8 May 2026 17:11:41 -0400
Message-ID: <0bf77c8c295b5e9a-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507085758.3514265-1-1468888505@139.com>
References: <20260507085758.3514265-1-1468888505@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C79C4FBCDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244827-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,chromium.org,samba.org,gmail.com,microsoft.com,139.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Subject: [PATCH 5.15.y] ksmbd: do not expire session on binding failure
>
> commit 9bbb19d21ded7d78645506f20d8c44895e3d0fb9 upstream.

Now queued for 5.15, thanks.

--
Thanks,
Sasha

