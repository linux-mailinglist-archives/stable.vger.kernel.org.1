Return-Path: <stable+bounces-230423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FicGpTRxGmw4AQAu9opvQ
	(envelope-from <stable+bounces-230423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:26:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAF32FBFE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81030303E494
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29539B952;
	Thu, 26 Mar 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+uJC85q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF638C2A4;
	Thu, 26 Mar 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506235; cv=none; b=KJbjW5qGL49FrVlxivgaoDCLKbxWF5T1A+UfxZHk7v2W1WocNky7KQHUNykpcUhHJZxdWTt+3SChqJc5Q/+wl8S0rqvU33u2ERBZhj1pNtdQkATIKReNR/nimx4B9h/QnlscbLD2Nj8pRLzVzKYdHF8yfHabQJ8Dhv044Czx7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506235; c=relaxed/simple;
	bh=dMVkNZI0wrZB9u+j8RryzXGldt03j6+1zZalaSs4HPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StC1yyt/NKAh0TdsOd68gOtSeY0gwHIqj/1MSaX959hH9ubyC+0YWYnv8rESzxY5sJQh/rJv/i/PmdHefojZokUYsZNPOkjyA9tYjBKvkmP6S5U3rw/BNYK9FR+WT5TrN0NMOdnrmfK2fxBdwU16CqeFnxyzoO69osRNm/I7xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+uJC85q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C202FC19423;
	Thu, 26 Mar 2026 06:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774506234;
	bh=dMVkNZI0wrZB9u+j8RryzXGldt03j6+1zZalaSs4HPk=;
	h=From:To:Cc:Subject:Date:From;
	b=E+uJC85qyaMArvOTnBRnTOIzI4VauEoEOhqf0nStY+z5t/FFcqXGpbFx/AH74OfUS
	 G+bI4keNhe6LqqmZQkrSv15BhoDe/xX1e5AtPc2mXm3DjmWrC3KN3RbOd7k8X4v5ZH
	 WA+xmGusGmJm2UbPkk8tKUwiQbxtdnD3VVw0J1f3sRE5/lH5ucl9aorGg++Ze82Kxh
	 4dCVtUZ0kjLxImpsgbVn1T1kAcFSOJzgsDicafpg1ykPaU3GyllLfzQ/w4EJvAzwPe
	 aDJwGfpFiz8Ntl/JR2+nBCKSMZ0/um82NFCuVmw06tBGQRPfpjBcHGpPnSmg7sbUNa
	 qbRivVt6uLi0g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon: fix damon_call()-related leak and deadlock
Date: Wed, 25 Mar 2026 23:23:44 -0700
Message-ID: <20260326062347.88569-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230423-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECBAF32FBFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_SYSFS can leak memory due to improper handling of damon_call()
failure.  It can also cause a deadlock due to a race between
damon_call() and kdamond_fn() termination.  Fix those.

SeongJae Park (2):
  mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
  mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 41 ++++++++++-------------------------------
 mm/damon/sysfs.c      |  3 ++-
 3 files changed, 13 insertions(+), 32 deletions(-)


base-commit: 2b3fbc1796d335685d9b7a825c621914a1c97d1d
-- 
2.47.3

