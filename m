Return-Path: <stable+bounces-272695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KCzPG297TmqWNgIAu9opvQ
	(envelope-from <stable+bounces-272695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:31:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1768728BBD
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bb2Ji3MM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272695-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272695-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F133064FE8
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63C430787;
	Wed,  8 Jul 2026 16:18:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5E42DA44;
	Wed,  8 Jul 2026 16:18:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527496; cv=none; b=IN2dVvybIrWRhyQsaCI18coa7R6veaHwd1A7Yl62gS3J6wHl23P+c/MfMinkw0qR+QUT2avCIS+94Mhy5NuwOutUU4ZaTqVIPioTQBgid0ygJ1GTsw3ggh3t6+xYQYZ4ZR7Tw8Pi4QJRnSKZThJaghJlxdugswOSu1O5KafwEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527496; c=relaxed/simple;
	bh=g6M3lGbwNCXgQ5KgLhh/+rShX5VadDF7bwG1iRenO6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZ9pgXySuHXYuITmJYsY6WRnH592IDlqx0Stfi9FbyOKnjRTZC6+aum/gKp91wuVupktUmk7BP2S+EuTt+6Imx8nXUTXGJ8Ov8xWJ9H9ZyPDKC6ALHSa3HGHpWVFthNkRinAaVqcy3WNIDkNVucz0nW9pMYBY5xQDRIkzfDY0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb2Ji3MM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9511F00A3E;
	Wed,  8 Jul 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527494;
	bh=jKssdYZiy6udKlNV01GqsnyHLqSFgLJHIAJ0O3hJg4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bb2Ji3MMofOwrfCPD9WmYbHt/0TR4qmaPEKm6cLd+lywOAsljbIVW2WYfgLAH12Qy
	 XOmcU4Sd3HHKftB30QlTctZkh7oLs9EP9UTuNWHpI9cmChLobCrdipI4vfip1Vv/ZU
	 EAVkMmiBOhZpOvi3Fks7c5LDd83Ju/EVCO2GyWxO/4PgdlqE/4cusG6iuIUeWfI+3f
	 9tA5RRPZgsdPhQENMGCgsoTWFH1L6wFu2yr9e5dKY+gLjhOWpvM48QXoXQDpSaFnlP
	 Ags4V9BPmjPqRqkZ9ivxVPKDqL2Mat7nCugMCT6hOqvABBNnZzogMSllbBSu2Z8ztf
	 PBd35A9rA9JsQ==
From: Sasha Levin <sashal@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	xfs-stable@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org,
	linux-xfs@vger.kernel.org,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Date: Wed,  8 Jul 2026 12:18:02 -0400
Message-ID: <20260708120504.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ak2bBIGLumgLD4nd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <ak2bBIGLumgLD4nd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:sashal@kernel.org,m:cem@kernel.org,m:amir73il@gmail.com,m:pchelkin@ispras.ru,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leah.rumancik@gmail.com,m:tytso@mit.edu,m:djwong@kernel.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272695-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ispras.ru,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1768728BBD

On Tue, Jul 07, 2026 at 08:34:12PM -0400, Hamza Mahfooz wrote:
> I ran fstests both before and after applying the series with "-g auto"
> as Amir suggested and the only meaningful difference between the two is
> that all of the tests after xfs/234 refuse to run on the unpatched
> kernel (presumably because of the kernel panic). I have also attached
> both runs if you're interested in having a look for yourself.

Thanks for running these! Queued the series for 6.6.

-- 
Thanks,
Sasha

