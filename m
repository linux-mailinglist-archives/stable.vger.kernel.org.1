Return-Path: <stable+bounces-237670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCF+IFtw3WkgeQkAu9opvQ
	(envelope-from <stable+bounces-237670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:38:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5E3F3F20
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D4830949EE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE939E19C;
	Mon, 13 Apr 2026 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBlpVyFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4F36605A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119590; cv=none; b=B4eKTX0uKQDIvPN79bLZjojd0F6poh1yliz7WzlnIzWZWmYc5IdZxoF4ydbAJXE4sd96x6lweYqdCUVyx4KlBA4i+Tsl5N7jfgWF/Bx0pcdYFyhTjfoVxnzTzF9aD7vQZLirT27WMG3Nb73rwnaU46ydeQ5DGIWJAiEP8MfkS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119590; c=relaxed/simple;
	bh=BxHBBfTUbx/sXj0TWCylbsn74xG207GITZ0kWGylMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEnQQstZ31pZjcj2rpP65HWLYe45SM3UkHGpAyA4rOCC83OL5CRqmnqd9Nwk2Naee1Rpf1umjfdBF6J57EwseHb6OUhKVGDcbfnD5GUzAITC+3mLs/HRH0x/YhqAt8h2em7TTAq/5wetjHgcqQtLISUYl6gduS9zSMLsWyS3NUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBlpVyFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AFC2BCB4;
	Mon, 13 Apr 2026 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119590;
	bh=BxHBBfTUbx/sXj0TWCylbsn74xG207GITZ0kWGylMC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBlpVyFuOsZRAgpOFQN5Wnvu3XKuSWhFofnJGsTU6KWiywY7/HAH1Ol3rhL/6TAFN
	 69cKp5kWX3upSAbS2YypVBDYLsjRp0a90l9cwCeya4FiYHml12+fZxmcuZT1azAVNO
	 OHeaqbJM99OsXtZQPDUoRkYVB5CjJey9Wqmdv2qP2qoiq9o8pAPuYMN5QExT7zWbsn
	 mM0ai+n5KXQmEd2f+PgMWwXmVIqDscF/ztsPAiOvDP8pmVil+0HJgZM+66StyWsXmv
	 nWfLXljyEUHlSJAIkKYFqyV6vvyoobI07JFDL962WhozYpKE9C6oAXwftB8P5bl5rc
	 Jz+k5XyhN0uXw==
From: Sasha Levin <sashal@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10 427/491] media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
Date: Mon, 13 Apr 2026 18:33:08 -0400
Message-ID: <20260413223308.3760836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiDSCt44g9PYddX1bYw+OASwV=Ah2XOKmKmf0aeXSCKZ7i7EA@mail.gmail.com>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155835.015055819@linuxfoundation.org> <673ddf965a5af7b881e86cb2e22055d4fcbb2dfc.camel@decadent.org.uk> <CANiDSCt44g9PYddX1bYw+OASwV=Ah2XOKmKmf0aeXSCKZ7i7EA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237670-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 1AE5E3F3F20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 at 22:50, Ricardo Ribalda <ribalda@chromium.org> wrote:
> Agree with Ben here.
>
> if the reason for this patch is to get  "media: uvcvideo: Use
> heuristic to find stream entity" in 5.10 I can work on a backport that
> only adds this feature without GPIO it should be pretty easy.

Dropped all 5 uvcvideo patches from the 5.10 queue (move-guid-to-entity,
allow-extra-entities, implement-uvc_ext_gpio_unit, mark-invalid-entities,
use-heuristic-to-find-stream-entity).

An alternative backport without the GPIO code would be welcome, thanks.

