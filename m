Return-Path: <stable+bounces-272136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j9nZGfVVS2qKPgEAu9opvQ
	(envelope-from <stable+bounces-272136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:15:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5770D690
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=wC3Qc1A6;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272136-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272136-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81E934B63D4
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3D4C0415;
	Mon,  6 Jul 2026 06:24:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AE3CBE69;
	Mon,  6 Jul 2026 06:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319071; cv=none; b=O4NvwJnnnda/jUyXSWrKSX6aQmuj+eDC5V+jLM+mMEQ/tr2g5ZCBE82DYFFMn9BIqUAzwJF6OFU/teG7n33sWoSuGD1RiTdCFQATicdKrcAyxWlt9JkcNVjkhq6yPMxCmYrVUb3BoENhFP4F0eaivnP9h0iMHaCqmP2n0RjoDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319071; c=relaxed/simple;
	bh=FHTwWWdpbmraH3fKYY0ka1jQ+eV9iOVLeNq9bpYd6lA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AWpMLSdhRVZWmG1zh8Igf/aiZy3SQ2vBeY8iAW0WHCtklg1f1bdE857P+kZcj12GKekZWohClR1ZS6mYI2sQe5QETH5j6sNguNUVmHYu+LragwTdE1yGhjlzZJmxqLAwMEjTya31oN7pjbNUNxOAe6wik9OB7GT7EPUZyCXVJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wC3Qc1A6; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 26C281A0E7F;
	Mon,  6 Jul 2026 06:24:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7A91601A2;
	Mon,  6 Jul 2026 06:24:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E4BE11BB9890;
	Mon,  6 Jul 2026 08:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3IbFos0UeA5hamgUTU74OZqNtIk1cvZ107rKx8smnWk=;
	b=wC3Qc1A6ke/5jyvpXClPdyJj6j+KsAzGM8khmdwAPlCrl7WWxNRvQOQltzSN3YNsQPz0QG
	/Jz4zseEy/9KVscxDWYrFTzh3M6rvhrjROkZ4Aw26YextQKVVqqXA4CKKBUQY4dwwYo4ap
	gsbkK7N03c7JYWdfL0vQ23jTIXb6SsGcYdaDGX0Kd67KIIYJqbaLebfQ+MjjpYarv/4AnN
	SMYOPgyo6yu/2eX5DzDB+9wpl3D9EnhUpVI/uZuzfWAX1JZcMarCkCvozdSe3jvprscHXw
	fugmy/DlsW8mqzhs6p8z/cNmhOcHJVsWnjK15bDeLOvGeUbCNtfbRxicRC6FBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: raoxu <raoxu@uniontech.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <A9EF5AD55FADC312+20260626021338.3744161-1-raoxu@uniontech.com>
References: <A9EF5AD55FADC312+20260626021338.3744161-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] mtd: virt-concat: free duplicate generated name
Message-Id: <178331905244.868671.13228037841179082405.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272136-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACC5770D690

On Fri, 26 Jun 2026 10:13:38 +0800, raoxu wrote:
> Every MTD registration runs mtd_virt_concat_create_join().  Once a
> virtual concat has already been registered, the function builds the same
> name again and takes the equal-name branch.  That branch skips to the
> next item without freeing the newly allocated string.
> 
> Free the temporary name before continuing.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: virt-concat: free duplicate generated name
      commit: caa0ecbeff4f7fbf70f22bd8ca598918bffb1b78

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


