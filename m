Return-Path: <stable+bounces-261939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s5ocGDMOJmpVRwIAu9opvQ
	(envelope-from <stable+bounces-261939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:34:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF57A652045
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:34:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="TG5/vlrg";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261939-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261939-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 455BF30022CE
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 00:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68F2E22BD;
	Mon,  8 Jun 2026 00:34:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163582E11C7;
	Mon,  8 Jun 2026 00:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780878895; cv=none; b=DWLwlN3YPEQovHfQbtbTG5z8zf5vgDylR7ptTLIyAxqOl96j9brgparAalFLDBbitUZVmkqV6VP+pf+43Yx5dP5QgfpkA+P4iPLWc4eVtmnKbxGNd2GLT0QBjy8bXxbrE7w44RyN+San3TN0AziNcLQBjVKX4TJnpvYvzdU0VTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780878895; c=relaxed/simple;
	bh=eyS8IE4UX/rqahBlzU9wjQ8heie46agiTatI7322cPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV8qrmQu6v+PpIw7Y57oCDrh3YbtNX5sh0zCdo5P+TucPhG4x0m90FX75sKO98B66V9SgFN4DeYnc+uAe+m5yvmbqZbl356mV6trtpm/9tc+LDMToIGbumUER2MqCAf9rR3WKbAqjZ6lVu3y382wiSCu2t+cG0NCHQmrLJWany0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG5/vlrg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBE1F00893;
	Mon,  8 Jun 2026 00:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780878894;
	bh=eyS8IE4UX/rqahBlzU9wjQ8heie46agiTatI7322cPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TG5/vlrgUaRMDAt6rFlygpFpmKpQr/0Uc0p5i301blQ1PVkLNd2/Td1JSYSgES6Yx
	 JhqJxwzGY9l1nVPXNgakfsp4kmMiRbBJViu2b5ox+gg6vodLksCOZCPWGsTcwKfnnY
	 R4mlFU0+hX6+ZguNcteSmcyif7hRUY1LKnbBoJDIoVxvqNAk4NgOVqAx77/y3VbKLJ
	 EBROoGpg4YTYSnubKw0EnhokUyYd91y4owZAjxmC+890CpNMKPd5LBq+EMJQhp3YB4
	 iWsb3Ydv1rjn0ZQEwCTpcNIb2Bl1rroqoRZ3H33v4aA9en6xV5ejcOuze5r6gywI66
	 1XxpyUqI0zk1g==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 7.0 243/332] gpib: cb7210: Fix region leak when request_irq fails
Date: Sun,  7 Jun 2026 20:34:48 -0400
Message-ID: <20260607202000.rc-0004-gpib@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <148e4311-5d45-4c89-b93d-898282282f7b@kernel.org>
References: <20260607095728.031258202@linuxfoundation.org> <20260607095736.972391850@linuxfoundation.org> <148e4311-5d45-4c89-b93d-898282282f7b@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261939-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:zenghongling@kylinos.cn,m:stable@kernel.org,m:jirislaby@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF57A652045

> This was reverted by 05d5d79440c2cc0784f91b61f2012753e66be472.

Dropped from the 7.0 and 6.18 queues, thanks.

--
Thanks,
Sasha

