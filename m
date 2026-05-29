Return-Path: <stable+bounces-256623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMC6Mx6KGWoJxggAu9opvQ
	(envelope-from <stable+bounces-256623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51D60261E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1572D30058C5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92A3E0C7A;
	Fri, 29 May 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaj0x1xt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868C3E1225;
	Fri, 29 May 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058651; cv=none; b=fg2QQDEd9MyX9/8lmwqfQTvmtPq+54JGRdTGs6u4Ih5b+St0sXPgF4kFgmX0CIm9KUYstxCWF4nQRasvgfwUjf6X0uzjKvkN1ZQC5w4ZLzCOJRyDOXMNl23whXsukh4bQSljFpH9jhb249w8oQh8LR4uvfGwlXqA+6oRaXoYLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058651; c=relaxed/simple;
	bh=5S9XX1w5jtOy6zLol9okjIWGMPqpVRkiJiA1cY2oHas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq+IIsdMY1jzPyZBpLKzXsbnPsFwaJD/P5r+BhnidlXJmKo+FLibkZTkTFrVd9ezpH4HKFTlxUCrGP7zClP67ZyUuGask/wlV9Po19GLQREzdF3PzMPE3V1SzOlRn2AVxQORQHi81EqsvvOrOwxd+qu8hdfwP+JU4pr6FJLgeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaj0x1xt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453241F0089F;
	Fri, 29 May 2026 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780058650;
	bh=5S9XX1w5jtOy6zLol9okjIWGMPqpVRkiJiA1cY2oHas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uaj0x1xtRu0GIRO8y1iUmHPQJh57sLUi1JoGcMpRqUI6wYKJjstOyM1MLLjH3Rruc
	 IT/bynl4mRuZvMfPlMQSeq5O+vzOhL0kELAE+gXXK6oeLnfCVoYmKDbrIWuMaaBBPi
	 l+TDNw/0yfXLSrTufv0Mv83XJOZ2XIc1Z5jXv8Cl1r9YIZd1wU29oWO42SRErONJ5n
	 4u7e4PJ+B4Jyl2+9uMTqCsSFEVAZJdKSI6thir1A6jxwSvJYSZT8pX5Y1iMSv9Lei9
	 e3bnb+qttJ5AQmOPxNgwC0GQ6lWQyJcBFRbGb6HleVURfrsE5CbW+LmuIJpXHTeyQ3
	 sQDgqn1IppB0w==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 7.0 284/461] net: shaper: reject handle IDs exceeding internal bit-width
Date: Fri, 29 May 2026 08:44:02 -0400
Message-ID: <20260529120000.shaper-rc-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d66f5c95-ebc0-4c53-9852-f73c790363f7@leemhuis.info>
References: <20260528194646.819809818@linuxfoundation.org> <20260528194655.415018028@linuxfoundation.org> <d66f5c95-ebc0-4c53-9852-f73c790363f7@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256623-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C51D60261E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 06:23:04AM +0200, Thorsten Leemhuis wrote:
> This causes a error for me when building ynl.
>
> It can be fixed by reverting this patch from the stable-rc queue or by
> applying fbf5df34a4dbcd ("tools: ynl: add scope qualifier for
> definitions") [v7.1-rc4] (preceding patch from the same patch series)

Thanks Thorsten. Dropped from the 7.0 and 6.18 queues.

--
Thanks,
Sasha

