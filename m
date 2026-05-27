Return-Path: <stable+bounces-254676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MAZNPtKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F45E9AD8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F43F306C52D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F93B1EE4;
	Wed, 27 May 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxNi8mWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60B3B1EC8;
	Wed, 27 May 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911376; cv=none; b=FwwnGzJuqcFlMIk7ESy7ve5h3q74+SRQHA3r8pa/FURf4mnawj23KX15LQEr8eB8vFx8exfpcvaSXat7C7N/KSivt9oQCtVKQx176s+xlVC04DfUz3x3N9v5/9cnpbEvqo+weccEPURmG6zcBYtaZRqhMj0FlmkLc3hiTB0rd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911376; c=relaxed/simple;
	bh=uPdnk+9Xag3ocKyOILnUoy4oYUYH63qCVU1qhqO2mXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boCQkedrLuHmRgzMpGax7txvT6fXK97bEp3OIKpUh9WPPIxv0jxOAgvnqLqDqD8VgkT1fVAlyDaiMECerO8puN/83GvoCigYsJfSezPJtaCNXpkk3MXeh76DGApfh2gWVj1rlKFBhdiUUzALy3jUhmt3oIE00Yd4LtxYUS8BD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxNi8mWK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2811F00A3F;
	Wed, 27 May 2026 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911374;
	bh=uPdnk+9Xag3ocKyOILnUoy4oYUYH63qCVU1qhqO2mXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxNi8mWKaZIOw4w4TOuFUyC9k3m503pW2G5k1ViImeJ45N5fs55frZpRcWxPAdrI/
	 U+HaYVL3dUHRvj1uHDu0DQdOVudyjWfzN6n/0EOflcWucvH1LVxK7mlaLC2sDX0S2n
	 SUK7gzrBErlwzPwZYaipPmWmTB5XYtkhl7RQ/P2oJsyu//v7r2PkKjETZKSLqMwxYj
	 MJ3eo5gIlPAxMtdkzWpOJmXR+oX/2H1a0n8wQhlhyq/oUvsd5ubIQdVw0j5BX3bpKH
	 qOriPubDI9odZXYZU4WxVKLRCJ3rAiWd6fsCe2GzIGxnFnm+gWSPPBx2erMKRR3BGF
	 mLnBY33gmyB2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	w15303746062@163.com
Cc: Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
Date: Wed, 27 May 2026 15:49:08 -0400
Message-ID: <20260527-agent5-item016-vkms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254676-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linuxfoundation.org,163.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 895F45E9AD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This series backports the generic vblank timer infrastructure and
> converts the vkms driver to use it, fixing an ABBA deadlock.

All five patches queued for 6.18.y per Maarten's ack. Thanks for the
v2 with the proper Signed-off-by chain.

--
Thanks,
Sasha

