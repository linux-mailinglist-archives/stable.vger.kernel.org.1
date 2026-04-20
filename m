Return-Path: <stable+bounces-238869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA26Eq4t5mliswEAu9opvQ
	(envelope-from <stable+bounces-238869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9D42C335
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 383D831F8A05
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46F3AA4E2;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq8rVKFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4C3A380B;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691283; cv=none; b=VonF7YG5CVOrjo/TL4qdc+W/qsrgYU338YwFvT8fLSxZgppOsx9ZMLzBtDnjq1Qlyt/eY+Kl2iOuI3jS5Y7WZdTgKxBMx2YA7r08rLS4kM6r71DByYiz3ymmjCOKYW73xOg20sl9zsIrL6+HI384uKxFmwBxMzjQ3R0LUGuFLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691283; c=relaxed/simple;
	bh=41VcOyArA7xsWl1GqSDSToqyXwVMNgmiVNHeMPkBMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL5X4atsLkkiapy9WSx9Mwjiwl6D3yw4xTtNdnhnZXD6uEcFhMIo7zQtexGC60DoStnM04ZcOg+01agYHySaAj1+BOismoY8eB1cQUmDLcUKGWX7/itzx33q0EkOpip61AFXZkJTDidDsdziYFoU6CiysSbQWiPf4co6v+HlOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq8rVKFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655FC2BCB6;
	Mon, 20 Apr 2026 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691282;
	bh=41VcOyArA7xsWl1GqSDSToqyXwVMNgmiVNHeMPkBMjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vq8rVKFKDBuK1lXXtvRN5lhV2M7Sb1cQoHqFfCDfURn98MMVEpQvj07pI5hSX32Pe
	 04eSgT7nWHhaadsDaD44jQ/rdYcl9trDCqOqOqPP3ZrNzv3NKPVmMMYeqBAnPZl/Qg
	 ayago+GZg9VHDphRdnMfwbJrKieAxJluqlbVkygNQnHLoIet8Ym8s6Qz7XvXgKUab0
	 0+zGL5nmCKMza7vBbep+OayBJFpJnD1rIpQx0QJKHnkXPqCJ7eogyqapgRqZRjsddb
	 Dv6zeSE6tFPhjDGCg+6sD31VucCdURV3c/v/j7qvays48Trh79TTi+ebTky9rW6J4K
	 Ed6VZssWiquqw==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5.10] ACPI: property: Constify stubs for CONFIG_ACPI=n case
Date: Mon, 20 Apr 2026 09:21:03 -0400
Message-ID: <20260420-stable-reply-acpi-property-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418230704.4178547-1-nathan@kernel.org>
References: <20260418230704.4178547-1-nathan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238869-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16B9D42C335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026, Nathan Chancellor wrote:
> Backport of 5c1a72a0fbe1 ("ACPI: property: Constify stubs for
> CONFIG_ACPI=n case") to 5.10.y.

Queued for 5.10, thanks.

--
Thanks,
Sasha

