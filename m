Return-Path: <stable+bounces-256625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJaFCiSKGWoJxggAu9opvQ
	(envelope-from <stable+bounces-256625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF360262C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5432130237CD
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7453E168A;
	Fri, 29 May 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igmpuS9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA43E168D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058653; cv=none; b=OemChoPXOPiOrCo7p9FBXwePoddaunOdb0cOuLQm5zcjWRq7aDE030OXlPdPC+y0aYcFBaBd645IsGxi+kRCuCRhblpTmlP6C9Op59ZIr67jVVBkOUuQU66WaVEe4jTpvdenQOuBfb4nBIDRdH1sSBV9xvx1J63MBfauYvY7dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058653; c=relaxed/simple;
	bh=kFvK3zoH8/akFtySGPE2F/3wvsMPTophGUvOpC2AG2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8kwFEnljXdOGbiGfOpjWjZ9PLLyflYofsygdv+Ye6m1EKTxZC080YxSlq9BN3gHahJXKyE4nE12NY7DySxfXbLtDe1Vgl4lHgZe87FBi7kMKhrJ5KJNLPfuNIW45Eu92jVPoJuxgPuq3X2idgBMwzq9hCouRphiLES200hgIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igmpuS9P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE41F00898;
	Fri, 29 May 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780058652;
	bh=Xx02OTG1Q8VD0JUnxwMovXybTBNPnkvSgTFuOocD2mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igmpuS9PWiNhOD+X9PMSF6dr/qbQd6jJFRjTQzXt4hXdI8wNPUvlxjf0rqwXv95vj
	 4ZxZPbUXXwVNDTE2RWLR9CEVNsSGBYjmebOUdkDduCiNkf9dcLh6oxRHmd8fY3E/9K
	 hPBy6ZPjcjbUUtV7yYl66B6cDMt8bVMWQs5HB1L+1NmHo7IvDoq/CFFbmcHLoN0nk1
	 ux0puyBJAl33WnOG22hY4R2lwO9DxHcDi0KjizzQlf3ZxLwiQ2weZHv4BzmUrRuD2y
	 42qwOYFPpMHswhCWhZl8zvc1lxrogPyXSTQsZ9SQC/Vxk8X4oUWFbFNn+5PZ4qZn2k
	 CweFkNDYRIXeg==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	gus@collabora.com,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) incompatible pointer types passing 'u32 (*)[4]' (aka 'unsigned int...
Date: Fri, 29 May 2026 08:44:04 -0400
Message-ID: <20260529120000.armffa-rc-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178001274428.7152.372661732178917650@330cfa3079ca>
References: <178001274428.7152.372661732178917650@330cfa3079ca>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256625-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 98DF360262C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:59:04PM -0000, KernelCI bot wrote:
> /tmp/kci/linux/drivers/firmware/arm_ffa/driver.c:381:14: error: incompatible pointer types passing 'u32 (*)[4]' (aka 'unsigned int (*)[4]') to parameter of type 'uuid_t *' [-Werror,-Wincompatible-pointer-types]
>   381 |                         uuid_copy(&buf->uuid, &uuid_regs.uuid);

Thanks for the report. In 6.12 struct ffa_partition_info.uuid is still
'u32 uuid[4]', not uuid_t, so uuid_copy(&buf->uuid, ...) fails to
compile. The conversion prerequisite b7c9f32614f17 ("firmware: arm_ffa:
Replace UUID buffer to standard UUID format") isn't in 6.12. Dropped the
offending patch from the 6.12 queue along with its dependency:
  - "firmware: arm_ffa: fix big-endian support in __ffa_partition_info_get_regs"

--
Thanks,
Sasha

