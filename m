Return-Path: <stable+bounces-254023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBZ6DfLrEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE15C2553
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD22E30432F5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A3A2D6409;
	Sun, 24 May 2026 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Jz6pFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86935B632
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624614; cv=none; b=WsVz4S5ICF6vR+BaxfouQQqvHfDN0RMIfcuXaTPD02pV4RnKl/q6DQZI/rc1+Nj22oAz7KnisA1Q6B7o06Suu2B8prnsQZ+m8PlDzMh/oxMocdADxvWZcRjRXPNMe69YYW7/G5nlqpD+PqhWiAItE3FyQcILcpMhVM20W7z8Dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624614; c=relaxed/simple;
	bh=3HzAmxbHLtK3XRYOD+GQMkne8MWGT7yxsAMYToruO1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQlm+rt8mufSXQZc0Ol/DL7EJ0sbuuUJAcK49YKG5DPHcfWizWSx3OT4vcrJseKi421AysJiwOqdpjczOvhXInNCIRqX8WPsHg7BUglvkJ1mqVsqc4icXRSIvy4SC3Qd8pXT/cwPDYEl5NH1VRHSE8PSYkX6Id+UbaMVotOR11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Jz6pFe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EB41F00A3A;
	Sun, 24 May 2026 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624613;
	bh=t73p2I3zof5OTdzUFh0Y+Fxp//BaqZzHgLjsEtNLW6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0Jz6pFePlrzJt7LpTylop1w+QvPi02/eEqnlC49ViF4eSPC1aVfHW/p+u7MpEu1s
	 m308QJt6debjbHcBGPvsfi5zqUl2KXN/eDIoUF6HS8wvl0/Pk/dtndqmUiIJZKyh9X
	 wPpmjmTWk5QZjHyXnVBs4QKZqvPSgHvQp6j3QF+c7FtfurhMZoD1rToDz+vv+S/R75
	 2YbeSzKeGB1yvM7xxp4vEa2KnhdETkzgVoYaEvSjGPeMiHmOJlY/mSd9mNzmVH54zs
	 BGc3/R46+9kYnsEXdxHd+ngu0wCixRCiXLmrQFOx4qIOmUbdjSc5lxfNVfAcIrd8zB
	 fzG2T6ONWW3yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Block <bblock@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 6.1.y] s390/debug: Reject zero-length input before trimming a newline
Date: Sun, 24 May 2026 08:10:10 -0400
Message-ID: <20260524-stable-item013c-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521022839.38760-1-pengpeng@iscas.ac.cn>
References: <20260521022839.38760-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254023-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0FE15C2553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

