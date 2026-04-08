Return-Path: <stable+bounces-233834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNo8Jcsz1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527C3BAFA5
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5FE3083FE3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A43B47D1;
	Wed,  8 Apr 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtKj0Uuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA539A07F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645530; cv=none; b=m8VuTezZ22TkItpfVvm6qkkUy3b020M8zQ5WXpthTCixaNOT2myMGzRGFfEVZzLwiJ+ve8okZdJHryEYmm4OtKxShQaJMCcgfU+YIUNjCAv0kFqluKFc8wThJo7LzYVhxM1cuYaMoWjBD3xIVXK7N2+PsEzyK+J5eMjbLnOT20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645530; c=relaxed/simple;
	bh=Yerm+D05tkTPg8YuiDw7LsztguIaSHr1yW55Wli1JPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGk9D7VX/r0QIdiCTPE71f/z5xT4ckmXHgPpfjwHDBMI/qKCHr4IAn6hrB3d3v2d2DswAjOsFDfeyyS1Udogi21PPreEKGBmxSds90vH3CPKMAxY0vqlC3EW0X8H2DgWsWpgkWdQx32A4w+duMRMxNpbARf6aULwXH/5ECpjZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtKj0Uuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870EC19421;
	Wed,  8 Apr 2026 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645529;
	bh=Yerm+D05tkTPg8YuiDw7LsztguIaSHr1yW55Wli1JPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtKj0UuolgVyWHiTDysr0od1MyZ4Y8K804pu1xX5Zjq2ouO+LI7seb62K4tAgXVUY
	 RglkZIV9/UzmWjg87tQG3myyfzg19JRazEXn6/QAwMMb9gqi9hvyT1o7uSL3IXMq1u
	 i/D+Oi46msaywnT4xixgkaK0L//rI9/C51EOr3VJQw0bB4Pn10GpEvMLtqQ5v7dTyY
	 nIJlpdkuqDEphgUwbzUmwWhor39w/dtb9WOhYvqK6tg571ykmBGHFxLB9hYYB/6HSc
	 cI4FYMW6Vn5e40/WD3LppOynsqoWG5tSQ264ckid33Pk/nOGQ0VJU2+wUfQim/BP1T
	 ydFat0tCZZFTg==
From: Sasha Levin <sashal@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 6.1] net: enetc: fix PF !of_device_is_available() teardown path
Date: Wed,  8 Apr 2026 06:52:08 -0400
Message-ID: <20260408105208.946526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330081944.527545-1-vladimir.oltean@nxp.com>
References: <20260330081944.527545-1-vladimir.oltean@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233834-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3527C3BAFA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> net: enetc: fix PF !of_device_is_available() teardown path

Queued for 6.1, thanks.

