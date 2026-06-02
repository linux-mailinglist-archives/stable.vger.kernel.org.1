Return-Path: <stable+bounces-259873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DdpnL9cfH2prhAAAu9opvQ
	(envelope-from <stable+bounces-259873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4378A6310B9
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=knAsFlV0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259873-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259873-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6536E3039CAB
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093D392C56;
	Tue,  2 Jun 2026 18:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1643955ED;
	Tue,  2 Jun 2026 18:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424512; cv=none; b=cf4N7VhnWNtrTqVe0IdEns7UQ3O5QnVak1vwHrswB7XQUeS+WYR6No9c3IXfO6XcZXo3Cc61mI4dcA4y64XC5TBy+hIDxjyhaHizcTz6S+ssz149LjuGID+Wk6iHxyFW1txM0IZbnhbYCDTHBrOdWsInP/g8ylTvfyWLsRz3TUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424512; c=relaxed/simple;
	bh=rdJIW0U5Hms6fz0Svui8c485jp1wx/M0jcmFovht9I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpQG1TvnazOP8+XVTzuCfAZtZRn08MMPgjRpDiwm+qeV2VNnC0EXJ79eii9S0y/0e9fRb4sxHxxeOHgT9EE0RYbVIzTT+asJRDRGbYtlJAGR8eDOXGX4mJ4XB39Y2brx6arIKCJ+Qy+XWTRqNDgaTbAmqVkU5rfsw6eZiIe4fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knAsFlV0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319631F00898;
	Tue,  2 Jun 2026 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424509;
	bh=rdJIW0U5Hms6fz0Svui8c485jp1wx/M0jcmFovht9I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=knAsFlV0bIy5Phc1zoCI/HeMTCcv6QRmuYpk5UABYdqYXggNiKMCjBeAFQEMnTVp5
	 Y/igctu0uYIBe9UGSz5xm+1xI3WQZ9sVIWccTv9AFCBpS+Fn3mGBOgsA+2RGs92ssu
	 1/yCUeaPSW3wlCRa4o2hUPBCWFVVR5zGGFJ6vx3VgV0H5WdB6c97zFs9Dlr0vImN4O
	 M8HozrAqSpu7Rk8XiRkL01TachkvX1Ckh1xs9Oe4AY2B27oCw91SoBqrCskadgzMr9
	 2WIUgb7oSOy1vPar5YbjIcDi69U8H0kNR/8ky/4ASlB5wLouZbTBYJEidKU11/dSLp
	 4Z1q714TJo17A==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 5.10 027/589] xfrm: Wait for RCU readers during policy netns exit
Date: Tue,  2 Jun 2026 14:21:26 -0400
Message-ID: <20260602180900.xfrm-pre-exit-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <56652caf63e8db874a3ebd761ec134c003d4986c.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160225.295450347@linuxfoundation.org> <56652caf63e8db874a3ebd761ec134c003d4986c.camel@decadent.org.uk> <20260601015021.rc-xfrm-netns-exit@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259873-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:steffen.klassert@secunet.com,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4378A6310B9

On Sun, Jun 01, 2026 at 03:50:21AM +0200, Ben Hutchings wrote:
> This is broken - it needs commit 3e5241731847 "xfrm: move policy_bydst
> RCU sync from per-netns .exit to .pre_exit" as a further fix.

Now queued from mainline (3e52417318473782) together with the original
commit for 7.0.y, 6.18.y and 6.12.y.

--
Thanks,
Sasha

