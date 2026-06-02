Return-Path: <stable+bounces-259877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hi6CHxQgH2rihAAAu9opvQ
	(envelope-from <stable+bounces-259877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4116310D2
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UVbU4IXt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259877-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259877-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96FA304E31D
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E27397B1C;
	Tue,  2 Jun 2026 18:21:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EF396B84;
	Tue,  2 Jun 2026 18:21:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424516; cv=none; b=aeMD6sA+hH3kzLRjzntg/HTu9NWg9Nj3DaTz3QiQijmOYHJaL58wm1p+ZbDkp6q+23ezKUpOWfWd9/22gPwXMQU+gxx3H4tR//kfbBC1Vy6qTUosUJK4sqLMOLjgWW7UmohB1hVdkJRpjUna/1ngmF11CHrAJVls89OIT9cVXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424516; c=relaxed/simple;
	bh=VqcC3FAALlNFchhDu1XHRiw/utxjMFlHh0rIuwzVyMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Eg5S66/XNjCX0suCllWhM7b8x5+1WkUjVgK76rGunaQAGI72mRZCNXVZ0yLK28qHPuQ52xddeBcwOjx6UtGUOz9+JzpgbYjW+EZH4mcCu5WKtsZw6TJNHhFWSbQyFQIWkmn/By0q5ps5KoTVqFvc69Y/sYjIUVdeqHNvVy1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVbU4IXt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB81F00899;
	Tue,  2 Jun 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424514;
	bh=VqcC3FAALlNFchhDu1XHRiw/utxjMFlHh0rIuwzVyMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVbU4IXtXkkczzi/aIwB0rnXter1VBUqzgt5fcAJ8lSc67kRfYbFOLVoKncKI+D2r
	 Sg2LS9dpM/SrUGOVv62rCHcQIC7cN0cNcevwoz7d4maqSTMcT1PLy18dh/7+vFbL8H
	 ayNzYjvNz/amND+xlcxGXTNZdtpcsWfCBwTXG/SqOMLtVXNp5Ln7AL/6Hh4GfHhkdq
	 PEY3km+lH7Ftaje7csaadQ17wNRgNerVQFnVR6J2Hj5fA7jsNil5rLERz86S3pleLc
	 nTJvJGoTjasCyPygcQNB061olLfN89SWBmAK8Jm4cMBmdMTdC8mLhdrmYWRDhtphHT
	 pQfwHsyuAY9cw==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5.15.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Tue,  2 Jun 2026 14:21:30 -0400
Message-ID: <20260602180900.idxd-release-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601052412.72913-1-jetlan9@163.com>
References: <20260601052412.72913-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-259877-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jetlan9@163.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:vinicius.gomes@intel.com,m:dave.jiang@intel.com,m:vkoul@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4116310D2

On Mon, Jun 01, 2026 at 01:24:12PM +0800, Wenshan Lan wrote:
> [PATCH 5.15.y] dmaengine: idxd: Fix not releasing workqueue on .release()

Now applied to 5.15.y as dd377066acf6a4 (backport of upstream
3d33de353b1f).

Thanks,
Sasha

