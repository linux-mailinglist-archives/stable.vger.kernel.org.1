Return-Path: <stable+bounces-260117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9oLYD2NHIGr9zwAAu9opvQ
	(envelope-from <stable+bounces-260117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B763925B
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Moec8r/l";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260117-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260117-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E3232FE0FB
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD333D524A;
	Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5343B6350
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499683; cv=none; b=jnUNuYEqreQ/hsvk80YrlBG44yeieAeeejFFdOirGRFdru9MSdw8LofixriTaLt5MBQfKKfyv1sdBE8aSoV6zMJZeFYgAbS/agnCEcmr5+Bk8w1qFB8OFSscOXk39tVWyeYQQ8cu77Mla2yb7jLFSeVNugFxSgLheEzeK1m9p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499683; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9tVzar/hyMPYOfML+aqyNalKpgqgeRHCcqWQ5gR72kFrbVgb2QT9q1DO1U65ydoS0tzliebUjSCqqizDkeR2vj0TZR0b1l3yVTEAlGbHHABFFk5M0wX1LATf9clVtBdQYagrn2mAi2HQjP8yK4mC36GyRM7Mu5Wa9+92M638bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moec8r/l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E511F0089A;
	Wed,  3 Jun 2026 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499682;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Moec8r/lEi3IR+ji89e7ZXL1X3onTB1eONpEHev7p0EclOh06NI5Z/0vaLZilarsJ
	 I0C3FVBmOSGSNw/WyaHH57aK7vCm7CGU/fCwWssQ6CIcrQFyNPrg9Kz5oK6rNvk5Qk
	 J+XNw0w9sWG6s0E3v5HHBLyVFxOtbhO38Sq1YycE6t3xTqgz93/NjUbdDnirdXFOXO
	 fk6ib7oiwXErjsD8cl+NubIdWaPUFVGNvUWT4OSDXx+bi5YXYKjPRB9sQD5ETUaXNN
	 acnLr5JI1i0mCzlJRwt+MuB72zmUCBpJ+xZyQj0eXoiPGyXhh0tUOeNCgz4Em6peQE
	 EfJ4/0SOfdQ9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: Re: [PATCH 6.12.y] batman-adv: tvlv: reject oversized TVLV packets
Date: Wed,  3 Jun 2026 11:14:07 -0400
Message-ID: <20260603111500.item017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180804.414401-1-sven@narfation.org>
References: <20260529180804.414401-1-sven@narfation.org>
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
	FREEMAIL_CC(0.00)[kernel.org,narfation.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-260117-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A1B763925B

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

