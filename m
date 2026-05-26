Return-Path: <stable+bounces-254359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOA6LPCjFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 597195D6C5E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6326C30243B7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49C3FA5C2;
	Tue, 26 May 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO0fMXGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BC2E228D
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802704; cv=none; b=RfAVNil2DWwnQBvbxiYcuLQl/q8cLrRAY5Idoe2eaD2mdh7MCwCxT+hmaPSQwRq1MNRCAtnsbdgsyftfFRcbeqOrrwK+W0achbaXzOQiuZ8JamnNhd4rWVbV/KUFacFomjk0EAJANIUTMxLOEQfGLYMlnbieq4HuxS8ysfEyWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802704; c=relaxed/simple;
	bh=YFlw88qepEzSU4nWdETVI8eZp+lP7t4leSvf9DsyHAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVRuLBS5nAB69VuO41Id1crBFRbRrM0ar0TC4YQV6apsRfBKBpzUablTdsSWgm85iUf/qJ1nVgvncrjQXnbplHeWXyF6LhlsDaVBNv13c8/SRdUwqDWazyvHvnez5qsxJOgLhUIWpIw82IQIwRIf/POYZY+uuz8O0FVpccRUm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO0fMXGm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FC11F000E9;
	Tue, 26 May 2026 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802703;
	bh=Kbt1vq9pUIY2h+SWgk6IQBLzXpBvw4JyRBZ1v5FM+BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IO0fMXGmZPbER97LDjrlerK7HqES4V6j84McHbwTFejJM68y72kSmt1FdUgwr9nJF
	 pA+Ht0EohSRB/nhpZx50LsmBtmGwCZRAg5/lqvGmDT/vF818SQMrfFBjgaut3x3aKL
	 4TsY4Dx1lOYbCO9b0UM29yrlVfLwHAXwfHOS5d0ZTn4V4DvEXJ1KmOVqe+zTTmDKkX
	 kSZODCB7N/t6RYVltTVRE4b/Nw3jKKn28zW7TNrGFtOJ1EC/ptbPMZXlU9y4Cay6Kn
	 b4RMcOi57b62YlVI2vCybeGvb0Hz3JTwCL0DmJfQqVti5OBBTBFbEx10nXaWZN0fF3
	 RPQQluwv1qcXQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 5.10] Revert "s390/cio: Fix device lifecycle handling in css_alloc_subchannel()"
Date: Tue, 26 May 2026 09:38:13 -0400
Message-ID: <20260526140000.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahVuMv5SLjHVUbkt@decadent.org.uk>
References: <ahVuMv5SLjHVUbkt@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254359-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linux.ibm.com,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 597195D6C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:56:02AM +0200, Ben Hutchings wrote:
> The backported commit calls put_device() on the embedded struct
> device, which is now reached if css_sch_create_locks() fails, before
> it was initialised.  This effectively reverts upstream commit
> f65c75b0b9b5 for 5.10.

Queued for 5.10, thanks. I also queued matching reverts on 5.15 (of
b1d4e6fb24167) and 6.1 (of fd295a75d828c), since the same goto-err
path lands at the err: label before device_initialize() on those
branches too.

-- 
Thanks,
Sasha

