Return-Path: <stable+bounces-260111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 77cKET5KIGpU0QAAu9opvQ
	(envelope-from <stable+bounces-260111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:37:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BAB63945D
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CyV2MDWS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260111-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260111-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EA26328541B
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF273D4132;
	Wed,  3 Jun 2026 15:14:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3173D3324
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499677; cv=none; b=iony6rW1Xgdqa2qLV85goePhV3MgrhIgRMVRcGR+1627S8nM+a9JuSKT10rSWzgRwR1joc+f8DBDvs6E/je8ko1Km09FOg914PcuVPQ6dmRKgkG9TxBnoYUlhJhFPgDO2/BBV0bDBZOIcHIeMKSNEjvD0UE4QD/uffP5YOTpw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499677; c=relaxed/simple;
	bh=sSg1Bp2Q7gxa9Rm/Bu/ydi2z7TgHKY4GL1qs4g3TuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2GU9U7XK8AQWWxgrk43A2SBi/Cf1wkUf/xLI4GwzkFh+TwQ2Z9+HRiQt+c8MElQyBzd0WqTQ8fMTXnsmYBjeKuU9U7pAJN63fnXA2g59jer3nkBPZQ1PPYPlnOEWYP4293sz2zgEDdiY6A4ZS48bop96AYYzuyAOM8hGmWcQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyV2MDWS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835201F00899;
	Wed,  3 Jun 2026 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499676;
	bh=pX7WEF6IeTgp1VCOrtgpExlDWue20UoEpxE6XPci39M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyV2MDWSCTG8RkuNHzfmhLLIdF4Avr+kIrAi4N0ukTCDptgN3S8pRi6dIQ3g8ibnS
	 72ZMqTXhS/MqfmBOzyyYeZ4df43fu8MtE013TDOWiAS56WlupCcDrrushLx1ItP/FG
	 beZzFh61eZpE49SYumsIF0xZ3wRtgPowzl6ylvP+UJCWojajrYgEmA1A/PpsTjRd98
	 qArFY6Rlk5gJAifrLRyUE31Nx1OEAqH/B2cyKJayvQQ+NF9njRyQsdv35S0lGoERUZ
	 Nfi6d7UKyefGAOCcAn5nIT1jNT4AFsy6+eiB/JK3urIwY3fFg/QFasjZWqNm1xIeIl
	 HMp1/Vq4bte0Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	stable@vger.kernel.org,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 5.10 1/2] Revert "RDMA/rxe: Fix double free in rxe_srq_from_init"
Date: Wed,  3 Jun 2026 11:14:01 -0400
Message-ID: <20260603111500.item005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahghwxSf9me8PHM4@decadent.org.uk>
References: <ahghwxSf9me8PHM4@decadent.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,vger.kernel.org,debian.org];
	TAGGED_FROM(0.00)[bounces-260111-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:jiashengjiangcool@gmail.com,m:yanjun.Zhu@linux.dev,m:leon@kernel.org,m:stable@vger.kernel.org,m:benh@debian.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5BAB63945D

Queued for 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

