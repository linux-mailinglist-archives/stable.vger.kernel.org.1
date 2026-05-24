Return-Path: <stable+bounces-254037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAtoDzAYE2oi7gYAu9opvQ
	(envelope-from <stable+bounces-254037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112115C2D7F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9317B300CC81
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD53399D08;
	Sun, 24 May 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHPsiYXs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD81DB95E;
	Sun, 24 May 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779636265; cv=none; b=qIFo2KdxvvUh6nxp9cNWPNmOR+BVmegmCCCb3oVjD/d8Z3T3weUNpJq2mwp74vW+FNZnT+gvOD1le4lgFrL/H+K2u4ApXfNPf+3yP1RGeY4XQmIgXK4K/pVHPktY4W6IPqj3M1RPifMW7IUEU9atuiwzKR6iP09p6NnPYCJpM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779636265; c=relaxed/simple;
	bh=bCmyFjdA4iHIcezigm6L8aV0+RJvDjszZV0U6GoEwxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx/QY7NBwf2uHT5mFL5Xq7q1NNz5H0jv5foR88ggo1ZNdye7hGmMIDGYHPyrdhYE1dDT84bDo1rc0b8Xcvh1st+TFb5zHGACm+o1HbJkW2A4h+rJBu3LfQTKGgfFzjzKleHucLx0CDb3MuQeOg/Fsjp2rGxGN9HcFWNsSuYjS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHPsiYXs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23BA1F00A3C;
	Sun, 24 May 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779636264;
	bh=YVnkto8I5OXMziaCAPLSNc2/SiJXFVDLCRyLCKuVUNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HHPsiYXsXTPJ+Ix8OXjSvGV4ncXpsfpk2DgEbzmPmlORIHF9Fn7ZjTUjIUffPTIJX
	 yk8z/AIq4JkNG8JDolt2dcO9dUEL5GgnOzjRjzhGKLS3NEmhaFKXqenrDC/1kAY7j9
	 QzQaHs3NH91yITyPnI5VLL76AsFGuJ/76p/wnnO8P9tbW/0JuwE9qDgstj3XAR/Kp0
	 mg+lXzo4PAiUOGuFagHOPsKjRVtkg1IHGsQUyTQhJcnA6wf1D9dKfBpxKpsu30FzqN
	 vy89MQHg4+1SdUwP5YgNVDzeOOUV46lsGcbrkvEnZy/H6l/SWEBeyoPBKLwPepcli8
	 RSWiHZFppP1vQ==
From: Sasha Levin <sashal@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 6.18 346/957] fuse: new work queue to periodically invalidate expired dentries
Date: Sun, 24 May 2026 11:24:17 -0400
Message-ID: <20260524150046.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87se7h6pul.fsf@igalia.com>
References: <20260520162134.554764788@linuxfoundation.org> <20260520162142.034488466@linuxfoundation.org> <CAOssrKcqmVW3kJ131tRF3LCJVQUtdRB31B5HENDfpgrq6r=jEA@mail.gmail.com> <20260522123641.rc-drop-ab84ad597386@kernel.org> <87se7h6pul.fsf@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254037-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 112115C2D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hopefully I got everything correctly, but it would be great if someone
> could double-check.

Applied to pending-6.18, thanks.

-- 
Thanks,
Sasha

