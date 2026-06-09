Return-Path: <stable+bounces-262143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yMRNAe9jJ2oUvwIAu9opvQ
	(envelope-from <stable+bounces-262143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:53:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DA65B72A
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IfK0iNrw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262143-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262143-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 892A13085FA6
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A83274B2A;
	Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746026F28D;
	Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966332; cv=none; b=OwCWyA6y0zUk57CH4rLlCbNCnP+UpELE/PXfqGUTagNbBuvgzv06vlBZ5lKMPqljRN4GIff3/sU8/vKWXiFDRBZ2jhK3OX7XtMP4/KWNGyaceN4IiPpSVlTaA42m1GOyHwxkuxbDq/VLthZ1EF/bbNcavNiRE699R3e8C87kF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966332; c=relaxed/simple;
	bh=jUJHKdlItZlaQAfQ+r+MRLBGNB0vpvVN4DN0OgTVrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRTQ9623DEPk9e24OkhVMf+9AFDvD472p/HVMSNJYYVYv/c3Fm5qa0osJdmOx3m8Ik6DpOrPxCv0e8JboUJZk03hOFN/hV9eIXeF5DmNDMaKlC4IpEL2rgbGLyhiIsCNZwgsw8UPv9ccecMAAJS74DAvX/nOpm4vk1HHxB6Gb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfK0iNrw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208831F0089B;
	Tue,  9 Jun 2026 00:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966331;
	bh=jUJHKdlItZlaQAfQ+r+MRLBGNB0vpvVN4DN0OgTVrUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfK0iNrwOE5jJKovA1vj1sxtcqIr4liLlb0b8OgUUjTH9LXf7/eEoyyLciJUcn5nE
	 PBIPxhIycQbu+y5muvbMl/VmlOt4KQi3PUnffKR3Jn2E9l0M1NTfcoF2Y02Kt3Ohom
	 TBfFQReAbqf9VhSKWm9us9XFhxNHbDreZFfGGQvz8Dkjoo5O+vsZVtPUZkD0ryCXQB
	 OeTlR29YFzuntLFFFevGFc07F4c5/LlT9QJgiA+l1USixbI8p4IkY6t/o6tt/BoYho
	 YIignphwkcfrnz5lfwgyDep4wPMh8sWYsEkyyHSAdIHSTnFrqYUMGiVv+h3a8qKVKZ
	 TepzFuIkWnxMw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.1.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Mon,  8 Jun 2026 20:51:50 -0400
Message-ID: <20260608-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608095510.97742-1-jetlan9@163.com>
References: <20260608095510.97742-1-jetlan9@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,intel.com,163.com];
	TAGGED_FROM(0.00)[bounces-262143-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:vinicius.gomes@intel.com,m:dave.jiang@intel.com,m:vkoul@kernel.org,m:jetlan9@163.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 844DA65B72A

> [PATCH 6.1.y] dmaengine: idxd: Fix not releasing workqueue on .release()

Queued for 6.1, thanks.

--
Thanks,
Sasha

