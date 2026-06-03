Return-Path: <stable+bounces-260108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2AQsCeZOIGoS0wAAu9opvQ
	(envelope-from <stable+bounces-260108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:57:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A36397B9
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:57:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EgpjHidw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260108-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260108-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E31531A90FB
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193D3D1ABC;
	Wed,  3 Jun 2026 15:14:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79833CF677
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499673; cv=none; b=iS9D5MgQH/48gxox5CriBsFfvyNI9df+rXzw3wV7U3iXTb0w4cuwZm7lZYaAX/AF4HX5wJeDmov8dmjcUJzc7d1CciuPh0soKtvGWJYUSfsVSmC6NN/YCgEEbHJalFtLUPff8g+C+3CGkWhwdEukJTK7/zPMl5H4PcUvZKk7QJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499673; c=relaxed/simple;
	bh=ndcg9HTiLyWJn+0+Zo7QJd/gIe/Eeiv4cJUP2rhG5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db4/BXjjB6LfgEP5jD/M/Ro2CVnt13eDi/F2jjVV/Vo2Mdo8ULVVoW5SEBXcQo4IBvtlb0WM6VgrkpKmJR11JvW4h3Q3+cGRBZF+gy4n0T1gSL174ZF4otuezOSwLgLu3Be0/q8OkJy3c+/XXmfdngavnuK2e424rkBy7VsYbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgpjHidw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FA21F00893;
	Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499672;
	bh=+wNM6NZFTfOIUY0WPqES+hsYCoypKEamWs7y3Mr2xFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgpjHidw8oQzDs7d0ir/I/bGN3PfWj6kgvX8cZgabVAf68wU4u6XIOx0GnDbLfkAl
	 52LAu18mqTVHK+E+tAIObfMPrPAuQO/9CWHM5LckfnHQhDC/+tIxTQqKJV9AWcVlIN
	 Jrez92zOTftPVGxIyxf/rzEWUW0dTOJMJM+uAXBzZKOFwxu/pOFUe+N1XJXiJShKlw
	 xAdpEjvPqgePUaBLQBP3iNamnHZpsS9KTC1nkey/ymTWxbZk6ZbiF4h+8KkudSxy+N
	 T/u7OrJGU+JacCgYwH7qUJXNe8dTZAR/MKUWluJDDBtxADFiS9lp/t93YSdsOBnilG
	 AXot26ntrSXDA==
From: Sasha Levin <sashal@kernel.org>
To: Jiping Ma <jiping.ma2@windriver.com>
Cc: Sasha Levin <sashal@kernel.org>,
	michael.bommarito@gmail.com,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] smb: client: validate the whole DACL before rewriting it in cifsacl
Date: Wed,  3 Jun 2026 11:13:58 -0400
Message-ID: <20260603111500.item001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526015822.4076817-1-jiping.ma2@windriver.com>
References: <20260526015822.4076817-1-jiping.ma2@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260108-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,microsoft.com,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:jiping.ma2@windriver.com,m:sashal@kernel.org,m:michael.bommarito@gmail.com,m:stable@vger.kernel.org,m:stfrench@microsoft.com,m:gregkh@linuxfoundation.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B0A36397B9

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha

