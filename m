Return-Path: <stable+bounces-272692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ToHOYN7TmqfNgIAu9opvQ
	(envelope-from <stable+bounces-272692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B50728BD2
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:32:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d4FhlAzJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272692-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272692-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DEC304CC01
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E963A42DA42;
	Wed,  8 Jul 2026 16:18:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA242DA41
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527492; cv=none; b=YUR6dMtpZ6MOBtqe9GuptuxlYPdZti9I9JAxBtq4tpGPPc96yPQv17cUZxg4OcQX7FZ8/G67Qo2UWH1Cfob7JBnquOlivt9hBlORYs49Z9D1LSXLtVrHgepBk+c+sf/wvGLmq9YkROLzlzFbYHokRxiI9rqO2QtkksibQITpqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527492; c=relaxed/simple;
	bh=GpdmFh0tf8gqKYu/oPkcs8RRgBWc5t5aAN0aHqDrwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8/WmFbFygN9Ak7ev5TKhv0zPF/seyjebAr1GgOe+idWrt0Is+mzHFwGyfYCstM4J6QUA2VL/LmilLX7oYcXwV4QXhdaobnvesFl6fC9OpQD16bfCSJFKhyzG+JazQxK+6icyx06LTVYUToKpUSEO5mwsA3DKz8XoGRkJQToShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4FhlAzJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6491F1F000E9;
	Wed,  8 Jul 2026 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527490;
	bh=KT7hvXJzaos0xn+ijp1hQi8WdY2j1/oHG4iy9QQIkvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d4FhlAzJtPCKbrmExlknaf54dinXG2TxJXvZAQxkQt4C/g7GtV9CmAvReJsXN1T7I
	 ycox4ARU1IM/bDAQuDRps+vDI5csr8Ipci2MbUDVMAeRG20iIZpevhPb2t0k+ib81s
	 HFApS0b8Z7eaigvXK0eCzwoHxLvZtq+7bYhLlWVfLSyH9NsuemneByBlJgArNbE52f
	 0bqoi+iGHSBYGCFeiltsuQRg638RNNI4Ycx0BuioC+9o7mYz+Jjlvs0x+UcQEDiXkQ
	 cMtr+Pt58R8xSnWy341qCFSfqpFC7gCtCQAor23qJiNvcmzE2v+6fW15TZWBEj+wvm
	 A71PG4GMPZKNQ==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.6.y 00/11] bonding bugfixes for 6.6.y
Date: Wed,  8 Jul 2026 12:17:59 -0400
Message-ID: <20260708120501.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272692-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0B50728BD2

On Wed, Jul 08, 2026 at 05:46:59PM +0800, Wentao Guan wrote:
> Fixes CVE-2026-23451: bonding: prevent potential infinite loop in bond_header_parse()
> Fixes CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha

