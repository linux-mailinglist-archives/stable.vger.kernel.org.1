Return-Path: <stable+bounces-270283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F2dgBxezRWp4EAsAu9opvQ
	(envelope-from <stable+bounces-270283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:38:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620A6F2A3F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WFVLZ4Lr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270283-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270283-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D131830234C8
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C125FA29;
	Thu,  2 Jul 2026 00:38:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF723EA84;
	Thu,  2 Jul 2026 00:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952722; cv=none; b=A6qDlaoSxDI0G7rBcv67De6ZzyXSHgjyN2SZm6Ev94Zu/cz3R0TkYtEYEfSciDT+2Avl9KkoLaxvs5vF9JeAsnJCEl0LuwpdTxAUFu0TTwums+abCSPW94P9p08Yzi9ahANrKp6V6kw5+LeQabx35BzrTxlL/g9AZk+Ja104S5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952722; c=relaxed/simple;
	bh=a6vCZh7qQ5ltEbHUkQzu66tNw9GjojCxbWkvzXLnnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STBUVjlKEQiZ5qIqPWdYSX7KtT6Jpl7EAG5eKkyyvNFrWKWbix/2JUXyo7odO2b3rWB79zITjz3AqmQ6hNvh4TX4LyLKGtk7VoEFEJF4lrMJToDU8KFn1rMWzL3zCuEowdvVw6GKsPVTfxs9hDLxx7rF4eYZQhMwKlXFW9ccp5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFVLZ4Lr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265D41F00A3D;
	Thu,  2 Jul 2026 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952720;
	bh=FirefrJifF+hN9FiUE8KWPoLfzeDTpIGvbAYAcbCzTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WFVLZ4Lrywfp5yJF2+YAwdE31CZckQ5r1f/Sqkn+Gc8pw2XQVwg0bxwtpzKcy+NbK
	 usr8Ch6ssEmvHGMbFI2tO6M0W4PBMs6w9QHHif041QNnPf1jIycs8zmTWDswqRRkDi
	 ZrCkS+a4E/UWtNtqSDd08vv0nb6CzGU+XLDVgvPpbik/AJ6+x5NVbVaXOqYax1KxZo
	 xIQ4+X1XaGfUxpdb4qc7yoRkplE1g1HbRrjGeXhKpGMah1lV4SD1LXEYlxpzKZ6/vf
	 ddt5Z17ijj1ujmuUPEx+sCvfF8qz4jz+JD9RO+Nrc/+Q9nI7TnjS6fp+53bApwh3gk
	 flx5YbTW8VR+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH 5.15.y] ext4: add bounds check for inline data length in ext4_read_inline_page
Date: Wed,  1 Jul 2026 20:38:25 -0400
Message-ID: <stable-reply-ext4-inline-515-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630163923.50039-2-ytohnuki@amazon.com>
References: <20260630163923.50039-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270283-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ytohnuki@amazon.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9620A6F2A3F

> Add a bounds check after computing len, returning -EFSCORRUPTED if the
> value exceeds PAGE_SIZE.
>
> The upstream commit replaced a BUG_ON(len > PAGE_SIZE) in
> ext4_read_inline_folio(). In 6.1 and earlier, the function is still named
> ext4_read_inline_page() and the BUG_ON was never present, so this patch
> adds the bounds check directly.

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha

