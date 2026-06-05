Return-Path: <stable+bounces-260798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e2LtC48mI2rujQEAu9opvQ
	(envelope-from <stable+bounces-260798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8064B03E
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FoogILND;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260798-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260798-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55781305EA59
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB72416CF3;
	Fri,  5 Jun 2026 19:37:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292784071CA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688271; cv=none; b=PZhGod/bP4EZkz4Sn3S2PcvFKvMdIoAd3FJOkY/OO/4cC5hS43oa9z5a6UXgP1rgpic+KkaJU6WVGy58wzc64SWBqFBc+bGPhlpg+faJK7sRMowRDn0bTKoDJBGEvSpUl2DBvjRx+2cGSHPcve5laHxEFuRU4Z7ZEbBInV2uztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688271; c=relaxed/simple;
	bh=FToYJIQ8RdH6JxhRfoWMRJcXrIJD1WNJJYbuN1kj20M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6F4Ep7alDs6GDz/jJ+9NYv1c2hregjLUqMAaXmlibRBrHWK5b90zVqVP/M0sGi3J3YVrDGkJyIKeRFbdJbJbQ7asPj4cd/xYlZVnoNIgp+37dUWI9uCZBT3ieKUh5oaT1xwkg71nBId2rhFFvkFGFHdN/3kflGK9MeKH+ortbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoogILND; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8A01F00899;
	Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688270;
	bh=Cn3wo5zAEi7V+MeTEPkCM0Q/ykaUHIqraUi8VT4q5gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FoogILNDfzfQQxMX4p+8D3Fxch5k2QnAFevGrktL02zH8Jw5K5+00iv40/4PkMueF
	 MVctQPn8onQ7fnkaEPA3Fk5Sh08MY2GGMxmyV/hGWqm0O8jfEAVg+eqPL+QOeGZdy0
	 OszK4gyiK75f+K9pvWcOcywKi/gZxpV4skYnoNwz4pEGTncqjAHiVSlKY1i2FeR6bQ
	 kANQ6ULoMlIlXIeiQSpRrfzZgDr1RbW0BFNMrlPTn+aYzJDKLu8ibOE8H5CAQHBluL
	 jpxBmHAIp5Qcqo+0sKs3NHOI+ImNfqykeCkINSqnhrelFPhczkIewWJUcEA29FT7O1
	 ooGwbtrVQc6rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 5.10.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:24 -0400
Message-ID: <20260605-stable-reply-0017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121918.150487-1-weichengc@nvidia.com>
References: <2026060435-implicate-henna-b77d@gregkh> <20260604121918.150487-1-weichengc@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260798-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:weichengc@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1C8064B03E

> [PATCH 5.10.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha

