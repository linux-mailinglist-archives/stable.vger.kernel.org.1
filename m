Return-Path: <stable+bounces-233734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SINWBiWp1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC513B5D04
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C861300463C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA092E8B83;
	Wed,  8 Apr 2026 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4V9CbZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF1327BFA
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610132; cv=none; b=UhiveIci5cukKegFuis+9vXaRFSetl761cteMiua2wllsxST40L+qq1I3+mYL7qgY/0quFuaM553J6yGlrhGfxVFnJ4C4l3ZzDPqdD5rcwSL0f0AGEYoYKXS365PZ9GKZCA6zPHxVyN0Y6TihBreluNPabbs1oXP7gZ0h+nE1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610132; c=relaxed/simple;
	bh=YMq5jl9S5FHqzTDZpU/NsXOHgTj1f992nu/K6QEV5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8HwnIZypAIM33MNXxwij0w7llQZy0e9PLqfxiUw2egIh7DXS8oGiash5Y/NfR7rwuFxUWSWaBt2r9oE7Fn05as18Xwln99JGVtbA17BK91AD7PJQF0Q00ieqWmw8qnIaz19re19N2aBXQvZ05YYr1AOwTL7GLO4vePdv7B3GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4V9CbZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47413C116C6;
	Wed,  8 Apr 2026 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610132;
	bh=YMq5jl9S5FHqzTDZpU/NsXOHgTj1f992nu/K6QEV5Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4V9CbZ67DahPQtQuJyNcvAMIz1V+QQuBaPwZ/iqT5TtWr/Ue8ZyDklPYJ8BRs4IV
	 AGqpta0wkklMsGy/cet2VHIPPFTNX8pjhEQM+gKgCxSmZ+vkLVXjcf7Vfg24WdyHWn
	 /naG7RO8mPKCzx2oU8DOVtr5Ax9eMTgqrGrkQcgJUNxIRAXTGAhZ9l8WG/YeDmkJqk
	 zRj5iNjnRQ9FPM/UvasUQNq66q7m4Hg9lUts8c1hmsuaHTXJV+yGsge7giPZo0VR3v
	 DL8BC26otGrz+eD48H6gHKZBvBdMJyjcU4JrnNf0PN/7so3+ccne8sx8APMX0DmUG1
	 HAsIGq4ol2FjQ==
From: Sasha Levin <sashal@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Tue,  7 Apr 2026 21:02:10 -0400
Message-ID: <20260408010210.746205-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404212336.1808498-1-cengiz.can@canonical.com>
References: <20260404212336.1808498-1-cengiz.can@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233734-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC513B5D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 05, 2026 at 02:53:36AM +0530, Cengiz Can wrote:
> Fix this by moving the iov_len declaration to function scope and
> keeping the assignment after the bounds checks, matching the ordering
> in mainline.

Queued for 5.15, thanks.

-- Sasha

