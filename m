Return-Path: <stable+bounces-211380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPPZOWZ4c2kfwAAAu9opvQ
	(envelope-from <stable+bounces-211380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:32:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518176479
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751BB301F9EF
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDD3033D8;
	Fri, 23 Jan 2026 13:32:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D3231845;
	Fri, 23 Jan 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175135; cv=none; b=sYMTShnnGxcDB2Z7M3RYc7uVaeI7SYnNmnH8J33F+RL50qckTd76OLxJ3yEJZRI4QCDD0Gjj7AKQ7eQKW/Yv4CseEEFoHMxgcBiA7MSW6zB8tad0lYQLdcc3Q/IBc6LnDeiBAZTTzZgNF+vVCHdHF6xHUMv/g9HO5uJRxXjNMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175135; c=relaxed/simple;
	bh=SiM3uxLQ5h9r5hcCVwtNueZxfMFrefAwq6fiJ4CUqEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+mXRMFMBntzhYW4ID69k4eW6Crqwp9gHXUaJPxQy0nyKvYscZUiVBRtWReyiyu+2CY3XcR7p0qJZ8fjosIouMWlyzNFw5hp58M21RtGRfX6xuychPoxSzvNRW72i4QMQj0FmZ/W5qcUgWXqRK8gBM2p45SG2XJ+Yt0lHR+fxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0F21476;
	Fri, 23 Jan 2026 05:32:06 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21603F632;
	Fri, 23 Jan 2026 05:32:10 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/2] tools: Fix bitfield failure and minor polish
Date: Fri, 23 Jan 2026 13:32:02 +0000
Message-Id: <20260123-perf_fix_bitfield-h-v2-0-cc8f8752607c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJ4c2kC/x2MWwqAIBAAryL7nWBrRnWViOix5kJYaEQQ3j3pc
 2BmXogUmCJ04oVAN0c+fAYsBCxu8htJXjMDKqxViVqeFOxo+RlnvizTvkonVVO1Cq0xizaQyzN
 QNv5rP6T0AUEoD5xlAAAA
X-Change-ID: 20260123-perf_fix_bitfield-h-084902f55c35
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 coresight@lists.linaro.org, Leo Yan <leo.yan@arm.com>, 
 Thomas Voegtle <tv@lio96.de>, Greg KH <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769175130; l=703;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SiM3uxLQ5h9r5hcCVwtNueZxfMFrefAwq6fiJ4CUqEo=;
 b=aKKOgY4XRNEGNCMYAuvc4mHGYgjSBEAledqxQTLgoGA9C2wS5HYKdSZ3ug5wP+RipFigSJOXW
 hns9SbTvCLLBEBb4bjWN3YZBcgNf2wUHoT3Ag1nyqTBJK7Xc9pV/0q8
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211380-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6518176479
X-Rspamd-Action: no action

The first patch fixes an build failure issued caused by bitfield on the
stable kernel, the second patch is a minor polish to avoid including
redundant headers.

Verified for Arm64 perf building.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      tools: Fix bitfield dependency failure
      perf: Remove redundant kernel.h include

 tools/include/linux/bitfield.h      | 1 +
 tools/perf/arch/arm64/util/header.c | 1 -
 tools/perf/util/cs-etm.c            | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
---
base-commit: 800af362d68945e589f73cda429d04bfe4287feb
change-id: 20260123-perf_fix_bitfield-h-084902f55c35

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


