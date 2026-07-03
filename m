Return-Path: <stable+bounces-271622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JV4TFpc1R2ocUQAAu9opvQ
	(envelope-from <stable+bounces-271622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:07:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF46FE4CF
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:07:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UJVLSJwM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271622-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271622-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AC5D305C5F2
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 04:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A631F992;
	Fri,  3 Jul 2026 04:07:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2927A47F;
	Fri,  3 Jul 2026 04:07:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051644; cv=none; b=O+qug34lb+R6G6oCdFt4Lh2+gVSOloIDIoNIWAGXWzjG5HFEOkIdJ/41QorAOEokjGKD236UMENIu62LGVC3p/OaCmaBuBwPHl1zRgIZOCMS35pkUk8vwQCrptox5fV84jDnexOTAjNwUj2+pKTQC0aQcEGftat9o29xwpfElOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051644; c=relaxed/simple;
	bh=8JFptKc5F1Mtqu5EgsatieyuDF4OD9UTfmykO8s11wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3x7MhCs3F7hTx0WYEekowjvknIO6k2efSzUhv15Gf/VkL3dBgsomDFgj20QXB4Z5dYXwpyQvqPn5LYeCi+La+27lE6ygZD5O8bioMpEqWL+YvU4kE15dBxxo4EHXQpOgYR1ZGWSRXLtiFj5I/FTG05GrApOKSWXcoQrzMiJ56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJVLSJwM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054B61F00A3D;
	Fri,  3 Jul 2026 04:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051633;
	bh=Tq3FGAxT2PbVeWRTb1xowyXXk6WxyiKSyiEU9oJBico=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJVLSJwMwLi0BtqUqqelFCmJ2L1eD4eM1AVRbNVMrvKURAEv7Qjn9Qu4snWGpVZRj
	 lCBo1uxfbiYPuxu6G+hdcKOlDf22ygQ2XFhL5rqOJ7jCxAmKC95W9+yFn2CRT36iTr
	 eALt9s47J0or3qVGNlQaq7cXWzbD48yEtft8YIsOr7ZnskHfr6iNPSsJ+P062NYk7d
	 UqVyFcOKp/rjUrmE0KBJdlU6xpB3Z/ynGKyPX7XL5MJ+Auk/5lIh3ZNVmbhW8PMSU4
	 z7xW2whT4rRm5ve2VxVNKEW4DkCTUdCXmoi0HaDn2KtZWqECRysSTk+dY/9wkk57Rm
	 dpx9BsDB3Sx6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Peter Chen <peter.chen@nxp.com>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	lvc-project@linuxtesting.org,
	stable <stable@kernel.org>,
	Yongchao Wu <yongchao.wu@autochips.com>
Subject: Re: [PATCH 5.10] usb: cdns3: gadget: fix NULL pointer dereference in ep_queue
Date: Fri,  3 Jul 2026 00:07:00 -0400
Message-ID: <stable-reply-usb-cdns3-ep-queue-510-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702102018.48182-1-mdmitrichenko@astralinux.ru>
References: <20260702102018.48182-1-mdmitrichenko@astralinux.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:mdmitrichenko@astralinux.ru,m:peter.chen@nxp.com,m:pawell@cadence.com,m:rogerq@ti.com,m:felipe.balbi@linux.intel.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:peter.chen@kernel.org,m:rogerq@kernel.org,m:lvc-project@linuxtesting.org,m:stable@kernel.org,m:yongchao.wu@autochips.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271622-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6BF46FE4CF

On Thu, Jul 02, 2026 at 01:20:17PM +0300, Mikhail Dmitrichenko wrote:
> From: Yongchao Wu <yongchao.wu@autochips.com>
>
> commit 7f6f127b9bc34bed35f56faf7ecb1561d6b39000 upstream.
>
> When the gadget endpoint is disabled or not yet configured, the ep->desc
> pointer can be NULL. This leads to a NULL pointer dereference when
> __cdns3_gadget_ep_queue() is called, causing a kernel crash.

Queued up for 5.10.y, thanks!

-- 
Thanks,
Sasha

