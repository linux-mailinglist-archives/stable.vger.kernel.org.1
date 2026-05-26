Return-Path: <stable+bounces-254361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdyA+aiFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B315D6AEE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23CF5304B7FD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C93FB7C1;
	Tue, 26 May 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfOfhKQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96803FADED;
	Tue, 26 May 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802706; cv=none; b=lX9/XOJUfRYyacre+suP8ggtHNlWR1mqLZKaqQV/eEZ4ERnugOfChLv3PrRg9fxIlU0+buGZJCf5r8ILWPcjeLy2MrRZjnvOwDPoNOhx+FstfkSaYu1Fk8VW1Sbj8nNGG0G3If9FtaRx6GwyHsdlVxyRPZDTfP61qprd5Sk5d+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802706; c=relaxed/simple;
	bh=bA2arLRw6MrFzjf4q674YQ3U0FDOAobtI8xjknfdPiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sel7I3TRxXmKPJgP9Bh7S6soLNEIlYg+dXBnGbF0JfUK6QF01CgTBgwCpWrZUiXHqR241E6uj46rTvCTH1T2Dj5nMSsRwitFGsod5WU4lA6ApP/L4N58HskqHV9rHTkmA4MpTzeGNbR+SyKolTStfTKfE3NFLSiwJax5iM3OfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfOfhKQH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA6C1F000E9;
	Tue, 26 May 2026 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802705;
	bh=YmkPWGaUZd7ofALFSfwSQbmMqOkx/9YpJHcA7pI+x4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mfOfhKQH98PCbed9Ss7W9LkrDIA+x0YoESNCd6CyAFsaD51FJZOCvgE7UdtoFXEIS
	 xmGlbdyUkxOR3ggNNnLCilMfwpTbk9Wi2nPCdt+KMYB2IpuvgG+/LWjn3V2DAOCJf/
	 3cXbVFxDF6ExDwwLdHQTYDVl1RegiKSVUzf3WWGQZ4WGy/1ke7OktKSlKMb+zHF2tI
	 8BZvOVHr2YLDnjy8fbcKszJ7WE+yrQT6m4a/HQN0VV7zVYKqH4l/jQ7hu+IrDskT2f
	 z+frIKB1dck1kdSN6fA2nlgbo+iji5+CSOpw2vmU+clHAqRBKTb9dASOVDhy+2Mh8W
	 nek3ZGBYBbWrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	willy@infradead.org,
	brauner@kernel.org,
	Oleg Chaun <olegchaun@gmail.com>
Subject: Re: Subject:[REGRESSION] fs/qnx6: incorrect pointer arithmetic breaks dir scanning completely
Date: Tue, 26 May 2026 09:38:15 -0400
Message-ID: <20260526140000.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d02905f7-6ef8-4df0-bb55-dea44fda6ce2@gmail.com>
References: <d02905f7-6ef8-4df0-bb55-dea44fda6ce2@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254361-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,infradead.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C5B315D6AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 12:40:12PM +0200, Oleg Chaun wrote:
> Commit b2aa61556fcf ("qnx6: Convert qnx6_get_page() to
> qnx6_get_folio()") breaks qnx6 readdir on 6.12, 6.18 and 7.0 by
> dropping the QNX6_DIR_ENTRY_SIZE scaling in the entry-pointer
> arithmetic.

Thanks for the report. As Thorsten noted, Arpith already posted a fix
at:

  https://lore.kernel.org/all/20260310102233.391113-1-arpithk@nvidia.com/

with Al Viro's review feedback still pending. There is no upstream
commit to cherry-pick yet, so I cannot queue anything for stable until
an upstream fix lands.

-- 
Thanks,
Sasha

