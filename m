Return-Path: <stable+bounces-254016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJaOAjPrEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:12:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F35C250F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB39B302E405
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B713955D7;
	Sun, 24 May 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY/vMQwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08633C1B7
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624591; cv=none; b=kQ5myiC87JxC2rMCvjaVCY9iiiV6yeevoP9CDd/GlKQ7/zH2bwAkyc1DQglrc2pG2AohsbnalFcznFWdx04NBB8w9kpiTdyr3Sdsf8kp+Zrk30Y98+UOeiQOkk/MyHVfNwH7zLpk6lnQlSnpTP4rtFKlMZF8mf8eJHGzYSbxEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624591; c=relaxed/simple;
	bh=QbPFEzpP2kPYX4FwQLnQNAqL+IFS0eNiC0HsAxo4v0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2Y+3WqGjD5WqnhkXPRKctk+sD1HnTC/ojehWVSh1niC5IIEX8+Yz7B0/DhIgqtoXXerExQfsCfGFroZul2sFIxPlPT/n8SBgPskBnWLh+HZGCqP0xcByjAEEhd6HeuTFWNY+FSWW39hkH635UmKoGVXyvm8NtLAUNC7bONVVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY/vMQwm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA3C1F000E9;
	Sun, 24 May 2026 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624589;
	bh=TZ9ukQG4joMnjZwYLiZ7bVYPyERULbFTjADzaHQHmJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NY/vMQwmrIJsTcHp2BHs8YDDhwOgw/S+WObhG5uBLvI/cOmxU1sdjwn+WArx1BMAa
	 xbLWUz+93FL9TBYsbIDTpndeaQU8KGd29MTn7anko9IryfKZpGH1ogaaLUK9eKEmeL
	 Uem4ptEXY0cIF+x9Y9zbscHkZ+lv4f9rZKEDp2FR0pojk/R/MEK9ChJV9ZkT+wsVnR
	 B0GqSk91vWha2D4KRqRJGI/5TQzoyDj1y36ZMch+J85tmEMt4muGeDMR32Fgptcu1g
	 GUt1uHaLPXOYEPV79TwjNGy0+SdJGpxo8KmHPIxGS+FG/OzfLAdXvZkEjwkr9a2O1m
	 1LtoyVS/8jRvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	matthew.brost@intel.com,
	matthew.d.roper@intel.com,
	shuicheng.lin@intel.com
Subject: Re: [PATCH 6.18.y] drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()
Date: Sun, 24 May 2026 08:09:46 -0400
Message-ID: <20260524-stable-item008a-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522184742.119776-2-gustavo.sousa@intel.com>
References: <20260522184742.119776-2-gustavo.sousa@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254016-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE6F35C250F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

