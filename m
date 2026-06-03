Return-Path: <stable+bounces-260134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0wrDXhKIGp00QAAu9opvQ
	(envelope-from <stable+bounces-260134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A60639487
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:38:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gSKFgMzM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260134-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260134-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 290ED33444A7
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025E3D6CC4;
	Wed,  3 Jun 2026 15:14:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5F3D16F0
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499699; cv=none; b=on+sO26UP34rQ1U3EXzZX7JUS++fA7/4WXB7pa895bnB1aywnPLqRP2LGAUCZDNCmLs1BF7Od+XVaC4oUb0CHvLNKH4dmCdy5L5TlMT/utEGqwoTA0Ve0sW2gLdUXloNVTXz9eGbaoWypsX4eGFUpK4cWTMFVl1NHzTd/DKKxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499699; c=relaxed/simple;
	bh=nmGuDndhrJHC1tBBSRkUzs1VRlHE/0D1x/0iu8ZZ7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chPfIDN6/z/ZuAPuUHmzUun9Den4L7sAxw4l6DKQ18mdTV+GUH+ysovrH3ObPOfCgTlzxD1ps0ZnpEa4XuqZp5jg0XLN0VPZswH94mU2MU+EwC0IHlT/CnSXvHxxJnGGvVH6/xln/fgo9xSFW5h8rvbUklnoyFapNYzipg/QBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSKFgMzM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E131F00893;
	Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499698;
	bh=cGCh73sD5XhczmoBgU0Na/+4pkgXrZL7jqTEQPxZqG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSKFgMzMrq8fv6XKZWGMur+2ITTmPH4dymM4YUehvia/SwBMCnVkqhj0J08+lEv8N
	 kwxsMU0oRpXCsw88CugY9+48eaie8vVAQRng9rWKvGTRekdrNVZ1WB7YXeObKtEreF
	 KILSV7K+CKvpq0bbRy3McrufdN6TTVxwK5aMEzfw1nTrk4gVAqoqQY8zOEBwJQUWvy
	 ggi1xxUlorgQOzA8ZZYgcCZXFh46I9yHH9BIy/0FPihZJY+/yv+CNpdpDSbhtYgxC+
	 1SCzx/MNkYjZ+OiXzpVLXwY7yTWVvO7DuvjAdrM2F0HwemTyL5Xz+BO+9ir8O5FaUt
	 uGptWY36FIiyA==
From: Sasha Levin <sashal@kernel.org>
To: Li Wang <li.wang@windriver.com>
Cc: Sasha Levin <sashal@kernel.org>,
	mikhail.v.gavrilov@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Wed,  3 Jun 2026 11:14:24 -0400
Message-ID: <20260603151458.2404783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529050231.1849697-1-li.wang@windriver.com>
References: <20260529050231.1849697-1-li.wang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260134-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:li.wang@windriver.com,m:sashal@kernel.org,m:mikhail.v.gavrilov@gmail.com,m:stable@vger.kernel.org,m:mikhailvgavrilov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A60639487

Queued for 6.12.y, 6.6.y, and 6.1.y, thanks.

-- 
Thanks,
Sasha

