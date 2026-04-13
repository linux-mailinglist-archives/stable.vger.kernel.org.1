Return-Path: <stable+bounces-235896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGmQIMdv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34B3E7418
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58AFB30036D9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681538F929;
	Mon, 13 Apr 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXce61bi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36502382F1A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053636; cv=none; b=t22FVs9j5bc0TcZKMzPL+izw5Wdwdwh53MmV4CTFDUV1XyS40HdiU40YtI0NMUGBJkEYMZLzXyyCbyEwvhEp4RQp1sgRNwogtDJe+JaD7E6CX0UzF0zSwOZH9HNNqnQeCkX0MKiqZXpQazJPqQRO+fr4KPJP0UeLjDjksXr6F2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053636; c=relaxed/simple;
	bh=aEmf+dwQkp8kOkHrYU7e/MjUnaW43/hMWUclj6xwgIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr/sJ10ih0DnvOncQrAjYRJ7uz3FNAeEpO4S0OyhSQMKjyxkV2cSzSFmnZtlrKyjOGS2WLALzYddDZ/aGKMuen294p7/HTemnHb/wbf0zhPyMCxgJP3ZhjuK40dJHm5DFFcogwgFLpEc9FLphhdpIBtj+W/DTQkFqnq3FjCDmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXce61bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F6C116C6;
	Mon, 13 Apr 2026 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053635;
	bh=aEmf+dwQkp8kOkHrYU7e/MjUnaW43/hMWUclj6xwgIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXce61biomK1rudPQDvLt21y8tad1gv62ZCHBSSoVC8lkmCbXD3S+qNyyQ9ovWGnV
	 uP9Bj2beaNKGWAN3hgftqTijd2RlE3MWfK15GTS44e5sRHMu1FZMHiAlGIWZMkgvdY
	 SYG+UYkyskQ8MmBxlDVS51/01OjTIyTy3txRcPIbNyfm2Fgh9OBwbIVziEZbQMc8mm
	 oYSjKFV5JlDlCi+sWOac3SIaG1aiNTX023EMB/ZKBZM/qgS4aUTPhamnR+QDbxCGWo
	 LENtimLb5dg37GU/xvFep5vW3Oqu79KcQmactYVqEmeH6AVZe9yianMzcEHpz/5wyr
	 0GY843drweCiA==
From: Sasha Levin <sashal@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID + followup fix
Date: Mon, 13 Apr 2026 00:13:54 -0400
Message-ID: <20260412120103.uvcvideo-backport@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiDSCukK5wBm+kO9hcYho+j73Ko=17D975bwd8iT_NC4gkEaw@mail.gmail.com>
References: <CANiDSCukK5wBm+kO9hcYho+j73Ko=17D975bwd8iT_NC4gkEaw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235896-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A34B3E7418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> both patches should be backported to all kernel versions

Both 0e2ee70291e6 ("Mark invalid entities with id UVC_INVALID_ENTITY_ID")
and 758dbc756aad ("Use heuristic to find stream entity") have been queued
for 6.1, 5.15, and 5.10. They were already present in 6.6 and newer.
Thanks.

