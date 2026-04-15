Return-Path: <stable+bounces-238123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FYbHRqJ32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43549404723
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A87343083800
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89452283FC8;
	Wed, 15 Apr 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ruxyuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF33275B15
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257254; cv=none; b=tLtaq5+zikhufrHHbTWUsLY6IlhxDXuFmJoG0khw+Nh+LruDXSu4kheE4ywcCejPEax/TSeVoafBY28jCFuI5RlXybEq1/OBj2HqWJ8/hN1oJ+99TS5T9ZSeXlkQfFoY9Dpnn7A48vt+ZvXdnfkk4X20Rw0+MsbLGTk4VPIv5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257254; c=relaxed/simple;
	bh=h/JAMz+pWYbWO/YYjEnWTofcM5KgzO2ABxZFuq7IAt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dli2eEKmtWM1XY2QpGprgwJuJH6sNRBsiSVQUD0B+2tYtXlMUCKdUYCl2BL68Klt8505NUT4BDQ8LA4XOb393j/WQgT/khrkpX6og6pAFjFaeFFFDVa3pl89YyRLCUt1KXxxmGfrHk2S/N1V1BAOLyr17Mep4updzZ3RZuYHYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ruxyuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8087EC19424;
	Wed, 15 Apr 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257254;
	bh=h/JAMz+pWYbWO/YYjEnWTofcM5KgzO2ABxZFuq7IAt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9ruxyuF5X4bcHkJnklm7BWIAUr8U6LYm0Aovnl2NnJy9sTZfDxI0hvyiHTXSwmz/
	 EckQ3bFnZdqIFyH8mJJMgVr+PnXN+6et3vUa+cQfOzjc3jCQlakyNc10IOch/m8OXQ
	 RgYo1nHh+gkGaJWcN98yowevZ9XCvzCwJ8mGobfdK2qVaABMREEMKTB4anvvJssgRy
	 JuoGoR3pCHmu6onGVnIghEbPsvem119Sd7TgVp3RH/I+AWU8ROAR53A/IthEVRCBPo
	 O6WKv/5xxPW1AhU43uz1tBqjK2/ZiDRY2kcQcVKTvcGXidR49O7b05AhNmwSAU8SzO
	 Ce4uveLK+dSvw==
From: Sasha Levin <sashal@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 5.10 010/491] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Wed, 15 Apr 2026 08:47:32 -0400
Message-ID: <20260415124100.fsl-mc-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALbr=LaxfRiP8totK7_K_ErH8EbYcBxTTZ5dYaXZeo2UCVNSMQ@mail.gmail.com>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155819.436681483@linuxfoundation.org> <CALbr=LaxfRiP8totK7_K_ErH8EbYcBxTTZ5dYaXZeo2UCVNSMQ@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238123-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43549404723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This patch still needs its prerequisite commit 5688f212e98a ("fsl-mc:
> Use driver_set_override() instead of open-coding") to be queued
> for the 5.10.y and 5.15.y trees.

Dropped from the 5.10 queue along with its dependency:
  - "bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions"

Thanks.

