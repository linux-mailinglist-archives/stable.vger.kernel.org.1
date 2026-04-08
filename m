Return-Path: <stable+bounces-233738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMHjLUip1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:03:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF443B5D37
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B54493043AD8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F312815;
	Wed,  8 Apr 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTgqqAJJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36A32E134
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610140; cv=none; b=tXMirgoj1r40y68MHDhCRcqU0OLir+6qnG5nvUWxeHZZr/irTiG9J+ngj1dnoq0v5oAO8p9QsdHGvJOs+9f7fm53zjAT2gi2M4OQcJjw+NIeG8ETfPJIdUU9OHKpxPo9GendSJ5JIxrQlsrUFET/Hsko1P5BCSDGYnjMdcrbtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610140; c=relaxed/simple;
	bh=/AqQsoVIUXloWjDhaKy37gUllnWuIcMuIAqfkj9Zr2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuhDAcqbOz7M0uuO7poG9DMgKAG9pjIsD+7E3Q1ZM1o5uS5IOSN6tqGq00hzhGIs3+tkxDl70ijfS+UDpRDvlmFhLwOD97xy6ZIRN8IoEWNq9ZAKVG/eDlh2koPGT+L9soQCyTR/PpFDtPNsMNzx8zutR/zBk15xMkNZcpj7qWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTgqqAJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32696C116C6;
	Wed,  8 Apr 2026 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610139;
	bh=/AqQsoVIUXloWjDhaKy37gUllnWuIcMuIAqfkj9Zr2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTgqqAJJLxDt6jTXMTr1TOdDNnJ9wgNt0OSqer5nr1gkDh9kTYsnitdhhvu3cLmNd
	 pAI9F/jZCm2CNtKIAUC4Mq4XKmSp3P2gzK++4d5vY2Lj1lkShcM3V/LXstsaYNVUcc
	 FB855kjBAP/QAPheDAT9z0Mli67216gSdxtYK52UfS6DmQSLrWg7s8/EY3TJ8yXFfX
	 ARIHTOXhNyt5IKzEuZI1783aQJGXv4Hitx/KaXyqrcI4vmZajSmINRFnbso0P3rUrs
	 a4yiaBGfgOWogfOdgR5RGXEUpSpnhaMlRCRj1iHKGhCogQqa4YpEinzIplaE0eTtWC
	 5wzmI+xA0d2hA==
From: Sasha Levin <sashal@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH 6.18.y] ASoC: qcom: sc7280: make use of common helpers
Date: Tue,  7 Apr 2026 21:02:18 -0400
Message-ID: <20260408010218.746314-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-qcom-sdw-6-18-v1-1-2e1b884c14cf@radxa.com>
References: <20260407-qcom-sdw-6-18-v1-1-2e1b884c14cf@radxa.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233738-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CF443B5D37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:32:05PM +0800, Xilin Wu wrote:
> [This is a partial backport containing only the sound/soc/qcom/sdw.c
> changes which add LPASS CDC DMA DAI IDs to qcom_snd_is_sdw_dai().

Queued for 6.18, thanks.

-- Sasha

