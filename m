Return-Path: <stable+bounces-254677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D69DFJLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C375E9B64
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF03D30A32E7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1743B27DD;
	Wed, 27 May 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTbLdd3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090193B1ED7;
	Wed, 27 May 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911377; cv=none; b=c5UvmiP5D3cmqadikd9PScPSn7FQRATfOpFeJhheuYwxOduyARhrVulNKywK8FiiS4d8/mkLHOMD8mJpJmL2DZ77PkHWfH4FukGpp1rqFCEIDE5G4rav+Div0cgDNe6H8sMJs2jdyZv6Gv7UvhKSpxywMKYr7+lQbCaGoISAU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911377; c=relaxed/simple;
	bh=wz3F9nbji3zLvF5OwXry4/Geb/VB7sP97dNUVdHg9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHSZaudiGybu6p513QGDoreEXFofGRjfT97LtetgeZ4Van9IPY4jZBoT3bqe8LNkH0VmHHq2v5/xEC99ivLb3a7McGiT9yzQeAE3WK291iq28cU4+qhfe3vnBZ+O4NqAvKPntmmzWuGVMQWqB7Cs4S1xl/XWuxf1sa1lfZ6tnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTbLdd3V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F501F00A3E;
	Wed, 27 May 2026 19:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911375;
	bh=wz3F9nbji3zLvF5OwXry4/Geb/VB7sP97dNUVdHg9lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTbLdd3VPIidMkK9LL+BJ9hfdVtBq/QDPx5lJPxceMTlfNtqXsot/JamD76EWMFCp
	 LejZ6ldYOyk5E+lC0hkhDcE+j67hZAbCL6xNXNe6auyy9NRwPuYVFR+I+EEKJ6wgjM
	 bSlp6OnpYSku/fiMYClbMhnOoP4fCDJCu0aBsYB73f7W6z9DumwkIGmtNXLIVHS0lk
	 qbwLA9OK4hSWwdq20ovn9HsL7dftFhjivkRaA+1xYEKcXpyUK7LCBOz1AQ8R3rXuGt
	 kFDJOvzfdACLKntwZzp8IV8bWpwSBUCYrL6qpMdyo+tlG1rOyY/AdCSHH7HoMVCcMR
	 LGzYFOodm7w6g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fang Wang <32840572@qq.com>
Subject: Re: [PATCH 6.12.y] hwmon: (pmbus/core) Protect regulator operations with mutex
Date: Wed, 27 May 2026 15:49:09 -0400
Message-ID: <20260527-agent5-item017-pmbus@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_1E7EC9319D484C797CF4F159CAB1C3DB3706@qq.com>
References: <tencent_1E7EC9319D484C797CF4F159CAB1C3DB3706@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254677-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1C375E9B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [ Upstream commit 754bd2b4a084b90b5e7b630e1f423061a9b9b761 ]

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

