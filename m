Return-Path: <stable+bounces-262755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LrJZGvrTKmq/xgMAu9opvQ
	(envelope-from <stable+bounces-262755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F56730F9
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:27:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TAp+zw0C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262755-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262755-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78D830E78B4
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2A4183BD;
	Thu, 11 Jun 2026 15:26:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7840DFDC;
	Thu, 11 Jun 2026 15:26:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191595; cv=none; b=L6hX43x8I9T5UfEqAMBK7BRFHc7HY5SCqMjakRfTNAeiFXv5spKlyccRI0yVz+HZF3Y+tl+rRwhe6Pn05wv7JVXB/+rMSVOkCXhaPlV69cru+5ASOsbSLTrAnjA8G2Le73Mkxmb+MsTayT7jJXA16+TiMorrrQRFZmbmsdxZWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191595; c=relaxed/simple;
	bh=lb/Xh6CZ6v1JETMo9SWyYV+gk6hUM+mppnKrC0/EHrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re+1ERlc9IjHsoaKXybunFtPYutvLQfms39Kz4Vq69F8OjDjhKHFpNEfEOk0i4ZlZ5MSxyYuGfnDpKyN3VUBK/yFpXDc3tlNlQorJ3t8yIsPytohSDbDtSpdAZeHz41EutDlIcLi8aeg4IJztKx3zTq5URf4s9SntqIHp8E273I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAp+zw0C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847171F00893;
	Thu, 11 Jun 2026 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191594;
	bh=lb/Xh6CZ6v1JETMo9SWyYV+gk6hUM+mppnKrC0/EHrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAp+zw0CbJJIQ4NM0uBYexikifAx7aNFXk5dTK9zgeBSbTObWApjirUISQviKuIpf
	 Fj8X+LJR2tPTZBRGogK2M+pfizLJ2qwtdhY651v1XLHv9pSG5+AVYs5p4trKGqJPDR
	 BbfPOWiGYk8N3HsTTy2YcOjI3iiCXVh3niox1fdfDS3ZLq1P0txsV0ooMyxP318mTM
	 pqHTsquON/C1nKquL0n+u+t7jaqYNKCC2Wnzw/r0EKiLykR6NtQiqNdZjSWJSBsMc3
	 0MH96hQwiTbrn90FcksFkz7PK9qEah0ev4i2sksH4SB5QP6WTPvBBIGNEClaGIFdSo
	 dZBqg5EECasyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jianqiang kang <jianqkang@sina.cn>,
	Neill Kapron <nkapron@google.com>,
	kernel-team@android.com,
	Kuen-Han Tsai <khtsai@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	raub camaioni <raubcameo@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	Felipe Balbi <balbi@ti.com>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
Date: Thu, 11 Jun 2026 11:26:22 -0400
Message-ID: <20260611-stable-reply-0104@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610180928.3093023-1-cmllamas@google.com>
References: <20260610180928.3093023-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262755-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:jianqkang@sina.cn,m:nkapron@google.com,m:kernel-team@android.com,m:khtsai@google.com,m:stable@kernel.org,m:gregkh@linuxfoundation.org,m:cmllamas@google.com,m:raubcameo@gmail.com,m:kyungmin.park@samsung.com,m:andrzej.p@samsung.com,m:balbi@ti.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sina.cn,google.com,android.com,linuxfoundation.org,gmail.com,samsung.com,ti.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 013F56730F9

On Wed, Jun 10, 2026 at 06:09:23PM +0000, Carlos Llamas wrote:
> From: Kuen-Han Tsai <khtsai@google.com>
>
> [ Upstream commit ec35c1969650e7cb6c8a91020e568ed46e3551b0 ]
>
> The network device outlived its parent gadget device during
> disconnection, resulting in dangling sysfs links and null pointer
> dereference problems.

Both queued for 6.6 together as the series, thanks.

--
Thanks,
Sasha

