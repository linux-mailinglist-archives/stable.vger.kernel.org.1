Return-Path: <stable+bounces-260226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zT/fK7TBIGpr7gAAu9opvQ
	(envelope-from <stable+bounces-260226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:07:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D5263BFD9
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:07:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NZUGUTeh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260226-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE6F13014852
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048032C8B;
	Thu,  4 Jun 2026 00:06:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431F2AD35;
	Thu,  4 Jun 2026 00:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531563; cv=none; b=eX5NaxpAf+kgPZRbscXbXGhtAtpgTjJbdViZ7FGiYrpIJUMRHOPdC+OarGL5k+chB+S1On4hZC7GHxQW3E/iMN1RK1gFCALtBll3I8CYOt/QqF0xvOWvt71bDKfEmfp1crKiQ8GznlhSrz6giU0IWGsfvGGY6wnA67dWqdP/oJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531563; c=relaxed/simple;
	bh=mi7E+At9QLulzwlQPILcHxfpu7UYlzt7umRN92a9IBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ7G1VkBkweXGW3F0h6LHJmnoKcuoQJVfnvhtS62S9smQn1TcdaFMtkK++Pd9wK7jzuxddSrx+/3DUYhrvh1JS3vB1amk0/4x+KnD7fmIQeucPpu7SSIEDc4mgDor0k6yZDcVBIsI0ATFN9Q1mdTULjTY+O1K2sPLmkH+TP9uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZUGUTeh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63691F00898;
	Thu,  4 Jun 2026 00:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531562;
	bh=dA8qdE9l+pRvTBAM9C2cL0PZzRAsR8Q17W2VthHAZBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZUGUTehfhkpma1CcR7/BVFVdQHw8FXBpMb5DH0qOEUa7dC4/ZzmCJZpnCQCr1Gkc
	 6+I4is3w7Us0bsqjjJumL2ahKX3/NyUlCyNhETtXjNWYqf7I6ajvDX5A7eGYfInKDa
	 JDDRn6ifmrAgvc88cWDgpWViveSYZqf7DbUdrabZAm38Maa5Do0tnBGUyHb78hW/rk
	 qgG3KthWNzW/OvVPE48fzwMRqvKJQ1PGb3hghV6+EjTtcweaWh23EbENvLqYGYgLWS
	 9CmZaCWU9wsBo7c4o9Q1wR6ox7CctYxxgqhdlQYV3t12h2lxqO2v10eWjRU+1Wmjsp
	 g9hp1p3mSupEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path
Date: Wed,  3 Jun 2026 20:05:46 -0400
Message-ID: <20260603210831.item015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603081509.2027062-1-rob_garcia@163.com>
References: <20260603081509.2027062-1-rob_garcia@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260226-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:metze@samba.org,m:sashal@kernel.org,m:stfrench@microsoft.com,m:tom@talpey.com,m:longli@microsoft.com,m:linkinjeon@kernel.org,m:pshilov@microsoft.com,m:rob_garcia@163.com,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,talpey.com,163.com,vger.kernel.org,lists.samba.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09D5263BFD9

> [PATCH 5.15.y] smb: client: fix smbdirect_recv_io leak in
> smbd_negotiate() error path

Queued for 5.15.y, thanks. 5.10.y is affected as well, so I've also
queued the equivalent backport there.

-- 
Thanks,
Sasha

