Return-Path: <stable+bounces-222772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAduGKA+pmkZNAAAu9opvQ
	(envelope-from <stable+bounces-222772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:51:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EC1E7D44
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9985C306DF05
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93060373C1B;
	Tue,  3 Mar 2026 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LEyuP7vs"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3E364EA5;
	Tue,  3 Mar 2026 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502683; cv=none; b=j1Ir3+1ZiUnYwUhLE6wR7IM99/Ehv3jL3GRcpN06nj1CnE5VdXquwakR2Jqal5XCP8PTftD0ZnNk5fRo4cKqbZ7aJfJ5eAxS2Sp5UMjGlqc6K90EP5yi66yUZ/NSubJlYg2G86vf5OFzymCMiYQ4MddxMfnEv2uFD4PmES3HihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502683; c=relaxed/simple;
	bh=w6u5tzNGm6oO6Ef0a0mRW9jkXHiiIT7Ibl+2AC5mNK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktGeb7XkSBXeMy1iDjOHJV3UPPYyCeYnytzM8xxL4dAr9ZIKf0rLVRwkSz/hWBfFkCziwVTN+f68lfZe1qib5G7S9wyq3HMqvRr5cyn0jcdQadE0aL1wMU1WM2xZFVvlSrfyGm5F46Ubg3j52ybTgikzvNbsdxCQeUy251fj5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LEyuP7vs; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SU
	RCCLoh/qynqEThgmaRVFw3mAlxu9CdTM6/2KQ0iuk=; b=LEyuP7vsDVZxFrGhDj
	+I4/sSbzp65aAeklVW1tbTK5c1n5riTiiwO8fI9VTovc1B9qOOVivU62tTqKyKPp
	iG8SK//5VD1EuVwxtrA42yXDOxpeaJ5amdjeOCV75KYgqmnS2gneVURkNMnqavm6
	MTK0ZnVNoBWW1K5/ti/bIrnOk=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnhCODPqZp1ezIOw--.34317S2;
	Tue, 03 Mar 2026 09:51:00 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.12.y 0/2] Fix patch backport review
Date: Tue,  3 Mar 2026 09:50:45 +0800
Message-Id: <20260303015047.2014999-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnhCODPqZp1ezIOw--.34317S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRPpnmUUUUU
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QS0TmmmPoQVQgAA3B
X-Rspamd-Queue-Id: E01EC1E7D44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222772-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch series is to backport the fix d2907cbe9ea0
("arm64/fpsimd: signal: Fix restoration of SVE context")
to 6.12.y and the first patch
("arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state")
is its dependence.

Mark Rutland (2):
  arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
  arm64/fpsimd: signal: Fix restoration of SVE context

 arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

-- 
2.34.1


