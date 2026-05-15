Return-Path: <stable+bounces-248917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAFmF8aJB2ol7gIAu9opvQ
	(envelope-from <stable+bounces-248917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E932E5579BF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4A6300EAA8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0AE37CD41;
	Fri, 15 May 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CzkCtcSm"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87426A1A4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878834; cv=none; b=SBGrGKffGfQnhGQCTs55KohUmTiNlljm+27DyUd6OvbI+CV22pU9/2UOMcYKltz2WuB45GnkLYJ/XBvjL9vgri8FdUDzjUuLRlEQmS4q+XkokvcCbgF0yrXFeTqkgKXtpK5p4Sgnsy7yvNG7UZ78S1ajLRAkpvnWp9bEEWWKndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878834; c=relaxed/simple;
	bh=gpQKDiaOL14iwBMgoM/+Ufx9UCW6DRp2kyHRMzJZlnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2e0qLP4CfyfwKhLQ8GVTis7uawjXbBq06JWU4xh/4x2ysG30XlTyRYkDe5bYUbYo/EVOjL6alZz3Hl2VAF44Y2ClqHarlKNPX1L97BPRXxKvoxBi62lDCQpGwQyReTd6kJ3vppzshtBBN/UkO0fm6lGMGbovIKc/jn3YCaJCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CzkCtcSm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gpQKDiaOL14iwBMgoM/+Ufx9UCW6DRp2kyHRMzJZlnI=; b=CzkCtcSmgGLbwZyu8nJMt3MPp2
	kI1WHkEpQehzjyLitL/W14ZT9YaxaziM9uSdsIy8ie+3f2ttDUiFuvX7SVy/QJ2v0yGmg848HGyCq
	T6DFvDte1Cj8EcPwRpVBmrauMHMBYddWhFZ2KS1CU702alknhrm7uMwDbovatFfGAmffMduSgeNEJ
	/+9ZEtuqueUa4mhI8svNC8E3EcxuBLZUU9EqBdVZL08+Oewk0pXr66PPhU4QDAQ+CEbD4QIcdBX35
	n1BrUVkK7iA2RnL5WmclUe7tT3WnVgaweAKs55fzuTWtO2ZGFgiupHKbXUpC7Cv6YT/dXFK7GShQX
	Ko0yPtRA==;
Received: from [187.90.172.56] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNzdo-000gyI-92; Fri, 15 May 2026 23:00:16 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Vijendar.Mukunda@amd.com,
	venkataprasad.potturu@amd.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	stable@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>,
	Umang Jain <uajain@igalia.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Melissa Wen <mwen@igalia.com>
Subject: [PATCH 7.0.y / 6.18.y / 6.12.y] Request for stable backport of sound quirk for Steam Deck
Date: Fri, 15 May 2026 17:49:56 -0300
Message-ID: <20260515205733.196362-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E932E5579BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,perex.cz,suse.com,vger.kernel.org,igalia.com,kernel.org,collabora.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248917-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gpiccoli@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.671];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:mid]
X-Rspamd-Action: no action

Hi Greg / Sasha (and everyone CCed here),

I'd like to please request the backport of the following commit
to the stable branches 7.0.y, 6.18.y and 6.12.y:

b0f6f4ac7d5d ("ASoC: amd: acp: Add DMI quirk for Valve Steam Deck OLED")

I've tried myself, build-tested and all of them are working fine. I am
including the backports I did for testing in this thread, in case you
prefer (but last time I recall the suggestion was to just ask the backport
providing the commit id, so here it is). The 6.12.y version has slight
adjustment due to context, but no difference in code, etc.

Let me know if you have any questions, and thanks in advance!
Cheers,


Guilherme

