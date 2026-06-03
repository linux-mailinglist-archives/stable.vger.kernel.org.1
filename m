Return-Path: <stable+bounces-260130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4RKiGJVOIGoC0wAAu9opvQ
	(envelope-from <stable+bounces-260130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:56:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D863977E
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EmWcDaLH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260130-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260130-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423F2333127C
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A43B6BEC;
	Wed,  3 Jun 2026 15:14:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38A3D1709
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499695; cv=none; b=Y6veiJb9cVOA3q7f3WVmnsaDsAs3ZwsD9XHWOu5tWXRDZMjKZdQ4n/GroOugujpfwc8ArkCK6QO5AEQb7qyq/WxmAGkOF9PBhxH+4MN+GRMvM17xtfz5eLyEcjUCEq+S03NwxaTesyD9lCSCZL1+MdjY3JxX4w0ER/1/IvDj9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499695; c=relaxed/simple;
	bh=IQjyFloxEuRb41i5z5ImLBazvqc5OmpdohGRF22zwrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4e/bw1jzWLE4EMqdNh6iFaEWpCTTJ1L7eU5darvYaHVW/yg899Webd8XdVhwJrOYnv3Z7h/47K4ftqhEx6tfOnoZ8HC/EXEjvUFB2MCogzkgZ8vQ32ZHID3570vrlO2+Jxb5FKAq14GTY/nCG5ro9+EsWSxQ16HukDAp6xVyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmWcDaLH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089AE1F00898;
	Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499694;
	bh=8lBTrZuBd7byqbnusUy2MCtApz/gd2Q5Qeb+J0gnGKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmWcDaLHj9sNZPTOydPR9xqVRVCufuqqxBs9wkV33Uv1UXJ4yJcavhDIVD1VHqKr1
	 oPNrB20wAH6Nokpu5EujkbHGYdASz6aZNDdT8ji4epVJ6ZQXgJH7n3SZA1q/W4GGh5
	 rxnAAN+tXNwThIToX3oeUcWxyt45Ki4jbQ2BRnN1W1QB/g8tQ7yQF9Hjc/73mIa0pn
	 aDYOPOqiOqk+NAIZ68hLLHLxERaez18wmOK2PMsptvu+E0ZhXJvrPHEHfbXrSL5DW0
	 dyoSPIY+S+RNgB5WqsniJjLDVPmjoqPhjTbLNGL0Ca3c/3EYmWE7rcCNn4WH0w1fCA
	 r5qG7ziHwglpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.1.y 1/2] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
Date: Wed,  3 Jun 2026 11:14:20 -0400
Message-ID: <20260603111500.item053@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194908.473287-1-sven@narfation.org>
References: <20260529194908.473287-1-sven@narfation.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260130-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 336D863977E

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha

