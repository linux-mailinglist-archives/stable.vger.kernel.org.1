Return-Path: <stable+bounces-233735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOJ7ATyp1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3FD3B5D28
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75908300BCB2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577C33344A;
	Wed,  8 Apr 2026 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0aWmXth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518031F984
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610134; cv=none; b=q5edBU8wAmW4550W0DwmQzwBBMeLFVoP8Uei0jKPmjpgNvsNvyjQvgLK2T1y/IEWyt1Mwewa4qAMCe9PpfrMegyCRNCW6eA+ie/gWxFdYGaMnPJXz6izpK9m9Zr62bR+uSiwdvFBp5TjioR3Hq9h9zcyvdb+yakMwQ0hExW4nL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610134; c=relaxed/simple;
	bh=2N4R8+BzCrWOogoudaF3qymHQHt9Ps16pQAB7y7SXlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKiphiY91GF2HPObEbDg5s7qsxmKV0mS/C9to2cjmfAFcqL9CpsG9D823Nbl1KIutIyxPBUs0/xTLdhrAe0C+mxq74VZX0PEDUxuSIp5hM8+5ce1pislP/d3P0moebwH1JtfkKT2aU3PjOQNPZA8OYS02Fp0S2O2SoK2DMUm4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0aWmXth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A52BC116C6;
	Wed,  8 Apr 2026 01:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610133;
	bh=2N4R8+BzCrWOogoudaF3qymHQHt9Ps16pQAB7y7SXlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0aWmXthC1P1xJhh9n9jXd6vwGajJdZAXK4diNRdskI6lMvtApjoQk7T9emB7+Tk8
	 XTCVsjBd4BetuAnWyYNRseX8EGtDXyRTTS5uQXm582UrMM6pQsIOEyaMtd5t8sLwX8
	 d9mHJX+E9HUZGb4RTHbEcC3hbxovrSB1s+ckdduz3gp8d2D3dzY2b8UFM1OBrgA8NC
	 NeIJsXM7Lc+FhMzjBVoaSwMZrVXylo3B84GCqxiUslN8I5kSDcYHS0XlKDtAMnuFmZ
	 7pzgNPy20cDWaajU4BajRzQNAvSgBSubN7CsuyvqwdnlS7oGvf77KwzVI9gb622BEi
	 wMXepBOahpxYQ==
From: Sasha Levin <sashal@kernel.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/4] phy: renesas: rcar-gen3-usb2: Fixes for Renesas GEN3 USB2 PHY
Date: Tue,  7 Apr 2026 21:02:12 -0400
Message-ID: <20260408010212.746232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-233735-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3FD3B5D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:37:38PM +0300, Claudiu wrote:
> Series backports fixes to the Renesas RCAR GEN3 USB2 PHY driver. Fixes
> are already backported to the other stable trees.

Queued for 5.10 and 5.15, thanks.

-- Sasha

