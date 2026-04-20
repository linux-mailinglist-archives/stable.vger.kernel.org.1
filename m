Return-Path: <stable+bounces-238870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHC+FLMt5mliswEAu9opvQ
	(envelope-from <stable+bounces-238870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA742C345
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E3E3344C57
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B573A3E98;
	Mon, 20 Apr 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrjuQrpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05163A380B;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691284; cv=none; b=Gi8hAgqgskCzlQ7siC9ropv7uOVzsnC6Evm2Tu5TV+oGnOlWQt2R27kVEYY5ENrvSQvOHOljwv0Lw/NJZ07kCxFoXRFrquXmB2S8JP9hDdKT9TVzpZrWOGKjC2P/xWNEpZ92n6OTn6TLhIhP6VJhkIWQ0/KM8vo/H40Y+tvEyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691284; c=relaxed/simple;
	bh=ljvyhzT6Nvtw50hqX+gA305HATW22mofXgjTthntcB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oThhgOt2xtTukYwIYKMQZnP1XKkosslIiip/E+zq5PdcIHUeU9NCqOc8tkDo15RQCVyJ5Guj6DfLdarDkM/kOOdTtXJ0+CNV6HDBBDMOaD9jk+ZKQ7KadylJjQ6HYknks4Oo+/nl03nise/X9bzEkVhLnI7X9IOtno/8qYKevhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrjuQrpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBDC2BCB6;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691283;
	bh=ljvyhzT6Nvtw50hqX+gA305HATW22mofXgjTthntcB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrjuQrpFL4qk1iVWHaZ6gqw77psk84SfFXOTJupaMaVy3w6jhYXuGsNkKMzfe+5UU
	 Jw+t6I3I5c9XW/fNeiegrqvkCA/xwP8CmHUNjQAK16L1cJK5I4ntnNGtZOCju+29Ef
	 z+19KYoIDFMaX+e7DR65RLDOH2qUF5Q/QPSGTF+Qm7kAB/clDz+ptMV4whoIF93XHR
	 SKti8P1FImLHLgT3XpGIxFEZCs/A6+z+MYvvxjxBegz91+pAs2865FWFbrUs03IpH0
	 5pA7t1OMII3dy7nVqEJhIDUff6EHLugO7hTX0QGRmOlV3FwKD+E933KbXufW4nCojO
	 SmAeXMAwnJpMg==
From: Sasha Levin <sashal@kernel.org>
To: Fang Wang <32840572@qq.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: common: st_sensors: Fix use of uninitialize device structs
Date: Mon, 20 Apr 2026 09:21:04 -0400
Message-ID: <20260420-stable-reply-iio-st-sensors-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_B4E5A4D17E67F7C7096F7BF8A4C701223008@qq.com>
References: <tencent_B4E5A4D17E67F7C7096F7BF8A4C701223008@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238870-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08CA742C345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026, Fang Wang wrote:
> Backport of 9f92e93e257b ("iio: common: st_sensors: Fix use of
> uninitialize device structs") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha

