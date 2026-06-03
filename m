Return-Path: <stable+bounces-260121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfkpFlpOIGr00gAAu9opvQ
	(envelope-from <stable+bounces-260121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD7639759
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OSdMqSPl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260121-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260121-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D63331D0A3
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81C3D6691;
	Wed,  3 Jun 2026 15:14:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAC3CD8BB;
	Wed,  3 Jun 2026 15:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499688; cv=none; b=Mf/+QMcuHcb1MPGyg/vt8/2F+ni0Ixx9eOEbF6Hhf9+dIhAvlJSpd5y7INj7hh+mwb3437oeAjWeBy4WibrloFuUsIDOAtKmJU073CFzdIFP6/VXnIlZHjdELVtfNmd/1EzWyM//O7K1kiOuw6AcNZaSCLjd6IdkGcB8icPgCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499688; c=relaxed/simple;
	bh=LxgTUKbn8KNhLGRhBso8SsMhr0Dzs7JAPcOk+R2tsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe/FBiWHiSWG70e4IQkSVMtW5yxqd+qHEfLLIhPxAw0fdR3IKECCFWraN+JXIgoFcTNic3m+2L1RZ+eJ3XlyViqS5VIpmqKZpF0woFtsfk8QGp4i9ZUByjwt26lcwp0m/IVolNc9GQhYq9gk2oB3H0PykyEE32l1kx6XyT8gIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSdMqSPl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B71F00893;
	Wed,  3 Jun 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499687;
	bh=6ujqYMqXB0/i41pw2tThC/BzMjS9s70+BOjvuc2SkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSdMqSPl2HS0O3gNNG0z8SDxubJ5Tg2tHpX/XfFz91ONcRw/Hi2k9QmlEDETFKLn6
	 7P/AW43vSdyWfm3gzjvaHuS+PNty6Fd/AMLkVpQsql6FV3JtUfprsubcQndPnS4XUB
	 jhXu2x5LqcBFgcDNlF1Ql5lXrfPpG+l/DWSL5Wlm3+iDU5CKNlrwj1iCgRzGiwGI6Q
	 LtAn5JCi40DF6AD9olXSN051tl2xQ/xwqxNI5QZpx9W/intmYjZaWHHAUWPn/FrKfs
	 /XDAK4js0bTz2NXehDxp/sB3oVpftJ1sV8HhtV2yRkAsxSx22aCMQHOYy8ni88cxTP
	 CLfzdvTmBgWAg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y 1/2] drm/fbdev-helper: Set and clear VGA switcheroo client from fb_info
Date: Wed,  3 Jun 2026 11:14:11 -0400
Message-ID: <20260603111500.item036@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528131817.59900-1-jetlan9@163.com>
References: <20260528131817.59900-1-jetlan9@163.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260121-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.de,redhat.com,163.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:tzimmermann@suse.de,m:javierm@redhat.com,m:jetlan9@163.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ECD7639759

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

