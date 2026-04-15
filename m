Return-Path: <stable+bounces-238124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPt8GO2I32kHVAAAu9opvQ
	(envelope-from <stable+bounces-238124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:47:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B26784046D0
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16E0F3005166
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BDB283FC8;
	Wed, 15 Apr 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvHw0jRB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE772512C8
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257256; cv=none; b=AehtZLKfshulnyVE0M1YuK/1TnMVE5GUCqWe+evlRzkkWKp1em5v9h5LucgzptuG3HAxo5dVfU/Z7ehHxRVMZc5Rq/f32XI4W5y+REWsNd7Ha6kKRxms5DFNN14thmU2jOEHR1fPOStvPykHZmyiUIVftipCFbRK7KF66k5c8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257256; c=relaxed/simple;
	bh=6qcPPizjmrH4IxfM4aPYBchp4gTkMIRYwTTrk/cIIC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYyBQDxsDfVLpTbOtfb4Px4wMY/eoAHNFCrpHJzh+OaFQlgVj65cM+Uw2+n5MWKflwX7Cbk62nI5qg++/JrDi2mt7xwf1XlYd9AdNM/OYF2XMa3Qh0kms1lJadPLFBLFeiHJRn/FzPU7PIlJkRrg/Z8x962SyF5eV+lPTfkSWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvHw0jRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82516C19424;
	Wed, 15 Apr 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257256;
	bh=6qcPPizjmrH4IxfM4aPYBchp4gTkMIRYwTTrk/cIIC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvHw0jRBnMQknkXtjVeTZJjQvK5CugQHUzFBx7MXGzsYg4nwE4n12zW0aky+yyj5S
	 9dVwwVSlrCyLvLiqVsFE2zPwmydOl5mUgiuKxPR7PS9zt8ImfQd0eDpHZOBxMC/mkD
	 soqdD8ENH8aOcpAaj0hZ2/x6/jKgtoGCfEMJ0wXgifl5cfzVjTtnCPu9p2gftuV8QK
	 XmfeZo8WEp95EulgWXgEZ0uCEBmL8/edMuE7Qz9fQ5JcnKWUV7X1vIM6dav9dQ+p7w
	 ohLHUdljp0ypDXTyktXg1CijuGwb4NAAcsR3+EBvOgj/3NyUAtExzdluIguJiv9l47
	 +Xs3QOg0xnIAQ==
From: Sasha Levin <sashal@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 5.15 336/570] netfilter: nf_conntrack_expect: skip expectations in other netns via proc
Date: Wed, 15 Apr 2026 08:47:34 -0400
Message-ID: <20260415124100.netfilter-conntrack-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad90kM0wXIrO6aqu@chamomile>
References: <20260413155830.386096114@linuxfoundation.org> <20260413155843.080326747@linuxfoundation.org> <18260c94-4eca-434d-8a54-e556bc2057c9@oracle.com> <ad90kM0wXIrO6aqu@chamomile>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238124-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B26784046D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone
> in expectation") is good to have as a Stable-Dep.

Dropped from the 5.15 and 5.10 queues until 02a3231b6d82 is properly
backported, thanks.

