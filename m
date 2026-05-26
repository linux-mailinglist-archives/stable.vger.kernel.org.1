Return-Path: <stable+bounces-254362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJn+IxCkFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E15D6C8A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54674304C486
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82643F86FE;
	Tue, 26 May 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYATYHEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026D3FB06E
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802707; cv=none; b=pLKgZCJowSCyV0VIW9T0WHmUXNE0tPNYg8MAaMxcn67h1J9nNPEvGhXCMjEYwAYcAP9IXoYkSXbV+JM4jS+AIRyCUinnfH89uQumzReihKQLlHEQrIho7BbfztfrVNnrSfrVXDARE1uFXKNu+TCiAE+jmUDJnNNZctHfHU3YOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802707; c=relaxed/simple;
	bh=auXzHp5QQDfngu3ihIlZNQrfFPT64/ltXw5gNYtFPyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxse2+siUwPqAvlfUZEJBiYbP3F8+ekfkNyz0zT/JUjXCa/H5Tj3dHpqj5NHYRxC/zJCb+sUlxoUM4kx6tnYeRKaph5YNzWH90BT6tK5rIyN3Bj7JStEU9C+xX2NtaQ34EJcQLvMdGRkhBkBGiGgYC10/PmS6p2CyP+fpD0CDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYATYHEa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3A71F00A3E;
	Tue, 26 May 2026 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802706;
	bh=BDmhGO/VmHAEXHxvFXpq4kJiA6FZPKxNLY1WBpoB1ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYATYHEaKShLPBdZnJJ+i7pw4HVqkTIwxZFH9hPGGpi+TVdxlQznk6rKx68xN/5T/
	 JAFmeU5vZPKmkm8IJbM6qGO1TGgR84g4YDPPRkrOafcUgnrEyjRhoosu1vQMl+Ud0V
	 /+m0djvrYhWAPZ3jUecR4qfN0ZHHJUTiE8Pd87qglyEBt3W69orRrT6bS7ioKnrt3a
	 7coj8qCyA6HCzODZwA8kP2Cubwi/OClpNRIRB+ngOquQHFg2cGALSLoE+Za7qHpPS8
	 ss0uoBeTQE8kUNVo5XiK2f2a95/ESNi2yOA80MkM1BSa2XE7SxiVPF7xK5o5xenAWY
	 BSmPXPCzNAbJQ==
From: Sasha Levin <sashal@kernel.org>
To: kuniyu@google.com,
	kuba@kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Leon Chen <leonchen.oss@139.com>
Subject: Re: [PATCH 6.12.y] af_unix: Give up GC if MSG_PEEK intervened.
Date: Tue, 26 May 2026 09:38:16 -0400
Message-ID: <20260526140000.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526054549.3962-1-leonchen.oss@139.com>
References: <20260526054549.3962-1-leonchen.oss@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254362-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C5E15D6C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:45:49PM +0800, Leon Chen wrote:
> Backport of upstream e5b31d988a41 to 6.12.y.

Queued for 6.12, thanks. I also queued the matching 6.6 backport from
your submission.

-- 
Thanks,
Sasha

