Return-Path: <stable+bounces-233836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PtEKtIz1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:54:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEEC3BAFAD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C3573085A91
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9963BA22E;
	Wed,  8 Apr 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjqLK4uX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B820E023
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645533; cv=none; b=AtgM5Fc9RmSPhcHijZ/NhJOO2XVTNXEe5JTtrDoELh43me9j7CeZxWnO0vnUTl6525OKAE3/2Vlz8x8zwNYaM80UmJfX1iWIcA465pTpJvYkXFO8dphKcKvKhlSPmmawjKzjwpKxWnI/ENOD10UM4rj5n7Jj+xU8wLnn7W6pc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645533; c=relaxed/simple;
	bh=+cvipv03aTb233FWQpchoVJUwkM4Fk2vv30NxgbrNJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhWLZcOP+NkpIjF+hvFWu/PUnuiyu251cKX68awW0v2A2JVMqicBE+/5qH3/ZRObPOcKrTH42TJANhQVojiSHy72axYCV7zr2piAN6e53cykRF0dfgj2rykVbSGkDPu/0OXF2FtfuVr/WTzG9gBQqkVY3ChXNqFtTOkwZXHe5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjqLK4uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE74C19424;
	Wed,  8 Apr 2026 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645533;
	bh=+cvipv03aTb233FWQpchoVJUwkM4Fk2vv30NxgbrNJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjqLK4uX6DabsuMDl0k5zp4/zpOm/BkbKU0Nyb8brZEAivloIziNBg3x1FQNP9ZoP
	 qdFT85rPiC5nQNIskC5YA8I7doqUsxAJgCELVuNuWVVDUhtynXeNE210lm1Dnx0Pak
	 4CjBfaHm45/jSfSEes46cZg0lOm0qCM74UEeczhb16PdFBPXVaWfFkANAjRSTmKqC3
	 e+40gVgYwpiBA9NPNvRDglIkFNaGhknS0VeykZJ1vazg6/RM4Cje8uBl7uZypjiQaP
	 619/OUHexZuN6uaYQK3hYNlpXUKbpPrdIojCilUl7zkSSWqPDEvqUbgqxYEKkDVWRF
	 p3Iml+c3hUgVg==
From: Sasha Levin <sashal@kernel.org>
To: Ruohan Lan <ruohanlan@aliyun.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 1/2] gfs2: Improve gfs2_consist_inode() usage
Date: Wed,  8 Apr 2026 06:52:11 -0400
Message-ID: <20260408105211.946670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403055154.4206-1-ruohanlan@aliyun.com>
References: <20260403055154.4206-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-233836-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CEEC3BAFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> gfs2: Improve gfs2_consist_inode() usage

Both patches queued for 6.6, thanks.

