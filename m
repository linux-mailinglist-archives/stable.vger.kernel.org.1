Return-Path: <stable+bounces-272248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuWyJubAS2raZgEAu9opvQ
	(envelope-from <stable+bounces-272248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2F712345
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:51:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ImE01U9k;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272248-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272248-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8493316075C
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4ED3793A8;
	Mon,  6 Jul 2026 14:08:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E27378D76;
	Mon,  6 Jul 2026 14:08:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346910; cv=none; b=WvvQFlKdaafSBziXqbeCSU7DSziUnyFIjpRgRcMy+BW9rjoC9F3zW/NK1+S7QDiz7EnE/BdIbEJCC6pG2oOjJv5gQa7sY2ywBsX09ntHStRHqhT7Bzvg6LMSpPb2d2PJ4w79YuyMOGMHoRbqMrynMIzEcZwNWN8aliYHFb6poOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346910; c=relaxed/simple;
	bh=lxlqGKfABMfZDI+W0HNaq6D8+ZvBD+cRtYxi58m1R2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH7+nGdoSmxQiJIAOSmwjYoTuzWzS4WIJFhkkGcaJE2OoqWmebOi2jU6RqHgsMSskKWIVwj4a3rBCzsqSuGZ7BFPtVcdXp6ouJp5TyveD/FSzVoBqD0TwB+BPwAFJx8ntgngmf7aFUTv/qoTZVjWjA3BVnVccKTLU1B0KsP54wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImE01U9k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876441F00A3D;
	Mon,  6 Jul 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346909;
	bh=9wA9W72obBOInK7f+81GO6Aw1p0fg+9MBar9MjsxaW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImE01U9kBSCZQ5nGTUfUp+o4YIk+uJf7VQQk9uXJqlCSHqvfM98lVziYbL4HRzkog
	 /BCezasfMSd9v7x/6ZZZMvtoMsrcdLNSnxDs9yPDta0OWL7iZVEpg5102FonWO2pK9
	 9C5ymdfzkciTKg9jS1RgheKK9CZ3KVNov8XHHSN+I6OPVYuFHytpTW5k4gwBcvWOq/
	 am7byl4K+dZ2eyjuT/+hNVeNwLBfNbWmR6WJBcnzla3JHIHzmBB1N5Mm1jtoj72DMX
	 l/mmCO9rAfLmW2o7SaFyVboFV04jQqg50q1NKvBkP4A6r5rf3QjrkB122ZnOdaB1yB
	 syJIOby18F1Ig==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Dominik=20Wo=C5=BAniak?= <stalion@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10 81/96] nfsd: check get_user() return when reading princhashlen
Date: Mon,  6 Jul 2026 10:08:20 -0400
Message-ID: <20260706135124.draft-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8601edcd7c9bcc70e75f85a758f8818c57945d07.camel@decadent.org.uk>
References: <8601edcd7c9bcc70e75f85a758f8818c57945d07.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272248-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,gmail.com,oracle.com,decadent.org.uk];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:stalion@gmail.com,m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:ben@decadent.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,name.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5C2F712345

> I think this depends on commit 4552f4e3f2c9 "nfsd: change
> nfs4_client_to_reclaim() to allocate data" which went into 6.19.  In
> older stable branches this failure path appears to leak name.data.

You're right - the new early return leaks name.data on every branch
lacking 4552f4e3f2c9, and the patch shipped in this round of releases
on all six branches.

Could someone please send a tested backport of 4552f4e3f2c9 to all relevant
trees?

-- 
Thanks,
Sasha

