Return-Path: <stable+bounces-237644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFKnMHNE3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:30:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A43F2BBD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DC1B3014BA5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93835E92D;
	Mon, 13 Apr 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdHe26Us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCA335BA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108657; cv=none; b=WAesTKpA7Q6cUiL5aU0k5baEtYrnTyejDT3p5SxO3gNKnISlE33ySHnE4zMINXAGkYxi5DjOeoNrJWo48ERTz8+56Cvs0JxZDLB8EMcmKkn4KLpetrhgEbj+G2e8J2WTe1oQT1ozwi8riiUA8rhzbAKDPenP2QK0lhO0jX/CbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108657; c=relaxed/simple;
	bh=+lhrtU1vXUHl5ZiLd8SOAVfsEhsREcfP5n1pbUrNTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iem5GJuvPUB0IAGJSfq7/LSeAFQXA2aZ7SLcK3OuGnvgWg52HPS6+yHhgvnbj9CPLr/NPPQZXNMe+SRcDrWRQHH37IyrpX7zhmkQCSAVETmx9aAUNiDv3AnXLw97xVywMmot2Ec/cfjoLFemvIKYcbrshpZT+cTfskkz3OtPIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdHe26Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F51AC2BCAF;
	Mon, 13 Apr 2026 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776108656;
	bh=+lhrtU1vXUHl5ZiLd8SOAVfsEhsREcfP5n1pbUrNTgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdHe26UstZySI5NeuX4f7DQdXx9FXw0HqCfPAaDjMMtZPl/ynQozgWr8M8LzyTeNt
	 v9Vafpd76wMx96Lf5pSAwa8i67z19zPEMhCYl8zw895D8H9hMGP3vmUhA5JqPDNpSs
	 QAq0kw310eEpAiukax2WS//yoUM1JAg7GtJB3GvzIAqnf3F0JC7BzRaXyMso7JbWo3
	 qdHib+1+NfxxaA0k2Tchq02KgzAZznm5/PHDqLbT1EN9J1vnnKBVPMPbkJTXo8iKha
	 TJAuuFseByGFHycPfAU38T9PgCIy0QgLZOcbtXVzCo+HC6uvU/SfFaRC/Pt2a68KKj
	 8I/idKWK7E7tg==
From: Sasha Levin <sashal@kernel.org>
To: "Geoffrey D. Bennett" <g@b4.vu>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 5.15 005/570] ALSA: usb-audio: Remove VALIDATE_RATES quirk for Focusrite devices
Date: Mon, 13 Apr 2026 15:30:36 -0400
Message-ID: <20260413192300.stable-rc-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad0pqOwdPW1s3t4U@m.b4.vu>
References: <20260413155830.386096114@linuxfoundation.org> <20260413155830.596728908@linuxfoundation.org> <ad0pqOwdPW1s3t4U@m.b4.vu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237644-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 640A43F2BBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 14, 2026 at 03:06:40AM +0930, Geoffrey D. Bennett wrote:
> This commit depends on its predecessor 24d2d3c5f940 ("ALSA: usb-audio:
> Improve Focusrite sample rate filtering") which was not picked up for
> stable because it didn't have a Fixes tag.

Dropped from the 5.15 queue along with its dependency:
  - "ALSA: usb-audio: Update for native DSD support quirks"

Thanks.

