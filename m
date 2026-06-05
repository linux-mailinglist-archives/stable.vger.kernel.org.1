Return-Path: <stable+bounces-260803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e4ZdD/cmI2r/jQEAu9opvQ
	(envelope-from <stable+bounces-260803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C664B06A
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XsbAz19n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260803-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260803-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E74A309027C
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2E343D50D;
	Fri,  5 Jun 2026 19:37:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C381419316
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688278; cv=none; b=kdY1hMAARvWGRnLDlQGi2CEXEpviLNpC44+BKDOTKOHo3aGkN4cyeWoC+Fygoy36tilNHWmoNtv+zJPHYJTbGsRx4H2KEwqstVt8uj79vGyMENqOeIC2rh3VoKlnnH4K/PW0N+qGcyMpdQo8JN26atXMkIgon/FhBu8w8NN/a5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688278; c=relaxed/simple;
	bh=tTOAFXCdP+6uk1F/DonGGJoVhQRtkFyvhVMk673VWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1VxUKTHj3iHkt0EZRyGNSbl5weFftr93y3gXFrQ+bm0fXKnESOy+/Tip0jLEIg353ul28P3Ii8M7IizFaY455IGrTUoKgkatX7UGeESllbQQkqyhUB5G6+cm3ZcW1VaYndvavbmgo258Irx2WraQp8176/GVi1EiO0bpiVXZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsbAz19n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D51F00899;
	Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688276;
	bh=QBg7Xx2OztcHIAPGl2Z3FI2HELYO7wnTWXTl+PI/I9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsbAz19n718JUjjxQmwlvHYgAIJEBTl0Cpb/j5czeOz+Unl1S9NoajMX+4ziTEUL5
	 aQf1wyk3IlzA0qdjUCesPtlpZ89CGOoRyNEavC74YxLQ9sMikpkS/i4NHSt2my3HGe
	 TLoWHJ4mNQtlp8OycjG/Xn8lFs26Y/DFMulX6STEoAq/0mWY7Dlsnpq3K5jHGLwq07
	 leEvXsa2RNf03TirlDVsGCw7DoA3G4r6DBMBIIFYEuQPdgfvpLhiY338ZhnIdjc1Wy
	 EtTvaeBZ13JsilbyLmWhgOhrLIIkctdw3OFtyF76BVQSsy1j5s87+540u0fsF2BcON
	 gejVZ4H/LdRkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jordan Walters <jaggyaur@gmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Fri,  5 Jun 2026 15:37:29 -0400
Message-ID: <20260605-stable-reply-0022@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604014809.121934-1-jaggyaur@gmail.com>
References: <20260604014809.121934-1-jaggyaur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260803-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:jaggyaur@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F06C664B06A

> [PATCH 6.6.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Thanks for the patch, but I can't take this as-is -- a v2 is needed:

1) The "commit ... upstream" line cites a hash that doesn't exist in
   mainline, and there's no upstream commit titled "Fix UAF in
   hci_unregister_dev()".

2) The diff doesn't match that fix: upstream uses disable_work_sync() /
   disable_delayed_work_sync() (guarded by HCI_UNREGISTER), not an added
   cancel_delayed_work_sync() in hci_unregister_dev(). cancel_* doesn't
   prevent re-queue, and hci_unregister_dev() later calls
   hci_dev_close_sync() which can re-touch those timers, so this may not
   actually close the UAF.

-- 
Thanks,
Sasha

